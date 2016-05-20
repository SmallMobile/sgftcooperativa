unit UnitAfiliacionEps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, DB, IBCustomDataSet,
  IBQuery, IBDatabase;

type
  TFrmAfiliacionEps = class(TForm)
    Panel3: TPanel;
    BCancelar: TSpeedButton;
    SPcerrar: TSpeedButton;
    Baceptar: TBitBtn;
    label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    IBconvenio: TIBQuery;
    DSconvenio: TDataSource;
    DBconvenio: TDBLookupComboBox;
    Nit: TEdit;
    DBEps: TDBLookupComboBox;
    DataSource1: TDataSource;
    IBEps: TIBQuery;
    IBTransaction1: TIBTransaction;
    panel: TPanel;
    procedure SPcerrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NitExit(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BaceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmAfiliacionEps: TFrmAfiliacionEps;

implementation
uses UnitDataModulo, UnitQuerys, UnitdataQuerys,UnitGlobal;

{$R *.dfm}

procedure TFrmAfiliacionEps.SPcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmAfiliacionEps.FormCreate(Sender: TObject);
begin
        IBconvenio.Open;
        IBEps.Open;
        IBEps.Last;
        IBconvenio.Last;
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        DBconvenio.KeyValue := 4;
        DBEps.KeyValue := 1;
end;

procedure TFrmAfiliacionEps.cmChildKey(var msg: TWMKEY);
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

procedure TFrmAfiliacionEps.NitExit(Sender: TObject);
var     nit1,nombre :string;
begin

        if Nit.Text <> '' then
        begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$beneficiario"."nombres",');
          SQL.Add('"fun$afiliacion"."nit_beneficiario"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('LEFT OUTER JOIN "fun$beneficiario" ON ("fun$afiliacion"."nit_beneficiario" = "fun$beneficiario"."identificacion")');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."nit_beneficiario" = :nit_beneficiario) and');
          SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
          ParamByName('nit_beneficiario').AsString := Nit.Text;
          ParamByName('convenio').AsSmallInt := DBconvenio.KeyValue;
          Open;
          nit1 := FieldByName('nit_beneficiario').AsString;
          if nit1 = '' then
          begin
            MessageDlg('No se Encuentra Afiliado(a) a este Programa',mtWarning,[mbok],0);
            Nit.SetFocus;
            Exit;
          end;
          nombre := FieldByName('nombres').AsString;
          Close;
        end;
        if (nombre = '') and (nit1 <> '') then
        begin
            with FrmQuerys.IBseleccion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('select * from BUSCA_PERSONA_N1(:NIT)');
              ParamByName('NIT').AsString := Nit.Text;
              Open;
              if RecordCount = 0 then
              begin
                 MessageDlg('Verifique la Informacion el No de Identificacion'+#13+'no se Encuentra Registrado el la Base de Datos.',mtInformation,[mbok],0);
                 Nit.SetFocus;
                 Exit;
              end
              else
              begin
                nombre := FieldByName('APELLIDO1').AsString + ' ' +FieldByName('APELLIDO2').AsString + ' ' +FieldByName('NOMBRES').AsString;
              end;
              Close;
            end;
        end;

        MessageDlg(nombre,mtinformation,[mbok],0);
        end;
end;

procedure TFrmAfiliacionEps.BCancelarClick(Sender: TObject);
begin
        Nit.Text := '';
        DBconvenio.SetFocus;
end;

procedure TFrmAfiliacionEps.BaceptarClick(Sender: TObject);
begin
        if Nit.Text = '' then
        begin
          Nit.SetFocus;
          Exit;
        end;
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('insert into "fun$afiliacioneps" values (');
          SQL.Add(':id_eps,:nit_beneficiario,:id_convenio)');
          ParamByName('id_eps').AsInteger := DBEps.KeyValue;
          ParamByName('nit_beneficiario').AsString := Nit.Text;
          ParamByName('id_convenio').AsInteger := DBconvenio.KeyValue;
          Open;
          Close;
          Transaction.Commit;
        end;
        Nit.Text := '';
        DBconvenio.SetFocus;
end;

end.
