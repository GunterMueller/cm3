(*******************************************************************************
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.3
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
*******************************************************************************)

INTERFACE MySQL;

IMPORT Ctypes AS C;


CONST
  NOT_NULL_FLAG         = 1;
  PRI_KEY_FLAG          = 2;
  UNIQUE_KEY_FLAG       = 4;
  MULTIPLE_KEY_FLAG     = 8;
  BLOB_FLAG             = 16;
  UNSIGNED_FLAG         = 32;
  ZEROFILL_FLAG         = 64;
  BINARY_FLAG           = 128;
  ENUM_FLAG             = 256;
  AUTO_INCREMENT_FLAG   = 512;
  TIMESTAMP_FLAG        = 1024;
  SET_FLAG              = 2048;
  NO_DEFAULT_VALUE_FLAG = 4096;
  NUM_FLAG              = 32768;

TYPE                             (* Enum MySQLOption *)
  MySQLOption =
    {MYSQL_OPT_CONNECT_TIMEOUT, MYSQL_OPT_COMPRESS, MYSQL_OPT_NAMED_PIPE,
     MYSQL_INIT_COMMAND, MYSQL_READ_DEFAULT_FILE, MYSQL_READ_DEFAULT_GROUP,
     MYSQL_SET_CHARSET_DIR, MYSQL_SET_CHARSET_NAME, MYSQL_OPT_LOCAL_INFILE,
     MYSQL_OPT_PROTOCOL, MYSQL_SHARED_MEMORY_BASE_NAME,
     MYSQL_OPT_READ_TIMEOUT, MYSQL_OPT_WRITE_TIMEOUT, MYSQL_OPT_USE_RESULT,
     MYSQL_OPT_USE_REMOTE_CONNECTION, MYSQL_OPT_USE_EMBEDDED_CONNECTION,
     MYSQL_OPT_GUESS_CONNECTION, MYSQL_SET_CLIENT_IP, MYSQL_SECURE_AUTH,
     MYSQL_REPORT_DATA_TRUNCATION, MYSQL_OPT_RECONNECT};

TYPE                             (* Enum MySQLStatus *)
  MySQLStatus =
    {MYSQL_STATUS_READY, MYSQL_STATUS_GET_RESULT, MYSQL_STATUS_USE_RESULT};

TYPE                             (* Enum MySQLProtocolType *)
  MySQLProtocolType =
    {MYSQL_PROTOCOL_DEFAULT, MYSQL_PROTOCOL_TCP, MYSQL_PROTOCOL_SOCKET,
     MYSQL_PROTOCOL_PIPE, MYSQL_PROTOCOL_MEMORY};

CONST                            (* Enum MySQLStmtState *)
  MYSQL_STMT_INIT_DONE    = 1;
  MYSQL_STMT_PREPARE_DONE = 2;
  MYSQL_STMT_EXECUTE_DONE = 3;
  MYSQL_STMT_FETCH_DONE   = 4;

TYPE                             (* Enum MySQLStmtState *)
  MySQLStmtState = [1 .. 4];

TYPE                             (* Enum MySQLStmtAttrType *)
  MySQLStmtAttrType = {STMT_ATTR_UPDATE_MAX_LENGTH, STMT_ATTR_CURSOR_TYPE,
                       STMT_ATTR_PREFETCH_ROWS};

