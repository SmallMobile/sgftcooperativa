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

  Project Descriptive Name:  InterBase Database Repair Utility
  Project Unix Name:  ibdbrepair
  CVS Server:         cvs.ibdbrepair.sourceforge.net
  Shell/Web Server:   ibdbrepair.sourceforge.net

  Brenden Walker
  DRB Systems, Inc.
  3245 Pickle Road
  Akron, OH   44312-5333

 *************************************************************************)
unit IBRepairSupport;

interface

uses
  Db, IBDatabase, IBQuery, Sysutils, DBLogDlg, DosCommand,
  IBDBRepairUtilities, Classes,
  Forms, Controls, Windows, Registry, Dialogs, IBSQL;

const
  EXT_TABLE_NAME = 'EXT_SOURCE';

type
  // dpSkip: Don't copy this table
  // dpExternal: use external tables, only valid if there are no blob fields
  // dpRecord: safest and slowest, only way to copy tables with blobs.
  tDataCopyType = (dcSkip, dcExternal, dcRecord);
  // dhFlush: flush entire table prior to copying data
  // dhIgnore: skip any duplicate records, ie: do nothing
  // dhOverwrite: Duplicates are overwritten. Only works on RecordCopy.
  tDuplicateHandling = (dhFlush, dhIgnore, dhOverwrite);

  TDatabaseInfo = class(TObject)
  private
    ldb: TIBDatabase;
    lTran: TIBTransaction;
    lQuery: TIBQuery;
    lIBBinPath: String;
    lFinished : Boolean;
    fTableList: TStringList;
    lBuildingDatabase: Boolean;
    fPath: String;
    fUserName: String;
    fPassword: String;
    fIsLocal: Boolean;
    fDBExists: Boolean;
    fMetaData: TStringList;
    fLogFile: TLogFile;
    fTempPath: String;
    fUseFirebird: Boolean; // True = use FB engine
    lCurrentMetadataProcess: String;
    procedure SetPath(InPath: String);
    procedure SetUseFirebird(InUseFirebird: Boolean);
    procedure DosCommandTerminated(Sender: TObject);
    procedure DosCommandNewLine(Sender: TObject; NewLine: string;
                                OutputType: TOutputType);
    procedure Log(Msg: String; OutputType: TLogOutputType = DEFAULT_LOG_TYPE);
  public
    property Path : string read FPath write SetPath;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
    property IsLocal: boolean read FIsLocal;
    property DBExists: boolean read FDBExists;
    property MetaData: TStringList read FMetaData;
    property LogFile: TLogFile read FLogFile write FLogFile;
    property TempPath: string read fTempPath write fTempPath;
    property TableList: TStringList read fTableList write fTableList;
    property Database: TIBDatabase read lDB;
    property UseFirebird: boolean read fUseFirebird write SetUseFirebird;
    procedure ConnectDB;
    procedure DisconnectDB;
    procedure LoadMetadata;
    procedure PutMetaData;
    procedure LoadTableInformation(DestDBInfo: TDatabaseInfo);
    procedure DisableAllTriggers;
    procedure EnableAllTriggers;
    function GetUserInfo: Boolean;
    function TestConnection : Boolean;
    constructor Create;
    destructor Destroy; override;
  end;


  TTableInfo = class(TObject)
  private
    fKeyFields: TStringList;
    fIntKey: String;
    fMaxIntKey : Integer;
    fMinIntKey : Integer;
//    fDensity   : Integer;
    fTableName: String;
    fRecordCount: Integer;
    fRecordSize: Integer;
    fHasBlobs: Boolean;     // any blobs make it impossible to use external copy
    fNullNumerics: Boolean; // Numeric fields with nulls allowed
    fLogFile: TLogFile;
    fCopyType: tDataCopyType;
    fDupHandling: tDuplicateHandling;
    fExportWhereClause: String;
    fDatabasesLocal: Boolean;
    fSourceFields: String;
    fImportFields: String;
    fDestParams: String;
    fCreateFields: String;
    fExtFileName: String;
    fTempPath: String;
    {$IFDEF STATS}
    fBytesPerMin: Double;
    fCopyElapsed: Int64;
    {$ENDIF}
    procedure Log(Msg: String; OutputType: TLogOutputType = DEFAULT_LOG_TYPE);
    procedure SetCopyType(InType: tDataCopyType);
    procedure SetDupHandling(InType: tDuplicateHandling);
    function GetExtTableCreateQuery: String;
  public
    property TempPath: string read fTempPath write fTempPath;
    property KeyFields: tStringList read fKeyFields;
    property IntKey: String read fIntKey;
    property MaxIntKey: Integer read fMaxIntKey;
    property MinIntKey: Integer read fMinIntKey;
//    property IntKeyDensity: Integer read fDensity;

    property LogFile: TLogFile read fLogFile write fLogFile;
    property CopyType: tDataCopyType read fCopyType write SetCopyType;
    property DupHandling: tDuplicateHandling read fDupHandling write SetDupHandling;
    property TableName: String read fTableName;
    property RecordCount: integer read fRecordCount;
    property RecordSize: Integer read fRecordSize;
    property HasBlobs: Boolean read fHasBlobs;
    property DatabasesLocal: Boolean read fDatabasesLocal write fDatabasesLocal;
    property ExtFileName: String read fExtFileName;

    property ExportWhere: String read fExportWhereClause;
    property ExtTableCreateQuery: String read GetExtTableCreateQuery;
    property SourceFields: String read fSourceFields;
    property ImportFields: String read fImportFields;
    property DestParams:   String read fDestParams;
    property CreateFields: String read fCreateFields;

    {$IFDEF STATS}
    property BytesPerMin: Double read fBytesPerMin write fBytesPerMin;
    property Elapsed: Int64 read fCopyElapsed write fCopyElapsed;
    {$ENDIF}
    function GetMostDeviantIntKey(DB: TIBDatabase): String;
    function Load(TableName: String;DB: TIBDatabase): Boolean;
    procedure SetExportWhere(InExportWhere: String;DB: TIBDatabase);
    constructor Create;
    destructor Destroy; override;
  end;


