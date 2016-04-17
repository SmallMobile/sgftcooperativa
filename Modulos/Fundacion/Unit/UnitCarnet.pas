unit UnitCarnet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, ComCtrls, StdCtrls, JvEdit, DBCtrls, JvLabel, ExtCtrls,
  DB, IBDatabase, IBCustomDataSet, IBQuery, Grids, DBGrids, DBClient,
  Buttons, pr_Common, pr_TxClasses,JclDateTime, JvStaticText;

type
  TFrmCarnet = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    JvLabel1: TJvLabel;
    DBoficina: TDBLookupComboBox;
    DBconvenio: TDBLookupComboBox;
    TEdocumento: TJvEdit;
    TEnombres: TJvEdit;
    IBconvenio: TIBQuery;
    IBoficina: TIBQuery;
    IBToficina: TIBTransaction;
    DSconvenio: TDataSource;
    DSoficina: TDataSource;
    Panel2: TPanel;
    Label5: TLabel;
    DBCarnet: TDBGrid;
    CDcarnet: TClientDataSet;
    CDcarnetnit_beneficiario: TStringField;
    CDcarnetprograma: TIntegerField;
    CDcarnetno_carnet: TStringField;
    CDcarnetdescripcion: TStringField;
    CDcarnetnombres: TStringField;
    DScarnet: TDataSource;
    Panel4: TPanel;
    BtActualizar: TSpeedButton;
    BTcancelar: TSpeedButton;
    BTsalir: TSpeedButton;
    SpeedButton1: TSpeedButton;
    PrCarnet: TprTxReport;
    Panel3: TPanel;
    Label6: TLabel;
    Documento: TJvEdit;
    JvLabel2: TJvLabel;
    nombres: TJvStaticText;
    JvLabel3: TJvLabel;
    procedure FormCreate(Sender: TObject);
    procedure TEdocumentoExit(Sender: TObject);
    procedure DBoficinaExit(Sender: TObject);
    procedure BTsalirClick(Sender: TObject);
    procedure BTcancelarClick(Sender: TObject);
    procedure BtActualizarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DocumentoExit(Sender: TObject);
  private
  oficina :Smallint;
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmCarnet: TFrmCarnet;

implementation
uses unitdatamodulo, UnitQuerys,UnitdataQuerys,UnitGlobal,UnitVistapreliminar,
  UnitPrincipal;

{$R *.dfm}

procedure TFrmCarnet.cmChildKey(var msg: TWMKEY);
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

procedure TFrmCarnet.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        IBconvenio.Open;
        IBoficina.Open;
        IBconvenio.Last;
        IBoficina.Last;
        oficina := 100;
end;

