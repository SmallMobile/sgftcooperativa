unit UnitRecupera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, DBCtrls, DB, IBCustomDataSet,
  IBQuery;

type
  TFrmRecupera = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    fecha: TDateTimePicker;
    Label2: TLabel;
    dbltiponomina: TDBLookupComboBox;
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    IBQuery1: TIBQuery;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRecupera: TFrmRecupera;

implementation
uses unitdatamodulo, UnitNomina, UnitPrincipal,UnitGlobal,Unitdataquerys,
  UnitQuerys;

{$R *.dfm}

procedure TFrmRecupera.FormCreate(Sender: TObject);
begin
        IBQuery1.Open;
        IBQuery1.Last;
        dbltiponomina.KeyValue := 10;
        fecha.DateTime := Date;
end;

procedure TFrmRecupera.Button1Click(Sender: TObject);
var        fecha1 :string;
           cod_nomina :Integer;
begin
           DataQuerys := TDataQuerys.Create(self);
           fecha1 := FormatDateTime('yyyy/mm/01',fecha.DateTime);
           with DataQuerys.IBdatos do
           begin
             Close;
             SQL.Clear;
             SQL.Add('SELECT');
             SQL.Add('"nom$controlnomina"."cod_nomina"');
             SQL.Add('FROM');
             SQL.Add('"nom$controlnomina"');
             SQL.Add('WHERE');
             SQL.Add('("nom$controlnomina"."fecha" = :fecha)');
             SQL.Add('and ("nom$controlnomina"."liquidada" = 1)');
             ParamByName('fecha').AsDate := StrToDate(fecha1);
             Open;
             cod_nomina := FieldByName('cod_nomina').AsInteger;
             if RecordCount = 0 then
                Exit;
             Close;
           end;
            frmnomina := TFrmNomina.Create(self);
            verificatransaccion(FrmNomina.IBaportes);
            FrmNomina.IBtiponomina.ParamByName('codigo').AsInteger := dbltiponomina.KeyValue;
            FrmNomina.IBfechanomina.ParamByName('cod').AsInteger := cod_nomina;
            FrmNomina.IBfechanomina.Open;
            FrmNomina.IBfondos.ParamByName('tipo').AsInteger := DBLtiponomina.KeyValue;
            FrmNomina.IBfondos.ParamByName('codigo').AsInteger := cod_nomina;
            FrmNomina.IBfondos.Open;
            FrmNomina.IBaportes.ParamByName('tipo').AsInteger := DBLtiponomina.KeyValue;
            FrmNomina.IBaportes.ParamByName('codigo').AsInteger := cod_nomina;
            FrmNomina.IBaportes.Open;
            FrmNomina.IBnomina.Close;
            FrmNomina.frDBDataSet1.DataSet := FrmNomina.IBnomina1;
            FrmNomina.IBnomina1.ParamByName('codigo').AsInteger := cod_nomina;
            FrmNomina.IBnomina1.ParamByName('tiponomina').AsInteger := DBLtiponomina.KeyValue;;
            FrmNomina.IBnomina1.Open;
            FrmNomina.imprimir_reporte(frmain.wpath+'reportes\reprealizanominarec.frf');

end;

procedure TFrmRecupera.Button2Click(Sender: TObject);
begin
        Close;
end;

end.
