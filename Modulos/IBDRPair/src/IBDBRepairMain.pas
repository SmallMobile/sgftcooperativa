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
                                
Compiler Directives:

  DEBUG - turns on some more detailed debugging information in logs
  STATS - Outputs statistics about performance to a log file
  DSI   - does some 'special' things for DRB Systems metadata structures.
 *************************************************************************)
unit IBDBRepairMain;
{ TODO :
Saving and Restoring table selections.  Might make sense to just save an 'ini'
style using the table name as the section, and allow loading which would just
ignore any missing tables.  Would be very useful for databases with tons of tables
I think. }

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, Dialogs, FileCtrl,
  Menus, ActnList, ToolWin, ImgList, WinSvc, Registry,
  // Database units
  Db, IBDatabase,
  // Custom Units
  IBDBRepairUtilities, IBTableCopier, IBRepairSupport, Messages;

const
  WM_NEXT = WM_USER + 199;

type
  TformDBRepairMain = class(TForm)
    psMain: TPageControl;
    Panel1: TPanel;
    tsSource: TTabSheet;
    Label1: TLabel;
    btnNext: TButton;
    btnPrev: TButton;
    btnCancel: TButton;
    tsCollectingInformation: TTabSheet;
    tsOptions: TTabSheet;
    editSourcedb: TEdit;
    Label4: TLabel;
    Panel2: TPanel;
    lblCollectingInfo: TLabel;
    Panel3: TPanel;
    memoCollectingInfo: TMemo;
    tsConfirm: TTabSheet;
    cboxTriggers: TCheckBox;
    cboxIndexes: TCheckBox;
    tsProgress: TTabSheet;
    memoProgress: TMemo;
    tsIntro: TTabSheet;
    memoIntro: TMemo;
    tsDest: TTabSheet;
    editDestDB: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    tsReady: TTabSheet;
    memoReady: TMemo;
    lvTables: TListView;
    puGrid: TPopupMenu;
    pumiSkip: TMenuItem;
    pumiExternal: TMenuItem;
    pumiRecordCopy: TMenuItem;
    N1: TMenuItem;
    pumiIgnore: TMenuItem;
    pumiFlushTable: TMenuItem;
    pumiOverwrite: TMenuItem;
    alMain: TActionList;
    actSkipCopy: TAction;
    actExternalCopy: TAction;
    actRecordCopy: TAction;
    actFlush: TAction;
    actIgnore: TAction;
    actOverwrite: TAction;
    actSetWhere: TAction;
    ilMain: TImageList;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Label2: TLabel;
    editTempPath: TEdit;
    Label6: TLabel;
    memoConfirm: TMemo;
    pbTotal: TProgressBar;
    pbTable: TProgressBar;
    Label8: TLabel;
    Label3: TLabel;
    ilColumns: TImageList;
    N2: TMenuItem;
    pumiWhere: TMenuItem;
    sbtnBrowse: TSpeedButton;
    openDatabaseDialog: TOpenDialog;
    sbtnBrowseDest: TSpeedButton;
    actSelectAll: TAction;
    N3: TMenuItem;
    pumiSelectAll: TMenuItem;
    cboxAutoRepair: TCheckBox;
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvTablesAdvancedCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
      var DefaultDraw: Boolean);
    procedure lvTablesCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvTablesColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvTablesClick(Sender: TObject);
    procedure actSkipCopyExecute(Sender: TObject);
    procedure actExternalCopyExecute(Sender: TObject);
    procedure actRecordCopyExecute(Sender: TObject);
    procedure actFlushExecute(Sender: TObject);
    procedure actIgnoreExecute(Sender: TObject);
    procedure actOverwriteExecute(Sender: TObject);
    procedure actSetWhereExecute(Sender: TObject);
    procedure sbtnBrowseClick(Sender: TObject);
    procedure sbtnBrowseDestClick(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
  private
    { Private declarations }
    SourceDBInfo: TDatabaseInfo;
    DestDBInfo:   TDatabaseInfo;
    LLogFile: TLogFile;
    SortBy: Integer;
    Descending: Boolean;
    function ValidatePageChange(Next: Boolean) : Boolean;
    procedure DoPage(Next: Boolean);
    procedure HandleTableCopierProgress(TableName: String; CopiedCount, TotalCount: Int64);
    procedure DoNextPage(var Message: TMsg); message WM_NEXT;
  public
    { Public declarations }
  end;

var
  formDBRepairMain: TformDBRepairMain;


implementation

{$R *.DFM}

const
  PG_INTRO      = 0;
  PG_SOURCE_DB  = 1;
  PG_DEST_DB    = 2;
  PG_READY      = 3;
  PG_COLLECTING = 4;
  PG_OPTIONS    = 5;
  PG_CONFIRM    = 6;
  PG_PROGRESS   = 7;
  PG_DONE       = 8;

  {$IFDEF DEBUG}
  // Setting DEBUG allows you to not have to browse and select and
  // keep typing in username/passwords.  Make things much quicker.
  SOURCE_DB_PATH = 'd:\a.gdb';
  SOURCE_DB_USER = 'sysdba';
  SOURCE_DB_PASS = 'masterkey';
  DEST_DB_PATH   = 'd:\x.gdb';
  DEST_DB_USER   = 'sysdba';
  DEST_DB_PASS   = 'masterkey';
  TEMP_DIR       = 'd:\';
  {$ENDIF}

{******************************************************************************
  HandleTableCopierProgress
 ******************************************************************************}
procedure TformDBRepairMain.HandleTableCopierProgress(TableName: String; CopiedCount, TotalCount: Int64);
begin // HandleTableCopierProgress
  if TotalCount > 0
  then pbTable.Max := TotalCount
  else pbTable.Max := 0;
  pbTable.Position := CopiedCount;
  Application.ProcessMessages;
end;  // HandleTableCopierProgress

{******************************************************************************
  ValidatePageChange
  Any pre-page change logic goes here
 ******************************************************************************}
function TformDBRepairMain.ValidatePageChange(Next: Boolean): Boolean;
begin // ValidatePageChange
  Result := TRUE; // Assume OK
  case (psMain.ActivePageIndex) of    //
    PG_INTRO: begin // nothing...always okay
    end;
    PG_SOURCE_DB: begin
      if (Next)
      then begin
        btnNext.Enabled := FALSE;
        Result := FALSE;
        try
          if (editSourceDB.text = '')
          then ShowMessage('You must enter a database')
          else begin
            SourceDBInfo.Path := editSourceDB.Text;
            {$IFDEF DEBUG}
            SourceDBInfo.UserName := SOURCE_DB_USER;
            SourceDBInfo.Password := SOURCE_DB_PASS;
            {$ENDIF}
            Result := SourceDBInfo.GetUserInfo;
            if (Result)
            then Result := SourceDBInfo.TestConnection;
          end;
          if (Not Result)
          then begin
            editSourceDB.SelectAll;
            editSourceDB.SetFocus;
          end;
        finally
          btnNext.Enabled := TRUE;
        end;
      end;
    end;
    PG_DEST_DB: begin
      if (Next)
      then begin
        btnNext.Enabled := FALSE;
        Result := FALSE;
        try
          if (editDestDB.text = '')
          then ShowMessage('You must enter a database')
          else begin
            DestDBInfo.Path := editDestDB.Text;
            {$IFDEF DEBUG}
            DestDBInfo.UserName := DEST_DB_USER;
            DestDBInfo.Password := DEST_DB_PASS;
            {$ENDIF}
            Result := DestDBInfo.GetUserInfo;
            if (Not Result)
            then begin
              Result := (MessageDlg('Unable to confirm the username and password.  You entered Username: ' +
              DestDBInfo.UserName + ' and Password: ' + DestDBInfo.Password +
              '.  Are you sure these values are correct?',mtConfirmation, [mbYes, mbNo],0) = idYes);
            end;
          end;
          if (Not Result)
          then begin
            editDestDB.SelectAll;
            editDestDB.SetFocus;
          end;
        finally
          btnNext.Enabled := TRUE;
        end;
      end;
    end;
    PG_READY: begin
    end;
    PG_COLLECTING: begin
      btnNext.Enabled := FALSE;
    end;
    PG_OPTIONS: begin
    end;
    PG_CONFIRM: begin
    end;
    PG_PROGRESS: begin
    end;
    PG_DONE: begin
    end;
  end;
end;  // ValidatePageChange


{******************************************************************************
  DoPage
  Post page change, DoPage handles whatever work is required after the page
  change has passed the validate routine.
 ******************************************************************************}
procedure TformDBRepairMain.DoPage(Next: Boolean);
var
  Loop: Integer;
  CurrTableInfo: TTableInfo;
  CurrItem: TListItem;
  TotalRecords: Int64;
  SourceFileSize: Int64;
  TableCopier: TTableCopier;
  TotalCopied,
  TableCopied : Int64;
  {$IFDEF STATS}
  StatsList: TStringList;
  StartTime,
  EndTime: TTimeStamp;
  ElapsedTime: Double;
  TestTag: String;
  {$ENDIF}


begin // DoPage
  case (psMain.ActivePageIndex) of    //
    PG_INTRO: begin // nothing to do here.
    end;
    PG_SOURCE_DB: begin
      {$IFNDEF DEBUG}
      // Blank out SourceDB params!
      SourceDBInfo.Path := '';
      SourceDBInfo.UserName := '';
      SourceDBInfo.Password := '';
      editSourcedb.SetFocus;
      {$ENDIF}
    end;
    PG_DEST_DB: begin
      {$IFNDEF DEBUG}
      // Blank out DestDB params!
      DestDBInfo.Path := '';
      DestDBInfo.UserName := '';
      DestDBInfo.Password := '';
      editDestDB.SetFocus;
      {$ENDIF}
    end;
    PG_READY: begin
      if (Next)
      then begin
        memoReady.Lines.Clear;
        memoReady.Lines.Add('** The next step could take a while.  ' +
          'Please verify the below databases and users are correct before pressing the Next button:' );
        memoReady.Lines.Add('');
        memoReady.Lines.Add('     Source Database: ' + SourceDBInfo.Path);
        memoReady.Lines.Add('           User Name: ' + SourceDBInfo.UserName);
        memoReady.Lines.Add('');
        memoReady.Lines.Add('Destination Database: ' + DestDBInfo.Path);
        memoReady.Lines.Add('           User Name: ' + DestDBInfo.UserName);
        memoReady.Lines.Add('');
        if (DestDBInfo.DBExists)
        then begin
          memoReady.Lines.Add('***************************** Warning *****************************');
          memoReady.Lines.Add('The destination database already exists, you must be 100% sure that');
          memoReady.Lines.Add('this database has the same structure as the source database!');
          memoReady.Lines.Add('');
          memoReady.Lines.Add('if not, use the Previous button to change the database name/location.');
        end
        else memoReady.Lines.Add('Destination database will be created.');
      end;
    end;
    PG_COLLECTING: begin
      btnNext.Enabled := FALSE;
      btnPrev.Enabled := FALSE;
      btnCancel.Enabled := FALSE;
      try
        Application.ProcessMessages;
        LLogFile.Memo := memoCollectingInfo;
        // Do we need to create the destination database?  If so, get the metadata
        if (Not DestDBInfo.DBExists)
        then begin
          // Below call will not return until done
          SourceDBInfo.LoadMetadata;
        end;
        // Collect table information
        SourceDBInfo.LoadTableInformation(DestDBInfo);
        lblCollectingInfo.Caption := '** Done';
      finally
        btnNext.Enabled := (SourceDBInfo.TableList.Count > 0);
        btnPrev.Enabled := TRUE;
        btnCancel.Enabled := TRUE;
        if cboxAutoRepair.Checked then  PostMessage(Handle, WM_NEXT, 0, 0);
      end;
    end;
    PG_OPTIONS: begin
      if cboxAutoRepair.Checked then  PostMessage(Handle, WM_NEXT, 0, 0)
      else begin
        lvTables.Items.Clear;
        for Loop := 0 to SourceDBInfo.TableList.Count - 1
        do begin
          CurrTableInfo := TTableInfo(SourceDBInfo.TableList.Objects[Loop]);
          CurrItem := lvTables.Items.Add;
          CurrItem.Caption := '"' + CurrTableInfo.TableName + '"';
          CurrItem.ImageIndex := -1;
          CurrItem.Checked := TRUE;
          CurrItem.SubItems.Add('na');
          CurrItem.SubItems.Add('nb');
          CurrItem.SubItems.Add(IntToStr(CurrTableInfo.RecordCount));
          CurrItem.SubItems.Add(CurrTableInfo.ExportWhere);
          CurrItem.Data := CurrTableInfo;
        end;
      end;
    end;
    PG_CONFIRM: begin
      memoConfirm.Clear;
      editTempPath.Text := ExtractFilePath(Paramstr(0));
      TotalRecords := 0;
      for Loop := 0 to SourceDBInfo.TableList.Count - 1
      do begin
        TotalRecords := TotalRecords + TTableInfo(SourceDBInfo.TableList.Objects[Loop]).RecordCount;
      end;
      if (SourceDBInfo.IsLocal)
      then SourceFileSize := GetDatabaseSize(SourceDBInfo.Path)
      else SourceFileSize := -1;
      memoConfirm.Lines.Add('Ready to copy ' + SourceDBInfo.Path + ' to ' +
        DestDBInfo.Path);
      memoConfirm.Lines.Add('');
      if (SourceFileSize > 0)
      then memoConfirm.Lines.Add('Source Database appears to use ' + MemSizeToStr(SourceFileSize) +
        ' make sure there is at least that much free space where the destination database ' +
        'will be located')
      else memoConfirm.Lines.Add('Source Database is not local, unable to determine ' +
        'how much disk space it is using.  You will need to make sure there is enough ' +
        'space on the where the destination database is located!.');
      memoConfirm.Lines.Add('');
      memoConfirm.Lines.Add(IntToStr(TotalRecords) + ' Total Records will be copied');
      if cboxAutoRepair.Checked then PostMessage(Handle, WM_NEXT, 0, 0);
    end;
    PG_PROGRESS: begin
      btnNext.Enabled := FALSE;
      btnPrev.Enabled := FALSE;
      btnCancel.Enabled := FALSE;
      lLogFile.AddLog('Repairing:  ' + SourceDBInfo.Path + ' > ' + DestDBInfo.Path);
      TotalRecords := 0;
      for Loop := 0 to SourceDBInfo.TableList.Count - 1
      do begin
        TotalRecords := TotalRecords + TTableInfo(SourceDBInfo.TableList.Objects[Loop]).RecordCount;
      end;
      TotalCopied  := 0;
      try
        memoProgress.Lines.Clear;
        lLogFile.Memo := memoProgress;
        {$IFDEF STATS}
        StartTime := DateTimeToTimeStamp(NOW);
        {$ENDIF}
        // Create destination if we need to, sourcedb already loaded metadata.
        if (Not DestDBInfo.DBExists)
        then begin
          DestDBInfo.MetaData.Text := SourceDBInfo.MetaData.Text;
          DestDBInfo.PutMetaData;
        end;
//        lLogFile.AddLog('Disabling Triggers');
//        DestDBInfo.DisableAllTriggers;
//        lLogFile.AddLog('   - Done');
        // Copy all the table data here!!!
        TableCopier := TTableCopier.Create;
        TableCopier.TempPath := editTempPath.Text;
        TableCopier.SourceDBInfo := SourceDBInfo;
        TableCopier.DestDBInfo   := DestDBInfo;
        TableCopier.OnLog := lLogfile.AddLog;
        TableCopier.OnProgress := HandleTableCopierProgress;
        pbTotal.Max := SourceDBInfo.TableList.Count;
        for Loop := 0 to SourceDBInfo.TableList.Count - 1
        do begin
          CurrTableInfo := TTableInfo(SourceDBInfo.TableList.Objects[Loop]);
          CurrTableInfo.TempPath := editTempPath.Text;
//          if CurrTableInfo.TableName <> 'col$tiposcuota' then
          try
            TableCopied := TableCopier.CopyTable(CurrTableInfo,
                                  cboxTriggers.Checked, cboxIndexes.Checked);
          except
            on E:Exception
            do begin
              lLogFile.AddLog('CopyTable: ' + E.Message);
              raise;
            end;
          end;
          // -1 means table skipped or empty, a 0 would indicate a problem
          // with the copy attempt.
          if (TableCopied > -1)
          then begin
            lLogFile.AddLog('"' + CurrTableInfo.TableName + '"' + ' : ' + IntToStr(TableCopied));
            TotalCopied := TotalCopied + TableCopied;
          end;
          pbTotal.StepIt;
          Application.ProcessMessages;
        end;
        // Below number should match.
        lLogFile.AddLog('*** Copied: ' + IntToStr(TotalCopied) + ' of ' + IntToStr(TotalRecords));
//        lLogFile.AddLog('Enabling Triggers');
//        DestDBInfo.DisableAllTriggers;
//        lLogFile.AddLog('   - Done');


        {$IFDEF STATS}
        EndTime := DateTimeToTimeStamp(NOW);
        ElapsedTime := ((TimeStampToMSecs(EndTime) - TimeStampToMSecs(StartTime)) / 1000 / 60);

        InputQuery('Test Name:', 'Enter name of this test run', TestTag);

        // Statistics reporting, using this for debugging and testing purposes only
        StatsList := TStringList.Create;
        try
          try
            StatsList.LoadFromFile('stats.txt');
          except
            StatsList.Clear;
          end;
          // If it's new, put in the header
          if (StatsList.Count = 0)
          then StatsList.Add('"Table","Copy Type","Bytes per Minute","Record Size","Record Count","Elapsed Time (MS)"');
          StatsList.Add(TestTag + ' total time (including any database creation: ' + FloatToStrF(ElapsedTime, ffFixed, 15, 3) + ' minutes');
          for Loop := 0 to SourceDBInfo.TableList.Count - 1
          do begin
            CurrTableInfo := TTableInfo(SourceDBInfo.TableList.Objects[Loop]);
            if (CurrTableInfo.CopyType = dcExternal)
            then StatsList.Add('"' + CurrTableInfo.TableName + '"' + ',E,' +
                         FloatToStrF(CurrTableInfo.BytesPerMin, ffFixed, 15, 3) + ',' +
                         IntToStr(CurrTableInfo.RecordSize) + ', ' +
                         IntToStr(CurrTableInfo.RecordCount) + ', ' +
                         IntToStr(CurrTableInfo.Elapsed))
            else if (CurrTableInfo.CopyType = dcRecord)
            then StatsList.Add('"' + CurrTableInfo.TableName + '"' + ',R,' +
                         FloatToStrF(CurrTableInfo.BytesPerMin, ffFixed, 15, 3) + ',' +
                         IntToStr(CurrTableInfo.RecordSize) + ', ' +
                         IntToStr(CurrTableInfo.RecordCount) + ', ' +
                         IntToStr(CurrTableInfo.Elapsed))
          end;
          StatsList.SaveToFile('stats.txt');
        finally
          FreeAndNil(StatsList);
        end;
        {$ENDIF}

      finally
        lLogFile.AddLog('**************************');
        lLogFile.AddLog('**      Completed       **');
        lLogFile.AddLog('**************************');
        btnCancel.Enabled := TRUE;
        btnCancel.Caption := 'E&xit';
        if cboxAutoRepair.Checked then btnCancelClick(Self);
      end;
    end;
    PG_DONE: begin
    end;
  end;
end;  // DoPage


{******************************************************************************
  btnNextClick
 ******************************************************************************}
procedure TformDBRepairMain.btnNextClick(Sender: TObject);
begin // btnNextClick
  if ValidatePageChange(TRUE)
  then begin
    psMain.ActivePageIndex  := psMain.ActivePageIndex + 1;
    btnNext.Enabled := psMain.ActivePageIndex < (psMain.PageCount - 1);
    btnPrev.Enabled := psMain.ActivePageIndex > 0;
    DoPage(TRUE);
  end;
end;  // btnNextClick

{******************************************************************************
  btnPrevClick
 ******************************************************************************}
procedure TformDBRepairMain.btnPrevClick(Sender: TObject);
begin // btnPrevClick
  if ValidatePageChange(False)
  then begin
    psMain.ActivePageIndex  := psMain.ActivePageIndex - 1;
    btnPrev.Enabled := psMain.ActivePageIndex > 0;
    btnNext.Enabled := psMain.ActivePageIndex < (psMain.PageCount - 1);
    DoPage(FALSE);
  end;
end;  // btnPrevClick

{******************************************************************************
  btnCancelClick
 ******************************************************************************}
procedure TformDBRepairMain.btnCancelClick(Sender: TObject);
begin // btnCancelClick
  Close;
end;  // btnCancelClick

{******************************************************************************
  FormCreate
 ******************************************************************************}
procedure TformDBRepairMain.FormCreate(Sender: TObject);
var
  FBRunning, IBRunning: Boolean;
  FBVersion, IBVersion: String;
  Reg: TRegistry;

  function ServiceRunning(ServiceName: String): Boolean;
  var
    ServiceHandle : SC_HANDLE;
    ServiceStatus : TServiceStatus;
    SvcManager: SC_HANDLE;

  begin
    Result := FALSE;
    try
      SvcManager := OpenSCManager(NIL, NIL, SC_MANAGER_CONNECT);
      ServiceHandle := OpenService(SvcManager, pChar(ServiceName), SERVICE_ALL_ACCESS);
      try
        if (QueryServiceStatus(ServiceHandle, ServiceStatus))
        then Result := ServiceStatus.dwCurrentState = SERVICE_RUNNING;
      finally
        CloseServiceHandle(ServiceHandle);
      end;
    except
      // Ignore
    end;
  end;

  function ApplicationRunning(ClassName: String) : Boolean;
  var
    xClassName : array[0..512] of char;
  begin
    StrPCopy(xClassName, ClassName);
    Result := (FindWindow(xClassName, NIL) <> 0);
  end;

begin // FormCreate
  SortBy := 0; // TableName
  Descending := FALSE;
  SourceDBInfo := TDatabaseInfo.Create;
  DestDBInfo := TDatabaseInfo.Create;
  psMain.ActivePageIndex := 0;
  LLogFile := TLogFile.Create;
  LLogFile.FileName := 'DBRepair.Log';
  SourceDBInfo.LogFile := LLogFile;
  DestDBInfo.LogFile   := LLogFile;
  SourceDBInfo.TempPath := ExtractFilePath(ParamStr(0));
  DestDBInfo.TempPath := ExtractFilePath(ParamStr(0));
  {$IFDEF DEBUG}
  editSourcedb.Text := SOURCE_DB_PATH;
  editDestDB.Text   := DEST_DB_PATH;
  editTempPath.Text := TEMP_DIR;
  {$ENDIF}
  SpeedButton1.Caption := '';
  SpeedButton2.Caption := '';
  SpeedButton3.Caption := '';
  SpeedButton4.Caption := '';
  SpeedButton5.Caption := '';
  SpeedButton6.Caption := '';
  SpeedButton7.Caption := '';

  IBRunning := ServiceRunning('InterBaseServer') or ApplicationRunning('IB_Server');
  FBRunning := ServiceRunning('FirebirdServer') or
               ServiceRunning('FirebirdServerDefaultInstance') or  // FB 1.5
               ApplicationRunning('FB_Server');

  IBVersion := '';
  FBVersion := '';
  Reg := TRegistry.Create;
  try
    try
      Reg.RootKey := HKEY_LOCAL_MACHINE;  //Assume Local Machine Keys!
      Reg.OpenKey('\SOFTWARE\FirebirdSQL\Firebird\CurrentVersion',FALSE);
      FBVersion := IncludeTrailingBackslash(Reg.ReadString('Version'));
    except
    end;
    if (FBVersion = '\') then FBVersion := 'Unknown'; // 1.5 removed Version from registry
    Reg.CloseKey;
    try
      Reg.OpenKey('\SOFTWARE\InterBase Corp\InterBase\CurrentVersion', FALSE);
      IBVersion := IncludeTrailingBackslash(Reg.ReadString('Version'));
    except
    end;
    Reg.CloseKey;
  finally
    Reg.Free;
  end;

  if (IBRunning and FBRunning)
  then begin
    memoIntro.Lines.Clear;
    memoIntro.Lines.Add('Both InterBase and Firebird servers are running!  Unable to continue!');
    btnNext.Enabled := FALSE;
    raise Exception.Create('Both InterBase and Firebird servers are running!  Unable to continue!');
  end;

  if ((not IBRunning) and (not FBRunning))
  then begin
    memoIntro.Lines.Clear;
    memoIntro.Lines.Add('Unable to detect which whether InterBase or FireBird is running.  Please make sure the correct program is running before going on.');
  end;

  memoIntro.Lines.Add('');
  memoIntro.Lines.Add('Detected Server Engines');
  if (IBVersion <> '')
  then memoIntro.Lines.Add('InterBase Server: ' + IBVersion);
  if (FBVersion <> '')
  then memoIntro.Lines.Add('Firebird Server : ' + FBVersion);
  memoIntro.Lines.Add('');
  if FBRunning
  then begin
    SourceDBInfo.UseFirebird := TRUE;
    DestDBInfo.UseFirebird := TRUE;
    memoIntro.Lines.Add('Firebird Server is currently running and will be used.');
    Caption := 'Firebird Database Repair Utility';
  end
  else if IBRunning
  then begin
    SourceDBInfo.UseFirebird := FALSE;
    DestDBInfo.UseFirebird := FALSE;
    memoIntro.Lines.Add('InterBase Server is currently running and will be used.');
    Caption := 'InterBase Database Repair Utility';
  end;

  // If both IB and FB servers are installed, warn user!
  if ((FBVersion <> '') and (IBVersion <> ''))
  then MessageDlg('You have both Firebird and InterBase installed on this machine, ' +
  'Please make sure the correct server is running', mtWarning, [mbOk], 0);
end;  // FormCreate

{******************************************************************************
  FormDestroy
 ******************************************************************************}
procedure TformDBRepairMain.FormDestroy(Sender: TObject);
begin // FormDestroy
  FreeAndNil(SourceDBInfo);
  FreeAndNil(DestDBInfo);
  FreeAndNil(LLogFile);
end;  // FormDestroy

{******************************************************************************
  lvTablesAdvancedCustomDrawItem
 ******************************************************************************}
procedure TformDBRepairMain.lvTablesAdvancedCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage; var DefaultDraw: Boolean);
var
  CurrTable : TTableInfo;

begin // lvTablesAdvancedCustomDrawItem
  if (Stage = cdPrePaint)
  then begin
    if (Item.Data <> NIL)
    then begin
      CurrTable := TTableInfo(Item.Data);
      if (Item.Checked <> (CurrTable.CopyType <> dcSkip))
      then Item.Checked := CurrTable.CopyType <> dcSkip;
      case CurrTable.CopyType of
        dcSkip: begin
          if Item.SubItems[0] <> 'Skip'
          then Item.SubItems[0] := 'Skip';
        end;
        dcExternal: begin
          if Item.SubItems[0] <> 'External'
          then Item.SubItems[0] := 'External';
        end;
        dcRecord  : begin
          if  Item.SubItems[0] <> 'Record'
          then Item.SubItems[0] := 'Record';
        end;
      end;
      case CurrTable.DupHandling of
        dhFlush: begin
          if (Item.SubItems[1] <> 'Flush')
          then Item.SubItems[1] := 'Flush';
        end;
        dhIgnore: begin
          if (Item.SubItems[1] <> 'Ignore')
          then Item.SubItems[1] := 'Ignore';
        end;
        dhOverwrite: begin
          if (Item.SubItems[1] <> 'Overwrite')
          then Item.SubItems[1] := 'Overwrite';
        end;
      end;
      if (Item.SubItems[2] <> IntToStr(CurrTable.RecordCount))
      then Item.SubItems[2] := IntToStr(CurrTable.RecordCount);
      if (Item.SubItems[3] <> CurrTable.ExportWhere)
      then Item.SubItems[3] := CurrTable.ExportWhere;
    end;
  end;
  DefaultDraw := TRUE;
end;  // lvTablesAdvancedCustomDrawItem

{******************************************************************************
  lvTablesCompare
 ******************************************************************************}
procedure TformDBRepairMain.lvTablesCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin // lvTablesCompare
  if (SortBy = 0)
  then begin
    if (Descending)
    then Compare := CompareText(Item2.Caption, Item1.Caption)
    else Compare := CompareText(Item1.Caption, Item2.Caption)
  end
  else if SortBy < 3
  then begin
    if (Descending)
    then Compare := CompareText(Item2.SubItems[SortBy - 1],Item1.SubItems[SortBy - 1])
    else Compare := CompareText(Item1.SubItems[SortBy - 1],Item2.SubItems[SortBy - 1])
  end
  else begin
    if (TTableInfo(Item1.Data).RecordCount < TTableInfo(Item2.Data).RecordCount)
    then Compare := -1
    else if (TTableInfo(Item1.Data).RecordCount > TTableInfo(Item2.Data).RecordCount)
    then Compare := 1
    else Compare := 0;
    if (Descending)
    then begin
      if (Compare = 1)
      then Compare := -1
      else if (Compare = -1)
      then Compare := 1;
    end;
  end;
end;  // lvTablesCompare

{******************************************************************************
  lvTablesColumnClick
 ******************************************************************************}
procedure TformDBRepairMain.lvTablesColumnClick(Sender: TObject;
  Column: TListColumn);
begin // lvTablesColumnClick
  if (Column.Index < 4) // Only first 4 column sortable
  then begin
    if (SortBy = Column.Index)
    then begin
      Descending := Not Descending;
      if (Descending)
      then Column.ImageIndex := 0
      else Column.ImageIndex := 1;
    end
    else begin
      TListView(Sender).Columns[SortBy].ImageIndex := 2; // reset sort image
      SortBy := Column.Index;
      Column.ImageIndex := 1;
      Descending := FALSE;
    end;
    TListView(Sender).Alphasort;
  end;
end;  // lvTablesColumnClick

{******************************************************************************
  lvTablesClick
 ******************************************************************************}
procedure TformDBRepairMain.lvTablesClick(Sender: TObject);
var
  CurrTable: TTableInfo;
begin // lvTablesClick
  if (TListView(Sender).SelCount = 1)
  then begin
    CurrTable := TTableInfo(TListView(Sender).Selected.Data);
    if (CurrTable.CopyType = dcSkip)
    then begin
      actSkipCopy.Enabled := FALSE;
      actRecordCopy.Enabled := TRUE;
      actExternalCopy.Enabled := TRUE;
      actFlush.Enabled := FALSE;
      actIgnore.Enabled := FALSE;
      actOverwrite.Enabled := FALSE;
      actSetWhere.Enabled := FALSE;
    end
    else begin
      actSkipCopy.Enabled := TRUE;
      actRecordCopy.Enabled := TRUE;
      actFlush.Enabled := TRUE;
      actIgnore.Enabled := TRUE;
      if (CurrTable.CopyType = dcExternal)
      then actOverwrite.Enabled := FALSE
      else actOverwrite.Enabled := TRUE;
      if (CurrTable.HasBlobs)
      then actExternalCopy.Enabled := FALSE
      else actExternalCopy.Enabled := TRUE;
      actSetWhere.Enabled := TRUE;
    end;
  end
  else if (TListView(Sender).SelCount > 1)
  then begin
    actSkipCopy.Enabled := TRUE;
    actExternalCopy.Enabled := TRUE;
    actRecordCopy.Enabled := TRUE;
    actFlush.Enabled := TRUE;
    actIgnore.Enabled := TRUE;
    actOverwrite.Enabled := TRUE;
    actSetWhere.Enabled := FALSE;
  end
  else begin
    actSkipCopy.Enabled := FALSE;
    actExternalCopy.Enabled := FALSE;
    actRecordCopy.Enabled := FALSE;
    actFlush.Enabled := FALSE;
    actIgnore.Enabled := FALSE;
    actOverwrite.Enabled := FALSE;
    actSetWhere.Enabled := FALSE;
  end;
end;  // lvTablesClick

{******************************************************************************
  actSkipCopyExecute
 ******************************************************************************}
procedure TformDBRepairMain.actSkipCopyExecute(Sender: TObject);
var
  CurrTable: TTableInfo;
  Loop: Integer;
begin // actSkipCopyExecute
  if (lvTables.SelCount = 1)
  then begin
    CurrTable := TTableInfo(lvTables.Selected.Data);
    CurrTable.CopyType := dcSkip;
    lvTables.Refresh;
  end
  else if (lvTables.SelCount > 1)
  then begin
    for Loop := 0 to lvTables.Items.Count - 1
    do begin
      if (lvTables.Items[Loop].Selected)
      then begin
        CurrTable := TTableInfo(lvTables.Items[Loop].Data);
        CurrTable.CopyType := dcSkip;
      end;
    end;
    lvTables.Refresh;
  end;
end;  // actSkipCopyExecute

{******************************************************************************
  actExternalCopyExecute
 ******************************************************************************}
procedure TformDBRepairMain.actExternalCopyExecute(Sender: TObject);
var
  CurrTable: TTableInfo;
  Loop: Integer;
begin // actExternalCopyExecute
  if (lvTables.SelCount = 1)
  then begin
    CurrTable := TTableInfo(lvTables.Selected.Data);
    try
      CurrTable.CopyType := dcExternal;
    except
      // Ignore exception, it'll just not change the value.
    end;
    lvTables.Refresh;
  end
  else if (lvTables.SelCount > 1)
  then begin
    for Loop := 0 to lvTables.Items.Count - 1
    do begin
      if (lvTables.Items[Loop].Selected)
      then begin
        CurrTable := TTableInfo(lvTables.Items[Loop].Data);
        try
          CurrTable.CopyType := dcExternal;
        except
          // Ignore exception, it'll just not change the value.
        end;
      end;
    end;
    lvTables.Refresh;
  end;
end;  // actExternalCopyExecute

{******************************************************************************
  actRecordCopyExecute
 ******************************************************************************}
procedure TformDBRepairMain.actRecordCopyExecute(Sender: TObject);
var
  CurrTable: TTableInfo;
  Loop: Integer;
begin // actRecordCopyExecute
  if (lvTables.SelCount = 1)
  then begin
    CurrTable := TTableInfo(lvTables.Selected.Data);
    CurrTable.CopyType := dcRecord;
    lvTables.Refresh;
  end
  else if (lvTables.SelCount > 1)
  then begin
    for Loop := 0 to lvTables.Items.Count - 1
    do begin
      if (lvTables.Items[Loop].Selected)
      then begin
        CurrTable := TTableInfo(lvTables.Items[Loop].Data);
        CurrTable.CopyType := dcRecord;
      end;
    end;
    lvTables.Refresh;
  end;
end;  // actRecordCopyExecute

{******************************************************************************
  actFlushExecute
 ******************************************************************************}
procedure TformDBRepairMain.actFlushExecute(Sender: TObject);
var
  CurrTable: TTableInfo;
  Loop: Integer;
begin // actFlushExecute
  if (lvTables.SelCount = 1)
  then begin
    CurrTable := TTableInfo(lvTables.Selected.Data);
    CurrTable.DupHandling := dhFlush;
    lvTables.Refresh;
  end
  else if (lvTables.SelCount > 1)
  then begin
    for Loop := 0 to lvTables.Items.Count - 1
    do begin
      if (lvTables.Items[Loop].Selected)
      then begin
        CurrTable := TTableInfo(lvTables.Items[Loop].Data);
        CurrTable.DupHandling := dhFlush;
      end;
    end;
    lvTables.Refresh;
  end;
end;  // actFlushExecute

{******************************************************************************
  actIgnoreExecute
 ******************************************************************************}
procedure TformDBRepairMain.actIgnoreExecute(Sender: TObject);
var
  CurrTable: TTableInfo;
  Loop: Integer;
begin // actIgnoreExecute
  if (lvTables.SelCount = 1)
  then begin
    CurrTable := TTableInfo(lvTables.Selected.Data);
    CurrTable.DupHandling := dhIgnore;
    lvTables.Refresh;
  end
  else if (lvTables.SelCount > 1)
  then begin
    for Loop := 0 to lvTables.Items.Count - 1
    do begin
      if (lvTables.Items[Loop].Selected)
      then begin
        CurrTable := TTableInfo(lvTables.Items[Loop].Data);
        CurrTable.DupHandling := dhIgnore;
      end;
    end;
    lvTables.Refresh;
  end;
end;  // actIgnoreExecute

{******************************************************************************
  actOverwriteExecute
 ******************************************************************************}
procedure TformDBRepairMain.actOverwriteExecute(Sender: TObject);
var
  CurrTable: TTableInfo;
  Loop: Integer;
begin // actOverwriteExecute
  if (lvTables.SelCount = 1)
  then begin
    CurrTable := TTableInfo(lvTables.Selected.Data);
    try
      CurrTable.DupHandling := dhOverwrite;
    except
    end;
    lvTables.Refresh;
  end
  else if (lvTables.SelCount > 1)
  then begin
    for Loop := 0 to lvTables.Items.Count - 1
    do begin
      if (lvTables.Items[Loop].Selected)
      then begin
        CurrTable := TTableInfo(lvTables.Items[Loop].Data);
        try
        CurrTable.DupHandling := dhOverwrite;
        except
        end;
      end;
    end;
    lvTables.Refresh;
  end;
end;  // actOverwriteExecute

{******************************************************************************
  actSetWhereExecute
 ******************************************************************************}
procedure TformDBRepairMain.actSetWhereExecute(Sender: TObject);
var
  CurrTable: TTableInfo;
  WhereClause: String;
begin // actSetWhereExecute
  btnNext.Enabled := FALSE;
  btnPrev.Enabled := FALSE;
  btnCancel.Enabled := FALSE;
  Screen.Cursor := crHourglass;
  try
    if (lvTables.SelCount = 1)
    then begin
      CurrTable := TTableInfo(lvTables.Selected.Data);
      WhereClause := CurrTable.ExportWhere;
      InputQuery('Where Clause:', 'Enter export where clause', WhereClause);
      if (WhereClause <> CurrTable.ExportWhere)
      then begin
        SourceDBInfo.ConnectDB;
        try
          CurrTable.SetExportWhere(WhereClause, SourceDBInfo.Database);
          lvTables.Refresh;
        finally
          SourceDBInfo.DisconnectDB;
        end;
      end;
    end
  finally
    btnNext.Enabled := TRUE;
    btnPrev.Enabled := TRUE;
    btnCancel.Enabled := TRUE;
    Screen.Cursor := crDefault;
  end;
end;  // actSetWhereExecute

{******************************************************************************
  sbtnBrowseClick
 ******************************************************************************}
procedure TformDBRepairMain.sbtnBrowseClick(Sender: TObject);
begin // sbtnBrowseClick
  if (OpenDatabaseDialog.Execute)
  then editSourcedb.Text := OpenDatabaseDialog.FileName;
end;  // sbtnBrowseClick

{******************************************************************************
  sbtnBrowseDestClick
 ******************************************************************************}
procedure TformDBRepairMain.sbtnBrowseDestClick(Sender: TObject);
begin // sbtnBrowseDestClick
  if (OpenDatabaseDialog.Execute)
  then editDestdb.Text := OpenDatabaseDialog.FileName;
end;  // sbtnBrowseDestClick

{******************************************************************************
  actSelectAllExecute
 ******************************************************************************}
procedure TformDBRepairMain.actSelectAllExecute(Sender: TObject);
var
  Loop: Integer;
begin // actSelectAllExecute
  for Loop := 0 to lvTables.Items.Count - 1
  do begin
    lvTables.Items[Loop].Selected := TRUE;
  end;
end;  // actSelectAllExecute

procedure TFormDBRepairMain.DoNextPage(var Message: TMsg);
begin
  btnNextClick(Self);
end;

end.




