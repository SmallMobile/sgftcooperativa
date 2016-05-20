unit UnitPosicionNeta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Mask, JvToolEdit, Buttons, ComCtrls,
  JvProgressBar, JvSpecialProgress, DBTables, JvMemTable, IBDatabase,
  pr_Common, pr_TxClasses,// FIBQuery, pFIBQuery, FIBDatabase, pFIBDatabase,
  IBCustomDataSet, IBQuery;

type TNombre = record
     PrimerApellido:string;
     SegundoApellido:string;
     Nombre:string;
end;

type
  TfrmPosicionNeta = class(TForm)
    CDSCaptacion: TClientDataSet;
    CDSColocacion: TClientDataSet;
    CDSAportes: TClientDataSet;
    CDSAportesTIPO_IDE: TStringField;
    CDSAportesNUMERO_IDE: TStringField;
    CDSAportesSALDO_APO: TCurrencyField;
    CDSCaptacionTIPO_IDE: TStringField;
    CDSCaptacionNUMERO_IDE: TStringField;
    CDSCaptacionSALDO: TCurrencyField;
    CDSColocacionNUMERO_IDE: TStringField;
    CDSColocacionSALDO_CAPITAL: TCurrencyField;
    Label1: TLabel;
    EdCaptacion: TJvFilenameEdit;
    Label2: TLabel;
    EdColocacion: TJvFilenameEdit;
    Label3: TLabel;
    EdAportes: TJvFilenameEdit;
    CmdProcesar: TBitBtn;
    CmdReporte: TBitBtn;
    CmdCerrar: TBitBtn;
    GroupBox1: TGroupBox;
    BarCaptacion: TJvProgressBar;
    BarColocacion: TJvProgressBar;
    BarAportes: TJvProgressBar;
    GroupBox2: TGroupBox;
    Bar: TJvSpecialProgress;
    Label4: TLabel;
    EdDocumentos: TJvFilenameEdit;
    CDSColocacionTIPO_IDE: TStringField;
    CDSDocumentos: TClientDataSet;
    CDSPosicion: TClientDataSet;
    CDSDocumentosNUMERO_IDE: TStringField;
    CDSPosicionNUMERO_IDE: TStringField;
    CDSPosicionCAPTACION: TCurrencyField;
    CDSPosicionCOLOCACION: TCurrencyField;
    CDSPosicionAPORTES: TCurrencyField;
    CDSPosicionPOSICION: TCurrencyField;
    CDSDocumentosTIPO_IDE: TStringField;
    GroupBox3: TGroupBox;
    Bar1: TJvSpecialProgress;
    CDSPosicionPRIMER_APELLIDO: TStringField;
    CDSPosicionSEGUNDO_APELLIDO: TStringField;
    CDSPosicionNOMBRE: TStringField;
    Reporte: TprTxReport;
    IBQuery1: TIBQuery;
    IBDatabase1: TIBDatabase;
    Transaction: TIBTransaction;
    procedure CmdCerrarClick(Sender: TObject);
    procedure CmdProcesarClick(Sender: TObject);
    procedure CmdReporteClick(Sender: TObject);
  private
    function BuscarCaptacion(Documento: String): Currency;
    function BuscarColocacion(Documento: String): Currency;
    function BuscarAportes(Documento: String): Currency;
    function BuscarNombre(Documento: String): TNombre;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPosicionNeta: TfrmPosicionNeta;

implementation

{$R *.dfm}

function TfrmPosicionNeta.BuscarAportes(Documento: String): Currency;
begin
        with CDSAportes do begin
            Open;
            First;        
            if Locate('NUMERO_IDE',Documento,[loCaseInsensitive]) then
              Result := FieldByName('SALDO_APO').AsCurrency
            else
              Result := 0;
            Close;
        end;
end;

function TfrmPosicionNeta.BuscarCaptacion(Documento: String): Currency;
begin
        with CDSCaptacion do begin
            Open;
            First;
            if Locate('NUMERO_IDE',Documento,[loCaseInsensitive]) then
              Result := FieldByName('SALDO').AsCurrency
            else
              Result := 0;
            Close;
        end;
end;

function TfrmPosicionNeta.BuscarColocacion(Documento: String): Currency;
begin
        with CDSColocacion do begin
            Open;
            First;
            if Locate('NUMERO_IDE',Documento,[loCaseInsensitive]) then
              Result := FieldByName('SALDO_CAPITAL').AsCurrency
            else
              Result := 0;
            Close;
        end;
end;

