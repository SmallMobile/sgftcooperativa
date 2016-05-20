unit Unitservercajas;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, IdBaseComponent, IdComponent, IdTCPServer, IdThreadMgr,
  IdThreadMgrDefault, DBXpress, DB, SqlExpr, FMTBcd,sdXmlDocuments,StrUtils,DateUtils;type
  Saldos = record
    sDisponible :Currency;
    sActual :Currency;
    sCanje :Currency;
  end;
type
  TFrmservercajas = class(TForm)
    IdTCPServer1: TIdTCPServer;
    IdThreadMgrDefault1: TIdThreadMgrDefault;
    SQLConnection1: TSQLConnection;
    Label1: TLabel;
    base: TLabel;
    Label2: TLabel;
    Tiempo: TLabel;
    SQLQuery1: TSQLQuery;
    SQLStoredProc1: TSQLStoredProc;
    Mregistro: TMemo;
    Label3: TLabel;
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
  private
  IDpuerto :Integer;
    IDtiempo: Integer;
    DBserver: String;
    DBpath: String;
    DBname: String;
    archivo :TextFile;
    MiIni :string;
    //variables de captacion
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
    nodo,nodo1 :TXmlNode;
    function validar_libreta: boolean;
    function saldos_cuenta(opcion :Smallint): saldos;
    procedure Libretas_Usadas;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmservercajas: TFrmservercajas;

implementation
uses IniFiles;

{$R *.xfm}

procedure TFrmservercajas.IdTCPServer1Execute(AThread: TIdPeerThread);
var

    IBconsulta :TSQLQuery;
    IBconexion :TSQLConnection;
    IBTransaction :TTransactionDesc;
    id_transaccion :Integer;
    Astream,Astream1,Astream2 :TMemoryStream;
    tamano :Integer;
    numerocuenta :string;
    TipoConsulta :string;
    contador :Integer;
    id_persona :string;
    id_identificacion :Integer;
    Dbalias :string;
    Vhora :TDateTime;
    i :Integer;
    Numero_Cheques :Integer;
    cadena :string;
    es_firma :Boolean;
