unit Unitdescarga;

interface

uses
  Windows,ShellApi, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdPOP3, IdBaseComponent, IdMessage, StrUtils,IniFiles,
  AbBase, AbBrowse, AbZBrows, AbUnzper,UnitClaseData, DB, DBClient,UnitClaseXml,AbArcTyp,UnitConexion,
  Mask, JvToolEdit, ExtCtrls, Buttons, JvEdit, Grids, DBGrids;

type
  TFrmDescaraAutomatica = class(TForm)
    Msg: TIdMessage;
    POP: TIdPOP3;
    IdTCPClient1: TIdTCPClient;
    SaveDialog1: TSaveDialog;
    btDescargArchivo: TButton;
    UnZip: TAbUnZipper;
    CdSentencia: TClientDataSet;
    CdSentenciaID_AGENCIA: TIntegerField;
    CdSentenciaSENTENCIA: TStringField;
    CdSentenciaTIPO: TStringField;
    IdTCPClient2: TIdTCPClient;
    Button1: TButton;
    Panel1: TPanel;
    EdArchivoExterno: TJvFilenameEdit;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Panel2: TPanel;
    bitProcesar: TBitBtn;
    bitCancelar: TBitBtn;
    bitSalir: TBitBtn;
    EdFecha: TJvEdit;
    EdConvenio: TJvEdit;
    EdOperador: TJvEdit;
    EdFormato: TJvEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    EdMov: TEdit;
    Label4: TLabel;
    EdBlq: TEdit;
    Label5: TLabel;
    EdTar: TEdit;
    Label6: TLabel;
    EdEst: TEdit;
    Button2: TButton;
    bitDescomprimir: TBitBtn;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    GroupBox2: TGroupBox;
    mLineas: TMemo;
    Memotxt: TMemo;
    procedure btDescargArchivoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UnZipArchiveItemProgress(Sender: TObject;
      Item: TAbArchiveItem; Progress: Byte; var Abort: Boolean);
    procedure EdArchivoExternoChange(Sender: TObject);
    procedure bitSalirClick(Sender: TObject);
    procedure bitCancelarClick(Sender: TObject);
    procedure bitProcesarClick(Sender: TObject);
    procedure bitDescomprimirClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
      FileName:TFileName;
      _fFechaActual :TDate;
      _sRutaArchivo :string;
      _iIndice :Integer;
      _sRutaLectura :string;
      //Variables PGP
      ListaFile:TList;
      fUnidad :string;
      _tData :TData;
      _tConexion :TConexion;
      _tXml :TXml;
      Astream :TMemoryStream;
      _sNombreArchivo :string;
      _dFechaDescarga :TDate;
      procedure RetrievePOPHeaders(inMsgCount: Integer);
      procedure RetrieveExecute(Sender: TObject);
      function  FindAttachment(stFilename: string): Integer;
    procedure Descomprimir;
    procedure DescargarMovs(fFileName: string);
    procedure DescargarBlqs(fFileName: string);
    procedure DescargarTars(fFileName: string);
    procedure Procesar;
    procedure Transferir;
    function EnviarXml(_iIdPuerto: Integer; sIdHost, Desc: string;
      AstreamEnv: TMemoryStream): TMemoryStream;
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
        NOV_CAR:string[13];
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
  FrmDescaraAutomatica: TFrmDescaraAutomatica;

implementation
uses UnitGlobalTD,UnitPantallaProgreso;

{$R *.dfm}

procedure TFrmDescaraAutomatica.RetrieveExecute(Sender: TObject);
begin
end;

procedure TFrmDescaraAutomatica.RetrievePOPHeaders(inMsgCount: Integer);
begin
end;

function TFrmDescaraAutomatica.FindAttachment(stFilename: string): Integer;
var
  intIndex: Integer;
  found: boolean;
begin
  intIndex := -1;
  result := -1;
  if (Msg.MessageParts.Count < 1) then
    exit; //No existen Archivos Adjuntos
  found := false;
  stFilename := uppercase(stFilename);
  repeat
    inc(intIndex);
    if (Msg.MessageParts.Items[intIndex] is TIdAttachment) then
    begin //Colocar Archivo Adjunto
      if stFilename =
        uppercase(TIdAttachment(Msg.MessageParts.Items[intIndex]).Filename) then
        found := true;
    end;
  until found or (intIndex > Pred(Msg.MessageParts.Count));
  if found then
    result := intIndex
  else
    result := -1;


