unit UnitCartera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, math, StdCtrls, JvEdit, JvFloatEdit, Grids, XStringGrid, DB,
  IBCustomDataSet, IBQuery, IBSQL, JvTypedEdit, IBDatabase, pr_Common,
  pr_TxClasses, Buttons;

type
  TFrmCartera = class(TForm)
    IBQTabla: TIBQuery;
    IBQuery1: TIBQuery;
    IBGrupo3: TIBQuery;
    IBextracto: TIBQuery;
    IBbarrido: TIBQuery;
    IBConsecB: TIBQuery;
    IBcomprobante: TIBQuery;
    IBTransaction1: TIBTransaction;
    IBGrupo1: TIBQuery;
    QueryComprobante: TIBQuery;
    QueryComprobanteID_COMPROBANTE: TIntegerField;
    QueryComprobanteFECHADIA: TDateField;
    QueryComprobanteDESCRIPCION: TMemoField;
    QueryComprobanteTOTAL_DEBITO: TIBBCDField;
    QueryComprobanteTOTAL_CREDITO: TIBBCDField;
    QueryComprobanteESTADO: TIBStringField;
    QueryComprobanteIMPRESO: TSmallintField;
    QueryComprobanteANULACION: TMemoField;
    QueryComprobanteDESCRIPCION1: TIBStringField;
    QueryAuxiliar: TIBQuery;
    QueryAuxiliarID_COMPROBANTE: TIntegerField;
    QueryAuxiliarID_AGENCIA: TSmallintField;
    QueryAuxiliarCODIGO: TIBStringField;
    QueryAuxiliarNOMBRE: TIBStringField;
    QueryAuxiliarDEBITO: TIBBCDField;
    QueryAuxiliarCREDITO: TIBBCDField;
    QueryAuxiliarID_CUENTA: TIBStringField;
    QueryAuxiliarID_COLOCACION: TIBStringField;
    QueryAuxiliarID_IDENTIFICACION: TSmallintField;
    QueryAuxiliarID_PERSONA: TIBStringField;
    QueryAuxiliarMONTO_RETENCION: TIBBCDField;
    QueryAuxiliarTASA_RETENCION: TFloatField;
    report10: TprTxReport;
    IBAuxiliar: TIBQuery;
    Report3: TprTxReport;
    IBTransaction2: TIBTransaction;
    IBcolextractode: TIBQuery;
    IBTransaction3: TIBTransaction;
    IBTransaction4: TIBTransaction;
    IBTransaction5: TIBTransaction;
    report: TprTxReport;
    IBtrancuotas: TIBTransaction;
    IBconbarrido: TIBQuery;
    IBCuotas: TIBSQL;
    IBCuotas1: TIBQuery;
    IBTrancuotas1: TIBTransaction;
    IBtranbarrido: TIBTransaction;
    GridColocaciones: TXStringGrid;
    BitBtn1: TBitBtn;
    d: TJvIntegerEdit;
    v: TJvCurrencyEdit;
    n: TJvIntegerEdit;
    BitBtn2: TBitBtn;
    IBbusbaempleado: TIBQuery;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);

  private

    { Private declarations }
  public
  vTotalLiquidacion:Currency;
  CodigoAhorros:string;
  abono_capital : currency;
  abono_cxc : currency;
  abono_servicios : currency;
  abono_anticipado: currency;
  abono_mora : Currency;
  agencia : Integer;
  VNocomprobante : string;
  ConsecBarridoInicial,ConsecBarridoFinal : string;
    function saldocredito(nit: integer): currency;
    function saldocreditoAg(nit: integer): Currency;
    procedure BarridoEmpleados;
    procedure contable(comprobante: string;tipo_nomina:integer);
    procedure cuenta(opcion: integer);
    procedure buscarnumero;
    procedure actualizav;
    { Public declarations }
  end;

var
  FrmCartera: TFrmCartera;
   vTotalAhorros:Currency;
   fechahoy :TDate;

implementation

uses unitglobalescol,unitdata, UnitQuerys,unitdatamodulo,
  UnitPrincipal,Unitglobales,UnitGlobal,UnitVistaPreliminar,
  UnitdmColocacion, UnitRealizaNomina, UnitdataQuerys, UnitCausacion,
  UnitPantallaProgreso, UnitdmGeneral;

{$R *.dfm}

procedure TFrmCartera.BarridoEmpleados;
var Fecha:TDate;
    Dias,Conteo:Integer;
    Amortiza :Integer;
    Tipo:string;
    tipo_nomina:Integer;
    CuotasaLiquidar:Integer;
    fecha_cortebarrido : TDate;
    valor_mes,valor_ano :string;
    saldo_credito :Currency;
