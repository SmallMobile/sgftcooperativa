unit UnitPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls, ImgList, ToolWin, jpeg, ExtCtrls,IniFiles,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdTime,MAth,
  DB, IBCustomDataSet, IBQuery, IBSQL, JclDateTime,Shellapi;

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
    General1: TMenuItem;
    Entidades1: TMenuItem;
    RegistrarEmpleado1: TMenuItem;
    IngresarEmpleado1: TMenuItem;
    Salir1: TMenuItem;
    RegistrarPrestacion1: TMenuItem;
    Primas1: TMenuItem;
    Vacaciones1: TMenuItem;
    Descuentos1: TMenuItem;
    ToolButton3: TToolButton;
    Descuentos2: TMenuItem;
    HorasExtras1: TMenuItem;
    Nomina1: TMenuItem;
    Nomina2: TMenuItem;
    RealizarNomina1: TMenuItem;
    RegistrarNomina1: TMenuItem;
    Reportes1: TMenuItem;
    CuentasPorCobrar1: TMenuItem;
    ReporteIndividualdePaga1: TMenuItem;
    Actualizar1: TMenuItem;
    Empleado1: TMenuItem;
    Fondos1: TMenuItem;
    ReportesCartera1: TMenuItem;
    Viaticos1: TMenuItem;
    Causaciones1: TMenuItem;
    ReportesCausacin1: TMenuItem;
    Realizar1: TMenuItem;
    Reportes2: TMenuItem;
    Servicios1: TMenuItem;
    Navidad1: TMenuItem;
    Antiguedad1: TMenuItem;
    PVacaciones1: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    Datos1: TMenuItem;
    ablaObligaciones1: TMenuItem;
    Agencias1: TMenuItem;
    Navidad2: TMenuItem;
    Servicios2: TMenuItem;
    ObligacionesLaborales1: TMenuItem;
    LimpiarTablas1: TMenuItem;
    DescuentosEmpleados1: TMenuItem;
    OLaboralesDIAN1: TMenuItem;
    Obligaciones1: TMenuItem;
    Prestaciones1: TMenuItem;
    General2: TMenuItem;
    Causacion1: TMenuItem;
    RecuperaNomina1: TMenuItem;
    VerificarFecha1: TMenuItem;
    ObligacionesConsolidadas1: TMenuItem;
    PrimadeServicios1: TMenuItem;
    HorasExtras2: TMenuItem;
    EReversarHorasExtras1: TMenuItem;
    Retefuente1: TMenuItem;
    EliminarEmpleado1: TMenuItem;
    PrimadeNavidad1: TMenuItem;
    Descuentos3: TMenuItem;
    Recuperar1: TMenuItem;
    HorasExtras3: TMenuItem;
    PagoInteres1: TMenuItem;
    CancelaInteres1: TMenuItem;
    CancelaInteres2: TMenuItem;
    CausacinCesantias1: TMenuItem;
    Cesantias1: TMenuItem;
    ObligacionesLaborales2: TMenuItem;
    PorcentageSaludyPensin1: TMenuItem;
    AportesPensin1: TMenuItem;
    Procesos1: TMenuItem;
    NotasContables1: TMenuItem;
    Aporte1: TMenuItem;
    CancelarContrato1: TMenuItem;
    N11: TMenuItem;
    IBQuery1: TIBQuery;
    IBQuery2: TIBQuery;
    DesmarcarColocacion1: TMenuItem;
    Gestiones1: TMenuItem;
    RequerimientoSistemas1: TMenuItem;
    Timer1: TTimer;
    IdTime1: TIdTime;
    N12: TMenuItem;
    ReporteLiquidacion1: TMenuItem;
    Exportar1: TMenuItem;
    ReportesPDF1: TMenuItem;
    EstudioEmpleados1: TMenuItem;
    GestiondeEstudios1: TMenuItem;
    IngresarLibranza1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton1Click(Sender: TObject);
    procedure Entidades1Click(Sender: TObject);
    procedure RegistrarEmpleado1Click(Sender: TObject);
    procedure IngresarEmpleado1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure RegistrarPrestacion1Click(Sender: TObject);
    procedure Vacaciones1Click(Sender: TObject);
    procedure Descuentos1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure HorasExtras1Click(Sender: TObject);
    procedure Nomina1Click(Sender: TObject);
    procedure RealizarNomina1Click(Sender: TObject);
    procedure RegistrarNomina1Click(Sender: TObject);
    procedure Nomina2Click(Sender: TObject);
    procedure CuentasPorCobrar1Click(Sender: TObject);
    procedure ReporteIndividualdePaga1Click(Sender: TObject);
    procedure Empleado1Click(Sender: TObject);
    procedure Fondos1Click(Sender: TObject);
    procedure ReportesCartera1Click(Sender: TObject);
    procedure Causaciones1Click(Sender: TObject);
    procedure ReportesCausacin1Click(Sender: TObject);
    procedure Servicios1Click(Sender: TObject);
    procedure Navidad1Click(Sender: TObject);
    procedure Antiguedad1Click(Sender: TObject);
    procedure PVacaciones1Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure Datos1Click(Sender: TObject);
    procedure ablaObligaciones1Click(Sender: TObject);
    procedure Navidad2Click(Sender: TObject);
    procedure Servicios2Click(Sender: TObject);
    procedure ObligacionesLaborales1Click(Sender: TObject);
    procedure DescuentosEmpleados1Click(Sender: TObject);
    procedure OLaboralesDIAN1Click(Sender: TObject);
    procedure Obligaciones1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure Prestaciones1Click(Sender: TObject);
    procedure General2Click(Sender: TObject);
    procedure LimpiarTablas1Click(Sender: TObject);
    procedure Causacion1Click(Sender: TObject);
    procedure RecuperaNomina1Click(Sender: TObject);
    procedure VerificarFecha1Click(Sender: TObject);
    procedure ObligacionesConsolidadas1Click(Sender: TObject);
    procedure PrimadeServicios1Click(Sender: TObject);
    procedure HorasExtras2Click(Sender: TObject);
    procedure EReversarHorasExtras1Click(Sender: TObject);
    procedure Retefuente1Click(Sender: TObject);
    procedure EliminarEmpleado1Click(Sender: TObject);
    procedure PrimadeNavidad1Click(Sender: TObject);
    procedure Descuentos3Click(Sender: TObject);
    procedure HorasExtras3Click(Sender: TObject);
    procedure PagoInteres1Click(Sender: TObject);
    procedure CancelaInteres1Click(Sender: TObject);
    procedure CancelaInteres2Click(Sender: TObject);
    procedure CausacinCesantias1Click(Sender: TObject);
    procedure Cesantias1Click(Sender: TObject);
    procedure ObligacionesLaborales2Click(Sender: TObject);
    procedure PorcentageSaludyPensin1Click(Sender: TObject);
    procedure AportesPensin1Click(Sender: TObject);
    procedure NotasContables1Click(Sender: TObject);
    procedure Aporte1Click(Sender: TObject);
    procedure CancelarContrato1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure DesmarcarColocacion1Click(Sender: TObject);
    procedure RequerimientoSistemas1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure ReporteLiquidacion1Click(Sender: TObject);
    procedure Exportar1Click(Sender: TObject);
    procedure ReportesPDF1Click(Sender: TObject);
    procedure EstudioEmpleados1Click(Sender: TObject);
    procedure GestiondeEstudios1Click(Sender: TObject);
    procedure IngresarLibranza1Click(Sender: TObject);
  private
    { Private declarations }
  public
    salirmal: boolean;
    MiINI: string;
    DBserver,DBserver1: string;
    DBPath,DBPath1: string;
    DBname,DBname1: string;
    Empresa: string;
    Nit: string;
    Agencia: integer;
    Ciudad: string;
    Dbalias: string;
    DBPasabordo: string;
    wpath : string;
    fechacartera: tdate;
    FUltimaActividad :TDate;
    apagar :Boolean;
    procedure cuenta1(opcion: integer);
    procedure AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
  published
    function fecha: boolean;
    function fechac: boolean;
    function ExecAppWait(AppName, Params: string): Boolean;

    { Public declarations }
  end;
