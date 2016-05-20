unit UnitCaptaciones;

interface

uses Math,Controls,SysUtils,DateUtils,UnitdmLiquidacionCaptacion, UnitGlobales, UnitGlobalesCol;

type tInteres = record
   Interes:Currency;
   Causado:Currency;
   ReteInteres:Currency;
   ReteCausado:Currency;
   Retencion:Currency;
   SaldoAFecha:Currency;
   SaldoLiquidacion:Currency;
   TasaLiquidacion:Double;
   DiasLiquidacion:Integer;
end;

function InteresDiario(Ag:Integer;Tipo:Integer;Numero:Integer;Digito:Integer;FechaCorte:TDate;TasaN:Double;SaldoMinimo:Currency;DiarioRetefuente:Currency;TasaRetefuente:Double):tInteres;
function InteresCertificado(Valor:Currency;FechaCorte:TDate;TasaN:Double;DiarioRetefuente:Currency;TasaRetefuente:Extended;UltimoPago:TDate;Amor:Integer):tInteres;

implementation

function InteresDiario(Ag:Integer;Tipo:Integer;Numero:Integer;Digito:Integer;FechaCorte:TDate;TasaN:Double;SaldoMinimo:Currency;DiarioRetefuente:Currency;TasaRetefuente:Double):tInteres;
var SaldoI:Currency;
    Saldo:Currency;
    SaldoMenor:Currency;
    SaldoActual:Currency;
    R:tInteres;
begin
        with dmLiquidacionCaptacion.IBConsulta do
        begin
             Close;
             SQL.Clear;
             SQL.Add('select SALDO_INICIAL from "cap$maestrosaldoinicial" where ');
             SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" and ');
             SQL.Add('NUMERO_CUENTA = :"NUMERO_CUENTA" and DIGITO_CUENTA = :"DIGITO_CUENTA" and ANO = :"ANO"');
             ParamByName('ID_AGENCIA').AsInteger := Ag;
             ParamByName('ID_TIPO_CAPTACION').AsInteger := Tipo;
             ParamByName('NUMERO_CUENTA').AsInteger := Numero;
             ParamByName('DIGITO_CUENTA').AsInteger := Digito;
             ParamByName('ANO').AsString := IntToStr(Yearof(date));
             try
               ExecQuery;
               SaldoI := FieldByName('SALDO_INICIAL').AsCurrency;
             except
               SaldoI := 0;
             end;

             Close;
             SQL.Clear;
             SQL.Add('select SUM(VALOR_DEBITO - VALOR_CREDITO) AS SALDOM from "cap$extracto" where ');
             SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" and ');
             SQL.Add('NUMERO_CUENTA = :"NUMERO_CUENTA" and DIGITO_CUENTA = :"DIGITO_CUENTA" and FECHA_MOVIMIENTO >= :"FECHA1" and FECHA_MOVIMIENTO < :"FECHA2"');
             ParamByName('ID_AGENCIA').AsInteger := Ag;
             ParamByName('ID_TIPO_CAPTACION').AsInteger := Tipo;
             ParamByName('NUMERO_CUENTA').AsInteger := Numero;
             ParamByName('DIGITO_CUENTA').AsInteger := Digito;
             ParamByName('FECHA2').AsDate := FechaCorte;
             ParamByName('FECHA1').AsDate := EncodeDate(YearOf(Date),1,1);
             try
               ExecQuery;
               SaldoActual := SaldoI + FieldByName('SALDOM').AsCurrency;
             except
               SaldoActual := SaldoI;
             end;
             Close;

             if SaldoActual < SaldoMinimo then
             begin
                Result.Interes := 0;
                Result.Retencion := 0;
                Result.SaldoAFecha := 0;
                Result.SaldoLiquidacion := 0;
                Exit;
             end;

             Close;
             SQL.Clear;
             SQL.Add('select SUM(VALOR_DEBITO - VALOR_CREDITO) AS SALDOM from "cap$extracto" where ');
             SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" and ');
             SQL.Add('NUMERO_CUENTA = :"NUMERO_CUENTA" and DIGITO_CUENTA = :"DIGITO_CUENTA" and FECHA_MOVIMIENTO >= :"FECHA1" and FECHA_MOVIMIENTO < :"FECHA2"');
             ParamByName('ID_AGENCIA').AsInteger := Ag;
             ParamByName('ID_TIPO_CAPTACION').AsInteger := Tipo;
             ParamByName('NUMERO_CUENTA').AsInteger := Numero;
             ParamByName('DIGITO_CUENTA').AsInteger := Digito;
             ParamByName('FECHA2').AsDate := FechaCorte;
             ParamByName('FECHA1').AsDate := EncodeDate(YearOf(Date),1,1);
             try
               ExecQuery;
               Saldo := SaldoI + FieldByName('SALDOM').AsCurrency;
             except
               Saldo := SaldoI;
             end;
             Close;


             SQL.Clear;
             SQL.Add('select VALOR_DEBITO, VALOR_CREDITO from "cap$extracto" where ');
             SQL.Add('(ID_AGENCIA = :"ID_AGENCIA" ) and (ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" ) and ');
             SQL.Add('(NUMERO_CUENTA = :"NUMERO_CUENTA") and (DIGITO_CUENTA = :"DIGITO_CUENTA") and ');
             SQL.Add('(FECHA_MOVIMIENTO = :"FECHA_MOVIMIENTO") ORDER BY HORA_MOVIMIENTO');
             ParamByName('ID_AGENCIA').AsInteger := Ag;
             ParamByName('ID_TIPO_CAPTACION').AsInteger := Tipo;
             ParamByName('NUMERO_CUENTA').AsInteger := Numero;
             ParamByName('DIGITO_CUENTA').AsInteger := Digito;
             ParamByName('FECHA_MOVIMIENTO').AsDate := FechaCorte;
             try
               ExecQuery;
             except
               Close;
               Result.Interes := 0;
               Result.Retencion := 0;
               Exit;
             end;

             SaldoMenor := Saldo;

             while not Eof do
             begin
               Saldo := Saldo + FieldByName('VALOR_DEBITO').AsCurrency - FieldByName('VALOR_CREDITO').AsCurrency;
               if Saldo < SaldoMenor then
                  SaldoMenor := Saldo;
               Next;
             end;

             if SaldoMenor < 0 then SaldoMenor := 0;

             Saldo := SaldoMenor;

             R.SaldoAFecha := SaldoActual;
             R.SaldoLiquidacion := Saldo;
             R.DiasLiquidacion := 1;
             R.Causado := 0;
             R.TasaLiquidacion := TasaN;

             R.Interes := Saldo * ( TasaN/100 ) / 360;
             R.Interes := SimpleRoundTo(R.Interes,0);
             if R.Interes >= DiarioRetefuente then
             begin
                R.Retencion := R.Interes * ( TasaRetefuente / 100 );
                R.Retencion := SimpleRoundTo(R.Retencion,0);
             end
             else
                R.Retencion := 0;
        end;
      Result := R;

