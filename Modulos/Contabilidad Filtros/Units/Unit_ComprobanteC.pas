unit Unit_ComprobanteC;

interface

uses
  Windows, Messages, SysUtils, Math, DateUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DBCtrls, DB,
  IB, IBCustomDataSet, IBQuery, XStringGrid, Mask, CEForm, pr_Common, pr_Parser, pr_TxClasses,
  IBSQL, JvEdit, JvTypedEdit, IBDatabase, pr_Classes;

 type
      TComprobante = class
   end;

type
  PList = ^AList;
  AList = record
    codigo   : string;
    nomcuenta: string;
    debito   : currency;
    credito  : currency;
    tipoide  : integer;
    idpersona: string;
    monto    : currency;
    tasa     : single;
    estado   : string;
  end;

type PCuentas = ^ACuentas;
     ACuentas = record
        Tp:Integer;
        Cuenta:Integer;
        Debitos:Currency;
        Creditos:Currency;
end;

type
  PSaldos = ^ASaldos;
  ASaldos = record
    tipo:Integer;
    numero:Integer;
    saldo:Currency;
end;

type
  TfrmComprobanteC = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    editdescripcion: TMemo;
    Label6: TLabel;
    Label7: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    BtnBuscar: TBitBtn;
    BtnGrabar: TBitBtn;
    BtnAnular: TBitBtn;
    Btnreporte: TBitBtn;
    Btnlimpiar: TBitBtn;
    Btncerrar: TBitBtn;
    btnrefrescar: TBitBtn;
    QueryComprobante: TIBQuery;
    XSauxiliar: TXStringGrid;
    Bevel1: TBevel;
    NoComprobante: TLabel;
    fechadia: TLabel;
    Edittotaldebito: TMemo;
    Edittotalcredito: TMemo;
    Label8: TLabel;
    editanulacion: TMemo;
    QueryComprobanteID_COMPROBANTE: TIntegerField;
    QueryComprobanteFECHADIA: TDateField;
    QueryComprobanteDESCRIPCION: TMemoField;
    QueryComprobanteTOTAL_DEBITO: TIBBCDField;
    QueryComprobanteTOTAL_CREDITO: TIBBCDField;
    QueryComprobanteESTADO: TIBStringField;
    QueryComprobanteIMPRESO: TSmallintField;
    QueryComprobanteANULACION: TMemoField;
    QueryComprobanteDESCRIPCION1: TIBStringField;
    QueryComprobanteDESCRIPCION_AGENCIA: TIBStringField;
    IBQTabla: TIBQuery;
    QueryAuxiliar: TIBQuery;
    QueryAuxiliarID_COMPROBANTE: TIntegerField;
    QueryAuxiliarID_AGENCIA: TSmallintField;
    QueryAuxiliarCODIGO: TIBStringField;
    QueryAuxiliarNOMBRE: TIBStringField;
    QueryAuxiliarDEBITO: TIBBCDField;
    QueryAuxiliarCREDITO: TIBBCDField;
    QueryAuxiliarID_CUENTA: TIntegerField;
    QueryAuxiliarID_COLOCACION: TIBStringField;
    QueryAuxiliarID_IDENTIFICACION: TSmallintField;
    QueryAuxiliarID_PERSONA: TIBStringField;
    QueryAuxiliarMONTO_RETENCION: TIBBCDField;
    QueryAuxiliarTASA_RETENCION: TFloatField;
    IBPagar: TIBSQL;
    IBOtros: TIBSQL;
    IBAuxiliar: TIBQuery;
    IBSQL1: TIBSQL;
    IBAuxiliar1: TIBQuery;
    Report1: TprTxReport;
    Panel4: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    nomcta: TLabel;
    CmdPUC: TSpeedButton;
    editcodigo: TMaskEdit;
    GrupoInforme: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Edtipoid: TDBLookupComboBox;
    EdMonto: TMemo;
    EdNit: TMemo;
    EdTasa: TMemo;
    EdDebito: TJvCurrencyEdit;
    EdCredito: TJvCurrencyEdit;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    GroupBox1: TGroupBox;
    CheckBoxcerrado: TCheckBox;
    CheckBoxanulado: TCheckBox;
    CheckBoximpreso: TCheckBox;
    PanelXS: TPanel;
    BtnAgregar: TBitBtn;
    BtnModificarGrid: TBitBtn;
    BtnEliminar: TBitBtn;
    DSTiposIdentificacion: TDataSource;
    IBQTiposIdentificacion: TIBQuery;
    IBSQL2: TIBSQL;
    Label3: TLabel;
    IBTransaction1: TIBTransaction;
    IBAuxiliarID_COMPROBANTE: TIntegerField;
    IBAuxiliarDESCRIPCION_AGENCIA: TIBStringField;
    IBAuxiliarTIPO: TIBStringField;
    IBAuxiliarFECHADIA: TDateField;
    IBAuxiliarDESCRIPCION: TMemoField;
    IBAuxiliarPRIMER_APELLIDO: TIBStringField;
    IBAuxiliarSEGUNDO_APELLIDO: TIBStringField;
    IBAuxiliarNOMBRE: TIBStringField;
    IBAuxiliarCODIGO: TIBStringField;
    IBAuxiliarCUENTA: TIBStringField;
    IBAuxiliarID_CUENTA: TIBStringField;
    IBAuxiliarID_COLOCACION: TIBStringField;
    IBAuxiliarID_IDENTIFICACION: TSmallintField;
    IBAuxiliarID_PERSONA: TIBStringField;
    IBAuxiliarPRIMER_APELLIDO1: TIBStringField;
    IBAuxiliarSEGUNDO_APELLIDO1: TIBStringField;
    IBAuxiliarNOMBRE1: TIBStringField;
    IBAuxiliarDEBITO: TIBBCDField;
    IBAuxiliarCREDITO: TIBBCDField;
    Panel5: TPanel;
    IBTransaction2: TIBTransaction;
    Label4: TLabel;
    dblcbtipo: TDBLookupComboBox;
    IBQTipoC: TIBQuery;
    DsTipoC: TDataSource;
    IBTransaction3: TIBTransaction;
    prReport1: TprReport;

    procedure BtnGrabarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bloquear;
    procedure desbloquear;
    procedure BtncerrarClick(Sender: TObject);
    procedure BtnAgregarClick(Sender: TObject);
    procedure actualizaxsauxiliar;
    procedure CheckBoximpresoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnlimpiarClick(Sender: TObject);
    procedure editdescripcionExit(Sender: TObject);
    procedure BtnBuscarClick(Sender: TObject);
    procedure btnrefrescarClick(Sender: TObject);
    procedure BtnAnularClick(Sender: TObject);
    procedure CheckBoxcerradoKeyPress(Sender: TObject; var Key: Char);
    procedure CheckBoxanuladoKeyPress(Sender: TObject; var Key: Char);
    procedure XSauxiliarSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure editanulacionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editanulacionExit(Sender: TObject);
    procedure editanulacionKeyPress(Sender: TObject; var Key: Char);
    procedure dblcbtipo_compKeyPress(Sender: TObject; var Key: Char);
    procedure DblcbAgenciaKeyPress(Sender: TObject; var Key: Char);
    procedure editdescripcionKeyPress(Sender: TObject; var Key: Char);
    procedure BtnModificarGridClick(Sender: TObject);
    procedure BtnEliminarClick(Sender: TObject);
    procedure BtnreporteClick(Sender: TObject);
    procedure CheckBoximpresoExit(Sender: TObject);
    procedure Report1PrintComplete(Sender: TObject);
    procedure EdittotaldebitoExit(Sender: TObject);
    procedure EdittotalcreditoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Report1InitDetailBandDataSet(Sender: TObject;
      DetailBand: TprBand; DataSet: TObject; const DataSetName: String);
    procedure editcodigoExit(Sender: TObject);
    procedure editcodigoEnter(Sender: TObject);
    procedure editcodigoKeyPress(Sender: TObject; var Key: Char);
    procedure EdDebitoEnter(Sender: TObject);
    procedure EdDebitoExit(Sender: TObject);
    procedure EdCreditoEnter(Sender: TObject);
    procedure EdCreditoExit(Sender: TObject);
    procedure EdtipoidEnter(Sender: TObject);
    procedure EdtipoidExit(Sender: TObject);
    procedure EdtipoidKeyPress(Sender: TObject; var Key: Char);
    procedure EdNitEnter(Sender: TObject);
    procedure EdNitExit(Sender: TObject);
    procedure EdNitKeyPress(Sender: TObject; var Key: Char);
    procedure EdTasaEnter(Sender: TObject);
    procedure EdTasaKeyPress(Sender: TObject; var Key: Char);
    procedure EdMontoEnter(Sender: TObject);
    procedure EdMontoKeyPress(Sender: TObject; var Key: Char);
    procedure EdDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure EdCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure prReport1InitDetailBandDataSet(Sender: TObject;
      DetailBand: TprBand; DataSet: TObject; const DataSetName: String);
    procedure prReport1PrintComplete(Sender: TObject);
    procedure dblcbtipoKeyPress(Sender: TObject; var Key: Char);
    procedure dblcbtipoEnter(Sender: TObject);


  private
    function getimpreso : boolean;
    procedure setimpreso (nvalor:boolean);
    function getdescripcion:string;
    procedure setdescripcion (nvalor:string);
    function grabar : Boolean;
    function actualizar : Boolean;
    Procedure Empleado;
    function EvaluarCodigo(Codigo: string): string;
    procedure buscarcomprobante(ID_COMPROBANTE: integer; ID_AGENCIA:Integer);
    procedure BuscarComp(Id, Ag: Integer);
    procedure Inicializar;
    function Evaluarinforme(id : string) : string;
    function gettipoide :integer;
    procedure settipoide (nvalor:integer);
    function getmonto : currency;
    procedure setmonto (nvalor:currency);
    function gettasa : single;
    procedure settasa (nvalor:single);
    function Getdebito : currency;
    procedure Setdebito (nvalor:currency);
    function Getcredito : currency;
    procedure Setcredito (nvalor:currency);
    function getcodigo : string;
    procedure setcodigo (nvalor:string);
    function getidpersona:string;
    procedure setidpersona(nvalor:string);
    function getestado :string;
    procedure setestado (nvalor:string);
    function getnomcuenta : string;
    procedure setnomcuenta (nvalor:string);

  public
    property impreso : boolean read getimpreso write setimpreso;
    property descripcion : string read getdescripcion write setdescripcion;
    property tipoide : integer read gettipoide write settipoide;
    property monto : currency read getmonto write setmonto;
    property tasa : single read gettasa write settasa;
    property codigo: string read getcodigo write setcodigo;
    property debito : currency read getdebito write setdebito;
    property credito : currency read getcredito write setcredito;
    property idpersona : string read getidpersona write setidpersona;
    property estado: string read getestado write setestado;
    property nomcuenta: string read getnomcuenta write setnomcuenta;
  end;


