unit UnitGlobales;

interface

uses DateUtils,SysUtils,Controls,IB,IBQuery,Classes,Math,IBSQL,IBDatabase,forms,Dialogs,
      IBStoredProc, StrUtils;

type
     PFechasLiq = ^AFechasLiq;
     AFechasLiq = record
       FechaInicial :TDate;
       FechaFinal   :TDate;
       Anticipado   :Boolean;
       Causado      :Boolean;
       Corrientes   :Boolean;
       Vencida      :Boolean;
       Devuelto     :Boolean;
     end;

function fFechaActual(Database:TIBDatabase): TDate;
function  DiasEntre(FechaInicial:TDate;FechaFinal:TDate):Integer;
function BuscoTasaEfectivaMaximaNueva(IBQuery1:TIBQuery;Fecha:TDate):Double;
procedure CalcularFechasLiquidarFija(FechaInicial:TDate;FechaCorte:TDate;FechaProx:TDate;var FechasLiq:TList);
function BuscoTasaEfectivaUvrNueva(IBQuery1:TIBQuery;Fecha:TDate):Double;
procedure CalcularFechasLiquidarVarAnticipada(FechaInicial:TDate;FechaCorte:TDate;FechaProx:TDate;var FechasLiq:TList);
procedure CalcularFechasLiquidarVarVencida(FechaInicial:TDate;FechaCorte:TDate;FechaProx:TDate;var FechasLiq:TList);
function TasaNominalVencida(TasaE:Single;Amortiza:Integer): Single;
function TasaNominalAnticipada(TasaE:Single;Amortiza:Integer): Single;
function BuscoTasaEfectivaMaximaDtfNueva(IBQuery1:TIBQuery;Fecha:TDate):Double;
function BuscoTasaEfectivaMaximaIPCNueva(IBQuery1:TIBQuery):Double;
function CalculoFecha(FechaActual:TDate;Dias:Integer):TDate;
function  DiasEntreFechas(FechaInicial:TDate;FechaFinal:TDate;FechaCorte:TDate;Bisiesto:Boolean):Integer;
function ObtenerConsecutivo(IBSQL1:TIBSQL): Longint;
function ObtenerCaptacion(TipoCaptacion:Integer;IBSQL1: TIBSQL): Longint;
function DigitoControl(Tipo:Integer;Cuenta: string): string;

var
  Ruta:string;
  DataBase:string;
  UserName:string;
  PassWord:string;
  Sql_Role:string;
  DBAlias:string;

implementation

function DigitoControl(Tipo:Integer;Cuenta: string): string;
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

function fFechaActual(Database:TIBDatabase): TDate;
var IBSP1:TIBStoredProc;
    IBT1:TIBTransaction;
begin
        IBT1 := TIBTransaction.Create(Application);
        IBSP1 := TIBStoredProc.Create(Application);
        IBT1.DefaultDatabase := Database;
        IBSP1.Transaction := IBT1;
        IBSP1.StoredProcName := 'SP_FECHA_ACTUAL';
        with IBSP1 do begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          Close;
          try
           ExecProc;
          finally
           Result := parambyname('FECHA').AsDate;
          end;
          Close;
          Transaction.Commit;
        end;
        IBSP1.Destroy;
        IBT1.Destroy;
end;

function  DiasEntre(FechaInicial:TDate;FechaFinal:TDate):Integer;
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

function BuscoTasaEfectivaMaximaNueva(IBQuery1:TIBQuery;Fecha:TDate):Double;
begin
        with IBQuery1 do
        begin
                SQL.Clear;
                SQL.Add('select VALOR_TASA_EFECTIVA from ');
                SQL.Add(' "col$tasafijas" where (:"FECHA" between FECHA_INICIAL and FECHA_FINAL)');
                ParamByName('FECHA').AsDate := Fecha;
                Open;
                if RecordCount = 0 then
                begin
                        SQL.Clear;
                        SQL.Add('select VALOR_TASA_EFECTIVA from ');
                        SQL.Add(' "col$tasafijas" ');
                        try
                          Open;
                          Last;
                          Result := FieldByName('VALOR_TASA_EFECTIVA').AsFloat;
                          Close;
                        except
                           Close;
                           Result := 99.999;
                           Exit;
                        end;
                end
                else
                begin
                 Result := FieldByName('VALOR_TASA_EFECTIVA').AsFloat;
                 Close;
                end;
        end;
end;

procedure CalcularFechasLiquidarFija(FechaInicial:TDate;FechaCorte:TDate;FechaProx:TDate;var FechasLiq:TList);
var FechaF1,FechaF2,FechaF3,FechaF4:TDate;
    Fecha,FechaA,FechaB:TDate;
    AF:PFechasLiq;
    Paso : Boolean;
    A,AA,M,MM,D,DD:Word;
