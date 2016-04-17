program ContabilidadFiltros;

uses
  Forms,
  unitMain in '\\winserver\repositorio\sistemas\Modulos\Contabilidad Filtros\Units\unitMain.pas' {frmMain},
  UnitdmGeneral in '\\winserver\repositorio\sistemas\Modulos\Contabilidad Filtros\Units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  UnitGlobales in '\\winserver\repositorio\sistemas\Modulos\Contabilidad Filtros\Units\UnitGlobales.pas',
  Unit_DmComprobante in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\Unit_DmComprobante.pas' {DmComprobante: TDataModule},
  Unit_ComprobanteC in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\Unit_ComprobanteC.pas' {frmComprobanteC},
  unitLogin in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\unitLogin.pas' {frmLogin},
  Unit_Dmpuc in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\Unit_Dmpuc.pas' {Dmpuc: TDataModule},
  Unit_buscarcomprobante in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\Unit_buscarcomprobante.pas' {frmbuscarcomprobante},
  UnitPantallaProgreso in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitPantallaProgreso.pas' {frmProgreso},
  UnitPlandeCuentas in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitPlandeCuentas.pas' {frmPlandeCuentas},
  UnitBalanceGeneral in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitBalanceGeneral.pas' {frmBalanceGeneral},
  unitCierreDia in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\unitCierreDia.pas' {frmcierredia},
  UnitBalanceGralDetallado in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitBalanceGralDetallado.pas' {frmBalanceGralDetallado},
  UnitInformeAuxiliar in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitInformeAuxiliar.pas' {frmInformeAuxiliares},
  UnitCajaDiario in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitCajaDiario.pas' {frmCajaDiario},
  UnitCopia in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitCopia.pas' {FrmCopia},
  UnitPersona in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitPersona.pas' {FrmPersona},
  UnitPlanillaResumen in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitPlanillaResumen.pas' {frmPlanillaResumen},
  UnitRecuperacionsaldos in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitRecuperacionsaldos.pas' {frmrecuperacionsaldos},
  Consts in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\Consts.pas',
  UnitCotrasena in 'Units\UnitCotrasena.pas' {FrmContrasena},
  UnitUsuario in 'Units\UnitUsuario.pas' {FrmUsuario},
  UnitCierreAnual in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitCierreAnual.pas' {frmcierreanual},
  UnitProcesoCierreAno in '\\winserver\repositorio\Sistemas\Modulos\Contabilidad Filtros\Units\UnitProcesoCierreAno.pas' {frmCierreAno};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SoftCount';
  Application.CreateForm(TdmGeneral, dmGeneral);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