var
  frmComprobanteC: TfrmComprobanteC;
  vid_comprobante       :string;
  vfechadia             :TDate;
  vfechadiamod          :TDate;
  vtipo_comprobante     :integer;
  vdescripcion          :string;
  vtotal_debito         :currency;
  vtotal_credito        :currency;
  vestadoc              :string;
  vimpreso              :boolean;
  vcomprobante          :integer;
  vcodigo               :string;
  vestado               :string;
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
  Apellidos             :String;
  SCuentas              :TList;
  movimiento            :Boolean;
  vid_persona           :string;
  vprimer_ape           :string;
  vsegundo_ape          :string;
  vtipoid               :integer;
  vmonto                :currency;
  vtasa                 :single;
  vdebito               :Currency;
  vcredito              :Currency;
  id                    :string;
  vnomcuenta            :string;

implementation

uses UnitdmGeneral, UnitPersona,
Unit_buscarcomprobante,unit_Dmpuc, UnitGlobales, Unit_DmComprobante;


{$R *.dfm}

var DmComprobante :TDmComprobante;

function TfrmComprobanteC.getdescripcion : string;
begin
        result:= vdescripcion;
end;

procedure TfrmComprobanteC.setdescripcion (nvalor:string);
begin
        vdescripcion:= nvalor;
        editdescripcion.Text:= vdescripcion;

end;


function TfrmComprobanteC.getimpreso : boolean;
begin
        result:= vimpreso;
end;

procedure TfrmComprobanteC.setimpreso (nvalor:boolean);
begin
        vimpreso:= nvalor;
        checkboximpreso.Checked := vimpreso;
end;

procedure TfrmComprobanteC.FormCreate(Sender: TObject);
begin
        DmComprobante := TDmComprobante.Create(self);
end;

function TfrmComprobanteC.grabar : Boolean;
var
Arecord : Plist;
I:integer;
begin

      Consecutivo := ObtenerConsecutivo(IBSQL1);
      Consec := FormatCurr('0000000',Consecutivo);
      Nocomprobante.Caption := consec;
      vid_comprobante:= consec;

      DmComprobante.IBQuery1.Transaction.StartTransaction;
      with dmcomprobante.IBQuery1 do
        try
         Close;
         sql.Clear;
         sql.Add('insert into "con$comprobante" ("con$comprobante"."ID_COMPROBANTE",');
         sql.Add('"con$comprobante"."FECHADIA", "con$comprobante"."TIPO_COMPROBANTE",');
         sql.Add('"con$comprobante"."ID_AGENCIA", "con$comprobante"."DESCRIPCION",');
         sql.Add('"con$comprobante"."TOTAL_DEBITO", "con$comprobante"."TOTAL_CREDITO",');
         sql.Add('"con$comprobante"."ESTADO", "con$comprobante"."IMPRESO",');
         sql.Add('"con$comprobante"."ANULACION","con$comprobante".ID_EMPLEADO)');
         sql.Add('values (');
         sql.Add(':"ID_COMPROBANTE", :"FECHADIA", :"TIPO_COMPROBANTE",');
         sql.Add(':"ID_AGENCIA", :"DESCRIPCION", :"TOTAL_DEBITO",');
         sql.Add(':"TOTAL_CREDITO", :"ESTADO", :"IMPRESO", :"ANULACION",:ID_EMPLEADO)');

         ParamByName('ID_COMPROBANTE').AsString:= vid_comprobante;
         ParamByname('FECHADIA').AsDate := fFechaActual;
         ParamByName('ID_AGENCIA').AsInteger := Agencia;
         ParamByName('TIPO_COMPROBANTE').AsInteger := dblcbtipo.KeyValue;
         ParamByName('DESCRIPCION').AsBlob := vdescripcion;
         ParamByName('TOTAL_DEBITO').AsCurrency  := vtotal_debito;
         ParamByName('TOTAL_CREDITO').AsCurrency  := vtotal_credito;
         ParamByName('ESTADO').AsString  := 'O';
         ParamByname('ANULACION').asstring := '';
         ParamByName('IMPRESO').AsInteger  := Ord(false);
         ParamByName('ID_EMPLEADO').AsString := DBAlias;
         ExecSQL;

         SQL.Clear;
         SQL.Add('insert into "con$auxiliar" values (');
         SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
         SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
         SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
         if List.Count > 0 then
         for I := 0 to List.Count -1 do
         begin
            Close;
            SQL.Clear;
            SQL.Add('insert into "con$auxiliar" values (');
            SQL.Add(':"ID_COMPROBANTE",:"ID_AGENCIA",:"FECHA",:"CODIGO",:"DEBITO",');
            SQL.Add(':"CREDITO",:"ID_CUENTA",:"ID_COLOCACION",:"ID_IDENTIFICACION",');
            SQL.Add(':"ID_PERSONA",:"MONTO_RETENCION",:"TASA_RETENCION",:"ESTADOAUX")');
            ARecord := List.Items[I];
            ParamByName('ID_COMPROBANTE').AsString := vid_comprobante;
            ParamByName('ID_AGENCIA').AsInteger:= Agencia;
            ParamByName('FECHA').AsDate := fFechaActual;
            ParamByName('CODIGO').AsString := Arecord^.codigo;
            ParamByName('DEBITO').AsCurrency := Arecord^.debito;
            ParamByName('CREDITO').AsCurrency := Arecord^.credito;
            ParamByName('ID_CUENTA').Clear;
            ParamByName('ID_COLOCACION').Clear;
            ParamByName('ID_IDENTIFICACION').AsInteger := Arecord^.tipoide;
            ParamByName('ID_PERSONA').AsString := Arecord^.idpersona;
            ParamByName('MONTO_RETENCION').AsCurrency := Arecord^.monto;
            ParamByName('TASA_RETENCION').AsFloat := Arecord^.tasa;
            ParamByName('ESTADOAUX').AsString := 'O';
            ExecSQL;
