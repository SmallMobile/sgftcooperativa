{$F+}
Unit ras_api32;

Interface

Uses Windows, Dialogs;

{.$DEFINE NT_EXTNS}
{ this define detetmines whether the NT4 RAS extensions are supported. Do
not use this if compiling under NT4 but needing compatibility with Win9x }


{ Copyright (c) 1992, Microsoft Corporation, all rights reserved
  Note: The 'dwSize' member of a structure X must be set to sizeof(X)
  before calling the associated API, otherwise ERROR_INVALID_SIZE is
  returned.  The APIs determine the size using 2-byte packing (the
  default for Microsoft compilers when no /Zp<n> option is supplied).
  Users requiring non-default packing can use the 'dwSize' values
  listed next to each 'dwSize' member in place of sizeof(X). }

{
DELPHI RAS COMPONENT - version 3.0 - 17th March 1999

(C) 1996 Daniel Polistchuck
Updated by Angus Robertson, Magenta Systems Ltd, England
in early 1998, angus@magsys.co.uk, http://www.magsys.co.uk
Copyright Magenta Systems Ltd

Compatible with Delphi 2, 3 and 4, tested with Win95, 98 and NT4

Added RasMonitorDlg (NT only)
Added .DLL since needed for NT4
Added phone book stuff
Removed explicit DLL calls so application will run without RAS installed
Added extra literals

Changes in 2.8

WARNING!!!!
Changed WINVER41 to NT_EXTNS so code can be compiled under NT4 but using only
   Win9x functions and structures
Added RASSUBENTRY, RasGetSubEntryProperties for multi-link connections, NT only
Added various AUTODIAL things, NT only


}

Const
  UNLEN = 256;
  PWLEN = 256;
  DNLEN = 15;
  NETBIOS_NAME_LEN  	= 16; // Angus
  RAS_MaxEntryName	  	=  256;
  RAS_MaxDeviceName	 	=  128;
  RAS_MaxDeviceType 	=  16;
//RAS_MaxParamKey 		=  32;
//RAS_MaxParamValue 	= 128;
  RAS_MaxPhoneNumber 	= 128;
  RAS_MaxCallbackNumber =  RAS_MaxPhoneNumber;
  RAS_MaxIpAddress 		= 15;  // ANGUS
  RAS_MaxIpxAddress 	= 21;  // ANGUS
  RAS_MaxAreaCode 		= 10;
  RAS_MaxPadType 		= 32;
  RAS_MaxX25Address 	= 200;
  RAS_MaxFacilities 	= 200;
  RAS_MaxUserData 		= 200;

Type
//UINT = Word;
  PHRASConn = ^HRASConn;
  HRASConn = DWORD;

{ Pass this string to the RegisterWindowMessage() API to get the message
** number that will be used for notifications on the hwnd you pass to the
** RasDial() API.  WM_RASDIALEVENT is used only if a unique message cannot be
** registered. }

