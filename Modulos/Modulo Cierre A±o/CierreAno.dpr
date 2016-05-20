program CierreAno;

uses
  Forms,
  UnitProcesoCierreAno in 'units\UnitProcesoCierreAno.pas' {frmCierreAno},
  UnitdmGeneral in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre A�o\units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  UnitGlobalesCol in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre A�o\units\UnitGlobalesCol.pas',
  UnitGlobales in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre A�o\units\UnitGlobales.pas',
  Unit_DmComprobante in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre A�o\units\Unit_DmComprobante.pas',
  UnitdmColocacion in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre A�o\units\UnitdmColocacion.pas' {dmColocacion: TDataModule},
  UnitPantallaProgreso in '\\Winserver\Repositorio\Sistemas\Modulos\Modulo Cierre A�o\units\UnitPantallaProgreso.pas' {frmProgreso};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cierre A�o';
  Application.CreateForm(TdmGeneral, dmGeneral);
  Application.CreateForm(TdmColocacion, dmColocacion);
  Application.CreateForm(TfrmCierreAno, frmCierreAno);
  Application.Run;
  frmCierreAno.ShowModal;
end.
