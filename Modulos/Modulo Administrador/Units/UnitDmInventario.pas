unit UnitDmInventario;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase;

type
  TDmInventario = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmInventario: TDmInventario;

implementation

{$R *.dfm}

end.
