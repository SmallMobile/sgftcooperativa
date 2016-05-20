unit UnitCierreAnual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ComCtrls, ExtCtrls, DB,
  IBCustomDataSet, IBQuery, pr_Common, pr_TxClasses, pr_Parser, IBSQL,
  DBCtrls, DBClient;

type
  Tfrmcierreanual = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    EdCodigoInicial: TMaskEdit;
    Label2: TLabel;
    EdCodigoFinal: TMaskEdit;
    Panel2: TPanel;
    CmdAceptar: TBitBtn;
    CmdCerrar: TBitBtn;
    IBQuery1: TIBQuery;
    IBQuery: TIBQuery;
    IBQuery2: TIBQuery;
    IBQuery1ID_AGENCIA: TSmallintField;
    IBQuery1ID_COMPROBANTE: TIntegerField;
    IBQuery1CODIGO: TIBStringField;
    IBQuery1DEBITO: TIBBCDField;
    IBQuery1CREDITO: TIBBCDField;
    IBQuery1ID_PERSONA: TIBStringField;
    IBQuery1ESTADOAUX: TIBStringField;
    IBQuery1FECHADIA: TDateField;
    IBQuery1DESCRIPCION: TMemoField;
    IBQuery1NOMBRE: TIBStringField;
    IBQuery1SALDOINICIAL: TIBBCDField;
    IBQuery1DESCRIPCION_AGENCIA: TIBStringField;
    IBQuery1NOMBRE1: TIBStringField;
    IBQuery1PRIMER_APELLIDO: TIBStringField;
    IBQuery1SEGUNDO_APELLIDO: TIBStringField;
    EdCtaI: TStaticText;
    EdCtaF: TStaticText;
    IBSQL1: TIBSQL;
    ReportAuxiliar: TprTxReport;
    IBTipoDocumento: TIBQuery;
    DSTipoDocumento: TDataSource;
    IBpuc: TIBQuery;
    IBSaldo: TIBQuery;
    CDsaldos: TClientDataSet;
    CDsaldoscodigo: TStringField;
    CDsaldosnombre: TStringField;
    CDsaldosdebito: TCurrencyField;
    CDsaldoscredito: TCurrencyField;
    Report1: TprTxReport;
    report10: TprTxReport;
    IBQuery3: TIBQuery;
    Label3: TLabel;
    EDcodigo: TMaskEdit;
    Ednombre: TEdit;
    Label4: TLabel;
    procedure EdCodigoInicialExit(Sender: TObject);
    procedure EdCodigoFinalExit(Sender: TObject);
    procedure EdCodigoInicialKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodigoFinalKeyPress(Sender: TObject; var Key: Char);
    procedure EdFechaInicialKeyPress(Sender: TObject; var Key: Char);
    procedure EdFechaFinalKeyPress(Sender: TObject; var Key: Char);
    procedure EdFechaInicialExit(Sender: TObject);
    procedure EdFechaFinalExit(Sender: TObject);
    procedure CmdAceptarClick(Sender: TObject);
    procedure CmdCerrarClick(Sender: TObject);
    procedure ReportAuxiliarUnknownVariable(Sender: TObject;
      const VarName: String; var Value: TprVarValue;
      var IsProcessed: Boolean);
    procedure FormShow(Sender: TObject);
    procedure EDcodigoExit(Sender: TObject);
    procedure EDcodigoKeyPress(Sender: TObject; var Key: Char);
  private
    function Empleado : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcierreanual: Tfrmcierreanual;
  CodigoInicial : String;
  CodigoFinal   : String;
  codigo_r      :string;
  FechaInicial  : TDate;
  FechaFinal    : TDate;
  Cadena        : String;
  SaldoMovimiento : Currency;
  SaldoInicial : Currency;
  CodigoGrupo :  String;
  SumaSaldoCodigo : Currency;

implementation

{$R *.dfm}

uses UnitGlobales, UnitdmGeneral, UnitVistaPreliminar;

procedure Tfrmcierreanual.EdCodigoInicialExit(Sender: TObject);
begin
        Cadena := EdCodigoInicial.Text;
        while Pos(' ',Cadena) > 0 do
        Cadena[Pos(' ',Cadena)] := '0';
        CodigoInicial := Cadena;
        with IBSQL1 do begin
         Close;
         ParamByName('CODIGO').AsString := CodigoInicial;
         ExecQuery;
         if RecordCount > 0 then
            EdCtaI.Caption := FieldByName('NOMBRE').AsString
         else
            EdCtaI.Caption := 'NO SE ENCONTRO CODIGO';
        end;
