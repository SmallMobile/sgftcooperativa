unit UnitCopia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IBServices, StdCtrls, ExtCtrls, Buttons;

type
  TFrmCopia = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    IB: TIBBackupService;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCopia: TFrmCopia;

implementation
uses UnitGlobales;

{$R *.dfm}

procedure TFrmCopia.BitBtn1Click(Sender: TObject);
var _sFile :string;
    i :Integer;
begin
        IB.ServerName := DBServer;
        IB.DatabaseName := DBpath + DBnombre;
        if not DirectoryExists('c:\BackupFiltros') then
           CreateDir('c:\BackupFiltros');
          _sFile := 'c:\BackupFiltros\GbkFiltro.gbk';
        IB.BackupFile.Append(_sFile);
        IB.Active := true;
        Ib.ServiceStart;
        while not ib.Eof do
          memo1.Lines.Add(ib.GetNextLine);
        memo1.Lines.Add('/********************************/');
        memo1.Lines.Add('PROCESO REALIZADO CON EXITO');
        memo1.Lines.Add('Ruta del Backup');
        memo1.Lines.Add(_sFile);
        BitBtn1.Enabled := False;
 end;
end.
