unit UnitExogena;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, XStringGrid, StdCtrls, JvDialogs, Buttons,sdXmlDocuments,DateUtils,
  DB, DBClient, OleCtrls, SHDocVw, JvEdit, JvTypedEdit, ComCtrls, ExtCtrls;

type
  TFrmExogena = class(TForm)
    jv: TJvOpenDialog;
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
    Op: TOpenDialog;
    Label5: TLabel;
    r: TRichEdit;
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    CBhoja: TComboBox;
    EDlibro: TEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CBarchivos: TComboBox;
    Label6: TLabel;
    Panel2: TPanel;
    CHinsercion: TCheckBox;
    Label4: TLabel;
    jVNumero: TJvIntegerEdit;
    Ch: TCheckBox;
    Button2: TButton;
    jvConsecutivo: TJvIntegerEdit;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure ChClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);

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
  RutaSalida :string;
    function Xls_To_StringGrid(AGrid1: TXStringGrid;
      AXLSFile: string): Boolean;
    procedure encabezado(formato: string);
    procedure encabezado1;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExogena: TFrmExogena;

implementation
uses
  ComObj, UnitPantallaProgreso;
{$R *.dfm}

function TFrmExogena.Xls_To_StringGrid(AGrid1: TXStringGrid;AXLSFile: string): Boolean;

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

procedure TFrmExogena.Button1Click(Sender: TObject);
begin
        if Op.Execute then
           EDlibro.Text := Op.FileName;
        if Op.FileName = '' then
        begin
           MessageDlg('Debe Seleccionar un Archivo',mtInformation,[mbok],0);
           Exit;
        end;
        RutaSalida := ExtractFileDir(Op.FileName) + '\salida';
        if not DirectoryExists(RutaSalida) then
           CreateDir(RutaSalida);
        Label5.Caption := 'Ruta de Resultados : ' + RutaSalida;
        //
        //RutaSalida := RutaSalida + '\';
        if Cargado then
        begin
              XLApp.Quit;
              XLAPP := Unassigned;
              Sheet := Unassigned;
        end;
          if Xls_To_StringGrid(Agrid, EDlibro.Text) then
          begin
            ShowMessage('Archivo Cargado');
            Cargado := True;
            BitBtn1.Enabled := True;
            Button1.Enabled := False;
          end;
end;

procedure TFrmExogena.FormCreate(Sender: TObject);
begin
        Cargado := False;
        xml.Navigate('about:blank');
end;

procedure TFrmExogena.encabezado(formato: string);
var  r: Integer;
begin
end;

procedure TFrmExogena.BitBtn1Click(Sender: TObject);
begin
        encabezado1;
        xml.Navigate('about:blank');
        r.Lines.Clear;
        xml.Visible := True;
        r.Visible := False;
end;

procedure TFrmExogena.encabezado1;
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
        if jvConsecutivo.Value = 0 then
        begin
           MessageDlg('Favor Ingrese el Numero de Consecutivo',mtInformation,[mbok],0);
           Exit;
        end;
        nMaximo := jVNumero.Value;
        if CHinsercion.Checked then
           Insercion := '01'
        else
           Insercion := '02';
        consecutivo := 1;
        RDoc := TsdXmlDocument.Createname('mas');
        RDoc.EncodingString := 'ISO8859-1';
        RDoc.XmlFormat := xfCompact;
        valor := 0;
        contador := 0;
        CBarchivos.Clear;
        RutaSalida := RutaSalida + '\' + 'Formato' +  CBhoja.Text;
        if not DirectoryExists(RutaSalida) then
           CreateDir(RutaSalida);
        RutaSalida := RutaSalida + '\';

//*****************************************formato 1019 ******************************************

        if CBhoja.Text = '1019' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + insercion + '01906' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
         try
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
          except
            CD1019.CancelUpdates;
          end;
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1019.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1019);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
                WriteAttributeString('mun',RangeMatrix[r,11]);
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
                    nodo1 := Nodo.NodeNew('titSec');
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
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1019.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1019);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
          ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
          ANode.WriteString('FecInicial','2005-01-01');
          ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);

              end; // fin de la valiudacion del numero de registros
        end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end
//**********************************************fin formato 1019****************

