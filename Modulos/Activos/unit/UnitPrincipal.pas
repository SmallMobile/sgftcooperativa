unit UnitPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls, ImgList, ToolWin, jpeg, ExtCtrls,IniFiles,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdTime,MAth,
  DB, IBCustomDataSet, IBQuery, IBSQL;

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
    rr: TMenuItem;
    Activo1: TMenuItem;
    Factura1: TMenuItem;
    Entrega1: TMenuItem;
    Proveedor1: TMenuItem;
    Mantenimiento1: TMenuItem;
    raslado1: TMenuItem;
    Mejoras1: TMenuItem;
    Salir1: TMenuItem;
    ConfigurarImpresora1: TMenuItem;
    Reportes1: TMenuItem;
    Captura1: TMenuItem;
    SalidadeActivos1: TMenuItem;
    ActualizarPolizas1: TMenuItem;
    DevoluciondeActivos1: TMenuItem;
    Consultas1: TMenuItem;
    Acta1: TMenuItem;
    Depreciacion1: TMenuItem;
    DepreciacionActual1: TMenuItem;
    Depreciaciones1: TMenuItem;
    DigitarComprobante1: TMenuItem;
    IDserver: TIdTime;
    ElementosdeTrabajo1: TMenuItem;
    ToolButton2: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    Activo2: TMenuItem;
    Polizas1: TMenuItem;
    CancelarPolizas1: TMenuItem;
    SalidadeActivos2: TMenuItem;
    ActivosDepreciados1: TMenuItem;
    M1: TMenuItem;
    Inventario1: TMenuItem;
    Seccion1: TMenuItem;
    Sucursal1: TMenuItem;
    Elementos1: TMenuItem;
    AbrirReporte1: TMenuItem;
    Empleado1: TMenuItem;
    Seccion2: TMenuItem;
    Empleado2: TMenuItem;
    General1: TMenuItem;
    Actualizar1: TMenuItem;
    ActualizarActivo1: TMenuItem;
    ActivosnoEntregados1: TMenuItem;
    UPlacaAsignada1: TMenuItem;
    Activo3: TMenuItem;
    Elemento1: TMenuItem;
    IBplaca: TIBQuery;
    Componentes1: TMenuItem;
    Entrega2: TMenuItem;
    IBSQL1: TIBSQL;
    ToolButton11: TToolButton;
    ToolButton10: TToolButton;
    ToolButton12: TToolButton;
    rslados1: TMenuItem;
    ActualizarContrasea1: TMenuItem;
    ADadosdeBaja1: TMenuItem;
    ActualizarPlaca1: TMenuItem;
    CalcularDepreciacin1: TMenuItem;
    OtrosActivos1: TMenuItem;
    ipo1: TMenuItem;
    Sucursal2: TMenuItem;
    DepreciacionNormal1: TMenuItem;
    RequerimientoSistemas1: TMenuItem;
    Gestiones1: TMenuItem;
    RequeimientoSistemas1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Activo1Click(Sender: TObject);
    procedure Entrega1Click(Sender: TObject);
    procedure Factura1Click(Sender: TObject);
    procedure Proveedor1Click(Sender: TObject);
    procedure Mantenimiento1Click(Sender: TObject);
    procedure raslado1Click(Sender: TObject);
    procedure Mejoras1Click(Sender: TObject);
    procedure ConfigurarImpresora1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure SalidadeActivos1Click(Sender: TObject);
    procedure ActualizarPolizas1Click(Sender: TObject);
    procedure DevoluciondeActivos1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure DepreciacionActual1Click(Sender: TObject);
    procedure Depreciaciones1Click(Sender: TObject);
    procedure DigitarComprobante1Click(Sender: TObject);
    procedure Acta1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure Activo2Click(Sender: TObject);
    procedure Polizas1Click(Sender: TObject);
    procedure CancelarPolizas1Click(Sender: TObject);
    procedure Articulo4Click(Sender: TObject);
    procedure Entradas2Click(Sender: TObject);
    procedure Empleados1Click(Sender: TObject);
    procedure SalidadeActivos2Click(Sender: TObject);
    procedure Proveedores1Click(Sender: TObject);
    procedure Salir2Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ActivosDepreciados1Click(Sender: TObject);
    procedure M1Click(Sender: TObject);
    procedure Seccion1Click(Sender: TObject);
    procedure Sucursal1Click(Sender: TObject);
    procedure Elementos1Click(Sender: TObject);
    procedure AbrirReporte1Click(Sender: TObject);
    procedure Empleado1Click(Sender: TObject);
    procedure General1Click(Sender: TObject);
    procedure Empleado2Click(Sender: TObject);
    procedure Seccion2Click(Sender: TObject);
    procedure ActualizarActivo1Click(Sender: TObject);
    procedure ActivosnoEntregados1Click(Sender: TObject);
    procedure Activo3Click(Sender: TObject);
    procedure Elemento1Click(Sender: TObject);
    procedure Componentes1Click(Sender: TObject);
    procedure Entrega2Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure rslados1Click(Sender: TObject);
    procedure ActualizarContrasea1Click(Sender: TObject);
    procedure ADadosdeBaja1Click(Sender: TObject);
    procedure ActualizarPlaca1Click(Sender: TObject);
    procedure CalcularDepreciacin1Click(Sender: TObject);
    procedure OtrosActivos1Click(Sender: TObject);
    procedure ipo1Click(Sender: TObject);
    procedure Sucursal2Click(Sender: TObject);
    procedure Reportes1Click(Sender: TObject);
    procedure Actualizar1Click(Sender: TObject);
    procedure Consultas1Click(Sender: TObject);
    procedure Depreciacion1Click(Sender: TObject);
    procedure Captura1Click(Sender: TObject);
    procedure rrClick(Sender: TObject);
    procedure DepreciacionNormal1Click(Sender: TObject);
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
    fecha: string;
    opcion: Integer;
    wpath : string;
    entrada : Boolean;
    validarep: Integer;
    seccion : Integer;
  published
    procedure actualiza;

    { Public declarations }
  end;
