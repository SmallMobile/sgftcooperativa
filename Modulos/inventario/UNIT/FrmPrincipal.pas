unit FRMPRINCIPAL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls, ImgList, ToolWin, jpeg, ExtCtrls;

type
  TFrMain = class(TForm)
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    Articulo1: TMenuItem;
    Articulo2: TMenuItem;
    Dependencia1: TMenuItem;
    Clasificacion1: TMenuItem;
    Registro1: TMenuItem;
    Entrada1: TMenuItem;
    Salida1: TMenuItem;
    Proveedor1: TMenuItem;
    Exixtencias1: TMenuItem;
    Empleado1: TMenuItem;
    Existencias1: TMenuItem;
    Mantenimiento1: TMenuItem;
    EliminarEntrada1: TMenuItem;
    EliminarSalida1: TMenuItem;
    SalidasPorFecha1: TMenuItem;
    Reportes1: TMenuItem;
    ExistenciaArticulos1: TMenuItem;
    ReporteProveedores1: TMenuItem;
    Actualizar1: TMenuItem;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    GastosSeccion1: TMenuItem;
    ConsultarSalidas1: TMenuItem;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    Entradas1: TMenuItem;
    GastosSucursal1: TMenuItem;
    Salidas1: TMenuItem;
    Sucursal1: TMenuItem;
    consumo1: TMenuItem;
    Consumo2: TMenuItem;
    Empleado2: TMenuItem;
    Seccion1: TMenuItem;
    Sucursal2: TMenuItem;
    rr: TMenuItem;
    Articulo3: TMenuItem;
    Detalle1: TMenuItem;
    ConfigurarImpresora1: TMenuItem;
    PrinterSetupDialog: TPrinterSetupDialog;
    StockMinimo1: TMenuItem;
    General1: TMenuItem;
    GastosEmpleado1: TMenuItem;
    General2: TMenuItem;
    Objetiva1: TMenuItem;
    GastosEmpleado2: TMenuItem;
    GastosSucursal2: TMenuItem;
    GastosSeccion2: TMenuItem;
    GastosGenerales2: TMenuItem;
    Sto1: TMenuItem;
    Relativa1: TMenuItem;
    Salir1: TMenuItem;
    menu: TPopupMenu;
    Articulo4: TMenuItem;
    Proveedores1: TMenuItem;
    Empleados1: TMenuItem;
    Entradas2: TMenuItem;
    Salidas2: TMenuItem;
    Salir2: TMenuItem;
    Existencias2: TMenuItem;
    ReporteGastoDiario1: TMenuItem;
    Informacin1: TMenuItem;
    Image1: TImage;
    Valoracin1: TMenuItem;
    Valoracion1: TMenuItem;
    General3: TMenuItem;
    Suministros1: TMenuItem;
    Papeleria1: TMenuItem;
    Consumo3: TMenuItem;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ReclasificacionArticulos1: TMenuItem;
    ConsumoConsolidado1: TMenuItem;
    Gestiones1: TMenuItem;
    RequeimientoSistemas1: TMenuItem;
    procedure Entrada1Click(Sender: TObject);
    procedure Salida1Click(Sender: TObject);
    procedure Articulo1Click(Sender: TObject);
    procedure Articulo2Click(Sender: TObject);
    procedure Dependencia1Click(Sender: TObject);
    procedure Clasificacion1Click(Sender: TObject);
    procedure Proveedor1Click(Sender: TObject);
    procedure Empleado1Click(Sender: TObject);
    procedure EliminarEntrada1Click(Sender: TObject);
    procedure EliminarSalida1Click(Sender: TObject);
    procedure SalidasPorFecha1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExistenciaArticulos1Click(Sender: TObject);
    procedure ReporteProveedores1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure GastosSeccion1Click(Sender: TObject);
    procedure Actualizar1Click(Sender: TObject);
    procedure ConsultarSalidas1Click(Sender: TObject);
    procedure Existencias1Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure Entradas1Click(Sender: TObject);
    procedure GastosSucursal1Click(Sender: TObject);
    procedure Salidas1Click(Sender: TObject);
    procedure Sucursal1Click(Sender: TObject);
    procedure rr1Click(Sender: TObject);
    procedure Seccion1Click(Sender: TObject);
    procedure Empleado2Click(Sender: TObject);
    procedure Sucursal2Click(Sender: TObject);
    procedure rrClick(Sender: TObject);
    procedure ConfigurarImpresora1Click(Sender: TObject);
    procedure StockMinimo1Click(Sender: TObject);
    procedure Detalle1Click(Sender: TObject);
    procedure General1Click(Sender: TObject);
    procedure GastosEmpleado1Click(Sender: TObject);
    procedure GastosEmpleado2Click(Sender: TObject);
    procedure Sto1Click(Sender: TObject);
    procedure GastosSeccion2Click(Sender: TObject);
    procedure GastosGenerales2Click(Sender: TObject);
    procedure GastosSucursal2Click(Sender: TObject);
    procedure Relativa1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure Articulo4Click(Sender: TObject);
    procedure Empleados1Click(Sender: TObject);
    procedure Proveedores1Click(Sender: TObject);
    procedure Entradas2Click(Sender: TObject);
    procedure Salidas2Click(Sender: TObject);
    procedure Salir2Click(Sender: TObject);
    procedure Existencias2Click(Sender: TObject);
    procedure ReporteGastoDiario1Click(Sender: TObject);
    procedure Informacin1Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure Valoracion1Click(Sender: TObject);
    procedure General3Click(Sender: TObject);
    procedure Suministros1Click(Sender: TObject);
    procedure Papeleria1Click(Sender: TObject);
    procedure Consumo3Click(Sender: TObject);
    procedure ReclasificacionArticulos1Click(Sender: TObject);
    procedure ConsumoConsolidado1Click(Sender: TObject);
  private
    { Private declarations }
    salirmal: boolean;
    MiINI: string;
    DBserver: string;
    DBPath: string;
    DBname: string;
    Empresa: string;
    Nit: string;
    Agencia: integer;
    Ciudad: string;
    Dbalias: string;
    DBPasabordo: string;

  public
  wpath : string;
  entrada : Boolean;
  published
    procedure actualizar;
    { Public declarations }
  end;
