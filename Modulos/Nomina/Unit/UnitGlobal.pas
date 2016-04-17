unit UnitGlobal;

interface
Uses pr_Common, pr_TxClasses,Forms, StdCtrls, DBCtrls, IB, IBSQL,IBQuery , Messages,SysUtils,Math,DB,DBGrids,Windows,Controls, StrUtils,Classes,Dialogs, winspool, Printers,DateUtils;
type
  rete = record
    tasa:Currency;
    monto:Currency;
end;

procedure Numerico(Sender:TObject;var Key:Char);
procedure verificatransaccion(IBQuery1: TIBQuery);
procedure Num(Sender: TObject; var Key: Char);
function buscanomina(IBQuery1: TIBQuery): integer;
function valorhoraextra(IBquery1: TIBQuery;codigo:Integer): currency;
function horaextra(IBQuery1: TIBQuery; nit: integer): currency;
function cobro(IBQuery1: TIBQuery; nit: integer): Currency;
function fsp(IBQuery1: TIBQuery; nit: integer): Currency;
function deduccion(IBQuery1: TIBQuery; opcion: Integer; nit:integer): Currency;
function buscacodigopuc(IBQuery1: TIBQuery; opcion, nit: integer): Integer;
function retefuente(IBQuery1: TIBQuery;nit,opcion: Integer;valor:currency): Currency;
function nomina(IBQuery1: TIBQuery; opcion, tipo, nit: integer): currency;
function ObtenerConsecutivo(IBSQL1: TIBSQL): Longint;
function empleados(IBquery1:TIBQuery;dbalias: string): string;
function descuento(IBQuery1: TIBQuery; nit, opcion: integer): Currency;
function ObtenerConsecutivobarrido(IBSQL1: TIBSQL): LongInt;
function interescesantia(valor: Currency;nit:integer;opcion,tipo:integer): currency;
function vacacionconsolidada(nit,opcion: integer): currency;
function prima(nit, opcion: integer): currency;
procedure consignacion(cuenta, consecutivo: Integer; valor: currency;cadena:string);
procedure actualizarcomprobante(consecutivo: integer);
function comprobantes(cadena,tipo:string): integer;
procedure auxiliarcon(codigopuc, consecutivo: Integer; tipo: string;
  valor: Currency);
procedure auxiliaraho(codigopuc, consecutivo, nit: Integer; tipo: string;
  valor: Currency; cuenta: string);
procedure verifica(IBSQL1: TIBSQL);
procedure obligacion(tipo, nit: integer; valor: currency);
function selobligacion(tipo, nit: integer): currency;
function tipo_agencia(consecutivo: integer): string;
function totaldias(nit: integer): integer;
function tabla: boolean;
procedure iniciaano;
procedure consolidadas;
function Oconsolidada(nit, opcion: integer): currency;
procedure hora(nit: Integer;valor:currency);
function promedio(nit: integer): Currency;
function consolidar(nit,opcion: integer): currency;
function saldo_cuenta(mes: string;codigopuc,id_agencia: integer): currency;
procedure actualiza_fondo;
function ibc(IBquery1: TIBQuery; nit_empleado: integer): currency;
function aux_transporte(IBQuery1: TIBQuery; nit,tipo_nomina: integer): Currency;
procedure actualiza_consolidados;
function interes(nit: integer): currency;
function valor_transporte(nit,tipo:integer): Currency;
function tasaretefuente(nit: integer): rete;
function pension(nit, codigo: integer): currency;
function nDias(nit, opcion: integer): currency;
function vCodigoPuc(nit: integer): integer;
function vCodigoPucCXC(nit,opcion: integer): Integer;
var
  vTotalOficina :Currency;
  vMes :Integer;

function BuscaCol(vId_Colocacion: string): boolean;
function retornadias(fecha: tdate): integer;
function procesantia(nit: Integer; sueldo: currency): currency;
function proservicios(fecha: tdate; nit: integer): currency;
function diasservicio(fecha: TDate): integer;
function serextras(nit: Integer; fecha: TDate): currency;
function cPrima360(nit: integer): Currency;
procedure ActualizaCon;
implementation
uses unitquerys,Unitglobales,Unitdataquerys,UnitPrincipal,UnitVIstapreliminar,UnitRealizanomina;

