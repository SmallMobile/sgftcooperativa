unit UnitRepConsolidado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, FR_DSet, FR_DBSet, DB,
  IBCustomDataSet, IBQuery, FR_Class, DBClient;

type
  TFrmRepConsolidado = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    FECHA1: TDateTimePicker;
    FECHA2: TDateTimePicker;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    frReport1: TfrReport;
    IBQuery1: TIBQuery;
    frDBDataSet1: TfrDBDataSet;
    CdDatos: TClientDataSet;
    CdDatosagencia: TStringField;
    CdDatosclasificacion: TStringField;
    CdDatosvalor: TCurrencyField;
    CdDatosid_agencia: TIntegerField;
    CdDatosid_clasificacion: TIntegerField;
    CdSum: TClientDataSet;
    CdSumid_agencia: TIntegerField;
    CdSumdescripcion: TStringField;
    CdSumvalor: TCurrencyField;
    CdSumclasificacion: TStringField;
    IBQuery2: TIBQuery;
    CdDatossuma: TAggregateField;
    frDBDataSet2: TfrDBDataSet;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRepConsolidado: TFrmRepConsolidado;

implementation

{$R *.dfm}

procedure TFrmRepConsolidado.BitBtn1Click(Sender: TObject);
var    sentencia :string;
begin
        with IBQuery1 do
        begin
          Close;
          ParamByName('FECHA1').AsDate := FECHA1.Date;
          ParamByName('FECHA2').AsDate := FECHA2.Date;
          Open;
          while not Eof do
          begin
            CdDatos.Append;
            CdDatos.FieldValues['agencia'] := FieldByName('descripcion1').AsString;
            CdDatos.FieldValues['id_agencia'] := FieldByName('cod_agencia').AsInteger;
            CdDatos.FieldValues['clasificacion'] := FieldByName('descripcion').AsString;
            CdDatos.FieldValues['id_clasificacion'] := FieldByName('cod_clasificacion').AsInteger;
            CdDatos.FieldValues['valor'] := FieldByName('VALOR').AsCurrency;
            CdDatos.Post;
            Next;
          end;
        end;
        with IBQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select * from "Inv$Agencia"');
          Open;
          while not Eof do
          begin
            CdDatos.Filtered := False;
            sentencia := 'id_clasificacion = 3000 and id_agencia = ' + FieldByName('cod_agencia').AsString;
            //ShowMessage(sentencia);
            CdDatos.Filter := sentencia;
            CdDatos.Filtered := True;
            CdDatos.AggregatesActive := True;
            CdSum.Append;
            CdSum.FieldValues['id_agencia'] := FieldByName('cod_agencia').AsInteger;
            CdSum.FieldValues['descripcion'] := FieldByName('descripcion').AsString;
            CdSum.FieldValues['clasificacion'] := 'PAPELERIA';
            CdSum.FieldValues['valor'] := CdDatos.FieldByName('suma').AsVariant;
            CdSum.Post;
            CdDatos.Filtered := False;
            CdDatos.Filter := 'id_clasificacion = 4000 and id_agencia = ' + FieldByName('cod_agencia').AsString;
            CdDatos.Filtered := True;
            CdDatos.AggregatesActive := True;
            CdSum.Append;
            CdSum.FieldValues['id_agencia'] := FieldByName('cod_agencia').AsInteger;
            CdSum.FieldValues['descripcion'] := FieldByName('descripcion').AsString;
            CdSum.FieldValues['clasificacion'] := 'UTILES';
            CdSum.FieldValues['valor'] := CdDatos.FieldByName('suma').AsVariant;
            CdSum.Post;
            Next;
          end;
        end;
        if frReport1.PrepareReport then
           frReport1.ShowReport
end;

procedure TFrmRepConsolidado.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmRepConsolidado.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'fecha1' then
           ParValue := FECHA1.Date;
        if ParName = 'fecha2' then
           ParValue := FECHA2.Date;
        if ParName = 'empresa' then
           ParValue := 'CREDISERVIR Ltda. Nit. 890.505.363-6';
end;

end.
