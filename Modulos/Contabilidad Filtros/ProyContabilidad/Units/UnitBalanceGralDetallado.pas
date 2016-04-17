unit UnitBalanceGralDetallado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ComCtrls, ExtCtrls, DB, StrUtils,
  IBCustomDataSet, IBQuery, pr_Common, pr_TxClasses, IBSQL, FR_Class,
  frOLEExl, FR_DSet, FR_DBSet,JclDateTime, JvComponent, JvProgressDlg;

type
  TfrmBalanceGralDetallado = class(TForm)
    Panel1: TPanel;
    IBQSaldoAct: TIBQuery;
    IBQTabla: TIBQuery;
    IBQuery1: TIBQuery;
    IBQPuc: TIBQuery;
    IBQSaldoActDEBITO: TIBBCDField;
    IBQSaldoActCREDITO: TIBBCDField;
    ReportBalanceDet: TprTxReport;
    Reporte: TprTxReport;
    frDBDataSet1: TfrDBDataSet;
    frOLEExcelExport1: TfrOLEExcelExport;
    frReport1: TfrReport;
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    EdCodigoInicial: TMaskEdit;
    EdCodigoFinal: TMaskEdit;
    GroupBox3: TGroupBox;
    CBNivel: TComboBox;
    EdAno: TMaskEdit;
    CBMeses: TComboBox;
    CmdAceptar: TBitBtn;
    CmdCerrar: TBitBtn;
    JvProgreso: TJvProgressDlg;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CmdCerrarClick(Sender: TObject);
    procedure CmdAceptarClick(Sender: TObject);
    procedure CBMesesExit(Sender: TObject);
    procedure CBNivelExit(Sender: TObject);
    procedure EdCodigoInicialExit(Sender: TObject);
    procedure CBMesesKeyPress(Sender: TObject; var Key: Char);
    procedure CBNivelKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodigoInicialKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodigoFinalKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodigoFinalExit(Sender: TObject);
    procedure EdAnoKeyPress(Sender: TObject; var Key: Char);
    procedure EdAnoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    function Empleado : String;
    procedure Inicializar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBalanceGralDetallado: TfrmBalanceGralDetallado;
  Mes           : String;
  MesCorte      : String;
  NomMes        : String;
  Cadena        : String;
  CodigoInicial : String;
  Codigofinal   : String;
  Nivel         : Integer;
  AnoCorte      : Integer;
  NivelCodigo   : Integer;

implementation

uses  unitdmgeneral, unitglobales;
{$R *.dfm}

procedure TfrmBalanceGralDetallado.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        if IBQPuc.Transaction.InTransaction then
          IBQPuc.Transaction.Commit;
        Action := caFree;
end;

