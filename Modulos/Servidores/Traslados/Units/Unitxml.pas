unit Unitxml;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IBQuery, IBSql, IBDatabase, DB, JvComponent,
  JvSimpleXml, JvEdit, JvTypedEdit, DateUtils, IdBaseComponent, IdCoder,
  IdCoder3To4,DBClient,Math;

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
  TfrmXml = class(TForm)
    Label1: TLabel;
    EdDocumento: TEdit;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    xml: TJvSimpleXml;
    Label2: TLabel;
    EdTipo: TJvIntegerEdit;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    IdBase64Decoder1: TIdBase64Decoder;
    Label3: TLabel;
    st1: TStaticText;
    CDSCuentas: TClientDataSet;
    CDSCuentasTIPO_CUENTA: TIntegerField;
    CDSCuentasNUMERO_CUENTA: TIntegerField;
    CDSCuentasN_NUMERO_CUENTA: TIntegerField;
    CDSCuentasN_TIPO_CUENTA: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
  nRegistro,nCampo: TJvSimpleXmlElem;
//  nodo :TJvSimpleXmlElems;
    { Private declarations }
  public
    procedure procesar(tipo: integer; id: string);
    procedure Contabilizar;
    function BuscoTasaAnt(Ag: Integer;Colocacion: string;FechaIntereses:TDate): Single;
    function FldToStr(const Value : TFieldType) : string;
    { Public declarations }
  end;

var
  frmXml: TfrmXml;

  Cuentas:TList;
  Personas:TList;
  vId_Persona :string;
  vId_Identificacion :Integer;
  vAnalista :string;
  AgenciaL:Integer;
  AgenciaT:Integer;
  IBDatabase1,IBDatabase2:TIBDatabase;
  IBTransaction1,IBTransaction2:TIBTransaction;
  IBSql1,IBSql2,IBSql3,IBSql4,IBQVarios,IBInsertar:TIBQuery;
  IBSQ:TIBSQL;
  CDcartera:TClientDataSet;
  CDSolicitud:TClientDataSet;
  dCuenta:PTCuenta;
  dPersona:PTPersona;
  Root : TJvSimpleXmlElemClassic;
  Nodo1: TJvSimpleXmlElemClassic;
  Nodo2: TJvSimpleXmlElemClassic;
  Nodo3: TJvSimpleXmlElemClassic;
  fI,fO:string;

implementation

{$R *.dfm}

uses UnitGlobales,SZCodeBaseX;

procedure TfrmXml.procesar(tipo: integer; id: string);
var
  i,j,k,l:Integer;
  Id_Agencia,Id_Tipo_Captacion,Numero_Cuenta,Digito_Cuenta:Integer;
  yaExiste :Boolean;
  vTabla :Boolean;
  vContador :Integer;
  OldTimeFormat,OldDateFormat,OldDateTimeFormat:string;
  CodContable:string;
  Nombre:string;
  Fecha1,Fecha2:TDate;
//  Cuentas:TList;
begin
        Cuentas := TList.Create;
        Personas := TList.Create;

        OldDateFormat := ShortDateFormat;
        ShortDateFormat := 'yyyy/MM/dd';
        OldTimeFormat := LongTimeFormat;
        LongTimeFormat := 'HH:mm:ss';

        Fecha1 := EncodeDate(YearOf(fFechaActual(IBDatabase1)),01,01);
        Fecha2 := EncodeDate(YearOf(fFechaActual(IBDatabase1)),12,31);        


        with IBSql1 do begin
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

        xml.Root.Properties.Add('tipo',IntToStr(EdTipo.Value));
        xml.Root.Properties.Add('numero',EdDocumento.Text);
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

procedure TfrmXml.FormCreate(Sender: TObject);
begin
        xml.Root.Name := 'root';
end;

procedure TfrmXml.BitBtn1Click(Sender: TObject);
begin
        IBDatabase1 := TIBDatabase.Create(nil);
        IBTransaction1 := TIBTransaction.Create(nil);
        IBSql1 := TIBQuery.Create(nil);
        IBSql2 := TIBQuery.Create(nil);
        IBSql3 := TIBQuery.Create(nil);
        IBSql4 := TIBQuery.Create(nil);
        IBQVarios := TIBQuery.Create(nil);
        CDcartera := TClientDataSet.Create(nil);
        CDcartera.FieldDefs.Add('ID_COLOCACION',ftString,11,True);
        CDcartera.FieldDefs.Add('CLASIFICACION',ftInteger,0,True);
        CDcartera.FieldDefs.Add('GARANTIA',ftInteger,0,True);
        CDcartera.FieldDefs.Add('CATEGORIA',ftString,1,True);
        CDcartera.CreateDataSet;
        CDSolicitud := TClientDataSet.Create(nil);
        CDSolicitud.FieldDefs.Add('ID_SOLICITUD',ftString,10,True);
        CDSolicitud.CreateDataSet;

        Ruta := '192.168.200.141:/var/db/fbird/';
        DataBase := 'database.fdb';
        UserName := 'SYSDBA';
        PassWord := 'masterkey';

        IBDatabase1.DatabaseName := Ruta + DataBase;
        IBDatabase1.SQLDialect := 3;
        IBDatabase1.LoginPrompt := False;
        IBDatabase1.Params.Append('user_name='+UserName);
        IBDatabase1.Params.Append('password='+PassWord);
        IBDatabase1.Params.Append('lc_ctype=ISO8859_1');
        try
          IBDatabase1.Open;
          if not IBDatabase1.Connected then
          begin
            ShowMessage('No se pudo conectar a la base de datos Origen');
            Exit;
          end;
        except
          raise;
          Exit;
        end;

        IBTransaction1.DefaultDatabase := IBDatabase1;
        IBTransaction1.StartTransaction;

        IBSql1.Database := IBDatabase1;
        IBSql1.Transaction := IBTransaction1;

        IBSql2.Database := IBDatabase1;
        IBSql2.Transaction := IBTransaction1;

        IBSql3.Database := IBDatabase1;
        IBSql3.Transaction := IBTransaction1;

        IBSql4.Database := IBDatabase1;
        IBSql4.Transaction := IBTransaction1;

        IBQVarios.Database := IBDatabase1;
        IBQVarios.Transaction := IBTransaction1;

        AgenciaT := 4;  //ojo cambiar por parametro de agencia de traslado
        AgenciaL := 1; //cambiar por la Agencia Local        

        procesar(EdTipo.Value,EdDocumento.Text);
        contabilizar;
        // Guardar archivo xml de prueba para verificacion
        xml.SaveToFile('C:\Prueba1.xml');
        ShowMessage('Proceso Terminado con Exito');
