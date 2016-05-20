unit UnitActivorep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, DB, IBCustomDataSet, IBQuery,
  FR_Class, FR_E_TXT, FR_E_RTF, frOLEExl, frRtfExp, FR_DSet, FR_DBSet,
  IBTable, pr_Common, pr_Classes,StrUtils, pr_TxClasses, IBSQL, DBCtrls, Gauges,Math,
  IBDatabase, Buttons,dateutils,jcldatetime, DBClient;

type


    TFrmActivos = class(TForm)
    frRtfAdvExport1: TfrRtfAdvExport;
    frOLEExcelExport1: TfrOLEExcelExport;
    frRTFExport1: TfrRTFExport;
    frTextExport1: TfrTextExport;
    Button1: TButton;
    codigo: TEdit;
    lactivo: TListBox;
    tiempo: TDateTimePicker;
    Button2: TButton;
    Edit1: TEdit;
    depreciacion: TIBQuery;
    Button3: TButton;
    frReport1: TfrReport;
    frCompositeReport1: TfrCompositeReport;
    frDBDataSet1: TfrDBDataSet;
    Button4: TButton;
    tipo: TEdit;
    placa: TEdit;
    Label1: TLabel;
    Button5: TButton;
    IBtabla: TIBQuery;
    IBllenatabla: TIBQuery;
    IBQuery1: TIBQuery;
    IBacta: TIBQuery;
    IBseccion: TIBQuery;
    empresa: TIBQuery;
    IBsucursal: TIBQuery;
    Fecha_rep: TDateTimePicker;
    barra: TGauge;
    barraprogreso: TGauge;
    IBempleado: TIBQuery;
    IBelemento: TIBQuery;
    IBconelemento: TIBQuery;
    IBconSucursal: TIBQuery;
    IBnoentregados: TIBQuery;
    Button6: TButton;
    IBentrega: TIBQuery;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    IBtraslado: TIBQuery;
    IBtrantraslado: TIBTransaction;
    IBactivos: TIBQuery;
    cancelar: TSpeedButton;
    IBactivosdepreciados: TIBQuery;
    IBactivosrep: TIBQuery;
    IBterrenos: TIBQuery;
    CDdeprecia: TClientDataSet;
    CDdepreciaclase_activo: TStringField;
    CDdepreciadescripcion: TStringField;
    CDdepreciavalor: TCurrencyField;
    IBQuery2: TIBQuery;
    IBTransaction1: TIBTransaction;
    report1: TprTxReport;
    RepCalc: TprTxReport;
    report2: TprTxReport;
    IBCon: TIBQuery;
    IBTransaction2: TIBTransaction;
    frDBDataSet2: TfrDBDataSet;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);


  private
  vDesagencia,vDeclase :string;
    { Private declarations }
  public
  cod_traslado: Integer;
  nombre_empleado,tantes,tactual: string;
  fecha_depreciacion,Tabla,tabla1: string;
  fecha_ini,fecha_fin:string;
  fecha1,fecha2 :TDate;
    procedure imprimir_rep;
    procedure clase(codigo,vcodagencia:Integer;desc,vagencia:string);
  published
    procedure imprimir_reporte(cadena: string);
    procedure ejeacta;
    procedure depreciar;
    procedure repactivos;
    procedure elementos;
    procedure acta;
    procedure totaldepreciado;
    procedure repblanco;
    procedure actno;
    procedure inserta;
    procedure actualiza;
    procedure busca;
    procedure traslado;
    procedure actdebaja;
    procedure calcula_dep;
    { Public declarations }
  end;
var
  FrmActivos: TFrmActivos;
  lugar:string;

implementation
uses unitdatamodulo,unitglobal, UnitImpresion,unitreporte, UnitPrincipal,
  UnitVistaPreliminar,unitdecomprobante, Unitprogreso, UnitDepreciacion,
  Unitbuscaactivos, UnitPantallaProgreso, UnitCalculo, UnitClase;
{$R *.dfm}

procedure TFrmActivos.imprimir_reporte(cadena: string);
begin

        FrmImpresion := TFrmImpresion.Create(self);
        frReport1.LoadFromFile(cadena);
        frCompositeReport1.DoublePass := True;
        frCompositeReport1.Reports.Clear;
        frCompositeReport1.Reports.Add(frReport1);
        frReport1.Preview := FrmImpresion.frPreview1;
        frReport1.ShowReport;
        FrmImpresion.ShowModal
end;
procedure TFrmActivos.ejeacta;
begin
end;
procedure TFrmActivos.depreciar;
var     vidautil,mes_actual,mes_a,mes_anterior,total_mes,ano1,ano2: Integer;
        placa,descripcion,fechaingreso,Clase,fechasalida,fechasalida1,control_fec: string;
        valorhistorico,dep_actual,dep_anterior,total_depreciacion,valor_libros: Variant;
        depreciacion_mes,clave_mayor1: Variant;
        a :Integer;
begin
        Tabla := '"depreciacion' + FloatToStr(Now)+ '"';
        with depreciacion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('create table ' + Tabla + ' (');
          SQL.Add('placa                 CHAR(10),');
          SQL.Add('descripcion           CHAR(200),');
          SQL.Add('fechaingreso          DATE,');
          SQL.Add('valorhistorico        NUMERIC(10,2),');
          SQL.Add('mesesactual           INTEGER,');
          SQL.Add('depreciacionactual    NUMERIC(10,2),');
          SQL.Add('depreciacioanterior   NUMERIC(10,2),');
          SQL.Add('depreciaciontotal     NUMERIC(10,2),');
          SQL.Add('mesesanterio          INTEGER,');
          SQL.Add('totalmes              INTEGER,');
          SQL.Add('valorlibros           NUMERIC(10,2),');
          SQL.Add('claseactivo           CHAR(30),');
          SQL.Add('depreciacion_mes      NUMERIC(10,2),');
          SQL.Add('clavemayor            VARCHAR(50),');
          SQL.Add('clavemayor1           INTEGER)');
          ExecSQL;
          Transaction.CommitRetaining;
          Close;
        end;
        a := DaysInAMonth(YearOfDate(tiempo.Date),MonthOfDate(tiempo.Date));