end;

procedure Tfrmcierreanual.EdCodigoFinalExit(Sender: TObject);
begin
        Cadena := EdCodigoFinal.Text;
        while Pos(' ',Cadena) > 0 do
        Cadena[Pos(' ',Cadena)] := '0';
        CodigoFinal := Cadena;
        with IBSQL1 do begin
         Close;
         ParamByName('CODIGO').AsString := CodigoFinal;
         ExecQuery;
         if RecordCount > 0 then
            EdCtaF.Caption := FieldByName('NOMBRE').AsString
         else
            EdCtaF.Caption := 'NO SE ENCONTRO CODIGO';
        end;


end;

procedure Tfrmcierreanual.EdCodigoInicialKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure Tfrmcierreanual.EdCodigoFinalKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure Tfrmcierreanual.EdFechaInicialKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure Tfrmcierreanual.EdFechaFinalKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure Tfrmcierreanual.EdFechaInicialExit(Sender: TObject);
begin
        //FechaInicial := EdFechaInicial.Date;
end;

procedure Tfrmcierreanual.EdFechaFinalExit(Sender: TObject);
begin
       // FechaFinal := EdFechaFinal.Date;
end;

procedure Tfrmcierreanual.CmdAceptarClick(Sender: TObject);
var
frmVistaPreliminar:TfrmVistaPreliminar;
NomAgencia, tipo : String;
cansecutivo :Integer;
saldo_cuenta, movimiento,debito,credito,valor_d,valor_c,total:Currency;
begin
        if MessageDlg('Esta Seguro de Realizar la Operación',mtInformation,[mbyes,mbno],0) = mryes then
        begin
        Cansecutivo := ObtenerConsecutivo(IBSQL1);
        CDsaldos.CancelUpdates;
        saldo_cuenta := 0;
        movimiento := 0;
        debito := 0;
        credito := 0;
        valor_d := 0;
        valor_c := 0;
        IBpuc.Close;
        IBpuc.ParamByName('COD_INICIAL').AsString := CodigoInicial;
        IBpuc.ParamByName('COD_FINAL').AsString := CodigoFinal;
        IBpuc.Open;
        while not IBpuc.Eof do
        begin
          saldo_cuenta := IBpuc.FieldByName('SALDOINICIAL').AsCurrency;
          IBSaldo.Close;
          IBSaldo.ParamByName('CODIGO').AsString := IBpuc.FieldByName('CODIGO').AsString;
          IBSaldo.Open;
          Movimiento := IBSaldo.FieldByName('SALDO').AsCurrency + saldo_cuenta;
          if movimiento < 0 then
          begin
             debito := ABS(movimiento);
             valor_d := valor_d + debito;
             credito := 0;
          end
          else
          begin
             credito := ABS(movimiento);
             valor_c := valor_c + credito;
             debito := 0;
          end;
          if ABS(movimiento) > 0 then
          begin
             CDsaldos.Append;
             CDsaldos.FieldValues['codigo'] := IBpuc.FieldByName('CODIGO').AsString;
             CDsaldos.FieldValues['nombre'] := IBpuc.FieldByName('NOMBRE').AsString;
             CDsaldos.FieldValues['debito'] := debito;
             CDsaldos.FieldValues['credito'] := credito;
             CDsaldos.Post;
          end;
          IBpuc.Next;
                    debito := 0;
          credito := 0;
          saldo_cuenta := 0;
          movimiento := 0;
        end;
                       if valor_c <> valor_d then
               begin
                  if valor_c > valor_d then
                     tipo := 'd'
                  else
                     tipo := 'c';
                  total := abs(valor_c - valor_d);
               end;
               credito := 0;credito := 0;
               if tipo = 'c' then
                  credito := total
               else
                  debito := total;
                  valor_d := valor_d + debito;
                  valor_c := valor_c + credito;
             CDsaldos.Append;
             CDsaldos.FieldValues['codigo'] := codigo_r;
             CDsaldos.FieldValues['nombre'] := Ednombre.Text;
             CDsaldos.FieldValues['debito'] := debito;
             CDsaldos.FieldValues['credito'] := credito;
             CDsaldos.Post;


        CDsaldos.IndexFieldNames := 'debito';
              frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
              report10.Variables.ByName['v_debito'].AsVariant := valor_d;
              report10.Variables.ByName['v_credito'].AsVariant := valor_c;
              report10.Variables.ByName['Empleado'].AsString := 'ROSALBA COLLANTES TORRADO';
              report10.Variables.ByName['comprobante'].AsString := IntToStr(cansecutivo);
              {report10.Variables.ByName['oficina'].AsString := oficina;
              report10.Variables.ByName['tiponota'].AsString := tipo_agencia(consec);}

              if report10.PrepareReport then
               begin
                 frmVistaPreliminar.Reporte := Report10;
                 frmVistaPreliminar.ShowModal;
               end;
         with IBQuery1 do begin
         Close;
         sql.Clear;
         sql.Add('insert into "con$comprobante" ("con$comprobante"."ID_COMPROBANTE",');
         sql.Add('"con$comprobante"."FECHADIA", "con$comprobante"."TIPO_COMPROBANTE",');
         sql.Add('"con$comprobante"."ID_AGENCIA", "con$comprobante"."DESCRIPCION",');
         sql.Add('"con$comprobante"."TOTAL_DEBITO", "con$comprobante"."TOTAL_CREDITO",');
         sql.Add('"con$comprobante"."ESTADO", "con$comprobante"."IMPRESO",');
         sql.Add('"con$comprobante"."ANULACION","con$comprobante".ID_EMPLEADO)');
         sql.Add('values (');
         sql.Add(':"ID_COMPROBANTE", :"FECHADIA", :"TIPO_COMPROBANTE",');
         sql.Add(':"ID_AGENCIA", :"DESCRIPCION", :"TOTAL_DEBITO",');
         sql.Add(':"TOTAL_CREDITO", :"ESTADO", :"IMPRESO", :"ANULACION",:ID_EMPLEADO)');
         ParamByName('ID_COMPROBANTE').AsString:= IntToStr(cansecutivo);
         ParamByname('FECHADIA').AsDate := StrToDate('2004/12/31'); //fFechaActual;
         ParamByName('ID_AGENCIA').AsInteger := 1;
         ParamByName('TIPO_COMPROBANTE').AsInteger := 1;
         ParamByName('DESCRIPCION').AsBlob := 'CIERRE DE AÑO 2004';
         ParamByName('TOTAL_DEBITO').AsCurrency  := valor_d;
         ParamByName('TOTAL_CREDITO').AsCurrency  := valor_c;
         ParamByName('ESTADO').AsString  := 'O';
         ParamByname('ANULACION').asstring := '';
         ParamByName('IMPRESO').AsInteger  := Ord(false);
         ParamByName('ID_EMPLEADO').AsString := 'RCOLLANTES';
         Open;
         CDsaldos.First;
         while not CDsaldos.Eof do
         begin
         SQL.Clear;
         SQL.Add('insert into "con$auxiliar" values (');
            SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
            SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
            SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
            ParamByName('ID_COMPROBANTE').AsString := IntToStr(cansecutivo);
            ParamByName('ID_AGENCIA').AsInteger:= 1;
            ParamByName('FECHA').AsDate := StrToDate('2004/12/31');
            ParamByName('CODIGO').AsString := CDsaldos.FieldByName('codigo').AsString;
            ParamByName('DEBITO').AsCurrency := CDsaldos.FieldByName('debito').AsCurrency;
            ParamByName('CREDITO').AsCurrency := CDsaldos.FieldByName('credito').AsCurrency;
            ParamByName('ID_CUENTA').AsString := '0';
            ParamByName('ID_COLOCACION').AsString := '0';
            ParamByName('ID_IDENTIFICACION').AsInteger := 0;
            ParamByName('ID_PERSONA').AsString := '0';
            ParamByName('MONTO_RETENCION').AsCurrency := 0;
            ParamByName('TASA_RETENCION').AsFloat := 0;
            ParamByName('ESTADOAUX').AsString := 'O';
          Open;
          CDsaldos.Next;
         end;
         Close;
        end;
        CmdAceptar.Enabled := False;
        end;