//*********************************************formato 1020 *******************
        else if CBhoja.Text = '1020' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0102006' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1020.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1020);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
            Nodo := RDoc.Root.NodeNew('invcdt');
            with Nodo do
            begin
              WriteAttributeString('tdoc',RangeMatrix[r,1]);
              WriteAttributeString('nid',RangeMatrix[r,2]);
              try
              if RangeMatrix[r,3] <> '' then
                 WriteAttributeString('dv',RangeMatrix[r,3]);
              except
                 WriteAttributeString('dv',RangeMatrix[r,3]);
              end;
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
              WriteAttributeString('mun',RangeMatrix[r,11]);
              if CurrToStr(RangeMatrix[r,12]) <> '' then
                 WriteAttributeString('salini',RangeMatrix[r,12]);
              WriteAttributeString('inv',RangeMatrix[r,13]);
              if RangeMatrix[r,14] then
                 WriteAttributeString('ren',RangeMatrix[r,14]);
              WriteAttributeString('saldic',RangeMatrix[r,15]);
              WriteAttributeString('ntit',RangeMatrix[r,16]);
              WriteAttributeString('numt',RangeMatrix[r,17]);
              valor := valor + RangeMatrix[r,13];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1020.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1020);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
          ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
          ANode.WriteString('FecInicial','2005-01-01');
          ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end
//*************************************fin formato 1020 ******************************

//*************************************formato 1021 **********************************
        else if CBhoja.Text = '1021' then//formato 1021
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0102106' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1021.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1021);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',1);
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
            Nodo := RDoc.Root.NodeNew('invs');
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
              if CurrToStr(RangeMatrix[r,12]) <> '' then
                 WriteAttributeString('salini',RangeMatrix[r,12]);
              WriteAttributeString('inv',RangeMatrix[r,13]);
              if RangeMatrix[r,14] then
                 WriteAttributeString('ren',RangeMatrix[r,14]);
              WriteAttributeString('saldic',RangeMatrix[r,15]);
              WriteAttributeString('ntit',RangeMatrix[r,16]);
              WriteAttributeString('numt',RangeMatrix[r,17]);
              WriteAttributeString('tfon',RangeMatrix[r,18]);
              valor := valor + RangeMatrix[r,13];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1021.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1021);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',1);
          ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
          ANode.WriteString('FecInicial','2005-01-01');
          ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end
//***********************************************fin formato 1021**********************************

//***********************************************formato 1022 *************************************
        else if CBhoja.Text = '1022' then//formato 1022
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0102206' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1022.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1022);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',1);
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
            Nodo := RDoc.Root.NodeNew('afp');
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
              WriteAttributeString('mun',RangeMatrix[r,11]);
              if CurrToStr(RangeMatrix[r,12]) <> '' then
                 WriteAttributeString('sal',RangeMatrix[r,12]);
              WriteAttributeString('aho',RangeMatrix[r,13]);
              if RangeMatrix[r,14] then
                 WriteAttributeString('ret',RangeMatrix[r,14]);
              if RangeMatrix[r,15] then
              WriteAttributeString('ren',RangeMatrix[r,15]);
              WriteAttributeString('saldic',RangeMatrix[r,16]);
              valor := valor + RangeMatrix[r,13];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1022.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1022);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',1);
          ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
          ANode.WriteString('FecInicial','2005-01-01');
          ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end
//********************************* fin formato 1022 *****************

//***********************************************formato 1023 *************************************
        else if CBhoja.Text = '1023' then//formato 1023
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0102306' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1023.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1023);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',1);
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
            Nodo := RDoc.Root.NodeNew('consumos');
            with Nodo do
            begin
              WriteAttributeString('ctar',RangeMatrix[r,1]);
              WriteAttributeString('tdoc',RangeMatrix[r,2]);
              WriteAttributeString('nid',RangeMatrix[r,3]);
              if RangeMatrix[r,4] <> '' then
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              if RangeMatrix[r,5] <> '' then
                 WriteAttributeString('apl1',RangeMatrix[r,5]);
              if RangeMatrix[r,6] <> '' then
                 WriteAttributeString('apl2',RangeMatrix[r,6]);
              if RangeMatrix[r,7] <> '' then
                 WriteAttributeString('nom1',RangeMatrix[r,7]);
              if RangeMatrix[r,8] <> '' then
                 WriteAttributeString('nom2',RangeMatrix[r,8]);
              if RangeMatrix[r,9] <> '' then
                 WriteAttributeString('raz',RangeMatrix[r,9]);
              WriteAttributeString('dir',RangeMatrix[r,10]);
              WriteAttributeString('dpto',RangeMatrix[r,11]);
              WriteAttributeString('mun',RangeMatrix[r,12]);
              WriteAttributeString('adq',RangeMatrix[r,13]);
              WriteAttributeString('ntar',RangeMatrix[r,14]);
              valor := valor + RangeMatrix[r,13];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','1023.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1023);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',1);
          ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
          ANode.WriteString('FecInicial','2005-01-01');
          ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end
