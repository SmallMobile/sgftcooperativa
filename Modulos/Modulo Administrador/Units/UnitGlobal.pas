unit UnitGlobal;

interface

Uses Graphics, Forms, StdCtrls, DBCtrls, Math, DateUtils, IB, IBSQL ,IBQuery,IBStoredProc, IBDataBase, Messages,SysUtils,DB,DBGrids,Windows,Controls, StrUtils,Classes,Dialogs, winspool, Printers,
     Unit_DmComprobante,JvStringGrid;
const
  C1 = 52845;
  C2 = 11719;
var
    AIni :string;
    dbPassSysdba :string;
    pApellido,sApellido,vNombre :string;   
    function Decrypt(const S: String; Key: Word): String;
    function Encrypt(const S: String; Key: Word): string;
function validar(cadena: string): boolean;

implementation
function Decrypt(const S: String; Key: Word): String;
 var
         I: byte;
       begin
         SetLength(Result,Length(S));
         for I := 1 to Length(S) do begin
           Result[I] := char(byte(S[I]) xor (Key shr 8));
           Key := (byte(S[I]) + Key) * C1 + C2;
         end;
end;
function Encrypt(const S: String; Key: Word): String;
Var
         I: byte;
       begin
         SetLength(Result,Length(S));
         for I := 1 to Length(S) do begin
           Result[I] := char(byte(S[I]) xor (Key shr 8));
           Key := (byte(Result[I]) + Key) * C1 + C2;
         end;

end;
function validar(cadena: string): boolean;
var
     Inicio,Final: string;
begin
     result := False;
     Inicio:=LeftStr(cadena,1);
     Final :=RightStr(cadena,1);
     If (Inicio='[') and (Final=']') then Result:=True
end;

end.