//        control_f := FormatDateTime('mm/yy',tiempo.DateTime);
        control_fec := FormatDateTime('yyyy/mm/'+IntToStr(a),tiempo.Date);// restringir el acceso de activos
        //* barra progreso
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select distinct "act$activo"."cod_activo","act$activo"."placa",');
          SQL.Add('"act$activo"."descripcion","act$activo"."fechacompra",');
          SQL.Add('"act$activo"."preciocompra","act$activo"."vidadepreciable",');
          SQL.Add('"act$clase_activo"."descripcion" as clase, "act$clase_activo"."clavemayor"');
          SQL.Add('from "act$clase_activo" ,"act$activo","act$traslado"');
          SQL.Add(' where "act$activo"."clase_activo"="act$clase_activo"."cod_clase" and');
          SQL.Add('"act$activo"."cod_activo" = "act$traslado"."cod_activo" and');
          SQL.Add('"act$traslado"."lugar" = :"lugar" and');
          SQL.Add('"act$traslado"."cod_oficina" = :"cod_oficina" ');
          SQL.Add('and "act$activo"."estado" = :"estado" and ');
          SQL.Add('"act$activo"."fechacompra" <= :"tiempo"');
          SQL.Add('and "act$activo"."esactivo" =:"esactivo"');
          //SQL.Add('and "act$activo"."placa" = :placa');// ojo
          SQL.Add('order by "act$clase_activo"."clavemayor"');
          //ParamByName('placa').AsString := '01-00515';//ojo
          ParamByName('esactivo').AsInteger := Ord(True);
          ParamByName('estado').AsString := 'A';
          ParamByName('tiempo').AsDate := StrToDate(FormatDateTime('dd/mm/yy',StrToDate(control_fec)));
          ParamByName('lugar').AsString := 'A';
          ParamByName('cod_oficina').AsInteger := FrmDepreciacion.cbagencia.ItemIndex+1;
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Titulo := 'Generando Reporte de Depreciacion';
          frmProgresos.Ejecutar;
            while not DataGeneral.IBsel.Eof do
            begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Activo No: '+IntToStr(RecNo);
            Application.ProcessMessages;
             vidautil := FieldByName('vidadepreciable').AsInteger;
             placa := FieldByName('placa').AsString;
             descripcion := FieldByName('descripcion').AsString;
             fechaingreso := DateToStr(FieldByName('fechacompra').AsDateTime);
             valorhistorico := FieldByName('preciocompra').AsCurrency;
             Clase:=FieldByName('clase').AsString;
             clave_mayor1 := FieldByName('clavemayor').AsInteger;
             fechasalida1 := DateTimeToStr(tiempo.DateTime);
             mes_anterior := no_mesant(fechaingreso,DateToStr(tiempo.DateTime));// calcula el no de meses antes del año en curso...
             mes_actual := no_meses(DateToStr(tiempo.DateTime),fechaingreso);// calcula el no de meses del año en curso..
             total_mes := mes_anterior + mes_actual;// total meses
             depreciacion_mes := valorhistorico / vidautil;// depreciacion mensual
             if total_mes >= 0 then
             begin
               if total_mes <= vidautil then
               begin
                dep_actual := mes_actual * depreciacion_mes;// depreciacion año en curso
                dep_anterior := mes_anterior * depreciacion_mes;// depreciacion a fin del año anterior
                total_depreciacion := total_mes * depreciacion_mes;// total depreciacion acumulada
                valor_libros:=valorhistorico - total_depreciacion; // valor en libros del activo a la fecha
               end
               else
               begin
                 fechasalida := obtenerfecha(fechaingreso,IntToStr(vidautil));
                 ano1 := StrToInt(FormatDateTime('yyyy',StrToDateTime(fechasalida)));
                 fechasalida1 := DateTimeToStr(tiempo.DateTime);
                 ano2 := StrToInt(FormatDateTime('yyyy',StrToDateTime(fechasalida1)));
                 if ano1 = ano2 then
                 begin
                   mes_a := StrToInt(FormatDateTime('mm',StrToDateTime(fechasalida)));
                   dep_actual := mes_a * depreciacion_mes;
                   total_depreciacion := valorhistorico;
                   dep_anterior := valorhistorico - dep_actual;
                 end
                 else
                 begin
                   dep_actual := 0;
                   dep_anterior := valorhistorico;
                 end;
                 valor_libros := 0;
                 total_depreciacion := valorhistorico;
                 end;
                 with depreciacion do
                 begin
                   Close;
                   SQL.Clear;
                   SQL.Add('insert into ' + Tabla + 'values(');
                   SQL.Add(':"placa",:"descripcion",:"fechaingreso",');
                   SQL.Add(':"valorhistorico",:"mesesactual",:"depreciacionactual",');
                   SQL.Add(':"depreciacionanterior",:"depreciaciontotal",');
                   SQL.Add(':"mesesanterio",:"totalmes",:"valorlibros",');
                   SQL.Add(':"claseactivo",:"depreciacionmes",:"clavemayor",:clavemayor1)');
                   ParamByName('placa').AsString := placa;
                   ParamByName('descripcion').AsString := descripcion;
                   ParamByName('fechaingreso').AsDate := StrToDateTime(fechaingreso);
                   ParamByName('valorhistorico').AsCurrency := SimpleRoundTo(valorhistorico,0);
                   ParamByName('mesesactual').AsInteger := mes_actual;
                   ParamByName('depreciacionactual').AsCurrency := simpleroundto(dep_actual,0);
                   ParamByName('depreciacionanterior').AsCurrency := SimpleRoundTo(dep_anterior,0);
                   ParamByName('depreciaciontotal').AsCurrency := SimpleRoundTo(total_depreciacion,0);
                   ParamByName('mesesanterio').AsInteger := mes_anterior;
                   ParamByName('totalmes').AsInteger := total_mes;
                   ParamByName('valorlibros').AsCurrency := SimpleRoundTo(valor_libros,0);
                   ParamByName('claseactivo').AsString := clase;
                   ParamByName('depreciacionmes').AsCurrency := SimpleRoundTo(depreciacion_mes,0);
                   ParamByName('clavemayor').AsString := clavemayor(DataGeneral.IBsel.FieldByName('clavemayor').AsString);
                   ParamByName('clavemayor1').AsInteger := clave_mayor1;
                   Open;
                   Close;
                   DataGeneral.IBTransaction1.CommitRetaining;
                 end;
               end;
                   DataGeneral.IBsel.Next;
                 end;

                   //******************
                  with IBterrenos do
                  begin
                  Close;
                  ParamByName('codigo').AsInteger := FrmDepreciacion.cbagencia.ItemIndex+1;
                  Open;
                  while not Eof do
                  begin
                  with depreciacion do
                  begin
                   Close;
                   SQL.Clear;
                   SQL.Add('insert into ' + Tabla + 'values(');
                   SQL.Add(':"placa",:"descripcion",:"fechaingreso",');
                   SQL.Add(':"valorhistorico",:"mesesactual",:"depreciacionactual",');
                   SQL.Add(':"depreciacionanterior",:"depreciaciontotal",');
                   SQL.Add(':"mesesanterio",:"totalmes",:"valorlibros",');
                   SQL.Add(':"claseactivo",:"depreciacionmes",:"clavemayor",:clavemayor1)');
                   ParamByName('placa').AsString := IBterrenos.FieldByName('placa').AsString;
                   ParamByName('descripcion').AsString := IBterrenos.FieldByName('descripcion').AsString;
                   ParamByName('fechaingreso').AsDate := IBterrenos.FieldByName('fecha').AsDateTime;
                   ParamByName('valorhistorico').AsCurrency := IBterrenos.FieldByName('valor').AsCurrency;
                   ParamByName('mesesactual').AsInteger := 0;
                   ParamByName('depreciacionactual').AsCurrency := 0;
                   ParamByName('depreciacionanterior').AsCurrency := 0;
                   ParamByName('depreciaciontotal').AsCurrency := 0;
                   ParamByName('mesesanterio').AsInteger := 0;
                   ParamByName('totalmes').AsInteger := 0;
                   ParamByName('valorlibros').AsCurrency := 0;
                   ParamByName('claseactivo').AsString := 'TERRENOS';
                   ParamByName('depreciacionmes').AsCurrency := 0;
                   ParamByName('clavemayor').AsString := 'TERRENOS';
                   ParamByName('clavemayor1').AsInteger :=651;
                   Open;
                   Close;
                   DataGeneral.IBTransaction1.CommitRetaining;
                 end;
                 IBterrenos.Next;
               end;
             end;
            end;       //*******************
          with depreciacion do
          begin
            SQL.Clear;
            SQL.Add('select distinct');
            SQL.Add('CLAVEMAYOR,CLAVEMAYOR1');
            SQL.Add('FROM'+Tabla);
            SQL.Add('WHERE CLAVEMAYOR1 <> 651');
            Open;
            while not Eof do
            begin
              with IBQuery1 do
              begin
                SQL.Clear;
                SQL.Add('select sum(VALORHISTORICO) AS suma');
                SQL.Add('From'+tabla);
                SQL.Add('where VALORLIBROS = 0');
                SQL.Add('AND CLAVEMAYOR = :clase');
                ParamByName('clase').AsString := depreciacion.FieldByName('CLAVEMAYOR').AsString;
                Open;
                if FieldByName('suma').AsCurrency > 0 THEN
                begin
                CDdeprecia.Append;
                CDdeprecia.FieldValues['clase_activo'] := depreciacion.FieldByName('CLAVEMAYOR1').AsString;
                CDdeprecia.FieldValues['descripcion'] :=  depreciacion.FieldByName('CLAVEMAYOR').AsString;
                CDdeprecia.FieldValues['valor'] := FieldByName('suma').AsCurrency;
                CDdeprecia.Post;
                end;
                Close;
              end;
              Next;
            end;
            Close;
          end;