//****************************** fin formato 1023********************************
//***********************************************formato 1024 *************************************
        else if CBhoja.Text = '1024' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0102406' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1024.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1024);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',1);
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
            Nodo := RDoc.Root.NodeNew('ventastc');
            with Nodo do
            begin
              WriteAttributeString('nit',RangeMatrix[r,1]);
              WriteAttributeString('dv',RangeMatrix[r,2]);
              if RangeMatrix[r,3] <> '' then
                 WriteAttributeString('apl1',RangeMatrix[r,3]);
              if RangeMatrix[r,4] <> '' then
                 WriteAttributeString('apl2',RangeMatrix[r,4]);
              if RangeMatrix[r,5] <> '' then
                 WriteAttributeString('nom1',RangeMatrix[r,5]);
              if RangeMatrix[r,6] <> '' then
                 WriteAttributeString('nom2',RangeMatrix[r,6]);
              if RangeMatrix[r,7] <> '' then
                 WriteAttributeString('raz',RangeMatrix[r,7]);
              WriteAttributeString('dir',RangeMatrix[r,8]);
              WriteAttributeString('dpto',RangeMatrix[r,9]);
              WriteAttributeString('mun',RangeMatrix[r,10]);
              WriteAttributeString('val',RangeMatrix[r,11]);
              WriteAttributeString('iva',RangeMatrix[r,12]);
              valor := valor + RangeMatrix[r,11];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','1024.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1024);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',1);
          ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
          ANode.WriteString('FecInicial','2005-01-01');
          ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end
//****************************** fin formato 1024********************************
//***********************************************formato 1025 *************************************
        else if CBhoja.Text = '1025' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0102506' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','1025.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1025);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',1);
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
            Nodo := RDoc.Root.NodeNew('difcon');
            with Nodo do
            begin
              WriteAttributeString('cod',RangeMatrix[r,1]);
              WriteAttributeString('nit',RangeMatrix[r,2]);
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
              WriteAttributeString('vcon',RangeMatrix[r,9]);
              WriteAttributeString('vfis',RangeMatrix[r,10]);
              valor := valor + RangeMatrix[r,9];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','1025.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1025);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',1);
          ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
          ANode.WriteString('FecInicial','2005-01-01');
          ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',consecutivo) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end
//****************************** fin formato 1025********************************
//***********************************************formato 1026 *************************************
        else if CBhoja.Text = '1026' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0102606' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1026.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1026);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
            Nodo := RDoc.Root.NodeNew('prestamos');
            with Nodo do
            begin
            try

              WriteAttributeString('cod',RangeMatrix[r,1]);
              WriteAttributeString('tdoc',RangeMatrix[r,2]);
              WriteAttributeString('nid',RangeMatrix[r,3]);
              try
              if RangeMatrix[r,4] <> '' then
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              except
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              end;
              if RangeMatrix[r,5] <> '' then
                 WriteAttributeString('apl1',RangeMatrix[r,5]);
              if RangeMatrix[r,6] <> '' then
                 WriteAttributeString('apl2',RangeMatrix[r,6]);
              if RangeMatrix[r,7] <> '' then
                 WriteAttributeString('nom1',RangeMatrix[r,7]);
              if RangeMatrix[r,8] <> '' then
                 WriteAttributeString('nom2',RangeMatrix[r,8]);
              if RangeMatrix[r,9] <> '' then
                 WriteAttributeString('raz',RangeMatrix[r,9]);
              WriteAttributeString('dir',RangeMatrix[r,10]);
              WriteAttributeString('dpto',RangeMatrix[r,11]);
              WriteAttributeString('mun',RangeMatrix[r,12]);
              WriteAttributeString('val',RangeMatrix[r,13]);
            except
              ShowMessage(RangeMatrix[r,2]);
            end;
              valor := valor + RangeMatrix[r,13];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','1026.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');//
                ANode.WriteInteger('Ano',YearOf(Date));
                ANode.WriteString('CodCpt','1');
                ANode.WriteInteger('Formato',1026);
                ANode.WriteString('Version','6');
                ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
                ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
                ANode.WriteString('FecInicial','2005-01-01');
                 ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);     //
              end; // fin de la valiudacion del numero de registros

         end;//fin del for

              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end
