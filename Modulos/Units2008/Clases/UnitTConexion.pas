unit UnitTConexion;

interface

uses IBDatabase,Controls,SysUtils,Windows,UnitGlobal;

type
   TConexion = class
     private
       _database: TIBDatabase;
     public
       constructor Create;
       destructor Destroy;
       property Database:TIBDatabase read _database;
       function ValidaUsuario:Boolean;
       function Conectar:Boolean;
       procedure Desconectar;
   end;

implementation
uses UnitLogin;

constructor TConexion.Create;
begin
        _database := TIBDatabase.Create(nil);
        _database.DatabaseName := _sDBserver + ':' + _sDBpath + _sDBname;
        _database.SQLDialect := 3;
        _database.LoginPrompt := false;
        _database.Params.Add('user_name='+ _sDBuser);
        _database.Params.Add('password='+_sDBpass);
        _database.Params.Add('sql_role_name=' + _sDBrole);
        _database.Params.Add('lc_ctype=ISO8859_1');

end;

destructor TConexion.Destroy;
begin
        _database.Free;
end;

function TConexion.ValidaUsuario:Boolean;
var frmLogin:TfrmLogin;
    Veces :SmallInt;
    Mensaje :string;
begin
  Result := False;
  try
     _database.Connected := True;
     Result := True;
  except
  on E: Exception do
  begin
     Result := False;
     if StrLIComp(PChar(E.Message),PChar('Your user name'),14) = 0 then
     begin
       Mensaje :='Verifique su Nombre y su Contraseña' + #10 + #13 + 'Mensaje:' + E.Message;
       MessageBox(0,PChar(Mensaje),PChar('Usuario Invalido'),MB_OK OR MB_ICONERROR);
     end
     else
     begin
       Mensaje := 'Verifique su Configuración o Informe al Administrador de la Red' + #10 + #13 + 'Mensaje:' + E.Message;
       MessageBox(0,PChar(Mensaje),PChar('Configuración Erronea'),MB_OK OR MB_ICONERROR);
      end;
   end; //fin del begin de la excepción.
   end;
end;
procedure TConexion.Desconectar;
begin
    if (_database.Connected) then
        _database.Close;
end;
function TConexion.Conectar;
begin

{  _database.DatabaseName := _sDBserver + ':' + _sDBpath + _sDBname;
  _database.SQLDialect := 3;

  _database.LoginPrompt := false;
  _database.Params.Clear;
  _database.Params.Add('user_name= ' + _sDBuser);
  _database.Params.Add('password= ' +_sDBpass);
  _database.Params.Add('sql_role_name=' + _sDBrole);
  _database.Params.Add('lc_ctype=ISO8859_1');}
//  _DATABASE.Params.Text;

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
end.

