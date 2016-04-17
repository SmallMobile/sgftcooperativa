unit UnitRecuperacionsaldos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, StdCtrls, Dateutils, Buttons, IBSQL,
  ComCtrls, JvComponent, JvProgressDlg, ExtCtrls;

type
  Tfrmrecuperacionsaldos = class(TForm)
    IBQuery1: TIBQuery;
    IBQuery2: TIBQuery;
    IBSactualizar: TIBSQL;
    IBQuery3: TIBQuery;
    btnsalir: TBitBtn;
    JvProgreso: TJvProgressDlg;
    Panel1: TPanel;
    Panel2: TPanel;
    btnaceptar: TBitBtn;
    procedure btnaceptarClick(Sender: TObject);
    procedure btnsalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    _bOpcion :Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmrecuperacionsaldos: Tfrmrecuperacionsaldos;

implementation

{$R *.dfm}

uses UnitGlobales;

procedure Tfrmrecuperacionsaldos.btnaceptarClick(Sender: TObject);
var
codigo       : string;
agencia      : integer;
debito       : currency;
credito      : currency;
fechadia     : TDate;
mes          : integer;
mescierre    : string;
begin

  if _bOpcion then
  begin
    Close;
    Exit;
  end;
  btnaceptar.Enabled := False;
  btnsalir.Enabled := False;
  btnsalir.Visible := True;


 with IBQuery1 do begin
   if Transaction.InTransaction then
      Transaction.Rollback;
   Transaction.StartTransaction;
   Close;
   SQL.Clear;
   SQL.Add('select count(*) AS TOTAL from "con$puc"');
   SQL.Add('where ');
   SQL.Add('"con$puc".MOVIMIENTO <> 0');
   try
    Open;
     JvProgreso.Maximum := FieldByName('TOTAL').AsInteger;
     JvProgreso.Text := 'Espere un Momento...';
     JvProgreso.Show;
   except
     Transaction.Rollback;
     raise;
     Exit;
   end;
 end;



  with ibquery1 do
    begin
      Close;
      sql.Clear;
      sql.Add('select ');
      sql.Add('"con$puc".CODIGO,');
      sql.Add('"con$puc".ID_AGENCIA,');
      sql.Add('"con$puc".SALDOINICIAL');
      sql.Add('from "con$puc"');
      sql.Add('where ');
      sql.Add('"con$puc".MOVIMIENTO <> 0');
      SQL.Add('order by "con$puc".CODIGO');
      open;
      try
        while not Eof do
         begin
           Application.ProcessMessages;
           codigo := fieldbyname('CODIGO').AsString;
           agencia := fieldbyname('ID_AGENCIA').AsInteger;
              IBQuery2.Close;
              IBQuery2.sql.Clear;
              IBQuery2.sql.Add('update "con$saldoscuenta" set ');
              IBQuery2.sql.Add('"con$saldoscuenta"."DEBITO" =:"DEBITO",');
              IBQuery2.sql.Add('"con$saldoscuenta"."CREDITO" =:"CREDITO"');
              IBQuery2.sql.Add('where ');
              IBQuery2.sql.Add('"con$saldoscuenta".ID_AGENCIA =:"ID_AGENCIA" and');
              IBQuery2.sql.Add('"con$saldoscuenta".CODIGO =:"CODIGO"');
              IBQuery2.ParamByName('ID_AGENCIA').AsInteger := agencia;
              IBQuery2.ParamByName('CODIGO').AsString := codigo;
              IBQuery2.ParamByName('DEBITO').AsCurrency := 0;
              IBQuery2.ParamByName('CREDITO').AsCurrency := 0;
              try
                IBQuery2.ExecSQL;
              except
                 IBQuery2.Transaction.Rollback;
                 raise;
                 Exit;
              end;
           with ibquery3 do
            begin
              IBQuery3.sql.Clear;
              IBQuery3.sql.Add('select ');
              IBQuery3.sql.Add('"con$auxiliar".ID_COMPROBANTE,');
              IBQuery3.sql.Add('"con$auxiliar".ID_AGENCIA,');
              IBQuery3.sql.Add('"con$auxiliar".FECHA,');
              IBQuery3.sql.Add('"con$auxiliar".CODIGO,');
              IBQuery3.sql.Add('"con$auxiliar".DEBITO,');
              IBQuery3.sql.Add('"con$auxiliar".CREDITO,');
              IBQuery3.sql.Add('"con$auxiliar".ESTADOAUX');
              IBQuery3.sql.Add('from "con$auxiliar"');
              IBQuery3.sql.Add('where ');
              IBQuery3.sql.Add('"con$auxiliar".CODIGO =:"CODIGO" and');
              IBQuery3.SQL.Add('"con$auxiliar".ID_AGENCIA =:"ID_AGENCIA" and');
              IBQuery3.sql.Add('"con$auxiliar".ESTADOAUX =:"ESTADOAUX"');
              IBQuery3.ParamByName('CODIGO').AsString := codigo;
              IBQuery3.ParamByName('ID_AGENCIA').AsInteger := agencia;
              IBQuery3.ParamByname('ESTADOAUX').AsString := 'C';
              IBQuery3.open;
              while not ibquery3.Eof do
                begin
                 Application.ProcessMessages;
                 debito      := FieldbyName('DEBITO').AsCurrency;
                 credito     := FieldbyName('CREDITO').AsCurrency;
                 fechadia    := Fieldbyname('FECHA').AsDateTime;
                 mes := monthof(fechadia);
                 mescierre := formatcurr('00',mes);
                 with  IBSactualizar do
                  begin
                    sql.Clear;
                    sql.Add('update "con$saldoscuenta" set');
                    sql.Add('"con$saldoscuenta"."DEBITO" ="con$saldoscuenta"."DEBITO" + :"DEBITO",');
                    sql.Add('"con$saldoscuenta"."CREDITO" ="con$saldoscuenta"."CREDITO" + :"CREDITO"');
                    sql.Add('where ');
                    sql.Add('"con$saldoscuenta".ID_AGENCIA =:"ID_AGENCIA" and');
                    sql.Add('"con$saldoscuenta".CODIGO =:"CODIGO" and');
                    sql.Add('"con$saldoscuenta".MES =:"MES"');
                    ParamByname('ID_AGENCIA').AsInteger := agencia;
                    ParamByname('CODIGO').AsString := codigo;
                    ParamByname('MES').AsInteger := mes;
                    ParamByname('DEBITO').AsCurrency := debito;
                    ParamByname('CREDITO').AsCurrency := credito;
                    try
                      ExecQuery;
                      if RowsAffected < 1 then
                       begin
                         Close;
                         SQL.Clear;
                         SQL.Add('insert into "con$saldoscuenta" values(:ID_AGENCIA,:CODIGO,:MES,:DEBITO,:CREDITO)');
                         ParamByName('ID_AGENCIA').AsInteger := Agencia;
                         ParamByName('CODIGO').AsString := codigo;
                         ParamByName('MES').AsInteger := StrToInt(mescierre);
                         ParamByName('DEBITO').AsCurrency := debito;
                         ParamByName('CREDITO').AsCurrency := credito;
                         try
                          ExecQuery;
                         except
                          raise;
                         end;
                        end;
                       close;
                      except
                       raise;
                      end;
                  end;
                 next;
               end;
            end; // fin query3
           next;
           JvProgreso.Value := IBQuery1.RecNo +1;
         end; // fin while query1
         IBQuery1.Transaction.Commit;
         if ReCalculoSaldosGenerales then
         begin
//           IBQuery1.Transaction.Commit;
           JvProgreso.Close;
           Application.ProcessMessages;
           MessageDlg('Proceso Culminado con Exito',mtInformation,[mbok],0);
           btnaceptar.Enabled := True;
           btnaceptar.Caption := '&Salir';
           _bOpcion := True;
         end
         else
         begin
           JvProgreso.Close;
           Application.ProcessMessages;
           MessageDlg('Error Recalculando Saldos...',mtError,[mbok],0);
         end;
      finally
      end;
    end; //fin query1
end;

procedure Tfrmrecuperacionsaldos.btnsalirClick(Sender: TObject);
begin
        self.Close;
end;

procedure Tfrmrecuperacionsaldos.FormCreate(Sender: TObject);
begin
        _bOpcion := False;
end;

end.




