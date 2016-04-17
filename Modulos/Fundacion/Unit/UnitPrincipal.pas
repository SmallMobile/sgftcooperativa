unit UnitPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls, ImgList, ToolWin, jpeg, ExtCtrls,IniFiles,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdTime,MAth,
  DB, IBCustomDataSet, IBQuery, IBSQL, JvComponent, JvClock,JclSysUtils,
  DBClient, JvBalloonHint, JvBaseDlg, JvWinDialogs, JvPasswordForm,
  JvProgressDlg, JvImageDlg, JvSerialDlg, JvExchListboxes, JvNagScreen,
  JvDSADialogs;

type
  TFrMain = class(TForm)
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    PrinterSetupDialog: TPrinterSetupDialog;
    menu: TPopupMenu;
    Articulo4: TMenuItem;
    Proveedores1: TMenuItem;
    Empleados1: TMenuItem;
    Entradas2: TMenuItem;
    Salir2: TMenuItem;
    Image1: TImage;
    MainMenu1: TMainMenu;
    IDserver: TIdTime;
    SalidadeActivos2: TMenuItem;
    IBplaca: TIBQuery;
    IBSQL1: TIBSQL;
    ToolButton3: TToolButton;
    General: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    Afiliacin1: TMenuItem;
    Afiliacion1: TMenuItem;
    Renovacin1: TMenuItem;
    Buscar1: TMenuItem;
    Actalizar1: TMenuItem;
    Carnet1: TMenuItem;
    Asociado1: TMenuItem;
    Beneficiaro1: TMenuItem;
    Timer1: TTimer;
    NAfiliacion1: TMenuItem;
    FechaVencimiento1: TMenuItem;
    Fecha1: TMenuItem;
    Usuario1: TMenuItem;
    Reportes1: TMenuItem;
    Certificados1: TMenuItem;
    Asociado2: TMenuItem;
    Beneficiario1: TMenuItem;
    RegistrarEps1: TMenuItem;
    AfiliacionEps1: TMenuItem;
    RegistrosVencidos1: TMenuItem;
    Asociados2: TMenuItem;
    Beneficiarios2: TMenuItem;
    ReversarAfiliacion1: TMenuItem;
    RegistrarTipodeCapacitacion1: TMenuItem;
    RegistrarCapacitacion1: TMenuItem;
    RegistrarCapacitaciones1: TMenuItem;
    Capacitacion1: TMenuItem;
    Capacitacioes1: TMenuItem;
    Asociado3: TMenuItem;
    Fecha2: TMenuItem;
    Conferencistas1: TMenuItem;
    Capacitacion2: TMenuItem;
    Consulta1: TMenuItem;
    Consulta2: TMenuItem;
    ConfigurarImpresora1: TMenuItem;
    Salir1: TMenuItem;
    RegistrarConvenio1: TMenuItem;
    ddd1: TMenuItem;
    itulares1: TMenuItem;
    Consulta3: TMenuItem;
    VentasporEmpleado1: TMenuItem;
    AsistenciaPasantias1: TMenuItem;
    Documento1: TMenuItem;
    ToolButton10: TToolButton;
    EliminarCapacitacin1: TMenuItem;
    Creditos1: TMenuItem;
    Formulario1: TMenuItem;
    RecuperarReporte1: TMenuItem;
    Solicitudes1: TMenuItem;
    MMMMM1: TMenuItem;
    Conyuge1: TMenuItem;
    IdTime1: TIdTime;
    ConsultadeProductos1: TMenuItem;
    Gestiones1: TMenuItem;
    RequerimientoSistemas1: TMenuItem;
    PlanosCredividas1: TMenuItem;
    Equidad1: TMenuItem;
    CredividasVencidos1: TMenuItem;
    CredividasVendidos1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure Buscar1Click(Sender: TObject);
    procedure Afiliacion1Click(Sender: TObject);
    procedure Renovacin1Click(Sender: TObject);
    procedure Asociado1Click(Sender: TObject);
    procedure Beneficiaro1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure NAfiliacion1Click(Sender: TObject);
    procedure Fecha1Click(Sender: TObject);
    procedure Usuario1Click(Sender: TObject);
    procedure Asociado2Click(Sender: TObject);
    procedure Beneficiario1Click(Sender: TObject);
    procedure RegistrarEps1Click(Sender: TObject);
    procedure AfiliacionEps1Click(Sender: TObject);
    procedure Salir2Click(Sender: TObject);
    procedure SalidadeActivos2Click(Sender: TObject);
    procedure Proveedores1Click(Sender: TObject);
    procedure Empleados1Click(Sender: TObject);
    procedure Entradas2Click(Sender: TObject);
    procedure Articulo4Click(Sender: TObject);
    procedure RegistrosVencidos1Click(Sender: TObject);
    procedure ReversarAfiliacion1Click(Sender: TObject);
    procedure RegistrarTipodeCapacitacion1Click(Sender: TObject);
    procedure RegistrarCapacitacion1Click(Sender: TObject);
    procedure RegistrarCapacitaciones1Click(Sender: TObject);
    procedure Capacitacion1Click(Sender: TObject);
    procedure Asociado3Click(Sender: TObject);
    procedure Fecha2Click(Sender: TObject);
    procedure Conferencistas1Click(Sender: TObject);
    procedure Consulta2Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure ConfigurarImpresora1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure RegistrarConvenio1Click(Sender: TObject);
    procedure Beneficiarios2Click(Sender: TObject);
    procedure ddd1Click(Sender: TObject);
    procedure Asociados2Click(Sender: TObject);
    procedure itulares1Click(Sender: TObject);
    procedure Consulta3Click(Sender: TObject);
    procedure VentasporEmpleado1Click(Sender: TObject);
    procedure AsistenciaPasantias1Click(Sender: TObject);
    procedure Documento1Click(Sender: TObject);
    procedure EliminarCapacitacin1Click(Sender: TObject);
    procedure Formulario1Click(Sender: TObject);
    procedure RecuperarReporte1Click(Sender: TObject);
    procedure Solicitudes1Click(Sender: TObject);
    procedure MMMMM1Click(Sender: TObject);
    procedure Conyuge1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ConsultadeProductos1Click(Sender: TObject);
    procedure RequerimientoSistemas1Click(Sender: TObject);
    procedure PlanosCredividas1Click(Sender: TObject);
    procedure CredividasVencidos1Click(Sender: TObject);
    procedure CredividasVendidos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    FUltimaActividad: TDateTime;
    salirmal:boolean;
    apagar :Boolean;
    MiINI: string;
    DBserver,DBserver1: string;
    DBPath,DBPath1: string;
    DBname,DBname1: string;
    Empresa: string;
    Nit: string;
    //Agencia: integer;
    Ciudad: string;
    Dbalias: string;
    DBPasabordo: string;
    wpath : string;
    titulo :string;
    procedure AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
  published
    { Public declarations }
  end;