var
  FrMain: TFrMain;

implementation
uses unitlogin,unitdatamodulo, UnitEntidad, UnitEmpleado, UnitDatosempleado,
  UnitPrestacion, Unitdata, UnitVacaciones, UnitDescuento,
  UnitHorasExtras, UnitNomina, UnitRealizaNomina, UnitQuerys,unitglobal,
  Unitcuentasporcobrar, Unitprogreso,
  UnitCartera, UnitFondos, UnitRepCartera, UnitCausacion, UnitPrimas,
  UnitNovedades, UnitAgencias, UnitObligacionesLab, UnitActualizacausacion,
  UnitRecupera, UnitEliminaHoras, UnitRetefuente, UnitEliminaEmpleado,
  UnitPagoPrimas, UnitModDescuentos, UnitRecuperaHoras,
  UnitCausacionCesantias, UnitActualizaPension, UnitdmGeneral, UnitPension,
  Unit_Comprobante,UnitGlobales, UnitCancelar, UnitRegistraCol,
  UnitCambiosFun, UnitExportar, UnitEstudios, UnitGestionEstudios,UnitIngresaLibranza;


{$R *.dfm}

procedure TFrMain.FormCreate(Sender: TObject);
var Login: TLogin;
    Veces: SmallInt;
    Mensaje: string;
    validahora,hora: Integer;
