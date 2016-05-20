unit UnitCausacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IBDatabase, DB, IBCustomDataSet,
  IBQuery, DBCtrls,Math, pr_Common, pr_TxClasses, JvTypedEdit, JvEdit,DateUtils,
  FR_Class;

type
  TFrmCausacion = class(TForm)
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    Bnomina: TBitBtn;
    Bcerrar: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    IBQuery2: TIBQuery;
    IBTransaction1: TIBTransaction;
    DBagencia: TDBLookupComboBox;
    DataSource1: TDataSource;
    IBagencia: TIBQuery;
    IBTransaction2: TIBTransaction;
    IBQTabla: TIBQuery;
    QueryComprobante: TIBQuery;
    QueryComprobanteID_COMPROBANTE: TIntegerField;
    QueryComprobanteFECHADIA: TDateField;
    QueryComprobanteDESCRIPCION: TMemoField;
    QueryComprobanteTOTAL_DEBITO: TIBBCDField;
    QueryComprobanteTOTAL_CREDITO: TIBBCDField;
    QueryComprobanteESTADO: TIBStringField;
    QueryComprobanteIMPRESO: TSmallintField;
    QueryComprobanteANULACION: TMemoField;
    QueryComprobanteDESCRIPCION1: TIBStringField;
    QueryAuxiliar: TIBQuery;
    QueryAuxiliarID_COMPROBANTE: TIntegerField;
    QueryAuxiliarID_AGENCIA: TSmallintField;
    QueryAuxiliarCODIGO: TIBStringField;
    QueryAuxiliarNOMBRE: TIBStringField;
    QueryAuxiliarDEBITO: TIBBCDField;
    QueryAuxiliarCREDITO: TIBBCDField;
    QueryAuxiliarID_CUENTA: TIBStringField;
    QueryAuxiliarID_COLOCACION: TIBStringField;
    QueryAuxiliarID_IDENTIFICACION: TSmallintField;
    QueryAuxiliarID_PERSONA: TIBStringField;
    QueryAuxiliarMONTO_RETENCION: TIBBCDField;
    QueryAuxiliarTASA_RETENCION: TFloatField;
    IBTransaction3: TIBTransaction;
    IBTransaction4: TIBTransaction;
    IBTransaction5: TIBTransaction;
    report10: TprTxReport;
    IBValor: TIBQuery;
    IBTransaction6: TIBTransaction;
    frReport1: TfrReport;
    procedure FormCreate(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure BnominaClick(Sender: TObject);
  private
  tipo_nomina1,tipo_nomina2 : Integer;
    procedure elimina;
    procedure contable;
    function causapirma(nit, opcion,tipo_n: integer): currency;
    procedure actualiza_saldos;
    function Vvalor(fecha: tdate; nit: integer): currency;
    function servicios(nit: Integer;sueldo:currency): currency;
    function vcesantias(nit: Integer;sueldo:Currency): Currency;
    function extras(nit: integer;fecha:TDate): currency;
    function dias(fecha: tdate): integer;
    procedure VerificaPvacacion(_iNit, _iAgencia: integer;
      _cValor,_cSueldo: Currency);
    procedure ActualizaConsolidadas;
    function Devuelve360(nit: integer): currency;
    function ValidarP360(nit: Integer;_iMes :Integer): Boolean;
    { Private declarations }
  public
  opcion_boton :Integer;
  opcion_causacion :Boolean;
  consecutivo,consec : Integer;
  codigo_oficina :Integer;
  _fFechaActual :TDate;
  published
    procedure causacion;
    procedure causa;
    function causar(oficina,opcion:integer): Currency;
    function buscar(oficina, opcion: integer): Currency;
    procedure auxiliar(codigopuc, consec: Integer; tipo: string;
      valor: Currency);
    procedure comprobante;
    procedure actcomprobante;
    procedure reporte(tipodenomia: Smallint; report3: TprTxReport);

    { Public declarations }
  end;

var
  FrmCausacion: TFrmCausacion;

implementation
uses unitquerys,unitdatamodulo,unitglobal, UnitPrincipal,
  UnitNomina, UnitdataQuerys,Unitvistapreliminar, UnitPantallaProgreso,
  Unitprogreso,UnitGlobales;

{$R *.dfm}

procedure TFrmCausacion.FormCreate(Sender: TObject);
begin
        FrmQuerys := TFrmQuerys.Create(self);
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('select * from "nomina"');
          SQL.Add('where "nomina"."mes" = :mes');
          ParamByName('mes').AsString := FormatDateTime('mm',Date);
          Open;
          if RecordCount = 0 then
          begin
             opcion_causacion := True;
             BACEPTAR.Hint := 'Realiza la Causacion Referente al Mes: '+ FormatDateTime('mmmm',Date)+'.';
             BACEPTAR.Caption := '&Realizar';
          end
          else
          begin
             opcion_causacion := False;
             BACEPTAR.Hint := 'Registra Contablemente la Causacion de '+ FormatDateTime('mmmm',Date)+'.';
             BACEPTAR.Caption := 'R&egistrar';
          end;
          Label1.Caption := Label1.Caption + ': '+FormatDateTime('mmmm " de " yyyy',Date);
        end;

end;

procedure TFrmCausacion.BcerrarClick(Sender: TObject);
begin
         Close;
end;

procedure TFrmCausacion.causacion;
var     nombre: string;
        nit,tipo,tipo_n,vMes :Integer;
        valor,valor1 :Currency;
        valorces :Currency;
        valorext :Currency;
        _cTransporteSer :Currency;
        vfecha :TDate;
        vDias :Currency;
        vExtras :Currency;
        _cTransporteCes :Currency;
        _cPrima360 :Currency;
        _cValorCausar :Currency;
        _bAplicaTransporte :Boolean;
        _cValorPrima :Currency;
        _iMesRegistro :Integer;
        _cValorServicio :Currency;
//        _cValorCon :Currency;
begin
        FrmNomina := TFrmNomina.Create(self);
        if IBTransaction1.InTransaction then
           IBTransaction1.Rollback;
        IBTransaction1.StartTransaction;
        tipo := 0;
        actualiza_saldos;
        with IBQuery2 do
        begin
          Close;
          verificatransaccion(IBQuery2);          
          SQL.Clear;
          SQL.Add('DELETE FROM "nom$tmpcausacion"');
          ExecSQL;
          verificatransaccion(IBQuery2);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"nom$empleado"."nitempleado",');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido",');
          SQL.Add('"nom$empleado"."tipo_nomina",');
          SQL.Add('"nom$empleado"."aux_transporte","nom$empleado"."fecha_registro"');
          SQL.Add('FROM');
          SQL.Add('"inv$empleado"');
          SQL.Add('INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empleado"."nitempleado")');
