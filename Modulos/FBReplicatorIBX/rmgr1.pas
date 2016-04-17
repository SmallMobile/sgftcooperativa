unit rmgr1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, OpenDB, RmgrSQL, 
  DualDlg, DBEdit, IniFiles, Menus, DB, DBTables, 
  IBCustomDataSet, IBQuery, IBDatabase;

const
  VERSION = 'FBRM-T0.2';

  CHANGES_INSERT
    = 'insert into changes(TableKey,TableName,Op,Loc_ID)';
  LOCATION_ID_FIELD
    = 'loc_id';
  LOCATION_SELECT
    = 'from repl_tables where TableName=';

  IB_SMALLINT = 7;
  IB_INTEGER  = 8;
  IB_BIGINTEGER = 16;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Edit1: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    ColSrcList: TListBox;
    ColDstList: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    ColModBtn: TButton;
    ColSaveBtn: TButton;
    ColCancelBtn: TButton;
    TriggerMemo: TMemo;
    TrigSaveBtn: TButton;
    TrigCancelBtn: TButton;
    SaveDialog1: TSaveDialog;
    Label6: TLabel;
    DBSrcList: TListBox;
    Label4: TLabel;
    Label5: TLabel;
    DBDstList: TListBox;
    Button1: TButton;
    DbModBtn: TButton;
    DbSaveBtn: TButton;
    DbCancelBtn: TButton;
    TabSheet4: TTabSheet;
    EventMemo: TMemo;
    CheckBox1: TCheckBox;
    EvntCancelBtn: TButton;
    EvntSaveBtn: TButton;
    Panel3: TPanel;
    Label1: TLabel;
    TableListBox: TComboBox;
    Button2: TButton;
    Label7: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    BtnDBOpen: TButton;
    BtnDBClose: TButton;
    PopupMenu2: TPopupMenu;
    Authors1: TMenuItem;
    StaticText1: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    SourceDB: TIBDatabase;
    ReplDB: TIBDatabase;
    SourceTR: TIBTransaction;
    ReplTR: TIBTransaction;
    QuerySource: TIBQuery;
    QueryRepl: TIBQuery;
    chbox1: TCheckBox;
    procedure BtnDBOpenClick(Sender: TObject);
    procedure BtnDBCloseClick(Sender: TObject);
    procedure ColCancelBtnClick(Sender: TObject);
    procedure ColSaveBtnClick(Sender: TObject);
    procedure TrigSaveBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TableListBoxChange(Sender: TObject);
    procedure ColModBtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DbModBtnClick(Sender: TObject);
    procedure DbCancelBtnClick(Sender: TObject);
    procedure DbSaveBtnClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure EvntSaveBtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Authors1Click(Sender: TObject);
  private
    { Private declarations }
    procedure DispErrorMsg( E : EDBEngineError );
    function CountReplTables: Integer;
    procedure SetupReplTables;
    function GetWorkingPath: string;
    procedure InitDstFields(TableName: string);
    procedure InitSrcFields(TableName: String );
    procedure InitTableList;
    procedure InitDbList(TableName: string);
    procedure StoreStmt( Stmt : TStringList; TableName : String; Op : Char);
    procedure BuildTriggers( Fields: TStrings; Table: string; Path: string);
    procedure AddTrigger( Fields : TStrings; Table : string; Op : string;
      TrigTemp: TStringList );
    procedure DropTrigger( Table : string; Op : string; TrigTemp: TStringList );
    procedure AddEventTrigger;
    procedure DropEventTrigger;
    function VerifyIntegerCol(ColName: String; TableName: String): boolean;
    function getFirstSelected( List: TCustomListBox ): Integer;
    procedure GetTrigTemplate( var TrigTemp: TStringList );
    function GetTrigName(TrigLine: string): string;
    function CheckTrigExists( TrigName: string ): boolean;
    function ChangeTrigToAlter( TrigLine: string): string;
    procedure ApplyTrigToDB( TrigLines: TStrings );
    procedure SaveSourceDB(DBServer, DBPath: string; UserName: string; Password: string);
  public
    { Public declarations }
    ReplTable : string[32];
    ReplFields : TStrings;
    ReplPath, ReplServer, ReplUser, ReplPWord : string;
  end;

var
  Form1: TForm1;
  TableList : TStringList;
  FieldList : TStringList;
  DBList: TStringList;
  UserName: string[50];
  WorkingPath: string[255];

implementation

uses DelDb, AppTrig, DBSetup;

{$R *.DFM}

procedure TForm1.DispErrorMsg( E: EDBEngineError );
var
  i: Integer;
  S : string[100];
begin
  for i := 0 to E.ErrorCount-1 do
  begin
    if( E.Errors[i].NativeError <> 0 ) then
      MessageDlg(E.Errors[i].Message, mtInformation, [mbOK], 0 );
  end;
end;

procedure TForm1.BtnDBOpenClick(Sender: TObject);
var
  AliasParams: TStringList;
