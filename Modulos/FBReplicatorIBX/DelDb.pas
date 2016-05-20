unit DelDb;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TDelDBDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DbPath: string[255];
  end;

var
  DelDBDlg: TDelDBDlg;

implementation

{$R *.DFM}

procedure TDelDBDlg.OKBtnClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TDelDBDlg.CancelBtnClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TDelDBDlg.FormShow(Sender: TObject);
begin
  Edit1.Text := DbPath;
end;

end.
