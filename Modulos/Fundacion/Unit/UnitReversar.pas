unit UnitReversar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, JvLabel, JvEdit, DBCtrls, DB,
  IBCustomDataSet, IBQuery,dateutils,jcldatetime, Grids, DBGrids, DBClient,
  Buttons ;

type
  TFrmReversar = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    DBconvenio: TDBLookupComboBox;
    Label4: TLabel;
    TEdocumento: TJvEdit;
    JvLabel2: TJvLabel;
    DTfecha: TDateTimePicker;
    JvLabel1: TJvLabel;
    TEnombres: TJvEdit;
    DSconvenio: TDataSource;
    IBconvenio: TIBQuery;
    CDafiliacion: TClientDataSet;
    CDafiliacionnit_asociado: TStringField;
    CDafiliacionnit_beneficiario: TStringField;
    CDafiliacionid_convenio: TIntegerField;
    DSdatos: TDataSource;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    CDafiliacionno_entrada: TIntegerField;
    CDafiliacionnombres: TStringField;
    CDafiliacionparentesco: TStringField;
    Panel3: TPanel;
    BtAceptar: TBitBtn;
    BtCancelar: TBitBtn;
    BTcerrar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure TEdocumentoExit(Sender: TObject);
    procedure BtCerrarClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
    procedure BtAceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    function beneficiario(nit: string; opcion: integer): string;
    function verifica(nit: string): boolean;
    { Public declarations }
  end;

var
  FrmReversar: TFrmReversar;

implementation

uses UnitQuerys, UnitdataQuerys, UnitGlobal;

{$R *.dfm}

function TFrmReversar.beneficiario(nit: string; opcion: integer): string;
begin
        with DataQuerys.IBFundacion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          case opcion of
            1: SQL.Add('"fun$beneficiario"."nombres" as total');
            2: SQL.Add('"fun$beneficiario"."tipo_id" as total');
            3: SQL.Add('"fun$beneficiario"."identificacion"as total');
            4: SQL.Add('"fun$beneficiario"."lugar_id" as total');
            5: SQL.Add('"fun$beneficiario"."sexo" as total');
            6: SQL.Add('"fun$beneficiario"."estrato" as total');
            7: SQL.Add('"fun$beneficiario"."direccion" as total');
            8: SQL.Add('"fun$beneficiario"."barrio" as total');
            9: SQL.Add('"fun$beneficiario"."telefono" as total');
           10: SQL.Add('"fun$beneficiario"."fecha_nacimiento" as total');
           11: SQL.Add('"fun$beneficiario"."ciudad" as total');
           12: SQL.Add('"fun$beneficiario"."no_entrada" as total');
          end;
          SQL.Add('FROM');
          SQL.Add('"fun$beneficiario"');
          SQL.Add('WHERE');
          SQL.Add('("fun$beneficiario"."identificacion" = :nit)');
          ParamByName('nit').AsString := nit;
          Open;
          Result := FieldByName('total').AsString;
          Close;
        end;
end; 

procedure TFrmReversar.cmChildKey(var msg: TWMKEY);
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

procedure TFrmReversar.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        IBconvenio.Open;
        IBconvenio.Last;
        DTfecha.Date := Date;
        DTfecha.MaxDate := Date;
        DBconvenio.KeyValue := 1;
end;

procedure TFrmReversar.TEdocumentoExit(Sender: TObject);
var     nit,nombres:string;
        a,id_afiliacion :Integer;
