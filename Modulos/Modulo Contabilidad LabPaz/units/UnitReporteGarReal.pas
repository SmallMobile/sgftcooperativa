unit UnitReporteGarReal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, DB, IBCustomDataSet,
  IBQuery, pr_Common, pr_TxClasses, DBClient, IBDatabase, Math, IBSQL,
  FR_Class, FR_DSet, FR_DBSet, frOLEExl,scExcelExport;

type
  TfrmReporteGarReal = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel4: TPanel;
    CmdAceptar: TBitBtn;
    CmdCerrar: TBitBtn;
    EdAgencia: TDBLookupComboBox;
    CmdNuevo: TBitBtn;
    DSAgencia: TDataSource;
    IBAgencia: TIBQuery;
    CBclasificacion: TDBLookupComboBox;
    Reporte: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    IBQuery1: TIBQuery;
    IBQuery: TIBQuery;
    DSClasificacion: TDataSource;
    IBClasificacion: TIBQuery;
    frOLEExcelExport1: TfrOLEExcelExport;
    procedure EdAgenciaKeyPress(Sender: TObject; var Key: Char);
    procedure CmdAceptarClick(Sender: TObject);
    procedure Empleado;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CmdNuevoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ReporteGetValue(const ParName: String;
      var ParValue: Variant);
  private
  scExcelExport1 :TscExcelExport;
    procedure Inicializar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReporteGarReal: TfrmReporteGarReal;
  Nombres : String;
  Apellidos : String;

implementation

{$R *.dfm}

uses UnitGlobales, UnitdmGeneral;

procedure TfrmReporteGarReal.EdAgenciaKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmReporteGarReal.CmdAceptarClick(Sender: TObject);
var
  Duration : TDateTime;
begin
    //IBQuery1.Open;

        CmdAceptar.Enabled := False;
  //try
{    scExcelExport1 := TscExcelExport.Create(self);
    scExcelExport1.WorksheetName := 'reporte de la tabla gen$minimos';
    scExcelExport1.Dataset:=IBQuery1;
    scExcelExport1.SummarySelection := ssValues;
    scExcelExport1.SummaryCalculation := scSUM;     }
    

        with IBQuery1  do begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"col$colocacion".ID_IDENTIFICACION,');
          SQL.Add('"col$colocacion".ID_PERSONA,');
          SQL.Add('"col$colocacion".ID_COLOCACION,');
          SQL.Add('"gen$persona".PRIMER_APELLIDO, "gen$persona".SEGUNDO_APELLIDO, "gen$persona".NOMBRE,');
          SQL.Add('"col$colocacion".VALOR_DESEMBOLSO - "col$colocacion".ABONOS_CAPITAL AS SALDO,');
          SQL.Add('"col$colgarantiasreal".CUENTAS_DE_ORDEN,');
          SQL.Add('"col$colgarantiasreal".NUMERO_ESCRITURA,');
          SQL.Add('"col$colgarantiasreal".FECHA_ESCRITURA,');
          SQL.Add('"col$colgarantiasreal".MATRICULA_INMOBILIARIA,');
          SQL.Add('"col$colgarantiasreal".POLIZA_INCENDIO,');
          SQL.Add('"col$colgarantiasreal".FECHA_FINAL_POLIZA,');
          SQL.Add('"col$colgarantiasreal".AVALUO,');
          SQL.Add('"col$colgarantiasreal".FECHA_AVALUO,');
          SQL.Add('"col$colocacion".ID_CLASIFICACION,');
          SQL.Add('"col$colocacion".ID_ESTADO_COLOCACION');
          SQL.Add('FROM');
          SQL.Add('"col$colocacion"');
          SQL.Add('INNER JOIN "gen$persona" ON ("col$colocacion".ID_IDENTIFICACION="gen$persona".ID_IDENTIFICACION)');
          SQL.Add('AND ("col$colocacion".ID_PERSONA="gen$persona".ID_PERSONA)');
          SQL.Add('INNER JOIN "col$colgarantiasreal" ON ("col$colocacion".ID_AGENCIA="col$colgarantiasreal".ID_AGENCIA)');
          SQL.Add('AND ("col$colocacion".ID_COLOCACION="col$colgarantiasreal".ID_COLOCACION)');
          SQL.Add('WHERE');
          SQL.Add('("col$colocacion".ID_ESTADO_COLOCACION <= 3) and');
          SQL.Add('"col$colocacion".ID_CLASIFICACION = :ID and "col$colgarantiasreal".CUENTAS_DE_ORDEN > 0');
          SQL.Add('order by "gen$persona".PRIMER_APELLIDO, "gen$persona".SEGUNDO_APELLIDO, "gen$persona".NOMBRE');
          ParamByName('ID').AsInteger := CBclasificacion.KeyValue;
          Open;
//    scExcelExport1.ExcelVisible:=True;
//    Duration := Now();
//    scExcelExport1.ExportDataset;

  //finally
    //scExcelExport1.Disconnect;
  //end;
          empleado;
          Reporte.ShowReport;
          Close;
       end;
end;

procedure TfrmReporteGarReal.Empleado;
begin
        with IBQuery do
         begin
           sql.Clear;
           sql.Add('select PRIMER_APELLIDO, SEGUNDO_APELLIDO, NOMBRE from "gen$empleado"');
           sql.Add('where "gen$empleado"."ID_EMPLEADO" =:"ID_EMPLEADO"');
           ParamByName('ID_EMPLEADO').AsString := DBAlias;
           Open;
           Nombres := FieldByName('NOMBRE').AsString;
           Apellidos := FieldByname('PRIMER_APELLIDO').AsString + '   ' + FieldByName('SEGUNDO_APELLIDO').AsString;
         end;
end;

procedure TfrmReporteGarReal.Inicializar;
begin
        if dmGeneral.IBTransaction1.InTransaction then
           dmGeneral.IBTransaction1.Rollback;

        dmGeneral.IBTransaction1.StartTransaction;

        IBAgencia.Active := True;
        IBAgencia.Last;
        EdAgencia.KeyValue := Agencia;

        IBClasificacion.Active := True;
        IBClasificacion.Last;
        CBclasificacion.KeyValue := -1;
        CBclasificacion.SetFocus;
        CmdAceptar.Enabled := True;
end;

procedure TfrmReporteGarReal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        Action := caFree;
end;

procedure TfrmReporteGarReal.FormShow(Sender: TObject);
begin
        Inicializar;
end;

procedure TfrmReporteGarReal.CmdNuevoClick(Sender: TObject);
var
  Duration : TDateTime;
begin
{  try
    scExcelExport1 := TscExcelExport.Create(self);
    scExcelExport1.WorksheetName := 'reporte de la tabla gen$minimos';
    scExcelExport1.Dataset:=IBQuery1;
    //IBQuery1.Open;
    scExcelExport1.ExcelVisible:=True;
    Duration := Now();
    scExcelExport1.ExportDataset;

  finally
    scExcelExport1.Disconnect;
  end;   }
        Inicializar;
end;

procedure TfrmReporteGarReal.FormKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmReporteGarReal.ReporteGetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'Empresa' then ParValue := Empresa;
        if ParName = 'Nit' then ParValue := Nit;
        if ParName = 'Empleado' then ParValue := Nombres + ' ' + Apellidos;
        if ParName = 'Clasificacion' then ParValue := CBclasificacion.Text;
end;

end.


