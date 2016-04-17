unit UnitTraslados;

interface

uses
  DateUtils, IniFiles, SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, IdBaseComponent, IdComponent, IdTCPServer, FMTBcd,
  DB,IBQuery, IBSql, IBDatabase,IdCoder, JvSimpleXml, DBXpress, SqlExpr,
  IdCoder3To4, sdXmlDocuments;

type
  PTCuenta = ^TCuenta;
  TCuenta = Record
    Id_Agencia :Integer;
    Id_Tipo_Captacion :Integer;
    Numero_Cuenta:Integer;
    Digito_Cuenta:Integer;
    CodContable:string;
end;

type
  PTPersona = ^TPersona;
  TPersona = record
     id:Integer;
     persona:string;
end;


type
  TfrmServerTraslados = class(TForm)
    EdLog: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    lblDatabase: TLabel;
    Label3: TLabel;
    lblPuerto: TLabel;
    IdTCPServer1: TIdTCPServer;
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    Label4: TLabel;
    lblTimeOut: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
  private
    { Private declarations }
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
    host_aguachica:string;
    Hay_Conexion: Boolean;
    procedure Ejecutar(AThread: TIdPeerThread);
    function BuscoTasaAnt(Ag: Integer;Colocacion: string;FechaIntereses:TDateTime): Single;
  public
    { Public declarations }
    procedure procesar(tipo: integer; id: string);
    procedure Contabilizar;    
  end;

var
  frmServerTraslados: TfrmServerTraslados;
   
implementation

{$R *.xfm}

uses UnitGlobales;

procedure TfrmServerTraslados.FormCreate(Sender: TObject);
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
       host_aguachica := ReadString('SERVER','hostaguachica','');
     end;
     IdTCPServer1.TerminateWaitTime := IDtiempo;
     IdTCPServer1.DefaultPort := IDpuerto;
     IdTCPServer1.Active := True;
     lblDataBase.Caption := DBServer + ':' + DBPath + DBName;
     lblPuerto.Caption := IntToStr(IDpuerto);
     lblTimeOut.Caption := IntToStr(IDtiempo) + ' Milisegundos Puerto ' + IntToStr(IDpuerto);
end;

procedure TfrmServerTraslados.IdTCPServer1Execute(AThread: TIdPeerThread);
begin
      if Athread.Connection.RecvBufferSize > 0 then
      begin
        Ejecutar(AThread);
      end;
end;

procedure TfrmServerTraslados.Ejecutar(AThread: TIdPeerThread);
var
i,Size:Integer;
AStream:TStringStream;
XMLDoc,XMLDocRet :TsdXmlDocument;
XMLRet:Boolean;
SQLConn:TSQLConnection;
ANode: TXmlNode;
Id:Integer;
Nm:string;
begin        XmlDocRet := TsdXmlDocument.Create;
        XmlDocRet.EncodingString := 'ISO8859-1';
        XmlDocRet.XmlFormat := xfReadable;
        XmlDoc := TsdXmlDocument.Create;
        Athread.Connection.WriteLn('Esperando...');
        AStream := TStringStream.Create('');
        Size := AThread.Connection.ReadInteger;
        Athread.Connection.ReadStream(AStream,Size,False);
        System.WriteLn('Stream recibido');
       try        XMLDoc.LoadFromStream(AStream);
        XMLDoc.SaveToFile('xmlrecibido1.xml');
        EdLog.Lines.LoadFromStream(AStream);
        System.WriteLn('Xml Cargado');
       finally
       end;

    AStream := TStringStream.Create('');
    System.WriteLn('Guardando AStream Retorno');
    XMLDocRet.SaveToStream(AStream);
    XMLDocRet.SaveToFile('XmlServer.xml');
    AStream.Seek(0,0);
    Athread.Connection.WriteInteger(AStream.Size);
    Athread.Connection.OpenWriteBuffer;
    Athread.Connection.WriteStream(AStream);
    Athread.Connection.CloseWriteBuffer;
end;

procedure TfrmServerTraslados.procesar(tipo: integer; id: string);
var
  i,j,k,l:Integer;
  Id_Agencia,Id_Tipo_Captacion,Numero_Cuenta,Digito_Cuenta:Integer;
  yaExiste :Boolean;
  vTabla :Boolean;
  vContador :Integer;
  OldTimeFormat,OldDateFormat,OldDateTimeFormat:string;
  CodContable:string;
  Nombre:string;
  Fecha1,Fecha2:TDateTime;
  Cuentas :TList;
  Personas :TList;
  IBSql1: TIBQuery;
  IBDataBase1 : TIBDatabase;
  xml :TJvSimpleXml;
  Nodo1 : TJvSimpleElemenClass;
begin
        Cuentas := TList.Create;
        Personas := TList.Create;

        IBDataBase1 := TIBDatabase.Create(nil);
        IBSql1 := TIBQuery.Create(nil);

        OldDateFormat := ShortDateFormat;
        ShortDateFormat := 'yyyy/MM/dd';
        OldTimeFormat := LongTimeFormat;
        LongTimeFormat := 'HH:mm:ss';

        Fecha1 := EncodeDate(YearOf(fFechaActual(IBDatabase1)),01,01);
        Fecha2 := EncodeDate(YearOf(fFechaActual(IBDatabase1)),12,31);        


        with IBSQl1 do begin
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('  "cap$maestrotitular".ID_AGENCIA,');
          SQL.Add('  "cap$maestrotitular".ID_TIPO_CAPTACION,');
          SQL.Add('  "cap$maestrotitular".NUMERO_CUENTA,');
          SQL.Add('  "cap$maestrotitular".DIGITO_CUENTA,');
          SQL.Add('  "cap$maestrotitular".ID_IDENTIFICACION,');
          SQL.Add('  "cap$maestrotitular".ID_PERSONA,');
          SQL.Add('  "cap$maestrotitular".NUMERO_TITULAR,');
          SQL.Add('  "cap$maestrotitular".TIPO_TITULAR,');
          SQL.Add('  "gen$persona".NOMBRE || '' '' ||');
          SQL.Add('  "gen$persona".PRIMER_APELLIDO || '' '' ||');
          SQL.Add('  "gen$persona".SEGUNDO_APELLIDO AS ASOCIADO');
          SQL.Add('FROM');
          SQL.Add(' "cap$maestrotitular"');
          SQL.Add('INNER JOIN "gen$persona" ON ("cap$maestrotitular".ID_IDENTIFICACION="gen$persona".ID_IDENTIFICACION)');
          SQL.Add('AND ("cap$maestrotitular".ID_PERSONA="gen$persona".ID_PERSONA)');
          SQL.Add('WHERE');
          SQL.Add('"cap$maestrotitular".ID_IDENTIFICACION = :ID_IDENTIFICACION');
          SQL.Add('AND');
          SQL.Add('"cap$maestrotitular".ID_PERSONA = :ID_PERSONA');
          SQL.Add('AND');
          SQL.Add('"cap$maestrotitular".NUMERO_TITULAR = 1');
          SQL.Add('ORDER BY');
          SQL.Add('"cap$maestrotitular".ID_TIPO_CAPTACION, "cap$maestrotitular".NUMERO_CUENTA');
          ParamByName('ID_IDENTIFICACION').AsInteger := tipo;
          ParamByName('ID_PERSONA').AsString := id;
          try
           Open;
          except
           Transaction.Rollback;
           raise;
           Exit;
          end;
        end; // fin del with cap$maestrotitular busqueda inicial de cuenta

        Nombre := IBSql1.FieldByName('ASOCIADO').AsString;

        xml.Root.Properties.Add('tipo',IntToStr(tipo));
        xml.Root.Properties.Add('numero',id);
        xml.Root.Properties.Add('asociado',Nombre);

        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','cap$maestro');

        while not IBSql1.Eof do
        begin
             Id_Agencia := IBSql1.FieldByName('ID_AGENCIA').AsInteger;
             Id_Tipo_Captacion := IBSql1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
             Numero_Cuenta := IBSql1.FieldByName('NUMERO_CUENTA').AsInteger;
             Digito_Cuenta := IBSql1.FieldByName('DIGITO_CUENTA').AsInteger;

             // Realizar proceso general para esta cuenta
             IBSql2.Close;
             IBSql2.SQL.Clear;
             IBSql2.SQL.Add('SELECT ');
             IBSql2.SQL.Add('  "cap$maestro".ID_AGENCIA,');
             IBSql2.SQL.Add('  "cap$maestro".ID_TIPO_CAPTACION,');
             IBSql2.SQL.Add('  "cap$maestro".NUMERO_CUENTA,');
             IBSql2.SQL.Add('  "cap$maestro".DIGITO_CUENTA,');
             IBSql2.SQL.Add('  "cap$maestro".VALOR_INICIAL,');
             IBSql2.SQL.Add('  "cap$maestro".ID_FORMA,');
             IBSql2.SQL.Add('  "cap$maestro".FECHA_APERTURA,');
             IBSql2.SQL.Add('  "cap$maestro".PLAZO_CUENTA,');
             IBSql2.SQL.Add('  "cap$maestro".TIPO_INTERES,');
             IBSql2.SQL.Add('  "cap$maestro".ID_INTERES,');
             IBSql2.SQL.Add('  "cap$maestro".TASA_EFECTIVA,');
             IBSql2.SQL.Add('  "cap$maestro".PUNTOS_ADICIONALES,');
             IBSql2.SQL.Add('  "cap$maestro".MODALIDAD,');
             IBSql2.SQL.Add('  "cap$maestro".AMORTIZACION,');
             IBSql2.SQL.Add('  "cap$maestro".CUOTA,');
             IBSql2.SQL.Add('  "cap$maestro".CUOTA_CADA,');
             IBSql2.SQL.Add('  "cap$maestro".ID_PLAN,');
             IBSql2.SQL.Add('  "cap$maestro".ID_ESTADO,');
             IBSql2.SQL.Add('  "cap$maestro".FECHA_VENCIMIENTO,');
             IBSql2.SQL.Add('  "cap$maestro".FECHA_ULTIMO_PAGO,');
             IBSql2.SQL.Add('  "cap$maestro".FECHA_PROXIMO_PAGO,');
             IBSql2.SQL.Add('  "cap$maestro".FECHA_PRORROGA,');
             IBSql2.SQL.Add('  "cap$maestro".FECHA_VENCIMIENTO_PRORROGA,');
             IBSql2.SQL.Add('  "cap$maestro".FECHA_SALDADA,');
             IBSql2.SQL.Add('  "cap$maestro".FIRMAS,');
             IBSql2.SQL.Add('  "cap$maestro".SELLOS,');
             IBSql2.SQL.Add('  "cap$maestro".PROTECTOGRAFOS,');
             IBSql2.SQL.Add('  "cap$maestro".ID_TIPO_CAPTACION_ABONO,');
             IBSql2.SQL.Add('  "cap$maestro".NUMERO_CUENTA_ABONO');
             IBSql2.SQL.Add('FROM');
             IBSql2.SQL.Add(' "cap$maestro"');
             IBSql2.SQL.Add('WHERE');
             IBSql2.SQL.Add(' "cap$maestro".ID_AGENCIA = :ID_AGENCIA');
             IBSql2.SQL.Add('AND');
             IBSql2.SQL.Add(' "cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION');
             IBSql2.SQL.Add('AND');
             IBSql2.SQL.Add(' "cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA');
             IBSql2.SQL.Add('AND');
             IBSql2.SQL.Add(' "cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA');
             IBSql2.SQL.Add('AND');
             IBSql2.SQL.Add(' "cap$maestro".ID_ESTADO IN (1,3,4,6,13,14)');
             IBSql2.ParamByName('ID_AGENCIA').AsInteger := Id_Agencia;
             IBSql2.ParamByName('ID_TIPO_CAPTACION').AsInteger := Id_Tipo_Captacion;
             IBSql2.ParamByName('NUMERO_CUENTA').AsInteger := Numero_Cuenta;
             IBSql2.ParamByName('DIGITO_CUENTA').AsInteger := Digito_Cuenta;
             try
              IBSql2.Open;
              if IBSql2.RecordCount > 0 then
              begin
                Nodo2 := Nodo1.Items.Add('registro');
                IBSql3.Close;
                IBSql3.SQL.Clear;
                IBSql3.SQL.Add('SELECT CODIGO_CONTABLE from "cap$contable" where ID_CAPTACION = :ID_CAP AND ID_CONTABLE = :ID_CONTABLE');
                if ((IBSql2.FieldByName('ID_TIPO_CAPTACION').AsInteger = 1) or
                   (IBSql2.FieldByName('ID_TIPO_CAPTACION').AsInteger = 2) or
                   (IBSql2.FieldByName('ID_TIPO_CAPTACION').AsInteger = 4) or
                   (IBSql2.FieldByName('ID_TIPO_CAPTACION').AsInteger = 5)) then
                 begin
                   IBSql3.ParamByName('ID_CAP').AsInteger := id_Tipo_Captacion;
                   IBSql3.ParamByName('ID_CONTABLE').AsInteger := 20;
                 end
                else
                 begin
                   IBSql3.ParamByName('ID_CAP').AsInteger := id_Tipo_Captacion;
                   if ((IBSql2.FieldByName('PLAZO_CUENTA').AsInteger > 0) and (IBSql2.FieldByName('PLAZO_CUENTA').AsInteger <= 179)) then
                      IBSql3.ParamByName('ID_CONTABLE').AsInteger := 21
                   else if ((IBSql2.FieldByName('PLAZO_CUENTA').AsInteger >= 180) and (IBSql2.FieldByName('PLAZO_CUENTA').AsInteger <= 360)) then
                      IBSql3.ParamByName('ID_CONTABLE').AsInteger := 22
                   else if ((IBSql2.FieldByName('PLAZO_CUENTA').AsInteger >= 361) and (IBSql2.FieldByName('PLAZO_CUENTA').AsInteger <= 539)) then
                      IBSql3.ParamByName('ID_CONTABLE').AsInteger := 23
                   else if ((IBSql2.FieldByName('PLAZO_CUENTA').AsInteger >= 180) and (IBSql2.FieldByName('PLAZO_CUENTA').AsInteger <= 360)) then
                      IBSql3.ParamByName('ID_CONTABLE').AsInteger := 24;
                 end;

                IBSql3.Open;
                CodContable := IBSql3.FieldByName('CODIGO_CONTABLE').AsString;
                IBSql3.Close;

                New(dCuenta);
                dCuenta.Id_Agencia := IBSql2.FieldByName('ID_AGENCIA').AsInteger;
                dCuenta.Id_Tipo_Captacion := IBSql2.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                dCuenta.Numero_Cuenta := IBSql2.FieldByName('NUMERO_CUENTA').AsInteger;
                dCuenta.Digito_Cuenta := IBSql2.FieldByName('DIGITO_CUENTA').AsInteger;
                dCuenta.CodContable := CodContable;
                Cuentas.Add(dCuenta);
                for i := 0 to IBSql2.FieldCount - 1 do
                 begin
                   Nodo3 := Nodo2.Items.Add('campo');
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql2.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql2.Fields[i].DataSize));
                   Nodo3.Value := IBSql2.Fields[i].AsString;
                 end;
                 IBSql2.Close;
              end;
             except
              IBSql2.Transaction.Rollback;
              raise;
              Exit;
             end;
           IBSql1.Next;

        end; // fin del while de ciclo de cuentas encontradas para ese asociado
        CheckBox1.Checked := True;
