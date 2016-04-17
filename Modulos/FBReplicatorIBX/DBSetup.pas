unit DBSetup;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TSetupDB = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure OKBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetupDB: TSetupDB;

implementation

{$R *.DFM}

procedure TSetupDB.OKBtnClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TSetupDB.CancelBtnClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