procedure Numerico(Sender:TObject;var Key:Char);
begin
if not (Key in [#8,#13, '0'..'9', '-']) then
  begin
    Key := #0;
  end; //End First if.
{  else
  if ((Key = DecimalSeparator) or (Key = '-')) and (Pos(Key, TMemo(Sender).Text ) > 0) then
  begin
    Key := #0;
  end//End second if.
  else
  if (Key = '-') and (TMemo(Sender).SelStart <> 0) then
  begin
    Key := #0;
  end;//End third if.}
end;

procedure verificatransaccion(IBQuery1: TIBQuery);
begin
        with IBQuery1 do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
        end;
end;

procedure Num(Sender: TObject; var Key: Char);
begin
if not (Key in [#8,#13, '0'..'9','.']) then
  begin
    Key := #0;
  end;
end;

function buscanomina(IBQuery1: TIBQuery): Integer;
begin
        with ibquery1 do
        begin
          Close;
          verificatransaccion(ibquery1);
          SQL.Clear;
          SQL.Add('select "nom$controlnomina"."cod_nomina" from "nom$controlnomina"');
          SQL.Add('where "nom$controlnomina"."liquidada" = 0');
          Open;
          Result := FieldByName('cod_nomina').AsInteger;
          Close;
        end;
end;

function valorhoraextra(IBquery1: TIBQuery;codigo:Integer): currency;
begin
        with IBquery1 do
        begin
          Close;
          verificatransaccion(IBquery1);
          SQL.Clear;
          SQL.Add('select "nom$general"."valor" from "nom$general"');
          SQL.Add('where "nom$general"."codigo" = :codigo');
          ParamByName('codigo').AsInteger := codigo;
          Open;
          Result := FieldByName('valor').AsCurrency;
          Close;
        end;
end;

function horaextra(IBQuery1: TIBQuery; nit: integer): Currency;
var     cod_nomina : Integer;
        valor_hora : Currency;
        total_horas : Currency;
begin
        valor_hora := descuento(IBQuery1,nit,3)/240;
        cod_nomina := buscanomina(IBQuery1);
        total_horas := 0;
        with IBQuery1 do
        begin
          Close;
          verificatransaccion(IBquery1);
          SQL.Clear;
          SQL.Add('select "nom$horasextras"."horas","nom$horasextras"."diurna" from "nom$horasextras"');
          SQL.Add('where "nom$horasextras"."cod_nomina" = :cod_nomina and');
          SQL.Add('"nom$horasextras"."nit_empleado" = :nit');
          ParamByName('cod_nomina').AsInteger := cod_nomina;
          ParamByName('nit').AsInteger := nit;
          Open;
          while not Eof do
          begin
          case FieldByName('diurna').AsInteger of
             1:total_horas := total_horas + (valor_hora * FieldByName('horas').AsCurrency) * valorhoraextra(DataQuerys.ibquery1,3);// hora extra diurna
             2:total_horas := total_horas + (valor_hora * FieldByName('horas').AsCurrency) * valorhoraextra(dataquerys.ibquery1,4);// hora extra nocturna
             3:total_horas := total_horas + (valor_hora * FieldByName('horas').AsCurrency) * valorhoraextra(dataquerys.ibquery1,5);// hora ordinaria dominical
             4:total_horas := total_horas + (valor_hora * FieldByName('horas').AsCurrency) * valorhoraextra(dataquerys.IBQuery1,6);// hora extra nocturna dominical
             5:total_horas := total_horas + (valor_hora * FieldByName('horas').AsCurrency) * valorhoraextra(dataquerys.IBQuery1,7);// hora extra diurna dominical
             6:total_horas := total_horas + (valor_hora * FieldByName('horas').AsCurrency) * valorhoraextra(dataquerys.IBQuery1,10);// hora extra dominical nocturna
             7:total_horas := total_horas + (valor_hora * FieldByName('horas').AsCurrency) * valorhoraextra(dataquerys.IBQuery1,11);// hora extra con solo recargo
          end;
            Next;
          end;
          Result := SimpleRoundTo(total_horas,0);
          Close;
        end;
end;

function descuento(IBQuery1: TIBQuery; nit, opcion: integer): Currency;
var      cod_nomina : Integer;
         valor_mes,no_dias : Currency;
         fecha_registro :TDate;
         valor_minimo :Currency;
begin
         no_dias := 0;
         cod_nomina := buscanomina(IBQuery1);
         with IBQuery1 do
         begin
           Close;
           SQL.Clear;
           SQL.Add('select "nom$empleado"."sueldobasico","nom$empleado"."fecha_registro" from "nom$empleado"');
           SQL.Add('where "nom$empleado"."nitempleado" = :nit');
           ParamByName('nit').AsInteger := nit;
           Open;
           valor_mes := FieldByName('sueldobasico').AsCurrency;
           fecha_registro := FieldByName('fecha_registro').AsDateTime;
           SQL.Clear;
           SQL.Add('select "nom$general"."valor" from "nom$general" where "nom$general"."codigo" = 2');
           Open;
           valor_minimo := FieldByName('valor').AsCurrency;
           SQL.Clear;
           SQL.Add('select "nom$descuento"."numero_dias"');
           SQL.Add('from "nom$descuento"');
           SQL.Add('where "nom$descuento"."nit_empleado" = :nit');
           SQL.Add('and "nom$descuento"."cod_nomina" = :cod_nomina');
           ParamByName('nit').AsInteger := nit;
           ParamByName('cod_nomina').AsInteger := cod_nomina;
           Open;
           while not Eof do
           begin
             no_dias := no_dias + FieldByName('numero_dias').AsCurrency;
             Next;
           end;
             Close;
           if opcion = 1 then
             Result := no_dias
           else if opcion = 2 then
             Result := valor_mes - ((valor_mes/30)*no_dias)
           else if opcion = 3 then
             Result := valor_mes
           else if opcion = 4 then
           begin
             if valor_minimo > valor_mes then
                valor_mes := valor_minimo;
             if FormatDateTime('yyyy/mm',fecha_registro) <> FormatDateTime('yyyy/mm',Date) then
                Result := valor_mes
             else
                Result := valor_mes - ((valor_mes/30)*no_dias);
           end;
         end;

end;

function fsp(IBQuery1: TIBQuery; nit: Integer): Currency;
var     salariominimo,sueldobasico,_cHora : Currency;
begin
        _cHora := horaextra(IBquery1,nit);
        salariominimo := valorhoraextra(IBQuery1,2);
        with IBQuery1 do
        begin
          Close;
          verificatransaccion(IBQuery1);
          SQL.Clear;
          SQL.Add('select "nom$empleado"."sueldobasico" from "nom$empleado"');
          SQL.Add('where "nom$empleado"."nitempleado" = :nit');
          ParamByName('nit').AsInteger := nit;
          Open;
          sueldobasico := FieldByName('sueldobasico').AsCurrency;
          Close;
        end;
        if ((sueldobasico + _cHora) / salariominimo) > 4 then
           Result := ibc(IBQuery1,nit) * 0.01
        else
           Result := 0;
end;

function deduccion(IBQuery1: TIBQuery; opcion: Integer;nit:integer): Currency;
var     porcentaje: Currency;
        vCancelacion :Boolean;
        cod_nomina,vDias :Integer;
begin
        vCancelacion := False;
        cod_nomina := buscanomina(IBQuery1);
        with IBQuery1 do
        begin
          Close;
          verificatransaccion(IBQuery1);
          SQL.Clear;
          SQL.Add('select "nom$tipoprestacion"."porempleado" from "nom$tipoprestacion"');
          SQL.Add('where "nom$tipoprestacion"."codigo" = :codigo');
          ParamByName('codigo').AsInteger := opcion;
          Open;
          porcentaje := FieldByName('porempleado').AsCurrency;
          SQL.Clear;
          SQL.Add('select "nom$empleado"."sueldobasico" from "nom$empleado"');
          SQL.Add('where "nom$empleado"."nitempleado" = :nit');
          ParamByName('nit').AsInteger := nit;
          Open;
          Result := SimpleRoundTo(((ibc(IBQuery1,nit) * porcentaje)) / 100,0);
          Close;
          SQL.Clear;
          SQL.Add('select "nom$cancelacion"."dias" from "nom$cancelacion" where');
          SQL.Add('"nom$cancelacion"."nitempleado" = :NIT and "nom$cancelacion"."cod_nomina" = :CODIGO');
          ParamByName('NIT').AsInteger := nit;
          ParamByName('CODIGO').AsInteger := cod_nomina;
          Open;
          vDias := FieldByName('dias').AsInteger;
          if vDias > 0 then
             Result := SimpleRoundTo((Result / 30),0) * vDias;
          end;
end;

function buscacodigopuc(IBQuery1: TIBQuery; opcion, nit: integer): Integer;
begin
        with IBQuery1 do
        begin
          Close;
          SQL.Clear;
          if opcion = 1 then
             SQL.Add('select "nom$empleado"."codigo_salud"')
          else
            SQL.Add('select "nom$empleado"."codigo_pension"');
          SQL.Add('from "nom$empleado"');
          SQL.Add('where "nom$empleado"."nitempleado" = :nit');
          ParamByName('nit').AsInteger := nit;
          Open;
          if opcion = 1 then
            Result := FieldByName('codigo_salud').AsInteger
          else
            Result := FieldByName('codigo_pension').AsInteger;
          Close;
          end;
        end;
function retefuente(IBQuery1: TIBQuery;nit,opcion: Integer;valor:currency): Currency;
var     devengado,descuento1,fsp1,pension: Currency;
        _cSalud,_cEducacion :Currency;
        _cValorAntes :Currency;
begin
        with IBQuery1 do
        begin
          Close;
          verificatransaccion(IBQuery1);
          SQL.Clear;
          SQL.Add('select *');
          SQL.Add('from');
          SQL.Add('"nom$retefuente"');
          SQL.Add('where "nom$retefuente"."nit_empleado" = :nit_empleado');
          ParamByName('nit_empleado').AsInteger := nit;
          Open;
          if FieldByName('retefuente').AsCurrency > 0 then
          begin
           devengado := valor;
           _cSalud := FieldByName('SALUD').AsCurrency;
           _cEducacion := FieldByName('EDUCACION').AsCurrency;
           descuento1 := FieldByName('retefuente').AsCurrency / 100;
           if opcion = 1 then begin
             fsp1 := fsp(IBQuery1,nit);
             pension := deduccion(IBQuery1,200,nit);
             _cValorAntes := SimpleRoundTo(((devengado - (fsp1 + pension))* 0.75),0);

             Result := SimpleRoundTo((_cValorAntes - (_cSalud + _cEducacion))* descuento1,0);
           end
           else
           begin
             Result := SimpleRoundTo((devengado * 0.75) * descuento1,0);
           end;
          end
          else
           Result := 0;
          Close;
        end;
end;
function nomina(IBQuery1: TIBQuery; opcion, tipo,nit: integer): currency;
var     cod_nomina :Smallint;
begin
       cod_nomina := buscanomina(IBQuery1);
        with IBQuery1 do
        begin
          Close;
          verificatransaccion(IBQuery1);
          SQL.Clear;
          SQL.Add('SELECT');
             case opcion  of
               1: SQL.Add('"nom$nomina"."sueldobasico" AS "total"');
               2: SQL.Add('"nom$nomina"."total_basico" AS "total"');
               3: SQL.Add('"nom$nomina"."horas_extras" AS "total"');
               4: SQL.Add('sum("nom$nomina"."transporte") AS "total"');
               5: SQL.Add('"nom$nomina"."total_devengado" AS "total"');
               6: SQL.Add('"nom$nomina"."libranza" AS "total"');
               7: SQL.Add('sum("nom$nomina"."cporcobrar") AS "total"');
               8: SQL.Add('sum("nom$nomina"."fsp") AS "total"');
               9: SQL.Add('sum("nom$nomina"."retefuente") AS "total"');
               10: SQL.Add('sum("nom$nomina"."pension") AS "total"');
               11: SQL.Add('sum("nom$nomina"."salud") AS "total"');
               12: SQL.Add('"nom$nomina"."sueldoneto" AS "total"');
               13: SQL.Add('sum("nom$nomina"."sueldobasico") AS "total"');
               14: SQL.Add('sum("nom$nomina"."horas_extras") AS "total"');
               15: SQL.Add('sum("nom$nomina"."sueldoneto") AS "total"');
               16: SQL.Add('"nom$nomina"."transporte" AS "total"');
               17: SQL.Add('sum("nom$nomina"."libranza") AS "total"');
               18: SQL.Add('sum("nom$nomina"."ibc") AS "total"');
               19: SQL.Add('sum("nom$nomina"."ap_pension") AS "total"');
             end;
          SQL.Add('FROM');
          SQL.Add('"nom$nomina"');
          SQL.Add('INNER JOIN "nom$empleado" ON ("nom$nomina"."nit_empleado" = "nom$empleado"."nitempleado")');
          SQL.Add('WHERE');
          SQL.Add('("nom$nomina"."codigo_nomina" = :cod) AND');
          SQL.Add('("nom$empleado"."tipo_nomina" = :tipo)');
          if nit <> 0 then begin
            SQL.Add('AND("nom$empleado"."nitempleado" = :nit_empleado)');
            ParamByName('nit_empleado').AsInteger := nit;
          end;
          ParamByName('cod').AsInteger := cod_nomina;
          ParamByName('tipo').AsInteger := tipo;
          Open;
          Result := FieldByName('total').AsCurrency;
          Close;
        end;


end;
function ObtenerConsecutivo(IBSQL1: TIBSQL): Longint;
const ntMaxTries = 100;
var I, WaitCount, Tries,Consecutivo:Integer;
    RecordLocked:Boolean;
    ErrorMsg:string;
begin
       Result := 0;
       Tries := 0;
       while True do
        with IBSQL1 do begin
         Close;
         if Transaction.InTransaction then
            Transaction.Commit;
         Transaction.StartTransaction;
         try
          SQL.Clear;
          SQL.Add('select * from "gen$consecutivos" where "gen$consecutivos"."ID_CONSECUTIVO" = 1');
          ExecQuery;
          Consecutivo := FieldByName('CONSECUTIVO').AsInteger;
          //ShowMessage(IntToStr(Consecutivo));
          Close;
          Consecutivo := Consecutivo + 1;
          SQL.Clear;
          SQL.Add('update "gen$consecutivos" set "gen$consecutivos"."CONSECUTIVO" = :"CONSECUTIVO" ');
          SQL.Add(' where "gen$consecutivos"."ID_CONSECUTIVO" = 1');
          ParamByName('CONSECUTIVO').AsInteger := Consecutivo;
          ExecQuery;
          Transaction.Commit;
          Result := Consecutivo;
          break;
         except
           on E: EIBInterBaseError do
           begin
            if E.SQLCode = -913 then RecordLocked := True;
            if RecordLocked then
             begin
              WaitCount := Random(20);
              for I := 1 to WaitCount do
              Application.ProcessMessages;
              Continue;
             end
            else
             begin
              ErrorMsg := ErrorMsg + E.Message +
              ' (' + IntToStr(E.IBErrorCode ) + '). ';
              MessageDlg(ErrorMsg,mterror,[mbOk],0);
             end;
           end;
          end;
        end;
end;


function empleados(IBquery1:TIBQuery;dbalias: string): string;
var      nombres,apellidos:string;
begin
         with IBQuery1 do
         begin
           sql.Clear;
           sql.Add('select PRIMER_APELLIDO, SEGUNDO_APELLIDO, NOMBRE from "gen$empleado"');
           sql.Add('where "gen$empleado"."ID_EMPLEADO" =:"ID_EMPLEADO"');
           ParamByName('ID_EMPLEADO').AsString := UpperCase(DBAlias);
           Open;
           Nombres := FieldByName('NOMBRE').AsString;
           Apellidos := FieldByname('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
         end;
         Result :=apellidos + ' ' + nombres;

end;

function cobro(IBQuery1: TIBQuery; nit: Integer): Currency;
var     cod_nomina :Integer;
        descuentos :Currency;
begin
         cod_nomina := buscanomina(IBQuery1);
         descuentos := 0;
         with IBQuery1 do
         begin
           SQL.Clear;
           SQL.Add('select "nom$cobros"."descuento"');
           SQL.Add('from "nom$cobros"');
           SQL.Add('where "nom$cobros"."nit_empleado" = :nit');
           SQL.Add('and "nom$cobros"."cod_nomina" = :cod_nomina');
           ParamByName('nit').AsInteger := nit;
           ParamByName('cod_nomina').AsInteger := cod_nomina;
           Open;
           while not Eof do
           begin
             descuentos := descuentos + FieldByName('descuento').AsCurrency;
             Next;
           end;
             Close;
         end;
         Result := descuentos;
end;

function ObtenerConsecutivobarrido(IBSQL1: TIBSQL): LongInt;
const ntMaxTries = 100;
var I, WaitCount, Tries,Consecutivo:Integer;
    RecordLocked:Boolean;
    ErrorMsg:string;
begin
       Result := 0;
       Tries := 0;
       while True do
        with IBSQL1 do begin
         Close;
         if Transaction.InTransaction then
            Transaction.Commit;
         Transaction.StartTransaction;
         try
          SQL.Clear;
          SQL.Add('select * from "gen$consecutivos" where "gen$consecutivos"."ID_CONSECUTIVO" = 2');
          ExecQuery;
          Consecutivo := FieldByName('CONSECUTIVO').AsInteger;
          Close;
          Consecutivo := Consecutivo;
          SQL.Clear;
          SQL.Add('update "gen$consecutivos" set "gen$consecutivos"."CONSECUTIVO" = :"CONSECUTIVO" ');
          SQL.Add(' where "gen$consecutivos"."ID_CONSECUTIVO" = 2');
          ParamByName('CONSECUTIVO').AsInteger := Consecutivo;
          ExecQuery;
          Transaction.Commit;
          Result := Consecutivo;
          break;
         except
           on E: EIBInterBaseError do
           begin
            if E.SQLCode = -913 then RecordLocked := True;
            if RecordLocked then
             begin
              WaitCount := Random(20);
              for I := 1 to WaitCount do
              Application.ProcessMessages;
              Continue;
             end
            else
             begin
              ErrorMsg := ErrorMsg + E.Message +
              ' (' + IntToStr(E.IBErrorCode ) + '). ';
              MessageDlg(ErrorMsg,mterror,[mbOk],0);
             end;
           end;
          end;
        end;
end;

function interescesantia(valor: Currency;nit:Integer;opcion,tipo:integer): currency;
var     mes_actual,no_dias :Integer;
        dias : Integer;
        ano_actual,ano_anterior: Smallint;
        fecha :string;
        valorcesantia,V1,V2,vT :Currency;
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
          fecha := FieldByName('fecha_registro').AsString;
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM BUSCADIAS(:NIT,:ANO)');
          ParamByName('NIT').AsInteger := nit;
          ParamByName('ANO').AsInteger := YearOf(Date);
          Open;
          V1 := FieldByName('V1').AsCurrency;
          V2 := FieldByName('V2').AsCurrency;
        end;
//***
        if StrToInt(FormatDateTime('m',date)) <= 6 then
        begin
            vT := V1;
            //valorcesantia := selobligacion(2,nit);
            //valorcesantia := nomina(DataQuerys.IBselecion,3,tipo,nit) + valorcesantia;
            //valorcesantia := valorcesantia / 6;
        end
         else
         begin
            vT := V2;
            //valorcesantia := promedio(nit);
         end;
           //ShowMessage(CurrToStr((selobligacion(2,nit))));
           //ShowMessage(CurrToStr((nomina(DataQuerys.IBselecion,3,tipo,nit)/12)));
           valorcesantia := (selobligacion(2,nit) + SimpleRoundTo((nomina(DataQuerys.IBselecion,3,tipo,nit)),0)) / MonthOf(fFechaActual);
//***
        no_dias := StrToInt(FormatDateTime('d',StrToDate(fecha))) - 1;
        if no_dias = 0 then
           no_dias := 30
        else
           no_dias := 30 - no_dias;
           dias := no_dias;
        ano_actual := StrToInt(FormatDateTime('yyyy',Date));
        ano_anterior := StrToInt(FormatDateTime('yyyy',StrToDate(fecha)));
        if ano_actual <> ano_anterior then
        begin
          no_dias := 30;
          mes_actual := StrToInt(FormatDateTime('m',Date));
        end
        else
          mes_actual := strtoint(FormatDateTime('m',date)) - StrToInt(FormatDateTime('m',StrToDate(fecha)));
        if opcion = 1 then // interes cesantia
        begin
        //valorcesantia := valor + valorcesantia;
          if ano_actual <> ano_anterior then
             no_dias := 0;
           valor := valor + valorcesantia + valor_transporte(nit,2);  
           valor := (valor/360)*((mes_actual*30) + no_dias);
           valor := ((valor*0.12)/360)* (((mes_actual*30) + no_dias) - (V1 + V2));
        end
          else if opcion = 2 then
          begin

          
           //valorcesantia := valor + valorcesantia;
            if ano_actual <> ano_anterior then // total cesantias y primas de servicios
               no_dias := 0;
               valor := valor + valorcesantia + valor_transporte(nit,2);
             valor := (valor/360)*(((mes_actual*30) + no_dias)- (V1 + V2));// + valorcesantia;
          end
            else if opcion = 3 then // reporte prima de navidad
            begin
              if ano_actual <> ano_anterior then
                 no_dias := 0;
               valor := (valor/720)*(((mes_actual*30) + no_dias) - (V1 +V2));
              end
                else if opcion = 4 then  // prima de vacaciones
                begin
               if mes_actual < (StrToInt(FormatDateTime('mm',StrToDate(fecha)))) then
                  no_dias := 12 - StrToInt(FormatDateTime('mm',StrToDate(fecha)))+ mes_actual
               else
                 no_dias :=  mes_actual - StrToInt(FormatDateTime('mm',StrToDate(fecha)));
                 if ano_actual = ano_anterior then
                    no_dias := mes_actual;
                  valor := (valor/720) * (((no_dias) * 30) + dias);
                end
                     else if opcion = 5 then // cesantias y primas de servicios
                     begin
                       if FormatDateTime('01/mm/yyy',Date) <> FormatDateTime('01/mm/yyyy',StrToDate(fecha)) then
                          valor := (valorcesantia/360) * 30
                       else
                          valor := (valor/360)+valorcesantia * dias;
                     end
                       else if opcion = 6 then
                       begin
                         if mes_actual >= 0 then
                         begin
                              no_dias :=  mes_actual;// - StrToInt(FormatDateTime('mm',StrToDate(fecha)));
                            if ano_actual = ano_anterior then
                            begin
                            if no_dias < 0 then
                               no_dias := 0;
                            valor := SimpleRoundTo((((valor/3)*2)/360),0)*(((no_dias) * 30) + dias);
                            end
                            else
                            valor := SimpleRoundTo((((valor/3)*2)/360),0) * (StrToInt(FormatDateTime('mm',Date))*30);
                          end
                          else
                            valor := 0
                          end
                            else if opcion = 7 then
                              begin
                                if ano_actual <> ano_anterior then // total dias y primas de sevicios
                                   no_dias := 0;
                                   valor := ((mes_actual*30) + no_dias) - (V1 + v2);
                               end
                                 else if opcion = 8 then
                                 begin
                                   if mes_actual < (StrToInt(FormatDateTime('mm',StrToDate(fecha)))) then
                                      no_dias := 12 - StrToInt(FormatDateTime('mm',StrToDate(fecha)))+ mes_actual
                                    else
                                       no_dias :=  mes_actual - StrToInt(FormatDateTime('mm',StrToDate(fecha)));
                                    if ano_actual = ano_anterior then
                                    begin
                                       no_dias := mes_actual;
                                    end;
                                    if no_dias < 0 then
                                       no_dias := 0;
                                    valor := ((no_dias) * 30) + dias;
                                    end
                                       else if opcion = 9 then
                                       begin
                                         if mes_actual >= 0 then
                                         begin
                                           if mes_actual < (StrToInt(FormatDateTime('mm',StrToDate(fecha)))) then
                                              no_dias := 12 - StrToInt(FormatDateTime('mm',StrToDate(fecha)))+ mes_actual
                                            else
                                              no_dias :=  mes_actual - StrToInt(FormatDateTime('mm',StrToDate(fecha)));
                                            if ano_actual = ano_anterior then
                                               no_dias := no_dias -1;
                                            if no_dias < 0 then
                                               no_dias := 0;
                                            valor := ((no_dias) * 30) + dias;
                                            end;
                                          end
                                            else if opcion = 10 then
                                            begin
                                               if ano_actual <> ano_anterior then // total cesantias y primas de servicios
                                               begin
                                                   no_dias := 0;
                                                   if (StrToInt(FormatDateTime('m',Date)) >= 7) then
                                                      mes_actual := mes_actual - 6;
                                               end
                                               else
                                               begin
                                                 if (StrToInt(FormatDateTime('m',StrToDateTime(fecha))) <= 6)  then
                                                    begin
                                                    if (StrToInt(FormatDateTime('m',Date)) >= 7) then
                                                    begin
                                                      no_dias := 0;
                                                      dias := 6 - StrToInt(FormatDateTime('m',StrToDate(fecha)));
                                                      mes_actual := mes_actual - dias;
                                                    end;
                                                    end;
                                               end;
                                                 valor := valor + valorcesantia + valor_transporte(nit,2);
                                                 valor := (valor/360)*(((mes_actual*30) + no_dias) - vT);//+valorcesantia;
          end;
        Result := SimpleRoundTo(valor,0);

end;

function vacacionconsolidada(nit,opcion: integer): currency;
var     fecha_anterior,fecha_reg1 :tdate;
        fecha,fecha_reg :string;
        dias_actuales,valor,tipo,dias_final,dia :variant;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"nom$empleado"."tipo_nomina",');
          SQL.Add('"nom$empleado"."fecha_registro"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit;
          Open;
          tipo := FieldByName('tipo_nomina').AsInteger;
          fecha_reg := FieldByName('fecha_registro').AsString;
          fecha_reg1 := FieldByName('fecha_registro').AsDateTime;
          Close;
        end;
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$vacaciones"."fecha_vacaciones"');
          SQL.Add('FROM');
          SQL.Add('"nom$vacaciones"');
          SQL.Add('WHERE');
          SQL.Add('("nom$vacaciones"."nitempleado" = :nit) and');
          SQL.Add('("nom$vacaciones"."fechasalida" = ( select max("nom$vacaciones"."fechasalida")');
          SQL.Add('from "nom$vacaciones"');
          SQL.Add('where ("nom$vacaciones"."nitempleado" = :nit)))');
          ParamByName('nit').AsInteger := nit;
          Open;
          fecha_anterior := FieldByName('fecha_vacaciones').AsDateTime;
          fecha := FieldByName('fecha_vacaciones').AsString;
          Close;
        end;
        if fecha_anterior = 0 then
        begin
           fecha_anterior := fecha_reg1;
           fecha := fecha_reg;
        end;
        dia := StrToInt(FormatDateTime('dd',fecha_anterior)) -1;
        if dia = 0 then
           dia := 30
        else
           dia := 30 - dia;
             if FormatDateTime('m',Date) = '2' then
                dias_actuales := int(StrToDate(FormatDateTime('yyyy/mm/28',Date))) - fecha_anterior + 2 -dia
             else
                dias_actuales := int(StrToDate(FormatDateTime('yyyy/mm/30',Date))) -  fecha_anterior - dia;
             dias_final := (SimpleRoundTo(((dias_actuales/30)),0)*30) + dia;
             if opcion = 1 then
                valor := SimpleRoundTo((((descuento(DataQuerys.IBselecion,nit,3)/3)*2)/360) * (dias_final),0)
             else if opcion = 2 then
                valor := dias_final
             else if opcion = 3 then
             begin
             if FormatDateTime('yyyy',Date) = FormatDateTime('yyyy',StrToDate(fecha)) then
                valor := SimpleRoundTo((((descuento(DataQuerys.IBselecion,nit,3)/3)*2)/360) * (dias_final),0)
             else
                valor := SimpleRoundTo((((descuento(DataQuerys.IBselecion,nit,3)/3)*2)/360) * (StrToInt(FormatDateTime('mm',Date))*30),0);
             end;
             Result := valor;
end;

function prima(nit, opcion: integer): currency;
var     fecha_registro,fecha_prima5,fecha_prima9,fecha_prima14,fecha_prima19 :string;
        fechaa,mes_actual,no_dias,dias :Integer;
        valor :Currency;
begin
        valor := descuento(DataQuerys.IBdatos,nit,3);
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
        fecha_prima14 := FormatDateTime(IntToStr(fechaa+14)+'/mm/01',StrToDate(fecha_registro));
        fecha_prima19 := FormatDateTime(IntToStr(fechaa+19)+'/mm/01',StrToDate(fecha_registro));
        if opcion = 0 then
          mes_actual := StrToInt(FormatDateTime('m',Date))
        else
          mes_actual := StrToInt(FormatDateTime('m',Date - 15));
        no_dias := StrToInt(FormatDateTime('d',StrToDate(fecha_registro))) - 1;
        if no_dias = 0 then
           no_dias := 30
        else
           no_dias := 30 - no_dias;
           dias := no_dias;
        if mes_actual < (StrToInt(FormatDateTime('mm',StrToDate(fecha_registro)))) then
           no_dias := 12 - StrToInt(FormatDateTime('mm',StrToDate(fecha_registro)))+ mes_actual
        else
           no_dias :=  mes_actual - StrToInt(FormatDateTime('mm',StrToDate(fecha_registro)));

        if Int(Date) >= Int(StrToDate(fecha_prima19)) then // prima 1 sueldos
           valor := ((valor)/360) * (((no_dias) * 30) + dias)
        else if Int(Date) >= Int(StrToDate(fecha_prima14)) then  // prima 1 sueldos
           valor := ((valor)/360) * (((no_dias) * 30) + dias)
        else if Int(Date) >= Int(StrToDate(fecha_prima9)) then  // prima 1/2 sueldo
           valor := ((valor/2)/360) * (((no_dias) * 30) + dias)
        else if Int(Date) >= Int(StrToDate(fecha_prima5)) then // prima 1/4 sueldo
           valor := ((valor/4)/360) * (((no_dias) * 30) + dias)
        else
           valor := 0;
           Result := valor;
end;

procedure consignacion(cuenta, consecutivo: Integer; valor: Currency;cadena:string);
var    digitocuenta :Integer;
begin
        DigitoCuenta := StrToInt(DigitoControl(2,FormatCurr('0000000',cuenta)));
        with FrmQuerys.IBregistro do
        begin
          Close;
          verificatransaccion(FrmQuerys.IBregistro);
          SQL.Clear;
          SQL.Add('insert into "cap$extracto" values(');
          SQL.Add(':"ID_AGENCIA",:"ID_TIPO_CAPTACION",:"NUMERO_CUENTA",');
          SQL.Add(':"DIGITO_CUENTA",:"FECHA_MOVIMIENTO",:"HORA_MOVIMIENTO",');
          SQL.Add(':"ID_TIPO_MOVIMIENTO",:"DOCUMENTO_MOVIMIENTO",:"DESCRIPCION_MOVIMIENTO",');
          SQL.Add(':"VALOR_DEBITO",:"VALOR_CREDITO")');
          ParamByName('ID_AGENCIA').AsInteger := 1;
          ParamByName('ID_TIPO_CAPTACION').AsInteger := 2;
          ParamByName('NUMERO_CUENTA').AsInteger := cuenta;
          ParamByName('DIGITO_CUENTA').AsInteger := DigitoCuenta;
          ParamByName('FECHA_MOVIMIENTO').AsDateTime := FrMain.fechacartera;
          ParamByName('HORA_MOVIMIENTO').AsTime := Time;
          ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 6;
          ParamByName('DOCUMENTO_MOVIMIENTO').AsString := FormatCurr('0000000',consecutivo);;
          ParamByName('DESCRIPCION_MOVIMIENTO').AsString := cadena;
          ParamByName('VALOR_DEBITO').AsCurrency := valor;
          ParamByName('VALOR_CREDITO').AsCurrency := 0;
          Open;
          Close;
          Transaction.Commit;
        end;

end;
procedure actualizarcomprobante(consecutivo: integer);
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
end;

function comprobantes(cadena,tipo:string): integer;
var     consecutivo :Integer;
begin
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
          ParamByname('FECHADIA').AsDate := FrMain.fechacartera;
          ParamByName('ID_AGENCIA').AsInteger := 1;
          ParamByName('TIPO_COMPROBANTE').AsInteger := StrToInt(tipo);
          ParamByName('DESCRIPCION').AsString := cadena;
          ParamByName('TOTAL_DEBITO').AsCurrency  := 0;
          ParamByName('TOTAL_CREDITO').AsCurrency  := 0;
          ParamByName('ESTADO').AsString  := 'O';
          ParamByname('ANULACION').asstring := '';
          ParamByName('IMPRESO').AsInteger  := Ord(False);
          ParamByname('ID_EMPLEADO').asstring := UpperCase(FrMain.Dbalias);
          Open;
          Close;
          Transaction.Commit;
          Result := consecutivo;
        end;
end;

procedure auxiliarcon(codigopuc, consecutivo: Integer; tipo: string;
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
            ParamByName('ID_COMPROBANTE').asInteger := consecutivo;
            ParamByName('ID_AGENCIA').AsInteger := 1;
            ParamByName('FECHA').AsDate := FrMain.fechacartera;
            ParamByName('CODIGO').AsString := codigo;
            ParamByName('DEBITO').AsCurrency := SimpleRoundTo(debito,0);
            ParamByName('CREDITO').AsCurrency := SimpleRoundTo(credito,0);
            ParamByName('ID_CUENTA').Clear;
            ParamByName('ID_COLOCACION').AsString := '';
            ParamByName('ID_IDENTIFICACION').AsInteger := 0;
            ParamByName('ID_PERSONA').AsString :='0';
            ParamByName('MONTO_RETENCION').AsCurrency := 0;
            ParamByName('TASA_RETENCION').AsFloat := 0;
            ParamByName('ESTADOAUX').AsString := 'O';
            ExecSQL;
            Close;
            Transaction.Commit;
          end;
         end;
end;

procedure auxiliaraho(codigopuc, consecutivo, nit: Integer; tipo: string;
  valor: Currency; cuenta: string);
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
            ParamByName('ID_COMPROBANTE').asInteger := consecutivo;
            ParamByName('ID_AGENCIA').AsInteger := 1;
            ParamByName('FECHA').AsDate := FrMain.fechacartera;
            ParamByName('CODIGO').AsString := codigo;
            ParamByName('DEBITO').AsCurrency := SimpleRoundTo(debito,0);
            ParamByName('CREDITO').AsCurrency := SimpleRoundTo(credito,0);
            ParamByName('ID_CUENTA').AsString := cuenta;
            ParamByName('ID_COLOCACION').AsString := '';
            ParamByName('ID_IDENTIFICACION').AsInteger := 3;
            ParamByName('ID_PERSONA').AsString := IntToStr(nit);
            ParamByName('MONTO_RETENCION').AsCurrency := 0;
            ParamByName('TASA_RETENCION').AsFloat := 0;
            ParamByName('ESTADOAUX').AsString := 'O';
            Open;
            Close;
            Transaction.Commit;
          end;
         end;
end;

procedure verifica(IBSQL1: TIBSQL);
begin
        with IBSQL1 do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
        end;
end;

procedure obligacion(tipo, nit: integer; valor: currency);
begin
            with DataQuerys.IBselecion do
            begin
              Close;
              verificatransaccion(DataQuerys.IBselecion);
              SQL.Clear;
              SQL.Add('update "nom$obligaciones" ');
              case tipo of
                1:  SQL.Add('set "nom$obligaciones"."sueldo" = :valor');
                2:  SQL.Add('set "nom$obligaciones"."horas_extras" = :valor');
                3:  SQL.Add('set "nom$obligaciones"."viaticos" = :valor');
                4:  SQL.Add('set "nom$obligaciones"."transporte" = :valor');
                5:  SQL.Add('set "nom$obligaciones"."p_antiguedad" = :valor');
                6:  SQL.Add('set "nom$obligaciones"."p_vacaciones" = :valor');
                7:  SQL.Add('set "nom$obligaciones"."p_navidad" = :valor');
                8:  SQL.Add('set "nom$obligaciones"."p_servicios" = :valor');
                9:  SQL.Add('set "nom$obligaciones"."vacaciones" = :valor');
                10: SQL.Add('set "nom$obligaciones"."bonificacion" = :valor');
                11: SQL.Add('set "nom$obligaciones"."pension" = :valor');
                12: SQL.Add('set "nom$obligaciones"."fsp" = :valor');
                13: SQL.Add('set "nom$obligaciones"."retefuente" = :valor');
              end;
              SQL.Add('where "nom$obligaciones"."nit" = :Nit');
              SQL.Add('and "nom$obligaciones"."ano" = :ano');
              ParamByName('nit').AsInteger := nit;
              ParamByName('ano').AsInteger := StrToInt(FormatDateTime('yyyy',Date));
              ParamByName('valor').AsCurrency := valor;
              Open;
              Close;
              Transaction.Commit;
            end;
end;

function selobligacion(tipo, nit: integer): currency;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          case tipo of
            1:  SQL.Add('"nom$obligaciones"."sueldo" as total');
            2:  SQL.Add('"nom$obligaciones"."horas_extras" as total');
            3:  SQL.Add('"nom$obligaciones"."viaticos" as total');
            4:  SQL.Add('"nom$obligaciones"."transporte" as total');
            5:  SQL.Add('"nom$obligaciones"."p_antiguedad" as total');
            6:  SQL.Add('"nom$obligaciones"."p_vacaciones" as total');
            7:  SQL.Add('"nom$obligaciones"."p_navidad" as total');
            8:  SQL.Add('"nom$obligaciones"."p_servicios" as total');
            9:  SQL.Add('"nom$obligaciones"."vacaciones" as total');
            10: SQL.Add('"nom$obligaciones"."bonificacion" as total');
            11: SQL.Add('"nom$obligaciones"."pension" as total');
            12: SQL.Add('"nom$obligaciones"."fsp" as total');
            13: SQL.Add('"nom$obligaciones"."retefuente" as total');
          end;
          SQL.Add('FROM');
          SQL.Add('"nom$obligaciones"');
          SQL.Add('WHERE');
          SQL.Add('("nom$obligaciones"."nit" = :nit) AND');
          SQL.Add('("nom$obligaciones"."ano" = :ano)');
          ParamByName('nit').AsInteger := nit;
          ParamByName('ano').AsInteger := StrToInt(FormatDateTime('yyyy',Date));
          Open;
          Result := FieldByName('total').AsCurrency;
          Close;
        end;
end;

function tipo_agencia(consecutivo: integer): string;
begin
        with FrmQuerys.IBregistro do
        begin
          Close;
          verificatransaccion(FrmQuerys.IBregistro);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"con$comprobante".TIPO_COMPROBANTE');
          SQL.Add('FROM');
          SQL.Add('"con$comprobante"');
          SQL.Add('WHERE');
          SQL.Add('("con$comprobante".ID_COMPROBANTE = :consecutivo)');
          ParamByName('consecutivo').AsInteger := consecutivo;
          Open;
          if FieldByName('TIPO_COMPROBANTE').AsString = '1 ' then
             Result := 'NOTA CONTABLE'
          else
             Result := 'NOTA CONTABLE SUCURSAL';
          Close;
        end;
end;
function totaldias(nit: integer): integer;
var dias_consolidados,mes :Integer;
    fecha :TDate;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "nom$empleado"."fecha_registro"');
          SQL.Add('from "nom$empleado"');
          SQL.Add('where "nom$empleado"."nitempleado" = :Nit');
          ParamByName('Nit').AsInteger := nit;
          Open;
          fecha := FieldByName('fecha_registro').AsDateTime;
          Close;
        end;
        mes := 12 - StrToInt(FormatDateTime('m',fecha));
        dias_consolidados := 31 - StrToInt(FormatDateTime('d',fecha));
        Result := (mes * 30) + dias_consolidados;
end;

function tabla: boolean;
var     fecha :string;
begin
{        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$obligaciones"."ano"');
          SQL.Add('FROM');
          SQL.Add('"nom$obligaciones"');
          Open;
          fecha := FieldByName('ano').AsString;
          Close;
        end;
        if (fecha <> FormatDateTime('yyyy',Date)) and (FormatDateTime('m',date) = '1') then
            Result := True
        else   }
            Result := False;
end;

procedure iniciaano;
begin
        //actualiza_consolidados;
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('delete from "nom$control"');
          ExecSQL;
          SQL.Clear;
          SQL.Add('delete from "nom$cobros"');
          ExecSQL;
          SQL.Clear;
          SQL.Add('delete from "nom$descuento"');
          ExecSQL;
          SQL.Clear;
          SQL.Add('delete from "nom$fondos"');
          ExecSQL;
          SQL.Clear;
          SQL.Add('delete from "nom$horasextras"');
          Close;
          ExecSQL;
          Transaction.Commit;
        end;
        with DataQuerys.IBdatos do
        begin
          verificatransaccion(DataQuerys.IBdatos);
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"nom$empleado"."nitempleado"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          Open;
          while not Eof do
          begin
            with DataQuerys.IBselecion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('insert into "nom$obligaciones"');
              SQL.Add('values (');
              SQL.Add(':nitempleado,');
              SQL.Add(':ano,');
              SQL.Add(':sueldo,');
              SQL.Add(':horas_extras,');
              SQL.Add(':viaticos,');
              SQL.Add(':transporte,');
              SQL.Add(':p_antiguedad,');
              SQL.Add(':p_vacaciones,');
              SQL.Add(':p_navidad,');
              SQL.Add(':p_servicios,');
              SQL.Add(':vacaciones,');
              SQL.Add(':bonificacion,');
              SQL.Add(':pension,');
              SQL.Add(':fsp,:retefuente,0,0)');
              ParamByName('nitempleado').AsInteger := DataQuerys.IBdatos.FieldByName('nitempleado').AsInteger;
              ParamByName('ano').AsInteger := StrToInt(FormatDateTime('yyyy',date));;
              ParamByName('sueldo').AsCurrency := 0;
              ParamByName('horas_extras').AsCurrency := 0;
              ParamByName('viaticos').AsCurrency := 0;
              ParamByName('transporte').AsCurrency := 0;
              ParamByName('p_antiguedad').AsCurrency := 0;
              ParamByName('p_vacaciones').AsCurrency := 0;
              ParamByName('p_navidad').AsCurrency := 0;
              ParamByName('p_servicios').AsCurrency := 0;
              ParamByName('vacaciones').AsCurrency := 0;
              ParamByName('bonificacion').AsCurrency := 0;
              ParamByName('pension').AsCurrency := 0;
              ParamByName('fsp').AsCurrency := 0;
              ParamByName('retefuente').AsCurrency := 0;

              Open;
              Transaction.CommitRetaining;
              Close;
            end;
            Next;
          end;
          Close;
          DataQuerys.IBdatos.Transaction.Commit;
        end;
end;

procedure consolidadas;
begin

end;

function Oconsolidada(nit, opcion: integer): currency;
begin
        with dataquerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          case opcion of
          1 : SQL.Add('"nomina"."consolidas" - "nomina"."vacaciones" AS "total"');
          2 : SQL.Add('"nomina"."prima_vacaciones" - "nomina"."primav_con" AS "total"');
          3 : SQL.Add('"nomina"."prima_antiguedad" - "nomina"."prima_con" AS "total"');
          end;
          SQL.Add('FROM');
          SQL.Add('"nomina"');
          SQL.Add('WHERE');
          SQL.Add('("nomina"."nit" = :Nit)');
          ParamByName('nit').AsInteger := nit;
          Open;
          Result := FieldByName('total').AsCurrency;
        end;
end;

procedure hora(nit: Integer;valor:currency);
begin
        if StrToInt(FormatDateTime('m',Date)) >= 7 then
        begin
            with DataQuerys.IBselecion do
            begin
              Close;
              verificatransaccion(DataQuerys.IBselecion);
              SQL.Clear;
              SQL.Add('select "nom$horas"."valor" from "nom$horas"');
              SQL.Add('where "nom$horas"."nit" = :nit');
              ParamByName('nit').AsInteger := nit;
              Open;
              valor := valor + FieldByName('valor').AsCurrency;
              SQL.Clear;
              SQL.Add('update "nom$horas" ');
              SQL.Add('set "nom$horas"."valor" = :valor');
              SQL.Add('where "nom$horas"."nit" = :Nit');
              ParamByName('nit').AsInteger := nit;
              ParamByName('valor').AsCurrency := valor;
              Open;
              Close;
              Transaction.Commit;
            end;
        end;
end;

function promedio(nit: integer):Currency;
begin
            with DataQuerys.IBselecion do
            begin
              Close;
              verificatransaccion(DataQuerys.IBselecion);
              SQL.Clear;
              SQL.Add('select "nom$horas"."valor" from "nom$horas"');
              SQL.Add('where "nom$horas"."nit" = :nit');
              ParamByName('nit').AsInteger := nit;
              Open;
              Result :=  FieldByName('valor').AsCurrency / 6;
              Close;
            end;
end;
function consolidar(nit,opcion: integer): currency;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          case opcion of
            1: SQL.Add('"nom$consolidado"."vacaciones" as total');
            2: SQL.Add('"nom$consolidado"."prima_vacaciones" as total');
            3: SQL.Add('"nom$consolidado"."prima_ant" as total');
          end;
          SQL.Add('FROM');
          SQL.Add('"nom$consolidado"');
          SQL.Add('WHERE');
          SQL.Add('("nom$consolidado"."nit" = :nit)');
          ParamByName('nit').AsInteger := nit;
          Open;
          Result := FieldByName('total').AsCurrency;
          Close;
        end;
end;

function saldo_cuenta(mes: string; codigopuc,id_agencia: integer): currency;
var     saldo_inicial,saldo_final,total_saldo :Currency;
        codigo: string;
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
        with FrmQuerys.IBSaldo  do
        begin
          Close;
          verificatransaccion(FrmQuerys.IBseleccion);
          SQL.Clear;
          SQL.Add('select SALDOINICIAL from "con$puc"');
          SQL.Add('where');
          SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and');
          SQL.Add('CODIGO = :"CODIGO"');
          ParamByName('ID_AGENCIA').AsInteger := id_agencia; //AGENCIA DE OCAÑA
          ParamByName('CODIGO').AsString := codigo;
          Open;
          saldo_inicial  := FieldByName('SALDOINICIAL').AsCurrency;
          SQL.Clear;
          SQL.Add('Select');
          SQL.Add('sum("con$saldoscuenta"."DEBITO") as DEBITO,');
          SQL.Add('sum("con$saldoscuenta"."CREDITO") as CREDITO');
          SQL.Add('from "con$saldoscuenta" ');
          SQL.Add('where ');
          SQL.Add('"con$saldoscuenta".ID_AGENCIA =:"ID_AGENCIA" and');
          SQL.Add('"con$saldoscuenta".CODIGO =:"CODIGO" and');
          SQL.Add('"con$saldoscuenta".MES <=:"MES"');
          ParamByName('ID_AGENCIA').AsInteger := id_agencia; // AGENCIA OCAÑA
          ParamByName('CODIGO').AsString := codigo;// CODIGO PUC
          ParamByName('MES').AsString := mes;      // MES CORTE
          Open;
          saldo_final := FieldByName('DEBITO').AsCurrency - FieldByName('CREDITO').AsCurrency;
          Close;
          Transaction.Commit;
          Total_saldo := saldo_inicial + saldo_final;
          Result := abs(total_saldo);
        end;
end;

procedure actualiza_fondo;
begin
      with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('update "nom$tiponomina" set "nom$tiponomina"."valor" = 0');
          Open;
          Close;
          Transaction.Commit;
        end;
end;

function ibc(IBquery1: TIBQuery; nit_empleado: integer): Currency;
var
        resultado,valor_ibc,valor_red :Currency;
        jornada :Integer;
begin
        resultado :=  SimpleRoundTo(descuento(IBquery1,nit_empleado,4) + horaextra(IBquery1,nit_empleado),0);
        valor_red := StrToCurr(RightStr(CurrToStr(resultado),3));
        resultado := resultado - valor_red;
        if valor_red <= 500 then
           valor_ibc := resultado
        else
           valor_ibc := resultado + 1000;
{        if valor_ibc < 381500 then
           valor_ibc := 381000;}
        Result := valor_ibc;
end;

function aux_transporte(IBQuery1: TIBQuery; nit,tipo_nomina: integer): Currency;
var     fecha_registro :TDate;
        dias :Currency;
        codigo,Vdias,cod_nomina :Integer;
begin
        codigo := 8;
        cod_nomina := buscanomina(DataQuerys.IBselecion);
        with IBQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "nom$empleado"."jornada" from "nom$empleado" where  "nom$empleado"."nitempleado" = :nit');
          ParamByName('nit').AsInteger := nit;
          Open;
          if abs(FieldByName('jornada').AsInteger) = 1 then
             codigo := 9;
          SQL.Clear;
          SQL.Add('select sum("nom$descuento"."numero_dias") as "total" from "nom$descuento"');
          SQL.Add('where "nom$descuento"."nit_empleado" = :nit and');
          SQL.Add('"nom$descuento"."cod_nomina" = :cod_nomina');
          ParamByName('nit').AsInteger := nit;
          ParamByName('cod_nomina').AsInteger := tipo_nomina;
          Open;
          dias := FieldByName('total').AsCurrency;
          SQL.Clear;
          SQL.Add('select "nom$empleado"."aux_transporte","nom$empleado"."fecha_registro" from "nom$empleado" where');
          SQL.Add('"nom$empleado"."nitempleado" = :nit');
          ParamByName('nit').AsInteger := nit;
          Open;
          fecha_registro := FieldByName('fecha_registro').AsDateTime;
          if FieldByName('aux_transporte').AsInteger = 0 then
             Result := 0
          else
          begin
            SQL.Clear;
            SQL.Add('select "nom$general"."valor" from "nom$general"');
            SQL.Add('where "nom$general"."codigo" = :codigo');
            ParamByName('codigo').AsInteger := codigo;
            Open;
            //if FormatDateTime('yyyy/mm',Date) = FormatDateTime('yyyy/mm',fecha_registro) then
               Result := (FieldByName('valor').AsCurrency/30) * (30 - dias)
            //else
            //   Result := FieldByName('valor').AsCurrency;
          end;
            SQL.Clear;
            SQL.Add('select "nom$cancelacion"."dias" from "nom$cancelacion" where');
            SQL.Add('"nom$cancelacion"."nitempleado" = :NIT and "nom$cancelacion"."cod_nomina" = :CODIGO');
            ParamByName('NIT').AsInteger := nit;
            ParamByName('CODIGO').AsInteger := cod_nomina;
            Open;
            vDias := FieldByName('dias').AsInteger;
            if vDias > 0 then
               Result := SimpleRoundTo((Result / 30),0) * Vdias;
        end;
end;

procedure actualiza_consolidados;
var    nit_empleado :Integer;
begin
        with DataQuerys.IBdata do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('select * from "nom$empleado"');
          //SQL.Add('where "nom$empleado"."nitempleado" = :nit');
          //ParamByName('nit').AsString := inputbox('aasa','adasd','');
          Open;
          while not Eof do
          begin
            nit_empleado := DataQuerys.IBdata.FieldByName('nitempleado').AsInteger;
            with DataQuerys.IBdatos do
            begin
               Close;
               verificatransaccion(DataQuerys.IBdatos);
               SQL.Clear;
               SQL.Add('update "nom$consolidado" set');
               SQL.Add('"nom$consolidado"."vacaciones" = :vacaciones,');
               SQL.Add('"nom$consolidado"."prima_vacaciones" = :prima_vacaciones,');
               SQL.Add('"nom$consolidado"."prima_ant = :prima_ant"');
               SQL.Add('"nom$consolidado"."nit" = :nit');
               if consolidar(nit_empleado,1) <= 0 then
               ParamByName('vacaciones').AsCurrency := vacacionconsolidada(nit_empleado,1) - SimpleRoundTo(((descuento(DataQuerys.IBselecion,nit_empleado,3)/3)*2)/12,0) + consolidar(nit_empleado,1)
               else
                  ShowMessage(CurrToStr(descuento(DataQuerys.IBselecion,nit_empleado,3)/3*2 + consolidar(nit_empleado,1)));
               ParamByName('prima_vacaciones').AsCurrency := interescesantia(descuento(DataQuerys.IBselecion,nit_empleado,3),nit_empleado,4,10) - (descuento(DataQuerys.IBselecion,nit_empleado,3)/24) - consolidar(nit_empleado,2);
               ParamByName('prima_ant').AsCurrency := prima(nit_empleado,1) + consolidar(nit_empleado,3);
               ParamByName('nit').AsInteger :=  DataQuerys.IBselecion.FieldByName('nitempleado').AsInteger;
               Open;
               Close;
               Transaction.Commit;
            end;
            Next;
          end;
        end;
                    
end;

function interes(nit: integer): currency;
begin
        with DataQuerys.IBdatos do
        begin
           verificatransaccion(DataQuerys.IBdatos);
           Close;
           SQL.Clear;
           SQL.Add('SELECT');
           SQL.Add('"nomina"."interes"');
           SQL.Add('FROM');
           SQL.Add('"nomina"');
           SQL.Add('WHERE');
           SQL.Add('("nomina"."nit" = :nit) and');
           SQL.Add('("nomina"."mes" = 12)');
           ParamByName('nit').AsInteger := nit;
           Open;
           Result := SimpleRoundTo(FieldByName('interes').AsCurrency,0);
           Close;
        end;
end;

function valor_transporte(nit,tipo:Integer): currency;
var    codigo :Integer;
       fecha :TDate;
       auxilio :Boolean;
       fecha_corte : TDate;
       _dFechareal :TDate;
begin
        if StrToInt(FormatDateTime('mm',Date)) <= 6 then
           fecha_corte := StrToDate(FormatDateTime('yyyy/01/01',Date))
        else
           fecha_corte := StrToDate(FormatDateTime('yyyy/07/01',Date));
        if tipo = 2 then
           fecha_corte := StrToDate(FormatDateTime('yyyy/01/01',Date));       
        with DataQuerys.IBdatos do
        begin
          verificatransaccion(DataQuerys.IBdatos);
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$empleado"."fecha_registro",');
          SQL.Add('"nom$empleado"."aux_transporte"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit;
          Open;
          fecha := StrToDate(FormatDateTime('yyyy/mm/01',FieldByName('fecha_registro').AsDateTime));
          if fecha > fecha_corte then
             _dFechareal := fecha
          else
             _dFechareal := fecha_corte;
          try
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('sum("nom$nomina"."transporte")/count("nom$nomina"."transporte") as promedio');
            SQL.Add('FROM');
            SQL.Add('"nom$nomina"');
            SQL.Add('INNER JOIN "nom$controlnomina" ON ("nom$nomina"."codigo_nomina"="nom$controlnomina"."cod_nomina")');
            SQL.Add('WHERE');
            SQL.Add('("nom$controlnomina"."fecha" >= :FECHA) AND');
            SQL.Add('("nom$nomina"."nit_empleado" = :ID) AND');
            SQL.Add('("nom$nomina"."transporte" > 0)');
            ParamByName('FECHA').AsDate := _dFechareal;
            ParamByName('ID').AsInteger := nit;
            Open;
            Result := FieldByName('promedio').AsCurrency;
          except
            Result := 0;
          end;
        end;
{          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$controlnomina"."cod_nomina"');
          SQL.Add('FROM');
          SQL.Add('"nom$controlnomina"');
          SQL.Add('WHERE');
          SQL.Add('("nom$controlnomina"."fecha" = :fecha)');
          ParamByName('fecha').AsDate := fecha_corte;
          Open;
          codigo := FieldByName('cod_nomina').AsInteger;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('SUM("nom$nomina"."transporte") / 6 AS TRANSPORTE');
          SQL.Add('FROM');
          SQL.Add('"nom$nomina"');
          SQL.Add('WHERE');
          SQL.Add('("nom$nomina"."nit_empleado" = :nit) AND');
          SQL.Add('("nom$nomina"."codigo_nomina" >= :cod)');
          ParamByName('nit').AsInteger := nit;
          ParamByName('cod').AsInteger := codigo;
          Open;
          Result := FieldByName('transporte').AsCurrency;
        end;                                      }
end;


function tasaretefuente(nit: integer): rete;
var    sueldo,fsp1,pension :Currency;
       tasa :Currency;
       monto :Currency;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
{          SQL.Clear;
          SQL.Add('select * from "nom$empleado"');
          SQL.Add('where "nom$empleado"."nitempleado" = :nit');
          ParamByName('nit').AsInteger := nit;
          Open;
          sueldo := FieldByName('sueldobasico').AsCurrency;}
          SQL.Clear;
          SQL.Add('select "nom$retefuente"."retefuente"');
          SQL.Add('from');
          SQL.Add('"nom$retefuente"');
          SQL.Add('where "nom$retefuente"."nit_empleado" = :nit_empleado');
          ParamByName('nit_empleado').AsInteger := nit;
          Open;
          tasa := FieldByName('retefuente').AsCurrency;
        end;
          if tasa <= 0 then
          begin
            tasa := 0;
            monto := 0;
          end
          else
          begin
             sueldo := (descuento(DataQuerys.IBselecion,nit,2) + horaextra(DataQuerys.IBselecion,nit));
             fsp1 := fsp(DataQuerys.IBselecion,nit);
             pension := deduccion(DataQuerys.IBselecion,200,nit);
             monto := SimpleRoundTo(((sueldo - (fsp1 + pension))* 0.75),0);
             tasa := tasa;
          end;
          Result.monto := monto;
          Result.tasa := tasa;
end;
function pension(nit, codigo: integer): currency;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Add('select "nom$pension"."valor" as valor from "nom$pension"');
          SQL.Add('where "nom$pension"."id_persona" = :ID_PERSONA');
          ParamByName('ID_PERSONA').AsInteger := nit;
          Open;
          Result := SimpleRoundTo(FieldByName('valor').AsCurrency,0);
        end;

end;

function nDias(nit, opcion: integer): currency;
begin
        with DataQuerys.IBselecion do
        begin
          verificatransaccion(DataQuerys.IBselecion);
          Close;
          SQL.Clear;
          if opcion = 0 then
          begin
          end
          else
          begin
          end;
        end;
end;

function vCodigoPuc(nit: integer): integer;
begin
        Result := -1;
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Add('SELECT ');
          SQL.Add('  "nom$relacion".ID_AGENCIA');
          SQL.Add('FROM');
          SQL.Add(' "nom$relacion"');
          SQL.Add('WHERE');
          SQL.Add('  ("nom$relacion".NIT = :NIT)');
          ParamByName('NIT').AsInteger := nit;
          Open;
          case FieldByName('ID_AGENCIA').AsInteger of
            2 : Result := 59;
            3 : Result := 60;
            4 : Result := 61;
            5 : Result := 66;
          end;

          //Result := SimpleRoundTo(FieldByName('valor').AsCurrency,0);
        end;
end;

function BuscaCol(vId_Colocacion: string): boolean;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Add('SELECT ID_COLOCACION FROM "nom$colocacion" WHERE ID_COLOCACION = :ID AND ESTADO = 1');
          ParamByName('ID').AsString := vId_Colocacion;
          Open;
          if RecordCount = 0 then
             Result := False
          else
             Result := True;
        end;

end;

function retornadias(fecha: tdate): integer;
var     FechaFin :TDate;
        ano :string;
begin
        ano := IntToStr(YearOf(Date));
        FechaFin := StrToDate(ano + '/12/31');
        Result := DaysBetween(fecha,FechaFin);
end;

function procesantia(nit: Integer; sueldo: currency): currency;
var    verifica :Boolean;
        codigo :Integer;
begin
        verifica := False;
        with DataQuerys.IBdatos do
        begin
          verificatransaccion(DataQuerys.IBaportes);
          Close;
          SQL.Clear;
          SQL.Add('select max("nom$controlnomina"."cod_nomina") - 4 as codigo from "nom$controlnomina"');
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

function proservicios(fecha: tdate; nit: integer): currency;
begin
        with DataQuerys.IBdatos do
        begin
          verificatransaccion(DataQuerys.IBaportes);
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('sum("nom$nomina"."sueldobasico")/count("nom$nomina"."sueldobasico") as promedio');
          SQL.Add('FROM');
          SQL.Add('"nom$nomina"');
          SQL.Add('INNER JOIN "nom$controlnomina" ON ("nom$nomina"."codigo_nomina"="nom$controlnomina"."cod_nomina")');
          SQL.Add('WHERE');
          SQL.Add('("nom$controlnomina"."fecha" >= :FECHA) AND');
          SQL.Add('("nom$nomina"."nit_empleado" = :ID)');
          ParamByName('ID').AsInteger := nit;
          ParamByName('FECHA').AsDate := fecha;
          Open;
          Result := FieldByName('promedio').AsCurrency;
        end;
end;

function diasservicio(fecha: TDate): integer;
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
        if Date >= StrToDate('2011/07/01') then
        begin
          if valida then
             Result := 30 * (mes_actual - 6)
          else
          begin
            if fecha > StrToDate('2011/07/01') then
            begin
               Result := (30 * (mes_actual - mes_entrada)) + no_dias;
            end
            else
              Result := 30 * (mes_actual - 6);
          end;
        end
        else
        begin
         if valida then
            result := 180
         else
            result := (30 * (mes_actual - mes_entrada)) + no_dias;
        end;


end;

function serextras(nit: Integer; fecha: TDate): currency;
begin
        with DataQuerys.IBdatos do
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
          SQL.Add('  ("nom$nomina"."nit_empleado" = :ID)');
          ParamByName('FECHA').AsDate := fecha;
          ParamByName('ID').AsInteger := nit;
          Open;
          Result := FieldByName('promedio').AsCurrency;
        end;

end;
function cPrima360(nit: integer): currency;
begin
        with DataQuerys.IBingresa do
        begin
          verificatransaccion(DataQuerys.IBingresa);
          Close;
          SQL.Clear;
          SQL.Add('select VALOR from NOM$CAUSACION360 WHERE NIT = :NIT');
          ParamByName('NIT').AsInteger := nit;
          Open;
          if RecordCount = 0 then
             Result := 0
          else
             Result := FieldByName('VALOR').AsCurrency;
          Close;
        end;
end;
procedure ActualizaCon;
begin
//        verificatransaccion(DataQuerys.IBdatos);
        verificatransaccion(DataQuerys.IBselecion);
        with DataQuerys.IBdatos do
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
            DataQuerys.IBselecion.Close;
            DataQuerys.IBselecion.SQL.Clear;
            DataQuerys.IBselecion.SQL.Add('UPDATE');
            DataQuerys.IBselecion.SQL.Add('  "nom$consolidado"');
            DataQuerys.IBselecion.SQL.Add('SET');
            DataQuerys.IBselecion.SQL.Add('  "prima_vacaciones" = :VALOR');
            DataQuerys.IBselecion.SQL.Add('WHERE');
            DataQuerys.IBselecion.SQL.Add('  "nom$consolidado"."nit" = :NIT');
            DataQuerys.IBselecion.ParamByName('VALOR').AsCurrency := 0;
            DataQuerys.IBselecion.ParamByName('NIT').AsInteger := FieldByName('NIT').AsInteger;
            DataQuerys.IBselecion.ExecSQL;
            DataQuerys.IBselecion.Transaction.CommitRetaining;
            Next;
          end;
          DataQuerys.IBselecion.Transaction.Commit;
        end;

end;
function vCodigoPucCXC(nit,opcion: integer): Integer;
var     _iIdAgencia :Integer;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Add('SELECT');
          SQL.Add('  DISTINCT "nom$libranza".IDAGENCIA');
          SQL.Add('FROM');
          SQL.Add('  "nom$libranza"');
          SQL.Add('WHERE');
          SQL.Add('  "nom$libranza".NIT = :NIT');
          ParamByName('NIT').AsInteger := nit;
          Open;
          _iIdAgencia := FieldByName('IDAGENCIA').AsInteger;
          if opcion = 0 then
          begin
            case _iIdAgencia of
              2 : Result := 67;
              3 : Result := 68;
              4 : Result := 69;
              5 : Result := 70;
            end;
          end
          else
            Result := _iIdAgencia;
        end;
end;

end.