// Procesar cap$maestrotitular por cada una de las cuentas a trasladar
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','cap$maestrotitular');
// Procesar datos adicionales de cada cuenta.
        for i := 0 to Cuentas.Count - 1 do
        begin
         dCuenta := Cuentas.Items[i];
         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "cap$maestrotitular".ID_AGENCIA,');
         IBSql1.SQL.Add('  "cap$maestrotitular".ID_TIPO_CAPTACION,');
         IBSql1.SQL.Add('  "cap$maestrotitular".NUMERO_CUENTA,');
         IBSql1.SQL.Add('  "cap$maestrotitular".DIGITO_CUENTA,');
         IBSql1.SQL.Add('  "cap$maestrotitular".ID_IDENTIFICACION,');
         IBSql1.SQL.Add('  "cap$maestrotitular".ID_PERSONA,');
         IBSql1.SQL.Add('  "cap$maestrotitular".NUMERO_TITULAR,');
         IBSql1.SQL.Add('  "cap$maestrotitular".TIPO_TITULAR');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "cap$maestrotitular"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "cap$maestrotitular".ID_AGENCIA = :ID_AGENCIA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrotitular".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrotitular".NUMERO_CUENTA = :NUMERO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrotitular".DIGITO_CUENTA = :DIGITO_CUENTA');
         IBSql1.ParamByName('ID_AGENCIA').AsInteger := dCuenta.Id_Agencia;
         IBSql1.ParamByName('ID_TIPO_CAPTACION').AsInteger := dCuenta.Id_Tipo_Captacion;
         IBSql1.ParamByName('NUMERO_CUENTA').AsInteger := dCuenta.Numero_Cuenta;
         IBSql1.ParamByName('DIGITO_CUENTA').AsInteger := dCuenta.Digito_Cuenta;
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           while not IBSql1.Eof do
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                 Nodo3.Value := IBSql1.Fields[j].AsString;
             end;

             yaExiste := False;

             for k := 0 to Personas.Count - 1 do
             begin
                dPersona  := Personas.Items[k];
                if (dPersona.id = IBSql1.Fields[4].AsInteger) and
                   (dPersona.persona = IBSql1.Fields[5].AsString) then
                   yaExiste := True;
             end;

             if not yaExiste then
             begin
              New(dPersona);
              dPersona.id := IBSql1.Fields[4].AsInteger;
              dPersona.persona := IBSql1.Fields[5].AsString;
              Personas.Add(dPersona);
             end;

             IBSql1.Next;
           end;
         except
           IBSql1.Transaction.Rollback;
           raise;
           Exit;
         end;
        end; // fin del for de cuentas
        CheckBox2.Checked := True;
// Fin lectura Maestro titular

// Lectura Maestro Saldo Inicial
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','cap$maestrosaldoinicial');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Cuentas.Count - 1 do
        begin
         dCuenta := Cuentas.Items[i];
         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT');
         IBSql1.SQL.Add('  "cap$maestrosaldoinicial".ID_AGENCIA,');
         IBSql1.SQL.Add('  "cap$maestrosaldoinicial".ID_TIPO_CAPTACION,');
         IBSql1.SQL.Add('  "cap$maestrosaldoinicial".NUMERO_CUENTA,');
         IBSql1.SQL.Add('  "cap$maestrosaldoinicial".DIGITO_CUENTA,');
         IBSql1.SQL.Add('  "cap$maestrosaldoinicial".ANO,');
         IBSql1.SQL.Add('  "cap$maestrosaldoinicial".SALDO_INICIAL');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "cap$maestrosaldoinicial"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "cap$maestrosaldoinicial".ID_AGENCIA = :ID_AGENCIA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrosaldoinicial".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrosaldoinicial".NUMERO_CUENTA = :NUMERO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrosaldoinicial".DIGITO_CUENTA = :DIGITO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrosaldoinicial".ANO = :ANO');
         IBSql1.ParamByName('ID_AGENCIA').AsInteger := dCuenta.Id_Agencia;
         IBSql1.ParamByName('ID_TIPO_CAPTACION').AsInteger := dCuenta.Id_Tipo_Captacion;
         IBSql1.ParamByName('NUMERO_CUENTA').AsInteger := dCuenta.Numero_Cuenta;
         IBSql1.ParamByName('DIGITO_CUENTA').AsInteger := dCuenta.Digito_Cuenta;
         IBSql1.ParamByName('ANO').AsString := IntToStr(yearof(now));
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                 Nodo3.Value := IBSql1.Fields[j].AsString;
             end;
           end;
         except
           IBTransaction1.Rollback;
           raise;
           Exit;
         end;
        end;
        CheckBox3.Checked := True;
// Fin lectura maestro saldo inicial

// Lectura Maestro Saldos Mes
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','cap$maestrosaldosmes');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Cuentas.Count - 1 do
        begin
         dCuenta := Cuentas.Items[i];
         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "cap$maestrosaldosmes".ID_AGENCIA,');
         IBSql1.SQL.Add('  "cap$maestrosaldosmes".ID_TIPO_CAPTACION,');
         IBSql1.SQL.Add('  "cap$maestrosaldosmes".NUMERO_CUENTA,');
         IBSql1.SQL.Add('  "cap$maestrosaldosmes".DIGITO_CUENTA,');
         IBSql1.SQL.Add('  "cap$maestrosaldosmes".MES,');
         IBSql1.SQL.Add('  "cap$maestrosaldosmes".DEBITO,');
         IBSql1.SQL.Add('  "cap$maestrosaldosmes".CREDITO');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "cap$maestrosaldosmes"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "cap$maestrosaldosmes".ID_AGENCIA = :ID_AGENCIA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrosaldosmes".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrosaldosmes".NUMERO_CUENTA = :NUMERO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrosaldosmes".DIGITO_CUENTA = :DIGITO_CUENTA');
         IBSql1.ParamByName('ID_AGENCIA').AsInteger := dCuenta.Id_Agencia;
         IBSql1.ParamByName('ID_TIPO_CAPTACION').AsInteger := dCuenta.Id_Tipo_Captacion;
         IBSql1.ParamByName('NUMERO_CUENTA').AsInteger := dCuenta.Numero_Cuenta;
         IBSql1.ParamByName('DIGITO_CUENTA').AsInteger := dCuenta.Digito_Cuenta;
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                 Nodo3.Value := IBSql1.Fields[j].AsString;
             end;
           end;
         except
           IBTransaction1.Rollback;
           raise;
           Exit;
         end;
        end;
        CheckBox4.Checked := True;

// Fin Lectura mestro saldos mes

// Lectura Maestro Apertura
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','cap$maestrosapertura');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Cuentas.Count - 1 do
        begin
         dCuenta := Cuentas.Items[i];
         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "cap$maestrosapertura".ID_AGENCIA,');
         IBSql1.SQL.Add('  "cap$maestrosapertura".ID_TIPO_CAPTACION,');
         IBSql1.SQL.Add('  "cap$maestrosapertura".NUMERO_CUENTA,');
         IBSql1.SQL.Add('  "cap$maestrosapertura".DIGITO_CUENTA,');
         IBSql1.SQL.Add('  "cap$maestrosapertura".FECHA,');
         IBSql1.SQL.Add('  "cap$maestrosapertura".HORA,');
         IBSql1.SQL.Add('  "cap$maestrosapertura".EFECTIVO,');
         IBSql1.SQL.Add('  "cap$maestrosapertura".CHEQUE');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "cap$maestrosapertura"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "cap$maestrosapertura".ID_AGENCIA = :ID_AGENCIA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrosapertura".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrosapertura".NUMERO_CUENTA = :NUMERO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$maestrosapertura".DIGITO_CUENTA = :DIGITO_CUENTA');
         IBSql1.ParamByName('ID_AGENCIA').AsInteger := dCuenta.Id_Agencia;
         IBSql1.ParamByName('ID_TIPO_CAPTACION').AsInteger := dCuenta.Id_Tipo_Captacion;
         IBSql1.ParamByName('NUMERO_CUENTA').AsInteger := dCuenta.Numero_Cuenta;
         IBSql1.ParamByName('DIGITO_CUENTA').AsInteger := dCuenta.Digito_Cuenta;
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                 Nodo3.Value := IBSql1.Fields[j].AsString;
             end;
           end;
         except
           IBTransaction1.Rollback;
           raise;
           Exit;
         end;
        end;
        CheckBox5.Checked := True;
// Fin Lectura Maestro Apertura