begin
             dmColocacion := TdmColocacion.Create(self);
             Dias := 0;
             with IBQTabla do
              begin
                Close;
                verificatransaccion(IBQTabla);
                SQL.Clear;
                SQL.Add('delete from "col$barridoCartera"');
                Open;
                Transaction.Commit;
                Close;
              end;
        Conteo := 0;
        valor_mes := IntToStr(strtoint(FormatDateTime('m',FrMain.fechacartera))+1);
        with DataQuerys.IBdatos do
        begin
           SQL.Clear;
           SQL.Add('select "nom$empleado"."nitempleado","nom$empleado"."tipo_nomina" from "nom$empleado"');
           SQL.Add('where ("nom$empleado"."numero_cuenta" <> 0)');
           //SQL.Add('where ("nom$empleado"."tipo_nomina" IN (10,20))');
           //SQL.Add('and "nom$empleado"."nitempleado" <> :nit_empleado'); //opcion temporal para no tomar descuentos
           //ParamByName('nit_empleado').AsInteger := 88283430;// opcion temporal
           Open;
           Last;
           First;
           FrmProgresos := TFrmProgresos.Create(self);
           frmProgresos.Titulo := 'Espere Un Momento Realizando Barrido';
           frmProgresos.Max := RecordCount;
           frmProgresos.Min := 0;
           frmProgresos.Ejecutar;
          while not Eof do
          begin
            FrmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Empleado No : '+IntToStr(RecNo);
            Application.ProcessMessages;
            tipo_nomina := DataQuerys.IBdatos.FieldByName('tipo_nomina').AsInteger;
            if StrToInt(valor_mes) < 13 then
               fecha_cortebarrido := StrToDate(FormatDateTime('yyyy/'+valor_mes+'/24',FrMain.fechacartera))
            else
            begin
               valor_ano := FormatDateTime('yyyy',FrMain.fechacartera);
               valor_ano := IntToStr(StrToInt(valor_ano) + 1);
               fecha_cortebarrido := StrToDate(FormatDateTime(valor_ano+'/01/24',FrMain.fechacartera))
            end;
            with IBQuery1 do begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT');
                SQL.Add('"col$colocacion".ID_AGENCIA,');
                SQL.Add('"col$colocacion".ID_COLOCACION,');
                SQL.Add('"col$colocacion".ID_IDENTIFICACION,');
                SQL.Add('"col$colocacion".ID_PERSONA,');
                SQL.Add('"col$colocacion".ID_CLASIFICACION,');
                SQL.Add('"col$colocacion".ID_CATEGORIA,');
                SQL.Add('"col$colocacion".ID_GARANTIA,');
                SQL.Add('"col$colocacion".ID_ESTADO_COLOCACION,');
                SQL.Add('"col$colocacion".ID_TIPO_CUOTA,');
                SQL.Add('"col$colocacion".ID_INTERES,');
                SQL.Add('"col$colocacion".TIPO_INTERES,');
                SQL.Add('"gen$persona".PRIMER_APELLIDO,');
                SQL.Add('"gen$persona".SEGUNDO_APELLIDO,');
                SQL.Add('"gen$persona".NOMBRE,');
                SQL.Add('"col$colocacion".FECHA_CAPITAL,');
                SQL.Add('"col$colocacion".FECHA_INTERES,');
                SQL.Add('"col$colocacion".AMORTIZA_CAPITAL,');
                SQL.Add('"col$colocacion".AMORTIZA_INTERES,');
                SQL.Add('"col$colocacion".VALOR_CUOTA,');
                SQL.Add('"col$colocacion".VALOR_DESEMBOLSO - "col$colocacion".ABONOS_CAPITAL AS SALDO,');
                SQL.Add('"col$colocacion".TASA_INTERES_CORRIENTE,');
                SQL.Add('"col$colocacion".TASA_INTERES_MORA,');
                SQL.Add('"col$colocacion".PUNTOS_INTERES,');
                SQL.Add('"col$colocacion".DIAS_PRORROGADOS,');
                SQL.Add('"col$estado".DESCRIPCION_ESTADO_COLOCACION,');
                SQL.Add('"col$tasasvariables".VALOR_ACTUAL_TASA,');
                SQL.Add('"col$tiposcuota".DESCRIPCION_TIPO_CUOTA,');
                SQL.Add('"col$tiposcuota".CAPITAL,');
                SQL.Add('"col$tiposcuota".INTERES');
                SQL.Add('FROM');
                SQL.Add('"col$colocacion"');
                SQL.Add('LEFT JOIN "gen$persona" ON ("col$colocacion".ID_IDENTIFICACION = "gen$persona".ID_IDENTIFICACION) AND ("col$colocacion".ID_PERSONA = "gen$persona".ID_PERSONA)');
                SQL.Add('INNER JOIN "col$estado" ON ("col$colocacion".ID_ESTADO_COLOCACION = "col$estado".ID_ESTADO_COLOCACION)');
                SQL.Add('LEFT OUTER JOIN "col$tasasvariables" ON ("col$colocacion".ID_INTERES = "col$tasasvariables".ID_INTERES) ');
                SQL.Add('INNER JOIN "col$tiposcuota" ON ("col$colocacion".ID_TIPO_CUOTA = "col$tiposcuota".ID_TIPOS_CUOTA)');
                SQL.Add('WHERE');
                SQL.Add('("col$colocacion".ID_ESTADO_COLOCACION = 0) and ');
                SQL.Add('("col$colocacion".ID_TIPO_CUOTA = 1)');
                SQL.Add('and("gen$persona".ID_PERSONA = :nit)');
                SQL.Add('Order by "col$colocacion".ID_ESTADO_COLOCACION DESC, "col$colocacion".FECHA_INTERES DESC');
                ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('nitempleado').AsString;
                try
                Open;
                  while not Eof do
                  begin
                  if BuscaCol(FieldByName('ID_COLOCACION').AsString) = False then
                  begin
                    if FieldByName('SALDO').AsCurrency > 0 then
                    begin
                      Fecha := FieldByName('FECHA_INTERES').AsDateTime;
                      Tipo := FieldByName('INTERES').AsString;
                      Amortiza := FieldByName('AMORTIZA_INTERES').AsInteger;
                      saldo_credito := FieldByName('SALDO').AsCurrency;
                        Fecha := CalculoFecha(Fecha,Amortiza);
                        if (Int(Fecha) <= Int(fecha_cortebarrido)) and (saldo_credito > 0)  then
                        begin // valida fecha
                      Conteo := Conteo + 1;
                      GridColocaciones.RowCount := Conteo + 1;
                      GridColocaciones.Cells[0,Conteo] := FieldByName('ID_COLOCACION').AsString;
                      GridColocaciones.Cells[1,Conteo] := FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                                           FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                                           FieldByName('NOMBRE').AsString;
                      GridColocaciones.Cells[2,Conteo] := FormatCurr('$#,##0',FieldByName('SALDO').AsCurrency);
                      GridColocaciones.Cells[3,Conteo] := FormatCurr('$#,##0',FieldByName('VALOR_CUOTA').AsCurrency);
                      GridColocaciones.Cells[4,Conteo] := DateToStr(FieldByName('FECHA_CAPITAL').AsDateTime);
                      GridColocaciones.Cells[5,Conteo] := DateToStr(FieldByName('FECHA_INTERES').AsDateTime);
                      GridColocaciones.Cells[6,Conteo] := FieldByName('DESCRIPCION_ESTADO_COLOCACION').AsString;
                      GridColocaciones.Cells[7,Conteo] := IntToStr(Dias);
                      GridColocaciones.Cells[8,Conteo] := IntToStr(FieldByName('ID_IDENTIFICACION').AsInteger);
                      GridColocaciones.Cells[9,Conteo] := FieldByName('ID_PERSONA').AsString;
                      GridColocaciones.Cells[10,Conteo] := FieldByName('DESCRIPCION_TIPO_CUOTA').AsString;
                        with IBCuotas1 do
                        begin
                          SQL.Clear;
                          SQL.Add('select count(CUOTA_NUMERO) as CUOTAS');
                          SQL.Add('from "col$tablaliquidacion"');
                          SQL.Add('where');
                          SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and');
                          SQL.Add('ID_COLOCACION = :"ID_COLOCACION" and');
                          SQL.Add('PAGADA = 0 and');
                          SQL.Add('FECHA_A_PAGAR <= :"FECHA"');
                          ParamByName('ID_AGENCIA').AsInteger := 1;
                          ParamByName('ID_COLOCACION').AsString := IBQuery1.FieldByName('ID_COLOCACION').AsString;
                          ParamByName('FECHA').AsDate := fecha_cortebarrido;//FechaHoy;
                          open;
                          CuotasaLiquidar := 1;//FieldByName('CUOTAS').AsInteger;
                          Close;
                       end; // fin ibcuotas
                       with IBQTabla do
                       begin
                         Close;
                         verificatransaccion(IBQTabla);
                         SQL.Clear;
                         SQL.Add('insert into "col$barridoCartera" values(');
                         SQL.Add(':"AGENCIA",');
                         SQL.Add(':"COLOCACION",');
                         SQL.Add(':"IDIDENTIFICACION",');
                         SQL.Add(':"IDPERSONA",');
                         SQL.Add(':"CUOTASALIQUIDAR",');
                         SQL.Add(':"CLASIFICACION",');
                         SQL.Add(':"CATEGORIA",');
                         SQL.Add(':"GARANTIA",');
                         SQL.Add(':"SALDOACTUAL",');
                         SQL.Add(':"ESTADO",');
                         SQL.Add(':"VALORCUOTA",');
                         SQL.Add(':"FECHAPAGOK",');
                         SQL.Add(':"FECHAPAGOI",');
                         SQL.Add(':"TIPOCUOTA",');
                         SQL.Add(':"IDINTERES",');
                         SQL.Add(':"TIPOINTERES",');
                         SQL.Add(':"VALORTASA",');
                         SQL.Add(':"VALORACTUALTASA",');
                         SQL.Add(':"VALORMORA",');
                         SQL.Add(':"PUNTOSADIC",');
                         SQL.Add(':"AMORTIZAK",');
                         SQL.Add(':"AMORTIZAI",');
                         SQL.Add(':"DIASPRORROGA",');
                         SQL.Add(':"TIPO_NOMINA")');
                         ParamByName('AGENCIA').AsInteger := IBQuery1.fieldbyname('ID_AGENCIA').AsInteger;
                         ParamByName('COLOCACION').AsString := IBQuery1.fieldbyname('ID_COLOCACION').AsString;
                         ParamByName('IDIDENTIFICACION').AsInteger := IBQuery1.fieldbyname('ID_IDENTIFICACION').AsInteger;
                         ParamByName('IDPERSONA').AsString := IBQuery1.fieldbyname('ID_PERSONA').AsString;
                         ParamByName('CUOTASALIQUIDAR').AsInteger := CuotasaLiquidar;
                         ParamByName('CLASIFICACION').AsInteger := IBQuery1.fieldbyname('ID_CLASIFICACION').AsInteger;
                         ParamByName('CATEGORIA').AsString := IBQuery1.fieldbyname('ID_CATEGORIA').AsString;
                         ParamByName('GARANTIA').AsInteger := IBQuery1.fieldbyname('ID_GARANTIA').AsInteger;
                         ParamByName('SALDOACTUAL').AsCurrency := IBQuery1.fieldbyname('SALDO').AsCurrency;
                         ParamByName('ESTADO').AsInteger := IBQuery1.fieldbyname('ID_ESTADO_COLOCACION').AsInteger;
                         ParamByName('VALORCUOTA').AsInteger := IBQuery1.fieldbyname('VALOR_CUOTA').AsInteger;
                         ParamByName('FECHAPAGOK').AsDate := IBQuery1.fieldbyname('FECHA_CAPITAL').AsDateTime;
                         ParamByName('FECHAPAGOI').AsDate := IBQuery1.fieldbyname('FECHA_INTERES').AsDateTime;
                         ParamByName('TIPOCUOTA').AsInteger := IBQuery1.fieldbyname('ID_TIPO_CUOTA').AsInteger;
                         ParamByName('IDINTERES').AsInteger := IBQuery1.fieldbyname('ID_INTERES').AsInteger;
                         ParamByName('TIPOINTERES').AsString := IBQuery1.fieldbyname('TIPO_INTERES').AsString;
                         ParamByName('VALORTASA').AsFloat := IBQuery1.fieldbyname('TASA_INTERES_CORRIENTE').AsFloat;
                         ParamByName('VALORACTUALTASA').AsFloat := IBQuery1.fieldbyname('VALOR_ACTUAL_TASA').AsFloat;
                         ParamByName('VALORMORA').AsFloat := IBQuery1.fieldbyname('TASA_INTERES_MORA').AsFloat;
                         ParamByName('PUNTOSADIC').AsFloat := IBQuery1.fieldbyname('PUNTOS_INTERES').AsFloat;
                         ParamByName('AMORTIZAK').AsInteger := IBQuery1.fieldbyname('AMORTIZA_CAPITAL').AsInteger;
                         ParamByName('AMORTIZAI').AsInteger := IBQuery1.fieldbyname('AMORTIZA_INTERES').AsInteger;
                         ParamByName('DIASPRORROGA').AsInteger := IBQuery1.fieldbyname('DIAS_PRORROGADOS').AsInteger;
                         ParamByName('TIPO_NOMINA').AsInteger := tipo_nomina;
                         Open;
                         Close;
                         Transaction.Commit;
                       end; // fin de with insert Ibqtabla
                       end;
                     end; // fin valida fecha
                  end; // fin del valida colocacion a no tener en cuenta
                   Next;
                    end;// fin comprueba tipo nomina
                  //fin de while busca colocaciones
                 IBQuery1.Close;
              //end; // fin if recordcount
                 except
                  Close;
                  MessageDlg('Error al buscar colocaciones, consulte con sistemas',mtError,[mbcancel],0);
                  Exit;
                end;
            end; // fin witnh busca colocaciones
          DataQuerys.IBdatos.Next;
        end; // fin while busca empleados
          DataQuerys.IBdatos.Close;
          frmProgresos.Cerrar;
        end; // fin del with busca empleados
