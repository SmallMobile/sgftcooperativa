unit UnitExportar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JvEdit, JvTypedEdit, Buttons, DB,
  IBCustomDataSet, IBQuery, JvDialogs, JvComponent, JvProgressDlg;

type
  TFrmExportarPagos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    JvAno: TJvYearEdit;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Button1: TButton;
    IBQuery1: TIBQuery;
    Jv: TJvSaveDialog;
    Jv1: TJvProgressDlg;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExportarPagos: TFrmExportarPagos;

implementation
uses ComObj;

{$R *.dfm}

procedure TFrmExportarPagos.Button1Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmExportarPagos.BitBtn1Click(Sender: TObject);
var   G :Integer;
      Excel, WorkBook, WorkSheet: Variant;
      DesAgencia :string;
      Format: OleVariant;
      _iTotal :Integer;
const
       xlWBATWorksheet = -4167;
begin
       Excel := CreateOleObject('Excel.Application');
       Excel.DisplayAlerts := false;
       Workbook := Excel.Workbooks.Add(xlWBATWorksheet);
       WorkSheet := WorkBook.WorkSheets[1];
       WorkSheet.Name := 'ObLab' +  IntToStr(JvAno.Value);;
       G := 0;
        with IBQuery1 do
        begin
          if Transaction.InTransaction then
             Transaction.Rollback;
          Transaction.StartTransaction;
          Close;
          ParamByName('ANO').AsInteger := JvAno.Value;
          Open;
          Last;
          _iTotal := RecordCount;
          Jv1.Maximum := _iTotal;
          Jv1.Text := '';
          Jv1.Show;
          First;
          WorkSheet.Cells[1,1] := 'Obligaciones Laborales Año: ' +  IntToStr(JvAno.Value);
          WorkSheet.Cells[3,1] := 'EMPLEADO';
          WorkSheet.Cells[3,2] := 'No. DOCUMENTO';
          WorkSheet.Cells[3,3] := 'TIPO NOMINA';
          WorkSheet.Cells[3,4] := 'SUELDO';
          WorkSheet.Cells[3,5] := 'HORAS EXTRAS';
          WorkSheet.Cells[3,6] := 'VIATICOS';
          WorkSheet.Cells[3,7] := 'TRANSPORTE';
          WorkSheet.Cells[3,8] := 'P. ANTIGUEDAD';
          WorkSheet.Cells[3,9] := 'P. VACACIONES';
          WorkSheet.Cells[3,10] := 'P. NAVIDAD';
          WorkSheet.Cells[3,11] := 'P. SERVICIOS';
          WorkSheet.Cells[3,12] := 'VACACIONES';
          WorkSheet.Cells[3,13] := 'BONIFICACION';
          WorkSheet.Cells[3,14] := 'PENSION';
          WorkSheet.Cells[3,15] := 'FSP';
          WorkSheet.Cells[3,16] := 'RETEFUENTE';
          WorkSheet.Cells[3,17] := 'GASTOS REP.';
          WorkSheet.Cells[1,1].ColumnWidth := 50;
          WorkSheet.Cells[1,2].ColumnWidth := 15;
          WorkSheet.range['A3:Q3'].Font.FontStyle := 'Bold';
          WorkSheet.range['A1:B1'].Font.FontStyle := 'Bold';
          while not Eof do
          begin
           Jv1.Value := RecNo;
           Jv1.Text := 'Procesando: ' + Fields.Fields[0].AsString;
           Sleep(50);
           Application.ProcessMessages;
           for G := 1 to 17 do
             WorkSheet.Cells[recno + 4, G] := Fields.Fields[G - 1].AsString;
//            WorkSheet.Range['D' + IntToStr(recno + 4) + ':Q' + IntToStr(recno + 4)].NumberFormat := '#,###,##';
            Next;
          end;
        end;
        WorkSheet.Range['D4:Q' + IntToStr(_Itotal + 4)].NumberFormat := '#,##0';
        WorkSheet.Range['B4:B' + IntToStr(_Itotal + 4)].NumberFormat := '#,##0';
        WorkSheet.Range['D' + IntToStr(_Itotal + 6) + ':D' + IntToStr(_Itotal + 6)].NumberFormat := '#,##0';//'#,###,##';
        WorkSheet.Cells[(_Itotal + 6),1] := 'TOTALES';
        WorkSheet.range['A' + IntToStr(_Itotal + 6) + ':Q' + IntToStr(_Itotal + 6)].Font.FontStyle := 'Bold';
        WorkSheet.Range['D' + IntToStr(_Itotal + 6) + ':D' + IntToStr(_Itotal + 6)].Formula := '=SUM(D5:D' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['E' + IntToStr(_Itotal + 6) + ':E' + IntToStr(_Itotal + 6)].Formula := '=SUM(E5:E' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['F' + IntToStr(_Itotal + 6) + ':F' + IntToStr(_Itotal + 6)].Formula := '=SUM(F5:F' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['G' + IntToStr(_Itotal + 6) + ':G' + IntToStr(_Itotal + 6)].Formula := '=SUM(G5:G' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['H' + IntToStr(_Itotal + 6) + ':H' + IntToStr(_Itotal + 6)].Formula := '=SUM(H5:H' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['I' + IntToStr(_Itotal + 6) + ':I' + IntToStr(_Itotal + 6)].Formula := '=SUM(I5:I' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['J' + IntToStr(_Itotal + 6) + ':J' + IntToStr(_Itotal + 6)].Formula := '=SUM(J5:J' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['K' + IntToStr(_Itotal + 6) + ':K' + IntToStr(_Itotal + 6)].Formula := '=SUM(K5:K' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['L' + IntToStr(_Itotal + 6) + ':L' + IntToStr(_Itotal + 6)].Formula := '=SUM(L5:L' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['M' + IntToStr(_Itotal + 6) + ':M' + IntToStr(_Itotal + 6)].Formula := '=SUM(M5:M' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['O' + IntToStr(_Itotal + 6) + ':O' + IntToStr(_Itotal + 6)].Formula := '=SUM(O5:O' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['P' + IntToStr(_Itotal + 6) + ':P' + IntToStr(_Itotal + 6)].Formula := '=SUM(P5:P' + IntToStr(_Itotal + 4) + ')';
        WorkSheet.Range['Q' + IntToStr(_Itotal + 6) + ':Q' + IntToStr(_Itotal + 6)].Formula := '=SUM(Q5:Q' + IntToStr(_Itotal + 4) + ')';
        //workBook.SaveAs(FileName := 'c:\archivo.xls', Password := '123456');
        Jv1.Close;
        if Jv.Execute then
        begin
           workBook.SaveAs(FileName := Jv.FileName + '.xls');
           if MessageDlg('Desea Abrir el Archivo ' + Jv.FileName + '.xls',mtInformation,[mbyes,mbno],0) = mryes then
           begin
             Excel.WorkBooks.Open(Jv.FileName + '.xls');
             Excel.visible:=True;
          end;
        end;
        //Excel.quit;

end;                        

end.
