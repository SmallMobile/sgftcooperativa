unit AppTrig;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TOKTrigDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OKTrigDlg: TOKTrigDlg;

implementation

{$R *.DFM}

procedure TOKTrigDlg.OKBtnClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TOKTrigDlg.CancelBtnClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
