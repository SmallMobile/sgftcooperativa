program SaldosCap;

uses
  Forms,
  UnitTrasladoSaldos in 'Units\UnitTrasladoSaldos.pas' {frmTrasladoSaldos};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTrasladoSaldos, frmTrasladoSaldos);
  Application.Run;
end.
