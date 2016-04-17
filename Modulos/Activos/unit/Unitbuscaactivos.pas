unit Unitbuscaactivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TFrmBusca = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    fecha1: TDateTimePicker;
    fecha2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBusca: TFrmBusca;

implementation

uses UnitActivorep;

{$R *.dfm}

procedure TFrmBusca.BitBtn1Click(Sender: TObject);
begin
        FrmActivos := TFrmActivos.Create(self);
        FrmActivos.fecha_ini := DateToStr(fecha1.Date);
        FrmActivos.fecha_fin := DateToStr(fecha2.Date);

        FrmActivos.actdebaja;
end;

end.
