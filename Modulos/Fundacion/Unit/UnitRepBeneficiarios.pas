unit UnitRepBeneficiarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, DB, IBCustomDataSet, IBQuery, StdCtrls,
  DBClient, ComCtrls, Buttons, IBDatabase, pr_Common, pr_TxClasses,StrUtils;

type
  TFrmRepBeneficiarios = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    IBconvenio: TIBQuery;
    DSconvenio: TDataSource;
    DBconvenio: TDBLookupComboBox;
    Label2: TLabel;
    Fecha: TDateTimePicker;
    Label3: TLabel;
    DSOFICINA: TDataSource;
    CDoficina: TClientDataSet;
    CDoficinacod_oficina: TIntegerField;
    CDoficinaoficina: TStringField;
    DBOficina: TDBLookupComboBox;
    Panel3: TPanel;
    BCancelar: TSpeedButton;
    Baceptar: TBitBtn;
    IBTransaction1: TIBTransaction;
    CDbeneficiarios: TClientDataSet;
    CDbeneficiariosdocumento: TStringField;
    CDbeneficiariosnombres: TStringField;
    CDbeneficiariosciudad: TStringField;
    CDbeneficiariostelefono: TStringField;
    CDbeneficiariosnumero: TIntegerField;
    CDbeneficiariosbarrio: TStringField;
    CDbeneficiariosdireccion: TStringField;
    PrAfiliacion: TprTxReport;
    procedure FormCreate(Sender: TObject);
    procedure BaceptarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
  es_asociado :Boolean;
    { Public declarations }
  end;

var
  FrmRepBeneficiarios: TFrmRepBeneficiarios;

implementation

uses UnitQuerys, UnitPantallaProgreso, UnitPrincipal, UnitGlobal, UnitVistaPreliminar,
  UnitdataQuerys, UnitGlobales;

{$R *.dfm}

procedure TFrmRepBeneficiarios.FormCreate(Sender: TObject);
begin
        Fecha.Date := Date;
        Fecha.MaxDate := Date;
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        IBconvenio.Open;
        IBconvenio.Last;
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$oficinas"."descripcion",');
          SQL.Add('"fun$oficinas"."cod_oficina"');
          SQL.Add('FROM');
          SQL.Add('"fun$oficinas"');
          Open;
          while not Eof do
          begin
             CDoficina.Append;
             CDoficina.FieldValues['cod_oficina'] := FieldByName('cod_oficina').AsInteger;
             CDoficina.FieldValues['oficina'] := FieldByName('descripcion').AsString;
             CDoficina.Post;
             Next;
          end;
             //CDoficina.Append;
             //CDoficina.FieldValues['cod_oficina'] := 111;
             //CDoficina.FieldValues['oficina'] := 'GENERAL';
             //CDoficina.Post;
        end;
        DBOficina.KeyValue := 111;
end;

procedure TFrmRepBeneficiarios.BaceptarClick(Sender: TObject);
var       descrripcion_bene,cadena,h :string;
          s :Integer;
