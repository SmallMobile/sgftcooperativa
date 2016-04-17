program ProcesoTarjeta;

uses
  Forms,
  UnitTarjeta in 'UnitTarjeta.pas' {Form1},
  UnitTarjetasNovedades in 'UnitTarjetasNovedades.pas' {frmTarjetasNovedades},
  UnitdmGeneral in 'UnitdmGeneral.pas' {dmGeneral: TDataModule},
  UnitClaseXml in 'UnitClaseXml.pas',
  UnitClaseData in 'UnitClaseData.pas',
  UnitConexion in 'UnitConexion.pas',
  UnitGlobalTd in 'UnitGlobalTd.pas',
  UnitPantallaProgreso in '..\..\Units\UnitPantallaProgreso.pas' {frmProgreso};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmGeneral, dmGeneral);
  Application.CreateForm(TfrmTarjetasNovedades, frmTarjetasNovedades);
  Application.Run;
end.
