library ibdc;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  View-Project Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the DELPHIMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using DELPHIMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,  Classes,
  IBAPI in 'ibapi.pas';

Procedure IBDateToTM( IbDatePtr:PISC_QUAD;Ptr: Pointer);
var
  Tm1 : TM;
  TStr : string;
begin
   isc_decode_date(IbDatePtr,@Tm1);
   TStr := Format('%2.2d/%2.2d/%4d %2.2d:%2.2d:%2.2d',[Tm1.mon+1,Tm1.mday,Tm1.year+1900,Tm1.hour,Tm1.min,Tm1.sec]);
   StrPCopy(Ptr,TStr);
end;

Procedure IBTMToDate(Ptr : Pointer;TmStr: PChar);
var
  TmpChar2 : array[0..2] of Char;
  TmpChar4 : array[0..4] of Char;
  TmValue : TM;
begin
  TmpChar2[2] := Char(0);
  TmpChar4[4] := Char(0);
{
  sec     : Integer;
  min     : Integer;
  hour    : Integer;
  mday    : Integer;
  mon     : Integer;
  year    : Integer;
  wday    : Integer;
  yday    : Integer;
}
  { The string passed in must be of the format
    mm/dd/yyyy hh:mm:ss
  }
  TmpChar2[2] := Char(0);
  StrPLCopy(TmpChar2,TmStr,2);
  TmValue.mon := StrToInt(TmpChar2) -1; {Subtract one from month}
  StrPLCopy(TmpChar2,TmStr+3,2);
  TmValue.mday := StrToInt(TmpChar2);
  StrPLCopy(TmpChar4,TmStr+6,4);
  TmValue.year := StrToInt(TmpChar4)-1900;
  StrPLCopy(TmpChar2,TmStr+11,2);
  TmValue.hour := StrToInt(TmpChar2);
  StrPLCopy(TmpChar2,TmStr+14,2);
  TmValue.min := StrToInt(TmpChar2);
  StrPLCopy(TmpChar2,TmStr+17,2);
  TmValue.sec := StrToInt(TmpChar2);
  isc_encode_date(@TmValue,Ptr);
end;

function IBBlobToPtr( hstmt: HSTMT;BlobPtr:PISC_QUAD;Ptr:Pointer;SegSize:Integer):LongInt;
var
  errcode : isc_status;
  TmValue : TM;
  TmpPtr : Pointer;
  bhndl : isc_blob_handle;
  SegLen : Short;
  IbStatus : status_vector;
  BlobSize : LongInt;
begin
   SegLen := 0;
   BlobSize := 0;
   bhndl := nil;
   errcode := isc_open_blob2( @IbStatus, @(hstmt^.hdbc.db_handle), @(hstmt^.hdbc.tx_handle),@bhndl,BlobPtr,0,nil);
   TmpPtr := Ptr;
   while (errcode <> isc_segstr_eof) do
   begin
       errcode := isc_get_segment( @IbStatus, @bhndl,@SegLen,SegSize,TmpPtr);
       TmpPtr := PChar(TmpPtr) + SegLen;
       BlobSize := BlobSize + SegLen;
   end;
   errcode := isc_close_blob( @IbStatus, @bhndl);
   if errcode <> 0 then
     IBBlobToPtr := -1
   else
     IBBlobToPtr := BlobSize;
end;

function SearchLL(Head:PPtr;SVal : Integer): Pointer;
var
  CurPtr : PPtr;
  Foundit : Integer;
begin
  CurPtr := Head;
  Foundit := 0;
  if ( CurPtr <> nil) then
  begin
     while (CurPtr <> nil) and (Foundit = 0) do
     begin
        if ( CurPtr^.Index = SVal) then
          Foundit := 1
        else
          CurPtr := CurPtr^.link;
     end;
  end;
  if CurPtr = nil then
     SearchLL := nil
  else
     SearchLL := CurPtr^.Ptr;
end;

function IsNullSearchLL(Head:PPtr;SVal : Integer): Pointer;
var
  CurPtr : PPtr;
  Foundit : Integer;
begin
  CurPtr := Head;
  Foundit := 0;
  if ( CurPtr <> nil) then
  begin
     while (CurPtr <> nil) and (Foundit = 0) do
     begin
        if ( CurPtr^.Index = SVal) then
          Foundit := 1
        else
          CurPtr := CurPtr^.link;
     end;
  end;
  if CurPtr = nil then
     IsNullSearchLL := nil
  else
     IsNullSearchLL := CurPtr^.NullPtr;
end;

function BlobSearchLL(Head:PPtr;SVal : Integer): PPtr;
var
  CurPtr : PPtr;
  Foundit : Integer;
begin
  CurPtr := Head;
  Foundit := 0;
  if ( CurPtr <> nil) then
  begin
     while (CurPtr <> nil) and (Foundit = 0) do
     begin
        if ( CurPtr^.Index = SVal) then
          Foundit := 1
        else
          CurPtr := CurPtr^.link;
     end;
  end;
  if CurPtr = nil then
     BlobSearchLL := nil
  else
     BlobSearchLL := CurPtr;
