unit UnitAfiliacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, DB, IBCustomDataSet, IBQuery,
  IBDatabase, JvEdit, JvLabel, ComCtrls, JvPanel, Grids, DBGrids, Buttons,
  JvTypedEdit, Mask, DBClient,JclSysUtils, Menus, ImgList;

type
  TFrmAfiliacion = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DBoficina: TDBLookupComboBox;
    DSoficina: TDataSource;
    IBoficina: TIBQuery;
    IBToficina: TIBTransaction;
    IBconvenio: TIBQuery;
    DSconvenio: TDataSource;
    Label3: TLabel;
    DBconvenio: TDBLookupComboBox;
    Label4: TLabel;
    TEdocumento: TJvEdit;
    JvLabel1: TJvLabel;
    TEnombres: TJvEdit;
    JvLabel2: TJvLabel;
    DTfecha: TDateTimePicker;
    JvLabel3: TJvLabel;
    JvPanel1: TJvPanel;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    BTagregar: TBitBtn;
    BTeliminar: TBitBtn;
    Panel2: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBplan: TDBLookupComboBox;
    TEvalor: TJvCurrencyEdit;
    JvPanel2: TJvPanel;
    BTaceptar: TBitBtn;
    IBplan: TIBQuery;
    DSplan: TDataSource;
    BTcerrar: TSpeedButton;
    TEcuenta: TMaskEdit;
    CDafiliacion: TClientDataSet;
    CDafiliacionnit_asociado: TStringField;
    CDafiliacionnit_beneficiario: TStringField;
    CDafiliacionid_convenio: TIntegerField;
    CDafiliacionfecha: TDateField;
    CDafiliacionid_parentesco: TIntegerField;
    CDafiliacionid_afiliacion: TIntegerField;
    CDafiliaciones_afiliacion: TIntegerField;
    CDafiliaciones_local: TIntegerField;
    CDafiliacionnombres: TStringField;
    CDafiliacionparentesco: TStringField;
    DSdatos: TDataSource;
    ClientDataSet1: TClientDataSet;
    CDafiliacionfecha_na: TDateField;
    BTverificar: TBitBtn;
    PMenu: TPopupMenu;
    VerFechasdeVencimiento1: TMenuItem;
    ImageList1: TImageList;
    CDafiliacionfecha_ven: TDateField;
    BTcancelar: TSpeedButton;
    BTcarne: TBitBtn;
    CDcarnet: TClientDataSet;
    CDcarnetnit_beneficiario: TStringField;
    CDcarnetprograma: TIntegerField;
    CDcarnetno_carnet: TStringField;
    CDcarnetdescripcion: TStringField;
    CDcarnetnombres: TStringField;
    Label9: TLabel;
    cbZona: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure TEdocumentoExit(Sender: TObject);
    procedure DBoficinaExit(Sender: TObject);
    procedure DBconvenioExit(Sender: TObject);
    procedure BTcerrarClick(Sender: TObject);
    procedure BTcancelarClick(Sender: TObject);
    procedure BTagregarClick(Sender: TObject);
    procedure BTeliminarClick(Sender: TObject);
    procedure BTverificarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BTaceptarClick(Sender: TObject);
    procedure DTfechaExit(Sender: TObject);
    procedure DBGrid1Enter(Sender: TObject);
    procedure VerFechasdeVencimiento1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTcarneClick(Sender: TObject);
  private
    control_agrega: boolean;
    verifica_asociado: boolean;
    id_afiliacion_plan: integer;
    procedure limpiar;
    procedure registrar;
    procedure asociado;
    function fecha_v(nit: string;opcion:Integer): tdate;
    procedure plan;
    function verifica_renovacion(nit,convenio: string): boolean;
    function id_registra: integer;
   

    { Private declarations }
  public

    id_afiliacion :Integer;
    oficina :Smallint;
    es_afiliacion: boolean;

  published
    function busca_fecha(id_convenio: integer): Integer;
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;
var
  FrmAfiliacion: TFrmAfiliacion;

implementation
uses unitdatamodulo, UnitQuerys, UnitPrograma, UnitdataQuerys,UnitGlobal,UnitGlobales,
  UnitFechaven, UnitPrincipal, UnitActCarne, UnitReEps;

{$R *.dfm}

procedure TFrmAfiliacion.cmChildKey(var msg: TWMKEY);
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

procedure TFrmAfiliacion.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        FrmPrograma := TFrmPrograma.Create(self);
        DTfecha.Date := Date;
        IBoficina.Open;
        IBoficina.Last;
        IBconvenio.Open;
        IBconvenio.Last;
        oficina := 100;
        control_agrega := False;
        if es_afiliacion = False then
           DBGrid1.ShowHint := True;
end;

procedure TFrmAfiliacion.TEdocumentoExit(Sender: TObject);
var     id_identificacion :Smallint;
        nombresa :string;
