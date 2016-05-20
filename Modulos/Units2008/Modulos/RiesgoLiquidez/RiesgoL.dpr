program RiesgoL;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {frmMain},
  UnitAExcel in 'UnitAExcel.pas' {frmAExcel},
  UnitTConexion in '..\..\Clases\UnitTConexion.pas',
  Consts in '..\..\Units\Consts.pas',
  UnitGlobal in '..\..\Units\UnitGlobal.pas',
  unitLogin in '..\..\Units\unitLogin.pas' {frmLogin};

{$R *.res}
var
  _tConexion : TConexion;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