end;

function InteresCertificado(Valor:Currency;FechaCorte:TDate;TasaN:Double;DiarioRetefuente:Currency;TasaRetefuente:Extended;UltimoPago:TDate;Amor:Integer):tInteres;
var R:tInteres;
    Dias: Integer;
    DiasC: Integer;
    FechaC: TDate;
    Total : Currency;
    Diario:Integer;
    Dia:Integer;
    tInteres :Currency;
begin
        Dia := DayOf(FechaCorte);
        if Dia = 31 then
           Dia := 30;

        FechaCorte := EncodeDate(YearOf(FechaCorte),MonthOf(FechaCorte),Dia);

        UltimoPago := CalculoFecha(FechaCorte,-Amor);

        FechaC := FechaCorte;
        FechaC := EncodeDate(YearOf(FechaC),MonthOf(FechaC),01);
        FechaC := IncDay(FechaC,-1);

        DiasC := DiasEntre(Int(UltimoPago),Int(FechaC));
        if DiasC < 1 then DiasC := 0;
        Dias := DiasEntre(Int(UltimoPago),Int(FechaCorte));
        if Dias > Amor then Dias := Amor;
        R.DiasLiquidacion := Dias;
        tInteres := (Valor * (TasaN/100))/360 * Dias;
        tInteres := SimpleRoundTo(tInteres,0);
        Dias := Dias - DiasC;
//        R.Interes := (Valor * (TasaN/100))/360 * Dias;
        R.Causado := (Valor * (TasaN/100))/360 * DiasC;
//        R.Interes := SimpleRoundTo(R.Interes,0);
        R.Causado := SimpleRoundTo(R.Causado,0);
        R.Interes := tInteres - R.Causado;
        Total := R.Interes + R.Causado;
        if tInteres >= (DiarioRetefuente * Amor) then
        begin
           R.ReteInteres := R.Interes * ( TasaRetefuente / 100);
           R.ReteInteres := SimpleRoundTo(R.ReteInteres,0);
           R.ReteCausado := R.Causado * ( TasaRetefuente / 100);
           R.ReteCausado := SimpleRoundTo(R.ReteCausado,0);
           R.Retencion := R.ReteInteres + R.ReteCausado;
        end
        else
        begin
           R.ReteInteres := 0;
           R.ReteCausado := 0;
           R.Retencion := 0;
        end;
        
        R.SaldoAFecha := Valor;
        R.SaldoLiquidacion := Valor;
        R.TasaLiquidacion := TasaN;

        Result := R;
end;

end.