//****************************** fin formato 1026******************************** //
//****************************** inicio formato 1001 ***************************//
        else if CBhoja.Text = '1001' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0100106' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1001.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1001);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
            Nodo := RDoc.Root.NodeNew('pagos');
            with Nodo do
            begin
              WriteAttributeString('cpt',RangeMatrix[r,1]);
              WriteAttributeString('tdoc',RangeMatrix[r,2]);
              WriteAttributeString('nid',RangeMatrix[r,3]);
              try
              if RangeMatrix[r,4] <> '' then
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              except
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              end;
              if RangeMatrix[r,5] <> '' then
                 WriteAttributeString('apl1',RangeMatrix[r,5]);
              if RangeMatrix[r,6] <> '' then
                 WriteAttributeString('apl2',RangeMatrix[r,6]);
              if RangeMatrix[r,7] <> '' then
                 WriteAttributeString('nom1',RangeMatrix[r,7]);
              if RangeMatrix[r,8] <> '' then
                 WriteAttributeString('nom2',RangeMatrix[r,8]);
              if RangeMatrix[r,9] <> '' then
                 WriteAttributeString('raz',RangeMatrix[r,9]);
              WriteAttributeString('dir',RangeMatrix[r,10]);
              WriteAttributeString('dpto',RangeMatrix[r,11]);
              WriteAttributeString('mun',RangeMatrix[r,12]);
              WriteAttributeString('pag',RangeMatrix[r,13]);
              valor := valor + RangeMatrix[r,13];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','./xsd/1001.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');//
                ANode.WriteInteger('Ano',YearOf(Date));
                ANode.WriteString('CodCpt','1');
                ANode.WriteInteger('Formato',1001);
                ANode.WriteString('Version','6');
                ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
                ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
                ANode.WriteString('FecInicial','2005-01-01');
                 ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);     //
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end

//****************************** fin del formato 1001 **************************//
//****************************** inicio del formato 1002 **************************//
        else if CBhoja.Text = '1002' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0100206' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1002.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1002);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
            Nodo := RDoc.Root.NodeNew('rets');
            with Nodo do
            begin
              WriteAttributeString('cpt',RangeMatrix[r,1]);
              WriteAttributeString('tdoc',RangeMatrix[r,2]);
              WriteAttributeString('nid',RangeMatrix[r,3]);
              try
              if RangeMatrix[r,4] <> '' then
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              except
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              end;
              if RangeMatrix[r,5] <> '' then
                 WriteAttributeString('apl1',RangeMatrix[r,5]);
              if RangeMatrix[r,6] <> '' then
                 WriteAttributeString('apl2',RangeMatrix[r,6]);
              if RangeMatrix[r,7] <> '' then
                 WriteAttributeString('nom1',RangeMatrix[r,7]);
              if RangeMatrix[r,8] <> '' then
                 WriteAttributeString('nom2',RangeMatrix[r,8]);
              if RangeMatrix[r,9] <> '' then
                 WriteAttributeString('raz',RangeMatrix[r,9]);
              WriteAttributeString('dir',RangeMatrix[r,10]);
              WriteAttributeString('dpto',RangeMatrix[r,11]);
              WriteAttributeString('mun',RangeMatrix[r,12]);
              WriteAttributeString('vabo',RangeMatrix[r,13]);
              WriteAttributeString('vret',RangeMatrix[r,14]);
              valor := valor + RangeMatrix[r,14];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','./xsd/1002.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');//
                ANode.WriteInteger('Ano',YearOf(Date));
                ANode.WriteString('CodCpt','1');
                ANode.WriteInteger('Formato',1002);
                ANode.WriteString('Version','6');
                ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
                ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
                ANode.WriteString('FecInicial','2005-01-01');
                 ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);     //
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end

