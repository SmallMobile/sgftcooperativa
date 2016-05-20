program Cajas;

uses
  Forms,
  unitMain in 'Units\unitMain.pas' {frmMain},
  UnitPantallaProgreso in '..\..\units\UnitPantallaProgreso.pas' {frmProgreso},
  UnitBuscarPersona in '..\..\units\UnitBuscarPersona.pas' {frmBuscarPersona},
  UnitConsultaProductos in '..\..\units\UnitConsultaProductos.pas' {frmConsultaProductos},
  UnitdmCaptacion in '..\..\units\UnitdmCaptacion.pas' {dmCaptacion: TDataModule},
  UnitdmColocacion in '..\..\units\UnitdmColocacion.pas' {dmColocacion: TDataModule},
  UnitdmGeneral in '..\..\units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  UnitdmPersona in '..\..\units\UnitdmPersona.pas' {dmPersona: TDataModule},
  UnitEfectivoNota in '..\..\units\UnitEfectivoNota.pas' {frmEfectivoNota},
  UnitInformeDiarioCaja in '..\..\units\UnitInformeDiarioCaja.pas' {frmInformeDiarioCaja},
  UnitLiquidacionInteresesCaptacion in '..\..\units\UnitLiquidacionInteresesCaptacion.pas' {frmLiquidacionInteresesCaptacion},
  unitLogin in '..\..\units\unitLogin.pas' {frmLogin},
  UnitOperacionesCaja in '..\..\units\UnitOperacionesCaja.pas' {frmOperacionesCaja},
  UnitCaptaciones in '..\..\units\UnitCaptaciones.pas',
  UnitdmLiquidacionCaptacion in '..\..\units\UnitdmLiquidacionCaptacion.pas' {dmLiquidacionCaptacion: TDataModule},
  UnitValidarColocacion in '..\..\units\UnitValidarColocacion.pas' {frmValidarColocacion},
  UnitValidarCaptacion in '..\..\units\UnitValidarCaptacion.pas' {frmValidarCaptacion},
  UnitRelacionCheques in '..\..\units\UnitRelacionCheques.pas' {frmRelacionCheques},
  UnitArqueoDevolucion in '..\..\units\UnitArqueoDevolucion.pas' {frmArqueoDevolucion},
  UnitBuscarColocacion in '..\..\units\UnitBuscarColocacion.pas' {frmBusquedadeColocacion},
  UnitImagenAmpliada in '..\..\units\UnitImagenAmpliada.pas' {frmImagenAmpliada},
  UnitImagenesPersona in '..\..\units\UnitImagenesPersona.pas' {frmImagenesPersona},
  Consts in '..\..\units\Consts.pas',
  UnitInformeChequesenCaja in '..\..\units\UnitInformeChequesenCaja.pas' {frmInformeChequesenCaja},
  UnitInformeArqueoDiarioCaja in '..\..\units\UnitInformeArqueoDiarioCaja.pas' {frmInformeArqueoDiarioCaja},
  UnitCierreDiarioCaja in '..\..\units\UnitCierreDiarioCaja.pas' {frmCierreDiarioCaja},
  UnitChequesenCaja in '..\..\units\UnitChequesenCaja.pas' {frmChequesenCaja},
  UnitVistaPreliminar in '..\..\units\UnitVistaPreliminar.pas' {frmVistaPreliminar},
  UnitBuscarTexto in '..\..\units\UnitBuscarTexto.pas' {frmBuscarTexto},
  UnitBuscarCaptacion in '..\..\units\UnitBuscarCaptacion.pas' {frmBuscarCaptacion},
  UnitComprobanteDiarioCaja in '..\..\units\UnitComprobanteDiarioCaja.pas' {frmComprobanteDiario},
  Unit_DmComprobante in '..\..\units\Unit_DmComprobante.pas' {DmComprobante: TDataModule},
  UnitControlCobroCartera in '..\..\units\UnitControlCobroCartera.pas' {frmControlCobroCartera},
  UnitRecuperarLiquidacionColocacion in '..\..\units\UnitRecuperarLiquidacionColocacion.pas' {frmRecuperarLiquidacionColocacion},
  UnitAgregarObservacion in '..\..\units\UnitAgregarObservacion.pas' {frmAgregarObservacionCobro},
  UnitConsultaLiquidacion in '..\..\units\UnitConsultaLiquidacion.pas' {frmConsultaLiquidacion},
  UnitConsultaGarantias in '..\..\units\UnitConsultaGarantias.pas' {frmConsultaGarantias},
  UnitDireccionesAsociados in '..\..\units\UnitDireccionesAsociados.pas' {frmDireccionesAsociado},
  UnitExtractoColocacion in '..\..\units\UnitExtractoColocacion.pas' {FrmExtractoColocacion},
  UnitSumatorias in '..\..\units\UnitSumatorias.pas' {frmSumatorias},
  UnitCambiarContrasena in '..\..\units\UnitCambiarContrasena.pas' {frmCambiarContrasena},
  UnitConsultaColocacion in '..\..\units\UnitConsultaColocacion.pas' {frmConsultaColocacion},
  UnitTablaLiquidacion in '..\..\units\UnitTablaLiquidacion.pas' {frmTablaLiquidacion},
  UnitGlobales in '..\..\Globales\UnitGlobales.pas',
  UnitObservacionesCambioEstado in '..\..\units\UnitObservacionesCambioEstado.pas' {frmObservacionesCambioEstado},
  UnitResumenColocaciones in '..\..\units\UnitResumenColocaciones.pas' {frmResumenColocaciones},
  UnitConsultaExtractoCaptacion in '..\..\units\UnitConsultaExtractoCaptacion.pas' {frmConsultaExtractoCaptacion},
  UnitCreaciondePersona in '..\..\units\UnitCreaciondePersona.pas' {frmCreacionPersona},
  UnitTomarFoto in '..\..\units\UnitTomarFoto.pas' {frmTomarFoto},
  UnitTomaHuella in '..\..\units\UnitTomaHuella.pas' {frmRegister},
  UnitVerificarHuella in '..\..\units\UnitVerificarHuella.pas' {frmVerify},
  UnitBuscarControlCobro in '..\..\units\UnitBuscarControlCobro.pas' {frmBusquedaControlCobro},
  UnitReLogin in '..\..\units\UnitReLogin.pas' {frmReLogin},
  Unittesoreria in '..\..\units\Unittesoreria.pas' {Frmtesoreria},
  UnitArqueoConsolidado in '..\..\units\UnitArqueoConsolidado.pas' {frmArqueoConsolidado},
  UnitMantenimientoCajas in '..\..\units\UnitMantenimientoCajas.pas' {frmMantenimientoCajas},
  UnitControldeObservaciones in '..\..\units\UnitControldeObservaciones.pas' {frmControldeObservaciones},
  UnitRegistrarObservacion in '..\..\units\UnitRegistrarObservacion.pas' {frmRegistrarObservacion},
  UnitPantallaHuella in '..\..\units\UnitPantallaHuella.pas' {frmPantallaHuella},
  UnitImpresion in '..\..\units\UnitImpresion.pas' {FrmImpresion},
  Videocap in '..\..\units\Videocap.pas',
  VFW in '..\..\units\VfW.pas',
  UnitLiquidacionGral in '..\..\units\UnitLiquidacionGral.pas' {frmLiquidacionGral},
  UnitCalculoTasas in '..\..\units\UnitCalculoTasas.pas' {frmCalculoTasas},
  UnitConsultaSol in '..\..\units\UnitConsultaSol.pas' {FrmConsultaSol},
  UnitDmSolicitud in '..\..\units\UnitDmSolicitud.pas' {DmSolicitud: TDataModule},
  UnitDescObservacion in '..\..\units\UnitDescObservacion.pas' {FrmDescObsrevacion},
  UnitFirmas in '..\..\units\UnitFirmas.pas' {FrmFirmas},
  UnitComprobanteSucursalFecha in '..\..\units\UnitComprobanteSucursalFecha.pas' {FrmComprobanteSucursalFecha},
  UnitRelacionChequesEnCanje in '..\..\units\UnitRelacionChequesEnCanje.pas' {frmRelacionChequesEnCanje},
  UnitRemotaConsulta in '..\..\units\UnitRemotaConsulta.pas' {FrmRemotaConsulta},
  UnitInformeCajaRemota in '..\..\units\UnitInformeCajaRemota.pas' {FrmInformeCajaRemota},
  ZLibEx in '..\Modulo Analista\ZlibEx\ZLIBEX.PAS',
  UnitVisacionRetirosCaja in '..\..\units\UnitVisacionRetirosCaja.pas' {frmVisacionRetirosCaja},
  UnitExtractoCredito in '..\..\units\UnitExtractoCredito.pas' {frmExtractoCredito},
  UnitCambios in '..\..\units\UnitCambios.pas' {FrmCambios},
  UnitAgregarObservacionSol in '..\..\units\UnitAgregarObservacionSol.pas' {frmAgregarObservacionSol},
  UnitExtractoAgencia in '..\..\units\UnitExtractoAgencia.pas' {FrmExtractoAgencia},
  UnitComprobanteSucursal in '..\..\units\UnitComprobanteSucursal.pas' {FrmComprobanteSucursal},
  UnitBuscarCiiu in '..\..\units\UnitBuscarCiiu.pas' {frmBuscarCIIU},
  UnitCreacionPersonaIndependiente in '..\..\units\UnitCreacionPersonaIndependiente.pas' {frmCreacionPersonaIndependiente},
  UnitOperacionesEfectivo in '..\..\units\UnitOperacionesEfectivo.pas' {frmOperacionesEfectivo},
  UnitGlobalesCol in '..\..\Globales\UnitGlobalesCol.pas',
  UnitDeclaracion in '..\..\Units\UnitDeclaracion.pas' {FrmDeclaracion},
  UnitGeneraCartas in '..\..\Units\UnitGeneraCartas.pas' {FrmGeneraCarta},
  UnitImagenJpeg in '..\..\Units\UnitImagenJpeg.pas' {FrmImagenJpg},
  UnitGuardaImagen in '..\..\Units\UnitGuardaImagen.pas',
  UnitRecuperaValidacion in '..\..\Units\UnitRecuperaValidacion.pas' {FrmRecuperaValidacion},
  Unit_Comprobante in '..\..\Units\Unit_Comprobante.pas' {frmComprobante},
  digitacuenta in '..\..\Units\digitacuenta.pas' {digita},
  Unit_Mantenimientopuc in '..\..\Units\Unit_Mantenimientopuc.pas' {frmMantenimientopuc},
  Unit_Dmpuc in '..\..\Units\Unit_Dmpuc.pas' {Dmpuc: TDataModule},
  Unit_BuscarCodigo in '..\..\Units\Unit_BuscarCodigo.pas' {frmBuscarCodigo},
  Unit_BuscarClave in '..\..\Units\Unit_BuscarClave.pas' {frmBuscarClave},
  Unit_buscarcomprobante in '..\..\Units\Unit_buscarcomprobante.pas' {frmbuscarcomprobante},
  UnitTipoImpresion in '..\..\Units\UnitTipoImpresion.pas' {frmTipoImpresion},
  UnitConsultaTarjeta in '..\..\Units\UnitConsultaTarjeta.pas' {FrmConsultaTarjeta},
  UnitClaseXml in '..\..\Units\UnitClaseXml.pas',
  UnitTiraSumadora in '..\..\Units\UnitTiraSumadora.pas' {FrmTiraSumadora};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Modulo de Cajas';
  Application.CreateForm(TdmGeneral, dmGeneral);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
