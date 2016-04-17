unit frmrepperiodico;

interface

uses
  Windows, Messages,frmreportesgenerales, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, IBCustomDataSet, DBCtrls, ComCtrls;

type
  Tgastos_seccion = class(TForm)
    IBDataSet1: TIBDataSet;
    DataSource1: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    fecha_ini: TDateTimePicker;
    Label2: TLabel;
    fecha_fin: TDateTimePicker;
    dependencia: TDBLookupComboBox;
    Label3: TLabel;
    ejecutar: TBitBtn;
    ejecutarsalida: TBitBtn;
    sucursal: TDBLookupComboBox;
    DataSource2: TDataSource;
    IBDataSet2: TIBDataSet;
    ejeconsumo: TBitBtn;
    ejecutasuc: TBitBtn;
    eje_val_seccion: TBitBtn;
    eje_val_sucursal: TBitBtn;
    ejecuta_valseccion: TBitBtn;
    ibbusca_agencia: TIBDataSet;
    ibcantidad_agencia: TIBDataSet;
    ibbusca_seccion: TIBDataSet;
    ibcantidad_seccion: TIBDataSet;
    ejecuta_consumo: TBitBtn;
    co_articulo: TEdit;
    Label4: TLabel;
    procedure ejecutarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ejecutarsalidaClick(Sender: TObject);
    procedure ejeconsumoClick(Sender: TObject);
    procedure ejecutasucClick(Sender: TObject);
    procedure eje_val_seccionClick(Sender: TObject);
    procedure eje_val_sucursalClick(Sender: TObject);
    procedure ejecuta_valseccionClick(Sender: TObject);
    procedure ejecuta_consumoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  gastos_seccion: Tgastos_seccion;

implementation
uses frmprincipal,frmdatamodulo, reporte;
//var     datageneral:tdatageneral;

{$R *.dfm}

procedure Tgastos_seccion.ejecutarClick(Sender: TObject);
var     lugar:string;
        cod_dep:integer;
begin
        reportes:=treportes.Create(self);
        with datageneral.IBdatos do
        begin
          Sql.Clear;
          Sql.Add('select "inv$dependencia"."cod_dependencia" as coddep from "inv$dependencia"');
          Sql.Add('where "inv$dependencia"."nombre" like :"SISTEMAS"');
          ParamByname('SISTEMAS').AsString:=dependencia.Text;
          open;
          cod_dep:=FieldByname('coddep').AsInteger;
          close;
        end;
        lugar:= frmain.wpath+'reportes\VALORACIONSECCION.frf';
        reportes.frDBDataSet1.DataSet:=reportes.valoracionseccion;
        reportes.valoracionseccion.ParamByName('codigo').AsInteger:=cod_dep;
        reportes.valoracionseccion.ParamByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
        reportes.valoracionseccion.ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
        reportes.valoracionseccion.Open;
        if reportes.valoracionseccion.RecordCount= 0 then
            showmessage('No Existen Elementos Disponibles')
        else
        begin
          ipresion.Caption:= 'Reporte de Gastos Por Seccón '+ '"Vista Previa"';
          reportes.imprimir_reporte(lugar);
        end;
end;

procedure Tgastos_seccion.FormCreate(Sender: TObject);
begin
        fecha_ini.DateTime:=date;
        fecha_fin.DateTime:=date;
        fecha_fin.MaxDate := Date;
        fecha_ini.MaxDate := Date;
        fecha_ini.MinDate := StrToDate('2003/10/08');
        reportes := Treportes.Create(self);
end;

procedure Tgastos_seccion.ejecutarsalidaClick(Sender: TObject);
var     lugar:string;
        cod_dep:integer;
begin
        with datageneral.IBdatos do
        begin
          Sql.Clear;
          Sql.Add('select "Inv$Agencia"."cod_agencia" as coddep from "Inv$Agencia"');
          Sql.Add('where "Inv$Agencia"."descripcion" like :"SISTEMAS"');
          ParamByname('SISTEMAS').AsString:=sucursal.Text;
          open;
          cod_dep:=FieldByname('coddep').AsInteger;
          close;
        end;
          lugar:= frmain.wpath + 'reportes\RepSucursal.frf';
          reportes.frDBDataSet1.DataSet:=reportes.salida;
          reportes.salida.ParamByName('codigo').AsInteger:=cod_dep;
          reportes.salida.ParamByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
          reportes.salida.ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
          FrMain.actualizar;
          reportes.salida.Open;
          if reportes.salida.RecordCount= 0 then
            showmessage('No Existen Elementos Disponibles')
          else
          begin
            ipresion.Caption:= 'Reporte de Gastos Por Sucursal '+ '"Vista Previa"';
            reportes.imprimir_reporte(lugar);
          end;
          IBDataSet2.Open;
          IBDataSet2.Last;
