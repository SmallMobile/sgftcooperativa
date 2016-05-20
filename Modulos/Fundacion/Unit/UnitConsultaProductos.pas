unit UnitConsultaProductos;

interface

uses
  Windows, Messages, Clipbrd, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  JvComponent,JvSplit, ExtCtrls, ComCtrls, JvComCtrls, StdCtrls,
  JvGroupBox, DBCtrls, JvStaticText, JvEdit, JvTypedEdit, JvFloatEdit,
  IBSQL, DB, IBCustomDataSet, Buttons, ImgList, Grids, DBGrids, JvDBCtrl,
  IBQuery, JvEnterTab,DateUtils, XStringGrid, JvLabel, JvBlinkingLabel,
  dbcgrids, Menus, IBDatabase, ADODB,sdXmlDocuments, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient,Jpeg;

type
  TfrmConsultaProductos = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PanelTree: TPanel;
    splitter: TJvxSplitter;
    PanelDatos: TPanel;
    PageControl: TJvPageControl;
    Hoja1: TTabSheet;
    Hoja2: TTabSheet;
    Hoja3: TTabSheet;
    Hoja4: TTabSheet;
    Hoja5: TTabSheet;
    JvGroupBox1: TJvGroupBox;
    PageBuscar: TJvPageControl;
    Tab1: TTabSheet;
    EdNombre: TJvStaticText;
    Tab2: TTabSheet;
    Tab3: TTabSheet;
    Label1: TLabel;
    CBtiposid: TDBLookupComboBox;
    Label2: TLabel;
    EdNumeroIdentificacion: TMemo;
    Label18: TLabel;
    EdColocacion: TJvEdit;
    EdCaptacion: TJvEdit;
    Label3: TLabel;
    Label4: TLabel;
    CBTiposCaptacion: TDBLookupComboBox;
    DSTiposCaptacion: TDataSource;
    IBDSTiposCaptacion: TIBDataSet;
    IBDSTiposId: TIBDataSet;
    DSTiposId: TDataSource;
    Panel3: TPanel;
    Panel4: TPanel;
    CmdCerrar: TBitBtn;
    CmdOtro: TBitBtn;
    ImageTree: TImageList;
    IBSaldosMes: TIBQuery;
    DSSaldosMes: TDataSource;
    PageControlCaptacion: TJvPageControl;
    TabAlaVista: TTabSheet;
    Panel7: TPanel;
    Label14: TLabel;
    EdEstadoCaptacion: TJvStaticText;
    Panel8: TPanel;
    TabContractual: TTabSheet;
    TabCertificados: TTabSheet;
    Label16: TLabel;
    PageControl1: TPageControl;
    TabAportes: TTabSheet;
    Panel5: TPanel;
    Panel6: TPanel;
    Label11: TLabel;
    EdEstadoAporte: TJvStaticText;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Label15: TLabel;
    EdPlanContractual: TJvStaticText;
    Label17: TLabel;
    EdProximoAbonoContractual: TJvStaticText;
    Label19: TLabel;
    EdCuotaContractual: TJvStaticText;
    Label20: TLabel;
    EdEstadoContractual: TJvStaticText;
    Panel13: TPanel;
    Panel14: TPanel;
    Label21: TLabel;
    EdFechaAperturaCaptacion: TJvStaticText;
    Label22: TLabel;
    EdFechaAperturaContractual: TJvStaticText;
    IBTablaLiquidacion: TIBQuery;
    DSTablaLiquidacion: TDataSource;
    Label23: TLabel;
    EdFechaAperturaCertificado: TJvStaticText;
    Label24: TLabel;
    EdPlazoCertificado: TJvStaticText;
    Label25: TLabel;
    EdTasaCertificado: TJvStaticText;
    Label26: TLabel;
    EdAmortizaCertificado: TJvStaticText;
    Label27: TLabel;
    EdTipoTasaCertificado: TJvStaticText;
    Label28: TLabel;
    EdFechaVencimientoCertificado: TJvStaticText;
    Label29: TLabel;
    EdFechaUltimoPagoCertificado: TJvStaticText;
    Label30: TLabel;
    EdEstadoCertificado: TJvStaticText;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Label31: TLabel;
    EdClasificacion: TJvStaticText;
    Label32: TLabel;
    EdCategoria: TJvStaticText;
    Label33: TLabel;
    EdEvaluacion: TJvStaticText;
    Label34: TLabel;
    EdLinea: TJvStaticText;
    EdInversion: TJvStaticText;
    Label35: TLabel;
    Label36: TLabel;
    EdTipoInteres: TJvStaticText;
    Label37: TLabel;
    EdTasaE: TJvStaticText;
    EdInteresVariable: TJvStaticText;
    Label38: TLabel;
    EdPlazoColocacion: TJvStaticText;
    Label39: TLabel;
    EdAmortizaK: TJvStaticText;
    Label40: TLabel;
    EdAmortizaI: TJvStaticText;
    Label43: TLabel;
    EdProxPagoColocacion: TJvStaticText;
    Label44: TLabel;
    EdDiasMora: TJvStaticText;
    IBTablaLiquidacionColocacion: TIBQuery;
    DSTablaLiquidacionColocacion: TDataSource;
    Panel18: TPanel;
    Panel19: TPanel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    EdClasificacionF: TJvStaticText;
    EdCategoriaF: TJvStaticText;
    EdEvaluacionF: TJvStaticText;
    EdLineaF: TJvStaticText;
    EdInversionF: TJvStaticText;
    EdTipoInteresF: TJvStaticText;
    EdTasaEF: TJvStaticText;
    EdInteresVariableF: TJvStaticText;
    EdPlazoColocacionF: TJvStaticText;
    EdAmortizaKF: TJvStaticText;
    EdAmortizaIF: TJvStaticText;
    EdFechaCapitalF: TJvStaticText;
    EdFechaInteresF: TJvStaticText;
    EdProxPagoColocacionF: TJvStaticText;
    Panel20: TPanel;
    Label61: TLabel;
    EdDeudorF: TJvStaticText;
    DSObservaciones: TDataSource;
    EnterAsTab: TJvEnterAsTab;
    CmdActualizar1: TBitBtn;
    CmdActualizar2: TBitBtn;
    CmdActualizar3: TBitBtn;
    IBObservaciones: TIBQuery;
    IBFormas: TIBQuery;
    IBConsulta2: TIBQuery;
    IBColocaciones: TIBQuery;
    IBConsulta: TIBQuery;
    IBFianzas: TIBQuery;
    IBPersona: TIBQuery;
    IBCaptaciones: TIBQuery;
    IBConsulta1: TIBQuery;
    Hoja0: TTabSheet;
    HojaIni: TTabSheet;
    Panel21: TPanel;
    IBSQL: TIBSQL;
    IBSQL1: TIBSQL;
    IBTablaLiquidacionColocacionID_AGENCIA: TSmallintField;
    IBTablaLiquidacionColocacionID_COLOCACION: TIBStringField;
    IBTablaLiquidacionColocacionCUOTA_NUMERO: TIntegerField;
    IBTablaLiquidacionColocacionFECHA_A_PAGAR: TDateField;
    IBTablaLiquidacionColocacionCAPITAL_A_PAGAR: TIBBCDField;
    IBTablaLiquidacionColocacionINTERES_A_PAGAR: TIBBCDField;
    IBTablaLiquidacionColocacionPAGADA: TSmallintField;
    IBTablaLiquidacionColocacionFECHA_PAGADA: TDateField;
    cmdBuscar: TJvBlinkingLabel;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    PanelPersona: TPanel;
    Label63: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label62: TLabel;
    Label64: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    EdEstudio: TCheckBox;
    EdTipoPersona: TJvStaticText;
    EdEstadoCivil: TJvStaticText;
    EdSexo: TJvStaticText;
    EdFechaNacimiento: TJvStaticText;
    EdLugarNacimiento: TJvStaticText;
    EdTipoAfiliacion: TJvStaticText;
    EdFechaAfiliacion: TJvStaticText;
    GroupBox4: TGroupBox;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    EdRetefuente: TCheckBox;
    EdProfesion: TJvStaticText;
    EdEmpresa: TJvStaticText;
    EdCargo: TJvStaticText;
    EdFechaIngreso: TJvStaticText;
    EdTotalActivos: TJvStaticText;
    EdTotalPasivos: TJvStaticText;
    TabSheet2: TTabSheet;
    DSPersona: TDataSource;
    IBSQL2: TIBSQL;
    Label79: TLabel;
    IBDeudaHoy: TIBSQL;
    CBOtrosTitulares: TComboBox;
    Label80: TLabel;
    EdFechaProrrogaCer: TJvStaticText;
    Label81: TLabel;
    EdFechaVProrrogaCer: TJvStaticText;
    PopMCaptaciones: TPopupMenu;
    Ir1: TMenuItem;
    N1: TMenuItem;
    ConsultadeExtracto1: TMenuItem;
    CambiosdeEstado1: TMenuItem;
    ImageCap: TImageList;
    GridObservaciones: TDBGrid;
    Memo: TMemo;
    PMenu1: TPopupMenu;
    IraObservaciones1: TMenuItem;
    IBObservacionesFECHA: TDateField;
    IBObservacionesOBSERVACION: TMemoField;
    IBObservacionesSEMAFORO: TIntegerField;
    IBObservacionesID_EMPLEADO: TIBStringField;
    HojaSolicitud: TTabSheet;
    IBllenaSolicitud: TIBQuery;
    DSllenaSolicitud: TDataSource;
    IBtranSolicitud: TIBTransaction;
    Label82: TLabel;
    Label83: TLabel;
    EdFechaAperturaApo: TJvStaticText;
    PMenu2: TPopupMenu;
    IrA1: TMenuItem;
    N2: TMenuItem;
    ExtractodeColocacin1: TMenuItem;
    PMenu3: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    GroupBox5: TGroupBox;
    Label84: TLabel;
    Label85: TLabel;
    EDempleado_act: TJvStaticText;
    EDfecha_act: TJvStaticText;
    IdTCPClient1: TIdTCPClient;
    N3: TMenuItem;
    ExpandirTodo1: TMenuItem;
    ContraerTodo1: TMenuItem;
    HojaTarjetaDebito: TTabSheet;
    Label86: TLabel;
    EdTarjetaDebito: TStaticText;
    Label87: TLabel;
    EdFechaAsignacion: TStaticText;
    Label88: TLabel;
    EdFechaBloqueo: TStaticText;
    Label89: TLabel;
    EdFechaCancelacion: TStaticText;
    GroupBox6: TGroupBox;
    Label90: TLabel;
    EdCupoATM: TStaticText;
    Label91: TLabel;
    EdCupoPOS: TStaticText;
    Label92: TLabel;
    Label93: TLabel;
    EdTransaATM: TStaticText;
    EdTransaPOS: TStaticText;
    Label94: TLabel;
    EdEstado: TStaticText;
    Arbol: TJvTreeView;
    JVSolicitud: TJvStaticText;
    JvGroupBox2: TJvGroupBox;
    JVempleadoRec: TJvStaticText;
    JVfechaRec: TJvStaticText;
    JvGroupBox3: TJvGroupBox;
    JVempleadoCre: TJvStaticText;
    JVfechaCre: TJvStaticText;
    JvGroupBox4: TJvGroupBox;
    JVempleadoAna: TJvStaticText;
    JVfechaAna: TJvStaticText;
    JvGroupBox5: TJvGroupBox;
    JvLabel7: TJvLabel;
    JvLabel8: TJvLabel;
    JvLabel9: TJvLabel;
    JvLabel10: TJvLabel;
    JvLabel11: TJvLabel;
    JvLabel12: TJvLabel;
    JvLabel13: TJvLabel;
    JvLabel14: TJvLabel;
    JVestado: TJvStaticText;
    JVlinea: TJvStaticText;
    JVrespaldo: TJvStaticText;
    JVgarantia: TJvStaticText;
    JVcuota: TJvStaticText;
    JVvalor: TJvStaticText;
    JVplazo: TJvStaticText;
    JVcapital: TJvStaticText;
    Label95: TLabel;
    JVinteres: TJvStaticText;
    Mobservacion: TMemo;
    Label96: TLabel;
    JvGroupBox6: TJvGroupBox;
    JVempleadoInf: TJvStaticText;
    JVfechaInf: TJvStaticText;
    Label99: TLabel;
    EdReciprocidadF: TJvStaticText;
    Label41: TLabel;
    EdFechaCapital: TJvStaticText;
    Label42: TLabel;
    EdFechaInteres: TJvStaticText;
    Label100: TLabel;
    EdReciprocidad: TJvStaticText;
    IBTransaction1: TIBTransaction;
    ImgFotoC: TImage;
    ImFirma: TImage;
    procedure FormShow(Sender: TObject);
    procedure EdCaptacionKeyPress(Sender: TObject; var Key: Char);
    procedure EdColocacionKeyPress(Sender: TObject; var Key: Char);
    procedure EdNumeroIdentificacionKeyPress(Sender: TObject;
      var Key: Char);
    procedure CmdOtroClick(Sender: TObject);
    procedure Tab1Show(Sender: TObject);
    procedure Tab2Show(Sender: TObject);
    procedure Tab3Show(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CmdActualizar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CmdBuscarClick(Sender: TObject);
    procedure ArbolChange(Sender: TObject; Node: TTreeNode);
    procedure CmdActualizar2Click(Sender: TObject);
    procedure EdCaptacionExit(Sender: TObject);
    procedure CmdActualizar3Click(Sender: TObject);
    procedure IBTablaLiquidacionColocacionPAGADAGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure CmdCerrarClick(Sender: TObject);
    procedure DBImage1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBImage3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridObservacionesDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure IBObservacionesOBSERVACIONGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure IBObservacionesID_EMPLEADOGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure IBObservacionesAfterScroll(DataSet: TDataSet);
    procedure IraObservaciones1Click(Sender: TObject);
    procedure IBObservacionesSEMAFOROGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExpandirTodo1Click(Sender: TObject);
    procedure ContraerTodo1Click(Sender: TObject);
    procedure splitterMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    vAno:string;
    vFechaInicial: Tdate;
    vFechaFinal: TDateTime;
    procedure AbrirIniciales;
    procedure BuscarProductos;
    procedure AgregarCaptaciones;
    procedure AgregarColocaciones;
    procedure AgregarFianzas;
    procedure AgregarObservaciones;
    procedure BuscarDatosAportes(tipo:Integer;agencia:Integer;cuenta:string);
    procedure BuscarDatosAhorro(tipo:Integer;agencia: integer; cuenta: string);
    procedure BuscarDatosAhorroC(tipo:Integer;agencia: integer; cuenta: string);
    procedure BuscarDatosColocacion(agencia: integer; cuenta: string);
    procedure BuscarDatosFianzas(agencia: integer; cuenta: string);
    procedure BuscarDatosCertificados(tipo:Integer;agencia: Integer;cuenta: string);
    procedure BuscarDatosObservaciones;
    procedure AgregarSolicitudes;
    procedure BuscarSolicitudes;
    procedure BuscaCredivida;
    procedure AgregarTarjetaDebito;
    procedure BuscarDatosTarjetaDebito(numero: string);
    procedure BuscarDatosSolicitud(vId_Solicitud: string;vPersona:Boolean);
    procedure AgregaCodeudor;
    { Private declarations }
  public
  id_identificacion_sol :integer;
  id_persona_sol :string;
    { Public declarations }
  end;

type
     TProductos = class
     private
     forma:Integer;
     nombre:string;
     tipo:Integer;
     numero:string;
     agencia:Integer;
     digito:Integer;
     estado:Integer;
     nivel:Integer;
end;

type
     TServicios = class
     private
     forma:Integer;
     nombre:string;
     tipo:Integer;
     numero:string;
     agencia:Integer;
     digito:Integer;
     estado:Integer;
     nivel:Integer;
end;


var
  frmConsultaProductos: TfrmConsultaProductos;

  vididentificacion:Integer;
  vidpersona:string;
  arbolinfo:TProductos;
  arbolsinfo:TServicios;
  Nodo : Array[0..10] of TTreeNode;
  NodoSe: Array[0..10] of TTreeNode;
  NodoOb: array[0..10] of TTreeNode;
  NodoSo: array[0..10] of TTreeNode;
  NodoOt: array[0..10] of TTreeNode;
  NodoAnt : Integer;
  vTotAportaciones:Currency;
  vTotCaptaciones:Currency;
  vTotColocaciones:Currency;
  vTotFianzas:Currency;

//  Hoja0
  vTipoPersona:string;
  vEstadoCivil:string;
  vSexo:string;
  vFechaNacimiento:TDate;
  vLugarNacimiento:string;
  vTipoAfiliacion:string;
  vFechaAfiliacion:TDate;
  vEducacion:Boolean;
  vProfesion:string;
  vEmpresa:string;
  vCargo:string;
  vFechaIngreso:TDate;
  vRetefuente:Boolean;
  vTotalActivos:Currency;
  vTotalPasivos:Currency;
// Hoja Aportes
  vSaldoIAporte:Currency;
  vSaldoAporte:Currency;
  vEstadoActual:string;
// Hoja Ahorro a la Vista
  vSaldoIAno:Currency;
  vSaldoActual:Currency;
  vEstadoCaptacion:string;
  vFechaApertura:TDate;
// Hoja Ahorro Contractual
  vPlanContractual:string;
  vProximoAbonoContractual:TDate;
  vCuotaContractual:Currency;
  vEstadoContractual:Currency;
  vFechaAperturaContractual:TDate;

// Hoja Certificados de Deposito

  vFechaAperturaCertificado:TDate;
  vPlazoCertificado:Integer;

  EstadoAct:Integer;
  EnLectura:Boolean;

  GridCap:Boolean;
  GridCol:Boolean;
  GridFia:Boolean;

  FilaCap:Integer;
  FilaCol:Integer;
  FilaFia:Integer;

implementation

{$R *.dfm}

uses unitdmGeneral,unitGlobales,
     unitBuscarPersona, unitGlobalesCol,
     unitDmColocacion,UnitConsultaExtractoCaptacion,UnitExtractoColocacion,
     unitObservacionesCambioEstado, UnitControlDeObservaciones, UnitExtractoCredito,UnitGuardaImagen;

procedure TfrmConsultaProductos.FormShow(Sender: TObject);
begin
        AbrirIniciales;
end;

procedure TfrmConsultaProductos.AbrirIniciales;
var I :Integer;
begin
        if IBDSTiposId.Transaction.InTransaction then
           IBDSTiposId.Transaction.Rollback;
        if dmGeneral.IBTransaction1.InTransaction then
           dmGeneral.IBTransaction1.Rollback;
        dmGeneral.IBTransaction1.StartTransaction;
        IBDSTiposId.Transaction.StartTransaction;
        IBDSTiposId.Open;
        IBDSTiposCaptacion.Open;
        PageBuscar.Enabled := True;
        PageBuscar.ActivePage := Tab1;
        CmdBuscar.Enabled := True;
        PageControl.ActivePage := HojaIni;
        CBTiposCaptacion.KeyValue := -1;
        EdNombre.Caption := '';
        EdCaptacion.Text := '';
        EdColocacion.Text := '';
        EDfecha_act.Caption := '';
        EDempleado_act.Caption := '';
        Arbol.Items.Clear;
        Arbol.Enabled := False;
        Nodo[0] := Arbol.Items.Add(nil,'Productos');
        NodoSe[0] := Arbol.Items.Add(nil,'Servicios');
        NodoOb[0] := Arbol.Items.Add(nil,'Observaciones');
        NodoSo[0] := Arbol.Items.Add(nil,'Solicitudes');
        NodoOt[0] := Arbol.Items.Add(nil,'Otros');
        Nodo[0].ImageIndex := 6;
        NodoSe[0].ImageIndex := 7;
        NodoOb[0].ImageIndex := 8;
        NodoSo[0].ImageIndex := 9;
        NodoOt[0].ImageIndex := 10;
{        if id_persona_sol <> '' then
        begin
           EdNumeroIdentificacion.Text :=id_persona_sol;
           CBTiposid.KeyValue := id_identificacion_sol;
           vidpersona := id_persona_sol;
           vididentificacion := id_identificacion_sol;
           CmdActualizar1Click(Self);
        end
        else
        begin
           EdNumeroIdentificacion.Text := '';
           CBTiposid.KeyValue := -1;
           CBtiposid.SetFocus;
        end;}
        vTotAportaciones:=0;
        vTotCaptaciones:=0;
        vTotColocaciones:=0;
        vTotFianzas:=0;

//GridRCaptaciones
        if id_persona_sol <> '' then
        begin
           EdNumeroIdentificacion.Text :=id_persona_sol;
           CBTiposid.KeyValue := id_identificacion_sol;
//           vidpersona := id_persona_sol;
//           vididentificacion := id_identificacion_sol;
           CmdActualizar1Click(Self);
        end
        else
        begin
           EdNumeroIdentificacion.Text := '';
           CBTiposid.KeyValue := -1;
           CBtiposid.SetFocus;
        end;


end;

procedure TfrmConsultaProductos.EdCaptacionKeyPress(Sender: TObject;
  var Key: Char);
begin
        NumericoSinPunto(Sender,Key);
end;

procedure TfrmConsultaProductos.EdColocacionKeyPress(Sender: TObject;
  var Key: Char);
begin
        NumericoSinPunto(Sender,Key);
end;

procedure TfrmConsultaProductos.EdNumeroIdentificacionKeyPress(
  Sender: TObject; var Key: Char);
begin
//        NumericoSinPunto(Sender,Key);
end;

procedure TfrmConsultaProductos.CmdOtroClick(Sender: TObject);
begin
        AbrirIniciales;
        ImgFotoC.Picture := nil;
        ImFirma.Picture := nil;
end;

procedure TfrmConsultaProductos.Tab1Show(Sender: TObject);
begin
        CBtiposid.SetFocus;
end;

procedure TfrmConsultaProductos.Tab2Show(Sender: TObject);
begin
        CBTiposCaptacion.SetFocus;
end;

procedure TfrmConsultaProductos.Tab3Show(Sender: TObject);
begin
        EdColocacion.SetFocus;
end;

procedure TfrmConsultaProductos.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Ord(Key) = VK_F2 then
                cmdBuscarClick(Sender)
        else
           EnterTabs(Key,Self);
end;

procedure TfrmConsultaProductos.CmdActualizar1Click(Sender: TObject);
begin
        PageBuscar.ActivePage := Tab1;
        vididentificacion := CBtiposid.KeyValue;
        vidpersona := EdNumeroIdentificacion.Text;
        Screen.Cursor := crHourGlass;
        buscarproductos;
        Screen.Cursor := crDefault;
end;

procedure TfrmConsultaProductos.BuscarProductos;
var     jpg :TJPEGImage;
        _sjpg : TMemoryStream;
        _iImagen :TGImagen;
        _rImagen :TImagen;
begin
        _iImagen := TGImagen.Create;
        if dmGeneral.IBTransaction1.InTransaction then
           dmGeneral.IBTransaction1.Rollback;
        dmGeneral.IBTransaction1.StartTransaction;

        with IBPersona do
        begin
            if Transaction.InTransaction then
              Transaction.Rollback;
            Transaction.StartTransaction;

            Close;
            ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
            ParamByName('ID_PERSONA').AsString := vidpersona;
            Open;
            if RecordCount < 1 then
            begin
               MessageDlg('Esa Persona no Existe!',mtWarning,[mbOK],0);
               if PageBuscar.ActivePage = Tab1 then
                  EdNumeroIdentificacion.SetFocus
               else
               if PageBuscar.ActivePage = Tab2 then
                  EdCaptacion.SetFocus
               else
               if PageBuscar.ActivePage = Tab3 then
                  EdColocacion.SetFocus;
               exit;
            end;
            EdNombre.Caption := FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                FieldByName('NOMBRE').AsString;
            _rimagen := _iImagen.ConsultaImagen(vididentificacion,vidpersona);
            if _rImagen.Foto.Size > 0 then
            begin
              jpg := TJpegImage.Create;
              jpg.LoadFromStream(_rImagen.Foto);
              ImgFotoC.Picture.Bitmap.Assign(jpg);
              ImgFotoC.Repaint;
              FreeAndNil(jpg);
            end;
            if _rImagen.Firma.Size > 0 then
            begin
              jpg := TJpegImage.Create;
              jpg.LoadFromStream(_rImagen.Firma);
              ImFirma.Picture.Bitmap.Assign(jpg);
              ImFirma.Repaint;
              FreeAndNil(jpg);
            end;
            FreeAndNil(_rImagen);
        end;

        PageBuscar.Enabled := False;
        CmdBuscar.Enabled := False;
// Coloco datos de la persona
        with IBSQL do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select DESCRIPCION_PERSONA from "gen$tipospersona" where ');
          SQL.Add('ID_TIPO_PERSONA = :"ID_TIPO_PERSONA"');
          ParamByName('ID_TIPO_PERSONA').AsInteger := IBPersona.FieldByName('ID_TIPO_PERSONA').AsInteger;
          ExecQuery;
          EdTipoPersona.Caption  := FieldByName('DESCRIPCION_PERSONA').AsString;
          Close;
        end;

        with IBSQL do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select DESCRIPCION_ESTADO_CIVIL from "gen$tiposestadocivil" where ');
          SQL.Add('ID_TIPO_ESTADO_CIVIL = :"ID"');
          ParamByName('ID').AsInteger := IBPersona.FieldByName('ID_TIPO_ESTADO_CIVIL').AsInteger;
          ExecQuery;
          EdEstadoCivil.Caption := FieldByName('DESCRIPCION_ESTADO_CIVIL').AsString;
          Close;
        end;

        if IBPersona.FieldByName('SEXO').AsString = 'M' then
          EdSexo.Caption := 'MASCULINO'
        else
        if IBPersona.FieldByName('SEXO').AsString = 'F' Then
          EdSexo.Caption := 'FEMENINO'
        else
          EdSexo.Caption := '';

        EdFechaNacimiento.Caption := DateToStr(IBPersona.FieldByName('FECHA_NACIMIENTO').AsDateTime);
        EdLugarNacimiento.Caption := IBPersona.FieldByName('LUGAR_NACIMIENTO').AsString;
        if IBPersona.FieldByName('FECHA_ACTUALIZACION').IsNull = False then // fecha de actulizaciion
           EDfecha_act.Caption := FormatDateTime('yyyy/mm/dd',IBPersona.FieldByName('FECHA_ACTUALIZACION').AsDateTime);
        with IBSQL do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select DESCRIPCION_RELACION from "gen$tiposrelacion" where ');
          SQL.Add('ID_TIPO_RELACION = :"ID"');
          ParamByName('ID').AsInteger := IBPersona.FieldByName('ID_TIPO_RELACION').AsInteger;
          ExecQuery;
          EdTipoAfiliacion.Caption := FieldByName('DESCRIPCION_RELACION').AsString;
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"gen$empleado".NOMBRE,');
          SQL.Add('"gen$empleado".SEGUNDO_APELLIDO,');
          SQL.Add('"gen$empleado".PRIMER_APELLIDO');
          SQL.Add('FROM');
          SQL.Add('"gen$empleado"');
          SQL.Add('WHERE');
          SQL.Add('("gen$empleado".ID_EMPLEADO = :DBALIAS)');
          ParamByName('DBALIAS').AsString := IBPersona.FieldByName('ID_EMPLEADO').AsString;
          ExecQuery;
          EDempleado_act.Caption := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
        end;

//        EdFechaAfiliacion.Caption := DateToStr(IBPersona.FieldByName('FECHA_REGISTRO').AsDateTime);
        EdEstudio.Checked := InttoBoolean(IBPersona.FieldByName('EDUCACION').AsInteger);

        EdProfesion.Caption := IBPersona.FieldByName('PROFESION').AsString;
        EdEmpresa.Caption := IBPersona.FieldByName('EMPRESA_LABORA').AsString;
        EdCargo.Caption := IBPersona.FieldByName('CARGO_ACTUAL').AsString;
        EdFechaIngreso.Caption := DateToStr(IBPersona.FieldByName('FECHA_INGRESO_EMPRESA').AsDateTime);
        EdRetefuente.Checked := InttoBoolean(IBPersona.FieldByName('RETEFUENTE').AsInteger);
        EdTotalActivos.Caption := FormatCurr('$0,0.00',IBPersona.FieldByName('TOTAL_ACTIVOS').AsCurrency);
        EdTotalPasivos.Caption := FormatCurr('$0,0.00',IBPersona.FieldByName('TOTAL_PASIVOS').AsCurrency);

        Application.ProcessMessages;
        GridCap := False;
        GridCol := False;
        GridFia := False;

        EnLectura := True;
        EnLectura := False;

        with IBCaptaciones do
        begin
            Close;
            ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
            ParamByName('ID_PERSONA').AsString := vidpersona;
            Open;
            if RecordCount > 0 then
            begin
               AgregarCaptaciones;
               AgregarTarjetaDebito;
            end;
        end;
//Buscar Colocaciones
        Application.ProcessMessages;
        with IBColocaciones do
        begin
            Close;
            ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
            ParamByName('ID_PERSONA').AsString := vidpersona;
            Open;
            if RecordCount > 0 then
               AgregarColocaciones;
        end;
//Buscar Fianzas
        Application.ProcessMessages;
        with IBFianzas do
        begin
            Close;
            ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
            ParamByName('ID_PERSONA').AsString := vidpersona;
            Open;
            if RecordCount > 0 then
               AgregarFianzas;
        end;
//Buscar Observaciones
        Application.ProcessMessages;
        with IBObservaciones do
        begin
            Close;
            ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
            ParamByName('ID_PERSONA').AsString := vidpersona;
            Open;
            if RecordCount > 0 then
               AgregarObservaciones;
        end;
        agregarsolicitudes;
        AgregaCodeudor;//agrega solicitudes posible codeudor
        if Role = 'CAPTACIONES' then // ojo cambiar la validacion de la oficina
           BuscaCredivida;
        Arbol.Enabled := True;
//        Arbol.Items[0].Selected := True;
        PageControl.ActivePage := Hoja0;
end;

procedure TfrmConsultaProductos.AgregarCaptaciones;
begin
// Cargar formas de captacion que tiene el asociado
        with IBConsulta do
        begin
           SQL.Clear;
           SQL.Add('select DISTINCT "cap$tiposforma".ID_FORMA,"cap$tiposforma".DESCRIPCION,"cap$tiposforma".APORTE,');
           SQL.Add('"cap$tiposforma".AHORRO,"cap$tiposforma".CERTIFICADO,"cap$tiposforma".PROGRAMADO ');
           SQL.Add('FROM "cap$maestrotitular" INNER JOIN "cap$tipocaptacion" ON ("cap$maestrotitular".ID_TIPO_CAPTACION = "cap$tipocaptacion".ID_TIPO_CAPTACION) ');
           SQL.Add('INNER JOIN "cap$tiposforma" ON ("cap$tipocaptacion".ID_FORMA = "cap$tiposforma".ID_FORMA) ');
           SQL.Add('WHERE (ID_IDENTIFICACION = :"ID_IDENTIFICACION" AND ID_PERSONA = :"ID_PERSONA") ');
           ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
           ParamByName('ID_PERSONA').AsString := vidpersona;
           Open;
           Last;
           First;
           if RecordCount > 0 then
           while not IBConsulta.Eof do
           begin
                arbolinfo := TProductos.Create;
                arbolinfo.forma := 0; //FieldByName('ID_FORMA').AsInteger;
                arbolinfo.nombre := FieldByName('DESCRIPCION').AsString;
                arbolinfo.tipo := 0;
                arbolinfo.numero := '';
                arbolinfo.agencia := Agencia;
                arbolinfo.digito := 0;
                arbolinfo.nivel := 1;
                Nodo[1] := Arbol.Items.AddChildObject(Nodo[0],FieldByName('DESCRIPCION').AsString,arbolinfo);
                Nodo[1].ImageIndex := 1;
// Cargo Tipo Captaciones x cada forma
                   IBConsulta1.Close;
                   IBConsulta1.ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
                   IBConsulta1.ParamByName('ID_PERSONA').AsString := vidpersona;
                   IBConsulta1.ParamByName('ID_FORMA').AsInteger := IBConsulta.FieldByName('ID_FORMA').AsInteger;
                   IBConsulta1.Open;
                   IBConsulta1.Last;
                   IBConsulta1.First;
                   while not IBConsulta1.Eof do
                   begin
                        arbolinfo := TProductos.Create;
                        arbolinfo.forma := 0; //FieldByName('ID_FORMA').AsInteger;
                        arbolinfo.nombre := FieldByName('DESCRIPCION').AsString;
                        arbolinfo.tipo := 0;
                        arbolinfo.numero := '';
                        arbolinfo.agencia := Agencia;
                        arbolinfo.digito := 0;
                        arbolinfo.nivel := 2;
                        Nodo[2] := Arbol.Items.AddChildObject(Nodo[1],IBConsulta1.FieldByName('DESCRIPCION').AsString,arbolinfo);
                        Nodo[2].ImageIndex := 2;
// Cargar Cada captacion seg�n su tipo y su forma;
                        IBConsulta2.Close;
                        IBConsulta2.ParamByName('ID_FORMA').AsInteger := FieldByName('ID_FORMA').AsInteger;
                        IBConsulta2.ParamByName('ID_TIPO_CAPTACION').AsInteger := IBConsulta1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                        IBConsulta2.ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
                        IBConsulta2.ParamByName('ID_PERSONA').AsString := vidpersona;
                        IBConsulta2.Open;
                        IBConsulta2.Last;
                        IBConsulta2.First;
                        while not IBConsulta2.Eof do
                        begin
                                arbolinfo := TProductos.Create;
                                arbolinfo.forma := FieldByName('ID_FORMA').AsInteger;
                                arbolinfo.nombre := IBConsulta1.FieldByName('DESCRIPCION').AsString;
                                arbolinfo.tipo := IBConsulta1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                                arbolinfo.numero := Format('%.7d',[IBConsulta2.FieldByName('NUMERO_CUENTA').AsInteger]);
                                arbolinfo.agencia := IBConsulta2.FieldByName('ID_AGENCIA').AsInteger;
                                arbolinfo.digito := IBConsulta2.FieldByName('DIGITO_CUENTA').AsInteger;
                                arbolinfo.nivel := 3;
                                Nodo[3] := Arbol.Items.AddChildObject(Nodo[2],FormatCurr('00',arbolinfo.agencia)+ '-' + arbolinfo.numero + '-' + FormatCurr('0',arbolinfo.digito)+' '+IBConsulta2.FieldByName('ESTADO').AsString,arbolinfo);
                                Nodo[3].ImageIndex := 3;
                                IBConsulta2.Next;
                        end;
//fin Carga 2
                        IBConsulta1.Next;
                   end;
//fin Carga 1
                Next;
           end;
        end;
end;

procedure TfrmConsultaProductos.AgregarColocaciones;
var Descripcion:string;
begin
        with IBConsulta do
        begin
             Close;
             SQL.Clear;
             SQL.Add('select ID_AGENCIA,ID_COLOCACION,"col$colocacion".ID_ESTADO_COLOCACION,DESCRIPCION_ESTADO_COLOCACION from "col$colocacion" ');
             SQL.Add('LEFT JOIN "col$estado" ON "col$estado".ID_ESTADO_COLOCACION = "col$colocacion".ID_ESTADO_COLOCACION ');
             SQL.Add(' where ');
             SQL.Add('ID_IDENTIFICACION = :"ID_IDENTIFICACION" and ID_PERSONA = :"ID_PERSONA" and');
             SQL.Add('"col$colocacion".ID_ESTADO_COLOCACION <> 4 and "col$colocacion".ID_ESTADO_COLOCACION <> 5');
             ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
             ParamByName('ID_PERSONA').AsString := vidpersona;
             Open;
             Last;
             First;
             if RecordCount > 0 then
             begin
                arbolinfo := TProductos.Create;
                arbolinfo.forma := 0;
                arbolinfo.nombre := 'COLOCACIONES';
                arbolinfo.tipo := 0;
                arbolinfo.numero := '';
                arbolinfo.agencia := Agencia;
                arbolinfo.digito := 0;
                arbolinfo.nivel := 1;
                Nodo[1] := Arbol.Items.AddChildObject(Nodo[0],arbolinfo.nombre,arbolinfo);
                Nodo[1].ImageIndex := 1;
                while not Eof do
                begin
                        arbolinfo := TProductos.Create;
                        arbolinfo.forma := 5;
                        arbolinfo.nombre := 'COLOCACIONES';
                        arbolinfo.tipo := 0;
                        arbolinfo.numero := FieldByName('ID_COLOCACION').AsString;
                        arbolinfo.agencia := FieldByName('ID_AGENCIA').AsInteger;
                        Descripcion := FieldByName('DESCRIPCION_ESTADO_COLOCACION').AsString;
                        arbolinfo.estado := FieldByName('ID_ESTADO_COLOCACION').AsInteger;
                        arbolinfo.digito := 0;
                        arbolinfo.nivel := 2;
                        Nodo[2] := Arbol.Items.AddChildObject(Nodo[1],FormatCurr('00',arbolinfo.agencia) + '-' + arbolinfo.numero + ' ' + Descripcion,arbolinfo);
                        Nodo[2].ImageIndex := 4;
                        Next;
                end;
             end;
        end;
end;

procedure TfrmConsultaProductos.AgregarFianzas;
var Descripcion:string;
begin
        with IBConsulta do
        begin
             Close;
             SQL.Clear;
             SQL.Add('select "col$colgarantias".ID_AGENCIA,"col$colgarantias".ID_COLOCACION from "col$colgarantias"');
             SQL.Add('inner join "col$colocacion" on ("col$colgarantias".ID_AGENCIA = "col$colocacion".ID_AGENCIA and "col$colgarantias".ID_COLOCACION = "col$colocacion".ID_COLOCACION)');
             SQL.Add('where "col$colgarantias".ID_IDENTIFICACION = :"ID_IDENTIFICACION" and "col$colgarantias".ID_PERSONA = :"ID_PERSONA" and');
             SQL.Add('("col$colocacion".ID_ESTADO_COLOCACION <> 4 and "col$colocacion".ID_ESTADO_COLOCACION <> 5)');
             ParamByName('ID_PERSONA').Asstring := vidpersona;
             ParamByName('ID_IDENTIFICACION').Asinteger := vididentificacion;
             Open;
             Last;
             First;
             if RecordCount > 0 then
             begin
                arbolinfo := TProductos.Create;
                arbolinfo.forma := 0;
                arbolinfo.nombre := 'FIANZAS';
                arbolinfo.tipo := 0;
                arbolinfo.numero := '';
                arbolinfo.agencia := Agencia;
                arbolinfo.digito := 0;
                arbolinfo.nivel := 1;
                Nodo[1] := Arbol.Items.AddChildObject(Nodo[0],arbolinfo.nombre,arbolinfo);
                Nodo[1].ImageIndex := 1;
                while not Eof do
                begin
                        arbolinfo := TProductos.Create;
                        arbolinfo.forma := 6;
                        arbolinfo.nombre := 'FIANZAS';
                        arbolinfo.tipo := 0;
                        arbolinfo.numero := FieldByName('ID_COLOCACION').AsString;
                        arbolinfo.agencia := FieldByName('ID_AGENCIA').AsInteger;
                        arbolinfo.digito := 0;
                        IBSQL1.Close;
                        IBSQL1.SQL.Clear;
                        IBSQL1.SQL.Add('select ID_AGENCIA,ID_COLOCACION,"col$colocacion".ID_ESTADO_COLOCACION,DESCRIPCION_ESTADO_COLOCACION from "col$colocacion" ');
                        IBSQL1.SQL.Add('LEFT JOIN "col$estado" ON "col$estado".ID_ESTADO_COLOCACION = "col$colocacion".ID_ESTADO_COLOCACION ');
                        IBSQL1.SQL.Add(' where ');
                        IBSQL1.SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_COLOCACION = :"ID_COLOCACION"');
                        IBSQL1.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
                        IBSQL1.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                        IBSQL1.ExecQuery;
                        Descripcion := IBSQL1.FieldByName('DESCRIPCION_ESTADO_COLOCACION').AsString;
                        IBSQL1.Close;
                        arbolinfo.nivel := 2;
                        Nodo[2] := Arbol.Items.AddChildObject(Nodo[1],FormatCurr('00',arbolinfo.agencia) + '-' + arbolinfo.numero + ' ' + Descripcion,arbolinfo);
                        Nodo[2].ImageIndex := 4;
                        Next;
                end;
             end;
        end;
end;

procedure TfrmConsultaProductos.AgregarObservaciones;
begin
        with IBConsulta do
        begin
             Close;
             SQL.Clear;
             SQL.Add('select FECHA,OBSERVACION,ID_EMPLEADO from "gen$observaciones" where ');
             SQL.Add('ID_IDENTIFICACION = :"ID_IDENTIFICACION" and ID_PERSONA = :"ID_PERSONA"');
             ParamByName('ID_PERSONA').Asstring := vidpersona;
             ParamByName('ID_IDENTIFICACION').Asinteger := vididentificacion;
             Open;
             Last;
             First;
             if RecordCount > 0 then
             begin
                arbolinfo := TProductos.Create;
                arbolinfo.forma := 7;
                arbolinfo.nombre := 'GENERALES';
                arbolinfo.tipo := 0;
                arbolinfo.numero := '';
                arbolinfo.agencia := Agencia;
                arbolinfo.digito := 0;
                arbolinfo.nivel := 1;
                NodoOb[0] := Arbol.Items.AddChildObject(NodoOb[0],arbolinfo.nombre,arbolinfo);
                NodoOb[0].ImageIndex := 1;
             end;
             Close;
        end;
end;

procedure TfrmConsultaProductos.FormCreate(Sender: TObject);
begin
        vAno := IntToStr(YearOf(fFechaActual));
        vFechaInicial := EncodeDate(YearOf(Date),01,01);
        vFechaFinal := fFechaActual + StrToTime('23:59:59');
        Hoja0.TabVisible := False;
        Hoja1.TabVisible := False;
        Hoja2.TabVisible := False;
        Hoja3.TabVisible := False;
        Hoja4.TabVisible := False;
        Hoja5.TabVisible := False;
        HojaIni.TabVisible := False;
        HojaSolicitud.TabVisible := False;
        HojaTarjetaDebito.TabVisible := False;
        DmColocacion := TDmColocacion.Create(Self);
end;

procedure TfrmConsultaProductos.CmdBuscarClick(Sender: TObject);
var frmBuscarPersona:TfrmBuscarPersona;
begin
                frmBuscarPersona := TfrmBuscarPersona.Create(self);
                if frmBuscarPersona.ShowModal = mrOk then
                begin
                   vididentificacion := frmBuscarPersona.id_identificacion;
                   vidpersona := frmBuscarPersona.id_persona;
                   EdNumeroIdentificacion.Text := vidpersona;
                   CBtiposid.KeyValue := vididentificacion;
                   PageBuscar.ActivePage := Tab1;
                   CmdActualizar1.Click;
                end;
                frmBuscarPersona.Free;
end;

procedure TfrmConsultaProductos.ArbolChange(Sender: TObject;
  Node: TTreeNode);
begin
        if Node.Data <> nil then
        begin
           case TProductos(Node.Data).forma of
               0: PageControl.ActivePage := Hoja0;
               1: begin
                     PageControl.ActivePage := Hoja1;
                     BuscarDatosAportes(TProductos(Node.Data).tipo,TProductos(Node.Data).agencia,TProductos(Node.Data).numero);
                  end;
               2..4:begin
                      PageControl.ActivePage := Hoja2;
                      TabAlaVista.TabVisible := False;
                      TabContractual.TabVisible := False;
                      TabCertificados.TabVisible := False;
                      case TProductos(Node.Data).tipo of
                        2..4: begin
                                BuscarDatosAhorro(TProductos(Node.Data).tipo,tproductos(Node.Data).agencia,TProductos(Node.Data).numero);
                                PageControlCaptacion.ActivePage := TabAlaVista;
                              end;
                        5: begin
                              BuscarDatosAhorroC(TProductos(Node.Data).tipo,tproductos(Node.Data).agencia,TProductos(Node.Data).numero);
                              PageControlCaptacion.ActivePage := TabContractual;
                           end;
                        6: begin
                             BuscarDatosCertificados(TProductos(Node.Data).tipo,tproductos(Node.Data).agencia,TProductos(Node.Data).numero);
                             PageControlCaptacion.ActivePage := TabCertificados;
                           end;
                      end;
                    end;
               5: begin
                    BuscarDatosColocacion(TProductos(Node.Data).agencia,TProductos(Node.Data).numero);
                    PageControl.ActivePage := Hoja3;
                  end;
               6: begin
                    BuscarDatosFianzas(TProductos(Node.Data).agencia,TProductos(Node.Data).numero);
                    PageControl.ActivePage := Hoja4;
                  end;
               7: begin
                    BuscarDatosObservaciones;
                    PageControl.ActivePage := Hoja5;
                  end;
               8: begin
                    BuscarDatosSolicitud(TProductos(Node.Data).numero,False);
                    PageControl.ActivePage := HojaSolicitud;
                  end;
              10: begin
                    BuscarDatosTarjetaDebito(TProductos(Node.Data).numero);
                    PageControl.ActivePage := HojaTarjetaDebito;
                  end;
              11: begin
                    BuscarDatosSolicitud(TProductos(Node.Data).numero,True);
                    PageControl.ActivePage := HojaSolicitud;
                  end;
               else
                  PageControl.ActivePage := Hoja0;
           end;
        end
        else
                  PageControl.ActivePage := Hoja0;
end;

procedure TfrmConsultaProductos.BuscarDatosAportes(tipo:Integer;agencia:Integer;cuenta:string);
var digito:string;
    tmp:Integer;
    Inicial:Currency;
    Actual:Currency;
    i:Integer;
begin
        Inicial := 0;
        Actual := 0;
        digito := DigitoControl(tipo,cuenta);
        with IBSQL do
        begin
                Close;
                SQL.Clear;
                SQL.Add('select FECHA_APERTURA,ID_ESTADO from "cap$maestro" where ');
                SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" ');
                SQL.Add('and NUMERO_CUENTA = :"NUMERO_CUENTA" and DIGITO_CUENTA = :"DIGITO_CUENTA" ');
                ParamByName('ID_AGENCIA').AsInteger := agencia;
                ParamByName('ID_TIPO_CAPTACION').AsInteger := tipo;
                ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(cuenta);
                ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(digito);
                ExecQuery;
                if RecordCount > 0 then
                   begin
                     EdFechaAperturaApo.Caption := DateToStr(FieldByName('FECHA_APERTURA').AsDate);
                     tmp := FieldByName('ID_ESTADO').AsInteger;
                     Close;
                     SQL.Clear;
                     SQL.Add('select DESCRIPCION from "cap$tiposestado" where ');
                     SQL.Add('ID_ESTADO = :"ID_ESTADO" ');
                     ParamByName('ID_ESTADO').AsInteger := tmp;
                     ExecQuery;
                     if RecordCount > 0 then
                     begin
                        EdEstadoAporte.Caption := FieldByName('DESCRIPCION').AsString;
                     end;
                     Close;
                   end;
                Close;
        end;

end;


procedure TfrmConsultaProductos.BuscarDatosAhorro(tipo:Integer;agencia: integer;
  cuenta: string);
var digito:string;
    tmp:Integer;
    Inicial:Currency;
    Actual:Currency;
    i:Integer;
begin
        Inicial := 0;
        Actual := 0;
        CBOtrosTitulares.Clear;        

        digito := DigitoControl(tipo,cuenta);
        with IBSQL do
        begin
                Close;
                SQL.Clear;
                SQL.Add('select ID_ESTADO,FECHA_APERTURA from "cap$maestro" where ');
                SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" ');
                SQL.Add('and NUMERO_CUENTA = :"NUMERO_CUENTA" and DIGITO_CUENTA = :"DIGITO_CUENTA" ');
                ParamByName('ID_AGENCIA').AsInteger := agencia;
                ParamByName('ID_TIPO_CAPTACION').AsInteger := tipo;
                ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(cuenta);
                ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(digito);
                ExecQuery;
                if RecordCount > 0 then
                   begin
                     tmp := FieldByName('ID_ESTADO').AsInteger;
                     EdFechaAperturaCaptacion.Caption := DateToStr(FieldByName('FECHA_APERTURA').AsDate);
                     Close;
                     SQL.Clear;
                     SQL.Add('select DESCRIPCION from "cap$tiposestado" where ');
                     SQL.Add('ID_ESTADO = :"ID_ESTADO" ');
                     ParamByName('ID_ESTADO').AsInteger := tmp;
                     ExecQuery;
                     if RecordCount > 0 then
                        EdEstadoCaptacion.Caption := FieldByName('DESCRIPCION').AsString;
                     Close;
                   end;
                Close;
                Close;
                SQL.Clear;
                SQL.Add('select "gen$persona".PRIMER_APELLIDO,"gen$persona".SEGUNDO_APELLIDO,"gen$persona".NOMBRE from "cap$maestrotitular"');
                SQL.Add('inner join "gen$persona" ON ("cap$maestrotitular".ID_IDENTIFICACION = "gen$persona".ID_IDENTIFICACION and ');
                SQL.Add('"cap$maestrotitular".ID_PERSONA = "gen$persona".ID_PERSONA)');
                SQL.Add('where "cap$maestrotitular".ID_AGENCIA = :"ID_AGENCIA" and "cap$maestrotitular".ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" ');
                SQL.Add('and "cap$maestrotitular".NUMERO_CUENTA = :"NUMERO_CUENTA" and "cap$maestrotitular".DIGITO_CUENTA = :"DIGITO_CUENTA" and "cap$maestrotitular".NUMERO_TITULAR > 1');
                ParamByName('ID_AGENCIA').AsInteger := agencia;
                ParamByName('ID_TIPO_CAPTACION').AsInteger := tipo;
                ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(cuenta);
                ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(digito);
                ExecQuery;
                if RecordCount > 0 then begin
                 while not Eof do begin
                   CBOtrosTitulares.Items.Add(FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                              FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                              FieldByName('NOMBRE').AsString);
                   Next;
                 end;
                 CBOtrosTitulares.ItemIndex := 0;
                end;
        end;


end;

procedure TfrmConsultaProductos.BuscarDatosAhorroC(tipo:Integer;agencia: integer;
  cuenta: string);
var digito:string;
    tmp,tmp1:Integer;
    Inicial:Currency;
    Actual:Currency;
    i:Integer;
begin
        digito := DigitoControl(tipo,cuenta);
        with IBSQL do
        begin
                Close;
                SQL.Clear;
                SQL.Add('select CUOTA,ID_PLAN,ID_ESTADO,FECHA_APERTURA,FECHA_PROXIMO_PAGO from "cap$maestro" where ');
                SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" ');
                SQL.Add('and NUMERO_CUENTA = :"NUMERO_CUENTA" and DIGITO_CUENTA = :"DIGITO_CUENTA" ');
                ParamByName('ID_AGENCIA').AsInteger := agencia;
                ParamByName('ID_TIPO_CAPTACION').AsInteger := tipo;
                ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(cuenta);
                ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(digito);
                ExecQuery;
                if RecordCount > 0 then
                   begin
                     tmp := FieldByName('ID_ESTADO').AsInteger;
                     tmp1 := FieldByName('ID_PLAN').AsInteger;
                     EdFechaAperturaContractual.Caption := DateToStr(FieldByname('FECHA_APERTURA').AsDate);
                     EdProximoAbonoContractual.Caption := DateToStr(FieldByName('FECHA_PROXIMO_PAGO').AsDate);
                     EdCuotaContractual.Caption := FormatCurr('$0,0.00',FieldByName('CUOTA').AsCurrency);
                     Close;
                     SQL.Clear;
                     SQL.Add('select DESCRIPCION from "cap$tiposestado" where ');
                     SQL.Add('ID_ESTADO = :"ID_ESTADO" ');
                     ParamByName('ID_ESTADO').AsInteger := tmp;
                     ExecQuery;
                     if RecordCount > 0 then
                        EdEstadoContractual.Caption := FieldByName('DESCRIPCION').AsString;
                     Close;
                     SQL.Clear;
                     SQL.Add('select DESCRIPCION from "cap$tiposplancontractual" where ');
                     SQL.Add('ID_PLAN = :"ID_PLAN" ');
                     ParamByName('ID_PLAN').AsInteger := tmp1;
                     ExecQuery;
                     if RecordCount > 0 then
                        EdPlanContractual.Caption := FieldByName('DESCRIPCION').AsString;
                     Close;
                   end;
        end;


end;


procedure TfrmConsultaProductos.BuscarDatosCertificados(tipo:Integer;agencia: integer; cuenta: string);
var digito:string;
    tmp:Integer;
    Inicial:Currency;
    Actual:Currency;
    i:Integer;
begin
        digito := DigitoControl(tipo,cuenta);
        with IBSQL do
        begin
                Close;
                SQL.Clear;
                SQL.Add('select VALOR_INICIAL,PLAZO_CUENTA,TIPO_INTERES,TASA_EFECTIVA,MODALIDAD,AMORTIZACION,ID_ESTADO,FECHA_APERTURA,FECHA_ULTIMO_PAGO,FECHA_VENCIMIENTO,FECHA_PRORROGA,FECHA_VENCIMIENTO_PRORROGA from "cap$maestro" where ');
                SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" ');
                SQL.Add('and NUMERO_CUENTA = :"NUMERO_CUENTA" and DIGITO_CUENTA = :"DIGITO_CUENTA" ');
                ParamByName('ID_AGENCIA').AsInteger := agencia;
                ParamByName('ID_TIPO_CAPTACION').AsInteger := tipo;
                ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(cuenta);
                ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(digito);
                ExecQuery;
                if RecordCount > 0 then
                   begin
                     tmp := FieldByName('ID_ESTADO').AsInteger;
                     EdFechaAperturaCertificado.Caption := DateToStr(FieldByname('FECHA_APERTURA').AsDate);
                     EdFechaVencimientoCertificado.Caption := DateToStr(FieldByName('FECHA_VENCIMIENTO').AsDate);
                     if FieldByname('FECHA_PRORROGA').AsDate > 0 Then
                        EdFechaProrrogaCer.Caption := DateToStr(FieldByname('FECHA_PRORROGA').AsDate)
                     else
                        EdFechaProrrogaCer.Caption := '';
                     if FieldByName('FECHA_VENCIMIENTO_PRORROGA').AsDate > 0 then
                        EdFechaVProrrogaCer.Caption := DateToStr(FieldByName('FECHA_VENCIMIENTO_PRORROGA').AsDate)
                     else
                        EdFechaVProrrogaCer.Caption := '';
                     if FieldByName('FECHA_ULTIMO_PAGO').AsDate > 0 then
                        EdFechaUltimoPagoCertificado.Caption := DateToStr(FieldByName('FECHA_ULTIMO_PAGO').AsDate)
                     else
                        EdFechaUltimoPagoCertificado.Caption := '';
                     EdPlazoCertificado.Caption := IntToStr(FieldByName('PLAZO_CUENTA').AsInteger);
                     EdTasaCertificado.Caption := FormatCurr('0.00%',FieldByName('TASA_EFECTIVA').AsFloat);
                     EdAmortizaCertificado.Caption := IntToStr(FieldByName('AMORTIZACION').AsInteger);
                     if FieldByName('TIPO_INTERES').AsString = 'F' then
                        EdTipoTasaCertificado.Caption := 'FIJA'
                     else
                        EdTipoTasaCertificado.Caption := 'VARIABLE';

                     Close;
                     SQL.Clear;
                     SQL.Add('select DESCRIPCION from "cap$tiposestado" where ');
                     SQL.Add('ID_ESTADO = :"ID_ESTADO" ');
                     ParamByName('ID_ESTADO').AsInteger := tmp;
                     ExecQuery;
                     if RecordCount > 0 then
                        EdEstadoCertificado.Caption := FieldByName('DESCRIPCION').AsString;
                     Close;
                   end;
        end;


        with IBTablaliquidacion do
        begin
             Close;
             ParamByName('ID_AGENCIA').AsInteger := agencia;
             ParamByName('ID_TIPO_CAPTACION').AsInteger := tipo;
             ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(cuenta);
             ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(digito);
             Open;
        end;


end;

procedure TfrmConsultaProductos.BuscarDatosColocacion(agencia: integer;
  cuenta: string);
var tmp:Integer;
    tmp1:string;
    Fecha:TDate;
    Cuota:Integer;
    Cuotas:Integer;
    DeudaHoy:Currency;
    DiasMora:Integer;
begin
        with IBSQL do
        begin
                Close;
                SQL.Clear;
                SQL.Add('select * from "col$colocacion" where ');
                SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_COLOCACION = :"ID_COLOCACION" ');
                ParamByName('ID_AGENCIA').AsInteger := agencia;
                ParamByName('ID_COLOCACION').AsString := cuenta;
                ExecQuery;
                if RecordCount > 0 then
                begin
                        if FieldByName('TIPO_INTERES').AsString = 'F' then
                        EdTipoInteres.Caption := 'FIJO'
                        else
                        begin
                          EdTipoInteres.Caption := 'VARIABLE';
                          tmp := FieldByName('ID_INTERES').AsInteger;
                          with IBSQL1 do
                          begin
                            Close;
                            SQL.Clear;
                            SQL.Add('select DESCRIPCION_TASA from "col$tasasvariables" where ');
                            SQL.Add('ID_INTERES = :"ID" ');
                            ParamByName('ID').AsInteger := tmp;
                            ExecQuery;
                            if RecordCount > 0 then
                              EdInteresVariable.Caption := FieldByName('DESCRIPCION_TASA').AsString;
                            Close;
                          end;
                        end;
                        tmp := FieldByName('ID_CLASIFICACION').AsInteger;
                        with IBSQL1 do
                        begin
                          Close;
                          SQL.Clear;
                          SQL.Add('select DESCRIPCION_CLASIFICACION from "col$clasificacion" where ');
                          SQL.Add('ID_CLASIFICACION = :"ID"');
                          ParamByName('ID').AsInteger := tmp;
                          ExecQuery;
                          if RecordCount > 0 then
                             EdClasificacion.Caption := FieldByName('DESCRIPCION_CLASIFICACION').AsString;
                          Close;
                        end;
                        EdCategoria.Caption := FieldByName('ID_CATEGORIA').Asstring;
                        EdEvaluacion.Caption := FieldByName('ID_EVALUACION').Asstring;
                        tmp := FieldByName('ID_LINEA').AsInteger;
                        with IBSQL1 do
                        begin
                          Close;
                          SQL.Clear;
                          SQL.Add('select DESCRIPCION_LINEA from "col$lineas" where ');
                          SQL.Add('ID_LINEA = :"ID"');
                          ParamByName('ID').AsInteger := tmp;
                          ExecQuery;
                          if RecordCount > 0 then
                             EdLinea.Caption := FieldByName('DESCRIPCION_LINEA').AsString;
                          Close;
                        end;
                        tmp := FieldByName('ID_INVERSION').AsInteger;
                        with IBSQL1 do
                        begin
                          Close;
                          SQL.Clear;
                          SQL.Add('select DESCRIPCION_INVERSION from "col$inversion" where ');
                          SQL.Add('ID_INVERSION = :"ID"');
                          ParamByName('ID').AsInteger := tmp;
                          ExecQuery;
                          if RecordCount > 0 then
                             EdInversion.Caption := FieldByName('DESCRIPCION_INVERSION').AsString;
                          Close;
                        end;
                        EdTasaE.Caption := FormatCurr('0.00%',FieldByName('TASA_INTERES_CORRIENTE').AsFloat);
                        EdPlazoColocacion.Caption := IntToStr(FieldByName('PLAZO_COLOCACION').AsInteger);
                        EdAmortizaK.Caption := IntToStr(FieldByName('AMORTIZA_CAPITAL').AsInteger);
                        EdAmortizaI.Caption := IntToStr(FieldByName('AMORTIZA_INTERES').AsInteger);
                        EdFechaCapital.Caption := DateToStr(FieldByName('FECHA_CAPITAL').AsDate);
                        EdFechaInteres.Caption := DateToStr(FieldByName('FECHA_INTERES').AsDate);
                        EdReciprocidad.Caption := FloatToStr(FieldByName('RECIPROCIDAD').AsFloat);
                        DiasMora := ObtenerDeudaHoy1(agencia,cuenta,IBDeudaHoy).Dias;
                        DeudaHoy := ObtenerDeudaHoy1(agencia,cuenta,IBDeudaHoy).Valor;
                        EdDiasMora.Caption := IntToStr(DiasMora);
                end;
          Close;
        end;

        with IBSQL do
        begin
            Close;
            SQL.Clear;
            SQL.Add('select * from "col$tablaliquidacion" where ID_AGENCIA = :"ID_AGENCIA" and ID_COLOCACION = :"ID_COLOCACION" and PAGADA = 0');
            SQL.Add('Order by FECHA_A_PAGAR');
            ParamByName('ID_AGENCIA').AsInteger := agencia;
            ParamByName('ID_COLOCACION').AsString := cuenta;
            ExecQuery;
            Cuotas := 0;
            if RecordCount > 0 then
            begin
             EdProxPagoColocacion.Caption := DateToStr(FieldByName('FECHA_A_PAGAR').AsDate);
             Fecha := FieldByName('FECHA_A_PAGAR').AsDate;
             while not Eof do
             begin
               if FieldByName('FECHA_A_PAGAR').AsDate < Date then
                begin
                  Cuota := FieldByName('CUOTA_NUMERO').AsInteger;
                  Cuotas := Cuotas + 1;
                end
               else
                begin
                  Break;
                end;
                Next;
             end;
            end;
            Close;
        end;

        with IBTablaLiquidacionColocacion do
        begin
           Close;
           ParamByName('ID_AGENCIA').AsInteger := agencia;
           ParamByName('ID_COLOCACION').AsString := cuenta;
           Open;
           IBTablaLiquidacionColocacionPAGADA.DisplayFormat := '#';
           IBTablaLiquidacionColocacionCAPITAL_A_PAGAR.DisplayFormat := '#,#0';
           IBTablaLiquidacionColocacionINTERES_A_PAGAR.DisplayFormat := '#,#0';
           IBTablaLiquidacionColocacionPAGADA.Alignment := taCenter;
           IBTablaLiquidacionColocacionCAPITAL_A_PAGAR.Alignment := taRightJustify;
           IBTablaLiquidacionColocacionINTERES_A_PAGAR.Alignment := taRightJustify;
           IBTablaLiquidacionColocacionCUOTA_NUMERO.Alignment := taCenter;
        end;

end;

procedure TfrmConsultaProductos.BuscarDatosFianzas(agencia: integer;
  cuenta: string);
var tmp:Integer;
    tmp1:string;
    Fecha:TDate;
    Cuota:Integer;
    Cuotas:Integer;
    vidid:Integer;
    vidpe:string;
    DeudaHoy:Currency;
    DiasMora:Integer;
begin
        with IBSQL do
        begin
                Close;
                SQL.Clear;
                SQL.Add('select * from "col$colocacion" where ');
                SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_COLOCACION = :"ID_COLOCACION" ');
                ParamByName('ID_AGENCIA').AsInteger := agencia;
                ParamByName('ID_COLOCACION').AsString := cuenta;
                ExecQuery;
                if RecordCount > 0 then
                begin
                        if FieldByName('TIPO_INTERES').AsString = 'F' then
                        EdTipoInteresF.Caption := 'FIJO'
                        else
                        begin
                          EdTipoInteresF.Caption := 'VARIABLE';
                        tmp := FieldByName('ID_INTERES').AsInteger;
                        with IBSQL1 do
                        begin
                            Close;
                            SQL.Clear;
                            SQL.Add('select DESCRIPCION_TASA from "col$tasasvariables" where ');
                            SQL.Add('ID_INTERES = :"ID" ');
                            ParamByName('ID').AsInteger := tmp;
                            ExecQuery;
                            if RecordCount > 0 then
                              EdInteresVariableF.Caption := FieldByName('DESCRIPCION_TASA').AsString;
                            Close;
                          end;
                        end;
                        tmp := FieldByName('ID_CLASIFICACION').AsInteger;
                        with IBSQL1 do
                        begin
                          Close;
                          SQL.Clear;
                          SQL.Add('select DESCRIPCION_CLASIFICACION from "col$clasificacion" where ');
                          SQL.Add('ID_CLASIFICACION = :"ID"');
                          ParamByName('ID').AsInteger := tmp;
                          ExecQuery;
                          if RecordCount > 0 then
                             EdClasificacionF.Caption := FieldByName('DESCRIPCION_CLASIFICACION').AsString;
                          Close;
                        end;
                        EdCategoriaF.Caption := FieldByName('ID_CATEGORIA').Asstring;
                        EdEvaluacionF.Caption := FieldByName('ID_EVALUACION').Asstring;
                        tmp := FieldByName('ID_LINEA').AsInteger;
                        with IBSQL1 do
                        begin
                          Close;
                          SQL.Clear;
                          SQL.Add('select DESCRIPCION_LINEA from "col$lineas" where ');
                          SQL.Add('ID_LINEA = :"ID"');
                          ParamByName('ID').AsInteger := tmp;
                          ExecQuery;
                          if RecordCount > 0 then
                             EdLineaF.Caption := FieldByName('DESCRIPCION_LINEA').AsString;
                          Close;
                        end;
                        tmp := FieldByName('ID_INVERSION').AsInteger;
                        with IBSQL1 do
                        begin
                          Close;
                          SQL.Clear;
                          SQL.Add('select DESCRIPCION_INVERSION from "col$inversion" where ');
                          SQL.Add('ID_INVERSION = :"ID"');
                          ParamByName('ID').AsInteger := tmp;
                          ExecQuery;
                          if RecordCount > 0 then
                             EdInversionF.Caption := FieldByName('DESCRIPCION_INVERSION').AsString;
                          Close;
                        end;
                        EdTasaEF.Caption := FormatCurr('0.00%',FieldByName('TASA_INTERES_CORRIENTE').AsFloat);
                        EdPlazoColocacionF.Caption := IntToStr(FieldByName('PLAZO_COLOCACION').AsInteger);
                        EdAmortizaKF.Caption := IntToStr(FieldByName('AMORTIZA_CAPITAL').AsInteger);
                        EdAmortizaIF.Caption := IntToStr(FieldByName('AMORTIZA_INTERES').AsInteger);
                        EdFechaCapitalF.Caption := DateToStr(FieldByName('FECHA_CAPITAL').AsDate);
                        EdFechaInteresF.Caption := DateToStr(FieldByName('FECHA_INTERES').AsDate);
                        EdReciprocidadF.Caption := FloatToStr(FieldByName('RECIPROCIDAD').AsFloat);
                        DiasMora := ObtenerDeudaHoy1(agencia,cuenta,IBDeudaHoy).Dias;
                        DeudaHoy := ObtenerDeudaHoy1(agencia,cuenta,IBDeudaHoy).Valor;

                        vidid := FieldByName('ID_IDENTIFICACION').AsInteger;
                        vidpe := FieldByName('ID_PERSONA').AsString;
                        with IBSQL1 do
                        begin
                           Close;
                           SQL.Clear;
                           SQL.Add('select PRIMER_APELLIDO,SEGUNDO_APELLIDO,NOMBRE from "gen$persona" ');
                           SQL.Add('where ID_IDENTIFICACION = :"ID_ID" and ID_PERSONA = :"ID_PE"');
                           ParamByName('ID_ID').AsInteger := vidid;
                           ParamByName('ID_PE').AsString := vidpe;
                           ExecQuery;
                           if RecordCount > 0 then
                           begin
                              EdDeudorF.Caption := FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                                   FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                                   FieldByName('NOMBRE').AsString;
                           end;
                        end;
                end;
          Close;
        end;

        with IBSQL do
        begin
            Close;
            SQL.Clear;
            SQL.Add('select * from "col$tablaliquidacion" where ID_AGENCIA = :"ID_AGENCIA" and ID_COLOCACION = :"ID_COLOCACION" and PAGADA = 0');
            ParamByName('ID_AGENCIA').AsInteger := agencia;
            ParamByName('ID_COLOCACION').AsString := cuenta;
            ExecQuery;
            Cuotas := 0;
            if RecordCount > 0 then
            begin
             EdProxPagoColocacionF.Caption := DateToStr(FieldByName('FECHA_A_PAGAR').AsDate);
             Fecha := FieldByName('FECHA_A_PAGAR').AsDate;
             while not Eof do
             begin
               if FieldByName('FECHA_A_PAGAR').AsDate < Date then
                begin
                  Cuota := FieldByName('CUOTA_NUMERO').AsInteger;
                  Cuotas := Cuotas + 1;
                end
               else
                begin
                  Break;
                end;
                Next;
             end;
            end;
            Close;
        end;

        with IBTablaLiquidacionColocacion do
        begin
           Close;
           ParamByName('ID_AGENCIA').AsInteger := agencia;
           ParamByName('ID_COLOCACION').AsString := cuenta;
           Open;
           IBTablaLiquidacionColocacionPAGADA.DisplayFormat := '#';
           IBTablaLiquidacionColocacionCAPITAL_A_PAGAR.DisplayFormat := '#,#0';
           IBTablaLiquidacionColocacionINTERES_A_PAGAR.DisplayFormat := '#,#0';
           IBTablaLiquidacionColocacionPAGADA.Alignment := taCenter;
           IBTablaLiquidacionColocacionCAPITAL_A_PAGAR.Alignment := taRightJustify;
           IBTablaLiquidacionColocacionINTERES_A_PAGAR.Alignment := taRightJustify;
           IBTablaLiquidacionColocacionCUOTA_NUMERO.Alignment := taCenter;
        end;

end;


procedure TfrmConsultaProductos.CmdActualizar2Click(Sender: TObject);
begin
        with IBSQL do
        begin
            Close;
            SQL.Clear;
            SQL.Add('select ID_PERSONA,ID_IDENTIFICACION from "cap$maestrotitular" where (');
            SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_TIPO_CAPTACION = :"ID_TIPO_CAPTACION" ');
            SQL.Add('and NUMERO_CUENTA = :"NUMERO_CUENTA" and DIGITO_CUENTA = :"DIGITO_CUENTA" )');
            ParamByName('ID_AGENCIA').AsInteger := Agencia;
            ParamByName('ID_TIPO_CAPTACION').AsInteger := CBTiposCaptacion.KeyValue;
            ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(EdCaptacion.Text);
            ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(DigitoControl(CBTiposCaptacion.KeyValue,FormatCurr('0000000',StrToFloat(EdCaptacion.Text))));
            ExecQuery;
            if RecordCount > 0 then
            begin
              CBtiposid.KeyValue := FieldByName('ID_IDENTIFICACION').AsInteger;
              EdNumeroIdentificacion.Text  := FieldByName('ID_PERSONA').AsString;
              CmdActualizar1.Click;
            end
            else
            begin
              MessageDlg('Persona no encontrada',mtError,[mbOk],0);
            end;
        end;
end;

procedure TfrmConsultaProductos.EdCaptacionExit(Sender: TObject);
begin
        EdCaptacion.Text := FormatCurr('0000000',StrToFloat(EdCaptacion.Text));
end;

procedure TfrmConsultaProductos.CmdActualizar3Click(Sender: TObject);
begin
        with IBSQL do
        begin
            Close;
            SQL.Clear;
            SQL.Add('select ID_IDENTIFICACION,ID_PERSONA from "col$colocacion" where ');
            SQL.Add('ID_AGENCIA = :"ID_AGENCIA" and ID_COLOCACION = :"ID_COLOCACION" ');
            ParamByName('ID_AGENCIA').AsInteger := Agencia;
            ParamByName('ID_COLOCACION').AsString := EdColocacion.Text;
            ExecQuery;
            if RecordCount > 0 then
            begin
              CBtiposid.KeyValue := FieldByName('ID_IDENTIFICACION').AsInteger;
              EdNumeroIdentificacion.Text  := FieldByName('ID_PERSONA').AsString;
              CmdActualizar1.Click;
            end
            else
            begin
              MessageDlg('Persona no encontrada',mtError,[mbOk],0);
            end;
        end;
end;

procedure TfrmConsultaProductos.BuscarDatosObservaciones;
begin
        with IBObservaciones do
        begin
                Close;
                ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
                ParamByName('ID_PERSONA').AsString := vidpersona;
                Open;
        end;
end;

procedure TfrmConsultaProductos.IBTablaLiquidacionColocacionPAGADAGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
        if Sender.AsInteger = 0 then Text := 'N'
        else
        if (Sender.AsInteger = 1) or (Sender.AsInteger = -1) then Text := 'S';

end;

procedure TfrmConsultaProductos.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmConsultaProductos.DBImage1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
        if ssCtrl in Shift then begin
          MessageDlg('No puede realizar procesos de copiar o cortar',mtError,[mbcancel],0);
          Clipboard.Clear;
        end;

end;

procedure TfrmConsultaProductos.DBImage3KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
        if ssCtrl in Shift then begin
          MessageDlg('No puede realizar procesos de copiar o cortar',mtError,[mbcancel],0);
          Clipboard.Clear;
        end;

end;

procedure TfrmConsultaProductos.GridObservacionesDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  bmp: TBitmap;
  W: Integer;
  R: TRect;
begin
  R := Rect;
  if Column.Field = IBObservacionesSEMAFORO then begin
    bmp := TBitmap.Create;
    try
      if Column.Field.Value = 2 then
         bmp.LoadFromResourceName(HInstance,'SEMROJO')
      else
      if Column.Field.Value = 1 then
         bmp.LoadFromResourceName(HInstance,'SEMAMARILLO')
      else
      if Column.Field.Value = 0 then
         bmp.LoadFromResourceName(HInstance,'SEMVERDE');
      W := (Rect.Bottom - Rect.Top) * 1;
      R.Right := Rect.Left + W;
      GridObservaciones.Canvas.StretchDraw(R, bmp);
    finally
      bmp.Free;
    end;
    R := Rect;
    R.Left := R.Left + W;
  end;
  GridObservaciones.DefaultDrawDataCell(R, Column.Field, State);end;

procedure TfrmConsultaProductos.IBObservacionesOBSERVACIONGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
        Text := Sender.AsString;
end;

procedure TfrmConsultaProductos.IBObservacionesID_EMPLEADOGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
        with IBSQL1 do begin
          Close;
          SQL.Clear;
          SQL.Add('select * from "gen$empleado" where ID_EMPLEADO = :ID_EMPLEADO');
          ParamByName('ID_EMPLEADO').AsString := Sender.AsString;
          try
           ExecQuery;
           if RecordCount > 0 then
              Text := Trim(FieldByName('NOMBRE').AsString + ' ' +
                           FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                           FieldByName('SEGUNDO_APELLIDO').AsString)
           else
              Text := 'NO REGISTRADO';
          except
            Transaction.Rollback;
            raise;
            Exit;
          end;
        end;
end;

procedure TfrmConsultaProductos.IBObservacionesAfterScroll(
  DataSet: TDataSet);
begin
        Memo.Text := DataSet.FieldByName('OBSERVACION').AsString;
end;

procedure TfrmConsultaProductos.IraObservaciones1Click(Sender: TObject);
var frmControldeObservaciones:TfrmControldeObservaciones;
begin
        frmControldeObservaciones := TfrmControldeObservaciones.Create(Self);
        frmControldeObservaciones.Id := vididentificacion;
        frmControldeObservaciones.Persona := vidpersona;
        frmControldeObservaciones.ShowModal;
end;

procedure TfrmConsultaProductos.IBObservacionesSEMAFOROGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
        Text := '';
end;

procedure TfrmConsultaProductos.AgregarSolicitudes;
begin
       with IBConsulta do
       begin
             Close;
             SQL.Clear;
             SQL.Add('SELECT ');
             SQL.Add('"col$solicitud".ID_SOLICITUD,');
             SQL.Add('"col$estadosolicitud".DESCRIPCION_ESTADO');
             SQL.Add('FROM');
             SQL.Add('"col$solicitud"');
             SQL.Add('INNER JOIN "col$estadosolicitud" ON ("col$solicitud".ESTADO="col$estadosolicitud".ID_ESTADO)');
             SQL.Add('WHERE');
             SQL.Add('("col$solicitud".ID_PERSONA = :ID_PERSONA) AND ');
             SQL.Add('("col$solicitud".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND ');
             SQL.Add('("col$solicitud".ESTADO IN (1,2,3,4,8,11,12,13,7))');
             ParamByName('ID_PERSONA').AsString := vidpersona;
             ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
             Open;
             //ShowMessage(FieldByName('ID_SOLICITUD').AsString);
             //if RecordCount <> 0 then
             //begin
             while not Eof do
             begin
                arbolinfo := TProductos.Create;
                arbolinfo.forma := 8;
                arbolinfo.nombre := FieldByName('ID_SOLICITUD').AsString + ' ' + FieldByName('DESCRIPCION_ESTADO').AsString;
                arbolinfo.tipo := 0;
                arbolinfo.numero := FieldByName('ID_SOLICITUD').AsString;
                arbolinfo.agencia := Agencia;
                arbolinfo.digito := 0;
                arbolinfo.nivel := 1;
                NodoSo[1] := Arbol.Items.AddChildObject(NodoSo[0],arbolinfo.nombre,arbolinfo);
                NodoSo[1].ImageIndex := 1;
                Next;
             end;
        end;

end;

procedure TfrmConsultaProductos.BuscarSolicitudes;
begin
        with IBllenaSolicitud do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          ParamByName('ID_PERSONA').AsString := vidpersona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
          Open;
        end;
end;

procedure TfrmConsultaProductos.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
        try
          if id_persona_sol = '' then 
          dmColocacion.Free;
        except
        end;
        if dmGeneral.IBTransaction1.InTransaction then
           dmGeneral.IBTransaction1.Commit;
end;

procedure TfrmConsultaProductos.BuscaCredivida;
var     Astream :TStringStream;
        XmlDoc,Xmlres,RDoc :TsdXmlDocument;
        tamano :Integer;
        nodo1 :TXmlNode;
        i :Integer;
        sentencia :string;
begin
        XmlDoc := TsdXmlDocument.CreateName('equivida');
        XmlDoc.EncodingString := 'ISO8859-1';
        XmlDoc.XmlFormat := xfReadable;
        nodo1 := XmlDoc.Root.NodeNew('Tipo');
        nodo1.WriteInteger('Opcion',2);
        Nodo1 := XmlDoc.Root.NodeNew('registro');
        AStream := TStringStream.Create('');
        with Nodo1 do
        begin
          WriteString('cedula',vIdpersona);
          WriteString('consecutivo','0');
        end;// fin nodo1
        XmlDoc.SaveToStream(Astream);
        with IdTCPClient1 do
        begin
          Host := host_equivida;
          Port := puerto_barrido;
          try
          Connect;
          except
          begin
            Disconnect;
            Exit;
          end;// fin excetion
          end;//fin except
          if Connected then
          begin
            WriteInteger(AStream.Size);
            OpenWriteBuffer;
            WriteStream(AStream);
            CloseWriteBuffer;
            FreeAndNil(AStream);
            tamano := ReadInteger;
            AStream := TStringStream.Create('');
            ReadStream(AStream,tamano,False);
            RDoc := TsdXmlDocument.Create;
            RDoc.LoadFromStream(AStream);
          end;// fin connect
          Disconnect;
          if RDoc.Root.NodeCount > 0 then
          begin
            arbolinfo := TProductos.Create;
            arbolinfo.forma := 9;
            arbolinfo.nombre := 'CREDIVIDAS';
            arbolinfo.tipo := 0;
            arbolinfo.numero := '';
            arbolinfo.agencia := Agencia;
            arbolinfo.digito := 0;
            arbolinfo.nivel := 1;
            NodoSe[0] := Arbol.Items.AddChildObject(NodoSe[0],arbolinfo.nombre,arbolinfo);
            NodoSe[0].ImageIndex := 1;
            for i := 0 to RDoc.Root.NodeCount -1 do
            begin
                NodoSe[i+2] := Arbol.Items.AddChildObject(NodoSe[0],Rdoc.Root.Nodes[i].ValueAsString,arbolinfo);
                NodoSe[i+2].ImageIndex := 5;
              // := Rdoc.Root.Nodes[i].ValueAsString + #13 + respuesta;
            end;//fin for
        end; // fin de if
        end; // fin del coo
        end;
procedure TfrmConsultaProductos.AgregarTarjetaDebito;
begin
        with IBConsulta do
        begin
           SQL.Clear;
           SQL.Add('SELECT ');
           SQL.Add('"cap$tarjetacuenta".ID_TARJETA,');
           SQL.Add('"cap$tarjetaestado".DESCRIPCION');
           SQL.Add('FROM');
           SQL.Add('"cap$tarjetacuenta"');
           SQL.Add('INNER JOIN "cap$tarjetaestado" ON ("cap$tarjetacuenta".ID_ESTADO="cap$tarjetaestado".ID_ESTADO)');
           SQL.Add(' INNER JOIN "cap$maestrotitular" ON ("cap$tarjetacuenta".ID_AGENCIA="cap$maestrotitular".ID_AGENCIA)');
           SQL.Add('  AND ("cap$tarjetacuenta".ID_TIPO_CAPTACION="cap$maestrotitular".ID_TIPO_CAPTACION)');
           SQL.Add('  AND ("cap$tarjetacuenta".NUMERO_CUENTA="cap$maestrotitular".NUMERO_CUENTA)');
           SQL.Add('  AND ("cap$tarjetacuenta".DIGITO_CUENTA="cap$maestrotitular".DIGITO_CUENTA)');
           SQL.Add('WHERE');
           SQL.Add('  ("cap$maestrotitular".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND ');
           SQL.Add('  ("cap$maestrotitular".ID_PERSONA = :ID_PERSONA) AND ');
           SQL.Add('  ("cap$maestrotitular".NUMERO_TITULAR = 1) AND ');
           SQL.Add('  ("cap$maestrotitular".TIPO_TITULAR = 1)');
           SQL.Add('ORDER BY');
           SQL.Add('  "cap$tarjetacuenta".ID_ESTADO');
           ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
           ParamByName('ID_PERSONA').AsString := vidpersona;
           try
            Open;
            if RecordCount > 0 then
            begin
                arbolinfo := TProductos.Create;
                arbolinfo.forma := 0; //FieldByName('ID_FORMA').AsInteger;
                arbolinfo.nombre := 'TARJETAS DEBITO';
                arbolinfo.tipo := 0;
                arbolinfo.numero := '';
                arbolinfo.agencia := Agencia;
                arbolinfo.digito := 0;
                arbolinfo.nivel := 1;
                NodoSe[1] := Arbol.Items.AddChildObject(NodoSe[0],arbolinfo.nombre,nil);//arbolinfo);
                NodoSe[1].ImageIndex := 11;
                while not Eof do begin
                 arbolinfo := TProductos.Create;
                 arbolinfo.forma := 10;
                 arbolinfo.nombre := FieldByName('ID_TARJETA').AsString + ' ' + FieldByName('DESCRIPCION').AsString;
                 arbolinfo.tipo := 0;
                 arbolinfo.numero := FieldByName('ID_TARJETA').AsString;
                 arbolinfo.agencia := Agencia;
                 arbolinfo.digito := 0;
                 arbolinfo.nivel := 3;
                 NodoSe[2] := Arbol.Items.AddChildObject(NodoSe[1],arbolinfo.nombre,arbolinfo);
                 NodoSe[2].ImageIndex := 11;
                 Next;
                end;
            end;
           except
             Transaction.Rollback;
             raise;
             Exit;
           end;
        end;

end;

procedure TfrmConsultaProductos.ExpandirTodo1Click(Sender: TObject);
begin
        Arbol.FullExpand;
end;

procedure TfrmConsultaProductos.ContraerTodo1Click(Sender: TObject);
begin
        Arbol.FullCollapse;
end;

procedure TfrmConsultaProductos.BuscarDatosTarjetaDebito(numero: string);
begin
        with IBConsulta do
        begin
           SQL.Clear;
           SQL.Add('SELECT ');
           SQL.Add('  "cap$tarjetacuenta".ID_TARJETA,');
           SQL.Add('  "cap$tarjetaestado".DESCRIPCION,');
           SQL.Add('  "cap$tarjetacuenta".FECHA_ASIGNACION,');
           SQL.Add('  "cap$tarjetacuenta".FECHA_BLOQUEO,');
           SQL.Add('  "cap$tarjetacuenta".FECHA_CANCELADA,');
           SQL.Add('  "cap$tarjetacuenta".CUPO_ATM,');
           SQL.Add('  "cap$tarjetacuenta".CUPO_POS,');
           SQL.Add('  "cap$tarjetacuenta".TRANS_ATM,');
           SQL.Add('  "cap$tarjetacuenta".TRANS_POS');
           SQL.Add('FROM');
           SQL.Add(' "cap$tarjetacuenta"');
           SQL.Add(' INNER JOIN "cap$tarjetaestado" ON ("cap$tarjetacuenta".ID_ESTADO="cap$tarjetaestado".ID_ESTADO)');
           SQL.Add('WHERE');
           SQL.Add('  ("cap$tarjetacuenta".ID_TARJETA = :ID_TARJETA)');
           ParamByName('ID_TARJETA').AsString := numero;
           try
            Open;
            if RecordCount > 0 then
            begin
              EdTarjetaDebito.Caption := FieldByName('ID_TARJETA').AsString;
              EdFechaAsignacion.Caption := FieldByName('FECHA_ASIGNACION').AsString;
              if FieldByName('FECHA_BLOQUEO').AsFloat <> 0 then
                 EdFechaBloqueo.Caption := FieldByName('FECHA_BLOQUEO').AsString
              else
                 EdFechaBloqueo.Caption := '';
              if FieldByName('FECHA_CANCELADA').AsFloat <> 0 then
                 EdFechaCancelacion.Caption := FieldByName('FECHA_CANCELADA').AsString
              else
                 EdFechaCancelacion.Caption := '';

              EdCupoATM.Caption := FormatCurr('$#,#.00',FieldByName('CUPO_ATM').AsCurrency);
              EdCupoPOS.Caption := FormatCurr('$#,#.00',FieldByName('CUPO_POS').AsCurrency);
              EdTransaATM.Caption := FieldByName('TRANS_ATM').AsString;
              EdTransaPOS.Caption := FieldByName('TRANS_POS').AsString;
              EdEstado.Caption := FieldByName('DESCRIPCION').AsString;
            end;
           except
            Transaction.Rollback;
            raise;
            Exit;
           end;
        end;

end;

procedure TfrmConsultaProductos.splitterMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
        if (ssleft in Shift) then
        begin

        end;
end;

procedure TfrmConsultaProductos.BuscarDatosSolicitud(
  vId_Solicitud: string;vPersona:Boolean);
var     vEnte :Integer;
        vIdEmpleado :string;
        vFecha :TDateTime;
        vEstado :Integer;
        vIdper :string;
        vIdid :Integer;
begin
        vEnte := -1;
        JVempleadoRec.Caption := '';
        JVfechaRec.Caption := '';
        JVempleadoCre.Caption := '';
        JVfechaCre.Caption := '';
        JVempleadoAna.Caption := '';
        JVfechaAna.Caption := '';
        JVestado.Caption := '';
        JVvalor.Caption := '';
        JVlinea.Caption := '';
        JVrespaldo.Caption := '';
        JVgarantia.Caption := '';
        JVplazo.Caption := '';
        JVcapital.Caption := '';
        JVcuota.Caption := '';
        Mobservacion.Text := '';
        JVempleadoInf.Caption := '';
        JVfechaInf.Caption := '';
        JVSolicitud.Caption := vId_Solicitud;
        with IBllenaSolicitud do
        begin
         try
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"col$respaldo".DESCRIPCION_RESPALDO,');
          SQL.Add('"col$estadosolicitud".DESCRIPCION_ESTADO,');
          SQL.Add('"col$garantia".DESCRIPCION_GARANTIA,');
          SQL.Add('"col$lineas".DESCRIPCION_LINEA,');
          SQL.Add('"col$tiposcuota".DESCRIPCION_TIPO_CUOTA,');
          SQL.Add('"gen$empleado".PRIMER_APELLIDO,');
          SQL.Add('"gen$empleado".SEGUNDO_APELLIDO,');
          SQL.Add('"gen$empleado".NOMBRE,');
          SQL.Add('"col$solicitud".VALOR_SOLICITADO,');
          SQL.Add('"col$solicitud".ID_PERSONA,');
          SQL.Add('"col$solicitud".ID_IDENTIFICACION,');
          SQL.Add('"col$solicitud".PLAZO,');
          SQL.Add('"col$solicitud".AMORTIZACION,');
          SQL.Add('"col$solicitud".PAGO_INTERES,');
          SQL.Add('"col$solicitud".FECHA_RECEPCION,');
          SQL.Add('"col$solicitud".ESTADO,');
          SQL.Add('"col$solicitud".FECHA_CONCEPTO,');
          SQL.Add('"col$solicitud".VALOR_APROBADO,');
          SQL.Add('"col$solicitud".ENTE_APROBADOR');
          SQL.Add('FROM');
          SQL.Add('"col$solicitud"');
          SQL.Add('INNER JOIN "col$respaldo" ON ("col$solicitud".RESPALDO="col$respaldo".ID_RESPALDO)');
          SQL.Add('INNER JOIN "col$estadosolicitud" ON ("col$solicitud".ESTADO="col$estadosolicitud".ID_ESTADO)');
          SQL.Add('INNER JOIN "col$garantia" ON ("col$solicitud".GARANTIA="col$garantia".ID_GARANTIA)');
          SQL.Add('INNER JOIN "col$lineas" ON ("col$solicitud".LINEA="col$lineas".ID_LINEA)');
          SQL.Add('INNER JOIN "col$tiposcuota" ON ("col$solicitud".TIPO_CUOTA="col$tiposcuota".ID_TIPOS_CUOTA)');
          SQL.Add('INNER JOIN "gen$empleado" ON ("col$solicitud".ID_EMPLEADO="gen$empleado".ID_EMPLEADO)');
          SQL.Add('WHERE');
          SQL.Add('("col$solicitud".ID_SOLICITUD = :ID_SOLICITUD)');
          SQL.Add('order by "col$estadosolicitud".ORDEN');
          ParamByName('ID_SOLICITUD').AsString := vId_Solicitud;
          Open;
          vIdid := FieldByName('ID_IDENTIFICACION').AsInteger;
          vIdper := FieldByName('ID_PERSONA').AsString;
          JVempleadoRec.Caption := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
          JVfechaRec.Caption := FormatDateTime('yyyy/mm/dd hh:mm',FieldByName('FECHA_RECEPCION').AsDateTime);
          JVrespaldo.Caption := FieldByName('DESCRIPCION_RESPALDO').AsString;
          JVgarantia.Caption := FieldByName('DESCRIPCION_GARANTIA').AsString;
          JVlinea.Caption := FieldByName('DESCRIPCION_LINEA').AsString;
          JVcuota.Caption := FieldByName('DESCRIPCION_TIPO_CUOTA').AsString;
          JVplazo.Caption := FieldByName('PLAZO').AsString + ' Dias.';
          JVcapital.Caption := FieldByName('AMORTIZACION').AsString + ' Dias.';
          vEstado := FieldByName('ESTADO').AsInteger;
          if  vEstado = 4 then
          begin
          vEnte := FieldByName('ENTE_APROBADOR').AsInteger;
          JvLabel7.Caption := 'Estado y Fecha de Aprobacion';
          JvLabel12.Caption := 'Valor Aprobado';
          JVvalor.Caption := '$' + FormatCurr('#,#',FieldByName('VALOR_APROBADO').AsCurrency) + ' ';
          JVestado.Caption := FieldByName('DESCRIPCION_ESTADO').AsString + ' - ' + FieldByName('FECHA_CONCEPTO').AsString;
          end
          else if vEstado = 7 then
          begin
            vEnte := FieldByName('ENTE_APROBADOR').AsInteger;
            JvLabel7.Caption := 'Estado y Fecha de Negaci�n';
            JvLabel12.Caption := 'Valor Negado';
            JVvalor.Caption := '$' + FormatCurr('#,#',FieldByName('VALOR_APROBADO').AsCurrency) + ' ';
            JVestado.Caption := FieldByName('DESCRIPCION_ESTADO').AsString + ' - ' + FieldByName('FECHA_CONCEPTO').AsString;
          end
          else
          begin
          JvLabel7.Caption := 'Estado';
          JvLabel12.Caption := 'Valor Solicitado';
          JVvalor.Caption := '$' + FormatCurr('#,#',FieldByName('VALOR_SOLICITADO').AsCurrency) + ' ';
          JVestado.Caption := FieldByName('DESCRIPCION_ESTADO').AsString;
          end;
          JVinteres.Caption := FieldByName('PAGO_INTERES').AsString + ' Dias.';
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"col$solicitudempleado".FECHAHORA,');
          SQL.Add('"gen$empleado".NOMBRE,');
          SQL.Add('"gen$empleado".PRIMER_APELLIDO,');
          SQL.Add('"gen$empleado".SEGUNDO_APELLIDO');
          SQL.Add('FROM');
          SQL.Add('"gen$empleado"');
          SQL.Add('INNER JOIN "col$solicitudempleado" ON ("gen$empleado".ID_EMPLEADO="col$solicitudempleado".ID_EMPLEADO)');
          SQL.Add('WHERE');
          SQL.Add('("col$solicitudempleado".ID_SOLICITUD = :ID_SOLICITUD)');
          ParamByName('ID_SOLICITUD').AsString := vId_Solicitud;
          Open;
          JVempleadoCre.Caption := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
          if FieldByName('FECHAHORA').AsDateTime <> 0 then
          JVfechaCre.Caption := FormatDateTime('yyyy/mm/dd hh:mm',FieldByName('FECHAHORA').AsDateTime);
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"gen$empleado".NOMBRE,');
          SQL.Add('"gen$empleado".PRIMER_APELLIDO,');
          SQL.Add('"gen$empleado".SEGUNDO_APELLIDO,');
          SQL.Add('"col$solicitudanalista".FECHAHORA');
          SQL.Add('FROM');
          SQL.Add('"gen$empleado"');
          SQL.Add('INNER JOIN "col$solicitudanalista" ON ("gen$empleado".ID_EMPLEADO="col$solicitudanalista".ID_EMPLEADO)');
          SQL.Add('WHERE');
          SQL.Add('("col$solicitudanalista".ID_SOLICITUD = :ID_SOLICITUD) AND ');
          SQL.Add('("col$solicitudanalista".ES_VIGENTE = 1)');
          ParamByName('ID_SOLICITUD').AsString := vId_Solicitud;
          Open;
          JVempleadoAna.Caption := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
          if FieldByName('FECHAHORA').AsDateTime <> 0 then
          JVfechaAna.Caption := FormatDateTime('yyyy/mm/dd hh:mm',FieldByName('FECHAHORA').AsDateTime);
          if vEnte <> -1 then
          begin
            if vEstado = 4 then
            begin
              SQL.Clear;
              SQL.Add('SELECT * FROM "col$observacion" WHERE ID_OBSERVACION = 14 AND ID_SOLICITUD = :ID_SOLICITUD');
              ParamByName('ID_SOLICITUD').AsString := vId_Solicitud;
              Open;
              Mobservacion.Text := FieldByName('OBSERVACION').AsString;
            end;
            if vEstado = 7 then
            begin
              SQL.Clear;
              SQL.Add('SELECT * FROM "col$observacion" WHERE ID_OBSERVACION = 6 AND ID_SOLICITUD = :ID_SOLICITUD');
              ParamByName('ID_SOLICITUD').AsString := vId_Solicitud;
              Open;
              Mobservacion.Text := FieldByName('OBSERVACION').AsString;
            end;
          end;
          SQL.Clear;
          SQL.Add('select ID_EMPLEADO,FECHA from "col$registroinformacion" where');
          SQL.Add('ID_REGISTRO = (SELECT MAX(ID_REGISTRO) FROM');
          SQL.Add('"col$registroinformacion" WHERE');
          SQL.Add('(ID_PERSONA = :ID_PERSONA) AND');
          SQL.Add('(ID_IDENTIFICACION = :ID_IDENTIFICACION))');
          ParamByName('ID_PERSONA').AsString := vidpersona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
          Open;
          vIdEmpleado := FieldByName('ID_EMPLEADO').AsString;
          if FieldByName('FECHA').AsDateTime <> 0 then
             JVfechaInf.Caption := FormatDateTime('yyyy/mm/dd hh:mm',FieldByName('FECHA').AsDateTime);
          SQL.Clear;
          SQL.Add('select NOMBRE,PRIMER_APELLIDO,SEGUNDO_APELLIDO from "gen$empleado"');
          SQL.Add('where ID_EMPLEADO = :ID_EMPLEADO');
          ParamByName('ID_EMPLEADO').AsString := vIdEmpleado;
          Open;
          JVempleadoInf.Caption := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
          Close;
          if vPersona then
          begin
            JvGroupBox6.Caption := 'Nombres y Apellidos del Solicitante';
            SQL.Clear;
            SQL.Add('SELECT ');
            SQL.Add('"gen$persona".NOMBRE,');
            SQL.Add('"gen$persona".PRIMER_APELLIDO,');
            SQL.Add('"gen$persona".SEGUNDO_APELLIDO');
            SQL.Add('FROM');
            SQL.Add('"gen$persona"');
            SQL.Add('WHERE');
            SQL.Add('("gen$persona".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND ');
            SQL.Add('("gen$persona".ID_PERSONA = :ID_PERSONA)');
            ParamByName('ID_PERSONA').AsString := vIdper;
            ParamByName('ID_IDENTIFICACION').AsInteger := vIdid;
            Open;
            JVempleadoInf.Caption := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
            Close;
          end
          else
            JvGroupBox6.Caption := 'Datos Ultimo Empleado Informaci�n de Cr�dito';
         except
          Exit;
         end;
        end;
end;

procedure TfrmConsultaProductos.AgregaCodeudor;
begin
        with IBConsulta do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"col$solicitud".ID_SOLICITUD,');
          SQL.Add('"col$estadosolicitud".DESCRIPCION_ESTADO');
          SQL.Add('FROM');
          SQL.Add('"col$codeudor"');
          SQL.Add('INNER JOIN "col$solicitud" ON ("col$codeudor".ID_SOLICITUD="col$solicitud".ID_SOLICITUD)');
          SQL.Add('INNER JOIN "col$estadosolicitud" ON ("col$solicitud".ESTADO="col$estadosolicitud".ID_ESTADO)');
          SQL.Add('WHERE');
          SQL.Add('("col$solicitud".ESTADO IN (1,2,3,4,8,9,10,13,14)) AND');
          SQL.Add('("col$codeudor".ID_PERSONA = :ID_PERSONA) AND ');
          SQL.Add('("col$codeudor".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND ');
          SQL.Add('("col$codeudor".ES_CONYUGUE = 0)');
          ParamByName('ID_PERSONA').AsString := vidpersona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vididentificacion;
          Open;
          //*
          if RecordCount > 0 then
          begin
            arbolinfo := TProductos.Create;
            arbolinfo.forma := 0; //FieldByName('ID_FORMA').AsInteger;
            arbolinfo.nombre := 'CODEUDOR';
            arbolinfo.tipo := 0;
            arbolinfo.numero := '';
            arbolinfo.agencia := Agencia;
            arbolinfo.digito := 0;
            arbolinfo.nivel := 2;
            NodoOt[1] := Arbol.Items.AddChildObject(NodoOT[0],arbolinfo.nombre,nil);//arbolinfo);
            NodoOt[1].ImageIndex := 1;
            arbolinfo := TProductos.Create;
            arbolinfo.forma := 0; //FieldByName('ID_FORMA').AsInteger;
            arbolinfo.nombre := 'SOLICITUDES';
            arbolinfo.tipo := 0;
            arbolinfo.numero := '';
            arbolinfo.agencia := Agencia;
            arbolinfo.digito := 0;
            arbolinfo.nivel := 2;
            NodoOt[2] := Arbol.Items.AddChildObject(NodoOT[1],arbolinfo.nombre,nil);//arbolinfo);
            NodoOt[2].ImageIndex := 1;

            while not Eof do
            begin
              arbolinfo := TProductos.Create;
              arbolinfo.forma := 11;
              arbolinfo.nombre := FieldByName('ID_SOLICITUD').AsString + ' ' + FieldByName('DESCRIPCION_ESTADO').AsString;
              arbolinfo.tipo := 0;
              Arbolinfo.numero := FieldByName('ID_SOLICITUD').AsString;
              arbolinfo.agencia := Agencia;
              arbolinfo.digito := 0;
              arbolinfo.nivel := 3;
              NodoOt[3] := Arbol.Items.AddChildObject(NodoOT[2],arbolinfo.nombre,arbolinfo);
              NodoOt[3].ImageIndex := 1;
              Next;
           end;
          end;
        end;
end;

end.
