program NotasC;

uses
  Forms,
  UnitNotas in 'Units\UnitNotas.pas' {FrmNotas},
  UnitPantallaProgreso in '\\winserver\Repositorio\Sistemas\units\UnitPantallaProgreso.pas' {frmProgreso};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmNotas, FrmNotas);
  Application.Run;
end.