end;

procedure Tgastos_seccion.ejeconsumoClick(Sender: TObject);
var     seccion,nombre_r,lugar: string;
        cod_dep,codigo_r,cantidad_r:integer;
begin
        seccion:=dependencia.Text;
        reportes.referencia.Open;
        if reportes.referencia.RecordCount <> 0 then
        begin
          with datageneral.IBsel1 do
          begin
            close;
            sql.Clear;
            sql.Add('delete from "inv$referencia"');
            open;
            close;
            datageneral.IBTransaction1.CommitRetaining;
          end;
        end;

        begin
        reportes.referencia.Close;
          with datageneral.IBdatos do
          begin
            Close;
            Sql.Clear;
            Sql.Add('select "inv$dependencia"."cod_dependencia" as coddep from "inv$dependencia"');
            Sql.Add('where "inv$dependencia"."nombre" like :"SISTEMAS"');
            ParamByname('SISTEMAS').AsString:=dependencia.Text;
            open;
            cod_dep:=FieldByname('coddep').AsInteger;
            close;
          end;

           with ibbusca_seccion do
           begin
             close;
             ParamByName('cod_dep').AsInteger:=cod_dep;
             ParamByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
             ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
             open;
               while not ibbusca_seccion.Eof do
               begin
                 codigo_r:=fieldbyname('codigo').AsInteger;
                 nombre_r:=fieldbyname('nombre').AsString;
                   with ibcantidad_seccion do
                   begin
                     close;
                     parambyname('codigo').AsInteger:=codigo_r;
                     ParamByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
                     ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
                     parambyname('cod_dep').AsInteger:=cod_dep;
                     open;
                     cantidad_r:=fieldbyname('cantidad').AsInteger;
                     close;
                   end;
                   with datageneral.IBsel1 do
                   begin
                     close;
                     sql.clear;
                     sql.Add('insert into "inv$referencia" values(:"codigo_r",:"nombre_r",:"total",:"seccion")');
                     parambyname('codigo_r').AsInteger:=codigo_r;
                     parambyname('nombre_r').AsString:=nombre_r;
                     parambyname('total').AsInteger:=cantidad_r;
                     parambyname('seccion').AsString:=seccion;
                     open;
                     close;
                     datageneral.IBTransaction1.CommitRetaining;
                     end;
             ibbusca_seccion.Next;
               end;
           end;
        ibbusca_seccion.Close;
        reportes.rep:=false;
        lugar:= frmain.wpath + 'reportes\REPORTE_CONSUMO.frf';
        reportes.frDBDataSet2.DataSet:=reportes.referencia;
        datageneral.IBTransaction1.CommitRetaining;
        FrMain.actualizar;
        reportes.referencia.Open;
          if reportes.referencia.RecordCount= 0 then
             showmessage('No Existen Elementos Disponibles')
          else
             ipresion.Caption:= 'Reporte de Consumo Por Sección '+ '"Vista Previa"';
             reportes.imprimir(lugar);
          end;
          IBDataSet1.Open;
          IBDataSet1.Last;
end;
procedure Tgastos_seccion.ejecutasucClick(Sender: TObject);
var     seccion,nombre_r,lugar: string;
        cod_dep,codigo_r,cantidad_r:integer;
