unit Unittipo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFrmTipo = class(TForm)
    RGrafico: TRadioButton;
    Rtextual: TRadioButton;
    Panel1: TPanel;
    BTaceptar: TButton;
    procedure BTaceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
  tipo: Smallint;
  published

    { Public declarations }
  end;

var
  FrmTipo: TFrmTipo;

implementation

uses UnitBeneficiario, UnitConvenios;

{$R *.dfm}

procedure TFrmTipo.BTaceptarClick(Sender: TObject);
begin
        if tipo = 0 then
        begin
          if RGrafico.Checked then
             FrmBeneficiario.opcion_reporte := 1
          else
             FrmBeneficiario.opcion_reporte := 2;
        end
        else
        begin
          if RGrafico.Checked then
             FrmConvenio.opcion_fecha := True
          else
             FrmConvenio.opcion_fecha := False;
        end;

end;

end.
