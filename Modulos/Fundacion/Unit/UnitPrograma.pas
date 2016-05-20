unit UnitPrograma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvDBCtrl, DB, IBCustomDataSet, IBQuery,
  StdCtrls, ComCtrls, ExtCtrls, Buttons, IBDatabase, XStringGrid, DBClient, JvComponent,
  JvaScrollText, DBCtrls, JvEdit, JvLabel, JvPanel,strutils, Mask;

type
  TFrmPrograma = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    TEnombres: TEdit;
    Label2: TLabel;
    Csexo: TComboBox;
    Label3: TLabel;
    Tipo: TLabel;
    Label4: TLabel;
    TEestrato: TEdit;
    Label5: TLabel;
    Panel2: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    TECiudad: TEdit;
    TEBarrio: TEdit;
    TEdireccion: TEdit;
    Panel3: TPanel;
    Baceptar: TBitBtn;
    DBtiponit: TDBLookupComboBox;
    IBtipo: TIBQuery;
    DataSource1: TDataSource;
    IBTtipo: TIBTransaction;
    Label10: TLabel;
    DBparentesco: TDBLookupComboBox;
    IBparentesco: TIBQuery;
    DSparentesco: TDataSource;
    TEnit: TJvEdit;
    JvLabel1: TJvLabel;
    TElugar: TJvEdit;
    T: TLabel;
    TEtelefono: TEdit;
    JvPanel1: TJvPanel;
    Fecha: TLabel;
    Cuenta: TJvLabel;
    TEcuenta: TJvEdit;
    DTfecha: TMaskEdit;
    BCancelar: TSpeedButton;
    Label11: TLabel;
    Eps: TDBLookupComboBox;
    DataSource2: TDataSource;
    IBEps: TIBQuery;
    IBTransaction1: TIBTransaction;
    nombre1: TEdit;
    Label12: TLabel;
    apellido1: TEdit;
    apellido2: TEdit;
    EdMail: TEdit;
    Mail: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BcancelarClick(Sender: TObject);
    procedure BaceptarClick(Sender: TObject);
    procedure TEnitExit(Sender: TObject);
    procedure DBparentescoExit(Sender: TObject);
  private
    { Private declarations }

  public
    no_registro,opcion,oficina :Integer;
    titular :Smallint;
    opcion_salida: integer;
    actualiza_dato: boolean;
    codigo_convenio :Integer;
    convenio :string;
    codigo_oficina :Integer;
    afiliacion: integer;
    es_afilia :Boolean;
    opcion_real: Integer;
  procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    procedure actualizar(opcion_act:Integer);
    procedure act_asociado(opcion_a: integer);
    procedure limpiar;
    procedure afilia_eps;
  published


    { Public declarations }
  end;

var
  FrmPrograma: TFrmPrograma;

implementation
uses unitdatamodulo,unitdata,UnitDataquerys,Unitquerys,UnitBeneficiario,UnitGlobal,
  UnitAfiliacion, UnitNuevaAfiliacion;

{$R *.dfm}