end;

procedure TfrmXml.Contabilizar;
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

function TfrmXml.BuscoTasaAnt(Ag: Integer;Colocacion: string;FechaIntereses:TDate): Single;
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


procedure TfrmXml.BitBtn2Click(Sender: TObject);
var     i,j,h :Integer;
        tabla :string;
        sentencia :string;
        VBlob :Boolean;
        Reg :string;
        TotalDebito,TotalCredito :Currency;
        Comp:string;
        Consecutivo :Integer;
        Codigo:string;
        Valor:Currency;
        Contenido:string;
        tp:Integer;
        id:string;
        Asociado:string;
        Table:string;
        New_Cta, Old_Cta:Integer;
        Tp_Cta,Dg_Cta:Integer;
        OldTimeFormat,OldDateFormat,OldDateTimeFormat:string;

begin
        VBlob := False;
        IBDatabase2 := TIBDatabase.Create(nil);
        IBTransaction2 := TIBTransaction.Create(nil);

        OldDateFormat := ShortDateFormat;
        ShortDateFormat := 'yyyy/MM/dd';
        OldTimeFormat := LongTimeFormat;
        LongTimeFormat := 'HH:mm:ss';

        Ruta := '192.168.200.198:/var/db/fbird/';
        DataBase := 'database.fdb';
        UserName := 'SYSDBA';
        PassWord := 'masterkey';

        IBDatabase2.DatabaseName := Ruta + DataBase;
        IBDatabase2.SQLDialect := 3;
        IBDatabase2.LoginPrompt := False;
        IBDatabase2.Params.Append('user_name='+UserName);
        IBDatabase2.Params.Append('password='+PassWord);
        IBDatabase2.Params.Append('lc_ctype=ISO8859_1');
        try
          IBDatabase2.Open;
          if not IBDatabase2.Connected then
          begin
            ShowMessage('No se pudo conectar a la base de datos Destino');
            Exit;
          end;
        except
          raise;
          Exit;
        end;

        IBTransaction2.DefaultDatabase := IBDatabase2;
        IBTransaction2.StartTransaction;

        IBInsertar := TIBQuery.Create(nil);
        IBInsertar.Database := IBDatabase2;
        IBInsertar.Transaction := IBTransaction2;

        IBSQ := TIBSQL.Create(nil);
        IBSQ.Database := IBDatabase2;
        IBSQ.Transaction := IBTransaction2;

        if IBInsertar.Transaction.InTransaction then
           IBInsertar.Transaction.Commit;

        IBInsertar.Transaction.StartTransaction;
        xml.LoadFromFile('c:\Prueba1.xml');

        tp := xml.Root.Properties.Item[0].IntValue;
        id := xml.Root.Properties.Item[1].Value;
        Asociado := xml.Root.Properties.Item[2].Value;

