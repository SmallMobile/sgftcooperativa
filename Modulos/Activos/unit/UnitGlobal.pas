unit UnitGlobal;

interface
Uses Forms, StdCtrls, DBCtrls, IB, IBSQL , Messages,SysUtils,Math,DB,DBGrids,Windows,Controls, StrUtils,Classes,Dialogs, winspool, Printers;
procedure Numerico(Sender:TObject;var Key:Char);
function total_mes(fecha,fecha2:string):Integer;
function no_meses(fecha_e,fecha_s:string): Integer;
function no_mesant(fecha_e, fecha_s: string): integer;
function obtenerfecha(fecha_e, vidau: string): string;
function Precisarcodigo(Codigo: String): String;
function InttoBoolean(Valor: Integer): Boolean;
procedure EnterTabs(var Key: Char; oSelf: TForm);
function deprecia(placa, utilidad: string): string;
function validaactivo(placa: string): integer;
function depreciaactivo(codigo: string): string;
function completacodigos(codigo: string): string;
function devuelve(placa: string): string;
procedure ValidaPlaca(Sender: TObject; var Key: Char);

var
  Empleado: string;

function empleados(dbalias:string): string;
function devuelveoficina(placa: string): integer;
function obtenerfechaatras(fecha_e, vidau: string): string;
function validafecha: boolean;
function ObtenerConsecutivo(IBSQL1: TIBSQL): LongInt;
function clavemayor(codifo: string): string;
function saldo_cuenta(mes: string; codigopuc,
  id_agencia: integer): currency;

implementation
uses unitdatamodulo,unitdecomprobante,unitdata;

