unit unitMain;

interface

uses
  Windows, Messages, SysUtils, Variants,  Graphics,  Forms,
  DateUtils,ActnList, ToolWin, Dialogs, Menus, ComCtrls, IdBaseComponent,
  IdComponent, IdTCPClient, IdTCPConnection, IdTime, ExtCtrls, IBSQL,
  ImgList, Controls, Classes, FR_DSet, FR_DBSet, FR_Class, DB,
  IBCustomDataSet, IBQuery;

type
  TfrmMain = class(TForm)
    MainMenu: TMainMenu;
    ImageList: TImageList;
    ActionList: TActionList;
    pp: TPrinterSetupDialog;
    Configurar_Impresora: TAction;
    ToolBar1: TToolBar;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    BtnSalir: TToolButton;
    IdTime1: TIdTime;
    Timer1: TTimer;
    Timer2: TTimer;
    IBSQL1: TIBSQL;
    CambiarContrasea1: TMenuItem;
    ConfigurarImpresora1: TMenuItem;
    Salir1: TMenuItem;
    Verificarini1: TMenuItem;
    Administracion1: TMenuItem;
    CrearUsuarios1: TMenuItem;
    Permisos1: TMenuItem;
    AsignarRoles1: TMenuItem;
    AsignaroQuitarPermisos1: TMenuItem;
    EliminarUsuarios1: TMenuItem;
    Consultas1: TMenuItem;
    Sucursales1: TMenuItem;
    CambiarHorarios1: TMenuItem;
    ConsultaEmpleado1: TMenuItem;
    Reportes1: TMenuItem;
    ReporteEmpleados1: TMenuItem;
    IBempleado: TIBQuery;
    frReport1: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    ReporteIndividualEmpleado1: TMenuItem;
    AccesoCAjas1: TMenuItem;
    AccesoaModulos1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConfigurarImpresora1Click(Sender: TObject);
    procedure SalirdePSI1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Timer2Timer(Sender: TObject);
    procedure Verificarini1Click(Sender: TObject);
    procedure BtnSalirClick(Sender: TObject);
    procedure CrearUsuarios1Click(Sender: TObject);
    procedure BtnExtractoClick(Sender: TObject);
    procedure CambiarContrasea1Click(Sender: TObject);
    procedure AsignarRoles1Click(Sender: TObject);
    procedure AsignaroQuitarPermisos1Click(Sender: TObject);
    procedure CambiarHorarios1Click(Sender: TObject);
    procedure ConsultaEmpleado1Click(Sender: TObject);
    procedure EliminarUsuarios1Click(Sender: TObject);
    procedure ReporteEmpleados1Click(Sender: TObject);
  private
    { Private declarations }
    SalirMal:Boolean;
    TheGraphic: TBitmap;
    FUltimaActividad:TDateTime;
    procedure AtraparMensajes(var Msg: TMsg; var Handled: Boolean);

  public
  ruta1 :string;
  wpath :string;
  DbInventario :string;
  published
    procedure imprimir_reporte(cadena: string);
    { Public declarations }
  end;
var
  frmMain: TfrmMain;
  FechaHora: TDateTime;

implementation

{$R *.dfm}

uses unitLogin, IniFiles, UnitCambiarContrasena, UnitReLogin, UnitGlobal,
  UnitVerificaIni, UnitCreacionUsuario, UnitRole, UnitDmPermiso,
  UnitPermisos, UnitFechaSucursal,unitdmGeneral, UnitConsultaEmp, UnitDmInventario,
  UnitEliminaUsuario,unitGlobales;

procedure TfrmMain.FormCreate(Sender: TObject);
var frmLogin:TfrmLogin;
    frmCambiarContrasena:TfrmCambiarContrasena;
    Veces :SmallInt;
    Mensaje :String;
    Ruta:string;
    Role:string;
    Dias:Integer;
    Ufecha,Hoy:TDate;
    ServerInventario :string;
    RutaInventario :string;
    NombreInventario :string;