begin
  ShortDateFormat := 'yyyy/mm/dd';
  wpath := ExtractFilePath(ParamStr(0));
  DecimalSeparator := '.';
  ThousandSeparator := ',';
  fechacartera := Date;
  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(MiINI) do
  try
    DBserver := ReadString('DBNAME','server','192.168.1.8');
    DBserver1 := ReadString('DBNAME1','server','192.168.1.8');
    DBPath := ReadString('DBNAME','path','/base/');
    DBPath1 := ReadString('DBNAME1','path','/base/');
    DBname := ReadString('DBNAME','name','inventario.gdb');
    DBname1 := ReadString('DBNAME1','name','coopservir.gdb');
    Empresa := ReadString('EMPRESA','name','COOPSERVIR LTDA');
    Nit     := ReadString('EMPRESA','nit','890.505.363-6');
    Agencia := ReadInteger('EMPRESA','Agencia',1);
    vMes := ReadInteger('EMPRESA','Mes',12);
    Ciudad  := ReadString('EMPRESA','city','OCAÑA N.S.');
    unitglobales.Agencia := Agencia;
  finally
    free;
  end;
  try
  //IDserver.Host := DBserver;
  hora := 700;
  //Timer1.OnTimer(Sender);
  //ShowMessage(FormatDateTime('yyyy/mm/dd hh:mm',IDserver.DateTime));
  //validahora := StrToInt(FormatDateTime('Hnn',IDserver.DateTime));
  validahora := 800;
  if validahora > hora then
  begin
        Veces := 0;
        Login := Tlogin.Create(Self);
        datageneral := tdatageneral.Create(self);
        frmdata := Tfrmdata.Create(self);
        dmGeneral := TdmGeneral.Create(self);
        DataGeneral.IBDatabase1.Connected := False;
         while Not datageneral.IBDatabase1.Connected do
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
                vRol := 'NOMINA';
                DBAlias := LowerCase(Usuario.Text);
                DBPasabordo := LowerCase(password.Text);
                DataGeneral.IBDatabase1.DataBaseName := DBserver + ':' + DBpath + DBname;
                DataGeneral.IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
                DataGeneral.IBDatabase1.Params.Values['User_Name'] := DBAlias;
                DataGeneral.IBDatabase1.Params.Values['PassWord'] := DBPasabordo;
                //DataGeneral.IBDatabase1.Params.Values['sql_role_name'] := 'NOMINA';
                frmdata.IBDatabase2.DataBaseName := DBserver1 + ':' + DBpath1 + DBname1;
                frmdata.IBDatabase2.Params.Values['lc_ctype'] := 'ISO8859_1';
                frmdata.IBDatabase2.Params.Values['User_Name'] := DBAlias;
                frmdata.IBDatabase2.Params.Values['PassWord'] := DBPasabordo;
                frmdata.IBDatabase2.Params.Values['sql_role_name'] := 'AUXILIAR';
                dmGeneral.IBDatabase1.DatabaseName := DBserver1 + ':' + DBpath1 + DBname1;
                dmGeneral.IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
                dmGeneral.IBDatabase1.Params.Values['User_Name'] := DBAlias;
                dmGeneral.IBDatabase1.Params.Values['PassWord'] := DBPasabordo;
                dmGeneral.IBDatabase1.Params.Values['sql_role_name'] := 'AUXILIAR';

                // *************
                FrMain.Caption := 'SISTEMA DE NOMINA DE CREDISERVIR LTDA 2011/01/06 '+ DBserver1 + ' INVENTARIOS. ' + DBserver;
                Veces := Veces + 1;
                try
                  DataGeneral.IBDatabase1.Connected := True;
                  DataGeneral.IBTransaction1.Active := True;
                  frmdata.IBDatabase2.Connected := True;
                  frmdata.IBTransaction2.Active := True;
                  dmGeneral.IBDatabase1.Connected := True;
                  dmGeneral.IBTransaction1.Active := True;
                  UnitGlobales.DBAlias := UpperCase(dbalias);
                  UnitGlobales.Nit := Nit;
                  UnitGlobales.Empresa := Empresa;
                  if fecha then
                    RealizarNomina1.Visible := False;
                  if fechac then
                    Causaciones1.Visible := True; // Ojo Cambiar
                  if (StrToInt(FormatDateTime('m',Date)) in [6,12]) then
                  begin
                      Servicios1.Visible := True;
                      Servicios2.Visible := True;
                  end;
                  if tabla then
                     LimpiarTablas1.Visible := True;
                  if (StrToInt(FormatDateTime('m',Date)) in [12]) then
                  begin
                     Navidad1.Visible := True;
                     Navidad2.Visible := True;
                     PagoInteres1.Visible := True;
                     CancelaInteres1.Visible := True;
                     CancelaInteres2.Visible := True;
                  end;
                except
                     on E: Exception do
                     begin
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
           salirmal:=true;
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
        if Not SalirMal then
        if MessageDlg('Cerrar Sistema de Nomina de CREDISERVIR LTDA.',mtInformation,[mbYes,mbNo],0) = mrYes Then
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
          finally }
           begin
            dataGeneral.IBDatabase1.Connected := False;
            dataGeneral.IBTransaction1.Active  := False;
            frmdata.IBDatabase2.Connected := False;
            frmdata.IBTransaction2.Active := False;
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