procedure TFrmPrograma.actualizar(opcion_act:Integer);
var    no_entrada :Integer;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          if opcion_act = 1 then
          begin
            SQL.Add('update "fun$beneficiario" set');
            SQL.Add('"fun$beneficiario"."nombres" = :nombres,');
            //****** cambio de forma de registrar la informacion
            SQL.Add('"fun$beneficiario".NOMBRE1 = :nombre1,');
            SQL.Add('"fun$beneficiario".APELLIDO1 = :apellido1,');
            SQL.Add('"fun$beneficiario".APELLIDO2 = :apellido2,');
            //***** ojo se cambiaron los nombres
            SQL.Add('"fun$beneficiario"."tipo_id" = :tipo_id,');
            SQL.Add('"fun$beneficiario"."identificacion" = :identificacion,');
            SQL.Add('"fun$beneficiario"."lugar_id" = :lugar_id,');
            SQL.Add('"fun$beneficiario"."sexo" = :sexo,');
            SQL.Add('"fun$beneficiario"."estrato" = :estrato,');
            SQL.Add('"fun$beneficiario"."direccion" = :direccion,');
            SQL.Add('"fun$beneficiario"."barrio" = :barrio,');
            SQL.Add('"fun$beneficiario"."telefono" = :telefono,');
            SQL.Add('"fun$beneficiario"."fecha_nacimiento" = :fecha_nacimiento,');
            SQL.Add('"fun$beneficiario"."ciudad" = :ciudad,');
            SQL.Add('"fun$beneficiario"."MAIL" = :MAIL');
            SQL.Add('where "fun$beneficiario"."identificacion" = :nit');
            ParamByName('nit').AsString := TEnit.Text;
          end
          else
          begin
            SQL.Add('SELECT');
            SQL.Add('MAX("fun$beneficiario"."no_entrada") AS maxentrada');
            SQL.Add('FROM');
            SQL.Add('"fun$beneficiario"');
            Open;
            no_entrada := FieldByName('maxentrada').AsInteger + 1;
            SQL.Clear;
            SQL.Add('insert into "fun$beneficiario"');
            SQL.Add('values (');
            SQL.Add(':nombres,');
            SQL.Add(':nombre1,');
            SQL.Add(':apellido1,');
            SQL.Add(':apellido2,');
            // ojo se cambiaron los nombres
            SQL.Add(':tipo_id,');
            SQL.Add(':identificacion,');
            SQL.Add(':lugar_id,');
            SQL.Add(':sexo,');
            SQL.Add(':estrato,');
            SQL.Add(':direccion,');
            SQL.Add(':barrio,');
            SQL.Add(':telefono,');
            SQL.Add(':fecha_nacimiento,');
            SQL.Add(':ciudad,');
            SQL.Add(':es_titular,');
            SQL.Add(':estado,');
            SQL.Add(':no_entrada,:MAIL)');
            ParamByName('es_titular').AsInteger := titular;
            ParamByName('estado').AsInteger := 1;
            ParamByName('no_entrada').AsInteger := no_entrada;
          end;
            ParamByName('nombres').AsString := TEnombres.Text;
            //*****
            ParamByName('nombre1').AsString := nombre1.Text;
            ParamByName('apellido1').AsString := apellido1.Text;
            ParamByName('apellido2').AsString := apellido2.Text;
            //*****
            ParamByName('tipo_id').AsInteger := DBtiponit.KeyValue;
            ParamByName('identificacion').AsString := TEnit.Text;
            ParamByName('sexo').AsString := LeftStr(Csexo.Text,1);
            ParamByName('lugar_id').AsString := TElugar.Text;
            ParamByName('estrato').AsString := TEestrato.Text;
            ParamByName('direccion').AsString := TEdireccion.Text;
            ParamByName('barrio').AsString := TEBarrio.Text;
            ParamByName('telefono').AsString := TEtelefono.Text;
            ParamByName('fecha_nacimiento').AsDateTime := StrToDateTime(DTFECHA.Text);
            ParamByName('ciudad').AsString := TEciudad.Text;
            ParamByName('MAIL').AsString := EdMail.Text;
            ExecSQL;
            Close;
            Transaction.Commit;
        end;

end;
procedure TFrmPrograma.cmChildKey(var msg: TWMKEY);
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
procedure TFrmPrograma.FormCreate(Sender: TObject);
begin
        IBtipo.Open;
        IBtipo.Last;
        IBEps.Open;
        IBEps.Last;
        IBparentesco.Open;
        IBparentesco.Last;
end;

procedure TFrmPrograma.BcancelarClick(Sender: TObject);
begin
        limpiar;
        Close;
        if afiliacion = 0 then
        begin
          if opcion = 1 then
             FrmAfiliacion.DBoficina.SetFocus
          else if opcion = 2 then
             FrmAfiliacion.DBoficina.SetFocus
          else
             FrmAfiliacion.BTagregar.SetFocus;
        end
        else
           FrmNuevaAfiliacion.BTagregar.SetFocus;
        {if opcion = 5 then
        begin
          with FrmAfiliacion.CDafiliacion do
          begin
            Append;
            FieldValues['nit_asociado'] := FrmAfiliacion.TEdocumento.Text;
            FieldValues['nit_beneficiario'] := TEnit.Text;
            FieldValues['id_convenio'] := FrmAfiliacion.DBconvenio.KeyValue;
            FieldValues['fecha'] := FrmAfiliacion.DTfecha.Date;
            FieldValues['id_parentesco'] := DBparentesco.KeyValue;
            FrmAfiliacion.id_afiliacion := FrmAfiliacion.id_afiliacion +1;
            FieldValues['id_afiliacion'] := FrmAfiliacion.id_afiliacion;
            FieldValues['es_afiliacion'] := Ord(FrmAfiliacion.es_afiliacion);
            if FrmAfiliacion.oficina = 1 then
               FieldValues['es_local'] := 1
            else
               FieldValues['es_local'] := 0;
            FieldValues['nombres'] := TEnombres.Text;
            FieldValues['parentesco'] := DBparentesco.Text;
            Post;
          end;
          end;}
