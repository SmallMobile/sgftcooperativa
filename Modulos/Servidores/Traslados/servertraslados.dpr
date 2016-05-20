program servertraslados;

uses
  QForms,
  UnitTraslados in 'Units\UnitTraslados.pas' {frmServerTraslados},
  Unitxml in '\\Winserver\Repositorio\Sistemas\Modulos\Servidores\Traslados\Units\Unitxml.pas' {frmXml},
  UnitGlobales in '\\Winserver\Repositorio\Sistemas\Modulos\Servidores\Traslados\Units\UnitGlobales.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmServerTraslados, frmServerTraslados);
  Application.Run;
end.
