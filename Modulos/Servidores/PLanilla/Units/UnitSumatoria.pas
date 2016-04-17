unit UnitSumatoria;
interface
uses
  SysUtils, Types, Classes,SqlExpr,IniFiles,DateUtils,IdMessage,IdSMTP,StrUtils,sdXmlDocuments,IdTCPClient;
procedure inicio;
var
  SQLConnection1: TSQLConnection;
  SQLQuery1: TSQLQuery;
  SQLQuery2: TSQLQuery;
  XmlPetc :TsdXmlDocument;
  IdTCPClient1: TIdTCPClient;
  nodo,nodo1 :TXmlNode;
  vSentencia :string;
  pOcana :Integer;
  hOcana :string;

implementation
procedure inicio;
var
  MiIni:string;
  DBname :string;
  DBagencia :integer;
  vOpcion :Boolean;
procedure insertar(tipo,numero,id:integer;desc:string;saldo:currency);
var     fecha :TDateTime;
begin
        fecha := Date - 1;
        with SQLQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "gen$planilladiaria" values (:ID_TIPO,:FECHA,:ID_AGENCIA,:SALDO_ACTUAL,:NUMERO,:ID_SUMATORIA)');
          ParamByName('ID_TIPO').AsInteger := tipo;
          ParamByName('FECHA').AsDate := fecha;
          ParamByName('ID_AGENCIA').AsInteger := DBAgencia;
          ParamByName('SALDO_ACTUAL').AsCurrency := saldo;
          ParamByName('NUMERO').AsInteger := numero;
          ParamByName('ID_SUMATORIA').AsInteger := id;
          ExecSQL;
        end;
        vSentencia := 'insert into "gen$planilladiaria" values (' + IntToStr(tipo) + ',' + '''' + DateToStr(fecha)
         + '''' + ',' + IntToStr(1) + ',' + CurrToStr(saldo) + ','
         + IntToStr(numero) + ',' + IntToStr(id) + ')';
end;
procedure cargaxml(sentencia:string);
begin
         Nodo1 := Nodo.NodeNew('query');
         Nodo1.WriteString('tipo','insert');
         nodo1.WriteString('sentencia',sentencia);
end;
procedure EnviarXml;
var     cadena :string;
        Astream :TMemoryStream;
        tamano :Integer;
