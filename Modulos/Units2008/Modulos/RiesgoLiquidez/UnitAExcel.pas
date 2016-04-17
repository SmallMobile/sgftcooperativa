unit UnitAExcel;

interface

uses
  DateUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, BaseGrid, AdvGrid, ProfGrid, ComCtrls, ExtCtrls,
  Buttons, JvExStdCtrls, JvEdit, JvValidateEdit;

type
  TfrmAExcel = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    PageControl1: TPageControl;
    edYear: TJvValidateEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAExcel: TfrmAExcel;

implementation

{$R *.dfm}

procedure TfrmAExcel.BitBtn3Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmAExcel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmAExcel.FormCreate(Sender: TObject);
begin
  edYear.Value := YearOf(Date);
end;

end.
