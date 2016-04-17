unit Unit1copia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, XStringGrid, StdCtrls, JvDialogs, Buttons,sdXmlDocuments,DateUtils,
  DB, DBClient, OleCtrls, SHDocVw, JvEdit, JvTypedEdit;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    jv: TJvOpenDialog;
    Button2: TButton;
    CBhoja: TComboBox;
    EDlibro: TEdit;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    CD1019: TClientDataSet;
    CD1019tdoc: TStringField;
    CD1019nidsec: TStringField;
    CD1019apl1: TStringField;
    CD1019apl2: TStringField;
    CD1019nom1: TStringField;
    CD1019nom2: TStringField;
    CD1019raz: TStringField;
    CD1019tdocp: TStringField;
    CD1019nidp: TStringField;
    xml: TWebBrowser;
    Agrid: TXStringGrid;
    CD1019dv: TStringField;
    CHinsercion: TCheckBox;
    CBarchivos: TComboBox;
    BitBtn2: TBitBtn;
    jVNumero: TJvIntegerEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn2Click(Sender: TObject);

  private
  a:Integer;
  XLApp,XLApp1,Sheet,Sheet1: OLEVariant;
  RangeMatrix,RangeMatrix1: Variant;
  x, y, k,x1,k1,y1: Integer;
  WS, WBk : Variant;
  archivo :string;
  Cargado :Boolean;
  RDoc:TsdXmlDocument;
    ANode:TXmlNode;
  Nodo,Nodo1:TXmlNode;

    function Xls_To_StringGrid(AGrid1: TXStringGrid;
      AXLSFile: string): Boolean;
    procedure encabezado(formato: string);
    procedure encabezado1;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
  ComObj, UnitPantallaProgreso;
{$R *.dfm}

function TForm1.Xls_To_StringGrid(AGrid1: TXStringGrid;AXLSFile: string): Boolean;

var
r,i: Integer;
begin
    Result := False;
    XLApp := CreateOleObject('Excel.Application');
    XLApp.Visible := False;
    WBk := XLApp.Workbooks.Open(AXLSFile);
    for i := 0 to XLApp.Workbooks[ExtractFileName(AXLSFile)].Worksheets.Count - 1 do
    begin
       CBhoja.Items.Add(XLApp.Workbooks[ExtractFileName(AXLSFile)].Worksheets[i +1].Name);
    end;
    Result := True;
    archivo := AXLSFile;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
if Cargado then
begin
      XLApp.Quit;
      XLAPP := Unassigned;
      Sheet := Unassigned;
end;
  if Xls_To_StringGrid(Agrid, EDlibro.Text) then
  begin
    ShowMessage('Archivo Cargado');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
const
  xlCellTypeLastCell = $0000000B;
var  r,j: Integer;
begin
    Sheet := XLApp.Workbooks[ExtractFileName(archivo)].Worksheets[cbhoja.Text];
    Sheet.Activate;
    Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    x := XLApp.ActiveCell.Row;
    y := XLApp.ActiveCell.Column;
    AGrid.RowCount := x;
    AGrid.ColCount := y;
    RangeMatrix := XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;
    encabezado(CBhoja.Text);
    k := 1;
    try
      for r := 1 to x do //x
      begin
        with RDoc.Root.NodeNew('subnac') do
        begin
          for j := 1 to y do //y
          begin
               WriteAttributeString(RangeMatrix[1, j],RangeMatrix[r, j]);
          end;
        end;
      end;
    except
    RDoc.SaveToFile('c:\xml.xml');
    end;
    RangeMatrix := Unassigned;
    RDoc.SaveToFile('c:\xml.xml');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
        Cargado := False;
end;

procedure TForm1.encabezado(formato: string);
const
  xlCellTypeLastCell = $0000000B;