procedure Numerico(Sender:TObject;var Key:Char);
begin
if not (Key in [#8,#13, '0'..'9', '-', DecimalSeparator]) then
  begin
    Key := #0;
  end //End First if.
  else
  if ((Key = DecimalSeparator) or (Key = '-')) and (Pos(Key, TMemo(Sender).Text ) > 0) then
  begin
    Key := #0;
  end//End second if.
  else
  if (Key = '-') and (TMemo(Sender).SelStart <> 0) then
  begin
    Key := #0;
  end;//End third if.
end;

function total_mes(fecha,fecha2:string):integer;
var     ano_ini,meses,ano_fin: Integer;
begin
        ano_ini := StrToInt(FormatDateTime('yyyy',StrToDateTime(fecha)));
        meses := 13-StrToInt(FormatDateTime('mm',StrToDateTime(fecha)));
        ano_fin := StrToInt(FormatDateTime('yyyy',StrToDateTime(fecha2)));
        if ano_ini = ano_fin then
           Result := 0
        else
           Result := (((ano_fin - 1) - ano_ini)*12) + meses;
end;

function no_meses(fecha_e,fecha_s:string): Integer;
var     mes_fin,mes_ini:Integer;
begin
        mes_fin := StrToInt(FormatDateTime('mm',StrToDateTime(fecha_e)));
        if FormatDateTime('yyyy',StrToDateTime(fecha_e)) <> FormatDateTime('yyyy',StrToDateTime(fecha_s)) then
         mes_ini := 0
        else
          mes_ini := StrToInt(FormatDateTime('mm',StrToDateTime(fecha_s)));
        Result := mes_fin-mes_ini;

end;

function no_mesant(fecha_e, fecha_s: string): integer;
var     ano_ini,meses,ano_fin: Integer;
begin
        ano_ini := StrToInt(FormatDateTime('yyyy',StrToDateTime(fecha_e)));
        meses := 12 - StrToInt(FormatDateTime('mm',StrToDateTime(fecha_e)));
        ano_fin := StrToInt(FormatDateTime('yyyy',StrToDateTime(fecha_s)));
        if ano_ini = ano_fin then
           Result := 0
        else
           Result := (((ano_fin - 1) - ano_ini) * 12) + meses;
end;
function obtenerfecha(fecha_e, vidau: string): string;
var      vidautil:Integer;
         total:Variant;
begin
        vidautil := StrToInt(vidau);
        total := vidautil*30.41;
        fecha_e := FormatDateTime('yyyy/mm/01',StrToDateTime(fecha_e)+total);
        Result := fecha_e;
end;

function Precisarcodigo(Codigo: String): String;
var Longitud : Integer;
begin
        Longitud := 16;
        if MidStr(Codigo,17,2) = '00' then Longitud := 14; //18-10
        if MidStr(Codigo,15,2) = '00' then Longitud := 13; //16-9
        if MidStr(Codigo,13,2) = '00' then Longitud := 10; //14-8
        if MidStr(Codigo,11,2) = '00' then Longitud := 8; //12-7
        if MidStr(Codigo,9,2)  = '00' then Longitud := 6; //10-6
        if MidStr(Codigo,7,2)  = '00' then Longitud := 4; //8-5
        if MidStr(Codigo,5,2)  = '00' then Longitud := 2; //6-4
        if MidStr(Codigo,3,2)  = '00' then Longitud := 1; //4-3
        if Midstr(Codigo,2,1)  = '0'  then Longitud := 1; //1-2
        Result := LeftStr(Codigo,Longitud);
end;

function InttoBoolean(Valor: Integer): Boolean;
begin
  If Valor <> 0 then
          Result := True
       Else
          Result := False;
end;
procedure EnterTabs(var Key: Char; oSelf: TForm);
begin
if (Key = #13) and
      not (oSelf.ActiveControl is TButton)    and
      not (oSelf.ActiveControl is TDBMemo)
                                 then begin
      oSelf.Perform( WM_NEXTDLGCTL, 0,0);
      Key := #0;
      end;
end;
function deprecia(placa, utilidad: string): string;
var     vidautil,mes_actual,mes_a,mes_anterior,total_mes,ano1,ano2 :Integer;
        descripcion,fechaingreso,Clase,fechasalida,fechasalida1:string;
        valorhistorico,dep_actual,dep_anterior,total_depreciacion,valor_libros:Variant;
        depreciacion_mes:Variant;
begin
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select distinct "act$activo"."cod_activo","act$activo"."placa",');
          SQL.Add('"act$activo"."descripcion","act$activo"."fechacompra",');
          SQL.Add('"act$activo"."preciocompra","act$activo"."vidadepreciable",');
          SQL.Add('"act$clase_activo"."descripcion" as clase');
          SQL.Add('from "act$clase_activo" ,"act$activo"');
          SQL.Add(' where "act$activo"."clase_activo"="act$clase_activo"."cod_clase"');
          SQL.Add('and "act$activo"."estado" = :"estado" and');
          SQL.Add('"act$activo"."placa"=:"placa"');
          SQL.Add('and "act$activo"."esactivo"=1');
          ParamByName('placa').AsString:=placa;
          ParamByName('estado').AsString:='A';
          Open;
            while not DataGeneral.IBsel.Eof do
            begin
             vidautil := FieldByName('vidadepreciable').AsInteger;
             placa := FieldByName('placa').AsString;
             descripcion := FieldByName('descripcion').AsString;
             fechaingreso := DateToStr(FieldByName('fechacompra').AsDateTime);
             valorhistorico := FieldByName('preciocompra').AsCurrency;
             Clase := FieldByName('clase').AsString;
             fechasalida1 := DateTimeToStr(Date);
             mes_anterior := no_mesant(fechaingreso,DateToStr(date));// calcula el no de meses antes del año en curso...
             mes_actual := no_meses(DateToStr(Date),fechaingreso);// calcula el no de meses del año en curso..
             total_mes := mes_anterior + mes_actual;// total meses
             depreciacion_mes := valorhistorico/vidautil;// depreciacion mensual
               if total_mes <= vidautil then
               begin
                dep_actual := mes_actual * depreciacion_mes;// depreciacion año en curso
                dep_anterior := mes_anterior * depreciacion_mes;// depreciacion a fin del año anterior
                total_depreciacion := total_mes * depreciacion_mes;// total depreciacion acumulada
                valor_libros := valorhistorico - total_depreciacion; // valor en libros del activo a la fecha
               end
               else
               begin
                 fechasalida := obtenerfecha(fechaingreso,IntToStr(vidautil));
                 ano1 := StrToInt(FormatDateTime('yyyy',StrToDateTime(fechasalida)));
                 fechasalida1 := DateTimeToStr(date);
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
                 end;// end  del if del compara años
                 valor_libros := 0;
                 total_depreciacion := valorhistorico;
                 end; //fin del while
                 Close;
                 if utilidad = '1' then
                   Result := descripcion
                 else if utilidad = '2' then
                   Result := CurrToStr(valorhistorico)
                 else if utilidad = '3' then
                   Result := IntToStr(mes_actual)
                 else if utilidad = '4' then
                   Result := CurrToStr(dep_actual)
                 else if utilidad = '5' then
                   Result := CurrToStr(dep_anterior)
                 else if utilidad = '6' then
                   Result := IntToStr(mes_anterior)
                 else if utilidad = '7' then
                   Result := IntToStr(mes_anterior)
                 else if utilidad = '8' then
                   Result := IntToStr(total_mes)
                 else if utilidad = '9' then
                   Result := CurrToStr(depreciacion_mes)
                 else if utilidad = '10' then
                   Result := CurrToStr(valor_libros)
                 else if utilidad = '11' then
                   Result := IntToStr(vidautil)
                 else if utilidad = '12' then
                   Result := fechaingreso
                 else if utilidad = '13' then
                   Result := CurrToStr(total_depreciacion)
          end;
     end;
end;

function validaactivo(placa: string): integer;
begin
         with DataGeneral.IBsql do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select count(*) contador from "act$activo"');
          SQL.Add('where "act$activo"."placa"=:"cod"');
          SQL.Add('and "act$activo"."estado"=:"estado"');
          ParamByName('cod').AsString:=placa;
          ParamByName('estado').AsString:='D';
          ExecQuery;
          Result := FieldByName('contador').AsInteger;
          Close;
        end;
end;
function depreciaactivo(codigo: string): string;
var a:string;
begin
        with dmcomprobante.buscacodigo do
        begin
          Close;
          ParamByName('codigo').AsString := '1795';
          ParamByName('nombre').AsString := codigo;
          Open;
          a := FieldByName('CODIGO').AsString;
          Result := a;
          Close;
        end;
end;
function completacodigos(codigo: string): string;
var     a,b,i:Integer;
        codigocompleto:string;
begin
        codigocompleto:=codigo;
        a := StrLen(PChar(codigo));
        b := 18 - a;
        for i := 1 to b do
          codigocompleto := codigocompleto + '0';
        Result := codigocompleto;
end;

function devuelve(placa: string): string;
begin
        Result := LeftStr(placa,3);
end;

procedure ValidaPlaca(Sender: TObject; var Key: Char);
begin
        if not (Key in [#8,#13, '0'..'9', '-','N','n','a','A']) then
        begin
            Key := #0;
        end; //End First if.
end;

function empleados(dbalias:string): string;
var      nombres,apellidos:string;
begin
         with frmdata.IBQuery3 do
         begin
           sql.Clear;
           sql.Add('select PRIMER_APELLIDO, SEGUNDO_APELLIDO, NOMBRE from "gen$empleado"');
           sql.Add('where "gen$empleado"."ID_EMPLEADO" =:"ID_EMPLEADO"');
           ParamByName('ID_EMPLEADO').AsString := DBAlias;
           Open;
           Nombres := FieldByName('NOMBRE').AsString;
           Apellidos := FieldByname('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
         end;
         Result :=apellidos + ' ' + nombres;
end;

function devuelveoficina(placa: string): integer;
begin
        with DataGeneral.ibglobal do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"act$traslado"."cod_oficina"');
          SQL.Add('FROM');
          SQL.Add('"act$traslado"');
          SQL.Add('INNER JOIN "act$activo" ON ("act$traslado"."cod_activo" = "act$activo"."cod_activo")');
          SQL.Add('WHERE');
          SQL.Add('("act$traslado"."lugar" = :"estado") AND');
          SQL.Add('("act$activo"."esactivo" = 1) AND');
          SQL.Add('("act$activo"."estado" = :"lugar") AND');
          SQL.Add('("act$activo"."placa" = :"placa")');
          ParamByName('placa').AsString:=placa;
          ParamByName('estado').AsString:='A';
          ParamByName('lugar').AsString:='A';
          Open;
            if FieldByName('cod_oficina').AsString = '' then
               Result := 0
            else
               Result := StrToInt(FieldByName('cod_oficina').AsString);
          Close;
        end;
end;

function obtenerfechaatras(fecha_e, vidau: string): string;
var      vidautil:Integer;
         total:Variant;
begin
        vidautil := StrToInt(vidau);
        total := vidautil * 30.41;
        fecha_e := FormatDateTime('01/mm/yy',StrToDateTime(fecha_e) - total);
        Result := fecha_e;
end;

function validafecha: boolean;
var fecha,fecha1:string;
begin

        with DataGeneral.IBsel3 do
        begin;
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('select max("act$controldepreciacion"."fecha") as fecha from "act$controldepreciacion"');
          Open;
          fecha := FormatDateTime('"01"/mm/yy',FieldByName('fecha').AsDateTime);
          Close;
          Transaction.Commit;
        end;
        fecha1 := FormatDateTime('"01"/mm/yy',Date);
        if FormatDateTime('dd/mm/yy',StrToDate(fecha1)) <= FormatDateTime('dd/mm/yy',StrToDate(fecha)) then
           Result := True
        else
            Result := False;
end;

function ObtenerConsecutivo(IBSQL1: TIBSQL): LongInt;
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

function clavemayor(codifo: string): string;
begin
        with frmdata.IBQuery3 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"con$puc".NOMBRE');
          SQL.Add('FROM');
          SQL.Add('"con$puc"');
          SQL.Add('WHERE');
          SQL.Add('("con$puc".CLAVE = :codigo)');
          ParamByName('codigo').AsString := codifo;
          Open;
          Result := FieldByName('NOMBRE').AsString;
          Close;
        end;
end;

function saldo_cuenta(mes: string; codigopuc,
  id_agencia: integer): currency;
var     saldo_inicial,saldo_final,total_saldo :Currency;
        codigo: string;
begin
          with DataGeneral.IBQuery1 do
          begin
            Close;
            if Transaction.InTransaction then
               Transaction.Commit
            else
               Transaction.StartTransaction;
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
          with DataGeneral.IBQuery1 do
          begin
            Close;
            if Transaction.InTransaction then
               Transaction.Commit
            else
               Transaction.StartTransaction;
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

end.