function TfrmPosicionNeta.BuscarNombre(Documento: String): TNombre;
begin
        IBDatabase1.Open;

        if Transaction.InTransaction then
           Transaction.Commit;
        Transaction.StartTransaction;

        with IBQuery1 do begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT PRIMER_APELLIDO,SEGUNDO_APELLIDO,NOMBRE from "gen$persona"');
          SQL.Add('WHERE ID_PERSONA = :ID_PERSONA');
          ParamByName('ID_PERSONA').AsString := Documento;
          try
           Open;
           if RecordCount > 0 then begin
             Result.PrimerApellido := FieldByName('PRIMER_APELLIDO').AsString;
             Result.SegundoApellido := FieldByName('SEGUNDO_APELLIDO').AsString;
             Result.Nombre := FieldByName('NOMBRE').AsString;
           end
           else
           begin
             Result.PrimerApellido := 'NO REGISTRO';
             Result.SegundoApellido := 'NO REGISTRO';
             Result.Nombre := 'NO REGISTRO';
           end;
           Transaction.Commit;
          except
             Transaction.Rollback;
             raise;
          end;
        end;

        IBDatabase1.Close;
end;

procedure TfrmPosicionNeta.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmPosicionNeta.CmdProcesarClick(Sender: TObject);
var
    i:Integer;
   S1:TStringList;
   S2:TStringList;
   Conteo:Integer;
   Captacion:Currency;
   Colocacion:Currency;
   Aportes:Currency;
   Nombre:TNombre;
   Identificacion:string;
