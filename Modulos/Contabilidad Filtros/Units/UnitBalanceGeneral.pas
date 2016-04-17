unit UnitBalanceGeneral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, DB, IBCustomDataSet, IBQuery,
  IBSQL, pr_Common, pr_TxClasses, StrUtils, DBClient, FR_DSet, FR_DBSet,
  FR_Class, ComCtrls,JclDateTime, frOLEExl;

type
  TfrmBalanceGeneral = class(TForm)
    IBQPuc: TIBQuery;
    IBQSaldoAct: TIBQuery;
    IBQuery1: TIBQuery;
    IBQTabla: TClientDataSet;
    IBQTablaCODIGO: TStringField;
    IBQTablaNOMBRE: TStringField;
    IBQTablaDEBITOANT: TCurrencyField;
    IBQTablaCREDITOANT: TCurrencyField;
    IBQTablaDEBITOMOV: TCurrencyField;
    IBQTablaCREDITOMOV: TCurrencyField;
    IBQTabla1: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    CurrencyField1: TCurrencyField;
    CurrencyField2: TCurrencyField;
    CurrencyField3: TCurrencyField;
    CurrencyField4: TCurrencyField;
    IBQSaldoAnt: TIBQuery;
    IBQTablaDESCRIPCION_AGENCIA: TStringField;
    frReport1: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    frDBDataSet2: TfrDBDataSet;
    IBQTablaDEBITOACT: TCurrencyField;
    IBQTablaCREDITOACT: TCurrencyField;
    IBQTabla1DEBITOACT: TCurrencyField;
    IBQTabla1CREDITOACT: TCurrencyField;
    Panel3: TPanel;
    Panel4: TPanel;
    CmdAceptar: TBitBtn;
    CmdCerrar: TBitBtn;
    frOLEExcelExport1: TfrOLEExcelExport;
    IBQTablaTIPO: TIntegerField;
    GroupBox1: TGroupBox;
    CBMeses: TComboBox;
    EdAno: TMaskEdit;
    CbTipo: TComboBox;
    procedure CBMesesExit(Sender: TObject);
    procedure CBMesesKeyPress(Sender: TObject; var Key: Char);
    procedure EdAnoExit(Sender: TObject);
    procedure EdAnoKeyPress(Sender: TObject; var Key: Char);
    procedure CmdCerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CmdAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure FormShow(Sender: TObject);
  private
    function Empleado:String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBalanceGeneral: TfrmBalanceGeneral;
  Mes : String;
  MesCorte : String;
  NomMes : String;
  AnoCorte : Integer;
  CodigoInicial : String;
  CodigoFinal   : String;
implementation

{$R *.dfm}

uses UnitDmGeneral, UnitGlobales;

procedure TfrmBalanceGeneral.CBMesesExit(Sender: TObject);
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

procedure TfrmBalanceGeneral.CBMesesKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmBalanceGeneral.EdAnoExit(Sender: TObject);
begin
        AnoCorte := StrToInt(EdAno.Text);
end;

procedure TfrmBalanceGeneral.EdAnoKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmBalanceGeneral.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmBalanceGeneral.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        Action := CaFree;
end;