//****************************** fin del formato 1002 *****************************//
//******************************* incio fromato 1008 ******************************//
        else if CBhoja.Text = '1008' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0100806' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1008.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1008);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
            Nodo := RDoc.Root.NodeNew('saldoscc');
            with Nodo do
            begin
              WriteAttributeString('cpt',RangeMatrix[r,1]);
              WriteAttributeString('tdoc',RangeMatrix[r,2]);
              WriteAttributeString('nid',RangeMatrix[r,3]);
              try
              if RangeMatrix[r,4] <> '' then
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              except
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              end;
              if RangeMatrix[r,5] <> '' then
                 WriteAttributeString('apl1',RangeMatrix[r,5]);
              if RangeMatrix[r,6] <> '' then
                 WriteAttributeString('apl2',RangeMatrix[r,6]);
              if RangeMatrix[r,7] <> '' then
                 WriteAttributeString('nom1',RangeMatrix[r,7]);
              if RangeMatrix[r,8] <> '' then
                 WriteAttributeString('nom2',RangeMatrix[r,8]);
              if RangeMatrix[r,9] <> '' then
                 WriteAttributeString('raz',RangeMatrix[r,9]);
              WriteAttributeString('dir',RangeMatrix[r,10]);
              WriteAttributeString('dpto',RangeMatrix[r,11]);
              WriteAttributeString('mun',RangeMatrix[r,12]);
              WriteAttributeString('sal',RangeMatrix[r,13]);
              valor := valor + RangeMatrix[r,13];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1008.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');//
                ANode.WriteInteger('Ano',YearOf(Date));
                ANode.WriteString('CodCpt','1');
                ANode.WriteInteger('Formato',1008);
                ANode.WriteString('Version','6');
                ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
                ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
                ANode.WriteString('FecInicial','2005-01-01');
                 ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);     //
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end


//******************************* fin formato 1008 ********************************//
//******************************* inicio formato 1009 *****************************//
        else if CBhoja.Text = '1009' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0100906' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1009.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1009);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
            Nodo := RDoc.Root.NodeNew('saldoscp');
            with Nodo do
            begin
              WriteAttributeString('cpt',RangeMatrix[r,1]);
              WriteAttributeString('tdoc',RangeMatrix[r,2]);
              WriteAttributeString('nid',RangeMatrix[r,3]);
              try
              if RangeMatrix[r,4] <> '' then
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              except
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              end;
              if RangeMatrix[r,5] <> '' then
                 WriteAttributeString('apl1',RangeMatrix[r,5]);
              if RangeMatrix[r,6] <> '' then
                 WriteAttributeString('apl2',RangeMatrix[r,6]);
              if RangeMatrix[r,7] <> '' then
                 WriteAttributeString('nom1',RangeMatrix[r,7]);
              if RangeMatrix[r,8] <> '' then
                 WriteAttributeString('nom2',RangeMatrix[r,8]);
              if RangeMatrix[r,9] <> '' then
                 WriteAttributeString('raz',RangeMatrix[r,9]);
              WriteAttributeString('dir',RangeMatrix[r,10]);
              WriteAttributeString('dpto',RangeMatrix[r,11]);
              WriteAttributeString('mun',RangeMatrix[r,12]);
              WriteAttributeString('sal',RangeMatrix[r,13]);
              valor := valor + RangeMatrix[r,13];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1009.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');//
                ANode.WriteInteger('Ano',YearOf(Date));
                ANode.WriteString('CodCpt','1');
                ANode.WriteInteger('Formato',1009);
                ANode.WriteString('Version','6');
                ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
                ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
                ANode.WriteString('FecInicial','2005-01-01');
                 ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);     //
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end


