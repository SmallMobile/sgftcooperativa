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
unit IBTableCopier;

interface

uses
  Forms, Classes, Sysutils, FileCtrl, Registry, Windows,
  // Database units
  DB, dbTables, IBSQL, IBQuery, IBDatabase, IBHeader,
  // Custom units
  IBDBRepairUtilities, IBRepairSupport;

const
  // How many records between status updates, probably could be higher
  // depends on how much user feedback is wanted.
  STATUS_INTERVAL = 1000;
  // Maximum size of external files, Interbase 5.x will not work with external
  // database files larger than MaxInt.  Tests with 6.0 indicate this limiation
  // is no more.
  MAX_EXT_FILE_SIZE = MaxInt;
//  MAX_EXT_FILE_SIZE = 1000;


type
  // Callback events.
  TTableCopierProgressEvent = procedure (TableName: String; CopiedCount, TotalCount: Int64) of object;
  TTableCopierLogEvent      = procedure (Msg: String; OutputType: TLogOutputType = toBoth) of object;


  // The main table copier class. This handles all the details of a table copy
  // based on the passed in TTableInfo object and other parameters.
  TTableCopier = class(TObject)
  private
    // Property variables
    fSourceDBInfo,
    fDestDBInfo:            TDatabaseInfo;
    fTempPath:              String;
    fMaxDiskUsage:          Integer;
    fOnProgress:            TTableCopierProgressEvent;
    fOnLog:                 TTableCopierLogEvent;
    // Local working IBSQL objects
    sqlSource,
    sqlDest:                TIBSql;

    // Property assignment procedures
    procedure SetTempPath(xTempPath: String);
    procedure SetMaxDiskUsage(xDiskUsage: Integer);
  published
    property DestDBInfo: TDatabaseInfo read fDestDBInfo write fDestDBInfo;
    property SourceDBInfo: TDatabaseInfo read fSourceDBInfo write fSourceDBInfo;
    property MaxDiskUsage: Integer
             read fMaxDiskUsage write SetMaxDiskUsage;
    property TempPath: String
             read fTempPath write SetTempPath;
    property OnProgress: TTableCopierProgressEvent
             read fOnProgress write fOnProgress;
    property OnLog: TTableCopierLogEvent
             read fOnLog write fOnLog;
  private
    procedure CloseWorkSQL;
    procedure AddLog(Msg: String; OutputType: TLogOutputType = toBoth);
    procedure ReportProgress(TableName: String; CopyCount, TotalCount: Int64);
    procedure Commit(DB: TIBDatabase);
    procedure CloseAll;
    procedure ReconnectAll;
    function  TableExists(TableName: String; DB: TIBDatabase; LogResult : boolean = FALSE): Boolean;
    procedure DropTable(TableName: String; DB: TIBDatabase; HaltOnException: Boolean = TRUE);
    procedure DeleteExternalFile(Name: String);

    // Root copy functions, CopyTable decides which of these to call.
    function  QueryRecordCopy(DestTable, SourceQuery, DestQuery: String;
                              RecordCount: Integer;
                              KeyFields: String = '';
                              IgnoreDuplicates: Boolean = TRUE): Integer;
    function BatchCopy(TableInfo: TTableInfo): Integer;
    // ExternalCopy handles a single external copy (export, import, deletefile)
    // process, above BatchCopy manages determining the number of files to use
    // and manages the queries necessary to call ExternalCopy
    function ExternalCopy(TableInfo: TTableInfo; SourceQuery, DestQuery: String): Integer;
    // RawCopy used IB raw copy components.. This is amazingly slow, takes about
    // as much time as a record copy, with all the drawbacks of an external
    // table copy.  Left it here for 'historical' purposes.
    // function RawCopy(TableInfo: TTableInfo; SourceWhere: String): Integer;
  public
    constructor Create;
    destructor  Destroy; override;
    function  CopyTable(TableInfo: TTableInfo; DropTriggers, DropIndexes: Boolean): Integer;
  end; //TTableCopier


implementation

(*

Left here for ..well..why not.  This is using the IBRawCopy components, pretty darned
slow
{******************************************************************************
  RawCopy
 ******************************************************************************}
function TTableCopier.RawCopy(TableInfo: TTableInfo; SourceWhere: String): Integer;
var
  ExportCount,
  SkippedCount,
  ImportCount : Integer;
  ExtCreate: String;
  ExtFile: String;
  RawOutput : TIBOutputRawFile;
  RawInput : TIBInputRawFile;

begin // RawCopy
  SkippedCount := 0;
  // Only call this once, intitializes ExtFilename based on current
  // contents of tempdir.
  ExtCreate := TableInfo.ExtTableCreateQuery;
  ExtFile := TableInfo.ExtFileName;

  sqlSource.SQL.Text := 'select ' + TableInfo.SourceFields + ' from ' + '"' + TableInfo.TableName + '"' + SourceWhere;
  sqlDest.SQL.Text := 'Insert into ' + '"' + TableInfo.TableName + '"' + ' (' + TableInfo.SourceFields + ') values ' + TableInfo.DestParams;
  RawOutput:= TIBOutputRawFile.Create;
  try
    AddLog('  - Exporting Data');
    RawOutput.FileName := ExtFile;
    sqlSource.BatchOutput(RawOutput);
    ExportCount := sqlSource.RowsAffected;
  finally
    RawOutput.Free;
  end;

  RawInput := TIBInputRawFile.Create;
  try
    AddLog('  - Importing Data');
    RawInput.FileName := ExtFile;
    sqlDest.BatchInput(RawInput);
    ImportCount := sqlDest.RowsAffected;
    if (TableInfo.DupHandling = dhIgnore)
    then SkippedCount := ExportCount - ImportCount;
  finally
    RawInput.Free;
  end;
  AddLog('  - Commit');
  Commit(fDestDBInfo.Database);
  AddLog('  - Raw copy done');
  DeleteExternalFile(ExtFile);
  if (SkippedCount > 0)
  then AddLog('Copied: ' + IntToStr(ImportCount) + ' records, ' + IntToStr(SkippedCount) + ' duplicates ignored', toFile)
  else AddLog('Copied: ' + IntToStr(ImportCount) + ' records', toFile);
  Result := ImportCount + SkippedCount; // return combined value, so progress is accurate
  if (Result <> ExportCount)
  then AddLog('Record Count Mismatch: (' + IntToStr(ExportCount) + '/' +
              IntToStr(Result) + ')');
  CloseWorkSQL;

end;  // RawCopy
*)

