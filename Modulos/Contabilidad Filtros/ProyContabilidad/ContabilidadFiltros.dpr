program ContabilidadFiltros;

uses
  Forms,
  unitMain in 'Units\unitMain.pas' {frmMain},
  UnitdmGeneral in 'Units\UnitdmGeneral.pas' {dmGeneral: TDataModule},
  UnitGlobales in 'Units\UnitGlobales.pas',
  Unit_DmComprobante in 'Units\Unit_DmComprobante.pas' {DmComprobante: TDataModule},
  UnitBalanceGeneral in 'UnitsWum\UnitBalanceGeneral.pas' {frmBalanceGeneral},
  UnitBalanceGralDetallado in 'UnitsWum\UnitBalanceGralDetallado.pas' {frmBalanceGralDetallado},
  UnitCajaDiario in 'UnitsWum\UnitCajaDiario.pas' {frmCajaDiario},
  UnitInformeAuxiliar in 'UnitsWum\UnitInformeAuxiliar.pas' {frmInformeAuxiliares},
  UnitPersona in 'UnitsWum\UnitPersona.pas' {FrmPersona},
  unitCierreDia in 'UnitsWum\unitCierreDia.pas' {frmcierredia},
  UnitRecuperacionsaldos in 'UnitsWum\UnitRecuperacionsaldos.pas' {frmrecuperacionsaldos},
  UnitPlanillaResumen in 'UnitsWum\UnitPlanillaResumen.pas' {frmPlanillaResumen},
  UnitCopia in 'UnitsWum\UnitCopia.pas' {FrmCopia};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
