unit UnitCausacionCesantias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DBCtrls, DB, IBDatabase,
  IBCustomDataSet, IBQuery, pr_Common, pr_TxClasses;

type
  TFrmCausacionCesantias = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    DBagencia: TDBLookupComboBox;
    DataSource1: TDataSource;
    IBagencia: TIBQuery;
    IBTransaction2: TIBTransaction;
    SS: TPanel;
    SSS: TPanel;
    report3: TprTxReport;
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
    IBTransaction5: TIBTransaction;
    IBTransaction4: TIBTransaction;
    IBTransaction3: TIBTransaction;
    IBTransaction1: TIBTransaction;
    IBbusca: TIBQuery;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
  consecutivo :Integer;
  tipo_prima,nit:Integer;
    procedure insertar;
    { Private declarations }
  public
  published
    procedure reporte(consec: integer);
    { Public declarations }
  end;

var
  FrmCausacionCesantias: TFrmCausacionCesantias;

implementation
uses UnitGlobal, UnitCausacion, UnitPrincipal, UnitVistaPreliminar,
  UnitQuerys, UnitdataQuerys;

{$R *.dfm}

procedure TFrmCausacionCesantias.FormCreate(Sender: TObject);
begin
        IBagencia.Open;
        IBagencia.Last;
        DBagencia.KeyValue := 1;
end;

procedure TFrmCausacionCesantias.BitBtn1Click(Sender: TObject);
var     valor, saldo_cesantia :Currency;

begin
        with IBbusca do
        begin
        Close;
        verificatransaccion(IBbusca);
        IBbusca.ParamByName('tipo').AsInteger := 66;
        IBbusca.ParamByName('nit').AsInteger := 66;
        IBbusca.ParamByName('fecha').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',Date));
        Open;
        if RecordCount <> 0 then
        begin
        if MessageDlg('La Causación de las Cesantias ya fue Realizado'+#13+'segun Nota contable No. ' + FieldByName('comprobante').AsString + ' Desea ver la Nota',mtInformation,[mbYes,mbNo],0) = mrYes Then
        begin
          consecutivo := FieldByName('comprobante').AsInteger;
          reporte(consecutivo);
          Exit;
        end
        else
          Exit;
        end;
        end;
        FrmCausacion := TFrmCausacion.Create(self);
        if DBagencia.KeyValue = 1 then
        begin
              consecutivo :=comprobantes('Causacion de Cesantias Of. Ocaña','1');
              valor := FrmCausacion.causar(DBagencia.KeyValue,1) - FrmCausacion.buscar(DBagencia.KeyValue,1);// actualiza los auxiliares de cesantias
              //FrmCausacion.auxiliar(23,consecutivo,'C',valor);
              FrmCausacion.auxiliar(29,consecutivo,'D',valor);
              saldo_cesantia := abs(saldo_cuenta(FormatDateTime('mm',FrMain.fechacartera),23,1));
              frmcausacion.auxiliar(23,consecutivo,'D',saldo_cesantia);
              FrmCausacion.auxiliar(50,consecutivo,'C',saldo_cesantia + valor);
              actualizarcomprobante(consecutivo);
              reporte(consecutivo);
              //ShowMessage(CurrToStr(saldo_cesantia));
        end;
           tipo_prima := 66;
           nit := 66;
           insertar;

end;
procedure TFrmCausacionCesantias.reporte(consec: integer);
var     anulacion,tipo_nota: string;
        Tabla,oficina: string;
begin
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
          SQL.Add(',"con$tipocomprobante".DESCRIPCION AS DESCRIPCION1');
          SQL.Add('from ');
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
          ParamByName('ID_COMPROBANTE').AsString :=IntToStr(consec);
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
              report3.Variables.ByName['tiponota'].AsString := tipo_nota;
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

procedure TFrmCausacionCesantias.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmCausacionCesantias.insertar;
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
          ExecSQL;
          Close;
          Transaction.Commit;
        end;
end;

end.
