unit demo;

{

This application demos the TRAS component.  While it may be installed
in the component library and dropped on a form, this example creates
the component in code.

Please note this is not intended to be a fully functioning application
and may not be distributed as such.

Created by Angus Robertson, Magenta Systems Ltd, England
in early 1998, delphi@magsys.co.uk, http://www.magsys.co.uk/delphi/
Copyright Magenta Systems Ltd

Last updated: 28th March 1999

Compatible with Delphi 2, 3 and 4, tested with Win95, 98 and NT4

Note that Magenta Systems also has available some TAPI functions that
allow monitoring on modems and ISDN adaptors using events, avoiding needing
to continually poll using the RAS APIs.  TAPI also monitors non-RAS modem
usage and will monitor incoming calls.  A TAPI function is also used to
convert the canonical telephone number into a dialable number according
to telephony dialling properties.

See the web site listed above for more details on the TAPI functions.

}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, 
  Rascomp32, RAS_API32 ;	// the main TRAS component and literals

type
  TMainForm = class(TForm)
	Status: TStatusBar;
	ConnList: TListBox;
	Label1: TLabel;
	Timer: TTimer;
	doCreateConn: TButton;
	doEditConn: TButton;
	ConnUser: TEdit;
	ConnPw: TEdit;
	Label2: TLabel;
	Label3: TLabel;
	doLogonUpdate: TButton;
	doConnect: TButton;
	doDisConn: TButton;
	doExit: TButton;
	Label4: TLabel;
	doDeleteConn: TButton;
	doRenameConn: TButton;
    DeviceName: TLabel;
    ConnPhone: TLabel;
    Label7: TLabel;
    ListDUA: TListBox;
    Label8: TLabel;
    Panel1: TPanel;
    Label5: TLabel;
    StatXmit: TLabel;
    StatRecv: TLabel;
    ConnSpeed: TLabel;
    Label6: TLabel;
    IPAddr: TLabel;
    Memory: TLabel;
    DeviceList: TListBox;
    Label9: TLabel;
    ConnCanonical: TLabel;
    DeviceType: TLabel;
    DevicePort: TLabel;
	procedure FormCreate(Sender: TObject);
	procedure TimerTimer(Sender: TObject);
	procedure doConnectClick(Sender: TObject);
	procedure doDisConnClick(Sender: TObject);
	procedure doCreateConnClick(Sender: TObject);
	procedure doEditConnClick(Sender: TObject);
	procedure doLogonUpdateClick(Sender: TObject);
	procedure ConnListClick(Sender: TObject);
	procedure FormClose(Sender: TObject; var Action: TCloseAction);
	procedure doExitClick(Sender: TObject);
	procedure doDeleteConnClick(Sender: TObject);
	procedure doRenameConnClick(Sender: TObject);

  private
	{ Private declarations }

	procedure StateChanged(Sender: TObject);	// TRAS event, added manually

  public
	{ Public declarations }
  end;

var
	MainForm: TMainForm;

	RAS: TRAS ;					// the main TRAS component
	CurrConnection: string ;	// active connection name, if any
	StopFlag: boolean ;			// if true, stop connection in progress
	OnlineFlag: boolean ;		// if true, connected
 	heap: THeapStatus ;


implementation

{$R *.DFM}

// when a connection is clicked, get Phone book info

procedure TMainForm.ConnListClick(Sender: TObject);
begin
	if ConnList.ItemIndex = -1 then exit ;
	RAS.EntryName := ConnList.Items [ConnList.ItemIndex];	// Connection name
	ConnUser.Text := '' ;
	ConnPw.Text := '' ;
	if RAS.GetDialParams = 0 then							// get connection parameters
	begin
		ConnUser.Text := RAS.UserName ;					// display them
		ConnPw.Text := RAS.Password ;
       if RAS.GetEntryProperties = 0 then
		begin
			DeviceName.Caption := 'Device Name: ' + RAS.DeviceName ;
           	DeviceType.Caption := 'Device Type: ' + RAS.DeviceType ;
           	DevicePort.Caption := 'Device Port: ' + RAS.DevicePort ;
           	ConnPhone.Caption := 'Phone Number: ' + RAS.PhoneNumber ;
		   	ConnCanonical.Caption := 'Canonical Number: ' + RAS.PhoneCanonical ;
		end ;
		Timer.Enabled := true ;								// not until RAS installed
	end
	else
		Status.Panels[1].Text := RAS.StatusStr ;


end;

procedure TMainForm.FormCreate(Sender: TObject);
var
	count: integer ;
