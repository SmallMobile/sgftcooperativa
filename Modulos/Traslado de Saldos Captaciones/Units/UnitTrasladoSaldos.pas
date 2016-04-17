unit UnitTrasladoSaldos;

interface

uses
  Windows, Messages, SysUtils, DateUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, JvEdit, JvTypedEdit, IBDatabase, DB,
  IBCustomDataSet, IBQuery, IBSQL;

type
  TfrmTrasladoSaldos = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    CmdProcesar: TBitBtn;
    CmdCerrar: TBitBtn;
    Label3: TLabel;
    Edit1: TEdit;
    AnoOld: TJvIntegerEdit;
    AnoNew: TJvIntegerEdit;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    CmdConectar: TBitBtn;
    Label4: TLabel;
    EdTipoCaptacion: TStaticText;
    EdAgencia: TStaticText;
    EdNumeroCuenta: TStaticText;
    EdDigitoCuenta: TStaticText;
    IBSQL1: TIBSQL;
    EdMensajes: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure CmdCerrarClick(Sender: TObject);
    procedure CmdConectarClick(Sender: TObject);
    procedure CmdProcesarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTrasladoSaldos: TfrmTrasladoSaldos;

implementation

{$R *.dfm}

procedure TfrmTrasladoSaldos.FormShow(Sender: TObject);
begin
        AnoOld.Value := YearOf(Date);
        AnoNew.Value := AnoOld.Value + 1;
end;

procedure TfrmTrasladoSaldos.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmTrasladoSaldos.CmdConectarClick(Sender: TObject);
begin
        IBDatabase1.DatabaseName := Edit1.Text;
        try
          IBDatabase1.Open;
          if IBDatabase1.Connected then
          begin
             CmdProcesar.Enabled := True;
             CmdConectar.Enabled := False;
          end
          else
             CmdProcesar.Enabled := False;
             CmdConectar.Enabled := True;
        except
          MessageDlg('No se pudo conectar',mtError,[mbcancel],0);
          CmdProcesar.Enabled := False;
        end;

end;

