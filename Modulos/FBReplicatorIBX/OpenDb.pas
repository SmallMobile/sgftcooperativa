unit OpenDb;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Dialogs, IniFiles;

const
  DEFAULT_PATH='server:[drive]\path';
  
type
  TOpenDBDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Button1: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    DBPath: string[200];
    UserName: string[50];
    Password: string[50];
  end;

var
  OpenDBDlg: TOpenDBDlg;
  IniFile: TIniFile;

implementation

{$R *.DFM}

procedure TOpenDBDlg.Button1Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  ComboBox1.Text := OpenDialog1.FileName;
end;

procedure TOpenDBDlg.CancelBtnClick(Sender: TObject);
begin
  DBPath := '';
  UserName := '';
  Password := '';
end;

procedure TOpenDBDlg.OKBtnClick(Sender: TObject);
begin
  if( CompareText(ComboBox1.Text, DEFAULT_PATH) <> 0 ) then
  begin
    DBPath := ComboBox1.Text;
    UserName := Edit1.Text;
    Password := Edit2.Text;
  end;
end;

procedure TOpenDBDlg.FormShow(Sender: TObject);
var
  Idents: TStringList;
  Path: string;
  i: Integer;
begin
  Idents := TStringList.Create;
  ComboBox1.Items.Clear;
  Edit1.Text := '';
  Edit2.Text := '';

  IniFile := TIniFile.Create('REPL.INI');

  IniFile.ReadSection('Paths', Idents );

  for i := 0 to Idents.Count - 1 do
  begin
    ComboBox1.Items.Add(IniFile.ReadString('Paths', Idents[i], ''));
  end;
end;

procedure TOpenDBDlg.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
  New: Boolean;
begin
  New := True;
  for i := 0 to (ComboBox1.Items.Count - 1) do
  begin
    if( CompareText(ComboBox1.Items[i], ComboBox1.Text ) = 0 ) then
    begin
      New := False;
      break;
    end;
  end;

  if( ( New ) and
      ( CompareText(ComboBox1.Text, DEFAULT_PATH) <> 0 )) then
    ComboBox1.Items.Insert(0, ComboBox1.Text);

  if( ComboBox1.Items.Count > 10 ) then
    ComboBox1.Items.Delete(10);

  for i:=0 to (ComboBox1.Items.Count -1) do
  begin
    IniFile.WriteString('Paths', 'Path' + IntToStr(i), ComboBox1.Items[i] );
  end;
  IniFile.Free;
end;

end.