// Lectura Extractos
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','cap$extracto');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Cuentas.Count - 1 do
        begin
         dCuenta := Cuentas.Items[i];
         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "cap$extracto".ID_AGENCIA,');
         IBSql1.SQL.Add('  "cap$extracto".ID_TIPO_CAPTACION,');
         IBSql1.SQL.Add('  "cap$extracto".NUMERO_CUENTA,');
         IBSql1.SQL.Add('  "cap$extracto".DIGITO_CUENTA,');
         IBSql1.SQL.Add('  "cap$extracto".FECHA_MOVIMIENTO,');
         IBSql1.SQL.Add('  "cap$extracto".HORA_MOVIMIENTO,');
         IBSql1.SQL.Add('  "cap$extracto".ID_TIPO_MOVIMIENTO,');
         IBSql1.SQL.Add('  "cap$extracto".DOCUMENTO_MOVIMIENTO,');
         IBSql1.SQL.Add('  "cap$extracto".DESCRIPCION_MOVIMIENTO,');
         IBSql1.SQL.Add('  "cap$extracto".VALOR_DEBITO,');
         IBSql1.SQL.Add('  "cap$extracto".VALOR_CREDITO');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "cap$extracto"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "cap$extracto".ID_AGENCIA = :ID_AGENCIA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$extracto".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$extracto".NUMERO_CUENTA = :NUMERO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$extracto".DIGITO_CUENTA = :DIGITO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$extracto".FECHA_MOVIMIENTO BETWEEN :FECHA1 and :FECHA2');
         IBSql1.ParamByName('ID_AGENCIA').AsInteger := dCuenta.Id_Agencia;
         IBSql1.ParamByName('ID_TIPO_CAPTACION').AsInteger := dCuenta.Id_Tipo_Captacion;
         IBSql1.ParamByName('NUMERO_CUENTA').AsInteger := dCuenta.Numero_Cuenta;
         IBSql1.ParamByName('DIGITO_CUENTA').AsInteger := dCuenta.Digito_Cuenta;
         IBSql1.ParamByName('FECHA1').AsDate := Fecha1;
         IBSql1.ParamByName('FECHA2').AsDate := Fecha2;
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           while not IBSql1.Eof do
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
               if IBSql1.FieldDefs.Items[j].DataType = fttime then
                begin
                  Nodo3 := Nodo2.Items.Add('campo',FormatDateTime('hh:mm:ss',IBSql1.Fields.Fields[j].AsDateTime));
                  Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                  Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                  Nodo3.Value := IBSql1.Fields[j].AsString;
                end
                else
                begin
                  Nodo3 := Nodo2.Items.Add('campo');
                  Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                  Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                  Nodo3.Value := IBSql1.Fields[j].AsString;
                end;
             end;
             IBSql1.Next;
           end;
         except
           IBSql1.Transaction.Rollback;
           raise;
           Exit;
         end;
        end; // fin del for de cuentas
        CheckBox6.Checked := True;
// Fin Lectura Extractos

// Lectura Tabla Liquidacion Cdats
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','cap$tablaliquidacion');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Cuentas.Count - 1 do
        begin
         dCuenta := Cuentas.Items[i];
         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "cap$tablaliquidacion".ID_AGENCIA,');
         IBSql1.SQL.Add('  "cap$tablaliquidacion".ID_TIPO_CAPTACION,');
         IBSql1.SQL.Add('  "cap$tablaliquidacion".NUMERO_CUENTA,');
         IBSql1.SQL.Add('  "cap$tablaliquidacion".DIGITO_CUENTA,');
         IBSql1.SQL.Add('  "cap$tablaliquidacion".FECHA_PAGO,');
         IBSql1.SQL.Add('  "cap$tablaliquidacion".VALOR,');
         IBSql1.SQL.Add('  "cap$tablaliquidacion".PAGADO');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "cap$tablaliquidacion"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "cap$tablaliquidacion".ID_AGENCIA = :ID_AGENCIA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$tablaliquidacion".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$tablaliquidacion".NUMERO_CUENTA = :NUMERO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$tablaliquidacion".DIGITO_CUENTA = :DIGITO_CUENTA');
         IBSql1.ParamByName('ID_AGENCIA').AsInteger := dCuenta.Id_Agencia;
         IBSql1.ParamByName('ID_TIPO_CAPTACION').AsInteger := dCuenta.Id_Tipo_Captacion;
         IBSql1.ParamByName('NUMERO_CUENTA').AsInteger := dCuenta.Numero_Cuenta;
         IBSql1.ParamByName('DIGITO_CUENTA').AsInteger := dCuenta.Digito_Cuenta;
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           while not IBSql1.Eof do
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                 Nodo3.Value := IBSql1.Fields[j].AsString;
             end;
             IBSql1.Next;
           end;
         except
           IBSql1.Transaction.Rollback;
           raise;
           Exit;
         end;
        end; // fin del for de cuentas
        CheckBox7.Checked := True;
// Fin Lectura Tabla Liquidacion Cdats

// Lectura Tabla Liquidacion Contractural
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','cap$tablaliquidacioncon');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Cuentas.Count - 1 do
        begin
         dCuenta := Cuentas.Items[i];
         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "cap$tablaliquidacioncon".ID_AGENCIA,');
         IBSql1.SQL.Add('  "cap$tablaliquidacioncon".ID_TIPO_CAPTACION,');
         IBSql1.SQL.Add('  "cap$tablaliquidacioncon".NUMERO_CUENTA,');
         IBSql1.SQL.Add('  "cap$tablaliquidacioncon".DIGITO_CUENTA,');
         IBSql1.SQL.Add('  "cap$tablaliquidacioncon".FECHA_DESCUENTO,');
         IBSql1.SQL.Add('  "cap$tablaliquidacioncon".VALOR,');
         IBSql1.SQL.Add('  "cap$tablaliquidacioncon".DESCONTADO');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "cap$tablaliquidacioncon"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "cap$tablaliquidacioncon".ID_AGENCIA = :ID_AGENCIA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$tablaliquidacioncon".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$tablaliquidacioncon".NUMERO_CUENTA = :NUMERO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$tablaliquidacioncon".DIGITO_CUENTA = :DIGITO_CUENTA');
         IBSql1.ParamByName('ID_AGENCIA').AsInteger := dCuenta.Id_Agencia;
         IBSql1.ParamByName('ID_TIPO_CAPTACION').AsInteger := dCuenta.Id_Tipo_Captacion;
         IBSql1.ParamByName('NUMERO_CUENTA').AsInteger := dCuenta.Numero_Cuenta;
         IBSql1.ParamByName('DIGITO_CUENTA').AsInteger := dCuenta.Digito_Cuenta;
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           while not IBSql1.Eof do
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                 Nodo3.Value := IBSql1.Fields[j].AsString;
             end;
             IBSql1.Next;
           end;
         except
           IBSql1.Transaction.Rollback;
           raise;
           Exit;
         end;
        end; // fin del for de cuentas
        CheckBox8.Checked := True;
// Fin Lectura Tabla Liquidacion Contractual

// Lectura tabla saldos iniciales mes

        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','cap$saldosmes');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Cuentas.Count - 1 do
        begin
         dCuenta := Cuentas.Items[i];
         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "cap$saldosmes".ID_AGENCIA,');
         IBSql1.SQL.Add('  "cap$saldosmes".ID_TIPO_CAPTACION,');
         IBSql1.SQL.Add('  "cap$saldosmes".NUMERO_CUENTA,');
         IBSql1.SQL.Add('  "cap$saldosmes".DIGITO_CUENTA,');
         IBSql1.SQL.Add('  "cap$saldosmes".ANO,');
         IBSql1.SQL.Add('  "cap$saldosmes".MES,');
         IBSql1.SQL.Add('  "cap$saldosmes".SALDOINICIAL');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "cap$saldosmes"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "cap$saldosmes".ID_AGENCIA = :ID_AGENCIA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$saldosmes".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$saldosmes".NUMERO_CUENTA = :NUMERO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$saldosmes".DIGITO_CUENTA = :DIGITO_CUENTA');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "cap$saldosmes".ANO = :ANO');
         IBSql1.ParamByName('ID_AGENCIA').AsInteger := dCuenta.Id_Agencia;
         IBSql1.ParamByName('ID_TIPO_CAPTACION').AsInteger := dCuenta.Id_Tipo_Captacion;
         IBSql1.ParamByName('NUMERO_CUENTA').AsInteger := dCuenta.Numero_Cuenta;
         IBSql1.ParamByName('DIGITO_CUENTA').AsInteger := dCuenta.Digito_Cuenta;
         IBSql1.ParamByName('ANO').AsInteger := yearof(Now);
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           while not IBSql1.Eof do
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                 Nodo3.Value := IBSql1.Fields[j].AsString;
             end;
             IBSql1.Next;
           end;
         except
           IBSql1.Transaction.Rollback;
           raise;
           Exit;
         end;
        end; // fin del for de cuentas
        CheckBox9.Checked := True;
// Fin Lectura Tabla Liquidacion Contractual


// Inicio Traslado de Solicitudes
        vAnalista := 'WURIBE';
        vContador := 1;
        vTabla := False;
        vId_Persona := EdDocumento.Text;
        vId_Identificacion := EdTipo.Value;
        with IBSql1 do
        begin
          SQL.Clear;
          SQL.Add('select * from "col$solicitud" where ID_PERSONA = :ID_PERSONA and ID_IDENTIFICACION = :ID_IDENTIFICACION');
          ParamByName('ID_PERSONA').AsString := vId_Persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vId_Identificacion;
          Open;
          if RecordCount > 0 then //registro de solicitudes
          begin
              Nodo1  := xml.Root.Items.Add('tabla');
              Nodo1.Properties.Add('nombre','col$solicitud');
            while not Eof do
            begin
              Nodo2 := Nodo1.Items.Add('Registro');
              for i := 0 to FieldDefs.Count -1 do begin
                 Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
              end;
              CdSolicitud.Append;
              CdSolicitud.FieldValues['ID_SOLICITUD'] := FieldByName('ID_SOLICITUD').AsString;
              CdSolicitud.Post;
              Next;
            end;

            yaExiste := False;

            for k := 0 to Personas.Count - 1 do
            begin
               dPersona  := Personas.Items[k];
               if (dPersona.id = IBSql1.Fields[2].AsInteger) and
                  (dPersona.persona = IBSql1.Fields[1].AsString) then
                  yaExiste := True;
            end;

            if not yaExiste then
             begin
              New(dPersona);
              dPersona.id := IBSql1.Fields[2].AsInteger;
              dPersona.persona := IBSql1.Fields[1].AsString;
              Personas.Add(dPersona);
             end;
          end; //fin registro de solicitudes
          // busqueda de codeudores
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$codeudor" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$codeudor');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                   vContador := vContador + 1;

                   yaExiste := False;

                   for k := 0 to Personas.Count - 1 do
                    begin
                      dPersona  := Personas.Items[k];
                      if (dPersona.id = IBSql1.Fields[2].AsInteger) and
                        (dPersona.persona = IBSql1.Fields[1].AsString) then
                      yaExiste := True;
                    end;

                   if not yaExiste then
                    begin
                      New(dPersona);
                      dPersona.id := IBSql1.Fields[2].AsInteger;
                      dPersona.persona := IBSql1.Fields[1].AsString;
                      Personas.Add(dPersona);
                    end;

                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin del registra codeudor
          // busqueda de conyuges
          vTabla := False;
          vContador := 0;
          SQL.Clear;
          SQL.Add('select * from "col$infconyuge" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$infconyuge');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin del registra conyuges
          // busqueda de referencias
          Close;
          SQL.Clear;
          SQL.Add('select * from "col$referencias" where ID_PERSONA = :ID_PERSONA  and ID_IDENTIFICACION = :ID_IDENTIFICACION');
          ParamByName('ID_PERSONA').AsString := vId_Persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vId_Identificacion;
          Open;
          if RecordCount > 0 then //registro de solicitudes
          begin
              Nodo1  := xml.Root.Items.Add('tabla');
              Nodo1.Properties.Add('nombre','col$referencias');
            while not Eof do
            begin
              Nodo2 := Nodo1.Items.Add('Registro');
              for i := 0 to FieldDefs.Count -1 do begin
                 Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
              end;
              Next;
            end;
          end; //fin registro de referencias solicitud
          // busqueda entardas de las solicitudes
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$referenciasolicitud" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$referenciasolicitud');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin entradas de las solicitudes
          // busqueda registros de sesion
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$registrosesion" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$registrosesion');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                 begin
                   if FieldDefs.Items[i].DataType = fttime then begin
                      Nodo3 := Nodo2.Items.Add('campo',FormatDateTime('hh:mm:ss',Fields.Fields[i].AsDateTime));
                      Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                      Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                   end
                   else begin
                      Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                      Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                      Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                   end
                 end;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin consulta de registro de sesion
          // registro de la entrada de los analistas
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$solicitudanalista" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$solicitudanalista');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                 begin
                   if i = 2 then begin
                      Nodo3 := Nodo2.Items.Add('campo',vAnalista);
                      Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                      Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                   end
                   else
                   begin
                   if FieldDefs.Items[i].DataType = ftdatetime then begin
                      Nodo3 := Nodo2.Items.Add('campo',FormatDateTime('yyyy/mm/dd hh:mm:ss',Fields.Fields[i].AsDateTime));
                      Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                      Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                   end
                   else begin
                      Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                      Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                      Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                   end;
                   end;
                 end;
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin consulta de los analista
          // consulta de los requisisitos
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$solicitudrequisito" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$solicitudrequisito');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin consulta de los requisistos
          // consulta de los requisisitos
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$observacion" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$observacion');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin consulta de la observaciones del analista
          // consulta bien raiz
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "gen$bienesraices" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','gen$bienesraices');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //consulta infromacion crediticia
          // consulta bien raiz
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "gen$infcrediticia" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','gen$infcrediticia');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin consulta bien raiz
          Close;  // consulta de informacion de persona infpersona
          SQL.Clear;
          SQL.Add('select * from "gen$infpersona" where ID_PERSONA = :ID_PERSONA  and ID_IDENTIFICACION = :ID_IDENTIFICACION');
          ParamByName('ID_PERSONA').AsString := vId_Persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vId_Identificacion;
          Open;
          if RecordCount > 0 then //registro de solicitudes
          begin
              Nodo1  := xml.Root.Items.Add('tabla');
              Nodo1.Properties.Add('nombre','gen$infpersona');
            while not Eof do
            begin
              Nodo2 := Nodo1.Items.Add('Registro');
              for i := 0 to FieldDefs.Count -1 do begin
                 Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
              end;
              Next;
            end;
          end; //fin consulat de informacion adicional de la persona
          Close;// consulta de vehiculos
          SQL.Clear;
          SQL.Add('select * from "gen$vehiculo" where ID_PERSONA = :ID_PERSONA  and ID_IDENTIFICACION = :ID_IDENTIFICACION');
          ParamByName('ID_PERSONA').AsString := vId_Persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vId_Identificacion;
          Open;
          if RecordCount > 0 then //registro de solicitudes
          begin
              Nodo1  := xml.Root.Items.Add('tabla');
              Nodo1.Properties.Add('nombre','gen$vehiculo');
            while not Eof do
            begin
              Nodo2 := Nodo1.Items.Add('Registro');
              for i := 0 to FieldDefs.Count -1 do begin
                 Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
              end;
              Next;
            end;
          end; //fin consulta de vehiculos
