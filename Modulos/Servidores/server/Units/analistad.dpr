program analistad;

uses
  QForms,
  UnitAnalista_respuesta in 'UnitAnalista_respuesta.pas' {FrmServer_Analistas};

{$E .exe}

{$R *.res}

begin
  Application.Initialize;
Application.CreateForm(TFrmServer_Analistas, FrmServer_Analistas);
   Application.Run;
end.
