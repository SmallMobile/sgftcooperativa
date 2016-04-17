unit UnitLineasVsTotal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TeeProcs, TeEngine, Chart, ExtCtrls, Series,
  IBDatabase, DB, IBCustomDataSet, IBQuery, StdCtrls, Buttons, DbChart,
  Grids, DBGrids, FR_Chart, FR_Class, FR_DSet, FR_DBSet, FR_Shape, sdXMLDocuments,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, DBClient,
  IBStoredProc, JvComponent, JvDlg;

type
  TfrmLineasVsCartera = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    IBQuery1: TIBQuery;
    IBTransaction1: TIBTransaction;
    btnCerrar: TBitBtn;
    btnImprimir: TBitBtn;
    DS1: TDataSource;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    IBQuery1ID_LINEA: TSmallintField;
    IBQuery1DESCRIPCION_LINEA: TIBStringField;
    IBQuery1CANTIDAD: TIntegerField;
    IBQuery1DEUDA: TIBBCDField;
    EdCantidad: TStaticText;
    EdDeuda: TStaticText;
    IBQuery2: TIBQuery;
    Label1: TLabel;
    Label2: TLabel;
    frReport1: TfrReport;
    frChartObject1: TfrChartObject;
    frDBDataSet1: TfrDBDataSet;
    frDBDataSet2: TfrDBDataSet;
    frShapeObject1: TfrShapeObject;
    IBQuery1PORCENTAJE: TFloatField;
    IdTCPClient1: TIdTCPClient;
    CDS: TClientDataSet;
    CDSAGENCIA: TIntegerField;
    CDSID_LINEA: TIntegerField;
    CDSDESCRIPCION_LINEA: TStringField;
    CDSCANTIDAD: TIntegerField;
    CDSDEUDA: TCurrencyField;
    CDSPORCENTAJE: TFloatField;
    IBsp1: TIBStoredProc;
    IBQuery1AGENCIA: TIntegerField;
    DBChart1: TDBChart;
    Series1: THorizBarSeries;
    PageControl1: TPageControl;
    Tab01: TTabSheet;
    Tab03: TTabSheet;
    TabConsol: TTabSheet;
    Tab02: TTabSheet;
    Panel5: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    DBGrid2: TDBGrid;
    EdCantidad02: TStaticText;
    EdDeuda02: TStaticText;
    Panel4: TPanel;
    DBChart2: TDBChart;
    HorizBarSeries1: THorizBarSeries;
    Panel6: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    DBGrid3: TDBGrid;
    EdCantidad03: TStaticText;
    EdDeuda03: TStaticText;
    Panel7: TPanel;
    DBChart3: TDBChart;
    HorizBarSeries2: THorizBarSeries;
    CDS02: TClientDataSet;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    IntegerField3: TIntegerField;
    CurrencyField1: TCurrencyField;
    FloatField1: TFloatField;
    CDS03: TClientDataSet;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    StringField2: TStringField;
    IntegerField6: TIntegerField;
    CurrencyField2: TCurrencyField;
    FloatField2: TFloatField;
    CDSConsol: TClientDataSet;
    IntegerField8: TIntegerField;
    StringField3: TStringField;
    IntegerField9: TIntegerField;
    CurrencyField3: TCurrencyField;
    FloatField3: TFloatField;
    frmBar: TJvProgressForm;
    DS2: TDataSource;
    DS3: TDataSource;
    Panel8: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    DBGrid4: TDBGrid;
    EdCantidadConsol: TStaticText;
    EdDeudaConsol: TStaticText;
    Panel9: TPanel;
    DBChart4: TDBChart;
    HorizBarSeries3: THorizBarSeries;
    DSConsol: TDataSource;
    frDBDataSet3: TfrDBDataSet;
    frDBDataSet4: TfrDBDataSet;
    procedure btnCerrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
     procedure ExtraerRemoto(puerto,idagencia: integer; Hostr: string);  
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLineasVsCartera: TfrmLineasVsCartera;

implementation

{$R *.dfm}

uses UnitDmGeneral, UnitGlobales;

procedure TfrmLineasVsCartera.btnCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmLineasVsCartera.FormCreate(Sender: TObject);
var
   tCantidad:Integer;
   tDeuda:Currency;
