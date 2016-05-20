unit UnitVacaciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, IBCustomDataSet, IBQuery, JvEdit,
  JvTypedEdit, ComCtrls, Buttons, pr_Common, pr_TxClasses, IBDatabase, Math, jcldatetime,DateUtils, StrUtils;

type
  TFrmVacaciones = class(TForm)
    busca_nombre: TIBQuery;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    empleado: TComboBox;
    empleadonit: TComboBox;
    seccion: TEdit;
    Label1: TLabel;
    nomina: TEdit;
    Label4: TLabel;
    Panel2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    salario: TJvCurrencyEdit;
    Label8: TLabel;
    Label9: TLabel;
    Fecha_ini: TDateTimePicker;
    Fecha_salida: TDateTimePicker;
    Label10: TLabel;
    salida: TComboBox;
    Panel3: TPanel;
    Label11: TLabel;
    obsevaciones: TMemo;
    Panel4: TPanel;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    BACEPTAR: TBitBtn;
    Label12: TLabel;
    periodo: TJvYearEdit;
    nodias: TJvEdit;
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
    BTreporte: TSpeedButton;
    IBbusca: TIBQuery;
    Panel5: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Dia1: TJvEdit;
    Dia2: TJvEdit;
    procedure FormCreate(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure Fecha_iniExit(Sender: TObject);
    procedure Fecha_salidaExit(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure Fecha_iniKeyPress(Sender: TObject; var Key: Char);
    procedure Fecha_salidaKeyPress(Sender: TObject; var Key: Char);
    procedure salidaKeyPress(Sender: TObject; var Key: Char);
    procedure obsevacionesKeyPress(Sender: TObject; var Key: Char);
    procedure nodiasExit(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure obsevacionesExit(Sender: TObject);
    procedure nodiasEnter(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure BTreporteClick(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure nodiasKeyPress(Sender: TObject; var Key: Char);
    procedure salidaExit(Sender: TObject);
  private
  nit_emp :Integer;
  sueldo_basico :Currency;
  punto :Boolean;
  cuenta :string;
  tipo_salida :Char;
  codigo_nomina :Integer;
  Control_l :Boolean;
  cod_vacaciones :Integer;
  tipo_s,tipo_e :string;
  fecha_vacaciones :TDate;

    procedure limpiar;
    procedure entra_datos;
    procedure act_descuentos;
    procedure descuento(nodias, fecha: Variant; codigo_nomina:integer);
    procedure contable;
    procedure reporte;
    procedure calculaDias;
    procedure actualizarDescuentos;

    { Private declarations }
  public
    consecutivo :Integer;
    tipos_nomina :Integer;
    { Public declarations }
  end;

var
  FrmVacaciones: TFrmVacaciones;

implementation

uses UnitQuerys,unitglobal, UnitRealizaNomina,Unitvistapreliminar,
  UnitPrincipal, UnitdataQuerys, UnitNomina;

{$R *.dfm}

procedure TFrmVacaciones.FormCreate(Sender: TObject);
begin
        Fecha_salida.DateTime := Date;
        Fecha_ini.DateTime := Date;
        with DataQuerys.IBselecion do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Clear;
          SQL.Add('select "inv$empleado"."nombre","inv$empleado"."apellido"  from "inv$empleado"');
          SQL.Add('where "inv$empleado"."nit" in (');
          SQL.Add('select "nom$empleado"."nitempleado" from "nom$empleado")');          
          SQL.Add('order by "inv$empleado"."nombre"');
          Open;
          while not Eof do
          begin
            empleado.Items.Add(FieldByName('nombre').AsString + ' ' + fieldbyname('apellido').AsString);
            empleadonit.Items.Add(FieldByName('nombre').AsString + fieldbyname('apellido').AsString);
            Next;
             end;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmVacaciones.empleadoExit(Sender: TObject);
var     a :Integer;
        b: string;
begin
        BTreporte.Enabled := False;
        BACEPTAR.Enabled := True;
        punto := false;
        Control_l := True;
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        busca_nombre.Close;
        busca_nombre.parambyname('nombre').AsString := b;
        busca_nombre.Open;
        nit_emp := busca_nombre.fieldbyname('nit').AsInteger;
        seccion.Text := busca_nombre.fieldbyname('nombre').AsString;
        busca_nombre.Close;
        if nit_emp = 0 then
        begin
          MessageDlg('El Nombre del Empleado no es Correcto',mtInformation,[mbOK],0);
          empleado.SetFocus;
          Exit;
        end;
        with IBbusca do
        begin
        Close;
        verificatransaccion(IBbusca);
        ParamByName('tipo').AsInteger := 101;
        ParamByName('nit').AsInteger := nit_emp;
        ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/01/01',Date));
        Open;
        if RecordCount <> 0 then
        begin
        if MessageDlg('El Pago de las Vacaciones ya fue Efectuado'+#13+'segun Nota contable No. ' + FieldByName('comprobante').AsString + ' Desea ver la Nota',mtInformation,[mbYes,mbNo],0) = mrYes Then
        begin
          consecutivo := FieldByName('comprobante').AsInteger;
          reporte;
          empleado.SetFocus;
          Exit;
        end
        else
          empleado.SetFocus;
          Exit;
        end;
        Close;
        end;
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$tiponomina"."descripcion","nom$empleado"."sueldobasico",');
          SQL.Add('"nom$empleado"."numero_cuenta","nom$empleado"."tipo_nomina"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado",');
          SQL.Add('"nom$tiponomina"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."tipo_nomina" = "nom$tiponomina"."codigo") AND');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          nomina.Text := FieldByName('descripcion').AsString;
          sueldo_basico := FieldByName('sueldobasico').AsCurrency;
          cuenta := FieldByName('numero_cuenta').AsString;
          tipos_nomina := FieldByName('tipo_nomina').AsInteger;
          Close;
        end;
end;
procedure TFrmVacaciones.Fecha_iniExit(Sender: TObject);
begin
        periodo.Value := StrToInt(FormatDateTime('yyyy',Fecha_ini.DateTime));
        Fecha_salida.DateTime := Fecha_ini.DateTime + int(StrToFloat(nodias.Text));
        calculaDias;
end;

procedure TFrmVacaciones.Fecha_salidaExit(Sender: TObject);
begin
        periodo.Value := StrToInt(FormatDateTime('yyyy',Fecha_ini.DateTime));
        Fecha_salida.DateTime := Fecha_ini.DateTime + int(StrToFloat(nodias.Text));
        calculaDias;
end;

procedure TFrmVacaciones.empleadoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           nodias.SetFocus;
end;

procedure TFrmVacaciones.Fecha_iniKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           salida.SetFocus
end;

procedure TFrmVacaciones.Fecha_salidaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           salida.SetFocus;
end;

procedure TFrmVacaciones.salidaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           obsevaciones.SetFocus;
end;

procedure TFrmVacaciones.obsevacionesKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           BACEPTAR.SetFocus;
end;

procedure TFrmVacaciones.nodiasExit(Sender: TObject);
var dias,promedio :Currency;
    dia1 :Real;
begin
        if nodias.Text <> '' then
        begin
        dias := StrToCurr(nodias.Text);
        dia1 := StrToFloat(nodias.Text);
        promedio := sueldo_basico/30;
        salario.Value := SimpleRoundTo((dias * promedio),0);
        end;
        Fecha_salida.DateTime := Fecha_ini.DateTime + int(dia1);
end;

procedure TFrmVacaciones.limpiar;
begin
        empleado.ItemIndex := -1;
        seccion.Text := '';
        nomina.Text := '';
        nodias.Text := '';
        salario.Value := 0;
        salida.ItemIndex := -1;
        obsevaciones.Text := '';
        empleado.SetFocus;
end;

procedure TFrmVacaciones.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmVacaciones.obsevacionesExit(Sender: TObject);
begin
        obsevaciones.Text := UpperCase(obsevaciones.Text);
end;

procedure TFrmVacaciones.nodiasEnter(Sender: TObject);
begin
        punto := False;
        nodias.Text := '';
end;

procedure TFrmVacaciones.BACEPTARClick(Sender: TObject);
begin
        if salida.ItemIndex = 0 then
        begin
           tipo_salida := 'M';
           tipo_s := '07:40 A.M.';
           if Frac(StrToCurr(nodias.Text)) <> 0 then
              tipo_e := '01:40 P.M'
           else
              tipo_e := '07:40 A.M';
        end
        else
        begin
           tipo_salida := 'T';
           tipo_s := '01:40 P.M.';
           if Frac(StrToCurr(nodias.Text)) <> 0 then
              tipo_e := '07:40 A.M'
           else
              tipo_e := '01:40 P.M';
        end;
        if (nodias.Text = '') or ( nodias.Text = '.') then
        begin
           MessageDlg('El Campo "No. de Dias" No puede ser Nulo',mtInformation,[mbOK],0);
           nodias.SetFocus;
        end
        else if salida.Text = '' then
        begin
           MessageDlg('El Campo "Hora Salida" No puede ser Nulo',mtInformation,[mbOK],0);
           salida.SetFocus;
        end
        else
        begin
        if MessageDlg('Seguro de Registrar el Pago de las Vacaciones.',mtInformation,[mbYes,mbNo],0) = mrYes Then
        begin
          contable;
          entra_datos;
          with DataQuerys.IBingresa do
          begin
            Close;
            verificatransaccion(DataQuerys.IBingresa);
            SQL.Clear;
            SQL.Add('insert into "nom$control"');
            SQL.Add('values (');
            SQL.Add(':tipo,:fecha,:nit,:comprobante)');
            ParamByName('tipo').AsInteger := 101;
            ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/01/01',Date));
            ParamByName('nit').AsInteger := nit_emp;
            ParamByName('comprobante').AsInteger := consecutivo;
            Open;
            Close;
            Transaction.Commit;
          end;
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('update "nom$vacaciones"');
          SQL.Add('set "nom$vacaciones"."comprobante" = :consecutivo');
          SQL.Add('where "nom$vacaciones"."codigo" = :cod_vacaciones');
          ParamByName('consecutivo').AsInteger := consecutivo;
          ParamByName('cod_vacaciones').AsInteger := cod_vacaciones;
          Open;
          Close;
          Transaction.Commit;
        end;
          act_descuentos;
          reporte;
          BTreporte.Enabled := True;
        end
        else
        empleado.SetFocus;
end;
end;

procedure TFrmVacaciones.entra_datos;
var     ano:Integer;
        fecha_reg :TDate;
        fecha_vac: string;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"nom$empleado"."fecha_registro"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          fecha_reg := FieldByName('fecha_registro').AsDateTime;
          Close;
        end;
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$vacaciones"."fecha_vacaciones"');
          SQL.Add('FROM');
          SQL.Add('"nom$vacaciones"');
          SQL.Add('WHERE');
          SQL.Add('("nom$vacaciones"."nitempleado" = :nit) and');
          SQL.Add('("nom$vacaciones"."fechasalida" = ( select max("nom$vacaciones"."fechasalida")');
          SQL.Add('from "nom$vacaciones"');
          SQL.Add('where ("nom$vacaciones"."nitempleado" = :nit)))');
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          fecha_vacaciones := FieldByName('fecha_vacaciones').AsDateTime;
          Close;
        end;
         if fecha_vacaciones = 0 then
            fecha_vacaciones := fecha_reg;
          ano := StrToInt(formatdatetime('yyyy',fecha_vacaciones)) + 1;
          fecha_vacaciones := StrToDate(FormatDateTime(IntToStr(ano)+'/mm/dd',fecha_vacaciones));
          fecha_vac := DateToStr(fecha_vacaciones);
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('select max("nom$vacaciones"."codigo")as codigo from "nom$vacaciones"');
          Open;
          cod_vacaciones := FieldByName('codigo').AsInteger + 1;
          SQL.Clear;
          SQL.Add('insert into "nom$vacaciones"');
          SQL.Add('values (');
          SQL.Add(':codigo,:nitempleado,:fechasalida,');
          SQL.Add(':fechareintegro,:observaciones,:devengado,');
          SQL.Add(':numero_dias,:salida,:comprobante,:entrada,:fecha_vacaciones)');
          ParamByName('codigo').AsInteger := cod_vacaciones;
          ParamByName('nitempleado').AsInteger := nit_emp;
          ParamByName('fechasalida').AsDateTime := Fecha_ini.DateTime;
          ParamByName('fechareintegro').AsDateTime := Fecha_salida.DateTime;
          ParamByName('observaciones').AsString := obsevaciones.Text;
          ParamByName('devengado').AsCurrency := salario.Value;
          ParamByName('numero_dias').AsString := nodias.Text;
          ParamByName('salida').AsString := tipo_s;
          ParamByName('comprobante').AsInteger := 0;
          ParamByName('fecha_vacaciones').AsDate := fecha_vacaciones;
          ParamByName('entrada').AsString := tipo_e;
          Open;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmVacaciones.act_descuentos;
const  desc :currency = 0.5;
var    fecha_inicio,fecha_fin,dias_habiles :string;
       no_diasactual,no_diasiguiente,nodiasmes :Currency;
       no_diassalida,diasmes :Integer;
begin
        codigo_nomina := buscanomina(DataQuerys.IBselecion);
        if StrToCurr(Dia1.Text) > 0 then
            descuento(Dia1.Text,Fecha_ini.DateTime,codigo_nomina);
        if StrToCurr(Dia2.Text) > 0 then
        begin
          codigo_nomina := codigo_nomina+1;
          descuento(Dia2.Text,Fecha_salida.DateTime,codigo_nomina);
        end;
{        dias_habiles := IntToStr(periodo.Value);
        diasmes := DaysInAMonth(YearOfDate(Date),MonthOfDate(Fecha_ini.Date));
        codigo_nomina := buscanomina(DataQuerys.IBselecion);
        fecha_inicio := FormatDateTime('yyyy/mm',Fecha_ini.DateTime);
        fecha_fin := FormatDateTime('yyyy/mm',Fecha_salida.DateTime);
        no_diassalida := StrToInt(FormatDateTime('d',Fecha_ini.DateTime));
        if no_diassalida >= 25 then
           descuento(StrToCurr(nodias.Text),Fecha_salida.DateTime,codigo_nomina + 1)
        else
        begin
        if fecha_inicio = fecha_fin then
           begin
             nodiasmes := StrToCurr(FormatDateTime('dd',Fecha_ini.DateTime))+StrToCurr(nodias.Text);
             if nodiasmes > 30 then
             begin
               MessageDlg('Verifique la Fecha de Reintegro, No concuerda'+#13+'Con el Numero de dias',mtInformation,[mbOK],0);
               Fecha_salida.SetFocus;
               Control_l := False;
               Exit;
             end;
           descuento(nodias.Text,Fecha_ini.DateTime,codigo_nomina);
        end
        else if (fecha_inicio <> fecha_fin) then
        begin
           Control_l := true;
           no_diasactual := 1 + diasmes - StrToCurr(FormatDateTime('dd',Fecha_ini.DateTime));
           no_diasiguiente := StrToCurr(nodias.Text)-no_diasactual;
           if salida.ItemIndex = 1 then
           begin
              no_diasactual := no_diasactual - desc;
              no_diasiguiente := StrToCurr(nodias.Text)-no_diasactual;
           end;
           descuento(no_diasactual,Fecha_ini.DateTime,codigo_nomina);
           codigo_nomina := codigo_nomina+1;
           descuento(no_diasiguiente,Fecha_salida.DateTime,codigo_nomina);
       end;
       end;    }

end;

procedure TFrmVacaciones.descuento(nodias, fecha: Variant;codigo_nomina:integer);
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('insert into "nom$descuento"');
          SQL.Add('values (');
          SQL.Add(':cod_nomina,:nit_empleado,:fecha,');
          SQL.Add(':numero_dias,:motivo)');
          ParamByName('cod_nomina').AsInteger := codigo_nomina;
          ParamByName('nit_empleado').AsInteger := nit_emp;
          ParamByName('fecha').AsDateTime := fecha;
          ParamByName('numero_dias').AsString := nodias;
          ParamByName('motivo').AsString := 'DESCUENTO POR VACACIONES';
          Open;
          Close;
          Transaction.Commit;
        end;

end;

procedure TFrmVacaciones.contable;
var     totalvacaciones,restovacaciones :Currency;
        vacaciones,total_vac,rete,valor_consignar :Currency;
begin   {descripcion de variables
        vacaciones : extrae el total de vacaciones consolidads del empleado
        total_vac : vacaciones consolidadas
        total vacaciones : resto de vacaciones en caso de que las consolidadas no cubran el total de las vacaciones
        restovacaciones : valor para actualizar las vacaciones consolidadas de los empleados
        rete : valor retefuente de los empleados si lo poseen
        valor_consignar : devengado por el empleado despues del los descuentos}
        totalvacaciones := 0;
        vacaciones := consolidar(nit_emp,1);
        FrmQuerys := TFrmQuerys.Create(self);
        valor_consignar := salario.Value;
        if tipos_nomina in [10,20] then
           consecutivo := comprobantes('PAGO VACACIONES '+empleado.Text+' ' + nodias.Text + ' DIAS SOBRE ' + CurrToStr(sueldo_basico) + ' CONSIG AHORROS','1')
        else
           consecutivo := comprobantes('PAGO VACACIONES '+empleado.Text+' ' + nodias.Text + ' DIAS SOBRE ' + CurrToStr(sueldo_basico) + ' CONSIG AHORROS','2');
        if (valor_consignar > vacaciones) then
        begin
          total_vac := vacaciones;
          totalvacaciones := valor_consignar - vacaciones;
          restovacaciones := 0;
        end
        else
        begin
          total_vac := valor_consignar;
          restovacaciones := vacaciones - valor_consignar;
        end;
        if retefuente(DataQuerys.IBaportes,nit_emp,2,valor_consignar) > 0 then begin
           rete := retefuente(DataQuerys.IBaportes,nit_emp,2,valor_consignar );
           valor_consignar := valor_consignar - rete;
           auxiliarcon(9,consecutivo,'C',rete);
           obligacion(13,nit_emp,(rete + selobligacion(13,nit_emp)));
        end;
        if tipos_nomina in [30,40,50,60] then // valida si el empleado
        begin
          if tipos_nomina = 30 then
          begin
             auxiliarcon(37,consecutivo,'D',total_vac);
             if cuenta <> '0' then begin
                auxiliaraho(8,consecutivo,nit_emp,'C',valor_consignar,cuenta);
                consignacion(StrToInt(cuenta),consecutivo,valor_consignar,'PAGO VAC. AL EMP.' + leftstr(empleado.Text,25));
             end
             else if vCodigoPuc(nit_emp) <> -1 then
                  auxiliarcon(vCodigoPuc(nit_emp),consecutivo,'C',valor_consignar)
             else
               auxiliarcon(38,consecutivo,'C',valor_consignar);
             auxiliarcon(38,consecutivo,'D',totalvacaciones);
          end
          else if tipos_nomina = 40 then
          begin
             auxiliarcon(37,consecutivo,'D',total_vac);
             if cuenta <> '0' then begin
                auxiliaraho(8,consecutivo,nit_emp,'C',valor_consignar,cuenta);
                consignacion(StrToInt(cuenta),consecutivo,valor_consignar,'PAGO VAC. AL EMP.' + leftstr(empleado.Text,25));
             end
             else if vCodigoPuc(nit_emp) <> -1 then
                  auxiliarcon(vCodigoPuc(nit_emp),consecutivo,'C',valor_consignar)
             else
               auxiliarcon(22,consecutivo,'C',valor_consignar);
             auxiliarcon(22,consecutivo,'D',totalvacaciones);
          end
          else if tipos_nomina = 50 then
          begin
             auxiliarcon(37,consecutivo,'D',total_vac);
             if cuenta <> '0' then begin
                auxiliaraho(8,consecutivo,nit_emp,'C',valor_consignar,cuenta);
                consignacion(StrToInt(cuenta),consecutivo,valor_consignar,'PAGO VAC. AL EMP.' + leftstr(empleado.Text,25));
             end
             else if vCodigoPuc(nit_emp) <> -1 then
                  auxiliarcon(vCodigoPuc(nit_emp),consecutivo,'C',valor_consignar)
             else
               auxiliarcon(57,consecutivo,'C',valor_consignar);
             auxiliarcon(57,consecutivo,'D',totalvacaciones);
          end
          else if tipos_nomina = 60 then
          begin
             auxiliarcon(37,consecutivo,'D',total_vac);
             if cuenta <> '0' then begin
                auxiliaraho(8,consecutivo,nit_emp,'C',valor_consignar,cuenta);
                consignacion(StrToInt(cuenta),consecutivo,valor_consignar,'PAGO VAC. AL EMP.' + leftstr(empleado.Text,25));
             end
             else if vCodigoPuc(nit_emp) <> -1 then
                  auxiliarcon(vCodigoPuc(nit_emp),consecutivo,'C',valor_consignar)
             else
               auxiliarcon(65,consecutivo,'C',valor_consignar);
             auxiliarcon(65,consecutivo,'D',totalvacaciones);
          end;
        end
        else
        begin
        auxiliarcon(37,consecutivo,'D',total_vac);
        auxiliarcon(25,consecutivo,'D',totalvacaciones);
        if StrToInt(cuenta) = 0 then
        begin
          auxiliarcon(vcodigopuc(nit_emp),consecutivo,'C',valor_consignar);
        end
        else
        begin
          auxiliaraho(8,consecutivo,nit_emp,'C',valor_consignar,cuenta);
          consignacion(StrToInt(cuenta),consecutivo,valor_consignar,'PAGO VAC. AL EMP.' + leftstr(empleado.Text,25));
        end;
        end;
        obligacion(9,nit_emp,valor_consignar);
        with DataQuerys.IBingresa do
        begin
             Close;
             verificatransaccion(DataQuerys.IBingresa);
             SQL.Clear;
             SQL.Add('update "nom$consolidado" set');
             SQL.Add('"nom$consolidado"."vacaciones" = :valor');
             SQL.Add('where "nom$consolidado"."nit" = :nit');
             ParamByName('nit').AsInteger := nit_emp;
             ParamByName('valor').AsCurrency := restovacaciones;
             Open;
        end;
        actualizarcomprobante(consecutivo);
        BACEPTAR.Enabled := False;
end;

procedure TFrmVacaciones.reporte;
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
                 if QueryAuxiliar.FieldByName('ID_CUENTA').AsString <> '0' then
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
          consecutivo:=0;

end;

procedure TFrmVacaciones.BTreporteClick(Sender: TObject);
begin
        FrmNomina := TFrmNomina.Create(self);
        FrmNomina.IBvacaciones.Transaction.Commit;
        FrmNomina.IBvacaciones.Close;
        FrmNomina.frDBDataSet1.DataSet := FrmNomina.IBvacaciones;
        FrmNomina.IBvacaciones.ParamByName('codigo').AsInteger :=36;// cod_vacaciones;
        FrmNomina.IBvacaciones.Open;
        FrmNomina.imprimir_reporte(FrMain.wpath+'reportes\repvacaciones.frf');
        if Control_l then
          limpiar;
end;

procedure TFrmVacaciones.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmVacaciones.nodiasKeyPress(Sender: TObject; var Key: Char);
begin
        if Key =#13 then
          Fecha_ini.SetFocus
end;

procedure TFrmVacaciones.calculaDias;
var
        _iDiasActual :Currency;
        _iDiasSiguiente :Currency;
begin
        _iDiasActual := 0;
        _iDiasSiguiente := 0;
        if salida.ItemIndex = 1 then
        begin
          _iDiasActual := (DaysInMonth(Fecha_ini.DateTime) - DayOfTheMonth(Fecha_ini.DateTime)) + 0.5;
          if _iDiasActual < StrToCurr(nodias.Text) then
          _iDiasSiguiente := StrToCurr(nodias.Text) - _iDiasActual;
        end
        else
        begin
          _iDiasActual := (DaysInMonth(Fecha_ini.DateTime) - DayOfTheMonth(Fecha_ini.DateTime)) + 1;
          if _iDiasActual < StrToCurr(nodias.Text) then
          _iDiasSiguiente := StrToCurr(nodias.Text) - _iDiasActual;
        end;
        Dia1.Text := CurrToStr(_iDiasActual);
        Dia2.Text := CurrToStr(_iDiasSiguiente);
end;

procedure TFrmVacaciones.salidaExit(Sender: TObject);
begin
        calculaDias;
end;

procedure TFrmVacaciones.actualizarDescuentos;
begin

end;

end.