//          SQL.Add('WHERE "nom$empleado"."nitempleado" = 5506317');
//          SQL.Add('WHERE "nom$empleado"."nitempleado" = 37331145');
          Open;
          Last;
          First;
          FrmProgresos := TFrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Titulo := 'Realizando Proceso de Causacion';
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            nit := IBQuery2.FieldByName('nitempleado').AsInteger;
            nombre := IBQuery2.FieldByName('nombre').AsString + ' ' + IBQuery2.FieldByName('apellido').AsString;
            tipo_n := IBQuery2.FieldByName('tipo_nomina').AsInteger;
            vfecha := FieldByName('fecha_registro').AsDateTime;
            _iMesRegistro := MonthOf(vfecha);
            if tipo_n = 10 then
               tipo := 1
            else if tipo_n = 20 then
               tipo := 1
            else if tipo_n = 30 then
               tipo := 2
            else if tipo_n = 40 then
               tipo := 3
            else if tipo_n = 50 then
               tipo := 4
            else if tipo_n = 60 then
               tipo := 5;
            valor := descuento(DataQuerys.IBselecion,nit,3);
            vMes := StrToInt(FormatDateTime('m',FrMain.fechacartera));
            //Valor cesantias
            valorces := vcesantias(nit,valor);
            //Valor sueldo Servicios
            valor1 := servicios(nit,valor);

            _bAplicaTransporte := True;
            //if valorces = valor then
            //   _bAplicaTransporte := False;
            if vMes > 6 then
              valorext := extras(nit,StrToDate('2011/07/01'))
            else
              valorext := extras(nit,StrToDate('2011/01/01'));
              //valorext := SimpleRoundTo(selobligacion(2,nit)/MonthOf(Date),0);
            frmProgresos.Position := IBQuery2.RecNo;
            frmProgresos.InfoLabel := 'Empleado No : '+IntToStr(IBQuery2.RecNo);
            Application.ProcessMessages;
            with DataQuerys.IBaportes do
            begin
              Close;
              SQL.Clear;
              SQL.Add('insert into "nomina"');
              SQL.Add('values(');
              SQL.Add(':nombre,');
              SQL.Add(':basico,');
              SQL.Add(':transporte,');
              SQL.Add(':extras,');
              SQL.Add(':total,');
              SQL.Add(':dias_cesantias,');
              SQL.Add(':cesantias,');
              SQL.Add(':interes,');
              SQL.Add(':prima_ser,');
              SQL.Add(':prima_nav,');
              SQL.Add(':vacaciones,');
              SQL.Add(':consolidas,');
              SQL.Add(':prima_antiguedad,');
              SQL.Add(':mes,');
              SQL.Add(':dias_prima,:nit,:tipo_nomina,:dias_vacaciones,:prima_vacaciones,');
              SQL.Add(':primav_con,:prima_con,:vacacion_con,:promedio,');
              SQL.Add(':pro_cesantias,:pro_servicio,:pro_extras,:dias_ser,:tipon,:transporteces,');
              SQL.Add(':PRIMAV360,:VALORC)');
              ParamByName('nombre').AsString := nombre;
              ParamByName('basico').AsCurrency:= SimpleRoundTo(valor,0);
                 _cTransporteSer := valor_transporte(nit,1);
                 _cTransporteCes := valor_transporte(nit,2);
              ParamByName('transporte').AsCurrency := _cTransporteSer;//Cesantias para Servicios
              //Extras cesantias
              vExtras := SimpleRoundTo(extras(nit,StrToDate('2011/01/01')),0);//SimpleRoundTo(selobligacion(2,nit)/MonthOf(Date),0);
              //Cambiar Extras
              ParamByName('extras').AsCurrency := vextras;//SimpleRoundTo(selobligacion(2,nit)/MonthOf(Date),0);
              ParamByName('total').AsCurrency := SimpleRoundTo(vextras + valor+_cTransporteSer,0); //SimpleRoundTo((selobligacion(2,nit)/MonthOf(Date))+valor+_cTransporteSer,0);
{              end
              else
              begin
                 ParamByName('extras').AsCurrency := promedio(nit);
                 ParamByName('total').AsCurrency :=  SimpleRoundTo(promedio(nit)+valor,0);
              end;}
                 ParamByName('dias_cesantias').AsCurrency := SimpleRoundTo(interescesantia(valor,nit,7,tipo_n),0);
                 vDias := SimpleRoundTo(interescesantia(valor,nit,7,tipo_n),0);
              if not (StrToInt(FormatDateTime('m',FrMain.fechacartera)) in [UnitGlobal.vMes]) then
              begin
                 if _bAplicaTransporte = False  then
                    _cTransporteCes := 0;
                 ParamByName('cesantias').AsCurrency := ((valorces + vExtras + _cTransporteCes)/360) * vdias; //SimpleRoundTo(interescesantia(valorces,nit,2,tipo_n),0);
                 ParamByName('interes').AsCurrency := SimpleRoundTo((((((valorces + vExtras + _cTransporteCes)/360) * vDias) * 0.12)/360) * vDias,0);//SimpleRoundTo(interescesantia(valorces,nit,1,tipo_n),0);
              end
              else
              begin
                 ParamByName('cesantias').AsCurrency := 0;
                 ParamByName('interes').AsCurrency := 0;
              end;

              if not (StrToInt(FormatDateTime('m',FrMain.fechacartera)) in [6,12]) then
                 ParamByName('prima_ser').AsCurrency := ((valor1 + valorext + _cTransporteSer)/360) * dias(vfecha) //SimpleRoundTo(interescesantia(valor1,nit,10,tipo_n),0)
              else
                 ParamByName('prima_ser').AsCurrency := 0;
              if not (StrToInt(FormatDateTime('m',FrMain.fechacartera)) in [UnitGlobal.vMes]) then
              begin
                if retornadias(vfecha) >= 360 then
                  ParamByName('prima_nav').AsCurrency := SimpleRoundTo(interescesantia(valor1,nit,3,tipo_n),0)
                else
                  ParamByName('prima_nav').AsCurrency := 0;
              end
              else
                  ParamByName('prima_nav').AsCurrency := 0;

              ParamByName('vacaciones').AsCurrency := SimpleRoundTo(vacacionconsolidada(nit,3),0);
              ParamByName('consolidas').AsCurrency := SimpleRoundTo(vacacionconsolidada(nit,1),0);
              ParamByName('prima_antiguedad').AsCurrency := SimpleRoundTo(prima(nit,0),0);
              ParamByName('mes').AsString := FormatDateTime('mm',Date);
              ParamByName('dias_prima').AsCurrency := interescesantia(valor,nit,8,tipo_n);
              ParamByName('nit').AsInteger := nit;
              ParamByName('tipo_nomina').AsInteger := tipo;
              //Aqui Verificar si tiene mas de 360 Dias para hacer el Ajuste

              ParamByName('dias_vacaciones').AsCurrency := vacacionconsolidada(nit,2);
              //
              //ShowMessage(CurrToStr(consolidar(nit,2)));
              //ShowMessage(CurrToStr(interescesantia(valor,nit,4,tipo_n)));
              //Validar si entran en la prima 360

              //if ((SimpleRoundTo(interescesantia(valor,nit,4,tipo_n),0) - consolidar(nit,2)) <= 30000) then
              if ValidarP360(nit,_iMesRegistro) then
              begin
                 _cValorCausar := SimpleRoundTo(interescesantia(valor,nit,4,tipo_n),0);
                 if MonthOf(Date) = 12 then
                 begin
                    _cPrima360 := Devuelve360(nit); //Ojo Revisar Proceso para causaciones
                 end
                 else
                   _cPrima360 := SimpleRoundTo(valor,0)/2;
                 //Se modificaria el valor de las consolidadas
                  VerificaPvacacion(nit,tipo_n,_cValorCausar,valor);
                 // Crear proceso para verificar la causación
              end
              else
              begin
                 _cValorCausar := (SimpleRoundTo(interescesantia(valor,nit,4,tipo_n),0) - consolidar(nit,2));
                 _cPrima360 := 0;
              end;
              paramByName('prima_vacaciones').AsCurrency := SimpleRoundTo(interescesantia(valor,nit,4,tipo_n),0);
              if _cPrima360 > 0 then
                paramByName('primav_con').AsCurrency := 0
              else
                paramByName('primav_con').AsCurrency := consolidar(nit,2);
              //***///***///
              paramByName('prima_con').AsCurrency := consolidar(nit,3);
              paramByName('vacacion_con').AsCurrency := consolidar(nit,1);
              ParamByName('promedio').AsCurrency := valor1;
              ParamByName('pro_cesantias').AsCurrency := valorces;
              ParamByName('pro_servicio').AsCurrency := valor1;
              ParamByName('pro_extras').AsCurrency := valorext;
              ParamByName('dias_ser').AsInteger := dias(vfecha);
              ParamByname('tipon').AsInteger := tipo_n;
              ParamByName('transporteces').AsCurrency := _cTransporteCes;
              //Validamos si ingresamos el valor de la prima 360
              if _cPrima360 = 0 then
                    _cPrima360 := cPrima360(nit);
              ParamByName('PRIMAV360').AsCurrency := _cPrima360;
              ParamByName('VALORC').AsCurrency := _cValorCausar;
              //ShowMessage(CurrToStr(valorces) + ' ' + CurrToStr(valor1) + ' ' + CurrToStr(valorext) + ' ' + IntToStr(dias(vfecha)));
              Execsql;
              Close;
              Transaction.CommitRetaining;
            end;
            IBQuery2.Next
          end;
        Close;
        frmProgresos.Cerrar;
       end;