begin
        a := DaysInAMonth(YearOfDate(DTfecha.Date),MonthOfDate(DTfecha.Date));
        nombres := '';
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT distinct');
          SQL.Add('"fun$afiliacion"."nit_asociado",');
          SQL.Add('"fun$afiliacion"."id_afiliacion"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."fecha" BETWEEN :fecha AND :fecha1) and "fun$afiliacion"."nit_asociado" = :nit_beneficiario and');// (select max("fun$afiliacion"."fecha") from "fun$afiliacion" where "fun$afiliacion"."nit_beneficiario" = :"nit_beneficiario")) AND');
          SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
          ParamByName('nit_beneficiario').AsString := TEdocumento.Text;
          ParamByName('convenio').AsSmallInt := DBconvenio.KeyValue;
          ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',DTfecha.Date));
          ParamByName('fecha1').AsDate := StrToDate(FormatDateTime('yyyy/mm/'+IntToStr(a),DTfecha.Date));
          Open;
          nit := FieldByName('nit_asociado').AsString;
          id_afiliacion := FieldByName('id_afiliacion').AsInteger;
          if nit = '' then
          begin
            MessageDlg('No se Encuentra Registrado en esta Fecha',mtInformation,[mbok],0);
            DTfecha.SetFocus;
            Exit;
          end;
          SQL.Clear;
          SQL.Add('select "fun$beneficiario"."nombres" from "fun$beneficiario"');
          SQL.Add('where "fun$beneficiario"."identificacion" = :identificacion');
          ParamByName('identificacion').AsString := nit;
          Open;
          nombres := FieldByName('nombres').AsString;
          Close;
        end;
        if (nombres = '') and (nit <> '') then
        begin
            with FrmQuerys.IBseleccion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('select * from "gen$persona"');
              SQL.Add('where ID_PERSONA = :NIT');
              ParamByName('NIT').AsString := TEdocumento.Text;
              Open;
                nombres:= FieldByName('PRIMER_APELLIDO').AsString + ' ' +FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +FieldByName('NOMBRE').AsString;
              end;
        end;
        tenombres.Text := nombres;
        if (nombres = '') or (nombres = '  ') then
        begin
          MessageDlg('Error En la Entrada del Documento, Favor Verificar Informacion',mtInformation,[mbok],0);
          TEdocumento.Text := '';
          TEdocumento.SetFocus;
        end
        else
        begin
          if verifica(TEdocumento.Text) then
          begin
          with CDafiliacion do
          begin
            Append;
            FieldValues['nit_asociado'] := TEdocumento.Text;
            FieldValues['nit_beneficiario'] := TEdocumento.Text;
            FieldValues['id_convenio'] := DBconvenio.KeyValue;
            FieldValues['no_entrada'] := id_afiliacion;
            FieldValues['nombres'] := nombres;
            FieldValues['parentesco'] := 'A. TITULAR';
            Post;
          end;
          end;
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$afiliacion"."nit_beneficiario",');
          SQL.Add('"fun$afiliacion"."parentesco",');
          SQL.Add('"fun$afiliacion"."id_afiliacion",');
          SQL.Add('"fun$parentesco"."descripcion"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion","fun$parentesco"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."parentesco" = "fun$parentesco"."id_parentesco") and');
          SQL.Add('("fun$afiliacion"."nit_asociado" = :nit) AND');
          SQL.Add('("fun$afiliacion"."fecha" BETWEEN :fecha AND :fecha1) AND');
          SQL.Add('("fun$afiliacion"."id_convenio" = :convenio) AND');
          SQL.Add('("fun$afiliacion"."parentesco" <> 1)');
          ParamByName('nit').AsString := TEdocumento.Text;
          ParamByName('convenio').AsSmallInt := DBconvenio.KeyValue;
          ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',DTfecha.Date));
          ParamByName('fecha1').AsDate := StrToDate(FormatDateTime('yyyy/mm/'+IntToStr(a),DTfecha.Date));
          Open;
          while not Eof do
          begin
            with CDafiliacion do
            begin
              Append;
              FieldValues['nit_asociado'] := TEdocumento.Text;
              FieldValues['nit_beneficiario'] := DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString;
              FieldValues['id_convenio'] := DBconvenio.KeyValue;
              FieldValues['no_entrada'] := DataQuerys.IBdatos.FieldByName('id_afiliacion').AsInteger;
              FieldValues['nombres'] := beneficiario(DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString,1);
              FieldValues['parentesco'] := DataQuerys.IBdatos.FieldByName('descripcion').AsString;
              Post;
            end;
            Next;
          end;
          Close;
        end;
        end;
end;

procedure TFrmReversar.BtCerrarClick(Sender: TObject);
begin
        Close;

end;

procedure TFrmReversar.BtCancelarClick(Sender: TObject);
begin
        TEdocumento.Text := '';
        TEnombres.Text := '';
        CDafiliacion.CancelUpdates;
        TEdocumento.SetFocus;
end;

procedure TFrmReversar.BtAceptarClick(Sender: TObject);
begin
       if MessageDlg('Seguro de Realizar la Operacion',mtInformation,[mbyes,mbno],1) = mryes then
       begin
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
              SQL.Add('delete from "fun$afiliacion"');
              SQL.Add('where "fun$afiliacion"."id_afiliacion" = :entrada');
              ParamByName('entrada').AsInteger := CDafiliacion.FieldValues['no_entrada'];
              Open;
              Close;
              Transaction.Commit;
            end;
            Next;
          end;
          BtCancelar.Click;
        end;
       end;
end;

function TFrmReversar.verifica(nit: string): boolean;
var     a:Integer;
begin
        a := DaysInAMonth(YearOfDate(DTfecha.Date),MonthOfDate(DTfecha.Date));
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT *');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."nit_beneficiario" = :nit) AND');
          SQL.Add('("fun$afiliacion"."fecha" BETWEEN :fecha1 AND :fecha2)');
          ParamByName('nit').AsString := nit;
          ParamByName('fecha1').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',DTfecha.Date));
          ParamByName('fecha2').AsDate := StrToDate(FormatDateTime('yyyy/mm/'+IntToStr(a),DTfecha.Date));
          Open;
          if RecordCount <> 0 then
            Result := true
          else
            Result := False;
          Close;
          Transaction.Commit;
        end;
end;

end.
