unit IBAPI;

interface

uses SysUtils, Classes, Windows;
{$F+}

const
  MinCols  = 5;
  MaxDbs  = 100;

  SQL_SUCCESS = 0;
  SQL_AUTOCOMMIT = 102;
  SQL_ROLLBACK = 1;
  SQL_COMMIT = 0;
  SQL_BEGIN_TRANS = 2;
  SQL_ERROR = -1;
  SQL_AUTOCOMMIT_ON = 1;
  SQL_AUTOCOMMIT_OFF = 0;
  SQL_MAX_ROWS = 1;
  SQL_ASYNC_ENABLE = 4;
  SQL_INVALID_HANDLE = -2;
  SQL_DROP = 1;
  SQL_CLOSE = 0;
  SQL_RESET_PARAMS = 3;
  SQL_ACCESS_MODE = 101;
  SQL_MODE_READ_ONLY = 1;
  SQL_C_TIMESTAMP = 11;
  SQL_NULL = -1;

  isc_dpb_version1  = 1;
  isc_dpb_user_name = 28;
  isc_dpb_password  = 29;
  IBaseDLL = 'gds';
  SQLDA_VERSION1         = 1;
  SQLDA_VERSION2	       = 2; (*     V6.0 SQLDA *)
  SQL_DIALECT_V5	       = 1; (* meaning is same as DIALECT_xsqlda *)
  SQL_DIALECT_V6_TRANSITION    = 2; (* flagging anything that is delimited
                                       by double quotes as an error and
                                       flagging keyword DATE as an error *)
  SQL_DIALECT_V6	       = 3; (* supports SQL delimited identifier,
                                       SQLDATE/DATE, TIME, TIMESTAMP,
                                       CURRENT_DATE, CURRENT_TIME,
                                       CURRENT_TIMESTAMP, and 64-bit exact
                                       numeric type *)
  SQL_DIALECT_CURRENT	       = SQL_DIALECT_V6; (* latest IB DIALECT *)

  DSQL_drop = 2;
  DSQL_close = 1;
  isc_segstr_eof = 335544367;

  SQL_TEXT =       452;
  SQL_VARYING =    448;
  SQL_SHORT =      500;
  SQL_TIMESTAMP =  510;
  SQL_LONG =       496;
  SQL_FLOAT =      482;
  SQL_DOUBLE =     480;
  SQL_D_FLOAT =    530;
  SQL_BLOB =       520;
  SQL_ARRAY =      540;
  SQL_QUAD =       550;
  SQL_TYPE_TIME =  560;
  SQL_TYPE_DATE =  570;
  SQL_INT64 =      580;
  SQL_DATE =       SQL_TIMESTAMP;


  isc_deadlock =                  335544336;
  isc_io_error =                  335544344;
  isc_lock_conflict =             335544345;