end;

procedure TFrmCausacion.BACEPTARClick(Sender: TObject);
var _iTipo :Integer;
begin
     _fFechaActual := fFechaActual;
     if opcion_boton = 1 then
     begin
        if opcion_causacion then
        begin
           if (strtoint(FormatDateTime('d',Date)) < 0) then
           begin
             MessageDlg('La Causacion Solo se Realiza despues del 24',mtInformation,[mbok],0);
             Exit;
           end;
           elimina;
           causacion;
           opcion_causacion := False;
           BACEPTAR.Hint := 'Registra Contablemente la Causacion de '+ FormatDateTime('mmmm',Date)+'.';
           BACEPTAR.Caption := 'R&egistrar';
           FrmCausacion.Close;
           FrMain.ReportesCausacin1.Click;
        end
        else
        begin
          if MessageDlg('Seguro de Registrar Contablemente la Causacion?',mtInformation,[mbYes,mbNo],0) = mrYes then // registrar Causacion
          begin
            contable;
          end;
        end;
        end
     else
       begin
        try
          case DbAgencia.KeyValue of
            10,20 :_iTipo := 1;
            30: _iTipo := 2;
            40: _iTipo := 3;
            50: _iTipo := 4;
          end;
          reporte(_iTipo,report10);
        except
        on E: Exception do
          MessageDlg('Debe Seleccionar un Tipo de Nomina',mtInformation,[mbok],0)
        end;
        end;

end;

procedure TFrmCausacion.causa;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('SUM("nomina"."cesantias") AS total,');
          SQL.Add('SUM("nomina"."interes") AS total,');
          SQL.Add('SUM("nomina"."prima_nav") AS total,');
          SQL.Add('SUM("nomina"."vacaciones") AS total,');
          SQL.Add('SUM("nomina"."prima_antiguedad") total,');
          SQL.Add('SUM("nomina"."prima_vacaciones") total');
          SQL.Add('FROM');
          SQL.Add('"nomina"');
          SQL.Add('WHERE');
          SQL.Add('("nomina"."mes" = :mes) AND');
          SQL.Add('("nomina"."tipo_nomina" IN (:tipo1,:tipo2))');
          ParamByName('mes').AsString := FormatDateTime('mm',date);
          ParamByName('tipo1').AsInteger := tipo_nomina1;
          ParamByName('tipo2').AsInteger := tipo_nomina2;
          Open;
          Close;
        end;
end;

function TFrmCausacion.causar(oficina,opcion:integer): Currency;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          if opcion = 99 then
          begin
            SQL.Add('SELECT');
            SQL.Add('sum("nom$consolidado"."prima_vacaciones") as TOTAL');
            SQL.Add('FROM');
            SQL.Add('"nom$consolidado"');
            SQL.Add('INNER JOIN "nom$empleado" ON ("nom$consolidado"."nit" = "nom$empleado"."nitempleado")');
            SQL.Add('WHERE');
            SQL.Add('"nom$empleado"."tipo_nomina" IN (10,20)');
            Open;
            Result := FieldByName('TOTAL').AsCurrency;
          end
          else
          begin
            SQL.Add('SELECT DISTINCT');
            case opcion of
              1: SQL.Add('SUM("nomina"."cesantias") AS total');
              2: SQL.Add('SUM("nomina"."interes") AS total');
              3: SQL.Add('SUM("nomina"."prima_nav") AS total');
              4: SQL.Add('SUM("nomina"."vacaciones") AS total');
              5: SQL.Add('SUM("nomina"."prima_antiguedad") AS total');
              6: SQL.Add('SUM("nomina"."prima_vacaciones") AS total');
              7: SQL.Add('SUM("nomina"."prima_ser") AS total');
              8: SQL.Add('SUM("nomina"."primav_con") AS total');
              9: SQL.Add('SUM("nomina"."prima_con") AS total');
              10:SQL.Add('SUM("nomina"."vacacion_con") AS total');
              11:SQL.Add('SUM("nomina"."consolidas") AS total');
            end;
            SQL.Add('FROM');
            SQL.Add('"nomina"');
            SQL.Add('WHERE');
            SQL.Add('("nomina"."mes" = :mes) AND');
            SQL.Add('("nomina"."tipo_nomina" = :oficina)');
            ParamByName('mes').AsString := FormatDateTime('mm',date);
            ParamByName('oficina').AsInteger := oficina;
            Open;
            Result := FieldByName('total').AsCurrency;
            Close;
          end;
        end;
end;

procedure TFrmCausacion.elimina();
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('delete from "nomina" where "nomina"."mes" = :MES');
          ParamByName('MES').AsString := FormatCurr('00',MonthOf(Date));
          Open;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmCausacion.BnominaClick(Sender: TObject);
begin
        if opcion_boton = 1 then
        begin
           if opcion_causacion = false then
           begin
             if MessageDlg('Esta Seguro de Eliminar La Causación de '+FormatDateTime('mmmm',Date),mtInformation,[mbYes,mbNo],0) = mrYes Then
             begin
               elimina;
               opcion_causacion := True;
               BACEPTAR.Caption := '&Realizar';
               BACEPTAR.Hint := 'Realiza la Causacion Referente al Mes: '+ FormatDateTime('mmmm',Date)+'.';
             end;
           end
           else
           MessageDlg('No Existen Elementos A Eliminar ',mtInformation,[mbOK],0);
        end
        else
        begin
           FrmNomina := TFrmNomina.Create(self);
           verificatransaccion(FrmNomina.IBcausacion);
           FrmNomina._sTipoN := DbAgencia.Text;
           FrmNomina.frDBDataSet1.DataSet := FrmNomina.IBcausacion;
           FrmNomina.IBcausacion.ParamByName('tipo').AsInteger := DBagencia.KeyValue;
           FrmNomina.IBcausacion.ParamByName('MES').AsString := FormatCurr('00',MonthOf(Date));
           FrmNomina.IBcausacion.Open;
           FrmNomina.IB360.Close;
           FrmNomina.IB360.ParamByName('tipo').AsInteger := DBagencia.KeyValue;
           FrmNomina.IB360.ParamByName('MES').AsString := FormatCurr('00',MonthOf(Date));
           FrmNomina.IB360.Open;
           if not (FormatDateTime('mm',Date) = '12') then
           begin
//            if DBagencia.KeyValue = 1 then
               FrmNomina.imprimir_reporte(FrMain.wpath+'reportes\repcausacion.frf')
//            else
//               FrmNomina.imprimir_reporte(frmain.wpath+'reportes\repcausacionagencia1.frf');
           end
           else
           begin
            //if DBagencia.KeyValue = 1 then
            //FrmNomina.imprimir_reporte(frmain.wpath+'reportes\repcausacion.frf')
              //FrmNomina.imprimir_reporte(frmain.wpath+'reportes\repcausacion12.frf')
            //else
               FrmNomina.imprimir_reporte(frmain.wpath+'reportes\repcausacionagencia12.frf');
           end;
        end;
end;

