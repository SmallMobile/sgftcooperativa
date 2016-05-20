unit UnitTConexion1;

interface

uses IBDatabase, UnitGlobal;

type
   TConexion1 = class
     private
       _database: TIBDatabase;
     public
       property Database:TIBDatabase read _database;
       function Conectar:Boolean;
       procedure Desconectar;
   end;

implementation

function TConexion1.Conectar:Boolean;
begin
  _database := TIBDatabase.Create(nil);
  _database.DatabaseName := _sDBserver + ':' + _sDBpath + _sDBname;
  _database.SQLDialect := 3;
  _database.LoginPrompt := false;
  _database.Params.Add('user_name= ' + _sDBuser);
  _database.Params.Add('password= ' +_sDBpass);
  _database.Params.Add('sql_role_name' + _sDBrole);
  _database.Params.Add('lc_ctype=ISO8859_1');
  try
    _database.Open;
    if (_database.Connected) then
        result := true
    else
        result := false;
  except
        result := false;
  end;
end;

procedure TConexion1.Desconectar;
begin
    if (_database.Connected) then
        _database.Close;
end;
end.

