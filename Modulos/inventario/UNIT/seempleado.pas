unit seempleado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBDatabase, Grids, DBGrids, IBCustomDataSet, StdCtrls,
  Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    nit: TEdit;
    eje: TBitBtn;
    DataSource1: TDataSource;
    IBDataSet1: TIBDataSet;
    DBGrid1: TDBGrid;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBDataSet1cod_articulo: TIntegerField;
    IBDataSet1nit_empleado: TIntegerField;
    IBDataSet1no_salida: TIntegerField;
    IBDataSet1fecha_entrega: TDateField;
    IBDataSet1cantidad: TSmallintField;
    IBDataSet1cod_agencia: TSmallintField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
