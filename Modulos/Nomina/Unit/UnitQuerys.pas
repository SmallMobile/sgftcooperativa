unit UnitQuerys;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase;

type
  TDataQuerys = class(TDataModule)
    IBdatos: TIBQuery;
    IBselecion: TIBQuery;
    IBingresa: TIBQuery;
    IBTrandatos: TIBTransaction;
    IBTranselecion: TIBTransaction;
    IBTraningresa: TIBTransaction;
    IBaportes: TIBQuery;
    IBtranaportes: TIBTransaction;
    IBQuery1: TIBQuery;
    IBTransaction1: TIBTransaction;
    IBTransaction2: TIBTransaction;
    IBdata: TIBQuery;
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
