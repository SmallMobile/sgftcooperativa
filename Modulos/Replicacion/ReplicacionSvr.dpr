program ReplicacionSvr;

uses
  QForms,
  UnitReplicacionServer in 'UnitReplicacionServer.pas' {frmMain},
  UnitErrores in 'UnitErrores.pas' {frmErrorres};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmErrorres, frmErrorres);
  Application.Run;
end.