//        end;

// Fin Traslado de Solicitudes


// Inicio Traslado de Cartera
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$colocacion" where ID_PERSONA = :ID_PERSONA and ID_IDENTIFICACION = :ID_IDENTIFICACION and ID_ESTADO_COLOCACION IN (0,2,3,8,9)');
          ParamByName('ID_PERSONA').AsString := EdDocumento.Text;
          ParamByName('ID_IDENTIFICACION').AsInteger := EdTipo.Value;
          Open;

          if RecordCount > 0 then //registro de Colocaciones
          begin
              Nodo1  := xml.Root.Items.Add('tabla');
              Nodo1.Properties.Add('nombre','col$colocacion');
            while not Eof do
            begin
              Nodo2 := Nodo1.Items.Add('Registro');
              Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
              Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
              Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));

              for i := 1 to FieldDefs.Count -1 do begin
                Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
              end;
              CDcartera.Append;
              CDcartera.FieldValues['ID_COLOCACION'] := FieldByName('ID_COLOCACION').AsString;
              CDcartera.FieldValues['CLASIFICACION'] := FieldByName('ID_CLASIFICACION').AsInteger;
              CDcartera.FieldValues['GARANTIA'] := FieldByName('ID_GARANTIA').AsInteger;
              CDcartera.FieldValues['CATEGORIA'] := FieldByName('ID_EVALUACION').AsString;
              CDcartera.Post;

              yaExiste := False;

              for k := 0 to Personas.Count - 1 do
               begin
                 dPersona  := Personas.Items[k];
                 if (dPersona.id = IBSql1.Fields[2].AsInteger) and
                   (dPersona.persona = Trim(IBSql1.Fields[3].AsString)) then
                 yaExiste := True;
               end;

              if not yaExiste then
               begin
                 New(dPersona);
                 dPersona.id := IBSql1.Fields[2].AsInteger;
                 dPersona.persona := Trim(IBSql1.Fields[3].AsString);
                 Personas.Add(dPersona);
               end;

              Next;
            end;
           end; //fin registro de Colocaciones

          // Busqueda de extracto
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$extracto" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$extracto');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));
                 for i := 1 to FieldDefs.Count -1 do
                   if FieldDefs.Items[i].DataType = fttime then begin
                      Nodo3 := Nodo2.Items.Add('campo',FormatDateTime('hh:mm:ss',Fields.Fields[i].AsDateTime));
                      Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                      Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                   end
                   else
                    begin
                      Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                      Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                      Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                   end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //fin del registra extracto

          // Busqueda de Extracto Detallado
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$extractodet" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$extractodet');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));
                 for i := 1 to FieldDefs.Count -1 do
                  begin
                   if FieldDefs.Items[i].DataType = fttime then begin
                      Nodo3 := Nodo2.Items.Add('campo',FormatDateTime('hh:mm:ss',Fields.Fields[i].AsDateTime));
                      Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                      Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                   end
                   else begin
                      Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                      Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                      Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                   end;
                  end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //fin del registra Extracto Detallado

          // Busqueda de Garantias Personales
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$colgarantias" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$colgarantias');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));
                 for i := 1 to FieldDefs.Count -1 do begin
                    Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                    Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                    Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                 yaExiste := False;

                  for k := 0 to Personas.Count - 1 do
                   begin
                     dPersona  := Personas.Items[k];
                     if (dPersona.id = IBSql1.Fields[2].AsInteger) and
                       (dPersona.persona = Trim(IBSql1.Fields[3].AsString)) then
                     yaExiste := True;
                   end;

                  if not yaExiste then
                   begin
                     New(dPersona);
                     dPersona.id := IBSql1.Fields[2].AsInteger;
                     dPersona.persona := Trim(IBSql1.Fields[3].AsString);
                     Personas.Add(dPersona);
                   end;

                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin registro de Garantias Personales

          // Busqueda de Garantias Reales
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$colgarantiasreal" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$colgarantiasreal');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));
                 for i := 1 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin registro de Garantias Reales

          // Busqueda de Tabla de Liquidacion
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$tablaliquidacion" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$tablaliquidacion');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 2 then begin
                   Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                  end
                  else begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                  end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Tabla de Liquidacion

          // Busqueda Registros de Costas
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$costas" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$costas');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));
                 for i := 1 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Registro de Costas

          // Registro de Pagos Consignacion Nal
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$pagoconnal" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$pagoconnal');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));
                 for i := 1 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Pagos Consignacion Nal

          // Registro Control de Cobro
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$controlcobro" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$controlcobro');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));
                 for i := 1 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Control de Cobro

          // Registro Colocaciones en Abogados
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$colocacionabogado" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$colocacionabogado');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));
                 for i := 1 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Colocaciones en Abogados

          // Registro Cambios de Estado
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$cambioestado" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$cambioestado');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));
                 for i := 0 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Cambios de Estado

          // Registro Marcas
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$marcas" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$marcas');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 1 then begin
                   Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                  end
                  else begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                  end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Registro de Marcas

          //Inicio Provisiones de años anteriores
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$causaciondiariamov" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  Nodo1  := xml.Root.Items.Add('tabla');
                  Nodo1.Properties.Add('nombre','col$causaciondiariamov');
               end;
               while not Eof do
               begin
                 Nodo2 := Nodo1.Items.Add('Registro');
                 Nodo3 := Nodo2.Items.Add('campo',AgenciaT);
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[0].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[0].DataSize));
                 for i := 1 to FieldDefs.Count -1 do begin
                   Nodo3 := Nodo2.Items.Add('campo',Fields.Fields[i].AsString);
                   Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[i].DataType));
                   Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[i].DataSize));
                 end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Registro de Provisiones Anteriores

        end;
// Fin Traslado de Cartera



// Guardar información de Persona
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','gen$persona');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Personas.Count - 1 do
        begin
         dPersona := Personas.Items[i];

         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "gen$persona".ID_IDENTIFICACION,');
         IBSql1.SQL.Add('  "gen$persona".ID_PERSONA,');
         IBSql1.SQL.Add('  "gen$persona".LUGAR_EXPEDICION,');
         IBSql1.SQL.Add('  "gen$persona".FECHA_EXPEDICION,');
         IBSql1.SQL.Add('  "gen$persona".NOMBRE,');
         IBSql1.SQL.Add('  "gen$persona".PRIMER_APELLIDO,');
         IBSql1.SQL.Add('  "gen$persona".SEGUNDO_APELLIDO,');
         IBSql1.SQL.Add('  "gen$persona".ID_TIPO_PERSONA,');
         IBSql1.SQL.Add('  "gen$persona".SEXO,');
         IBSql1.SQL.Add('  "gen$persona".FECHA_NACIMIENTO,');
         IBSql1.SQL.Add('  "gen$persona".LUGAR_NACIMIENTO,');
         IBSql1.SQL.Add('  "gen$persona".PROVINCIA_NACIMIENTO,');
         IBSql1.SQL.Add('  "gen$persona".DEPTO_NACIMIENTO,');
         IBSql1.SQL.Add('  "gen$persona".PAIS_NACIMIENTO,');
         IBSql1.SQL.Add('  "gen$persona".ID_TIPO_ESTADO_CIVIL,');
         IBSql1.SQL.Add('  "gen$persona".ID_CONYUGE,');
         IBSql1.SQL.Add('  "gen$persona".ID_IDENTIFICACION_CONYUGE,');
         IBSql1.SQL.Add('  "gen$persona".NOMBRE_CONYUGE,');
         IBSql1.SQL.Add('  "gen$persona".PRIMER_APELLIDO_CONYUGE,');
         IBSql1.SQL.Add('  "gen$persona".SEGUNDO_APELLIDO_CONYUGE,');
         IBSql1.SQL.Add('  "gen$persona".ID_APODERADO,');
         IBSql1.SQL.Add('  "gen$persona".ID_IDENTIFICACION_APODERADO,');
         IBSql1.SQL.Add('  "gen$persona".NOMBRE_APODERADO,');
         IBSql1.SQL.Add('  "gen$persona".PRIMER_APELLIDO_APODERADO,');
         IBSql1.SQL.Add('  "gen$persona".SEGUNDO_APELLIDO_APODERADO,');
         IBSql1.SQL.Add('  "gen$persona".PROFESION,');
         IBSql1.SQL.Add('  "gen$persona".ID_ESTADO,');
         IBSql1.SQL.Add('  "gen$persona".ID_TIPO_RELACION,');
         IBSql1.SQL.Add('  "gen$persona".ID_CIIU,');
         IBSql1.SQL.Add('  "gen$persona".EMPRESA_LABORA,');
         IBSql1.SQL.Add('  "gen$persona".FECHA_INGRESO_EMPRESA,');
         IBSql1.SQL.Add('  "gen$persona".CARGO_ACTUAL,');
         IBSql1.SQL.Add('  "gen$persona".DECLARACION,');
         IBSql1.SQL.Add('  "gen$persona".INGRESOS_A_PRINCIPAL,');
         IBSql1.SQL.Add('  "gen$persona".INGRESOS_OTROS,');
         IBSql1.SQL.Add('  "gen$persona".INGRESOS_CONYUGE,');
         IBSql1.SQL.Add('  "gen$persona".INGRESOS_CONYUGE_OTROS,');
         IBSql1.SQL.Add('  "gen$persona".DESC_INGR_OTROS,');
         IBSql1.SQL.Add('  "gen$persona".EGRESOS_ALQUILER,');
         IBSql1.SQL.Add('  "gen$persona".EGRESOS_SERVICIOS,');
         IBSql1.SQL.Add('  "gen$persona".EGRESOS_TRANSPORTE,');
         IBSql1.SQL.Add('  "gen$persona".EGRESOS_ALIMENTACION,');
         IBSql1.SQL.Add('  "gen$persona".EGRESOS_DEUDAS,');
         IBSql1.SQL.Add('  "gen$persona".EGRESOS_OTROS,');
         IBSql1.SQL.Add('  "gen$persona".DESC_EGRE_OTROS,');
         IBSql1.SQL.Add('  "gen$persona".EGRESOS_CONYUGE,');
         IBSql1.SQL.Add('  "gen$persona".OTROS_EGRESOS_CONYUGE,');
         IBSql1.SQL.Add('  "gen$persona".TOTAL_ACTIVOS,');
         IBSql1.SQL.Add('  "gen$persona".TOTAL_PASIVOS,');
         IBSql1.SQL.Add('  "gen$persona".EDUCACION,');
         IBSql1.SQL.Add('  "gen$persona".RETEFUENTE,');
         IBSql1.SQL.Add('  "gen$persona".ACTA,');
         IBSql1.SQL.Add('  "gen$persona".FECHA_REGISTRO,');
         IBSql1.SQL.Add('  "gen$persona".FOTO,');
         IBSql1.SQL.Add('  "gen$persona".FIRMA,');
         IBSql1.SQL.Add('  "gen$persona".ESCRITURA_CONSTITUCION,');
         IBSql1.SQL.Add('  "gen$persona".DURACION_SOCIEDAD,');
         IBSql1.SQL.Add('  "gen$persona".CAPITAL_SOCIAL,');
         IBSql1.SQL.Add('  "gen$persona".MATRICULA_MERCANTIL,');
         IBSql1.SQL.Add('  "gen$persona".FOTO_HUELLA,');
         IBSql1.SQL.Add('  "gen$persona".DATOS_HUELLA,');
         IBSql1.SQL.Add('  "gen$persona".EMAIL,');
         IBSql1.SQL.Add('  "gen$persona".ID_EMPLEADO,');
         IBSql1.SQL.Add('  "gen$persona".FECHA_ACTUALIZACION');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "gen$persona"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "gen$persona".ID_IDENTIFICACION = :ID_IDENTIFICACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "gen$persona".ID_PERSONA = :ID_PERSONA');
         IBSql1.ParamByName('ID_IDENTIFICACION').AsInteger := dPersona.id;
         IBSql1.ParamByName('ID_PERSONA').AsString := dPersona.persona;
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 if IBSql1.Fields[j].DataType in [ ftBlob, ftGraphic ] then begin
                    fO := SZFullEncodeOnlyBase64(IBSql1.Fields[j].AsString);
                    Nodo3.Value := fO;
                    Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                    Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                 end
                 else begin
                    Nodo3.Value := IBSql1.Fields[j].AsString;
                    Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                    Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
                 end;
             end;
           end;
         except
           IBTransaction1.Rollback;
           raise;
           Exit;
         end;
        end;
        CheckBox10.Checked := True;

