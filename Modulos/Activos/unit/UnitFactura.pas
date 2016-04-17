unit UnitFactura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, Grids, DBGrids, StdCtrls, Buttons;

type
  TFrmFacturas = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    nit: TEdit;
    Proveedor: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    nombre_p: TMemo;
    Label4: TLabel;
    procedure nitExit(Sender: TObject);
  private
    { Private declarations }


  public
    { Public declarations }
  end;




implementation

uses UnitDatamodulo;

{$R *.dfm}

procedure TFrmFacturas.nitExit(Sender: TObject);
begin
        with DataGeneral.IBdatos do
        begin
          Close;
          SQL.Add('select "inv$proveedor"."nombre","inv$proveedor"."telefono"');
          SQL.Add('from "inv$proveedor"');
          SQL.Add('where "inv$proveedor"."nit_proveedor"=:"nit"');
          ParamByName('nit').AsString:=nit.Text;
          Open;
          Label4.Caption:=FieldByName('telefono').AsString;
          nombre_p.Text:=FieldByName('nombre').AsString;
          Close;
        end;


end;

end.