{******************************************************************************
  BatchCopy
  This routine handles copying a table using external files, breaking up the
  files and all related details
 ******************************************************************************}
function TTableCopier.BatchCopy(TableInfo: TTableInfo): Integer;
var
  ExportQuery,
  ImportQuery,
  xWhere : String;
  RecLen,
  CopyCount,
  NumFiles,
  StartRange,
  EndRange,
//  Delta,
  MinKey,
  MaxKey,
//  Density,
  CurrCopyCount: Int64;
  FilesNeeded: Int64;
  Middle: Int64;
  IntKeyName: String;

  function IgnoreDupWhere: String;
  var
    lWhere: String;
    FieldLoop: Integer;
  begin
    // If duphandling is set to ignore and we aren't creating a new database
    // put where clause on end of importquery so that any existing duplicates
    // do not cause the entire file import to fail.
    lWhere := '';
    if (TableInfo.DupHandling = dhIgnore) and (DestDBInfo.DBExists)
    then begin
      for FieldLoop := 0 to TableInfo.KeyFields.Count - 1
      do begin
        if (lWhere <> '')
        then lWhere := lWhere + ' AND ';
        lWhere := lWhere + '(INTERN.' + TableInfo.KeyFields[FieldLoop] +
                         ' = EXTERN.' + TableInfo.KeyFields[FieldLoop] + ')';
      end;
    end;
    Result := lWhere;
  end;


begin // BatchCopy
  CopyCount := 0;
  try
    NumFiles := 0; // Assume only one file necessary
    RecLen := TableInfo.RecordSize;

    // if the exported data will exceed fMaxDiskUsage, make some guesses about how to break it up.
    if ((TableInfo.RecordCount * RecLen) > fMaxDiskUsage)
    then begin
      TableInfo.GetMostDeviantIntKey(fSourceDBInfo.Database);
      IntKeyName := TableInfo.IntKey;
      // find out how many files we'd need, rounding up of course
      FilesNeeded := Trunc(((TableInfo.RecordCount) * RecLen) / fMaxDiskUsage) + 1;
      MinKey := TableInfo.MinIntKey;
      MaxKey := TableInfo.MaxIntKey;
      Middle := MinKey + Round(((MaxKey - MinKey) / FilesNeeded));
      // Setup our first 'chunk' attempt
      EndRange := Middle;
      StartRange := MinKey;
    end
    else begin
      StartRange := -High(Int64);
      EndRange := High(Int64);
      MaxKey   := High(Int64);
      MinKey   := -High(Int64);
      Middle := 0;
      IntKeyName := '';
    end;

    // Export/Import/Delete each file one at a time, this minimizes use of
    // disk space
    While (EndRange < MaxKey) or (CopyCount < TableInfo.RecordCount)
    do begin
      try
        xWhere := '';
        if (IntKeyName <> '') // Indicates we need to breakup the export
        then begin
          if (EndRange = MaxKey) // If we're getting everything left, drop the EndRange
          then  xWhere := ' where (' + IntKeyName + ' >= ' + IntToStr(StartRange) + ')'
          else begin // Get StartRange - EndRange
            xWhere := ' where (' + IntKeyName + ' >= ' + IntToStr(StartRange) + ') and (' +
                                       IntKeyName + ' < ' + IntToStr(EndRange) + ')';
          end;
        end;
        // Add in the user specified where clause, if necessary
        if (TableInfo.ExportWhere <> '')
        then begin
          if (xWhere <> '')
          then xWhere := xWhere + ' and ' + TableInfo.ExportWhere
          else xWhere := ' where ' + TableInfo.ExportWhere;
        end;

        // Here's the export query.
        ExportQuery := 'insert into ' + EXT_TABLE_NAME +
                       ' select ' + TableInfo.SourceFields + ' from ' + '"' + TableInfo.TableName + '"' + xWhere;

        // Get where params for importing, if the destination database existed and
        // the duplicate handling is set to dupIgnore... login in IngoreDupWhere
        xWhere := IgnoreDupWhere;

        ImportQuery := 'insert into ' + '"' + TableInfo.TableName + '"' + ' (' + TableInfo.SourceFields +
                       ') select ' + TableInfo.ImportFields + ' from ' + EXT_TABLE_NAME + ' EXTERN';
        if (xWhere <> '')
        then begin
          ImportQuery := ImportQuery + ' where not exists(select * from ' +
                           '"' + TableInfo.TableName + '"' + ' INTERN where ' + xWhere + ')';
        end;
        AddLog('**** External Copy: ' + '"' + TableInfo.TableName + '"');
        // If we are breaking up the export, report details.
        if (IntKeyName <> '')
        then begin
          AddLog('    | Batch Copy using the following values', toFile);
          AddLog('    | Min = ' + IntToStr(MinKey), toFile);
          AddLog('    | Max = ' + IntToStr(MaxKey), toFile);
          AddLog('    | Mid = ' + IntToStr(Middle), toFile);
        end;
        try
          CurrCopyCount := ExternalCopy(TableInfo, ExportQuery, ImportQuery);
        except
          CurrCopyCount := -1;
        end;

        if (CurrCopyCount <> -1)
        then begin
          CopyCount := CopyCount + CurrCopyCount;
          // We're breaking up the export so we need to re-calculate
          if (IntKeyName <> '')
          then begin
            // find out how many files we'd need for remaining records, forcing an extra
            // just to be sure.
            FilesNeeded := Trunc(((TableInfo.RecordCount - CopyCount) * RecLen) / fMaxDiskUsage) + 1;
            // Start process on the remainder
            MinKey := Middle;
            Middle := MinKey + Round(((Maxkey - MinKey) / FilesNeeded));
            EndRange := Middle;
            StartRange := MinKey;
            if (((TableInfo.RecordCount - CopyCount) * RecLen) < fMaxDiskUsage)
            then EndRange := MaxKey;
            Inc(NumFiles);
            ReportProgress(TableInfo.TableName + '(File #' + IntToStr(NumFiles) + ')', CopyCount, TableInfo.RecordCount);
          end
          else Break;
        end
        else begin // Error during export, indicated by -1 return value
          AddLog('BatchCopy: Exceeded safe file size');
          if (IntKeyName <> '')
          then begin
            FilesNeeded := Trunc(((TableInfo.RecordCount - CopyCount) * RecLen) / fMaxDiskUsage) + 1;
            // *2 for some extra safety, we want to keep the number of failures
            // to a minimum.
            FilesNeeded := FilesNeeded * 2;
            // split the range and try again!
            Middle := MinKey + Round(((Middle - MinKey) / FilesNeeded));
            // Setup our first 'chunk' attempt
            EndRange := Middle;
            StartRange := MinKey;
          end
          else begin
            AddLog('BatchCopy: Unable to break up export, missing IntKey!');
            Break;
          end;
        end;
      except
        on E:Exception
        do AddLog('CopyTable: ' + E.Message + ' (' + sqlSource.SQL.Text + ', ' +
                  sqlDest.SQL.Text + ')');
      end;
    end;    // While
  except
    on E:Exception
    do AddLog('CopyTable: ' + E.Message + ' (' + sqlSource.SQL.Text + ', ' +
               sqlDest.SQL.Text + ')');
  end;
  Result := CopyCount;
  AddLog(' - Done with ' + '"' + TableInfo.TableName + '"' );
  CloseWorkSQL;
