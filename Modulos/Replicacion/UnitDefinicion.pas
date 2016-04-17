unit UnitDefinicion;

interface

uses
  IniFiles, SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QComCtrls, QDBCtrls, QExtCtrls, QButtons, DBXpress, FMTBcd,
  DB, SqlExpr, Provider, DBClient, DBLocal, DBLocalS;

type
  TfrmDefiniciones = class(TForm)
    PageControl: TPageControl;
    TabDefinicion: TTabSheet;
    TabProcesos: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    dblcbSource: TDBLookupComboBox;
    btnConectarSource: TBitBtn;
    Panel2: TPanel;
    Label2: TLabel;
    dblcbTarget: TDBLookupComboBox;
    Panel3: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    lbReg: TListBox;
    SQLConn1: TSQLConnection;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    SQLConn2: TSQLConnection;
    Panel4: TPanel;
    lbCampos: TListBox;
    Label5: TLabel;
    lbLlave: TListBox;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Panel5: TPanel;
    btnCerrar: TBitBtn;
    Panel6: TPanel;
    btnAplicar: TBitBtn;
    btnModificar: TBitBtn;
    btnEliminar: TBitBtn;
    SQLQuery1: TSQLClientDataSet;
    SQLQuery2: TSQLClientDataSet;
    SQLQuery: TSQLQuery;
    SQLQuery3: TSQLQuery;
    lbDisp: TComboBox;
    btnRegistrar: TBitBtn;
    SQLTablas: TSQLQuery;
    procedure btnCerrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConectarSourceClick(Sender: TObject);
    procedure lbDispChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btnAplicarClick(Sender: TObject);
    procedure btnRegistrarClick(Sender: TObject);
  private
    procedure Inicializar;
    procedure InitSrcFields( TableName: string );
    procedure InitDstFields( TableName: string );
    procedure CargarDatos(IdRelacion:Integer;IDT1:TTransactionDesc);
    { Private declarations }
  public
    ReplTable : string[32];
    ReplFields : TStrings;
    ReplPath, ReplServer, ReplUser, ReplPWord : string;
    { Public declarations }
  end;

var
  frmDefiniciones: TfrmDefiniciones;
  IDT:TTransactionDesc;
  Conectado:Boolean;

  TableList : TStringList;
  FieldList : TStringList;
  KeyList   : TStringList;
  

implementation

{$R *.xfm}

procedure TfrmDefiniciones.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDefiniciones.FormCreate(Sender: TObject);
var
  MiIni:TIniFile;
  EdDBMgr,EdUsuario,EdContrasena:string;
begin
      MiIni := TIniFile.Create(ExtractFilepath(Application.ExeName)+'/Repl.ini');
      EdDBMgr := MiIni.ReadString('MANAGER','Ruta','');
      EdUsuario := MiIni.ReadString('MANAGER','Usuario','');
      EdContrasena := MiIni.ReadString('MANAGER','Contrasena','');

      TableList := TStringList.Create;
      FieldList := TStringList.Create;
      KeyList   := TStringList.Create;

      with SQLConn1 do
      begin
        Params.Clear;
        Params.Values['Database'] := EdDBMgr;
        Params.Values['User_name'] := EdUsuario;
        Params.Values['Password'] := EdContrasena;
        SQLConn1.Open;
        if not Connected then
        begin
          ShowMessage('Error al abrir DB de Configuración');
          Exit;
        end
        else
          Inicializar;
      end;
end;

procedure TfrmDefiniciones.Inicializar;
begin
          IDT.TransactionID := 8;
          SQLConn1.StartTransaction(IDT);
          SQLQuery1.Close;
          SQLQuery1.Open;
          SQLQuery2.Close;
          SQLQuery2.Open;
          Panel4.Enabled := False;

end;

procedure TfrmDefiniciones.btnConectarSourceClick(Sender: TObject);
var IDT1:TTransactionDesc;
begin
        if Conectado then
        begin
          SQLConn1.Commit(IDT);
          SQLConn1.Close;
          btnConectarSource.Caption := '&Conectar';
          Exit;
        end;

        if dblcbSource.KeyValue < 1 then
        begin
          MessageDlg('Debe Seleccionar una Base de Datos Origen',mtInformation,[mbCancel],0);
          Exit;
        end;

        with SQLQuery do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select * from SOURCES where IDSOURCE = :ID');
          ParamByName('ID').AsInteger := dblcbSource.KeyValue;
          try
            Open;
          except
            raise;
          end;
        end;


        with SQLConn2 do begin
          Params.Clear;
          Params.Values['Database'] := SQLQuery.FieldByName('SOURCE_PATH').AsString;
          Params.Values['User_name'] := SQLQuery.FieldByName('USERNAME').AsString;
          Params.Values['Password'] := SQLQuery.FieldByName('PASSWD').AsString;
          SQLQuery.Close;
          try
            Connected := True;
            btnConectarSource.Caption := '&Desconectar';
            dblcbSource.Enabled := False;
          except
