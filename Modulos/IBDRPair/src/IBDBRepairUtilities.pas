(*************************************************************************
IBDBRepair - Interbase Database Repair Utility
Copyright (C) 2003  DRB Systems Inc., Brenden K. Walker

This file is part of IBDBRepair

    IBDBRepair is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    IBDBRepair is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with IBDBRepair; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


Contact Information

  Primary Programmer: Brenden K. Walker (bkwalker@drbsystems.com)

  Brenden Walker
  DRB Systems, Inc.
  3245 Pickle Road
  Akron, OH   44312-5333

 *************************************************************************)
unit IBDBRepairUtilities;

interface

uses
  Windows, ExtCtrls, StdCtrls, SysUtils,
  // IBX units
  IBSQL, IBHeader;

type
  TLogOutputType   = (toBoth, toDisplay, toFile, toUpdateLine, toUpdateLineOnly);

const
  DEFAULT_LOG_TYPE = toBoth;

type
  TLogFile = class
  private
    LLastWasUpdateLine: Boolean;
    FMemo  : TMemo;
  public
    constructor Create;
    destructor  Destroy; override;
  protected
    LFile    : TextFile;
    FFileName: String;
    FOpened  : Boolean;
    FCount   : Integer;
    procedure Open;                                      virtual;
    procedure Close;                                     virtual;
    function  FmtLine(Msg: String): String;              virtual;
    procedure AddFileLine(Msg: String);                  virtual;
    procedure AddFileHeader;                             virtual;
    procedure AddToFile(Msg: String);                    virtual;
    procedure AddToMemo(Msg: String; SameLine: Boolean); virtual;
  public
    {Methods}
    procedure StartNewLine; virtual;
    procedure ResetCount;   virtual;
    procedure AddLog(Msg: String; OutputType: TLogOutputType = DEFAULT_LOG_TYPE); virtual;
    {Properties}
    property  Opened  : Boolean read FOpened;
    property  FileName: String  read FFileName write FFileName;
    property  Count   : Integer read FCount;
    property  Memo    : TMemo   read FMemo     write FMemo;
  end; // tlogfile

procedure SetIBXParam(Param, Field: TIBXSQLVAR);
function HDSpace(DriveLetter: Char): Int64;
function HDSpaceAvailable(DriveLetter: Char; MinBytesReq: Int64): Boolean;
function GetDatabaseSize(Path: String): Int64;
function MemSizeToStr(Size :Int64): String;

implementation

uses IBRepairSupport;

const
  DEFAULT_FLUSH_FREQUENCY = 5000;  // Flush file every 5 Seconds of inactivity

{******************************************************************************
  SetIBXParam
  Sets IBX param; uses Value for everything except Blobs.
  Blobs get copied as a String which should work in most cases.  Caller needs
  to be sure this is what is needed.
  ASSUMES:  Caller checks to make sure Param and Field are assigned, etc.
 ******************************************************************************}
procedure SetIBXParam(Param, Field: TIBXSQLVAR);
begin // SetIBXParam
  if (Field.IsNull)
  then Param.Clear
  else begin
    if (Param.SQLType = SQL_BLOB)
    then Param.AsString := Field.AsString
    else Param.Value := Field.Value;
  end;
end;  // SetIBXParam


function HDSpace(DriveLetter: Char): Int64;
var
  DriveNum: Byte;
begin // HDSpace
  // The drive numbers are 1 based - so A = 1, B = 2, etc.
  DriveNum  := (ord(UpCase(DriveLetter)) - ord('A') + 1);
  if ((DriveNum >= 1 {A}) and (DriveNum <= 26 {Z}))
  then Result := DiskFree(DriveNum)
  else Result := 0;
end;  // HDSpace

function HDSpaceAvailable(DriveLetter: Char; MinBytesReq: Int64): Boolean;
var
  FreeBytes: Int64;
begin // HDSpaceAvailable
  FreeBytes := HDSpace(DriveLetter);
  Result := (FreeBytes >= MinBytesReq);
end;  // HDSpaceAvailable

function GetDatabaseSize(Path: String): Int64;
var
  SR: TSearchRec;
  PathOnly: String;

