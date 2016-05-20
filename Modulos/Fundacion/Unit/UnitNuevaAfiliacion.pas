unit UnitNuevaAfiliacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, IBDatabase, IBCustomDataSet, IBQuery, Buttons,
  JvTypedEdit, StdCtrls, Grids, DBGrids, JvPanel, Mask, ComCtrls, JvEdit,
  DBCtrls, JvLabel, ExtCtrls,JclDateTime;

type
  TFrmNuevaAfiliacion = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    DBoficina: TDBLookupComboBox;
    DBconvenio: TDBLookupComboBox;
    TEdocumento: TJvEdit;
    TEnombres: TJvEdit;
    DTfecha: TDateTimePicker;
    TEcuenta: TMaskEdit;
    JvPanel1: TJvPanel;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    BTagregar: TBitBtn;
    BTeliminar: TBitBtn;
    BTverificar: TBitBtn;
    Panel2: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBplan: TDBLookupComboBox;
    TEvalor: TJvCurrencyEdit;
    JvPanel2: TJvPanel;
    BTcerrar: TSpeedButton;
    BTaceptar: TBitBtn;
    BTcancelar: TBitBtn;
    DSoficina: TDataSource;
    IBoficina: TIBQuery;
    IBToficina: TIBTransaction;
    IBconvenio: TIBQuery;
    DSconvenio: TDataSource;
    IBplan: TIBQuery;
    DSplan: TDataSource;
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
    CDafiliacionfecha_na: TDateField;
    DSdatos: TDataSource;
    ClientDataSet1: TClientDataSet;
    Label9: TLabel;
    cbZona: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure TEdocumentoExit(Sender: TObject);
    procedure DBoficinaExit(Sender: TObject);
    procedure BTcerrarClick(Sender: TObject);
    procedure BTagregarClick(Sender: TObject);
    procedure BTaceptarClick(Sender: TObject);
    procedure DBconvenioExit(Sender: TObject);
    procedure BTeliminarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BTverificarClick(Sender: TObject);
    procedure BTcancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
  id_afiliacion: Integer;
    oficina: smallint;
    verifica_asociado: boolean;
    procedure registrar;
    function busca_fecha(id_convenio: integer): Integer;
    procedure limpiar;
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmNuevaAfiliacion: TFrmNuevaAfiliacion;

implementation

uses UnitQuerys, UnitdataQuerys, UnitPrograma,UnitGlobal,
  UnitPantallaProgreso, UnitPrincipal, UnitReEps, UnitGlobales;

{$R *.dfm}

procedure TFrmNuevaAfiliacion.cmChildKey(var msg: TWMKEY);
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

procedure TFrmNuevaAfiliacion.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        //FrmPrograma := TFrmPrograma.Create(self);
        DTfecha.Date := Date;
        IBoficina.Open;
        IBoficina.Last;
        IBconvenio.Open;
        IBconvenio.Last;
        DBconvenio.KeyValue := 1;
        oficina := 100;
end;

procedure TFrmNuevaAfiliacion.TEdocumentoExit(Sender: TObject);
var   nombresa :string;
        id_identificacion :Integer;
