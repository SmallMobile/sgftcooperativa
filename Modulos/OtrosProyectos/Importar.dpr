program Importar;

uses
  Forms,
  UnitImportar in 'UnitImportar.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