begin // GetDatabaseSize
  //Old Database Size - look for all files
  Result := 0;
  PathOnly := ExtractFilePath(Path);
  if (FindFirst(ChangeFileExt(Path, '.G*'), faAnyFile, SR) = 0)
  then begin
    repeat
      if (Pos('.GBK', UpperCase(SR.Name)) = 0)
      then Result := Result +  (Int64FileSize(PathOnly + '\' + SR.Name));
    until (FindNext(SR) <> 0);
    SysUtils.FindClose(SR);  //deallocate memory
  end;
end;  // GetDatabaseSize

function MemSizeToStr(Size :Int64): String;
var
  xValue : Double;
begin // MemSizeToStr
  if (Size = 0)
  then Result := ''
  else if (Abs(Size) >= (1024*1024))
  then begin
    xValue := Size / (1024*1024);
    if (Abs(xValue) >= 1024)
    then Result := FormatFloat('0.0', xValue / 1024) + 'GB'
    else Result := FormatFloat('0.0', xValue) + 'MB'
  end
  else if (Abs(Size) >= 1024)
  then Result := FormatFloat('0.0', Size / 1024) + 'KB'
  else Result := FormatFloat('0',Size) + 'B'
end;  // MemSizeToStr


{*****************************************************************************
  tlogfile
 *****************************************************************************}
{*****************************************************************************
  Obejct Construction/Destruction
 *****************************************************************************}
{*****************************************************************************
  Create
 *****************************************************************************}
constructor tlogfile.Create;
begin // Create
  inherited;
  LLastWasUpdateLine := FALSE;
  FOpened   := FALSE;
  FFileName := '';
  FMemo     := NIL;
end;  // Create

{*****************************************************************************
  Destroy
 *****************************************************************************}
destructor  tlogfile.Destroy;
begin // Destroy
  if (Opened)
  then Close;
  inherited;
end;  // Destroy



{*****************************************************************************
  Protected Methods
 *****************************************************************************}
{*****************************************************************************
  Open
  Open existing file and append, or create a new log file
 *****************************************************************************}
procedure tlogfile.Open;
begin // Open
  if (not Opened)
  then begin
    AssignFile(LFile, FFileName);
    if (FileExists(FFileName))
    then Append(LFile)
    else begin
      ReWrite(LFile);
      AddFileHeader;
    end;
    FOpened := TRUE;
  end;
end;  // Open

{*****************************************************************************
  Close
 *****************************************************************************}
procedure   tlogfile.Close;
begin // Close
  if (Opened)
  then begin
    CloseFile(LFile);
    FOpened := FALSE;
  end;
end;  // Close

{*****************************************************************************
  FmtLine
 *****************************************************************************}
function    tlogfile.FmtLine(Msg: String): String;
begin // FmtLine
  Result  := FormatDateTime('mmm/dd/yyyy hh:nn:ss.zzz', Now) + '  ' + Msg;
end;  // FmtLine

{*****************************************************************************
  AddFileLine
 *****************************************************************************}
procedure   tlogfile.AddFileLine(Msg: String);
begin // AddFileLine
  Writeln(LFile, FmtLine(Msg));
  Inc(FCount);
end;  // AddFileLine

{*****************************************************************************
  AddFileHeader
 *****************************************************************************}
procedure   tlogfile.AddFileHeader;
begin // AddFileHeader
  Writeln(LFile, 'Date        Time          Message');
  AddFileLine('Log File Created.');
end;  // AddFileHeader

{*****************************************************************************
  AddToFile
 *****************************************************************************}
procedure   tlogfile.AddToFile(Msg: String);
begin // AddToFile
  Open;
  AddFileLine(Msg);
  Close;
end;  // AddToFile

{*****************************************************************************
  AddToMemo
 *****************************************************************************}
procedure tlogfile.AddToMemo(Msg: String; SameLine: Boolean);
begin // AddToMemo
  if (Assigned(FMemo))
  then begin
    if (SameLine)
    then FMemo.Lines[FMemo.Lines.Count - 1] := FmtLine(Msg)
    else FMemo.Lines.Add(FmtLine(Msg));
    FMemo.ScrollBy(-4096, 0); //Make sure the memo area is scrolled to the far-left
  end;
end;  // AddToMemo



{*****************************************************************************
  public
 *****************************************************************************}
{*****************************************************************************
  StartNewLine
 *****************************************************************************}
procedure tlogfile.StartNewLine;
begin // StartNewLine
  LLastWasUpdateLine := FALSE;
end;  // StartNewLine

{*****************************************************************************
  ResetCount
 *****************************************************************************}
procedure tlogfile.ResetCount;
begin // ResetCount
  FCount := 0;
end;  // ResetCount

{*****************************************************************************
  AddLog
 *****************************************************************************}
procedure tlogfile.AddLog(Msg: String; OutputType: TLogOutputType = DEFAULT_LOG_TYPE);
begin // AddLog
  //If not updating the same line or not just writing to the file
  if (not (OutputType in [toUpdateLine, toUpdateLineOnly, toFile]))
  then LLastWasUpdateLine := FALSE;

  //Add to the log file if not a display only message
  if (OutputType in [toBoth, toFile, toUpdateLine]) 
  then AddToFile(Msg);

  if (Assigned(FMemo))
  then begin
    //Add to Progress display
    if (OutputType in [toBoth, toDisplay])
    then AddToMemo(Msg, FALSE)
    //Replace the last line in the memo with this one and log to file
    else if (OutputType in [toUpdateLine, toUpdateLineOnly])
    then begin
      //NOTE: If the memo's WordWrap is turned on, "toUpdateLine" function will
      //not operate correctly.
      AddToMemo(Msg, LLastWasUpdateLine);
      LLastWasUpdateLine := TRUE;
    end;

  end;
end;  // AddLog




end.