// Fin Información de Personas

// Lectura Información Direcciones Persona
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','gen$direccion');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Personas.Count - 1 do
        begin
         dPersona := Personas.Items[i];

         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "gen$direccion".ID_IDENTIFICACION,');
         IBSql1.SQL.Add('  "gen$direccion".ID_PERSONA,');
         IBSql1.SQL.Add('  "gen$direccion".CONSECUTIVO,');
         IBSql1.SQL.Add('  "gen$direccion".ID_DIRECCION,');
         IBSql1.SQL.Add('  "gen$direccion".DIRECCION,');
         IBSql1.SQL.Add('  "gen$direccion".BARRIO,');
         IBSql1.SQL.Add('  "gen$direccion".COD_MUNICIPIO,');
         IBSql1.SQL.Add('  "gen$direccion".MUNICIPIO,');
         IBSql1.SQL.Add('  "gen$direccion".TELEFONO1,');
         IBSql1.SQL.Add('  "gen$direccion".TELEFONO2,');
         IBSql1.SQL.Add('  "gen$direccion".TELEFONO3,');
         IBSql1.SQL.Add('  "gen$direccion".TELEFONO4');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "gen$direccion"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "gen$direccion".ID_IDENTIFICACION = :ID_IDENTIFICACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "gen$direccion".ID_PERSONA = :ID_PERSONA');
         IBSql1.ParamByName('ID_IDENTIFICACION').AsInteger := dPersona.id;
         IBSql1.ParamByName('ID_PERSONA').AsString := dPersona.persona;
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           while not IBSql1.Eof do
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 Nodo3.Value := IBSql1.Fields[j].AsString;
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
             end;
             IBSql1.Next;
           end;
         except
           IBSql1.Transaction.Rollback;
           raise;
           Exit;
         end;
        end; // fin del for de cuentas
        CheckBox11.Checked := True;

// Fin Lectura Direcciones

// Lectura Información Referencias Persona
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','gen$referencias');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Personas.Count - 1 do
        begin
         dPersona := Personas.Items[i];

         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "gen$referencias".TIPO_ID_REFERENCIA,');
         IBSql1.SQL.Add('  "gen$referencias".ID_REFERENCIA,');
         IBSql1.SQL.Add('  "gen$referencias".CONSECUTIVO_REFERENCIA,');
         IBSql1.SQL.Add('  "gen$referencias".PRIMER_APELLIDO_REFERENCIA,');
         IBSql1.SQL.Add('  "gen$referencias".SEGUNDO_APELLIDO_REFERENCIA,');
         IBSql1.SQL.Add('  "gen$referencias".NOMBRE_REFERENCIA,');
         IBSql1.SQL.Add('  "gen$referencias".DIRECCION_REFERENCIA,');
         IBSql1.SQL.Add('  "gen$referencias".TELEFONO_REFERENCIA,');
         IBSql1.SQL.Add('  "gen$referencias".TIPO_REFERENCIA,');
         IBSql1.SQL.Add('  "gen$referencias".PARENTESCO_REFERENCIA');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "gen$referencias"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "gen$referencias".TIPO_ID_REFERENCIA = :ID_IDENTIFICACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "gen$referencias".ID_REFERENCIA = :ID_PERSONA');
         IBSql1.ParamByName('ID_IDENTIFICACION').AsInteger := dPersona.id;
         IBSql1.ParamByName('ID_PERSONA').AsString := dPersona.persona;
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           while not IBSql1.Eof do
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 Nodo3.Value := IBSql1.Fields[j].AsString;
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
             end;
             IBSql1.Next;
           end;
         except
           IBSql1.Transaction.Rollback;
           raise;
           Exit;
         end;
        end; // fin del for de cuentas
        CheckBox12.Checked := True;

// Fin Lectura Referencia

// Lectura Información Beneficiarios de la Persona
        Nodo1 := xml.Root.Items.Add('tabla');
        Nodo1.Properties.Add('nombre','gen$beneficiario');

// Procesar datos adicionales de cada cuenta.
        for i := 0 to Personas.Count - 1 do
        begin
         dPersona := Personas.Items[i];

         IBSql1.Close;
         IBSql1.SQL.Clear;
         IBSql1.SQL.Add('SELECT ');
         IBSql1.SQL.Add('  "gen$beneficiario".ID_AGENCIA,');
         IBSql1.SQL.Add('  "gen$beneficiario".ID_PERSONA,');
         IBSql1.SQL.Add('  "gen$beneficiario".ID_IDENTIFICACION,');
         IBSql1.SQL.Add('  "gen$beneficiario".CONSECUTIVO,');
         IBSql1.SQL.Add('  "gen$beneficiario".PRIMER_APELLIDO,');
         IBSql1.SQL.Add('  "gen$beneficiario".SEGUNDO_APELLIDO,');
         IBSql1.SQL.Add('  "gen$beneficiario".NOMBRE,');
         IBSql1.SQL.Add('  "gen$beneficiario".ID_PARENTESCO,');
         IBSql1.SQL.Add('  "gen$beneficiario".PORCENTAJE,');
         IBSql1.SQL.Add('  "gen$beneficiario".AUXILIO');
         IBSql1.SQL.Add('FROM');
         IBSql1.SQL.Add(' "gen$beneficiario"');
         IBSql1.SQL.Add('WHERE');
         IBSql1.SQL.Add(' "gen$beneficiario".ID_IDENTIFICACION = :ID_IDENTIFICACION');
         IBSql1.SQL.Add('AND');
         IBSql1.SQL.Add(' "gen$beneficiario".ID_PERSONA = :ID_PERSONA');
         IBSql1.ParamByName('ID_IDENTIFICACION').AsInteger := dPersona.id;
         IBSql1.ParamByName('ID_PERSONA').AsString := dPersona.persona;
         try
           IBSql1.Open;
           if IBSql1.RecordCount > 0 then
           while not IBSql1.Eof do
           begin
             Nodo2 := Nodo1.Items.Add('registro');
             for j := 0 to IBSql1.FieldCount - 1 do
             begin
                 Nodo3 := Nodo2.Items.Add('campo');
                 Nodo3.Value := IBSql1.Fields[j].AsString;
                 Nodo3.Properties.Add('tipo',fldtostr(IBSql1.Fields[j].DataType));
                 Nodo3.Properties.Add('Size',IntToStr(IBSql1.Fields[j].DataSize));
             end;
             IBSql1.Next;
           end;
         except
           IBSql1.Transaction.Rollback;
           raise;
           Exit;
         end;
        end; // fin del for de cuentas
        CheckBox13.Checked := True;

// Fin Lectura Referencia
end;