const
  RASDialEvent 		= 'RASDialEvent';
  WM_RASDialEvent 	= $0CCCD;
  { Enumerates intermediate states to a Connection.  (See RasDial) }
  RASCS_Paused 		= $1000;
  RASCS_Done		= $2000;	 // =8192

  RASBase = 600;
  Success = 0;
{ Error Codes }
  PENDING								= (RASBase+0);
  ERROR_INVALID_PORT_HANDLE				= (RASBase+1);
  ERROR_PORT_ALREADY_OPEN				= (RASBase+2);
  ERROR_BUFFER_TOO_SMALL				= (RASBase+3);
  ERROR_WRONG_INFO_SPECIFIED			= (RASBase+4);
  ERROR_CANNOT_SET_PORT_INFO			= (RASBase+5);
  ERROR_PORT_NOT_ConnECTED				= (RASBase+6);
  ERROR_EVENT_INVALID					= (RASBase+7);
  ERROR_DEVICE_DOES_NOT_EXIST			= (RASBase+8);
  ERROR_DEVICETYPE_DOES_NOT_EXIST		= (RASBase+9);
  ERROR_INVALID_BUFFER					= (RASBase+10);
  ERROR_ROUTE_NOT_AVAILABLE				= (RASBase+11);
  ERROR_ROUTE_NOT_ALLOCATED				= (RASBase+12);
  ERROR_INVALID_COMPRESSION_SPECIFIED	= (RASBase+13);
  ERROR_OUT_OF_BUFFERS					= (RASBase+14);
  ERROR_PORT_NOT_FOUND					= (RASBase+15);
  ERROR_ASYNC_REQUEST_PENDING			= (RASBase+16);
  ERROR_ALREADY_DISCONNECTING			= (RASBase+17);
  ERROR_PORT_NOT_OPEN					= (RASBase+18);
  ERROR_PORT_DISCONNECTED				= (RASBase+19);
  ERROR_NO_ENDPOINTS					= (RASBase+20);
  ERROR_CANNOT_OPEN_PHONEBOOK			= (RASBase+21);
  ERROR_CANNOT_LOAD_PHONEBOOK			= (RASBase+22);
  ERROR_CANNOT_FIND_PHONEBOOK_ENTRY		= (RASBase+23);
  ERROR_CANNOT_WRITE_PHONEBOOK			= (RASBase+24);
  ERROR_CORRUPT_PHONEBOOK				= (RASBase+25);
  ERROR_CANNOT_LOAD_STRING				= (RASBase+26);
  ERROR_KEY_NOT_FOUND					= (RASBase+27);
  ERROR_DISCONNECTION					= (RASBase+28);
  ERROR_REMOTE_DISCONNECTION			= (RASBase+29);
  ERROR_HARDWARE_FAILURE				= (RASBase+30);
  ERROR_USER_DISCONNECTION				= (RASBase+31);
  ERROR_INVALID_SIZE					= (RASBase+32);
  ERROR_PORT_NOT_AVAILABLE				= (RASBase+33);
  ERROR_CANNOT_PROJECT_CLIENT			= (RASBase+34);
  ERROR_UNKNOWN							= (RASBase+35);
  ERROR_WRONG_DEVICE_ATTACHED			= (RASBase+36);
  ERROR_BAD_STRING						= (RASBase+37);
  ERROR_REQUEST_TIMEOUT					= (RASBase+38);
  ERROR_CANNOT_GET_LANA					= (RASBase+39);
  ERROR_NETBIOS_ERROR					= (RASBase+40);
  ERROR_SERVER_OUT_OF_RESOURCES			= (RASBase+41);
  ERROR_NAME_EXISTS_ON_NET				= (RASBase+42);
  ERROR_SERVER_GENERAL_NET_FAILURE		= (RASBase+43);
  WARNING_MSG_ALIAS_NOT_ADDED			= (RASBase+44);
  ERROR_AUTH_INTERNAL					= (RASBase+45);
  ERROR_RESTRICTED_LOGON_HOURS			= (RASBase+46);
  ERROR_ACCT_DISABLED					= (RASBase+47);
  ERROR_PASSWD_EXPIRED					= (RASBase+48);
  ERROR_NO_DIALIN_PERMISSION			= (RASBase+49);
  ERROR_SERVER_NOT_RESPONDING			= (RASBase+50);
  ERROR_FROM_DEVICE						= (RASBase+51);
  ERROR_UNRECOGNIZED_RESPONSE			= (RASBase+52);
  ERROR_MACRO_NOT_FOUND					= (RASBase+53);
  ERROR_MACRO_NOT_DEFINED				= (RASBase+54);
  ERROR_MESSAGE_MACRO_NOT_FOUND			= (RASBase+55);
  ERROR_DEFAULTOFF_MACRO_NOT_FOUND		= (RASBase+56);
  ERROR_FILE_COULD_NOT_BE_OPENED		= (RASBase+57);
  ERROR_DEVICENAME_TOO_LONG				= (RASBase+58);
  ERROR_DEVICENAME_NOT_FOUND			= (RASBase+59);
  ERROR_NO_RESPONSES					= (RASBase+60);
  ERROR_NO_COMMAND_FOUND				= (RASBase+61);
  ERROR_WRONG_KEY_SPECIFIED				= (RASBase+62);
  ERROR_UNKNOWN_DEVICE_TYPE				= (RASBase+63);
  ERROR_ALLOCATING_MEMORY				= (RASBase+64);
  ERROR_PORT_NOT_CONFIGURED				= (RASBase+65);
  ERROR_DEVICE_NOT_READY				= (RASBase+66);
  ERROR_READING_INI_FILE				= (RASBase+67);
  ERROR_NO_ConnECTION					= (RASBase+68);
  ERROR_BAD_USAGE_IN_INI_FILE			= (RASBase+69);
  ERROR_READING_SECTIONNAME				= (RASBase+70);
  ERROR_READING_DEVICETYPE				= (RASBase+71);
  ERROR_READING_DEVICENAME				= (RASBase+72);
  ERROR_READING_USAGE					= (RASBase+73);
  ERROR_READING_MAXCONNECTBPS			= (RASBase+74);
  ERROR_READING_MAXCARRIERBPS			= (RASBase+75);
  ERROR_LINE_BUSY						= (RASBase+76);
  ERROR_VOICE_ANSWER					= (RASBase+77);
  ERROR_NO_ANSWER						= (RASBase+78);
  ERROR_NO_CARRIER						= (RASBase+79);
  ERROR_NO_DIALTONE						= (RASBase+80);
  ERROR_IN_COMMAND						= (RASBase+81);
  ERROR_WRITING_SECTIONNAME				= (RASBase+82);
  ERROR_WRITING_DEVICETYPE				= (RASBase+83);
  ERROR_WRITING_DEVICENAME				= (RASBase+84);
  ERROR_WRITING_MAXConnECTBPS			= (RASBase+85);
  ERROR_WRITING_MAXCARRIERBPS			= (RASBase+86);
  ERROR_WRITING_USAGE					= (RASBase+87);
  ERROR_WRITING_DEFAULTOFF				= (RASBase+88);
  ERROR_READING_DEFAULTOFF				= (RASBase+89);
  ERROR_EMPTY_INI_FILE					= (RASBase+90);
  ERROR_AUTHENTICATION_FAILURE			= (RASBase+91);
  ERROR_PORT_OR_DEVICE					= (RASBase+92);
  ERROR_NOT_BINARY_MACRO				= (RASBase+93);
  ERROR_DCB_NOT_FOUND					= (RASBase+94);
  ERROR_STATE_MACHINES_NOT_STARTED		= (RASBase+95);
  ERROR_STATE_MACHINES_ALREADY_STARTED	= (RASBase+96);
  ERROR_PARTIAL_RESPONSE_LOOPING		= (RASBase+97);
  ERROR_UNKNOWN_RESPONSE_KEY			= (RASBase+98);
  ERROR_RECV_BUF_FULL					= (RASBase+99);
  ERROR_CMD_TOO_LONG					= (RASBase+100);
  ERROR_UNSUPPORTED_BPS                 = (RASBase+101);
  ERROR_UNEXPECTED_RESPONSE             = (RASBase+102);
  ERROR_INTERACTIVE_MODE                = (RASBase+103);
  ERROR_BAD_CALLBACK_NUMBER             = (RASBase+104);
  ERROR_INVALID_AUTH_STATE              = (RASBase+105);
  ERROR_WRITING_INITBPS                 = (RASBase+106);
  ERROR_X25_DIAGNOSTIC                  = (RASBase+107);
  ERROR_ACCT_EXPIRED                    = (RASBase+108);
  ERROR_CHANGING_PASSWORD               = (RASBase+109);
  ERROR_OVERRUN                         = (RASBase+110);
  ERROR_RASMAN_CANNOT_INITIALIZE        = (RASBase+111);
  ERROR_BIPLEX_PORT_NOT_AVAILABLE       = (RASBase+112);
  ERROR_NO_ACTIVE_ISDN_LINES            = (RASBase+113);
  ERROR_NO_ISDN_CHANNELS_AVAILABLE      = (RASBase+114);
  ERROR_TOO_MANY_LINE_ERRORS            = (RASBase+115);
  ERROR_IP_CONFIGURATION                = (RASBase+116);
  ERROR_NO_IP_ADDRESSES                 = (RASBase+117);
  ERROR_PPP_TIMEOUT                     = (RASBase+118);
  ERROR_PPP_REMOTE_TERMINATED           = (RASBase+119);
  ERROR_PPP_NO_PROTOCOLS_CONFIGURED     = (RASBase+120);
  ERROR_PPP_NO_RESPONSE                 = (RASBase+121);
  ERROR_PPP_INVALID_PACKET              = (RASBase+122);
  ERROR_PHONE_NUMBER_TOO_LONG           = (RASBase+123);
  ERROR_IPXCP_NO_DIALOUT_CONFIGURED     = (RASBase+124);
  ERROR_IPXCP_NO_DIALIN_CONFIGURED      = (RASBase+125);
  ERROR_IPXCP_DIALOUT_ALREADY_ACTIVE    = (RASBase+126);
  ERROR_ACCESSING_TCPCFGDLL             = (RASBase+127);
  ERROR_NO_IP_RAS_ADAPTER               = (RASBase+128);
  ERROR_SLIP_REQUIRES_IP                = (RASBase+129);
  ERROR_PROJECTION_NOT_COMPLETE         = (RASBase+130);
  ERROR_PROTOCOL_NOT_CONFIGURED         = (RASBase+131);
  ERROR_PPP_NOT_CONVERGING              = (RASBase+132);
  ERROR_PPP_CP_REJECTED                 = (RASBase+133);
  ERROR_PPP_LCP_TERMINATED              = (RASBase+134);
  ERROR_PPP_REQUIRED_ADDRESS_REJECTED   = (RASBase+135);
  ERROR_PPP_NCP_TERMINATED              = (RASBase+136);
  ERROR_PPP_LOOPBACK_DETECTED           = (RASBase+137);
  ERROR_PPP_NO_ADDRESS_ASSIGNED         = (RASBase+138);
  ERROR_CANNOT_USE_LOGON_CREDENTIALS    = (RASBase+139);
  ERROR_TAPI_CONFIGURATION              = (RASBase+140);
  ERROR_NO_LOCAL_ENCRYPTION             = (RASBase+141);
  ERROR_NO_REMOTE_ENCRYPTION            = (RASBase+142);
  ERROR_REMOTE_REQUIRES_ENCRYPTION      = (RASBase+143);
  ERROR_IPXCP_NET_NUMBER_CONFLICT       = (RASBase+144);
  ERROR_INVALID_SMM                     = (RASBase+145);
  ERROR_SMM_UNINITIALIZED               = (RASBase+146);
  ERROR_NO_MAC_FOR_PORT                 = (RASBase+147);
  ERROR_SMM_TIMEOUT                     = (RASBase+148);
  ERROR_BAD_PHONE_NUMBER                = (RASBase+149);
  ERROR_WRONG_MODULE                    = (RASBase+150);
  ERROR_INVALID_CALLBACK_NUMBER         = (RASBase+151);
  ERROR_SCRIPT_SYNTAX                   = (RASBase+152);
  ERROR_HANGUP_FAILED                   = (RASBase+153);
  RASBaseEnd                            = (RASBase+153);