//           on E1: EDBEngineError do begin
            ShowMessage('Error Conectando a la Base de Datos Origen: ' + SQLQuery.FieldByName('SOURCE_PATH').AsString);
//            DispErrorMsg(E1);
           end;

         if not Connected then
          begin
            MessageDlg('Error Conectando a la Base de Datos Origen',mtError,[mbCancel],0);
            Exit;
          end;

          TableList.Clear;

          IDT1.TransactionID := 5;
          IDT1.IsolationLevel := xilREADCOMMITTED;

          StartTransaction(IDT1);

          SQLQuery3.SQL.Clear;
          SQLQuery3.SQL.Add('Select RDB$RELATION_NAME FROM');
          SQLQuery3.SQL.Add('RDB$RELATIONS WHERE');
          SQLQuery3.SQL.Add('RDB$SYSTEM_FLAG <> 1');
          SQLQuery3.SQL.Add('AND RDB$VIEW_BLR IS NULL');
          SQLQuery3.SQL.Add('AND RDB$RELATION_NAME <> ''CHANGES''');
          SQLQuery3.SQL.Add('AND RDB$RELATION_NAME <> ''REPL_TABLES''');
          SQLQuery3.SQL.Add('ORDER BY RDB$RELATION_NAME');
          SQLQuery3.Open;

          while not SQLQuery3.EOF do begin
            TableList.Add(Trim(SQLQuery3.Fields[0].AsString));
            SQLQuery3.Next;
          end;
          SQLQuery3.Close;

          SQLConn2.Commit(IDT1);
          
          lbDisp.Items := TableList;
          lbDisp.Sorted := True;

        end;
end;

procedure TfrmDefiniciones.lbDispChange(Sender: TObject);
var
  Index:Integer;
begin
        lbCampos.Clear;
        lbLlave.Clear;
        Index := lbDisp.ItemIndex;
        ReplTable := lbDisp.Items.Strings[ Index ];
        InitDstFields( ReplTable );
        InitSrcFields( ReplTable );

end;

procedure TfrmDefiniciones.InitSrcFields( TableName: string );
var
  i: Integer;
  IDT2:TTransactionDesc;
begin
  FieldList.Clear;
  IDT2.TransactionID := 6;
  IDT2.IsolationLevel := xilREADCOMMITTED;
  SQLConn2.StartTransaction(IDT2);

  with SQLQuery3 do begin
    Close;
    SQL.Clear;
    SQL.Add('Select RF.RDB$FIELD_NAME FROM');
    SQL.Add('RDB$RELATION_FIELDS RF LEFT JOIN RDB$FIELDS F');
    SQL.Add('ON RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME WHERE');
    SQL.Add('RDB$RELATION_NAME = :TABLENAME');
