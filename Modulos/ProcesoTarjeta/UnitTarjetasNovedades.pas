unit UnitTarjetasNovedades;

interface

uses
  ShellApi, Windows, Messages, DateUtils, StrUtils, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, DB, IBCustomDataSet,
  IBQuery,unitdmgeneral, IBSQL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, AbBase, AbBrowse,
  AbZBrows, AbZipper, AbMeter, IdMessage, UnitClaseXml, Grids, DBGrids,UnitClaseData,UnitConexion,
  DBClient;

type
  TfrmTarjetasNovedades = class(TForm)
    Panel1: TPanel;
    CmdProcesar: TBitBtn;
    CmdCerrar: TBitBtn;
    CmdVer: TBitBtn;
    CmdEnviar: TBitBtn;
    IBQTarjetas: TIBQuery;
    IBSQL1: TIBSQL;
    IdSMTP1: TIdSMTP;
    Msg: TIdMessage;
    IdTCPClient1: TIdTCPClient;
    CdAscii: TClientDataSet;
    CdAsciiNOVALIDO: TStringField;
    CdAsciiVALIDO: TStringField;
    procedure CmdCerrarClick(Sender: TObject);
    procedure CmdProcesarClick(Sender: TObject);
    procedure CmdEnviarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IdTCPClient1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdTCPClient1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdTCPClient1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
  private
    { Private declarations }
    function ObtenerTamanoArchivo(const FileName: string): Int64;
    procedure EnvioNovedad;
    function EnviarXml(_iIdPuerto: Integer; sIdHost, Desc: string;
      AstreamEnv: TMemoryStream): TMemoryStream;
  public
    { Public declarations }
  end;

var
  frmTarjetasNovedades: TfrmTarjetasNovedades;
  _tData :TData;
  _tConexion :TConexion;
  _bConexion :Boolean;
  _sMensaje :string;
  _tXml :TXml;
  _dFechaActual :TDate;
  _iLog :Integer;
implementation
uses IniFiles, UnitGlobalTd, UnitPantallaProgreso,Math;
{$R *.dfm}

procedure TfrmTarjetasNovedades.CmdCerrarClick(Sender: TObject);
begin
        Close;

end;

procedure TfrmTarjetasNovedades.CmdProcesarClick(Sender: TObject);
begin
        EnvioNovedad;
        Application.Terminate;
end;

function TfrmTarjetasNovedades.ObtenerTamanoArchivo(const FileName: string): Int64;
var
  SizeLow, SizeHigh: DWord;
  hFile: THandle;
begin
  Result := 0;
  hFile := FileOpen(FileName, fmOpenRead);
  try
    if hFile <> 0 then
    begin
      SizeLow := Windows.GetFileSize(hFile, @SizeHigh);
      Result := (SizeHigh shl 32) + SizeLow;
    end;
  finally
    FileClose(hFile);
  end;
end;


procedure TfrmTarjetasNovedades.CmdEnviarClick(Sender: TObject);
var Zip :TAbZipper;
    _sProceso :string;
begin

end;

procedure TfrmTarjetasNovedades.EnvioNovedad;
var Cadena:string;
    SaldoTotal,SaldoDisponible:Currency;
    ConteoAT,ConteoAC,ConteoATC,ConteoACT,ConteoTN:Integer;
    Tamano:Int64;
    LineaPedido:string;
    FechaSaldo:TDate;
    //VARIABLES PARA LA CONEXION
   _iIdAgencia :Integer;
   _iIdPuerto :Integer;
   _sIdHost :string;
   _sDescripcionAg :string;
   Astream1 :TMemoryStream;
   _sen :string;
   _cSaldoTotal,_cSaldoDisponible :Currency;
   _cSaldoDisp,_cSaldoTot :Currency;
   _iTotalReg :Integer;
   _sHoraInicio :string;
   _sHoraFin :string;
   _fArchivo :TextFile;
   _sTexto :string;
begin
       _sHoraInicio := DateToStr(Date)+ ':' + TimeToStr(Time);
       AssignFile(_farchivo,'d:\tarjeta\logA.log');
        _tXml.CrearXml;
        Astream1 := TMemoryStream.Create;
        Application.ProcessMessages;
        _tData.Sentencia := 'SELECT * FROM TDB$TARJETABIN';
        _tXml.Tipo := 'select';
        _tXml.Sentencia := 'SELECT * FROM TDB_NOVEDAD';
        _tXml.CargarNodo;
        Astream1 := _tXml.CargarAstream;
        with _tData.CodAgencia do
        begin
          while not Eof do
          begin
            _iIdAgencia := FieldByName('ID_AGENCIA').AsInteger;
            _iIdPuerto := FieldByName('ID_PUERTO').AsInteger;
            _sIdHost := FieldByName('ID_HOST').AsString;
            _sDescripcionAg := FieldByName('DESCRIPCION_AGENCIA').AsString;
