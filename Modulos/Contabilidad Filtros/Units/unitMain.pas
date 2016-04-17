unit unitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, ActnList, StdActns, unitGlobales, ComCtrls,
  ToolWin, unitdmGeneral, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdTime, ExtCtrls, DateUtils, IBSQL,JclSysUtils;

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
    IdTime1: TIdTime;
    MantenimientodelPUC1: TMenuItem;
    CierredelDa1: TMenuItem;
    MayoryBalance1: TMenuItem;
    BalanceGeneralDetallado1: TMenuItem;
    EstadodeIngresosyGastos1: TMenuItem;
    InformeCajaDiario1: TMenuItem;
    LibrosAuxiliares1: TMenuItem;
    PlanillaResumen1: TMenuItem;
    RecuperacindeSaldos1: TMenuItem;
    ProcesosAnuales1: TMenuItem;
    Gestiones1: TMenuItem;
    Timer1: TTimer;
    Timer2: TTimer;
    AjusteComprobantes1: TMenuItem;
    LibrosRegistrados1: TMenuItem;
    PaginacindePapel1: TMenuItem;
    CajaDiario1: TMenuItem;
    MayoryBalance3: TMenuItem;
    ImportarSaldosIniciales1: TMenuItem;
    SaldosIniciales1: TMenuItem;
    IBSQL1: TIBSQL;
    NotasFindeMes1: TMenuItem;
    CierredeAo1: TMenuItem;
    N6: TMenuItem;
    ComprobantedeCierre1: TMenuItem;
    MantenimientodePersonas1: TMenuItem;
    ExportarSaldosFinales1: TMenuItem;
    Seguridad1: TMenuItem;
    CopiadeSeguridad1: TMenuItem;
    Salir1: TMenuItem;
    CambiarContrasea1: TMenuItem;
    ActualizarUsuario1: TMenuItem;
    procedure Configurar_ImpresoraExecute(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure BtnSalirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AjusteComprobantes1Click(Sender: TObject);
    procedure MantenimientodelPUC1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SalirdePSI1Click(Sender: TObject);
    procedure MayoryBalance1Click(Sender: TObject);
    procedure BalanceGeneralDetallado1Click(Sender: TObject);
    procedure CierredelDa1Click(Sender: TObject);
    procedure LibrosAuxiliares1Click(Sender: TObject);
    procedure InformeCajaDiario1Click(Sender: TObject);
    procedure CopiadeSeguridad1Click(Sender: TObject);
    procedure MantenimientodePersonas1Click(Sender: TObject);
    procedure PlanillaResumen1Click(Sender: TObject);
    procedure RecuperacindeSaldos1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure CambiarContrasea1Click(Sender: TObject);
    procedure ActualizarUsuario1Click(Sender: TObject);
    procedure ComprobantedeCierre1Click(Sender: TObject);
    procedure CierredeAo1Click(Sender: TObject);
  private
    { Private declarations }
    SalirMal:Boolean;
    TheGraphic: TBitmap;
    FUltimaActividad:TDateTime;
    _bAdmin :Boolean;
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

uses unitLogin, IniFiles,UnitPlandeCuentas,
     unit_ComprobanteC,unitCierreDia,UnitBalanceGeneral,
     UnitBalanceGralDetallado,UnitInformeAuxiliar, UnitCajaDiario, UnitCopia,
     UnitPersona, UnitPlanillaResumen, UnitRecuperacionsaldos,
     UnitCotrasena, UnitUsuario,UnitCierreAnual,UnitProcesoCierreAno;

procedure TfrmMain.Configurar_ImpresoraExecute(Sender: TObject);
begin
        PrinterSetupDialog.Execute;
end;

procedure TfrmMain.FormPaint(Sender: TObject);
begin
    frmMain.Canvas.Draw(0, 0, TheGraphic);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
       if Not SalirMal then
        if MessageDlg('Salir de SoftCount',mtConfirmation,[mbYes,mbNo],0) = mrYes Then
           begin
            dmGeneral.IBDatabase1.Connected := False;
            dmGeneral.IBTransaction1.Active  := False;
            dmGeneral.Free;
            CanClose := True;
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
        Self.Caption := 'SoftCount - Software Contable Version 1.0';
        if SalirMal then
           Self.Close;
end;



procedure TfrmMain.BtnSalirClick(Sender: TObject);
begin
        SalirdePSI1.Click;
end;


procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
        FechaHora := Date;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
{      try
        IdTime1.Host := DBserver;
        IdTime1.SyncTime;
        IdTime1.DateTime;
      finally
        IdTime1.Disconnect;
      end;}

end;

procedure TfrmMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
        FechaHora := fFechaActual;
end;

procedure tfrmmain.AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
begin
  case Msg.Message of
    WM_KEYFIRST..WM_KEYLAST,
    WM_LBUTTONDOWN..WM_MOUSELAST: FUltimaActividad := Now;
  end;
end;


procedure TfrmMain.AjusteComprobantes1Click(Sender: TObject);
var frmComprobanteC:TfrmComprobanteC;
begin
          frmComprobanteC := TfrmComprobanteC.Create(Self);
          frmComprobanteC.ShowModal;
end;


procedure TfrmMain.MantenimientodelPUC1Click(Sender: TObject);
var frmPlandeCuentas :TfrmPlandeCuentas;
begin
        frmPlandeCuentas := TfrmPlandeCuentas.Create(Self);
        frmPlandeCuentas.ShowModal;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var frmLogin:TfrmLogin;
    Veces :SmallInt;
    Mensaje :String;
    Ruta:string;
    //Role:string;
    Dias:Integer;
    Ufecha,Hoy:TDate;
    _bValidaContrasena :Boolean;
begin
  Application.OnMessage := AtraparMensajes;

  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(MiINI) do
  try
    DBserver := ReadString('DBNAME','server','192.168.1.8');
    DBPath := ReadString('DBNAME','path','/home/');
    DBname := ReadString('DBNAME','name','database.gdb');
    Empresa := 'V. de Prueba';
    Nit     := '111.1111.111.-1';
    Agencia := ReadInteger('EMPRESA','Agencia',1);
    Ciudad  := ReadString('EMPRESA','city','OCAÑA N.S.');
    DBMinutos := ReadFloat('ADICIONALES','timerrelogin',1);
  finally
    free;
  end;

        Veces := 0;
        frmLogin := TfrmLogin.Create(Self);
        frmLogin.EdRole.Text := 'CONTABILIDAD_A';
        dmGeneral.IBDatabase1.Connected := false;
        dmGeneral.IBDatabase1.DataBaseName := DBserver + ':' + DBpath + DBname;
        dmGeneral.IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
        dmGeneral.IBDatabase1.Params.Values['User_Name'] := 'sysdba';
        dmGeneral.IBDatabase1.Params.Values['PassWord'] := 'masterkey';
        dmGeneral.IBDatabase1.Connected := True;
        dmGeneral.IBTransaction1.Active := True;
        IBSQL1.Database := dmGeneral.IBDatabase1;
        IBSQL1.Transaction := dmGeneral.IBTransaction1;
        _bValidaContrasena := False;
         while Not _bValidaContrasena do
          begin
           if Veces = 3 then
           begin
                SalirMal := True;
                dmGeneral.IBDatabase1.Connected := False;
                dmGeneral.IBTransaction1.Active := False;
                Exit;
           end;
          if frmLogin.ShowModal = mrOk then
           begin
             with frmLogin do
             begin
                DBAlias := EdUsuario.Text;
                DBPasabordo:= EdPasabordo.Text;
                Role := EdRole.Text;
                Veces := Veces + 1;
                  with IBSQL1 do
                  begin
                    Close;
                    if Transaction.InTransaction then
                       Transaction.Commit;
                    Transaction.StartTransaction;
                    SQL.Clear;
                    SQL.Add('select CONTRASENA,TIPO from "gen$empleado" where ID_EMPLEADO = :ID_EMPLEADO');
                    ParamByName('ID_EMPLEADO').AsString := DBAlias;
                    ExecQuery;
                    if FieldByName('CONTRASENA').AsString = '' then
                       ShowMessage('Contraseña o Nombre de Usuario Errado, Favor Revise')
                       else if UpperCase(FieldByName('CONTRASENA').AsString) = UpperCase(DBPasabordo) then
                       begin
                          _bValidaContrasena := True;
                          _bAdmin := IntToBool(FieldByName('TIPO').AsInteger);
                       end
                          else
                            ShowMessage('Contraseña o Nombre de Usuario Errado, Favor Revise');
                  end;
             end; //fin del begin del with

            end // fin del begin del if superior
          else
          begin
             SalirMal := True;
             Exit;
          end;
         end; // fin del while

  Ruta := ExtractFilePath(Application.ExeName);
  ruta1 := Ruta;
  TheGraphic := TBitmap.Create; { Create the bitmap object }
  TheGraphic.LoadFromFile(Ruta+'\grafico.bmp');
end;

procedure TfrmMain.SalirdePSI1Click(Sender: TObject);
begin
        Close;
end;

procedure TfrmMain.MayoryBalance1Click(Sender: TObject);
var frmBalanceGeneral :TfrmBalanceGeneral;
begin
        frmBalanceGeneral := TfrmBalanceGeneral.Create(Self);
        frmBalanceGeneral.ShowModal;
end;

procedure TfrmMain.BalanceGeneralDetallado1Click(Sender: TObject);
var frmBalanceGralDetallado :TfrmBalanceGralDetallado;
begin
        frmBalanceGralDetallado := TfrmBalanceGralDetallado.Create(Self);
        frmBalanceGralDetallado.ShowModal;
end;

procedure TfrmMain.CierredelDa1Click(Sender: TObject);
var frmCierreDia :TfrmCierreDia;
begin
        frmCierreDia := TfrmCierreDia.Create(Self);
        frmCierreDia.ShowModal;
end;

procedure TfrmMain.LibrosAuxiliares1Click(Sender: TObject);
var frmInformeAuxiliares :TfrmInformeAuxiliares;
begin
        frmInformeAuxiliares := TfrmInformeAuxiliares.Create(Self);
        frmInformeAuxiliares.ShowModal;
end;

procedure TfrmMain.InformeCajaDiario1Click(Sender: TObject);
var frmCajaDiario :TfrmCajaDiario;
begin
        frmCajaDiario := TfrmCajaDiario.Create(Self);
        frmCajaDiario.ShowModal;
end;

procedure TfrmMain.CopiadeSeguridad1Click(Sender: TObject);
var FrmCopia :TFrmCopia;
begin
        dmGeneral.IBDatabase1.Connected := False;
        dmGeneral.IBTransaction1.Active := False;
        WinExec(PChar(_sRuta + 'Copia.exe'),SW_SHOWNORMAL);
        dmGeneral.IBDatabase1.Connected := True;
        dmGeneral.IBTransaction1.Active := True;
end;
procedure TfrmMain.MantenimientodePersonas1Click(Sender: TObject);
var FrmPersona : TFrmPersona;
begin
        FrmPersona := TFrmPersona.Create(Self);
        FrmPersona.ShowModal;
end;

procedure TfrmMain.PlanillaResumen1Click(Sender: TObject);
var frmPlanillaResumen : TfrmPlanillaResumen;
begin
        frmPlanillaResumen := TfrmPlanillaResumen.Create(Self);
        frmPlanillaResumen.ShowModal;
end;



procedure TfrmMain.RecuperacindeSaldos1Click(Sender: TObject);
var frmrecuperacionsaldos : Tfrmrecuperacionsaldos;
begin
        frmrecuperacionsaldos := Tfrmrecuperacionsaldos.Create(Self);
        frmrecuperacionsaldos.ShowModal;
end;

procedure TfrmMain.Salir1Click(Sender: TObject);
begin
        Close;
end;

procedure TfrmMain.CambiarContrasea1Click(Sender: TObject);
begin
        FrmContrasena := TFrmContrasena.Create(Self);
        FrmContrasena.ShowModal
end;

procedure TfrmMain.ActualizarUsuario1Click(Sender: TObject);
begin
        if _bAdmin = False then
        begin
          ShowMessage('No Tiene Permisos para Este Proceso');
          Exit;
        end;
        FrmUsuario := TFrmUsuario.Create(Self);
        FrmUsuario.ShowModal        
end;

procedure TfrmMain.ComprobantedeCierre1Click(Sender: TObject);
var frmcierreanual :Tfrmcierreanual;
begin
        frmcierreanual := Tfrmcierreanual.Create(Self);
        frmcierreanual.ShowModal;
end;

procedure TfrmMain.CierredeAo1Click(Sender: TObject);
var frmcierreano :TfrmCierreAno;
begin
        frmcierreano := TfrmCierreAno.Create(Self);
        frmcierreano.ShowModal;
end;

end.
