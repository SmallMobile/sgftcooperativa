unit UnitConfrontar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IBCustomDataSet, IBQuery, DB, DBClient, StdCtrls, Buttons,
  Grids, DBGrids, IBDatabase, ExtCtrls, ComCtrls, IBSQL, FR_Class, FR_DSet,
  FR_DBSet, FR_Desgn, Provider, frRtfExp, frOLEExl {scExcelExport,scExcelExport,DataSetToExcel};

type
  TfrmConfrontar = class(TForm)
    CDResult: TClientDataSet;
    CDResultID_AGENCIA: TSmallintField;
    CDResultID_COLOCACION: TStringField;
    CDResultID_EDAD: TStringField;
    CDResultNOMBRE: TStringField;
    CDResultDEUDA: TCurrencyField;
    CDResultID_ARRASTRE: TStringField;
    CDResultBAJA : TBooleanField;
    CDResultSUBE: TBooleanField;
    CDResultMANTIENE: TBooleanField;
    CDResultSALDADO: TBooleanField;
    IBQMarzo: TIBQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    IBTransaction1: TIBTransaction;
    IBDatabase1: TIBDatabase;
    Panel1: TPanel;
    btnConfrontar: TBitBtn;
    Bar1: TProgressBar;
    IBSQL1: TIBSQL;
    btnCerrar: TBitBtn;
    IBDatabase2: TIBDatabase;
    IBDatabase3: TIBDatabase;
    Bar2: TProgressBar;
    Status: TStatusBar;
    CDAbonos: TClientDataSet;
    CDAbonosID_AGENCIA: TSmallintField;
    CDAbonosID_COLOCACION: TStringField;
    CDAbonosFECHA: TDateField;
    CDAbonosVALOR_CAPITAL: TCurrencyField;
    CDAbonosRECIBO: TIntegerField;
    IBTransaction2: TIBTransaction;
    IBTransaction3: TIBTransaction;
    frReport1: TfrReport;
    ColocacionesDS: TfrDBDataSet;
    AbonosDS: TfrDBDataSet;
    DSResult: TDataSource;
    DSAbonos: TDataSource;
    frDesigner1: TfrDesigner;
    frOLEExcelExport1: TfrOLEExcelExport;
    frRtfAdvExport1: TfrRtfAdvExport;
    CDResultDEUDAJ: TCurrencyField;
    CdCreditos: TClientDataSet;
    CdCreditosID_AGENCIA: TSmallintField;
    CdCreditosID_COLOCACION: TStringField;
    CdCreditosNOMBRE: TStringField;
    CdCreditosVARIACION: TCurrencyField;
    IBdespues: TIBQuery;
    IBantes: TIBQuery;
    IBQuery1: TIBQuery;
    IBvalida: TIBQuery;
    frDBDataSet1: TfrDBDataSet;
    DScreditos: TDataSource;
    CdCreditosCLASIFICACION: TStringField;
    CdExel: TClientDataSet;
    CdExelCAMPO1: TStringField;
    CdExelCAMPO2: TStringField;
    CdExelCAMPO3: TStringField;
    CdExelCAMPO4: TStringField;
    CdExelCAMPO5: TStringField;
    CdExelCAMPO6: TStringField;
    DSexel: TDataSource;
    BitBtn1: TBitBtn;
    SDdialogo: TSaveDialog;
    Fecha1: TDateTimePicker;
    Fecha2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
//    scExcelExport1: TscExcelExport;
    procedure btnCerrarClick(Sender: TObject);
    procedure btnConfrontarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    { Private declarations }
    procedure Procesar1;
    procedure Procesar2;
    procedure Procesar3;
    procedure procesara;
    procedure procesarc;
    {procedure ChangeCellColors(Sender: TObject; Field: TField;
      var ColorBackground: TColor; FontCell: TxlFont);}
  public
    { Public declarations }
  end;

var
  frmConfrontar: TfrmConfrontar;

implementation

{$R *.dfm}

procedure TfrmConfrontar.Procesar1;
var    Fantes,Fdespues :TDate;
       i,b :Integer;
       vDirerencia :Currency;
