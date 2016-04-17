unit UnitConferencista;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TFrmConferencista = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    nombre: TEdit;
    entidad: TEdit;
    Panel3: TPanel;
    BCancelar: TSpeedButton;
    SPcerrar: TSpeedButton;
    Baceptar: TBitBtn;
    procedure nombreKeyPress(Sender: TObject; var Key: Char);
    procedure entidadKeyPress(Sender: TObject; var Key: Char);
    procedure BaceptarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure SPcerrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConferencista: TFrmConferencista;

implementation

uses UnitQuerys,UnitGlobal, UnitCapacitacioncon;

{$R *.dfm}

procedure TFrmConferencista.nombreKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           entidad.SetFocus
end;

procedure TFrmConferencista.entidadKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           Baceptar.SetFocus
end;

procedure TFrmConferencista.BaceptarClick(Sender: TObject);
var     id_conferencista :Integer;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('select max("fun$conferencista"."id_conferencista") as codigo');
          SQL.Add('from "fun$conferencista"');
          Open;
          id_conferencista := FieldByName('codigo').AsInteger + 1;
          SQL.Clear;
          SQL.Add('insert into "fun$conferencista" values (');
          SQL.Add(':id_conferencista,:nombre,:entidad)');
          ParamByName('id_conferencista').AsInteger := id_conferencista;
          ParamByName('nombre').AsString := nombre.Text;
          ParamByName('entidad').AsString := entidad.Text;
          Open;
          Close;
          Transaction.Commit;
        end;
        with FrmCapacitacionCon.cdconferencista do
        begin
          Append;
          FieldValues['id_capacitacion'] := FrmCapacitacionCon.descripcion.KeyValue;
          FieldValues['id_persona'] := id_conferencista;
          FieldValues['nombre'] := nombre.Text;
          FieldValues['entidad'] := entidad.Text;
          Post;
        end;
        FrmCapacitacionCon.IBQuery2.Close;
        verificatransaccion(FrmCapacitacionCon.IBQuery2);
        FrmCapacitacionCon.IBQuery2.Open;
        FrmCapacitacionCon.IBQuery2.Last;
        BCancelar.Click;
        Close;
end;

procedure TFrmConferencista.BCancelarClick(Sender: TObject);
begin
        nombre.Text := '';
        entidad.Text := '';
end;

procedure TFrmConferencista.SPcerrarClick(Sender: TObject);
begin
        Close;
end;

end.
