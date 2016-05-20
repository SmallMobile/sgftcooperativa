program BarridoCartera;

uses
  Forms,
  ProcesarBarridoCartera in 'ProcesarBarridoCartera.pas' {frmBarridoCartera},
  UnitGlobales in '..\..\Globales\UnitGlobales.pas',
  UnitGlobalesCol in '..\..\Globales\UnitGlobalesCol.pas',
  UnitdmGeneral in '..\..\Units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  Unit_DmComprobante in '..\..\Globales\Unit_DmComprobante.pas' {DmComprobante: TDataModule},
  UnitdmColocacion in '..\..\Units\UnitdmColocacion.pas' {dmColocacion: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBarridoCartera, frmBarridoCartera);
  Application.Run;
end.