var
  FrMain: TFrMain;

implementation
uses unitlogin,unitdatamodulo, UnitActivoreal,unitentrega,
  UnitFactura, UnitTraslado, UnitProveedores, UnitMantenimiento,
  UnitTrasladoreal, UnitMejora, UnitSalida, UnitActualiza, UnitDvolucion,
  UnitActivorep, UnitReporte, UnitDepreciacion,
  Unitdecomprobante,unitdata, UnitDatosactivo, UnitReppoliza, UnitCancela,
  UnitconMantenimiento, UnitRepSeccion, UnitGeneral, UnitElementos,
  UnitImpresion, Unitcomponentes, UnitReportetraslado,
  UnitCambiarContrasena, Unitcambioplaca, Unitbuscaactivos, UnitCalculo,
  UnitOtroActivo, UnitClase;


{$R *.dfm}

procedure TFrMain.FormCreate(Sender: TObject);
var Login: TLogin;
    Veces: SmallInt;
    Mensaje,a: string;
    validahora,hora: Integer;
begin
  ShortDateFormat := 'yyyy/mm/dd';
  a := DateToStr(Date);
  wpath := ExtractFilePath(ParamStr(0));
  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(MiINI) do
  try
    DBserver := ReadString('DBNAME','server','192.168.1.8');
    DBserver1 := ReadString('DBNAME1','server','192.168.1.8');// BASE COOPSERVIR
    DBPath := ReadString('DBNAME','path','/base/');
    DBPath1 := ReadString('DBNAME1','path','/base/');// BASE COOPSERVIR
    DBname := ReadString('DBNAME','name','inventario.gdb');
    DBname1 := ReadString('DBNAME1','name','coopservir.gdb');// BASE COOPSERVIR
    Empresa := ReadString('EMPRESA','name','COOPSERVIR LTDA');
    Nit     := ReadString('EMPRESA','nit','890.505.363-6');
    Agencia := ReadInteger('EMPRESA','Agencia',1);
    Ciudad  := ReadString('EMPRESA','city','OCAÑA N.S.');
  finally
    free;
  end;
  try
  IDserver.Host := DBserver;
  hora := 700;
  validahora := StrToInt(FormatDateTime('Hnn',IDserver.DateTime));
  Self.Caption := Self.Caption + ' ' + DBserver;
  if validahora > hora then
  begin
        Veces := 0;
        Login := Tlogin.Create(Self);
        datageneral := tdatageneral.Create(self);
        frmdata := Tfrmdata.Create(self);
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
                DBAlias := LowerCase(Usuario.Text);
                DBPasabordo := LowerCase(password.Text);
                datageneral.IBDatabase1.DataBaseName := DBserver + ':' + DBpath + DBname;
                datageneral.IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
                datageneral.IBDatabase1.Params.Values['User_Name'] := DBAlias;
                datageneral.IBDatabase1.Params.Values['PassWord'] := DBPasabordo;
