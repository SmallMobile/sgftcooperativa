unit UnitErrores;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QButtons;

type
  TfrmErrorres = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    EFile: TEdit;
    SpeedButton1: TSpeedButton;
    MError: TMemo;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmErrorres: TfrmErrorres;

implementation

{$R *.xfm}

uses UnitReplicacionServer;

procedure TfrmErrorres.SpeedButton1Click(Sender: TObject);
begin
   DeleteFile(frmMain.ErrorFile);
   MError.Lines.Clear;
end;

procedure TfrmErrorres.FormActivate(Sender: TObject);
begin
  MError.Lines.Clear;
  EFile.Text := frmMain.ErrorFile;
  if FileExists(frmMain.ErrorFile) then
    MError.Lines.LoadFromFile(frmMain.ErrorFile);

end;

end.
