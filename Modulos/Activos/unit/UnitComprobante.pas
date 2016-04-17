unit UnitComprobante;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, Grids, XStringGrid, Buttons,
  pr_Common, pr_TxClasses, DB, IBCustomDataSet, IBQuery, IBSQL;

type
    PList = ^AList;
    AList = record
    codigo   : string;
    nomcuenta: string;
    debito   : currency;
    credito  : currency;
    nocuenta : integer;
    nocredito: string;
    tipoide  : integer;
    idpersona: string;
    monto    : currency;
    tasa     : single;
    estado   : string;
end;
type
  TFrmComprobantes = class(TForm)
    Panel1: TPanel;
    fechadia: TLabel;
    Label3: TLabel;
    Nocomprobante: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    editDescripcion: TMemo;
    Label7: TLabel;
    Panel2: TPanel;
    XSauxiliar: TXStringGrid;
    Panel3: TPanel;
    BtnGrabar: TBitBtn;
    Btnreporte: TBitBtn;
    Btncerrar: TBitBtn;
    Btnlimpiar: TBitBtn;
    BtnAgregar: TBitBtn;
    BtnEliminar: TBitBtn;
    Label2: TLabel;
    Edittotaldebito: TMemo;
    Label4: TLabel;
    Edittotalcredito: TMemo;
    QueryComprobante: TIBQuery;
    IBQTabla: TIBQuery;
    QueryAuxiliar: TIBQuery;
    ibagencia: TIBQuery;
    ibagenciadescripcion: TIBStringField;
    Report1: TprTxReport;
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
    QueryComprobanteID_COMPROBANTE: TIntegerField;
    QueryComprobanteFECHADIA: TDateField;
    QueryComprobanteDESCRIPCION: TMemoField;
    QueryComprobanteTOTAL_DEBITO: TIBBCDField;
    QueryComprobanteTOTAL_CREDITO: TIBBCDField;
    QueryComprobanteESTADO: TIBStringField;
    QueryComprobanteIMPRESO: TSmallintField;
    QueryComprobanteANULACION: TMemoField;
    QueryComprobanteDESCRIPCION1: TIBStringField;
    comboagencia: TComboBox;
    tipo_comp1: TEdit;
    IBSQL1: TIBSQL;
    Ibtipo: TIBQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtncerrarClick(Sender: TObject);
    procedure BtnGrabarClick(Sender: TObject);
    procedure BtnreporteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAgregarClick(Sender: TObject);
    procedure editDescripcionExit(Sender: TObject);
    procedure BtnlimpiarClick(Sender: TObject);
    procedure BtnEliminarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnrefrescarClick(Sender: TObject);
    procedure XSauxiliarSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure comboagenciaExit(Sender: TObject);
    procedure dblcbtipo_compKeyPress(Sender: TObject; var Key: Char);
    procedure comboagenciaKeyPress(Sender: TObject; var Key: Char);
    procedure editDescripcionKeyPress(Sender: TObject; var Key: Char);
  private
  agencia:Integer;

    function grabar : Boolean;
    function actualizar: Boolean;
    procedure actualizaxsauxiliar;
    { Private declarations }
  public

  published

    { Public declarations }
  end;

var
  FrmComprobantes: TFrmComprobantes;

  vid_comprobante       :string;
  vfechadia             :TDate;
  vtipo_comprobante     :integer;
  vagencia              :integer;
  vdescripcion          :string;
  vtotal_debito         :currency;
  vtotal_credito        :currency;
  vestadoc              :string;
  vimpreso              :boolean;
  vcomprobante          :integer;
  anulacion             :string;
  id_comprobante        :integer;
  id_agencia            :integer;
  codigo                :string;
  nombre                :string;
  debito                :currency;
  credito               :currency;
  nocuenta              :integer;
  nocredito             :string;
  estadoa               :string;
  vestadoa              :string;
  consecutivo           :integer;
  consec                :string;
  List                  :TList;
  posgrid               :integer;
  vmodificar            :boolean;
  estadoc               :string;
  Nombres               :String;
  Apellidos             :string;

implementation
uses UnitReporte,unitdecomprobante, UnitDatamodulo,unitglobal, UnitVistaPreliminar,
  UnitDigita, UnitPrincipal,unitdata ;

{$R *.dfm}
procedure TFrmComprobantes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      dmcomprobante.DataAgencia.Active:=False;
      dmcomprobante.DataComprobante.Active:=False;
      dmcomprobante.Free;
      Self.Close;