end;

procedure TFrmCartera.FormCreate(Sender: TObject);
begin
        TRY
        fechahoy := FrMain.fechacartera;
        EXCEPT
        ShowMessage('EEROER');
        end;
end;

function TFrmCartera.saldocredito(nit: integer): currency;
var CuotasLiq:TCuotasLiq;
    AF:PCuotasLiq;
    I,J,K,L:Integer;
    Clasificacion:Integer;
    Categoria:string;
    Garantia:Integer;
    SaldoActual:Currency;
    TipoCapital:string;
    TipoInteres:Integer;
    TipoCuota:Integer;
    FechaPagoK:TDate;
    FechaPagoI:TDate;
    Estado:Integer;
    ValorTasa:Double;
    ValorMora:Double;
    ValorCuota:Currency;
    PuntosAdic:Double;
    AmortizaK:Integer;
    AmortizaI:Integer;
    DiasProrroga:Integer;
    IdAgencia : Integer;
    Colocacion : string;
    CuotasPendientes : Integer;
    Conteo:Integer;
    Cuota : Integer;
    total : Currency;
begin
         total := 0;
         fechahoy := FrMain.fechacartera;
         with DataQuerys.IBselecion do
         begin
           Close;
           verificatransaccion(DataQuerys.IBselecion);
           SQL.Clear;
           SQL.Add('Select * ');
           SQL.Add('from "col$barridoCartera"');
           SQL.Add('where "col$barridoCartera"."IDPERSONA" = :Nit');
           ParamByName('Nit').AsString := IntToStr(nit);
           Open;
           while not Eof do
            begin
              IdAgencia := FieldByName('AGENCIA').AsInteger;
              Colocacion := FieldByName('COLOCACION').AsString;
              Clasificacion := FieldByName('CLASIFICACION').AsInteger;
              Categoria     := FieldByName('CATEGORIA').AsString;
              Garantia      := FieldByName('GARANTIA').AsInteger;
              SaldoActual   := FieldByName('SALDOACTUAL').AsCurrency;
              TipoInteres   := FieldByName('IDINTERES').AsInteger;
              TipoCuota     := FieldByName('TIPOCUOTA').AsInteger;
              ValorCuota    := FieldByName('VALORCUOTA').AsCurrency;
              if FieldByName('TIPOINTERES').AsString = 'F' then
               ValorTasa := FieldByName('VALORTASA').AsFloat
              else
               ValorTasa := FieldByName('VALORACTUALTASA').AsFloat;
              PuntosAdic := FieldByName('PUNTOSADIC').AsFloat;
              ValorMora     := (ValorTasa + PuntosAdic) + FieldByName('VALORMORA').AsFloat;
              AmortizaK     := FieldByName('AMORTIZAK').AsInteger;
              AmortizaI     := FieldByName('AMORTIZAI').AsInteger;
              DiasProrroga  := FieldByName('DIASPRORROGA').AsInteger;
              FechaPagoK    := FieldByName('FECHAPAGOK').AsDateTime;
              FechaPagoI    := FieldByName('FECHAPAGOI').AsDateTime;
              Estado        := FieldByName('ESTADO').AsInteger;
              CuotasPendientes := FieldByName('CUOTASALIQUIDAR').AsInteger;
              if CuotasPendientes = 0 then CuotasPendientes := 1;
              for  I := 1 to CuotasPendientes do
               begin
                 //Conteo := Conteo + 1;
                 Application.ProcessMessages;
                 if FieldByName('TIPOCUOTA').AsInteger = 1 then
                   LiquidarCuotasFija(IdAgencia,Colocacion,1,FechaHoy,
                    CuotasLiq,Clasificacion,Garantia,Categoria,Estado,ValorCuota,
                    FechaPagoK,FechaPagoI,TipoInteres,ValorTasa,ValorMora,PuntosAdic,SaldoActual,AmortizaK,AmortizaI,DiasProrroga)
                 else if FieldByName('TIPOCUOTA').AsInteger = 2 then
                    LiquidarCuotasVarAnticipada(IdAgencia,Colocacion,1,FechaHoy,
                    CuotasLiq,Clasificacion,Garantia,Categoria,Estado,ValorCuota,
                    FechaPagoK,FechaPagoI,TipoInteres,ValorTasa,ValorMora,PuntosAdic,SaldoActual,AmortizaK,AmortizaI,DiasProrroga);
                  if FieldByName('TIPOCUOTA').AsInteger = 3 then
                    LiquidarCuotasVarVencida(IdAgencia,Colocacion,1,FechaHoy,
                    CuotasLiq,Clasificacion,Garantia,Categoria,Estado,ValorCuota,
                    FechaPagoK,FechaPagoI,TipoInteres,ValorTasa,ValorMora,PuntosAdic,SaldoActual,AmortizaK,AmortizaI,DiasProrroga);
                    J := CuotasLiq.Lista.Count - 1;
                   AF := CuotasLiq.Lista.Items[J];
                   vTotalLiquidacion := AF^.Debito;
                   AF^.CodigoPuc := CodigoAhorros;
                   //Cuota := AF^.CuotaNumero;
                   total := total + vTotalLiquidacion;
               end; // fin for cuotas pendientes
              DataQuerys.IBselecion.Next;
            end; // fin while not ibquery1.eof
            if total > (descuento(DataQuerys.IBselecion,nit,2)+ horaextra(DataQuerys.IBselecion,nit)) - (deduccion(DataQuerys.IBaportes,100,nit)+deduccion(DataQuerys.IBaportes,200,nit)+fsp(DataQuerys.IBselecion,nit)+cobro(DataQuerys.IBselecion,nit)) then
            begin
              with DataQuerys.IBaportes do
              begin
                Close;
                verificatransaccion(DataQuerys.IBaportes);
                SQL.Clear;
                SQL.Add('delete from "col$barridoCartera"');
                SQL.Add('where "col$barridoCartera"."IDPERSONA" = :nit');
                ParamByName('nit').AsInteger := nit;
                Open;
                Close;
                Transaction.Commit;
              end;
              Result := 0;
              end
            else
               Result := total;
          end; // fin with ibquery1 Select tabla barrido

