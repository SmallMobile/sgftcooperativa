unit FrmArticulo;

interface

uses
  Windows, Messages,FrmDataModulo,  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, ImgList, StdCtrls, Buttons, ComCtrls, ToolWin, ExtCtrls,
  DB, IBDatabase, IBCustomDataSet;

type
  TArticulo = class(TForm)
    panel: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    cod_barras: TEdit;
    cantidad: TEdit;
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    BCANCELAR: TBitBtn;
    Bcerrar: TBitBtn;
    df: TLabel;
    Label2: TLabel;
    clasificacion: TDBLookupComboBox;
    DataSource1: TDataSource;
    IBDataSet1: TIBDataSet;
    nombre: TMemo;
    cod_articulo: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    precio: TEdit;
    Label6: TLabel;
    Memo1: TMemo;
    Label7: TLabel;
    minimo: TEdit;
    procedure BcerrarClick(Sender: TObject);
    procedure cod_barrasKeyPress(Sender: TObject; var Key: Char);
    procedure nombreKeyPress(Sender: TObject; var Key: Char);
    procedure clasificacionKeyPress(Sender: TObject; var Key: Char);
    procedure cantidadKeyPress(Sender: TObject; var Key: Char);
    procedure BACEPTARClick(Sender: TObject);
    procedure BCANCELARClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure clasificacionExit(Sender: TObject);
    procedure nombreExit(Sender: TObject);
    procedure precioKeyPress(Sender: TObject; var Key: Char);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure Memo1Exit(Sender: TObject);
    procedure minimoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
  openarticulo: boolean;
    procedure numerico(Sender: TObject; var Key: Char);
  published
    procedure verclas;
    procedure entra_datos;
    procedure limpia;

    { Public declarations }
  end;

var
  Articulo: TArticulo;
  cod_clas: integer;


implementation

uses frmDependencia, frmentradadatos, FrmPrincipal;
{$R *.dfm}

procedure TArticulo.BcerrarClick(Sender: TObject);
begin
        close;
end;

procedure TArticulo.cod_barrasKeyPress(Sender: TObject; var Key: Char);
begin
        dependencia.NumericoSinPunto(self,key);
        if key = #13 then
          nombre.SetFocus;

end;

procedure TArticulo.nombreKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
          memo1.SetFocus;
end;

procedure TArticulo.clasificacionKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
          nombre.SetFocus;
end;

procedure TArticulo.cantidadKeyPress(Sender: TObject; var Key: Char);
begin
        dependencia.NumericoSinPunto(self,key);
        if key = #13 then
          precio.SetFocus;
end;

procedure TArticulo.verclas;
begin
        with datageneral.IBdatos do
        begin
          Sql.Clear;
          Sql.Add('select "inv$clasificacion"."cod_clasificacion" as codclas from "inv$clasificacion"');
          Sql.Add('where "inv$clasificacion"."nombre" like :"nombre"');
          ParamByname('nombre').AsString:=clasificacion.Text;
          open;
          cod_clas:=FieldByname('codclas').AsInteger;
          close;
        end;
end;

procedure TArticulo.BACEPTARClick(Sender: TObject);
var articulo1,cantidadar,nombrear:string;
begin
        articulo1:=cod_articulo.Caption;
        nombrear:=nombre.Text;
        cantidadar:=cantidad.Text;
        if clasificacion.Text = '' then
          ShowMessage('El Campo Clasificacion No Puede Ser Nulo')
          else if nombre.Text='' then
          begin
            ShowMessage('El Campo Nombre No Puede Ser Nulo');
            nombre.SetFocus;
          end
        else
        begin
          verclas;
          entra_datos;
          limpia;
            if openarticulo = true then
            begin
              entrada_articulo.IBentradacod_articulo.Text:=articulo1;
              entrada_articulo.IBentradacantidad.Text:=cantidadar;
              entrada_articulo.IBentradanombre.Text:=nombrear;
              entrada_articulo.Show;
              articulo.close;
            end;
        end;
        FrMain.entrada:=True;
end;

