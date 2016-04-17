unit UnitCajaDiario;

interface

uses
  Windows, Messages, DateUtils, StrUtils, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pr_Common, pr_TxClasses, DB, IBCustomDataSet, IBQuery, StdCtrls,
  Buttons, Mask, ExtCtrls, DBClient, FR_DSet, FR_DBSet, FR_Class, frOLEExl,
  JvComponent, JvProgressDlg,JclDateTime;

type
  TfrmCajaDiario = class(TForm)
    IBQPuc: TIBQuery;
    IBQAuxiliar: TIBQuery;
    IBQTemp: TClientDataSet;
    IBQTempCODIGO: TStringField;
    IBQTempDIA: TIntegerField;
    IBQTempMES: TIntegerField;
    IBQTempDEBITO: TCurrencyField;
    IBQTempCREDITO: TCurrencyField;
    IBQTempNOMBRE: TStringField;
    Reporte: TprTxReport;
    SDArchivo: TSaveDialog;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    CBMeses: TComboBox;
    EdAno: TMaskEdit;
    Panel1: TPanel;
    CmdAceptar: TBitBtn;
    CmdReporte: TBitBtn;
    CmdCerrar: TBitBtn;
    frReport1: TfrReport;
    frOLEExcelExport1: TfrOLEExcelExport;
    frDBDataSet1: TfrDBDataSet;
    JvProgreso: TJvProgressDlg;
    CbTipo: TComboBox;
    procedure CmdAceptarClick(Sender: TObject);
    procedure CmdCerrarClick(Sender: TObject);
    procedure CmdReporteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCajaDiario: TfrmCajaDiario;

implementation

{$R *.dfm}

uses UnitDmGeneral,UnitGlobales;

procedure TfrmCajaDiario.CmdAceptarClick(Sender: TObject);
var Total:Integer;
    Codigo:string;
begin
       
       if CBMeses.ItemIndex = -1 then
       begin
         CBMeses.SetFocus;
         ShowMessage('Debe seleccionar un Mes de Corte');
         Exit;
       end;
        CmdAceptar.Enabled := False;
        Application.ProcessMessages;
        if dmGeneral.IBTransaction1.InTransaction then
           dmGeneral.IBTransaction1.Rollback;
        dmGeneral.IBTransaction1.StartTransaction;
        with IBQAuxiliar do begin
         Close;
         SQL.Clear;
         SQL.Add('select COUNT(*) AS TOTAL from "con$auxiliar" where');
         SQL.Add('((ESTADOAUX = :ESTADO) and (FECHA BETWEEN :FECHA1 and :FECHA2))');
         ParamByName('ESTADO').AsString := 'C';
         ParamByName('FECHA1').AsDate := EncodeDate(StrToInt(EdAno.Text),CBMeses.ItemIndex + 1,01);
         ParamByName('FECHA2').AsDate := EncodeDate(StrToInt(EdAno.Text),CBMeses.ItemIndex + 1,DaysInMonth(EncodeDate(StrToInt(EdAno.Text),CBMeses.ItemIndex + 1,01)));
         try
          Open;
          Total := FieldByName('TOTAL').AsInteger;
         except
          Transaction.Rollback;
         end;

         Close;
         SQL.Clear;
         SQL.Add('select * from "con$auxiliar" where');
         SQL.Add('((ESTADOAUX = :ESTADO) and (FECHA BETWEEN :FECHA1 and :FECHA2))');
         SQL.Add('Order by FECHA,ID_AGENCIA,CODIGO');
         ParamByName('ESTADO').AsString := 'C';
         ParamByName('FECHA1').AsDate := EncodeDate(StrToInt(EdAno.Text),CBMeses.ItemIndex + 1,01);
         ParamByName('FECHA2').AsDate := EncodeDate(StrToInt(EdAno.Text),CBMeses.ItemIndex + 1,DaysInMonth(EncodeDate(StrToInt(EdAno.Text),CBMeses.ItemIndex + 1,01)));
         try
          Open;
         except
          Transaction.Rollback;
          raise;
         end;

         JvProgreso.Maximum := Total;
         JvProgreso.Show;

         while not Eof do begin
           JvProgreso.Value := RecNo;
           JvProgreso.Text := 'Procesando Dia: '  + FieldByName('FECHA').AsString;
           Application.ProcessMessages;
           IBQTemp.Open;
           if not IBQTemp.FindKey([MonthOf(FieldByName('FECHA').AsDateTime),DayOf(FieldByName('FECHA').AsDateTime),LeftStr(FieldByName('CODIGO').AsString,4)]) then
