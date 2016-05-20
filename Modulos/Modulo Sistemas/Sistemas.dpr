program Sistemas;

uses
  Forms,
  UnitVistaPreliminar in '..\..\units\UnitVistaPreliminar.pas' {frmVistaPreliminar},
  Consts in '..\..\units\Consts.pas',
  digitacuenta in '..\..\units\digitacuenta.pas' {digita},
  Unit_BuscarClave in '..\..\units\Unit_BuscarClave.pas' {frmBuscarClave},
  Unit_BuscarCodigo in '..\..\units\Unit_BuscarCodigo.pas' {frmBuscarCodigo},
  Unit_buscarcomprobante in '..\..\units\Unit_buscarcomprobante.pas' {frmbuscarcomprobante},
  Unit_Comprobante in '..\..\units\Unit_Comprobante.pas' {frmComprobante},
  Unit_DmComprobante in '..\..\units\Unit_DmComprobante.pas' {DmComprobante: TDataModule},
  Unit_Dmpuc in '..\..\units\Unit_Dmpuc.pas' {Dmpuc: TDataModule},
  Unit_Mantenimientopuc in '..\..\units\Unit_Mantenimientopuc.pas' {frmMantenimientopuc},
  Unit_RecInformeColocacion in '..\..\units\Unit_RecInformeColocacion.pas' {frmRecuperarInformeColocacion},
  UnitActualizarArqueo in '..\..\units\UnitActualizarArqueo.pas' {frmActualizarArqueo},
  UnitAgregarObservacion in '..\..\units\UnitAgregarObservacion.pas' {frmAgregarObservacionCobro},
  UnitArqueoDevolucion in '..\..\units\UnitArqueoDevolucion.pas' {frmArqueoDevolucion},
  UnitBalanceDetalladoConsolidado in '..\..\units\UnitBalanceDetalladoConsolidado.pas' {frmBalanceDetalladoConsolidado},
  UnitBalanceGeneral in '..\..\units\UnitBalanceGeneral.pas' {frmBalanceGeneral},
  UnitBalanceGralDetallado in '..\..\units\UnitBalanceGralDetallado.pas' {frmBalanceGralDetallado},
  UnitBuscarCaptacion in '..\..\units\UnitBuscarCaptacion.pas' {frmBuscarCaptacion},
  UnitBuscarColocacion in '..\..\units\UnitBuscarColocacion.pas' {frmBusquedadeColocacion},
  UnitBuscarPersona in '..\..\units\UnitBuscarPersona.pas' {frmBuscarPersona},
  UnitBuscarTexto in '..\..\units\UnitBuscarTexto.pas' {frmBuscarTexto},
  UnitCalculoTasas in '..\..\units\UnitCalculoTasas.pas' {frmCalculoTasas},
  UnitCaptaciones in '..\..\units\UnitCaptaciones.pas',
  UnitCargarCostasJudiciales in '..\..\units\UnitCargarCostasJudiciales.pas' {frmCargarCostasJudiciales},
  UnitCausacionColocaciones in '..\..\units\UnitCausacionColocaciones.pas' {frmCausacionColocaciones},
  UnitChequesenCaja in '..\..\units\UnitChequesenCaja.pas' {frmChequesenCaja},
  UnitChequesenTesoreria in '..\..\units\UnitChequesenTesoreria.pas' {frmChequesenTesoreria},
  unitCierreDia in '..\..\units\unitCierreDia.pas' {frmcierredia},
  UnitCierreDiarioCaja in '..\..\units\UnitCierreDiarioCaja.pas' {frmCierreDiarioCaja},
  UnitComprobanteDiarioCaja in '..\..\units\UnitComprobanteDiarioCaja.pas' {frmComprobanteDiario},
  UnitConsolidarBalance in '..\..\units\UnitConsolidarBalance.pas' {frmConsolidarBalance},
  UnitConsultaCaptacion in '..\..\units\UnitConsultaCaptacion.pas' {frmConsultaCaptacion},
  UnitConsultaColocacion in '..\..\units\UnitConsultaColocacion.pas' {frmConsultaColocacion},
  UnitConsultaExtractoCaptacion in '..\..\units\UnitConsultaExtractoCaptacion.pas' {frmConsultaExtractoCaptacion},
  UnitConsultaGarantias in '..\..\units\UnitConsultaGarantias.pas' {frmConsultaGarantias},
  UnitConsultaLiquidacion in '..\..\units\UnitConsultaLiquidacion.pas' {frmConsultaLiquidacion},
  UnitConsultaProductos in '..\..\units\UnitConsultaProductos.pas' {frmConsultaProductos},
  UnitControlCobroCartera in '..\..\units\UnitControlCobroCartera.pas' {frmControlCobroCartera},
  UnitCreacionCaptacion in '..\..\units\UnitCreacionCaptacion.pas' {frmCreacionCaptacion},
  UnitCreaciondePersona in '..\..\units\UnitCreaciondePersona.pas' {frmCreacionPersona},
  UnitDireccionesAsociados in '..\..\units\UnitDireccionesAsociados.pas' {frmDireccionesAsociado},
  UnitdmCaptacion in '..\..\units\UnitdmCaptacion.pas' {dmCaptacion: TDataModule},
  UnitdmColocacion in '..\..\units\UnitdmColocacion.pas' {dmColocacion: TDataModule},
  UnitdmGeneral in '..\..\units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  UnitdmLiquidacionCaptacion in '..\..\units\UnitdmLiquidacionCaptacion.pas' {dmLiquidacionCaptacion: TDataModule},
  UnitdmPersona in '..\..\units\UnitdmPersona.pas' {dmPersona: TDataModule},
  UnitEfectivoNota in '..\..\units\UnitEfectivoNota.pas' {frmEfectivoNota},
  UnitEstadoCaptacion in '..\..\units\UnitEstadoCaptacion.pas' {frmEstadoCaptacion},
  UnitExtractoColocacion in '..\..\units\UnitExtractoColocacion.pas' {FrmExtractoColocacion},
  UnitGarantiaPersonal in '..\..\units\UnitGarantiaPersonal.pas' {frmGarantiaPersonal},
  UnitGarantiaReal in '..\..\units\UnitGarantiaReal.pas' {frmGarantiaReal},
  UnitImagenAmpliada in '..\..\units\UnitImagenAmpliada.pas' {frmImagenAmpliada},
  UnitImagenesPersona in '..\..\units\UnitImagenesPersona.pas' {frmImagenesPersona},
  UnitImpresionCaptacion in '..\..\units\UnitImpresionCaptacion.pas' {frmImpresionCaptacion},
  UnitInformeArqueoDiarioCaja in '..\..\units\UnitInformeArqueoDiarioCaja.pas' {frmInformeArqueoDiarioCaja},
  UnitInformeAuxiliar in '..\..\units\UnitInformeAuxiliar.pas' {frmInformeAuxiliares},
  UnitInformeChequesenCaja in '..\..\units\UnitInformeChequesenCaja.pas' {frmInformeChequesenCaja},
  UnitInformeColocacionListadoGeneral in '..\..\units\UnitInformeColocacionListadoGeneral.pas' {frmInformeColocacionesListadoGeneral},
  UnitInformeColocacionListadoGeneralGClasificacion in '..\..\units\UnitInformeColocacionListadoGeneralGClasificacion.pas' {frmColocacionesporClasificacion},
  UnitInformeDiarioCaja in '..\..\units\UnitInformeDiarioCaja.pas' {frmInformeDiarioCaja},
  UnitInformeGeneraldeCaptaciones in '..\..\units\UnitInformeGeneraldeCaptaciones.pas' {frmInformeGeneraldeCaptaciones},
  UnitLiberacionCanje in '..\..\units\UnitLiberacionCanje.pas' {frmLiberacionCanje},
  UnitLiquidaciondePrueba in '..\..\units\UnitLiquidaciondePrueba.pas' {frmLiquidaciondePrueba},
  UnitLiquidacionExtraordinaria1 in '..\..\units\UnitLiquidacionExtraordinaria1.pas' {frmLiquidacionExtraordinaria1},
  UnitLiquidacionInteresesCaptacion in '..\..\units\UnitLiquidacionInteresesCaptacion.pas' {frmLiquidacionInteresesCaptacion},
  UnitListadodePrueba in '..\..\units\UnitListadodePrueba.pas' {frmListadodePrueba},
  UnitListadoGeneralCaptaciones in '..\..\units\UnitListadoGeneralCaptaciones.pas' {frmListadoGeneralCaptaciones},
  unitLogin in '..\..\units\unitLogin.pas' {frmLogin},
  unitMain in '..\..\units\unitMain.pas' {frmMain},
  UnitMantenimientoCajas in '..\..\units\UnitMantenimientoCajas.pas' {frmMantenimientoCajas},
  UnitMantenimientoCaptacion in '..\..\units\UnitMantenimientoCaptacion.pas' {frmMantenimientoCaptacion},
  UnitMuestroLiquidacionColocacion in '..\..\units\UnitMuestroLiquidacionColocacion.pas' {frmMuestroLiquidacionColocacion},
  UnitNuevaColocacion in '..\..\units\UnitNuevaColocacion.pas' {frmNuevaColocacion},