begin
        cadena := '';
        ShortDateFormat := 'yyyy/MM/dd';
        IBconexion := TSQLConnection.Create(nil);
        {with IBconexion do
        begin
          ConnectionName := 'IBlocal';
          DriverName := 'Interbase';
          GetDriverFunc := 'getSQLDriverINTERBASE';
          KeepConnection := True;
          LibraryName := 'libsqlib.so.1';
          LoadParamsOnConnect := False;
          LoginPrompt := False;
          Params.Append('Database='+DBServer+':'+DBPath+DBName);
          Params.Append('User_Name=sysdba');
          Params.Append('Password=masterkey');
          Params.Append('ServerCharSet=ISO8859_1');
          Params.Append('SQLDialect=3');
          Params.Append('BlobSize=-1');
          Params.Append('CommitRetain=False');
          Params.Append('LocaleCode=0000');
          Params.Append('Interbase TransIsolation=ReadCommited');
          Params.Append('WaitOnLocks=True');
          VendorLib := 'libgds.so.0';
        end;}
        with IBconexion do
        begin
          ConnectionName := 'conexion';
          DriverName := 'Interbase';
          GetDriverFunc := 'getSQLDriverINTERBASE';
          LibraryName := 'dbexpint.dll';
          LoginPrompt := False;
          Params.Append('Database='+DBServer+':'+DBPath+DBName);
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
        IBconsulta := TSQLQuery.Create(nil);
        IBlibretas := TSQLQuery.Create(nil);
        IBotros := TSQLQuery.Create(nil);
        IBprocedimiento := TSQLStoredProc.Create(nil);
        IBprocedimiento.SQLConnection := IBconexion;
        IBconsulta.SQLConnection := IBconexion;
        IBlibretas.SQLConnection := IBconexion;
        IBotros.SQLConnection := IBconexion;
        id_transaccion := Random(1000) + 1 + StrToInt(FormatDateTime('s',Time));
        IBTransaction.TransactionID := id_transaccion;
        IBTransaction.IsolationLevel := xilREADCOMMITTED;
        IBconexion.StartTransaction(IBTransaction);
        XmlDoc := TsdXmlDocument.CreateName('datos');// xml de llegada
        XmlDoc.EncodingString := 'ISO8859-1';
        XmlDoc.XmlFormat := xfReadable;
        XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
        XmlRes.EncodingString := 'ISO8859-1';
        XmlRes.XmlFormat := xfReadable;
        Astream := TMemoryStream.Create;
        tamano := AThread.Connection.ReadInteger;
        AThread.Connection.ReadStream(Astream,tamano,False);
        XmlDoc.LoadFromStream(Astream);
        numerocuenta := XmlDoc.Root.ReadString('numerocuenta');
        TipoConsulta := XmlDoc.Root.ReadString('tipoconsulta');
        TipoOperacion := XmlDoc.Root.ReadString('tipooperacion');
        es_firma := XmlDoc.Root.ReadBool('firma');
        Dbalias := XmlDoc.Root.ReadString('dbalias');
        Ag := 1;//StrToInt(MidStr(numerocuenta,1,1));
        Tp := StrToInt(MidStr(numerocuenta,2,1));
        Nm := StrToInt(MidStr(numerocuenta,3,7));
        Dg := StrToInt(MidStr(numerocuenta,10,1));
        contador := 0;
        IBprocedimiento.StoredProcName := 'SP_FECHA_ACTUAL';
        IBprocedimiento.ExecProc;
        fFechaActual := IBprocedimiento.ParamByName('FECHA').AsDate;
        IBprocedimiento.StoredProcName := 'SP_HORA_ACTUAL';
        IBprocedimiento.ExecProc;
        Vhora := IBprocedimiento.ParamByName('HORA').AsTime;
        with IBconsulta do
        begin
          try
           if TipoConsulta = 'S' then
           begin
             Close;
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
               XmlRes.Root.WriteInteger('permite_movimiento',FieldByName('PERMITE_MOVIMIENTO').AsInteger);
               XmlRes.Root.WriteInteger('permite_movimiento_entrada',FieldByName('PERMITE_MOVIMIENTO_ENTRADA').AsInteger);
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
               if TipoOperacion = 'R' then // verifica si se carga la firma o huella
               begin
               if es_firma = False then
               begin
                 nodo := XmlRes.Root.NodeNew('datos_huella');
                 nodo.BinaryEncoding := xbeBase64;
                 nodo.BinaryString := FieldByName('DATOS_HUELLA').AsString;
               end
               else
               begin
                 nodo := XmlRes.Root.NodeNew('datos_firma');
                 nodo.BinaryEncoding := xbeBase64;
                 nodo.BinaryString := FieldByName('FIRMA').AsString;
               end;
               end;
               nodo := XmlRes.Root.NodeNew('titulares');
               while not Eof do
               begin
                 nodo1 := nodo.NodeNew('titular');
                 if FieldByName('NUMERO_TITULAR').AsInteger = 1 then
                 begin
                    id_persona := FieldByName('ID_PERSONA').AsString;
                 end;
                 nodo1.WriteString('titular',FieldByName('ID_IDENTIFICACION').AsString + '-' +
                                                   FieldByName('ID_PERSONA').AsString + '   ' +
                                                   FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                                   FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                                   FieldByName('NOMBRE').AsString);
                 Next;
               end;
               XmlRes.Root.WriteFloat('canje',saldos_cuenta(3).sCanje);
               XmlRes.Root.WriteFloat('saldodisponible',saldos_cuenta(2).sDisponible);
               XmlRes.Root.WriteFloat('saldoactual',saldos_cuenta(1).sActual);
             end;// fin de la validacion si hay registros
           end    // fin del tipo de consulta
           else if (TipoConsulta = 'I') and (TipoOperacion = 'C') then//consignación
           begin
             Libreta := XmlDoc.Root.ReadInteger('documento_cap');
             if validar_libreta then
             begin
               V_Libreta := True;
               Valor := XmlDoc.Root.ReadFloat('billetes') + XmlDoc.Root.ReadFloat('monedas');
               if Valor > 0 then
               begin
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
// registro del movimineto de entrada
                 SQL.Clear;
                 cadena := 'insert into "caj$movremotoentrada" values (' + XmlDoc.Root.ReadString('numero_caja') + ',' + '''' + FormatDateTime('yyyy/mm/dd',XmlDoc.Root.ReadDateTime('fecha_movimiento')) + ' ' + XmlDoc.Root.ReadString('hora_movimiento') + '''' +
                 ',' + IntToStr(Ag) + ',' + IntToStr(Tp) + ',' + IntToStr(Nm) + ',' + IntToStr(Dg) + ',' + XmlDoc.Root.ReadString('origenm') + ',' +
                 '1' + ',' + XmlDoc.Root.ReadString('documento_cap') + ',' + IntToStr(Numero_Cheques) + ',' + CurrToStr(XmlDoc.Root.ReadFloat('billetes')) + ',' + CurrToStr(XmlDoc.Root.ReadFloat('monedas')) + ',' +
                 CurrToStr(XmlDoc.Root.ReadFloat('cheques')) + ',' + IntToStr(XmlDoc.Root.ReadInteger('agencia_remota')) + ')';
                 SQL.SaveToFile('c:\cadena.txt');
                 SQL.Add(cadena);
                 ExecSQL;
//***  libretas usadas
                  libretas_usadas;