begin
    FechaF1 := FechaInicial;
    FechaF2 := FechaCorte;

    FechaF3 := FechaProx;
    FechaF4 := Date;
    Paso := False;

    // Inicio While 1
    While Int(FechaF1) <= Int(FechaF3) do
     begin
       New(AF);
       AF^.Anticipado := False;
       AF^.Causado := False;
       AF^.Corrientes := False;
       AF^.Vencida := False;
       AF^.Devuelto := False;
       Fecha := FechaF1;
       Fecha := RecodeDay(FechaF1,Dayof(EndOfAMonth(YearOf(Fecha),MonthOf(Fecha))));
       if Int(Fecha) > Int(FechaF3) then
          Fecha := FechaF3;
       if (Int(Fecha) > Int(FechaF4)) and (Paso = False) and (Int(FechaF1) < Int(FechaF4)) then
//       if (Int(Fecha) > Int(FechaF2)) and (Paso = False) and (Int(FechaF1) < Int(FechaF2)) then
//       if (Int(Fecha) > Int(FechaF2)) and (FechaF2 > FechaF3) and (Paso = False) then
        begin
//          Fecha := FechaF2;
          Fecha := FechaF4;
          Paso := True;
        end;
       AF^.FechaInicial := FechaF1;
       AF^.FechaFinal := Fecha;
       DecodeDate(AF^.FechaInicial,A,M,D);
       DecodeDate(AF^.FechaFinal,AA,MM,DD);
       FechaA := RecodeDay(Fecha,01);
//       FechaB := RecodeDay(FechaF2,01);
       FechaB := RecodeDay(FechaF4,01);

       if (Fecha <= FechaF4) and (FechaA = FechaB) then
        begin
          AF^.Anticipado := False;
          AF^.Causado := False;
          AF^.Corrientes := True;
          AF^.Vencida := False;
          AF^.Devuelto := False;
        end
       else if (Fecha <= FechaF4) then
        begin
          AF^.Anticipado := False;
          AF^.Causado := True;
          AF^.Corrientes := False;
          AF^.Vencida := False;
          AF^.Devuelto := False;
        end
       else
        begin
          AF^.Anticipado := True;
          AF^.Causado := False;
          AF^.Corrientes := False;
          AF^.Vencida := False;
          AF^.Devuelto := False;
        end;

       FechaF1 := Fecha;
       if not ((M=MM) and (D=31) and (DD=31)) then
         FechasLiq.Add(AF);
       FechaF1 := IncDay(Fecha);
     end;  // fin del While 1
end;

function BuscoTasaEfectivaUvrNueva(IBQuery1:TIBQuery;Fecha:TDate):Double;
begin
        with IBQuery1 do
        begin
                SQL.Clear;
                SQL.Add('select VALOR_TASA_EFECTIVA from ');
                SQL.Add(' "col$tasauvr" where (:"FECHA" between FECHA_INICIAL and FECHA_FINAL)');
                ParamByName('FECHA').AsDate := Fecha;
                Open;
                if RecordCount = 0 then
                begin
                        SQL.Clear;
                        SQL.Add('select VALOR_TASA_EFECTIVA from ');
                        SQL.Add('"col$tasauvr" order by FECHA_INICIAL ASC ');
                        try
                          Open;
                          Last;
                          Result := FieldByName('VALOR_TASA_EFECTIVA').AsFloat;
                          Close;
                        except
                           Close;
                           Result := 99.999;
                           Exit;
                        end;
                end
                else
                begin
                 Result := FieldByName('VALOR_TASA_EFECTIVA').AsFloat;
                 Close;
                end;
        end;
end;

procedure CalcularFechasLiquidarVarAnticipada(FechaInicial:TDate;FechaCorte:TDate;FechaProx:TDate;var FechasLiq:TList);
var FechaF1,FechaF2,FechaF3,FechaF4:TDate;
    Fecha,FechaA,FechaB:TDate;
    AF:PFechasLiq;
    A,AA,M,MM,D,DD:Word;
    Paso : Boolean;
begin
    FechaF1 := FechaInicial;
    FechaF2 := FechaCorte;
    FechaF3 := FechaProx;
    FechaF4 := Date;
    Paso := False;

    // Inicio While 1
    While Int(FechaF1) <= Int(FechaF3) do
     begin
       New(AF);
       AF^.Anticipado := False;
       AF^.Causado := False;
       AF^.Corrientes := False;
       AF^.Vencida := False;
       AF^.Devuelto := False;
       Fecha := FechaF1;
       Fecha := RecodeDay(FechaF1,Dayof(EndOfAMonth(YearOf(Fecha),MonthOf(Fecha))));
       if Int(Fecha) > Int(FechaF3) then