begin
        with IBDatabase1 do begin
          Status.Panels[1].Text := 'Intentando Conexión con Database Ocaña';
          Application.ProcessMessages;
          DatabaseName := '192.168.200.254:/dbase/coodin/coodin3006.fdb';
          Params.Clear;
          Params.Add('user_name=SYSDBA');
          Params.Add('password=masterkey');
          //Params.Add('sql_role_name=CARTERA');
          //Params.Add('lc_ctype=ISO8859_1');
          try
           Open;
          except
           raise;
           Exit;
          end;
        end;
        with IBTransaction1 do begin
          StartTransaction;
        end;
         with IBQuery1 do
         begin
           Close;
           Open;
           Last;
           First;
           Bar1.Min := 0;
           Bar1.Max := RecordCount;
           Bar1.Position := 0;
           while not Eof do
           begin
             Bar1.Position := RecNo;
             Application.ProcessMessages;
             IBvalida.Close;
             IBvalida.ParamByName('FECHA_INICIO').AsDate := EncodeDate(2005,12,30);
             IBvalida.ParamByName('FECHA_FIN').AsDate := EncodeDate(2006,03,30);
             IBvalida.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
             IBvalida.ParamByName('ID_AGENCIA').AsInteger := 1;
             IBvalida.Open;
             IBvalida.Last;
             b := IBvalida.RecordCount;
             if b > 0 then
             begin
              vDirerencia := 0;
              //Fantes := EncodeDate(2005,12,30);
              for i := 0 to 0  do// (b - 2) do
              begin
                {Fdespues := IncMonth(Fantes,1);
                if i = 0 then
                   Fdespues := EncodeDate(2006,01,31);
                if i = 1 then
                   Fdespues := EncodeDate(2005,02,28);
                if i = 2 then
                    Fdespues := EncodeDate(2005,03,30);}
                Fdespues := Fecha2.Date;
                Fantes := Fecha1.Date;
                IBantes.Close;
                IBantes.ParamByName('FECHA_CORTE').AsDate := Fantes;
                IBantes.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                IBantes.ParamByName('ID_AGENCIA').AsInteger := 1;
                IBantes.Open;
                IBdespues.Close;
                IBdespues.ParamByName('FECHA_CORTE').AsDate := Fdespues;
                IBdespues.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                IBdespues.ParamByName('ID_AGENCIA').AsInteger := 1;
                IBdespues.Open;
                IF IBdespues.FieldByName('PCAPITAL').AsString <> '' then
                if IBdespues.FieldByName('PCAPITAL').AsCurrency < IBantes.FieldByName('PCAPITAL').AsCurrency then
                   vDirerencia := vDirerencia + (IBantes.FieldByName('PCAPITAL').AsCurrency  - IBdespues.FieldByName('PCAPITAL').AsCurrency);
                Fantes := Fdespues;
              end;
                if vDirerencia > 0 then
                begin
                  CdCreditos.Append;
                  CdCreditos.FieldValues['ID_AGENCIA'] := 1;
                  CdCreditos.FieldValues['ID_COLOCACION'] := FieldByName('ID_COLOCACION').AsString;
                  CdCreditos.FieldValues['NOMBRE'] := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
                  CdCreditos.FieldValues['VARIACION'] := vDirerencia;
                  CdCreditos.FieldValues['CLASIFICACION'] := FieldByName('DESCRIPCION_CLASIFICACION').AsString;
                  CdCreditos.Post;
                  IBSQL1.Close;
                  IBSQL1.SQL.Clear;
                  IBSQL1.SQL.Add('select * from "col$extracto" where');
                  IBSQL1.SQL.Add('ID_AGENCIA = :ID_AGENCIA and ID_COLOCACION = :ID_COLOCACION and');
                  IBSQL1.SQL.Add('FECHA_EXTRACTO BETWEEN :FECHA1 and :FECHA2 and ABONO_CAPITAL <> 0');
                  IBSQL1.SQL.Add('ORDER BY FECHA_EXTRACTO,ID_CBTE_COLOCACION');
                  IBSQL1.ParamByName('FECHA1').AsDate := EncodeDate(2006,02,01);
                  IBSQL1.ParamByName('FECHA2').AsDate := EncodeDate(2006,02,28);
                  IBSQL1.ParamByName('ID_AGENCIA').AsInteger := 1;
                  IBSQL1.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                  IBSQL1.ExecQuery;
                  while not IBSQL1.Eof do
                  begin
                     CDAbonos.Open;
                     CDAbonos.Append;
                     CDAbonos.FieldByName('ID_AGENCIA').AsInteger := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
                     CDAbonos.FieldByName('ID_COLOCACION').AsString := IBSQL1.FieldByName('ID_COLOCACION').AsString;
                     CDAbonos.FieldByName('FECHA').AsDateTime := IBSQL1.FieldByName('FECHA_EXTRACTO').AsDate;
                     CDAbonos.FieldByName('VALOR_CAPITAL').AsCurrency := IBSQL1.FieldByName('ABONO_CAPITAL').AsCurrency;
                     CDAbonos.FieldByName('RECIBO').AsInteger := IBSQL1.FieldByName('ID_CBTE_COLOCACION').AsInteger;
                     CDAbonos.Post;
                     IBSQL1.Next;
                  end;

                end;
             end;// FIN DEL VALIDA
             Next;

           end;// FIN DEL PRIMER WHILE
         end;
{        IBQMarzo.Database := IBDatabase1;

        IBQMarzo.Open;
        IBQMarzo.Last;
        IBQMarzo.First;
        Bar1.Min := 0;
        Bar1.Max := IBQMarzo.RecordCount;
        Bar1.Position := 0;
        IBSQL1.SQL.Clear;
        IBSQL1.SQL.Add('SELECT ');
        IBSQL1.SQL.Add('  "col$causaciones".ID_AGENCIA,');
        IBSQL1.SQL.Add('  "col$causaciones".ID_COLOCACION,');
        IBSQL1.SQL.Add('  "col$causaciones".ID_ARRASTRE,');
        IBSQL1.SQL.Add('  "gen$persona".PRIMER_APELLIDO || '' '' || "gen$persona".SEGUNDO_APELLIDO || '' '' || "gen$persona".NOMBRE AS NOMBRE,');
        IBSQL1.SQL.Add('  "col$causaciones".DEUDA');
        IBSQL1.SQL.Add('FROM');
        IBSQL1.SQL.Add(' "col$causaciones"');
        IBSQL1.SQL.Add(' INNER JOIN "gen$persona" ON ("col$causaciones".ID_IDENTIFICACION="gen$persona".ID_IDENTIFICACION)');
        IBSQL1.SQL.Add('  AND ("col$causaciones".ID_PERSONA="gen$persona".ID_PERSONA)');
        IBSQL1.SQL.Add('WHERE');
        IBSQL1.SQL.Add('  ("col$causaciones".ID_AGENCIA = :ID_AGENCIA) AND ');
        IBSQL1.SQL.Add('  ("col$causaciones".ID_COLOCACION = :ID_COLOCACION) AND ');
        IBSQL1.SQL.Add('  ("col$causaciones".FECHA_CORTE = :FECHA_CORTE)');
        IBSQL1.ParamByName('FECHA_CORTE').AsDate := EncodeDate(2005,12,30);

        with IBQMarzo do begin
         CDResult.Open;
         Status.Panels[1].Text := 'Confrontando Colocaciones Septiembre - Diciembre Oficina Ocaña';

         while not Eof do begin
          Bar1.Position := RecNo;
          Application.ProcessMessages;
          IBSQL1.Close;
          IBSQL1.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
          IBSQL1.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
          CDResult.Append;
          CDResult.FieldByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
          CDResult.FieldByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
          CDResult.FieldByName('ID_EDAD').AsString := FieldByName('ID_ARRASTRE').AsString;
          CDResult.FieldByName('NOMBRE').AsString := FieldByName('NOMBRE').AsString;
          CDResult.FieldByName('DEUDA').AsCurrency := FieldByName('DEUDA').AsCurrency;
          try
           IBSQL1.ExecQuery;
           if IBSQL1.RecordCount > 0 then
           begin
             CDResult.FieldByName('ID_ARRASTRE').AsString := IBSQL1.fieldbyname('ID_ARRASTRE').AsString;
             CDResult.FieldByName('DEUDAJ').AsCurrency := IBSQL1.FieldByName('DEUDA').AsCurrency;
             if IBSQL1.FieldByName('ID_ARRASTRE').AsString < FieldByName('ID_ARRASTRE').AsString then
             begin
                CDResult.FieldByName('BAJA').AsBoolean := True;
                CDResult.FieldByName('SUBE').AsBoolean := False;
                CDResult.FieldByName('MANTIENE').AsBoolean := False;
                CDResult.FieldByName('SALDADO').AsBoolean := False;
             end
             else
             if IBSQL1.FieldByName('ID_ARRASTRE').AsString > FieldByName('ID_ARRASTRE').AsString then
             begin
                CDResult.FieldByName('BAJA').AsBoolean := False;
                CDResult.FieldByName('SUBE').AsBoolean := True;
                CDResult.FieldByName('MANTIENE').AsBoolean := False;
                CDResult.FieldByName('SALDADO').AsBoolean := False;
             end
             else
             begin
                CDResult.FieldByName('BAJA').AsBoolean := False;
                CDResult.FieldByName('SUBE').AsBoolean := False;
                CDResult.FieldByName('MANTIENE').AsBoolean := True;
                CDResult.FieldByName('SALDADO').AsBoolean := False;
             end;
           end
           else
           begin
               CDResult.FieldByName('ID_ARRASTRE').AsString := ' ';
               CDResult.FieldByName('BAJA').AsBoolean := False;
               CDResult.FieldByName('SUBE').AsBoolean := False;
               CDResult.FieldByName('MANTIENE').AsBoolean := False;
               CDResult.FieldByName('SALDADO').AsBoolean := True;
               CDResult.FieldByName('DEUDAJ').AsCurrency := 0;
           end;
          except
           Transaction.Rollback;
           raise;
           Exit;
          end;
          Next;
         end; // fin del while
        end; // fin del with

        IBQMarzo.Close;}

        {with CDResult do
        begin
          First;
          Bar2.Min := 0;
          Bar2.Max := RecordCount;
          Bar2.Position := 0;
          IBSQL1.Close;
          IBSQL1.SQL.Clear;
          IBSQL1.SQL.Add('select * from "col$extracto" where');
          IBSQL1.SQL.Add('ID_AGENCIA = :ID_AGENCIA and ID_COLOCACION = :ID_COLOCACION and');
          IBSQL1.SQL.Add('FECHA_EXTRACTO BETWEEN :FECHA1 and :FECHA2 and ABONO_CAPITAL <> 0');
          IBSQL1.SQL.Add('ORDER BY FECHA_EXTRACTO,ID_CBTE_COLOCACION');
          IBSQL1.ParamByName('FECHA1').AsDate := EncodeDate(2005,10,01);
          IBSQL1.ParamByName('FECHA2').AsDate := EncodeDate(2005,12,30);
          while not Eof do begin
           Bar2.Position := RecNo;
           Application.ProcessMessages;
           IBSQL1.Close;
           IBSQL1.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
           IBSQL1.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
           try
            IBSQL1.ExecQuery;
            while not IBSQL1.Eof do
            begin
               CDAbonos.Open;
               CDAbonos.Append;
               CDAbonos.FieldByName('ID_AGENCIA').AsInteger := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
               CDAbonos.FieldByName('ID_COLOCACION').AsString := IBSQL1.FieldByName('ID_COLOCACION').AsString;
               CDAbonos.FieldByName('FECHA').AsDateTime := IBSQL1.FieldByName('FECHA_EXTRACTO').AsDate;
               CDAbonos.FieldByName('VALOR_CAPITAL').AsCurrency := IBSQL1.FieldByName('ABONO_CAPITAL').AsCurrency;
               CDAbonos.FieldByName('RECIBO').AsInteger := IBSQL1.FieldByName('ID_CBTE_COLOCACION').AsInteger;
               CDAbonos.Post;
               CDAbonos.Close;
               IBSQL1.Next;
            end;
           except
            IBSQL1.Transaction.Rollback;
            raise;
            Exit;
           end;
           Next;
          end; // fin del while
        end; // fin del with
        IBDatabase1.Close;}