begin
  { Prompt for db to open }
  if( OpenDBDlg.ShowModal = mrOK ) then begin
    Edit1.Text := OpenDBDlg.DBPath;
    if( OpenDBDlg.DBPath <> '') then begin
      { open the db }
      with SourceDB do begin
        Close;
        {
        Server := copy(OpenDBDlg.DBPath,0,Pos(':',OpenDBDlg.DBPath)-1);
        Path := copy(OpenDBDlg.DBPath,Pos(':',OpenDBDlg.DBPath)+1,255);
        Username := OpenDBDlg.UserName;
        Password := OpenDBDlg.Password;
        }
        DatabaseName := OpenDBDlg.DBPath;
        Params.Clear;
        Params.Add('user_name='+OpenDBDlg.UserName);
        Params.Add('password='+OpenDBDlg.Password);
        try
          Connected := True;
        except
          on E1: EDBEngineError do begin
            ShowMessage('No pude abrir DB: ' + OpenDBDlg.DBPath);
            DispErrorMsg(E1);
          end;
        end;
      end;
      { Verify the selected db has the necessary replication tables }
      if( CountReplTables > 0 ) then begin
        //SaveSourceDB(SourceDB.Server, SourceDB.Path, OpenDBDlg.UserName, OpenDBDlg.Password );
        UserName := OpenDBDlg.UserName;
        InitTableList;
        TableListBox.ItemIndex := 0;
        TableListBoxChange(self);
      end else begin
        SetupDB.Label1.Caption := OpenDBDlg.DBPath;
        if( SetupDB.ShowModal = mrOK ) then begin
          SetupReplTables;
          //SaveSourceDB(SourceDB.Server, SourceDB.Path, OpenDBDlg.UserName, OpenDBDlg.Password );
          UserName := OpenDBDlg.UserName;
          InitTableList;
          TableListBox.ItemIndex := 0;
        end else
          SourceDB.Close;
      end;
    end;
  end;
end;

procedure TForm1.SetupReplTables;
begin
  if SourceTR.InTransaction then
    SourceTR.Commit;
  with QuerySource do begin
    try
      Close;
      SQL.Clear;
      SQL.Add('create table changes(');
      SQL.Add('CHANGECODE BIGINT Not Null,');
      SQL.Add('TABLENAME VARCHAR(32) Not Null,');
      SQL.Add('TABLEKEY BIGINT Not Null,');
      SQL.Add('OP CHAR(1) Not Null,');
      SQL.Add('LOC_ID INTEGER Not Null)');
      SourceTR.StartTransaction;
      ExecSQL;
      SourceTR.Commit;

      SQL.Clear;
      SQL.Add('ALTER TABLE CHANGES ADD CONSTRAINT PK_CHANGES PRIMARY KEY (CHANGECODE)');
      SourceTR.StartTransaction;
      ExecSQL;
      SourceTR.Commit;
      SQL.Clear;
      SQL.Add('CREATE INDEX CHANGES_LOC_ID ON CHANGES (LOC_ID)');
      SourceTR.StartTransaction;
      ExecSQL;
      SourceTR.Commit;
      SQL.Clear;
      SQL.Add('grant select, insert on changes to public');
      SourceTR.StartTransaction;
      ExecSQL;
      SQL.Clear;
      SQL.Add('create table repl_tables(');
      SQL.Add('TABLENAME VARCHAR(32) Not Null,');
      SQL.Add('LOC_ID INTEGER Not Null)');
      ExecSQL;

      SQL.Clear;
      SQL.Add('grant select on repl_tables to public');
      ExecSQL;

      SQL.Clear;
      SQL.Add('create generator gen_changecode');
      ExecSQL;

      SQL.Clear;
      SQL.Add('create trigger insert_changes for changes');
      SQL.Add('before insert as');
      SQL.Add('begin');
      SQL.Add('  new.ChangeCode = gen_id( gen_changecode, 1 );');
      SQL.Add('end');
      ExecSQL;

      SourceTR.Commit;
    except
      on E1: EDBEngineError do
      begin
        ShowMessage('Cannot Setup DB for Replication');
        DispErrorMsg(E1);
        if( SourceTR.inTransaction ) then
          SourceTR.Rollback;
      end;
    end;
  end;
end;

procedure TForm1.SaveSourceDB(DBServer, DBPath: string; UserName: string; Password: string);
begin
  with QueryRepl do begin
    Close;
    SQL.Clear;
    SQL.Add('delete from source_location');

    if ReplTR.InTransaction then
      ReplTR.Commit;
    ReplTR.StartTransaction;
    ExecSQL;

    SQL.Clear;
    SQL.Add('insert into source_location( source_server, source_path, username, passwd )');
    SQL.Add('values( :ss, :sp, :u, :p )');
    ParamByName('ss').AsString := DBServer;
    ParamByName('sp').AsString := DBPath;
    ParamByName('u').AsString := UserName;
    ParamByName('p').AsString := Password;

    ExecSQL;
    ReplTR.Commit;
  end;
end;

function TForm1.CountReplTables: Integer;
var
  Count: Integer;
begin
  Count := 0;
  { Select the special replication table names from the metadata }
  with QuerySource do begin
    Close;
    SQL.Clear;
    SQL.Add('Select RDB$RELATION_NAME FROM');
    SQL.Add('RDB$RELATIONS WHERE');
    SQL.Add('RDB$RELATION_NAME = ''CHANGES''');
    SQL.Add('OR RDB$RELATION_NAME = ''REPL_TABLES''');

    if SourceTR.InTransaction then
      SourceTR.Commit;
    SourceTR.StartTransaction;
    QuerySource.Open;
    First;
    while not QuerySource.EOF do begin
      QuerySource.Next;
      inc(Count);
    end;
    QuerySource.Close;
    SourceTR.Commit;
  end;

  CountReplTables := Count;
end;

procedure TForm1.InitTableList;
begin
  { Set Up Table List Box }
  TableList.Clear;
  with QuerySource do begin
    Close;
    SQL.Clear;
    SQL.Add('Select RDB$RELATION_NAME FROM');
    SQL.Add('RDB$RELATIONS WHERE');
    SQL.Add('RDB$SYSTEM_FLAG <> 1');
    SQL.Add('AND RDB$VIEW_BLR IS NULL');
    SQL.Add('AND RDB$RELATION_NAME <> ''CHANGES''');
    SQL.Add('AND RDB$RELATION_NAME <> ''REPL_TABLES''');
    SQL.Add('ORDER BY RDB$RELATION_NAME');
    if SourceTR.InTransaction then
      SourceTR.Commit;
    SourceTR.StartTransaction;
    Open;
  end;
  while not QuerySource.EOF do begin
    TableList.Add(Trim(QuerySource.Fields[0].AsString));
    QuerySource.Next;
  end;
  QuerySource.Close;
  SourceTR.Commit;
  TableListBox.Items := TableList;
  TableListBox.Sorted := True;
