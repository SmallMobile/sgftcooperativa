unit UnitRepVentas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Buttons, ComCtrls, IBDatabase, DB,
  IBCustomDataSet, IBQuery,JclDateTime,DateUtils, DBClient, pr_Common,
  pr_TxClasses;

type
  TFrmRepVentas = class(TForm)
    Panel1: TPanel;
    empleado: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    fecha: TDateTimePicker;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DataSource1: TDataSource;
    IBQuery1: TIBQuery;
    IBTransaction1: TIBTransaction;
    Label3: TLabel;
    Label4: TLabel;
    Convenio: TDBLookupComboBox;
    IBconvenio: TIBQuery;
    DSconvenio: TDataSource;
    CdVentas: TClientDataSet;
    CdVentasnit_beneficiario: TStringField;
    CdVentasnombres: TStringField;
    CdVentasrenovacion: TStringField;
    CdVentasparentesco: TStringField;
    CdVentasnumero: TIntegerField;
    Reporte: TprTxReport;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fechaChange(Sender: TObject);
  private
    function busca_nombre(nit: string): string;
    function busca_parentesco(parentesco: integer): string;
  
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRepVentas: TFrmRepVentas;

implementation

uses UnitQuerys, UnitPantallaProgreso, UnitdataQuerys, UnitPrincipal,UnitVistaPreliminar;

{$R *.dfm}

procedure TFrmRepVentas.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmRepVentas.BitBtn1Click(Sender: TObject);
var    a:string;
begin
        DataQuerys := TDataQuerys.Create(self);
        frmquerys := TFrmQuerys.Create(self);
        CdVentas.CancelUpdates;
        a := IntToStr(DaysInAMonth(YearOfDate(fecha.Date),MonthOfDate(fecha.Date)));
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$afiliacion"."nit_beneficiario","fun$afiliacion"."es_afiliacion","fun$afiliacion"."parentesco"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."id_convenio" = :id_convenio) AND');
          SQL.Add('("fun$afiliacion"."id_empleado" = :id_empleado) AND');
          SQL.Add('("fun$afiliacion"."fecha" BETWEEN :fecha1 AND :fecha2)');
          ParamByName('id_convenio').AsInteger := Convenio.KeyValue;
          ParamByName('id_empleado').AsString := empleado.KeyValue;
          ParamByName('fecha1').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',fecha.Date));
          ParamByName('fecha2').AsDate := StrToDate(FormatDateTime('yyyy/mm/' + a,fecha.Date));
          Open;
          Last;
          First;
          if RecordCount = 0 then begin
             MessageDlg('No existen Registros Disponibles',mtInformation,[mbok],0);
             empleado.SetFocus;
             Exit;
          end;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Titulo := 'Reporte de Ventas -- '+ FormatDateTime('mmmm " de " yyyy',fecha.Date);
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Registro No : '+IntToStr(RecNo);
            Application.ProcessMessages;
            CdVentas.Append;
            CdVentas.FieldValues['nit_beneficiario'] := FieldByName('nit_beneficiario').AsString;
            CdVentas.FieldValues['nombres'] := busca_nombre(FieldByName('nit_beneficiario').AsString);
            if FieldByName('es_afiliacion').AsInteger = 1 then
               CdVentas.FieldValues['renovacion'] := 'Afiliacion'
            else
               CdVentas.FieldValues['renovacion'] := 'Renovacion';
            CdVentas.FieldValues['parentesco'] := busca_parentesco(fieldbyname('parentesco').AsInteger);
            CdVentas.FieldValues['numero'] := RecNo;
            CdVentas.Post;
            Next;
          end;
          frmProgresos.Cerrar;
          Close;
        end;
            reporte.Variables.ByName['empresa'].AsString := FrMain.Empresa;
            Reporte.Variables.ByName['hoy'].AsDateTime := Date;
            Reporte.Variables.ByName['tramite'].AsString := empleado.Text;
            reporte.Variables.ByName['Nit'].AsString := FrMain.Nit;
            Reporte.Variables.ByName['convenio'].AsString := Convenio.Text;
            Reporte.Variables.ByName['participante'].AsString := formatdatetime('mmmm " de " yyyy',fecha.DateTime);            
            frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
            if Reporte.PrepareReport then
            begin
              frmVistaPreliminar.Reporte := reporte;
              frmVistaPreliminar.ShowModal;
            end;
end;

procedure TFrmRepVentas.FormCreate(Sender: TObject);
begin
        IBQuery1.Open;
        IBQuery1.Last;
        IBconvenio.Open;
        IBconvenio.Last;
        fecha.Date := Date;
        fecha.MaxDate := Date;
        fecha.Hint := FormatDateTime('mmmm " de " yyyy',fecha.Date);
end;

function TFrmRepVentas.busca_nombre(nit: string): string;
var     nombres :string;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$beneficiario"."nombres"');
          SQL.Add('FROM');
          SQL.Add('"fun$beneficiario"');
          SQL.Add('WHERE');
          SQL.Add('("fun$beneficiario"."identificacion" = :nit)');
          ParamByName('nit').AsString := nit;
          Open;
          nombres := FieldByName('nombres').AsString;
          Close;
        end;
        if nombres <> '' then
          Result := nombres
        else
        begin
          with FrmQuerys.IBseleccion do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select * from BUSCA_PERSONA_N1(:NIT)');
            ParamByName('NIT').AsString := nit;
            Open;
            Result := FieldByName('APELLIDO1').AsString + ' ' +FieldByName('APELLIDO2').AsString + ' ' +FieldByName('NOMBRES').AsString;
            Close;
          end;
        end;
end;

function TFrmRepVentas.busca_parentesco(parentesco: integer): string;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$parentesco"."descripcion"');
          SQL.Add('FROM');
          SQL.Add('"fun$parentesco"');
          SQL.Add('WHERE');
          SQL.Add('("fun$parentesco"."id_parentesco" = :parentesco)');
          ParamByName('parentesco').AsInteger := parentesco;
          Open;
          Result := FieldByName('descripcion').AsString;
          Close;
        end;
end;

procedure TFrmRepVentas.fechaChange(Sender: TObject);
begin
        fecha.Hint := FormatDateTime('mmmm " de " yyyy',fecha.Date)
end;

end.