end;

procedure TfrmConfrontar.Procesar2;
begin
        Bar1.Position := 0;
        Bar2.Position := 0;
        IBSQL1.Database := IBDatabase2;
        IBSQL1.Transaction := IBTransaction2;

        with IBDatabase2 do begin
          Status.Panels[1].Text := 'Intentando Conexión con Database Abrego';
          Application.ProcessMessages;
          DatabaseName := '192.168.201.2:/var/db/fbird/database.fdb';
          Params.Clear;
          Params.Add('user_name=ADMDOR');
          Params.Add('password=nino2001');
          Params.Add('sql_role_name=CARTERA');
          Params.Add('lc_ctype=ISO8859_1');
          try
           Open;
          except
           raise;
           Exit;
          end;
        end;


        with IBTransaction2 do begin
          StartTransaction;
        end;

        IBQMarzo.Database := IBDatabase2;
        IBQMarzo.Transaction := IBTransaction2;

        IBQMarzo.Open;
        IBQMarzo.Last;
        IBQMarzo.First;
        Bar1.Min := 0;
        Bar1.Max := IBQMarzo.RecordCount;
        Bar1.Position := 0;
        IBSQL1.Close;
        IBSQL1.SQL.Clear;
        IBSQL1.SQL.Add('SELECT ');
        IBSQL1.SQL.Add('  "col$causaciones".ID_AGENCIA,');
        IBSQL1.SQL.Add('  "col$causaciones".ID_COLOCACION,');
        IBSQL1.SQL.Add('  "col$causaciones".ID_ARRASTRE,');
        IBSQL1.SQL.Add('  "gen$persona".PRIMER_APELLIDO || '' '' || "gen$persona".SEGUNDO_APELLIDO || '' '' || "gen$persona".NOMBRE AS NOMBRE,');
        IBSQL1.SQL.Add('  "col$causaciones".DEUDA');
        IBSQL1.SQL.Add('FROM');
        IBSQL1.SQL.Add(' "col$causaciones"');
        IBSQL1.SQL.Add(' INNER JOIN "gen$persona" ON ("col$causaciones".ID_IDENTIFICACION="gen$persona".ID_IDENTIFICACION)');
        IBSQL1.SQL.Add('  AND ("col$causaciones".ID_PERSONA="gen$persona".ID_PERSONA)');
        IBSQL1.SQL.Add('WHERE');
        IBSQL1.SQL.Add('  ("col$causaciones".ID_AGENCIA = :ID_AGENCIA) AND ');
        IBSQL1.SQL.Add('  ("col$causaciones".ID_COLOCACION = :ID_COLOCACION) AND ');
        IBSQL1.SQL.Add('  ("col$causaciones".FECHA_CORTE = :FECHA_CORTE)');
        IBSQL1.ParamByName('FECHA_CORTE').AsDate := EncodeDate(2005,12,30);

        with IBQMarzo do begin
         CDResult.Open;
         Status.Panels[1].Text := 'Confrontando Colocaciones Septiembre - Diciembre Oficina Abrego';

         while not Eof do begin
          Bar1.Position := RecNo;
          Application.ProcessMessages;
          IBSQL1.Close;
          IBSQL1.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
          IBSQL1.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
          CDResult.Append;
          CDResult.FieldByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
          CDResult.FieldByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
          CDResult.FieldByName('ID_EDAD').AsString := FieldByName('ID_ARRASTRE').AsString;
          CDResult.FieldByName('NOMBRE').AsString := FieldByName('NOMBRE').AsString;
          CDResult.FieldByName('DEUDA').AsCurrency := FieldByName('DEUDA').AsCurrency;
          try
           IBSQL1.ExecQuery;
           if IBSQL1.RecordCount > 0 then
           begin
             CDResult.FieldByName('ID_ARRASTRE').AsString := IBSQL1.fieldbyname('ID_ARRASTRE').AsString;
             CDResult.FieldByName('DEUDAJ').AsCurrency := IBSQL1.FieldByName('DEUDA').AsCurrency;
             if IBSQL1.FieldByName('ID_ARRASTRE').AsString < FieldByName('ID_ARRASTRE').AsString then
             begin
                CDResult.FieldByName('BAJA').AsBoolean := True;
                CDResult.FieldByName('SUBE').AsBoolean := False;
                CDResult.FieldByName('MANTIENE').AsBoolean := False;
                CDResult.FieldByName('SALDADO').AsBoolean := False;
             end
             else
             if IBSQL1.FieldByName('ID_ARRASTRE').AsString > FieldByName('ID_ARRASTRE').AsString then
             begin
                CDResult.FieldByName('BAJA').AsBoolean := False;
                CDResult.FieldByName('SUBE').AsBoolean := True;
                CDResult.FieldByName('MANTIENE').AsBoolean := False;
                CDResult.FieldByName('SALDADO').AsBoolean := False;
             end
             else
             begin
                CDResult.FieldByName('BAJA').AsBoolean := False;
                CDResult.FieldByName('SUBE').AsBoolean := False;
                CDResult.FieldByName('MANTIENE').AsBoolean := True;
                CDResult.FieldByName('SALDADO').AsBoolean := False;
             end;
           end
           else
           begin
               CDResult.FieldByName('ID_ARRASTRE').AsString := ' ';
               CDResult.FieldByName('BAJA').AsBoolean := False;
               CDResult.FieldByName('SUBE').AsBoolean := False;
               CDResult.FieldByName('MANTIENE').AsBoolean := False;
               CDResult.FieldByName('SALDADO').AsBoolean := True;
               CDResult.FieldByName('DEUDAJ').AsCurrency := 0;
           end;
          except
           Transaction.Rollback;
           raise;
           Exit;
          end;
          Next;
         end; // fin del while
        end; // fin del with

        IBQMarzo.Close;
        
        with CDResult do
        begin
          Filter := 'ID_AGENCIA = 2';
          Filtered := True;
          First;
          Bar2.Min := 0;
          Bar2.Max := RecordCount;
          Bar2.Position := 0;
          IBSQL1.Close;
          IBSQL1.SQL.Clear;
          IBSQL1.SQL.Add('select * from "col$extracto" where');
          IBSQL1.SQL.Add('ID_AGENCIA = :ID_AGENCIA and ID_COLOCACION = :ID_COLOCACION and');
          IBSQL1.SQL.Add('FECHA_EXTRACTO BETWEEN :FECHA1 and :FECHA2 and ABONO_CAPITAL <> 0');
          IBSQL1.SQL.Add('ORDER BY FECHA_EXTRACTO,ID_CBTE_COLOCACION');
          IBSQL1.ParamByName('FECHA1').AsDate := EncodeDate(2005,10,01);
          IBSQL1.ParamByName('FECHA2').AsDate := EncodeDate(2005,12,30);
          while not Eof do begin
           Bar2.Position := RecNo;
           Application.ProcessMessages;
           IBSQL1.Close;
           IBSQL1.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
           IBSQL1.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
           try
            IBSQL1.ExecQuery;
            while not IBSQL1.Eof do
            begin
               CDAbonos.Open;
               CDAbonos.Append;
               CDAbonos.FieldByName('ID_AGENCIA').AsInteger := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
               CDAbonos.FieldByName('ID_COLOCACION').AsString := IBSQL1.FieldByName('ID_COLOCACION').AsString;
               CDAbonos.FieldByName('FECHA').AsDateTime := IBSQL1.FieldByName('FECHA_EXTRACTO').AsDate;
               CDAbonos.FieldByName('VALOR_CAPITAL').AsCurrency := IBSQL1.FieldByName('ABONO_CAPITAL').AsCurrency;
               CDAbonos.FieldByName('RECIBO').AsInteger := IBSQL1.FieldByName('ID_CBTE_COLOCACION').AsInteger;
               CDAbonos.Post;
               CDAbonos.Close;
               IBSQL1.Next;
            end;// fin del while ibsql1
           except
            IBSQL1.Transaction.Rollback;
            raise;
            Exit;
           end;
           Next;
          end; // fin del while
        end; // fin del with

        IBDatabase2.Close;

