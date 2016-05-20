unit UnitTipocapacitacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmTipocapacitacion = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    LBcodigo: TLabel;
    TEDescripcion: TEdit;
    Panel3: TPanel;
    BCancelar: TSpeedButton;
    SPcerrar: TSpeedButton;
    Baceptar: TBitBtn;
    procedure SPcerrarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TEDescripcionKeyPress(Sender: TObject; var Key: Char);
    procedure BaceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
  published
    function codigo: integer;
    { Public declarations }
  end;

var
  FrmTipocapacitacion: TFrmTipocapacitacion;

implementation

uses UnitQuerys,UnitGlobal;

{$R *.dfm}

procedure TFrmTipocapacitacion.SPcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmTipocapacitacion.BCancelarClick(Sender: TObject);
begin
        TEDescripcion.Text := '';
end;

function TFrmTipocapacitacion.codigo: integer;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('MAX("fun$tipocapacitacion"."id_tipo") AS "codigo"');
          SQL.Add('FROM');
          SQL.Add('"fun$tipocapacitacion"');
          Open;
          Result := FieldByName('codigo').AsInteger + 1;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmTipocapacitacion.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        LBcodigo.Caption := IntToStr(codigo);
end;

procedure TFrmTipocapacitacion.TEDescripcionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           Baceptar.SetFocus;
end;

procedure TFrmTipocapacitacion.BaceptarClick(Sender: TObject);
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('insert into "fun$tipocapacitacion" values (');
          SQL.Add(':id_tipocapacitacion,:descripcion)');
          ParamByName('id_tipocapacitacion').AsSmallInt := StrToInt(LBcodigo.Caption);
          ParamByName('descripcion').AsString := TEDescripcion.Text;
          Open;
          Close;
          Transaction.Commit;
        end;
        TEDescripcion.Text := '';
        TEDescripcion.SetFocus;
        LBcodigo.Caption := IntToStr(codigo);
end;

end.
