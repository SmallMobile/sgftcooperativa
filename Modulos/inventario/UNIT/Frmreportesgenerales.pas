unit Frmreportesgenerales;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBCustomDataSet, Grids, DBGrids, IBDatabase,
  IBQuery, FR_DSet, FR_DBSet, FR_Class, IBTable, ExtCtrls, FR_View,
  DBCtrls, ComCtrls, frOLEExl, FR_E_TXT, FR_E_RTF, frRtfExp;

type
  Treportes = class(TForm)
    Label1: TLabel;
    frReport1: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    IBQuery1: TIBQuery;
    IBTable1: TIBTable;
    frCompositeReport1: TfrCompositeReport;
    IBdatos: TIBQuery;
    Empresa: TIBTable;
    proveedores: TIBQuery;
    cosumoseccion: TIBQuery;
    valoracionseccion: TIBQuery;
    entrada: TIBQuery;
    repseccion: TIBQuery;
    salida: TIBQuery;
    regsalida: TIBQuery;
    total: TIBQuery;
    total1: TIBQuery;
    total1NOM: TLargeintField;
    referencia: TIBTable;
    DataSource1: TDataSource;
    frReport2: TfrReport;
    frDBDataSet2: TfrDBDataSet;
    referenciacod_articulo: TIntegerField;
    referencianombre: TIBStringField;
    referenciacantidad: TIntegerField;
    referencianombre_re: TIBStringField;
    IBDataSet1: TIBDataSet;
    stock_minimo: TIBQuery;
    Detalle: TIBQuery;
    Button1: TButton;
    Button2: TButton;
    valorempleado: TIBQuery;
    valgeneral: TIBQuery;
    datos: TIBQuery;
    Edit1: TEdit;
    cantidad_total: TIBDataSet;
    cantidad_totalCANTIDAD: TLargeintField;
    cant_tot: TIBDataSet;
    ibbusca_codigo: TIBDataSet;
    ibprecio_salida: TIBDataSet;
    ibbusca_general: TIBDataSet;
    cantidad_general: TIBDataSet;
    LargeintField1: TLargeintField;
    ibbusca_seccion: TIBDataSet;
    ibprecio_salidagen: TIBDataSet;
    ibprecio_salidasec: TIBDataSet;
    ibcantidad_seccion: TIBDataSet;
    ibbusca_agencia: TIBDataSet;
    ibprecio_agencia: TIBDataSet;
    ibcantidad_agencia: TIBDataSet;
    IBQuery2: TIBQuery;
    secciones: TIBQuery;
    frOLEExcelExport1: TfrOLEExcelExport;
    frRtfAdvExport1: TfrRtfAdvExport;
    frRTFExport1: TfrRTFExport;
    frTextExport1: TfrTextExport;
    valor_existencia: TIBQuery;
    valoracion: TIBQuery;
    valoracionnombre: TIBStringField;
    valoracioncod_articulo: TIntegerField;
    valoracionstock: TSmallintField;
    valoracionprecio_unitario: TIBBCDField;
    valoracionexistencia: TIntegerField;
    valoracionnombre1: TIBStringField;
    valoraciondetalle: TIBStringField;
    valoracion1: TIBQuery;
    e_consumo: TIBDataSet;
    procedure frReport2GetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
  public
    rep:boolean;
    fecha_ini,fecha_fin,nombre_emp,nombre_articulo : string;
    nit_empleado,cod_dep,codigo_articulo,codigo_articulo1: Integer;
    procedure reporte_articulo;
    procedure reporte_proveedor;
    procedure stock_min;
    procedure detalle_art;
    procedure reportr_gen;
    procedure empleado_gen;
    procedure valora_seccion;
    procedure stock1;
    procedure valora_sucursal;
    procedure relacion_gastos;
    procedure rep_articulos;
    procedure valor_existencias;
    procedure valoraciones;
    procedure valoracion_papeleria;

  published
    procedure imprimir_reporte(cadena: string);
    procedure imprimir(cadena: string);
    procedure e_articulo;
    { Public declarations }
  end;

var
  reportes: Treportes;
  var lugar: string;

implementation
uses      reporte,frmdatamodulo,frmprincipal,frmrepperiodico, frmrepempleado,
          frmDependencia;

{$R *.dfm}