end;

procedure TfrmConfrontar.Procesar3;
begin
        Bar1.Position := 0;
        Bar2.Position := 0;

        IBSQL1.Database := IBDatabase3;
        IBSQL1.Transaction := IBTransaction3;

        with IBDatabase3 do begin
          Status.Panels[1].Text := 'Intentando Conexión con Database Convención';
          Application.ProcessMessages;
          DatabaseName := '192.168.202.2:/var/db/fbird/database.fdb';
          Params.Clear;
          Params.Add('user_name=ADMDOR');
          Params.Add('password=nino2001');
          Params.Add('sql_role_name=CARTERA');
          Params.Add('lc_ctype=ISO8859_1');
          try
           Open;
          except
           raise;
           Exit;
          end;
        end;


        with IBTransaction3 do begin
          StartTransaction;
        end;

        IBQMarzo.Database := IBDatabase3;
        IBQMarzo.Transaction := IBTransaction3;

        IBQMarzo.Open;
        IBQMarzo.Last;
        IBQMarzo.First;
        Bar1.Min := 0;
        Bar1.Max := IBQMarzo.RecordCount;
        Bar1.Position := 0;
        IBSQL1.Close;
        IBSQL1.SQL.Clear;
        IBSQL1.SQL.Add('SELECT ');
        IBSQL1.SQL.Add('  "col$causaciones".ID_AGENCIA,');
        IBSQL1.SQL.Add('  "col$causaciones".ID_COLOCACION,');
        IBSQL1.SQL.Add('  "col$causaciones".ID_ARRASTRE,');
        IBSQL1.SQL.Add('  "gen$persona".PRIMER_APELLIDO || '' '' || "gen$persona".SEGUNDO_APELLIDO || '' '' || "gen$persona".NOMBRE AS NOMBRE,');
        IBSQL1.SQL.Add('  "col$causaciones".DEUDA');
        IBSQL1.SQL.Add('FROM');
        IBSQL1.SQL.Add(' "col$causaciones"');
        IBSQL1.SQL.Add(' INNER JOIN "gen$persona" ON ("col$causaciones".ID_IDENTIFICACION="gen$persona".ID_IDENTIFICACION)');
        IBSQL1.SQL.Add('  AND ("col$causaciones".ID_PERSONA="gen$persona".ID_PERSONA)');
        IBSQL1.SQL.Add('WHERE');
        IBSQL1.SQL.Add('  ("col$causaciones".ID_AGENCIA = :ID_AGENCIA) AND ');
        IBSQL1.SQL.Add('  ("col$causaciones".ID_COLOCACION = :ID_COLOCACION) AND ');
        IBSQL1.SQL.Add('  ("col$causaciones".FECHA_CORTE = :FECHA_CORTE)');
        IBSQL1.ParamByName('FECHA_CORTE').AsDate := EncodeDate(2005,12,30);

        with IBQMarzo do begin
         CDResult.Open;
         Status.Panels[1].Text := 'Confrontando Colocaciones Septiembre - Diciembre Oficina Convención';

         while not Eof do begin
          Bar1.Position := RecNo;
          Application.ProcessMessages;
          IBSQL1.Close;
          IBSQL1.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
          IBSQL1.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
          CDResult.Append;
          CDResult.FieldByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
          CDResult.FieldByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
          CDResult.FieldByName('ID_EDAD').AsString := FieldByName('ID_ARRASTRE').AsString;
          CDResult.FieldByName('NOMBRE').AsString := FieldByName('NOMBRE').AsString;
          CDResult.FieldByName('DEUDA').AsCurrency := FieldByName('DEUDA').AsCurrency;
          try
           IBSQL1.ExecQuery;
           if IBSQL1.RecordCount > 0 then
           begin
             CDResult.FieldByName('ID_ARRASTRE').AsString := IBSQL1.fieldbyname('ID_ARRASTRE').AsString;
             CDResult.FieldByName('DEUDAJ').AsCurrency := IBSQL1.FieldByName('DEUDA').AsCurrency;
             if IBSQL1.FieldByName('ID_ARRASTRE').AsString < FieldByName('ID_ARRASTRE').AsString then
             begin
                CDResult.FieldByName('BAJA').AsBoolean := True;
                CDResult.FieldByName('SUBE').AsBoolean := False;
                CDResult.FieldByName('MANTIENE').AsBoolean := False;
                CDResult.FieldByName('SALDADO').AsBoolean := False;
             end
             else
             if IBSQL1.FieldByName('ID_ARRASTRE').AsString > FieldByName('ID_ARRASTRE').AsString then
             begin
                CDResult.FieldByName('BAJA').AsBoolean := False;
                CDResult.FieldByName('SUBE').AsBoolean := True;
                CDResult.FieldByName('MANTIENE').AsBoolean := False;
                CDResult.FieldByName('SALDADO').AsBoolean := False;
             end
             else
             begin
                CDResult.FieldByName('BAJA').AsBoolean := False;
                CDResult.FieldByName('SUBE').AsBoolean := False;
                CDResult.FieldByName('MANTIENE').AsBoolean := True;
                CDResult.FieldByName('SALDADO').AsBoolean := False;
             end;
           end
           else
           begin
               CDResult.FieldByName('ID_ARRASTRE').AsString := ' ';
               CDResult.FieldByName('BAJA').AsBoolean := False;
               CDResult.FieldByName('SUBE').AsBoolean := False;
               CDResult.FieldByName('MANTIENE').AsBoolean := False;
               CDResult.FieldByName('SALDADO').AsBoolean := True;
               CDResult.FieldByName('DEUDAJ').AsCurrency := 0;
           end;
          except
           Transaction.Rollback;
           raise;
           Exit;
          end;
          Next;
         end; // fin del while
        end; // fin del with


        IBQMarzo.Close;

        with CDResult do
        begin
          Filter := 'ID_AGENCIA = 3';
          Filtered := True;
          First;
          Bar2.Min := 0;
          Bar2.Max := RecordCount;
          Bar2.Position := 0;
          IBSQL1.Close;
          IBSQL1.SQL.Clear;
          IBSQL1.SQL.Add('select * from "col$extracto" where');
          IBSQL1.SQL.Add('ID_AGENCIA = :ID_AGENCIA and ID_COLOCACION = :ID_COLOCACION and');
          IBSQL1.SQL.Add('FECHA_EXTRACTO BETWEEN :FECHA1 and :FECHA2 and ABONO_CAPITAL <> 0');
          IBSQL1.SQL.Add('ORDER BY FECHA_EXTRACTO,ID_CBTE_COLOCACION');
          IBSQL1.ParamByName('FECHA1').AsDate := EncodeDate(2005,10,01);
          IBSQL1.ParamByName('FECHA2').AsDate := EncodeDate(2005,12,30);
          while not Eof do begin
           Bar2.Position := RecNo;
           Application.ProcessMessages;
           IBSQL1.Close;
           IBSQL1.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
           IBSQL1.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
           try
            IBSQL1.ExecQuery;
            while not IBSQL1.Eof do
            begin
               CDAbonos.Open;
               CDAbonos.Append;
               CDAbonos.FieldByName('ID_AGENCIA').AsInteger := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
               CDAbonos.FieldByName('ID_COLOCACION').AsString := IBSQL1.FieldByName('ID_COLOCACION').AsString;
               CDAbonos.FieldByName('FECHA').AsDateTime := IBSQL1.FieldByName('FECHA_EXTRACTO').AsDate;
               CDAbonos.FieldByName('VALOR_CAPITAL').AsCurrency := IBSQL1.FieldByName('ABONO_CAPITAL').AsCurrency;
               CDAbonos.FieldByName('RECIBO').AsInteger := IBSQL1.FieldByName('ID_CBTE_COLOCACION').AsInteger;
               CDAbonos.Post;
               CDAbonos.Close;
               IBSQL1.Next;
            end;// fin del while ibsql1
           except
            IBSQL1.Transaction.Rollback;
            raise;
            Exit;
           end;
           Next;
          end; // fin del while
        end; // fin del with

        IBDatabase3.Close;        

