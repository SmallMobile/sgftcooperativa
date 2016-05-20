unit UnitReportetraslado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TFrmReptraslado = class(TForm)
    Panel1: TPanel;
    fechaini: TDateTimePicker;
    fechafin: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Reporte: TBitBtn;
    Salir: TBitBtn;
    procedure SalirClick(Sender: TObject);
    procedure ReporteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReptraslado: TFrmReptraslado;

implementation

uses UnitActivorep;

{$R *.dfm}

procedure TFrmReptraslado.SalirClick(Sender: TObject);
begin
        Self.Close;
end;

procedure TFrmReptraslado.ReporteClick(Sender: TObject);
begin
        if fechaini.Date > fechafin.Date then
          begin
          MessageDlg('La Fecha Inicial no debe ser mayor que la Fecha Final',mterror,[mbOK],0);
          Exit;
          end
        else
        begin
        FrmActivos := TFrmActivos.Create(self);
        FrmActivos.fecha_ini := DateToStr(fechaini.Date);
        FrmActivos.fecha_fin := DateToStr(fechafin.Date);
        FrmActivos.traslado;
        end;
end;

procedure TFrmReptraslado.FormCreate(Sender: TObject);
begin
        fechaini.Date := Date;
        fechafin.Date := Date;
        fechaini.MaxDate := Date;
        fechafin.MaxDate := Date;
end;

end.