//                datageneral.IBDatabase1.Params.Values['sql_role_name'] := 'ACTIVOS';
                frmdata.IBDatabase2.DataBaseName := DBserver1 + ':' + DBpath1 + DBname1;
                frmdata.IBDatabase2.Params.Values['lc_ctype'] := 'ISO8859_1';
                frmdata.IBDatabase2.Params.Values['User_Name'] := DBAlias;
                frmdata.IBDatabase2.Params.Values['PassWord'] := DBPasabordo;
                frmdata.IBDatabase2.Params.Values['sql_role_name'] := 'AUXILIAR';
                Veces := Veces + 1;
                try
                  DataGeneral.IBDatabase1.Connected := True;
                  DataGeneral.IBTransaction1.Active := True;
                  frmdata.IBDatabase2.Connected := True;
                  frmdata.IBTransaction2.Active := True;
                  fecha:=DateTimeToStr(date);
                  opcion := StrToInt(FormatDateTime('dd',date));
                if (0 >= opcion) then
                begin
                  DepreciacionActual1.Enabled := false;
                  ToolButton5.Enabled := False;
                  Empleados1.Enabled := False;
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
          MessageDlg('El Servidor se Encuentra Fuera de Servicio. Informe al Administrador de la Red',mtInformation,[mbOK],0);
          salirmal := true;
          Application.Terminate;
        end;
        end;
end;

procedure TFrMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        if Not SalirMal then
        if MessageDlg('Cerrar Sistema de Control de Activos de CREDISERVIR LTDA.',mtInformation,[mbYes,mbNo],0) = mrYes Then
         with TIniFile.Create(MiINI) do
          try
         {   WriteString('DBNAME','server',DBserver);
            WriteString('DBNAME1','server',DBserver1);// BASE COOPSERVIR
            WriteString('DBNAME','path',DBpath);
            WriteString('DBNAME1','path',DBpath1);// BASSE COOPSERVIR
            WriteString('DBNAME','name',DBname);
            WriteString('DBNAME1','name',DBname1);// BASE COOPSERVIR
            WriteString('EMPRESA','name',Empresa);
            WriteString('EMPRESA','nit',Nit);
            WriteInteger('EMPRESA','Agencia',Agencia);
            WriteString('EMPRESA','city',Ciudad);}
          finally
           begin
            dataGeneral.IBDatabase1.Connected := False;
            dataGeneral.IBTransaction1.Active  := False;
            frmdata.IBDatabase2.Connected := False;
            frmdata.IBTransaction2.Active := False;
            frmdata.Free;
            dataGeneral.Free;
            Action := caFree;
           end;
          end
        else
            Action := caNone
       else
         begin
            dataGeneral.Free;
            Action := caFree;
         end;
