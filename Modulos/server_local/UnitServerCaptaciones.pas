unit UnitServerCaptaciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls,
  IdThreadMgr, IdThreadMgrDefault, sdXmlDocuments,JclShell,JclSysUtils,strutils,
  DB, DBClient, ShellCtrls,ShellApi, JvComponent, JvTrayIcon, Menus, ADODB,
  JvTransparentForm;

type
  TFrmServerConsultas = class(TForm)
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
    JvTransparentForm1: TJvTransparentForm;
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

    function recupera: string;

    { Public declarations }
  end;
var
  FrmServerConsultas: TFrmServerConsultas;
implementation

{$R *.dfm}

procedure TFrmServerConsultas.IdTCPServer1Execute(AThread: TIdPeerThread);
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
        ADOConnection1.Connected := True;
        ADOConnection1.DefaultDatabase := 'C:\convenio\Data\equivida.dbc';
        //JvTrayIcon1.Hint := 'llego peticion';
        XmlDoc := TsdXmlDocument.CreateName('equivida');//xml de entrada
        XmlDoc.EncodingString := 'ISO8859-1';
        XmlDoc.XmlFormat := xfReadable;
        Xmlres := TsdXmlDocument.CreateName('retorno');// xml de salida
        Xmlres.EncodingString := 'ISO88ñ59-1';
        Xmlres.XmlFormat := xfReadable;
        Astream := TStringStream.Create('');
        tamano := AThread.Connection.ReadInteger;
        AThread.Connection.ReadStream(Astream,tamano,false);
        Memo2.Lines.LoadFromStream(Astream);
        Memo1.Text := '';
        Memo2.Text := '';
        XmlDoc.LoadFromStream(Astream);
        nodo := XmlDoc.Root.NodeByName('registro');
        if nodo.ReadInteger('consecutivo') = 0 then
        begin
          sentencia := 'select certificado,fecha_venc from equivida where  eliminado = 0 and equivida .numdocum = ' + '''' + nodo.ReadString('cedula') + '''';
          try
          with ADOQuery1 do
          begin
            Close;
            SQL.Clear;
            SQL.Add(sentencia);
            Open;
              while not Eof do
              begin
                 JvTrayIcon1.Hint := (DateToStr(FieldByName('fecha_venc').AsDateTime + 45));
                 if  FieldByName('fecha_venc').AsDateTime >= Date then
                 begin
                     nodo := Xmlres.Root.NodeNew('certificado');
                     nodo.ValueAsString := (LeftStr(FieldByName('certificado').AsString,7) + ' - ' + FormatDateTime('yyy/mm/dd',fieldByName('fecha_venc').AsDateTime)) + ' - VIGENTE'
                 end
                 else if (FieldByName('fecha_venc').AsDateTime + 45) >= Date then
                 begin
                     nodo := Xmlres.Root.NodeNew('certificado');
                     nodo.ValueAsString := (LeftStr(FieldByName('certificado').AsString,7) + ' - ' + FormatDateTime('yyy/mm/dd',fieldByName('fecha_venc').AsDateTime)) + ' POR RENOVAR';
                 end;
                Next;
              end;
         end;
         except
         on e: Exception do
             ADOQuery1.Close;
        end;
        ADOConnection1.Connected := False;
        Xmlres.SaveToFile('c:\1.xml');
        Astream := TStringStream.Create('');
        Xmlres.SaveToStream(Astream);
        AThread.Connection.WriteInteger(Astream.Size);
        AThread.Connection.OpenWriteBuffer;
        AThread.Connection.WriteStream(Astream);
        AThread.Connection.CloseWriteBuffer;
       end;
end;

function TFrmServerConsultas.lee_archivo(cadena:string): string;
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

function TFrmServerConsultas.recupera: string;
begin
end;

procedure TFrmServerConsultas.FormCreate(Sender: TObject);
begin
ShowWindow( Application.Handle, SW_HIDE );
   SetWindowLong( Application.Handle, GWL_EXSTYLE,
                  GetWindowLong(Application.Handle, GWL_EXSTYLE) or
                  WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
   ShowWindow( Application.Handle, SW_SHOW );
//   ShowWindow(Application.Handle, SW_MINIMIZE);
end;

procedure TFrmServerConsultas.ejecutar(Ejecutable, Argumentos: string;
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

procedure TFrmServerConsultas.Button1Click(Sender: TObject);
begin
ShowWindow(Application.Handle, SW_MINIMIZE);
end;

procedure TFrmServerConsultas.JvTrayIcon1BalloonHide(Sender: TObject);
begin
        //ShowMessage('Servidor Credivida');
        MessageDlg('Servidor Credivida',mtInformation,[mbok],0);
end;

procedure TFrmServerConsultas.CerrarEquivida1Click(Sender: TObject);
begin
        if InputBox('Servidor Credivida - Captaciones','Favor Digite la Clave','') = '123' then
        begin
          IdTCPServer1.Active := False;
          Close;
        end
        else
          MessageDlg('Error al Intentar Cerrar el Servidor',mtError,[mbok],0)
end;


end.

