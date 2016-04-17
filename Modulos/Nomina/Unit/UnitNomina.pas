unit UnitNomina;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvTypedEdit, JvEdit, DB, IBCustomDataSet, IBQuery,
  FR_DSet, FR_DBSet, FR_Class, IBDatabase,Math, JvSpecialProgress,
  pr_Common, pr_TxClasses, DBClient, JclDateTime, frOLEExl, frexpimg,
  frRtfExp, DateUtils, DataSetToExcel;

type
  TFrmNomina = class(TForm)
    Button1: TButton;
    Button2: TButton;
    nomi: TJvCurrencyEdit;
    frReport1: TfrReport;
    frCompositeReport1: TfrCompositeReport;
    frDBDataSet1: TfrDBDataSet;
    IBempresa: TIBQuery;
    IBnomina: TIBQuery;
    IBfondos: TIBQuery;
    IBaportes: TIBQuery;
    IBfechanomina: TIBQuery;
    frDBDataSet2: TfrDBDataSet;
    frDBDataSet3: TfrDBDataSet;
    IBtiponomina: TIBQuery;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    IBvacaciones: TIBQuery;
    Bara: TJvSpecialProgress;
    IBQuery2: TIBQuery;
    IBcausacion: TIBQuery;
    IBtabla: TIBQuery;
    nit: TJvIntegerEdit;
    IBobligaciones: TIBQuery;
    IBreportes: TIBQuery;
    Ibriesgos: TIBQuery;
    IBsalud: TIBQuery;
    CDtabla: TClientDataSet;
    CDtablanombre: TStringField;
    CDtablasueldo: TCurrencyField;
    CDtablanit: TIntegerField;
    CDtablaeps: TStringField;
    CDtablaarp: TStringField;
    CDtablaafp: TStringField;
    CDtablafecha: TDateField;
    CDtablacuenta: TIntegerField;
    IBinforme: TIBQuery;
    CDtablanomina: TStringField;
    CDtablatiponomina: TIntegerField;
    CDhoras: TClientDataSet;
    CDhorasnombre: TStringField;
    CDhorasdiurno: TCurrencyField;
    CDhorasfectivo: TCurrencyField;
    CDhorasdominical: TCurrencyField;
    CDhorasbasico: TCurrencyField;
    IBconsolidadas: TIBQuery;
    CDPago: TClientDataSet;
    CDPagonombres: TStringField;
    CDPagovalor: TCurrencyField;
    CDPagocedula: TStringField;
    CDhora: TClientDataSet;
    CDhoranombres: TStringField;
    CDhorahdiurna: TCurrencyField;
    CDhoravdiurna: TCurrencyField;
    CDhorahfestivo: TCurrencyField;
    CDhoravfestivo: TCurrencyField;
    CDhorahdominical: TCurrencyField;
    CDhoravdominical: TCurrencyField;
    CDhorahnocturno: TCurrencyField;
    CDhoravnocturno: TCurrencyField;
    CDPagoretefuente: TCurrencyField;
    CDPagocuenta: TStringField;
    CDhoravalorn: TCurrencyField;
    IBQuery3: TIBQuery;
    frDBDataSet4: TfrDBDataSet;
    IBInteres: TIBQuery;
    frDBDataSet5: TfrDBDataSet;
    frRtfAdvExport1: TfrRtfAdvExport;
    frTIFFExport1: TfrTIFFExport;
    frOLEExcelExport1: TfrOLEExcelExport;
    IBpension: TIBQuery;
    frDBpension: TfrDBDataSet;
    CDhorahoraord: TCurrencyField;
    CDhoravhoraord: TCurrencyField;
    IBNomina1: TIBQuery;
    CDobligacion: TClientDataSet;
    CDobligacionnombre: TStringField;
    CDobligacionsueldo: TCurrencyField;
    CDobligacionviaticos: TCurrencyField;
    CDobligacionatransporte: TCurrencyField;
    CDobligacionpantiguedad: TCurrencyField;
    CDobligacionpvacacion: TCurrencyField;
    CDobligacionpnavidad: TCurrencyField;
    CDobligacionpservicios: TCurrencyField;
    CDobligacionvacaciones: TCurrencyField;
    CDobligacionbonificacion: TCurrencyField;
    CDobligacionsalud: TCurrencyField;
    CDobligacionpension: TCurrencyField;
    CDobligacionfsp: TCurrencyField;
    CDobligacionfspretefuente: TCurrencyField;
    CDobligacionint_cesantias: TCurrencyField;
    CDobligacioncesantias: TCurrencyField;
    IBcalObligacion: TIBQuery;
    IBTransaction2: TIBTransaction;
    CDobligacionhoras: TCurrencyField;
    CDobligacionnit: TIntegerField;
    frDBDataSet6: TfrDBDataSet;
    CDobligaciongrep: TCurrencyField;
    CDobligacionapension: TCurrencyField;
    CDhorahotra: TCurrencyField;
    CDhoravotra: TCurrencyField;
    frTIFFExport2: TfrTIFFExport;
    CDhorahorad: TCurrencyField;
    IB360: TIBQuery;
    frDB360: TfrDBDataSet;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure FormCreate(Sender: TObject);
  private
    codigo_general :Integer;

    { Private declarations }
  public
  nit_empleado :Integer;
  cod_inicio,cod_fin :Integer;
  nomina_ini,nomina_fin :Integer;
  ano_obligacion :Integer;
  _sTipoN :String;
    procedure realizanomina;
    procedure actfondo;
    procedure actdeduccion(opcion:Smallint);
    procedure imprimir_reporte(cadena:string);
    procedure reporteindividual;
    procedure primas;
    procedure vacaciones;
    procedure navidad;
    procedure obligaciones;
    procedure descuentos;
    procedure repdian;
    procedure prestaciones;
    procedure repgeneral;
    procedure consolidada;
    procedure pagoprima;
    function buscanombre(nit: integer): string;
    procedure horaextra1;
    function formato(valor: Currency): currency;
    procedure pnavidad;
    procedure extrae_horas;
    function busca_mes(nit:integer): boolean;
    function busca_sueldo(sueldo:Currency;nit:integer): boolean;
    function valor_real(nit,opcion: Integer;sueldobasico:currency): currency;
    procedure Pago_interes;
    procedure pensiones;
    function ExNomina(opcion, ano, Nit: integer): currency;
    { Public declarations }
  end;

var
  FrmNomina: TFrmNomina;

implementation
uses unitglobal,UnitQuerys,Unitdatamodulo, UnitImpresion, Unitprogreso,
  UnitPrincipal, UnitCartera, UnitPantallaProgreso, UnitdataQuerys,
  UnitRecuperaHoras;

{$R *.dfm}

procedure TFrmNomina.realizanomina;
var     nit,tipo_denomina :Integer;
        valor_retefuente :Currency;
        valor_libranza,valor_total : Currency;
begin
        FrmCartera := TFrmCartera.Create(self);
        tipo_denomina := buscanomina(dataquerys.IBselecion);
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Add('select "nom$empleado"."numero_cuenta","nom$empleado"."nitempleado","nom$empleado"."tipo_nomina" from "nom$empleado"');
         // SQL.Add('where "nom$empleado"."nitempleado" = 1094575537');//OJO QUITRA
          Open;
          Last;
          First;
          FrmProgresos := TFrmProgresos.Create(self);
          frmProgresos.Titulo := 'Espere Un Momento por Favor.   Realizando Nomina';
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not DataQuerys.IBdatos.Eof do
          begin
            FrmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Empleado No : '+IntToStr(RecNo);
            Application.ProcessMessages;
            nit := FieldByName('nitempleado').AsInteger;
            valor_total := descuento(DataQuerys.IBaportes,nit,2)+ horaextra(DataQuerys.IBaportes,nit);
            valor_retefuente := retefuente(DataQuerys.IBaportes,nit,1,valor_total);
            //Validar para el proceso de Libranzas en las oficinas
