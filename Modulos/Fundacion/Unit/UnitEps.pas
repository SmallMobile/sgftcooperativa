unit UnitEps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TFrmEps = class(TForm)
    Panel3: TPanel;
    BCancelar: TSpeedButton;
    Baceptar: TBitBtn;
    SPcerrar: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    LBcodigo: TLabel;
    TEDescripcion: TEdit;
    procedure SPcerrarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BaceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TEDescripcionKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
  published
    function codigo: integer;
    { Public declarations }
  end;

var
  FrmEps: TFrmEps;

implementation

uses UnitQuerys,UnitGlobal;

{$R *.dfm}

function TFrmEps.codigo: integer;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('MAX("fun$eps"."id_eps") AS "codigo"');
          SQL.Add('FROM');
          SQL.Add('"fun$eps"');
          Open;
          Result := FieldByName('codigo').AsInteger + 1;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmEps.SPcerrarClick(Sender: TObject);
begin

        Close;
end;

procedure TFrmEps.BCancelarClick(Sender: TObject);
begin
        TEDescripcion.Text := '';
end;

procedure TFrmEps.BaceptarClick(Sender: TObject);
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('insert into "fun$eps" values (');
          SQL.Add(':id_eps,:descripcion)');
          ParamByName('id_eps').AsSmallInt := StrToInt(LBcodigo.Caption);
          ParamByName('descripcion').AsString := TEDescripcion.Text;
          Open;
          Close;
          Transaction.Commit;
        end;
        TEDescripcion.Text := '';
        TEDescripcion.SetFocus;
        LBcodigo.Caption := IntToStr(codigo);
end;

procedure TFrmEps.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        LBcodigo.Caption := IntToStr(codigo);
end;

procedure TFrmEps.TEDescripcionKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           Baceptar.SetFocus;
end;

end.
