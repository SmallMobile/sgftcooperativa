unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls,
  IdThreadMgr, IdThreadMgrDefault, sdXmlDocuments,JclShell,JclSysUtils,strutils,
  DB, DBClient, ShellCtrls;

type
  TForm1 = class(TForm)
    IdTCPServer1: TIdTCPServer;
    Button1: TButton;
    IdThread: TIdThreadMgrDefault;
    Memo1: TMemo;
    Memo2: TMemo;
    CDrespuesta: TClientDataSet;
    CDrespuestarespuesta: TStringField;
    CDrespuestatipo: TIntegerField;
    Button2: TButton;
    Scambio: TShellChangeNotifier;
    ShellChangeNotifier1: TShellChangeNotifier;
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
  private
    function lee_archivo(cadena:string): string;    { Private declarations }
  public
  published

    function recupera: string;

    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.IdTCPServer1Execute(AThread: TIdPeerThread);
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
begin
        a := 0;
        XmlDoc := TsdXmlDocument.CreateName('equivida');//xml de entrada
        XmlDoc.EncodingString := 'ISO8859-1';
        XmlDoc.XmlFormat := xfReadable;
        Xmlres := TsdXmlDocument.CreateName('retorno');// xml de salida
        Xmlres.EncodingString := 'ISO8859-1';
        Xmlres.XmlFormat := xfReadable;
        Astream := TStringStream.Create('');
        tamano := AThread.Connection.ReadInteger;
        AThread.Connection.ReadStream(Astream,tamano,false);
        Memo1.Text := '';
        Memo2.Text := '';
        XmlDoc.LoadFromStream(Astream);
        nodo := XmlDoc.Root.NodeByName('registro');
        XmlDoc.SaveToFile('c:\xml\eje10.xml');
try
        with nodo do
        begin
          Archivo := ReadString('cedula');
          Memo1.Lines.Add(ReadString('cedula') + #9 + ReadString('nombre') +
          #9 + ReadString('direccion') + #9 + ReadString('telefono')+ #9 +
          ReadString('consecutivo')+ #9 + ReadString('ciudad')+ #9 +
          ReadString('ciudad_nacimiento')+ #9 + ReadString('fecha_nacimiento'));
          Memo1.Lines.SaveToFile('c:\convenio\entrada\'+ Archivo + '.txt');
          ShellExecEx('c:\convenio\importar\importar.exe','','',2);
          while FileExists('c:\convenio\salida\'+ Archivo + '.res') = false do
             a := a + 1;
          //Reset
          if FileExists('c:\convenio\salida\'+ Archivo + '.res') then
            // Memo2.Lines.LoadFromFile('c:\convenio\salida\'+ Archivo + '.res');
            respuesta := lee_archivo('c:\convenio\salida\'+ Archivo + '.res');
          DeleteFile('c:\convenio\salida\'+ Archivo + '.res');
        end;
        Astream := TStringStream.Create('');
        Xmlres.Root.WriteString('respuesta',respuesta);
        Xmlres.SaveToFile('c:\xml\res.xml');
        Xmlres.SaveToStream(Astream);
        AThread.Connection.WriteInteger(Astream.Size);
        AThread.Connection.OpenWriteBuffer;
        AThread.Connection.WriteStream(Astream);
        AThread.Connection.CloseWriteBuffer;
       except
       begin
        DeleteFile('c:\convenio\salida\'+ Archivo + '.res');
        Astream := TStringStream.Create('');
        Xmlres.SaveToFile('c:\xml\res.xml');
        Xmlres.SaveToStream(Astream);
        AThread.Connection.WriteInteger(Astream.Size);
        AThread.Connection.OpenWriteBuffer;
        AThread.Connection.WriteStream(Astream);
        AThread.Connection.CloseWriteBuffer;
       end;
       end;

end;

function TForm1.lee_archivo(cadena:string): string;
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

function TForm1.recupera: string;
begin
end;

end.