//            if FieldByName('tipo_nomina').AsInteger in [10,20,30,40,50,60] then // provicional
            if FieldByName('numero_cuenta').AsInteger <> 0 then
               valor_libranza := FrmCartera.saldocredito(nit)
            else
               valor_libranza := FrmCartera.saldocreditoAg(nit);
              with DataQuerys.IBingresa do
              begin
                Close;
                SQL.Clear;
                SQL.Add('insert into "nom$nomina"');
                SQL.Add('Values (');
                SQL.Add(':codigo_nomina,:nit_empleado,:sueldo_basico,');
                SQL.Add(':dias_trabajados,:total_basico,:horas_extras,');
                SQL.Add(':transporte,:total_devengado,:libranza,');
                SQL.Add(':cporcobrar,:fsp,:retefuente,:salud,');
                SQL.Add(':pension,:sueldoneto,:codigo_salud,:codigo_pension,:ibc,:ap_pension)');
                ParamByName('codigo_nomina').AsInteger := buscanomina(dataquerys.IBselecion);
                ParamByName('nit_empleado').AsInteger := nit;
                ParamByName('sueldo_basico').AsCurrency := descuento(DataQuerys.IBselecion,nit,3);
                ParamByName('dias_trabajados').AsCurrency := (30 - descuento(DataQuerys.IBselecion,nit,1));
                ParamByName('total_basico').AsCurrency := descuento(DataQuerys.IBselecion,nit,2);
                ParamByName('horas_extras').AsCurrency := horaextra(DataQuerys.IBselecion,nit);
                ParamByName('transporte').AsCurrency := SimpleRoundTo(aux_transporte(DataQuerys.IBselecion,nit,tipo_denomina),0);
                ParamByName('total_devengado').AsCurrency := descuento(DataQuerys.IBselecion,nit,2)+ horaextra(DataQuerys.IBselecion,nit);
                ParamByName('libranza').AsCurrency := valor_libranza;
                ParamByName('cporcobrar').AsCurrency := cobro(DataQuerys.IBselecion,nit);
                ParamByName('fsp').AsCurrency := SimpleRoundTo(fsp(DataQuerys.IBselecion,nit),0);
                ParamByName('retefuente').AsCurrency := SimpleRoundTo(valor_retefuente,0);
                ParamByName('salud').AsCurrency := SimpleRoundTo(deduccion(DataQuerys.IBselecion,100,nit),0);
                ParamByName('pension').AsCurrency := SimpleRoundTo(deduccion(DataQuerys.IBselecion,200,nit),0);
                ParamByName('sueldoneto').AsCurrency := SimpleRoundTo(aux_transporte(DataQuerys.IBselecion,nit,tipo_denomina),0) + SimpleRoundTo((descuento(DataQuerys.IBselecion,nit,2)+
                horaextra(DataQuerys.IBselecion,nit))- (fsp(DataQuerys.IBselecion,nit) + deduccion(DataQuerys.IBselecion,100,nit)+
                deduccion(DataQuerys.IBselecion,200,nit)+valor_retefuente+cobro(DataQuerys.IBselecion,nit)) - valor_libranza,0) - pension(nit,tipo_denomina);
                ParamByName('codigo_salud').AsInteger := buscacodigopuc(DataQuerys.IBselecion,1,nit);
                ParamByName('codigo_pension').AsInteger := buscacodigopuc(DataQuerys.IBselecion,2,nit);
                ParamByName('ibc').AsCurrency := ibc(DataQuerys.IBselecion,nit);
                ParamByName('ap_pension').AsCurrency := pension(nit,tipo_denomina);
                Open;
                Close;
                Transaction.CommitRetaining;
              end;
                DataQuerys.IBdatos.Next;
            end;
            Close;
            DataQuerys.IBingresa.Transaction.Commit;
            frmProgresos.Cerrar;
            MessageDlg('Nomina Realizada con Exito !!!',mtInformation,[mbok],0);
          end;

end;

procedure TFrmNomina.Button2Click(Sender: TObject);
begin
        realizanomina;
end;

procedure TFrmNomina.actfondo;
var     tipo_nomina,cod_nomina :Integer;
        total :Currency;
begin
        cod_nomina := buscanomina(DataQuerys.IBselecion);
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('select "nom$tiponomina"."codigo"');
          SQL.Add('from "nom$tiponomina"');
          Open;
          while not Eof do
          begin
            tipo_nomina := FieldByName('codigo').AsInteger;
            with DataQuerys.IBingresa do
            begin
              Close;
              verificatransaccion(DataQuerys.IBingresa);
              SQL.Clear;
              SQL.Add('SELECT');
              SQL.Add('sum("nom$nomina"."ibc") AS total,'); // cambio para parafiscales
              SQL.Add('SUM("nom$nomina"."horas_extras") AS horas');
              SQL.Add('FROM');
              SQL.Add('"nom$empleado"');
              SQL.Add('INNER JOIN "nom$nomina" ON ("nom$empleado"."nitempleado" = "nom$nomina"."nit_empleado")');
              SQL.Add('WHERE');
              SQL.Add('("nom$empleado"."tipo_nomina" = :tiponomina)');
              SQL.Add('and ( "nom$nomina"."codigo_nomina" = :cod_nomina)');
              ParamByName('tiponomina').AsInteger := tipo_nomina;
              ParamByName('cod_nomina').AsInteger := cod_nomina;
              Open;
              total := FieldByName('total').AsCurrency;// + FieldByName('horas').AsCurrency;
              Close;
                with DataQuerys.IBaportes do
                begin
                  Close;
                  verificatransaccion(DataQuerys.IBaportes);
                  SQL.Clear;
                  SQL.Add('select "nom$aportes"."nit",');
                  SQL.Add('"nom$aportes"."descripcion",');
                  SQL.Add('"nom$aportes"."porcentaje",');
                  SQL.Add('"nom$aportes"."codigopuc"');
                  SQL.Add('from "nom$aportes"');
                  Open;
                  while not Eof do
                  begin
                    with DataQuerys.IBdatos do
                    begin
                      Close;
                      verificatransaccion(DataQuerys.IBdatos);
                      SQL.Clear;
                      SQL.Add('insert into "nom$fondos"');
                      SQL.Add('values (');
                      SQL.Add(':codigopuc,:deduccion,:descripcion,');
                      SQL.Add(':cod_nomina,:valor_salud,:fsp,:tipo_nomina,:valor_pension)');
                      ParamByName('codigopuc').AsInteger := DataQuerys.IBaportes.FieldByName('codigopuc').AsInteger;
                      ParamByName('deduccion').AsInteger := 0;
                      if (tipo_nomina = 50) and (DataQuerys.IBaportes.FieldByName('codigopuc').AsInteger = 5) then
                         ParamByName('descripcion').AsString := 'CONFACESAR'
                      else
                         ParamByName('descripcion').AsString := DataQuerys.IBaportes.FieldByName('descripcion').AsString;
                      ParamByName('cod_nomina').AsInteger := cod_nomina;
                      ParamByName('valor_salud').AsCurrency := SimpleRoundTo(total * (DataQuerys.IBaportes.FieldByName('porcentaje').AsCurrency / 100),0);
                      ParamByName('fsp').AsCurrency := 0;
                      ParamByName('tipo_nomina').AsInteger := tipo_nomina;
                      ParamByName('valor_pension').AsCurrency := 0;
                      Open;
                      Close;
                      Transaction.Commit;
                    end;
                    Next;
                  end;
                Close;
                end;
            end;
           DataQuerys.IBselecion.Next;
          end;
          Close;
          end;
end;

procedure TFrmNomina.actdeduccion(opcion:Smallint);
var     tipo_nomina,cod_nomina,codigopuc :Integer;
        descripcion :string;
begin
        cod_nomina := buscanomina(DataQuerys.IBselecion);
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('select "nom$tiponomina"."codigo"');
          SQL.Add('from "nom$tiponomina"');
          Open;
          while not Eof do
          begin
            tipo_nomina := FieldByName('codigo').AsInteger;
            with DataQuerys.IBdatos do
            begin
              Close;
              verificatransaccion(DataQuerys.IBdatos);
              SQL.Clear;
              SQL.Add('SELECT DISTINCT');
              if opcion = 1 then
                 SQL.Add('"nom$nomina"."codigo_salud"')
              else
              SQL.Add('"nom$nomina"."codigo_pension"');
              SQL.Add('FROM');
              SQL.Add('"nom$nomina"');
              SQL.Add('INNER JOIN "nom$empleado" ON ("nom$nomina"."nit_empleado" = "nom$empleado"."nitempleado")');
              SQL.Add('WHERE');
              SQL.Add('"nom$empleado"."tipo_nomina" = :tipo_nomina');
              ParamByName('tipo_nomina').AsInteger := tipo_nomina;
              Open;
              while not Eof do
              begin
                with DataQuerys.IBaportes do
                begin
                  Close;
                  verificatransaccion(DataQuerys.IBaportes);
                  SQL.Clear;
                  SQL.Add('SELECT DISTINCT');
                  SQL.Add('"nom$entidad"."descripcion",');
                  SQL.Add('"nom$prestacion"."codigopuc"');
                  SQL.Add('From');
                  SQL.Add('"nom$prestacion",');
                  SQL.Add('"nom$entidad"');
                  SQL.Add('WHERE');
                  SQL.Add('("nom$prestacion"."nitentidad" = "nom$entidad"."nit") AND');
                  SQL.Add('("nom$prestacion"."codigo" = :cod)');
                  if opcion = 1 then
                    ParamByName('cod').AsInteger := DataQuerys.IBdatos.FieldByName('codigo_salud').AsInteger
                  else
                    ParamByName('cod').AsInteger := DataQuerys.IBdatos.FieldByName('codigo_pension').AsInteger;
                  Open;
                  descripcion := FieldByName('descripcion').AsString;
                  codigopuc := FieldByName('codigopuc').AsInteger;
                  SQL.Clear;
                  SQL.Add('SELECT');
                  if opcion = 1 then
                     SQL.Add('SUM("nom$nomina"."salud") AS total,')
                  else
                     SQL.Add('SUM("nom$nomina"."pension") AS total,');
                  SQL.Add('SUM("nom$nomina"."fsp") AS fsp');
                  SQL.Add('FROM');
                  SQL.Add('"nom$empleado"');
                  SQL.Add('INNER JOIN "nom$nomina" ON ("nom$empleado"."nitempleado" = "nom$nomina"."nit_empleado")');
                  SQL.Add('WHERE');
                  if opcion = 1 then
                     SQL.Add('("nom$nomina"."codigo_salud" = :codigo_salud) AND')
                  else
                     SQL.Add('("nom$nomina"."codigo_pension" = :codigo_pension) AND');
                  SQL.Add('("nom$empleado"."tipo_nomina" = :tipo_nomina) AND');
                  SQL.Add('("nom$nomina"."codigo_nomina" = :cod_nomina)');
                  if opcion = 1 then
                     ParamByName('codigo_salud').AsInteger := DataQuerys.IBdatos.FieldByName('codigo_salud').AsInteger
                  else
                     ParamByName('codigo_pension').AsInteger := DataQuerys.IBdatos.FieldByName('codigo_pension').AsInteger;
                  ParamByName('tipo_nomina').AsInteger := tipo_nomina;
                  ParamByName('cod_nomina').AsInteger := cod_nomina;
                  Open;
                  with DataQuerys.IBingresa do
                  begin
                    Close;
                    verificatransaccion(DataQuerys.IBingresa);
                    SQL.Clear;
                    SQL.Add('insert into "nom$fondos"');
                    SQL.Add('values (');
                    SQL.Add(':codigopuc,:deduccion,:descripcion,');
                    SQL.Add(':cod_nomina,:valor_salud,:fsp,:tipo_nomina,:valor_pension)');
                    ParamByName('codigopuc').AsInteger := codigopuc;
                    ParamByName('deduccion').AsInteger := 1;
                    ParamByName('descripcion').AsString := descripcion;
                    ParamByName('cod_nomina').AsInteger := cod_nomina;
                    if opcion = 1 then
                    begin
                       ParamByName('fsp').AsCurrency := 0;
                       ParamByName('valor_salud').AsCurrency := DataQuerys.IBaportes.FieldByName('total').AsCurrency;
                       ParamByName('valor_pension').AsCurrency := 0;
                       end
                    else
                    begin
                        ParamByName('fsp').AsCurrency := DataQuerys.IBaportes.FieldByName('fsp').AsCurrency;
                        ParamByName('valor_pension').AsCurrency := DataQuerys.IBaportes.FieldByName('total').AsCurrency;
                        ParamByName('valor_salud').AsCurrency := 0;
                    end;
                    ParamByName('tipo_nomina').AsInteger := tipo_nomina;
                    Open;
                    Close;
                    Transaction.Commit;
                  end;
                end;
                DataQuerys.IBdatos.Next;
              end;
              DataQuerys.IBdatos.Close;
            end;
            DataQuerys.IBselecion.Next;
          end;
          DataQuerys.IBselecion.Close;
        end;
