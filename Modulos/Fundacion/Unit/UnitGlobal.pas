unit UnitGlobal;
interface
uses JclDateTime,pr_Common, pr_TxClasses,Forms, StdCtrls, DBCtrls, IB, IBSQL,IBQuery , Messages,SysUtils,Math,DB,DBGrids,Windows,Controls, StrUtils,Classes,Dialogs, winspool, Printers,DateUtils;
procedure verificatransaccion(IBQuery1:TIBQuery);
function parametro(parametro, convenio, edad: smallint;
  definicion: string;IBquery1:TIBQuery): boolean;
function validafecha(nit: string): boolean;
function empleados(dbalias: string;opcion:integer): string;
function actualiza_fecha(fecha: tdate): tdate;
function valor_plan(id_afiliacion: integer): Currency;
function busca_plan(id_afiliacion: integer): string;
function buscar_carnet(nit: string; id_convenio,Opcion: integer): string;
function edad(fecha: tdate): integer;
function busca_numerocuenta(nit: string): string;
function DigitoControl(Tipo: Integer; Cuenta: string): string;
function CalculoFecha(FechaActual: TDate; Dias: Integer): TDate;
function Dias(FechaInicial, FechaFinal: TDate): Integer;
procedure actualiza_fondo;
function busca_eps(nit: string): string;
function empleado_fun(dbalias: string): string;
function edad1(fecha: tdate): integer;
implementation
uses Unitquerys,Unitdataquerys;

procedure verificatransaccion(IBQuery1:TIBQuery);
begin
        with IBQuery1 do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
        end;