var
  FrMain: TFrMain;

implementation
uses unitlogin,unitdatamodulo, Unitdata, UnitPrograma, UnitBeneficiario,
  UnitConvenios, UnitBusca, UnitAfiliacion, UnitCarnet,
  UnitCarnetBene, UnitCredito, UnitNuevaAfiliacion, UnitActualizaFecha,
  UnitActualizaBene, UnitEps, UnitAfiliacionEps, UnitQuerys,
  UnitPantallaProgreso, UnitdataQuerys, UnitReportes, UnitReversar,
  UnitTipocapacitacion, UnitCapacitaciones, UnitRegistropas,
  UnitRegistrocap, Unitrepcapacitaciones, Unitrepcapacitacion,
  UnitCapacitacioncon, UnitConsulta, UnitRepBeneficiarios,
  UnitAsociadoTitular, UnitRepVentas, UnitAsistencia, UnitActaualizaBene,
  UnitReconfirmar, UnitActualizanit, UnitEliCapacitacion, UnitInformacion,
  UnitdmGeneral, UnitBuscaSolicitud, UnitEstadoSolicitud, UnitEjemplo, UnitGlobales,
  UnitConyuge, UnitConsultaProductos, UnitCambiosFun, UnitPlanoCredivida,
  UnitCredividasVencidos;

