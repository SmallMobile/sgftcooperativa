unit Unitservercajas;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, IdBaseComponent, IdComponent, IdTCPServer, IdThreadMgr,
  IdThreadMgrDefault, DBXpress, DB, SqlExpr, FMTBcd,sdXmlDocuments,StrUtils,DateUtils,
  IdThreadMgrPool,Math, IdRawBase, IdRawClient, IdIcmpClient, QButtons;
type
  c_aportes = record
    cuenta :Integer;
    digito :Integer;
  end;
type
  TFrmservercajas = class(TForm)
    IdTCPServer1: TIdTCPServer;
    SQLConnection1: TSQLConnection;
    Label1: TLabel;
    base: TLabel;
    Label2: TLabel;
    Tiempo: TLabel;
    SQLQuery1: TSQLQuery;
    SQLStoredProc1: TSQLStoredProc;
    Mregistro: TMemo;
    Label3: TLabel;
    IPhost: TIdIcmpClient;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
    procedure IPhostReply(ASender: TComponent;
      const AReplyStatus: TReplyStatus);
    procedure BitBtn1Click(Sender: TObject);
  private
    IBconexion :TSQLConnection;
    IDpuerto :Integer;
    IDtiempo: Integer;
    DBserver: String;
    DBpath: String;
    DBname: String;
    DBRole :string;
    DBUser :string;
    DBpassword :string;
    archivo :TextFile;
    MiIni :string;
    host_remoto: string;
    host_ocana: string;
    host_abrego: string;
    host_convencion: string;
    Hay_Conexion: Boolean;
    //variables de captacion
    procedure server(AThreads: TIdPeerThread;id_transaccion:integer);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmservercajas: TFrmservercajas;
  numero: array[0..255] of Boolean;
implementation
uses IniFiles,ZLibStream;

{$R *.xfm}

procedure TFrmservercajas.FormCreate(Sender: TObject);
var    Archivo_respaldo :string;
        i :integer;
begin
     MiIni := ChangeFileExt(Application.ExeName,'.ini');
     shortdateformat := 'yyyy/mm/dd';
     decimalseparator := '.';
     AssignFile(archivo,ChangeFileExt(Application.ExeName,'.log'));
     Archivo_respaldo := ChangeFileExt(Application.ExeName,'.log');
     if not(FileExists(Archivo_respaldo)) then
        Rewrite(archivo);
     with TIniFile.Create(MiIni) do
     begin
       DBServer := ReadString('SERVER','servidor','0.0.0.0');
       DBPath := ReadString('SERVER','ruta','/var/db/fbird/');
       DBName := ReadString('SERVER','nombre','database.fdb');
       IDtiempo := StrToInt(ReadString('SERVER','tiempo','0'));
       IDpuerto := StrToInt(ReadString('SERVER','puerto','0'));
       DBrole := ReadString('SERVER','rolename','0');
       DBpassword := ReadString('SERVER','password','0');
       DBuser := ReadString('SERVER','username','0');
       host_ocana := ReadString('SERVER','hostocana','');
       host_abrego := ReadString('SERVER','hostabrego','');
       host_convencion := ReadString('SERVER','hostconvencion','');
     end;
     IdTCPServer1.TerminateWaitTime := IDtiempo;
     IdTCPServer1.DefaultPort := IDpuerto;
     IdTCPServer1.Active := True;
     Base.Caption := DBServer + ':' + DBPath + DBName;
     Tiempo.Caption := IntToStr(IDtiempo) + ' Milisegundos Puerto ' + IntToStr(IDpuerto);
     //for i := 1 to 255 do
         //numero[i] := false

end;

procedure TFrmservercajas.server(AThreads: TIdPeerThread;id_transaccion :Integer);
 type
        Saldos = record
           sDisponible :Currency;
           sActual :Currency;
           sCanje :Currency;
 end;
 var
        IBconsulta :TSQLQuery;
        IBTransaction :TTransactionDesc;
        Astream,Astream1,Astream2 :TMemoryStream;
        tamano :Integer;
        numerocuenta :string;
        TipoConsulta :string;
        id_persona :string;
        id_identificacion :Integer;
        Dbalias :string;
        Vhora :TDateTime;
        i :Integer;
        Numero_Cheques :Integer;
        cadena :string;
        es_firma :Boolean;
        es_credito :Boolean;
        VComision :Currency;
        Vmonedas :Currency;
        Vcheques :Currency;
        Vbilletes :Currency;
        VmonedasComision :Currency;
        VbilletesComision :Currency;
        VchequesComision :Currency;
        DgA :Integer;
        NmA :Integer;
        Nm :Integer;
        Ag :Integer;
        Dg :Integer;
        Tp :Integer;
        TipoOperacion :string;
        LibGeneral :Boolean;
        IBlibretas :TSQLQuery;
        IBotros :TSQLQuery;
        IBprocedimiento :TSQLStoredProc;
        Libreta :Integer;
        Mensaje :string;
        Valor :Currency;
        fFechaActual :TDateTime;
        V_Libreta :Boolean;
        v_General :Currency;
        Es_Autorizado :Boolean;
        Es_Servicaja :Boolean;
        servicaja :Boolean;
        TopeTotalOp:Integer;
        TopeValorOp:Currency;
        TotalOp:Integer;
        ValorOp:Currency;
        TopeTotalOpS:Integer;
        TopeValorOpS:Currency;
        TotalOpS:Integer;
        ValorOpS:Currency;
        XmlDoc, XmlRes :TsdXmlDocument;
        nodo,nodo1,nodo2 :TXmlNode;
        contador :Integer;
        vOrigenMov :string;
        vTpVerifica :integer;
function saldos_cuenta(opcion :Smallint): saldos;
begin
           with IBprocedimiento do
           begin
           if opcion = 1 then
           begin
             StoredProcName := 'SALDO_ACTUAL';// saldo actual
             Params[0].AsInteger := Ag;
             Params[1].AsInteger := Tp;
             Params[2].AsInteger := Nm;
             Params[3].AsInteger := Dg;
             Params[4].AsString := IntToStr(YearOf(fFechaActual ));
             Params[5].AsDate := EncodeDate(YearOf(fFechaActual),01,01);
             Params[6].AsDate := EncodeDate(YearOf(fFechaActual),12,31);
             Prepared := True;
             ExecProc;
             Result.sActual := ParamByName('SALDO_ACTUAL').AsCurrency;//).AsCurrency);
           end
           else if opcion = 2 then
           begin
             StoredProcName := 'SALDO_DISPONIBLE';// saldo disponible
             Params[0].AsInteger := Ag;
             Params[1].AsInteger := Tp;
             Params[2].AsInteger := Nm;
             Params[3].AsInteger := Dg;
             Params[4].AsString := IntToStr(YearOf(fFechaActual));
             Params[5].AsDate := EncodeDate(YearOf(fFechaActual),01,01);
             Params[6].AsDate := EncodeDate(YearOf(fFechaActual),12,31);
             Prepared := True;
             ExecProc;
             Result.sDisponible := ParamByName('SALDO_DISPONIBLE').AsCurrency;
           end
           else
           begin
           with IBotros do
           begin
             Close;
             SQL.Clear;// canje actual
             SQL.Add('SELECT SUM("cap$canje".VALOR_CHEQUE + "cap$canje".VALOR_MONEDAS) AS CANJE');
             SQL.Add('FROM');
             SQL.Add('"cap$maestro"');
             SQL.Add('LEFT JOIN "cap$canje" ON ("cap$maestro".ID_AGENCIA = "cap$canje".ID_AGENCIA) AND ');
             SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$canje".ID_TIPO_CAPTACION) AND ("cap$maestro".NUMERO_CUENTA = "cap$canje".NUMERO_CUENTA) AND ("cap$maestro".DIGITO_CUENTA = "cap$canje".DIGITO_CUENTA)');
             SQL.Add('Where');
             SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
             SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
             SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA and');
             SQL.Add('"cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA and');
             SQL.Add('"cap$canje".LIBERADO = 0 and');
             SQL.Add('"cap$canje".DEVUELTO = 0');
             ParamByName('ID_AGENCIA').AsInteger := Ag;
             ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
             ParamByName('NUMERO_CUENTA').AsInteger := Nm;
             ParamByName('DIGITO_CUENTA').AsInteger := Dg;
             Open;
             Result.sCanje := FieldByName('CANJE').AsCurrency;
           end;
           end;