begin
        seccion:=dependencia.Text;
        reportes.referencia.Open;
          if reportes.referencia.RecordCount <> 0 then
          begin
            with datageneral.IBsel1 do
            begin
            close;
            sql.Clear;
            sql.Add('delete from "inv$referencia"');
            open;
            close;
            datageneral.IBTransaction1.CommitRetaining;
            end;
          end;
        begin
          reportes.referencia.Close;
          with datageneral.IBdatos do
          begin
            close;
            Sql.Clear;
            Sql.Add('select "Inv$Agencia"."cod_agencia" as coddep from "Inv$Agencia"');
            Sql.Add('where "Inv$Agencia"."descripcion" like :"SISTEMAS"');
            ParamByname('SISTEMAS').AsString:=sucursal.Text;
            open;
            cod_dep:=FieldByname('coddep').AsInteger;
            close;
          end;
          with ibbusca_agencia do
          begin
          close;
          parambyname('cod_dep').AsInteger:=cod_dep;
          ParamByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
          ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
          Open;
            while not ibbusca_agencia.Eof do
            begin
              codigo_r:=fieldbyname('codigo').AsInteger;
              nombre_r:=fieldbyname('nombre').AsString;
                with ibcantidad_agencia do
                begin
                  close;
                  parambyname('codigo').AsInteger:=codigo_r;
                  ParamByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
                  ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
                  parambyname('cod_dep').AsInteger:=cod_dep;
                  open;
                  cantidad_r:=fieldbyname('cantidad').AsInteger;
                  close;
                end;
                    with datageneral.IBsel1 do
                    begin
                      close;
                      sql.clear;
                      sql.Add('insert into "inv$referencia" values(:"codigo_r",:"nombre_r",:"total",:"seccion")');
                      parambyname('codigo_r').AsInteger:=codigo_r;
                      parambyname('nombre_r').AsString:=nombre_r;
                      parambyname('total').AsInteger:=cantidad_r;
                      parambyname('seccion').AsString:=sucursal.Text;
                      open;
                      close;
                      datageneral.IBTransaction1.CommitRetaining;
                    end;
          ibbusca_agencia.Next;
            end;
        end;
          ibbusca_agencia.Close;
          reportes.rep:=false;
          lugar:= frmain.wpath + 'reportes\REPORTE_CONSUMO_SUC.frf';
          reportes.frDBDataSet2.DataSet:=reportes.referencia;
          datageneral.IBTransaction1.CommitRetaining;
          FrMain.actualizar;
          reportes.referencia.Open;
           if reportes.referencia.RecordCount= 0 then
             showmessage('No Existen Elementos Disponibles')
           else
           begin
             ipresion.Caption:= 'Reporte de Consumo Por Sucursal '+ '"Vista Previa"';
             reportes.imprimir(lugar);
        end;
        IBDataSet2.Open;
        IBDataSet2.Last;
end;
end;
procedure Tgastos_seccion.eje_val_seccionClick(Sender: TObject);
begin

        reportes.referencia.Open;
        if reportes.referencia.RecordCount <> 0 then
        begin
          with datageneral.IBsel1 do
          begin
          close;
          sql.Clear;
          sql.Add('delete from "inv$referencia"');
          open;
          close;
          datageneral.IBTransaction1.CommitRetaining;
          end;
        end;
        reportes.referencia.Close;
        with datageneral.IBdatos do
        begin
          Sql.Clear;
          Sql.Add('select "inv$dependencia"."cod_dependencia" as coddep from "inv$dependencia"');
          Sql.Add('where "inv$dependencia"."nombre" like :"SISTEMAS"');
          ParamByname('SISTEMAS').AsString:=dependencia.Text;
          open;
          reportes.cod_dep:=FieldByname('coddep').AsInteger;
          close;
        end;
        reportes.nombre_emp:=dependencia.Text;
        reportes.fecha_ini:=DateToStr(fecha_ini.DateTime);
        reportes.fecha_fin:=DateToStr(fecha_fin.DateTime);
        reportes.rep:=false;
        reportes.valora_seccion;
        lugar:= frmain.wpath + 'reportes\REPORTE_VALORACION_SECCION.frf';
        reportes.frDBDataSet2.DataSet:=reportes.referencia;
        datageneral.IBTransaction1.CommitRetaining;
        FrMain.actualizar;
        reportes.referencia.Open;
        if reportes.referencia.RecordCount= 0 then
          showmessage('No Existen Elementos Disponibles')
        else
        begin
          ipresion.Caption:= 'Reporte de Gastos Por Sección '+ '"Vista Previa"';
          reportes.imprimir(lugar);
        end;
        IBDataSet1.Open;
        IBDataSet1.Last;
end;

