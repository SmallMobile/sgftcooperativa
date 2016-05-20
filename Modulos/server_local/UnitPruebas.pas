unit UnitPruebas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sdXmlDocuments, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient;

type
  TForm1 = class(TForm)
    Button1: TButton;
    IdTCPClient1: TIdTCPClient;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var     Astream :TStringStream;
        XmlDoc,Xmlres,RDoc :TsdXmlDocument;
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
        XmlDoc := TsdXmlDocument.CreateName('equivida');
        XmlDoc.EncodingString := 'ISO8859-1';
        XmlDoc.XmlFormat := xfReadable;
        Nodo := XmlDoc.Root.NodeNew('registro');
        with Nodo do
        begin
          WriteString('cedula',Edit1.Text);
          WriteString('nombre','wum');
          WriteString('direccion','der');
          WriteString('telefono','d');
          WriteString('consecutivo','0');
          WriteString('ciudad','s');
          WriteString('ciudad_nacimiento','de');
          WriteString('fecha_nacimiento','s');
        end;
          AStream := TStringStream.Create('');
          XmlDoc.SaveToFile('c:\informacion.xml');
          XmlDoc.SaveToStream(AStream);
        with IdTCPClient1 do
        begin
          Host := '192.168.200.252';
          Port := 4001;
          try
          Connect;
          except
          begin
            MessageDlg('Error en la Conexión',mtInformation,[mbok],0);
            Exit;
          end;
          end;
          if Connected then
          begin
            WriteInteger(AStream.Size);
            OpenWriteBuffer;
            WriteStream(AStream);
            CloseWriteBuffer;
            FreeAndNil(AStream);
            tamano := ReadInteger;
//            Application.ProcessMessages;
            AStream := TStringStream.Create('');
            ReadStream(AStream,tamano,False);
            RDoc := TsdXmlDocument.Create;
            RDoc.LoadFromStream(AStream);
            for i := 0 to RDoc.Root.NodeCount -1 do
              respuesta := Rdoc.Root.Nodes[i].ValueAsString + #13 + respuesta;
            Disconnect;
          end;
        end;
        ShowMessage(respuesta);

end;

end.