end;

procedure TFrmComprobantes.BtncerrarClick(Sender: TObject);
begin
        Close;
end;

function TFrmComprobantes.grabar: Boolean;
var
Arecord : Plist;
I:Integer;
begin
         consecutivo := ObtenerConsecutivo(IBSQL1);
         Consec := FormatCurr('0000000',Consecutivo);
         Nocomprobante.Caption := consec;
         vid_comprobante:= consec;
      with dmcomprobante.IBQuery1 do
        try
         sql.Clear;
         sql.Add('insert into "con$comprobante" ("con$comprobante"."ID_COMPROBANTE",');
         sql.Add('"con$comprobante"."FECHADIA", "con$comprobante"."TIPO_COMPROBANTE",');
         sql.Add('"con$comprobante"."ID_AGENCIA", "con$comprobante"."DESCRIPCION",');
         sql.Add('"con$comprobante"."TOTAL_DEBITO", "con$comprobante"."TOTAL_CREDITO",');
         sql.Add('"con$comprobante"."ESTADO", "con$comprobante"."IMPRESO",');
         sql.Add('"con$comprobante"."ANULACION","con$comprobante"."ID_EMPLEADO") ');
         sql.Add('values (');
         sql.Add(':"ID_COMPROBANTE", :"FECHADIA", :"TIPO_COMPROBANTE",');
         sql.Add(':"ID_AGENCIA", :"DESCRIPCION", :"TOTAL_DEBITO",');
         sql.Add(':"TOTAL_CREDITO", :"ESTADO", :"IMPRESO", :"ANULACION",:"ID_EMPLEADO")');
         ParamByName('ID_COMPROBANTE').AsString:= vid_comprobante;
         ParamByname('FECHADIA').AsDate := vfechadia;
         ParamByName('ID_AGENCIA').AsInteger := vagencia;
         ParamByName('TIPO_COMPROBANTE').AsInteger := vtipo_comprobante;
         ParamByName('DESCRIPCION').AsString := vdescripcion;
         ParamByName('TOTAL_DEBITO').AsCurrency  := vtotal_debito;
         ParamByName('TOTAL_CREDITO').AsCurrency  := vtotal_credito;
         ParamByName('ESTADO').AsString  := 'O';
         ParamByname('ANULACION').asstring := '';
         ParamByName('IMPRESO').AsInteger  := Ord(false);
         ParamByname('ID_EMPLEADO').asstring := UpperCase(FrMain.Dbalias);

         ExecSQL;
         SQL.Clear;
         SQL.Add('insert into "con$auxiliar" values (');
         SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
         SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
         SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
         if List.Count > 0 then
           for I := 0 to List.Count -1 do
           begin
             ARecord := List.Items[I];
             ParamByName('ID_COMPROBANTE').AsString := vid_comprobante;
             ParamByName('ID_AGENCIA').AsInteger:= vagencia;
             ParamByName('FECHA').AsDate := vfechadia;
             ParamByName('CODIGO').AsString := Arecord^.codigo;
             ParamByName('DEBITO').AsCurrency := Arecord^.debito;
             ParamByName('CREDITO').AsCurrency := Arecord^.credito;
             ParamByName('ID_CUENTA').AsInteger := Arecord^.nocuenta;
             ParamByName('ID_COLOCACION').AsString := Arecord^.nocredito;
             ParamByName('ID_IDENTIFICACION').AsInteger := Arecord^.tipoide;
             ParamByName('ID_PERSONA').AsString := Arecord^.idpersona;
             ParamByName('MONTO_RETENCION').AsCurrency := Arecord^.monto;
             ParamByName('TASA_RETENCION').AsFloat := Arecord^.tasa;
             ParamByName('ESTADOAUX').AsString := Arecord^.estado;
             ExecSQL;
           end;
         Transaction.CommitRetaining;
         Result := True;
         except
           Transaction.RollbackRetaining;
           Result := False;
         end;
end;

