program PUC;

uses
  QForms,
  unitpasopuccon in 'unitpasopuccon.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmImportarPuc, frmImportarPuc);
  Application.Run;
end.
