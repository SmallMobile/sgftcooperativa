program pPlanos;

uses
  Forms,
  uForm in 'uForm.pas' {frmPlanoSiplaft},
  uDatos in 'uDatos.pas' {DataModule4: TDataModule},
  UnitImportar in 'UnitImportar.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPlanoSiplaft, frmPlanoSiplaft);
  Application.CreateForm(TDataModule4, DataModule4);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