{$R *.dfm}

procedure TFrMain.FormCreate(Sender: TObject);
var Login: TLogin;
    Veces: SmallInt;
    Mensaje: string;
    validahora,hora: Integer;
begin
  Application.OnMessage := AtraparMensajes;
  FUltimaActividad := Now;
  ShortDateFormat := 'yyyy/mm/dd';
  wpath := ExtractFilePath(ParamStr(0));
  DecimalSeparator := '.';
  ThousandSeparator := ',';
  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(MiINI) do
  try
    DBserver := ReadString('DBNAME','server','192.168.1.8');
    DBserver1 := ReadString('DBNAME1','server','192.168.1.8');
    _sServerImagen := ReadString('DBNAME','serverimagen','');    
    DBPath := ReadString('DBNAME','path','/base/');
    DBPath1 := ReadString('DBNAME1','path','/base/');
    DBname := ReadString('DBNAME','name','inventario.gdb');
    DBname1 := ReadString('DBNAME1','name','coopservir.gdb');
    Empresa := ReadString('EMPRESA','name','COOPSERVIR LTDA');
    Nit     := ReadString('EMPRESA','nit','890.505.363-6');
    Agencia := ReadInteger('EMPRESA','Agencia',1);
    Ciudad  := ReadString('EMPRESA','city','OCAÑA N.S.');
    titulo :=  ReadString('EMPRESA','title','SISTEMA');
  finally
    free;
  end;
  //Application.Title := titulo;
  try
  IDserver.Host := DBserver;
  hora := 700;
  validahora := StrToInt(FormatDateTime('Hnn',IDserver.DateTime));
  if validahora > hora then
  begin
        vRol := 'FUNDACION';
        Veces := 0;
        Login := Tlogin.Create(Self);
        datageneral := tdatageneral.Create(self);
        frmdata := Tfrmdata.Create(self);
        DataGeneral.IBDatabase1.Connected := False;
        dmGeneral.IBDatabase1.Connected := False;
        frmdata.IBDatabase2.Connected := False;
         while Not (datageneral.IBDatabase1.Connected)  and not (frmdata.IBDatabase2.Connected) do
          begin
           if Veces = 3 then
           begin
                SalirMal := True;
                Self.Close;
                Exit;
           end;
        if Login.ShowModal = mrOk then
           begin
             with Login do
             begin
                DBAlias := LowerCase(Usuario.Text);
                DBPasabordo := LowerCase(password.Text);
                DataGeneral.IBDatabase1.DataBaseName := DBserver + ':' + DBpath + DBname;
                DataGeneral.IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
                DataGeneral.IBDatabase1.Params.Values['User_Name'] := DBAlias;
                DataGeneral.IBDatabase1.Params.Values['PassWord'] := DBPasabordo;
                frmdata.IBDatabase2.DataBaseName := DBserver1 + ':' + DBpath1 + DBname1;
                frmdata.IBDatabase2.Params.Values['lc_ctype'] := 'ISO8859_1';
                frmdata.IBDatabase2.Params.Values['User_Name'] := DBAlias;
                frmdata.IBDatabase2.Params.Values['PassWord'] := DBPasabordo;
                frmdata.IBDatabase2.Params.Values['sql_role_name'] := 'FUNDACION';
                DataGeneral.IBDatabase1.Params.Values['sql_role_name'] := 'FUNDACION';
                DmGeneral.IBDatabase1.DataBaseName := DBserver1 + ':' + DBpath1 + DBname1;
                DmGeneral.IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
                DmGeneral.IBDatabase1.Params.Values['User_Name'] := DBAlias;
                dmGeneral.IBDatabase1.Params.Values['PassWord'] := DBPasabordo;
                dmGeneral.IBDatabase1.Params.Values['sql_role_name'] := 'FUNDACION';
                unitglobales.DBAlias := dbalias;
                FrMain.Caption := 'SISTEMA DE CONSULTA INTEGRAL FUNDACION CREDISERVIR. '+ DBserver1 + ' FUNDACIÓN. ' + DBserver + '. 2011/10/03';
                Veces := Veces + 1;
                try
                  DataGeneral.IBDatabase1.Connected := True;
                  DataGeneral.IBTransaction1.Active := True;
                  frmdata.IBDatabase2.Connected := True;
                  frmdata.IBTransaction2.Active := True;
                  dmGeneral.IBDatabase1.Connected := True;
                  dmGeneral.IBTransaction1.Active := True;
                except
                     on E: Exception do
                     begin
                     DataGeneral.IBDatabase1.Connected := False;
                     frmdata.IBDatabase2.Connected := False;
                     dmGeneral.IBDatabase1.Connected := False;
                     if StrLIComp(PChar(E.Message),PChar('Your user name'),14) = 0 then
                       begin
                       Mensaje := 'Verifique su Nombre y su Contraseña' + #10 + #13; // + 'Mensaje:' + E.Message;
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
             Self.Close;
             Exit;
          end;
         end; // fin del while
         end
         else
         begin
           MessageDlg('La Hora Establecida Para el Acceso al Sistema es Despues de las 8:00 a.m.',mtInformation,[mbOK],0);
           salirmal := True;
           Application.Terminate;
         end;
        except
        on E: Exception do
        begin
          MessageDlg('El Servidor se Encuentra Fuera de Servicio. Informe al Administrador de la Red',mtError,[mbOK],0);
          salirmal := true;
          Application.Terminate;
        end;
        end;
        
