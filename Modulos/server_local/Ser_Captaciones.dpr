program Ser_Captaciones;

uses
  Forms,
  UnitServerCaptaciones in 'UnitServerCaptaciones.pas' {FrmServerConsultas};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmServerConsultas, FrmServerConsultas);
  Application.Run;
end.
