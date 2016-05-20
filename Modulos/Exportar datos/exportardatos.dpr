program exportardatos;

uses
  Forms,
  Unitxml in 'Unitxml.pas' {Form1},
  UnitGlobales in '\\Winserver\Repositorio\Sistemas\Modulos\Exportar datos\UnitGlobales.pas',
  SZCodeBaseX in '\\Winserver\Repositorio\Sistemas\Componentes\SZCODER\SZCodeBaseX.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