function TFrmComprobantes.actualizar: Boolean;
var
Arecord : Plist;
I:Integer;
begin
     with Dmcomprobante.IBQuery2 do
       try
         SQL.Clear;
         SQL.Add('update "con$comprobante" set ');
         SQL.Add('"con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE",');
         SQL.Add('"con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA",');
         SQL.Add('"con$comprobante"."TIPO_COMPROBANTE" =:"TIPO_COMPROBANTE",');
         SQL.Add('"con$comprobante"."FECHADIA" =:"FECHADIA",');
         SQL.Add('"con$comprobante"."DESCRIPCION" =:"DESCRIPCION",');
         SQL.Add('"con$comprobante"."TOTAL_DEBITO" =:"TOTAL_DEBITO",');
         SQL.Add('"con$comprobante"."TOTAL_CREDITO" =:"TOTAL_CREDITO",');
         SQL.Add('"con$comprobante"."ESTADO" =:"ESTADO",');
         SQL.Add('"con$comprobante"."IMPRESO" =:"IMPRESO",');
         SQL.Add('"con$comprobante"."ANULACION" =:"ANULACION",');
         SQL.Add('"con$comprobante"."ID_EMPLEADO" =:"ID_EMPLEADO"');
         SQL.Add(' where ');
         SQL.Add('"con$comprobante"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and');
         SQL.Add('"con$comprobante"."ID_AGENCIA" = :"ID_AGENCIA"');
         ParamByName('ID_COMPROBANTE').AsString:= vid_comprobante;
         ParamByName('ID_AGENCIA').AsInteger := vagencia;
         ParamByName('TIPO_COMPROBANTE').AsInteger := vtipo_comprobante;
         ParamByname('FECHADIA').AsDate:= vfechadia;
         ParamByName('DESCRIPCION').AsString := vdescripcion;
         ParamByName('TOTAL_DEBITO').AsCurrency  := vtotal_debito;
         ParamByName('TOTAL_CREDITO').AsCurrency  := vtotal_credito;
         ParamByName('ESTADO').AsString  := 'O';
         ParamByName('IMPRESO').AsInteger  := Ord(False);
         ParamByName('ANULACION').AsString := anulacion;
         ParamByName('ID_EMPLEADO').AsString := UpperCase(FrMain.Dbalias);
         ExecSQL;
         SQL.Clear;
         SQL.Add('delete from "con$auxiliar" where ');
         SQL.Add('"con$auxiliar"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and');
         SQL.Add('"con$auxiliar"."ID_AGENCIA" = :"ID_AGENCIA"');
         ParamByName('ID_COMPROBANTE').AsString:= vid_comprobante;
         ParamByName('ID_AGENCIA').AsInteger := vagencia;
         ExecSQL;
         SQL.Clear;
         SQL.Add('insert into "con$auxiliar" values (');
         SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
         SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
         SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
         if List.Count > 0 then
         for I := 0 to List.Count -1 do
         begin
            ARecord := List.Items[I];
            ParamByName('ID_COMPROBANTE').AsString := vid_comprobante;
            ParamByName('ID_AGENCIA').AsInteger:= vagencia;
            ParamByName('FECHA').AsDate := vfechadia;
            ParamByName('CODIGO').AsString := Arecord^.codigo;
            ParamByName('DEBITO').AsCurrency := Arecord^.debito;
            ParamByName('CREDITO').AsCurrency := Arecord^.credito;
            ParamByName('ID_CUENTA').AsInteger := Arecord^.nocuenta;
            ParamByName('ID_COLOCACION').AsString := Arecord^.nocredito;
            ParamByName('ID_IDENTIFICACION').AsInteger := Arecord^.tipoide;
            ParamByName('ID_PERSONA').AsString := Arecord^.idpersona;
            ParamByName('MONTO_RETENCION').AsCurrency := Arecord^.monto;
            ParamByName('TASA_RETENCION').AsFloat := Arecord^.tasa;
            ParamByname('ESTADOAUX').AsString := Arecord^.estado;
            ExecSQL;
         end;
         Transaction.CommitRetaining;
         Result := true;
         vmodificar:= false;
       except
         Transaction.RollbackRetaining;
         Result := false;
       end;
end;

procedure TFrmComprobantes.actualizaxsauxiliar;
var
        i:integer;
        ARecord: PList;