begin
	OnlineFlag := false ;
	CurrConnection := '' ;					// no active connection, yet
	RAS := TRAS.Create (Self) ;				// create TRAS component
	RAS.OnStateChanged := StateChanged ;	// install event handler
	if RAS.TestRAS then
	begin
	// get list of connections
		RAS.GetPhoneBookEntries;
		ConnList.Items.Assign (RAS.PhoneBookEntries);		// display it
		if ConnList.Items.Count <> 0 then ConnList.ItemIndex := 0 ;		// set first

	// get list of RAS capable modems
    	RAS.GetDeviceList ;
        if RAS.DeviceNameList.Count <> 0 then
        	for count := 0 to RAS.DeviceNameList.Count - 1 do
            	DeviceList.Items.Add (RAS.DeviceNameList [count] + ' (' +
                                         RAS.DeviceTypeList [count] + ')') ;

    // Win95/98 gets performance stats from registry, but the keys may be
    // translated and there may be more than one dial up adaptor
    // so get a list and select the first found
		if NOT RAS.EnablePerfStats (true, true) then
		begin
            ListDUA.Items.Assign (RAS.DialUpAdaptors) ;
            ListDUA.Items.Add ('No Performance Statistics') ;
            Status.Panels[1].Text := 'No Performance Statistics' ;
		end
        else
           ListDUA.Items.Assign (RAS.DialUpAdaptors) ;

	// initial settings
		ConnListClick (self) ;	// get connection info
		Timer.Enabled := true ;
		StateChanged (self) ;	// initial status panel
	end
	else
	begin
		ConnList.Items.Add (RAS.StatusStr) ;	// no RAS available
		Status.Panels[1].Text := RAS.StatusStr ;
	end ;

end;

// event handler called by TRAS when connection status changes

procedure TMainform.StateChanged(Sender: TObject);
var
	info: string ;
begin
	if CurrConnection = '' then
		info := 'DUN: Offline'
	else
		info := 'DUN: ' + CurrConnection + ' - ' + RAS.StatusStr  ;
	Status.Panels[0].Text := info ;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
var
	numconns: integer ;
	info: string ;
begin

// check for memory leaks
   heap := GetHeapStatus ;
   Memory.Caption := 'Memory: Allocated ' + IntToStr (heap.TotalAllocated) ;

// see if any connections are open
	RAS.GetConnections ;				// check for active connections
	if Ras.Connections.Count = 0 then	// no active connections
	begin
		OnlineFlag := false ;
		if CurrConnection <> '' then	// just gone offline
		begin
			CurrConnection := '' ;
			RAS.IntDisconnect ;			// disconnect, but ignore errors
			RAS.ResetPerfStats ;		// clear stats for next connection
			StateChanged (self) ;
		end
	end
	else
	begin						 // see if new connection
		if CurrConnection <> RAS.Connections.EntryName (0) then
		begin
			CurrConnection := RAS.Connections.EntryName (0) ;
			RAS.ReOpen (0) ;		// allow RAS to use this connection
		end ;
		RAS.CurrentStatus ;			// triggers StateChanged event
		if (RAS.ConnectState = RASCS_Connected) then
		begin
			RAS.GetPerfStats ;       // get performance info
			if NOT OnlineFlag then
			begin
				OnlineFlag := true ;

			// connections speed not available on NT
 				if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
					ConnSpeed.Caption := 'Speed: ' +
									IntToStr (RAS.StatsConn) + ' bps' ;

			// dynamic IP addresses
				if RAS.GetIPAddress = 0 then IPAddr.Caption :=
								RAS.ClientIP + ' > ' + RAS.ServerIP ;
			end ;

		// display performance statistics
			StatXmit.Caption := 'Xmit: ' +
								IntToStr (RAS.StatsXmit) + ' chars' ;
			StatRecv.Caption := 'Recv: ' +
								IntToStr (RAS.StatsRecv) + ' chars' ;
		end ;
	end ;
end;

// this proc waits until a connection is achieved or cancelled

procedure TMainForm.doConnectClick(Sender: TObject);
begin
	if ConnList.ItemIndex = -1 then exit ;
	if CurrConnection <> '' then exit ;			// already connected
	Timer.Enabled := false ;					// must stop progress events during connection
	RAS.EntryName := ConnList.Items [ConnList.ItemIndex];	// Connection name
	CurrConnection := RAS.EntryName ;			// keep it to check later
	StopFlag := false ;							// set if Disconnect button is pressed
	Status.Panels[1].Text := '' ;
	Status.Panels[1].Text := CurrConnection + ' - Starting Connection' ;
	if RAS.AutoConnect <> 0 then				// get phone book, start connection
	begin
		CurrConnection := '' ;
		Timer.Enabled := true ;
		Status.Panels[1].Text := 'Connection Failed - ' + RAS.StatusStr ;
		beep ;
		exit ;
	end ;

