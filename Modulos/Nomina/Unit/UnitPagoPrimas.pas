unit UnitPagoPrimas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Buttons, DB, IBCustomDataSet,
  IBQuery;

type
  TFrmPagoPrimas = class(TForm)
    Oficina: TLabel;
    DBagencia: TDBLookupComboBox;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DataSource1: TDataSource;
    IBQuery1: TIBQuery;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
  tipo_prima :Integer;
    { Public declarations }
  end;

var
  FrmPagoPrimas: TFrmPagoPrimas;

implementation

uses UnitNomina, UnitGlobal, UnitPrincipal;

{$R *.dfm}

procedure TFrmPagoPrimas.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmPagoPrimas.FormCreate(Sender: TObject);
begin
        IBQuery1.Open;
        IBQuery1.Last;
        DBagencia.KeyValue := 1;
end;

procedure TFrmPagoPrimas.BitBtn1Click(Sender: TObject);

begin
        FrmNomina := TFrmNomina.Create(self);
        if DBagencia.KeyValue = 1 then
        begin
           FrmNomina.cod_inicio := 10; FrmNomina.cod_fin := 20;
        end
        else if DBagencia.KeyValue = 2 then
        begin
           FrmNomina.cod_inicio := 30; FrmNomina.cod_fin := 30;
        end
        else if DBagencia.KeyValue = 3 then
        begin
           FrmNomina.cod_inicio := 40; FrmNomina.cod_fin := 40;
        end
        else if DBagencia.KeyValue = 4 then
        begin
           FrmNomina.cod_inicio := 50; FrmNomina.cod_fin := 50;
        end
        else if DBagencia.KeyValue = 5 then
        begin
           FrmNomina.cod_inicio := 60; FrmNomina.cod_fin := 60;
        end;


        if tipo_prima = 1 then
           FrmNomina.pagoprima
        else if tipo_prima = 2 then
           FrmNomina.pnavidad
        else if tipo_prima = 3 then
           FrmNomina.Pago_interes
        else
        begin
           verificatransaccion(FrmNomina.IBcausacion);
           FrmNomina.frDBDataSet1.DataSet := FrmNomina.IBcausacion;
           FrmNomina.IBcausacion.ParamByName('tipo').AsInteger := FrmNomina.cod_inicio;
           FrmNomina.IBcausacion.ParamByName('tipo1').AsInteger := FrmNomina.cod_fin;           
           FrmNomina.IBcausacion.ParamByName('mes').AsInteger := 12;

           FrmNomina.IBcausacion.Open;
           FrmNomina.imprimir_reporte(frmain.wpath+'reportes\reppagocesantias.frf')
        end;

end;

end.