begin
           with IdTCPClient1 do
           begin
             Port := pOcana;
             Host := hOcana;;
             try
               Connect;
             except
             on e: Exception do
             begin
                writeln('Error en la Conexión' + #13 + e.Message);
                Disconnect;
                Exit;
             end;
           end;
           if Connected then
           begin
                Cadena := ReadLn();
                AStream := TMemoryStream.Create;
                XmlPetC.SaveToStream(AStream);
                WriteInteger(AStream.Size);
                OpenWriteBuffer;
                WriteStream(AStream);
                CloseWriteBuffer;
                FreeAndNil(AStream);
                tamano := ReadInteger;
                AStream := TMemoryStream.Create;
                ReadStream(Astream,tamano,False);
                XmlPetc.LoadFromStream(AStream);
                Disconnect;
           end;
           end;

end;
begin
        IdTCPClient1 := TIdTCPClient.Create(nil);
        shortdateformat := 'yyyy/mm/dd';
        decimalseparator := '.';
        thousandseparator := ',';
        MiINI := 'c:\sumatoria.ini';
        //MiINI := ('/usr/bin/sumatoria1.ini');
        with TIniFile.Create(MiINI) do
        try
          DBName := ReadString('DBSUMATORIA','DBname','192.168.200.141:/var/db/fbird/database.fdb');
          DBAgencia := ReadInteger('DBSUMATORIA','DBagencia',1);
          vOpcion := ReadBool('DBSUMATORIA','vOpcion',False);
        finally
          free;
        end;
        Writeln('Iniciando Proceso de Sumatoria desde ' + DBname + ' el dia ' + datetostr(date));
        SQLConnection1 := TSQLConnection.Create(nil);
        with SQLConnection1 do
        begin
          ConnectionName := 'Interbase';
          DriverName := 'Interbase';
          GetDriverFunc := 'getSQLDriverINTERBASE';
          KeepConnection := True;
          LibraryName := 'libsqlib.so.1';
          LoadParamsOnConnect := False;
          LoginPrompt := False;
          params.Clear;
          Params.Add('Database='+ DBName);
          Params.Add('User_Name=' + 'SYSDBA');
          Params.Add('Password=' + 'masterkey');
          Params.Add('ServerCharSet=ISO8859_1');
          Params.Add('SQLDialect=3');
          Params.Add('BlobSize=-1');
          Params.Add('CommitRetain=False');
          Params.Add('LocaleCode=0000');
          Params.Add('Interbase TransIsolation=ReadCommited');
          Params.Add('WaitOnLocks=True');
          VendorLib := 'libgds.so.0';

          {ConnectionName := 'IBlocal';
          DriverName := 'Interbase';
          GetDriverFunc := 'getSQLDriverINTERBASE';
          LibraryName := 'dbexpint.dll';
          LoginPrompt := False;
          Params.Add('Database='+ DBname);
          Params.Add('User_Name=sysdba');
          Params.Add('Password=masterkey');
          Params.Add('ServerCharSet=ISO8859_1');
          Params.Add('SQLDialect=3');
          Params.Add('BlobSize=-1');
          Params.Add('CommitRetain=False');
          Params.Add('LocaleCode=0000');
          Params.Add('Interbase TransIsolation=ReadCommited');
          Params.Add('WaitOnLocks=True');
          VendorLib := 'GDS32.DLL';}
        end;
        SQLConnection1.Connected := True;
        SQLQuery1 := TSQLQuery.Create(nil);
        SQLQuery1.SQLConnection := SQLConnection1;
        SQLQuery2 := TSQLQuery.Create(nil);
        SQLQuery2.SQLConnection := SQLConnection1;
        if DBagencia <> 1 then //xml generado en el caso de las agencias
        begin
          XmlPetc := TsdXmlDocument.CreateName('query_info');
          XmlPetc.XmlFormat := xfReadable;
          Nodo := XmlPetc.Root.NodeNew('querys');
          with SQLQuery2 do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select ID_PUERTO,ID_HOST from "gen$servidor" where ID_AGENCIA = :ID_AGENCIA and ID_SERVICIO = :ID_SERVICIO');
            ParamByName('ID_AGENCIA').AsInteger := 1;
            ParamByName('ID_SERVICIO').AsInteger := 1;
            Open;
            hOcana := FieldByName('ID_HOST').AsString;
            pOcana := FieldByName('ID_PUERTO').AsInteger;
          end;
        end;
        with SQLQuery1 do
        begin
           Close;
           SQL.Clear;
           SQL.Add('select * from SUMATORIAS_PLANILLA (:ANO,:FECHA,:FECHA1)');
           ParamByName('ANO').AsInteger := YearOf(Date);
           ParamByName('FECHA').AsDate := date + StrToTime('23:59:00');
           ParamByName('FECHA1').AsDate := StrToDateTime(IntToStr(YearOf(Date)) + '/01/01 00:00:00');//; strtodate('2005/01/01') + StrToTime('00:00:00');
           Open;
           if vOpcion = False then // valiodacion para generacion del correo
           begin
             while not Eof do
             begin
                Writeln('Guardando Registro No. ' + IntToStr(RecNo));
                insertar(FieldByName('ID_CAPTACION').AsInteger,FieldByName('NUMERO').AsInteger,FieldByName('ID_SUMATORIA').AsInteger,FieldByName('TIPO_CAPTACION').AsString,FieldByName('SALDO_ACTUAL').AsCurrency);
                if DBagencia <> 1 then
                   cargaxml(vSentencia);
                Next;
             end;
//             XmlPetc.SaveToFile('c:\\sumatoria.xml');
             EnviarXml;
             sqlconnection1.Close;
             Exit;
           end;
             while not Eof do
             begin
                insertar(FieldByName('ID_CAPTACION').AsInteger,FieldByName('NUMERO').AsInteger,FieldByName('ID_SUMATORIA').AsInteger,FieldByName('TIPO_CAPTACION').AsString,FieldByName('SALDO_ACTUAL').AsCurrency);
                Next;
             end;
           end;
       sqlconnection1.Close;
       exit;

end;

end.
