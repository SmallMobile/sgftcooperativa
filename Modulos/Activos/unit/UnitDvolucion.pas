unit UnitDvolucion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmDevolucion = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    placa: TEdit;
    nombre_p: TMemo;
    Panel1: TPanel;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    Aceptar: TBitBtn;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    estado: TEdit;
    procedure placaExit(Sender: TObject);
  private
  cod_activo,cod_traslado:Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDevolucion: TFrmDevolucion;

implementation

uses UnitDatamodulo;

{$R *.dfm}

procedure TFrmDevolucion.placaExit(Sender: TObject);
begin
  with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$activo"."descripcion",');
          SQL.Add('"act$activo"."cod_activo"');
          SQL.Add('from "act$activo"');
          SQL.Add('where "act$activo"."placa" = :"placa"');
          ParamByName('placa').AsString:=placa.Text;
          Open;
          cod_activo:=FieldByName('cod_activo').AsInteger;
          nombre_p.Text:=FieldByName('descripcion').AsString;
          Close;
        end;
        if cod_activo > 0 then
        begin
          with DataGeneral.IBsql do
             begin
             Close;
             SQL.Clear;
             SQL.Add('select  "act$traslado"."cod_traslado","act$traslado"."fecha_reintegro"');
             SQL.Add(' ,"act$traslado"."fecha_traslado" from "act$traslado" where "act$traslado"."cod_traslado" =');
             SQL.Add(' (select max("act$traslado"."cod_traslado") from "act$traslado"');
             SQL.Add('where "act$traslado"."cod_activo" = :"codigo")');
             ParamByName('codigo').AsInteger:=cod_activo;
             ExecQuery;
             Label9.Caption:=FieldByName('fecha_reintegro').AsString;
             Label10.Caption:=FieldByName('fecha_traslado').AsString;
             Close;
             end;

          with DataGeneral.IBdatos do
          begin
            Close;
            SQL.Clear;
            SQL.Add('Select "inv$dependencia"."nombre"');
            SQL.Add('from "inv$dependencia","inv$empleado","act$traslado"');
            SQL.Add('where "act$traslado"."nit_empleado"="inv$empleado"."nit" and');
            SQL.Add('"inv$empleado"."cod_dependencia"="inv$dependencia"."cod_dependencia" and');
            SQL.Add('"act$traslado"."cod_traslado" = (');
            SQL.Add('select max("act$traslado"."cod_traslado") from "act$traslado"');
            SQL.Add('where "act$traslado"."cod_activo" = :"codigo")');
            ParamByName('codigo').AsInteger:=cod_activo;
            Open;
            Label3.Caption:=FieldByName('nombre').AsString;
            Close;
          end;
          with DataGeneral.IBsql do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select max("act$traslado"."cod_traslado") as cod_traslado');
            SQL.Add('from "act$traslado"' );
            ExecQuery;
            cod_traslado:=(FieldByName('cod_traslado').AsInteger)+1;
            Close;
          end;
        end
        else
        begin
          ShowMessage('No Existe el Activo');
          placa.SetFocus;
        end;

end;

end.