//        Cuenta := ObtenerCaptacion(2,IBSQL1);
//        Digito := DigitoControl(2,FormatFloat('0000000',Cuenta));

        for i := 0 to xml.Root.Items.Count -1 do
        begin
          nRegistro := xml.Root.Items[i];
          st1.Caption := nRegistro.Properties.Item[0].Value;
          Table := st1.Caption;
          Application.ProcessMessages;
          if Table = 'cap$maestro' then
          begin
                IBInsertar.Close;
                IBInsertar.SQL.Clear;
                IBInsertar.SQL.Add('insert into "cap$maestro" values(');
                IBInsertar.SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,');
                IBInsertar.SQL.Add(':DIGITO_CUENTA,:VALOR_INICIAL,:ID_FORMA,:FECHA_APERTURA,');
                IBInsertar.SQL.Add(':PLAZO_CUENTA,:TIPO_INTERES,:ID_INTERES,:TASA_EFECTIVA,');
                IBInsertar.SQL.Add(':PUNTOS_ADICIONALES,:MODALIDAD,:AMORTIZACION,:CUOTA,:CUOTA_CADA,');
                IBInsertar.SQL.Add(':ID_PLAN,:ID_ESTADO,:FECHA_VENCIMIENTO,:FECHA_ULTIMO_PAGO,');
                IBInsertar.SQL.Add(':FECHA_PROXIMO_PAGO,:FECHA_PRORROGA,:FECHA_VENCIMIENTO_PRORROGA,');
                IBInsertar.SQL.Add(':FECHA_SALDADA,:FIRMAS,:SELLOS,:PROTECTOGRAFOS,:ID_TIPO_CAPTACION_ABONO,');
                IBInsertar.SQL.Add(':NUMERO_CUENTA_ABONO');
                IBInsertar.SQL.Add(')');
                for j := 0 to nRegistro.Items.Count - 1 do
                begin
                  nCampo := nRegistro.Items[j];
                  Tp_Cta := nCampo.Items.Item[1].IntValue;
                  Old_Cta := nCampo.Items.Item[2].IntValue;
                  CdsCuentas.Open;
                  CdsCuentas.Filter := 'TIPO_CUENTA = ' + IntToStr(Tp_Cta) +
                                       ' AND NUMERO_CUENTA = ' + IntToStr(Old_Cta);
                  CdsCuentas.Filtered := True;
                  if CdsCuentas.RecordCount > 0 then
                   New_Cta := CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger
                  else
                   if Tp_Cta = 1 then
                   begin
                      Old_Cta := nCampo.Items.Item[2].IntValue;
                      New_Cta := ObtenerCaptacion(1,IBSQ);
                      // Guardar relación nueva cuenta de aportes
                      CdsCuentas.Append;
                      CdsCuentas.FieldByName('TIPO_CUENTA').AsInteger := 1;
                      CdsCuentas.FieldByName('NUMERO_CUENTA').AsInteger := Old_Cta;
                      CdsCuentas.FieldByName('N_TIPO_CUENTA').AsInteger := 1;
                      CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger := New_Cta;
                      CdsCuentas.Post;
                      // Guardar relación nueva cuenta de ahorros
                      CdsCuentas.Append;
                      CdsCuentas.FieldByName('TIPO_CUENTA').AsInteger := 2;
                      CdsCuentas.FieldByName('NUMERO_CUENTA').AsInteger := Old_Cta;
                      CdsCuentas.FieldByName('N_TIPO_CUENTA').AsInteger := 2;
                      CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger := New_Cta;
                      CdsCuentas.Post;
                   end
                   else
                   begin
                      if Tp_Cta <> 6 then begin
                        Old_Cta := nCampo.Items.Item[2].IntValue;
                        New_Cta := ObtenerCaptacion(Tp_Cta,IBSQ);
                      // Guardar relación nueva cuenta de aportes
                        CdsCuentas.Open;
                        CdsCuentas.Append;
                        CdsCuentas.FieldByName('TIPO_CUENTA').AsInteger := Tp_Cta;
                        CdsCuentas.FieldByName('NUMERO_CUENTA').AsInteger := Old_Cta;
                        CdsCuentas.FieldByName('N_TIPO_CUENTA').AsInteger := Tp_Cta;
                        CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger := New_Cta;
                        CdsCuentas.Post;
                        CdsCuentas.Close;
                      end
                      else
                      begin
                        New_Cta := Old_Cta;
                      // Guardar relación nueva cuenta de aportes
                        CdsCuentas.Open;
                        CdsCuentas.Append;
                        CdsCuentas.FieldByName('TIPO_CUENTA').AsInteger := Tp_Cta;
                        CdsCuentas.FieldByName('NUMERO_CUENTA').AsInteger := Old_Cta;
                        CdsCuentas.FieldByName('N_TIPO_CUENTA').AsInteger := Tp_Cta;
                        CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger := New_Cta;
                        CdsCuentas.Post;
                        CdsCuentas.Close;
                      end;
                   end; // del if Tp_Cta
// Grabar Registo
                   Dg_Cta := StrToInt(DigitoControl(Tp_Cta,Format('%.7d',[New_Cta])));
                   for h := 0 to nCampo.Items.Count - 1 do
                    begin
                     case h of
                       0: begin
                           IBInsertar.Params.Items[h].AsInteger := AgenciaT;
                          end;
                       1: begin
                           IBInsertar.Params.Items[h].AsInteger := Tp_Cta;
                          end;
                       2: begin
                           IBInsertar.Params.Items[h].AsInteger := New_Cta;
                          end;
                       3: begin
                           IBInsertar.Params.Items[h].AsInteger  := Dg_Cta;
                         end;
                        else
                          begin
                            IBInsertar.Params.Items[h].AsString := nCampo.Items.Item[h].Value;
                          end;
                     end;
                    end; // del for h
                    try
                     IBInsertar.ExecSQL;
                     IBInsertar.Transaction.CommitRetaining;
                    except
                     raise;
                     IBInsertar.Transaction.RollbackRetaining;
                    end;
                    CdsCuentas.Close;
                end; // del for j