//////////////************

          with depreciacion do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select * ');
            SQL.Add('from ' + Tabla + ' ');
            SQL.Add('order by' + tabla + '."CLAVEMAYOR1",'+tabla + '."CLASEACTIVO",'+tabla + '."FECHAINGRESO"');
            Open;
            depreciacion.Last;
            depreciacion.First;
            depreciacion.RecordCount;
            Close;
            Transaction.CommitRetaining;
          end;
          //Button3Click(self);
end;

procedure TFrmActivos.Button3Click(Sender: TObject);
begin
        report2.Variables.ByName['nombre'].AsString := empleados(UpperCase(FrMain.Dbalias));
        report2.Variables.ByName['fecha'].AsDateTime:=StrToDateTime(fecha_depreciacion);
        report2.Variables.ByName['actual'].AsString := tactual;
        report2.Variables.ByName['actual1'].AsString := tactual;
        report2.Variables.ByName['antes'].AsString := tantes;
        report2.Variables.ByName['empresa'].AsString := FrMain.Empresa;
        report2.Variables.ByName['nit'].AsString := FrMain.Nit;
        report2.Variables.ByName['oficina'].AsString := FrmDepreciacion.cbagencia.Text;
        if Report2.PrepareReport then
        begin
          frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
          frmVistaPreliminar.Reporte := Report2;
          frmProgresos.Cerrar;
          frmVistaPreliminar.ShowModal;
        end;
        IBQuery1.Transaction.Commit;
          with depreciacion do
          begin
            Close;
            SQL.Clear;
            SQL.Add('drop table ' + Tabla);
            ExecSQL;
            Close;
            Transaction.CommitRetaining;
          end;
end;
procedure TFrmActivos.Button4Click(Sender: TObject);
begin
        with DataGeneral.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "con$puc"."CODIGO" from "con$puc"');
          SQL.Add('where "con$puc"."CLAVE"= :"clave"');
          ParamByName('clave').AsString:=codigo.Text;
          Open;
          placa.Text := FieldByName('codigo').AsString;
          Close;
        end;
        tipo.Text := Precisarcodigo(placa.Text);
end;

procedure TFrmActivos.Button2Click(Sender: TObject);
var     a,b,i:Integer;
        aa:string;