end;

procedure TFrMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        if apagar then
        Exit;
        if Not SalirMal then
        if MessageDlg('Cerrar Sistema de Informacion de la Fundacion Crediservir.',mtInformation,[mbYes,mbNo],0) = mrYes Then
         {with TIniFile.Create(MiINI) do
          try
            WriteString('DBNAME','server',DBserver);
            WriteString('DBNAME1','server',DBserver1);
            WriteString('DBNAME','path',DBpath);
            WriteString('DBNAME1','path',DBpath1);
            WriteString('DBNAME','name',DBname);
            WriteString('DBNAME1','name',DBname1);
            WriteString('EMPRESA','name',Empresa);
            WriteString('EMPRESA','nit',Nit);
            WriteInteger('EMPRESA','Agencia',Agencia);
            WriteString('EMPRESA','city',Ciudad);
            WriteString('EMPRESA','title',titulo);
          finally}
           begin
            dataGeneral.IBDatabase1.Connected := False;
            dataGeneral.IBTransaction1.Active  := False;
            frmdata.IBDatabase2.Connected := False;
            frmdata.IBTransaction2.Active := False;
            dmGeneral.IBDatabase1.Connected := False;
            dmGeneral.IBTransaction1.Active  := False;
            dmGeneral.Free;
            frmdata.Free;
            dataGeneral.Free;
            Action := caFree;
          end
        else
            Action := caNone
       else
         begin
            dataGeneral.Free;
            Action := caFree;
         end;
end;
procedure TFrMain.ToolButton9Click(Sender: TObject);
begin
        Close;
end;

procedure TFrMain.ToolButton7Click(Sender: TObject);
begin
        consulta2click(Self);
end;

procedure TFrMain.ToolButton5Click(Sender: TObject);
begin
        FrmConvenio := TFrmConvenio.Create(self);
        FrmConvenio.ShowModal;
end;

procedure TFrMain.Buscar1Click(Sender: TObject);
begin
        FrmBuscar := TFrmBuscar.Create(self);
        FrmBuscar.ShowModal;
end;

procedure TFrMain.Afiliacion1Click(Sender: TObject);
begin
        FrmAfiliacion := TFrmAfiliacion.Create(self);
        with FrmAfiliacion do
        begin
           es_afiliacion := True;
           Caption := 'Afiliacion de Personas';
           BTcarne.Visible := False;
           BTagregar.Width := 137;
           BTagregar.Left := 20;
           BTagregar.Top := 136;
           BTagregar.Height := 25;
           BTeliminar.Width := 137;
           BTeliminar.Left := 170;
           BTeliminar.Top := 136;
           BTeliminar.Height := 25;
           BTverificar.Visible := False;
           BTcarne.Visible := True;
           BTcarne.Width := 137;
           BTcarne.Left := 315;
           BTcarne.Caption := '&Eps';
           VerFechasdeVencimiento1.Visible := False;
           ShowModal;
           Free;
        end;