begin
        CmdReporte.Enabled := False;
        CmdCerrar.Enabled := False;


        S1 := TStringList.Create;
        S2 := TStringList.Create;
        S1.LoadFromFile(EdCaptacion.FileName);
        BarCaptacion.Min := 0;
        BarCaptacion.Max := S1.Count;
        BarCaptacion.Position := 0;
        for i := 0 to S1.Count - 1 do begin
          BarCaptacion.Position := i;
          Application.ProcessMessages;
          S2.Text := StringReplace(S1[i],#9,#13,[rfReplaceAll]);
          with CDSCaptacion do begin
            Open;
            First;
            if Locate('NUMERO_IDE',S2.Strings[1],[loCaseInsensitive]) then
            begin
              Edit;
              FieldByName('SALDO').AsCurrency := FieldByName('SALDO').AsCurrency + StrToCurr(S2.Strings[14]);
              Post;
            end
            else
            begin
              Append;
              FieldByName('TIPO_IDE').AsString := S2.Strings[0];
              FieldByName('NUMERO_IDE').AsString := S2.Strings[1];
              FieldByName('SALDO').AsCurrency := StrToCurr(S2.Strings[14]);
              Post;
            end;
            Close;
          end;
        end;

        S1.Free;
        S2.Free;

        S1 := TStringList.Create;
        S2 := TStringList.Create;
        S1.LoadFromFile(EdColocacion.FileName);
        BarColocacion.Min := 0;
        BarColocacion.Max := S1.Count;
        BarColocacion.Position := 0;
        for i := 0 to S1.Count - 1 do begin
          BarColocacion.Position := i;
          Application.ProcessMessages;
          S2.Text := StringReplace(S1[i],#9,#13,[rfReplaceAll]);
          with CDSColocacion do begin
            Open;
            First;
            if Locate('NUMERO_IDE',S2.Strings[1],[loCaseInsensitive]) then
            begin
              Edit;
              FieldByName('SALDO_CAPITAL').AsCurrency := FieldByName('SALDO_CAPITAL').AsCurrency + StrToCurr(S2.Strings[17]);
              Post;
            end
            else
            begin
              Append;
              FieldByName('TIPO_IDE').AsString := S2.Strings[0];
              FieldByName('NUMERO_IDE').AsString := S2.Strings[1];
              FieldByName('SALDO_CAPITAL').AsCurrency := StrToCurr(S2.Strings[17]);
              Post;
            end;
            Close;
          end;
        end;

        S1.Free;
        S2.Free;

        S1 := TStringList.Create;
        S2 := TStringList.Create;
        S1.LoadFromFile(EdAportes.FileName);
        BarAportes.Min := 0;
        BarAportes.Max := S1.Count;
        BarAportes.Position := 0;
        for i := 0 to S1.Count - 1 do begin
          BarAportes.Position := i;
          Application.ProcessMessages;
          S2.Text := StringReplace(S1[i],#9,#13,[rfReplaceAll]);
          with CDSAportes do begin
            Open;
            First;
            if Locate('NUMERO_IDE',S2.Strings[1],[loCaseInsensitive]) then
            begin
              Edit;
              FieldByName('SALDO_APO').AsCurrency := FieldByName('SALDO_APO').AsCurrency + StrToCurr(S2.Strings[3]);
              Post;
            end
            else
            begin
              Append;
              FieldByName('TIPO_IDE').AsString := S2.Strings[0];
              FieldByName('NUMERO_IDE').AsString := S2.Strings[1];
              FieldByName('SALDO_APO').AsCurrency := StrToCurr(S2.Strings[3]);
              Post;
            end;
            Close;
          end;
        end;

        S1.Free;
        S2.Free;

        S1 := TStringList.Create;
        S2 := TStringList.Create;
        S1.LoadFromFile(EdDocumentos.FileName);
        for i := 0 to S1.Count - 1 do begin
          Application.ProcessMessages;
          S2.Text := StringReplace(S1[i],#9,#13,[rfReplaceAll]);
          with CDSDocumentos do begin
            Open;
            Append;
            FieldByName('TIPO_IDE').AsString := S2.Strings[0];
            FieldByName('NUMERO_IDE').AsString := S2.Strings[1];
            Post;
            Close;
          end;
        end;

        S1.Free;
        S2.Free;

        with CDSDocumentos do begin
          Open;
          Last;
          First;
          Conteo := RecordCount;
          Bar.Minimum := 0;
          Bar.Maximum := Conteo;
          Bar.Position := 0;
          while not Eof do begin
              Bar.Position := RecNo;
              Application.ProcessMessages;
              Captacion := BuscarCaptacion(FieldByName('NUMERO_IDE').AsString);
              Colocacion := buscarcolocacion(FieldByName('NUMERO_IDE').AsString);
              Aportes := buscaraportes(FieldByName('NUMERO_IDE').AsString);
              CDSPosicion.Open;

{              if CDSPosicion.Locate('NUMERO_IDE',FieldByName('NUMERO_IDE').AsString,[loCaseInsensitive]) then begin
                CDSPosicion.Edit;
                CDSPosicion.FieldByName('COLOCACION').AsCurrency := CDSPosicion.FieldByName('COLOCACION').AsCurrency + Colocacion;
                CDSPosicion.FieldByName('CAPTACION').AsCurrency := CDSPosicion.FieldByName('CAPTACION').AsCurrency + Captacion;
                CDSPosicion.FieldByName('APORTES').AsCurrency := CDSPosicion.FieldByName('APORTES').AsCurrency + Aportes;
                CDSPosicion.Post;
              end
              else
              begin }
               CDSPosicion.Append;
               CDSPosicion.FieldByName('NUMERO_IDE').AsString := FieldByName('NUMERO_IDE').AsString;
               CDSPosicion.FieldByName('POSICION').AsCurrency := 0;
               CDSPosicion.FieldByName('COLOCACION').AsCurrency := Colocacion;
               CDSPosicion.FieldByName('CAPTACION').AsCurrency := Captacion;
               CDSPosicion.FieldByName('APORTES').AsCurrency := Aportes;
               CDSPosicion.FieldByName('PRIMER_APELLIDO').AsString := '';
               CDSPosicion.FieldByName('SEGUNDO_APELLIDO').AsString := '';
               CDSPosicion.FieldByName('NOMBRE').AsString;
               CDSPosicion.Post;
//              end;
              CDSPosicion.Close;
              Next;
          end;
        end;

        with CDSPosicion do begin
          Open;
          Last;
          First;
          Bar1.Minimum := 0;
          Bar1.Maximum := RecordCount;
          Bar1.Position := 0;
          while not Eof do begin
             Bar1.Position := RecNo;
             Application.ProcessMessages;
             Edit;
             Identificacion := FieldByName('NUMERO_IDE').AsString;
             Nombre := BuscarNombre(Identificacion);
             FieldByName('POSICION').AsCurrency := FieldByName('CAPTACION').AsCurrency - FieldByName('COLOCACION').AsCurrency;
             FieldByName('PRIMER_APELLIDO').AsString := Nombre.PrimerApellido;
             FieldByName('SEGUNDO_APELLIDO').AsString := Nombre.SegundoApellido;
             FieldByName('NOMBRE').AsString := Nombre.Nombre;
             Post;
             Next;
          end;
        end;

        CmdReporte.Enabled := True;
        CmdCerrar.Enabled := True;
        Application.ProcessMessages;
        
end;

procedure TfrmPosicionNeta.CmdReporteClick(Sender: TObject);
begin
        CDSPosicion.Open;
        CDSPosicion.Last;
        if Reporte.PrepareReport then
           Reporte.PreviewPreparedReport(True);
end;

end.
