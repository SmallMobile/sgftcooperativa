unit UnitRepCartera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, DB, IBCustomDataSet,
  IBQuery, pr_Common, pr_TxClasses, JvEdit, JvTypedEdit, ComCtrls,
  JvProgressBar, JvDbPrgrss, JvComponent, JvProgressDlg, JvDBProgressBar;

type
  TFrmRepCartera = class(TForm)
    l: TPanel;
    Label1: TLabel;
    nomina: TDBLookupComboBox;
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    Bcerrar: TBitBtn;
    IBtiponomina: TIBQuery;
    DBtiponomina: TDataSource;
    report: TprTxReport;
    IBGrupo1: TIBQuery;
    IBAuxiliar: TIBQuery;
    DataSource1: TDataSource;
    IBQuery1: TIBQuery;
    JV: TJvDBProgressBar;
    DataSource2: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
  consec :Integer;
  baja : Integer;
  valor :Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRepCartera: TFrmRepCartera;
implementation
uses unitdatamodulo, UnitQuerys,UnitGlobal,UnitData, UnitPrincipal,UnitGlobales,UnitVistaPreliminar,
  Unitprogreso, UnitdataQuerys, UnitDbProgres, UnitPantallaProgreso, UnitDb;

{$R *.dfm}

procedure TFrmRepCartera.FormCreate(Sender: TObject);
begin
        IBtiponomina.Open;
        IBtiponomina.Last;
        //baja := 0;
        valor := 0;
end;

procedure TFrmRepCartera.BcerrarClick(Sender: TObject);
var a:Currency;
begin
        Close
end;

procedure TFrmRepCartera.BACEPTARClick(Sender: TObject);
var inicio,fin :Integer;
    fecha1 :TDate;