end;


procedure TFrmDescaraAutomatica.btDescargArchivoClick(Sender: TObject);
begin
//        Memotxt.Clear;
        DBAlias := 'T.DEBITO';
        _tConexion := TConexion.Create;
        _tConexion.Conectar;
        _tData := TData.Create;
        _tData.Database := _tConexion.Database;
        ShortTimeFormat := 'HH:mm:ss';
        Descomprimir;
//        Procesar;
        _tConexion.Desconectar;
        Application.Terminate;
end;

procedure TFrmDescaraAutomatica.FormCreate(Sender: TObject);
var
    MiINI :string;
begin
  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(MiINI) do
  try
    _sRutaArchivo := ReadString('DBNAME','ruta','c:\');
    DBserver := ReadString('DBNAME','server','192.168.200.7');
    DBPath := ReadString('DBNAME','path','/home/');
    DBname := ReadString('DBNAME','name','coopservir.gdb');
    Self.Caption := 'Conectado a: ' + DBServer + ':' + DBpath + DBname;
  finally
    free;
  end;
//  btDescargArchivo.Click;

end;

procedure TFrmDescaraAutomatica.Descomprimir;
var
  DirectorioBase:string;
  Ruta:string;
  Archivo,Archivo1,Convenio,Fecha:string;
  FechaDia:TDate;
  AR:PArchivos;
  i:Integer;
  fText:TextFile;
  _sProceso : string;
  _iTamano :Integer;
  _sRutaPGP :string;
  _sArchivoPGP :string;
begin
  //proceso de desencriptar el archivo
  if FileExists(FileName) then
  begin
  _sArchivoPGP := RightStr(FileName,15); // Busco la ruta donde esta el archivo y se extrae el nombre
  _iTamano := StrLen(PChar(FileName));
  _sRutaPGP := LeftStr(FileName,_itamano - 15); //Busco la ruta de la carpeta del archivo
  _sRutaLectura := _sRutaPGP;
//   Memo1.Text := _sProceso;
  end
  else
  begin
    Exit;
  end;  //Proceso para desencriptar el archivo
  _sNombreArchivo := FileName;
  if FileExists(FileName) then
  begin
   ListaFile := TList.Create;
   UnZip.FileName := FileName;
   with UnZip do begin
      FUnidad := ExtractFilePath( FileName );
      BaseDirectory := ExtractFilePath( FileName );
      ExtractFiles( '*.*' );
      for i := 0 to ListaFile.Count - 1 do
      begin
        AR := ListaFile.Items[i];
        Archivo1 := AR^.Nombre;
        if FileExists(Archivo1) then
        begin
         AR^.Existe := True;
         if LowerCase(ExtractFileExt(AR^.Nombre)) = '.mov' then
            EdMov.Text := Archivo1;
         if LowerCase(ExtractFileExt(AR^.Nombre)) = '.blq' then
            EdBlq.Text := Archivo1;
         if LowerCase(ExtractFileExt(AR^.Nombre)) = '.tar' then
            EdTar.Text := Archivo1;
         if LowerCase(ExtractFileExt(AR^.Nombre)) = '.est' then
            EdEst.Text := Archivo1;
        end;
      end;
   end;
  end
  else
  begin
//      ShowMessage('No Existe Ningún Archivo a Procesar');
      Exit;
  end;
end;

procedure TFrmDescaraAutomatica.DescargarMovs(fFileName: string);
var     _sSentencia :string;
        _sCadena :string;
        _sCadena1 :string;
        _sSentenciaOf :string;
        _sCadenaInicial :string; //Cadena inicial
        Archivo:TextFile;
        R:TRegMov;
        Monto:string;
        Comision :string;
        _iIdAgencia :Integer; //Agencia a la Que pertenece la tarjeta
        _iIdAgenciaDataF :Integer; //Agencia a la que pertenece el Datafono
        _rTras :string;
begin
        _sCadena1 := '';
        AssignFile(Archivo,fFileName);
        Reset(Archivo);
        while not Eof(Archivo) do

        begin
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
          _tData.Tarjeta := Trim(R.NPOS_TAR);
          _tData._sDatafono := MidStr(Trim(R.NPOS_FLD),3,6);
          _iIdAgencia := _tData.ValidaAgencia;
          _iIdAgenciaDataF := _tData.ValidaDatafono;
          _tData._sSentencia := 'insert into TDB$TARJETAMOV values ( ';
          _sSentencia := 'insert into "tmp$tarjetamovtem" values (';

          if (R.NPOS_TRA = 'B') then
             _rTras := '11'
          else if (R.NPOS_TRA = 'A') then
            _rTras := '12'
          else
            _rTras := R.NPOS_TRA;   //OJO VALIDAR ESTE TIPO DE MOVIMIENTO
          //LLenar cadena inicial
          _sCadenaInicial  := R.NPOS_CSC +
                              ',' + QuotedStr(R.NPOS_CTA) +
                              ',' + QuotedStr(R.NPOS_TAR) +
                              ',' + R.NPOS_RAD +
                              ',' + R.NPOS_SEC +
                              ',' + QuotedStr(R.NPOS_NTE) +
                              ',' + QuotedStr(R.NPOS_NOM) +
                              ',' + QuotedStr(DateToStr(EncodeDate(StrToInt(LeftStr(R.NPOS_FEC,4)),StrToInt(MidStr(R.NPOS_FEC,5,2)),StrToInt(RightStr(R.NPOS_FEC,2)))))+
                              ',' + QuotedStr(LeftStr(R.NPOS_HOR,2)  + ':' + MidStr(R.NPOS_HOR,3,2)+ ':' + RightStr(R.NPOS_HOR,2)) +
                              ',' + QuotedStr(Monto) +
                              ',' + QuotedStr(Comision) +
                              ',' + _rTras +
                              ',' + QuotedStr(R.NPOS_ERR) +
                              ',' + R.NPOS_TER +
                              ',' + R.NPOS_RED +
                              ',' + QuotedStr(R.NPOS_NCA) +
                              ',' + QuotedStr(R.NPOS_FLD) +
                              ',1';

          if StrToInt(_rTras) < 10 then
          begin
            //Validación Movimientos realizados por datafono en oficina diferencte a la oficina de la tarjeta
            if  (R.NPOS_RED = '5') and (_iIdAgencia <> _iIdAgenciaDataF) then
            begin
                  //Movimiento para la oficina dueña de la tarjeta
                  _sSentenciaOf := _sSentencia;
                  _sCadena := _sCadenaInicial + ',' + IntToStr(_iIdAgencia) + ')';
                  _sSentenciaOf := _sSentencia + _sCadena;
                  CdSentencia.Append;
                  CdSentencia.FieldValues['ID_AGENCIA'] := _iIdAgenciaDataF;
                  CdSentencia.FieldValues['SENTENCIA'] := _sSentenciaOf;
                  CdSentencia.FieldValues['TIPO'] := 'insert';
                  CdSentencia.Post;
                  //Movimiento para la oficina dueña de la tarjeta
                  _sCadena := _sCadenaInicial + ',' + IntToStr(_iIdAgenciaDataF) + ')';
                  _sSentencia := _sSentencia + _sCadena;
                  CdSentencia.Append;
                  CdSentencia.FieldValues['ID_AGENCIA'] := _iIdAgencia;
                  CdSentencia.FieldValues['SENTENCIA'] := _sSentencia;
                  CdSentencia.FieldValues['TIPO'] := 'insert';
                  CdSentencia.Post;
            end
            else
            begin // caso para retiros por cajero o para datafonos contarjetas de la misma oficina
                  _sCadena := _sCadenaInicial + ',' + IntToStr(_iIdAgencia) + ')';
                  _sSentencia := _sSentencia + _sCadena;
                  CdSentencia.Append;
                  CdSentencia.FieldValues['ID_AGENCIA'] := _iIdAgencia;
                  CdSentencia.FieldValues['SENTENCIA'] := _sSentencia;
                  CdSentencia.FieldValues['TIPO'] := 'insert';
                  CdSentencia.Post;
             end; //fin de la validación de la red
// ******************* ****Fin de la validación de los movimientos reales......
            end;
            _sCadena1 := R.NPOS_CSC +
                        ',' + QuotedStr(R.NPOS_CTA) +
                        ',' + QuotedStr(R.NPOS_TAR) +
                        ',' + R.NPOS_RAD +
                        ',' + R.NPOS_SEC +
                        ',' + QuotedStr(R.NPOS_NTE) +
                        ',' + QuotedStr(R.NPOS_NOM) +
                        ',' + QuotedStr(DateToStr(EncodeDate(StrToInt(LeftStr(R.NPOS_FEC,4)),StrToInt(MidStr(R.NPOS_FEC,5,2)),StrToInt(RightStr(R.NPOS_FEC,2)))))+
                        ',' + QuotedStr(LeftStr(R.NPOS_HOR,2)  + ':' + MidStr(R.NPOS_HOR,3,2)+ ':' + RightStr(R.NPOS_HOR,2)) +
                        ',' + QuotedStr(Monto) +
                        ',' + QuotedStr(Comision) +
                        ',' + _rTras +
                        ',' + QuotedStr(R.NPOS_ERR) +
                        ',' + R.NPOS_TER +
                        ',' + R.NPOS_RED +
                        ',' + QuotedStr(R.NPOS_NCA) +
                        ',' + QuotedStr(R.NPOS_FLD) +
                        ',1' +
                        ',' + IntToStr(_iIdAgencia) +
                        ')';
         // _dFechaDescarga := EncodeDate(StrToInt(LeftStr(R.NPOS_FEC,4)),StrToInt(MidStr(R.NPOS_FEC,5,2)),StrToInt(RightStr(R.NPOS_FEC,2)));
          _tData._sSentencia := _tData._sSentencia + _sCadena1;
          _tData.Query;
          mLineas.Lines.Add(_tData._sSentencia + _sCadena1);
        end;// fin del while
        _sCadena := '';
        _sCadena1 := '';


end;

procedure TFrmDescaraAutomatica.DescargarBlqs(fFileName: string);
var
  Archivo:TextFile;
  Registro:string;
  R:TRegBlq;
 _iIdAgencia :Integer;
 _sSentencia :string;
 _sCadena :string;
 _sSentenciaUp :string;
begin
         AssignFile(Archivo,fFileName);
         Reset(Archivo);
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
           _tData._sTarjeta := LeftStr(R.NOV_BIN +R.NOV_CAR,16);
          _iIdAgencia := _tData.ValidaAgencia;
          _tData._sSentencia := 'insert into TDB$TARJETABLQ values ( ';
          _sSentencia := 'insert into "cap$tarjetablq" values (';
          _sCadena := QuotedStr(R.NOV_SEC) +
                      ',' + QuotedStr(R.NOV_BIN) +
                      ',' + QuotedStr(R.NOV_CAR) +
                      ',' + QuotedStr(DateToStr(EncodeDate(StrToInt(LeftStr(R.NOV_FRE,4)),StrToInt(MidStr(R.NOV_FRE,5,2)),StrToInt(RightStr(R.NOV_FRE,2))))) +
                      ',' + QuotedStr(TimeToStr(EncodeTime(StrToint(LeftStr(R.NOV_HOR,2)),StrToInt(MidStr(R.NOV_HOR,3,2)),StrToInt(RightStr(R.NOV_HOR,2)),00))) +
                      ',' + QuotedStr(DateToStr(EncodeDate(StrToInt(LeftStr(R.NOV_FCO,4)),StrToInt(MidStr(R.NOV_FCO,5,2)),StrToInt(RightStr(R.NOV_FCO,2))))) +
                      ',' + R.NOV_COD +
                      ',' + QuotedStr(R.NOV_TER) +
                      ',' + QuotedStr(R.NOV_USE) +
                      ',' + IntToStr(_iIdAgencia) +
                      ')';
          _tData._sSentencia := _tData._sSentencia + _sCadena;
          _sSentencia := _sSentencia + _sCadena;
          _sSentenciaUp := 'update "cap$tarjetacuenta" set ID_ESTADO = 3, FECHA_CANCELADA = ' + QuotedStr(DateToStr(EncodeDate(StrToInt(LeftStr(R.NOV_FRE,4)),StrToInt(MidStr(R.NOV_FRE,5,2)),StrToInt(RightStr(R.NOV_FRE,2))))) +
                           ' where ID_TARJETA = ' + QuotedStr(LeftStr(R.NOV_BIN +R.NOV_CAR,16));
          _tData.Query;
          with CdSentencia do
          begin
            Append;
            FieldValues['ID_AGENCIA'] := _iIdAgencia;
            FieldValues['SENTENCIA'] := _sSentencia;
            FieldValues['TIPO'] := 'update';
            Post;
            Append;
            FieldValues['ID_AGENCIA'] := _iIdAgencia;
            FieldValues['SENTENCIA'] := _sSentenciaUp;
            FieldValues['TIPO'] := 'insert';
            Post;

          end;
         end;// fin del while
end;

procedure TFrmDescaraAutomatica.DescargarTars(fFileName: string);
var
  Archivo:TextFile;
  Registro:string;
  R:TRegTar;
  Valor:Currency;
begin
        AssignFile(Archivo,fFileName);
        Reset(Archivo);
         while not Eof(Archivo) do
         begin
           Readln(Archivo,
                  R.TAR_NEW,
                  R.TAR_CUP
                  );
          _tData.Sentencia := 'insert into TDB$TARJETA values(' +  QuotedStr(R.TAR_NEW) + ',0,0)';
          _tData.Query;
        end;
end;

procedure TFrmDescaraAutomatica.Procesar;
var
   i:Integer;
   AR:PArchivos;
   fichero:string;
begin
        if _tData.ConsultaArchivo(_sNombreArchivo) = False then
        begin
           //ShowMessage('Archivo Procesado');
           //Exit;
        end;
        for i := 0 to ListaFile.Count - 1 do
        begin
           AR := ListaFile.Items[i];
           if LowerCase(ExtractFileExt(AR^.Nombre)) = '.mov' then
            begin
              try
                DescargarMovs(AR^.Nombre);
              except
              end;
            end;
           {if LowerCase(ExtractFileExt(AR^.Nombre)) = '.blq' then
            begin
               try
                 DescargarBlqs(AR^.Nombre);
               except
               end;
            end; }
           if LowerCase(ExtractFileExt(AR^.Nombre)) = '.tar' then
           begin
              try
                DescargarTars(AR^.Nombre);
              except
              end;
           end;
           if LowerCase(ExtractFileExt(AR^.Nombre)) = '.est' then
           begin
              try
                fichero := AR^.Nombre;
                //ShellExecute(Handle, 'open', 'notepad.exe', PChar(fichero), nil, SW_SHOWNORMAL);
              except
              end;
           end;     
        end;

        if CdSentencia.RecordCount > 0 then
        begin
          _tXml := TXml.Create;
        end;
//        Transferir;
        try
          _tData.ControlArchivo(_sNombreArchivo);
        except
        end;
end;

procedure TFrmDescaraAutomatica.Transferir;
var     _bSiHay :Boolean;
        _iIdPuerto :Integer;
        _sIdHost :string;
        _sDescripcionAg :string;
        _iIdAgencia :Integer;
        _sMensaje :string;
        _iContador :Integer;
        _cTotalBanco :Currency;
        _cERindediario :Currency;
        _cEJuvenil :Currency;
        _cSRindediario :Currency;
        _cSJuvenil :Currency;
        _cCRindediario :Currency;
        _cCJuvenil :Currency;
        _cGmfBanco :Currency;
        _cGmfComisionBanco :Currency;
        _sCodigoAg :string;
        _sCodBanco :string;
        _bConexion :Boolean;
        _sIdHostContable :string;
        _iIdPuertoContable :Integer;
        _sDesc :string;
begin
//        _dFechaDescarga := _fFechaActual;
        _tData.Sentencia := 'SELECT CODIGO FROM TDB$CODIGOPUC WHERE ID_CODIGO = 1';
        _sCodBanco := _tData.selectquery.FieldByName('CODIGO').AsString;
        with _tData.CodAgencia do
        begin
          while not Eof do
          begin
            //Validar si la Agencia fue Cargada
            _iIdAgencia := FieldByName('ID_AGENCIA').AsInteger;
            _iIdPuerto := FieldByName('ID_PUERTO').AsInteger;
            _sIdHost := FieldByName('ID_HOST').AsString;
            _sDescripcionAg := FieldByName('DESCRIPCION_AGENCIA').AsString;
            _sCodigoAg := FieldByName('CODIGO_CONTABLE').AsString;
            if _iIdAgencia = 1 then // para contabilizar respuesta de los movimientos
            begin
              _iIdPuertoContable := _iIdPuerto;
              _sIdHostContable := _sIdHost;
              _sDesc := _sDescripcionAg;
            end;
            //Validar si la Agencia fue Cargada
            if _tData.ValidaDescarga(FieldByName('ID_AGENCIA').AsInteger,_dFechaDescarga) then
            //if 1=1 then
            begin
              _bSiHay := False;
              with CdSentencia do
              begin
                 Filtered := False;
                 Filter := 'ID_AGENCIA = ' + IntToStr(_iIdAgencia);
                 Filtered := True;
                 First;
                 _iContador := 1;
                 while not Eof do
                 begin
                   if RecNo = 1 then
                   begin
                     _bSiHay := True;
                     _tXml.CrearXml;
                     _tXml.Sentencia := 'delete from "tmp$tarjetamovtem"';
                     _tXml.Tipo := 'delete';
                     _tXml.CargarNodo;
                     _iContador := _iContador + 1;
                     _tXml.Tipo := 'delete';
                     _tXml.Sentencia := 'delete from "tmp$condatafono"';
                     _tXml.CargarNodo;
                   end;
                   _tXml.Tipo := FieldByName('TIPO').AsString;
                   _tXml.Sentencia := FieldByName('SENTENCIA').AsString;
                   _tXml.CargarNodo;
                   _iContador := _iContador + 1;
                   Next;
                 end;   // fin del while del CdTarjeta

                 if _bSiHay then
                 begin
                   _tXml.Tipo := 'select';
                   _tXml.Sentencia := 'SELECT * FROM TDB_MOVTARJETA';
                   _tXml.CargarNodo;
                   Astream := _tXml.CargarAstream;
                   Astream.SaveToFile('c:\archivo' + IntToStr(_iIdAgencia) + '.xml');
                   _bConexion := True;
                   try
                    _tXml.AstreamEnt := EnviarXml(_iIdPuerto,_sIdHost,_sDescripcionAg,Astream);
                    if _iIdAgencia = 1 then
                       _tData.InsertaDescarga(FieldByName('ID_AGENCIA').AsInteger,_dFechaDescarga);
                    except
                    begin
                        _bConexion := False;
                        frmProgreso.Cerrar;
                        IdTCPClient1.Disconnect;
                        _sMensaje := _sMensaje + _sDescripcionAg;
                     end;
                   end; // Ffin del try
                 end; // Fin del Sihay
              end;// fin del CdTarjeta
              if (_iIdAgencia <> 1) and (_bConexion) and (_bSiHay) then // validacion para la generacion de comprobante de sucursales
              begin
                _tXml.ListaConsulta := 'Consulta' + FormatCurr('000',_iContador);
                with _tXml.LeerXml do
                begin
                 try
                    _cERindediario := FieldByName('VALORERIND').AsCurrency;
                    _cEJuvenil := FieldByName('VALOREJUV').AsCurrency;
                    _cSRindediario := FieldByName('VALORSRIND').AsCurrency;
                    _cSJuvenil := FieldByName('VALORSJUV').AsCurrency;
                    _cCRindediario := FieldByName('VALORCRIND').AsCurrency;
                    _cCJuvenil := FieldByName('VALORCJUV').AsCurrency;
                    _cTotalBanco := FieldByName('TOTALBANCO').AsCurrency;
                    _cGmfBanco := FieldByName('GMFBANCO').AsCurrency;
                    _cGmfComisionBanco := FieldByName('GMFCOMISIONBANCO').AsCurrency;
                 except
                 end;
                end; //fin del try
                _tXml.CrearXml;
                _tXml.Tipo := 'delete';
                _tXml.Sentencia := 'delete from "tmp$contable"';
                _tXml.CargarNodo;
                _tXml.Tipo := 'insert';
                if _cTotalBanco > 0 then
                begin
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodBanco) + ',' +
                                CurrToStr(_cTotalBanco) + ',' + '0' + ',' + QuotedStr(DBAlias) +
                                ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;
                end;
                if _cERindediario > 0 then
                begin
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodigoAg) + ',' +
                                CurrToStr(_cERindediario) + ',' + '0' + ',' + QuotedStr(DBAlias) +
                                ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;
                end;
                if _cEJuvenil > 0 then
                begin
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodigoAg) + ',' +
                                CurrToStr(_cEJuvenil) + ',' + '0' + ',' + QuotedStr(DBAlias) +
                                ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;
                end;
                if _cSRindediario > 0 then
                begin
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodigoAg) +  ',' + '0' +
                                 ',' + CurrToStr(_cSRindediario) + ',' + QuotedStr(DBAlias) +
                                 ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;
                end;
                if _cSJuvenil > 0 then
                begin
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodigoAg) +  ',' + '0' +
                                 ',' + CurrToStr(_cSJuvenil) + ',' + QuotedStr(DBAlias) +
                                 ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;
                end;
                if _cCRindediario > 0 then
                begin
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodigoAg) +  ',' + '0' +
                                 ',' + CurrToStr(_cCRindediario) + ',' + QuotedStr(DBAlias) +
                                 ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;
                end;
                if _cCJuvenil > 0 then
                begin
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodigoAg) +  ',' + '0' +
                                 ',' + CurrToStr(_cCJuvenil) + ',' + QuotedStr(DBAlias) +
                                 ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;
                end;
                if _cGmfBanco > 0 then
                begin
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodBanco) + ',' +
                                CurrToStr(_cGmfBanco) + ',' + '0' + ',' + QuotedStr(DBAlias) +
                                ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;
                 //
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodigoAg) +  ',' + '0' +
                                 ',' + CurrToStr(_cGmfBanco) + ',' + QuotedStr(DBAlias) +
                                 ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;
                end;
                if _cGmfComisionBanco > 0 then
                begin
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodBanco) + ',' +
                                CurrToStr(_cGmfComisionBanco) + ',' + '0' + ',' + QuotedStr(DBAlias) +
                                ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;
                 //
                 _tXml.Sentencia := 'insert into "tmp$contable" values( ' + QuotedStr(_sCodigoAg) +  ',' + '0' +
                                 ',' + CurrToStr(_cGmfComisionBanco) + ',' + QuotedStr(DBAlias) +
                                 ',' + QuotedStr(DateToStr(_dFechaDescarga)) + ',' + QuotedStr(_sDescripcionAg) + ')';
                 _tXml.CargarNodo;

                end;
                _tXml.Tipo := 'execute';
                _tXml.Sentencia := 'execute PROCEDURE TDB_COMPROBANTE';
                _tXml.CargarNodo;
               Astream := _tXml.CargarAstream;
               _sDesc := 'Ocaña';
               _tXml.AstreamEnt := EnviarXml(_iIdPuertoContable,_sIdHostContable,_sDesc,Astream);
               //Insertar Movimiento de Validación de la descarga
               _tData.InsertaDescarga(FieldByName('ID_AGENCIA').AsInteger,_dFechaDescarga);
              end;
            end; // Fin del valida descarga
           Next;
           end; // fin del while principal
        end; // fin del _tData.CodAgencia

        try
          if _sMensaje = '' then
          begin
            //MessageDlg('Proceso Culminado con Exito',mtInformation,[mbok],0);
            Memotxt.Lines.Add('Proceso Realizado con Exito con Fecha: ' + FormatDateTime('yy/mm/dd',fFechaActual));
          end
          else
          begin
            Memotxt.Lines.Add('Error de Comunicacion con la siguiente(s) oficinas: ' + _sMensaje + ' Con fecha: ' + FormatDateTime('yy/mm/dd',fFechaActual));
          end;
          Memotxt.Lines.SaveToFile('\\Archivos\publico\ClienteTDNew\LogTarjeta.txt');
        except
        end;