end;
procedure TfrmConfrontar.btnCerrarClick(Sender: TObject);
begin
        if IBDatabase1.Connected then
        begin
          Status.Panels[1].Text := 'Desconectando de Database Ocaña';
          Application.ProcessMessages;
          IBDatabase1.Close;
        end;
        if IBDatabase2.Connected then
        begin
          Status.Panels[1].Text := 'Desconectando de Database Abrego';
          Application.ProcessMessages;
          IBDatabase2.Close;
        end;
        if IBDatabase3.Connected then
        begin
          Status.Panels[1].Text := 'Desconectando de Database Convención';
          Application.ProcessMessages;
          IBDatabase3.Close;
        end;
        Close;
end;

procedure TfrmConfrontar.btnConfrontarClick(Sender: TObject);
begin
        CDAbonos.CancelUpdates;
        CdCreditos.CancelUpdates;
        Procesar1;
        //Procesara;
        //Procesarc;
        CDResult.Close;
        CDAbonos.Close;
        CDResult.Filtered := False;
        CDResult.Filter := 'DEUDA <> DEUDAJ';
        CDResult.Filtered := True;
        CDResult.Open;
        CDAbonos.Open;
        frReport1.LoadFromFile(ExtractFilePath(Application.ExeName)+'\Confrontacionp.frf');
