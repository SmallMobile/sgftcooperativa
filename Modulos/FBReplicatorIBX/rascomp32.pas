unit rascomp32;

{-----------------------------------------------------
DELPHI RAS COMPONENT - version 3.0 - 17th March 1999
(C) 1996 Daniel Polistchuck and 1999 Magenta Systems Ltd

Updated by Angus Robertson, Magenta Systems Ltd, England
in 1999, delphi@magsys.co.uk, http://www.magsys.co.uk/delphi/
Copyright Magenta Systems Ltd

Compatible with Delphi 2, 3 and 4, Windows 95, 98 and NT 4.0.

TRAS is an installable Delphi non-visual component, supplied with
full source and a demo program, for accessing Dial Up Networking
or Remote Access Services functions.  This is an updated version of
Daniel Polistchuck's and Mike Armstrong's earlier component.

It adds support for phone books including DUN password update,
using existing connections, NT compatible, improved events and
progress messages, on demand DLL loading to allow application use
without RAS installed, connection IP addressed, performance
statistics for Win95/98/NT showing data transmitted and received.

A new demo program illustrates nearly all the methods and properties.
By using TRAS, it is not necessary to understand any of the RAS APIs
or structures.

Since TRAS does need design time properties, it need not really be
installed as such, but may be created in the application as needed,
as shown in the demo program.


Known Problems
--------------

Please note that getting performance statistics from Windows 95/98 can
sometimes be difficult.  This component now searches the registry for any
Dial-Up Adaptors and will default to the first found.  If there are two or
more adaptors installed, I'm not currently sure how to determine which is
being used, but a list is returned and a property may be changed to select
one. To get performance statistics running, make sure that Connection
Properties, Server Types, Record a Log File is ticked, and in Modem
Properties, Options, Display Modem Status is ticked.  You may need to
reboot after these changes and then make a connection, at which point the
correct registry keys should be created.  Users have reported difficulties
geting performance statistics from DUN version earlier than 1.2, so this
is recommended.

It does not appear to be possible to get Multilink (ISDN dual channel) info
from the structures under Win95/98, despite DUN 1.2 supporting this stuff.



Distribution
------------

TRAS may be freely distributed via web pages, FTP sites, BBS and
conferencing systems or on CD-ROM in unaltered zip format, but no charge
may be made other than reasonable media or bandwidth cost.

TRAS may be used freely in Delphi applications, but it would be polite to 
mention in the documentation that your application is using "TRAS from 
Daniel Polistchuck and Magenta Systems Ltd".  Please email Magenta Systems 
Ltd at delphi@magsys.co.uk if you use TRAS in some way, so you can be 
notified of upgrades or other important changes.
            
Magenta Systems Ltd uses TRAS in its DUN Manager and CamCollect 
applications that may be found at http://www.magsys.co.uk/ so if you
want to support the effort that has gone into enhancing and testing this 
component, please look at one or both of those applications and register 
them.


------------------------------------------------------------------------

Updated in 1998 by Angus Robertson, Magenta Systems Ltd, England

Added various functions:
IntDisConnect		- disconnect without error handling
AutoConnect			- GetDialParams, then Connect
LeaveOpen			- stops disconnection when component destroyed
ReOpen				- access an existing connection
GetDialParams		- read phone book logon and password
SetDialParams		- write phone book logon and password
MessText			- gets description for CurrentState
TestRAS				- see if RAS available
EditPhonebook		- displays a dialog to edit a connection
CreatePhonebook		- displays a dialog to create a connection
DeletePhonebook		- deletes a connection
CreatePhonebook		- renames a connection
StateChanged		- event called whenever RAS status changes
ResetPerfStats		- resets the performance counters
EnablePerfStats		- enable performance counters
GetPerfStats		- get current performance counters
GetEntryProperties  - read connection properties (dial number etc), note
                        that not all are processed yet)
GetConnection       - check for existing connection and get name

Other minor changes include:

Improved error handling
StateChanged event handles all progress messages
Get RAS username and password, access phone books
Only call functions if DLL is loaded so application will run without RAS installed
When disconnecting, wait until it happens
Added more progress messages
Error during connection now reported properly
Improved connection progress literals
Corrected a major memory leak in TConnectionList.Clear

Changes in 2.6
Win95/98 performance stats needs registry settings that may be translated
or change, so added search option to EnablePerfStats which will set the
first Dial Up Adaptor found listed

Changes in 2.7
Ensure ConnectState cleared during disconnection so application does not
   think we are still on-line
Increased maximum number of phone book entries from 20 to 100

Changes in 2.8
Supported multi-link connections, using RASSUBENTRY - NT4 only
Changed compiler directive so that programs compiled under NT4 will
  only use the Win9x structures for backward compatibility

Changes in 2.9
Added PhoneCanonical property which is completed from Phonebook with
  full canonical number that may be passed to TAPI lineTranslateAddress to
  create a diallable number for Connect
Clear DialParams if request fails
Ensure RASAPI_Loaded cleared during destroy, so RAS can be used again
Close both libraries

Changes in 3.0
Added GetDeviceList to fill DeviceTypeList and DeviceNameList with RAS TAPI devices
Added DevicePort property, NT only for phonebooks
Corrected canonical number where area code is blank

WARNING - you need to use the TAPI APIs and lineTranslateAddress in particular
to translate the canonical number to a dialable number using defined dialling
preferences - otherwise add stuff like P, T or *40 to the front of the dialable
number

}


interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ras_api32, WinPerf;

const
  MaxConnections = 4;
  MaxPhonebooks = 100 ;
  MaxDevices = 30 ;

type
  TConnectionList = class(TList)
	function AddConnection(Connection: TRASConn): Word;
	function RASConn(Index: Integer): HRASConn;
	function EntryName(Index: Integer): String;
    procedure Clear ;
	procedure Delete(Index: Integer);
  end;

  TRasStateEvent = Procedure( Sender: TObject; Error: Longint; ErrorString: String) of Object;

  TRAS = class(TComponent)
  private
	{ Private declarations }
	FEntryName,
	FPhoneNumber,
	FPhoneBookPath,
	FCallbackNumber,
	FUserName,
	FPassword,
	FDomain,
	FDeviceType,
	FClientIP,
	FServerIP,
	FDeviceName,
    FDevicePort: String;    // Angus, 3.0

	FRedialAttempts: Integer;

	fOnCallback,
	fStateChanged,	// ANGUS
	fOnConnect,
	fAboutToOpenPort,
	fPortOpened,
	fAboutToConnDev,
	fDevConnected,
	fAllDevsConnected,
	fAuthenticate,
	fAuthNotify,
	fAuthRetry,
	fAuthCallBack,
	fAuthChangePassword,
	fAuthProject,
	fAuthLinkSpeed,
	fAuthAck,
	fReAuthenticate,
	fAuthenticated,
	fPrepareforCallback,
	fWaitForModemReset,
	fInteractiveStarted,
	fRetryAuth,
	fPasswordExpired : TNotifyEvent;

	fOnDisconnect : TRasStateEvent;
	fWindowHandle: HWND;
	RASEvent: Word;
	RASLib : THandle ;
	RASxlib: THandle ;
	RASDialParams: TRASDialParams;
	RASAPI_Loaded: Boolean ; 	//See if DLL functions are loaded
	RASExtn_Flag: Boolean ; 		//See if extensions are available

// Angus - more useful things
    FLastError: LongInt;
	FRASConn: HRASConn;	{ Connection handle}
	FConnectState: Word;
    FSavedState: Word ;
    FConnectError: Word ;
	FStatusStr: String ;
    FCurConnName: String ;   // reported by RasEnumConnections
    FNumConns: Dword ;       // reported by RasEnumConnections
    fCurRASConn: HRASConn;   // reported by RasEnumConnections
	FPhoneCanonical: string ;  // formatted phone number for TAPI lineTranslateAddress

