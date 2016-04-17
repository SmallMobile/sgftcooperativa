unit UnitAplicarDefinicion;

interface

uses
  IniFiles, SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, DBXpress, DB, SqlExpr, QDBCtrls, QButtons, QExtCtrls,
  Provider, DBClient, DBLocal, DBLocalS, FMTBcd, IBCustomDataSet, IBQuery,
  IBDatabase;

type
  TfrmAplicarDefinicion = class(TForm)
    lbrelaciones: TDBLookupListBox;
    Label1: TLabel;
    SQLConnMgr: TSQLConnection;
    SQLConnSrc: TSQLConnection;
    Panel1: TPanel;
    btnCrear: TBitBtn;
    DataSource1: TDataSource;
    SQLQuery1: TSQLClientDataSet;
    btnCerrar: TBitBtn;
    SQLQReplicas: TSQLQuery;
    SQLQProcesos: TSQLQuery;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    btnRemover: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure lbrelacionesClick(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnCrearClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
  private
    procedure Inicializar;
    procedure AgregarTrigger(IdRelacion,IdSource,IdTarget,IdReplica:Integer;Tabla,Llave,Op: string);
    procedure RemoverTrigger(IdRelacion,IdSource,IdTarget,IdReplica:Integer;Tabla,Llave,Op: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAplicarDefinicion: TfrmAplicarDefinicion;
  IDT:TTransactionDesc;


implementation

{$R *.xfm}

procedure TfrmAplicarDefinicion.FormCreate(Sender: TObject);
var
  MiIni:TIniFile;
  EdDBMgr,EdUsuario,EdContrasena:string;
begin
      MiIni := TIniFile.Create(ExtractFilepath(Application.ExeName)+'/Repl.ini');
      EdDBMgr := MiIni.ReadString('MANAGER','Ruta','');
      EdUsuario := MiIni.ReadString('MANAGER','Usuario','');
      EdContrasena := MiIni.ReadString('MANAGER','Contrasena','');

      with SQLConnMgr do
      begin
        Params.Clear;
        Params.Values['Database'] := EdDBMgr;
        Params.Values['User_name'] := EdUsuario;
        Params.Values['Password'] := EdContrasena;
        SQLConnMgr.Open;
        if not Connected then
        begin
          ShowMessage('Error al abrir DB de Configuración');
          Exit;
        end
        else
          Inicializar;
      end;
end;

procedure TfrmAplicarDefinicion.Inicializar;
begin

      IDT.TransactionID := 1;
      IDT.IsolationLevel := xilREADCOMMITTED;
      SQLConnMgr.StartTransaction(IDT);

      with SQLQuery1 do
      begin
        Close;
        CommandText := 'SELECT ' +
                       '   RELACIONES.IDRELACION, '+
                       '   RELACIONES.IDSOURCE, ' +
                       '   RELACIONES.IDTARGET, ' +
                       '   SOURCES.SOURCE_PATH, ' +
                       '   SOURCES.USERNAME, ' +
                       '   SOURCES.PASSWD, ' +
                       '   SOURCES.SOURCE_PATH || ''->'' || TARGETS.TARGET_PATH AS RELACION ' +
                       'FROM ' +
                       '   RELACIONES ' +
                       'INNER JOIN SOURCES ON (RELACIONES.IDSOURCE = SOURCES.IDSOURCE) ' +
                       'INNER JOIN TARGETS ON (RELACIONES.IDTARGET = TARGETS.IDTARGET) ';
        try
         Open;
        except
         SQLConnMgr.Rollback(IDT);
         raise;
        end;
      end;


end;

procedure TfrmAplicarDefinicion.lbrelacionesClick(Sender: TObject);
begin
        if SQLQuery1.FieldByName('IDRELACION').AsInteger > 0 then
        begin
          btnCrear.Enabled := True;
          btnRemover.Enabled := True;
        end
        else
        begin
          btnCrear.Enabled := False;
          btnRemover.Enabled := False;
        end;
end;

procedure TfrmAplicarDefinicion.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAplicarDefinicion.btnCrearClick(Sender: TObject);
var
    IdRelacion:Integer;
    IdSource:Integer;
    IdTarget:Integer;
    IdReplica:Integer;
    Tabla:string;
    Llave:string;
begin

    if MessageDlg('Seguro de Crear los objetos para esta Relación?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    begin
       ShowMessage('No se realizó ningún cambio');
       Exit;
    end;


// Abrir conexión a la base origen
    IBDatabase1.DatabaseName := SQLQuery1.FieldByName('SOURCE_PATH').AsString;
//    IBDatabase1.Params.Values['Database'] := SQLQuery1.FieldByName('SOURCE_PATH').AsString;
    IBDatabase1.Params.Values['User_name'] := SQLQuery1.FieldByName('USERNAME').AsString;
    IBDatabase1.Params.Values['Password'] := SQLQuery1.FieldByName('PASSWD').AsString;
    try
     IBDatabase1.Connected := True;
    except
     raise;
    end;
{
    SQLConnSrc.Params.Clear;
    SQLConnSrc.Params.Values['Database'] := SQLQuery1.FieldByName('SOURCE_PATH').AsString;
    SQLConnSrc.Params.Values['User_name'] := SQLQuery1.FieldByName('USERNAME').AsString;
    SQLConnSrc.Params.Values['Password'] := SQLQuery1.FieldByName('PASSWD').AsString;
    try
      SQLConnSrc.Connected := True;
    except
      raise;
    end;
}
    IdRelacion := SQLQuery1.FieldByName('IDRELACION').AsInteger;
    IdSource   := SQLQuery1.FieldByName('IDSOURCE').AsInteger;
    IdTarget   := SQLQuery1.FieldByName('IDTARGET').AsInteger;

// Tomar Datos

   with SQLQReplicas do
   begin
        Close;
        SQL.Clear;
        SQL.Add('select * from TABLARELACIONES WHERE IDRELACION = :IDRELACION');
        ParamByName('IDRELACION').AsInteger := SQLQuery1.FieldByName('IDRELACION').AsInteger;
        try
         Open;
        except
         SQLConnMgr.Rollback(IDT);
         raise;
        end;

// Lectura de tablas a replicar
        while not Eof do
        begin

          IdReplica := FieldByName('IDREPLICA').AsInteger;
          Tabla     := FieldByName('NOMTABLA').AsString;
          Llave     := FieldByName('PKTABLA').AsString;

          AgregarTrigger(IdRelacion,IdSource,IdTarget,IdReplica,Tabla,Llave,'I');
          AgregarTrigger(IdRelacion,IdSource,IdTarget,IdReplica,Tabla,Llave,'U');
          AgregarTrigger(IdRelacion,IdSource,IdTarget,IdReplica,Tabla,Llave,'D');

          Next;
        end;

   end;

   MessageDlg('Objetos Creados con Exito',mtinformation,[mbOk],0);

end;

procedure TfrmAplicarDefinicion.AgregarTrigger(IdRelacion,IdSource,IdTarget,IdReplica:Integer;Tabla,Llave,Op: string);
var
  IDT1:TTransactionDesc;
  OutTrig :TStringList;
  CamposK :TStringList;
  i:Integer;
  Lin:string;
  Nombre:string;
begin

  OutTrig := TStringList.Create;
  OutTrig.Clear;

  CamposK := TStringList.Create;
  CamposK.Clear;
  if Pos(#32,Llave) > 0 then
     CamposK.Text := StringReplace(Llave,#32,#13,[rfReplaceall])
  else
     CamposK.Text := StringReplace(Llave,#9,#13,[rfReplaceall]);

// Caso trigger Insert
  if Op = 'I' then begin
    Nombre := 'REPL$'+IntToStr(IdRelacion)+'_'+IntToStr(IdReplica)+'_I';
    OutTrig.Add('CREATE TRIGGER REPL$'+IntToStr(IdRelacion)+'_'+IntToStr(IdReplica)+'_I FOR '+AnsiQuotedStr(Tabla,'"')+' ACTIVE');
    OutTrig.Add('AFTER INSERT POSITION 32760');
    OutTrig.Add('AS');
    OutTrig.Add('BEGIN');
    OutTrig.Add('IF (USER <> ''REPL'') THEN ');
    OutTrig.Add(' BEGIN');
    OutTrig.Add('  INSERT INTO REPL_CAMBIOS(IDRELACION,IDSOURCE,IDTARGET,IDREPLICA,OPERACION,LLAVENUEVA)');
    OutTrig.Add('  VALUES ('+IntToStr(IdRelacion)+','+IntToStr(IdSource)+','+IntToStr(IdTarget)+','+IntToStr(IdReplica)+','+QuotedStr('I')+',');

    Lin := '';

    for i := 0 to CamposK.Count - 1 do
    begin
         Lin := Lin + 'NEW.'+CamposK.Strings[i];
         if i <> (CamposK.Count - 1) then Lin := Lin + '||' + QuotedStr(#9)+'||';
    end;
    Lin := Lin + ');END';
    OutTrig.Add(Lin);
    OutTrig.Add('END');
  end;


  if Op = 'D' then begin
    Nombre := 'REPL$'+IntToStr(IdRelacion)+'_'+IntToStr(IdReplica)+'_D';
    OutTrig.Add('CREATE TRIGGER REPL$'+IntToStr(IdRelacion)+'_'+IntToStr(IdReplica)+'_D FOR '+#34+Trim(Tabla)+#34+' ACTIVE');
    OutTrig.Add('AFTER DELETE POSITION 32760');
    OutTrig.Add('AS');
    OutTrig.Add('BEGIN');
    OutTrig.Add(' IF (USER <> ''REPL'') THEN ');
    OutTrig.Add(' BEGIN');
    OutTrig.Add('  INSERT INTO REPL_CAMBIOS(IDRELACION,IDSOURCE,IDTARGET,IDREPLICA,OPERACION,LLAVEANT)');
    OutTrig.Add('  VALUES ('+IntToStr(IdRelacion)+','+IntToStr(IdSource)+','+IntToStr(IdTarget)+','+IntToStr(IdReplica)+','+QuotedStr('D')+',');

    Lin := '';

    for i := 0 to CamposK.Count - 1 do
    begin
         Lin := Lin + 'OLD.'+CamposK.Strings[i];
         if i <> (CamposK.Count - 1) then Lin := Lin + '||' + QuotedStr(#9)+'||';
    end;
    lin := lin + ');END';
    OutTrig.Add(Lin);
    OutTrig.Add('END');
  end;


  if Op = 'U' then begin
    Nombre := 'REPL$'+IntToStr(IdRelacion)+'_'+IntToStr(IdReplica)+'_U';  
    OutTrig.Add('CREATE TRIGGER REPL$'+IntToStr(IdRelacion)+'_'+IntToStr(IdReplica)+'_U FOR '+#34+Trim(Tabla)+#34+' ACTIVE');
    OutTrig.Add('AFTER UPDATE POSITION 32760');
    OutTrig.Add('AS');
    OutTrig.Add('BEGIN');
    OutTrig.Add(' IF (USER <> ''REPL'') THEN ');
    OutTrig.Add(' BEGIN');
    OutTrig.Add('  INSERT INTO REPL_CAMBIOS(IDRELACION,IDSOURCE,IDTARGET,IDREPLICA,OPERACION,LLAVEANT,LLAVENUEVA)');
    OutTrig.Add('  VALUES ('+IntToStr(IdRelacion)+','+IntToStr(IdSource)+','+IntToStr(IdTarget)+','+IntToStr(IdReplica)+','+QuotedStr('U')+',');

    Lin := '';

    for i := 0 to CamposK.Count - 1 do
    begin
         Lin := Lin + 'OLD.'+CamposK.Strings[i];
         if i <> (CamposK.Count - 1) then Lin := Lin + '||' + QuotedStr(#9)+'||';
    end;
    Lin := Lin + ',';
    for i := 0 to CamposK.Count - 1 do
    begin
         Lin := Lin + 'NEW.'+CamposK.Strings[i];
         if i <> (CamposK.Count - 1) then Lin := Lin + '||' + QuotedStr(#9)+'||';
    end;
    Lin := Lin + ');END';
    OutTrig.Add(Lin);
    OutTrig.Add('END');
  end;

  IBTransaction1.StartTransaction;

  with IBQuery1 do begin
    Close;
    SQL.Clear;
    SQL.Add('select * from RDB$TRIGGERS where RDB$TRIGGER_NAME = :NOMBRE');
    ParamByName('NOMBRE').AsString := Nombre;
    try
     Open;
     if RecordCount > 0 then
     begin
        Close;
        SQL.Clear;
        SQL.Add('DROP TRIGGER '+Nombre);
        try
         ExecSQL;
         Transaction.Commit;
        except
         Transaction.Rollback;
         raise;
        end;
     end
     else
       Transaction.Commit;
    except
      Transaction.Rollback;
      raise;
    end;

    Transaction.StartTransaction;

    Close;
    SQL.Clear;
    SQL.Text := OutTrig.Text;
    try
//      SQL.SaveToFile('C:\SQL.SQL');
      ExecSQL;
      Transaction.Commit;
    except
      Transaction.Rollback;
      raise;
    end;
  end;

{
  IDT1.TransactionID := 21;
  IDT1.IsolationLevel := xilREADCOMMITTED;

  SQLConnSrc.StartTransaction(IDT1);

  with SQLQProcesos do begin
   Close;
   SQL.Clear;
   for i := 0 to OutTrig.Count - 1 do
     SQL.Add(OutTrig.Strings[i]);
   try
    SQL.SaveToFile('C:\SQL.SQL');
    ExecSQL(True);
    SQLConnSrc.Commit(IDT1);
   except
    on E:EDatabaseError   do
    begin
      SQLConnSrc.Rollback(IDT1);
      ShowMessage(E.Message);
    end;
   end;
  end;
}
end;

procedure TfrmAplicarDefinicion.btnRemoverClick(Sender: TObject);
var
    IdRelacion:Integer;
    IdSource:Integer;
    IdTarget:Integer;
    IdReplica:Integer;
    Tabla:string;
    Llave:string;
begin

    if MessageDlg('Seguro de Remover los objetos para esta Relación?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    begin
       ShowMessage('No se realizó ningún cambio');
       Exit;
    end;


// Abrir conexión a la base origen
    IBDatabase1.DatabaseName := SQLQuery1.FieldByName('SOURCE_PATH').AsString;
//    IBDatabase1.Params.Values['Database'] := SQLQuery1.FieldByName('SOURCE_PATH').AsString;
    IBDatabase1.Params.Values['User_name'] := SQLQuery1.FieldByName('USERNAME').AsString;
    IBDatabase1.Params.Values['Password'] := SQLQuery1.FieldByName('PASSWD').AsString;
    try
     IBDatabase1.Connected := True;
    except
     raise;
    end;
{
    SQLConnSrc.Params.Clear;
    SQLConnSrc.Params.Values['Database'] := SQLQuery1.FieldByName('SOURCE_PATH').AsString;
    SQLConnSrc.Params.Values['User_name'] := SQLQuery1.FieldByName('USERNAME').AsString;
    SQLConnSrc.Params.Values['Password'] := SQLQuery1.FieldByName('PASSWD').AsString;
    try
      SQLConnSrc.Connected := True;
    except
      raise;
    end;
}
    IdRelacion := SQLQuery1.FieldByName('IDRELACION').AsInteger;
    IdSource   := SQLQuery1.FieldByName('IDSOURCE').AsInteger;
    IdTarget   := SQLQuery1.FieldByName('IDTARGET').AsInteger;

// Tomar Datos

   with SQLQReplicas do
   begin
        Close;
        SQL.Clear;
        SQL.Add('select * from TABLARELACIONES WHERE IDRELACION = :IDRELACION');
        ParamByName('IDRELACION').AsInteger := SQLQuery1.FieldByName('IDRELACION').AsInteger;
        try
         Open;
        except
         SQLConnMgr.Rollback(IDT);
         raise;
        end;

// Lectura de tablas a replicar
        while not Eof do
        begin

          IdReplica := FieldByName('IDREPLICA').AsInteger;
          Tabla     := FieldByName('NOMTABLA').AsString;
          Llave     := FieldByName('PKTABLA').AsString;

          RemoverTrigger(IdRelacion,IdSource,IdTarget,IdReplica,Tabla,Llave,'I');
          RemoverTrigger(IdRelacion,IdSource,IdTarget,IdReplica,Tabla,Llave,'U');
          RemoverTrigger(IdRelacion,IdSource,IdTarget,IdReplica,Tabla,Llave,'D');

          Next;
        end;

   end;

   MessageDlg('Objetos Removidos con Exito',mtinformation,[mbOk],0);



end;

procedure TfrmAplicarDefinicion.RemoverTrigger(IdRelacion,IdSource,IdTarget,IdReplica:Integer;Tabla,Llave,Op: string);
var
  IDT1:TTransactionDesc;
  Nombre:string;
begin
  if Op = 'I' then begin
    Nombre := 'REPL$'+IntToStr(IdRelacion)+'_'+IntToStr(IdReplica)+'_I';
  end;


  if Op = 'D' then begin
    Nombre := 'REPL$'+IntToStr(IdRelacion)+'_'+IntToStr(IdReplica)+'_D';
  end;


  if Op = 'U' then begin
    Nombre := 'REPL$'+IntToStr(IdRelacion)+'_'+IntToStr(IdReplica)+'_U';
  end;

  IBTransaction1.StartTransaction;

  with IBQuery1 do begin
    Close;
    SQL.Clear;
    SQL.Add('select * from RDB$TRIGGERS where RDB$TRIGGER_NAME = :NOMBRE');
    ParamByName('NOMBRE').AsString := Nombre;
    try
     Open;
     if RecordCount > 0 then
     begin
        Close;
        SQL.Clear;
        SQL.Add('DROP TRIGGER '+Nombre);
        try
         ExecSQL;
         Transaction.Commit;
        except
         Transaction.Rollback;
         raise;
        end;
     end
     else
       Transaction.Commit;
    except
      Transaction.Rollback;
      raise;
    end;
  end;

{
  IDT1.TransactionID := 21;
  IDT1.IsolationLevel := xilREADCOMMITTED;

  SQLConnSrc.StartTransaction(IDT1);

  with SQLQProcesos do begin
   Close;
   SQL.Clear;
   for i := 0 to OutTrig.Count - 1 do
     SQL.Add(OutTrig.Strings[i]);
   try
    SQL.SaveToFile('C:\SQL.SQL');
    ExecSQL(True);
    SQLConnSrc.Commit(IDT1);
   except
    on E:EDatabaseError   do
    begin
      SQLConnSrc.Rollback(IDT1);
      ShowMessage(E.Message);
    end;
   end;
  end;
}
end;


end.
