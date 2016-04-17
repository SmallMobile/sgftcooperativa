unit frmrepempleado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, DB, IBCustomDataSet;

type
  Trepempleado = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    lista: TComboBox;
    ejecutaemp: TBitBtn;
    listanit: TComboBox;
    Label2: TLabel;
    fecha_ini: TDateTimePicker;
    Label3: TLabel;
    fecha_fin: TDateTimePicker;
    IBDataSet1: TIBDataSet;
    ejecutagen: TBitBtn;
    ejevaloracion: TBitBtn;
    ejecuta_gen: TBitBtn;
    ejecuta_val_emp: TBitBtn;
    ibbusca_codigo: TIBDataSet;
    cantidad_total: TIBDataSet;
    ibtotal_general: TIBDataSet;
    ibbusca_general: TIBDataSet;
    procedure FormCreate(Sender: TObject);
    procedure ejecutaempClick(Sender: TObject);
    procedure listaExit(Sender: TObject);
    procedure listaKeyPress(Sender: TObject; var Key: Char);
    procedure ejecutagenClick(Sender: TObject);
    procedure ejevaloracionClick(Sender: TObject);
    procedure ejecuta_genClick(Sender: TObject);
    procedure fecha_finExit(Sender: TObject);
    procedure ejecuta_val_empClick(Sender: TObject);

  private
    { Private declarations }
  public

  opcion: Integer;

    { Public declarations }
  end;

var
  repempleado: Trepempleado;
  nit_emp: integer;

implementation
uses frmdatamodulo, Frmreportesgenerales, FrmPrincipal, reporte;

{$R *.dfm}

procedure Trepempleado.FormCreate(Sender: TObject);
var nombre,nombre1: string;
begin
        reportes := Treportes.Create(self);
        fecha_ini.DateTime:=date;
        fecha_fin.DateTime:=date;
        with datageneral.IBsel do
        begin
          close;
          sql.Clear;
          sql.Add('select "inv$empleado"."nombre","inv$empleado"."apellido"  from "inv$empleado"');
          open;
          while not datageneral.IBsel.Eof do
          begin
            nombre:=FieldByName('nombre').AsString + ' ' + fieldbyname('apellido').AsString;
            nombre1:=FieldByName('nombre').AsString + FieldByName('apellido').AsString;
            lista.Items.Add(nombre);
            listanit.Items.Add(nombre1);
            DataGeneral.IBsel.Next;
          end;
          close;
        end;
end;

procedure Trepempleado.ejecutaempClick(Sender: TObject);
var     seccion,nombre_r,lugar: string;
        codigo_r,cantidad_r:integer;
begin
        seccion:=lista.Text;
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
          with ibbusca_codigo do
          begin
          Close;
          parambyname('cod_dep').AsInteger:=nit_emp;
          ParamByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
          ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
          ParamByName('E').AsString:='E';
          Open;
            while not ibbusca_codigo.Eof do
            begin
              codigo_r:=fieldbyname('codigo').AsInteger;
              nombre_r:=fieldbyname('nombre').AsString;
                with  cantidad_total do
                begin
                  close;
                  parambyname('codigo').AsInteger:=codigo_r;
                  ParamByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
                  ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
                  parambyname('cod_dep').AsInteger:=nit_emp;
                  open;
                  cantidad_r:=FieldByName('total').AsInteger;
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
                ibbusca_codigo.Next
           end;
          end;
          ibbusca_codigo.Close;
          reportes.rep:=true;
          lugar:= frmain.wpath + 'reportes\REPORTE_CONSUMO_EMP.frf';
          reportes.frDBDataSet2.DataSet:=reportes.referencia;
          datageneral.IBTransaction1.CommitRetaining;
          FrMain.actualizar;
          reportes.referencia.Open;
          if reportes.referencia.RecordCount= 0 then
          begin
            showmessage('No Existen Elementos Disponibles');
            lista.ItemIndex:=-1;
            lista.SetFocus;
          end
            else
            begin
              ipresion.Caption:= 'Reporte de Consumo Por Empleado '+ '"Vista Previa"';
              reportes.imprimir(lugar);
              lista.ItemIndex:=-1;
              lista.SetFocus;
             end;

end;

procedure Trepempleado.listaExit(Sender: TObject);
 var    a:integer;
        b:string;
begin
        a:=lista.ItemIndex;
        listanit.ItemIndex:=a;
        b:=listanit.Text;
        ibdataset1.parambyname('nombre').AsString:=b;
        ibdataset1.Open;
        nit_emp:=ibdataset1.fieldbyname('nit').AsInteger;
        ibdataset1.Close;
        end;

procedure Trepempleado.listaKeyPress(Sender: TObject; var Key: Char);
begin
        if key =#13 then
        begin
        case opcion of
          1 : ejecutaemp.SetFocus;
          2 : ejecutagen.SetFocus;
          3 : ejevaloracion.SetFocus;
          4 : ejecuta_val_emp.SetFocus;
        end;
        end;

end;

