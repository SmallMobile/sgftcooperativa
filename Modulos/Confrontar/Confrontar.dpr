program Confrontar;

uses
  Forms,
  UnitConfrontar in 'UnitConfrontar.pas' {frmConfrontar};
  //DataSetToExcel in '\\winserver\Repositorio\Sistemas\units\DataSetToExcel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmConfrontar, frmConfrontar);
  Application.Run;
end.