// Angus - performance statistics variables
	fStatsXmitTot: DWord ;
	fStatsXmitCon: DWord ;
	fStatsRecvTot: DWord ;
	fStatsRecvCon: DWord ;
	fStatsXmitCur: integer ;
	fStatsRecvCur: integer ;
	fStatsConnSpd: integer ;
    fKeyDUNAdap: string ;
    fKeyDUNConn: string ;
    fKeyDUNXmit: string ;
    fKeyDUNRecv: string ;

	procedure SetPhoneBookPath(Value: String);
	procedure StateChanged;	// ANGUS
	procedure Connected;
	procedure DisConnected;
	procedure WaitingForCallBack;
	procedure AboutToOpenPort;
	procedure PortOpened;
	procedure AboutToConnDev;
	procedure DevConnected;
	procedure AllDevsConnected;
	procedure Authenticate;
	procedure AuthNotify;
	procedure AuthRetry;
	procedure AuthCallBack;
	procedure AuthChangePassword;
	procedure AuthProject;
	procedure AuthLinkSpeed;
	procedure AuthAck;
	procedure ReAuthenticate;
	procedure Authenticated;
	procedure PrepareforCallback;
	procedure WaitForModemReset;
	procedure InteractiveStarted;
	procedure RetryAuth;
	procedure PasswordExpired;
	Procedure SetRedialAttempts( Value: Integer );
	function LoadRASAPI: boolean ;
	procedure MoveDialParms ;

	procedure WndProc(var Msg: TMessage);
  protected
	{ Protected declarations }
	RASConnect: Array[1..MaxConnections] OF TRASConn;
  public
	{ Public declarations }
	PhoneBookEntries: TStringList;
	Connections: TConnectionList;
    DialUpAdaptors: TStringList ;
	DeviceTypeList: TStringList;    // 3.0 Angus
	DevicePortList: TStringList;    // 3.0 Angus
	DeviceNameList: TStringList;    // 3.0 Angus

	CONSTRUCTOR Create(AOwner: TComponent); OVERRIDE;
	DESTRUCTOR Destroy; override;
	FUNCTION GetConnectStatus: LongInt;
	FUNCTION DisConnect: LongInt;
	FUNCTION GetErrorString(ErrorCode: LongInt): String;
	FUNCTION Connect: LongInt;
	FUNCTION CurrentStatus: String;
	FUNCTION GetConnections: LongInt;
	FUNCTION GetPhoneBookEntries: LongInt;
	function IntDisConnect: LongInt; { Used internally to bypass fOnDisconnect }
	FUNCTION AutoConnect: LongInt;		 // ANGUS
	FUNCTION LeaveOpen: LongInt;		// ANGUS
	FUNCTION ReOpen (item: integer) : LongInt;  // ANGUS
	FUNCTION GetDialParams: longInt;	// ANGUS
	FUNCTION SetDialParams: longInt;	// ANGUS
	function MessText: String ;			// ANGUS
	function TestRAS: boolean ;			// ANGUS
	function EditPhonebook: LongInt ; 	// ANGUS
	function CreatePhonebook: LongInt ;	// ANGUS
	function DeletePhonebook: LongInt ;	// ANGUS
	function RenamePhonebook (newname: string): LongInt ;  	// ANGUS
	function ValidateName (newname: string): LongInt ;		// ANGUS
	function GetIPAddress: LongInt;		// ANGUS
	procedure ResetPerfStats ;			// ANGUS
	function EnablePerfStats (start, search: boolean): boolean ;  // ANGUS
	function GetPerfStats: boolean ;	 // ANGUS
    function GetEntryProperties: LongInt ;  // ANGUS
 	function GetConnection: String ;     // ANGUS
    function SearchDUA: boolean ;        // ANGUS
	function GetDeviceList: LongInt ;    // 3.0 Angus

  PUBLISHED
	{ Published declarations }
	PROPERTY EntryName:	String		  read fEntryName write fEntryName;
	PROPERTY PhoneNumber: String	  read fPhoneNumber write fPhoneNumber;
	PROPERTY PhoneBookPath:  String	  read fPhoneBookPath write SetPhoneBookPath;
	PROPERTY CallbackNumber: String	  read fCallbackNumber write fCallbackNumber;
	PROPERTY UserName:	String		  read fUserName write fUserName;
	PROPERTY Password:	String		  read fPassword write fPassword;
	PROPERTY RedialAttempts: Integer  read FRedialAttempts write SetRedialAttempts default 1;
	PROPERTY Domain:	  String	  read fDomain write fDomain;
	PROPERTY DeviceType:  String	  read fDeviceType write fDeviceType;
	PROPERTY DeviceName:  String	  read fDeviceName write fDeviceName;
	PROPERTY DevicePort:  String	  read fDevicePort write fDevicePort;  // Angus 3.0

	PROPERTY ClientIP:    String	  read FClientIP ;		// ANGUS
	PROPERTY ServerIP:    String	  read FServerIP ;	 	// ANGUS
	PROPERTY StatsXmit:   Integer	  read fStatsXmitCur ;	// ANGUS
	PROPERTY StatsRecv:   Integer	  read fStatsRecvCur ;	// ANGUS
	PROPERTY StatsConn:   Integer	  read fStatsConnSpd ;	// ANGUS
	PROPERTY LastError:   LongInt     read fLastError ;     // Angus
	PROPERTY RASConn:     HRASConn    read fRASConn ;       // Angus
	PROPERTY ConnectState: Word       read fConnectState ;  // Angus
    PROPERTY SavedState:  Word        read fSavedState ;    // Angus
    PROPERTY ConnectError: Word       read fConnectError ;  // Angus
	PROPERTY StatusStr:   String      read fStatusStr write FStatusStr ;   // Angus
    PROPERTY CurConnName: String      read fCurConnName ;   // Angus
    PROPERTY NumConns: DWord          read fNumConns ;      // Angus
    PROPERTY CurRASConn: HRASConn     read fCurRASConn ;    // Angus
	PROPERTY PhoneCanonical: string	  read FPhoneCanonical ;  // Angus

	PROPERTY KeyDUNAdap: String	      read fKeyDUNAdap write fKeyDUNAdap ; // ANGUS
	PROPERTY KeyDUNConn: String	      read fKeyDUNConn write fKeyDUNConn ; // ANGUS
	PROPERTY KeyDUNXmit: String	      read fKeyDUNXmit write fKeyDUNXmit ; // ANGUS
	PROPERTY KeyDUNRecv: String	      read fKeyDUNRecv write fKeyDUNRecv ; // ANGUS

	PROPERTY OnStateChanged:  	TNotifyEvent	read fStateChanged write fStateChanged;
	PROPERTY OnConnect:	TNotifyEvent	read fOnconnect write fOnConnect;
	PROPERTY OnDisconnect: TRasStateEvent read fOnDisconnect write fOnDisconnect;
	PROPERTY OnCallBack:	TNotifyEvent	read fOnCallBack write fOnCallBack;
	PROPERTY OnAboutToOpenPort:TNotifyEvent read fAboutToOpenPort write fAboutToOpenPort;
	PROPERTY OnPortOpened:	 TNotifyEvent read fPortOpened write fPortOpened;
	PROPERTY OnAboutToConnDev: TNotifyEvent read fAboutToConnDev write fAboutToConnDev;
	PROPERTY OnDevConnected:	TNotifyEvent read fAllDevsConnected write fAllDevsConnected;
	PROPERTY OnAllDevsConnected: TNotifyEvent read fAllDevsConnected write fAllDevsConnected;
	PROPERTY OnAuthenticate:	TNotifyEvent read fAuthenticate write fAuthenticate;
	PROPERTY OnAuthNotify:	 TNotifyEvent read fAuthNotify write fAuthNotify;
	property OnAuthRetry:	  TNotifyEvent read fAuthRetry write fAuthRetry;
	property OnAuthCallBack:	TNotifyEvent read fAuthCallBack write fAuthCallBack;
	property OnAuthChangePassword: TNotifyEvent read fAuthChangePassword write fAuthChangePassword;
	property OnAuthProject:	TNotifyEvent read fAuthProject write fAuthProject;
	property OnAuthLinkSpeed:  TNotifyEvent read fAuthLinkSpeed write fAuthLinkSpeed;
	property OnAuthAck:		TNotifyEvent read fAuthAck write fAuthAck;
	property OnReAuthenticate: TNotifyEvent read fReAuthenticate write fReAuthenticate;
	property OnAuthenticated:  TNotifyEvent read fAuthenticated write fAuthenticated;
	property OnPrepareforCallback: TNotifyEvent read fPrepareforCallback write fPrepareforCallback;
	property OnWaitForModemReset:  TNotifyEvent read fWaitForModemReset write fWaitForModemReset;
	property OnInteractiveStarted: TNotifyEvent read fInteractiveStarted write fInteractiveStarted;
	property OnRetryAuth:		TNotifyEvent read fRetryAuth write fRetryAuth;
	property OnPasswordExpired: TNotifyEvent read fPasswordExpired write fPasswordExpired;
  end;

