program rasdemo;

uses
  Forms,
  demo in 'demo.pas' {MainForm},
  ras_api32 in 'ras_api32.pas',
  rascomp32 in 'rascomp32.pas',
  winperf in 'winperf.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
