unit UnitActualizaBene;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, DBCtrls, Grids, DBGrids, StdCtrls, ExtCtrls, DB,
  IBCustomDataSet, IBQuery, DBClient;

type
  TFrmActualizaBene = class(TForm)
    Panel2: TPanel;
    Label5: TLabel;
    DBCarnet: TDBGrid;
    Panel1: TPanel;
    Label3: TLabel;
    DBconvenio: TDBLookupComboBox;
    Panel4: TPanel;
    BtActualizar: TSpeedButton;
    BTcancelar: TSpeedButton;
    BTsalir: TSpeedButton;
    IBconvenio: TIBQuery;
    DSconvenio: TDataSource;
    CDfecha: TClientDataSet;
    CDfechanit: TStringField;
    CDfechanombres: TStringField;
    CDfechaid_afiliacion: TIntegerField;
    DataSource1: TDataSource;
    CDfechafecha_registro: TStringField;
    CDfechafecha_ven: TDateField;
    CDnit: TClientDataSet;
    CDnitnit: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure CDfechanitValidate(Sender: TField);
    procedure CDfechaEditError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure CDfechaPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure BTsalirClick(Sender: TObject);
    procedure DBCarnetCellClick(Column: TColumn);
    procedure BtActualizarClick(Sender: TObject);
    procedure BTcancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmActualizaBene: TFrmActualizaBene;

implementation
uses UnitdataQuerys, UnitQuerys, Unitglobal;
{$R *.dfm}
procedure TFrmActualizaBene.FormCreate(Sender: TObject);
begin
        IBconvenio.Open;
        IBconvenio.Last;
        DBconvenio.KeyValue := 1;
end;

procedure TFrmActualizaBene.CDfechanitValidate(Sender: TField);
var     nit :string;
begin
        if CDfechanit.Text = '' then
           Abort;
        if CDnit.Locate('nit',CDfechanit.Text,[loPartialKey]) then
        begin
           CDfecha.Delete;
           Exit;
        end;
        dataquerys := tdataquerys.Create(Self);
        FrmQuerys := TFrmQuerys.Create(self);
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$beneficiario"."nombres",');
          SQL.Add('"fun$carnet"."no_carnet",');
          SQL.Add('"fun$afiliacion"."fecha"');
          SQL.Add(',"fun$afiliacion"."nit_beneficiario",');
          SQL.Add('"fun$afiliacion"."id_afiliacion"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('LEFT OUTER JOIN "fun$carnet" ON ("fun$afiliacion"."nit_beneficiario" = "fun$carnet"."nit_beneficiario")');
          SQL.Add('LEFT OUTER JOIN "fun$beneficiario" ON ("fun$afiliacion"."nit_beneficiario" = "fun$beneficiario"."identificacion")');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."fecha" = (select max("fun$afiliacion"."fecha") from "fun$afiliacion" where "fun$afiliacion"."nit_beneficiario" = :"nit_beneficiario")) AND');
          SQL.Add('("fun$afiliacion"."nit_beneficiario" = :nit_beneficiario) and');
          SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
          //SQL.Add('and ("fun$afiliacion"."fecha" = (select max("fun$afiliacion"."fecha") from "fun$afiliacion" where "fun$afiliacion"."nit_beneficiario" = :nit_beneficiario))');
          ParamByName('nit_beneficiario').AsString := cdfechanit.Text;
          ParamByName('convenio').AsSmallInt := DBconvenio.KeyValue;
          Open;
          nit := FieldByName('nit_beneficiario').AsString;
          if nit = '' then
          begin
            MessageDlg('No Existe el Numero de Identificación',mtInformation,[mbok],0);
            CDfecha.Delete;
            Exit;
          end;
          CDfechanombres.Text := FieldByName('nombres').AsString;
          CDfechafecha_registro.Text := FieldByName('fecha').AsString;
          CDfechaid_afiliacion.Text := FieldByName('id_afiliacion').AsString;
          Close;
        end;
        if (CDfechanombres.Text = '') and (nit <> '') then
        begin
            with FrmQuerys.IBseleccion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('select * from BUSCA_PERSONA_N1(:NIT)');
              ParamByName('NIT').AsString := CDfechanit.Text;
              Open;
              if RecordCount = 0 then
              begin
                 MessageDlg('Verifique la Informacion el No de Identificacion'+#13+'no se Encuentra Registrado el la Base de Datos.',mtInformation,[mbok],0);
                 CDfecha.Delete;
                 Exit;
              end
              else
              begin
                CDfechanombres.Text := FieldByName('APELLIDO1').AsString + ' ' +FieldByName('APELLIDO2').AsString + ' ' +FieldByName('NOMBRES').AsString;
              end;
              Close;
            end;
        end;
        CDnit.Append;
        CDnit.FieldValues['nit'] := nit;
        CDnit.Post;
end;

procedure TFrmActualizaBene.cmChildKey(var msg: TWMKEY);
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

procedure TFrmActualizaBene.CDfechaEditError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
        if E.Message <> '' then
           Abort;
end;

procedure TFrmActualizaBene.CDfechaPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
        if E.Message <> '' then
        begin
            E.Message := 'El Formato de la Fecha no es Valido';
        end;
end;
procedure TFrmActualizaBene.BTsalirClick(Sender: TObject);
begin
        Close;
end;
procedure TFrmActualizaBene.DBCarnetCellClick(Column: TColumn);
begin
ShowMessage(CDfechaid_afiliacion.Text);
end;

procedure TFrmActualizaBene.BtActualizarClick(Sender: TObject);
begin
        if MessageDlg('Seguro de realizar la transaccion',mtInformation,[mbYes, mbNo],1) = mryes then
        begin
          with CDfecha do
          begin
            First;
            while not Eof do
            begin
              try
              with DataQuerys.IBdatos do
              begin
                Close;
                verificatransaccion(DataQuerys.IBdatos);
                SQL.Clear;
                SQL.Add('update "fun$afiliacion" set ');
                SQL.Add('"fun$afiliacion"."fecha_vencimiento" = :fecha');
                SQL.Add('where "fun$afiliacion"."id_afiliacion" = :id_afiliacion');
                ParamByName('fecha').AsDate := StrToDate(CDfechafecha_ven.Text);
                ParamByName('id_afiliacion').AsString := CDfechaid_afiliacion.Text;
                Open;
                Close;
                Transaction.Commit;
              end;
              except
              MessageDlg('El Formato de la Fecha no es Valido',mtInformation,[mbok],0);
              end;
              Next;
            end;
          end;
        end;
        CDfecha.CancelUpdates;
end;

procedure TFrmActualizaBene.BTcancelarClick(Sender: TObject);
begin
        CDfecha.CancelUpdates;
end;

end.