//            evaluarcodigo(Arecord^.codigo);
          end;
         Transaction.Commit;
         Result := true;
       except
         Transaction.Rollback;
         Result := false;
         raise;
       end;
end;

function TfrmComprobanteC.actualizar: Boolean;
var
Arecord : Plist;
I:integer;
begin

      with Dmcomprobante.IBQuery2 do
       try
         sql.Clear;
         sql.Add('update "con$comprobante" set ');
         sql.Add('"con$comprobante"."TIPO_COMPROBANTE" =:"TIPO_COMPROBANTE",');
         sql.Add('"con$comprobante"."DESCRIPCION" =:"DESCRIPCION",');
         sql.Add('"con$comprobante"."TOTAL_DEBITO" =:"TOTAL_DEBITO",');
         sql.Add('"con$comprobante"."TOTAL_CREDITO" =:"TOTAL_CREDITO",');
         sql.Add('"con$comprobante"."ESTADO" =:"ESTADO",');
         sql.Add('"con$comprobante"."IMPRESO" =:"IMPRESO",');
         sql.Add('"con$comprobante"."ANULACION" =:"ANULACION",');
         sql.Add('"con$comprobante".ID_EMPLEADO = :ID_EMPLEADO');
         sql.Add(' where ');
         sql.Add('"con$comprobante"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and');
         sql.Add('"con$comprobante"."ID_AGENCIA" = :"ID_AGENCIA"');

         ParamByName('ID_COMPROBANTE').AsString:= vid_comprobante;
         ParamByName('ID_AGENCIA').AsInteger := Agencia;
         ParamByName('TIPO_COMPROBANTE').AsInteger := dblcbtipo.KeyValue;
         ParamByName('DESCRIPCION').AsString := vdescripcion;
         ParamByName('TOTAL_DEBITO').AsCurrency  := vtotal_debito;
         ParamByName('TOTAL_CREDITO').AsCurrency  := vtotal_credito;
         ParamByName('ESTADO').AsString  := 'O';
         ParamByName('IMPRESO').AsInteger  := Ord(False);
         ParamByName('ANULACION').AsString := anulacion;
         parambyname('ID_EMPLEADO').AsString := DBAlias;
         ExecSQL;

         SQL.Clear;
         SQL.Add('delete from "con$auxiliar" where ');
         SQL.Add('"con$auxiliar"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and');
         SQL.Add('"con$auxiliar"."ID_AGENCIA" = :"ID_AGENCIA"');
         ParamByName('ID_COMPROBANTE').AsString:= vid_comprobante;
         ParamByName('ID_AGENCIA').AsInteger := Agencia;
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
            ParamByName('ID_AGENCIA').AsInteger:= Agencia;
            ParamByName('FECHA').AsDate := vfechadiamod;
            ParamByName('CODIGO').AsString := Arecord^.codigo;
            ParamByName('DEBITO').AsCurrency := Arecord^.debito;
            ParamByName('CREDITO').AsCurrency := Arecord^.credito;
            ParamByName('ID_CUENTA').Clear;
            ParamByName('ID_COLOCACION').Clear;
            ParamByName('ID_IDENTIFICACION').AsInteger := Arecord^.tipoide;
            ParamByName('ID_PERSONA').AsString := Arecord^.idpersona;
            ParamByName('MONTO_RETENCION').AsCurrency := Arecord^.monto;
            ParamByName('TASA_RETENCION').AsFloat := Arecord^.tasa;
            ParamByname('ESTADOAUX').AsString := 'O';
            ExecSQL;
         end;
         Transaction.Commit;
         Result := true;
         vmodificar:= true;
         buscarcomp(StrToInt(vid_comprobante),Agencia);
       except
         Transaction.Rollback;
         vmodificar:= true;
         buscarcomp(StrToInt(vid_comprobante),Agencia);
         Result := false;
       end;
end;


procedure TfrmComprobanteC.BtnGrabarClick(Sender: TObject);
var
    TotalDebito:Currency;
    TotalCredito:Currency;
    i:Integer;
    ARecord: PList;
begin
  Application.ProcessMessages;

  TotalDebito := 0;
  TotalCredito := 0;

  for i:= 0 to List.Count - 1 do begin
     ARecord := List.Items[i];
     TotalDebito := TotalDebito + ARecord^.debito;
     TotalCredito := TotalCredito + ARecord^.credito;
  end;

  if DmGeneral.IBTransaction1.InTransaction then
     DmGeneral.IBTransaction1.Commit;
  dmGeneral.IBTransaction1.StartTransaction;
  if vModificar then
     begin
      if descripcion ='' then begin
         messagedlg('No ha digitado la descripci�n',mtError,[mbOk],0);
         editdescripcion.SetFocus;
         exit;
        end;
      if List.Count = 0 then
       begin
         messagedlg('No ha digitado ning�n movimiento',mtError,[mbOk],0);
         exit;
       end;
      if TotalDebito <> TotalCredito then
       begin
        messagedlg('El comprobante No est� cuadrado',mtError,[mbOk],0);
        exit;
       end;
      BtnGrabar.Enabled := False;
      if Actualizar then
          begin
           MessageDlg('El Comprobante se Actualiz�',mtInformation,[mbOK],0);
           vmodificar := true;
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
      if descripcion ='' then
        begin
         messagedlg('No ha digitado la descripci�n',mtError,[mbOk],0);
         editdescripcion.SetFocus;
         exit;
        end;
      if List.Count = 0 then
       begin
         messagedlg('No ha digitado ning�n movimiento',mtError,[mbOk],0);
         exit;
       end;
      if TotalDebito <> TotalCredito then
        begin
         messagedlg('El comprobante No est� cuadrado',mtError,[mbOk],0);
         exit;
        end;
     BtnGrabar.Enabled := False;
     if Grabar then
       begin
       MessageDlg('El Comprobante fue Grabado',mtInformation,[mbOK],0);
       BtnGrabar.Enabled := True;
       Btngrabar.Caption := '&Modificar';
       Application.ProcessMessages;
       Btnreporte.Click;
       vmodificar := True;
       BuscarComp(StrToInt(vid_comprobante),Agencia);
       end
     else
       MessageDlg('Comprobante No Grabado',mtError,[mbOK],0);
   end;
end;


procedure TfrmComprobanteC.BtncerrarClick(Sender: TObject);
begin
        self.Close;
end;

procedure TfrmComprobanteC.actualizaxsauxiliar;
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
        xsauxiliar.ColWidths[1] := 180;
        xsauxiliar.Cells [1,i+1] := arecord^.nomcuenta;
        xsauxiliar.ColWidths[3] := 90;
        xsauxiliar.Cells [3,i+1] := formatcurr ('#,##0.00',Arecord^.debito);
        vtotal_debito := vtotal_debito + ARecord^.debito;
        xsauxiliar.ColWidths[4] := 90;
        xsauxiliar.Cells [4,i+1] := formatcurr ('#,##0.00',Arecord^.credito);
        vtotal_credito := vtotal_credito + Arecord^.credito;
        edittotaldebito.Text := currtostr(vtotal_debito);
        edittotalcredito.Text := currtostr(vtotal_credito);
        if ARecord^.idpersona <> '' then
        xsauxiliar.Cells [2,i+1] := arecord^.idpersona;
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