end;  // BatchCopy

{******************************************************************************
  CloseAll
  Force everything closed
 ******************************************************************************}
procedure TTableCopier.CloseAll;
begin // CloseAll
  // Force closing, this is necessary to make sure external files are freed up
  fSourceDBInfo.DisconnectDB;
  fDestDBInfo.DisconnectDB;
  Session.Active := FALSE;
end;  // CloseAll

{******************************************************************************
  ReconnectAll
  ForceClose and reconnect on Source and Dest databases.  This is necessary in
  order to assure external files are freed up so they can be deleted.
 ******************************************************************************}
procedure TTableCopier.ReconnectAll;
begin // ReconnectAll
  //Close all database connections
  CloseAll;
  Sleep(1000);
  fSourceDBInfo.ConnectDB;
  fDestDBInfo.ConnectDB;
  // Make sure the defaultaction values are still commitretaining.
  fSourceDBInfo.Database.DefaultTransaction.DefaultAction := TACommitRetaining;
  fDestDBInfo.Database.DefaultTransaction.DefaultAction := TACommitRetaining;
  sqlSource.Database := fSourceDBInfo.Database;
  sqlDest.Database := fDestDBInfo.Database;
end;  // ReconnectAll


{******************************************************************************
  ReportProgress
  Calls back to the fOnProgress event if it's assinged.  Otherwise passed the
  call to AddLog (which only logs if the LogFile has been properly assigned).
 ******************************************************************************}
procedure TTableCopier.ReportProgress(TableName: String; CopyCount, TotalCount: Int64);
begin // ReportProgress
  if (Assigned(fOnProgress))
  then fOnProgress(TableName, CopyCount, TotalCount)
  else AddLog('"' + TableName + '"' + ' - Copied: ' + IntToStr(CopyCount), toUpdateLine);
end;  // ReportProgress

{******************************************************************************
  Commit
  Handles commiting a transaction and makes sure there's a new active trans
 ******************************************************************************}
procedure TTableCopier.Commit(DB: TIBDatabase);
begin // Commit
  if (DB.DefaultTransaction.InTransaction)
  then DB.DefaultTransaction.Commit;
  if (not DB.DefaultTransaction.Active)
  then DB.DefaultTransaction.StartTransaction;
end;  // Commit


{******************************************************************************
  CloseWorkSQL
  FreeHandle and Close both work TIBSQL objects.

  Note that there are times when a query is prepared but not open, such as
  after executing an Insert or Update query.  In these cases we need to FreeHandle.

  In addition, a Query that is open is *not* closed by calling FreeHandle, so
  we need to make sure to Close the query too.

  In addition, calling Close on a prepared query (whether open or not) does *not*
  free the handle!

  So we must to both.
 ******************************************************************************}
