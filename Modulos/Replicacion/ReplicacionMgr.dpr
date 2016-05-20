program ReplicacionMgr;

uses
  QForms,
  UnitAdmReplica in 'UnitAdmReplica.pas' {frmMain},
  UnitAdmManager in 'UnitAdmManager.pas' {frmAdmMgr},
  UnitBasesFuentes in 'UnitBasesFuentes.pas' {frmMgrFuentes},
  UnitBasesDestino in 'UnitBasesDestino.pas' {frmMgrDestino},
  UnitDefinicion in 'UnitDefinicion.pas' {frmDefiniciones},
  UnitAplicarDefinicion in 'UnitAplicarDefinicion.pas' {frmAplicarDefinicion};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