procedure TfrmTrasladoSaldos.CmdProcesarClick(Sender: TObject);
var Saldo,Movimiento:Currency;
begin
        Saldo := 0;
        with IBQuery1 do begin
         if Transaction.InTransaction then
           Transaction.Commit;
           Transaction.StartTransaction;
         Close;
         SQL.Clear;
         SQL.Add('select * from "cap$maestro" INNER JOIN "cap$tiposestado" ON ("cap$maestro".ID_ESTADO = "cap$tiposestado".ID_ESTADO)');
         SQL.Add('where "cap$tiposestado".SE_SUMA = 1 ORDER BY "cap$maestro".ID_TIPO_CAPTACION ASC, "cap$maestro".NUMERO_CUENTA');
         try
           Open;
           if RecordCount < 1 then begin
             MessageDlg('Nada para procesar',mtInformation,[mbok],0);
             Transaction.Commit;
             Exit;
           end;
         except
           MessageDlg('Error al Buscar Datos',mtError,[mbcancel],0);
           Transaction.Rollback;
           Exit;
         end;

         while not Eof do begin
           EdTipoCaptacion.Caption := Format('%d',[FieldByName('ID_TIPO_CAPTACION').AsInteger]);
           EdAgencia.Caption := Format('%.2d',[FieldByName('ID_AGENCIA').AsInteger]);
           EdNumeroCuenta.Caption := Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger]);
           EdDigitoCuenta.Caption := Format('%d',[FieldByName('DIGITO_CUENTA').AsInteger]);
           Application.ProcessMessages;
           with IBSQL1 do begin
                Close;
                SQL.Clear;
                SQL.Add('Select "cap$maestrosaldoinicial".SALDO_INICIAL from "cap$maestro"');
                SQL.Add('LEFT JOIN "cap$maestrosaldoinicial" ON ("cap$maestro".ID_AGENCIA = "cap$maestrosaldoinicial".ID_AGENCIA) AND');
                SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$maestrosaldoinicial".ID_TIPO_CAPTACION) AND ("cap$maestro".NUMERO_CUENTA = "cap$maestrosaldoinicial".NUMERO_CUENTA) AND ("cap$maestro".DIGITO_CUENTA = "cap$maestrosaldoinicial".DIGITO_CUENTA)');
                SQL.Add('Where');
                SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
                SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA and');
                SQL.Add('"cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA and');
                SQL.Add('"cap$maestrosaldoinicial".ANO = :ANO');
                ParamByName('ID_AGENCIA').AsInteger        := IBQuery1.FieldByName('ID_AGENCIA').AsInteger;
                ParamByName('ID_TIPO_CAPTACION').AsInteger := IBQuery1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                ParamByName('NUMERO_CUENTA').AsInteger     := IBQuery1.FieldByName('NUMERO_CUENTA').AsInteger;
                ParamByName('DIGITO_CUENTA').AsInteger     := IBQuery1.FieldByName('DIGITO_CUENTA').AsInteger;
                ParamByName('ANO').AsString                := IntToStr(AnoOld.Value);
                try
                  ExecQuery;
                  if RecordCount < 1 then
                  begin
                   EdMensajes.Caption := 'Fallo Consultando Saldo Inicial';
                  end;
                  Saldo := FieldByName('SALDO_INICIAL').AsCurrency;
                except
                   MessageDlg('Error Consultando Saldo Inicial',mtError,[mbcancel],0);
                   Transaction.Rollback;
                   Exit;
                end;

                Close;
                SQL.Clear;
                SQL.Add('SELECT SUM("cap$extracto".VALOR_DEBITO - "cap$extracto".VALOR_CREDITO) AS MOVIMIENTO from "cap$maestro"');
                SQL.Add('LEFT JOIN "cap$extracto" ON ("cap$maestro".ID_AGENCIA = "cap$extracto".ID_AGENCIA) AND ');
                SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$extracto".ID_TIPO_CAPTACION) AND ');
                SQL.Add('("cap$maestro".NUMERO_CUENTA = "cap$extracto".NUMERO_CUENTA) AND ("cap$maestro".DIGITO_CUENTA = "cap$extracto".DIGITO_CUENTA)');
                SQL.Add('Where');
                SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
                SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
                SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA and');
                SQL.Add('"cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA and');
                SQL.Add('"cap$extracto".FECHA_MOVIMIENTO BETWEEN :FECHA1 and :FECHA2');
                ParamByName('ID_AGENCIA').AsInteger        := IBQuery1.FieldByName('ID_AGENCIA').AsInteger;
                ParamByName('ID_TIPO_CAPTACION').AsInteger := IBQuery1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                ParamByName('NUMERO_CUENTA').AsInteger     := IBQuery1.fieldbyname('NUMERO_CUENTA').AsInteger;
                ParamByName('DIGITO_CUENTA').AsInteger     := IBQuery1.fieldbyname('DIGITO_CUENTA').AsInteger;
                ParamByName('FECHA1').AsDate := EncodeDate(AnoOld.Value,01,01);
                ParamByName('FECHA2').AsDate := EncodeDate(AnoOld.Value,12,31);
                try
                  ExecQuery;
                  if RecordCount < 1 then
                   Movimiento := 0
                  else
                   Movimiento := FieldByName('MOVIMIENTO').AsCurrency;
                except
                   MessageDlg('Error Consultando Movimientos',mtError,[mbcancel],0);
                   Movimiento := 0;
                end;
                Saldo := Saldo + Movimiento;
                Close;
                SQL.Clear;
                SQL.Add('insert into "cap$maestrosaldoinicial" Values(');
                SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,');
                SQL.Add(':ANO,:SALDO_INICIAL)');
                ParamByName('ID_AGENCIA').AsInteger        := IBQuery1.FieldByName('ID_AGENCIA').AsInteger;
                ParamByname('ID_TIPO_CAPTACION').AsInteger := IBQuery1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                ParamByname('NUMERO_CUENTA').AsInteger     := IBQuery1.fieldbyname('NUMERO_CUENTA').AsInteger;
                ParamByname('DIGITO_CUENTA').AsInteger     := IBQuery1.fieldbyname('DIGITO_CUENTA').AsInteger;
                ParamByName('ANO').AsString                := IntToStr(AnoNew.Value);
                ParamByName('SALDO_INICIAL').AsCurrency    := Saldo;
                try
                  ExecQuery;
                except
                  MessageDlg('Error al Tratar de Grabar el Nuevo Saldo',mterror,[mbcancel],0);
                  Transaction.Rollback;
                  Exit;
                end;
           end;
           Next;
         end;
        end;
        IBQuery1.Transaction.Commit;
        MessageDlg('Proceso Culminado con Exito!',mtInformation,[mbok],0);
end;

end.