end;
procedure TFrMain.Activo1Click(Sender: TObject);
begin
        frmactivoreal := TFrmActivoreal.Create(self);
        frmactivoreal.control_actualiza := 0;
        frmactivoreal.ShowModal;
end;

procedure TFrMain.Entrega1Click(Sender: TObject);
begin
        FrmEntrega := TFrmEntrega.Create(self);
        FrmEntrega.ShowModal;
end;

procedure TFrMain.Factura1Click(Sender: TObject);
begin
        frmfact := tFrmFact.Create(Self);
        frmfact.ShowModal;
end;

procedure TFrMain.Proveedor1Click(Sender: TObject);
begin
        frmproveedor := TFrmProveedor.Create(self);
        FrmProveedor.ShowModal;
end;

procedure TFrMain.Mantenimiento1Click(Sender: TObject);
begin
        FrmMantenimiento := TFrmMantenimiento.Create(self);
        FrmMantenimiento.ShowModal;
end;

procedure TFrMain.raslado1Click(Sender: TObject);
begin
        FrmTraslado := TFrmTraslado.Create(self);
        FrmTraslado.ShowModal;
end;

procedure TFrMain.Mejoras1Click(Sender: TObject);
begin
        FrmMejora := TFrmMejora.Create(self);
        FrmMejora.ShowModal;
end;

procedure TFrMain.ConfigurarImpresora1Click(Sender: TObject);
begin
        PrinterSetupDialog.Execute;
end;

procedure TFrMain.Salir1Click(Sender: TObject);
begin
        Self.Close;
end;

procedure TFrMain.SalidadeActivos1Click(Sender: TObject);
begin
        FrmSalida := TFrmSalida.Create(self);
        FrmSalida.ShowModal;
end;

procedure TFrMain.ActualizarPolizas1Click(Sender: TObject);
begin
        Frmactualiza := TFrmactualiza.Create(self);
        Frmactualiza.ShowModal;
end;

procedure TFrMain.DevoluciondeActivos1Click(Sender: TObject);
begin
        FrmDevolucion := TFrmDevolucion.Create(self);
        FrmDevolucion.ShowModal;
end;

procedure TFrMain.ToolButton1Click(Sender: TObject);
begin
        FrmActivos := TFrmActivos.Create(self);
        FrmActivos.ShowModal;
end;

procedure TFrMain.actualiza;
begin
end;

procedure TFrMain.DepreciacionActual1Click(Sender: TObject);
var control_fecha,control_actual,fecha_control:string;
begin
//        FrmComprobantes := TFrmComprobantes.Create(self);
        FrmDepreciacion := TFrmDepreciacion.Create(self);
        with DataGeneral.IBsel3 do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('select max("act$controldepreciacion"."fecha") as control from "act$controldepreciacion"');
          open;
          fecha_control := FieldByName('control').AsString;
          Close;
          Transaction.Commit;
        end;
        if fecha_control = '' then
          fecha_control := '12/06/1977';// fecha
          control_fecha := FormatDateTime('mm/yy',StrToDateTime(fecha_control));
          control_actual := FormatDateTime('mm/yy',Date);
        if control_fecha = control_actual then
        begin
          FrmDepreciacion.Bejecutar.Enabled := False;
          FrmDepreciacion.Label2.Caption := 'Seleccione Oficina';
          FrmDepreciacion.cbagencia.Visible := True;
        end;
          FrmDepreciacion.Fecha_rep.Visible := False;

          validarep := 1;
          fecha := DateTimeToStr(date);
          opcion := StrToInt(FormatDateTime('dd',strtodatetime(fecha)));
        if (opcion >= 1) then
        begin
          frmdepreciacion.Label3.Visible := True;
          FrmDepreciacion.ShowModal;
        end
        else
          MessageDlg('La depreciación Solo se Realiza Entre los dias 25 y 31 de cada mes',mtInformation,[mbOK],0);
end;

