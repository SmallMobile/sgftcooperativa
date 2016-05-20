unit FRmmantenimiento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls,
  IBDatabase, IBSQL, IBQuery;

type
  TMantenimiento = class(TForm)
    DataSource1: TDataSource;
    ibmante: TIBDataSet;
    Panel1: TPanel;
    factura: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    entrada: TEdit;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    eliminar: TBitBtn;
    BitBtn2: TBitBtn;
    nit: TLabel;
    Label4: TLabel;
    IBdatos: TIBQuery;
    IBsel: TIBQuery;
    IBsel1: TIBQuery;
    ibmantecod_articulo: TIntegerField;
    ibmantenit_proveedor: TIBBCDField;
    ibmantecod_factura: TIntegerField;
    ibmantecantidad: TSmallintField;
    ibmantenombre: TIBStringField;
    ibmanteno_factura: TIBStringField;
    ibmantefecha_entrada: TDateField;
    Label5: TLabel;
    Label6: TLabel;
    procedure entradaKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure eliminarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
  published
    procedure actualizar;
    procedure eliminar_dato;
    { Public declarations }
  end;

var
  Mantenimiento: TMantenimiento;

  codigo_factura,numero_entrada: integer;

implementation
uses frmdatamodulo;
//var datageneral: tdatageneral;





{$R *.dfm}

procedure TMantenimiento.entradaKeyPress(Sender: TObject; var Key: Char);
var     fecha,no_salida: string;
        codigo: Integer;
begin
        if key = #13 then
        begin
          with IBdatos do
          begin
            SQL.Clear;
            SQL.Add('select "inv$entrada"."fecha_entrada" as fecha,');
            SQL.Add('"inv$entrada"."cod_articulo" as codigo from "inv$entrada"');
            SQL.Add(' where "inv$entrada"."no_entrada"=:"entrada"');
            ParamByName('entrada').AsString:=entrada.Text;
            open;
            fecha:=FieldByName('fecha').AsString;
            if fecha <> '' then
            begin
              while not IBdatos.Eof do
              begin
                codigo:= FieldByName('codigo').AsInteger;
                with IBsel do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('select "inv$salida"."no_salida" from "inv$salida"');
                  SQL.Add('where "inv$salida"."cod_articulo"=:"codigo_ar" and');
                  SQL.Add('"inv$salida"."fecha_entrega">=:"fecha_en"');
                  ParamByName('codigo_ar').AsInteger:=codigo;
                  ParamByName('fecha_en').AsString:=fecha;
                  Open;
                  no_salida := FieldByName('no_salida').AsString;
                  Close;
                end;
              IBdatos.Next;
               end;
              IBdatos.Close;
                 if no_salida <> '' then
                 begin
                   Showmessage('No se puede Eliminar La entrada consulte al Administrador');
                   entrada.SetFocus;
                   eliminar.Enabled:=false;
                 end
                 else begin
                   eliminar.Enabled:=true;
                   ibmante.ParamByName('entrada').AsInteger:=strtoint(entrada.Text);
                   ibmante.Open;
                   nit.Caption:=ibmantenit_proveedor.Text;
                   factura.Caption:=ibmanteno_factura.Text;
                   codigo_factura:= strtoint(ibmantecod_factura.Text);
                   numero_entrada:= strtoint(entrada.Text);
                   Label6.Caption:=ibmantefecha_entrada.Text;
                 end;
             end;
          end;
       end;
end;

procedure TMantenimiento.BitBtn2Click(Sender: TObject);
begin
        close;
end;

procedure TMantenimiento.actualizar;
var codigo_articulo,cantidad_articulo: integer;
begin
        with IBsel do
        begin
          close;
          Sql.Clear;
          Sql.Add('select "inv$entrada"."cod_articulo" as codigo,');
          Sql.Add('"inv$entrada"."cantidad_articulo" as cantidad');
          Sql.Add('from "inv$entrada"' );
          Sql.Add('where "inv$entrada"."no_entrada"=:"entrada"');
          parambyname('entrada').AsString:=entrada.Text;
          open;
          while  not IBsel.Eof do
          begin
            codigo_articulo:= fieldbyname('codigo').AsInteger;
            cantidad_articulo:= fieldbyname('cantidad').AsInteger;
            with IBsel1 do
            begin
              close;
              Sql.Clear;
              Sql.Add('update "inv$articulo"');
              Sql.Add('set "inv$articulo"."existencia"=:"nueva_can"');
              Sql.Add('where "inv$articulo"."cod_articulo"=:"cod_articulo"');
              parambyname('nueva_can').AsInteger:=cantidad_articulo;
              parambyname('cod_articulo').AsInteger:=codigo_articulo;
              open;
              close;
              datageneral.IBTransaction1.CommitRetaining;
            end;
          IBsel.Next;
          end;
        end;
        IBsel.Close;
end;

procedure TMantenimiento.eliminarClick(Sender: TObject);
begin
        actualizar;
        eliminar_dato;
        ibmante.Close;
        nit.Caption:='';
        factura.Caption:='';
        entrada.Text:='';
        eliminar.Enabled:=False;
end;

procedure TMantenimiento.eliminar_dato;
begin
        with ibsel1 do
        begin
          close;
          Sql.Clear;
          Sql.Add('delete from "inv$entrada"');
          sql.Add('where "inv$entrada"."no_entrada"=:"no_entrada"');
          parambyname('no_entrada').AsInteger:=numero_entrada;
          open;
          close;
          datageneral.ibtransaction1.CommitRetaining;
        end;
          with ibsel do
          begin
            close;
            Sql.Clear;
            Sql.Add('delete from "inv$datos_factura"');
            sql.Add('where "inv$datos_factura"."cod_factura"=:"cod_factura"');
            parambyname('cod_factura').AsInteger:=codigo_factura;
            open;
            close;
            datageneral.ibtransaction1.CommitRetaining;
          end;
end;

procedure TMantenimiento.FormActivate(Sender: TObject);
begin
  {      datageneral:=tdatageneral.Create(self);
        datageneral.IBDatabase1.Connected:=true;
        datageneral.IBTransaction1.Active:=true}
end;

end.