procedure Treportes.imprimir_reporte(cadena: string);
begin
        frReport1.LoadFromFile(cadena);
        frCompositeReport1.DoublePass := True;
        frCompositeReport1.Reports.Clear;
        frCompositeReport1.Reports.Add(frReport1);
        frReport1.Preview:=ipresion.frPreview1;
        frReport1.ShowReport;
        ipresion.ShowModal

end;
procedure Treportes.reporte_articulo;
begin
        lugar:=FrMain.wpath+'reportes\reportearticulo.frf';
        frDBDataSet1.DataSet:=ibquery1;
        IBQuery1.Open;
        frReport1.Dictionary.Variables.Variable['nombre'] := 'nombre';
        imprimir_reporte(lugar);
end;

procedure Treportes.reporte_proveedor;
begin
        lugar:=FrMain.wpath+'reportes\repproveedores.frf';
        frDBDataSet1.DataSet:=proveedores;
        proveedores.Open;
        imprimir_reporte(lugar);

end;

procedure Treportes.frReport2GetValue(const ParName: String;
  var ParValue: Variant);

begin
        if rep = false then
        begin
          frReport2.Dictionary.Variables['fecha1']:=gastos_seccion.fecha_ini.DateTime;
          frReport2.Dictionary.Variables['fecha2']:=gastos_seccion.fecha_fin.DateTime;
        end
          else
          begin
            frReport2.Dictionary.Variables['fecha1']:=repempleado.fecha_ini.DateTime;
            frReport2.Dictionary.Variables['fecha2']:=repempleado.fecha_fin.DateTime;
          end;
        end;
procedure Treportes.imprimir(cadena: string);
begin
        frReport2.LoadFromFile(cadena);
        frCompositeReport1.DoublePass := True;
        frCompositeReport1.Reports.Clear;
        frCompositeReport1.Reports.Add(frReport2);
        frReport2.Preview:=ipresion.frPreview1;
        frReport2.ShowReport;
        ipresion.ShowModal
end;
procedure Treportes.stock_min;
begin
        lugar:=FrMain.wpath+'reportes\repstock.frf';
        frDBDataSet1.DataSet:=stock_minimo;
        stock_minimo.Open;
        imprimir_reporte(lugar);
end;
procedure Treportes.detalle_art;
begin
        lugar:=FrMain.wpath+'reportes\reportedetalle.frf';
        frDBDataSet1.DataSet:=detalle;
        detalle.Open;
        imprimir_reporte(lugar);
end;
procedure Treportes.reportr_gen;
var     nombre_a: string;
        cod_art: integer;
        cantidad,cantidad_t,total,total_p,precio_salida: Variant;
begin
        cantidad_t:=0;
        total_p:=0;
        with ibbusca_general do
        begin
          Close;
          ParamByName('fecha').AsString:=fecha_ini;
          ParamByName('fecha1').AsString:=fecha_fin;
          Open;
          while not ibbusca_general.Eof do
          begin
            cod_art:=FieldByName('codigo').AsInteger;
            nombre_a:=FieldByName('nombre').AsString;
            with ibprecio_salidagen do
            begin
              Close;
              ParamByName('fecha').AsString:=fecha_ini;
              ParamByName('fecha1').AsString:=fecha_fin;
              ParamByName('codigo').AsInteger:=cod_art;
              Open;
              cantidad_t:=0;
              total_p:=0;
              while not ibprecio_salidagen.Eof do
              begin
                precio_salida:=FieldByName('precio_salida').AsVariant;
                with cantidad_general do
                begin
                  Close;
                  ParamByName('fecha').AsString:=fecha_ini;
                  ParamByName('fecha1').AsString:=fecha_fin;
                  ParamByName('codigo').AsInteger:=cod_art;
                  ParamByName('precio').AsCurrency:=precio_salida;
                  Open;
                  cantidad:=FieldByName('cantidad').AsVariant;
                  cantidad_t:=cantidad_t + cantidad;
                  total:=cantidad*precio_salida;
                  total_p := total_p + total;
                  Close;
                end;
             ibprecio_salidagen.Next;
             end;
             ibprecio_salidagen.Close;
        end;
        with DataGeneral.IBsel1 do
        begin
           Close;
           SQL.clear;
           SQL.Add('insert into "inv$referencia" values(:"codigo_r",:"nombre_r",:"total",:"seccion")');
           ParamByName('codigo_r').AsInteger:=cod_art;
           ParamByName('nombre_r').AsString:=nombre_a;
           ParamByName('total').AsInteger:=cantidad_t;
           ParamByName('seccion').AsString:=total_P;
           Open;
           Close;
           DataGeneral.IBTransaction1.CommitRetaining;
       end;
        ibbusca_general.Next
        end;
        ibbusca_general.Close;
        end;