end;

procedure UpdateIsNullPtr(Head:PPtr;SVal : Integer;IsNull:Boolean);
var
  CurPtr : PPtr;
  Foundit : Integer;
begin
  CurPtr := Head;
  Foundit := 0;
  if ( CurPtr <> nil) then
  begin
     while (CurPtr <> nil) and (Foundit = 0) do
     begin
        if ( CurPtr^.Index = SVal) then
          Foundit := 1
        else
          CurPtr := CurPtr^.link;
     end;
  end;
  if (CurPtr <> nil) and (CurPtr^.NullPtr <> nil) then
     CurPtr^.NullPtr^ := IsNull;
end;

procedure AddLL(Head:PPPtr;SVal:Integer;Ptr:Pointer;PtrNull:Pointer;TotalSize:PSDWORD;SegSize : Integer);
var
  TmpPtr,NewPtr : PPtr;
begin
  New(NewPtr);
  NewPtr^.Index := SVal;
  NewPtr^.Ptr := Ptr;
  NewPtr^.NullPtr := PtrNull;
  NewPtr^.NullPtr^ := False;
  NewPtr^.TotalSize := TotalSize;
  NewPtr^.SegSize := SegSize;
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

procedure DestroyLL(Head:PPPtr);
var
  CurPtr,NextPtr : PPtr;
begin
  CurPtr := Head^;
  if ( CurPtr <> nil) then
  begin
     while (CurPtr^.link <> nil) do
     begin
        NextPtr := CurPtr^.link;
        FreeMem(CurPtr);
        CurPtr := NextPtr;
     end;
     FreeMem(CurPtr);
     Head^ := nil;
  end
end;

function SQLAllocConnect( hdbc : PHDBC) : RETCODE; export;
begin
    hdbc^ := AllocMem(sizeof(ODBC));
    SQLAllocConnect := SQL_SUCCESS;
end;

function  SQLSetConnectOption( hdbc : HDBC;foption : UWORD;vparam: UDWORD) : RETCODE;export;
var
  retval : RETCODE;
  ret : isc_status;
begin
  retval := SQL_SUCCESS;
  if (foption  = SQL_AUTOCOMMIT) then
  begin
    case vparam of
      SQL_AUTOCOMMIT_ON:
      begin
         hdbc^.autocommit_flag := 1;
         if (hdbc^.tx_handle <> nil) then
         begin
             ret := isc_commit_transaction(@(hdbc^.status),@(hdbc^.tx_handle));
             if (ret <> 0) then
                retval := SQL_ERROR;
         end
      end
      else
         hdbc^.autocommit_flag := 1;
    end;
  end;
  SQLSetConnectOption := retval;
end;

function SQLDisconnect( hdbc : PHDBC) : RETCODE;export;
var
  retval : RETCODE;
begin
    retval := SQL_SUCCESS;
    { Add bs to committ txs, detach from db  }
    if (hdbc^.tx_handle <> nil) then
        isc_commit_transaction(@(hdbc^.status),@(hdbc^.tx_handle));
    isc_detach_database(@(hdbc^.status),@(hdbc^.db_handle));
    FreeMem(hdbc^);
    hdbc^ := nil;
    SQLDisconnect := retval;
end;

function SQLConnect( hdbc : HDBC;DatabaseName, UserName, Password : PChar) : RETCODE;export;
var
    i, len : integer;
    DATABASE : array[0..255] of Char;
    dpb : array[0..47] of Char;
    p : PChar;
    ret : isc_status;
    retval : RETCODE;
begin
    retval := SQL_SUCCESS;
    i := 0;
    dpb[i] := char(isc_dpb_version1);
    inc(i);
    dpb[i] := char(isc_dpb_user_name);
    inc(i);
    len := Length(UserName);
    dpb[i] := char(len);
    inc(i);
    p := @dpb[i];
    StrPCopy( p, UserName );
    i := i + len;
    dpb[i] := char(isc_dpb_password);
    inc(i);
    len := Length(Password);
    dpb[i] := char(len);
    inc(i);
    p := @dpb[i];
    StrPCopy(p, Password);
    i := i + len;
    StrPCopy( DATABASE, DatabaseName);
    len := StrLen(DATABASE);
    p := @dpb[0];
    ret := isc_attach_database(@(hdbc^.status), 0,@DATABASE,@(hdbc^.db_handle),i, @dpb);
    if (ret <> 0) then
       retval := SQL_ERROR;
    SQLConnect := retval;
end;

function  SQLTransact( hdbc : HDBC; TxOption : UWORD) : RETCODE;export;
var
  retval : RETCODE;
  ret : isc_status;
  teb : isc_teb;