//    frmConectando:TfrmConectando;
begin
  Application.OnMessage := AtraparMensajes;
  Timer2.Enabled := False;
  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  AIni := MiINI;
  with TIniFile.Create(MiINI) do
  try
    DBserver := ReadString('DBNAME','server','192.168.1.8');
    DBPath := ReadString('DBNAME','path','/home/');
    DBname := ReadString('DBNAME','name','coopservir.gdb');
    Empresa := ReadString('EMPRESA','name','COOPSERVIR LTDA');
    //** Base de Datos Inventario
    ServerInventario := ReadString('DBNAMEI','server','192.168.1.8');
    RutaInventario := ReadString('DBNAMEI','path','/home/');
    NombreInventario := ReadString('DBNAMEI','name','coopservir.gdb');
    //** Base de Datos Inventario
    Nit     := ReadString('EMPRESA','nit','890.505.363-6');
    Agencia := ReadInteger('EMPRESA','Agencia',1);
    Ciudad  := ReadString('EMPRESA','city','OCAÑA N.S.');
    DBMinutos := ReadFloat('ADICIONALES','timerrelogin',1);
    //** Contraseña SYSDBA
    dbPassSysdba  := Decrypt(ReadString('ADICIONALES','key','0'),6474);
  finally
    free;
  end;
        IdTime1.Host := DBserver;
        if IdTime1.Connected then
           FechaHoy := IdTime1.DateTime;
        if not IdTime1.SyncTime then
        begin
          SalirMal := True;
          Exit;
        end;
        Timer2.Enabled := False;

        control_consulta := True;
        Veces := 0;
        frmLogin := TfrmLogin.Create(Self);
        frmLogin.EdRole.Text := 'ADMINISTRADOR';
        //DmInventario := TDmInventario.Create(Self);
        //DmPermiso := tDmPermiso.Create(Self);
        DmInventario.IBDatabase1.Connected := False;
        DmPermiso.IBDatabase1.Connected := False;
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
                dmGeneral.IBDatabase1.Params.Values['sql_role_name'] := 'ADMINISTRADOR';
                //*** base de datos conectada directamente con el servidor
                DmPermiso.IBDatabase1.DataBaseName := DBserver + ':' + DBpath + DBname;
                DmPermiso.IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
                DmPermiso.IBDatabase1.Params.Values['User_Name'] := 'sysdba';
                DmPermiso.IBDatabase1.Params.Values['PassWord'] :=  dbPassSysdba;
                //*** base de datos inventario
                DmInventario.IBDatabase1.DataBaseName := ServerInventario + ':' + RutaInventario + NombreInventario;
                DmInventario.IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
                DmInventario.IBDatabase1.Params.Values['User_Name'] := 'sysdba';
                DmInventario.IBDatabase1.Params.Values['PassWord'] :=  dbPassSysdba;
                Veces := Veces + 1;
                try
                    dmGeneral.IBDatabase1.Connected := True;
                    dmGeneral.IBTransaction1.Active := True;
                    DmPermiso.IBDatabase1.Connected := True;
                    DmPermiso.IBTransaction1.Active := True;
                    DmInventario.IBDatabase1.Connected := True;
                    DmInventario.IBTransaction1.Active := True;
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
  Timer2.Enabled := True;
  FUltimaActividad := Now;
  ShortDateFormat := 'yyyy/mm/dd';
  Ruta := ExtractFilePath(Application.ExeName);
  ruta1 := Ruta;
  wpath := ExtractFilePath(Application.ExeName);
  TheGraphic := TBitmap.Create; { Create the bitmap object }
  TheGraphic.LoadFromFile(Ruta+'\Coopservir.bmp');
  Self.Caption := 'Modulo de 8 - ';
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
           Action := caFree;
end;

procedure TfrmMain.ConfigurarImpresora1Click(Sender: TObject);
begin
        pp.Execute
end;



procedure TfrmMain.SalirdePSI1Click(Sender: TObject);
begin
        Close;
end;


procedure TfrmMain.FormPaint(Sender: TObject);
begin
    frmMain.Canvas.Draw(0, 0, TheGraphic);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
       if Not SalirMal then
        if MessageDlg('Seguro que desea cerrar SIFCREDISERVIR',mtConfirmation,[mbYes,mbNo],0) = mrYes Then
           begin
            dmGeneral.IBDatabase1.Connected := False;
            dmGeneral.IBTransaction1.Active  := False;
            dmGeneral.Free;
            DmPermiso.IBDatabase1.Connected := False;
            DmPermiso.IBTransaction1.Active  := False;
            DmPermiso.Free;
            DmInventario.IBDatabase1.Connected := False;
            DmInventario.IBTransaction1.Active  := False;
            DmInventario.Free;

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
        Self.Caption := 'Módulo Aministración de Usuarios - '; //+ DBserver;
        if SalirMal then
           Self.Close;
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


procedure TfrmMain.Timer2Timer(Sender: TObject);
var    Pasabordo :string;
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
procedure TfrmMain.imprimir_reporte(cadena: string);
begin
end;

procedure TfrmMain.Verificarini1Click(Sender: TObject);
begin
        FrmVerificaIni := TFrmVerificaIni.Create(Self);
        FrmVerificaIni.ShowModal;
end;

procedure TfrmMain.BtnSalirClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmMain.CrearUsuarios1Click(Sender: TObject);
begin
        FrmCreacionUsuarios := TFrmCreacionUsuarios.Create(Self);
        FrmCreacionUsuarios.ShowModal
end;

procedure TfrmMain.BtnExtractoClick(Sender: TObject);
begin
        CrearUsuarios1.Click;
end;

procedure TfrmMain.CambiarContrasea1Click(Sender: TObject);
begin
        frmCambiarContrasena := TfrmCambiarContrasena.Create(Self);
        frmCambiarContrasena.ShowModal;
end;

procedure TfrmMain.AsignarRoles1Click(Sender: TObject);
begin
        FrmRole := TFrmRole.Create(Self);
        FrmRole.ShowModal;
end;

procedure TfrmMain.AsignaroQuitarPermisos1Click(Sender: TObject);
begin
        FrmPermisos := TFrmPermisos.Create(Self);
        FrmPermisos.ShowModal
end;

procedure TfrmMain.CambiarHorarios1Click(Sender: TObject);
begin
        FrmFechaSucursal := TFrmFechaSucursal.Create(Self);
        FrmFechaSucursal.ShowModal
end;

procedure TfrmMain.ConsultaEmpleado1Click(Sender: TObject);
begin
        FrmConsultaEmp := TFrmConsultaEmp.Create(Self);
        FrmConsultaEmp.ShowModal;
end;

procedure TfrmMain.EliminarUsuarios1Click(Sender: TObject);
begin
        FrmEliminaUsuario := TFrmEliminaUsuario.Create(Self);
        FrmEliminaUsuario.ShowModal;
end;

procedure TfrmMain.ReporteEmpleados1Click(Sender: TObject);
begin
        with IBempleado do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          Open;
          frReport1.LoadFromFile(wpath + 'reportes\frUsuarios.frf');
          frReport1.ShowReport;
        end;
end;

end.
