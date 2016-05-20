unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Grids, DBGrids, DB, DBClient,
  IBDatabase, IBCustomDataSet, IBQuery,IniFiles, JvComponent, JvBaseDlg,
  JvPasswordForm, DataSetToExcel, IBScript, DBXpress, SqlExpr;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DsConsulta: TDataSource;
    CdConsulta: TClientDataSet;
    DBGrid2: TDBGrid;
    BitBtn4: TBitBtn;
    IBconsulta: TIBQuery;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    jv: TJvPasswordForm;
    IB: TIBScript;
    IBScript1: TIBScript;
    Memo2: TMemo;
    IBconexion: TSQLConnection;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    op: TOpenDialog;
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jvOk(Sender: TObject; Password: String; var Accept: Boolean);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
  private
    password1,password2 :string;
    salir :Boolean;
    archivo :TextFile;
    procedure general;
    { Private declarations }
  public
  published
    function cadena(cad: string): Integer;
    procedure select;
    procedure error(cadena: string);
    procedure delete;
    procedure insert;
    procedure mensaje(cadena: string);
    procedure actualizar;
    procedure execute;
    procedure script;
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses UnitCuadro,ComObj;

{$R *.dfm}

procedure TFrmMain.BitBtn4Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmMain.BitBtn3Click(Sender: TObject);
begin
        Memo1.Text := '';
        BitBtn1.Enabled := True;
        BitBtn2.Enabled := False;
        BitBtn6.Enabled := True;
        DsConsulta.Enabled := False;
        Memo1.SetFocus;
        IBconexion.Close;
end;

procedure TFrmMain.BitBtn1Click(Sender: TObject);
var
  Tipo:string;
  posicion :TStringList;
  archivo_respaldo :string;
