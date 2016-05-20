program servercajas;

uses
  QForms,
  Unitservercajas in 'Units\Unitservercajas.pas' {Frmservercajas};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmservercajas, Frmservercajas);
  Application.Run;
end.
