unit UnitRevalorizacionAportes;

interface

uses
  Windows, Messages, DateUtils, StrUtils, Math, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, JvEdit, JvFloatEdit, IBSQL, DB,
  IBCustomDataSet, IBQuery, JvTypedEdit, DBClient, Provider, ComCtrls,
  pr_Common, pr_TxClasses, pr_Parser;

type TPromedio = Record
   Sumatoria:Currency;
   Dias:Integer;
end;

type TMovimiento = Record
   Debito:Currency;
   Credito:Currency;
end;

type
  TfrmRevalorizacionAportes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CmdRevalorizar: TBitBtn;
    CmdInforme: TBitBtn;
    CmdAplicar: TBitBtn;
    CmdCerrar: TBitBtn;
    Label1: TLabel;
    RGproceso: TRadioGroup;
    Label2: TLabel;
    EdTasa: TJvFloatEdit;
    IBSQL1: TIBSQL;
    IBQuery1: TIBQuery;
    EdYear: TJvYearEdit;
    MData: TClientDataSet;
    MDataFECHA: TStringField;
    MDataSALDO: TCurrencyField;
    MDataDEBITO: TCurrencyField;
    MDataCREDITO: TCurrencyField;
    Label3: TLabel;
    EdFechaAplicar: TDateTimePicker;
    IBQuery2: TIBQuery;
    IBPagar: TIBSQL;
    IBSQL2: TIBSQL;
    IBQuery5: TIBQuery;
    Reporte: TprTxReport;
    Label4: TLabel;
    EdCbte: TJvIntegerEdit;
    MFecha: TClientDataSet;
    MFechaFECHA: TDateField;
    MFechaDEBITO: TCurrencyField;
    MFechaCREDITO: TCurrencyField;
    MSaldos: TClientDataSet;
    MSaldosSALDO: TCurrencyField;
    MSaldosDIAS: TIntegerField;
    procedure EdYearKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure CmdRevalorizarClick(Sender: TObject);
    procedure CmdCerrarClick(Sender: TObject);
    procedure CmdAplicarClick(Sender: TObject);
    procedure ReporteUnknownVariable(Sender: TObject;
      const VarName: String; var Value: TprVarValue;
      var IsProcessed: Boolean);
    procedure CmdInformeClick(Sender: TObject);
  private
    function Promedio: TPromedio;
    procedure CreoDias;
    function BuscoMovimiento(Fecha: TDate): TMovimiento;
    procedure CompletoDias;
    procedure CreoSaldos;
    { Private declarations }
  public
    { Public declarations }
  end;

type TFecha = Record
   ano:Integer;
   mes:Integer;
   dia:Integer;
end;




var
  frmRevalorizacionAportes: TfrmRevalorizacionAportes;
  FechaInicial,FechaFinal:TDate;
  SaldoI,SaldoF:Currency;
  Ag:Integer;
  Tp:Integer;
  Ct:Integer;
  Dg:Integer;
  FechaPrimerMov,FechaUltimoMov:TDate;
  Suma:Currency;
  DiasSuma:Integer;

implementation

{$R *.dfm}

uses unitGlobales,UnitdmGeneral, UnitPantallaProgreso, UnitVistaPreliminar;

procedure TfrmRevalorizacionAportes.EdYearKeyPress(Sender: TObject; var Key: Char);
begin
        NumericoSinPunto(Sender,Key);
end;

procedure TfrmRevalorizacionAportes.FormKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmRevalorizacionAportes.FormShow(Sender: TObject);
begin
        EdYear.Text := IntToStr(Yearof(Date)-1);
        EdFechaAplicar.Date := Date;
end;

procedure TfrmRevalorizacionAportes.CmdRevalorizarClick(Sender: TObject);
var Total:Integer;
    frmProgreso:TfrmProgreso;
    Datos:TPromedio;
    SePaga:Boolean;
    MesCanc:Integer;
