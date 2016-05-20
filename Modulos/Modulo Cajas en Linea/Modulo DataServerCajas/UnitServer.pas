unit UnitServer;

interface

uses
  IniFiles, sdXmlDocuments, IdThreadMgr, IdThreadMgrPool, Classes, IdBaseComponent,
  IdComponent, IdTCPServer, SysUtils, Types, Variants, QGraphics, QControls, QForms, QDialogs,
  SqlExpr, FMTBcd, DB, DBXpress, IdThreadMgrDefault, IdTCPConnection,
  QStdCtrls;

type
  FieldRecord = Record
     FieldTipo:String;
     FieldSentencia:String;
end;

type
  TIndyTCPServer = class(TForm)
    IdTCPServer: TIdTCPServer;
    SQLConnection: TSQLConnection;
    IdThreadMgrDefault1: TIdThreadMgrDefault;
    SQLQuery1: TSQLQuery;
    SQLStoredProc1: TSQLStoredProc;
    Label1: TLabel;
    Label2: TLabel;
    procedure IdTCPServerExecute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    DBServer:String;
    DBPath:String;
    DBName:String;
    function  fSelect(Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
    function  fInsert(Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
    function  fDelete(Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
    function  fUpdate(Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
    function  fProcedure(Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
  public
       Fields: array of FieldRecord; // Array Dinamico
       procedure LoadFieldFromNode(var AField: FieldRecord; ANode: TXmlNode);
    { Public declarations }
  end;

var
  IndyTCPServer: TIndyTCPServer;

implementation

{$R *.xfm}

procedure TIndyTCPServer.LoadFieldFromNode(var AField: FieldRecord;
  ANode: TXmlNode);
// Load one field from the XML element ANode

begin
  with AField, ANode do begin
    // Initialize record
    FillChar(AField, SizeOf(AField), 0);
    // The flat data
    FieldTipo      := ReadString('tipo');
    FieldSentencia := ReadString('sentencia');
  end;
end;

procedure TIndyTCPServer.IdTCPServerExecute(AThread: TIdPeerThread);
var
i:Integer;
AStream:TStringStream;
XMLDoc,XmlDocRet:TsdXmlDocument;
XMLRet:Boolean;
Size:Integer;
Tipo:String;
Sentencia:String;
SQLQuery:TSQLQuery;
ANode: TXmlNode;
AList: TList;
begin

        XmlDocRet := TsdXmlDocument.CreateName('Retorno');
        XmlDocRet.EncodingString := 'ISO-8859-1';
//        XmlDocRet.BinaryEncoding := xbeBase64;
        XmlDocRet.XmlFormat := xfReadable;

        XmlDoc := TsdXmlDocument.Create;
        AStream := TStringStream.Create('');
        Athread.Connection.WriteLn('Esperando...');
        Size := AThread.Connection.ReadInteger;
        Athread.Connection.ReadStream(AStream,Size,False);
        System.WriteLn('Stream recibido');
       try
        XMLDoc.LoadFromStream(AStream);
        XMLDoc.SaveToFile('xmlrecibido1.xml');
        System.WriteLn('Xml Cargado');
        AList := TList.Create;
        try
        ANode := XmlDoc.Root.NodeByName('querys');
        System.WriteLn('Leyendo ANode Ok');
        if assigned(ANode) then
        begin
      // Lista de nodos que son nombrados "query"
         ANode.NodesByName('query', AList);
         System.WriteLn('Consultas:'+IntToStr(AList.Count));
      // Establecer la longitud del array
         SetLength(Fields, AList.Count);
      // Importar cada elemento
         for i := 0 to AList.Count - 1 do
          LoadFieldFromNode(Fields[i], AList[i]);
//         showmessage('Consultas Cargadas');
      // Validar Consultas, Ejecutar y Crear XML
         for i := 0 to AList.Count - 1 do begin
          SQLQuery := TSQLQuery.Create(nil);
          SQLQuery.SQLConnection := SQLConnection;
          SQLConnection.Open;
          Tipo := Fields[i].FieldTipo;
          Sentencia := Fields[i].FieldSentencia;
          System.WriteLn('Sentencia tipo:'+Tipo);
          System.WriteLn('Consultado sentencia:'+Sentencia);
          if Tipo = 'select' then
           XmlRet := fSelect(XmlDocRet,i,Sentencia)
          else
          if Tipo = 'insert' then
           XmlRet := fInsert(XmlDocRet,i,Sentencia)
          else
          if Tipo = 'delete' then
           XmlRet := fDelete(XmlDocRet,i,Sentencia)
          else
          if Tipo = 'update' then
           XmlRet := fUpdate(XmlDocRet,i,Sentencia)
          else
          if Tipo = 'procedure' then
           XmlRet := fProcedure(XmlDocRet,i,Sentencia);
        end;
      end;
      finally
        System.WriteLn('proceso finalizado');
        AList.Free;
      end;
    finally
      AStream.Free;
    end;
    AStream := TStringStream.Create('');
    System.WriteLn('Guardando AStream Retorno');
    XMLDocRet.SaveToStream(AStream);
    XMLDocRet.SaveToFile('XmlServer.xml');
    Athread.Connection.WriteInteger(AStream.Size); 
    Athread.Connection.OpenWriteBuffer;
    Athread.Connection.WriteStream(AStream);
    Athread.Connection.CloseWriteBuffer;
end;

function TIndyTCPServer.fSelect(Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
var ANode,Nodo,Nodo1:TXmlNode;
    SQLQuery:TSQLQuery;
    Cadena:String;
    i,bLargo:integer;
    TD:TTransactionDesc;
    AStream1:TStream;
begin
    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := SQLConnection;
    SQLConnection.Open;
    TD.TransactionID :=1;
    TD.IsolationLevel := xilREADCOMMITTED;
    SQLConnection.StartTransaction(TD);
    SQLQuery.SQL.Clear;
    SQLQuery.SQL.Add(sentencia);
    ANode := Xml.Root.NodeNew('consulta'+Format('%.3d',[csc]));
    try
     SQLQuery.Open;
     System.WriteLn('Consulta Realizada');
     if SQLQuery.RecordCount > 0 then
     begin

     Anode.AttributeAdd('campos',SQLQuery.Fields.Count);
     for i := 0 to SQLQuery.Fields.Count - 1 do
     begin
       Anode.AttributeAdd('campotipo'+inttostr(i+1),Vartostr(SQLQuery.Fields[i].DataType));
       Anode.AttributeAdd('camponombre'+inttostr(i+1),Vartostr(SQLQuery.Fields[i].FieldName));
       Anode.AttributeAdd('campotamano'+inttostr(i+1),VarToStr(SQLQuery.Fields[i].Size));
     end;

     while not SQLQuery.Eof do
     begin
       Cadena := '';
       Nodo:= ANode.NodeNew('Registro');
       for i := 0 to SQLQuery.Fields.Count - 1 do
       begin
           Nodo1 := Nodo.NodeNew('campo');
           if SQLQuery.Fields[i].DataType = ftBlob then
           begin
             AStream1 := TStream.Create;
             AStream1 := SQLQuery1.CreateBlobStream(SQLQuery.Fields[i],bmRead);
             bLargo := AStream1.Size;
             Nodo1.AttributeAdd('largo',bLargo);
             Nodo1.BinaryEncoding := xbeBase64;
             Nodo1.BufferWrite(AStream1,bLargo);
             FreeAndNil(AStream1);
           end
           else
           if SQLQuery.Fields[i].DataType = ftString then
             Nodo1.ValueAsString := SQLQuery.Fields[i].AsString
           else
           if SQLQuery.Fields[i].DataType in [ftDate,ftTime,ftDateTime] then
             Nodo1.ValueAsDateTime := SQLQuery.Fields[i].AsDateTime
           else
           if SQLQuery.Fields[i].DataType in [ftSmallInt,ftInteger,ftWord,ftBoolean] then
             Nodo1.ValueAsInteger := SQLQuery.Fields[i].AsInteger
           else
           if SQLQuery.Fields[i].DataType in [ftFloat,ftCurrency] then
             Nodo1.ValueAsFloat := SQLQuery.Fields[i].AsFloat
           else
             Nodo1.ValueAsWidestring := SQLQuery.Fields[i].AsString;
       end;
       SQLQuery.Next;
       System.Writeln('Creando Fila Retorno');
     end;
     end;
     SQLConnection.Commit(TD);
     fSelect := True;
    except
     on E: Exception do begin
       Nodo:= ANode.NodeNew('Registro');
       Nodo.WriteString('campo',E.Message);
       fSelect := False;
       SQLConnection.Rollback(TD);
       SQLConnection.Close;
     end;
    end;

end;

function TIndyTCPServer.fInsert(Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
var ANode,Nodo:TXmlNode;
    SQLQuery:TSQLQuery;
    i:integer;
    TD:TTransactionDesc;
begin
    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := SQLConnection;
    SQLConnection.Open;
    TD.TransactionID :=1;
    TD.IsolationLevel := xilREADCOMMITTED;
    SQLConnection.StartTransaction(TD);
    SQLQuery.SQL.Text := sentencia;
    ANode := Xml.Root.NodeNew('consulta'+Format('%.3d',[csc]));
    try
     i := SQLQuery.ExecSQL;
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('filas',InttoStr(i));
     SQLConnection.Commit(TD);
     fInsert := True;
    except
     on E: Exception do begin
       Nodo:= ANode.NodeNew('Registro');
       Nodo.WriteString('campo',E.Message);
       fInsert := False;
       SQLConnection.Rollback(TD);
       SQLConnection.Close;
     end;
    end;
end;

function TIndyTCPServer.fDelete(Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
var ANode,Nodo:TXmlNode;
    SQLQuery:TSQLQuery;
    i:integer;
    TD:TTransactionDesc;
begin
    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := SQLConnection;
    SQLConnection.Open;
    TD.TransactionID :=1;
    TD.IsolationLevel := xilREADCOMMITTED;
    SQLConnection.StartTransaction(TD);
    SQLQuery.SQL.Text := sentencia;
    ANode := Xml.Root.NodeNew('consulta'+Format('%.3d',[csc]));
    try
     i := SQLQuery.ExecSQL;
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('filas',InttoStr(i));
     SQLConnection.Commit(TD);
     SQLConnection.Close;
     fDelete := True;
    except
     on E: Exception do begin
       Nodo:= ANode.NodeNew('Registro');
       Nodo.WriteString('campo',E.Message);
       fDelete := False;
       SQLConnection.Rollback(TD);
       SQLConnection.Close;
     end;
    end;
end;

function TIndyTCPServer.fUpdate(Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
var ANode,Nodo:TXmlNode;
    SQLQuery:TSQLQuery;
    i:integer;
    TD:TTransactionDesc;
begin
    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := SQLConnection;
    SQLConnection.Open;
    TD.TransactionID :=1;
    TD.IsolationLevel := xilREADCOMMITTED;
    SQLConnection.StartTransaction(TD);
    SQLQuery.SQL.Text := sentencia;
    ANode := Xml.Root.NodeNew('consulta'+Format('%.3d',[csc]));
    try
     i := SQLQuery.ExecSQL;
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('filas',InttoStr(i));
     SQLConnection.Commit(TD);
     fUpdate := True;
    except
     on E: Exception do begin
       Nodo:= ANode.NodeNew('Registro');
       Nodo.WriteString('campo',E.Message);
       fUpdate := False;
       SQLConnection.Rollback(TD);
       SQLConnection.Close;
     end;
    end;
end;

function TIndyTCPServer.fProcedure(Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
var ANode,Nodo:TXmlNode;
    SQLQuery:TSQLStoredproc;
    Cadena:String;
    i:integer;
    TD:TTransactionDesc;
begin
    SQLQuery := TSQLStoredProc.Create(nil);
    SQLQuery.SQLConnection := SQLConnection;
    SQLConnection.Open;
    TD.TransactionID :=1;
    TD.IsolationLevel := xilREADCOMMITTED;
    SQLConnection.StartTransaction(TD);
    SQLQuery.StoredProcName := Sentencia;
    ANode := Xml.Root.NodeNew('consulta'+Format('%.3d',[csc]));
    try
     SQLQuery.Open;
     System.WriteLn('Consulta Realizada');
     if SQLQuery.RecordCount > 0 then
     begin
     while not SQLQuery.Eof do
     begin
       Cadena := '';
       Nodo:= ANode.NodeNew('Registro');
       Nodo.WriteString('campos',InttoStr(SQLQuery.Fields.Count));
       for i := 0 to SQLQuery.Fields.Count - 1 do
       begin
           Nodo.WriteString('campo'+inttostr(i),SQLQuery.Fields[i].AsString);
       end;
       SQLQuery.Next;
       System.Writeln('Creando Fila Retorno');
     end;
     end;
     SQLConnection.Commit(TD);
     fProcedure := True;
    except
     on E: Exception do begin
       Nodo:= ANode.NodeNew('Registro');
       Nodo.WriteString('campo',E.Message);
       fProcedure := False;
       SQLConnection.Rollback(TD);
       SQLConnection.Close;
     end;
    end;

end;

procedure TIndyTCPServer.FormCreate(Sender: TObject);
var MiIniFile:TIniFile;
begin
     MiIniFile := TIniFile.Create('/usr/bin/dataserverd.ini');
     DBServer := MiIniFile.ReadString('SERVER','DBServer','0.0.0.0');
     DBPath := MiIniFile.ReadString('SERVER','DBPath','/var/db/fbird/');
     DBName := MiIniFile.ReadString('SERVER','DBName','database.fdb');
     SQLConnection.ConnectionName := 'IBConnection';
     SQLConnection.DriverName := 'Interbase';
     SQLConnection.GetDriverFunc := 'getSQLDriverINTERBASE';
     SQLConnection.KeepConnection := True;
     SQLConnection.LibraryName := 'libsqlib.so.1';
     SQLConnection.LoadParamsOnConnect := False;
     SQLConnection.LoginPrompt := False;
     SQLConnection.Params.Append('Database='+DBServer+':'+DBPath+DBName);
     SQLConnection.Params.Append('RoleName=REMOTE');
     SQLConnection.Params.Append('User_Name=REMOTEQUERY');
     SQLConnection.Params.Append('Password=remoterestore');
     SQLConnection.Params.Append('ServerCharSet=ISO8859_1');
     SQLConnection.Params.Append('SQLDialect=3');
     IdTCPServer.Active := True;
     Label2.Caption := SQLConnection.Params.Values['Database'];
end;

end.
