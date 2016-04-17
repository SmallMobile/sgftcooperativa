program AyudaManual;

uses
  Forms,
  UnitAyudaManual in 'UnitAyudaManual.pas' {FrmAyudaManual};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmAyudaManual, FrmAyudaManual);
  Application.Run;
end.