Const
  RASCS_OpenPort = 0;
  RASCS_PortOpened = 1;
  RASCS_ConnectDevice = 2;
  RASCS_DeviceConnected = 3;
  RASCS_AllDevicesConnected = 4;
  RASCS_Authenticate = 5;
  RASCS_AuthNotify = 6;
  RASCS_AuthRetry = 7;
  RASCS_AuthCallback = 8;
  RASCS_AuthChangePassword = 9;
  RASCS_AuthProject = 10;
  RASCS_AuthLinkSpeed = 11;
  RASCS_AuthAck = 12;
  RASCS_ReAuthenticate = 13;
  RASCS_Authenticated = 14;
  RASCS_PrepareForCallback = 15;
  RASCS_WaitForModemReset = 16;
  RASCS_WaitForCallback = 17;
  RASCS_Projected = 18;
  RASCS_StartAuthentication = 19;   // following three are Win95 only
  RASCS_CallbackComplete = 20;
  RASCS_LogonNetwork = 21;

  RASCS_Interactive		 	= RASCS_Paused;
  RASCS_RetryAuthentication = RASCS_Paused + 1;
  RASCS_CallbackSetByCaller = RASCS_Paused + 2;
  RASCS_PasswordExpired	 	= RASCS_Paused + 3;

  RASCS_Connected	 = RASCS_Done;        // 8192
  RASCS_DisConnected = RASCS_Done + 1;    // 8193

