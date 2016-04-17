program Rmgr1_pr;

uses
  Forms,
  rmgr1 in 'rmgr1.pas' {Form1},
  OpenDb in 'OpenDb.pas' {OpenDBDlg},
  DualDlg in 'DualDlg.pas' {DualListDlg},
  RmgrSQL in 'Rmgrsql.pas',
  DBEdit in 'DBEdit.pas' {Form2},
  DelDb in 'DelDb.pas' {DelDBDlg},
  AppTrig in 'AppTrig.pas' {OKTrigDlg},
  DBSetup in 'DBSetup.pas' {SetupDB};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'FB Replication Manager';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TOpenDBDlg, OpenDBDlg);
  Application.CreateForm(TDualListDlg, DualListDlg);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDelDBDlg, DelDBDlg);
  Application.CreateForm(TOKTrigDlg, OKTrigDlg);
  Application.CreateForm(TSetupDB, SetupDB);
  Application.Run;
end.
