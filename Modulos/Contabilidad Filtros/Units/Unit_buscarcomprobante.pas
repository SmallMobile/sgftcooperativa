unit Unit_buscarcomprobante;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls;

type
  Tfrmbuscarcomprobante = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    EditCODIGO: TMaskEdit;
    Panel3: TPanel;
    BtnAceptar: TBitBtn;
    BtnCancelar: TBitBtn;
    procedure EditCODIGOKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmbuscarcomprobante: Tfrmbuscarcomprobante;

implementation

{$R *.dfm}


procedure Tfrmbuscarcomprobante.EditCODIGOKeyPress(Sender: TObject;
  var Key: Char);
begin
        if key = #13 then
        BtnAceptar.SetFocus;
end;

end.
