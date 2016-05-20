unit UnitMain;

interface

uses
  StrUtils, DateUtils, SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  IdUDPServer,IdSocketHandle, HexConvert, UnitDES;

type
  TForm1 = class(TForm)
    UDPClient: TIdUDPClient;
    Memo1: TMemo;
    Button2: TButton;
    lb1: TListBox;
    Button3: TButton;
    Button4: TButton;
    Button1: TButton;
    procedure FormClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
   TXMLHead=Record
     szHead:array[0..2] of Char;
     nSize :array[0..3] of Byte;
     nCrc  :array[0..3] of Byte;
     vbKey :array[0..7] of Byte;
end;


var
  Form1: TForm1;
  Ciclo:Boolean;
  
implementation

{$R *.xfm}


procedure TForm1.FormClick(Sender: TObject);
begin
        Ciclo := False;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  EncaXMLRet:TXMLHead;
  Size,Longitud:Integer;
  KeyString,DataString,ResCadena:string;
  i,j,Bloques:Integer;
  KeyRet:string[16];
  Error:Integer;
  LongData:integer;
  Pint:^Integer;
  PByte:^Byte;
  Hex:string;
  Ciclo:Integer;
//  Buffer:Pointer;
  Buffer:array[0..1042] of Byte;
begin

   KeyRet := '0123456789ABCDEF';
   for Ciclo := 0 to lb1.Items.Count - 1 do
   begin
    lb1.Selected[Ciclo] := True;
    DataString := TextToHex(lb1.Items[Ciclo]);//,Length(XMLString));
    if (Length(DataString) mod 16 <> 0) then
    begin
         j := 16 - (Length(DataString) mod 16);
         for i := 1 to j do
          DataString := DataString + '0';
    end;

    DataString := DESCipher(DataString,KeyRet,True);
    KeyString  := DESCipher(KeyRet,'0123456789ABCDEF',True);

    EncaXMLRet.szHead := 'XML';
    Pint := Addr(EncaXMLRet.nSize);
    Pint^:= Length(DataString) div 2;
    Pint := Addr(EncaXMLRet.nCrc);
    Pint^:= 0;

    for i := 0 to 7 do
     EncaXMLRet.vbKey[i] := StrToInt('$'+MidStr(KeyString,i*2+1,2));

    PByte := @EncaXMLRet;
    for i := 0 to 18 do
    begin
      Buffer[i] := PByte^;
      Inc(PByte);
    end;

    j := (Length(DataString) div 2)-1;

    for i := 0 to j do
    begin
     Hex := MidStr(DataString,i*2+1,2);
     Buffer[19+i] := StrToInt('$'+Hex);
    end;

    i := i + 19;

// Enviar Petición
    UDPClient.SendBuffer(Buffer,i);
    Application.ProcessMessages;
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
        if Memo1.Text <> '' then
           lb1.Items.Add(Memo1.Text);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
        Close;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
        lb1.Items.Delete(lb1.ItemIndex);
end;

end.