procedure TFrMain.Depreciaciones1Click(Sender: TObject);
begin
        validarep := 2;
        FrmDepreciacion := TFrmDepreciacion.Create(self);
        FrmDepreciacion.Breporte.Left := 144;
        //FrmDepreciacion.BitBtn1.Visible := True;
        FrmDepreciacion.Bejecutar.Visible := False;
        FrmDepreciacion.Btncomprobante.Visible := False;
        FrmDepreciacion.Label2.Left := 30;
        FrmDepreciacion.Fecha_rep.Left := 70;
        FrmDepreciacion.Label3.Visible := False;
        FrmDepreciacion.Breporte.Caption := '&Ejecutar Reporte';
        FrmDepreciacion.Fecha_rep.Visible := True;
        FrmDepreciacion.Height := 147;
        FrmDepreciacion.Breporte.Visible := True;
        FrmDepreciacion.Btraslado.Visible := False;
        FrmDepreciacion.ejecutacomp.Visible := False;
        FrmDepreciacion.Label2.Caption := 'Fecha';
        FrmDepreciacion.oficinas.Visible := True;
        FrmDepreciacion.cbagencia.Visible := True;
        FrmDepreciacion.cbagencia.Left := 276;
        FrmDepreciacion.detalle.Visible := False;
        FrmDepreciacion.ShowModal;
end;

procedure TFrMain.DigitarComprobante1Click(Sender: TObject);
begin
//        FrmComprobantes := TFrmComprobantes.Create(self);
//        FrmComprobantes.ShowModal;
end;

procedure TFrMain.Acta1Click(Sender: TObject);
begin
        FrmActivos := TFrmActivos.Create(self);
        FrmActivos.repactivos;
        FrmReporte.Free;
end;

procedure TFrMain.ToolButton2Click(Sender: TObject);
begin
        Activo1Click(Self);
end;

procedure TFrMain.ToolButton3Click(Sender: TObject);
begin
        Entrega1Click(Self);
end;

procedure TFrMain.ToolButton5Click(Sender: TObject);
begin
        DepreciacionActual1Click(Self);
end;

procedure TFrMain.ToolButton7Click(Sender: TObject);
begin
        SalidadeActivos1Click(Self);
end;

procedure TFrMain.ToolButton9Click(Sender: TObject);
begin
        DigitarComprobante1Click(Self);
end;

procedure TFrMain.Activo2Click(Sender: TObject);
begin
        FrmdatoActivo := TFrmdatoActivo.Create(self);
        FrmdatoActivo.ShowModal;
end;

procedure TFrMain.Polizas1Click(Sender: TObject);
begin
        FrmReportepol := TFrmReportepol.Create(self);
        FrmReportepol.ShowModal;
        if FrmReportepol.reporte then
           FrmReporte.Free;
end;

procedure TFrMain.CancelarPolizas1Click(Sender: TObject);
begin
        FrmCancela := TFrmCancela.Create(self);
        FrmCancela.ShowModal;
end;

procedure TFrMain.Articulo4Click(Sender: TObject);
begin
        ToolButton2Click(Self);
end;

procedure TFrMain.Entradas2Click(Sender: TObject);
begin
        ToolButton3Click(Self);
end;

procedure TFrMain.Empleados1Click(Sender: TObject);
begin
        ToolButton5Click(Self);
end;

procedure TFrMain.SalidadeActivos2Click(Sender: TObject);
begin
        ToolButton7Click(Self);
end;

procedure TFrMain.Proveedores1Click(Sender: TObject);
begin
        ToolButton9Click(Self);
end;

procedure TFrMain.Salir2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrMain.ToolButton10Click(Sender: TObject);
begin
        Self.Close;
end;

procedure TFrMain.ActivosDepreciados1Click(Sender: TObject);
begin
        FrmActivos := TFrmActivos.Create(self);
        FrmActivos.totaldepreciado;
        FrmReporte.Free;
end;

procedure TFrMain.M1Click(Sender: TObject);
begin
        FrmcosultaMant := TFrmcosultaMant.Create(self);
        FrmcosultaMant.ShowModal;
        FrmReporte.Free;
