unit UnitConsultaRemota;

interface

uses
  StrUtils, Windows, IniFiles, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, ExtCtrls, JvComCtrls, sdXmlDocuments,
  ValEdit, DBTables, DB, DBClient, FMTBcd, DBCtrls, DataSetToExcel,
  Menus, JvEdit, JvTypedEdit, IdTCPServer,Jpeg;

type
  TfrmConsultaRemota = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    cmdSend: TBitBtn;
    cmdCerrar: TBitBtn;
    IdTCPClient1: TIdTCPClient;
    Panel2: TPanel;
    Panel3: TPanel;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListaConsulta: TValueListEditor;
    BitBtn3: TBitBtn;
    DataSource1: TDataSource;
    CDataSet: TClientDataSet;
    cmdExportar: TBitBtn;
    SaveD1: TSaveDialog;
    ComboBox1: TComboBox;
    Memo2: TMemo;
    DBImage1: TDBImage;
    PopupMenu1: TPopupMenu;
    Editar1: TMenuItem;
    BitBtn4: TBitBtn;
    OpDialog: TOpenDialog;
    S1: TMenuItem;
    Copiar1: TMenuItem;
    Pegar1: TMenuItem;
    Cortar1: TMenuItem;
    JVpuerto: TJvIntegerEdit;
    IdTCPServer1: TIdTCPServer;
    ImgFotoC: TImage;
    procedure cmdCerrarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure cmdSendClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListaConsultaClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure cmdExportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure IdTCPClient1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdTCPClient1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure Memo1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Editar1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure S1Click(Sender: TObject);
    procedure Copiar1Click(Sender: TObject);
    procedure Pegar1Click(Sender: TObject);
    procedure Cortar1Click(Sender: TObject);
  private
  function StrToFld(const Value : String) : TFieldType;
    function Cadena(Cad: string): integer;
    { Private declarations }
  public
    Consultado:Boolean;
    RDoc:TsdXmlDocument;
    procedure Inicializar;
    { Public declarations }
  end;

type
  PConsultas = ^TConsultas;
    TConsultas = Record
    Tipo:string;
    Consulta:string;
end;

var
  frmConsultaRemota: TfrmConsultaRemota;
  Lista:TList;

implementation

uses UnitPantallaProgreso;

{$R *.dfm}
{$H+}

procedure TfrmConsultaRemota.cmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmConsultaRemota.BitBtn1Click(Sender: TObject);
var
  Tipo:string;
  posicion :TStringList;
