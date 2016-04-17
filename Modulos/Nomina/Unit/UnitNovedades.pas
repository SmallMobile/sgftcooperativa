unit UnitNovedades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, IBDatabase, DB,
  IBCustomDataSet;

type
  TFrmActualizar = class(TForm)
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    Bnomina: TBitBtn;
    Bcerrar: TBitBtn;
    DBGrid1: TDBGrid;
    DSActualiza: TDataSource;
    IBActualiza: TIBDataSet;
    IBTransaction1: TIBTransaction;
    IBActualizacodigo: TSmallintField;
    IBActualizadescripcion: TIBStringField;
    IBActualizavalor: TIBBCDField;
    procedure FormCreate(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure BnominaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmActualizar: TFrmActualizar;

implementation
uses unitdatamodulo,unitglobal;

{$R *.dfm}

procedure TFrmActualizar.FormCreate(Sender: TObject);
begin
        IBActualiza.Open;
end;

procedure TFrmActualizar.BACEPTARClick(Sender: TObject);
begin
        //IBActualiza.Open;
//        IBActualiza.Transaction.StartTransaction;
        IBActualiza.ApplyUpdates;
        with IBActualiza do
        begin
          Transaction.Commit;
          Transaction.StartTransaction;
        end;
        BACEPTAR.Enabled := False;
        Bnomina.Enabled := True;
end;

procedure TFrmActualizar.BcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmActualizar.BnominaClick(Sender: TObject);
begin
        IBActualiza.Open;
        Bnomina.Enabled := False;
        BACEPTAR.Enabled := True;
end;

end.
