unit UnitPlanillaResumen;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, pr_Common, pr_TxClasses, DB,
  IBCustomDataSet, IBQuery, Buttons, ComCtrls, IBSQL, FR_DSet, FR_DBSet,
  FR_Class, frOLEExl;

type
  TfrmPlanillaResumen = class(TForm)
    Panel1: TPanel;
    CmdAceptar: TBitBtn;
    CmdCancelar: TBitBtn;
    IBQuery1: TIBQuery;
    IBSQL1: TIBSQL;
    IBSQL2: TIBSQL;
    IBQuery2: TIBQuery;
    Report: TprTxReport;
    IBQuery3: TIBQuery;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    EdFecha: TDateTimePicker;
    CbTipo: TComboBox;
    frReport1: TfrReport;
    frOLEExcelExport1: TfrOLEExcelExport;
    frDBDataSet1: TfrDBDataSet;
    procedure CmdAceptarClick(Sender: TObject);
    procedure CmdCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlanillaResumen: TfrmPlanillaResumen;

implementation

{$R *.dfm}

uses UnitGlobales, UnitdmGeneral;

procedure TfrmPlanillaResumen.CmdAceptarClick(Sender: TObject);
var Codigo:string;
    Consecutivo:Integer;
begin
//**
        with IBSQL1 do begin
          Close;
          if Transaction.InTransaction then
             Transaction.Rollback;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('select * from "con$controlplanilla" where FECHA_PLANILLA = :FECHA_PLANILLA');
          ParamByName('FECHA_PLANILLA').AsDate := EdFecha.Date;
          ExecQuery;
          if RecordCount > 0 then
           begin
             MessageDlg('La planilla ya se Impresa y Registrada el Dia :'+FieldByName('FECHA_IMPRESION').AsString,mtInformation,[mbok],0);
             EdFecha.SetFocus;
             Exit;
           end;
        end;
//**
        Consecutivo := 0;
        if IBSQL1.Transaction.InTransaction then
           IBSQL1.Transaction.Commit;
        IBSQL1.Transaction.StartTransaction;
        with IBSQL1 do begin
           Close;
           SQL.Clear;
           SQL.Add('delete from "con$planillaresumen"');
           try
             ExecQuery;
             IBSQL1.Transaction.Commit;
           except
             MessageDlg('Error al Limpiar Planilla',mtError,[mbok],0);
           end;
        end;
        IBQuery1.Transaction.StartTransaction;

        if CbTipo.ItemIndex = 1 then
         with IBQuery3 do begin
          Close;
          SQL.Clear;
          SQL.Add('select * from "gen$consecutivos" where ID_CONSECUTIVO = 4');
          Open;
          Consecutivo := FieldByName('CONSECUTIVO').AsInteger;
          Consecutivo := Consecutivo + 1;

          Close;
          SQL.Clear;
          SQL.Add('update "gen$consecutivos" set CONSECUTIVO = :CONSECUTIVO where ID_CONSECUTIVO = 4');
          ParamByName('CONSECUTIVO').AsInteger := Consecutivo;
          ExecSQL;
          Close;

          Close;
          SQL.Clear;
          SQL.Add('insert into "con$controlplanilla" values (:FECHA_PLANILLA,:FECHA_IMPRESION,:CONSECUTIVO)');
          ParamByName('FECHA_PLANILLA').AsDate := EdFecha.Date;
          ParamByName('FECHA_IMPRESION').AsDate := date;
          ParamByName('CONSECUTIVO').AsInteger := Consecutivo;
          ExecSQL;
          Close;
          CmdAceptar.Enabled := False;
         end;

        with IBQuery1 do begin
           Close;
           ParamByName('ID_AGENCIA').AsInteger := Agencia;
           ParamByName('FECHADIA').AsDate := EdFecha.Date;
           try
            Open;
           except
            MessageDlg('Error al Buscar Datos para este día',mtError,[mbok],0);
           end;
        end;

        IBSQL1.SQL.Clear;
        IBSQL1.SQL.Add('update "con$planillaresumen" SET DEBITO = DEBITO + :DEBITO,');
        IBSQL1.SQL.Add('CREDITO = CREDITO + :CREDITO where CODIGO = :CODIGO');
        IBSQL2.SQL.Clear;
        IBSQL2.SQL.Add('insert into "con$planillaresumen" VALUES (:CODIGO,:DEBITO,:CREDITO)');

        with IBQuery1 do
        while not Eof do begin
              Codigo := LeftStr(FieldByName('CODIGO').AsString,4);
              Codigo := Codigo + '00000000000000';
              IBSQL1.ParamByName('CODIGO').AsString := Codigo;
              IBSQL1.ParamByName('DEBITO').AsCurrency := FieldByName('DEBITO').AsCurrency;
              IBSQL1.ParamByName('CREDITO').AsCurrency := FieldByName('CREDITO').AsCurrency;
              try
               IBSQL1.ExecQuery;
               if IBSQL1.RowsAffected < 1 then begin
                  IBSQL2.ParamByName('CODIGO').AsString := Codigo;
                  IBSQL2.ParamByName('DEBITO').AsCurrency := FieldByName('DEBITO').AsCurrency;
                  IBSQL2.ParamByName('CREDITO').AsCurrency := FieldByName('CREDITO').AsCurrency;
                  try
                    IBSQL2.ExecQuery;
                  except
                    MessageDlg('Error al Generar Planilla',mtError,[mbcancel],0);
                    IBSQL2.Transaction.Rollback;
                    Exit;
                  end;
               end; // if
              except
                    MessageDlg('Error al Generar Planilla',mtError,[mbcancel],0);
                    IBSQL2.Transaction.Rollback;
                    Exit;
              end;
              Next;
        end;
        frReport1.LoadFromFile(_sRuta + 'Reportes\RepPlanilla.frf');
        frReport1.ShowReport;

        IBSQL1.Transaction.Commit;

end;


procedure TfrmPlanillaResumen.CmdCancelarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmPlanillaResumen.FormShow(Sender: TObject);
begin
        EdFecha.Date := Date;
        if IBSQL1.Transaction.InTransaction then
           IBSQL1.Transaction.Rollback;
        IBSQL1.Transaction.StartTransaction;
end;

procedure TfrmPlanillaResumen.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'EMPRESA' then
           ParValue := Empresa;
        if ParName = 'NIT' then
           ParValue := Nit;
        if ParName = 'FECHA' then
           ParValue := EdFecha.Date;
end;

end.