procedure TfrmComprobanteC.CheckBoximpresoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
        if Key = 13 then
        btnAgregar.SetFocus;
end;


procedure TfrmComprobanteC.BtnlimpiarClick(Sender: TObject);
begin
        Inicializar;
end;

procedure TfrmComprobanteC.editdescripcionExit(Sender: TObject);
begin
        if editdescripcion.Text <> '' then
          begin
           descripcion := editdescripcion.Text;
           editdescripcion.Text := uppercase(descripcion);
           vdescripcion := editdescripcion.Text;
           editcodigo.SetFocus;           
          end
        else
          begin
           MessageDlg('No ha digitado la Descripcion del Comprobante',mtError,[mbOK],0);
//           editdescripcion.SetFocus;
          end;

end;

procedure TfrmComprobanteC.BtnBuscarClick(Sender: TObject);
var
opcion:integer;
begin
        btnlimpiar.Click;
        frmbuscarcomprobante := Tfrmbuscarcomprobante.Create(Self);
        frmBuscarcomprobante.Position:= poMainFormCenter;
        Opcion := frmbuscarcomprobante.ShowModal;
        if Opcion = mrOK then
        begin
          id_comprobante:= strtoint(frmbuscarcomprobante.EditCODIGO.Text);
          id_agencia:= 1;
          frmBuscarcomprobante.Free;
          buscarcomp(id_comprobante,id_agencia);
        end;
end;


procedure TfrmComprobanteC.btnrefrescarClick(Sender: TObject);
begin
     dmcomprobante.IBQsetcomprobante.Close;
     dmcomprobante.IBQsetcomprobante.Open;
     DmComprobante.IBQsetauxiliar.close;
     DmComprobante.IBQsetauxiliar.Open;
end;

procedure TfrmComprobanteC.BtnAnularClick(Sender: TObject);
begin
                if (estadoc= 'N') and (estadoa= 'N')  then
                 begin
                  buscarcomprobante(id_comprobante,id_agencia);
                  bloquear;
                  MessageDlg('El Comprobante ya est� anulado',mtError,[mbOk],0);
                  Btnlimpiarclick(sender);
                  desbloquear;
                  exit;
                 end;
                if (estadoc= 'C') and (estadoa= 'C') then
                 begin
                  buscarcomprobante(id_comprobante,id_agencia);
                  bloquear;
                  MessageDlg('El comprobante est� cerrado, No se puede Anular',mtError,[mbOk],0);
                  BtnLimpiarclick(sender);
                  desbloquear;
                  exit;
                 end;
                if (estadoc= 'O') and (estadoa= 'O') then
                begin
                   if  MessageDlg('Seguro de Anular Comprobante',mtConfirmation,[mbYes,mbNo],0) = mrYes then
                    begin
                        vestadoc:= 'N';
                        vestadoa:= 'N';
                        buscarcomprobante(id_comprobante,id_agencia);
                        label8.Visible:= true;
                        editanulacion.Visible:= true;
                        editanulacion.SetFocus;
                     end;
                end;
                if (estadoc ='') or (estadoa = '') then
                 begin
                  MessageDlg('El comprobante no existe',mtError,[mbOk],0);
                  BtnAnular.SetFocus;
                 end;
end;

procedure TfrmComprobanteC.bloquear;
var
I,J:integer;
begin
    I := Self.ComponentCount -1;

    for J := 0 to I do
    begin
        if Self.Components[J] is TMemo then begin
           TMemo(Self.Components[J]).ReadOnly:= true;
           TMemo(Self.Components[J]).Color:= clLtGray;
        end
        else
        if Self.Components[J] is TDBLookupComboBox then begin
           TDBLookupComboBox(Self.Components[J]).ReadOnly:= true;
           TDBLookupComboBox(Self.Components[J]).Color:= clLtGray;
        end
        else
        if Self.Components[J] is TEdit then begin
           TEdit(Self.Components[J]).ReadOnly:= true;
           TEdit(Self.Components[J]).color:= clLtgray;
        end

        end;
    end;

procedure TfrmComprobanteC.desbloquear;
var
I,J:integer;
begin
    I := Self.ComponentCount -1;

    for J := 0 to I do
    begin
        if Self.Components[J] is TMemo then begin
           TMemo(Self.Components[J]).ReadOnly:= false;
           TMemo(Self.Components[J]).Color:= clWindow;
        end
        else
        if Self.Components[J] is TDBLookupComboBox then begin
           TDBLookupComboBox(Self.Components[J]).ReadOnly:= false;
           TDBLookupComboBox(Self.Components[J]).Color:= clWindow;
        end
        else
        if Self.Components[J] is TEdit then begin
           TEdit(Self.Components[J]).ReadOnly:= false;
           TEdit(Self.Components[J]).color:= clWindow;
        end

        end;
    end;