function TFrmCausacion.buscar(oficina, opcion: integer): currency;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          case opcion of
            1: SQL.Add('"nom$causacion"."cesantias" as total');
            2: SQL.Add('"nom$causacion"."interes" as total');
            3: SQL.Add('"nom$causacion"."pnavidad" as total');
            4: SQL.Add('"nom$causacion"."vacaciones" as total');
            5: SQL.Add('"nom$causacion"."pvacaciones" as total');
            6: SQL.Add('"nom$causacion"."prima_antiguedad"as total');
            7: SQL.Add('"nom$causacion"."prima_servicios" as total');
            
          end;
          SQL.Add('FROM');
          SQL.Add('"nom$causacion"');
          SQL.Add('WHERE');
          SQL.Add('("nom$causacion"."mes" = :mes) AND');
          SQL.Add('("nom$causacion"."oficina" = :oficina)');
          ParamByName('oficina').AsInteger := oficina;
          ParamByName('mes').AsString := FormatDateTime('mm',Date-35);
          Open;
          Result := FieldByName('total').AsCurrency;
          Close;
          end;

end;

procedure TFrmCausacion.comprobante;
var     cadena:string;
begin
        cadena := 'CAUSAR GTO PROVI OBLIGACION LABORALES  '+ FormatDateTime('mmmm "de" yyyy',Date);
        consecutivo := ObtenerConsecutivo(FrmQuerys.IBSQL1);
        with FrmQuerys.IBregistro do
        begin
        verificatransaccion(FrmQuerys.IBregistro);
          SQL.Clear;
          SQL.Add('insert into "con$comprobante" ("con$comprobante"."ID_COMPROBANTE",');
          SQL.Add('"con$comprobante"."FECHADIA", "con$comprobante"."TIPO_COMPROBANTE",');
          SQL.Add('"con$comprobante"."ID_AGENCIA", "con$comprobante"."DESCRIPCION",');
          SQL.Add('"con$comprobante"."TOTAL_DEBITO", "con$comprobante"."TOTAL_CREDITO",');
          SQL.Add('"con$comprobante"."ESTADO", "con$comprobante"."IMPRESO",');
          SQL.Add('"con$comprobante"."ANULACION","con$comprobante"."ID_EMPLEADO") ');
          SQL.Add('values (');
          SQL.Add(':"ID_COMPROBANTE", :"FECHADIA", :"TIPO_COMPROBANTE",');
          SQL.Add(':"ID_AGENCIA", :"DESCRIPCION", :"TOTAL_DEBITO",');
          SQL.Add(':"TOTAL_CREDITO", :"ESTADO", :"IMPRESO", :"ANULACION", :"ID_EMPLEADO")');
          ParamByName('ID_COMPROBANTE').AsInteger := consecutivo;
          ParamByname('FECHADIA').AsDate := date;
          ParamByName('ID_AGENCIA').AsInteger := 1;
          ParamByName('TIPO_COMPROBANTE').AsInteger := 1;
          ParamByName('DESCRIPCION').AsString := cadena;
          ParamByName('TOTAL_DEBITO').AsCurrency  := 0;
          ParamByName('TOTAL_CREDITO').AsCurrency  := 0;
          ParamByName('ESTADO').AsString  := 'O';
          ParamByname('ANULACION').asstring := '';
          ParamByName('IMPRESO').AsInteger  := Ord(false);
          ParamByname('ID_EMPLEADO').asstring := UpperCase(FrMain.Dbalias);
          Open;
          Close;
          Transaction.Commit;
        end;

end;

procedure TFrmCausacion.auxiliar(codigopuc, consec: Integer; tipo: string;
  valor: Currency);
var     codigo :string;
        debito,credito :Currency;
begin
        debito := 0;
        credito := 0;
        if tipo = 'D' then
           debito := valor
        else
           credito := valor;
        if (debito <> 0) or (credito <> 0) then
        begin
          with DataQuerys.IBselecion do
          begin
            Close;
            verificatransaccion(DataQuerys.IBselecion);
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"nom$pucbasico"."codigo",');
            SQL.Add('"nom$pucbasico"."descripcion"');
            SQL.Add('FROM');
            SQL.Add('"nom$pucbasico"');
            SQL.Add('WHERE');
            SQL.Add('("nom$pucbasico"."id" = :codigo)');
            ParamByName('codigo').AsInteger := codigopuc;
            Open;
            codigo := FieldByName('codigo').AsString;
            Close;
            Transaction.Commit;
         end;
          with FrmQuerys.IBregistro do
          begin
            Close;
            verificatransaccion(FrmQuerys.IBregistro);
            SQL.Clear;
            SQL.Add('insert into "con$auxiliar" values (');
            SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
            SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
            SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
            ParamByName('ID_COMPROBANTE').asInteger := consec;
            ParamByName('ID_AGENCIA').AsInteger := 1;
            ParamByName('FECHA').AsDate := date;
            ParamByName('CODIGO').AsString := codigo;
            ParamByName('DEBITO').AsCurrency := SimpleRoundTo(debito,0);
            ParamByName('CREDITO').AsCurrency := SimpleRoundTo(credito,0);
            ParamByName('ID_CUENTA').AsString :='';
            ParamByName('ID_COLOCACION').AsString := '';
            ParamByName('ID_IDENTIFICACION').AsInteger := 0;
            ParamByName('ID_PERSONA').AsString :='0';
            ParamByName('MONTO_RETENCION').AsCurrency := 0;
            ParamByName('TASA_RETENCION').AsFloat := 0;
            ParamByName('ESTADOAUX').AsString := 'O';
            Open;
            Close;
            Transaction.Commit;
          end;
         end;
end;

procedure TFrmCausacion.actcomprobante;
var     debito,credito: Currency;
begin
        with FrmQuerys.IBregistro do
        begin
          Close;
          verificatransaccion(FrmQuerys.IBregistro);
          SQL.Clear;
          SQL.Add('select SUM("con$auxiliar"."DEBITO") as debito,SUM("con$auxiliar"."CREDITO") as credito');
          SQL.Add('from "con$auxiliar" where "con$auxiliar"."ID_COMPROBANTE"=:"comprobante"');
          ParamByName('comprobante').AsInteger:=consecutivo;
          Open;
          debito := FieldByName('debito').AsCurrency;
          credito := FieldByName('credito').AsCurrency;
          SQL.Clear;
          SQL.Add('update "con$comprobante" set "con$comprobante".TOTAL_DEBITO =:"debito",');
          SQL.Add('"con$comprobante".TOTAL_CREDITO =:"credito"');
          SQL.Add('where "con$comprobante"."ID_COMPROBANTE"=:"comprobante"');
          ParamByName('comprobante').AsInteger := consecutivo;
          ParamByName('DEBITO').AsCurrency := SimpleRoundTo(debito,0);
          ParamByName('CREDITO').AsCurrency := SimpleRoundTo(credito,0);
          Open;
          Close;
          Transaction.Commit;
        end;
        with DataQuerys.IBaportes do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('insert into "nom$causacion"');
          SQL.Add('Values (');
          SQL.Add(':mes,');
          SQL.Add(':cesantias,');
          SQL.Add(':interes,');
          SQL.Add(':pnavidad,');
          SQL.Add(':vacaciones,');
          SQL.Add(':pvacaciones,');
          SQL.Add(':oficina,');
          SQL.Add(':comprobante,');
          SQL.Add(':prima_antiguedad,');
          SQL.Add(':prima_servicios)');
          ParamByName('mes').AsString := FormatDateTime('mm',Date);
          ParamByName('cesantias').AsCurrency := causar(codigo_oficina,1);
          ParamByName('interes').AsCurrency := causar(codigo_oficina,2);
          ParamByName('pnavidad').AsCurrency := causar(codigo_oficina,3);
          ParamByName('vacaciones').AsCurrency := causar(codigo_oficina,4);
          ParamByName('pvacaciones').AsCurrency := causar(codigo_oficina,8);
          ParamByName('oficina').AsInteger := 1;
          ParamByName('comprobante').AsInteger := consecutivo;
          ParamByName('prima_antiguedad').AsCurrency := causar(codigo_oficina,9);
          ParamByName('prima_servicios').AsCurrency := causar(codigo_oficina,7);
          Open;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmCausacion.reporte(tipodenomia: Smallint;
  report3: TprTxReport);
