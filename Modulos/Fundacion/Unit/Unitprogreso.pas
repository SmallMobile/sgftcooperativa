unit Unitprogreso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Gauges, StdCtrls, ExtCtrls, JvSpecialProgress,
  JvComponent, JvAnimTitle;

type
  TFrmProgreso = class(TForm)
    Barra: TJvSpecialProgress;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProgreso: TFrmProgreso;

implementation

{$R *.dfm}

end.
