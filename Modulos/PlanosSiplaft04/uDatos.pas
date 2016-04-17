unit uDatos;

interface

uses
  SysUtils, Classes, WideStrings, DBXInterbase, FMTBcd, DB, SqlExpr, Provider,
  DBClient, IBCustomDataSet, IBQuery, IBDatabase;

type
  TDataModule4 = class(TDataModule)
    _cdsSelect: TClientDataSet;
    _dspSelect: TDataSetProvider;
    _ibdb: TIBDatabase;
    _qrSelect: TIBQuery;
    _ibt: TIBTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule4: TDataModule4;

implementation

{$R *.dfm}

end.