begin
  retval := SQL_SUCCESS;
  if (hdbc^.tx_handle <> nil) then
  begin
    case TxOption of
       SQL_COMMIT:
       begin
         ret := isc_commit_transaction(@(hdbc^.status),@(hdbc^.tx_handle))
       end;
       SQL_BEGIN_TRANS:
       begin
         teb.db_ptr := @(hdbc^.db_handle);
         teb.tpb_len := 0;
         teb.tpb_ptr := nil;
         ret := isc_start_multiple( @(hdbc^.status), @(hdbc^.tx_handle), 1, @teb);
       end
       else
        ret := isc_rollback_transaction(@(hdbc^.status),@(hdbc^.tx_handle));
    end;
    if (ret <> 0) then
        retval := SQL_ERROR;
  end;
  SQLTransact := retval;
end;

function  SQLTransactMdb( hdbcArr : array of PHDBC;TxOption : UWORD;DbCount:Integer) : RETCODE;export;
var
  teb : array[0..(MaxDbs-1)] of isc_teb;
  i : Integer;
  retval : RETCODE;
  ret : isc_status;
  hdbc,PrevHdbc : PHDBC;
begin
  ret := 0;
  retval := Word(SQL_SUCCESS);
  hdbc := hdbcArr[0];

  case TxOption of
    SQL_COMMIT:
    begin
        ret := isc_commit_transaction(@(hdbc^.status),@(hdbc^.tx_handle));
      { Update all of the hdbc.tx_handles
        Update all of the status if there was an error
      }
      PrevHdbc := hdbc;
      for i := 1 to DbCount-1 do
      begin
        hdbc := hdbcArr[i];
        hdbc^.tx_handle := PrevHdbc^.tx_handle;
        hdbc^.status := PrevHdbc^.status;
      end;
    end;
    SQL_ROLLBACK:
    begin
      ret := isc_rollback_transaction(@(hdbc^.status),@(hdbc^.tx_handle));
      PrevHdbc := hdbc;
      for i := 1 to DbCount-1 do
      begin
        hdbc := hdbcArr[i];
        hdbc^.tx_handle := PrevHdbc^.tx_handle;
        hdbc^.status := PrevHdbc^.status;
      end;
    end;
    SQL_BEGIN_TRANS:
    begin
      i := 0;
      while (i < DbCount) and (i < MaxDbs) do
      begin
        hdbc := hdbcArr[i];
        begin
          PrevHdbc := hdbc;
          teb[i].db_ptr := @(hdbc^.db_handle);
          teb[i].tpb_len := 0;
          teb[i].tpb_ptr := nil;
          Inc(i);
        end;
      end;
      ret := isc_start_multiple( @(PrevHdbc^.status), @(PrevHdbc^.tx_handle), DbCount,@teb);
      { Update all of the hdbc.tx_handles
        Update all of the status if there was an error
      }
      for i := 0 to DbCount-2 do
      begin
        hdbc := hdbcArr[i];
        hdbc^.tx_handle := PrevHdbc^.tx_handle;
        hdbc^.status := PrevHdbc^.status;
      end;
    end;
  end;
  if (ret <> 0) then
     retval := SQL_ERROR;
   SQLTransactMdb := retval;
end;

function  SQLAllocStmt( hdbc : HDBC; hstmt :PHSTMT) : RETCODE;export;
var
  retval : RETCODE;
  ret : isc_status;
begin
  retval := SQL_ERROR;
  hstmt^ := AllocMem(sizeof(IB_STMT));
  ret := isc_dsql_allocate_statement(@(hdbc^.status),@(hdbc^.db_handle),@(hstmt^.st_handle));
  if  ( ret = 0 ) then
  begin
    hstmt^.hdbc := hdbc;   { Save the database handle ass. w/this statement }
    hstmt^.posqlda := AllocMem( XSQLDA_LENGTH ( MinCols ));
    hstmt^.posqlda^.version := SQLDA_VERSION1;
    hstmt^.posqlda^.sqln := MinCols;
    hstmt^.pisqlda := AllocMem( XSQLDA_LENGTH ( MinCols ));
    hstmt^.pisqlda^.version := SQLDA_VERSION1;
    hstmt^.pisqlda^.sqln := MinCols;
    retval := SQL_SUCCESS;
  end;
  SQLAllocStmt := retval;
end;

function  SQLFreeStmt( hstmt :HSTMT;foption :UWORD) : RETCODE;export;
var
  retval : RETCODE;
  ret : isc_status;
  i,dtype: Integer;
  ovar,ivar: PXSQLVAR;