procedure TfrmBalanceGeneral.CmdAceptarClick(Sender: TObject);
var
Tabla:String;
SaldoAnterior:Currency;
//Variables necesarias para la creacion de reporte en fast Report
_cDebitoAnt :Currency;
_cCreditoAnt :Currency;
_cDebitoMov :Currency;
_cCreditoMov :Currency;
begin
       if CBMeses.ItemIndex = -1 then
       begin
         CBMeses.SetFocus;
         ShowMessage('Debe seleccionar un Mes de Corte');
         Exit;
       end;
       IBQTabla.CancelUpdates;
       IBQTabla1.CancelUpdates;       
       if dmGeneral.IBTransaction1.InTransaction then
          dmGeneral.IBTransaction1.Rollback;
       dmGeneral.IBTransaction1.StartTransaction;
       Empleado;
       with IBQPuc do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('select ');
          SQL.Add('"con$puc".CODIGO,');
          SQL.Add('"con$puc".ID_AGENCIA,');
          SQL.Add('"con$puc".NOMBRE,');
          SQL.Add('"con$puc".SALDOINICIAL,');
          SQL.Add('"gen$agencia".DESCRIPCION_AGENCIA');
          SQL.Add(' from "con$puc" ');
          SQL.Add('LEFT JOIN "gen$agencia" ON ("con$puc".ID_AGENCIA = "gen$agencia".ID_AGENCIA)');
          SQL.Add('where ');
          SQL.Add('("con$puc".ID_AGENCIA = :ID_AGENCIA) and');
          SQL.Add('("con$puc".NIVEL = :"NIVEL")');
          //**
          //SQL.Add('AND "con$puc".CODIGO LIKE :COD');
          //ParamByName('COD').AsString := '1330%';
          //**
          SQL.Add('order by "con$puc".CODIGO');
          ParamByName('ID_AGENCIA').AsInteger := Agencia;
          ParamByName('NIVEL').AsInteger := 3;
          Open;
       end;

       with IBQSaldoAnt do
        Begin
          SQL.Clear;
          SQL.Add('select ');
          SQL.Add('"con$puc".CODIGO,');
          SQL.Add('SUM("con$saldoscuenta".DEBITO) AS DEBITO,');
          SQL.Add('SUM("con$saldoscuenta".CREDITO) AS CREDITO');
          SQL.Add(' from "con$puc" ');
          SQL.Add('LEFT JOIN "con$saldoscuenta" ON ("con$puc".CODIGO = "con$saldoscuenta".CODIGO and "con$puc".ID_AGENCIA = "con$saldoscuenta".ID_AGENCIA)');
          SQL.Add('where ');
          SQL.Add('"con$puc".ID_AGENCIA = :ID_AGENCIA and');
          SQL.Add('("con$puc".CODIGO = :"CODIGO") and');
          SQL.Add('("con$saldoscuenta".MES <= :"MES")');
          SQL.Add('GROUP BY "con$puc".CODIGO');

          ParamByName('ID_AGENCIA').AsInteger := Agencia;
          ParamByName('MES').AsInteger := StrToInt(MesCorte);
         end;

       with IBQSaldoAct do
        Begin
          SQL.Clear;
          SQL.Add('select ');
          SQL.Add('"con$puc".CODIGO,');
          SQL.Add('"con$saldoscuenta".DEBITO,');
          SQL.Add('"con$saldoscuenta".CREDITO');
          SQL.Add(' from "con$puc" ');
          SQL.Add('LEFT JOIN "con$saldoscuenta" ON ("con$puc".CODIGO = "con$saldoscuenta".CODIGO and "con$puc".ID_AGENCIA = "con$saldoscuenta".ID_AGENCIA)');
          SQL.Add('where ');
          SQL.Add('"con$puc".ID_AGENCIA = :ID_AGENCIA and');
          SQL.Add('("con$puc".CODIGO = :"CODIGO") and');
          SQL.Add('("con$saldoscuenta".MES = :"MES")');

          ParamByName('ID_AGENCIA').AsInteger := Agencia;
          ParamByName('MES').AsInteger := StrToInt(Mes);
         end;

           with IBQTabla do
            begin
              While (not IBQPuc.Eof) do
               begin
                 Open;
                 Insert;
                 IBQSaldoAnt.ParamByName('CODIGO').AsString := IBQPuc.FieldByName('CODIGO').AsString;
                 IBQSaldoAnt.Open;
                 IBQSaldoAct.ParamByName('CODIGO').AsString := IBQPuc.FieldByName('CODIGO').AsString;
                 IBQSaldoAct.Open;
                 FieldByName('CODIGO').AsString := LeftStr(IBQPuc.FieldByName('CODIGO').AsString,4);
                 if (StrToInt(LeftStr(IBQPuc.FieldByName('CODIGO').AsString,1)) >= 8) then
                   FieldByName('TIPO').AsInteger := 2
                 else
                   FieldByName('TIPO').AsInteger := 1;
                 FieldByName('NOMBRE').AsString := IBQPuc.FieldByName('NOMBRE').AsString;
                 //**

                 //**
                 SaldoAnterior := IBQPuc.FieldByName('SALDOINICIAL').AsCurrency + IBQSaldoAnt.FieldByName('DEBITO').AsCurrency - IBQSaldoAnt.FieldByName('CREDITO').AsCurrency;
                 if SaldoAnterior > 0 then
                  begin
                    FieldByName('DEBITOANT').AsCurrency := SaldoAnterior;
                    FieldByName('CREDITOANT').AsCurrency := 0;
                    _cDebitoAnt := SaldoAnterior;
                    _cCreditoAnt := 0;
                  end
                 else
                  begin
                    FieldByName('DEBITOANT').AsCurrency := 0;
                    FieldByName('CREDITOANT').AsCurrency := -SaldoAnterior;
                    _cDebitoAnt := 0;
                    _cCreditoAnt := -SaldoAnterior;

                  end;
                 FieldByName('DEBITOMOV').AsCurrency := IBQSaldoAct.FieldByName('DEBITO').AsCurrency;
                 _cDebitoMov := IBQSaldoAct.FieldByName('DEBITO').AsCurrency;
                 FieldByName('CREDITOMOV').AsCurrency := IBQSaldoAct.FieldByName('CREDITO').AsCurrency;
                 _cCreditoMov := IBQSaldoAct.FieldByName('CREDITO').AsCurrency;
                 FieldByName('DESCRIPCION_AGENCIA').AsString := IBQPuc.FieldByName('DESCRIPCION_AGENCIA').AsString;
                 if ((_cDebitoAnt + _cDebitoMov) - (_cCreditoAnt + _cCreditoMov)) > 0 then
                 begin
                    FieldByName('DEBITOACT').AsCurrency := ((_cDebitoAnt + _cDebitoMov) - (_cCreditoAnt + _cCreditoMov));
                    FieldByName('CREDITOACT').AsCurrency := 0;
                 end
                 else
                 begin
                    FieldByName('DEBITOACT').AsCurrency := 0;
                    FieldByName('CREDITOACT').AsCurrency := -((_cDebitoAnt + _cDebitoMov) - (_cCreditoAnt + _cCreditoMov));
                 end;
                 Post;
                 Close;

                 IBQSaldoAnt.Close;
                 IBQSaldoAct.Close;
                 IBQPuc.Next;

               end;
             end;

             IBQPuc.Close;
             IBQSaldoAct.Close;
             // si _sRuta genera error hay que crearlo en UnitGlobales
             if CbTipo.ItemIndex = 0 then
                frReport1.LoadFromFile(_sRuta + 'Reportes\RepMayorBalance.frf')
             else
                frReport1.LoadFromFile(_sRuta + 'Reportes\RepLibroMayorBalance.frf');
             frReport1.ShowReport;

end;

function TfrmBalanceGeneral.Empleado;
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


procedure TfrmBalanceGeneral.FormCreate(Sender: TObject);
begin
        EdAno.Text := IntToStr(Yearofdate(Date));
        CBMeses.ItemIndex := -1;
end;

procedure TfrmBalanceGeneral.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'EMPRESA' then
           ParValue := Empresa;
        if ParName = 'NIT' then
           ParValue := Nit;
        if ParName = 'ELABORO' then
           ParValue := Empleado;
        if ParName = 'FECHA' then
           ParValue := CBMeses.Text + ' - ' + EdAno.Text;

end;

procedure TfrmBalanceGeneral.FormShow(Sender: TObject);
begin
        Panel3.Caption := Empresa + ' - ' + Nit;
end;

end.