end;

function TFrmDescaraAutomatica.EnviarXml(_iIdPuerto: Integer; sIdHost,
  Desc: string; AstreamEnv: TMemoryStream): TMemoryStream;
var     Cadena :string;
        AStream : TMemoryStream;
        Tamano :Integer;
begin
        frmProgreso := TfrmProgreso.Create(self);
        frmProgreso.Titulo := 'Enviando Informacion de ' + Desc;
        frmProgreso.InfoLabel := 'Kbs Recibidos 0.2';
        with IdTCPClient1 do
        begin
          Port :=_iIdPuerto;
          Host := sIdHost;
          Application.ProcessMessages;
          Connect;
          if Connected then
          begin
            Application.ProcessMessages;
            frmProgreso.Position := 2;
            frmProgreso.Min := 0;
            frmProgreso.Ejecutar;
            Cadena := ReadLn();
            WriteInteger(AStreamEnv.Size);
            OpenWriteBuffer;
            WriteStream(AStreamEnv);
            CloseWriteBuffer;
            FreeAndNil(AStreamEnv);
            tamano := ReadInteger;
            AStream := TMemoryStream.Create;
            ReadStream(Astream,tamano,False);
            Disconnect;
            frmProgreso.Cerrar;
          end;
        end;
        Result := AStream;