begin
        if Memo1.Text <> '' then
        begin
          posicion := TStringList.Create;
          posicion.Text := StringReplace(' ' + Memo1.Text,' ',#13,[rfReplaceAll]);
          Tipo :=  LowerCase(posicion.Strings[1]);
          if cadena(Tipo) in [0,1,2,3,4,5,6,7,8,9] then//'select','delete','insert','update','grant','drop','revoke','create','alter','execute') then
          begin
             ListaConsulta.InsertRow(Tipo,Memo1.Text,True);
             Memo1.Text := '';
          end
          else
          begin
             ShowMessage('Error, Sentencia "' + Tipo + '"  no Registrada');
             Memo1.SetFocus;
          end;
        end;
{        if Memo1.Text <> '' then
        begin
          if Pos('select',LowerCase(Memo1.Text)) <> 0 then
            Tipo := 'select'
          else
          if Pos('insert',LowerCase(Memo1.Text)) <> 0 then
            Tipo := 'insert'
          else
          if Pos('delete',LowerCase(Memo1.Text)) <> 0 then
            Tipo := 'delete'
          else
          if Pos('update',LowerCase(Memo1.Text)) <> 0 then
            Tipo := 'update'
          else
            Tipo := 'procedure';}

//          ListaConsulta.InsertRow(Tipo,Memo1.Text,True);

end;

procedure TfrmConsultaRemota.BitBtn2Click(Sender: TObject);
begin
        if MessageDlg('Seguro de Quitar esta Consulta?',mtConfirmation,[mbYes,MbNo],0) = MrYes then
           ListaConsulta.DeleteRow(ListaConsulta.Row);
end;

procedure TfrmConsultaRemota.cmdSendClick(Sender: TObject);
var
  ADoc: TsdXmlDocument;
  ANode:TXmlNode;
  Nodo:TXmlNode;
  i,inic:Integer;
  Cadena:string;
  Size:Integer;
  AStream:TMemoryStream;
begin
        if MessageDlg('Seguro de Enviar esta Consulta?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
        begin
           cmdSend.Enabled := False;
           Panel2.Enabled := False;
//           Memo1.Enabled := False;
           ADoc := TsdXmlDocument.CreateName('query_info');
           ADoc.XmlFormat := xfReadable;
           ANode := ADoc.Root.NodeNew('querys');
           for i := 1 to ListaConsulta.RowCount - 1 do
           begin
                Nodo := ANode.NodeNew('query');
                Nodo.WriteString('tipo',ListaConsulta.Cells[0,i]);
                Nodo.WriteString('sentencia',ListaConsulta.Cells[1,i]);
                
           end;
           Memo1.Text := ADoc.WriteToString;
           ADoc.SaveToFile('C:\Peticion.xml');
           with IdTCPClient1 do
           begin
             inic := Pos('=',ComboBox1.Text);
             Host := RightStr(ComboBox1.Text,Length(ComboBox1.Text)-inic);
             Port := JVpuerto.Value;
             Application.ProcessMessages;
             Connect;
             if Connected then
             begin
                frmProgreso := TfrmProgreso.Create(self);
                frmProgreso.Titulo := 'Recibiendo Informacion...';
                frmProgreso.InfoLabel := 'Kbs Recibidos';
                frmProgreso.Min := 0;
                frmProgreso.Ejecutar;
                Cadena := ReadLn();
                AStream := TMemoryStream.Create;
                ADoc.SaveToStream(AStream);
                AStream.Seek(0,soFromEnd);
                Size := AStream.Size;
                WriteInteger(Size,True); // este es para kylix
                OpenWriteBuffer;
                WriteStream(AStream);
                CloseWriteBuffer;
                FreeAndNil(AStream);
                Size := ReadInteger(True); // Este es para Kylix
                Memo1.Text := 'tamaño retornado:'+IntToStr(Size);
                AStream := TMemoryStream.Create;
                ReadStream(AStream,Size,False);
                AStream.Position := 0;
                RDoc := TsdXmlDocument.Create;
                AStream.Position := 0;
                RDoc.LoadFromStream(AStream);
                RDoc.SaveToFile('C:\Respuesta.xml');
                Disconnect;
                frmProgreso.Cerrar;
                Consultado := True;
                Memo1.Lines.Add ('Consulta Finalizada');
             end;
           end;
        end;



end;

procedure TfrmConsultaRemota.BitBtn3Click(Sender: TObject);
begin
        Inicializar;
end;

procedure TfrmConsultaRemota.Inicializar;
begin
//         ComboBox1.ItemIndex := 0;
         Memo1.Text := '';
         Panel2.Enabled := True;
         ListaConsulta.Strings.Clear;
         DataSource1.Enabled := False;
         Consultado := False;
         cmdSend.Enabled := True;
         try
          FreeAndNil(RDoc);
         finally
          ComboBox1.SetFocus;
         end;
end;

procedure TfrmConsultaRemota.FormShow(Sender: TObject);
begin
        Inicializar;
end;

procedure TfrmConsultaRemota.ListaConsultaClick(Sender: TObject);
var
   NodoRoot,NodoRegistros,NodoCampos:TXmlNode;
   AStream:TStream;
   AList,AListCampos:TList;
   i,j,Campos:Integer;
   NombreCampo:string;
   TipoCampo:TFieldType;
   Tamano:Integer;
   Binario:array of Byte;
begin
        if not Consultado then Exit;

        CDataSet.Active := False;
//        CDataSet.ClearFields;
        CDataSet.FieldDefs.Clear;
        if //(ListaConsulta.Keys[ListaConsulta.Row] = 'select') and
           Assigned(RDoc) then
        begin
           RDoc.SaveToFile('C:\Respuesta.xml');
           AList := TList.Create;
           NodoRoot := RDoc.Root.NodeByName('consulta'+Format('%.3d',[ListaConsulta.Row-1]));
           Campos := NodoRoot.ReadAttributeInteger('campos');
           if Campos < 1 then begin
              DataSource1.Enabled := False;
              Exit;
           end;
           for i := 1 to Campos do
           begin
              NombreCampo := NodoRoot.AttributeByName['camponombre'+IntToStr(i)];
              TipoCampo := StrToFld(NodoRoot.AttributeByName['campotipo'+IntToStr(i)]);
              Tamano := StrToInt(NodoRoot.AttributeByName['campotamano'+IntToStr(i)]);
              with CDataSet.FieldDefs.AddFieldDef do
              begin
                      Name      := NombreCampo;
                      DataType  := TipoCampo;
                      if (TipoCampo in [ftDate,ftTime,ftTimeStamp,ftInteger,ftSmallInt,ftCurrency,ftFloat,ftMemo,ftBlob]) then Tamano := 0;
                      Size      := Tamano;
              end;
           end;
           CDataSet.CreateDataSet;
           NodoRoot.NodesByName('Registro',AList);
           for i := 0 to AList.Count -1 do
           begin
                AListCampos := TList.Create;
                TXmlNode(AList[i]).NodesByName('campo',AListCampos);
                CDataSet.Append;
                try
                for j := 0 to AListCampos.Count - 1 do
                begin

                  if TXmlNode(AListCampos[j]).ValueAsString <> '' then
                  begin
                    if CDataSet.FieldDefs[j].DataType = ftstring then
                      CDataSet.Fields[j].Value := TXmlNode(AListCampos[j]).ValueAsString
                    else
                    if CDataSet.FieldDefs[j].DataType in [ftsmallint,ftinteger,ftword,ftboolean] then
                      CDataSet.Fields[j].Value := TXmlNode(AListCampos[j]).ValueAsInteger
                    else
                    if CDataSet.FieldDefs[j].DataType in [ftDate,ftDateTime,ftTimeStamp] then
                      CDataSet.Fields[j].Value := TXmlNode(AListCampos[j]).ValueAsDateTime
                    else
                    if CDataSet.FieldDefs[j].DataType in [ftTime] then
                      CDataSet.Fields[j].Value := TXmlNode(AListCampos[j]).ValueAsString
                    else
                    if CDataSet.FieldDefs[j].DataType = ftMemo then
                      CDataSet.Fields[j].Value := TXmlNode(AListCampos[j]).ValueAsString
                    else
                    if CDataSet.FieldDefs[j].DataType in [ftBlob,ftGraphic] then
                    begin
                      CDataSet.Fields[j].Value := TXmlNode(AListCampos[j]).BinaryString;
                    end
                    else
                    if CDataSet.FieldDefs[j].DataType in [ftFloat,ftCurrency] then
                      CDataSet.Fields[j].Value := TXmlNode(AListCampos[j]).ValueAsFloat
                    else
                    if CDataSet.FieldDefs[j].DataType in [ftFMTBcd,ftBCD] then
                       if TXmlNode(AListCampos[j]).ValueAsString <> '' then
                          CDataSet.Fields[j].Value := TXmlNode(AListCampos[j]).ValueAsString
                       else
                          CDataSet.Fields[j].Value := 0
                    else
                      CDataSet.Fields[j].Value := TXmlNode(AListCampos[j]).ValueAsString;
                    end;
                    end;
                    CDataSet.Post;
                  except
                     ShowMessage(CDataSet.Fields[j].Value +  '   ' + TXmlNode(AListCampos[j]).ValueAsString);
                  end;
           end;
           DataSource1.DataSet := CDataSet;
           DataSource1.Enabled := True;
        end
        else
        begin
                   RDoc.SaveToFile('C:\Respuesta.xml');
        end;
end;

procedure TfrmConsultaRemota.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  bmp: TBitmap;
  W: integer;
  R: TRect;
  Grafica: TGraphicField;
begin
{  R := Rect;
  if Column.Field.DataType = ftBlob then begin
    bmp := TBitmap.Create;
    try
      bmp.Assign(TGraphicField(Column.Field));
      W := (Rect.Bottom - Rect.Top) * 2;
      R.Right := Rect.Left + W;
      DBGrid1.Canvas.StretchDraw(R, bmp);
    finally
      bmp.Free;
    end;
    R := Rect;
    R.Left := R.Left + W;
  end;
  DBGrid1.DefaultDrawDataCell(R, Column.Field, State);
}
end;

procedure TfrmConsultaRemota.DBGrid1CellClick(Column: TColumn);
var AStream:TStream;
begin

        if (Column.Field.DataType = ftBlob) or
           (Column.Field.DataType = ftGraphic) or
           (Column.Field.DataType = ftMemo) then
        begin
           if Column.Field.DataType = ftMemo then
              Memo2.Text := CDataSet.Fields.FindField(Column.Field.FieldName).AsString
           else 
           try
              DBImage1.DataField := Column.Field.FieldName
           except
              //H.SelectionAsHex := CDataSet.Fields.FindField(Column.Field.FieldName).AsString;
           end;
        end;


end;

procedure TfrmConsultaRemota.cmdExportarClick(Sender: TObject);
var
  ExcelFile:TDataSetToExcel;
begin
        if SaveD1.Execute then
        begin
          ExcelFile := TDataSetToExcel.Create(CDataSet,SaveD1.FileName);
          ExcelFile.WriteFile;
          ExcelFile.Free;
        end;
end;

procedure TfrmConsultaRemota.FormCreate(Sender: TObject);
var
  MiIni:TIniFile;
begin
     MiIni:= TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
     MiIni.ReadSectionValues('OFICINAS',ComboBox1.Items);
     ComboBox1.ItemIndex := 0;
end;
function TfrmConsultaRemota.StrToFld(const Value : String) : TFieldType;
begin
   if (UpperCase(Value) = 'UNKNOWN') then
      StrToFld := ftUnknown
   else if (UpperCase(Value) ='STRING') then
      StrToFld := ftString
   else if (UpperCase(Value) ='SMALLINT') then
      StrToFld := ftSmallInt
   else if (UpperCase(Value) = 'INTEGER') then
      StrToFld := ftInteger
   else if (UpperCase(Value) = 'WORD') then
      StrToFld := ftWord
   else if (UpperCase(Value) = 'BOOLEAN') then
      StrToFld := ftBoolean
   else if (UpperCase(Value) = 'FLOAT') then
      StrToFld := ftFloat
   else if (UpperCase(Value) = 'CURRENCY') then
      StrToFld := ftCurrency
   else if (UpperCase(Value) = 'NUMERIC') or (UpperCase(Value) = 'DOUBLE PRECISION') or (UpperCase(Value) = 'DECIMAL') then
      StrToFld := ftCurrency
   else if (UpperCase(Value) = 'BCD') then
      StrToFld := ftBCD
   else if (UpperCase(Value) = 'DATE') then
      StrToFld := ftDate
   else if (UpperCase(Value) = 'TIME') then
      StrToFld := ftTime
   else if (UpperCase(Value) = 'DATETIME') then
      StrToFld := ftDateTime
   else if (UpperCase(Value) = 'BYTES') then
      StrToFld := ftBytes
   else if (UpperCase(Value) = 'VARBYTES') then
      StrToFld := ftVarBytes
   else if (UpperCase(Value) = 'AUTOINC') then
      StrToFld := ftAutoInc
   else if (UpperCase(Value) = 'BLOB') then
      StrToFld := ftBlob
   else if (UpperCase(Value) = 'MEMO') or (UpperCase(Value) = 'BLOB SUB_TYPE 1') then
      StrToFld := ftMemo
   else if (UpperCase(Value) = 'GRAPHIC') then
      StrToFld := ftGraphic
   else if Value = 'FmtMemo' then
      StrToFld := ftFmtMemo
   else if Value = 'ParadoxOle' then
      StrToFld := ftParadoxOle
   else if Value = 'DBaseOle' then
      StrToFld := ftDBaseOle
   else if Value = 'TypedBinary' then
      StrToFld := ftTypedBinary
   else if Value = 'Cursor' then
      StrToFld := ftCursor
   else if Value = 'FixedChar' then
      StrToFld := ftFixedChar
   else if Value = 'WideString' then
      StrToFld := ftWideString
   else if (UpperCase(Value) = 'CHAR') then
      StrToFld := ftFixedChar
   else if (UpperCase(Value) = 'VARCHAR') then
      StrToFld := ftWideString
   else if Value = 'LargeInt' then
      StrToFld := ftLargeInt
   else if Value = 'ADT' then
      StrToFld := ftADT
   else if Value = 'Array' then
      StrToFld := ftArray
   else if Value = 'Reference' then
      StrToFld := ftReference
   else if Value = 'DataSet' then
      StrToFld := ftDataSet
   else if Value = 'OraBlob' then
      StrToFld := ftOraBlob
   else if Value = 'OraClob' then
      StrToFld := ftOraClob
   else if (UpperCase(Value) = 'VARIANT') then
      StrToFld := ftVariant
   else if Value = 'Interface' then
      StrToFld := ftInterface
   else if Value = 'IDispatch' then
      StrToFld := ftIDispatch
   else if Value = 'GUID' then
      StrToFld := ftGuid
   else if (UpperCase(Value) = 'TIMESTAMP') then
      StrToFld := ftTimeStamp
   else if Value = 'FMTBcd' then
      StrToFld := ftFMTBcd
   else
      StrToFld := ftUnknown;
end;

function TfrmConsultaRemota.Cadena(Cad: string): integer;
begin
        if Cad = 'select' then
           Result := 0
        else if Cad = 'insert' then
           Result := 1
        else if Cad = 'delete' then
           Result := 2
        else if Cad = 'update' then
           Result := 3
        else if Cad = 'drop' then
           Result := 4
        else if Cad = 'alter' then
           Result := 5
        else if Cad = 'create' then
           Result := 6
        else if Cad = 'revoke' then
           Result := 7
        else if Cad = 'grant' then
           Result := 8
        else if Cad = 'execute' then
           Result := 9
        else
           Result := -1
end;

procedure TfrmConsultaRemota.Memo1KeyPress(Sender: TObject; var Key: Char);
var     letra :string;
begin
        letra := MidStr(Memo1.Text,strLen(PChar(Memo1.Text)),1);
        if ((letra = ' ') and (key = ' ')) or ((letra = '') and (key = ' ')) or ((Memo1.SelStart = 0) and (Key = ' '))  then
        begin
          Key := #0;
        end;

end;

procedure TfrmConsultaRemota.IdTCPClient1Work(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCount: Integer);
var
        paquete :Currency;
begin
          if AWorkMode = wmRead then
          begin
            frmProgreso.Position := AWorkCount;
            paquete := AWorkCount/1000;
            frmProgreso.InfoLabel := 'Kbs Recibidos : ' + CurrToStr(paquete);
            Application.ProcessMessages;
          end;
end;

procedure TfrmConsultaRemota.IdTCPClient1WorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
          if AWorkMode = wmRead then
          begin
            frmProgreso.Max := AWorkCountMax;
          end;
          frmProgreso.Titulo := 'Recibiendo Información... Tamaño: ' +  CurrToStr(AWorkCountMax/1000) + ' Kbs';

end;

procedure TfrmConsultaRemota.Memo1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        if Key = 120 then
           BitBtn1.Click
end;

procedure TfrmConsultaRemota.Editar1Click(Sender: TObject);
begin
        //Memo1.Text := ListaConsulta.Cells[ListaConsulta.col + 1,2]
        OpDialog.Execute;
        Memo1.Lines.LoadFromFile(OpDialog.FileName);
end;

procedure TfrmConsultaRemota.BitBtn4Click(Sender: TObject);
begin
        Memo1.Text := ListaConsulta.Cells[2,ListaConsulta.row];
        ListaConsulta.DeleteRow(ListaConsulta.Row);
end;

procedure TfrmConsultaRemota.S1Click(Sender: TObject);
begin
        Memo1.SelectAll;
end;

procedure TfrmConsultaRemota.Copiar1Click(Sender: TObject);
begin
        Memo1.CopyToClipboard;
end;

procedure TfrmConsultaRemota.Pegar1Click(Sender: TObject);
begin
        Memo1.PasteFromClipboard;
end;

procedure TfrmConsultaRemota.Cortar1Click(Sender: TObject);
begin
        Memo1.CutToClipboard
end;

end.
