unit UnitRegistropas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, IBDatabase, DB, IBCustomDataSet,
  IBQuery, JvLabel, JvEdit, Buttons, jclsysutils, Mask, DBClient,
  JvStaticText;

type
  TFrmRegistropas = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    descripcion: TDBLookupComboBox;
    Label3: TLabel;
    tipo: TEdit;
    Label4: TLabel;
    lugar: TEdit;
    Label5: TLabel;
    asistente: TEdit;
    IBQuery1: TIBQuery;
    IBTransaction1: TIBTransaction;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    TEdocumento: TJvEdit;
    JvLabel1: TJvLabel;
    nombres: TJvEdit;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    municipio: TJvEdit;
    Panel3: TPanel;
    BCancelar: TSpeedButton;
    SPcerrar: TSpeedButton;
    Baceptar: TBitBtn;
    IBQuery2: TIBQuery;
    IBTransaction2: TIBTransaction;
    DataSource2: TDataSource;
    cuenta: TMaskEdit;
    oficina: TDBLookupComboBox;
    cdoficina: TClientDataSet;
    cdoficinaid_agencia: TIntegerField;
    cdoficinadescripcion: TStringField;
    Label9: TLabel;
    Numero: TEdit;
    Label10: TLabel;
    JVcupo: TJvStaticText;
    Label11: TLabel;
    DBtipo: TDBLookupComboBox;
    IBtipodoc: TIBQuery;
    DStipo: TDataSource;
    IBTransaction3: TIBTransaction;
    procedure FormCreate(Sender: TObject);
    procedure SPcerrarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure descripcionExit(Sender: TObject);
    procedure oficinaExit(Sender: TObject);
    procedure TEdocumentoExit(Sender: TObject);
    procedure BaceptarClick(Sender: TObject);
  private
    opcion_oficina :Boolean;
    opcion_capacitacion :Boolean;
    tipo_capacitacion :Integer;
    Educacion :Boolean;
    id_programa: smallint;
    procedure local;
    procedure agencias;
    function busca_cuenta(nit: string): string;
    function verifica_capacitacion(nit: string; tipo: integer): boolean;
    function numero1(id: integer): integer;

    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmRegistropas: TFrmRegistropas;

implementation

uses UnitQuerys,UnitGlobal, UnitdataQuerys, UnitActualiza, UnitGlobales;

{$R *.dfm}

procedure TFrmRegistropas.cmChildKey(var msg: TWMKEY);
begin
if Msg.CharCode = VK_RETURN then
    if not (Assigned(ActiveControl) and
           ((ActiveControl is TButton) or
            (ActiveControl is TCustomMemo)))
    then begin
      msg.Result := 1;
      keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), 0, 0);
      Keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), KEYEVENTF_KEYUP, 0);
    end;
end;

procedure TFrmRegistropas.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        IBQuery1.Open;
        IBQuery1.Last;
        //oficina.KeyValue := 1;
        with IBQuery2 do
        begin
          Close;
          Open;
          while not Eof do
          begin
            cdoficina.Append;
            cdoficina.FieldValues['id_agencia'] := FieldByName('ID_AGENCIA').AsInteger;
            cdoficina.FieldValues['descripcion'] := FieldByName('DESCRIPCION_AGENCIA').AsString;
            cdoficina.Post;
            Next;
          end;
        end;
        cdoficina.Append;
        cdoficina.FieldValues['id_agencia'] := 10;
        cdoficina.FieldValues['descripcion'] := 'OTRAS';
        cdoficina.Post;
        Next;
        if IBtipodoc.Transaction.InTransaction then
           IBtipodoc.Transaction.Rollback;
        IBtipodoc.Transaction.StartTransaction;
        IBtipodoc.Open;
        IBtipodoc.Last;
end;

procedure TFrmRegistropas.SPcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmRegistropas.BCancelarClick(Sender: TObject);
begin
        tipo.Text := '';
        lugar.Text := '';
        asistente.Text := '';
        TEdocumento.Text := '';
        nombres.Text := '';
        cuenta.Text := '';
        cuenta.EditMask := ''; 
        municipio.Text := '';
        descripcion.SetFocus;
        Numero.Text := '';
        JVcupo.Caption := '';
end;