var     anulacion,tipo_nota: string;
        Tabla,oficina: string;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$causacion"."comprobante"');
          SQL.Add('FROM');
          SQL.Add('"nom$causacion"');
          SQL.Add('WHERE');
          SQL.Add('("nom$causacion"."oficina" = :oficina) AND');
          SQL.Add('("nom$causacion"."mes" = (select max("nom$causacion"."mes")');
          SQL.Add('from "nom$causacion"))');
          ParamByName('oficina').AsInteger := tipodenomia;
          Open;
          consec := FieldByName('comprobante').AsInteger;
          if RecordCount = 0 then
          begin
             MessageDlg('No se ha Registrado contablemente la Causacion',mtInformation,[mbok],0);
             Exit;
          end;
          Close;
        end;
        frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
        with querycomprobante do
        begin
          Close;
          verificatransaccion(QueryComprobante);
          SQL.Clear;
          SQL.Add('Select "con$comprobante".ID_COMPROBANTE,');
          SQL.Add('"con$comprobante".FECHADIA,');
          SQL.Add('"con$comprobante".DESCRIPCION,');
          SQL.Add('"con$comprobante".TOTAL_DEBITO,');
          SQL.Add('"con$comprobante".TOTAL_CREDITO,');
          SQL.Add('"con$comprobante".ESTADO,');
          SQL.Add('"con$comprobante".IMPRESO,');
          SQL.Add('"con$comprobante".ANULACION');
          SQL.Add(',"con$tipocomprobante".DESCRIPCION AS DESCRIPCION1');
          SQL.Add('from ');
          SQL.Add('"con$comprobante"');
          SQL.Add(',"con$tipocomprobante"');
          SQL.Add('where "con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
          SQL.Add('and "con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA"');
          ParamByName('ID_COMPROBANTE').AsString := IntToStr(consec);
          ParamByName('ID_AGENCIA').AsInteger := 1;
          Open;
          anulacion := FieldByName('ANULACION').AsString;
          if anulacion <> '' then
             Report3.Variables.ByName['anulacion'].AsString := 'Anulado por:'
          else
             Report3.Variables.ByName['anulacion'].AsString := '';
        end;
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "Inv$Agencia"."descripcion" from "Inv$Agencia"' );
          SQL.Add('where "Inv$Agencia"."cod_agencia"=:"codigo"');
          ParamByName('codigo').AsInteger:=1;
          Open;
          oficina:=FieldByName('descripcion').AsString;
          Close;
        end;
          tipo_nota:='NOTA CONTABLE';
        with QueryAuxiliar do
        begin
          Close;
          verificatransaccion(QueryAuxiliar);
          SQL.Clear;
          SQL.Add('select ');
          SQL.Add('"con$auxiliar".ID_COMPROBANTE,');
          SQL.Add('"con$auxiliar".ID_AGENCIA,');
          SQL.Add('"con$auxiliar".CODIGO,');
          SQL.Add('"con$puc".NOMBRE,');
          SQL.Add('"con$auxiliar".DEBITO,');
          SQL.Add('"con$auxiliar".CREDITO,');
          SQL.Add('"con$auxiliar".ID_CUENTA,');
          SQL.Add('"con$auxiliar".ID_COLOCACION,');
          SQL.Add('"con$auxiliar".ID_IDENTIFICACION,');
          SQL.Add('"con$auxiliar".ID_PERSONA,');
          SQL.Add('"con$auxiliar".MONTO_RETENCION,');
          SQL.Add('"con$auxiliar".TASA_RETENCION');
          SQL.Add('FROM "con$auxiliar" INNER JOIN "con$puc"');
          SQL.Add('ON ("con$auxiliar"."CODIGO" = "con$puc"."CODIGO")');
          SQL.Add('where "con$auxiliar"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
          SQL.Add('and "con$auxiliar"."ID_AGENCIA" =:"ID_AGENCIA"');
          SQL.Add('order by "con$auxiliar"."CREDITO"');
          ParamByName('ID_COMPROBANTE').AsString :=IntToStr(consec);
          ParamByName('ID_AGENCIA').AsInteger := 1;
          Open;
          Last;
          First;
         end;
           Tabla := '"Comprobante' + FloatToStr(Now)+ '"';
           with IBQTabla do
            begin
              Close;
              verificatransaccion(IBQTabla);
              SQL.Clear;
              SQL.Add('create table ' + Tabla + ' (');
              SQL.Add('CODIGO              CHAR(18),');
              SQL.Add('NOMBRE              CHAR(100),');
              SQL.Add('CREDCTA             CHAR(11),');
              SQL.Add('IDENTIFICACION      CHAR(15),');
              SQL.Add('DEBITO              NUMERIC(15,3),');
              SQL.Add('CREDITO             NUMERIC(15,3))');
              ExecSQL;
              Transaction.CommitRetaining;
              Close;
              SQL.Clear;
              SQL.Add('insert into ' + Tabla + 'values(');
              SQL.Add(':"CODIGO",');
              SQL.Add(':"NOMBRE",');
              SQL.Add(':"CREDCTA",');
              SQL.Add(':"IDENTIFICACION",');
              SQL.Add(':"DEBITO",');
              SQL.Add(':"CREDITO")');
              While not QueryAuxiliar.Eof do
               begin
                 ParamByName('CODIGO').AsString := (QueryAuxiliar.FieldByName('CODIGO').AsString);
                 ParamByName('NOMBRE').AsString := QueryAuxiliar.FieldByName('NOMBRE').AsString;
                 if QueryAuxiliar.FieldByName('ID_CUENTA').AsString <> '0' then
                    ParamByName('CREDCTA').AsString := QueryAuxiliar.FieldByName('ID_CUENTA').AsString
                 else if Trim(QueryAuxiliar.FieldByName('ID_COLOCACION').AsString) <> '' then
                    ParamByName('CREDCTA').AsString := QueryAuxiliar.FieldByName('ID_COLOCACION').AsString
                 else
                    ParamByName('CREDCTA').AsString := '';
                 if Trim(QueryAuxiliar.FieldByName('ID_PERSONA').AsString) <> '0' then
                    ParamByName('IDENTIFICACION').AsString := QueryAuxiliar.FieldByName('ID_PERSONA').AsString
                 else
                    ParamByName('IDENTIFICACION').AsString := '';
                 ParamByName('DEBITO').AsCurrency := QueryAuxiliar.FieldByName('DEBITO').AsCurrency;
                 ParamByName('CREDITO').AsCurrency := QueryAuxiliar.FieldByName('CREDITO').AsCurrency;
                 ExecSql;
                 QueryAuxiliar.Next;
                end;
              Close;
              SQL.Clear;
              SQL.Add('select ');
              SQL.Add('CODIGO,');
              SQL.Add('NOMBRE,');
              SQL.Add('CREDCTA,');
              SQL.Add('IDENTIFICACION,');
              SQL.Add('DEBITO,');
              SQL.Add('CREDITO');
              SQL.Add('from ' + Tabla + ' ');
              SQL.Add('order by CREDITO,CODIGO');
              Open;
              IBQTabla.Last;
              IBQTabla.First;
              IBQTabla.RecordCount;
              report3.Variables.ByName['empresa'].AsString := FrMain.Empresa;
              report3.Variables.ByName['hoy'].AsDateTime := Date;
              report3.Variables.ByName['Empleado'].AsString := empleados(FrmQuerys.IBseleccion,UpperCase(FrMain.Dbalias));
              report3.Variables.ByName['Nit'].AsString := FrMain.Nit;
              report3.Variables.ByName['oficina'].AsString := oficina;
              report3.Variables.ByName['tiponota'].AsString := tipo_nota;
              if report3.PrepareReport then
               begin
                 frmVistaPreliminar.Reporte := Report3;
                 frmVistaPreliminar.ShowModal;
               end;
              IBQTabla.Close;
              Transaction.CommitRetaining;
              with IBQTabla do
              begin
                SQL.Clear;
                SQL.Add('drop table ' + Tabla);
                ExecSQL;
                IBQTabla.Close;
                Transaction.CommitRetaining;
              end;
            end; // Fin With IBQTabla
          QueryAuxiliar.Close;
          consecutivo:=0;
end;

procedure TFrmCausacion.contable;
var     valor :Currency;
        pVacaciones,pAntiguedad,Vacaciones :Currency;
        mes :Integer;
        _cValorConsolidado :Currency;
        _iCodPuc :Integer;
        _cValorCausado :Currency;
begin
        mes := MonthOf(Date);
        FrmProgreso := TFrmProgreso.Create(self);
        FrmProgreso.Barra.Maximum := 11;
        FrmProgreso.Show;
        FrmProgreso.Barra.Position := 1;
        if FormatDateTime('mm',Date) = '01' then
        begin
          with DataQuerys.IBdatos do
          begin
            Close;
            verificatransaccion(DataQuerys.IBdatos);
            SQL.Clear;
            SQL.Add('delete from "nom$causacion"');
            Open;
            Close;
            Transaction.Commit;
          end;
        end;
        comprobante;
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"Inv$Agencia"."cod_agencia"');
          SQL.Add('FROM');
          SQL.Add('"Inv$Agencia"');
//          SQL.Add('where "Inv$Agencia"."cod_agencia" = 1');
          Open;
          {SQL.Clear;
          SQL.Add('select "nom$tiponomina"."codigo" from "nom$tiponomina"');
          SQL.Add('where "nom$tiponomina"."codigo" in (10,20)');
          Open;}
          FrmProgreso.Barra.Position := 2;
          while not Eof do
          begin
            codigo_oficina := FieldByName('cod_agencia').AsInteger;
              _cValorConsolidado := 0;
              with DataQuerys.IBselecion do
              begin
                 Close;
                 SQL.Clear;
                 SQL.Add('SELECT');
                 SQL.Add('"nom$tmpcausacion".ID_AGENCIA,');
                 SQL.Add('"nom$tmpcausacion".NIT,');
                 SQL.Add('"nom$tmpcausacion".SUELDO,');
                 SQL.Add('"nom$tmpcausacion".VALOR');                 
                 SQL.Add('FROM');
                 SQL.Add('"nom$tmpcausacion"');
                 SQL.Add('WHERE "nom$tmpcausacion".ID_AGENCIA = :ID');
                 ParamByName('ID').AsInteger := codigo_oficina;
                 Open;
                 while not Eof do
                 begin
                    //Insertar Movimiento en tabla 360
                    _cValorCausado := FieldByName('VALOR').AsCurrency;
                    with DataQuerys.IBdatos do
                    begin
                        verificatransaccion(DataQuerys.IBdatos);
                        SQL.Clear;
                        SQL.Add('INSERT INTO');
                        SQL.Add('  NOM$CAUSACION360(');
                        SQL.Add('  NIT,');
                        SQL.Add('  VALOR,');
                        SQL.Add('  AGENCIA)');
                        SQL.Add('VALUES(');
                        SQL.Add('  :NIT,');
                        SQL.Add('  :VALOR,');
                        SQL.Add('  :AGENCIA)');
                        ParamByName('NIT').AsInteger :=  DataQuerys.IBselecion.FieldByName('NIT').AsInteger;
                        ParamByName('VALOR').AsCurrency :=  DataQuerys.IBselecion.FieldByName('SUELDO').AsCurrency;
                        ParamByName('AGENCIA').AsInteger :=  DataQuerys.IBselecion.FieldByName('ID_AGENCIA').AsInteger;
                        ExecSQL;
                        Transaction.Commit;
                    end;
                    _cValorConsolidado := _cValorConsolidado + FieldByName('SUELDO').AsCurrency - _cValorCausado;
                    Next;
                 end; //Fin del While

              end; // fin del With

              //Contabilizar valor en las consolidadas
              if _cValorConsolidado > 0 then
              begin
                 case codigo_oficina of
                   2 : _iCodPuc := 38;
                   3 : _iCodPuc := 22;
                   4 : _iCodPuc := 57;
                   5 : _iCodPuc := 65;
                 end;
                 if codigo_oficina = 1 then
                 begin
//                   auxiliar(27,consecutivo,'D',_cValorConsolidado);
                   auxiliar(33,consecutivo,'D',_cValorConsolidado);
                   auxiliar(52,consecutivo,'C', _cValorConsolidado);
                 end
                 else
                 begin
                   auxiliar(_iCodPuc,consecutivo,'D',_cValorConsolidado);
                   auxiliar(52,consecutivo,'C', _cValorConsolidado);
                 end;
              end;

            if codigo_oficina = 1 then
            begin
              FrmProgreso.Barra.Position := 3;
//              comprobante;
              if not (StrToInt(FormatDateTime('m',FrMain.fechacartera)) in [12]) then
              begin
                valor := causar(codigo_oficina,1) - buscar(codigo_oficina,1);// actualiza los auxiliares de cesantias
                auxiliar(23,consecutivo,'C',valor);
                auxiliar(29,consecutivo,'D',valor);
              end;
              FrmProgreso.Barra.Position := 4;
              if not (StrToInt(FormatDateTime('m',FrMain.fechacartera)) in [12]) then
              begin
                 valor := causar(codigo_oficina,2) - buscar(codigo_oficina,2);// actualiza los auxiliasres de los intereses
                 auxiliar(24,consecutivo,'C',valor);
                 auxiliar(30,consecutivo,'D',valor);
              end;
              FrmProgreso.Barra.Position := 5;
              if not (StrToInt(FormatDateTime('m',FrMain.fechacartera)) in [12]) then
              begin
                valor := causar(codigo_oficina,3) - buscar(codigo_oficina,3);// actualiza los auxiliasres de prima de navidad
                auxiliar(36,consecutivo,'C',valor);
                auxiliar(34,consecutivo,'D',valor);
              end;
              FrmProgreso.Barra.Position := 6;

              valor := (causar(codigo_oficina,11)-causar(codigo_oficina,10)) - buscar(codigo_oficina,4); // actualiza las vacaciones
              FrmProgreso.Barra.Position := 7;
              if mes < 12 then
                 auxiliar(25,consecutivo,'C',valor);
              Vacaciones := valor;
              auxiliar(32,consecutivo,'D',valor);

              valor := (causar(codigo_oficina,5)-causar(codigo_oficina,9)) - buscar(codigo_oficina,6);// actualiza los auxiliasres de prima de antiguedad
              FrmProgreso.Barra.Position := 8; // prima de antiguedad
              if mes < 12 then
                 auxiliar(28,consecutivo,'C',valor);
              pAntiguedad := valor;
              auxiliar(35,consecutivo,'D',valor);

              //****Proceso de Prima de Vacaciones y consolidadas
              valor := (causar(codigo_oficina,6)-causar(codigo_oficina,8)) - buscar(codigo_oficina,5);// actualiza los auxiliasres de prima de Vacaciones
              FrmProgreso.Barra.Position := 9; // prima de vacaciones
              pVacaciones := valor;
              if mes < 12 then
                 auxiliar(27,consecutivo,'C',valor);
              auxiliar(33,consecutivo,'D',valor);

              if not (StrToInt(FormatDateTime('m',FrMain.fechacartera)) in [6,12]) then
              begin
                 valor := causar(codigo_oficina,7) - buscar(codigo_oficina,7);// actualiza los auxiliasres de prima de servicios
                 auxiliar(26,consecutivo,'C',valor);
                 auxiliar(31,consecutivo,'D',valor);
                 FrmProgreso.Barra.Position := 10;
              end;
              FrmProgreso.Barra.Position := 11;
              if FormatDateTime('mm',Date) = '12' then  // TRASLADO DE FIN DE AÑO A CONSOLIDADAS
              begin
                 valor := Abs(saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),28,1));// PRIMA DE ANTIGUEDAD
                 auxiliar(28,consecutivo,'D',valor);
                 auxiliar(53,consecutivo,'C',valor + pAntiguedad);

                 valor := Abs(saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),27,1));// PRIMA DE VACACIONES
                 auxiliar(27,consecutivo,'D',valor);
                 auxiliar(52,consecutivo,'C', valor + pVacaciones);

                 valor := Abs(saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),25,1));// VACACIONES
                 auxiliar(25,consecutivo,'D',valor);
                 auxiliar(51,consecutivo,'C',valor + Vacaciones);
              end;

            end;
              DataQuerys.IBingresa.Next;
          end;
          actcomprobante; // fin del valida oficina
          Close;
        end;
        ActualizaConsolidadas;
        ActualizaCon;
        verificatransaccion(DataQuerys.IBdatos);
        verificatransaccion(DataQuerys.IBselecion);
        FrmProgreso.Hide;
        BACEPTAR.Enabled := False;