Function Int64FileSize(fn: string) : Int64;

implementation


Function Int64FileSize(fn: string) : Int64;
var
  FileHandle: Integer;
  LoDWord, HiDWord: DWord;

begin
  FileHandle := FileOpen(fn, fmOpenRead + fmShareDenyNone);
  if (FileHandle = -1) then Raise Exception.Create('Unable to open file: ' + fn);
  LoDWord := GetFileSize(THandle(FileHandle), @HiDWord);
  Result := LoDWord + (HiDWord shl (4 * 8));
  FileClose(FileHandle);
end;

{******************************************************************************
  SetExportWhere

  This routine re-queries for a record count based on the export where values
  passed in, any exception would indicate the clause is incorrect.

  Requires a database, so it's a simple procedure instead of a property write
  routine.
 ******************************************************************************}
procedure TTableInfo.SetExportWhere(InExportWhere: String;DB: TIBDatabase);
var
  lQuery: TIBQuery;
begin // SetExportWhere
  InExportWhere := Trim(InExportWhere);
  Log('Setting Export Where for ' + '"' + TableName + '"' + ' (' + InExportWhere + ')');
  if (InExportWhere <> fExportWhereClause)
  then begin
    lQuery := TIBQuery.Create(nil);
    try
      Log('  -Getting Record Count', toUpdateLineOnly);
      lQuery.Database := DB;
      if (InExportWhere <> '')
      then lQuery.SQL.Text := 'select count(*) from ' + '"' + fTableName + '"' + ' where ' + InExportWhere
      else lQuery.SQL.Text := 'select count(*) from ' + '"' + fTableName + '"';
      lQuery.Open;
      fRecordCount := lQuery.Fields[0].AsInteger;
      lQuery.Close;
      Log('  -Getting Record Count: ' + IntToStr(fRecordCount), toUpdateLine);
      fExportWhereClause := InExportWhere;
    finally
      FreeAndNil(lQuery);
    end;
  end;
end;  // SetExportWhere

{******************************************************************************
  GetMostDeviantIntKey

  In order for the 'batch copy' routines to best break up the external files
  (if necessary) we must get the integer key field that contains the largest
  variance in min/max values.

  This can be time consuming, so it must be called directly.
 ******************************************************************************}
function TTableInfo.GetMostDeviantIntKey(DB: TIBDatabase): String;
var
  lQuery: TIBQuery;
  sqlWork: TIBSQL;
  CurrField: String;
  Loop,
  CurrMin,
  CurrMax: Integer;

begin
  if (fIntKey = '') and (fKeyFields.CommaText <> '') // Only do this once, it's expensive!
  then begin
    lQuery := TIBQuery.Create(nil);
    sqlWork := TIBSQL.Create(nil);
    try
      lQuery.Database := DB;
      sqlWork.Database := DB;
      lQuery.SQL.Text := 'select ' + fKeyFields.CommaText + ' from ' + '"' + fTableName + '"';
      lQuery.Open;
      for Loop := 0 to (lQuery.Fields.Count - 1)
      do begin    // Iterate
        if (lQuery.Fields[Loop].DataType in [ftSmallInt, ftInteger])
        then begin
          CurrField := lQuery.Fields[Loop].FieldName;
          sqlWork.SQL.Text := 'select min(' + CurrField + ') from ' + '"' + fTableName + '"';
          Log('    | Getting Min(' + CurrField + ')', toBoth);
          sqlWork.ExecQuery;
          CurrMin := sqlWork.Fields[0].AsInteger;
          Log('    |         Min(' + CurrField + ') : ' + IntToStr(CurrMin), toBoth);

          sqlWork.Close;
          sqlWork.SQL.Text := 'select max(' + CurrField + ') from ' + '"' + fTableName + '"';
          Log('    | Getting Max(' + CurrField + ')', toBoth);
          sqlWork.ExecQuery;
          CurrMax := sqlWork.Fields[0].AsInteger;
          Log('    |         Max(' + CurrField + ') : ' + IntToStr(CurrMax), toBoth);
          sqlWork.Close;
          if ((CurrMax - CurrMin) > (fMaxIntKey - fMinIntKey))
          then begin
            // the Density value lets us know how many possible records there
            // are per 'most deviant int key' value.
            if (fIntKey <> '')
            then begin
(*              Log('    | Getting Count(' + fIntKey + ')', toBoth);
              sqlWork.SQL.Text := 'select distinct ' + fIntKey + ' from ' + '"' + fTableName + '"';
              sqlWork.ExecQuery;
              while (not sqlWork.Eof) do sqlWork.Next;
              Log('    |         Count(' + fIntKey + ') : ' + IntToStr(sqlWork.RecordCount), toBoth);
              if (sqlWork.RecordCount > 0)
              then fDensity := fDensity * (sqlWork.RecordCount);
              sqlWork.Close;*)
            end;
            fMaxIntKey := CurrMax;
            fMinIntKey := CurrMin;
            fIntKey := CurrField;
          end
          else begin
(*
            // Currfield isn't 'more deviant' than fIntKey, multiply into Density
            if (CurrField <> '') and (fIntKey <> '')
            then begin
              Log('    | Getting Count(' + CurrField + ')', toBoth);
              sqlWork.SQL.Text := 'select distinct ' + CurrField + ' from ' + '"' + fTableName + '"';
              sqlWork.ExecQuery;
              while (not sqlWork.Eof) do sqlWork.Next;
              Log('    |         Count(' + CurrField + ') : ' + IntToStr(sqlWork.RecordCount), toBoth);
              if (sqlWork.RecordCount > 0)
              then fDensity := fDensity * (sqlWork.RecordCount);
              sqlWork.Close;
            end;            *)
          end;
        end;
      end; //for
    finally
      FreeAndNil(lQuery);
      FreeAndNil(sqlWork);
    end;
  end;
  Result := fIntKey;
