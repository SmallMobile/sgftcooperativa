{******************************************}
{                                          }
{                 PReport                  }
{                                          }
{ Copyright (c) 1999-2002 by vtkTools      }
{                                          }
{******************************************}

unit pr_TxConsts;

interface

uses
  SysUtils, Classes, Graphics, typinfo, windows, WinSpool, CommDlg, Forms,
  messages, inifiles,

  pr_Common;

const
  _sTxReportOptionsFileName = 'TxRO.ini';
  ESCSymbol = #27;
  ESCCustomCommandSymbol = #26;
  sFormFeedTxCommand = 'txcFormFeed';

type
  TprTxFontOption = class;
  TprTxReportOptions = class;
  TprTxPaperType = (ptPage,ptRulon);
  TprTxPrintRulonMode = (prmAllLines,prmLinesRange);
  /////////////////////////////////////////////////
  //
  // TprTxFontOptions
  //
  /////////////////////////////////////////////////
  TprTxFontOptions = class(TList)
  private
    function GetItm(i : integer) : TprTxFontOption;
  public
    property Items[i : integer] : TprTxFontOption read GetItm; default;
    procedure Assign(Source : TprTxFontOptions);
    function Equals(Value : TprTxFontOptions) : boolean;
    function Contains(TxFontOption : TprTxFontOption) : boolean;
    procedure Remove(TxFontOption : TprTxFontOption);
    function Add(TxFontOption : TprTxFontOption) : integer;
  end;

  /////////////////////////////////////////////////
  //
  // TprTxRecodeTable
  //
  /////////////////////////////////////////////////
  TprTxRecodeTable = class(TObject)
  private
    FRecodeTableName : string;
    FDescription : string;
    FOEMtoWINTable : array [0..127] of char;
    FWINtoOEMTable : array [0..127] of char;
    function GetOEMtoWINTable : PChar;
    function GetWINtoOEMTable : PChar;
    procedure Decode(sSource,sDest,Table : PChar);
  public
    property RecodeTableName : string read FRecodeTableName;
    property Description : string read FDescription;
    property OEMtoWINTable : PChar read GetOEMtoWINTable;
    property WINtoOEMTable : PChar read GetWINtoOEMTable;
    procedure WINtoOEM(sSource,sDest : PChar);
    procedure OEMtoWIN(sSource,sDest : PChar);
  end;

  /////////////////////////////////////////////////
  //
  // TprTxCommand
  //
  /////////////////////////////////////////////////
  TprTxCommand = class(TObject)
  private
    FName : string;
    FSymbol : char;
    FDescription : string;
  public
    property Name : string read FName;
    property Symbol : char read FSymbol;
    property Description : string read FDescription;
  end;

  /////////////////////////////////////////////////
  //
  // TprTxFontStyle
  //
  /////////////////////////////////////////////////
  TprTxFontStyle = class(TObject)
  private
    FName : string;
    FTxCommand : TprTxCommand;
    FDescription : string;
  public
    property Name : string read FName;
    property TxCommand : TprTxCommand read FTxCommand write FTxCommand;
    property Description : string read FDescription;
  end;

  /////////////////////////////////////////////////
  //
  // TprTxFontOption
  //
  /////////////////////////////////////////////////
  TprTxFontOption = class(TObject)
  private
    FName : string;
    FTxCommandOn : TprTxCommand;
    FTxCommandOff : TprTxCommand;
    FDescription : string;
  public
    property Name : string read FName;
    property TxCommandOn : TprTxCommand read FTxCommandOn write FTxCommandOn;
    property TxCommandOff : TprTxCommand read FTxCommandOff write FTxCommandOff;
    property Description : string read FDescription;
  end;

  /////////////////////////////////////////////////
  //
  // TprESCModelItem
  //
  /////////////////////////////////////////////////
  TprESCModelItem = class(TObject)
  private
    FTxCommand : TprTxCommand;
    FESCCommand : string;
  public
    property TxCommand : TprTxCommand read FTxCommand;
    property ESCCommand : string read FESCCommand write FESCCommand;
  end;

  /////////////////////////////////////////////////
  //
  // TprESCModel
  //
  /////////////////////////////////////////////////
  TprESCModel = class(TObject)
  private
    FModelName : string;
    FPrinterDriver : string;
    FESCs : TList;
    function GetESC(i : integer) : TprESCModelItem;
  public
    property ESCs[i : integer] : TprESCModelItem read GetESC;
    property ModelName : string read FModelName;
    property PrinterDriver : string read FPrinterDriver;
    function GetRealESCCommandForESCPrefix(c : char) : string;
    function GetRealESCCommand(const TxCommand : string) : string;
    function GetFormFeedRealESCCommand : string;
    constructor Create;
    destructor Destroy; override;
  end;

  /////////////////////////////////////////////////
  //
  // rSetupPrintParams
  //
  /////////////////////////////////////////////////
  rSetupPrintParams = record
    MaxLines : integer;
    PrintPagesMode : TprPrintPagesMode;
    ESCModelName : string;
    PrinterName : string;
    UseLinesOnPage : boolean;
    WrapAfterColumn : integer;
    MakeFormFeedOnRulon : boolean;
    LeftSpaces : integer;
    PrintRulonMode : TprTxPrintRulonMode;
    FromLine : integer;
    ToLine : integer;
    PrintPages : string;
    PrintPagesList : TList;
    PaperType : TprTxPaperType;
    LinesOnPage : integer;
  end;
  pSetupPrintParams = ^rSetupPrintParams;

  /////////////////////////////////////////////////
  //
  // TprTxReportOptions
  //
  /////////////////////////////////////////////////
  TprTxReportOptions = class(TObject)
  private
    FRecodeTables : TList;
    FESCModels : TList;
    FTxCommands : TList;
    FTxFontStyles : TList;
    FTxFontOptions : TList;
    FDefaultRecodeTable : TprTxRecodeTable;
    function GetTxRecodeTable(i : integer) : TprTxRecodeTable;
    function GetESCModel(i : integer) : TprESCModel;
    function GetTxCommand(i : integer) : TprTxCommand;
    function GetTxFontStyle(i : integer) : TprTxFontStyle;
    function GetTxFontOption(i : integer) : TprTxFontOption;
    function GetTxRecodeTablesCount : integer;
    function GetESCModelsCount : integer;
    function GetTxCommandsCount : integer;
    function GetTxFontStylesCount : integer;
    function GetTxFontOptionsCount : integer;
  public
    property RecodeTables[i : integer] : TprTxRecodeTable read GetTxRecodeTable;
    property TxRecodeTablesCount : integer read GetTxRecodeTablesCount;
    property ESCModels[i : integer] : TprESCModel read GetESCModel;
    property ESCModelsCount : integer read GetESCModelsCount;
    property TxCommands[i : integer] : TprTxCommand read GetTxCommand;
    property TxCommandsCount : integer read GetTxCommandsCount;
    property TxFontStyles[i : integer] : TprTxFontStyle read GetTxFontStyle;
    property TxFontStylesCount : integer read GetTxFontStylesCount;
    property TxFontOptions[i : integer] : TprTxFontOption read GetTxFontOption;
    property TxFontOptionsCount : integer read GetTxFontOptionsCount;
    property DefaultRecodeTable : TprTxRecodeTable read FDefaultRecodeTable;

    function IndexOfTxFontStyle(TxFontStyle : TprTxFontStyle) : integer;
    function IndexOfTxFontOption(const TxFontOptionName : string) : integer;
    function FindRecodeTable(const RecodeTableName : string) : TprTxRecodeTable;
    function FindESCModelByDriverName(const DriverName : string) : TprESCModel;
    function FindESCModel(const ESCModelName : string) : TprESCModel;
    function FindTxCommand(const TxCommandName : string) : TprTxCommand;
    function FindTxFontStyle(const TxFontStyle : string) : TprTxFontStyle;
    function FindTxFontOption(const TxFontOption : string) : TprTxFontOption;
    function ESCModelIndexByModelName(const ModelName : string) : integer;

    function GetTxFontStyleESCPrefix(TxFontStyle : TprTxFontStyle) : string;
    function GetTxFontOptionsESCPrefixOn(FontOptions : TprTxFontOptions) : string;
    function GetTxFontOptionsESCPrefixOff(FontOptions : TprTxFontOptions) : string;
    function GetTxFontOptionESCPrefixOn(TxFontOption : TprTxFontOption) : string;
    function GetTxFontOptionESCPrefixOff(TxFontOption : TprTxFontOption) : string;
    function GetFormFeedESCPrefix : string;

    function GetESCModelForPrinter(const PrinterName : string) : TprESCModel;
    function RemoveESCFromString(const s : string) : string;
    function ESCSkipTo(const s : string; SkipCount : integer; var p : integer) : integer;
    function TxPrintStrings(Lines : TStrings;
                            const PrinterName : string; // name of printer
                            const ESCModelName : string; // ESC model of printer
                            const ReportTitle : string; // name of task in Spooler Windows
                            Copies : integer;
                            WrapAfterColumn : integer;
                            LeftSpaces : integer;
                            PaperType : TprTxPaperType; // Roller or Pages
                            PrintRulonMode : TprTxPrintRulonMode;
                            MakeFormFeedOnRulon : boolean;
                            FromLine : integer;
                            ToLine : integer;
                            PrintPagesMode : TprPrintPagesMode;
                            LinesOnPage : integer;
                            UseLinesOnPage : boolean;
                            PrintPagesList : TList;
                            FromPage : integer;
                            ToPage : integer;
                            RecodeTable : TprTxRecodeTable=nil;
                            StartNewLineOnWrap : boolean=false
                            ) : boolean;
    function TxSetupPrintParams(hWndOwner : THandle; // Handle of parent window
                                MaxPage : integer;
                                MaxLines : integer;
                                var LinesOnPage : integer;
                                var FromPage : integer;
                                var ToPage : integer;
                                var PrintPagesMode : TprPrintPagesMode;
                                var ESCModelName : string;
                                var PrinterName : string;
                                var UseLinesOnPage : boolean;
                                var WrapAfterColumn : integer;
                                var MakeFormFeedOnRulon : boolean;
                                var LeftSpaces : integer;
                                var PrintRulonMode : TprTxPrintRulonMode;
                                var FromLine : integer;
                                var ToLine : integer;
                                var PrintPages : string;
                                PrintPagesList : TList;
                                var PaperType : TprTxPaperType;
                                var Copies : integer
                                )  : boolean;
    function ESCStringLengthWithoutESC(const s : string) : integer;
    function ParsePages(Lines : TStrings;
                        UseLinesOnPage : boolean;
                        LinesOnPage : integer;
                        PagesList : TList) : integer;

    procedure LoadFromFile(const FileName : string);
    procedure LoadFromRes();

    constructor Create;
    destructor Destroy; override;
  end;

