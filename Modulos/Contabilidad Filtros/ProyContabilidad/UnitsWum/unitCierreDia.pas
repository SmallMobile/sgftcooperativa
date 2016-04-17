unit unitCierreDia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBCustomDataSet, Buttons, ComCtrls, ExtCtrls, IBQuery,
  IBSQL, Dateutils, pr_Common, pr_Parser, sdXmlDocuments,pr_TxClasses,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IBDatabase,
  JvComponent, JvProgressDlg, FR_Class, frOLEExl, FR_DSet, FR_DBSet;

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
      TTotales = Record
        totaldebito: Currency;
        totalcredito: Currency;
end;

type
  Tfrmcierredia = class(TForm)
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
    IBSQLIva: TIBSQL;
    IBSQLCodigo: TIBSQL;
    IdTCPClient1: TIdTCPClient;
    IBTransaction1: TIBTransaction;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    editfechacierre: TDateTimePicker;
    JvProgreso: TJvProgressDlg;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    frOLEExcelExport1: TfrOLEExcelExport;
    procedure BtnAceptarClick(Sender: TObject);
    procedure editfechacierreExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnReporteClick(Sender: TObject);
    procedure RepanormalUnknownObjFunction(Sender: TObject;
      Component: TComponent; const FuncName: String;
      const Parameters: TprVarsArray; ParametersCount: Integer;
      var Value: TprVarValue; var IsProcessed: Boolean);
    procedure editfechacierreKeyPress(Sender: TObject; var Key: Char);
    procedure BtnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
  private
    _bOpcion :Boolean;
    function BuscaCodigo(vIdComprobante,vId: Integer;vPersona:string): integer;
    function ValidarTotales(idagencia,idcomp: integer): TTotales;
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
  //variables validaciíón movimientos de caja con agencias
  vErrorAgencia : string;
  vEvaluaAgencia :Boolean;
  ADoc: TsdXmlDocument;
  RDoc: TsdXmlDocument;
  Nodo,Anode:TXmlNode;
  Astream :TMemoryStream;

implementation

{$R *.dfm}

uses UnitDmGeneral, UnitGlobales;

procedure Tfrmcierredia.BtnAceptarClick(Sender: TObject);
var
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
Tcomp           : TTotales;
begin
   if _bOpcion then
   begin
     BtnReporte.Click;
     Exit;
   end;
   if IBTransaction1.InTransaction then
      IBTransaction1.Rollback;
   IBTransaction1.StartTransaction;
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
         MessageDlg('No Existen Notas Contables Abiertas para Cierre',mterror,[mbok],0);
         exit;
       end;
       JvProgreso.Maximum := querycompcierre.RecordCount;
       JvProgreso.Show;
        While not QueryCompcierre.Eof do
         begin
           id_comprobante := FieldByName('ID_COMPROBANTE').AsInteger;
           JvProgreso.Text := 'Comprobando Nota No: '+Format('%.7d',[id_comprobante]);
           JvProgreso.Value := Querycompcierre.RecNo;
           Application.ProcessMessages;
           agencia := FieldByName('ID_AGENCIA').AsInteger;
           estado := FieldByName('ESTADO').AsString;
           // Validar Totales del Comprobante
           Tcomp := validartotales(agencia,id_comprobante);
           // Totales Validados
           total_debito := Tcomp.totaldebito;
           total_credito:= Tcomp.totalcredito;
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
                     mes := MonthOf(vfechacierre);
                     mescierre := formatcurr('00',mes);
                     codigo := FieldByName('CODIGO').AsString;
                     debito := FieldByName('DEBITO').AsCurrency;
                     credito := FieldByName('CREDITO').AsCurrency;
                     cuenta := trim(FieldByName('ID_CUENTA').AsString);// si lleva registrado cuenta alguna
                     colocacion := trim(FieldByName('ID_COLOCACION').AsString);//si lleva amarrada una colocacion
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
// inicia verificacion de auxiliares con respecto a cuentas de ahorro pot WUM
                     IBSQLcierre.Close;
                     if estadoaux = 'O' then
                      begin
                         vcuenta := True;
                         vCredito := True;
                        with IBSQLcierre do
                        begin
                           vEvaluaAgencia := False;
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
                              begin
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
         JvProgreso.Close;
      with IBSQLcierre do
       begin
         sql.Clear;
         sql.Add('select * from "con$errorcierrecomp"');
         ExecQuery;
         if IBSQLcierre.RecordCount > 0 then
          begin
            vcierre := false;
            MessageDlg('No se logro hacer el Cierre, Favor Revise',mterror,[mbok],0);
            BtnReporteClick(sender);
            BtnAceptar.Enabled := False;
            _bOpcion := True;
            Close;
            Transaction.RollbackRetaining;
          end
          else
          begin
            close;
            Transaction.CommitRetaining;
            if ReCalculoSaldosGenerales then
            begin
               BtnReporteClick(Sender);
               BtnAceptar.Enabled := False;
               _bOpcion := True;
            end
            else
               MessageDlg('No se logro hacer el Cierre, Favor Revise',mterror,[mbok],0);
          end;
       end;

    end;  // fin de with comprobante
   Except
            MessageDlg('No se logro hacer el Cierre, Favor Revise',mterror,[mbok],0);
            IBTransaction1.Rollback;
            raise;
   End;

   IBTransaction1.Commit;

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
            frDBDataSet1.DataSet := IBQRepnormal;
            frReport1.LoadFromFile(_sRuta + 'Reportes\RepCierre.frf');
            frReport1.ShowReport;

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
            //Repanormal.Variables.ByName['empresa'].AsString := empresa;
            //Repanormal.Variables.ByName['fechadia'].AsString := datetostr(vfechacierre);
            //if Repanormal.PrepareReport then
            //   Repanormal.PreviewPreparedReport(true);
            frDBDataSet1.DataSet := IBQRepanormal;
            frReport1.LoadFromFile(_sRuta + 'Reportes\RepErrorCierre.frf');
            frReport1.ShowReport;

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