begin
   vtotal_debito:= 0;
   vtotal_credito:= 0;
   with list do
     if count > 0 then
     begin
      xsauxiliar.RowCount := Count+1;
      for i:=0 to (Count - 1) do
       begin
        Arecord := Items[i];
        xsauxiliar.ColWidths[0] := 112;
        xsauxiliar.Cells [0,i+1] := arecord^.codigo;
        xsauxiliar.ColWidths[1] := 120;
        xsauxiliar.Cells [1,i+1] := arecord^.nomcuenta;
        xsauxiliar.ColWidths[3] := 100;
        xsauxiliar.Cells [3,i+1] := formatcurr ('#,##0.00',Arecord^.debito);
        vtotal_debito := vtotal_debito + ARecord^.debito;
        xsauxiliar.ColWidths[4] := 100;
        xsauxiliar.Cells [4,i+1] := formatcurr ('#,##0.00',Arecord^.credito);
        vtotal_credito := vtotal_credito + Arecord^.credito;
        edittotaldebito.Text := currtostr(vtotal_debito);
        edittotalcredito.Text := currtostr(vtotal_credito);
        if arecord^.nocuenta <> 0 then
          xsauxiliar.Cells [2,i+1] := IntToStr(arecord^.nocuenta);
        if arecord^.nocredito <>'' then
          xsauxiliar.Cells [2,i+1] := trim(arecord^.nocredito);
       end;
    end
    else if count = 0 then
    begin
     edittotaldebito.Text := '0';
     edittotalcredito.Text:= '0';
     xsauxiliar.RowCount := 2;
     xsauxiliar.Cells[0,1]:= '';
     xsauxiliar.Cells[1,1]:= '';
     xsauxiliar.Cells[2,1]:= '';
     xsauxiliar.Cells[3,1]:= '';
     xsauxiliar.Cells[4,1]:= '';
    end;
end;

procedure TFrmComprobantes.BtnGrabarClick(Sender: TObject);
begin
  if DataGeneral.IBTransaction1.InTransaction then
     DataGeneral.IBTransaction1.CommitRetaining;
  if vModificar then
     begin
      if vtipo_comprobante <1 then
       if messagedlg('No ha digitado el tipo de comprobante',mtError,[mbOk],0) = mrok then
        begin
         exit;
        end;
      if agencia <1 then
       if messagedlg('No ha digitado la agencia',mtError,[mbOk],0) = mrok then
        begin
         comboagencia.SetFocus;
         exit;
        end;
      if editDescripcion.Text ='' then
       if messagedlg('No ha digitado la descripción',mtError,[mbOk],0) = mrok then
        begin
         editdescripcion.SetFocus;
         exit;
        end;
      if List.Count = 0 then
       begin
       if messagedlg('No ha digitado ningún movimiento',mtError,[mbOk],0) = mrok then
         exit;
       end;
      if edittotaldebito.Text <> edittotalcredito.Text then
       begin
       if messagedlg('El comprobante No está cuadrado',mtError,[mbOk],0)= mrok then
         exit;
       end;
      if Actualizar then
          begin
           MessageDlg('El Comprobante se Actualizó',mtInformation,[mbOK],0);
           vmodificar := false;
           exit;
          end
        else
          begin
           MessageDlg('Comprobante no Actualizado',mtError,[mbOK],0);
           exit;
          end;
     end
     else
     begin
      if vtipo_comprobante <1 then
       if messagedlg('No ha digitado el tipo de comprobante',mtError,[mbOk],0) = mrok then
        begin

         exit;
        end;
      if agencia <1 then
       if messagedlg('No ha digitado la agencia',mtError,[mbOk],0) = mrok then
        begin
         comboagencia.SetFocus;
         exit;
        end;
      if editDescripcion.Text ='' then
       if messagedlg('No ha digitado la descripción',mtError,[mbOk],0) = mrok then
        begin
         editdescripcion.SetFocus;
         exit;
        end;
      if List.Count = 0 then
       begin
       if messagedlg('No ha digitado ningún movimiento',mtError,[mbOk],0) = mrok then
         exit;
       end;
      if edittotaldebito.Text <> edittotalcredito.Text then
       begin
       if messagedlg('El comprobante No está cuadrado',mtError,[mbOk],0)= mrok then
         exit;
       end;
     if Grabar then
       begin
       MessageDlg('El Comprobante fue Grabado',mtInformation,[mbOK],0);
       BtnReporteClick(Sender);
     end
     else
       MessageDlg('Comprobante No Grabado',mtError,[mbOK],0);
   end;
end;

