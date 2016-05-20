unit unitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, ActnList, StdActns, unitGlobales, ComCtrls,
  ToolWin, unitdmGeneral, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdTime, ExtCtrls, DateUtils;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    ImageList: TImageList;
    PrinterSetupDialog: TPrinterSetupDialog;
    ActionList: TActionList;
    Mnu01: TMenuItem;
    ConfigurarImpresora1: TMenuItem;
    N1: TMenuItem;
    SalirdePSI1: TMenuItem;
    Configurar_Impresora: TAction;
    N2: TMenuItem;
    InformesGerenciales1: TMenuItem;
    ConsultadeGerencia1: TMenuItem;
    ConsultaExtracto1: TMenuItem;
    MnuComprobantes: TMenuItem;
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
    EvaluacinPresupuestal1: TMenuItem;
    ListadodePrueba1: TMenuItem;
    N4: TMenuItem;
    PlanillaResumen1: TMenuItem;
    N5: TMenuItem;
    RecuperacindeSaldos1: TMenuItem;
    Agencias1: TMenuItem;
    MayoryBalance2: TMenuItem;
    BalanceGeneralDetallado2: TMenuItem;
    ProcesosAnuales1: TMenuItem;
    RevalorizacindeAportes1: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    Sumatorias1: TMenuItem;
    N7: TMenuItem;
    ConsultaExtractoColocaciones1: TMenuItem;
    RecuperarLiquidacindeColocacin1: TMenuItem;
    CambiarContrasea1: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    Gestiones1: TMenuItem;
    ControldeCobro1: TMenuItem;
    Consultas1: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    ProcesosEspeciales2: TMenuItem;
    BarridodeAhorrosparaAportes1: TMenuItem;
    InformeCaptaciones1: TMenuItem;
    Timer1: TTimer;
    AplicarAyudasSolidaridadyEducacin1: TMenuItem;
    Timer2: TTimer;
    N16: TMenuItem;
    AjusteComprobantes1: TMenuItem;
    LibrosRegistrados1: TMenuItem;
    PaginacindePapel1: TMenuItem;
    CajaDiario1: TMenuItem;
    MayoryBalance3: TMenuItem;
    Agencias2: TMenuItem;
    ConsolidarBalances2: TMenuItem;
    ImportarSaldosIniciales1: TMenuItem;
    ConsolidarCajaDiario1: TMenuItem;
    N17: TMenuItem;
    Observaciones1: TMenuItem;
    BalanceConsolidado1: TMenuItem;
    EstadodeIngresosyGastosConsolidados1: TMenuItem;
    MantenimientodePrivilegiados1: TMenuItem;
    MantenimientodeTasas1: TMenuItem;
    CierredeAo1: TMenuItem;
    N6: TMenuItem;
    CertificadoRetencinenlaFuente1: TMenuItem;
    procedure Configurar_ImpresoraExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConfigurarImpresora1Click(Sender: TObject);
    procedure SalirdePSI1Click(Sender: TObject);
    procedure ConsultadeGerencia1Click(Sender: TObject);
    procedure ConsultaExtracto1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure BtnExtractoClick(Sender: TObject);
    procedure BtnConsultaPersonaClick(Sender: TObject);
    procedure BtnSalirClick(Sender: TObject);
    procedure MnuComprobantesClick(Sender: TObject);
    procedure BtnComprobanteClick(Sender: TObject);
    procedure CierredelDa1Click(Sender: TObject);
    procedure MayoryBalance1Click(Sender: TObject);
    procedure BalanceGeneralDetallado1Click(Sender: TObject);
    procedure LibrosAuxiliares1Click(Sender: TObject);
    procedure MantenimientodelPUC1Click(Sender: TObject);
    procedure ListadodePrueba1Click(Sender: TObject);
    procedure PlanillaResumen1Click(Sender: TObject);
    procedure RecuperacindeSaldos1Click(Sender: TObject);
    procedure CausacindeColocaciones1Click(Sender: TObject);
    procedure BalanceGeneralDetallado2Click(Sender: TObject);
    procedure RevalorizacindeAportes1Click(Sender: TObject);
    procedure Sumatorias1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ConsultaExtractoColocaciones1Click(Sender: TObject);
    procedure RecuperarLiquidacindeColocacin1Click(Sender: TObject);
    procedure CambiarContrasea1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ControldeCobro1Click(Sender: TObject);
    procedure CdatsPorEdades1Click(Sender: TObject);
    procedure CausacindeCaptaciones1Click(Sender: TObject);
    procedure BarridodeAhorrosparaAportes1Click(Sender: TObject);
    procedure InformeCaptaciones1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure InformeTasaPromedioCdats1Click(Sender: TObject);
    procedure AplicarAyudasSolidaridadyEducacin1Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImportarBalances1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure AjusteComprobantes1Click(Sender: TObject);
    procedure PaginacindePapel1Click(Sender: TObject);
    procedure ConsolidarBalances2Click(Sender: TObject);
    procedure ImportarSaldosIniciales1Click(Sender: TObject);
    procedure MayoryBalance3Click(Sender: TObject);
    procedure ConsolidarCajaDiario1Click(Sender: TObject);
    procedure CajaDiario1Click(Sender: TObject);
    procedure InformeCajaDiario1Click(Sender: TObject);
    procedure Observaciones1Click(Sender: TObject);
    procedure BalanceConsolidado1Click(Sender: TObject);
    procedure EstadodeIngresosyGastosConsolidados1Click(Sender: TObject);
    procedure MantenimientodePrivilegiados1Click(Sender: TObject);
    procedure MantenimientodeTasas1Click(Sender: TObject);
    procedure CierredeAo1Click(Sender: TObject);
    procedure CertificadoRetencinenlaFuente1Click(Sender: TObject);
  private
    { Private declarations }
    SalirMal:Boolean;
    TheGraphic: TBitmap;
    FUltimaActividad:TDateTime;
    procedure AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
  public
    { Public declarations }
    ruta1:string;
  end;