//        begin
          Fecha := FechaF3;
          if (Int(Fecha) > Int(FechaF4)) and (Paso = False) and (Int(FechaF1) < Int(FechaF4)) then
           begin
             Fecha := FechaF4;
             Paso := True;
           end;
  //      end;

       AF^.FechaInicial := FechaF1;
       AF^.FechaFinal := Fecha;
       DecodeDate(AF^.FechaInicial,A,M,D);
       DecodeDate(AF^.FechaFinal,AA,MM,DD);
       FechaA := RecodeDay(Fecha,01);
       FechaB := RecodeDay(FechaF4,01);

       if (Fecha <= FechaF4) and (FechaA = FechaB) then
        begin
          AF^.Anticipado := False;
          AF^.Causado := False;
          AF^.Corrientes := True;
          AF^.Vencida := False;
          AF^.Devuelto := False;
        end
       else
        if Fecha <= FechaF4 then
         begin
           AF^.Anticipado := False;
           AF^.Causado := True;
           AF^.Corrientes := False;
           AF^.Vencida := False;
           AF^.Devuelto := False;
         end
        else
         begin
           AF^.Anticipado := True;
           AF^.Causado := False;
           AF^.Corrientes := False;
           AF^.Vencida := False;
           AF^.Devuelto := False;
         end;

       FechaF1 := Fecha;
       if not ((M=MM) and (D=31) and (DD=31)) then
         FechasLiq.Add(AF);
       FechaF1 := IncDay(Fecha);
     end;  // fin del While 1

end;

procedure CalcularFechasLiquidarVarVencida(FechaInicial:TDate;FechaCorte:TDate;FechaProx:TDate;var FechasLiq:TList);
var FechaF1,FechaF2,FechaF3,FechaF4:TDate;
    Fecha,FechaA,FechaB:TDate;
    AF:PFechasLiq;
    Paso : Boolean;
    A,AA,M,MM,D,DD:Word;
begin
    FechaF1 := FechaInicial;
    FechaF2 := FechaCorte;
    FechaF3 := FechaProx;
    FechaF4 := Date;
    Paso := False;

    // Inicio While 1
    While Int(FechaF1) <= Int(FechaF3) do
     begin
       New(AF);
       AF^.Anticipado := False;
       AF^.Causado := False;
       AF^.Corrientes := False;
       AF^.Vencida := False;
       AF^.Devuelto := False;
       Fecha := FechaF1;
       Fecha := RecodeDay(FechaF1,Dayof(EndOfAMonth(YearOf(Fecha),MonthOf(Fecha))));
       if Int(Fecha) > Int(FechaF3) then
          Fecha := FechaF3;
       if (Int(Fecha) > Int(FechaF4)) and (Paso = False) and (Int(FechaF1) < Int(FechaF4)) then
        begin
          Fecha := FechaF1; //FechaF2;
          Paso := True;
        end;
       AF^.FechaInicial := FechaF1;
       AF^.FechaFinal := Fecha;
       DecodeDate(AF^.FechaInicial,A,M,D);
       DecodeDate(AF^.FechaFinal,AA,MM,DD);
       FechaA := RecodeDay(Fecha,01);
       FechaB := RecodeDay(FechaF4,01);

       if (Fecha <= FechaF4) and (FechaA = FechaB) then
        begin
          AF^.Anticipado := False;
          AF^.Causado := False;
          AF^.Corrientes := True;
          AF^.Vencida := False;
          AF^.Devuelto := False;
        end
       else if Fecha <= FechaF4 then
        begin
          AF^.Anticipado := False;
          AF^.Causado := True;
          AF^.Corrientes := False;
          AF^.Vencida := False;
          AF^.Devuelto := False;
        end
       else
        begin
          AF^.Anticipado := True;
          AF^.Causado := False;
          AF^.Corrientes := False;
          AF^.Vencida := False;
          AF^.Devuelto := False;
        end;

       FechaF1 := Fecha;
       if not ((M=MM) and (D=31) and (DD=31)) then
         FechasLiq.Add(AF);
       FechaF1 := IncDay(Fecha);
     end;  // fin del While 1
end;

function TasaNominalVencida(TasaE:Single;Amortiza:Integer): Single;
var Potencia:Single;
    Factor:Double;
begin
        if Amortiza < 30 then Amortiza := 30;
        Factor := Amortiza / 30;
        Factor := 12 / Factor;
        Potencia := power(1+(TasaE/100),(1/Factor));
        Potencia := ((Potencia-1)*Factor*100);
        Result := SimpleRoundTo(Potencia,-2);
end;

function TasaNominalAnticipada(TasaE:Single;Amortiza:Integer): Single;
var Potencia:Single;
    Factor:Double;
