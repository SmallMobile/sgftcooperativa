program INVENTARIO;

uses
  Forms,
  FrmPrincipal in 'UNIT\FrmPrincipal.pas' {FrMain},
  FrmClasificacio in 'UNIT\FrmClasificacio.pas' {frmclasificacion},
  FrmDatamodulo in 'UNIT\FrmDatamodulo.pas' {DataGeneral: TDataModule},
  Entradas in 'UNIT\Entradas.pas' {fentrada},
  FrmProveedores in 'UNIT\FrmProveedores.pas' {Proveedor},
  frmDependencia in 'UNIT\frmDependencia.pas' {Dependencia},
  FrmEmpleados in 'UNIT\FrmEmpleados.pas' {empleado},
  FrmAgencia in 'UNIT\FrmAgencia.pas' {d},
  FrmArticulo in 'UNIT\FrmArticulo.pas' {Articulo},
  frmentradadatos in 'UNIT\frmentradadatos.pas' {Entrada_Articulo},
  FrmSalida in 'UNIT\FrmSalida.pas' {Salida},
  Frmreportesgenerales in 'UNIT\Frmreportesgenerales.pas' {reportes},
  seempleado in 'UNIT\seempleado.pas' {Form1},
  frmbuscaempleado in 'UNIT\frmbuscaempleado.pas' {Buscaempleado},
  FRmmantenimiento in 'UNIT\FRmmantenimiento.pas' {Mantenimiento},
  Frmelisalida in 'UNIT\Frmelisalida.pas' {eliminarsalida},
  frmsalidafecha in 'UNIT\frmsalidafecha.pas' {salidaporfecha},
  reporte in 'UNIT\reporte.pas' {ipresion},
  frmlogin in 'UNIT\frmlogin.pas' {login},
  frmrepperiodico in 'UNIT\frmrepperiodico.pas' {gastos_seccion},
  frmentradafecha in 'UNIT\frmentradafecha.pas' {conentrada},
  Frmexistencia in 'UNIT\Frmexistencia.pas' {existencia},
  FrmRepEntrada in 'UNIT\FrmRepEntrada.pas' {repentrada},
  frmrepempleado in 'UNIT\frmrepempleado.pas' {repempleado},
  frmstockminimo in 'UNIT\frmstockminimo.pas' {stockminimo},
  Consts in 'UNIT\Consts.pas',
  UnitReclasifica in 'UNIT\UnitReclasifica.pas' {FrmReclasificacion},
  UnitRepConsolidado in 'UNIT\UnitRepConsolidado.pas' {FrmRepConsolidado};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Sistema Control de Inventarios';
  Application.CreateForm(TFrMain, FrMain);
  Application.CreateForm(Tipresion, ipresion);
  Application.Run;
end.

