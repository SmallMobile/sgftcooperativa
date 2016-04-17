unit UnitRecuperaHoras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons;

type
  TFrmRecuperaHora = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    fecha1: TDateTimePicker;
    fecha2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRecuperaHora: TFrmRecuperaHora;

implementation

uses UnitNomina, UnitQuerys, UnitGlobal;

{$R *.dfm}

procedure TFrmRecuperaHora.BitBtn1Click(Sender: TObject);
begin
        if fecha1.DateTime > fecha2.DateTime then
           fecha1.DateTime := fecha2.DateTime;
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('MAX("nom$controlnomina"."cod_nomina") AS "nomina2",');
          SQL.Add('MIN("nom$controlnomina"."cod_nomina") AS "nomina1"');
          SQL.Add('FROM');
          SQL.Add('"nom$controlnomina"');
          SQL.Add('WHERE');
          SQL.Add('("nom$controlnomina"."fecha" BETWEEN :fecha1 AND :fecha2)');
//          SQL.Add('("nom$controlnomina"."liquidada" = 1)');
          ParamByName('fecha1').AsDateTime := fecha1.DateTime;
          ParamByName('fecha2').AsDateTime := fecha2.DateTime;
          Open;
          FrmNomina := TFrmNomina.Create(Self);
          FrmNomina.nomina_ini := FieldByName('nomina1').AsInteger;
          FrmNomina.nomina_fin := FieldByName('nomina2').AsInteger;
          FrmNomina.extrae_horas;
          Close;
        end;

end;

procedure TFrmRecuperaHora.FormCreate(Sender: TObject);
begin
        fecha1.Date := StrToDate(FormatDateTime('yyyy/'+'01/01',Date));
        fecha2.Date := Date;
end;

end.