var
  FrMain: TFrMain;

implementation
uses frmentradadatos,frmrepentrada,frmagencia,frmexistencia,frmentradafecha,inifiles,frmlogin,frmrepperiodico,frmreportesgenerales,frmdatamodulo,frmsalidafecha,frmelisalida,frmmantenimiento,frmbuscaempleado,frmsalida,frmempleados,frmarticulo,frmclasificacio,frmdependencia,frmproveedores,
  frmrepempleado, frmstockminimo, UnitReclasifica, UnitRepConsolidado;
//var     datageneral:tdatageneral;

{$R *.dfm}

procedure TFrMain.Entrada1Click(Sender: TObject);
begin
        entrada_articulo := tentrada_articulo.Create(self);
        entrada_articulo.ShowModal;
end;

procedure TFrMain.Salida1Click(Sender: TObject);
begin
        salida := tsalida.Create(self);
        salida.ShowModal;
end;

procedure TFrMain.Articulo1Click(Sender: TObject);
begin
        empleado := Templeado.Create(self);
        empleado.ShowModal;
end;

procedure TFrMain.Articulo2Click(Sender: TObject);
begin
        articulo := TArticulo.Create(self);
        articulo.ShowModal;
end;

procedure TFrMain.Dependencia1Click(Sender: TObject);
begin
        dependencia := Tdependencia.Create(self);
        dependencia.ShowModal;
end;

procedure TFrMain.Clasificacion1Click(Sender: TObject);
begin
        frmclasificacion := Tfrmclasificacion.Create(self);
        frmclasificacion.ShowModal;
end;

procedure TFrMain.Proveedor1Click(Sender: TObject);
begin
        proveedor := TProveedor.Create(self);
        proveedor.ShowModal;
end;

