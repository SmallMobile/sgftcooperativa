unit UnitActivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, DB, IBCustomDataSet, IBQuery;

type
  TFrmActivos = class(TForm)
    procedure vidaKeyPress(Sender: TObject; var Key: Char);
    procedure TabSheet2Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmActivos: TFrmActivos;

implementation
uses unitdatamodulo;


{$R *.dfm}

procedure TFrmActivos.vidaKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then

end;

procedure TFrmActivos.TabSheet2Enter(Sender: TObject);
begin

//prueba.SetFocus;

end;

end.