end;
procedure Treportes.empleado_gen;
var     nombre_a: string;
        cod_art: integer;
        cantidad,cantidad_t,total,total_p,precio_salida: variant;
begin
        cantidad_t:=0;
        total_p:=0;
        DataGeneral.IBTransaction1.CommitRetaining;
        with ibbusca_codigo do
        begin
          Close;
          ParamByName('fecha').AsString:=fecha_ini;
          ParamByName('fecha1').AsString:=fecha_fin;
          ParamByName('nit').AsInteger:=nit_empleado;
          ParamByName('E').AsString:='E';
          open;
          while not ibbusca_codigo.Eof do
          begin
            cod_art:=FieldByName('cod_articulo').AsInteger;
            nombre_a:=FieldByName('nombre').AsString;
            with ibprecio_salida do
            begin
              Close;
              ParamByName('fecha').AsString:=fecha_ini;
              ParamByName('fecha1').AsString:=fecha_fin;
              ParamByName('codigo').AsInteger:=cod_art;
              ParamByName('nit').AsInteger:=nit_empleado;
              ParamByName('E').AsString:='E';
              Open;
              cantidad_t:=0;
              total_p:=0;
              while not ibprecio_salida.Eof do
              begin
                precio_salida:=FieldByName('precio_salida').AsVariant;
                with cantidad_total do
                begin
                  Close;
                  ParamByName('fecha').AsString:=fecha_ini;
                  ParamByName('fecha1').AsString:=fecha_fin;
                  ParamByName('codigo').AsInteger:=cod_art;
                  ParamByName('precio').AsCurrency:=precio_salida;
                  ParamByName('nit').AsInteger:=nit_empleado;
                  ParamByName('E').AsString:='E';
                  Open;
                  cantidad:=FieldByName('cantidad').AsVariant;
                  cantidad_t:=cantidad_t + cantidad;
                  total:=cantidad*precio_salida;
                  total_p := total_p + total;
                  Close;
                end;
              ibprecio_salida.Next;
             end;
              ibprecio_salida.Close;
            end;
              with DataGeneral.IBsel1 do
              begin
                Close;
                SQL.clear;
                SQL.Add('insert into "inv$referencia" values(:"codigo_r",:"nombre_r",:"total",:"seccion")');
                total_p:=int(total_p);
                ParamByName('codigo_r').AsInteger:=total_p;
                ParamByName('nombre_r').AsString:=nombre_a;
                ParamByName('total').AsInteger:=cantidad_t;
                ParamByName('seccion').AsString:=nombre_emp;
                Open;
                Close;
                DataGeneral.IBTransaction1.CommitRetaining;
              end;
        ibbusca_codigo.Next;
        end;
        ibbusca_codigo.Close;
        end;
end;
procedure Treportes.valora_seccion;
var     nombre_a: string;
        cod_art: integer;
        cantidad,cantidad_t,total,total_p,precio_salida: Variant;
begin
        cantidad_t:=0;
        total_p:=0;
        with ibbusca_seccion do
        begin
          Close;
          ParamByName('fecha').AsString:=fecha_ini;
          ParamByName('fecha1').AsString:=fecha_fin;
          ParamByName('cod_dep').AsInteger:=cod_dep;
          Open;
          while not ibbusca_seccion.Eof do
          begin
            cod_art:=FieldByName('codigo').AsInteger;
            nombre_a:=FieldByName('nombre').AsString;
            with ibprecio_salidasec do
            begin
              Close;
              ParamByName('fecha').AsString:=fecha_ini;
              ParamByName('fecha1').AsString:=fecha_fin;
              ParamByName('codigo').AsInteger:=cod_art;
              ParamByName('cod_dep').AsInteger:=cod_dep;
              Open;
              cantidad_t:=0;
              total_p:=0;
              while not ibprecio_salidasec.Eof do
              begin
                precio_salida:=FieldByName('precio_salida').AsVariant;
                with ibcantidad_seccion do
                begin
                  Close;
                  ParamByName('cod_dep').AsInteger:=cod_dep;
                  ParamByName('fecha').AsString:=fecha_ini;
                  ParamByName('fecha1').AsString:=fecha_fin;
                  ParamByName('codigo').AsInteger:=cod_art;
                  ParamByName('precio').AsCurrency:=precio_salida;
                  Open;
                  cantidad:=FieldByName('cantidad').AsVariant;
                  cantidad_t:=cantidad_t + cantidad;
                  total:=cantidad*precio_salida;
                  total_p := total_p + total;
                  Close;
                end;
             ibprecio_salidasec.Next;
             end;
             ibprecio_salidasec.Close;
        end;
          with DataGeneral.IBsel1 do
          begin
            Close;
            SQL.clear;
            total_p:=int(total_p);
            SQL.Add('insert into "inv$referencia" values(:"codigo_r",:"nombre_r",:"total",:"seccion")');
            ParamByName('codigo_r').AsInteger:=total_p;
            ParamByName('nombre_r').AsString:=nombre_a;
            ParamByName('total').AsInteger:=cantidad_t;
            ParamByName('seccion').AsString:=nombre_emp;
            Open;
            Close;
            DataGeneral.IBTransaction1.CommitRetaining;
        end;
        ibbusca_seccion.Next;
        end;
        ibbusca_seccion.Close;
        end;