Type
{ Identifies an active RAS Connection.  (See RasConnectEnum) }
  PRASConn = ^TRASConn;
  TRASConn = record
	dwSize: DWORD;
	rasConn: HRASConn;
	szEntryName: Array[0..RAS_MaxEntryName] Of Char;
	szDeviceType : Array[0..RAS_MaxDeviceType] Of Char;
	szDeviceName : Array [0..RAS_MaxDeviceName] Of char;
{$IFDEF NT_EXTNS}
    szPhonebook: Array[0..MAX_PATH - 1] Of Char;
    dwSubEntry: Longint;
{$ENDIF}
  end;

  PRASConnStatus = ^TRASConnStatus;
  TRASConnStatus = Record
	dwSize: LongInt;
	rasConnstate: Word;
	dwError: LongInt;
	szDeviceType: Array[0..RAS_MaxDeviceType] Of Char;
	szDeviceName: Array[0..RAS_MaxDeviceName] Of Char;
{$IFDEF NT_EXTNS}
    szPhoneNumber: Array[0..RAS_MaxPhoneNumber] Of Char;
{$ENDIF}
  End;

  PRASDIALEXTENSIONS= ^TRASDIALEXTENSIONS;
  TRASDIALEXTENSIONS= Record
	dwSize: DWORD;
	dwfOptions: DWORD;
	hwndParent: HWnd;
	reserved: DWORD;
	end;

  PRASDialParams = ^TRASDialParams;
  TRASDialParams = Record
	dwSize: DWORD;
	szEntryName: Array[0..RAS_MaxEntryName] Of Char;
	szPhoneNumber: Array[0..RAS_MaxPhoneNumber] Of Char;
	szCallbackNumber: Array[0..RAS_MaxCallbackNumber] Of Char;
	szUserName: Array[0..UNLEN] Of Char;
	szPassword: Array[0..PWLEN] Of Char;
	szDomain: Array[0..DNLEN] Of Char;
{$IFDEF NT_EXTNS}
    dwSubEntry: Longint;
    dwCallbackId: Longint;
{$ENDIF}
  end;

  PRASEntryName = ^TRASEntryName;
  TRASEntryName = Record
	dwSize: LongInt;
	szEntryName: Array[0..RAS_MaxEntryName] Of Char;