begin
        a := StrLen(PChar(tipo.Text));
        b := 18 - a;
        aa := tipo.Text;
        for i := 1 to b do
          aa := aa + '0';
        placa.Text := aa;
        with DataGeneral.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "con$puc"."NOMBRE" from "con$puc"');
          SQL.Add('where "con$puc"."CODIGO"= :"clave"');
          ParamByName('clave').AsString:=aa;
          Open;
          codigo.Text:=FieldByName('NOMBRE').AsString;
          Close;
        end;
end;

procedure TFrmActivos.repactivos;
begin
        FrmReporte := TFrmReporte.Create(self);
        FrmReporte.Activosporseccion.Close;
        lugar := FrMain.wpath+'reportes\reporteporseccion.frf';
        frDBDataSet1.DataSet := FrmReporte.Activosporseccion;
        FrmReporte.Activosporseccion.Open;
        imprimir_reporte(lugar);
end;

procedure TFrmActivos.elementos;
begin
        FrmReporte := TFrmReporte.Create(self);
        FrmReporte.Elementos.Close;
        lugar := FrMain.wpath+'reportes\elementos.frf';
        frDBDataSet1.DataSet:=FrmReporte.Elementos;
        FrmReporte.Elementos.Open;
        imprimir_reporte(lugar);
end;

procedure TFrmActivos.acta;
begin
end;

procedure TFrmActivos.totaldepreciado;
var placa:string;
begin
        FrmReporte := TFrmReporte.Create(self);
        FrmProgreso := TFrmProgreso.Create(self);
        FrmProgreso.Caption := 'Progreso del Reporte';
        Tabla1 := '"dep' + FloatToStr(Now)+ '"';
        with depreciacion do
        begin
          SQL.Clear;
          SQL.Add('create table ' + Tabla1 + ' (');
          SQL.Add('placa                 CHAR(10),');
          SQL.Add('descripcion           CHAR(150),');
          SQL.Add('fechaingreso          DATE,');
          SQL.Add('valorhistorico        NUMERIC(10,2),');
          SQL.Add('valorlibros           NUMERIC(10,2),');
          SQL.Add('oficina               CHAR(30))');
          ExecSQL;
          Transaction.CommitRetaining;
          Close;
        end;
        with ibllenatabla do
        begin
          Open;
          Last;
          First;
          FrmProgreso.BarraProgreso.Maxvalue:=IBllenatabla.RecordCount;
          FrmProgreso.Show;
          placa := FieldByName('placa').AsString;
          while not IBllenatabla.Eof do
          begin
            if (FieldByName('vidadepreciable').AsInteger) <= StrToInt(deprecia(FieldByName('placa').AsString,'8')) then
            begin
              with depreciacion do
              begin
                Close;
                SQL.Clear;
                SQL.Add('insert into ' + Tabla1 + 'values(');
                SQL.Add(':"placa",:"descripcion",:"fechaingreso",');
                SQL.Add(':"valorhistorico",:"vidadepreciable",:"oficina")');
                ParamByName('placa').AsString:=IBllenatabla.FieldByName('placa').AsString;
                ParamByName('descripcion').AsString:=IBllenatabla.FieldByName('descripcion').AsString;;
                ParamByName('fechaingreso').AsDateTime:=IBllenatabla.FieldByName('fechacompra').AsDateTime;
                ParamByName('valorhistorico').AsCurrency:=IBllenatabla.FieldByName('preciocompra').AsCurrency;
                ParamByName('vidadepreciable').AsInteger:=IBllenatabla.FieldByName('vidadepreciable').AsInteger;
                ParamByName('oficina').AsString:=IBllenatabla.FieldByName('descripcion1').AsString;;
                Open;
                Close;
              end;
            end;
          IBllenatabla.Next;
          FrmProgreso.barraprogreso.Progress := IBllenatabla.RecNo+1;
          DataGeneral.IBTransaction1.CommitRetaining;
          end;
           Close;
          end;
          with IBQuery1 do
          begin
           Close;
           SQL.Clear;
           SQL.Add('select * from '+tabla1);
           Open;
          end;
          DataGeneral.IBTransaction1.Commit;
          lugar := FrMain.wpath+'reportes\reportedep.frf';
          frDBDataSet1.DataSet := IBQuery1;
          IBQuery1.Open;
          imprimir_reporte(lugar);
          frDBDataSet1.Free;
          IBQuery1.Close;
          IBQuery1.Free;
          with depreciacion do
          begin
           Close;
           SQL.Clear;
           SQL.Add('drop table ' + Tabla1);
           ExecSQL;
           Close;
           Transaction.CommitRetaining;
          end;
          FrmProgreso.Hide;
end;

procedure TFrmActivos.Button1Click(Sender: TObject);
var primero,segundo,codigo:Integer;
begin
        segundo := 0;
        codigo := 0;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT "inv$articulo"."cod_articulo" From  "inv$articulo"');
          Open;
          Last;
          First;
          barra.MaxValue := DataGeneral.IBsel.RecordCount;
          while not DataGeneral.IBsel.Eof do
          begin
            with DataGeneral.IBsel1 do
            begin
              Close;
              SQL.Clear;
              SQL.Add(' SELECT sum("inv$salida"."cantidad") AS suma');
              SQL.Add('FROM "inv$salida"');
              SQL.Add('WHERE ("inv$salida"."cod_articulo" = :codigo)');
              ParamByName('codigo').AsInteger:=DataGeneral.IBsel.FieldByName('cod_articulo').AsInteger;
              Open;
              primero := FieldByName('suma').AsInteger;
              Close;
              if primero >= segundo then
              begin
                segundo := primero;
                codigo := DataGeneral.IBsel.FieldByName('cod_articulo').AsInteger;
              end;
            end;
            DataGeneral.IBsel.Next;
//            FrmProgreso.BarraProgreso.Position := IBllenatabla.RecNo+1;
            barra.Progress := DataGeneral.IBsel.RecNo + 1;
          end;
        Close;
        tipo.Text := IntToStr(segundo)+'....'+IntToStr(codigo);
     end;
end;

