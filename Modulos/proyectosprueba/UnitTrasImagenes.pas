unit UnitTrasImagenes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBCustomDataSet, IBQuery, IBDatabase, ExtCtrls,
  Buttons, StrUtils, JvComponent, JvSimpleXml, IdBaseComponent, IdCoder,
  IdComponent, IdTCPConnection, IdTCPClient,sdXmlDocuments, IdCoder3To4, Zlib;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edId: TEdit;
    edPer: TEdit;
    ImgFotoC: TImage;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    Label3: TLabel;
    edBase: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edUser: TEdit;
    edPassword: TEdit;
    btnCargar: TBitBtn;
    btnRecuperar: TBitBtn;
    ImgHuellaC: TImage;
    ImgFirmaC: TImage;
    BitBtn1: TBitBtn;
    IdTCPClient1: TIdTCPClient;
    procedure btnCargarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{ Compress a stream }

procedure CompressStream(inpStream, outStream: TStream);
var
  InpBuf, OutBuf: Pointer;
  InpBytes, OutBytes: Integer;
begin
  InpBuf := nil;
  OutBuf := nil;
  try
    GetMem(InpBuf, inpStream.Size);
    inpStream.Position := 0;
    InpBytes := inpStream.Read(InpBuf^, inpStream.Size);
    CompressBuf(InpBuf, InpBytes, OutBuf, OutBytes);
    outStream.Write(OutBuf^, OutBytes);
  finally
    if InpBuf <> nil then FreeMem(InpBuf);
    if OutBuf <> nil then FreeMem(OutBuf);
  end;
end;


{ Decompress a stream }
procedure DecompressStream(inpStream, outStream: TStream);
var
  InpBuf, OutBuf: Pointer;
  OutBytes, sz: Integer;
begin
  InpBuf := nil;
  OutBuf := nil;
  sz     := inpStream.Size - inpStream.Position;
  if sz > 0 then 
    try
      GetMem(InpBuf, sz);
      inpStream.Read(InpBuf^, sz);
      DecompressBuf(InpBuf, sz, 0, OutBuf, OutBytes);
      outStream.Write(OutBuf^, OutBytes);
    finally
      if InpBuf <> nil then FreeMem(InpBuf);
      if OutBuf <> nil then FreeMem(OutBuf);
    end;
  outStream.Position := 0;
end;

procedure TForm1.btnCargarClick(Sender: TObject);
var
 xmldoc:TsdXmlDocument;
 nodo:TXmlNode;
 host:string;
 base:string;
 IMfoto :TStream;
 IMhuella :TStream;
 IMfirma :TStream;
 XmlStm:TStream;
 ComStm:TStream;
 s:string;
 longitud:Integer;