//	Reserved: Byte;
  End;

  PRASRASMONITORDLG= ^TRASRASMONITORDLG;	// ANGUS 5Feb98
  TRASRASMONITORDLG= Record
	dwSize: DWORD ;
	hwndOwner: HWnd;
	dwFlags: DWORD ;
	dwStartPage: DWORD ;
	xDlg: LongInt ;
	yDlg: LongInt ;
	dwError: DWORD ;
	reserved: DWORD ;
	reserved2: DWORD ;
	End;

// Describes the result of a PPP NBF (NetBEUI) projection

  PRasPppNbf = ^TRasPppNbf;
  TRasPppNbf = record
	dwSize: Longint;
	dwError: Longint;
	dwNetBiosError: Longint;
	szNetBiosError: Array[0..NETBIOS_NAME_LEN] of Char;
	szWorkstationName: Array[0..NETBIOS_NAME_LEN] of Char;
	bLana: Byte;
  end;


// Describes the results of a PPP IPX (Internetwork Packet Exchange)
// projection.

  PRasPppIpx = ^TRasPppIpx;
  TRasPppIpx = record
	dwSize: Longint;
	dwError: Longint;
	szIpxAddress: Array[0..RAS_MaxIpxAddress] of Char;
  end;


// Describes the results of a PPP IP (Internet) projection.

  PRasPppIp = ^TRasPppIp;
  TRasPppIp = record
	dwSize: Longint;
	dwError: Longint;
	szIpAddress: Array[0..RAS_MaxIpAddress] of Char;
	szServerIpAddress: Array[0..RAS_MaxIpAddress] of Char;
  end ;

// Describes the results of a PPP LCP/multi-link negotiation.

  PRasPppLcp = ^TRasPppLcp;
  TRasPppLcp = record
	dwSize: Longint;
	fBundled: LongBool;
  end;


// Describes the results of a SLIP (Serial Line IP) projection.

  PRasSlip = ^TRasSlip;
  TRasSlip = record
	dwSize: Longint;
	dwError: Longint;
	szIpAddress: Array[0..RAS_MaxIpAddress] of Char;
  end;

//  Information describing a RAS-capable device - ie modems or ISDN cards

  PRasDevInfo = ^TRasDevInfo;
  TRasDevInfo = record
	dwSize: Longint;
	szDeviceType: Array[0..RAS_MaxDeviceType] of Char;
	szDeviceName: Array[0..RAS_MaxDeviceName] of Char;
  end;


// RAS Country Information (currently retreieved from TAPI).

  PRasCtryInfo = ^TRasCtryInfo;
  TRasCtryInfo = record
	dwSize,
	dwCountryID,
	dwNextCountryID,
	dwCountryCode,
	dwCountryNameOffset: Longint;
  end;


// A RAS IP Address.

  PRasIPAddr = ^TRasIPAddr;
  TRasIPAddr = record
	a, b, c, d: Byte;
  end;


// A RAS phonebook entry.

  PRasEntry = ^TRasEntry;
  TRasEntry = record
	dwSize,
	dwfOptions,
	//
	// Location/phone number.
	//
	dwCountryID,
	dwCountryCode: Longint;
	szAreaCode: array[0.. RAS_MaxAreaCode] of Char;
	szLocalPhoneNumber: array[0..RAS_MaxPhoneNumber] of Char;
	dwAlternatesOffset: Longint;
	//
// PPP/Ip
	//
	ipaddr,
	ipaddrDns,
	ipaddrDnsAlt,
	ipaddrWins,
	ipaddrWinsAlt: TRasIPAddr;
	//
	// Framing
	//
	dwFrameSize,
	dwfNetProtocols,
	dwFramingProtocol: Longint;
	//
	// Scripting
	//
	szScript: Array[0..MAX_PATH - 1] of Char;
	//
	// AutoDial
	//
	szAutodialDll: Array [0..MAX_PATH - 1] of Char;
	szAutodialFunc: Array [0..MAX_PATH - 1] of Char;
	//
	// Device
	//
	szDeviceType: Array [0..RAS_MaxDeviceType] of Char;
	szDeviceName: Array [0..RAS_MaxDeviceName] of Char;
	//
	// X.25
	//
	szX25PadType: Array [0..RAS_MaxPadType] of Char;
	szX25Address: Array [0..RAS_MaxX25Address] of Char;
	szX25Facilities: Array [0..RAS_MaxFacilities] of Char;
	szX25UserData: Array [0..RAS_MaxUserData] of Char;
	dwChannels: Longint;
	//
	// Reserved
	//
	dwReserved1,
	dwReserved2: Longint;
	//
	// Multilink
	//
{$IFDEF NT_EXTNS}
	dwSubEntries,
	dwDialMode,
	dwDialExtraPercent,
	dwDialExtraSampleSeconds,
	dwHangUpExtraPercent,
	dwHangUpExtraSampleSeconds: Longint;
	//
	// Idle timeout
	//
	dwIdleDisconnectSeconds: Longint;
{$ENDIF}
  end;

  PRasProjection = ^TRasProjection;
  TRasProjection = Integer;