begin
  retval := SQL_SUCCESS;
  case foption of
    SQL_DROP: begin
      if (hstmt^.hdbc.OpenCursors > 0) and (hstmt^.HasCursor = 1) then
        Dec(hstmt^.hdbc.OpenCursors);
      isc_dsql_free_statement( @(hstmt^.status), @(hstmt^.st_handle), DSQL_drop );
      if (hstmt^.BoundOutputs >0) then begin
        { Free memory alloc'd for NULL-indicators}
        for i := 0 to (hstmt^.posqlda.sqld - 1) do begin
          ovar := @(hstmt^.posqlda.sqlvar[i]);
          dtype := ovar^.sqltype;
          { If we allocated IB datetime structures(ISC_QUAD),BLOB_IDS,ARRAY_IDS on
            the Bind.  We need to free them here}
          case dtype of
            SQL_DATE, SQL_DATE+1:
              FreeMem( ovar^.sqldata, sizeof( ISC_QUAD ) );
            SQL_BLOB,SQL_BLOB+1:
              FreeMem( ovar^.sqldata, sizeof( ISC_QUAD ) );
            SQL_VARYING,SQL_VARYING+1:
              FreeMem( ovar^.sqldata, (sizeof(Char)*(ovar^.sqllen+2)) );
          end;
          FreeMem( ovar^.sqlind, sizeof( word ) );
        end;
        DestroyLL(@(hstmt^.ODateHead));
        DestroyLL(@(hstmt^.OBlobHead));
        DestroyLL(@(hstmt^.OVarying));
        DestroyLL(@(hstmt^.OOthersHead));
      end;
      if (hstmt^.BoundInputs >0) then begin
        for i := 0 to (hstmt^.pisqlda.sqld  -1) do begin
          ivar := @(hstmt^.pisqlda.sqlvar[i]);
          dtype := ivar^.sqltype;
          case dtype of
            SQL_BLOB,SQL_DATE:  {If using blobs/dates as input we
                        allocated space for the blob_id/ibdate}
              FreeMem(ivar^.sqldata,sizeof(ISC_QUAD));
            SQL_VARYING,SQL_VARYING+1:
              FreeMem( ivar^.sqldata, (sizeof(Char)*(ivar^.sqllen+2)) );
          end;
          FreeMem( ivar^.sqlind, sizeof( word ) );
        end;
        DestroyLL(@(hstmt^.IDateHead));
        DestroyLL(@(hstmt^.IBlobHead));
        DestroyLL(@(hstmt^.IVarying));
        DestroyLL(@(hstmt^.IOthersHead));
      end;
      { Free the sqlda space that was alloc'd by SQLAllocStmt }
      FreeMem( hstmt^.posqlda, XSQLDA_LENGTH( hstmt^.posqlda.sqln ));
      FreeMem( hstmt^.pisqlda, XSQLDA_LENGTH( hstmt^.pisqlda.sqln ));
      FreeMem(hstmt,sizeof(IB_STMT));
    end;
    SQL_CLOSE: begin
      if (hstmt^.hdbc.OpenCursors > 0) and (hstmt^.HasCursor = 1) then
        Dec(hstmt^.hdbc.OpenCursors);
      isc_dsql_free_statement( @(hstmt^.status), @(hstmt^.st_handle), DSQL_close );
    end;
    SQL_RESET_PARAMS:
  end;
  SQLFreeStmt := retval;
end;

function  SQLBindCol( hstmt : HSTMT; ParamNum : UWORD;DataType:SWORD;PParam:Pointer;PNull:Pointer;BlobSize:PSDWORD) : RETCODE;export;
var
  retval : RETCODE;
  ret : isc_status;
  i,dtype: Integer;
  ovar,ivar: PXSQLVAR;
begin
  hstmt^.BoundOutputs := 1;
  ovar := @(hstmt^.posqlda.sqlvar[ParamNum-1]);
  case DataType of
    SQL_DATE,SQL_DATE+1: begin
      { Allocate space for an IB DATE datatype }
      ovar^.sqldata := AllocMem(sizeof(ISC_QUAD));
      { They gave us a pointer to a TM structure. We'll save this pointer so it can be used when we
        fetch records to put the IB DATE field into a TM structure }
      AddLL(@(hstmt^.ODateHead),ParamNum-1,PParam,PNull,nil,0);
    end;
    SQL_BLOB,SQL_BLOB+1: begin
      { Allocate space for an IB Blob_id datatype. i.e. You can't access blob data directly. You have to
        first get the blob_id and with that,  you can get segments.  See SQLFetch() }
      ovar^.sqldata := AllocMem(sizeof(ISC_QUAD));
      { They gave us a pointer. We'll save this pointer, so it can be used when we fetch records
        to put the BLOB field into this pointer.  I do a little something strange here.  When we call
        BindCol with a Blob datatype, I use the pointer given to me as the TotalSize variable within
        the call to AddLL.  This is fine. The strangeity comes in the fact that I use the contents of
        the BlobSize pointer(BlobSize^) as the segment size.  The segment size gets set once, i.e. only
        when you call BindCol }
        AddLL(@(hstmt^.OBlobHead),ParamNum-1,PParam,PNull,BlobSize,BlobSize^);
      end;
    SQL_VARYING,SQL_VARYING+1: begin
      { Allocate space for an IB VARYING datatype }
      ovar^.sqldata := AllocMem(sizeof(Char)*(ovar^.sqllen+sizeof(ovar^.sqllen)));
      AddLL(@(hstmt^.OVarying),ParamNum-1,PParam,PNull,nil,0);
    end else begin
       ovar^.sqldata := PParam;
       AddLL(@(hstmt^.OOthersHead),ParamNum-1,PParam,PNull,nil,0);
    end;
  end;
  { Allocate space for a NULL-indicator for this output variable }
  ovar^.sqlind := AllocMem( sizeof( word ) );
  SQLBindCol := SQL_SUCCESS;
end;

function  SQLBindParameter( hstmt: HSTMT; ParamNum: UWORD; DataType: SWORD; PParam: Pointer; PNull:Pointer;MaxLen:PSDWORD;Scale:SWORD) : RETCODE;export;
var
  retval : RETCODE;
  ret : isc_status;
  ivar: PXSQLVAR;
begin
  hstmt^.BoundInputs := 1;
  ivar := @(hstmt^.pisqlda.sqlvar[ParamNum-1]);
  case DataType of
    SQL_BLOB,SQL_BLOB+1: begin
      { Allocate space for an IB Blob_id datatype. i.e. You can't insert blob data directly. You have to
        first create the blob_id and with that, you can then put segments.  See SQLExecute()   }
      ivar^.sqldata := AllocMem(sizeof(ISC_QUAD));
      { They gave us a pointer. We'll save this pointer so it can be used when we run the SQLExecute }
      AddLL(@(hstmt^.IBlobHead),ParamNum-1,PParam,PNull,MaxLen,Scale);
    end;
    SQL_DATE,SQL_DATE+1: begin
      { Allocate space for an IB Date datatype. }
      ivar^.sqldata := AllocMem(sizeof(ISC_QUAD));
      { They gave us a pointer to the TM structure. We'll save this pointer, so it can be used when we
        run SQLExecute }
      AddLL(@(hstmt^.IDateHead),ParamNum-1,PParam,PNull,nil,0);
    end;
    SQL_VARYING,SQL_VARYING+1: begin
      { Allocate space for an IB VARYING datatype }
      ivar^.sqldata := AllocMem(sizeof(Char)*(ivar^.sqllen+sizeof(ivar^.sqllen)));
      AddLL(@(hstmt^.IVarying),ParamNum-1,PParam,PNull,nil,0);
    end else begin
      ivar^.sqldata := PParam;
      AddLL(@(hstmt^.IOthersHead),ParamNum-1,PParam,PNull,nil,0);
    end;
  end;
  { Allocate space for a NULL-indicator for this
    input variable.  (Not sure this is needed) }
  ivar^.sqlind := AllocMem( sizeof( word ) );
  SQLBindParameter := SQL_SUCCESS;
end;

function  SQLPrepare( hstmt :HSTMT;SqlStr :PChar;SqlStrLen :SDWORD) : RETCODE;export;
var
  teb : isc_teb;
  retval : RETCODE;
  ret : isc_status;
  i,dtype,SomeNum,len,HasInput: Integer;
  ovar,ivar: PXSQLVAR;
  TPtr : PChar;
begin
  retval := SQL_SUCCESS;
  { We're here to Prepare a stmt.  ODBC rules state that if a tx does not exist, we should start one.
    For now, we'll do this. }
  if (hstmt^.hdbc.tx_handle = nil) then begin
    teb.db_ptr := @(hstmt^.hdbc.db_handle);
    teb.tpb_len := 0;
    teb.tpb_ptr := nil;
    ret := isc_start_multiple( @(hstmt^.status), @(hstmt^.hdbc.tx_handle), 1, @teb);
  end;
  ret := isc_dsql_prepare(@(hstmt^.status), @(hstmt^.hdbc.tx_handle), @(hstmt^.st_handle), 0, SqlStr, 3, hstmt^.posqlda);
  if (ret <> 0 ) then begin
    retval := SQL_ERROR;
  end else begin
    hstmt^.IsPrepared := 1;
    { Determine if this is a "select" statement being prepared. If so, there will be a cursor associated
      with this and we need to track some info internally. }
    if (hstmt^.posqlda.sqld > 0) then begin
      hstmt^.HasCursor := 1;
      Inc(hstmt^.hdbc.OpenCursors);
    end;
    if (hstmt^.posqlda.sqld > hstmt^.posqlda.sqln) then begin
      SomeNum := hstmt^.posqlda.sqld;
      ReallocMem( hstmt^.posqlda, XSQLDA_LENGTH( SomeNum ));
      hstmt^.posqlda.sqln := SomeNum;
      hstmt^.posqlda.version := SQLDA_VERSION1;
      ret := isc_dsql_describe( @(hstmt^.status), @(hstmt^.st_handle), 3, hstmt^.posqlda);
      if (ret <> 0 ) then begin
        retval := SQL_ERROR;
        hstmt^.posqlda.sqld := 0;
      end;
    end;
    { Now we need to see if we have input parameters. Scan the string looking for a '?'. If we find one,
      we have input parameters.  This will mean we need to call describe_bind and figure out whether we have
      enough space allocated for the input sqlda }
    len := Length(SqlStr);
    TPtr := SqlStr;
    hstmt^.AnyInParams := 0;
    i:=0;
    while (i < len) and (hstmt^.AnyInParams = 0) do begin
      if (TPtr^ = Char('?')) then
        hstmt^.AnyInParams := 1;
      Inc(i);
      TPtr := SqlStr + i;
    end;
    if (hstmt^.AnyInParams = 1) then begin
      ret := isc_dsql_describe_bind( @(hstmt^.status), @(hstmt^.st_handle), 3, hstmt^.pisqlda);
      if (ret = 0 ) then begin
        if (hstmt^.pisqlda.sqld > hstmt^.pisqlda.sqln) then begin
          SomeNum := hstmt^.pisqlda.sqld;
          ReallocMem( hstmt^.pisqlda, XSQLDA_LENGTH( SomeNum ));
          hstmt^.pisqlda.sqln := SomeNum;
          hstmt^.pisqlda.version := SQLDA_VERSION1;
          ret := isc_dsql_describe_bind( @(hstmt^.status), @(hstmt^.st_handle), 3, hstmt^.pisqlda);
        end;
      end;
      if (ret <> 0 ) then
        retval := SQL_ERROR;
    end;
  end;
  SQLPrepare := retval;
end;

function  SQLExecute( hstmt :HSTMT) : RETCODE;export;
var
  teb : isc_teb;
  retval : RETCODE;
  ret : isc_status;
  i,dtype,SomeNum: Integer;
  ovar,ivar: PXSQLVAR;
  BlobIdPtr,TmpPtr : Pointer;
  bhndl : isc_blob_handle;
  SegLen : Short;
  LenSize,LenValue : Word;
  IbStatus : status_vector;
  TMDataPtr,VarPtr : PChar;
  AmountWritten,AmountLeft : Integer;
  BlobNode : PPtr;
  IsNullPtr : ^Boolean;
begin
  retval := SQL_SUCCESS;
  if (hstmt^.AnyInParams = 1) then begin
    for i := 0 to (hstmt^.pisqlda.sqld - 1) do begin
      ivar := @(hstmt^.pisqlda.sqlvar[i]);
      dtype := ivar^.sqltype;
      case dtype of
        SQL_BLOB, SQL_BLOB+1: begin
          { Blobs (at least for this code) can be INSERTED/UPDATED. This code checks to
            see if we are INSERTING a blob datatype If so, we need to create the blob ...
            and pass in the blob_id as part of the in_sqlda }
          IsNullPtr := IsNullSearchLL(hstmt^.IBlobHead,i);
          If IsNullPtr^ = True then
            ivar^.sqlind^ := SQL_NULL
          else begin
            ivar^.sqlind^ := 0;
            BlobIdPtr := ivar^.sqldata;
            BlobNode := BlobSearchLL(hstmt^.IBlobHead,i);
            bhndl := nil;
            ret := isc_create_blob( @(hstmt^.status), @(hstmt^.hdbc.db_handle), @(hstmt^.hdbc.tx_handle),@bhndl,BlobIdPtr);
            if (ret = 0) then begin
              { Should probably check for errors here. If error call isc_cancel_blob, I think }
              AmountWritten := 0;
              AmountLeft := BlobNode^.TotalSize^;
              while ((AmountWritten < BlobNode^.TotalSize^) and (ret = 0) ) do begin
                if (AmountLeft < BlobNode^.SegSize) then
                   ret := isc_put_segment( @(hstmt^.status), @bhndl,AmountLeft,PChar(BlobNode^.Ptr)+AmountWritten)
                else
                   ret := isc_put_segment( @(hstmt^.status), @bhndl,BlobNode^.SegSize,PChar(BlobNode^.Ptr)+AmountWritten);
                AmountWritten := AmountWritten + BlobNode^.SegSize;
                AmountLeft := AmountLeft - BlobNode^.SegSize;
              end;
              ret := isc_close_blob( @(hstmt^.status), @bhndl);
              if  (ret <> 0) then
                 ret := isc_cancel_blob( @IbStatus, @bhndl);
            end;
          end;
        end;
        SQL_DATE, SQL_DATE+1: begin
          IsNullPtr := IsNullSearchLL(hstmt^.IDateHead,i);
          if IsNullPtr^ = True then
            ivar^.sqlind^ := SQL_NULL
          else begin
            ivar^.sqlind^ := 0;
            TMDataPtr := SearchLL(hstmt^.IDateHead,i);
            IBTMToDate(ivar^.sqldata,TMDataPtr);
          end;
        end;
        SQL_VARYING, SQL_VARYING+1: begin
          IsNullPtr := IsNullSearchLL(hstmt^.IVarying,i);
          if IsNullPtr^ = True then
            ivar^.sqlind^ := SQL_NULL
          else begin
            ivar^.sqlind^ := 0;
            VarPtr := SearchLL(hstmt^.IVarying,i);
            LenSize := sizeof(ivar^.sqllen);
            LenValue := Length(VarPtr);
            Move(LenValue,ivar^.sqldata^,LenSize);
            Move(VarPtr^,(PChar(ivar^.sqldata)+LenSize)^,LenValue);
          end;
        end else begin
          IsNullPtr := IsNullSearchLL(hstmt^.IOthersHead,i);
          if IsNullPtr^ = True then
            ivar^.sqlind^ := SQL_NULL
          else
            ivar^.sqlind^ := 0;
        end;
      end;
    end;
  end;
  { We're here to Execute a stmt. The ODBC rules state that if a tx does not exist, we should start one }
  if (hstmt^.hdbc.tx_handle = nil) then begin
    teb.db_ptr := @(hstmt^.hdbc.db_handle);
    teb.tpb_len := 0;
    teb.tpb_ptr := nil;
    ret := isc_start_multiple( @(hstmt^.status), @(hstmt^.hdbc.tx_handle), 1, @teb);
  end;
  if( hstmt^.AnyInParams = 1 ) then
    ret := isc_dsql_execute( @(hstmt^.status), @(hstmt^.hdbc.tx_handle),@(hstmt^.st_handle), 3, hstmt^.pisqlda)
  else
    ret := isc_dsql_execute( @(hstmt^.status), @(hstmt^.hdbc.tx_handle),@(hstmt^.st_handle), 3, nil);
  hstmt^.IsPrepared := 0;
  if ( ret <> 0) then
     retval := SQL_ERROR
  else begin
    if (hstmt^.HasCursor = 1) then
      Inc(hstmt^.hdbc.OpenCursors);
  end;
  SQLExecute := retval;
end;

function  SQLFetch( hstmt :HSTMT) : RETCODE;export;
var
  teb : isc_teb;
  retval : RETCODE;
  ret : isc_status;
  i,dtype,j: Integer;
  ovar,ivar: PXSQLVAR;
  BlobIdPtr,TmpPtr,BlobDataPtr : Pointer;
  bhndl : isc_blob_handle;
  SegLen : Short;
  TPtr,VarPtr : PChar;
  RInteger : ^Integer;
  BInteger : ^Int64;
  SShort : ^Short;
  factor,BlobSize : LongInt;
  BlobNode : PPtr;
  LenSize,LenValue : Word;
  PtrBool : ^Boolean;
begin
  retval := SQL_SUCCESS;
  ret := isc_dsql_fetch( @(hstmt^.status), @(hstmt^.st_handle), 3, hstmt^.posqlda );
  if (ret <> 0) then begin
    if (ret = 100) then begin
      Dec(hstmt^.hdbc.OpenCursors);
      retval := 100;     { No more rows to fetch }
      { Maybe some autocommit shit here in the future }
    end else
      retval := SQL_ERROR;   { Error occurred on Fetch() }
  end else begin
    for i := 0 to (hstmt^.posqlda.sqld - 1) do begin
      ovar := @(hstmt^.posqlda.sqlvar[i]);
      dtype := ovar^.sqltype;
      if (ovar^.sqlind^ <> SQL_NULL) then { Is field null }  begin   { No. }
        case dtype of
          SQL_DATE, SQL_DATE+1: begin
            {Translate IB dates into TM_STRUCTS }
            IBDateToTM( ovar^.sqldata, SearchLL(hstmt^.ODateHead,i) );
            UpdateIsNullPtr(hstmt^.ODateHead,i,False);
          end;
          SQL_BLOB, SQL_BLOB+1: begin
            { We fetched the blob_id(ovar^.sqldata), now we need
             to get the blob data and copy it to the pointer
             given in SQLBindCol(hstmt^.OutBlobDataArr[i])}
            UpdateIsNullPtr(hstmt^.OBlobHead,i,False);
            BlobNode := BlobSearchLL(hstmt^.OBlobHead,i);
            BlobSize := IBBlobToPtr( hstmt,ovar^.sqldata, BlobNode^.Ptr,BlobNode^.SegSize);
            BlobNode^.TotalSize^ := BlobSize;
          end;
          SQL_TEXT,SQL_TEXT+1: begin
            UpdateIsNullPtr(hstmt^.OOthersHead,i,False);
            TPtr := PChar(ovar^.sqldata) + ovar^.sqllen;
            TPtr^ := Char(0);
          end;
          SQL_VARYING, SQL_VARYING+1: begin
            UpdateIsNullPtr(hstmt^.OVarying,i,False);
            VarPtr := SearchLL(hstmt^.OVarying,i);
            LenSize := sizeof(ovar^.sqllen);
            Move(ovar^.sqldata^,LenValue,LenSize);
            Move((PChar(ovar^.sqldata)+LenSize)^,VarPtr^,LenValue);
            (VarPtr + LenValue)^ := Char(0);
          end;
          SQL_LONG,SQL_LONG+1: begin
            UpdateIsNullPtr(hstmt^.OOthersHead,i,False);
            if (ovar^.sqlscale <> 0) then begin
              factor :=1;
              for j := 1 to -(ovar^.sqlscale) do
                factor := factor * 10;
              RInteger := ovar^.sqldata;
              RInteger^:= RInteger^ div factor;
            end
          end;
          SQL_INT64,SQL_INT64+1: begin
            UpdateIsNullPtr(hstmt^.OOthersHead,i,False);
            if (ovar^.sqlscale <> 0) then begin
              factor :=1;
              for j := 1 to -(ovar^.sqlscale) do
                factor := factor * 10;
              BInteger := ovar^.sqldata;
              BInteger^:= BInteger^ div factor;
            end
          end;
          SQL_SHORT,SQL_SHORT+1: begin
            UpdateIsNullPtr(hstmt^.OOthersHead,i,False);
            if (ovar^.sqlscale <> 0) then begin
              factor :=1;
              for j := 1 to -(ovar^.sqlscale) do
                factor := factor * 10;
              SShort := ovar^.sqldata;
              SShort^:= SShort^ div factor;
            end
          end;
         end;
       end else { It is null } begin
          case dtype of
            SQL_DATE, SQL_DATE+1:
              UpdateIsNullPtr(hstmt^.ODateHead,i,True);
            SQL_BLOB, SQL_BLOB+1:
              UpdateIsNullPtr(hstmt^.OBlobHead,i,True);
            SQL_VARYING, SQL_VARYING+1:
              UpdateIsNullPtr(hstmt^.OVarying,i,True);
            else
              UpdateIsNullPtr(hstmt^.OOthersHead,i,True);
          end;
       end;
     end;
   end;
   SQLFetch:= retval;
end;

procedure SQLError(hdbc : HDBC;hstmt :HSTMT; ErrorBuffer : PChar);export;
var
   sqlcode : Word;
   ErrorString : array[0..512] of Char;
   ret : isc_status;
   ErrorCode : ppstatus_vector;
begin
   { We don't know if there was an error with the associated with the statement handle or the db handle }
   if (hdbc^.status[1] <> SQL_SUCCESS) then
     ErrorCode := @(hdbc^.status)
   else
     if (hstmt^.status[1] <> 0) then
       ErrorCode := @(hstmt^.status);
   ret := isc_interprete( @ErrorString, @ErrorCode);
   while (ret <> 0) do
   begin
      StrCat(ErrorBuffer,'|');
      StrCat(ErrorBuffer,ErrorString);
      FillChar(ErrorString, SizeOf(ErrorString), Char(0));
      ret := isc_interprete( @ErrorString, @ErrorCode);
   end
end;

function  SQLGetCol( hstmt : HSTMT; ParamNum : UWORD; var DataType,DataLen:SWORD) : RETCODE;export;
var
  retval : RETCODE;
  ovar: PXSQLVAR;
  tablename,colname : array[0..31] of Char;
  BlobDesc  : BLOBDESCRIPTION;
  ret : isc_status;
begin
  retval := SQL_SUCCESS;
  if( (hstmt^.posqlda.sqld) > (ParamNum-1)) then
  begin
    ovar := @(hstmt^.posqlda.sqlvar[ParamNum-1]);
    DataType := ovar^.sqltype;
    if (DataType = SQL_BLOB) or (DataType = SQL_BLOB +1) then
    begin
      StrLCopy(colname,ovar^.sqlname,ovar^.sqlname_length);
      StrLCopy(tablename,ovar^.relname,ovar^.relname_length);
      ret := isc_blob_lookup_desc( @(hstmt^.status), @(hstmt^.hdbc.db_handle),@(hstmt^.hdbc.tx_handle),@(tablename), @(colname), @(BlobDesc),@(colname));
      if ret <> 0 then
         DataLen := 80
      else
         DataLen := BlobDesc.SegmentSize;
    end
    else
      DataLen := ovar^.sqllen;
  end else
    retval := 100;
  SQLGetCol := retval;
end;

function  SQLGetParam( hstmt : HSTMT; ParamNum : UWORD; var DataType,DataLen:SWORD) : RETCODE;export;
var
  retval : RETCODE;
  ivar: PXSQLVAR;
begin
  retval := SQL_SUCCESS;
  if( (ParamNum-1) < (hstmt^.pisqlda.sqld) ) then
  begin
    ivar := @(hstmt^.pisqlda.sqlvar[ParamNum-1]);
    DataType := ivar^.sqltype;
    DataLen := ivar^.sqllen;
  end else
    retval := 100;
  SQLGetParam := retval;
end;

exports
  SQLAllocConnect,
  SQLSetConnectOption,
  SQLDisconnect,
  SQLConnect,
  SQLTransact,
  SQLTransactMdb,
  SQLAllocStmt,
  SQLFreeStmt,
  SQLBindCol,
  SQLBindParameter,
  SQLPrepare,
  SQLExecute,
  SQLFetch,
  SQLError,
  SQLGetParam,
  SQLGetCol;
begin
end.