end;

procedure TFrMain.Renovacin1Click(Sender: TObject);
begin
        FrmAfiliacion := TFrmAfiliacion.Create(self);
        FrmAfiliacion.es_afiliacion := False;
        FrmAfiliacion.Caption := 'Renovacion de Información';
        FrmAfiliacion.ShowModal;
        FrmAfiliacion.Free;
end;

procedure TFrMain.Asociado1Click(Sender: TObject);
begin
        FrmCarnet := TFrmCarnet.Create(self);
        FrmCarnet.ShowModal;
        FrmCarnet.Free;
end;

procedure TFrMain.Beneficiaro1Click(Sender: TObject);
begin
        FrmCarnetBene := TFrmCarnetBene.Create(self);
        FrmCarnetBene.ShowModal;
end;

procedure TFrMain.ToolButton3Click(Sender: TObject);
begin
        frmbeneficiario := tfrmbeneficiario.Create(self);
        FrmBeneficiario.controlcolor := False;
        FrmBeneficiario.ShowModal;
end;

procedure TFrMain.ToolButton10Click(Sender: TObject);
begin
        Frmejemplo := TFrmEjemplo.Create(self);
        FrmEjemplo.ShowModal;
end;

procedure TFrMain.NAfiliacion1Click(Sender: TObject);
begin
        FrmNuevaAfiliacion := TFrmNuevaAfiliacion.Create(self);
        with FrmNuevaAfiliacion do
        begin
           //BTverificar.Visible := False;
           ShowModal;
           Free;
        end;
end;

procedure TFrMain.Fecha1Click(Sender: TObject);
begin
        FrmActualizafecha := TFrmActualizafecha.Create(self);
        FrmActualizafecha.ShowModal;
end;

procedure TFrMain.Usuario1Click(Sender: TObject);
begin
        FrmActualizaBene := TFrmActualizaBene.Create(self);
        FrmActualizaBene.ShowModal;
end;

procedure TFrMain.Asociado2Click(Sender: TObject);
begin
        FrmCarnet := TFrmCarnet.Create(self);
        FrmCarnet.Caption := 'Actualizar Numeros de Certificados Por Titular de la Cuenta';
        FrmCarnet.ShowModal;
        FrmCarnet.Free;
end;

procedure TFrMain.Beneficiario1Click(Sender: TObject);
begin
        FrmCarnetBene := TFrmCarnetBene.Create(self);
        FrmCarnet.Caption := 'Actualizar Numeros de Certificados Por Beneficiario';
        FrmCarnetBene.ShowModal;
        FrmCarnetBene.Free;
end;

procedure TFrMain.RegistrarEps1Click(Sender: TObject);
begin
        FrmEps := TFrmEps.Create(self);
        FrmEps.ShowModal;
end;

procedure TFrMain.AfiliacionEps1Click(Sender: TObject);
begin
        FrmAfiliacionEps := TFrmAfiliacionEps.Create(self);
        FrmAfiliacionEps.ShowModal;
end;

procedure TFrMain.Salir2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrMain.SalidadeActivos2Click(Sender: TObject);
begin
        Afiliacion1.Click;
end;

procedure TFrMain.Proveedores1Click(Sender: TObject);
begin
        Renovacin1.Click;
end;

procedure TFrMain.Empleados1Click(Sender: TObject);
begin
        NAfiliacion1.Click;
end;

procedure TFrMain.Entradas2Click(Sender: TObject);
begin
        FrmBeneficiario := TFrmBeneficiario.Create(self);
        FrmBeneficiario.ShowModal;
end;

procedure TFrMain.Articulo4Click(Sender: TObject);
begin
        Buscar1.Click;
end;

