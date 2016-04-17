unit UnitActualizaPension;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IBDatabase, DB, IBCustomDataSet,
  Grids, DBGrids;

type
  TFrmActualizaPension = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BACEPTAR: TBitBtn;
    Bnomina: TBitBtn;
    Bcerrar: TBitBtn;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    IBactualiza: TIBDataSet;
    IBTransaction1: TIBTransaction;
    procedure BACEPTARClick(Sender: TObject);
    procedure BnominaClick(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmActualizaPension: TFrmActualizaPension;

implementation

{$R *.dfm}

procedure TFrmActualizaPension.BACEPTARClick(Sender: TObject);
begin
        IBActualiza.ApplyUpdates;
        with IBActualiza do
        begin
          Transaction.Commit;
          Transaction.StartTransaction;
        end;
        BACEPTAR.Enabled := False;
        Bnomina.Enabled := True;
end;

procedure TFrmActualizaPension.BnominaClick(Sender: TObject);
begin
        IBActualiza.Open;
        Bnomina.Enabled := False;
        BACEPTAR.Enabled := True;
end;

procedure TFrmActualizaPension.BcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmActualizaPension.FormCreate(Sender: TObject);
begin
        IBActualiza.Open;
end;

end.
