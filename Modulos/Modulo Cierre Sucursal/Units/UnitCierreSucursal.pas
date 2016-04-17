unit UnitCierreSucursal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB,IB, DBClient, StdCtrls, IBDatabase, IBCustomDataSet, IBQuery,
  IBSQL,Math;

type
  TFrmCierreSucursal = class(TForm)
    CdMovimiento: TClientDataSet;
    CdMovimientoID_AGENCIA: TIntegerField;
    CdMovimientoAGENCIA: TStringField;
    CdMovimientoID_CAJA: TSmallintField;
    CdMovimientoORIGEN_MOVIMIENTO: TSmallintField;
    CdMovimientoID_TIPO_CAPTACION: TSmallintField;
    CdMovimientoID_TIPO_MOVIMIENTO: TSmallintField;
    CdMovimientoCHEQUE_DB: TCurrencyField;
    CdMovimientoCHEQUE_CR: TCurrencyField;
    Button1: TButton;
    CDcomision: TClientDataSet;
    CDcomisioncomision: TCurrencyField;
    CDcomisionagencia: TIntegerField;
    CDcomisionid_identificacion: TIntegerField;
    CDcomisionid_persona: TStringField;
    CDcomisionvalor: TAggregateField;
    CdMovimientoCODIGO: TStringField;
    CdMovimientoEFECTIVO_DB2: TCurrencyField;
    CdMovimientoEFECTIVO_CR: TCurrencyField;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _iAgencia :Integer;
    _dFechaActual :TDate;
    procedure CierreSucursal;
    function BuscaMovimiento(_ibQuery: TIBQuery):Boolean;
    function Comprobante(_ibSQl: TIBQuery;_sDesAgencia: string;_cDebito,_cCredito:Currency;_iComprobante:Integer): Integer;
    function ObtenerConsecutivo(IBSQL1:TIBSQL): Longint;
    procedure Auxiliar(_ibQuery: TIBQuery;_iConsecutivo:Integer; _sCodigo: String; _cDebito,
      _cCredito: Currency);
    function CodigoSucursal(_ibQuery: TIBQuery; _iAgenciaRemota,
      _iOrigen: Integer): string;
    procedure ControlCierre(_ibCon: TIBQuery);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCierreSucursal: TFrmCierreSucursal;

implementation
uses  IniFiles;

{$R *.dfm}
procedure TFrmCierreSucursal.CierreSucursal;
var     _sMiINI :string;
        _sDBserver :string;
        _sDBPath :string;
        _sDBname :string;
        IBDatabaseSuc: TIBDatabase;
        IBTransactionSuc: TIBTransaction;
        IBTransactionCsc: TIBTransaction;
        _ibConsulta: TIBQuery;
        _ibConsulta1 :TIBQuery;
        _ibSQL1:TIBSQL;
        _iConsecutivo :Integer;
        _cSalida :Currency;
        _cEntrada :Currency;
        _cAportes :Currency;
        _cAhorros :Currency;
        _sCodigo :string;
        _cValorTasa :Currency;
        _cValorValor :Currency;
        _cValorVeces :Currency;
        _cTotalDebito :Currency;
        _cTotalCredito :Currency;
        _bHayMovimiento :Boolean;

