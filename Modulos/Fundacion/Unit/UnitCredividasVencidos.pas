unit UnitCredividasVencidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, DB, IBCustomDataSet,
  IBQuery,UnitClaseXml, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, JvComponent, JvProgressDlg, JvDialogs;

type
  TFrmCredividasVencidos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DtFecha1: TDateTimePicker;
    DtFecha2: TDateTimePicker;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    IBQuery1: TIBQuery;
    IdTCPClient1: TIdTCPClient;
    JvProgreso: TJvProgressDlg;
    Jv: TJvSaveDialog;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure IdTCPClient1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdTCPClient1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure FormCreate(Sender: TObject);
  private
  _bConexion :Boolean;
    function EnviarXml(_iIdPuerto: Integer; sIdHost, Desc: string;
      AstreamEnv: TMemoryStream): TMemoryStream;
    { Private declarations }
  public
    _iOpcion :Integer;
    { Public declarations }
  end;

var
  FrmCredividasVencidos: TFrmCredividasVencidos;

implementation
uses ComObj, Unitprogreso;

{$R *.dfm}

procedure TFrmCredividasVencidos.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmCredividasVencidos.BitBtn1Click(Sender: TObject);
var   _sMensaje :string;
      _tXml :TXml;
      _iIdPuerto :Integer;
      _sIdHost :string;
      Astream1 :TMemoryStream;
      _sFecha1 :string;
      _sfecha2 :string;
// Variables Excel
      G :Integer;
      Excel, WorkBook, WorkSheet: Variant;
      DesAgencia :string;
      Format: OleVariant;
      _iTotal :Integer;
      _iHoja :Integer;
      _iSalida :Integer;
const
       xlWBATWorksheet = -4167;

begin
        _iHoja := 1;
        _sFecha1 := DateToStr(DtFecha1.Date);
        _sFecha2 := DateToStr(DtFecha2.Date);
        _tXml := TXml.Create;
        _tXml.CrearXml;
        Astream1 := TMemoryStream.Create;
        _tXml.Tipo := 'select';
        if _iOpcion = 1 then
        begin
           _tXml.Sentencia := 'select * from PRD$REPVENDIDOS(' + QuotedStr(_sFecha1) + ',' + QuotedStr(_sfecha2) + ')';
           _iSalida := 6;
        end
        else
        begin
           _tXml.Sentencia := 'select * from PRD$REPVENCIDOS(' + QuotedStr(_sFecha1) + ',' + QuotedStr(_sfecha2) + ')';
           _iSalida := 7;
        end;
        _tXml.CargarNodo;
        Astream1 := _tXml.CargarAstream;
       Excel := CreateOleObject('Excel.Application');
       Excel.DisplayAlerts := false;
       Workbook := Excel.Workbooks.Add(xlWBATWorksheet);
       WorkSheet := WorkBook.WorkSheets[1];
       if _iOpcion = 1 then
           WorkSheet.Name := 'Vendidos_' + FormatDateTime('yyyyMMdd',DtFecha1.Date) + '_' + FormatDateTime('yyyyMMdd',DtFecha2.Date)
        else
           WorkSheet.Name := 'Vencidos_' + FormatDateTime('yyyyMMdd',DtFecha1.Date) + '_' + FormatDateTime('yyyyMMdd',DtFecha2.Date);
        WorkSheet.Cells[1,1] := 'AGENCIA';
        WorkSheet.Cells[1,2] := 'NOMBRES';
        WorkSheet.Cells[1,3] := 'ID_PERSONA';
        WorkSheet.Cells[1,4] := 'VALOR';
        WorkSheet.Cells[1,5] := 'CERTIFICADO';
        WorkSheet.Cells[1,6] := 'FECHACAPTURA';
        WorkSheet.Cells[1,7] := 'FECHAVENCIMIENTO';
        if _iOpcion = 2 then
          WorkSheet.Cells[1,8] := 'TELEFONO';
        WorkSheet.range['A1:G1'].Font.FontStyle := 'Bold';
        WorkSheet.Cells[1,1].ColumnWidth := 14;
        WorkSheet.Cells[1,2].ColumnWidth := 40;
        WorkSheet.Cells[1,3].ColumnWidth := 14;
        WorkSheet.Cells[1,4].ColumnWidth := 11;
        WorkSheet.Cells[1,5].ColumnWidth := 13;
        WorkSheet.Cells[1,6].ColumnWidth := 14;
        WorkSheet.Cells[1,7].ColumnWidth := 14;
        if _iOpcion = 2 then
          WorkSheet.Cells[1,8].ColumnWidth := 30;
        with IBQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"gen$agencia".DESCRIPCION_AGENCIA,');
          SQL.Add('"gen$servidor".ID_HOST,');
          SQL.Add('"gen$servidor".ID_PUERTO');
          SQL.Add('FROM');
          SQL.Add('"gen$agencia"');
          SQL.Add('INNER JOIN "gen$servidor" ON ("gen$agencia".ID_AGENCIA = "gen$servidor".ID_AGENCIA)');
          SQL.Add('WHERE');
          SQL.Add('"gen$servidor".ID_SERVICIO = 1');
          SQL.Add('AND');
          SQL.Add('"gen$agencia".ID_AGENCIA > 0');
          Open;
          while not Eof do
          begin
            _iIdPuerto := FieldByName('ID_PUERTO').AsInteger;
            _sIdHost := FieldByName('ID_HOST').AsString;
            DesAgencia := FieldByName('DESCRIPCION_AGENCIA').AsString;
            try
              _tXml.AstreamEnt := EnviarXml(_iIdPuerto,_sIdHost,DesAgencia,Astream1);
            except
              _sMensaje := _sMensaje + ' ' + DesAgencia;
            end;
            if _bConexion then
            begin
              G := 0;
              _tXml.ListaConsulta := 'Consulta000';
              try
               with _tXml.LeerXml do
               begin
                 while not Eof do
                 begin
                  Inc(_iHoja);
                   WorkSheet.Cells[_iHoja, 1] := DesAgencia;
                   for G := 1 to _iSalida do
                     WorkSheet.Cells[_iHoja, G + 1] := Fields.Fields[G - 1].AsString;
                   Next;
                 end;// fin del while del xml
               end;// fin del With del XML
               except
               end;
            end;// fin del valida si hay conexión
            Next;
          end;// fin del while busca agencias
        end;//fin del ibquery
        if Jv.Execute then
        begin
           workBook.SaveAs(FileName := Jv.FileName + '.xls');
           if MessageDlg('Desea Abrir el Archivo ' + Jv.FileName + '.xls',mtInformation,[mbyes,mbno],0) = mryes then
           begin
             Excel.WorkBooks.Open(Jv.FileName + '.xls');
             Excel.visible:=True;
          end;
        end;

