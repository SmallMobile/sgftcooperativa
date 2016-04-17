unit ibdbapi;

interface

uses ibapi;

{$F+}

const
     NumTables = 30;
     FieldWidth = 32;
     NumCols = 9;

function  SQLAllocConnect( hdbc : PHDBC) : RETCODE;
function  SQLSetConnectOption( hdbc : HDBC;foption : UWORD;vparam: UDWORD) : RETCODE;
function  SQLDisconnect( hdbc : PHDBC) : RETCODE;
function  SQLConnect( hdbc : HDBC;DatabaseName, UserName, Password : PChar) : RETCODE;
function  SQLTransact( hdbc : HDBC; TxOption : UWORD) : RETCODE;
function  SQLTransactMdb( hdbcArr : array of PHDBC;TxOption : UWORD;DbCount:Integer) : RETCODE;
function  SQLAllocStmt( hdbc : HDBC; hstmt :PHSTMT) : RETCODE;
function  SQLFreeStmt( hstmt :HSTMT;foption :UWORD) : RETCODE;
function  SQLBindCol( hstmt : HSTMT; ParamNum : UWORD;DataType:SWORD;PParam:Pointer;PNull:Pointer;BlobSize : PSDWORD) : RETCODE;
function  SQLBindParameter( hstmt : HSTMT; ParamNum : UWORD;DataType:SWORD;PParam:Pointer;PNull:Pointer;MaxLen:PSDWORD;Scale:SWORD) : RETCODE;
function  SQLPrepare( hstmt :HSTMT;SqlStr :PChar;SqlStrLen :SDWORD) : RETCODE;
function  SQLExecute( hstmt :HSTMT) : RETCODE;
function  SQLFetch( hstmt :HSTMT) : RETCODE;
procedure SQLError(hdbc : HDBC;hstmt :HSTMT; ErrorBuffer : PChar);
function  SQLGetParam( hstmt : HSTMT; ParamNum : UWORD; var DataType,DataLen:SWORD) : RETCODE;
function  SQLGetCol( hstmt : HSTMT; ParamNum : UWORD; var DataType,DataLen:SWORD) : RETCODE;

implementation
function  SQLAllocConnect;
  external 'IBDC.DLL' name 'SQLAllocConnect';
function  SQLSetConnectOption;
  external 'IBDC.DLL' name 'SQLSetConnectOption';
function  SQLDisconnect;
  external 'IBDC.DLL' name 'SQLDisconnect';
function  SQLConnect;
  external 'IBDC.DLL' name 'SQLConnect';
function  SQLTransact;
  external 'IBDC.DLL' name 'SQLTransact';
function  SQLTransactMdb;
  external 'IBDC.DLL' name 'SQLTransactMdb';
function  SQLAllocStmt;
  external 'IBDC.DLL' name 'SQLAllocStmt';
function  SQLFreeStmt;
  external 'IBDC.DLL' name 'SQLFreeStmt';
function  SQLBindCol;
  external 'IBDC.DLL' name 'SQLBindCol';
function  SQLBindParameter;
  external 'IBDC.DLL' name 'SQLBindParameter';
function  SQLPrepare;
  external 'IBDC.DLL' name 'SQLPrepare';
function  SQLExecute;
  external 'IBDC.DLL' name 'SQLExecute';
function  SQLFetch;
  external 'IBDC.DLL' name 'SQLFetch';
procedure SQLError;
  external 'IBDC.DLL' name 'SQLError';
function  SQLGetParam;
  external 'IBDC.DLL' name 'SQLGetParam';
function  SQLGetCol;
  external 'IBDC.DLL' name 'SQLGetCol';
end.