procedure TfrmServerTraslados.Contabilizar;
var
i:Integer;
Saldo:Currency;
SaldoK,ProvK,Costas,ProvI,ProvC,Causados,Anticipados,Contingentes:Currency;
CodAportes,CodAhorros,CodCausaCdat,CodCausaContractual:string;
CodDControl,CodCont,CodAcCont,CodOHip,CodOCdat,CredAprob:string;
SucK,SucCxC,SucProv,SucOPas:string;
SucAportes,SucAhorros:string;
TotalAportes,TotalAhorros:Currency;
Dias,DiasCxC,DiasContingencia,DiasCalc,DiasCorrientes,DiasANT,DiasCON:Integer;
FechaFinal,FechaInicial,FechaCorte,FechaDesembolso:TDate;
Tasa,Tasa1,TasaViv,TasaAnt:Double;
Bisiesto:Boolean;
ListaFechas:TList;
AFechas:PFechasLiq;
begin
  Nodo1 := xml.Root.Items.Add('tabla');
  Nodo1.Properties.Add('nombre','con$auxiliar');
  //INICIO DEPOSITOS
   TotalAportes := 0;
   TotalAhorros := 0;
   for i := 0 to Cuentas.Count - 1 do begin
     dCuenta := Cuentas.Items[i];
     Saldo := 0;
     if dCuenta.Id_Tipo_Captacion = 1 then begin //Es aportes
       IBSql3.Close;
       IBSql3.SQL.Clear;
       IBSql3.SQL.Add('SELECT CODIGO_CONTABLE from "cap$contable" where ID_CAPTACION = :ID_CAP AND ID_CONTABLE = :ID_CONTABLE');
       IBSql3.ParamByName('ID_CAP').AsInteger := DCUENTA.Id_Tipo_Captacion;
       if AgenciaT = 1 then
         IBSql3.ParamByName('ID_CONTABLE').AsInteger := 16
       else if AgenciaT = 2 then
         IBSql3.ParamByName('ID_CONTABLE').AsInteger := 17
       else if AgenciaT = 3 then
        IBSql3.ParamByName('ID_CONTABLE').AsInteger := 18
       else if AgenciaT = 4 then
        IBSql3.ParamByName('ID_CONTABLE').AsInteger := 19;
       IBSql3.Open;
       SucAportes := IBSql3.FieldByName('CODIGO_CONTABLE').AsString;
       IBSql3.Close;

       IBSql3.Close;
       IBSql3.SQL.Clear;
       IBSql3.SQL.Add('SELECT SALDO_ACTUAL FROM SALDO_ACTUAL(:AG,:TP,:CTA,:DGT,:ANO,:FECHA1,:FECHA2)');
       IBSql3.ParamByName('AG').AsInteger := dCuenta.Id_Agencia;
       IBSql3.ParamByName('TP').AsInteger := dCuenta.Id_Tipo_Captacion;
       IBSql3.ParamByName('CTA').AsInteger := dCuenta.Numero_Cuenta;
       IBSql3.ParamByName('DGT').AsInteger := dCuenta.Digito_Cuenta;
       IBSql3.ParamByName('ANO').AsInteger := YearOf(Date);
       IBSql3.ParamByName('FECHA1').AsDate := EncodeDate(YearOf(Date),01,01);
       IBSql3.ParamByName('FECHA2').AsDate := Date;
       IBSql3.Open;
       Saldo := IBSql3.FieldByName('SALDO_ACTUAL').AsCurrency;
       TotalAportes := TotalAportes + Saldo;
       IBSql3.Close;

       if Saldo > 0 then begin
         Nodo2 := Nodo1.Items.Add('Registro');
         Nodo2.Items.Add('campo',dCuenta.CodContable);
         Nodo2.Items.Add('campo',CurrToStr(Saldo));
       end;
     end // FIN APORTES
     else
     begin //ES DEPOSITOS
       IBSql3.Close;
       IBSql3.SQL.Clear;
       IBSql3.SQL.Add('SELECT CODIGO_CONTABLE from "cap$contable" where ID_CAPTACION = :ID_CAP AND ID_CONTABLE = :ID_CONTABLE');
       IBSql3.ParamByName('ID_CAP').AsInteger := 2;
       if AgenciaT = 1 then
         IBSql3.ParamByName('ID_CONTABLE').AsInteger := 16
       else if AgenciaT = 2 then
         IBSql3.ParamByName('ID_CONTABLE').AsInteger := 17
       else if AgenciaT = 3 then
         IBSql3.ParamByName('ID_CONTABLE').AsInteger := 18
       else if AgenciaT = 4 then
         IBSql3.ParamByName('ID_CONTABLE').AsInteger := 19;
       IBSql3.Open;
       SucAhorros := IBSql3.FieldByName('CODIGO_CONTABLE').AsString;
       IBSql3.Close;

       IBSql3.Close;
       IBSql3.SQL.Clear;
       IBSql3.SQL.Add('SELECT SALDO_ACTUAL FROM SALDO_ACTUAL(:AG,:TP,:CTA,:DGT,:ANO,:FECHA1,:FECHA2)');
       IBSql3.ParamByName('AG').AsInteger := DCUENTA.Id_Agencia;
       IBSql3.ParamByName('TP').AsInteger := DCUENTA.Id_Tipo_Captacion;
       IBSql3.ParamByName('CTA').AsInteger := DCUENTA.Numero_Cuenta;
       IBSql3.ParamByName('DGT').AsInteger := DCUENTA.Digito_Cuenta;
       IBSql3.ParamByName('ANO').AsInteger := YearOf(Date);
       IBSql3.ParamByName('FECHA1').AsDate := EncodeDate(YearOf(Date),01,01);
       IBSql3.ParamByName('FECHA2').AsDate := Date;
       IBSql3.Open;
       Saldo := IBSql3.FieldByName('SALDO_ACTUAL').AsCurrency;
       TotalAhorros := TotalAhorros + Saldo;
       IBSql3.Close;

       if Saldo > 0 then begin
         Nodo2 := Nodo1.Items.Add('Registro');
         Nodo2.Items.Add('campo',dCuenta.CodContable);
         Nodo2.Items.Add('campo',CurrToStr(Saldo));
       end;

       //Busca Causacion de Cdat y Contractual
       if (dCuenta.Id_Tipo_Captacion = 6) then begin
         IBSql3.SQL.Clear;
         IBSql3.SQL.Add('SELECT CODIGO_PUC FROM  "cap$codigoscausacion" WHERE ES_INTERESES = 1');
         IBSql3.Open;
         CodCausaCdat := IBSql3.FieldByName('CODIGO_PUC').AsString;
         IBSql3.Close;

         IBSql3.SQL.Clear;
         IBSql3.SQL.Add('SELECT NETO_TOTAL from "cap$causacioncdat" where ID_AGENCIA = :AG AND NUMERO_CUENTA = :NUMERO');
         IBSql3.SQL.Add('AND DIGITO_CUENTA = :DIGITO AND ANO = :ANO AND MES = :MES');
         IBSql3.ParamByName('AG').AsInteger := DCUENTA.Id_Agencia;
         IBSql3.ParamByName('NUMERO').AsInteger := DCUENTA.Numero_Cuenta;
         IBSql3.ParamByName('DIGITO').AsInteger := DCUENTA.Digito_Cuenta;
         IBSql3.ParamByName('ANO').AsString := IntToStr(YearOf(Date));
         IBSql3.ParamByName('MES').AsInteger := (MonthOf(Date) - 1);
         IBSql3.Open;

         if IBSql3.FieldByName('NETO_TOTAL').AsCurrency > 0 then begin
           Nodo2 := Nodo1.Items.Add('Registro');
           Nodo2.Items.Add('campo',CodCausaCdat);
           Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('NETO_TOTAL').AsCurrency));

           Nodo2 := Nodo1.Items.Add('Registro');
           Nodo2.Items.Add('campo',SucAhorros);
           Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('NETO_TOTAL').AsCurrency));
         end;
         IBSql3.Close;
       end;

       if (dCuenta.Id_Tipo_Captacion = 5) then begin
         IBSql3.SQL.Clear;
         IBSql3.SQL.Add('SELECT CODIGO FROM  "cap$codigoscontractual" WHERE ID_CODIGO = 2');
         IBSql3.Open;
         CodCausaContractual := IBSql3.FieldByName('CODIGO').AsString;
         IBSql3.Close;

         IBSql3.SQL.Clear;
         IBSql3.SQL.Add('SELECT CAUSACION_ACUMULADA from "cap$causacioncon" where ID_AGENCIA = :AG AND NUMERO_CUENTA = :NUMERO');
         IBSql3.SQL.Add('AND DIGITO_CUENTA = :DIGITO AND ANO = :ANO AND MES = :MES');
         IBSql3.ParamByName('AG').AsInteger := DCUENTA.Id_Agencia;
         IBSql3.ParamByName('NUMERO').AsInteger := DCUENTA.Numero_Cuenta;
         IBSql3.ParamByName('DIGITO').AsInteger := DCUENTA.Digito_Cuenta;
         IBSql3.ParamByName('ANO').AsString := IntToStr(YearOf(Date));
         IBSql3.ParamByName('MES').AsInteger := (MonthOf(Date) - 1);
         IBSql3.Open;

         if IBSql3.FieldByName('CAUSACION_ACUMULADA').AsCurrency > 0then begin
           Nodo2 := Nodo1.Items.Add('Registro');
           Nodo2.Items.Add('campo',CodCausaContractual);
           Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('CAUSACION_ACUMULADA').AsCurrency));

           Nodo2 := Nodo1.Items.Add('Registro');
           Nodo2.Items.Add('campo',SucAhorros);
           Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('CAUSACION_ACUMULADA').AsCurrency));
         end;
         IBSql3.Close;
       end;
     end;
   end; // Fin del For

   //Totaliza Depositos
   if TotalAportes > 0 then begin
     Nodo2 := Nodo1.Items.Add('Registro');
     Nodo2.Items.Add('campo',SucAportes);
     Nodo2.Items.Add('campo','-' + CurrToStr(TotalAportes));
   end;

   if TotalAhorros > 0 then begin
     Nodo2 := Nodo1.Items.Add('Registro');
     Nodo2.Items.Add('campo',SucAhorros);
     Nodo2.Items.Add('campo','-' + CurrToStr(TotalAhorros));
   end;
  // FIN DEPOSITOS

  // INICIO CARTERA
  with CDcartera do begin
    CDcartera.First;
    while not CDcartera.Eof do  begin
      IBSql3.SQL.Clear;
      IBSql3.SQL.Add('SELECT CODIGO FROM "col$codigospucbasicos" WHERE ID_CODIGOPUCBASICO = :ID');
      if AgenciaT = 1 then
        IBSql3.ParamByName('ID').AsInteger := 30
      else if AgenciaT = 2 then
        IBSql3.ParamByName('ID').AsInteger := 31
      else if AgenciaT = 3 then
        IBSql3.ParamByName('ID').AsInteger := 32
      else if AgenciaT = 4 then
        IBSql3.ParamByName('ID').AsInteger := 33;
      IBSql3.Open;
      SucK := IBSql3.FieldByName('CODIGO').AsString;
      IBSql3.Close;

      IBSql3.SQL.Clear;
      IBSql3.SQL.Add('SELECT CODIGO FROM "col$codigospucbasicos" WHERE ID_CODIGOPUCBASICO = :ID');
      if AgenciaT = 1 then
        IBSql3.ParamByName('ID').AsInteger := 34
      else if AgenciaT = 2 then
        IBSql3.ParamByName('ID').AsInteger := 35
      else if AgenciaT = 3 then
        IBSql3.ParamByName('ID').AsInteger := 36
      else if AgenciaT = 4 then
        IBSql3.ParamByName('ID').AsInteger := 37;
      IBSql3.Open;
      SucCxC := IBSql3.FieldByName('CODIGO').AsString;
      IBSql3.Close;

      IBSql3.SQL.Clear;
      IBSql3.SQL.Add('SELECT CODIGO FROM "col$codigospucbasicos" WHERE ID_CODIGOPUCBASICO = :ID');
      if AgenciaT = 1 then
        IBSql3.ParamByName('ID').AsInteger := 38
      else if AgenciaT = 2 then
        IBSql3.ParamByName('ID').AsInteger := 39
      else if AgenciaT = 3 then
        IBSql3.ParamByName('ID').AsInteger := 40
      else if AgenciaT = 4 then
        IBSql3.ParamByName('ID').AsInteger := 41;
      IBSql3.Open;
      SucProv := IBSql3.FieldByName('CODIGO').AsString;
      IBSql3.Close;

      IBSql3.SQL.Clear;
      IBSql3.SQL.Add('SELECT CODIGO FROM "col$codigospucbasicos" WHERE ID_CODIGOPUCBASICO = :ID');
      if AgenciaT = 1 then
        IBSql3.ParamByName('ID').AsInteger := 54
      else if AgenciaT = 2 then
        IBSql3.ParamByName('ID').AsInteger := 55
      else if AgenciaT = 3 then
        IBSql3.ParamByName('ID').AsInteger := 56
      else if AgenciaT = 4 then
        IBSql3.ParamByName('ID').AsInteger := 57;
      IBSql3.Open;
      SucOPas := IBSql3.FieldByName('CODIGO').AsString;
      IBSql3.Close;

      IBSql3.SQL.Clear;
      IBSql3.SQL.Add('SELECT CODIGO FROM "col$codigospucbasicos" WHERE ID_CODIGOPUCBASICO = :ID');
      IBSql3.ParamByName('ID').AsInteger := 42;
      IBSql3.Open;
      CodCont := IBSql3.FieldByName('CODIGO').AsString;
      IBSql3.Close;

      IBSql3.SQL.Clear;
      IBSql3.SQL.Add('SELECT CODIGO FROM "col$codigospucbasicos" WHERE ID_CODIGOPUCBASICO = :ID');
      IBSql3.ParamByName('ID').AsInteger := 43;
      IBSql3.Open;
      CodDControl := IBSql3.FieldByName('CODIGO').AsString;
      IBSql3.Close;

      IBSql3.SQL.Clear;
      IBSql3.SQL.Add('SELECT CODIGO FROM "col$codigospucbasicos" WHERE ID_CODIGOPUCBASICO = :ID');
      IBSql3.ParamByName('ID').AsInteger := 52;
      IBSql3.Open;
      CodAcCont := IBSql3.FieldByName('CODIGO').AsString;
      IBSql3.Close;

      IBSql4.Close;
      IBSql4.SQL.Clear;
      IBSql4.SQL.Add('select * from "col$codigospuc" where ID_CLASIFICACION = :"ID_CLASIFICACION" and ');
      IBSql4.SQL.Add('ID_GARANTIA = :"ID_GARANTIA" and ID_CATEGORIA = :"ID_CATEGORIA" ');
      IBSql4.ParamByName('ID_CLASIFICACION').AsInteger := CDcartera.FieldValues['CLASIFICACION'];
      IBSql4.ParamByName('ID_GARANTIA').AsInteger := CDcartera.FieldValues['GARANTIA'];
      IBSql4.ParamByName('ID_CATEGORIA').AsString := CDcartera.FieldValues['CATEGORIA'];
      IBSql4.Open;

      FechaCorte := EncodeDate(YearOf(Date),MonthOf(Date) - 1,30);
      IBSql3.SQL.Clear;
      IBSql3.SQL.Add('SELECT ("col$colocacion".VALOR_DESEMBOLSO - "col$colocacion".ABONOS_CAPITAL) AS SALDO,"col$colocacion".ID_EVALUACION,"col$colocacion".FECHA_INTERES,');
      IBSql3.SQL.Add('"col$colocacion".ID_ESTADO_COLOCACION,"col$colocacion".ID_LINEA,"col$colocacion".ID_CLASIFICACION,');
      IBSql3.SQL.Add('"col$colocacion".AMORTIZA_INTERES,"col$colocacion".ID_TIPO_CUOTA,"col$colocacion".FECHA_DESEMBOLSO,');
      IBSql3.SQL.Add('"col$colocacion".ID_INTERES,"col$colocacion".TASA_INTERES_CORRIENTE,"col$colocacion".PUNTOS_INTERES,');
      IBSql3.SQL.Add('"col$causaciondiaria".ANTICIPADOS, "col$causaciondiaria".CAUSADOS,"col$causaciondiaria".CONTINGENCIAS,');
      IBSql3.SQL.Add('"col$causaciondiaria".PCAPITAL,"col$causaciondiaria".PINTERES, "col$causaciondiaria".PCOSTAS,"col$tiposcuota".INTERES');
      IBSql3.SQL.Add('FROM "col$colocacion" INNER JOIN "col$causaciondiaria" ON ("col$colocacion".ID_AGENCIA="col$causaciondiaria".ID_AGENCIA)');
      IBSql3.SQL.Add('AND ("col$colocacion".ID_COLOCACION="col$causaciondiaria".ID_COLOCACION)');
      IBSql3.SQL.Add('LEFT JOIN "col$tiposcuota" ON ("col$colocacion".ID_TIPO_CUOTA = "col$tiposcuota".ID_TIPOS_CUOTA)');
      IBSql3.SQL.Add('WHERE ("col$colocacion".ID_COLOCACION = :ID_COLOCACION and FECHA_CORTE = :FECHA_CORTE)');
      IBSql3.ParamByName('ID_COLOCACION').AsString := CDcartera.FieldValues['ID_COLOCACION'];
      IBSql3.ParamByName('FECHA_CORTE').AsDate := FechaCorte;
      IBSql3.Open;
      if IBSql3.RecordCount > 0 then begin
       //Cartera Castigada
       if IBSql3.FieldByName('ID_ESTADO_COLOCACION').AsInteger = 3 then begin
         Nodo2 := Nodo1.Items.Add('Registro');
         Nodo2.Items.Add('campo',IBSql4.FieldByName('COD_CAPITAL_CAS').AsString);
         Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('SALDO').AsCurrency));

         Nodo2 := Nodo1.Items.Add('Registro');
         Nodo2.Items.Add('campo',CodDControl);
         Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('SALDO').AsCurrency));
       end
       else begin
        //fin Cartera Castigada

       //contabilizar Capital
        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',IBSql4.FieldByName('COD_CAPITAL_CP').AsString);
        Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('SALDO').AsCurrency));

        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',SucK);
        Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('SALDO').AsCurrency));
       //Fin Capital

       //Contabilizar Provision a Capital
       if IBSql3.FieldByName('PCAPITAL').AsCurrency > 0 then begin
        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',IBSql4.FieldByName('COD_PROV_CAPITAL').AsString);
        Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('PCAPITAL').AsCurrency));

        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',SucProv);
        Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('PCAPITAL').AsCurrency));
       end;
       //Fin Provision a Capital

       //Contabilizar Provision a Interes
       if IBSql3.FieldByName('PINTERES').AsCurrency > 0 then begin
        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',IBSql4.FieldByName('COD_PROV_INTERES').AsString);
        Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('PINTERES').AsCurrency));

        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',SucProv);
        Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('PINTERES').AsCurrency));
       end;
       //Fin Provision a Interes

       //Contabilizar Provision a Costas
       if IBSql3.FieldByName('PCOSTAS').AsCurrency > 0 then begin
        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',IBSql4.FieldByName('COD_PROV_COSTAS').AsString);
        Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('PCOSTAS').AsCurrency));

        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',SucProv);
        Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('PCOSTAS').AsCurrency));
       end;
       //Fin Provision a Costas

       //Contabilizar Intereses
       Dias := DiasEntre(IBSql3.FieldByName('FECHA_INTERES').AsDateTime,Date);
       Tasa1 := BuscoTasaEfectivaMaximaNueva(IBQVarios,Date);
       IBSql1.Close;
       IBSql1.SQL.Clear;
       IBSql1.SQL.Add('select DIAS_INICIALES from "col$codigospuc" where');
       IBSql1.SQL.Add('ID_CLASIFICACION = :CLASIFICACION and ');
       IBSql1.SQL.Add('ID_GARANTIA = :GARANTIA and ');
       IBSql1.SQL.Add('ID_CATEGORIA = :CATEGORIA');
       IBSql1.ParamByName('CLASIFICACION').AsInteger := CDcartera.FieldValues['CLASIFICACION'];
       IBSql1.ParamByName('GARANTIA').AsInteger := CDcartera.FieldValues['GARANTIA'];
       IBSql1.ParamByName('CATEGORIA').AsString := 'C';
       IBSql1.Open;
       DiasContingencia := IBSql1.FieldByName('DIAS_INICIALES').AsInteger;
       IBSql1.Close;
       DiasCorrientes := Dias;

       if IBSql3.FieldByName('INTERES').AsString = 'V' then
         DiasContingencia := DiasContingencia + IBSql3.FieldByName('AMORTIZA_INTERES').AsInteger;

       if Dias > 0 then
         if (Dias >= DiasContingencia) then begin
           DiasANT := 0;
           DiasCON := Dias - (DiasContingencia - 1);
           DiasCXC := DiasContingencia - 1;
         end
         else
         begin
           DiasANT := 0;
           DiasCON := 0;
           DiasCXC := Dias;
         end// if
       else
       begin
         DiasANT := dias;
         DiasCON := 0;
         DiasCXC := 0;
       end; // if

       // Evaluar Fechas
       if DiasCXC > 0 then begin
         FechaInicial := IBSql3.FieldByName('FECHA_INTERES').AsDateTime;
         FechaFinal := Date;
         ListaFechas := TList.Create;
         if IBSql3.FieldByName('ID_TIPO_CUOTA').AsInteger = 1 then
           CalcularFechasLiquidarFija(FechaInicial,FechaFinal,FechaFinal,ListaFechas)
         else
         if IBSql3.FieldByName('ID_TIPO_CUOTA').AsInteger = 2 then
           CalcularFechasLiquidarVarAnticipada(FechaInicial,FechaFinal,FechaFinal,ListaFechas)
         else
           CalcularFechasLiquidarVarVencida(FechaInicial,FechaFinal,FechaFinal,ListaFechas);

         Causados := 0;
         Contingentes := 0;
         DiasCXC := 0;
         DiasCON := 0;
         for i := 0 to ListaFechas.Count - 1 do begin
          AFechas := ListaFechas.Items[i];

          if IBSql3.FieldByName('ID_INTERES').AsInteger = 0 then begin
           Tasa := BuscoTasaEfectivaMaximaNueva(IBQVarios,AFechas.FechaFinal);
           if IBSql3.FieldByName('TASA_INTERES_CORRIENTE').AsFloat < Tasa then
             Tasa :=IBsql3.FieldByName('TASA_INTERES_CORRIENTE').AsFloat;

           if IBSql3.FieldByName('ID_EVALUACION').AsString = 'E' then
             Tasa := TasaNominalVencida(Tasa,30)
           else
             begin
               if IBSql3.FieldByName('INTERES').AsString = 'A' then
                 begin
                   Tasa := TasaNominalAnticipada(Tasa,IBsql3.FieldByName('AMORTIZA_INTERES').AsInteger);
                 end
                else
                 begin
                   Tasa := TasaNominalVencida(Tasa,IBsql3.FieldByName('AMORTIZA_INTERES').AsInteger);
                 end;
               end;
          end
          else
          if IBSql3.FieldByName('ID_INTERES').AsInteger = 1 then begin
           Tasa := BuscoTasaEfectivaMaximaDtfNueva(IBQVarios,AFechas.FechaFinal);
           if IBSql3.FieldByName('TASA_INTERES_CORRIENTE').AsFloat < Tasa then
             Tasa :=IBsql3.FieldByName('TASA_INTERES_CORRIENTE').AsFloat;

           if IBSql3.FieldByName('ID_EVALUACION').AsString = 'E' then
             Tasa := TasaNominalVencida(Tasa,30)
           else
             begin
               if IBSql3.FieldByName('INTERES').AsString = 'A' then
                begin
                   Tasa := TasaNominalAnticipada(Tasa,IBsql3.FieldByName('AMORTIZA_INTERES').AsInteger) + IBsql3.FieldByName('PUNTOS_INTERES').AsFloat;
                end
               else
                begin
                  Tasa := TasaNominalVencida(Tasa,IBsql3.FieldByName('AMORTIZA_INTERES').AsInteger) + IBsql3.FieldByName('PUNTOS_INTERES').AsFloat;
                end;
             end;
          end
          else
          if IBSql3.FieldByName('ID_INTERES').AsInteger = 2 then begin
             Tasa := BuscoTasaEfectivaMaximaIPCNueva(IBQVarios);
           if IBSql3.FieldByName('TASA_INTERES_CORRIENTE').AsFloat < Tasa then
             Tasa :=IBsql3.FieldByName('TASA_INTERES_CORRIENTE').AsFloat;

           if IBSql3.FieldByName('ID_EVALUACION').AsString = 'E' then
             Tasa := TasaNominalVencida(Tasa,30)
           else
             begin
               if IBSql3.FieldByName('INTERES').AsString = 'A' then
                begin
                  Tasa := TasaNominalAnticipada(Tasa,IBsql3.FieldByName('AMORTIZA_INTERES').AsInteger) + IBSql3.FieldByName('PUNTOS_INTERES').AsFloat;
                end
               else
                begin
                  Tasa := TasaNominalVencida(Tasa,IBsql3.FieldByName('AMORTIZA_INTERES').AsInteger) + IBsql3.FieldByName('PUNTOS_INTERES').AsFloat;
                end;
             end;
          end;

          //*****Tasa de vivienda***////
          if IBSql3.FieldByName('ID_CLASIFICACION').AsInteger = 3 then begin
            TasaViv := BuscoTasaEfectivaUvrNueva(IBQVarios,AFechas.FechaFinal);
            if IBSql3.FieldByName('ID_EVALUACION').AsString = 'E' then
              TasaViv := TasaNominalVencida(Tasa,30)
            else
              begin
                if IBSql3.FieldByName('INTERES').AsString = 'A' then
                 begin
                   TasaViv := TasaNominalAnticipada(TasaViv,IBsql3.FieldByName('AMORTIZA_INTERES').AsInteger) + IBsql3.FieldByName('PUNTOS_INTERES').AsFloat;
                 end
                else
                 begin
                   TasaViv := TasaNominalVencida(TasaViv,IBsql3.FieldByName('AMORTIZA_INTERES').AsInteger) + IBsql3.FieldByName('PUNTOS_INTERES').AsFloat;
                 end;
              end;
            if Tasa > TasaViv then
              Tasa := TasaViv;
          end;

         if IBSql3.FieldByName('ID_EVALUACION').AsString = 'E' then
           Tasa := Tasa1;

         Bisiesto := False;
         FechaDesembolso := IBsql3.FieldByName('FECHA_DESEMBOLSO').AsDateTime;
         if AFechas^.FechaInicial = FechaInicial then
           AFechas^.FechaInicial := CalculoFecha(FechaInicial,1);
         DiasCalc := DiasEntreFechas(AFechas^.FechaInicial,AFechas^.FechaFinal,FechaDesembolso,bisiesto);
         if DiasCalc < 0 then DiasCalc := 0;
           Dispose(AFechas);
         if DiasCXC < (DiasContingencia - 1) then begin
            DiasCXC := DiasCXC + DiasCalc;
            if DiasCXC > (DiasContingencia - 1) then
             begin
               DiasCON := DiasCXC - (DiasContingencia-1);
               DiasCXC := (DiasContingencia-1);
               Contingentes := Contingentes + SimpleRoundTo(((IBsql3.FieldByName('SALDO').AsCurrency * (Tasa/100)) / 360 ) * DiasCON,0);
               DiasCalc := DiasCalc - DiasCON;
             end;
            Causados := Causados + SimpleRoundTo(((IBsql3.FieldByName('SALDO').AsCurrency * (Tasa/100)) / 360 ) * DiasCalc,0);
         end
         else
         begin
           Contingentes := Contingentes + SimpleRoundTo(((IBsql3.FieldByName('SALDO').AsCurrency * (Tasa/100)) / 360 ) * DiasCalc,0);
           DiasCON := DiasCON + DiasCalc;
         end;
        end;
        ListaFechas.Free;
       end
       else
       begin
         Contingentes := 0;
         Causados := 0;
         DiasCON := 0;
         DiasCXC := 0;
       end;


       // Buscar Tasa Anticipada
       if DiasANT < 0 then begin
         TasaAnt := BuscoTasaAnt(AgenciaL,CDcartera.FieldValues['ID_COLOCACION'],IBsql3.FieldByName('FECHA_INTERES').AsDateTime);
         if TasaAnt = 0 then begin
           case IBSql3.FieldByName('ID_INTERES').AsInteger of
            0 : begin
                  TasaAnt := BuscoTasaEfectivaMaximaNueva(IBQVarios,FechaCorte);
                  if IBSql3.FieldByName('TASA_INTERES_CORRIENTE').AsFloat < TasaAnt then
                    TasaAnt := IBsql3.FieldByName('TASA_INTERES_CORRIENTE').AsFloat;
                end;

            1 : TasaAnt := BuscoTasaEfectivaMaximaDtfNueva(IBQVarios,Date);

            2 : TasaAnt := BuscoTasaEfectivaMaximaIPCNueva(IBQVarios);
           end;
         if IBsql3.FieldByName('INTERES').AsString = 'A' then
           TasaAnt := TasaNominalAnticipada(TasaAnt,IBSQL3.fieldbyname('AMORTIZA_INTERES').AsInteger)
         else
           TasaAnt := TasaNominalVencida(TasaAnt,IBSQL3.FieldByName('AMORTIZA_INTERES').AsInteger);
         end;
       end;
       // Fin Buqueda de Tasa Anticipada

           // Calculo Intereses
       Anticipados := SimpleRoundTo(((IBSQL3.FieldByName('SALDO').AsCurrency * (TasaAnt/100)) / 360 ) * -DiasANT,0);
  // Fin Calculo Intereses

       //Contabilizar Anticipados
       if Anticipados > 0 then begin
        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',IBSql4.FieldByName('COD_INT_ANT').AsString);
        Nodo2.Items.Add('campo',CurrToStr(Anticipados));

        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',SucOPas);
        Nodo2.Items.Add('campo','-' + CurrToStr(Anticipados));
       end;
       //Fin Anticipados

       //Contabilizar Causados
       if Causados > 0 then begin
        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',IBSql4.FieldByName('COD_CXC').AsString);
        Nodo2.Items.Add('campo','-' + CurrToStr(Causados));

        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',SucCxC);
        Nodo2.Items.Add('campo',CurrToStr(Causados));
       end;
       //Fin Causados

       //Contabilizar Costas
       IBSql1.Close;
       IBSql1.SQL.Clear;
       IBSql1.SQL.Add('SELECT SUM(VALOR_COSTAS) AS COSTAS from "col$costas" where ID_AGENCIA = :ID_AGENCIA AND ID_COLOCACION = :ID_COLOCACION');
       IBSql1.ParamByName('ID_AGENCIA').AsInteger := AgenciaL;
       IBSql1.ParamByName('ID_COLOCACION').AsString := CDcartera.FieldValues['ID_COLOCACION'];
       IBSql1.Open;
       if IBSql1.FieldByName('COSTAS').AsCurrency > 0 then begin
        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',IBSql4.FieldByName('COD_COSTAS').AsString);
        Nodo2.Items.Add('campo','-' + CurrToStr(IBSql1.FieldByName('COSTAS').AsCurrency));

        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',SucCxC);
        Nodo2.Items.Add('campo',CurrToStr(IBSql1.FieldByName('COSTAS').AsCurrency));
       end;
       IBSql1.Close;
       //Fin Costas

       //Contabilizar Contingencias
       if IBSql3.FieldByName('CONTINGENCIAS').AsCurrency > 0 then begin
        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',IBSql4.FieldByName('COD_CONTINGENCIA').AsString);
        Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('CONTINGENCIAS').AsCurrency));

        Nodo2 := Nodo1.Items.Add('Registro');
        Nodo2.Items.Add('campo',CodCont);
        Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('CONTINGENCIAS').AsCurrency));
       end;
       //Fin Contingencias

       // Contabilizar Cuentas de Orden Garantia Cdat
        if ((IBSql3.FieldByName('ID_LINEA').AsInteger = 6) or (IBSql3.FieldByName('ID_LINEA').AsInteger = 12)) then begin
         IBSql4.Close;
         IBSql4.SQL.Clear;
         IBSql4.SQL.Add('SELECT CODIGO FROM "col$codigospucbasicos" WHERE ID_CODIGOPUCBASICO = :ID');
         if IBSql3.FieldByName('ID_CLASIFICACION').AsInteger = 1 then
           IBSql4.ParamByName('ID').AsInteger := 48
         else if IBSql3.FieldByName('ID_CLASIFICACION').AsInteger = 2 then
           IBSql4.ParamByName('ID').AsInteger := 49
         else if IBSql3.FieldByName('ID_CLASIFICACION').AsInteger = 3 then
           IBSql4.ParamByName('ID').AsInteger := 50
         else if IBSql3.FieldByName('ID_CLASIFICACION').AsInteger = 4 then
           IBSql4.ParamByName('ID').AsInteger := 51;
         IBSql4.Open;
         CodOCdat := IBSql3.FieldByName('CODIGO').AsString;
         IBSql4.Close;

         Nodo2 := Nodo1.Items.Add('Registro');
         Nodo2.Items.Add('campo',CodOCdat);
         Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('SALDO').AsCurrency));

         Nodo2 := Nodo1.Items.Add('Registro');
         Nodo2.Items.Add('campo',CodAcCont);
         Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('SALDO').AsCurrency));
        end; //Fin cuentas de Orden Garantia Cdat

       //Contabilizar Cuentas de Orden Garantia Real Hipoteca
        IBSql3.Close;
        IBSql3.SQL.Clear;
        IBSql3.SQL.Add('SELECT ID_CLASIFICACION, SUM(CUENTAS_DE_ORDEN) AS ORDEN FROM "col$colgarantiasreal"');
        IBSql3.SQL.Add('INNER JOIN "col$colocacion" on ("col$colgarantiasreal".ID_COLOCACION = "col$colocacion".ID_COLOCACION)');
        IBSql3.SQL.Add('WHERE "col$colgarantiasreal".ID_COLOCACION = :ID_COLOCACION group by ID_CLASIFICACION');
        IBSql3.ParamByName('ID_COLOCACION').AsString := CDcartera.FieldValues['ID_COLOCACION'];
        IBSql3.Open;
        while not IBSql3.Eof do begin
         IBSql4.Close;
         IBSql4.SQL.Clear;
         IBSql4.SQL.Add('SELECT CODIGO FROM "col$codigospucbasicos" WHERE ID_CODIGOPUCBASICO = :ID');
         if IBSql3.FieldByName('ID_CLASIFICACION').AsInteger = 1 then
           IBSql4.ParamByName('ID').AsInteger := 44
         else if IBSql3.FieldByName('ID_CLASIFICACION').AsInteger = 2 then
           IBSql4.ParamByName('ID').AsInteger := 45
         else if IBSql3.FieldByName('ID_CLASIFICACION').AsInteger = 3 then
           IBSql4.ParamByName('ID').AsInteger := 46
         else if IBSql3.FieldByName('ID_CLASIFICACION').AsInteger = 4 then
           IBSql4.ParamByName('ID').AsInteger := 47;
         IBSql4.Open;
         CodOHip := IBSql4.FieldByName('CODIGO').AsString;
         IBSql4.Close;

         if IBSql3.FieldByName('ORDEN').AsCurrency > 0 then begin
          Nodo2 := Nodo1.Items.Add('Registro');
          Nodo2.Items.Add('campo',CodOHip);
          Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('ORDEN').AsCurrency));

          Nodo2 := Nodo1.Items.Add('Registro');
          Nodo2.Items.Add('campo',CodAcCont);
          Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('ORDEN').AsCurrency));
         end;
         IBSql3.Next;
        end; //Fin While Garantia Real Hipotecaria
       end; // Fin de if Cartera Castigada
      end; // fin de if RecordCount Cartera
     Next;
    end; // Fin de While
  end; //Fin de With
  // FIN CARTERA

  //INICIO SOLICITUDES
  with CDSolicitud do begin
    CDSolicitud.First;
    while not CDSolicitud.Eof do  begin
      IBSql3.Close;
      IBSql3.SQL.Clear;
      IBSql3.SQL.Add('SELECT CODIGO FROM "col$codigospucbasicos" WHERE ID_CODIGOPUCBASICO = :ID');
      IBSql3.ParamByName('ID').AsInteger := 53;
      IBSql3.Open;
      CredAprob := IBSql3.FieldByName('CODIGO').AsString;
      IBSql3.Close;
      IBSql3.SQL.Clear;
      IBSql3.SQL.Add('SELECT VALOR_APROBADO from "col$solicitud" where ID_SOLICITUD = :ID_SOLICITUD AND ESTADO = 4');
      IBSql3.ParamByName('ID_SOLICITUD').AsString := CDSolicitud.FieldValues['ID_SOLICITUD'];
      IBSql3.Open;

      if IBSql3.FieldByName('VALOR_APROBADO').AsCurrency > 0 then begin
       Nodo2 := Nodo1.Items.Add('Registro');
       Nodo2.Items.Add('campo',CredAprob);
       Nodo2.Items.Add('campo',CurrToStr(IBSql3.FieldByName('VALOR_APROBADO').AsCurrency));

       Nodo2 := Nodo1.Items.Add('Registro');
       Nodo2.Items.Add('campo',CodAcCont);
       Nodo2.Items.Add('campo','-' + CurrToStr(IBSql3.FieldByName('VALOR_APROBADO').AsCurrency));
      end;
      Next;
    end; //fin de while solicitudes
  end; // fin de with solicitudes
  //FIN SOLICITUDES
  CDcartera.Destroy;
  CDSolicitud.Destroy;
end;

function TfrmServerTraslados.BuscoTasaAnt(Ag: Integer;Colocacion: string;FechaIntereses:TDate): Single;
begin
        with IBQVarios do begin
          Close;
          SQL.Clear;
          SQL.Add('select * from "col$extracto" where ID_AGENCIA = :ID_AGENCIA and ID_COLOCACION = :ID_COLOCACION');
          SQL.Add('ORDER BY FECHA_EXTRACTO DESC, HORA_EXTRACTO DESC');
          ParamByName('ID_AGENCIA').AsInteger := Ag;
          ParamByName('ID_COLOCACION').AsString := Colocacion;
          try
            Open;
            if RecordCount > 0 then
             while not Eof do begin
                if FieldByName('INTERES_PAGO_HASTA').AsDateTime = FechaIntereses then begin
                   Result := SimpleRoundTo(FieldByName('TASA_INTERES_LIQUIDACION').AsFloat);
                   Exit;
                end;
             Next;
             end;
             Close;
             Result := 0;
          except
             Result := 0;
          end;
        end;
end;


end.