procedure Register;

implementation

var
  datasize: integer = 0 ;   // performance data buffer size

const

  TOTALBYTES =  8192 ;    // initial buffer size for NT performance data
  BYTEINCREMENT = 1024 ;  // make it bigger

// NT performance counter identifiers, assume they are fixed data
  Pdata_RAS_Total   = '906' ;
  Pdata_Bytes_Xmit  = 872 ;
  Pdata_Bytes_Recv  = 874 ;
  // connect speed is not available on NT, get it from TAPI instead

// keys and names for Win9x performance statistics under HKEY_DYN_DATA
  Reg_PerfStatStart 	= 'PerfStats\StartStat';
  Reg_PerfStatData 		= 'PerfStats\StatData';
  Reg_PerfStatStop 		= 'PerfStats\StopStat';
  Reg_PerfAdap 			= 'Dial-Up Adapter' ;
  Reg_PerfXmit 			= 'TotalBytesXmit' ;
  Reg_PerfRecv 			= 'TotalBytesRecvd' ;
  Reg_PerfConn 			= 'ConnectSpeed' ;

  Reg_PerfStatEmum   = 'System\CurrentControlSet\Control\PerfStats\Enum' ;

{ other keys... Win9x only
Dial-Up Adapter #2\
"Dial-Up Adapter\Buffer"
"Dial-Up Adapter\Framing"
"Dial-Up Adapter\Overrun "
"Dial-Up Adapter\Alignment"
"Dial-Up Adapter\Timeout"
"Dial-Up Adapter\CRC"
"Dial-Up Adapter\Runts"
"Dial-Up Adapter\FramesXmit"
"Dial-Up Adapter\FramesRecvd"
"Dial-Up Adapter\BytesXmit"	these are the same as Total
"Dial-Up Adapter\BytesRecvd"	}


procedure Register;
begin
	RegisterComponents('Samples', [TRAS]);
end;


{ ********************************************************************* }
{							TConnectionList							 }
{ ********************************************************************* }
function TConnectionList.AddConnection(Connection: TRASConn): Word;
var
	Conn: PRASConn;
begin
	Conn := New(PRASConn);
	Conn^ := Connection;
	Add(Conn);
end;

function TConnectionList.RASConn(Index: Integer): HRASConn;
begin
	Result := PRASConn(Items[Index])^.RASConn;
end;

function TConnectionList.EntryName(Index: Integer): String;
begin
	If PRASConn(Items[Index])^.szEntryName[0] <> #0 THEN
		Result := StrPas(PRASConn(Items[Index])^.szEntryName)
	ELSE
		Result := '';
end;

procedure TConnectionList.Clear;  // Angus, must clear memory before Tlist
begin
    while (Count > 0) do Delete (count - 1) ;

	Inherited Clear ;
end;

procedure TConnectionList.Delete(Index: Integer);
begin
	Dispose( PRASConn( Items[ Index ] ) );
	Items[ Index ] := Nil;

	Inherited Delete( Index );
end;

{ ********************************************************************* }
{							TRASConnection							 }
{ ********************************************************************* }

CONSTRUCTOR TRAS.Create(AOwner: TComponent);
begin
	inherited Create(AOwner);
	RASEvent := RegisterWindowMessage(RASDialEvent);
	If RASEvent = 0 THEN RASEvent := WM_RASDialEvent;
	RASLib := 0 ;
	RASxlib := 0 ;
	RASAPI_Loaded := False;
	RASExtn_Flag := False;

	fRASConn := 0;
	fConnectState := 0;
    fSavedState := 9999 ;
	fWindowHandle := 0;
	ResetPerfStats ;  // clear performance statistics
	FRedialAttempts := 1;
	fDeviceName := '' ;     // Angus
	fDeviceType := '' ;     // Angus
	fDevicePort := '' ;     // Angus
	fLastError := 0 ;
    fStatusStr :=  '' ;
    fKeyDUNAdap := Reg_PerfAdap ;
    fKeyDUNConn := Reg_PerfConn ;
    fKeyDUNXmit := Reg_PerfXmit ;
    fKeyDUNRecv := Reg_PerfRecv ;

	PhoneBookEntries := TStringList.Create;
	Connections := TConnectionList.Create;
    DialUpAdaptors := TStringList.Create;
	DeviceTypeList := TStringList.Create;
	DevicePortList := TStringList.Create;
	DeviceNameList := TStringList.Create;
end;

destructor TRAS.Destroy;
begin
	IntDisconnect;
	PhoneBookEntries.Free;
	Connections.Free;
    DialUpAdaptors.Free ;
	DeviceTypeList.Free ;
 	DevicePortList.Free ;
	DeviceNameList.Free ;
    if (RASxlib <> RASlib) and (RASxlib <> 0) then
 										      	FreeLibrary(RASxlib) ;
	if RASAPI_Loaded then FreeLibrary(RASlib);
    RASAPI_Loaded := false ;
// must close key to allow other applications to be deleted/accessed
	if Win32Platform = VER_PLATFORM_WIN32_NT then
						RegCloseKey (HKEY_PERFORMANCE_DATA);
	inherited Destroy;
end;

// Try and load various RAS DLL functions. Returns false if failed

function TRAS.LoadRASAPI: boolean ;
begin
	if Not RASAPI_Loaded then
	begin
		RasDial := Nil;
		RASAPI_Loaded := True;
		RASExtn_Flag := false ;
		RASlib := LoadLibrary (RASAPI_DLL) ;
		If RASlib <> 0 then
		begin
			RasDial := GetProcAddress(RASlib, 'RasDialA') ;
			RasEnumConnections := GetProcAddress(RASlib, 'RasEnumConnectionsA');
			RasEnumEntries := GetProcAddress(RASlib, 'RasEnumEntriesA');
			RasGetConnectStatus := GetProcAddress(RASlib, 'RasGetConnectStatusA');
			RasGetErrorString := GetProcAddress(RASlib, 'RasGetErrorStringA');
			RasHangUp := GetProcAddress(RASlib, 'RasHangUpA');
			RasGetEntryDialParams := GetProcAddress(RASlib, 'RasGetEntryDialParamsA');
			RasSetEntryDialParams := GetProcAddress(RASlib, 'RasSetEntryDialParamsA');
			RasMonitorDlg := GetProcAddress(RASlib, 'RasMonitorDlgA');
			RasEditPhonebookEntry := GetProcAddress(RASlib, 'RasEditPhonebookEntryA');
			RasCreatePhonebookEntry := GetProcAddress(RASlib, 'RasCreatePhonebookEntryA');
			RasGetProjectionInfo := GetProcAddress(RASlib, 'RasGetProjectionInfoA');

	// now get API extensions that may be in rasapi32.dll or rnaph.dll
			RASxLib := RASLib ;
			RasGetCountryInfo := GetProcAddress(RASxLib, 'RasGetCountryInfoA');
			if Assigned (RasGetCountryInfo) then
				RASExtn_Flag := true
			else
			begin
				RASxlib := LoadLibrary (RNAPH_DLL) ;
				If RASxlib <> 0 then RASExtn_Flag := true ;
			end ;
			if RASExtn_Flag then
			begin
				RasGetCountryInfo := GetProcAddress(RASxLib, 'RasGetCountryInfoA');
				RasGetEntryProperties := GetProcAddress(RASxLib, 'RasGetEntryPropertiesA');
				RasSetEntryProperties := GetProcAddress(RASxLib, 'RasSetEntryPropertiesA');
				RasRenameEntry := GetProcAddress(RASxLib, 'RasRenameEntryA');
				RasDeleteEntry := GetProcAddress(RASxLib, 'RasDeleteEntryA');
				RasValidateEntryName := GetProcAddress(RASxLib, 'RasValidateEntryNameA');
				RasEnumDevices := GetProcAddress(RASxLib, 'RasEnumDevicesA');
			end ;
		end ;
	end ;
	result := Assigned (RasDial) ;