var
  frmMain: TfrmMain;
  FechaHora: TDateTime;

implementation

{$R *.dfm}

uses unitLogin, IniFiles,
     unitConsultaProductos,unitConsultaExtractoCaptacion,
     unit_Comprobante,unit_ComprobanteC,unitCierreDia,UnitBalanceGeneral,
     UnitBalanceGralDetallado,UnitInformeAuxiliar,Unit_Mantenimientopuc,
     UnitListadodePrueba, UnitPlanillaResumen, UnitRecuperacionSaldos,
     UnitCausacionColocaciones, UnitConsolidarBalance, UnitBalanceDetalladoConsolidado,
     UnitSumatorias, UnitExtractoColocacion,
     UnitRecuperarLiquidacioncolocacion, UnitCambiarContrasena,
     UnitControlCobroCartera,unitCdatporEdades,UnitCausacionCdat,UnitBarridoAhoApo,
     UnitListadoCaptacionesConsolidado, UnitRevalorizacionAportes,
     UnitInformeTasaPromedio,unitAyudasSolidaridad, UnitReLogin,
     UnitPaginarPapel,UnitConsolidarBalAgencia, UnitConsolidarSaldoIAgencia,
     UnitLibroRMayorYBalance, UnitConsolidarCajaDiario, UnitLibroCajaDiario,
     UnitCajaDiario,UnitControldeObservaciones,UnitBalanceConsolidado,
     UnitEstadoIyGConsolidado, UnitMantenimientoPrivilegiados, UnitActualizoTasasColocacion,
     UnitCierreAnual, UnitCertificadoRetefuente;

procedure TfrmMain.Configurar_ImpresoraExecute(Sender: TObject);
begin
        PrinterSetupDialog.Execute;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var frmLogin:TfrmLogin;
    Veces :SmallInt;
    Mensaje :String;
    Ruta:string;
    Role:string;