end;

procedure TFrmPrograma.BaceptarClick(Sender: TObject);
var    edad :Variant;
begin
        try
          edad := 0;//int((int(Date) - int(StrToDate(DTfecha.Text)))/365.25);
          {if parametro(DBparentesco.KeyValue,codigo_convenio,edad,'a',DataQuerys.IBdatos) = False then begin
             if MessageDlg('El Beneficiario no Concuerda con los parametros del Convenio'+#13+'                            Desea continuar?',mtInformation,[mbyes,mbno],0) = mrno then begin
                TEnit.SetFocus;
                Exit;
             end;
          end;}
          except
          on E: Exception do
          begin
            MessageDlg('Favor Actualice los Datos, Falta la Fecha de Nacimiento',mtInformation,[mbok],0);
            DTfecha.SetFocus;
            Exit;
          end;
       end;
        //Exit; !9999/99/99;1;_
        // para los parametros
        if opcion = 1 then
        begin
           actualizar(1);
           if actualiza_dato then
              act_asociado(2)
           else
              act_asociado(1);
         end
         else if opcion = 2 then
         begin
           actualizar(2);
           act_asociado(2);
         end
         else if (opcion = 3) or (opcion = 5) then
              actualizar(1)
         else
              actualizar(2);


        if opcion = 5 then FrmAfiliacion.CDafiliacion.Delete;
        if (opcion >= 3) then
        begin
        if afiliacion = 0 then
        begin
          with FrmAfiliacion.CDafiliacion do
          begin
            Append;
            FieldValues['nit_asociado'] := FrmAfiliacion.TEdocumento.Text;
            FieldValues['nit_beneficiario'] := TEnit.Text;
            FieldValues['id_convenio'] := FrmAfiliacion.DBconvenio.KeyValue;
            FieldValues['fecha'] := FrmAfiliacion.DTfecha.Date;
            FieldValues['id_parentesco'] := DBparentesco.KeyValue;
            FrmAfiliacion.id_afiliacion := FrmAfiliacion.id_afiliacion +1;
            FieldValues['id_afiliacion'] := FrmAfiliacion.id_afiliacion;
            FieldValues['es_afiliacion'] := Ord(FrmAfiliacion.es_afiliacion);
            if FrmAfiliacion.oficina = 1 then
               FieldValues['es_local'] := 1
            else
               FieldValues['es_local'] := 0;
            FieldValues['nombres'] := TEnombres.Text + ' ' + nombre1.Text + ' ' + apellido1.Text + ' ' + apellido2.Text;
            //*** nombres y apellidos por separado
            {FieldValues['nombre1'] := TEnombres.Text;
            FieldValues['nombre2'] := nombre1.Text;
            FieldValues['apellido1'] := apellido1.Text;
            FieldValues['apellido2'] := apellido2.Text;}
            //***

            FieldValues['parentesco'] := DBparentesco.Text;
            FieldValues['fecha_na'] := StrToDate(DTfecha.Text);
            //FieldValues['cod_oficina'] := codigo_oficina;
            Post;
          end;
        end
        else
        begin
          with FrmNuevaAfiliacion.CDafiliacion do
          begin
            Append;
            FieldValues['nit_asociado'] := FrmnuevaAfiliacion.TEdocumento.Text;
            FieldValues['nit_beneficiario'] := TEnit.Text;
            FieldValues['id_convenio'] := FrmnuevaAfiliacion.DBconvenio.KeyValue;
            FieldValues['fecha'] := FrmnuevaAfiliacion.DTfecha.Date;
            FieldValues['id_parentesco'] := DBparentesco.KeyValue;
            FrmNuevaAfiliacion.id_afiliacion := FrmnuevaAfiliacion.id_afiliacion +1;
            FieldValues['id_afiliacion'] := FrmnuevaAfiliacion.id_afiliacion;
            FieldValues['es_afiliacion'] := 1;
            if FrmnuevaAfiliacion.oficina = 1 then
               FieldValues['es_local'] := 1
            else
               FieldValues['es_local'] := 0;
            FieldValues['nombres'] := TEnombres.Text + ' ' + nombre1.Text + ' ' + apellido1.Text + ' ' + apellido2.Text;
                        //*** nombres y apellidos por separado
            {FieldValues['nombre1'] := TEnombres.Text;
            FieldValues['nombre2'] := nombre1.Text;
            FieldValues['apellido1'] := apellido1.Text;
            FieldValues['apellido2'] := apellido2.Text;}
            //***


            FieldValues['parentesco'] := DBparentesco.Text;
            FieldValues['fecha_na'] := StrToDate(DTfecha.Text);
            Post;
          end;
          end;
          end;
        if (opcion = 1) or (opcion = 2) then
        begin
           FrmAfiliacion.TEcuenta.EditMask := '';
           FrmAfiliacion.TEcuenta.Text := TEcuenta.Text;
           FrmAfiliacion.TEnombres.Text := TEnombres.Text;
        end;
        try
        afilia_eps;
        except
        limpiar;
        end;
        limpiar;
        if afiliacion = 0 then
           FrmAfiliacion.SetFocus
        else
           FrmNuevaAfiliacion.SetFocus;
        DTfecha.Text := '';
        Close;
end;

procedure TFrmPrograma.act_asociado(opcion_a: integer);
begin
          with DataQuerys.IBdatos do
          begin
            Close;
            verificatransaccion(DataQuerys.IBdatos);
            SQL.Clear;
            if opcion_a = 1 then
            begin
              SQL.Add('update "fun$datos_asociado" set');
              SQL.Add('"fun$datos_asociado"."numero_cuenta" = :no_cuenta');
              SQL.Add('where "fun$datos_asociado"."nit_asociado" = :nit_asociado');
            end
            else
            begin
              SQL.Add('insert into "fun$datos_asociado"');
              SQL.Add('values (');
              SQL.Add(':nit_asociado,:oficina,:no_cuenta)');
              ParamByName('oficina').AsInteger := codigo_oficina;
            end;
              ParamByName('nit_asociado').AsString := TEnit.Text;
              ParamByName('no_cuenta').AsString := TEcuenta.Text;
              Open;
              Close;
              Transaction.Commit;
          end;
end;

procedure TFrmPrograma.limpiar;
begin
        TEnombres.Text := '';
        TEnit.Text := '';
        TEBarrio.Text := '';
        TECiudad.Text := '';
        TEtelefono.Text := '';
        TEdireccion.Text := '';
        TElugar.Text := '';
        TEestrato.Text := '';
        DBparentesco.KeyValue := 19;
        DBtiponit.KeyValue := 6;
        Csexo.ItemIndex := -1;
        TEnit.SetFocus;
end;

procedure TFrmPrograma.TEnitExit(Sender: TObject);
begin
        opcion := opcion_real;
        if afiliacion = 1 then
        begin
          codigo_convenio := FrmnuevaAfiliacion.DBconvenio.KeyValue;
          convenio := FrmnuevaAfiliacion.DBconvenio.Text;
          if TEnit.text = FrmNuevaAfiliacion.TEdocumento.Text then
          begin
            MessageDlg('No se Puede Registrar, Es el Titular de la Cuenta',mtInformation,[mbok],0);
            TEnit.SetFocus;
            Exit;
          end;
        end
        else
        codigo_convenio := FrmAfiliacion.DBconvenio.KeyValue;
        if TEnit.Text <> '' then
        begin
        if opcion < 5 then
        begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$afiliacion"."fecha"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."nit_beneficiario" = :ced) and');
          SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
          ParamByName('ced').AsString := TEnit.Text;
          ParamByName('convenio').AsInteger := codigo_convenio;
          Open;
          if RecordCount <> 0 then
          begin
            if MessageDlg('El Beneficiario ya se Encuentra Afiliado al Programa '+#13+'          '+convenio+#13+ 'con Fecha '+FormatDateTime('dd/mmmm/yyyy',FieldByName('fecha').AsDateTime)+' Desea Continuar.',mtInformation,[mbyes,mbno],0) = mrno then
            begin
            TEnit.Text := '';
            TEnit.SetFocus;
            Exit;
            end;
          end;
          Close;
        end;
        if afiliacion = 0 then
        begin
          if FrmAfiliacion.CDafiliacion.Locate('nit_beneficiario',TEnit.Text,[loPartialKey]) then
          begin
             MessageDlg('Se Encuentra Actualmente en la Lista de Beneficiarios',mtInformation,[mbok],0);
             TEnit.Text := '';
             TEnit.SetFocus;
             Exit;
          end;
        end
        else
        begin
          if FrmnuevaAfiliacion.CDafiliacion.Locate('nit_beneficiario',TEnit.Text,[loPartialKey]) then
          begin
             MessageDlg('Se Encuentra Actualmente en la Lista de Beneficiarios',mtInformation,[mbok],0);
             TEnit.Text := '';
             TEnit.SetFocus;
             Exit;
          end;
        end;
          if opcion  = 1 then
          begin
            with DataQuerys.IBdatos do
            begin
              Close;
              verificatransaccion(DataQuerys.IBdatos);
              SQL.Clear;
              SQL.Add('SELECT');
              SQL.Add(' * ');
              SQL.Add('FROM');
              SQL.Add('"fun$datos_asociado"');
              SQL.Add('WHERE');
              SQL.Add('("fun$datos_asociado"."nit_asociado" = :nit)');
              ParamByName('nit').AsString := TEnit.Text;
              Open;
              if RecordCount <> 0 then
              begin
                actualiza_dato := False;
                TEcuenta.Text := FieldByName('numero_cuenta').AsString;
                DBparentesco.KeyValue := 1;
              end
              else
                 actualiza_dato := True;
              Close;
            end;
          //end;

        end
        else if opcion = 3 then // beneficiarios
        begin
          with DataQuerys.IBdatos do
          begin
            Close;
            verificatransaccion(DataQuerys.IBdatos);
            SQL.Clear;
            SQL.Add('select * from BUSCA_BENE(:NIT)');
            ParamByName('NIT').AsString := TEnit.Text;
            Open;
            if RecordCount <> 0 then
            begin
              TEnombres.Text := FieldByName('NOMBRES').AsString;
              nombre1.Text := FieldByName('NOMBRE1').AsString;
              apellido1.Text := FieldByName('APELLIDO1').AsString;;
              apellido2.Text := FieldByName('APELLIDO2').AsString;
              TEnit.Text :=  FieldByName('ID_PERSONA').AsString;
              TElugar.Text := FieldByName('LUGAR_ID').AsString;
              TEBarrio.Text := FieldByName('BARRIO').AsString;
              TEdireccion.Text := FieldByName('DIRECCION').AsString;
              TECiudad.Text := FieldByName('MUNICIPIO').AsString;
              TEtelefono.Text := FieldByName('TELEFONO').AsString;
              DTfecha.Text := FieldByName('FECHA_NACIMIENTO').AsString;
              if FieldByName('SEXO').AsString = 'M' then
                Csexo.ItemIndex := 0
              else
                 Csexo.ItemIndex := 1;
             DBtiponit.KeyValue := FieldByName('TIPO_ID').AsInteger;
             TEestrato.Text := FieldByName('ESTRATO').AsString;
             no_registro := FieldByName('NO_ENTRADA').AsInteger;
             end
          else
             opcion := 4;
        end;
        end;
        end;
end;
end;
procedure TFrmPrograma.DBparentescoExit(Sender: TObject);
begin
        if DBparentesco.KeyValue = 1 then
           titular := 1
        else
           titular := 0;
end;

procedure TFrmPrograma.afilia_eps;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('insert into "fun$afiliacioneps" values (');
          SQL.Add(':id_eps,:nit_beneficiario,:id_convenio)');
          ParamByName('id_eps').AsInteger := Eps.KeyValue;
          ParamByName('nit_beneficiario').AsString := TEnit.Text;
          ParamByName('id_convenio').AsInteger := 1;
          Open;
          Close;
          Transaction.Commit;
        end;

end;

end.
