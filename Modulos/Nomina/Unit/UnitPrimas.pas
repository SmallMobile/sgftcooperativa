unit UnitPrimas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, IBCustomDataSet, IBDatabase,
  IBQuery, pr_Common, pr_TxClasses, DBCtrls, Math, DateUtils;

type
  TFrmPrimas = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    BACEPTAR: TBitBtn;
    IBQTabla: TIBQuery;
    IBTransaction1: TIBTransaction;
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
    IBTransaction2: TIBTransaction;
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
    report3: TprTxReport;
    Bcerrar: TBitBtn;
    emp: TLabel;
    empleado: TComboBox;
    empleadonit: TComboBox;
    Breporte: TBitBtn;
    busca_nombre: TIBQuery;
    IBbusca: TIBQuery;
    IBTransaction4: TIBTransaction;
    Button1: TButton;
    IBQuery1: TIBQuery;
    procedure BACEPTARClick(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure BreporteClick(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure empleadoEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  cuenta :Integer;
  consecutivo: Integer;
  nit,tipo :Integer;
  tipo_prima :Smallint;
  valor,total :Currency;
    Vmonto_retefuente: Currency;
    procedure reporte;
    procedure insertar;
    procedure auxiliar_con(codigo_puc, consecutivo: integer; tipo: string;
      valor: Currency; cuenta: Integer; id_persona: string;
      id_identifcacion: integer; monto, tasa: currency);
    { Private declarations }
  public
  opcion :Integer;
    procedure servicios;
    procedure navidad;
    procedure antiguedad;
    procedure antiguos;
    procedure Int_Cesantias;
    { Public declarations }
  end;

var
  FrmPrimas: TFrmPrimas;

implementation

uses UnitQuerys,unitglobal,unitvistapreliminar, UnitVacaciones,
  UnitPrincipal, UnitdataQuerys,UnitDatamodulo, UnitDatosempleado,
  UnitNomina, Unitprogreso, UnitPantallaProgreso;

{$R *.dfm}

procedure TFrmPrimas.servicios;
var     saldo_prima, ptotal :Currency;
        vFecha :TDate;
        Extras, Servicio, Transporte,dias :Currency;

begin
        with IBbusca do
        begin
          Close;
          verificatransaccion(IBbusca);
          IBbusca.ParamByName('tipo').AsInteger := 3;
          IBbusca.ParamByName('nit').AsInteger := 3;
          IBbusca.ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',Date));
          Open;
          if RecordCount <> 0 then
          begin
            if MessageDlg('El Pago de la Prima de Servicios ya fue Efectuado'+#13+'segun Nota contable No. ' + FieldByName('comprobante').AsString + 'Desea ver la Nota',mtInformation,[mbYes,mbNo],0) = mrYes Then
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
        FrmProgresos := TFrmProgresos.Create(self);
        consecutivo := comprobantes('PAGO PRIMA DE SERVICIOS '+FormatDateTime('mmmm "de" yyyy',date),'1');
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('*');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          Open;
          Last;
          First;
          frmProgresos.Max := RecordCount;
          frmProgresos.Titulo := 'Realizando Pago Prima de Servicios';
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            FrmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Registro No : '+IntToStr(RecNo);
            Application.ProcessMessages;
            nit := FieldByName('nitempleado').AsInteger;
            cuenta := FieldByName('numero_cuenta').AsInteger;
            tipo := FieldByName('tipo_nomina').AsInteger;
            vFecha := FieldByName('fecha_registro').AsDateTime;
            //if FieldByName('aux_transporte').AsInteger = 1 then
               transporte := valor_transporte(nit,1);
            //else
            //   transporte := 0;
            Servicio := proservicios(StrToDate('2011/01/01'),nit);
            extras := serextras(nit,StrToDate('2011/01/01'));
            dias := diasservicio(vFecha);
            valor := SimpleRoundTo(((Servicio+Extras+Transporte)/360) * dias,0);
            ptotal := valor;
            if tipo in [10,20] then
            begin
              if retefuente(DataQuerys.IBaportes,nit,2,valor) > 0 then // identifica si al empleado se le descuenta retefuente
              begin
                 Vmonto_retefuente := 0;
                 Vmonto_retefuente := (0.75 * valor);
                 auxiliar_con(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor),0,IntToStr(nit),3,Vmonto_retefuente,tasaretefuente(nit).tasa);
                 //auxiliarcon(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor));
                 valor := valor - retefuente(DataQuerys.IBaportes,nit,2,valor);
                 obligacion(13,nit,(retefuente(DataQuerys.IBaportes,nit,2,ptotal)+selobligacion(13,nit)));
              end; // fin retefuente
              if cuenta = 0 then
              begin
                 auxiliarcon(vcodigopuc(nit),consecutivo,'C',valor);
              end
              else
              begin
                auxiliar_con(8,consecutivo,'C',valor,cuenta,IntToStr(nit),3,0,0);
                //auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
                consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE SERVICIOS');
              end;// fin cuenta
              valor := valor + retefuente(DataQuerys.IBaportes,nit,2,ptotal);
              total := valor+total;
            end;// fin tipo 10 y 20
            obligacion(8,nit,(valor + selobligacion(8,nit)));
            Next;
          end;   // fin del while
        end;// fin del primer query
        saldo_prima := total - abs(saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),26,1));
        if saldo_prima > 0 then
        begin
           auxiliarcon(43,consecutivo,'D',saldo_prima);
           total := total - saldo_prima;
        end;
           auxiliarcon(26,consecutivo,'D',total);
           actualizarcomprobante(consecutivo);
           tipo_prima := 3;
           nit := 3;
           insertar;
           frmProgresos.Cerrar;
           reporte;