end;

procedure TFrMain.Seccion1Click(Sender: TObject);
begin
        FrmReporteseccion := TFrmReporteseccion.Create(self);
        FrmActivos := TFrmActivos.Create(self);
        FrmReporteseccion.seccion.Visible := True;
        seccion := 1;// ejecuta consulta por seccion
        FrmReporteseccion.ShowModal;
end;

procedure TFrMain.Sucursal1Click(Sender: TObject);
begin
        FrmReporteseccion := tFrmReporteseccion.Create(self);
        FrmReporteseccion.Label1.Caption := 'Sucursal';
        FrmActivos := TFrmActivos.Create(self);
        FrmReporteseccion.Sucursal.Visible := True;
        frmgeneral.IbAgencia.Active := True;
        frmgeneral.IbAgencia.Last;
        seccion := 2;// Ejecuta Consulta por sucursal
        FrmReporteseccion.ShowModal;
end;

procedure TFrMain.Elementos1Click(Sender: TObject);
begin
        FrmElementos := TFrmElementos.Create(self);
        FrmElementos.ShowModal;
end;
procedure TFrMain.AbrirReporte1Click(Sender: TObject);
begin
        FrmActivos := TFrmActivos.Create(self);
        FrmActivos.repblanco;
        FrmReporte.Free;
end;

procedure TFrMain.Empleado1Click(Sender: TObject);
begin
        FrmReporteseccion := tFrmReporteseccion.Create(self);
        FrmActivos := TFrmActivos.Create(self);
        seccion := 3;
        FrmReporteseccion.Label1.Visible := False;
        FrmReporteseccion.Label2.Visible := True;
        FrmReporteseccion.empleado.Visible := True;
        FrmReporteseccion.ShowModal;
end;

procedure TFrMain.General1Click(Sender: TObject);
begin
        FrmActivos:=TFrmActivos.Create(self);
        FrmActivos.elementos;
        FrmReporte.Free;
end;

procedure TFrMain.Empleado2Click(Sender: TObject);
begin
        FrmReporteseccion := TFrmReporteseccion.Create(self);
        FrmActivos := TFrmActivos.Create(self);
        seccion := 4;
        FrmReporteseccion.Label1.Visible := False;
        FrmReporteseccion.label2.Visible := True;
        FrmReporteseccion.empleado.Visible := True;
        FrmReporteseccion.ShowModal;
end;

procedure TFrMain.Seccion2Click(Sender: TObject);
begin
        FrmReporteseccion := TFrmReporteseccion.Create(self);
        FrmActivos := TFrmActivos.Create(self);
        FrmReporteseccion.seccion.Visible := True;
        seccion := 5;// ejecuta consulta por seccion
        FrmReporteseccion.ShowModal;
end;

procedure TFrMain.ActualizarActivo1Click(Sender: TObject);
begin
        FrmActivoreal:=TFrmActivoreal.Create(self);
        frmactivoreal.control_actualiza := 1;
        frmactivoreal.aceptar.Caption := '&Actualizar';
        frmactivoreal.ShowModal;
end;

procedure TFrMain.ActivosnoEntregados1Click(Sender: TObject);
begin
        FrmActivos:=TFrmActivos.Create(self);
        FrmActivos.actno;
end;