procedure TFrMain.ToolButton1Click(Sender: TObject);
begin
        Close;
end;

procedure TFrMain.Entidades1Click(Sender: TObject);
begin
        FrmEntidad := TFrmEntidad.Create(self);
        FrmEntidad.ShowModal;
end;

procedure TFrMain.RegistrarEmpleado1Click(Sender: TObject);
begin
        FrmEmpleado := TFrmEmpleado.Create(self);
        FrmEmpleado.actualizar := True;
        FrmEmpleado.ShowModal;
end;

procedure TFrMain.IngresarEmpleado1Click(Sender: TObject);
begin
        frmempleado1 := TFrmempleado1.Create(self);
        Frmempleado1.ShowModal;
end;

procedure TFrMain.Salir1Click(Sender: TObject);
begin
        Close;
end;

procedure TFrMain.RegistrarPrestacion1Click(Sender: TObject);
begin
        FrmPrestacion := tFrmPrestacion.Create(self);
        FrmPrestacion.ShowModal;
end;

procedure TFrMain.Vacaciones1Click(Sender: TObject);
begin
        FrmVacaciones := TFrmVacaciones.Create(self);
        FrmVacaciones.ShowModal;
end;

procedure TFrMain.Descuentos1Click(Sender: TObject);
begin
        FrmDescuentos := TFrmDescuentos.Create(self);
        FrmDescuentos.ShowModal;
end;

procedure TFrMain.ToolButton3Click(Sender: TObject);
begin
        RegistrarEmpleado1.Click;
end;

procedure TFrMain.HorasExtras1Click(Sender: TObject);
begin
        FrmHorasExtras := TFrmHorasExtras.Create(self);
        FrmHorasExtras.ShowModal;
end;

procedure TFrMain.Nomina1Click(Sender: TObject);
begin
        FrmCartera := TFrmCartera.Create(self);
        FrmCartera.ShowModal;
end;

procedure TFrMain.RealizarNomina1Click(Sender: TObject);
begin
        FrmRealizaNomina := TFrmRealizaNomina.Create(self);
        FrmRealizaNomina.opcion_boton := 1;
        FrmRealizaNomina.IBtiponomina.Open;
        FrmRealizaNomina.IBtiponomina.Last;
        FrmRealizaNomina.Bnomina.Caption := '&Cancelar';
        FrmRealizaNomina.Hint := 'Elimina la Nomina Actual';
        FrmRealizaNomina.BACEPTAR.Glyph.LoadFromFile(wpath+'icon\Aceptar.bmp');
        FrmRealizaNomina.Bnomina.Glyph.LoadFromFile(wpath+'icon\Cancelar.bmp');
        //FrmRealizaNomina.DBLtiponomina.Visible := True;
        FrmRealizaNomina.ShowModal;
end;

procedure TFrMain.RegistrarNomina1Click(Sender: TObject);
begin
        FrmRealizaNomina := TFrmRealizaNomina.Create(self);
        FrmRealizaNomina.opcion_boton := 2;
        FrmRealizaNomina.BACEPTAR.Caption := '&Comprobante';
        FrmRealizaNomina.BACEPTAR.Hint := 'Nota Contable de Cada Tipo de Nomina.';
        FrmRealizaNomina.Bnomina.Caption := '&Reporte';
        FrmRealizaNomina.Hint := 'Reporte de Nomina';
        FrmRealizaNomina.BACEPTAR.Glyph.LoadFromFile(wpath+'icon\Impresora.bmp');
        FrmRealizaNomina.Bnomina.Glyph.LoadFromFile(wpath+'icon\Reporte.bmp');
        FrmRealizaNomina.DBLtiponomina.Visible := True;
        FrmRealizaNomina.IBtiponomina.Open;
        FrmRealizaNomina.IBtiponomina.Last;
        FrmRealizaNomina.Label1.Visible := True;
        FrmRealizaNomina.l.Caption := '';
        FrmRealizaNomina.Caption := 'Reportes de Nomina';
        FrmRealizaNomina.ShowModal;