procedure Tfrmcierredia.editfechacierreKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure Tfrmcierredia.BtnSalirClick(Sender: TObject);
begin
        Close;

end;

function Tfrmcierredia.BuscaCodigo(vIdComprobante,vId: Integer;vPersona:string): integer;
begin
end;

function Tfrmcierredia.ValidarTotales(idagencia,idcomp: integer): TTotales;
var
  _queryAux:TIBSQL;
  _queryUpd:TIBSQL;
begin
  _queryAux := TIBSQL.Create(self);
  _queryUpd := TIBSQL.Create(self);

  _queryAux.Transaction := IBTransaction1;
  _queryAux.SQL.Clear;
  _queryAux.SQL.Add('select SUM(DEBITO) AS DEBITO, SUM(CREDITO) AS CREDITO from "con$auxiliar"');
  _queryAux.SQL.Add('where');
  _queryAux.SQL.Add('ID_AGENCIA = :ID_AGENCIA and ID_COMPROBANTE = :ID_COMPROBANTE');
  _queryAux.ParamByName('ID_AGENCIA').AsInteger := idagencia;
  _queryAux.ParamByName('ID_COMPROBANTE').AsInteger := idcomp;
  try
   _queryAux.ExecQuery;
   Result.totaldebito := _queryAux.FieldByName('DEBITO').AsCurrency;
   Result.totalcredito := _queryAux.FieldByName('CREDITO').AsCurrency;
   _queryAux.Close;
  except
    Result.totaldebito := 0;
    Result.totalcredito := 0;
    raise;
    Exit;
  end;

  _queryUpd.Transaction := IBTransaction1;
  _queryUpd.SQL.Clear;
  _queryUpd.SQL.Add('update "con$comprobante" ');
  _queryUpd.SQL.Add('SET TOTAL_DEBITO = :TOTAL_DEBITO,');
  _queryUpd.SQL.Add('TOTAL_CREDITO = :TOTAL_CREDITO');
  _queryUpd.SQL.Add('where ID_AGENCIA = :ID_AGENCIA ');
  _queryUpd.SQL.Add('and ID_COMPROBANTE = :ID_COMPROBANTE');
  _queryUpd.ParamByName('TOTAL_DEBITO').AsCurrency := Result.totaldebito;
  _queryUpd.ParamByName('TOTAL_CREDITO').AsCurrency := Result.totalcredito;
  _queryUpd.ParamByName('ID_AGENCIA').AsInteger := idagencia;
  _queryUpd.ParamByName('ID_COMPROBANTE').AsInteger := idcomp;
  try
   _queryUpd.ExecQuery;
   _queryUpd.Close;
  except
    raise;
    Exit;
  end;


end;

procedure Tfrmcierredia.FormCreate(Sender: TObject);
begin
        _bOpcion := False;
        EditFechacierre.Date := Date;
end;

procedure Tfrmcierredia.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'FECHA' then
           ParValue := editfechacierre.Date;
end;

end.



