program DataServerCajas;

uses
  QForms,
  UnitServer in '\\Archivos\sistemas\Modulos\Modulo Cajas en Linea\Modulo DataServerCajas\UnitServer.pas' {IndyTCPServer};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Servidor de Consultas';
  Application.CreateForm(TIndyTCPServer, IndyTCPServer);
  Application.Run;
end.
