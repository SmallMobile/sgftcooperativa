unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  cmpTrayIcon, Menus, IBCtrls, ExtCtrls, StdCtrls, ComCtrls,
  WinTypes, WinProcs, IBAPI, IBDBAPI,
  Rascomp32, IniFiles, Buttons, DB,

  IBDatabase, IBCustomDataSet, IBQuery, IBEvents;

const
  MaxBlobSize = 128000;    { This can be modified modifying the INI file(BlobMaxBytes)}
  MaxColumns  = 1024;
  ChangeSelect = 'SELECT CHANGECODE,TABLENAME,TABLEKEY,OP FROM CHANGES WHERE LOC_ID = ? ORDER BY CHANGECODE';
  ChangeDelete = 'DELETE FROM CHANGES WHERE CHANGECODE = ?';
type
  ParamRec = record
       ParamPtr    : pointer;
       NullPtr     : pointer;
       BlobSizePtr : PSDWORD;
       DataType    : SWORD;
  end;
  StmtPtr = ^StmtPtrNode;
  LocsPtr = ^LocsPtrNode;
  StmtPtrNode = record
    TableName  : array[0..32] of Char;
    Operation  : array[0..1] of Char;
    SqlStmt    : Pointer;
    Link  : StmtPtr;
  end;
  LocsPtrNode = record
    LocPath  : Pointer;
    RService : array[0..49] of Char;
    RUser    : array[0..49] of Char;
    RPass    : array[0..49] of Char;
    UserName : array[0..49] of Char;
    Password : array[0..49] of Char;
    IdLoc : Integer; { The actual Location Id }
    Link  : LocsPtr;
  end;
  HeadPtr = ^StmtPtr;
  LocsHeadPtr = ^LocsPtr;

  TMain = class(TForm)
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    ShowForm1: TMenuItem;
    N1: TMenuItem;
    Close1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TDoReplication: TTimer;
    TReplInterval: TTimer;
    Image2: TImage;
    SpeedButton1: TSpeedButton;
    StaticText1: TStaticText;
    StatusText: TStaticText;
    Run1: TMenuItem;
    Image1: TImage;
    StaticText2: TStaticText;
    ViewErrors1: TMenuItem;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ReplPath: TStaticText;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CBEvent: TCheckBox;
    Label1: TLabel;
    EInterval: TEdit;
    Label2: TLabel;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    SpeedButton6: TSpeedButton;
    ReplDB: TIBDatabase;
    DBSource: TIBDatabase;
    EvSourceDB: TIBDatabase;
    QueryStmt: TIBQuery;
    QueryLocs: TIBQuery;
    QSrcLocs: TIBQuery;
    QChanges: TIBQuery;
    QLocChanges: TIBQuery;
    ReplTR: TIBTransaction;
    TRSource: TIBTransaction;
    EvSourceTR: TIBTransaction;
    IBEvent: TIBEvents;
    procedure ViewErrors1Click(Sender: TObject);
    procedure ShutDown1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ShowForm1Click(Sender: TObject);
    procedure Run1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IBEvent1EventAlert(Sender: TObject; EventName: String;
      EventCount: Integer; var CancelAlerts: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure TDoReplicationTimer(Sender: TObject);
    procedure TReplIntervalTimer(Sender: TObject);
    procedure SaveEdits5Click(Sender: TObject);
    procedure About6Click(Sender: TObject);
  private
    fCanClose : boolean;
    { Private declarations }
    function  CacheSqlStmts:Integer;
    procedure FreeSqlStmts;
    procedure ReplicateData;
    procedure AddStmtLL(Head:HeadPtr;TableName,Operation,SqlStr:PChar);
    procedure AddLocsLL(Head:LocsHeadPtr;LocPath,RasServ,RasUser,RasPass:PChar;IdLoc :Integer;User,Passwd:PChar);
    function  SearchStmtLL(Head:StmtPtr;TableName,Operation:PChar): PChar;
    function  SearchLocsLL(Head:LocsPtr;IdLoc:Integer): LocsPtr;
    function  ConnectDb(LocId:Integer;LocPtr:LocsPtr):Integer;
    procedure DisconnectDb(IdLoc:Integer);
    procedure SyncSrcAndTarget;
    function  OpenChanges:RETCODE;
    function  DeleteChangeRec:RETCODE;
    function  GetChanges:RETCODE;
    function  SyncInsUpd:RETCODE;
    function  SyncDelete:RETCODE;
    procedure CloseChanges;
    procedure DestroyStmtLL(Head:HeadPtr);
    procedure DestroyLocsLL(Head:LocsHeadPtr);
    procedure SetParams;
    procedure HandleError(ErrorMsg:string);
  public
    { Public declarations }
    ErrorFile : array[0..254] of Char;
  end;

var
  Main: TMain;
  SrcPath,TargetPath,AliasName : string;
  StmtHead : StmtPtr;
  LocsHead : LocsPtr;
  CachedEm : Boolean;
  TotalLocs : Integer;
  SrcHandle,TargetHandle : HDBC;
  ChgStmt,ChgStmt2,SrcStmt,TargetStmt : HSTMT;
  ChgCode,ChgLocId  : Integer;
  ChgTableKey : Int64;
  ChgTableName : array[0..33] of Char;
  ChgOperation : array[0..1] of Char ;
  SomeNull1,SomeNull2,SomeNull3,SomeNull4,SomeNull5 : Boolean;
  SqlStmtPtr : PChar;
  AnyErrors,BlobMaxSize : Integer;
  Running,Reg4Event,FatalError : Boolean;
  SrcUsername,SrcPassword, SrcPathDB,TargetUser,TargetPwd :string;

implementation

uses
  rasform, Unit4, About;

{$R *.DFM}

function TMain.CacheSqlStmts: Integer;
var
  SqlStmts:Integer;
  TableName : array[0..32] of Char;
  Operation : array[0..1] of Char;
  SqlStr : array[0..2047] of Char;
  TmpStr, LocPath : string;
  IdLoc : Integer;
begin
  if ( not CachedEm) then begin
    SqlStmts := 0;
    SqlStr := '';
    if (ReplTR.InTransaction) then
      ReplTR.Commit;
    ReplTR.StartTransaction;
    QueryStmt.Open;
    QueryStmt.First;
    StrCopy(TableName,PChar(QueryStmt.FieldByName('TABLENAME').AsString));
    StrCopy(Operation,PChar(QueryStmt.FieldByName('OPTYPE').AsString));
    while( QueryStmt.EOF <> True ) do  begin
      if (QueryStmt.FieldByName('OPTYPE').AsString <> Operation) or (QueryStmt.FieldByName('TABLENAME').AsString <> TableName) then
      begin
        Inc(SqlStmts);
        AddStmtLL(@(StmtHead),TableName,Operation,SqlStr);
        StrCopy(TableName,PChar(QueryStmt.FieldByName('TABLENAME').AsString));
        StrCopy(Operation,PChar(QueryStmt.FieldByName('OPTYPE').AsString));
        SqlStr := '';
      end;
      TmpStr := QueryStmt.FieldByName('SQLSTMT').AsString;
      StrLCat(SqlStr,PChar(TmpStr),Sizeof(SqlStr)-1);
      QueryStmt.Next;
    end;
    if (TableName <> '') then
         AddStmtLL(@(StmtHead),TableName,Operation,SqlStr);
    QueryStmt.Close;
    { See how many locations we have to deal with and cache all the dbpaths/locid while we're at it }
    QueryLocs.Open;
    QueryLocs.First;
    TotalLocs :=0;
    while( QueryLocs.EOF <> True ) do
    begin
      Inc(TotalLocs);
      AddLocsLL(@(LocsHead),PChar(Trim(QueryLocs.FieldByName('LOC_PATH').AsString)),PChar(Trim(QueryLocs.FieldByName('RAS_SERVICENAME').AsString)),PChar(Trim(QueryLocs.FieldByName('RAS_USER').AsString)),PChar(Trim(QueryLocs.FieldByName('RAS_PASSWORD').AsString)),QueryLocs.FieldByName('LOC_ID').AsInteger,PChar(Trim(QueryLocs.FieldByName('USERNAME').AsString)),PChar(Trim(QueryLocs.FieldByName('PASSWD').AsString)));
      QueryLocs.Next;
    end;
    ReplTR.Commit;
    CachedEm := True;
  end;
  CacheSqlStmts := TotalLocs;
end;

procedure TMain.FreeSqlStmts;
begin
  DestroyStmtLL(@(StmtHead));
  DestroyLocsLL(@(LocsHead));
end;

procedure TMain.SetParams;
var
  Len : Integer;
  TmpError : array[0..254] of Char;
  ReplIni: TIniFile;
  EvtStr : string;
  SomeNum,n1,PathLen: Integer;
  ReplPath,ReplServer, ReplUser, ReplPWord : string;
begin
  ReplIni := TIniFile.Create('REPL.INI');
  with ReplIni do begin
     TReplInterval.Interval:=StrToInt(ReadString('ReplServer', 'Interval', '0'))*1000*60;
     EvtStr:=ReadString('ReplServer', 'EventResp', 'False');
     ReplServer:=ReadString('ReplMgmt', 'Server', 'Not Found');
     ReplPath:=ReadString('ReplMgmt', 'Path', 'Not Found');
     ReplUser:=ReadString('ReplMgmt', 'UserName', 'Not Found');
     ReplPWord:=ReadString('ReplMgmt', 'Password', 'Not Found');
     BlobMaxSize:=StrToInt(ReadString('ReplServer', 'BlobMaxBytes', IntToStr(MaxBlobSize)))
  end;
  if (StrComp('Not Found',PChar(ReplPath)) = 0) or(StrComp('Not Found',PChar(ReplServer))=0) then begin
    ShowMessage('Cannot find REPL.INI or the ReplMgmt section is missing.  See readme.txt included with Replication Server zip file.');
    FatalError := True;
    Application.Terminate;
  end else begin
    PathLen := Length(ReplPath);
    if (ReplPath[PathLen] = '\') then
    begin
       ReplPath[PathLen] := Char(0);
    end;
    StrCopy(ErrorFile,PChar(ExtractFilePath(Application.EXEName)));
    StrLCat(ErrorFile, PChar('replerrors.txt'),SizeOf(ErrorFile)-1);
    if TReplInterval.Interval < 1 then
       TReplInterval.Enabled := False
    else
      TReplInterval.Enabled := True;
    if (EvtStr = 'True') then
      Reg4Event := True
    else
      Reg4Event := False;
    ReplIni.Free;
    // connect to the replcation database
    ReplDB.DatabaseName := ReplServer+':'+ReplPath;
    ReplDB.Params.Clear;
    ReplDB.Params.Add('user_name='+ReplUser);
    ReplDB.Params.Add('password='+ReplPWord);
    {
    ReplDB.Server := ReplServer;
    ReplDB.Path := ReplPath;
    ReplDB.Username := ReplUser;
    ReplDB.Password := ReplPWord;
    }
    ReplDB.Connected := True;
    if (not ReplDB.Connected) then
      FatalError := True;
    ReplTR.StartTransaction;
    QSrcLocs.Open;
    QSrcLocs.First;
    // connect to the source database
    DBSource.DatabaseName := Trim(QSrcLocs.FieldByName('SOURCE_SERVER').AsString)+':'+Trim(QSrcLocs.FieldByName('SOURCE_PATH').AsString);
    DBSource.Params.Clear;
    DBSource.Params.Add('user_name='+Trim(QSrcLocs.FieldByName('USERNAME').AsString));
    DBSource.Params.Add('password='+Trim(QSrcLocs.FieldByName('PASSWD').AsString));

    SrcUsername := Trim(QSrcLocs.FieldByName('USERNAME').AsString);
    SrcPassword := Trim(QSrcLocs.FieldByName('PASSWD').AsString);
    SrcPathDB := Trim(QSrcLocs.FieldByName('SOURCE_SERVER').AsString)+':'+Trim(QSrcLocs.FieldByName('SOURCE_PATH').AsString);

    {
    DBSource.Server := QSrcLocsSOURCE_SERVER.value;
    DBSource.Path := QSrcLocsSOURCE_PATH.value;
    DBSource.Username := QSrcLocsUSERNAME.value;
    DBSource.Password := QSrcLocsPASSWD.value;
    }
    // connect to the event database
    EvSourceDB.DatabaseName := Trim(QSrcLocs.FieldByName('SOURCE_SERVER').AsString)+':'+Trim(QSrcLocs.FieldByName('SOURCE_PATH').AsString);
    EvSourceDB.Params.Clear;
    EvSourceDB.Params.Add('user_name='+Trim(QSrcLocs.FieldByName('USERNAME').AsString));
    EvSourceDB.Params.Add('password='+Trim(QSrcLocs.FieldByName('PASSWD').AsString));
    {
    EvSourceDB.Server := QSrcLocsSOURCE_SERVER.value;
    EvSourceDB.Path := QSrcLocsSOURCE_PATH.value;
    EvSourceDB.Username := QSrcLocsUSERNAME.value;
    EvSourceDB.Password := QSrcLocsPASSWD.value;
    }
    QSrcLocs.Close;
    ReplTR.Commit;
  end;
end;

procedure TMain.HandleError(ErrorMsg:string);
var
  Len : Integer;
  F:Textfile;
  FileId : Integer;
begin
  if (not FileExists(ErrorFile)) then begin
    FileId := FileCreate(ErrorFile);
    if FileId > 0 then begin
      FileClose(FileId);
    end;
  end;
  AssignFile(F,ErrorFile);
  Append(F);
  Writeln(F,DateTimeToStr(Now) + ' '+ErrorMsg);
  CloseFile(F);
  Inc(AnyErrors);
end;

procedure TMain.DestroyStmtLL(Head:HeadPtr);
var
  CurPtr,NextPtr : StmtPtr;
begin
  CurPtr := Head^;
  if ( CurPtr <> nil) then begin
    while (CurPtr^.link <> nil) do begin
      NextPtr := CurPtr^.link;
      if CurPtr^.SqlStmt <> nil then
        FreeMem(PChar(CurPtr^.SqlStmt));
      FreeMem(CurPtr);
      CurPtr := NextPtr;
    end;
    FreeMem(CurPtr^.SqlStmt);
    FreeMem(CurPtr);
    Head^ := nil;
  end;
end;

procedure TMain.AddStmtLL(Head:HeadPtr;TableName,Operation,SqlStr:PChar);
var
  LenStr : Integer;
  TmpPtr,NewPtr : StmtPtr;
begin
  New(NewPtr);
  StrCopy(NewPtr^.Tablename,TableName);
  StrCopy(NewPtr^.Operation,Operation);
  LenStr := StrLen(SqlStr);
  NewPtr^.SqlStmt := AllocMem(LenStr+1);
  StrCopy(NewPtr^.SqlStmt,SqlStr);
  NewPtr^.link := nil;
  TmpPtr := Head^;
  if (TmpPtr = nil) then
    Head^ := NewPtr   {First one on the list}
  else begin
    while (TmpPtr^.link <> nil) do   { stick it on the end }
      TmpPtr := TmpPtr^.link;
    TmpPtr^.link := NewPtr;
  end;
end;

function  TMain.SearchStmtLL(Head:StmtPtr;TableName,Operation:PChar): PChar;
var
  CurPtr : StmtPtr;
  Foundit : Integer;
begin
  CurPtr := Head;
  Foundit := 0;
  if ( CurPtr <> nil) then begin
    while (CurPtr <> nil) and (Foundit = 0) do begin
      if ( StrIComp(CurPtr^.TableName,TableName)=0) and (StrIComp(CurPtr^.Operation,Operation)=0) then
        Foundit := 1
      else
        CurPtr := CurPtr^.link;
    end;
  end;
  if CurPtr = nil then
    SearchStmtLL := nil
  else
    SearchStmtLL := CurPtr^.SqlStmt;
end;

procedure TMain.DestroyLocsLL(Head:LocsHeadPtr);
var
  CurPtr,NextPtr : LocsPtr;
begin
  CurPtr := Head^;
  if ( CurPtr <> nil) then begin
    while (CurPtr^.link <> nil) do begin
      NextPtr := CurPtr^.link;
      if CurPtr^.LocPath <> nil then
        FreeMem(PChar(CurPtr^.LocPath));
      FreeMem(CurPtr);
      CurPtr := NextPtr;
    end;
    FreeMem(CurPtr^.LocPath);
    FreeMem(CurPtr);
    Head^ := nil;
  end
end;

procedure TMain.AddLocsLL(Head:LocsHeadPtr;LocPath,RasServ,RasUser,RasPass:PChar;IdLoc :Integer;User,Passwd:PChar);
var
  LenStr : Integer;
  TmpPtr,NewPtr : LocsPtr;
begin
  New(NewPtr);
  NewPtr^.IdLoc := IdLoc;
  LenStr := StrLen(LocPath);
  NewPtr^.LocPath := AllocMem(LenStr+1);
  StrCopy(NewPtr^.LocPath,LocPath);
  StrCopy(NewPtr^.RService, RasServ);
  StrCopy(NewPtr^.RUser, RasUser);
  StrCopy(NewPtr^.RPass, RasPass);
  StrCopy(NewPtr^.UserName, User);
  StrCopy(NewPtr^.Password, Passwd);
  NewPtr^.link := nil;
  TmpPtr := Head^;
  if (TmpPtr = nil) then
    Head^ := NewPtr   {First one on the list}
  else begin
    while (TmpPtr^.link <> nil) do   { stick it on the end }
      TmpPtr := TmpPtr^.link;
    TmpPtr^.link := NewPtr;
  end;
end;

function  TMain.SearchLocsLL(Head:LocsPtr;IdLoc:Integer): LocsPtr;
var
  CurPtr : LocsPtr;
  Foundit : Integer;
begin
  CurPtr := Head;
  Foundit := 0;
  if ( CurPtr <> nil) then begin
    while (CurPtr <> nil) and (Foundit = 0) do begin
      if ( IdLoc =  CurPtr^.IdLoc ) then
        Foundit := 1
      else
        CurPtr := CurPtr^.link;
    end;
  end;
  if CurPtr = nil then
    SearchLocsLL := nil
  else
    SearchLocsLL := CurPtr;
end;

function TMain.ConnectDb(LocId:Integer;LocPtr:LocsPtr):Integer;
var
  retval : RETCODE;
  ErrorBuf : array[0..511] of Char;
  DbName : string;
  DbStatus : Integer;
begin
   retval := SQL_SUCCESS;
   FillChar(ErrorBuf, SizeOf(ErrorBuf), Char(0));
   if (LocId = -1) then begin
     SrcHandle := nil;
     SQLAllocConnect(@SrcHandle);
     SQLSetConnectOption( SrcHandle,SQL_AUTOCOMMIT,SQL_AUTOCOMMIT_OFF);
     retval := SQLConnect(SrcHandle,PChar(SrcPathDB),PChar(SrcUsername),PChar(SrcPassword));
     if ( retval <> SQL_SUCCESS) then begin
       SQLError(SrcHandle,nil,ErrorBuf);
       HandleError('Src Connect Failed: '+ ErrorBuf);
     end;
   end else begin
     if (LocPtr <> nil) then begin
       TargetUser := LocPtr^.UserName;
       TargetPwd := LocPtr^.Password;
       TargetPath := StrPas(PChar(LocPtr^.LocPath));
       { Is there a RAS service affilliated with this location? }
(*       if (Length(LocPtr^.RService) > 0) then  begin
         dialer.REntryName := LocPtr^.RService;
         dialer.RUserName := LocPtr^.RUser;
         dialer.RPassword := LocPtr^.RPass;
         {Wait for the RAS connection to take place.}
         dialer.ShowModal;
         if (not dialer.IsConnected) then begin
           retval := SQL_ERROR;
           HandleError('Target'+IntToStr(LocId)+' Connect Failed: Could not connect to associated RAS Service('+Form2.REntryName+')');
         end
       end; *)
     end else begin
       retval := SQL_ERROR;
       HandleError('Could not find Target location linked-list info');
     end;
     if (retval = SQL_SUCCESS) then begin
       TargetHandle := nil;
       SQLAllocConnect(@TargetHandle);
       SQLSetConnectOption( TargetHandle,SQL_AUTOCOMMIT,SQL_AUTOCOMMIT_OFF);
       retval := SQLConnect(TargetHandle,PChar(TargetPath),PChar(TargetUser),PChar(TargetPwd));
       if ( retval <> SQL_SUCCESS) then begin
         SQLError(TargetHandle,nil,ErrorBuf);
         HandleError('Target'+IntToStr(LocId)+' Connect Failed: '+ ErrorBuf);
       end
     end else begin
       retval := SQL_ERROR;
       HandleError('Target'+IntToStr(LocId)+' Connect Failed: Could not connect to associated RAS Service('+dialer.REntryName+')');
     end;
   end;
   ConnectDb := retval;
end;

procedure TMain.DisconnectDb(IdLoc:Integer);
var
  retval : RETCODE;
begin
  if (IdLoc = -1) then
    retval := SQLDisconnect(@SrcHandle)
  else begin
    retval := SQLDisconnect(@TargetHandle);
    if (dialer.IsConnected) then begin
      dialer.RAS1.Disconnect;
      dialer.IsConnected := False;
    end;
  end;
end;

function TMain.OpenChanges:RETCODE;
var
  retval : RETCODE;
  ErrorBuf : array[0..511] of Char;
begin
  FillChar(ErrorBuf, SizeOf(ErrorBuf), Char(0));
  retval := SQLAllocStmt( SrcHandle,@ChgStmt);
  if ( retval = SQL_SUCCESS) then begin
    retval := SQLPrepare( ChgStmt, PChar(ChangeSelect) , 0 );
    if ( retval = SQL_SUCCESS) then begin
      SQLBindCol( ChgStmt,1, SQL_INT64+1,@ChgCode,@SomeNull1,nil);
      SQLBindCol( ChgStmt,2, SQL_VARYING+1,@ChgTableName,@SomeNull2,nil);
      SQLBindCol( ChgStmt,3, SQL_INT64+1,@ChgTableKey,@SomeNull3,nil);
      SQLBindCol( ChgStmt,4, SQL_TEXT+1,@ChgOperation,@SomeNull4,nil);
      SQLBindParameter( ChgStmt,1, SQL_LONG+1,@ChgLocId,@SomeNull5,nil,0);
      retval := SQLExecute( ChgStmt );
      if ( retval <> SQL_SUCCESS) then begin
        SQLError(SrcHandle,ChgStmt,ErrorBuf);
        HandleError('ChgExecute Failed: for LocId='+IntToStr(ChgLocId)+' SqlStmt='+ChangeSelect+' Error='+ ErrorBuf);
        SQLFreeStmt( ChgStmt,SQL_DROP);
      end;
    end else begin
      SQLError(SrcHandle,ChgStmt,ErrorBuf);
      HandleError('ChgPrepare Failed: for LocId='+IntToStr(ChgLocId)+' SqlStmt='+ChangeSelect+' Error='+ErrorBuf);
      SQLFreeStmt( ChgStmt,SQL_DROP);
    end;
  end else begin
    SQLError(SrcHandle,nil,ErrorBuf);
    HandleError('Chg AllocFailed for LocId='+IntToStr(ChgLocId)+' Error= '+ ErrorBuf);
  end;
  OpenChanges := retval;
end;

function TMain.DeleteChangeRec:RETCODE;
var
  retval : RETCODE;
  ErrorBuf : array[0..511] of Char;
begin
  FillChar(ErrorBuf, SizeOf(ErrorBuf), Char(0));
  retval := SQLAllocStmt( SrcHandle,@ChgStmt2);
  if ( retval = SQL_SUCCESS) then begin
    retval := SQLPrepare( ChgStmt2, PChar(ChangeDelete) , 0 );
    if ( retval = SQL_SUCCESS) then begin
      SQLBindParameter( ChgStmt2,1, SQL_INT64+1,@ChgCode,@SomeNull1,nil,0);
      retval := SQLExecute( ChgStmt2 );
      if ( retval <> SQL_SUCCESS) then begin
        SQLError(SrcHandle,ChgStmt2,ErrorBuf);
        HandleError('ChgDelete Failed LocId='+IntToStr(ChgCode)+' SqlStmt='+ChangeDelete+ 'Error='+ErrorBuf);
      end;
    end else begin
      SQLError(SrcHandle,ChgStmt2,ErrorBuf);
      HandleError('ChgDelPrepare Failed LocId='+IntToStr(ChgCode)+' SqlStmt='+ ChangeDelete+' Error='+ErrorBuf);
    end;
    SQLFreeStmt( ChgStmt2,SQL_DROP);
  end else begin
    SQLError(SrcHandle,nil,ErrorBuf);
    HandleError('ChgDel AllocFailed LocId='+IntToStr(ChgLocId)+' Error='+ ErrorBuf);
  end;
  DeleteChangeRec := retval;
end;

function TMain.GetChanges:RETCODE;
var
  retval : RETCODE;
  ErrorBuf : array[0..511] of Char;
begin
  FillChar(ErrorBuf, SizeOf(ErrorBuf), Char(0));
  retval := SQLFetch( ChgStmt );
  if (retval <> SQL_SUCCESS) then begin
     if (retval <> 100) then begin
       SQLError(SrcHandle,ChgStmt,ErrorBuf);
       HandleError('ChgFetch Failed LocId='+IntToStr(ChgLocId)+' SqlStmt='+ ChangeSelect+ ' Error='+ErrorBuf);
     end;
  end;
  GetChanges := retval;
end;

procedure TMain.CloseChanges;
begin
  SQLFreeStmt( ChgStmt,SQL_DROP);
end;

function TMain.SyncDelete:RETCODE;
var
  retval : RETCODE;
  ErrorBuf : array[0..511] of Char;
begin
  FillChar(ErrorBuf, SizeOf(ErrorBuf), Char(0));
  retval := SQLAllocStmt( TargetHandle,@TargetStmt);
  if ( retval = SQL_SUCCESS) then begin
    retval := SQLPrepare( TargetStmt, PChar(SqlStmtPtr) , 0 );
    if ( retval = SQL_SUCCESS) then begin
      SomeNull1 := False;
      SQLBindParameter( TargetStmt,1, SQL_INT64+1,@ChgTableKey,@SomeNull1,nil,0);
      retval := SQLExecute( TargetStmt );
      if ( retval <> SQL_SUCCESS) then begin
        SQLError(TargetHandle,TargetStmt,ErrorBuf);
        HandleError('TgtDelete Failed: LocId='+IntToStr(ChgLocId)+'Key='+IntToStr(ChgTableKey)+ ' SqlStmt='+SqlStmtPtr+' Error='+ErrorBuf);
      end;
    end else begin
      SQLError(TargetHandle,TargetStmt,ErrorBuf);
      HandleError('TgtDelPrepare Failed: LocId='+IntToStr(ChgLocId)+'Key='+IntToStr(ChgTableKey)+ ' SqlStmt='+SqlStmtPtr+' Error='+ErrorBuf);
    end;
    SQLFreeStmt( TargetStmt,SQL_DROP);
  end else begin
    SQLError(TargetHandle,nil,ErrorBuf);
    HandleError('TgtDel AllocFailed: LocId='+IntToStr(ChgLocId)+' Error='+ ErrorBuf);
  end;
  SyncDelete := retval;
end;

function TMain.SyncInsUpd:RETCODE;
var
  retval1,retval2 : RETCODE;
  ErrorBuf : array[0..511] of Char;
  SrcSqlPtr : PChar;
  DataType,DataLen:SWORD;
  ParamNum,NumIn,NumOut,i : UWORD;
  InList,OutList : array[1..MaxColumns] of ParamRec;
  BoolPtr : ^Boolean;
  TmpChar : array[0..1] of Char;
begin
  retval1 := 0;
  retval2 := 0;
  FillChar(ErrorBuf, SizeOf(ErrorBuf), Char(0));
  retval1 := SQLAllocStmt( SrcHandle,@SrcStmt);
  retval2 := SQLAllocStmt( TargetHandle,@TargetStmt);
  if ( retval1 = SQL_SUCCESS) and (retval2 = SQL_SUCCESS) then begin
    TmpChar := 'S';
    SrcSqlPtr := SearchStmtLL(StmtHead,ChgTableName,TmpChar);
    retval1 := SQLPrepare( SrcStmt, SrcSqlPtr , 0 );
    if ( retval1 = SQL_SUCCESS) then begin
      NumOut := 1;
      { For each column in a Select clause, we'll allocate space. SQLGetCol() will tell us
        the Datatype and Length.  Once we have the proper space allocated, we can "bind" the
        output data to the variable pointed to by the allocated space using SQLBindCol(). }
      retval1 := SQLGetCol( SrcStmt,NumOut,DataType,DataLen);
      while (retval1 <> 100) do begin
        OutList[NumOut].NullPtr := AllocMem(sizeof(Boolean));
        OutList[NumOut].BlobSizePtr := nil;
        BoolPtr := OutList[NumOut].NullPtr;
        BoolPtr^ := False;
        case DataType of
          SQL_DATE+1,SQL_DATE: begin
          { Dates are passed in/out as strings of the format mm/dd/yyyy hh:mm:ss SQL_TIMESTAMP}
            OutList[NumOut].ParamPtr := AllocMem(sizeof(Char)*20);
            SQLBindCol( SrcStmt,NumOut, SQL_DATE+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,nil);
            OutList[NumOut].DataType := SQL_DATE+1;
          end;
          SQL_TYPE_DATE+1,SQL_TYPE_DATE: begin
          { Dates are passed in/out as strings of the format mm/dd/yyyy ?}
            OutList[NumOut].ParamPtr := AllocMem(sizeof(Char)*20);
            SQLBindCol( SrcStmt,NumOut, SQL_TYPE_DATE+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,nil);
            OutList[NumOut].DataType := SQL_TYPE_DATE+1;
          end;
          SQL_TYPE_TIME+1,SQL_TYPE_TIME: begin
          { Dates are passed in/out as strings of the format hh:mm:ss }
            OutList[NumOut].ParamPtr := AllocMem(sizeof(Char)*20);
            SQLBindCol( SrcStmt,NumOut, SQL_TYPE_TIME+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,nil);
            OutList[NumOut].DataType := SQL_TYPE_TIME+1;
          end;
          SQL_TEXT+1,SQL_TEXT: begin
            OutList[NumOut].ParamPtr := AllocMem(sizeof(Char)*DataLen+1);
            SQLBindCol( SrcStmt,NumOut, SQL_TEXT+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,nil);
            OutList[NumOut].DataType := SQL_TEXT+1;
          end;
          SQL_VARYING+1,SQL_VARYING: begin
            OutList[NumOut].ParamPtr := AllocMem(sizeof(Char)*DataLen+1);
            SQLBindCol( SrcStmt,NumOut, SQL_VARYING+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,nil);
            OutList[NumOut].DataType := SQL_VARYING+1;
          end;
          SQL_INT64,SQL_INT64+1: begin
            OutList[NumOut].ParamPtr := AllocMem(sizeof(Int64));
            SQLBindCol( SrcStmt,NumOut, SQL_INT64+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,nil);
            OutList[NumOut].DataType := SQL_INT64+1;
          end;
          SQL_LONG,SQL_LONG+1: begin
            OutList[NumOut].ParamPtr := AllocMem(sizeof(LongInt));
            SQLBindCol( SrcStmt,NumOut, SQL_LONG+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,nil);
            OutList[NumOut].DataType := SQL_LONG+1;
          end;
          SQL_SHORT,SQL_SHORT+1: begin
            OutList[NumOut].ParamPtr := AllocMem(sizeof(Short));
            SQLBindCol( SrcStmt,NumOut, SQL_SHORT+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,nil);
            OutList[NumOut].DataType := SQL_SHORT+1;
          end;
          SQL_FLOAT,SQL_FLOAT+1: begin
            OutList[NumOut].ParamPtr := AllocMem(sizeof(Double));
            SQLBindCol( SrcStmt,NumOut, SQL_FLOAT+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,nil);
            OutList[NumOut].DataType := SQL_FLOAT+1;
          end;
          SQL_DOUBLE,SQL_DOUBLE+1: begin
            OutList[NumOut].ParamPtr := AllocMem(sizeof(Double));
            SQLBindCol( SrcStmt,NumOut, SQL_DOUBLE+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,nil);
            OutList[NumOut].DataType := SQL_DOUBLE+1;
          end;
          SQL_BLOB,SQL_BLOB+1: begin
            OutList[NumOut].ParamPtr := AllocMem(sizeof(Char)*BlobMaxSize);
            OutList[NumOut].BlobSizePtr := AllocMem(sizeof(SDWORD));
            { OutList[NumOut].BlobSizePtr^ := DataLen;}
            OutList[NumOut].BlobSizePtr^ := sizeof(Char)*BlobMaxSize;
            { DataLen is filled in when we called SQLGetCol. DataLen contains the segment size for this blob
              field. After calling SQLFetch() this variable will contain the actual size of the Blob returned. }
            SQLBindCol( SrcStmt,NumOut, SQL_BLOB+1,OutList[NumOut].ParamPtr,OutList[NumOut].NullPtr,OutList[NumOut].BlobSizePtr);
            OutList[NumOut].DataType := SQL_BLOB+1;
          end;
        end;
        Inc(NumOut);
        retval1 := SQLGetCol( SrcStmt,NumOut,DataType,DataLen);
      end;
      SomeNull1 := False;
      SQLBindParameter( SrcStmt,1, SQL_INT64+1,@ChgTableKey,@SomeNull1,nil,0);
      retval2 := SQLPrepare( TargetStmt, PChar(SqlStmtPtr) , 0 );
      if (retval2 = SQL_SUCCESS) then begin
        { SQLBindCol is for output params SQLBindParameter is for input params}
        { The input params to the other dbs stmt(hstmt2) are the output params from the first dbs
          stmt(hstmt1). If this were not the case then, we'd obviously have to allocate space for the
          variables we were going to pass in.}
        i := 1;
        while i < NumOut do begin
          if (OutList[i].BlobSizePtr = nil) then
            SQLBindParameter( TargetStmt,i, OutList[i].DataType,OutList[i].ParamPtr,OutList[i].NullPtr,OutList[i].BlobSizePtr,0)
          else
            SQLBindParameter( TargetStmt,i, OutList[i].DataType,OutList[i].ParamPtr,OutList[i].NullPtr,OutList[i].BlobSizePtr,OutList[i].BlobSizePtr^);
            Inc(i);
        end;
        if (ChgOperation = 'U') then begin
          { If we're issuing an Update statement, we'll have one more parameter to Bind into the
            Input data section, i.e. The TableKey }
           SomeNull1 := False;
           SQLBindParameter( TargetStmt, NumOut, SQL_INT64+1, @ChgTableKey, @SomeNull1, nil, 0);
        end;
        retval1 := SQLExecute( SrcStmt );
        retval2 := SQLFetch( SrcStmt );
        while ( (retval1  = SQL_SUCCESS) and (retval2 = SQL_SUCCESS)) do begin
          retval2 := SQLExecute( TargetStmt );
          if (retval2 = SQL_SUCCESS) then
            retval1 := SQLFetch( SrcStmt );
        end;
        if ( (retval1  = 100) and (retval2 = SQL_SUCCESS)) then begin
            retval1 := SQL_SUCCESS;
        end else begin
          if (retval2 <> SQL_SUCCESS) then begin
            if (retval2 <> 100) then begin
              if (retval2 = -23) then begin
                HandleError('Not enough memory allocated for a Blob field.  Make sure BlobMaxBytes is set to a large enough value in repl.ini');
                retval1 := SQL_ERROR;
              end else begin
                SQLError(TargetHandle,TargetStmt,ErrorBuf);
                HandleError('InsUpd TgtEx Failed: LocId='+IntToStr(ChgLocId)+'Key='+IntToStr(ChgTableKey)+ ' SqlStmt='+SqlStmtPtr+' Error='+ErrorBuf);
                retval1 := SQL_ERROR;
              end;
            end;
          end else begin
            SQLError(SrcHandle,SrcStmt,ErrorBuf);
            HandleError('InsUpd SrcFetch Failed: LocId='+IntToStr(ChgLocId)+'Key='+IntToStr(ChgTableKey)+ ' SqlStmt='+SrcSqlPtr+' Error='+ErrorBuf);
            retval1 := SQL_ERROR;
          end;
        end;
      end else begin { Target Prepare Failed }
        SQLError(TargetHandle,TargetStmt,ErrorBuf);
        HandleError('InsUpd TgtPrep Failed: LocId='+IntToStr(ChgLocId)+'Key='+IntToStr(ChgTableKey)+ ' SqlStmt='+SqlStmtPtr+' Error='+ErrorBuf);
        retval1 := SQL_ERROR;
      end;
    end else begin  { Source Prepare Failed }
      SQLError(SrcHandle,SrcStmt,ErrorBuf);
      HandleError('InsUpd SrcPrep Failed: LocId='+IntToStr(ChgLocId)+'Key='+IntToStr(ChgTableKey)+ ' SqlStmt='+SrcSqlPtr+' Error='+ErrorBuf);
    end;
      SQLFreeStmt( SrcStmt,SQL_DROP);
      SQLFreeStmt( TargetStmt,SQL_DROP);
      i := 1;
      while i < NumOut do begin
        if OutList[i].DataType = SQL_BLOB+1 then
          FreeMem( OutList[i].BlobSizePtr);
        FreeMem( OutList[i].ParamPtr);
        FreeMem( OutList[i].NullPtr);
        Inc(i);
      end;
    end else begin
      if retval1 <> SQL_SUCCESS then begin
        SQLError(SrcHandle,nil,ErrorBuf);
        HandleError('InsUpd SrcAlloc Failed: LocId'+IntToStr(ChgLocId)+' Error='+ ErrorBuf);
      end else begin
        SQLError(TargetHandle,nil,ErrorBuf);
        HandleError('InsUpd Target Alloc Failed: LocId'+IntToStr(ChgLocId)+' Error='+ ErrorBuf);
        retval1 := SQL_ERROR;
      end;
    end;
  SyncInsUpd := retval1;
end;

procedure TMain.SyncSrcAndTarget;
var
  retval1,retval2 : RETCODE;
  ErrorBuf : array[0..511] of Char;
  dbArray : HDBCARR;
  dbCount : Integer;
begin
  { For each record in the Change Table matching the passed in Loc_id.
    We'll Pull the information out of the Source DB and propagate it to the Target DB }
  FillChar(ErrorBuf, SizeOf(ErrorBuf), Char(0));
  dbArray[0] := @SrcHandle;
  dbArray[1] := @TargetHandle;
  dbCount := 2;
  //         SQLTransactMdb( hdbcArr : array of PHDBC;TxOption : UWORD;DbCount:Integer) : RETCODE;export;
  retval1 := SQLTransactMdb( dbArray, SQL_BEGIN_TRANS, dbCount);
  if ( retval1 = SQL_SUCCESS) then begin
    retval1 := OpenChanges;
    if (retval1 = SQL_SUCCESS) then begin
      retval2 := GetChanges;
      retval1 := SQL_SUCCESS;
      while ( retval2 = SQL_SUCCESS) and (retval1 = SQL_SUCCESS) do begin
        {Get the proper SQL statement for the given TABLENAME, and Operation }
        SqlStmtPtr := SearchStmtLL(StmtHead,ChgTableName,ChgOperation);
        if SqlStmtPtr <> nil then begin
          { Handle the sync of Insert, Update, or Delete }
          if (ChgOperation = 'U') or (ChgOperation = 'I') then
            retval1 := SyncInsUpd
          else
            retval1 := SyncDelete;
          if (retval1 = SQL_SUCCESS) then begin
            {We've done what we should have, so we can delete the record from the Changes table.}
            retval1 := DeleteChangeRec;
          end;
          retval2 := GetChanges;
        end else begin
          HandleError('No Corresponding SQL Stmt for TableName='+ChgTableName+' Operation='+ChgOperation);
          SQLTransactMdb( dbArray,SQL_ROLLBACK,dbCount);
          retval2 := 100;
        end;
      end;
      if (retval2 <> 100) or (retval1 <> SQL_SUCCESS) then begin
        if (retval2 <> 100) then begin
          HandleError('Sql Failed: '+ ErrorBuf);
          retval1 := SQLTransactMdb( dbArray,SQL_ROLLBACK,dbCount);
        end
      end else
        retval1 := SQLTransactMdb( dbArray,SQL_COMMIT,dbCount);
      CloseChanges;
    end else begin
      retval1 := SQLTransactMdb( dbArray,SQL_ROLLBACK,dbCount);
    end
  end else begin
    SQLError(SrcHandle,nil,ErrorBuf);
    HandleError('Source Begin TX Failed: '+ ErrorBuf);
  end;
end;

procedure TMain.ReplicateData;
var
  PosCode,NumLocations : Integer;
  ret1,ret2 : RETCODE;
  Connected2Src : Boolean;
  LocPtr : LocsPtr;
begin
  ret1 := SQL_SUCCESS;
  Connected2Src := False;
  try
    NumLocations := CacheSqlStmts;
    { Cache all the SQL stmts for all tables that may be replicated. At the same time, figure out
      how many target locations there are and cache all of their DB names }
    if (TRSource.InTransaction) then
      TRSource.Commit;
    TRSource.StartTransaction;
    QLocChanges.Open; { Query for distinct LocIds in Change table}
    QLocChanges.First;
    while ((QLocChanges.EOF <> True) and (ret1=SQL_SUCCESS)) do begin
      if (not Connected2Src) then begin
        ret1 := ConnectDb(-1,nil);  {-1 signifies the Source DB}
        ChgLocId := QLocChanges.FieldByName('LOC_ID').AsInteger;
        if (ret1 = SQL_SUCCESS) then
          Connected2Src := True;
      end;
      ChgLocId := QLocChanges.FieldByName('LOC_ID').AsInteger;
      LocPtr := SearchLocsLL(LocsHead,ChgLocId);
      ret2 := ConnectDb(ChgLocId,LocPtr);
      if ((ret2 = SQL_SUCCESS) and (ret1 = SQL_SUCCESS)) then begin
        SyncSrcAndTarget;
        DisconnectDb(ChgLocId);
      end;
      QLocChanges.Next;
    end;
    QLocChanges.Close;
    TRSource.Commit;
    if (Connected2Src) then
      DisconnectDb(-1);  { -1 signifies the Source DB }
  except
    ShowMessage('Exception in ReplicateData');
  end;
end;

procedure TMain.Run1Click(Sender: TObject);
begin
  TDoReplication.Enabled := True;
end;

procedure TMain.FormCreate(Sender: TObject);
var
  ReplIni: TIniFile;
  EvtStr : string;
begin
  Height := 246;
  Width := 370;
  ReplIni := TIniFile.Create('REPL.INI');
  with ReplIni do begin
     ReplPath.Caption := ReadString('ReplMgmt', 'Path', 'Not found');
     EInterval.Text := ReadString('ReplServer', 'Interval', '0');
     EvtStr := ReadString('ReplServer', 'EventResp', 'False');
  end;
  ReplIni.Free;
  if (EvtStr = 'True') then
     CBEvent.Checked := True
  else
     CBEvent.Checked := False;
  try
    SetParams;
    if not (FatalError) then begin
      if not (DBSource.Connected) then
        DBSource.Connected := True;
      if not (EvSourceDB.Connected) then
        EvSourceDB.Connected := True;
      if (Reg4Event) then
        IBEvent.Registered := True;
    end else
      Application.Terminate;
  except
    ShowMessage('Exception in FormCreate');
  end;
end;

procedure TMain.IBEvent1EventAlert(Sender: TObject; EventName: string;
  EventCount: Longint; var CancelAlerts: Boolean);
begin
  TDoReplication.Enabled := True;
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
   FreeSqlStmts; { Free all Cached SQL stmts }
   if ( DBSource.Connected) then
     DBSource.Connected := False;
   if ( EvSourceDB.Connected) then
   begin
     IBEvent.Registered := False;
     EvSourceDB.Connected := False;
   end;
end;

procedure TMain.TDoReplicationTimer(Sender: TObject);
begin
  TDoReplication.Enabled := False;
  if ( Not Running) then
  begin
    Running := True;
    main.TrayIcon1.Hint := 'FB Replicator - Status: Running';
    main.TrayIcon1.Enabled := False;
    main.TrayIcon1.Icon.LoadFromFile('IBReplsmly.ico');
    main.TrayIcon1.Enabled := True;
    main.StatusText.Font.Color := clYellow;
    main.StatusText.Caption := 'Running';
    Image2.Picture.LoadFromFile('YLIGHT.BMP');
    Application.ProcessMessages;
    ReplicateData;
    if (AnyErrors > 0) then begin
      Image2.Picture.LoadFromFile('RLIGHT.BMP');
      main.TrayIcon1.Hint := 'FB Replicator - Status: Errors';
      main.TrayIcon1.Enabled := False;
      main.TrayIcon1.Icon.LoadFromFile('IBReplsmlr.ico');
      main.TrayIcon1.Enabled := True;
      StatusText.Font.Color := clRed;
      StatusText.Caption := 'Errors';
    end else begin
      Image2.Picture.LoadFromFile('GLIGHT.BMP');
      TrayIcon1.Hint := 'FB Replicator - Status: Standby';
      main.TrayIcon1.Enabled := False;
      main.TrayIcon1.Icon.LoadFromFile('IBReplsml.ico');
      main.TrayIcon1.Enabled := True;
      StatusText.Font.Color := clGreen;
      StatusText.Caption := 'Standby';
    end;
    Application.ProcessMessages;
    AnyErrors := 0;
    Screen.Cursor := CrDefault;
    Running := False;
  end;
end;

procedure TMain.TReplIntervalTimer(Sender: TObject);
begin
  TDoReplication.Enabled := True;
end;

procedure TMain.ViewErrors1Click(Sender: TObject);
begin
   errordialog.Show;
end;

procedure TMain.ShutDown1Click(Sender: TObject);
begin
  fCanClose := True;
  Close
end;

procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := fCanClose;
  if not fCanClose then
    Visible := False
end;

procedure TMain.ShowForm1Click(Sender: TObject);
begin
  Visible := True;
  SetFocus;
end;

procedure TMain.SaveEdits5Click(Sender: TObject);
var
  ReplIni: TIniFile;
begin
   main.TReplInterval.Enabled := False;
   main.IBEvent.Registered := False;
   ReplIni := TIniFile.Create('REPL.INI');
   with ReplIni do begin
     WriteString('ReplServer', 'Interval', EInterval.Text);
     if CBEvent.Checked then
        WriteString('ReplServer', 'EventResp', 'True')
     else
        WriteString('ReplServer', 'EventResp', 'False');
   end;
   main.TReplInterval.Interval := StrToInt( EInterval.Text)*1000*60;
   main.TReplInterval.Enabled := True;
   if (CBEvent.Checked) then
     main.IBEvent.Registered := True;
   ReplIni.Free;
end;

procedure TMain.About6Click(Sender: TObject);
begin
  AboutBox := TAboutBox.Create(Application);
  AboutBox.ShowModal;
  AboutBox.Free;
end;

initialization
  SomeNull1 := False;
  SomeNull2 := False;
  SomeNull3 := False;
  SomeNull4 := False;
  SomeNull5 := False;
  AnyErrors := 0;
  FatalError := False;
  Running := False;
  CachedEm := False;
end.
