unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, OleCtrls, Dialogs, ShellApi;

type
  TAboutBox = class(TForm)
    MainPanel: TPanel;
    Version: TLabel;
    OKButton: TButton;
    WarningText: TLabel;
    CopyRightLabel: TLabel;
    Image1: TImage;
    VersionNumber: TStaticText;
    InternetLinkLabel: TStaticText;
    Info: TLabel;
    StaticText1: TStaticText;
    Image2: TImage;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure InternetLinkLabelMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure GetVersionInformation(const VersionInformationKey: array of string);
    procedure InternetLinkLabelClick(Sender: TObject);
    procedure FormMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation
uses Registry;
const RegistryName = '\Software\Microsoft\Internet Explorer\Settings';
      AnchorColor = 'Anchor Color';
      AnchorColorVisited = 'Anchor Color Visited';
var SelectedColor, UnselectedColor, VisitedColor: TColor;


{$R *.DFM}


function GetColor(ColorString: String): TColor;
var I: Integer;
		Red, Green, Blue: Cardinal;
begin
	I := Pos(',', ColorString);
  Red := StrToInt(Copy(ColorString, 0, I - 1));

  ColorString := Copy(ColorString, I + 1, Length(ColorString) - I);
  ColorString := Trim(ColorString);
	I := Pos(',', ColorString);
  Green := StrToInt(Copy(ColorString, 0, I - 1));

  ColorString := Copy(ColorString, I + 1, Length(ColorString) - I);
  ColorString := Trim(ColorString);
  Blue := StrToInt(ColorString);

  Result := RGB(Red, Green, Blue);
end;


procedure TAboutBox.FormCreate(Sender: TObject);
var
  Sysdir: PChar;
  buffersize: Integer;
  ExplorerColors: TRegIniFile;
begin
  buffersize := 255;
  GetMem(Sysdir, buffersize);
  try
    GetSystemDirectory( SysDir, buffersize);
  finally
    FreeMem(Sysdir);
  end;
  UnselectedColor := InternetLinkLabel.Font.Color;
  ExplorerColors := TRegIniFile.Create('');
  with ExplorerColors do
    try
      VisitedColor := GetColor(ReadString(RegistryName, AnchorColorVisited, '0, 0, 255'));
      SelectedColor := GetColor(ReadString(RegistryName, AnchorColor, '128, 0, 128'));
    finally
      Free;
    end;
  GetVersionInformation(['CompanyName', 'ProductName', 'FileVersion']);
end;

procedure TAboutBox.GetVersionInformation(const VersionInformationKey: array of string);
const LangCharset = '0C0904E4';
var VZero, SizeOfInfo, I: DWord;
    Buffer, VersionValue, VersionPointer: PChar;
begin
  SizeOfInfo := GetFileVersionInfoSize(PChar(Application.Exename), VZero);
  if SizeOfInfo = 0 then // ShowMessage('No version data saved in exe file.')
  else begin
    Buffer := StrAlloc(SizeOfInfo + 1);
    try
      GetFileVersionInfo(PChar(Application.Exename), 0, SizeOfInfo, Buffer);

      for I := 0 to High(VersionInformationKey) do begin
	      if not VerQueryValue(Buffer, PChar('\\StringFileInfo\\' + LangCharset +
          '\\' + VersionInformationKey[I]), Pointer(VersionPointer), SizeOfInfo) then
//          ShowMessage('Error retrieving version info...')
        else if SizeOfInfo < 2 then //ShowMessage('No Version Info for ' + VersionInformationKey[I])
        else begin
          VersionValue := StrAlloc(SizeOfInfo + 1);
          try
            StrLCopy(VersionValue, VersionPointer, SizeOfInfo);
//            ShowMessage(VersionInformationKey[I] + ' = ' + VersionValue);
              if I=2 then VersionNumber.Caption := VersionValue;
          finally
            StrDispose(VersionValue);
          end;
        end;
      end;
    finally
      StrDispose(Buffer);
    end;
  end;
end;

procedure TAboutBox.InternetLinkLabelClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(InternetLinkLabel.Caption+'/default.asp'), nil, nil, SW_SHOWNORMAL);
  UnselectedColor := VisitedColor;
	FormMouseMove(Self, [], 0, 0);
end;

procedure TAboutBox.InternetLinkLabelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 (Sender as TStaticText).Font.Color := SelectedColor;
end;

procedure TAboutBox.FormMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  InternetLinkLabel.Font.Color := UnselectedColor;
end;


end.