//******************************* fin formato 1009 ********************************//
//******************************* inicio formato 1011 *****************************//
        else if CBhoja.Text = '1011' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0101106' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1011.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1011);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
            Nodo := RDoc.Root.NodeNew('decl');
            with Nodo do
            begin
              WriteAttributeString('cpt',RangeMatrix[r,1]);
              WriteAttributeString('sal',RangeMatrix[r,2]);
              valor := valor + RangeMatrix[r,2];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1011.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');//
                ANode.WriteInteger('Ano',YearOf(Date));
                ANode.WriteString('CodCpt','1');
                ANode.WriteInteger('Formato',1011);
                ANode.WriteString('Version','6');
                ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
                ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
                ANode.WriteString('FecInicial','2005-01-01');
                 ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);     //
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end

//******************************* fin foemato 1011 ********************************//
//******************************* inicio formato 1012 *****************************//
        else if CBhoja.Text = '1012' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0101206' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1012.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1012);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
            Nodo := RDoc.Root.NodeNew('dectri');
            with Nodo do
            begin
              WriteAttributeString('cpt',RangeMatrix[r,1]);
              WriteAttributeString('tdoc',RangeMatrix[r,2]);
              WriteAttributeString('nid',RangeMatrix[r,3]);
              try
              if RangeMatrix[r,4] <> '' then
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              except
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              end;
              if RangeMatrix[r,5] <> '' then
                 WriteAttributeString('apl1',RangeMatrix[r,5]);
              if RangeMatrix[r,6] <> '' then
                 WriteAttributeString('apl2',RangeMatrix[r,6]);
              if RangeMatrix[r,7] <> '' then
                 WriteAttributeString('nom1',RangeMatrix[r,7]);
              if RangeMatrix[r,8] <> '' then
                 WriteAttributeString('nom2',RangeMatrix[r,8]);
              if RangeMatrix[r,9] <> '' then
                 WriteAttributeString('raz',RangeMatrix[r,9]);
              WriteAttributeString('val',RangeMatrix[r,10]);
              valor := valor + RangeMatrix[r,10];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1012.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');//
                ANode.WriteInteger('Ano',YearOf(Date));
                ANode.WriteString('CodCpt','1');
                ANode.WriteInteger('Formato',1012);
                ANode.WriteString('Version','6');
                ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
                ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
                ANode.WriteString('FecInicial','2005-01-01');
                 ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);     //
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end

