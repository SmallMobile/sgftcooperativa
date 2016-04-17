program IBReplicator;

uses
  Windows,
  Forms,
  MainForm in 'MainForm.pas' {Main},
  rasform in 'rasform.pas' {dialer},
  Unit4 in 'Unit4.pas' {errordialog},
  About in 'About.pas' {AboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'FB Replicator';
  Application.CreateForm(TMain, Main);
  Application.CreateForm(Tdialer, dialer);
  Application.CreateForm(Terrordialog, errordialog);
  ShowWindow(Application.Handle, SW_HIDE);
  Application.ShowMainForm := FALSE;
  Application.Run;
end.