end;
end;
function validar_libreta: Boolean;
var     usado:Boolean;
        contador :Integer;
begin
        Result := True;
        usado := False;
        with IBlibretas do
        begin
             Close;
             SQL.Clear;
             if TipoOperacion = 'C' then
             begin
               SQL.Add('select * from "cap$libretas" where ');
               SQL.Add('(ID_AGENCIA = :ID_AGENCIA and ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and ');
               SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and DIGITO_CUENTA = :DIGITO_CUENTA and');
               SQL.Add(':LIBRETA BETWEEN NUMERO_INICIAL and NUMERO_FINAL )');
               SQL.Add(' or ');
               SQL.Add('(ID_AGENCIA = :ID_AGENCIA and ID_TIPO_CAPTACION = 0 and ');
               SQL.Add('NUMERO_CUENTA = 0 and DIGITO_CUENTA = 0 and');
               SQL.Add(':LIBRETA BETWEEN NUMERO_INICIAL and NUMERO_FINAL )');
             end
             else
             begin
               SQL.Add('select * from "cap$libretas" where ');
               SQL.Add('(ID_AGENCIA = :ID_AGENCIA and ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and ');
               SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and DIGITO_CUENTA = :DIGITO_CUENTA and');
               SQL.Add(':LIBRETA BETWEEN NUMERO_INICIAL and NUMERO_FINAL )');
             end;
             ParamByName('ID_AGENCIA').AsInteger := Ag;
             ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
             ParamByName('NUMERO_CUENTA').AsInteger := Nm;
             ParamByName('DIGITO_CUENTA').AsInteger := Dg;
             ParamByName('LIBRETA').AsInteger := Libreta;
             try
              Open;
              contador := 0;
              while not Eof do
              begin
                contador := contador + 1;
                Next;
              end;
              if contador < 1 then
              begin
                 Result := False;
                 Mensaje := 'Talon Fuera de Rango';
                 Exit;
              end;
             except
              Result :=False;
              Mensaje := 'Error al Validar Rango';
              Exit;
             end;
             First;
             while not Eof do
             begin
              IBOtros.Close;
              IBotros.SQL.Clear;
              IBOtros.SQL.Add('select * from "cap$libretasusada" where ');
              IBOtros.SQL.Add('ID_AGENCIA = :ID_AGENCIA and ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and ');
              IBOtros.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and DIGITO_CUENTA = :DIGITO_CUENTA and');
              IBOtros.SQL.Add('NUMERO_TALON = :LIBRETA');
              IBOtros.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
              IBOtros.ParamByName('ID_TIPO_CAPTACION').AsInteger := FieldByName('ID_TIPO_CAPTACION').AsInteger;
              IBOtros.ParamByName('NUMERO_CUENTA').AsInteger := FieldByName('NUMERO_CUENTA').AsInteger;
              IBOtros.ParamByName('DIGITO_CUENTA').AsInteger := FieldByName('DIGITO_CUENTA').AsInteger;
              IBOtros.ParamByName('LIBRETA').AsInteger := Libreta;
              try
                IBotros.Open;
                contador := 0;
                while not IBotros.Eof do
                begin
                  contador := contador + 1;
                  IBotros.Next;
                end;
                if contador > 0 then
                begin
                   usado := True;
                   if FieldByName('NUMERO_CUENTA').AsInteger = 0 then
                     LibGeneral := true
                   else
                     LibGeneral := False;
                end
                else
                begin
                   usado := False;
                   if FieldByName('NUMERO_CUENTA').AsInteger = 0 then
                     LibGeneral := true
                   else
                     LibGeneral := False;
                end
              except
                Mensaje := 'Error consultando talon';
                Result := False;
              end;
              Next;
             end;
        end;
        if usado and LibGeneral then usado := False;

        if usado then
        begin
           Mensaje := 'Talon ya Utilizado';
           Result := False;
        end;
        //IBconexion.Rollback(IBTransaction);
end;
procedure Libretas_Usadas;
begin
      with IBotros do
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert into "cap$libretasusada" values(');
        SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,:NUMERO_TALON,:FECHA_USADA)');
        if LibGeneral then
        begin
           ParamByName('ID_AGENCIA').AsInteger := Ag;
           ParamByName('ID_TIPO_CAPTACION').AsInteger := 0;
           ParamByName('NUMERO_CUENTA').AsInteger := 0;
           ParamByName('DIGITO_CUENTA').AsInteger := 0;
        end
        else
        begin
           ParamByName('ID_AGENCIA').AsInteger := Ag;
           ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
           ParamByName('NUMERO_CUENTA').AsInteger := Nm;
           ParamByName('DIGITO_CUENTA').AsInteger := Dg;
        end;
           ParamByName('FECHA_USADA').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
           ParamByName('NUMERO_TALON').AsInteger := Libreta;
           ExecSQL;
      end;
end;
function Rcomision(id_minimo: integer): currency;
begin
        with IBotros do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select VALOR_MINIMO from "gen$minimos" where ID_MINIMO = :ID_MINIMO');
          ParamByName('ID_MINIMO').AsInteger := id_minimo;
          Open;
          Result := FieldByName('VALOR_MINIMO').AsCurrency;
        end;
end;
function Bool(valor: Boolean): integer;
begin
        if valor = True then
           Result := 1
        else
           Result := 0;
end;
function aportes(id_persona: string;
  id_identificacion: integer): c_aportes;
begin
        contador := 0;
        with IBotros do
        begin
          close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"cap$maestro".NUMERO_CUENTA,');
          SQL.Add('"cap$maestro".DIGITO_CUENTA');
          SQL.Add('FROM');
          SQL.Add('"cap$maestro"');
          SQL.Add('INNER JOIN "cap$maestrotitular" ON ("cap$maestro".ID_TIPO_CAPTACION = "cap$maestrotitular".ID_TIPO_CAPTACION) AND ("cap$maestro".NUMERO_CUENTA = "cap$maestrotitular".NUMERO_CUENTA)');
          SQL.Add('WHERE');
          SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = 1) AND');
          SQL.Add('("cap$maestrotitular".ID_PERSONA = :ID_PERSONA) AND');
          SQL.Add('("cap$maestrotitular".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND');
          SQL.Add('("cap$maestro".ID_ESTADO IN (1,3,4,5,6,8,10,12,13))');
          ParamByName('ID_PERSONA').AsString := id_persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
          open;
          while not eof do
          begin
            contador := contador + 1;
            next;
          end;
          First;
          if contador > 0 then
          begin
            result.cuenta := FieldByName('NUMERO_CUENTA').AsInteger;
            result.digito := FieldByName('DIGITO_CUENTA').AsInteger;
          end
          else
            result.cuenta := 0;
        end;
end;
//** busca cuenta rindediario
function aportesR(id_persona: string;
  id_identificacion: integer): c_aportes;
begin
        contador := 0;
        with IBotros do
        begin
          close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"cap$maestro".NUMERO_CUENTA,');
          SQL.Add('"cap$maestro".DIGITO_CUENTA');
          SQL.Add('FROM');
          SQL.Add('"cap$maestro"');
          SQL.Add('INNER JOIN "cap$maestrotitular" ON ("cap$maestro".ID_TIPO_CAPTACION = "cap$maestrotitular".ID_TIPO_CAPTACION) AND ("cap$maestro".NUMERO_CUENTA = "cap$maestrotitular".NUMERO_CUENTA)');
          SQL.Add('WHERE');
          SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = 2) AND');
          SQL.Add('("cap$maestrotitular".ID_PERSONA = :ID_PERSONA) AND');
          SQL.Add('("cap$maestrotitular".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND');
          SQL.Add('("cap$maestro".ID_ESTADO IN (1,3,4,5,6,8,10,12,13))');
          ParamByName('ID_PERSONA').AsString := id_persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
          open;
          while not eof do
          begin
            contador := contador + 1;
            next;
          end;
          First;
          if contador > 0 then
          begin
            result.cuenta := FieldByName('NUMERO_CUENTA').AsInteger;
            result.digito := FieldByName('DIGITO_CUENTA').AsInteger;
          end
          else
            result.cuenta := 0;
        end;
