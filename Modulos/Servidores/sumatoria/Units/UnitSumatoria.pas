unit UnitSumatoria;
interface
uses
  SysUtils, Types, Classes,SqlExpr,IniFiles,DateUtils,IdMessage,IdSMTP,StrUtils,sdXmlDocuments,IdTCPClient,Forms,Controls;
procedure inicio;
var
  SQLConnection1: TSQLConnection;
  SQLQuery1: TSQLQuery;
  SQLQuery2: TSQLQuery;
  IdTCPClient1: TIdTCPClient;
  Mensaje: TIdMessage;
  idSCorreo: TIdSMTP;
  XmlPetc :TsdXmlDocument;
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
  correo,correo1,correo2 :TStringList;
  cadena_1,cadena_2 :string[25];
  cadena_3 :string[10];
  cadena1,cadena2,cadena3 :string;
  DBContador :string;
  DBUserContador :string;
  DBPassContador :string;
  DBCreditos :string;
  DBUserCreditos :string;
  DBPassCreditos :string;
  DBAhorros :string;
  DBUserahorros :string;
  DBPassAhorros :string;
  DBPuerto :Integer;
  DBHost :string;
  DBfrom :string;
  vOpcion :Boolean;
  _dFechaActual:TDate;
procedure insertar(tipo,numero,id:integer;desc:string;saldo:currency);
var     fecha :TDateTime;
begin
        fecha := _dFechaActual - 1;
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
        cadena_1 := '                         ';
        cadena_3 := '          ';
        cadena_2 := '                         ';
        Mensaje := TIdMessage.Create(nil);
        idSCorreo := TIdSMTP.Create(nil);
        idSCorreo.AuthenticationType := atLogin;
        MiINI := ChangeFileExt(Application.ExeName,'.ini');
        with TIniFile.Create(MiINI) do
        try
          DBName := ReadString('DBSUMATORIA','DBname','192.168.200.141:/var/db/fbird/database.fdb');
          DBAgencia := ReadInteger('DBSUMATORIA','DBagencia',1);
          DBContador := ReadString('DBcorreo','DBcontador','');
          DBUserContador := ReadString('DBcorreo','DBuserContador','');
          DBPassContador := ReadString('DBcorreo','DBpaswordContador','');
          DBCreditos := ReadString('DBcorreo','DBcreditos','');
          DBUserCreditos := ReadString('DBcorreo','DBuserCreditos','');
          DBPassCreditos := ReadString('DBcorreo','DBpaswordCreditos','');
          DBAhorros := ReadString('DBcorreo','DBAhorros','');
          DBuserahorros := ReadString('DBcorreo','DBuserAhorros','');
          DBpassahorros := ReadString('DBcorreo','DBpaswordAhorros','');
          DBfrom := ReadString('DBcorreo','DBfrom','');
          DBPuerto := ReadInteger('DBSUMATORIA','DBpuerto',0);
          DBHost := ReadString('DBSUMATORIA','DBhost','');
          vOpcion := ReadBool('DBSUMATORIA','vOpcion',False);
        finally
          free;
        end;
        Writeln('Iniciando Proceso de Sumatoria desde ' + DBname);
        SQLConnection1 := TSQLConnection.Create(nil);
        with SQLConnection1 do
        begin
          {ConnectionName := 'Interbase';
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
          VendorLib := 'libgds.so.0';}

          ConnectionName := 'IBlocal';
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
          VendorLib := 'GDS32.DLL';
          Writeln('Iniciand 1');
        end;
        SQLConnection1.Connected := True;
        SQLQuery1 := TSQLQuery.Create(nil);
        SQLQuery1.SQLConnection := SQLConnection1;
        SQLQuery2 := TSQLQuery.Create(nil);
        SQLQuery2.SQLConnection := SQLConnection1;
        with SQLQuery1 do
        begin
           Close;
           SQL.Clear;
           SQL.Add('select FECHA from SP_FECHA_ACTUAL');
           Open;
           _dFechaActual := FieldByName('FECHA').AsDateTime;
        end;
        //ojo
        {if DBagencia <> 1 then //xml generado en el caso de las agencias
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
        end;}
        //ojo

        correo := Tstringlist.Create;
        correo1 := Tstringlist.Create;
        correo2 := Tstringlist.Create;
        correo.Add('<html>');
        correo.Add('<body>');
        correo.Add('<b>CONTABILIDAD</b> <p>');
        correo.Add('<b>SUMATORIA GENERADA EL DIA : ' + FormatDateTime('yyyy/MM/dd',_dFechaActual -1) + ' 00:00:00...</b>');
        correo.Add('<table  border="1" width="65%" cellspacing="0" cellpadding="0">');
        correo.Add('<tr>');
        correo.Add('<td width="30%" align="center" bgcolor= "#EFEFEF"><b>MODALIDAD</b></td>');
        correo.Add('<td width="15%" align="center" bgcolor= "#EFEFEF"><b>CANTIDAD</b></td>');
        correo.Add('<td width="20%" align="center" bgcolor= "#EFEFEF"><b>SUMATORIA<b/></td>');
        correo.Add('</tr>');