procedure TFrMain.RegistrosVencidos1Click(Sender: TObject);
begin
        FrmBeneficiario := TFrmBeneficiario.Create(self);
        with FrmBeneficiario do
        begin
          Tipo.Visible := False;
          Tipoa.Visible := False;
          Label1.Visible := False;
          Label2.Visible := False;
          fecha1.Visible := False;
          fecha2.Visible := False;
          Panel4.Font.Size := 14;
          Panel4.Caption := 'Reporte Beneficiarios Con Fechas Vencidas';
          Caption := FrMain.titulo;
          opcion_beneficiario := 1;
          ShowModal;
        end;
end;

procedure TFrMain.AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
begin
 case Msg.Message of
    WM_KEYFIRST..WM_KEYLAST,
    WM_LBUTTONDOWN..WM_MOUSELAST,WM_MOUSEMOVE: begin FUltimaActividad := Now;apagar := False;end;
  end;
end;

procedure TFrMain.ReversarAfiliacion1Click(Sender: TObject);
begin
        FrmReversar := TFrmReversar.Create(self);
        FrmReversar.ShowModal;
end;

procedure TFrMain.RegistrarTipodeCapacitacion1Click(Sender: TObject);
begin
        FrmTipocapacitacion := TFrmTipocapacitacion.Create(self);
        FrmTipocapacitacion.ShowModal;
end;

procedure TFrMain.RegistrarCapacitacion1Click(Sender: TObject);
begin
        FrmCapacitaciones := TFrmCapacitaciones.Create(self);
        FrmCapacitaciones.ShowModal;
end;

procedure TFrMain.RegistrarCapacitaciones1Click(Sender: TObject);
begin
        FrmRegistropas := TFrmRegistropas.Create(self);
        FrmRegistropas.ShowModal;
end;

procedure TFrMain.Capacitacion1Click(Sender: TObject);
begin
        FrmRegistrocap := TFrmRegistrocap.Create(self);
        FrmRegistrocap.ShowModal;
end;

procedure TFrMain.Asociado3Click(Sender: TObject);
begin
        FrmRepcapacitaciones := TFrmRepcapacitaciones.Create(self);
        FrmRepcapacitaciones.ShowModal;
end;

procedure TFrMain.Fecha2Click(Sender: TObject);
begin
        FrmRepCapacitacion := TFrmRepCapacitacion.Create(self);
        FrmRepCapacitacion.ShowModal;
end;

procedure TFrMain.Conferencistas1Click(Sender: TObject);
begin
        FrmCapacitacionCon := TFrmCapacitacionCon.Create(Self);
        FrmCapacitacionCon.ShowModal;
end;

procedure TFrMain.Consulta2Click(Sender: TObject);
begin
        FrmConsulta := TFrmConsulta.Create(self);
        FrmConsulta.ShowModal;
end;

procedure TFrMain.Salir1Click(Sender: TObject);
begin
        Close;
end;

procedure TFrMain.ConfigurarImpresora1Click(Sender: TObject);
begin
        PrinterSetupDialog.Execute
end;

procedure TFrMain.ToolButton2Click(Sender: TObject);
begin
        Afiliacion1Click(Self);
end;

procedure TFrMain.RegistrarConvenio1Click(Sender: TObject);
begin
        FrmConvenio := TFrmConvenio.Create(self);
        FrmConvenio.ShowModal;
end;

procedure TFrMain.Beneficiarios2Click(Sender: TObject);
begin
        FrmRepBeneficiarios := TFrmRepBeneficiarios.Create(self);
        FrmRepBeneficiarios.es_asociado := False;
        FrmRepBeneficiarios.ShowModal;
end;

procedure TFrMain.ddd1Click(Sender: TObject);
begin
        frmbeneficiario := TFrmBeneficiario.Create(self);
        FrmBeneficiario .controlcolor := False;
        FrmBeneficiario.ShowModal;
end;

procedure TFrMain.Asociados2Click(Sender: TObject);
begin
        FrmRepBeneficiarios := TFrmRepBeneficiarios.Create(self);
        FrmRepBeneficiarios.es_asociado := True;
        FrmRepBeneficiarios.Caption:= 'Reporte Asociados...';
        FrmRepBeneficiarios.ShowModal;
