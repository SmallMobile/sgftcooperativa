program CierreAno;

uses
  Forms,
  UnitProcesoCierreAno in 'units\UnitProcesoCierreAno.pas' {frmCierreAno},
  UnitdmGeneral in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre Año\units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  UnitGlobalesCol in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre Año\units\UnitGlobalesCol.pas',
  UnitGlobales in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre Año\units\UnitGlobales.pas',
  Unit_DmComprobante in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre Año\units\Unit_DmComprobante.pas',
  UnitdmColocacion in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre Año\units\UnitdmColocacion.pas' {dmColocacion: TDataModule},
  UnitPantallaProgreso in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre Año\units\UnitPantallaProgreso.pas' {frmProgreso};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cierre Año';
  Application.CreateForm(TdmGeneral, dmGeneral);
  Application.CreateForm(TdmColocacion, dmColocacion);
  Application.CreateForm(TfrmCierreAno, frmCierreAno);
  Application.Run;
  frmCierreAno.ShowModal;
end.
