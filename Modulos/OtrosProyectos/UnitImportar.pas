unit UnitImportar;

interface

uses
  Windows, Messages, StrUtils, Controls, StdCtrls, FIBQuery, pFIBQuery,
  FIBDatabase, pFIBDatabase, Buttons, Mask, JvToolEdit, SysUtils, Variants, Classes, Graphics, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    JvFilenameEdit1: TJvFilenameEdit;
    BitBtn1: TBitBtn;
    pFIBDatabase1: TpFIBDatabase;
    pFIBTransaction1: TpFIBTransaction;
    pFIBQuery1: TpFIBQuery;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  S1:TStringList;
  S2:TStringList;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
        pFIBDatabase1.Connected := True;
        pFIBTransaction1.Active := True;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var Archivo:string;
    i,j:Integer;
begin
       Archivo := JvFilenameEdit1.FileName;
       S1 := TStringList.Create;
       S2 := TStringList.Create;
       S1.LoadFromFile(archivo);
       for i := 1 to S1.Count - 1 do begin
         S2.Text := stringreplace(S1.Strings[i],#9,#13,[rfReplaceAll]);
         Label1.Caption := LeftStr(S1.Strings[i],30);
         Application.ProcessMessages;
         with pFIBQuery1 do begin
           Close;
           SQL.Clear;
           SQL.Add('insert into "cap$extracto" values (');
           SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
           SQL.Add(':FECHA_MOVIMIENTO,:HORA_MOVIMIENTO,:ID_TIPO_MOVIMIENTO,:DOCUMENTO_MOVIMIENTO,');
           SQL.Add(':DESCRIPCION_MOVIMIENTO,:VALOR_DEBITO,:VALOR_CREDITO)');
           ParamByName('ID_AGENCIA').AsInteger := StrToInt(S2.Strings[0]);
           ParamByName('ID_TIPO_CAPTACION').AsInteger := StrToInt(S2.Strings[1]);
           ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(S2.Strings[2]);
           ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(S2.Strings[3]);
           ParamByName('FECHA_MOVIMIENTO').AsDate := StrToDate(S2.Strings[4]);
           ParamByName('HORA_MOVIMIENTO').AsTime  := StrToTime(S2.Strings[5]);
           ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := StrToInt(S2.Strings[6]);
           ParamByName('DOCUMENTO_MOVIMIENTO').AsString := S2.Strings[7];
           ParamByName('DESCRIPCION_MOVIMIENTO').AsString := S2.Strings[8];
           ParamByName('VALOR_DEBITO').AsCurrency := StrToCurr(S2.Strings[9]);
           ParamByName('VALOR_CREDITO').AsCurrency := StrToCurr(S2.Strings[10]);
           try
            ExecQuery;
           except
            raise;
           end;
         end;

       end;
       pFIBTransaction1.Commit;
       ShowMessage('Proceso Finalizado');
end;

end.