// need to wait for connection to dial or whatever
	while (RAS.ConnectState <  RASBase) do
	begin
		Application.ProcessMessages ;
		if StopFlag then break ;			// see if Disconnect button pressed
	end ;
	Timer.Enabled := true ;
	if (RAS.ConnectState <> RASCS_Connected) or StopFlag then
	begin
		Ras.Disconnect;
		CurrConnection := '' ;
		StateChanged (self) ;				// update panel
		Status.Panels[1].Text := 'Connection Terminated' ;
		beep ;
		exit ;
	end ;
	Status.Panels[1].Text := 'Connection Opened OK' ;
end;

procedure TMainForm.doDisConnClick(Sender: TObject);
begin
	Status.Panels[1].Text := '' ;
	StopFlag := true ;
	if NOT Timer.Enabled then exit ;		// not while connecting
	RAS.Disconnect ;						// disconnect, returns when done
end;

procedure TMainForm.doLogonUpdateClick(Sender: TObject);
begin
	Status.Panels[1].Text := '' ;
	if ConnList.ItemIndex = -1 then exit ;
	RAS.EntryName := ConnList.Items [ConnList.ItemIndex];		// Connection name
	RAS.UserName := ConnUser.Text ;
	RAS.Password := ConnPw.Text ;
	if RAS.SetDialParams = 0 then
		Status.Panels[1].Text := 'Connection Updated'
	else
		Status.Panels[1].Text := RAS.StatusStr ;
end;

procedure TMainForm.doExitClick(Sender: TObject);
var
	key: integer ;
begin
	Timer.Enabled := false ;		// stop connection checks
	if RAS.RASConn <> 0 then
	begin
		key := MessageDlg ('Close Down Dial-Up Connection?',
								 mtConfirmation, mbYesNoCancel, 0) ;
		if key = mrCancel then exit ;
		if key = mrYes then
			doDisConnClick(Sender)
		else
			RAS.LeaveOpen ;			// stop destroy closing RAS
	end ;
	Application.Terminate ;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	doExitClick (sender) ;
	Application.Terminate ;
end;

procedure TMainForm.doCreateConnClick(Sender: TObject);
begin
	Status.Panels[1].Text := '' ;
	if RAS.CreatePhonebook <> 0 then
		Status.Panels[1].Text := RAS.StatusStr
	else
	begin
		RAS.GetPhoneBookEntries;						// get new list of connections
		ConnList.Items.Assign (RAS.PhoneBookEntries);	// display it
		if ConnList.Items.Count <> 0 then ConnList.ItemIndex := 0 ;	// set first
		ConnListClick (self) ;							// get connection info
	end ;
end;

procedure TMainForm.doEditConnClick(Sender: TObject);
begin
	Status.Panels[1].Text := '' ;
	if ConnList.ItemIndex = -1 then exit ;
	RAS.EntryName := ConnList.Items [ConnList.ItemIndex];		// Connection name
	if RAS.EditPhonebook <> 0 then								// display Dialog
				Status.Panels[1].Text := RAS.StatusStr ;
end;

procedure TMainForm.doDeleteConnClick(Sender: TObject);
begin
	Status.Panels[1].Text := '' ;
	if ConnList.ItemIndex = -1 then exit ;
	RAS.EntryName := ConnList.Items [ConnList.ItemIndex];		// Connection name
	if RAS.DeletePhonebook <> 0 then
		Status.Panels[1].Text := RAS.StatusStr
	else
	begin
		RAS.GetPhoneBookEntries;								// get new list of connections
		ConnList.Items.Assign (RAS.PhoneBookEntries);			// display it
		if ConnList.Items.Count <> 0 then ConnList.ItemIndex := 0 ;	// set first
		ConnListClick (self) ;									// get connection info
	end ;
end;

procedure TMainForm.doRenameConnClick(Sender: TObject);
var
   oldname, newname: string ;
begin
	Status.Panels[1].Text := '' ;
	if ConnList.ItemIndex = -1 then exit ;
	oldname := ConnList.Items [ConnList.ItemIndex];		// Connection name
   newname := oldname ;
   while newname = oldname do
   begin
       if NOT InputQuery ('Rename Connection', 'New Connection Name',
                                                    newname) then exit ;
       if RAS.ValidateName (newname) <> 0 then
       begin
           Status.Panels[1].Text := RAS.StatusStr ;
           beep ;
           newname := oldname ;
       end ;
   end ;
   Status.Panels[1].Text := '' ;
 	RAS.EntryName := oldname ;
	if RAS.RenamePhonebook (newname) <> 0 then
		Status.Panels[1].Text := RAS.StatusStr
	else
	begin
		RAS.GetPhoneBookEntries;								// get new list of connections
		ConnList.Items.Assign (RAS.PhoneBookEntries);			// display it
		if ConnList.Items.Count <> 0 then ConnList.ItemIndex := 0 ;	// set first
		ConnListClick (self) ;									// get connection info
	end ;

end;

end.
