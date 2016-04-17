unit UnitVerificaIni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TFrmVerificaIni = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Mactual: TMemo;
    Label2: TLabel;
    mEnc: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
  vTexto :TStringList;
  vTexto1 :TStringList;
   cadena :WideString;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVerificaIni: TFrmVerificaIni;

implementation

uses UnitGlobal;

{$R *.dfm}

procedure TFrmVerificaIni.FormCreate(Sender: TObject);
var     i,j :Integer;

begin
        vTexto := TStringList.Create;
        vtexto1 := TStringList.Create;
        Self.Caption := 'Cambios Sobre el Archivo :' + AIni;
        Mactual.Lines.LoadFromFile(aini);
        vTexto.Text := Mactual.Text;
        for i := 0 to vTexto.Count - 1 do
        begin
            cadena := vTexto.Strings[i];
            if not(validar(cadena)) then
            begin
               vtexto1.Text := StringReplace(cadena,'=',#13,[rfreplaceall]);
               for j := 0 to vtexto1.Count -1 do
               begin
                 if j = 0 then
                   cadena := vTexto1.Strings[0] + '='
                 else
                   cadena := cadena + Decrypt(vtexto1.Strings[j],6474)
               end;
               mEnc.Lines.Add(cadena)
            end
            else
               mEnc.Lines.Add(cadena)
        end;
        vTexto.Free;
        vtexto1.Free
end;

procedure TFrmVerificaIni.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmVerificaIni.BitBtn1Click(Sender: TObject);
var     i,j :Integer;

begin
        Mactual.Lines.Clear;
        vTexto := TStringList.Create;
        vtexto1 := TStringList.Create;
        Self.Caption := 'Cambios Sobre el Archivo :' + AIni;
        vTexto.Text := mEnc.Text;
        for i := 0 to vTexto.Count - 1 do
        begin
            cadena := vTexto.Strings[i];
            if not(validar(cadena)) then
            begin
               vtexto1.Text := StringReplace(cadena,'=',#13,[rfreplaceall]);
               for j := 0 to vtexto1.Count -1 do
               begin
                 if j = 0 then
                   cadena := vTexto1.Strings[0] + '='
                 else
                   cadena := cadena + encrypt(vtexto1.Strings[j],6474)
               end;
               Mactual.Lines.Add(cadena)
            end
            else
               Mactual.Lines.Add(cadena);
        end;
        vTexto.Free;
        vtexto1.Free
end;

end.