//correo
        if DBagencia = 1 then
        begin
          correo1.Add('<html>');
          correo1.Add('<body>');
          correo1.Add('<b>SECCION AHORROS</b> <p>');
          correo1.Add('<b>SUMATORIA GENERADA EL DIA : ' + FormatDateTime('yyyy/MM/dd',_dFechaActual -1) + ' 00:00:00...</b><p>');
          correo1.Add('<table  border="1" width="65%" cellspacing="0" cellpadding="0">');
          correo1.Add('<tr>');
          correo1.Add('<td width="30%" align="center" bgcolor= "#EFEFEF"><b>MODALIDAD</b></td>');
          correo1.Add('<td width="15%" align="center" bgcolor= "#EFEFEF"><b>CANTIDAD</b></td>');
          correo1.Add('<td width="20%" align="center" bgcolor= "#EFEFEF"><b>SUMATORIA<b/></td>');
          correo1.Add('</tr>');
//cooreo
          correo2.Add('<html>');
          correo2.Add('<body>');
          correo2.Add('<b>SECCION CARTERA</b> <p>');
          correo2.Add('<b>SUMATORIA GENERADA EL DIA : ' + FormatDateTime('yyyy/MM/dd',_dFechaActual -1) + ' 00:00:00...</b><p>');
          correo2.Add('<table  border="1" width="65%" cellspacing="0" cellpadding="0">');
          correo2.Add('<tr>');
          correo2.Add('<td width="30%" align="center" bgcolor= "#EFEFEF"><b>MODALIDAD</b></td>');
          correo2.Add('<td width="15%" align="center" bgcolor= "#EFEFEF"><b>CANTIDAD</b></td>');
          correo2.Add('<td width="20%" align="center" bgcolor= "#EFEFEF"><b>SUMATORIA<b/></td>');
          correo2.Add('</tr>');
        end;
