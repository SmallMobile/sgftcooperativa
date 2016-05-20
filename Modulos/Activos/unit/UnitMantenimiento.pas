unit UnitMantenimiento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TFrmMantenimiento = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    placa: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nombre_p: TMemo;
    GroupBox2: TGroupBox;
    Mpreventivo: TRadioButton;
    mcorrectivo: TRadioButton;
    GroupBox3: TGroupBox;
    Minterno: TRadioButton;
    Mexterno: TRadioButton;
    GroupBox4: TGroupBox;
    Panel1: TPanel;
    Aceptar: TBitBtn;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    Label5: TLabel;
    ejecutadopor: TEdit;
    Label6: TLabel;
    fecha_mantenimiento: TDateTimePicker;
    Label7: TLabel;
    valor: TEdit;
    Label8: TLabel;
    observacion: TMemo;
    procedure valorExit(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
    procedure MpreventivoKeyPress(Sender: TObject; var Key: Char);
    procedure mcorrectivoKeyPress(Sender: TObject; var Key: Char);
    procedure MinternoKeyPress(Sender: TObject; var Key: Char);
    procedure MexternoKeyPress(Sender: TObject; var Key: Char);
    procedure ejecutadoporKeyPress(Sender: TObject; var Key: Char);
    procedure fecha_mantenimientoKeyPress(Sender: TObject; var Key: Char);
    procedure valorKeyPress(Sender: TObject; var Key: Char);
    procedure observacionKeyPress(Sender: TObject; var Key: Char);
    procedure placaExit(Sender: TObject);
    procedure ejecutadoporExit(Sender: TObject);
    procedure observacionExit(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure nombre_pKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure valorEnter(Sender: TObject);
  private
        valor_real: Variant;
        cod_mantenimiento,cod_activo: Integer;
        tipo_mantenimiento,forma_mantenimiento: string;


    { Private declarations }
  public
  published
    procedure limpiar;
    procedure entra_datos;
    { Public declarations }
  end;

var
  FrmMantenimiento: TFrmMantenimiento;

implementation

uses UnitDatamodulo,unitglobal;

{$R *.dfm}

procedure TFrmMantenimiento.valorExit(Sender: TObject);
begin
        if valor.Text = '' then
           valor_real := 0
        else
          valor_real := StrToCurr(valor.Text);
          valor.Text := '$ '+ FormatCurr('#,##0.00',valor_real);
end;

procedure TFrmMantenimiento.placaKeyPress(Sender: TObject; var Key: Char);
begin
        ValidaPlaca(Self,Key);
        if Key = #13 then
          Mpreventivo.SetFocus;
end;

procedure TFrmMantenimiento.MpreventivoKeyPress(Sender: TObject;
  var Key: Char);
begin
         if Key = #13 then
          Minterno.SetFocus
end;

procedure TFrmMantenimiento.mcorrectivoKeyPress(Sender: TObject;
  var Key: Char);
begin
         if Key = #13 then
           Minterno.SetFocus;
end;

procedure TFrmMantenimiento.MinternoKeyPress(Sender: TObject;
  var Key: Char);
begin
         if Key = #13 then
           ejecutadopor.SetFocus
end;

procedure TFrmMantenimiento.MexternoKeyPress(Sender: TObject;
  var Key: Char);
begin
         if Key = #13 then
           ejecutadopor.SetFocus;
end;

procedure TFrmMantenimiento.ejecutadoporKeyPress(Sender: TObject;
  var Key: Char);
begin
         if Key = #13 then
           fecha_mantenimiento.SetFocus

end;

procedure TFrmMantenimiento.fecha_mantenimientoKeyPress(Sender: TObject;
  var Key: Char);
begin
         if Key = #13 then
           valor.SetFocus;
end;

procedure TFrmMantenimiento.valorKeyPress(Sender: TObject; var Key: Char);
begin
          Numerico(Self,Key);
         if Key = #13 then
           observacion.SetFocus;
end;

procedure TFrmMantenimiento.observacionKeyPress(Sender: TObject;
  var Key: Char);
begin
         if Key = #13 then
           Aceptar.SetFocus;
end;

procedure TFrmMantenimiento.placaExit(Sender: TObject);
var    nombre:string;
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
          cod_activo := FieldByName('cod_activo').AsInteger;
          nombre := FieldByName('descripcion').AsString;
          Close;
        end;
        if validaactivo(placa.Text) = 0 then
        begin
          if nombre='' then
          begin
             Label3.Caption := '';
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
                with DataGeneral.IBsql do
                begin
                Close;
                SQL.Clear;
                SQL.Add('select max("act$mantenimiento"."cod_mantenimiento") as codigo_mantenimiento');
                SQL.Add('from "act$mantenimiento"' );
                ExecQuery;
                cod_mantenimiento := (FieldByName('codigo_mantenimiento').AsInteger)+1;
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

procedure TFrmMantenimiento.ejecutadoporExit(Sender: TObject);
begin
        ejecutadopor.Text := UpperCase(ejecutadopor.Text);
end;

procedure TFrmMantenimiento.observacionExit(Sender: TObject);
begin
        observacion.Text := UpperCase(observacion.Text);
end;

procedure TFrmMantenimiento.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmMantenimiento.limpiar;
begin
        placa.Text := '';
        Label3.Caption := '';
        nombre_p.Text := '';
        ejecutadopor.Text := '';
        valor.Text := '';
        observacion.Text := '';
        placa.SetFocus;
end;

procedure TFrmMantenimiento.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmMantenimiento.entra_datos;
begin
        if Mpreventivo.Checked = True then
           tipo_mantenimiento := 'PREVENTIVO'
        else
           tipo_mantenimiento := 'CORRECTIVO';

        if Minterno.Checked = True then
           forma_mantenimiento := 'INTERNO'
        else
           forma_mantenimiento := 'EXTERNO';

        with DataGeneral.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "act$mantenimiento" ');
          SQL.Add('values (');
          SQL.Add(':"cod_mantenimiento",:"cod_activo",:"fecha"');
          SQL.Add(',:"descripcion",:"ejecutadopor",:"costo",:"tipo_mantenimiento"');
          SQL.Add(',:"forma_mantenimiento")');
          ParamByName('cod_mantenimiento').AsInteger := cod_mantenimiento;
          ParamByName('cod_activo').AsInteger := cod_activo;
          ParamByName('fecha').AsDate := fecha_mantenimiento.DateTime;
          ParamByName('descripcion').AsString := observacion.Text;
          ParamByName('ejecutadopor').AsString := ejecutadopor.Text;
          ParamByName('costo').AsCurrency := valor_real;
          ParamByName('tipo_mantenimiento').AsString := tipo_mantenimiento;
          ParamByName('forma_mantenimiento').AsString := forma_mantenimiento;
          Open;
          Close;
        end;


end;
procedure TFrmMantenimiento.AceptarClick(Sender: TObject);
begin
        if valor.Text = '' then
           valor_real := 0;
        entra_datos;
        DataGeneral.IBTransaction1.CommitRetaining;
        limpiar;
end;

procedure TFrmMantenimiento.nombre_pKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          Mpreventivo.SetFocus;
end;

procedure TFrmMantenimiento.FormCreate(Sender: TObject);
begin
        fecha_mantenimiento.DateTime := date
end;

procedure TFrmMantenimiento.valorEnter(Sender: TObject);
begin
        valor.Text := '';
end;
end.