end;

procedure TFrmCartera.contable(comprobante: string;tipo_nomina:integer);
var CuotasLiq:TCuotasLiq;
    AF:PCuotasLiq;
    I,J,K,L:Integer;
    Clasificacion:Integer;
    Categoria:string;
    Garantia:Integer;
    SaldoActual:Currency;
    TipoCapital:string;
    TipoInteres:Integer;
    TipoCuota:Integer;
    FechaPagoK:TDate;
    FechaPagoI:TDate;
    Estado:Integer;
    ValorTasa:Double;
    ValorMora:Double;
    ValorCuota:Currency;
    PuntosAdic:Double;
    AmortizaK:Integer;
    AmortizaI:Integer;
    DiasProrroga:Integer;
    IdAgencia : Integer;
    Colocacion : string;
    CuotasPendientes : Integer;
    ConsecBarrido : string;
    vNoComprobanteBarrido : string;
    TotalDebitoRecibo : Currency;
    TotalCreditoRecibo : Currency;
    TotalDebito: Currency;
    TotalCredito : Currency;
    DescImpuesto : Currency;
    Conteo:Integer;
    Save_Cursor:TCursor;
    Total:Integer;
    ConteoConsec : Integer;
    Cuota : Integer;
begin
{          if dmGeneral.IBTransaction1.InTransaction then
             dmGeneral.IBTransaction1.Commit;
          dmGeneral.IBTransaction1.StartTransaction;}
        IdAgencia := 1;
        AGENCIA := IdAgencia;
        Vnocomprobante := comprobante;
        fechahoy := FrMain.fechacartera;
        Application.ProcessMessages;
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"nom$pucbasico"."codigo"');
          SQL.Add('FROM');
          SQL.Add('"nom$pucbasico"');
          SQL.Add('WHERE');
          SQL.Add('("nom$pucbasico"."id" = 54)');
          Open;
          CodigoAhorros := FieldByName('codigo').AsString;
          Close;
         end;
        ConteoConsec := ObtenerConsecutivoBarrido(IBCuotas); //obtener consecutivo barrido
        ConsecBarridoInicial := FormatCurr('00000000',ConteoConsec + 1); //consecutivo inicial del barrido empleados
          with DataQuerys.IBdatos do
          begin
           SQL.Clear;
           SQL.Add('Select * ');
           SQL.Add('from "col$barridoCartera"');
           SQL.Add('where "col$barridoCartera".TIPO_NOMINA = :tipo');
           SQL.Add('order by AGENCIA,COLOCACION');
           ParamByName('tipo').AsInteger := tipo_nomina;
           Open;
           if RecordCount <> 0 then begin
           while not Eof do
            begin
              Application.ProcessMessages;
              //vTotalAhorros := BuscoSaldoAhorros(FieldByName('IDIDENTIFICACION').AsInteger,FieldByName('IDPERSONA').AsString);
              IdAgencia := FieldByName('AGENCIA').AsInteger;
              Colocacion := FieldByName('COLOCACION').AsString;
              Clasificacion := FieldByName('CLASIFICACION').AsInteger;
              Categoria     := FieldByName('CATEGORIA').AsString;
              Garantia      := FieldByName('GARANTIA').AsInteger;
              SaldoActual   := FieldByName('SALDOACTUAL').AsCurrency;
              TipoInteres   := FieldByName('IDINTERES').AsInteger;
              TipoCuota     := FieldByName('TIPOCUOTA').AsInteger;
              ValorCuota    := FieldByName('VALORCUOTA').AsCurrency;
              if FieldByName('TIPOINTERES').AsString = 'F' then
               ValorTasa := FieldByName('VALORTASA').AsFloat
              else
               ValorTasa := FieldByName('VALORACTUALTASA').AsFloat;
              PuntosAdic := FieldByName('PUNTOSADIC').AsFloat;
              ValorMora     := (ValorTasa + PuntosAdic) + FieldByName('VALORMORA').AsFloat;
              AmortizaK     := FieldByName('AMORTIZAK').AsInteger;
              AmortizaI     := FieldByName('AMORTIZAI').AsInteger;
              DiasProrroga  := FieldByName('DIASPRORROGA').AsInteger;
              FechaPagoK    := FieldByName('FECHAPAGOK').AsDateTime;
              FechaPagoI    := FieldByName('FECHAPAGOI').AsDateTime;
              Estado        := FieldByName('ESTADO').AsInteger;
              CuotasPendientes := FieldByName('CUOTASALIQUIDAR').AsInteger;
              if CuotasPendientes = 0 then
                 CuotasPendientes := 1;
              for  I := 1 to CuotasPendientes do
               begin
                 Conteo := Conteo + 1;
                 Application.ProcessMessages;
                 if FieldByName('TIPOCUOTA').AsInteger = 1 then
                   LiquidarCuotasFija(IdAgencia,Colocacion,1,FechaHoy,
                    CuotasLiq,Clasificacion,Garantia,Categoria,Estado,ValorCuota,
                    FechaPagoK,FechaPagoI,TipoInteres,ValorTasa,ValorMora,PuntosAdic,SaldoActual,AmortizaK,AmortizaI,DiasProrroga)
                 else if FieldByName('TIPOCUOTA').AsInteger = 2 then
                    LiquidarCuotasVarAnticipada(IdAgencia,Colocacion,1,FechaHoy,
                    CuotasLiq,Clasificacion,Garantia,Categoria,Estado,ValorCuota,
                    FechaPagoK,FechaPagoI,TipoInteres,ValorTasa,ValorMora,PuntosAdic,SaldoActual,AmortizaK,AmortizaI,DiasProrroga)
                 else if FieldByName('TIPOCUOTA').AsInteger = 3 then
                    LiquidarCuotasVarVencida(IdAgencia,Colocacion,1,FechaHoy,
                    CuotasLiq,Clasificacion,Garantia,Categoria,Estado,ValorCuota,
                    FechaPagoK,FechaPagoI,TipoInteres,ValorTasa,ValorMora,PuntosAdic,SaldoActual,AmortizaK,AmortizaI,DiasProrroga);
                 J := CuotasLiq.Lista.Count - 1;
                 AF := CuotasLiq.Lista.Items[J];
                 vTotalLiquidacion := AF^.Debito;
                  AF^.CodigoPuc := CodigoAhorros;
                 Cuota := AF^.CuotaNumero;
