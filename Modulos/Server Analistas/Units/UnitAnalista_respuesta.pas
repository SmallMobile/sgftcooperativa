unit UnitAnalista_respuesta;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, IdThreadMgr, IdThreadMgrDefault, IdBaseComponent, IdComponent,
  IdTCPServer, IBDatabase, DB, IBSQL, sdXmlDocuments , IBCustomDataSet,
  IBQuery, DBXpress, SqlExpr, FMTBcd, DateUtils, QExtCtrls, QDBCtrls,
  AbZipper, AbBase, AbBrowse, AbZBrows, AbUnzper,AbArcTyp;

type
  TFrmServer_Analistas = class(TForm)
    IdTCPServer1: TIdTCPServer;
    IdThreadMgrDefault1: TIdThreadMgrDefault;
    Memo1: TMemo;
    SQLQuery1: TSQLQuery;
    SQLConnection1: TSQLConnection;
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
  private
  saldo_inicial, saldo_actual, total_canje, total_movimiento, saldo_cdat :Currency;
  cuenta, agencia, tipo :Integer;
  MiIni :string;
  DBServer :string;
  DBPath :string;
  DBName :string;
  Item : TAbArchiveItem;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmServer_Analistas: TFrmServer_Analistas;

implementation
uses IniFiles;

{$R *.xfm}

procedure TFrmServer_Analistas.IdTCPServer1Execute(AThread: TIdPeerThread);
type
  PMyList = ^AList;
  AList = record
    id_ident: Integer;
    id_pers: string;
end;
var     IBconsulta,IBextracto :TSQLQuery;
        IBTconsulta :TTransactionDesc;
        XmlDoc, XmlRes :TsdXmlDocument;
        Astream :TStringStream;
        tamano :Integer;
        nodo,nodo1 :TXmlNode;
        id_solicitud :string;
        id_tipo :string;
        id_modulo :string;
        tipo_codeudor :string;
        i,contador :Integer;
        numero_observacion :string;
        MyList: TList;
        ARecord: PMyList;
        Vaportes :Currency;
        Vcontractual :Currency;
        Vcdat :Currency;
        Vahorros :Currency;
        Vjuvenil :Currency;
        id_persona :string;
        id_identificacion :Integer;
        Vcuenta :string;
        id_transaccion :Cardinal;
        IBconexion :TSQLConnection;
        Blargo :Integer;
        fStream :string;
