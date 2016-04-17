unit unitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, ActnList, StdActns, ComCtrls,
  ToolWin, unitdmGeneral, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdTime, ExtCtrls, DateUtils, IBSQL;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    ImageList: TImageList;
    PrinterSetupDialog: TPrinterSetupDialog;
    ActionList: TActionList;
    Mnu01: TMenuItem;
    SalirdePSI1: TMenuItem;
    Configurar_Impresora: TAction;
    N2: TMenuItem;
    Informes1: TMenuItem;
    ProcesosEspeciales1: TMenuItem;
    ToolBar1: TToolBar;
    BtnComprobante: TToolButton;
    ToolButton2: TToolButton;
    BtnExtracto: TToolButton;
    ToolButton3: TToolButton;
    BtnConsultaPersona: TToolButton;
    ToolButton5: TToolButton;
    BtnSalir: TToolButton;
    IdTime1: TIdTime;
    MantenimientodelPUC1: TMenuItem;
    N3: TMenuItem;
    CierredelDa1: TMenuItem;
    MayoryBalance1: TMenuItem;
    BalanceGeneralDetallado1: TMenuItem;
    EstadodeIngresosyGastos1: TMenuItem;
    InformeCajaDiario1: TMenuItem;
    LibrosAuxiliares1: TMenuItem;
    N4: TMenuItem;
    PlanillaResumen1: TMenuItem;
    N5: TMenuItem;
    RecuperacindeSaldos1: TMenuItem;
    ProcesosAnuales1: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    N9: TMenuItem;
    Gestiones1: TMenuItem;
    Timer1: TTimer;
    Timer2: TTimer;
    AjusteComprobantes1: TMenuItem;
    ImportarSaldosIniciales1: TMenuItem;
    SaldosIniciales1: TMenuItem;
    IBSQL1: TIBSQL;
    NotasFindeMes1: TMenuItem;
    CierredeAo1: TMenuItem;
    N6: TMenuItem;
    ComprobantedeCierre1: TMenuItem;
    MantenimientodePersonas1: TMenuItem;
    N11: TMenuItem;
    ExportarSaldosFinales1: TMenuItem;
    Seguridad1: TMenuItem;
    CopiadeSeguridad1: TMenuItem;
    procedure Configurar_ImpresoraExecute(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSalirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure MayoryBalance1Click(Sender: TObject);
    procedure BalanceGeneralDetallado1Click(Sender: TObject);
    procedure InformeCajaDiario1Click(Sender: TObject);
    procedure LibrosAuxiliares1Click(Sender: TObject);
    procedure MantenimientodePersonas1Click(Sender: TObject);
    procedure CierredelDa1Click(Sender: TObject);
    procedure RecuperacindeSaldos1Click(Sender: TObject);
    procedure PlanillaResumen1Click(Sender: TObject);
    procedure CopiadeSeguridad1Click(Sender: TObject);
  private
    { Private declarations }
    SalirMal:Boolean;
    TheGraphic: TBitmap;
    FUltimaActividad:TDateTime;
    procedure AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
  public
  ruta1 :string;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  FechaHora: TDateTime;
implementation

{$R *.dfm}

uses UnitGlobales, UnitBalanceGeneral, UnitBalanceGralDetallado,
  UnitCajaDiario, UnitInformeAuxiliar, UnitPersona, unitCierreDia,
  UnitRecuperacionsaldos, UnitPlanillaResumen, UnitCopia;

procedure TfrmMain.Configurar_ImpresoraExecute(Sender: TObject);
begin
        PrinterSetupDialog.Execute;
end;

procedure TfrmMain.FormPaint(Sender: TObject);
begin
    frmMain.Canvas.Draw(0, 0, TheGraphic);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
        Self.Caption := 'Módulo Contable - ' + DBserver;
        if SalirMal then
           Self.Close;
end;



procedure TfrmMain.BtnSalirClick(Sender: TObject);
begin
        Close;
end;


procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
        FechaHora := Date;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
      try
        IdTime1.Host := DBserver;
        IdTime1.SyncTime;
        IdTime1.DateTime;
      finally
        IdTime1.Disconnect;
      end;

end;

procedure TfrmMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
        FechaHora := Date;
end;

procedure tfrmmain.AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
begin
  case Msg.Message of
    WM_KEYFIRST..WM_KEYLAST,
    WM_LBUTTONDOWN..WM_MOUSELAST: FUltimaActividad := Now;
  end;
end;


procedure TfrmMain.FormCreate(Sender: TObject);
begin
       //****
      DBNombre := 'database.fdb';
      DBServer := 'localhost';
      DBpath := 'C:\ProyContabilidad\';
      dmGeneral := TdmGeneral.Create(self);
      dmGeneral.IBDatabase1.Connected := False;
      dmGeneral.IBDatabase1.DatabaseName := DBServer + ':' + DBpath + DBNombre;
      dmGeneral.IBDatabase1.Connected := True;
      dmGeneral.IBTransaction1.Active := True;
       Agencia := 1;
       Empresa := 'CREDISERVIR LTDA';
       Nit := '890.505.636-3';
end;

procedure TfrmMain.MayoryBalance1Click(Sender: TObject);
begin
        frmBalanceGeneral := TfrmBalanceGeneral.Create(Self);
        frmBalanceGeneral.ShowModal;
end;

procedure TfrmMain.BalanceGeneralDetallado1Click(Sender: TObject);
begin
        FrmBalanceGralDetallado := TFrmBalanceGralDetallado.Create(Self);
        frmBalanceGralDetallado.ShowModal
end;

procedure TfrmMain.InformeCajaDiario1Click(Sender: TObject);
begin
        frmCajaDiario := TfrmCajaDiario.Create(Self);
        frmCajaDiario.ShowModal
end;

procedure TfrmMain.LibrosAuxiliares1Click(Sender: TObject);
begin
        frmInformeAuxiliares := tfrmInformeAuxiliares.Create(Self);
        frmInformeAuxiliares.ShowModal;
end;

procedure TfrmMain.MantenimientodePersonas1Click(Sender: TObject);
begin
        FrmPersona := TFrmPersona.Create(Self);
        FrmPersona.ShowModal;
end;

procedure TfrmMain.CierredelDa1Click(Sender: TObject);
begin
        frmcierredia := Tfrmcierredia.Create(Self);
        frmcierredia.ShowModal;
end;

procedure TfrmMain.RecuperacindeSaldos1Click(Sender: TObject);
begin
        frmrecuperacionsaldos := Tfrmrecuperacionsaldos.Create(Self);
        frmrecuperacionsaldos.ShowModal
end;

procedure TfrmMain.PlanillaResumen1Click(Sender: TObject);
begin
        frmPlanillaResumen := TfrmPlanillaResumen.Create(Self);
        frmPlanillaResumen.ShowModal;
end;

procedure TfrmMain.CopiadeSeguridad1Click(Sender: TObject);
begin
        FrmCopia := TFrmCopia.Create(self);
        FrmCopia.ShowModal
end;

end.
