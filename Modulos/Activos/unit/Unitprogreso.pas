unit Unitprogreso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Gauges, StdCtrls, ExtCtrls;

type
  TFrmProgreso = class(TForm)
    barraprogreso: TGauge;
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