procedure TfrmBalanceGralDetallado.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmBalanceGralDetallado.CmdAceptarClick(Sender: TObject);
var
Tabla:String;
SaldoAnterior:Currency;
_cDebitoAnt :Currency;
_cCreditoAnt :Currency;
_cDebitoMov :Currency;
_cCreditoMov :Currency;
SumDebito,SumCredito:Currency;
Total:Integer;
begin
       if CBMeses.ItemIndex = -1 then
       begin
         CBMeses.SetFocus;
         ShowMessage('Debe seleccionar un Mes');
         Exit;
       end;
       SaldoAnterior := 0;
       SumDebito := 0;
       SumCredito := 0;
       with IBQSaldoAct do
        Begin
          if Transaction.InTransaction then
             Transaction.Rollback;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('select ');
          SQL.Add('"con$saldoscuenta".DEBITO,');
          SQL.Add('"con$saldoscuenta".CREDITO');
          SQL.Add(' from "con$puc" ');
          SQL.Add('LEFT JOIN "con$saldoscuenta" ON ("con$puc".CODIGO = "con$saldoscuenta".CODIGO and "con$puc".ID_AGENCIA = "con$saldoscuenta".ID_AGENCIA)');
          SQL.Add('where ');
          SQL.Add('("con$saldoscuenta".ID_AGENCIA = :ID_AGENCIA) and ("con$saldoscuenta".CODIGO = :"CODIGO") and ');
          SQL.Add('("con$saldoscuenta".MES = :"MES")');
        end;
       Empleado;
       with IBQPuc do
        begin
          SQL.Clear;
          SQL.Add('select ');
          SQL.Add('Count(*) as TOTAL');
          SQL.Add(' from "con$puc" ');
          SQL.Add('where ');
          SQL.Add('("con$puc".ID_AGENCIA = :ID_AGENCIA) and ("con$puc".CODIGO BETWEEN :"CODIGO_INICIAL" and :"CODIGO_FINAL") and');
          SQL.Add('("con$puc".NIVEL <= :"NIVEL")');
          ParamByName('ID_AGENCIA').AsInteger := Agencia;
          ParamByName('CODIGO_INICIAL').AsString := CodigoInicial;
          ParamByName('CODIGO_FINAL').AsString := CodigoFinal;
          ParamByName('NIVEL').AsInteger := Nivel;
          Open;
          Total := FieldByName('TOTAL').AsInteger;
        end;


       with IBQPuc do
        Begin
          SQL.Clear;
          SQL.Add('select ');
          SQL.Add('"con$puc".CODIGO,');
          SQL.Add('"con$puc".ID_AGENCIA,');
          SQL.Add('"con$puc".NOMBRE,');
          SQL.Add('"con$puc".NIVEL,');
          SQL.Add('"con$puc".SALDOINICIAL,');
          SQL.Add('"gen$agencia".DESCRIPCION_AGENCIA');
          SQL.Add(' from "con$puc" ');
          SQL.Add('LEFT JOIN "gen$agencia" ON ("con$puc".ID_AGENCIA = "gen$agencia".ID_AGENCIA)');
          SQL.Add('where ');
          SQL.Add('("con$puc".ID_AGENCIA = :ID_AGENCIA) and ("con$puc".CODIGO BETWEEN :"CODIGO_INICIAL" and :"CODIGO_FINAL") and');
          SQL.Add('("con$puc".NIVEL <= :"NIVEL")');
          SQL.Add('order by "con$puc".CODIGO');

          ParamByName('ID_AGENCIA').AsInteger := Agencia;
          ParamByName('CODIGO_INICIAL').AsString := CodigoInicial;
          ParamByName('CODIGO_FINAL').AsString := CodigoFinal;
          ParamByName('NIVEL').AsInteger := Nivel;
          Open;
       end;

          IBQPuc.Last;
          IBQPuc.First;

          Tabla := '"BalanceDet' + FloatToStr(Now)+ '"';
           with IBQTabla do
            begin
              SQL.Clear;
              SQL.Add('create table ' + Tabla + ' (');
              SQL.Add('CODIGO              CHAR(18),');
              SQL.Add('NOMBRE              CHAR(100),');
              SQL.Add('NIVEL               INTEGER,');
              SQL.Add('DESCRIPCION_AGENCIA CHAR(50), ');
              SQL.Add('DEBITOANT           NUMERICO,');
              SQL.Add('CREDITOANT          NUMERICO,');
              SQL.Add('DEBITOMOV           NUMERICO,');
              SQL.Add('CREDITOMOV          NUMERICO,');
              //*** CAMPOS NUEVOS PAA VALIDACION
              SQL.Add('DEBITOACT           NUMERICO,');
              SQL.Add('CREDITOACT          NUMERICO)');
              ExecSQL;
              Transaction.CommitRetaining;
              Close;


              SQL.Clear;
              SQL.Add('insert into ' + Tabla + 'values(');
              SQL.Add(':"CODIGO",');
              SQL.Add(':"NOMBRE",');
              SQL.Add(':NIVEL,');
              SQL.Add(':DESCRIPCION_AGENCIA,');
              SQL.Add(':"DEBITOANT",');
              SQL.Add(':"CREDITOANT",');
              SQL.Add(':"DEBITOMOV",');
              SQL.Add(':"CREDITOMOV",:"DEBITOACT",:"CREDITOACT")');
              JvProgreso.Maximum := Total;
              JvProgreso.Show;
              While (not IBQPuc.Eof)  do
               begin
                 JvProgreso.Value := IBQPuc.RecNo;
                 JvProgreso.Text := IBQPuc.FieldByName('CODIGO').AsString;
                 Application.ProcessMessages;
                 IBQSaldoAct.Close;
                 IBQSaldoAct.ParamByName('ID_AGENCIA').AsInteger := Agencia;
                 IBQSaldoAct.ParamByName('CODIGO').AsString  := IBQPuc.FieldByName('CODIGO').AsString;
                 IBQSaldoAct.ParamByName('MES').AsInteger := StrToInt(Mes);
                 try
                  IBQSaldoAct.Open;
                 except
                  JvProgreso.Close;
                  Transaction.Rollback;
                  raise;
                  Exit;
                 end;
                 ParamByName('CODIGO').AsString := LeftStr(IBQPuc.FieldByName('CODIGO').AsString,NivelCodigo);
                 ParamByName('NOMBRE').AsString := IBQPuc.FieldByName('NOMBRE').AsString;
                 ParamByName('NIVEL').AsInteger := IBQPuc.FieldByName('NIVEL').AsInteger;
                 ParamByName('DESCRIPCION_AGENCIA').AsString := IBQPuc.FieldByName('DESCRIPCION_AGENCIA').AsString;

                 IBQuery1.Close;
                 IBQuery1.SQL.Clear;
                 IBQuery1.SQL.Add('select ');
                 IBQuery1.SQL.Add('SUM("con$saldoscuenta".DEBITO) AS DEBITO,');
                 IBQuery1.SQL.Add('SUM("con$saldoscuenta".CREDITO) AS CREDITO');
                 IBQuery1.SQL.Add(' from "con$saldoscuenta" ');
                 IBQuery1.SQL.Add('where ');
                 IBQuery1.SQL.Add('("con$saldoscuenta".ID_AGENCIA = :ID_AGENCIA) and ("con$saldoscuenta".CODIGO = :"CODIGO") and ');
                 IBQuery1.SQL.Add('("con$saldoscuenta".MES < :"MES")');
                 IBQuery1.ParamByName('ID_AGENCIA').AsInteger := Agencia;
                 IBQuery1.ParamByName('CODIGO').AsString := IBQPuc.FieldByName('CODIGO').AsString;
                 IBQuery1.ParamByName('MES').AsInteger := StrToInt(Mes);
                 try
                   IBQuery1.Open;
                   if IBQuery1.RecordCount > 0 then
                   begin
                      SumDebito := IBQuery1.FieldByName('DEBITO').AsCurrency;
                      SumCredito := IBQuery1.FieldByName('CREDITO').AsCurrency;
                   end
                   else
                   begin
                      SumDebito := 0;
                      SumCredito := 0;
                   end;
                 except
                      SumDebito := 0;
                      SumCredito := 0;
                 end;

                 SaldoAnterior := IBQPuc.FieldByName('SALDOINICIAL').AsCurrency + SumDebito - SumCredito;
                 if SaldoAnterior > 0 then
                  begin
                    ParamByName('DEBITOANT').AsCurrency := SaldoAnterior;
                    ParamByName('CREDITOANT').AsCurrency := 0;
                    _cDebitoAnt := SaldoAnterior;
                    _cCreditoAnt := 0;
                  end;
                 if SaldoAnterior < 0 then
                  begin
                    ParamByName('CREDITOANT').AsCurrency := SaldoAnterior * -1;
                    ParamByName('DEBITOANT').AsCurrency := 0;
                    _cDebitoAnt := 0;
                    _cCreditoAnt := -SaldoAnterior;
                  end;
                 if SaldoAnterior = 0 then
                  begin
                    ParamByName('DEBITOANT').AsCurrency := 0;
                    ParamByName('CREDITOANT').AsCurrency := 0;
                    _cDebitoAnt := 0;
                    _cCreditoAnt := 0;
                  end;
                 ParamByName('DEBITOMOV').AsCurrency := IBQSaldoAct.FieldByName('DEBITO').AsCurrency;
                 _cDebitoMov := IBQSaldoAct.FieldByName('DEBITO').AsCurrency;
                 ParamByName('CREDITOMOV').AsCurrency := IBQSaldoAct.FieldByName('CREDITO').AsCurrency;
                 _cCreditoMov := IBQSaldoAct.FieldByName('CREDITO').AsCurrency;
                 //**** VALIDACION PARA LOS SALDOS ACTUALES DEL BALANCE
                 if ((_cDebitoAnt + _cDebitoMov) - (_cCreditoAnt + _cCreditoMov)) > 0 then
                 begin
                    ParamByName('DEBITOACT').AsCurrency := ((_cDebitoAnt + _cDebitoMov) - (_cCreditoAnt + _cCreditoMov));
                    ParamByName('CREDITOACT').AsCurrency := 0;
                 end
                 else
                 begin
                    ParamByName('DEBITOACT').AsCurrency := 0;
                    ParamByName('CREDITOACT').AsCurrency := -((_cDebitoAnt + _cDebitoMov) - (_cCreditoAnt + _cCreditoMov));
                 end;

                 //***

                 ExecSql;
                 IBQPuc.Next;
                end;

              IBQPuc.Close;
              JvProgreso.Close;

              SQL.Clear;
              SQL.Add('select ');
              SQL.Add('CODIGO,');
              SQL.Add('NOMBRE,');
              SQL.Add('NIVEL,');
              SQL.Add('DESCRIPCION_AGENCIA,');
              SQL.Add('DEBITOANT,');
              SQL.Add('CREDITOANT,');
              SQL.Add('DEBITOMOV,');
              SQL.Add('CREDITOMOV,DEBITOACT,CREDITOACT');
              SQL.Add('from ' + Tabla + ' ');
              SQL.Add('where ');
              SQL.Add('(CODIGO BETWEEN :"CODIGOINICIAL" and');
              SQL.Add(':"CODIGOFINAL") and');
              SQL.Add('(DEBITOANT>0 or CREDITOANT>0 or');
              SQL.Add('DEBITOMOV>0 or CREDITOMOV>0)');

              ParamByName('CODIGOINICIAL').AsString := CodigoInicial;
              ParamByName('CODIGOFINAL').AsString := CodigoFinal;
              Open;
              begin
                  //*** Fast Report
             frReport1.LoadFromFile(_sRuta + 'Reportes\RepBalanceDetallado.frf');
             frReport1.ShowReport;

              end;
              IBQTabla.Close;

              Transaction.Commit;
              With IBQTabla do
              begin
              Transaction.StartTransaction;
              Close;
              SQL.Clear;
              SQL.Add('drop table ' + Tabla);
              ExecSQL;
              IBQTabla.Close;
              Transaction.Commit;
              end;

            end; // Fin With IBQTabla