procedure TFrMain.Empleado1Click(Sender: TObject);
begin
        actualizar;
        Buscaempleado := TBuscaempleado.Create(self);
        Buscaempleado.ShowModal;
end;

procedure TFrMain.EliminarEntrada1Click(Sender: TObject);
begin
        mantenimiento := TMantenimiento.Create(self);
        mantenimiento.ShowModal;

end;
procedure TFrMain.EliminarSalida1Click(Sender: TObject);
begin

        eliminarsalida := Teliminarsalida.Create(self);
        eliminarsalida.ShowModal;
end;

procedure TFrMain.SalidasPorFecha1Click(Sender: TObject);
begin
        salidaporfecha := Tsalidaporfecha.Create(self);
        salidaporfecha.ShowModal;
end;

procedure TFrMain.FormCreate(Sender: TObject);
var Login:TLogin;
    Veces :SmallInt;
    Mensaje :string;
begin
  wpath:=ExtractFilePath(ParamStr(0));
  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  ShortDateFormat := 'yyyy/mm/dd';
  with TIniFile.Create(MiINI) do
  try
    DBserver := ReadString('DBNAME','server','192.168.1.8');
    DBPath := ReadString('DBNAME','path','/base/');
    DBname := ReadString('DBNAME','name','inventario.gdb');
    Empresa := ReadString('EMPRESA','name','COOPSERVIR LTDA');
    Nit     := ReadString('EMPRESA','nit','890.505.363-6');
    Agencia := ReadInteger('EMPRESA','Agencia',1);
    Ciudad  := ReadString('EMPRESA','city','OCAÑA N.S.');
  finally
    Free;
  end;
        Veces := 0;
        FrMain.Caption := 'Sistema de Inventarios de Crediservir Ltda. ' + DBserver;
        Login := Tlogin.Create(Self);
        DataGeneral := TDataGeneral.Create(Self);
        DataGeneral.IBDatabase1.Connected := false;
         while Not DataGeneral.IBDatabase1.Connected do
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
                DBPasabordo:= LowerCase(password.Text);
                DataGeneral.IBDatabase1.DataBaseName := DBserver + ':' + DBpath + DBname;
                DataGeneral.IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
                DataGeneral.IBDatabase1.Params.Values['User_Name'] := DBAlias;
                DataGeneral.IBDatabase1.Params.Values['PassWord'] := DBPasabordo;
                DataGeneral.IBDatabase1.Params.Values['sql_role_name'] := 'INVENTARIO';
                Veces := Veces + 1;
                 try
                DataGeneral.IBDatabase1.Connected:=True;
                DataGeneral.IBTransaction1.Active:=True;
                except
                        on E: Exception do
                        begin
                          if StrLIComp(PChar(E.Message),PChar('Your user name'),14) = 0 then
                           begin
                            Mensaje :='Verifique su Nombre y su Contraseña' + #10 + #13; // + 'Mensaje:' + E.Message;
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
end;

procedure TFrMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        if Not SalirMal then
        if MessageDlg('Seguro que desea cerrar Sistema de Inventario de CREDISERVIR LTDA',mtCustom,[mbYes,mbNo],0) = mrYes Then
        { with TIniFile.Create(MiINI) do
          try
            WriteString('DBNAME','server',DBserver);
            WriteString('DBNAME','path',DBpath);
            WriteString('DBNAME','name',DBname);
            WriteString('EMPRESA','name',Empresa);
            WriteString('EMPRESA','nit',Nit);
            WriteInteger('EMPRESA','Agencia',Agencia);
            WriteString('EMPRESA','city',Ciudad);
          finally}
           begin
            DataGeneral.IBDatabase1.Connected := False;
            DataGeneral.IBTransaction1.Active  := False;
            dataGeneraL.Free;
            Action:= caFree;
          end
        else
            Action := caNone
       else
         begin
            dataGeneral.Free;
            Action := caFree;
         end;
end;
procedure TFrMain.ExistenciaArticulos1Click(Sender: TObject);
begin
        reportes := Treportes.Create(Self);
        reportes.reporte_articulo;