end; // GetMostDeviantIntKey

{******************************************************************************
  GetExtTableCreateQuery
 ******************************************************************************}
function TTableInfo.GetExtTableCreateQuery: String;

  {******************************************************************************
    GetExternalFileName (GetExtTableCreateQuery)
    Attempt to create a X00 to X99 temp file, if it is not able to, raises
    Exception
   ******************************************************************************}
  function GetExternalFileName: String;
  var
    Loop: Integer;
  begin // GetExternalFileName (GetExtTableCreateQuery)
    Result := fTempPath + 'EXTCOPY.X00';
    Loop := 0;
    while (FileExists(Result)) and (Loop < 99)
    do begin
      Inc(Loop);
      // Using IntToHex as it handles padding to 2 spaces, and
      // would allow us to go up to 255 MAX_FILE_NUM
      Result := ChangeFileExt(Result, '.X' + IntToHex(Loop, 2));
    end;    // while
    if (FileExists(Result))
    then begin
      Log('GetExternalFileName: Cannot create ' + Result);
      raise Exception.Create('Unable to create temporary file!');
    end;
  end;  // GetExternalFileName (GetExtTableCreateQuery)

begin // GetExtTableCreateQuery
  Result := '';
  if (fCreateFields <> '')
  then begin
    fExtFileName := GetExternalFileName; // need to keep this name around
    Result := 'create table ' + EXT_TABLE_NAME +
              ' external file "' + fExtFileName +
              '" (' + fCreateFields + ')';
  end;
end;  // GetExtTableCreateQuery

{******************************************************************************
  SetDupHandling
 ******************************************************************************}
procedure TTableInfo.SetDupHandling(InType: tDuplicateHandling);
begin // SetDupHandling
  if (InType = dhOverwrite) and (fCopyType = dcExternal)
  then raise exception.create('"' + TableName + '"' + ': Overwriting duplicates is incompatible with External table copying.');
  if (InType = dhOverwrite) and (fKeyFields.Text = '')
  then raise exception.create('"' + TableName + '"' + ': Unable to determine key fields, overwrite is not supported.');
  fDupHandling := InType;
end;  // SetDupHandling

{******************************************************************************
  SetCopyType
 ******************************************************************************}
procedure TTableInfo.SetCopyType(InType: TDataCopyType);
begin // SetCopyType
  //Validate type of datapumping
  if (InType = dcExternal)
  then begin
    if (not fDatabasesLocal)
    then raise exception.Create('"' + fTableName + '"' + ' Source and Dest database must both be local to use External Copy!');
    if (fHasBlobs)
    then raise exception.Create('"' + fTableName + '"' + ' contains BLOB fields, unable to use external copy!');
    {$IFNDEF DSI}
    if (fNullNumerics)
    then ShowMessage('"' + fTableName + '"' + ' has numeric fields that may be null, ' +
     'using external copy will convert any null values into number 0');
    {$ENDIF}
    if (fRecordCount = -1)
    then raise exception.Create('"' + fTableName + '"' + ' appears to have some corruption in it, ' +
                                                'using external copy has been disabled');
  end;
  fCopyType := InType;
end;  // SetCopyType

{******************************************************************************
  Log
 ******************************************************************************}
procedure TTableInfo.Log(Msg: String; OutputType: TLogOutputType = DEFAULT_LOG_TYPE);
begin // Log
  if (Assigned(FLogFile))
  then FLogFile.AddLog(Msg, OutputType);
end;  // Log

{******************************************************************************
  Destroy
 ******************************************************************************}
destructor TTableInfo.Destroy;
begin // Destroy
  FreeAndNil(fKeyFields);
  Inherited Destroy;
end;  // Destroy

{******************************************************************************
  Create
 ******************************************************************************}
constructor TTableInfo.Create;
begin // Create
  Inherited;
  fKeyFields := TStringList.Create;
  fDatabasesLocal := FALSE;
  fRecordCount := -1;
  fRecordSize  := -1;
end;  // Create

{******************************************************************************
  Load
 ******************************************************************************}
function TTableInfo.Load(TableName: String;DB: TIBDatabase): Boolean;
var
  lQuery: TIBQuery;
  CurrField: TField;
  Loop: Integer;
  PrimaryIndexName: String;

begin // Load
  //Safe assumption.
  fCopyType := dcRecord;
  Result := FALSE;
  Log('Loading Information for: ' + '"' + TableName + '"');
  lQuery := TIBQuery.Create(nil);
  try
    fExportWhereClause := '';
    fTableName := TableName;
    lQuery.Database := DB;
    Log('  -Collecting other information');
    lQuery.SQL.Text := 'select * from ' + '"' + fTableName + '"';
    lQuery.Open;
    fRecordSize := 0;
    fNullNumerics := FALSE;
    fHasBlobs := FALSE;
    fSourceFields := '';
    fImportFields := '';
    fDestParams   := '';
    // Get table information
    for Loop := 0 to (lQuery.FieldCount - 1)
    do begin
      CurrField := lQuery.Fields[Loop];
      // Update fSourceFields
      fSourceFields := fSourceFields + ', ' + CurrField.FieldName;

