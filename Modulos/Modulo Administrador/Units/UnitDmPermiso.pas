unit UnitDmPermiso;

interface

uses
  SysUtils, Classes, IBDatabase, DB;

type
  TDmPermiso = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmPermiso: TDmPermiso;

implementation

{$R *.dfm}

end.