const

// TRasEntry 'dwfOptions' bit flags.

  RASEO_UseCountryAndAreaCodes 	= $00000001;
  RASEO_SpecificIpAddr		 	= $00000002;
  RASEO_SpecificNameServers		= $00000004;
  RASEO_IpHeaderCompression		= $00000008;
  RASEO_RemoteDefaultGateway	= $00000010;
  RASEO_DisableLcpExtensions	= $00000020;
  RASEO_TerminalBeforeDial	 	= $00000040;
  RASEO_TerminalAfterDial	  	= $00000080;
  RASEO_ModemLights				= $00000100;
  RASEO_SwCompression		  	= $00000200;
  RASEO_RequireEncryptedPw	 	= $00000400;
  RASEO_RequireMsEncryptedPw	= $00000800;
  RASEO_RequireDataEncryption  	= $00001000;
  RASEO_NetworkLogon			= $00002000;
  RASEO_UseLogonCredentials		= $00004000;
  RASEO_PromoteAlternates	  	= $00008000;
  RASEO_SecureLocalFiles		= $00010000;

// TRasEntry 'dwfNetProtocols' bit flags. (session negotiated protocols)

  RASNP_Netbeui = $00000001;  // Negotiate NetBEUI
  RASNP_Ipx	 	= $00000002;  // Negotiate IPX
  RASNP_Ip	  	= $00000004;  // Negotiate TCP/IP

// TRasEntry 'dwFramingProtocols' (framing protocols used by the server)

  RASFP_Ppp  = $00000001;  // Point-to-Point Protocol (PPP)
  RASFP_Slip = $00000002;  // Serial Line Internet Protocol (SLIP)
  RASFP_Ras  = $00000004;  // Microsoft proprietary protocol

// TRasEntry 'szDeviceType' strings

  RASDT_Modem	= 'modem';
  RASDT_Isdn  	= 'isdn';
  RASDT_X25		= 'x25';
  RASDT_Vpn     = 'vpn' ;
  RASDT_Pad     = 'pad' ;


// Protocol code to projection data structure mapping.

// TRasProjection literals for RasGetProjectionInfo
  RASP_Amb 		= $10000 ;
  RASP_PppNbf 	= $803F ;
  RASP_PppIpx 	= $802B ;
  RASP_PppIp 	= $8021 ;
  RASP_PppLcp 	= $C021 ;
  RASP_Slip 	= $20000 ;


// following structures are NT4 only, some DUN 1.2

//Flags for RasConnectionNotification()

  RASCN_Connection       = $00000001;
  RASCN_Disconnection    = $00000002;
  RASCN_BandwidthAdded   = $00000004;
  RASCN_BandwidthRemoved = $00000008;

// TRasEntry 'dwDialMode' values.

  RASEDM_DialAll      = 1;
  RASEDM_DialAsNeeded = 2;

// TRasEntry 'dwIdleDisconnectSeconds' constants

  RASIDS_Disabled       = $ffffffff;
  RASIDS_UseGlobalValue = 0;

type

// AutoDial DLL function parameter block

  LpRasADParams = ^TRasADParams;
  TRasADParams = record
    dwSize: Longint;
    hwndOwner: THandle;
    dwFlags: Longint;
    xDlg,
    yDlg: Longint;
  end;

const

// AutoDial DLL function parameter block 'dwFlags.'

  RASADFLG_PositionDlg = $00000001;

// A RAS phone book multilinked sub-entry - NT4 only

{$IFDEF NT_EXTNS}

type

  LpRasSubEntry = ^TRasSubEntry;
  TRasSubEntry = record
    dwSize,
    dwfFlags: Longint;
    //
    // Device
    //
    szDeviceType: Array[0..RAS_MaxDeviceType] Of Char;
    szDeviceName: Array[0..RAS_MaxDeviceName] Of Char;
    //
    // Phone numbers
    //
    szLocalPhoneNumber: Array[0..RAS_MaxPhoneNumber] Of Char;
    dwAlternateOffset: Longint;
  end;

  LpRasCredentials = ^TRasCredentials;
  TRasCredentials = record
    dwSize,
    dwMask: Longint;
    szUserName: Array[0..UNLEN] Of Char;
    zPassword: Array[0..PWLEN ] Of Char;
    szDomain: Array[0..DNLEN] Of Char;
  end;

const

// TRasCredentials 'dwMask' values

  RASCM_UserName = $00000001;
  RASCM_Password = $00000002;
  RASCM_Domain   = $00000004;