begin
        if Amortiza < 30 then Amortiza := 30;
        Factor := Amortiza / 30;
        Factor := 12 / Factor;
        Potencia := power(1+(TasaE/100),-(1/Factor));
        Potencia := Abs(((Potencia-1)* Factor*100));
        Result := RoundTo(Potencia,-2);
end;

function BuscoTasaEfectivaMaximaDtfNueva(IBQuery1:TIBQuery;Fecha:TDate):Double;
begin
        with IBQuery1 do
        begin
                SQL.Clear;
                SQL.Add('select VALOR_TASA_EFECTIVA from ');
                SQL.Add(' "col$tasadtf" ');
                SQL.Add('where (:"FECHA" between FECHA_INICIAL and FECHA_FINAL)');
                ParamByName('FECHA').AsDate := Fecha;
                Open;
                if RecordCount = 0 then
                begin
                        SQL.Clear;
                        SQL.Add('select VALOR_TASA_EFECTIVA from ');
                        SQL.Add(' "col$tasadtf" ');
                        try
                          Open;
                          Last;
                          Result := FieldByName('VALOR_TASA_EFECTIVA').AsFloat;
                          Close;
                        except
                           Close;
                           Result := 99.999;
                           Exit;
                        end;
                end
                else
                begin
                 Result := FieldByName('VALOR_TASA_EFECTIVA').AsFloat;
                 Close;
                end;
        end;
end;

function BuscoTasaEfectivaMaximaIPCNueva(IBQuery1:TIBQuery):Double;
begin
        with IBQuery1 do
        begin
                SQL.Clear;
                SQL.Add('select VALOR_ACTUAL_TASA from ');
                SQL.Add(' "col$tasasvariables" ');
                SQL.Add('Where ID_INTERES = 2');
                Open;
                Result := FieldByName('VALOR_ACTUAL_TASA').AsFloat;
                Close;
        end;
end;

function CalculoFecha(FechaActual:TDate;Dias:Integer):TDate;
var Mes: Integer;
    Ano: Integer;
    Dia: Integer;
    I: Integer;
    FinMes:Boolean;
begin


     Dia := DayOf(FechaActual);
     Mes := MonthOf(FechaActual);
     Ano := YearOf(FechaActual);

     if Dia = DaysInMonth(FechaActual) then
        FinMes := True
     else
        FinMes := False;

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

//         if FinMes then
//           Dia := DayOf(EndOfAMonth(Ano,Mes));

//        Result := FechaActual;
        Result := EncodeDate(Ano,Mes,Dia);

end;

function  DiasEntreFechas(FechaInicial:TDate;FechaFinal:TDate;FechaCorte:TDate;Bisiesto:Boolean):Integer;
var A,AA,M,MM,D,DD,AAA,DDD,MMM,AAAA,MMMM,DDDD,B:Word;
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
        B := D;
        DecodeDate(FechaFinal,AA,MM,DD);
        DecodeDate(FechaCorte,AAA,MMM,DDD);
        FechaInicial := EncodeDate(A,M,D);
        FechaFinal := EncodeDate(AA,MM,DD);
        FechaCorte := EncodeDate(AAA,MMM,DDD);

        if Negativo = True then
          if (M=2) and ((D=28) or (D=29)) then
            D := 30;

        if (MM=2) and ((DD=28) or (DD=29)) then
            DD := 30;

        if DD = 31 then DD := 30;
        if D = 31 then D := 30;

        while (D <> DD) and (M <= MM) and (A <= AA) do
        begin
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

       DDDD := Dayof(EndOfAMonth(YearOf(Date),02));
       if ((DDDD=29) and(M=3) and (B=1)) and (Bisiesto) then
          if (DDD=29) then Dias := Dias + 1
          else if (DDD=28) then Dias := Dias + 2;

        if Negativo then
           Result := -(Dias)
        else
           Result := Dias;
end;

function ObtenerCaptacion(TipoCaptacion:Integer;IBSQL1: TIBSQL): LongInt;
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
          Close;
          SQL.Clear;
          SQL.Add('select CONSECUTIVO from "cap$tipocaptacion" where ');
          SQL.Add(' ID_TIPO_CAPTACION = :"ID" ');
          ParamByName('ID').AsInteger := TipoCaptacion;
          ExecQuery;
          Consecutivo := FieldByName('CONSECUTIVO').AsInteger;
          Close;
          Consecutivo := Consecutivo + 1;
          SQL.Clear;
          SQL.Add('UPDATE "cap$tipocaptacion" ');
          SQL.Add('SET CONSECUTIVO = :CONSECUTIVO where ');
          SQL.Add('ID_TIPO_CAPTACION = :ID');
          ParamByName('CONSECUTIVO').AsInteger := Consecutivo;
          ParamByName('ID').AsInteger := TipoCaptacion;
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


function ObtenerConsecutivo(IBSQL1:TIBSQL): LongInt;
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
            RecordLocked := False;
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

end.
