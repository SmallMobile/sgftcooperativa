program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  UnitGlobales in '\\Winserver\Repositorio\Sistemas\Globales Prueba Causados\UnitGlobales.pas',
  UnitdmGeneral in '\\Winserver\Repositorio\Sistemas\units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  Unit_DmComprobante in '\\Winserver\Repositorio\Sistemas\Globales\Unit_DmComprobante.pas' {DmComprobante: TDataModule},
  UnitGlobalesCol in '\\Winserver\Repositorio\Sistemas\Globales\UnitGlobalesCol.pas',
  UnitdmColocacion in '\\Winserver\Repositorio\Sistemas\units\UnitdmColocacion.pas' {dmColocacion: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmGeneral, dmGeneral);
  Application.CreateForm(TDmComprobante, DmComprobante);
  Application.CreateForm(TdmColocacion, dmColocacion);
  Application.Run;
end.