procedure TfrmComprobanteC.buscarcomprobante(ID_COMPROBANTE: integer; ID_AGENCIA:integer);
var
auxiliar:integer;
Arecord:Plist;
begin
        with dmcomprobante.IBQuery1 do
            begin
                SQL.Clear;
                SQL.Add('select * from "con$comprobante" where "con$comprobante"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
                SQL.Add('and "con$comprobante"."ID_AGENCIA" =:"ID_AGENCIA"');
                paramByName('ID_COMPROBANTE').AsInteger:= ID_COMPROBANTE;
                ParamByName('ID_AGENCIA').AsInteger:= id_agencia;
                Active := True;
                vid_comprobante:= inttostr(fieldbyname('ID_COMPROBANTE').AsInteger);
                if DmComprobante.IBQuery1.RecordCount > 0 then
                begin
                   Nocomprobante.Caption:= FormatCurr('0000000',StrToCurr(vid_comprobante));
                   vfechadiamod := FieldByName('FECHADIA').AsDateTime;
                   fechadia.Caption := datetostr(fieldbyname('FECHADIA').AsDateTime);
                   vtipo_comprobante := strtoint(trim(fieldbyname('TIPO_COMPROBANTE').AsString));
                   dblcbtipo.KeyValue := vtipo_comprobante;
                   vdescripcion := fieldbyname('DESCRIPCION').AsString;
                   editdescripcion.Text:= vdescripcion;
                   vtotal_debito := fieldbyname('TOTAL_DEBITO').AsCurrency;
                   edittotaldebito.Text:= formatcurr('#,##0.00',vtotal_debito);
                   vtotal_credito := fieldbyname('TOTAL_CREDITO').AsCurrency;
                   edittotalcredito.Text:= formatcurr('#,##0.00',vtotal_credito);
                   vestadoc:= fieldbyname('ESTADO').AsString;
                   vimpreso := inttoboolean(fieldbyname('IMPRESO').AsInteger);
                   BtnGrabar.Caption := '&Modificar';
                   if vimpreso then
                      checkboximpreso.Checked := true;
                   if vestadoc = 'N' then
                     begin
                      checkboxanulado.Checked:= true;
                      label8.Visible:= true;
                      editanulacion.Visible:= true;
                      anulacion := fieldbyname('ANULACION').AsString;
                      editanulacion.Text:= anulacion;
                     end
                   else
                   if estadoc = 'C' then
                     checkboxcerrado.Checked:= true;
                end;
            end;

        with Dmcomprobante.IBQuery2 do
          begin
                List.Clear;
                SQL.Clear;
                SQL.Add('select * from "con$auxiliar" where "con$auxiliar"."ID_COMPROBANTE" =:"ID_COMPROBANTE"');
                SQL.Add('and "con$auxiliar"."ID_AGENCIA" =:"ID_AGENCIA"');
                paramByName('ID_COMPROBANTE').AsInteger:= ID_COMPROBANTE;
                ParamByName('ID_AGENCIA').AsInteger:= ID_AGENCIA;
                Active := True;
                auxiliar:= fieldbyname('ID_COMPROBANTE').AsInteger;
                if (auxiliar <> 0) then
                 begin
                    DmComprobante.IBQuery2.Active:= true;
                    Dmcomprobante.IBQuery2.Last;
                    Dmcomprobante.IBQuery2.First;
                    while not Dmcomprobante.IBQuery2.Eof do
                    begin
                    New(Arecord);
                    ARecord^.codigo:= fieldbyname('CODIGO').AsString;
                    with Dmcomprobante.IBQuery1 do
                     begin
                      sql.Clear;
                      Sql.Add('select "NOMBRE" from "con$puc" where "con$puc"."CODIGO" =:"CODIGO"');
                      parambyname('CODIGO').AsString := Arecord^.codigo;
                      active := true;
                      nombre := fieldbyname('NOMBRE').AsString;
                     end;
                    ARecord^.nomcuenta:= nombre;
                    Arecord^.debito:= fieldbyname('DEBITO').AsCurrency;
                    Arecord^.credito:= fieldbyname('CREDITO').AsCurrency;
                    Arecord^.tipoide:=fieldbyname('ID_IDENTIFICACION').AsInteger;
                    Arecord^.idpersona:=fieldbyname('ID_PERSONA').AsString;
                    Arecord^.monto:=fieldbyname('MONTO_RETENCION').AsCurrency;
                    Arecord^.tasa:=fieldbyname('TASA_RETENCION').AsFloat;
                    Arecord^.estado:=fieldbyname('ESTADOAUX').AsString;
                    List.Add(Arecord);
                    next;
                    end;
                    actualizaxsauxiliar;
                 end;
          end;
end;



procedure TfrmComprobanteC.CheckBoxcerradoKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(key,self);
end;

procedure TfrmComprobanteC.CheckBoxanuladoKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(key,self);
end;

procedure TfrmComprobanteC.XSauxiliarSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
        posgrid := ARow-1;
        CanSelect := true;
        if vmodificar then
        begin
          BtnModificargrid.Enabled := false;
          BtnEliminar.Enabled := false;
        end
        else
        begin
          BtnModificargrid.Enabled := True;
          BtnEliminar.Enabled := true;
        end;
end;

procedure TfrmComprobanteC.editanulacionKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
        if key = 13 then
        BtnAgregar.SetFocus;
end;

procedure TfrmComprobanteC.editanulacionExit(Sender: TObject);
var
I : integer;
begin
anulacion:=editanulacion.Text;
editanulacion.Text := uppercase(anulacion);
anulacion := editanulacion.Text;
if anulacion <> '' then
 begin
  with Dmcomprobante.IBQuery1 do
   begin
    sql.Clear;
    Sql.Add('update "con$comprobante" set "con$comprobante"."ANULACION" = :"anulacion",');
    Sql.Add('"con$comprobante"."ESTADO" = :"estado"');
    sql.Add('where "con$comprobante"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and "con$comprobante"."ID_AGENCIA" = :"ID_AGENCIA"');
    parambyname('ID_COMPROBANTE').AsInteger := id_comprobante;
    parambyname('ID_AGENCIA').AsInteger := Agencia;
    parambyname('ANULACION').AsString := anulacion;
    parambyname('ESTADO').AsString := 'N';
    active := true;
    Transaction.CommitRetaining;
   end;
  with Dmcomprobante.IBQuery2 do
   begin
    sql.Clear;
    Sql.Add('update "con$auxiliar" set ');
    Sql.Add('"con$auxiliar"."ESTADOAUX" = :"ESTADOAUX"');
    sql.Add('where "con$auxiliar"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and "con$auxiliar"."ID_AGENCIA" = :"ID_AGENCIA"');
    parambyname('ID_COMPROBANTE').AsInteger := id_comprobante;
    parambyname('ID_AGENCIA').AsInteger := agencia;
    for I := 0 to List.Count -1 do
      ParamByName('ESTADOAUX').AsString := 'N';
    active := true;
    Transaction.CommitRetaining;
   end;
    MessageDlg('Comprobante Anulado',mtConfirmation,[mbOk],0);
    BtnLimpiarClick(sender);
    label8.Visible:= false;
    editanulacion.Visible:= false;
    Btnlimpiar.SetFocus;
 end
 else
 begin
  MessageDlg('Debe digitar la causal de anulacion',mtError,[mbOk],0);
  editanulacion.SetFocus;
 end;
end;


procedure TfrmComprobanteC.editanulacionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if key = #13 then
        BtnBuscar.SetFocus;
end;

procedure TfrmComprobanteC.dblcbtipo_compKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmComprobanteC.DblcbAgenciaKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmComprobanteC.editdescripcionKeyPress(Sender: TObject;
  var Key: Char);
begin
       EnterTabs(Key,Self);
end;

procedure TfrmComprobanteC.BtnModificarGridClick(Sender: TObject);
var
Arecord: Plist;
AR:PCuentas;
i:Integer;
begin
        ARecord := List.Items[posgrid];
        codigo:= arecord^.codigo;
        Label5.Caption := Arecord^.nomcuenta;
        debito := Arecord^.debito;
        credito := Arecord^.credito;
        tipoide:= Arecord^.tipoide;
        idpersona := Arecord^.idpersona;
        monto := Arecord^.monto;
        tasa := Arecord^.tasa;
        estado := Arecord^.estado;
              posgrid:= -1;

             actualizaxsauxiliar;
             BtnModificargrid.Enabled := false;
             Btneliminar.Enabled := false;
end;

procedure TfrmComprobanteC.BtnAgregarClick(Sender: TObject);
var
ARecord: PList;
i:Integer;
begin
        if codigo = '' then begin
          MessageDlg('Debe Digitar un C�digo',mtError,[mbok],0);
          editcodigo.SetFocus;
          Exit;
        end;

        if (debito = 0) and (credito = 0) then
          begin
           MessageDlg('Debe digitar un valor debito � cr�dito',mtError,[mbOk],0);
           eddebito.SetFocus;
           Exit;
          end;


           New(ARecord);
           ARecord^.codigo := codigo;
           ARecord^.debito := debito;
           ARecord^.credito:= credito;
           ARecord^.nomcuenta := nomcuenta;
           ARecord^.tipoide := tipoide;
           ARecord^.idpersona:= idpersona;
           ARecord^.monto := monto;
           ARecord^.tasa := tasa;
           Arecord^.estado := estado;
           List.Add(ARecord);

           actualizaxsauxiliar;

           editcodigo.Text := '';
           EdDebito.Value := 0;
           EdCredito.Value := 0;
           debito := 0;
           credito := 0;
           Label11.Caption := '';

           Edtipoid.KeyValue := -1;
           Edtipoid.Enabled := False;

           EdNit.Text := '';
           EdNit.Enabled := False;

           EdMonto.Text := '';
           EdMonto.Enabled := False;

           EdTasa.Text := '';
           EdTasa.Enabled := False;

           Label3.Caption := '';
           Label3.Visible := False;

           editcodigo.SetFocus;
end;


procedure TfrmComprobanteC.BtnEliminarClick(Sender: TObject);
var
Arecord : Plist;
i:Integer;
AR:PCuentas;
begin
        if posgrid <> -1 then
        begin
           ARecord := List.Items[posgrid];
           List.Remove(ARecord);
           List.Pack;
           posgrid := -1;
           Actualizaxsauxiliar;
           BtnEliminar.Enabled := false;
           BtnModificargrid.Enabled := false;

           editcodigo.Text := '';
           EdDebito.Value := 0;
           EdCredito.Value := 0;
           debito := 0;
           credito := 0;
           Label11.Caption := '';

           Edtipoid.KeyValue := -1;
           Edtipoid.Enabled := False;

           EdNit.Text := '';
           EdNit.Enabled := False;

           EdMonto.Text := '';
           EdMonto.Enabled := False;

           EdTasa.Text := '';
           EdTasa.Enabled := False;

           Label3.Caption := '';
           Label3.Visible := False;           

        end
        else
         MessageDlg('No Seleccion� Movimiento',mterror,[mbOk],0);
end;


procedure TfrmComprobanteC.BtnreporteClick(Sender: TObject);
var
anulacion : string;
Tabla : String;
begin
        with IBAuxiliar do begin
         if  Transaction.InTransaction then
            Transaction.Commit;
         Transaction.StartTransaction;
         empleado;

         Close;
         ParamByName('ID_AGENCIA').AsInteger := Agencia;
         ParamByName('ID_COMPROBANTE').AsInteger := StrToInt(NoComprobante.Caption);
         try
          Open;
          prReport1.Variables.ByName['EMPRESA'].AsString := Empresa;
          prReport1.Variables.ByName['NIT'].AsString := Nit;
          prReport1.Variables.ByName['FechaHoy'].AsDateTime := fFechaActual;
          if prReport1.PrepareReport then
            prReport1.PreviewPreparedReport(True);
         except
          MessageDlg('Error al generar el reporte',mtError,[mbcancel],0);
         end;
        end;
end;

procedure TfrmComprobanteC.CheckBoximpresoExit(Sender: TObject);
begin
        if checkboximpreso.Checked = true then
          vimpreso := true
        else
          vimpreso := false;
end;

procedure TfrmComprobanteC.Report1PrintComplete(Sender: TObject);
begin
      vimpreso := true;
      with Dmcomprobante.IBQuery2 do
       begin
         sql.Clear;
         sql.Add('update "con$comprobante" set ');
         sql.Add('"con$comprobante"."IMPRESO" = :"IMPRESO"');
         sql.Add(' where ');
         sql.Add('"con$comprobante"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and');
         sql.Add('"con$comprobante"."ID_AGENCIA" = :"ID_AGENCIA"');

         ParamByName('ID_COMPROBANTE').AsString:= vid_comprobante;
         ParamByName('ID_AGENCIA').AsInteger := Agencia;
         ParamByName('IMPRESO').AsInteger  := ord(vimpreso);
         ExecSQL;
       end;
end;


procedure TfrmComprobanteC.EdittotaldebitoExit(Sender: TObject);
begin
        vtotal_debito:= strtocurr(edittotaldebito.Text);
end;

procedure TfrmComprobanteC.EdittotalcreditoExit(Sender: TObject);
begin
        vtotal_credito:= strtocurr(edittotalcredito.Text);
end;

procedure TfrmComprobanteC.Empleado;
begin
        with DmComprobante.IBQuery1 do
         begin
           sql.Clear;
           sql.Add('select PRIMER_APELLIDO, SEGUNDO_APELLIDO, NOMBRE from "gen$empleado"');
           sql.Add('where "gen$empleado"."ID_EMPLEADO" =:"ID_EMPLEADO"');
           ParamByName('ID_EMPLEADO').AsString := DBAlias;
           Open;
           Nombres := FieldByName('NOMBRE').AsString;
           Apellidos := FieldByname('PRIMER_APELLIDO').AsString + '   ' + FieldByName('SEGUNDO_APELLIDO').AsString;
         end;
end;

procedure TfrmComprobanteC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        DmComprobante.Free;
end;

function TfrmComprobanteC.EvaluarCodigo(Codigo: string): string;
begin
    with Dmcomprobante.IBQuery1 do
    begin
     sql.Clear;
     Sql.Add('select "NOMBRE", "MOVIMIENTO", "INFORME"');
     Sql.Add('from "con$puc"');
     Sql.Add('where "con$puc"."ID_AGENCIA" =:"ID_AGENCIA" and');
     Sql.Add('"con$puc"."CODIGO" =:"CODIGO"');
     parambyname('ID_AGENCIA').AsInteger := Agencia;
     parambyname('CODIGO').AsString := codigo;
     Open;
     nombre := FieldByName('NOMBRE').AsString;
     movimiento:= IntToBoolean(FieldByName('MOVIMIENTO').AsInteger);
     id := Fieldbyname('INFORME').AsString;
     if DmComprobante.IBQuery1.RecordCount > 0 then
      begin
        Label11.Visible:= true;
        Label11.Caption:= nombre;
        result := nombre;

        if not movimiento then
          begin
           MessageDlg('La Cuenta no es de Movimiento',mtError,[mbOk],0);
           editcodigo.SetFocus;
           editcodigo.Text:= '';
           label11.Visible := false;
           exit;
          end;
      end
     else
      begin
        MessageDlg('La cuenta no Existe',mtError,[mbOk],0);
        editcodigo.Text:= '';
        editcodigo.SetFocus;
        label11.Caption := '';
        Label11.Visible := False;
        GrupoInforme.Enabled := False;
      end;
    end;
end;


procedure TfrmComprobanteC.BuscarComp(Id, Ag: Integer);
begin
          with dmcomprobante.IBQuery1 do
          begin
           if Transaction.InTransaction then
              Transaction.Commit;
           Transaction.StartTransaction;
           DmComprobante.IBQsetagencia.Open;
           dmcomprobante.IBQsettipocomp.Open;
           dmcomprobante.IBQsetauxiliar.Open;
           SQL.Clear;
           SQL.Add('select "con$comprobante".ESTADO, "con$auxiliar".ESTADOAUX from "con$comprobante"');
           SQL.Add('LEFT JOIN "con$auxiliar" ON ("con$comprobante".ID_COMPROBANTE = "con$auxiliar".ID_COMPROBANTE and "con$comprobante".ID_AGENCIA = "con$auxiliar".ID_AGENCIA)');
           SQL.Add(' where "con$comprobante".ID_COMPROBANTE = :"ID_COMPROBANTE" AND "con$comprobante".ID_AGENCIA = :"ID_AGENCIA"');
           paramByName('ID_COMPROBANTE').AsInteger:= Id;
           ParamByName('ID_AGENCIA').AsInteger:= Ag;
           Active := True;
           estadoc:= fieldbyname('ESTADO').AsString;
           estadoa:= FieldByName('ESTADOAUX').AsString;
           if dmcomprobante.IBQuery1.RecordCount > 0 then
             begin
              buscarcomprobante(id_comprobante,id_agencia);
              vmodificar:= true;
              if (estadoc= 'N') or (estadoc = 'C') or (estadoa= 'C') or (estadoa= 'N')  then
                 begin
                 MessageDlg('No se puede Modificar, El Comprobante est� Cerrado o Anulado',mtError,[mbOk],0);
                 BtnGrabar.Enabled := false;
                 BtnAnular.Enabled := false;
                 BtnRefrescar.Enabled := false;
                 BtnAgregar.Enabled := false;
                 BtnCerrar.Enabled := True;
                 PanelXS.Enabled := False;
                 bloquear;
                 xsauxiliar.Enabled := True;
                 end;
             end
           else
             begin
              MessageDlg('El comprobante no existe',mtError,[mbOk],0);
              BtnBuscar.SetFocus;
             end;
          end;
          

          if vmodificar then
          begin
           BtnModificarGrid.Enabled := False;
           BtnEliminar.Enabled := False;
          end
          else
          begin
           BtnModificarGrid.Enabled := True;
           BtnEliminar.Enabled := True;
          end;

end;

procedure TfrmComprobanteC.Inicializar;
begin
        if DmGeneral.IBTransaction1.InTransaction then
           DmGeneral.IBTransaction1.Commit;
        DmGeneral.IBTransaction1.StartTransaction;

        if IBQTiposIdentificacion.Transaction.InTransaction then
          IBQTiposIdentificacion.Transaction.Commit;
        IBQTiposIdentificacion.Transaction.StartTransaction;

        if IBQTipoC.Transaction.InTransaction then
          IBQTipoC.Transaction.Commit;
        IBQTipoC.Transaction.StartTransaction;

        
        IBQTipoC.Open;
        IBQTipoC.Last;
        DmComprobante.IBQsetagencia.Open;
        dmcomprobante.IBQsetauxiliar.Open;
        xsauxiliar.ColWidths [0] := 112;
        xsauxiliar.ColWidths [1] := 130;
        xsauxiliar.ColWidths [2] := 70;
        xsauxiliar.ColWidths [3] := 90;
        xsauxiliar.ColWidths [4] := 90;
//        XSauxiliar.ColWidths [5] := 30;
        xsauxiliar.Cols[0].Text  := 'C�digo';
        xsauxiliar.Cols[1].Text  := 'Nombre Cuenta';
        xsauxiliar.Cols[2].Text  := 'Dto/Nit';
        xsauxiliar.Cols[3].Text  := 'D�bitos';
        xsauxiliar.Cols[4].Text  := 'Cr�ditos';
//        XSauxiliar.Cols[5].Text  := 'GMF';
        try
          List := Tlist.Create;
          SCuentas := TList.Create;
        finally
          List.Clear;
          SCuentas.Clear;
        end;
        fechadia.Caption := DateToStr(Date);
        editdescripcion.Text := '';
        edittotaldebito.Text:= '';
        edittotalcredito.Text:='';
        editanulacion.Text:='';
        BtnModificargrid.Enabled := false;
        BtnEliminar.Enabled := false;
        xsauxiliar.Enabled := True;
        posgrid := -1;
        vmodificar := False;
        id_comprobante:= 0;
        id_agencia:= 0;
        vfechadia := Date;
        vfechadiamod := Date;
        vid_comprobante:= '';
        vtipo_comprobante := 0;
        vdescripcion:= '';
        anulacion:= '';
        vtotal_debito:= 0;
        vtotal_credito:= 0;
        vestadoc:= '';
        estadoc := '';
        vestadoa:= '';
        estadoa := '';
        desbloquear;
        edittotaldebito.Color := clMoneyGreen;
        edittotalcredito.Color := clMoneyGreen;
        label8.Visible := false;
        editanulacion.Visible := false;
        BtnGrabar.Enabled := true;
        BtnGrabar.Caption := '&Grabar';
        BtnAnular.Enabled := true;
        BtnRefrescar.Enabled := true;
        Btncerrar.Enabled := true;
        BtnAgregar.Enabled := True;
        xsauxiliar.Enabled := True;
        PanelXS.Enabled := True;
        editcodigo.Text := '';
        EdDebito.Value := 0;
        EdCredito.Value := 0;
        Edtipoid.KeyValue := -1;
        EdNit.Text := '';
        EdTasa.Text := '';
        EdMonto.Text := '';
        Edtipoid.Enabled := False;
        EdNit.Enabled := False;
        EdTasa.Enabled := False;
        EdMonto.Enabled := False;
        NoComprobante.Caption := '';
        Label11.Caption := '';
        Label3.Caption := '';
        codigo := '';
        debito := 0;
        credito := 0;
        nomcuenta := '';
        vmonto := 0;
        vtasa := 0;
        tipoide := 0;
        idpersona := '';
        dblcbtipo.DropDown;
        dblcbtipo.KeyValue := 1;
        dblcbtipo.SetFocus;
end;

procedure TfrmComprobanteC.FormShow(Sender: TObject);
begin
        Inicializar;
        Panel5.Caption := Empresa + '   Nit   ' + Nit;
end;

procedure TfrmComprobanteC.Report1InitDetailBandDataSet(Sender: TObject;
  DetailBand: TprBand; DataSet: TObject; const DataSetName: String);
begin
        if DataSetName = 'IBAuxiliar1' then begin
          with IBAuxiliar1 do begin
            Close;
            ParamByName('ID_IDENTIFICACION').AsInteger := IBAuxiliar.FieldByName('ID_IDENTIFICACION').AsInteger;
            ParamByName('ID_PERSONA').AsString := IBAuxiliar.FieldByName('ID_PERSONA').AsString;
            try
             Open;
            except
             raise;
            end;
          end;
        end;
end;

procedure TfrmComprobanteC.editcodigoExit(Sender: TObject);
var Cadena, informe:string;
begin
    Cadena := EditCODIGO.Text;
    while Pos(' ',Cadena) > 0 do
    Cadena[Pos(' ',Cadena)] := '0';
    Codigo := Cadena;
    if (codigo <> '') then begin
      nomcuenta := evaluarcodigo(codigo);
      informe := evaluarinforme(id);
    end;
end;

procedure TfrmComprobanteC.editcodigoEnter(Sender: TObject);
begin
        editcodigo.SelectAll;
end;

procedure TfrmComprobanteC.editcodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmComprobanteC.EdDebitoEnter(Sender: TObject);
begin
//        EdDebito.Value := debito;
        EdDebito.SelectAll;
end;

procedure TfrmComprobanteC.EdDebitoExit(Sender: TObject);
begin
        debito := EdDebito.Value;
        if debito > 0 then BtnAgregar.SetFocus;
end;

procedure TfrmComprobanteC.EdCreditoEnter(Sender: TObject);
begin
//        EdCredito.Value := credito;
        EdCredito.SelectAll;
end;

procedure TfrmComprobanteC.EdCreditoExit(Sender: TObject);
begin
        credito := EdCredito.Value;
        if (debito <> 0) and (credito<>0) then
        begin
          MessageDlg('Ambos, debitos y creditos no pueden tener valor',mtError,[mbcancel],0);
          EdDebito.SetFocus;
          Exit;
        end;
        BtnAgregar.SetFocus;
end;

procedure TfrmComprobanteC.EdtipoidEnter(Sender: TObject);
begin
    Edtipoid.KeyValue := self.tipoide;
    Edtipoid.DropDown;
end;

procedure TfrmComprobanteC.EdtipoidExit(Sender: TObject);
begin
    tipoide := Edtipoid.KeyValue;
end;

procedure TfrmComprobanteC.EdtipoidKeyPress(Sender: TObject;
  var Key: Char);
begin
        if key= #13 then
          EdNit.SetFocus;
end;

procedure TfrmComprobanteC.EdNitEnter(Sender: TObject);
begin
        EdNit.SelectAll;
end;

procedure TfrmComprobanteC.EdNitExit(Sender: TObject);
begin
            with IBSQL2 do
              begin
               if Transaction.InTransaction then
                 Transaction.Commit;
               Transaction.StartTransaction;
               Close;
               SQL.Clear;
               SQL.Add('select * from "gen$persona" where ID_IDENTIFICACION = :ID_IDENTIFICACION and ID_PERSONA = :ID_PERSONA');
               ParamByName('ID_IDENTIFICACION').AsInteger := Edtipoid.KeyValue;
               ParamByName('ID_PERSONA').AsString := EdNit.Text;
               try
                ExecQuery;
                if RecordCount > 0 then begin
                   Label3.Visible := True;
                   Label3.Caption := FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                     FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                     FieldByName('NOMBRE').AsString;
                end
                else
                  if MessageDlg('El Documento no Existe!, Desea Agregarlo',mtConfirmation,[mbyes,mbno],0) = mryes then
                  begin
                    frmPersona := TfrmPersona.Create(Self);
                    frmPersona.ShowModal;
                    EdNitexit(Sender);
                  end
                  else
                    EdNit.SetFocus;
               except
                  Transaction.Rollback;
                  raise;
               end;
              end;
end;

procedure TfrmComprobanteC.EdNitKeyPress(Sender: TObject; var Key: Char);
begin
    if key = #13 then
        if EdNit.Text <> '' then
         begin
           vid_persona := EdNit.Text;
           if EdMonto.Enabled then
             EdMonto.SetFocus
           else
          eddebito.SetFocus;

           with Dmcomprobante.IBQsetpersona do
            begin
              if Transaction.InTransaction then
                Transaction.Commit;
              Transaction.StartTransaction;
              ParamByName('ID_IDENTIFICACION').AsInteger := Edtipoid.KeyValue;
              ParamByName('ID_PERSONA').AsString := EdNit.Text;
              Open;
              Last;
              First;
              if RecordCount = 1 then
               begin
                 label3.Visible:= true;
                 label3.Caption := FieldByName('PRIMER_APELLIDO').AsString + ' '+
                                   FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                   FieldByName('NOMBRE').AsString;
               end
              else
               begin
                if MessageDlg('La Persona no existe, �Desea Crearla?',mtconfirmation,[mbYes,mbNo],0)= mryes then
                 begin
//                   frmCreacionPersona:= TfrmCreacionPersona.Create(self);
//                   frmcreacionpersona.Show;
                 end
                else
                   EdNit.SetFocus;
               end;
            end;
         end;
end;

procedure TfrmComprobanteC.EdTasaEnter(Sender: TObject);
begin
        EdTasa.SelectAll;
end;

procedure TfrmComprobanteC.EdTasaKeyPress(Sender: TObject; var Key: Char);
begin
       Numerico(sender,key);
       if key = #13 then
        begin
        if EdTasa.Text <> '' then
          begin
            tasa := strtofloat(EdTasa.Text);
            EdTasa.Text := formatfloat('#,##0.00',tasa);
            eddebito.SetFocus
          end;
         end;
end;

procedure TfrmComprobanteC.EdMontoEnter(Sender: TObject);
begin
        EdMonto.SelectAll;
end;

procedure TfrmComprobanteC.EdMontoKeyPress(Sender: TObject; var Key: Char);
begin
       Numerico(sender,key);
       if key = #13 then
        begin
        if EdMonto.Text <> '' then
          begin
            monto := strtocurr(EdMonto.Text);
            EdMonto.Text := formatcurr('#,##0.00',monto);
            if EdTasa.Visible then
             EdTasa.SetFocus
            else
             eddebito.SetFocus
          end;
         end;
end;

function TfrmComprobanteC.Evaluarinforme(id : string) : string;
var
pidoid, pidotasa, pidotipoid, pidomonto: boolean;
begin
        with dmcomprobante.IBQuery1 do
        begin
         sql.Clear;
         Sql.Add('select "PIDOID", "PIDOMONTO", "PIDOTASA", "PIDOTIPOID" from "con$informes" where "con$informes"."ID" =:"ID"');
         parambyname('ID').AsString := id;
         active := true;
         pidoid := inttoboolean(fieldbyname('PIDOID').AsInteger);
         pidotasa:= inttoboolean(fieldbyname('PIDOTASA').AsInteger);
         pidotipoid:= inttoboolean(fieldbyname('PIDOTIPOID').AsInteger);
         pidomonto:= inttoboolean(fieldbyname('PIDOMONTO').AsInteger);
         if pidotipoid then begin
          GrupoInforme.Enabled := True;
          IBQTiposIdentificacion.Open;
          IBQTiposIdentificacion.Last;
          Edtipoid.Enabled := True;
          Edtipoid.SetFocus;
         end;
         if pidoid then begin
          GrupoInforme.Enabled := True;
          EdNit.Enabled := true;
         end;
         if pidotasa then begin
          GrupoInforme.Enabled := True;
          EdTasa.Enabled := true;
//          EdTasa.SetFocus;
         end;
         if pidomonto then begin
          GrupoInforme.Enabled := True;
          EdMonto.Enabled := True;
//          EdMonto.SetFocus;
         end;
        id := '';
        end;
end;

function TfrmComprobanteC.gettipoide : integer;
begin
        result:= vtipoid;
end;

procedure TfrmComprobanteC.settipoide (nvalor:integer);
begin
        vtipoid:= nvalor;
        Edtipoid.KeyValue := vtipoid;
end;
function TfrmComprobanteC.getmonto : currency;
begin
        result:= vmonto;
end;

procedure TfrmComprobanteC.setmonto (nvalor:currency);
begin
        vmonto:= nvalor;
        EdMonto.Text := formatcurr('#,##0.00',vmonto);
end;

function TfrmComprobanteC.gettasa : single;
begin
        result:= vtasa;
end;

procedure TfrmComprobanteC.settasa (nvalor:single);
begin
        vtasa:= nvalor;
        EdTasa.Text := Floattostr(vtasa);
end;

function TfrmComprobanteC.getcodigo  : string;
begin
    result:= vcodigo;
end;

procedure TfrmComprobanteC.setcodigo (nvalor:string);
begin
    vcodigo:= nvalor;
    editcodigo.Text := vcodigo;
end;

function TfrmComprobanteC.Getdebito : currency;
begin
    result := vdebito;
end;

procedure TfrmComprobanteC.Setdebito(nvalor:currency);
begin
        vdebito := nValor;
        EdDebito.Value := vdebito;
end;

function TfrmComprobanteC.Getcredito :currency;
begin
        result:= vcredito;
end;

procedure TfrmComprobanteC.Setcredito(nvalor:currency);
begin
        vcredito := nvalor;
        EdCredito.Value := vcredito;
end;

function TfrmComprobanteC.getidpersona : string;
begin
        result:= vid_persona;
end;

procedure TfrmComprobanteC.setidpersona (nvalor:string);
begin
        vid_persona := nvalor;
        EdNit.Text := vid_persona;
end;

function TfrmComprobanteC.getestado : string;
begin
        result := vestado;
end;

procedure TfrmComprobanteC.setestado(nvalor:string);
begin
        vestado:= 'O';
end;

function TfrmComprobanteC.getnomcuenta : string;
begin
        result := vnomcuenta;
end;

procedure TfrmComprobanteC.setnomcuenta (nvalor: string);
begin
        vnomcuenta := nvalor;
        label5.Caption := vnomcuenta;
end;

procedure TfrmComprobanteC.EdDebitoKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmComprobanteC.EdCreditoKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmComprobanteC.prReport1InitDetailBandDataSet(Sender: TObject;
  DetailBand: TprBand; DataSet: TObject; const DataSetName: String);
begin
        if DataSetName = 'IBAuxiliar1' then begin
          with IBAuxiliar1 do begin
            Close;
            ParamByName('ID_IDENTIFICACION').AsInteger := IBAuxiliar.FieldByName('ID_IDENTIFICACION').AsInteger;
            ParamByName('ID_PERSONA').AsString := IBAuxiliar.FieldByName('ID_PERSONA').AsString;
            try
             Open;
            except
             raise;
            end;
          end;
        end;
end;

procedure TfrmComprobanteC.prReport1PrintComplete(Sender: TObject);
begin
      vimpreso := true;
      with Dmcomprobante.IBQuery2 do
       begin
         Close;
         sql.Clear;
         sql.Add('update "con$comprobante" set ');
         sql.Add('"con$comprobante"."IMPRESO" = :"IMPRESO"');
         sql.Add(' where ');
         sql.Add('"con$comprobante"."ID_COMPROBANTE" = :"ID_COMPROBANTE" and');
         sql.Add('"con$comprobante"."ID_AGENCIA" = :"ID_AGENCIA"');

         ParamByName('ID_COMPROBANTE').AsString:= vid_comprobante;
         ParamByName('ID_AGENCIA').AsInteger := Agencia;
         ParamByName('IMPRESO').AsInteger  := ord(vimpreso);
         ExecSQL;
         Transaction.Commit;
       end;
end;

procedure TfrmComprobanteC.dblcbtipoKeyPress(Sender: TObject;
  var Key: Char);
begin
       EnterTabs(Key,Self);
end;

procedure TfrmComprobanteC.dblcbtipoEnter(Sender: TObject);
begin
        dblcbtipo.DropDown;
end;

end.