end;

procedure TFrmPrimas.BACEPTARClick(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
//        FrmNomina.busca_sueldo(2856365,5035698);
        if MessageDlg('Esta Seguro de Ralizar la Transaccion',mtInformation,[mbYes,mbNo],0) = mrYes Then
        begin
          if opcion = 1 then
             servicios
          else if opcion = 2 then
             navidad
          else if opcion = 3 then
             antiguedad
          else if opcion = 4 then
             antiguos
          else if opcion = 10 then
            int_cesantias
        end;
end;

procedure TFrmPrimas.reporte;
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
          QueryAuxiliar.Close;
end;

procedure TFrmPrimas.navidad;
var     saldo_prima,ptotal :Currency;
        vMeses :Integer;
        vFecha :TDate;
begin
        with IBbusca do
        begin
        Close;
        verificatransaccion(IBbusca);
        IBbusca.ParamByName('tipo').AsInteger := 2;
        IBbusca.ParamByName('nit').AsInteger := 2;
        IBbusca.ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',Date));
        Open;
        if RecordCount <> 0 then
        begin
        if MessageDlg('El Pago de la Prima de la Prima de Navidad ya fue Efectuado'+#13+'segun Nota contable No. ' + FieldByName('comprobante').AsString + ' Desea ver la Nota',mtInformation,[mbYes,mbNo],0) = mrYes Then
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
        FrmProgreso := TFrmProgreso.Create(self);
        consecutivo := comprobantes('PAGO PRIMA DE NAVIDAD '+FormatDateTime('mmmm "de" yyyy',date),'1');
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('*');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('where "nom$empleado"."tipo_nomina" between 10 and 20');
          Open;
          Last;
          First;
          FrmProgreso.Barra.Maximum := RecordCount;
          while not Eof do
          begin
            FrmProgreso.Barra.Position := RecNo;
            nit := FieldByName('nitempleado').AsInteger;
            cuenta := FieldByName('numero_cuenta').AsInteger;
            tipo := FieldByName('tipo_nomina').AsInteger;
            vFecha := FieldByName('fecha_registro').AsDateTime;
            vMeses := MonthsBetween(FieldByName('fecha_registro').AsDateTime,(Date + 15));
            if retornadias(vFecha) >= 180 then
            begin
                valor := SimpleRoundTo((proservicios(StrToDate('2011/01/01'),nit)/720) * SimpleRoundTo(interescesantia(0,nit,7,0),0),0);
               if tipo in [10,20] then
               begin
                  if retefuente(DataQuerys.IBaportes,nit,2,valor) > 0 then // identifica si al empleado se le descuenta retefuente
                  begin
                    Vmonto_retefuente := 0;
                    Vmonto_retefuente := (0.75 * valor);
                    auxiliar_con(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor),0,IntToStr(nit),3,Vmonto_retefuente,tasaretefuente(nit).tasa);
                    //auxiliarcon(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor));
                    obligacion(13,nit,(retefuente(DataQuerys.IBaportes,nit,2,valor)+selobligacion(13,nit)));
                    ptotal := valor;
                    valor := valor - retefuente(DataQuerys.IBaportes,nit,2,valor);
                  end; // fin del valida retefuente
                 if cuenta = 0 then
                 begin
                    auxiliarcon(vcodigopuc(nit),consecutivo,'C',valor);
                 end
                 else
                 begin
                   auxiliar_con(8,consecutivo,'C',valor,cuenta,IntToStr(nit),3,0,0);
                   consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE NAVIDAD');
                 end; // fin del valida cuenta
                 valor := valor + retefuente(DataQuerys.IBaportes,nit,2,ptotal);
                 total := valor+total;
               end; // fin del valida tipo
                 obligacion(7,nit,(valor+selobligacion(7,nit))); // actualiza sumatoria obligacion
           end; // fin delña validacion de el tirmpo trabajado
           Next;
          end; // fin del whilw
          Close;
        end; // fin dewith
           saldo_prima := total - abs(saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),36,1));
           if saldo_prima > 0 then
           begin
              auxiliarcon(34,consecutivo,'D',saldo_prima);
              total := total - saldo_prima;
           end;
           auxiliarcon(36,consecutivo,'D',total);
           actualizarcomprobante(consecutivo);
           FrmProgreso.Hide;
           reporte;
           tipo_prima := 2;
           nit := 2;
           insertar;