end;
procedure Treportes.stock1;
begin
        lugar:=frmain.wpath+'reportes\reportearticulo_stock.frf';
        frDBDataSet1.DataSet:=ibquery1;
        IBQuery1.Open;
        imprimir_reporte(lugar);
end;
procedure Treportes.valora_sucursal;
var     nombre_a: string;
        cod_art: integer;
        cantidad,cantidad_t,total,total_p,precio_salida: Variant;
begin
        cantidad_t:=0;
        total_p:=0;
        with ibbusca_agencia do
        begin
          Close;
          ParamByName('fecha').AsString:=fecha_ini;
          ParamByName('fecha1').AsString:=fecha_fin;
          ParamByName('cod_dep').AsInteger:=cod_dep;
          Open;
          while not ibbusca_agencia.Eof do
          begin
            cod_art:=FieldByName('codigo').AsInteger;
            nombre_a:=FieldByName('nombre').AsString;
            with ibprecio_agencia do
            begin
              Close;
              ParamByName('fecha').AsString:=fecha_ini;
              ParamByName('fecha1').AsString:=fecha_fin;
              ParamByName('codigo').AsInteger:=cod_art;
              ParamByName('cod_dep').AsInteger:=cod_dep;
              Open;
              cantidad_t:=0;
              total_p:=0;
              while not ibprecio_agencia.Eof do
              begin
                precio_salida:=FieldByName('precio_salida').AsVariant;
                with ibcantidad_agencia do
                begin
                  Close;
                  ParamByName('cod_dep').AsInteger:=cod_dep;
                  ParamByName('fecha').AsString:=fecha_ini;
                  ParamByName('fecha1').AsString:=fecha_fin;
                  ParamByName('codigo').AsInteger:=cod_art;
                  ParamByName('precio').AsCurrency:=precio_salida;
                  Open;
                  cantidad:=FieldByName('cantidad').AsVariant;
                  cantidad_t:=cantidad_t + cantidad;
                  total:=cantidad*precio_salida;
                  total_p := total_p + total;
                  Close;
                end;
             ibprecio_agencia.Next;
             end;
             ibprecio_agencia.Close;
           end;
           with DataGeneral.IBsel1 do
           begin
             Close;
             SQL.clear;
             total_p:=int(total_p);
             SQL.Add('insert into "inv$referencia" values(:"codigo_r",:"nombre_r",:"total",:"seccion")');
             ParamByName('codigo_r').AsInteger:=total_p;
             ParamByName('nombre_r').AsString:=nombre_a;
             ParamByName('total').AsInteger:=cantidad_t;
             ParamByName('seccion').AsString:=nombre_emp;
             Open;
             Close;
             DataGeneral.IBTransaction1.CommitRetaining;
           end;
         ibbusca_agencia.Next;
         end;
         ibbusca_agencia.Close;
        end;
end;
procedure Treportes.relacion_gastos;
var     cod_art: integer;
        cantidad,cantidad_t,total,total_p,precio_salida: Variant;
