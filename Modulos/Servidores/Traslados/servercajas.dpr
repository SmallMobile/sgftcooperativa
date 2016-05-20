program servercajas;

uses
  QForms,
  Unitservercajas in 'Units/Unitservercajas.pas' {Frmservercajas},
  ZLib in '../compress/ZLib.pas',
  ZLibStream in '../compress/ZLibStream.pas';


{$R *.res}

begin
  Application.Initialize;Application.Title := 'Servidor de Cajas';
  Application.CreateForm(TFrmservercajas, Frmservercajas);
   Application.Run;
end.
