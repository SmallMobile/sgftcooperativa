unit unitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, IniFiles,ExtCtrls, IBQuery, IBSQL,DateUtils, ImgList,
  ComCtrls, ToolWin;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    SalirdePSI1: TMenuItem;
    N1: TMenuItem;
    ConfigurarImpresora1: TMenuItem;
    N2: TMenuItem;
    CambiarContrasea1: TMenuItem;
    Edit1: TMenuItem;
    N3: TMenuItem;
    GeneracionPlano1: TMenuItem;
    AgregarBancoldex1: TMenuItem;
    Window1: TMenuItem;
    ReporteCrditosBancoldex1: TMenuItem;
    ReporteSolicitudes1: TMenuItem;
    PrinterSetupDialog: TPrinterSetupDialog;
    Timer2: TTimer;
    IBSQL1: TIBSQL;
    ToolBar1: TToolBar;
    AgregarRecursos: TToolButton;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    N4: TMenuItem;
    EliminarSolicitudBancoldex1: TMenuItem;
    procedure CambiarContrasea1Click(Sender: TObject);
    procedure ConfigurarImpresora1Click(Sender: TObject);
    procedure SalirdePSI1Click(Sender: TObject);
    procedure AgregarBancoldex1Click(Sender: TObject);
    procedure GeneracionPlano1Click(Sender: TObject);
    procedure ReporteSolicitudes1Click(Sender: TObject);
    procedure ReporteCrditosBancoldex1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    SalirMal:Boolean;
    FUltimaActividad:TDateTime;
    TheGraphic: TBitmap;    
    procedure AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
  public
    ruta1,wpath :string;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses unitLogin, UnitCambiarContrasena, unitdmGeneral,UnitInformeCreditosBancoldex,UnitGlobales,
     UnitInformeSolicitudesBancoldex,UnitAgregarCreditosBancoldex,UnitConsolidarPlanoBancoldex,UnitCambioLineaBancoldex;

procedure TfrmMain.CambiarContrasea1Click(Sender: TObject);
var frmCambiarContrasena : TfrmCambiarContrasena;
begin
        frmCambiarContrasena := TfrmCambiarContrasena.Create(Self);
        frmCambiarContrasena.ShowModal;
end;

procedure TfrmMain.ConfigurarImpresora1Click(Sender: TObject);
begin
        PrinterSetupDialog.Execute;
end;

procedure TfrmMain.SalirdePSI1Click(Sender: TObject);
begin
        Close;
end;

procedure TfrmMain.AgregarBancoldex1Click(Sender: TObject);
var
  frmAgregarCreditosBancoldex:TfrmAgregarCreditosBancoldex;
begin
        frmAgregarCreditosBancoldex := TfrmAgregarCreditosBancoldex.Create(Self);
        frmAgregarCreditosBancoldex.ShowModal;
end;


procedure TfrmMain.GeneracionPlano1Click(Sender: TObject);
var frmConsolidarPlanoBancoldex : TfrmConsolidarPlanoBancoldex;
begin
        frmConsolidarPlanoBancoldex := TfrmConsolidarPlanoBancoldex.Create(self);
        frmConsolidarPlanoBancoldex.ShowModal;
end;

procedure TfrmMain.ReporteSolicitudes1Click(Sender: TObject);
var
  frmInformeSolicitudesBancoldex:TfrmInformeSolicitudesBancoldex;
begin
        frmInformeSolicitudesBancoldex := TfrmInformeSolicitudesBancoldex.Create(Self);
        frmInformeSolicitudesBancoldex.ShowModal;
end;

procedure TfrmMain.ReporteCrditosBancoldex1Click(Sender: TObject);
var
  frmInformeCreditosBancoldex:TfrmInformeCreditosBancoldex;
begin
        frmInformeCreditosBancoldex := TfrmInformeCreditosBancoldex.Create(self);
        frmInformeCreditosBancoldex.ShowModal;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var frmLogin:TfrmLogin;
    frmCambiarContrasena:TfrmCambiarContrasena;
    Veces :SmallInt;
    Mensaje :String;
    Ruta:string;    
    AA,MM,DD,H,M,S,ms:Word;
    Dias:Integer;
    Ufecha,Hoy:TDate;
    MiINI:string;
