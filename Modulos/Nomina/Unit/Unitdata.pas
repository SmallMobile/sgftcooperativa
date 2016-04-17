unit Unitdata;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase;

type
  Tfrmdata = class(TDataModule)
    IBTransaction2: TIBTransaction;
    IBDatabase2: TIBDatabase;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmdata: Tfrmdata;

implementation

{$R *.dfm}

end.
