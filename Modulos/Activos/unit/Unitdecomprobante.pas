unit Unitdecomprobante;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery;

type
  Tdmcomprobante = class(TDataModule)
    DataComprobante: TIBDataSet;
    Dsagencia: TDataSource;
    Dstipocom: TDataSource;
    IBQuery1: TIBQuery;
    buscacodigo: TIBQuery;
    IBQuery2: TIBQuery;
    ibbuscada: TIBQuery;
    tipocomprobante: TIBQuery;
    Ibdatos1: TIBQuery;
    dataagencia: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmcomprobante: Tdmcomprobante;

implementation
uses unitdatamodulo,unitdata;
{$R *.dfm}

end.
