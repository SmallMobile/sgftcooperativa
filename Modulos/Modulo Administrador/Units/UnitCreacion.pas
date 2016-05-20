unit UnitCreacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TFrmCreacion = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdNombre: TEdit;
    EdPrimer: TEdit;
    EdSegundo: TEdit;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EdNombreKeyPress(Sender: TObject; var Key: Char);
    procedure EdPrimerKeyPress(Sender: TObject; var Key: Char);
    procedure EdSegundoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCreacion: TFrmCreacion;

implementation
uses UnitGlobal;
{$R *.dfm}

procedure TFrmCreacion.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmCreacion.BitBtn1Click(Sender: TObject);
begin
        vNombre := EdNombre.Text;
        pApellido := EdPrimer.Text;
        sApellido := EdSegundo.Text;
        Close;
end;

procedure TFrmCreacion.EdNombreKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           EdPrimer.SetFocus
end;

procedure TFrmCreacion.EdPrimerKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           EdSegundo.SetFocus

end;

procedure TFrmCreacion.EdSegundoKeyPress(Sender: TObject; var Key: Char);
begin
       if Key = #13 then
         BitBtn1.SetFocus;

end;

end.