var
  TxReportOptions : TprTxReportOptions;
  prTxReportOptionsFileName : string;
//  prOEMtoWINTable : array [0..127] of char = #192#193#194#195#196#197#198#199#200#201#202#203#204#205#206#207#208#209#210#211#212#213#214#215#216#217#218#219#220#221#222#223#224#225#226#227#228#229#230#231#232#233#234#235#236#237#238#239#128#129#130#131#132#133#134#135#136#137#138#139#140#141#142#143#144#145#146#147#148#149#150#151#152#153#154#155#156#157#158#159#160#161#162#163#164#165#166#167#168#169#170#171#172#173#174#175#240#241#242#243#244#245#246#247#248#249#250#251#252#253#254#255#176#177#178#179#180#181#182#183#184#185#186#187#185#189#190#191;
//  prWINtoOEMTable : array [0..127] of char = #176#177#178#179#180#181#182#183#184#185#186#187#188#189#190#191#192#193#194#195#196#197#198#199#200#201#202#203#204#205#206#207#208#209#210#211#212#213#214#215#216#217#218#219#220#221#222#223#240#241#242#243#244#245#246#247#248#78#250#251#252#253#254#255#128#129#130#131#132#133#134#135#136#137#138#139#140#141#142#143#144#145#146#147#148#149#150#151#152#153#154#155#156#157#158#159#160#161#162#163#164#165#166#167#168#169#170#171#172#173#174#175#224#225#226#227#228#229#230#231#232#233#234#235#236#237#238#239;
                                                                                                                                                                                                                                                                                  {249}
implementation

uses
  pr_Utils, pr_Strings, pr_MultiLang;

/////////////////////////////////////////////////
//
// TprTxFontOptions
//
/////////////////////////////////////////////////
function TprTxFontOptions.GetItm(i : integer) : TprTxFontOption;
begin
Result := TprTxFontOption(inherited Items[i]);
end;

procedure TprTxFontOptions.Assign(Source : TprTxFontOptions);
var
  i : integer;
begin
Clear;
for i:=0 to Source.Count-1 do
  Add(Source[i]);
end;

function TprTxFontOptions.Equals(Value : TprTxFontOptions) : boolean;
var
  i : integer;
begin
Result := Count=Value.Count;
if Result then
  begin
    i := 0;
    while (i<Count) and (Items[i]=Value[i]) do Inc(i);
    Result := i>=Count;
  end;
end;

function TprTxFontOptions.Contains(TxFontOption : TprTxFontOption) : boolean;
begin
Result := IndexOf(TxFontOption)<>-1;
end;

procedure TprTxFontOptions.Remove(TxFontOption : TprTxFontOption);
var
  i : integer;
begin
i := IndexOf(TxFontOption);
if i<>-1 then
  Delete(i);
end;

function TprTxFontOptions.Add(TxFontOption : TprTxFontOption) : integer;
begin
if IndexOf(TxFontOption)=-1 then
  Result := inherited Add(TxFontOption)
else
  Result := -1;
end;

/////////////////////////////////////////////////
//
// TprTxCodePage
//
/////////////////////////////////////////////////
function TprTxRecodeTable.GetOEMtoWINTable : PChar;
begin
Result := @FOEMtoWINTable[0];
end;

function TprTxRecodeTable.GetWINtoOEMTable : PChar;
begin
Result := @FWINtoOEMTable[0];
end;

procedure TprTxRecodeTable.Decode(sSource,sDest,Table : PChar);
var
  i : integer;
begin
for i:=0 to lstrlen(sSource)-1 do
  if byte(sSource[i])>=128 then
    sDest[i] := Table[byte(sSource[i])-128];
end;

procedure TprTxRecodeTable.WINtoOEM(sSource,sDest : PChar);
begin
Decode(sSource,sDest,WINtoOEMTable);
end;

procedure TprTxRecodeTable.OEMtoWIN(sSource,sDest : PChar);
begin
Decode(sSource,sDest,OEMtoWINTable);
end;

/////////////////////////////////////////////////
//
// TprESCModel
//
/////////////////////////////////////////////////
constructor TprESCModel.Create;
begin
inherited Create;
FESCs := TList.Create;
end;

destructor TprESCModel.Destroy;
begin
FreeList(FESCs);
FESCs.Destroy;
inherited;
end;

function TprESCModel.GetESC(i : integer) : TprESCModelItem;
begin
Result := TprESCModelItem(FESCs[i]);
end;

