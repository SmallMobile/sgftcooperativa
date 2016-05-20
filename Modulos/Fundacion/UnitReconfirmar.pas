unit UnitReconfirmar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmReconfirmar = class(TForm)
    BtnCancelar: TBitBtn;
    BtnAceptar: TBitBtn;
    Label2: TLabel;
    EdPasabordo: TEdit;
    asas: TPanel;
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;

  public
    { Public declarations }
  end;

var
  frmReconfirmar: TfrmReconfirmar;

implementation

{$R *.dfm}

uses UnitPrincipal;
procedure TfrmReconfirmar.CreateParams(var Params: TCreateParams);
begin
end;

end.
