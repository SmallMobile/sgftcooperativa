unit rasform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Rascomp32, ExtCtrls;

type
  Tdialer = class(TForm)
    RAS1: TRAS;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure RAS1Connect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    IsConnected : Boolean;
    REntryName : string;
    RUserName : string;
    RPassword : string;
  end;

var
  dialer: Tdialer;

implementation

{$R *.DFM}

procedure Tdialer.Timer1Timer(Sender: TObject);
begin
   Timer1.Enabled := False;
   Ras1.Disconnect;
   dialer.Close;
end;

procedure Tdialer.RAS1Connect(Sender: TObject);
begin
   IsConnected := True;
   dialer.Close;
end;

procedure Tdialer.FormCreate(Sender: TObject);
begin
   IsConnected := False;
end;

procedure Tdialer.FormShow(Sender: TObject);
begin
   Timer1.Enabled := True;
   Ras1.EntryName := REntryName;
   Ras1.UserName := RUserName;
   Ras1.Password := RPassword;
   dialer.Caption := 'Connecting to ' + Ras1.EntryName;
   Ras1.Connect;
end;

end.