end;

function TFrmCausacion.causapirma(nit, opcion,tipo_n: integer): currency;
var     fechaa :Integer;
        dias_actuales,valor_dias,valor:Currency;
        fecha_registro :string;
        fecha_prima5,fecha_prima9 :string;
begin
        valor := descuento(DataQuerys.IBselecion,nit,3);
        dias_actuales := interescesantia(valor,nit,8,tipo_n) - totaldias(nit);
        if dias_actuales <= 0 then
           dias_actuales := interescesantia(valor,nit,8,tipo_n);
        if opcion = 1 then
          valor_dias := valor/720
        else
        begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$empleado"."fecha_registro"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit;
          Open;
          fecha_registro := FormatDateTime('yyyy/mm/dd',FieldByName('fecha_registro').AsDateTime);
          Close;
        end;
        fechaa := StrToInt(FormatDateTime('yyyy',StrToDate(fecha_registro)));
        fecha_prima5 := FormatDateTime(IntToStr(fechaa+4)+'/mm/01',StrToDate(fecha_registro));
        fecha_prima9 := FormatDateTime(IntToStr(fechaa+9)+'/mm/01',StrToDate(fecha_registro));
        if Int(Date-5) >= Int(StrToDate(fecha_prima9)) then
           valor_dias := (valor/360)
        else if Int(Date-5) >= Int(StrToDate(fecha_prima5)) then
           valor_dias := (valor/720)
        else
           valor_dias := 0;
        end;
        Result := SimpleRoundTo((dias_actuales*valor_dias),0);