procedure TArticulo.entra_datos;
var existencia,barra:Integer;
begin
        if minimo.Text= '' then
        begin
          minimo.Text:='0';
        end;
          existencia:=0;
          if cod_barras.Text='' then
            barra:=0
          else
            barra:=strtoint(cod_barras.Text);
            With DataGeneral.IBsql Do
            begin
              Sql.Clear;
              Sql.Add('Insert Into "inv$articulo" (');
              Sql.Add('"inv$articulo"."cod_articulo","inv$articulo"."cod_barras",');
              Sql.Add('"inv$articulo"."nombre","inv$articulo"."cod_clasificacion",');
              Sql.Add('"inv$articulo"."existencia","inv$articulo"."precio_unitario","inv$articulo"."detalle","inv$articulo"."stock")');
              sql.Add('values(');
              Sql.Add(':"cod_articulo",:"cod_barras",:"nombre",:"cod_clasificacion",:"existencia",:"precio",:"detalle",:"stock")');
              ParamByname('cod_articulo').AsInteger:=strtoint(cod_articulo.Caption);
              ParamByname('cod_barras').AsInteger:=barra;
              ParamByname('nombre').AsString:=nombre.Text;
              ParamByname('cod_clasificacion').AsInteger:=cod_clas;
              ParamByname('existencia').AsInteger:=existencia;
              ParamByname('precio').AsCurrency:=0;
              ParamByname('detalle').AsString:=memo1.Text;
              ParamByName('stock').AsInteger:= StrToInt(minimo.Text);
              ExecQuery;
              close;
              DataGeneral.IBTransaction1.CommitRetaining;
            end;
end;

procedure TArticulo.limpia;
begin
        cod_articulo.Caption:='';
        cod_barras.Text:='';
        nombre.Text:='';
        cantidad.Text:='';
        cod_articulo.Caption:='';
        precio.Text:='';
        memo1.Text:='';
        minimo.Text:='';
        clasificacion.SetFocus;

end;

procedure TArticulo.BCANCELARClick(Sender: TObject);
begin
        limpia;
end;

procedure TArticulo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        if openarticulo = true then
        begin
          entrada_articulo.Show;
          articulo.close;
        end;


end;

procedure TArticulo.FormActivate(Sender: TObject);
begin
        ibdataset1.Active:=True;
        ibdataset1.Last;
        if openarticulo = true then
          Nombre.SetFocus;
end;

procedure TArticulo.numerico(Sender: TObject; var Key: Char);
begin
if not (Key in [#8,#13, '0'..'9', '-', DecimalSeparator]) then
  begin
    Key := #0;
  end //End First if.
  else
  if ((Key = DecimalSeparator) or (Key = '-')) and (Pos(Key, TMemo(Sender).Text ) > 0) then
  begin
    Key := #0;
  end//End second if.
  else
  if (Key = '-') and (TMemo(Sender).SelStart <> 0) then
  begin
    Key := #0;
  end;//End third if.
end;

procedure TArticulo.clasificacionExit(Sender: TObject);
Var     Contador: integer;
        codigo,cod_d,codigo_articulo: integer ;
begin
        With DataGeneral.IBdatos do
        Begin
          close;
          Sql.Clear;
          Sql.Add('Select "inv$clasificacion"."cod_clasificacion" as cod_dep');
          Sql.Add('From "inv$clasificacion"');
          sql.Add('where "inv$clasificacion"."nombre"=:"cod"');
          parambyname('cod').AsString:=clasificacion.Text;
          Open;
          cod_d:=FieldByName('cod_dep').AsInteger;
          Close;
        end;
        With DataGeneral.IBdatos do
        Begin
          SQL.Clear;
          SQL.Add('Select max("inv$articulo"."cod_articulo") as cod');
          SQL.Add('From "inv$articulo"');
          SQL.Add('where "inv$articulo"."cod_clasificacion"=:"codigo_cla"');
          ParamByName('codigo_cla').AsInteger:=cod_d;
          Open;
          Contador:=FieldByName('cod').AsInteger;
          Contador:=Contador+1;
          codigo:=Contador;
          Close;
        end;
        if Contador = 1 then
          codigo_articulo:=cod_d+codigo
        else
          codigo_articulo:=codigo;
        cod_articulo.Caption:=inttostr(codigo_articulo);
end;

procedure TArticulo.nombreExit(Sender: TObject);
begin
        nombre.Text:=UpperCase(nombre.Text);
end;

procedure TArticulo.precioKeyPress(Sender: TObject; var Key: Char);
begin
        numerico(self,key);
        if key =#13 then
          Baceptar.SetFocus;
end;

procedure TArticulo.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
          minimo.SetFocus;
end;

procedure TArticulo.Memo1Exit(Sender: TObject);
begin
        memo1.Text:=uppercase(memo1.Text);
end;

procedure TArticulo.minimoKeyPress(Sender: TObject; var Key: Char);
begin
        dependencia.NumericoSinPunto(self,key);
        if key = #13 then
          BACEPTAR.SetFocus;
end;

end.
