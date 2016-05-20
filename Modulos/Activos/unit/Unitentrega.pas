unit Unitentrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons, DB, IBCustomDataSet,
  IBQuery, FR_Class, FR_DSet, FR_DBSet, Grids, DBGrids;

type
  TFrmEntrega = class(TForm)
    Panel2: TPanel;
    Aceptar: TBitBtn;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    empleado: TComboBox;
    empleadonit: TComboBox;
    suscursal: TComboBox;
    fecha: TDateTimePicker;
    Panel3: TPanel;
    DBentrega: TDBGrid;
    seccion: TComboBox;
    Label1: TLabel;
    tipoentrega: TComboBox;
    eliminar: TBitBtn;
    procedure empleadoExit(Sender: TObject);
    procedure suscursalExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBentregaEnter(Sender: TObject);
    procedure seccionClick(Sender: TObject);
    procedure seccionEnter(Sender: TObject);
    procedure seccionExit(Sender: TObject);
    procedure fechaKeyPress(Sender: TObject; var Key: Char);
    procedure suscursalKeyPress(Sender: TObject; var Key: Char);
    procedure tipoentregaExit(Sender: TObject);
    procedure eliminarClick(Sender: TObject);

  private


    { Private declarations }
  public
        nit_emp,cod_agencia,cod_traslado,codigo_seccion:Integer;
        tipo_entrega : Char;
        valida_codigo,valida_e:Integer;
  published

    procedure entra_datos;
    procedure limpiar;
    procedure imprimir(cadena: string);
    procedure cmChildKey(var msg: TWMKEY);message CM_CHILDKEY;
    { Public declarations }

  end;

var
  FrmEntrega: TFrmEntrega;

implementation

uses UnitGeneral, UnitDatamodulo, UnitActivorep, UnitPrincipal, UnitReporte,
  UnitImpresion;

{$R *.dfm}

procedure TFrmEntrega.empleadoExit(Sender: TObject);
var     a,codigo:integer;
        b:string;
begin
        valida_e := 0;
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        frmgeneral.busca_nombre.parambyname('nombre').AsString := b;
        frmgeneral.busca_nombre.Open;
        nit_emp := frmgeneral.busca_nombre.fieldbyname('nit').AsInteger;
        seccion.Text := frmgeneral.busca_nombre.fieldbyname('nombre').AsString;
        codigo_seccion := frmgeneral.busca_nombre.fieldbyname('cod_dependencia').AsInteger;
        frmgeneral.busca_nombre.Close;
        if nit_emp = 0 then
        begin
          ShowMessage('El Nombre del Empleado no es Correcto');
          empleado.SetFocus;
          Exit;
        end;
        frmgeneral.IBentrega.Active:=True;
        with DataGeneral.IBsel do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select max("act$traslado"."cod_traslado") as codigo_traslado');
            SQL.Add('from "act$traslado"');
            Open;
            codigo := FieldByName('codigo_traslado').AsInteger;
            cod_traslado := codigo + 1;
            Close;
          end;
          tipoentrega.ItemIndex := 0;
end;

procedure TFrmEntrega.suscursalExit(Sender: TObject);
begin
        with DataGeneral.IBsql do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "Inv$Agencia"."cod_agencia" from "Inv$Agencia"');
          SQL.Add('where "Inv$Agencia"."descripcion"=:"agencia"');
          ParamByName('agencia').AsString:=suscursal.Text;
          ExecQuery;
          cod_agencia := FieldByName('cod_agencia').AsInteger;
          Close;
        end;
end;

procedure TFrmEntrega.FormCreate(Sender: TObject);
begin
        fecha.DateTime := Date;
        tipo_entrega := 'E';
        Fecha.MaxDate := StrToDate(FormatDateTime('yyyy/mm/dd',Date));
        with DataGeneral.IBdatos do
           begin
             Close;
             SQL.Clear;
             SQL.Clear;
             SQL.Add('select "inv$empleado"."nombre","inv$empleado"."apellido"  from "inv$empleado"');
             SQL.Add('order by "inv$empleado"."nombre"');
             Open;
             while not DataGeneral.IBdatos.Eof do
             begin
               empleado.Items.Add(FieldByName('nombre').AsString + ' ' + fieldbyname('apellido').AsString);
               empleadonit.Items.Add(FieldByName('nombre').AsString + fieldbyname('apellido').AsString);
               DataGeneral.IBdatos.Next;
             end;
               Close;
        end;
        with DataGeneral.IBsql do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "Inv$Agencia"."descripcion" from "Inv$Agencia"');
          ExecQuery;
          while not DataGeneral.IBsql.Eof do
          begin
           suscursal.Items.Add(FieldByName('descripcion').AsString);
           DataGeneral.IBsql.Next;
          end;
          Close;
        end;
end;