begin
        CDafiliacion.CancelUpdates;
        CDcarnet.CancelUpdates;
        verifica_asociado := True;
          if TEdocumento.Text <> '' then
          begin
              with DataQuerys.IBdatos do
              begin
               Close;
               verificatransaccion(DataQuerys.IBdatos);
               SQL.Clear;
               SQL.Add('SELECT');
               SQL.Add('MAX("fun$afiliacion"."id_afiliacion") AS "maxid"');
               SQL.Add('FROM');
               SQL.Add('"fun$afiliacion"');
               Open;
               id_afiliacion := FieldByName('maxid').AsInteger + 1;
               id_afiliacion_plan := id_afiliacion;
               Close;
             end;
          if es_afiliacion then begin
          with DataQuerys.IBdatos do
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"fun$afiliacion"."fecha"');
            SQL.Add('FROM');
            SQL.Add('"fun$afiliacion"');
            SQL.Add('WHERE');
            SQL.Add('("fun$afiliacion"."nit_beneficiario" = :ced) and');
            SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
            ParamByName('ced').AsString := TEdocumento.Text;
            ParamByName('convenio').AsInteger := DBconvenio.KeyValue;
            Open;
            if RecordCount <> 0 then
            begin
              MessageDlg('El Beneficiario ya se Encuentra Afiliado al Programa '+#13+'          '+DBconvenio.Text,mtInformation,[mbok],0);
              DBoficina.SetFocus;
              Exit;
              end;
            Close;
          end;
          control_agrega := False;
          if oficina = 100 then
          begin
            MessageDlg('Debe Selecionar Una Oficina',mtError,[mbok],0);
            DBoficina.SetFocus;
            Exit;
          end;
          if oficina = Agencia  then
          begin
            with FrmQuerys.IBseleccion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('select * from "gen$persona"');
              SQL.Add('where ID_PERSONA = :ID_PERSONA');
              ParamByName('ID_PERSONA').AsString := TEdocumento.Text;
              Open;
              nombresa := FieldByName('PRIMER_APELLIDO').AsString + ' ' +FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +FieldByName('NOMBRE').AsString;
              id_identificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
              SQL.Clear;
              SQL.Add('SELECT * FROM P_CAP_0008 (:ID_AGENCIA,:ID_TIPO_CAPTACION,:ID_IDENTIFICACION,:ID_PERSONA)');
              ParamByName('ID_AGENCIA').AsInteger := Agencia;
              ParamByName('ID_TIPO_CAPTACION').AsInteger := 1;
              ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
              ParamByName('ID_PERSONA').AsString := TEdocumento.Text;
              Open;
              if RecordCount = 0 then
              begin
                 MessageDlg('Verifique la Informacion el No de Identificacion'+#13+'no se Encuentra Registrado el la Base de Datos.',mtInformation,[mbok],0);
                 DBoficina.SetFocus;
                 Exit;
              end
              else
              begin
              TEcuenta.Text:= '20'+IntToStr(DBoficina.KeyValue)+'-'+FieldByName('NUMERO_CUENTA').AsString;
              TEnombres.Text := nombresa;
              end;
              Close;
            end;
          end
          else
          begin // comienzo otras oficinas
             FrmPrograma.Cuenta.Visible := True;
             FrmPrograma.TEcuenta.Visible := True;
             FrmPrograma.Fecha.Left := 5;
             FrmPrograma.DTfecha.Left := 138;
             with DataQuerys.IBdatos do
             begin
               Close;
               SQL.Clear;
               SQL.Add('select * FROM BUSCA_BENE(:NIT)');
               ParamByName('NIT').AsString := TEdocumento.Text;
               Open;
               if RecordCount <> 0 then
               begin
                  if MessageDlg('El Beneficiario ya Existe, Desea Actualizar los Datos',mtInformation,[mbyes,mbno],0) = mrYes then
                  begin
                    FrmPrograma.TEnombres.Text := FieldByName('NOMBRES').AsString;
                    FrmPrograma.nombre1.Text := FieldByName('NOMBRE1').AsString;
                    FrmPrograma.apellido1.Text := FieldByName('APELLIDO1').AsString;
                    FrmPrograma.apellido2.Text := FieldByName('APELLIDO2').AsString;
                    FrmPrograma.TEnit.Text :=  FieldByName('ID_PERSONA').AsString;
                    FrmPrograma.TElugar.Text := FieldByName('LUGAR_ID').AsString;
                    FrmPrograma.TEBarrio.Text := FieldByName('BARRIO').AsString;
                    FrmPrograma.TEdireccion.Text := FieldByName('DIRECCION').AsString;
                    FrmPrograma.TECiudad.Text := FieldByName('MUNICIPIO').AsString;
                    FrmPrograma.TEtelefono.Text := FieldByName('TELEFONO').AsString;
                    FrmPrograma.DTfecha.Text := FieldByName('FECHA_NACIMIENTO').AsString;
                    FrmPrograma.EdMail.Text := FieldByName('MAIL').AsString;
                    if FieldByName('SEXO').AsString = 'M' then
                       FrmPrograma.Csexo.ItemIndex := 0
                    else
                       FrmPrograma.Csexo.ItemIndex := 1;
                    FrmPrograma.DBtiponit.KeyValue := FieldByName('TIPO_ID').AsInteger;
                    FrmPrograma.TEestrato.Text := FieldByName('ESTRATO').AsString;
                    FrmPrograma.no_registro := FieldByName('NO_ENTRADA').AsInteger;
                    FrmPrograma.oficina := DBoficina.KeyValue;
                    FrmPrograma.opcion_real := 1;
                    FrmPrograma.ShowModal;
                  end
                  else
                  begin
                    TEcuenta.EditMask := '';
                    //TEnombres.Text := FieldByName('NOMBRES').AsString;
                    TEdocumento.SetFocus;
                  end;
               Close;
               end
               else
               begin
                  FrmPrograma.TEnit.Text := TEdocumento.Text;
                  FrmPrograma.opcion_real := 2;
                  FrmPrograma.titular := 1;
                  FrmPrograma.ShowModal;
               end;
             end;
            end;  // fin otras oficinas
          end
        else begin // renovacion
          with DataQuerys.IBdatos do
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('COUNT("fun$afiliacion"."nit_asociado") AS contador');
            SQL.Add('FROM');
            SQL.Add('"fun$afiliacion"');
            SQL.Add('where ("fun$afiliacion"."nit_asociado" = :nit) and');
            SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
            ParamByName('convenio').AsInteger := FrmAfiliacion.DBconvenio.KeyValue;
            ParamByName('nit').AsString := TEdocumento.Text;
            Open;
            if FieldByName('contador').AsInteger = 0 then
            begin
              MessageDlg('        No se Encuentra en el Programa'+#13+FrmAfiliacion.DBconvenio.Text+' Favor Registrarlo.',mtInformation,[mbok],0);
              TEdocumento.Text := '';
              TEdocumento.SetFocus;
              Exit;
            end;
            Close;
          end;
        ///////////////////////////////////////////
          if oficina = 100 then
          begin
            MessageDlg('Debe Selecionar Una Oficina',mtError,[mbok],0);
            DBoficina.SetFocus;
            Exit;
          end;
          if validafecha(TEdocumento.Text) then
          begin
             if MessageDlg('No a Vencido la Vigencia de la Afiliacion'+#13+'              Desea Continuar ?',mtInformation,[mbyes,mbno],0) = mrno then
             begin
                TEdocumento.Text := '';
                TEdocumento.SetFocus;
                Exit;
             end;
          end;
          if oficina = Agencia then
          begin
            with FrmQuerys.IBseleccion do
            begin
              Close;
              verificatransaccion(FrmQuerys.IBseleccion);
              {SQL.Clear;
              SQL.Add(' select * from BUSCA_PERSONA_N1(:NIT)');
              ParamByName('NIT').AsString := TEdocumento.Text;
              Open;}
              SQL.Clear;
              SQL.Add('select * from "gen$persona"');
              SQL.Add('where ID_PERSONA = :ID_PERSONA');
              ParamByName('ID_PERSONA').AsString := TEdocumento.Text;
              Open;
              nombresa := FieldByName('PRIMER_APELLIDO').AsString + ' ' +FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +FieldByName('NOMBRE').AsString;
              id_identificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
              SQL.Clear;
              SQL.Add('SELECT * FROM P_CAP_0008 (:ID_AGENCIA,:ID_TIPO_CAPTACION,:ID_IDENTIFICACION,:ID_PERSONA)');
              ParamByName('ID_AGENCIA').AsInteger := Agencia;
              ParamByName('ID_TIPO_CAPTACION').AsInteger := 2;
              ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
              ParamByName('ID_PERSONA').AsString := TEdocumento.Text;
              Open;
              TEcuenta.EditMask := '!999-999999;1;0';
              TEcuenta.Text := '20' + IntToStr(Agencia) + '-'+ FieldByName('NUMERO_CUENTA').AsString;
              TEnombres.Text := nombresa;
              //
             if verifica_renovacion(TEdocumento.Text,DBconvenio.KeyValue) then //** inicio verificar renovacion de beneficiarios
             begin
               with CDafiliacion do
               begin
                 Append;
                 FieldValues['nit_asociado'] := TEdocumento.Text;
                 FieldValues['nit_beneficiario'] := TEdocumento.Text;
                 FieldValues['id_convenio'] := DBconvenio.KeyValue;
                 FieldValues['fecha'] := fecha_v(TEdocumento.Text,2);
                 FieldValues['id_parentesco'] := 1;
                 FieldValues['id_afiliacion'] := id_afiliacion;
                 FieldValues['es_afiliacion'] := 0;
                 if oficina = Agencia then
                   FieldValues['es_local'] := 1
                 else
                   FieldValues['es_local'] := 0;
                 FieldValues['nombres'] := TEnombres.Text;
                 FieldValues['parentesco'] := 'A. TITULAR';
                 FieldValues['fecha_ven'] := fecha_v(TEdocumento.Text,1);
                 Post;
               end;
               {with CDcarnet do
               begin
                  Append;
                  FieldValues['nit_beneficiario'] := TEdocumento.Text;
                  FieldValues['programa'] := DBconvenio.KeyValue;
                  FieldValues['no_carnet'] := buscar_carnet(TEdocumento.Text,DBconvenio.KeyValue,1);
                  FieldValues['descripcion'] := buscar_carnet(TEdocumento.Text,DBconvenio.KeyValue,2);
                  FieldValues['nombres']  := TEnombres.Text;
                  Post;
               end;}
             end; //**fin verifica renovacion beneficiarios
             with DataQuerys.IBdatos do
             begin
               Close;
               SQL.Clear;
               SQL.Add('SELECT distinct');
               SQL.Add('"fun$beneficiario"."nombres",');
               //*******
               SQL.Add('"fun$beneficiario".NOMBRE1,');
               SQL.Add('"fun$beneficiario".APELLIDO1,');
               SQL.Add('"fun$beneficiario".APELLIDO2,');
               //*******
               SQL.Add('"fun$beneficiario"."fecha_nacimiento",');
               SQL.Add('"fun$beneficiario"."identificacion",');
               SQL.Add('"fun$parentesco"."descripcion",');
               SQL.Add('"fun$afiliacion"."parentesco",');
              // SQL.Add('"fun$afiliacion"."fecha_vencimiento",');
               //SQL.Add('"fun$afiliacion"."fecha",');
               SQL.Add('"fun$afiliacion"."nit_beneficiario"');
               SQL.Add('FROM');
               SQL.Add('"fun$beneficiario"');
               SQL.Add('RIGHT OUTER JOIN "fun$afiliacion" ON ("fun$beneficiario"."identificacion" = "fun$afiliacion"."nit_beneficiario")');
               SQL.Add('INNER JOIN "fun$parentesco" ON ("fun$afiliacion"."parentesco" = "fun$parentesco"."id_parentesco")');
               SQL.Add('WHERE');
               SQL.Add('("fun$afiliacion"."nit_asociado" = :nit_asociado) AND');
               //SQL.Add('("fun$afiliacion"."es_afiliacion" = 1) AND');
               SQL.Add('("fun$afiliacion"."nit_beneficiario" <> :nit_asociado)');
               ParamByName('nit_asociado').AsString := TEdocumento.Text;
               Open;
               while not Eof do
               begin
               if verifica_renovacion(FieldByName('nit_beneficiario').AsString,DBconvenio.KeyValue) then //** inicio verifica
               begin
                 id_afiliacion := id_afiliacion+1;
                 with CDafiliacion do
                 begin
                   Append;
                   FieldValues['nit_asociado'] := TEdocumento.Text;
                   FieldValues['nit_beneficiario'] := DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString;
                   FieldValues['id_convenio'] := DBconvenio.KeyValue;
                   FieldValues['fecha'] := DateToStr(fecha_v(DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString,2));
                   FieldValues['id_parentesco'] := DataQuerys.IBdatos.FieldByName('parentesco').AsInteger;
                   FieldValues['id_afiliacion'] := id_afiliacion;
                   FieldValues['es_afiliacion'] := 0;
                   if oficina = Agencia then
                      FieldValues['es_local'] := 1
                    else
                      FieldValues['es_local'] := 0;
                      FieldValues['nombres'] := DataQuerys.IBdatos.FieldByName('nombres').AsString + ' ' + DataQuerys.IBdatos.FieldByName('NOMBRE1').AsString +
                                                DataQuerys.IBdatos.FieldByName('APELLIDO1').AsString + ' ' + DataQuerys.IBdatos.FieldByName('APELLIDO2').AsString;
                      FieldValues['parentesco'] := DataQuerys.IBdatos.FieldByName('descripcion').AsString;
                      FieldValues['fecha_na'] := DataQuerys.IBdatos.FieldByName('fecha_nacimiento').AsDateTime;
                      FieldValues['Fecha_ven'] := fecha_v(DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString,1);
                   Post;
                   end;
            { with CDcarnet do
             begin
                Append;
                FieldValues['nit_beneficiario'] := DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString;
                FieldValues['programa'] := DBconvenio.KeyValue;
                FieldValues['no_carnet'] := buscar_carnet(DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString,DBconvenio.KeyValue,1);
                FieldValues['descripcion'] := buscar_carnet(DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString,DBconvenio.KeyValue,2);
                FieldValues['nombres']  := DataQuerys.IBdatos.FieldByName('nombres').AsString;
                Post;
             end;}
             end;
                   Next;
                 end;
               Close;
             end;
             control_agrega := True;
             BTagregar.SetFocus;
            end;
          end
          else//////////
          begin
          with DataQuerys.IBdatos do
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('*');
//            SQL.Add('"fun$datos_asociado"."numero_cuenta"');
            SQL.Add('FROM');
            SQL.Add('"fun$beneficiario"');
            SQL.Add('INNER JOIN "fun$datos_asociado" ON ("fun$beneficiario"."identificacion" = "fun$datos_asociado"."nit_asociado")');
            SQL.Add('WHERE');
            SQL.Add('("fun$datos_asociado"."nit_asociado" = :nit_asociado)');
            ParamByName('nit_asociado').AsString := TEdocumento.Text;
            Open;
            TEnombres.Text := FieldByName('nombres').AsString + ' ' + FieldByName('NOMBRE1').AsString + ' ' + FieldByName('APELLIDO1').AsString + ' ' + FieldByName('APELLIDO2').AsString;
            TEcuenta.Text := FieldByName('numero_cuenta').AsString;
            Close;
          end;
            with DataQuerys.IBdatos do
            begin
              Close;
              SQL.Clear;
              SQL.Add('SELECT distinct');
              SQL.Add('"fun$beneficiario"."nombres", "fun$beneficiario"."NOMBRE1", "fun$beneficiario"."APELLIDO1", "fun$beneficiario"."APELLIDO2",');
              SQL.Add('"fun$beneficiario"."identificacion",');
              SQL.Add('"fun$beneficiario"."fecha_nacimiento",');
              SQL.Add('"fun$parentesco"."descripcion",');
              SQL.Add('"fun$afiliacion"."parentesco"');
              SQL.Add('FROM');
              SQL.Add('"fun$beneficiario"');
              SQL.Add('RIGHT OUTER JOIN "fun$afiliacion" ON ("fun$beneficiario"."identificacion" = "fun$afiliacion"."nit_beneficiario")');
              SQL.Add('INNER JOIN "fun$parentesco" ON ("fun$afiliacion"."parentesco" = "fun$parentesco"."id_parentesco")');
              SQL.Add('WHERE');
              SQL.Add('("fun$afiliacion"."nit_asociado" = :nit)');
              SQL.Add('order by "fun$afiliacion"."parentesco"');
              //SQL.Add('and )
              ParamByName('nit').AsString := TEdocumento.Text;
              Open;
              while not Eof do
              begin
              if verifica_renovacion(FieldByName('identificacion').AsString,DBconvenio.KeyValue) then
              begin
                 id_afiliacion := id_afiliacion + 1;
                 with CDafiliacion do
                 begin
                   Append;
                   FieldValues['nit_asociado'] := TEdocumento.Text;
                   FieldValues['nit_beneficiario'] := DataQuerys.IBdatos.FieldByName('identificacion').AsString;
                   FieldValues['id_convenio'] := DBconvenio.KeyValue;
                   FieldValues['fecha'] := DTfecha.Date;
                   FieldValues['id_parentesco'] := DataQuerys.IBdatos.FieldByName('parentesco').AsString;
                   FieldValues['id_afiliacion'] := id_afiliacion;
                   FieldValues['es_afiliacion'] := 0;
                   if oficina = Agencia then
                      FieldValues['es_local'] := 1
                    else
                      FieldValues['es_local'] := 0;
                      FieldValues['nombres'] := DataQuerys.IBdatos.FieldByName('nombres').AsString + ' ' + DataQuerys.IBdatos.FieldByName('NOMBRE1').AsString + ' ' + DataQuerys.IBdatos.FieldByName('APELLIDO1').AsString + ' ' +DataQuerys.IBdatos.FieldByName('APELLIDO2').AsString;
                      FieldValues['parentesco'] := DataQuerys.IBdatos.FieldByName('descripcion').AsString;
                      FieldValues['fecha_na'] := DataQuerys.IBdatos.FieldByName('fecha_nacimiento').AsDateTime;
                   Post;
                   end;
             {with CDcarnet do
             begin
                Append;
                FieldValues['nit_beneficiario'] := DataQuerys.IBdatos.FieldByName('identificacion').AsString;
                FieldValues['programa'] := DBconvenio.KeyValue;
                FieldValues['no_carnet'] := buscar_carnet(DataQuerys.IBdatos.FieldByName('identificacion').AsString,DBconvenio.KeyValue,1);
                FieldValues['descripcion'] := buscar_carnet(DataQuerys.IBdatos.FieldByName('identificacion').AsString,DBconvenio.KeyValue,2);
                FieldValues['nombres']  := DataQuerys.IBdatos.FieldByName('nombres').AsString;
                Post;
             end; }
             end;
                   Next;
                 end;
               Close;
             end;
           control_agrega := True;
           BTagregar.SetFocus;
          end;/////////
        end;

        end;
end;

procedure TFrmAfiliacion.DBoficinaExit(Sender: TObject);
begin
        try
           oficina := DBoficina.KeyValue;
        except
        on e: Exception do
           DBoficina.SetFocus;
        end;
end;

procedure TFrmAfiliacion.DBconvenioExit(Sender: TObject);
begin
        try
        verifica_asociado := True;
        IBplan.Close;
        FrmPrograma.codigo_convenio := DBconvenio.KeyValue;
        FrmPrograma.convenio := DBconvenio.Text;
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select count(*) as contador from "fun$planes"');
          SQL.Add('where "fun$planes"."id_convenio" = :convenio');
          ParamByName('convenio').AsInteger := DBconvenio.KeyValue;
          Open;
          if FieldByName('contador').AsInteger >= 1 then
          begin
            ibplan.Close;
            IBplan.ParamByName('convenio').AsInteger := DBconvenio.KeyValue;
            IBplan.Open;
            DBplan.KeyValue := IBplan.FieldByName('id_plan').AsInteger;
            IBplan.Last;
            TEvalor.Enabled := True;
          end;
          Close;
        end;
        except
        on e: Exception do
        begin
          MessageDlg('Debe Seleccionar un Convenio',mtInformation,[mbok],0);
          DBconvenio.SetFocus;
        end;
        end;
end;

procedure TFrmAfiliacion.limpiar;
begin
        IBplan.Close;
        TEdocumento.Text := '';
        TEnombres.Text := '';
        TEcuenta.Text := '';
        TEvalor.Enabled := False;
        CDafiliacion.CancelUpdates;
        TEcuenta.EditMask := '';
        DBconvenio.SetFocus;
end;

procedure TFrmAfiliacion.BTcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmAfiliacion.BTcancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmAfiliacion.BTagregarClick(Sender: TObject);
begin

        if control_agrega  then
        begin
          FrmPrograma.opcion_salida := 1;
          FrmPrograma.DBparentesco.KeyValue := 20;
          FrmPrograma.opcion_real := 3;
          FrmPrograma.titular := 0;
          FrmPrograma.DTfecha.Left := 215;
          FrmPrograma.Fecha.Left := 82;
          FrmPrograma.Cuenta.Visible := False;
          FrmPrograma.TEcuenta.Visible := False;
          FrmPrograma.Show;
        end;
end;

procedure TFrmAfiliacion.BTeliminarClick(Sender: TObject);
begin
        try
          CDafiliacion.Delete;
        except
        on E: Exception do
        MessageDlg('No Existen Campos Para Eliminar',mtWarning,[mbok],0);
        end;
end;

procedure TFrmAfiliacion.BTverificarClick(Sender: TObject);
var     edad :Variant;
begin
         if CDafiliacionid_parentesco.Value <> 1 then
         begin
           if  int(CDafiliacionfecha_na.Value) < 10
           then
           begin
              MessageDlg('Favor Actualice los Datos, Falta la Fecha de Nacimiento',mtInformation,[mbok],0);
              Exit;
           end;
           try
             edad := int((int(Date) - int(CDafiliacionfecha_na.Value))/365.25);
             if parametro(CDafiliacionid_parentesco.Value,DBconvenio.KeyValue,edad,'a',DataQuerys.IBdatos) = False then begin
                MessageDlg('El Beneficiario no Concuerda con los parametros del Convenio',mtInformation,[mbok],0);
                DBGrid1.SetFocus;
             end
             else
                MessageDlg('Los Datos se Encuentran Actualizados',mtInformation,[mbok],0);
            except
            on E: Exception do
            begin
               MessageDlg('Favor Actualice los Datos, Falta la Fecha de Nacimiento',mtInformation,[mbok],0);
               DTfecha.SetFocus;
               Exit;
             end;
             end;
         end
         else
         MessageDlg('Los Datos se Encuentran Actualizados',mtInformation,[mbok],0);
end;

procedure TFrmAfiliacion.DBGrid1DblClick(Sender: TObject);
begin
        if (CDafiliacionnit_beneficiario.Text <> TEdocumento.Text) or (DBoficina.KeyValue <> 1) then
        begin
        if es_afiliacion = False then
        begin
             with DataQuerys.IBdatos do
             begin
               Close;
               SQL.Clear;
               SQL.Add('select * FROM BUSCA_BENE(:NIT)');
               ParamByName('NIT').AsString := CDafiliacionnit_beneficiario.Text;
               Open;
                    FrmPrograma.TEnombres.Text := FieldByName('NOMBRES').AsString;
                    //****
                    FrmPrograma.nombre1.Text := FieldByName('NOMBRE1').AsString;
                    FrmPrograma.apellido1.Text := FieldByName('APELLIDO1').AsString;
                    FrmPrograma.apellido2.Text := FieldByName('APELLIDO2').AsString;
                    FrmPrograma.EdMail.Text := FieldByName('MAIL').AsString;
                    //***

                    FrmPrograma.TEnit.Text :=  CDafiliacionnit_beneficiario.Text;
                    FrmPrograma.TElugar.Text := FieldByName('LUGAR_ID').AsString;
                    FrmPrograma.TEBarrio.Text := FieldByName('BARRIO').AsString;
                    FrmPrograma.TEdireccion.Text := FieldByName('DIRECCION').AsString;
                    FrmPrograma.TECiudad.Text := FieldByName('MUNICIPIO').AsString;
                    FrmPrograma.TEtelefono.Text := FieldByName('TELEFONO').AsString;
                    FrmPrograma.DTfecha.Text := FieldByName('FECHA_NACIMIENTO').AsString;
                    if FieldByName('SEXO').AsString = 'M' then
                       FrmPrograma.Csexo.ItemIndex := 0
                    else
                       FrmPrograma.Csexo.ItemIndex := 1;
                    FrmPrograma.DBtiponit.KeyValue := FieldByName('TIPO_ID').AsInteger;
                    FrmPrograma.TEestrato.Text := FieldByName('ESTRATO').AsString;
                    FrmPrograma.no_registro := FieldByName('NO_ENTRADA').AsInteger;
                    FrmPrograma.DBparentesco.KeyValue := CDafiliacion.FieldValues['id_parentesco'];
                    FrmPrograma.oficina := DBoficina.KeyValue;
                    if CDafiliacionnombres.Text <> '' then
                       FrmPrograma.opcion_real := 5
                    else
                    begin
                       CDafiliacion.Delete;
                       FrmPrograma.opcion_real := 8;
                    end;
                    FrmPrograma.ShowModal;
             end;
        end;
        end;
end;

procedure TFrmAfiliacion.registrar;
var     fecha_v :Integer;
begin
        fecha_v := busca_fecha(DBconvenio.KeyValue);
        with CDafiliacion do
        begin
           First;
           while not Eof do
           begin
             with DataQuerys.IBdatos do
             begin
               Close;
               verificatransaccion(DataQuerys.IBdatos);
               SQL.Clear;
               SQL.Add('insert into "fun$afiliacion"');
               SQL.Add('Values (');
               SQL.Add(':nit_asociado,:nit_beneficiario,');
               SQL.Add(':id_convenio,:fecha,');
               SQL.Add(':parentesco,:id_afiliacion,');
               SQL.Add(':es_afiliacion,:es_local,');
               SQL.Add(':cod_oficina,');
               SQL.Add(':fecha_vencimiento,');
               SQL.Add(':es_fechaparcial,:id_empleado,:ZONA )');
               ParamByName('nit_asociado').AsString := CDafiliacion.FieldValues['nit_asociado'];
               ParamByName('nit_beneficiario').AsString := CDafiliacion.FieldValues['nit_beneficiario'];
               ParamByName('id_convenio').AsInteger := CDafiliacion.FieldValues['id_convenio'];
               try
               ParamByName('fecha').AsDate := DTfecha.Date;
               except
               begin
                 messagedlg('error en fecha de afiliacioon',mtinformation,[mbok],0);
               end;
               end;
               ParamByName('parentesco').AsInteger := CDafiliacion.FieldValues['id_parentesco'];
               ParamByName('id_afiliacion').AsInteger := id_registra;//CDafiliacion.FieldValues['id_afiliacion'];
               ParamByName('es_afiliacion').AsInteger := CDafiliacion.FieldValues['es_afiliacion'];
               ParamByName('es_local').AsInteger := CDafiliacion.FieldValues['es_local'];
               ParamByName('cod_oficina').AsInteger := DBoficina.KeyValue;
               try
               ParamByName('fecha_vencimiento').AsDate := actualiza_fecha(DTfecha.Date);
               except
               begin
                 messagedlg('error en fecha de vencimiento',mtinformation,[mbok],0);
               end;
               end;
               ParamByName('es_fechaparcial').AsInteger := fecha_v;//busca_fecha(DBconvenio.KeyValue);
               ParamByName('id_empleado').AsString := UpperCase(FrMain.Dbalias);
               ParamByName('ZONA').AsString := cbZona.Text;
               Open;
               Close;
               Transaction.Commit;
             end;
             Next;
           end;
        end;
end;

procedure TFrmAfiliacion.BTaceptarClick(Sender: TObject);
begin
        if MessageDlg('Esta Seguro de Registrar la Transaccion',mtInformation,[mbyes,mbno],0) = mryes then
        begin
           registrar;
           if TEvalor.Enabled then
              plan;
           limpiar;
        end
        else
        DBconvenio.SetFocus;
end;

function TFrmAfiliacion.busca_fecha(id_convenio: integer): integer;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$convenios"."tipo_fecha"');
          SQL.Add('FROM');
          SQL.Add('"fun$convenios"');
          SQL.Add('WHERE');
          SQL.Add('("fun$convenios"."id_convenio" = :id_convenio)');
          ParamByName('id_convenio').AsInteger := id_convenio;
          Open;
          Result := FieldByName('tipo_fecha').AsInteger;
          Close;
        end;
end;

procedure TFrmAfiliacion.asociado;
begin
        if verifica_asociado then
        begin
        verifica_asociado := False;
        if TEnombres.Text <> '' then
        begin
           if es_afiliacion then
           begin
             with DataQuerys.IBdatos do
             begin
               Close;
               verificatransaccion(DataQuerys.IBdatos);
               SQL.Clear;
               SQL.Add('SELECT');
               SQL.Add('MAX("fun$afiliacion"."id_afiliacion") AS "maxid"');
               SQL.Add('FROM');
               SQL.Add('"fun$afiliacion"');
               Open;
               id_afiliacion := FieldByName('maxid').AsInteger + 1;
               Close;
             end;
               id_afiliacion_plan := id_afiliacion;
             with CDafiliacion do
             begin
               Append;
               FieldValues['nit_asociado'] := TEdocumento.Text;
               FieldValues['nit_beneficiario'] := TEdocumento.Text;
               FieldValues['id_convenio'] := DBconvenio.KeyValue;
               FieldValues['fecha'] := DTfecha.Date;
               FieldValues['id_parentesco'] := 1;
               FieldValues['id_afiliacion'] := id_afiliacion;
               FieldValues['es_afiliacion'] := 1;
               if oficina = Agencia then
                 FieldValues['es_local'] := 1
               else
                 FieldValues['es_local'] := 0;
                 FieldValues['nombres'] := TEnombres.Text;
                 FieldValues['parentesco'] := 'A. TITULAR';
                 Post;
               end;
               control_agrega := True;
               BTagregar.SetFocus;
            end;
        end;
        end;
end;

procedure TFrmAfiliacion.DTfechaExit(Sender: TObject);
begin
        asociado;
end;

procedure TFrmAfiliacion.DBGrid1Enter(Sender: TObject);
begin
        asociado;
end;

function TFrmAfiliacion.fecha_v(nit: string;opcion:integer): tdate;
begin
        with DataQuerys.IBFundacion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBFundacion);
          SQL.Clear;
          if opcion = 1 then
          SQL.Add('select max("fun$afiliacion"."fecha_vencimiento") as fecha from "fun$afiliacion"')
          else
          SQL.Add('select max("fun$afiliacion"."fecha") as fecha from "fun$afiliacion"');
          SQL.Add('where "fun$afiliacion"."nit_beneficiario" = :nit');
          ParamByName('nit').AsString := nit;
          Open;
          Result := FieldByName('fecha').AsDateTime;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmAfiliacion.VerFechasdeVencimiento1Click(Sender: TObject);
begin
        FrmFechaven := TFrmFechaven.Create(self);
        FrmFechaven.ShowModal;
end;

procedure TFrmAfiliacion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        CDafiliacion.CancelUpdates;

end;

procedure TFrmAfiliacion.plan;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('insert into "fun$planbeneficiario" values(');
          SQL.Add(':id_plan,:valor,:id_afiliacion)');
          ParamByName('id_plan').AsInteger := DBplan.KeyValue;
          ParamByName('valor').AsCurrency := TEvalor.Value;
          ParamByName('id_afiliacion').AsInteger := id_afiliacion_plan;
          Open;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmAfiliacion.BTcarneClick(Sender: TObject);
begin
        FrmReEps := TFrmReEps.Create(self);
        if es_afiliacion then
        begin
          FrmReEps.CDeps.Append;
          FrmReEps.CDeps.FieldValues['nombres'] := TEnombres.Text;
          FrmReEps.CDeps.FieldValues['nit_beneficiario'] := TEdocumento.Text;
          FrmReEps.CDeps.FieldValues['id_eps'] := 0;
          FrmReEps.CDeps.Post;
          FrmReEps.ShowModal;
        end
        else
        begin
        CDcarnet.CancelUpdates;
       FrmActCarne := TFrmActCarne.Create(self);
       with CDafiliacion do
       begin
         First;
         while not Eof do
         begin
         CDcarnet.Append;
         CDcarnet.FieldValues['nit_beneficiario'] := FieldValues['nit_beneficiario'];
         CDcarnet.FieldValues['programa'] := DBconvenio.KeyValue;
         CDcarnet.FieldValues['no_carnet'] := buscar_carnet(FieldValues['nit_beneficiario'],DBconvenio.KeyValue,1);
         CDcarnet.FieldValues['descripcion'] := buscar_carnet(FieldValues['nit_beneficiario'],DBconvenio.KeyValue,2);
         CDcarnet.FieldValues['nombres']  := FieldValues['nombres'];
         CDcarnet.Post;
         Next;
         end;
      end;
          FrmActCarne.ShowModal;
        end;
end;

function TFrmAfiliacion.verifica_renovacion(nit,convenio: string): boolean;
var     fecha :TDate;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('MAX("fun$afiliacion"."fecha") AS "fecha"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."id_convenio" = :id) AND');
          SQL.Add('("fun$afiliacion"."nit_beneficiario" = :nit)');
          ParamByName('id').AsInteger := StrToInt(convenio);
          ParamByName('nit').AsString := nit;
          Open;
          fecha := FieldByName('fecha').AsDateTime;
          //ShowMessage(datetostr(fecha));
          Close;
          fecha := fecha + 183;
          Transaction.Commit;
          if Int(DTfecha.Date) >= fecha then
            Result := true
          else
            Result := False;
        end;
end;
function TFrmAfiliacion.id_registra: integer;
begin
              DataQuerys := TDataQuerys.Create(self);
              with DataQuerys.IBdatos do
              begin
               Close;
               verificatransaccion(DataQuerys.IBdatos);
               SQL.Clear;
               SQL.Add('SELECT');
               SQL.Add('MAX("fun$afiliacion"."id_afiliacion") AS "maxid"');
               SQL.Add('FROM');
               SQL.Add('"fun$afiliacion"');
               Open;
               Result := FieldByName('maxid').AsInteger + 1;
               Close;
             end;

end;


end.