//* inicio 4 x mil
                 DescImpuesto := SimpleRoundTo((vTotalLiquidacion/1000) * 4,0);
                 New(AF);
                 AF^.CuotaNumero := cuota;
                 AF^.CodigoPuc   := '531520000000000000';
                 AF^.FechaInicial := Date;
                 AF^.FechaFinal   := Date;
                 AF^.Dias         := 0;
                 AF^.Tasa         := 0;
                 AF^.Debito       := DescImpuesto;
                 AF^.Credito      := 0;
                 AF^.EsCapital := False;
                 AF^.EsCausado := False;
                 AF^.EsCorriente := False;
                 AF^.EsVencido := False;
                 AF^.EsAnticipado := False;
                 AF^.EsDevuelto := False;
                 if (AF^.Debito <> 0) or
                    (AF^.Credito <> 0) then
                    CuotasLiq.Lista.Add(AF);

                 New(AF);
                 AF^.CuotaNumero := cuota;
                 AF^.CodigoPuc   := '244205000000000000';
                 AF^.FechaInicial := Date;
                 AF^.FechaFinal   := Date;
                 AF^.Dias         := 0;
                 AF^.Tasa         := 0;
                 AF^.Debito       := 0;
                 AF^.Credito      := DescImpuesto;
                 AF^.EsCapital := False;
                 AF^.EsCausado := False;
                 AF^.EsCorriente := False;
                 AF^.EsVencido := False;
                 AF^.EsAnticipado := False;
                 AF^.EsDevuelto := False;
                 if (AF^.Debito <> 0) or
                    (AF^.Credito <> 0) then
                    CuotasLiq.Lista.Add(AF);