procedure TFrmActivos.Button5Click(Sender: TObject);
var s:string;
begin
        s := DateToStr(StrToDate(FormatDateTime('yyyy/mm/dd',Fecha_rep.DateTime)));
        if StrToDate(s) <  StrToDate(FormatDateTime('yyyy/mm/dd',date)) then
        tipo.Text := FormatDateTime('dd/mm/yy',Fecha_rep.DateTime);
end;

procedure TFrmActivos.FormCreate(Sender: TObject);
begin
        Fecha_rep.DateTime := Date;
        Fecha_rep.MaxDate := StrToDate(FormatDateTime('yyyy/mm/dd',Date));
end;

procedure TFrmActivos.repblanco;
begin
        FrmReporte := TFrmReporte.Create(self);
        FrmImpresion.Caption := 'Reporte en Blanco';
        lugar := FrMain.wpath+'reportes\reporteblanco.frf';
        frDBDataSet1.DataSet := FrmReporte.empresa;
        FrmReporte.empresa.Open;
        imprimir_reporte(lugar);
end;

procedure TFrmActivos.actno;
begin
        IBnoentregados.Close;
        lugar := FrMain.wpath+'reportes\reportenoentregados.frf';
        frDBDataSet1.DataSet := IBnoentregados;
        IBnoentregados.Open;
        imprimir_reporte(lugar);
end;

procedure TFrmActivos.Button6Click(Sender: TObject);
var a:Variant;
begin
//tipo.Text := IntToStr(simpleroundto(1.2,1));
a := SimpleRoundTo(1234567.6, 0);
tipo.Text := a;
end;

procedure TFrmActivos.inserta;
var     a,b: string;
        i,c:Integer;
begin
        for i:=1 to 100 do
        begin
          b := IntToStr(i);
          c := StrLen(PChar(b));
          case c of
            1: a := 'NA-01-' + '000' + b;
            2: a := 'NA-01-' + '00' + b;
            3: a := 'NA-01-' + '0' + b;
            4: a := 'NA-01-' + b;
          end;
          with DataGeneral.IBdatos do
          begin
            Close;
            SQL.Clear;
            SQL.Add('insert into "ejemplo"');
            SQL.Add('values (');
            SQL.Add(':"cuenta",:"valor",:"fecha")');
            ParamByName('cuenta').AsString := a;
            ParamByName('valor').AsString := b;
            ParamByName('fecha').AsDateTime := now;
            Open;
            Close;
            DataGeneral.IBTransaction1.CommitRetaining;
          end;
        end;
end;

procedure TFrmActivos.Button7Click(Sender: TObject);
begin
        TRASLADO;
end;

procedure TFrmActivos.actualiza;
var a,b,c,F,G : string;
    d : Integer;
begin
        with DataGeneral.IBdatos do
        begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT *');
        SQL.Add('FROM');
        SQL.Add('"act$activo"');
        SQL.Add('WHERE');
        SQL.Add('"act$activo"."placa" LIKE :placa');
        ParamByName('placa').AsString := 'NA%';
        Open;
        while not DataGeneral.IBdatos.Eof do
        begin

          F := FieldByName('placa').AsString;
          G := LeftStr(F,9);
          a := RightStr(G,3);
          b := LeftStr(FieldByName('placa').AsString,6);
          a := '0' + a;
          c := b + a;
          d := FieldByName('cod_activo').AsInteger;

          with DataGeneral.IBsel do
          begin
          Close;
          SQL.Clear;
          SQL.Add('update "act$activo" set "act$activo"."placa" = :cuenta');
          SQL.Add('where "act$activo"."cod_activo" = :codigo');
          ParamByName('cuenta').AsString := c;
          ParamByName('codigo').AsInteger := d;
          Open;
          DataGeneral.IBTransaction1.CommitRetaining;
          Close;
          end;
          DataGeneral.IBdatos.Next;
        end;
          Close;
        end;
end;

procedure TFrmActivos.Button8Click(Sender: TObject);
begin
        actualiza;
end;

procedure TFrmActivos.busca;
var a:Integer;
begin
        with DataGeneral.IBdatos do
        begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT *');
        SQL.Add('FROM');
        SQL.Add('"act$activo"');
        SQL.Add('WHERE');
        SQL.Add('"act$activo"."placa" LIKE :placa');
        ParamByName('placa').AsString := 'NA%';
        Open;
        while not DataGeneral.IBdatos.Eof do
        begin
          a := StrLen(PChar(FieldByName('placa').AsString));
          if a <> 10 then
          ShowMessage(FieldByName('placa').AsString);
          DataGeneral.IBdatos.Next;
        end;
          Close;
        end;
end;

procedure TFrmActivos.Button9Click(Sender: TObject);
begin
        busca;
end;

procedure TFrmActivos.Button10Click(Sender: TObject);
begin
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "ejemplo"."fecha" from "ejemplo"');
          SQL.Add('where "ejemplo"."valor" = 100');
          Open;
          ShowMessage(DateToStr(FieldByName('fecha').AsDateTime));
          Close;
          end;
end;
procedure TFrmActivos.traslado;
var tablat: string;
        placa,descripcion,fechareintegro:string;
        tipotraslado,oficinaactual:string;
        oficinaanterior,seccionactual,seccionanterior:string;
        empactual,empanterior,fechatraslado,motivo:string;
        cod_traslado,cod_activo : Integer;