end;

procedure TFrmCausacion.actualiza_saldos;
begin
        with DataQuerys.IBaportes do
        begin
          Close;
          verificatransaccion(DataQuerys.IBaportes);
          SQL.Clear;
          SQL.Add('update "nom$causacion" set');
          SQL.Add('"nom$causacion"."cesantias" = :cesantias,');
          SQL.Add('"nom$causacion"."interes" = :interes,');
          SQL.Add('"nom$causacion"."pnavidad" = :pnavidad,');
          SQL.Add('"nom$causacion"."vacaciones" = :vacaciones,');
          SQL.Add('"nom$causacion"."pvacaciones" = :pvacaciones,');
          SQL.Add('"nom$causacion"."prima_antiguedad" = :prima_antiguedad,');
          SQL.Add('"nom$causacion"."prima_servicios" = :prima_servicios');
          SQL.Add('where "nom$causacion"."mes" = :mes');
          ParamByName('cesantias').AsCurrency := saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),23,1);
          ParamByName('interes').AsCurrency := saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),24,1);
          ParamByName('pnavidad').AsCurrency := saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),36,1);
          ParamByName('vacaciones').AsCurrency := saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),25,1);
          ParamByName('pvacaciones').AsCurrency := saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),27,1);
          ParamByName('prima_antiguedad').AsCurrency := saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),28,1);
          ParamByName('prima_servicios').AsCurrency := saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),26,1);
          ParamByName('mes').AsString := FormatDateTime('mm',FrMain.fechacartera - 35);
          Open;
          Close;
          Transaction.Commit;
        end;
end;

function TFrmCausacion.Vvalor(fecha: tdate; nit: integer): currency;
begin
        with IBValor do
        begin
          Close;
          ParamByName('FECHA').AsDate := StrToDate('2011/01/01');
          ParamByName('ID').AsInteger := nit;
          Open;
          Result := FieldByName('PROMEDIO').AsCurrency;
        end;
end;

function TFrmCausacion.servicios(nit: Integer;sueldo:Currency): currency;
var codigo:Integer;
    verifica :Boolean;
begin
        verifica := False;
        with DataQuerys.IBselecion do
        begin
          verificatransaccion(DataQuerys.IBaportes);
          Close;
          SQL.Clear;
          SQL.Add('select max("nom$controlnomina"."cod_nomina") - 4 as codigo from "nom$controlnomina"'); //ojo en el -1 habia un -4
          Open;
          codigo := FieldByName('codigo').AsInteger;
          SQL.Clear;
          SQL.Add('select "nom$nomina"."sueldobasico" from "nom$nomina" where "nom$nomina"."nit_empleado" = :nit and "nom$nomina"."codigo_nomina" >= :codigo');
          ParamByName('nit').AsInteger := nit;
          ParamByName('codigo').AsInteger := codigo;
          Open;
          while not Eof do
          begin
            if FieldByName('sueldobasico').AsCurrency <> sueldo then
            begin
              verifica := True;
              Break;
            end;
            Next;
          end;
          if verifica then
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('sum("nom$nomina"."sueldobasico")/count("nom$nomina"."sueldobasico") as promedio');
            SQL.Add('FROM');
            SQL.Add(' "nom$nomina"');
            SQL.Add(' INNER JOIN "nom$controlnomina" ON ("nom$nomina"."codigo_nomina"="nom$controlnomina"."cod_nomina")');
            SQL.Add('WHERE');
            SQL.Add('  ("nom$controlnomina"."fecha" >= :FECHA) AND');
            SQL.Add('  ("nom$nomina"."nit_empleado" = :ID)');
            ParamByName('FECHA').AsDateTime := StrToDate('2011/01/01');
            ParamByName('ID').AsInteger := nit;
            Open;
            Result := FieldByName('promedio').AsCurrency;
          end
          else
            Result := sueldo;
        end;
end;

function TFrmCausacion.extras(nit: Integer;fecha:TDate): currency;
begin
        with DataQuerys.IBselecion do
        begin
          verificatransaccion(DataQuerys.IBaportes);
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('sum("nom$nomina"."horas_extras")/count("nom$nomina"."horas_extras") as promedio');
          SQL.Add('FROM');
          SQL.Add(' "nom$nomina"');
          SQL.Add(' INNER JOIN "nom$controlnomina" ON ("nom$nomina"."codigo_nomina"="nom$controlnomina"."cod_nomina")');
          SQL.Add('WHERE');
          SQL.Add('  ("nom$controlnomina"."fecha" >= :FECHA) AND');
          SQL.Add('  ("nom$nomina"."nit_empleado" = :ID) AND');
          SQL.Add('("nom$nomina"."horas_extras" > 0)');
          ParamByName('FECHA').AsDate := fecha;
          ParamByName('ID').AsInteger := nit;
          Open;
          Result := FieldByName('promedio').AsCurrency;
        end;

end;

function TFrmCausacion.dias(fecha: TDate): integer;
var    no_dias,dias,ano_actual,ano_anterior,mes_actual,mes_entrada :Integer;
       valida :Boolean;