//* fin 4 x mil
                 if 1 = 1 then // descuento del sueldo
                  begin
                    abono_capital := 0;
                    abono_cxc := 0;
                    abono_servicios := 0;
                    abono_mora := 0;
                    abono_anticipado := 0;
                    //Genero el consecutivo
                    ConteoConsec := ConteoConsec + 1;
                    ConsecBarrido := FormatCurr('00000000',ConteoConsec);
                    for K := 0 to CuotasLiq.Lista.Count - 1 do
                     begin
                       AF := CuotasLiq.Lista.Items[K];
                       if AF^.EsCapital then
                          abono_capital := abono_capital + AF^.Credito;
                       if AF^.EsCausado then
                          abono_cxc := abono_cxc + AF^.Credito;
                       if AF^.EsCorriente then
                          abono_servicios := abono_servicios + AF^.Credito;
                       if AF^.EsVencido then
                          abono_mora := abono_mora + AF^.Credito;
                       if AF^.EsAnticipado then
                          abono_anticipado := abono_anticipado + AF^.Credito;
                     end; //for K
                    TotalDebitoRecibo := 0;
                    TotalCreditoRecibo := 0;
                    for L := 0 to CuotasLiq.Lista.Count - 1 do
                     begin
                       Application.ProcessMessages;
                       AF := CuotasLiq.Lista.Items[L];
                       TotalDebitoRecibo := TotalDebitoRecibo + AF^.Debito;
                       TotalCreditoRecibo := TotalCreditoRecibo + AF^.Credito;
                     end; // for L
                    //**grabarextracto
                  //end;// fin opcional para cuotas pendientes
                    with IBExtracto do
                     begin
                       Close;
                       verificatransaccion(IBextracto);
                       sql.Clear;
                       sql.Add('insert into "col$extracto" (');
                       sql.Add('"col$extracto"."ID_AGENCIA", "col$extracto"."ID_CBTE_COLOCACION",');
                       sql.Add('"col$extracto"."ID_COLOCACION", "col$extracto"."FECHA_EXTRACTO",');
                       sql.Add('"col$extracto"."HORA_EXTRACTO", "col$extracto"."CUOTA_EXTRACTO",');
                       sql.Add('"col$extracto"."TIPO_OPERACION", "col$extracto"."SALDO_ANTERIOR_EXTRACTO",');
                       sql.Add('"col$extracto"."ABONO_CAPITAL", "col$extracto"."ABONO_CXC",');
                       sql.Add('"col$extracto"."ABONO_SERVICIOS", "col$extracto"."ABONO_ANTICIPADO",');
                       sql.Add('"col$extracto"."ABONO_MORA", "col$extracto"."ABONO_SEGURO",');
                       sql.Add('"col$extracto"."ABONO_PAGXCLI", "col$extracto"."ABONO_HONORARIOS",');
                       sql.Add('"col$extracto"."ABONO_OTROS", "col$extracto"."TASA_INTERES_LIQUIDACION",');
                       sql.Add('"col$extracto"."ID_EMPLEADO",');
                       sql.Add('"col$extracto"."INTERES_PAGO_HASTA",');
                       sql.Add('"col$extracto"."CAPITAL_PAGO_HASTA",');
                       sql.Add('"col$extracto"."TIPO_ABONO")');
                       sql.Add(' Values (');
                       sql.Add(':"ID_AGENCIA", :"ID_CBTE_COLOCACION", :"ID_COLOCACION",');
                       sql.Add(':"FECHA_EXTRACTO", :"HORA_EXTRACTO", :"CUOTA_EXTRACTO",');
                       sql.Add(':"TIPO_OPERACION", :"SALDO_ANTERIOR_EXTRACTO", :"ABONO_CAPITAL",');
                       sql.Add(':"ABONO_CXC", :"ABONO_SERVICIOS", :"ABONO_ANTICIPADO", :"ABONO_MORA",');
                       sql.Add(':"ABONO_SEGURO", :"ABONO_PAGXCLI", :"ABONO_HONORARIOS",');
                       sql.Add(':"ABONO_OTROS", :"TASA_INTERES_LIQUIDACION", :"ID_EMPLEADO",');
                       sql.Add(':"INTERES_PAGO_HASTA", :"CAPITAL_PAGO_HASTA", :"TIPO_ABONO")');
                       ParamByName('ID_AGENCIA').AsInteger := agencia;
                       ParamByName('ID_CBTE_COLOCACION').AsInteger := strtoint(ConsecBarrido);
                       ParamByName('ID_COLOCACION').AsString := Colocacion;
                       ParamByName('FECHA_EXTRACTO').AsDate := FrMain.fechacartera;
                       ParamByName('HORA_EXTRACTO').AsDateTime := Time;
                       ParamByName('CUOTA_EXTRACTO').AsInteger := Cuota;
                       ParamByName('TIPO_OPERACION').AsInteger := 1;
                       ParamByName('SALDO_ANTERIOR_EXTRACTO').AsCurrency := SaldoActual;
                       ParamByName('ABONO_CAPITAL').AsCurrency := abono_capital;
                       ParamByName('ABONO_CXC').AsCurrency := abono_cxc;
                       ParamByName('ABONO_SERVICIOS').AsCurrency := abono_servicios;
                       ParamByName('ABONO_ANTICIPADO').AsCurrency := abono_anticipado;
                       ParamByName('ABONO_MORA').AsCurrency := abono_mora;
                       ParamByName('ABONO_SEGURO').AsCurrency := 0;
                       ParamByName('ABONO_PAGXCLI').AsCurrency := 0;
                       ParamByName('ABONO_HONORARIOS').AsCurrency := 0;
                       ParamByName('ABONO_OTROS').AsCurrency := 0;
                       ParamByName('TASA_INTERES_LIQUIDACION').AsFloat := vTasa;
                       ParamByName('ID_EMPLEADO').AsString := UpperCase(frmain.Dbalias);
                       ParamByName('INTERES_PAGO_HASTA').AsDate := CuotasLiq.InteresesHasta;
                       ParamByName('CAPITAL_PAGO_HASTA').AsDate := CuotasLiq.CapitalHasta;
                       ParamByName('TIPO_ABONO').AsBoolean := False;
                       open;
                       //fin  grabarextracto
                       //grabartablaliquidacion
                       sql.Clear;
                       sql.Add('update "col$tablaliquidacion" set');
                       sql.Add('"col$tablaliquidacion"."PAGADA" =:"PAGADA",');
                       sql.Add('"col$tablaliquidacion"."FECHA_PAGADA" =:"FECHA_PAGADA"');
                       sql.Add(' where ');
                       sql.Add('"col$tablaliquidacion"."ID_AGENCIA" =:"ID_AGENCIA" and');
                       sql.Add('"col$tablaliquidacion"."ID_COLOCACION" =:"ID_COLOCACION" and');
                       sql.Add('"col$tablaliquidacion"."CUOTA_NUMERO" =:"CUOTA_NUMERO"');
                       ParamByName('ID_AGENCIA').AsInteger := agencia;
                       ParamByName('ID_COLOCACION').AsString := Colocacion;
                       ParamByName('CUOTA_NUMERO').AsInteger := Cuota;
                       ParamByName('PAGADA').AsInteger := 1;
                       ParamByName('FECHA_PAGADA').AsDate := FrMain.fechacartera;
                       open;
                       Close;
                       Transaction.Commit;
                     end;
                       //fin grabar tablaliquidacion
                       if  CuotasLiq.Lista.Count > 0 then
                       for L := 0 to CuotasLiq.Lista.Count - 1 do
                        begin
                          Application.ProcessMessages;
                          AF := CuotasLiq.Lista.Items[L];
                       with IBcolextractode do
                         begin
                         Close;
                         verificatransaccion(IBcolextractode);
                         SQL.Clear;
                         SQL.Add('insert into "col$extractodet" values (');
                         SQL.Add(':"ID_AGENCIA",:"ID_CBTE_COLOCACION",:"ID_COLOCACION",:"FECHA_EXTRACTO",:"HORA_EXTRACTO",');
                         SQL.Add(':"CODIGO_PUC",:"FECHA_INICIAL",:"FECHA_FINAL",:"DIAS_APLICADOS",');
                         SQL.Add(':"TASA_LIQUIDACION",:"VALOR_DEBITO",:"VALOR_CREDITO")');
                         ParamByName('ID_AGENCIA').AsInteger := agencia;
                         ParamByName('ID_CBTE_COLOCACION').AsInteger:= strtoint(ConsecBarrido);
                         ParamByName('ID_COLOCACION').AsString := colocacion;
                         ParamByName('FECHA_EXTRACTO').AsDate := FrMain.fechacartera;
                         ParamByName('HORA_EXTRACTO').AsDateTime := Time;
                         ParamByName('CODIGO_PUC').AsString := AF^.CodigoPuc;
                         ParamByName('FECHA_INICIAL').AsDate := AF^.FechaInicial;
                         ParamByName('FECHA_FINAL').AsDate := AF^.FechaFinal;
                         ParamByName('DIAS_APLICADOS').AsInteger := AF^.Dias;
                         ParamByName('TASA_LIQUIDACION').AsFloat := AF^.Tasa;
                         ParamByName('VALOR_DEBITO').AsCurrency := AF^.Debito;
                         ParamByName('VALOR_CREDITO').AsCurrency := AF^.Credito;
                         open;
                         Close;
                         Transaction.CommitRetaining;
                         end;
                       end; //fin for l
                       IBcolextractode.Transaction.Commit; //fin for
                       with IBcolextractode do
                       begin
                       Close;
                       verificatransaccion(IBcolextractode);
                       sql.Clear;
                       SQL.Add('update "col$colocacion" set ');
                       sql.Add('"col$colocacion"."ABONOS_CAPITAL" = "col$colocacion"."ABONOS_CAPITAL" + :"ABONOS_CAPITAL",');
                       sql.Add('"col$colocacion"."FECHA_CAPITAL" =:"FECHA_CAPITAL",');
                       sql.Add('"col$colocacion"."FECHA_INTERES" =:"FECHA_INTERES"');
                       sql.Add(' where ');
                       sql.Add('"col$colocacion"."ID_AGENCIA" =:"ID_AGENCIA" and');
                       sql.Add('"col$colocacion"."ID_COLOCACION" =:"ID_COLOCACION"');
                       ParamByName('ID_AGENCIA').AsInteger := agencia;
                       ParamByName('ID_COLOCACION').AsString := colocacion;
                       ParamByName('ABONOS_CAPITAL').AsCurrency := abono_capital;
                       ParamByName('FECHA_CAPITAL').AsDate := CuotasLiq.CapitalHasta;
                       ParamByName('FECHA_INTERES').AsDate := CuotasLiq.InteresesHasta;
                       open;
                       Close;
                       Transaction.Commit;
                       end;
                     end; // fin for cuotas pendientes
            end; // fin while not ibquery1.eof
                    DataQuerys.IBdatos.Next;
                    with IBBarrido do
                     begin
                       Close;
                       verificatransaccion(IBbarrido);
                       SQL.Clear;
                       SQL.Add('delete from "col$barridoCartera"');
                       SQL.Add('where AGENCIA =:"AGENCIA" and COLOCACION =:"COLOCACION"');
                       ParamByName('AGENCIA').AsInteger := IdAgencia;
                       ParamByName('COLOCACION').AsString := Colocacion;
                       open;
                       Close;
                       Transaction.Commit;
                     end;
           end;
            ConsecBarridoFinal := FormatCurr('00000000',ConteoConsec);// numero final del consecutivo

            with IBconbarrido do
            begin
               Close;
               verificatransaccion(IBconbarrido);
               SQL.Clear;
               SQL.Add('update "gen$consecutivos" set "gen$consecutivos"."CONSECUTIVO" = :"CONSECUTIVO" ');
               SQL.Add(' where "gen$consecutivos"."ID_CONSECUTIVO" = 2');
               ParamByName('CONSECUTIVO').AsInteger := ConteoConsec;
               open;
               Transaction.Commit;
               Close;
             end;
       //**Busco Valores y Genero el comprobante
        Vnocomprobante := comprobante;
        cuenta(1);
        cuenta(2);
        verificarcancelacioncredito(IdAgencia,Colocacion);

        with DataQuerys.IBingresa do
        begin
        Close;
        verificatransaccion(DataQuerys.IBingresa);
        SQL.Clear;
        SQL.Add('insert into "nom$cartera"');
        SQL.Add('Values (');
        SQL.Add(':comprobante,:inicio,');
        SQL.Add(':fin,:fecha )');
        ParamByName('comprobante').AsString := VNocomprobante;
        ParamByName('inicio').AsInteger := StrToInt(ConsecBarridoInicial);
        ParamByName('fin').AsInteger := StrToInt(ConsecBarridoFinal);
        ParamByName('fecha').AsDate := FrMain.fechacartera;
        Open;
        Close;
        Transaction.Commit;
       end;
