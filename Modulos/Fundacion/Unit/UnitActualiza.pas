unit UnitActualiza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, JvPanel, JvEdit, DBCtrls, JvLabel,
  ExtCtrls,StrUtils, DB, IBCustomDataSet, IBQuery, IBDatabase;

type
  TFrmActualizarD = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Tipo: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    JvLabel1: TJvLabel;
    Csexo: TComboBox;
    TEestrato: TEdit;
    TEnit: TJvEdit;
    TElugar: TJvEdit;
    JvPanel1: TJvPanel;
    Fecha: TLabel;
    Cuenta: TJvLabel;
    TEcuenta: TJvEdit;
    DTfecha: TMaskEdit;
    Panel2: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    T: TLabel;
    TECiudad: TEdit;
    TEBarrio: TEdit;
    TEdireccion: TEdit;
    TEtelefono: TEdit;
    Panel3: TPanel;
    BCancelar: TSpeedButton;
    Baceptar: TBitBtn;
    DBparentesco: TEdit;
    DBTipoNit: TDBLookupComboBox;
    IBtipo: TIBQuery;
    DataSource1: TDataSource;
    Label11: TLabel;
    Eps: TDBLookupComboBox;
    IBTransaction1: TIBTransaction;
    IBEps: TIBQuery;
    DataSource2: TDataSource;
    Label1: TLabel;
    TEnombres: TEdit;
    nombre1: TEdit;
    Label12: TLabel;
    apellido1: TEdit;
    apellido2: TEdit;
    procedure BCancelarClick(Sender: TObject);
    procedure BaceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    no_entrada1 :Integer;
    control_actualizacion: Boolean;
    control_entrada: smallint;
    control_eps: boolean;
    function entrada: integer;
    procedure a_eps;
  published

    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmActualizarD: TFrmActualizarD;

implementation

uses UnitBeneficiario, UnitQuerys,UnitGlobal,UnitRegistropas,
  UnitAfiliacion;

{$R *.dfm}

procedure TFrmActualizarD.cmChildKey(var msg: TWMKEY);
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

procedure TFrmActualizarD.BCancelarClick(Sender: TObject);
begin
        Close;
        //FrmRegistropas.oficina.SetFocus;
end;

