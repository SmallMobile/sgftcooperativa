unit UnitdataQuerys;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, IBQuery, IBSQL;

type
  TFrmQuerys = class(TDataModule)
    IBseleccion: TIBQuery;
    IBregistro: TIBQuery;
    IBTranseleccion: TIBTransaction;
    IBTranregistro: TIBTransaction;
    IBSQL1: TIBSQL;
    IBTIBsql: TIBTransaction;
    IBfianzas: TIBQuery;
    IBTransaction1: TIBTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQuerys: TFrmQuerys;

implementation
uses unitdata,unitdatamodulo;

{$R *.dfm}

end.