begin
        Tablat := '"traslado' + FloatToStr(Now)+ '"';
        with IBtraslado do
        begin
          SQL.Clear;
          SQL.Add('create table ' + Tablat + ' (');
          SQL.Add('placa                 CHAR(10),');
          SQL.Add('descripcion           CHAR(100),');
          SQL.Add('fechareintegro        VARCHAR(20),');
          SQL.Add('notraslado            INTEGER,');
          SQL.Add('tipotraslado          VARCHAR(20),');
          SQL.Add('oficinaactual         VARCHAR(20),');
          SQL.Add('oficinaanterior       VARCHAR(20),');
          SQL.Add('seccionactual         VARCHAR(20),');
          SQL.Add('seccionanterior       VARCHAR(20),');
          SQL.Add('empactual             VARCHAR(70),');
          SQL.Add('empanterior           VARCHAR(70),');
          SQL.Add('fechatraslado         DATE,');
          SQL.Add('motivo                VARCHAR(70))');
          ExecSQL;
          Transaction.Commit;
          Close;
        end;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"act$traslado"."cod_traslado"');
          SQL.Add('FROM');
          SQL.Add('"act$traslado"');
          SQL.Add('WHERE');
          SQL.Add('("act$traslado"."identificador" = :identificador) AND');
          SQL.Add('("act$traslado"."lugar" = :lugar) AND');
          SQL.Add('("act$traslado"."fecha_traslado" <= :fechafin) AND');
          SQL.Add('("act$traslado"."fecha_traslado" >= :fechaini)');
          ParamByName('fechafin').AsDate := StrToDate(fecha_fin);
          ParamByName('fechaini').AsDate := StrToDate(fecha_ini);
          ParamByName('lugar').AsString := 'A';
          ParamByName('identificador').AsString := 'A';
          Open;
              if RecordCount = 0 then
                 begin
                 MessageDlg('No Existen Traslados',mtInformation,[mbOK],0);
                 with ibtraslado do
                 begin
                  Close;
                  SQL.Clear;
                  SQL.Add('drop table ' + Tablat);
                  ExecSQL;
                  Close;
                  Transaction.Commit;
                 end;
                 Exit;
              end;

          while not DataGeneral.IBsel.Eof do
          begin
            cod_traslado:= FieldByName('cod_traslado').AsInteger;
            with DataGeneral.IBsel1 do
            begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT DISTINCT');
            SQL.Add('"act$traslado"."fecha_traslado",');
            SQL.Add('"act$traslado"."cod_activo",');
            SQL.Add('"act$traslado"."tipo_traslado",');
            SQL.Add('"act$traslado"."forma_traslado",');
            SQL.Add('"act$traslado"."motivo",');
            SQL.Add('"inv$empleado"."nombre","inv$empleado"."apellido",');
            SQL.Add('"act$activo"."descripcion",');
            SQL.Add('"act$activo"."placa",');
            SQL.Add('"inv$dependencia"."nombre" AS "dependencia",');
            SQL.Add('"act$traslado"."cod_traslado",');
            SQL.Add('"act$traslado"."fecha_reintegro",');
            SQL.Add('"Inv$Agencia"."descripcion" AS "oficina"');
            SQL.Add('FROM');
            SQL.Add('"Inv$Agencia",');
            SQL.Add('"act$activo",');
            SQL.Add('"inv$dependencia"');
            SQL.Add('INNER JOIN "act$traslado" ON ("inv$dependencia"."cod_dependencia" = "act$traslado"."cod_seccion"),');
            SQL.Add('"inv$empleado"');
            SQL.Add('WHERE');
            SQL.Add('("Inv$Agencia"."cod_agencia" = "act$traslado"."cod_oficina") AND');
            SQL.Add('("act$activo"."cod_activo" = "act$traslado"."cod_activo") AND');
            SQL.Add('("act$traslado"."nit_empleado" = "inv$empleado"."nit") AND');
            SQL.Add('("act$traslado"."cod_traslado" = :cod)');
            ParamByName('cod').AsInteger := cod_traslado;
            Open;
            fechatraslado := FieldByName('fecha_traslado').AsString;
            tipotraslado := FieldByName('tipo_traslado').AsString;
            motivo := FieldByName('motivo').AsString;
            empactual := FieldByName('nombre').AsString + ' ' + FieldByName('apellido').AsString ;
            descripcion := FieldByName('descripcion').AsString;
            placa := FieldByName('placa').AsString;
            seccionactual := FieldByName('dependencia').AsString;
            fechareintegro := FieldByName('fecha_reintegro').AsString;
            oficinaactual := FieldByName('oficina').AsString;
            cod_activo := FieldByName('cod_activo').AsInteger;
            Close;
            end;
            IBactivos.Close;
            IBactivos.ParamByName('cod_activo').AsInteger := cod_activo;
            IBactivos.Open;
            empanterior := IBactivos.FieldByName('nombre').AsString;
            oficinaanterior := IBactivos.FieldByName('oficina').AsString;
            seccionanterior := IBactivos.FieldByName('seccion').AsString;
            IBactivos.Close;
            if fechareintegro = '' then
               fechareintegro := 'INDEFINIDA';
            with ibtraslado do
            begin
              if Transaction.Active then
                 Transaction.Commit;
              Transaction.StartTransaction;
              Close;
              SQL.Clear;
              SQL.Add('insert into ' + Tablat + 'values(');
              SQL.Add(':"placa",:"descripcion",:"fechareintegro",:"notraslado",');
              SQL.Add(':"tipotraslado",:"oficinaactual",:"oficinaanterior",');
              SQL.Add(':"seccionactual",:"seccionanterior",:"empactual",');
              SQL.Add(':"empanterior",:"fechatraslado",:"motivo")');
              ParamByName('placa').AsString := placa;
              ParamByName('descripcion').AsString := descripcion;
              ParamByName('fechareintegro').AsString := fechareintegro;
              ParamByName('notraslado').AsInteger := cod_traslado;
              ParamByName('tipotraslado').AsString := tipotraslado;
              ParamByName('oficinaactual').AsString := oficinaactual;
              ParamByName('oficinaanterior').AsString := oficinaanterior;
              ParamByName('seccionactual').AsString := seccionactual;
              ParamByName('seccionanterior').AsString := seccionanterior;
              ParamByName('empactual').AsString := empactual;
              ParamByName('empanterior').AsString := empanterior;
              ParamByName('fechatraslado').AsString := fechatraslado;
              ParamByName('motivo').AsString := motivo;
              Open;
              Close;
              Transaction.Commit;
              end;
            DataGeneral.IBsel.Next;
          end;
         Close;
        end;
        with IBtraslado do
        begin
        Close;
        if Transaction.Active then
           Transaction.Commit;
        Transaction.StartTransaction;
        SQL.Clear;
        SQL.Add('select * from '+tablat);
        Open;
        end;
          lugar := FrMain.wpath+'reportes\reportetraslado.frf';
          frDBDataSet1.DataSet := ibtraslado;
          ibtraslado.Open;
          imprimir_reporte(lugar);
          frDBDataSet1.Free;
          ibtraslado.Close;
          with ibtraslado do
          begin
           Close;
           SQL.Clear;
           SQL.Add('drop table ' + Tablat);
           ExecSQL;
           Close;
           Transaction.Commit;
          end;
          fecha_ini := '';
          fecha_fin := '';
