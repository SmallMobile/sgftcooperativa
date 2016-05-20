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
  correo,correo1,correo2 :string;
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
        Writeln('Iniciando Proceso de Sumatoria desde ' + DBname);
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
        cadena1 := 'MODALIDAD';
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
        correo2 := correo2 + cadena_1 +  cadena_3 + '  ' +  cadena_2 + #13;
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
              cadena_1 := '                              ';
              cadena_2 := '                              ';
              cadena_3 := '          ';
              cadena1 := FieldByName('TIPO_CAPTACION').AsString;
              cadena2 := FORMATCURR('#,#0.00',FieldByName('SALDO_ACTUAL').AsCurrency);
              cadena3 := FieldByName('NUMERO').AsString;
              longitud1 := StrLen(PChar(cadena1));
              longitud2 := StrLen(PChar(cadena2));
              longitud3 := StrLen(PChar(cadena3));
              system.Insert(LeftStr(cadena1,longitud1),cadena_1,1);
              system.Insert(LeftStr(cadena2,longitud2),cadena_2,1);
              system.Insert(LeftStr(cadena3,longitud3),cadena_3,1);
              Writeln(cadena_1 + #9 + cadena_3 + '  $' + cadena_2);
              correo := correo + cadena_1 + cadena_3 + '  $' + cadena_2 + #13;
              if FieldByName('ID_SUMATORIA').AsInteger = 1 then
                 correo1 := correo1 + cadena_1 + cadena_3 + '  $' + cadena_2 + #13;
              if FieldByName('ID_SUMATORIA').AsInteger = 2 then
                 correo2 := correo2 + cadena_1 + cadena_3 + '  $' + cadena_2 + #13;
              Next;
           end;
        end;
       Writeln('Enviando Correo Contabilidad');
       // proceso contabilidad
       //Application.ProcessMessages;
       Mensaje.From.Text := DBfrom;
       Mensaje.Recipients.EMailAddresses := DBContador;
       //Mensaje.ReceiptRecipient.Text := Mensaje.From.Text;
       Mensaje.Priority := TIdMessagePriority(0);
       Mensaje.Subject := 'Sumatoria General Generada el día ' + FormatDateTime('dd-mm-yyyy',Date);
       Mensaje.Body.Add('CONTABILIDAD');
       Mensaje.Body.Add('');
       Mensaje.Body.Add('SUMATORIA GENERADA EL DIA : ' + FormatDateTime('dd-mm-yyyy',Date) + ' 00:00:00...');
       Mensaje.Body.Add('');
       Mensaje.Body.Add(correo);
       Mensaje.Body.Add('');
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
       Mensaje.From.Text := DBfrom;
       Mensaje.Recipients.EMailAddresses := DBCreditos;
       //Mensaje.ReceiptRecipient.Text := Mensaje.From.Text;
       Mensaje.Priority := TIdMessagePriority(0);
       Mensaje.Subject := 'Sumatoria de Cartera Generada el día ' + FormatDateTime('dd-mm-yyyy',Date);
       Mensaje.Body.Add('CREDITOS');
       Mensaje.Body.Add('');
       Mensaje.Body.Add('SUMATORIA GENERADA EL DIA : ' + FormatDateTime('dd-mm-yyyy',Date) + ' 00:00:00...');
       Mensaje.Body.Add('');
       Mensaje.Body.Add(correo2);
       Mensaje.Body.Add('');
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
       Mensaje.From.Text := DBfrom;
       Mensaje.Recipients.EMailAddresses := DBAhorros;
       //Mensaje.ReceiptRecipient.Text := Mensaje.From.Text;
       Mensaje.Priority := TIdMessagePriority(mpnormal);
       Mensaje.Subject := 'Sumatoria de Ahorros Generada el día ' + FormatDateTime('dd-mm-yyyy',Date);
       Mensaje.Body.Add('AHORROS');
       Mensaje.Body.Add('');
       Mensaje.Body.Add('SUMATORIA GENERADA EL DIA : ' + FormatDateTime('dd-mm-yyyy',Date) + ' 00:00:00...');
       Mensaje.Body.Add('');
       Mensaje.Body.Add(correo1);
       Mensaje.Body.Add('');
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
