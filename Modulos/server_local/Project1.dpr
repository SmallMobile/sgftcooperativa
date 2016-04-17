program Project1;

uses
  Forms,
  UnitServer in 'UnitServer.pas' {FrmServer};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmServer, FrmServer);
  Application.Run;
end.