end;

procedure TfrmBalanceGralDetallado.CBMesesExit(Sender: TObject);
begin
        With CBMeses do
         case ItemIndex of
           0: begin
                Mes := '01';
                MesCorte := '00';
                AnoCorte := AnoCorte - 1;
                NomMes := 'Enero';
              end;
           1: begin
                Mes := '02';
                MesCorte := '01';
                NomMes := 'Febrero';
              end;
           2: begin
                Mes := '03';
                MesCorte := '02';
                NomMes := 'Marzo';
              end;
           3: begin
                Mes := '04';
                MesCorte := '03';
                NomMes := 'Abril';
              end;
           4: begin
                Mes := '05';
                MesCorte := '04';
                NomMes := 'Mayo';
              end;
           5: begin
                Mes := '06';
                MesCorte := '05';
                NomMes := 'Junio';
              end;
           6: begin
                Mes := '07';
                MesCorte := '06';
                NomMes := 'Julio';
              end;
           7: begin
                Mes := '08';
                MesCorte := '07';
                NomMes := 'Agosto';
              end;
           8: begin
                Mes := '09';
                MesCorte := '08';
                NomMes := 'Septiembre';
              end;
           9: begin
                Mes := '10';
                MesCorte := '09';
                NomMes := 'Octubre';
              end;
          10: begin
                Mes := '11';
                MesCorte := '10';
                NomMes := 'Noviembre';
              end;
          11: begin
                Mes := '12';
                MesCorte := '11';
                NomMes := 'Diciembre';
              end;
         end;