type

// AutoDial address properties

  LPRasAutoDialEntry = ^TRasAutoDialEntry;
  TRasAutoDialEntry = record
    dwSize,
    dwFlags,
    dwDialingLocation: Longint;
    szEntry: Array[0..RAS_MaxEntryName] Of Char;
  end;


const

//  AutoDial control parameter values for
//  Ras(Get,Set)AutodialParam.

  RASADP_DisableConnectionQuery  = 0;
  RASADP_LoginSessionDisable     = 1;
  RASADP_SavedAddressesLimit     = 2;
  RASADP_FailedConnectionTimeout = 3;
  RASADP_ConnectionQueryTimeout  = 4;
{$ENDIF}


var

RasDial: Function (
	lpRasDialExtensions : PRASDIALEXTENSIONS ;	// pointer to function extensions data
	lpszPhonebook: PChar;	// pointer to full path and filename of phonebook file
	lpRasDialParams : PRASDIALPARAMS;	// pointer to calling parameters data
	dwNotifierType : DWORD;	// specifies type of RasDial event handler
	lpvNotifier: DWORD;	// specifies a handler for RasDial events
	var rasConn: HRASConn 	// pointer to variable to receive connection handle
	): DWORD; stdcall;

RasEnumConnections: Function (
	RASConn: PrasConn;		{ buffer to receive Connections data }
	var BufSize: DWord;		{ size in bytes of buffer }
	var Connections: DWord	{ number of Connections written to buffer }
	): LongInt; stdcall;

RasEnumEntries: Function (
	reserved: PChar;	// reserved, must be NULL
	lpszPhonebook: PChar  ;	// pointer to full path and filename of phonebook file
	lprasentryname: PRASENTRYNAME ;	// buffer to receive phonebook entries
	var lpcb : 	DWORD;// size in bytes of buffer
	var lpcEntries : DWORD// number of entries written to buffer
	) : DWORD; stdcall;

RasGetConnectStatus: Function (
	RASConn: hrasConn;	{ handle to Remote Access Connection of interest }
	RASConnStatus: PRASConnStatus	{ buffer to receive status data }
	): LongInt; stdcall;

RasGetErrorString: Function (
	ErrorCode: DWord;	{ error code to get string for }
	szErrorString: PChar;	{ buffer to hold error string }
	BufSize: DWord	{ sizeof buffer }
	): LongInt; stdcall;

RasHangUp: Function (
	RASConn: hrasConn	{ handle to the Remote Access Connection to hang up }
	): LongInt; stdcall;

RasGetEntryDialParams: Function (		  // ANGUS
	lpszPhonebook:PChar;	// pointer to the full path and filename of the phonebook file
	var lprasdialparams: TRASDIALPARAMS;	// pointer to a structure that receives the connection parameters
	VAR lpfPassword : BOOL	// indicates whether the user's password was retrieved
	): DWORD; stdcall;

RasSetEntryDialParams: Function (		  // ANGUS
	lpszPhonebook:PChar;	// pointer to the full path and filename of the phonebook file
	var lprasdialparams: TRASDIALPARAMS;	// pointer to a structure that contains the connection parameters
	fRemovePassword: BOOL	// // indicates whether to remove password from entry's parameters
	): DWORD; stdcall;

RasMonitorDlg: Function (
	lpszDeviceName:PChar;	// pointer to the name of the device to display initially
	VAR lprasmonitordlg:TRASRASMONITORDLG	// pointer to a structure with I/O parms
	): LongInt; stdcall;

RasEditPhonebookEntry: Function (	 // ANGUS
	hWndParent : HWND;	 // handle to the parent window of the dialog box
	lpszPhonebook : PChar; // pointer to the full path and filename of the phonebook file
	lpszEntryName : PChar  // pointer to the phonebook entry name
	) : DWORD; stdcall;

RasCreatePhonebookEntry: Function (	// ANGUS
	hWndParent : HWND;	// handle to the parent window of the dialog box
	lpszPhonebook : PChar // pointer to the full path and filename of the phonebook file
	) : DWORD; stdcall;

RasGetProjectionInfo: Function (	// ANGUS
	hConn: HRasConn;
	rasproj: TRasProjection;
	lpProjection: Pointer;
	var lpcb: Longint
	): Longint; stdcall;

RasGetCountryInfo: Function (	// ANGUS  -  from RNAPH.DLL
	var lpCtryInfo: TRasCtryInfo;
	var lpdwSize: Longint
	): Longint; stdcall;

RasGetEntryProperties: Function (	// ANGUS	 -  from RNAPH.DLL
	lpszPhonebook,
	szEntry: PChar;
	  lpbEntry: Pointer;
	var lpdwEntrySize: Longint;
	lpbDeviceInfo: Pointer;
	var lpdwDeviceInfoSize: Longint
	): Longint; stdcall;

