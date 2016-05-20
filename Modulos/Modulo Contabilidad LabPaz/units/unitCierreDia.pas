unit unitCierreDia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBCustomDataSet, Buttons, ComCtrls, ExtCtrls, IBQuery,
  IBSQL, Dateutils, pr_Common, pr_Parser, pr_TxClasses;

type
  Plerror   = ^Alist;
  Alist   = Record
    lagencia    : string;
    lcomprobante: string;
    lcuenta     : string;
    lcredito    : string;
    lnit        : string;
    lestado     : string;
    lcuadrado   : Boolean;
end;

type
  Tfrmcierredia = class(TForm)
    Panel1: TPanel;
    editfechacierre: TDateTimePicker;
    Label1: TLabel;
    Querycompcierre: TIBQuery;
    Queryauxcierre: TIBQuery;
    IBSQLcierre: TIBSQL;
    IBQRepnormal: TIBQuery;
    IBQRepanormal: TIBQuery;
    IBSQLcierre1: TIBSQL;
    IBQRepanormalID_AGENCIA: TSmallintField;
    IBQRepanormalID_COMPROBANTE: TIntegerField;
    IBQRepanormalERROR: TMemoField;
    IBQRepnormalID_AGENCIA: TSmallintField;
    IBQRepnormalID_COMPROBANTE: TIntegerField;
    IBQRepnormalFECHADIA: TDateField;
    IBQRepnormalTOTAL_DEBITO: TIBBCDField;
    IBQRepnormalTOTAL_CREDITO: TIBBCDField;
    IBQRepnormalESTADO: TIBStringField;
    IBVerificarcap: TIBSQL;
    Panel2: TPanel;
    BtnAceptar: TBitBtn;
    BtnReporte: TBitBtn;
    BtnSalir: TBitBtn;
    Reportcierre: TprTxReport;
    Repnormal: TprTxReport;
    Repanormal: TprTxReport;
    IBSQL1: TIBSQL;
    IBSQL2: TIBSQL;
    IBSQL3: TIBSQL;
    procedure BtnAceptarClick(Sender: TObject);
    procedure editfechacierreExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnReporteClick(Sender: TObject);
    procedure RepanormalUnknownObjFunction(Sender: TObject;
      Component: TComponent; const FuncName: String;
      const Parameters: TprVarsArray; ParametersCount: Integer;
      var Value: TprVarValue; var IsProcessed: Boolean);
    procedure editfechacierreEnter(Sender: TObject);
    procedure editfechacierreKeyPress(Sender: TObject; var Key: Char);
    procedure BtnSalirClick(Sender: TObject);
  private
    procedure RecuperarTotales;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcierredia  : Tfrmcierredia;
  mes           : currency;
  vfechacierre  : TDate;
  fecha         : Tdate;
  id_comprobante: Integer;
  vcuadrado     : Boolean;
  vcodigo       : Boolean;
  vcuenta       : Boolean;
  vcredito      : Boolean;
  vpersona      : Boolean;
  codigo        : String;
  debito        : Currency;
  credito       : Currency;
  lerror        : Tlist;
  vcierreaux    : Boolean;
  vcierre       : Boolean;
implementation

{$R *.dfm}

uses UnitDmGeneral, UnitGlobales, UnitVistaPreliminar,
     UnitPantallaProgreso;

