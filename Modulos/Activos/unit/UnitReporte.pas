unit UnitReporte;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBSQL;

type
  TFrmReporte = class(TDataModule)
    Activosporseccion: TIBQuery;
    empresa: TIBQuery;
    Elementos: TIBQuery;
    polizas: TIBQuery;
    IBactivodepreciado: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReporte: TFrmReporte;

implementation
uses unitdatamodulo;

{$R *.dfm}

end.
