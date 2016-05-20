unit Unit1;

interface
uses IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

uses sdXmlDocuments,Classes,DBClient;
type
   TtCP = class
     private
        IdTCP: TIdTCPClient;
        procedure iTCPWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
     public
     procedure Create;

   end;

implementation
procedure TTcp.Create;
begin
        IdTCP.OnWork := iTCPWork;
end;

procedure TTcp.iTCPWork(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
          frmProgreso.InfoLabel := 'Kbs Enviados : ' + CurrToStr(AWorkCount/1000);
          frmProgreso.Position := AWorkCount;
          Application.ProcessMessages;
end;
end.