begin                
  _sMiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(_sMiINI) do
  try
    _sDBserver := ReadString('DBNAME','server','192.168.1.8');
    _sDBPath := ReadString('DBNAME','path','/home/');
    _sDBname := ReadString('DBNAME','name','coopservir.gdb');
    _iAgencia := ReadInteger('DBNAME','Agencia',1);
  finally
    free;
  end;
  // Conexión a la Base de Datos
  IBDatabaseSuc := TIBDatabase.Create(Self);
  IBTransactionSuc := TIBTransaction.Create(Self);
  IBTransactionCsc := TIBTransaction.Create(Self);
  IBDatabaseSuc.LoginPrompt := False;
  IBDatabaseSuc.DataBaseName := _sDBserver + ':' + _sDBpath + _sDBname;
  IBDatabaseSuc.Params.Values['lc_ctype'] := 'ISO8859_1';
  IBDatabaseSuc.Params.Values['User_Name'] := 'SUCURSAL';
  IBDatabaseSuc.Params.Values['PassWord'] := 'sucursal123';
  IBDatabaseSuc.Params.Values['sql_role_name'] := 'TESORERIA';
  IBTransactionSuc.DefaultDatabase := IBDatabaseSuc;
  IBTransactionCsc.DefaultDatabase := IBDatabaseSuc;
  try
    IBDatabaseSuc.Open;
    IBTransactionSuc.Active := True;
  except
    ShowMessage('Error Conectando Base de Datos');
  end;
  //Fin Conexión Base de Datos
  //Querys Utilizados
  _ibConsulta := TIBQuery.Create(Self);
  _ibConsulta.Database := IBDatabaseSuc;
  _ibConsulta.Transaction := IBTransactionSuc;
  _ibConsulta1 := TIBQuery.Create(Self);
  _ibConsulta1.Database := IBDatabaseSuc;
  _ibConsulta1.Transaction := IBTransactionSuc;
  _ibSQL1 := TIBSQL.Create(Self);
  _ibSQL1.Database := IBDatabaseSuc;
  _ibSQL1.Transaction := IBTransactionCsc;
  _bHayMovimiento := False;
  with _ibConsulta do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT FECHA FROM SP_FECHA_ACTUAL');
    Open;
    _dFechaActual := FieldByName('FECHA').AsDateTime;
    if Buscamovimiento(_ibConsulta) then // Validacion si existen movimientos o si ya se contabilizo el dia
    begin
      _bHayMovimiento := True;
      Close;
      SQL.Clear;
      SQL.Add('select ID_AGENCIA,DESCRIPCION_AGENCIA from "gen$agencia" where ID_AGENCIA <> :ID_AGENCIA order by ID_AGENCIA');
      ParamByName('ID_AGENCIA').AsInteger := _iAgencia;
      Open;
      while not Eof do
      begin
        _iConsecutivo := 0;
        _cSalida := 0;
        _cEntrada := 0;
        _cAportes := 0;
        _cAhorros := 0;
        _cValorTasa := 0;
        _cValorValor := 0;
        _cValorVeces := 0;
        _cTotalDebito := 0;
        _cTotalCredito := 0;
        CdMovimiento.Filtered := False;
        CdMovimiento.Filter := 'ID_AGENCIA = ' + IntToStr(FieldByName('ID_AGENCIA').AsInteger);
        CdMovimiento.Filtered := True;
        if CdMovimiento.RecordCount > 0 then //Validacion para Generacion de Comprobante
        begin
          _iConsecutivo :=  ObtenerConsecutivo(_ibSQL1);
          while not CdMovimientYamatoo.Eof do
          begin
            _sCodigo :=  CdMovimiento.FieldByName('CODIGO').AsString;
            _cEntrada := CdMovimiento.FieldByName('EFECTIVO_DB').AsCurrency + CdMovimiento.FieldByName('CHEQUE_DB').AsCurrency;
            _cSalida := CdMovimiento.FieldByName('EFECTIVO_CR').AsCurrency + CdMovimiento.FieldByName('CHEQUE_CR').AsCurrency;
            if CdMovimiento.FieldByName('ORIGEN_MOVIMIENTO').AsInteger in [2,4] then
               _cAhorros := _cAhorros + (_cEntrada - _cSalida)
            else
                _cAportes := _cAportes + (_cEntrada - _cSalida);
            if _cEntrada > 0 then
            begin
              Auxiliar(_ibConsulta1,_iConsecutivo,_sCodigo,0,_cEntrada);
            end;
            if _cSalida > 0 then
            begin
              Auxiliar(_ibConsulta1,_iConsecutivo,_sCodigo,_cSalida,0);
            end;
