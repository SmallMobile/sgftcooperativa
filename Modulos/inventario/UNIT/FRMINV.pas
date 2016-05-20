unit FRMINV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBCustomDataSet, Grids, DBGrids, IBDatabase,
  IBQuery, FR_DSet, FR_DBSet, FR_Class, IBTable, ExtCtrls, FR_View;

type
  Tinventa = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    frReport1: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    IBQuery1: TIBQuery;
    IBTable1: TIBTable;
    frCompositeReport1: TfrCompositeReport;
    nombre: TEdit;
    IBdatos: TIBQuery;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure reporte_articulo;
  published
    procedure imprimir_reporte(cadena: string);
    { Public declarations }
  end;

var
  inventa: Tinventa;
  var lugar: string;

implementation
uses reporte,frmdatamodulo;

{$R *.dfm}

procedure Tinventa.Button2Click(Sender: TObject);

begin
        reporte_articulo;
end;

procedure Tinventa.Button3Click(Sender: TObject);
begin
ibdatos.ParamByName('nit').AsInteger:=strtoint(nombre.Text);
ibdatos.Open;
end;

procedure Tinventa.imprimir_reporte(cadena: string);
var Report: TfrReport;
begin

        Report := frCompositeReport1;
        frreport1.LoadFromFile(cadena);
        frCompositeReport1.DoublePass := True;
        frCompositeReport1.Reports.Clear;
        frCompositeReport1.Reports.Add(frReport1);
        frreport1.Preview:=ipresion.frPreview1;
        frreport1.ShowReport;
        ipresion.ShowModal

end;
procedure Tinventa.reporte_articulo;
begin
        lugar:='C:\INVENTARIO\reportes\reportearticulo.frf';
        frDBDataSet1.DataSet:=ibquery1;
        //ibquery1.ParamByName('codigo').AsInteger:=strtoint(nombre.Text);
        ibquery1.Open;
        imprimir_reporte(lugar);
end;

end.