end;
//**
procedure notificacion;
begin
   Mregistro.Lines.Add(TipoOperacion + ' ' + TipoConsulta + ' ' + FormatDateTime('yyyy/mm/dd',fFechaActual) + ' ' + Formatdatetime('hh:mm:ss:zzz AM/PM',Vhora) + ' ' + numerocuenta + ' ' + Dbalias + ' id= ' + inttostr(id_transaccion));
end;
begin
     Hay_conexion := true;
     IBconexion := TSQLConnection.Create(nil);
     with IBconexion do
     begin
       ConnectionName := 'Interbase';
       DriverName := 'Interbase';
       GetDriverFunc := 'getSQLDriverINTERBASE';
       KeepConnection := True;
       LibraryName := 'libsqlib.so.1';
       LoadParamsOnConnect := False;
       LoginPrompt := False;
       params.Clear;
       Params.Add('Database='+ DBServer + ':' + DBPath + DBName);
       Params.Add('RoleName='+ DBrole);
       Params.Add('User_Name=' + DBuser);
       Params.Add('Password=' + DBpassword);
       Params.Add('ServerCharSet=ISO8859_1');
       Params.Add('SQLDialect=3');
       Params.Add('BlobSize=-1');
       Params.Add('CommitRetain=False');
       Params.Add('LocaleCode=0000');
       Params.Add('Interbase TransIsolation=ReadCommited');
       Params.Add('WaitOnLocks=True');
       VendorLib := 'libgds.so.0';
     end;
        cadena := '';
        ShortDateFormat := 'yyyy/MM/dd';
        DecimalSeparator := '.';
        IBconsulta := TSQLQuery.Create(nil);
        IBlibretas := TSQLQuery.Create(nil);
        IBotros := TSQLQuery.Create(nil);
        IBprocedimiento := TSQLStoredProc.Create(nil);
        IBprocedimiento.SQLConnection := IBconexion;
        IBconsulta.SQLConnection := IBconexion;
        IBlibretas.SQLConnection := IBconexion;
        IBotros.SQLConnection := IBconexion;
//        id_transaccion := Random(StrToInt(FormatDateTime('z',Time))) + 1 + StrToInt(FormatDateTime('z',Time));
        IBTransaction.TransactionID := id_transaccion;
        IBTransaction.IsolationLevel := xilREPEATABLEREAD;//xilREADCOMMITTED;
        //IBconexion.StartTransaction(IBTransaction);
        IBprocedimiento.TransactionLevel := id_transaccion;
        IBconsulta.TransactionLevel := id_transaccion;
        IBlibretas.TransactionLevel := id_transaccion;
        ibotros.TransactionLevel := id_transaccion;
        XmlDoc := TsdXmlDocument.CreateName('datos');// xml de llegada
        XmlDoc.EncodingString := 'ISO8859-1';
        XmlDoc.XmlFormat := xfReadable;
        XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
        XmlRes.EncodingString := 'ISO8859-1';
        XmlRes.XmlFormat := xfReadable;
        Astream := TMemoryStream.Create;
        tamano := AThreads.Connection.ReadInteger;
        AThreads.Connection.ReadStream(Astream,tamano,False);
        XmlDoc.LoadFromStream(Astream);
        TipoConsulta := XmlDoc.Root.ReadString('tipoconsulta');
        numerocuenta := XmlDoc.Root.ReadString('numerocuenta');
        TipoOperacion := XmlDoc.Root.ReadString('tipooperacion');
        es_firma := XmlDoc.Root.ReadBool('firma');
        Dbalias := XmlDoc.Root.ReadString('dbalias');
        Ag := StrToInt(MidStr(numerocuenta,1,1));
        Tp := StrToInt(MidStr(numerocuenta,2,1));
        Nm := StrToInt(MidStr(numerocuenta,3,7));
        Dg := StrToInt(MidStr(numerocuenta,10,1));
        {if Ag = 1 then
           host_remoto := host_ocana
           else if Ag = 2 then
              host_remoto := host_abrego
              else if Ag = 3 then
                 host_remoto := host_convencion;
        IPhost.Host := host_remoto;
        IPhost.Ping;
        if not (Hay_Conexion) then
        begin
          ibconexion.Close;
          exit;
        end;}
        contador := 0;
        VbilletesComision := 0;
        VmonedasComision := 0;
        VchequesComision := 0;
        fFechaActual := date;//IBprocedimiento.ParamByName('FECHA').AsDateTime;
        Vhora := time;//IBprocedimiento.ParamByName('HORA').AsTime;
        notificacion;
        with IBconsulta do
        begin
          try
          if TipoConsulta = 'S' then
          begin
             close;
             SQL.Clear;
             SQL.Add('SELECT');
             SQL.Add('"cap$maestro".ID_ESTADO,');
             SQL.Add('"cap$tiposestado".DESCRIPCION,');
             SQL.Add('"cap$tiposestado".PERMITE_MOVIMIENTO,');
             SQL.Add('"cap$tiposestado".PERMITE_MOVIMIENTO_ENTRADA,');
             SQL.Add('"cap$tiposestado".PARA_SALDAR,');
             SQL.Add('"cap$maestro".CUOTA,');
             SQL.Add('"cap$maestro".FIRMAS,');
             SQL.Add('"cap$maestro".SELLOS,');
             SQL.Add('"cap$maestro".PROTECTOGRAFOS,');
             SQL.Add('"cap$libretas".NUMERO_INICIAL,');
             SQL.Add('"cap$libretas".NUMERO_FINAL');
             SQL.Add('FROM');
             SQL.Add('"cap$maestro"');
             SQL.Add('INNER JOIN "cap$tiposestado" ON ("cap$maestro".ID_ESTADO = "cap$tiposestado".ID_ESTADO)');
             SQL.Add('LEFT JOIN "cap$libretas" ON ("cap$maestro".ID_AGENCIA = "cap$libretas".ID_AGENCIA and');
             SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = "cap$libretas".ID_TIPO_CAPTACION and');
             SQL.Add('"cap$maestro".NUMERO_CUENTA = "cap$libretas".NUMERO_CUENTA and');
             SQL.Add('"cap$maestro".DIGITO_CUENTA = "cap$maestro".DIGITO_CUENTA)');
             SQL.Add('WHERE');
             SQL.Add('("cap$maestro".ID_AGENCIA = :ID_AGENCIA) AND');
             SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION) AND');
             SQL.Add('("cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA) AND');
             SQL.Add('("cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA)');
             ParamByName('ID_AGENCIA').AsInteger := Ag;
             ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
             ParamByName('NUMERO_CUENTA').AsInteger := Nm;
             ParamByName('DIGITO_CUENTA').AsInteger := Dg;
             Open;
             while not Eof do
             begin
               contador := contador + 1;
               Next;
             end;
             if contador < 1 then
             begin
                  XmlRes.Root.WriteBool('ejecutado',False);
             end
             else
             begin
               First;
               XmlRes.Root.WriteBool('ejecutado',True);
               XmlRes.Root.WriteInteger('cuenta',Nm);
               XmlRes.Root.WriteInteger('id_estado',FieldByName('ID_ESTADO').AsInteger);
               XmlRes.Root.WriteString('descripcion_estado',FieldByName('DESCRIPCION').AsString);
               XmlRes.Root.WriteFloat('valorcuotacon',FieldByName('CUOTA').AsCurrency);
               XmlRes.Root.WriteInteger('firmas',FieldByName('FIRMAS').AsInteger);
               XmlRes.Root.WriteInteger('sellos',FieldByName('SELLOS').AsInteger);
               XmlRes.Root.WriteInteger('parasaldar',FieldByName('PARA_SALDAR').AsInteger);
               XmlRes.Root.WriteInteger('protectografos',FieldByName('PROTECTOGRAFOS').AsInteger);
               XmlRes.Root.WriteInteger('permite_movimiento',Abs(FieldByName('PERMITE_MOVIMIENTO').AsInteger));
               XmlRes.Root.WriteInteger('permite_movimiento_entrada',Abs(FieldByName('PERMITE_MOVIMIENTO_ENTRADA').AsInteger));
               XmlRes.Root.WriteString('numero_inicial',Format('%.8d',[FieldByName('NUMERO_inicial').AsInteger]));
               XmlRes.Root.WriteString('numero_final',Format('%.8d',[FieldByName('NUMERO_FINAL').AsInteger]));
               Close;
               SQL.Clear;
               SQL.Add('select "gen$persona".ID_IDENTIFICACION,"gen$persona".ID_PERSONA,');
               SQL.Add('"gen$persona".PRIMER_APELLIDO,"gen$persona".SEGUNDO_APELLIDO,"gen$persona".NOMBRE,"gen$persona".DATOS_HUELLA,"gen$persona".FIRMA,"cap$maestrotitular".NUMERO_TITULAR');
               SQL.Add('from "cap$maestro"');
               SQL.Add('LEFT JOIN "cap$maestrotitular" ON ');
               SQL.Add('("cap$maestro".ID_AGENCIA = "cap$maestrotitular".ID_AGENCIA) AND ');
               SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$maestrotitular".ID_TIPO_CAPTACION) AND ');
               SQL.Add('("cap$maestro".NUMERO_CUENTA = "cap$maestrotitular".NUMERO_CUENTA) AND ');
               SQL.Add('("cap$maestro".DIGITO_CUENTA = "cap$maestrotitular".DIGITO_CUENTA)');
               SQL.Add('LEFT JOIN "gen$persona" ON ("cap$maestrotitular".ID_IDENTIFICACION = "gen$persona".ID_IDENTIFICACION) AND ');
               SQL.Add('("cap$maestrotitular".ID_PERSONA = "gen$persona".ID_PERSONA)');
               SQL.Add('where');
               SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
               SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
               SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA and');
               SQL.Add('"cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA');
               SQL.Add('ORDER BY "cap$maestrotitular".NUMERO_TITULAR');
               ParamByName('ID_AGENCIA').AsInteger := Ag;
               ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
               ParamByName('NUMERO_CUENTA').AsInteger := Nm;
               ParamByName('DIGITO_CUENTA').AsInteger := Dg;
               Open;
               XmlRes.Root.WriteString('asociado_titular',FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                                          FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                                          FieldByName('NOMBRE').AsString);

               nodo := XmlRes.Root.NodeNew('titulares');
               while not Eof do
               begin
                 nodo1 := nodo.NodeNew('titular');
                 if FieldByName('NUMERO_TITULAR').AsInteger = 1 then
                 begin
                    id_persona := FieldByName('ID_PERSONA').AsString;
                    id_identificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
                 end;
                 nodo1.WriteString('nombre',FieldByName('ID_IDENTIFICACION').AsString + '-' +
                                                   FieldByName('ID_PERSONA').AsString + '   ' +
                                                   FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                                   FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                                   FieldByName('NOMBRE').AsString);
               if TipoOperacion = 'R' then // verifica si se carga la firma o huella
               begin
               if es_firma = False then
               begin
                 nodo2 := nodo1.NodeNew('datos_huella');
                 nodo2.BinaryEncoding := xbeBase64;
                 nodo2.BinaryString := FieldByName('DATOS_HUELLA').AsString;
               end
               else
               begin
                 nodo2 := nodo1.NodeNew('datos_firma');
                 nodo2.BinaryEncoding := xbeBase64;
                 nodo2.BinaryString := FieldByName('FIRMA').AsString;
               end;
               end;
                 Next;
               end;
               XmlRes.Root.WriteFloat('canje',saldos_cuenta(3).sCanje);
               XmlRes.Root.WriteFloat('saldodisponible',saldos_cuenta(2).sDisponible);
               XmlRes.Root.WriteFloat('saldoactual',saldos_cuenta(1).sActual);
               XmlRes.Root.WriteString('id_persona_titular',id_persona);
               XmlRes.Root.WriteInteger('id_identificacion_titular',id_identificacion);
             end;// fin de la validacion si hay registros
           end    // fin del tipo de consulta
           else if (TipoConsulta = 'I') and (TipoOperacion = 'C') then//consignación
           begin
             es_credito := XmlDoc.Root.ReadBool('es_credito');
             Libreta := XmlDoc.Root.ReadInteger('documento_cap');
             DgA := aportes(XmlDoc.Root.ReadString('id_persona_titular'),XmlDoc.Root.ReadInteger('id_identificacion_titular')).digito;
             NmA := aportes(XmlDoc.Root.ReadString('id_persona_titular'),XmlDoc.Root.ReadInteger('id_identificacion_titular')).cuenta;
             if validar_libreta then
             begin
               Vcomision := 0;
               V_Libreta := True;
               Vbilletes := XmlDoc.Root.ReadFloat('billetes');
               Vmonedas := XmlDoc.Root.ReadFloat('monedas');
               Valor := Vbilletes  + Vmonedas;
               //valor := valor - Vcomision;
               if Valor > 0 then
               begin
               if Tp <> 0 then
               begin
                 if not es_credito then
                 begin
                   //if valor >= Rcomision(15) then
                      //Vcomision := simpleroundto(valor * Rcomision(13),0)
                   //else
                      Vcomision := Rcomision(14);//valor constante de la comision
                 end;
               end;
                 Close;
                 SQL.Clear;
                 SQL.Add('insert into "cap$extracto" values');
                 SQL.Add('(:ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,');
                 SQL.Add(':DIGITO_CUENTA,:FECHA_MOVIMIENTO,:HORA_MOVIMIENTO,');
                 SQL.Add(':ID_TIPO_MOVIMIENTO,:DOCUMENTO_MOVIMIENTO,:DESCRIPCION_MOVIMIENTO,');
                 SQL.Add(':VALOR_DEBITO,:VALOR_CREDITO)');
                 ParamByName('ID_AGENCIA').AsInteger := Ag;
                 ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
                 ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                 ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                 ParamByName('FECHA_MOVIMIENTO').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                 ParamByName('HORA_MOVIMIENTO').AsString := XmlDoc.Root.ReadString('hora_movimiento');
                 ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 1;
                 ParamByName('DOCUMENTO_MOVIMIENTO').AsInteger := libreta;
                 ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'CONSIGNACION EN EFECTIVO DESDE ' + XmlDoc.Root.ReadString('des_agencia');
                 ParamByName('VALOR_DEBITO').AsCurrency := Valor;
                 ParamByName('VALOR_CREDITO').AsCurrency := 0;
                 ExecSQL;