begin
        if EdYear.Text = '' then
          begin
            MessageDlg('Debe Seleccionar un año',mtError,[mbcancel],0);
            Exit;
          end;

        if EdYear.Text = '' then
          begin
            MessageDlg('Debe Seleccionar un año',mtError,[mbcancel],0);
            Exit;
          end;

        FechaInicial := EncodeDate(StrtoInt(Edyear.Text),01,01);
        FechaFinal := EncodeDate(StrtoInt(Edyear.Text),12,31);

        with IBSQL1 do begin
           if Transaction.InTransaction then
              Transaction.Rollback;
           Transaction.StartTransaction;
           Close;
           SQL.Clear;
           SQL.Add('delete from "cap$revalorizaciontmp"');
           try
            ExecQuery;
           except
            Transaction.Rollback;
            raise;
            Exit;
           end;
        end;

        with IBQuery1 do begin
           Close;
           SQL.Clear;
           SQL.Add('select Count(*) as Total from "cap$maestro" Where ID_TIPO_CAPTACION = 1 and NUMERO_CUENTA >= :NUMERO');
           ParamByName('NUMERO').AsInteger := 0;
           try
             Open;
             Total := FieldByName('Total').AsInteger;
           except
             Transaction.Rollback;
             raise;
             Exit;
           end;
        end;

        with IBQuery1 do begin
          Close;
          SQL.Clear;
          SQL.Add('select * from "cap$maestro" Where ID_TIPO_CAPTACION = 1 and NUMERO_CUENTA >= :NUMERO');
          SQL.Add('Order by ID_AGENCIA,ID_TIPO_CAPTACION,NUMERO_CUENTA,DIGITO_CUENTA');
          ParamByName('NUMERO').AsInteger := 0;
          try
           Open;
          except
           Transaction.Rollback;
           raise;
           Exit;
          end; // try
          frmProgreso := TfrmProgreso.Create(Self);
          frmProgreso.Min := 0;
          frmProgreso.Max := Total;
          frmProgreso.Position := 0;
          frmProgreso.InfoLabel := 'Procesando Aportes';
          frmProgreso.Ejecutar;
          Application.ProcessMessages;
          while not Eof do begin
            frmProgreso.Position := RecNo;
            frmProgreso.InfoLabel := 'Procesando Aportes:' + Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger]);
            Application.ProcessMessages;
            Ag := FieldByName('ID_AGENCIA').AsInteger;
            Tp := FieldByName('ID_TIPO_CAPTACION').AsInteger;
            Ct := FieldByName('NUMERO_CUENTA').AsInteger;
            Dg := FieldByName('DIGITO_CUENTA').AsInteger;

            IBSQL1.Close;
            IBSQL1.SQL.Clear;
            IBSQL1.SQL.Add('Select SALDO_INICIAL from "cap$maestrosaldoinicial" where');
            IBSQL1.SQL.Add('ID_AGENCIA = :ID_AGENCIA and ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
            IBSQL1.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and DIGITO_CUENTA = :DIGITO_CUENTA and');
            IBSQL1.SQL.Add('ANO = :ANO');
            IBSQL1.ParamByName('ID_AGENCIA').AsInteger        := Ag;
            IBSQL1.ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
            IBSQL1.ParamByName('NUMERO_CUENTA').AsInteger     := Ct;
            IBSQL1.ParamByName('DIGITO_CUENTA').AsInteger     := Dg;
            IBSQL1.ParamByName('ANO').AsString                := EdYear.Text;
            try
             IBSQL1.ExecQuery;
             if IBSQL1.RecordCount < 1 then
                SaldoI := 0
             else
                SaldoI := IBSQL1.FieldByName('SALDO_INICIAL').AsCurrency;
            except
             SaldoI := 0;
            end;// try
            IBSQL1.Close;
            IBSQL1.ParamByName('ID_AGENCIA').AsInteger        := Ag;
            IBSQL1.ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
            IBSQL1.ParamByName('NUMERO_CUENTA').AsInteger     := Ct;
            IBSQL1.ParamByName('DIGITO_CUENTA').AsInteger     := Dg;
            IBSQL1.ParamByName('ANO').AsString                := IntToStr(StrToInt(EdYear.Text)+1);;
            try
             IBSQL1.ExecQuery;
             if IBSQL1.RecordCount < 1 then
                SaldoF := 0
             else
                SaldoF := IBSQL1.FieldByName('SALDO_INICIAL').AsCurrency;
            except
             SaldoF := 0;
            end;// try

//            if SaldoI = 0 then begin
//               Next;
//               Continue;
//            end;// if

            if SaldoF = 0 then SePaga := False
            else
             SePaga := True;

            Datos := Promedio;

            if not SePaga then
               MesCanc := Monthof(FechaUltimoMov)
            else
               MesCanc := 0;

            if Datos.Dias > 0 then begin

            IBSQL1.Close;
            IBSQL1.SQL.Clear;
            IBSQL1.SQL.Add('insert into "cap$revalorizaciontmp" values(');
            IBSQL1.SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
            IBSQL1.SQL.Add(':ANO,:PROMEDIO,:TASA,:MES_CANCELO,:SE_PAGA,:DIAS,:REVALORIZACION,');
            IBSQL1.SQL.Add(':ESTADO,:VALOR_AJUSTADO,:ESTADO_AJUSTE,:PAGADO)');
            IBSQL1.ParamByName('ID_AGENCIA').AsInteger := Ag;
            IBSQL1.ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
            IBSQL1.ParamByName('NUMERO_CUENTA').AsInteger := Ct;
            IBSQL1.ParamByName('DIGITO_CUENTA').AsInteger := Dg;
            IBSQL1.ParamByName('ANO').AsInteger := EdYear.Value;
            IBSQL1.ParamByName('PROMEDIO').AsCurrency := SimpleRoundTo(Datos.Sumatoria / Datos.Dias,0);
            IBSQL1.ParamByName('TASA').AsFloat := EdTasa.Value;
            IBSQL1.ParamByName('MES_CANCELO').AsInteger := MesCanc;
            IBSQL1.ParamByName('SE_PAGA').AsInteger := BooleanoToInt(SePaga);
            IBSQL1.ParamByName('DIAS').AsInteger := Datos.Dias;
            IBSQL1.ParamByName('REVALORIZACION').AsCurrency := SimpleRoundTo(SimpleRoundTo(Datos.Sumatoria / Datos.Dias,0) * (EdTasa.Value/36000) * Datos.Dias,0);
            IBSQL1.ParamByName('ESTADO').AsString := 'A';
            IBSQL1.ParamByName('VALOR_AJUSTADO').AsCurrency := 0;
            IBSQL1.ParamByName('ESTADO_AJUSTE').AsString := '';
            IBSQL1.ParamByName('PAGADO').AsInteger := BooleanoToInt(False);
            try
              IBSQL1.ExecQuery;
            except
               Transaction.Rollback;
               frmProgreso.Cerrar;
              raise;
            end;
           end;
          Transaction.CommitRetaining;
          Next;
         end; // while
         Transaction.Commit;
        end; // with

        if RGproceso.ItemIndex = 1 then
          CmdAplicar.Enabled := True;

        CmdInforme.Enabled := True;
end;

function TfrmRevalorizacionAportes.Promedio: TPromedio;
var Dias:Integer;
    Sumatoria:Currency;
    Fecha:TDateTime;
    Ano,Mes,Dia:Word;
begin

   FechaInicial := EncodeDate(EdYear.Value,01,01);
   FechaFinal := EncodeDate(EdYear.Value,12,30);

   FechaPrimerMov := StrtoDate('1899/12/30');
   FechaUltimoMov := StrtoDate('1899/12/30');

   with IBSQL1 do begin
     Close;
     SQL.Clear;
     SQL.Add('select * from P_CAP_0012(:ID,:TP,:CTA,:DG,:ANO)');
     ParamByName('ID').AsInteger  := Ag;
     ParamByName('TP').AsInteger  := Tp;
     ParamByName('CTA').AsInteger := Ct;
     ParamByName('DG').AsInteger  := Dg;
     ParamByName('ANO').AsString  := IntToStr(EdYear.Value);
     try
      ExecQuery;
      if RecordCount > 0 then
         if FieldByName('SALDOAHORROS').AsCurrency <> 0 then
           FechaPrimerMov := FechaInicial;
     except
       Transaction.Rollback;
       frmProgreso.Cerrar;
      raise;
     end;
   end;

   MFecha.DisableControls;
   try
    MFecha.Open;
    MFecha.EmptyDataSet;
   except
    raise;
   end;

   with IBQuery2 do begin
     Close;
     SQL.Clear;
     SQL.Add('select * from "cap$extracto" where');
     SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
     SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
     SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and');
     SQL.Add('DIGITO_CUENTA = :DIGITO_CUENTA and');
     SQL.Add('FECHA_MOVIMIENTO BETWEEN :FECHA1 and :FECHA2');
     SQL.Add('ORDER BY FECHA_MOVIMIENTO ASC');
     ParamByName('ID_AGENCIA').AsInteger := Ag;
     ParamByName('ID_TIPO_CAPTACION').AsInteger :=Tp;
     ParamByName('NUMERO_CUENTA').AsInteger := Ct;
     ParamByName('DIGITO_CUENTA').AsInteger := Dg;
     ParamByName('FECHA1').AsDate := FechaInicial;
     ParamByName('FECHA2').AsDate := FechaFinal;
     try
       Open;
       First;
       if RecordCount > 0 then
         begin
// Marcar Fecha Primer Movimiento
           if FechaPrimerMov = StrtoDate('1899/12/30') then
            FechaPrimerMov := FieldByName('FECHA_MOVIMIENTO').AsDateTime;

           while not Eof do
           begin
               Fecha := FieldByName('FECHA_MOVIMIENTO').AsDateTime;
               DecodeDate(Fecha,Ano,Mes,Dia);
               if Dia = 31 then
                  Dia := 30;
               Fecha := EncodeDate(Ano,Mes,Dia);
               if MFecha.Locate('FECHA',VarArrayOf([Fecha]),[loCaseInsensitive]) then
               begin
                  MFecha.Edit;
                  MFecha.FieldByName('DEBITO').AsCurrency := MFecha.FieldByName('DEBITO').AsCurrency + FieldByName('VALOR_DEBITO').AsCurrency;
                  MFecha.FieldByName('CREDITO').AsCurrency := MFecha.FieldByName('CREDITO').AsCurrency + FieldByName('VALOR_CREDITO').AsCurrency;
                  MFecha.Post;
               end
               else
                  MFecha.AppendRecord([Fecha,FieldByName('VALOR_DEBITO').AsCurrency,FieldByName('VALOR_CREDITO').AsCurrency]);
               Next;
           end;
// Buscar Fecha Ultimo Movimiento
           FechaUltimoMov := FieldByName('FECHA_MOVIMIENTO').AsDateTime;
         end;
     except
       Transaction.Rollback;
       frmProgreso.Cerrar;
       raise;
     end;
    end;


    if FechaPrimerMov = StrtoDate('1899/12/30') then
       FechaPrimerMov := FechaInicial;
    if FechaUltimoMov = StrtoDate('1899/12/30') then
       FechaUltimoMov := FechaFinal;


    if SaldoF > 0 then
         FechaUltimoMov := FechaFinal;

    

    {CreoDias;}
    CreoSaldos;
//    CompletoDias;

    Sumatoria := Suma;
    Dias := DiasSuma;

{    with MData do begin
      Open;
      First;
      while not Eof do begin
          Sumatoria := Sumatoria + FieldByName('SALDO').AsCurrency;
          Dias := Dias + 1;
          Next;
      end;
      Dias := Dias - 1;
    end;
}

    Result.Sumatoria := Sumatoria;
    Result.Dias := Dias;


end;


procedure TfrmRevalorizacionAportes.CreoDias;
var Fecha:TDate;
    Year:Integer;
    Month:Integer;
    Day:Integer;
    Fecha1,Fecha2:TFecha;
    FechaDia:TDate;
    FechaTmp:TDateTime;
    Movimientos:TMovimiento;
    Dia,Mes,Ano:Integer;
    Saldo:Currency;
begin

        MData.DisableControls;
        try
         MData.Open;
         MData.EmptyDataSet;
         with MData do begin
           Year := EdYear.Value;
           Month := 0;
           Day := 0;
           AppendRecord([Format('%.4d%.2d%.2d',[year,month,day]),SaldoI,0,0]);
         end;

         Suma := 0;
         DiasSuma := 0;

         Saldo := SaldoI;

         Fecha := FechaPrimerMov;
         Year  := YearOf(Fecha);
         Month := MonthOf(Fecha);
         Day   := DayOf(Fecha);

         while True do begin

         if not TryEncodeDate(Year,Month,Day,FechaTmp) then
            Day := 30;

          Ano := Year;
          Mes := Month;
          Dia := Day;
          if (Month = 2) and
             (Day > 28) then
             Dia := DaysInAMonth(Year,Month);
          FechaDia := EncodeDate(Ano,Mes,Dia);

          with MData do begin
            Movimientos := BuscoMovimiento(FechaDia);
            Saldo := Saldo + Movimientos.Debito - Movimientos.Credito;
            if Day = 31 then
              Day := 30
            else
              DiasSuma := DiasSuma + 1;

            AppendRecord([Format('%.4d%.2d%.2d',[year,month,day]),movimientos.debito,movimientos.credito,Saldo]);
            Suma := Suma + Saldo;
//            DiasSuma := DiasSuma + 1;
          end;

         Day := Day + 1;
         if Day > 31 then begin
           Day := 1;
           Month := Month + 1;
           if Month > 12 then begin
             Month := 1;
             Year := Year + 1;
           end;
         end;

         Fecha1.ano := Year;
         Fecha1.mes := Month;
         Fecha1.dia := Day;

         Fecha2.ano := YearOf(FechaUltimoMov);
         Fecha2.mes := MonthOf(FechaUltimoMov);
         Fecha2.dia := DayOf(FechaUltimoMov);

         if (Fecha1.ano * 360 + Fecha1.mes * 30 + Fecha1.dia) >
            (Fecha2.ano * 360 + Fecha2.mes * 30 + Fecha2.dia) then
            begin
             MData.Close;
             Break;
            end;
        end;
        except
          frmProgreso.Cerrar;
          raise;
        end;



end;

procedure TfrmRevalorizacionAportes.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;


function TfrmRevalorizacionAportes.BuscoMovimiento(
  Fecha: TDate): TMovimiento;
begin
        with IBSQL1 do begin
           Close;
           SQL.Clear;
           SQL.Add('select * from "cap$extracto" where ');
           SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
           SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
           SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and');
           SQL.Add('DIGITO_CUENTA = :DIGITO_CUENTA and');
           SQL.Add('FECHA_MOVIMIENTO = :FECHA');
           ParamByName('ID_AGENCIA').AsInteger := Ag;
           ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
           ParamByName('NUMERO_CUENTA').AsInteger := Ct;
           ParamByName('DIGITO_CUENTA').AsInteger := Dg;
           ParamByName('FECHA').AsDate := Fecha;
           try
            ExecQuery;
            if RecordCount > 0 then begin
               Result.Debito := FieldByName('VALOR_DEBITO').AsCurrency;
               Result.Credito := FieldByName('VALOR_CREDITO').AsCurrency;
            end
            else
             begin
               Result.Debito := 0;
               Result.Credito := 0;
             end;
           except
             frmProgreso.Cerrar;
             Transaction.Rollback;
             raise;
           end;
        end;

end;

procedure TfrmRevalorizacionAportes.CompletoDias;
var Saldo:Currency;
begin
        with MData do begin
          Open;
          Saldo := 0;
          while not Eof do begin
             Saldo := Saldo + FieldByName('DEBITO').AsCurrency + FieldByName('CREDITO').AsCurrency;
             Edit;
             FieldByName('SALDO').AsCurrency := Saldo;
             Post;
             Next;
          end;
        end;
            
end;

procedure TfrmRevalorizacionAportes.CmdAplicarClick(Sender: TObject);
var  frmProgreso:TfrmProgreso;
     Total:Integer;
     Digito:Integer;
begin
        with IBQuery1 do begin
          if Transaction.InTransaction then
             Transaction.Rollback;
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('select count(*) as TOTAL from "cap$revalorizaciontmp"');
          Open;
          Total := FieldByName('TOTAL').AsInteger;
          Close;
        end;

        with IBQuery1 do begin
          Close;
          SQL.Clear;
          SQL.Add('select * from "cap$revalorizaciontmp" order by ID_AGENCIA, ID_TIPO_CAPTACION,NUMERO_CUENTA,DIGITO_CUENTA');
          try
           Open;
          except
           raise;
          end;

          frmProgreso := TfrmProgreso.Create(Self);
          frmProgreso.Min := 0;
          frmProgreso.Max := Total;
          frmProgreso.Position := 0;
          frmProgreso.Ejecutar;

          while not Eof do begin
             frmProgreso.Position := RecNo;
             frmProgreso.InfoLabel := 'Procesando Aportes:' + Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger]);
             Application.ProcessMessages;
             Digito := StrToInt(DigitoControl(1,Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger])));
             IBQuery2.Close;
             IBQuery2.SQL.Clear;
             IBQuery2.SQL.Add('select ID_ESTADO from "cap$maestro" where');
             IBQuery2.SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
             IBQuery2.SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
             IBQuery2.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and');
             IBQuery2.SQL.Add('DIGITO_CUENTA = :DIGITO_CUENTA');
             IBQuery2.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
             IBQuery2.ParamByName('ID_TIPO_CAPTACION').AsInteger := FieldbyName('ID_TIPO_CAPTACION').AsInteger;
             IBQuery2.ParamByName('NUMERO_CUENTA').AsInteger := FieldByName('NUMERO_CUENTA').AsInteger;
             IBQuery2.ParamByName('DIGITO_CUENTA').AsInteger := Digito;
             try
              IBQuery2.Open;
              if IBQuery2.RecordCount > 0 then