function TprESCModel.GetRealESCCommandForESCPrefix(c : char) : string;
var
  i : integer;
begin
i := 0;
while (i<FESCs.Count) and ((ESCs[i].TxCommand=nil) or (ESCs[i].TxCommand.Symbol<>c)) do Inc(i);
if (i<FESCs.Count) and (ESCs[i].TxCommand<>nil) then
  Result := ESCs[i].ESCCommand
else
  Result := '';
end;

function TprESCModel.GetRealESCCommand(const TxCommand : string) : string;
var
  i : integer;
begin
Result := '';
i := 0;
while (i<FESCs.Count) and ((ESCs[i].TxCommand=nil) or (AnsiCompareText(ESCs[i].TxCommand.Name,TxCommand)<>0)) do Inc(i);
if (i<FESCs.Count) and (ESCs[i].TxCommand<>nil) then
  Result := ESCs[i].ESCCommand
else
  Result := '';
end;

function TprESCModel.GetFormFeedRealESCCommand : string;
begin
Result := GetRealESCCommand(sFormFeedTxCommand);
end;

/////////////////////////////////////////////////
//
// TprTxReportOptions
//
/////////////////////////////////////////////////
constructor TprTxReportOptions.Create;
begin
inherited;
FRecodeTables := TList.Create;
FESCModels := TList.Create;
FTxCommands := TList.Create;
FTxFontStyles := TList.Create;
FTxFontOptions := TList.Create;
end;

destructor TprTxReportOptions.Destroy;
begin
FreeList(FRecodeTables);
FRecodeTables.Free;
FreeList(FESCModels);
FESCModels.Free;
FreeList(FTxCommands);
FTxCommands.Free;
FreeList(FTxFontStyles);
FTxFontStyles.Free;
FreeList(FTxFontOptions);
FTxFontOptions.Free;
inherited;
end;

function TprTxReportOptions.GetTxRecodeTable(i : integer) : TprTxRecodeTable;
begin
Result := TprTxRecodeTable(FRecodeTables[i]);
end;

function TprTxReportOptions.GetESCModel(i : integer) : TprESCModel;
begin
Result := TprESCModel(FESCModels[i]);
end;

function TprTxReportOptions.GetTxCommand(i : integer) : TprTxCommand;
begin
Result := TprTxCommand(FTxCommands[i]);
end;

function TprTxReportOptions.GetTxFontStyle(i : integer) : TprTxFontStyle;
begin
Result := TprTxFontStyle(FTxFontStyles[i]);
end;

function TprTxReportOptions.GetTxFontOption(i : integer) : TprTxFontOption;
begin
Result := TprTxFontOption(FTxFontOptions[i]);
end;

function TprTxReportOptions.GetTxCommandsCount : integer;
begin
Result := FTxCommands.Count;
end;

function TprTxReportOptions.GetTxRecodeTablesCount : integer;
begin
Result := FRecodeTables.Count;
end;

function TprTxReportOptions.GetESCModelsCount : integer;
begin
Result := FESCModels.Count;
end;

function TprTxReportOptions.GetTxFontStylesCount : integer;
begin
Result := FTxFontStyles.Count;
end;

function TprTxReportOptions.GetTxFontOptionsCount : integer;
begin
Result := FTxFontOptions.Count;
end;

function TprTxReportOptions.GetTxFontStyleESCPrefix(TxFontStyle : TprTxFontStyle) : string;
begin
if TxFontStyle=nil then
  Result := ''
else
  Result := ESCSymbol+TxFontStyle.TxCommand.Symbol
end;

function TprTxReportOptions.GetTxFontOptionsESCPrefixOn(FontOptions : TprTxFontOptions) : string;
var
  i : integer;
begin
Result := '';
for i:=0 to FontOptions.Count-1 do
  Result := Result+ESCSymbol+FontOptions[i].TxCommandOn.Symbol;
end;

function TprTxReportOptions.GetTxFontOptionsESCPrefixOff(FontOptions : TprTxFontOptions) : string;
var
  i : integer;
begin
Result := '';
for i:=0 to FontOptions.Count-1 do
  Result := ESCSymbol+FontOptions[i].TxCommandOff.Symbol+Result;
end;

function TprTxReportOptions.GetTxFontOptionESCPrefixOn(TxFontOption : TprTxFontOption) : string;
begin
Result := ESCSymbol+TxFontOption.TxCommandOn.Symbol;
end;

function TprTxReportOptions.GetTxFontOptionESCPrefixOff(TxFontOption : TprTxFontOption) : string;
begin
Result := ESCSymbol+TxFontOption.TxCommandOff.Symbol;
end;

function TprTxReportOptions.IndexOfTxFontStyle(TxFontStyle : TprTxFontStyle) : integer;
begin
Result := FTxFontStyles.IndexOf(TxFontStyle);
end;

function TprTxReportOptions.IndexOfTxFontOption(const TxFontOptionName : string) : integer;
begin
Result := 0;
while (Result<TxFontOptionsCount) and (AnsiCompareText(TxFontOptions[Result].Name,TxFontOptionName)<>0) do Inc(Result);
if Result>=TxFontOptionsCount then
  Result := -1;
end;

function TprTxReportOptions.FindRecodeTable(const RecodeTableName : string) : TprTxRecodeTable;
var
  i : integer;
begin
i := 0;
while (i<FRecodeTables.Count) and (AnsiCompareText(RecodeTables[i].RecodeTableName,RecodeTableName)<>0) do Inc(i);
if i>=FRecodeTables.Count then
  Result := nil
else
  Result := RecodeTables[i];
end;

function TprTxReportOptions.FindESCModelByDriverName(const DriverName : string) : TprESCModel;
var
  i : integer;
begin
i := 0;
while (i<ESCModelsCount) and (pos(AnsiUpperCase(ESCModels[i].PrinterDriver),AnsiUpperCase(DriverName))=0) do Inc(i);
if i<ESCModelsCount then
  Result := ESCModels[i]
else
  Result := nil;
end;

function TprTxReportOptions.FindESCModel(const ESCModelName : string) : TprESCModel;
var
  i : integer;
begin
i := 0;
while (i<ESCModelsCount) and (AnsiCompareText(ESCModels[i].ModelName,ESCModelName)<>0) do Inc(i);
if i<ESCModelsCount then
  Result := ESCModels[i]
else
  Result := nil;
end;

function TprTxReportOptions.FindTxCommand(const TxCommandName : string) : TprTxCommand;
var
  i : integer;
begin
i := 0;
while (i<TxCommandsCount) and (AnsiCompareText(TxCommands[i].Name,TxCommandName)<>0) do Inc(i);
if i>=TxCommandsCount then
  Result := nil
else
  Result := TxCommands[i];
end;

function TprTxReportOptions.FindTxFontStyle(const TxFontStyle : string) : TprTxFontStyle;
var
  i : integer;
begin
i := 0;
while (i<TxFontStylesCount) and (AnsiCompareText(TxFontStyles[i].Name,TxFontStyle)<>0) do Inc(i);
if i>=TxFontStylesCount then
  Result := nil
else
  Result := TxFontStyles[i];
end;

function TprTxReportOptions.FindTxFontOption(const TxFontOption : string) : TprTxFontOption;
var
  i : integer;
begin
i := 0;
while (i<TxFontOptionsCount) and (AnsiCompareText(TxFontOptions[i].Name,TxFontOption)<>0) do Inc(i);
if i>=TxFontOptionsCount then
  Result := nil
else
  Result := TxFontOptions[i];
end;

