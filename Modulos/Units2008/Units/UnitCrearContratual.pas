unit UnitCrearContratual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Grids, DBGrids, UnitTConexion,UnitTContractual;

type
  TFrmCrearContractual = class(TForm)
    DsContractual: TDataSource;
    CdContractual: TClientDataSet;
    CdContractualID_PLAN: TIntegerField;
    CdContractualDESCRIPCION: TStringField;
    CdContractualPLAZO: TIntegerField;
    CdContractualACTIVO: TBooleanField;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    CdContractualPORCENTAJE: TFloatField;
    procedure FormCreate(Sender: TObject);
  private
  _tConexion :TConexion;
  _tContractual :TContractual;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCrearContractual: TFrmCrearContractual;

implementation
uses UnitGlobal;

{$R *.dfm}

procedure TFrmCrearContractual.FormCreate(Sender: TObject);
begin
  _tConexion := TConexion.Create;
  _tConexion.Conectar;
  _tContractual := TContractual.Create;
  _tContractual.IBDatabase1 := _tConexion.Database;
  _tContractual.SelectContractual(CdContractual);
end;

end.