//    frmConectando:TfrmConectando;
begin
  Application.OnMessage := AtraparMensajes;
  Timer2.Enabled := False;

  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(MiINI) do
  try
    DBserver := ReadString('DBNAME','server','192.168.1.8');
    DBPath := ReadString('DBNAME','path','/home/');
    DBname := ReadString('DBNAME','name','coopservir.gdb');
    Empresa := ReadString('EMPRESA','name','COOPSERVIR LTDA');
    Nit     := ReadString('EMPRESA','nit','890.505.363-6');
    Agencia := ReadInteger('EMPRESA','Agencia',1);
    Ciudad  := ReadString('EMPRESA','city','OCAÑA N.S.');
    DBMinutos := ReadFloat('ADICIONALES','timerrelogin',1);
  finally
    free;
  end;
{        IdTime1.Host := DBserver;
        if IdTime1.Connected then
           FechaHoy := IdTime1.DateTime;
        if not IdTime1.SyncTime then
        begin
          SalirMal := True;
          Exit;
        end;
        Timer2.Enabled := False;
}
        control_consulta := True;
        Veces := 0;
        frmLogin := TfrmLogin.Create(Self);
        frmLogin.EdRole.Text := 'CONTABILIDAD_A';
        dmGeneral.IBDatabase1.Connected := false;
        while Not dmGeneral.IBDatabase1.Connected do
          begin
           if Veces = 3 then
           begin
                SalirMal := True;
                Exit;
           end;
          if frmLogin.ShowModal = mrOk then
           begin
             with frmLogin do
             begin
                DBAlias := EdUsuario.Text;
                DBPasabordo:= EdPasabordo.Text;
                Role := EdRole.Text;
                dmGeneral.IBDatabase1.DataBaseName := DBserver + ':' + DBpath + DBname;
                dmGeneral.IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
                dmGeneral.IBDatabase1.Params.Values['User_Name'] := DBAlias;
                dmGeneral.IBDatabase1.Params.Values['PassWord'] := DBPasabordo;
                dmGeneral.IBDatabase1.Params.Values['sql_role_name'] := Role;
                Veces := Veces + 1;

                try
                    dmGeneral.IBDatabase1.Connected := True;
                    dmGeneral.IBTransaction1.Active := True;
                except
                        on E: Exception do
                        begin
                          if StrLIComp(PChar(E.Message),PChar('Your user name'),14) = 0 then
                           begin
                            Mensaje :='Verifique su Nombre y su Contraseña' + #10 + #13 + 'Mensaje:' + E.Message;
                            MessageBox(0,PChar(Mensaje),PChar('Usuario Invalido'),MB_OK OR MB_ICONERROR);
                           end
                          else
                           begin
                            Mensaje := 'Verifique su Configuración o Informe al Administrador de la Red' + #10 + #13 + 'Mensaje:' + E.Message;
                            MessageBox(0,PChar(Mensaje),PChar('Configuración Erronea'),MB_OK OR MB_ICONERROR);
                           end;
                        end; //fin del begin de la excepción.
                end; // fin del try

             end; //fin del begin del with

            end // fin del begin del if superior
          else
          begin
             SalirMal := True;
             Exit;
          end;
         end; // fin del while

  Timer2.Enabled := True;
  FUltimaActividad := Now;
  ShortDateFormat := 'yyyy/mm/dd';
  Ruta := ExtractFilePath(Application.ExeName);
  ruta1 := Ruta;
  TheGraphic := TBitmap.Create; { Create the bitmap object }
  TheGraphic.LoadFromFile(Ruta+'\Coopservir.bmp');
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
           Action := caFree;
end;

procedure TfrmMain.ConfigurarImpresora1Click(Sender: TObject);
begin
        PrinterSetupDialog.Execute;
end;



procedure TfrmMain.SalirdePSI1Click(Sender: TObject);
begin
        Close;
end;