begin
        frmBar.Execute;
        frmBar.InfoLabel := 'leyendo oficina Ocaña...';
        frmBar.ProgressStepIt;
        Application.ProcessMessages;
        with IBQuery1 do
        begin
         if Transaction.InTransaction then
            Transaction.Rollback;
         Transaction.StartTransaction;
         Close;
         SQL.Clear;
         SQL.Add('select * from P_LINEASVSCARTERA');
         try
          Open;
{
        with IBsp1 do
         begin
          if Transaction.InTransaction then
             Transaction.Rollback;
          Transaction.StartTransaction;
          Close;
         try 
          ExecProc; }
          while not Eof do
          begin
                  CDS.Open;
                  CDS.Append;
                  CDS.FieldByName('AGENCIA').AsInteger := FieldByName('AGENCIA').AsInteger;
                  CDS.FieldByName('ID_LINEA').AsInteger := FieldByName('ID_LINEA').AsInteger;
                  CDS.FieldByName('DESCRIPCION_LINEA').AsString := Fieldbyname('DESCRIPCION_LINEA').AsString;
                  CDS.FieldByName('CANTIDAD').AsInteger := FieldByName('CANTIDAD').AsInteger;
                  CDS.FieldByName('DEUDA').AsCurrency := FieldByName('DEUDA').AsCurrency;
                  CDS.FieldByName('PORCENTAJE').AsFloat := FieldByName('PORCENTAJE').AsFloat;
                  CDS.Post;
                  CDS.Close;
                  Next;
          end;
          CDS.Open;
          CDS.First;
         except
          raise;
          Exit;
         end;
        end;

        with IBQuery2 do
        begin
         Close;
         SQL.Clear;
         SQL.Add('select COUNT(*) AS CANTIDAD, SUM(VALOR_DESEMBOLSO - ABONOS_CAPITAL) AS DEUDA from "col$colocacion"');
         SQL.Add('where ID_ESTADO_COLOCACION < 3');
         try
          Open;
          EdCantidad.Caption := FormatCurr('#,0',IBQuery2.FieldByName('CANTIDAD').AsInteger);
          EdDeuda.Caption := FormatCurr('$#,0',IBQuery2.FieldByName('DEUDA').AsCurrency);
         except
          raise;
          Exit;
         end;
        end;

        frmBar.InfoLabel := 'leyendo oficina Abrego...';
        frmBar.ProgressStepIt;
        Application.ProcessMessages;
        Extraerremoto(3052,2,'');
        frmBar.InfoLabel := 'leyendo oficina Convención...';
        frmBar.ProgressStepIt;
        Application.ProcessMessages;        
        Extraerremoto(3052,3,'');
        tCantidad := 0;
        tDeuda := 0;
        CDS02.Open;
        while not CDS02.Eof do
        begin
         tCantidad := tCantidad + CDS02.FieldByName('CANTIDAD').AsInteger;
         tDeuda := tDeuda + CDS02.FieldByName('DEUDA').AsFloat;
         CDS02.Next;
        end;
        EdCantidad02.Caption := FormatCurr('#,0',tCantidad);
        EdDeuda02.Caption := FormatCurr('$#,0',tDeuda);
        tCantidad := 0;
        tDeuda :=0;
        CDS03.Open;
        while not CDS03.Eof do
        begin
         tCantidad := tCantidad + CDS03.FieldByName('CANTIDAD').AsInteger;
         tDeuda := tDeuda + CDS03.FieldByName('DEUDA').AsFloat;
         CDS03.Next;
        end;
        EdCantidad03.Caption := FormatCurr('#,0',tCantidad);
        EdDeuda03.Caption := FormatCurr('$#,0',tDeuda);
        frmBar.Free;

        tCantidad := 0;
        tDeuda := 0;

        with CDS do begin
         First;
         while not Eof do
         begin
          CDSConsol.Open;
          if CDSConsol.Locate('ID_LINEA',VarArrayOf([FieldByName('ID_LINEA').AsInteger]),[loCaseInsensitive]) then
          begin
              CDSConsol.Edit;
              CDSConsol.FieldByName('CANTIDAD').AsInteger := CDSConsol.FieldByName('CANTIDAD').AsInteger + FieldByName('CANTIDAD').AsInteger;
              CDSConsol.FieldByName('DEUDA').AsCurrency := CDSConsol.FieldByName('DEUDA').AsCurrency + FieldByName('DEUDA').AsCurrency;
              CDSConsol.Post;
              CDSConsol.Close;
          end
          else
          begin
              CDSConsol.Append;
              CDSConsol.FieldByName('ID_LINEA').AsInteger := FieldByName('ID_LINEA').AsInteger;
              CDSConsol.FieldByName('DESCRIPCION_LINEA').AsString := FieldByName('DESCRIPCION_LINEA').AsString;
              CDSConsol.FieldByName('CANTIDAD').AsInteger := FieldByName('CANTIDAD').AsInteger;
              CDSConsol.FieldByName('DEUDA').AsCurrency := FieldByName('DEUDA').AsCurrency;
              CDSConsol.FieldByName('PORCENTAJE').AsFloat := 0;
              CDSConsol.Post;
              CDSConsol.Close;
          end;
          tCantidad := tCantidad + FieldByName('CANTIDAD').AsInteger;
          tDeuda := tDeuda + FieldByName('DEUDA').AsCurrency;
          Next;
         end;
        end;

        with CDS02 do begin
         First;
         while not Eof do
         begin
          CDSConsol.Open;
          if CDSConsol.Locate('ID_LINEA',VarArrayOf([FieldByName('ID_LINEA').AsInteger]),[loCaseInsensitive]) then
          begin
              CDSConsol.Edit;
              CDSConsol.FieldByName('CANTIDAD').AsInteger := CDSConsol.FieldByName('CANTIDAD').AsInteger + FieldByName('CANTIDAD').AsInteger;
              CDSConsol.FieldByName('DEUDA').AsCurrency := CDSConsol.FieldByName('DEUDA').AsCurrency + FieldByName('DEUDA').AsCurrency;
              CDSConsol.Post;
              CDSConsol.Close;
          end
          else
          begin
              CDSConsol.Append;
              CDSConsol.FieldByName('ID_LINEA').AsInteger := FieldByName('ID_LINEA').AsInteger;
              CDSConsol.FieldByName('DESCRIPCION_LINEA').AsString := FieldByName('DESCRIPCION_LINEA').AsString;
              CDSConsol.FieldByName('CANTIDAD').AsInteger := FieldByName('CANTIDAD').AsInteger;
              CDSConsol.FieldByName('DEUDA').AsCurrency := FieldByName('DEUDA').AsCurrency;
              CDSConsol.FieldByName('PORCENTAJE').AsFloat := 0;
              CDSConsol.Post;
              CDSConsol.Close;
          end;
          tCantidad := tCantidad + FieldByName('CANTIDAD').AsInteger;
          tDeuda := tDeuda + FieldByName('DEUDA').AsCurrency;
          Next;
         end;
        end;

        with CDS03 do begin
         First;
         while not Eof do
         begin
          CDSConsol.Open;
          if CDSConsol.Locate('ID_LINEA',VarArrayOf([FieldByName('ID_LINEA').AsInteger]),[loCaseInsensitive]) then
          begin
              CDSConsol.Edit;
              CDSConsol.FieldByName('CANTIDAD').AsInteger := CDSConsol.FieldByName('CANTIDAD').AsInteger + FieldByName('CANTIDAD').AsInteger;
              CDSConsol.FieldByName('DEUDA').AsCurrency := CDSConsol.FieldByName('DEUDA').AsCurrency + FieldByName('DEUDA').AsCurrency;
              CDSConsol.Post;
              CDSConsol.Close;
          end
          else
          begin
              CDSConsol.Append;
              CDSConsol.FieldByName('ID_LINEA').AsInteger := FieldByName('ID_LINEA').AsInteger;
              CDSConsol.FieldByName('DESCRIPCION_LINEA').AsString := FieldByName('DESCRIPCION_LINEA').AsString;
              CDSConsol.FieldByName('CANTIDAD').AsInteger := FieldByName('CANTIDAD').AsInteger;
              CDSConsol.FieldByName('DEUDA').AsCurrency := FieldByName('DEUDA').AsCurrency;
              CDSConsol.FieldByName('PORCENTAJE').AsFloat := 0;
              CDSConsol.Post;
              CDSConsol.Close;
          end;
          tCantidad := tCantidad + FieldByName('CANTIDAD').AsInteger;
          tDeuda := tDeuda + FieldByName('DEUDA').AsCurrency;
          Next;
         end;
        end;

        with CDSConsol do begin
         Open;
         while not Eof do
         begin
           Edit;
           FieldByName('PORCENTAJE').AsFloat := (FieldByName('DEUDA').AsFloat / tDeuda ) * 100;
           Post;
           Next;
         end;
        end;

        EdCantidadConsol.Caption := FormatCurr('#,0',tCantidad);
        EdDeudaConsol.Caption := FormatCurr('$#,0',tDeuda);

        CDS.First;
        CDS02.First;
        CDS03.First;
        CDSConsol.First;




