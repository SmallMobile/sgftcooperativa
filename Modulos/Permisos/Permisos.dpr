program Permisos;

uses
  Forms,
  Unitpermisos in 'Unitpermisos.pas' {FrmPermisos};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPermisos, FrmPermisos);
  Application.Run;
end.
