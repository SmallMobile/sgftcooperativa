unit UnitBarra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FR_Class, DB, ADODB, IBCustomDataSet, IBQuery, IBDatabase,
  FR_DSet, FR_DBSet, StdCtrls, JvEdit, JvTypedEdit, DBClient, ExtCtrls,
  Buttons;
                                     
type
  TForm1 = class(TForm)
    frReport1: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    CdCodigo: TClientDataSet;
    Panel1: TPanel;
    Label1: TLabel;
    jv1: TJvIntegerEdit;
    Label2: TLabel;
    jv2: TJvIntegerEdit;
    Label3: TLabel;
    cB: TComboBox;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    tipo: TCheckBox;
    frReport2: TfrReport;
    frReport3: TfrReport;
    CdCodigoCODIGO: TStringField;
    NA: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure frReport2GetValue(const ParName: String;
      var ParValue: Variant);
    procedure frReport3GetValue(const ParName: String;
      var ParValue: Variant);
  private
  vOficina :string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
var     i :Integer;
begin
        case cB.ItemIndex + 1 of
          1: vOficina := 'OCAÑA';
          2: vOficina := 'ABREGO';
          3: vOficina := 'CONVENCION';
          4: vOficina := 'AGUACHICA';
        else
          vOficina := 'No Aplica';
        end;
        CdCodigo.CancelUpdates;
        if NA.Checked then
        begin
          for i := jv1.Value to jv2.Value do
          begin
            CdCodigo.Append;
            CdCodigo.FieldValues['CODIGO'] := 'NA-0' + IntToStr(cB.ItemIndex + 1) + '-' + FormatCurr('0000',i);
            CdCodigo.Post;
          end;
        end
        else
        begin
          for i := jv1.Value to jv2.Value do
          begin
            CdCodigo.Append;
            CdCodigo.FieldValues['CODIGO'] := '0' + IntToStr(cB.ItemIndex + 1) + '-' + FormatCurr('00000',i);
            CdCodigo.Post;
          end;
        end;

        if NA.Checked then
           frReport3.ShowReport
        else if tipo.Checked then
           frReport1.ShowReport
        else
           frReport2.ShowReport
end;

procedure TForm1.frReport2GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'oficina' then
           ParValue := vOficina;
end;

procedure TForm1.frReport3GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'oficina' then
           ParValue := vOficina;

end;

end.