//        frReport1.DesignReport;
        if frReport1.PrepareReport then
           frReport1.ShowPreparedReport
        else
           ShowMessage('No hay reporte');
        IBDatabase1.Close;
end;

procedure TfrmConfrontar.procesara;
var    Fantes,Fdespues :TDate;
       i,b :Integer;
       vDirerencia :Currency;
begin
        IBDatabase1.Close;
        with IBDatabase1 do begin
          Status.Panels[1].Text := 'Intentando Conexión con Database Abrego';
          Application.ProcessMessages;
          DatabaseName := '192.168.200.254:/dbase/baseenero/abrego/abene06.fdb';
          Params.Clear;
          Params.Add('user_name=SYSDBA');
          Params.Add('password=masterkey');
          Params.Add('sql_role_name=CARTERA');
          Params.Add('lc_ctype=ISO8859_1');
          try
           Open;
          except
           raise;
           Exit;
          end;
        end;
        with IBTransaction1 do begin
          StartTransaction;
        end;
         with IBQuery1 do
         begin
           Close;
           Open;
           Last;
           First;
           Bar1.Min := 0;
           Bar1.Max := RecordCount;
           Bar1.Position := 0;
           while not Eof do
           begin
             Bar1.Position := RecNo;
             Application.ProcessMessages;
             IBvalida.Close;
             IBvalida.ParamByName('FECHA_INICIO').AsDate := EncodeDate(2004,12,30);
             IBvalida.ParamByName('FECHA_FIN').AsDate := EncodeDate(2005,12,30);
             IBvalida.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
             IBvalida.ParamByName('ID_AGENCIA').AsInteger := 2;
             IBvalida.Open;
             IBvalida.Last;
             b := IBvalida.RecordCount;
             if b > 0 then
             begin
              vDirerencia := 0;
              Fantes := EncodeDate(2004,12,30);
              for i := 0 to 0 do
              begin
                Fdespues := EncodeDate(2005,12,30);
                Fantes := EncodeDate(2004,12,30);
                {Fdespues := IncMonth(Fantes,1);
                if i = 1 then
                   Fdespues := EncodeDate(2005,02,28);
                if i = 2 then
                    Fdespues := EncodeDate(2005,03,30);}
                IBantes.Close;
                IBantes.ParamByName('FECHA_CORTE').AsDate := Fantes;
                IBantes.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                IBantes.ParamByName('ID_AGENCIA').AsInteger := 2;
                IBantes.Open;
                IBdespues.Close;
                IBdespues.ParamByName('FECHA_CORTE').AsDate := Fdespues;
                IBdespues.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                IBdespues.ParamByName('ID_AGENCIA').AsInteger := 2;
                IBdespues.Open;
                                IF IBdespues.FieldByName('PCAPITAL').AsString <> '' then
                if IBdespues.FieldByName('PCAPITAL').AsCurrency < IBantes.FieldByName('PCAPITAL').AsCurrency then
                   vDirerencia := vDirerencia + (IBantes.FieldByName('PCAPITAL').AsCurrency  - IBdespues.FieldByName('PCAPITAL').AsCurrency);
                Fantes := Fdespues;
              end;
                if vDirerencia > 0 then
                begin
                  CdCreditos.Append;
                  CdCreditos.FieldValues['ID_AGENCIA'] := 2;
                  CdCreditos.FieldValues['ID_COLOCACION'] := FieldByName('ID_COLOCACION').AsString;
                  CdCreditos.FieldValues['NOMBRE'] := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
                  CdCreditos.FieldValues['VARIACION'] := vDirerencia;
                  CdCreditos.FieldValues['CLASIFICACION'] := FieldByName('DESCRIPCION_CLASIFICACION').AsString;
                  CdCreditos.Post;
                  IBSQL1.Close;
                  IBSQL1.SQL.Clear;
                  IBSQL1.SQL.Add('select * from "col$extracto" where');
                  IBSQL1.SQL.Add('ID_AGENCIA = :ID_AGENCIA and ID_COLOCACION = :ID_COLOCACION and');
                  IBSQL1.SQL.Add('FECHA_EXTRACTO BETWEEN :FECHA1 and :FECHA2 and ABONO_CAPITAL <> 0');
                  IBSQL1.SQL.Add('ORDER BY FECHA_EXTRACTO,ID_CBTE_COLOCACION');
                  IBSQL1.ParamByName('FECHA1').AsDate := EncodeDate(2005,01,01);
                  IBSQL1.ParamByName('FECHA2').AsDate := EncodeDate(2005,12,30);
                  IBSQL1.ParamByName('ID_AGENCIA').AsInteger := 2;
                  IBSQL1.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                  IBSQL1.ExecQuery;
                  while not IBSQL1.Eof do
                  begin
                     CDAbonos.Open;
                     CDAbonos.Append;
                     CDAbonos.FieldByName('ID_AGENCIA').AsInteger := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
                     CDAbonos.FieldByName('ID_COLOCACION').AsString := IBSQL1.FieldByName('ID_COLOCACION').AsString;
                     CDAbonos.FieldByName('FECHA').AsDateTime := IBSQL1.FieldByName('FECHA_EXTRACTO').AsDate;
                     CDAbonos.FieldByName('VALOR_CAPITAL').AsCurrency := IBSQL1.FieldByName('ABONO_CAPITAL').AsCurrency;
                     CDAbonos.FieldByName('RECIBO').AsInteger := IBSQL1.FieldByName('ID_CBTE_COLOCACION').AsInteger;
                     CDAbonos.Post;
                     IBSQL1.Next;
                  end;

                end;
             end;// FIN DEL VALIDA
             Next;

           end;// FIN DEL PRIMER WHILE
         end;