{        With IBQuery1 do
         begin
           SQL.Clear;
           SQL.Add('select');
           SQL.Add('"con$comprobante".ID_AGENCIA,');
           SQL.Add('"con$comprobante".ID_COMPROBANTE,');
           SQL.Add('"con$auxiliar".CODIGO,');
           SQL.Add('"con$auxiliar".DEBITO,');
           SQL.Add('"con$auxiliar".CREDITO,');
           SQL.Add('"con$auxiliar".ID_PERSONA,');
           SQL.Add('"con$auxiliar".ESTADOAUX,');
           SQL.Add('"con$comprobante".FECHADIA,');
           SQL.Add('"con$comprobante".DESCRIPCION,');
           SQL.Add('"con$puc".NOMBRE,');
           SQL.Add('"con$puc".SALDOINICIAL,');
           SQL.Add('"gen$agencia".DESCRIPCION_AGENCIA,');
           SQL.Add('"gen$persona".NOMBRE as NOMBRE1,');
           SQL.Add('"gen$persona".PRIMER_APELLIDO,');
           SQL.Add('"gen$persona".SEGUNDO_APELLIDO');
           SQL.Add('from "con$comprobante"');
           SQL.Add('LEFT JOIN "con$auxiliar" ON ("con$auxiliar".ID_AGENCIA = "con$comprobante".ID_AGENCIA and "con$auxiliar".ID_COMPROBANTE = "con$comprobante".ID_COMPROBANTE)');
           SQL.Add('LEFT JOIN "con$puc" ON ("con$auxiliar".CODIGO = "con$puc".CODIGO)');
           SQL.Add('LEFT JOIN "gen$agencia" ON ("con$comprobante".ID_AGENCIA = "gen$agencia".ID_AGENCIA)');
           SQL.Add('LEFT JOIN "gen$persona" ON ("con$auxiliar".ID_IDENTIFICACION = "gen$persona".ID_IDENTIFICACION and "con$auxiliar".ID_PERSONA = "gen$persona".ID_PERSONA)');
           SQL.Add('where');
           SQL.Add('("con$comprobante".FECHADIA >= :"FECHA_INICIAL" and "con$comprobante".FECHADIA <= :"FECHA_FINAL") and');
           SQL.Add('("con$auxiliar".CODIGO >= :"CODIGO_INICIAL" and "con$auxiliar".CODIGO <= :"CODIGO_FINAL")');

           ParamByName('FECHA_INICIAL').AsDate := EdFechaInicial.Date;
           ParamByName('FECHA_FINAL').AsDate := EdFechaFinal.Date;
           ParamByName('CODIGO_INICIAL').AsString := CodigoInicial;
           ParamByName('CODIGO_FINAL').AsString := CodigoFinal;
           case RGTipo.ItemIndex of
           0: begin
              SQL.Add('and (("con$comprobante".ESTADO = :"ESTADOAUX1") or ("con$comprobante".ESTADO = :"ESTADOAUX2"))');
              ParamByName('ESTADOAUX1').AsString := 'C';
              ParamByName('ESTADOAUX2').AsString := 'O';
              ReportAuxiliar.Variables.ByName['Estado'].AsString := 'TODOS';
              end;
           1: begin
              SQL.Add('and ("con$comprobante".ESTADO = :"ESTADOAUX")');
              ParamByName('ESTADOAUX').AsString := 'C';
              ReportAuxiliar.Variables.ByName['Estado'].AsString := 'CERRADOS';
              end;
           end;
           SQL.Add('order by "con$auxiliar".CODIGO, "con$auxiliar".FECHA, "con$auxiliar".ID_COMPROBANTE, "con$auxiliar".CREDITO');
           Open;
           NomAgencia := FieldByName('DESCRIPCION_AGENCIA').AsString;
          end;


          ReportAuxiliar.Variables.ByName['Empresa'].AsString := Empresa;
          ReportAuxiliar.Variables.ByName['FechaI'].AsDateTime := FechaInicial;
          ReportAuxiliar.Variables.ByName['FechaF'].AsDateTime := FechaFinal;
          ReportAuxiliar.Variables.ByName['CodigoI'].AsString := CodigoInicial;
          ReportAuxiliar.Variables.ByName['CodigoF'].AsString := CodigoFinal;
          ReportAuxiliar.Variables.ByName['Hoy'].AsDateTime := Now;
          ReportAuxiliar.Variables.ByName['NomAgencia'].AsString := NomAgencia;
          ReportAuxiliar.Variables.ByName['Empleado'].AsString := Empleado;

          if ReportAuxiliar.PrepareReport then
          begin
             frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
             frmVistaPreliminar.Reporte := ReportAuxiliar;
             frmVistaPreliminar.ShowModal;
          end;}
