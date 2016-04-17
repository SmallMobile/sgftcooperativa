unit UnitMain;

interface

uses
  IniFiles, SysUtils, Types, Classes, Variants, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, IdThreadMgr, IdThreadMgrDefault, IdBaseComponent,
  IdComponent, IdTCPServer, IdAntiFreezeBase, IdAntiFreeze, DBXpress, FMTBcd,
  DB, SqlExpr, sdXmlDocuments, QButtons;

  type
   FieldRecord = Record     FieldTipo:String;
     FieldSentencia:String;
  end;

  type
   TfrmMain = class(TForm)
    Label1: TLabel;
    LblDatabase: TLabel;
    EdLog: TMemo;
    Label3: TLabel;
    LblPuerto: TLabel;
    IdTCPServer1: TIdTCPServer;
    IdThreadMgrDefault1: TIdThreadMgrDefault;
    IdAntiFreeze1: TIdAntiFreeze;
    btnApagar: TBitBtn;
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
  private
    Fields: array of FieldRecord; // Array Dinamico
    procedure LoadFieldFromNode(var AField: FieldRecord;ANode: TXmlNode);
    procedure Ejecutar(AThread: TIdPeerThread);
    function  fSelect(var SQLConn:TSQLConnection;Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
    function  fInsert(var SQLConn:TSQLConnection;Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
    function  fDelete(var SQLConn:TSQLConnection;Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
    function  fUpdate(var SQLConn:TSQLConnection;Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
    function  fExecute(var SQLConn:TSQLConnection;Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
    function  FldToStr(const Value : TFieldType) : String;
    function ValidaTipo(vTipo: string): integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  DBServer:string;
  DBPath:string;
  DBName:string;
  IDPuerto:integer;
  IDTiempo:integer;
  DBrole:string;
  DBpassword:string;
  DBuser:string;
implementation
{$R *.xfm}
procedure TfrmMain.LoadFieldFromNode(var AField: FieldRecord;
  ANode: TXmlNode);begin
  with AField, ANode do begin
    FillChar(AField, SizeOf(AField), 0);
    FieldTipo      := ReadString('tipo');
    FieldSentencia := ReadString('sentencia');
  end;
end;

procedure TfrmMain.Ejecutar(AThread: TIdPeerThread);
var
i:Integer;
AStream:TStringStream;
XMLDoc,XMLDocRet :TsdXmlDocument;
XMLRet:Boolean;
Size:Integer;
Tipo:String;
Sentencia:String;
SQLConn:TSQLConnection;
ANode: TXmlNode;
AList: TList;
begin        XmlDocRet := TsdXmlDocument.CreateName('Retorno');
        XmlDocRet.EncodingString := 'ISO8859-1';
        XmlDocRet.XmlFormat := xfReadable;
        XmlDoc := TsdXmlDocument.Create;
        AStream := TStringStream.Create('');
        Athread.Connection.WriteLn('Esperando...');
        Size := AThread.Connection.ReadInteger;
        Athread.Connection.ReadStream(AStream,Size,False);
        System.WriteLn('Stream recibido');
       try        XMLDoc.LoadFromStream(AStream);
        XMLDoc.SaveToFile('xmlrecibido1.xml');
        EdLog.Lines.LoadFromStream(AStream);
        System.WriteLn('Xml Cargado');
        AList := TList.Create;
        try
         ANode := XmlDoc.Root.NodeByName('querys');
         System.WriteLn('Leyendo ANode Ok');
         if assigned(ANode) then
         begin
           ANode.NodesByName('query', AList);
           System.WriteLn('Consultas:'+IntToStr(AList.Count));
           SetLength(Fields, AList.Count);
      // Importar cada elemento
           for i := 0 to AList.Count - 1 do
            LoadFieldFromNode(Fields[i], AList[i]);

           SQLConn := TSQLConnection.Create(nil);

           with SQLConn do begin
             ConnectionName := 'IBConnection';
             DriverName := 'Interbase';
             GetDriverFunc := 'getSQLDriverINTERBASE';
             KeepConnection := True;
             LibraryName := 'libsqlib.so.1';
             LoadParamsOnConnect := False;
             LoginPrompt := False;
             Name := 'SQLConn';
             VendorLib := 'libgds.so.0';
             Params.Clear;
             Params.Add('DriverName=Interbase');
             Params.Add('Database='+DBServer+':'+DBPath+DBName);
             //Params.Add('RoleName='+DBrole);
             Params.Add('User_Name=sysdba');
             Params.Add('Password=masterkey');
             Params.Add('ServerCharSet=ISO8859_1');
             Params.Add('SQLDialect=3');
             Params.Add('ErrorResourceFile=./DbxIbErr.msg');
             Params.Add('LocaleCode=0000');
             Params.Add('BlobSize=-1');
             Params.Add('CommitRetain=False');
             Params.Add('WaitOnLocks=True');
             Params.Add('Interbase TransIsolation=ReadCommited');
           end;

// Validar Consultas, Ejecutar y Crear XML
           for i := 0 to AList.Count - 1 do begin
            SQLConn.Open;
            Tipo := Fields[i].FieldTipo;
            Sentencia := Fields[i].FieldSentencia;            System.WriteLn('Sentencia tipo:'+Tipo);
            System.WriteLn('Consultado sentencia:'+Sentencia);
            case validatipo(tipo) of
              0: XmlRet := fSelect(SQLConn,XmlDocRet,i,Sentencia);
              1: XmlRet := fInsert(SQLConn,XmlDocRet,i,Sentencia);
              2: XmlRet := fDelete(SQLConn,XmlDocRet,i,Sentencia);
              3: XmlRet := fUpdate(SQLConn,XmlDocRet,i,Sentencia);
            else
             XmlRet := fExecute(SQLConn,XmlDocRet,i,Sentencia);
            end;
            SQLConn.Close;
           end;         end;
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
    AStream.Seek(0,0);
    Athread.Connection.WriteInteger(AStream.Size);
    Athread.Connection.OpenWriteBuffer;
    Athread.Connection.WriteStream(AStream);
    Athread.Connection.CloseWriteBuffer;
end;
function TfrmMain.fSelect(var SQLConn:TSQLConnection;Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
var ANode,Nodo,Nodo1:TXmlNode;    SQLQuery:TSQLQuery;
    Cadena:String;
    i:integer;
    Hay:Boolean;
begin
   edlog.Text := edlog.text + sentencia;
   SQLQuery := TSQLQuery.Create(nil);
   SQLQuery.NoMetaData := True;
   SQLQuery.ParamCheck := False;
   SQLQuery.SQLConnection := SQLConn;
   SQLQuery.SQL.Text := sentencia;
    ANode := Xml.Root.NodeNew('consulta'+Format('%.3d',[csc]));
   try
     SQLQuery.Open;
     System.WriteLn('Consulta Realizada');
     Hay := False;
     while Not SQLQuery.Eof do
     begin
        Hay := True;
        break;
     end;
     if Hay then
     begin
      Anode.AttributeAdd('campos',SQLQuery.Fields.Count);
      for i := 1 to SQLQuery.Fields.Count do
      begin
        Anode.AttributeAdd('campotipo'+inttostr(i),FldToStr(SQLQuery.Fields[i-1].DataType));
        Anode.AttributeAdd('camponombre'+inttostr(i),SQLQuery.Fields[i-1].FieldName);
        Anode.AttributeAdd('campotamano'+inttostr(i),SQLQuery.Fields[i-1].Size);
      end;
      while not SQLQuery.Eof do
      begin
       Cadena := '';
       Nodo:= ANode.NodeNew('Registro');
       for i := 0 to SQLQuery.Fields.Count - 1 do
       begin
           if SQLQuery.Fields[i].DataType in [ftBlob,ftGraphic] then
           begin
                Nodo1 := Nodo.NodeNew('campo');
                Nodo1.BinaryEncoding := xbeBase64;
                Nodo1.BinaryString := SQLQuery.Fields[i].AsString;
           end
           else
           begin
             Nodo1 := Nodo.NodeNew('campo');
             Nodo1.ValueAsString := SQLQuery.Fields[i].AsString;
           end;
       end;
       SQLQuery.Next;
      end;
      end;
      fSelect := True;
    except
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('campo','Error en la Consulta');
     fSelect := False;
    end;
end;

function TfrmMain.fInsert(var SQLConn:TSQLConnection;Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;var ANode,Nodo:TXmlNode;
    SQLQuery:TSQLQuery;
    i:integer;
begin
    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := SQLConn;
    SQLQuery.SQL.Text := sentencia;
    ANode := Xml.Root.NodeNew('consulta'+Format('%.3d',[csc]));
    try
     i := SQLQuery.ExecSQL;
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('filas',InttoStr(i));
     fInsert := True;
    except
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('campo','Error en la Consulta');
     fInsert := False;
    end;
end;
function TfrmMain.fDelete(var SQLConn:TSQLConnection;Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;var ANode,Nodo:TXmlNode;
    SQLQuery:TSQLQuery;
    i:integer;
begin
    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := SQLConn;
    SQLQuery.SQL.Text := sentencia;
    ANode := Xml.Root.NodeNew('consulta'+Format('%.3d',[csc]));
    try
     i := SQLQuery.ExecSQL;
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('filas',InttoStr(i));
     fDelete := True;
    except
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('campo','Error en la Consulta');
     fDelete := False;
    end;
end;

function TfrmMain.fUpdate(var SQLConn:TSQLConnection;Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;var
    ANode,Nodo:TXmlNode;
    SQLQuery:TSQLQuery;
    i:integer;
begin
    SQLQuery := TSQLQuery.Create(nil);
    SQLQuery.SQLConnection := SQLConn;
    SQLQuery.SQL.Text := sentencia;    
    ANode := Xml.Root.NodeNew('consulta'+Format('%.3d',[csc]));
    try
     i := SQLQuery.ExecSQL;
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('filas',InttoStr(i));
     fUpdate := True;
    except
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('campo','Error en la Consulta');
     fUpdate := False;
    end;
end;

function TfrmMain.fExecute(var SQLConn:TSQLConnection;Xml:TsdXmlDocument;csc:Integer;sentencia:String):Boolean;
var ANode,Nodo:TXmlNode;
begin
    ANode := Xml.Root.NodeNew('consulta'+Format('%.3d',[csc]));
    try
     SQLConn.Execute(sentencia,nil,nil);
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('filas','Ejecutado');
     fExecute := True;
    except
     Nodo:= ANode.NodeNew('Registro');
     Nodo.WriteString('campo','Error en la Consulta');
     fExecute := False;
    end;

end;

procedure TfrmMain.IdTCPServer1Execute(AThread: TIdPeerThread);
begin
      if Athread.Connection.RecvBufferSize > 0 then
      begin
        Ejecutar(AThread);
      end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  MiIni:string;
begin
     MiIni := ChangeFileExt(Application.ExeName,'.ini');
     shortdateformat := 'yyyy/mm/dd';
     decimalseparator := '.';
     with TIniFile.Create(MiIni) do
     begin
       DBServer := ReadString('SERVER','servidor','0.0.0.0');
       DBPath := ReadString('SERVER','ruta','/var/db/fbird/');
       DBName := ReadString('SERVER','nombre','database.fdb');
       IDtiempo := StrToInt(ReadString('SERVER','tiempo','0'));
       IDpuerto := StrToInt(ReadString('SERVER','puerto','0'));
       DBrole := ReadString('SERVER','rolename','0');
       DBpassword := ReadString('SERVER','password','0');
       DBuser := ReadString('SERVER','username','0')
     end;
     
     IdTCPServer1.TerminateWaitTime := IDtiempo;
     IdTCPServer1.DefaultPort := IDpuerto;
     IdTCPServer1.Active := True;
     lblDatabase.Caption := DBServer + ':' + DBPath + DBName;
     lblpuerto.caption := inttostr(Idpuerto);
end;

function TfrmMain.FldToStr(const Value : TFieldType) : String;
begin
   Case Value of
   ftUnknown    :  FldToStr := 'Unknown';
   ftString     :  FldToStr := 'String';
   ftSmallint   :  FldToStr := 'SmallInt';
   ftInteger    :  FldToStr := 'Integer';
   ftWord       :  FldToStr := 'Word';
   ftBoolean    :  FldToStr := 'Boolean';
   ftFloat      :  FldToStr := 'Float';
   ftCurrency   :  FldToStr := 'Currency';
   ftBCD        :  FldToStr := 'BCD';
   ftDate       :  FldToStr := 'Date';
   ftTime       :  FldToStr := 'Time';
   ftDateTime   :  FldToStr := 'DateTime';
   ftBytes      :  FldToStr := 'Bytes';
   ftVarBytes   :  FldToStr := 'VarBytes';
   ftAutoInc    :  FldToStr := 'AutoInc';
   ftBlob       :  FldToStr := 'Blob';
   ftMemo       :  FldToStr := 'Memo';
   ftGraphic    :  FldToStr := 'Graphic';
   ftFmtMemo    :  FldToStr := 'FmtMemo';
   ftParadoxOle :  FldToStr := 'ParadoxOle';
   ftDBaseOle   :  FldToStr := 'DBaseOle';
   ftTypedBinary: FldToStr := 'TypedBinary';
   ftCursor     :  FldToStr := 'Cursor';
   ftFixedChar  :  FldToStr := 'FixedChar';
   ftWideString :  FldToStr := 'WideString';
   ftLargeint   :  FldToStr := 'LargeInt';
   ftADT        :  FldToStr := 'ADT';
   ftArray      :  FldToStr := 'Array';
   ftReference  :  FldToStr := 'Reference';
   ftDataSet    :  FldToStr := 'DataSet';
   ftOraBlob    :  FldToStr := 'OraBlob';
   ftOraClob    :  FldToStr := 'OraClob';
   ftVariant    :  FldToStr := 'Variant';
   ftInterface  :  FldToStr := 'Interface';
   ftIDispatch  :  FldToStr := 'IDispatch';
   ftGuid       :  FldToStr := 'GUID';
   ftTimeStamp  :  FldToStr := 'TimeStamp';
   ftFMTBcd     :  FldToStr := 'FMTBcd';
   end;
end;


procedure TfrmMain.btnApagarClick(Sender: TObject);
begin
  IdTCPServer1.Active := False;
  Close;
end;

function TfrmMain.ValidaTipo(vTipo: string): integer;
begin
        if vTipo = 'select' then
           Result := 0
        else if vTipo = 'insert' then
           Result := 1
        else if vTipo = 'delete' then
           Result := 2
        else if vTipo = 'update' then
           Result := 3
        else if vTipo = 'drop' then
           Result := 4
        else if vTipo = 'alter' then
           Result := 5
        else if vTipo = 'create' then
           Result := 6
        else if vTipo = 'revoke' then
           Result := 7
        else if vTipo = 'grant' then
           Result := 8
        else
           Result := -1
end;

end.