end;

procedure TFrMain.ReporteProveedores1Click(Sender: TObject);
begin
        reportes := treportes.Create(Self);
        reportes.reporte_proveedor;
end;

procedure TFrMain.actualizar;
begin
end;

procedure TFrMain.ToolButton1Click(Sender: TObject);
begin
        articulo:=TArticulo.Create(Self);
        articulo.ShowModal;
end;

procedure TFrMain.ToolButton3Click(Sender: TObject);
begin
        proveedor := TProveedor.Create(self);
        proveedor.ShowModal;
end;

procedure TFrMain.ToolButton7Click(Sender: TObject);
begin
        salida := TSalida.Create(self);
        salida.ShowModal;
end;

procedure TFrMain.ToolButton4Click(Sender: TObject);
begin
        salida := TSalida.Create(self);
          if Entrada = True then
          begin
            actualizar;
            entrada := False;
          end;
        entrada_articulo := tentrada_articulo.Create(self);
        entrada_articulo.ShowModal;
end;

procedure TFrMain.GastosSeccion1Click(Sender: TObject);
begin

        gastos_seccion := tgastos_seccion.Create(self);
        with gastos_seccion do
        begin
          ibdataset1.Active:=true;
          ibdataset1.Last;
          ejecutar.Visible:=true;
          dependencia.Visible:=true;
          Label3.Caption:='Seccion';
          Caption := 'Reportes de Gastos por Seccion';
          gastos_seccion.ShowModal;
        end;
end;

procedure TFrMain.Actualizar1Click(Sender: TObject);
begin
        empleado := Templeado.Create(Self);
        empleado.actempleado := true;
        empleado.BACEPTAR.Caption:='&Actualizar';
        empleado.Caption:= 'Actualizacion Empleado';
        empleado.ShowModal;
end;

procedure TFrMain.ConsultarSalidas1Click(Sender: TObject);
begin
        conentrada := Tconentrada.Create(Self);
        conentrada.ShowModal;
end;

procedure TFrMain.Existencias1Click(Sender: TObject);
begin
        existencia := Texistencia.Create(Self);
        existencia.ShowModal;
end;

procedure TFrMain.ToolButton9Click(Sender: TObject);
begin
        existencia := Texistencia.Create(self);
        existencia.Show;
end;

procedure TFrMain.Entradas1Click(Sender: TObject);
begin
        repentrada := trepentrada.Create(self);
        with repentrada do
        begin
          label1.Caption:= 'No Entrada';
          bitbtn1.Visible:=true;
          ShowModal;
        end;
end;

procedure TFrMain.GastosSucursal1Click(Sender: TObject);
begin
        gastos_seccion := tgastos_seccion.Create(self);
        with gastos_seccion do
        begin
          ibdataset2.Active:=true;
          ibdataset2.Last;
          ejecutarsalida.Visible:=true;
          sucursal.Visible:=true;
          label3.Caption:='Sucursal';
          caption:='Reportes de Gastos por Sucursal';
          gastos_seccion.ShowModal;
        end;
end;
procedure TFrMain.Salidas1Click(Sender: TObject);
begin
        repentrada := trepentrada.Create(self);
        with repentrada do
        begin
          label1.Caption:= 'No Salida';
          ejesalida.Visible:=true;
          ShowModal;
        end;
end;
procedure TFrMain.Sucursal1Click(Sender: TObject);
begin
        d := td.Create(self);
        d.ShowModal;
end;
procedure TFrMain.rr1Click(Sender: TObject);
begin
        reportes := treportes.Create(self);
        reportes.ShowModal;
end;
procedure TFrMain.Seccion1Click(Sender: TObject);
begin
        gastos_seccion := tgastos_seccion.Create(self);
        with gastos_seccion do
        begin
          ibdataset1.Active:=true;
          ibdataset1.Last;
          ejeconsumo.Visible:=true;
          dependencia.Visible:=true;
          label3.Caption:='Seccion';
          caption:='Reportes de Consumo por Seccion';
          gastos_seccion.ShowModal;
        end;