end;

procedure TfrmConfrontar.procesarc;
var    Fantes,Fdespues :TDate;
       i,b :Integer;
       vDirerencia :Currency;
begin
        IBDatabase1.Close;
        with IBDatabase1 do begin
          Status.Panels[1].Text := 'Intentando Conexión con Database Convención';
          Application.ProcessMessages;
          DatabaseName := '192.168.200.254:/dbase/baseenero/convencion/conene06.fdb';
          Params.Clear;
          Params.Add('user_name=SYSDBA');
          Params.Add('password=masterkey');
          Params.Add('sql_role_name=CARTERA');
          Params.Add('lc_ctype=ISO8859_1');
          try
           Open;
          except
           raise;
           Exit;
          end;
        end;
        with IBTransaction1 do begin
          StartTransaction;
        end;
         with IBQuery1 do
         begin
           Close;
           Open;
           Last;
           First;
           Bar1.Min := 0;
           Bar1.Max := RecordCount;
           Bar1.Position := 0;
           while not Eof do
           begin
             Bar1.Position := RecNo;
             Application.ProcessMessages;
             IBvalida.Close;
             IBvalida.ParamByName('FECHA_INICIO').AsDate := EncodeDate(2004,12,30);
             IBvalida.ParamByName('FECHA_FIN').AsDate := EncodeDate(2005,12,30);
             IBvalida.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
             IBvalida.ParamByName('ID_AGENCIA').AsInteger := 3;
             IBvalida.Open;
             IBvalida.Last;
             b := IBvalida.RecordCount;
             if b > 0 then
             begin
              vDirerencia := 0;
              Fantes := EncodeDate(2004,12,30);
              for i := 0 to 0{(b - 2)} do
              begin
                Fdespues := EncodeDate(2005,12,30);
                Fantes := EncodeDate(2004,12,30);
{
                Fdespues := IncMonth(Fantes,1);
                if i = 1 then
                   Fdespues := EncodeDate(2005,02,28);
                if i = 2 then
                    Fdespues := EncodeDate(2005,03,30);}
                IBantes.Close;
                IBantes.ParamByName('FECHA_CORTE').AsDate := Fantes;
                IBantes.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                IBantes.ParamByName('ID_AGENCIA').AsInteger := 3;
                IBantes.Open;
                IBdespues.Close;
                IBdespues.ParamByName('FECHA_CORTE').AsDate := Fdespues;
                IBdespues.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                IBdespues.ParamByName('ID_AGENCIA').AsInteger := 3;
                IBdespues.Open;
                IF IBdespues.FieldByName('PCAPITAL').AsString <> '' then
                if IBdespues.FieldByName('PCAPITAL').AsCurrency < IBantes.FieldByName('PCAPITAL').AsCurrency then
                   vDirerencia := vDirerencia + (IBantes.FieldByName('PCAPITAL').AsCurrency  - IBdespues.FieldByName('PCAPITAL').AsCurrency);
                Fantes := Fdespues;
              end;
                if vDirerencia > 0 then
                begin
                  CdCreditos.Append;
                  CdCreditos.FieldValues['ID_AGENCIA'] := 3;
                  CdCreditos.FieldValues['ID_COLOCACION'] := FieldByName('ID_COLOCACION').AsString;
                  CdCreditos.FieldValues['NOMBRE'] := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
                  CdCreditos.FieldValues['VARIACION'] := vDirerencia;
                  CdCreditos.FieldValues['CLASIFICACION'] := FieldByName('DESCRIPCION_CLASIFICACION').AsString;
                  CdCreditos.Post;
                  IBSQL1.Close;
                  IBSQL1.SQL.Clear;
                  IBSQL1.SQL.Add('select * from "col$extracto" where');
                  IBSQL1.SQL.Add('ID_AGENCIA = :ID_AGENCIA and ID_COLOCACION = :ID_COLOCACION and');
                  IBSQL1.SQL.Add('FECHA_EXTRACTO BETWEEN :FECHA1 and :FECHA2 and ABONO_CAPITAL <> 0');
                  IBSQL1.SQL.Add('ORDER BY FECHA_EXTRACTO,ID_CBTE_COLOCACION');
                  IBSQL1.ParamByName('FECHA1').AsDate := EncodeDate(2005,01,01);
                  IBSQL1.ParamByName('FECHA2').AsDate := EncodeDate(2005,12,30);
                  IBSQL1.ParamByName('ID_AGENCIA').AsInteger := 3;
                  IBSQL1.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                  IBSQL1.ExecQuery;
                  while not IBSQL1.Eof do
                  begin
                     CDAbonos.Open;
                     CDAbonos.Append;
                     CDAbonos.FieldByName('ID_AGENCIA').AsInteger := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
                     CDAbonos.FieldByName('ID_COLOCACION').AsString := IBSQL1.FieldByName('ID_COLOCACION').AsString;
                     CDAbonos.FieldByName('FECHA').AsDateTime := IBSQL1.FieldByName('FECHA_EXTRACTO').AsDate;
                     CDAbonos.FieldByName('VALOR_CAPITAL').AsCurrency := IBSQL1.FieldByName('ABONO_CAPITAL').AsCurrency;
                     CDAbonos.FieldByName('RECIBO').AsInteger := IBSQL1.FieldByName('ID_CBTE_COLOCACION').AsInteger;
                     CDAbonos.Post;
                     IBSQL1.Next;
                  end;

                end;
             end;// FIN DEL VALIDA
             Next;

           end;// FIN DEL PRIMER WHILE
         end;