function TprTxReportOptions.ESCModelIndexByModelName(const ModelName : string) : integer;
begin
Result := 0;
while (Result<ESCModelsCount) and (AnsiCompareText(ESCModels[Result].ModelName,ModelName)<>0) do Inc(Result);
if Result>=ESCModelsCount then
  Result := -1;
end;

function TprTxReportOptions.RemoveESCFromString(const s : string) : string;
var
  j,l,i : integer;
begin
l := Length(s);
j := 1;
i := 1;
SetLength(Result,l);
while j<=l do
  begin
    if s[j]=ESCSymbol then
      Inc(j)
    else
      if s[j]=ESCCustomCommandSymbol then
        repeat
          Inc(j);
        until (j>l) or (s[j]=ESCCustomCommandSymbol)
      else
        begin
          Result[i] := s[j];
          Inc(i);
        end;
    Inc(j);
  end;
SetLength(Result,i-1);
end;

function TprTxReportOptions.ESCSkipTo(const s : string; SkipCount : integer; var p : integer) : integer;
var
  LenStr : integer;
begin
Result := 0;
LenStr := Length(s);
while (p<=LenStr) and (Result<SkipCount) do
  begin
    if s[p]=ESCSymbol then
      Inc(p)
    else
      if s[p]=ESCCustomCommandSymbol then
        repeat
          Inc(p);
        until (p>LenStr) or (s[p]=ESCCustomCommandSymbol)
      else
        Inc(Result);
    Inc(p);
  end;
end;

function TprTxReportOptions.GetESCModelForPrinter(const PrinterName : string) : TprESCModel;
var
  Buf,Buffer : PChar;
  i,BytesNeeded,NumInfo : cardinal;
begin
Result := nil;
Buffer := nil;
BytesNeeded := 0;
EnumPrinters(PRINTER_ENUM_LOCAL or PRINTER_ENUM_CONNECTIONS,nil,2,Buffer,0,BytesNeeded,NumInfo);
if BytesNeeded<>0 then
  begin
    GetMem(Buffer,BytesNeeded);
    try
      if EnumPrinters(PRINTER_ENUM_LOCAL or PRINTER_ENUM_CONNECTIONS,nil,2,Buffer,BytesNeeded,BytesNeeded,NumInfo) then
        begin
          i := 0;
          Buf := Buffer;
          while (i<NumInfo) and (StrPas(PPrinterInfo2(Buf).pPrinterName)<>PrinterName) do
            begin
              Inc(i);
              Buf := Buf+sizeof(TPrinterInfo2);
            end;
          if i<NumInfo then
            Result := FindESCModelByDriverName(StrPas(PPrinterInfo2(Buf).pDriverName));
        end;
    finally
      FreeMem(Buffer);
    end;
  end;
end;

function TprTxReportOptions.TxPrintStrings;
var
  h : Cardinal;
  DocInfo : DOC_INFO_1;
  ESCModel : TprESCModel;
  PagesList : TList;
  PrinterOpened,DocStarted,PageStarted : boolean;
  wc,WrapCount,i,j,k,l,ml,_FromLine,_ToLine : integer;

  // write string part
  procedure PrintLine(const s : string; wc : integer; PrintFormFeed : boolean);
  var
    b2 : string;
    i,l,sl,el,n : integer;
    BytesWritten : cardinal;
  begin
  l := Length(s);
  if WrapAfterColumn<1 then
    begin
      sl := 1;
      el := l+1;
    end
  else
    begin
      i := 1;
      ESCSkipTo(s,wc*WrapAfterColumn,i);
      sl := i;
      ESCSkipTo(s,WrapAfterColumn,i);
      el := i;
    end;
  if (sl>l) and ((l>0) or (wc>0)) and StartNewLineOnWrap then
    exit;

  i := 1;
  b2 := '';
  while i<=l do
    begin
      if s[i]=ESCSymbol then
        begin
          // get real ESC command for this ESC specifier and ESC model
          Inc(i);
          b2 := b2+ESCModel.GetRealESCCommandForESCPrefix(s[i]);
        end
      else
        if s[i]=ESCCustomCommandSymbol then
          begin
            n := i;
            repeat
              Inc(i);
            until (i>l) or (s[i]=ESCCustomCommandSymbol);
            b2 := b2+Copy(s,n,i-n);
          end
        else
          if (i>=sl) and (i<el) then
            b2 := b2+s[i];
      Inc(i);
    end;

  if RecodeTable<>nil then
    RecodeTable.WINtoOEM(PChar(b2),PChar(b2));
  b2 := b2+#13#10;
  WritePrinter(h, @(b2[1]), Length(b2), BytesWritten);
  end;

  procedure CheckStartPagePrinter;
  begin
  PageStarted:=StartPagePrinter(h);
  if not PageStarted then
    raise Exception.CreateFmt(prLoadStr(sErrorTxStartPage),[GetLastError]);
  end;

  procedure EjectPage;
  var
    b : string;
    BytesWritten : cardinal;
  begin
  b := ESCModel.GetFormFeedRealESCCommand;
  WritePrinter(h,@(b[1]),Length(b),BytesWritten);
  end;

  procedure PrintPage(PageIndex : integer);
  var
    i,j,l : integer;
  begin
  if PageIndex>=PagesList.Count-1 then
    l := Lines.Count
  else
    l := integer(PagesList[PageIndex+1]);

  if StartNewLineOnWrap then
    begin
      for i:=integer(PagesList[PageIndex]) to l-1 do
        for j:=0 to WrapCount do
          PrintLine(Lines[i],j,false);
      EjectPage;
    end
  else
    begin
      for j:=0 to WrapCount do
        begin
          for i:=integer(PagesList[PageIndex]) to l-1 do
            PrintLine(Lines[i],j,false);
          EjectPage;
        end;
    end;
  end;

begin
ESCModel := nil;
if ESCModelName='' then
  begin
    if PrinterName<>'' then
      ESCModel := GetESCModelForPrinter(PrinterName);
  end
else
  ESCModel := FindESCModel(ESCModelName);

Result := false;
PrinterOpened := false;
DocStarted := false;
PageStarted := false;
PagesList := TList.Create;
try
  if not OpenPrinter(PChar(PrinterName),h,nil) then
    raise Exception.CreateFmt(prLoadStr(sErrorTxOpenPrinter),[GetLastError]);
  PrinterOpened := true;

  DocInfo.pDocName := PChar(ReportTitle);
  DocInfo.pOutputFile := nil;
  DocInfo.pDatatype := 'RAW';
  if StartDocPrinter(h,1,@DocInfo)=0 then
    raise Exception.CreateFmt(prLoadStr(sErrorTxStartDoc),[GetLastError]);
  DocStarted := true;

  CheckStartPagePrinter;

  WrapCount := 0;
  if WrapAfterColumn>1 then
    begin
      ml := ESCStringLengthWithoutESC(Lines[0]);
      for i:=1 to Lines.Count-1 do
        begin
          l := ESCStringLengthWithoutESC(Lines[i]);
          if ml<l then
            ml := l;
        end;

      WrapCount := ml div WrapAfterColumn;
      if (ml mod WrapAfterColumn)=0 then
        Dec(WrapCount);
      if WrapCount=-1 then
        WrapCount := 0;
    end;

  if PaperType=ptPage then
    ParsePages(Lines,UseLinesOnPage,LinesOnPage,PagesList);

  case PaperType of
    ptRulon:
      begin
        _FromLine := 0;
        _ToLine := Lines.Count-1;
        case PrintRulonMode of
          prmLinesRange : begin _FromLine := FromLine-1; _ToLine := ToLine-1; end;
        end;

        for i:=1 to Copies do
          if StartNewLineOnWrap then
            for j:=_FromLine to _ToLine do
              for wc:=0 to WrapCount do
                PrintLine(Lines[j],wc,MakeFormFeedOnRulon)
          else
            for wc:=0 to WrapCount do
              for j:=_FromLine to _ToLine do
                PrintLine(Lines[j],wc,MakeFormFeedOnRulon);
      end;


    ptPage:
      begin
        for j:=1 to Copies do
          begin
            case PrintPagesMode of
              ppmAll,ppmPagesRange:
                begin
                  i := 0;
                  k := PagesList.Count-1;
                  if PrintPagesMode=ppmPagesRange then
                    begin
                      i := FromPage-1;
                      k := ToPage-1;
                    end;
                  for i:=i to k do
                    PrintPage(i);
                end;
              ppmPagesList:
                begin
                  for i:=0 to PrintPagesList.Count-1 do
                    PrintPage(integer(PrintPagesList[i])-1)
                end;
            end;
          end;
      end;
  end;

  Result := true;