procedure TFrmEntrega.entra_datos;
begin
        {with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "act$traslado" (');
          SQL.Add('"act$traslado"."cod_traslado","act$traslado"."fecha_traslado",');
          SQL.Add('"act$traslado"."nit_empleado","act$traslado"."cod_oficina",');
          SQL.Add('"act$traslado"."cod_seccion","act$traslado"."cod_activo",');
          SQL.Add('"act$traslado"."forma_traslado","act$traslado"."identificador",');
          SQL.Add('"act$traslado"."lugar")');
          SQL.Add('values (');
          SQL.Add(':"cod_traslado",:"fecha_traslado",:"nit_empleado",');
          SQL.Add(':"cod_oficina",:"cod_seccion",:"cod_activo",:"forma_traslado",:"identificador",:"lugar")');
          ParamByName('cod_traslado').AsInteger:=cod_traslado;
          ParamByName('fecha_traslado').AsDate:=fecha.DateTime;
          ParamByName('nit_empleado').AsInteger:=nit_emp;
          ParamByName('cod_oficina').AsInteger:=cod_agencia;
          ParamByName('cod_seccion').AsInteger:=codigo_seccion;
          ParamByName('cod_activo').AsInteger:=codigo_activo;
          ParamByName('forma_traslado').AsString:='DEFINITIVO';
          ParamByName('identificador').AsString:='N';
          ParamByName('lugar').AsString:='A';
          Open;
          Close;
          DataGeneral.IBTransaction1.CommitRetaining;
        end;}

end;

procedure TFrmEntrega.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmEntrega.limpiar;
begin
        empleado.ItemIndex := - 1;
        seccion.ItemIndex := - 1;
        suscursal.ItemIndex := - 1;
        tipoentrega.ItemIndex := - 1;
        empleado.SetFocus;
end;

procedure TFrmEntrega.CancelarClick(Sender: TObject);
begin
        if valida_e <> 1 then
        frmgeneral.IBentrega.Transaction.RollbackRetaining;
        limpiar;
end;

procedure TFrmEntrega.AceptarClick(Sender: TObject);
var lugar:string;
begin
        valida_e := 1;
        frmgeneral.IBentrega.Insert;
        frmgeneral.IBentrega.Transaction.Commit;
        
        if MessageDlg('Desea ver el Acta de Entrega',mtCustom,[mbYes,mbNo],0) = mrYes Then
        begin
          FrmActivos := TFrmActivos.Create(self);
          lugar := FrMain.wpath+'reportes\actade entrega2.frf';
          FrmActivos.IBacta.Close;
          FrmActivos.frDBDataSet1.DataSet := FrmActivos.IBacta;
          FrmActivos.IBacta.ParamByName('codigo').AsInteger := cod_traslado;
          FrmActivos.IBacta.Open;
          FrmActivos.imprimir_reporte(lugar);
        end;
        limpiar;
end;

procedure TFrmEntrega.imprimir(cadena: string);
begin
end;

procedure TFrmEntrega.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        if valida_e <> 1 then
        frmgeneral.IBentrega.Transaction.RollbackRetaining;
        frmgeneral.IBentrega.Active := False;
end;

procedure TFrmEntrega.cmChildKey(var msg: TWMKEY);
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

procedure TFrmEntrega.DBentregaEnter(Sender: TObject);
begin
        if cod_agencia = 0 then
        begin
          MessageDlg('El Campo Sucursal no Puede ser Nulo',mtInformation,[mbOK],0);
          suscursal.SetFocus;
        end;
end;
procedure TFrmEntrega.seccionClick(Sender: TObject);
begin
        with DataGeneral.IBsel do
        begin
        Close;
        SQL.Clear;
        SQL.Add('select "inv$dependencia"."nombre" from "inv$dependencia"');
        Open;
        while not DataGeneral.IBsel.Eof do
        begin
        seccion.Items.Add(FieldByName('nombre').AsString);
        Next;
        end;
        Close;
        end;


end;

procedure TFrmEntrega.seccionEnter(Sender: TObject);
begin
        seccion.Clear;
        seccionClick(Self);
end;

procedure TFrmEntrega.seccionExit(Sender: TObject);
begin
        with DataGeneral.IBsel do
        begin
        Close;
        SQL.Clear;
        SQL.Add('select "inv$dependencia"."cod_dependencia" from "inv$dependencia"');
        SQL.Add('where "inv$dependencia"."nombre" = :"nombre"');
        ParamByName('nombre').AsString := UpperCase(seccion.Text);
        Open;
        codigo_seccion := FieldByName('cod_dependencia').AsInteger;
        Close;
        end;
        if codigo_seccion = 0 then
           seccion.SetFocus;
        if seccion.Text = 'GENERAL' then
           begin
           tipoentrega.ItemIndex := 1;
           tipo_entrega := 'S';
           end;
end;

procedure TFrmEntrega.fechaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           DBentrega.SetFocus;
end;

procedure TFrmEntrega.suscursalKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           DBentrega.SetFocus;
end;

procedure TFrmEntrega.tipoentregaExit(Sender: TObject);
begin
        if tipoentrega.Text = 'EMPLEADO' Then
           tipo_entrega := 'E'
        else
           tipo_entrega := 'S';
end;

procedure TFrmEntrega.eliminarClick(Sender: TObject);
begin
        if frmgeneral.IBentregaplaca.Text = '' then
           eliminar.Enabled := False
        else
           frmgeneral.IBentrega.Delete;
           DBentrega.SetFocus;

end;

end.
