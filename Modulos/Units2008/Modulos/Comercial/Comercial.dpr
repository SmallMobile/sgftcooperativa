program Comercial;

uses
  Forms,
  UnitMain in '..\..\..\Modulo Comercial\Units\UnitMain.pas' {FrmMain},
  UnitTConexion in '..\..\Clases\UnitTConexion.pas',
  UnitGlobal in '..\..\Units\UnitGlobal.pas',
  unitLogin in '..\..\Units\unitLogin.pas' {frmLogin},
  Consts in '..\..\Units\Consts.pas',
  UnitCrearContratual in '..\..\Units\UnitCrearContratual.pas' {FrmCrearContractual},
  UnitTContractual in '..\..\Clases\UnitTContractual.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