end;
end;
end;

procedure TFrmCartera.cuenta(opcion: integer);
var       codigoas: string;
          debitoa,creditoa :Currency;
begin
            with IBQuery1 do
            begin
             SQL.Clear;
             verificatransaccion(IBQuery1);
             SQL.Add('select ');
             SQL.Add('CODIGO_PUC, SUM(VALOR_DEBITO) AS DEBITO, SUM(VALOR_CREDITO) AS CREDITO');
             SQL.Add('from "col$extractodet"');
             SQL.Add('where');
             SQL.Add('("col$extractodet".ID_CBTE_COLOCACION >= :"ID1") and');
             SQL.Add('("col$extractodet".ID_CBTE_COLOCACION <= :"ID2") and');
             if opcion = 1 then
                SQL.Add('("col$extractodet".VALOR_CREDITO = 0) and')
             else
                 SQL.Add('("col$extractodet".VALOR_CREDITO > 0) and');
             SQL.Add('("col$extractodet".FECHA_EXTRACTO = :"FECHA")');
             SQL.Add('group by CODIGO_PUC');
             ParamByName('ID1').AsInteger := StrToInt(ConsecBarridoInicial);
             ParamByName('ID2').AsInteger := StrToInt(ConsecBarridoFinal);
             ParamByName('FECHA').AsDate := FrMain.fechacartera;
             Open;
            while not IBQuery1.Eof do
             begin
             codigoas := IBQuery1.FieldByName('CODIGO_PUC').AsString;
             debitoa := IBQuery1.FieldByName('DEBITO').AsCurrency;
             creditoa := IBQuery1.FieldByName('CREDITO').AsCurrency;
             if CODIGOAS  <> Codigoahorros THEN
             begin
               with IBcomprobante do
               begin
                 Close;
                 verificatransaccion(IBcomprobante);
                 SQL.Clear;
                 SQL.Add('insert into "con$auxiliar" values (');
                 SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
                 SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
                 SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
                 ParamByName('ID_COMPROBANTE').AsString := vNoComprobante;
                 ParamByName('ID_AGENCIA').AsInteger:= Agencia;
                 ParamByName('FECHA').AsDate := FrMain.fechacartera;
                 ParamByName('CODIGO').AsString := codigoas;
                 ParamByName('DEBITO').AsCurrency := debitoa;
                 ParamByName('CREDITO').AsCurrency := creditoa;
                 ParamByName('ID_CUENTA').AsString := '';
                 ParamByName('ID_COLOCACION').AsString := '';
                 ParamByName('ID_IDENTIFICACION').AsInteger := 0;
                 ParamByName('ID_PERSONA').AsString := '';
                 ParamByName('MONTO_RETENCION').AsCurrency := 0;
                 ParamByName('TASA_RETENCION').AsFloat := 0;
                 ParamByName('ESTADOAUX').AsString := 'O';
                 open;
                 Close;
                 Transaction.Commit;
              end;  // fin actualiza comprobante
             end;// fin if
            IBQuery1.Next;
          end;// fin while
       end;