end ;

// allow to check if RAS available without calling any functions

function TRAS.TestRAS: boolean ;
begin
	result := LoadRASAPI ;
	if NOT result then
	begin
		fLastError := ERROR_DLL_NOT_FOUND ;
		fStatusStr :=  RASAPI_DLL + ' Not Available' ;
	end ;
end ;

// get dial parms from specified Phone Book (aka Dialup Connection)

FUNCTION TRAS.GetDialParams: LongInt;
var
	fp: LongBool;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	FillChar(RASDialParams, SizeOf(TRasDialParams), 0);
	fUserName := '' ;
	FPassword := '' ;
 //	fPhoneNumber := '' ;
	fCallBackNumber := '' ;
	fDomain := '' ;
	with RASDialParams do
	begin
		dwSize := Sizeof(TRasDialParams);
		StrPCopy(szEntryName, fEntryName);
	end;
	If fPhoneBookPath <> '' THEN
		fLastError := RasGetEntryDialParams (PChar(fPhoneBookPath),
													 RASDialParams, fp)
	else
		fLastError := RasGetEntryDialParams (nil, RASDialParams, fp);
	result := fLastError ;
	if fLastError = 0 then
	begin
		with RASDialParams do
		begin
		// note no phone number comes back!!, but try anyway
			fUserName := StrPas (szUserName) ;
			FPassword := '' ;
			if fp then Fpassword := StrPas (szPassword) ;
 //			fPhoneNumber := StrPas (szPhoneNumber) ;
			fCallBackNumber := StrPas (szCallBackNumber) ;
			fDomain := StrPas (szDomain) ;
		end ;
	end
	else
		fStatusStr := GetErrorString (LastError);
	;
end;

function FixedToPasStr (fixstr: PChar; fixsize: integer): string ;
var
    temp: string ;
begin
	SetLength (temp, fixsize);
    Move (fixstr^, PChar (temp)^, fixsize);    // may include embedded nulls
    result := TrimRight (temp) ;   // strip trailing nulls
end ;

// get entry properties from specified Phone Book (aka Dialup Connection)

function TRAS.GetEntryProperties: LongInt ;
var
   BuffSize, PropsSize, DevSize, count: Longint ;
   EntryBuff: PChar ;
   RASEntry: TRasEntry ;
   dwSize: ^Longint ;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;

// note that NT may return info beyond RASEntry, for extra phone numbers
// so the buffer must be larger, 5K is a guess
    BuffSize := 5000 ;
   	Try
	GetMem (EntryBuff, BuffSize) ;
	PropsSize := BuffSize ;
   	pointer (dwSize) := EntryBuff ;
    dwSize^ := SizeOf (TRASEntry) ;
    DevSize := 0 ;
