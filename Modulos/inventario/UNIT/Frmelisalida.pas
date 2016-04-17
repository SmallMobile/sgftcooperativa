unit Frmelisalida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, StdCtrls, Buttons, Grids, DBGrids, ExtCtrls,
  IBQuery, IBDatabase;

type
  Teliminarsalida = class(TForm)
    Panel1: TPanel;
    nombre: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    nit: TLabel;
    entrada: TEdit;
    Panel2: TPanel;
    Label4: TLabel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    eliminar: TBitBtn;
    BitBtn2: TBitBtn;
    ibmante: TIBDataSet;
    DataSource1: TDataSource;
    IBdatos: TIBQuery;
    IBsel: TIBQuery;
    IBsel1: TIBQuery;
    ibmantecod_articulo: TIntegerField;
    ibmantenit_empleado: TIntegerField;
    ibmantecantidad: TSmallintField;
    ibmanteNOMBRE_AR: TIBStringField;
    ibmantenombre: TIBStringField;
    procedure entradaKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure eliminarClick(Sender: TObject);
  private
    { Private declarations }
  public
  published
    procedure actualizar;
    procedure eliminar_dato;
    { Public declarations }
  end;

var
  eliminarsalida: Teliminarsalida;
  numero_salida: integer;

implementation
uses frmdatamodulo;

{$R *.dfm}

procedure Teliminarsalida.entradaKeyPress(Sender: TObject; var Key: Char);
var fecha,fecha1,identificador: string;
begin
        if key = #13 then
        begin
          with IBdatos do
          begin
          Sql.Clear;
          Sql.Add('select "inv$salida"."fecha_entrega" as fecha from "inv$salida"');
          Sql.Add(' where "inv$salida"."no_salida"=:"salida"');
          parambyname('salida').AsString:=entrada.Text;
          open;
          fecha:=fieldbyname('fecha').AsString;
          fecha1:=datetostr(date);
          close;
          end;
            if fecha <> '' then
            begin
              if fecha1 <> fecha then
              begin
                Showmessage('No se puede Eliminar La Salida consulte al Administrador');
                entrada.SetFocus;
                eliminar.Enabled:=false;
               end
               else
               begin
               with DataGeneral.IBsel1 do
               begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select count(*)as i from "inv$salida"');
                 SQL.Add('where "inv$salida"."no_salida"=:"no_salida" and');
                 SQL.Add('"inv$salida"."cod_articulo" in');
                 SQL.Add('(select "inv$salida"."cod_articulo" from "inv$salida"');
                 SQL.Add(' where "inv$salida"."no_salida">:"no_salida")');
                 ParamByName('no_salida').AsInteger:=StrToInt(entrada.Text);
                 Open;
                 identificador:=FieldByName('i').AsString;
                 Close;
                 end;
                 if identificador='0' then
                 begin
                 eliminar.Enabled:=true;
                 ibmante.ParamByName('salida').AsInteger:=strtoint(entrada.Text);
                 ibmante.Open;
                 nit.Caption:=ibmantenit_empleado.Text;
                 nombre.Caption:=ibmantenombre.Text;
                 numero_salida:= strtoint(entrada.Text);
                 end
                 else
                 Showmessage('No se puede Eliminar La Salida consulte al Administrador');
                end;
            end;
        end;
        end;
procedure Teliminarsalida.BitBtn2Click(Sender: TObject);
begin
        close;
end;

procedure Teliminarsalida.actualizar;
var codigo_articulo,cantidad_articulo: integer;
begin
        with IBsel do
        begin
          close;
          Sql.Clear;
          Sql.Add('select "inv$salida"."cod_articulo" as codigo,');
          Sql.Add('"inv$salida"."cantidad_articulo" as cantidad');
          Sql.Add('from "inv$salida"' );
          Sql.Add('where "inv$salida"."no_salida"=:"salida"');
          parambyname('salida').AsString:=entrada.Text;
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


procedure Teliminarsalida.eliminarClick(Sender: TObject);
begin
        actualizar;
        eliminar_dato;
        ibmante.Close;
        nit.Caption:='';
        nombre.Caption:='';
        entrada.Text:='';
        entrada.SetFocus;

end;

procedure Teliminarsalida.eliminar_dato;
begin
        with ibsel1 do
        begin
          close;
          Sql.Clear;
          Sql.Add('delete from "inv$salida"');
          sql.Add('where "inv$salida"."no_salida"=:"no_salida"');
          parambyname('no_salida').AsInteger:=numero_salida;
          open;
          close;
          datageneral.ibtransaction1.CommitRetaining;
        end;

end;

end.