end;

procedure TFrmPrimas.BcerrarClick(Sender: TObject);
begin
        Close;
//owMessage(CurrToStr(interescesantia(1188600,88280751,10,1)));// + SimpleRoundTo((nomina(DataQuerys.IBselecion,3,tipo,nit)/6),0)));
//ShowMessage(CurrToStr(interescesantia(1774000,5426410,4,10)));
        {with DataQuerys.IBdatos do
        begin
        SQL.Add('select "nom$obligaciones"."nit" from "nom$obligaciones"');
        Open;
        while not Eof do
        begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('update "nom$obligaciones" set');
          SQL.Add('"nom$obligaciones"."p_servicios" = :valor');
          SQL.Add('where "nom$obligaciones"."nit" = :nit');
          ParamByName('valor').AsCurrency := descuento(DataQuerys.IBselecion,DataQuerys.IBdatos.FieldByName('nit').AsInteger,3)/2;
          ParamByName('nit').AsInteger := DataQuerys.IBdatos.FieldByName('nit').AsInteger;
          Open;
          Close;
          Transaction.Commit
        end;
        Next;
        end;
        Close;
        end;}
end;

procedure TFrmPrimas.BreporteClick(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
        if opcion = 1 then
        begin
          FrmNomina.primas;
        end
        else if opcion = 3 then
        begin
          FrmNomina.nit_empleado := nit;
          FrmNomina.vacaciones;
        end
        else if opcion = 2 then
          FrmNomina.navidad;

end;

procedure TFrmPrimas.antiguedad;
var     dias_actuales :Integer;
        valor_consolidado,valor_actual,valor_dias :Currency;
        _cValor360 :Currency;
begin
        with IBbusca do
        begin
          Close;
          verificatransaccion(IBbusca);
          IBbusca.ParamByName('tipo').AsInteger := 1;
          IBbusca.ParamByName('nit').AsInteger := nit;
          IBbusca.ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',Date));
          Open;
          if RecordCount <> 0 then
          begin
            if MessageDlg('El Pago de la Prima de Vacaciones ya fue Efectuado'+#13+'segun Nota contable No. ' + FieldByName('comprobante').AsString + ' Desea ver la Nota',mtInformation,[mbYes,mbNo],0) = mrYes Then
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
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$empleado"."nitempleado",');
          SQL.Add('"nom$empleado"."numero_cuenta",');
          SQL.Add('"nom$empleado"."tipo_nomina"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('where "nom$empleado"."nitempleado" = :nit');
          ParamByName('nit').AsInteger := nit;
          Open;
          cuenta := FieldByName('numero_cuenta').AsInteger;
          tipo := FieldByName('tipo_nomina').AsInteger;
          Close;
        end;// fin del ibingresa
        FrmQuerys := TFrmQuerys.Create(self);
        dias_actuales := 360 - totaldias(nit);
        //Validar prima 360 ---
        _cValor360 := cPrima360(nit);
        if _cValor360 = 0 then
        begin
          valor := SimpleRoundTo((descuento(DataQuerys.IBselecion,nit,3) / 2),0);
          valor_dias := SimpleRoundTo(valor/360,-2);
          valor_consolidado := consolidar(nit,2);
          valor_actual := valor - valor_consolidado;
          valor := valor_consolidado + valor_actual;
        end
        else
        begin
          valor_consolidado := _cValor360;
          valor := _cValor360;
        end;

        if not (tipo in [10,20]) then
        begin
           consecutivo := comprobantes('PAGO P. DE VAC. '+ empleado.Text + ' '+ FormatDateTime('mmmm/yyyy',Date),'2');
           if retefuente(DataQuerys.IBaportes,nit,2,valor) <> 0 then
           begin
             Vmonto_retefuente := 0;
             Vmonto_retefuente := (valor * 0.75);
             auxiliar_con(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor),0,IntToStr(nit),3,Vmonto_retefuente,tasaretefuente(nit).tasa);
             //auxiliarcon(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor));
             valor := valor - retefuente(DataQuerys.IBaportes,nit,2,valor);
             obligacion(13,nit,(retefuente(DataQuerys.IBaportes,nit,2,valor)+selobligacion(13,nit)));
           end; //fin del retefuente
           if tipo = 40 then
           begin
              auxiliarcon(40,consecutivo,'D',valor_consolidado);
              if cuenta <> 0 then
              begin
                 auxiliar_con(8,consecutivo,'C',valor,cuenta,IntToStr(nit),3,0,0);
                   //auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
                 consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE VACACIONES');
              end // fin del cuenta
              else
                auxiliarcon(22,consecutivo,'C',valor);
              if _cValor360 = 0 then
                auxiliarcon(22,consecutivo,'D',valor_actual);
           end // fin tipo
           else if tipo = 60 then
           begin
              auxiliarcon(40,consecutivo,'D',valor_consolidado);
              if cuenta <> 0 then
              begin
                 auxiliar_con(8,consecutivo,'C',valor,cuenta,IntToStr(nit),3,0,0);
                   //auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
                 consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE VACACIONES');
              end // fin del cuenta
              else
                auxiliarcon(65,consecutivo,'C',valor);
              if _cValor360 = 0 then
                auxiliarcon(65,consecutivo,'D',valor_actual);

           end // fin tipo
           else if tipo = 30 then
           begin
              auxiliarcon(40,consecutivo,'D',valor_consolidado);
              if cuenta <> 0 then
              begin
                   //auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
                   auxiliar_con(8,consecutivo,'C',valor,0,IntToStr(nit),3,0,0);
                   consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE VACACIONES');
              end
              else
                auxiliarcon(38,consecutivo,'C',valor);
              if _cValor360 = 0 then
                auxiliarcon(38,consecutivo,'D',valor_actual);
           end  // fin tipo 30
//        end
        else if tipo = 50 then
        begin
              auxiliarcon(40,consecutivo,'D',valor_consolidado);
              if cuenta <> 0 then
              begin
                   //auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
                   auxiliar_con(8,consecutivo,'C',valor,0,IntToStr(nit),3,0,0);
                   consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE VACACIONES');
              end
              else
                auxiliarcon(57,consecutivo,'C',valor);
              if _cValor360 = 0 then
                auxiliarcon(57,consecutivo,'D',valor_actual);
        end;// fin  tipo 50
        end
        else
        begin
           consecutivo := comprobantes('Pago. P. DE VACACIONES '+ empleado.Text + ' '+ FormatDateTime('mmmm/yyyy',Date),'1');
           if retefuente(DataQuerys.IBaportes,nit,2,valor) <> 0 then
           begin
             Vmonto_retefuente := 0;
             Vmonto_retefuente := (0.75 * valor);
             auxiliar_con(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor),0,IntToStr(nit),3,Vmonto_retefuente,tasaretefuente(nit).tasa);
             valor := valor - retefuente(DataQuerys.IBaportes,nit,2,valor);
             obligacion(13,nit,(retefuente(DataQuerys.IBaportes,nit,2,valor)+selobligacion(13,nit)));
           end;
           if cuenta = 0 then
           begin
             auxiliarcon(vcodigopuc(nit),consecutivo,'C',valor);
           end
           else
           begin
             auxiliar_con(8,consecutivo,'C',valor,cuenta,IntToStr(nit),3,0,0);
             consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE VACACIONES');
           end;
           //auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
           if _cValor360 = 0 then
              auxiliarcon(27,consecutivo,'D',valor_actual);
           auxiliarcon(40,consecutivo,'D',valor_consolidado);
        end;
        obligacion(6,nit,valor);
        if _cValor360 = 0 then
        begin
          with DataQuerys.IBingresa do
          begin
               Close;
               verificatransaccion(DataQuerys.IBingresa);
               SQL.Clear;
               SQL.Add('update "nom$consolidado" set');
               SQL.Add('"nom$consolidado"."prima_vacaciones" = :valor');
               SQL.Add('where "nom$consolidado"."nit" = :nit');
               ParamByName('nit').AsInteger := nit;
               ParamByName('valor').AsCurrency := 0;
               Open;
               Close;
               Transaction.Commit;
          end;
        end;
        actualizarcomprobante(consecutivo);
        reporte;
        tipo_prima := 1;
        insertar;
        if _cValor360 > 0 then
        begin
        //Se elimina la prima 360
        with DataQuerys.IBingresa do
        begin
             Close;
             verificatransaccion(DataQuerys.IBingresa);
             SQL.Clear;
             SQL.Add('delete from NOM$CAUSACION360 WHERE NIT = :NIT');
             ParamByName('nit').AsInteger := nit;
             ExecSQL;
             Transaction.Commit;
        end;
        end;

end;

procedure TFrmPrimas.empleadoExit(Sender: TObject);
var   a :Smallint;
      b :string;
begin
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        busca_nombre.Close;
        busca_nombre.parambyname('nombre').AsString := b;
        busca_nombre.Open;
        nit := busca_nombre.fieldbyname('nit').AsInteger;
        if nit = 0 then
        begin
          MessageDlg('Empelado no Existe',mtWarning,[mbok],0);
          Exit;
        end;
end;

procedure TFrmPrimas.insertar;
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

procedure TFrmPrimas.empleadoEnter(Sender: TObject);
var fecha,fecha_prima: TDate;
       mes :Integer;
begin
      empleado.Clear;
      if opcion = 3 then
      begin
        with DataQuerys.IBselecion do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido",');
          SQL.Add('"inv$empleado"."nit",');
          SQL.Add('"nom$empleado"."fecha_registro"');
          SQL.Add('FROM');
          SQL.Add('"inv$empleado"');
          SQL.Add('INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empleado"."nitempleado")');
          Open;
          while not Eof do
          begin
            fecha := FieldByName('fecha_registro').AsDateTime;
//            if FormatDateTime('mm',fecha) = FormatDateTime('mm',Date) then
//            begin
              empleado.Items.Add(FieldByName('nombre').AsString + ' ' + fieldbyname('apellido').AsString);
              empleadonit.Items.Add(FieldByName('nombre').AsString + fieldbyname('apellido').AsString);
//            end;
            Next;
             end;
          Close;
          Transaction.Commit;
        end;
        end
        else if opcion = 4 then
        begin
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"inv$empleado"."nombre",');
          SQL.Add('"inv$empleado"."apellido",');
          SQL.Add('"inv$empleado"."nit",');
          SQL.Add('"nom$empleado"."fecha_registro"');
          SQL.Add('FROM');
          SQL.Add('"inv$empleado"');
          SQL.Add('INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empleado"."nitempleado")');
          Open;
          while not Eof do
          begin
            fecha := FieldByName('fecha_registro').AsDateTime;
            mes := StrToInt(FormatDateTime('yyyy',fecha));
            mes := mes+5;
            fecha_prima := StrToDate(FormatDateTime(IntToStr(mes)+'/mm/dd',fecha));
            if (Int(Date) >= fecha_prima) and (FormatDateTime('mm',fecha) = FormatDateTime('mm',Date)) then
            begin
              empleado.Items.Add(FieldByName('nombre').AsString + ' ' + fieldbyname('apellido').AsString);
              empleadonit.Items.Add(FieldByName('nombre').AsString + fieldbyname('apellido').AsString);
            end;
            Next;
             end;
          Close;
          Transaction.Commit;
        end;

        end;
end;

procedure TFrmPrimas.FormCreate(Sender: TObject);
begin
        Label1.Caption := 'Fecha: '+FormatDateTime('mmmm "de" yyyy',date);
end;

procedure TFrmPrimas.antiguos;
var    fecha_registro,fecha_prima5,fecha_prima10,fecha_prima14,fecha_prima19 :TDate;
       fechaa,dias_actuales :Integer;
       valor_consolidado,valor_actual :Currency;
       valor_dias :Currency;
begin
        with IBbusca do
        begin
          Close;
          verificatransaccion(IBbusca);
          IBbusca.ParamByName('tipo').AsInteger := 4;
          IBbusca.ParamByName('nit').AsInteger := nit;
          IBbusca.ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',Date));
          Open;
          {if RecordCount <> 0 then
          begin
          if MessageDlg('El Pago de la Prima de Antiguedad ya fue Efectuado'+#13+'segun Nota contable No. ' + FieldByName('comprobante').AsString + ' Desea ver la Nota',mtInformation,[mbYes,mbNo],0) = mrYes Then
          begin
            consecutivo := FieldByName('comprobante').AsInteger;
            reporte;
            Exit;
          end
          else
            Exit;
          end // fin del recorcount
        Close;   }
        end; // fin del primer with
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$empleado"."nitempleado",');
          SQL.Add('"nom$empleado"."numero_cuenta",');
          SQL.Add('"nom$empleado"."tipo_nomina",');
          SQL.Add('"nom$empleado"."fecha_registro"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('where "nom$empleado"."nitempleado" = :nit');
          ParamByName('nit').AsInteger := nit;
          Open;
          cuenta := FieldByName('numero_cuenta').AsInteger;
          tipo := FieldByName('tipo_nomina').AsInteger;
          fecha_registro := FieldByName('fecha_registro').AsDateTime;
          Close;
        end; // fin del segundo with
        fechaa := StrToInt(FormatDateTime('yyyy',fecha_registro));
        fecha_prima5 := StrToDate(FormatDateTime(IntToStr(fechaa+5)+'/mm/01',fecha_registro));
        fecha_prima10 := StrToDate(FormatDateTime(IntToStr(fechaa+10)+'/mm/01',fecha_registro));
        fecha_prima14 := StrToDate(FormatDateTime(IntToStr(fechaa+15)+'/mm/01',fecha_registro));
        fecha_prima19 := StrToDate(FormatDateTime(IntToStr(fechaa+20)+'/mm/01',fecha_registro));
        if (Int(Date) >= fecha_prima19) then // prima 2 sueldos
           valor := SimpleRoundTo((descuento(DataQuerys.IBselecion,nit,3) * 1),0) // 1 SUELDO
        else if (Int(Date) >= fecha_prima14) then  // prima 1.5 sueldos
           valor := SimpleRoundTo((descuento(DataQuerys.IBselecion,nit,3) * 1),0) // UN SUELDO
        else if (Int(Date) >= fecha_prima10)  then
           valor := (descuento(DataQuerys.IBselecion,nit,3)/2)// 1/2 SUELDO
        else if (Int(Date) >= fecha_prima5) then
           valor := SimpleRoundTo((descuento(DataQuerys.IBselecion,nit,3) / 4),0) // 1/4 SUELDO
        else
           Exit;
        dias_actuales := 360 - totaldias(nit);
        valor_dias := valor/360;
        valor_consolidado := consolidar(nit,3);
        valor_actual := valor - valor_consolidado;
        valor := valor_consolidado + valor_actual;
        FrmQuerys := TFrmQuerys.Create(self);
        if not (tipo in [10,20]) then
        begin
           consecutivo := comprobantes('PAGO PRIMA DE ANTIGUEDAD '+ empleado.Text + ' '+ FormatDateTime('mmmm/yyyy',Date),'2');
          if retefuente(DataQuerys.IBaportes,nit,2,valor) <> 0 then //verifica retefuente
          begin
             Vmonto_retefuente := 0;
             Vmonto_retefuente := (0.75 * valor);
             auxiliar_con(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor),0,IntToStr(nit),3,Vmonto_retefuente,tasaretefuente(nit).tasa);
             //auxiliarcon(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor));
             valor := valor - retefuente(DataQuerys.IBaportes,nit,2,valor);
             obligacion(13,nit,(retefuente(DataQuerys.IBaportes,nit,2,valor)+selobligacion(13,nit)));
          end; // fin del retefuente
        end; // FIN DEL PRIMER IF
        if tipo = 40 then
        begin
          auxiliarcon(39,consecutivo,'D',valor_consolidado);
          if cuenta <> 0 then
          begin
            auxiliar_con(8,consecutivo,'C',valor,0,IntToStr(nit),3,0,0);
            //auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
            consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE ANTIGUEDAD');
          end
          else
            auxiliarcon(22,consecutivo,'C',valor);
          auxiliarcon(22,consecutivo,'D',valor_actual);
        end // fin del 40
        else if tipo = 60 then
        begin
          auxiliarcon(39,consecutivo,'D',valor_consolidado);
          if cuenta <> 0 then
          begin
            auxiliar_con(8,consecutivo,'C',valor,0,IntToStr(nit),3,0,0);
            //auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
            consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE ANTIGUEDAD');
          end
          else
            auxiliarcon(65,consecutivo,'C',valor);
          auxiliarcon(65,consecutivo,'D',valor_actual);
        end // fin del 40
        else if tipo = 30 then
        begin
           auxiliarcon(39,consecutivo,'D',valor_consolidado);
           if cuenta <> 0 then
           begin
              auxiliar_con(8,consecutivo,'C',valor,cuenta,IntToStr(nit),3,0,0);
              //auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
              consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE ANTIGUEDAD');
           end
           else
              auxiliarcon(38,consecutivo,'C',valor);
           auxiliarcon(38,consecutivo,'D',valor_actual);
        end // fin del 30
        else if tipo = 50 then
        begin
          auxiliarcon(39,consecutivo,'D',valor_consolidado);
          if cuenta <> 0 then
          begin
            auxiliar_con(8,consecutivo,'C',valor,cuenta,IntToStr(nit),3,0,0);
            consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE ANTIGUEDAD');
          end
          else
            auxiliarcon(57,consecutivo,'C',valor);
           auxiliarcon(57,consecutivo,'D',valor_actual);
        end // fin del 50
        else
        begin
          consecutivo := comprobantes('PAGO PRIMA DE ANTIGUEDAD '+ empleado.Text + ' '+ FormatDateTime('mmmm/yyyy',Date),'1');
          if retefuente(DataQuerys.IBaportes,nit,2,valor) <> 0 then //verifica retefuente
          begin
             Vmonto_retefuente := 0;
             Vmonto_retefuente := (0.75 * valor);
             auxiliar_con(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor),0,IntToStr(nit),3,Vmonto_retefuente,tasaretefuente(nit).tasa);
             //auxiliarcon(9,consecutivo,'C',retefuente(DataQuerys.IBaportes,nit,2,valor));
             valor := valor - retefuente(DataQuerys.IBaportes,nit,2,valor);
             obligacion(13,nit,(retefuente(DataQuerys.IBaportes,nit,2,valor)+selobligacion(13,nit)));
          end;

          //
           if cuenta = 0 then
           begin
             auxiliarcon(vcodigopuc(nit),consecutivo,'C',valor);
           end
           else
           begin
             auxiliar_con(8,consecutivo,'C',valor,cuenta,IntToStr(nit),3,0,0);
             consignacion(cuenta,consecutivo,valor,'PAGO PRIMA DE ANTIGUEDAD');
           end;
            auxiliarcon(28,consecutivo,'D',valor_actual);
            auxiliarcon(39,consecutivo,'D',valor_consolidado);
        end; // fin general
        obligacion(5,nit,valor);
        with DataQuerys.IBingresa do
        begin
             Close;
             verificatransaccion(DataQuerys.IBingresa);
             SQL.Clear;
             SQL.Add('update "nom$consolidado" set');
             SQL.Add('"nom$consolidado"."prima_ant" = :valor');
             SQL.Add('where "nom$consolidado"."nit" = :nit');
             ParamByName('nit').AsInteger := nit;
             ParamByName('valor').AsCurrency := 0;
             Open;
             Close;
             Transaction.Commit;
        end;
        actualizarcomprobante(consecutivo);
        reporte;
        tipo_prima := 4;
        insertar;
end;

procedure TFrmPrimas.Button1Click(Sender: TObject);
begin
        consecutivo := 3429;
        reporte;
end;

procedure TFrmPrimas.Int_Cesantias;
var   ptotal,saldo_prima :Currency;
begin
        total := 0;
        with IBbusca do
        begin
        Close;
        verificatransaccion(IBbusca);
        IBbusca.ParamByName('tipo').AsInteger := 50;
        IBbusca.ParamByName('nit').AsInteger := 50;
        IBbusca.ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',Date));
        Open;
        if RecordCount <> 0 then
        begin
        if MessageDlg('El Pago de los Interes ya fue Efectuado'+#13+'segun Nota contable No. ' + FieldByName('comprobante').AsString + 'Desea ver la Nota',mtInformation,[mbYes,mbNo],0) = mrYes Then
        begin
          consecutivo := FieldByName('comprobante').AsInteger;
          reporte;
          Exit;
        end
        else
          Exit;
        end;
        Close;
        end;// fin ibbusca
          FrmQuerys := TFrmQuerys.Create(self);
          FrmProgresos := TFrmProgresos.Create(self);
          consecutivo := comprobantes('PAGO INTERES CESANTIAS '+FormatDateTime('mmmm "de" yyyy',date),'1');
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('*');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('where ("nom$empleado"."tipo_nomina" BETWEEN 10 AND 20)');
          Open;
          Last;
          First;
          frmProgresos.Max := RecordCount;
          frmProgresos.Titulo := 'Realizando Pago Interes Cesantias';
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            FrmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Registro No : '+IntToStr(RecNo);
            Application.ProcessMessages;
            nit := FieldByName('nitempleado').AsInteger;
            cuenta := FieldByName('numero_cuenta').AsInteger;
            valor := interes(nit);
            if cuenta = 0 then
            begin
               auxiliarcon(vcodigopuc(nit),consecutivo,'C',valor);
            end
            else
            begin
            auxiliaraho(8,consecutivo,nit,'C',valor,IntToStr(cuenta));
            consignacion(cuenta,consecutivo,valor,'PAGO INTERES CESANTIAS');
            end;
            total := valor+total;
            //obligacion(8,nit,(valor+selobligacion(8,nit)));
            Next;
          end;// FIN DEL WHILE
          Close;
        end;//FIN DEL WITH
           saldo_prima := total - abs(saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),24,1));
           if saldo_prima > 0 then
           begin
              auxiliarcon(30,consecutivo,'D',saldo_prima);
              total := total - saldo_prima;
           end;
           auxiliarcon(24,consecutivo,'D',total);
           actualizarcomprobante(consecutivo);
           tipo_prima := 50;
           nit := 50;
           insertar;
           frmProgresos.Cerrar;
           reporte;
end;

procedure TFrmPrimas.auxiliar_con(codigo_puc, consecutivo: integer;
  tipo: string; valor: Currency; cuenta: Integer; id_persona: string;
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