procedure TFrmActualizarD.BaceptarClick(Sender: TObject);
begin
           a_eps;
           with DataQuerys.IBdatos do
           begin
             Close;
             verificatransaccion(DataQuerys.IBdatos);
             SQL.Clear;
             if control_actualizacion  then //insert
             begin
               SQL.Add('insert into "fun$beneficiario" values(');
               SQL.Add(':nombres,:tipo_id,:identificacion,:lugar_id,:sexo,');
               SQL.Add(':estrato,:direccion,:barrio,:telefono,:fecha_nacimineto,');
               SQL.Add(':ciudad,:es_titular,:estado,:no_entrada)');
               ParamByName('no_entrada').AsInteger := entrada;
             end
             else
             begin
               SQL.Add('update "fun$beneficiario" set');
               SQL.Add('"fun$beneficiario"."nombres" = :nombres,');
               //**
            SQL.Add('"fun$beneficiario".NOMBRE1 = :nombre1,');
            SQL.Add('"fun$beneficiario".APELLIDO1 = :apellido1,');
            SQL.Add('"fun$beneficiario".APELLIDO2 = :apellido2,');

               //**
               SQL.Add('"fun$beneficiario"."tipo_id" = :tipo_id,');
               SQL.Add('"fun$beneficiario"."lugar_id" = :lugar_id,');
               SQL.Add('"fun$beneficiario"."sexo" = :sexo,');
               SQL.Add('"fun$beneficiario"."estrato" = :estrato,');
               SQL.Add('"fun$beneficiario"."direccion" = :direccion,');
               SQL.Add('"fun$beneficiario"."barrio" = :barrio,');
               SQL.Add('"fun$beneficiario"."telefono" = :telefono,');
               SQL.Add('"fun$beneficiario"."fecha_nacimiento" = :fecha_nacimineto,');
               SQL.Add('"fun$beneficiario"."ciudad" = :ciudad,');
               SQL.Add('"fun$beneficiario"."es_titular" = :es_titular,');
               SQL.Add('"fun$beneficiario"."estado" = :estado');
               SQL.Add('where "fun$beneficiario"."identificacion" = :identificacion');
             end;
               ParamByName('nombres').AsString := TEnombres.Text;
               //**
            ParamByName('nombre1').AsString := nombre1.Text;
            ParamByName('apellido1').AsString := apellido1.Text;
            ParamByName('apellido2').AsString := apellido2.Text;

               //**
               ParamByName('tipo_id').AsString := DBTipoNit.KeyValue;
               ParamByName('identificacion').AsString := TEnit.Text;
               ParamByName('lugar_id').AsString := TElugar.Text;
               ParamByName('sexo').Text := LeftStr(Csexo.Text,1);
               ParamByName('estrato').AsString := TEestrato.Text;
               ParamByName('direccion').AsString := TEdireccion.Text;
               ParamByName('barrio').AsString := TEBarrio.Text;
               ParamByName('telefono').AsString := TEtelefono.Text;
               try
                 ParamByName('fecha_nacimineto').AsDate := StrToDateTime(DTFECHA.Text);
               except
               on E: Exception do
               begin
                 MessageDlg('La Fecha de Nacimiento es Obligatoria',mtError,[mbok],0);
                 DTfecha.SetFocus;
                 Exit;
               end;
               end;
               ParamByName('ciudad').AsString := TECiudad.Text;
               ParamByName('es_titular').AsSmallInt := 0;
               ParamByName('estado').AsSmallInt := 1;
             Open;
             Close;
             Transaction.Commit;
        end;
        if control_entrada = 1 then
        begin
           with DataQuerys.IBselecion do
           begin
             Close;
             verificatransaccion(DataQuerys.IBselecion);
             SQL.Clear;
             SQL.Add('insert into "fun$datos_asociado" values(');
             SQL.Add(':nit_asociado,:numero_cuenta,:oficina)');
             ParamByName('nit_asociado').AsString := TEnit.Text;
             ParamByName('numero_cuenta').AsString := DBparentesco.Text;
             ParamByName('oficina').AsInteger := FrmRegistropas.oficina.KeyValue;
               try
             Open;
             Close;
             Transaction.Commit;
             except
             begin
           FrmRegistropas.nombres.Text := TEnombres.Text;
           FrmRegistropas.municipio.Text := TECiudad.Text;
           FrmRegistropas.cuenta.Text := DBparentesco.Text;

             end;

             end;
           end;
           FrmRegistropas.nombres.Text := TEnombres.Text;
           FrmRegistropas.municipio.Text := TECiudad.Text;
           FrmRegistropas.cuenta.Text := DBparentesco.Text;
        end;

        Close;
end;

function TFrmActualizarD.entrada: integer;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('MAX("fun$beneficiario"."no_entrada") as no_entrada');
          SQL.Add('FROM');
          SQL.Add('"fun$beneficiario"');
          Open;
          Result := FieldByName('no_entrada').AsInteger + 1;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmActualizarD.FormCreate(Sender: TObject);
begin
        IBtipo.Open;
        IBtipo.Last;
        IBEps.Open;
        IBEps.Last;
        DataQuerys := TDataQuerys.Create(self);
        with DataQuerys.IBingresa do
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT DISTINCT');
            SQL.Add('"fun$afiliacioneps"."id_eps"');
            SQL.Add('FROM');
            SQL.Add('"fun$afiliacioneps"');
            SQL.Add('WHERE');
            SQL.Add('("fun$afiliacioneps"."nit_beneficiario" = :nit)');
            try
            ParamByName('nit').AsString := FrmBeneficiario.CDafiliacionnit.Text;
            except
            ParamByName('nit').AsString := '0';
            end;
            Open;
            if RecordCount <> 0 then
            begin
              Eps.KeyValue := FieldByName('id_eps').AsInteger;
              control_eps := True;
            end
            else
              control_eps := False;
          end;

end;

procedure TFrmActualizarD.a_eps;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          if control_eps = False then
          begin
            SQL.Add('insert into "fun$afiliacioneps" values (');
            SQL.Add(':id_eps,:nit_beneficiario,:id_convenio)');
            ParamByName('id_convenio').AsInteger := 1;
          end
          else
          begin
            SQL.Add('update "fun$afiliacioneps" set');
            SQL.Add('"fun$afiliacioneps"."id_eps" = :id_eps');
            SQL.Add('where "fun$afiliacioneps"."nit_beneficiario" = :nit_beneficiario');
          end;
          ParamByName('id_eps').AsInteger := Eps.KeyValue;
          ParamByName('nit_beneficiario').AsString := TEnit.Text;
            Open;
            Close;
            Transaction.Commit;
        end;


end;

end.