{        Serie1 := TPieSeries.Create(Self);
        Serie1.ParentChart := Chart1;
        Serie1.DataSource := DS1;

        Chart1.SeriesList.Clear;
        Chart1.SeriesList.Series[0] := Serie1;}
end;

procedure TfrmLineasVsCartera.btnImprimirClick(Sender: TObject);
var
 ruta:string;
begin
        ruta := ExtractFilePath(Application.exename)+'reporte\repLineasVsCartera.frf';
        frReport1.LoadFromFile(ruta);
        if frReport1.PrepareReport then
           frReport1.ShowPreparedReport
        else
          ShowMessage('Error al preparar el reporte');

end;

procedure TfrmLineasVsCartera.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'EMPRESA' then
          ParValue := Empresa;
        if ParName =  'NIT' then
          ParValue := Nit;
        if ParName = 'FECHA' then
          ParValue := fFechaHoraActual;
end;

procedure TfrmLineasVsCartera.ExtraerRemoto(puerto,idagencia: integer; Hostr: string);
var     cadena :String;
        AStream,Astream1 :TMemoryStream;
        j,i :Integer;
        AList,AListCampos:TList;
        Amortizacion:Integer;
        TasaNominal:Double;
        Interes:Currency;
        XmlPet,XmlRes: Tsdxmldocument;
        Nodo,Nodo1:TXmlNode;
        sentencia,host_server:string;
        puerto_server:Integer;
        Size:Integer;
