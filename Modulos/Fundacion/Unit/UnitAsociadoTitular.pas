unit UnitAsociadoTitular;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JvEdit, JvLabel, DBCtrls, DB,
  IBCustomDataSet, IBQuery, JvDice, JvStaticText;

type
  TFrmAsociadoTitular = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    JvEdit1: TJvEdit;
    JvLabel1: TJvLabel;
    Label3: TLabel;
    DBOficina: TDBLookupComboBox;
    DataSource1: TDataSource;
    IBQuery1: TIBQuery;
    Label2: TLabel;
    LBnombres: TJvStaticText;
    procedure FormCreate(Sender: TObject);
    procedure JvEdit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAsociadoTitular: TFrmAsociadoTitular;

implementation

{$R *.dfm}

procedure TFrmAsociadoTitular.FormCreate(Sender: TObject);
begin
        IBQuery1.Open;
        IBQuery1.Last;
end;

procedure TFrmAsociadoTitular.JvEdit1Exit(Sender: TObject);
begin
        if DBOficina.KeyValue <> 1 then
        begin
                  
        end
        else
        begin

        end;
end;


end.
