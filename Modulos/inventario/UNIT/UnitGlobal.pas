unit UnitGlobal;
interface
Uses pr_Common, pr_TxClasses,Forms, StdCtrls, DBCtrls, IB, IBSQL,IBQuery , Messages,SysUtils,Math,DB,DBGrids,Windows,Controls, StrUtils,Classes,Dialogs, winspool, Printers;
procedure verificatransaccion(IBQuery1:TIBQuery);
implementation

procedure verificatransaccion(IBQuery1:TIBQuery);
begin
        with IBQuery1 do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
        end;
end;

end.
