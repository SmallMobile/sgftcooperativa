unit UnitEjemplo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,sdXmlDocuments, DB, IBCustomDataSet, IBQuery,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TFrmEjemplo = class(TForm)
    BitBtn1: TBitBtn;
    IBQuery1: TIBQuery;
    tcpcliente: TIdTCPClient;
    Memo1: TMemo;
    texto: TEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEjemplo: TFrmEjemplo;

implementation

uses UnitdmGeneral;

{$R *.dfm}

procedure TFrmEjemplo.BitBtn1Click(Sender: TObject);
var
  ADoc: TsdXmlDocument;
  AStream: TMemoryStream;
  id_persona :string;
  tamano,i,j : Integer;
begin
  id_persona := '5035698';
  ADoc := TsdXmlDocument.CreateName('Root');
  try
    with ADoc.Root do //.Root.NodeNew('Customer') do
    begin
      IBQuery1.Close;
      IBQuery1.ParamByName('id').AsString := id_persona;
      IBQuery1.Open;
      WriteString('cedula', IBQuery1.FieldByName('ID_PERSONA').AsString);
      WriteString('nombre', IBQuery1.FieldByName('NOMBRE').AsString);
    end;
    ADoc.XmlFormat := xfReadable;
    ADoc.EncodingString := 'ISO-8859-1';
    AStream := TMemoryStream.Create;
    ADoc.SaveToStream(AStream);

    ADoc.SaveToFile('c:\'+id_persona+'.xml');
{    tcpcliente.
    with tcpcliente do begin
       Connect;
       OpenWriteBuffer;
       WriteBuffer(AStream,AStream.Size);
       CloseWriteBuffer;
       tamano := tcpcliente.co
       ReadBuffer(AStream,tamano);}
       ADoc.LoadFromStream(AStream);
       for i := 0 to ADoc.Root.NodeCount do
       begin
       Memo1.Text := Memo1.Text + ADoc.Root.ReadString('cedula','');
       texto.Text := ADoc.Root.ReadString('nombre','');
       end;


    //end;
  finally
    ADoc.Free;
  end;
//end;


end;

end.
