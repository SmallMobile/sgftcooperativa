unit UnitDescuentoExtra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFrmDescuentoExtra = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    empleado: TComboBox;
    seccion: TEdit;
    nomina: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDescuentoExtra: TFrmDescuentoExtra;

implementation

{$R *.dfm}

end.