begin
        BitBtn5.Click;
        BitBtn6.Enabled := False;
        IBconexion.Open;
     if MessageDlg('Esta Seguro de Realizar la Transacción?',mtWarning,[mbyes,mbno],0) = mrno then
        Exit;
     AssignFile(archivo,'C:\Consulta\sentencia.log');
     Archivo_respaldo :='C:\Consulta\sentencia.log';
     if not(FileExists(Archivo_respaldo)) then
        Rewrite(archivo);
        DsConsulta.Enabled := True;
        CdConsulta.Active := False;
        CdConsulta.FieldDefs.Clear;
        if Memo1.Text <> '' then
        begin
          posicion := TStringList.Create;
          posicion.Text := StringReplace(' ' + Memo1.Text,' ',#13,[rfReplaceAll]);
          Tipo :=  LowerCase(posicion.Strings[1]);
          if cadena(Tipo) in [0,1,2,3,4,5,6,7,8,9,10] then//'select','delete','insert','update','grant','drop','revoke','create','alter','execute') then
          begin
              case cadena(Tipo) of
                0 : select;
                1 : Insert;
                2 : Delete;
                3 : actualizar;
                4 : script;
                else
                  general;
              end;
              system.Append(archivo);
              system.Writeln(archivo,'Fecha y Hora de Registro ' + datetostr(Date) + '_' + timetostr(Time) + '*********' +  memo1.Text + 'Fin Registro *******');
              system.Flush(archivo);
              system.CloseFile(archivo);
              if salir then
              begin
                BitBtn2.Enabled := True;
              end;
              BitBtn1.Enabled := False;
          end
          else
          begin
             ShowMessage('Error, Sentencia "' + Tipo + '"  no Registrada');
             Memo1.SetFocus;
             Exit;
          end;
        end;

end;

function TFrmMain.cadena(Cad: string): integer;
begin
        if cad = 'select' then
           Result := 0
        else if Cad = 'insert' then
           Result := 1
        else if Cad = 'delete' then
           Result := 2
        else if Cad = 'update' then
           Result := 3
        else if cad = 'script' then
           Result := 4
        else if Cad = 'drop' then
           Result := 5
        else if Cad = 'alter' then
           Result := 6
        else if Cad = 'create' then
           Result := 7
        else if Cad = 'revoke' then
           Result := 8
        else if Cad = 'grant' then
           Result := 9
        else if Cad = 'execute' then
           Result := 10
        else
           Result := -1

end;

procedure TFrmMain.FormCreate(Sender: TObject);
var     server,MiINI,oficina,codigo :string;
begin
  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(MiINI) do
  try
    server := ReadString('DBNAME','server','');
    oficina := ReadString('DBNAME','oficina','');
    codigo :=  ReadString('DBNAME','codigo','');
  finally
    free;
  end;
  salir := True;
  password1 := 'svr00' + codigo;
  jv.Execute;
  Self.Caption := 'Conectado a: + ' + oficina + ', ' + server + ' V.2014/05/12 Mej.';
  if LowerCase(password2) = password1 then
  begin
      try
       FrmCuadro := TFrmCuadro.Create(Self);
       IBDatabase1.DatabaseName := server;
       IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
       IBDatabase1.Params.Values['User_Name'] := 'SYSDBA';
       IBDatabase1.Params.Values['PassWord'] := 'masterkey';
       IBDatabase1.Connected := False;
       IBDatabase1.Connected := True;
       IBTransaction1.Active := True;
        with IBconexion do
        begin
          ConnectionName := 'IBlocal';
          DriverName := 'Interbase';
          GetDriverFunc := 'getSQLDriverINTERBASE';
          KeepConnection := True;
          LibraryName := 'dbexpint.dll';
          LoadParamsOnConnect := False;
          LoginPrompt := False;
          Params.Append('Database=' + server);
          Params.Append('User_Name=sysdba');
          Params.Append('Password=masterkey');
          Params.Append('ServerCharSet=ISO8859_1');
          Params.Append('SQLDialect=3');
          Params.Append('BlobSize=-1');
          Params.Append('CommitRetain=False');
          Params.Append('LocaleCode=0000');
          Params.Append('Interbase TransIsolation=ReadCommited');
          Params.Append('WaitOnLocks=True');
          VendorLib := 'GDS32.DLL';
        end;

      except
       Application.Terminate;
      end;
  end
  else
  begin
     ShowMessage('Contraseña Incorrecta');
     Application.Terminate;
  end;
end;

procedure TFrmMain.select;
var     i :Integer;
begin
        try
            with IBconsulta do
            begin
              Close;
              SQL.Clear;
              if Transaction.InTransaction then
                 Transaction.Commit;
              Transaction.StartTransaction;
              SQL.Add(Memo1.Text);
              Open;
              if RecordCount > 0 then
              begin
                for i := 0 to FieldDefs.Count -1 do
                    CdConsulta.FieldDefs.Add(FieldDefs.Items[i].Name,FieldDefs.Items[i].DataType,FieldDefs.Items[i].Size,False);
                CdConsulta.CreateDataSet;
                CdConsulta.Active := true;
                DsConsulta.DataSet := CdConsulta;
                while not Eof do
                begin
                  CdConsulta.Append;
                for i := 0 to Fields.Count -1 do
                begin
                    if CdConsulta.FieldDefs[i].DataType = ftstring then
                      CdConsulta.Fields[i].Value := Fields.Fields[i].AsString
                    else
                    if CdConsulta.FieldDefs[i].DataType in [ftsmallint,ftinteger,ftword,ftboolean] then
                     CdConsulta.Fields[i].Value := Fields.Fields[i].AsInteger
                    else
                    if CdConsulta.FieldDefs[i].DataType in [ftDate,ftDateTime] then
                      CdConsulta.Fields[i].Value := Fields.Fields[i].AsDateTime
                    else
                    if CdConsulta.FieldDefs[i].DataType in [ftTime] then
                      CdConsulta.Fields[i].Value := Fields.Fields[i].AsString
                    else
                    if CdConsulta.FieldDefs[i].DataType = ftMemo then
                      CdConsulta.Fields[i].Value := Fields.Fields[i].AsString
                    else
                    if CdConsulta.FieldDefs[i].DataType in [ftBlob,ftGraphic] then
                    begin
                      CdConsulta.Fields[i].Value := Fields.Fields[i].Value
                    end
                    else
                    if CdConsulta.FieldDefs[i].DataType in [ftFloat,ftCurrency] then
                      CdConsulta.Fields[i].Value := Fields.Fields[i].AsFloat
                    else
                    if CdConsulta.FieldDefs[i].DataType in [ftFMTBcd,ftBCD] then
                       try
                         CdConsulta.Fields[i].Value := Fields.Fields[i].AsCurrency
                       except
                         CdConsulta.Fields[i].Value := Fields.Fields[i].AsVariant;
                       end
                    else
                      CdConsulta.Fields[i].Value := Fields.Fields[i].AsString;
                end;
                CdConsulta.Post;
                Next;
              end;
              for i := 0 to DBGrid2.Columns.Count -1 do
                  DBGrid2.Columns[i].Width := 100;
              end
              else
                mensaje('No se Encontraron Registros');
            end;
        except
        on e : Exception do
        begin
          salir := False;
          error(e.Message);
        end;
        end;

end;

procedure TFrmMain.error(cadena: string);
var       posicion :TStringList;
          mensaje1 :string;
          i :Integer;
begin
          mensaje1 := '';
          posicion := TStringList.Create;
          posicion.Text := cadena;
          for i := 0 to posicion.Count -1 do
              mensaje1 := mensaje1 + posicion.Strings[i] + ' ';
          mensaje(mensaje1);
end;

procedure TFrmMain.jvOk(Sender: TObject; Password: String;
  var Accept: Boolean);
begin
       Password2 := Password;
       Accept := True;
end;

procedure TFrmMain.DBGrid2CellClick(Column: TColumn);
begin
       if Column.Field.DataType = ftMemo then
       begin
         FrmCuadro.Memo1.Text := cdconsulta.Fields.FindField(Column.Field.FieldName).AsString;
         FrmCuadro.ShowModal;
       end;

end;

procedure TFrmMain.BitBtn2Click(Sender: TObject);
var     ExcelFile:TDataSetToExcel;
        Excel : Variant;
begin
        if not DirectoryExists('C:\RegConsultas\') then
           CreateDir('c:\RegConsultas\');
            CdConsulta.First;
            ExcelFile := TDataSetToExcel.Create(cdconsulta,'c:\RegConsultas\Consulta.xls');
            ExcelFile.WriteFile;
            //ExcelFile.Free;
            Excel := CreateOleObject('Excel.Application');
            Excel.WorkBooks.Open('C:\RegConsultas\Consulta.xls');
            Excel.visible:=True;

end;

procedure TFrmMain.delete;
var     afecto :Integer;
begin
        afecto := 0;
        try
            with IBconsulta do
            begin
              Close;
              SQL.Clear;
              if Transaction.InTransaction then
                 Transaction.Commit;
              Transaction.StartTransaction;
              SQL.Add(Memo1.Text);
              ExecSQL;
              afecto := RowsAffected;
              Transaction.Commit;
              if afecto > 0 then
                mensaje('Se Eliminaron un Total de ' + IntToStr(afecto) + ' Registro(s)')
              else
                mensaje('No Elimino Ningun Registro, Favor Verifique');
            end;
        except
        on e : Exception do
        begin
          salir := False;
          error(e.Message);
        end;
        end;

end;

procedure TFrmMain.insert;
var     afecto :Integer;
begin
        afecto := 0;
        try
            with IBconsulta do
            begin
              Close;
              SQL.Clear;
              if Transaction.InTransaction then
                 Transaction.Commit;
              Transaction.StartTransaction;
              SQL.Add(Memo1.Text);
              ExecSQL;
              afecto := RowsAffected;
              Transaction.Commit;
              if afecto > 0 then
                mensaje('Se Grabaron ' + IntToStr(afecto) + ' Registro(s)')
              else
                mensaje('No Grabo Registro, Favor Verifique');
            end;
        except
        on e : Exception do
        begin
          salir := False;
          error(e.Message);
        end;
        end;
end;

procedure TFrmMain.mensaje(cadena: string);
begin
        CdConsulta.FieldDefs.Clear;
        CdConsulta.FieldDefs.Add('Mensaje',ftString,500,False);
        CdConsulta.CreateDataSet;
        CdConsulta.Active := True;
        CdConsulta.Append;
        CdConsulta.FieldValues['Mensaje'] := cadena;
        cdConsulta.Post;
        DsConsulta.DataSet := CdConsulta;
end;

procedure TFrmMain.actualizar;
var     afecto :Integer;
begin
        afecto := 0;
        try
            with IBconsulta do
            begin
              Close;
              SQL.Clear;
              if Transaction.InTransaction then
                 Transaction.Commit;
              Transaction.StartTransaction;
              SQL.Add(Memo1.Text);
              ExecSQL;
              afecto := RowsAffected;
              Transaction.Commit;
              if afecto > 0 then
                mensaje('Se Actualizaron ' + IntToStr(afecto) + ' Registro(s)')
              else
                mensaje('No se Actualizo ningun Registro, Favor Verifique');
            end;
        except
        on e : Exception do
        begin
          salir := False;
          error(e.Message);
        end;
        end;

end;


procedure TFrmMain.execute;
var     afecto :Integer;
begin
        afecto := 0;
        try
            with IBconsulta do
            begin
              Close;
              SQL.Clear;
              if Transaction.InTransaction then
                 Transaction.Commit;
              Transaction.StartTransaction;
              SQL.Add(Memo1.Text);
              ExecSQL;
              afecto := RowsAffected;
              Transaction.Commit;
            end;
        except
        on e : Exception do
        begin
          salir := False;
          error(e.Message);
        end;
        end;
end;

procedure TFrmMain.script;
var     texto :string;
        i :Integer;
begin

//        texto := '';
//        ShowMessage(IntToStr(Memo1.Lines.Count));
        for i := 1 to memo1.Lines.Count do
        begin
            if i = 1  then
              texto := Memo1.Lines.Strings[i]
            else
              texto := texto + #13 + Memo1.Lines.Strings[i];
        end;
        Memo2.Text := texto;
//        ShowMessage(Memo2.Text);
      try
        with IB do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          script.Clear;
          Script.Text := texto;
          ExecuteScript;
          Transaction.Commit;
        end;
        except
        on e : Exception do
        begin
          salir := False;
          error(e.Message);
          Exit;
        end;
        end;
        error('Script Ejecutado con Exito');
        //IBDatabase1.
end;

procedure TFrmMain.general;
begin
        try
           { with IBconsulta do
            begin
              Close;
              SQL.Clear;
              if Transaction.InTransaction then
                 Transaction.Commit;
              Transaction.StartTransaction;
              SQL.Add(Memo1.Text);
              ExecSQL;
              Transaction.Commit;
            end;}
            IBconexion.Execute(Memo1.Text,nil,nil)
        except
        on e : Exception do
        begin
          salir := False;
          error(e.Message);
        end;
        end;
          error('Procedimiento ejecutado con Exito');
end;

procedure TFrmMain.BitBtn5Click(Sender: TObject);
var     i :Integer;
begin
        Memo2.Text := '';
        for i := 0 to memo1.Lines.Count do
        begin
            if i = 2  then
            begin
              if Memo1.Lines.Strings[i] <> '' then
              Memo2.Lines.Add(Memo1.Lines.Strings[i]);
            end
            else if Memo1.Lines.Strings[i] <> '' then
              Memo2.Lines.Add(Memo1.Lines.Strings[i]);
        end;
        Memo1.Text := '';
        Memo1.Text := Memo2.Text;
end;

procedure TFrmMain.BitBtn6Click(Sender: TObject);
begin
        if op.Execute then
           Memo1.Lines.LoadFromFile(op.FileName);
        
end;

end.
