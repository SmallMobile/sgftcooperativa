program UDPCliente;

uses
  QForms,
  UnitMain in 'UnitMain.pas' {Form1},
  HexConvert in 'HexConvert.pas',
  UnitDES in 'UnitDES.pas',
  UnitDesCiphers in 'UnitDesCiphers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