end;

procedure TFrmActivos.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if fecha_ini <> '' then
        begin
          frReport1.Dictionary.Variables['fecha1']:=StrToDate(fecha_ini);
          frReport1.Dictionary.Variables['fecha2']:=StrToDate(fecha_fin);
        end;
        if ParName = 'vdescripcion' then
           ParValue := vDeclase;
        if ParName = 'vagencia' then
           ParValue := vDesagencia;
end;

procedure TFrmActivos.actdebaja;
begin
        IBactivosdepreciados.Close;
        lugar := FrMain.wpath+'reportes\reportedep1.frf';
        frDBDataSet1.DataSet := IBactivosdepreciados;
        IBactivosdepreciados.ParamByName('fecha').AsString := fecha_ini;
        IBactivosdepreciados.ParamByName('fecha1').AsString := fecha_fin;
        IBactivosdepreciados.Open;
        imprimir_reporte(lugar);
end;

procedure TFrmActivos.calcula_dep;
var     vidautil: Integer;
        placa,descripcion,fechaingreso,Clase,b: string;
        valorhistorico,dep_actual: Variant;
        depreciacion_mes,clave_mayor1: Variant;
        a,numero_meses :Integer;
        fecha_salida, fecha_respaldo :TDate;
begin
        a := DaysInAMonth(YearOfDate(fecha2),MonthOfDate(fecha2));
        fecha_respaldo := StrToDate(FormatDateTime('yyyy/mm/01',fecha2));
        fecha1 := StrToDate(FormatDateTime('yyyy/mm/01',fecha1));
        fecha2 := StrToDate(FormatDateTime('yyyy/mm/'+IntToStr(a),fecha2));
        Tabla := '"depreciacion' + FloatToStr(Now)+ '"';
        with depreciacion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('create table ' + Tabla + ' (');
          SQL.Add('placa                 CHAR(10),');
          SQL.Add('descripcion           CHAR(200),');
          SQL.Add('fechaingreso          DATE,');
          SQL.Add('valorhistorico        NUMERIC(10,2),');
          SQL.Add('mesesactual           INTEGER,');
          SQL.Add('depreciacionactual    NUMERIC(10,2),');
          SQL.Add('depreciacioanterior   NUMERIC(10,2),');
          SQL.Add('depreciaciontotal     NUMERIC(10,2),');
          SQL.Add('mesesanterio          INTEGER,');
          SQL.Add('totalmes              INTEGER,');
          SQL.Add('valorlibros           NUMERIC(10,2),');
          SQL.Add('claseactivo           CHAR(30),');
          SQL.Add('depreciacion_mes      NUMERIC(10,2),');
          SQL.Add('clavemayor            VARCHAR(50),');
          SQL.Add('clavemayor1           INTEGER)');
          ExecSQL;
          Transaction.CommitRetaining;
          Close;
        end;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select distinct "act$activo"."cod_activo","act$activo"."placa",');
          SQL.Add('"act$activo"."descripcion","act$activo"."fechacompra",');
          SQL.Add('"act$activo"."preciocompra","act$activo"."vidadepreciable",');
          SQL.Add('"act$clase_activo"."descripcion" as clase, "act$clase_activo"."clavemayor"');
          SQL.Add('from "act$clase_activo" ,"act$activo","act$traslado"');
          SQL.Add(' where "act$activo"."clase_activo"="act$clase_activo"."cod_clase" and');
          SQL.Add('"act$activo"."cod_activo" = "act$traslado"."cod_activo" and');
          SQL.Add('"act$traslado"."lugar" = :"lugar" and');
          SQL.Add('"act$traslado"."cod_oficina" = :"cod_oficina" ');
          SQL.Add('and "act$activo"."estado" = :"estado" ');
          SQL.Add('and "act$activo"."esactivo" =:"esactivo"');
          SQL.Add('order by "act$clase_activo"."clavemayor"');
          ParamByName('esactivo').AsInteger := Ord(True);
          ParamByName('estado').AsString := 'A';
          ParamByName('lugar').AsString := 'A';
          ParamByName('cod_oficina').AsInteger := FrmCalculo.Agencia.KeyValue;
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Titulo := 'Generando Reporte de Depreciacion';
          frmProgresos.Ejecutar;
            while not DataGeneral.IBsel.Eof do
            begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Activo No: '+IntToStr(RecNo);
            Application.ProcessMessages;
             vidautil := FieldByName('vidadepreciable').AsInteger;
             placa := FieldByName('placa').AsString;
             descripcion := FieldByName('descripcion').AsString;
             fechaingreso := DateToStr(FieldByName('fechacompra').AsDateTime);
             valorhistorico := FieldByName('preciocompra').AsCurrency;
             Clase:=FieldByName('clase').AsString;
             clave_mayor1 := FieldByName('clavemayor').AsInteger;
             depreciacion_mes := valorhistorico / vidautil;// depreciacion mensual
             fecha_salida := StrToDate(obtenerfecha(fechaingreso,IntToStr(vidautil)));
             b := IntToStr(DaysInAMonth(YearOfDate(fecha_salida),MonthOfDate(fecha_salida)));
             fecha_salida := StrToDate(FormatDateTime('yyyy/mm/'+b,fecha_salida));
             if fecha_salida >= fecha1 then
             begin
             if fecha_salida < fecha2 then
                numero_meses := MonthsBetween(Fecha1,fecha_salida + 13)
             else
                numero_meses := MonthsBetween(Fecha1,fecha2+15);
             if fecha_respaldo = fecha1 then
                numero_meses := 1;
             dep_actual := depreciacion_mes * numero_meses;
                 with depreciacion do
                 begin
                   Close;
                   SQL.Clear;
                   SQL.Add('insert into ' + Tabla + 'values(');
                   SQL.Add(':"placa",:"descripcion",:"fechaingreso",');
                   SQL.Add(':"valorhistorico",:"mesesactual",:"depreciacionactual",');
                   SQL.Add(':"depreciacionanterior",:"depreciaciontotal",');
                   SQL.Add(':"mesesanterio",:"totalmes",:"valorlibros",');
                   SQL.Add(':"claseactivo",:"depreciacionmes",:"clavemayor",:clavemayor1)');
                   ParamByName('placa').AsString := placa;
                   ParamByName('descripcion').AsString := descripcion;
                   ParamByName('fechaingreso').AsDate := StrToDateTime(fechaingreso);
                   ParamByName('valorhistorico').AsCurrency := SimpleRoundTo(valorhistorico,0);
                   ParamByName('mesesactual').AsInteger := numero_meses;
                   ParamByName('depreciacionactual').AsCurrency := SimpleRoundTo(dep_actual,0);
                   ParamByName('depreciacionanterior').AsCurrency := 0;
                   ParamByName('depreciaciontotal').AsCurrency := 0;
                   ParamByName('mesesanterio').AsInteger := 0;
                   ParamByName('totalmes').AsInteger := 0;
                   ParamByName('valorlibros').AsCurrency := 0;
                   ParamByName('claseactivo').AsString := clase;
                   ParamByName('depreciacionmes').AsCurrency := 0;
                   ParamByName('clavemayor').AsString := clavemayor(DataGeneral.IBsel.FieldByName('clavemayor').AsString);
                   ParamByName('clavemayor1').AsInteger := clave_mayor1;
                   Open;
                   Close;
                   DataGeneral.IBTransaction1.CommitRetaining;
                 end;
               end;
                   DataGeneral.IBsel.Next;
                 end;
             end;
                  {with IBterrenos do
                  begin
                    Close;
                    ParamByName('codigo').AsInteger := FrmDepreciacion.cbagencia.ItemIndex+1;
                    Open;
                    while not Eof do
                    begin
                      with depreciacion do
                      begin
                        Close;
                        SQL.Clear;
                        SQL.Add('insert into ' + Tabla + 'values(');
                        SQL.Add(':"placa",:"descripcion",:"fechaingreso",');
                        SQL.Add(':"valorhistorico",:"mesesactual",:"depreciacionactual",');
                        SQL.Add(':"depreciacionanterior",:"depreciaciontotal",');
                        SQL.Add(':"mesesanterio",:"totalmes",:"valorlibros",');
                        SQL.Add(':"claseactivo",:"depreciacionmes",:"clavemayor",:clavemayor1)');
                        ParamByName('placa').AsString := IBterrenos.FieldByName('placa').AsString;
                        ParamByName('descripcion').AsString := IBterrenos.FieldByName('descripcion').AsString;
                        ParamByName('fechaingreso').AsDate := IBterrenos.FieldByName('fecha').AsDateTime;
                        ParamByName('valorhistorico').AsCurrency := IBterrenos.FieldByName('valor').AsCurrency;
                        ParamByName('mesesactual').AsInteger := 0;
                        ParamByName('depreciacionactual').AsCurrency := 0;
                        ParamByName('depreciacionanterior').AsCurrency := 0;
                        ParamByName('depreciaciontotal').AsCurrency := 0;
                        ParamByName('mesesanterio').AsInteger := 0;
                        ParamByName('totalmes').AsInteger := 0;
                        ParamByName('valorlibros').AsCurrency := 0;
                        ParamByName('claseactivo').AsString := 'TERRENOS';
                        ParamByName('depreciacionmes').AsCurrency := 0;
                        ParamByName('clavemayor').AsString := 'TERRENOS';
                        ParamByName('clavemayor1').AsInteger :=651;
                        Open;
                        Close;
                        DataGeneral.IBTransaction1.CommitRetaining;
                     end;
                     IBterrenos.Next;
                   end;
              end;  }
          frmProgresos.Cerrar;
          with depreciacion do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select * ');
            SQL.Add('from ' + Tabla + ' ');
            SQL.Add('order by' + tabla + '."CLAVEMAYOR1",'+tabla + '."CLASEACTIVO",'+tabla + '."FECHAINGRESO"');
            Open;
            depreciacion.Last;
            depreciacion.First;
            depreciacion.RecordCount;
            Close;
            Transaction.CommitRetaining;
          end;
          imprimir_rep;