// currently ignoring the device specific information
	If fPhoneBookPath <> '' THEN
        Result := RasGetEntryProperties (PChar(fPhoneBookPath),
	       PChar (fEntryName), Pchar(EntryBuff), PropsSize, nil, DevSize)
    else
        Result := RasGetEntryProperties (nil, PChar (fEntryName),
                             Pchar(EntryBuff), PropsSize, nil, DevSize) ;
 	fLastError := Result ;
	if fLastError <> 0 then
		fStatusStr := GetErrorString (fLastError)
    else
    begin
    	move (EntryBuff^, RASEntry, SizeOf (TRASEntry)) ;
		with RASEntry do
        begin
	   	if ((dwfOptions and RASEO_UseCountryAndAreaCodes) =
									  RASEO_UseCountryAndAreaCodes) then
        begin
	        fPhoneNumber := StrPas (szAreaCode) + ' ' +
            								   StrPas (szLocalPhoneNumber) ;
            fPhoneCanonical := '+' + IntToStr (dwCountryCode) + ' ' ;
			if (szAreaCode [0] >= '0') then	fPhoneCanonical :=
		               	fPhoneCanonical + '(' + StrPas (szAreaCode) + ') ' ;
            fPhoneCanonical := fPhoneCanonical + StrPas (szLocalPhoneNumber) ;
       	end
        else
        begin
			fPhoneNumber := StrPas (szLocalPhoneNumber) ;
            fPhoneCanonical := fPhoneNumber ;
    	end ;
    // warning, some devices have two nulls strings
   		fDeviceName := FixedToPasStr (szDeviceName, sizeof (szDeviceName)) ;
        fDevicePort := '' ;
        count := pos (#0, fDeviceName) ;  // see if port follows drvice, NT only
        if count > 1 then
        begin
            fDevicePort := trim (copy (fDeviceName, count + 1, 99)) ;
            fDeviceName := trim (copy (fDeviceName, 1, count - 1)) ;
        end ;
	    fDeviceType := StrPas (szDeviceType);
          // other connection stuff here, if we need it
         // may be extra phone numbers after structure
         end ;
   	end ;
    finally
 		if EntryBuff <> nil then Freemem (EntryBuff) ;
 	end ;
end ;

// internal proc used to setup dial params for Set and Dial

procedure TRAS.MoveDialParms ;
begin
	FillChar(RASDialParams, SizeOf(RASDialParams), #0);
	With RASDialParams DO
	Begin
		dwSize := SizeOf(TRASDialParams);
		UniqueString(fEntryName);
		StrLCopy(szEntryName, PChar((fEntryName)), RAS_MaxEntryName);
		UniqueString(fPhoneNumber);
		StrLCopy(szPhoneNumber, PChar(fPhoneNumber), RAS_MaxPhoneNumber);
		UniqueString(fCallBackNumber);
		StrLCopy(szCallbackNumber, PChar((fCallBackNumber)), RAS_MaxCallbackNumber);
		UniqueString(fUserName);
		StrLCopy(szUserName,PChar((fUserName)), UNLEN);
		UniqueString(fPassWord);
		StrLCopy(szPassword, PChar((fPassWord)), PWLEN);
		UniqueString(fDomain);
		StrLCopy(szDomain, Pchar(fDomain), DNLEN);
	End;
end ;

// update dial parms for specified Phonebook (aka Dialup Connection)

function TRAS.SetDialParams: LongInt;
begin
   	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	MoveDialParms ;
	If fPhoneBookPath <> '' THEN
			fLastError := RasSetEntryDialParams (PChar(fPhoneBookPath),
													 RASDialParams, false)
	else
		fLastError := RasSetEntryDialParams (nil, RASDialParams, false);
	if fLastError <> 0 then
				fStatusStr := GetErrorString (fLastError);
	Result := fLastError;
end;

// edit specified Phonebook (aka Dialup Connection)

function TRAS.EditPhonebook: LongInt ;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	Result := RasEditPhonebookEntry (Application.Handle, nil, PChar(fEntryName));
	fLastError := Result ;
	if fLastError <> 0 then
				fStatusStr := GetErrorString (fLastError);
end ;

// delete specified Phonebook (aka Dialup Connection)

function TRAS.DeletePhonebook: LongInt ;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	if NOT RASExtn_Flag then exit ;
	Result := RasDeleteEntry (nil, PChar(fEntryName));
	fLastError := Result ;
	if Result = 0 then
		fEntryName := ''
	else
		fStatusStr := GetErrorString (fLastError);
end ;

// rename specified Phonebook (aka Dialup Connection)
// checks that name is valid first

function TRAS.RenamePhonebook (newname: string): LongInt ;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	if NOT RASExtn_Flag then exit ;
	Result := RasValidateEntryName (nil, PChar(newname));
	fLastError := Result ;
	if fLastError = 0 then
	begin
		Result := RasRenameEntry (nil, PChar(fEntryName), PChar(newname));
		if Result = 0 then fEntryName := newname ;
    	fLastError := Result ;
	end  ;
	if fLastError <> 0 then
			fStatusStr := GetErrorString (fLastError);
end ;

// check specified Phonebook name is valid (aka Dialup Connection)

function TRAS.ValidateName (newname: string): LongInt ;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	if NOT RASExtn_Flag then exit ;
	Result := RasValidateEntryName (nil, PChar(newname));
	fLastError := Result ;
	if fLastError <> 0 then
				fStatusStr := GetErrorString (fLastError);
end ;

// create new Phonebook (aka Dialup Connection)

function TRAS.CreatePhonebook: LongInt ;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	Result := RasCreatePhonebookEntry (Application.Handle, nil);
	fLastError := Result ;
	if fLastError <> 0 then
				fStatusStr := GetErrorString (fLastError);
end ;


// for specified Phonebook, get username/password/number, then dial it

function TRAS.AutoConnect: LongInt;
begin
	GetDialParams ;
    if fLastError = 0 then GetEntryProperties ;
    if fLastError = 0 then Connect ;
	result := fLastError ;
end ;

// for specified Phonebook, dial it (with given logon and password)

function TRAS.Connect: LongInt;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	If fRASConn <> 0 THEN { Allow only one connection }
				  IntDisconnect;
	If fWindowHandle = 0 THEN
				  fWindowHandle := AllocateHWnd(WndProc);
	fRasConn := 0;
	fConnectState := 0;	  // ANGUS, 16 Apr 98
    fSavedState := 9999 ;
	ResetPerfStats ;  // clear performance statistics
	MoveDialParms ;
	If fPhoneBookPath <> '' THEN
		fLastError := RasDial(Nil, PChar(fPhoneBookPath), @RASDialParams,
									$FFFFFFFF, fWindowHandle, fRASConn)
	ELSE
		fLastError := RasDial(Nil, Nil, @RASDialParams,$FFFFFFFF,
												 fWindowHandle, fRASConn);
	if fLastError <> 0 then		// Angus, get more info about failure
		fStatusStr := GetErrorString (fLastError) ;
	Result := fLastError;
end;

// get a standard Windows Error String

function TRAS.GetErrorString(ErrorCode: LongInt): String;
var
	szErrorString: Array[0..256] of Char;
begin
	Result := '';
	FillChar(szErrorString, SizeOf(szErrorString), #0);
	RasGetErrorString(ErrorCode, szErrorString, 256);
	If szErrorString[0] <> #0 THEN
		Result := StrPas(szErrorString)
	Else
//		Result := 'Status Unknown';
		Result := SysErrorMessage (ErrorCode) ;  // Angus, try a windows error
end;

// Leave connection open but disable access from this component
// use this before terminating the program if the connection is
// to be left open, otherwise it's closed automatically

function TRAS.LeaveOpen: LongInt;
begin
	fRASConn := 0;
	Result := IntDisconnect;
end ;

// ReOpen RAS an existing coonection for access from this component
// used after RAS.GetConnections finds one or more new connections
// entry is specific connection to access

function TRAS.ReOpen (item: integer) : LongInt;
begin
 	if fRASConn = 0 then
    begin
        if fCurRASConn = 0 then
        begin
            fLastError := 6 ;    // bad handle
            result := fLastError ;
            exit ;
        end ;
       if item > 0 then
            fRASConn := Connections.RasConn (item)
        else
            fRASConn := fCurRASConn ;
    end ;
	Result := GetConnectStatus ;
//	ResetPerfStats ;  // clear performance statistics
end ;

// Close RAS connection, wait for it to finish

function TRAS.Disconnect: LongInt;
var
	oldstate: integer ;
begin
	Result := 0;
	OldState := 0 ;
    fConnectState := 0 ;     // 11 Nov 98 - ensure not left 'connected'
	If fRASConn <> 0 THEN
	begin
		fLastError := ERROR_DLL_NOT_FOUND ;
		if NOT LoadRASAPI then exit ;
		result := RASHangUp (fRASConn);
		while GetConnectStatus = 0 do	// ANGUS, wait for it to die
		begin
			Application.ProcessMessages ;		// 16 Apr 98
			if oldstate <> fConnectState then
			begin
				fStatusStr := MessText ;
				StateChanged ;
				oldstate := fConnectState ;
			end ;
		end ;
	end ;
	fRASConn := 0;
	If fWindowHandle <> 0 THEN { Stop message flow }
	Begin
		DeallocateHWnd(fWindowHandle);
		fWindowHandle := 0;
	End;
	fLastError := Result;
	Disconnected;
end;

// Close RAS connection, do not wait for it to finish (used by Destroy)

function TRAS.IntDisconnect: LongInt;
begin
	Result := 0;
    fConnectState := 0 ;     // 11 Nov 98 - ensure not left 'connected'
	If fRASConn <> 0 THEN
	begin
		fLastError := ERROR_DLL_NOT_FOUND ;
		if NOT LoadRASAPI then exit ;
		Result := RASHangUp (fRASConn);
	end ;
	fRASConn := 0;
	If fWindowHandle <> 0 THEN { Stop message flow }
	Begin
		DeallocateHWnd(fWindowHandle);
		fWindowHandle := 0;
	End;
	fLastError := Result;
end;

// get IP addresses for current RAS connections

function TRAS.GetIPAddress: LongInt;
var
	RasPppIp: TRasPppIp ;
	varsize: longint ;
begin
	Result := 0;
	FClientIP := '' ;
	FServerIP := '' ;
	If fRASConn = 0 THEN exit ;
	fLastError := ERROR_DLL_NOT_FOUND ;
	if NOT LoadRASAPI then exit ;
	FillChar (RasPppIp, SizeOf(RasPppIp), #0);
	RASPppIp.dwSize := SizeOf (RasPppIp);
	varsize := SizeOf (RasPppIp);
	Result := RASGetProjectionInfo(RASConn, RASP_PppIp,
												@RasPppIp, varsize) ;
	fLastError := Result;
	if Result = 0 then
	begin
		//	dwError - PPP control negotiation, 0 OK
		fClientIP := StrPas(RasPppIp.szIpAddress);
		fServerIP := StrPas(RasPppIp.szServerIpAddress);
	end ;
end;

// get list of active RAS connections, ie things online

function TRAS.GetConnections: LongInt;
var
//  RASConnect: Array[1..MaxConnections] OF TRASConn;
	I,
	BufSize: DWord;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
    fCurConnName := '' ;
    fCurRASConn := 0 ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	Connections.Clear;
	FillChar (RASConnect, SizeOf(RASConnect), 0);
	RASConnect[1].dwSize := Sizeof (RASConnect[1]);
	BufSize := SizeOf(RASConnect);
	Result := RasEnumConnections(@RASConnect, BufSize, fNumConns);
	fLastError := Result;
	if ((fLastError  = 0) OR (fLastError = ERROR_BUFFER_TOO_SMALL)) and
                                                    (fNumConns <> 0) THEN
    begin
    	For I := 1 TO fNumConns DO
        begin
	    	If (I <= MaxConnections) THEN
		    	Connections.AddConnection(RASConnect[I]);
        end ;
        fCurConnName := RASConnect [1].szEntryName ;
        fCurRASConn := RASConnect [1].rasConn ;
    end ;
end;

// get single connection details
// this avoids messing with string lists when one connection is common

function TRAS.GetConnection: String;
var
	BufSize: DWord ;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
    fCurConnName := '' ;
    fCurRASConn := 0 ;
	result := '' ;
	if NOT LoadRASAPI then exit ;
	FillChar (RASConnect, SizeOf(RASConnect), 0);
	RASConnect[1].dwSize := Sizeof (RASConnect[1]);
	BufSize := SizeOf(RASConnect);
	fLastError := RasEnumConnections(@RASConnect, BufSize, fNumConns);
	if ((fLastError  = 0) OR (fLastError = ERROR_BUFFER_TOO_SMALL)) and
                                                    (fNumConns <> 0) THEN
    begin
        fCurConnName := RASConnect [1].szEntryName ;
        fCurRASConn := RASConnect [1].rasConn ;
        result := fCurConnName ;
    end ;
end;

// get list of defined TAPI device, ie modems or ISDN cards

function TRAS.GetDeviceList;
var
	RASDevNames: Array[1..MaxDevices] Of TRasDevInfo;
	I,
	BufSize,
	Entries: LongInt ;
    count: integer ;
    DeviceName, DevicePort: string ;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	if NOT RASExtn_Flag then exit ;
	DeviceTypeList.Clear;
 	DevicePortList.Clear ;
	DeviceNameList.Clear;
	BufSize := SizeOf(RASDevNames);
	FillChar (RASDevNames, SizeOf(RASDevNames), 0);
	RASDevNames[1].dwSize := SizeOf(RASDevNames[1]);
	Result := RasEnumDevices (@RASDevNames, BufSize, Entries);
	fLastError := Result;
	If (Result = 0) THEN
    	For I := 1 TO Entries DO
	    	If (RASDevNames[I].szDeviceName[0] <> #0) THEN
            begin
		    	DeviceTypeList.Add (StrPas(RASDevNames[I].szDeviceType));
   				DeviceName := FixedToPasStr (RASDevNames[I].szDeviceName,
                					sizeof (RASDevNames[1].szDeviceName)) ;
		        DevicePort := '' ;
		        count := pos (#0, DeviceName) ;  // see if port follows drvice, NT only
		        if count > 1 then
        		begin
		            DevicePort := copy (DeviceName, count + 1, 99) ;
        		    DeviceName := copy (DeviceName, 1, count - 1) ;
		        end ;
 		    	DevicePortList.Add (DevicePort) ;
  		    	DeviceNameList.Add (DeviceName) ;
			end ;
end;

// get list of defined Phonebooks (aka DUN Connections)

function TRAS.GetPhoneBookEntries;
var
	RASEntryName: Array[1..MaxPhonebooks] Of TRASENTRYNAME;
	I,
	BufSize,
	Entries: DWord;
	szPhoneBookPath: PChar;
begin
	fLastError := ERROR_DLL_NOT_FOUND ;
	result := fLastError ;
	if NOT LoadRASAPI then exit ;
	PhoneBookEntries.Clear;
	FillChar (RASEntryName, SizeOf(RASEntryName), 0);
	RASEntryName[1].dwSize := SizeOf(RASEntryName[1]);
	BufSize := SizeOf(RASEntryName);
	If fPhoneBookPath <> '' THEN
	Begin
		GetMem(szPhoneBookPath, Length(fPhoneBookPath) + 1);
		StrPCopy(szPhoneBookPath, fPhoneBookPath);
		Result := RasEnumEntries(Nil, szPhonebookPath, @RASEntryName,
							 BufSize, Entries);
		FreeMem(szPhoneBookPath, Length(fPhoneBookPath) + 1);
	End
	ELSE
		Result := RasEnumEntries(Nil, Nil, @RASEntryName, BufSize, Entries);
	fLastError := Result;
	If (Result = 0) THEN
    	For I := 1 TO Entries DO
	    	If (RASEntryName[I].szEntryName[0] <> #0) THEN
		    	PhoneBookEntries.Add(StrPas(RASEntryName[I].szEntryName));
end;


// get text for RAS progress message

function TRAS.MessText: String ;
begin
	Result := '' ;
	Case fConnectState OF
	RASCS_OpenPort:
			Result := 'Opening Serial Port' ;
	RASCS_PortOpened:
			Result := 'Serial Port Opened';
	RASCS_ConnectDevice:
            begin
    			Result := 'Connecting/Dialling' ;
                if fDeviceType <> '' then Result := Result +
                                ' (' + LowerCase (fDeviceType) + ')' ;
            end ;
	RASCS_DeviceConnected:
            begin
    			Result := 'Connected/Answered' ;
                if fDeviceType <> '' then Result := Result +
                                ' (' + LowerCase (fDeviceType) + ')' ;
            end ;
	RASCS_AllDevicesConnected:
			Result := 'Connected/Negotiation';
	RASCS_Authenticate:
			Result := 'Validating User and Password';
	RASCS_AuthNotify:
			Result := 'Authentication Notification';
	RASCS_AuthCallBack:
			Result := 'Authentication Call Back';
	RASCS_AuthProject:
			Result := 'Projection Started';
	RASCS_AuthLinkSpeed:
			Result := 'Calculating Link speed';
	RASCS_AuthAck:
			Result := 'Authentication acknowledged';
	RASCS_ReAuthenticate:
			Result := 'Reauthenticating';
	RASCS_Authenticated:
			Result := 'Login Authenticated';
	RASCS_PrepareforCallBack:
			Result := 'Preparing for Callback';
	RASCS_WaitForModemReset:
			Result := 'Waiting for Modem Reset';
	RASCS_WaitForCallBack:
			Result := 'Waiting for Callback';
    RASCS_Projected:                              // ANGUS
			Result := 'Projection Completion';
    RASCS_StartAuthentication:                    // ANGUS
			Result := 'Start Authentication';
    RASCS_CallbackComplete:                       // ANGUS
			Result := 'Callback Complete';
    RASCS_LogonNetwork:                           // ANGUS
			Result := 'Logon to Network';
	RASCS_Connected:						      // ANGUS
			 Result := 'Connected/Online';
	RASCS_DisConnected:					          // ANGUS
			 Result := 'Disconnected/Offline';
 	End; { Case }
    if Result = '' then
    begin
    // connect state should not have errors, but of course it does!
        If fConnectState > Pending THEN     // 600
	        Result := GetErrorString (fConnectState)
         else
            Result := 'Unknown State - ' + IntToStr (fConnectState) ;
    end ;

end ;

// event handler called by Windows while making a RAS connection

procedure TRAS.WndProc(var Msg: TMessage);
begin
	If (Msg.Msg = RASEvent) AND (fRASConn <> 0) THEN
	Begin
        fConnectError := Msg.lParam ;
    	If Msg.lParam <> 0 THEN
    	begin
    		fLastError := Msg.lParam ;
     		fConnectState := fLastError ;	 // ANGUS, ensure errors handled
 	    	fStatusStr := GetErrorString (fLastError);
    		StateChanged ;			  // ANGUS - general catch all
    	end
    	ELSE
    	Begin
    		fConnectState := Msg.wParam;
    		fStatusStr := MessText ;
    		StateChanged ;			  // ANGUS - general catch all
    		Case fConnectState OF
{			RASCS_DeviceConnected: DeviceConnected;}
			{Daniel's Addition}
    			RASCS_OpenPort : AboutToOpenPort;
    			RASCS_PortOpened : PortOpened;
	    		RASCS_ConnectDevice : AboutToConnDev;
    			RASCS_DeviceConnected : DevConnected;
    			RASCS_AllDevicesConnected : AllDevsConnected;
	    		RASCS_Authenticate : Authenticate;
		    	RASCS_AuthNotify : AuthNotify;
    			RASCS_AuthRetry : AuthRetry;
    			RASCS_AuthCallback : AuthCallBack;
	    		RASCS_AuthChangePassword : AuthChangePassword;
		    	RASCS_AuthProject : AuthProject;
    			RASCS_AuthLinkSpeed : AuthLinkSpeed;
    			RASCS_AuthAck : AuthAck;
    			RASCS_ReAuthenticate : ReAuthenticate;
	    		RASCS_Authenticated : Authenticated;
		    	RASCS_PrepareForCallback : PrepareforCallback;
    			RASCS_WaitForModemReset : WaitForModemReset;
    			RASCS_Interactive : InteractiveStarted;
    			RASCS_RetryAuthentication : RetryAuth;
    			RASCS_PasswordExpired : PasswordExpired;
     			RASCS_Connected	: Connected;
	    		RASCS_DisConnected : Disconnected;
    			RASCS_WaitForCallBack: WaitingForCallBack;
    		End;
    	End;
//	CurrentStatus;
	End
	ELSE
		DefWindowProc(fWindowHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

Procedure TRAS.SetRedialAttempts( Value: Integer );
Begin
	IF ( FRedialAttempts <> Value ) THEN
	BEGIN
		FRedialAttempts := Value;
	END;
End;

// get status of currently open RAS connection

function TRAS.GetConnectStatus: LongInt;
var
	RASConnStatus: TRASConnStatus;
begin
    fConnectState := 0 ;
	Result := ERROR_INVALID_PORT_HANDLE ;
    if (fRASConn = 0) THEN Exit;
	fLastError := ERROR_DLL_NOT_FOUND ;
    Result := fLastError ;
	if NOT LoadRASAPI then exit ;
	FillChar (RASConnStatus, SizeOf(RASConnStatus), #0);
	RASConnStatus.dwSize := SizeOf (RasConnStatus);
	fLastError := RasGetConnectStatus(RASConn, @RASConnStatus);
	If fLastError = 0 THEN
	begin
// removed 27 Aug 98 - not reliable on NT, so get from Phonebook instead
//		fDeviceName := StrPas(RASConnStatus.szDeviceName);
//		fDeviceType := StrPas(RASConnStatus.szDeviceType);
		fConnectState := RASConnStatus.RASConnState;
        fConnectError := RASConnStatus.dwError ;
      	if RASConnStatus.dwError > Pending then	 // ANGUS
        							  fLastError := RASConnStatus.dwError;
 	end;
	if fLastError <> 0 then		// Angus, get more info about failure
				fStatusStr := GetErrorString (fLastError) ;
	Result := fLastError;
end;

// RAS status procedure, asks windows what is going on

FUNCTION TRAS.CurrentStatus: String;
BEGIN
	If fRASConn <> 0 THEN
	Begin
		GetConnectStatus;		 // actually makes RasGetConnectStatus
		Result := 'Unknown State';
		If fLastError <> 0 THEN
    	Begin
    		If fLastError > Pending THEN     // 600
	    		Result := GetErrorString (fLastError)
		    ELSE
    		Case fLastError OF
	    		6: Result := 'Disconnected';	 // bad handle
		    	8: Result := 'Not enough memory';
			    Pending: Result := 'Device Connecting/Dialling' ; // better than pending
    		End;
	    End
    	ELSE
	    	Result := MessText ;
		// moved all literals to function MessText
	End
	ELSE
		Result := 'Not Connected';

	fStatusStr := Result ;
	StateChanged ;			  // ANGUS - general catch all event
end;

PROCEDURE TRAS.SetPhoneBookPath( Value: String );
BEGIN
	fPhoneBookPath := Value;
	GetPhoneBookEntries;
END;

PROCEDURE TRAS.Connected;
BEGIN
	If ( fRASConn = 0 ) THEN Exit;
	If Assigned( fOnConnect ) THEN fOnConnect( Self );
END;

PROCEDURE TRAS.StateChanged;			 // Angus
BEGIN
	If ( fRASConn = 0 ) THEN Exit;
    If Assigned( fStateChanged ) THEN
    begin
        if (LastError <> 0) or (ConnectState <> SavedState) then
                                                fStateChanged( Self );
        if (LastError <> 0) then
            fSavedState := 0
        else
            fSavedState := fConnectState ;
    end ;
END;

PROCEDURE TRAS.AboutToOpenPort;
BEGIN
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAboutToOpenPort) THEN fAboutToOpenPort (Self);
end;

procedure TRAS.PortOpened;
begin
	If (fRASConn = 0) THEN Exit;
//   	GetConnectStatus ; 				// Angus, get device type and device name
   	If Assigned(fPortOpened) THEN fPortOpened(Self);
end;

procedure TRAS.AboutToConnDev;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAboutToConnDev) THEN fAboutToConnDev (Self);
end;

procedure TRAS.DevConnected;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fDevConnected) THEN fDevConnected(Self);
end;

procedure TRAS.AllDevsConnected;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAllDevsConnected) THEN fAllDevsConnected(Self);
end;

procedure TRAS.Authenticate;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAuthenticate) THEN fAuthenticate(Self);
end;

procedure TRAS.AuthNotify;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAuthNotify) THEN fAuthNotify(Self);
end;

procedure TRAS.AuthRetry;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAuthRetry) THEN fAuthRetry(Self);
end;

procedure TRAS.AuthCallBack;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAuthCallBack) THEN fAuthCallBack(Self);
end;

procedure TRAS.AuthChangePassword;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAuthChangePassword) THEN fAuthChangePassword(Self);
end;

procedure TRAS.AuthProject;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAuthProject) THEN fAuthProject(Self);
end;

