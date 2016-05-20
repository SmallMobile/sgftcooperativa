program Exogena;

uses
  Forms,
  UnitPantallaProgreso in '\\winserver\Repositorio\Sistemas\units\UnitPantallaProgreso.pas' {frmProgreso},
  UnitExogena in 'UnitExogena.pas' {FrmExogena};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmExogena, FrmExogena);
  Application.Run;
end.