CONST                            (* Enum MySQLFieldTypes *)
  MYSQL_TYPE_DECIMAL     = 0;
  MYSQL_TYPE_TINY        = 1;
  MYSQL_TYPE_SHORT       = 2;
  MYSQL_TYPE_LONG        = 3;
  MYSQL_TYPE_FLOAT       = 4;
  MYSQL_TYPE_DOUBLE      = 5;
  MYSQL_TYPE_NULL        = 6;
  MYSQL_TYPE_TIMESTAMP   = 7;
  MYSQL_TYPE_LONGLONG    = 8;
  MYSQL_TYPE_INT24       = 9;
  MYSQL_TYPE_DATE        = 10;
  MYSQL_TYPE_TIME        = 11;
  MYSQL_TYPE_DATETIME    = 12;
  MYSQL_TYPE_YEAR        = 13;
  MYSQL_TYPE_NEWDATE     = 14;
  MYSQL_TYPE_VARCHAR     = 15;
  MYSQL_TYPE_BIT         = 16;
  MYSQL_TYPE_NEWDECIMAL  = 246;
  MYSQL_TYPE_ENUM        = 247;
  MYSQL_TYPE_SET         = 248;
  MYSQL_TYPE_TINY_BLOB   = 249;
  MYSQL_TYPE_MEDIUM_BLOB = 250;
  MYSQL_TYPE_LONG_BLOB   = 251;
  MYSQL_TYPE_BLOB        = 252;
  MYSQL_TYPE_VAR_STRING  = 253;
  MYSQL_TYPE_STRING      = 254;
  MYSQL_TYPE_GEOMETRY    = 255;

TYPE                             (* Enum MySQLFieldTypes *)
  MySQLFieldTypes = [0 .. 255];

CONST

  CLIENT_NET_READ_TIMEOUT  = 365 * 24 * 3600;
  CLIENT_NET_WRITE_TIMEOUT = 365 * 24 * 3600;

  (* status return codes *)
  MYSQL_NO_DATA        = 100;
  MYSQL_DATA_TRUNCATED = 101;

TYPE
  InitCBT = PROCEDURE (p1: REF ADDRESS; p2: TEXT; p3: ADDRESS): INTEGER;
  ReadCBT = PROCEDURE (p1: ADDRESS; p2: TEXT; p3: CARDINAL): INTEGER;
  ErrorCBT = PROCEDURE (p1: ADDRESS; p2: TEXT; p3: CARDINAL): INTEGER;
  EndCBT = PROCEDURE (p1: ADDRESS);
  ExtendCBT = PROCEDURE (p1: ADDRESS; p2: TEXT; p3: REF LONGINT): TEXT;



TYPE
  T <: ADDRESS;                  (* connection handle *)

  ResultT <: ADDRESS;            (* result handle *)
  StmtT <: ADDRESS;              (* statement handle *)
  RowOffsetT <: ADDRESS;
  FieldT <: ADDRESS;
  ParametersT <: ADDRESS;
  BindT <: ADDRESS;
  CharsT <: ADDRESS;

CONST
  MAX_COLUMNS = 1000;            (* Arbitrary limit to how many cols
                                    returned in a query *)

EXCEPTION ConnE;
EXCEPTION ResultE;
EXCEPTION ReturnE(INTEGER);

TYPE RefLengthsT = UNTRACED REF ARRAY [0 .. MAX_COLUMNS] OF INTEGER;

PROCEDURE ServerInit
  (argc: INTEGER; READONLY argv, groups: ARRAY OF TEXT; ): INTEGER
  RAISES {ReturnE};

PROCEDURE ServerEnd ();

PROCEDURE GetParameters (): ParametersT;

PROCEDURE ThreadInit (): BOOLEAN;

PROCEDURE ThreadEnd ();

PROCEDURE NumRows (res: ResultT; ): LONGINT;

PROCEDURE NumFields (res: ResultT; ): CARDINAL;

PROCEDURE Eof (res: ResultT; ): BOOLEAN;

PROCEDURE FetchFieldDirect (res: ResultT; fieldnr: CARDINAL; ): FieldT;

PROCEDURE FetchFields (res: ResultT; ): FieldT;

PROCEDURE RowTell (res: ResultT; ): RowOffsetT;

PROCEDURE FieldTell (res: ResultT; ): CARDINAL;

PROCEDURE FieldCount (mysql: T; ): CARDINAL;

PROCEDURE AffectedRows (mysql: T; ): LONGINT;

PROCEDURE InsertId (mysql: T; ): LONGINT;

PROCEDURE Errno (mysql: T; ): CARDINAL;

PROCEDURE Error (mysql: T; ): TEXT;

PROCEDURE Sqlstate (mysql: T; ): TEXT;

PROCEDURE WarningCount (mysql: T; ): CARDINAL;

PROCEDURE Info (mysql: T; ): TEXT;

