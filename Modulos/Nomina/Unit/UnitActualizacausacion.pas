unit UnitActualizacausacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,
  IBQuery, JvEdit, JvTypedEdit, JvFloatEdit;

type
  TFrmActualizaCausacion = class(TForm)
    DSactualiza: TDataSource;
    IBActualiza: TIBDataSet;
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
    Label8: TLabel;
    PVacaciones: TJvCurrencyEdit;
    PAntiguedad: TJvCurrencyEdit;
    Vacaciones: TJvCurrencyEdit;
    Panel3: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    APvacaciones: TJvFloatEdit;
    APantiguedad: TJvFloatEdit;
    Avacaciones: TJvFloatEdit;
    Label13: TLabel;
    Label14: TLabel;
    JVcesantias: TJvCurrencyEdit;
    acesantias: TJvFloatEdit;
    procedure FormCreate(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
  private
  nit_emp :Integer;
  v_vacaciones :Currency;
  v_pvacaciones :Currency;
  v_pantiguedad :Currency;
    procedure seleciona;
    procedure limpiar;
    procedure actualizar;
    { Private declarations }
  public
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmActualizaCausacion: TForm;

implementation
uses
unitdatamodulo, UnitQuerys,UnitGlobal;

{$R *.dfm}

procedure TFrmActualizaCausacion.FormCreate(Sender: TObject);
begin
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

procedure TFrmActualizaCausacion.empleadoExit(Sender: TObject);
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
        seleciona;
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

end;

procedure TFrmActualizaCausacion.seleciona;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"nom$consolidado"."vacaciones",');
          SQL.Add('"nom$consolidado"."prima_vacaciones",');
          SQL.Add('"nom$consolidado"."prima_ant",');
          SQL.Add('"nom$consolidado"."cesantia"');
          SQL.Add('FROM');
          SQL.Add('"nom$consolidado"');
          SQL.Add('WHERE');
          SQL.Add('("nom$consolidado"."nit" = :nit)');
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          PVacaciones.Value := FieldByName('prima_vacaciones').AsCurrency;
          PAntiguedad.Value := FieldByName('prima_ant').AsCurrency;
          Vacaciones.Value := FieldByName('vacaciones').AsCurrency;
          JVcesantias.Value := FieldByName('cesantia').AsCurrency;
          Close;
        end;
end;

procedure TFrmActualizaCausacion.cmChildKey(var msg: TWMKEY);
begin
if msg.CharCode = VK_RETURN then
    if not (Assigned(ActiveControl) and
           ((ActiveControl is TButton) or
            (ActiveControl is TCustomMemo)))
    then begin
      msg.Result := 1;
      keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), 0, 0);
      Keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), KEYEVENTF_KEYUP, 0);
    end;
end;

procedure TFrmActualizaCausacion.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmActualizaCausacion.limpiar;
begin
        empleado.ItemIndex := -1;
        seccion.Text := '';
        nomina.Text := '';
        PVacaciones.Value := 0;
        PAntiguedad.Value := 0;
        Vacaciones.Value := 0;
        AVacaciones.Value := 0;
        APantiguedad.Value := 0;
        AVacaciones.Value := 0;
        JVcesantias.Value := 0;
        Acesantias.Value := 0;
        empleado.SetFocus;
end;

procedure TFrmActualizaCausacion.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmActualizaCausacion.actualizar;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('update "nom$consolidado" set');
          SQL.Add('"nom$consolidado"."vacaciones" = :vacaciones,');
          SQL.Add('"nom$consolidado"."prima_vacaciones" = :pvacaciones,');
          SQL.Add('"nom$consolidado"."prima_ant" = :antiguedad,');
          SQL.Add('"nom$consolidado"."cesantia" = :cesantia');
          SQL.Add('where "nom$consolidado"."nit" = :nit');
          ParamByName('nit').AsInteger := nit_emp;
          ParamByName('vacaciones').AsCurrency := Vacaciones.Value + AVacaciones.Value;
          ParamByName('antiguedad').AsCurrency := PAntiguedad.Value + apantiguedad.Value;
          ParamByName('pvacaciones').AsCurrency := PVacaciones.Value + apvacaciones.Value;
          ParamByName('cesantia').AsCurrency := JVcesantias.Value + acesantias.Value;
          Open;
          Close;
          Transaction.Commit;
        end;
        seleciona;
end;

procedure TFrmActualizaCausacion.BACEPTARClick(Sender: TObject);
begin
        if MessageDlg('Seguro de Realizar la Transaccion.',mtInformation,[mbYes,mbNo],0) = mrYes Then
        begin
        actualizar;
        AVacaciones.Value := 0;
        APvacaciones.Value:= 0;
        APantiguedad.Value := 0;
        Acesantias.Value := 0;
        end;
end;

end.