//*** libretas usadas
                 IBconexion.Commit(IBTransaction);
                 IBconexion.StartTransaction(IBTransaction);
             end // fin del valida libreta
             else
             V_Libreta := False;
           end//fin tipo consulta = I tipo operacion = C
           else
           begin if (TipoConsulta = 'I') and (TipoOperacion = 'R') then // PARA RETIROS
           v_General := XmlDoc.Root.ReadFloat('billetes') + XmlDoc.Root.ReadFloat('monedas') + XmlDoc.Root.ReadFloat('cheques');
             Libreta := XmlDoc.Root.ReadInteger('documento_cap');
             V_Libreta := True;
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
// Fin Validación Retiros Autorizados
// comienzo del regsitro del movimiento
           if V_Libreta then
           begin
               Valor := XmlDoc.Root.ReadFloat('billetes') + XmlDoc.Root.ReadFloat('monedas');
               if Valor > 0 then
               begin
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
                 ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'RETIRO EN EFECTIVO DESDE ' + XmlDoc.Root.ReadString('des_agencia');
                 ParamByName('VALOR_DEBITO').AsCurrency := 0;
                 ParamByName('VALOR_CREDITO').AsCurrency := Valor;
                 ExecSQL;
// valida valor de cheques
                 if XmlDoc.Root.ReadFloat('cheques') > 0 then
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
                   ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'RETIRO EN EFECTIVO DESDE ' + XmlDoc.Root.ReadString('des_agencia');
                   ParamByName('VALOR_DEBITO').AsCurrency := 0;
                   ParamByName('VALOR_CREDITO').AsCurrency := Valor;
                   ExecSQL;
                 end;
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
               '2' + ',' + XmlDoc.Root.ReadString('documento_cap') + ',' + IntToStr(Numero_Cheques) + ',' + CurrToStr(XmlDoc.Root.ReadFloat('billetes')) + ',' + CurrToStr(XmlDoc.Root.ReadFloat('monedas')) + ',' +
               CurrToStr(XmlDoc.Root.ReadFloat('cheques')) + ',' + IntToStr(XmlDoc.Root.ReadInteger('agencia_remota')) + ')';
               SQL.SaveToFile('c:\cadena.txt');
               SQL.Add(cadena);
               ExecSQL;
               libretas_usadas;
               if XmlDoc.Root.ReadBool('autorizado') then
               begin
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
               end;
                 IBconexion.Commit(IBTransaction);
                 IBconexion.StartTransaction(IBTransaction);
// fin del valor total del retiro
             end;
          end;//  fin del segundo v_libreta
              end;// fin del valida libreta
              end
             else
               V_Libreta := False;
           end;
           if TipoConsulta <> 'S' then
           begin
             if V_Libreta then
             begin
               XmlRes.Root.WriteBool('ejecutado',True);
               XmlRes.Root.WriteBool('v_libreta',True);
               XmlRes.Root.WriteFloat('saldoactual',saldos_cuenta(1).sActual);
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
             IBconexion.Rollback(IBTransaction);
             XmlRes.Clear;
             XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
             XmlRes.EncodingString := 'ISO8859-1';
             XmlRes.XmlFormat := xfReadable;
             XmlRes.Root.WriteBool('ejecutado',false);
             XmlRes.Root.WriteString('mensaje',Mensaje);
           end;// fin de la excepción
           end;// fin del try
        end;// fin del with de ibconsulta
        Mregistro.Lines.Add(TipoOperacion + ' ' + TipoConsulta + ' ' + FormatDateTime('yyyy/mm/dd',fFechaActual) + ' ' + Formatdatetime('hh:mm AM/PM',Vhora) + ' ' + numerocuenta + ' ' + Dbalias);
        Astream1 := TMemoryStream.Create;
        Astream := TMemoryStream.Create;
        xmlres.SaveToStream(Astream1);
        astream1.SaveToFile('c:\ini.xml');
        if es_firma then
//          zCompressStream(Astream1,Astream)// cambiar por CompressStream(Astream1,Astream);
        else
          Astream := Astream1;
        Astream.Position := 0;
        Astream.Seek(0,0);
        Astream2 := TMemoryStream.Create;
//        ZDecompressStream(Astream,astream2);
        astream2.Seek(0,0);
        astream2.SaveToFile('c:\eje.xml');
        Astream2.SaveToFile('c:\res_caja1.txt');
        AThread.Connection.WriteInteger(Astream.size);
        AThread.Connection.OpenWriteBuffer;
        AThread.Connection.WriteStream(Astream);
        AThread.Connection.CloseWriteBuffer;

end;

procedure TFrmservercajas.FormCreate(Sender: TObject);
var    Archivo_respaldo :string;
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
     end;
     IdTCPServer1.TerminateWaitTime := IDtiempo;
     IdTCPServer1.DefaultPort := IDpuerto;
     IdTCPServer1.Active := True;
     Base.Caption := DBServer + ':' + DBPath + DBName;
     Tiempo.Caption := IntToStr(IDtiempo) + ' Milisegundos Puerto ' + IntToStr(IDpuerto);
end;

function TFrmservercajas.validar_libreta: Boolean;
var     usado:Boolean;
        contador :Integer;
begin
        Result := True;
        usado := False;
        with IBlibretas do
        begin
             Close;
             SQL.Clear;
             if TipoOperacion = 'C' then begin
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

function TFrmservercajas.saldos_cuenta(opcion :Smallint): saldos;
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

procedure TFrmservercajas.Libretas_Usadas;
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

end.