procedure TFrMain.Activo3Click(Sender: TObject);
var     oficina,oficina2,oficina3,oficina4,oficina5:string;
begin
        IBplaca.Close;
        IBplaca.ParamByName('placa').AsInteger := 1;
        IBplaca.ParamByName('placa1').AsString := '01%';
        IBplaca.Open;
        oficina := IBplaca.FieldByName('ultimo').AsString;
        IBplaca.Close;
        IBplaca.ParamByName('placa').AsInteger := 1;
        IBplaca.ParamByName('placa1').AsString := '02%';
        IBplaca.Open;
        oficina2 := IBplaca.FieldByName('ultimo').AsString;
        IBplaca.Close;
        IBplaca.ParamByName('placa').AsInteger := 1;
        IBplaca.ParamByName('placa1').AsString := '03%';
        IBplaca.Open;
        oficina3 := IBplaca.FieldByName('ultimo').AsString;
        IBplaca.Close;
        IBplaca.ParamByName('placa').AsInteger := 1;
        IBplaca.ParamByName('placa1').AsString := '04%';
        IBplaca.Open;
        oficina4 := IBplaca.FieldByName('ultimo').AsString;
        IBplaca.Close;
        IBplaca.Close;
        IBplaca.ParamByName('placa').AsInteger := 1;
        IBplaca.ParamByName('placa1').AsString := '05%';
        IBplaca.Open;
        oficina5 := IBplaca.FieldByName('ultimo').AsString;
        MessageDlg('Ultimo No. de Placa en la Oficina Ocaña: '+oficina + #13+'Ultimo No. de Placa en la Oficina Abrego: '+oficina2 + #13+'Ultimo No. de Placa en la Oficina Convencion: '+oficina3 + #13+'Ultimo No. de Placa en la Oficina Aguachica: '+oficina4+#13+'Ultimo No. de Placa en la Oficina Santa Clara: '+oficina5,mtInformation,[mbOK],0);
        IBplaca.Close;
end;

procedure TFrMain.Elemento1Click(Sender: TObject);
var     oficina,oficina2,oficina3,oficina4,oficina5:string;
begin
        IBplaca.Close;
        IBplaca.ParamByName('placa').AsInteger := 0;
        IBplaca.ParamByName('placa1').AsString := 'NA-01%';
        IBplaca.Open;
        oficina := IBplaca.FieldByName('ultimo').AsString;
        IBplaca.Close;
        IBplaca.ParamByName('placa').AsInteger := 0;
        IBplaca.ParamByName('placa1').AsString := 'NA-02%';
        IBplaca.Open;
        oficina2 := IBplaca.FieldByName('ultimo').AsString;
        IBplaca.Close;
        IBplaca.ParamByName('placa').AsInteger := 0;
        IBplaca.ParamByName('placa1').AsString := 'NA-03%';
        IBplaca.Open;
        oficina3 := IBplaca.FieldByName('ultimo').AsString;
        IBplaca.Close;
        IBplaca.ParamByName('placa').AsInteger := 0;
        IBplaca.ParamByName('placa1').AsString := 'NA-04%';
        IBplaca.Open;
        oficina4 := IBplaca.FieldByName('ultimo').AsString;
        IBplaca.Close;
        IBplaca.ParamByName('placa').AsInteger := 0;
        IBplaca.ParamByName('placa1').AsString := 'NA-05%';
        IBplaca.Open;
        oficina5 := IBplaca.FieldByName('ultimo').AsString;
        IBplaca.Close;
        MessageDlg('Ultimo No. de Placa en la Oficina Ocaña: '+oficina + #13+'Ultimo No. de Placa en la Oficina Abrego: '+oficina2 + #13+'Ultimo No. de Placa en la Oficina Convencion: '+oficina3+ #13+'Ultimo No. de Placa en la Oficina Aguachica: '+oficina4 + #13+'Ultimo No. de Placa en la Oficina Santa Clara: '+oficina5,mtInformation,[mbOK],0);
        IBplaca.Close;
end;

procedure TFrMain.Componentes1Click(Sender: TObject);
begin
        FrmConcomponente := TFrmConcomponente.Create(self);
        frmgeneral := Tfrmgeneral.Create(self);
        FrmConcomponente.ShowModal;
end;

procedure TFrMain.Entrega2Click(Sender: TObject);
begin
        FrmReporteseccion := tFrmReporteseccion.Create(self);
        FrmActivos := TFrmActivos.Create(self);
        seccion := 6;
        FrmReporteseccion.Label1.Visible := False;
        FrmReporteseccion.Label2.Visible := True;
        FrmReporteseccion.empleado.Visible := True;
        FrmReporteseccion.ShowModal;
end;

procedure TFrMain.ToolButton12Click(Sender: TObject);
begin
//        FrmActivos := tFrmActivos.Create(self);
//        FrmActivos.ShowModal;

end;

procedure TFrMain.rslados1Click(Sender: TObject);
begin
        FrmReptraslado := TFrmReptraslado.Create(self);
        FrmReptraslado.ShowModal;
end;

procedure TFrMain.ActualizarContrasea1Click(Sender: TObject);
begin
        frmCambiarContrasena := TfrmCambiarContrasena.Create(self);
        frmCambiarContrasena.ShowModal;
end;

procedure TFrMain.ADadosdeBaja1Click(Sender: TObject);
begin
        FrmBusca := TFrmBusca.Create(self);
        FrmBusca.ShowModal;
end;

procedure TFrMain.ActualizarPlaca1Click(Sender: TObject);
begin
        frmcambioplaca := Tfrmcambioplaca.Create(self);
        frmcambioplaca.ShowModal;
end;

procedure TFrMain.CalcularDepreciacin1Click(Sender: TObject);
begin
        FrmCalculo := TFrmCalculo.Create(self);
        FrmCalculo.ShowModal
end;

procedure TFrMain.OtrosActivos1Click(Sender: TObject);
begin
        FrmOtroActivo := TFrmOtroActivo.Create(self);
        FrmOtroActivo.ShowModal
end;

procedure TFrMain.ipo1Click(Sender: TObject);
begin
        FrmClase := TFrmClase.Create(self);
        FrmClase.ShowModal
end;

procedure TFrMain.Sucursal2Click(Sender: TObject);
begin
        FrmReporteseccion := tFrmReporteseccion.Create(self);
        FrmReporteseccion.Label1.Caption := 'Sucursal';
        FrmActivos := TFrmActivos.Create(self);
        FrmReporteseccion.Sucursal.Visible := True;
        frmgeneral.IbAgencia.Active := True;
        frmgeneral.IbAgencia.Last;
        seccion:=16;// Ejecuta Consulta por sucursal
        FrmReporteseccion.ShowModal;

end;

procedure TFrMain.Reportes1Click(Sender: TObject);
begin
        if DataGeneral.IBTransaction1.InTransaction then
           DataGeneral.IBTransaction1.Commit;
        DataGeneral.IBTransaction1.StartTransaction;
end;

procedure TFrMain.Actualizar1Click(Sender: TObject);
begin
        if DataGeneral.IBTransaction1.InTransaction then
           DataGeneral.IBTransaction1.Commit;
        DataGeneral.IBTransaction1.StartTransaction;

end;

procedure TFrMain.Consultas1Click(Sender: TObject);
begin
        if DataGeneral.IBTransaction1.InTransaction then
           DataGeneral.IBTransaction1.Commit;
        DataGeneral.IBTransaction1.StartTransaction;

end;

procedure TFrMain.Depreciacion1Click(Sender: TObject);
begin
        if DataGeneral.IBTransaction1.InTransaction then
           DataGeneral.IBTransaction1.Commit;
        DataGeneral.IBTransaction1.StartTransaction;

end;

procedure TFrMain.Captura1Click(Sender: TObject);
begin
        if DataGeneral.IBTransaction1.InTransaction then
           DataGeneral.IBTransaction1.Commit;
        DataGeneral.IBTransaction1.StartTransaction;

end;

procedure TFrMain.rrClick(Sender: TObject);
begin
        if DataGeneral.IBTransaction1.InTransaction then
           DataGeneral.IBTransaction1.Commit;
        DataGeneral.IBTransaction1.StartTransaction;

end;

procedure TFrMain.DepreciacionNormal1Click(Sender: TObject);
begin
//        FrmDepreciacionAct := TFrmDepreciacionAct.Create(Self);
//        FrmDepreciacionact.ShowModal
end;

end.