end;

procedure TFrmCartera.buscarnumero;
begin
{        with FrmQuerys.IBregistro do
        begin
         Close;
         SQL.Clear;
         Sql.Add('select * from P_CAP_0008 (:ID_AGENCIA,:ID_TIPO_CAPTACION,:ID_IDENTIFICACION,:ID_PERSONA)');
         ParamByName('ID_AGENCIA').AsInteger;
         ParamByName('ID_TIPO_CAPTACION').AsInteger := 1;
         ParamByName('ID_IDENTIFICACION').AsInteger := vTipoId;
         ParamByName('ID_PERSONA').AsString := vNumeroId;
         Open;;
         NumeroCuenta := FieldByName('NUMERO_CUENTA').AsInteger;
         DigitoCuenta := StrToInt(DigitoControl(2,FormatCurr('0000000',FieldByName('NUMERO_CUENTA').AsInteger)));
         Close;
        end;}
end;

procedure TFrmCartera.actualizav;
var cod_vacaciones :Integer;
begin
        cod_vacaciones := 1;
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "nom$empleado"."nitempleado"');
          SQL.Add(',"nom$empleado"."fecha_registro"');
          SQL.Add('from "nom$empleado"');
          Open;
          while not Eof do
          begin
          with DataQuerys.IBselecion do
          begin
            Close;
            SQL.Clear;
            SQL.Add('insert into "nom$vacaciones"');
            SQL.Add('values (');
            SQL.Add(':codigo,:nitempleado,:fechasalida,');
            SQL.Add(':fechareintegro,:observaciones,:devengado,');
            SQL.Add(':numero_dias,:salida,:comprobante,:entrada,:fecha_vacaciones)');
            ParamByName('codigo').AsInteger := cod_vacaciones;
            ParamByName('nitempleado').AsInteger := DataQuerys.IBdatos.FieldByName('nitempleado').AsInteger;
            ParamByName('fechasalida').AsDateTime := Date;
            ParamByName('fechareintegro').AsDateTime := Date;
            ParamByName('observaciones').AsString := '';
            ParamByName('devengado').AsCurrency := 0;
            ParamByName('numero_dias').AsString := '0';
            ParamByName('salida').AsString := '07:40';
            ParamByName('comprobante').AsInteger := 0;
            ParamByName('fecha_vacaciones').AsDate := DataQuerys.IBdatos.FieldByName('fecha_registro').AsDateTime;
            ParamByName('entrada').AsString := '07:40';
            Open;
            Close;
            Transaction.Commit;
          end;
          cod_vacaciones := cod_vacaciones +1;
          Next;
        end;
end;
end;

procedure TFrmCartera.BitBtn1Click(Sender: TObject);
var tipo_nomina,nite :Integer;
     valor :Currency;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$empleado"."nitempleado",');
          SQL.Add('"nom$empleado"."numero_cuenta",');
          SQL.Add('"nom$empleado"."tipo_nomina"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          Open;
          while not Eof do
          begin
            tipo_nomina := FieldByName('tipo_nomina').AsInteger;
            nite := FieldByName('nitempleado').AsInteger;
            valor := SimpleRoundTo(deduccion(DataQuerys.IBselecion,200,nite),0);
            obligacion(11,nite,(valor*3));
            Next;
          end; // fin while busca empleado
          Close;
        end; // fin with s¡busca empleado;

end;

procedure TFrmCartera.BitBtn2Click(Sender: TObject);
var
           nite,tipo_nomina : Integer;
           valor_retefuente,valor_hora,valor_sueldo :Currency;
           valor_fsp,valor_pension :Currency;
begin
        tipo_nomina := 10;
        while tipo_nomina <= 40 do
        begin
        with IBbusbaempleado do
        begin
          Close;
          verificatransaccion(IBbusbaempleado);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$empleado"."nitempleado",');
          SQL.Add('"nom$empleado"."numero_cuenta"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."tipo_nomina" = :tipo_nomina)');
          ParamByName('tipo_nomina').AsInteger := tipo_nomina;
          Open;
          while not Eof do
          begin
            nite := FieldByName('nitempleado').AsInteger;
            valor_retefuente := retefuente(DataQuerys.IBselecion,nite,1,1);
            valor_sueldo := nomina(DataQuerys.IBselecion,2,tipo_nomina,nite);
            valor_fsp := SimpleRoundTo(fsp(DataQuerys.IBselecion,nite),0);
            valor_pension := SimpleRoundTo(deduccion(DataQuerys.IBselecion,200,nite),0);
            obligacion(11,nite,(valor_pension * 3 + selobligacion(11,nite)));
            obligacion(12,nite,(valor_fsp * 3 + selobligacion(12,nite)));
            obligacion(13,nite,(valor_retefuente * 3 + selobligacion(13,nite)));
          Next;
          end;
        end;
        tipo_nomina := tipo_nomina+10;
       end;
end;

function TFrmCartera.saldocreditoAg(nit: integer): Currency;
begin
         with DataQuerys.IBselecion do
         begin
           Close;
           verificatransaccion(DataQuerys.IBselecion);
           SQL.Clear;
           SQL.Add('SELECT');
           SQL.Add('sum("nom$libranza".VCUOTA) as CUOTA');
           SQL.Add('FROM');
           SQL.Add('"nom$libranza"');
           SQL.Add('INNER JOIN "Inv$Agencia" ON ("nom$libranza".IDAGENCIA = "Inv$Agencia"."cod_agencia")');
           SQL.Add('WHERE');
           SQL.Add('"nom$libranza".NIT = :NIT AND');
           SQL.Add('"nom$libranza".FECHAV >= :FECHA');
           ParamByName('FECHA').AsDateTime := fFechaActual;
           ParamByName('NIT').AsInteger := nit;
           Open;
           Result := FieldByName('CUOTA').AsCurrency;
         end;
end;

end.