//correo
        with SQLQuery1 do
        begin
           Close;
           SQL.Clear;
           if DBagencia = 1 then
              SQL.Add('select * from SUMATORIAS_DIARIA (:ANO,:FECHA,:FECHA1)')
           else
              SQL.Add('select * from SUMATORIAS_PLANILLA (:ANO,:FECHA,:FECHA1)');
           ParamByName('ANO').AsInteger := YearOf(_dFechaActual);
           ParamByName('FECHA').AsDate := _dFechaActual + StrToTime('23:59:00');
           ParamByName('FECHA1').AsDate := StrToDateTime(IntToStr(YearOf(_dFechaActual)) + '/01/01 00:00:00');//; strtodate('2005/01/01') + StrToTime('00:00:00');
           Open;
           {if vOpcion = False then // valiodacion para generacion del correo
           begin
             while not Eof do
             begin
                Writeln('Guardando Registro No. ' + IntToStr(RecNo));
                //ojo
                //insertar(FieldByName('ID_CAPTACION').AsInteger,FieldByName('NUMERO').AsInteger,FieldByName('ID_SUMATORIA').AsInteger,FieldByName('TIPO_CAPTACION').AsString,FieldByName('SALDO_ACTUAL').AsCurrency);
                //if DBagencia <> 1 then
                   //cargaxml(vSentencia);
                Next;
             end;
             //ojo
//             XmlPetc.SaveToFile('c:\\sumatoria.xml');
             //EnviarXml;
             sqlconnection1.Close;
             Exit;
           end;}
             while not Eof do
             begin
                //ojo
                if DBagencia = 01111 then
                   insertar(FieldByName('ID_CAPTACION').AsInteger,FieldByName('NUMERO').AsInteger,FieldByName('ID_SUMATORIA').AsInteger,FieldByName('TIPO_CAPTACION').AsString,FieldByName('SALDO_ACTUAL').AsCurrency);
                cadena1 := FieldByName('TIPO_CAPTACION').AsString;
                cadena3 := FORMATCURR('#,#0.00',FieldByName('SALDO_ACTUAL').AsCurrency);
                cadena2 := FieldByName('NUMERO').AsString;
                correo.Add('<tr>');
                correo.Add('<td width="30%"align="left">' + cadena1 + '</td>');
                correo.Add('<td width="15%"align="center">' + cadena2 + '</td>');
                correo.Add('<td width="20%"align="right">' + cadena3 + '</td>');
                correo.Add('</tr>');
                if FieldByName('ID_SUMATORIA').AsInteger = 1 then
                begin
                  correo1.Add('<tr>');
                  correo1.Add('<td width="30%"align="left">' + cadena1 + '</td>');
                  correo1.Add('<td width="15%"align="center">' + cadena2 + '</td>');
                  correo1.Add('<td width="20%"align="right">' + cadena3 + '</td>');
                  correo1.Add('</tr>');
                end;
                if FieldByName('ID_SUMATORIA').AsInteger = 2 then
                begin
                  correo2.Add('<tr>');
                  correo2.Add('<td width="30%"align="left">' + cadena1 + '</td>');
                  correo2.Add('<td width="15%"align="center">' + cadena2 + '</td>');
                  correo2.Add('<td width="20%"align="right">' + cadena3 + '</td>');
                  correo2.Add('</tr>');
                end;
                Next;
             end;
          end;
          correo.Add('</table>');
          correo.Add('</body>');
          correo.Add('</html>');
          correo1.Add('</table>');
          correo1.Add('</body>');
          correo1.Add('</html>');
          correo2.Add('</table>');
          correo2.Add('</body>');
          correo2.Add('</html>');
         // proceso contabilidad
         Mensaje.ContentType := 'text/html';
         Mensaje.From.Text := DBfrom;
         Mensaje.Recipients.EMailAddresses := DBContador;
         //Mensaje.ReceiptRecipient.Text := Mensaje.From.Text;
         Mensaje.Priority := TIdMessagePriority(0);
         Mensaje.Subject := 'Sumatoria General Generada el día ' + FormatDateTime('dd-mm-yyyy',_dFechaActual -1);
         Mensaje.Body.Add(correo.Text);
         idSCorreo.Host := DBHost;//SmtpServerName;
         idSCorreo.Port := DBPuerto;//SmtpServerPort;
         idSCorreo.UserId := DBUserContador;//SmtpServerUser;
         idSCorreo.Password := DBPassContador;//SmtpServerPassword;
         idSCorreo.Connect;
         try
           idSCorreo.Send(mensaje);
           idSCorreo.Disconnect;
         except
            idSCorreo.Disconnect;
            raise;
         end;
         Sleep(100000);
         if DBagencia = 1 then
         begin
           // PROCESO CREDITOS
           //Writeln('Enviando Correo Creditos');
           //Application.ProcessMessages;
           Mensaje.ClearBody;
           Mensaje.ClearHeader;
           Mensaje.ContentType := 'text/html';
           Mensaje.From.Text := DBfrom;
           Mensaje.Recipients.EMailAddresses := DBCreditos;
           //Mensaje.ReceiptRecipient.Text := Mensaje.From.Text;
           Mensaje.Priority := TIdMessagePriority(0);
           Mensaje.Subject := 'Sumatoria de Cartera Generada el día ' + FormatDateTime('dd-mm-yyyy',_dFechaActual -1);
           Mensaje.Body.Add(correo2.Text);
           idSCorreo.Host := DBHost;
           idSCorreo.Port := DBPuerto;
           idSCorreo.UserId := DBUserCreditos;
           idSCorreo.Password := DBPassCreditos;
           idSCorreo.Connect;
           try
             idSCorreo.Send(mensaje);
             idSCorreo.Disconnect;
           except
              idSCorreo.Disconnect;
              raise;
           end;
           Sleep(100000);
           //Writeln('Enviando Correo Ahorros');
           //Application.ProcessMessages;
           Mensaje.ClearBody;
           Mensaje.ClearHeader;
           Mensaje.ContentType := 'text/html';
           Mensaje.From.Text := DBfrom;
           Mensaje.Recipients.EMailAddresses := DBAhorros;
           //Mensaje.ReceiptRecipient.Text := Mensaje.From.Text;
           Mensaje.Priority := TIdMessagePriority(mpnormal);
           Mensaje.Subject := 'Sumatoria de Ahorros Generada el día ' + FormatDateTime('dd-mm-yyyy',_dFechaActual -1);
           Mensaje.Body.Add(correo1.Text);
           idSCorreo.Host := DBHost;
           idSCorreo.Port := DBPuerto;
           idSCorreo.UserId := DBUserahorros;
           idSCorreo.Password := DBPassAhorros;
           idSCorreo.Connect;
           try
             idSCorreo.Send(mensaje);
             idSCorreo.Disconnect;
           except
              idSCorreo.Disconnect;
              raise;
           end;
         end;
         Sleep(100000);
         sqlconnection1.Close;
       //application.Terminate;
       exit;
        //Writeln('Mensajes enviados Correctamnete');
        //Readln(i);

end;

end.