procedure TTableCopier.CloseWorkSQL;
begin // CloseWorkSQL
  if (sqlSource.Prepared)
  then sqlSource.FreeHandle;
  if (sqlSource.Open)
  then sqlSource.Close;
  if (sqlDest.Prepared)
  then sqlDest.FreeHandle;
  if (sqlDest.Open)
  then sqlDest.Close;
end;  // CloseWorkSQL

{******************************************************************************
  AddLog
  Add message to log if callback is assigned
 ******************************************************************************}
procedure TTableCopier.AddLog(Msg: String; OutputType: TLogOutputType = toBOTH);
begin // AddLog
  if (Assigned(fOnLog))
  then fOnLog(Msg, OutputType);
end;  // AddLog

{******************************************************************************
  CopyTable
  The main workhorse, this decides which specific table copy method to use,
  when to copy (and when not), when to purge tables and handles all
  trigger/index deactivation/activation
 ******************************************************************************}
function  TTableCopier.CopyTable(TableInfo: TTableInfo; DropTriggers, DropIndexes: Boolean): Integer;
var
  SelectQuery,
  InsertQuery,
  ConstraintQuery,
  IndexQuery,
  PrimaryKeyIndex       : String;
  Descending: Boolean;
  {$IFDEF STATS}
  StartTime, EndTime: TTimeStamp;
  {$ENDIF}