//                if (IBQuery2.FieldByName('ID_ESTADO').AsInteger = 1)
                 if (FieldByName('SE_PAGA').AsInteger <> 0)
                   then
                begin
                   IBPagar.Close;
                   IBPagar.SQL.Clear;
                   IBPagar.SQL.Add('insert into "cap$extracto" values(');
                   IBPagar.SQL.Add(':"ID_AGENCIA",:"ID_TIPO_CAPTACION",:"NUMERO_CUENTA",');
                   IBPagar.SQL.Add(':"DIGITO_CUENTA",:"FECHA_MOVIMIENTO",:"HORA_MOVIMIENTO",');
                   IBPagar.SQL.Add(':"ID_TIPO_MOVIMIENTO",:"DOCUMENTO_MOVIMIENTO",:"DESCRIPCION_MOVIMIENTO",');
                   IBPagar.SQL.Add(':"VALOR_DEBITO",:"VALOR_CREDITO")');
                   IBPagar.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
                   IBPagar.ParamByName('ID_TIPO_CAPTACION').AsInteger := FieldByName('ID_TIPO_CAPTACION').AsInteger;
                   IBPagar.ParamByName('NUMERO_CUENTA').AsInteger := FieldByName('NUMERO_CUENTA').AsInteger;
                   IBPagar.ParamByName('DIGITO_CUENTA').AsInteger := Digito;
                   IBPagar.ParamByName('FECHA_MOVIMIENTO').AsDateTime := EdFechaAplicar.Date;
                   IBPagar.ParamByName('HORA_MOVIMIENTO').AsTime := Time;
                   IBPagar.ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 6;
                   IBPagar.ParamByName('DOCUMENTO_MOVIMIENTO').AsString := Format('%.7d',[EdCbte.Value]);
                   IBPagar.ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'Revalorización del Patrimonio';
                   IBPagar.ParamByName('VALOR_DEBITO').AsCurrency := FieldByName('REVALORIZACION').AsCurrency;
                   IBPagar.ParamByName('VALOR_CREDITO').AsCurrency := 0;
                    try
                       IBPagar.ExecQuery;
                       if IBPagar.RowsAffected < 1 then
                       begin
                        frmProgreso.Cerrar;
                        MessageDlg('Error Grabando Revalorización',mtError,[mbok],0);
                        IBPagar.Transaction.Rollback;
                        Exit;
                       end
                    except
                       frmProgreso.Cerrar;
                       MessageDlg('Error Grabando Revalorización',mtError,[mbok],0);
                       IBPagar.Transaction.Rollback;
                       raise;
                    end; // del try

                    IBSQL1.Close;
                    IBSQL1.SQL.Clear;
                    IBSQL1.SQL.Add('update "cap$revalorizacion" SET PAGADO = :PAGADO, DIGITO_CUENTA = :DIGITO where');
                    IBSQL1.SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
                    IBSQL1.SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                    IBSQL1.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA');
                    IBSQL1.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
                    IBSQL1.ParamByName('ID_TIPO_CAPTACION').AsInteger := FieldByName('ID_TIPO_CAPTACION').AsInteger;
                    IBSQL1.ParamByName('NUMERO_CUENTA').AsInteger := FieldByName('NUMERO_CUENTA').AsInteger;
                    IBSQL1.ParamByName('DIGITO').AsInteger := Digito;
                    IBSQL1.ParamByName('PAGADO').AsInteger := BooleanoToInt(True);
                    try
                     IBSQL1.ExecQuery;
                    except
                     frmProgreso.Cerrar;
                     raise;
                    end;

