unit UnitDescuento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, IBCustomDataSet, IBQuery,
  JvEdit, ComCtrls;

type
  TFrmDescuentos = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    empleado: TComboBox;
    empleadonit: TComboBox;
    seccion: TEdit;
    nomina: TEdit;
    Panel4: TPanel;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    BACEPTAR: TBitBtn;
    busca_nombre: TIBQuery;
    Panel2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    fecha_descuento: TDateTimePicker;
    dias: TJvEdit;
    Panel3: TPanel;
    Label8: TLabel;
    Observaciones: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure diasKeyPress(Sender: TObject; var Key: Char);
    procedure fecha_descuentoKeyPress(Sender: TObject; var Key: Char);
    procedure ObservacionesKeyPress(Sender: TObject; var Key: Char);
    procedure ObservacionesExit(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure diasEnter(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
  private
  nit_emp :Integer;
  punto :Boolean;
  sueldo_basico :Currency;
    procedure limpiar;
    procedure entra_datos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDescuentos: TFrmDescuentos;

implementation

uses UnitQuerys,unitglobal;

{$R *.dfm}

procedure TFrmDescuentos.FormCreate(Sender: TObject);
begin
        fecha_descuento.DateTime := Date;
        fecha_descuento.MaxDate := Date;
        with DataQuerys.IBselecion do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Clear;
          SQL.Add('select "inv$empleado"."nombre","inv$empleado"."apellido"  from "inv$empleado"');
          SQL.Add('where "inv$empleado"."nit" in (');
          SQL.Add('select "nom$empleado"."nitempleado" from "nom$empleado")');
          SQL.Add('order by "inv$empleado"."nombre"');
          Open;
          while not Eof do
          begin
            empleado.Items.Add(FieldByName('nombre').AsString + ' ' + fieldbyname('apellido').AsString);
            empleadonit.Items.Add(FieldByName('nombre').AsString + fieldbyname('apellido').AsString);
            Next;
             end;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmDescuentos.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmDescuentos.empleadoExit(Sender: TObject);
var   a :Smallint;
      b :string;
begin
        punto := false;
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        busca_nombre.Close;
        busca_nombre.parambyname('nombre').AsString := b;
        busca_nombre.Open;
        nit_emp := busca_nombre.fieldbyname('nit').AsInteger;
        seccion.Text := busca_nombre.fieldbyname('nombre').AsString;
        busca_nombre.Close;
        if nit_emp = 0 then
        begin
          MessageDlg('El Nombre del Empleado no es Correcto',mtInformation,[mbOK],0);
          empleado.SetFocus;
          Exit;
        end;
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$tiponomina"."descripcion","nom$empleado"."sueldobasico"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado",');
          SQL.Add('"nom$tiponomina"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."tipo_nomina" = "nom$tiponomina"."codigo") AND');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          nomina.Text := FieldByName('descripcion').AsString;
          sueldo_basico := FieldByName('sueldobasico').AsCurrency;
          Close;
        end;
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('sum("nom$descuento"."numero_dias") as dias');
          SQL.Add('FROM');
          SQL.Add('"nom$descuento"');
          SQL.Add('WHERE');
          SQL.Add('("nom$descuento"."cod_nomina" = :codigo) AND');
          SQL.Add('("nom$descuento"."nit_empleado" = :nit)');
          ParamByName('codigo').AsInteger := buscanomina(DataQuerys.IBselecion);
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          if  FieldByName('dias').AsCurrency <> 0 then
          begin
            if MessageDlg(empleado.Text+' Tiene Registrado un total de: '+
            FieldByName('dias').AsString+'  Dias'+#13+'                                     Desea Continuar?'
            ,mtInformation,[mbYes,mbNo],0) = mrNO Then
            empleado.SetFocus;
          end;
          Close;
        end;
end;

procedure TFrmDescuentos.empleadoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           dias.SetFocus;
end;

procedure TFrmDescuentos.diasKeyPress(Sender: TObject; var Key: Char);
begin

        if punto = False then
           num(Self,Key)
         else if not (Key  in [#13,'5']) then
           Key := #0;
        if Key = #13 then
           fecha_descuento.SetFocus;
        if Key in ['.'] then
           punto := True;
        if (punto = true) and (Key in['5']) then
           fecha_descuento.SetFocus;
end;

procedure TFrmDescuentos.fecha_descuentoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           Observaciones.SetFocus;
end;

procedure TFrmDescuentos.ObservacionesKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           BACEPTAR.SetFocus;
end;

procedure TFrmDescuentos.ObservacionesExit(Sender: TObject);
begin
        Observaciones.Text := UpperCase(Observaciones.Text);
end;

procedure TFrmDescuentos.limpiar;
begin
        empleado.ItemIndex := -1;
        dias.Text := '';
        seccion.Text := '';
        nomina.Text := '';
        Observaciones.Text := '';
        empleado.SetFocus;
end;

procedure TFrmDescuentos.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmDescuentos.diasEnter(Sender: TObject);
begin
        punto := False;
        dias.Text := '';
end;

procedure TFrmDescuentos.BACEPTARClick(Sender: TObject);
begin
        if (dias.Text = '') or (dias.Text ='.')then
        begin
           MessageDlg('El Campo "No. de Dias" No puede ser Nulo',mtInformation,[mbOK],0);
           dias.SetFocus;
        end
        else
        begin
          entra_datos;
          limpiar;
        end;
end;

procedure TFrmDescuentos.entra_datos;
var     codigo_nomina :Integer;
begin
        codigo_nomina := buscanomina(DataQuerys.IBselecion);
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('insert into "nom$descuento"');
          SQL.Add('values (');
          SQL.Add(':cod_nomina,:nit_empleado,:fecha,');
          SQL.Add(':numero_dias,:motivo)');
          ParamByName('cod_nomina').AsInteger := codigo_nomina;
          ParamByName('nit_empleado').AsInteger := nit_emp;
          ParamByName('fecha').AsDateTime := fecha_descuento.DateTime;
          ParamByName('numero_dias').AsString := dias.Text;
          ParamByName('motivo').AsString := Observaciones.Text;
          Open;
          Close;
          Transaction.Commit;
        end;
end;

end.