// Grabando Canje Monedas
                 if XmlDoc.Root.ReadFloat('monedas') > 0 then
                 begin
                   Close;
                   SQL.Clear;
                   SQL.Add('insert into "cap$canje"(ID_AGENCIA,ID_TIPO_CAPTACION,NUMERO_CUENTA,');
                   SQL.Add('DIGITO_CUENTA,ID_BANCO,NUMERO_CHEQUE,PLAZA,ID_CAJA,FECHA_ENTRADA,VALOR_CHEQUE,VALOR_MONEDAS,LIBERADO,DEVUELTO,CONSIGNADO)');
                   SQL.Add('values(');
                   SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
                   SQL.Add(':ID_BANCO,:NUMERO_CHEQUE,:PLAZA,:ID_CAJA,:FECHA_ENTRADA,:VALOR_CHEQUE,:VALOR_MONEDAS,:LIBERADO,:DEVUELTO,:CONSIGNADO)');
                   ParamByName('ID_CAJA').AsInteger := XmlDoc.Root.ReadInteger('numero_caja');
                   ParamByName('ID_AGENCIA').AsInteger := Ag;
                   ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
                   ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                   ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                   ParamByName('FECHA_ENTRADA').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                   ParamByName('LIBERADO').AsInteger := 0;
                   ParamByName('DEVUELTO').AsInteger := 0;
                   ParamByName('CONSIGNADO').AsInteger := 0;
                   ParamByName('NUMERO_CHEQUE').AsInteger := 0;
                   ParamByName('ID_BANCO').AsInteger := 0;
                   ParamByName('PLAZA').AsString := '';
                   ParamByName('VALOR_CHEQUE').AsCurrency := 0;
                   ParamByName('VALOR_MONEDAS').AsCurrency := XmlDoc.Root.ReadFloat('monedas');
                   ExecSQL;
                 end;
                end;// fin del valida valor monedas y billetes
                 if XmlDoc.Root.ReadFloat('cheques') > 0 then // valida valor de cheques
                 begin
                   Close;
                   SQL.Clear;
                   SQL.Add('insert into "cap$extracto" values(');
                   SQL.Add(':"ID_AGENCIA",:"ID_TIPO_CAPTACION",:"NUMERO_CUENTA",');
                   SQL.Add(':"DIGITO_CUENTA",:"FECHA_MOVIMIENTO",:"HORA_MOVIMIENTO",');
                   SQL.Add(':"ID_TIPO_MOVIMIENTO",:"DOCUMENTO_MOVIMIENTO",:"DESCRIPCION_MOVIMIENTO",');
                   SQL.Add(':"VALOR_DEBITO",:"VALOR_CREDITO")');
                   ParamByName('ID_AGENCIA').AsInteger := Ag;
                   ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
                   ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                   ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                   ParamByName('FECHA_MOVIMIENTO').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                   ParamByName('HORA_MOVIMIENTO').AsString := XmlDoc.Root.ReadString('hora_movimiento');
                   ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 3;
                   ParamByName('DOCUMENTO_MOVIMIENTO').AsInteger := libreta;
                   ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'CONSIGNACION EN CHEQUE DESDE ' + XmlDoc.Root.ReadString('des_agencia');
                   ParamByName('VALOR_DEBITO').AsCurrency := XmlDoc.Root.ReadFloat('cheques');
                   ParamByName('VALOR_CREDITO').AsCurrency := 0;
                   ExecSQL;
                   Close;
                   SQL.Clear;
                   SQL.Add('insert into "caj$cheques" (ID_CAJA,ID_BANCO,NUMERO_CHEQUE,FECHA,PLAZA,');
                   SQL.Add('VALOR,ID_AGENCIA,ID_TIPO_CUENTA,NUMERO_CUENTA,DIGITO_CUENTA,DOCUMENTO,ENVIADO)');
                   SQL.Add('values(');
                   SQL.Add(':ID_CAJA,:ID_BANCO,:NUMERO_CHEQUE,:FECHA,:PLAZA,');
                   SQL.Add(':VALOR,:ID_AGENCIA,:ID_TIPO_CUENTA,:NUMERO_CUENTA,');
                   SQL.Add(':DIGITO_CUENTA,:DOCUMENTO,:ENVIADO)');
                   ParamByName('ID_CAJA').AsInteger := XmlDoc.Root.ReadInteger('numero_caja');
                   ParamByName('ID_AGENCIA').AsInteger := Ag;
                   ParamByName('ID_TIPO_CUENTA').AsInteger := Tp;
                   ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                   ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                   ParamByName('FECHA').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                   ParamByName('DOCUMENTO').AsInteger := libreta;
                   ParamByName('ENVIADO').AsInteger := 0;
                   IBotros.Close;
                   IBotros.SQL.Clear;
                   IBotros.SQL.Add('insert into "cap$canje"(ID_AGENCIA,ID_TIPO_CAPTACION,NUMERO_CUENTA,');
                   IBotros.SQL.Add('DIGITO_CUENTA,ID_BANCO,NUMERO_CHEQUE,PLAZA,ID_CAJA,FECHA_ENTRADA,VALOR_CHEQUE,VALOR_MONEDAS,LIBERADO,DEVUELTO,CONSIGNADO)');
                   IBotros.SQL.Add('values(');
                   IBotros.SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
                   IBotros.SQL.Add(':ID_BANCO,:NUMERO_CHEQUE,:PLAZA,:ID_CAJA,:FECHA_ENTRADA,:VALOR_CHEQUE,:VALOR_MONEDAS,:LIBERADO,:DEVUELTO,:CONSIGNADO)');
                   IBotros.ParamByName('ID_CAJA').AsInteger := XmlDoc.Root.ReadInteger('numero_caja');
                   IBotros.ParamByName('ID_AGENCIA').AsInteger := Ag;
                   IBotros.ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
                   IBotros.ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                   IBotros.ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                   IBotros.ParamByName('FECHA_ENTRADA').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                   IBotros.ParamByName('LIBERADO').AsInteger := 0;
                   IBotros.ParamByName('DEVUELTO').AsInteger := 0;
                   IBotros.ParamByName('CONSIGNADO').AsInteger := 0;
                   IBotros.ParamByName('VALOR_MONEDAS').AsCurrency := 0;
                   Numero_Cheques := 0;
                   nodo := XmlDoc.Root.NodeByName('rel_cheques');
                   for i := 0 to nodo.NodeCount -1 do
                   begin
                      Numero_Cheques := Numero_Cheques + 1;
                      ParamByName('ID_BANCO').AsInteger := nodo.Nodes[i].ReadInteger('codigo');
                      ParamByName('NUMERO_CHEQUE').AsInteger := nodo.Nodes[i].ReadInteger('numero_cheque');
                      ParamByName('PLAZA').AsString := nodo.Nodes[i].ReadString('plaza');
                      ParamByName('VALOR').AsCurrency := nodo.Nodes[i].ReadFloat('valor');
                      ExecSQL;
                      IBOtros.ParamByName('PLAZA').AsString := nodo.Nodes[i].ReadString('plaza');
                      IBOtros.ParamByName('ID_BANCO').AsInteger := nodo.Nodes[i].ReadInteger('codigo');
                      IBOtros.ParamByName('NUMERO_CHEQUE').AsString := nodo.Nodes[i].ReadString('numero_cheque');
                      IBOtros.ParamByName('VALOR_CHEQUE').AsCurrency := nodo.Nodes[i].ReadFloat('valor');
                      IBotros.ExecSQL;
                   end; // fin del for
                 end;// fin del valida cheques