//    SQL.Add('AND F.RDB$COMPUTED_BLR IS NULL');
//    SQL.Add('AND F.RDB$DIMENSIONS IS NULL');

    for i := 0 to lbLlave.Items.Count - 1 do begin
      SQL.Add('AND RF.RDB$FIELD_NAME <> '''+lbLlave.Items[i]+'''');
    end;

    SQL.Add('ORDER BY RDB$RELATION_FIELDS.RDB$FIELD_POSITION ASC');

    ParamByName('TABLENAME').AsString := TableName;
    Open;
  end;
  while not SQLQuery3.EOF do begin
    FieldList.Add(Trim(SQLQuery3.Fields[0].AsString));
    SQLQuery3.Next;
  end;
  SQLQuery3.Close;
  SQLConn2.Commit(IDT2);

  lbCampos.Clear;
  lbCampos.Items := FieldList;
  Lbcampos.Sorted := False;
end;

procedure TfrmDefiniciones.InitDstFields( TableName: string );
var
  i: Integer;
  IDT2:TTransactionDesc;
  IndexName:string;
begin
  KeyList.Clear;
  IDT2.TransactionID := 6;
  IDT2.IsolationLevel := xilREADCOMMITTED;
  SQLConn2.StartTransaction(IDT2);

  with SQLQuery3 do begin
    Close;
    SQL.Clear;
    SQL.Add('Select RF.RDB$CONSTRAINT_NAME FROM');
    SQL.Add('RDB$RELATION_CONSTRAINTS RF');
    SQL.Add('WHERE');
    SQL.Add('RDB$RELATION_NAME = :TABLENAME and RDB$CONSTRAINT_TYPE = "PRIMARY KEY"');
    ParamByName('TABLENAME').AsString := TableName;
    Open;
    IndexName :='';
    while not Eof do
    begin
       IndexName := FieldByName('RDB$CONSTRAINT_NAME').AsString;
       Next;
    end;
    Close;
  end;

 if IndexName <> '' then
  with SQLQuery3 do begin
    Close;
    SQL.Clear;
    SQL.Add('Select RF.RDB$FIELD_NAME FROM');
    SQL.Add('RDB$INDEX_SEGMENTS RF');
    SQL.Add('WHERE');
    SQL.Add('RDB$INDEX_NAME = :INDEXNAME');
    SQL.Add('Order by RDB$FIELD_POSITION ASC');
    ParamByName('INDEXNAME').AsString := IndexName;
    Open;
    while not EOF do begin
     KeyList.Add(Trim(Fields[0].AsString));
     Next;
    end;
  end;

  SQLQuery3.Close;
  SQLConn2.Commit(IDT2);

  lbLlave.Clear;
  lbLlave.Items := KeyList;
  lbLlave.Sorted := False;
end;

procedure TfrmDefiniciones.Button1Click(Sender: TObject);
var
  i:Integer;
begin
      for i := lbCampos.Items.Count - 1  downto 0 do
      begin
          if lbCampos.Selected[i] then
          begin
             lbLlave.Items.AddObject(lbCampos.Items[i],lbCampos.Items.Objects[i]);
//             lbLlave.Items.Add(lbCampos.Items[i]);
             lbCampos.Selected[i] := False;
             lbCampos.Items.Delete(i);
          end;
      end;
end;

procedure TfrmDefiniciones.Button2Click(Sender: TObject);
var
  i:Integer;
begin
      for i := lbCampos.Items.Count - 1 downto 0  do
      begin
         lbLlave.Items.AddObject(lbCampos.Items[i],lbCampos.Items.Objects[i]);
         lbCampos.Items.Delete(i);
      end;

end;

procedure TfrmDefiniciones.Button3Click(Sender: TObject);
var
  i:Integer;
begin
      for i := lbLlave.Items.Count - 1  downto 0 do
      begin
          if lbLlave.Selected[i] then begin
             lbCampos.Items.AddObject(lbLlave.Items[i],lbLlave.Items.Objects[i]);
             lbLlave.Selected[i] := False;
             lbLlave.Items.Delete(i);
          end;
      end;

end;

procedure TfrmDefiniciones.Button4Click(Sender: TObject);
var
  i:Integer;
begin
      for i := lbLlave.Items.Count - 1 downto 0  do
      begin
         lbCampos.Items.AddObject(lbLlave.Items[i],lbLlave.Items.Objects[i]);
         lbLlave.Items.Delete(i);
      end;
end;

procedure TfrmDefiniciones.btnAplicarClick(Sender: TObject);
var
  IDT1:TTransactionDesc;
  IdRelacion:Integer;
  IdReplica:Integer;
  NomTabla:string;
  PkTabla:string;
  i:Integer;
begin

        Application.ProcessMessages;

        IDT1.TransactionID := 1;
        IDT1.IsolationLevel := xilREADCOMMITTED;

        SQLConn1.StartTransaction(IDT1);

        with SQLQuery do
        begin
           Close;
           SQL.Clear;
           SQL.Add('select * from RELACIONES where IDSOURCE = :IDSOURCE and IDTARGET = :IDTARGET');
           ParamByName('IDSOURCE').AsInteger := dblcbSource.KeyValue;
           ParamByName('IDTARGET').AsInteger := dblcbTarget.KeyValue;
           try
            Open;
            IdRelacion := FieldByName('IDRELACION').AsInteger;
            SQLConn1.Commit(IDT1);
           except
            SQLConn1.Rollback(IDT1);
            raise;
           end;
        end;

        NomTabla := lbDisp.Text;

        for i := 0 to lbLlave.Items.Count - 1 do
        begin
          PkTabla := PkTabla + lbLlave.Items[i];
          if i < (lbLlave.Items.Count - 1) then
            PkTabla := PkTabla + chr(9);
        end;


        SQLConn1.StartTransaction(IDT1);

        with SQLQuery do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into TABLARELACIONES(IDRELACION,NOMTABLA,PKTABLA) values (');
          SQL.Add(':IDRELACION,:NOMTABLA,:PKTABLA)');
          ParamByName('IDRELACION').AsInteger := IdRelacion;
          ParamByName('NOMTABLA').AsString :=  NomTabla;
          ParamByName('PKTABLA').AsString := PkTabla;
          try
            ExecSQL;
            SQLConn1.Commit(IDT1);
          except
            SQLConn1.Rollback(IDT1);
            raise;
          end;

          SQLConn1.StartTransaction(IDT1);

          Close;
          SQL.Clear;
          SQL.Add('select IDREPLICA from TABLARELACIONES where IDRELACION = :IDRELACION and NOMTABLA = :NOMTABLA');
          ParamByName('IDRELACION').AsInteger := IdRelacion;
          ParamByName('NOMTABLA').AsString := NomTabla;
          try
           Open;
           IdReplica := FieldByName('IDREPLICA').AsInteger;
          except
            SQLConn1.Rollback(IDT1);
            raise;
          end;

          Close;
          SQL.Clear;
          SQL.Add('insert into CAMPOSTABLA(IDREPLICA,NOMCAMPO) values (');
          SQL.Add(':IDREPLICA,:NOMCAMPO)');
          ParamByName('IDREPLICA').AsInteger := IdReplica;

          for i := 0 to lbLlave.Items.Count - 1 do
          begin
              ParamByName('NOMCAMPO').AsString := lbLlave.Items[i];
              try
                ExecSQL;
              except
                SQLConn1.Rollback(IDT1);
                raise;
              end;
          end;

          for i := 0 to lbCampos.Items.Count - 1 do
          begin
              ParamByName('NOMCAMPO').AsString := lbCampos.Items[i];
              try
                ExecSQL;
              except
                SQLConn1.Rollback(IDT1);
                raise;
              end;
          end;

          SQLConn1.Commit(IDT1);
        end;

        lbDisp.Items.Delete(lbDisp.ItemIndex);
        lbReg.Items.Add(lbDisp.Text);
        lbDisp.Text := '';
        lbCampos.Clear;
        lbLlave.Clear;

end;

procedure TfrmDefiniciones.btnRegistrarClick(Sender: TObject);
var
  Existe: Boolean;
  IDT1:TTransactionDesc;
begin
        btnRegistrar.Enabled := False;
        dblcbTarget.Enabled := False;

        IDT1.TransactionID := 1;
        IDT1.IsolationLevel := xilREADCOMMITTED;

        SQLConn1.StartTransaction(IDT1);
        
        with SQLQuery do
        begin
// Mirar si ya existe la relación y cargar la información existente
           Existe := False;
           Close;
           SQL.Clear;
           SQL.Add('select * from RELACIONES where IDSOURCE = :IDSOURCE and IDTARGET = :IDTARGET');
           ParamByName('IDSOURCE').AsInteger := dblcbSource.KeyValue;
           ParamByName('IDTARGET').AsInteger := dblcbTarget.KeyValue;
           try
             Open;
             while not Eof do
             begin
                Existe := True;
                Next;
             end;
             First;
             if Existe then
             begin
               CargarDatos(FieldByName('IDRELACION').AsInteger,IDT1);
               SQLConn1.Commit(IDT1);
               Panel4.Enabled := True;
               Application.ProcessMessages;
               Exit;
             end;
           except
             MessageDlg('Error al consultar relaciones',mtError,[mbCancel],0);
             SQLConn1.Rollback(IDT1);
             Exit;
           end;
// Registrar la relación
           Close;
           SQL.Clear;
           SQL.Add('insert into RELACIONES (IDSOURCE,IDTARGET) values (:IDSOURCE,:IDTARGET)');
           ParamByName('IDSOURCE').AsInteger := dblcbSource.KeyValue;
           ParamByName('IDTARGET').AsInteger := dblcbTarget.KeyValue;
           try
            ExecSQL;
            SQLConn1.Commit(IDT1);
           except
            MessageDlg('Es posible que la relación ya este registrada',mtinformation,[mbOk],0);
            SQLConn1.Rollback(IDT1);
           end;
        end;

        Panel4.Enabled := True;
        Application.ProcessMessages;
end;

procedure TfrmDefiniciones.CargarDatos(IdRelacion:Integer;IDT1:TTransactionDesc);
begin
      with SQLTablas do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select NOMTABLA from TABLARELACIONES where IDRELACION = :IDRELACION');
        ParamByName('IDRELACION').AsInteger := IdRelacion;
        try
         Open;
         while not Eof do
         begin
            lbReg.Items.Add(FieldByName('NOMTABLA').AsString);
            Next;
         end;
        except
         SQLConn1.Rollback(IDT1);
        end;
      end;

end;

end.
