program Consulta;

uses
  Forms,
  UnitMain in 'UnitMain.pas' {FrmMain},
  UnitCuadro in 'UnitCuadro.pas' {FrmCuadro},
  DataSetToExcel in '\\Winserver\repositorio\sistemas\units\DataSetToExcel.pas',
  Consts in '\\Winserver\repositorio\sistemas\units\Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
