unit UnitServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls,
  IdThreadMgr, IdThreadMgrDefault, sdXmlDocuments,JclShell,JclSysUtils,strutils,
  DB, DBClient, ShellCtrls,ShellApi, JvComponent, JvTrayIcon, Menus, ADODB;

type
  TFrmServer = class(TForm)
    IdTCPServer1: TIdTCPServer;
    IdThread: TIdThreadMgrDefault;
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    JvTrayIcon1: TJvTrayIcon;
    PopupMenu1: TPopupMenu;
    CerrarEquivida1: TMenuItem;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure JvTrayIcon1BalloonHide(Sender: TObject);
    procedure CerrarEquivida1Click(Sender: TObject);
  private
    function lee_archivo(cadena:string): string;
    procedure ejecutar(Ejecutable, Argumentos: string;
      Visibilidad: integer);    { Private declarations }
  public
  published

    function recupera:string;

    { Public declarations }
  end;

var
  FrmServer: TFrmServer;

implementation

{$R *.dfm}

procedure TFrmServer.IdTCPServer1Execute(AThread: TIdPeerThread);
var     Astream :TStringStream;
        XmlDoc,Xmlres :TsdXmlDocument;
        tamano :Integer;
        nodo :TXmlNode;
        nodo1 :TXmlNode;
        Alist :TList;
        i :Integer;
        tamano_m,contador,Posicion,tipo,a :Integer;
        cadena :string;
        Archivo :string;
        respuesta :string;
        sentencia :string;