{ TODO : document fact that you must have f_lrtrim in the database! or
  do not allow external copy if f_lrtrim isn't in source database (if it's there
  it should be in the dest as well) }
      // Update ImportFields
      if (CurrField.DataType = ftString)
      then fImportFields := fImportFields + ', f_lrTrim(' + CurrField.FieldName + ')'
      else fImportFields := fImportFields + ', ' + CurrField.FieldName;

      // build dest params
      if (Loop = 0)
      then fDestParams := fDestParams + ':' + CurrField.FieldName
      else fDestParams := fDestParams + ', :' + CurrField.FieldName;

      fRecordSize := fRecordSize + CurrField.DataSize;
      if (CurrField.DataType = ftString)
      then fRecordSize := fRecordSize + 2;
      // Get for blob fields
      if (not fHasBlobs) and
         (CurrField.DataType in [ftBlob, ftMemo])
      then fHasBlobs := TRUE;
      // Null numerics
      if (not fNullNumerics) and
         (not CurrField.Required) and
         (CurrField.DataType in [ftSmallInt, ftInteger, ftFloat])
      then fNullNumerics := TRUE;
    end;
    System.Delete(fSourceFields,1,1);
    System.Delete(fImportFields,1,1);
    fDestParams := '(' + fDestParams + ')';

    // Build create fields, '' means we can't do external copy
    fCreateFields := '';
    for Loop := 0 to (lQuery.Fields.Count - 1)
    do begin    // Iterate
      fCreateFields := fCreateFields + ', ' + lQuery.Fields[Loop].FieldName + ' ';
      // Add datatype to field creation text
      case lQuery.Fields[Loop].DataType of
        ftString  : fCreateFields := fCreateFields + 'char(' + IntToStr(lQuery.Fields[Loop].DataSize - 1) + ')';
        ftDateTime: fCreateFields := fCreateFields + 'date';
        ftSmallInt: fCreateFields := fCreateFields + 'smallint';
        ftInteger : fCreateFields := fCreateFields + 'integer';
        ftFloat   : fCreateFields := fCreateFields + 'double precision';
      else
        fCreateFields := '';
        Break;
      end;    // case
    end; //for
    System.Delete(fCreateFields, 1, 1);  //remove leading ', '


    fRecordSize := fRecordSize + 2; // 2 bytes overhead for each record (roughly)
    Log('  -        Record Size: ' + IntToStr(fRecordSize));

    lQuery.Close;
    lQuery.SQL.Text := 'select RDB$INDEX_NAME from RDB$RELATION_CONSTRAINTS ' +
      'where RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' and RDB$RELATION_NAME = ''' +
      '"' + fTableName + '"' + '''';;
    lQuery.Open;
    if (lQuery.IsEmpty)
    then PrimaryIndexName := ''
    else PrimaryIndexName := Trim(lQuery.Fields[0].AsString);
    lQuery.Close;
    if (PrimaryIndexName <> '')
    then begin
      lQuery.SQL.Text := 'select RDB$FIELD_NAME from RDB$INDEX_SEGMENTS where RDB$INDEX_NAME = ''' +
        PrimaryIndexName + ''' order by RDB$FIELD_POSITION';
      lQuery.Open;
      while (not lQuery.EOF)
      do begin
        fKeyFields.Add(Trim(lQuery.Fields[0].AsString));
        lQuery.Next;
      end;    // while
      lQuery.Close;
    end;

    fIntKey := '';
    fMaxIntKey := 0;
    fMinIntKey := 0;
//    fDensity   := 1;
    fDupHandling := dhIgnore; // default, ignore dups..ie: skip
    // Get record count last, if there is any corruption this is the likely place it'll
    // blow up at.
    try
      Log('  -Getting Record Count', toUpdateLineOnly);
      lQuery.SQL.Text := 'select count(*) from ' + '"' + fTableName + '"';
      lQuery.Open;
      fRecordCount := lQuery.Fields[0].AsInteger;
      lQuery.Close;
      Log('  -Getting Record Count: ' + IntToStr(fRecordCount), toUpdateLine);
      if (fRecordCount = 0)
      then fCopyType := dcSkip; // no sense copying empty table, and if we made it here the count query ran
      Result := TRUE;
    except
      on E:Exception
      do begin
        Log(E.Message + ' (TTableInfo.Load: ' + '"' + TableName + '"' + ')');
      end;
    end;

    if (not fNullNumerics) and (not fHasBlobs) and (fDatabasesLocal) and (not fRecordCount = -1)
    then fCopyType := dcExternal
    else fCopyType := dcRecord;

  finally
    FreeAndNil(lQuery);
  end;
end;  // Load

{******************************************************************************
  RemoveServerName
 ******************************************************************************}
Function RemoveServerName(path: string) : string;
var
  psn: Integer;
  xTemp: String;
begin // RemoveServerName
  psn := Pos(':', Path);
  if (psn > 0)
  then begin
    if (Path[1] = '\') // NetBEUI, remove up to first : minus 1
    then Delete(Path, 1, psn - 2)  //leave the Drive letter and ":"
    else begin                     // Attempt to remove TCP/IP computer name.
      xTemp := Copy(Path,psn + 1,Length(Path));
      psn := Pos(':',xTemp);
      if (psn > 0) // It's definately TCP/IP, we've already removed <computername> + :
      then Path := xTemp;
    end;
  end;
  Result := Path;
end;  // RemoveServerName



{******************************************************************************
  ComputerName
  returns current computer's name
 ******************************************************************************}
function ComputerName: String;
var
  Name: String[MAX_COMPUTERNAME_LENGTH + 1];
  NameLen: DWord;
begin // ComputerName
  NameLen := SizeOf(Name) - 1;
  try
    GetComputerName(@Name[1], NameLen);  //Sets buffer, adjusts NameLen
    SetLength(Name, NameLen);
  except
    Name := '';
    GetLastError;
  end;
  Result := Name;
end;  // ComputerName



{******************************************************************************
  LoadTableInformation
 ******************************************************************************}
procedure TDatabaseInfo.LoadTableInformation(DestDBInfo: TDatabaseInfo);
var
  TableInfo: TTableInfo;

begin // LoadTableInformation
  ConnectDB;
  try
    lQuery.SQL.Text := 'select RDB$RELATION_NAME from rdb$relations where ' +
                       '(not rdb$system_flag = 1) and (rdb$view_source is null)';
    lQuery.Open;
    while (not lQuery.EOF)
    do begin
      Application.ProcessMessages;
      if (fTableList.IndexOf(Trim(lQuery.Fields[0].AsString)) = -1)
      then begin
        TableInfo := TTableInfo.Create;
        TableInfo.DatabasesLocal := (fIsLocal and DestDBInfo.IsLocal);
        TableInfo.LogFile := fLogFile;
        fTableList.AddObject(Trim(lQuery.Fields[0].AsString), TableInfo);
        try
          if (not TableInfo.Load(Trim(lQuery.Fields[0].AsString), ldb))
          then begin
            // Some exception, we need to disconnect the database and re-query!
            DisconnectDB;
            Application.ProcessMessages;
            ConnectDB;
            lQuery.SQL.Text := 'select RDB$RELATION_NAME from rdb$relations where ' +
                               '(not rdb$system_flag = 1) and (rdb$view_source is null)';
            lQuery.Open;
          end;
        except
          on E:Exception
          do begin
            // ignore, we don't want to skip all the others!
            Log(E.Message + ' (TDatabaseInfo.LoadTableInformation: ' + Trim(lQuery.Fields[0].AsString) + ')');
          end;
        end;
        {$IFDEF DSI}
        if TableInfo.RecordCount > 0
        then begin
          if (UpperCase(TableInfo.TableName) = 'SALE') or
             (UpperCase(TableInfo.TableName) = 'SALEITEMS') or
             (UpperCase(TableInfo.TableName) = 'SALEFACTS') or
             (UpperCase(TableInfo.TableName) = 'SALESERVICERS') or
             (UpperCase(TableInfo.TableName) = 'SALEEMPLOYEES')
          then begin
            try
              TableInfo.CopyType := dcExternal;
            except;
            end;
          end;
        end;
        {$ENDIF}
      end;
      lQuery.Next;
    end;    // while
  finally
    DisconnectDB;
  end;
end;  // LoadTableInformation

{******************************************************************************
  DisableAllTriggers
 ******************************************************************************}
procedure TDatabaseInfo.DisableAllTriggers;
begin // DisableAllTriggers
  ConnectDB;
  try
    lQuery.SQL.Text := 'update RDB$TRIGGERS set RDB$TRIGGER_INACTIVE = 1';
    try
      lQuery.ExecSQL;
    except
      on E:Exception
      do begin
        // ignore, we don't want to skip all the others!
        Log(E.Message + ' (TDatabaseInfo.DisableAllTriggers)');
      end;
    end;
  finally
    DisconnectDB;
  end;
end;  // DisableAllTriggers

{******************************************************************************
  EnableAllTriggers
 ******************************************************************************}
procedure TDatabaseInfo.EnableAllTriggers;
begin // DisableAllTriggers
  ConnectDB;
  try
    lQuery.SQL.Text := 'update RDB$TRIGGERS set RDB$TRIGGER_INACTIVE = 0';
    try
      lQuery.ExecSQL;
    except
      on E:Exception
      do begin
        // ignore, we don't want to skip all the others!
        Log(E.Message + ' (TDatabaseInfo.EnableAllTriggers)');
      end;
    end;
  finally
    DisconnectDB;
  end;
end;  // EnableAllTriggers

{******************************************************************************
  ConnectDB
 ******************************************************************************}
procedure TDatabaseInfo.ConnectDB;
begin // ConnectDB
  ldb   := TIBDatabase.Create(nil);
  lTran := TIBTransaction.Create(nil);
  lTran.DefaultDatabase := ldb;
  lDb.DefaultTransaction := lTran;
  ldb.DatabaseName := FPath;
  ldb.LoginPrompt := FALSE;
  ldb.Params.Values['password'] := FPassword;
  ldb.Params.Values['user_name'] := FUsername;
  // turn off forces writes, should speed things up a bit
  ldb.Params.Values['isc_dpb_force_write'] := '0';
  ldb.Open;
  lTran.Active := TRUE;
  lQuery := TIBQuery.Create(nil);
  lQuery.Database := ldb;
end;  // ConnectDB


{******************************************************************************
  DisconnectDB
 ******************************************************************************}
procedure TDatabaseInfo.DisconnectDB;
begin // DisconnectDB
  try
    try
      if (Assigned(lQuery))
      then begin
        if (lQuery.Active)
        then lQuery.Close;
        FreeAndNil(lQuery);
      end;
      if (Assigned(lTran))
      then begin
        if (lTran.InTransaction)
        then begin
          try
            lTran.Commit;
          except
            lTran.Rollback;
          end;
        end;
        lTran.Active := FALSE;
        FreeAndNil(lTran);
      end;
    finally
      if (Assigned(ldb))
      then begin
        lDB.ForceClose;
        FreeAndNil(lDB);
      end;
    end;
  except
    // Ignore, 
  end;
end;  // DisconnectDB


{******************************************************************************
  DosCommandNewLine
 ******************************************************************************}
procedure TDatabaseInfo.DosCommandNewLine(Sender: TObject; NewLine: string;
                                          OutputType: TOutputType);
{$IFDEF DSI}
var
  Index: Integer;
  DSIPrimaryKey: String;

  {****************************************************************************
    ConvertPrimaryKeyToDSIFormat (DosCommandNewLine)
   ****************************************************************************}
  function ConvertPrimaryKeyToDSIFormat(Constraint, Table: String): string;
  var
    TableName, IndexName, Fields : String;
    Index : Integer;

  begin // ConvertPrimaryKeyToDSIFormat (DosCommandNewLine)
    Result := '';
    try
      // Get table name from string: CREATE TABLE ACCOUNT (OBJID DT$OBJID NOT NULL,
      Index := pos('TABLE', Table);
      System.Delete(Table, 1, Index + 5);
      Table := Trim(Table);
      Index := pos(' ', Table);
      TableName := Copy(Table, 1, Index);
      // get index name from: CONSTRAINT ACCOUNT$OBJID PRIMARY KEY (OBJID));
      Index := pos('CONSTRAINT', Constraint);
      System.Delete(Constraint, 1, Index + 10);
      Constraint := Trim(Constraint);
      Index := pos(' ', Constraint);
      IndexName := Trim(Copy(Constraint, 1, Index));
      // get key fields from: CONSTRAINT ACCOUNT$OBJID PRIMARY KEY (OBJID));
      Index := Pos('(', Constraint);
      System.Delete(Constraint,1,Index);
      Constraint := Trim(Constraint);
      Index := Pos(')', Constraint);
      Fields := Copy(Constraint, 1, Index - 1);
      lQuery.SQL.Text := 'select * from classindex where upper(name) = "' + IndexName + '"';
      lQuery.Open;
      lQuery.First;
      if (not lQuery.IsEmpty) // We've got a matching classindex, fix the creation
      then begin
        Result := '';
        Result := 'create unique ascending index ' + IndexName + ' on ' + '"' + TableName + '"' + '(' + Fields + ');' + #$0D+#$0A;
        Result := Result + 'COMMIT WORK;'+ #$0D+#$0A;
        Result := Result + 'Insert into RDB$RELATION_CONSTRAINTS (RDB$CONSTRAINT_NAME, RDB$CONSTRAINT_TYPE, ' +
                ' RDB$RELATION_NAME, RDB$DEFERRABLE, RDB$INITIALLY_DEFERRED, RDB$INDEX_NAME) ' +
                'values (''' + UpperCase(IndexName) + ''', ''PRIMARY KEY'', ''' +
                '"' + TableName + '"' + ''', ''NO'', ''NO'', ''' +
                Uppercase(IndexName) + ''');'+ #$0D+#$0A;
        Result := Result + 'COMMIT WORK;' + #$0D+#$0A;
        Log('-----',toFile);
        Log('Table : ' + '"' + TableName + '"',toFile);
        Log('Index : ' + IndexName,toFile);
        Log('Fields: ' + Fields,toFile);
        Log('-----',toFile);
      end
      else begin
        Result := '';
      end;
      lQuery.Close;
    except
      on E:Exception
      do begin
        Log(E.Message + ' (ConvertPrimaryKeyToDSIFormat)');
      end;
    end;
  end;  // ConvertPrimaryKeyToDSIFormat (DosCommandNewLine)

  function AddGeneratorSetCommand(GeneratorLine: String): String;
  var
    GeneratorName: String;
    SourceValue: Int64;
    Index: Integer;

  begin
    try
      Index := pos('CREATE GENERATOR', GeneratorLine);
      Result := '';
      if (Index <> -1)
      then begin
        System.Delete(GeneratorLine,1, Index + 16);
        System.Delete(GeneratorLine,Length(GeneratorLine),1);
        GeneratorName := Trim(GeneratorLine);
        lQuery.SQL.Text := 'select gen_id(' + GeneratorName + ',0) from RDB$DATABASE';
        lQuery.Open;
        SourceValue := lQuery.Fields[0].AsInteger;
        Result := 'set generator ' + GeneratorName + ' to ' + IntToStr(SourceValue) + ';';
        lQuery.Close;
      end;
    except
      on E:Exception
      do begin
        Log(E.Message + ' (ConvertPrimaryKeyToDSIFormat)');
      end;
    end;
  end;

{$ENDIF}

begin // DosCommandNewLine
  if (OutputType = otEntireLine)
  then begin
    if (not lBuildingDatabase)
    then begin
      if ((FMetaData.Count mod 10) = 0)
      then Log(IntToStr(FMetaData.Count) + ' lines collected',toUpdateLineOnly);

      // Remove Returns blob by value in Function declarations, IB 5.6 chokes
      // on that, suspect defect in ISQL when it extracts.
      if (Trim(NewLine) = 'RETURNS BLOB BY VALUE')
      then NewLine := 'RETURNS BLOB';
      {$IFDEF DSI}
      // Note, below code is to make the metadata creation DDL create the
      // metadata related primary keys in the 'DSI' fashion ;-)
      if (Pos('CONSTRAINT',NewLine) <> 0)
      then begin
        // Find Create Table statement
        Index := FMetaData.Count - 1;
        while (pos('CREATE TABLE',FMetaData[Index])= 0) and (Index > -1)
        do Dec(Index);
        // Call routine to format DSI primary key creation statements, returns '' if
        // it's not a dsikey and should be handled normally.  In which case we simply
        // add it to the list.
        DSIPrimaryKey := ConvertPrimaryKeyToDSIFormat(NewLine, FMetaData[Index]);
        if (DSIPrimaryKey <> '')
        then begin
          // Close the create statement, would have had a , at the end, we want a ");"
          FMetaData[FMetaData.Count - 1] :=
            StringReplace(FMetaData[FMetaData.Count - 1],',',');',[rfReplaceAll]);
          // Commit and add our primary key creation
          FMetaData.Add('COMMIT WORK;');
          FMetaData.Add(DSIPrimaryKey);
          FMetaData.Add('COMMIT WORK;');
        end
        else begin
          // otherwise, keep the primary key specification.
          FMetaData.Add(NewLine);
        end;
      end
      else if (Pos('CREATE GENERATOR', NewLine) <> 0)
      then begin
        FMetaData.Add(NewLine);
        FMetaData.Add('COMMIT WORK;');
        FMetaData.Add(AddGeneratorSetCommand(NewLine));
      end
      else FMetaData.Add(NewLine);
      {$ELSE}
      FMetaData.Add(NewLine);
      {$ENDIF}
    end
    else Log(NewLine);
  end;
end;  // DosCommandNewLine


{******************************************************************************
  DosCommandTerminated
 ******************************************************************************}
procedure TDatabaseInfo.DosCommandTerminated(Sender: TObject);
begin // DosCommandTerminated
  if (TDosThread(Sender).Exit_Code = 0)
  then begin
    Log('Success');
  end
  else begin
    Log('Attempt to ' + lCurrentMetadataProcess + ' MetaData Failed!', toBoth);
    Log('');
    FMetaData.Clear;
  end;
  LFinished := TRUE;
end;  // DosCommandTerminated


{******************************************************************************
  Log
 ******************************************************************************}
procedure TDatabaseInfo.Log(Msg: String; OutputType: TLogOutputType);
begin // Log
  if (Assigned(FLogFile))
  then FLogFile.AddLog(Msg, OutputType);
end;  // Log


{******************************************************************************
  LoadMetadata

  Collects a complete metadata dump from the current database (Path property)
  and stores the metadata in fMetaData stringlist.
 ******************************************************************************}
procedure TDatabaseInfo.LoadMetadata;
var
  DosCommand: TDosCommand;
begin // LoadMetadata
  DosCommand := TDosCommand.Create(nil);
  Screen.Cursor := crHourglass;
  LFinished := FALSE;
  try
    ConnectDB;
    Log('Collecting metadata information');
    lCurrentMetadataProcess := 'Load';
    DosCommand.OnTerminated := DosCommandTerminated;
    DosCommand.OnNewLine    := DosCommandNewLine;
    DosCommand.Priority := NORMAL_PRIORITY_CLASS;
    // we need to set environment variable for IB 5.6, as the ISQL command
    // has a bug, so is doesn't accept username and password on the command line.
    fMetaData.Clear;
    fMetaData.Add('@echo off');
    fMetaData.Add('set ISC_USER=' + FUserName);
    fMetaData.Add('set ISC_PASSWORD=' + FPassword);
    fMetaData.Add('"' + LibBinPath + '\isql" ' + Path + ' -x -a');
    fMetaData.SaveToFile(fTempPath + '\temp.bat');
    fMetaData.Clear;
    DosCommand.CommandLine := fTempPath + '\temp.bat';
    // Below is commented out version that should work with ib6.0 >
    //DosCommand.CommandLine := LibBinPath + '\isql -user ' + FUserName +
    //                     ' -password ' + FPassword + ' ' + Path + ' -x -a';
    //Log(DosCommand.CommandLine);
    DosCommand.Execute;
    Repeat
      Application.ProcessMessages;
    Until LFinished;
    {$IFDEF DEBUG}
    fMetaData.SaveToFile('METADATA.SQL');
    {$ENDIF}
  finally
    Screen.Cursor := crDefault;
    FreeAndNil(DosCommand);
    DisconnectDB;
    Sysutils.DeleteFile(fTempPath + '\temp.bat');
  end;
end;  // LoadMetadata


{******************************************************************************
  PutMetaData

  Creates new database with metadata defined in MetaData property using Path
  property for the newly created database.  All ancillary files are name Gxx where
  xx is the file number (01, 02, 03)
 ******************************************************************************}
procedure TDatabaseInfo.PutMetaData;
var
  DosCommand: TDosCommand;
  CreateCommands: TStringList;
  CreateCommand,
  TempSt,
  FileNum,
  PageSize: String;
  Index,
  CreateLinePos,
  ExtraFileCount: Integer;
begin // PutMetaData
  if (fMetaData.Text = '')
  then raise exception.create('Must assing MetaData before creating database!');
  DosCommand := TDosCommand.Create(nil);
  Screen.Cursor := crHourglass;
  LFinished := FALSE;
  CreateCommands := TStringList.Create;
  try
    Log('*Creating New Database');
    lBuildingDatabase := TRUE;
    DosCommand.Priority := NORMAL_PRIORITY_CLASS;
    lCurrentMetadataProcess := 'Save';
    DosCommand.OnTerminated := DosCommandTerminated;
    DosCommand.OnNewLine    := DosCommandNewLine;

    // Find the 'CREATE DATABASE' command
    Index := 0;
    CreateLinePos := -1;
    while (Index < fMetaData.Count)
    do begin
      if (pos('CREATE DATABASE',fMetaData[Index]) <> 0)
      then begin
        CreateLinePos := Index;
        Index := fMetaData.Count;
      end;
      Inc(Index);
    end;
    if (CreateLinePos = -1)
    then raise Exception.Create('Unable to find create statement in Metadata DDL!!');

    // Now create a new create database statement
    CreateCommand := fMetaData[CreateLinePos];
    Index := pos('PAGE_SIZE',CreateCommand);
    if Index <> 0
    then begin
      PageSize := copy(CreateCommand,Index + 10,Length(CreateCommand));
      CreateCommand := 'CREATE DATABASE ''' + fPath + ''' PAGE_SIZE ' + PageSize + ';';
    end
    else begin
      CreateCommand := 'CREATE DATABASE ''' + fPath + ''';';
    end;
    CreateCommands.Add(CreateCommand);

    // Now we need to look for ADD FILE statements
    Index := 0;
    ExtraFileCount := 0;
    while (Index < fMetaData.Count)
    do begin
      if (pos('ALTER DATABASE ADD FILE',fMetaData[Index]) <> 0)
      then begin
        Inc(ExtraFileCount);
        TempSt := fMetaData[Index];
        FileNum := IntToStr(ExtraFileCount);
        if (Length(FileNum) < 2)
        then FileNum := '0' + FileNum;
        CreateCommand := copy(TempSt,1,pos('"',TempSt));
        Delete(TempSt,1,pos('"',TempSt));
        CreateCommand := CreateCommand + ChangeFileExt(fPath, '.G' + FileNum);
        CreateCommand := CreateCommand + Copy(TempSt,pos('"',TempSt), Length(TempSt));
        CreateCommands.Add(CreateCommand + ';');
      end;
      inc(Index);
    end;    // while

    // Insert in reverse order!
    Index := CreateCommands.Count;
    repeat
      Dec(Index);
      fMetaData.Insert(CreateLinePos,CreateCommands[Index]);
    until Index = 0;
    fMetaData.SaveToFile(fTempPath + '$$TABLE.SQL');

    {$IFDEF DEBUG}
    fMetaData.SaveToFile('CREATEDB.SQL');
    {$ENDIF}

    // we need to set environment variable for IB 5.6, as the ISQL command
    // has a bug, so is doesn't accept username and password on the command line.
    fMetaData.Clear;
    fMetaData.Add('@echo off');
    fMetaData.Add('set ISC_USER=' + FUserName);
    fMetaData.Add('set ISC_PASSWORD=' + FPassword);
    fMetaData.Add('"' + LibBinPath + 'isql" -i "' + fTempPath + '$$TABLE.SQL"');
    fMetaData.Add('"' + LibBinPath + 'gfix" -h 0 ' +  '"' + fPath + '"');
    // set async writes (forced writes off)
    fMetaData.Add('"' + LibBinPath + 'gfix" -w async ' +  '"' + fPath + '"');
    fMetaData.SaveToFile(fTempPath + 'temp.bat');
    fMetaData.LoadFromFile(fTempPath + '$$TABLE.SQL');
    DosCommand.CommandLine := fTempPath + 'temp.bat';
    DosCommand.Execute;
    Repeat
      Application.ProcessMessages;
    Until LFinished;
  finally
    Screen.Cursor := crDefault;
    FreeAndNil(DosCommand);
    FreeAndNil(CreateCommands);
    Sysutils.DeleteFile(fTempPath + '\$$TABLE.SQL');
    Sysutils.DeleteFile(fTempPath + '\temp.bat');
  end;
end;  // PutMetaData

{******************************************************************************
  TestConnection
 ******************************************************************************}
function TDatabaseInfo.TestConnection: Boolean;
begin // TestConnection
  ldb := TIBDatabase.Create(nil);
  try
    ldb.DatabaseName := FPath;
    ldb.LoginPrompt := FALSE;
    ldb.Params.Values['password'] := FPassword;
    ldb.Params.Values['user_name'] := FUsername;
    FPassword := '';
    FUserName := '';
    ldb.Connected := TRUE;
    FPassword := ldb.Params.Values['password'];
    FUserName := ldb.Params.Values['user_name'];
    Result := TRUE;
    ldb.ForceClose;
  finally
    FreeAndNil(ldb);
  end;
end;  // TestConnection

{******************************************************************************
  Create
 ******************************************************************************}
constructor TDatabaseInfo.Create;
begin // Create
  inherited;
  lBuildingDatabase := FALSE;
  fIsLocal  := FALSE;
  fPath     := '';
  fUserName := '';
  fPassword := '';
  fIsLocal  := FALSE;
  lIBBinPath := '';
  // Setup the default, try to UseFirebird first, then fallback to IB
  // Calling application should handle checking to make sure the server is running
  // and the like.
  UseFirebird := TRUE;
  if (LIBBinPath = '') then UseFirebird := FALSE;
  if (LIBBinPath = '')
  then raise Exception.Create('Firebird or Interbase is not installed correctly!');
  fMetaData := TStringList.Create;
  fTableList := TStringList.Create;
end;  // Create

{******************************************************************************
  Destroy
 ******************************************************************************}
destructor TDatabaseInfo.Destroy;
var
  Loop: Integer;
  CurrTableInfo: TTableInfo;
begin // Destroy
  for Loop := 0 to fTableList.Count - 1
  do begin
    CurrTableInfo := TTableInfo(fTableList.Objects[Loop]);
    FreeAndNil(CurrTableInfo);
  end;
  FreeAndNil(fMetaData);
  FreeAndNil(fTableList);
  inherited Destroy;
end;  // Destroy


{******************************************************************************
  GetUserInfo
 ******************************************************************************}
function TDatabaseInfo.GetUserInfo: Boolean;
begin // GetUserInfo
  try
    if (FPassword = '') or (FUserName = '')
    then Result := LoginDialogEx(Path, FUserName, FPassword, FALSE)
    else Result := TRUE;
  finally
  end;
end;  // GetUserInfo

{******************************************************************************
  SetPath
 ******************************************************************************}
procedure TDatabaseInfo.SetPath(InPath: String);
begin // SetPath
  if (InPath <> FPath)
  then begin
    FPath := InPath;
    FIsLocal := FALSE;
    FIsLocal := ((RemoveServerName(FPath) = FPath) or ('127.0.0.1:' + RemoveServerName(FPath) = FPath));
    // Database is local, look for the file.
    if (FIsLocal)
    then begin
      FDBExists := FileExists(RemoveServerName(FPath));
    end;
    FUserName := '';
    FPassword := '';
  end;
end;  // SetPath


{******************************************************************************
  SetUseFirebird
 ******************************************************************************}
procedure TDatabaseInfo.SetUseFirebird(InUseFirebird: Boolean);
var
  Reg: TRegistry;

begin // SetUseFirebird
  Reg := TRegistry.Create;
  try
    if InUseFirebird
    then begin
      Reg.RootKey := HKEY_LOCAL_MACHINE;  //Assume Local Machine Keys!
      Reg.OpenKey('\SOFTWARE\FirebirdSQL\Firebird\CurrentVersion',FALSE);
      LIBBinPath := IncludeTrailingBackslash(Reg.ReadString('RootDirectory'));
      if (LIBBinPath = '\')
      then begin
        Reg.OpenKey('\SOFTWARE\Firebird Project\Firebird Server\Instances',FALSE);
        LIBBinPath := IncludeTrailingBackslash(Reg.ReadString('DefaultInstance'));
      end;
      LIBBinPath := LIBBinPath + 'bin\';
      fUseFirebird := TRUE;
    end
    else LIBBinPath := '';
    // Get Interbase path instead of Firebird
    if (LIBBinPath = '')
    then begin
      Reg.RootKey := HKEY_LOCAL_MACHINE;  //Assume Local Machine Keys!
      Reg.OpenKey('\SOFTWARE\InterBase Corp\InterBase\CurrentVersion', FALSE);
      LIBBinPath := IncludeTrailingBackslash(Reg.ReadString('ServerDirectory'));
      fUseFirebird := FALSE;
    end;
    Reg.CloseKey;
  finally
    Reg.Free;
  end;
end;  // SetUseFirebird

end.