procedure TfrmMain.ConsultadeGerencia1Click(Sender: TObject);
var frmConsultaProductos:TfrmConsultaProductos;
begin
       frmConsultaProductos := TfrmConsultaProductos.Create(Self);
       frmConsultaProductos.ShowModal;
end;


procedure TfrmMain.ConsultaExtracto1Click(Sender: TObject);
var frmConsultaExtractoCaptacion:TfrmConsultaExtractoCaptacion;
begin
        frmConsultaExtractoCaptacion := TfrmConsultaExtractoCaptacion.Create(self);
        frmConsultaExtractoCaptacion.ShowModal;
end;

procedure TfrmMain.FormPaint(Sender: TObject);
begin
    frmMain.Canvas.Draw(0, 0, TheGraphic);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
       if Not SalirMal then
        if MessageDlg('Seguro que desea cerrar SIFCOOPSERVIR',mtConfirmation,[mbYes,mbNo],0) = mrYes Then
         with TIniFile.Create(MiINI) do
          try
            WriteString('DBNAME','server',DBserver);
            WriteString('DBNAME','path',DBpath);
            WriteString('DBNAME','name',DBname);
            WriteString('EMPRESA','name',Empresa);
            WriteString('EMPRESA','nit',Nit);
            WriteInteger('EMPRESA','Agencia',Agencia);
            WriteString('EMPRESA','city',Ciudad);
          finally
           begin
            dmGeneral.IBDatabase1.Connected := False;
            dmGeneral.IBTransaction1.Active  := False;
            dmGeneral.Free;
            CanClose := True;
           end;
          end
        else
            CanClose := False
       else
           begin
            CanClose := True;
           end;

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
        Self.Caption := 'Módulo Contable - ' + DBserver;
        if SalirMal then
           Self.Close;
end;


procedure TfrmMain.BtnExtractoClick(Sender: TObject);
begin
        LibrosAuxiliares1.Click;
end;

procedure TfrmMain.BtnConsultaPersonaClick(Sender: TObject);
begin
        ConsultadeGerencia1.Click;
end;

procedure TfrmMain.BtnSalirClick(Sender: TObject);
begin
        SalirdePSI1.Click;
end;

procedure TfrmMain.MnuComprobantesClick(Sender: TObject);
var frmComprobante:TfrmComprobante;
begin
        frmComprobante := TfrmComprobante.Create(Self);
        frmComprobante.ShowModal;
end;

procedure TfrmMain.BtnComprobanteClick(Sender: TObject);
begin
        MnuComprobantes.Click;
end;

procedure TfrmMain.CierredelDa1Click(Sender: TObject);
var frmcierredia:Tfrmcierredia;
begin
    frmcierredia := Tfrmcierredia.Create(Self);
    frmcierredia.ShowModal;
end;

procedure TfrmMain.MayoryBalance1Click(Sender: TObject);
var frmBalanceGeneral:TfrmBalanceGeneral;
begin
       frmBalanceGeneral := TfrmBalanceGeneral.Create(Self);
       frmBalanceGeneral.ShowModal;
end;

procedure TfrmMain.BalanceGeneralDetallado1Click(Sender: TObject);
var frmBalanceGralDetallado:TfrmBalanceGralDetallado;
begin
        frmBalanceGralDetallado := TfrmBalanceGralDetallado.Create(Self);
        frmBalanceGralDetallado.ShowModal;
end;

procedure TfrmMain.LibrosAuxiliares1Click(Sender: TObject);
var frmInformeAuxiliares :TfrmInformeAuxiliares;
begin
    frmInformeAuxiliares := TfrmInformeAuxiliares.Create(Self);
    frmInformeAuxiliares.ShowModal;
end;

procedure TfrmMain.MantenimientodelPUC1Click(Sender: TObject);
var frmMantenimientopuc:TfrmMantenimientopuc;
begin
     frmMantenimientopuc := TfrmMantenimientopuc.Create(Self);
     frmMantenimientopuc.Agregar := True;
     frmMantenimientopuc.Modificar := True;
     frmMantenimientopuc.Eliminar := True;
     frmMantenimientopuc.ShowModal;