finally
  PagesList.Free;
  if PageStarted then
    EndPagePrinter(h);
  if DocStarted then
    EndDocPrinter(h);
  if PrinterOpened then
    ClosePrinter(h);
end;
end;

//
// Calc real size of string without Esc specifiers
//
function TprTxReportOptions.ESCStringLengthWithoutESC(const s : string) : integer;
var
  p : integer;
begin
p := 1;
Result := ESCSkipTo(s,Length(s),p);
end;

function TprTxReportOptions.ParsePages(Lines : TStrings;
                                       UseLinesOnPage : boolean;
                                       LinesOnPage : integer;
                                       PagesList : TList) : integer;
var
  i,j : integer;
  Buf : string;
begin
Result := 1;
if PagesList<>nil then
  PagesList.Add(pointer(0));
Buf := GetFormFeedESCPrefix;
if Buf='' then
  exit; // FormFeed prefix not defined

j := 0;
for i:=0 to Lines.Count-1 do
  begin
    if pos(Buf,Lines[i])<>0 then
      begin
        if PagesList<>nil then
          PagesList.Add(pointer(i+1));
        j := 0;
        Inc(Result);
      end
    else
      begin
        if (UseLinesOnPage) and (j>=LinesOnPage) then
          begin
            if PagesList<>nil then
              PagesList.Add(pointer(i+1));
            j := 0;
            Inc(Result);
          end;
      end;
    Inc(j);
  end;
end;

function TprTxReportOptions.GetFormFeedESCPrefix : string;
var
  TxCommand : TprTxCommand;
begin
TxCommand := FindTxCommand(sFormFeedTxCommand);
if TxCommand<>nil then
  Result := ESCSymbol+TxCommand.Symbol;
end;

const
  IDD_PRINTTEMPLATE = 1002;
  IDC_PAGESLIST = 1000;
  IDC_ALL = 1056;
  IDC_PAGES = 1058;
  IDC_SELECTION = 1057;
  IDC_EDITPAGESLIST = 1001;
  IDC_FROMPAGE = 1152;
  IDC_TOPAGE = 1153;

  IDC_PAPERPAGE = 1007;
  IDC_PAPERRULON = 1008;

  IDC_RULONALLLINES = 1059;
  IDC_RULONLINESRANGE = 1060;

  IDC_LINESFROM = 1155;
  IDC_LINESTO = 1156;

  IDC_ESCMODEL = 1002;

  IDC_PRINTERS = 1139;

  IDC_MAKEFORMFEEDONRULON = 1006;
  IDC_LEFTSPACES = 1003;

  IDC_USELINESONPAGE = 1004;
  IDC_LINESONPAGE = 1157;

  IDC_WRAPAFTERCOLUMN = 1005;

var
  cpd : PPrintDlg;
  pspr : pSetupPrintParams;

procedure CenterWindow(Wnd: HWnd);
var
  Rect: TRect;
  Monitor: TMonitor;
