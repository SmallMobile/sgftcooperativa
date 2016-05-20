unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cmpTrayIcon, IdBaseComponent, IdComponent, IdTCPServer,
  IdTimeServer, StdCtrls, Buttons, IdThreadMgr, IdThreadMgrDefault;

type
  TForm1 = class(TForm)
    IdTimeServer1: TIdTimeServer;
    TrayIcon1: TTrayIcon;
    BitBtn1: TBitBtn;
    IdThreadMgrDefault1: TIdThreadMgrDefault;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