procedure Tfrmcierredia.BtnAceptarClick(Sender: TObject);
var
frmProgreso:TfrmProgreso;
i,j             : integer;
total_debito    : currency;
total_credito   : currency;
estado          : string;
estadoaux       : string;
id              : integer;
cuenta          : string;
colocacion      : string;
identificacion  : string;
mescierre       : string;
TipoCaptacion   : Integer;
DigitoC         : String;
begin
//   RecuperarTotales;
   if dmGeneral.IBTransaction1.InTransaction then
      dmGeneral.IBTransaction1.Rollback;
   dmGeneral.IBTransaction1.StartTransaction;
   vcierre := True;
   try
   with querycompcierre do
    begin
      sql.Clear;
      sql.Add('Select ');
      sql.Add('"con$comprobante".ID_COMPROBANTE,');
      sql.Add('"con$comprobante".ID_AGENCIA,');
      sql.Add('"con$comprobante".FECHADIA,');
      sql.Add('"con$comprobante".TOTAL_DEBITO,');
      sql.Add('"con$comprobante".TOTAL_CREDITO,');
      sql.Add('"con$comprobante".ESTADO');
      sql.Add('from "con$comprobante"');
      sql.Add('where "con$comprobante"."FECHADIA" =:"FECHADIA" and "con$comprobante".ESTADO = :ESTADO and');
      SQL.Add('("con$comprobante".TOTAL_DEBITO > 0 and "con$comprobante".TOTAL_CREDITO > 0)');
      ParamByName('FECHADIA').AsDate := vfechacierre;
      ParamByName('ESTADO').AsString := 'O';
      open;
      Querycompcierre.Last;
      Querycompcierre.First;

      if querycompcierre.RecordCount = 0 then
       begin
         MessageDlg('No exiten comprobantes de fecha' + #10 + #13 + datetostr(vfechacierre) + #13 + #10 + 'Para Cerrar',mterror,[mbok],0);
         exit;
       end;
       frmProgreso := TfrmProgreso.Create(Self);
       frmProgreso.Min := 0;
       frmProgreso.Max := querycompcierre.RecordCount;
       frmProgreso.Titulo := 'Procesando Cierre del Día';
       frmProgreso.Position := 0;
       frmProgreso.Ejecutar;
        While not QueryCompcierre.Eof do
         begin
           id_comprobante := FieldByName('ID_COMPROBANTE').AsInteger;
           frmProgreso.InfoLabel := 'Verificando Comprobante No.:'+Format('%.7d',[id_comprobante]);
           frmProgreso.Position := Querycompcierre.RecNo;
           Application.ProcessMessages;
           agencia := FieldByName('ID_AGENCIA').AsInteger;
           estado := FieldByName('ESTADO').AsString;
           total_debito := FieldByName('TOTAL_DEBITO').AsCurrency;
           total_credito:= FieldByName('TOTAL_CREDITO').AsCurrency;
           vcuadrado := true;
           vcodigo := True;
           vcuenta := true;
           vcredito := true;
           vpersona := true;
           if estado = 'O' then
            begin
              if total_debito <> total_credito then
                 with IBSQLcierre do
                   begin
                     sql.Clear;
                     sql.Add('insert into "con$errorcierrecomp" (');
                     sql.Add('"con$errorcierrecomp"."ID_AGENCIA",');
                     sql.Add('"con$errorcierrecomp"."ID_COMPROBANTE",');
                     sql.Add('"con$errorcierrecomp"."ERROR")');
                     sql.Add(' values(');
                     sql.Add(':"ID_AGENCIA",:"ID_COMPROBANTE",:"ERROR")');
                     ParamByName('ID_AGENCIA').AsInteger := agencia;
                     ParamByName('ID_COMPROBANTE').AsInteger := id_comprobante;
                     ParamByName('ERROR').AsString := 'El Comprobante no está Cuadrado';
                     ExecQuery;
                     vcuadrado := false;
                     close;
                   end;

               with Queryauxcierre do
                begin
                  sql.Clear;
                  sql.Add('Select ');
                  sql.Add('"con$auxiliar".CODIGO,');
                  sql.Add('"con$auxiliar".DEBITO,');
                  sql.Add('"con$auxiliar".CREDITO,');
                  sql.Add('"con$auxiliar".ID_CUENTA,');
                  sql.Add('"con$auxiliar".ID_COLOCACION,');
                  sql.Add('"con$auxiliar".ID_IDENTIFICACION,');
                  sql.Add('"con$auxiliar".ID_PERSONA,');
                  sql.Add('"con$auxiliar".ESTADOAUX');
                  sql.Add('FROM "con$auxiliar"');
                  sql.Add(' where "con$auxiliar".ID_COMPROBANTE =:"ID_COMPROBANTE" and');
                  sql.Add('"con$auxiliar".ID_AGENCIA =:"ID_AGENCIA"');
                  parambyname('ID_COMPROBANTE').AsInteger := id_comprobante;
                  parambyname('ID_AGENCIA').AsInteger:= agencia;
                  Open;
                  Queryauxcierre.Last;
                  Queryauxcierre.First;
                  While not queryauxcierre.Eof do
                   begin
                     mes := monthof(vfechacierre);
                     mescierre := formatcurr('00',mes);
                     codigo := FieldByName('CODIGO').AsString;
                     debito := FieldByName('DEBITO').AsCurrency;
                     credito := FieldByName('CREDITO').AsCurrency;
                     cuenta := trim(FieldByName('ID_CUENTA').AsString);
                     colocacion := trim(FieldByName('ID_COLOCACION').AsString);
                     id := FieldByName('ID_IDENTIFICACION').AsInteger;
                     identificacion := trim(FieldByName('ID_PERSONA').AsString);
                     estadoaux := FieldByName('ESTADOAUX').AsString;
// Verificar Cuenta
                       IBSQLcierre.Close;
                       IBSQLcierre.SQL.Clear;
                       IBSQLcierre.SQL.Add('select * from "con$puc" where ID_AGENCIA = :ID_AGENCIA and CODIGO = :CODIGO');
                       IBSQLcierre.ParamByName('ID_AGENCIA').AsInteger := Agencia;
                       IBSQLcierre.ParamByName('CODIGO').AsString := codigo;
                       try
                        IBSQLcierre.ExecQuery;
                        if IBSQLcierre.RecordCount < 1 then
                         with IBSQLcierre1 do
                          begin
                           Close;
                           sql.Clear;
                           sql.Add('insert into "con$errorcierrecomp" (');
                           sql.Add('"con$errorcierrecomp"."ID_AGENCIA",');
                           sql.Add('"con$errorcierrecomp"."ID_COMPROBANTE",');
                           sql.Add('"con$errorcierrecomp"."ERROR")');
                           sql.Add(' values(');
                           sql.Add(':"ID_AGENCIA",:"ID_COMPROBANTE",:"ERROR")');
                           ParamByName('ID_AGENCIA').AsInteger := agencia;
                           ParamByName('ID_COMPROBANTE').AsInteger := id_comprobante;
                           ParamByName('ERROR').AsString := 'La Cuenta' + ' ' + codigo + ' ' + 'No Existe';
                           ExecQuery;
                           vcodigo := false;
                           Close;
                          end;
                       except
                         raise;
                       end;
// Fin verificar cuenta
                     IBSQLcierre.Close;
                     if estadoaux = 'O' then
                      begin
                        if (cuenta <> '') and (cuenta <> '0') then
                         begin
                           with IBSQLcierre do
                            begin
                              Sql.Clear;
                              Sql.Add('Select');
                              Sql.Add('"cap$tipocaptacion".ID_TIPO_CAPTACION');
                              Sql.Add('from "cap$tipocaptacion"');
                              Sql.Add('where "cap$tipocaptacion".CODIGO_CONTABLE =:"CODIGO_CONTABLE"');
                              ParamByName('CODIGO_CONTABLE').AsString := Codigo;
                              ExecQuery;
                              if RecordCount > 0 then begin
                               TipoCaptacion := FieldByName('ID_TIPO_CAPTACION').AsInteger;
                               DigitoC := DigitoControl(TipoCaptacion,formatcurr('0000000',StrToCurr(cuenta)));
                               IBSQLcierre.Close;

                               Sql.Clear;
                               Sql.Add('select');
                               Sql.Add('"cap$maestrotitular".NUMERO_CUENTA');
                               Sql.Add('from "cap$maestrotitular"');
                               Sql.Add('where');
                               Sql.Add('"cap$maestrotitular".ID_AGENCIA =:"ID_AGENCIA" and');
                               Sql.Add('"cap$maestrotitular".ID_TIPO_CAPTACION =:"ID_TIPO_CAPTACION" and');
                               Sql.Add('"cap$maestrotitular".NUMERO_CUENTA =:"NUMERO_CUENTA" and');
                               Sql.Add('"cap$maestrotitular".DIGITO_CUENTA =:"DIGITO_CUENTA"');
                               ParamByName('ID_AGENCIA').AsInteger := Agencia;
                               ParamByName('ID_TIPO_CAPTACION').AsInteger := TipoCaptacion;
                               ParamByName('NUMERO_CUENTA').AsString := cuenta;
                               ParamByName('DIGITO_CUENTA').AsString := DigitoC;
                               ExecQuery;
                               if not (IBSQLcierre.RecordCount > 0) then
                                 with IBSQLcierre1 do
                                  begin
                                    sql.Clear;
                                    sql.Add('insert into "con$errorcierrecomp" (');
                                    sql.Add('"con$errorcierrecomp"."ID_AGENCIA",');
                                    sql.Add('"con$errorcierrecomp"."ID_COMPROBANTE",');
                                    sql.Add('"con$errorcierrecomp"."ERROR")');
                                    sql.Add(' values(');
                                    sql.Add(':"ID_AGENCIA",:"ID_COMPROBANTE",:"ERROR")');
                                    ParamByName('ID_AGENCIA').AsInteger := agencia;
                                    ParamByName('ID_COMPROBANTE').AsInteger := id_comprobante;
                                    ParamByName('ERROR').AsString := 'La Captación' + ' ' + cuenta + ' ' + 'No Existe';
                                    ExecQuery;
                                    vcuenta := false;
                                    Close;
                                  end;
                               end;
                              IBSQLcierre.Close;
                            end;
                         end;

                        with IBSQLcierre do
                         begin
                           Close;
                           sql.Clear;
                           sql.Add('select ID_COLOCACION from "col$colocacion"');
                           sql.Add('where "col$colocacion".ID_AGENCIA =:"ID_AGENCIA" and');
                           sql.Add('"col$colocacion".ID_COLOCACION =:"ID_COLOCACION"');
                           ParamByName('ID_AGENCIA').AsInteger := Agencia;
                           ParamByName('ID_COLOCACION').AsString:= colocacion;
                           ExecQuery;
                           if colocacion <> '' then
                            begin
                              if not (RecordCount > 0) then
                                 with IBSQLcierre1 do
                                  begin
                                    sql.Clear;
                                    sql.Add('insert into "con$errorcierrecomp" (');
                                    sql.Add('"con$errorcierrecomp"."ID_AGENCIA",');
                                    sql.Add('"con$errorcierrecomp"."ID_COMPROBANTE",');
                                    sql.Add('"con$errorcierrecomp"."ERROR")');
                                    sql.Add(' values(');
                                    sql.Add(':"ID_AGENCIA",:"ID_COMPROBANTE",:"ERROR")');
                                    ParamByName('ID_AGENCIA').AsInteger := agencia;
                                    ParamByName('ID_COMPROBANTE').AsInteger := id_comprobante;
                                    ParamByName('ERROR').AsString := 'El Crédito' + ' ' + colocacion + ' ' + 'No Existe';
                                    ExecQuery;
                                    vcredito := false;
                                    Close;
                                  end;
                            end;
                           close;
                         end;

                        with IBSQLcierre do
                         begin
                           sql.Clear;
                           sql.Add('select ID_IDENTIFICACION, ID_PERSONA from "gen$persona"');
                           sql.Add('where "gen$persona".ID_IDENTIFICACION =:"ID_IDENTIFICACION" and');
                           sql.Add('"gen$persona".ID_PERSONA =:"ID_PERSONA"');
                           ParamByName('ID_IDENTIFICACION').AsInteger:= id;
                           ParamByName('ID_PERSONA').AsString:= identificacion;
                           ExecQuery;
                           if (id <> 0) and (identificacion <> '') then
                            begin
                              if not (RecordCount > 0) then
                                 with IBSQLcierre1 do
                                   begin
                                     sql.Clear;
                                     sql.Add('insert into "con$errorcierrecomp" (');
                                     sql.Add('"con$errorcierrecomp"."ID_AGENCIA",');
                                     sql.Add('"con$errorcierrecomp"."ID_COMPROBANTE",');
                                     sql.Add('"con$errorcierrecomp"."ERROR")');
                                     sql.Add(' values(');
                                     sql.Add(':"ID_AGENCIA",:"ID_COMPROBANTE",:"ERROR")');
                                     ParamByName('ID_AGENCIA').AsInteger := agencia;
                                     ParamByName('ID_COMPROBANTE').AsInteger  := id_comprobante;
                                     ParamByName('ERROR').AsString := 'El NIT/CC' + ' ' + identificacion + ' ' + 'No Existe';
                                     ExecQuery;
                                     vpersona := false;
                                     Close;
                                   end;
                            end;
                           close;
                         end;

                        if vcuadrado and vcodigo and vcuenta and vcredito and vpersona then
                         begin
                           with IBSQLcierre do
                             begin
                               sql.Clear;
                               sql.Add('update "con$saldoscuenta" set ');
                               sql.Add('"con$saldoscuenta"."DEBITO" ="con$saldoscuenta"."DEBITO" + :"DEBITO",');
                               sql.Add('"con$saldoscuenta"."CREDITO" ="con$saldoscuenta"."CREDITO" + :"CREDITO"');
                               sql.Add(' where ');
                               sql.Add('"con$saldoscuenta"."ID_AGENCIA" =:"ID_AGENCIA" and');
                               sql.Add('"con$saldoscuenta"."CODIGO" =:"CODIGO" and');
                               sql.Add('"con$saldoscuenta"."MES" =:"MES"');
                               ParamByName('ID_AGENCIA').AsInteger := agencia;
                               ParamByName('CODIGO').AsString := codigo;
                               ParamByName('MES').AsString := mescierre;
                               ParamByName('DEBITO').AsCurrency := debito;
                               ParamByName('CREDITO').AsCurrency := credito;
                               ExecQuery;
                               if RowsAffected < 1 then begin
                                 Close;
                                 SQL.Clear;
                                 SQL.Add('insert into "con$saldoscuenta" values (:ID_AGENCIA,:CODIGO,:MES,:DEBITO,:CREDITO)');
                                 ParamByName('ID_AGENCIA').AsInteger := agencia;
                                 ParamByName('CODIGO').AsString := codigo;
                                 ParamByName('MES').AsString := mescierre;
                                 ParamByName('DEBITO').AsCurrency := debito;
                                 ParamByName('CREDITO').AsCurrency := credito;
                                 ExecQuery;
                               end;
                               Close;
                             end;
                            with IBSQLcierre1 do
                             begin
                               sql.Clear;
                               sql.Add('update "con$auxiliar" set ');
                               sql.Add('"con$auxiliar"."ESTADOAUX" =:"ESTADOAUX"');
                               sql.Add(' where ');
                               sql.Add('"con$auxiliar"."ID_AGENCIA" =:"ID_AGENCIA" and');
                               sql.Add('"con$auxiliar"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
                               ParamByName('ID_AGENCIA').AsInteger := agencia;
                               ParamByName('ID_COMPROBANTE').AsInteger := id_comprobante;
                               ParamByName('ESTADOAUX').AsString := 'C';
                               ExecQuery;
                               Close;
                             end;
                           vcierreaux := true;
                         end;  // fin de if cuenta,credito y persona

                      end; //fin de auxiliar abierto
                     vcodigo := True;
                     vcuadrado := true;
                     vcuenta := true;
                     vcredito := true;
                     vpersona := true;
                     next;
                   end;  // fin de while auxiliar
                  Close;
                end;  //fin with auxiliar

               if vcierreaux = True then
                   with IBSQLcierre do
                     begin
                       sql.Clear;
                       sql.Add('update "con$comprobante" set ');
                       sql.Add('"con$comprobante"."ESTADO" =:"ESTADO"');
                       sql.Add(' where ');
                       sql.Add('"con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA" and');
                       sql.Add('"con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
                       ParamByName('ID_AGENCIA').AsInteger := agencia;
                       ParamByName('ID_COMPROBANTE').AsInteger := id_comprobante;
                       ParamByName('ESTADO').AsString := 'C';
                       ExecQuery;
                       Close;
                     end;
            end //fin de comprobante abierto
         else if estado = 'C' then
            begin
              with IBSQLcierre do
               begin
                 sql.Clear;
                 sql.Add('insert into "con$errorcierrecomp" (');
                 sql.Add('"con$errorcierrecomp"."ID_AGENCIA",');
                 sql.Add('"con$errorcierrecomp"."ID_COMPROBANTE",');
                 sql.Add('"con$errorcierrecomp"."ERROR")');
                 sql.Add(' values(');
                 sql.Add(':"ID_AGENCIA",:"ID_COMPROBANTE",:"ERROR")');
                 ParamByName('ID_AGENCIA').AsInteger := agencia;
                 ParamByName('ID_COMPROBANTE').AsInteger  := id_comprobante;
                 ParamByName('ERROR').AsString := 'El Comprobante está Cerrado';
                 ExecQuery;
                 close;
               end;
            end
         else if estado = 'N' then
            begin
              with IBSQLcierre do
               begin
                 sql.Clear;
                 sql.Add('insert into "con$errorcierrecomp" (');
                 sql.Add('"con$errorcierrecomp"."ID_AGENCIA",');
                 sql.Add('"con$errorcierrecomp"."ID_COMPROBANTE",');
                 sql.Add('"con$errorcierrecomp"."ERROR")');
                 sql.Add(' values(');
                 sql.Add(':"ID_AGENCIA",:"ID_COMPROBANTE",:"ERROR")');
                 ParamByName('ID_AGENCIA').AsInteger := agencia;
                 ParamByName('ID_COMPROBANTE').AsInteger := id_comprobante;
                 ParamByName('ERROR').AsString := 'El Comprobante está Anulado';
                 ExecQuery;
                 close;
               end;
            end;
          next;
         end; //fin de While comprobante
      frmProgreso.Cerrar;
      with IBSQLcierre do
       begin
         sql.Clear;
         sql.Add('select * from "con$errorcierrecomp"');
         ExecQuery;
         if IBSQLcierre.RecordCount > 0 then
          begin
            vcierre := false;
            MessageDlg('Error al Efectuar Cierre',mterror,[mbok],0);
            BtnReporteClick(sender);
            Close;
            Transaction.RollbackRetaining;
          end
          else
          begin
            close;
            Transaction.CommitRetaining;
            if ReCalculoSaldosGenerales then
               BtnReporteClick(Sender)
            else
               MessageDlg('Error al Efectuar Cierre',mterror,[mbok],0);
          end;
       end;

    end;  // fin de with comprobante
   Except
            MessageDlg('Error al Efectuar Cierre',mterror,[mbok],0);
            DmGeneral.IBTransaction1.RollbackRetaining;
            raise;
   End;

end;

procedure Tfrmcierredia.editfechacierreExit(Sender: TObject);
begin
        fecha := editfechacierre.Date;
        vfechacierre := fecha;
end;

procedure Tfrmcierredia.FormShow(Sender: TObject);
begin
        lerror := Tlist.Create;
end;

procedure Tfrmcierredia.BtnReporteClick(Sender: TObject);
begin
        if vcierre = True then
         begin
           with IBQRepnormal do
            begin
              if Transaction.InTransaction then
                 Transaction.Rollback;
              Transaction.StartTransaction;
              sql.Clear;
              sql.Add('Select "con$comprobante".ID_AGENCIA,');
              sql.Add('"con$comprobante".ID_COMPROBANTE,');
              sql.Add('"con$comprobante".FECHADIA,');
              sql.Add('"con$comprobante".TOTAL_DEBITO,');
              sql.Add('"con$comprobante".TOTAL_CREDITO,');
              sql.Add('"con$comprobante".ESTADO');
              sql.Add('from "con$comprobante"');
              sql.Add('where ');
              sql.Add('"con$comprobante"."FECHADIA" =:"FECHADIA" and');
              sql.Add('"con$comprobante"."ESTADO" =:"ESTADO"');
              ParamByName('FECHADIA').AsDate := vfechacierre;
              ParamByName('ESTADO').AsString := 'C';
              open;
            end;
            Repnormal.Variables.ByName['empresa'].AsString := empresa;
            if Repnormal.PrepareReport then
               Repnormal.PreviewPreparedReport(true);
            IBQrepnormal.Close;
         end;

        if vcierre = False then
         begin
           with IBQRepanormal do
            begin
              sql.Clear;
              sql.Add('Select "con$errorcierrecomp".ID_AGENCIA,');
              sql.Add('"con$errorcierrecomp".ID_COMPROBANTE,');
              sql.Add('"con$errorcierrecomp".ERROR');
              sql.Add('from "con$errorcierrecomp"');
              open;
            end;
            Repanormal.Variables.ByName['empresa'].AsString := empresa;
            Repanormal.Variables.ByName['fechadia'].AsString := datetostr(vfechacierre);
            if Repanormal.PrepareReport then
               Repanormal.PreviewPreparedReport(true);
            IBQrepanormal.Close;
         end;

end;



procedure Tfrmcierredia.RepanormalUnknownObjFunction(Sender: TObject;
  Component: TComponent; const FuncName: String;
  const Parameters: TprVarsArray; ParametersCount: Integer;
  var Value: TprVarValue; var IsProcessed: Boolean);
var
  f : TField;
begin
 if (Component=IBQRepanormal) and
    (AnsiCompareText(FuncName,'IBQRepanormal.dato')=0) and
    (ParametersCount=1) then
  begin
    if _vAsString(Parameters[0]) = 'item' then
     begin
      f := IBQRepanormal.FindField('ID_CUENTA');
      if f <> nil then
       begin
         if trim(f.AsString) <> '' then
           value.vString := trim(f.AsString)
         else
         begin
           f := IBQRepanormal.FindField('ID_COLOCACION');
           if f <> nil then
              if trim(f.AsString) <> '' then
                value.vString := trim(f.AsString)
           else
           begin
             f := IBQRepanormal.FindField('ID_PERSONA');
             if f <> nil then
              if trim(f.AsString) <> '' then
                 value.vString := trim(f.AsString)
             else
             begin
             f := IBQRepanormal.FindField('ESTADO');
             if f <> nil then
              if trim(f.AsString) <> '' then
                 value.vString := trim(f.AsString)
               else
               begin
               f := IBQRepanormal.FindField('CUADRADO');
               if f <> nil then
                if trim(f.AsString) <> '' then
                   value.vString := trim(f.AsString)
                 else
                 if trim(f.AsString) = '' then
                    value.vString := '';
               end;
             end;
           end;
         end;
       IsProcessed := true;
       end;
     end;
  end;
end;

procedure Tfrmcierredia.editfechacierreEnter(Sender: TObject);
begin
        EditFechacierre.Date := Date;
end;

procedure Tfrmcierredia.editfechacierreKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure Tfrmcierredia.BtnSalirClick(Sender: TObject);
begin
        Close;
end;

procedure Tfrmcierredia.RecuperarTotales;
begin
        with IBSQL1 do begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          Close;
          try
            ExecQuery;
          except
            raise;
          end;

          while not Eof do begin
             Application.ProcessMessages;
             IBSQL2.Close;
             IBSQL2.ParamByName('ID_AGENCIA').AsInteger := 1;
             IBSQL2.ParamByName('ID_COMPROBANTE').AsInteger := FieldByName('ID_COMPROBANTE').AsInteger;
             try
              IBSQL2.ExecQuery;
             except
              raise;
             end;

             IBSQL3.Close;
             IBSQL3.ParamByName('ID_AGENCIA').AsInteger := 1;
             IBSQL3.ParamByName('ID_COMPROBANTE').AsInteger := FieldByName('ID_COMPROBANTE').AsInteger;
             IBSQL3.ParamByName('TOTAL_DEBITO').AsCurrency := IBSQL2.FieldByName('TOTAL_DEBITO').AsCurrency;
             IBSQL3.ParamByName('TOTAL_CREDITO').AsCurrency := IBSQL2.FieldByName('TOTAL_CREDITO').AsCurrency;
             try
               IBSQL3.ExecQuery;
             except
               raise;
             end;

             Next;
          end;
          Transaction.Commit;
        end;

end;

end.