// registro del movimiento de entrada
                 if Vcomision < VBilletes then
                    VbilletesComision := Vcomision
                 else if Vcomision < Vmonedas then
                    VmonedasComision := Vcomision;
//** registro del movimiento principal total del mvimineto
                 SQL.Clear;
                 cadena := 'insert into "caj$movremotoentrada" values (' + XmlDoc.Root.ReadString('numero_caja') +
                  ',' + '''' + FormatDateTime('yyyy/mm/dd',XmlDoc.Root.ReadDateTime('fecha_movimiento')) + ' ' +
                  XmlDoc.Root.ReadString('hora_movimiento') + '''' + ',' + IntToStr(Ag) + ',' + IntToStr(Tp) + ',' +
                  IntToStr(Nm) + ',' + IntToStr(Dg) + ',' + XmlDoc.Root.ReadString('origenm') + ',' + '1' + ',' +
                  XmlDoc.Root.ReadString('documento_cap') + ',' + IntToStr(Numero_Cheques) + ',' + CurrToStr(Vbilletes) +
                   ',' + CurrToStr(Vmonedas) + ',' + CurrToStr(Vcheques) + ',' + IntToStr(XmlDoc.Root.ReadInteger('agencia_remota'))
                   + ',' + IntToStr(Bool(es_credito)) + ',' + '0' + ')';
                 //SQL.SaveToFile('c:\cadena.txt');
                 SQL.Add(cadena);
                 ExecSQL;
                 if Vcomision > 0 then
                 begin
//*** registro en la cuenta de aportes del valor total de la comision
//*** CAMBIO REALIZADO POR INGRESOS
                   {SQL.Clear;
                   cadena := 'insert into "caj$movremotoentrada" values (' + XmlDoc.Root.ReadString('numero_caja') + ',' + '''' + FormatDateTime('yyyy/mm/dd',XmlDoc.Root.ReadDateTime('fecha_movimiento')) + ' ' + XmlDoc.Root.ReadString('hora_movimiento') + '''' +
                   ',' + IntToStr(Ag) + ',' + IntToStr(1) + ',' + IntToStr(NmA) + ',' + IntToStr(DgA) + ',' + '1' + ',' +
                   '1' + ',' + XmlDoc.Root.ReadString('documento_cap') + ',' + IntToStr(0) + ',' + CurrToStr(VbilletesComision) + ',' + CurrToStr(VmonedasComision) + ',' +
                   CurrToStr(VchequesComision) + ',' + IntToStr(XmlDoc.Root.ReadInteger('agencia_remota')) + ',' + '0' + ',' + '1' + ')';
                   //SQL.SaveToFile('c:\cadena.txt');
                   SQL.Add(cadena);
                   ExecSQL;}