end;

procedure TfrmMain.ListadodePrueba1Click(Sender: TObject);
var frmListadodePrueba:TfrmListadodePrueba;
begin
      frmListadodePrueba := TfrmListadodePrueba.Create(Self);
      frmListadodePrueba.ShowModal;
end;

procedure TfrmMain.PlanillaResumen1Click(Sender: TObject);
var frmPlanillaResumen:TfrmPlanillaResumen;
begin
        frmPlanillaResumen := TfrmPlanillaResumen.Create(Self);
        frmPlanillaResumen.ShowModal;
end;

procedure TfrmMain.RecuperacindeSaldos1Click(Sender: TObject);
var frmRecuperacionSaldos:TfrmRecuperacionSaldos;
begin
        frmRecuperacionSaldos := Tfrmrecuperacionsaldos.Create(Self);
        frmRecuperacionSaldos.ShowModal;
end;

procedure TfrmMain.CausacindeColocaciones1Click(Sender: TObject);
var frmCausacionColocaciones:TfrmCausacionColocaciones;
begin
     frmCausacionColocaciones := TfrmCausacionColocaciones.Create(self);
     frmCausacionColocaciones.ShowModal;
end;

procedure TfrmMain.BalanceGeneralDetallado2Click(Sender: TObject);
var frmBalanceDetalladoConsolidado:tfrmbalancedetalladoconsolidado;
begin
       frmBalanceDetalladoConsolidado:=tfrmbalancedetalladoconsolidado.Create(Self);
       frmBalanceDetalladoConsolidado.ShowModal;
end;

procedure TfrmMain.RevalorizacindeAportes1Click(Sender: TObject);
var frmRevalorizacionAportes:TfrmRevalorizacionAportes;
begin
        frmRevalorizacionAportes := TfrmRevalorizacionAportes.Create(Self);
        frmRevalorizacionAportes.ShowModal;
end;

procedure TfrmMain.Sumatorias1Click(Sender: TObject);
var frmSumatorias:TfrmSumatorias;
begin
      Timer2.Enabled := False;
      frmSumatorias := TfrmSumatorias.Create(Self);
      frmSumatorias.ShowModal;
      Timer2.Enabled := True;
end;

procedure TfrmMain.ToolButton1Click(Sender: TObject);
begin
        Sumatorias1.Click;
end;

procedure TfrmMain.ConsultaExtractoColocaciones1Click(Sender: TObject);
var frmExtractoColocacion:TFrmExtractoColocacion;
begin
        frmextractocolocacion := TFrmExtractoColocacion.Create(Self);
        frmextractocolocacion.ShowModal;
end;

procedure TfrmMain.RecuperarLiquidacindeColocacin1Click(Sender: TObject);
var frmRecuperarLiquidacionColocacion:TfrmRecuperarLiquidacionColocacion;
begin
         frmRecuperarLiquidacionColocacion := TfrmRecuperarLiquidacionColocacion.Create(Self);
         frmRecuperarLiquidacionColocacion.ShowModal;
end;

procedure TfrmMain.CambiarContrasea1Click(Sender: TObject);
var frmCambiarContrasena:TfrmCambiarContrasena;
begin
        frmCambiarContrasena := TfrmCambiarContrasena.Create(self);
        frmCambiarContrasena.ShowModal;
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
        FechaHora := Date;
end;

procedure TfrmMain.ControldeCobro1Click(Sender: TObject);
var frmControlCobroCartera:tfrmControlCobroCartera;
begin
      frmControlCobroCartera := TfrmControlCobroCartera.Create(Self);
      frmControlCobroCartera.Show;
end;

procedure TfrmMain.CdatsPorEdades1Click(Sender: TObject);
var frmCdatporEdades:TfrmCdatporEdades;
begin
        frmCdatporEdades := TfrmCdatporEdades.Create(Self);
        frmCdatporEdades.ShowModal;
