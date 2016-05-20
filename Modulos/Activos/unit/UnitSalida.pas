unit UnitSalida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TFrmSalida = class(TForm)
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
    Rventa: TRadioButton;
    rDonacion: TRadioButton;
    RDestruccion: TRadioButton;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    valor_actual: TEdit;
    Label6: TLabel;
    Precio_venta: TEdit;
    Label7: TLabel;
    fecha_salida: TDateTimePicker;
    Label8: TLabel;
    ubicacion: TEdit;
    Label9: TLabel;
    motivo: TMemo;
    Label10: TLabel;
    Label11: TLabel;
    procedure placaExit(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
    procedure RDestruccionKeyPress(Sender: TObject; var Key: Char);
    procedure rDonacionKeyPress(Sender: TObject; var Key: Char);
    procedure RventaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Precio_ventaEnter(Sender: TObject);
    procedure Precio_ventaExit(Sender: TObject);
    procedure Precio_ventaKeyPress(Sender: TObject; var Key: Char);
    procedure fecha_salidaKeyPress(Sender: TObject; var Key: Char);
    procedure ubicacionKeyPress(Sender: TObject; var Key: Char);
    procedure motivoKeyPress(Sender: TObject; var Key: Char);
    procedure SalirClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure RventaClick(Sender: TObject);
    procedure rDonacionClick(Sender: TObject);
    procedure RDestruccionClick(Sender: TObject);
    procedure valor_actualExit(Sender: TObject);
    procedure valor_actualKeyPress(Sender: TObject; var Key: Char);
    procedure valor_actualEnter(Sender: TObject);
  private
  cod_salida,cod_activo,tipo_salida,vida_activo:Integer;
  valor_real,valor_venta,valor_depreciacion,valor_compra: Variant;
  fecha_real: string;
    { Private declarations }
  public
  published
    procedure limpiar;
    procedure entra_datos;
    procedure actualizar;
    { Public declarations }
  end;

var
  FrmSalida: TFrmSalida;

implementation

uses UnitDatamodulo,unitglobal;

{$R *.dfm}

procedure TFrmSalida.placaExit(Sender: TObject);
var    nombre,defineactivo:string;
       valida,valida1:Integer;
begin
        Label5.Caption := 'Valor Actual';
        Label10.Visible := True;
        Label11.Visible := True;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$activo"."descripcion",');
          SQL.Add('"act$activo"."cod_activo","act$activo"."vidadepreciable",');
          SQL.Add('"act$activo"."preciocompra" from "act$activo"');
          SQL.Add('where "act$activo"."placa" = :"placa"');
          ParamByName('placa').AsString:=placa.Text;
          Open;
          cod_activo := FieldByName('cod_activo').AsInteger;
          nombre := FieldByName('descripcion').AsString;
          vida_activo := FieldByName('vidadepreciable').AsInteger;
          valor_compra := FieldByName('preciocompra').AsCurrency;
          Close;
        end;
        defineactivo := devuelve(placa.Text);// define si se trata de un activo o un elemento de trabajo
        if validaactivo(placa.Text) = 0 then
          begin
          if nombre ='' then
          begin
            Label3.Caption := '';
            ShowMessage('El Activo no se Encuetra en la Base de Datos');
            placa.SetFocus;
            Exit;
          end
          else if defineactivo = 'NA-' then
          begin
            valor_real := valor_compra;
            valor_actual.Text := '$' + FormatCurr('#,##0.00',valor_real);
            Label5.Caption := 'Valor Compra';
            Label10.Visible := False;
            Label11.Visible := False;
          end
          else
          begin
            valida := StrToInt(deprecia(placa.Text,'11'));
            valida1 := StrToInt(deprecia(placa.Text,'8'));
            valor_depreciacion := StrToCurr(deprecia(placa.Text,'9'));// valor_compra/vida_activo;
            fecha_real := deprecia(placa.Text,'12');
            if validafecha then
              valor_real := StrToCurr(deprecia(placa.Text,'10'))
            else
            begin
              valida1 := valida1-1;
              valor_real := valor_depreciacion*(valida-valida1);
            end;
            if valor_real <= 0 then
               valor_real := 0;
               valor_actual.Text := '$'+FormatCurr('#,##0.00',valor_real);
               if valida <= valida1 then
                 Label11.Caption := 'Activo Totalmente Depreciado'
               else
                 Label11.Caption := 'Activo Parcialmente Depreciado';
            end;
          end
          else
          begin
            ShowMessage('El Activo Fue Dado de Baja');
            Label3.Caption := '';
            nombre_p.Text := '';
            placa.SetFocus;
            Exit;
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
            SQL.Add('select max("act$salida_activo"."cod_salida") as codigo_salida');
            SQL.Add('from "act$salida_activo"' );
            ExecQuery;
            cod_salida := (FieldByName('codigo_salida').AsInteger)+1;
            Close;
           end;
end;

procedure TFrmSalida.placaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          RDestruccion.SetFocus;
end;

procedure TFrmSalida.RDestruccionKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
        begin
        if Precio_venta.Visible = True then
          Precio_venta.SetFocus
        else
          fecha_salida.SetFocus
        end;
end;

procedure TFrmSalida.rDonacionKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
        begin
          if Precio_venta.Visible = True then
            Precio_venta.SetFocus
          else
            fecha_salida.SetFocus
        end;
end;

procedure TFrmSalida.RventaKeyPress(Sender: TObject; var Key: Char);
begin
       if Key = #13 then
        begin
          if Precio_venta.Visible = True then
            Precio_venta.SetFocus
          else
            fecha_salida.SetFocus
        end;
end;

procedure TFrmSalida.FormCreate(Sender: TObject);
begin
        valor_real := 0;
        valor_venta := 0;
        fecha_salida.DateTime := Date;
        fecha_salida.MaxDate := StrToDate(FormatDateTime('yyyy/mm/dd',Date));
end;

procedure TFrmSalida.Precio_ventaEnter(Sender: TObject);
begin
        Precio_venta.Text := '';
end;

procedure TFrmSalida.Precio_ventaExit(Sender: TObject);
begin
        if precio_venta.Text = '' then
           valor_venta := 0
        else
          valor_venta := StrToCurr(precio_venta.Text);
          precio_venta.Text := '$' + FormatCurr('#,##0.00',valor_venta);
end;

procedure TFrmSalida.Precio_ventaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          fecha_salida.SetFocus;
end;

procedure TFrmSalida.fecha_salidaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          ubicacion.SetFocus;
end;

procedure TFrmSalida.ubicacionKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          motivo.SetFocus;
end;

procedure TFrmSalida.motivoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          Aceptar.SetFocus
end;

procedure TFrmSalida.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmSalida.limpiar;
begin
        placa.Text := '';
        Label3.Caption := '';
        nombre_p.Text := '';
        Label11.Caption := '';
        valor_actual.Text := '';
        Precio_venta.Text := '';
        ubicacion.Text := '';
        motivo.Text := '';
        placa.SetFocus;
end;

procedure TFrmSalida.entra_datos;
begin
        with DataGeneral.IBsel1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "act$salida_activo" ');
          SQL.Add(' values (');
          SQL.Add(':"cod_salida",:"cod_activo",:"tipo_salida",');
          SQL.Add(':"motivo_salida",:"fecha_salida",:"precio_salida"');
          SQL.Add(',:"destino",:"precio_venta")');
          ParamByName('cod_salida').AsInteger := cod_salida;
          ParamByName('cod_activo').AsInteger := cod_activo;
          ParamByName('tipo_salida').AsInteger := tipo_salida;
          ParamByName('motivo_salida').AsString := motivo.Text;
          ParamByName('fecha_salida').AsDate := fecha_salida.DateTime;
          ParamByName('precio_salida').AsCurrency := valor_real;
          ParamByName('destino').AsString := ubicacion.Text;
          ParamByName('precio_venta').AsCurrency := valor_venta;
          Open;
          Close;
        end;
        DataGeneral.IBTransaction1.CommitRetaining;
end;

procedure TFrmSalida.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmSalida.AceptarClick(Sender: TObject);
begin
        Label5.Caption := 'Valor Actual';
        Label10.Visible := True;
        valor_actual.ReadOnly := True;
        if rDonacion.Checked = True then
          tipo_salida := 1
        else if RDestruccion.Checked = true then
          tipo_salida := 2
        else if Rventa.Checked = True then
          tipo_salida := 3;
        entra_datos;
        actualizar;
        limpiar;
end;

procedure TFrmSalida.RventaClick(Sender: TObject);
begin
        Precio_venta.Visible := True;
        Label6.Visible := True;
end;

procedure TFrmSalida.rDonacionClick(Sender: TObject);
begin
        Precio_venta.Visible:=False;
        Label6.Visible:=False;
end;

procedure TFrmSalida.RDestruccionClick(Sender: TObject);
begin
        Precio_venta.Visible := False;
        Label6.Visible := False;
end;

procedure TFrmSalida.actualizar;
begin
        with DataGeneral.IBsel do
        begin
          Close;
          Sql.Clear;
          SQL.Add(' update "act$activo" set "act$activo"."estado" = :"D"');
          SQL.Add('where "act$activo"."cod_activo" = :"codigo"' );
          ParamByName('codigo').AsInteger := cod_activo;
          ParamByName('D').AsString := 'D';
          Open;
          Close;
        end;
          DataGeneral.IBTransaction1.CommitRetaining;
end;

procedure TFrmSalida.valor_actualExit(Sender: TObject);
begin
        if valor_actual.ReadOnly = False then
        begin
          if valor_actual.Text = '' then
             valor_actual.Text := '0';
             valor_real := StrToCurr(valor_actual.Text);
             valor_actual.Text := '$'+FormatCurr('#,##0.00',valor_real);
        end;
end;

procedure TFrmSalida.valor_actualKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          fecha_salida.SetFocus;
end;

procedure TFrmSalida.valor_actualEnter(Sender: TObject);
begin
        if not valor_actual.ReadOnly then
          valor_actual.Text := '';
end;
end.