end;

procedure TFrmActivos.imprimir_rep;
begin
        RepCalc.Variables.ByName['nombre'].AsString := empleados(UpperCase(FrMain.Dbalias));
        RepCalc.Variables.ByName['fecha'].AsDateTime:=fecha1;
        RepCalc.Variables.ByName['fecha1'].AsDateTime:=fecha2;
        RepCalc.Variables.ByName['actual'].AsString := tactual;
        RepCalc.Variables.ByName['actual1'].AsString := tactual;
        RepCalc.Variables.ByName['antes'].AsString := tantes;
        RepCalc.Variables.ByName['empresa'].AsString := FrMain.Empresa;
        RepCalc.Variables.ByName['nit'].AsString := FrMain.Nit;
        RepCalc.Variables.ByName['oficina'].AsString := FrmCalculo.Agencia.Text;//FrmDepreciacion.cbagencia.Text;
        if RepCalc.PrepareReport then
        begin
          frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
          frmVistaPreliminar.Reporte := RepCalc;
          frmProgresos.Cerrar;
          frmVistaPreliminar.ShowModal;
        end;
        IBQuery1.Transaction.Commit;
          with depreciacion do
          begin
            Close;
            SQL.Clear;
            SQL.Add('drop table ' + Tabla);
            ExecSQL;
            Close;
            Transaction.CommitRetaining;
          end;

end;

procedure TFrmActivos.clase(codigo,vcodagencia:Integer;desc,vagencia:string);
begin
        vDesagencia := desc;
        vDeclase := vagencia;
        IBCon.Close;
        IBCon.ParamByName('codigo').AsInteger := codigo;
        IBCon.ParamByName('OFICINA').AsInteger := vcodagencia;
        IBCon.Open;
//        frDBDataSet1.DataSet := IBCon;
        IBCon.Last;
//        ShowMessage(IntToStr(IBCon.RecordCount));
        imprimir_reporte(FrMain.wpath + '\reportes\repclase.frf');

end;

end.