end;

procedure TfrmMain.CausacindeCaptaciones1Click(Sender: TObject);
var frmcausacioncdat:Tfrmcausacioncdat;
begin
        frmcausacioncdat := Tfrmcausacioncdat.Create(self);
        frmcausacioncdat.ShowModal;
end;

procedure TfrmMain.BarridodeAhorrosparaAportes1Click(Sender: TObject);
var frmBarridoAhoApo:TfrmBarridoAhoApo;
begin
        frmBarridoAhoApo := TfrmBarridoAhoApo.Create(Self);
        frmBarridoAhoApo.ShowModal;
end;

procedure TfrmMain.InformeCaptaciones1Click(Sender: TObject);
var frmListadoCaptacionesConsolidado : TfrmListadoCaptacionesConsolidado;
begin
        Timer2.Enabled := False;
        frmListadoCaptacionesConsolidado := TfrmListadoCaptacionesConsolidado.Create(Self);
        frmListadoCaptacionesConsolidado.ShowModal;
        Timer2.Enabled := True;
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

procedure TfrmMain.InformeTasaPromedioCdats1Click(Sender: TObject);
var frmInformeTasaPromedio:TfrmInformeTasaPromedio;
begin
        frmInformeTasaPromedio := TfrmInformeTasaPromedio.Create(Self);
        frmInformeTasaPromedio.ShowModal;
end;

procedure TfrmMain.AplicarAyudasSolidaridadyEducacin1Click(
  Sender: TObject);
var frmAyudas:TfrmAyudas;
begin
      frmAyudas := TfrmAyudas.Create(Self);
      frmAyudas.ShowModal;
end;

procedure TfrmMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
        FechaHora := Date;
end;

procedure TfrmMain.ImportarBalances1Click(Sender: TObject);
//var frmImportarPuc:TfrmImportarPuc;
begin
//    frmImportarPuc := TfrmImportarPuc.Create(self);
//   frmImportarPuc.ShowModal;
end;

procedure tfrmmain.AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
begin
  case Msg.Message of
    WM_KEYFIRST..WM_KEYLAST,
    WM_LBUTTONDOWN..WM_MOUSELAST: FUltimaActividad := Now;
  end;
end;


procedure TfrmMain.Timer2Timer(Sender: TObject);
var frmReLogin:TfrmReLogin;
    Pasabordo :string;
    ESPERA:Extended;
begin
  Timer2.Enabled := False;
  ESPERA := ((1 / 24 / 60) * DBMinutos);
  if (FUltimaActividad + ESPERA) < Now then begin
    frmReLogin := TfrmReLogin.Create(Self);
    if frmReLogin.ShowModal = mrOk then
    begin
     Pasabordo := frmReLogin.EdPasabordo.Text;
     if Pasabordo <> DBPasabordo then
      begin
        ShowMessage('Confirmación no valida!, Cerrando el Módulo');
        SalirMal := True;
        Close;
        Exit;
      end;
    end
    else
    begin
        SalirMal := True;
        Close;
        Exit;
    end;
  end;
  Timer2.Enabled := True;
end;

procedure TfrmMain.AjusteComprobantes1Click(Sender: TObject);
var frmComprobanteC:TfrmComprobanteC;
begin
        frmComprobanteC := TfrmComprobanteC.Create(Self);
        frmComprobanteC.ShowModal;
end;

procedure TfrmMain.PaginacindePapel1Click(Sender: TObject);
var frmPaginarPapel:TfrmPaginarPapel;
begin
    frmPaginarPapel := TfrmPaginarPapel.Create(Self);
    frmPaginarPapel.ShowModal;
end;

procedure TfrmMain.ConsolidarBalances2Click(Sender: TObject);
var frmConsolidarBalAgencia:TfrmConsolidarBalAgencia;
begin
        frmConsolidarBalAgencia := TfrmConsolidarBalAgencia.Create(Self);
        frmConsolidarBalAgencia.ShowModal;