procedure TFrmRegistropas.descripcionExit(Sender: TObject);
var     cupo :Integer;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$tipocapacitacion"."descripcion",');
          SQL.Add('"fun$tipocapacitacion"."id_tipo",');
          SQL.Add('"fun$capacitacion"."esjuvenil",');
          SQL.Add('"fun$capacitacion"."lugar",');
          SQL.Add('"fun$capacitacion"."fecha",');
          SQL.Add('"fun$capacitacion"."id_programa",');
          SQL.Add('"fun$capacitacion"."cupo"');
          SQL.Add('FROM');
          SQL.Add('"fun$capacitacion"');
          SQL.Add('INNER JOIN "fun$tipocapacitacion" ON ("fun$capacitacion"."id_tipocapacitacion" = "fun$tipocapacitacion"."id_tipo")');
          SQL.Add('WHERE');
          SQL.Add('("fun$capacitacion"."estado" = 1) AND');
          SQL.Add('("fun$capacitacion"."id_capacitacion" = :id)');
          try
            ParamByName('id').AsInteger := descripcion.KeyValue;
          except
          on e: Exception do
          begin
             descripcion.SetFocus;
             Exit;
          end;
          end;
          Open;
          cupo := FieldByName('cupo').AsInteger;
          tipo.Text := FieldByName('descripcion').AsString;
          lugar.Text := FieldByName('lugar').Text  + ' Fecha: ' + FormatDateTime('dd-mmm-yyyy',FieldByName('fecha').AsDateTime);
          tipo_capacitacion := FieldByName('id_tipo').AsInteger;
          if FieldByName('esjuvenil').AsInteger = 1 then
          begin
             asistente.Text := 'ahorradores juveniles de la cooperativa';
             opcion_capacitacion := True;
          end
          else
          begin
             asistente.Text := 'asociados adultos de la cooperativa';
             opcion_capacitacion := False;
          end;
          Close;
          Transaction.Commit;
        end;
        if cupo <= numero1(descripcion.KeyValue) then
        begin
           MessageDlg('El Cupo ya se Encuentra Completo'+#13+'El cupo Máximo fue de '+IntToStr(cupo),mtInformation,[mbok],0);
           BCancelar.Click;
           Exit;
        end;
        Numero.Text := IntToStr(numero1(descripcion.KeyValue));
        JVcupo.Caption := IntToStr(cupo);
end;

procedure TFrmRegistropas.oficinaExit(Sender: TObject);
begin
        try
          opcion_oficina := False;//IntToBool(oficina.KeyValue);
          if oficina.KeyValue = agencia then
             opcion_oficina := True//IntToBool(oficina.KeyValue)
          else
             opcion_oficina := False;
        except
        on e: Exception do
          oficina.SetFocus;
        end;
end;

procedure TFrmRegistropas.local;
var     id_identificacion :Integer;
begin
        cuenta.EditMask := '!999-999999;1;0';
        if opcion_capacitacion then
        begin
          with FrmQuerys.IBseleccion do
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"gen$persona".NOMBRE,');
            SQL.Add('"gen$persona".ID_IDENTIFICACION,');
            SQL.Add('"gen$persona".PRIMER_APELLIDO,');
            SQL.Add('"gen$persona".SEGUNDO_APELLIDO,');
            SQL.Add('"gen$persona".EDUCACION,');
            SQL.Add('"gen$persona".FECHA_NACIMIENTO,');
            SQL.Add('"cap$maestrotitular".NUMERO_CUENTA,');
            SQL.Add('"gen$persona".provincia_nacimiento');
            SQL.Add('FROM');
            SQL.Add('"cap$maestrotitular"');
            SQL.Add('INNER JOIN "gen$persona" ON ("cap$maestrotitular".ID_PERSONA = "gen$persona".ID_PERSONA)');
            SQL.Add('WHERE');
            SQL.Add('("cap$maestrotitular".ID_TIPO_CAPTACION = 4) AND');
            SQL.Add('("cap$maestrotitular".NUMERO_TITULAR = 2) and');
            SQL.Add('("gen$persona".id_persona = :nit) and ("gen$persona".ID_IDENTIFICACION = :OP)');
            ParamByName('OP').AsInteger := DBtipo.KeyValue;
            ParamByName('nit').AsString := TEdocumento.Text;
            Open;
            id_identificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
            nombres.Text := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
            try
            municipio.Text := 'Edad:' + IntToStr(edad1(FieldByName('FECHA_NACIMIENTO').AsDateTime)) + ' Años';
            except
            municipio.Text := '0';
            end;
            cuenta.Text := '401-'+FieldByName('NUMERO_CUENTA').Text;
            Close;
          end;
        end
        else
        begin
          with FrmQuerys.IBseleccion do
          begin
            Close;
            verificatransaccion(FrmQuerys.IBseleccion);
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"gen$persona".NOMBRE,');
            SQL.Add('"gen$persona".PRIMER_APELLIDO,');
            SQL.Add('"gen$persona".SEGUNDO_APELLIDO,');
            SQL.Add('"gen$persona".EDUCACION,');
            SQL.Add('"gen$persona".ID_IDENTIFICACION');
            //SQL.Add('"cap$maestrotitular".NUMERO_CUENTA,');
            //SQL.Add('"gen$persona".provincia_nacimiento');
            SQL.Add('FROM');
            SQL.Add('"gen$persona"');
            //SQL.Add('INNER JOIN "gen$persona" ON ("cap$maestrotitular".ID_PERSONA = "gen$persona".ID_PERSONA)');
            //SQL.Add('INNER JOIN "cap$maestro" ON ("cap$maestrotitular".NUMERO_CUENTA = "cap$maestro".NUMERO_CUENTA) AND ("cap$maestrotitular".ID_TIPO_CAPTACION = "cap$maestro".ID_TIPO_CAPTACION)');
            SQL.Add('WHERE');
            //SQL.Add('("cap$maestrotitular".ID_TIPO_CAPTACION = 2) AND');
            //SQL.Add('("cap$maestrotitular".NUMERO_TITULAR = 1) and');
            //SQL.Add('("cap$maestro".ID_ESTADO = 1)and');
            SQL.Add('("gen$persona".ID_PERSONA = :nit) and (ID_IDENTIFICACION = :ID_IDENTIFICACION)');
            ParamByName('ID_IDENTIFICACION').AsInteger := DBtipo.KeyValue;
            ParamByName('nit').AsString := TEdocumento.Text;
            Open;
            id_identificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
            nombres.Text := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
            //cuenta.Text := '201-'+FieldByName('NUMERO_CUENTA').Text;
            Educacion := IntToBool(FieldByName('EDUCACION').AsInteger);
            //municipio.Text := FieldByName('provincia_nacimiento').Text;
            SQL.Clear;
            SQL.Add('SELECT * FROM P_CAP_0008 (:ID_AGENCIA,:ID_TIPO_CAPTACION,:ID_IDENTIFICACION,:ID_PERSONA)');
            ParamByName('ID_AGENCIA').AsInteger := oficina.KeyValue;
            ParamByName('ID_TIPO_CAPTACION').AsInteger := 2;
            ParamByName('ID_IDENTIFICACION').AsInteger := DBtipo.KeyValue;
            ParamByName('ID_PERSONA').AsString := TEdocumento.Text;
            Open;
            cuenta.Text := '201-'+FieldByName('NUMERO_CUENTA').Text;
            Close;
          end;
        end;
        Exit;

end;

procedure TFrmRegistropas.TEdocumentoExit(Sender: TObject);
begin
        if opcion_oficina then
        begin
          local;
          if nombres.Text = '  'then
          begin
           MessageDlg('No Existe el Asociado',mtInformation,[mbok],0);
           oficina.SetFocus;
           Exit;
        end;
        end
        else
        begin
         Baceptar.Enabled := True;
         agencias;
         Exit;
        end;
        if (Educacion = False) and (tipo_capacitacion <> 1) and (opcion_capacitacion = False) then
        begin
          MessageDlg('Debe Realizar Primero el Curso de Capacitacion Basica',mtInformation,[mbok],0);
          BCancelar.Click;
          Exit;
        end;

        if (tipo_capacitacion = 1) and (Educacion) then
        begin
            if MessageDlg('El Asociado ya Realizo la Capacitacion Referente a '+#13+tipo.Text+ ' Desea Continuar?',mtInformation,[mbyes,mbno],0) = mrno then
            begin
            BCancelar.Click;
            Exit;
            end;
        end
        else if verifica_capacitacion(TEdocumento.Text,tipo_capacitacion) = False then
        begin
          if MessageDlg('El Asociado ya Realizo la Capacitacion Referente a '+#13+tipo.Text+' Desea Continuar?',mtInformation,[mbyes,mbno],0) = mrNo then
          begin
             BCancelar.Click;
             Exit;
          end;
        end;
        Baceptar.Enabled := True;
end;

procedure TFrmRegistropas.agencias;
begin
        FrmActualizarD := TFrmActualizarD.Create(self);
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select * FROM BUSCA_BENE(:NIT)');
          ParamByName('NIT').AsString := TEdocumento.Text;
          Open;
          if RecordCount = 0 then
          begin
            MessageDlg('El Asociado no Existe, Debe Ingresar los Datos del Mismo',mtInformation,[mbok],0);
            FrmActualizarD.control_entrada := 1;
            FrmActualizarD.control_actualizacion := True;
            FrmActualizarD.TEnit.Text := tedocumento.Text;
            FrmActualizarD.Label10.Caption := 'Cuenta';
            FrmActualizarD.ShowModal;
            Abort;
          end;
          nombres.Text := FieldByName('nombres').AsString;
          //municipio.Text := FieldByName('municipio').AsString;
          cuenta.Text := busca_cuenta(TEdocumento.Text);
          Close;
        end;

end;

function TFrmRegistropas.busca_cuenta(nit: string): string;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$datos_asociado"."numero_cuenta"');
          SQL.Add('FROM');
          SQL.Add('"fun$datos_asociado"');
          SQL.Add('WHERE');
          SQL.Add('("fun$datos_asociado"."nit_asociado" = :nit)');
          ParamByName('nit').AsString := nit;
          Open;
          Result := FieldByName('numero_cuenta').AsString;
          Close;
        end;
end;

procedure TFrmRegistropas.BaceptarClick(Sender: TObject);
begin
        try
         with DataQuerys.IBdatos do
         begin
           Close;
           verificatransaccion(DataQuerys.IBdatos);
           SQL.Clear;
           SQL.Add('insert into "fun$capacitacionper" values(');
           SQL.Add(':id_capacitacion,:id_persona,:oficina,:telefono)');
           ParamByName('id_capacitacion').AsInteger := descripcion.KeyValue;
           ParamByName('id_persona').AsString := TEdocumento.Text;
           ParamByName('oficina').AsSmallInt := oficina.KeyValue;
           ParamByName('telefono').AsString := municipio.Text;
           ExecSQL;
           Close;
           Transaction.Commit;
          end;
         except
         on e: Exception do
         begin
           MessageDlg('El Asociado Ya se Encuentra Registrado',mtWarning,[mbok],0);
           TEdocumento.SetFocus;
           Exit;
         end;
         end;
         BCancelar.Click;
         Baceptar.Enabled := False;
        Numero.Text := IntToStr(numero1(descripcion.KeyValue));
end;

function TFrmRegistropas.verifica_capacitacion(nit: string;
  tipo: integer): boolean;
begin
        with DataQuerys.IBFundacion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$capacitacion"."id_programa"');
          SQL.Add('FROM');
          SQL.Add('"fun$capacitacion"');
          SQL.Add('INNER JOIN "fun$capacitacionper" ON ("fun$capacitacion"."id_capacitacion" = "fun$capacitacionper"."id_capacitacion")');
          SQL.Add('WHERE');
          SQL.Add('("fun$capacitacionper"."id_persona" = :nit)');
          SQL.Add('and("fun$capacitacion"."id_tipocapacitacion" = :id)');
          ParamByName('nit').AsString := nit;
          ParamByName('id').AsInteger := tipo;
          Open;
          if FieldByName('id_programa').AsInteger = 0 then
             Result := True
          else
             Result := False;
          Close;
        end;
end;



function TFrmRegistropas.numero1(id: integer): integer;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('select count(*) as contador from "fun$capacitacionper"');
          SQL.Add('where "fun$capacitacionper"."id_capacitacion" = :id');
          ParamByName('id').AsInteger := id;
          Open;
          Result := FieldByName('contador').AsInteger;
          Close;
          Transaction.Commit;
        end;
end;
end.
