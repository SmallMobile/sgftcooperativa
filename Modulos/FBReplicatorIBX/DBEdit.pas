unit DBEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Rascomp32;

const
  stars = '***************';

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    EDBPath: TEdit;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    ERasUser: TEdit;
    ERasPass: TEdit;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RAS: TRAS;
    Panel3: TPanel;
    EUser: TEdit;
    EPass: TEdit;
    EConPass: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Button1: TButton;
    Button2: TButton;
    ERasConPass: TEdit;
    Label8: TLabel;
    Button3: TButton;
    OpenDialog1: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    procedure DoRASBox;
  public
    { Public declarations }
    LocPath: string[100];
    User: string[50];
    Password: string[50];
    RasServiceName: string[50];
    RasUser: string[50];
    RasPassword: string[50];
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

procedure TForm2.FormShow(Sender: TObject);
begin
  EDBPath.Text := LocPath;
  EUser.Text := User;
  EPass.Text := Password;
  if( length(RasServiceName) = 0 ) then
    CheckBox1.Checked := False
  else begin
    CheckBox1.Checked := True;
    ComboBox1.Text := RasServiceName;
    ERasUser.Text := RasUser;
    ERasPass.Text := RasPassword;
  end;

  DoRASBox;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  if( CompareStr(EPass.Text,EConPass.Text) <> 0 ) then
    ShowMessage('DB Password and Confirmed DB Password do not match')
  else if( CompareStr(ERasPass.Text,ERasConPass.Text) <> 0 ) then
    ShowMessage('RAS Password and Confirmed RAS Password do not match')
  else begin
    LocPath := EDBPath.Text;
    User := EUser.Text;
    Password := EPass.Text;
    if(CheckBox1.Checked) then
    begin
      RasServiceName := ComboBox1.Text;
      RasUser := ERasUser.Text;
      RasPassword := ERasPass.Text;
    end else begin
      RasServiceName := '';
      RasUser := '';
      RasPassword := '';
    end;
    ModalResult := mrOK;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TForm2.CheckBox1Click(Sender: TObject);
begin
  DoRASBox;
end;

procedure TForm2.DoRASBox;
begin
  if( CheckBox1.Checked ) then
  begin
    RAS.GetPhoneBookEntries;
    ComboBox1.Items.Assign (RAS.PhoneBookEntries);
    ComboBox1.Enabled := True;
    ERasUser.ReadOnly := False;
    ERasPass.ReadOnly := False;
    ERasConPass.ReadOnly := False;
  end else begin
    ComboBox1.Text := '';
    ERasUser.Text := '';
    ERasPass.Text := '';
    ERasConPass.Text := '';
    ComboBox1.Enabled := False;
    ERasUser.ReadOnly := True;
    ERasPass.ReadOnly := True;
    ERasConPass.ReadOnly := True;
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  EDBPath.Text := OpenDialog1.FileName;
end;

end.