var  r: Integer;
begin
    XLApp1 := CreateOleObject('Excel.Application');
    XLApp1.Visible := False;
    XLApp1.Workbooks.Open('c:\formato.xls');
    Sheet1 := XLApp1.Workbooks[ExtractFileName('c:\formato.xls')].Worksheets[formato];
    Sheet1.Activate;
    Sheet1.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    x1 := XLApp1.ActiveCell.Row;
    y1 := XLApp1.ActiveCell.Column;
    AGrid.RowCount := x1;
    AGrid.ColCount := y1;
    RangeMatrix1 := XLApp1.Range['A1', XLApp1.Cells.Item[X1, Y1]].Value;
    k1 := 1;
    RDoc := TsdXmlDocument.CreateName('mas');
    RDoc.EncodingString := 'ISO8859-1';
    RDoc.XmlFormat := xfReadable;
    repeat
      for r := 1 to 1 do
      begin
        if K1 = 1 then
        begin
           ShowMessage(RangeMatrix1[K1, R]);
           RDoc.Root.ValueAsString := RangeMatrix1[K1, R];
           ANode := RDoc.Root.NodeNew('Cab')
        end
        else
        ANode.WriteString(RangeMatrix1[K1, R],RangeMatrix1[K1, R + 1]);
      end;
      Inc(k1, 1);
    until k1 > x1;
RangeMatrix1 := Unassigned;

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
        encabezado1;
end;

procedure TForm1.encabezado1;
const
        xlCellTypeLastCell = $0000000B;
        var  r,j,contador: Integer;
        valor :Currency;
        nArchivo :string;
        Insercion :string;
        consecutivo :Integer;
        cArchivo :string;
        nMaximo :Integer;