end;

procedure TFrmDescaraAutomatica.UnZipArchiveItemProgress(Sender: TObject;
  Item: TAbArchiveItem; Progress: Byte; var Abort: Boolean);
  var
    AR:PArchivos;
begin
        New(AR);
        AR^.Nombre := FUnidad + Item.DiskFileName;
        ListaFile.Add(AR);
end;

procedure TFrmDescaraAutomatica.EdArchivoExternoChange(Sender: TObject);
var
        cadena :string;
begin
        if EdArchivoExterno.Text <> '' then
        begin
          EdArchivoExterno.ReadOnly := True;
          //EdFecha.Text := EdArchivoExterno.FileName;
          bitDescomprimir.Enabled := True;
          cadena := RightStr(EdArchivoExterno.Text,12);
          EdFormato.Text := 'Zip';
          EdConvenio.Text := '240';
          EdOperador.Text := 'Enpacto E.U';
//          EdFecha.Text := RightStr(EdFecha.Text,12);
//          EdFecha.Text := LeftStr(EdFecha.Text,8);
          Panel1.Enabled := False;
          FileName := EdArchivoExterno.FileName;
          _dFechaDescarga := EncodeDate(StrToInt(MidStr(cadena,5,4)),StrToInt(MidStr(cadena,3,2)),StrToInt(LeftStr(cadena,2)));
          EdFecha.Text := DateToStr(_dFechaDescarga);
        end;