end;

procedure TForm1.InitSrcFields( TableName: string );
var
  i: Integer;
begin
  { Set Up Field List Box }
  FieldList.Clear;
  with QuerySource do begin
    Close;
    SQL.Clear;
    { Get the fields that are not computed and not arrays}
    SQL.Add('Select RF.RDB$FIELD_NAME FROM');
    SQL.Add('RDB$RELATION_FIELDS RF LEFT JOIN RDB$FIELDS F');
    SQL.Add('ON RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME WHERE');
    SQL.Add('RDB$RELATION_NAME = :TABLENAME');
    SQL.Add('AND F.RDB$COMPUTED_BLR IS NULL');
    SQL.Add('AND F.RDB$DIMENSIONS IS NULL');

    {Don't select those fields currently selected }
    for i := 0 to ColDstList.Items.Count - 1 do begin
      SQL.Add('AND RF.RDB$FIELD_NAME <> '''+ColDstList.Items[i]+'''');
    end;

    SQL.Add('ORDER BY RF.RDB$FIELD_NAME');
    ParamByName('TABLENAME').AsString := TableName;
    if SourceTR.InTransaction then
      SourceTR.Commit;
    SourceTR.StartTransaction;
    Open;
    First;
  end;
  while not QuerySource.EOF do begin
    FieldList.Add(Trim(QuerySource.Fields[0].AsString));
    QuerySource.Next;
  end;
  QuerySource.Close;
  SourceTR.Commit;

  ColSrcList.Clear;
  ColSrcList.Items := FieldList;
  ColSrcList.Sorted := True;
end;

procedure TForm1.InitDstFields(TableName: string);
var
  stmt: string[255];
  field: string[32];
  StartPos, CommaPos, EndPos: Integer;
  SelectFound, FromFound: boolean;
begin
  ColDstList.Clear;
  if ReplTR.InTransaction then
    ReplTR.Commit;
  ReplTR.StartTransaction;
  with QueryRepl do begin
    Close;
    SQL.Clear;
    { Get the fields including in any existing REPLDEFS entry}
    SQL.Add('Select SQLSTMT FROM REPLDEFS WHERE');
    SQL.Add('TABLENAME = :TABLENAME');
    SQL.Add('AND OPTYPE = ''S''');
    SQL.Add('ORDER BY MORE');
    ParamByName('TABLENAME').AsString := TableName;
    Open;
    SelectFound := False;
    FromFound := False;
    while ((not EOF) and (not FromFound)) do begin
      { Parse out the column names from the SQLSTMT }
      stmt := Trim(Fields[0].AsString);
      if( not SelectFound ) then begin
        { remove select keyword + blank }
        System.Delete(stmt, 1, 7);
        SelectFound := True;
      end;
      { stop either at the FROM or end of line }
      EndPos := Pos('FROM',stmt);
      if( EndPos = 0 ) then
        EndPos := length(stmt)
      else begin
        FromFound := True;
        dec(EndPos);
        dec(EndPos);
      end;
      if (Pos(',',stmt)=1) then
        System.Delete(stmt,1,1);
      while EndPos > 0 do begin
        CommaPos := Pos(',',stmt);
        if(CommaPos = 0) then
          CommaPos := EndPos+1;
        field := Copy(stmt, 1, CommaPos - 1 );
        ColDstList.Items.Add(field);

        System.Delete(stmt, 1, CommaPos );
        EndPos := EndPos - CommaPos;
      end;

      if( not FromFound ) then
        Next;
    end;
    Close;
  end;
  ReplTR.Commit;
end;

procedure TForm1.InitDbList(TableName: string);
var
  i: Integer;
  DstDbIds: TStringList;
  DstFound: boolean;
begin
  DstDbIds := TStringList.Create;
  DbDstList.Clear;

  with QuerySource do begin
    Close;
    SQL.Clear;
    SQL.Add('Select LOC_ID FROM REPL_TABLES');
    SQL.Add('WHERE TABLENAME = :TABLENAME');
    SQL.Add('ORDER BY LOC_ID');
    ParamByName('TABLENAME').AsString := TableName;
    if ReplTR.InTransaction then
      ReplTR.Commit;
    SourceTR.StartTransaction;
    Open;
    First;
    while not QuerySource.EOF do begin
      DstDbIds.Add(Trim(Fields[0].AsString));
      Next;
    end;
    Close;
  end;
  SourceTR.Commit;

  DbList.Clear;
  with QueryRepl do begin
    Close;
    SQL.Clear;
    SQL.Add('Select LOC_ID,LOC_PATH FROM LOCATIONS');
    SQL.Add('ORDER BY LOC_ID');
    ReplTR.StartTransaction;
    Open;
    First;
    while not EOF do begin
      DstFound := False;
      for i := 0 to DstDbIds.Count-1 do
      begin
        if( CompareStr(DstDbIds[i],Trim(Fields[0].AsString)) = 0 ) then
        begin
          DstFound := True;
          Break;
        end;
      end;

      if( DstFound ) then
        DbDstList.Items.Add(Trim(Fields[0].AsString) + ',' + Trim(Fields[1].AsString))
      else
        DbList.Add(Trim(Fields[0].AsString) + ',' + Trim(Fields[1].AsString));

      Next;
    end;
    Close;
  end;
  ReplTR.Commit;
  DbSrcList.Clear;
  DbSrcList.Items := DbList;
  DbSrcList.Sorted := True;
  DstDbIds.Free;
end;

procedure TForm1.TableListBoxChange(Sender: TObject);
var
  Index: Integer;
begin
  ColDstList.Clear;
  ColSrcList.Clear;
  Index := TableListBox.ItemIndex;
  ReplTable := TableListBox.Items.Strings[ Index ];
  InitDstFields( ReplTable );
  InitSrcFields( ReplTable );
  if( ColDstList.Items.Count > 0 ) then
    BuildTriggers( ColDstList.Items, ReplTable, Edit1.Text )
  else
    TriggerMemo.Clear;
  InitDbList( ReplTable );
end;

procedure TForm1.BtnDBCloseClick(Sender: TObject);
begin
  SourceDB.Close;
end;

procedure TForm1.ColCancelBtnClick(Sender: TObject);
begin
  ColDstList.Clear;
  ColSrcList.Clear;
  TableListBox.ItemIndex := 0;
  TriggerMemo.Clear;
end;

procedure TForm1.ColSaveBtnClick(Sender: TObject);
var
  Stmt :  TStringList;
  Index : Integer;
  Caracter:string;
begin

  if chbox1.Checked then
     Caracter := '"'
  else
     Caracter := '';

  Stmt := TStringList.Create;
  Index := TableListBox.ItemIndex;
  ReplFields := ColDstList.Items;

  RmgrSQL.BuildSelect( ReplFields, ReplTable, Stmt, Caracter);
  StoreStmt( Stmt, TableListBox.Items.Strings[Index], 'S');
  Stmt.Clear;

  RmgrSQL.BuildInsert( ColDstList.Items, TableListBox.Items.Strings[ Index ], Stmt, Caracter );
  StoreStmt( Stmt, TableListBox.Items.Strings[Index], 'I');
  Stmt.Clear;

  RmgrSQL.BuildUpdate( ColDstList.Items, TableListBox.Items.Strings[ Index ], Stmt, Caracter );
  StoreStmt( Stmt, TableListBox.Items.Strings[Index], 'U');
  Stmt.Clear;

  RmgrSQL.BuildDelete( ColDstList.Items, TableListBox.Items.Strings[ Index ], Stmt, Caracter );
  StoreStmt( Stmt, TableListBox.Items.Strings[Index], 'D');
  Stmt.Free;

  BuildTriggers( ColDstList.Items, ReplTable, Edit1.Text );

end;

procedure TForm1.StoreStmt ( Stmt : TStringList; TableName : string; Op : Char);
var
  More, I : SmallInt;
begin
  if ReplTR.InTransaction then
    ReplTR.Commit;
  with QueryRepl do begin
    SQL.Clear;
    SQL.Add('Delete FROM REPLDEFS ');
    SQL.Add('WHERE TABLENAME = :TABLENAME AND');
    SQL.Add('OpType = :OP');

    ParamByName('TABLENAME').AsString := TableName;
    ParamByName('OP').AsString := Op;

    ReplTR.StartTransaction;
    ExecSQL;

    if( Stmt.Count > 1 ) then
      More := 1
    else
      More := 0;

      SQL.Clear;
      SQL.Add('INSERT INTO REPLDEFS(');
      SQL.Add('TABLENAME,OpType,SQLStmt,More) VALUES (');
      SQL.Add(':TABLENAME,:OPERATION,:STMT,:MORE)');
    for I := 0 to (Stmt.Count - 1) do begin
      ParamByName('TABLENAME').AsString := TableName;
      ParamByName('OPERATION').AsString := Op;
      ParamByName('STMT').AsString := Stmt[I];
      ParamByName('MORE').AsInteger := More + I;

      ExecSQL;
    end;
  end;

  ReplTR.Commit;
end;

procedure TForm1.BuildTriggers( Fields : TStrings; Table : string;
  Path : string);
var
  Op : string[6];
  TrigTemplate : TStringList;
begin
  TrigTemplate := TStringList.Create;
  GetTrigTemplate( TrigTemplate );

  With TriggerMemo do
  begin
    Clear;

    Lines.Add('connect "' + Path + '";');
    Lines.Add('');

    Lines.Add('set term ^^;');
    Lines.Add('');

    if( Fields.Count > 0 ) then begin
      Op := 'DELETE';
      AddTrigger( Fields, Table, Op, TrigTemplate );
      Lines.Add('^^');

      Op := 'INSERT';
      AddTrigger( Fields, Table, Op, TrigTemplate );
      Lines.Add('^^');

      Op := 'UPDATE';
      AddTrigger( Fields, Table, Op, TrigTemplate );
      Lines.Add('^^');
    end else begin
      Op := 'INSERT';
      DropTrigger( Table, Op, TrigTemplate );
      Lines.Add('^^');

      Op := 'UPDATE';
      DropTrigger( Table, Op, TrigTemplate );
      Lines.Add('^^');

      Op := 'DELETE';
      DropTrigger( Table, Op, TrigTemplate );
      Lines.Add('^^');
    end;

    Lines.Add('set term ;^^');
  end;
  TrigTemplate.Free;
end;

procedure TForm1.GetTrigTemplate( var TrigTemp: TStringList );
var
  F: TextFile;
  S: string;
begin
  TrigTemp.Clear;
  AssignFile(F, ExtractFilePath(Application.EXEName)+'repltrig.sql');
  Reset(F);
  Readln(F, S);

  while( not Eof(F) ) do
  begin
    if(length(S) > 0) then
    begin
      if(S[1] <> '#') then
      begin
        TrigTemp.Add(S);
      end;
    end;

    Readln(F,S);
  end;
  CloseFile(F);

{    Add('create trigger @@table@@_@@action@@_REPL FOR @@table@@');
    Add('after @@action@@ as');
    Add('begin');
    Add('  if USER <> SYSDBA then');
    Add('  begin');
    Add('    insert into changes(TableKey,TableName,Op,Loc_ID)');
    Add('      select @@context@@.@@tablekey@@,"@@table@@","@@op@@",loc_id');
    Add('      from repl_tables where TableName="@@table@@";');
    Add('  end');
    Add('end^^');
  end;      }
end;

procedure TForm1.AddTrigger( Fields: TStrings; Table: string; Op: string; TrigTemp: TStringList );
var
  OutTrig : string[80];
  TempLine: string[80];
  context : string[4];
  i, StartPos, EndPos: Integer;
  Token: string[32];
  TrigName: string[32];
begin

  if( Op = 'DELETE' ) then
    context := 'OLD'
  else
    context := 'NEW';

  for i := 0 to TrigTemp.Count-1 do
  begin
    TempLine := TrigTemp[i];
    StartPos := Pos('@@',TempLine);
    OutTrig := '';
    while( StartPos > 0 ) do
    begin
      OutTrig := OutTrig + Copy(TempLine, 1, StartPos - 1);
      Delete(TempLine,1,StartPos+1);
      EndPos := Pos('@@',TempLine);
      Token := Copy( TempLine, 1, EndPos-1);
      Delete(TempLine,1,EndPos+1);
      StartPos := Pos('@@',TempLine);

      if( CompareText(Token,'table') = 0 ) then
        OutTrig := OutTrig + Table
      else if( CompareText(Token,'action') = 0 ) then
        OutTrig := OutTrig + Op
      else if( CompareText(Token,'context') = 0 ) then
        OutTrig := OutTrig + context
      else if( CompareText(Token,'tablekey') = 0 ) then
        OutTrig := OutTrig + Fields.Strings[0]
      else if( CompareText(Token,'op') = 0 ) then
        OutTrig := OutTrig + Op[1]
      else if( CompareText(Token,'username') = 0 ) then
        OutTrig := OutTrig + UserName;
    end;

    OutTrig := OutTrig + TempLine;

    if( Pos('CREATE', AnsiUpperCase(OutTrig)) > 0 ) then
    begin
      TrigName := GetTrigName( OutTrig );
      if( CheckTrigExists( TrigName ) ) then begin
        OutTrig := ChangeTrigToAlter( OutTrig );
      end;
    end;

    TriggerMemo.Lines.Add(OutTrig);
  end;

{    With TriggerMemo do
    begin
    OutTrig := 'create trigger ' + Table + '_' + Op + '_REPL FOR ' + Table;
    Lines.Add( OutTrig);
    OutTrig := 'after ' + Op + ' as';
    Lines.Add( OutTrig );
    Lines.Add( 'begin' );
    OutTrig := CHANGES_INSERT;
    Lines.Add( '  ' + OutTrig );
    OutTrig := 'select ' + context + '.' + Fields.Strings[0] + ',"' + Table + '"'
       + ',"' + Op[1] + '",' + LOCATION_ID_FIELD;
    Lines.Add( '    ' + OutTrig );
    OutTrig := LOCATION_SELECT + '"' + Table + '"' + ';';
    Lines.Add( '    ' + OutTrig );
    Lines.Add( 'end^^' );
  end;   }
end;

procedure TForm1.DropTrigger( Table : string; Op : string; TrigTemp: TStringList );
var
  OutTrig : string[80];
  TempLine: string[80];
  i, StartPos, EndPos: Integer;
  Token: string[32];
  TrigName: string[32];
begin
  for i := 0 to TrigTemp.Count-1 do
  begin
    TempLine := TrigTemp[i];
    StartPos := Pos('@@',TempLine);
    OutTrig := '';
    while( StartPos > 0 ) do
    begin
      OutTrig := OutTrig + Copy(TempLine, 1, StartPos - 1);
      Delete(TempLine,1,StartPos+1);
      EndPos := Pos('@@',TempLine);
      Token := Copy( TempLine, 1, EndPos-1);
      Delete(TempLine,1,EndPos+1);
      StartPos := Pos('@@',TempLine);

      if( CompareText(Token,'table') = 0 ) then
        OutTrig := OutTrig + Table
      else if( CompareText(Token,'action') = 0 ) then
        OutTrig := OutTrig + Op
      else if( CompareText(Token,'op') = 0 ) then
        OutTrig := OutTrig + Op[1]
      else if( CompareText(Token,'username') = 0 ) then
        OutTrig := OutTrig + UserName;
    end;

    OutTrig := OutTrig + TempLine;

    if(Pos('CREATE',AnsiUpperCase(OutTrig)) > 0 ) then
    begin
      TriggerMemo.Lines.Add('DROP TRIGGER '+ GetTrigName(OutTrig));
      break;
    end;
  end;
end;

procedure TForm1.TrigSaveBtnClick(Sender: TObject);
begin
  SaveDialog1.Execute;
  if(SaveDialog1.FileName <> '' ) then
    TriggerMemo.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TableList := TStringList.Create;
  FieldList := TStringList.Create;
  DBList := TStringList.Create;

  WorkingPath := GetWorkingPath;

  if( Length(WorkingPath) > 0 ) then
  begin
    with ReplDB do begin
      Close;
      {
      Server :=  ReplServer;
      Path := ReplPath;
      Username := ReplUser;
      Password:= ReplPWord;
      }
      DatabaseName :=  ReplServer+':'+ReplPath;
      Params.Clear;
      Params.Add('user_name='+ReplUser);
      Params.Add('password='+ReplPWord);
      try
        Connected := True;
      except
        on E1: EDBEngineError do
        begin
          ShowMessage('Cannot open DB: ' + WorkingPath );
          DispErrorMsg(E1);
          Application.Terminate;
        end;
      end;
    end;
  end else
    Application.Terminate;
end;

function TForm1.GetWorkingPath: string;
var
  IniFile: TIniFile;
  WPaths: TStringList;
  Path: string[255];
begin
  WPaths := TStringList.Create;
  IniFile := TIniFile.Create('REPL.INI');
  ReplServer:= IniFile.ReadString('ReplMgmt', 'Server', 'Not Found');
  ReplPath:= IniFile.ReadString('ReplMgmt', 'Path', 'Not Found');
  ReplUser:= IniFile.ReadString('ReplMgmt', 'UserName', 'Not Found');
  ReplPWord:= IniFile.ReadString('ReplMgmt', 'Password', 'Not Found');
  Path := ReplPath;
  if (StrComp('Not Found',PChar(ReplPath)) = 0) or(StrComp('Not Found',PChar(ReplServer))=0) then begin
    ShowMessage('Cannot find REPL.INI or the ReplMgmt section is missing.  See readme.txt included with Replication Server zip file.');
    Path := '';
  end else begin
    Path := Trim(Path);
    if( Path[Length(Path)] = '\' ) then
      Delete(Path, Length(Path), 1 );
  end;

  GetWorkingPath := Path;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  TableList.Free;
  FieldList.Free;
  DBList.Free;
  SourceDB.Close;
  ReplDB.Close;
end;

procedure TForm1.ColModBtnClick(Sender: TObject);
begin
  DualListDlg.SrcList.Items := ColSrcList.Items;
  DualListDlg.SrcLabel.Caption := 'Columnas';
  DualListDlg.DstList.Items := ColDstList.Items;
  DualListDlg.DstLabel.Caption := 'Columnas Replicadas';
  if(DualListDlg.ShowModal = mrOK) then
  begin
    if(DualListDlg.DstList.Items.Count > 0 ) then
    begin
      if(VerifyIntegerCol(DualListDlg.DstList.Items.Strings[0], ReplTable)) then
      begin
        ColSrcList.Items := DualListDlg.SrcList.Items;
        ColDstList.Items := DualListDlg.DstList.Items;
      end else
        ShowMessage(DualListDlg.DstList.Items.Strings[0] + ' no es un Entero!');
    end else
    begin
      ColSrcList.Items := DualListDlg.SrcList.Items;
      ColDstList.Items := DualListDlg.DstList.Items;
    end;
  end;
end;

function TForm1.VerifyIntegerCol(ColName: String; TableName: String): boolean;
var
  IsInteger: boolean;
begin
  IsInteger := False;

  with QuerySource do
  begin
    SQL.Clear;
    { Get the fields that are not computed }
    SQL.Add('Select F.RDB$FIELD_TYPE FROM');
    SQL.Add('RDB$RELATION_FIELDS RF, RDB$FIELDS F');
    SQL.Add('WHERE RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME AND');
    SQL.Add('RF.RDB$RELATION_NAME = :TABLENAME');
    SQL.Add('AND RF.RDB$FIELD_NAME = :COLNAME');
    ParamByName('TABLENAME').AsString := TableName;
    ParamByName('COLNAME').AsString := ColName;
    SourceTR.StartTransaction;
    Open;
    if not EOF then begin
      if( (Fields[0].AsInteger = IB_SMALLINT) or
          (Fields[0].AsInteger = IB_INTEGER) or
          (Fields[0].AsInteger = IB_BIGINTEGER)) then
        IsInteger := True;
    end;
    Close;
  end;
  SourceTR.Commit;

  VerifyIntegerCol := IsInteger;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  NewPath: string[255];
begin
  Form2.LocPath := 'server:[drive]\path';
  Form2.User := '';
  Form2.Password := '';
  Form2.RasServiceName := '';
  Form2.RasUser := '';
  Form2.RasPassword := '';

  if(Form2.ShowModal = mrOK) then
  begin
    with QueryRepl do
    begin
      SQL.Clear;
      { Get the fields including in any existing REPLDEFS entry}
      SQL.Add('INSERT INTO LOCATIONS (LOC_PATH, RAS_SERVICENAME, ');
      SQL.Add('RAS_USER,RAS_PASSWORD, USERNAME, PASSWD)');
      SQL.Add('VALUES(:LP, :RS, :RU, :RP, :U, :P)');
      ParamByName('LP').AsString := Form2.LocPath;
      ParamByName('RS').AsString := Form2.RasServiceName;
      ParamByName('RU').AsString := Form2.RasUser;
      ParamByName('RP').AsString := Form2.RasPassword;
      ParamByName('U').AsString := Form2.User;
      ParamByName('P').AsString := Form2.Password;

      if ReplTR.InTransaction then
        ReplTR.Commit;
      ReplTR.StartTransaction;
      ExecSQL;
      ReplTR.Commit;

      InitDbList(ReplTable);
    end;
  end;
end;

procedure TForm1.DbModBtnClick(Sender: TObject);
begin
  DualListDlg.SrcList.Items := DbSrcList.Items;
  DualListDlg.SrcLabel.Caption := 'Databases';
  DualListDlg.DstList.Items := DbDstList.Items;
  DualListDlg.DstLabel.Caption := 'Target Databases';
  if(DualListDlg.ShowModal = mrOK) then
  begin
    DbSrcList.Items := DualListDlg.SrcList.Items;
    DbDstList.Items := DualListDlg.DstList.Items;
  end;
end;

procedure TForm1.DbCancelBtnClick(Sender: TObject);
begin
  DbSrcList.Clear;
  DbDstList.Clear;
  DbSrcList.Items := DbList;
end;

procedure TForm1.DbSaveBtnClick(Sender: TObject);
var
  i, len: Integer;
  loc_str: string[10];
begin
  with QuerySource do
  begin
    SQL.Clear;
    SQL.Add('Delete FROM REPL_TABLES ');
    SQL.Add('WHERE TABLENAME = :TABLENAME');

    ParamByName('TABLENAME').AsString := TableListBox.Items.Strings[TableListBox.ItemIndex];

    if SourceTR.InTransaction then
      SourceTR.Commit;
    SourceTR.StartTransaction;
    ExecSQL;

    for i:= 0 to DbDstList.Items.Count - 1 do
    begin
      SQL.Clear;
      SQL.Add('INSERT INTO REPL_TABLES(');
      SQL.Add('TABLENAME, LOC_ID) VALUES (');
      SQL.Add(':TABLENAME,:LOC_ID)');

      ParamByName('TABLENAME').AsString := TableListBox.Items.Strings[TableListBox.ItemIndex];

      { parse the location id out of the path string }
      Len := Pos(',',DbDstList.Items.Strings[i]) -1;
      loc_str := Copy(DbDstList.Items.Strings[i], 0, Len);
      ParamByName('LOC_ID').AsString := loc_str;

      ExecSQL;
    end;
  end;

  SourceTR.Commit;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if(CheckBox1.Checked = True) then
    AddEventTrigger
  else
    DropEventTrigger;
end;

procedure TForm1.AddEventTrigger;
begin
  With EventMemo do
  begin
    Clear;

    Lines.Add('connect "' + Edit1.Text + '";');
    Lines.Add('');

    Lines.Add('set term ^^;');
    Lines.Add('');

    Lines.Add('create trigger CHANGES_INSERT_REPL for CHANGES');
    Lines.Add('after insert as');
    Lines.Add('begin');
    Lines.Add('  POST_EVENT ' + QuotedStr('new_change') );
    Lines.Add('end');
    Lines.Add('^^');

    Lines.Add('');
    Lines.Add('set term ;^^');
  end;
end;

procedure TForm1.DropEventTrigger;
begin
  With EventMemo do
  begin
    Clear;

    Lines.Add('connect "' + Edit1.Text + '";');
    Lines.Add('');

    Lines.Add('set term ^^;');
    Lines.Add('');

    Lines.Add('drop trigger CHANGES_INSERT_REPL');
    Lines.Add('^^');

    Lines.Add('');
    Lines.Add('set term ;^^');
  end;
end;

procedure TForm1.EvntSaveBtnClick(Sender: TObject);
begin
  SaveDialog1.Execute;
  if(SaveDialog1.FileName <> '' ) then
    EventMemo.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  x, LocId, CommaPos: Integer;
  EditDB: string[100];
begin
  EditDB := '';

  x := getFirstSelected( DBDstList );
  if( x > -1 ) then
    EditDB := DBDstList.Items[x]
  else begin
    x := getFirstSelected( DBSrcList );
    if( x > -1 ) then
      EditDB := DBSrcList.Items[x];
  end;

  if( length(EditDB) <> 0 ) then
  begin
    CommaPos := Pos(',', EditDB);
    LocId := StrToInt(Copy(EditDB, 1, CommaPos - 1));

    with QueryRepl do
    begin
      SQL.Clear;
      { Get the fields including in any existing REPLDEFS entry}
      SQL.Add('Select LOC_PATH,USERNAME,PASSWD,RAS_SERVICENAME,RAS_USER,RAS_PASSWORD ');
      SQL.Add('FROM LOCATIONS WHERE');
      SQL.Add('LOC_ID = :LOC_ID');
      ParamByName('LOC_ID').AsInteger := LocId;
      if ReplTR.InTransaction then
        ReplTR.Commit;
      ReplTR.StartTransaction;
      Open;

      if (not EOF) then
      begin
        Form2.LocPath := Trim(Fields[0].AsString);
        Form2.User := Trim(Fields[1].AsString);
        Form2.Password := Trim(Fields[2].AsString);
        Form2.RasServiceName := Trim(Fields[3].AsString);
        Form2.RasUser := Trim(Fields[4].AsString);
        Form2.RasPassword := Trim(Fields[5].AsString);
      end;
      Close;
      ReplTR.Commit;

      if(Form2.ShowModal = mrOK) then
      begin
        SQL.Clear;
        { Get the fields including in any existing REPLDEFS entry}
        SQL.Add('UPDATE LOCATIONS SET LOC_PATH = :L,RAS_SERVICENAME =:RS,');
        SQL.Add('RAS_USER = :RU,RAS_PASSWORD = :RP, USERNAME = :U, PASSWD = :P');
        SQL.Add('WHERE LOC_ID = :LOC_ID');
        ParamByName('L').AsString := Form2.LocPath;
        ParamByName('RD').AsString := Form2.RasServiceName;
        ParamByName('RU').AsString := Form2.RasUser;
        ParamByName('RP').AsString := Form2.RasPassword;
        ParamByName('U').AsString := Form2.User;
        ParamByName('P').AsString := Form2.Password;
        ParamByName('LOC_ID').AsInteger := LocId;
        ReplTR.Commit;
        ReplTR.StartTransaction;
        ExecSQL;
        ReplTR.Commit;

        InitDbList(ReplTable);
      end;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  x, Len: Integer;
  loc_str: string[10];
  DelDB: string[100];
begin
  DelDB := '';

  { get the selected db path }
  x := getFirstSelected( DBDstList );
  if( x > -1 ) then
    DelDB := DBDstList.Items[x]
  else begin
    x := getFirstSelected( DBSrcList );
    if( x > -1 ) then
      DelDB := DBSrcList.Items[x];
  end;

  { if one's selected, confirm choice }
  if( length(DelDB) > 0) then
  begin
    DelDbDlg.DBPath := DelDB;
    if( DelDbDlg.ShowModal = mrOK ) then
    begin
      { parse out the location id }
      Len := Pos(',',DelDB) -1;
      loc_str := Copy(DelDB, 0, Len);

      { delete any pending changes }
      with QuerySource do
      begin
        SQL.Clear;
        SQL.Add('DELETE FROM CHANGES WHERE LOC_ID = :L');
        ParamByName('L').AsString := loc_str;

        if SourceTR.InTransaction then
          SourceTR.Commit;
        SourceTR.StartTransaction;
        ExecSQL;
        SourceTR.Commit;
      end;

      { delete from global locations table }
      with QueryRepl do
      begin
        SQL.Clear;
        SQL.Add('DELETE FROM LOCATIONS WHERE LOC_ID = :L');
        ParamByName('L').AsString := loc_str;

        if ReplTR.InTransaction then
          ReplTR.Commit;
        ReplTR.StartTransaction;
        ExecSQL;
        ReplTR.Commit;
      end;

      InitDbList(ReplTable);
    end;
  end;
end;

function TForm1.getFirstSelected( List: TCustomListBox ): Integer;
var
  x: Integer;
begin
  getFirstSelected := -1;
  for x:= 0 to List.Items.Count -1 do
    if List.Selected[x] then
    begin
      getFirstSelected := x;
      Break;
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if( OKTrigDlg.ShowModal = mrOK ) then
  begin
    ApplyTrigtoDB( TriggerMemo.Lines );
  end;
end;

procedure TForm1.ApplyTrigToDB( TrigLines: TStrings );
var
  inTrigger: boolean;
  i: Integer;
  UpLine: string[255];
begin
  try
    if SourceTR.InTransaction then
      SourceTR.Commit;
    SourceTR.StartTransaction;

    QuerySource.SQL.Clear;
    inTrigger := False;

    for i := 0 to TrigLines.Count - 1 do
    begin
      if( not inTrigger ) then
      begin
        UpLine := AnsiUpperCase(TrigLines[i]);
        if( (Pos('CREATE', UpLine) > 0) or
            (Pos('ALTER', UpLine) > 0) or
            (Pos('DROP', UpLine) > 0) ) then
          inTrigger := True;
      end else if( Pos('^^', TrigLines[i] ) > 0) then
      begin
        inTrigger := False;
        QuerySource.ExecSQL;
        QuerySource.SQL.Clear;
      end;

      if( inTrigger = True ) then
        QuerySource.SQL.Add(TrigLines[i]);
    end;
    SourceTR.Commit;
  except
    on E1: EDBEngineError do
    begin
      ShowMessage('Cannot Apply Triggers to DB');
      DispErrorMsg(E1);
      if( SourceTR.InTransaction ) then
        SourceTR.Rollback;
    end;
  end;
end;

function TForm1.ChangeTrigToAlter( TrigLine: string): string;
var
  UpLine: string[255];
  StartPos: integer;
begin
  UpLine := AnsiUpperCase(TrigLine);
  StartPos := Pos('CREATE', UpLine );
  if( StartPos > 0 ) then
  begin
    Delete( UpLine, StartPos, length('CREATE') );
    StartPos := Pos('FOR', UpLine );
    Delete( UpLine, StartPos, Length(UpLine) - StartPos + 1);
    TrigLine := 'ALTER' + UpLine;
  end;

  ChangeTrigToAlter := TrigLine;
end;

function TForm1.CheckTrigExists( TrigName: string ): boolean;
begin
  with QuerySource do
  begin
    SQL.Clear;
    SQL.Add('select rdb$trigger_name from rdb$triggers where');
    SQL.Add('rdb$trigger_name = :trig');
    ParamByName('TRIG').AsString := TrigName;

    if SourceTR.InTransaction then
      SourceTR.Commit;
    SourceTR.StartTransaction;
    Open;
    if( not EOF ) then
      CheckTrigExists := True
    else
      CheckTrigExists := False;

    Close;
    SourceTR.Commit;
  end;
end;

function TForm1.GetTrigName( TrigLine: string ): string;
var
  i, NameStart, NameEnd: Integer;
  TrigName: string[32];
  UpLine: string[255];
  Done: boolean;
begin
  Done := False;
  TrigName := '';

  UpLine := AnsiUpperCase(TrigLine);
  if( Pos('CREATE', UpLine ) > 0 ) then
  begin
    NameStart := Pos('TRIGGER', UpLine ) + length('TRIGGER') + 1;
    NameEnd := Pos('FOR', UpLine);
    TrigName := Copy(UpLine, NameStart, NameEnd - NameStart);
    TrigName := Trim(TrigName);
  end else if( (Pos('DROP', UpLine ) > 0) or
               (Pos('ALTER', UpLine) > 0) ) then
  begin
    NameStart := Pos('TRIGGER', UpLine) + length('TRIGGER') + 1;
    NameEnd := length(UpLine);
    TrigName := Copy(UpLine, NameStart, NameEnd - NameStart);
    TrigName := Trim(TrigName);
  end;

  GetTrigName := TrigName;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if( OKTrigDlg.ShowModal = mrOK ) then
  begin
    ApplyTrigtoDB( EventMemo.Lines );
  end;
end;

procedure TForm1.Authors1Click(Sender: TObject);
begin
  ShowMessage('Stan Dorcey and Kevin Gardeck');
end;

end.