end;
function empleados(dbalias: string;opcion:integer): string;
var      nombres,apellidos:string;
begin
         with FrmQuerys.IBseleccion do
         begin
           sql.Clear;
           sql.Add('select PRIMER_APELLIDO, SEGUNDO_APELLIDO, NOMBRE from "gen$empleado"');
           sql.Add('where "gen$empleado"."ID_EMPLEADO" =:"ID_EMPLEADO"');
           ParamByName('ID_EMPLEADO').AsString := UpperCase(DBAlias);
           Open;
           Nombres := FieldByName('NOMBRE').AsString;
           Apellidos := FieldByname('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
         end;
         if opcion = 1 then
           Result := apellidos + ' ' + nombres
         else
           Result := nombres + ' ' + apellidos;
end;

function parametro(parametro, convenio, edad: smallint;
  definicion: string;IBquery1:TIBQuery): boolean;
var     edad_entrante :Integer;
        variable :string;
begin
        with IBquery1 do
        begin
          Close;
          verificatransaccion(IBquery1);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$parametros"."definicion",');
          SQL.Add('"fun$parametros"."parametro",');
          SQL.Add('"fun$parametros"."valor"');
          SQL.Add('FROM');
          SQL.Add('"fun$parametros"');
          SQL.Add('WHERE');
          SQL.Add('("fun$parametros"."parentesco" = :parentesco) AND');
          SQL.Add('("fun$parametros"."id_convenio" = :convenio)');
          ParamByName('parentesco').AsInteger := parametro;
          ParamByName('convenio').AsInteger := convenio;
          Open;
          if FieldByName('valor').AsInteger = 0 then begin
             Result := true;
             Exit;
          end;
          edad_entrante := FieldByName('valor').AsInteger;
          variable := FieldByName('parametro').AsString;
          Close;
          if variable = '<' then begin
             if edad_entrante < edad then
                Result := True
             else Result := False;
          end//menor
          else if variable = '>' then begin
             if edad_entrante > edad then
                Result := True
             else Result := False;
          end//mayor
          else if variable = '=' then begin
             if edad_entrante = edad then
                Result := True
             else Result := False;
          end// igual
          else if variable = '<=' then begin
             if edad_entrante <= edad then
                Result := True
             else Result := False;
          end// menor igual
          else if variable = '>=' then begin
             if edad_entrante >= edad then
                Result := True
             else Result := False;
          end// mayor igual
          else if variable = 'NINGUNO' then
                 Result := False;
          end;

end;

function validafecha(nit: string): boolean;
var     fecha :TDate;
begin
        with DataQuerys.IBFundacion do
        begin
           Close;
           verificatransaccion(DataQuerys.IBFundacion);
           SQL.Clear;
           SQL.Add('select max("fun$afiliacion"."fecha_vencimiento") as fecha from "fun$afiliacion"');
           SQL.Add('where "fun$afiliacion"."nit_beneficiario" = :nit');
           ParamByName('nit').AsString := nit;
           Open;
           fecha := FieldByName('fecha').AsDateTime;
           Close;
           Transaction.Commit;
        end;
        if Int(fecha) > Int(Date) then
           Result := True
        else
           Result := False;
end;

function actualiza_fecha(fecha: tdate): tdate;
var    ano :string;
begin
        ano := IntToStr(YearOfDate(fecha) + 1);
        try
          Result := StrToDate(FormatDateTime(ano+'/mm/dd',fecha));
        except
          Result := fecha + 365;
        end;
end;

function valor_plan(id_afiliacion: integer): currency;
begin
          with DataQuerys.IBFundacion do
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"fun$planbeneficiario"."valor"');
            SQL.Add('FROM');
            SQL.Add('"fun$planbeneficiario"');
            SQL.Add('WHERE');
            SQL.Add('("fun$planbeneficiario"."id_afiliacion" = :id_afiliacion)');
            ParamByName('id_afiliacion').AsInteger := id_afiliacion;
            Open;
            Result := FieldByName('valor').AsCurrency;
          end;
end;

function busca_plan(id_afiliacion: integer): string;
var     id_plan :Integer;
begin
        with DataQuerys.IBFundacion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$planbeneficiario"."id_plan"');
          SQL.Add('FROM');
          SQL.Add('"fun$planbeneficiario"');
          SQL.Add('WHERE');
          SQL.Add('("fun$planbeneficiario"."id_afiliacion" = :id_afiliacion)');
          ParamByName('id_afiliacion').AsInteger := id_afiliacion;
          Open;
          id_plan := FieldByName('id_plan').AsInteger;
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$planes"."descripcion"');
          SQL.Add('FROM');
          SQL.Add('"fun$planes"');
          SQL.Add('WHERE');
          SQL.Add('("fun$planes"."id_plan" = :id)');
          ParamByName('id').AsInteger := id_plan;
          Open;
          Result := FieldByName('descripcion').AsString;
          Close;
        end;
end;

function buscar_carnet(nit: string; id_convenio,opcion: integer): string;
begin
        with DataQuerys.IBFundacion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          case opcion of
            1: SQL.Add('"fun$carnet"."no_carnet" as no_carnet');
            2: SQL.Add('"fun$carnet"."descripcion" as no_carnet');
          end;
          SQL.Add('FROM');
          SQL.Add('"fun$carnet"');
          SQL.Add('WHERE');
          SQL.Add('("fun$carnet"."nit_beneficiario" = :nit) AND');
          SQL.Add('("fun$carnet"."programa" = :programa)');
          ParamByName('nit').AsString := nit;
          ParamByName('programa').AsInteger := id_convenio;
          Open;
          Result := FieldByName('no_carnet').AsString;
          Close;
        end;
end;

function edad(fecha: tdate): integer;
begin
        if DayOfDate(Date) < DayOfDate(fecha) then
           Result :=  YearOfDate(date) - YearOfDate(fecha) - 1
        else
           Result :=  YearOfDate(date) - YearOfDate(fecha);
end;

function busca_numerocuenta(nit: string): string;
begin
     with DataQuerys.IBselecion do
     begin
       Close;
       SQL.Clear;
       SQL.Add('SELECT');
       SQL.Add('"fun$datos_asociado"."numero_cuenta"');
       SQL.Add('FROM');
       SQL.Add('"fun$datos_asociado"');
       SQL.Add('WHERE');
       SQL.Add('("fun$datos_asociado"."nit_asociado" = :nit)');
       ParamByName('nit').AsString := nit;
       Open;
       if RecordCount <> 0 then
          Result := FieldByName('numero_cuenta').AsString
       else
         Result := '';
       Close;
     end;
end;

function DigitoControl(Tipo: Integer; Cuenta: string): string;
var 
    n,i:Integer;
begin
        n := 0;
        for i := 0 to 6 do
        begin
          n := n + StrToInt(MidStr(cuenta,i+1,1));
        end;
        n := n + Tipo;
        Result := RightStr(FormatCurr('00',n),1);
end;

function CalculoFecha(FechaActual: TDate; Dias: Integer): TDate;
var Mes: Integer;
    Ano: Integer;
    Dia: Integer;
    I: Integer;
begin

     Dia := DayOf(FechaActual);
     Mes := MonthOf(FechaActual);
     Ano := YearOf(FechaActual);

     if Dias > 0 then
      begin
        for I := 1 to Dias do
        begin
           Dia := Dia + 1;
           if Dia > 30 then
           begin
              Dia := 1;
              Mes := Mes + 1;
              if Mes > 12 then
              begin
                   Mes := 1;
                   Ano := Ano + 1;
              end
           end
        end;
      end
     else
      begin
        for I := 1 to ABS(Dias) do
        begin
           Dia := Dia - 1;
           if Dia = 0 then
           begin
              Dia := 30;
              Mes := Mes - 1;
              if Mes = 0 then
              begin
                   Mes := 12;
                   Ano := Ano - 1;
              end
           end
        end;
        Dia := ABS(Dia);
      end;

        if Mes = 2 then
         if Dia > 28 then
            Dia := DayOf(EndOfAMonth(Ano,Mes));

        Result := FechaActual;
        Result := RecodeDate(Result,Ano,Mes,Dia);



end;

function Dias(FechaInicial, FechaFinal: TDate): Integer;
var A,AA,M,MM,D,DD:Word;
    Dias:Integer;
    Fecha:TDate;
    Negativo:Boolean;
begin
        Negativo := False;
        if FechaInicial > FechaFinal then
        begin
          Fecha := FechaInicial;
          FechaInicial := FechaFinal;
          FechaFinal := Fecha;
          Negativo := True;
        end;
        Dias := 0;
        Fecha := FechaInicial;
        DecodeDate(FechaInicial,A,M,D);
        DecodeDate(FechaFinal,AA,MM,DD);
        FechaFinal := EncodeDate(AA,MM,DD);
        if (MM = 2) and ( (DD=28) or (DD=29)) then DD := 30;
        if DD = 31 then DD := 30;

        while true do
        begin
         if (AA = A) and (MM = M) and (DD = D) then Break;
         Dias := Dias + 1;
         D := D + 1;
         if D > 30 then
         begin
           D := 1;
           M := M+1;
           if M > 12 then
           begin
              M := 1;
              A := A + 1;
           end;
         end;
        end;
        if Negativo then
           Result := -(Dias)
        else
           Result := Dias;

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

function busca_eps(nit: string): string;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$eps"."descripcion"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacioneps"');
          SQL.Add('INNER JOIN "fun$eps" ON ("fun$afiliacioneps"."id_eps" = "fun$eps"."id_eps")');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacioneps"."nit_beneficiario" = :id)');
          ParamByName('id').AsString := nit;
          Open;
          Result := FieldByName('descripcion').AsString;
          Close;
        end;

end;

function empleado_fun(dbalias: string): string;
begin
         with DataQuerys.IBdatos do
         begin
           sql.Clear;
           sql.Add('select PRIMER_APELLIDO, SEGUNDO_APELLIDO, NOMBRE from "gen$empleado"');
           sql.Add('where "gen$empleado"."ID_EMPLEADO" =:"ID_EMPLEADO"');
           ParamByName('ID_EMPLEADO').AsString := UpperCase(DBAlias);
           Open;
           Result := FieldByName('NOMBRE').AsString + ' ' + FieldByname('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
         end;

end;

function edad1(fecha: tdate): integer;
begin
        if DayOfDate(Date) < DayOfDate(fecha) then
           Result :=  YearOfDate(date) - YearOfDate(fecha) - 1
        else
           Result :=  YearOfDate(date) - YearOfDate(fecha);
end;

end.
