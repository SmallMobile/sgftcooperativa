unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    FUltimaActividad: TDateTime;
    procedure AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
begin
 case Msg.Message of
    WM_KEYFIRST..WM_KEYLAST,
    WM_LBUTTONDOWN..WM_MOUSELAST: FUltimaActividad := Now;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Self.Caption := 'Cerrar la aplicación después de un período de inactividad';
  Application.OnMessage := AtraparMensajes;
  FUltimaActividad := Now;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
const
  ESPERA = (1 / 24 / 60 / 4);  // 15 segundos
begin
  if (FUltimaActividad + ESPERA) < Now Then
    Close;
  StatusBar1.SimpleText := Format('Cierre en: %s',
    [FormatDateTime('hh:mm:ss', Now - FUltimaActividad - ESPERA)]);
end;

end.
