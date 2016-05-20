DELPHI RAS COMPONENT - version 3.0  - 28th March 1999
=====================================================

(C) 1996 Daniel Polistchuck	and 1999 Magenta Systems Ltd

This is a Delphi 2.0 wrapper for the RAS & W95 Dial-Up Connection
client services. It was tested and re-tested. 
This component is a rewrite of the excelent Mike Armstrong's
TRAS component. Parts of it were rewritten in order to conform 
to the 32 bits RAS Api, whose prototypes are included in the 
RAS_API32 unit source code. Daniel Polistchuck with collaborations 
from Ronaldo Smith Jr.

------------------------------------------------------------------------------

Updated by Angus Robertson, Magenta Systems Ltd, England
in early 1999, delphi@magsys.co.uk, http://www.magsys.co.uk/delphi/

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
one.  To get performance statistics running, make sure that Connection 
Properties, Server Types, Record a Log File is ticked, and in Modem 
Properties, Options, Display Modem Status is ticked.  You may need to 
reboot after these changes and then make a connection, at which point the
correct registry keys should be created.  Users have reported difficulties
geting performance statistics from DUN version earlier than 1.2, so this 
is recommended.


TAPI Functions
--------------

Note that Magenta Systems also has available some TAPI functions that
allow monitoring on modems and ISDN adaptors using events, avoiding needing
to continually poll using the RAS APIs.  TAPI also monitors non-RAS modem
usage and will monitor incoming calls.  A TAPI function is also used to
convert the canonical telephone number into a dialable number according
to telephony dialling properties.

See the web site listed above for more details on the TAPI functions.


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