begin
        FrmQuerys := TFrmQuerys.Create(self);
        try
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('select "nom$controlreporte"."comprobante"');
          SQL.Add('from "nom$controlreporte"');
          SQL.Add('where "nom$controlreporte"."agencia" = :agencia');
          SQL.Add('and "nom$controlreporte"."codigo_nomina" = :nomina');
          ParamByName('agencia').AsInteger := nomina.KeyValue;
          ParamByName('nomina').AsInteger := buscanomina(DataQuerys.IBdatos)- 1;
          Open;
          consec := FieldByName('comprobante').AsInteger;
          if RecordCount = 0 then
          begin
             MessageDlg('No se ha Registrado contablemente la Nomina',mtInformation,[mbok],0);
             Exit;
          end;
          Close;
        end;
        except
        on E: Exception do
        begin
          MessageDlg('Error Generando Comprobante',mtError,[mbok],0);
          nomina.SetFocus;
          Exit;
        end;
      end;
      with DataQuerys.IBdatos do
      begin
        Close;
        verificatransaccion(DataQuerys.IBdatos);
        SQL.Clear;
        SQL.Add('SELECT');
        SQL.Add('"nom$cartera"."inicio",');
        SQL.Add('"nom$cartera"."fin"');
        SQL.Add(',"nom$cartera"."fecha"');
        SQL.Add('FROM');
        SQL.Add('"nom$cartera"');
        SQL.Add('WHERE');
        SQL.Add('("nom$cartera"."comprobante" = :consecutivo)');
        ParamByName('consecutivo').AsInteger := consec;
        Open;
        inicio := FieldByName('inicio').AsInteger;
        fin := FieldByName('fin').AsInteger;
        fecha1 := FieldByName('fecha').AsDateTime;
        Close;
      end;
         with IBGrupo1 do
          begin
           SQL.Clear;
           SQL.Add('select ');
           SQL.Add('"col$extracto".ID_COLOCACION,');
           SQL.Add('"col$extracto".ID_CBTE_COLOCACION,');
           SQL.Add('"col$extracto".FECHA_EXTRACTO,');
           SQL.Add('"col$extracto".CAPITAL_PAGO_HASTA,');
           SQL.Add('"col$extracto".INTERES_PAGO_HASTA,');
           SQL.Add('"col$extracto".SALDO_ANTERIOR_EXTRACTO,');
           SQL.Add('"col$extracto".ID_EMPLEADO,');
           SQL.Add('"col$extracto".CUOTA_EXTRACTO,');
           SQL.Add('"col$colocacion".ID_IDENTIFICACION,');
           SQL.Add('"col$colocacion".NUMERO_CUENTA,');
           SQL.Add('"col$colocacion".ID_PERSONA,');
           SQL.Add('"col$colocacion".VALOR_DESEMBOLSO,');
           SQL.Add('("col$colocacion".VALOR_DESEMBOLSO - "col$colocacion".ABONOS_CAPITAL) as SALDO,');
           SQL.Add('"gen$persona".PRIMER_APELLIDO, "gen$persona".SEGUNDO_APELLIDO, "gen$persona".NOMBRE,');
           SQL.Add('"col$extractodet".CODIGO_PUC,');
           SQL.Add('"col$extractodet".FECHA_INICIAL,');
           SQL.Add('"col$extractodet".FECHA_FINAL,');
           SQL.Add('"col$extractodet".DIAS_APLICADOS,');
           SQL.Add('"col$extractodet".TASA_LIQUIDACION,');
           SQL.Add('"col$extractodet".VALOR_DEBITO,');
           SQL.Add('"col$extractodet".VALOR_CREDITO,');
           SQL.Add('"con$puc".NOMBRE as CUENTA');
           //SQL.Add('"gen$empleado".PRIMER_APELLIDO as APE1EMPLEADO,');
           //SQL.Add('"gen$empleado".SEGUNDO_APELLIDO as APE2EMPLEADO,');
           //SQL.Add('"gen$empleado".NOMBRE as NOMEMPLEADO');
           SQL.Add('from "col$extractodet" ');
           SQL.Add('left join "col$colocacion" on ("col$extractodet".ID_COLOCACION = "col$colocacion".ID_COLOCACION)');
           SQL.Add('LEFT JOIN "gen$persona" on ("gen$persona".ID_IDENTIFICACION = "col$colocacion".ID_IDENTIFICACION and ');
           SQL.Add('"gen$persona".ID_PERSONA = "col$colocacion".ID_PERSONA)');
           SQL.Add('LEFT JOIN "con$puc" ON ("col$extractodet".CODIGO_PUC = "con$puc".CODIGO and ');
           SQL.Add('"col$extractodet".ID_AGENCIA = "con$puc".ID_AGENCIA )');
           SQL.Add('inner join "col$extracto" on ("col$extractodet".ID_CBTE_COLOCACION = "col$extracto".ID_CBTE_COLOCACION and "col$extractodet".FECHA_EXTRACTO = "col$extracto".FECHA_EXTRACTO)');
           //SQL.Add('inner join "gen$empleado" on ("col$extracto".ID_EMPLEADO = "gen$empleado".ID_EMPLEADO)');
           SQL.Add('where');
           SQL.Add('("col$extractodet".ID_CBTE_COLOCACION >= :"ID1" and "col$extractodet".ID_CBTE_COLOCACION <= :"ID2") and');
           SQL.Add('"col$extracto".FECHA_EXTRACTO = :"FECHA_EXTRACTO"');
           sql.Add('order by "col$extractodet".ID_CBTE_COLOCACION,  "col$extractodet".VALOR_CREDITO');
           ParamByName('ID1').AsString := IntToStr(inicio);
           ParamByName('ID2').AsString := IntToStr(fin);
           ParamByName('FECHA_EXTRACTO').AsDate := fecha1;
           Application.ProcessMessages;
           Open;
           Last;
           First;
           Report.Variables.ByName['EMPRESA'].AsString := FrMain.Empresa;
           Report.Variables.ByName['EMPLEADO'].AsString := empleados(frmquerys.IBseleccion,upperCase(FrMain.Dbalias));
           Report.Variables.ByName['NIT'].AsString := FrMain.Nit;
          if Report.PrepareReport then
           begin
             frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
             frmVistaPreliminar.Reporte := Report;
             frmVistaPreliminar.ShowModal;
           end;
          end;

end;

procedure TFrmRepCartera.Timer1Timer(Sender: TObject);
begin
        if valor = 0 then
           baja := 1;
        if valor = 100 then
           baja := -1;
        valor := valor + baja;
        frmdb.Position := valor;
//        FrmDbProgres.Position := valor;
end;

end.