begin
  Application.OnMessage := AtraparMensajes;
  Timer2.Enabled := False;
  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(MiINI) do
  try
    DBserver := ReadString('DBNAME','server','100.21.210.24');
    DBPath := ReadString('DBNAME','path','/base/');
    DBname := ReadString('DBNAME','name','coopservir.gdb');
    Empresa := ReadString('EMPRESA','name','COOPSERVIR LTDA');
    Nit     := ReadString('EMPRESA','nit','890.505.363-6');
    Agencia := ReadInteger('EMPRESA','Agencia',1);
    Ciudad  := ReadString('EMPRESA','city','OCAÑA N.S.');
    DBMinutos := ReadFloat('ADICIONALES','timerrelogin',1);
    host_equivida := ReadString('ADICIONALES','host','192.168.200.6');
    puerto_barrido := ReadInteger('ADICIONALES','puerto_barrido',0);
    vRuraCredivida := ReadString('ADICIONALES','ruta','\\Archivos\Publico\Reportes Credivida');
    host_abrego := ReadString('ADICIONALES','host_abrego','0.0.0.0');
    host_convencion := ReadString('ADICIONALES','host_convencion','0.0.0.0');
    host_aguachica := ReadString('ADICIONALES','host_aguachica','0.0.0.0');
    puerto_abrego := ReadInteger('ADICIONALES','puerto_abrego',0);
    puerto_convencion := ReadInteger('ADICIONALES','puerto_convencion',0);
    puerto_aguachica := ReadInteger('ADICIONALES','puerto_aguachica',0);
  finally
    free;
  end;

     Veces := 0;
     frmLogin := TfrmLogin.Create(Self);
     frmLogin.EdRole.Text := 'BANCOLDEX';
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
         //    Self.Close;
             Exit;
          end;
         end; // fin del while

  with IBSQL1 do begin
    if Transaction.InTransaction then
       Transaction.Rollback;
    Transaction.StartTransaction;
    Close;
    SQL.Clear;
    SQL.Add('select * from "gen$minimos" where ID_MINIMO = 11');
    try
     ExecQuery;
    except
     Transaction.Rollback;
     raise;
    end;
    Dias := FieldByName('VALOR_MINIMO').AsInteger;

    Close;
    SQL.Clear;
    SQL.Add('select ULTIMO_CAMBIO_PASABORDO from "gen$empleado"');
    SQL.Add('where ID_EMPLEADO = :ID_EMPLEADO');
    ParamByName('ID_EMPLEADO').AsString := DBAlias;
    try
     ExecQuery;
    except
     Transaction.Rollback;
     raise;
    end;

    Ufecha := FieldByName('ULTIMO_CAMBIO_PASABORDO').AsDate;
    Transaction.Commit;
  end;

  Ufecha := IncDay(Ufecha,Dias);
  Hoy:= fFechaActual;

  if Ufecha < Hoy then
  begin
   frmCambiarContrasena := TfrmCambiarContrasena.Create(Self);
   while not frmCambiarContrasena.Bien do
   begin
       frmCambiarContrasena.ShowModal;
   end;
  end;
  FUltimaActividad := Now;
  Timer2.Enabled := True;
  DecimalSeparator := '.';
  ShortDateFormat := 'yyyy/mm/dd';
  Ruta := ExtractFilePath(Application.ExeName);
  ruta1 := Ruta;
  wpath := ruta1;
  TheGraphic := TBitmap.Create; { Create the bitmap object }
  TheGraphic.LoadFromFile(Ruta+'\Coopservir.bmp');

end;

procedure tfrmmain.AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
begin
  case Msg.Message of
    WM_KEYFIRST..WM_KEYLAST,
    WM_LBUTTONDOWN..WM_MOUSELAST: FUltimaActividad := Now;
  end;
end;

procedure TfrmMain.ToolButton8Click(Sender: TObject);
begin
        Close;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
       if Not SalirMal then
        if MessageDlg('Seguro que desea cerrar SIFCREDISERVIR',mtConfirmation,[mbYes,mbNo],0) = mrYes Then

        begin
            dmGeneral.IBDatabase1.Connected := False;
            dmGeneral.IBTransaction1.Active  := False;
            dmGeneral.Free;
            Action:= caFree;
        end
        else
            Action := caNone
       else
         begin
            dmGeneral.Free;
            Action := caFree;
         end;
end;

procedure TfrmMain.FormPaint(Sender: TObject);
begin
    frmMain.Canvas.Draw(0, 0, TheGraphic);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
        Self.Caption := 'Módulo Bancoldex - ' + DBServer;
        if salirmal then Close;
end;

end.