begin // CopyTable
  Result := -1;
  ReconnectAll;
  if (TableInfo.CopyType <> dcSkip) and
     (TableInfo.RecordSize > 0) and
     (TableExists(TableInfo.TableName, fDestDBInfo.Database, TRUE))
  then
  begin
    AddLog('CopyTable: ' + '"' + TableInfo.TableName+ '"');
    try
      if (DropTriggers)
      then begin
        AddLog('    Turning off triggers');
        sqlDest.SQL.Text := 'update RDB$TRIGGERS set RDB$TRIGGER_INACTIVE = 1 ' +
                            ' where ((not RDB$SYSTEM_FLAG = 1) or (rdb$system_flag is null)) and (RDB$RELATION_NAME = ''' +
                            TableInfo.TableName + ''')';
        sqlDest.ExecQuery;
        sqlDest.FreeHandle;
        Commit(fDestDBInfo.Database);
      end;
      // Dropping indexes only usable on flushed tables or new database
      IndexQuery := '';
      ConstraintQuery := '';
      if (DropIndexes) and ((TableInfo.DupHandling = dhFlush) or (not DestDBInfo.DBExists))
      then begin
        AddLog('    Turning off indexes');
        // In order to 'turn off' the primary key index, we need to drop the constraint
        // which in turn will delete the primary key (go figure).
        // So, first, let's create an SQL index creation statement to rebuild the primary
        // key index
        sqlDest.SQL.Text := 'select rdb$index_name from rdb$relation_constraints where ' +
          'rdb$relation_name = ''' +  TableInfo.TableName  + ''' and ' +
          'rdb$constraint_type = "PRIMARY KEY"';
        sqlDest.ExecQuery;
        if (not sqlDest.Fields[0].IsNull) and (trim(sqlDest.Fields[0].AsString) <> '')
        then begin
          PrimaryKeyIndex := trim(sqlDest.Fields[0].AsString);
          sqlDest.Close;
          sqlDest.SQL.Text := 'select rdb$index_type from rdb$indices where rdb$index_name = ''' + PrimaryKeyIndex + '''';
          sqlDest.ExecQuery;
          if (sqlDest.Fields[0].AsInteger = 1) then Descending := TRUE
          else Descending := FALSE;
          sqlDest.Close;
          sqlDest.SQL.Text := 'select rdb$field_name from rdb$index_segments where ' +
            'rdb$index_name = ''' + PrimaryKeyIndex + ''' order by rdb$field_position';

          sqlDest.ExecQuery;
          IndexQuery := 'create unique ';
          if Descending then IndexQuery := IndexQuery + ' descending ';
          IndexQuery := IndexQuery + ' index ' + PrimaryKeyIndex + ' on ' + '"' + TableInfo.TableName + '"' + '(';
          while not sqlDest.EOF
          do begin
            IndexQuery := IndexQuery + Trim(sqlDest.Fields[0].AsString) + ',';
            sqlDest.Next;
          end;
          // Change final comma into close parens.
          IndexQuery[Length(IndexQuery)] := ')';
          sqlDest.Close;
          // Delete the constraint
          sqlDest.SQL.Text := 'delete from rdb$relation_constraints where rdb$constraint_type = ''PRIMARY KEY'' ' +
           ' and RDB$RELATION_NAME = ''' + TableInfo.TableName + '''';
          sqlDest.ExecQuery;
          // Create the constraint insert query
          ConstraintQuery := 'Insert into RDB$RELATION_CONSTRAINTS (RDB$CONSTRAINT_NAME, RDB$CONSTRAINT_TYPE, ' +
          ' RDB$RELATION_NAME, RDB$DEFERRABLE, RDB$INITIALLY_DEFERRED, RDB$INDEX_NAME) ' +
          'values (''' + PrimaryKeyIndex + ''', ''PRIMARY KEY'', ''' +
          TableInfo.TableName + ''', ''NO'', ''NO'', ''' +
          PrimaryKeyIndex + ''')';
        end;
        sqlDest.Close;
        sqlDest.SQL.Text := 'update RDB$INDICES set RDB$INDEX_INACTIVE = 1 ' +
                            ' where ((not RDB$SYSTEM_FLAG = 1) or (rdb$system_flag is null)) and (RDB$RELATION_NAME = ''' +
                            TableInfo.TableName + ''')';
        sqlDest.ExecQuery;
        Commit(fDestDBInfo.Database);
      end;
      // DBExists indicates whether it existed before this process, ie if it's FALSE
      // the database was freshly created so no need to flush.
      if (TableInfo.DupHandling = dhFlush) and (DestDBInfo.DBExists)
      then begin
        AddLog('- Flushing data from: ' + '"' + TableInfo.TableName + '"');
        sqlDest.SQL.Text := 'delete from ' + '"' + TableInfo.TableName + '"';
        try
          sqlDest.ExecQuery;
        except
          on E:Exception
          do AddLog('CopyTable: ' + E.Message);
        end;
      end;
      Commit(fSourceDBInfo.Database);
      Commit(fDestDBInfo.Database);
      {$IFDEF STATS}
      StartTime := DateTimeToTimeStamp(NOW);
      {$ENDIF}
      if (TableInfo.CopyType = dcRecord)
      then begin
        if (TableInfo.ExportWhere <> '')
        then SelectQuery := 'Select ' + TableInfo.SourceFields + ' from ' + '"' + TableInfo.TableName + '"' + ' where ' + TableInfo.ExportWhere
        else SelectQuery := 'Select ' + TableInfo.SourceFields + ' from ' + '"' + TableInfo.TableName + '"';
        InsertQuery := 'Insert into ' + '"' + TableInfo.TableName + '"' + ' (' + TableInfo.SourceFields + ') values ' + TableInfo.DestParams;
        AddLog('**** Record: ' + '"' + TableInfo.TableName + '"');
        Result := QueryRecordCopy(TableInfo.TableName, SelectQuery, InsertQuery, TableInfo.RecordCount,
                   TableInfo.Keyfields.Text,
                   // We only want to 'ignore' when duphandling is Ignore AND
                   // the Destination database exists..  otherwise we have created
                   // a new database so there will (in theory) be no duplicates.
                   // This saves a lot of time as we'll not check for duplicates prior
                   // to inserting.
                   (TableInfo.DupHandling = dhIgnore) and (fDestDBInfo.DBExists));
        AddLog('---- Complete:' + '"' + TableInfo.TableName + '"');
      end
      else if (TableInfo.CopyType = dcExternal)
      then begin
        AddLog('**** External: ' + '"' + TableInfo.TableName + '"');
        Result := BatchCopy(TableInfo);
        AddLog('---- Complete:' + '"' + TableInfo.TableName + '"');
      end;
      {$IFDEF STATS}
      EndTime := DateTimeToTimeStamp(NOW);
      TableInfo.Elapsed := Round(TimeStampToMSecs(EndTime) - TimeStampToMSecs(StartTime));
      TableInfo.BytesPerMin := (Result * TableInfo.RecordSize) / (TableInfo.Elapsed / 1000 / 60);
      {$ENDIF}
      if (DropTriggers)
      then begin
        AddLog('    Enabling triggers');
        sqlDest.SQL.Text := 'update RDB$TRIGGERS set RDB$TRIGGER_INACTIVE = 0 ' +
                            ' where ((not RDB$SYSTEM_FLAG = 1) or (rdb$system_flag is null)) and (RDB$RELATION_NAME = ''' +
                            TableInfo.TableName + ''')';
        sqlDest.ExecQuery;
        sqlDest.FreeHandle;
      end;
      // Dropping indexes only usable on flushed tables or new database
      if (DropIndexes) and ((TableInfo.DupHandling = dhFlush) or (not DestDBInfo.DBExists))
      then begin
        AddLog('    Enabling indexes');
        sqlDest.SQL.Text := 'update RDB$INDICES set RDB$INDEX_INACTIVE = 0 ' +
                            ' where ((not RDB$SYSTEM_FLAG = 1) or (rdb$system_flag is null)) and (RDB$RELATION_NAME = ''' +
                            TableInfo.TableName + ''')';
        sqlDest.ExecQuery;
        // Create primary key index
        if IndexQuery <> ''
        then begin
          sqlDest.SQL.Text := IndexQuery;
          sqlDest.ExecQuery;
        end;
        // Add constraint
        if ConstraintQuery <> ''
        then begin
          sqlDest.SQL.Text := ConstraintQuery;
          sqlDest.ExecQuery;
          sqlDest.FreeHandle;
        end;
      end;
    finally
      CloseAll;
    end;
  end
  else
  begin
    // Either skip was specified, or the record count is zero, report message.
    if (TableInfo.CopyType = dcSkip) then
      AddLog('  Skipped: ' + '"' + TableInfo.TableName + '"', toFile)
    else
    if (TableInfo.RecordSize = -1) then
      AddLog('  Corrupted Table: ' + '"' + TableInfo.TableName + '"' , toFile)
    else
    if (not TableExists(TableInfo.TableName, fDestDBInfo.Database)) then
      AddLog('  *ERROR: Destination table does not exist: ' + '"' + TableInfo.TableName + '"', toBoth)
    else
      AddLog('  Unknown Error: ' + '"' + TableInfo.TableName + '"', toFile)
  end;
end;  // CopyTable


{******************************************************************************
  ExternalCopy
  Base routine that handles exporting table data to an external file, importing
  it and deleting the external file.
 ******************************************************************************}
function TTableCopier.ExternalCopy(TableInfo: TTableInfo;SourceQuery, DestQuery: String): Integer;
var
  ExportCount,
  SkippedCount,
  ImportCount : Integer;
  ExtCreate: String;
  ExtFile: String;

begin // ExternalCopy
  SkippedCount := 0;
  // Only call this once, intitializes ExtFilename based on current
  // contents of tempdir.
  ExtCreate := TableInfo.ExtTableCreateQuery;
  ExtFile := TableInfo.ExtFileName;

  // Drop table, just in case..routine ignore exceptions
  DropTable(EXT_TABLE_NAME, fSourceDBInfo.Database, False);
  // Create external table on source database.
  AddLog('Creating External Table: ' + ExtCreate, toFile);
  sqlSource.SQL.Text := ExtCreate;
  sqlSource.ExecQuery;
  Commit(fSourceDBInfo.Database);

  try
    // Export data
    AddLog('Exporting Data: ' + SourceQuery, toFile);
    AddLog('  - Exporting Data', toDisplay);
    sqlSource.SQL.Text := SourceQuery;
    ExportCount := -1;
    try
      sqlSource.ExecQuery;
      ExportCount := sqlSource.RowsAffected;
    except
      on E:Exception
      do AddLog('Externalcopy Export Data: ' + E.Message, toFile);
    end;
  finally
    // Drop external table from source
    sqlSource.FreeHandle;
    DropTable(EXT_TABLE_NAME, fSourceDBInfo.Database);
  end;

  // Check the file size, if it's > fMaxDiskUsage, call the process a failure
  // so that we don't waste time trying to import.
  if (Int64FileSize(ExtFile) > fMaxDiskUsage)
  then ExportCount := -1;
  AddLog('Filesize: ' + IntToStr(Int64FileSize(ExtFile)), toFile);

  if (ExportCount <> -1) // Export was okay, proceed with import
  then begin
    // Drop table, just in case..routine ignore exceptions
    DropTable(EXT_TABLE_NAME, fDestDBInfo.Database, False);
    // Create external table on Destination
    AddLog('Creating External Table (Dest): ' + ExtCreate, toFile);
    sqlDest.SQL.Text := ExtCreate;
    sqlDest.ExecQuery;
    Commit(fDestDBInfo.Database);
    try
      // Import Data
      AddLog('Importing Data: ' + DestQuery, toFile);
      AddLog('  - Importing Data', toDisplay);
      sqlDest.SQL.Text := DestQuery;
      try
        sqlDest.ExecQuery;
        ImportCount := sqlDest.RowsAffected;
        // If we are skipping duplicates, consider the duplicate records
        // copied as they already exist.  This is managed by the caller which puts
        // a where clause on the import to not import existing records (see BatchCopy for details)
        if (TableInfo.DupHandling = dhIgnore)
        then SkippedCount := ExportCount - ImportCount;
      except
        on E:Exception
        do begin
          AddLog('Externalcopy Import Data: ' + E.Message, toFile);
          ImportCount := -1;
          SkippedCount := 0;
        end;
      end;
    finally
      // Drop external table from Destination
      sqlDest.FreeHandle;
      DropTable(EXT_TABLE_NAME, fDestDBInfo.Database);
    end;

    // Log detailed information about exported data to file.
    if (ImportCount = -1) and (ExportCount > 0)
    then Result := 0
    else begin
      if (SkippedCount > 0)
      then AddLog('Copied: ' + IntToStr(ImportCount) + ' records, ' + IntToStr(SkippedCount) + ' duplicates ignored', toFile)
      else AddLog('Copied: ' + IntToStr(ImportCount) + ' records', toFile);

      Result := ImportCount + SkippedCount; // return combined value, so progress is accurate
      // If the Export count isn't equal to the ImportCount + Skipped Count then report an error
      if (Result <> ExportCount)
      then AddLog('Record Count Mismatch: (' + IntToStr(ExportCount) + '/' +
                IntToStr(Result) + ')');
    end;
  end
  else Result := -1; // Flag export as failed!
  DeleteExternalFile(ExtFile);

  CloseWorkSQL;
end;  // ExternalCopy


{******************************************************************************
  QueryRecordCopy
  IgnoreDuplicates will try to find a Site and an ID or an ObjID field and delete
  the destination record that's the duplicate.  Then re-try the copy.
  If there is no ID or ObjID then an Exception is raised

  KeyFields is provided so that caller can specify what fields are key, this is
  necessary for non-metadata tables (CurrentObjIDStartRange and such).
 ******************************************************************************}
function TTableCopier.QueryRecordCopy(DestTable, SourceQuery, DestQuery: String;
                                      RecordCount: Integer;
                                      KeyFields: String = '';
                                      IgnoreDuplicates: Boolean = TRUE): Integer;
var
  CurCount,
  SkipCount,
  Loop: Integer;
  sqlWork, sqlTest: TIBSQL;
  slKeyFields: TStringList;
begin // QueryRecordCopy
  // Commit, just to make sure we start fresh
  Commit(fDestDBInfo.Database);
  Commit(fSourceDBInfo.Database);
  CurCount := 0;
  SkipCount := 0;
  sqlSource.SQL.Text := SourceQuery;
  sqlDest.SQL.Text := DestQuery;
  sqlWork := TIBSql.Create(NIL);
  sqlTest := TIBSql.Create(NIL);
  slKeyFields := TStringList.Create;
  ReportProgress(DestTable, CurCount + SkipCount, RecordCount);
  try
    slKeyFields.CommaText := KeyFields;
    // No keyfields, force ignore duplicates on!
    if (slKeyFields.Text = '')
    then IgnoreDuplicates := TRUE;

    sqlWork.Database := fDestDBInfo.Database;
    sqlTest.Database := fDestDBInfo.Database;
    if (slKeyFields.Count > 0) // Found key fields, setup delete and test queries
    then begin
      sqlTest.SQL.Text := 'select * from ' + '"' + DestTable + '"' + ' where ';
      sqlWork.SQL.Text := 'delete from ' + '"' + DestTable + '"' + ' where ';
      for Loop := 0 to (slKeyFields.Count - 1)
      do begin    // Iterate
        if (Loop = 0)
        then begin
          sqlWork.SQL.Text := sqlWork.SQL.Text + '(' + slKeyFields[Loop] +
                            ' = :' + slKeyFields[Loop] + ') ';
          sqlTest.SQL.Text := sqlTest.SQL.Text + '(' + slKeyFields[Loop] +
                            ' = :' + slKeyFields[Loop] + ') ';
        end
        else begin
          sqlWork.SQL.Text := sqlWork.SQL.Text + 'AND (' + slKeyFields[Loop] +
                            ' = :' + slKeyFields[Loop] + ') ';
          sqlTest.SQL.Text := sqlTest.SQL.Text + 'AND (' + slKeyFields[Loop] +
                            ' = :' + slKeyFields[Loop] + ') ';
        end;
      end;    // for
      sqlWork.Prepare;
      sqlTest.Prepare;
      // Make sure the slKeyFields objects are cleared, we'll use them below
      for Loop := 0 to slKeyFields.Count - 1
      do slKeyFields.Objects[loop] := nil;
    end;
    sqlDest.Prepare;
    sqlSource.ExecQuery;
    while (sqlSource.Open) and (not sqlSource.EOF)
    do begin
      try
        // Sent out status messages at a regular interval
        if ((CurCount + SkipCount) mod STATUS_INTERVAL = 0)
        then begin
          ReportProgress(DestTable, CurCount + SkipCount, RecordCount);
          Application.ProcessMessages;
          Commit(fDestDBInfo.Database);
        end;
        (*
                initial test seems to indicate checking for the duplicate instead of just
                allowing the exception is about twice as fast
        *)
        // Below code will check for a duplicate value prior to attempting insert.
        // Need to test with 100% conflict, 0% conflict and perhaps 50% conflict levels...
        if (IgnoreDuplicates) and (sqlTest.Prepared)
        then begin
          for Loop := 0 to (slKeyFields.Count - 1)
          do begin    // Iterate
            if (not assigned(slKeyFields.Objects[Loop]))
            then slKeyFields.Objects[Loop] := sqlSource.FieldByName(slKeyFields[Loop]);
            sqlTest.Params[Loop].Value := TIBXSQLVAR(slKeyFields.Objects[Loop]).Value;
          end;    // for
          sqlTest.ExecQuery;
          if (not sqlTest.EOF)
          then begin
            sqlTest.Close;
            sqlSource.Next;
            Inc(SkipCount);
            continue;
          end
          else sqlTest.Close;
        end;
        // Iterate all parameters on the Destination, and set them
        // to the same index field in the source query.
        for Loop := 0 to (sqlDest.Params.Count - 1)
        do begin    // Iterate
          SetIBXParam(sqlDest.Params[Loop], sqlSource.Fields[Loop]);
        end;    // for
        try
          sqlDest.ExecQuery;
          inc(CurCount);
        except
         on E:Exception
          do begin
            // Only log errors not caused by primary or unique indexes
            if (Pos('PRIMARY',E.Message) = 0) and (Pos('UNIQUE',E.Message) = 0)
            then AddLog('QueryRecordCopy: ' + E.Message + '(' + '"' + DestTable + '"'  + ')', toFile);
            if (not IgnoreDuplicates)
            then begin
              // Not ignoring duplicates, check and see if we can delete
              // otherwise log the error to the file with a note that sqlWork is
              // not prepared
              if (sqlWork.Prepared)
              then begin
                // Attempt to delete the duplicate and retry copy
                for Loop := 0 to (slKeyFields.Count - 1)
                do begin    // Iterate
                  sqlWork.Params[Loop].Value := sqlSource.FieldByName(slKeyFields[Loop]).Value;
                end;    // for
                try
                  sqlWork.ExecQuery;
                  sqlDest.ExecQuery; // Retry, should work now!
                except
                  on E:Exception
                  do begin
                    AddLog('QueryRecordCopy: ' + E.Message + '(deletion failed)', toFile);
                    Inc(SkipCount);
                  end;
                end;
                Inc(CurCount);
              end
              else AddLog('QueryRecordCopy: ' + E.Message + '(sqlWork not prepared)', toFile);
            end
            else Inc(SkipCount);
          end;
        end;
        sqlSource.Next;
      except
        on E:Exception
        do begin
          AddLog('  -- Record Copy Error: ' + E.Message + ' - Cancelling');
          sqlSource.Close;
        end;
      end;
    end;    // while
    // Report the final count.
    ReportProgress(DestTable, CurCount + SkipCount, RecordCount);
  finally
    FreeAndNil(sqlWork);
    FreeAndNil(slKeyFields);
    Result := CurCount;
  end;
  CloseWorkSQL;
end;  // QueryRecordCopy


{******************************************************************************
  TableExists
  This checks to see if a table name is present in Interbase's RDB$Relations
  table.  That is where Interbase keeps track of what tables it has and if
  the table name is present there, it should be ok to drop the table from
  the system.
  NOTE: This does not check for any dependencies on the table, only that it
  is there.  Droping a table while it is being referenced by other components
  of the database or by a query, ect. will cause the drop to fail.
 ******************************************************************************}
function TTableCopier.TableExists(TableName: String; DB: TIBDatabase; LogResult : boolean = FALSE): Boolean;
var
  sql: TIBSql;
begin // TableExists
  sql := TIBSql.Create(NIL);
  try
    sql.Database := DB;
    sql.sql.Text := 'select Count(*) from RDB$Relations ' +
                    'where RDB$Relation_Name = ''' + TableName + '''';
    sql.ExecQuery;
    Result := (sql.Fields[0].AsInteger = 1);
    if (not Result)
    then begin
      if (DB = fSourceDBInfo.Database)
      then AddLog(' - Source DB Table ' + '"' + TableName + '"' + ' does not exist', toFile)
      else AddLog(' - Dest DB Table ' + '"' + TableName + '"' + ' does not exist', toFile);
    end;
    sql.Close;
  finally
    sql.Free;
  end;
end;  // TableExists

{******************************************************************************
  DropTable
  Drop a table if it exists
 ******************************************************************************}
procedure TTableCopier.DropTable(TableName: String; DB: TIBDatabase;
                                 HaltOnException: Boolean = TRUE);
var
  sql: TIBSql;
begin // DropTable
  if (TableExists(TableName, DB))
  then begin
    if (DB = fSourceDBInfo.Database)
    then AddLog(' - Dropping Source DB Table ' + '"' + TableName + '"', toFile)
    else AddLog(' - Dropping Dest DB Table ' + '"' + TableName + '"', toFile);
    sql := TIBSql.Create(NIL);
    try
      try
        sql.Database := DB;
        sql.sql.Text := 'DROP TABLE ' + '"' + TableName + '"';
        sql.ExecQuery;
        Commit(DB);
      except
        if (HaltOnException)
        then raise;
      end;
    finally
      sql.Free;
      Commit(DB);
    end;
  end;
end;  // DropTable

{******************************************************************************
  Destroy
  Cleanup
 ******************************************************************************}
destructor TTableCopier.Destroy;
begin // Destroy
  if (fSourceDBInfo.Database.Connected)
  then begin
    if (fSourceDBInfo.Database.DefaultTransaction.InTransaction)
    then(fSourceDBInfo.Database.DefaultTransaction.Commit);
    fSourceDBInfo.Database.Close;
  end;
  if (fDestDBInfo.Database.Connected)
  then begin
    if (fDestDBInfo.Database.DefaultTransaction.InTransaction)
    then(fDestDBInfo.Database.DefaultTransaction.Commit);
    fDestDBInfo.Database.Close;
  end;
  FreeAndNil(sqlSource);
  FreeAndNil(sqlDest);
  Session.Active := FALSE;
end;  // Destroy

{******************************************************************************
  Create
  Create databases and IBSQL objects
 ******************************************************************************}
constructor TTableCopier.Create;
begin // Create
  //Don't keep connections, we must drop connections to delete the external files
  Session.KeepConnections := FALSE;
  sqlSource := TIBSql.Create(NIL);
  sqlDest := TIBSql.Create(NIL);
  //Variable initialization / Defaulting
  fMaxDiskUsage      := 0;
  fTempPath          := '';
end;  // Create


{******************************************************************************
  DeleteExternalFile
  Attempts to delete an external file, closes database connections
 ******************************************************************************}
procedure TTableCopier.DeleteExternalFile(Name: String);
var
  TimeOut: TDateTime;
  Ok:      Boolean;
begin // DeleteExternalFile
  if (Name <> '')
  then begin
    //if it never existed, then don't delete it
    if (not FileExists(Name))
    then begin
      AddLog('External file: ' + Name + ' not found.', toFile);
    end
    else begin
      AddLog('Deleting external file: ' + Name, toFile);
      // We must force all connections closed in order to free up
      // external table files.
      CloseAll;
      Timeout := Now + (1000 * 5);  //give some timeout value
      repeat
        Ok := SysUtils.DeleteFile(Name);
        if (not Ok)
        then Application.ProcessMessages;
      until (Ok) or (Now > TimeOut);
      if (not OK)
      then begin
        AddLog('-Unable to Delete External File: ' + Name, toFile);
      end;
      ReconnectAll;
    end;
  end;
end;  // DeleteExternalFile

{******************************************************************************
  SetTempPath
  Set fTempPath and validate
 ******************************************************************************}
procedure TTableCopier.SetTempPath(xTempPath: String);
var
  FreeSpace: Int64;
begin // SetTempPath
  if (xTempPath[Length(xTempPath)] <> '\')
  then xTempPath := xTempPath + '\';
  if not (DirectoryExists(xTempPath))
  then raise Exception.Create('TDBCopier: TempPath is invalid!');
  fTempPath := xTempPath;
  // Default max disk usage to 2gig or whatever is left ;-)
  FreeSpace := HDSpace(fTempPath[1]);
  //Leave 10% free or Max of 2 Gig
  FreeSpace := FreeSpace - Round(FreeSpace * 0.10);
  if (FreeSpace > MAX_EXT_FILE_SIZE) then FreeSpace := MAX_EXT_FILE_SIZE;
  fMaxDiskUsage := FreeSpace;
end;  // SetTempPath


{******************************************************************************
  SetMaxDiskUsage
  Set maximum space for external files, assures that there is enough space
  available on the temp path.
 ******************************************************************************}
procedure TTableCopier.SetMaxDiskUsage(xDiskUsage: Integer);
begin // SetMaxDiskUsage
  if (TempPath = '')
  then raise Exception.Create('TDBCopier: Programmer Error, must set TempPath first');
  if (xDiskUsage = 0)
  then raise Exception.Create('TDBCopier: Programmer Error, Max Disk Usage cannot be zero');
  if not (HDSpaceAvailable(TempPath[1], xDiskUsage))
  then raise Exception.Create('TDBCopier: Programmer Error, Max Disk Usage value > available space');
  fMaxDiskUsage := xDiskUsage;
end;  // SetMaxDiskUsage



end.