begin
        host := LeftStr(edBase.Text,Pos(':',edBase.Text) - 1);
        base := RightStr(edBase.Text,Length(edBase.Text) - Pos(':',edBase.Text));
        IBDatabase1.DatabaseName := edBase.Text;
        IBDatabase1.Params.Add('user_name='+edUser.Text);
        IBDatabase1.Params.Add('password='+edPassword.Text);
        IBDatabase1.Params.Add('lc_ctype=ISO8859_1');
        IBDatabase1.LoginPrompt := False;
        IBDatabase1.Open;
        if IBDatabase1.Connected then
        begin
           IBTransaction1.DefaultDatabase := IBDatabase1;
           IBTransaction1.StartTransaction;
           IBQuery1.Database := IBDatabase1;
           IBQuery1.Close;
           IBQuery1.SQL.Clear;
           IBQuery1.SQL.Add('select FOTO,FIRMA,FOTO_HUELLA from "gen$persona" ');
           IBQuery1.SQL.Add('where ID_IDENTIFICACION = :ID_IDENTIFICACION and');
           IBQuery1.SQL.Add('ID_PERSONA = :ID_PERSONA');
           IBQuery1.ParamByName('ID_IDENTIFICACION').AsInteger := StrToInt(edid.Text);
           IBQuery1.ParamByName('ID_PERSONA').AsString := edPer.Text;
           try
             IBQuery1.Open;
           except
             IBTransaction1.Rollback;
             IBDatabase1.Close;
             raise;
             Exit;
           end;

           IMfoto := TMemoryStream.Create;
           TBlobField(IBQuery1.FieldByName('FOTO')).SaveToStream(IMfoto);
           IMfoto.Seek(0,soFromBeginning);
           ImgFotoC.Picture.Bitmap.LoadFromStream(IMfoto);
           ImgFotoC.Repaint;
           ImgFotoC.Picture.Bitmap.Dormant;
           ImgFotoC.Picture.Bitmap.FreeImage;

           IMhuella := TMemoryStream.Create;
           TBlobField(IBQuery1.FieldByName('FOTO_HUELLA')).SaveToStream(IMhuella);
           IMhuella.Seek(0,0);
           ImgHuellaC.Picture.Bitmap.LoadFromStream(IMhuella);
           ImgHuellaC.Repaint;
           ImgHuellaC.Picture.Bitmap.Dormant;
           ImgHuellaC.Picture.Bitmap.FreeImage;

           IMfirma := TMemoryStream.Create;
           TBlobField(IBQuery1.FieldByName('FIRMA')).SaveToStream(IMfirma);
           IMfirma.Seek(0,0);
           ImgFirmaC.Picture.Bitmap.LoadFromStream(IMfirma);
           ImgFirmaC.Picture.Bitmap.Dormant;
           ImgFirmaC.Picture.Bitmap.FreeImage;


           IMfoto.Seek(0,0);
           IMfirma.Seek(0,0);
           IMhuella.Seek(0,0);

           xmldoc := TsdXmlDocument.CreateName('root');
           xmldoc.Root.AttributeAdd('id',edId.Text);
           xmldoc.Root.AttributeAdd('doc',edPer.Text);
           xmldoc.Root.AttributeAdd('cmd','write');

           nodo := xmldoc.Root.NodeNew('foto');
           nodo.BinaryEncoding := xbeBase64;
           nodo.BinaryString := IBQuery1.FieldByName('FOTO').AsString;

           nodo := xmldoc.Root.NodeNew('firma');
           nodo.BinaryEncoding := xbeBase64;
           nodo.BinaryString := IBQuery1.FieldByName('FIRMA').AsString;

           nodo := xmldoc.Root.NodeNew('huella');
           nodo.BinaryEncoding := xbeBase64;
           nodo.BinaryString := IBQuery1.FieldByName('FOTO_HUELLA').AsString;

           IBQuery1.Close;
           IBTransaction1.Commit;
           IBDatabase1.Close;

           XmlStm := TMemoryStream.Create;
           xmldoc.SaveToStream(XmlStm);
           xmldoc.SaveToFile('C:\datos.xml');
           XmlStm.Seek(0,0);
           ComStm := TMemoryStream.Create;
           compressStream(XmlStm,ComStm);
           ComStm.Seek(0,0);
           longitud := ComStm.Size;
           IdTCPClient1.Host := '192.168.200.8';
//           IdTCPClient1.Host := '192.168.200.254';
           IdTCPClient1.Port := 3090;
           IdTCPClient1.Connect;
           if IdTCPClient1.Connected then
           begin
              if IdTCPClient1.ReadLn() = 'Esperando...' then
              begin
                 // enviar Comando
                 IdTCPClient1.WriteLn('write');
                 // enviar Tipo de Documento
                 IdTCPClient1.WriteLn(edId.Text);
                 // enviar Documento
                 IdTCPClient1.WriteLn(edPer.Text);
                 // enviar tamaño del stream
                 IdTCPClient1.WriteInteger(longitud);
                 ComStm.Seek(0,0);
                 // enviar stream
                 IdTCPClient1.OpenWriteBuffer;
                 IdTCPClient1.WriteStream(ComStm);
                 IdTCPClient1.CloseWriteBuffer;
                 IdTCPClient1.Disconnect;
              end;
           end;
           FreeAndNil(XmlStm);
           FreeAndNil(ComStm);
        end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
        Close;
end;

end.
