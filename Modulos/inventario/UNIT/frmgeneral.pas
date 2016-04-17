unit frmgeneral;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, Messages,dialogs;

type
  Tdataentrada = class(TDataModule)
    ibagencia: TIBDataSet;
    DataSource1: TDataSource;
    IBsalida: TIBDataSet;
    IBsalidacod_articulo: TIntegerField;
    IBsalidanit_empleado: TIntegerField;
    IBsalidano_salida: TIntegerField;
    IBsalidafecha_entrega: TDateField;
    IBsalidacod_barras: TIntegerField;
    IBsalidanombre: TIBStringField;
    IBsalidacantidad: TSmallintField;
    IBsalidacod_agencia: TSmallintField;
    IBsalidadefinicion: TIBStringField;
    IBsalidacantidad_articulo: TSmallintField;
    IBsalidaprecio_salida: TIBBCDField;
    IBsalidacod_dependencia: TIntegerField;
    IBDataSet1: TIBDataSet;
    dataagen: TDataSource;
    IBDataSet3: TIBDataSet;
    IBDataSet3cod_articulo: TIntegerField;
    IBDataSet3cod_barras: TIntegerField;
    IBDataSet3nombre: TIBStringField;
    IBDataSet3existencia: TFloatField;
    IBDataSet3cod_clasificacion: TIntegerField;
    IBentrada: TIBDataSet;
    IBentradacantidad: TSmallintField;
    IBentradacod_articulo: TIntegerField;
    IBentradacod_factura: TIntegerField;
    IBentradafecha_entrada: TDateField;
    IBentradano_entrada: TIntegerField;
    IBentradaprecio_unidad: TIBBCDField;
    IBentradacod_barras: TIntegerField;
    IBentradanombre: TIBStringField;
    IBentradacantidad_articulo: TSmallintField;
    IBentradaprecio_unitario: TIBBCDField;
    IBentradanit_proveedor: TIBBCDField;
    DataSource2: TDataSource;
    procedure IBsalidacod_articuloValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dataentrada: Tdataentrada;

implementation

uses FrmSalida;

{$R *.dfm}

procedure Tdataentrada.IBsalidacod_articuloValidate(Sender: TField);
var    precio,coddar,narticulo:string;
       stock,existencia:string;
begin

        if Salida.remp.Checked = true then
          Salida.tipo:= 'E'
        else
          Salida.tipo:='S';
        with Salida.IBdatos do
        Begin
          close;
          Sql.Clear;
          Sql.Add('select "inv$articulo"."cod_articulo" as codigo, "inv$articulo"."nombre" as des, "inv$articulo"."existencia" as existencia,');
          Sql.Add('"inv$articulo"."precio_unitario" as precio,');
          SQL.Add('"inv$articulo"."stock" as stock,"inv$articulo"."existencia" as stock');
          SQL.Add('from "inv$articulo"');
          Sql.Add('where "inv$articulo"."cod_articulo"= :"cod_articulo"');
          ParamByname('cod_articulo').AsInteger := StrtoInt(IBsalidacod_articulo.Text);
          open;
          coddar:=FieldByname('codigo').AsString;
          stock:= FieldByname('stock').AsString;
          existencia:=FieldByname('existencia').AsString;
            if coddar='' then
            begin
              Showmessage('el Articulo no se Encuentra');
            end
            else
            begin
              if (stock <> '') or (stock <> '0') then
              begin
                if StrToInt(existencia) <= StrToInt(stock) then
                   Showmessage('el Articulo se Encuentra en su Stock Minimo');
              end;
                narticulo:= FieldByname('des').AsString;
                Salida.existencia_articulo:= strtoint(fieldbyname('existencia').AsString);
                precio:= fieldbyname('precio').AsString;
                Ibsalidanombre.text :=narticulo;
                close;
            end;
        end;
        IBsalidano_salida.Text:=Salida.no_salida.Caption;
        IBsalidafecha_entrega.Text:=datetostr(Salida.fecha_salida.DateTime);
        Ibsalidanit_empleado.text:=Salida.nit_empleado.text;
        IBsalidacod_agencia.Text:=IntToStr(Salida.codigo_agencia);
        IBsalidadefinicion.Text:=Salida.tipo;
        ibsalidacod_barras.Text:='0';
        ibsalidacantidad_articulo.Text:=inttostr(Salida.existencia_articulo);
        ibsalidaprecio_salida.Text:= precio;
        Ibsalidacod_dependencia.Text:=inttostr(Salida.codigo_dependencia);
        Salida.bcerrar.Enabled:=True;
        end;

end.