end;

procedure TFrMain.itulares1Click(Sender: TObject);
begin
//        FrmAsociadoTitular := TFrmAsociadoTitular.Create(self);
//        FrmAsociadoTitular.ShowModal;
        FrmActaulizaBene := TFrmActaulizaBene.Create(self);
        FrmActaulizaBene.ShowModal;
end;

procedure TFrMain.Consulta3Click(Sender: TObject);
begin
        consulta2click(Self);
end;

procedure TFrMain.VentasporEmpleado1Click(Sender: TObject);
begin
        FrmRepVentas := TFrmRepVentas.Create(self);
        FrmRepVentas.ShowModal
end;

procedure TFrMain.AsistenciaPasantias1Click(Sender: TObject);
begin
        FrmAsistencia := TFrmAsistencia.Create(self);
        FrmAsistencia.ShowModal
end;

procedure TFrMain.Documento1Click(Sender: TObject);
begin
        FrmActualizanit := TFrmActualizanit.Create(self);
        FrmActualizanit.ShowModal;
end;

procedure TFrMain.EliminarCapacitacin1Click(Sender: TObject);
begin
        FrmElicapacitacion := TFrmElicapacitacion.Create(self);
        FrmElicapacitacion.ShowModal
end;

procedure TFrMain.Formulario1Click(Sender: TObject);
begin
        FrmInformacion := TFrmInformacion.Create(self);
        FrmInformacion.ShowModal;
end;

procedure TFrMain.RecuperarReporte1Click(Sender: TObject);
begin
        FrmBuscaSolicitud := TFrmBuscaSolicitud.Create(self);
        FrmBuscaSolicitud.ShowModal;
end;

procedure TFrMain.Solicitudes1Click(Sender: TObject);
begin
        FrmEstadoSolicitud := TFrmEstadoSolicitud.Create(self);
        FrmEstadoSolicitud.ShowModal;
end;

procedure TFrMain.MMMMM1Click(Sender: TObject);
begin
        FrmBuscaSolicitud := TFrmBuscaSolicitud.Create(self);
        FrmBuscaSolicitud.JVactualiza.Visible := True;
        FrmBuscaSolicitud.ShowModal;

end;

procedure TFrMain.Conyuge1Click(Sender: TObject);
begin
        FrmConyuge := TFrmConyuge.Create(Self);
        FrmConyuge.ShowModal
end;

procedure TFrMain.Timer1Timer(Sender: TObject);
begin
      try
        IdTime1.Host := DBserver;
        IdTime1.SyncTime;
        IdTime1.DateTime;
      finally
        IdTime1.Disconnect;
      end;

end;

procedure TFrMain.ConsultadeProductos1Click(Sender: TObject);
var
   frmConsultaProductos:TfrmConsultaProductos;
begin
        frmConsultaProductos := TfrmConsultaProductos.Create(Self);
        frmConsultaProductos.ShowModal;
end;

procedure TFrMain.RequerimientoSistemas1Click(Sender: TObject);
begin
        FrmCambiosFun := TFrmCambiosFun.Create(Self);
        FrmCambiosFun.ShowModal;
end;

procedure TFrMain.PlanosCredividas1Click(Sender: TObject);
begin
        FrmPlanoCredivida := TFrmPlanoCredivida.Create(Self);
        FrmPlanoCredivida.ShowModal
end;

procedure TFrMain.CredividasVencidos1Click(Sender: TObject);
begin
        FrmCredividasVencidos := TFrmCredividasVencidos.Create(Self);
        FrmCredividasVencidos._iOpcion := 2;
        FrmCredividasVencidos.Caption := 'Credividas Vencidos';
        FrmCredividasVencidos.ShowModal
end;

procedure TFrMain.CredividasVendidos1Click(Sender: TObject);
begin
        FrmCredividasVencidos := TFrmCredividasVencidos.Create(Self);
        FrmCredividasVencidos._iOpcion := 1;
        FrmCredividasVencidos.Caption := 'Credividas Vendidos';        
        FrmCredividasVencidos.ShowModal

end;

end.
