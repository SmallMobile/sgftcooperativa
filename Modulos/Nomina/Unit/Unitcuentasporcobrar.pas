unit Unitcuentasporcobrar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvEdit, ComCtrls, StdCtrls, Buttons, ExtCtrls, DB,
  IBCustomDataSet, IBQuery, JvTypedEdit;

type
  TFrmCuentasPorCobrar = class(TForm)
    Panel4: TPanel;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    BACEPTAR: TBitBtn;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    empleado: TComboBox;
    empleadonit: TComboBox;
    seccion: TEdit;
    nomina: TEdit;
    Panel2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    fecha_descuento: TDateTimePicker;
    busca_nombre: TIBQuery;
    valor: TJvCurrencyEdit;
    Panel3: TPanel;
    Label8: TLabel;
    observaciones: TMemo;
    procedure empleadoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure valorKeyPress(Sender: TObject; var Key: Char);
    procedure fecha_descuentoKeyPress(Sender: TObject; var Key: Char);
    procedure CancelarClick(Sender: TObject);
    procedure observacionesKeyPress(Sender: TObject; var Key: Char);
    procedure BACEPTARClick(Sender: TObject);
  private
  nit_emp :Integer;
    procedure limpiar;
    procedure entra_datos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCuentasPorCobrar: TFrmCuentasPorCobrar;

implementation

uses UnitQuerys,UnitGlobal;

{$R *.dfm}

procedure TFrmCuentasPorCobrar.empleadoExit(Sender: TObject);
var   a :Smallint;
      b :string;
begin
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
          Close;
        end;
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('sum("nom$cobros"."descuento") as descuento');
          SQL.Add('FROM');
          SQL.Add('"nom$cobros"');
          SQL.Add('WHERE');
          SQL.Add('("nom$cobros"."cod_nomina" = :codigo) AND');
          SQL.Add('("nom$cobros"."nit_empleado" = :nit)');
          ParamByName('codigo').AsInteger := buscanomina(DataQuerys.IBselecion);
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          if  FieldByName('descuento').AsCurrency <> 0 then
          begin
            if MessageDlg(empleado.Text+' Tiene Registrado un total de: '+
            '$'+FormatCurr('#,##0.00',FieldByName('descuento').AsCurrency)+'  Pesos'+#13+'                                     Desea Continuar?'
            ,mtInformation,[mbYes,mbNo],0) = mrNO Then
            empleado.SetFocus;
          end;
          Close;
        end;

end;

procedure TFrmCuentasPorCobrar.FormCreate(Sender: TObject);
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

procedure TFrmCuentasPorCobrar.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmCuentasPorCobrar.empleadoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           valor.SetFocus;
end;

procedure TFrmCuentasPorCobrar.valorKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           fecha_descuento.SetFocus;
end;

procedure TFrmCuentasPorCobrar.fecha_descuentoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           observaciones.SetFocus;
end;

procedure TFrmCuentasPorCobrar.limpiar;
begin
        empleado.ItemIndex := -1;
        seccion.Text := '';
        nomina.Text := '';
        valor.Value := 0;
        observaciones.Text := '';
        empleado.SetFocus;

end;

procedure TFrmCuentasPorCobrar.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmCuentasPorCobrar.observacionesKeyPress(Sender: TObject;
  var Key: Char);

begin
        if Key = #13 then
           BACEPTAR.SetFocus;
end;

procedure TFrmCuentasPorCobrar.entra_datos;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('insert into "nom$cobros"');
          SQL.Add('values (');
          SQL.Add(':cod_nomina,:nit_empleado,:descuento,:observacion)');
          ParamByName('cod_nomina').AsInteger := buscanomina(DataQuerys.IBselecion);
          ParamByName('nit_empleado').AsInteger := nit_emp;
          ParamByName('descuento').AsCurrency := valor.Value;
          ParamByName('observacion').AsString := observaciones.Text;
          Open;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmCuentasPorCobrar.BACEPTARClick(Sender: TObject);
begin
        if valor.Value = 0 then
        begin
           MessageDlg('El Campo "Descuento" no puede ser Nulo',mtInformation,[mbok],0);
           valor.SetFocus;
        end
        else
        entra_datos;
        limpiar;
end;

end.
