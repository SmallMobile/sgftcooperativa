unit UnitReclasifica;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JvStaticText, DBCtrls, DB, Buttons,
  IBCustomDataSet, IBQuery;

type
  TFrmReclasificacion = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    EdCodigo: TEdit;
    Label2: TLabel;
    JvDescripcion: TJvStaticText;
    Panel2: TPanel;
    Label3: TLabel;
    DataSource1: TDataSource;
    DBclasificacion: TDBLookupComboBox;
    Label4: TLabel;
    JvClasificacion: TJvStaticText;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel4: TPanel;
    IBQuery1: TIBQuery;
    IBQuery2: TIBQuery;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EdCodigoExit(Sender: TObject);
    procedure EdCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure DBclasificacionKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  CodArticulo :Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReclasificacion: TFrmReclasificacion;

implementation

{$R *.dfm}

procedure TFrmReclasificacion.BitBtn3Click(Sender: TObject);
begin
        Close
end;

procedure TFrmReclasificacion.BitBtn2Click(Sender: TObject);
begin
        EdCodigo.Text := '';
        JvDescripcion.Caption := '';
        JvClasificacion.Caption := '';
        DBclasificacion.KeyValue := -1;
        EdCodigo.SetFocus;
end;

procedure TFrmReclasificacion.EdCodigoExit(Sender: TObject);

begin
        with IBQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"inv$clasificacion"."nombre" as clasificacion,');
          SQL.Add('"inv$clasificacion"."cod_clasificacion",');
          SQL.Add('"inv$articulo"."nombre",');
          SQL.Add('"inv$articulo"."cod_articulo"');
          SQL.Add('FROM');
          SQL.Add('"inv$clasificacion",');
          SQL.Add('"inv$articulo"');
          SQL.Add('WHERE');
          SQL.Add('("inv$clasificacion"."cod_clasificacion" = "inv$articulo"."cod_clasificacion") AND ');
          SQL.Add('("inv$articulo"."cod_articulo" = :CODIGO)');
          ParamByName('CODIGO').AsInteger := StrToInt(EdCodigo.Text);
          Open;
          if RecordCount < 0 then
          begin
            MessageDlg('Articulo no Existe...',mtInformation,[mbok],0);
            Exit;
          end;
          JvDescripcion.Caption := FieldByName('nombre').AsString;
          JvClasificacion.Caption := FieldByName('clasificacion').AsString;
          CodArticulo := FieldByName('cod_articulo').AsInteger;
          DBclasificacion.KeyValue := FieldByName('cod_clasificacion').AsInteger;
        end;
end;

procedure TFrmReclasificacion.EdCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          DBclasificacion.SetFocus;
end;

procedure TFrmReclasificacion.DBclasificacionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          BitBtn1.SetFocus
end;

procedure TFrmReclasificacion.BitBtn1Click(Sender: TObject);
begin
        if MessageDlg('Seguro de Realizar la Operación?',mtInformation,[mbyes,mbno],0) = mrno then
           Exit;
        with IBQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update "inv$articulo" set "inv$articulo"."cod_clasificacion" = :CODIGO where "inv$articulo"."cod_articulo" = :CODARTICULO');
          ParamByName('CODIGO').AsInteger := DBclasificacion.KeyValue;
          ParamByName('CODARTICULO').AsInteger := CodArticulo;
          ExecSQL;
          Transaction.CommitRetaining;
          BitBtn2.Click;
        end;
end;

procedure TFrmReclasificacion.FormCreate(Sender: TObject);
begin
        IBQuery1.Close;
        IBQuery1.Open;
        IBQuery1.Last;
end;

end.