begin
          frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
          CDbeneficiarios.CancelUpdates;
          with DataQuerys.IBdatos do
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT DISTINCT');
            SQL.Add('"fun$afiliacion"."nit_beneficiario"');
            SQL.Add('FROM');
            SQL.Add('"fun$afiliacion"');
            SQL.Add('WHERE');
            if es_asociado then
              SQL.Add('("fun$afiliacion"."parentesco" = 1) AND')
            else
              SQL.Add('("fun$afiliacion"."parentesco" <> 1) AND');
            SQL.Add('("fun$afiliacion"."id_convenio" = :convenio) AND');
            SQL.Add('("fun$afiliacion"."fecha" >= :fecha)');
            if DBOficina.KeyValue <> 111 then
            begin
              SQL.Add('AND("fun$afiliacion"."cod_oficina" = :oficina)');
              ParamByName('oficina').AsInteger := DBOficina.KeyValue;
            end;
            ParamByName('convenio').AsInteger := DBconvenio.KeyValue;
            ParamByName('fecha').AsDate := Fecha.Date;
            Open;
            Last;
            First;
            frmProgresos := TfrmProgresos.Create(self);
            frmProgresos.Max := RecordCount;
            frmProgresos.Min := 0;
            frmProgresos.Titulo := 'Reporte Beneficiarios...';
            frmProgresos.Ejecutar;
            while not Eof do
            begin
            if DBOficina.KeyValue <> 111 then begin
              frmProgresos.Position := RecNo;
              frmProgresos.InfoLabel := 'Registro No : '+IntToStr(RecNo);
              Application.ProcessMessages;
              if es_asociado = False then
              begin
                with DataQuerys.IBselecion do
                begin
                  SQL.Clear;
                  SQL.Add('select * from BUSCA_BENE(:NIT)');
                  ParamByName('NIT').AsString := DataQuerys.IBdatos.fieldbyname('nit_beneficiario').AsString;
                  Open;
                  CDbeneficiarios.Append;
                  CDbeneficiarios.FieldValues['numero'] := DataQuerys.IBdatos.RecNo;
                  CDbeneficiarios.FieldValues['documento'] := DataQuerys.IBdatos.fieldbyname('nit_beneficiario').AsString;
                  CDbeneficiarios.FieldValues['nombres'] := FieldByName('NOMBRES').AsString;
                  CDbeneficiarios.FieldValues['ciudad'] := FieldByName('MUNICIPIO').AsString;
                  CDbeneficiarios.FieldValues['telefono'] := FieldByName('TELEFONO').AsString;
                  CDbeneficiarios.FieldValues['barrio'] := FieldByName('BARRIO').AsString;
                  CDbeneficiarios.FieldValues['direccion'] := FieldByName('DIRECCION').AsString;
                  CDbeneficiarios.Post;
                end;
              end
              else
              begin
               if DBOficina.KeyValue = Agencia then
               begin
                 cadena := DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString;
                 s := StrLen(PChar(cadena));
                 h := MidStr(cadena,s,1);
                 if h = '/' then
                  cadena := LeftStr(cadena,s-1);
                 with FrmQuerys.IBseleccion do
                 begin
                   Close;
                   SQL.Clear;
                   SQL.Add('select * from BUSCA_PERSONA_N1 (:NIT)');
                   ParamByName('NIT').AsString := cadena;
                   Open;
                   CDbeneficiarios.Append;
                   CDbeneficiarios.FieldValues['numero'] := DataQuerys.IBdatos.RecNo;
                   CDbeneficiarios.FieldValues['documento'] := DataQuerys.IBdatos.fieldbyname('nit_beneficiario').AsString;
                   CDbeneficiarios.FieldValues['nombres'] := FieldByName('APELLIDO1').AsString+' '+FieldByName('APELLIDO2').AsString+' '+FieldByName('NOMBRES').AsString;
                   CDbeneficiarios.FieldValues['ciudad'] := FieldByName('MUNICIPIO').AsString;
                   CDbeneficiarios.FieldValues['telefono'] := FieldByName('TELEFONO').AsString;
                   CDbeneficiarios.FieldValues['barrio'] := FieldByName('BARRIO').AsString;
                   CDbeneficiarios.FieldValues['direccion'] := FieldByName('DIRECCION').AsString;
                   CDbeneficiarios.Post;
                 end;
               end
               else
               begin
                with DataQuerys.IBselecion do
                begin
                  SQL.Clear;
                  SQL.Add('select * from BUSCA_BENE(:NIT)');
                  ParamByName('NIT').AsString := DataQuerys.IBdatos.fieldbyname('nit_beneficiario').AsString;
                  Open;
                  CDbeneficiarios.Append;
                  CDbeneficiarios.FieldValues['numero'] := DataQuerys.IBdatos.RecNo;
                  CDbeneficiarios.FieldValues['documento'] := DataQuerys.IBdatos.fieldbyname('nit_beneficiario').AsString;
                  CDbeneficiarios.FieldValues['nombres'] := FieldByName('NOMBRES').AsString;
                  CDbeneficiarios.FieldValues['ciudad'] := FieldByName('MUNICIPIO').AsString;
                  CDbeneficiarios.FieldValues['telefono'] := FieldByName('TELEFONO').AsString;
                  CDbeneficiarios.FieldValues['barrio'] := FieldByName('BARRIO').AsString;
                  CDbeneficiarios.FieldValues['direccion'] := FieldByName('DIRECCION').AsString;
                  CDbeneficiarios.Post;
                  Close;
                end;
               end;
               end;
            end;
              Next;
            end;

            Close;
            frmProgresos.Cerrar;
          end;
            PrAfiliacion.Variables.ByName['empresa'].AsString := FrMain.Empresa;
            PrAfiliacion.Variables.ByName['hoy'].AsDateTime := Date;
            PrAfiliacion.Variables.ByName['empleado'].AsString := empleados(UpperCase(FrMain.Dbalias),2);
            PrAfiliacion.Variables.ByName['Nit'].AsString := FrMain.Nit;
            PrAfiliacion.Variables.ByName['Convenio'].AsString := DBconvenio.Text;
            if es_asociado then
               descrripcion_bene := 'Reporte General de Asociados'
            else
               descrripcion_bene := 'Reporte General de Beneficiarios';

            if DBoficina.KeyValue = 111 then
              PrAfiliacion.Variables.ByName['tramite'].AsString := descrripcion_bene
            else
              PrAfiliacion.Variables.ByName['tramite'].AsString := descrripcion_bene+' '+DBOficina.Text;
            if PrAfiliacion.PrepareReport then
            begin
              frmVistaPreliminar.Reporte := PrAfiliacion;
              frmVistaPreliminar.ShowModal;
            end;
            frmVistaPreliminar.Free;

end;

procedure TFrmRepBeneficiarios.BCancelarClick(Sender: TObject);
begin
        Close;
end;

end.