begin
        nMaximo := jVNumero.Value;
        if CHinsercion.Checked then
           Insercion := '01'
        else
           Insercion := '02';
        consecutivo := 1;
        RDoc := TsdXmlDocument.Createname('mas');
        RDoc.EncodingString := 'ISO8859-1';
        RDoc.XmlFormat := xfReadable;
        valor := 0;
        contador := 0;
        CBarchivos.Clear;
        //CD1019.CancelUpdates;
        if CBhoja.Text = '1019' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '101906' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
          if CD1019.RecordCount = 0 then
          begin
            with CD1019 do
            begin
              Sheet := XLApp.Workbooks[ExtractFileName(archivo)].Worksheets[cbhoja.Text + '-1'];
              Sheet.Activate;
              Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
              x := XLApp.ActiveCell.Row;
              y := XLApp.ActiveCell.Column;
              RangeMatrix := XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;
              for r := 1 to x do //x
              begin
                 Append;
                 FieldValues['tdocp'] := RangeMatrix[r,1];
                 FieldValues['nidp'] := RangeMatrix[r,2];
                 FieldValues['tdoc'] := RangeMatrix[r,4];
                 FieldValues['nidsec'] := RangeMatrix[r,3];
                 FieldValues['dv'] := RangeMatrix[r,5];
                 FieldValues['apl1'] := RangeMatrix[r,6];
                 FieldValues['apl2'] := RangeMatrix[r,7];
                 FieldValues['nom1'] := RangeMatrix[r,8];
                 try
                   FieldValues['nom2'] := RangeMatrix[r,9];
                   FieldValues['raz'] := RangeMatrix[r,10];
                 except
                 begin
                   FieldValues['nom2'] := '';
                   FieldValues['raz'] := '';
                 end;
                 end;
                 Post;
              end;
            end;
          end;
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','1019.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','01');
          ANode.WriteInteger('Formato',1019);
          ANode.WriteInteger('NunEnvio',1);
          ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
          ANode.WriteString('FecInicial','2005-01-01');
          ANode.WriteString('FecFinal','2005-12-31');
          Sheet := XLApp.Workbooks[ExtractFileName(archivo)].Worksheets[cbhoja.Text];
          Sheet.Activate;
          Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
          x := XLApp.ActiveCell.Row;
          y := XLApp.ActiveCell.Column;
          frmProgreso := TfrmProgreso.Create(Self);
          frmProgreso.Titulo := 'Formatos Dian';
          frmProgreso.Max := x;
          frmProgreso.Min := 0;
          frmProgreso.Ejecutar;
          RangeMatrix := XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;
          for r := 1 to x do //x
          begin
              frmProgreso.Position := r;
              frmProgreso.InfoLabel := 'Registro Numero :' + IntToStr(r);
              Application.ProcessMessages;
              Nodo := RDoc.Root.NodeNew('movcta');
              with Nodo do
              begin
                WriteAttributeString('tdoc',RangeMatrix[r,1]);
                WriteAttributeString('nid',RangeMatrix[r,2]);
                if RangeMatrix[r,3] <> '' then
                   WriteAttributeString('dv',RangeMatrix[r,3]);
                if RangeMatrix[r,4] <> '' then
                   WriteAttributeString('apl1',RangeMatrix[r,4]);
                if RangeMatrix[r,5] <> '' then
                   WriteAttributeString('apl2',RangeMatrix[r,5]);
                if RangeMatrix[r,6] <> '' then
                   WriteAttributeString('nom1',RangeMatrix[r,6]);
                if RangeMatrix[r,7] <> '' then
                   WriteAttributeString('nom2',RangeMatrix[r,7]);
                if RangeMatrix[r,8] <> '' then
                   WriteAttributeString('raz',RangeMatrix[r,8]);
                WriteAttributeString('dir',RangeMatrix[r,9]);
                WriteAttributeString('dpto',RangeMatrix[r,10]);
                WriteAttributeString('num',RangeMatrix[r,11]);
                WriteAttributeString('mov',RangeMatrix[r,12]);
                WriteAttributeString('cta',RangeMatrix[r,13]);
                WriteAttributeString('ntitsec',RangeMatrix[r,14]);
                WriteAttributeString('tipcta',RangeMatrix[r,15]);
                valor := valor + RangeMatrix[r,12];
                contador := contador + 1;
                if RangeMatrix[r,14] > 0 then
                begin
                  CD1019.Filtered := False;
                  //ShowMessage('tdocp = ' + );// + ' and  nidcp = ' + RangeMatrix[r,2]);
                  CD1019.Filter := 'tdocp = ' + CurrToStr(RangeMatrix[r,1]) + ' and  nidp = ' + CurrToStr(RangeMatrix[r,2]);
                  CD1019.Filtered := True;
                  while not CD1019.Eof do
                  begin
                    nodo1 := Nodo.NodeNew('ticsec');
                    with nodo1 do
                    begin
                      WriteAttributeString('tdoc',CD1019.FieldByName('tdoc').AsString);
                      WriteAttributeString('nidsec',CD1019.FieldByName('nidsec').AsString);
                      if CD1019.FieldByName('dv').AsString <> '' then
                         WriteAttributeString('dv',CD1019.FieldByName('dv').AsString);
                      if CD1019.FieldByName('apl1').AsString <> '' then
                         WriteAttributeString('apl1',CD1019.FieldByName('apl1').AsString);
                      if CD1019.FieldByName('apl2').AsString <> '' then
                         WriteAttributeString('apl2',CD1019.FieldByName('apl2').AsString);
                      if CD1019.FieldByName('nom1').AsString <> '' then
                         WriteAttributeString('nom1',CD1019.FieldByName('nom1').AsString);
                      if CD1019.FieldByName('nom2').AsString <> '' then
                         WriteAttributeString('nom2',CD1019.FieldByName('nom2').AsString);
                      if CD1019.FieldByName('raz').AsString <> '' then
                         WriteAttributeString('raz',CD1019.FieldByName('raz').AsString);
                      CD1019.Next;
                    end;
                  end;
                end;
              end;
              //inicio de la validacion del numero de registros
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile('c:\exogena\' + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfReadable;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','1019.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');
                ANode.WriteInteger('Ano',YearOf(Date));
                ANode.WriteString('CodCpt','01');
                ANode.WriteInteger('Formato',1019);
                ANode.WriteInteger('NunEnvio',1);
                ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
                ANode.WriteString('FecInicial','2005-01-01');
                ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);

              end; // fin de la valiudacion del numero de registros
        end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile('c:\exogena\' + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end;

end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
          XLApp.Quit;
          XLAPP := Unassigned;
          Sheet := Unassigned;
          FreeAndNil(xlapp);
          CanClose := True;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
       xml.Navigate('c:\exogena\' + CBarchivos.Text);
end;

end.
