unit UnitGlobal;

interface
uses SysUtils,Forms,Dialogs,StdCtrls,DBCtrls,Messages,Db, DBClient,Controls;
var
    _sDBserver :string;
    _sDBPath :string;
    _sDBname :string;
    _sEmpresa :string;
    _sNit     :string;
    _iAgencia :Integer;
    _sCiudad  :string;
    _cDBMinutos :Currency;
    _sDBUser :string;
    _sDBPass :string;
    _sDBRole :string;

    procedure EnterTabs(var Key: Char; oSelf: TForm);
implementation
procedure EnterTabs(var Key: Char; oSelf: TForm);
begin
  if (Key=#13) and
      not (oSelf.ActiveControl is TButton)    and
      not (oSelf.ActiveControl is TDBMemo)then
      begin
        oSelf.Perform( WM_NEXTDLGCTL, 0,0);
        Key := #0;
      end;
end;

end.