PROCEDURE ThreadId (mysql: T; ): CARDINAL;

PROCEDURE CharacterSetName (mysql: T; ): TEXT;

PROCEDURE SetCharacterSet (mysql: T; csname: TEXT; ): INTEGER
  RAISES {ReturnE};

PROCEDURE Init (mysql: T; ): T RAISES {ConnE};

PROCEDURE SslSet (mysql: T; key, cert, ca, capath, cipher: TEXT; ):
  BOOLEAN;

PROCEDURE ChangeUser (mysql: T; user, passwd, db: TEXT; ): BOOLEAN;

PROCEDURE RealConnect (mysql                 : T;
                       host, user, passwd, db: TEXT;
                       port                  : CARDINAL;
                       unix_socket           : TEXT;
                       clientflag            : CARDINAL; ): T
  RAISES {ConnE};

PROCEDURE SelectDb (mysql: T; db: TEXT; ): INTEGER RAISES {ReturnE};

PROCEDURE Query (mysql: T; q: TEXT; ): INTEGER RAISES {ReturnE};

PROCEDURE SendQuery (mysql: T; q: TEXT; length: CARDINAL; ): INTEGER
  RAISES {ReturnE};

PROCEDURE RealQuery (mysql: T; q: TEXT; length: CARDINAL; ): INTEGER
  RAISES {ReturnE};

PROCEDURE StoreResult (mysql: T; ): ResultT RAISES {ResultE};

PROCEDURE UseResult (mysql: T; ): ResultT RAISES {ResultE};

PROCEDURE GetCharacterSetInfo (mysql: T; VAR charset: CharsT; );

PROCEDURE SetLocalInfileHandler (    mysql             : T;
                                     local_infile_init : InitCBT;
                                     local_infile_read : ReadCBT;
                                     local_infile_end  : EndCBT;
                                     local_infile_error: ErrorCBT;
                                 VAR userdata          : REFANY;   );

PROCEDURE SetLocalInfileDefault (mysql: T; );

PROCEDURE Shutdown (mysql: T; shutdown_level: INTEGER; ): INTEGER
  RAISES {ReturnE};

PROCEDURE DumpDebugInfo (mysql: T; ): INTEGER RAISES {ReturnE};

PROCEDURE Refresh (mysql: T; refresh_options: CARDINAL; ): INTEGER
  RAISES {ReturnE};

PROCEDURE Kill (mysql: T; pid: CARDINAL; ): INTEGER RAISES {ReturnE};

PROCEDURE SetServerOption (mysql: T; option: INTEGER; ): INTEGER
  RAISES {ReturnE};

PROCEDURE Ping (mysql: T; ): INTEGER RAISES {ReturnE};

PROCEDURE Stat (mysql: T; ): TEXT;

PROCEDURE GetServerInfo (mysql: T; ): TEXT;

PROCEDURE GetClientInfo (): TEXT;

PROCEDURE GetClientVersion (): CARDINAL;

PROCEDURE GetHostInfo (mysql: T; ): TEXT;

PROCEDURE GetServerVersion (mysql: T; ): CARDINAL;

PROCEDURE GetProtoInfo (mysql: T; ): CARDINAL;

PROCEDURE ListDbs (mysql: T; wild: TEXT; ): ResultT RAISES {ResultE};

PROCEDURE ListTables (mysql: T; wild: TEXT; ): ResultT RAISES {ResultE};

PROCEDURE ListProcesses (mysql: T; ): ResultT RAISES {ResultE};

PROCEDURE Options (mysql: T; option: INTEGER; arg: TEXT; ): INTEGER
  RAISES {ReturnE};

PROCEDURE FreeResult (res: ResultT; );

PROCEDURE DataSeek (res: ResultT; offset: LONGINT; );

PROCEDURE RowSeek (res: ResultT; offset: RowOffsetT; ): RowOffsetT;

PROCEDURE FieldSeek (res: ResultT; offset: CARDINAL; ): CARDINAL;

PROCEDURE FetchRow (res: ResultT; ): REF ARRAY OF TEXT;

PROCEDURE FetchLengths (res: ResultT; ): RefLengthsT;