end;

procedure TFrmDescaraAutomatica.bitSalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmDescaraAutomatica.bitCancelarClick(Sender: TObject);
begin
        EdMov.Text := '';
        EdConvenio.Text := '';
        EdArchivoExterno.ReadOnly := False;
        EdArchivoExterno.Text := '';
        EdFecha.Text := '';
        EdOperador.Text := '';
        EdFormato.Text := '';
        bitProcesar.Enabled := False;
        bitProcesar.Enabled := False;
        Panel1.Enabled := True;
        mLineas.Lines.Clear;
end;

procedure TFrmDescaraAutomatica.bitProcesarClick(Sender: TObject);
begin
        if MessageDlg('Esta Seguro(a) de realizar la Operación',mtWarning,[mbYes,MbNo],0) = Mrno then
           Exit;
        DBAlias := 'T.DEBITO';
        _tConexion := TConexion.Create;
        _tConexion.Conectar;
        _tData := TData.Create;
        _tData.Database := _tConexion.Database;
        ShortTimeFormat := 'HH:mm:ss';
        Procesar;
        Transferir;
        ShowMessage('Proceso Terminado...');
        _tConexion.Desconectar;
end;

procedure TFrmDescaraAutomatica.bitDescomprimirClick(Sender: TObject);
begin
        bitProcesar.Enabled := True;
        Descomprimir;       
end;

procedure TFrmDescaraAutomatica.Button2Click(Sender: TObject);
begin
        ShellExecute(Handle, 'open', 'notepad.exe', PChar(EdEst.Text), nil, SW_SHOWNORMAL);
end;

procedure TFrmDescaraAutomatica.Button3Click(Sender: TObject);
begin
        ShellExecute(Handle, 'open', 'notepad.exe', PChar(EdMov.Text), nil, SW_SHOWNORMAL);
end;

procedure TFrmDescaraAutomatica.Button4Click(Sender: TObject);
begin
        ShellExecute(Handle, 'open', 'notepad.exe', PChar(EdTar.Text), nil, SW_SHOWNORMAL);
end;

procedure TFrmDescaraAutomatica.Button5Click(Sender: TObject);
begin
        ShellExecute(Handle, 'open', 'notepad.exe', PChar(EdBlq.Text), nil, SW_SHOWNORMAL);
end;

end.