//// Ref¿gistrar otros descuentos
            _ibSQL1.Close;
            if _ibSQL1.Transaction.InTransaction then
               _ibSQL1.Transaction.Rollback;
            _ibSQL1.Transaction.StartTransaction;
            _ibSQL1.SQL.Clear;
            _ibSQL1.SQL.Add('select * from "caj$conadicional" where CODIGO = :CODIGO');
            _ibSQL1.ParamByName('CODIGO').AsString := _sCodigo;
            _ibSQL1.ExecQuery;
            while not _ibSQL1.Eof do
            begin
              if _ibSQL1.FieldByName('TOMAR_VALOR').AsString = 'E' then
              begin
                 _cValorTasa:= SimpleRoundTo(_ibSQL1.FieldByName('TASA').AsFloat*_cEntrada,0);
                 _cValorValor := _ibSQL1.FieldByName('VALOR').AsCurrency;
                 _cValorVeces := _ibSQL1.FieldByName('VECES').AsInteger * _cEntrada;
              end
              else
              begin
                 _cValorTasa:= SimpleRoundTo(_ibSQL1.FieldByName('TASA').AsFloat*_cSalida,0);
                 _cValorValor := _ibSQL1.FieldByName('VALOR').AsCurrency;
                 _cValorVeces := _ibSQL1.FieldByName('VECES').AsInteger * _cSalida;
              end;
              if _cValorTasa > 0 then
              begin
                Auxiliar(_ibConsulta1,_iConsecutivo,_ibSQL1.FieldByName('CODIGO_D').AsString,_cValorTasa,0);
                Auxiliar(_ibConsulta1,_iConsecutivo,_ibSQL1.FieldByName('CODIGO_C').AsString,0,_cValorTasa);
              end;
              if _cValorVeces > 0 then
              begin
                Auxiliar(_ibConsulta1,_iConsecutivo,_ibSQL1.FieldByName('CODIGO_D').AsString,_cValorVeces,0);
                Auxiliar(_ibConsulta1,_iConsecutivo,_ibSQL1.FieldByName('CODIGO_C').AsString,0,_cValorVeces);
              end;
              if _cValorValor > 0 then
              begin
                Auxiliar(_ibConsulta1,_iConsecutivo,_ibSQL1.FieldByName('CODIGO_D').AsString,_cValorValor,0);
                Auxiliar(_ibConsulta1,_iConsecutivo,_ibSQL1.FieldByName('CODIGO_C').AsString,0,_cValorValor);
              end;
              _ibSQL1.Next;
            end;
            CdMovimiento.Next;
          end;// fin del While de Movimiento,

          if _cAportes > 0 then
          begin
             Auxiliar(_ibConsulta1,_iConsecutivo,CodigoSucursal(_ibConsulta1,CdMovimiento.FieldByName('ID_AGENCIA').AsInteger,1),_cAportes,0);
          end;
          if _cAportes < 0 then
          begin
             Auxiliar(_ibConsulta1,_iConsecutivo,CodigoSucursal(_ibConsulta1,CdMovimiento.FieldByName('ID_AGENCIA').AsInteger,1),0,-_cAportes);
          end;
          if _cAhorros > 0 then
          begin
             Auxiliar(_ibConsulta1,_iConsecutivo,CodigoSucursal(_ibConsulta1,CdMovimiento.FieldByName('ID_AGENCIA').AsInteger,2),_cAhorros,0);
          end;
          if _cAhorros < 0 then
          begin
             Auxiliar(_ibConsulta1,_iConsecutivo,CodigoSucursal(_ibConsulta1,CdMovimiento.FieldByName('ID_AGENCIA').AsInteger,2),0,-_cAhorros);
          end;
          _ibConsulta1.Close;
          _ibConsulta1.SQL.Clear;
          _ibConsulta1.SQL.Add('SELECT SUM(DEBITO) AS DEBITO,SUM(CREDITO) AS  CREDITO FROM "con$auxiliar"');
          _ibConsulta1.SQL.Add('WHERE ID_AGENCIA = :AGENCIA and ID_COMPROBANTE = :COMPROBANTE');
          _ibConsulta1.ParamByName('AGENCIA').AsInteger := _iAgencia;
          _ibConsulta1.ParamByName('COMPROBANTE').AsInteger := _iConsecutivo;
          _ibConsulta1.Open;
          _cTotalDebito := _ibConsulta1.FieldByName('DEBITO').AsCurrency;
          _cTotalCredito := _ibConsulta1.FieldByName('CREDITO').AsCurrency;
          _ibConsulta1.Close;
          Comprobante(_ibConsulta1,FieldByName('DESCRIPCION_AGENCIA').AsString,_cTotalDebito,_cTotalCredito,_iConsecutivo);
       end;// Fin del Valida si hay movimientos en la agencia

        Next; // fin del next de la agencia
      end;// fin del while de la agencia

    end;// Fin de la validacion del si existen Movimientos
  Close;
  SQL.Clear;
  SQL.Add('SELECT * FROM "caj$cierresucursal" WHERE FECHA = :FECHA');
  ParamByName('FECHA').AsDate := _dFechaActual;
  Open;
  if RecordCount = 0 then
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO');
    SQL.Add('"caj$cierresucursal"(');
    SQL.Add('ID_CAJA,');
    SQL.Add('FECHA,');
    SQL.Add('CONTABILIZADO,');
    SQL.Add('ES_MOVIMIENTO)');
    SQL.Add('VALUES(25,:FECHA,:MOV,:CONT)');
    if _bHayMovimiento then
    begin
      ParamByName('MOV').AsInteger := 1;
      ParamByName('CONT').AsInteger := 1;
    end
    else
    begin
      ParamByName('MOV').AsInteger := 0;
      ParamByName('CONT').AsInteger := 0;
    end;
  end
  else
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE');
    SQL.Add('  "caj$cierresucursal"');
    SQL.Add('SET');
    SQL.Add('  CONTABILIZADO = 1,');
    SQL.Add('  ES_MOVIMIENTO = 1');
    SQL.Add('WHERE');
    SQL.Add('  "caj$cierresucursal".FECHA = :FECHA');
  end;
  ParamByName('FECHA').AsDate := _dFechaActual;
  ExecSQL;
  IBTransactionSuc.Commit;
  end;// Fin del IBconsulta
  //Cerrar Conexión Base de Datos
    IBDatabaseSuc.Close;
    IBTransactionSuc.Active := False;
    Close;
  // FIn COnexión Base de Datos
