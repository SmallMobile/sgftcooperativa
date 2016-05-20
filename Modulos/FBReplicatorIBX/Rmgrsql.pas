unit RmgrSQL;

interface

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, DB, DBTables;

procedure BuildSelect( Fields : TStrings; Table : String;
  var Stmt : TStringList; Caracter:string);

procedure BuildInsert( Fields : TStrings; Table : string;
  var Stmt : TStringList; Caracter:string);

procedure BuildUpdate( Fields : TStrings; Table : string;
  var Stmt : TStringList; Caracter:string);

procedure BuildDelete( Fields : TStrings; Table : string;
  var Stmt : TStringList; Caracter:string);


implementation

procedure BuildSelect( Fields : TStrings; Table : String;
  var Stmt : TStringList; Caracter:string);
var
  i : Integer;
  StmtPart : string[255];
begin

  with Fields do
  begin
    if( Count > 0 ) then
    begin
      StmtPart := 'SELECT ' + Strings[0];

      for I := 1 to Count - 1 do
      begin
        StmtPart := StmtPart + ',' + Strings[I];
        if( Length( StmtPart ) > 200 ) then
        begin
          Stmt.Add( StmtPart );
          StmtPart := '';
        end;
      end;
      StmtPart := StmtPart + ' FROM ' + Caracter + Table + Caracter;
      Stmt.Add( StmtPart );
      Stmt.Add( ' WHERE ' + Strings[0] + '=?');
    end;
  end;
end;

procedure BuildInsert( Fields : TStrings; Table : string;
  var Stmt : TStringList; Caracter:string );
var
  i : Integer;
  StmtPart : string[255];
begin
  with Fields do
  begin
    if( Count > 0 ) then
    begin
      StmtPart := 'INSERT INTO ' + Caracter + Table + Caracter + ' (' +
        Strings[0];

      for I := 1 to Count - 1 do
      begin
        StmtPart := StmtPart + ',' + Strings[I];
        if( Length( StmtPart ) > 200 ) then
        begin
          Stmt.Add( StmtPart );
          StmtPart := '';
        end;
      end;

      StmtPart := StmtPart + ') VALUES (?';
      if( Length( StmtPart ) > 200 ) then
      begin
        Stmt.Add( StmtPart );
        StmtPart := '';
      end;

      for I := 1 to Count - 1 do
      begin
        StmtPart := StmtPart + ',?';
        if( Length( StmtPart ) > 200 ) then
        begin
          Stmt.Add( StmtPart );
          StmtPart := '';
        end;
      end;

      StmtPart := StmtPart + ')';
      Stmt.Add(StmtPart);
    end;
  end;
end;

procedure BuildUpdate( Fields : TStrings; Table : string;
  var Stmt : TStringList; Caracter:string);
var
  i : Integer;
  StmtPart : string[255];
begin
  with Fields do
  begin
    if( Count > 0 ) then
    begin
      StmtPart := 'UPDATE ' + Caracter + Table + Caracter + ' SET ' +
        Strings[0] + '=?';

      for I := 1 to Count - 1 do
      begin
        StmtPart := StmtPart + ',' + Strings[I] +
          '=?';
        if( Length(StmtPart) > 200 ) then
        begin
          Stmt.Add(StmtPart);
          StmtPart := '';
        end;
      end;

      StmtPart := StmtPart + ' WHERE ' + Strings[0] +
        '=?';
      Stmt.Add(StmtPart);
    end;
  end;
end;

procedure BuildDelete( Fields : TStrings; Table : string;
  var Stmt : TStringList; Caracter:string);
var
  i : Integer;
  StmtPart : String[255];
begin
  with Fields do
  begin
    if( Count > 0 ) then
    begin
      StmtPart := 'DELETE FROM ' + Caracter + Table + Caracter;

      StmtPart := StmtPart + ' WHERE ' + Strings[0] +
        '=?';

      Stmt.Add(StmtPart);
    end;
  end;
end;

end.
