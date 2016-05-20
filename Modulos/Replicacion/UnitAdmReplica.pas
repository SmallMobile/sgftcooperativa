unit UnitAdmReplica;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QButtons, DBXpress, FMTBcd, DB, SqlExpr, QComCtrls,
  QGrids, QMenus, QTypes;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    General1: TMenuItem;
    Administracin1: TMenuItem;
    CerrarManager1: TMenuItem;
    BasesFuente1: TMenuItem;
    BasesDestino1: TMenuItem;
    N1: TMenuItem;
    CerrarManager2: TMenuItem;
    Definiciones1: TMenuItem;
    AplicarDefiniciones1: TMenuItem;
    procedure CerrarManager2Click(Sender: TObject);
    procedure CerrarManager1Click(Sender: TObject);
    procedure BasesFuente1Click(Sender: TObject);
    procedure BasesDestino1Click(Sender: TObject);
    procedure Definiciones1Click(Sender: TObject);
    procedure AplicarDefiniciones1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.xfm}

uses UnitAdmManager, UnitBasesFuentes, UnitBasesDestino, UnitDefinicion,
     UnitAplicarDefinicion;

procedure TfrmMain.CerrarManager2Click(Sender: TObject);
begin
        Application.Terminate;
end;

procedure TfrmMain.CerrarManager1Click(Sender: TObject);
var
  frmAdmMgr:TfrmAdmMgr;
begin
   frmAdmMgr := TfrmAdmMgr.Create(Self);
   frmAdmMgr.ShowModal;
end;

procedure TfrmMain.BasesFuente1Click(Sender: TObject);
var
  frmMgrFuentes:TfrmMgrFuentes;
begin
  frmMgrFuentes := TfrmMgrFuentes.Create(Self);
  frmMgrFuentes.ShowModal;
end;

procedure TfrmMain.BasesDestino1Click(Sender: TObject);
var
  frmMgrDestino:TfrmMgrDestino;
begin
  frmMgrDestino := TfrmMgrDestino.Create(Self);
  frmMgrDestino.ShowModal;
end;

procedure TfrmMain.Definiciones1Click(Sender: TObject);
var
  frmDefiniciones:TfrmDefiniciones;
begin
  frmDefiniciones := TfrmDefiniciones.Create(Self);
  frmDefiniciones.ShowModal;
end;

procedure TfrmMain.AplicarDefiniciones1Click(Sender: TObject);
var frmAplicarDefinicion:TfrmAplicarDefinicion;
begin
  frmAplicarDefinicion := TfrmAplicarDefinicion.Create(Self);
  frmAplicarDefinicion.ShowModal;
end;

end.
