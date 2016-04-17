program CambioFecha;

uses
  Forms,
  UnitCambioFecha in 'UnitCambioFecha.pas' {Form1},
  UnitCuadro in '\\Winserver\repositorio\sistemas\Modulos\Consulta\UnitCuadro.pas' {FrmCuadro},
  Consts in '\\Winserver\repositorio\sistemas\units\Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFrmCuadro, FrmCuadro);
  Application.Run;
end.