end;

procedure TFrmNomina.imprimir_reporte(cadena:string);
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

procedure TFrmNomina.Button1Click(Sender: TObject);
begin
   nomi.Value := prima(nit.Value,0)
end;

procedure TFrmNomina.reporteindividual;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('select max("nom$nomina"."codigo_nomina") as codigo');
          SQL.Add('from "nom$nomina"');
          Open;
          IBQuery1.Close;
          verificatransaccion(IBQuery1);
          frDBDataSet2.DataSet := IBfechanomina;
          IBfechanomina.Close;
          IBfechanomina.ParamByName('cod').AsInteger := FieldByName('codigo').AsInteger;
          IBfechanomina.Open;
          frDBDataSet1.DataSet := IBQuery1;
          IBQuery1.ParamByName('codigo').AsInteger := FieldByName('codigo').AsInteger;
          IBQuery1.Open;
          imprimir_reporte(FrMain.wpath+'\reportes\reppago.frf');
        end;

end;

procedure TFrmNomina.primas;
var     tabla1,nombres,descripcion :string;
        nit,tipo :Integer;

begin
        FrmProgreso := TFrmProgreso.Create(self);
        FrmProgreso.Caption := 'Progreso del Reporte';
        Tabla1 := '"nomina' + FloatToStr(Now)+ '"';
        with IBtabla  do
        begin
          Close;
          verificatransaccion(IBtabla);
          SQL.Clear;
          SQL.Add('create table ' + Tabla1 + ' (');
          SQL.Add('nombres               VARCHAR(150),');
          SQL.Add('nit                   INTEGER,');
          SQL.Add('descripcion           VARCHAR(80),');
          SQL.Add('salario               NUMERIC(10,2),');
          SQL.Add('suma_pagar            NUMERIC(10,2),');
          SQL.Add('observaciones         VARCHAR(100))');
          ExecSQL;
          Close;
          Transaction.Commit;
        end;
        with DataQuerys.IBaportes  do
        begin
          Close;
          verificatransaccion(DataQuerys.IBaportes);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido",');
          SQL.Add('"inv$empleado"."nit",');
          SQL.Add('"nom$empleado"."tipo_nomina"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('INNER JOIN "inv$empleado" ON ("nom$empleado"."nitempleado" = "inv$empleado"."nit")');
          SQL.Add('WHERE');
          SQL.Add('"nom$empleado"."tipo_nomina" IN (10,20)');
          Open;
          Last;
          First;
          FrmProgreso.Barra.Maximum := RecordCount;
          while not DataQuerys.IBaportes.Eof do
          begin
            FrmProgreso.Barra.Position :=DataQuerys.IBaportes.RecNo;
            nombres := FieldByName('nombre').AsString + ' ' +FieldByName('apellido').AsString;
            nit := FieldByName('nit').AsInteger;
            tipo := FieldByName('tipo_nomina').AsInteger;
            if FormatDateTime('mm',Date) = '06' then
               descripcion := 'PRIMER SEMESTRE DE '+ FormatDateTime('YYYY',Date)
            else
               descripcion := 'SEGUNDO SEMESTRE DE '+ FormatDateTime('YYYY',Date);
              with IBtabla do
              begin
                Close;
                verificatransaccion(IBtabla);
                SQL.Clear;
                SQL.Add('insert into ' + Tabla1 + 'values(');
                SQL.Add(':"nombres",:"nit",:"descripcion",');
                SQL.Add(':"salario",:suma_pagar,:"observaciones")');
                ParamByName('nombres').AsString := nombres;
                ParamByName('nit').AsInteger := nit;
                ParamByName('descripcion').AsString := descripcion;
                ParamByName('salario').AsCurrency:= descuento(DataQuerys.IBselecion,nit,3);
                ParamByName('suma_pagar').AsCurrency := interescesantia(descuento(DataQuerys.IBselecion,nit,3),nit,10,tipo);
                ParamByName('observaciones').AsString := 'PAGO PRIMA DE SERVICIOS AL EMPLEADO: '+nombres;
                Open;
                Close;
                Transaction.Commit;
              end;
          DataQuerys.IBaportes.Next;
          end;
           Close;
           FrmProgreso.Hide;
          end;
          frDBDataSet1.DataSet := IBtabla;
          with IBtabla  do
          begin
           Close;
           verificatransaccion(IBtabla);
           SQL.Clear;
           SQL.Add('select * from '+tabla1);
           Open;
           Last;
           First;
           imprimir_reporte(FrMain.wpath+'reportes\reppagoservicios.frf');
           Close;
        end;

          with ibtabla do
          begin
           Close;
           verificatransaccion(IBtabla);
           SQL.Clear;
           SQL.Add('drop table ' + Tabla1);
           ExecSQL;
           Close;
           Transaction.Commit;
          end;
end;

procedure TFrmNomina.vacaciones;
var     tabla1,nombres,descripcion :string;
        nit :Integer;
begin
        Tabla1 := '"nomina' + FloatToStr(Now)+ '"';
        with IBtabla  do
        begin
          Close;
          verificatransaccion(IBtabla);
          SQL.Clear;
          SQL.Add('create table ' + Tabla1 + ' (');
          SQL.Add('nombres               VARCHAR(150),');
          SQL.Add('nit                   INTEGER,');
          SQL.Add('descripcion           VARCHAR(80),');
          SQL.Add('salario               NUMERIC(10,2),');
          SQL.Add('suma_pagar            NUMERIC(10,2),');
          SQL.Add('observaciones         VARCHAR(100))');
          ExecSQL;
          Close;
          Transaction.Commit;
        end;
        with DataQuerys.IBaportes  do
        begin
          Close;
          verificatransaccion(DataQuerys.IBaportes);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido",');
          SQL.Add('"inv$empleado"."nit",');
          SQL.Add('"nom$empleado"."tipo_nomina"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('INNER JOIN "inv$empleado" ON ("nom$empleado"."nitempleado" = "inv$empleado"."nit")');
          SQL.Add('WHERE');
          SQL.Add('"inv$empleado"."nit" = :nit');
          ParamByName('nit').AsInteger := nit_empleado;
          Open;
          Last;
          First;
          while not DataQuerys.IBaportes.Eof do
          begin
            nombres := FieldByName('nombre').AsString + ' ' +FieldByName('apellido').AsString;
            nit := FieldByName('nit').AsInteger;
            //tipo := FieldByName('tipo_nomina').AsInteger;
            if FormatDateTime('mm',Date) = '06' then
               descripcion := 'PRIMER SEMESTRE DE '+ FormatDateTime('YYYY',Date)
            else
               descripcion := 'SEGUNDO SEMESTRE DE '+ FormatDateTime('YYYY',Date);
              with IBtabla do
              begin
                Close;
                verificatransaccion(IBtabla);
                SQL.Clear;
                SQL.Add('insert into ' + Tabla1 + 'values(');
                SQL.Add(':"nombres",:"nit",:"descripcion",');
                SQL.Add(':"salario",:suma_pagar,:"observaciones")');
                ParamByName('nombres').AsString := nombres;
                ParamByName('nit').AsInteger := nit;
                ParamByName('descripcion').AsString := descripcion;
                ParamByName('salario').AsCurrency:= descuento(DataQuerys.IBselecion,nit,3);
                ParamByName('suma_pagar').AsCurrency := SimpleRoundTo(descuento(DataQuerys.IBselecion,nit,3)/2,0);
                ParamByName('observaciones').AsString := 'PAGO PRIMA DE VACACIONES AL EMPLEADO: '+nombres;
                Open;
                Close;
                Transaction.Commit;
              end;
          DataQuerys.IBaportes.Next;
          end;
           Close;
          end;
          frDBDataSet1.DataSet := IBtabla;
          with IBtabla  do
          begin
           Close;
           verificatransaccion(IBtabla);
           SQL.Clear;
           SQL.Add('select * from '+tabla1);
           Open;
           Last;
           First;
           imprimir_reporte(FrMain.wpath+'reportes\reppagovacaciones.frf');
           Close;
        end;
          with ibtabla do
          begin
           Close;
           verificatransaccion(IBtabla);
           SQL.Clear;
           SQL.Add('drop table ' + Tabla1);
           ExecSQL;
           Close;
           Transaction.Commit;
          end;
end;

procedure TFrmNomina.navidad;
var     tabla1,nombres,descripcion :string;
        nit,tipo :Integer;

begin
        FrmProgreso := TFrmProgreso.Create(self);
        FrmProgreso.Caption := 'Progreso del Reporte';
        Tabla1 := '"nomina' + FloatToStr(Now)+ '"';
        with IBtabla  do
        begin
          Close;
          verificatransaccion(IBtabla);
          SQL.Clear;
          SQL.Add('create table ' + Tabla1 + ' (');
          SQL.Add('nombres               VARCHAR(150),');
          SQL.Add('nit                   INTEGER,');
          SQL.Add('descripcion           VARCHAR(80),');
          SQL.Add('salario               NUMERIC(10,2),');
          SQL.Add('suma_pagar            NUMERIC(10,2),');
          SQL.Add('observaciones         VARCHAR(100))');
          ExecSQL;
          Close;
          Transaction.Commit;
        end;
        with DataQuerys.IBaportes  do
        begin
          Close;
          verificatransaccion(DataQuerys.IBaportes);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido",');
          SQL.Add('"inv$empleado"."nit",');
          SQL.Add('"nom$empleado"."tipo_nomina"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('INNER JOIN "inv$empleado" ON ("nom$empleado"."nitempleado" = "inv$empleado"."nit")');
          SQL.Add('WHERE');
          SQL.Add('"nom$empleado"."tipo_nomina" IN (10,20)');
          Open;
          Last;
          First;
          FrmProgreso.Barra.Maximum := RecordCount;
          while not DataQuerys.IBaportes.Eof do
          begin
            FrmProgreso.Barra.Position :=DataQuerys.IBaportes.RecNo;
            nombres := FieldByName('nombre').AsString + ' ' +FieldByName('apellido').AsString;
            nit := FieldByName('nit').AsInteger;
            tipo := FieldByName('tipo_nomina').AsInteger;
            if FormatDateTime('mm',Date) = '06' then
               descripcion := 'PRIMER SEMESTRE DE '+ FormatDateTime('YYYY',Date)
            else
               descripcion := 'SEGUNDO SEMESTRE DE '+ FormatDateTime('YYYY',Date);
              with IBtabla do
              begin
                Close;
                verificatransaccion(IBtabla);
                SQL.Clear;
                SQL.Add('insert into ' + Tabla1 + 'values(');
                SQL.Add(':"nombres",:"nit",:"descripcion",');
                SQL.Add(':"salario",:suma_pagar,:"observaciones")');
                ParamByName('nombres').AsString := nombres;
                ParamByName('nit').AsInteger := nit;
                ParamByName('descripcion').AsString := descripcion;
                ParamByName('salario').AsCurrency:= descuento(DataQuerys.IBselecion,nit,3);
                ParamByName('suma_pagar').AsCurrency := interescesantia(descuento(DataQuerys.IBselecion,nit,3),nit,3,tipo);
                ParamByName('observaciones').AsString := 'PAGO PRIMA DE NAVIDAD AL EMPLEADO(A): '+nombres;
                Open;
                Close;
                Transaction.Commit;
              end;
          DataQuerys.IBaportes.Next;
          end;
           Close;
           FrmProgreso.Hide;
          end;
          frDBDataSet1.DataSet := IBtabla;
          with IBtabla  do
          begin
           Close;
           verificatransaccion(IBtabla);
           SQL.Clear;
           SQL.Add('select * from '+tabla1);
           Open;
           Last;
           First;
           imprimir_reporte(FrMain.wpath+'reportes\reppagonavidad.frf');
           Close;
        end;

          with ibtabla do
          begin
           Close;
           verificatransaccion(IBtabla);
           SQL.Clear;
           SQL.Add('drop table ' + Tabla1);
           ExecSQL;
           Close;
           Transaction.Commit;
          end;
end;

procedure TFrmNomina.obligaciones;
var
  ExcelFile:TDataSetToExcel;
begin
        {frDBDataSet1.DataSet := IBobligaciones;
        verificatransaccion(IBobligaciones);
        IBobligaciones.ParamByName('fecha').AsString := IntToStr(ano_obligacion);
        IBobligaciones.Open;
        imprimir_reporte(FrMain.wpath+'\reportes\repobligaciones.frf');
        verificatransaccion(IBobligaciones);
        verificatransaccion(IBcalObligacion);}
        with IBobligaciones do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT ');
          SQL.Add('"nom$obligaciones"."nit",');
          SQL.Add('"nom$obligaciones"."horas_extras",');
          SQL.Add('"nom$obligaciones"."viaticos",');
          SQL.Add('"nom$obligaciones"."p_antiguedad",');
          SQL.Add('"nom$obligaciones"."p_vacaciones",');
          SQL.Add('"nom$obligaciones"."p_navidad",');
          SQL.Add('"nom$obligaciones"."p_servicios",');
          SQL.Add('"nom$obligaciones"."vacaciones",');
          SQL.Add('"nom$obligaciones"."bonificacion",');
          SQL.Add('"nom$obligaciones"."retefuente",');
          //SQL.Add('"nom$obligaciones"."int_cesantias",');
          SQL.Add('"nom$obligaciones"."g_representacion",');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido",');
          SQL.Add('"inv$empleado"."nit"');
          SQL.Add('FROM');
          SQL.Add('"nom$obligaciones"');
          SQL.Add('INNER JOIN "inv$empleado" ON ("nom$obligaciones"."nit" = "inv$empleado"."nit")');
          SQL.Add('WHERE');
          SQL.Add('("nom$obligaciones"."ano" = :fecha)');
          SQL.Add('order by "inv$empleado"."nombre" ');
          ParamByName('fecha').AsInteger := ano_obligacion;
          Open;
          Last;
          First;
          FrmProgresos := TFrmProgresos.Create(self);
          frmProgresos.Titulo := 'Espere Un Momento por Favor.';
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Empleado : ' + FieldByName('nombre').AsString + ' ' + FieldByName('apellido').AsString;
            Application.ProcessMessages;
            CDobligacion.Append;
            CDobligacion.FieldValues['nombre'] := FieldByName('nombre').AsString + ' ' + FieldByName('apellido').AsString;
            CDobligacion.FieldValues['horas'] := FieldByName('horas_extras').AsCurrency;
            CDobligacion.FieldValues['viaticos'] := FieldByName('viaticos').AsCurrency;
            CDobligacion.FieldValues['pantiguedad'] := FieldByName('p_antiguedad').AsCurrency;
            CDobligacion.FieldValues['pvacacion'] := FieldByName('p_vacaciones').AsCurrency;
            CDobligacion.FieldValues['pnavidad'] := FieldByName('p_navidad').AsCurrency;
            CDobligacion.FieldValues['pservicios'] := FieldByName('p_servicios').AsCurrency;
            CDobligacion.FieldValues['vacaciones'] := FieldByName('vacaciones').AsCurrency;
            CDobligacion.FieldValues['bonificacion'] := FieldByName('bonificacion').AsCurrency;
            CDobligacion.FieldValues['retefuente'] := FieldByName('retefuente').AsCurrency;
            //CDobligacion.FieldValues['int_cesantias'] := FieldByName('int_cesantias').AsCurrency;
            CDobligacion.FieldValues['grep'] := FieldByName('g_representacion').AsCurrency;
            with IBcalObligacion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('SELECT');
              SQL.Add('sum("nom$nomina"."total_devengado") AS NETO,');
              SQL.Add('SUM("nom$nomina"."transporte") AS TRANSPORTE,');
              SQL.Add('SUM("nom$nomina"."salud") AS SALUD,');
              SQL.Add('SUM("nom$nomina"."pension") AS PENSION,');
              SQL.Add('SUM("nom$nomina"."fsp") AS FSP,');
              SQL.Add('SUM("nom$nomina"."ap_pension") AS APENSION,');
              SQL.Add('"nom$nomina"."nit_empleado"');
              SQL.Add('FROM');
              SQL.Add('"nom$nomina"');
              SQL.Add('INNER JOIN "nom$controlnomina" ON ("nom$nomina"."codigo_nomina"="nom$controlnomina"."cod_nomina")');
              SQL.Add('WHERE');
              SQL.Add('((EXTRACT (YEAR FROM "nom$controlnomina"."fecha")) = :ANO) AND');
              SQL.Add('("nom$nomina"."nit_empleado" = :NIT)');
              SQL.Add('GROUP BY "nom$nomina"."nit_empleado"');
              ParamByName('NIT').AsInteger := IBobligaciones.FieldByName('nit').AsInteger;
              ParamByName('ANO').AsInteger := ano_obligacion;
              Open;
              CDobligacion.FieldValues['sueldo'] := FieldByName('NETO').AsCurrency;
              CDobligacion.FieldValues['salud'] := FieldByName('SALUD').AsCurrency;
              CDobligacion.FieldValues['pension'] := FieldByName('PENSION').AsCurrency;
              CDobligacion.FieldValues['fsp'] := FieldByName('FSP').AsCurrency;
              CDobligacion.FieldValues['atransporte'] := FieldByName('TRANSPORTE').AsCurrency;
              CDobligacion.FieldValues['nit'] := FieldByName('nit_empleado').AsInteger;
              CDobligacion.FieldValues['apension'] := FieldByName('APENSION').AsInteger;
              SQL.Clear;
              SQL.Add('SELECT ');
              SQL.Add('*');
              SQL.Add('FROM');
              SQL.Add('"nom$cesantias"');
              SQL.Add('WHERE');
              SQL.Add('("nom$cesantias"."nit" = :NIT) AND ');
              SQL.Add('("nom$cesantias"."ano" = :ANO)');
              ParamByName('NIT').AsInteger := IBobligaciones.FieldByName('nit').AsInteger;
              ParamByName('ANO').AsInteger := ano_obligacion;
              Open;
              CDobligacion.FieldValues['cesantias'] := FieldByName('cesantia').AsCurrency;
              CDobligacion.FieldValues['int_cesantias'] := FieldByName('int_cesantias').AsCurrency;
              //Sleep(250);
            end;
            Next;
          end;
          CDobligacion.First;
          ExcelFile := TDataSetToExcel.Create(CDobligacion,'C:\Nomina12.xls');
          ExcelFile.WriteFile;
          ExcelFile.Free;

          frmProgresos.Cerrar;
          imprimir_reporte(FrMain.wpath+'\reportes\repobligaciones1.frf');
        end;
end;

procedure TFrmNomina.descuentos;
var     mes :string;
begin
        frDBDataSet1.DataSet := IBreportes;
        with IBreportes do
        begin
          Close;
          verificatransaccion(IBreportes);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido",');
          SQL.Add('"nom$descuento"."numero_dias",');
          SQL.Add('"nom$descuento"."motivo",');
          SQL.Add('"nom$descuento"."fecha"');
          SQL.Add('FROM');
          SQL.Add('"nom$descuento"');
          SQL.Add('INNER JOIN "inv$empleado" ON ("nom$descuento"."nit_empleado" = "inv$empleado"."nit")');
          SQL.Add('WHERE');
          SQL.Add('("nom$descuento"."fecha" >= :fecha1) AND');
          SQL.Add('("nom$descuento"."fecha" <= :fecha)');
          SQL.Add('AND ("nom$descuento"."numero_dias" <> :dias)');
          mes := IntToStr(monthofdate(Date));
          ParamByName('dias').AsString := '0';
          ParamByName('fecha1').AsDate := StrToDate(FormatDateTime('yyyy/'+mes+'/01',Date));
          ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/12/31',Date));
          Open;
          imprimir_reporte(FrMain.wpath+'\reportes\repdescuento.frf');
        end;
end;

procedure TFrmNomina.repdian;
var     tabla1,nombres :string;
        nit :Integer;
        total_ingresos,total_deduccion : Currency;
        cesantias,nograbados,retefuente :Currency;
        interes :Currency;
begin
        FrmProgreso := TFrmProgreso.Create(self);
        FrmProgreso.Caption := 'Progreso del Reporte';
        Tabla1 := '"nomina' + FloatToStr(Now)+ '"';
        with IBtabla  do
        begin
          Close;
          verificatransaccion(IBtabla);
          SQL.Clear;
          SQL.Add('create table ' + Tabla1 + ' (');
          SQL.Add('nombres               VARCHAR(150),');
          SQL.Add('salgrabado            NUMERIC(10,2),');
          SQL.Add('salnograbado          NUMERIC(10,2),');
          SQL.Add('cesantias             NUMERIC(10,2),');
          SQL.Add('intcesantias          NUMERIC(10,2),');
          SQL.Add('retencion             NUMERIC(10,2))');
          ExecSQL;
          Close;
          Transaction.Commit;
        end;
        with DataQuerys.IBaportes  do
        begin
          Close;
          verificatransaccion(DataQuerys.IBaportes);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido",');
          SQL.Add('"inv$empleado"."nit",');
          SQL.Add('"nom$empleado"."tipo_nomina"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('INNER JOIN "inv$empleado" ON ("nom$empleado"."nitempleado" = "inv$empleado"."nit")');
          //SQL.Add('WHERE');
          //SQL.Add('"nom$empleado"."tipo_nomina" IN (10,20)');
          Open;
          Last;
          First;
          FrmProgreso.Barra.Maximum := RecordCount;
          while not DataQuerys.IBaportes.Eof do
          begin
            FrmProgreso.Barra.Position :=DataQuerys.IBaportes.RecNo;
            nombres := FieldByName('nombre').AsString + ' ' +FieldByName('apellido').AsString;
            nit := FieldByName('nit').AsInteger;
            //tipo := FieldByName('tipo_nomina').AsInteger;
            with DataQuerys.IBselecion do
            begin
              Close;
              verificatransaccion(DataQuerys.IBselecion);
              SQL.Clear;
              SQL.Add('SELECT');
              SQL.Add('"nom$obligaciones"."sueldo" + "nom$obligaciones"."horas_extras"');
              SQL.Add('+ "nom$obligaciones"."viaticos" + "nom$obligaciones"."transporte"');
              SQL.Add('+ "nom$obligaciones"."p_antiguedad" + "nom$obligaciones"."p_vacaciones"');
              SQL.Add('+ "nom$obligaciones"."p_navidad" + "nom$obligaciones"."p_servicios"');
              SQL.Add('+ "nom$obligaciones"."vacaciones" + "nom$obligaciones"."bonificacion" AS "ingresos",');
              SQL.Add('"nom$obligaciones"."pension" + "nom$obligaciones"."fsp" AS "subtotal",');
              SQL.Add(' "nom$obligaciones"."retefuente"');
              SQL.Add('FROM');
              SQL.Add('"nom$obligaciones"');
              SQL.Add('WHERE');
              SQL.Add('("nom$obligaciones"."nit" = :nit)');
              SQL.Add('and ("nom$obligaciones"."ano" = :ano)');
              ParamByName('ano').AsInteger := YearOf(Date);
              ParamByName('nit').AsInteger := nit;
              Open;
              total_ingresos := FieldByName('ingresos').AsCurrency;
              total_deduccion := FieldByName('subtotal').AsCurrency;
              retefuente := FieldByName('retefuente').AsCurrency;
              SQL.Clear;
              {SQL.Add('SELECT');
              SQL.Add('"nomina"."cesantias",');
              SQL.Add('"nomina"."interes"');
              SQL.Add('FROM');
              SQL.Add('"nomina"');
              SQL.Add('WHERE');
              SQL.Add('("nomina"."nit" = :nit)');
              ParamByName('nit').AsInteger := nit;
              Open;
              cesantias := FieldByName('cesantias').AsCurrency;
              interes := FieldByName('interes').AsCurrency;
}
              SQL.Add('SELECT');
              SQL.Add('"nom$consolidado"."cesantia"');
              SQL.Add('FROM');
              SQL.Add('"nom$consolidado"');
              SQL.Add('WHERE');
              SQL.Add('("nom$consolidado"."nit" = :nit)');
              ParamByName('nit').AsInteger := nit;
              Open;
              cesantias := FieldByName('cesantia').AsCurrency;
              interes := FieldByName('cesantia').AsCurrency * 0.12;
              Close;
            end;
              nograbados := SimpleRoundTo((total_ingresos - total_deduccion) * 0.25,0);
              with IBtabla do
              begin
                Close;
                verificatransaccion(IBtabla);
                SQL.Clear;
                SQL.Add('insert into ' + Tabla1 + 'values(');
                SQL.Add(':nombres,:salgrabado,');
                SQL.Add(':salnograbado,:cesantias,:intcesantias,:retefuente)');
                ParamByName('nombres').AsString := nombres;
                ParamByName('salgrabado').AsCurrency := SimpleRoundTo((total_ingresos - nograbados),0);
                ParamByName('salnograbado').AsCurrency := nograbados;
                ParamByName('cesantias').AsCurrency:= cesantias;
                ParamByName('intcesantias').AsCurrency:= interes;
                ParamByName('retefuente').AsCurrency := retefuente;
                Open;
                Close;
                Transaction.Commit;
              end;
          DataQuerys.IBaportes.Next;
          end;
           Close;
           FrmProgreso.Hide;
          end;
          frDBDataSet1.DataSet := IBtabla;
          with IBtabla  do
          begin
           Close;
           verificatransaccion(IBtabla);
           SQL.Clear;
           SQL.Add('select * from '+tabla1);
           SQL.Add('order by '+tabla1+'.nombres');
           Open;
           Last;
           First;
           imprimir_reporte(FrMain.wpath+'reportes\repdian.frf');
           Close;
        end;
          with ibtabla do
          begin
           Close;
           verificatransaccion(IBtabla);
           SQL.Clear;
           SQL.Add('drop table ' + Tabla1);
           ExecSQL;
           Close;
           Transaction.Commit;
          end;
end;

procedure TFrmNomina.prestaciones;
begin
        verificatransaccion(IBreportes);
        verificatransaccion(IBsalud);
        verificatransaccion(IBriesgos);
        frDBDataSet1.DataSet := IBreportes;
        frDBDataSet2.DataSet := IBsalud;
        frDBDataSet3.DataSet := Ibriesgos;
        Ibriesgos.Open;
        IBreportes.Open;
        IBsalud.Open;
        imprimir_reporte(FrMain.wpath+'reportes\repprestacion.frf');
end;

procedure TFrmNomina.repgeneral;
var eps,arp,afp,nomina :string;
begin

        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido",');
          SQL.Add('"inv$empleado"."nit",');
          SQL.Add('"nom$empleado"."sueldobasico",');
          SQL.Add('"nom$empleado"."numero_cuenta",');
          SQL.Add('"nom$empleado"."fecha_registro",');
          SQL.Add('"nom$empleado"."tipo_nomina"');
          SQL.Add('FROM');
          SQL.Add('"inv$empleado"');
          SQL.Add('INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empleado"."nitempleado")');
          Open;
          while not Eof do
          begin
            with DataQuerys.IBselecion do
            begin
              Close;
              verificatransaccion(DataQuerys.IBselecion);
              SQL.Clear;
              SQL.Add('SELECT DISTINCT');
              SQL.Add('"nom$entidad"."descripcion"');
              SQL.Add('FROM');
              SQL.Add('"nom$prestacion"');
              SQL.Add('INNER JOIN "nom$entidad" ON ("nom$prestacion"."nitentidad" = "nom$entidad"."nit")');
              SQL.Add('INNER JOIN "nom$empleado" ON ("nom$prestacion"."codigo" = "nom$empleado"."codigo_pension")');
              SQL.Add('WHERE');
              SQL.Add('("nom$empleado"."nitempleado" = :nit)');
              ParamByName('nit').AsInteger := DataQuerys.IBdatos.FieldByName('nit').AsInteger;
              Open;
              afp := FieldByName('descripcion').AsString;
              SQL.Clear;
              SQL.Add('SELECT DISTINCT');
              SQL.Add('"nom$entidad"."descripcion"');
              SQL.Add('FROM');
              SQL.Add('"nom$prestacion"');
              SQL.Add('INNER JOIN "nom$entidad" ON ("nom$prestacion"."nitentidad" = "nom$entidad"."nit")');
              SQL.Add('INNER JOIN "nom$empleado" ON ("nom$prestacion"."codigo" = "nom$empleado"."codigo_salud")');
              SQL.Add('WHERE');
              SQL.Add('("nom$empleado"."nitempleado" = :nit)');
              ParamByName('nit').AsInteger := DataQuerys.IBdatos.FieldByName('nit').AsInteger;
              Open;
              eps := FieldByName('descripcion').AsString;
              SQL.Clear;
              SQL.Add('SELECT DISTINCT');
              SQL.Add('"nom$entidad"."descripcion"');
              SQL.Add('FROM');
              SQL.Add('"nom$prestacion"');
              SQL.Add('INNER JOIN "nom$entidad" ON ("nom$prestacion"."nitentidad" = "nom$entidad"."nit")');
              SQL.Add('INNER JOIN "nom$empleado" ON ("nom$prestacion"."codigo" = "nom$empleado"."codigo_riesgo")');
              SQL.Add('WHERE');
              SQL.Add('("nom$empleado"."nitempleado" = :nit)');
              ParamByName('nit').AsInteger := DataQuerys.IBdatos.FieldByName('nit').AsInteger;
              Open;
              arp := FieldByName('descripcion').AsString;
              SQL.Clear;
              SQL.Add('SELECT DISTINCT');
              SQL.Add('"nom$tiponomina"."descripcion"');
              SQL.Add('FROM');
              SQL.Add('"nom$tiponomina"');
              SQL.Add('WHERE');
              SQL.Add('("nom$tiponomina"."codigo" = :codigo)');
              ParamByName('codigo').AsInteger := DataQuerys.IBdatos.FieldByName('tipo_nomina').AsInteger;
              Open;
              nomina := FieldByName('descripcion').AsString;
              Close;
            end;
            with CDtabla do
            begin
              Append;
              FieldValues['nit'] := DataQuerys.IBdatos.FieldByName('nit').AsInteger;
              FieldValues['nombre'] := DataQuerys.IBdatos.FieldByName('nombre').AsString+ ' '+ DataQuerys.IBdatos.FieldByName('apellido').AsString;
              FieldValues['sueldo'] := DataQuerys.IBdatos.FieldByName('sueldobasico').AsCurrency;
              FieldValues['eps'] := eps;
              FieldValues['arp'] := arp;
              FieldValues['afp'] := afp;
              FieldValues['fecha'] := DataQuerys.IBdatos.FieldByName('fecha_registro').AsDateTime;
              FieldValues['cuenta'] := DataQuerys.IBdatos.FieldByName('numero_cuenta').AsInteger;
              FieldValues['nomina'] := nomina;
              FieldValues['tiponomina'] := DataQuerys.IBdatos.FieldByName('tipo_nomina').AsInteger;
              Post;
          end;
          DataQuerys.IBdatos.Next;
        end;
          Close;
        end;
        frDBDataSet1.DataSet := CDtabla;
        CDtabla.Open;
        imprimir_reporte(FrMain.wpath+'reportes\repgeneral.frf');
        CDtabla.Edit;
        CDtabla.ClearFields;

end;

procedure TFrmNomina.consolidada;
begin
        frDBDataSet1.DataSet := IBconsolidadas;
        verificatransaccion(IBconsolidadas);
        IBconsolidadas.Open;
        imprimir_reporte(FrMain.wpath+'\reportes\repconsolidadas.frf');
end;

procedure TFrmNomina.pagoprima;
var     nit,tipo,cuenta :Integer;
        valor : Currency;
        vFecha :TDate;
        Extras, Servicio, Transporte,dias :Currency;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('*');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('where ("nom$empleado"."tipo_nomina" BETWEEN :inicio AND :fin)');
          //SQL.Add('and "nom$empleado"."nitempleado" = 80008650');//ojo quitar
          ParamByName('inicio').AsInteger := cod_inicio;
          ParamByName('fin').AsInteger := cod_fin;
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Titulo := 'Realizando Reporte Pago Prima de Servicios';
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            FrmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Registro No : '+IntToStr(RecNo);
            Application.ProcessMessages;
            nit := FieldByName('nitempleado').AsInteger;
            cuenta := FieldByName('numero_cuenta').AsInteger;
            tipo := FieldByName('tipo_nomina').AsInteger;
            vFecha := FieldByName('fecha_registro').AsDateTime;
            //if FieldByName('aux_transporte').AsInteger = 1 then
               transporte := valor_transporte(nit,1);
            //else
            //   transporte := 0;
            Servicio := proservicios(StrToDate('2011/01/01'),nit);
            extras := serextras(nit,StrToDate('2011/01/01'));
            dias := diasservicio(vFecha);
            valor := SimpleRoundTo(((Servicio+Extras+Transporte)/360) * dias,0);
            //valor := SimpleRoundTo((((/360) + )/180)* ,0);
            with CDPago do
            begin
              Append;
              FieldValues['nombres'] := buscanombre(nit);
              FieldValues['valor'] := valor - retefuente(DataQuerys.IBaportes,nit,2,valor);
              FieldValues['cedula'] := nit;
              FieldValues['retefuente'] := retefuente(DataQuerys.IBaportes,nit,2,valor);
              FieldValues['cuenta'] := cuenta;
              Post;
            end;
          //retefuente := 0;
            Next;
          end; // fin del while
          Close;
        end; // fin del with principoal
        frmProgresos.Cerrar;
        frDBDataSet1.DataSet := CDPago;
        CDPago.IndexFieldNames := 'nombres';
        imprimir_reporte(FrMain.wpath+'\reportes\repprimaser.frf');
end;

function TFrmNomina.buscanombre(nit: integer): string;
begin
        with DataQuerys.IBaportes do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido"');
          SQL.Add('FROM');
          SQL.Add('"inv$empleado"');
          SQL.Add('WHERE');
          SQL.Add('("inv$empleado"."nit" = :nit)');
          ParamByName('nit').AsInteger := nit;
          Open;
          Result := FieldByName('nombre').AsString + ' '+FieldByName('apellido').AsString;
          Close;
        end;
end;

procedure TFrmNomina.horaextra1;
var     valor_hora :Currency;
        cod_nomina :Integer;
        hn,hf,hd,hdi,hdd,hed,hotra :Currency;
begin

        valor_hora := 0;
        hdi := 0;hn := 0;hd := 0;hf := 0;hdd := 0;hed := 0;hotra := 0;
        cod_nomina := buscanomina(IBQuery1);
        with DataQuerys.IBselecion do
        begin
          verificatransaccion(DataQuerys.IBselecion);
          Close;
          SQL.Clear;
          SQL.Add('select "nom$controlnomina"."fecha" from "nom$controlnomina"');
          SQL.Add('where "nom$controlnomina"."cod_nomina" = :cod_nomina');
          ParamByName('cod_nomina').AsInteger := cod_nomina;
          Open;
          if FormatDateTime('mm',Date) <> FormatDateTime('mm',FieldByName('fecha').AsDateTime) then
             cod_nomina := cod_nomina - 1;
          Close;
        end;
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"inv$empleado"."nit",');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido"');
          SQL.Add('FROM');
          SQL.Add('"inv$empleado"');
          SQL.Add('INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empleado"."nitempleado")');
          SQL.Add('order by "inv$empleado"."nombre"');
          //SQL.Add('WHERE');
          //SQL.Add('("nom$empleado"."tipo_nomina" BETWEEN 10 AND 20)');
          Open;

          while not Eof do
          begin
            try
            valor_hora := descuento(IBQuery1,FieldByName('nit').AsInteger,3)/240;
                                                    except
           MessageDlg('mo ' + FieldByName('nit').AsString,mtinformation,[mbok],0);
         end;

            with IBQuery1 do
            begin
              Close;
              verificatransaccion(IBquery1);
              SQL.Clear;
              SQL.Add('select "nom$horasextras"."horas","nom$horasextras"."diurna" from "nom$horasextras"');
              SQL.Add('where "nom$horasextras"."cod_nomina" = :cod_nomina and');
              SQL.Add('"nom$horasextras"."nit_empleado" = :nit');
              //SQL.Add('and "nom$horasextras"."diurna" = 5');
              ParamByName('cod_nomina').AsInteger := cod_nomina;
              ParamByName('nit').AsInteger := DataQuerys.IBdatos.FieldByName('nit').AsInteger;
              Open;
              while not Eof do
              begin
                case FieldByName('diurna').AsInteger of
                 1:hdi := hdi + FieldByName('horas').AsCurrency; //total_horas + (valor_hora * FieldByName('horas').AsCurrency) * 1.25;// hora diurna
                 2:hf := hf + FieldByName('horas').AsCurrency;
                 3:hd := hd + FieldByName('horas').AsCurrency;
                 4:hn := hn + FieldByName('horas').AsCurrency;
                 5:hdd := hdd + FieldByName('horas').AsCurrency;
                 6:hed := hed + FieldByName('horas').AsCurrency;
                 7:hotra := hotra + FieldByName('horas').AsCurrency;
                end;
                Next;

              end;

          end;

          if (hdi+hf+hd+hn+hdd+hed+hotra) <> 0 then
          begin
          with CDhora do
          begin
            Append;
            FieldValues['nombres'] := DataQuerys.IBdatos.FieldByName('nombre').AsString + ' ' +DataQuerys.IBdatos.FieldByName('apellido').AsString;
            FieldValues['hdiurna'] := Formato(hdi);
            FieldValues['vdiurna'] := (hdi * valor_hora) * valorhoraextra(dataquerys.IBaportes,3);
            FieldValues['hfestivo'] := Formato(hf);
            FieldValues['vfestivo'] := (hf * valor_hora) * valorhoraextra(dataquerys.IBaportes,4);
            FieldValues['hdominical'] := Formato(hd);
            FieldValues['vdominical'] := (hd * valor_hora) * valorhoraextra(dataquerys.IBaportes,5);
            FieldValues['hnocturno'] := Formato(hn);
            FieldValues['vnocturno'] := (hn * valor_hora) *  valorhoraextra(dataquerys.IBaportes,6);
            FieldValues['horad'] := Formato(hdd);
            FieldValues['valorn'] := (hdd * valor_hora) *  valorhoraextra(dataquerys.IBaportes,7);
            FieldValues['horaord'] := formato(hed);
            FieldValues['vhoraord'] := (hed * valor_hora)* valorhoraextra(dataquerys.IBaportes,10);
            FieldValues['hotra'] := formato(hotra);
            FieldValues['votra'] := (hotra * valor_hora)* valorhoraextra(dataquerys.IBaportes,11);
            Post;

          end;
          end;
          hdi := 0;
          hd := 0;
          hf := 0;
          hn := 0;
          hdd := 0;
          hed := 0;
          hotra := 0;
          Next;
        end;
        frDBDataSet1.DataSet := CDhora;
        imprimir_reporte(FrMain.wpath + '/reportes/repextras.frf');
        end;
end;

function TFrmNomina.formato(valor: Currency): currency;
begin
        Result := int(valor) + SimpleRoundTo(((60*frac(valor))/100),-2);
end;

procedure TFrmNomina.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        //FrmQuerys := TFrmQuerys.Create(self);
        if Parname = 'TipoN' then
           ParValue := _sTipoN;

        if ParName  = 'fecha_ini' then
           ParValue  := FrmRecuperaHora.fecha1.DateTime;
        if ParName  = 'fecha_fin' then
           ParValue  := FrmRecuperaHora.fecha2.DateTime;
        if ParName = 'ano' then
           ParValue := ano_obligacion;
        if ParName = 'pension' then
        if ParName = 'salud' then


end;

procedure TFrmNomina.pnavidad;
var     nit,tipo,cuenta,vMeses :Integer;
        valor : Currency;
        vFecha :TDate;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('*');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('where ("nom$empleado"."tipo_nomina" BETWEEN :inicio AND :fin)');
          //SQL.Add('and "nom$empleado"."nitempleado" = 5035698'); //ojo quitar validacion
          ParamByName('inicio').AsInteger := cod_inicio;
          ParamByName('fin').AsInteger := cod_fin;
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Titulo := 'Realizando Reporte de Pago para Prima de Navidad';
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            FrmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Registro No : '+IntToStr(RecNo);
            Application.ProcessMessages;
            nit := FieldByName('nitempleado').AsInteger;
            vFecha := FieldByName('fecha_registro').AsDateTime;
            cuenta := FieldByName('numero_cuenta').AsInteger;
            tipo := FieldByName('tipo_nomina').AsInteger;
            vMeses := MonthsBetween(FieldByName('fecha_registro').AsDateTime,(Date + 15));

            if retornadias(vFecha) >= 180 then
            begin
              {if busca_mes(nit) then
              begin
              if busca_sueldo(FieldByName('sueldobasico').AsCurrency,nit) then
                 valor := interescesantia(descuento(DataQuerys.IBselecion,nit,3),nit,3,tipo)
              else
                valor := valor_real(nit,0,FieldByName('sueldobasico').AsCurrency);}

              valor := SimpleRoundTo((proservicios(StrToDate('2011/01/01'),nit)/720) * SimpleRoundTo(interescesantia(0,nit,7,0),0),0);
              with CDPago do
              begin
                Append;
                FieldValues['nombres'] := buscanombre(nit);
                FieldValues['valor'] := valor - retefuente(DataQuerys.IBaportes,nit,2,valor);
                FieldValues['cedula'] := nit;
                FieldValues['retefuente'] := retefuente(DataQuerys.IBaportes,nit,2,valor);
                FieldValues['cuenta'] := cuenta;
                Post;
              end;
            //retefuente := 0;
        end; //fin del retorna dias
          //end;
          Next;
          end; //fin del while
          Close;
          frmProgresos.Cerrar;
        end; // fin del with
        frDBDataSet1.DataSet := CDPago;
        CDPago.IndexFieldNames := 'nombres';
        imprimir_reporte(FrMain.wpath+'\reportes\repprimanav.frf');

end;

procedure TFrmNomina.extrae_horas;
var     valor_hora :Currency;
        //cod_nomina :Integer;
        hn,hf,hd,hdi,hdd,hed :Currency;
begin

        hdi := 0;hn := 0;hd := 0;hf := 0;hdd := 0;hed := 0;
        {with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "nom$controlnomina"."fecha" from "nom$controlnomina"');
          SQL.Add('where "nom$controlnomina"."cod_nomina" = :cod_nomina');
          ParamByName('cod_nomina').AsInteger := cod_nomina;
          Open;
          if FormatDateTime('mm',Date) <> FormatDateTime('mm',FieldByName('fecha').AsDateTime) then
             cod_nomina := cod_nomina - 1;
          Close;
        end; }
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"inv$empleado"."nit",');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido"');
          SQL.Add('FROM');
          SQL.Add('"inv$empleado"');
          SQL.Add('INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empleado"."nitempleado")');
          SQL.Add('order by "inv$empleado"."nombre"');
          //SQL.Add('WHERE');
          //SQL.Add('("nom$empleado"."tipo_nomina" BETWEEN 10 AND 20)');
          Open;
          while not Eof do
          begin
            with IBQuery1 do
            begin
              Close;
              verificatransaccion(IBquery1);
              SQL.Clear;
              SQL.Add('SELECT');
              SQL.Add('"nom$horasextras"."horas",');
              SQL.Add('"nom$horasextras"."diurna",');
              SQL.Add('"nom$nomina"."sueldobasico"');
              SQL.Add('FROM');
              SQL.Add('"nom$horasextras"');
              SQL.Add('INNER JOIN "nom$nomina" ON ("nom$horasextras"."cod_nomina" = "nom$nomina"."codigo_nomina") AND ("nom$horasextras"."nit_empleado" = "nom$nomina"."nit_empleado")');
              SQL.Add('WHERE');
              SQL.Add('("nom$horasextras"."cod_nomina" BETWEEN :cod1 AND :cod2) AND');
              SQL.Add('("nom$horasextras"."nit_empleado" = :nit)');
              ParamByName('cod1').AsInteger := nomina_ini;
              ParamByName('cod2').AsInteger := nomina_fin;
              ParamByName('nit').AsInteger := DataQuerys.IBdatos.FieldByName('nit').AsInteger;
              Open;
              while not Eof do
              begin
              valor_hora := FieldByName('sueldobasico').AsCurrency/240;
                case FieldByName('diurna').AsInteger of
                 1:hdi := hdi + FieldByName('horas').AsCurrency; // hora extra diurna//total_horas + (valor_hora * FieldByName('horas').AsCurrency) * 1.25;// hora diurna
                 2:hf := hf + FieldByName('horas').AsCurrency;   // hora extra nocturna
                 3:hd := hd + FieldByName('horas').AsCurrency;   // hora ordinaria dominical diurna
                 4:hn := hn + FieldByName('horas').AsCurrency;   // hora extra dominical diurna
                 5:hdd := hdd + FieldByName('horas').AsCurrency; // hora ordinaria dominical nocturna
                 6:hed := hed + FieldByName('horas').AsCurrency; // hora extra dominical nocturna
                end;
                Next;
              end;
          end;
          if (hdi+hf+hd+hn+hdd+hed) <> 0 then
          begin
          with CDhora do
          begin
            Append;
            FieldValues['nombres'] := DataQuerys.IBdatos.FieldByName('nombre').AsString + ' ' +DataQuerys.IBdatos.FieldByName('apellido').AsString;
            FieldValues['hdiurna'] := Formato(hdi);
            FieldValues['vdiurna'] := (hdi * valor_hora) * valorhoraextra(dataquerys.IBaportes,3);
            FieldValues['hfestivo'] := Formato(hf);
            FieldValues['vfestivo'] := (hf * valor_hora) * valorhoraextra(dataquerys.IBaportes,4);
            FieldValues['hdominical'] := Formato(hd);
            FieldValues['vdominical'] := (hd * valor_hora) * valorhoraextra(dataquerys.IBaportes,5);
            FieldValues['hnocturno'] := Formato(hn);
            FieldValues['vnocturno'] := (hn * valor_hora) *  valorhoraextra(dataquerys.IBaportes,6);
            FieldValues['horad'] := Formato(hdd);
            FieldValues['valorn'] := (hdd * valor_hora) *  valorhoraextra(dataquerys.IBaportes,7);
            FieldValues['horaord'] := (hed);
            FieldValues['vhoraord'] := (hed * valor_hora) * valorhoraextra(dataquerys.IBaportes,10);
            Post;
          end;
          end;
          hdi := 0;
          hd := 0;
          hf := 0;
          hn := 0;
          hdd := 0;
          hed := 0;
          Next;
        end;
        frDBDataSet1.DataSet := CDhora;
        imprimir_reporte(FrMain.wpath + '/reportes/repextrasrec.frf');
        end;
end;

function TFrmNomina.busca_mes(nit:integer): boolean;
var     fecha :tdate;
begin
        if FormatDateTime('mm',Date) = '06' then
           fecha := StrToDate(FormatDateTime('yyyy/01/01',Date))
        else
           fecha := StrToDate(FormatDateTime('yyyy/07/01',Date));
        with DataQuerys.IBdata do
        begin
          Close;
          if Transaction.InTransaction then
              Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$empleado"."fecha_registro"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit;
          Open;
          if fecha < FieldByName('fecha_registro').AsDateTime then
             Result := False
          else
             Result := True;
          Close;
        end;
        Result := True;

end;

function TFrmNomina.busca_sueldo(sueldo:Currency;nit:integer): boolean;
var     fecha2 :TDate;
        codigo :Integer;
        saldo, saldo_actual :Currency;
begin
        Result := True;
        if FormatDateTime('mm',Date) = '06' then
           fecha2 := StrToDate(FormatDateTime('yyyy/01/01',Date))
        else
           fecha2 := StrToDate(FormatDateTime('yyyy/07/01',Date));
        with DataQuerys.IBdata do
        begin
            Close;
            if Transaction.InTransaction then
               Transaction.Commit;
            Transaction.StartTransaction;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"nom$controlnomina"."cod_nomina"');
            SQL.Add('FROM');
            SQL.Add('"nom$controlnomina"');
            SQL.Add('WHERE');
            SQL.Add('("nom$controlnomina"."fecha" = :fecha)');
            ParamByName('fecha').AsDateTime := fecha2;
            Open;
            codigo := FieldByName('cod_nomina').AsInteger;
            codigo_general := codigo;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"nom$nomina"."sueldobasico"');
            SQL.Add('FROM');
            SQL.Add('"nom$nomina"');
            SQL.Add('WHERE');
            SQL.Add('("nom$nomina"."codigo_nomina" >= :codigo) AND');
            SQL.Add('("nom$nomina"."nit_empleado" = :nit)');
            ParamByName('codigo').AsInteger := codigo;
            ParamByName('nit').AsInteger := nit;
            Open;
            while not Eof do
            begin
              if FieldByName('sueldobasico').AsCurrency <> sueldo then
              begin
                 Result := False;
                 Break;
              end;
              Next;
            end;
            Close;
        end;
end;

function TFrmNomina.valor_real(nit,opcion: Integer;sueldobasico:currency): currency;
var     sueldo,mes,dias,horas,transporte :Currency;
        ano,ano1 :Integer;
        fecha_final :TDate;
begin
        transporte := 0;
        sueldo := 0;
        horas := 0;
        with DataQuerys.IBdata do
        begin
            Close;
            if Transaction.InTransaction then
               Transaction.Commit;
            Transaction.StartTransaction;
            SQL.Clear;
            SQL.Add('select "nom$empleado"."fecha_registro" from "nom$empleado"');
            SQL.Add('where "nom$empleado"."nitempleado" = :nit');
            ParamByName('nit').AsInteger := nit;
            Open;
            ano := YearOf(Date);
            ano1 := YearOf(FieldByName('fecha_registro').AsDateTime);
            //fecha_final := StrToDate(IntToStr(ano) + '/12/31');
            dias := DayOfTheMonth(FieldByName('fecha_registro').AsDateTime);
            mes := MonthOfTheYear(FieldByName('fecha_registro').AsDateTime);
            if opcion = 1 then
            begin
              if ano <> ano1 then
                 dias := 180
              else if mes <= 6 then
                 dias := 180//(30 - dias) + ((6 - mes)* 30)
              else
                 dias := (30 - dias) + ((12 - mes)* 30)
            end
            else
            begin
            dias := (30 - dias) + ((12 - mes)* 30);
            if ano <> ano1 then
               dias := 360
            else  if FieldByName('fecha_registro').AsDateTime > StrToDateTime(IntToStr(ano) + '/06/29')then
                 dias := 0;
            end;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"nom$nomina"."sueldobasico",');
            SQL.Add('"nom$nomina"."horas_extras",');
            SQL.Add('"nom$nomina"."transporte"');
            SQL.Add('FROM');
            SQL.Add('"nom$nomina"');
            SQL.Add('WHERE');
            SQL.Add('("nom$nomina"."codigo_nomina" >= :codigo) AND');
            SQL.Add('("nom$nomina"."nit_empleado" = :nit)');
            ParamByName('codigo').AsInteger := codigo_general;
            ParamByName('nit').AsInteger := nit;
            Open;
            while not Eof do
            begin
              sueldo := sueldo + FieldByName('sueldobasico').AsCurrency;
              horas := horas + FieldByName('horas_extras').AsCurrency;
              transporte := transporte + FieldByName('transporte').AsCurrency;
              Next;
            end;
            if opcion = 1 then
            begin
               Result := (((sueldo / 6) + (horas/6) + (transporte / 6))/2);
               Result := SimpleRoundTo((Result/180 * dias),0);
            end
            else
            begin
              Result := (((sueldo / 6)/2));
//            Result := (sueldo / 6) + horas;
//            Result := Result / 2:
              Result := SimpleRoundTo((Result/360 * dias),0)
            end;
        end;
end;

procedure TFrmNomina.Pago_interes;
var     codigo :Integer;
begin
        if cod_inicio = 10 then
           codigo := 1
        else if cod_inicio = 30 then
           codigo := 2
        else if cod_inicio = 40 then
           codigo := 3
        else if cod_inicio = 50 then
           codigo := 4
        else if cod_inicio = 60 then
           codigo := 5;
        IBInteres.Close;
        IBInteres.paramByName('tipo').AsInteger := codigo;
        IBInteres.Open;
        imprimir_reporte(FrMain.wpath + '/reportes/repcesantias.frf');
end;

procedure TFrmNomina.pensiones;
begin
        verificatransaccion(IBpension);
        IBpension.Close;
        IBpension.Open;
        imprimir_reporte(FrMain.wpath + '/reportes/RepPension.frf');
end;

procedure TFrmNomina.FormCreate(Sender: TObject);
begin
{        if DataGeneral.IBTransaction1.InTransaction then
           DataGeneral.IBTransaction1.Commit;
        DataGeneral.IBTransaction1.StartTransaction;}
end;

function TFrmNomina.ExNomina(opcion, ano, Nit: integer): currency;
begin

end;

end.