end;
procedure TFrmCierreSucursal.Button1Click(Sender: TObject);
begin
        CierreSucursal;
end;

function TFrmCierreSucursal.BuscaMovimiento(_ibQuery: TIBQuery):Boolean;
begin
        Result := False;
        CdMovimiento.CancelUpdates;
        CDcomision.CancelUpdates;
        with _ibQuery do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * FROM "caj$cierresucursal" WHERE FECHA = :FECHA AND CONTABILIZADO = 1');
          ParamByName('FECHA').AsDate := _dFechaActual;
          Open;
          if RecordCount > 0 then
          begin
            Exit;
          end;
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"gen$agencia".DESCRIPCION_AGENCIA,');
          SQL.Add('"caj$movremotoentrada".ID_CAJA,');
          SQL.Add('"caj$movremotoentrada".ID_TIPO_CAPTACION,');
          SQL.Add('"caj$movremotoentrada".ORIGEN_MOVIMIENTO,');
          SQL.Add('"caj$movremotoentrada".ID_TIPO_MOVIMIENTO,');
          SQL.Add('"caj$movremotoentrada".ID_AGENCIA_REMOTA,');
          SQL.Add('sum("caj$movremotoentrada".BILLETES + "caj$movremotoentrada".MONEDAS) AS EFECTIVO,');
          SQL.Add('sum("caj$movremotoentrada".CHEQUES) AS CHEQUES,');
          SQL.Add('"caj$origen".CODIGO');
          SQL.Add('FROM');
          SQL.Add('"caj$movremotoentrada"');
          SQL.Add('INNER JOIN "gen$agencia" ON ("caj$movremotoentrada".ID_AGENCIA_REMOTA = "gen$agencia".ID_AGENCIA)');
          SQL.Add('INNER JOIN "caj$origen" ON ("caj$movremotoentrada".ORIGEN_MOVIMIENTO = "caj$origen".ID_ORIGEN)');
          SQL.Add('WHERE');
          SQL.Add('"caj$movremotoentrada".FECHA_MOV BETWEEN :FECHA1 AND :FECHA2');
          SQL.Add('GROUP BY');
          SQL.Add('"gen$agencia".DESCRIPCION_AGENCIA,');
          SQL.Add('"caj$movremotoentrada".ID_CAJA,');
          SQL.Add('"caj$movremotoentrada".ID_TIPO_CAPTACION,');
          SQL.Add('"caj$movremotoentrada".ORIGEN_MOVIMIENTO,');
          SQL.Add('"caj$movremotoentrada".ID_TIPO_MOVIMIENTO,');
          SQL.Add('"caj$movremotoentrada".ID_AGENCIA_REMOTA,');
          SQL.Add('"caj$origen".CODIGO');
          ParamByName('FECHA1').AsDateTime := _dFechaActual + StrToTime('00:00:00');
          ParamByName('FECHA2').AsDateTime := _dFechaActual + StrToTime('23:59:59');
          Open;
          if RecordCount > 0 then
             Result := True;
           while not Eof do
           begin
 {            if Abs(FieldByName('ES_COMISION').AsInteger) = 1 then
             begin
               CDcomision.Append;
               CDcomision.FieldValues['agencia'] := FieldByName('ID_AGENCIA_REMOTA').AsInteger;
               CDcomision.FieldValues['comision'] := FieldByName('BILLETES').AsCurrency + FieldByName('MONEDAS').AsCurrency;
               CDcomision.Post;
            end;}
            CdMovimiento.Append;
            CdMovimiento.FieldValues['ID_AGENCIA'] := FieldByName('ID_AGENCIA_REMOTA').AsInteger;
            CdMovimiento.FieldValues['AGENCIA'] := FieldByName('DESCRIPCION_AGENCIA').AsString;
            CdMovimiento.FieldValues['ID_CAJA'] := FieldByName('ID_CAJA').AsInteger;
            CdMovimiento.FieldValues['ORIGEN_MOVIMIENTO'] := FieldByName('ORIGEN_MOVIMIENTO').AsInteger;
            CdMovimiento.FieldValues['ID_TIPO_CAPTACION'] := FieldByName('ID_TIPO_CAPTACION').AsInteger;
            CdMovimiento.FieldValues['ID_TIPO_MOVIMIENTO'] := FieldByName('ID_TIPO_MOVIMIENTO').AsInteger;
            if FieldByName('ID_TIPO_MOVIMIENTO').AsInteger = 1 then
            begin
              CdMovimiento.FieldValues['EFECTIVO_DB'] := FieldByName('EFECTIVO').AsCurrency;
              CdMovimiento.FieldValues['CHEQUE_DB'] := FieldByName('CHEQUES').AsCurrency;
              CdMovimiento.FieldValues['EFECTIVO_CR'] := 0;
              CdMovimiento.FieldValues['CHEQUE_CR'] := 0;
            end
            else
            begin
              CdMovimiento.FieldValues['EFECTIVO_CR'] := FieldByName('EFECTIVO').AsCurrency;
              CdMovimiento.FieldValues['CHEQUE_CR'] := FieldByName('CHEQUES').AsCurrency;
              CdMovimiento.FieldValues['EFECTIVO_DB'] := 0;
              CdMovimiento.FieldValues['CHEQUE_DB'] := 0;
            end;
            CdMovimiento.FieldValues['CODIGO'] := FieldByName('CODIGO').AsString;
            CdMovimiento.Post;
           Next;
         end; // fin del whiel
        end;// fin del with del query