//******************************* fin formato 1012 ********************************//
//******************************* inicio formato 1005 *****************************//
        else if CBhoja.Text = '1005' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0100506' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1005.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1005);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
            Nodo := RDoc.Root.NodeNew('impventas');
            with Nodo do
            begin
              WriteAttributeString('tdoc',RangeMatrix[r,1]);
              WriteAttributeString('nid',RangeMatrix[r,2]);
              try
              if RangeMatrix[r,3] <> '' then
                 WriteAttributeString('dv',RangeMatrix[r,3]);
              except
                 WriteAttributeString('dv',RangeMatrix[r,3]);
              end;
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
              WriteAttributeString('vimp',RangeMatrix[r,9]);
              valor := valor + RangeMatrix[r,9];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1005.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');//
                ANode.WriteInteger('Ano',YearOf(Date));
                ANode.WriteString('CodCpt','1');
                ANode.WriteInteger('Formato',1005);
                ANode.WriteString('Version','6');
                ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
                ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
                ANode.WriteString('FecInicial','2005-01-01');
                 ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);     //
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end
//******************************* fin formato 1005 ********************************//
//******************************* inicio formato 1007 ****************************//
        else if CBhoja.Text = '1007' then
        begin
          cArchivo := 'Dmuisca_' + Insercion + '0100706' + IntToStr(YearOf(Date));// + FormatCurr('00000000',consecutivo);
          nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
          with RDoc.Root do
          begin
              WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
              WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1007.xsd');
          end;
          ANode := RDoc.Root.NodeNew('Cab');
          ANode.WriteInteger('Ano',YearOf(Date));
          ANode.WriteString('CodCpt','1');
          ANode.WriteInteger('Formato',1007);
          ANode.WriteString('Version','6');
          ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
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
            Nodo := RDoc.Root.NodeNew('ingresos');
            with Nodo do
            begin
              WriteAttributeString('cpt',RangeMatrix[r,1]);
              WriteAttributeString('tdoc',RangeMatrix[r,2]);
              WriteAttributeString('nid',RangeMatrix[r,3]);
              try
              if RangeMatrix[r,4] <> '' then
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              except
                 WriteAttributeString('dv',RangeMatrix[r,4]);
              end;
              if RangeMatrix[r,5] <> '' then
                 WriteAttributeString('apl1',RangeMatrix[r,5]);
              if RangeMatrix[r,6] <> '' then
                 WriteAttributeString('apl2',RangeMatrix[r,6]);
              if RangeMatrix[r,7] <> '' then
                 WriteAttributeString('nom1',RangeMatrix[r,7]);
              if RangeMatrix[r,8] <> '' then
                 WriteAttributeString('nom2',RangeMatrix[r,8]);
              if RangeMatrix[r,9] <> '' then
                 WriteAttributeString('raz',RangeMatrix[r,9]);
              WriteAttributeString('ing',RangeMatrix[r,10]);
              //WriteAttributeString('dev',RangeMatrix[r,11]);
              valor := valor + RangeMatrix[r,10];
              contador := contador + 1;
            end;//validacion para maximo de archivos
              if (contador = nMaximo) and (r < x) then
              begin
                if consecutivo > 1 then
                   nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
                ANode.WriteString('ValorTotal',CurrToStr(valor));
                ANode.WriteString('CantReg',IntToStr(contador));
                RDoc.SaveToFile(RutaSalida + nArchivo);
                contador := 0;
                valor := 0;
                consecutivo := consecutivo + 1;
                RDoc.Clear;
                RDoc := TsdXmlDocument.Createname('mas');
                RDoc.EncodingString := 'ISO8859-1';
                RDoc.XmlFormat := xfCompact;
                with RDoc.Root do
                begin
                  WriteAttributeString('xmlns:xsi','http://www.w3.org/2001/XMLSchema-instance');
                  WriteAttributeString('xsi:noNamespaceSchemaLocation','../xsd/1012.xsd');
                end;
                ANode := RDoc.Root.NodeNew('Cab');//
                ANode.WriteInteger('Ano',YearOf(Date));
                ANode.WriteString('CodCpt','1');
                ANode.WriteInteger('Formato',1012);
                ANode.WriteString('Version','6');
                ANode.WriteInteger('NumEnvio',jvConsecutivo.Value);
                ANode.WriteString('FecEnvio',FormatDateTime('yyyy-MM-dd''T''HH:mm:ss',now));
                ANode.WriteString('FecInicial','2005-01-01');
                 ANode.WriteString('FecFinal','2005-12-31');
                CBarchivos.Items.Add(nArchivo);     //
              end; // fin de la valiudacion del numero de registros

         end;//fin del for
              nArchivo := cArchivo + FormatCurr('00000000',jvConsecutivo.Value) + '.xml';
              ANode.WriteString('ValorTotal',CurrToStr(valor));
              ANode.WriteString('CantReg',IntToStr(contador));
              RDoc.SaveToFile(RutaSalida + nArchivo);
              CBarchivos.Items.Add(nArchivo);
              frmProgreso.Cerrar;
        end


//******************************* fin formato 1007 *******************************//
 end;
procedure TFrmExogena.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
        if Cargado then
        begin
          XLApp.Quit;
          XLAPP := Unassigned;
          Sheet := Unassigned;
        end;
        CanClose := True;
end;

procedure TFrmExogena.BitBtn2Click(Sender: TObject);
begin
       xml.Navigate(RutaSalida + CBarchivos.Text);
       r.Lines.LoadFromFile(RutaSalida + CBarchivos.Text);
end;

procedure TFrmExogena.ChClick(Sender: TObject);
begin
        if Ch.Checked then
        begin
           r.Visible := True;
           xml.Visible := False;
        end
        else
        begin
           xml.Visible := True;
           r.Visible := False;
        end;
end;

procedure TFrmExogena.Button2Click(Sender: TObject);
begin
        try
          if Cargado then
          begin
            XLApp.Quit;
            XLAPP := Unassigned;
            Sheet := Unassigned;
            EDlibro.Text := '';
            CBhoja.Clear;
            CBarchivos.Clear;
            Cargado := False;
          end;
        except
          Cargado := False;
        end;
        xml.Navigate('about:blank');
        r.Lines.Clear;
        Button1.Enabled := True;
        BitBtn1.Enabled := True;
end;

end.
