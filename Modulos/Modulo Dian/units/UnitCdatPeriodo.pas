unit UnitCdatPeriodo;

interface

uses
  DateUtils, StrUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IBSQL, DB, DBClient, IBCustomDataSet, IBQuery, Grids, StdCtrls,
  Buttons, ExtCtrls, JvTypedEdit, JvEdit, JvSpecialProgress, XLSfile,JclDateTime;

type
  TfrmCdatPeriodo = class(TForm)
    Bar2: TJvSpecialProgress;
    Bar1: TJvSpecialProgress;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    EdMonto: TJvCurrencyEdit;
    EdPeriodo: TJvYearEdit;
    Panel1: TPanel;
    btnProcesar: TBitBtn;
    btnCerrar: TBitBtn;
    btnAExcel: TBitBtn;
    Sg1: TStringGrid;
    IBQuery1: TIBQuery;
    Cds1: TClientDataSet;
    sd1: TSaveDialog;
    IBSQL2: TIBSQL;
    IBSQL1: TIBQuery;
    Bar3: TJvSpecialProgress;
    IBQuery2: TIBQuery;
    Cds1Cuenta: TStringField;
    Cds1Interes: TCurrencyField;
    Cds1Saldo: TCurrencyField;
    Cds1Causados: TCurrencyField;
    Cds1Inicial: TCurrencyField;
    Cds1Inversion: TCurrencyField;
    Cds1fechaa: TStringField;
    Cds1fechav: TStringField;
    Cds1estado: TStringField;
    Cds1idpersona: TStringField;
    Cds1ididentificacion: TIntegerField;
    CDDATOS: TClientDataSet;
    CDDATOSIDPERSONA: TStringField;
    CDDATOSIDIDENTIFICACION: TIntegerField;
    CDDATOSINICIAL: TCurrencyField;
    CDDATOSINVERSION: TCurrencyField;
    CDDATOSINTERES: TCurrencyField;
    CDDATOSSALDO: TCurrencyField;
    CDDATOSFECHAA: TDateField;
    CDDATOSFECHAV: TDateField;
    CDDATOSESTADO: TStringField;
    CDDATOSNUMERO: TStringField;
    procedure btnProcesarClick(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
    procedure btnAExcelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCdatPeriodo: TfrmCdatPeriodo;

implementation

{$R *.dfm}

uses UnitDmGeneral,UnitGlobales;

procedure TfrmCdatPeriodo.btnProcesarClick(Sender: TObject);
var
  Id:string;
  Dg:string;
  Tp:string;
  Nm:string;
  Dr:string;
  Mn:string;
  Total:Integer;
  Fila:Integer;
  Saldo,Credito,Interes, Causados:Currency;
  Saldo1,Credito1,Interes1, Causados1:Currency;
  Cuenta:string;
  valor_inicial, CausadoAnt, Inversion1 :Currency;
  Dpto :string;
  vFechaSaldado :string;
  vContador :Integer;
  vEstado :string;
  vCodMunicipio :string;
  _sNombre :string;
  _dFechaApertura :TDate;
  _dFechaVencimiento :TDate;
begin
//ShowMessage('Inicial:' + DateToStr(_dFechaInicial) + ' Final:' + DateToStr(_dFechaCorteAhorros));
        Fila := -1;
        Application.ProcessMessages;
        Sg1.RowCount := 1;
        Sg1.ColWidths[0]  := 30;
        Sg1.ColWidths[1]  := 10;
        Sg1.ColWidths[2]  := 20;
        Sg1.ColWidths[3]  := 20;
        Sg1.ColWidths[4]  := 140;
        Sg1.ColWidths[5]  := 10;
        Sg1.ColWidths[6]  := 10;
        Sg1.ColWidths[7]  := 100;
        Sg1.ColWidths[8]  := 100;
        Sg1.colwidths[9]  := 100;
        Sg1.ColWidths[10] := 200; // Saldo Inicial
        Sg1.ColWidths[11] := 200; // Intereses
        Sg1.ColWidths[12] := 200; // Inversiones
        Sg1.ColWidths[13] := 200; // Saldo Final
        Sg1.ColWidths[14] := 140;
        Sg1.ColWidths[15] := 400;
        Sg1.ColWidths[16] := 50;
        Sg1.ColWidths[17] := 80;// fecha apertura
        Sg1.ColWidths[18] := 80; //fecha de saldado
        Sg1.ColWidths[19] := 80; // Estado
        Sg1.ColWidths[20] := 80; // contador de numero de cdat
        Sg1.ColWidths[21] := 300; // municipio

        with IBQuery1 do
        begin
         if Transaction.InTransaction then
            Transaction.Commit;
         Transaction.StartTransaction;
         Close;
         SQL.Clear;
         SQL.Add('select');
         SQL.Add('count(*) as TOTAL');
         SQL.Add('from');
         SQL.Add('"gen$persona"');
         SQL.Add('left join "gen$direccion" on ("gen$persona".ID_IDENTIFICACION = "gen$direccion".ID_IDENTIFICACION and');
         SQL.Add('"gen$persona".ID_PERSONA = "gen$direccion".ID_PERSONA and "gen$direccion".ID_DIRECCION = 1 ');
         SQL.Add('and "gen$direccion".ID_DIRECCION = 1)');
         try
           Open;
           Total := FieldByName('TOTAL').AsInteger;
         except
           Transaction.Rollback;
           raise;
         end;
         Close;

         Bar3.Maximum := Total;

         SQL.Clear;
         SQL.Add('select');
         SQL.Add('"gen$persona".ID_IDENTIFICACION,');
         SQL.Add('"gen$persona".ID_PERSONA,');
         SQL.Add('"gen$persona".PRIMER_APELLIDO, "gen$persona".SEGUNDO_APELLIDO,"gen$persona".NOMBRE,');
         SQL.Add('"gen$direccion".DIRECCION || '' '' || "gen$direccion".BARRIO AS DIRECCION,');
         SQL.Add('"gen$direccion".MUNICIPIO,"gen$direccion".COD_MUNICIPIO');
         SQL.Add('from');
         SQL.Add('"gen$persona"');
         SQL.Add('left join "gen$direccion" on ("gen$persona".ID_IDENTIFICACION = "gen$direccion".ID_IDENTIFICACION and');
         SQL.Add('"gen$persona".ID_PERSONA = "gen$direccion".ID_PERSONA');
         SQL.Add('and "gen$direccion".ID_DIRECCION = 1)');
         //SQL.Add('where "gen$persona".ID_PERSONA = :ID');
         //ParamByName('ID').AsString := '1975076';
         try
           Open;
         except
           Transaction.Rollback;
           raise;
         end;

         while not Eof do begin
           Bar3.Position := RecNo;
           Application.ProcessMessages;
           vCodMunicipio := FieldByName('COD_MUNICIPIO').AsString;
           if (vCodMunicipio = '') Then vCodMunicipio := '00000';
           IBSQL1.Close;
           IBSQL1.SQL.Clear; //seleccionar numero de cuenta de los cdats
           IBSQL1.SQL.Add('select');
           IBSQL1.SQL.Add('"cap$maestro".ID_AGENCIA,');
           IBSQL1.SQL.Add('"cap$maestro".ID_TIPO_CAPTACION,');
           IBSQL1.SQL.Add('"cap$maestro".NUMERO_CUENTA,');
           IBSQL1.SQL.Add('"cap$maestro".ID_ESTADO,');
           IBSQL1.SQL.Add('"cap$maestro".DIGITO_CUENTA,');
           IBSQL1.SQL.Add('"cap$maestro".VALOR_INICIAL,FECHA_VENCIMIENTO_PRORROGA,');
           IBSQL1.SQL.Add('"cap$maestro".FECHA_APERTURA,"cap$maestro".FECHA_ULTIMO_PAGO,"cap$maestro".FECHA_SALDADA');
           IBSQL1.SQL.Add('from');
           IBSQL1.SQL.Add('"cap$maestrotitular"');
           IBSQL1.SQL.Add('inner join');
           IBSQL1.SQL.Add('"cap$maestro" on ("cap$maestrotitular".ID_AGENCIA = "cap$maestro".ID_AGENCIA and');
           IBSQL1.SQL.Add('"cap$maestrotitular".ID_TIPO_CAPTACION = "cap$maestro".ID_TIPO_CAPTACION and');
           IBSQL1.SQL.Add('"cap$maestrotitular".NUMERO_CUENTA = "cap$maestro".NUMERO_CUENTA and');
           IBSQL1.SQL.Add('"cap$maestrotitular".DIGITO_CUENTA = "cap$maestro".DIGITO_CUENTA)');
           IBSQL1.SQL.Add('where');
           IBSQL1.SQL.Add('"cap$maestrotitular".ID_IDENTIFICACION = :ID_IDENTIFICACION and');
           IBSQL1.SQL.Add('"cap$maestrotitular".ID_PERSONA = :ID_PERSONA and');
           IBSQL1.SQL.Add('"cap$maestrotitular".ID_TIPO_CAPTACION IN (5,6) and');
           IBSQL1.SQL.Add('"cap$maestro".ID_ESTADO NOT IN (5,7,11,15)');
           IBSQL1.ParamByName('ID_IDENTIFICACION').AsInteger := FieldByName('ID_IDENTIFICACION').AsInteger;
           IBSQL1.ParamByName('ID_PERSONA').AsString := FieldByName('ID_PERSONA').AsString;
           try
            IBSQL1.Open;
            IBSQL1.Last;
            IBSQL1.First;
           except
            Transaction.Rollback;
            raise;
           end;
           Bar1.Maximum := IBSQL1.RecordCount;
           Bar1.Position := 0;
           Interes := 0;
           Cds1.Open;
           Cds1.EmptyDataSet;
           Cds1.Close;
           valor_inicial := 0;
           vcontador := 0;
           while not IBSQL1.Eof do
           begin

             Saldo1   := 0;
             Credito1 := 0;
             Interes1 := 0;
             Causados1 := 0;
             Inversion1 := 0;
             CausadoAnt := 0;
             Saldo   := 0;
             if (IBSQL1.FieldByName('FECHA_SALDADA').AsDateTime = 0) and (IBSQL1.FieldByName('ID_ESTADO').AsInteger = 2) then
             begin
                vFechaSaldado := DateToStr(IBSQL1.FieldByName('FECHA_VENCIMIENTO_PRORROGA').AsDateTime);
                _dFechaVencimiento := IBSQL1.FieldByName('FECHA_VENCIMIENTO_PRORROGA').AsDateTime;
             end
             else if IBSQL1.FieldByName('FECHA_SALDADA').AsDateTime = 0 then
             begin
                _dFechaVencimiento := StrToDate('1899/12/31');
                vFechaSaldado := '';
             end
             else
             begin
                vFechaSaldado := datetostr(IBSQL1.FieldByName('FECHA_SALDADA').AsDateTime);
                _dFechaVencimiento := IBSQL1.FieldByName('FECHA_SALDADA').AsDateTime;
             end;
             Bar1.Position := IBSQL1.RecNo;
             Application.ProcessMessages;
             case IBSQL1.FieldByName('ID_ESTADO').AsInteger of
               1: vEstado := 'ACTIVO';
               2: vEstado := 'SALDADO';
               3: vEstado := 'INACTIVO';
               4: vEstado := 'EMBARGADO';
               6: vEstado := 'PRORROGADO';
               9: vEstado := 'CANCELADO';
               11:vEstado := 'ANULADO';
               12:vEstado := 'FALLECIDO';
               15:vEstado := 'TRASLADADA';
             end;

             if IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger = 6 then
             begin
//               if IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger = 23411 then
//                  ShowMessage('Pausa');
               // verificar saldo inicial y saldo final a 31 dic
               Saldo1 := IBSQL1.FieldByName('VALOR_INICIAL').AsCurrency;
               if IBSQL1.FieldByName('FECHA_APERTURA').AsDateTime >= _dFechaInicial then
                   valor_inicial := valor_inicial + IBSQL1.FieldByName('VALOR_INICIAL').AsCurrency;
               if IBSQL1.FieldByName('ID_ESTADO').AsInteger in [1,6] then
                   Saldo := IBSQL1.FieldByName('VALOR_INICIAL').AsCurrency;
               _dFechaApertura := IBSQL1.FieldByName('FECHA_APERTURA').AsDateTime;

               IBQuery2.Close;
               IBQuery2.SQL.Clear;
               IBQuery2.SQL.Add('select SUM(VALOR_DEBITO) AS VALOR from "cap$extracto"');
               IBQuery2.SQL.Add('where');
               IBQuery2.SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
               IBQuery2.SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
               IBQuery2.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and');
               IBQuery2.SQL.Add('DIGITO_CUENTA = :DIGITO_CUENTA and');
               IBQuery2.SQL.Add('(FECHA_MOVIMIENTO BETWEEN :FECHA1 and :FECHA2) and');
               IBQuery2.SQL.Add('VALOR_DEBITO <> 0 and ID_TIPO_MOVIMIENTO = 15');
               IBQuery2.ParamByName('ID_AGENCIA').AsInteger := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
               IBQuery2.ParamByName('ID_TIPO_CAPTACION').AsInteger := IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
               IBQuery2.ParamByName('NUMERO_CUENTA').AsInteger := IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger;
               IBQuery2.ParamByName('DIGITO_CUENTA').AsInteger := IBSQL1.FieldByName('DIGITO_CUENTA').AsInteger;
               IBQuery2.ParamByName('FECHA1').AsDate := _dFechaInicial;
               IBQuery2.ParamByName('FECHA2').AsDate := _dFechaCorteAhorros;
               try
                 IBQuery2.Open;
                 if IBQuery2.RecordCount > 0 then
                   Interes1 := IBQuery2.FieldByName('VALOR').AsCurrency;
               except
                 IBQuery2.Transaction.Rollback;
                 raise;
               end;
{               Bar2.Maximum := IBQuery2.RecordCount;
               while not IBQuery2.Eof do
               begin
                 Bar2.Position := IBQuery2.RecNo;
                 Application.ProcessMessages;
                 Interes1 := Interes1 + IBQuery2.FieldByName('VALOR_DEBITO').AsCurrency;
                 IBQuery2.Next;
               end; // fin del while
}
               // Causacion Año Anterior
               IBQuery2.Close;
               IBQuery2.SQL.Clear;
               IBQuery2.SQL.Add('select CAUSACION_MENSUAL from "cap$causacioncdat"');
               IBQuery2.SQL.Add('where');
               IBQuery2.SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
               IBQuery2.SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
               IBQuery2.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and');
               IBQuery2.SQL.Add('DIGITO_CUENTA = :DIGITO_CUENTA and');
               IBQuery2.SQL.Add('ANO = :ANO and MES =:MES');
               IBQuery2.ParamByName('ID_AGENCIA').AsInteger := IBSQL1.fieldbyname('ID_AGENCIA').AsInteger;
               IBQuery2.ParamByName('ID_TIPO_CAPTACION').AsInteger := 6;
               IBQuery2.ParamByName('NUMERO_CUENTA').AsInteger := IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger;
               IBQuery2.ParamByName('DIGITO_CUENTA').AsInteger := IBSQL1.FieldByName('DIGITO_CUENTA').AsInteger;
               IBQuery2.ParamByName('ANO').AsInteger := EdPeriodo.Value-1;
               IBQuery2.ParamByName('MES').AsInteger := MonthOfDate(_dFechaCorteAhorros);
               try
                IBQuery2.Open;
                if IBQuery2.RecordCount > 0 then
                begin
                  CausadoAnt := IBQuery2.FieldByName('CAUSACION_MENSUAL').AsCurrency;
                end;
               except
                 IBQuery2.Transaction.Rollback;
                 raise;
               end;
               // Intereses Causados Año Reporte
               IBQuery2.Close;
               IBQuery2.SQL.Clear;
               IBQuery2.SQL.Add('select CAUSACION_TOTAL from "cap$causacioncdat"');
               IBQuery2.SQL.Add('where');
               IBQuery2.SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
               IBQuery2.SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
               IBQuery2.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and');
               IBQuery2.SQL.Add('DIGITO_CUENTA = :DIGITO_CUENTA and');
               IBQuery2.SQL.Add('ANO = :ANO and MES =:MES');
               IBQuery2.ParamByName('ID_AGENCIA').AsInteger := IBSQL1.fieldbyname('ID_AGENCIA').AsInteger;
               IBQuery2.ParamByName('ID_TIPO_CAPTACION').AsInteger := IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
               IBQuery2.ParamByName('NUMERO_CUENTA').AsInteger := IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger;
               IBQuery2.ParamByName('DIGITO_CUENTA').AsInteger := IBSQL1.FieldByName('DIGITO_CUENTA').AsInteger;
               IBQuery2.ParamByName('ANO').AsInteger := EdPeriodo.Value;
               IBQuery2.ParamByName('MES').AsInteger := 12;
               try
                IBQuery2.Open;
                if IBQuery2.RecordCount > 0 then
                begin
                  Causados1 := IBQuery2.FieldByName('CAUSACION_TOTAL').AsCurrency;
                end;
               except
                 IBQuery2.Transaction.Rollback;
                 raise;
               end;
               //SALDO DEL CDAT
               //validar fecha de ultimo pago
               //ShowMessage('Fecha Ultimo ' + DateToStr(IBSQL1.FieldByName('FECHA_ULTIMO_PAGO').AsDateTime) + ' Fecha Periodo ' + DateToStr( EncodeDate(EdPeriodo.Value,01,01)) + ' Numero : ' + Format('%.7d',[IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger]));

               if (IBSQL1.FieldByName('FECHA_ULTIMO_PAGO').AsDateTime >= EncodeDate(EdPeriodo.Value,01,01)) or (IBSQL1.FieldByName('FECHA_ULTIMO_PAGO').AsDateTime = EncodeDate(1899,12,30)) then
               begin
                 if (_dFechaApertura > _dFechaInicial) or (vEstado <> 'SALDADO') or (_dFechaVencimiento >= _dFechaInicial) then
                 begin
                   //ShowMessage('paso');
                   vContador := vContador + 1;
                   Cds1.Open;
                   Cds1.Append;
                   Cds1.FieldByName('Cuenta').AsString := IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsString+
                                                        Format('%.2d',[IBSQL1.FieldByName('ID_AGENCIA').AsInteger])+
                                                        Format('%.7d',[IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger])+
                                                        IBSQL1.FieldByName('DIGITO_CUENTA').AsString;

                   if IBSQL1.FieldByName('FECHA_APERTURA').AsDateTime < EncodeDate(EdPeriodo.Value,01,01) then
                   begin
                      Saldo1 := Saldo1;//+CausadoAnt;
                      Inversion1 := 0;
                   end
                   else
                   begin
                      Inversion1 := Saldo1;
                      Saldo1 := 0;
                   end;
                   Cds1.FieldByName('Inicial').AsCurrency := Saldo1;
                   Cds1.FieldByName('Inversion').AsCurrency := Inversion1;
                   Cds1.FieldByName('Interes').AsCurrency := Interes1+Causados1;
                   if IBSQL1.FieldByName('ID_ESTADO').AsInteger in [2,7,9,11] then
                                 Cds1.FieldByName('Saldo').AsCurrency := 0
                   else
                     Cds1.FieldByName('Saldo').AsCurrency := Inversion1;//Saldo1+Causados1+Inversion1;
                   Cds1.FieldByName('Causados').AsCurrency := Causados1;
                   Cds1.FieldByName('fechaa').AsString := DateToStr(IBSQL1.FieldByName('FECHA_APERTURA').AsDateTime);
                   Cds1.FieldByName('fechav').AsString := vFechaSaldado;
                   Cds1.FieldByName('estado').AsString := vEstado;
                   Cds1.Post;
                   Cds1.Close;
                 end;
               end;// fin validacion
               // finalizacion de validacion cdat
             end
             else
             begin   // Caso Contractual
               if _dFechaApertura > _dFechaInicial then //validacion para fecha apertura de Contractuales
               begin
                 IBQuery2.Close;
                 IBQuery2.SQL.Clear;
                 IBQuery2.SQL.Add('select SALDO_INICIAL from "cap$maestrosaldoinicial"');
                 IBQuery2.SQL.Add('where');
                 IBQuery2.SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
                 IBQuery2.SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                 IBQuery2.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and');
                 IBQuery2.SQL.Add('DIGITO_CUENTA = :DIGITO_CUENTA and');
                 IBQuery2.SQL.Add('ANO = :ANO');
                 IBQuery2.ParamByName('ID_AGENCIA').AsInteger := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
                 IBQuery2.ParamByName('ID_TIPO_CAPTACION').AsInteger := IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                 IBQuery2.ParamByName('NUMERO_CUENTA').AsInteger := IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger;
                 IBQuery2.ParamByName('DIGITO_CUENTA').AsInteger := IBSQL1.FieldByName('DIGITO_CUENTA').AsInteger;
                 IBQuery2.ParamByName('ANO').AsInteger := EdPeriodo.Value;
                 try
                   IBQuery2.Open;
                   if IBQuery2.RecordCount > 0 then
                     Saldo1 := IBQuery2.FieldByName('SALDO_INICIAL').AsCurrency;
                 except
                   IBQuery2.Transaction.Rollback;
                   raise;
                 end;

                IBQuery2.Close;
                IBQuery2.SQL.Clear;
                IBQuery2.SQL.Add('select SUM(VALOR_DEBITO) AS VALOR from "cap$extracto"');
                IBQuery2.SQL.Add('where');
                IBQuery2.SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
                IBQuery2.SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                IBQuery2.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and');
                IBQuery2.SQL.Add('DIGITO_CUENTA = :DIGITO_CUENTA and');
                IBQuery2.SQL.Add('(FECHA_MOVIMIENTO BETWEEN :FECHA1 and :FECHA2)');
                IBQuery2.ParamByName('ID_AGENCIA').AsInteger := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
                IBQuery2.ParamByName('ID_TIPO_CAPTACION').AsInteger := IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                IBQuery2.ParamByName('NUMERO_CUENTA').AsInteger := IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger;
                IBQuery2.ParamByName('DIGITO_CUENTA').AsInteger := IBSQL1.FieldByName('DIGITO_CUENTA').AsInteger;
                IBQuery2.ParamByName('FECHA1').AsDate := EncodeDate(EdPeriodo.Value,01,01);
                IBQuery2.ParamByName('FECHA2').AsDate := EncodeDate(EdPeriodo.Value,12,31);
                try
                  IBQuery2.Open;
                  Inversion1 := 0;
                  if IBQuery2.RecordCount > 0 then
                  begin
                  valor_inicial := valor_inicial + IBQuery2.FieldByName('VALOR').AsCurrency;
                  Inversion1 :=  IBQuery2.FieldByName('VALOR').AsCurrency;
                  end;
                except
                  IBQuery2.Transaction.Rollback;
                  raise;
                end;

                // Intereses Causados Año Reporte
                IBQuery2.Close;
                IBQuery2.SQL.Clear;
                IBQuery2.SQL.Add('select CAUSACION_ACUMULADA from "cap$causacioncon"');
                IBQuery2.SQL.Add('where');
                IBQuery2.SQL.Add('ID_AGENCIA = :ID_AGENCIA and');
                IBQuery2.SQL.Add('ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                IBQuery2.SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and');
                IBQuery2.SQL.Add('DIGITO_CUENTA = :DIGITO_CUENTA and');
                IBQuery2.SQL.Add('ANO = :ANO and MES =:MES');
                IBQuery2.ParamByName('ID_AGENCIA').AsInteger := IBSQL1.fieldbyname('ID_AGENCIA').AsInteger;
                IBQuery2.ParamByName('ID_TIPO_CAPTACION').AsInteger := IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                IBQuery2.ParamByName('NUMERO_CUENTA').AsInteger := IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger;
                IBQuery2.ParamByName('DIGITO_CUENTA').AsInteger := IBSQL1.FieldByName('DIGITO_CUENTA').AsInteger;
                IBQuery2.ParamByName('ANO').AsInteger := EdPeriodo.Value;
                IBQuery2.ParamByName('MES').AsInteger := 12;
                try
                 IBQuery2.Open;
                 if IBQuery2.RecordCount > 0 then
                 begin
                   Causados1 := IBQuery2.FieldByName('CAUSACION_ACUMULADA').AsCurrency;
                   Interes1 := 0;
                 end;
                except
                  IBQuery2.Transaction.Rollback;
                  raise;
                end;

                Cds1.Open;
                Cds1.Append;
                Cds1.FieldByName('Cuenta').AsString := IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsString+
                                                       Format('%.2d',[IBSQL1.FieldByName('ID_AGENCIA').AsInteger])+
                                                       Format('%.7d',[IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger])+
                                                       IBSQL1.FieldByName('DIGITO_CUENTA').AsString;

                Cds1.FieldByName('Inicial').AsCurrency := Saldo1;
                Cds1.FieldByName('Inversion').AsCurrency := Inversion1;
                Cds1.FieldByName('Interes').AsCurrency := Interes1+Causados1;

                if IBSQL1.FieldByName('ID_ESTADO').AsInteger in [2,7,9,11] then
                  Cds1.FieldByName('Saldo').AsCurrency := 0
                else
                  Cds1.FieldByName('Saldo').AsCurrency := inversion1;//Saldo1+Causados1+Inversion1;

                Cds1.FieldByName('Causados').AsCurrency := Causados1;
                Cds1.FieldByName('fechaa').AsString := DateToStr(IBSQL1.FieldByName('FECHA_APERTURA').AsDateTime);
                Cds1.FieldByName('fechav').AsString := vFechaSaldado;
                Cds1.FieldByName('estado').AsString := vEstado;
                Cds1.Post;
                Cds1.Close;

              end;
             end;//fin validacion de fecha de apertura

             IBSQL1.Next; // next del query captaciones
           end; // fin del while del IBSQL1
// Validar Saldo
           if  valor_inicial >= EdMonto.Value then
           begin
             Cds1.Open;
             while not Cds1.Eof do
             begin
               CDDATOS.Append;
               CDDATOS.FieldValues['NUMERO'] := Cds1.FieldByName('cuenta').AsString;
               CDDATOS.FieldValues['IDPERSONA'] := IBQuery1.FieldByName('ID_PERSONA').AsString;
               CDDATOS.FieldValues['IDIDENTIFICACION'] := IBQuery1.FieldByName('ID_IDENTIFICACION').AsInteger;
               CDDATOS.FieldValues['INICIAL'] := Cds1.FieldByName('inicial').AsCurrency;
               CDDATOS.FieldValues['INVERSION'] := Cds1.FieldByName('inversion').AsCurrency;
               CDDATOS.FieldValues['INTERES'] := Cds1.FieldByName('interes').AsCurrency;
               CDDATOS.FieldValues['SALDO'] := Cds1.FieldByName('saldo').AsCurrency;
               try
                 CDDATOS.FieldValues['FECHAA'] := StrToDate(Cds1.FieldByName('fechaa').AsString);
               except
                 CDDATOS.FieldValues['FECHAA'] := Null;
               end;
               try
                 CDDATOS.FieldValues['FECHAV'] := StrToDate(Cds1.FieldByName('fechav').AsString);
               except
                 CDDATOS.FieldValues['FECHAV'] := Null;
               end;
               CDDATOS.FieldValues['ESTADO'] := Cds1.FieldByName('estado').AsString;
               CDDATOS.Post;
               Cds1.Next;
             end;
          end; // fin de la validación de saldo
         Next; //next del query personas
         end; // fin del While de ibquery1
         Transaction.Commit;
        end; // Fin del With IBQuery1
        //Insertar Información en la tabla
        with IBQuery1 do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('INSERT INTO');
          SQL.Add('"dian$cdat"(CUENTA,IDPERSONA,IDIDENTIFICACION,INICIAL,INVERSION,INTERES,SALDO,FECHA,FECHAV,ESTADO)');
          SQL.Add('VALUES(');
          SQL.Add(':CUENTA,:IDPERSONA,:IDIDENTIFICACION,:INICIAL,:INVERSION,:INTERES,:SALDO,:FECHA,:FECHAV,:ESTADO)');
          CDDATOS.First;
          while not CDDATOS.Eof do
          begin
            ParamByName('CUENTA').AsString := CDDATOS.FieldByName('NUMERO').AsString;
            ParamByName('IDPERSONA').AsString := CDDATOS.FieldByName('IDPERSONA').AsString;
            ParamByName('IDIDENTIFICACION').AsInteger := CDDATOS.FieldByName('IDIDENTIFICACION').AsInteger;
            ParamByName('INICIAL').AsCurrency := CDDATOS.FieldByName('INICIAL').AsCurrency;
            ParamByName('INVERSION').AsCurrency := CDDATOS.FieldByName('INVERSION').AsCurrency;
            ParamByName('INTERES').AsCurrency := CDDATOS.FieldByName('INTERES').AsCurrency;
            ParamByName('SALDO').AsCurrency := CDDATOS.FieldByName('SALDO').AsCurrency;
            try
              ParamByName('FECHA').AsDateTime := CDDATOS.FieldByName('FECHAA').AsDateTime;
            except
              ParamByName('FECHA').Clear;
            end;
            try
              ParamByName('FECHAV').AsDateTime := CDDATOS.FieldByName('FECHAV').AsDateTime;
            except
              ParamByName('FECHAV').Clear;
            end;
            ParamByName('ESTADO').AsString := CDDATOS.FieldByName('ESTADO').AsString;
            ExecSQL;
            CDDATOS.Next;
          end;
          Transaction.Commit;
        end;

end;

procedure TfrmCdatPeriodo.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCdatPeriodo.btnAExcelClick(Sender: TObject);
begin
        if sd1.Execute then
           StringGridToXLS(Sg1,sd1.FileName);
end;

procedure TfrmCdatPeriodo.FormCreate(Sender: TObject);
begin
        EdPeriodo.Value := YearOf(fFechaActual) - 1;
end;

end.
