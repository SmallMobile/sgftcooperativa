unit UnitCalculo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, ComCtrls, Buttons, dateutils, DB,
  IBCustomDataSet, IBQuery, IBDatabase;

type
  TFrmCalculo = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Fecha2: TDateTimePicker;
    Fecha1: TDateTimePicker;
    Agencia: TDBLookupComboBox;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    IBQuery1: TIBQuery;
    DataSource1: TDataSource;
    IBTransaction1: TIBTransaction;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Fecha1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCalculo: TFrmCalculo;

implementation

uses UnitActivorep;

{$R *.dfm}

procedure TFrmCalculo.BitBtn1Click(Sender: TObject);
begin
        FrmActivos := TFrmActivos.Create(Self);
        FrmActivos.fecha1 := Fecha1.Date;
        FrmActivos.fecha2 := Fecha2.Date;
        FrmActivos.calcula_dep
end;

procedure TFrmCalculo.FormCreate(Sender: TObject);
begin
        Fecha1.DateTime := Date;
        Fecha2.DateTime := Date;
        IBQuery1.Open;
        IBQuery1.Last;
        Agencia.KeyValue := 1;
end;

procedure TFrmCalculo.Fecha1Exit(Sender: TObject);
begin
        if Fecha1.DateTime > Fecha2.DateTime then
           Fecha1.DateTime := Fecha2.DateTime;
end;

end.
