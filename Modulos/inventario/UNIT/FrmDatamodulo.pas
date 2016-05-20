unit FRMDATAMODULO;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBSQL, IBCustomDataSet, IBQuery;

type
  TDataGeneral = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBsql: TIBSQL;
    IBdatos: TIBQuery;
    IBsel: TIBQuery;
    IBsel1: TIBQuery;
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
