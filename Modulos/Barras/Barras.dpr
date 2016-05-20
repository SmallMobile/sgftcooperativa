program Barras;

uses
  Forms,
  UnitBarra in 'UnitBarra.pas' {Form1},
  FR_BarC in 'C:\Archivos de programa\FastReports\FastReport\source\FR_BarC.pas' {frBarCodeForm},
  Consts in '\\Winserver\repositorio\sistemas\units\Consts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
