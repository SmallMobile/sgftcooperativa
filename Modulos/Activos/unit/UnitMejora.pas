unit UnitMejora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, JvEdit, JvTypedEdit;

type
  TFrmMejora = class(TForm)
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
    Label5: TLabel;
    Label6: TLabel;
    fecha: TDateTimePicker;
    Label7: TLabel;
    Descripcion: TMemo;
    valor: TJvCurrencyEdit;
    procedure placaExit(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
    procedure ValorKeyPress(Sender: TObject; var Key: Char);
    procedure DescripcionKeyPress(Sender: TObject; var Key: Char);
    procedure fechaKeyPress(Sender: TObject; var Key: Char);
    procedure CancelarClick(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  cod_activo,cod_mejora: Integer;

    { Private declarations }
  public
  published
    procedure limpiar;
    procedure entra_datos;
    { Public declarations }
  end;

var
  FrmMejora: TFrmMejora;

implementation

uses UnitDatamodulo,unitglobal;

{$R *.dfm}

procedure TFrmMejora.placaExit(Sender: TObject);
var       nombre:string;
begin
        nombre_p.Text := '';
        Label3.Caption := '';
         with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$activo"."descripcion",');
          SQL.Add('"act$activo"."cod_activo"');
          SQL.Add('from "act$activo"');
          SQL.Add('where "act$activo"."placa" = :"placa"');
          ParamByName('placa').AsString := placa.Text;
          Open;
          cod_activo := FieldByName('cod_activo').AsInteger;
          nombre := FieldByName('descripcion').AsString;
          Close;
        end;

        if validaactivo(placa.Text) = 0 then
        begin
        if nombre = '' then
        begin
          MessageDlg('El Activo no se Encuentra en la Base de Datos',mtInformation,[mbOK],0);
          placa.SetFocus;
          end
        else
        begin
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
            SQL.Add('where "act$traslado"."cod_activo" = :"codigo" and');
            SQL.Add('"act$traslado"."forma_traslado"=:"def")');
            ParamByName('codigo').AsInteger := cod_activo;
            parambyname('def').AsString := 'DEFINITIVO';
            Open;
            Label3.Caption := FieldByName('nombre').AsString;
            nombre_p.Text := nombre;
            Close;
          end;
          with DataGeneral.IBsel1 do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select max("act$mejora"."cod_mejora") as codigo');
            SQL.Add('from "act$mejora"');
            Open;
            cod_mejora := (FieldByName('codigo').AsInteger)+1;
            Close;
            end;
            end;
          end
           else
        begin
         MessageDlg('El Activo Fue Dado de Baja',mtInformation,[mbOK],0);
         Label3.Caption := '';
         nombre_p.Text := '';
         placa.SetFocus;
        end;
end;

procedure TFrmMejora.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmMejora.placaKeyPress(Sender: TObject; var Key: Char);
begin
       ValidaPlaca(Self,Key);
       if Key = #13 then
        Valor.SetFocus;
end;

procedure TFrmMejora.ValorKeyPress(Sender: TObject; var Key: Char);
begin

        if Key = #13 then
          fecha.SetFocus;
end;

procedure TFrmMejora.DescripcionKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          Aceptar.SetFocus;
end;

procedure TFrmMejora.fechaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          Descripcion.SetFocus;
end;

procedure TFrmMejora.limpiar;
begin
        placa.Text := '';
        Label3.Caption := '';
        nombre_p.Text := '';
        Valor.Text := '';
        Descripcion.Text := '';
        placa.SetFocus;
end;

procedure TFrmMejora.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmMejora.entra_datos;
begin
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "act$mejora"');
          SQL.Add('values (');
          SQL.Add(':"cod_mejora",:"cod_activo",:"descripcion"');
          SQL.Add(',:"valor_mejora",:"fecha")');
          ParamByName('cod_mejora').AsInteger := cod_mejora;
          ParamByName('cod_activo').AsInteger := cod_activo;
          ParamByName('descripcion').AsString := Descripcion.Text;
          ParamByName('valor_mejora').AsCurrency := valor.Value;
          ParamByName('fecha').AsDate := fecha.DateTime;
          Open;
          Close;
        end;
        DataGeneral.IBTransaction1.CommitRetaining;
end;

procedure TFrmMejora.AceptarClick(Sender: TObject);
begin
        entra_datos;
        limpiar;
end;

procedure TFrmMejora.FormCreate(Sender: TObject);
begin
        fecha.DateTime:=Date;
end;

end.