//  UnitOperacionesCaja in '..\..\units\UnitOperacionesCaja.pas' {frmOperacionesCaja},
  UnitPantallaProgreso in '..\..\units\UnitPantallaProgreso.pas' {frmProgreso},
  UnitPlanillaResumen in '..\..\units\UnitPlanillaResumen.pas' {frmPlanillaResumen},
  UnitProrrogaCaptaciones in '..\..\units\UnitProrrogaCaptaciones.pas' {frmProrrogaCaptacion},
  UnitRangosdeLibreta in '..\..\units\UnitRangosdeLibreta.pas' {frmRangosdeLibreta},
  UnitRecuperacionsaldos in '..\..\units\UnitRecuperacionsaldos.pas' {frmrecuperacionsaldos},
  UnitRecuperarComprobante in '..\..\units\UnitRecuperarComprobante.pas' {frmRecuperarComprobante},
  UnitRecuperarLiquidacionColocacion in '..\..\units\UnitRecuperarLiquidacionColocacion.pas' {frmRecuperarLiquidacionColocacion},
  UnitRecuperarTablaLiquidacionCaptacion in '..\..\units\UnitRecuperarTablaLiquidacionCaptacion.pas' {frmRecuperarTablaLiquidacionCaptacion},
  UnitRelacionCheques in '..\..\units\UnitRelacionCheques.pas' {frmRelacionCheques},
  UnitRevalorizacionAportes in '..\..\units\UnitRevalorizacionAportes.pas' {frmRevalorizacionAportes},
  UnitSaldarCaptacion in '..\..\units\UnitSaldarCaptacion.pas' {frmSaldarCaptacion},
  UnitSumatorias in 'units\UnitSumatorias.pas' {frmSumatorias},
  UnitTablaLiquidacion in '..\..\units\UnitTablaLiquidacion.pas' {frmTablaLiquidacion},
  UnitTablaPagoColocacion in '..\..\units\UnitTablaPagoColocacion.pas' {frmTablaPagoColocacion},
  UnitTasaPromedioCertificados in '..\..\units\UnitTasaPromedioCertificados.pas' {frmTasaPromedioCertificados},
  UnitTomarFoto in '..\..\units\UnitTomarFoto.pas' {frmTomarFoto},
  UnitValidarCaptacion in '..\..\units\UnitValidarCaptacion.pas' {frmValidarCaptacion},
  UnitValidarColocacion in '..\..\units\UnitValidarColocacion.pas' {frmValidarColocacion},
  UnitVisarColocacion in '..\..\units\UnitVisarColocacion.pas' {frmVisarColocacion},
  UnitGlobalesCol in '..\..\Globales\UnitGlobalesCol.pas',
  UnitGlobales in '..\..\Globales\UnitGlobales.pas',
  UnitReporteCaptacionesFogacoop in 'UnitReporteCaptacionesFogacoop.pas' {frmReporteCaptacionesFogacoop},
  UnitCambiarContrasena in '..\..\units\UnitCambiarContrasena.pas' {frmCambiarContrasena},
  UnitResumenColocaciones in '..\..\units\UnitResumenColocaciones.pas' {frmResumenColocaciones},
  UnitObservacionesCambioEstado in '..\..\units\UnitObservacionesCambioEstado.pas' {frmObservacionesCambioEstado},
  UnitTomaHuella in '..\..\units\UnitTomaHuella.pas' {frmRegister},
  UnitVerificarHuella in '..\..\units\UnitVerificarHuella.pas' {frmVerify},
  UnitReporteColocacionesFogacoop in 'UnitReporteColocacionesFogacoop.pas' {frmReporteColocacionesFogacoop},
  UnitLiquidacionCarteraJudicial in '..\..\units\UnitLiquidacionCarteraJudicial.pas' {frmLiquidacionCarteraJudicial},
  UnitBuscarControlCobro in '..\..\units\UnitBuscarControlCobro.pas' {frmBusquedaControlCobro},
  UnitCancelacionCdats in 'UnitCancelacionCdats.pas' {frmCancelacionCdats},
  UnitFormatoPagare in '..\..\units\UnitFormatoPagare.pas' {frmFormatoPagare},
  UnitActualizacionSDN in '..\..\units\UnitActualizacionSDN.pas' {frmActualizacionSDN},
  UnitControldeObservaciones in '..\..\units\UnitControldeObservaciones.pas' {frmControldeObservaciones},
  UnitRegistrarObservacion in '..\..\units\UnitRegistrarObservacion.pas' {frmRegistrarObservacion},
  UnitMantenimientoAbogados in '..\..\units\UnitMantenimientoAbogados.pas' {frmMantenimientoAbogados},
  UnitAsignacionAbogado in '..\..\units\UnitAsignacionAbogado.pas' {frmAsignacionAbogado},
  UnitRCarteraAbogados in '..\..\units\UnitRCarteraAbogados.pas' {frmRCarteraAbogados},
  UnitEvaluacion in '..\..\units\UnitEvaluacion.pas' {frmEvaluacion},
  UnitReporteHuellasDigitales in 'UnitReporteHuellasDigitales.pas' {Form1},
  UnitPantallaHuella in '..\..\units\UnitPantallaHuella.pas' {frmPantallaHuella},
  UnitValidacion in 'UnitValidacion.pas',
  UnitReLogin in '..\..\units\UnitReLogin.pas' {frmReLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TdmGeneral, dmGeneral);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