end;

procedure Tfrmcierreanual.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

function Tfrmcierreanual.Empleado:String;
begin
        with IBQuery do
         begin
           sql.Clear;
           sql.Add('select PRIMER_APELLIDO, SEGUNDO_APELLIDO, NOMBRE from "gen$empleado"');
           sql.Add('where "gen$empleado"."ID_EMPLEADO" =:"ID_EMPLEADO"');
           ParamByName('ID_EMPLEADO').AsString := DBAlias;
           Open;
           Result := FieldByName('NOMBRE').AsString + ' ' + FieldByname('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
         end;
end;

procedure Tfrmcierreanual.ReportAuxiliarUnknownVariable(
  Sender: TObject; const VarName: String; var Value: TprVarValue;
  var IsProcessed: Boolean);
var
PrimerSaldo : Currency;
Nombres : String;
begin
    {if VarName = 'SALDOINICIAL' then
     begin
      PrimerSaldo := IBQuery1.FieldByName('SALDOINICIAL').AsCurrency ;
      CodigoGrupo := IBQuery1.fieldByName('CODIGO').AsString;
      SaldoMovimiento := 0;
      with IBQuery2 do
       begin
         Close;
         SQL.Clear;
         SQL.Add('Select ');
         SQL.Add('"con$auxiliar".DEBITO,');
         SQL.Add('"con$auxiliar".CREDITO,');
         SQL.Add('"con$auxiliar".FECHA');
         SQL.Add('from "con$auxiliar"');
         SQL.Add('where ');
         SQL.Add('("con$auxiliar".ID_AGENCIA =:"ID_AGENCIA") and');
         SQL.Add('("con$auxiliar".CODIGO =:"CODIGO") and');
         SQL.Add('("con$auxiliar".FECHA <:"FECHA_INICIAL")');
         ParamByName('ID_AGENCIA').AsInteger := Agencia;
         ParamByName('CODIGO').AsString := CodigoGrupo;
         ParamByName('FECHA_INICIAL').AsDate := EdFechaInicial.Date;
           case RGTipo.ItemIndex of
           0: begin
              SQL.Add('and (("con$auxiliar".ESTADOAUX = :"ESTADOAUX1") or ("con$auxiliar".ESTADOAUX = :"ESTADOAUX2"))');
              ParamByName('ESTADOAUX1').AsString := 'C';
              ParamByName('ESTADOAUX2').AsString := 'O';
              end;
           1: begin
              SQL.Add('and ("con$auxiliar".ESTADOAUX = :"ESTADOAUX")');
              ParamByName('ESTADOAUX').AsString := 'C';
              end;
           end;

         Open;

         IBQuery2.Last;
         IBQuery2.First;
         SaldoInicial := PrimerSaldo;
         While not IBQuery2.Eof do
          begin
            SaldoInicial := SaldoInicial +
                            (FieldByName('DEBITO').AsCurrency -
                            FieldByName('CREDITO').AsCurrency);
            next;
          end;
         _vSetAsDouble(Value,SaldoInicial);
         IsProcessed := True;
       end;
       SaldoMovimiento := SaldoInicial;
    end;

    if VarName = 'SALDOACTUAL' then
     begin
      SaldoMovimiento :=  SaldoMovimiento +
               (IBQuery1.FieldByName('DEBITO').AsCurrency -
                IBQuery1.FieldByName('CREDITO').AsCurrency);
      SumaSaldoCodigo := SaldoMovimiento;
      _vSetAsDouble(Value,SaldoMovimiento);
      IsProcessed := True;
     end;

    if (VarName = 'BENEFICIARIO') then
     begin
      Nombres := trim(IBQuery1.FieldByName('NOMBRE1').AsString) + ' ' +
                 trim(IBQuery1.FieldByName('PRIMER_APELLIDO').AsString) + ' ' +
                 trim(IBQuery1.FieldByName('SEGUNDO_APELLIDO').AsString);
      _vSetAsString(Value,Nombres);
      IsProcessed := True;
     end;

              }
end;

procedure Tfrmcierreanual.FormShow(Sender: TObject);
begin
        {EdFechaInicial.Date := Date;
        EdFechaFinal.Date := Date;
        if dmGeneral.IBTransaction1.InTransaction then
           dmGeneral.IBTransaction1.Commit;
        dmGeneral.IBTransaction1.StartTransaction;    }
end;

procedure Tfrmcierreanual.EDcodigoExit(Sender: TObject);

begin
        Cadena := EDcodigo.Text;
        while Pos(' ',Cadena) > 0 do
        Cadena[Pos(' ',Cadena)] := '0';
        codigo_r := Cadena;
        with IBSQL1 do begin
         Close;
         ParamByName('CODIGO').AsString := Codigo_r ;
         ExecQuery;
         if RecordCount > 0 then
            Ednombre.Text := FieldByName('NOMBRE').AsString
         else
            Ednombre.Text := 'NO SE ENCONTRO CODIGO';
        end;

end;

procedure Tfrmcierreanual.EDcodigoKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
end;

end.
