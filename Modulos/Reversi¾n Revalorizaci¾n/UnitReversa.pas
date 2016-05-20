unit UnitReversa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, JvComCtrls, IBSQL, IBDatabase,
  ComCtrls, pr_Common, pr_TxClasses, IBCustomDataSet, IBQuery;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    cds: TClientDataSet;
    cdsID_AGENCIA: TIntegerField;
    cdsID_TIPO_CAPTACION: TIntegerField;
    cdsNUMERO_CUENTA: TIntegerField;
    cdsDIGITO_CUENTA: TIntegerField;
    cdsVALOR: TCurrencyField;
    Bar: TProgressBar;
    IBDatabase1: TIBDatabase;
    IBT: TIBTransaction;
    EdIp: TJvIpAddress;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    IBSQL2: TIBSQL;
    IBSQL1: TIBQuery;
    Reporte: TprTxReport;
    Label2: TLabel;
    EdRev: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure ReporteCreatePreview(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Total:Integer;

implementation

{$R *.dfm}

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
        if IBDatabase1.Connected then
           IBDatabase1.Close;
        Close;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
         BitBtn1.Enabled := False;
        IBDatabase1.DatabaseName := EdIp.Text + ':/var/db/fbird/database.fdb';
        try
         IBDatabase1.Open;
        except
         raise;
        end;

        IBT.StartTransaction;

        cds.EmptyDataSet;

        with IBSQL1 do begin
          Close;
          SQL.Clear;
          SQL.Add('select count(*) as TOTAL from "cap$maestro"');
          SQL.Add('where ID_TIPO_CAPTACION = 1 and ((ID_ESTADO = 2) or (ID_ESTADO = 9) or (ID_ESTADO = 10))');
          try
            Open;
          except
            raise;
          end;
          Bar.Min := 0;
          Bar.Max := FieldByName('TOTAL').AsInteger;
          Bar.Position := 0;

          Close;
          SQL.Clear;
          SQL.Add('select ID_AGENCIA,ID_TIPO_CAPTACION,NUMERO_CUENTA,DIGITO_CUENTA');
          SQL.Add('from "cap$maestro"');
          SQL.Add('where ID_TIPO_CAPTACION = 1 and ((ID_ESTADO = 2) or (ID_ESTADO = 9) or (ID_ESTADO = 10))');
          SQL.Add('order by ID_AGENCIA,ID_TIPO_CAPTACION,NUMERO_CUENTA,DIGITO_CUENTA');
          try
           Open;
          except
           raise;
          end;
          
          Total := 0;

          while not Eof do begin
            Bar.Position := RecNo;
            Application.ProcessMessages;
            IBSQL2.Close;
            IBSQL2.SQL.Clear;
            IBSQL2.SQL.Add('select first 1 * from "cap$extracto"');
            IBSQL2.SQL.Add('where ("cap$extracto".ID_AGENCIA = :ID_AGENCIA) AND ("cap$extracto".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION) AND ("cap$extracto".NUMERO_CUENTA = :NUMERO_CUENTA) AND ("cap$extracto".DIGITO_CUENTA = :DIGITO_CUENTA)');
            IBSQL2.SQL.Add('order by FECHA_MOVIMIENTO DESC');
            IBSQL2.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
            IBSQL2.ParamByName('ID_TIPO_CAPTACION').AsInteger := FieldByName('ID_TIPO_CAPTACION').AsInteger;
            IBSQL2.ParamByName('NUMERO_CUENTA').AsInteger := FieldByName('NUMERO_CUENTA').AsInteger;
            IBSQL2.ParamByName('DIGITO_CUENTA').AsInteger := FieldByName('DIGITO_CUENTA').AsInteger;
            try
             IBSQL2.ExecQuery;
            except
             raise;
            end;

            if (IBSQL2.FieldByName('FECHA_MOVIMIENTO').AsString = '2005/04/02') and
               (IBSQL2.FieldByName('DOCUMENTO_MOVIMIENTO').AsString = EdRev.Text) then
             begin
               cds.Open;
               cds.Append;
               cds.FieldByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
               cds.FieldByName('ID_TIPO_CAPTACION').AsInteger := FieldByName('ID_TIPO_CAPTACION').AsInteger;
               cds.FieldByName('NUMERO_CUENTA').AsInteger := FieldByName('NUMERO_CUENTA').AsInteger;
               cds.FieldByName('DIGITO_CUENTA').AsInteger := FieldByName('DIGITO_CUENTA').AsInteger;
               cds.FieldByName('VALOR').AsCurrency := IBSQL2.FieldByName('VALOR_DEBITO').AsCurrency;
               cds.Post;
               Total := Total + 1;
             end;
            Next;
          end; //end while
         end; // end with

         IBT.Commit;

         BitBtn4.Enabled := True;

end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
        if Reporte.PrepareReport then
           Reporte.PreviewPreparedReport(True);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
        BitBtn3.Enabled := False;
        Application.ProcessMessages;

        IBT.StartTransaction;
        with cds do begin
         Open;
         First;
         Bar.Min := 0;
         Bar.Max := Total;
         Bar.Position := 0;
         while not Eof do begin
           Bar.Position := cds.RecNo;
           Application.ProcessMessages;
           IBSQL2.Close;
           IBSQL2.SQL.Clear;
           IBSQL2.SQL.Add('insert into "cap$extracto" VALUES (:ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
           IBSQL2.SQL.Add(':FECHA,:HORA,:ID_TIPO,:DOCUMENTO,:DESCRIPCION,:DEBITO,:CREDITO)');
           IBSQL2.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
           IBSQL2.ParamByName('ID_TIPO_CAPTACION').AsInteger := FieldByName('ID_TIPO_CAPTACION').AsInteger;
           IBSQL2.ParamByName('NUMERO_CUENTA').AsInteger := FieldByName('NUMERO_CUENTA').AsInteger;
           IBSQL2.ParamByName('DIGITO_CUENTA').AsInteger := FieldByName('DIGITO_CUENTA').AsInteger;
           IBSQL2.ParamByName('FECHA').AsDate := Date;
           IBSQL2.ParamByName('HORA').AsTime := Time;
           IBSQL2.ParamByName('ID_TIPO').AsInteger := 6;
           IBSQL2.ParamByName('DOCUMENTO').AsString := '9999999';
           IBSQL2.ParamByName('DESCRIPCION').AsString := 'Reversión Revalorización de Aportes';
           IBSQL2.ParamByName('DEBITO').AsCurrency := 0;
           IBSQL2.ParamByName('CREDITO').AsCurrency := FieldByName('VALOR').AsCurrency;
           try
            IBSQL2.ExecQuery;
           except
            raise;
           end;

           Next;
         end;
        end;
        IBT.Commit;
        ShowMessage('Aplicación Terminada, No Olvide Realizar la nota de reversión!');

end;

procedure TForm1.ReporteCreatePreview(Sender: TObject);
begin
        BitBtn3.Enabled := True;
end;

end.
