program Barrido;

uses
  Forms,
  UnitServerBarrido in 'UnitServerBarrido.pas' {FrmServerConsultas},
  Consts in '\\Winserver\repositorio\sistemas\units\Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmServerConsultas, FrmServerConsultas);
  Application.Run;
end.
