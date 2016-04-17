unit UnitLogin;

interface

uses
  Windows, Messages, SysUtils,Qt, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  Tlogin = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    usuario: TEdit;
    Label2: TLabel;
    password: TEdit;
    aceptar: TBitBtn;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure usuarioKeyPress(Sender: TObject; var Key: Char);
    procedure passwordKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  login: Tlogin;

implementation

{$R *.dfm}

procedure Tlogin.BitBtn1Click(Sender: TObject);
begin
        Application.Terminate;
end;

procedure Tlogin.usuarioKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 Then
           password.SetFocus;
        if Key = #27  then
           Application.Terminate;
end;

procedure Tlogin.passwordKeyPress(Sender: TObject; var Key: Char);
begin

        if key = #13 then
           aceptar.Click;
        if Key = #27  then
           Application.Terminate;
end;

procedure Tlogin.FormShow(Sender: TObject);
begin
        usuario.SetFocus;
end;

end.
