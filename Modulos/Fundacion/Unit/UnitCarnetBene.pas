unit UnitCarnetBene;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, DBGrids, StdCtrls, ExtCtrls, DB, DBClient,
  pr_Common, pr_TxClasses, DBCtrls, IBCustomDataSet, IBQuery, IBDatabase,idglobal;

type
  TFrmCarnetBene = class(TForm)
    Panel2: TPanel;
    Label5: TLabel;
    DBCarnet: TDBGrid;
    Panel4: TPanel;
    BtActualizar: TSpeedButton;
    BTcancelar: TSpeedButton;
    BTsalir: TSpeedButton;
    SpeedButton1: TSpeedButton;
    CDcarnet: TClientDataSet;
    CDcarnetnit_beneficiario: TStringField;
    CDcarnetprograma: TIntegerField;
    CDcarnetno_carnet: TStringField;
    CDcarnetdescripcion: TStringField;
    CDcarnetnombres: TStringField;
    DScarnet: TDataSource;
    Panel1: TPanel;
    Label3: TLabel;
    DBconvenio: TDBLookupComboBox;
    IBToficina: TIBTransaction;
    DSconvenio: TDataSource;
    IBconvenio: TIBQuery;
    CDnit: TClientDataSet;
    CDnitnit: TStringField;
    PrCarnet: TprTxReport;
    procedure CDcarnetnit_beneficiarioValidate(Sender: TField);
    procedure FormCreate(Sender: TObject);
    procedure DBCarnetDblClick(Sender: TObject);
    procedure BTsalirClick(Sender: TObject);
    procedure DBconvenioExit(Sender: TObject);
    procedure BTcancelarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure BtActualizarClick(Sender: TObject);
  private
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmCarnetBene: TFrmCarnetBene;

implementation

uses UnitQuerys,Unitdatamodulo, UnitdataQuerys, UnitPrincipal,UnitVistapreliminar,unitGlobal;

{$R *.dfm}

procedure TFrmCarnetBene.cmChildKey(var msg: TWMKEY);
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

procedure TFrmCarnetBene.CDcarnetnit_beneficiarioValidate(Sender: TField);
var    nit :string;
begin
        if CDnit.Locate('nit',CDcarnetnit_beneficiario.Text,[loPartialKey]) then
        begin
           CDcarnet.Delete;
           Exit;
        end;
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
          SQL.Add('("fun$afiliacion"."fecha" = (select max("fun$afiliacion"."fecha") from "fun$afiliacion" where "fun$afiliacion"."nit_beneficiario" = :"nit_beneficiario")) AND');
          SQL.Add('("fun$afiliacion"."nit_beneficiario" = :nit_beneficiario) and');
          SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
          ParamByName('nit_beneficiario').AsString := cdcarnetnit_beneficiario.Text;
          ParamByName('convenio').AsSmallInt := DBconvenio.KeyValue;
          Open;
          nit := FieldByName('nit_beneficiario').AsString;
          if nit = '' then
          begin
            MessageDlg('No Existe el Numero de Identificación',mtInformation,[mbok],0);
            CDcarnet.Delete;
            Exit;
          end;
          CDcarnetnombres.Text := FieldByName('nombres').AsString;
          CDcarnetno_carnet.Text := buscar_carnet(CDcarnetnit_beneficiario.Text,DBconvenio.KeyValue,1);
          CDcarnetprograma.Value := DBconvenio.KeyValue;
          Close;
        end;
        if (CDcarnetnombres.Text = '') and (nit <> '') then
        begin
            with FrmQuerys.IBseleccion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('select * from BUSCA_PERSONA_N1(:NIT)');
              ParamByName('NIT').AsString := CDcarnetnit_beneficiario.Text;
              Open;
              if RecordCount = 0 then
              begin
                 MessageDlg('Verifique la Informacion el No de Identificacion'+#13+'no se Encuentra Registrado el la Base de Datos.',mtInformation,[mbok],0);
                 CDcarnet.Delete;
                 Exit;
              end
              else
              begin
                CDcarnetnombres.Text := FieldByName('APELLIDO1').AsString + ' ' +FieldByName('APELLIDO2').AsString + ' ' +FieldByName('NOMBRES').AsString;
              end;
              Close;
            end;
        end;
        CDnit.Append;
        CDnit.FieldValues['nit'] := nit;
        CDnit.Post;
end;

procedure TFrmCarnetBene.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        IBconvenio.Open;
        IBconvenio.Last;
end;

procedure TFrmCarnetBene.DBCarnetDblClick(Sender: TObject);
begin
        try
          CDcarnet.Delete;
        except
        on e: Exception do
           MessageDlg('No existen Datos Para Eliminar',mtInformation,[mbok],0);
        end;
end;

procedure TFrmCarnetBene.BTsalirClick(Sender: TObject);
begin
        Close;
//CopyFileTo('c:\dd.txt','c:\act\ss.txt');
//DeleteFile('c:\act\ss.txt');
end;

procedure TFrmCarnetBene.DBconvenioExit(Sender: TObject);
begin
        if DBconvenio.Text = '' then
           DBconvenio.KeyValue := 1;
end;

procedure TFrmCarnetBene.BTcancelarClick(Sender: TObject);
begin
        CDcarnet.CancelUpdates;
        CDnit.CancelUpdates;
end;

procedure TFrmCarnetBene.SpeedButton1Click(Sender: TObject);
begin
          frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
          PrCarnet.Variables.ByName['empresa'].AsString := FrMain.Empresa;
          PrCarnet.Variables.ByName['hoy'].AsDateTime := Date;
          PrCarnet.Variables.ByName['Empleado'].AsString := empleados(UpperCase(FrMain.Dbalias),1);
          PrCarnet.Variables.ByName['Nit'].AsString := FrMain.Nit;
          PRcarnet.Variables.ByName['oficina'].AsString := DBconvenio.Text;
          if PrCarnet.PrepareReport then
          begin
            frmVistaPreliminar.Reporte := PrCarnet;
            frmVistaPreliminar.ShowModal;
          end;
end;

procedure TFrmCarnetBene.BtActualizarClick(Sender: TObject);
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
              SQL.Clear;
              SQL.Add('select count(*) as contador from "fun$carnet"');
              SQL.Add('where "fun$carnet"."nit_beneficiario" = :nit');
              SQL.Add('and "fun$carnet"."programa" = :programa');
              ParamByName('programa').AsInteger := CDcarnet.FieldValues['programa'];
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
                   ParamByName('programa').AsInteger := CDcarnet.FieldValues['programa'];
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
        CDcarnet.CancelUpdates;
        end;
end;

end.
