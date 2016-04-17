unit UnitTConexion;

interface

uses IBDatabase;//, UnitGlobal;

type
   TConexion = class
     private
       _database: TIBDatabase;
     public
       property Database:TIBDatabase read _database;
       function Conectar:Boolean;
       procedure Desconectar;
   end;

implementation

function TConexion.Conectar:Boolean;
begin
  {_database := TIBDatabase.Create(nil);
  _database.DatabaseName := _tParametro._sDbName;
  _database.SQLDialect := 3;
  _database.LoginPrompt := false;
  _database.Params.Add('user_name='+_tParametro._sDbAlias);
  _database.Params.Add('password='+_tParametro._sDbPassword);
  _database.Params.Add('lc_ctype=ISO8859_1');}
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

procedure TConexion.Desconectar;
begin
    if (_database.Connected) then
        _database.Close;
end;
end.