procedure TFrmComprobantes.BtnreporteClick(Sender: TObject);
var
anulacion,tipo_nota: string;
Tabla,oficina : string;
begin
        with Querycomprobante do
        begin
          sql.Clear;
          sql.Add('Select "con$comprobante".ID_COMPROBANTE,');
          sql.Add('"con$comprobante".FECHADIA,');
          sql.Add('"con$comprobante".DESCRIPCION,');
          sql.Add('"con$comprobante".TOTAL_DEBITO,');
          sql.Add('"con$comprobante".TOTAL_CREDITO,');
          sql.Add('"con$comprobante".ESTADO,');
          sql.Add('"con$comprobante".IMPRESO,');
          sql.Add('"con$comprobante".ANULACION,');
          sql.Add('"con$tipocomprobante".DESCRIPCION AS DESCRIPCION1');
          sql.Add(' from ');
          sql.Add('"con$comprobante",');
          sql.Add('"con$tipocomprobante"');
          sql.Add('where "con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
          sql.Add('and "con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA"');
          ParamByName('ID_COMPROBANTE').AsString := vid_comprobante;
          ParamByName('ID_AGENCIA').AsInteger := vagencia;
          open;
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
          ParamByName('codigo').AsInteger:=vagencia;
          Open;
          oficina:=FieldByName('descripcion').AsString;
          Close;
        end;
        with ibtipo do
        begin
          SQL.Clear;
          Close;
          SQL.Add('select "con$tipocomprobante".DESCRIPCION from "con$tipocomprobante"' );
          SQL.Add('where "con$tipocomprobante".ID = :"codigo"');
          ParamByName('codigo').AsInteger:=vtipo_comprobante;
          Open;
          tipo_nota:=FieldByName('DESCRIPCION').AsString;
          Close;
        end;
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
          ParamByName('ID_COMPROBANTE').AsString :=vid_comprobante;
          ParamByName('ID_AGENCIA').AsInteger := vagencia;
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
              SQL.Add('DEBITO              INTEGER,');
              SQL.Add('CREDITO             INTEGER)');
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
                 ParamByName('CODIGO').AsString := QueryAuxiliar.FieldByName('CODIGO').AsString;
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
                 frmVistaPreliminar := TfrmVistaPreliminar.Create(Self);
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
end;

procedure TFrmComprobantes.FormShow(Sender: TObject);
begin
        if datageneral.IBTransaction1.InTransaction then
         begin
           datageneral.IBTransaction1.Commit;
           datageneral.IBTransaction1.StartTransaction;
         end;
        dmcomprobante := Tdmcomprobante.Create(self);
        dmcomprobante.DataComprobante.Active:=True;
        dmcomprobante.DataAgencia.Active:=True;
        dmcomprobante.DataComprobante.Last;
        dmcomprobante.DataAgencia.Last;
        xsauxiliar.ColWidths [0] := 127;
        xsauxiliar.ColWidths [1] := 135;
        xsauxiliar.ColWidths [2] := -1;
        xsauxiliar.ColWidths [3] := 110;
        xsauxiliar.ColWidths [4] := 110;
        xsauxiliar.Cols[0].Text  := 'Código';
        xsauxiliar.Cols[1].Text  := 'Nombre Cuenta';
        xsauxiliar.Cols[2].Text  := 'No.Cuenta/Crédito';
        xsauxiliar.Cols[3].Text  := 'Débitos';
        xsauxiliar.Cols[4].Text  := 'Créditos';
        List := Tlist.Create;
        fechadia.Caption := FormatDateTime('mmmm dd - yyyy',now);
        vfechadia:= date;
        editdescripcion.Text := '';
        edittotaldebito.Text:= '';
        edittotalcredito.Text:='';
        posgrid := -1;
        xsauxiliar.Enabled := True;
end;

procedure TFrmComprobantes.BtnAgregarClick(Sender: TObject);
var     digita : TDigita;
        ARecord: PList;
begin
        digita:= Tdigita.Create(self); digita.codigo:= '';
        digita.nomcuenta:= '';
        digita.debito:= 0;
        digita.credito:= 0;
        digita.nocuenta:= 0;
        if digita.ShowModal = mrOk  then
         begin
           New(ARecord);
           ARecord^.codigo := digita.codigo;
           ARecord^.nomcuenta := digita.vnomcuenta;
           ARecord^.debito := digita.debito;
           ARecord^.credito:= digita.credito;
           ARecord^.nocuenta:= digita.nocuenta;
           ARecord^.nocredito:='';
           ARecord^.tipoide := 0;
           ARecord^.idpersona:= '';
           ARecord^.monto := 0;
           ARecord^.tasa := 0;
           Arecord^.estado :='O';
           List.Add(ARecord);
         end;
        actualizaxsauxiliar;
        digita.cerrar;
end;

procedure TFrmComprobantes.editDescripcionExit(Sender: TObject);
begin
        vdescripcion:=editDescripcion.Text;
end;

procedure TFrmComprobantes.BtnlimpiarClick(Sender: TObject);
begin
        xsauxiliar.ColWidths [0] := 127;
        xsauxiliar.ColWidths [1] := 135;
        xsauxiliar.ColWidths [2] := -1;
        xsauxiliar.ColWidths [3] := 110;
        xsauxiliar.ColWidths [4] := 110;
        xsauxiliar.Cols[0].Text  := 'Código';
        xsauxiliar.Cols[1].Text  := 'Nombre Cuenta';
        xsauxiliar.Cols[2].Text  := 'No.Cuenta';
        xsauxiliar.Cols[3].Text  := 'Débitos';
        xsauxiliar.Cols[4].Text  := 'Créditos';
        Nocomprobante.Caption:= '';
        fechadia.Caption := FormatDateTime('mmmm dd - yyyy',now);
        vfechadia:= Date;
        comboagencia.ItemIndex := -1;
        editdescripcion.Text:= '';
        edittotaldebito.Text:='';
        edittotalcredito.Text:='';
        list.Clear;
        List:= Tlist.Create;
        id_comprobante:= 0;
        id_agencia:= 0;
        vid_comprobante:= '';
        vtipo_comprobante := 0;
        vagencia:= 0;
        vdescripcion:= '';
        anulacion:= '';
        vtotal_debito:= 0;
        vtotal_credito:= 0;
        vestadoc:= '';
        estadoc := '';
        vestadoa:= '';
        estadoa := '';
        vmodificar := false;
        edittotaldebito.Color := clMoneyGreen;
        edittotalcredito.Color := clMoneyGreen;
        BtnGrabar.Enabled := true;
        BtnGrabar.Caption := 'Grabar';
        Btncerrar.Enabled := true;
        BtnAgregar.Enabled := True;
        xsauxiliar.Enabled := True;
        dmcomprobante.DataAgencia.Close;
        dmcomprobante.DataComprobante.Close;
        dmcomprobante.DataAgencia.Open;
        dmcomprobante.DataComprobante.Open;
end;

procedure TFrmComprobantes.BtnEliminarClick(Sender: TObject);
var
        Arecord : PList;
begin
        try
        if posgrid <> -1 then
        begin
           ARecord := List.Items[posgrid];
           List.Remove(ARecord);
           List.Pack;
           posgrid := -1;
           Actualizaxsauxiliar;
        end
        else
           MessageDlg('No Seleccionó Movimiento',mterror,[mbOk],0);
         except on E: Exception do
           MessageDlg('No Existe Ningun Movimiento ',mterror,[mbOk],0);
        end;
end;

procedure TFrmComprobantes.FormCreate(Sender: TObject);
begin
        dmcomprobante := Tdmcomprobante.Create(self);
        dmcomprobante.DataComprobante.Active:=True;
        dmcomprobante.DataComprobante.Last;
        dmcomprobante.tipocomprobante.Open;
        vtipo_comprobante:=1;
        with DataGeneral.IBdatos do
        begin
           Close;
           SQL.Clear;
           SQL.Add('select "Inv$Agencia"."descripcion"');
           SQL.Add('from "Inv$Agencia"');
           Open;
           while not DataGeneral.IBdatos.Eof do
           begin
           comboagencia.Items.Add(FieldByName('descripcion').AsString);
           Next;
           end;
        Close;
        end;


end;
procedure TFrmComprobantes.btnrefrescarClick(Sender: TObject);
begin
        dmcomprobante.DataAgencia.Close;
        dmcomprobante.DataAgencia.Open;
        dmcomprobante.DataComprobante.Close;
        dmcomprobante.DataComprobante.Open;
end;

procedure TFrmComprobantes.XSauxiliarSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
        posgrid := ARow-1;
        CanSelect := True;
end;
procedure TFrmComprobantes.comboagenciaExit(Sender: TObject);
begin
        vagencia := comboagencia.ItemIndex+1;
        agencia := vagencia;
end;

procedure TFrmComprobantes.dblcbtipo_compKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           comboagencia.SetFocus;
end;

procedure TFrmComprobantes.comboagenciaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           editDescripcion.SetFocus;
end;

procedure TFrmComprobantes.editDescripcionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           BtnAgregar.SetFocus;
end;
end.
