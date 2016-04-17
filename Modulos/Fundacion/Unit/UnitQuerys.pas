unit UnitQuerys;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase, IBSQL;

type
  TDataQuerys = class(TDataModule)
    IBdatos: TIBQuery;
    IBselecion: TIBQuery;
    IBingresa: TIBQuery;
    IBTrandatos: TIBTransaction;
    IBTranselecion: TIBTransaction;
    IBTraningresa: TIBTransaction;
    IBFundacion: TIBQuery;
    IBtranFundacion: TIBTransaction;
    IBSQL1: TIBSQL;
    IBSQL2: TIBSQL;
    IBTransaction1: TIBTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataQuerys: TDataQuerys;

implementation
uses unitdatamodulo;
{$R *.dfm}

end.