end;

function TFrMain.fecha: boolean;
var     fecha1,fecha2,opcion :string;
begin
        DataQuerys := TDataQuerys.Create(self);
        with DataQuerys.IBdatos do
        begin
           Close;
           verificatransaccion(DataQuerys.IBdatos);
           SQL.Clear;
           SQL.Add('select "nom$controlnomina"."fecha"');
           SQL.Add('from "nom$controlnomina"');
           SQL.Add('where "nom$controlnomina"."cod_nomina" = :cfecha');
           ParamByName('cfecha').AsInteger := buscanomina(DataQuerys.IBselecion);
           Open;
           fecha1 := FormatDateTime('yyyy/mm/dd',FieldByName('fecha').AsDateTime);
           Close;
        end;
        fecha2 := FormatDateTime('yyyy/mm/01',Date);
        opcion := FormatDateTime('dd',Date);
           if (fecha1 = fecha2) and (StrToInt(opcion) >= 1) then
              Result := False
           else
              Result := True;
end;

procedure TFrMain.Nomina2Click(Sender: TObject);
begin
           if fecha then
             RealizarNomina1.Visible := False;
             Causaciones1.Visible := Fechac;
end;

procedure TFrMain.CuentasPorCobrar1Click(Sender: TObject);
begin
        FrmCuentasPorCobrar := TFrmCuentasPorCobrar.Create(self);
        FrmCuentasPorCobrar.ShowModal;
end;