begin
  GetWindowRect(Wnd, Rect);
  if Application.MainForm <> nil then
    Monitor := Application.MainForm.Monitor
  else
    Monitor := Screen.Monitors[0];
  SetWindowPos(Wnd,
               0,
               Monitor.Left + ((Monitor.Width - Rect.Right + Rect.Left) div 2),
               Monitor.Top + ((Monitor.Height - Rect.Bottom + Rect.Top) div 3),
               0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;

function DialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
var
  pl : TList;
  Buf : string;
  bBuf : LongBool;
  ESCModel : TprESCModel;
  Min,Max,lMin,lMax,CtrlID,TextLength : integer;

  procedure Check(CtrlIDs : array of integer);
  var
    i : integer;
  begin
  for i:=0 to High(CtrlIDs) do
    SendDlgItemMessage(Wnd,CtrlIDs[i],BM_SETCHECK,BST_CHECKED,0);
  end;

  procedure UnCheck(CtrlIDs : array of integer);
  var
    i : integer;
  begin
  for i:=0 to High(CtrlIDs) do
    SendDlgItemMessage(Wnd,CtrlIDs[i],BM_SETCHECK,BST_UNCHECKED,0);
  end;

  function IsChecked(CtrlID : integer) : boolean;
  begin
  Result := SendDlgItemMessage(Wnd,CtrlID,BM_GETCHECK,0,0)=BST_CHECKED;
  end;

  function GetText(CtrlID : integer) : string;
  var
    TextLength : integer;
  begin
  TextLength := GetWindowTextLength(GetDlgItem(Wnd,CtrlID));
  if TextLength>0 then
    begin
      SetLength(Result,TextLength);
      if GetDlgItemText(Wnd,CtrlID,@(Result[1]),TextLength+1)<=0 then
        Result := '';
    end
  else
    Result := '';
  end;

  function GetSelText(CtrlID : integer) : string;
  var
    i,TextLength : integer;
  begin
  Result := '';
  i := SendDlgItemMessage(Wnd,CtrlID,CB_GETCURSEL,0,0);
  if i<>CB_ERR then
    begin
      TextLength:=SendDlgItemMessage(Wnd,CtrlID,CB_GETLBTEXTLEN,i,0);
      if TextLength>0 then
        begin
          SetLength(Result,TextLength);
          if SendDlgItemMessage(Wnd,CtrlID,CB_GETLBTEXT,i,integer(@(Result[1])))=CB_ERR then
            Result := ''
        end
      else
        Result := '';
    end;
  end;

begin
Result := 0;

case Msg of
  WM_INITDIALOG:
    begin
      cpd := PPrintDlg(lParam);
      pspr := pSetupPrintParams(cpd.lCustData);

      SetDlgItemText(Wnd,IDC_EDITPAGESLIST,PChar(pspr.PrintPages));
      SetDlgItemInt(Wnd,IDC_LINESFROM,pspr.FromLine,false);
      SetDlgItemInt(Wnd,IDC_LINESTO,pspr.ToLine,false);
      SetDlgItemInt(Wnd,IDC_LINESONPAGE,pspr.LinesOnPage,false);
      SetDlgItemInt(Wnd,IDC_WRAPAFTERCOLUMN,pspr.WrapAfterColumn,false);

      UnCheck([IDC_PAGESLIST,
               IDC_PAGES,
               IDC_SELECTION,
               IDC_ALL,
               IDC_MAKEFORMFEEDONRULON,
               IDC_PAPERRULON,
               IDC_PAPERPAGE,
               IDC_USELINESONPAGE,
               IDC_RULONALLLINES,
               IDC_RULONLINESRANGE]);


      if pspr.MakeFormFeedOnRulon then
        Check([IDC_MAKEFORMFEEDONRULON]);

      SetDlgItemInt(Wnd,IDC_LEFTSPACES,pspr.LeftSpaces,false);

      case pspr.PaperType of
        ptRulon:
          begin
            Check([IDC_PAPERRULON]);
            case pspr.PrintRulonMode of
              prmAllLines : Check([IDC_RULONALLLINES]);
              prmLinesRange : Check([IDC_RULONLINESRANGE]);
            end;
          end;
        ptPage :
          begin
            Check([IDC_PAPERPAGE]);
            case pspr.PrintPagesMode of
              ppmPagesList : Check([IDC_PAGESLIST]);
              ppmPagesRange : Check([IDC_PAGES]);
              ppmSelection : Check([IDC_SELECTION]);
                        else Check([IDC_ALL]);
            end;
          end;
      end;

      for Min:=0 to TxReportOptions.ESCModelsCount-1 do
        SendDlgItemMessage(Wnd,IDC_ESCMODEL,CB_ADDSTRING,0,integer(PChar(TxReportOptions.ESCModels[Min].ModelName)));

      SendDlgItemMessage(Wnd,IDC_ESCMODEL,CB_SELECTSTRING,0,integer(PChar(pspr.ESCModelName)));
      SendDlgItemMessage(Wnd,IDC_PRINTERS,CB_SELECTSTRING,0,integer(PChar(pspr.PrinterName)));
      SendMessage(Wnd,WM_COMMAND,(CBN_SELCHANGE shl 16) or IDC_PRINTERS,GetDlgItem(Wnd,IDC_PRINTERS));

      if pspr.UseLinesOnPage then
        Check([IDC_USELINESONPAGE]);

      CenterWindow(Wnd);
    end;
  WM_COMMAND:
    begin
      case wParam of
        IDOK:
          begin
            ////////////////////////
            // [OK] pressed
            ////////////////////////

            // Check ESCMODEL
            Min:=SendDlgItemMessage(Wnd,IDC_ESCMODEL,CB_GETCURSEL,0,0);
            if Min=CB_ERR then
              Result:=1
            else
              begin
                TextLength := SendDlgItemMessage(Wnd,IDC_ESCMODEL,CB_GETLBTEXTLEN,Min,0)+1;
                Buf := MakeStr(' ',TextLength);
                if SendDlgItemMessage(Wnd,IDC_ESCMODEL,CB_GETLBTEXT,Min,integer(@(Buf[1])))<>CB_ERR then
                  begin
                    Min := TxReportOptions.ESCModelIndexByModelName(Buf);
                    if Min=-1 then
                      Result := 1;
                  end;
              end;
            if Result=1 then
              Application.MessageBox(PChar(prLoadStr(sSetupPrintError5)),PChar(prLoadStr(sAttention)),MB_OK+MB_ICONEXCLAMATION);

            // Check Lines range
            if (Result=0) and
               (IsChecked(IDC_RULONLINESRANGE)) then
              begin
                lMin:=GetDlgItemInt(Wnd,IDC_LINESFROM,bBuf,false);
                lMax:=GetDlgItemInt(Wnd,IDC_LINESTO,bBuf,false);
                if lMin>lMax then
                  begin
                    Application.MessageBox(PChar(prLoadStr(sSetupPrintError3)),PChar(prLoadStr(sAttention)),MB_OK+MB_ICONEXCLAMATION);
                    Result:=1;
                  end;
                if (lMin<=0) or (lMax>pspr.MaxLines) then
                  begin
                    Application.MessageBox(PChar(Format(prLoadStr(sSetupPrintError4),[1,pspr.MaxLines])),PChar(prLoadStr(sAttention)),MB_OK+MB_ICONEXCLAMATION);
                    Result:=1;
                  end;
              end;

            // check pages range
            if (Result=0) and
               IsChecked(IDC_PAGESLIST) then
              begin
                Buf := GetText(IDC_EDITPAGESLIST);
                if Buf='' then
                  begin
                    Application.MessageBox(PChar(prLoadStr(sSetupPrintError1)),PChar(prLoadStr(sAttention)),MB_OK+MB_ICONEXCLAMATION);
                    Result := 1;
                  end
                else
                  begin
                    pl:=TList.Create;
                    try
                      TextToPageList(Buf,pl);
                      Min :=cpd.nMinPage;
                      Max :=cpd.nMaxPage;
                      lMin:=integer(pl[0]);
                      lMax:=integer(pl[pl.Count-1]);
                      if (lMin<Min) or (lMin>Max) or (lMax<Min) or (lMax>Max) then
                        begin
                          SetFocus(GetDlgItem(Wnd,IDC_EDITPAGESLIST));
                          Application.MessageBox(PChar(Format(prLoadStr(sSetupPrintError2),[Min,Max])),PChar(prLoadStr(sAttention)),MB_ICONEXCLAMATION+MB_OK);
                          Result:=1;
                        end;
                    finally
                      pl.Free;
                    end;
                  end;
              end;

            // check LinesOnPage
            if (Result=0) and
               IsChecked(IDC_USELINESONPAGE) then
              begin
                Min:=GetDlgItemInt(Wnd,IDC_LINESONPAGE,bBuf,false);
                if Min<=0 then
                  begin
                    Application.MessageBox(PChar(prLoadStr(sSetupPrintError6)),PChar(prLoadStr(sAttention)),MB_OK+MB_ICONEXCLAMATION);
                    Result:=1;
                  end;
              end;

            if Result=0 then
              begin
                //////////////////////
                // save entered data
                //////////////////////
                pspr.ESCModelName   :=GetSelText(IDC_ESCMODEL);
                pspr.PrinterName    :=GetSelText(IDC_PRINTERS);

                pspr.UseLinesOnPage :=IsChecked(IDC_USELINESONPAGE);
                pspr.LinesOnPage    :=GetDlgItemInt(Wnd,IDC_LINESONPAGE,bBuf,false);

                pspr.WrapAfterColumn:=GetDlgItemInt(Wnd,IDC_WRAPAFTERCOLUMN,bBuf,false);

                pspr.MakeFormFeedOnRulon:=IsChecked(IDC_MAKEFORMFEEDONRULON);
                pspr.LeftSpaces         :=GetDlgItemInt(Wnd,IDC_LEFTSPACES,bBuf,false);

                if IsChecked(IDC_PAPERRULON) then
                  pspr.PaperType:=ptRulon
                else
                  if IsChecked(IDC_PAPERPAGE) then
                    pspr.PaperType:=ptPage;

                pspr.FromLine :=GetDlgItemInt(Wnd,IDC_LINESFROM,bBuf,false);
                pspr.ToLine   :=GetDlgItemInt(Wnd,IDC_LINESTO,bBuf,false);

                if IsChecked(IDC_RULONALLLINES) then
                  pspr.PrintRulonMode:=prmAllLines
                else
                  if IsChecked(IDC_RULONLINESRANGE) then
                    pspr.PrintRulonMode:=prmLinesRange;

                pspr.PrintPages:=GetText(IDC_EDITPAGESLIST);
                TextToPageList(pspr.PrintPages,pspr.PrintPagesList);

                if IsChecked(IDC_PAGESLIST) then
                  pspr.PrintPagesMode:=ppmPagesList
                else
                  if IsChecked(IDC_ALL) then
                    pspr.PrintPagesMode:=ppmAll
                  else
                    if IsChecked(IDC_PAGES) then
                      pspr.PrintPagesMode:=ppmPagesRange;
              end;
          end
        else
          case WParam shr 16 of
            BN_CLICKED :
              begin
                CtrlID:=GetDlgCtrlID(LParam);
                case CtrlID of
                  IDC_PAPERPAGE:
                    begin
                      UnCheck([IDC_PAPERRULON,IDC_RULONALLLINES,IDC_RULONLINESRANGE]);
                      Check([IDC_PAPERPAGE]);
                    end;
                  IDC_PAPERRULON:
                    begin
                      UnCheck([IDC_PAPERPAGE,IDC_ALL,IDC_PAGES,IDC_SELECTION,IDC_PAGESLIST]);
                      Check([IDC_PAPERRULON]);
                    end;
                  IDC_RULONALLLINES:
                    begin
                      UnCheck([IDC_PAPERPAGE,IDC_RULONLINESRANGE,IDC_ALL,IDC_PAGES,IDC_SELECTION,IDC_PAGESLIST]);
                      Check([IDC_PAPERRULON,IDC_RULONALLLINES]);
                    end;
                  IDC_RULONLINESRANGE:
                    begin
                      UnCheck([IDC_PAPERPAGE,IDC_RULONALLLINES,IDC_ALL,IDC_PAGES,IDC_SELECTION,IDC_PAGESLIST]);
                      Check([IDC_PAPERRULON,IDC_RULONLINESRANGE]);

                      SetFocus(GetDlgItem(Wnd,IDC_LINESFROM));
                    end;
                  IDC_PAGESLIST:
                    begin
                      UnCheck([IDC_PAPERRULON,IDC_RULONALLLINES,IDC_RULONLINESRANGE,IDC_ALL,IDC_PAGES,IDC_SELECTION]);
                      Check([IDC_PAPERPAGE,IDC_PAGESLIST]);

                      SetFocus(GetDlgItem(Wnd,IDC_EDITPAGESLIST));
                      Result:=1;
                    end;
                  IDC_ALL,IDC_PAGES,IDC_SELECTION:
                    begin
                      UnCheck([IDC_PAPERRULON,IDC_PAGESLIST,IDC_RULONALLLINES,IDC_RULONLINESRANGE]);
                      Check([IDC_PAPERPAGE]);
                    end;
                end;
              end;
            EN_CHANGE:
              begin
                case GetDlgCtrlID(lParam) of
                  IDC_EDITPAGESLIST:
                    begin
                      UnCheck([IDC_PAPERRULON,IDC_RULONALLLINES,IDC_RULONLINESRANGE,IDC_ALL,IDC_PAGES,IDC_SELECTION]);
                      Check([IDC_PAPERPAGE,IDC_PAGESLIST]);
                    end;
                  IDC_FROMPAGE,IDC_TOPAGE:
                    begin
                      UnCheck([IDC_PAPERRULON,IDC_RULONALLLINES,IDC_RULONLINESRANGE,IDC_ALL,IDC_SELECTION]);
                      Check([IDC_PAPERPAGE]);
                    end;
                  IDC_LINESFROM,IDC_LINESTO:
                    begin
                      UnCheck([IDC_PAPERPAGE,IDC_RULONALLLINES,IDC_ALL,IDC_PAGES,IDC_SELECTION,IDC_PAGESLIST]);
                      Check([IDC_PAPERRULON,IDC_RULONLINESRANGE]);
                    end;
                end;
              end;
            CBN_SELCHANGE:
              begin
                case GetDlgCtrlID(lParam) of
                  IDC_PRINTERS:
                    begin
                      Min := SendDlgItemMessage(Wnd,IDC_PRINTERS,CB_GETCURSEL,0,0);
                      if Min<>CB_ERR then
                        begin
                          TextLength := SendDlgItemMessage(Wnd,IDC_PRINTERS,CB_GETLBTEXTLEN,Min,0)+1;
                          Buf := MakeStr(' ',TextLength);
                          if SendDlgItemMessage(Wnd,IDC_PRINTERS,CB_GETLBTEXT,Min,integer(@(Buf[1])))<>CB_ERR then
                            begin
                              ESCModel := TxReportOptions.FindESCModelByDriverName(Buf);
                              if ESCModel<>nil then
                                SendDlgItemMessage(Wnd,IDC_ESCMODEL,CB_SELECTSTRING,0,integer(PChar(ESCModel.ModelName)))
                              else
                                SendDlgItemMessage(Wnd,IDC_ESCMODEL,CB_SETCURSEL,-1,0)
                            end;
                        end;
                    end;
                end;
              end;
          end;
      end;
    end;
end;
end;

function TprTxReportOptions.TxSetupPrintParams;
var
  pd : tagPDA;
  spr : rSetupPrintParams;
begin
spr.MaxLines := MaxLines;
spr.PrintPagesMode := PrintPagesMode;
spr.ESCModelName := ESCModelName;
spr.PrinterName := PrinterName;
spr.UseLinesOnPage := UseLinesOnPage;
spr.WrapAfterColumn := WrapAfterColumn;
spr.MakeFormFeedOnRulon := MakeFormFeedOnRulon;
spr.LeftSpaces := LeftSpaces;
spr.PrintRulonMode := PrintRulonMode;
spr.FromLine := FromLine;
spr.ToLine := ToLine;
spr.PrintPages := PrintPages;
spr.PrintPagesList := PrintPagesList;
spr.PaperType := PaperType;
spr.LinesOnPage := LinesOnPage;

ZeroMemory(@pd,sizeof(pd));
pd.hWndOwner := hWndOwner;
pd.lStructSize := sizeof(pd);
pd.hInstance := SysInit.hInstance;
pd.lpPrintTemplateName :=PChar(IDD_PRINTTEMPLATE);
pd.nCopies := Copies;
if pd.nCopies=0 then
  pd.nCopies := 1;
pd.nMinPage := 1;
pd.nMaxPage := MaxPage;
pd.nFromPage := FromPage;
if pd.nFromPage=0 then
  pd.nFromPage := 1;
pd.nToPage := ToPage;
if pd.nToPage>MaxPage then
  pd.nToPage := MaxPage;
if pd.nToPage=0 then
  pd.nToPage := 1;
pd.lCustData := integer(@spr);
pd.lpfnPrintHook := @DialogHook;
pd.Flags := PD_HIDEPRINTTOFILE or PD_NONETWORKBUTTON or
            PD_ENABLEPRINTHOOK or PD_NOSELECTION or
            PD_ENABLEPRINTTEMPLATE;
case PrintPagesMode of
  ppmAll : pd.Flags := pd.Flags+PD_ALLPAGES;
  ppmPagesRange : pd.Flags := pd.Flags+PD_PAGENUMS;
end;

Result := PrintDlg(pd);
if Result then
  begin
    Copies := pd.nCopies;
    FromPage := pd.nFromPage;
    ToPage := pd.nToPage;

    PrintPagesMode := spr.PrintPagesMode;
    ESCModelName := spr.ESCModelName;
    PrinterName := spr.PrinterName;
    UseLinesOnPage := spr.UseLinesOnPage;
    WrapAfterColumn := spr.WrapAfterColumn;
    MakeFormFeedOnRulon := spr.MakeFormFeedOnRulon;
    LeftSpaces := spr.LeftSpaces;
    PrintRulonMode := spr.PrintRulonMode;
    FromLine := spr.FromLine;
    ToLine := spr.ToLine;
    PrintPages := spr.PrintPages;
    PaperType := spr.PaperType;
    LinesOnPage := spr.LinesOnPage;
  end;
end;

procedure TprTxReportOptions.LoadFromFile(const FileName : string);
const
  sTxIniTxCommandsSectionName = 'TxCommands';
  sTxIniTxFontStylesSectionName = 'TxFontStyles';
  sTxIniTxFontOptionsSectionName = 'TxFontOptions';
  sTxIniGeneralSection = 'General';

  sTxIniErrorInvalidSymbol = 'Symbol code for TxCommand [%s] not defined or invalid';
  sTxIniErrorTxCommandNotFoundForFontStyle = 'TxCommand [%s] in FontStyle [%s] not found';
  sTxIniErrorTxCommandNotFoundForFontOption = 'TxCommand [%s] in FontOption [%s] not found';
  sTxIniErrorTxCommandNotFoundForESCModel = 'TxCommand [%s] in ESCModel [%s] not found';
  sTxIniErrorInvalidRealESCCommand = 'Invalid real ESC command in ESCModel [%s] for TxCommand [%s]';
  sTxIniErrorInvalidTableForRecodeTable = 'Invalid table for RecodeTable [%s]';
  sTxIniErrorInvalidLengthTableForRecodeTable = 'Length of table for RecodeTable [%s] must be 128';
var
  ini : TIniFile;
  ESCModel : TprESCModel;
  FontStyle : TprTxFontStyle;
  FontOption : TprTxFontOption;
  RecodeTable : TprTxRecodeTable;
  i,j,k,eCode : integer;
  l,lSections : TStringList;
  ESCModelItem : TprESCModelItem;
  Name,Value,RealESCCommand : string;
  TxCommand,TxCommandOn,TxCommandOff : TprTxCommand;

  function GetTxCommand(const ErrorMessage : string) : TprTxCommand;
  var
    Buf : string;
  begin
  Buf := ExtractSubStr(Value,k,[',']);
  Result := FindTxCommand(Buf);
  if Result=nil then
    raise Exception.CreateFmt(ErrorMessage,[Buf,Name]);
  end;

  function CodesToString(const CodesString,ErrorMessage : string) : string;
  var
    i,j : integer;
  begin
  Result := '';
  i := Length(CodesString);
  while i>0 do
    begin
      j := i;
      while (i>0) and (CodesString[i]<>'#') do Dec(i);
      val(Copy(CodesString,i+1,j-i),j,eCode);
      if (eCode<>0) or (j<0) or (j>255) then
        raise Exception.Create(ErrorMessage);
      Result := char(j)+Result;
      Dec(i);
    end;
  end;

begin
ini := TIniFile.Create(FileName);
l := TStringList.Create;
lSections := TStringList.Create;
try
  ini.ReadSectionValues(sTxIniTxCommandsSectionName,l);
  for i:=0 to l.Count-1 do
    begin
      Name := l.Names[i];
      Value := l.Values[Name];
      j := 1;
      while (j<=Length(Value)) and (Value[j] in ['0'..'9']) do Inc(j);
      val(Copy(Value,1,j-1),k,eCode);
      if (eCode<>0) or (j<0) or (j>255) then
        raise Exception.CreateFmt(sTxIniErrorInvalidSymbol,[Name]);

      TxCommand := TprTxCommand.Create;
      TxCommand.FName := Name;
      TxCommand.FSymbol := char(k);
      TxCommand.FDescription := Trim(Copy(Value,j,Length(Value)));
      FTxCommands.Add(TxCommand);
    end;

  l.Clear;
  ini.ReadSectionValues(sTxIniTxFontStylesSectionName,l);
  for i:=0 to l.Count-1 do
    begin
      Name := l.Names[i];
      Value := l.Values[Name];
      k := 1;
      TxCommand := GetTxCommand(sTxIniErrorTxCommandNotFoundForFontStyle);

      FontStyle := TprTxFontStyle.Create;
      FontStyle.FName := Name;
      FontStyle.FTxCommand := TxCommand;
      FontStyle.FDescription := Trim(Copy(Value,k,Length(Value)));
      FTxFontStyles.Add(FontStyle);
    end;

  l.Clear;
  ini.ReadSectionValues(sTxIniTxFontOptionsSectionName,l);
  for i:=0 to l.Count-1 do
    begin
      Name := l.Names[i];
      Value := l.Values[Name];

      k := 1;
      TxCommandOn := GetTxCommand(sTxIniErrorTxCommandNotFoundForFontOption);
      TxCommandOff := GetTxCommand(sTxIniErrorTxCommandNotFoundForFontOption);

      FontOption := TprTxFontOption.Create;
      FontOption.FName := Name;
      FontOption.FTxCommandOn := TxCommandOn;
      FontOption.FTxCommandOff := TxCommandOff;
      FontOption.FDescription := Trim(Copy(Value,k,Length(Value)));
      FTxFontOptions.Add(FontOption);
    end;

  ini.ReadSections(lSections);
  for i:=0 to lSections.Count-1 do
    begin
      if AnsiCompareText(Copy(lSections[i],1,9),'ESCModel_')=0 then
        begin
          ESCModel := TprESCModel.Create;
          try
            ESCModel.FModelName := ini.ReadString(lSections[i],'ModelName',lSections[i]);
            ESCModel.FPrinterDriver := ini.ReadString(lSections[i],'PrinterDriver','');
            l.Clear;
            ini.ReadSectionValues(lSections[i],l);
            for j:=0 to l.Count-1 do
              begin
                Name := l.Names[j];
                if (AnsiCompareText(Name,'ModelName')=0) or (AnsiCompareText(Name,'PrinterDriver')=0) then
                  continue;
                TxCommand := FindTxCommand(Name);
                if TxCommand=nil then
                  raise Exception.CreateFmt(sTxIniErrorTxCommandNotFoundForESCModel,[Name,ESCModel.ModelName]);
                RealESCCommand := CodesToString(l.Values[Name],Format(sTxIniErrorInvalidRealESCCommand,[ESCModel.ModelName,TxCommand.Name]));
                if RealESCCommand<>'' then
                  begin
                    ESCModelItem := TprESCModelItem.Create;
                    ESCModelItem.FTxCommand := TxCommand;
                    ESCModelItem.FESCCommand := RealESCCommand;
                    ESCModel.FESCs.Add(ESCModelItem);
                  end;
              end;
          except
            ESCModel.Free;
            raise;
          end;
          FESCModels.Add(ESCModel);
        end
      else
        if AnsiCompareText(Copy(lSections[i],1,12),'RecodeTable_')=0 then
          begin
            Value := CodesToString(ini.ReadString(lSections[i],'OEMtoWINTable',''),Format(sTxIniErrorInvalidTableForRecodeTable,[lSections[i]]));
            if Length(Value)<>128 then
              raise Exception.CreateFmt(sTxIniErrorInvalidLengthTableForRecodeTable,[lSections[i]]);
            RecodeTable := TprTxRecodeTable.Create;
            RecodeTable.FRecodeTableName := Copy(lSections[i],13,Length(lSections[i]));
            RecodeTable.FDescription := ini.ReadString(lSections[i],'Description',RecodeTable.RecodeTableName);
            MoveMemory(RecodeTable.OEMtoWINTable,@Value[1],128);
            // build WINtoOEMTable
            for j:=128 to 255 do
              begin
                k := 0;
                while (k<128) and (RecodeTable.FOEMtoWINTable[k]<>char(j)) do Inc(k);
                if k<128 then
                  RecodeTable.FWINtoOEMTable[j-128] := char(k+128)
                else
                  RecodeTable.FWINtoOEMTable[j-128] := #32;
              end;
            FRecodeTables.Add(RecodeTable);
          end;
    end;

  FDefaultRecodeTable := FindRecodeTable(ini.ReadString(sTxIniGeneralSection,'DefaultRecodeTable',''));
finally
  ini.Free;
  l.Free;
  lSections.Free;
end;
end;

procedure TprTxReportOptions.LoadFromRes;
begin
end;

initialization

prTxReportOptionsFileName := GetFindFileName(_sTxReportOptionsFileName);
TxReportOptions := TprTxReportOptions.Create;
TxReportOptions.LoadFromFile(prTxReportOptionsFileName);

finalization

TxReportOptions.Free;

end.