end;
procedure TFrMain.Empleado2Click(Sender: TObject);
begin
        repempleado := trepempleado.Create(self);
        with repempleado do
        begin
          opcion:=1;
          Caption:='Reporte Consumo Empleado';
          ejecutaemp.Visible:=true;
          lista.Visible:=true;
          ShowModal;
        end;
end;
procedure TFrMain.Sucursal2Click(Sender: TObject);
begin
        gastos_seccion := tgastos_seccion.Create(self);
        with gastos_seccion do
        begin
          ibdataset2.Active:=true;
          ibdataset2.Last;
          ejecutasuc.Visible:=true;
          sucursal.Visible:=true;
          label3.Caption:='Sucursal';
          caption:='Reportes de Consumo por Sucursal';
          gastos_seccion.ShowModal;
        end;
end;

procedure TFrMain.rrClick(Sender: TObject);
begin

        reportes := Treportes.Create(Self);
        reportes.ShowModal;
end;

procedure TFrMain.ConfigurarImpresora1Click(Sender: TObject);
begin
        PrinterSetupDialog.Execute;
end;

procedure TFrMain.StockMinimo1Click(Sender: TObject);
begin
        reportes := treportes.Create(self);
        reportes.stock_min;
end;

procedure TFrMain.Detalle1Click(Sender: TObject);
begin
        reportes := treportes.Create(self);
        reportes.detalle_art;
end;

procedure TFrMain.General1Click(Sender: TObject);
begin
        repempleado := trepempleado.Create(self);
        with repempleado do
        begin
          opcion:=2;
          Caption:='Reporte Consumo General';
          ejecutagen.Visible:=true;
          Label1.Visible:=false;
          ShowModal;
        end;
end;

procedure TFrMain.GastosEmpleado1Click(Sender: TObject);
begin
        repempleado := trepempleado.Create(self);
        with repempleado do
        begin
          opcion:=3;
          Caption:='Reporte Gastos Empleados';
          lista.Visible:=True;
          ejevaloracion.Visible:=true;
          ShowModal;
        end;
end;

procedure TFrMain.GastosEmpleado2Click(Sender: TObject);
begin
        repempleado := trepempleado.Create(self);
        with repempleado do
        begin
          Caption:='Reporte Gastos Empleados';
          opcion:=4;
          lista.Visible:=True;
          ejecuta_val_emp.Visible:=true;
          ShowModal;
        end;
end;

procedure TFrMain.Sto1Click(Sender: TObject);
begin
        reportes:=Treportes.Create(self);
        reportes.stock1;
end;

procedure TFrMain.GastosSeccion2Click(Sender: TObject);
begin
        gastos_seccion := tgastos_seccion.Create(self);
        with gastos_seccion do
        begin
          ibdataset1.Active:=true;
          ibdataset1.Last;
          eje_val_seccion.Visible:=true;
          dependencia.Visible:=true;
          label3.Caption:='Seccion';
          caption:='Reportes de Gastos por Seccion';
          gastos_seccion.ShowModal;
        end;
end;

procedure TFrMain.GastosGenerales2Click(Sender: TObject);
begin
        repempleado := trepempleado.Create(self);
        with repempleado do
        begin
          Caption:='Reporte Gastos Generales';
          lista.Visible:=false;
          ejecuta_gen.Visible:=true;
          label1.Visible:=False;
          ShowModal;
        end;
end;

procedure TFrMain.GastosSucursal2Click(Sender: TObject);
begin
        gastos_seccion := tgastos_seccion.Create(self);
        with gastos_seccion do
        begin
          ibdataset2.Active:=true;
          ibdataset2.Last;
          eje_val_sucursal.Visible:=true;
          sucursal.Visible:=True;
          label3.Caption:='Sucursal';
          caption:='Reportes de Gastos por Sucursal';
          gastos_seccion.ShowModal;
        end;
end;