begin
        valida := False;
        mes_entrada := StrToInt(FormatDateTime('m',fecha));
        no_dias := StrToInt(FormatDateTime('d',fecha)) - 1;
        if no_dias = 0 then
           no_dias := 30
        else
           no_dias := 30 - no_dias;
           dias := no_dias;
        ano_actual := StrToInt(FormatDateTime('yyyy',Date));
        ano_anterior := StrToInt(FormatDateTime('yyyy',fecha));
        if ano_actual <> ano_anterior then
        begin
          valida := True;
          no_dias := 30;
          mes_actual := StrToInt(FormatDateTime('m',Date));
        end
        else
          mes_actual := strtoint(FormatDateTime('m',date));// - StrToInt(FormatDateTime('m',fecha));
        if Date < StrToDate('2011/07/01') then
        begin
          if valida then
             Result := 30 * (mes_actual)//Result := 30 * (mes_actual - 6)
          else
          begin
            if fecha > StrToDate('2011/01/01') then
            begin
               Result := (30 * (mes_actual - mes_entrada)) + no_dias;
            end
            else
              Result := 30 * (mes_actual - 6);
          end;
        end
        else
        begin
            if fecha > StrToDate('2011/07/01') then
            begin
               Result := (30 * (mes_actual - mes_entrada)) + no_dias;
            end
            else
              Result := 30 * (mes_actual - 6);
        end;
end;

procedure TFrmCausacion.VerificaPvacacion(_iNit, _iAgencia: integer;
  _cValor,_cSueldo: Currency);
var _cConsolidada :Currency;
    _cDiferencia :Currency;
    _cSueldoAnt :Currency;
begin
        case _iAgencia of
        10,20 :_iAgencia := 1;
        30:_iAgencia := 2;
        40:_iAgencia := 3;
        50:_iAgencia := 4;
        60:_iAgencia := 5;
        end;
        _cSueldoAnt := Devuelve360(_iNit);
        with DataQuerys.IBselecion do
        begin
          verificatransaccion(DataQuerys.IBselecion);
          Close;
          SQL.Clear;
          SQL.Add('select');
          SQL.Add('"nom$consolidado"."prima_vacaciones"');
          SQL.Add('from "nom$consolidado"');
          SQL.Add('where "nom$consolidado"."nit" = :NIT');
          ParamByName('NIT').AsInteger := _iNit;
          Open;
          _cConsolidada := FieldByName('prima_vacaciones').AsCurrency;
//          _cDiferencia := (_cSueldo/2) - _cConsolidada;
             _cDiferencia := 1;
          if _cDiferencia > 0 Then
          begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO');
            SQL.Add('"nom$tmpcausacion"(');
            SQL.Add('ID_AGENCIA,');
            SQL.Add('NIT,');
            SQL.Add('VALOR,');
            SQL.Add('SUELDO)');
            SQL.Add('VALUES(:ID_AGENCIA,');
            SQL.Add(':NIT,');
            SQL.Add(':VALOR,:SUELDO)');
            ParamByName('NIT').AsInteger := _iNit;
            ParamByName('ID_AGENCIA').AsInteger := _iAgencia;
            ParamByName('VALOR').AsCurrency := _cConsolidada;
            if MonthOf(Date) = 12 then
               ParamByName('SUELDO').AsCurrency := _cSueldoAnt
            else
               ParamByName('SUELDO').AsCurrency := (_cSueldo/2);
            ExecSQL;
            Transaction.Commit;
          end
        end;

end;

procedure TFrmCausacion.ActualizaConsolidadas;
begin
        verificatransaccion(DataQuerys.IBdatos);
        with DataQuerys.IBselecion do
        begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT');
           SQL.Add('"nom$tmpcausacion".ID_AGENCIA,');
           SQL.Add('"nom$tmpcausacion".NIT,');
           SQL.Add('"nom$tmpcausacion".SUELDO');
           SQL.Add('FROM');
           SQL.Add('"nom$tmpcausacion"');
           Open;
           while not Eof do
           begin
              DataQuerys.IBdatos.Close;
              DataQuerys.IBdatos.SQL.Clear;
              DataQuerys.IBdatos.SQL.Add('update');
              DataQuerys.IBdatos.SQL.Add('"nom$consolidado"');
              DataQuerys.IBdatos.SQL.Add('set "nom$consolidado"."prima_vacaciones" = :VALOR');
              DataQuerys.IBdatos.SQL.Add('where "nom$consolidado"."nit" = :NIT');
              DataQuerys.IBdatos.ParamByName('NIT').AsInteger := DataQuerys.IBselecion.FieldByName('NIT').AsInteger;
              DataQuerys.IBdatos.ParamByName('VALOR').AsCurrency := DataQuerys.IBselecion.FieldByName('SUELDO').AsCurrency;
              DataQuerys.IBdatos.ExecSQL;
              Next;
           end; //Fin del While
        end; // fin del With
        DataQuerys.IBdatos.Transaction.Commit;
end;

function TFrmCausacion.Devuelve360(nit: integer): Currency;
var
        _cPrima :Currency;
begin
        _cPrima := 0;
        with DataQuerys.IBselecion do
        begin
          verificatransaccion(DataQuerys.IBselecion);
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('  "nom$nomina"."sueldobasico"');
          SQL.Add('FROM');
          SQL.Add('  "nom$nomina"');
          SQL.Add('WHERE');
          SQL.Add('  "nom$nomina"."codigo_nomina" = 82 AND');
          SQL.Add('  "nom$nomina"."nit_empleado" = :NIT');
          ParamByName('NIT').AsInteger := nit;
          Open;
          Result := FieldByName('sueldobasico').AsCurrency/2;
        end;
end;

function TFrmCausacion.ValidarP360(nit: Integer;_iMes :Integer): Boolean;
var
        _cValorConsolidado :Currency;
        _iMesActual: Integer;
begin
        _iMesActual := MonthOf(_fFechaActual);
        _cValorConsolidado := consolidar(nit,2);
        if (_cValorConsolidado > 0) and (_iMesActual = _iMes) then
           Result := True
        else
           Result := False;

end;

function TFrmCausacion.vcesantias(nit: Integer;
  sueldo: Currency): Currency;
var codigo:Integer;
    verifica :Boolean;
begin
        verifica := False;
        with DataQuerys.IBselecion do
        begin
          verificatransaccion(DataQuerys.IBaportes);
          Close;
          SQL.Clear;
          SQL.Add('select max("nom$controlnomina"."cod_nomina") - 2 as codigo from "nom$controlnomina"'); //ojo en el -1 habia un -4
          Open;
          codigo := FieldByName('codigo').AsInteger;
          SQL.Clear;
          SQL.Add('select "nom$nomina"."sueldobasico" from "nom$nomina" where "nom$nomina"."nit_empleado" = :nit and "nom$nomina"."codigo_nomina" >= :codigo');
          ParamByName('nit').AsInteger := nit;
          ParamByName('codigo').AsInteger := codigo;
          Open;
          while not Eof do
          begin
            if FieldByName('sueldobasico').AsCurrency <> sueldo then
            begin
              verifica := True;
              Break;
            end;
            Next;
          end;
          if verifica then
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('sum("nom$nomina"."sueldobasico")/count("nom$nomina"."sueldobasico") as promedio');
            SQL.Add('FROM');
            SQL.Add(' "nom$nomina"');
            SQL.Add(' INNER JOIN "nom$controlnomina" ON ("nom$nomina"."codigo_nomina"="nom$controlnomina"."cod_nomina")');
            SQL.Add('WHERE');
            SQL.Add('  ("nom$controlnomina"."fecha" >= :FECHA) AND');
            SQL.Add('  ("nom$nomina"."nit_empleado" = :ID)');
            ParamByName('FECHA').AsDateTime := StrToDate('2011/01/01');
            ParamByName('ID').AsInteger := nit;
            Open;
            Result := FieldByName('promedio').AsCurrency;
          end
          else
            Result := sueldo;
        end;
end;

end.
