unit UnitCuadro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmCuadro = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCuadro: TFrmCuadro;

implementation

{$R *.dfm}

procedure TFrmCuadro.BitBtn1Click(Sender: TObject);
begin
        Close;
end;

end.
