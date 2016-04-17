unit UnitActuliza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvEdit, ExtCtrls, JvLabel, JvPanel, JvCtrls;

type
  TFrmActualiza = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    codigo: TJvEdit;
    JvLabel1: TJvLabel;
    titulo: TJvEdit;
    JvPanel1: TJvPanel;
    Label2: TLabel;
    JvPanel2: TJvPanel;
    nuevo: TJvEdit;
    JvImgBtn1: TJvImgBtn;
    procedure codigoExit(Sender: TObject);
    procedure JvImgBtn1Click(Sender: TObject);
    procedure codigoKeyPress(Sender: TObject; var Key: Char);
  private
  codigoa : Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmActualiza: TFrmActualiza;

implementation

uses FrmDatamodulo;

{$R *.dfm}

procedure TFrmActualiza.codigoExit(Sender: TObject);
begin
        with DataGeneral.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"inv$articulo"."cod_articulo",');
          SQL.Add('"inv$articulo"."nombre"');
          SQL.Add('FROM');
          SQL.Add('"inv$articulo"');
          SQL.Add('WHERE');
          SQL.Add('("inv$articulo"."cod_articulo" = :codigo)');
          ParamByName('codigo').AsString := codigo.Text;
          Open;
          titulo.Text := FieldByName('nombre').AsString;
          codigoa := FieldByName('cod_articulo').AsInteger;
          Close;
        end;
end;

procedure TFrmActualiza.JvImgBtn1Click(Sender: TObject);
begin
        with DataGeneral.IBsel1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update "inv$articulo"');
          SQL.Add('set "inv$articulo"."nombre" = :nombre');
          SQL.Add('where "inv$articulo"."cod_articulo" = :codigo');
          ParamByName('nombre').AsString := nuevo.Text;
          ParamByName('codigo').AsInteger := codigoa;
          Open;
          Close;
          Transaction.CommitRetaining;
        end;
        codigo.Text := '';
        nuevo.Text := '';
        titulo.Text := '';
        codigo.SetFocus;


end;

procedure TFrmActualiza.codigoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           nuevo.SetFocus;
end;

end.
