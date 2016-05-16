unit UnitMovimientoCredito_F1019v9;

interface

uses
  DateUtils, StrUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IBSQL, DB, DBClient, IBCustomDataSet, IBQuery, Grids, StdCtrls,
  Buttons, ExtCtrls, JvTypedEdit, JvEdit, JvSpecialProgress, XLSfile,
  DBGrids, IBDatabase, DataSetToExcel;

type
  TfrmMovimientoCredito_F1019v9 = class(TForm)
    Bar2: TJvSpecialProgress;
    Bar1: TJvSpecialProgress;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdMonto: TJvCurrencyEdit;
    EdPeriodo: TJvYearEdit;
    Panel1: TPanel;
    btnProcesar: TBitBtn;
    btnCerrar: TBitBtn;
    btnAExcel: TBitBtn;
    IBQuery1: TIBQuery;
    sd1: TSaveDialog;
    IBSQL2: TIBSQL;
    IBSQL1: TIBQuery;
    Bar3: TJvSpecialProgress;
    IBQuery2: TIBQuery;

    Label3: TLabel;
    JvSaldo: TJvCurrencyEdit;
    IBGMF: TIBQuery;
    Edit1: TEdit;
    CdsDatosCuenta: TClientDataSet;
    CdsDatosCuentaDEBITO: TCurrencyField;
    CdsDatosCuentaCREDITO: TCurrencyField;
    CdsDatosCuentaSALDO: TCurrencyField;
    CdsDatosCuentaFECHA: TDateField;
    CDSInfo: TClientDataSet;
    CDSInfoTIPODOCUMENTO: TIntegerField;
    CDSInfoDOCUMENTO: TStringField;
    CDSInfoDV: TIntegerField;
    CDSInfoPRIMER_APELLIDO: TStringField;
    CDSInfoSEGUNDO_APELLIDO: TStringField;
    CDSInfoNOMBRE: TStringField;
    CDSInfoPERIODO: TIntegerField;
    CDSInfoSEGUNDO_NOMBRE: TStringField;
    CDSInfoRAZONSOCIAL: TStringField;
    CDSInfoDIRECCION: TStringField;
    CDSInfoDEPARTAMENTO: TIntegerField;
    CDSInfoMUNICIPIO: TIntegerField;
    CDSInfoPAIS: TIntegerField;
    CDSInfoSALDOFINAL: TCurrencyField;
    CDSInfoPROMEDIO: TCurrencyField;
    CDSInfoMEDIANA: TCurrencyField;
    CDSInfoMAXIMO: TCurrencyField;
    CDSInfoMINIMO: TCurrencyField;
    CDSInfoVALORCREDITO: TCurrencyField;
    CDSInfoNUMEROCREDITO: TIntegerField;
    CDSInfoPROMEDIOCREDITO: TCurrencyField;
    CDSInfoMEDIANACREDITO: TCurrencyField;
    CDSInfoDEBITO: TCurrencyField;
    CDSInfoNUMERODEBITO: TCurrencyField;
    CDSInfoPROMEDIODEBITO: TCurrencyField;
    Data: TDBGrid;
    DSData: TDataSource;
    CDSSaldoInicialMes: TClientDataSet;
    CDSSaldoInicialMesMES: TIntegerField;
    CDSSaldoInicialMesSALDOINICIAL: TCurrencyField;
    Transaction: TIBTransaction;
    procedure btnProcesarClick(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnAExcelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  type TPersona = class(TObject)
        public
           TipoDocumento: String;
           NumeroDocumento: String;
           DigitoVerificacion: String;
           PrimerApellido: String;
           SegundoApellido: String;
           PrimerNombre: String;
           SegundoNombre: String;
           RazonSocial: String;
           Direccion: String;
           Departamento: String;
           Municipio: String;
           Pais: String;
  end;

var
  frmMovimientoCredito_F1019v9: TfrmMovimientoCredito_F1019v9;

implementation

{$R *.dfm}

uses UnitDmGeneral,UnitGlobales;

procedure TfrmMovimientoCredito_F1019v9.btnProcesarClick(Sender: TObject);
var
  Id:string;
  Dg:string;
  Tp:string;
  Nm:string;
  Dr:string;
  Dpto :string;
  Mn:string;
  Total:Integer;
  Fila,jFila:Integer;
  Saldo,Credito,Interes:Currency;
  Saldo1,Credito1,Interes1:Currency;
  Cuenta:string;
  iAgencia,iTipo,iCuenta,iDigito:Integer;
  vCodMunicipio :string;
  _sNombre :string;
  _cSaldoCheque :Currency;
  Persona: TPersona;

begin
        Fila := -1;
        jFila := -1;
        Application.ProcessMessages;

        Persona := TPersona.Create;



        with IBQuery1 do
        begin
         Transaction.StartTransaction;
         SQL.Clear;
         SQL.Add('select distinct');
         SQL.Add('"gen$persona".ID_IDENTIFICACION,');
         SQL.Add('"gen$persona".ID_PERSONA,');
         SQL.Add('"gen$persona".PRIMER_APELLIDO, "gen$persona".SEGUNDO_APELLIDO, "gen$persona".NOMBRE,');
         SQL.Add('"gen$direccion".DIRECCION || '' '' || "gen$direccion".BARRIO AS DIRECCION,');
         SQL.Add('"gen$direccion".MUNICIPIO AS MUNICIPIO,"gen$direccion".COD_MUNICIPIO');
         SQL.Add('from');
         SQL.Add('"gen$persona"');
         SQL.Add('left join "gen$direccion" on ("gen$persona".ID_IDENTIFICACION = "gen$direccion".ID_IDENTIFICACION and');
         SQL.Add('"gen$persona".ID_PERSONA = "gen$direccion".ID_PERSONA and "gen$direccion".ID_DIRECCION = 1 ');
         SQL.Add('and "gen$direccion".ID_DIRECCION = 1) ');
         try
           Open;
           Last;
           First;
           Bar3.Minimum := 0;
           Bar3.Maximum := Recordcount;
         except
           Transaction.Rollback;
           raise;
         end;



         while not Eof do begin
           Bar3.Position := RecNo;
           Application.ProcessMessages;

           Persona.TipoDocumento := '';
           Persona.NumeroDocumento := '';
           Persona.DigitoVerificacion := '';
           Persona.PrimerApellido := '';
           Persona.SegundoApellido := '';
           Persona.PrimerNombre := '';
           Persona.SegundoNombre := '';
           Persona.RazonSocial := '';
           Persona.Direccion := '';
           Persona.Departamento := '';
           Persona.Municipio := '';
           Persona.Pais := '';

//Primera Parte, Datos del Asociado
         case FieldByName('ID_IDENTIFICACION').AsInteger of
             1: Tp := '11';
             2: Tp := '12';
             3: Tp := '13';
             4: Tp := '31';
             6: Tp := '22';
             9: Tp := '11';//NUI son registrados como Registros Civiles
         end;

         Persona.TipoDocumento := Tp;
         if FieldByName('ID_IDENTIFICACION').AsInteger = 4 then
         begin
            Id := LeftStr(FieldByName('ID_PERSONA').AsString,Length(FieldByName('ID_PERSONA').AsString)-1);
            Dg := RightStr(FieldByName('ID_PERSONA').AsString,1);
         end
         else
         begin
            Id := FieldByName('ID_PERSONA').AsString;
            Dg := '';
         end;

         Persona.NumeroDocumento := Id;
         Persona.DigitoVerificacion := Dg;

         if Tp <> '31' then
         begin
            Persona.PrimerApellido := FieldByName('PRIMER_APELLIDO').AsString;
            Persona.SegundoApellido := FieldByName('SEGUNDO_APELLIDO').AsString;
            _sNombre := Trim(FieldByName('NOMBRE').AsString);
            Persona.PrimerNombre := _sNombre;
            if Pos(' ', _sNombre) > 0 then
            begin
              Persona.PrimerNombre := LeftStr(_sNombre,Pos(' ', _sNombre)-1);
              Persona.SegundoNombre := RightStr(_sNombre,Length(_sNombre) - Pos(' ', _sNombre));
            end;
         end
         else
         begin
                Persona.PrimerApellido := '';
                Persona.SegundoApellido := '';
                Persona.PrimerNombre := '';
                Persona.SegundoNombre := '';
         end;

         if Tp = '31' then
                Persona.RazonSocial := Trim(FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString + ' ' + FieldByName('NOMBRE').AsString)
         else
                Persona.RazonSocial := '';


         Dr := Trim(FieldByName('DIRECCION').AsString);
         Persona.Direccion := Dr;

         vCodMunicipio := FieldByName('COD_MUNICIPIO').AsString;
         if (vCodMunicipio = '') Then vCodMunicipio := '00000';
         
         try
            if StrLen(PChar(vCodMunicipio)) = 4 then
             vCodMunicipio := '0' +  vCodMunicipio;
            if (vCodMunicipio = '') then vCodMunicipio := '00000';
             Dpto := FormatCurr('00',StrToInt(LeftStr(vCodMunicipio,2)));
             Mn := FormatCurr('000',StrToInt(RightStr(vCodMunicipio,3)));
           except
              begin
                Mn := '00';
                Dpto := '000';
              end;
         end;


         Persona.Departamento := Dpto;
         Persona.Municipio := Mn;

// Fin Primera Parte, Datos del Asociado

// Segunda Parte, Leer Datos de Cuentas y Calcular Promedios
           IBSQL1.Close;
           IBSQL1.SQL.Clear;
           IBSQL1.SQL.Add('select');
           IBSQL1.SQL.Add('"cap$maestro".ID_AGENCIA,');
           IBSQL1.SQL.Add('"cap$maestro".ID_TIPO_CAPTACION,');
           IBSQL1.SQL.Add('"cap$maestro".NUMERO_CUENTA,');
           IBSQL1.SQL.Add('"cap$maestro".DIGITO_CUENTA');
           IBSQL1.SQL.Add('from');
           IBSQL1.SQL.Add('"cap$maestrotitular"');
           IBSQL1.SQL.Add('inner join');
           IBSQL1.SQL.Add('"cap$maestro" on ("cap$maestrotitular".ID_AGENCIA = "cap$maestro".ID_AGENCIA and');
           IBSQL1.SQL.Add('"cap$maestrotitular".ID_TIPO_CAPTACION = "cap$maestro".ID_TIPO_CAPTACION and');
           IBSQL1.SQL.Add('"cap$maestrotitular".NUMERO_CUENTA = "cap$maestro".NUMERO_CUENTA and');
           IBSQL1.SQL.Add('"cap$maestrotitular".DIGITO_CUENTA = "cap$maestro".DIGITO_CUENTA)');
           IBSQL1.SQL.Add('where');
           IBSQL1.SQL.Add('"cap$maestrotitular".ID_IDENTIFICACION = :ID_IDENTIFICACION and');
           IBSQL1.SQL.Add('"cap$maestrotitular".ID_PERSONA = :ID_PERSONA and');
           IBSQL1.SQL.Add('"cap$maestrotitular".ID_TIPO_CAPTACION IN (2,4) and');
           IBSQL1.SQL.Add('"cap$maestro".ID_ESTADO <> 15');
           IBSQL1.SQL.Add('and');
           IBSQL1.SQL.Add('"cap$maestrotitular".NUMERO_TITULAR = 1 ');
           IBSQL1.SQL.Add('order by');
           IBSQL1.SQL.Add('"cap$maestro".ID_AGENCIA,');
           IBSQL1.SQL.Add('"cap$maestro".ID_TIPO_CAPTACION,');
           IBSQL1.SQL.Add('"cap$maestro".NUMERO_CUENTA,');
           IBSQL1.SQL.Add('"cap$maestro".DIGITO_CUENTA');
           IBSQL1.ParamByName('ID_IDENTIFICACION').AsInteger := FieldByName('ID_IDENTIFICACION').AsInteger;
           IBSQL1.ParamByName('ID_PERSONA').AsString := FieldByName('ID_PERSONA').AsString;
           try
            IBSQL1.Open;
            IBSQL1.Last;
            IBSQL1.First;
           except
            Transaction.Rollback;
            raise;
           end;
           Bar1.Maximum := IBSQL1.RecordCount;
           Bar1.Position := 0;

           while not IBSQL1.Eof do
           begin

             Bar1.Position := IBSQL1.RecNo;
             Application.ProcessMessages;
             if IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger < 6 then
             begin
              IBQuery2.Close;
              IBQuery2.SQL.Clear;
              IBQuery2.SQL.Add('select * from "cap$extracto"');
              IBQuery2.SQL.Add('where');
              IBQuery2.SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
              IBQuery2.SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
              IBQuery2.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and');
              IBQuery2.SQL.Add('DIGITO_CUENTA = :DIGITO_CUENTA and');
              IBQuery2.SQL.Add('(FECHA_MOVIMIENTO BETWEEN :FECHA1 and :FECHA2) and');
              IBQuery2.SQL.Add('VALOR_DEBITO <> 0');
              IBQuery2.ParamByName('ID_AGENCIA').AsInteger := IBSQL1.fieldbyname('ID_AGENCIA').AsInteger;
              IBQuery2.ParamByName('ID_TIPO_CAPTACION').AsInteger := IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
              IBQuery2.ParamByName('NUMERO_CUENTA').AsInteger := IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger;
              IBQuery2.ParamByName('DIGITO_CUENTA').AsInteger := IBSQL1.FieldByName('DIGITO_CUENTA').AsInteger;
              IBQuery2.ParamByName('FECHA1').AsDate := _dFechaInicial;
              IBQuery2.ParamByName('FECHA2').AsDate := _dFechaCorteAhorros;
              try
                IBQuery2.Open;
                IBQuery2.Last;
                IBQuery2.First;
              except
                IBQuery2.Transaction.Rollback;
                raise;
              end;
              Bar2.Maximum := IBQuery2.RecordCount;
              while not IBQuery2.Eof do
              begin
                Bar2.Position := IBQuery2.RecNo;
                Application.ProcessMessages;
                //Validacion para reportes antiguos, en el caso de los desembolsos

                if ( ((IBQuery2.FieldByName('ID_TIPO_MOVIMIENTO').AsInteger = 6) or (IBQuery2.FieldByName('ID_TIPO_MOVIMIENTO').AsInteger = 1) ) and
                     (Pos('CARTE',IBQuery2.FieldByName('DOCUMENTO_MOVIMIENTO').AsString) <> 0) or
                     (Pos('CONSIGNACION POR DESEMBOLSO',IBQuery2.FieldByName('DESCRIPCION_MOVIMIENTO').AsString)<>0) ) then
                begin
                   IBQuery2.Next;
                   Continue;
                end;
                if IBQuery2.FieldByName('ID_TIPO_MOVIMIENTO').AsInteger <> 23 then // REVERSIONES DE TARJETA DEBITO
                begin
                  Credito1 := Credito1 + IBQuery2.FieldByName('VALOR_DEBITO').AsCurrency;
                  Credito := Credito + IBQuery2.FieldByName('VALOR_DEBITO').AsCurrency;
                end;
                if IBQuery2.FieldByName('ID_TIPO_MOVIMIENTO').AsInteger = 31 then // DEVOLUCION DE CHEQUES
                begin
                   _cSaldoCheque := _cSaldoCheque + IBQuery2.FieldByName('VALOR_CREDITO').AsCurrency;
                end;

                IBQuery2.Next;
              end; // fin del while
             end; // fin del if
// Saldo en Depositos e Intereses Causados
             Credito := Credito - _cSaldoCheque;
             Credito1 := Credito1 - _cSaldoCheque;
             case IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger of
             2,
             4,
             5: begin
                 IBSQL2.Close;
                 IBSQL2.SQL.Clear;
                 IBSQL2.SQL.Add('select SALDO_ACTUAL from SALDO_ACTUAL_MES_NOTD(:AGENCIA,:TIPO,:NUMERO,:DIGITO,:ANO,:FECHA1,:FECHA2)');
                 IBSQL2.ParamByName('AGENCIA').AsInteger := IBSQL1.fieldbyname('ID_AGENCIA').AsInteger;
                 IBSQL2.ParamByName('TIPO').AsInteger := IBSQL1.fieldbyname('ID_TIPO_CAPTACION').AsInteger;
                 IBSQL2.ParamByName('NUMERO').AsInteger := IBSQL1.fieldbyname('NUMERO_CUENTA').AsInteger;
                 IBSQL2.ParamByName('DIGITO').AsInteger := IBSQL1.fieldbyname('DIGITO_CUENTA').AsInteger;
                 IBSQL2.ParamByName('ANO').AsString := IntToStr(EdPeriodo.Value);
                 IBSQL2.ParamByName('FECHA1').AsDate := _dFechaInicial;
                 IBSQL2.ParamByName('FECHA2').AsDate := _dFechaCorteAhorros;
                 try
                  IBSQL2.ExecQuery;
                  Saldo1 := Saldo1 + IBSQL2.FieldByName('SALDO_ACTUAL').AsCurrency;
                  Saldo := Saldo + IBSQL2.FieldByName('SALDO_ACTUAL').AsCurrency;
                 except
                  Transaction.Rollback;
                  raise;
                 end;
                end; // fin del begin
             6: begin
                 IBSQL2.Close;
                 IBSQL2.SQL.Clear;
                 IBSQL2.SQL.Add('select');
                 IBSQL2.SQL.Add('"cap$causacioncdat".VALOR_INICIAL, "cap$causacioncdat".VALOR');
                 IBSQL2.SQL.Add('from');
                 IBSQL2.SQL.Add('"cap$causacioncdat"');
                 IBSQL2.SQL.Add('where');
                 IBSQL2.SQL.Add('"cap$causacioncdat".ID_AGENCIA = :ID_AGENCIA and');
                 IBSQL2.SQL.Add('"cap$causacioncdat".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                 IBSQL2.SQL.Add('"cap$causacioncdat".NUMERO_CUENTA = :NUMERO_CUENTA and');
                 IBSQL2.SQL.Add('"cap$causacioncdat".DIGITO_CUENTA = :DIGITO_CUENTA and');
                 IBSQL2.SQL.Add('"cap$causacioncdat".ANO = :ANO and');
                 IBSQL2.SQL.Add('"cap$causacioncdat".MES = :MES');
                 IBSQL2.ParamByName('ANO').AsInteger := EdPeriodo.Value;
                 IBSQL2.ParamByName('MES').AsInteger := MonthOf(_dFechaCorteAhorros);
                 try
                  IBSQL2.ExecQuery;
                  Saldo1 := Saldo1 + IBSQL2.FieldByName('VALOR_INICIAL').AsCurrency;
                  Interes1 := Interes1 + IBSQL2.FieldByName('VALOR').AsCurrency;
                  Saldo := Saldo + IBSQL2.FieldByName('VALOR_INICIAL').AsCurrency;
                  Interes := Interes + IBSQL2.FieldByName('VALOR').AsCurrency;
                 except
                  Transaction.Rollback;
                  raise;
                 end;
                end; // fin del begin 6
             end; // fin del case

            IBSQL1.Next; // next del query captaciones
           end; // fin del while del IBSQL1
// Validar Saldo

           if (Credito >= EdMonto.Value) or (Saldo >= JvSaldo.Value) then
           begin
                 

           end; // fin del while Cds1

         Next; //next del query personas
         end; // fin del While de ibquery1
         Transaction.Commit;
        end; // Fin del With IBQuery1

end;

procedure TfrmMovimientoCredito_F1019v9.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMovimientoCredito_F1019v9.btnAExcelClick(Sender: TObject);
var   ExcelFile:TDataSetToExcel;
begin
        if SD1.Execute then
        begin
          CDSinfo.First;
          ExcelFile := TDataSetToExcel.Create(CDSInfo,SD1.FileName);
          ExcelFile.WriteFile;
          ExcelFile.Free;
        end;
end;

procedure TfrmMovimientoCredito_F1019v9.FormCreate(Sender: TObject);
begin
             EdPeriodo.Value := YearOf(fFechaActual) -1 ;
end;

end.