end;

procedure TfrmMain.ImportarSaldosIniciales1Click(Sender: TObject);
var frmConsolidarSaldoIAgencia:TfrmConsolidarSaldoIAgencia;
begin
        frmConsolidarSaldoIAgencia := TfrmConsolidarSaldoIAgencia.Create(Self);
        frmConsolidarSaldoIAgencia.ShowModal;
end;

procedure TfrmMain.MayoryBalance3Click(Sender: TObject);
var frmLibroMayorYBalance :TfrmLibroMayorYBalance;
begin
        frmLibroMayorYBalance := TfrmLibroMayorYBalance.Create(Self);
        frmLibroMayorYBalance.ShowModal;
end;

procedure TfrmMain.ConsolidarCajaDiario1Click(Sender: TObject);
var frmConsolidarCajaDiario:TfrmConsolidarCajaDiario;
begin
      frmConsolidarCajaDiario:= TfrmConsolidarCajaDiario.Create(Self);
      frmConsolidarCajaDiario.ShowModal;
end;

procedure TfrmMain.CajaDiario1Click(Sender: TObject);
var frmLibroRCajaDiario:TfrmLibroRCajaDiario;
begin
        frmLibroRCajaDiario:=TfrmLibroRCajaDiario.Create(Self);
        frmLibroRCajaDiario.ShowModal;
end;

procedure TfrmMain.InformeCajaDiario1Click(Sender: TObject);
var frmCajaDiario:TfrmCajaDiario;
begin
        timer2.Enabled := False;
        frmCajaDiario := TfrmCajaDiario.Create(Self);
        frmCajaDiario.ShowModal;
        timer2.Enabled := True;
end;

procedure TfrmMain.Observaciones1Click(Sender: TObject);
var frmControldeObservaciones:TfrmControldeObservaciones;
begin
        frmControldeObservaciones:=TfrmControldeObservaciones.Create(Self);
        frmControldeObservaciones.ShowModal;
end;

procedure TfrmMain.BalanceConsolidado1Click(Sender: TObject);
var frmBalanceConsolidado:TfrmBalanceConsolidado;
begin
        frmBalanceConsolidado := TfrmBalanceConsolidado.Create(Self);
        frmBalanceConsolidado.ShowModal;
end;

procedure TfrmMain.EstadodeIngresosyGastosConsolidados1Click(
  Sender: TObject);
var frmEstadoIyGConsolidado:TfrmEstadoIyGConsolidado;
begin
        frmEstadoIyGConsolidado := TfrmEstadoIyGConsolidado.Create(Self);
        frmEstadoIyGConsolidado.ShowModal;
end;

procedure TfrmMain.MantenimientodePrivilegiados1Click(Sender: TObject);
var frmMantenimientoPrivilegiados : TfrmMantenimientoPrivilegiados;
begin
        frmMantenimientoPrivilegiados := TfrmMantenimientoPrivilegiados.Create(Self);
        frmMantenimientoPrivilegiados.ShowModal;
end;

procedure TfrmMain.MantenimientodeTasas1Click(Sender: TObject);
var frmActualizoTasas : TfrmActualizoTasas;
begin
        frmActualizoTasas := TfrmActualizoTasas.Create(Self);
        frmActualizoTasas.ShowModal;
end;

procedure TfrmMain.CierredeAo1Click(Sender: TObject);
begin
        frmcierreanual := Tfrmcierreanual.Create(self);
        frmcierreanual.ShowModal;
end;

procedure TfrmMain.CertificadoRetencinenlaFuente1Click(Sender: TObject);
var frmCertificadoRetefuente: TfrmCertificadoRetefuente;
begin
        frmCertificadoRetefuente := TfrmCertificadoRetefuente.Create(Self);
        frmCertificadoRetefuente.ShowModal;
end;

end.