procedure TFrMain.Relativa1Click(Sender: TObject);
begin
        gastos_seccion := tgastos_seccion.Create(self);
        with gastos_seccion do
        begin
          ejecuta_valseccion.Visible:=true;
          Label3.Visible:=False;
          caption:='Reportes Relativo de Gastos por Seccion';
          gastos_seccion.ShowModal;
        end;
end;

procedure TFrMain.Salir1Click(Sender: TObject);
begin
        Self.Close;
end;

procedure TFrMain.FormClick(Sender: TObject);
begin
        menu.AutoPopup:=True;
end;

procedure TFrMain.Articulo4Click(Sender: TObject);
begin
        Articulo2Click(self);
end;

procedure TFrMain.Empleados1Click(Sender: TObject);
begin
        Articulo2Click(self);
end;

procedure TFrMain.Proveedores1Click(Sender: TObject);
begin
        Proveedor1Click(Self);
end;

procedure TFrMain.Entradas2Click(Sender: TObject);
begin
        Entrada1Click(Self);
end;

procedure TFrMain.Salidas2Click(Sender: TObject);
begin
        Salida1Click(Self);
end;

procedure TFrMain.Salir2Click(Sender: TObject);
begin
        Self.Close;
end;

procedure TFrMain.Existencias2Click(Sender: TObject);
begin
        ExistenciaArticulos1Click(Self);
end;

procedure TFrMain.ReporteGastoDiario1Click(Sender: TObject);
begin
        repempleado := Trepempleado.Create(self);
        repempleado.fecha_ini.DateTime:=Date;
        repempleado.fecha_fin.DateTime:=Date;
        repempleado.ejecuta_genClick(Self);
end;

procedure TFrMain.Informacin1Click(Sender: TObject);
begin
        reportes := treportes.Create(self);
        reportes.rep_articulos;
end;

procedure TFrMain.ToolButton11Click(Sender: TObject);
begin
        Close;
end;

procedure TFrMain.Valoracion1Click(Sender: TObject);
var     total: string;
        valor_t,valor,precio,existencia: Variant;

begin
        actualizar;
        valor_t:=0;
        with datageneral.IBsql do
        begin
        Close;
        SQL.Clear;
        SQL.Add('select "inv$articulo"."precio_unitario","inv$articulo"."existencia" from "inv$articulo"');
        ExecQuery;
           while not datageneral.IBsql.Eof do
           begin
           precio:=FieldByName('precio_unitario').AsCurrency;
           existencia:=FieldByName('existencia').AsInteger;
           valor:= precio*existencia;
           valor_t := valor + valor_t;
           datageneral.IBsql.Next;
           end;
           total:=FormatCurr('#,##0.00',valor_t);
           ShowMessage('Total Existencias: $' + total);
           end;

end;

procedure TFrMain.General3Click(Sender: TObject);
begin
        reportes := Treportes.Create(self);
        reportes.valor_existencias;
end;

procedure TFrMain.Suministros1Click(Sender: TObject);
begin
        reportes := Treportes.Create(self);
        reportes.valoraciones;
end;

procedure TFrMain.Papeleria1Click(Sender: TObject);
begin
        reportes := Treportes.Create(self);
        reportes.valoracion_papeleria;
end;

procedure TFrMain.Consumo3Click(Sender: TObject);
begin

        gastos_seccion := tgastos_seccion.Create(self);
        with gastos_seccion do
        begin
          Label3.Visible:=False;
          Label4.Visible:=True;
          ejecuta_consumo.Visible:=True;
          co_articulo.Visible:=True;
//          co_articulo.SetFocus;
          caption:='Reportes de Cosumo de Articulos';
          gastos_seccion.ShowModal;
        end;

end;

procedure TFrMain.ReclasificacionArticulos1Click(Sender: TObject);
begin
        FrmReclasificacion := TFrmReclasificacion.Create(Self);
        FrmReclasificacion.ShowModal
end;

procedure TFrMain.ConsumoConsolidado1Click(Sender: TObject);
begin
        FrmRepConsolidado := TFrmRepConsolidado.Create(Self);
        FrmRepConsolidado.ShowModal;
end;

end.
