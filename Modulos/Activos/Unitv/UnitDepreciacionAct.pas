unit UnitDepreciacionAct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,StrUtils, Buttons, ComCtrls, pr_Common, pr_TxClasses, DB,
  IBCustomDataSet, IBQuery,Math, Menus, IBSQL, IBDatabase, DBCtrls,
  ExtCtrls ;

type
  TFrmDepreciacionAct = class(TForm)
    Btncomprobante: TBitBtn;
    IBQTabla: TIBQuery;
    QueryComprobante: TIBQuery;
    QueryAuxiliar: TIBQuery;
    Report1: TprTxReport;
    ibagencia: TIBQuery;
    ibagenciadescripcion: TIBStringField;
    Btraslado: TBitBtn;
    QueryComprobanteID_COMPROBANTE: TIntegerField;
    QueryComprobanteFECHADIA: TDateField;
    QueryComprobanteDESCRIPCION: TMemoField;
    QueryComprobanteTOTAL_DEBITO: TIBBCDField;
    QueryComprobanteTOTAL_CREDITO: TIBBCDField;
    QueryComprobanteESTADO: TIBStringField;
    QueryComprobanteIMPRESO: TSmallintField;
    QueryComprobanteANULACION: TMemoField;
    QueryComprobanteDESCRIPCION1: TIBStringField;
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
    report2: TprTxReport;
    btraslado2: TBitBtn;
    report3: TprTxReport;
    DET1: TButton;
    report4: TprTxReport;
    ibaux: TIBQuery;
    DET2: TButton;
    IBSQL1: TIBSQL;
    IBsel: TIBQuery;
    IBtransel: TIBTransaction;
    IBdepreciacion: TIBQuery;
    IBTransaction1: TIBTransaction;
    IBegen: TIBQuery;
    IBTransaction2: TIBTransaction;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    oficinas: TLabel;
    cbagencia: TDBLookupComboBox;
    Label3: TLabel;
    Fecha_rep: TDateTimePicker;
    Label2: TLabel;
    Panel2: TPanel;
    Bejecutar: TBitBtn;
    Breporte: TBitBtn;
    ejecutacomp: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BejecutarClick(Sender: TObject);
    procedure BreporteClick(Sender: TObject);
    procedure BtncomprobanteClick(Sender: TObject);
    procedure BtrasladoClick(Sender: TObject);
    procedure Report1PrintComplete(Sender: TObject);
    procedure report2PrintComplete(Sender: TObject);
    procedure ejecutacompClick(Sender: TObject);
    procedure btraslado2Click(Sender: TObject);
    procedure DET1Click(Sender: TObject);
    procedure DET2Click(Sender: TObject);
    private
        consecutivo: Integer;
        codigo_cuenta: string;
        placa,clavedep,clavedepreciacion: string;
        total_clasemayor: Variant;
        depreciacion_mes: Currency;
        cod_oficina3,cod_oficina1,cod_oficina2: Integer;

    { Private declarations }
  public
  published
    procedure actualizaauxiliar(valor:Currency);
    procedure comprobante(cadena: string);
    procedure actualizaauxiliardeb(valor: currency);
    procedure actualizacomprobante;
    function buscacodigo(PLACA: STRING): INTEGER;
    procedure actoficina(valor: Currency; deb: Integer; comprobante:Integer; clave:string);
    procedure actualizacomprobante1(comprobante:Integer);
    procedure actcomp(comprobante: Integer;oficina:Integer;deb:integer);

    { Public declarations }
  end;

var
  FrmDepreciacionAct: TFrmDepreciacionAct;

implementation

uses UnitDatamodulo,unitglobal, UnitActivorep, UnitPrincipal,
  Unitdecomprobante, UnitComprobante, UnitVistaPreliminar, Unitprogreso,unitdata,
  UnitPantallaProgreso;

{$R *.dfm}

procedure TFrmDepreciacionAct.FormCreate(Sender: TObject);
begin
        IBegen.Open;
        IBegen.Last;
        cbagencia.KeyValue := 1;
        Label3.Caption := FormatDateTime('mmmm " de "yyyy',Date);
        Fecha_rep.DateTime := Date;
        Fecha_rep.MaxDate := StrToDate(FormatDateTime('yyyy/mm/dd',Date));
        dmcomprobante := Tdmcomprobante.Create(self);
end;

procedure TFrmDepreciacionAct.BejecutarClick(Sender: TObject);
var     codigo_clase: Integer;
        total_clase: Variant;
        descripcion_clase,fecha_control,control_dep: string;
        control_fecha,control_actual,clave_mayor: string;
        progreso3,progreso4: Integer;
