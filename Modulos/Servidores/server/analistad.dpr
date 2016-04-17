program analistad;

uses
  QForms,
  UnitAnalista_respuesta in 'Units/UnitAnalista_respuesta.pas' {FrmServer_Analistas},
  ZLibStream in '../compress/ZLibStream.pas',
  ZLib in '../compress/ZLib.pas';


{$E .exe}

{$R *.res}

begin
  Application.Initialize;
 Application.CreateForm(TFrmServer_Analistas, FrmServer_Analistas);
   Application.Run;
end.