//*** CAMBIO REALIZADO POR INGRESOS
//** se registra la salida del valor de la comision
                   vOrigenMov := XmlDoc.Root.ReadString('origenm');
                   vTpVerifica  := 0;
                   if tp = 1 then
                   begin
                     Dg := aportesR(XmlDoc.Root.ReadString('id_persona_titular'),XmlDoc.Root.ReadInteger('id_identificacion_titular')).digito;
                     Nm := aportesR(XmlDoc.Root.ReadString('id_persona_titular'),XmlDoc.Root.ReadInteger('id_identificacion_titular')).cuenta;
                     vOrigenMov := '2';
                     vTpVerifica  := 1;
                     tp := 2;
                   end;
                   SQL.Clear;
                   cadena := 'insert into "caj$movremotoentrada" values (' + XmlDoc.Root.ReadString('numero_caja') +
                   ',' + '''' + FormatDateTime('yyyy/mm/dd',XmlDoc.Root.ReadDateTime('fecha_movimiento')) + ' ' +
                   XmlDoc.Root.ReadString('hora_movimiento') + '''' + ',' + IntToStr(Ag) + ',' + IntToStr(Tp) + ',' +
                   IntToStr(Nm) + ',' + IntToStr(Dg) + ',' + vOrigenMov + ',' + '2' + ',' +
                   XmlDoc.Root.ReadString('documento_cap') + ',' + IntToStr(0) + ',' + CurrToStr(VbilletesComision) +
                   ',' + CurrToStr(VmonedasComision) + ',' + CurrToStr(VchequesComision) + ',' +
                   IntToStr(XmlDoc.Root.ReadInteger('agencia_remota')) + ',' + '0' + ',' + '1' + ')';
                   //SQL.SaveToFile('c:\cadena.txt');
                   SQL.Add(cadena);
                   ExecSQL;
//** retiro del valor de la comision de la cuenta de ahorros//  QUITAR COMENTARIOS
                   Close;
                   SQL.Clear;
                   SQL.Add('insert into "cap$extracto" values');
                   SQL.Add('(:ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,');
                   SQL.Add(':DIGITO_CUENTA,:FECHA_MOVIMIENTO,:HORA_MOVIMIENTO,');
                   SQL.Add(':ID_TIPO_MOVIMIENTO,:DOCUMENTO_MOVIMIENTO,:DESCRIPCION_MOVIMIENTO,');
                   SQL.Add(':VALOR_DEBITO,:VALOR_CREDITO)');
                   ParamByName('ID_AGENCIA').AsInteger := Ag;
                   ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
                   ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                   ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                   ParamByName('FECHA_MOVIMIENTO').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                   ParamByName('HORA_MOVIMIENTO').AsString := XmlDoc.Root.ReadString('hora_movimiento');
                   ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 27;
                   ParamByName('DOCUMENTO_MOVIMIENTO').AsInteger := libreta;
                   ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'COMISION X CONSIG. DESDE ' + XmlDoc.Root.ReadString('des_agencia');
                   ParamByName('VALOR_DEBITO').AsCurrency := 0;
                   ParamByName('VALOR_CREDITO').AsCurrency := Vcomision;
                   ExecSQL;
//** consignacion de la comision en cuenta de aportes.
//** CAMBIO DE APORTES POR INGRESO
                  {Close;
                   SQL.Clear;
                   SQL.Add('insert into "cap$extracto" values');
                   SQL.Add('(:ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,');
                   SQL.Add(':DIGITO_CUENTA,:FECHA_MOVIMIENTO,:HORA_MOVIMIENTO,');
                   SQL.Add(':ID_TIPO_MOVIMIENTO,:DOCUMENTO_MOVIMIENTO,:DESCRIPCION_MOVIMIENTO,');
                   SQL.Add(':VALOR_DEBITO,:VALOR_CREDITO)');
                   ParamByName('ID_AGENCIA').AsInteger := Ag;
                   ParamByName('ID_TIPO_CAPTACION').AsInteger := 1;
                   ParamByName('NUMERO_CUENTA').AsInteger := NmA;
                   ParamByName('DIGITO_CUENTA').AsInteger := DgA;//Dg;
                   ParamByName('FECHA_MOVIMIENTO').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                   ParamByName('HORA_MOVIMIENTO').AsString := XmlDoc.Root.ReadString('hora_movimiento');
                   ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 27;
                   ParamByName('DOCUMENTO_MOVIMIENTO').AsInteger := libreta;
                   ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'COMISION X CONSIG. DESDE ' + XmlDoc.Root.ReadString('des_agencia');
                   ParamByName('VALOR_DEBITO').AsCurrency := Vcomision;
                   ParamByName('VALOR_CREDITO').AsCurrency := 0;
                   ExecSQL;}
                   if vTpVerifica  = 1 then
                   begin
                     Dg := aportes(XmlDoc.Root.ReadString('id_persona_titular'),XmlDoc.Root.ReadInteger('id_identificacion_titular')).digito;
                     Nm := aportes(XmlDoc.Root.ReadString('id_persona_titular'),XmlDoc.Root.ReadInteger('id_identificacion_titular')).cuenta;
                     tp := 1;
                   end;

//** CAMBIO REALIZADO POR INGRESOS
                 end;// fin valida comision
//***  libretas usadas
                  libretas_usadas;
//*** libretas usadas
                 //IBconexion.Commit(IBTransaction);
             end // fin del valida libreta
             else
             V_Libreta := False;
           end//fin tipo consulta = I tipo operacion = C
           else
           begin if (TipoConsulta = 'I') and (TipoOperacion = 'R') then // PARA RETIROS
             v_General := XmlDoc.Root.ReadFloat('billetes') + XmlDoc.Root.ReadFloat('monedas') + XmlDoc.Root.ReadFloat('cheques');
             Libreta := XmlDoc.Root.ReadInteger('documento_cap');
             V_Libreta := True;
             DgA := aportes(XmlDoc.Root.ReadString('id_persona_titular'),XmlDoc.Root.ReadInteger('id_identificacion_titular')).digito;
             NmA := aportes(XmlDoc.Root.ReadString('id_persona_titular'),XmlDoc.Root.ReadInteger('id_identificacion_titular')).cuenta;
             if validar_libreta then
             begin
              Close;
              SQL.Clear;
              SQL.Add('Select * from "cap$tipocaptacion"');
              SQL.Add('where ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION');
              ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
              Open;
              contador := 0;
              while not Eof do
              begin
                 contador := contador + 1;
                 Next;
              end;
              First;
              if contador < 1 then
              begin
                Mensaje := 'El tipo de captación no existe, Consulte con sistemas'+#13+
                        'Operación no registrada';
                V_Libreta := False;
              end;
              if (V_Libreta) and (FieldByName('RETIRO_PARCIAL').AsInteger = 0)  then
              begin
                Mensaje := 'Este tipo de captación, no permite retiros parciales'+#13+
                       'Por Favor verifique su operación';
                V_Libreta := False;
              end;
              if V_Libreta then// CONTINUA CON EL PROCESO DE RETIRO
              begin
                 Es_Autorizado := XmlDoc.Root.ReadBool('autorizado');
                 Es_Servicaja := XmlDoc.Root.ReadBool('servicaja');
// leer topes autorizados y retiros autorizados
                if es_autorizado then
                begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select * from "caj$maxautorizado" where SERVICAJA = 0');
                 Open;
                 contador := 0;
                 while not Eof do
                 begin
                   contador := contador + 1;
                   Next;
                 end;
                 First;
                 if contador > 0 then
                 begin
                   TopeTotalOp := FieldByName('CANTIDAD').AsInteger;
                   TopeValorOp := FieldByName('VALOR').AsCurrency;
                 end
                 else
                 begin
                   TopeTotalOp := 2;
                   TopeValorOp := 5000000;
                 end;
                 Close;
                 SQL.Clear;
                 SQL.Add('select * from "caj$maxautorizado" where SERVICAJA = 1');
                 Open;
                 contador := 0;
                 while not Eof do
                 begin
                   contador := contador + 1;
                   Next;
                 end;
                 First;
                 if contador > 0 then
                 begin
                   TopeTotalOpS := FieldByName('CANTIDAD').AsInteger;
                   TopeValorOpS := FieldByName('VALOR').AsCurrency;
                 end
                 else
                 begin
                   TopeTotalOpS := 2;
                   TopeValorOpS := 2500000;
                 end;
// fin de topes autorizados
// validar retiros autorizados
                 Close;
                 SQL.Clear;
                 SQL.Add('select COUNT(*) as TOTAL from "caj$retiroautorizado"');
                 SQL.Add('where ID_AGENCIA = :ID_AGENCIA and ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                 SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and DIGITO_CUENTA = :DIGITO_CUENTA and FECHA_MOV = :FECHA_MOV');
                 ParamByName('ID_AGENCIA').AsInteger := Ag;
                 ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
                 ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                 ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                 ParamByName('FECHA_MOV').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                 Open;
                 contador := 0;
                 while not Eof do
                 begin
                    contador := contador + 1;
                    Next;
                 end;
                 first;
                 if contador > 0 then
                 begin
                   TotalOp := FieldByName('TOTAL').AsInteger;
                   TotalOpS := FieldByName('TOTAL').AsInteger;
                 end
                 else
                 begin
                    TotalOp  := 0;
                    TotalOpS := 0;
                 end;
