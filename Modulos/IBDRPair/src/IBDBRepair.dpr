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
program IBDBRepair;

uses
  Forms,
  IBDBRepairMain in 'IBDBRepairMain.pas' {formDBRepairMain},
  Consts in '\\Winserver\repositorio\sistemas\units\Consts.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'IBDBRepair';
  Application.CreateForm(TformDBRepairMain, formDBRepairMain);
  Application.Run;
end.
