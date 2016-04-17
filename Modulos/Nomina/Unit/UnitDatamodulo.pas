unit UnitDatamodulo;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBSQL, IBCustomDataSet, IBQuery;

type
  TDataGeneral = class(TDataModule)
    IBTransaction1: TIBTransaction;
    IBDatabase1: TIBDatabase;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataGeneral: TDataGeneral;

implementation


{$R *.dfm}

end.