end;

procedure TfrmConfrontar.BitBtn1Click(Sender: TObject);
//var
//  ExcelFile:TDataSetToExcel;
//  valor :Currency;
begin
{        CdExel.CancelUpdates;
        with CdCreditos do
        begin
          First;
          while not Eof do
          begin
            CdExel.Append;
            CdExel.FieldValues['CAMPO1'] := 'COLOCACION';
            CdExel.FieldValues['CAMPO2'] := FieldByName('ID_AGENCIA').AsString + '-' + FieldByName('ID_COLOCACION').AsString;
            CdExel.FieldValues['CAMPO3'] := 'CLASIFICACION';
            CdExel.FieldValues['CAMPO4'] := FieldByName('CLASIFICACION').AsString;
            CdExel.FieldValues['CAMPO5'] := 'VARIACION';
            CdExel.FieldValues['CAMPO6'] := CurrToStrF(FieldByName('VARIACION').AsCurrency,ffCurrency,1);
            CdExel.Post;
            CDAbonos.Filtered := False;
            CDAbonos.Filter := 'ID_COLOCACION = ' + '''' + FieldByName('ID_COLOCACION').AsString + '''';
            CDAbonos.Filtered := True;
            valor := 0;
            while not CDAbonos.Eof do
            begin
              CdExel.Append;
              CdExel.FieldValues['CAMPO1'] := 'FECHA ABONO:';
              CdExel.FieldValues['CAMPO2'] := CDAbonos.FieldByName('FECHA').AsDateTime;
              CdExel.FieldValues['CAMPO3'] := 'RECIBO No.';
              CdExel.FieldValues['CAMPO4'] := CDAbonos.FieldByName('RECIBO').AsString;
              CdExel.FieldValues['CAMPO5'] := 'VALOR ABONO';
              CdExel.FieldValues['CAMPO6'] := CurrToStrF(CDAbonos.FieldByName('VALOR_CAPITAL').AsCurrency,ffCurrency,1);
              CdExel.Post;
              valor := valor + CDAbonos.FieldByName('VALOR_CAPITAL').AsCurrency;
              CDAbonos.Next;
            end;

            CdExel.Append;
            CdExel.FieldValues['CAMPO1'] := '';
            CdExel.FieldValues['CAMPO2'] := '';
            CdExel.FieldValues['CAMPO3'] := '';
            CdExel.FieldValues['CAMPO4'] := '';
            CdExel.FieldValues['CAMPO5'] := 'TOTAL';
            CdExel.FieldValues['CAMPO6'] := CurrToStrF(valor,ffCurrency,1);;
            CdExel.Post;
            CdExel.Append;
            CdExel.FieldValues['CAMPO1'] := '';
            CdExel.FieldValues['CAMPO2'] := '';
            CdExel.FieldValues['CAMPO3'] := '';
            CdExel.FieldValues['CAMPO4'] := '';
            CdExel.FieldValues['CAMPO5'] := '';
            CdExel.FieldValues['CAMPO6'] := '';
            CdExel.Post;
            Next;
          end;
        end;
    CdExel.First;
    scExcelExport1.LoadDefaultProperties;
    scExcelExport1.WorksheetName := 'CARTERA';
    scExcelExport1.Dataset:=CdExel;
    scExcelExport1.ExcelVisible:=True;
    scExcelExport1.OnGetCellStyleEvent := ChangeCellColors;
    scExcelExport1.ExportDataset;
    scExcelExport1.Disconnect;   }

end;

{procedure TfrmConfrontar.ChangeCellColors(Sender: TObject; Field: TField;
  var ColorBackground: TColor; FontCell: TxlFont);
begin
    if Field.Dataset.FieldByName('CAMPO1').Value = 'COLOCACION' then
      ColorBackground := clSilver;

end;}

procedure TfrmConfrontar.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'fecha1' then
           ParValue := Fecha1.Date;
        if ParName = 'fecha2' then
           ParValue := Fecha2.Date;
end;

end.
