unit UnitRepSeccion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Buttons;

type
  TFrmReporteseccion = class(TForm)
    Panel1: TPanel;
    seccion: TDBLookupComboBox;
    Label1: TLabel;
    Ejeseccion: TBitBtn;
    Sucursal: TDBLookupComboBox;
    empleadonit: TComboBox;
    empleado: TComboBox;
    label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure EjeseccionClick(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure seccionKeyPress(Sender: TObject; var Key: Char);
    procedure SucursalKeyPress(Sender: TObject; var Key: Char);
  private
  nit_emp:Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReporteseccion: TFrmReporteseccion;

implementation
uses unitgeneral, UnitActivorep, UnitPrincipal, UnitDatamodulo;

{$R *.dfm}

procedure TFrmReporteseccion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        frmgeneral.IBseccion.Active := False;
        frmgeneral.IbAgencia.Active := False;
        FrmActivos.IBseccion.Close;
        FrmActivos.IBsucursal.Close;
end;

procedure TFrmReporteseccion.FormCreate(Sender: TObject);
begin
        frmgeneral.IBseccion.Active := True;
        frmgeneral.IBseccion.Last;
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
end;

procedure TFrmReporteseccion.EjeseccionClick(Sender: TObject);
begin

        FrmActivos := TFrmActivos.Create(Self);
        if FrMain.seccion = 1 then
        begin
          try
          FrmActivos.frDBDataSet1.DataSet := FrmActivos.IBseccion;
          FrmActivos.IBseccion.ParamByName('codigo').AsInteger := seccion.KeyValue;
          FrmActivos.IBseccion.Open;
            if FrmActivos.IBseccion.RecordCount <> 0 then
              FrmActivos.imprimir_reporte(FrMain.wpath+'reportes\inventarioseccion.frf')
            else
            begin
              MessageDlg('No Existen Campos Disponibles',mtInformation,[mbOK],0);
              seccion.SetFocus;
        end;
          except
          on e: Exception do
          begin
          seccion.SetFocus;
          end;
          end;
          end
        else if FrMain.seccion = 2 then
        begin
          try
          FrmActivos.frDBDataSet1.DataSet := FrmActivos.IBsucursal;
          FrmActivos.IBsucursal.ParamByName('ES_ACTIVO').AsInteger := 1;
          FrmActivos.IBsucursal.ParamByName('codigo').AsInteger := sucursal.KeyValue;
          FrmActivos.IBsucursal.Open;
            if FrmActivos.IBsucursal.RecordCount <> 0 then
              FrmActivos.imprimir_reporte(FrMain.wpath + 'reportes\inventariosucursal.frf')
            else
            begin
              MessageDlg('No Existen Campos Disponibles',mtInformation,[mbOK],0);
              Sucursal.SetFocus;
             end;
            except
            on e: Exception do
             begin
             Sucursal.SetFocus;
             end;
             end;
        end
        else if FrMain.seccion = 3 then
        begin
          FrmActivos.frDBDataSet1.DataSet := FrmActivos.IBempleado;
          FrmActivos.IBempleado.ParamByName('CEDULA').AsInteger := nit_emp;
          FrmActivos.IBempleado.Open;
            if FrmActivos.IBempleado.RecordCount <> 0 then
              FrmActivos.imprimir_reporte(FrMain.wpath + 'reportes\reporteempleado.frf')
            else
            begin
              MessageDlg('No Existen Campos Disponibles',mtInformation,[mbOK],0);
              empleado.SetFocus;
            end;
             end

         else if FrMain.seccion = 4 then
        begin
          FrmActivos.frDBDataSet1.DataSet := FrmActivos.IBelemento;
          FrmActivos.IBelemento.ParamByName('CEDULA').AsInteger := nit_emp;
          FrmActivos.IBelemento.Open;
            if FrmActivos.IBelemento.RecordCount <> 0 then
              FrmActivos.imprimir_reporte(FrMain.wpath + 'reportes\reporteempleadoelemento.frf')
            else
            begin
              MessageDlg('No Existen Campos Disponibles',mtInformation,[mbOK],0);
              empleado.SetFocus;
            end;
             end
          else if FrMain.seccion = 5 then
        begin
          try
          FrmActivos.frDBDataSet1.DataSet := FrmActivos.IBconelemento;
          FrmActivos.IBconelemento.ParamByName('codigo').AsInteger := seccion.KeyValue;
          FrmActivos.IBconelemento.Open;
            if FrmActivos.IBconelemento.RecordCount <> 0 then
              FrmActivos.imprimir_reporte(FrMain.wpath + 'reportes\reporteseccioelemento.frf')
            else
            begin
              MessageDlg('No Existen Campos Disponibles',mtInformation,[mbOK],0);
              seccion.SetFocus;
        end;
          except
          on e: Exception do
          begin
          seccion.SetFocus;
          end;
          end;
          end
         else if FrMain.seccion = 6 then
        begin
          FrmActivos.IBentrega.Close;
          FrmActivos.frDBDataSet1.DataSet := FrmActivos.IBentrega;
          FrmActivos.IBentrega.ParamByName('nit').AsInteger := nit_emp;
          FrmActivos.IBentrega.Open;
            if FrmActivos.IBentrega.RecordCount <> 0 then
              FrmActivos.imprimir_reporte(FrMain.wpath + 'reportes\actade entrega_1.frf')
            else
            begin
              MessageDlg('No Existen Campos Disponibles',mtInformation,[mbOK],0);
              empleado.SetFocus;
            end;
             end
        else if FrMain.seccion = 16 then
        begin
          try
          FrmActivos.frDBDataSet1.DataSet := FrmActivos.IBsucursal;
          FrmActivos.IBsucursal.ParamByName('ES_ACTIVO').AsInteger := 0;
          FrmActivos.IBsucursal.ParamByName('codigo').AsInteger := sucursal.KeyValue;
          FrmActivos.IBsucursal.Open;
            if FrmActivos.IBsucursal.RecordCount <> 0 then
              FrmActivos.imprimir_reporte(FrMain.wpath + 'reportes\inventariosucursal.frf')
            else
            begin
              MessageDlg('No Existen Campos Disponibles',mtInformation,[mbOK],0);
              Sucursal.SetFocus;
             end;
            except
            on e: Exception do
             begin
             Sucursal.SetFocus;
             end;
             end;
        end




end;
procedure TFrmReporteseccion.empleadoExit(Sender: TObject);
var     a:integer;
        b:string;
begin
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        frmgeneral.busca_nombre.parambyname('nombre').AsString := b;
        frmgeneral.busca_nombre.Open;
        nit_emp := frmgeneral.busca_nombre.fieldbyname('nit').AsInteger;
        frmgeneral.busca_nombre.Close;


end;

procedure TFrmReporteseccion.empleadoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           Ejeseccion.SetFocus;
end;

procedure TFrmReporteseccion.seccionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           Ejeseccion.SetFocus
end;

procedure TFrmReporteseccion.SucursalKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           Ejeseccion.SetFocus
end;

end.