procedure Tgastos_seccion.eje_val_sucursalClick(Sender: TObject);
begin
        reportes.referencia.Open;
        if reportes.referencia.RecordCount <> 0 then
        begin
          with datageneral.IBsel1 do
          begin
            close;
            sql.Clear;
            sql.Add('delete from "inv$referencia"');
            open;
            close;
            datageneral.IBTransaction1.CommitRetaining;
          end;
        end;
        reportes.referencia.Close;
        with datageneral.IBdatos do
        begin
          close;
          Sql.Clear;
          Sql.Add('select "Inv$Agencia"."cod_agencia" as coddep from "Inv$Agencia"');
          Sql.Add('where "Inv$Agencia"."descripcion" like :"SISTEMAS"');
          ParamByname('SISTEMAS').AsString:=sucursal.Text;
          open;
          reportes.cod_dep:=FieldByname('coddep').AsInteger;
          close;
        end;
        reportes.nombre_emp:=sucursal.Text;
        reportes.fecha_ini:=DateToStr(fecha_ini.DateTime);
        reportes.fecha_fin:=DateToStr(fecha_fin.DateTime);
        reportes.rep:=false;
        reportes.valora_sucursal;
        lugar:= frmain.wpath + 'reportes\REPORTE_VALORACION_SUCURSAL.frf';
        reportes.frDBDataSet2.DataSet:=reportes.referencia;
        datageneral.IBTransaction1.CommitRetaining;
        FrMain.actualizar;
        reportes.referencia.Open;
        if reportes.referencia.RecordCount= 0 then
          showmessage('No Existen Elementos Disponibles')
        else
        begin
          ipresion.Caption:= 'Reporte de Gastos Por Sucursal '+ '"Vista Previa"';
          reportes.imprimir(lugar);
        end;
        IBDataSet2.Open;
        IBDataSet2.Last;
end;
procedure Tgastos_seccion.ejecuta_valseccionClick(Sender: TObject);
var     lugar:string;
begin
        reportes.referencia.Open;
        reportes.rep:=false;
        if reportes.referencia.RecordCount <> 0 then
        begin
          with datageneral.IBsel1 do
          begin
            close;
            sql.Clear;
            sql.Add('delete from "inv$referencia"');
            open;
            close;
            datageneral.IBTransaction1.CommitRetaining;
          end;
        end;
        reportes.referencia.Close;
        reportes.fecha_ini:=DateToStr(fecha_ini.DateTime);
        reportes.fecha_fin:=DateToStr(fecha_fin.DateTime);
        reportes.relacion_gastos;
        lugar:= frmain.wpath + 'reportes\REPORTE_CONSUMO_SECCION.frf';
        reportes.frDBDataSet2.DataSet:=reportes.referencia;
        datageneral.IBTransaction1.CommitRetaining;
        FrMain.actualizar;
        reportes.referencia.Open;
        if reportes.referencia.RecordCount= 0 then
        begin
          showmessage('No Existen Elementos Disponibles');
        end
        else
        begin
           ipresion.Caption:= 'Reporte de Consumo Por Sección '+ '"Vista Previa"';
           reportes.imprimir(lugar);
        end;
end;
procedure Tgastos_seccion.ejecuta_consumoClick(Sender: TObject);
var nombre_a : string;
begin
        reportes.referencia.Open;
        if reportes.referencia.RecordCount <> 0 then
        begin
          with datageneral.IBsel1 do
          begin
            close;
            sql.Clear;
            sql.Add('delete from "inv$referencia"');
            open;
            close;
            datageneral.IBTransaction1.CommitRetaining;
          end;
        end;
        with DataGeneral.IBsel do
        begin
        Close;
        SQL.Clear;
        SQL.Add('select "inv$articulo"."nombre" from "inv$articulo"');
        SQL.Add('where "inv$articulo"."cod_articulo" = :"codigo"');
        ParamByName('codigo').AsInteger:=StrToInt(co_articulo.Text);
        Open;
        nombre_a:=FieldByName('nombre').AsString;
        Close;
        end;
        reportes.referencia.Close;
        reportes.codigo_articulo1:=StrToInt(co_articulo.Text);
        reportes.nombre_articulo:=nombre_a;
        reportes.fecha_ini:=DateToStr(fecha_ini.DateTime);
        reportes.fecha_fin:=DateToStr(fecha_fin.DateTime);
        reportes.rep:=false;
        reportes.e_articulo;
        lugar:= frmain.wpath + 'reportes\REPORTECON.frf';
        reportes.frDBDataSet2.DataSet:=reportes.referencia;
        datageneral.IBTransaction1.CommitRetaining;
        FrMain.actualizar;
        reportes.referencia.Open;
        if reportes.referencia.RecordCount= 0 then
          showmessage('No Existen Elementos Disponibles')
        else
        begin
          ipresion.Caption:= 'Reporte de Gastos Por Sucursal '+ '"Vista Previa"';
          reportes.imprimir(lugar);
        end;
end;

end.