// validacion de retiros en caja normal
                 if not Servicaja then
                 begin
                   if v_General > TopeValorOp then
                   begin
                      Mensaje := 'Un autorizado no puede retirar esa cantidad';
                      V_Libreta := False;
                   end
                   else if (TotalOp + 1) > TopeTotalOp then
                   begin
                      Mensaje := 'Ya se realizaron el máximo de operaciones para autorizados, no puede retirar';
                      V_Libreta := False;
                   end
                   else if ValorOp >= (TopeTotalOp * TopeValorOp) then
                   begin
                      Mensaje := 'Ya se realizaron el máximo de operaciones para autorizados, no puede retirar';
                      V_Libreta := False;
                   end
                   else if (ValorOp + v_General) > (TopeTotalOp * TopeValorOp) then
                   begin
                      Mensaje := 'No puede retirar esa cantidad como autorizado';
                      V_Libreta := False;
                   end;
                end
                else
                begin
                  if v_General > TopeValorOpS then
                  begin
                    Mensaje := 'Un autorizado no puede retirar esa cantidad';
                    V_Libreta := False;
                 end
                 else if (TotalOp + 1) > TopeTotalOpS then
                 begin
                    Mensaje := 'Ya se realizaron el máximo de operaciones para autorizados, no puede retirar';
                    V_Libreta := False;
                 end
                 else if ValorOpS >= (TopeTotalOpS * TopeValorOpS) then
                 begin
                    Mensaje := 'Ya se realizaron el máximo de operaciones para autorizados, no puede retirar';
                    V_Libreta := False;
                 end
                 else if (ValorOpS + v_General) > (TopeTotalOpS * TopeValorOpS) then
                 begin
                    Mensaje := 'No puede retirar esa cantidad como autorizado';
                    V_Libreta := False;
                 end;
             end;
          end;// fin valida retiros autorizaos
// Fin Validación Retiros Autorizados
// comienzo del registro del movimiento
           if V_Libreta then
           begin
               es_credito := XmlDoc.Root.ReadBool('es_credito');
               Vcomision := 0;
               Vbilletes := XmlDoc.Root.ReadFloat('billetes');
               Vmonedas := XmlDoc.Root.ReadFloat('monedas');
               Valor := Vbilletes  + Vmonedas;
               if Valor > 0 then
               begin
                 //if valor >= Rcomision(15) then
                   // Vcomision := simpleroundto(Valor * Rcomision(13),0)
                 //else
                    Vcomision := Rcomision(14);//cambio a valor constante de la comision por ingresos
                 if Vbilletes > Vcomision then
                    VbilletesComision := Vcomision
                 else
                      VmonedasComision := Vcomision;
                 Close;
                 SQL.Clear;
                 SQL.Add('insert into "cap$extracto" values');
                 SQL.Add('(:ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,');
                 SQL.Add(':DIGITO_CUENTA,:FECHA_MOVIMIENTO,:HORA_MOVIMIENTO,');
                 SQL.Add(':ID_TIPO_MOVIMIENTO,:DOCUMENTO_MOVIMIENTO,:DESCRIPCION_MOVIMIENTO,');
                 SQL.Add(':VALOR_DEBITO,:VALOR_CREDITO)');
                 ParamByName('ID_AGENCIA').AsInteger := Ag;
                 ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
                 ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                 ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                 ParamByName('FECHA_MOVIMIENTO').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                 ParamByName('HORA_MOVIMIENTO').AsString := XmlDoc.Root.ReadString('hora_movimiento');
                 ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 2;
                 ParamByName('DOCUMENTO_MOVIMIENTO').AsInteger := libreta;
                 ParamByName('DESCRIPCION_MOVIMIENTO').AsString := XmlDoc.Root.ReadString('desc_movimiento');
                 ParamByName('VALOR_DEBITO').AsCurrency := 0;
                 ParamByName('VALOR_CREDITO').AsCurrency := Valor;
                 ExecSQL;
// valida valor de cheques
                 {if XmlDoc.Root.ReadFloat('cheques') > 0 then
                 begin
                   Close;
                   ParamByName('ID_AGENCIA').AsInteger := Ag;
                   ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
                   ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                   ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                   ParamByName('FECHA_MOVIMIENTO').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                   ParamByName('HORA_MOVIMIENTO').AsString := XmlDoc.Root.ReadString('hora_movimiento');
                   ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 2;
                   ParamByName('DOCUMENTO_MOVIMIENTO').AsInteger := libreta;
                   ParamByName('DESCRIPCION_MOVIMIENTO').AsString := XmlDoc.Root.ReadString('desc_movimiento');
                   ParamByName('VALOR_DEBITO').AsCurrency := 0;
                   ParamByName('VALOR_CREDITO').AsCurrency := Valor;
                   ExecSQL;
                 end;}
// verifica si la cuenta es para saldar
                 if XmlDoc.Root.ReadBool('parasaldar') then
                 begin
                  Close;
                  SQL.Clear;
                  SQL.Add('update "cap$maestro" set ID_ESTADO = 2');
                  SQL.Add('where ID_AGENCIA = :"ID_AGENCIA" and ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" and ');
                  SQL.Add('NUMERO_CUENTA = :"NUMERO_CUENTA" and DIGITO_CUENTA = :"DIGITO_CUENTA"');
                  ParamByName('ID_AGENCIA').AsInteger := Ag;
                  ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
                  ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                  ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                  ExecSQL;
                 end;
// se registra el movimiento
               Close;
               SQL.Clear;
               cadena := 'insert into "caj$movremotoentrada" values (' + XmlDoc.Root.ReadString('numero_caja') + ',' + '''' + FormatDateTime('yyyy/mm/dd',XmlDoc.Root.ReadDateTime('fecha_movimiento')) + ' ' + XmlDoc.Root.ReadString('hora_movimiento') + '''' +
               ',' + IntToStr(Ag) + ',' + IntToStr(Tp) + ',' + IntToStr(Nm) + ',' + IntToStr(Dg) + ',' + XmlDoc.Root.ReadString('origenm') + ',' +
               '2' + ',' + XmlDoc.Root.ReadString('documento_cap') + ',' + IntToStr(Numero_Cheques) + ',' + CurrToStr(Vbilletes) + ',' + CurrToStr(Vmonedas) + ',' +
               CurrToStr(Vcheques) + ',' + IntToStr(XmlDoc.Root.ReadInteger('agencia_remota')) + ',' + '0' + ',' + '0' + ')';
               //SQL.SaveToFile('c:\cadena.txt');
               SQL.Add(cadena);
               ExecSQL;
//** se registra el movimiento del retiro de la comision
               Close;
               SQL.Clear;
               cadena := 'insert into "caj$movremotoentrada" values (' + XmlDoc.Root.ReadString('numero_caja') + ',' + '''' + FormatDateTime('yyyy/mm/dd',XmlDoc.Root.ReadDateTime('fecha_movimiento')) + ' ' + XmlDoc.Root.ReadString('hora_movimiento') + '''' +
               ',' + IntToStr(Ag) + ',' + IntToStr(Tp) + ',' + IntToStr(Nm) + ',' + IntToStr(Dg) + ',' + XmlDoc.Root.ReadString('origenm') + ',' +
               '2' + ',' + XmlDoc.Root.ReadString('documento_cap') + ',' + IntToStr(0) + ',' + CurrToStr(VbilletesComision) + ',' + CurrToStr(VmonedasComision) + ',' +
               CurrToStr(VchequesComision) + ',' + IntToStr(XmlDoc.Root.ReadInteger('agencia_remota')) + ',' + '0' + ',' + '1' + ')';
               //SQL.SaveToFile('c:\cadena.txt');
               SQL.Add(cadena);
               ExecSQL;