//                    IBSQL1.Transaction.CommitRetaining;
                end; // if ID_ESTADO
              except
                frmProgreso.Cerrar;
                raise;
              end;

              Next;
             end;
          Transaction.Commit;
          frmProgreso.Cerrar;
          ShowMessage('Proceso Culminado con Exito!');
        end;

end;

procedure TfrmRevalorizacionAportes.ReporteUnknownVariable(Sender: TObject;
  const VarName: String; var Value: TprVarValue; var IsProcessed: Boolean);
var Ag,Tipo,Cuenta,Digito:Integer;
    Saldo,Movimiento:Currency;
begin
        Ag     := IBQuery5.FieldByName('ID_AGENCIA').AsInteger;
        Tipo   := IBQuery5.FieldByName('ID_TIPO_CAPTACION').AsInteger;
        Cuenta := IBQuery5.FieldByName('NUMERO_CUENTA').AsInteger;
        Digito := IBQuery5.FieldByName('DIGITO_CUENTA').AsInteger;

        if VarName = 'PRIMER_TITULAR' then begin
           IBSQL2.Close;
           IBSQL2.SQL.Clear;
           IBSQL2.SQL.Add('select "cap$maestrotitular".ID_PERSONA,"gen$persona".PRIMER_APELLIDO,"gen$persona".SEGUNDO_APELLIDO,"gen$persona".NOMBRE from "cap$maestrotitular"');
           IBSQL2.SQL.Add('LEFT JOIN "gen$persona" ON ("cap$maestrotitular".ID_IDENTIFICACION = "gen$persona".ID_IDENTIFICACION and');
           IBSQL2.SQL.Add('"cap$maestrotitular".ID_PERSONA = "gen$persona".ID_PERSONA)');
           IBSQL2.SQL.Add('where');
           IBSQL2.SQL.Add('"cap$maestrotitular".ID_AGENCIA = :ID_AGENCIA and');
           IBSQL2.SQL.Add('"cap$maestrotitular".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
           IBSQL2.SQL.Add('"cap$maestrotitular".NUMERO_CUENTA = :NUMERO_CUENTA and');
           IBSQL2.SQL.Add('"cap$maestrotitular".DIGITO_CUENTA = :DIGITO_CUENTA and');
           IBSQL2.SQL.Add('"cap$maestrotitular".NUMERO_TITULAR = 1');
           IBSQL2.ParamByName('ID_AGENCIA').AsInteger := Ag;
           IBSQL2.ParamByName('ID_TIPO_CAPTACION').AsInteger := Tipo;
           IBSQL2.ParamByName('NUMERO_CUENTA').AsInteger := Cuenta;
           IBSQL2.ParamByName('DIGITO_CUENTA').AsInteger := Digito;
           try
            IBSQL2.ExecQuery;
            if IBSQL2.RecordCount > 0 then
               _vSetAsString(Value,Format('%.15s',[IBSQL2.FieldByName('ID_PERSONA').AsString]) + '     '+ IBSQL2.FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                   IBSQL2.FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                   IBSQL2.FieldByName('NOMBRE').AsString)
            else
               _vSetAsString(Value,'');
           except
               _vSetAsString(Value,'');
           end;
           IsProcessed := True;
        end;




end;

procedure TfrmRevalorizacionAportes.CmdInformeClick(Sender: TObject);
var frmVistaPreliminar:TfrmVistaPreliminar;
begin
        with IBQuery5 do begin
           if Transaction.InTransaction then
              Transaction.Rollback;
            Transaction.StartTransaction;
            Close;
            SQL.Clear;
            SQL.Add('select * from "cap$revalorizaciontmp"');
            SQL.Add('order by ID_AGENCIA,ID_TIPO_CAPTACION, NUMERO_CUENTA,DIGITO_CUENTA');
        end;

        Reporte.Variables.ByName['Empresa'].AsString := Empresa;
        Reporte.Variables.ByName['Ano'].AsInteger := EdYear.Value;
        Reporte.Variables.ByName['FechaAplicada'].AsDateTime := edfechaaplicar.Date;

        if Reporte.PrepareReport then
        begin
          frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
          frmVistaPreliminar.Reporte := Reporte;
          frmVistaPreliminar.ShowModal;
        end;
        IBQuery5.Transaction.Commit;
end;

procedure TfrmRevalorizacionAportes.CreoSaldos;
var
  Dias:Extended;
  Saldo:Currency;
  Fecha1,Fecha2,Fecha3:TDate;
  Debito,Credito:Currency;
begin
        MSaldos.DisableControls;
        try
         MSaldos.Open;
         MSaldos.EmptyDataSet;
        except
         raise;
        end;
         with MSaldos do begin
             if MFecha.RecordCount < 1 then
             begin
                Dias := DiasEntre(FechaInicial,FechaFinal)+1;
//                Dias := FechaFinal - FechaInicial;
                AppendRecord([SaldoI,Dias]);
             end
             else
             begin
               MFecha.First;
               Saldo := SaldoI;
               Fecha1 := FechaInicial;
               while not MFecha.Eof do
               begin
                    Debito  := MFecha.FieldByName('DEBITO').AsCurrency;
                    Credito := MFecha.FieldByName('CREDITO').AsCurrency;
                    Fecha2 := MFecha.FieldByName('FECHA').AsDateTime;
                    Fecha3 := IncDay(Fecha2,-1);
//                    Dias := Fecha3 - Fecha1;
                    Dias := DiasEntre(Fecha1,Fecha3)+1;
                    AppendRecord([Saldo,Dias]);
                    Saldo := Saldo + Debito - Credito;
                    Fecha1 := Fecha2;
                    MFecha.Next;
               end;
               Dias := DiasEntre(Fecha1,FechaFinal)+1;
//               Dias := FechaFinal - Fecha1;
               AppendRecord([Saldo,Dias]);
             end;
         end;

         Suma := 0;
         DiasSuma := 0;
         with MSaldos do begin
          First;
          while not Eof do
          begin
              Suma := Suma + (FieldByName('SALDO').AsCurrency * FieldByName('DIAS').AsInteger);
              DiasSuma := DiasSuma + FieldByName('DIAS').AsInteger;
              Next;
          end;
         end;
         MSaldos.Close;
         MFecha.Close;
end;

end.
