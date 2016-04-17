program Contabilidad;

uses
  Forms,
  unitMain in 'units\unitMain.pas' {frmMain},
  Consts in 'units\Consts.pas',
  Unit_BuscarClave in 'units\Unit_BuscarClave.pas' {frmBuscarClave},
  Unit_BuscarCodigo in 'units\Unit_BuscarCodigo.pas' {frmBuscarCodigo},
  Unit_DmComprobante in 'units\Unit_DmComprobante.pas' {DmComprobante: TDataModule},
  Unit_Dmpuc in 'units\Unit_Dmpuc.pas' {Dmpuc: TDataModule},
  Unit_Mantenimientopuc in 'units\Unit_Mantenimientopuc.pas' {frmMantenimientopuc},
  UnitBalanceGeneral in 'units\UnitBalanceGeneral.pas' {frmBalanceGeneral},
  UnitBalanceGralDetallado in 'units\UnitBalanceGralDetallado.pas' {frmBalanceGralDetallado},
  UnitBuscarColocacion in 'units\UnitBuscarColocacion.pas' {frmBusquedadeColocacion},
  UnitBuscarPersona in 'units\UnitBuscarPersona.pas' {frmBuscarPersona},
  UnitBuscarTexto in 'units\UnitBuscarTexto.pas' {frmBuscarTexto},
  UnitdmGeneral in 'units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  UnitdmPersona in 'units\UnitdmPersona.pas' {dmPersona: TDataModule},
  UnitInformeAuxiliar in 'units\UnitInformeAuxiliar.pas' {frmInformeAuxiliares},
  UnitPantallaProgreso in 'units\UnitPantallaProgreso.pas' {frmProgreso},
  UnitRecuperacionsaldos in 'units\UnitRecuperacionsaldos.pas' {frmrecuperacionsaldos},
  UnitRecuperarComprobante in 'units\UnitRecuperarComprobante.pas' {frmRecuperarComprobante},
  unitLogin in 'units\unitLogin.pas' {frmLogin},
  Unit_buscarcomprobante in 'units\Unit_buscarcomprobante.pas' {frmbuscarcomprobante},
  unitCierreDia in 'units\unitCierreDia.pas' {frmcierredia},
  UnitListadodePrueba in 'units\UnitListadodePrueba.pas' {frmListadodePrueba},
  UnitPlanillaResumen in 'units\UnitPlanillaResumen.pas' {frmPlanillaResumen},
  UnitConsolidarBalance in 'units\UnitConsolidarBalance.pas' {frmConsolidarBalance},
  UnitBalanceDetalladoConsolidado in 'units\UnitBalanceDetalladoConsolidado.pas' {frmBalanceDetalladoConsolidado},
  UnitCreaciondePersona in 'units\UnitCreaciondePersona.pas' {frmCreacionPersona},
  UnitReLogin in 'units\UnitReLogin.pas' {frmReLogin},
  UnitVistaPreliminar in 'units\UnitVistaPreliminar.pas' {frmVistaPreliminar},
  Unit_Comprobante in 'units\Unit_Comprobante.pas' {frmComprobante},
  digitacuenta in 'units\digitacuenta.pas' {digita},
  digitacuentaC in 'units\digitacuentaC.pas' {digitaC},
  Unit_ComprobanteC in 'units\Unit_ComprobanteC.pas' {frmComprobanteC},
  UnitPaginarPapel in 'units\UnitPaginarPapel.pas' {frmPaginarPapel},
  UnitLibroRMayorYBalance in 'units\UnitLibroRMayorYBalance.pas' {frmLibroMayorYBalance},
  UnitConsolidarSaldoIAgencia in 'units\UnitConsolidarSaldoIAgencia.pas' {frmConsolidarSaldoIAgencia},
  UnitLibroCajaDiario in 'units\UnitLibroCajaDiario.pas' {frmLibroRCajaDiario},
  UnitCajaDiario in 'units\UnitCajaDiario.pas' {frmCajaDiario},
  UnitBalanceConsolidado in 'units\UnitBalanceConsolidado.pas' {frmBalanceConsolidado},
  UnitEstadoIyGConsolidado in 'units\UnitEstadoIyGConsolidado.pas' {frmEstadoIyGConsolidado},
  UnitImpresion in 'units\UnitImpresion.pas' {FrmImpresion},
  UnitCierreAnual in 'units\UnitCierreAnual.pas' {frmCierreAnual},
  UnitTipoImpresion in 'units\UnitTipoImpresion.pas' {frmTipoImpresion},
  UnitGlobales in 'units\UnitGlobales.pas',
  UnitConsolidarCajaDiario in 'units\UnitConsolidarCajaDiario.pas' {frmConsolidarCajaDiario},
  UnitExportarSaldos in 'units\UnitExportarSaldos.pas' {frmExportarSaldos};

//  UnitFechaAEvaluar in 'units\UnitFechaAEvaluar.pas' {frmFechas};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Módulo Contabilidad Laboratorio de Paz III';
  Application.CreateForm(TdmGeneral, dmGeneral);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