end;

procedure TfrmBalanceGralDetallado.CBNivelExit(Sender: TObject);
begin
        With CBNivel do
         case ItemIndex of
           0: begin
                Nivel := 1;
                NivelCodigo := 1;
              end;
           1: begin
                Nivel := 2;
                NivelCodigo := 2;
              end;
           2: begin
                Nivel := 3;
                NivelCodigo := 4;
              end;
           3..10: begin
                Nivel := ItemIndex + 1;
                NivelCodigo := ItemIndex * 2;
              end;
         end;
end;

procedure TfrmBalanceGralDetallado.EdCodigoInicialExit(Sender: TObject);
begin
        Cadena := EdCodigoInicial.Text;
        while Pos(' ',Cadena) > 0 do
        Cadena[Pos(' ',Cadena)] := '0';
        CodigoInicial := Cadena;
end;

procedure TfrmBalanceGralDetallado.CBMesesKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmBalanceGralDetallado.CBNivelKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmBalanceGralDetallado.EdCodigoInicialKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmBalanceGralDetallado.EdCodigoFinalKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmBalanceGralDetallado.EdCodigoFinalExit(Sender: TObject);
begin
        Cadena := EdCodigoFinal.Text;
        while Pos(' ',Cadena) > 0 do
        Cadena[Pos(' ',Cadena)] := '0';
        CodigoFinal := Cadena;
