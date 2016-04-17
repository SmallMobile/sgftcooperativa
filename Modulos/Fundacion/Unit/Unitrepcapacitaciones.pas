unit Unitrepcapacitaciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, JvBitBtn, JvPanel, JvEdit, DBCtrls, ExtCtrls,
  DB, IBDatabase, IBCustomDataSet, IBQuery, DBClient;

type
  TFrmRepcapacitaciones = class(TForm)
    Oficina: TLabel;
    dboficina: TDBLookupComboBox;
    Documento: TLabel;
    nit: TJvEdit;
    JvPanel1: TJvPanel;
    JvBitBtn1: TJvBitBtn;
    JvBitBtn2: TJvBitBtn;
    IBQuery2: TIBQuery;
    IBTransaction2: TIBTransaction;
    DataSource2: TDataSource;
    dfd: TPanel;
    cdoficina: TClientDataSet;
    cdoficinaid_agencia: TIntegerField;
    cdoficinadescripcion: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure JvBitBtn2Click(Sender: TObject);
    procedure dboficinaKeyPress(Sender: TObject; var Key: Char);
    procedure nitKeyPress(Sender: TObject; var Key: Char);
    procedure JvBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRepcapacitaciones: TFrmRepcapacitaciones;

implementation

uses UnitdataQuerys, UnitReportes, UnitQuerys,UnitGlobal, UnitGlobales;

{$R *.dfm}

procedure TFrmRepcapacitaciones.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        FrmReportes := TFrmReportes.Create(self);
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
end;

procedure TFrmRepcapacitaciones.JvBitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmRepcapacitaciones.dboficinaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           nit.SetFocus
end;

procedure TFrmRepcapacitaciones.nitKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           JvBitBtn1.SetFocus
end;

procedure TFrmRepcapacitaciones.JvBitBtn1Click(Sender: TObject);
begin
        if dboficina.KeyValue = Agencia then
        begin
          with FrmQuerys.IBseleccion do
          begin
          Close;
          verificatransaccion(FrmQuerys.IBseleccion);
          SQL.Clear;
          SQL.Add(' select * from "gen$persona"');
          SQL.Add('where ID_PERSONA = :NIT');
          ParamByName('NIT').AsString := nit.Text;
          Open;
          FrmReportes.asociado := FieldByName('PRIMER_APELLIDO').AsString + ' ' +FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +FieldByName('NOMBRE').AsString;
          Close;
        end;
        end
        else
        begin
         with DataQuerys.IBingresa do
         begin
           Close;
           verificatransaccion(DataQuerys.IBingresa);
           SQL.Clear;
           SQL.Add('select * FROM BUSCA_BENE(:NIT)');
           ParamByName('NIT').AsString := nit.Text;
           Open;
           FrmReportes.asociado := FieldByName('NOMBRES').AsString;
           Close;
         end;
        end;
        FrmReportes.nit_asociado := nit.Text;
        FrmReportes.capaciatacionaso;

end;

end.
