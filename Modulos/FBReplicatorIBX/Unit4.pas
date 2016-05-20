unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  Terrordialog = class(TForm)
    Panel1: TPanel;
    MError: TMemo;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    EFile: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  errordialog: Terrordialog;

implementation

uses MainForm;

{$R *.DFM}

procedure Terrordialog.FormActivate(Sender: TObject);
begin
  MError.Lines.Clear;
  EFile.Text := main.ErrorFile;
  if FileExists(main.ErrorFile) then
    MError.Lines.LoadFromFile(main.ErrorFile);
end;

procedure Terrordialog.Button1Click(Sender: TObject);
begin
   DeleteFile(main.ErrorFile);
   MError.Lines.Clear;
end;

end.