begin
           sentencia := 'select * from P_LINEASVSCARTERA';
           XmlPet := TsdXmlDocument.CreateName('query_info');
           XmlPet.XmlFormat := xfReadable;
           Nodo := XmlPet.Root.NodeNew('querys');
           Nodo1 := Nodo.NodeNew('query');
           Nodo1.WriteString('tipo','select');
           nodo1.WriteString('sentencia',sentencia);
           case idagencia of
           2:
            begin
              host_server := host_abrego;
              puerto_server := puerto_abrego;
            end;
           3:
            begin
              host_server := host_convencion;
              puerto_server := puerto_convencion;
            end;
           end;


           with IdTCPClient1 do
           begin
             Host := host_server;
             Port := puerto_server;
             Connect;
             if Connected then
             begin
                Cadena := ReadLn();
                AStream := TMemoryStream.Create;
                XmlPet.SaveToStream(AStream);
                WriteInteger(AStream.Size);
                OpenWriteBuffer;
                WriteStream(AStream);
                CloseWriteBuffer;
                FreeAndNil(AStream);
                Size := ReadInteger;
                AStream := TMemoryStream.Create;
                ReadStream(AStream,Size,False);
                XmlRes := TsdXmlDocument.Create;
                XmlRes.LoadFromStream(AStream);
                Disconnect;
                AList := TList.Create;
                Nodo := XmlRes.Root.NodeByName('consulta000');
                Nodo.NodesByName('Registro',AList);
                for i := 0 to AList.Count -1 do
                begin
                  AListCampos := TList.Create;
                  TXmlNode(AList[i]).NodesByName('campo',AListCampos);
                  case idagencia of
                  2: begin
                     CDS02.Open;
                     CDS02.Append;
                     CDS02.FieldByName('AGENCIA').AsInteger := TXmlNode(AListCampos[0]).ValueAsInteger;
                     CDS02.FieldByName('ID_LINEA').AsInteger := TXmlNode(AListCampos[1]).ValueAsInteger;
                     CDS02.FieldByName('DESCRIPCION_LINEA').AsString := TXmlNode(AListCampos[2]).ValueAsString;
                     CDS02.FieldByName('CANTIDAD').AsInteger := TXmlNode(AListCampos[3]).ValueAsInteger;
                     CDS02.FieldByName('DEUDA').AsCurrency := TXmlNode(Alistcampos[4]).ValueAsFloat;
                     CDS02.FieldByName('PORCENTAJE').AsFloat := TXmlNode(AListCampos[5]).ValueAsFloat;
                     CDS02.Post;
                     CDS02.Close;
                     end;
                  3: begin
                     CDS03.Open;
                     CDS03.Append;
                     CDS03.FieldByName('AGENCIA').AsInteger := TXmlNode(AListCampos[0]).ValueAsInteger;
                     CDS03.FieldByName('ID_LINEA').AsInteger := TXmlNode(AListCampos[1]).ValueAsInteger;
                     CDS03.FieldByName('DESCRIPCION_LINEA').AsString := TXmlNode(AListCampos[2]).ValueAsString;
                     CDS03.FieldByName('CANTIDAD').AsInteger := TXmlNode(AListCampos[3]).ValueAsInteger;
                     CDS03.FieldByName('DEUDA').AsCurrency := TXmlNode(Alistcampos[4]).ValueAsFloat;
                     CDS03.FieldByName('PORCENTAJE').AsFloat := TXmlNode(AListCampos[5]).ValueAsFloat;
                     CDS03.Post;
                     CDS03.Close;
                     end;
                  end;
                  Application.ProcessMessages;
                end;
              end;
             end;
           end;


end.