//           if not IBQTemp.Locate('MES;DIA;CODIGO',VarArrayOf([MonthOf(FieldByName('FECHA').AsDateTime),DayOf(FieldByName('FECHA').AsDateTime),LeftStr(FieldByName('CODIGO').AsString,4)]),[loCaseInsensitive]) then
           begin
              IBQTemp.Insert;
              IBQTemp.FieldByName('CODIGO').AsString := LeftStr(FieldByName('CODIGO').AsString,4);
              IBQPuc.Close;
              IBQPuc.SQL.Clear;
              IBQPuc.SQL.Add('select NOMBRE from "con$puc" where CODIGO = :CODIGO');
              Codigo := '00000000000000';
              Codigo := LeftStr(FieldByName('CODIGO').AsString,4) + Codigo;
              IBQPuc.ParamByName('CODIGO').AsString := Codigo;
              try
                IBQPuc.Open;
              except
                IBQPuc.Transaction.Rollback;
                JvProgreso.Close;
                raise;
              end;
              IBQTemp.FieldByName('NOMBRE').AsString := IBQPuc.FieldByName('NOMBRE').AsString;
              IBQTemp.FieldByName('DIA').AsInteger := DayOf(FieldByName('FECHA').AsDateTime);
              IBQTemp.FieldByName('MES').AsInteger := MonthOf(FieldByName('FECHA').AsDateTime);
              IBQTemp.FieldByName('DEBITO').AsCurrency := 0;
              IBQTemp.FieldByName('CREDITO').AsCurrency := 0;
              IBQTemp.Post;
           end;
           IBQTemp.Edit;
           IBQTemp.FieldByName('DEBITO').AsCurrency := IBQTemp.FieldByName('DEBITO').AsCurrency + FieldByName('DEBITO').AsCurrency;
           IBQTemp.FieldByName('CREDITO').AsCurrency := IBQTemp.FieldByName('CREDITO').AsCurrency + FieldByName('CREDITO').AsCurrency;
           IBQTemp.Post;
           IBQTemp.First;
           IBQTemp.Close;
           Next;
         end;
         JvProgreso.Close;
       end;
       CmdReporte.Enabled := True;
       CmdReporte.Click;
//       CmdArchivo.Enabled := True;

end;

procedure TfrmCajaDiario.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmCajaDiario.CmdReporteClick(Sender: TObject);
begin
       if CbTipo.ItemIndex = 0 then
           frReport1.LoadFromFile(_sRuta + 'Reportes\RepCajaDiario.frf')
       else
           frReport1.LoadFromFile(_sRuta + 'Reportes\RepLibroCajaDiario.frf');
       frReport1.ShowReport;
end;

procedure TfrmCajaDiario.FormShow(Sender: TObject);
begin
        CmdReporte.Enabled := False;
//        CmdArchivo.Enabled := False;
end;

procedure TfrmCajaDiario.FormCreate(Sender: TObject);
begin
        EdAno.Text := IntToStr(Yearofdate(Date));
end;

procedure TfrmCajaDiario.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'EMPRESA' then
           ParValue := Empresa;
        if ParName = 'NIT' then
           ParValue := Nit;
        if ParName = 'FECHA' then
           ParValue := CBMeses.Text + ' - ' + EdAno.Text;
end;

end.