//            try
              _tXml.AstreamEnt := EnviarXml(_iIdPuerto,_sIdHost,_sDescripcionAg,Astream1);
//            except
//              _sMensaje := _sMensaje + ' ' + _sDescripcionAg;
//            end;
            if _bConexion then
            begin
              _tXml.ListaConsulta := 'Consulta000';
               with _tXml.LeerXml do
               begin
                _iTotalReg := RecordCount;
                 if RecordCount > 0 then // VALIDACION PARA ELIMINAR SALDOS
                 begin
                    _tData.Sentencia := 'DELETE FROM TDB$SALDO WHERE ID_AGENCIA = '+ IntToStr(_iIdAgencia);
                    _tData.Query;
                 end;
                 while not Eof do
                 begin
                   if FieldByName('OPERACION').AsString = 'A' then
                   begin
                     _cSaldoDisp := SimpleRoundTo(FieldByName('DISPONIBLE').AsCurrency,0);
                     _cSaldoTot := SimpleRoundTo(FieldByName('SALDO').AsCurrency,0);
                     _tData.Sentencia :=  'INSERT INTO TDB$SALDO VALUES (' + QuotedStr(FieldByName('TARJETA').AsString)+ ',' +
                                         CurrToStr(_cSaldoDisp) + ',' + CurrToStr(_cSaldoTot) + ',' +
                                         QuotedStr(DateToStr(_dFechaActual)) + ',' + QuotedStr(TimeToStr(Time)) + ',' + inttostr(_iIdAgencia) + ')';
                     _tdata.Query;
                   end; //fin del valida operación
                   Next;
                 end;// fin del while del xml
               end;// fin del with del leerxml
            end;// finde ña conexión
             _sHoraFin := DateToStr(Date)+ ':' + TimeToStr(Time);
            _sTexto := 'Inicio: ' + _sHoraInicio + ' Fin: ' + _sHoraFin +  ' Registros: ' + IntToStr(_iTotalReg)+ ' Agencia: ' + _sDescripcionAg + ' Fin Registro *******';
           Next;
         end;// Fin del While Busca Agencias
        end;
        try
          system.Append(_fArchivo);
          system.Writeln(_fArchivo,_stexto);
          system.Flush(_fArchivo);
          system.CloseFile(_fArchivo);
        except
        end;

end;

procedure TfrmTarjetasNovedades.FormCreate(Sender: TObject);
var     MiINI :string;
begin
  MiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(MiINI) do
  try
    DBserver := ReadString('DBNAME','server','192.168.200.7');
    DBPath := ReadString('DBNAME','path','/home/');
    DBname := ReadString('DBNAME','name','coopservir.gdb');
    _iLog := ReadInteger('DBNAME','log',0);
  finally
    free;
  end;
       _tConexion := TConexion.Create;
        _tConexion.Conectar;
        _tData := TData.Create;
        _tData.Database := _tConexion.Database;
        _tXml := TXml.Create;
        _tData.Sentencia := 'SELECT FECHA FROM SP_FECHA_ACTUAL';
        _dFechaActual := _tData.SelectQuery.FieldByName('FECHA').AsDateTime;
        LLenaAscii(CdAscii);
        CmdProcesar.Click;
end;

function TfrmTarjetasNovedades.EnviarXml(_iIdPuerto: Integer; sIdHost, Desc: string; AstreamEnv: TMemoryStream): TMemoryStream;
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
              frmProgreso := TfrmProgreso.Create(self);
              frmProgreso.Titulo := 'Enviando Informacion de ' + Desc;
              frmProgreso.InfoLabel := 'Kbs Recibidos 0.2';
              Application.ProcessMessages;
              frmProgreso.Position := 2;
              frmProgreso.Min := 0;
              frmProgreso.Ejecutar;
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
              frmProgreso.Cerrar;
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

procedure TfrmTarjetasNovedades.IdTCPClient1Work(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
          frmProgreso.InfoLabel := 'Kbs Enviados : ' + CurrToStr(AWorkCount/1000);
          frmProgreso.Position := AWorkCount;
          Application.ProcessMessages;

end;

procedure TfrmTarjetasNovedades.IdTCPClient1WorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
          frmProgreso.Max := AWorkCountMax;
          frmProgreso.Min := 0;

end;

procedure TfrmTarjetasNovedades.IdTCPClient1WorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
        frmProgreso.Max := 0;
end;

end.