// Finalizamos cap$maestro
          end  // del if table cap$maestro
          else
          if Table = 'cap$maestrotitular' then
          begin
           IBInsertar.Close;
           IBInsertar.SQL.Clear;
           IBInsertar.SQL.Add('insert into "cap$maestrotitular" values(');
           IBInsertar.SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,');
           IBInsertar.SQL.Add(':DIGITO_CUENTA,:ID_IDENTIFICACION,:ID_PERSONA,');
           IBInsertar.SQL.Add(':NUMERO_TITULAR,:TIPO_TITULAR');
           IBInsertar.SQL.Add(')');
           for j := 0 to nRegistro.Items.Count -1 do
            begin
              nCampo := nRegistro.Items[j];
              Tp_Cta := nCampo.Items.Item[1].IntValue;
              Old_Cta := nCampo.Items.Item[2].IntValue;
              CdsCuentas.Open;
              CdsCuentas.Filter := 'TIPO_CUENTA = ' + IntToStr(Tp_Cta) +
                                   ' AND NUMERO_CUENTA = ' + IntToStr(Old_Cta);
              CdsCuentas.Filtered := True;
              if CdsCuentas.RecordCount > 0 then
              begin
                  New_Cta := CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger;
                  Dg_Cta := StrToInt(DigitoControl(Tp_Cta,Format('%.7d',[New_Cta])));
              end
              else
              begin
                ShowMessage('No se encontro la cuenta para el titular');
                Exit;
              end;

              for h := 0 to nCampo.Items.Count - 1 do
              case h of
               0: IBInsertar.Params.Items[h].AsInteger := AgenciaT;
               1: IBInsertar.Params.Items[h].AsInteger := Tp_Cta;
               2: IBInsertar.Params.Items[h].AsInteger := New_Cta;
               3: IBInsertar.Params.Items[h].AsInteger := Dg_Cta;
               else
                  IBInsertar.Params.Items[h].AsString := nCampo.Items.Item[h].Value;
              end; // del case

              try
                IBInsertar.ExecSQL;
                IBInsertar.Transaction.CommitRetaining;
              except
                raise;
                IBInsertar.Transaction.RollbackRetaining;
              end;
              CdsCuentas.Close;
            end; // del for j
          end // del cap$maestrotitular
          else
          if Table = 'cap$extracto' then
          begin
           IBInsertar.Close;
           IBInsertar.SQL.Clear;
           IBInsertar.SQL.Add('insert into "cap$extracto" values(');
           IBInsertar.SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
           IBInsertar.SQL.Add(':FECHA_MOVIMIENTO,:HORA_MOVIMIENTO,:ID_TIPO_MOVIMIENTO,');
           IBInsertar.SQL.Add(':DOCUMENTO_MOVIMIENTO,:DESCRIPCION_MOVIMIENTO,');
           IBInsertar.SQL.Add(':VALOR_DEBITO,:VALOR_CREDITO');
           IBInsertar.SQL.Add(')');
           for j := 0 to nRegistro.Items.Count -1 do
            begin
              nCampo := nRegistro.Items[j];
              Tp_Cta := nCampo.Items.Item[1].IntValue;
              Old_Cta := nCampo.Items.Item[2].IntValue;
              CdsCuentas.Open;
              CdsCuentas.Filter := 'TIPO_CUENTA = ' + IntToStr(Tp_Cta) +
                                   ' AND NUMERO_CUENTA = ' + IntToStr(Old_Cta);
              CdsCuentas.Filtered := True;
              if CdsCuentas.RecordCount > 0 then
              begin
                  New_Cta := CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger;
                  Dg_Cta := StrToInt(DigitoControl(Tp_Cta,Format('%.7d',[New_Cta])));
              end
              else
              begin
                ShowMessage('No se encontro la cuenta para el titular');
                Exit;
              end;

              for h := 0 to nCampo.Items.Count - 1 do
              case h of
               0: IBInsertar.Params.Items[h].AsInteger := AgenciaT;
               1: IBInsertar.Params.Items[h].AsInteger := Tp_Cta;
               2: IBInsertar.Params.Items[h].AsInteger := New_Cta;
               3: IBInsertar.Params.Items[h].AsInteger := Dg_Cta;
               else
                  IBInsertar.Params.Items[h].AsString := nCampo.Items.Item[h].Value;
              end; // del case

              try
                IBInsertar.ExecSQL;
                IBInsertar.Transaction.CommitRetaining;
              except
                raise;
                IBInsertar.Transaction.RollbackRetaining;
              end;
              CdsCuentas.Close;
            end; // del for j
          end // del cap$extracto
          else
          if Table = 'cap$maestrosaldoinicial' then
          begin
           IBInsertar.Close;
           IBInsertar.SQL.Clear;
           IBInsertar.SQL.Add('insert into "cap$maestrosaldoinicial" values(');
           IBInsertar.SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
           IBInsertar.SQL.Add(':ANO,:SALDO_INICIAL');
           IBInsertar.SQL.Add(')');
           for j := 0 to nRegistro.Items.Count -1 do
            begin
              nCampo := nRegistro.Items[j];
              Tp_Cta := nCampo.Items.Item[1].IntValue;
              Old_Cta := nCampo.Items.Item[2].IntValue;
              CdsCuentas.Open;
              CdsCuentas.Filter := 'TIPO_CUENTA = ' + IntToStr(Tp_Cta) +
                                   ' AND NUMERO_CUENTA = ' + IntToStr(Old_Cta);
              CdsCuentas.Filtered := True;
              if CdsCuentas.RecordCount > 0 then
              begin
                  New_Cta := CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger;
                  Dg_Cta := StrToInt(DigitoControl(Tp_Cta,Format('%.7d',[New_Cta])));
              end
              else
              begin
                ShowMessage('No se encontro la cuenta para el titular');
                Exit;
              end;

              for h := 0 to nCampo.Items.Count - 1 do
              case h of
               0: IBInsertar.Params.Items[h].AsInteger := AgenciaT;
               1: IBInsertar.Params.Items[h].AsInteger := Tp_Cta;
               2: IBInsertar.Params.Items[h].AsInteger := New_Cta;
               3: IBInsertar.Params.Items[h].AsInteger := Dg_Cta;
               else
                  IBInsertar.Params.Items[h].AsString := nCampo.Items.Item[h].Value;
              end; // del case

              try
                IBInsertar.ExecSQL;
                IBInsertar.Transaction.CommitRetaining;
              except
                raise;
                IBInsertar.Transaction.RollbackRetaining;
              end;
              CdsCuentas.Close;
            end; // del for j
          end // del cap$maestrosaldoinicial
          else
          if Table = 'cap$saldosmes' then
          begin
           IBInsertar.Close;
           IBInsertar.SQL.Clear;
           IBInsertar.SQL.Add('insert into "cap$saldosmes" values(');
           IBInsertar.SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
           IBInsertar.SQL.Add(':ANO,:MES,:SALDOINICIAL');
           IBInsertar.SQL.Add(')');
           for j := 0 to nRegistro.Items.Count -1 do
            begin
              nCampo := nRegistro.Items[j];
              Tp_Cta := nCampo.Items.Item[1].IntValue;
              Old_Cta := nCampo.Items.Item[2].IntValue;
              CdsCuentas.Open;
              CdsCuentas.Filter := 'TIPO_CUENTA = ' + IntToStr(Tp_Cta) +
                                   ' AND NUMERO_CUENTA = ' + IntToStr(Old_Cta);
              CdsCuentas.Filtered := True;
              if CdsCuentas.RecordCount > 0 then
              begin
                  New_Cta := CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger;
                  Dg_Cta := StrToInt(DigitoControl(Tp_Cta,Format('%.7d',[New_Cta])));
              end
              else
              begin
                ShowMessage('No se encontro la cuenta para el titular');
                Exit;
              end;

              for h := 0 to nCampo.Items.Count - 1 do
              case h of
               0: IBInsertar.Params.Items[h].AsInteger := AgenciaT;
               1: IBInsertar.Params.Items[h].AsInteger := Tp_Cta;
               2: IBInsertar.Params.Items[h].AsInteger := New_Cta;
               3: IBInsertar.Params.Items[h].AsInteger := Dg_Cta;
               else
                  IBInsertar.Params.Items[h].AsString := nCampo.Items.Item[h].Value;
              end; // del case

              try
                IBInsertar.ExecSQL;
                IBInsertar.Transaction.CommitRetaining;
              except
                raise;
                IBInsertar.Transaction.RollbackRetaining;
              end;
              CdsCuentas.Close;
            end; // del for j
          end // del cap$saldosmes
          else
          if Table = 'cap$maestrosaldosmes' then
          begin
           IBInsertar.Close;
           IBInsertar.SQL.Clear;
           IBInsertar.SQL.Add('insert into "cap$maestrosaldosmes" values(');
           IBInsertar.SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
           IBInsertar.SQL.Add(':MES,:DEBITO,:CREDITO');
           IBInsertar.SQL.Add(')');
           for j := 0 to nRegistro.Items.Count -1 do
            begin
              nCampo := nRegistro.Items[j];
              Tp_Cta := nCampo.Items.Item[1].IntValue;
              Old_Cta := nCampo.Items.Item[2].IntValue;
              CdsCuentas.Open;
              CdsCuentas.Filter := 'TIPO_CUENTA = ' + IntToStr(Tp_Cta) +
                                   ' AND NUMERO_CUENTA = ' + IntToStr(Old_Cta);
              CdsCuentas.Filtered := True;
              if CdsCuentas.RecordCount > 0 then
              begin
                  New_Cta := CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger;
                  Dg_Cta := StrToInt(DigitoControl(Tp_Cta,Format('%.7d',[New_Cta])));
              end
              else
              begin
                ShowMessage('No se encontro la cuenta para el titular');
                Exit;
              end;

              for h := 0 to nCampo.Items.Count - 1 do
              case h of
               0: IBInsertar.Params.Items[h].AsInteger := AgenciaT;
               1: IBInsertar.Params.Items[h].AsInteger := Tp_Cta;
               2: IBInsertar.Params.Items[h].AsInteger := New_Cta;
               3: IBInsertar.Params.Items[h].AsInteger := Dg_Cta;
               else
                  IBInsertar.Params.Items[h].AsString := nCampo.Items.Item[h].Value;
              end; // del case

              try
                IBInsertar.ExecSQL;
                IBInsertar.Transaction.CommitRetaining;
              except
                raise;
                IBInsertar.Transaction.RollbackRetaining;
              end;
              CdsCuentas.Close;
            end; // del for j
          end // del cap$maestrosaldomes
          else
          if Table = 'cap$maestrosapertura' then
          begin
           IBInsertar.Close;
           IBInsertar.SQL.Clear;
           IBInsertar.SQL.Add('insert into "cap$maestrosapertura" values(');
           IBInsertar.SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
           IBInsertar.SQL.Add(':FECHA,:HORA,:EFECTIVO,:CHEQUE');
           IBInsertar.SQL.Add(')');
           for j := 0 to nRegistro.Items.Count -1 do
            begin
              nCampo := nRegistro.Items[j];
              Tp_Cta := nCampo.Items.Item[1].IntValue;
              Old_Cta := nCampo.Items.Item[2].IntValue;
              CdsCuentas.Open;
              CdsCuentas.Filter := 'TIPO_CUENTA = ' + IntToStr(Tp_Cta) +
                                   ' AND NUMERO_CUENTA = ' + IntToStr(Old_Cta);
              CdsCuentas.Filtered := True;
              if CdsCuentas.RecordCount > 0 then
              begin
                  New_Cta := CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger;
                  Dg_Cta := StrToInt(DigitoControl(Tp_Cta,Format('%.7d',[New_Cta])));
              end
              else
              begin
                ShowMessage('No se encontro la cuenta para el titular');
                Exit;
              end;

              for h := 0 to nCampo.Items.Count - 1 do
              case h of
               0: IBInsertar.Params.Items[h].AsInteger := AgenciaT;
               1: IBInsertar.Params.Items[h].AsInteger := Tp_Cta;
               2: IBInsertar.Params.Items[h].AsInteger := New_Cta;
               3: IBInsertar.Params.Items[h].AsInteger := Dg_Cta;
               else
                  IBInsertar.Params.Items[h].AsString := nCampo.Items.Item[h].Value;
              end; // del case

              try
                IBInsertar.ExecSQL;
                IBInsertar.Transaction.CommitRetaining;
              except
                raise;
                IBInsertar.Transaction.RollbackRetaining;
              end;
              CdsCuentas.Close;
            end; // del for j
          end  // del cap$maestroapertura
          else
          if Table = 'col$colocacion' then
          begin
             IBInsertar.Close;
             IBInsertar.SQL.Clear;
             IBInsertar.SQL.Add('insert into "col$colocacion" values(');
             IBInsertar.SQL.Add(':ID_AGENCIA,');
             IBInsertar.SQL.Add(':ID_COLOCACION,');
             IBInsertar.SQL.Add(':ID_IDENTIFICACION,');
             IBInsertar.SQL.Add(':ID_PERSONA,');
             IBInsertar.SQL.Add(':ID_CLASIFICACION,');
             IBInsertar.SQL.Add(':ID_LINEA,');
             IBInsertar.SQL.Add(':ID_INVERSION,');
             IBInsertar.SQL.Add(':ID_RESPALDO,');
             IBInsertar.SQL.Add(':ID_GARANTIA,');
             IBInsertar.SQL.Add(':ID_CATEGORIA,');
             IBInsertar.SQL.Add(':ID_EVALUACION,');
             IBInsertar.SQL.Add(':FECHA_DESEMBOLSO,');
             IBInsertar.SQL.Add(':VALOR_DESEMBOLSO,');
             IBInsertar.SQL.Add(':PLAZO_COLOCACION,');
             IBInsertar.SQL.Add(':FECHA_VENCIMIENTO,');
             IBInsertar.SQL.Add(':TIPO_INTERES,');
             IBInsertar.SQL.Add(':ID_INTERES,');
             IBInsertar.SQL.Add(':TASA_INTERES_CORRIENTE,');
             IBInsertar.SQL.Add(':TASA_INTERES_MORA,');
             IBInsertar.SQL.Add(':PUNTOS_INTERES,');
             IBInsertar.SQL.Add(':ID_TIPO_CUOTA,');
             IBInsertar.SQL.Add(':AMORTIZA_CAPITAL,');
             IBInsertar.SQL.Add(':AMORTIZA_INTERES,');
             IBInsertar.SQL.Add(':PERIODO_GRACIA,');
             IBInsertar.SQL.Add(':DIAS_PRORROGADOS,');
             IBInsertar.SQL.Add(':VALOR_CUOTA,');
             IBInsertar.SQL.Add(':ABONOS_CAPITAL,');
             IBInsertar.SQL.Add(':FECHA_CAPITAL,');
             IBInsertar.SQL.Add(':FECHA_INTERES,');
             IBInsertar.SQL.Add(':ID_ESTADO_COLOCACION,');
             IBInsertar.SQL.Add(':ID_ENTE_APROBADOR,');
             IBInsertar.SQL.Add(':ID_EMPLEADO,');
             IBInsertar.SQL.Add(':NOTA_CONTABLE,');
             IBInsertar.SQL.Add(':NUMERO_CUENTA,');
             IBInsertar.SQL.Add(':ES_ANORMAL,');
             IBInsertar.SQL.Add(':DIAS_PAGO,');
             IBInsertar.SQL.Add(':RECIPROCIDAD,');
             IBInsertar.SQL.Add(':FECHA_SALDADO');
             IBInsertar.SQL.Add(')');
           for j := 0 to nRegistro.Items.Count -1 do
            begin
              nCampo := nRegistro.Items[j];
              Tp_Cta := 1;
              Old_Cta := nCampo.Items.Item[33].IntValue;
              CdsCuentas.Open;
              CdsCuentas.Filter := 'TIPO_CUENTA = 1' +
                                   ' AND NUMERO_CUENTA = ' + IntToStr(Old_Cta);
              CdsCuentas.Filtered := True;
              if CdsCuentas.RecordCount > 0 then
              begin
                  New_Cta := CdsCuentas.FieldByName('N_NUMERO_CUENTA').AsInteger;
              end
              else
              begin
                ShowMessage('No se encontro la cuenta para el titular');
                Exit;
              end;

              for h := 0 to nCampo.Items.Count - 1 do
              case h of
               33: IBInsertar.Params.Items[h].AsInteger := New_Cta;
               else
                  IBInsertar.Params.Items[h].AsString := nCampo.Items.Item[h].Value;
              end; // del case

              try
                IBInsertar.ExecSQL;
                IBInsertar.Transaction.CommitRetaining;
              except
                raise;
                IBInsertar.Transaction.RollbackRetaining;
              end;
              CdsCuentas.Close;
            end; // del for j
          end // del col$colocacion
          else
          if ((Table <> 'con$auxiliar')) then
          begin

            if ((Table = 'gen$persona')) then
             VBlob := True
            else
             VBlob := False;

            tabla := 'insert into "' + nRegistro.Properties.Item[0].Value + '" values(';
            for j := 0 to nRegistro.Items.Count -1 do
            begin
              nCampo := nRegistro.Items[j];
              Application.ProcessMessages;
              for h := 0 to nCampo.Items.Count -1 do
              begin
                Contenido := ncampo.Items.Item[h].Value;
                Application.ProcessMessages;
                if h = 0 then
                 if ncampo.Items.Item[h].Value = '' then
                    sentencia := 'NULL'
                 else
                    sentencia := '''' + Contenido + ''''
                else
                 try
                  if (Contenido = '') or (nCampo.Items.Item[h].Properties.Value('Tipo') = 'Blob') then
                      sentencia := sentencia + ',NULL'
                  else
                      sentencia := sentencia + ',' + '''' + Contenido + '''';
                 except;
                     ShowMessage(sentencia);
                 end;
              end;
              Memo1.Lines.Add(#13 + #13);
              Memo1.Lines.Add(tabla + sentencia + ')');

              with IBInsertar do
               begin
                    Close;
                    SQL.Clear;
                    SQL.Add(tabla + sentencia + ')');
                    try
                      ExecSQL;
                      Transaction.CommitRetaining;
                      if VBlob then
                      begin
                        Close;
                        SQL.Clear;
                        SQL.Add('update "gen$persona" set FOTO = :FOTO, FIRMA = :FIRMA, FOTO_HUELLA = :FOTO_HUELLA, DATOS_HUELLA = :DATOS_HUELLA where ID_IDENTIFICACION = :ID_IDENTIFICACION AND ID_PERSONA = :ID_PERSONA');
                        ParamByName('ID_IDENTIFICACION').AsInteger := ncampo.Items.Item[0].IntValue;
                        ParamByName('ID_PERSONA').AsString := nCampo.Items.Item[1].Value;
                        fO := SZDecodeBase64(nCampo.Items.Item[53].Value);
                        ParamByName('FOTO').AsBlob := fO;
                        fO := SZDecodeBase64(nCampo.Items.Item[54].Value);
                        ParamByName('FIRMA').AsBlob := fO;
                        fO := SZDecodeBase64(nCampo.Items.Item[59].Value);
                        ParamByName('FOTO_HUELLA').AsBlob := fO;
                        fO := SZDecodeBase64(nCampo.Items.Item[60].Value);
                        ParamByName('DATOS_HUELLA').AsBlob := fO;
                        ExecSQL;
                        Transaction.CommitRetaining;
                      end;
                    except
                      Transaction.RollbackRetaining;
//                      ShowMessage(tabla + sentencia );
                    end; // del try
              end; // del with IBInsertar
              sentencia := '';
             end; // del for j
            end
            else
            if ((nRegistro.Properties.Item[0].Value = 'con$auxiliar')) then
            begin
              TotalDebito := 0;
              TotalCredito := 0;
              Consecutivo := ObtenerConsecutivo(IBSQ);

// Almacenar Comprobante en Ceros
              sentencia := 'insert into "con$comprobante" values (';
              sentencia := sentencia + IntToStr(Consecutivo) + ','+ IntToStr(AgenciaT) + ',';
              sentencia := sentencia + '2,'''+ DateToStr(ffechaactual(IBDatabase2))+''',';
              sentencia := sentencia + '''Traslado de productos del Asociado: ' + Asociado + ', Identificado con Documento: '+ id + ''',0,0,';
              sentencia := sentencia + '''O'',0,'' '',''' + DBAlias + ''')';

              with IBInsertar do
              begin
                Close;
                SQL.Clear;
                SQL.Add(sentencia);
                try
                  ExecSQL;
                  Transaction.CommitRetaining;
                except
                   Transaction.RollbackRetaining;
//                      ShowMessage(tabla + sentencia );
                end; // del try
              end; // del begin with

// Almacenar Datos Auxiliar

              Comp := Format('%.7d',[Consecutivo]);

              tabla := 'insert into "' + nRegistro.Properties.Item[0].Value + '" values(';

              for j := 0 to nRegistro.Items.Count - 1 do
              begin
                 Application.ProcessMessages;
                 nCampo := nRegistro.Items[j];
                 // asignar los valores a variables
                   Codigo :=  nCampo.Items.Item[0].Value;
                   Valor := StrToCurr(nCampo.Items.Item[1].Value);

                   if Valor > 0 then
                   begin
                     TotalDebito := TotalDebito  + Valor;
                     sentencia :=  Comp + ',' +
                                   IntToStr(AgenciaT) + ',''' +
                                   DateToStr(fFechaActual(IBDatabase2)) + ''',' +
                                   Codigo + ',' +
                                   CurrToStr(Valor)  + ',' +
                                   '0' + ',' +
                                   'NULL' + ',' +
                                   'NULL' + ',' +
                                   '0' + ',' +
                                   'NULL' + ',' +
                                   '0' + ',' +
                                   '0' + ',' +
                                   '''O''';
                   end
                   else
                   begin
                     TotalCredito := TotalCredito + -Valor;
                     sentencia :=  Comp + ',' +
                                   IntToStr(AgenciaT) + ',''' +
                                   DateToStr(fFechaActual(IBDatabase2)) + ''',' +
                                   Codigo + ',' +
                                   '0' + ',' +
                                   CurrToStr(-Valor)  + ',' +
                                   'NULL' + ',' +
                                   'NULL' + ',' +
                                   '0' + ',' +
                                   'NULL' + ',' +
                                   '0' + ',' +
                                   '0' + ',' +
                                   '''O''';
                   end;
//                 ShowMessage(sentencia);
                 Memo1.Lines.Add(#13 + #13);
                 Memo1.Lines.Add(tabla + sentencia + ')');

                 with IBInsertar do
                 begin
                    Close;
                    SQL.Clear;
                    SQL.Add(tabla + sentencia + ')');
                    try
                      ExecSQL;
                      Transaction.CommitRetaining;
                    except
                      Transaction.RollbackRetaining;
//                      ShowMessage(tabla + sentencia );
                    end; // del try
                 end; // del begin
                 sentencia := '';
              end; // fin del begin for j

// Actualizar saldos del comprobante
              tabla := 'update "con$comprobante" set TOTAL_DEBITO = ' +
                        CurrToStr(TotalDebito) + ', TOTAL_CREDITO = ' +
                        CurrToStr(TotalCredito);
              tabla := tabla + ' where ID_COMPROBANTE = ' + Comp;

              with IBInsertar do
              begin
                Close;
                SQL.Clear;
                SQL.Add(tabla);
                try
                  ExecSQL;
                  Transaction.CommitRetaining;
                except
                   Transaction.RollbackRetaining;
//                      ShowMessage(tabla + sentencia );
                end; // del try
              end; // del begin with

           end;

        end;
        IBInsertar.Transaction.Commit;
        ShowMessage('Proceso de Inserción culminado con exito!');
end;

function TfrmXml.FldToStr(const Value : TFieldType) : String;
begin
   Case Value of
   ftUnknown    :  FldToStr := 'Unknown';
   ftString     :  FldToStr := 'String';
   ftSmallint   :  FldToStr := 'SmallInt';
   ftInteger    :  FldToStr := 'Integer';
   ftWord       :  FldToStr := 'Word';
   ftBoolean    :  FldToStr := 'Boolean';
   ftFloat      :  FldToStr := 'Float';
   ftCurrency   :  FldToStr := 'Currency';
   ftBCD        :  FldToStr := 'BCD';
   ftDate       :  FldToStr := 'Date';
   ftTime       :  FldToStr := 'Time';
   ftDateTime   :  FldToStr := 'DateTime';
   ftBytes      :  FldToStr := 'Bytes';
   ftVarBytes   :  FldToStr := 'VarBytes';
   ftAutoInc    :  FldToStr := 'AutoInc';
   ftBlob       :  FldToStr := 'Blob';
   ftMemo       :  FldToStr := 'Memo';
   ftGraphic    :  FldToStr := 'Graphic';
   ftFmtMemo    :  FldToStr := 'FmtMemo';
   ftParadoxOle :  FldToStr := 'ParadoxOle';
   ftDBaseOle   :  FldToStr := 'DBaseOle';
   ftTypedBinary: FldToStr := 'TypedBinary';
   ftCursor     :  FldToStr := 'Cursor';
   ftFixedChar  :  FldToStr := 'FixedChar';
   ftWideString :  FldToStr := 'WideString';
   ftLargeint   :  FldToStr := 'LargeInt';
   ftADT        :  FldToStr := 'ADT';
   ftArray      :  FldToStr := 'Array';
   ftReference  :  FldToStr := 'Reference';
   ftDataSet    :  FldToStr := 'DataSet';
   ftOraBlob    :  FldToStr := 'OraBlob';
   ftOraClob    :  FldToStr := 'OraClob';
   ftVariant    :  FldToStr := 'Variant';
   ftInterface  :  FldToStr := 'Interface';
   ftIDispatch  :  FldToStr := 'IDispatch';
   ftGuid       :  FldToStr := 'GUID';
   ftTimeStamp  :  FldToStr := 'TimeStamp';
   ftFMTBcd     :  FldToStr := 'FMTBcd';
   end;
end;

end.