type
  isc_db_handle = pointer;
  pisc_db_handle = ^isc_db_handle;
  isc_long = longint;
  pisc_long = ^isc_long;
  isc_status = longint;
  pisc_status = ^isc_status;
  isc_tr_handle = pointer;
  pisc_tr_handle = ^isc_tr_handle;
  isc_stmt_handle = pointer;
  pisc_stmt_handle = ^isc_stmt_handle;
  isc_blob_handle = pointer;
  pword = ^word;
  pisc_blob_handle = ^isc_blob_handle;

  status_vector = array[0..19] of isc_status;
  pstatus_vector = ^status_vector;
  ppstatus_vector = ^pstatus_vector;


  XSQLVAR = record
    sqltype: Smallint;                    {* datatype of field *}
    sqlscale: Smallint;                   {* scale factor *}
    sqlsubtype: Smallint;                 {* datatype subtype - BLOBs & Text *}
                                       {* types only *}
    sqllen: Smallint;                     {* length of data area *}
    sqldata: pointer;                    {* address of data *}
    sqlind: ^Smallint;                    {* address of indicator variable *}
    sqlname_length: Smallint;             {* length of sqlname field *}
    sqlname: array [0..31] of Char;    {* name of field, name length + *}
                                       {* space for NULL *}
    relname_length: Smallint;             {* length of relation name *}
    relname: array [0..31] of Char;    {* field's relation name + space *}
                                       {* for NULL *}
    ownname_length: Smallint;             {* length of owner name *}
    ownname: array [0..31] of Char;    {* relation's owner name + space *}
                                       {* for NULL *}
    aliasname_length: Smallint;           {* length of alias name *}
    aliasname: array [0..31] of Char;  {* relation's alias name + space *}
                                       {* for NULL *}
  end;
  PXSQLVAR = ^XSQLVAR;
  XSQLDA = record
    version: Smallint;                   {* version of this XSQLDA *}
    sqldaid: array [0..7] of Char;    {* XSQLDA name field *}
    sqldabc: isc_long;                {* length in bytes of SQLDA *}
    sqln: Smallint;                      {* number of fields allocated *}
    sqld: Smallint;                      {* actual number of fields *}
    sqlvar: array [0..0] of XSQLVAR;  {* first field address *}
  end;
  PXSQLDA = ^XSQLDA;

  BLOBDESCRIPTION = record
    SubType: Smallint;
    Charset: Smallint;
    SegmentSize: Smallint;
    ColumnName: array [0..31] of Char;
    TableName: array [0..31] of Char;
  end;
  PBLOBDESC = ^BLOBDESCRIPTION;

  TXSQLVar = record
  end;

  TXSQLDA = record
  end;
  PTXSQLDA = ^TXSQLDA;

  short = word;
  isc_teb = record
    db_ptr: pisc_db_handle;
    tpb_len: longint;
    tpb_ptr: pchar;
  end;
  pisc_teb = ^isc_teb;

isc_callback = procedure( ptr: pointer; length: word; updated: pchar);
ISC_QUAD = record
    isc_quad_high: ISC_LONG;
    isc_quad_low: ISC_LONG;
  end;

PISC_QUAD = ^ISC_QUAD;

ISC_ARRAY_BOUND = record
    array_bound_lower: Word;
    array_bound_upper: Word;
  end;

ISC_ARRAY_DESC = record
    array_desc_dtype: Byte;
    array_desc_scale: Shortint;
    array_desc_length: Byte;
    array_desc_field_name: array [0..31] of Char;
    array_desc_relation_name: array [0..31] of Char;
    array_desc_dimensions: Word;
    array_desc_flags: Word;
    array_desc_bounds: array [0..15] of ISC_ARRAY_BOUND;
  end;
PISC_ARRAY_DESC = ^ISC_ARRAY_DESC;
type
  Int                  = LongInt; { 32 bit signed }
  UInt                 = DWord;   { 32 bit unsigned }
  Long                 = LongInt; { 32 bit signed }
  ULong                = DWord;   { 32 bit unsigned }
  UShort               = Word;    { 16 bit unsigned }
  Float                = Single;  { 32 bit }
  UChar                = Byte;    { 8 bit unsigned }
  UISC_LONG            = ULong;   { 32 bit unsigned }
  ISC_INT64            = Int64;   { 64 bit signed  }
  UISC_STATUS          = ULong;   { 32 bit unsigned}
  Void                 = Pointer;
  { Delphi Pointer types }
  PPChar               = ^PChar;
  PSmallInt            = ^SmallInt;
  PInt                 = ^Int;
  PInteger             = ^Integer;
  PShort               = ^Short;
  PUShort              = ^UShort;
  PLong                = ^Long;
  PULong               = ^ULong;
  PFloat               = ^Float;
  PUChar               = ^UChar;
  PVoid                = ^Pointer;
  PDouble              = ^Double;
  PISC_INT64            = ^Int64;
  PUISC_LONG           = ^UISC_LONG;
  PPISC_STATUS         = ^PISC_STATUS;
  PUISC_STATUS         = ^UISC_STATUS;

TM = record
  sec     : Integer; { seconds (0-59) }
  min     : Integer; { minutes (0-59) }
  hour    : Integer; { hour (0-23) }
  mday    : Integer; { day of month (1-31) }
  mon     : Integer; { month of year (0-11) }
  year    : Integer; { year (year - 1900 ) }
  wday    : Integer; { day of week (0-6  Sunday=0)}
  yday    : Integer; { day of year (0-364) }
  isdst   : Integer; { daylight savings in effect (1 = True) }
end;
IB_QUAD_PTR = ^ISC_QUAD;

PTM = ^TM;

DATETIME = record
    IbDateTime: ISC_QUAD;
    TimeDate: PTM;
end;

const
  TIME_SECONDS_PRECISION       = 10000;
  TIME_SECONDS_PRECISION_SCALE = -4;

type
  ISC_DATE = Long;
  PISC_DATE = ^ISC_DATE;
  ISC_TIME = ULong;
  PISC_TIME = ^ISC_TIME;
  TISC_TIMESTAMP = record
    timestamp_date: ISC_DATE;
    timestamp_time: ISC_TIME;
  end;
  PISC_TIMESTAMP = ^TISC_TIMESTAMP;

ODBC = record
    db_handle : isc_db_handle;
    status    : status_vector;
    tx_handle : isc_tr_handle;
    autocommit_flag : Short;
    OpenCursors : Short;
end;
PODBC = ^ODBC;
SWORD = Short;
SDWORD = LongInt;
HDBC = PODBC;
HENV  = pointer;
RETCODE = SmallInt;
UWORD = Byte;
UDWORD = Word;
PTR = pointer;
PHDBC = ^HDBC;
PSDWORD = ^SDWORD;
HDBCARR = array[0..MaxDbs] of PHDBC;

PPtr = ^PtrNode;

PtrNode = record     { A linked list of pointers }
   Index : Integer;
   SegSize  : Integer;
   TotalSize  : PSDWORD;
   Ptr   : Pointer;
   NullPtr : ^Boolean;
   Link  : PPtr;
end;
PPPtr = ^PPtr;

IB_STMT = record
    st_handle : isc_stmt_handle;
    status    : status_vector;
    hdbc : HDBC;
    IsPrepared : Short;
    BoundInputs : Short;
    BoundOutputs : Short;
    AnyInParams : Short;
    HasCursor: Short;
    posqlda : PXSQLDA;
    pisqlda : PXSQLDA;
    IBlobHead : PPtr;
    OBlobHead : PPtr;
    IDateHead : PPtr;
    ODateHead : PPtr;
    IVarying  : PPtr;
    OVarying  : PPtr;
    IArrHead  : PPtr;
    OArrHead  : PPtr;
    IOthersHead : PPtr;
    OOthersHead : PPtr;
end;
PIB_STMT = ^IB_STMT;
HSTMT = PIB_STMT;
PHSTMT = ^HSTMT;



{32-bit Definitions for interbase .dll i.e. gds32.dll }
function isc_array_get_slice( status: pstatus_vector;
  db_handle: pisc_db_handle;
  trans_handle: pisc_tr_handle;
  array_id: PISC_QUAD;
  desc: PISC_ARRAY_DESC;
  dest_array: Pointer;
  slice_length: PISC_LONG): isc_status; stdcall;

function isc_array_lookup_bounds(status: pstatus_vector;
  db_handle: pisc_db_handle;
  trans_handle: pisc_tr_handle;
  table_name: PChar;
  column_name: PChar;
  desc: PISC_ARRAY_DESC): isc_status; stdcall;

function isc_array_lookup_desc(status: pstatus_vector;
  db_handle: pisc_db_handle;
  trans_handle: pisc_tr_handle;
  table_name: PChar;
  column_name: PChar;
  desc: PISC_ARRAY_DESC): isc_status; stdcall;

function isc_array_put_slice( status: pstatus_vector;
  db_handle: pisc_db_handle;
  trans_handle: pisc_tr_handle;
  array_id: PISC_QUAD;
  desc: PISC_ARRAY_DESC;
  source_array: Pointer;
  slice_length: PISC_LONG): isc_status; stdcall;

function isc_attach_database(
  status: pstatus_vector;
  db_name_length: short;
  db_name: pchar;
  db_handle: pisc_db_handle;
  parm_buffer_length: short;
  parm_buffer: pchar
  ): isc_status; stdcall;

function isc_blob_lookup_desc(
  status: pstatus_vector;
  db_handle: pisc_db_handle;
  trans_handle: pisc_tr_handle;
  tablename: pchar;
  colname: pchar;
  blobdesc: PBLOBDESC;
  global: pchar
  ): isc_status; stdcall;

function isc_cancel_events(
  status: pstatus_vector;
  db_handle: pisc_db_handle;
  event_id: pisc_long
  ): isc_status; stdcall;

function isc_cancel_blob(
  status: pstatus_vector;
  db_handle: pisc_blob_handle
  ): isc_status; stdcall;

function isc_close_blob(
  status: pstatus_vector;
  db_handle: pisc_blob_handle
  ): isc_status; stdcall;

function isc_commit_retaining(
  status: pstatus_vector;
  trans_handle: pisc_tr_handle
  ): isc_status; stdcall;

function isc_commit_transaction(
  status: pstatus_vector;
  trans_handle: pisc_tr_handle
  ): isc_status; stdcall;

function isc_create_blob(
  status: pstatus_vector;
  db_handle: pisc_db_handle;
  trans_handle: pisc_tr_handle;
  b_handle: pisc_blob_handle;
  pblobid : PISC_QUAD
  ): isc_status; stdcall;

function isc_detach_database(
  status: pstatus_vector;
  db_handle: pisc_db_handle
  ): isc_status; stdcall;

procedure isc_decode_date(
  quad_ptr: PISC_QUAD;
  tm_ptr: PTM
  ); stdcall;

// From here added by AM
procedure isc_decode_sql_date(
  ib_date: PISC_DATE;
  tm_date: PTM
  ); stdcall;

procedure isc_decode_sql_time(
  ib_time: PISC_TIME;
  tm_date: PTM
  ); stdcall;

procedure isc_decode_timestamp(
  ib_timestamp: PISC_TIMESTAMP;
  tm_date: PTM
  ); stdcall;
  // to here

function isc_drop_database(
  status: pstatus_vector;
  db_handle: pisc_db_handle
  ): isc_status; stdcall;

function isc_dsql_allocate_statement(
  status : pstatus_vector;
  db_handle: pisc_db_handle;
  stmt_handle: pisc_stmt_handle ): isc_status; stdcall;

function isc_dsql_describe_bind(
  status: pstatus_vector;
  stmt_handle: pisc_stmt_handle;
  dialect: Word;
  xsqlda: PXSQLDA ): isc_status; stdcall;

function isc_dsql_describe(
  status: pstatus_vector;
  stmt_handle: pisc_stmt_handle;
  dialect: Word;
  xsqlda: PXSQLDA ): isc_status; stdcall;

function isc_dsql_execute(
  status: pstatus_vector;
  trans_handle: pisc_tr_handle;
  stmt_handle: pisc_stmt_handle;
  dialect: Word;
  xsqlda: PXSQLDA ): isc_status; stdcall;

  function isc_dsql_fetch(
  status: pstatus_vector;
  stmt_handle: pisc_stmt_handle;
  dialect: Word;
  xsqlda: PXSQLDA ): isc_status; stdcall;

function isc_dsql_free_statement(
  status: pstatus_vector;
  stmt_handle: pisc_stmt_handle;
  option: Word ): isc_status; stdcall;

function isc_dsql_prepare(
  status: pstatus_vector;
  trans_handle: pisc_tr_handle;
  stmt_handle: pisc_stmt_handle;
  length: Word;
  statement: PChar;
  dialect: Word;
  xsqlda: PXSQLDA): isc_status; stdcall;

function isc_dsql_execute_immediate(
  status: pstatus_vector;
  db_handle: pisc_db_handle;
  trans_handle: pisc_tr_handle;
  length: short;
  statement: PChar;
  dialect: short;
  xslqda: pointer
  ): isc_status; stdcall;

procedure isc_encode_date(
  tm_ptr: PTM;
  quad_ptr: IB_QUAD_PTR
  ); stdcall;

// From here added by AM
procedure isc_encode_sql_date(
  tm_date: PTM;
  ib_date: PISC_DATE
  ); stdcall;

procedure isc_encode_sql_time(
  tm_date: PTM;
	ib_time: PISC_TIME
  ); stdcall;

procedure isc_encode_timestamp(
  tm_date: PTM;
  ib_timestamp: PISC_TIMESTAMP
  ); stdcall;
// to here

function isc_event_block_asm: longint; stdcall;

procedure isc_event_counts(
  status: pstatus_vector;
  buffer_length: word;
  event_buffer: pchar;
  result_buffer: pchar
  ); stdcall;

function isc_free(
  buffer: PChar
  ): isc_long; stdcall;

function isc_get_segment(
  status: pstatus_vector;
  b_handle: pisc_blob_handle;
  pseglen : pword;
  segsize : word;
  buffer : pointer
  ): isc_status; stdcall;

function isc_interprete(
  buffer: PChar;
  status: ppstatus_vector
  ): isc_status; stdcall;

function isc_open_blob2(
  status: pstatus_vector;
  db_handle: pisc_db_handle;
  trans_handle: pisc_tr_handle;
  b_handle: pisc_blob_handle;
  pblobid : PISC_QUAD;
  bpblength : word;
  pbpb : pointer
  ): isc_status; stdcall;

function isc_put_segment(
  status: pstatus_vector;
  b_handle: pisc_blob_handle;
  segsize : word;
  buffer : pointer
  ): isc_status; stdcall;

function isc_que_events(
  status: pstatus_vector;
  db_handle: pisc_db_handle;
  event_id: pisc_long;
  length: word;
  event_buffer: pchar;
  event_function: isc_callback;
  event_function_arg: pointer
  ): isc_status; stdcall;

function isc_rollback_transaction(
  status: pstatus_vector;
  trans_handle: pisc_tr_handle
  ): isc_status; stdcall;

function isc_sqlcode(
  status: pstatus_vector
  ): word; stdcall;

procedure isc_sql_interprete(
  sqlcode: Longint;
  buffer: PChar;
  buffer_length: short
  ); stdcall;

function isc_start_multiple(
  status: pstatus_vector;
  trans_handle: pisc_tr_handle;
  db_handle_count: short;
  teb_vector_address: pisc_teb
  ): isc_status; stdcall;

function isc_start_transaction(
  status: pstatus_vector;
  trans_handle: pisc_tr_handle;
  db_handle_count: word;
  db_handle: pisc_db_handle;
  tpb_length: word;
  tpb_addr: pchar
  ): isc_status; stdcall;

function XSQLDA_LENGTH(n: word): Longint;

implementation

function XSQLDA_LENGTH(n: word): Longint;
begin
  XSQLDA_LENGTH := (SizeOf(XSQLDA) + (n - 1) * SizeOf(XSQLVAR));
end;
function isc_array_get_slice;
  external 'GDS32.DLL' name 'isc_array_get_slice';

function isc_array_lookup_bounds;
  external 'GDS32.DLL' name 'isc_array_lookup_bounds';

function isc_array_lookup_desc;
  external 'GDS32.DLL' name 'isc_array_lookup_desc';

function isc_array_put_slice;
  external 'GDS32.DLL' name 'isc_array_put_slice';

function isc_attach_database;
  external 'GDS32.DLL' name 'isc_attach_database';

function isc_blob_lookup_desc;
  external 'GDS32.DLL' name 'isc_blob_lookup_desc';

function isc_cancel_events;
  external 'GDS32.DLL' name 'isc_cancel_events';

function isc_close_blob;
  external 'GDS32.DLL' name 'isc_close_blob';

function isc_cancel_blob;
  external 'GDS32.DLL' name 'isc_close_blob';

function isc_commit_retaining;
  external 'GDS32.DLL' name 'isc_commit_retaining';

function isc_commit_transaction;
  external 'GDS32.DLL' name 'isc_commit_transaction';

function isc_create_blob;
  external 'GDS32.DLL' name 'isc_create_blob';

function isc_detach_database;
  external 'GDS32.DLL' name 'isc_detach_database';

procedure isc_decode_date;
  external 'GDS32.DLL' name 'isc_decode_date';

procedure isc_decode_sql_date;
  external 'GDS32.DLL' name 'isc_decode_sql_date';

procedure isc_decode_sql_time;
  external 'GDS32.DLL' name 'isc_decode_sql_time';

procedure isc_decode_timestamp;
  external 'GDS32.DLL' name 'isc_decode_timestamp';

function isc_dsql_execute_immediate;
  external 'GDS32.DLL' name 'isc_dsql_execute_immediate';

function isc_drop_database;
  external 'GDS32.DLL' name 'isc_drop_database';

function isc_sqlcode;
  external 'GDS32.DLL' name 'isc_sqlcode';

function isc_dsql_allocate_statement;
  external 'GDS32.DLL' name 'isc_dsql_allocate_statement';

function isc_dsql_describe;
  external 'GDS32.DLL' name 'isc_dsql_describe';

function isc_dsql_describe_bind;
  external 'GDS32.DLL' name 'isc_dsql_describe_bind';

function isc_dsql_execute;
  external 'GDS32.DLL' name 'isc_dsql_execute';

function isc_dsql_fetch;
  external 'GDS32.DLL' name 'isc_dsql_fetch';

function isc_dsql_free_statement;
  external 'GDS32.DLL' name 'isc_dsql_free_statement';

function isc_dsql_prepare;
  external 'GDS32.DLL' name 'isc_dsql_prepare';

procedure isc_encode_date;
  external 'GDS32.DLL' name 'isc_encode_date';

procedure isc_encode_sql_date;
  external 'GDS32.DLL' name 'isc_encode_sql_date';

procedure isc_encode_sql_time;
  external 'GDS32.DLL' name 'isc_encode_sql_time';

procedure isc_encode_timestamp;
  external 'GDS32.DLL' name 'isc_encode_timestamp';

function isc_event_block_asm;
  external 'GDS32.DLL' name 'isc_event_block_asm';

function isc_que_events;
  external 'GDS32.DLL' name 'isc_event_block_asm';

function isc_open_blob2;
  external 'GDS32.DLL' name 'isc_open_blob2';

procedure isc_event_counts;
  external 'GDS32.DLL' name 'isc_event_counts';

function isc_free;
  external 'GDS32.DLL' name 'isc_free';

function isc_get_segment;
  external 'GDS32.DLL' name 'isc_get_segment';

procedure isc_sql_interprete;
  external 'GDS32.DLL' name 'isc_sql_interprete';

function isc_interprete;
  external 'GDS32.DLL' name 'isc_interprete';

function isc_put_segment;
  external 'GDS32.DLL' name 'isc_put_segment';

function isc_rollback_transaction;
  external 'GDS32.DLL' name 'isc_rollback_transaction';

function isc_start_multiple;
  external 'GDS32.DLL' name 'isc_start_multiple';

function isc_start_transaction;
  external 'GDS32.DLL' name 'isc_start_transaction';

end.
