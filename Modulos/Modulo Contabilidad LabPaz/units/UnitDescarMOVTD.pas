unit UnitDescarMOVTD;

interface

uses
  Math, ShellApi, Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdPOP3, StdCtrls, IdMessage, Buttons, ComCtrls, ExtCtrls,
  ImgList, AbBase, AbBrowse, AbZBrows, AbUnzper, JvEdit, JvTypedEdit,
  Grids, AbView, AbZView, AbArcTyp, IBSQL, pr_Common, pr_TxClasses, DB,
  IBCustomDataSet, IBQuery, IBDatabase, DateUtils, DBClient, Mask,
  JvToolEdit;

type
  TfrmDescarMOVTD = class(TForm)
    POP: TIdPOP3;
    GroupBox1: TGroupBox;
    chkBox1: TCheckBox;
    chkBox2: TCheckBox;
    chkBox3: TCheckBox;
    chkBox4: TCheckBox;
    chkBox7: TCheckBox;
    chkBox8: TCheckBox;
    chkBox9: TCheckBox;
    chkBox10: TCheckBox;
    Msg: TIdMessage;
    lvHeaders: TListView;
    chkBox5: TCheckBox;
    Panel1: TPanel;
    cmdLeer: TBitBtn;
    cmdProcesar: TBitBtn;
    cmdCerrar: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    Memo1: TMemo;
    pnlAttachments: TPanel;
    Label2: TLabel;
    lvMessageParts: TListView;
    Button1: TBitBtn;
    ImageList1: TImageList;
    SaveDialog1: TSaveDialog;
    cmdDescomp: TBitBtn;
    UnZip: TAbUnZipper;
    chkBox6: TCheckBox;
    GroupBox2: TGroupBox;
    EdMov: TEdit;
    Label3: TLabel;
    EdBlq: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    EdTar: TEdit;
    Label6: TLabel;
    EdEst: TEdit;
    Label7: TLabel;
    EdTMov: TJvIntegerEdit;
    Label8: TLabel;
    EdTBlq: TJvIntegerEdit;
    Label9: TLabel;
    EdTTar: TJvIntegerEdit;
    IBSQL1: TIBSQL;
    IBSQL2: TIBSQL;
    IBSQL3: TIBSQL;
    IBSQL4: TIBSQL;
    IBComprobante: TIBQuery;
    IBAuxiliar: TIBQuery;
    IBAuxiliar1: TIBQuery;
    reporte: TprTxReport;
    IBTransaction1: TIBTransaction;
    IBSQLComp: TIBSQL;
    cmdComprobante: TBitBtn;
    CDS: TClientDataSet;
    CDSID_TARJETA: TStringField;
    CDSSECUENCIA: TStringField;
    CDSMONTO: TCurrencyField;
    CDSCOMISION: TCurrencyField;
    CDSAPROBADA: TBooleanField;
    cmdReporte: TBitBtn;
    CDSCUENTA: TStringField;
    CDSASOCIADO: TStringField;
    CDSTERMINAL: TStringField;
    reportemov: TprTxReport;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    rb1: TRadioButton;
    rb2: TRadioButton;
    GroupBox4: TGroupBox;
    EdArchivoExterno: TJvFilenameEdit;
    btnArchivoExterno: TBitBtn;
    procedure cmdLeerClick(Sender: TObject);
    procedure cmdCerrarClick(Sender: TObject);
    procedure lvHeadersDblClick(Sender: TObject);
    procedure lvMessagePartsDblClick(Sender: TObject);
    procedure cmdDescompClick(Sender: TObject);
    procedure UnZipArchiveItemProgress(Sender: TObject;
      Item: TAbArchiveItem; Progress: Byte; var Abort: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure lvMessagePartsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure cmdProcesarClick(Sender: TObject);
    procedure cmdComprobanteClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cmdReporteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnArchivoExternoClick(Sender: TObject);
    procedure EdArchivoExternoAfterDialog(Sender: TObject;
      var Name: String; var Action: Boolean);
    procedure EdArchivoExternoChange(Sender: TObject);
  private
    procedure RetrievePOPHeaders(inMsgCount: Integer);
    procedure RetrieveExecute(Sender: TObject);
    function  FindAttachment(stFilename: string): Integer;
    procedure DownloadMovs(fFileName: string);
    procedure DownloadBlqs(fFileName: string);
    procedure DownloadTars(fFileName: string);
    { Private declarations }
  public
    { Public declarations }
  end;

type PArchivos = ^TArchivos;
     TArchivos = Record
      Nombre:string;
      Existe:Boolean;
end;

type //PRegMov = ^TRegMov;
    TRegMov = Record
      NPOS_CSC:string[06];
      NPOS_CTA:string[10];
      NPOS_TAR:string[19];
      NPOS_RAD:string[05];
      NPOS_SEC:string[04];
      NPOS_NTE:string[08];
      NPOS_NOM:string[30];
      NPOS_FEC:string[08];
      NPOS_HOR:string[06];
      NPOS_MON:string[15];
      NPOS_CMS:string[15];
      NPOS_TRA:string[01];
      NPOS_ERR:string[02];
      NPOS_TER:string[01];
      NPOS_RED:string[01];
      NPOS_NCA:string[08];
      NPOS_FLD:string[12];
end;

type // PRegBlq = ^TRegBlq;
    TRegBlq = Record
      NOV_SEC:string[15];
      NOV_BIN:string[06];
      NOV_CAR:string[19];
      NOV_FRE:string[08];
      NOV_HOR:string[06];
      NOV_FCO:string[08];
      NOV_COD:string[02];
      NOV_TER:string[10];
      NOV_USE:string[05];
end;

type // PRegTar = ^TRegTar;
    TRegTar = Record
      TAR_NEW:string[19];
      TAR_CUP:string[15];
end;

type PResumen = ^TResumen;
     TResumen = record
      id:Integer;
      Nr:Integer;
      Vd:Currency;
      Vc:Currency;
end;


var
  frmDescarMOVTD: TfrmDescarMOVTD;
  FMsgCount :Integer;
  FileName:TFileName;
  ListaFile:TList;
  FUnidad:string='c:\tdebito\';
  LResumen:TList;
  Consecutivo:Integer;
  FechaCorte : TDate;

implementation

{$R *.dfm}

uses UnitGlobales, UnitDmGeneral;

procedure TfrmDescarMOVTD.RetrievePOPHeaders(inMsgCount: Integer);
var
//  stTemp: string;
  intIndex: integer;
  itm: TListItem;
begin
  lvHeaders.Items.Clear;
  for intIndex := 1 to inMsgCount do
  begin
    // Clear the message properties
//    ShowStatus(format('Messsage %d of %d', [intIndex, inMsgCount]));
    Application.ProcessMessages;
    Msg.Clear;
    try
      POP.RetrieveHeader(intIndex, Msg);
    finally
    end;
    // Add info to ListView
    itm := lvHeaders.Items.Add;
    itm.ImageIndex := 5;
    itm.Caption := IntToStr(intIndex);
    itm.SubItems.Add(Msg.Subject);
    itm.SubItems.Add(Msg.From.Text);
    itm.SubItems.Add(DateToStr(Msg.Date));
    itm.SubItems.Add(IntToStr(POP.RetrieveMsgSize(intIndex)));
    itm.SubItems.Add('n/a');
    //  itm.SubItems.Add(POP.RetrieveUIDL(intIndex));
  end;
end;


procedure TfrmDescarMOVTD.cmdLeerClick(Sender: TObject);
var
  Pop3ServerName:string;
  Pop3ServerPort:Integer;
  Pop3ServerUser:string;
  Pop3ServerPassword:string;
begin

  if rb1.Checked then
  begin
     Pop3ServerName := Pop3ServerName1;
     Pop3ServerPort := Pop3ServerPort1;
     Pop3ServerUser := Pop3ServerUser1;
     Pop3ServerPassword := Pop3ServerPassword1;
  end
  else
  begin
     Pop3ServerName := Pop3ServerName2;
     Pop3ServerPort := Pop3ServerPort2;
     Pop3ServerUser := Pop3ServerUser2;
     Pop3ServerPassword := Pop3ServerPassword2;
  end;
  POP.Host := Pop3ServerName;
  POP.Port := Pop3ServerPort;
  POP.UserID := Pop3ServerUser;
  POP.Password := Pop3ServerPassword;
  if POP.Connected then
     POP.Disconnect;
  POP.Connect;
  FMsgCount := POP.CheckMessages;
  if FMsgCount > 0 then
     RetrievePOPHeaders(FMsgCount)
  else
  begin
     ShowMessage('No hay mensajes');
     Exit;
  end;
  chkBox1.Checked := True;
  cmdLeer.Enabled := False;

//  cmdDescomp.Enabled := True;
end;

procedure TfrmDescarMOVTD.RetrieveExecute(Sender: TObject);
var
//  stTemp: string;
  intIndex: Integer;
  li: TListItem;
begin
//  stTemp := Statusbar1.Panels[1].text;
  if lvHeaders.Selected = nil then
  begin
    Exit;
  end;
  //initialise
//  Showbusy(true);
  Msg.Clear;
  Memo1.Clear;
  lvMessageParts.Items.Clear;
  pnlAttachments.visible := false;

  //get message and put into MSG
  POP.Retrieve(lvHeaders.Selected.Index + 1, Msg);

  //Setup fields on screen from MSG
  //Setup attachments list
//  ShowStatus('Decoding attachments (' + IntToStr(Msg.MessageParts.Count) + ')');
  for intIndex := 0 to Pred(Msg.MessageParts.Count) do
  begin
    if (Msg.MessageParts.Items[intIndex] is TIdAttachment) then
    begin //general attachment
      pnlAttachments.visible := true;
      li := lvMessageParts.Items.Add;
      li.ImageIndex := 8;
      li.Caption := TIdAttachment(Msg.MessageParts.Items[intIndex]).Filename;
      //  li.SubItems.Add(TIdAttachment(Msg.MessageParts.Items[intIndex]).ContentType);
    end
    else
    begin //body text
      if Msg.MessageParts.Items[intIndex] is TIdText then
      begin
        Memo1.Lines.Clear;
        Memo1.Lines.AddStrings(TIdText(Msg.MessageParts.Items[intIndex]).Body);
      end
    end;
  end;
  chkBox2.Checked := True;
//  ShowStatus(stTemp);
//  Showbusy(false);
end;


procedure TfrmDescarMOVTD.cmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmDescarMOVTD.lvHeadersDblClick(Sender: TObject);
begin
        RetrieveExecute(Sender);
end;

procedure TfrmDescarMOVTD.lvMessagePartsDblClick(Sender: TObject);
var
  i: Integer;
  cadena:string;
begin
   if lvMessageParts.Selected <> nil then
      begin
         if lvMessageParts.Selected.Index > Msg.MessageParts.Count then
            begin
               MessageDlg('Indice Desconocido', mtInformation, [mbOK], 0);
            end
         else
            begin
              for i := 0 to Msg.MessageParts.Count - 1 do begin
                if Msg.MessageParts.Items[i] is TIdAttachment then begin
                 SaveDialog1.FileName := TIdAttachment(Msg.MessageParts.Items[i]).FileName;
                 SaveDialog1.DefaultExt := '.zip';
                 SaveDialog1.InitialDir := FUnidad;
                 SaveDialog1.Title := 'Archivo de Movimientos Tarjeta Débito';
                  if SaveDialog1.Execute then
                    TIdAttachment(Msg.MessageParts.Items[i]).SaveToFile(
                      SaveDialog1.FileName);
                    FileName := SaveDialog1.FileName;
                    cadena := RightStr(FileName,12);
                    FechaCorte := EncodeDate(StrToInt(MidStr(cadena,5,4)),StrToInt(MidStr(cadena,3,2)),StrToInt(LeftStr(cadena,2)));
                    chkBox3.Checked := True;
                    cmdDescomp.Enabled := True;
                    break;
                end;
              end;
            end;
      end;


end;

procedure TfrmDescarMOVTD.cmdDescompClick(Sender: TObject);
var
  DirectorioBase:string;
  Ruta:string;
  Archivo,Archivo1,Convenio,Fecha:string;
  FechaDia:TDate;
  AR:PArchivos;
  i:Integer;
  fText:TextFile;
begin
  if FileExists(FileName) then
  begin
   ListaFile := TList.Create;
   UnZip.FileName := FileName;
   with UnZip do begin
      FUnidad := ExtractFilePath( FileName );
      BaseDirectory := ExtractFilePath( FileName );
      ExtractFiles( '*.*' );
      chkBox4.Checked := True;
      for i := 0 to ListaFile.Count - 1 do
      begin
        AR := ListaFile.Items[i];
        Archivo1 := AR^.Nombre;
        if FileExists(Archivo1) then
        begin
         AR^.Existe := True;
         if LowerCase(ExtractFileExt(AR^.Nombre)) = '.mov' then
            EdMov.Text := ExtractFileName(Archivo1);
         if LowerCase(ExtractFileExt(AR^.Nombre)) = '.blq' then
            EdBlq.Text := ExtractFileName(Archivo1);
         if LowerCase(ExtractFileExt(AR^.Nombre)) = '.tar' then
            EdTar.Text := ExtractFileName(Archivo1);
         if LowerCase(ExtractFileExt(AR^.Nombre)) = '.est' then
            EdEst.Text := ExtractFileName(Archivo1);
        end;
      end;
        chkBox5.Checked := True;
        cmdDescomp.Enabled := False;
        cmdProcesar.Enabled := True;
   end;
  end
  else
  begin
      ShowMessage('No Existe Ningún Archivo a Procesar');
      Exit;
  end;

end;

procedure TfrmDescarMOVTD.UnZipArchiveItemProgress(Sender: TObject;
  Item: TAbArchiveItem; Progress: Byte; var Abort: Boolean);
var
  AR:PArchivos;
begin
        New(AR);
        AR^.Nombre := FUnidad + Item.DiskFileName;
        ListaFile.Add(AR);
end;

procedure TfrmDescarMOVTD.Button1Click(Sender: TObject);
var
  intIndex: integer;
  fname: string;
  intMSGIndex: integer;
  cadena:string;
begin
  for intIndex := 0 to lvMessageParts.Items.Count - 1 do
    if lvMessageParts.Items[intIndex].Selected then
    begin
      intMSGIndex := FindAttachment(lvMessageParts.Items[intIndex].caption);
      if intMSGIndex > 0 then
      begin
        fname :=
          TIdAttachment(Msg.MessageParts.Items[intMSGIndex]).FileName;
        SaveDialog1.FileName := FUnidad +fname;
        if SaveDialog1.Execute then
        begin
          TIdAttachment(Msg.MessageParts.Items[intMSGIndex]).SaveToFile(SaveDialog1.FileName);
          FileName := SaveDialog1.FileName;
          cadena := RightStr(FileName,12);
          FechaCorte := EncodeDate(StrToInt(MidStr(cadena,5,4)),StrToInt(MidStr(cadena,3,2)),StrToInt(LeftStr(cadena,2)));
          chkBox3.Checked := True;
          cmdDescomp.Enabled := True;
        end;
      end;
    end;
end;

function TfrmDescarMOVTD.FindAttachment(stFilename: string): integer;
var
  intIndex: Integer;
  found: boolean;
begin
  intIndex := -1;
  result := -1;
  if (Msg.MessageParts.Count < 1) then
    exit; //no attachments (or anything else)
  found := false;
  stFilename := uppercase(stFilename);
  repeat
    inc(intIndex);
    if (Msg.MessageParts.Items[intIndex] is TIdAttachment) then
    begin //general attachment
      if stFilename =
        uppercase(TIdAttachment(Msg.MessageParts.Items[intIndex]).Filename) then
        found := true;
    end;
  until found or (intIndex > Pred(Msg.MessageParts.Count));
  if found then
    result := intIndex
  else
    result := -1;
end; (*  *)


procedure TfrmDescarMOVTD.lvMessagePartsSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
        if Selected then Button1.Enabled := true
        else Button1.Enabled := False;
end;

procedure TfrmDescarMOVTD.cmdProcesarClick(Sender: TObject);
var
   i:Integer;
   AR:PArchivos;
   fichero:string;
begin
        cmdProcesar.Enabled := False;
        for i := 0 to ListaFile.Count - 1 do
        begin
           AR := ListaFile.Items[i];
           if LowerCase(ExtractFileExt(AR^.Nombre)) = '.mov' then
            begin
              DownloadMovs(AR^.Nombre);
              chkBox6.Checked := True;
            end;
           if LowerCase(ExtractFileExt(AR^.Nombre)) = '.blq' then
            begin
              DownloadBlqs(AR^.Nombre);
              chkBox7.Checked := True;
            end;
           if LowerCase(ExtractFileExt(AR^.Nombre)) = '.tar' then
           begin
              DownloadTars(AR^.Nombre);
              chkBox8.Checked := True;
           end;
           if LowerCase(ExtractFileExt(AR^.Nombre)) = '.est' then
           begin
              fichero := AR^.Nombre;
              ShellExecute(Handle, 'open', 'notepad.exe', PChar(fichero), nil, SW_SHOWNORMAL);
           end;
        end;

        chkBox9.Checked := True;
        cmdComprobante.Enabled := True;

end;

procedure TfrmDescarMOVTD.DownloadMovs(fFileName: string);
var
  Archivo,Archivo1:TextFile;
  Registro:string;
  R:TRegMov;
  LErrores:TStringList;
  fichero:string;
  Monto:string;
  Comision:string;

  MontoN:Currency;
  ComisionN:Currency;

  TipoOperacion:Integer;
  CodigoError:Integer;

  EsDebito:Boolean;
  EsCredito:Boolean;
  Descripcion:string;
  Red:Integer;
  DesRed:string;

  i:Integer;
  AR:PResumen;

  Row:string;
  TotalReg:Integer;
  TotalCom:Integer;
  ValorCom:Currency;

  SumDebito:Currency;
  SumCredito:Currency;

  TotalComprobante:Currency;
  GMF:Currency;
  VecesGMF:Integer;
  SumGMF:Currency;

  SumGMFComision:Currency;
  GMFComision:Currency;

  ValorERindediario:Currency;
  ValorEJuvenil:Currency;

  ValorSRindediario:Currency;
  ValorSJuvenil:Currency;

  ValorCRindediario:Currency;
  ValorCJuvenil:Currency;

  CodigoBco:string;
  CodigoCap:string;
  CodigoJuv:string;
  CodigoGMF:string;
  CodigoGas:string;

  Aprobada :Boolean;

  ConsecutivoGenerado:Boolean;

  vFecha:TDate;


begin

        TotalReg := 0;
        TotalCom := 0;
        ValorCom := 0;
        SumGMF := 0;
        SumGMFComision := 0;

        ValorERindediario := 0;
        ValorEJuvenil     := 0;
        ValorSRindediario := 0;
        ValorSJuvenil     := 0;

        ValorCRindediario := 0;
        ValorCJuvenil     := 0;

        ConsecutivoGenerado := False;


        LResumen := TList.Create;

        LErrores := TStringList.Create;
        AssignFile(Archivo,fFileName);
        Reset(Archivo);

        with IBSQL1 do begin
            if Transaction.InTransaction then
               Transaction.Rollback;
            Transaction.StartTransaction;
            Close;
            SQL.Clear;
            SQL.Add('insert into "cap$tarjetamov" values (');
            SQL.Add(':NPOS_CSC,');
            SQL.Add(':NPOS_CTA,');
            SQL.Add(':NPOS_TAR,');
            SQL.Add(':NPOS_RAD,');
            SQL.Add(':NPOS_SEC,');
            SQL.Add(':NPOS_NTE,');
            SQL.Add(':NPOS_NOM,');
            SQL.Add(':NPOS_FEC,');
            SQL.Add(':NPOS_HOR,');
            SQL.Add(':NPOS_MON,');
            SQL.Add(':NPOS_CMS,');
            SQL.Add(':NPOS_TRA,');
            SQL.Add(':NPOS_ERR,');
            SQL.Add(':NPOS_TER,');
            SQL.Add(':NPOS_RED,');
            SQL.Add(':NPOS_NCA,');
            SQL.Add(':NPOS_FLD,');
            SQL.Add(':NPOS_APL');
            SQL.Add(')');
        end;

        for i := 1 to 5 do
        begin
          New(AR);
          AR^.id := i;
          AR^.Nr := 0;
          AR^.Vd := 0;
          AR^.Vc := 0;
          LResumen.Add(AR);
        end;


         while not Eof(Archivo) do
         begin
           ComisionN := 0;
           MontoN := 0;

           Readln(Archivo,
                  R.NPOS_CSC,
                  R.NPOS_CTA,
                  R.NPOS_TAR,
                  R.NPOS_RAD,
                  R.NPOS_SEC,
                  R.NPOS_NTE,
                  R.NPOS_NOM,
                  R.NPOS_FEC,
                  R.NPOS_HOR,
                  R.NPOS_MON,
                  R.NPOS_CMS,
                  R.NPOS_TRA,
                  R.NPOS_ERR,
                  R.NPOS_TER,
                  R.NPOS_RED,
                  R.NPOS_NCA,
                  R.NPOS_FLD
                  );

            if R.NPOS_CSC = 'FOOTER' then
            begin
             Break;
            end;

           Monto := LeftStr(R.NPOS_MON,(Length(R.NPOS_MON)-2))+DECIMALSEPARATOR+RightStr(R.NPOS_MON,2);
           Comision := LeftStr(R.NPOS_CMS,(Length(R.NPOS_CMS)-2))+DECIMALSEPARATOR+RightStr(R.NPOS_CMS,2);

           MontoN := StrToCurr(Monto);
           ComisionN := StrToCurr(Comision);
           TipoOperacion := StrToInt(R.NPOS_TRA);
           CodigoError := StrToInt(R.NPOS_ERR);
           Red := StrToInt(R.NPOS_RED);

           AR := LResumen.Items[Red-1];

           IBSQL4.Close;
           IBSQL4.SQL.Clear;
           IBSQL4.SQL.Add('select * from "cap$tarjetamovsdia" where');
           IBSQL4.SQL.Add('ID_TARJETA = :ID_TARJETA and SECUENCIA = :SECUENCIA and');
           IBSQL4.SQL.Add('FECHA = :FECHA');
           IBSQL4.ParamByName('ID_TARJETA').AsString := LeftStr(R.NPOS_TAR,16);
           IBSQL4.ParamByName('SECUENCIA').AsString := R.NPOS_FLD;
           IBSQL4.ParamByName('FECHA').AsDate := EncodeDate(StrToInt(LeftStr(R.NPOS_FEC,4)),StrToInt(MidStr(R.NPOS_FEC,5,2)),StrToInt(RightStr(R.NPOS_FEC,2)));
           try
             IBSQL4.ExecQuery;
             if IBSQL4.RecordCount > 0 then
                Aprobada := True
             else
                Aprobada := False;
           except
             IBSQL4.Transaction.Rollback;
             raise;
           end;

           with IBSQL1 do begin
             ParamByName('NPOS_CSC').AsInteger := StrToInt(R.NPOS_CSC);
             ParamByName('NPOS_CTA').AsString := R.NPOS_CTA;
             ParamByName('NPOS_TAR').AsString := R.NPOS_TAR;
             ParamByName('NPOS_RAD').AsInteger := StrToInt(R.NPOS_RAD);
             ParamByName('NPOS_SEC').AsInteger := StrToInt(R.NPOS_SEC);
             ParamByName('NPOS_NTE').AsString := R.NPOS_NTE;
             ParamByName('NPOS_NOM').AsString := R.NPOS_NOM;
             ParamByName('NPOS_FEC').AsDate := EncodeDate(StrToInt(LeftStr(R.NPOS_FEC,4)),StrToInt(MidStr(R.NPOS_FEC,5,2)),StrToInt(RightStr(R.NPOS_FEC,2)));
             ParamByName('NPOS_HOR').AsTime := EncodeTime(StrToint(LeftStr(R.NPOS_HOR,2)),StrToInt(MidStr(R.NPOS_HOR,3,2)),StrToInt(RightStr(R.NPOS_HOR,2)),00);
             ParamByName('NPOS_MON').AsCurrency := StrToCurr(Monto);
             ParamByName('NPOS_CMS').AsCurrency := StrToCurr(Comision);
             ParamByName('NPOS_TRA').AsInteger := StrToInt(R.NPOS_TRA);
             ParamByName('NPOS_ERR').AsInteger := StrToInt(R.NPOS_ERR);
             ParamByName('NPOS_TER').AsInteger := StrToInt(R.NPOS_TER);
             ParamByName('NPOS_RED').AsInteger := StrToInt(R.NPOS_RED);
             ParamByName('NPOS_NCA').AsString  := R.NPOS_NCA;
             ParamByName('NPOS_FLD').AsString := R.NPOS_FLD;
             ParamByName('NPOS_APL').AsInteger := 1;
             try
               ExecQuery;
             except
               Transaction.Rollback;
               raise;
             end;
// Insertar datos en el Extracto de Movimiento
// Validaciones Iniciales
             IBSQL4.Close;
             IBSQL4.SQL.Clear;
             IBSQL4.SQL.Add('select * from "cap$tarjetatipooperacion" where IDOPERACION = :ID');
             IBSQL4.ParamByName('ID').AsInteger := TipoOperacion;
             try
              IBSQL4.ExecQuery;
              EsDebito := InttoBoolean(IBSQL4.FieldByName('ESDEBITO').AsInteger);
              EsCredito := InttoBoolean(IBSQL4.FieldByName('ESCREDITO').AsInteger);
              Descripcion := 'TERMINAL:';
//              Descripcion := IBSQL4.FieldByName('DESCRIPCION').AsString;
             except
              Transaction.Rollback;
              raise;
             end;

// Aplicar operaciones
              IBSQL3.Close;
              IBSQL3.SQL.Clear;
              IBSQL3.SQL.Add('insert into "cap$extracto" (');
              IBSQL3.SQL.Add('ID_AGENCIA,ID_TIPO_CAPTACION,NUMERO_CUENTA,DIGITO_CUENTA,');
              IBSQL3.SQL.Add('FECHA_MOVIMIENTO,HORA_MOVIMIENTO,ID_TIPO_MOVIMIENTO,');
              IBSQL3.SQL.Add('DOCUMENTO_MOVIMIENTO,DESCRIPCION_MOVIMIENTO,VALOR_DEBITO,VALOR_CREDITO) values (');
              IBSQL3.SQL.Add(':ID_AGENCIA,');
              IBSQL3.SQL.Add(':ID_TIPO_CAPTACION,');
              IBSQL3.SQL.Add(':NUMERO_CUENTA,');
              IBSQL3.SQL.Add(':DIGITO_CUENTA,');
              IBSQL3.SQL.Add(':FECHA_MOVIMIENTO,');
              IBSQL3.SQL.Add(':HORA_MOVIMIENTO,');
              IBSQL3.SQL.Add(':ID_TIPO_MOVIMIENTO,');
              IBSQL3.SQL.Add(':DOCUMENTO_MOVIMIENTO,');
              IBSQL3.SQL.Add(':DESCRIPCION_MOVIMIENTO,');
              IBSQL3.SQL.Add(':VALOR_DEBITO,');
              IBSQL3.SQL.Add(':VALOR_CREDITO');
              IBSQL3.SQL.Add(')');

              IBSQL2.Close;
              IBSQL2.SQL.Clear;
              IBSQL2.SQL.Add('select * from "cap$tarjetacuenta" where');
              IBSQL2.SQL.Add('ID_TARJETA = :ID_TARJETA');
              IBSQL2.ParamByName('ID_TARJETA').AsString := LeftStr(R.NPOS_TAR,16);
              try
               IBSQL2.ExecQuery;
              except
               Transaction.Rollback;
               raise;
              end;

              if IBSQL2.FieldByName('NUMERO_CUENTA').AsInteger = Null then
              begin
                LErrores.Add('Error al buscar cuenta de Tarjeta No.'+R.NPOS_TAR);
                ShowMessage('Error al localizar cuenta de tarjeta No.'+R.NPOS_TAR);
              end;

              IBSQL3.ParamByName('ID_AGENCIA').AsInteger := IBSQL2.FieldByName('ID_AGENCIA').AsInteger;
              IBSQL3.ParamByName('ID_TIPO_CAPTACION').AsInteger := IBSQL2.FieldByName('ID_TIPO_CAPTACION').AsInteger;
              IBSQL3.ParamByName('NUMERO_CUENTA').AsInteger := IBSQL2.FieldByName('NUMERO_CUENTA').AsInteger;
              IBSQL3.ParamByName('DIGITO_CUENTA').AsInteger := IBSQL2.FieldByName('DIGITO_CUENTA').AsInteger;
              vFecha := EncodeDate(StrToInt(LeftStr(R.NPOS_FEC,4)),StrToInt(MidStr(R.NPOS_FEC,5,2)),StrToInt(RightStr(R.NPOS_FEC,2)));
              if ((vFecha = StrToDate('2005/12/30')) or
                  (vFecha = StrToDate('2005/12/31')) or
                  (vFecha = StrToDate('2006/01/01')) ) then
                 vFecha := StrToDate('2006/01/02');
              IBSQL3.ParamByName('FECHA_MOVIMIENTO').AsDate := vFecha;
              IBSQL3.ParamByName('HORA_MOVIMIENTO').AsTime := EncodeTime(StrToint(LeftStr(R.NPOS_HOR,2)),StrToInt(MidStr(R.NPOS_HOR,3,2)),StrToInt(RightStr(R.NPOS_HOR,2)),00);
// Código del Tipo de Operación
               case TipoOperacion of
               1:   IBSQL3.ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 20;
               2,3: IBSQL3.ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 21;
               4:   IBSQL3.ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 22;
               5:   IBSQL3.ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 23;
               6:   IBSQL3.ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 24;
               8:   IBSQL3.ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 25;
               9:   IBSQL3.ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 26;
               end;
// Fin
               IBSQL3.ParamByName('DOCUMENTO_MOVIMIENTO').AsString := R.NPOS_SEC;
               IBSQL3.ParamByName('DESCRIPCION_MOVIMIENTO').AsString := Descripcion + ' ' + R.NPOS_NOM;

               if R.NPOS_ERR = '00' then
               if MontoN <> 0 then
               begin
                if EsDebito then
                begin
                 IBSQL3.ParamByName('VALOR_DEBITO').AsCurrency := MontoN;
                 IBSQL3.ParamByName('VALOR_CREDITO').AsCurrency := 0;
                 AR^.Vc := AR^.Vc + MontoN;
                 case IBSQL2.FieldByName('ID_TIPO_CAPTACION').AsInteger of
                  2: ValorERindediario := ValorERindediario + MontoN;
                  4: ValorEJuvenil := ValorEJuvenil + MontoN;
                 end;
                 SumGMF := SumGMF - MontoN;
                end
                else
                begin
                 IBSQL3.ParamByName('VALOR_DEBITO').AsCurrency := 0;
                 IBSQL3.ParamByName('VALOR_CREDITO').AsCurrency := MontoN;
                 AR^.Vd := AR^.Vd + MontoN;
                 case IBSQL2.FieldByName('ID_TIPO_CAPTACION').AsInteger of
                  2: ValorSRindediario := ValorSRindediario + MontoN;
                  4: ValorSJuvenil := ValorSJuvenil + MontoN;
                 end;

                 if TipoOperacion <> 6 then
                    SumGMF := SumGMF + MontoN;
                end;

                 try
                  Inc(TotalReg);
                  IBSQL3.ExecQuery;
                 except
                  Transaction.Rollback;
                  raise;
                 end;
               end; // if MontoN

{               if ComisionN <> 0 then
               begin
                IBSQL3.ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'Com ' + MidStr((Descripcion + ' ' + R.NPOS_NOM),1,46);
                IBSQL3.ParamByName('VALOR_DEBITO').AsCurrency := 0;
                IBSQL3.ParamByName('VALOR_CREDITO').AsCurrency := ComisionN; //StrToCurr(R.NPOS_MON);
//                if R.NPOS_ERR = '00' then
                try
                 Inc(TotalCom);
                 IBSQL3.ExecQuery;
                 ValorCom := ValorCom + ComisionN;
                 SumGMFComision := SumGMFComision + ComisionN;

                 case IBSQL2.FieldByName('ID_TIPO_CAPTACION').AsInteger of
                  2: ValorCRindediario := ValorCRindediario + ComisionN;
                  4: ValorCJuvenil := ValorCJuvenil + ComisionN;
                 end;

                except
                 Transaction.Rollback;
                 raise;
                end; // fin del try
               end; // fin del if ComisionN
}

               if ComisionN <> 0 then
               begin
               if EsDebito then
               begin
                IBSQL3.ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'Rev Com ' + MidStr((Descripcion + ' ' + R.NPOS_NOM),1,46);
                IBSQL3.ParamByName('VALOR_DEBITO').AsCurrency := ComisionN;
                IBSQL3.ParamByName('VALOR_CREDITO').AsCurrency := 0; //StrToCurr(R.NPOS_MON);
//                if R.NPOS_ERR = '00' then
                try
//                 Inc(TotalCom);
                 IBSQL3.ExecQuery;
                 ValorCom := ValorCom - ComisionN;
                 SumGMFComision := SumGMFComision - ComisionN;

                 case IBSQL2.FieldByName('ID_TIPO_CAPTACION').AsInteger of
                  2: ValorCRindediario := ValorCRindediario - ComisionN;
                  4: ValorCJuvenil := ValorCJuvenil - ComisionN;
                 end;
                except
                 Transaction.Rollback;
                 raise;
                end; // fin del try

               end
               else
               begin
                IBSQL3.ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'Com ' + MidStr((Descripcion + ' ' + R.NPOS_NOM),1,46);
                IBSQL3.ParamByName('VALOR_DEBITO').AsCurrency := 0;
                IBSQL3.ParamByName('VALOR_CREDITO').AsCurrency := ComisionN; //StrToCurr(R.NPOS_MON);
//                if R.NPOS_ERR = '00' then
                try
                 Inc(TotalCom);
                 IBSQL3.ExecQuery;
                 ValorCom := ValorCom + ComisionN;
                 SumGMFComision := SumGMFComision + ComisionN;

                 case IBSQL2.FieldByName('ID_TIPO_CAPTACION').AsInteger of
                  2: ValorCRindediario := ValorCRindediario + ComisionN;
                  4: ValorCJuvenil := ValorCJuvenil + ComisionN;
                 end;

                except
                 Transaction.Rollback;
                 raise;
                end; // fin del try
               end; // fin EsDebito
              end; // fin del if ComisionN


                IBSQL3.Close;
                IBSQL3.SQL.Clear;
                IBSQL3.SQL.Add('SELECT');
                IBSQL3.SQL.Add('  "gen$persona".PRIMER_APELLIDO || ''  '' ||');
                IBSQL3.SQL.Add('  "gen$persona".SEGUNDO_APELLIDO || ''  '' ||');
                IBSQL3.SQL.Add('  "gen$persona".NOMBRE as NOMBRE');
                IBSQL3.SQL.Add('FROM');
                IBSQL3.SQL.Add('  "cap$maestrotitular"');
                IBSQL3.SQL.Add('  INNER JOIN "gen$persona" ON ("cap$maestrotitular".ID_IDENTIFICACION = "gen$persona".ID_IDENTIFICACION) AND ("cap$maestrotitular".ID_PERSONA = "gen$persona".ID_PERSONA)');
                IBSQL3.SQL.Add('WHERE');
                IBSQL3.SQL.Add('  "cap$maestrotitular".ID_AGENCIA = :ID_AGENCIA and');
                IBSQL3.SQL.Add('  "cap$maestrotitular".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                IBSQL3.SQL.Add('  "cap$maestrotitular".NUMERO_CUENTA = :NUMERO_CUENTA and');
                IBSQL3.SQL.Add('  "cap$maestrotitular".DIGITO_CUENTA = :DIGITO_CUENTA and');
                IBSQL3.SQL.Add('  "cap$maestrotitular".NUMERO_TITULAR = 1');
                IBSQL3.ParamByName('ID_AGENCIA').AsInteger := IBSQL2.FieldByName('ID_AGENCIA').AsInteger;
                IBSQL3.ParamByName('ID_TIPO_CAPTACION').AsInteger := IBSQL2.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                IBSQL3.ParamByName('NUMERO_CUENTA').AsInteger := IBSQL2.FieldByName('NUMERO_CUENTA').AsInteger;
                IBSQL3.ParamByName('DIGITO_CUENTA').AsInteger := IBSQL2.FieldByName('DIGITO_CUENTA').AsInteger;
                try
                  IBSQL3.ExecQuery;
                except
                  IBSQL3.Transaction.Rollback;
                  raise;
                end;

                if ((MontoN <> 0) or (ComisionN <> 0)) then
                begin
                 CDS.Open;
                 CDS.Insert;
                 CDS.FieldByName('ID_TARJETA').AsString := LeftStr(R.NPOS_TAR,16);
                 CDS.FieldByName('CUENTA').AsString := IBSQL2.FieldByName('ID_TIPO_CAPTACION').AsString +
                                                       Format('%.2d',[IBSQL2.FieldByName('ID_AGENCIA').AsInteger]) +
                                                       Format('%.7d',[IBSQL2.FieldByName('NUMERO_CUENTA').AsInteger]) +
                                                       IBSQL2.FieldByName('DIGITO_CUENTA').AsString;
                 CDS.FieldByName('ASOCIADO').AsString := IBSQL3.FieldByName('NOMBRE').AsString;
                 CDS.FieldByName('TERMINAL').AsString := R.NPOS_NOM;
                 CDS.FieldByName('SECUENCIA').AsString := R.NPOS_FLD;
                 CDS.FieldByName('MONTO').AsCurrency := MontoN;
                 CDS.FieldByName('COMISION').AsCurrency := ComisionN;
                 CDS.FieldByName('APROBADA').AsBoolean := Aprobada;
                 CDS.Post;
                 CDS.Close;
                end;

                IBSQL2.Close;
                IBSQL3.Close;

//Fin Insertar movimientos en Extracto
          end; // with

        end;  // while

        Row := 'RESUMEN DE MOVIMIENTOS CARGADOS';
        LErrores.Add(Row);
{
        IBSQL1.Close;
        IBSQL1.SQL.Clear;
        IBSQL1.SQL.Add('delete from "cap$tarjetamovol"');
        try
         IBSQL1.ExecQuery;
        except
         IBSQL1.Transaction.Rollback;
         raise;
        end;
 }
{
        IBSQL1.Transaction.Commit;
        IBSQL1.Transaction.StartTransaction;
}
        IBSQL1.Close;
        IBSQL1.SQL.Clear;
        IBSQL1.SQL.Add('select * from "cap$tarjetared" where IDRED = :IDRED');
        for i := 1 to 5 do begin
          IBSQL1.ParamByName('IDRED').AsInteger := i;
          try
           IBSQL1.Close;
           IBSQL1.ExecQuery;
          except
           IBSQL1.Transaction.Rollback;
           raise;
          end;

         AR := LResumen.Items[i-1];
         Row := 'Vlr. Deb. ' + IBSQL1.FieldByName('DESCRIPCION').AsString + #9 + ':' + #9 + FormatCurr('#,0.00',AR^.Vd);
         LErrores.Add(Row);
         Row := 'Vlr. Cre. ' + IBSQL1.FieldByName('DESCRIPCION').AsString + #9 + ':' + #9 + FormatCurr('#,0.00',AR^.Vc);
         LErrores.Add(Row);
        end;

        Row := 'Total Registros Aplicados  : ' + FormatCurr('#,0',TotalReg);
        LErrores.Add(Row);
        Row := 'Total Comisiones Aplicadas : ' + FormatCurr('#,0',TotalCom);
        LErrores.Add(Row);
        Row := 'Valor Comisiones Aplicadas : ' + FormatCurr('#,0',ValorCom);
        LErrores.Add(Row);

        SumDebito := 0;
        SumCredito := 0;

        for i := 1 to 5 do
        begin
          AR := LResumen.Items[i-1];
          SumDebito := SumDebito + AR^.Vd;
          SumCredito := SumCredito + AR^.Vc;
          Dispose(AR);
        end;

// Crear Nota Contable

// Buscar Codigo del Banco
        with IBSQL1 do begin
         Close;
         SQL.Clear;
         SQL.Add('select * from "cap$tarjetacodpuc"');
         try
          ExecQuery;
          CodigoBco := FieldByName('CODIGO').AsString;
         except
          Transaction.Rollback;
          raise;
         end;

         Close;
         SQL.Clear;
         SQL.Add('select CODIGO_CONTABLE from "cap$tipocaptacion" where ID_TIPO_CAPTACION = :ID');
         ParamByName('ID').AsInteger := 2;
         try
          ExecQuery;
          CodigoCap := FieldByName('CODIGO_CONTABLE').AsString;
         except
          Transaction.Rollback;
          raise;
         end;

         Close;
         SQL.Clear;
         SQL.Add('select CODIGO_CONTABLE from "cap$tipocaptacion" where ID_TIPO_CAPTACION = :ID');
         ParamByName('ID').AsInteger := 4;
         try
          ExecQuery;
          CodigoJuv := FieldByName('CODIGO_CONTABLE').AsString;
         except
          Transaction.Rollback;
          raise;
         end;

         CodigoGMF := CodigoBco;
         CodigoGas := '531520000000000000';

         Close;
         SQL.Clear;
         SQL.Add('select * from "gen$minimos" where ID_MINIMO = :ID');
         ParamByName('ID').AsInteger := 12;
         try
          ExecQuery;
          VecesGMF := FieldByName('VALOR_MINIMO').AsInteger;
         except
          Transaction.Rollback;
          raise;
         end;

        end;

        GMF := SimpleRoundTo((SumGMF / 1000) * VecesGMF,0);
        GMFComision := SimpleRoundTo((SumGMFComision / 1000) * VecesGMF,0);
        TotalComprobante := Abs(SumDebito - SumCredito)+GMF+ValorCom+GMFComision;

       if TotalComprobante > 0 then
       begin
        Consecutivo := ObtenerConsecutivo(IBSQLComp);

        with IBComprobante do begin
         Close;
         SQL.Clear;
         SQL.Add('insert into "con$comprobante" values(');
         SQL.Add(':ID_COMPROBANTE,:ID_AGENCIA,:TIPO_COMPROBANTE,');
         SQL.Add(':FECHA_DIA,:DESCRIPCION,:TOTAL_DEBITO,:TOTAL_CREDITO,');
         SQL.Add(':ESTADO,:IMPRESO,:ANULACION,:ID_EMPLEADO)');
         ParamByName('ID_COMPROBANTE').AsInteger := Consecutivo;
         ParamByName('ID_AGENCIA').AsInteger := Agencia;
//         if AR^.IdAgencia = Agencia then
            ParamByName('TIPO_COMPROBANTE').AsString := '1';
//         else
//            ParamByName('TIPO_COMPROBANTE').AsString := '2';
         ParamByName('FECHA_DIA').AsDate := vFecha;//fFechaActual;
         ParamByName('DESCRIPCION').AsString := 'Contabilización Movimientos Tarjeta Débito del día ' + DateToStr(fFechaActual);
         ParamByName('TOTAL_DEBITO').AsCurrency := TotalComprobante;
         ParamByName('TOTAL_CREDITO').AsCurrency := TotalComprobante;
         ParamByName('ESTADO').AsString := 'O';
         ParamByName('IMPRESO').AsInteger := 0;
         ParamByName('ANULACION').AsString := '';
         ParamByName('ID_EMPLEADO').AsString := DBAlias;
         try
          ExecSQL;
         except
          Transaction.Rollback;
          raise;
         end;




         Close;
         SQL.Clear;
         SQL.Add('insert into "con$auxiliar" values(');
         SQL.Add(':ID_COMPROBANTE,:ID_AGENCIA,:FECHA,');
         SQL.Add(':CODIGO,:DEBITO,:CREDITO,:ID_CUENTA,');
         SQL.Add(':ID_COLOCACION,:ID_IDENTIFICACION,:ID_PERSONA,');
         SQL.Add(':MONTO_RETENCION,:TASA_RETENCION,:ESTADOAUX)');
         ParamByName('ID_COMPROBANTE').AsInteger := Consecutivo;
         ParamByName('ID_AGENCIA').AsInteger := Agencia;
         ParamByName('FECHA').AsDate := vFecha;//fFechaActual;
// Datos Banco
         if ( TotalComprobante - (GMF+GMFComision) ) > 0 then
         begin
          ParamByName('CODIGO').AsString := CodigoBco;
          ParamByName('DEBITO').AsCurrency := 0;
          ParamByName('CREDITO').AsCurrency := (TotalComprobante-(GMF+GMFComision));
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         end;

         if ValorERindediario > 0 then
         begin
          ParamByName('CODIGO').AsString := CodigoCap;
          ParamByName('DEBITO').AsCurrency := 0;
          ParamByName('CREDITO').AsCurrency := ValorERindediario;
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         end;

         if ValorEJuvenil > 0 then
         begin
          ParamByName('CODIGO').AsString := CodigoJuv;
          ParamByName('DEBITO').AsCurrency := 0;
          ParamByName('CREDITO').AsCurrency := ValorEJuvenil;
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         end;

         if (ValorSRindediario) > 0 then
         begin
          ParamByName('CODIGO').AsString := CodigoCap;
          ParamByName('DEBITO').AsCurrency := ValorSRindediario;
          ParamByName('CREDITO').AsCurrency := 0;
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         end;

         if (ValorCRindediario) > 0 then
         begin
          ParamByName('CODIGO').AsString := CodigoCap;
          ParamByName('DEBITO').AsCurrency := ValorCRindediario;
          ParamByName('CREDITO').AsCurrency := 0;
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         end;


         if (ValorSJuvenil) > 0 then
         begin
          ParamByName('CODIGO').AsString := CodigoJuv;
          ParamByName('DEBITO').AsCurrency := ValorSJuvenil;
          ParamByName('CREDITO').AsCurrency := 0;
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         end;

         if (ValorCJuvenil) > 0 then
         begin
          ParamByName('CODIGO').AsString := CodigoJuv;
          ParamByName('DEBITO').AsCurrency := ValorCJuvenil;
          ParamByName('CREDITO').AsCurrency := 0;
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         end;

         if (GMF+GMFComision) > 0 then
         begin
          ParamByName('CODIGO').AsString := CodigoGas;
          ParamByName('DEBITO').AsCurrency := (GMF+GMFComision);
          ParamByName('CREDITO').AsCurrency := 0;
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         end;

         if GMF > 0 then
         begin
          ParamByName('CODIGO').AsString := CodigoGMF;
          ParamByName('DEBITO').AsCurrency := 0;
          ParamByName('CREDITO').AsCurrency := GMF;
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         end;

         if GMFComision > 0 then
         begin
          ParamByName('CODIGO').AsString := CodigoGMF;
          ParamByName('DEBITO').AsCurrency := 0;
          ParamByName('CREDITO').AsCurrency := GMFComision;
          ParamByName('ID_CUENTA').Clear;
          ParamByName('ID_COLOCACION').Clear;
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').Clear;
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').Clear;
          ParamByName('ESTADOAUX').AsString := 'O';
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         end;


        end;
       end;             

         IBSQL1.Transaction.Commit;
// Presentar informe y reporte de errores

        cmdReporte.Enabled := True;
        fichero := ChangeFileExt(FileName,'.txt');
        LErrores.SaveToFile(fichero);
        ShellExecute(Handle, 'open', 'notepad.exe', PChar(fichero), nil, SW_SHOWNORMAL);

end;

procedure TfrmDescarMOVTD.DownloadBlqs(fFileName: string);
var
  Archivo:TextFile;
  Registro:string;
  R:TRegBlq;
begin
        AssignFile(Archivo,fFileName);
        Reset(Archivo);

        with IBSQL1 do begin
            if Transaction.InTransaction then
               Transaction.Rollback;
            Transaction.StartTransaction;
            Close;
            SQL.Clear;
            SQL.Add('insert into "cap$tarjetablq" values (');
            SQL.Add('NOV_SEC,');
            SQL.Add('NOV_BIN,');
            SQL.Add('NOV_CAR,');
            SQL.Add('NOV_FRE,');
            SQL.Add('NOV_HOR,');
            SQL.Add('NOV_FCO,');
            SQL.Add('NOV_COD,');
            SQL.Add('NOV_TER,');
            SQL.Add('NOV_USE,');
            SQL.Add(')');
        end;

         while not Eof(Archivo) do
         begin
           Readln(Archivo,
                  R.NOV_SEC,
                  R.NOV_BIN,
                  R.NOV_CAR,
                  R.NOV_FRE,
                  R.NOV_HOR,
                  R.NOV_FCO,
                  R.NOV_COD,
                  R.NOV_TER,
                  R.NOV_USE
                  );
            if LeftStr(R.NOV_SEC,6) = 'FOOTER' then
            begin
             Break;
            end;

           with IBSQL1 do begin
           ParamByName('NOV_SEC').Asstring := R.NOV_SEC;
           ParamByName('NOV_BIN').AsString := R.NOV_BIN;
           ParamByName('NOV_CAR').AsString := R.NOV_CAR;
           ParamByName('NOV_FRE').AsDate := EncodeDate(StrToInt(LeftStr(R.NOV_FRE,4)),StrToInt(MidStr(R.NOV_FRE,5,2)),StrToInt(RightStr(R.NOV_FRE,2)));
           ParamByName('NOV_HOR').AsTime := EncodeTime(StrToint(LeftStr(R.NOV_HOR,2)),StrToInt(MidStr(R.NOV_HOR,3,2)),StrToInt(RightStr(R.NOV_HOR,2)),00);
           ParamByName('NOV_FCO').AsDate := EncodeDate(StrToInt(LeftStr(R.NOV_FCO,4)),StrToInt(MidStr(R.NOV_FCO,5,2)),StrToInt(RightStr(R.NOV_FCO,2)));
           ParamByName('NOV_COD').AsInteger := StrToInt(R.NOV_COD);
           ParamByName('NOV_TER').AsString := R.NOV_TER;
           ParamByName('NOV_USE').AsString := R.NOV_USE;
           try
             ExecQuery;
           except
             Transaction.Rollback;
             raise;
           end;

           end; // with

           with IBSQL2 do begin
            Close;
            SQL.Clear;
            SQL.Add('update "cap$tarjetacuenta" set ID_ESTADO = :ID_ESTADO, FECHA_BLOQUE = :FECHA_BLOQUEO');
            SQL.Add('where ID_TARJETA = :ID_TARJETA');
            ParamByName('ID_TARJETA').AsString := LeftStr(R.NOV_CAR,16);
            ParamByName('ID_ESTADO').AsInteger := 2;
            ParamByName('FECHA_BLOQUEO').AsDate := EncodeDate(StrToInt(LeftStr(R.NOV_FRE,4)),StrToInt(MidStr(R.NOV_FRE,5,2)),StrToInt(RightStr(R.NOV_FRE,2)));
            try
             ExecQuery;
            except
             Transaction.Rollback;
             raise;
            end;
           end;

        end;  // while

        IBSQL1.Transaction.Commit;



end;

procedure TfrmDescarMOVTD.DownloadTars(fFileName: string);
var
  Archivo:TextFile;
  Registro:string;
  R:TRegTar;
  Valor:Currency;
begin
        AssignFile(Archivo,fFileName);
        Reset(Archivo);

        with IBSQL1 do begin
            if Transaction.InTransaction then
               Transaction.Rollback;
            Transaction.StartTransaction;
            Close;
            SQL.Clear;
            SQL.Add('insert into "cap$tarjetatar" values (');
            SQL.Add(':TAR_NEW,');
            SQL.Add(':TAR_CUP,');
            SQL.Add(':TAR_DAT');
            SQL.Add(')');
        end;

         while not Eof(Archivo) do
         begin
           Readln(Archivo,
                  R.TAR_NEW,
                  R.TAR_CUP
                  );
           with IBSQL1 do begin
           ParamByName('TAR_NEW').Asstring := LeftStr(R.TAR_NEW,16);
           ParamByName('TAR_CUP').AsCurrency := StrToCurr(R.TAR_CUP)/100;
           ParamByName('TAR_DAT').AsDate := fFechaActual;
           try
             ExecQuery;
           except
             Transaction.Rollback;           
             raise;
           end;

           end; // with

           IBSQL2.Close;
           IBSQL2.SQL.Clear;
           IBSQL2.SQL.Add('insert into "cap$tarjetasdebito" values(:ID_TARJETA,:ASIGNADA,:ID_ESTADO)');
           IBSQL2.ParamByName('ID_TARJETA').AsString := LeftStr(R.TAR_NEW,16);
           IBSQL2.ParamByName('ASIGNADA').AsInteger := 0;
           IBSQL2.ParamByName('ID_ESTADO').AsInteger := 0;
           try
            IBSQL2.ExecQuery;
           except
            IBSQL2.Transaction.Rollback;
            raise;
           end;

        end;  // while

        IBSQL1.Transaction.Commit;

end;

procedure TfrmDescarMOVTD.cmdComprobanteClick(Sender: TObject);
begin

   if IBAuxiliar.Transaction.InTransaction then
      IBAuxiliar.Transaction.Rollback;

  IBAuxiliar.Transaction.StartTransaction;

  IBAuxiliar.Close;
  IBAuxiliar.SQL.Clear;
  IBAuxiliar.SQL.Add('select');
  IBAuxiliar.SQL.Add('         "con$auxiliar".ID_COMPROBANTE,');
  IBAuxiliar.SQL.Add('         "gen$agencia".DESCRIPCION_AGENCIA,');
  IBAuxiliar.SQL.Add('         "con$tipocomprobante".DESCRIPCION AS TIPO,');
  IBAuxiliar.SQL.Add('         "con$comprobante".FECHADIA,');
  IBAuxiliar.SQL.Add('         "con$comprobante".DESCRIPCION,');
  IBAuxiliar.SQL.Add('         "gen$empleado".PRIMER_APELLIDO,');
  IBAuxiliar.SQL.Add('         "gen$empleado".SEGUNDO_APELLIDO,');
  IBAuxiliar.SQL.Add('         "gen$empleado".NOMBRE,');
  IBAuxiliar.SQL.Add('         "con$auxiliar".CODIGO,');
  IBAuxiliar.SQL.Add('         "con$puc".NOMBRE AS CUENTA,');
  IBAuxiliar.SQL.Add('         "con$auxiliar".ID_CUENTA,');
  IBAuxiliar.SQL.Add('         "con$auxiliar".ID_COLOCACION,');
  IBAuxiliar.SQL.Add('         "con$auxiliar".ID_IDENTIFICACION,');
  IBAuxiliar.SQL.Add('         "con$auxiliar".ID_PERSONA,');
  IBAuxiliar.SQL.Add('         "gen$persona".PRIMER_APELLIDO AS PRIMER_APELLIDO1,');
  IBAuxiliar.SQL.Add('         "gen$persona".SEGUNDO_APELLIDO AS SEGUNDO_APELLIDO1,');
  IBAuxiliar.SQL.Add('         "gen$persona".NOMBRE AS NOMBRE1,');
  IBAuxiliar.SQL.Add('         "con$auxiliar".DEBITO,');
  IBAuxiliar.SQL.Add('         "con$auxiliar".CREDITO');
  IBAuxiliar.SQL.Add('         from');
  IBAuxiliar.SQL.Add('"con$comprobante"');
  IBAuxiliar.SQL.Add('LEFT JOIN "con$auxiliar" ON ("con$comprobante".ID_COMPROBANTE = "con$auxiliar".ID_COMPROBANTE)');
  IBAuxiliar.SQL.Add('LEFT JOIN "con$tipocomprobante" ON ("con$comprobante".TIPO_COMPROBANTE  = "con$tipocomprobante".ID ) ');
  IBAuxiliar.SQL.Add('LEFT JOIN "gen$agencia" ON ("con$auxiliar".ID_AGENCIA = "gen$agencia".ID_AGENCIA)');
  IBAuxiliar.SQL.Add('LEFT JOIN "con$puc" ON ("con$auxiliar".CODIGO = "con$puc".CODIGO)');
  IBAuxiliar.SQL.Add('LEFT JOIN "gen$empleado" ON ("con$comprobante".ID_EMPLEADO = "gen$empleado".ID_EMPLEADO) ');
  IBAuxiliar.SQL.Add('LEFT JOIN "gen$persona" ON ("con$auxiliar".ID_IDENTIFICACION = "gen$persona".ID_IDENTIFICACION and "con$auxiliar".ID_PERSONA = "gen$persona".ID_PERSONA )');
  IBAuxiliar.SQL.Add('where');
  IBAuxiliar.SQL.Add('"con$comprobante".ID_COMPROBANTE = :ID');
  IBAuxiliar.ParamByName('ID').AsInteger := Consecutivo;

  if reporte.PrepareReport then
     reporte.PreviewPreparedReport(True);

  IBAuxiliar.Transaction.Commit;

  chkBox10.Checked := True;

end;

procedure TfrmDescarMOVTD.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
        if POP.Connected then
           POP.Disconnect;
end;

procedure TfrmDescarMOVTD.cmdReporteClick(Sender: TObject);
begin
        reportemov.Variables.ByName['EMPRESA'].AsString := Empresa;
        reportemov.Variables.ByName['NIT'].AsString := Nit;
        reportemov.Variables.ByName['FECHACORTE'].AsDateTime := FechaCorte;

        if reportemov.PrepareReport then
           reportemov.PreviewPreparedReport(True);
end;

procedure TfrmDescarMOVTD.FormShow(Sender: TObject);
begin
        Edit1.Text := Pop3ServerMail1;
        Edit2.Text := Pop3ServerMail2;
end;

procedure TfrmDescarMOVTD.btnArchivoExternoClick(Sender: TObject);
var
  cadena:string;
begin
        if EdArchivoExterno.Text <> '' then
          begin
           FileName := EdArchivoExterno.FileName;
           cadena := RightStr(FileName,12);
           FechaCorte := EncodeDate(StrToInt(MidStr(cadena,5,4)),StrToInt(MidStr(cadena,3,2)),StrToInt(LeftStr(cadena,2)));
           chkBox3.Checked := True;
           cmdLeer.Enabled := False;
           cmdDescomp.Enabled := True;
          end;

end;

procedure TfrmDescarMOVTD.EdArchivoExternoAfterDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
        btnArchivoExterno.Enabled := True;
end;

procedure TfrmDescarMOVTD.EdArchivoExternoChange(Sender: TObject);
begin
        if EdArchivoExterno.Text <> '' then
          btnArchivoExterno.Enabled := True
        else
          btnArchivoExterno.Enabled := False;
end;

end.
