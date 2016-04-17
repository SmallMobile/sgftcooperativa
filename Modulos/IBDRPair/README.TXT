(*************************************************************************
IBDBRepair - Interbase Database Repair Utility
Copyright (C) 2003  DRB Systems Inc., Brenden K. Walker

This file is part of IBDBRepair

    IBDBRepair is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    IBDBRepair is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with IBDBRepair; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA


Contact Information

  Primary Programmer: Brenden K. Walker (bkwalker@drbsystems.com)

  Project Descriptive Name:  InterBase Database Repair Utility
  Project Unix Name:  ibdbrepair
  CVS Server:         cvs.ibdbrepair.sourceforge.net
  Shell/Web Server:   ibdbrepair.sourceforge.net

  Brenden Walker
  DRB Systems, Inc.
  3245 Pickle Road
  Akron, OH   44312-5333

 *************************************************************************)

-Summary:


According to Ann Harrison, certain types of subtle corruption can be propagated accross a backup and restore.  This means that you cannot rely on a backup and restore to correct all database corruption.

Over the past 4 years, I've seen this type of corruption in our customers databases many times.  What causes these issues is unknown at this time.  The usual culprit is having force writes disabled, or copying a database file while Interbase is actively modifying it and expecting the copy to be good.  The only official way to recover the data is to create a new database and import data from the old database. 

When dealing with large database files, this become very cumbersome and can be slow.  Using something like the BDE datapump is can take many days to copy the data from a 2gig database.  

This solution is a hybrid approach, using fast record copy and external table copy where appropriate.

-Goals:

	- Recover an Interbase Database as quickly and completly as possible
	- Provide sufficient flexibility to recover parts of databases and handle conflicts on the destination.


-Some things to be implemented or decided:

  When specifying a 'where' clause for exporting data, it would probably be good to use that same where clause when the duplicate handling is set to flush.  This way you could export a bunch of data where "salesman" = "BOB", and specify flush to that the destination data for "BOB" will match the source database.

  External table trimming: It should be possible to automate the handling of the f_lrtrim function by creating UDF DLL's for Interbase that just contains the trim functionality, then handle declaring the function (and dropping it when done) inside IDBDRepair.  This would make things a bit cleaner for those people who don't use freeUDFLib normally.
  

-Copy Methods:

There are three methods (well, two really...).  

  Skip: does just that, skips the table.  

  Record: copies the records individually, this is pretty slow but in cases where there is data present in the table on the destination database and you want to make sure that no distinct indexes are violated, record copy may be the best choice.  In cases where there are blob fields, this is your only choice.  In addition to that, if there are null numeric fields that need to be preserved you must use record copy to assure they remain null.

  External: uses external tables to pump the data in the most efficient (and fastest) way possible.  Due to the way this functions you must have a trim UDF defined (freeUDFLib has lrtrim, we usually define it as f_lrtrim) otherwise your string values will be padded to the maximum allowed.  Numeric fields that are null will be converted to 0 (zero) in the external table, which may cause some problems as well.  There are many 'caveats' that must be watched.  For example in IB5.6 the external table files cannot exceed 2gig, thus the TableCopier attempts to guess how many need to be used to copy the data and breaks up the export process accordingly.

-Duplicate handling:

Flush: This deletes the data in the destination table, this also allows the 'drop indexes' option to work and external table copies to perform the best (some tests take 1 minute to do what could take 20 minutes with indexes on!).

Ignore: This can hit performance a bit on external copies, and requires that indexes not be dropped (even if you check 'drop indexes' they will not in this case).  In order for an external copy to ingore, it must include a 'exists' in the where clause...

Overwrite: only valid for record copy, any conflicting primary keys records will be deleted.  



-FAQ (well, I think these would be frequent).

Why not use IBInputRawFile/IBOutputRawFile components?

Because they are slow, about half the speed of a raw external table copy.  The issue appears to be that using these components required transfering the data to the client then out to the external file, whereas simply using an external table keeps all io within the server...mucho faster.
