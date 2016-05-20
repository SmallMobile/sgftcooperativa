program BarridoCarteraFecha;

uses
  Forms,
  UnitdmGeneral in '\\winserver\repositorio\Sistemas\units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  UnitdmColocacion in '\\winserver\repositorio\Sistemas\units\UnitdmColocacion.pas' {dmColocacion: TDataModule},
  Unit_DmComprobante in '\\winserver\repositorio\Sistemas\units\Unit_DmComprobante.pas' {DmComprobante: TDataModule},
  UnitGlobales in '..\..\Globales\UnitGlobales.pas',
  UnitGlobalesCol in '..\..\Globales\UnitGlobalesCol.pas',
  ProcesarBarridoCarteraFecha in 'ProcesarBarridoCarteraFecha.pas' {frmBarridoCartera};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBarridoCartera, frmBarridoCartera);
  Application.Run;
end.