begin
        CDafiliacion.CancelUpdates;
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
               Close;
             end;
           if oficina = 100 then
          begin
            MessageDlg('Debe Selecionar Una Oficina',mtError,[mbok],0);
            DBoficina.SetFocus;
            Exit;
          end;
          if oficina = Agencia then
          begin
            {with FrmQuerys.IBseleccion do
            begin
              Close;
              verificatransaccion(FrmQuerys.IBseleccion);
              SQL.Clear;
              SQL.Add(' select * from BUSCA_PERSONA_N1(:NIT)');
              ParamByName('NIT').AsString := TEdocumento.Text;
              Open;
              if RecordCount = 0 then
              begin
                 MessageDlg('Verifique la Informacion el No de Identificacion'+#13+'no se Encuentra Registrado el la Base de Datos.',mtInformation,[mbok],0);
                 TEdocumento.SetFocus;
                 Exit;
              end
              else
              begin }
              //
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
              ParamByName('ID_AGENCIA').AsInteger := 1;
              ParamByName('ID_TIPO_CAPTACION').AsInteger := 2;
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

              //
              {TEcuenta.EditMask := '!999-999999;1;0';
              TEcuenta.Text := '201-'+ FieldByName('NUMERO_CUENTA').AsString;
              TEnombres.Text := FieldByName('APELLIDO1').AsString + ' ' +FieldByName('APELLIDO2').AsString + ' ' +FieldByName('NOMBRES').AsString;
              BTagregar.SetFocus;
              end;
              Close;
            end; }
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
               if RecordCount = 0 then
               begin
               MessageDlg('Verifique la Informacion no se se Encuentra en la Base de Datos',mtInformation,[mbok],0);
               TEdocumento.Text := '';
               TEnombres.Text := '';
               TEdocumento.SetFocus;
               Exit;
               end
                  else
                  begin
                    TEcuenta.EditMask := '';
                    TEnombres.Text := FieldByName('NOMBRES').AsString;
                    BTagregar.SetFocus;
                  end;
               Close;
               end;
             end;
          end;// primer if
          with DataQuerys.IBdatos do
          begin
             Close;
             verificatransaccion(DataQuerys.IBdatos);
             SQL.Clear;
             SQL.Add('select "fun$afiliacion"."nit_asociado" from "fun$afiliacion"');
             SQL.Add('where "fun$afiliacion"."nit_asociado" = :nit');
             SQL.Add('and "fun$afiliacion"."id_convenio" = :convenio');
             ParamByName('nit').AsString := TEdocumento.Text;
             ParamByName('convenio').AsInteger := DBconvenio.KeyValue;
             Open;
             if RecordCount = 0 then
             begin
               MessageDlg('No se Encuentra Afiliado al Programa',mtinformation,[mbok],0);
               limpiar;
               Exit;
             end;
             Close;
          end;
end;

procedure TFrmNuevaAfiliacion.DBoficinaExit(Sender: TObject);
begin
        try
        oficina := DBoficina.KeyValue;
        FrmPrograma.codigo_oficina := oficina;
        except
        on E: Exception do
        DBoficina.SetFocus;
        end;
end;

procedure TFrmNuevaAfiliacion.BTcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmNuevaAfiliacion.BTagregarClick(Sender: TObject);
begin
//        FrmPrograma := TFrmPrograma.Create(self);
        FrmPrograma.afiliacion := 1;
        FrmPrograma.opcion_salida := 1;
        FrmPrograma.opcion_real := 3;
        FrmPrograma.DBparentesco.KeyValue := 20;
        FrmPrograma.ShowModal;
end;

procedure TFrmNuevaAfiliacion.BTaceptarClick(Sender: TObject);
begin
        if MessageDlg('Esta Seguro de Registrar la Transaccion',mtInformation,[mbyes,mbno],0) = mryes then
        begin
           registrar;
           limpiar;
        end
        else
        DBconvenio.SetFocus;
end;

procedure TFrmNuevaAfiliacion.DBconvenioExit(Sender: TObject);
begin
        try
        verifica_asociado := True;
        FrmPrograma := TFrmPrograma.Create(self);
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
            IBplan.ParamByName('convenio').AsInteger := DBconvenio.KeyValue;
            IBplan.Open;
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

procedure TFrmNuevaAfiliacion.registrar;
var      fecha_v :Integer;
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
               ParamByName('fecha').AsDate := DTfecha.Date;
               ParamByName('parentesco').AsInteger := CDafiliacion.FieldValues['id_parentesco'];
               ParamByName('id_afiliacion').AsInteger := CDafiliacion.FieldValues['id_afiliacion'];
               ParamByName('es_afiliacion').AsInteger := CDafiliacion.FieldValues['es_afiliacion'];
               ParamByName('es_local').AsInteger := CDafiliacion.FieldValues['es_local'];
               ParamByName('cod_oficina').AsInteger := DBoficina.KeyValue;
               ParamByName('fecha_vencimiento').AsDate := actualiza_fecha(DTfecha.Date);
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

function TFrmNuevaAfiliacion.busca_fecha(id_convenio: integer): integer;
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

procedure TFrmNuevaAfiliacion.limpiar;
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

procedure TFrmNuevaAfiliacion.BTeliminarClick(Sender: TObject);
begin
        try
          CDafiliacion.Delete;
        except
        on E: Exception do
        MessageDlg('No Existen Campos Para Eliminar',mtWarning,[mbok],0);
        end;
end;

procedure TFrmNuevaAfiliacion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        CDafiliacion.CancelUpdates;
end;

procedure TFrmNuevaAfiliacion.BTverificarClick(Sender: TObject);
begin
          FrmReEps := TFrmReEps.Create(self);
          with CDafiliacion do
          begin
            First;
            while not Eof do
            begin
              FrmReEps.CDeps.Append;
              FrmReEps.CDeps.FieldValues['nombres'] := FieldValues['nombres'];
              FrmReEps.CDeps.FieldValues['nit_beneficiario'] := FieldValues['nit_beneficiario'];
              FrmReEps.CDeps.FieldValues['id_eps'] := 0;
              FrmReEps.CDeps.Post;
              Next;
            end;
          end;
          FrmReEps.ShowModal;

end;

procedure TFrmNuevaAfiliacion.BTcancelarClick(Sender: TObject);
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

end.
