program Bancoldex;

uses
  Forms,
  unitMain in 'Unit\unitMain.pas' {frmMain},
  UnitInformeSolicitudesBancoldex in '\\Winserver\Repositorio\Sistemas\units\UnitInformeSolicitudesBancoldex.pas' {frmInformeSolicitudesBancoldex},
  UnitAgregarCreditosBancoldex in '\\Winserver\Repositorio\Sistemas\units\UnitAgregarCreditosBancoldex.pas' {frmAgregarCreditosBancoldex},
  UnitConsolidarPlanoBancoldex in '\\Winserver\Repositorio\Sistemas\units\UnitConsolidarPlanoBancoldex.pas' {frmConsolidarPlanoBancoldex},
  UnitInformeCreditosBancoldex in '\\Winserver\Repositorio\Sistemas\units\UnitInformeCreditosBancoldex.pas' {frmInformeCreditosBancoldex},
  unitLogin in '\\Winserver\Repositorio\Sistemas\units\unitLogin.pas' {frmLogin},
  UnitCambiarContrasena in '\\Winserver\Repositorio\Sistemas\units\UnitCambiarContrasena.pas' {frmCambiarContrasena},
  UnitdmGeneral in '\\Winserver\Repositorio\Sistemas\units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  UnitdmColocacion in '\\Winserver\Repositorio\Sistemas\units\UnitdmColocacion.pas' {dmColocacion: TDataModule},
  UnitVistaPreliminar in '\\Winserver\Repositorio\Sistemas\units\UnitVistaPreliminar.pas' {frmVistaPreliminar},
  UnitBuscarTexto in '\\Winserver\Repositorio\Sistemas\units\UnitBuscarTexto.pas' {frmBuscarTexto},
  UnitGlobalesCol in '\\Winserver\Repositorio\Sistemas\Globales\UnitGlobalesCol.pas',
  UnitGlobales in '\\Winserver\Repositorio\Sistemas\Globales\UnitGlobales.pas',
  Unit_DmComprobante in '\\Winserver\Repositorio\Sistemas\Globales\Unit_DmComprobante.pas' {DmComprobante: TDataModule},
  UnitPantallaProgreso in '\\Winserver\Repositorio\Sistemas\units\UnitPantallaProgreso.pas' {frmProgreso},
  UnitImpresion in '\\Winserver\Repositorio\Sistemas\units\UnitImpresion.pas' {FrmImpresion},
  UnitCambioLineaBancoldex in '\\Winserver\Repositorio\Sistemas\units\UnitCambioLineaBancoldex.pas' {frmCambioLineaBancoldex},
  UnitModificaBancoldex in '..\..\units\UnitModificaBancoldex.pas' {FrmModificarLinea};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmGeneral, dmGeneral);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmCambioLineaBancoldex, frmCambioLineaBancoldex);
  Application.CreateForm(TFrmModificarLinea, FrmModificarLinea);
  Application.Run;
end.