RasSetEntryProperties: Function (	// ANGUS	-  from RNAPH.DLL
	lpszPhonebook,
	szEntry: PChar;
	  lpbEntry: Pointer;
	dwEntrySize: Longint;
	lpbDeviceInfo: Pointer;
	dwDeviceInfoSize: Longint
	): Longint; stdcall;

RasRenameEntry: Function (	// ANGUS		 -  from RNAPH.DLL
	lpszPhonebook,
	szEntryOld,
	szEntryNew: PChar
	): Longint; stdcall;

RasDeleteEntry: Function (	// ANGUS		  -  from RNAPH.DLL
	lpszPhonebook,
	szEntry: PChar
	): Longint; stdcall;

RasValidateEntryName: Function (	// ANGUS	 -  from RNAPH.DLL
	lpszPhonebook,
	szEntry: PChar
	): Longint; stdcall;

RasEnumDevices: Function (	// ANGUS	  -  from RNAPH.DLL
	lpBuff: PRasDevInfo;
	var lpcbSize: Longint;
	var lpcDevices: Longint
	): Longint; stdcall;

// following functions are NT4 only
{$IFDEF NT_EXTNS}

RasGetSubEntryHandle: Function (  	// ANGUS     - NT4 only
    hrasconn: HRasConn;
    dwSubEntry: Longint;
    var lphrasconn: HRasConn
    ): Longint; stdcall;

RasGetCredentials: Function (  	// ANGUS     - NT4 only
    lpszPhoneBook,
    lpszEntry: PChar;
    var lpCredentials: TRasCredentials
    ): Longint; stdcall;

RasSetCredentials: Function (  	// ANGUS     - NT4 only
    lpszPhoneBook,
    lpszEntry: PChar;
    var lpCredentials: TRasCredentials;
    fRemovePassword: LongBool
    ): Longint; stdcall;

RasConnectionNotification: Function (  	// ANGUS     - NT4 only
  hrasconn: HRasConn;
  hEvent: THandle;
  dwFlags: Longint
  ): Longint; stdcall;

RasGetSubEntryProperties: Function (  	// ANGUS     - NT4 only
    lpszPhoneBook,
    lpszEntry: PChar;
    dwSubEntry: Longint;
    var lpRasSubEntry: TRasSubEntry;
    var lpdwcb: Longint;
    p: Pointer;
    var lpdw: Longint
    ): Longint; stdcall;

RasSetSubEntryProperties: Function (  	// ANGUS     - NT4 only
    lpszPhoneBook,
    lpszEntry: PChar;
    dwSubEntry: Longint;
    var lpRasSubEntry: TRasSubEntry;
    dwcb: Longint;
    p: Pointer;
    dw: Longint
    ): Longint; stdcall;

RasGetAutodialAddress: Function (  	// ANGUS     - NT4 only
    lpszAddress: PChar;
    lpdwReserved: Pointer;
    lpAutoDialEntries: LPRasAutoDialEntry;
    var lpdwcbAutoDialEntries: Longint;
    var lpdwcAutoDialEntries: Longint
    ): Longint; stdcall;

RasSetAutodialAddress: Function (  	// ANGUS     - NT4 only
    lpszAddress: PChar;
    dwReserved: Longint;
    lpAutoDialEntries: LPRasAutoDialEntry;
    dwcbAutoDialEntries: Longint;
    dwcAutoDialEntries: Longint
    ): Longint; stdcall;

RasEnumAutodialAddresses: Function (  	// ANGUS     - NT4 only
    lppAddresses: Pointer;
    var lpdwcbAddresses: Longint;
    var lpdwAddresses: Longint
    ): Longint; stdcall;

RasGetAutodialEnable: Function (  	// ANGUS     - NT4 only
    dwDialingLocation: Longint;
    var lpfEnabled: LongBool
    ): Longint; stdcall;

RasSetAutodialEnable: Function (  	// ANGUS     - NT4 only
    dwDialingLocation: Longint;
    fEnabled: LongBool
    ): Longint; stdcall;

RasGetAutodialParam: Function (  	// ANGUS     - NT4 only
    dwKey: Longint;
    lpvValue: Pointer;
    var lpdwcbValue: Longint
    ): Longint; stdcall;

RasSetAutodialParam: Function (  	// ANGUS     - NT4 only
    dwKey: Longint;
    lpvValue: Pointer;
    dwcbValue: Longint
    ): Longint; stdcall;

{$ENDIF}


const
  RASAPI_DLL = 'RASAPI32.DLL';	// Angus - WinNT needs file extension
  RNAPH_DLL  = 'RNAPH.DLL';		// Angus - functions may be in rasapi32

implementation

end.