end;

procedure TfrmBalanceGralDetallado.EdAnoKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmBalanceGralDetallado.EdAnoExit(Sender: TObject);
begin
        if EdAno.Text <> '' then
           AnoCorte := StrToInt(EdAno.Text)
        else
           MessageDlg('Debe Digitar el Año',mtError,[mbOK],0);
end;

function TfrmBalanceGralDetallado.Empleado;
begin
        with IBQuery1 do
         begin
           sql.Clear;
           sql.Add('select PRIMER_APELLIDO, SEGUNDO_APELLIDO, NOMBRE from "gen$empleado"');
           sql.Add('where "gen$empleado"."ID_EMPLEADO" =:"ID_EMPLEADO"');
           ParamByName('ID_EMPLEADO').AsString := DBAlias;
           Open;
           Result := FieldByName('NOMBRE').AsString + ' ' + FieldByname('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
         end;
end;

procedure TfrmBalanceGralDetallado.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmBalanceGralDetallado.Inicializar;
begin
      EdAno.Text := IntToStr(Yearofdate(Date));
      CBMeses.ItemIndex := -1;
      with IBQPuc do begin
        if Transaction.InTransaction then
           Transaction.Rollback;
        Transaction.StartTransaction;
      end;

end;

procedure TfrmBalanceGralDetallado.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'EMPRESA' then
           ParValue := Empresa;
        if ParName = 'NIT' then
           ParValue := Nit;
        if ParName = 'FECHA' then
           ParValue := CBMeses.Text + ' - ' + EdAno.Text;
        if ParName = 'NIVEL' then
           ParValue := CBNivel.Text;

end;

end.