begin
        if MessageDlg('Esta Seguro de Realizar la Depreciación?',mtinformation,[mbyes,mbno],0) = mryes then
        begin
          progreso4 := 0;
          with DataGeneral.IBsel3 do
          begin
            Close;
             if Transaction.InTransaction then
                Transaction.Commit;
             Transaction.StartTransaction;
             SQL.Clear;
             SQL.Add('select max("act$controldepreciacion"."fecha") as control from "act$controldepreciacion"');
             SQL.Add('where "act$controldepreciacion"."codigo" = :cod_agencias');
             ParamByName('cod_agencias').AsInteger := cbagencia.KeyValue;
             open;
             fecha_control := FieldByName('control').AsString;
             Close;
             Transaction.Commit;
          end;
          if fecha_control = '' then
            fecha_control := '1977/06/12';
            control_fecha:=FormatDateTime('mm/yy',StrToDateTime(fecha_control));
            control_actual:=FormatDateTime('mm/yy',Date);
          if control_fecha <> control_actual then
          begin
            with DataGeneral.IBsel1 do
            begin
             Close;
             SQL.Clear;
             SQL.Add('SELECT');
             SQL.Add('count(*) AS "progreso2"');
             SQL.Add('FROM');
             SQL.Add('"act$activo",');
             SQL.Add('"act$traslado"');
             SQL.Add('WHERE');
             SQL.Add('("act$activo"."esactivo" = 1) AND');
             SQL.Add('("act$activo"."estado" = :estado) AND');
             SQL.Add('("act$activo"."cod_activo" = "act$traslado"."cod_activo") AND');
             SQL.Add('("act$traslado"."lugar" = :lugar) AND');
             SQL.Add('("act$traslado"."cod_oficina" = :cod)');
             ParamByName('estado').AsString:='A';
             ParamByName('lugar').AsString := 'A';
             ParamByName('cod').AsInteger := cbagencia.KeyValue;
             Open;
             progreso3 := FieldByName('progreso2').AsInteger;
             Close;
            end;
        frmProgresos := TfrmProgresos.Create(self);
        frmProgresos.Max := progreso3;
        frmProgresos.Min := 0;
        frmProgresos.Titulo := 'Realizando Depreciacion de : '+FormatDateTime('mmm-yyyy',Date);
        frmProgresos.Ejecutar;
           with IBdepreciacion do
           begin
             Close;
             SQL.Clear;
             SQL.Add('select distinct "Inv$Agencia"."cod_agencia","Inv$Agencia"."descripcion"');
             SQL.Add('from "Inv$Agencia","act$traslado"');
             SQL.Add('where "Inv$Agencia"."cod_agencia" = "act$traslado"."cod_oficina"');
             SQL.Add('and ("Inv$Agencia"."cod_agencia" = :cod_agencias)');
             ParamByName('cod_agencias').AsInteger := cbagencia.KeyValue;
             Open;
             while not Eof do
             begin
               comprobante('DEPRECIACION MENSUAL ACTIVOS FIJOS OF. '+FieldByName('descripcion').AsString);
               with DataGeneral.IBsel1 do
               begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select distinct "act$clase_activo"."clavemayor","act$clase_activo"."clavedep","act$clase_activo"."clavedepre"');
                 SQL.Add('from "act$clase_activo","act$activo"');
                 SQL.Add('where');
                 SQL.Add('"act$activo"."estado" = :"estado" and');
                 SQL.Add('"act$activo"."clase_activo"="act$clase_activo"."cod_clase"');
                 SQL.Add('and "act$clase_activo"."cod_clase" <> :"cod_clase"');
                 ParamByName('estado').AsString := 'A';
                 ParamByName('cod_clase').AsInteger := 1;
                 Open;
                 Last;
                 First;
                 while not DataGeneral.IBsel1.Eof do
                 begin
                   total_clasemayor := 0;
                   clave_mayor := FieldByName('clavemayor').AsString;
                   clavedep := FieldByName('clavedep').AsString;
                   clavedepreciacion := FieldByName('clavedepre').AsString;
                   with DataGeneral.IBdatos do
                   begin
                     Close;
                     SQL.Clear;
                     SQL.Add('select distinct "act$clase_activo"."cod_clase","act$clase_activo"."descripcion"');
                     SQL.Add('from "act$clase_activo","act$activo"');
                     SQL.Add('where "act$activo"."clase_activo"="act$clase_activo"."cod_clase" ');
                     SQL.Add('and "act$clase_activo"."clavemayor"=:"clave"');
                     ParamByName('clave').AsString := clave_mayor;
                     Open;
                     while not DataGeneral.IBdatos.Eof do // primer while
                     begin
                       total_clase := 0;
                       codigo_clase := FieldByName('cod_clase').AsInteger;
                       descripcion_clase := FieldByName('descripcion').AsString;
                       with DataGeneral.Ibacta do // busca activo
                       begin
                         Close;
                         SQL.Clear;
                         SQL.Add('SELECT DISTINCT');
                         SQL.Add('"act$activo"."placa"');
                         SQL.Add('From');
                         SQL.Add('"act$activo",');
                         SQL.Add('"act$clase_activo",');
                         SQL.Add('"act$traslado"');
                         SQL.Add('WHERE');
                         SQL.Add('("act$activo"."clase_activo" = "act$clase_activo"."cod_clase") AND');
                         SQL.Add('("act$activo"."estado" = :estado) AND');
                         SQL.Add('("act$activo"."clase_activo" = :clase) AND');
                         SQL.Add('("act$activo"."esactivo" = 1) AND');
                         SQL.Add('("act$traslado"."cod_activo" = "act$activo"."cod_activo") AND');
                         SQL.Add('("act$traslado"."lugar" = :lugar) AND');
                         SQL.Add('("act$traslado"."cod_oficina" = :cod_oficina)');
                         ParamByName('lugar').AsString := 'A';
                         ParamByName('estado').AsString := 'A';
                         ParamByName('clase').AsInteger := codigo_clase;
                         ParamByName('cod_oficina').AsInteger := ibdepreciacion.FieldByName('cod_agencia').AsInteger;
                         Open;
                         while not DataGeneral.Ibacta.Eof do // segundo while
                         begin
                           progreso4 := progreso4 + 1;
                           frmProgresos.Position := progreso4;
                           frmProgresos.InfoLabel := 'Activo No : '+IntToStr(progreso4);
                           Application.ProcessMessages;
                           placa := FieldByName('placa').AsString;
                           control_dep := FormatDateTime('mm/yy',StrToDateTime(deprecia(placa,'12')));
                           if ((StrToInt(deprecia(placa,'8'))) <= (StrToInt(deprecia(PLACA,'11')))) and (control_dep <> control_actual) then
                              depreciacion_mes := StrToCurr(deprecia(placa,'9'))
                           else
                              depreciacion_mes := 0;
                           total_clase := total_clase+depreciacion_mes;
                          Next;
                         end;//fin del segundo while
                         Close;
                       end;// fin de busca activo
                         total_clasemayor := total_clasemayor + total_clase;
                         DataGeneral.IBdatos.Next;
                   end;// fin del primer while
                        DataGeneral.IBdatos.Close;
                    if total_clasemayor > 0 then
                    begin
                      actualizaauxiliardeb(total_clasemayor); // bien
                      actualizaauxiliar(total_clasemayor);
                    end;
                      DataGeneral.IBTransaction1.CommitRetaining;
                      DataGeneral.IBsel1.Next;
                 end;
            end;
            DataGeneral.IBsel1.Close;
        end;//fin del busca clase
        with IBsel do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('insert into "act$controldepreciacion" values(');
          SQL.Add(':"codigo",:"fecha",:"comprobante")');
          ParamByName('codigo').AsInteger := IBdepreciacion.FieldByName('cod_agencia').AsInteger;
          ParamByName('fecha').AsDateTime := Date;
          ParamByName('comprobante').AsInteger := consecutivo;
          Open;
          Close;
          Transaction.Commit;
        end;
        actualizacomprobante;
        IBdepreciacion.Next;
        end;
        IBdepreciacion.Close;
        end;
          DataGeneral.IBTransaction1.CommitRetaining;
          frmProgresos.Cerrar;
          Btncomprobanteclick(Self);
        end
        else///   if del  controldepreoiacion
        begin
          ShowMessage('La Depreciacion Referente a ' + FormatDateTime('mmmm "de " yyyy',Date) + #13 +'para la Oficina ' + cbagencia.Text+' ya fue Efectuada');
        end;
        DataGeneral.IBTransaction1.CommitRetaining;
        ejecutacomp.SetFocus;
        end
        else
        cbagencia.SetFocus;
end;

procedure TFrmDepreciacionAct.BreporteClick(Sender: TObject);
var     fecha_control,fecha,fecha1,a,b,fecha_entrada,fecha_actual :string;
        conteo:Integer;
begin
        FrmActivos := TFrmActivos.Create(self);
        a := FormatDateTime('yyyy/mm',Fecha_rep.DateTime);
        b := FormatDateTime('yyyy/mm',Date);
        a := a + '/01';
        b := b + '/01';
        fecha_entrada := DateToStr(StrToDate(FormatDateTime('yyyy/mm/"01"',Fecha_rep.DateTime)));
        fecha_actual := FormatDateTime('yyyy/mm/"01"',Date );
        if StrToDate(fecha_entrada) = StrToDate(fecha_actual) then
        begin
        if validafecha = False then
        begin
           MessageDlg('No se ha Realizado la Depreciacion del mes Actual',mtInformation,[mbOK],0);
           Exit;
        end;
        end;
        if StrToDateTime(a) > StrToDateTime(b) then
        begin
          ShowMessage('La Fecha A Consultar no Debe Ser Mayor a la Fecha Actual');
          Exit;
        end;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select max("act$controldepreciacion"."fecha") as control from "act$controldepreciacion"');
          Open;
          fecha_control := DateTimeToStr(FieldByName('control').AsDateTime);
          Close;
        end;
        if FrMain.validarep = 1 then
        begin
          FrmActivos.tiempo.Date := Date;
          fecha_control := FormatDateTime('dd/mm/yy',StrToDateTime(fecha_control));
        end
        else
        begin
          FrmActivos.tiempo.Date:=Fecha_rep.Date;
          fecha_control:=FormatDateTime('dd/mm/yy',FrmActivos.tiempo.DateTime);
        end;
          fecha := FormatDateTime('yy',FrmActivos.tiempo.DateTime);
          conteo := StrToInt(fecha);
          conteo := conteo - 1;
        if conteo <= 9 then
          fecha1 := '0' + IntToStr(conteo)
        else
          fecha1 := IntToStr(conteo);
          FrmActivos.fecha_depreciacion := fecha_control;
          FrmActivos.tantes := fecha1;
          FrmActivos.tactual := fecha;
          FrmActivos.depreciar;
end;
procedure TFrmDepreciacionAct.actualizaauxiliar(valor:Currency);

begin
        with dmcomprobante.Ibdatos1 do
        begin
          Close;
             if Transaction.InTransaction then
                Transaction.Commit;
             Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('select "con$puc".CODIGO from "con$puc"');
          SQL.Add('where "con$puc".CLAVE=:"clave"');
          ParamByName('clave').AsString := clavedep;
          Open;
          codigo_cuenta := FieldByName('CODIGO').AsString;
          Close;
          Transaction.Commit;
        end;
        with dmcomprobante.ibbuscada do
        begin
          Close;
             if Transaction.InTransaction then
                Transaction.Commit;
             Transaction.StartTransaction;

          SQL.Clear;
          SQL.Add('insert into "con$auxiliar" values (');
          SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
          SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
          SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
          ParamByName('ID_COMPROBANTE').asInteger := consecutivo;
          ParamByName('ID_AGENCIA').AsInteger := 1;
          ParamByName('FECHA').AsDate := date;
          ParamByName('CODIGO').AsString := codigo_cuenta;
          ParamByName('DEBITO').AsCurrency := 0 ;
          ParamByName('CREDITO').AsCurrency := SimpleRoundTo(valor,0);
          ParamByName('ID_CUENTA').AsInteger := 0;
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
procedure TFrmDepreciacionAct.comprobante(cadena : string);
begin
        consecutivo := ObtenerConsecutivo(IBSQL1);
        with dmcomprobante.ibbuscada do
        begin
          Close;
             if Transaction.InTransaction then
                Transaction.Commit;
             Transaction.StartTransaction;

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
          ParamByName('TIPO_COMPROBANTE').AsInteger := 1;
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

procedure TFrmDepreciacionAct.actualizaauxiliardeb(valor: currency);
begin
         with dmcomprobante.Ibdatos1 do
         begin
           Close;
             if Transaction.InTransaction then
                Transaction.Commit;
             Transaction.StartTransaction;

           SQL.Clear;
           SQL.Add('select "con$puc".CODIGO from "con$puc"');
           SQL.Add('where "con$puc".CLAVE=:"clave"');
           ParamByName('clave').AsString := clavedepreciacion;
           Open;
           codigo_cuenta := FieldByName('CODIGO').AsString;
           Close;
           Transaction.Commit;
        end;
        with dmcomprobante.ibbuscada do
        begin
          Close;
             if Transaction.InTransaction then
                Transaction.Commit;
             Transaction.StartTransaction;

          SQL.Clear;
          SQL.Add('insert into "con$auxiliar" values (');
          SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
          SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
          SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
          ParamByName('ID_COMPROBANTE').asInteger := consecutivo;
          ParamByName('ID_AGENCIA').AsInteger := 1;
          ParamByName('FECHA').AsDate := date;
          ParamByName('CODIGO').AsString := codigo_cuenta;
          ParamByName('DEBITO').AsCurrency := SimpleRoundTo(valor,0) ;
          ParamByName('CREDITO').AsCurrency := 0;
          ParamByName('ID_CUENTA').AsInteger := 0;
          ParamByName('ID_COLOCACION').AsString := '';
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').AsString := '0';
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').AsFloat := 0;
          ParamByName('ESTADOAUX').AsString := 'O';
          Open;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmDepreciacionAct.actualizacomprobante;
var     debito,credito: Currency;
begin
        with dmcomprobante.IBQuery1 do
        begin
          Close;
             if Transaction.InTransaction then
                Transaction.Commit;
             Transaction.StartTransaction;

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
end;

function TFrmDepreciacionAct.buscacodigo(PLACA: STRING): integer;
var codigo:string;
begin
     with DataGeneral.IBsql DO
     begin
       Close;
       SQL.Clear;
       SQL.Add('select "act$traslado"."cod_oficina" from "act$traslado"');
       SQL.Add('where "act$traslado"."cod_activo"=(');
       SQL.Add('select "act$activo"."cod_activo" from "act$activo"');
       SQL.Add('where "act$activo"."placa" = :"placa")' );
       ParamByName('placa').AsString := PLACA;
       ExecQuery;
       codigo := FieldByName('cod_oficina').AsString;
       Close;
     end;
     if codigo='' then
       Result := 0
     else
       Result := StrToInt(codigo);
end;

procedure TFrmDepreciacionAct.BtncomprobanteClick(Sender: TObject);
var
        anulacion,tipo_nota: string;
        Tabla,oficina : string;
begin
        frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
          with DataGeneral.IBsel3 do
          begin
            Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
            SQL.Clear;
            SQL.Add('select "act$controldepreciacion"."comprobante" from "act$controldepreciacion"' );
            SQL.Add('where "act$controldepreciacion"."codigo" = :depreciacion and ');
            SQL.Add('"act$controldepreciacion"."fecha" =');
            SQL.Add('(select max("act$controldepreciacion"."fecha") from "act$controldepreciacion"');
            SQL.Add('where "act$controldepreciacion"."codigo" = :depreciacion)');
            ParamByName('depreciacion').AsInteger := cbagencia.KeyValue;
            Open;
            consecutivo := FieldByName('comprobante').AsInteger;
            Close;
            Transaction.Commit;
           end;
        with dmcomprobante.Ibdatos1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "con$comprobante".IMPRESO from "con$comprobante"');
          SQL.Add('where "con$comprobante".ID_COMPROBANTE =:"cod"');
          ParamByName('cod').AsInteger:=consecutivo;
          Open;
            {if InttoBoolean(FieldByName('IMPRESO').AsInteger) then
              frmVistaPreliminar.validareporte := True
            else
             frmVistaPreliminar.validareporte := False;}
          Close;
        end;
        with Querycomprobante do
        begin
          SQL.Clear;
          SQL.Add('Select "con$comprobante".ID_COMPROBANTE,');
          SQL.Add('"con$comprobante".FECHADIA,');
          SQL.Add('"con$comprobante".DESCRIPCION,');
          SQL.Add('"con$comprobante".TOTAL_DEBITO,');
          SQL.Add('"con$comprobante".TOTAL_CREDITO,');
          SQL.Add('"con$comprobante".ESTADO,');
          SQL.Add('"con$comprobante".IMPRESO,');
          SQL.Add('"con$comprobante".ANULACION,');
          SQL.Add('"con$tipocomprobante".DESCRIPCION AS DESCRIPCION1');
          SQL.Add(' from ');
          SQL.Add('"con$comprobante",');
          SQL.Add('"con$tipocomprobante"');
          SQL.Add('where "con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
          SQL.Add('and "con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA"');
          ParamByName('ID_COMPROBANTE').AsString := IntToStr(consecutivo);
          ParamByName('ID_AGENCIA').AsInteger := 1;
          Open;
          anulacion := FieldByName('ANULACION').AsString;
          if anulacion <> '' then
             Report1.Variables.ByName['anulacion'].AsString := 'Anulado por:'
          else
             Report1.Variables.ByName['anulacion'].AsString := '';
        end;
        with ibagencia do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "Inv$Agencia"."descripcion" from "Inv$Agencia"' );
          SQL.Add('where "Inv$Agencia"."cod_agencia"=:"codigo"');
          ParamByName('codigo').AsInteger := 1;
          Open;
          oficina := FieldByName('descripcion').AsString;
          Close;
        end;
          tipo_nota := 'NOTA CONTABLE';
        with Queryauxiliar do
        begin
          SQL.Clear;
          SQL.Add('select distinct ');
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
          ParamByName('ID_COMPROBANTE').AsString := IntToStr(consecutivo);
          ParamByName('ID_AGENCIA').AsInteger := 1;
          Open;
         end;
           Tabla := '"Comprobante' + FloatToStr(Now)+ '"';
           with IBQTabla do
            begin
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
                 else if trim(QueryAuxiliar.FieldByName('ID_COLOCACION').AsString) <> '' then
                    ParamByName('CREDCTA').AsString := QueryAuxiliar.FieldByName('ID_COLOCACION').AsString
                 else
                    ParamByName('CREDCTA').AsString := '';
                 if trim(QueryAuxiliar.FieldByName('ID_PERSONA').AsString) <> '' then
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
                 Open;
                 IBQTabla.Last;
                 IBQTabla.First;
                 IBQTabla.RecordCount;
                 Report1.Variables.ByName['empresa'].AsString := FrMain.Empresa;
                 Report1.Variables.ByName['hoy'].AsDateTime := Date;
                 Report1.Variables.ByName['Empleado'].AsString := empleados(UpperCase(FrMain.Dbalias));
                 Report1.Variables.ByName['Nit'].AsString := FrMain.Nit;
                 Report1.Variables.ByName['oficina'].AsString := oficina;
                 Report1.Variables.ByName['tiponota'].AsString := tipo_nota;
                 if Report1.PrepareReport then
                 begin
                   frmVistaPreliminar.Reporte := Report1;
                   frmVistaPreliminar.ShowModal;
                 end;
                 IBQTabla.Close;
                 Transaction.CommitRetaining;
                 With IBQTabla do
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

procedure TFrmDepreciacionAct.actoficina(valor: currency;
  deb:Integer; comprobante:Integer;clave:string);
var     codigo_cuenta,nombre:string;
        valor_cuenta,valor_cuenta1 : Currency;
begin
        if deb = 0 then
        begin
           valor_cuenta := valor;
           valor_cuenta1 := 0;
        end
        else
        begin
           valor_cuenta := 0;
           valor_cuenta1 := valor;
        end;
        with dmcomprobante.ibbuscada do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "con$puc".CODIGO,"con$puc".NOMBRE from "con$puc"');
          SQL.Add('where "con$puc".CLAVE= :"codigo"');
          ParamByName('codigo').AsString:=clave;
          Open;
          codigo_cuenta:=FieldByName('codigo').AsString;
          nombre := FieldByName('nombre').AsString;
          Close;
        end;
       with DataGeneral.IBdatos do
       begin
         Close;
         SQL.Clear;
         SQL.Add('insert into "con$auxiliartemp"');
         SQL.Add('values (');
         SQL.Add(':"comprobante",:"codigo",:"descripcion",:"debito",:"credito")');
         ParamByName('comprobante').AsInteger := comprobante;
         ParamByName('codigo').AsString := codigo_cuenta;
         ParamByName('descripcion').AsString := nombre;
         ParamByName('debito').AsCurrency := SimpleRoundTo(valor_cuenta,0);
         ParamByName('credito').AsCurrency := SimpleRoundTo(valor_cuenta1,0);
         Open;
         Close;
         Transaction.CommitRetaining;
         end;
       end;

procedure TFrmDepreciacionAct.actualizacomprobante1(comprobante:Integer);
var     debito,credito:Currency;
begin
        with dmcomprobante.IBQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select SUM("con$auxiliar"."DEBITO") as debito,SUM("con$auxiliar"."CREDITO") as credito');
          SQL.Add('from "con$auxiliar" where "con$auxiliar"."ID_COMPROBANTE"=:"comprobante"');
          ParamByName('comprobante').AsInteger:=comprobante;
          Open;
          debito:=FieldByName('debito').AsCurrency;
          credito:=FieldByName('credito').AsCurrency;
          SQL.Clear;
          SQL.Add('update "con$comprobante" set "con$comprobante".TOTAL_DEBITO =:"debito",');
          SQL.Add('"con$comprobante".TOTAL_CREDITO =:"credito"');
          SQL.Add('where "con$comprobante"."ID_COMPROBANTE"=:"comprobante"');
          ParamByName('comprobante').AsInteger:=comprobante;
          ParamByName('DEBITO').AsCurrency:=SimpleRoundTo(debito,0);
          ParamByName('CREDITO').AsCurrency:=SimpleRoundTo(credito,0);
          Open;
          Close;
          Transaction.CommitRetaining;
        end;
end;

procedure TFrmDepreciacionAct.BtrasladoClick(Sender: TObject);
var     anulacion,tipo_nota: string;
        Tabla,oficina : string;
begin
        if cod_oficina2 = 0 then
        begin
          with DataGeneral.IBsel3 do
          begin
            Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
            SQL.Clear;
            SQL.Add('select "act$controldepreciacion"."comprobante" from "act$controldepreciacion"' );
            SQL.Add('where "act$controldepreciacion"."codigo" = 2 and ');
            SQL.Add('"act$controldepreciacion"."fecha" =');
            SQL.Add('(select max("act$controldepreciacion"."fecha") from "act$controldepreciacion")');
            Open;
            consecutivo := FieldByName('comprobante').AsInteger;
            Close;
            Transaction.Commit;
           end;
          end
          else
            consecutivo := cod_oficina2;
        frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
        with dmcomprobante.Ibdatos1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "con$comprobante".IMPRESO from "con$comprobante"');
          SQL.Add('where "con$comprobante".ID_COMPROBANTE =:"cod"');
          ParamByName('cod').AsInteger:=consecutivo;
          Open;
            {if InttoBoolean(FieldByName('IMPRESO').AsInteger) then
              frmVistaPreliminar.validareporte := True
            else
               frmVistaPreliminar.validareporte := false;}
          Close;
        end;
        with Querycomprobante do
        begin
          SQL.Clear;
          SQL.Add('Select "con$comprobante".ID_COMPROBANTE,');
          SQL.Add('"con$comprobante".FECHADIA,');
          SQL.Add('"con$comprobante".DESCRIPCION,');
          SQL.Add('"con$comprobante".TOTAL_DEBITO,');
          SQL.Add('"con$comprobante".TOTAL_CREDITO,');
          SQL.Add('"con$comprobante".ESTADO,');
          SQL.Add('"con$comprobante".IMPRESO,');
          SQL.Add('"con$comprobante".ANULACION,');
          SQL.Add('"con$tipocomprobante".DESCRIPCION AS DESCRIPCION1');
          SQL.Add(' from ');
          SQL.Add('"con$comprobante",');
          SQL.Add('"con$tipocomprobante"');
          SQL.Add('where "con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
          SQL.Add('and "con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA"');
          ParamByName('ID_COMPROBANTE').AsString := IntToStr(consecutivo);
          ParamByName('ID_AGENCIA').AsInteger := 1;
          Open;
          anulacion := FieldByName('ANULACION').AsString;
          if anulacion <> '' then
             Report2.Variables.ByName['anulacion'].AsString := 'Anulado por:'
          else
             Report2.Variables.ByName['anulacion'].AsString := '';
        end;
        with ibagencia do
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
        with Queryauxiliar do
        begin
          SQL.Clear;
          SQL.Add('select distinct ');
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
         end;
           Tabla := '"Comprobante' + FloatToStr(Now)+ '"';
           with IBQTabla do
            begin
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
                 else if trim(QueryAuxiliar.FieldByName('ID_COLOCACION').AsString) <> '' then
                    ParamByName('CREDCTA').AsString := QueryAuxiliar.FieldByName('ID_COLOCACION').AsString
                 else
                    ParamByName('CREDCTA').AsString := '';
                 if trim(QueryAuxiliar.FieldByName('ID_PERSONA').AsString) <> '' then
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
              Open;
              IBQTabla.Last;
              IBQTabla.First;
              IBQTabla.RecordCount;
              report2.Variables.ByName['empresa'].AsString := FrMain.Empresa;
              report2.Variables.ByName['hoy'].AsDateTime := Date;
              report2.Variables.ByName['Empleado'].AsString := empleados(UpperCase(FrMain.Dbalias));
              report2.Variables.ByName['Nit'].AsString := FrMain.Nit;
              report2.Variables.ByName['oficina'].AsString := oficina;
              report2.Variables.ByName['tiponota'].AsString := tipo_nota;
              if report2.PrepareReport then
               begin
                 frmVistaPreliminar.Reporte := Report2;
                 frmVistaPreliminar.ShowModal;
               end;
              IBQTabla.Close;
              Transaction.CommitRetaining;
              With IBQTabla do
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

procedure TFrmDepreciacionAct.Report1PrintComplete(Sender: TObject);
begin
      with Dmcomprobante.IBQuery2 do
       begin
         SQL.Clear;
         SQL.Add('update "con$comprobante" set ');
         SQL.Add('"con$comprobante"."IMPRESO" = :"IMPRESO"');
         SQL.Add(' where ');
         SQL.Add('"con$comprobante"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and');
         SQL.Add('"con$comprobante"."ID_AGENCIA" = :"ID_AGENCIA"');
         ParamByName('ID_COMPROBANTE').AsString:= IntToStr(consecutivo);
         ParamByName('ID_AGENCIA').AsInteger := 1;
         ParamByName('IMPRESO').AsInteger  := Ord(True);
         ExecSQL;
         Transaction.CommitRetaining;
       end;
end;

procedure TFrmDepreciacionAct.report2PrintComplete(Sender: TObject);
begin
      with Dmcomprobante.IBQuery2 do
       begin
         SQL.Clear;
         SQL.Add('update "con$comprobante" set ');
         SQL.Add('"con$comprobante"."IMPRESO" = :"IMPRESO"');
         SQL.Add(' where ');
         SQL.Add('"con$comprobante"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and');
         SQL.Add('"con$comprobante"."ID_AGENCIA" = :"ID_AGENCIA"');
         ParamByName('ID_COMPROBANTE').AsString:= IntToStr(consecutivo);
         ParamByName('ID_AGENCIA').AsInteger := 1;
         ParamByName('IMPRESO').AsInteger  := Ord(True);
         ExecSQL;
         Transaction.CommitRetaining;
       end;
end;
procedure TFrmDepreciacionAct.actcomp(comprobante: Integer;oficina : Integer;deb:integer);
var     credito,debito: Currency;
        clave,codigo_cuenta : string;
begin
        with DataGeneral.IBsel1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$relacionoficina"."clave_gasto"');
          SQL.Add(' from "act$relacionoficina"');
          SQL.Add('where "act$relacionoficina"."cod_oficina"=:"codigo"');
          ParamByName('codigo').AsInteger:=oficina;
          Open;
          clave:=FieldByName('clave_gasto').AsString;
          Close;
        end;
        with dmcomprobante.Ibdatos1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "con$puc".CODIGO from "con$puc"');
          SQL.Add('where "con$puc".CLAVE=:"clave"');
          ParamByName('clave').AsString:=clave;
          Open;
          codigo_cuenta:=FieldByName('CODIGO').AsString;
          Close;
        end;
        with DataGeneral.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select sum("con$auxiliartemp"."debito") as debito,');
          SQL.Add('sum("con$auxiliartemp"."credito") as credito');
          SQL.Add('from "con$auxiliartemp"');
          SQL.Add('where "con$auxiliartemp"."comprobante" = :"comprobante"');
          ParamByName('comprobante').AsInteger := comprobante;
          Open;
          credito := SimpleRoundTo(FieldByName('credito').AsCurrency,0);
          debito := SimpleRoundTo(FieldByName('debito').AsCurrency,0);
          Close;
        end;
        if deb = 0 then
           credito := 0
        else
           debito := 0;
        with dmcomprobante.ibbuscada do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "con$auxiliar" values (');
          SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
          SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
          SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
          ParamByName('ID_COMPROBANTE').asInteger := comprobante;
          ParamByName('ID_AGENCIA').AsInteger:= 1;
          ParamByName('FECHA').AsDate := date;
          ParamByName('CODIGO').AsString := codigo_cuenta;
          ParamByName('DEBITO').AsCurrency :=debito ;
          ParamByName('CREDITO').AsCurrency := credito;
          ParamByName('ID_CUENTA').AsInteger := 0;
          ParamByName('ID_COLOCACION').AsString := '';
          ParamByName('ID_IDENTIFICACION').AsInteger := 0;
          ParamByName('ID_PERSONA').AsString :='0';
          ParamByName('MONTO_RETENCION').AsCurrency := 0;
          ParamByName('TASA_RETENCION').AsFloat := 0;
          ParamByName('ESTADOAUX').AsString := 'O';
          Open;
          Close;
          Transaction.CommitRetaining;
        end;
end;

procedure TFrmDepreciacionAct.ejecutacompClick(Sender: TObject);
begin
        Btncomprobante.Click;
end;

procedure TFrmDepreciacionAct.btraslado2Click(Sender: TObject);
var     anulacion,tipo_nota: string;
        Tabla,oficina : string;
begin
        if cod_oficina3 = 0 then
        begin
          with DataGeneral.IBsel3 do
          begin
            Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
            SQL.Clear;
            SQL.Add('select "act$controldepreciacion"."comprobante" from "act$controldepreciacion"' );
            SQL.Add('where "act$controldepreciacion"."codigo" = 3 and ');
            SQL.Add('"act$controldepreciacion"."fecha" =');
            SQL.Add('(select max("act$controldepreciacion"."fecha") from "act$controldepreciacion")');
            Open;
            consecutivo := FieldByName('comprobante').AsInteger;
            Close;
            Transaction.Commit;
           end;
          end
          else
            consecutivo := cod_oficina3;
        frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
        with dmcomprobante.Ibdatos1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "con$comprobante".IMPRESO from "con$comprobante"');
          SQL.Add('where "con$comprobante".ID_COMPROBANTE =:"cod"');
          ParamByName('cod').AsInteger:=consecutivo;
          Open;
            {if InttoBoolean(FieldByName('IMPRESO').AsInteger) then
              frmVistaPreliminar.validareporte := True
            else
               frmVistaPreliminar.validareporte := false;}
          Close;
        end;
        with Querycomprobante do
        begin
          SQL.Clear;
          SQL.Add('Select "con$comprobante".ID_COMPROBANTE,');
          SQL.Add('"con$comprobante".FECHADIA,');
          SQL.Add('"con$comprobante".DESCRIPCION,');
          SQL.Add('"con$comprobante".TOTAL_DEBITO,');
          SQL.Add('"con$comprobante".TOTAL_CREDITO,');
          SQL.Add('"con$comprobante".ESTADO,');
          SQL.Add('"con$comprobante".IMPRESO,');
          SQL.Add('"con$comprobante".ANULACION,');
          SQL.Add('"con$tipocomprobante".DESCRIPCION AS DESCRIPCION1');
          SQL.Add(' from ');
          SQL.Add('"con$comprobante",');
          SQL.Add('"con$tipocomprobante"');
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
        with ibagencia do
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
        with Queryauxiliar do
        begin
          SQL.Clear;
          SQL.Add('select distinct ');
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
         end;
           Tabla := '"Comprobante' + FloatToStr(Now)+ '"';
           with IBQTabla do
            begin
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
                 else if trim(QueryAuxiliar.FieldByName('ID_COLOCACION').AsString) <> '' then
                    ParamByName('CREDCTA').AsString := QueryAuxiliar.FieldByName('ID_COLOCACION').AsString
                 else
                    ParamByName('CREDCTA').AsString := '';
                 if trim(QueryAuxiliar.FieldByName('ID_PERSONA').AsString) <> '' then
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
              Open;
              IBQTabla.Last;
              IBQTabla.First;
              IBQTabla.RecordCount;
              report3.Variables.ByName['empresa'].AsString := FrMain.Empresa;
              report3.Variables.ByName['hoy'].AsDateTime := Date;
              report3.Variables.ByName['Empleado'].AsString := empleados(UpperCase(FrMain.Dbalias));
              report3.Variables.ByName['Nit'].AsString := FrMain.Nit;
              report3.Variables.ByName['oficina'].AsString := oficina;
              report3.Variables.ByName['tiponota'].AsString := tipo_nota;
              if report3.PrepareReport then
               begin
                 frmVistaPreliminar.Reporte := Report3;
                 frmVistaPreliminar.ShowModal;
               end;
              IBQTabla.Close;
              Transaction.CommitRetaining;
              With IBQTabla do
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

procedure TFrmDepreciacionAct.DET1Click(Sender: TObject);
var     anulacion,tipo_nota: string;
        Tabla,oficina : string;
begin
        if cod_oficina2 = 0 then
        begin
          with DataGeneral.IBsel3 do
          begin
            Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
            SQL.Clear;
            SQL.Add('select "act$controldepreciacion"."comprobante" from "act$controldepreciacion"' );
            SQL.Add('where "act$controldepreciacion"."codigo" = 2 and ');
            SQL.Add('"act$controldepreciacion"."fecha" =');
            SQL.Add('(select max("act$controldepreciacion"."fecha") from "act$controldepreciacion")');
            Open;
            consecutivo := FieldByName('comprobante').AsInteger;
            Close;
            Transaction.Commit;
           end;
          end
          else
            consecutivo := cod_oficina2;
        frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
        with dmcomprobante.Ibdatos1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "con$comprobante".IMPRESO from "con$comprobante"');
          SQL.Add('where "con$comprobante".ID_COMPROBANTE =:"cod"');
          ParamByName('cod').AsInteger:=consecutivo;
          Open;
              //frmVistaPreliminar.validareporte := False;
          Close;
        end;
        with Querycomprobante do
        begin
          SQL.Clear;
          SQL.Add('Select "con$comprobante".ID_COMPROBANTE,');
          SQL.Add('"con$comprobante".FECHADIA,');
          SQL.Add('"con$comprobante".DESCRIPCION,');
          SQL.Add('"con$comprobante".TOTAL_DEBITO,');
          SQL.Add('"con$comprobante".TOTAL_CREDITO,');
          SQL.Add('"con$comprobante".ESTADO,');
          SQL.Add('"con$comprobante".IMPRESO,');
          SQL.Add('"con$comprobante".ANULACION,');
          SQL.Add('"con$tipocomprobante".DESCRIPCION AS DESCRIPCION1');
          SQL.Add(' from ');
          SQL.Add('"con$comprobante",');
          SQL.Add('"con$tipocomprobante"');
          SQL.Add('where "con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
          SQL.Add('and "con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA"');
          ParamByName('ID_COMPROBANTE').AsString := IntToStr(consecutivo);
          ParamByName('ID_AGENCIA').AsInteger := 1;
          Open;
          anulacion := FieldByName('ANULACION').AsString;
          if anulacion <> '' then
             Report4.Variables.ByName['anulacion'].AsString := 'Anulado por:'
          else
             Report4.Variables.ByName['anulacion'].AsString := '';
        end;
        with ibagencia do
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
        with ibaux do
        begin
          SQL.Clear;
          SQL.Add('select distinct ');
          SQL.Add('"con$auxiliartemp"."comprobante",');
          SQL.Add('"con$auxiliartemp"."codigo",');
          SQL.Add('"con$auxiliartemp"."descripcion",');
          SQL.Add('"con$auxiliartemp"."debito",');
          SQL.Add('"con$auxiliartemp"."credito"');
          SQL.Add('FROM "con$auxiliartemp"');
          SQL.Add('where "con$auxiliartemp"."comprobante" =:"ID_COMPROBANTE"');
          SQL.Add('order by "con$auxiliartemp"."credito"');
          ParamByName('ID_COMPROBANTE').AsString :=IntToStr(consecutivo);
          Open;
         end;
           Tabla := '"Comprobante' + FloatToStr(Now)+ '"';
           with IBQTabla do
            begin
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
              While not ibaux.Eof do
               begin
                 ParamByName('CODIGO').AsString := (ibaux.FieldByName('codigo').AsString);
                 ParamByName('NOMBRE').AsString := ibaux.FieldByName('descripcion').AsString;
                 ParamByName('DEBITO').AsCurrency := ibaux.FieldByName('debito').AsCurrency;
                 ParamByName('CREDITO').AsCurrency := ibaux.FieldByName('credito').AsCurrency;
                 ExecSql;
                 ibaux.Next;
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
              Open;
              IBQTabla.Last;
              IBQTabla.First;
              IBQTabla.RecordCount;
              report4.Variables.ByName['empresa'].AsString := FrMain.Empresa;
              report4.Variables.ByName['hoy'].AsDateTime := Date;
              report4.Variables.ByName['Empleado'].AsString := empleados(UpperCase(FrMain.Dbalias));
              report4.Variables.ByName['Nit'].AsString := FrMain.Nit;
              report4.Variables.ByName['oficina'].AsString := oficina;
              report4.Variables.ByName['tiponota'].AsString := tipo_nota;
              report4.Variables.ByName['descripcion'].AsString := 'DISCRIMINACION DETALLADA DE LA NOTA CONTABLE No.: ';
              if report4.PrepareReport then
               begin
                 frmVistaPreliminar.Reporte := Report4;
                 frmVistaPreliminar.ShowModal;
               end;
              IBQTabla.Close;
              Transaction.CommitRetaining;
              With IBQTabla do
              begin
                SQL.Clear;
                SQL.Add('drop table ' + Tabla);
                ExecSQL;
                IBQTabla.Close;
                Transaction.CommitRetaining;
              end;
            end; // Fin With IBQTabla
          ibaux.Close;
          consecutivo:=0;

end;

procedure TFrmDepreciacionAct.DET2Click(Sender: TObject);
var     anulacion,tipo_nota: string;
        Tabla,oficina : string;
begin
        if cod_oficina3 = 0 then
        begin
          with DataGeneral.IBsel3 do
          begin
            Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
            SQL.Clear;
            SQL.Add('select "act$controldepreciacion"."comprobante" from "act$controldepreciacion"' );
            SQL.Add('where "act$controldepreciacion"."codigo" = 3 and ');
            SQL.Add('"act$controldepreciacion"."fecha" =');
            SQL.Add('(select max("act$controldepreciacion"."fecha") from "act$controldepreciacion")');
            Open;
            consecutivo := FieldByName('comprobante').AsInteger;
            Close;
            Transaction.Commit;
           end;
          end
          else
            consecutivo := cod_oficina3;
        frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
        with dmcomprobante.Ibdatos1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "con$comprobante".IMPRESO from "con$comprobante"');
          SQL.Add('where "con$comprobante".ID_COMPROBANTE =:"cod"');
          ParamByName('cod').AsInteger:=consecutivo;
          Open;
              //frmVistaPreliminar.validareporte := false;
          Close;
        end;
        with Querycomprobante do
        begin
          SQL.Clear;
          SQL.Add('Select "con$comprobante".ID_COMPROBANTE,');
          SQL.Add('"con$comprobante".FECHADIA,');
          SQL.Add('"con$comprobante".DESCRIPCION,');
          SQL.Add('"con$comprobante".TOTAL_DEBITO,');
          SQL.Add('"con$comprobante".TOTAL_CREDITO,');
          SQL.Add('"con$comprobante".ESTADO,');
          SQL.Add('"con$comprobante".IMPRESO,');
          SQL.Add('"con$comprobante".ANULACION,');
          SQL.Add('"con$tipocomprobante".DESCRIPCION AS DESCRIPCION1');
          SQL.Add(' from ');
          SQL.Add('"con$comprobante",');
          SQL.Add('"con$tipocomprobante"');
          SQL.Add('where "con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
          SQL.Add('and "con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA"');
          ParamByName('ID_COMPROBANTE').AsString := IntToStr(consecutivo);
          ParamByName('ID_AGENCIA').AsInteger := 1;
          Open;
          anulacion := FieldByName('ANULACION').AsString;
          if anulacion <> '' then
             Report4.Variables.ByName['anulacion'].AsString := 'Anulado por:'
          else
             Report4.Variables.ByName['anulacion'].AsString := '';
        end;
        with ibagencia do
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
        with ibaux do
        begin
          SQL.Clear;
          SQL.Add('select distinct ');
          SQL.Add('"con$auxiliartemp"."comprobante",');
          SQL.Add('"con$auxiliartemp"."codigo",');
          SQL.Add('"con$auxiliartemp"."descripcion",');
          SQL.Add('"con$auxiliartemp"."debito",');
          SQL.Add('"con$auxiliartemp"."credito"');
          SQL.Add('FROM "con$auxiliartemp"');
          SQL.Add('where "con$auxiliartemp"."comprobante" =:"ID_COMPROBANTE"');
          SQL.Add('order by "con$auxiliartemp"."credito"');
          ParamByName('ID_COMPROBANTE').AsString :=IntToStr(consecutivo);
          Open;
         end;
           Tabla := '"Comprobante' + FloatToStr(Now)+ '"';
           with IBQTabla do
            begin
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
              While not ibaux.Eof do
               begin
                 ParamByName('CODIGO').AsString := (ibaux.FieldByName('codigo').AsString);
                 ParamByName('NOMBRE').AsString := ibaux.FieldByName('descripcion').AsString;
                 ParamByName('DEBITO').AsCurrency := ibaux.FieldByName('debito').AsCurrency;
                 ParamByName('CREDITO').AsCurrency := ibaux.FieldByName('credito').AsCurrency;
                 ExecSql;
                 ibaux.Next;
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
              Open;
              IBQTabla.Last;
              IBQTabla.First;
              IBQTabla.RecordCount;
              report4.Variables.ByName['empresa'].AsString := FrMain.Empresa;
              report4.Variables.ByName['hoy'].AsDateTime := Date;
              report4.Variables.ByName['Empleado'].AsString := empleados(UpperCase(FrMain.Dbalias));
              report4.Variables.ByName['Nit'].AsString := FrMain.Nit;
              report4.Variables.ByName['oficina'].AsString := oficina;
              report4.Variables.ByName['tiponota'].AsString := tipo_nota;
              report4.Variables.ByName['descripcion'].AsString := 'DISCRIMINACION DETALLADA DE LA NOTA CONTABLE No.: ';
              if report4.PrepareReport then
               begin
                 frmVistaPreliminar.Reporte := Report4;
                 frmVistaPreliminar.ShowModal;
               end;
              IBQTabla.Close;
              Transaction.CommitRetaining;
              With IBQTabla do
              begin
                SQL.Clear;
                SQL.Add('drop table ' + Tabla);
                ExecSQL;
                IBQTabla.Close;
                Transaction.CommitRetaining;
              end;
            end; // Fin With IBQTabla
          ibaux.Close;
          consecutivo:=0;


end;

end.




