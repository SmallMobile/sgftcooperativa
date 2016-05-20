unit UnitRealizaNomina;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DBCtrls, DB, IBCustomDataSet,
  IBQuery,Math, IBSQL, pr_Common, pr_TxClasses, IBDatabase,JclSysUtils,
  JvEdit, DBClient,jcldatetime,DateUtils, Grids, DBGrids;

type
  TFrmRealizaNomina = class(TForm)
    l: TPanel;
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    Bnomina: TBitBtn;
    Bcerrar: TBitBtn;
    DBLtiponomina: TDBLookupComboBox;
    DBtiponomina: TDataSource;
    IBtiponomina: TIBQuery;
    IBSQL1: TIBSQL;
    report10: TprTxReport;
    QueryComprobante: TIBQuery;
    QueryComprobanteID_COMPROBANTE: TIntegerField;
    QueryComprobanteFECHADIA: TDateField;
    QueryComprobanteDESCRIPCION: TMemoField;
    QueryComprobanteTOTAL_DEBITO: TIBBCDField;
    QueryComprobanteTOTAL_CREDITO: TIBBCDField;
    QueryComprobanteESTADO: TIBStringField;
    QueryComprobanteIMPRESO: TSmallintField;
    QueryComprobanteANULACION: TMemoField;
    QueryComprobanteDESCRIPCION1: TIBStringField;
    QueryAuxiliar: TIBQuery;
    QueryAuxiliarID_COMPROBANTE: TIntegerField;
    QueryAuxiliarID_AGENCIA: TSmallintField;
    QueryAuxiliarCODIGO: TIBStringField;
    QueryAuxiliarNOMBRE: TIBStringField;
    QueryAuxiliarDEBITO: TIBBCDField;
    QueryAuxiliarCREDITO: TIBBCDField;
    QueryAuxiliarID_CUENTA: TIBStringField;
    QueryAuxiliarID_COLOCACION: TIBStringField;
    QueryAuxiliarID_IDENTIFICACION: TSmallintField;
    QueryAuxiliarID_PERSONA: TIBStringField;
    QueryAuxiliarMONTO_RETENCION: TIBBCDField;
    QueryAuxiliarTASA_RETENCION: TFloatField;
    IBTransaction3: TIBTransaction;
    IBTransaction2: TIBTransaction;
    IBTransaction1: TIBTransaction;
    Label1: TLabel;
    IBbusbaempleado: TIBQuery;
    IBTransaction4: TIBTransaction;
    IBQuery1: TIBQuery;
    IBTransaction5: TIBTransaction;
    IBQTabla: TClientDataSet;
    IBQTablaCODIGO: TStringField;
    IBQTablaNOMBRE: TStringField;
    IBQTablaCREDCTA: TStringField;
    IBQTablaIDENTIFICACION: TStringField;
    IBQTablaDEBITO: TCurrencyField;
    IBQTablaCREDITO: TCurrencyField;
    IBQuery2: TIBQuery;
    IBTransaction6: TIBTransaction;
    cdsLibranza: TClientDataSet;
    cdsLibranzaIDAGENCIA: TIntegerField;
    cdsLibranzaVALOR: TCurrencyField;
    cdsLibranzaVALORL: TAggregateField;
    cdsLibranzaTIPO: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BnominaClick(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure report10PrintComplete(Sender: TObject);
  private
  opcion_nomina : Boolean;
  codigo_nominanuevo,tipo_nomina :Smallint;
  consecutivo,consec,nitempleado :Integer;
  valor_hora,valor_sueldo :Currency;
  valor_fsp,valor_pension :Currency;
  valor_retefuente :Currency;
  _bLibranza :Boolean;
  _cValorLibranza :Currency;
    procedure cancelarnomina;
    function dnomina(tipo_nom: integer): boolean;
    function extrae_nombre(tipo: integer): string;
    procedure auxiliar_con(codigo_puc, consecutivo: integer; tipo: string;
      valor: currency;cuenta:Integer; id_persona: string; id_identifcacion: integer;
      monto, tasa: currency);

    { Private declarations }
  public
  opcion_boton: Smallint;
    function agencia(tipo: integer): string;
    procedure consignar(cuenta: integer;valor:currency);
  published
    procedure actulizaobligaciones;
    procedure auxiliar(codigopuc,consec:Integer;tipo:string;valor:Currency);
    procedure comprobante;
    procedure actcomprobante;
    function prestacion(tipo, opcion: integer): currency;
    function aportes(nit, opcion: integer): currency;
    procedure reporte(tipodenomia:Smallint;report3: TprTxReport);
    procedure auxiliar1(codigopuc, consec: Integer; tipo: string;
      valor: Currency; cuenta: string);
    procedure actualizacuentas;
    { Public declarations }
  end;

var
  FrmRealizaNomina: TFrmRealizaNomina;

implementation

uses UnitQuerys,unitglobal,UnitPrincipal,unitdatamodulo, UnitNomina,
Unitdata, UnitdataQuerys, Unitvistapreliminar, UnitCartera, UnitGlobales,
  UnitPantallaProgreso, UnitdmColocacion, UnitdmGeneral;

{$R *.dfm}

procedure TFrmRealizaNomina.FormCreate(Sender: TObject);
var    a :Integer;
begin
        a := DaysInAMonth(YearOfDate(Date),MonthOfDate(Date));
        FrmQuerys := TFrmQuerys.Create(self);
        FrmCartera := TFrmCartera.Create(self);
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('select * from "nom$nomina"');
          SQL.Add('where "nom$nomina"."codigo_nomina"= :codigo');
          ParamByName('codigo').AsInteger := buscanomina(DataQuerys.IBdatos);
          Open;
          if RecordCount = 0 then
          begin
             opcion_nomina := True;
             l.Caption := 'Nomina del 01 de '+FormatDateTime('mmmm "al "'+IntToStr(a)+' " de" mmmm "de" yyyy',Date);
             BACEPTAR.Hint := 'Realiza la Nomina Referente al Mes: '+ FormatDateTime('mmmm',Date)+'.';
             BACEPTAR.Caption := '&Realizar';
          end
          else
          begin
             opcion_nomina := False;
             BACEPTAR.Hint := 'Registra Contablemente la Nomina de '+ FormatDateTime('mmmm',Date) + '.';
             BACEPTAR.Caption := 'R&egistrar';
             l.Caption := 'Nomina del 01 de ' + FormatDateTime('mmmm "al "'+IntToStr(a)+' " de" mmmm "de" yyyy',Date);
          end;
          Close;
          end;
end;

procedure TFrmRealizaNomina.BcerrarClick(Sender: TObject);
//var    nit:Integer;
begin
        Close;
end;

procedure TFrmRealizaNomina.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        IBtiponomina.Close;
end;

procedure TFrmRealizaNomina.BnominaClick(Sender: TObject);
var     cod_nomina :Smallint;
begin
        if opcion_boton = 1 then
          cancelarnomina
        else
        begin
          try
            if FrMain.RealizarNomina1.Visible = True then
               cod_nomina := buscanomina(DataQuerys.IBdatos)
            else
               cod_nomina := buscanomina(DataQuerys.IBdatos)-1;
            frmnomina := TFrmNomina.Create(self);
            verificatransaccion(FrmNomina.IBaportes);
            FrmNomina.IBtiponomina.ParamByName('codigo').AsInteger := dbltiponomina.KeyValue;
            FrmNomina.IBfechanomina.ParamByName('cod').AsInteger := cod_nomina;
            FrmNomina.IBfechanomina.Open;
            FrmNomina.IBfondos.ParamByName('tipo').AsInteger := DBLtiponomina.KeyValue;
            FrmNomina.IBfondos.ParamByName('codigo').AsInteger := cod_nomina;
            FrmNomina.IBfondos.Open;
            FrmNomina.IBaportes.ParamByName('tipo').AsInteger := DBLtiponomina.KeyValue;
            FrmNomina.IBaportes.ParamByName('codigo').AsInteger := cod_nomina;
            FrmNomina.IBaportes.Open;
            FrmNomina.IBnomina.Close;
            FrmNomina.frDBDataSet1.DataSet := FrmNomina.IBnomina;
            FrmNomina.IBnomina.ParamByName('codigo').AsInteger := cod_nomina;
            FrmNomina.IBnomina.ParamByName('tiponomina').AsInteger := DBLtiponomina.KeyValue;;
            FrmNomina.IBnomina.Open;
            FrmNomina.imprimir_reporte(frmain.wpath+'reportes\reprealizanomina.frf');
          except
          on e: Exception do
             MessageDlg('Debe Seleccionar un  tipo de Nomina',mtInformation,[mbok],0);
          end;
        end;
end;

procedure TFrmRealizaNomina.BACEPTARClick(Sender: TObject);
var
        valor_servicio,valor_aporte,total :Currency;
        valor_totalagencia,valor_nomina : Currency;
        valor_fondo,valor_riesgo :Currency;
        nit :Integer;
        codigo_puc :Variant;
begin
      codigo_nominanuevo := buscanomina(DataQuerys.IBselecion);
     if opcion_boton = 1 then
     begin
        if opcion_nomina then
        begin
          if dmGeneral.IBTransaction1.InTransaction then
             dmGeneral.IBTransaction1.Commit;
           dmGeneral.IBTransaction1.StartTransaction;
           BACEPTAR.Enabled := False;
           Bnomina.Enabled := False;
           FrmCartera.BarridoEmpleados;
           FrmNomina.realizanomina;
           FrmNomina.actfondo;
           FrmNomina.actdeduccion(1);
           FrmNomina.actdeduccion(2);
           opcion_nomina := False;
           BACEPTAR.Hint := 'Registra Contablemente la Nomina de '+ FormatDateTime('mmmm',Date)+'.';
           BACEPTAR.Caption := 'R&egistrar';
           FrmRealizaNomina.Close;
           FrMain.RegistrarNomina1.Click;
        end
        else
        begin
          if MessageDlg('Seguro de Registrar Contablemente la Nomina?',mtInformation,[mbYes,mbNo],0) = mrYes then // registrar nomina
          begin
          dmColocacion := TdmColocacion.Create(self);
          if dmGeneral.IBTransaction1.InTransaction then
             dmGeneral.IBTransaction1.Commit;
          dmGeneral.IBTransaction1.StartTransaction;
          with DataQuerys.IBdatos do
          begin
            Close;
            verificatransaccion(DataQuerys.IBdatos);
            SQL.Clear;
            SQL.Add('select * from "nomina"');
            SQL.Add('where "nomina"."mes" = :mes');
            ParamByName('mes').AsString := FormatDateTime('mm',date);
            Open;
            Close;
          end;
            with DataQuerys.IBaportes do
            begin
               Close;
               verificatransaccion(DataQuerys.IBaportes);
               SQL.Clear;
               SQL.Add('SELECT DISTINCT');
               SQL.Add('"nom$empleado"."tipo_nomina"');
               SQL.Add('FROM');
               SQL.Add('"nom$nomina"');
               SQL.Add('INNER JOIN "nom$empleado" ON ("nom$nomina"."nit_empleado" = "nom$empleado"."nitempleado")');
               //SQL.Add('where "nom$empleado"."nitempleado" = 27615950');
               //SQL.Add('where "nom$empleado"."tipo_nomina" in (10,20,30)');///ojo
               Open;
               Last;
               First;
               FrmProgresos := TFrmProgresos.Create(self);
               frmProgresos.Titulo := 'Espere Un Momento por Favor.';
               frmProgresos.Max := RecordCount;
               frmProgresos.Min := 0;
               frmProgresos.Ejecutar;
               while not Eof do  // while del busca empleado * tipo_nomina
               begin
                 frmProgresos.Position := DataQuerys.IBaportes.RecNo;
                 frmProgresos.InfoLabel := 'Registrando Nomina : '+extrae_nombre(DataQuerys.IBaportes.FieldByName('tipo_nomina').AsInteger);
                 Application.ProcessMessages;
                 tipo_nomina := DataQuerys.IBaportes.FieldByName('tipo_nomina').AsInteger;
                 total := 0;
                 comprobante; // crea el comprobante
                 
                 if tipo_nomina in [10,20] then
                 begin
//                   cdsLibranza.AggregatesActive := False;
//                   cdsLibranza.Filtered := False;
                   _bLibranza := False;
                   actualizacuentas;// inicio oficina ocaña
                   auxiliar(16,consecutivo,'D',nomina(DataQuerys.IBselecion,4,tipo_nomina,0));//transporte
                   valor_servicio := (nomina(DataQuerys.IBselecion,11,tipo_nomina,0) * prestacion(100,3) / prestacion(100,2));
                   auxiliar(3,consecutivo,'D',valor_servicio);//aportes salud
                   valor_servicio := (nomina(DataQuerys.IBselecion,10,tipo_nomina,0) * prestacion(200,3) / prestacion(200,2));
                   auxiliar(4,consecutivo,'D',valor_servicio);//aportes pension
                   with DataQuerys.IBingresa do
                   begin
                     Close;
                     verificatransaccion(DataQuerys.IBingresa);
                     SQL.Clear;
                     SQL.Add('select "nom$aportes"."nit"');
                     SQL.Add('from "nom$aportes"');
                     Open;
                     while not Eof do
                     begin
                       nit := FieldByName('nit').AsInteger;
                       valor_servicio := SimpleRoundTo(nomina(DataQuerys.IBselecion,18,tipo_nomina,0) * aportes(nit,1) / 100,0);
                       codigo_puc := aportes(nit,2);
                       auxiliar(codigo_puc,consecutivo,'D',valor_servicio);//aporte  a cajas de compensacion sena icbf
                       Next;
                     end;// fin segundo while
                     Close;
                   end;
                   //auxiliar(9,consecutivo,'C',nomina(DataQuerys.IBselecion,9,tipo_nomina,0)); //retefuente
                   with DataQuerys.IBingresa do
                   begin
                     Close;
                     verificatransaccion(DataQuerys.IBingresa);
                     SQL.Clear;
                     SQL.Add('SELECT DISTINCT');
                     SQL.Add('"nom$fondos"."codigopuc",');
                     SQL.Add('"nom$fondos"."valor_salud",');
                     SQL.Add('"nom$fondos"."valor_pension",');
                     SQL.Add('"nom$fondos"."fsp"');
                     SQL.Add('FROM');
                     SQL.Add('"nom$fondos"');
                     SQL.Add('where "nom$fondos"."deduccion" = 1');
                     SQL.Add('and "nom$fondos"."cod_nomina" = :cod_nomina');
                     SQL.Add('and "nom$fondos"."tipo_nomina" = :tipo_nomina');
                     ParamByName('cod_nomina').AsInteger := codigo_nominanuevo;
                     ParamByName('tipo_nomina').AsInteger := tipo_nomina;
                     Open;
                     while not Eof do
                     begin
                       if FieldByName('valor_salud').AsCurrency <> 0 then
                       begin
                         valor_servicio := FieldByName('valor_salud').AsCurrency * prestacion(100,1)/prestacion(100,2);
                         auxiliar(FieldByName('codigopuc').AsInteger,consecutivo,'C',valor_servicio);
                       end
                       else
                       begin
                         valor_servicio := FieldByName('valor_pension').AsCurrency * prestacion(200,1)/prestacion(200,2);
                         auxiliar(FieldByName('codigopuc').AsInteger,consecutivo,'C',valor_servicio + FieldByName('fsp').AsCurrency);
                        end;
                        Next;
                        end;// fin tercer while
                        Close;
                     end;//
                     with DataQuerys.IBselecion do
                     begin
                       Close;
                       verificatransaccion(DataQuerys.IBselecion);
                       SQL.Clear;
                       SQL.Add('SELECT DISTINCT');
                       SQL.Add('SUM("nom$fondos"."valor_salud") AS "total"');
                       SQL.Add('FROM');
                       SQL.Add('"nom$fondos"');
                       SQL.Add('WHERE');
                       SQL.Add('("nom$fondos"."deduccion" = 0) AND');
                       SQL.Add('("nom$fondos"."cod_nomina" = :codigo_nomina) AND');
                       SQL.Add('("nom$fondos"."tipo_nomina" = :tipo_nomina)');
                       ParamByName('codigo_nomina').AsInteger := codigo_nominanuevo;
                       ParamByName('tipo_nomina').AsInteger := tipo_nomina;
                       Open;
                       auxiliar(10,consecutivo,'C',FieldByName('total').AsCurrency);
                       Close;
                      end;
                   auxiliar(17,consecutivo,'C',nomina(DataQuerys.IBselecion,7,tipo_nomina,0));
                   valor_servicio := nomina(DataQuerys.IBdatos,18,tipo_nomina,0)*(valorhoraextra(DataQuerys.IBdatos,1)/100);// riesgos profesionales
                   auxiliar(20,consecutivo,'D',valor_servicio);
                   auxiliar(21,consecutivo,'C',valor_servicio);
                   valor_servicio := 0;
                   //Proceso de Cuentas Por cobrar y Libranzas
                   valor_servicio := nomina(DataQuerys.IBselecion,7,tipo_nomina,0)+nomina(DataQuerys.IBselecion,17,tipo_nomina,0);
                   //Validar Libranzas locales y de las agencias
                     auxiliar(54,consecutivo,'D',valor_servicio);// LIBRANZAS
                     auxiliar(54,consecutivo,'C',valor_servicio);// LIBRANZAS
                   //Fin proceso de Libranzas
                   // APORTES VOLUNTARIOS A PENSIONES
                   valor_servicio := 0;
                   valor_servicio := nomina(DataQuerys.IBselecion,19,tipo_nomina,0);
                   auxiliar(55,consecutivo,'C',valor_servicio);
//                   Exit;
                   //Libranzas de las Agencias
                   //if cdsLibranza.RecordCount > 0 then
                   begin
                     with DataQuerys.IBingresa do
                     begin
                       Close;
                       verificatransaccion(DataQuerys.IBingresa);
                       SQL.Clear;
                       SQL.Add('select * from "Inv$Agencia"');
                       Open;
                       while not Eof do
                       begin
                         cdsLibranza.Filter := 'IDAGENCIA = ' + FieldByName('cod_agencia').AsString + ' and TIPO = ' + IntToStr(tipo_nomina); ;
                         cdsLibranza.Filtered := True;
                         cdsLibranza.AggregatesActive := True;
                         try
                           _cValorLibranza := cdsLibranza.FieldByName('VALORL').AsVariant;
                         except
                           _cValorLibranza := 0;
                         end;
                         if _cValorLibranza > 0 then
                         begin
                           case FieldByName('cod_agencia').AsInteger of
                             2 : auxiliarcon(67,consecutivo,'C',_cValorLibranza);
                             3 : auxiliarcon(68,consecutivo,'C',_cValorLibranza);
                             4 : auxiliarcon(69,consecutivo,'C',_cValorLibranza);
                             5 : auxiliarcon(70,consecutivo,'C',_cValorLibranza);
                           end;
                         end;
                         Next;
                       end;
                     end;

                   end;
                   //Fin del if 
                   //FrmCartera.contable(IntToStr(consecutivo),tipo_nomina);// fin agencia central
                 end  // fin identifica nomina local
//** REGISTRO DE LOS MOVIMIENTOS DE LAS AGENCIAS NO LOCALES
                 else // nominas de las agencias
                 begin
//                 cdsLibranza.CancelUpdates;
                 with DataQuerys.IBingresa do // valor en salud y pension
                 begin
                     Close;
                     verificatransaccion(DataQuerys.IBingresa);
                     SQL.Clear;
                     SQL.Add('SELECT DISTINCT');
                     SQL.Add('"nom$fondos"."codigopuc",');
                     SQL.Add('"nom$fondos"."valor_salud",');
                     SQL.Add('"nom$fondos"."valor_pension",');
                     SQL.Add('"nom$fondos"."fsp"');
                     SQL.Add('FROM');
                     SQL.Add('"nom$fondos"');
                     SQL.Add('where "nom$fondos"."deduccion" = 1');
                     SQL.Add('and "nom$fondos"."cod_nomina" = :cod_nomina');
                     SQL.Add('and "nom$fondos"."tipo_nomina" = :tipo_nomina');
                     ParamByName('cod_nomina').AsInteger := codigo_nominanuevo;
                     ParamByName('tipo_nomina').AsInteger := tipo_nomina;
                     Open;
                     while not Eof do
                     begin
                       if FieldByName('valor_salud').AsCurrency <> 0 then
                       begin
                         valor_servicio := FieldByName('valor_salud').AsCurrency * prestacion(100,1)/prestacion(100,2);
                         auxiliar(FieldByName('codigopuc').AsInteger,consecutivo,'C',valor_servicio);
                       end
                       else
                       begin
                         valor_servicio := FieldByName('fsp').AsCurrency + FieldByName('valor_pension').AsCurrency * prestacion(200,1)/prestacion(200,2);
                         auxiliar(FieldByName('codigopuc').AsInteger,consecutivo,'C',valor_servicio);
                        end;
                        Next;
                        total := total + valor_servicio; // total aportes en salud y pension
                        end;// fin tercer while
                        Close;
                     end;// fin actualiza cuentas de valor pension y salud
                     with DataQuerys.IBingresa do // busca total aportes
                     begin
                        Close;
                        verificatransaccion(DataQuerys.IBingresa);
                        SQL.Clear;
                        SQL.Add('select sum("nom$fondos"."valor_salud") as fondo');
                        SQL.Add('from "nom$fondos"');
                        SQL.Add('where "nom$fondos"."deduccion" = 0 and');
                        SQL.Add('"nom$fondos"."cod_nomina" = :cod_nomina and');
                        SQL.Add('"nom$fondos"."tipo_nomina" = :tipo_nomina');
                        ParamByName('cod_nomina').AsInteger := codigo_nominanuevo;
                        ParamByName('tipo_nomina').AsInteger := tipo_nomina;
                        Open;
                        valor_aporte := FieldByName('fondo').AsCurrency;
                        auxiliar(10,consecutivo,'C',valor_aporte);
                        Close;
                     end; // fin busca aportes
                     valor_riesgo := SimpleRoundTo((nomina(DataQuerys.IBingresa,18,tipo_nomina,0) * valorhoraextra(DataQuerys.IBingresa,1)/100),0);// ajustado al valor del ibc
                     valor_nomina := nomina(DataQuerys.IBingresa,15,tipo_nomina,0); // acredita las agencias
                     valor_totalagencia := valor_aporte + total + valor_nomina + valor_riesgo + nomina(DataQuerys.IBselecion,7,tipo_nomina,0) + nomina(DataQuerys.IBingresa,17,tipo_nomina,0) + nomina(DataQuerys.IBingresa,9,tipo_nomina,0);//debita las agencias
                     // agencia convencio D
                     if tipo_nomina = 40 then
                       auxiliar(22,consecutivo,'D',valor_totalagencia)
                     else if tipo_nomina = 30 then
                       auxiliar(38,consecutivo,'D',valor_totalagencia)
                     else if tipo_nomina = 50 then
                       auxiliar(57,consecutivo,'D',valor_totalagencia)
                     else if tipo_nomina = 60 then
                       auxiliar(65,consecutivo,'D',valor_totalagencia); //SANTA
                     // aportes a riesgos;
                     auxiliar(21,consecutivo,'C',valor_riesgo);
                     if dnomina(tipo_nomina) then // si esta afiliado al fondo de empleados
                     begin
                       with DataQuerys.IBingresa do
                       begin
                         Close;
                         verificatransaccion(DataQuerys.IBingresa);
                         SQL.Clear;
                         SQL.Add('select "nom$tiponomina"."valor","nom$tiponomina"."cuenta"');
                         SQL.Add('from "nom$tiponomina"');
                         SQL.Add('where "nom$tiponomina"."codigo" = :codigo');
                         ParamByName('codigo').AsInteger := tipo_nomina;
                         Open;
                         valor_fondo := FieldByName('valor').AsCurrency;
                         valor_nomina := valor_nomina - valor_fondo;
                         auxiliar1(8,consecutivo,'C',valor_fondo,FieldByName('cuenta').AsString);  // ahorro ordinario
                         //auxiliar_con(8,consecutivo,'C',valor_fondo,FieldByName('cuenta').AsInteger,
                         consignar(FieldByName('cuenta').AsVariant,valor_fondo);
                         Close;
                       end;
                       end;// fin busca fondo

                       // registras en cuentas de ahorro ordinario
                       with DataQuerys.IBingresa do
                       begin
                         Close;
                         verificatransaccion(DataQuerys.IBingresa);
                         SQL.Clear;
                         SQL.Add('SELECT');
                         SQL.Add('"nom$empleado"."numero_cuenta","nom$empleado"."nitempleado"');
                         SQL.Add('FROM');
                         SQL.Add('"nom$empleado"');
                         SQL.Add('WHERE');
                         SQL.Add('("nom$empleado"."tipo_nomina" = :tipo)');
                         ParamByName('tipo').AsInteger := tipo_nomina;
                         Open;
                         while not Eof do
                         begin
                             nitempleado := FieldByName('nitempleado').AsInteger;
                             valor_retefuente := retefuente(DataQuerys.IBselecion,nitempleado,1,(descuento(IBQuery1,nitempleado,2) + horaextra(IBQuery1,nitempleado)));
                             valor_hora := nomina(DataQuerys.IBselecion,3,tipo_nomina,nitempleado);
                             valor_sueldo := nomina(DataQuerys.IBselecion,2,tipo_nomina,nitempleado);
                             valor_fsp := SimpleRoundTo(fsp(DataQuerys.IBselecion,nitempleado),0);
                             valor_pension := SimpleRoundTo(deduccion(DataQuerys.IBselecion,200,nitempleado),0);
                             obligacion(11,nitempleado,(valor_pension + selobligacion(11,nitempleado)));
                             obligacion(12,nitempleado,(valor_pension + selobligacion(12,nitempleado)));
                             obligacion(1,nitempleado,(valor_sueldo + selobligacion(1,nitempleado)));
                             obligacion(2,nitempleado,(valor_hora + selobligacion(2,nitempleado)));
                             if valor_retefuente > 0 then
                                auxiliar_con(9,consecutivo,'C',valor_retefuente,0,IntToStr(nitempleado),3,tasaretefuente(nitempleado).monto,tasaretefuente(nitempleado).tasa);//retefuente
//                             auxiliar(9,consecutivo,'C',nomina(DataQuerys.IBselecion,9,tipo_nomina,0));

                           if FieldByName('numero_cuenta').AsInteger <> 0  then
                           begin
                             auxiliar_con(8,consecutivo,'C',nomina(IBQuery1,12,tipo_nomina,FieldByName('nitempleado').AsInteger),FieldByName('numero_cuenta').AsInteger,FieldByName('nitempleado').AsString ,3,0,0);
                             //auxiliar1(8,consecutivo,'C',nomina(IBQuery1,12,tipo_nomina,FieldByName('nitempleado').AsInteger),FieldByName('numero_cuenta').AsString);  // ahorro ordinario;
                             valor_nomina := valor_nomina - nomina(IBQuery1,12,tipo_nomina,FieldByName('nitempleado').AsInteger);
                             consignar(FieldByName('numero_cuenta').AsVariant,nomina(IBQuery1,12,tipo_nomina,FieldByName('nitempleado').AsInteger));
                           end
                           else //validacion para empleados de otras oficinas
                           begin
                             //Llenar valores de Libranza de Oficinas
                             _cValorLibranza := nomina(DataQuerys.IBselecion,6,tipo_nomina,DataQuerys.IBingresa.FieldByName('nitempleado').AsInteger);
                             if _cValorLibranza > 0 then
                             begin
                               with cdsLibranza do
                               begin
                                 Append;
                                 cdsLibranza.FieldValues['IDAGENCIA'] := vCodigoPucCXC(DataQuerys.IBingresa.FieldByName('nitempleado').AsInteger,1);
                                 cdsLibranza.FieldValues['VALOR'] := _cValorLibranza;
                                 cdsLibranza.FieldValues['TIPO'] := tipo_nomina;
                                 post;
                               end;
                            end;

                             if vCodigoPuc(nitempleado) <> -1 then
                             begin
                               auxiliarcon(vCodigoPuc(nitempleado),consecutivo,'C',nomina(IBQuery1,12,tipo_nomina,FieldByName('nitempleado').AsInteger));
                               valor_nomina := valor_nomina - nomina(IBQuery1,12,tipo_nomina,FieldByName('nitempleado').AsInteger);
                             end;
                           end;
                           Next;
                         end;
                         Close;
                       end;

                       //Descontar Libranzas
//                   if cdsLibranza.RecordCount > 0 then
                   begin
                     with DataQuerys.IBingresa do
                     begin
                       Close;
                       verificatransaccion(DataQuerys.IBingresa);
                       SQL.Clear;
                       SQL.Add('select * from "Inv$Agencia"');
                       Open;
                       while not Eof do
                       begin
                         cdsLibranza.Filtered := False;                       
                         cdsLibranza.Filter := 'IDAGENCIA = ' + FieldByName('cod_agencia').AsString + ' and TIPO = ' + IntToStr(tipo_nomina); ;;
                         cdsLibranza.Filtered := True;
                         cdsLibranza.AggregatesActive := True;
                         try
                           _cValorLibranza := cdsLibranza.FieldByName('VALORL').AsVariant;
                         except
                           _cValorLibranza := 0;
                         end;
                         if _cValorLibranza > 0 then
                         begin
                           //valor_nomina := valor_nomina - _cValorLibranza;
                           case FieldByName('cod_agencia').AsInteger of
                             2 : auxiliarcon(67,consecutivo,'C',_cValorLibranza);
                             3 : auxiliarcon(68,consecutivo,'C',_cValorLibranza);
                             4 : auxiliarcon(69,consecutivo,'C',_cValorLibranza);
                             5 : auxiliarcon(70,consecutivo,'C',_cValorLibranza);
                           end;  // Fin del Case
                         end; //Fin del If _cValorLibranza
                         //cdsLibranza.AggregatesActive := False;
                         Next;
                       end; // fin del While
                     end; //fin del With
                   end; // Fin del With CdsLibranza
                       //Registra el Total de la Nomina

                       if tipo_nomina = 40 then
                         auxiliar(22,consecutivo,'C',valor_nomina)
                       else if tipo_nomina = 30 then
                         auxiliar(38,consecutivo,'C',valor_nomina)
                       else if tipo_nomina = 50 then
                         auxiliar(57,consecutivo,'C',valor_nomina)
                       else if tipo_nomina = 60 then
                         auxiliar(65,consecutivo,'C',valor_nomina); //SANTA

                       auxiliar(17,consecutivo,'C',nomina(DataQuerys.IBselecion,7,tipo_nomina,0));
//                       FrmCartera.contable(IntToStr(consecutivo),tipo_nomina);// fin agencia central
                       /// posible liquidacion de cartera para las agencias
                   //auxiliar(9,consecutivo,'C',nomina(DataQuerys.IBselecion,9,tipo_nomina,0));
                   valor_servicio := 0;
                   valor_servicio := nomina(DataQuerys.IBselecion,7,tipo_nomina,0)+nomina(DataQuerys.IBselecion,17,tipo_nomina,0);
                   //auxiliar(54,consecutivo,'D',valor_servicio);
                   //auxiliar(54,consecutivo,'C',valor_servicio);
                 end;
                 FrmCartera.contable(IntToStr(consecutivo),tipo_nomina);
                 actcomprobante;
                 Application.ProcessMessages;
               Next;
             end;
             Close;
             frmProgresos.Cerrar;
           end;
           with DataQuerys.IBselecion do
           begin
             Close;
             verificatransaccion(DataQuerys.IBselecion);
             SQL.Clear;
             SQL.Add('select max("nom$controlnomina"."cod_nomina") as codigo');
             SQL.Add('from "nom$controlnomina"');
             Open;
             codigo_nominanuevo := FieldByName('codigo').AsInteger;
             SQL.Clear;
             SQL.Add('update "nom$controlnomina"');
             SQL.Add('set "nom$controlnomina"."liquidada" = 1' );
             SQL.Add('where "nom$controlnomina"."cod_nomina" = :codigo_nomina');
             ParamByName('codigo_nomina').AsInteger := codigo_nominanuevo;
             Open;
             SQL.Clear;
             SQL.Add('insert into "nom$controlnomina"');
             SQL.Add('values (');
             SQL.Add(':cod_nomina,:fecha,0)');
             ParamByName('cod_nomina').AsInteger := codigo_nominanuevo+1;
             ParamByName('fecha').AsDateTime := StrToDateTime(FormatDateTime('yyyy/mm/01',Date+25));
             Open;
             Close;
             Transaction.Commit;
             BACEPTAR.Enabled := False;
             actualiza_fondo;
          end;
        end;
      end;
     end
    else
       begin
        try
          reporte(DBltiponomina.KeyValue,report10);
        except
        on E: Exception do
          MessageDlg('Debe Seleccionar un Tipo de Nomina',mtInformation,[mbok],0)
        end;
       end;
end;

procedure TFrmRealizaNomina.auxiliar(codigopuc,consec:Integer;tipo:string;valor:Currency);
var     codigo :string;
        debito,credito :Currency;
begin
        debito := 0;
        credito := 0;
        if tipo = 'D' then
           debito := valor
        else
           credito := valor;
        if (debito <> 0) or (credito <> 0) then
        begin
          with DataQuerys.IBselecion do
          begin
            Close;
            verificatransaccion(DataQuerys.IBselecion);
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"nom$pucbasico"."codigo",');
            SQL.Add('"nom$pucbasico"."descripcion"');
            SQL.Add('FROM');
            SQL.Add('"nom$pucbasico"');
            SQL.Add('WHERE');
            SQL.Add('("nom$pucbasico"."id" = :codigo)');
            ParamByName('codigo').AsInteger := codigopuc;
            Open;
            codigo := FieldByName('codigo').AsString;
            Close;
            Transaction.Commit;
         end;
          with FrmQuerys.IBregistro do
          begin
            Close;
            verificatransaccion(FrmQuerys.IBregistro);
            SQL.Clear;
            SQL.Add('insert into "con$auxiliar" values (');
            SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
            SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
            SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
            ParamByName('ID_COMPROBANTE').asInteger := consec;
            ParamByName('ID_AGENCIA').AsInteger := 1;
            ParamByName('FECHA').AsDate := Date;
            ParamByName('CODIGO').AsString := codigo;
            ParamByName('DEBITO').AsCurrency := SimpleRoundTo(debito,0);
            ParamByName('CREDITO').AsCurrency := SimpleRoundTo(credito,0);
            ParamByName('ID_CUENTA').Clear;
            ParamByName('ID_COLOCACION').AsString := '';
            ParamByName('ID_IDENTIFICACION').AsInteger := 0;
            ParamByName('ID_PERSONA').AsString :='0';
            ParamByName('MONTO_RETENCION').AsCurrency := 0;
            ParamByName('TASA_RETENCION').AsFloat := 0;
            ParamByName('ESTADOAUX').AsString := 'O';
            Open;
            Close;
            Transaction.Commit;
          end;
         end;
end;

procedure TFrmRealizaNomina.comprobante;
var     cadena:string;
        tipo_comprobante :Integer;
begin
        if tipo_nomina in [10,20] then
        begin
          cadena := 'PAGO GTOS NOMINA DE '+FormatDateTime('MMM "de" yyyy',Date)+ ' DESC. LABORAL CONSIG. AHORROS N. '+agencia(tipo_nomina);
          tipo_comprobante := 1
        end
        else
        begin
          cadena := 'TRASL GTOS NOMINA DE ' + agencia(tipo_nomina) + ' DESC. LABORAL Y OTROS CONSIG. AHORROS SEGUN ANEXO';
          tipo_comprobante := 2;
        end;
        consecutivo := ObtenerConsecutivo(FrmQuerys.IBSQL1);
        with FrmQuerys.IBregistro do
        begin
        verificatransaccion(FrmQuerys.IBregistro);
          SQL.Clear;
          SQL.Add('insert into "con$comprobante" ("con$comprobante"."ID_COMPROBANTE",');
          SQL.Add('"con$comprobante"."FECHADIA", "con$comprobante"."TIPO_COMPROBANTE",');
          SQL.Add('"con$comprobante"."ID_AGENCIA", "con$comprobante"."DESCRIPCION",');
          SQL.Add('"con$comprobante"."TOTAL_DEBITO", "con$comprobante"."TOTAL_CREDITO",');
          SQL.Add('"con$comprobante"."ESTADO", "con$comprobante"."IMPRESO",');
          SQL.Add('"con$comprobante"."ANULACION","con$comprobante"."ID_EMPLEADO") ');
          SQL.Add('values (');
          SQL.Add(':"ID_COMPROBANTE", :"FECHADIA", :"TIPO_COMPROBANTE",');
          SQL.Add(':"ID_AGENCIA", :"DESCRIPCION", :"TOTAL_DEBITO",');
          SQL.Add(':"TOTAL_CREDITO", :"ESTADO", :"IMPRESO", :"ANULACION", :"ID_EMPLEADO")');
          ParamByName('ID_COMPROBANTE').AsInteger := consecutivo;
          ParamByname('FECHADIA').AsDate := date;
          ParamByName('ID_AGENCIA').AsInteger := 1;
          ParamByName('TIPO_COMPROBANTE').AsInteger := tipo_comprobante;
          ParamByName('DESCRIPCION').AsString := cadena;
          ParamByName('TOTAL_DEBITO').AsCurrency  := 0;
          ParamByName('TOTAL_CREDITO').AsCurrency  := 0;
          ParamByName('ESTADO').AsString  := 'O';
          ParamByname('ANULACION').asstring := '';
          ParamByName('IMPRESO').AsInteger  := Ord(false);
          ParamByname('ID_EMPLEADO').asstring := UpperCase(FrMain.Dbalias);
          Open;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmRealizaNomina.actcomprobante;
var     debito,credito: Currency;
begin
        with FrmQuerys.IBregistro do
        begin
          Close;
          verificatransaccion(FrmQuerys.IBregistro);
          SQL.Clear;
          SQL.Add('select SUM("con$auxiliar"."DEBITO") as debito,SUM("con$auxiliar"."CREDITO") as credito');
          SQL.Add('from "con$auxiliar" where "con$auxiliar"."ID_COMPROBANTE"=:"comprobante"');
          ParamByName('comprobante').AsInteger:=consecutivo;
          Open;
          debito := FieldByName('debito').AsCurrency;
          credito := FieldByName('credito').AsCurrency;
          SQL.Clear;
          SQL.Add('update "con$comprobante" set "con$comprobante".TOTAL_DEBITO =:"debito",');
          SQL.Add('"con$comprobante".TOTAL_CREDITO =:"credito"');
          SQL.Add('where "con$comprobante"."ID_COMPROBANTE"=:"comprobante"');
          ParamByName('comprobante').AsInteger := consecutivo;
          ParamByName('DEBITO').AsCurrency := SimpleRoundTo(debito,0);
          ParamByName('CREDITO').AsCurrency := SimpleRoundTo(credito,0);
          Open;
          Close;
          Transaction.Commit;
        end;
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('insert into "nom$controlreporte"');
          SQL.Add('Values (');
          SQL.Add(':comprobante,:agencia,:codigo_nomina)');
          ParamByName('comprobante').AsInteger := consecutivo;
          ParamByName('agencia').AsInteger := tipo_nomina;
          ParamByName('codigo_nomina').AsInteger := codigo_nominanuevo;
          Open;
          Close;
          Transaction.Commit;
        end;
end;

function TFrmRealizaNomina.prestacion(tipo, opcion: integer): currency;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          case opcion of
            1: SQL.Add('"nom$tipoprestacion"."porcentaje" as porcentaje');
            2: SQL.Add('"nom$tipoprestacion"."porempleado" as porcentaje');
            3: SQL.Add('"nom$tipoprestacion"."porempresa" as porcentaje');
          end;
          SQL.Add('FROM');
          SQL.Add('"nom$tipoprestacion"');
          SQL.Add('WHERE');
          SQL.Add('("nom$tipoprestacion"."codigo" = :tipo)');
          ParamByName('tipo').AsInteger := tipo;
          Open;
          Result := FieldByName('porcentaje').AsCurrency;
          Close;
        end;
end;

function TFrmRealizaNomina.aportes(nit, opcion: integer): currency;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          case opcion of
            1: SQL.Add('"nom$aportes"."porcentaje" as valor');
            2: SQL.Add('"nom$aportes"."codigopuc" as valor');
          end;
          SQL.Add('FROM');
          SQL.Add('"nom$aportes"');
          SQL.Add('WHERE');
          SQL.Add('("nom$aportes"."nit" = :nit)');
          ParamByName('nit').AsInteger := nit;
          Open;
          Result := FieldByName('valor').AsCurrency;
          Close;
        end;
end;

procedure TFrmRealizaNomina.reporte(tipodenomia:Smallint;report3: TprTxReport);
var     anulacion: string;
        oficina: string;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('select "nom$controlreporte"."comprobante"');
          SQL.Add('from "nom$controlreporte"');
          SQL.Add('where "nom$controlreporte"."agencia" = :agencia');
          SQL.Add('and "nom$controlreporte"."codigo_nomina" = :nomina');
          ParamByName('agencia').AsInteger := tipodenomia;
          ParamByName('nomina').AsInteger := buscanomina(DataQuerys.IBdatos)- 1;
          Open;
          consec := FieldByName('comprobante').AsInteger;
          if RecordCount = 0 then
          begin
             MessageDlg('No se ha Registrado contablemente la Nomina',mtInformation,[mbok],0);
             Exit;
          end;
          Close;
        end;
        frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
        with querycomprobante do
        begin
          Close;
          verificatransaccion(QueryComprobante);
          SQL.Clear;
          SQL.Add('Select "con$comprobante".ID_COMPROBANTE,');
          SQL.Add('"con$comprobante".FECHADIA,');
          SQL.Add('"con$comprobante".DESCRIPCION,');
          SQL.Add('"con$comprobante".TOTAL_DEBITO,');
          SQL.Add('"con$comprobante".TOTAL_CREDITO,');
          SQL.Add('"con$comprobante".ESTADO,');
          SQL.Add('"con$comprobante".IMPRESO,');
          SQL.Add('"con$comprobante".ANULACION');
          SQL.Add(',"con$comprobante".TIPO_COMPROBANTE');
          SQL.Add(',"con$tipocomprobante".DESCRIPCION AS DESCRIPCION1');
          SQL.Add('from');
          SQL.Add('"con$comprobante"');
          SQL.Add(',"con$tipocomprobante"');
          SQL.Add('where "con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
          SQL.Add('and "con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA"');
          ParamByName('ID_COMPROBANTE').AsString := IntToStr(consec);
          ParamByName('ID_AGENCIA').AsInteger := 1;
          Open;
          anulacion := FieldByName('ANULACION').AsString;
          if anulacion <> '' then
             Report3.Variables.ByName['anulacion'].AsString := 'Anulado por:'
          else
             Report3.Variables.ByName['anulacion'].AsString := '';
        end;
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "Inv$Agencia"."descripcion" from "Inv$Agencia"' );
          SQL.Add('where "Inv$Agencia"."cod_agencia"=:"codigo"');
          ParamByName('codigo').AsInteger:=1;
          Open;
          oficina := FieldByName('descripcion').AsString;
          Close;
        end;
        with QueryAuxiliar do
        begin
          Close;
          verificatransaccion(QueryAuxiliar);
          SQL.Clear;
          SQL.Add('select ');
          SQL.Add('"con$auxiliar".ID_COMPROBANTE,');
          SQL.Add('"con$auxiliar".ID_AGENCIA,');
          SQL.Add('"con$auxiliar".CODIGO,');
          SQL.Add('"con$puc".NOMBRE,');
          SQL.Add('"con$auxiliar".DEBITO,');
          SQL.Add('"con$auxiliar".CREDITO,');
          SQL.Add('"con$auxiliar".ID_CUENTA,');
          SQL.Add('"con$auxiliar".ID_COLOCACION,');
          SQL.Add('"con$auxiliar".ID_IDENTIFICACION,');
          SQL.Add('"con$auxiliar".ID_PERSONA,');
          SQL.Add('"con$auxiliar".MONTO_RETENCION,');
          SQL.Add('"con$auxiliar".TASA_RETENCION');
          SQL.Add('FROM "con$auxiliar" INNER JOIN "con$puc"');
          SQL.Add('ON ("con$auxiliar"."CODIGO" = "con$puc"."CODIGO")');
          SQL.Add('where "con$auxiliar"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
          SQL.Add('and "con$auxiliar"."ID_AGENCIA" =:"ID_AGENCIA"');
          SQL.Add('order by "con$auxiliar"."CREDITO"');
          ParamByName('ID_COMPROBANTE').AsString :=IntToStr(consec);
          ParamByName('ID_AGENCIA').AsInteger := 1;
          Open;
          Last;
          First;
         end;
              While not QueryAuxiliar.Eof do
               begin
                 with IBQTabla do
                 BEGIN
                 Append;
                 FieldValues['CODIGO']:= (QueryAuxiliar.FieldByName('CODIGO').AsString);
                 FieldValues['NOMBRE']  := QueryAuxiliar.FieldByName('NOMBRE').AsString;
                 if QueryAuxiliar.FieldByName('ID_CUENTA').AsString <> '0' then
                    FieldValues['CREDCTA']  := QueryAuxiliar.FieldByName('ID_CUENTA').AsString
                 else if Trim(QueryAuxiliar.FieldByName('ID_COLOCACION').AsString) <> '' then
                    FieldValues['CREDCTA']  := QueryAuxiliar.FieldByName('ID_COLOCACION').AsString
                 else
                    FieldValues['CREDCTA']  := '';
                 if Trim(QueryAuxiliar.FieldByName('ID_PERSONA').AsString) <> '' then
                    FieldValues['IDENTIFICACION']  := QueryAuxiliar.FieldByName('ID_PERSONA').AsString
                 else
                    FieldValues['IDENTIFICACION']  := '';
                 FieldValues['DEBITO']  := QueryAuxiliar.FieldByName('DEBITO').AsCurrency;
                 FieldValues['CREDITO']  := QueryAuxiliar.FieldByName('CREDITO').AsCurrency;
                 Post;
                 end;
                 QueryAuxiliar.Next;
                end;
              //IBQTabla.Open;
              report3.Variables.ByName['empresa'].AsString := FrMain.Empresa;
              report3.Variables.ByName['hoy'].AsDateTime := Date;
              report3.Variables.ByName['Empleado'].AsString := empleados(FrmQuerys.IBseleccion,UpperCase(FrMain.Dbalias));
              report3.Variables.ByName['Nit'].AsString := FrMain.Nit;
              report3.Variables.ByName['oficina'].AsString := oficina;
              report3.Variables.ByName['tiponota'].AsString := tipo_agencia(consec);
              if report3.PrepareReport then
               begin
                 frmVistaPreliminar.Reporte := Report3;
                 frmVistaPreliminar.ShowModal;
               end;
                IBQTabla.CancelUpdates;
          QueryAuxiliar.Close;
          consecutivo:=0;
end;

procedure TFrmRealizaNomina.report10PrintComplete(Sender: TObject);
begin
      with FrmQuerys.IBregistro do
       begin
         SQL.Clear;
         SQL.Add('update "con$comprobante" set ');
         SQL.Add('"con$comprobante"."IMPRESO" = :"IMPRESO"');
         SQL.Add(' where ');
         SQL.Add('"con$comprobante"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and');
         SQL.Add('"con$comprobante"."ID_AGENCIA" = :"ID_AGENCIA"');
         ParamByName('ID_COMPROBANTE').AsString:= IntToStr(consec);
         ParamByName('ID_AGENCIA').AsInteger := 1;
         ParamByName('IMPRESO').AsInteger  := Ord(True);
         Open;
         Transaction.Commit;
         Close;
       end;
end;

procedure TFrmRealizaNomina.cancelarnomina;
begin
           if opcion_nomina = false then
           begin
             if MessageDlg('Esta Seguro de Eliminar La Nomina de '+FormatDateTime('mmmm',Date),mtInformation,[mbYes,mbNo],0) = mrYes Then
             begin
             with DataQuerys.IBingresa do
             begin
               Close;
               verificatransaccion(DataQuerys.IBingresa);
               SQL.Clear;
               SQL.Add('delete from "nom$nomina"');
               SQL.Add('where "nom$nomina"."codigo_nomina" = :"codigo_nomina"');
               ParamByName('codigo_nomina').AsInteger := buscanomina(DataQuerys.IBselecion);
               Open;
               SQL.Clear;
               SQL.Add('delete from "nom$fondos"');
               SQL.Add('where "nom$fondos"."cod_nomina" = :"cod_nomina"');
               ParamByName('cod_nomina').AsInteger := buscanomina(DataQuerys.IBselecion);
               Open;
               Close;
               Transaction.Commit;
             end;
             opcion_nomina := True;
             BACEPTAR.Caption := '&Realizar';
             BACEPTAR.Hint := 'Realiza la Nomina Referente al Mes: '+ FormatDateTime('mmmm',Date)+'.';
             end;
           end
           else
           MessageDlg('No Existen Elementos A Eliminar ',mtInformation,[mbOK],0)
end;

procedure TFrmRealizaNomina.auxiliar1(codigopuc, consec: Integer;
  tipo: string; valor: Currency; cuenta: string);
var     codigo :string;
        debito,credito :Currency;
begin
        debito := 0;
        credito := 0;
        if tipo = 'D' then
           debito := valor
        else
           credito := valor;
        if (debito <> 0) or (credito <> 0) then
        begin
          with DataQuerys.IBselecion do
          begin
            Close;
            verificatransaccion(DataQuerys.IBselecion);
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"nom$pucbasico"."codigo",');
            SQL.Add('"nom$pucbasico"."descripcion"');
            SQL.Add('FROM');
            SQL.Add('"nom$pucbasico"');
            SQL.Add('WHERE');
            SQL.Add('("nom$pucbasico"."id" = :codigo)');
            ParamByName('codigo').AsInteger := codigopuc;
            Open;
            codigo := FieldByName('codigo').AsString;
            Close;
            Transaction.Commit;
         end;
          with FrmQuerys.IBregistro do
          begin
            Close;
            verificatransaccion(FrmQuerys.IBregistro);
            SQL.Clear;
            SQL.Add('insert into "con$auxiliar" values (');
            SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
            SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
            SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
            ParamByName('ID_COMPROBANTE').asInteger := consec;
            ParamByName('ID_AGENCIA').AsInteger := 1;
            ParamByName('FECHA').AsDate := date;
            ParamByName('CODIGO').AsString := codigo;
            ParamByName('DEBITO').AsCurrency := SimpleRoundTo(debito,0);
            ParamByName('CREDITO').AsCurrency := SimpleRoundTo(credito,0);
            ParamByName('ID_CUENTA').AsString := cuenta;
            ParamByName('ID_COLOCACION').AsString := '';
            ParamByName('ID_IDENTIFICACION').AsInteger := 0;
            ParamByName('ID_PERSONA').AsString :='0';
            ParamByName('MONTO_RETENCION').AsCurrency := 0;
            ParamByName('TASA_RETENCION').AsFloat := 0;
            ParamByName('ESTADOAUX').AsString := 'O';
            Open;
            Close;
            Transaction.Commit;
          end;
         end;
end;

procedure TFrmRealizaNomina.actualizacuentas;
var  nite,id_identificacion :Integer;
     cuenta :string;
     _cValorLibranzaAg :Currency;
begin
        with IBbusbaempleado do
        begin
          Close;
          verificatransaccion(IBbusbaempleado);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$empleado"."nitempleado",');
          SQL.Add('"nom$empleado"."numero_cuenta"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."tipo_nomina" = :tipo_nomina)');
          ParamByName('tipo_nomina').AsInteger := tipo_nomina;
          Open;
          while not Eof do
          begin
            nite := FieldByName('nitempleado').AsInteger;
            id_identificacion := 3;
            valor_retefuente := retefuente(DataQuerys.IBselecion,nite,1,(descuento(IBQuery1,nite,2) + horaextra(IBQuery1,nite)));
            valor_hora :=nomina(DataQuerys.IBselecion,3,tipo_nomina,nite);
            valor_sueldo := nomina(DataQuerys.IBselecion,2,tipo_nomina,nite);
            valor_fsp := SimpleRoundTo(fsp(DataQuerys.IBselecion,nite),0);
            valor_pension := SimpleRoundTo(deduccion(DataQuerys.IBselecion,200,nite),0);
            hora(nite,valor_hora);// ojo actualizar despues de junio
            obligacion(11,nite,(valor_pension + selobligacion(11,nite)));
            obligacion(12,nite,(valor_fsp + selobligacion(12,nite)));
            obligacion(1,nite,(valor_sueldo + selobligacion(1,nite)));
            obligacion(2,nite,(valor_hora + selobligacion(2,nite)));
            obligacion(13,nite,(valor_retefuente + selobligacion(13,nite)));
            cuenta := FieldByName('numero_cuenta').AsString;
            auxiliar(2,consecutivo,'D',nomina(DataQuerys.IBselecion,3,tipo_nomina,nite));//horas extras
            auxiliar_con(1,consecutivo,'D',nomina(DataQuerys.IBselecion,2,tipo_nomina,nite),0,IntToStr(nite),id_identificacion,0,0); // SUELDOS
            //auxiliar(1,consecutivo,'D',nomina(DataQuerys.IBselecion,2,tipo_nomina,nite));//sueldos
            //auxiliar1(8,consecutivo,'C',nomina(DataQuerys.IBselecion,12,tipo_nomina,nite),cuenta);  // ahorro ordinario
            if cuenta = '0' then
            begin
              //Ojo LLevar Contabilización Aqui
              auxiliarcon(vcodigopuc(nite),consecutivo,'C',nomina(DataQuerys.IBselecion,12,tipo_nomina,nite));
              _cValorLibranzaAg := nomina(DataQuerys.IBselecion,6,tipo_nomina,nite);
              if _cValorLibranzaAg > 0 then
              begin
                with cdsLibranza do
                begin
                  Append;
                  cdsLibranza.FieldValues['IDAGENCIA'] := vCodigoPucCXC(nite,1);
                  cdsLibranza.FieldValues['VALOR'] := nomina(DataQuerys.IBselecion,6,tipo_nomina,nite);
                  cdsLibranza.FieldValues['TIPO'] := tipo_nomina;
                  post;
                end;
              end;
            end
            else
            begin
              auxiliar_con(8,consecutivo,'C',nomina(DataQuerys.IBselecion,12,tipo_nomina,nite),StrToInt(cuenta),IntToStr(nite),id_identificacion,0,0); // AHOORO ORDINARIO
              consignar(StrToInt(cuenta),nomina(DataQuerys.IBselecion,12,tipo_nomina,nite));
            end;
            if valor_retefuente > 0 then
               auxiliar_con(9,consecutivo,'C',valor_retefuente,0,IntToStr(nite),id_identificacion,tasaretefuente(nite).monto,tasaretefuente(nite).tasa);// RETEFUENTE

          Next;
          end; // fin while busca empleado
          Close;
        end; // fin with s¡busca empleado;
end;

function TFrmRealizaNomina.agencia(tipo: integer): string;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('select "nom$tiponomina"."descripcion"');
          SQL.Add('from "nom$tiponomina"');
          SQL.Add('where "nom$tiponomina"."codigo" = :codigo');
          ParamByName('codigo').AsInteger := tipo;
          Open;
          Result := FieldByName('descripcion').AsString;
          Close;
        end;

end;
function TFrmRealizaNomina.dnomina(tipo_nom: integer): boolean;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"nom$tiponomina"."fondo"');
          SQL.Add('FROM');
          SQL.Add('"nom$tiponomina"');
          SQL.Add('WHERE');
          SQL.Add('("nom$tiponomina"."codigo" = :cod)');
          ParamByName('cod').AsInteger := tipo_nom;
          Open;
          Result := IntToBool(FieldByName('fondo').AsInteger);
          Close;
        end;
end;

procedure TFrmRealizaNomina.consignar(cuenta: Integer;valor:Currency);
var    digitocuenta :Integer;
begin
        DigitoCuenta := StrToInt(DigitoControl(2,FormatCurr('0000000',cuenta)));
        with FrmQuerys.IBregistro do
        begin
          Close;
          verificatransaccion(FrmQuerys.IBregistro);
          SQL.Clear;
          SQL.Add('insert into "cap$extracto" values(');
          SQL.Add(':"ID_AGENCIA",:"ID_TIPO_CAPTACION",:"NUMERO_CUENTA",');
          SQL.Add(':"DIGITO_CUENTA",:"FECHA_MOVIMIENTO",:"HORA_MOVIMIENTO",');
          SQL.Add(':"ID_TIPO_MOVIMIENTO",:"DOCUMENTO_MOVIMIENTO",:"DESCRIPCION_MOVIMIENTO",');
          SQL.Add(':"VALOR_DEBITO",:"VALOR_CREDITO")');
          ParamByName('ID_AGENCIA').AsInteger := 1;
          ParamByName('ID_TIPO_CAPTACION').AsInteger := 2;
          ParamByName('NUMERO_CUENTA').AsInteger := cuenta;
          ParamByName('DIGITO_CUENTA').AsInteger := DigitoCuenta;
          ParamByName('FECHA_MOVIMIENTO').AsDateTime := Date;
          ParamByName('HORA_MOVIMIENTO').AsTime := Time;
          ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 6;
          ParamByName('DOCUMENTO_MOVIMIENTO').AsString := FormatCurr('0000000',consecutivo);;
          ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'PAGO NOMINA MES DE ' + FormatDateTime('MMMM-YYYY',Date) + ' DESC. LABOR';
          ParamByName('VALOR_DEBITO').AsCurrency := valor;
          ParamByName('VALOR_CREDITO').AsCurrency := 0;
          Open;
          Close;
          Transaction.Commit;
        end;
end;
procedure TFrmRealizaNomina.actulizaobligaciones;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"nom$empleado"."nitempleado"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          Open;
          while not Eof do
          begin
            with DataQuerys.IBselecion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('insert into "nom$obligaciones"');
              SQL.Add('values (');
              SQL.Add(':nitempleado,');
              SQL.Add(':ano,');
              SQL.Add(':sueldo,');
              SQL.Add(':horas_extras,');
              SQL.Add(':viaticos,');
              SQL.Add(':transporte,');
              SQL.Add(':p_antiguedad,');
              SQL.Add(':p_vacaciones,');
              SQL.Add(':p_navidad,');
              SQL.Add(':p_servicios,');
              SQL.Add(':vacaciones,');
              SQL.Add(':bonificacion,');
              SQL.Add(':pension,');
              SQL.Add(':fsp )');
              ParamByName('nitempleado').AsInteger := DataQuerys.IBdatos.FieldByName('nitempleado').AsInteger;
              ParamByName('ano').AsInteger := StrToInt(FormatDateTime('yyyy',date));;
              ParamByName('sueldo').AsCurrency := 0;
              ParamByName('horas_extras').AsCurrency := 0;
              ParamByName('viaticos').AsCurrency := 0;
              ParamByName('transporte').AsCurrency := 0;
              ParamByName('p_antiguedad').AsCurrency := 0;
              ParamByName('p_vacaciones').AsCurrency := 0;
              ParamByName('p_navidad').AsCurrency := 0;
              ParamByName('p_servicios').AsCurrency := 0;
              ParamByName('vacaciones').AsCurrency := 0;
              ParamByName('bonificacion').AsCurrency := 0;
              ParamByName('pension').AsCurrency := 0;
              ParamByName('fsp').AsCurrency := 0;
              Open;
              Transaction.CommitRetaining;
              Close;
            end;
            with DataQuerys.IBingresa do
            begin
              Close;
              SQL.Clear;
              SQL.Add('insert into "nom$horas"');
              SQL.Add('Values (');
              SQL.Add(':valor,:nit');
              ParamByName('valor').AsCurrency := 0;
              ParamByName('nit').AsInteger := DataQuerys.IBdatos.FieldByName('nitempleado').AsInteger;
              Open;
              Close;
              Transaction.CommitRetaining;
            end;
            Next;
          end;
        end;
end;

function TFrmRealizaNomina.extrae_nombre(tipo: integer): string;
begin
//        IBTransaction6.Commit;
        try
        with IBQuery2 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "nom$tiponomina"."descripcion" from "nom$tiponomina"');
          SQL.Add('where "nom$tiponomina"."codigo" = :codigo');
          ParamByName('codigo').AsInteger := tipo;
          Open;
            Result := FieldByName('descripcion').AsString;
          Close;
        end;
                  except
            Result := '';
          end;

end;

procedure TFrmRealizaNomina.auxiliar_con(codigo_puc, consecutivo: integer;
  tipo: string; valor: Currency; cuenta:Integer; id_persona: string;
  id_identifcacion: integer; monto, tasa: currency);
var     codigo :string;
        debito,credito :Currency;
begin
        debito := 0;
        credito := 0;
        if tipo = 'D' then
           debito := valor
        else
           credito := valor;
        if (debito <> 0) or (credito <> 0) then
        begin
          with DataQuerys.IBselecion do
          begin
            Close;
            verificatransaccion(DataQuerys.IBselecion);
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"nom$pucbasico"."codigo",');
            SQL.Add('"nom$pucbasico"."descripcion"');
            SQL.Add('FROM');
            SQL.Add('"nom$pucbasico"');
            SQL.Add('WHERE');
            SQL.Add('("nom$pucbasico"."id" = :codigo)');
            ParamByName('codigo').AsInteger := codigo_puc;
            Open;
            codigo := FieldByName('codigo').AsString;
            Close;
            Transaction.Commit;
         end;
          with FrmQuerys.IBregistro do
          begin
            Close;
            verificatransaccion(FrmQuerys.IBregistro);
            SQL.Clear;
            SQL.Add('insert into "con$auxiliar" values (');
            SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
            SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
            SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
            ParamByName('ID_COMPROBANTE').asInteger := consecutivo;
            ParamByName('ID_AGENCIA').AsInteger := 1;
            ParamByName('FECHA').AsDate := date;
            ParamByName('CODIGO').AsString := codigo;
            ParamByName('DEBITO').AsCurrency := SimpleRoundTo(debito,0);
            ParamByName('CREDITO').AsCurrency := SimpleRoundTo(credito,0);
            if cuenta = 0 then
               ParamByName('ID_CUENTA').Clear
            else
               ParamByName('ID_CUENTA').AsInteger := cuenta;
            ParamByName('ID_COLOCACION').AsString := '';
            ParamByName('ID_IDENTIFICACION').AsInteger := id_identifcacion;
            ParamByName('ID_PERSONA').AsString :=id_persona;
            ParamByName('MONTO_RETENCION').AsCurrency := monto;
            ParamByName('TASA_RETENCION').AsCurrency := tasa;
            ParamByName('ESTADOAUX').AsString := 'O';
            Open;
            Close;
            Transaction.Commit;
          end;
         end;

end;

end.

