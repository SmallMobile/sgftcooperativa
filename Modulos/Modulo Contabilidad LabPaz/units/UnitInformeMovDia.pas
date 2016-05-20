unit UnitInformeMovDia;

interface

uses
  StrUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, pr_Common, pr_TxClasses, StdCtrls, Buttons,
  ExtCtrls, ComCtrls, IBCustomDataSet, IBQuery, IBSQL;

type
  TfrmInformeMovDia = class(TForm)
    reportemov: TprTxReport;
    CDS: TClientDataSet;
    CDSID_TARJETA: TStringField;
    CDSCUENTA: TStringField;
    CDSASOCIADO: TStringField;
    CDSTERMINAL: TStringField;
    CDSSECUENCIA: TStringField;
    CDSMONTO: TCurrencyField;
    CDSCOMISION: TCurrencyField;
    CDSAPROBADA: TBooleanField;
    Label1: TLabel;
    EdFecha: TDateTimePicker;
    Panel1: TPanel;
    btnProcesar: TBitBtn;
    btnCerrar: TBitBtn;
    IBQuery1: TIBQuery;
    IBSQL4: TIBSQL;
    IBSQL2: TIBSQL;
    IBSQL3: TIBSQL;
    procedure btnCerrarClick(Sender: TObject);
    procedure btnProcesarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInformeMovDia: TfrmInformeMovDia;

implementation

{$R *.dfm}

uses UnitGlobales,UnitDmGeneral;

procedure TfrmInformeMovDia.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmInformeMovDia.btnProcesarClick(Sender: TObject);
var
  Aprobada:Boolean;
begin
        CDS.EmptyDataSet;

        with IBQuery1 do begin
          if Transaction.InTransaction then
             Transaction.Rollback;
          Transaction.StartTransaction;

          Close;
          SQL.Clear;
          SQL.Add('select * from "cap$tarjetamov" where NPOS_FECHA = :FECHA');
          ParamByName('FECHA').AsDate := EdFecha.Date;
          try
           Open;
           Last;
           First;
          except
           Transaction.Rollback;
           raise;
          end;

          while not Eof do begin          

          IBSQL2.Close;
          IBSQL2.SQL.Clear;
          IBSQL2.SQL.Add('select * from "cap$tarjetacuenta" where');
          IBSQL2.SQL.Add('ID_TARJETA = :ID_TARJETA');
          IBSQL2.ParamByName('ID_TARJETA').AsString := LeftStr(FieldByName('NPOS_TARJETA').AsString,16);
          try
           IBSQL2.ExecQuery;
          except
           Transaction.Rollback;
           raise;
          end;

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


           IBSQL4.Close;
           IBSQL4.SQL.Clear;
           IBSQL4.SQL.Add('select * from "cap$tarjetamovsdia" where');
           IBSQL4.SQL.Add('ID_TARJETA = :ID_TARJETA and SECUENCIA = :SECUENCIA and');
           IBSQL4.SQL.Add('FECHA = :FECHA');
           IBSQL4.ParamByName('ID_TARJETA').AsString := LeftStr(FieldByName('NPOS_TARJETA').AsString,16);
           IBSQL4.ParamByName('SECUENCIA').AsString := FieldByName('NPOS_FLD').AsString;
           IBSQL4.ParamByName('FECHA').AsDate := EdFecha.Date;
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

           CDS.Open;
           CDS.Insert;
           CDS.FieldByName('ID_TARJETA').AsString := LeftStr(FieldByName('NPOS_TARJETA').AsString,16);
           CDS.FieldByName('CUENTA').AsString := IBSQL2.FieldByName('ID_TIPO_CAPTACION').AsString +
                                                 Format('%.2d',[IBSQL2.FieldByName('ID_AGENCIA').AsInteger]) +
                                                 Format('%.7d',[IBSQL2.FieldByName('NUMERO_CUENTA').AsInteger]) +
                                                 IBSQL2.FieldByName('DIGITO_CUENTA').AsString;
           CDS.FieldByName('ASOCIADO').AsString := IBSQL3.FieldByName('NOMBRE').AsString;
           CDS.FieldByName('TERMINAL').AsString := FieldByName('NPOS_NOMBRE').AsString;
           CDS.FieldByName('SECUENCIA').AsString := FieldByName('NPOS_FLD').AsString;
           CDS.FieldByName('MONTO').AsCurrency := FieldByName('NPOS_MONTO').AsCurrency;
           CDS.FieldByName('COMISION').AsCurrency := FieldByName('NPOS_COMISION').AsCurrency;
           CDS.FieldByName('APROBADA').AsBoolean := Aprobada;
           CDS.Post;
           CDS.Close;

           Next;
          end;
        end;


        reportemov.Variables.ByName['EMPRESA'].AsString := Empresa;
        reportemov.Variables.ByName['NIT'].AsString := Nit;
        reportemov.Variables.ByName['FECHACORTE'].AsDateTime := EdFecha.Date;

        if reportemov.PrepareReport then
           reportemov.PreviewPreparedReport(True);



end;

procedure TfrmInformeMovDia.FormKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
end;

end.
