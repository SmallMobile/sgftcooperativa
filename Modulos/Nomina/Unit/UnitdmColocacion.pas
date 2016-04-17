unit UnitdmColocacion;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBSQL, IBDatabase;

type
  TdmColocacion = class(TDataModule)
    IBQuery: TIBQuery;
    IBQuery1: TIBQuery;
    IBQueryVarios: TIBQuery;
    IBDScontable: TIBDataSet;
    IBTransaction1: TIBTransaction;
    IBTransaction2: TIBTransaction;
    IBTransaction3: TIBTransaction;
    IBTransaction4: TIBTransaction;
    IBTransaction5: TIBTransaction;
    IBTransaction6: TIBTransaction;
    IBSQL: TIBSQL;
    IBSQLcodigos: TIBSQL;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmColocacion: TdmColocacion;

implementation
uses unitdata;
{$R *.dfm}




end.