//****         se registra el valor de la comision en la cuenta de aportes
//*** CAMBIO REALIZADO POR INGRESOS
               {Close;
               SQL.Clear;
               cadena := 'insert into "caj$movremotoentrada" values (' + XmlDoc.Root.ReadString('numero_caja') + ',' + '''' + FormatDateTime('yyyy/mm/dd',XmlDoc.Root.ReadDateTime('fecha_movimiento')) + ' ' + XmlDoc.Root.ReadString('hora_movimiento') + '''' +
               ',' + IntToStr(Ag) + ',' + IntToStr(1) + ',' + IntToStr(NmA) + ',' + IntToStr(DgA) + ',' + '1' + ',' +
               '1' + ',' + XmlDoc.Root.ReadString('documento_cap') + ',' + IntToStr(0) + ',' + CurrToStr(VbilletesComision) + ',' + CurrToStr(VmonedasComision) + ',' +
               CurrToStr(VchequesComision) + ',' + IntToStr(XmlDoc.Root.ReadInteger('agencia_remota')) + ',' + '0' + ',' + '1' +')';
               //SQL.SaveToFile('c:\cadena.txt');
               SQL.Add(cadena);
               ExecSQL;}
//** CAMBIO REALIZADO POR INGRESOS
               libretas_usadas;// se registra el numero del talon en la tabla libretas usadas
//** se descuenta el valor de la comision de la cuenta
               Close;
               SQL.Clear;
               SQL.Add('insert into "cap$extracto" values');
               SQL.Add('(:ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,');
               SQL.Add(':DIGITO_CUENTA,:FECHA_MOVIMIENTO,:HORA_MOVIMIENTO,');
               SQL.Add(':ID_TIPO_MOVIMIENTO,:DOCUMENTO_MOVIMIENTO,:DESCRIPCION_MOVIMIENTO,');
               SQL.Add(':VALOR_DEBITO,:VALOR_CREDITO)');
               ParamByName('ID_AGENCIA').AsInteger := Ag;
               ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
               ParamByName('NUMERO_CUENTA').AsInteger := Nm;
               ParamByName('DIGITO_CUENTA').AsInteger := Dg;
               ParamByName('FECHA_MOVIMIENTO').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
               ParamByName('HORA_MOVIMIENTO').AsString := XmlDoc.Root.ReadString('hora_movimiento');
               ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 27;
               ParamByName('DOCUMENTO_MOVIMIENTO').AsInteger := libreta;
               ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'COMISION X ' + XmlDoc.Root.ReadString('desc_movimiento');
               ParamByName('VALOR_DEBITO').AsCurrency := 0;
               ParamByName('VALOR_CREDITO').AsCurrency := Vcomision;
               ExecSQL;
//** se registra el valor de la comision en la cuenta de aportes
//*** CAMBIOS REALIZADOS POR INGRESOS
               {Close;
               SQL.Clear;
               SQL.Add('insert into "cap$extracto" values');
               SQL.Add('(:ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,');
               SQL.Add(':DIGITO_CUENTA,:FECHA_MOVIMIENTO,:HORA_MOVIMIENTO,');
               SQL.Add(':ID_TIPO_MOVIMIENTO,:DOCUMENTO_MOVIMIENTO,:DESCRIPCION_MOVIMIENTO,');
               SQL.Add(':VALOR_DEBITO,:VALOR_CREDITO)');
               ParamByName('ID_AGENCIA').AsInteger := Ag;
               ParamByName('ID_TIPO_CAPTACION').AsInteger := 1;
               ParamByName('NUMERO_CUENTA').AsInteger := NmA;
               ParamByName('DIGITO_CUENTA').AsInteger := DgA;
               ParamByName('FECHA_MOVIMIENTO').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
               ParamByName('HORA_MOVIMIENTO').AsString := XmlDoc.Root.ReadString('hora_movimiento');
               ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 27;
               ParamByName('DOCUMENTO_MOVIMIENTO').AsInteger := libreta;
               ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'COMISION X ' + XmlDoc.Root.ReadString('desc_movimiento');
               ParamByName('VALOR_DEBITO').AsCurrency := Vcomision;;
               ParamByName('VALOR_CREDITO').AsCurrency := 0;
               ExecSQL;}
//***          fin del registro del valor de la comision
               if XmlDoc.Root.ReadBool('autorizado') then
               begin
                 close;
                 SQL.Clear;
                 SQL.Add('insert into "caj$retiroautorizado" values(');
                 SQL.Add(':ID_TIPO_CAPTACION,:ID_AGENCIA,:NUMERO_CUENTA,:DIGITO_CUENTA,');
                 SQL.Add(':FECHA_MOV,:DOCUMENTO,:EFECTIVO,:SERVICAJA)');
                 ParamByName('ID_AGENCIA').AsInteger := Ag;
                 ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
                 ParamByName('NUMERO_CUENTA').AsInteger := Nm;
                 ParamByName('DIGITO_CUENTA').AsInteger := Dg;
                 ParamByName('FECHA_MOV').AsDate := XmlDoc.Root.ReadDateTime('fecha_movimiento');
                 ParamByName('DOCUMENTO').AsString := IntToStr(Libreta);
                 ParamByName('EFECTIVO').AsCurrency := v_General;
                 ParamByName('SERVICAJA').AsInteger := XmlDoc.Root.ReadInteger('servicaja');
                 ExecSQL;
               end;
               //IBconexion.Commit(IBTransaction);
// fin del valor total del retiro
             end;
          end;//  fin del segundo v_libreta
              end;// fin del valida libreta
              end
             else
               V_Libreta := False;
           end;
           if (TipoConsulta = 'I')  then
           begin
             if V_Libreta then
             begin
               //IBconexion.StartTransaction(IBTransaction);
               XmlRes.Root.WriteBool('ejecutado',True);
               XmlRes.Root.WriteBool('v_libreta',True);
               XmlRes.Root.WriteFloat('saldoactual',saldos_cuenta(1).sActual);
               XmlRes.Root.WriteFloat('comision',Vcomision);
               XmlRes.Root.WriteFloat('billetes',VbilletesComision);
               XmlRes.Root.WriteFloat('monedas',VmonedasComision);
               XmlRes.Root.WriteFloat('cheques',VchequesComision);
               XmlRes.Root.WriteInteger('c_aportes',NmA);
               XmlRes.Root.WriteInteger('d_aportes',DgA);
               //IBconexion.commit(IBTransaction);
             end
             else
             begin
               XmlRes.Root.WriteBool('ejecutado',True);
               XmlRes.Root.WriteBool('v_libreta',False);
               XmlRes.Root.WriteString('mensaje',Mensaje);
             end;
           end;
           except// validacion de errores
           on e: Exception do
           begin
             Mensaje := 'Error Durante Operación ' + #13 + e.Message;
             //IBconexion.Rollback(IBTransaction);
             XmlRes.Clear;
             XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
             XmlRes.EncodingString := 'ISO8859-1';
             XmlRes.XmlFormat := xfReadable;
             XmlRes.Root.WriteBool('ejecutado',false);
             XmlRes.Root.WriteString('mensaje',Mensaje);
           end;// fin de la excepción
           end;// fin del try
        end;// fin del with de ibconsulta
        Astream1 := TMemoryStream.Create;
        Astream := TMemoryStream.Create;
        xmlres.SaveToStream(Astream1);
        if es_firma then
          CompressStream(Astream1,Astream)// cambiar por CompressStream(Astream1,Astream);
        else
          Astream := Astream1;
        AThreads.Connection.WriteInteger(Astream.size);
        AThreads.Connection.OpenWriteBuffer;
        AThreads.Connection.WriteStream(Astream);
        AThreads.Connection.CloseWriteBuffer;
        IBconexion.Close;
end;
procedure TFrmservercajas.IdTCPServer1Execute(AThread: TIdPeerThread);
var     id_transaction,i :Integer;
begin
{        for i := 1 to 255 do
        begin
           if numero[i] = false then
           begin
             id_transaction := i;
             numero[i] := true;
             break;
           end;
        end;

}
          if Athread.Connection.RecvBufferSize > 0 then
          begin
            server(Athread,Athread.ThreadID);
            Athread.Connection.Disconnect;
            //sleep(1000);
          end;
//        numero[id_transaction] := false;
end;
procedure TFrmservercajas.IPhostReply(ASender: TComponent;
  const AReplyStatus: TReplyStatus);
begin
        //if AReplyStatus.ReplyStatusType = rsTimeOut then
        //   Hay_conexion := False;
end;

procedure TFrmservercajas.BitBtn1Click(Sender: TObject);
begin
        close;
end;


end.