end;

function TFrmCierreSucursal.Comprobante(_ibSQl: TIBQuery;_sDesAgencia: string;_cDebito,_cCredito:Currency;_iComprobante:Integer): Integer;
begin
        Result := 0;
        with _ibSQl do
        begin
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO "con$comprobante" VALUES(');
          SQL.Add(':ID_COMPROBANTE,:ID_AGENCIA,:TIPO_COMPROBANTE,:FECHADIA,');
          SQL.Add(':DESCRIPCION,:TOTAL_DEBITO,:TOTAL_CREDITO,:ESTADO,:IMPRESO,');
          SQL.Add(':ANULACION,:ID_EMPLEADO)');
          ParamByName('ID_COMPROBANTE').AsInteger := _iComprobante;
          ParamByName('ID_AGENCIA').AsInteger := _iAgencia;
          ParamByName('TIPO_COMPROBANTE').AsInteger := 1;
          ParamByName('FECHADIA').AsDate := _dFechaActual;
          ParamByName('DESCRIPCION').AsString := 'Contabilización de Movimientos de la Agencia  ' + _sDesAgencia + ', CAJA 25, Fecha: ' + DatetoStr(_dFechaActual);
          ParamByName('TOTAL_DEBITO').AsCurrency := _cDebito;
          ParamByName('TOTAL_CREDITO').AsCurrency := _cCredito;
          ParamByName('ESTADO').AsString := 'O';
          ParamByName('IMPRESO').AsInteger := 0;
          ParamByName('ANULACION').Clear;
          ParamByName('ID_EMPLEADO').AsString := 'SUCURSAL';
          ExecSQL;
          Transaction.CommitRetaining;
        end;// FIN IBSQL3

end;
function TFrmCierreSucursal.ObtenerConsecutivo(IBSQL1:TIBSQL): LongInt;
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


procedure TFrmCierreSucursal.Auxiliar(_ibQuery: TIBQuery;_iConsecutivo:Integer; _sCodigo: String;
  _cDebito, _cCredito: Currency);
begin
        with _ibQuery do
        begin
          Close;
          SQL.Clear;
          SQL.Add('Insert Into "con$auxiliar"');
          SQL.Add('Values(:ID_COMPROBANTE,:ID_AGENCIA,:FECHA,');
          SQL.Add(':CODIGO,:DEBITO,:CREDITO,:ID_CUENTA,');
          SQL.Add(':ID_COLOCACION,:ID_IDENTIFICACION,');
          SQL.Add(':ID_PERSONA,:MONTO_RETENCION,:TASA_RETENCION,:ESTADOAUX)');
          ParamByName('ID_COMPROBANTE').AsInteger := _iConsecutivo;
          ParamByName('ID_AGENCIA').AsInteger := _iAgencia;
          ParamByName('FECHA').AsDate := _dFechaActual;
          ParamByName('CODIGO').AsString := _sCodigo;
          ParamByName('DEBITO').AsCurrency := _cDebito;
          ParamByName('CREDITO').AsCurrency := _cCredito;
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          ExecSQL;
          Transaction.CommitRetaining;
        end;

end;

function TFrmCierreSucursal.CodigoSucursal(_ibQuery: TIBQuery;
  _iAgenciaRemota, _iOrigen: Integer): string;
begin
        with _ibQuery do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"caj$origensucursal".CODIGO');
          SQL.Add('FROM');
          SQL.Add('"caj$origensucursal"');
          SQL.Add('WHERE');
          SQL.Add('("caj$origensucursal".ID_ORIGEN = :ID_ORIGEN) AND ');
          SQL.Add('("caj$origensucursal".ID_AGENCIA = :ID_AGENCIA)');
          ParamByName('ID_ORIGEN').AsInteger := _iOrigen;
          ParamByName('ID_AGENCIA').AsInteger := _iAgenciaRemota;
          Open;
          Result := FieldByName('CODIGO').AsString;
        end;
end;

procedure TFrmCierreSucursal.ControlCierre(_ibCon: TIBQuery);
begin
        with _ibCon do
        begin
          Close;
        end;
end;

procedure TFrmCierreSucursal.FormShow(Sender: TObject);
begin
        CierreSucursal
end;

end.
