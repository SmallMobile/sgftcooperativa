program Activos;

uses
  Forms,
  UnitActivorep in 'unit\UnitActivorep.pas' {FrmActivos},
  UnitLogin in 'unit\UnitLogin.pas' {login},
  UnitPrincipal in 'unit\UnitPrincipal.pas' {FrMain},
  UnitActivoreal in 'unit\UnitActivoreal.pas' {frmactivoreal},
  UnitGeneral in 'unit\UnitGeneral.pas' {frmgeneral: TDataModule},
  UnitGlobal in 'unit\UnitGlobal.pas',
  UnitTraslado in 'unit\UnitTraslado.pas' {frmfact},
  Unitentrega in 'unit\Unitentrega.pas' {FrmEntrega},
  UnitFactura in 'unit\UnitFactura.pas' {FrmFacturas},
  UnitProveedores in 'unit\UnitProveedores.pas' {FrmProveedor},
  UnitMantenimiento in 'unit\UnitMantenimiento.pas' {FrmMantenimiento},
  UnitTrasladoreal in 'unit\UnitTrasladoreal.pas' {FrmTraslado},
  UnitMejora in 'unit\UnitMejora.pas' {FrmMejora},
  UnitSalida in 'unit\UnitSalida.pas' {FrmSalida},
  UnitActualiza in 'unit\UnitActualiza.pas' {Frmactualiza},
  UnitDvolucion in 'unit\UnitDvolucion.pas' {FrmDevolucion},
  UnitReporte in 'unit\UnitReporte.pas' {FrmReporte: TDataModule},
  UnitImpresion in 'unit\UnitImpresion.pas' {FrmImpresion},
  UnitBuscarTexto in 'unit\UnitBuscarTexto.pas' {frmBuscarTexto},
  UnitDepreciacion in 'unit\UnitDepreciacion.pas' {FrmDepreciacion},
  Unitdecomprobante in 'unit\Unitdecomprobante.pas' {dmcomprobante: TDataModule},
  UnitDigita in 'unit\UnitDigita.pas' {Digita},
  Unitdata in 'unit\Unitdata.pas' {frmdata: TDataModule},
  Unitprogreso in 'unit\Unitprogreso.pas' {FrmProgreso},
  UnitDatosactivo in 'unit\UnitDatosactivo.pas' {FrmdatoActivo},
  UnitReppoliza in 'unit\UnitReppoliza.pas' {FrmReportepol},
  UnitCancela in 'unit\UnitCancela.pas' {FrmCancela},
  UnitconMantenimiento in 'unit\UnitconMantenimiento.pas' {FrmcosultaMant},
  UnitRepSeccion in 'unit\UnitRepSeccion.pas' {FrmReporteseccion},
  UnitElementos in 'unit\UnitElementos.pas' {FrmElementos},
  Unitcomponentes in 'unit\Unitcomponentes.pas' {FrmConcomponente},
  Consts in 'unit\Consts.pas',
  UnitReportetraslado in 'unit\UnitReportetraslado.pas' {FrmReptraslado},
  UnitCambiarContrasena in 'unit\UnitCambiarContrasena.pas' {frmCambiarContrasena},
  Unitcambioplaca in 'unit\Unitcambioplaca.pas' {frmcambioplaca},
  Unitbuscaactivos in 'unit\Unitbuscaactivos.pas' {FrmBusca},
  UnitPantallaProgreso in 'unit\UnitPantallaProgreso.pas' {frmProgresos},
  UnitVistaPreliminar in 'Unitv\UnitVistaPreliminar.pas' {frmVistaPreliminar},
  UnitCalculo in 'unit\UnitCalculo.pas' {FrmCalculo},
  UnitOtroActivo in 'unit\UnitOtroActivo.pas' {FrmOtroActivo},
  UnitClase in 'Unitv\UnitClase.pas' {FrmClase},
  UnitDatamodulo in 'unit\UnitDatamodulo.pas' {DataGeneral: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Sistema de Control de Activos';
  Application.CreateForm(TFrMain, FrMain);
  Application.CreateForm(Tfrmgeneral, frmgeneral);
  Application.Run;
end.
