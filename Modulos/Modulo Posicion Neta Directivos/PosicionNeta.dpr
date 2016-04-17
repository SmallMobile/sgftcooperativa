program PosicionNeta;

uses
  Forms,
  UnitPosicionNeta in 'UnitPosicionNeta.pas' {frmPosicionNeta};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPosicionNeta, frmPosicionNeta);
  Application.Run;
end.
