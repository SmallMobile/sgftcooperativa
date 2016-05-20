unit UnitMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  IdTCPServer, dom, zlibar, IdCustomTCPServer, IdContext, XmlRead, XmlWrite, Base64,
  Buttons, IniFiles, IdServerIOHandlerStack, IdSSLOpenSSL;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnCerrar: TBitBtn;
    IdTCPServer1: TIdTCPServer;
    Label1: TLabel;
    Label2: TLabel;
    edRecuperadas: TMemo;
    edAlmacenadas: TMemo;
    Label3: TLabel;
    edPuerto: TStaticText;
    procedure btnCerrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
  private
    { private declarations }
    procedure Ejecutar(AContext:TIdContext);
    procedure pSaveImage(InputXml,OutputXml:TXmlDocument);
    procedure pLoadImage(InputXml,OutputXml:TXmlDocument);
  public
    { public declarations }
  end; 

var
  frmMain: TfrmMain;
  puerto:Integer;
  maxcon:Integer;

implementation

{ TfrmMain }

procedure TfrmMain.IdTCPServer1Execute(AContext: TIdContext);
begin
      if  AContext.Connection.IOHandler.RecvBufferSize > 0 then
          Ejecutar(AContext);

end;

procedure TfrmMain.btnCerrarClick(Sender: TObject);
begin
     IdTCPServer1.Active := False;
     Close;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  MiIni:TIniFile;
begin
     MiIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'\serverimages.ini');
     puerto := MiIni.ReadInteger('GENERAL','puerto',3080);
     maxcon := MiIni.ReadInteger('GENERAL','maxcon',20);
     edPuerto.Caption := IntToStr(puerto);
     IdTCPServer1.DefaultPort := puerto;
     IdTCPServer1.MaxConnections := maxcon;
     IdTCPServer1.Active := True;
end;

procedure TfrmMain.Ejecutar(AContext: TIdContext);
var
   InputXml:TXmlDocument;
   OutputXml:TXmlDocument;
   InputStream, OutputStream:TStream;
   InputSize,OutputSize:Int64;
   Root:TDOMNode;
begin
      InputXml := TXmlDocument.Create;
      OutputXml := TXmlDocument.Create;

      AContext.Connection.IOHandler.WriteLn('Esperando...');
      InputStream := TMemoryStream.Create;
      OutputStream := TMemoryStream.Create;
      InputSize := AContext.Connection.IOHandler.ReadInt64;
      AContext.Connection.IOHandler.ReadStream(InputStream,InputSize,False);
      ReadXMLFile(InputXml,InputStream);
      Application.ProcessMessages;
      
      Root := InputXml.DocumentElement.ChildNodes.Item[0];
      if TDOMElement(Root).GetAttribute('cmd') = 'write' then
         pSaveImage(InputXml,OutputXml)
      else
      if TDOMElement(Root).GetAttribute('cmd') = 'read' then
         pLoadImage(InputXml, OutputXml);
         
      WriteXMLFile(OutputXml,OutputStream);
      OutputStream.Seek(0,soFromBeginning);
      AContext.Connection.IOHandler.Write(OutputStream.Size);
      AContext.Connection.IOHandler.WriteBufferOpen;
      AContext.Connection.IOHandler.Write(OutputStream);
      AContext.Connection.IOHandler.WriteBufferClose;
      AContext.Connection.IOHandler.Close;
end;

procedure TfrmMain.pSaveImage(InputXml,OutputXml:TXmlDocument);
var
    Root:TDOMNode;
    FotoStr:TStringStream;
    FirmaStr:TStringStream;
    HuellaStr:TStringStream;
    ISFoto:TStream;
    ISFirma:TStream;
    ISHuella:TStream;
    ISFotoC:TStream;
    ISFirmaC:TStream;
    ISHuellaC:TStream;
    id:integer;
    doc:string;
    NodoImg:TDOMNode;
    NodoTmp:TDOMNode;
begin

     Root := InputXml.DocumentElement.ChildNodes.Item[0];
     NodoImg := Root.ChildNodes.Item[0];
     
     id := strtoint(TDOMElement(Root).GetAttribute('id'));
     doc := TDOMElement(Root).GetAttribute('doc');
     
     NodoTmp   := TDOMElement(NodoImg).ChildNodes.Item[0];
     FotoStr   := TStringStream.Create(NodoTmp.NodeValue);
     NodoTmp   := TDOMElement(NodoImg).ChildNodes.Item[1];
     FirmaStr  := TStringStream.Create(NodoTmp.NodeValue);
     NodoTmp   := TDOMElement(NodoImg).ChildNodes.Item[2];
     HuellaStr := TStringStream.Create(NodoTmp.NodeValue);

     ISFoto   := TBase64DecodingStream.Create(FotoStr);
     ISFirma  := TBase64DecodingStream.Create(FirmaStr);
     ISHuella := TBase64DecodingStream.Create(HuellaStr);
     
     ISFotoC   := TMemoryStream.Create;
     ISFirmaC  := TMemoryStream.Create;
     ISHuellaC := TMemoryStream.Create;
     
     CompressStream(ISFoto,ISFotoC);
     CompressStream(ISFirma,ISFirmaC);
     CompressStream(ISHuella,ISHuellaC);

end;

procedure TfrmMain.pLoadImage(InputXml,OutputXml:TXmlDocument);
begin

end;

initialization
  {$I unitmain.lrs}

end.

