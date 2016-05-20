unit UnitClase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, DB, IBDatabase, IBCustomDataSet,
  IBQuery, Buttons;

type
  TFrmClase = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DBclase: TDBLookupComboBox;
    IBclase: TIBQuery;
    IBTransaction1: TIBTransaction;
    IBTransaction2: TIBTransaction;
    DSclase: TDataSource;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    IbOficina: TIBQuery;
    DsOficina: TDataSource;
    DBoficina: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmClase: TFrmClase;

implementation

uses UnitActivorep, UnitPrincipal;

{$R *.dfm}

procedure TFrmClase.FormCreate(Sender: TObject);
begin
        IBclase.Open;
        IBclase.Last;
        IbOficina.Open;
        IbOficina.Last;
end;

procedure TFrmClase.BitBtn1Click(Sender: TObject);
begin
        FrmActivos := TFrmActivos.Create(self);
        FrmActivos.clase(DBclase.KeyValue,DBoficina.KeyValue,DBclase.Text,DBoficina.Text);
end;

end.