procedure TRAS.AuthLinkSpeed;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAuthLinkSpeed) THEN fAuthLinkSpeed(Self);
end;

procedure TRAS.AuthAck;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAuthAck) THEN fAuthAck(Self);
end;

procedure TRAS.ReAuthenticate;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fReAuthenticate) THEN fReAuthenticate(Self);
end;

procedure TRas.Authenticated;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fAuthenticated) THEN fAuthenticated(Self);
end;

procedure TRAS.PrepareforCallback;
begin
	if (fRASConn = 0) THEN Exit;
	If Assigned(fPrepareforCallback) THEN fPrepareforCallback(Self);
end;

procedure TRAS.WaitForModemReset;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fWaitForModemReset) THEN fWaitForModemReset(Self);
end;

procedure TRAS.InteractiveStarted;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fInteractiveStarted) THEN fInteractiveStarted(Self);
end;

procedure TRAS.RetryAuth;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fRetryAuth) THEN fRetryAuth(Self);
end;

procedure TRAS.PasswordExpired;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fPasswordExpired) THEN fPasswordExpired(Self);
end;

procedure TRAS.DisConnected;
var
	RasConnStatus : TRasConnStatus;
	ErrorStr : String;
begin
	If Assigned(fOnDisConnect) THEN
	begin
		fLastError := ERROR_DLL_NOT_FOUND ;
		if NOT LoadRASAPI then exit ;
		FillChar(RASConnStatus, SizeOf(RASConnStatus), #0);
		RASConnStatus.dwSize := Sizeof (RasConnStatus);
		fLastError := RasGetConnectStatus(RASConn, @RASConnStatus);
		ErrorStr := GetErrorString (fLastError);
		fOnDisConnect(Self,fLastError,ErrorStr);
	end;
end;

procedure TRAS.WaitingForCallBack;
begin
	If (fRASConn = 0) THEN Exit;
	If Assigned(fOnCallBack) THEN fOnCallBack(Self);
end;

procedure TRAS.ResetPerfStats ;
begin
	fStatsXmitCon := fStatsXmitTot ;	// tot counters are from IPL
	fStatsRecvCon := fStatsRecvTot ;
	fStatsXmitCur := 0 ;				// cur counters are current connection
	fStatsRecvCur := 0 ;
end ;

function TRAS.SearchDUA: boolean ;
var
	TempKey, Temp2Key: HKey;
	keyname, lockey: string ;
    flag: boolean ;
	NumSubKeys, NumValues, count: integer ;
    dwType, dwSize, Len: DWORD ;
begin
	result := false ;
	if NOT Win32Platform = VER_PLATFORM_WIN32_WINDOWS then exit ;
    DialUpAdaptors.Clear ;
    TempKey := 0;
    Temp2Key := 0;
	result := RegOpenKeyEx (HKEY_LOCAL_MACHINE, PChar(Reg_PerfStatEmum),
                                   0, KEY_READ, TempKey) = ERROR_SUCCESS ;
	if result then
        result := RegOpenKeyEx (HKEY_DYN_DATA, PChar(Reg_PerfStatStart),
                                   0, KEY_READ, Temp2Key) = ERROR_SUCCESS ;
	if result then
	begin
        NumSubKeys := 0 ;
        NumValues := 0 ;
        count := RegQueryInfoKey (TempKey, nil, nil, nil, @NumSubKeys,
                               nil, nil, @NumValues, nil, nil, nil, nil) ;
        if NumSubKeys <> 0 then
        begin
            SetString (lockey, nil, 33);
            for count := 0 to NumSubKeys - 1 do
            begin
                Len := 33 ;
                RegEnumKeyEx (TempKey, count, PChar(lockey), Len,
                                                    nil, nil, nil, nil);
                keyname := PChar (lockey) + '\' + fKeyDUNConn ;
  		        if RegQueryValueEx (Temp2Key, PChar(keyname), nil,
		  				@dwType, nil, @dwSize) = ERROR_SUCCESS then
                                     DialUpAdaptors.Add (PChar (lockey)) ;
            end ;
        end ;
    end ;
    if TempKey <> 0 then RegCloseKey (TempKey) ;
 	if Temp2Key <> 0 then RegCloseKey (Temp2Key) ;
    if DialUpAdaptors.Count <> 0 then DialUpAdaptors.Sort ;
end;


function TRAS.EnablePerfStats (start, search: boolean): boolean ;
var
	TempKey: HKey;
	keyname: string ;
	dwType, dwSize: DWORD ;
	TempData: Pointer ;

	function InitData (ValueName: string): boolean ;
	begin
		result := false ;
        ValueName := fKeyDUNAdap + '\' + ValueName ;
		if RegQueryValueEx (TempKey, PChar(ValueName), nil,
							@dwType, nil, @dwSize) = ERROR_SUCCESS then
		begin
		try		// read data but ignore it
			GetMem (TempData, dwSize) ;
			Result := RegQueryValueEx (TempKey, PChar(ValueName), nil,
							@dwType, TempData, @dwSize) = ERROR_SUCCESS ;
		finally
			FreeMem (TempData) ;
		    end ;
		end ;
	end ;

begin
	result := false ;
	if Win32Platform = VER_PLATFORM_WIN32s then exit ;
	result := true ;
	if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
	begin
        if search then
        begin
           SearchDUA ;
           if DialUpAdaptors.Count = 0 then
           begin
                result := false ;
                exit ;
           end ;
           fKeyDUNAdap := DialUpAdaptors [0] ; // set first
        end ;
		TempKey := 0;
		if start then
			keyname := Reg_PerfStatStart
		else
			keyname := Reg_PerfStatStop ;
		result := RegOpenKeyEx (HKEY_DYN_DATA, PChar(keyname), 0,
							  KEY_ALL_ACCESS, TempKey) = ERROR_SUCCESS ;
		if result then
		begin
			result := InitData (fKeyDUNXmit) ;
			if result then result := InitData (fKeyDUNRecv) ;
			if result then result := InitData (fKeyDUNConn) ;
			RegCloseKey (TempKey) ;
		end ;
	end ;
	if result then
	begin
		if start then result := GetPerfStats ;	// get counters
		ResetPerfStats ;			// set current
	end ;
end;

function TRAS.GetPerfStats: boolean ;
var
	TempKey: HKey;
	dwType,
    dwSize,
    connspd: DWORD ;
	perfdata: PPERF_DATA_BLOCK ;
	perfobj: PPERF_OBJECT_TYPE ;
	perfcdef: PPERF_COUNTER_DEFINITION ;
	perfmcdef: array [1..50] of PPERF_COUNTER_DEFINITION ;
	perfinst: PPERF_INSTANCE_DEFINITION ;
	perfcblk: PPERF_COUNTER_BLOCK ;
	regbuff,
    objptr,
    defptr,
    countptr: Pchar ;
	actualsize,
    DataType: Integer;
	objnr,
    instnr,
    countnr: integer ;
	datvalue: ^integer ;
	loopflag: boolean ;


 	function GetData (ValueName: string; var Info: DWORD): boolean ;
	begin
        ValueName := fKeyDUNAdap + '\' + ValueName ;
		dwSize := 4 ;	// data is four bytes of binary, aka a DWORD
		Result := RegQueryValueEx (TempKey, PChar(ValueName), nil,
							@dwType, @Info, @dwSize) = ERROR_SUCCESS;
	end ;

begin
	result := false ;
	if Win32Platform = VER_PLATFORM_WIN32s then exit ;
	if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then  // Win95/98
	begin
		TempKey := 0;
		result := RegOpenKeyEx (HKEY_DYN_DATA, PChar(Reg_PerfStatData),
                                    0, KEY_READ, TempKey) = ERROR_SUCCESS ;
		if result then
        begin
            result := GetData (fKeyDUNXmit, fStatsXmitTot) ;
	    	if result then result := GetData (fKeyDUNRecv, fStatsRecvTot) ;
		    if result then result := GetData (fKeyDUNConn, connspd) ;
			RegCloseKey (TempKey) ;
    		if result then
	    	begin
    			if fStatsXmitTot < fStatsXmitCon then ResetPerfStats ;
	    		if fStatsRecvTot < fStatsRecvCon then ResetPerfStats ;
		    	fStatsConnSpd := connspd ;
    			fStatsXmitCur := fStatsXmitTot - fStatsXmitCon ;
    			fStatsRecvCur := fStatsRecvTot - fStatsRecvCon ;
            end ;
		end ;
	end
	else
	begin
		DataType := REG_NONE;        // Windows NT performance data
		try

// start with small buffer, it will be increased in size if necessary the
// first time, to that required for the returned performance data
			if datasize = 0 then datasize := TOTALBYTES ;
			GetMem (regbuff, datasize) ;
			actualsize := datasize ;
			while RegQueryValueEx (HKEY_PERFORMANCE_DATA,
				pchar(Pdata_RAS_Total), nil, @DataType, PByte(regbuff),
	 									@actualsize) = ERROR_MORE_DATA do
			begin
				Freemem (regbuff) ;
				inc (datasize,  BYTEINCREMENT) ;  // increase buffers size by 1K
				GetMem (regbuff, datasize) ;
				actualsize := datasize ;
			end ;

		// get performance data block
			if actualsize < 100 then exit ;     // forget it
			pointer (perfdata) := regbuff ;   // PERF_DATA_BLOCK

	// get performance object type blocks
			if perfdata.numobjecttypes = 0 then exit ;   // no objects to process
			objptr := regbuff + perfdata.HeaderLength ;
			for objnr := 1 to perfdata.numobjecttypes do
			begin
				Application.ProcessMessages;
				pointer (perfobj) := objptr ;  // PERF_OBJECT_TYPE
			//  perfobj.ObjectNameTitleIndex   // not needed
				defptr := objptr + perfobj.HeaderLength ;

			// get performance counter definitions
				if perfobj.numcounters > 0 then
				begin

			// read through definitions, really looking for length
				for countnr := 1 to perfobj.numcounters do
					begin
						pointer (perfmcdef [countnr]) := defptr ;  // keep each definitition
						pointer (perfcdef) := defptr ;  // PERF_COUNTER_DEFINITION
						inc (defptr, perfcdef.bytelength) ;
						if countnr > 50 then exit ;
						Application.ProcessMessages;
					end ;

			// now get counter data, perhaps from multiple instances
					loopflag := true ;
					instnr := 1 ;
					while loopflag do
					begin
						if perfobj.numinstances >= 1 then
						begin
							pointer (perfinst) := defptr ;  // PERF_INSTANCE_DEFINITON
					// Instance Name := WideCharToString
					//	(PWideChar(defptr + perfinst.nameoffset))) ;
							inc (defptr, perfinst.bytelength) ;
						end ;

					// get counter block, then read actual data values
						countptr := defptr ;  // after reading through blocks
						pointer (perfcblk) := countptr ;  // PERF_COUNTER_BLOCK

					// get counter data, currently only doublewords
						for countnr := 1 to perfobj.numcounters do
						begin
							if perfmcdef [countnr].CounterNameTitleIndex =
														Pdata_Bytes_Xmit then
							begin
								pointer (datvalue) := countptr +
									perfmcdef [countnr].counteroffset ;
								if Datvalue^ > fStatsXmitCur then
											fStatsXmitCur := Datvalue^ ;
							end ;
							if perfmcdef [countnr].CounterNameTitleIndex =
														Pdata_Bytes_Recv then
							begin
								pointer (datvalue) := countptr +
									perfmcdef [countnr].counteroffset ;
								if Datvalue^ > fStatsRecvCur then
												fStatsRecvCur := Datvalue^ ;
							end ;
						end ;
						inc (defptr, perfcblk.bytelength) ;

					// check for more instances of these counters
						if perfobj.numinstances >= 1 then
						begin
							inc (instnr) ;
							if instnr > perfobj.numinstances then loopflag := false ;
						end
						else
							loopflag := false ;
					end ;
				end ;
				objptr := objptr + perfobj.totalbytelength ;
			end ;
			result := true ;
		finally
			if regbuff <> nil then Freemem (regbuff) ;
		end ;
	end ;
end;

Initialization
finalization

end.