PROCEDURE FetchField (res: ResultT; ): FieldT;

PROCEDURE ListFields (mysql: T; table, wild: TEXT; ): ResultT
  RAISES {ResultE};

PROCEDURE HexString (to, from: TEXT; from_length: CARDINAL; ): CARDINAL;

PROCEDURE RealEscapeString (mysql: T; to, from: TEXT; length: CARDINAL; ):
  CARDINAL;

PROCEDURE Debug (debug: TEXT; );

PROCEDURE RemoveEscape (mysql: T; name: TEXT; );

PROCEDURE ThreadSafe (): CARDINAL;

PROCEDURE Embedded (): BOOLEAN;

PROCEDURE ReadQueryResult (mysql: T; ): BOOLEAN;

PROCEDURE StmtInit (mysql: T; ): StmtT RAISES {ResultE};

PROCEDURE StmtPrepare (stmt: StmtT; query: TEXT; length: CARDINAL; ):
  INTEGER RAISES {ReturnE};

PROCEDURE StmtExecute (stmt: StmtT; ): INTEGER RAISES {ReturnE};

PROCEDURE StmtFetch (stmt: StmtT; ): INTEGER RAISES {ReturnE};

PROCEDURE StmtFetchColumn
  (stmt: StmtT; bind: BindT; column, offset: CARDINAL; ): INTEGER
  RAISES {ReturnE};

PROCEDURE StmtStoreResult (stmt: StmtT; ): INTEGER RAISES {ReturnE};

PROCEDURE StmtParamCount (stmt: StmtT; ): CARDINAL;

PROCEDURE StmtAttrSet
  (stmt: StmtT; attr_type: INTEGER; READONLY attr: REFANY; ): BOOLEAN;

PROCEDURE StmtAttrGet
  (stmt: StmtT; attr_type: INTEGER; VAR attr: REFANY; ): BOOLEAN;

PROCEDURE StmtBindParam (stmt: StmtT; bnd: BindT; ): BOOLEAN;

PROCEDURE StmtBindResult (stmt: StmtT; bnd: BindT; ): BOOLEAN;

PROCEDURE StmtClose (stmt: StmtT; ): BOOLEAN;

PROCEDURE StmtReset (stmt: StmtT; ): BOOLEAN;

PROCEDURE StmtFreeResult (stmt: StmtT; ): BOOLEAN;

PROCEDURE StmtSendLongData
  (stmt: StmtT; param_number: CARDINAL; data: TEXT; length: CARDINAL; ):
  BOOLEAN;

PROCEDURE StmtResultMetadata (stmt: StmtT; ): ResultT RAISES {ResultE};

PROCEDURE StmtParamMetadata (stmt: StmtT; ): ResultT RAISES {ResultE};

PROCEDURE StmtErrno (stmt: StmtT; ): CARDINAL;

PROCEDURE StmtError (stmt: StmtT; ): TEXT;

PROCEDURE StmtSqlstate (stmt: StmtT; ): TEXT;

PROCEDURE StmtRowSeek (stmt: StmtT; offset: RowOffsetT; ): RowOffsetT;

PROCEDURE StmtRowTell (stmt: StmtT; ): RowOffsetT;

PROCEDURE StmtDataSeek (stmt: StmtT; offset: LONGINT; );

PROCEDURE StmtNumRows (stmt: StmtT; ): LONGINT;

PROCEDURE StmtAffectedRows (stmt: StmtT; ): LONGINT;

PROCEDURE StmtInsertId (stmt: StmtT; ): LONGINT;

PROCEDURE StmtFieldCount (stmt: StmtT; ): CARDINAL;

PROCEDURE Commit (mysql: T; ): BOOLEAN;

PROCEDURE Rollback (mysql: T; ): BOOLEAN;

PROCEDURE Autocommit (mysql: T; auto_mode: BOOLEAN; ): BOOLEAN;

PROCEDURE MoreResults (mysql: T; ): BOOLEAN;

PROCEDURE NextResult (mysql: T; ): INTEGER RAISES {ReturnE};

PROCEDURE Close (sock: T; );


END MySQL.