begin
        a := 0;
        //JvTrayIcon1.Hint := 'llego peticion';
        XmlDoc := TsdXmlDocument.CreateName('equivida');//xml de entrada
        XmlDoc.EncodingString := 'ISO8859-1';
        XmlDoc.XmlFormat := xfReadable;
        Xmlres := TsdXmlDocument.CreateName('retorno');// xml de salida
        Xmlres.EncodingString := 'ISO8859-1';
        Xmlres.XmlFormat := xfReadable;
        Astream := TStringStream.Create('');
        tamano := AThread.Connection.ReadInteger;
        AThread.Connection.ReadStream(Astream,tamano,false);
        Memo2.Lines.LoadFromStream(Astream);
        Memo1.Text := '';
        Memo2.Text := '';
        XmlDoc.LoadFromStream(Astream);
        nodo := XmlDoc.Root.NodeByName('registro');
        if nodo.ReadInteger('consecutivo') > 0 then
        begin
        try
         with nodo do
         begin
          Archivo := ReadString('cedula');
          cadena := (ReadString('cedula') + #9 + ReadString('nombre') +
          #9 + ReadString('direccion') + #9 + ReadString('telefono')+ #9 +
          ReadString('consecutivo')+ #9 + ReadString('ciudad')+ #9 +
          ReadString('ciudad_nacimiento')+ #9 + ReadString('fecha_nacimiento'));
          Memo1.Text := cadena;
          Memo1.Lines.SaveToFile('c:\convenio\entrada\'+ Archivo + '.txt');
          ejecutar('c:\convenio\importar\importar.exe','',2);
          if FileExists('c:\convenio\salida\'+ Archivo + '.res') then
            respuesta := lee_archivo('c:\convenio\salida\'+ Archivo + '.res');
          DeleteFile('c:\convenio\salida\'+ Archivo + '.res');
        end;
        Astream := TStringStream.Create('');
        Xmlres.Root.WriteString('respuesta',respuesta);
        Xmlres.SaveToStream(Astream);
        AThread.Connection.WriteInteger(Astream.Size);
        AThread.Connection.OpenWriteBuffer;
        AThread.Connection.WriteStream(Astream);
        AThread.Connection.CloseWriteBuffer;
       except
       begin
        DeleteFile('c:\convenio\salida\'+ Archivo + '.res');
        Astream := TStringStream.Create('');
        Xmlres.SaveToStream(Astream);
        AThread.Connection.WriteInteger(Astream.Size);
        AThread.Connection.OpenWriteBuffer;
        AThread.Connection.WriteStream(Astream);
        AThread.Connection.CloseWriteBuffer;
       end;
       end;
       end
       else
       begin
        sentencia := 'select certificado,fecha_venc from equivida where  poliza <> '+ '''' + '''' + ' and equivida .numdocum = ' + '''' + nodo.ReadString('cedula') + '''';
        try
        with ADOQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add(sentencia);
          Open;
            while not Eof do
            begin
               IF FieldByName('fecha_venc').AsDateTime > Date then
               begin
                 nodo := Xmlres.Root.NodeNew('certificado');
                 nodo.ValueAsString := (LeftStr(FieldByName('certificado').AsString,7) + ' - ' + FormatDateTime('yyy/mm/dd',fieldByName('fecha_venc').AsDateTime));
               end;
              //Xmlres.Root. := (FieldByName('certificado').AsString + ' - ' + FieldByName('fecha_venc').AsString);
              //ShowMessage(FieldByName('certificado').AsString + ' - ' + FieldByName('fecha_venc').AsString);
              Next;
            end;
       end;
       except
       on e: Exception do
           ADOQuery1.Close;
       end;
        Xmlres.SaveToFile('c:\1.xml');
        Astream := TStringStream.Create('');
        Xmlres.SaveToStream(Astream);
        AThread.Connection.WriteInteger(Astream.Size);
        AThread.Connection.OpenWriteBuffer;
        AThread.Connection.WriteStream(Astream);
        AThread.Connection.CloseWriteBuffer;
       end;
end;

function TFrmServer.lee_archivo(cadena:string): string;
var
        F:TextFile;
        S:string;
begin
        if FileExists(cadena) then begin
          AssignFile(F, cadena);
          Reset(F);
        while not EOF(F) do begin
          ReadLn(F, S);
        end;
          CloseFile(F);
          Result := RightStr(S,1);
end;

end;

function TFrmServer.recupera: string;
begin
end;

procedure TFrmServer.FormCreate(Sender: TObject);
begin
ShowWindow( Application.Handle, SW_HIDE );
   SetWindowLong( Application.Handle, GWL_EXSTYLE,
                  GetWindowLong(Application.Handle, GWL_EXSTYLE) or
                  WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
   ShowWindow( Application.Handle, SW_SHOW );
//   ShowWindow(Application.Handle, SW_MINIMIZE);
end;

procedure TFrmServer.ejecutar(Ejecutable, Argumentos: string;
  Visibilidad: integer);
var
      Info:TShellExecuteInfo;
      pInfo:PShellExecuteInfo;
      exitCode:DWord;
   begin
      {Puntero a Info}
      {Pointer to Info}
      pInfo:=@Info;
      {Rellenamos Info}
      {Fill info}
      With Info do
      begin
       cbSize:=SizeOf(Info);
       fMask:=SEE_MASK_NOCLOSEPROCESS;
       wnd:=Handle;
       lpVerb:=nil;
       lpFile:=PChar(Ejecutable);
       lpParameters:=Pchar(Argumentos+#0);
       lpDirectory:=nil;
       nShow:=Visibilidad;
       hInstApp:=0;
      end;
      ShellExecuteEx(pInfo);
      repeat
       exitCode := WaitForSingleObject(Info.hProcess,500);
       Application.ProcessMessages;
      until (exitCode <> WAIT_TIMEOUT);
end;

procedure TFrmServer.Button1Click(Sender: TObject);
begin
ShowWindow(Application.Handle, SW_MINIMIZE);
end;

procedure TFrmServer.JvTrayIcon1BalloonHide(Sender: TObject);
begin
        //ShowMessage('Servidor Credivida');
        MessageDlg('Servidor Credivida',mtInformation,[mbok],0);
end;

procedure TFrmServer.CerrarEquivida1Click(Sender: TObject);
begin
        IdTCPServer1.Active := False;
        Close;
end;


end.