procedure TFrmCarnet.TEdocumentoExit(Sender: TObject);
var     nombres :string;
begin
        CDcarnet.CancelUpdates;
        if TEdocumento.Text <> '' then
        begin
            with DataQuerys.IBdatos do
            begin
               Close;
               SQL.Clear;
               SQL.Add('select count(*) as i from "fun$afiliacion" where ');
               SQL.Add('"fun$afiliacion"."nit_asociado" = :nit and');
               SQL.Add('"fun$afiliacion"."id_convenio" = :convenio');
               ParamByName('convenio').AsSmallInt := DBconvenio.KeyValue;
               ParamByName('nit').AsString := TEdocumento.Text;
               Open;
               if FieldByName('i').AsInteger = 0 then
               begin
                 MessageDlg('No se Encuentra Afiliado al Programa',mtInformation,[mbok],0);
                 DBconvenio.SetFocus;
                 Exit;
               end;
               Close;
             end;
           if oficina = 100 then
           begin
              MessageDlg('Debe Selecionar Una Oficina',mtInformation,[mbok],0);
              DBoficina.SetFocus;
              Exit;
           end;
           if oficina <> 1 then
           begin
              with DataQuerys.IBdatos do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('SELECT');
                 SQL.Add('"fun$beneficiario"."nombres",');
                 SQL.Add('"fun$beneficiario"."identificacion"');
                 SQL.Add('FROM');
                 SQL.Add('"fun$afiliacion"');
                 SQL.Add('INNER JOIN "fun$beneficiario" ON ("fun$afiliacion"."nit_beneficiario" = "fun$beneficiario"."identificacion")');
                 SQL.Add('WHERE');
                 SQL.Add('("fun$afiliacion"."nit_asociado" = :nit_asociado) AND');
                 //SQL.Add('("fun$afiliacion"."es_afiliacion" = 1 )and');
                 SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
                 ParamByName('convenio').AsSmallInt := DBconvenio.KeyValue;
                 ParamByName('nit_asociado').AsString := TEdocumento.Text;
                 Open;
                 if RecordCount = 0 then
                 begin
                    MessageDlg('No Existe en la Tabla Afiliacion, Favor Verificar Datos',mtInformation,[mbok],0);
                    DBoficina.SetFocus;
                    Exit;
                 end;
                 while not Eof do
                 begin
                    if FieldByName('identificacion').AsString = TEdocumento.Text then
                       TEnombres.Text := FieldByName('nombres').AsString;
                    with CDcarnet do
                    begin
                       Append;
                       FieldValues['nit_beneficiario'] := DataQuerys.IBdatos.FieldByName('identificacion').AsString;
                       FieldValues['programa'] := DBconvenio.KeyValue;
                       FieldValues['no_carnet'] := buscar_carnet(DataQuerys.IBdatos.FieldByName('identificacion').AsString,DBconvenio.KeyValue,1);
                       FieldValues['nombres'] := DataQuerys.IBdatos.FieldByName('nombres').AsString;
                       Post;
                    end;
                    Next;
                 end;
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
              SQL.Add('select * from BUSCA_PERSONA_N1(:NIT)');
              ParamByName('NIT').AsString := TEdocumento.Text;
              Open;
              if RecordCount = 0 then
              begin
                 MessageDlg('Verifique la Informacion el No de Identificacion'+#13+'no se Encuentra Registrado el la Base de Datos.',mtInformation,[mbok],0);
                 TEdocumento.SetFocus;
              end
              else
              begin
                TEnombres.Text := FieldByName('APELLIDO1').AsString + ' ' +FieldByName('APELLIDO2').AsString + ' ' +FieldByName('NOMBRES').AsString;
              end;
              Close;
            end;
              with DataQuerys.IBdatos do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('SELECT');
                 SQL.Add('"fun$afiliacion"."nit_beneficiario"');
                 SQL.Add('FROM');
                 SQL.Add('"fun$afiliacion"');
                 SQL.Add('WHERE');
                 SQL.Add('("fun$afiliacion"."nit_asociado" = :nit_asociado) AND');
                 //SQL.Add('("fun$afiliacion"."es_afiliacion" = 1 )and');
                 SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
                 //SQL.Add(' and("fun$afiliacion"."parentesco" <> 1 )');
                 ParamByName('convenio').AsSmallInt := DBconvenio.KeyValue;
                 ParamByName('nit_asociado').AsString := TEdocumento.Text;
                 Open;
                 while not Eof do
                 begin
                    if FieldByName('nit_beneficiario').AsString = TEdocumento.Text  then
                    begin
                      with CDcarnet do
                      begin
                        Append;
                        FieldValues['nit_beneficiario'] := TEdocumento.Text;
                        FieldValues['programa'] := DBconvenio.KeyValue;
                        FieldValues['no_carnet'] := buscar_carnet(TEdocumento.Text,DBconvenio.KeyValue,1);
                        FieldValues['nombres'] := TEnombres.Text;
                        Post;
                       end;
                    end
                    else
                    begin
                    with DataQuerys.IBFundacion do
                    begin
                      Close;
                      verificatransaccion(DataQuerys.IBFundacion);
                      SQL.Clear;
                      SQL.Add('SELECT');
                      SQL.Add('"fun$beneficiario"."nombres"');
                      SQL.Add('FROM');
                      SQL.Add('"fun$beneficiario"');
                      SQL.Add('WHERE');
                      SQL.Add('("fun$beneficiario"."identificacion" = :nit)');
                      ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString;
                      Open;
                      nombres := FieldByName('nombres').AsString;
                    with CDcarnet do
                    begin
                       Append;
                       FieldValues['nit_beneficiario'] := DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString;
                       FieldValues['programa'] := DBconvenio.KeyValue;
                       FieldValues['no_carnet'] := buscar_carnet(DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString,DBconvenio.KeyValue,1);
                       FieldValues['nombres'] := nombres;
                       Post;
                    end;
                    end;
                    end;
                    Next;
                 end;
                 Close;
              end;
           end;
        end;
end;

procedure TFrmCarnet.DBoficinaExit(Sender: TObject);
begin
        try
           oficina := DBoficina.KeyValue;
        except
        on e: Exception do
           DBoficina.SetFocus;
        end;
end;

procedure TFrmCarnet.BTsalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmCarnet.BTcancelarClick(Sender: TObject);
begin
        CDcarnet.CancelUpdates;
        TEdocumento.Text := '';
        TEnombres.Text := '';
        DBoficina.SetFocus;
end;

procedure TFrmCarnet.BtActualizarClick(Sender: TObject);
begin
        if MessageDlg('Seguro de Realizar la Transaccion',mtInformation,[mbyes,mbno],0) = mryes then
        begin
        with CDcarnet do
        begin
          First;
          while not Eof do
          begin
            with DataQuerys.IBdatos do
            begin
              verificatransaccion(DataQuerys.IBdatos);
              SQL.Clear;
              SQL.Add('select count(*) as contador from "fun$carnet"');
              SQL.Add('where "fun$carnet"."nit_beneficiario" = :nit');
              SQL.Add('and "fun$carnet"."programa" = :programa');
              ParamByName('programa').AsString := CDcarnet.FieldValues['programa'];
              ParamByName('nit').AsString := CDcarnet.FieldValues['nit_beneficiario'];
              Open;
              if FieldByName('contador').AsInteger = 0 then
              begin
                with DataQuerys.IBselecion do
                begin
                   Close;
                   verificatransaccion(DataQuerys.IBselecion);
                   SQL.Clear;
                   SQL.Add('insert into "fun$carnet"');
                   SQL.Add('values(');
                   SQL.Add(':no_carnet,:nit_beneficiario,');
                   SQL.Add(':descripcion,:programa)');
                   ParamByName('no_carnet').AsString := CDcarnet.FieldValues['no_carnet'];
                   ParamByName('nit_beneficiario').AsString := CDcarnet.FieldValues['nit_beneficiario'];
                   try
                   ParamByName('descripcion').AsString := CDcarnet.FieldValues['descripcion'];
                   except
                   on e: Exception do
                   ParamByName('descripcion').AsString := '';
                   end;
                   ParamByName('programa').AsString := CDcarnet.FieldValues['programa'];
                   Open;
                   Close;
                end;
              end
              else
              begin
                 with DataQuerys.IBselecion do
                 begin
                   Close;
                   verificatransaccion(DataQuerys.IBdatos);
                   SQL.Clear;
                   SQL.Add('update "fun$carnet"');
                   SQL.Add('set "fun$carnet"."no_carnet" = :carnet,');
                   SQL.Add('"fun$carnet"."descripcion" = :descripcion');
                   SQL.Add('where "fun$carnet"."nit_beneficiario" = :nit and');
                   SQL.Add('"fun$carnet"."programa" = :programa');
                   ParamByName('nit').AsString := CDcarnet.FieldValues['nit_beneficiario'];
                   ParamByName('programa').AsString := CDcarnet.FieldValues['programa'];
                   ParamByName('carnet').AsString := CDcarnet.FieldValues['no_carnet'];
                   try
                   ParamByName('descripcion').AsString := CDcarnet.FieldValues['descripcion'];
                   except
                   on e: Exception do
                   ParamByName('descripcion').AsString := '';
                   end;
                   Open;
                   Close;
                 end;
              end;
            end;
            Next;
          end;
          end;
        DataQuerys.IBselecion.Transaction.Commit;
        //CDcarnet.CancelUpdates;
        CDcarnet.Filtered := False;
        TEdocumento.Text := '';
        TEnombres.Text := '';
        DBoficina.SetFocus;
        end;
end;

procedure TFrmCarnet.SpeedButton1Click(Sender: TObject);
begin
          frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
          PrCarnet.Variables.ByName['empresa'].AsString := FrMain.Empresa;
          PrCarnet.Variables.ByName['hoy'].AsDateTime := Date;
          //PrCarnet.Variables.ByName['Empleado'].AsString := empleados(FrmQuerys.IBseleccion,UpperCase(FrMain.Dbalias));
          PrCarnet.Variables.ByName['Nit'].AsString := FrMain.Nit;
          PRcarnet.Variables.ByName['oficina'].AsString := DBconvenio.Text;
          PRcarnet.Variables.ByName['persona'].AsString := nombres.Caption + ' Indentificacion : '+Documento.Text;
          if PrCarnet.PrepareReport then
          begin
            frmVistaPreliminar.Reporte := PrCarnet;
            frmVistaPreliminar.ShowModal;
          end;
end;
procedure TFrmCarnet.DocumentoExit(Sender: TObject);
var    nombres1 :string;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT distinct');
          SQL.Add('"fun$beneficiario"."nombres"');
          SQL.Add('FROM');
          SQL.Add('"fun$beneficiario"');
          SQL.Add('WHERE');
          SQL.Add('("fun$beneficiario"."identificacion" = :nit_beneficiario) ');
          ParamByName('nit_beneficiario').AsString := Documento.Text;
          Open;
          nombres1 := FieldByName('nombres').AsString;
        end;
        if (nombres1 = '') then
        begin
          with FrmQuerys.IBseleccion do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select * from BUSCA_PERSONA_N1(:NIT)');
            ParamByName('NIT').AsString := Documento.Text;
            Open;
            nombres1 := FieldByName('APELLIDO1').AsString + ' ' +FieldByName('APELLIDO2').AsString + ' ' +FieldByName('NOMBRES').AsString;
            Close;
          end;
       end;
       nombres.Caption := nombres1;
end;

end.
