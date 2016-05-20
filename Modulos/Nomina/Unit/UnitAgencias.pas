unit UnitAgencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, IBDatabase, DB, IBCustomDataSet,
  IBQuery, DBCtrls, pr_Common, pr_TxClasses, Math, DateUtils;

type
  TFrmAgencias = class(TForm)
    Panel1: TPanel;
    agencia: TLabel;
    Panel2: TPanel;
    BACEPTAR: TBitBtn;
    Bcerrar: TBitBtn;
    agencias: TDBLookupComboBox;
    IBQuery1: TIBQuery;
    DataSource1: TDataSource;
    IBTransaction1: TIBTransaction;
    report3: TprTxReport;
    IBbusca: TIBQuery;
    IBTransaction2: TIBTransaction;
    IBQTabla: TIBQuery;
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
    IBTransaction4: TIBTransaction;
    IBTransaction5: TIBTransaction;
    procedure FormCreate(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
  private
    { Private declarations }
  public
      consecutivo :Integer;
      nit: Integer;
      valor :Currency;
      tipo_prima :Integer;
      codigo_puc :Integer;
      opcion :Integer;
    procedure insertar;
    procedure int_cesantias;
  published
    procedure servicios;
    procedure reporte;
    procedure navidad;
    { Public declarations }
  end;

var
  FrmAgencias: TFrmAgencias;

implementation
uses unitdatamodulo, UnitdataQuerys, Unitprogreso, UnitQuerys,
  UnitPrincipal,UnitGlobal,UnitVistapreliminar, UnitPantallaProgreso,
  UnitNomina;
{$R *.dfm}

procedure TFrmAgencias.FormCreate(Sender: TObject);
begin
        IBQuery1.Open;
        IBQuery1.Last;
end;

procedure TFrmAgencias.BcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmAgencias.servicios;
var     total,total_consignado,total_traslado :Currency;
        cuenta :Integer;
        vFecha :TDate;
        Extras, Servicio, Transporte,dias :Currency;
begin
        total := 0;
        total_consignado := 0;
        total_traslado := 0;
        vTotalOficina := 0;
        with IBbusca do
        begin
        Close;
        verificatransaccion(IBbusca);
        IBbusca.ParamByName('tipo').AsInteger := 8;
        IBbusca.ParamByName('nit').AsInteger := agencias.KeyValue;
        IBbusca.ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',Date));
        Open;
        if RecordCount <> 0 then
        begin
        if MessageDlg('El Pago de la Prima de Servicios ya fue Efectuado'+#13+'segun Nota contable No. ' + FieldByName('comprobante').AsString + ' Desea ver la Nota',mtInformation,[mbYes,mbNo],0) = mrYes Then
        begin
          consecutivo := FieldByName('comprobante').AsInteger;
          reporte;
          Exit;
        end
        else
          Exit;
        end;
        Close;
        end;
        FrmQuerys := TFrmQuerys.Create(self);
        FrmProgresos:= TfrmProgresos.Create(self);
        frmProgresos.Titulo := 'Progreso del Traslado';
        consecutivo := comprobantes('TRASL. DE GASTOS PRIMA DE SERVICIOS '+ agencias.Text + ' '+FormatDateTime('mmmm "de" yyyy',date),'1');
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('*');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('where "nom$empleado"."tipo_nomina" = :tiponomina');
          ParamByName('tiponomina').AsInteger := agencias.KeyValue;
          Open;
          Last;
          First;
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Empleado No : ' + IntToStr(RecNo);
            Application.ProcessMessages;
            nit := FieldByName('nitempleado').AsInteger;
            cuenta := FieldByName('numero_cuenta').AsInteger;
            vFecha := FieldByName('fecha_registro').AsDateTime;
            //if FieldByName('aux_transporte').AsInteger = 1 then
               transporte := valor_transporte(nit,1);
            //else
            //   transporte := 0;
            Servicio := proservicios(StrToDate('2011/01/01'),nit);
            extras := serextras(nit,StrToDate('2011/01/01'));
            dias := diasservicio(vFecha);
            valor := SimpleRoundTo(((Servicio+Extras+Transporte)/360) * dias,0);
            if cuenta <> 0 then
            begin
               auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
               consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE SERVICIOS');
               total_consignado := total_consignado + valor;
            end
            else
            begin
               if vCodigoPuc(nit) <> -1 then
               begin
                 auxiliarcon(vCodigoPuc(nit),consecutivo,'C',valor);
                 vTotalOficina := vTotalOficina + valor;
               end;
            end;// fin del cuenta
            total := total + valor;
            Next;
          end;//fin del while
        end;
        total_traslado := total - total_consignado - vTotalOficina;
        auxiliarcon(codigo_puc,consecutivo,'D',total);
        auxiliarcon(codigo_puc,consecutivo,'C',total_traslado);
        actualizarcomprobante(consecutivo);
        frmProgresos.Cerrar;
        reporte;
        tipo_prima := 8;
        nit := agencias.KeyValue;
        insertar;
end;

procedure TFrmAgencias.reporte;
var     anulacion,tipo_nota: string;
        Tabla,oficina: string;
begin
        frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
        FrmQuerys := TFrmQuerys.Create(self);
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
          SQL.Add(',"con$tipocomprobante".DESCRIPCION AS DESCRIPCION1');
          SQL.Add('from ');
          SQL.Add('"con$comprobante"');
          SQL.Add(',"con$tipocomprobante"');
          SQL.Add('where "con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
          SQL.Add('and "con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA"');
          ParamByName('ID_COMPROBANTE').AsString := IntToStr(consecutivo);
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
          oficina:=FieldByName('descripcion').AsString;
          Close;
        end;
          tipo_nota:='NOTA CONTABLE';
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
          ParamByName('ID_COMPROBANTE').AsString :=IntToStr(consecutivo);
          ParamByName('ID_AGENCIA').AsInteger := 1;
          Open;
          Last;
          First;
         end;
           Tabla := '"Comprobante' + FloatToStr(Now)+ '"';
           with IBQTabla do
            begin
              Close;
              verificatransaccion(IBQTabla);
              SQL.Clear;
              SQL.Add('create table ' + Tabla + ' (');
              SQL.Add('CODIGO              CHAR(18),');
              SQL.Add('NOMBRE              CHAR(100),');
              SQL.Add('CREDCTA             CHAR(11),');
              SQL.Add('IDENTIFICACION      CHAR(15),');
              SQL.Add('DEBITO              NUMERIC(15,3),');
              SQL.Add('CREDITO             NUMERIC(15,3))');
              ExecSQL;
              Transaction.CommitRetaining;
              Close;
              SQL.Clear;
              SQL.Add('insert into ' + Tabla + 'values(');
              SQL.Add(':"CODIGO",');
              SQL.Add(':"NOMBRE",');
              SQL.Add(':"CREDCTA",');
              SQL.Add(':"IDENTIFICACION",');
              SQL.Add(':"DEBITO",');
              SQL.Add(':"CREDITO")');
              While not QueryAuxiliar.Eof do
               begin
                 ParamByName('CODIGO').AsString := (QueryAuxiliar.FieldByName('CODIGO').AsString);
                 ParamByName('NOMBRE').AsString := QueryAuxiliar.FieldByName('NOMBRE').AsString;
                 if QueryAuxiliar.FieldByName('ID_CUENTA').AsString <> '' then
                    ParamByName('CREDCTA').AsString := QueryAuxiliar.FieldByName('ID_CUENTA').AsString
                 else if Trim(QueryAuxiliar.FieldByName('ID_COLOCACION').AsString) <> '' then
                    ParamByName('CREDCTA').AsString := QueryAuxiliar.FieldByName('ID_COLOCACION').AsString
                 else
                    ParamByName('CREDCTA').AsString := '';
                 if Trim(QueryAuxiliar.FieldByName('ID_PERSONA').AsString) <> '0' then
                    ParamByName('IDENTIFICACION').AsString := QueryAuxiliar.FieldByName('ID_PERSONA').AsString
                 else
                    ParamByName('IDENTIFICACION').AsString := '';
                 ParamByName('DEBITO').AsCurrency := QueryAuxiliar.FieldByName('DEBITO').AsCurrency;
                 ParamByName('CREDITO').AsCurrency := QueryAuxiliar.FieldByName('CREDITO').AsCurrency;
                 ExecSql;
                 QueryAuxiliar.Next;
                end;
              Close;
              SQL.Clear;
              SQL.Add('select ');
              SQL.Add('CODIGO,');
              SQL.Add('NOMBRE,');
              SQL.Add('CREDCTA,');
              SQL.Add('IDENTIFICACION,');
              SQL.Add('DEBITO,');
              SQL.Add('CREDITO');
              SQL.Add('from ' + Tabla + ' ');
              SQL.Add('order by CREDITO,CODIGO');
              Open;
              IBQTabla.Last;
              IBQTabla.First;
              IBQTabla.RecordCount;
              report3.Variables.ByName['empresa'].AsString := FrMain.Empresa;
              report3.Variables.ByName['hoy'].AsDateTime := Date;
              report3.Variables.ByName['Empleado'].AsString := empleados(FrmQuerys.IBseleccion,UpperCase(FrMain.Dbalias));
              report3.Variables.ByName['Nit'].AsString := FrMain.Nit;
              report3.Variables.ByName['oficina'].AsString := oficina;

              report3.Variables.ByName['tiponota'].AsString := tipo_agencia(consecutivo);
              if report3.PrepareReport then
               begin
                 frmVistaPreliminar.Reporte := Report3;
                 frmVistaPreliminar.ShowModal;
               end;
              IBQTabla.Close;
              Transaction.CommitRetaining;
              with IBQTabla do
              begin
                SQL.Clear;
                SQL.Add('drop table ' + Tabla);
                ExecSQL;
                IBQTabla.Close;
                Transaction.CommitRetaining;
              end;
            end; // Fin With IBQTabla


end;

procedure TFrmAgencias.insertar;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('insert into "nom$control"');
          SQL.Add('values (');
          SQL.Add(':tipo,:fecha,:nit,:comprobante)');
          ParamByName('tipo').AsInteger := tipo_prima;
          ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',Date));
          ParamByName('nit').AsInteger := nit;
          ParamByName('comprobante').AsInteger := consecutivo;
          Open;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmAgencias.navidad;
var     total,total_consignado,total_traslado :Currency;
        cuenta :Integer;
        vMeses :Integer;
        vFecha :TDate;
begin
        total := 0;
        total_consignado := 0;
        total_traslado := 0;
        vTotalOficina := 0;
        with IBbusca do
        begin
          Close;
          verificatransaccion(IBbusca);
          IBbusca.ParamByName('tipo').AsInteger := 9;
          IBbusca.ParamByName('nit').AsInteger := agencias.KeyValue;
          IBbusca.ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',Date));
          Open;
          if RecordCount <> 0 then
          begin
            if MessageDlg('El Pago de la Prima de Navidad ya fue Efectuado'+#13+'segun Nota contable No. ' + FieldByName('comprobante').AsString + ' Desea ver la Nota',mtInformation,[mbYes,mbNo],0) = mrYes Then
            begin
              consecutivo := FieldByName('comprobante').AsInteger;
              reporte;
             Exit;
            end
            else
              Exit;
        end;
        Close;
        end; // fin del with
        if StrToInt(FormatDateTime('d',Date)) >= 1 then
        begin
          FrmQuerys := TFrmQuerys.Create(self);
          FrmProgreso := TFrmProgreso.Create(self);
          FrmProgreso.Caption := 'Progreso del Tralado';
          consecutivo := comprobantes('TRASL. DE GASTOS PRIMA DE NAVIDAD '+ agencias.Text + ' '+FormatDateTime('mmmm "de" yyyy',date),'2');
          with DataQuerys.IBingresa do
          begin
            Close;
            verificatransaccion(DataQuerys.IBingresa);
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('*');
            SQL.Add('FROM');
            SQL.Add('"nom$empleado"');
            SQL.Add('where "nom$empleado"."tipo_nomina" = :tiponomina');
            ParamByName('tiponomina').AsInteger := agencias.KeyValue;
            Open;
            Last;
            First;
            FrmProgreso.Barra.Maximum := RecordCount;
            FrmProgreso.Show;
            while not Eof do
            begin
              FrmProgreso.Barra.Position := RecNo;
              nit := FieldByName('nitempleado').AsInteger;
              cuenta := FieldByName('numero_cuenta').AsInteger;
              vMeses := MonthsBetween(FieldByName('fecha_registro').AsDateTime,(Date + 15));
              vFecha := FieldByName('fecha_registro').AsDateTime;
              if retornadias(vFecha) >= 180 then
              begin
                 valor := SimpleRoundTo((proservicios(StrToDate('2011/01/01'),nit)/720) * SimpleRoundTo(interescesantia(0,nit,7,0),0),0);
                 if cuenta <> 0 then
                 begin
                    auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
                    consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE NAVIDAD');
                    total_consignado := total_consignado + valor;
                 end
                 else
                 begin
                   if vCodigoPuc(nit) <> -1 then
                   begin
                     auxiliarcon(vCodigoPuc(nit),consecutivo,'C',valor);
                     vTotalOficina := vTotalOficina + valor;
                   end;
                 end;
                 total := total + valor;
              end; // fin del retorna dias
             Next;
            end; //fin del while
          end; // fin del with
        end; // fin del primer if
          //Close;
          total_traslado := total - total_consignado - vTotalOficina;
          auxiliarcon(codigo_puc,consecutivo,'D',total);
          auxiliarcon(codigo_puc,consecutivo,'C',total_traslado);
          actualizarcomprobante(consecutivo);
          FrmProgreso.Hide;
          reporte;
        tipo_prima := 9;
        nit := agencias.KeyValue;
        insertar;

end;

procedure TFrmAgencias.BACEPTARClick(Sender: TObject);
var    oficina :Integer;
begin
        if MessageDlg('Esta Seguro de Ralizar la Transaccion',mtInformation,[mbyes,mbno],0) = mryes then
        begin
        FrmNomina := TFrmNomina.Create(Self);
        try
        oficina := agencias.KeyValue;
        except
        on E: Exception do
        begin
          MessageDlg('Debe Seleccionar una Agencia',mtError,[mbOK],0);
          Exit;
        end;
        end;
        if oficina = 30 then
           codigo_puc := 38
        else if oficina = 40 then
           codigo_puc := 22
        else if oficina = 50 then
           codigo_puc := 57
        else if oficina = 60 then
           codigo_puc := 65;
        if opcion = 1 then
           navidad
        else if opcion = 2 then
           servicios
        else
           int_cesantias;
end;
end;

procedure TFrmAgencias.int_cesantias;
var    total,total_consignado,total_traslado :Currency;
       cuenta :Integer;
begin
        total := 0;
        total_consignado := 0;
        total_traslado := 0;
        vTotalOficina := 0;
        with IBbusca do
        begin
          Close;
          verificatransaccion(IBbusca);
          IBbusca.ParamByName('tipo').AsInteger := 60;// codigo agencias
          IBbusca.ParamByName('nit').AsInteger := agencias.KeyValue;
          IBbusca.ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',Date));
          Open;
          if RecordCount <> 0 then
          begin
             if MessageDlg('El Pago de los Intereses de Cesantias'+#13+'segun Nota contable No. ' + FieldByName('comprobante').AsString + ' Desea ver la Nota',mtInformation,[mbYes,mbNo],0) = mrYes Then
             begin
                consecutivo := FieldByName('comprobante').AsInteger;
                reporte;
                Exit;
             end
             else
               Exit;
          end;// fin del recorcount
          Close;
        end;// fin del ibbusca
        FrmQuerys := TFrmQuerys.Create(self);
        FrmProgreso := TFrmProgreso.Create(self);
        FrmProgreso.Caption := 'Progreso del Tralado';
        consecutivo := comprobantes('TRASL. DE GASTOS INTERES CESANTIAS '+ agencias.Text + ' '+FormatDateTime('mmmm "de" yyyy',date),'2');
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('*');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('where "nom$empleado"."tipo_nomina" = :tiponomina');
          ParamByName('tiponomina').AsInteger := agencias.KeyValue;
          Open;
          Last;
          First;
          FrmProgreso.Barra.Maximum := RecordCount;
          FrmProgreso.Show;
          while not Eof do
          begin
            FrmProgreso.Barra.Position := RecNo;
            nit := FieldByName('nitempleado').AsInteger;
            cuenta := FieldByName('numero_cuenta').AsInteger;
            valor := interes(nit);
            if cuenta <> 0 then
            begin
               auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
               consignacion(cuenta,consecutivo,valor,'PAGO INTERES CESANTIAS');
               total_consignado := total_consignado + valor;
            end
            else
            begin
               if vCodigoPuc(nit) <> -1 then
               begin
                 auxiliarcon(vCodigoPuc(nit),consecutivo,'C',valor);
                 vTotalOficina := vTotalOficina + valor;
               end;
            end;
            total := total + valor;
          Next;
          end;
          Close;
          total_traslado := total - total_consignado - vTotalOficina;
          auxiliarcon(codigo_puc,consecutivo,'D',total);
          auxiliarcon(codigo_puc,consecutivo,'C',total_traslado);
          actualizarcomprobante(consecutivo);
          FrmProgreso.Hide;
          reporte;
        end;
         tipo_prima := 60;
         nit := agencias.KeyValue;
         insertar;

end;

end.