procedure TFrMain.ReporteIndividualdePaga1Click(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
        FrmNomina.reporteindividual;
end;

procedure TFrMain.cuenta1(opcion: integer);
begin

end;

procedure TFrMain.Empleado1Click(Sender: TObject);
begin
        FrmEmpleado := TFrmEmpleado.Create(self);
        FrmEmpleado.actualizar := False;
        FrmEmpleado.BACEPTAR.Caption := '&Actualizar';
        FrmEmpleado.Caption := 'Actualizar Empleado';
        FrmEmpleado.ShowModal;
end;

procedure TFrMain.Fondos1Click(Sender: TObject);
begin
        FrmFondos := TFrmFondos.Create(self);
        FrmFondos.ShowModal;
end;

procedure TFrMain.ReportesCartera1Click(Sender: TObject);
begin
        FrmRepCartera := TFrmRepCartera.Create(self);
        FrmRepCartera.ShowModal;
end;

procedure TFrMain.Causaciones1Click(Sender: TObject);
begin
        FrmCausacion := TFrmCausacion.Create(self);
        FrmCausacion.opcion_boton := 1;
        FrmCausacion.Bnomina.Caption := '&Cancelar';
        FrmCausacion.Hint := 'Elimina la Causacion Actual';
        FrmCausacion.BACEPTAR.Glyph.LoadFromFile(wpath+'icon\Aceptar.bmp');
        FrmCausacion.Bnomina.Glyph.LoadFromFile(wpath+'icon\Cancelar.bmp');
        FrmCausacion.Label1.Visible := True;
        FrmCausacion.ShowModal;
end;

procedure TFrMain.ReportesCausacin1Click(Sender: TObject);
begin
        FrmCausacion := TFrmCausacion.Create(self);
        FrmCausacion.opcion_boton := 2;
        FrmCausacion.BACEPTAR.Caption := '&Comprobante';
        FrmCausacion.BACEPTAR.Hint := 'Nota Contable de Cada Tipo de Nomina.';
        FrmCausacion.Bnomina.Caption := '&Reporte';
        FrmCausacion.Hint := 'Reporte de Nomina';
        FrmCausacion.BACEPTAR.Glyph.LoadFromFile(wpath+'icon\Impresora.bmp');
        FrmCausacion.Bnomina.Glyph.LoadFromFile(wpath+'icon\Reporte.bmp');
        FrmCausacion.Label2.Visible := True;
        FrmCausacion.IBagencia.Open;
        FrmCausacion.IBagencia.Last;
        FrmCausacion.DBagencia.Visible := True;
        FrmCausacion.Caption := 'Reportes Causacion';
        FrmCausacion.ShowModal;

end;

function TFrMain.fechac: boolean;
var    mes,opcion:string;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('MAX("nom$causacion"."mes") AS mes');
          SQL.Add('FROM');
          SQL.Add('"nom$causacion"');
          Open;
          mes := FieldByName('mes').AsString;
          Close;
        end;
        opcion := FormatDateTime('mm',Date);
           if (mes = opcion) then
              Result := False
           else
              Result := True;
        {if mes = FormatDateTime('mm',Date) then
          Result := true
        else
          Result := false}
end;

procedure TFrMain.Servicios1Click(Sender: TObject);
begin
        FrmPrimas := TFrmPrimas.Create(self);
        FrmPrimas.opcion := 1;
        FrmPrimas.Label1.Visible := True;
        FrmPrimas.ShowModal;
end;

procedure TFrMain.Navidad1Click(Sender: TObject);
begin
        FrmPrimas := TFrmPrimas.Create(self);
        FrmPrimas.opcion := 2;
        FrmPrimas.Label1.Visible := True;
        FrmPrimas.Caption := 'Pago Prima de Navidad';
        FrmPrimas.ShowModal;
end;

procedure TFrMain.Antiguedad1Click(Sender: TObject);
begin
        FrmPrimas := TFrmPrimas.Create(self);
        FrmPrimas.Emp.Visible := True;
        FrmPrimas.opcion := 4;
        FrmPrimas.Empleado.Visible := True;
        FrmPrimas.Caption := 'Pago Prima de Antiguedad';
        FrmPrimas.ShowModal;
end;

procedure TFrMain.PVacaciones1Click(Sender: TObject);
begin
        FrmPrimas := TFrmPrimas.Create(self);
        FrmPrimas.opcion := 3;
        FrmPrimas.Emp.Visible := True;
        FrmPrimas.Empleado.Visible := True;
        FrmPrimas.Caption := 'Pago Prima de Vacaciones';
        FrmPrimas.ShowModal;
end;

procedure TFrMain.ToolButton9Click(Sender: TObject);
begin
        Close;
end;

procedure TFrMain.Datos1Click(Sender: TObject);
begin
        FrmActualizar := TFrmActualizar.Create(self);
        FrmActualizar.ShowModal;
end;

procedure TFrMain.ablaObligaciones1Click(Sender: TObject);
begin
        FrmRealizaNomina := TFrmRealizaNomina.Create(self);
        FrmRealizaNomina.actulizaobligaciones;
end;

procedure TFrMain.Navidad2Click(Sender: TObject);
begin
        FrmAgencias := TFrmAgencias.Create(self);
        FrmAgencias.Caption := 'Traslado de Gastos Prima de Navidad';
        FrmAgencias.opcion := 1;
        FrmAgencias.ShowModal;
end;

procedure TFrMain.Servicios2Click(Sender: TObject);
begin
        FrmAgencias := TFrmAgencias.Create(self);
        FrmAgencias.Caption := 'Traslado de Gastos Prima de Servicios';
        FrmAgencias.opcion := 2;
        FrmAgencias.ShowModal;
end;

procedure TFrMain.ObligacionesLaborales1Click(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
        FrmNomina.ano_obligacion := StrtoInt(inputbox('Digite el Año: ','',IntToStr(YearOfDate(Date))));
        FrmNomina.obligaciones;
end;

procedure TFrMain.DescuentosEmpleados1Click(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
        FrmNomina.descuentos;
end;

procedure TFrMain.OLaboralesDIAN1Click(Sender: TObject);
begin
          FrmNomina := TFrmNomina.Create(self);
          FrmNomina.repdian;
end;

procedure TFrMain.Obligaciones1Click(Sender: TObject);
begin
        FrmObligacionLaboral := tFrmObligacionLaboral.Create(self);
        FrmObligacionLaboral.ShowModal;
end;

procedure TFrMain.ToolButton2Click(Sender: TObject);
begin
        Empleado1.Click;
end;

procedure TFrMain.ToolButton5Click(Sender: TObject);
begin
        Datos1.Click;
end;

procedure TFrMain.ToolButton7Click(Sender: TObject);
begin
        RegistrarPrestacion1.Click;
end;
procedure TFrMain.Prestaciones1Click(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
        FrmNomina.prestaciones;
end;

procedure TFrMain.General2Click(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
        FrmNomina.repgeneral;
end;

procedure TFrMain.LimpiarTablas1Click(Sender: TObject);
begin
        iniciaano;
end;

procedure TFrMain.Causacion1Click(Sender: TObject);
begin
        FrmActualizaCausacion := TFrmActualizaCausacion.Create(self);
        FrmActualizaCausacion.ShowModal;
end;

procedure TFrMain.RecuperaNomina1Click(Sender: TObject);
begin
        FrmRecupera := TFrmRecupera.Create(self);
        FrmRecupera.ShowModal;
end;

procedure TFrMain.VerificarFecha1Click(Sender: TObject);
begin
        MessageDlg('Fecha Actual : '+DateToStr(fechacartera),mtInformation,[mbok],0);
end;

procedure TFrMain.ObligacionesConsolidadas1Click(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
        FrmNomina.consolidada;
end;

procedure TFrMain.PrimadeServicios1Click(Sender: TObject);
begin
        FrmPagoPrimas := TFrmPagoPrimas.Create(self);
        FrmPagoPrimas.tipo_prima := 1;
        FrmPagoPrimas.Caption := 'Prima de Servicios';
        FrmPagoPrimas.ShowModal;
end;

procedure TFrMain.HorasExtras2Click(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
        FrmNomina.horaextra1;
end;

procedure TFrMain.EReversarHorasExtras1Click(Sender: TObject);
begin
        FrmReversar := TFrmReversar.Create(self);
        FrmReversar.ShowModal;
end;

procedure TFrMain.Retefuente1Click(Sender: TObject);
begin
        FrmReteFuente := TFrmReteFuente.Create(self);
        FrmReteFuente.ShowModal;
end;

procedure TFrMain.EliminarEmpleado1Click(Sender: TObject);
begin
        FrmEliminaEmpleado := TFrmEliminaEmpleado.Create(self);
        FrmEliminaEmpleado.ShowModal;
end;

procedure TFrMain.AtraparMensajes(var Msg: TMsg; var Handled: Boolean);
begin
case Msg.Message of
    WM_KEYFIRST..WM_KEYLAST,
    WM_LBUTTONDOWN..WM_MOUSELAST,WM_MOUSEMOVE: begin FUltimaActividad := Now;apagar := False; end;
  end;
end;

procedure TFrMain.PrimadeNavidad1Click(Sender: TObject);
begin
        FrmPagoPrimas := TFrmPagoPrimas.Create(self);
        FrmPagoPrimas.tipo_prima := 2;
        FrmPagoPrimas.Caption := 'Prima de Navidad';
        FrmPagoPrimas.ShowModal;

end;

procedure TFrMain.Descuentos3Click(Sender: TObject);
begin
        FrmModDescuentos := TFrmModDescuentos.Create(self);
        FrmModDescuentos.ShowModal;
end;

procedure TFrMain.HorasExtras3Click(Sender: TObject);
begin
        FrmRecuperaHora := TFrmRecuperaHora.Create(self);
        FrmRecuperaHora.ShowModal
end;

procedure TFrMain.PagoInteres1Click(Sender: TObject);
begin
        FrmPagoPrimas := TFrmPagoPrimas.Create(self);
        FrmPagoPrimas.tipo_prima := 3;
        FrmPagoPrimas.Caption := 'Pago Intereses de Cesantias';
        FrmPagoPrimas.ShowModal;
end;

procedure TFrMain.CancelaInteres1Click(Sender: TObject);
begin
        FrmPrimas := TFrmPrimas.Create(self);
        FrmPrimas.opcion := 10;
        FrmPrimas.Label1.Visible := True;
        FrmPrimas.Caption := 'Pago Interes de Cesantias';
        FrmPrimas.ShowModal;

end;

procedure TFrMain.CancelaInteres2Click(Sender: TObject);
begin
        FrmAgencias := TFrmAgencias.Create(self);
        FrmAgencias.Caption := 'Traslado de Gastos Interes Cesantias';
        FrmAgencias.opcion := 3;
        FrmAgencias.ShowModal;

end;

procedure TFrMain.CausacinCesantias1Click(Sender: TObject);
begin
        FrmCausacionCesantias := TFrmCausacionCesantias.Create(self);
        FrmCausacionCesantias.ShowModal;
end;

procedure TFrMain.Cesantias1Click(Sender: TObject);
begin
        FrmPagoPrimas := TFrmPagoPrimas.Create(self);
        FrmPagoPrimas.tipo_prima := 4;
        FrmPagoPrimas.Caption := 'Reporte Cesantias';
        FrmPagoPrimas.ShowModal;
end;

procedure TFrMain.ObligacionesLaborales2Click(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
        FrmNomina.ano_obligacion := StrToInt(InputBox('Digite el Año','Numero',inttostr(YearOfDate(Date))));
        FrmNomina.obligaciones;
end;

procedure TFrMain.PorcentageSaludyPensin1Click(Sender: TObject);
begin
        FrmActualizaPension := TFrmActualizaPension.Create(self);
        FrmActualizaPension.ShowModal;
end;

procedure TFrMain.AportesPensin1Click(Sender: TObject);
begin
        FrmPension := TFrmPension.Create(Self);
        FrmPension.ShowModal;

end;

procedure TFrMain.NotasContables1Click(Sender: TObject);
begin
        if dmGeneral.IBTransaction1.InTransaction then
           dmGeneral.IBTransaction1.Rollback;
        dmGeneral.IBTransaction1.StartTransaction;
        frmcomprobante := TfrmComprobante.Create(self);
        frmComprobante.ShowModal
end;

procedure TFrMain.Aporte1Click(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(Self);
        FrmNomina.pensiones
end;

procedure TFrMain.CancelarContrato1Click(Sender: TObject);
begin
        FrmCancelar := TFrmCancelar.Create(Self);
        FrmCancelar.ShowModal;
end;

procedure TFrMain.N11Click(Sender: TObject);
begin
{        with IBQuery1  do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('select * from "pruebas"');
          Open;
          IBQuery2.Close;
          IBQuery2.SQL.Clear;
          IBQuery2.SQL.Add('update "nom$obligaciones" set "nom$obligaciones"."int_cesantias" = :INT where "nom$obligaciones"."nit" = :NIT');
          while not Eof do
          begin
            IBQuery2.ParamByName('INT').AsCurrency := FieldByName('interes').AsCurrency;
            IBQuery2.ParamByName('NIT').AsCurrency := FieldByName('nit').AsInteger;
            IBQuery2.ExecSQL;
            Next;
          end;
          Transaction.Commit;
          ShowMessage('listo');
        end;
                FrmCausacion := TFrmCausacion.Create(self);
        FrmCausacion.opcion_boton := 1;
        FrmCausacion.Bnomina.Caption := '&Cancelar';
        FrmCausacion.Hint := 'Elimina la Causacion Actual';
        FrmCausacion.BACEPTAR.Glyph.LoadFromFile(wpath+'icon\Aceptar.bmp');
        FrmCausacion.Bnomina.Glyph.LoadFromFile(wpath+'icon\Cancelar.bmp');
        FrmCausacion.Label1.Visible := True;
        FrmCausacion.ShowModal; }

end;

procedure TFrMain.DesmarcarColocacion1Click(Sender: TObject);
begin
        FrmDesmarcarCol := TFrmDesmarcarCol.Create(Self);
        FrmDesmarcarCol.ShowModal;
end;

procedure TFrMain.RequerimientoSistemas1Click(Sender: TObject);
begin
        frmCambiosFun := tfrmcambiosfun.Create(Self);
        FrmCambiosFun.ShowModal;
end;

procedure TFrMain.Timer1Timer(Sender: TObject);
begin
{      try
        IdTime1.Host := DBserver;
        IdTime1.SyncTime;
        IdTime1.DateTime;
      finally
        IdTime1.Disconnect;
      end;}

end;

procedure TFrMain.N12Click(Sender: TObject);
begin
        iniciaano
end;

procedure TFrMain.ReporteLiquidacion1Click(Sender: TObject);
begin
        WinExec(PChar(wpath + '\Reporte.exe'),SW_SHOWNORMAL);
end;

procedure TFrMain.Exportar1Click(Sender: TObject);
begin
        FrmExportarPagos := TFrmExportarPagos.Create(Self);
        FrmExportarPagos.ShowModal;
end;

procedure TFrMain.ReportesPDF1Click(Sender: TObject);
var _iCodigo :string;
begin
        if not DirectoryExists('c:\pdf') then
           CreateDir('c:\pdf');
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('select max("nom$nomina"."codigo_nomina") as codigo');
          SQL.Add('from "nom$nomina"');
          Open;
          _iCodigo := FieldByName('codigo').AsString;
        end;
        self.ExecAppWait(ExtractFilePath(Application.ExeName)+ 'RepPago.exe',_iCodigo);
end;

function TFrMain.ExecAppWait(AppName, Params: string): Boolean;
var
  ShellExInfo: TShellExecuteInfo; // structure containing and receiving info about application to start
begin
 FillChar(ShellExInfo, SizeOf(ShellExInfo), 0);
 with ShellExInfo do begin
    cbSize := SizeOf(ShellExInfo);
    fMask := see_Mask_NoCloseProcess;
    Wnd := Application.Handle;
    lpFile := PChar(AppName);
    lpParameters := PChar(Params);
    nShow := sw_ShowNormal;
 end;
  Result := ShellExecuteEx(@ShellExInfo);
  WaitForSingleObject(ShellExInfo.hProcess, INFINITE);
  CloseHandle(ShellExInfo.hProcess);
 end;
procedure TFrMain.EstudioEmpleados1Click(Sender: TObject);
begin
        FrmEstudios := TFrmEstudios.Create(Self);
        FrmEstudios.ShowModal;
end;

procedure TFrMain.GestiondeEstudios1Click(Sender: TObject);
begin
        FrmGestionEstudios := TFrmGestionEstudios.Create(Self);
        FrmGestionEstudios.ShowModal;
end;

procedure TFrMain.IngresarLibranza1Click(Sender: TObject);
var frm :TFrmIngresaLibranza;
begin
        frm := TFrmIngresaLibranza.Create(Self);
        frm.ShowModal;
end;

end.