begin
        IBconexion := TSQLConnection.Create(nil);
        with IBconexion do
        begin
          ConnectionName := 'IBlocal';
          DriverName := 'Interbase';
          GetDriverFunc := 'getSQLDriverINTERBASE';
          KeepConnection := True;
          LibraryName := 'dbexpint.dll';
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
          VendorLib := 'GDS32.DLL';
        end;
        Vaportes := 0;
        Vcontractual :=0;
        Vcdat := 0;
        Vahorros := 0;
        Vjuvenil := 0;
        contador := 0;
        MyList := TList.Create;// ENUMERA EL DEUDOR Y LOS CODEUDORES
        XmlDoc := TsdXmlDocument.CreateName('solicitud');// xml de llegada
        XmlDoc.EncodingString := 'ISO8859-1';
        XmlDoc.XmlFormat := xfReadable;
        XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
        XmlRes.EncodingString := 'ISO8859-1';
        XmlRes.XmlFormat := xfReadable;
        Astream := TStringStream.Create('');
        tamano := AThread.Connection.ReadInteger;
        AThread.Connection.ReadStream(Astream,tamano,False);
        XmlDoc.LoadFromStream(Astream);
        XmlDoc.SaveToFile('c:\xml\ressolicitud.xml');
        IBconsulta := TSQLQuery.Create(nil);
        IBextracto := TSQLQuery.Create(nil);
        IBconsulta.SQLConnection := IBconexion;
        IBextracto.SQLConnection := IBconexion;
        IBconexion.Open;
        id_transaccion := Random(1000) + 1 + StrToInt(FormatDateTime('s',Time));
        IBTconsulta.TransactionID := id_transaccion;
        IBTconsulta.IsolationLevel := xilREADCOMMITTED;
        IBconexion.StartTransaction(IBTconsulta);
        id_solicitud := XmlDoc.Root.ReadString('id_solicitud');// NUMERO DE SOLICITUD
        id_tipo := XmlDoc.Root.ReadString('id_tipo');// O CONSULTA 1 ACTUALZIACION
        id_modulo := XmlDoc.Root.ReadString('id_modulo');// A ANALISIS E ENTE APROBADOR
        Memo1.Lines.Add('Solicitud = ' + id_solicitud + '  Tipo = ' + id_tipo + '  Modulo = ' + id_modulo + ' Env.');
       try
        with IBconsulta do
        begin
        if id_tipo = '0' then // define el tipo de proceso 0-consulta 1-update o insert
        begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT DISTINCT');
            SQL.Add('"col$solicitud".ID_PERSONA,');
            SQL.Add('"col$solicitud".ID_IDENTIFICACION,');
            SQL.Add('"col$solicitud".VALOR_SOLICITADO,');
            SQL.Add('"col$solicitud".LINEA,');
            SQL.Add('"col$solicitud".PLAZO,');
            SQL.Add('"col$solicitud".ESTADO,');
            SQL.Add('"col$solicitud".PAGO_INTERES,');
            SQL.Add('"col$solicitud".FECHA_RECEPCION,');
            SQL.Add('"col$solicitud".DESTINO,');
            SQL.Add('"col$solicitud".ID_EMPLEADO,');
            SQL.Add('"col$solicitud".ENTE_APROBADOR,');
            SQL.Add('"col$solicitud".TASA_INTERES,');
            SQL.Add('"col$solicitud".PLAZO_APROBADO,');
            SQL.Add('"col$solicitud".DESCRIPCION_GARANTIA,');
            SQL.Add('"col$solicitud".NUMERO_CODEUDORES,');
            SQL.Add('"col$solicitud".VALOR_APROBADO,');
            SQL.Add('"col$solicitud".GARANTIA,');
            SQL.Add('"col$solicitud".ID_ANALISIS,');
            SQL.Add('"col$solicitud".EXP_CREDITOS,');
            SQL.Add('"col$solicitud".AMORTIZACION,');
            SQL.Add('"col$solicitud".INGRESOS,');
            SQL.Add('"col$solicitud".DISPONIBLE,');
            SQL.Add('"col$solicitud".SOLV_ECONOMICA,');
            SQL.Add('"col$solicitud".EXP_CREDITOS,');
            SQL.Add('"col$solicitud".DEDUCCIONES,');
            SQL.Add('"col$solicitud".VALOR_CUOTA,');
            SQL.Add('"col$solicitud".DISPONIBILIDAD,');
            SQL.Add('"col$solicitud".INVERSION,');
            SQL.Add('"col$solicitud".CLASIFICACION,');
            SQL.Add('"col$solicitud".TIPO_CUOTA,');
            SQL.Add('"col$solicitud".RESPALDO,');
            SQL.Add('"gen$persona".NOMBRE,');
            SQL.Add('"gen$persona".PRIMER_APELLIDO,');
            SQL.Add('"gen$persona".SEGUNDO_APELLIDO,');
            SQL.Add('"gen$persona".INGRESOS_A_PRINCIPAL,');
            SQL.Add('"gen$persona".INGRESOS_OTROS,');
            SQL.Add('"gen$persona".EGRESOS_ALQUILER,');
            SQL.Add('"gen$persona".EGRESOS_SERVICIOS,');
            SQL.Add('"gen$persona".EGRESOS_TRANSPORTE,');
            SQL.Add('"gen$persona".EGRESOS_ALIMENTACION,');
            SQL.Add('"gen$persona".EGRESOS_DEUDAS,');
            SQL.Add('"gen$persona".FOTO,');
            SQL.Add('"gen$persona".EGRESOS_OTROS');
            SQL.Add('FROM');
            SQL.Add('"col$solicitud"');
            SQL.Add('INNER JOIN "gen$persona" ON ("col$solicitud".ID_PERSONA = "gen$persona".ID_PERSONA) AND ("gen$persona".ID_IDENTIFICACION = "col$solicitud".ID_IDENTIFICACION)');
            SQL.Add('WHERE');
            SQL.Add('("col$solicitud".ID_SOLICITUD = :ID_SOLICITUD)');
            parambyname('ID_SOLICITUD').AsString := id_solicitud;
            Open;
            while not Eof do
            begin
              contador := contador + 1;
              Next;
            end;
            if contador = 0 then
            begin
              nodo := XmlRes.Root.NodeNew('solicitud');
              nodo.WriteString('encontrado','false');
            end
            else
            begin
              First;
              if id_modulo = 'E' then
              begin
                nodo := XmlRes.Root.NodeNew('foto');
                nodo.BinaryEncoding := xbeBase64;
                nodo.BinaryString := FieldByName('FOTO').AsString;
              end;
              nodo := XmlRes.Root.NodeNew('solicitud');
              nodo.WriteString('encontrado','True');
              nodo.WriteInteger('tipo_cuota',FieldByName('TIPO_CUOTA').AsInteger);
              nodo.WriteInteger('respaldo',FieldByName('RESPALDO').AsInteger);
              nodo.WriteString('id_persona',FieldByName('ID_PERSONA').AsString);
              nodo.WriteInteger('id_identificacion',FieldByName('ID_IDENTIFICACION').AsInteger);
              nodo.WriteString('valor_solicitado',FieldByName('VALOR_SOLICITADO').AsString);
              nodo.WriteString('linea',FieldByName('LINEA').AsString);
              nodo.WriteString('plazo',FieldByName('PLAZO').AsString);
              nodo.WriteString('estado',FieldByName('ESTADO').AsString);
              nodo.WriteString('pago_interes',FieldByName('PAGO_INTERES').AsString);
              nodo.WriteString('fecha_recepcion',FieldByName('FECHA_RECEPCION').AsString);
              nodo.WriteString('destino',FieldByName('DESTINO').AsString);
              nodo.WriteString('id_empleado',FieldByName('ID_EMPLEADO').AsString);
              nodo.WriteString('ente_aprobador',FieldByName('ENTE_APROBADOR').AsString);
              nodo.WriteString('tasa_interes',FieldByName('TASA_INTERES').AsString);
              nodo.WriteString('plazo_aprobado',FieldByName('PLAZO_APROBADO').AsString);
              nodo.WriteString('numero_codeudores',FieldByName('NUMERO_CODEUDORES').AsString);
              nodo.WriteString('valor_aprobado',FieldByName('VALOR_APROBADO').AsString);
              nodo.WriteString('id_analisis',FieldByName('ID_ANALISIS').AsString);
              nodo.WriteString('exp_creditos',FieldByName('EXP_CREDITOS').AsString);
              nodo.WriteString('amortizacion',FieldByName('AMORTIZACION').AsString);
              nodo.WriteString('nombre',FieldByName('NOMBRE').AsString);
              nodo.WriteString('p_apellido',FieldByName('PRIMER_APELLIDO').AsString);
              nodo.WriteString('s_apellido',FieldByName('SEGUNDO_APELLIDO').AsString);
              nodo.WriteFloat('ingresos',FieldByName('INGRESOS').AsFloat);
              nodo.WriteFloat('disponible',FieldByName('DISPONIBLE').AsFloat);
              nodo.WriteString('solv_economica',FieldByName('SOLV_ECONOMICA').AsString);
              nodo.WriteString('exp_creditos',FieldByName('EXP_CREDITOS').AsString);
              nodo.WriteFloat('deducciones',FieldByName('DEDUCCIONES').AsFloat);
              nodo.WriteFloat('valor_cuota',FieldByName('VALOR_CUOTA').AsFloat);
              nodo.WriteFloat('disponibilidad',FieldByName('DISPONIBILIDAD').AsFloat);
              nodo.WriteString('clasificacion',FieldByName('CLASIFICACION').AsString);
              nodo.WriteString('inversion',FieldByName('INVERSION').AsString);
              nodo.WriteString('garantia',FieldByName('GARANTIA').AsString);
              nodo.WriteString('des_garantia',FieldByName('DESCRIPCION_GARANTIA').AsString);
              nodo.WriteFloat('ingresos_p',FieldByName('INGRESOS_A_PRINCIPAL').AsCurrency);
              nodo.WriteFloat('otros_ingresos',FieldByName('INGRESOS_OTROS').AsCurrency);
              nodo.WriteFloat('alquiler',FieldByName('EGRESOS_ALQUILER').AsCurrency);
              nodo.WriteFloat('servicios',FieldByName('EGRESOS_SERVICIOS').AsCurrency);
              nodo.WriteFloat('transporte',FieldByName('EGRESOS_TRANSPORTE').AsCurrency);
              nodo.WriteFloat('alimentacion',FieldByName('EGRESOS_ALIMENTACION').AsCurrency);
              nodo.WriteFloat('deudas',FieldByName('EGRESOS_DEUDAS').AsCurrency);
              nodo.WriteFloat('otros_egresos',FieldByName('EGRESOS_OTROS').AsCurrency);
              New(Arecord);
              ARecord^.id_ident := FieldByName('ID_IDENTIFICACION').AsInteger;
              ARecord^.id_pers := FieldByName('ID_PERSONA').AsString;
              id_persona := FieldByName('ID_PERSONA').AsString;
              id_identificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
              MyList.Add(ARecord);
              Close;
              nodo := XmlRes.Root.NodeNew('codeudores');
              SQL.Clear;
              SQL.Add('SELECT');
              SQL.Add('"col$codeudor".ID_PERSONA,');
              SQL.Add('"col$codeudor".ID_IDENTIFICACION,');
              SQL.Add('"gen$persona".NOMBRE,');
              SQL.Add('"gen$persona".PRIMER_APELLIDO,');
              SQL.Add('"gen$persona".SEGUNDO_APELLIDO,');
              SQL.Add('"col$codeudor".ES_CONYUGUE,');
              SQL.Add('"col$codeudor".INGRESOS,');
              SQL.Add('"col$codeudor".DISPONIBLE,');
              SQL.Add('"col$codeudor".DEDUCCIONES,');
              SQL.Add('"col$codeudor".VALOR_CUOTA,');
              SQL.Add('"col$codeudor".DISP_PAGO,');
              SQL.Add('"col$codeudor".SOLV_ECONOMICA,');
              SQL.Add('"col$codeudor".EXP_CREDITOS,');
              SQL.Add('"col$codeudor".ID_ENTRADA,');
              SQL.Add('"gen$persona".INGRESOS_A_PRINCIPAL,');
              SQL.Add('"gen$persona".INGRESOS_OTROS,');
              SQL.Add('"gen$persona".EGRESOS_ALQUILER,');
              SQL.Add('"gen$persona".EGRESOS_SERVICIOS,');
              SQL.Add('"gen$persona".EGRESOS_TRANSPORTE,');
              SQL.Add('"gen$persona".EGRESOS_ALIMENTACION,');
              SQL.Add('"gen$persona".EGRESOS_DEUDAS,');
              SQL.Add('"gen$persona".EGRESOS_OTROS');
              SQL.Add('FROM');
              SQL.Add('"gen$persona"');
              SQL.Add('INNER JOIN "col$codeudor" ON ("gen$persona".ID_IDENTIFICACION = "col$codeudor".ID_IDENTIFICACION) AND ("gen$persona".ID_PERSONA = "col$codeudor".ID_PERSONA)');
              SQL.Add('WHERE');
              SQL.Add('("col$codeudor".ID_SOLICITUD = :ID_SOLICITUD)');
              SQL.Add('ORDER BY');
              SQL.Add('"col$codeudor".ID_ENTRADA');
              ParamByName('ID_SOLICITUD').AsString := id_solicitud;
              Open;
              while not Eof do
              begin
                if Abs(FieldByName('ES_CONYUGUE').AsInteger) = 1 then
                   tipo_codeudor := 'conyuge'
                else
                   tipo_codeudor := 'codeudor';
                nodo1 := nodo.NodeNew(tipo_codeudor);
                nodo1.WriteString('id_persona',FieldByName('ID_PERSONA').AsString);
                nodo1.WriteString('id_identificacion',FieldByName('ID_IDENTIFICACION').AsString);
                nodo1.WriteString('es_conyuge',FieldByName('ES_CONYUGUE').AsString);
                nodo1.WriteString('ingresos',FieldByName('INGRESOS').AsString);
                nodo1.WriteString('disponible',FieldByName('DISPONIBLE').AsString);
                nodo1.WriteString('deducciones',FieldByName('DEDUCCIONES').AsString);
                nodo1.WriteString('valor_cuota',FieldByName('VALOR_CUOTA').AsString);
                nodo1.WriteString('disponibilidad',FieldByName('DISP_PAGO').AsString);
                nodo1.WriteString('solv_economica',FieldByName('SOLV_ECONOMICA').AsString);
                nodo1.WriteString('exp_creditos',FieldByName('EXP_CREDITOS').AsString);
                nodo1.WriteString('id_entrada',FieldByName('ID_ENTRADA').AsString);
                nodo1.WriteString('nombre'FieldByName('NOMBRE').AsString + ' ' +FieldByName('PRIMER_APELLIDO').AsString + ' ' +FieldByName('SEGUNDO_APELLIDO').AsString);
                nodo1.WriteFloat('ingresos_p',FieldByName('INGRESOS_A_PRINCIPAL').AsCurrency);
                nodo1.WriteFloat('otros_ingresos',FieldByName('INGRESOS_OTROS').AsCurrency);
                nodo1.WriteFloat('alquiler',FieldByName('EGRESOS_ALQUILER').AsCurrency);
                nodo1.WriteFloat('servicios',FieldByName('EGRESOS_SERVICIOS').AsCurrency);
                nodo1.WriteFloat('transporte',FieldByName('EGRESOS_TRANSPORTE').AsCurrency);
                nodo1.WriteFloat('alimentacion',FieldByName('EGRESOS_ALIMENTACION').AsCurrency);
                nodo1.WriteFloat('deudas',FieldByName('EGRESOS_DEUDAS').AsCurrency);
                nodo1.WriteFloat('otros_egresos',FieldByName('EGRESOS_OTROS').AsCurrency);
                New(Arecord);
                ARecord^.id_ident := FieldByName('ID_IDENTIFICACION').AsInteger;
                ARecord^.id_pers := FieldByName('ID_PERSONA').AsString;
                MyList.Add(ARecord);
              Next;
              end;
              {ShowMessage(IntToStr(nodo.NodeCount));
              for i := 0 to nodo.NodeCount -1 do
              begin
                Memo1.Lines.Add(nodo.Nodes[i].Name + ' ' + nodo.Nodes[i].ReadString('nombre')); //:= nodo1.Name;
                //for j := 0 to nodo.Nodes[i].NodeCount - 1 do
                  //Memo1.Lines.Add()
              end;}
              nodo := XmlRes.Root.NodeNew('observaciones');
              Close;
              SQL.Clear;
              SQL.Add('SELECT *');
              SQL.Add('FROM');
              SQL.Add('"col$observacion"');
              SQL.Add('WHERE');
              SQL.Add('("col$observacion".ID_SOLICITUD = :ID_SOLICITUD)');
              SQL.Add('order by ID_OBSERVACION');
              ParamByName('ID_SOLICITUD').AsString := id_solicitud;
              Open;
              while not Eof do
              begin
                numero_observacion := 'observacion';
                nodo1  := nodo.NodeNew(numero_observacion);
                nodo1.WriteString('tipo',FieldByName('ID_OBSERVACION').AsString);
                nodo1.WriteString('observacion',FieldByName('OBSERVACION').AsString);
                Next;
              end;
              nodo := XmlRes.Root.NodeNew('colocaciones');
             for i := 0 to MyList.Count - 1 do
             begin
               ARecord := MyList[i];
               Close;
               SQL.Clear;
               SQL.Add('SELECT');
               SQL.Add('"col$estado".DESCRIPCION_ESTADO_COLOCACION,');
               SQL.Add('"col$colocacion".ID_COLOCACION,');
               SQL.Add('"col$colocacion".VALOR_CUOTA,"col$colocacion".VALOR_DESEMBOLSO,');
               SQL.Add('"col$colocacion".FECHA_CAPITAL,');
               SQL.Add('"col$colocacion".FECHA_INTERES,');
               SQL.Add('("col$colocacion".VALOR_DESEMBOLSO - "col$colocacion".ABONOS_CAPITAL) AS SALDO');
               SQL.Add('FROM');
               SQL.Add('"col$colocacion"');
               SQL.Add('INNER JOIN "col$estado" ON ("col$colocacion".ID_ESTADO_COLOCACION = "col$estado".ID_ESTADO_COLOCACION)');
               SQL.Add('WHERE');
               SQL.Add('("col$colocacion".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND');
               SQL.Add('("col$colocacion".ID_PERSONA = :ID_PERSONA) AND');
               SQL.Add('("col$colocacion".ID_ESTADO_COLOCACION NOT IN (4,5,8,7))');
               ParamByName('ID_PERSONA').AsString := Arecord^.id_pers;
               ParamByName('ID_IDENTIFICACION').AsInteger := Arecord^.id_ident;
               Open;
               while not Eof do
               begin
                 nodo1 := nodo.NodeNew('colocacion');
                 nodo1.WriteString('id_colocacion',FieldByName('ID_COLOCACION').AsString);
                 nodo1.WriteString('estado',FieldByName('DESCRIPCION_ESTADO_COLOCACION').AsString);
                 nodo1.WriteString('valor_cuota',FieldByName('VALOR_CUOTA').AsString);
                 nodo1.WriteString('valor_desembolso',FieldByName('VALOR_DESEMBOLSO').AsString);
                 nodo1.WriteString('fecha_capital',FieldByName('FECHA_CAPITAL').AsString);
                 nodo1.WriteString('fecha_interes',FieldByName('FECHA_INTERES').AsString);
                 nodo1.WriteString('saldo',FieldByName('SALDO').AsString);
                 nodo1.WriteString('id_persona',arecord^.id_pers);
                 nodo1.WriteString('id_identificacion',IntToStr(arecord^.id_ident));
                 Next;
               end;
             end;
              nodo := XmlRes.Root.NodeNew('fianzas');
             for i := 0 to MyList.Count - 1 do
             begin
              ARecord := MyList[i];
              Close;
              SQL.Clear;
              SQL.Add('SELECT');
              SQL.Add('("col$colocacion".VALOR_DESEMBOLSO-"col$colocacion".ABONOS_CAPITAL) AS SALDO,"col$colocacion".FECHA_INTERES,');
              SQL.Add('"col$colocacion".ID_COLOCACION,"col$colocacion".VALOR_DESEMBOLSO,"col$colocacion".VALOR_CUOTA,');
              SQL.Add('"col$estado".DESCRIPCION_ESTADO_COLOCACION');
              SQL.Add('FROM');
              SQL.Add('"col$colgarantias"');
              SQL.Add('INNER JOIN "col$colocacion" ON ("col$colgarantias".ID_COLOCACION = "col$colocacion".ID_COLOCACION) AND ("col$colgarantias".ID_AGENCIA = "col$colocacion".ID_AGENCIA)');
              SQL.Add('INNER JOIN "col$estado" ON ("col$colocacion".ID_ESTADO_COLOCACION = "col$estado".ID_ESTADO_COLOCACION)');
              SQL.Add('WHERE');
              SQL.Add('("col$colgarantias".ID_PERSONA = :ID_PERSONA) AND');
              SQL.Add('("col$colgarantias".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND');
              SQL.Add('("col$colocacion".ID_ESTADO_COLOCACION NOT IN (7,8,5,4))');
              ParamByName('ID_PERSONA').AsString := arecord^.id_pers;
              ParamByName('ID_IDENTIFICACION').AsInteger := arecord^.id_ident;
              Open;
              while not Eof do
              begin
                 nodo1 := nodo.NodeNew('fianza');
                 nodo1.WriteString('id_colocacion',FieldByName('ID_COLOCACION').AsString);
                 nodo1.WriteString('estado',FieldByName('DESCRIPCION_ESTADO_COLOCACION').AsString);
                 nodo1.WriteString('fecha_interes',FieldByName('FECHA_INTERES').AsString);
                 nodo1.WriteString('saldo',FieldByName('SALDO').AsString);
                 nodo1.WriteString('id_persona',arecord^.id_pers);
                 nodo1.WriteString('id_identificacion',IntToStr(arecord^.id_ident));
                 nodo1.WriteString('valor_desembolso',FieldByName('VALOR_DESEMBOLSO').AsString);
                 nodo1.WriteString('valor_cuota',FieldByName('VALOR_CUOTA').AsString);
                Next;
              end;
             end;
             nodo := XmlRes.Root.NodeNew('descuentos');
             Close;
             SQL.Clear;
             SQL.Add('SELECT');
             SQL.Add('"gen$infcrediticia".ID_COLOCACION');
             SQL.Add('FROM');
             SQL.Add('"gen$infcrediticia"');
             SQL.Add('WHERE');
             SQL.Add('("gen$infcrediticia".ID_SOLICITUD = :ID_SOLICITUD) AND');
             SQL.Add('("gen$infcrediticia".ES_DESCUENTO = 1)');
             ParamByName('ID_SOLICITUD').AsString := id_solicitud;
             Open;
             while not Eof do
             begin
               nodo1 := nodo.NodeNew('colocacion');
               nodo1.WriteString('colocacion',FieldByName('ID_COLOCACION').AsString);
               Next;
             end;
             ////////*******INICIO DE CONSULTA EXTRACTOS
              SQL.Clear;
              SQL.Add('Select "cap$maestrotitular".ID_AGENCIA,"cap$maestrotitular".ID_TIPO_CAPTACION,"cap$maestrotitular".NUMERO_CUENTA,"cap$maestrotitular".DIGITO_CUENTA from "cap$maestrotitular"');
              SQL.Add('Where');
              SQL.Add('"cap$maestrotitular".ID_IDENTIFICACION = :ID_IDENTIFICACION and');
              SQL.Add('"cap$maestrotitular".ID_PERSONA = :ID_PERSONA and');
              SQL.Add('"cap$maestrotitular".ID_TIPO_CAPTACION >= 1');
              ParamByName('ID_IDENTIFICACION').AsInteger := Id_identificacion;
              ParamByName('ID_PERSONA').AsString  := id_persona;
              Open;
              while not Eof do
              begin
                tipo := FieldByName('ID_TIPO_CAPTACION').AsInteger;
                cuenta := FieldByName('NUMERO_CUENTA').AsInteger;
                agencia := FieldByName('ID_AGENCIA').AsInteger;
                total_movimiento := 0;
                saldo_inicial := 0;
                saldo_actual := 0;
                total_canje := 0;
                saldo_cdat := 0;
                with IBextracto do
                begin
                  Close;
                  if tipo = 6 then
                  begin
                    SQL.Clear;
                    SQL.Add('SELECT DISTINCT');
                    SQL.Add('"cap$maestro".VALOR_INICIAL');
                    SQL.Add('FROM');
                    SQL.Add('"cap$maestro"');
                    SQL.Add('WHERE');
                    SQL.Add('("cap$maestro".ID_AGENCIA = :ID_AGENCIA) AND');
                    SQL.Add('("cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA) AND');
                    SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = :TIPO)AND');
                    SQL.Add('("cap$maestro".ID_ESTADO IN (1,6))');
                    ParamByName('ID_AGENCIA').AsInteger := agencia;
                    ParamByName('TIPO').AsInteger := tipo;
                    ParamByName('NUMERO_CUENTA').AsInteger := cuenta;
                    Open;
                    Saldo_cdat := FieldByName('VALOR_INICIAL').AsCurrency;
                    Close;
                  end
                  else
                  begin
                  SQL.Clear;
                  SQL.Add('Select "cap$maestrosaldoinicial".SALDO_INICIAL from "cap$maestro"');
                  SQL.Add('LEFT JOIN "cap$maestrosaldoinicial" ON ("cap$maestro".ID_AGENCIA = "cap$maestrosaldoinicial".ID_AGENCIA) AND ');
                  SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$maestrosaldoinicial".ID_TIPO_CAPTACION) AND ');
                  SQL.Add('("cap$maestro".NUMERO_CUENTA = "cap$maestrosaldoinicial".NUMERO_CUENTA) AND ("cap$maestro".DIGITO_CUENTA = "cap$maestrosaldoinicial".DIGITO_CUENTA)');
                  SQL.Add('INNER JOIN "cap$tiposestado" ON ("cap$maestro".ID_ESTADO = "cap$tiposestado".ID_ESTADO)');
                  SQL.Add('Where');
                  SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
                  SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                  SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA and');
                  SQL.Add('"cap$maestro".ID_ESTADO in (1,6) and');
                  SQL.Add('"cap$maestrosaldoinicial".ANO = :ANO');
                  ParamByName('ID_AGENCIA').AsInteger := agencia;
                  ParamByName('ID_TIPO_CAPTACION').AsInteger := tipo;
                  ParamByName('NUMERO_CUENTA').AsInteger := cuenta;
                  ParamByName('ANO').AsString := IntToStr(YearOf(Date));
                  Open;
                  Saldo_Inicial := FieldByName('SALDO_INICIAL').AsCurrency;
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT SUM("cap$extracto".VALOR_DEBITO - "cap$extracto".VALOR_CREDITO) AS SUMA from "cap$maestro"');
                  SQL.Add('LEFT JOIN "cap$extracto" ON ("cap$maestro".ID_AGENCIA = "cap$extracto".ID_AGENCIA) AND ');
                  SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$extracto".ID_TIPO_CAPTACION) AND ');
                  SQL.Add('("cap$maestro".NUMERO_CUENTA = "cap$extracto".NUMERO_CUENTA) AND ("cap$maestro".DIGITO_CUENTA = "cap$extracto".DIGITO_CUENTA)');
                  SQL.Add('Where');
                  SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
                  SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                  SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA and');
                  SQL.Add('"cap$maestro".ID_ESTADO in (1,6) and');
                  SQL.Add('"cap$extracto".FECHA_MOVIMIENTO BETWEEN :FECHA1 and :FECHA2');
                  ParamByName('ID_AGENCIA').AsInteger := agencia;
                  ParamByName('ID_TIPO_CAPTACION').AsInteger := tipo;
                  ParamByName('NUMERO_CUENTA').AsInteger := cuenta;
                  ParamByName('FECHA1').AsDate := EncodeDate(YearOf(Date),01,01);
                  ParamByName('FECHA2').AsDate := EncodeDate(YearOf(Date),12,31);
                  Open;
                  Saldo_Actual := FieldByName('SUMA').AsCurrency;
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT SUM("cap$canje".VALOR_CHEQUE + "cap$canje".VALOR_MONEDAS) AS CANJE');
                  SQL.Add('FROM');
                  SQL.Add('"cap$maestro"');
                  SQL.Add('LEFT JOIN "cap$canje" ON ("cap$maestro".ID_AGENCIA = "cap$canje".ID_AGENCIA) AND ');
                  SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$canje".ID_TIPO_CAPTACION) AND ("cap$maestro".NUMERO_CUENTA = "cap$canje".NUMERO_CUENTA) AND ("cap$maestro".DIGITO_CUENTA = "cap$canje".DIGITO_CUENTA)');
                  SQL.Add('Where');
                  SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
                  SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                  SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA and');
                  SQL.Add('"cap$maestro".ID_ESTADO = 1 and');
                  SQL.Add('"cap$canje".LIBERADO = 0 and');
                  SQL.Add('"cap$canje".DEVUELTO = 0');
                  ParamByName('ID_AGENCIA').AsInteger := agencia;
                  ParamByName('ID_TIPO_CAPTACION').AsInteger := Tipo;
                  ParamByName('NUMERO_CUENTA').AsInteger := cuenta;
                  Open;
                  total_canje := FieldByName('CANJE').AsCurrency;
                 end;
                 total_movimiento := Saldo_Actual + saldo_inicial + total_canje;
                 end;
              if tipo = 1 then
              begin
                 Vaportes := Vaportes + total_movimiento;
                 Vcuenta := IntToStr(cuenta);
              end
              else if tipo = 2 then
                 Vahorros := Vaportes + total_movimiento
              else if tipo = 5 then
                Vcontractual := Vcontractual + total_movimiento
              else if tipo = 4 then
                Vjuvenil := Vjuvenil + total_movimiento
              else if tipo = 6 then
                Vcdat := Vcdat + saldo_cdat;;
                Next;
              end;
            SQL.Clear;
            SQL.Add('select count(*) as CONTADOR from "col$colocacion"');
            SQL.Add('where ID_PERSONA = :ID_PERSONA and');
            SQL.Add('ID_IDENTIFICACION = :ID_IDENTIFICACION');
            ParamByName('ID_PERSONA').AsString := id_persona;
            ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
            Open;
            nodo := XmlRes.Root.NodeNew('extracto');
            if FieldByName('CONTADOR').AsInteger > 0 then
               nodo.WriteBool('creditos',True)
            else
               nodo.WriteBool('creditos',False);
            ///////********FIN CONSULTA EXTRACTOS
            nodo.WriteString('aportes',CurrToStr(Vaportes));
            nodo.WriteString('ahorros',CurrToStr(Vahorros));
            nodo.WriteString('juvenil',CurrToStr(Vjuvenil));
            nodo.WriteString('cdat',CurrToStr(Vcdat));
            nodo.WriteString('contractual',CurrToStr(Vcontractual));
            nodo.WriteString('cuenta',vcuenta);
            nodo := XmlRes.Root.NodeNew('referencias');
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"col$referencias".PRIMER_APELLIDO_REFERENCIA,');
            SQL.Add('"col$referencias".SEGUNDO_APELLIDO_REFERENCIA,');
            SQL.Add('"col$referencias".NOMBRE_REFERENCIA,');
            SQL.Add('"col$referencias".DIRECCION_REFERENCIA,');
            SQL.Add('"col$referencias".TELEFONO_REFERENCIA,');
            SQL.Add('"col$referencias".TIPO_REFERENCIA,');
            SQL.Add('"col$referencias".PARENTESCO_REFERENCIA');
            SQL.Add('FROM');
            SQL.Add('"col$referencias"');
            SQL.Add('INNER JOIN "col$referenciasolicitud" ON ("col$referencias".ID_ENTRADA = "col$referenciasolicitud".ID_ENTRADA)');
            SQL.Add('WHERE');
            SQL.Add('("col$referenciasolicitud".ID_SOLICITUD = :ID_SOLICITUD)');
            ParamByName('ID_SOLICITUD').AsString := id_solicitud;
            Open;
            while not Eof do
            begin
              nodo1 := nodo.NodeNew('referencia');
              nodo1.WriteString('p_apellido_ref',FieldByName('PRIMER_APELLIDO_REFERENCIA').AsString);
              nodo1.WriteString('s_apellido_ref',FieldByName('SEGUNDO_APELLIDO_REFERENCIA').AsString);
              nodo1.WriteString('nombre_ref',FieldByName('NOMBRE_REFERENCIA').AsString);
              nodo1.WriteString('direccion_ref',FieldByName('DIRECCION_REFERENCIA').AsString);
              nodo1.WriteString('telefono_ref',FieldByName('TELEFONO_REFERENCIA').AsString);
              nodo1.WriteString('tipo_ref',FieldByName('TIPO_REFERENCIA').AsString);
              nodo1.WriteString('parentesco_ref',FieldByName('PARENTESCO_REFERENCIA').AsString);
              Next;
            end;
            nodo := XmlRes.Root.NodeNew('requisitos');
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"col$solicitudrequisito".ID_IDENTIFICACION,');
            SQL.Add('"col$solicitudrequisito".ID_PERSONA,');
            SQL.Add('"col$solicitudrequisito".ID_REQUISITO');
            SQL.Add('FROM');
            SQL.Add('"col$solicitudrequisito"');
            SQL.Add('WHERE');
            SQL.Add('("col$solicitudrequisito".ID_SOLICITUD = :ID_SOLICITUD)');
            ParamByName('ID_SOLICITUD').AsString := id_solicitud;
            Open;
            while not Eof do
            begin
              nodo1 := nodo.NodeNew('requisito');
              nodo1.WriteString('id_persona',FieldByName('ID_PERSONA').AsString);
              nodo1.WriteString('id_identificacion',FieldByName('ID_IDENTIFICACION').AsString);
              nodo1.WriteString('id_requisito',FieldByName('ID_REQUISITO').AsString);
              Next;
            end;
            end; // fin del valida solciitud
         end // fin del if que define el tipo de proceso
         else
         begin
           if id_modulo = 'A' then// inicio de actualizar formulario de analisis
           begin
             if id_solicitud = '' then
             begin
               nodo := XmlRes.Root.NodeNew('solicitud');
               nodo.WriteString('actualizado','false');
             end;
             XmlDoc.Root.NodeByName('datos_solicitud');
             nodo := XmlDoc.Root.NodeByName('datos_solicitud');
             Close;
           try
             SQL.Clear;
             SQL.Add('update "col$solicitud" set "col$solicitud".TASA_INTERES = :TASA_INTERES,"col$solicitud".PLAZO_APROBADO = :PLAZO_APROBADO,');
             SQL.Add('"col$solicitud".VALOR_APROBADO = :VALOR_APROBADO,"col$solicitud".ID_ANALISIS = :ID_ANALISIS,"col$solicitud".INGRESOS = :INGRESOS,');
             SQL.Add('"col$solicitud".DISPONIBLE = :DISPONIBLE,"col$solicitud".DEDUCCIONES = :DEDUCCIONES,"col$solicitud".VALOR_CUOTA = :VALOR_CUOTA,');
             SQL.Add('"col$solicitud".DISPONIBILIDAD = :DISPONIBILIDAD,"col$solicitud".SOLV_ECONOMICA = :SOLV_ECONOMICA,"col$solicitud".EXP_CREDITOS = :EXP_CREDITOS,"col$solicitud".PLAZO_APROBADO = :PLAZO_APROBADO,"col$solicitud".ESTADO = :ESTADO,');
             SQL.Add('"col$solicitud".INVERSION = :INVERSION, "col$solicitud".CLASIFICACION = :CLASIFICACION');
             SQL.Add('where ID_SOLICITUD = :ID_SOLICITUD');
             ParamByName('ID_SOLICITUD').AsString := id_solicitud;
             ParamByName('TASA_INTERES').AsFloat := nodo.ReadFloat('tasa');
             ParamByName('VALOR_APROBADO').AsCurrency := nodo.ReadFloat('valor_aprobado');
             ParamByName('PLAZO_APROBADO').AsCurrency := nodo.ReadFloat('plazo_aprobado');
             ParamByName('ID_ANALISIS').AsString := nodo.ReadString('id_analisis');
             ParamByName('DISPONIBLE').AsCurrency := nodo.ReadFloat('disponible');
             ParamByName('DEDUCCIONES').AsCurrency := nodo.ReadFloat('deducciones');
             ParamByName('VALOR_CUOTA').AsCurrency := nodo.ReadFloat('valor_cuota');
             ParamByName('INGRESOS').AsCurrency := nodo.ReadFloat('ingresos');
             ParamByName('DISPONIBILIDAD').AsCurrency := nodo.ReadFloat('disponibilidad');
             ParamByName('SOLV_ECONOMICA').AsSmallInt := nodo.ReadInteger('solv_economica');
             ParamByName('EXP_CREDITOS').AsString := nodo.ReadString('exp_creditos');
             ParamByName('ESTADO').AsInteger := nodo.ReadInteger('estado');
             ParamByName('INVERSION').AsInteger := nodo.ReadInteger('inversion');
             ParamByName('CLASIFICACION').AsInteger := nodo.ReadInteger('clasificacion');
             ExecSQL;
             nodo := XmlDoc.Root.NodeByName('datos_codeudor');
             for i := 0 to nodo.NodeCount - 1 do
             begin
               Close;
               SQL.Clear;
               SQL.Add('update "col$codeudor"  set "col$codeudor".DISPONIBLE = :DISPONIBLE,"col$codeudor".DEDUCCIONES = :DEDUCCIONES,');
               SQL.Add('"col$codeudor".VALOR_CUOTA = :VALOR_CUOTA,"col$codeudor".DISP_PAGO = :DISP_PAGO,"col$codeudor".SOLV_ECONOMICA = :SOLV_ECONOMICA,');
               SQL.Add('"col$codeudor".EXP_CREDITOS = :EXP_CREDITOS,"col$codeudor".INGRESOS = :INGRESOS');
               SQL.Add('where ID_SOLICITUD = :ID_SOLICITUD and ID_PERSONA = :ID_PERSONA and ID_IDENTIFICACION = :ID_IDENTIFICACION');
               ParamByName('ID_SOLICITUD').AsString := id_solicitud;
               ParamByName('ID_PERSONA').AsString := nodo.Nodes[i].ReadString('id_persona');
               ParamByName('ID_IDENTIFICACION').AsSmallInt := nodo.Nodes[i].ReadInteger('id_identificacion');
               ParamByName('DISPONIBLE').AsCurrency := nodo.Nodes[i].ReadFloat('disponible');
               ParamByName('DEDUCCIONES').AsCurrency := nodo.Nodes[i].ReadFloat('deducciones');
               ParamByName('VALOR_CUOTA').AsCurrency := nodo.Nodes[i].ReadFloat('valor_cuota');
               ParamByName('INGRESOS').AsCurrency := nodo.Nodes[i].ReadFloat('ingresos');
               ParamByName('DISP_PAGO').AsCurrency := nodo.Nodes[i].ReadFloat('disponibilidad');
               ParamByName('SOLV_ECONOMICA').AsSmallInt := nodo.Nodes[i].ReadInteger('solv_economica');
               ParamByName('EXP_CREDITOS').AsString := nodo.Nodes[i].ReadString('exp_creditos');
               ExecSQL;
             end;
             nodo := XmlDoc.Root.NodeByName('datos_observacion');
             for i := 0 to nodo.NodeCount - 1 do
             begin
               Close;
               SQL.Clear;
               SQL.Clear;
               SQL.Add('delete from "col$observacion"');
               SQL.Add('where ID_SOLICITUD = :ID_SOLICITUD and');
               SQL.Add('ID_OBSERVACION = :ID_OBSERVACION');
               ParamByName('ID_SOLICITUD').AsString := id_solicitud;
               ParamByName('ID_OBSERVACION').AsInteger := nodo.Nodes[i].ReadInteger('id_observacion');
               ExecSQL;
               Close;
               SQL.Clear;
               SQL.Add('insert into "col$observacion"');
               SQL.Add('values(:ID_SOLICITUD,:ID_OBSERVACION,:OBSERVACION)');
               ParamByName('ID_SOLICITUD').AsString := id_solicitud;
               ParamByName('ID_OBSERVACION').AsInteger := nodo.Nodes[i].ReadInteger('id_observacion');
               ParamByName('OBSERVACION').AsBlob := nodo.Nodes[i].ReadString('observacion');
               ExecSQL;
               Close;
             end;
           except
           begin
             XmlRes.Clear;
             XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
             XmlRes.EncodingString := 'ISO8859-1';
             XmlRes.XmlFormat := xfReadable;
             nodo := XmlRes.Root.NodeNew('solicitud');
             nodo.WriteBool('actualizado',False);
           end;
           end;
             XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
             XmlRes.EncodingString := 'ISO8859-1';
             XmlRes.XmlFormat := xfReadable;
             nodo := XmlRes.Root.NodeNew('solicitud');
             nodo.WriteBool('actualizado',True);// validacion del error
           end // fin del actualizar del modulo analistas
           else if id_modulo = 'I' then// inicio de actualzar la opcion de de formulario de créditos
           begin
             if id_solicitud = '' then
             begin
               nodo := XmlRes.Root.NodeNew('solicitud');
               nodo.WriteString('actualizado','false');
             end;
             nodo := XmlDoc.Root.NodeByName('observaciones');
            try
             for i := 0 to nodo.NodeCount - 1 do
             begin
               Close;
               SQL.Clear;
               SQL.Clear;
               SQL.Add('delete from "col$observacion"');
               SQL.Add('where ID_SOLICITUD = :ID_SOLICITUD and');
               SQL.Add('ID_OBSERVACION = :ID_OBSERVACION');
               ParamByName('ID_SOLICITUD').AsString := id_solicitud;
               ParamByName('ID_OBSERVACION').AsInteger := nodo.Nodes[i].ReadInteger('tipo');
               ExecSQL;
               Close;
               SQL.Clear;
               SQL.Add('insert into "col$observacion"');
               SQL.Add('values(:ID_SOLICITUD,:ID_OBSERVACION,:OBSERVACION)');
               ParamByName('ID_SOLICITUD').AsString := id_solicitud;
               ParamByName('ID_OBSERVACION').AsInteger := nodo.Nodes[i].ReadInteger('tipo');
               ParamByName('OBSERVACION').AsBlob := nodo.Nodes[i].ReadString('descripcion');
               ExecSQL;
               Close;
             end;
             except
             begin
               XmlRes.Clear;
               XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
               XmlRes.EncodingString := 'ISO8859-1';
               XmlRes.XmlFormat := xfReadable;
               nodo := XmlRes.Root.NodeNew('solicitud');
               nodo.WriteBool('actualizado',False);
             end;
             end;
             XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
             XmlRes.EncodingString := 'ISO8859-1';
             XmlRes.XmlFormat := xfReadable;
             nodo := XmlRes.Root.NodeNew('solicitud');
             nodo.WriteBool('actualizado',True);// validacion del error
             end// fin de la actualizacion del formulario de comite de créditos
             else if id_modulo = 'E' then
             begin
               if id_solicitud = '' then
               begin
                 nodo := XmlRes.Root.NodeNew('solicitud');
                 nodo.WriteString('actualizado','false');
               end;
               nodo := Xmldoc.Root.NodeByName('datos_solicitud');
             try
               Close;
               SQL.Clear;
               SQL.Add('update "col$solicitud" set');
               SQL.Add('"col$solicitud".NUMERO_ACTA = :NUMERO_ACTA,');
               SQL.Add('"col$solicitud".VALOR_APROBADO = :VALOR_APROBADO,');
               SQL.Add('"col$solicitud".ENTE_APROBADOR = :ENTE_APROBADOR,');
               SQL.Add('"col$solicitud".FECHA_CONCEPTO = :FECHA_CONCEPTO,');
               SQL.Add('"col$solicitud".TASA_INTERES = :TASA_INTERES,');
               SQL.Add('"col$solicitud".PLAZO_APROBADO = :PLAZO_APROBADO,');
               SQL.Add('"col$solicitud".ESTADO = :ESTADO,');
               SQL.Add('"col$solicitud".ES_DESEMBOLSO_PARCIAL = :ES_DESEMBOLSO_PARCIAL');
               SQL.Add('where "col$solicitud".ID_SOLICITUD = :ID_SOLICITUD');
               ParamByName('NUMERO_ACTA').AsString := nodo.ReadString('acta');
               ParamByName('VALOR_APROBADO').AsCurrency := nodo.ReadFloat('valor_aprobado');
               ParamByName('ENTE_APROBADOR').AsSmallInt := nodo.ReadInteger('ente_aprobador');
               ParamByName('FECHA_CONCEPTO').AsDate := Date;
               ParamByName('TASA_INTERES').AsFloat := nodo.ReadFloat('tasa');
               ParamByName('PLAZO_APROBADO').AsInteger := nodo.ReadInteger('plazo_aprobado');
               ParamByName('ID_SOLICITUD').AsString := id_solicitud;
               ParamByName('ESTADO').AsInteger := nodo.ReadInteger('estado');
               ParamByName('ES_DESEMBOLSO_PARCIAL').AsInteger := nodo.ReadInteger('desembolso_parcial');
               ExecSQL;
               Close;
               if nodo.ReadBool('aprobada') then
               begin
                 SQL.Clear;
                 SQL.Add('delete from "col$desembolsoparcial"');
                 SQL.Add('where "col$desembolsoparcial".ID_SOLICITUD = :ID_SOLICITUD');
                 ParamByName('ID_SOLICITUD').AsString := id_solicitud;
                 ExecSQL;
                 SQL.Clear;
                 SQL.Add('insert into "col$desembolsoparcial" values (');
                 SQL.Add(':ID_SOLICITUD,:ID_DESEMBOLSO,:VALOR_DESEMBOLSO,:FECHA_DESEMBOLSO,:DESEMBOLSADO,:ID_COLOCACION,:ID_AGENCIA)');
                 ParamByName('ID_SOLICITUD').AsString := id_solicitud;
                 ParamByName('ID_DESEMBOLSO').AsInteger := 1;
                 ParamByName('VALOR_DESEMBOLSO').Clear;
                 ParamByName('FECHA_DESEMBOLSO').Clear;
                 ParamByName('DESEMBOLSADO').AsInteger :=0;
                 ParamByName('ID_COLOCACION').Clear;
                 parambyname('ID_AGENCIA').AsInteger := nodo.ReadInteger('oficina');
                 ExecSQL;
               end;
               except
               begin
                 XmlRes.Clear;
                 XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
                 XmlRes.EncodingString := 'ISO8859-1';
                 XmlRes.XmlFormat := xfReadable;
                 nodo := XmlRes.Root.NodeNew('solicitud');
                 nodo.WriteBool('actualizado',False);
               end;
               end;
               XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
               XmlRes.EncodingString := 'ISO8859-1';
               XmlRes.XmlFormat := xfReadable;
               nodo := XmlRes.Root.NodeNew('solicitud');
               nodo.WriteBool('actualizado',True);// validacion del error
             end;
          end; // fin del esle begin del tipo de proceso actualizar o insertar
         end;// FIN DEL WITH
             IBconexion.Commit(IBTconsulta);
     except
      on E: Exception do
      begin
        XmlRes.Clear;
        XmlRes := TsdXmlDocument.CreateName('resultado');// xml de respuesta
        XmlRes.EncodingString := 'ISO8859-1';
        XmlRes.XmlFormat := xfReadable;
        nodo := XmlRes.Root.NodeNew('solicitud');
        nodo.WriteString('encontrado','error');// validacion del error
        nodo.WriteString('mensaje',E.Message);
        IBconexion.Rollback(IBTconsulta);
      end;// fin del on
      end;// fin del try
      MyList.Clear;
      //Dispose(ARecord);
        Astream := TStringStream.Create('');
        XmlRes.SaveToStream(Astream);
        XmlRes.SaveToFile('C:\xml\ressol.xml');
        AThread.Connection.WriteInteger(Astream.Size);
        AThread.Connection.OpenWriteBuffer;
        AThread.Connection.WriteStream(Astream);
        AThread.Connection.CloseWriteBuffer;
end;

procedure TFrmServer_Analistas.FormCreate(Sender: TObject);
begin
     MiIni := ChangeFileExt(Application.ExeName,'.ini');
     with TIniFile.Create(MiIni) do
     begin
       DBServer := ReadString('SERVER','servidor','0.0.0.0');
       DBPath := ReadString('SERVER','Path','/var/db/fbird/');
       DBName := ReadString('SERVER','nombre','database.fdb');
     end;
     IdTCPServer1.Active := True;
     Memo1.Text := 'Base de Datos = ' + DBServer + ':' + DBPath + DBName;
end;
end.
