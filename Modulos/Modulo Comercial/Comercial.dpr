program Comercial;

uses
  Forms,
  UnitMain in 'Units\UnitMain.pas' {FrmMain},
  UnitTConexion in '..\Units2008\Clases\UnitTConexion.pas',
  UnitGlobal in '..\Units2008\Units\UnitGlobal.pas',
  unitLogin in '..\Units2008\Units\unitLogin.pas' {frmLogin},
  UnitCrearContratual in '..\Units2008\Units\UnitCrearContratual.pas' {Form1},
  Consts in '..\Units2008\Units\Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
