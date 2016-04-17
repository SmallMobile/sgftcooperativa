program CierreSucursal;

uses
  Forms,
  UnitCierreSucursal in 'Units\UnitCierreSucursal.pas' {FrmCierreSucursal};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmCierreSucursal, FrmCierreSucursal);
  Application.Run;
end.