procedure Trepempleado.ejecutagenClick(Sender: TObject);
var     nombre_r,lugar: string;
        codigo_r,cantidad_r:integer;
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
        with ibbusca_general do
        begin
          close;
          paramByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
          ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
          Open;
             while not ibbusca_general.Eof do
             begin
               codigo_r:=FieldByName('codigo').AsInteger;
               nombre_r:=FieldByName('nombre').AsString;
                  with ibtotal_general do
                  begin
                    Close;
                    ParamByName('codigo').AsInteger:=codigo_r;
                    ParamByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
                    ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
                    Open;
                    cantidad_r:=FieldByName('total').AsInteger;
                    close;
                 end;
                    with DataGeneral.IBsel1 do
                    begin
                      Close;
                      SQL.clear;
                      SQL.Add('insert into "inv$referencia" values(:"codigo_r",:"nombre_r",:"total",:"en")');
                      ParamByName('codigo_r').AsInteger:=codigo_r;
                      ParamByName('nombre_r').AsString:=nombre_r;
                      ParamByName('total').AsInteger:=cantidad_r;
                      ParamByName('en').AsString:='';
                      Open;
                      Close;
                      DataGeneral.IBTransaction1.CommitRetaining;
                   end;
          ibbusca_general.Next;
        end;
        end;
        ibbusca_general.Close;
        reportes.rep:=true;
        lugar:= frmain.wpath + 'reportes\REPORTE_CONSUMO_GEN.frf';
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
          ipresion.Caption:= 'Reporte Consumo General '+ '"Vista Previa"';
          reportes.imprimir(lugar);
        end;
end;

procedure Trepempleado.ejevaloracionClick(Sender: TObject);
begin
        reportes.valorempleado.Close;
        lugar:= frmain.wpath + 'reportes\valorempleado.frf';
        reportes.frDBDataSet1.DataSet:=reportes.valorempleado;
        reportes.valorempleado.ParamByName('codigo').AsInteger:=nit_emp;
        reportes.valorempleado.ParamByName('fecha').AsString:=datetostr(fecha_ini.DateTime);
        reportes.valorempleado.ParamByName('fecha1').AsString:=datetostr(fecha_fin.DateTime);
        reportes.valorempleado.Open;
        if reportes.valorempleado.RecordCount= 0 then
          showmessage('No Existen Elementos Disponibles')
        else
        begin
          ipresion.Caption:= 'Reporte de Gasto Por Empleado '+ '"Vista Previa"';
          reportes.imprimir_reporte(lugar);

          end;

end;

procedure Trepempleado.ejecuta_genClick(Sender: TObject);
var     lugar:string;
begin
        reportes.referencia.Open;
        reportes.rep:=True;
        if reportes.referencia.RecordCount <> 0 then
        begin
          with DataGeneral.IBsel1 do
          begin
            Close;
            SQL.Clear;
            SQL.Add('delete from "inv$referencia"');
            Open;
            Close;
            datageneral.IBTransaction1.CommitRetaining;
          end;
        end;
        reportes.referencia.Close;
        reportes.fecha_ini:=DateToStr(fecha_ini.DateTime);
        reportes.fecha_fin:=DateToStr(fecha_fin.DateTime);
        reportes.reportr_gen;
        lugar:= frmain.wpath + 'reportes\REPORTE_VALORACION_GEN1.frf';
        reportes.frDBDataSet2.DataSet:=reportes.referencia;
        DataGeneral.IBTransaction1.CommitRetaining;
        FrMain.actualizar;
        reportes.referencia.Open;
        if reportes.referencia.RecordCount= 0 then
        begin
          showmessage('No Existen Elementos Disponibles');
        end
          else
          begin
            ipresion.Caption:= 'Reporte de Gastos Generales '+ '"Vista Previa"';
            reportes.imprimir(lugar);
          end;

end;

procedure Trepempleado.fecha_finExit(Sender: TObject);
begin
        if fecha_ini.DateTime > fecha_fin.DateTime then
          fecha_fin.DateTime:=Date;
end;

procedure Trepempleado.ejecuta_val_empClick(Sender: TObject);
var     lugar:string;
begin
        reportes.referencia.Open;
        reportes.rep:=True;
        reportes.nit_empleado:=nit_emp;
        if reportes.referencia.RecordCount <> 0 then
        begin
          with DataGeneral.IBsel1 do
          begin
          Close;
          SQL.Clear;
          SQL.Add('delete from "inv$referencia"');
          Open;
          Close;
          DataGeneral.IBTransaction1.CommitRetaining;
          end;
        end;
        reportes.referencia.Close;
        reportes.fecha_ini:=DateToStr(fecha_ini.DateTime);
        reportes.fecha_fin:=DateToStr(fecha_fin.DateTime);
        reportes.nombre_emp:=lista.Text;
        datageneral.IBTransaction1.CommitRetaining;
        reportes.empleado_gen;
        lugar:= frmain.wpath + 'reportes\REPORTE_VALORACION_EMP.frf';
        reportes.frDBDataSet2.DataSet:=reportes.referencia;
        FrMain.actualizar;
        reportes.referencia.Open;
        if reportes.referencia.RecordCount= 0 then
        begin
          showmessage('No Existen Elementos Disponibles');
          lista.ItemIndex:=-1;
          lista.SetFocus;
        end
          else
           begin
             ipresion.Caption:= 'Reporte de Gastos Por Empleado '+ '"Vista Previa"';
             reportes.imprimir(lugar);
             lista.ItemIndex:=-1;
             lista.SetFocus;
           end;

end;
end.
