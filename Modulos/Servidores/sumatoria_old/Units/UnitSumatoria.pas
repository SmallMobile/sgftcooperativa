unit UnitSumatoria;
interface
uses
  SysUtils, Types, Classes,SqlExpr,IniFiles,DateUtils,IdMessage,IdSMTP,StrUtils;
procedure inicio;
var
  SQLConnection1: TSQLConnection;
  SQLQuery1: TSQLQuery;
  Mensaje: TIdMessage;
  idSCorreo: TIdSMTP;

implementation
procedure inicio;
var
  MiIni:string;
  DBname :string;
  DBagencia :integer;
  i :Integer;
  correo,correo1,correo2 :TStringList;
  longitud1,longitud2,longitud3:Integer;
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
begin
        shortdateformat := 'yyyy/mm/dd';
        decimalseparator := '.';
        thousandseparator := ',';
        cadena_1 := '                         ';
        cadena_3 := '          ';
        cadena_2 := '                         ';
        Mensaje := TIdMessage.Create(nil);
        idSCorreo := TIdSMTP.Create(nil);
        idSCorreo.AuthenticationType := atLogin;
        //MiINI := ChangeFileExt(Application.ExeName,'.ini');
        MiINI := ('/usr/bin/sumatoria1.ini');
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
        Writeln('Procesando Sumatoria');
        {cadena1 := 'MODALIDAD';
        cadena2 := 'SUMATORIA';
        cadena3 := 'TOTALES';
        longitud1 := StrLen(PChar(cadena1));
        longitud3 := StrLen(PChar(cadena3));
        longitud2 := StrLen(PChar(cadena2));
        system.Insert(LeftStr(cadena1,longitud1),cadena_1,1);
        system.Insert(LeftStr(cadena2,longitud2),cadena_2,1);
        system.Insert(LeftStr(cadena3,longitud3),cadena_3,1);
        Writeln(cadena_1 + #9 + cadena_3 + '  ' + cadena_2);
        correo := correo +  cadena_1 + cadena_3 + '  ' +  cadena_2 + #13;
        correo1 := correo1 + cadena_1 +  cadena_3 + '  ' +  cadena_2 + #13;
        correo2 := correo2 + cadena_1 +  cadena_3 + '  ' +  cadena_2 + #13;}
        correo := Tstringlist.Create;
        correo1 := Tstringlist.Create;
        correo2 := Tstringlist.Create;
        correo.Add('<html>');
        correo.Add('<body>');
        correo.Add('<b>CONTABILIDAD</b> <p>');
        correo.Add('<b>SUMATORIA GENERADA EL DIA : ' + FormatDateTime('dd-mm-yyyy',Date) + ' 00:00:00...</b>');
        correo.Add('<table  border="1" width="65%" cellspacing="0" cellpadding="0">');
        correo.Add('<tr>');
        correo.Add('<td width="30%" align="center" bgcolor= "#EFEFEF"><b>MODALIDAD</b></td>');
        correo.Add('<td width="15%" align="center" bgcolor= "#EFEFEF"><b>CANTIDAD</b></td>');
        correo.Add('<td width="20%" align="center" bgcolor= "#EFEFEF"><b>SUMATORIA<b/></td>');
        correo.Add('</tr>');
//correo
        correo1.Add('<html>');
        correo1.Add('<body>');
        correo1.Add('<b>SECCION AHORROS</b> <p>');
        correo1.Add('<b>SUMATORIA GENERADA EL DIA : ' + FormatDateTime('dd-mm-yyyy',Date) + ' 00:00:00...</b><p>');
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
        correo2.Add('<b>SUMATORIA GENERADA EL DIA : ' + FormatDateTime('dd-mm-yyyy',Date) + ' 00:00:00...</b><p>');
        correo2.Add('<table  border="1" width="65%" cellspacing="0" cellpadding="0">');
        correo2.Add('<tr>');
        correo2.Add('<td width="30%" align="center" bgcolor= "#EFEFEF"><b>MODALIDAD</b></td>');
        correo2.Add('<td width="15%" align="center" bgcolor= "#EFEFEF"><b>CANTIDAD</b></td>');
        correo2.Add('<td width="20%" align="center" bgcolor= "#EFEFEF"><b>SUMATORIA<b/></td>');
        correo2.Add('</tr>');
//correo
        with SQLQuery1 do
        begin
           Close;
           SQL.Clear;
           SQL.Add('select * from SUMATORIAS_DIARIA (:ANO,:FECHA,:FECHA1)');
           ParamByName('ANO').AsInteger := YearOf(Date);
           ParamByName('FECHA').AsDate := date + StrToTime('23:59:00');
//           showmessage(datetostr(Date)  + timetostr(StrToTime('23:59:00')));
           ParamByName('FECHA1').AsDate := StrToDateTime(IntToStr(YearOf(Date)) + '/01/01 00:00:00');//; strtodate('2005/01/01') + StrToTime('00:00:00');
           Open;
           while not Eof do
           begin
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
       Writeln('Enviando Correo Contabilidad');
       // proceso contabilidad
       //Application.ProcessMessages;
       Mensaje.ContentType := 'text/html';
       Mensaje.From.Text := DBfrom;
       Mensaje.Recipients.EMailAddresses := DBContador;
       //Mensaje.ReceiptRecipient.Text := Mensaje.From.Text;
       Mensaje.Priority := TIdMessagePriority(0);
       Mensaje.Subject := 'Sumatoria General Generada el día ' + FormatDateTime('dd-mm-yyyy',Date);
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
       // PROCESO CREDITOS
       Writeln('Enviando Correo Creditos');
       //Application.ProcessMessages;
       Mensaje.ClearBody;
       Mensaje.ClearHeader;
       Mensaje.ContentType := 'text/html';
       Mensaje.From.Text := DBfrom;
       Mensaje.Recipients.EMailAddresses := DBCreditos;
       //Mensaje.ReceiptRecipient.Text := Mensaje.From.Text;
       Mensaje.Priority := TIdMessagePriority(0);
       Mensaje.Subject := 'Sumatoria de Cartera Generada el día ' + FormatDateTime('dd-mm-yyyy',Date);
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
       Writeln('Enviando Correo Ahorros');
       //Application.ProcessMessages;
       Mensaje.ClearBody;
       Mensaje.ClearHeader;
       Mensaje.ContentType := 'text/html';
       Mensaje.From.Text := DBfrom;
       Mensaje.Recipients.EMailAddresses := DBAhorros;
       //Mensaje.ReceiptRecipient.Text := Mensaje.From.Text;
       Mensaje.Priority := TIdMessagePriority(mpnormal);
       Mensaje.Subject := 'Sumatoria de Ahorros Generada el día ' + FormatDateTime('dd-mm-yyyy',Date);
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
       sqlconnection1.Close;
       //application.Terminate;
       exit;
        //Writeln('Mensajes enviados Correctamnete');
        //Readln(i);

end;

end.
