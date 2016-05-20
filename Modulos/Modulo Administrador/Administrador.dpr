program Administrador;

uses
  Forms,
  Consts in '..\..\units\Consts.pas',
  UnitEliminaUsuario in '..\..\units\UnitEliminaUsuario.pas' {FrmEliminaUsuario},
  UnitdmGeneral in '..\..\units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  unitMain in 'Units\unitMain.pas' {frmMain},
  UnitGlobales in '..\..\Globales\UnitGlobales.pas',
  Unit_DmComprobante in '..\..\units\Unit_DmComprobante.pas' {DmComprobante: TDataModule},
  UnitGlobalesCol in '..\..\Globales\UnitGlobalesCol.pas',
  UnitdmColocacion in '..\..\units\UnitdmColocacion.pas' {dmColocacion: TDataModule},
  unitLogin in '..\..\units\unitLogin.pas' {frmLogin},
  UnitCambiarContrasena in '..\..\units\UnitCambiarContrasena.pas' {frmCambiarContrasena},
  UnitReLogin in '..\..\units\UnitReLogin.pas' {frmReLogin},
  UnitGlobal in 'Units\UnitGlobal.pas',
  UnitVerificaIni in 'Units\UnitVerificaIni.pas' {FrmVerificaIni},
  UnitDmPermiso in 'Units\UnitDmPermiso.pas' {DmPermiso: TDataModule},
  UnitRole in '..\..\units\UnitRole.pas' {FrmRole},
  UnitPermisos in '..\..\units\UnitPermisos.pas' {FrmPermisos},
  UnitPantallaProgreso in '..\..\units\UnitPantallaProgreso.pas' {frmProgreso},
  UnitFechaSucursal in '..\..\units\UnitFechaSucursal.pas' {FrmFechaSucursal},
  UnitConsultaEmp in '..\..\units\UnitConsultaEmp.pas' {FrmConsultaEmp},
  UnitDmInventario in 'Units\UnitDmInventario.pas' {DmInventario: TDataModule},
  UnitCreacionUsuario in '..\..\units\UnitCreacionUsuario.pas' {FrmCreacionUsuarios},
  UnitCreacion in 'Units\UnitCreacion.pas' {FrmCreacion},
  UnitAsignaCaja in '..\..\units\UnitAsignaCaja.pas' {FrmAsignaCaja},
  UnitClaseXml in '..\..\units\UnitClaseXml.pas';

//Consts in 'Units\Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDmPermiso, DmPermiso);
  Application.CreateForm(TDmInventario, DmInventario);
  Application.CreateForm(TdmGeneral, dmGeneral);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
