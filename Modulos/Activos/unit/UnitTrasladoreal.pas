unit UnitTrasladoreal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, IBCustomDataSet,
  IBQuery, DBCtrls;

type
  TFrmTraslado = class(TForm)
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
    Label5: TLabel;
    estado: TEdit;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Ttemporal: TRadioButton;
    Tdefinitivo: TRadioButton;
    Tinterno: TRadioButton;
    Texterno: TRadioButton;
    GroupBox4: TGroupBox;
    empleadonit: TComboBox;
    empleado: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    fecha_traslado: TDateTimePicker;
    Label8: TLabel;
    motivo: TMemo;
    Label9: TLabel;
    Fecha_Reintegro: TDateTimePicker;
    Label10: TLabel;
    suscursal: TComboBox;
    Label11: TLabel;
    tipoentrega: TComboBox;
    Label12: TLabel;
    DBseccion: TDBLookupComboBox;
    IBQuery1: TIBQuery;
    DataSource1: TDataSource;
    procedure placaExit(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
    procedure SalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TdefinitivoClick(Sender: TObject);
    procedure TtemporalClick(Sender: TObject);
    procedure suscursalExit(Sender: TObject);
    procedure TinternoClick(Sender: TObject);
    procedure TexternoClick(Sender: TObject);
    procedure nombre_pKeyPress(Sender: TObject; var Key: Char);
    procedure estadoKeyPress(Sender: TObject; var Key: Char);
    procedure TtemporalKeyPress(Sender: TObject; var Key: Char);
    procedure TexternoKeyPress(Sender: TObject; var Key: Char);
    procedure TdefinitivoKeyPress(Sender: TObject; var Key: Char);
    procedure TinternoKeyPress(Sender: TObject; var Key: Char);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure fecha_trasladoKeyPress(Sender: TObject; var Key: Char);
    procedure Fecha_ReintegroKeyPress(Sender: TObject; var Key: Char);
    procedure motivoKeyPress(Sender: TObject; var Key: Char);
    procedure suscursalKeyPress(Sender: TObject; var Key: Char);
    procedure motivoExit(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure placaEnter(Sender: TObject);
    procedure tipoentregaKeyPress(Sender: TObject; var Key: Char);
    procedure tipoentregaExit(Sender: TObject);
    procedure DBseccionKeyPress(Sender: TObject; var Key: Char);
  private
     cod_traslado,cod_activo,cod_seccion,cod_agencia,nit_empleado: Integer;
     tipo_traslado,forma_traslado: string;
     tipo_entrega : Char;
    { Private declarations }
  public
  published
    procedure llena_sucursal;
    procedure entra_datos;
    procedure limpiar;
    procedure entra_datos1;
    { Public declarations }
  end;

var
  FrmTraslado: TFrmTraslado;

implementation

uses UnitDatamodulo,unitgeneral,unitglobal;

{$R *.dfm}

procedure TFrmTraslado.placaExit(Sender: TObject);
var         nombre: string;
begin
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
         if cod_activo > 0 then
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
            SQL.Add('select max("act$traslado"."cod_traslado") as cod_traslado');
            SQL.Add('from "act$traslado"' );
            ExecQuery;
            cod_traslado := (FieldByName('cod_traslado').AsInteger) + 1;
            Close;
          end;
        end
        else
        begin
          MessageDlg('El Activo no se Encuentra en la Base de Datos',mtInformation,[mbOK],0);
          placa.SetFocus;
        end;
        end
        else
        begin
         MessageDlg('El Activo Fue Dado de Baja',mtInformation,[mbOK],0);
         Label3.Caption := '';
         nombre_p.Text := '';
          placa.SetFocus;
        end;
        Tdefinitivo.Checked := True;

end;

procedure TFrmTraslado.placaKeyPress(Sender: TObject; var Key: Char);
begin
        ValidaPlaca(Self,Key);
        if Key = #13 then
          estado.SetFocus;
end;

procedure TFrmTraslado.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmTraslado.FormCreate(Sender: TObject);
begin
        tipo_entrega := 'E';
        llena_sucursal;
        fecha_traslado.DateTime := Date;
        Fecha_Reintegro.DateTime := Date;
        frmgeneral.IbAgencia.Open;
        frmgeneral.IbAgencia.Last;
        fecha_traslado.MaxDate := StrToDate(FormatDateTime('yyyy/mm/dd',Date));
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

procedure TFrmTraslado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        frmgeneral.IbAgencia.Close;
end;

procedure TFrmTraslado.TdefinitivoClick(Sender: TObject);
begin
        Fecha_Reintegro.Visible := False;
        Label9.Visible := False;
end;

procedure TFrmTraslado.TtemporalClick(Sender: TObject);
begin
        Fecha_Reintegro.Visible := True;
        Label9.Visible := True;
end;

procedure TFrmTraslado.suscursalExit(Sender: TObject);
begin
         with DataGeneral.IBsql do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "Inv$Agencia"."cod_agencia" from "Inv$Agencia"');
          SQL.Add('where "Inv$Agencia"."descripcion"=:"agencia"');
          ParamByName('agencia').AsString := suscursal.Text;
          ExecQuery;
          cod_agencia := FieldByName('cod_agencia').AsInteger;
          Close;
        end;
end;

procedure TFrmTraslado.llena_sucursal;
begin
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "Inv$Agencia"."descripcion" from "Inv$Agencia"');
          open;
          while not DataGeneral.IBsel.Eof do
          begin
            suscursal.Items.Add(FieldByName('descripcion').AsString);
            DataGeneral.IBsel.Next;
          end;
          Close;
       end;
end;

procedure TFrmTraslado.TinternoClick(Sender: TObject);
begin
        suscursal.Clear;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "Inv$Agencia"."descripcion" from "Inv$Agencia"');
          SQL.Add('where "Inv$Agencia"."cod_agencia" = 1' );
          Open;
          suscursal.Items.Add(FieldByName('descripcion').AsString);
          Close;
       end;
       suscursal.ItemIndex := 0;
end;

procedure TFrmTraslado.TexternoClick(Sender: TObject);
begin
        suscursal.Clear;
        llena_sucursal;
end;

procedure TFrmTraslado.nombre_pKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          estado.SetFocus;

end;

procedure TFrmTraslado.estadoKeyPress(Sender: TObject; var Key: Char);
begin
         if Key = #13 then
         Tinterno.SetFocus
end;

procedure TFrmTraslado.TtemporalKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          Tinterno.SetFocus
end;

procedure TFrmTraslado.TexternoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          empleado.SetFocus
end;

procedure TFrmTraslado.TdefinitivoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          Tinterno.SetFocus;
end;

procedure TFrmTraslado.TinternoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          empleado.SetFocus;
end;

procedure TFrmTraslado.empleadoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          fecha_traslado.SetFocus;
end;

procedure TFrmTraslado.fecha_trasladoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if (Key = #13) and (Fecha_Reintegro.Visible=True) then
          Fecha_Reintegro.SetFocus
        else
          motivo.SetFocus
end;

procedure TFrmTraslado.Fecha_ReintegroKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          motivo.SetFocus;
end;

procedure TFrmTraslado.motivoKeyPress(Sender: TObject; var Key: Char);
begin
         if Key = #13 then
           suscursal.SetFocus
end;

procedure TFrmTraslado.suscursalKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          tipoentrega.SetFocus;
end;

procedure TFrmTraslado.motivoExit(Sender: TObject);
begin
        motivo.Text := UpperCase(motivo.Text)
end;

procedure TFrmTraslado.entra_datos;
var lugar:char;
begin
        if Tdefinitivo.Checked = True then
            lugar := 'A'
        else
            lugar := 'D';
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "act$traslado"');
          SQL.Add('values (');
          SQL.Add(':"cod_traslado",:"fecha_traslado",');
          SQL.Add(':"nit_empleado",:"cod_oficina",');
          SQL.Add(':"cod_seccion",:"cod_activo",:"tipo_traslado",');
          SQL.Add(':"fecha_reintegro",:"forma_traslado",:"motivo",');
          SQL.Add(':"A",:"estado",:"lugar1",:"tipotraslado")');
          ParamByName('cod_traslado').AsInteger := cod_traslado;
          ParamByName('fecha_traslado').AsDate := fecha_traslado.DateTime;
          ParamByName('nit_empleado').AsInteger := nit_empleado;
          ParamByName('cod_oficina').AsInteger := cod_agencia;
          ParamByName('cod_seccion').AsInteger := cod_seccion;
          ParamByName('cod_activo').AsInteger := cod_activo;
          ParamByName('tipo_traslado').AsString := tipo_traslado;
          ParamByName('fecha_reintegro').AsDate := Fecha_Reintegro.DateTime;
          ParamByName('forma_traslado').AsString := forma_traslado;
          ParamByName('motivo').AsString := motivo.Text;
          ParamByName('A').AsString := 'A';
          ParamByName('estado').AsString := estado.Text;
          parambyname('lugar1').AsString := lugar;
          ParamByName('tipotraslado').AsString := tipo_entrega;
          Open;
          Close;
        end;
        DataGeneral.IBTransaction1.CommitRetaining;
end;

procedure TFrmTraslado.AceptarClick(Sender: TObject);
begin
        cod_seccion := DBseccion.KeyValue;
        if Tdefinitivo.Checked = True then
           with DataGeneral.IBsel do
             begin
             Close;
             SQL.Clear;
             SQL.Add('update "act$traslado" set "act$traslado"."lugar"=:"lugar"');
             SQL.Add('where "act$traslado"."cod_activo"=:"codigo" and');
             SQL.Add('"act$traslado"."lugar"=:"lugar1"');
             ParamByName('lugar').AsString := 'D';
             ParamByName('codigo').AsInteger := cod_activo;
             ParamByName('lugar1').AsString := 'A';
             Open;
             Close;
             DataGeneral.IBTransaction1.CommitRetaining;
             end;

        if empleado.Text = '' then
           begin
           ShowMessage('El campo Empleado Debe Contener un Valor');
           empleado.SetFocus;
        end
        else if suscursal.Text = '' then
        begin
           ShowMessage('El campo Sucursal Debe Contener un Valor');
           suscursal.SetFocus;
        end
        else
        begin
        if Ttemporal.Checked = True then
          forma_traslado := 'TEMPORAL'
        Else
          forma_traslado := 'DEFINITIVO';

        if Tinterno.Checked = True Then
          tipo_traslado := 'INTERNO'
        Else
          tipo_traslado := 'EXTERNO';
          if Fecha_Reintegro.Visible = False then
             entra_datos1
          else
             entra_datos;
          limpiar;
          end;
end;

procedure TFrmTraslado.limpiar;
begin
        placa.Text := '';
        Label3.Caption := '';
        nombre_p.Text := '';
        estado.Text := '';
        empleado.ItemIndex := -1;
        motivo.Text := '';
        suscursal.ItemIndex := -1;
        placa.SetFocus;
end;

procedure TFrmTraslado.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmTraslado.empleadoExit(Sender: TObject);
var     a:integer;
        b:string;
begin
        IBQuery1.Close;
        IBQuery1.Open;
        IBQuery1.Last;
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        frmgeneral.busca_nombre.parambyname('nombre').AsString := b;
        frmgeneral.busca_nombre.Open;
        nit_empleado := frmgeneral.busca_nombre.fieldbyname('nit').AsInteger;
        cod_seccion := frmgeneral.busca_nombre.fieldbyname('cod_dependencia').AsInteger;
        DBseccion.KeyValue := cod_seccion;
        frmgeneral.busca_nombre.Close;
        if nit_empleado = 0 then
          begin
          MessageDlg('No Existe el Empleado. Favor Corregir',mtInformation,[mbOK],0);
          empleado.SetFocus;
        end;
end;

procedure TFrmTraslado.entra_datos1;
var lugar:Char;
begin
        if Tdefinitivo.Checked = True then
            lugar := 'A'
        else
            lugar := 'D';
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "act$traslado" (');
          SQL.Add('"act$traslado"."cod_traslado","act$traslado"."fecha_traslado",');
          SQL.Add('"act$traslado"."nit_empleado","act$traslado"."cod_oficina",');
          SQL.Add('"act$traslado"."cod_seccion","act$traslado"."cod_activo","act$traslado"."tipo_traslado",');
          SQL.Add('"act$traslado"."forma_traslado","act$traslado"."motivo",');
          SQL.Add('"act$traslado"."identificador","act$traslado"."estado",');
          SQL.Add('"act$traslado"."lugar","act$traslado"."tipotraslado")');
          SQL.Add('values (');
          SQL.Add(':"cod_traslado",:"fecha_traslado",');
          SQL.Add(':"nit_empleado",:"cod_oficina",');
          SQL.Add(':"cod_seccion",:"cod_activo",:"tipo_traslado",');
          SQL.Add(':"forma_traslado",:"motivo",');
          SQL.Add(':"identificador",:"estado",:"lugar",:"tipotraslado")');
          ParamByName('cod_traslado').AsInteger := cod_traslado;
          ParamByName('fecha_traslado').AsDate := fecha_traslado.DateTime;
          ParamByName('nit_empleado').AsInteger := nit_empleado;
          ParamByName('cod_oficina').AsInteger := cod_agencia;
          ParamByName('cod_seccion').AsInteger := cod_seccion;
          ParamByName('cod_activo').AsInteger := cod_activo;
          ParamByName('tipo_traslado').AsString := tipo_traslado;
          ParamByName('forma_traslado').AsString := forma_traslado;
          ParamByName('motivo').AsString := motivo.Text;
          ParamByName('identificador').AsString := 'A';
          ParamByName('estado').AsString := estado.Text;
          ParamByName('lugar').AsString := lugar;
          ParamByName('tipotraslado').AsString := tipo_entrega;// define si es seccion o empleado
          Open;
          Close;
        end;
        DataGeneral.IBTransaction1.CommitRetaining;
end;

procedure TFrmTraslado.placaEnter(Sender: TObject);
begin
        nombre_p.Text := '';
        Label3.Caption := '';
end;

procedure TFrmTraslado.tipoentregaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           DBseccion.SetFocus;
end;

procedure TFrmTraslado.tipoentregaExit(Sender: TObject);
begin
        if tipoentrega.Text = 'EMPLEADO' Then
           tipo_entrega := 'E'
        else
           tipo_entrega := 'S';
end;

procedure TFrmTraslado.DBseccionKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           Aceptar.SetFocus;
end;

end.
