program ConsultaRemota;

uses
  Forms,
  DataSetToExcel in 'DataSetToExcel.pas',
  UnitConsultaRemota in 'UnitConsultaRemota.pas' {frmConsultaRemota},
  Consts in '\\Winserver\repositorio\sistemas\units\Consts.pas',
  UnitPantallaProgreso in '..\..\Units\UnitPantallaProgreso.pas' {frmProgreso};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmConsultaRemota, frmConsultaRemota);
  Application.CreateForm(TfrmProgreso, frmProgreso);
  Application.Run;
end.