begin
        with datos do
        begin
          SQL.Clear;
          SQL.Add('select "inv$dependencia"."cod_dependencia" as coddep,"inv$dependencia"."nombre" as nombre from "inv$dependencia"');
          Open;
          while not datos.Eof do
          begin
            cod_dep:=FieldByname('coddep').AsInteger;
            nombre_emp:=FieldByname('nombre').AsString;
            cantidad_t:=0;
            total_p:=0;
            with ibbusca_seccion do
            begin
              Close;
              ParamByName('fecha').AsString:=fecha_ini;
              ParamByName('fecha1').AsString:=fecha_fin;
              ParamByName('cod_dep').AsInteger:=cod_dep;
              Open;
              while not ibbusca_seccion.Eof do
              begin
                cod_art:=FieldByName('codigo').AsInteger;
                with ibprecio_salidasec do
                begin
                  Close;
                  ParamByName('fecha').AsString:=fecha_ini;
                  ParamByName('fecha1').AsString:=fecha_fin;
                  ParamByName('codigo').AsInteger:=cod_art;
                  ParamByName('cod_dep').AsInteger:=cod_dep;
                  Open;
                  while not ibprecio_salidasec.Eof do
                  begin
                     precio_salida:=FieldByName('precio_salida').AsVariant;
                     with ibcantidad_seccion do
                        begin
                          Close;
                          ParamByName('cod_dep').AsInteger:=cod_dep;
                          ParamByName('fecha').AsString:=fecha_ini;
                          ParamByName('fecha1').AsString:=fecha_fin;
                          ParamByName('codigo').AsInteger:=cod_art;
                          ParamByName('precio').AsCurrency:=precio_salida;
                          Open;
                          cantidad:=FieldByName('cantidad').AsVariant;
                          cantidad_t:=cantidad_t + cantidad;
                          total:=cantidad*precio_salida;
                          Close;
                        end;
                     total_p := total_p + total;
                     ibprecio_salidasec.Next;
                     end;
                     ibprecio_salidasec.Close;
                   end;
                  ibbusca_seccion.Next
                  end;
                  ibbusca_seccion.Close;
                  with DataGeneral.IBsel1 do
                  begin
                    Close;
                    total_p:= int(total_p);
                    SQL.clear;
                    SQL.Add('insert into "inv$referencia" values(:"codigo_r",:"nombre_r",:"total",:"seccion")');
                    ParamByName('codigo_r').AsInteger:=cod_dep;
                    ParamByName('nombre_r').AsString:=nombre_emp;
                    ParamByName('total').AsInteger:=total_p;
                    ParamByName('seccion').AsString:='';
                    Open;
                    Close;
                    DataGeneral.IBTransaction1.CommitRetaining;
                  end;
          datos.Next;
          end;
        end;
          datos.Close;
        end;
end;
procedure Treportes.rep_articulos;
begin
        lugar:=FrMain.wpath+'reportes\reporte_articulos.frf';
        frDBDataSet1.DataSet:=ibquery2;
        IBQuery2.Open;
        imprimir_reporte(lugar);
end;

procedure Treportes.valor_existencias;
begin
        lugar:=FrMain.wpath+'reportes\valoracion_existencia.frf';
        frDBDataSet1.DataSet:=valor_existencia;
        valor_existencia.Open;
        imprimir_reporte(lugar);
end;

procedure Treportes.valoraciones;
begin
        lugar:=FrMain.wpath+'reportes\valoracion_suministros.frf';
        frDBDataSet1.DataSet:=valoracion;
        valoracion.Open;
        imprimir_reporte(lugar);
end;

procedure Treportes.valoracion_papeleria;
begin
        lugar:=FrMain.wpath+'reportes\valoracion_papeleria.frf';
        frDBDataSet1.DataSet:=valoracion1;
        valoracion1.Open;
        imprimir_reporte(lugar);
end;

procedure Treportes.e_articulo;
var    total:Integer;
begin
        with e_consumo do
        begin
         Close;
         ParamByName('fecha').AsString:=fecha_ini;
         ParamByName('fecha1').AsString:=fecha_fin;
         ParamByName('codigo').AsInteger:=codigo_articulo1;
         Open;
         total:=FieldByName('cantidad').AsInteger;
         Close;
         end;
        with DataGeneral.IBsel1 do
        begin
          Close;
          SQL.clear;
          SQL.Add('insert into "inv$referencia" values(:"codigo_r",:"nombre_r",:"total",:"seccion")');
          ParamByName('codigo_r').AsInteger:=codigo_articulo1;
          ParamByName('nombre_r').AsString:=nombre_articulo;
          ParamByName('total').AsInteger:=total;
          ParamByName('seccion').AsString:='';
          Open;
          Close;
          DataGeneral.IBTransaction1.CommitRetaining;
         end;
end;

end.