end;

function TFrmCredividasVencidos.EnviarXml(_iIdPuerto: Integer; sIdHost,
  Desc: string; AstreamEnv: TMemoryStream): TMemoryStream;
var     Cadena :string;
        AStream : TMemoryStream;
        Tamano :Integer;
begin
        _bConexion := True;
        with IdTCPClient1 do
        begin
          Port :=_iIdPuerto;
          Host := sIdHost;
          try
            Application.ProcessMessages;
            Connect;
            if Connected then
            begin
              JvProgreso.Text := 'Información de ' + Desc;
              Application.ProcessMessages;
              JvProgreso.Value := 2;
              JvProgreso.Show;
              Cadena := ReadLn();
              WriteInteger(AStreamEnv.Size);
              OpenWriteBuffer;
              WriteStream(AStreamEnv);
              CloseWriteBuffer;
              //FreeAndNil(AStreamEnv);
              tamano := ReadInteger;
              AStream := TMemoryStream.Create;
              ReadStream(Astream,tamano,False);
              Disconnect;
              JvProgreso.Close;
              Application.ProcessMessages;
            end;
          except
          on e: Exception do
          begin
            _bConexion := False;
            Disconnect;
          end;
        end;
        end;
        Result := AStream;


end;

procedure TFrmCredividasVencidos.IdTCPClient1Work(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
//          JvProgreso := 'Kbs Enviados : ' + CurrToStr(AWorkCount/1000);
          JvProgreso.Value := AWorkCount;
          Application.ProcessMessages;
end;

procedure TFrmCredividasVencidos.IdTCPClient1WorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
          JvProgreso.Maximum := AWorkCountMax;
//          JvProgreso. := 0;

end;

procedure TFrmCredividasVencidos.FormCreate(Sender: TObject);
begin
        DtFecha1.Date := Date;
        DtFecha2.Date := Date;
end;

end.
