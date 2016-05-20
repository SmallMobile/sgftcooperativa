unit UnitBeneficiario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IBDatabase, DB, IBCustomDataSet, IBQuery, ComCtrls,
  ExtCtrls,idglobal,StrUtils, DBClient, Grids, DBGrids, DBCtrls, Buttons,
  pr_Common, pr_TxClasses, FR_DSet, FR_DBSet, FR_Class, frOLEExl, FR_E_HTM,
  FR_E_CSV, FR_E_RTF, FR_E_TXT,JclDateTime, JvBaseDlg, JvBrowseFolder,
  JvDialogs, Menus, JvComponent, JvTransLED;

type
  TFrmBeneficiario = class(TForm)
    IBQuery1: TIBQuery;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;                     
    Button5: TButton;
    Button6: TButton;
    DataSource1: TDataSource;
    CDafiliacion: TClientDataSet;
    CDafiliacionnombres: TStringField;
    CDafiliacionnit: TStringField;
    CDafiliacionlugar_nit: TStringField;
    CDafiliacionparentesco: TStringField;
    CDafiliacionsexo: TStringField;
    CDafiliacionestrato: TStringField;
    CDafiliaciondireccion: TStringField;
    CDafiliacionbarrio: TStringField;
    CDafiliaciontelefono: TStringField;
    CDafiliacionfecha_na: TStringField;
    CDafiliacioncuenta: TStringField;
    CDafiliacionnumero: TIntegerField;
    Panel1: TPanel;
    Button7: TButton;
    Label3: TLabel;
    DBconvenio: TDBLookupComboBox;
    IBconvenio: TIBQuery;
    DSconvenio: TDataSource;
    Panel2: TPanel;
    Sejecutar: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    Tipo: TLabel;
    Tipoa: TComboBox;
    Label1: TLabel;
    fecha1: TDateTimePicker;
    Label2: TLabel;
    fecha2: TDateTimePicker;
    SpeedButton3: TSpeedButton;
    IBid: TIBQuery;
    CDafiliacionciudad: TStringField;
    Label4: TLabel;
    DBOficina: TDBLookupComboBox;
    CDoficina: TClientDataSet;
    CDoficinacod_oficina: TIntegerField;
    CDoficinaoficina: TStringField;
    DSOFICINA: TDataSource;
    FRexcel: TfrOLEExcelExport;
    frReport1: TfrReport;
    frCompositeReport1: TfrCompositeReport;
    frDBDataSet1: TfrDBDataSet;
    SaveDialog1: TSaveDialog;
    frDBDataSet2: TfrDBDataSet;
    IBtiponit: TIBQuery;
    frTextExport1: TfrTextExport;
    frRTFExport1: TfrRTFExport;
    frCSVExport1: TfrCSVExport;
    frHTMExport1: TfrHTMExport;
    CDafiliacioncarnet: TStringField;
    CDafiliaciondescripcion: TStringField;
    CDafiliacionvalor_plan: TStringField;
    CDafiliacionfecha_a: TStringField;
    CDafiliacionplan: TStringField;
    Dialogo: TJvSaveDialog;
    PopupMenu1: TPopupMenu;
    ExportarDatos1: TMenuItem;
    CDafiliacionno_entrada: TIntegerField;
    CDafiliacioneps: TStringField;
    PrAfiliacion: TprTxReport;
    CDafiliacioncod_oficina: TIntegerField;
    CDafiliaciones_local: TIntegerField;
    CDafiliaciondes_oficina: TStringField;
    Button2: TButton;
    CDafiliacionnombre1: TStringField;
    CDafiliacionapellido1: TStringField;
    CDafiliacionapellido2: TStringField;
    CDafiliaciontipo_nit: TStringField;
    Label5: TLabel;
    CDafiliacionzona: TStringField;
    CDafiliacionmail: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SejecutarClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure ExportarDatos1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
  estrato,tipo_nit,nombres,barrio,direccion,telefono,ciudad,lugar_nit,cuenta,sexo :string;
  no_entrada :Integer;
  _iIdIdentificacion :Integer;
  fecha :string;
    conteo: integer;
    tipo_afiliacion: string;
    tipo_oficina: string;
    tipo_convenio: string;

    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
//    procedure actuliza4;
    function busca_carnet(nit: string;opcion,id_programa:integer): string;
    procedure fechas_vencidas;
    procedure exportar(archivo, cadena: string);
    function extraedatos(nit: string; opcion: integer): string;
    function no_estrato(nit: string): integer;
    { Private declarations }
  public
      opcion_reporte: Integer;
    valor_plan1: Currency;
    opcion_beneficiario: integer;
    controlcolor: boolean;
    numerocolor :Integer;
    procedure imprimir_reporte(cadena:string);
  published

    
    procedure tramite;
    procedure buscar;
    { Public declarations }
  end;

var
  FrmBeneficiario: TFrmBeneficiario;

implementation
uses unitdata,UnitGlobal, UnitPrograma,Unitdatamodulo, UnitQuerys,
  Unitprogreso,unitdataquerys,Unitpantallaprogreso, UnitPrincipal, UnitVistapreliminar,
  Unittipo, UnitImpresion, UnitActualiza;

{$R *.dfm}

procedure TFrmBeneficiario.Button1Click(Sender: TObject);
begin
        with IBQuery1 do
        begin
          Close;
          verificatransaccion(ibquery1);
          SQL.Clear;
          SQL.Add('insert into "fun$beneficiario" values(');
          SQL.Add(':nit,');
          SQL.Add(':nombre,');
          SQL.Add(':apellidos,');
          SQL.Add(':fecha,');
          SQL.Add(':ciudad,');
          SQL.Add(':telefono )');
          ParamByName('nit').AsInteger := 2365;
          ParamByName('nombre').AsString := 'xyz';
          ParamByName('apellidos').AsString := 'wju';
          ParamByName('fecha').AsDate := Date;
          ParamByName('ciudad').AsString := 'fff';
          ParamByName('telefono').AsString := '58585';
          Open;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmBeneficiario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
       // verificatransaccion(FrmPrograma.IBQuery1);
        //FrmPrograma.IBQuery1.Open;
end;

procedure TFrmBeneficiario.Button2Click(Sender: TObject);
var     cedulaa :string;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$afiliacion_1"."nit_beneficiario",');
          SQL.Add('"fun$afiliacion_1"."id_afiliacion",');
          SQL.Add('"fun$afiliacion_1"."parentesco"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion_1"');
          Open;
          Last;
          First;
          FrmProgreso := TFrmProgreso.Create(self);
          FrmProgreso.Barra.Maximum := RecordCount;
          FrmProgreso.Show;
          while not Eof do
          begin
            FrmProgreso.Barra.Position := DataQuerys.IBdatos.RecNo;
            FrmProgreso.Caption := 'Actualizacion Numero: ' + IntToStr(RecNo);
            if (FieldByName('parentesco').AsInteger = 1) or (FieldByName('parentesco').AsInteger = 20) then
               cedulaa := FieldByName('nit_beneficiario').AsString;
            with DataQuerys.IBselecion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('update "fun$afiliacion_1" set ');
              SQL.Add('"fun$afiliacion_1"."nit_asociado" = :cedula');
              SQL.Add('where "fun$afiliacion_1"."id_afiliacion" = :ced');
              ParamByName('ced').AsInteger := DataQuerys.IBdatos.FieldByName('id_afiliacion').AsInteger;
              ParamByName('cedula').AsString := cedulaa;
              ExecSQL;
              Close;
            end;
          Next;
        end;
        Close;
        FrmProgreso.Hide;
        DataQuerys.IBselecion.Transaction.Commit;
end;
end;

procedure TFrmBeneficiario.Button3Click(Sender: TObject);
var cedula1,cedula2 :string;
begin
        cedula2 := '0';
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"duplicados"."identificacion",');
          SQL.Add('"duplicados"."valor"');
          SQL.Add('FROM');
          SQL.Add('"duplicados"');
          Open;
          Last;
          First;
          FrmProgreso := TFrmProgreso.Create(self);
          FrmProgreso.Barra.Maximum := RecordCount;
          while not Eof do
          begin
          FrmProgreso.Barra.Position := DataQuerys.IBdatos.RecNo;
          cedula1 := DataQuerys.IBdatos.FieldByName('identificacion').AsString;
          if cedula1 = cedula2 then
          begin
            with DataQuerys.IBselecion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('delete from "duplicados"');
              SQL.Add('where "duplicados"."valor" = :valor');
              ParamByName('valor').AsInteger := DataQuerys.IBdatos.FieldByName('valor').AsInteger;
              ExecSQL;
              Close;
              Transaction.CommitRetaining;
            end;
          end;
          cedula2 := cedula1;
        Next;
        end;
 Close;
 FrmProgreso.Hide;
   end;
   end;

procedure TFrmBeneficiario.Button4Click(Sender: TObject);
var     cadena,h :string;
        s :Integer;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "fun$beneficiario"."identificacion","fun$beneficiario"."no_entrada"');
          SQL.Add('from "fun$beneficiario"');
          SQL.Add('where "fun$beneficiario"."tipo_id" = 4');
          SQL.Add('and "fun$beneficiario"."no_entrada" > 38210');
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Min := 0;
          frmProgresos.Max := RecordCount;
          frmProgresos.Titulo := 'Realizando Actualizacion';
          frmProgresos.Ejecutar;
          while not Eof do
          begin
          frmProgresos.Position := RecNo;
          frmProgresos.InfoLabel := 'Identificacion No : '+ FieldByName('identificacion').AsString;
          Application.ProcessMessages;
          cadena := FieldByName('identificacion').AsString;
          s := StrLen(PChar(cadena));
          h := MidStr(cadena,s,1);
          if h <> '/' then
          begin
          with DataQuerys.IBselecion do
          begin
          cadena := cadena + '/';
            Close;
            SQL.Clear;
            SQL.Add('update "fun$beneficiario" set ');
            SQL.Add('"fun$beneficiario"."identificacion" = :cadena');
            SQL.Add('where "fun$beneficiario"."no_entrada" = :nit');
            ParamByName('nit').AsInteger := DataQuerys.IBdatos.FieldByName('no_entrada').AsInteger;
            ParamByName('cadena').AsString := cadena;
            Open;
            Close;
          end;
          end;
         Next;
        end;
         Close;
         frmProgresos.Cerrar;
         DataQuerys.IBselecion.Transaction.Commit;
        end;
end;

procedure TFrmBeneficiario.Button5Click(Sender: TObject);
begin
        FrmProgreso := TFrmProgreso.Create(self);
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "fun$pruebas"."nit_asociado"');
          SQL.Add('from "fun$pruebas"');
          Open;
          Last;
          First;
          FrmProgreso.Barra.Maximum := RecordCount;
          while not Eof do
          begin
            FrmProgreso.Barra.Position := RecNo;
            FrmProgreso.Caption := 'numero : '+IntToStr(RecNo);
            with FrmQuerys.IBseleccion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('select count(*) as contador from "gen$persona"');
              SQL.Add('where "gen$persona".id_persona = :nit');
              parambyname('nit').AsString := DataQuerys.IBdatos.FieldByName('nit_asociado').AsString;
              Open;
              if FieldByName('contador').AsInteger >= 1 then
              begin
                with DataQuerys.IBselecion do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('update "fun$pruebas" set ');
                  SQL.Add('"fun$pruebas"."es_local" = 1');
                  SQL.Add('where "fun$pruebas"."nit_asociado" = :nit');
                  ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('nit_asociado').AsString;
                  Open;
                  Close;
                end;
              end;
            end;
          Next;
        end;
        Close;
        FrmProgreso.Hide;
        DataQuerys.IBselecion.Transaction.Commit;
    end;
    end;
procedure TFrmBeneficiario.Button6Click(Sender: TObject);

begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"fun$prueba"."ced"');
          SQL.Add('FROM');
          SQL.Add('"fun$prueba"');
          Open;
          while not Eof do
          begin
            with DataQuerys.IBingresa do
            begin
              Close;
              SQL.Clear;
              SQL.Add('update "fun$afiliacion" set');
              SQL.Add('"fun$afiliacion"."es_local" = 1');
              SQL.Add('where "fun$afiliacion"."nit_asociado" = :nit');
              ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('ced').AsString;
              Open;
              Close;
              Transaction.CommitRetaining;
            end;
               Next;
          end;
          Close;
        end;
DataQuerys.IBingresa.Transaction.Commit;
ShowMessage('listo');
end;

procedure TFrmBeneficiario.tramite;
var    h :string;
       s,tipo_n :Integer;
       cadena,id_persona :string;
       _sNombre1,_sApellido1,_sApellido2,_sZona :string;
       _sMail :string;
begin
        conteo := 0;
        valor_plan1 := 0;
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$afiliacion"."nit_beneficiario",');
          SQL.Add('"fun$parentesco"."descripcion",');
          SQL.Add('"fun$afiliacion"."es_local",');
          SQL.Add('"fun$afiliacion"."fecha"');
          SQL.Add(',"fun$afiliacion"."parentesco"');
          SQL.Add(',"fun$oficinas"."descripcion" as des_oficina,');
          SQL.Add('"fun$oficinas"."cod_oficina",');
          SQL.Add('"fun$afiliacion"."id_afiliacion",');
          SQL.Add('"fun$afiliacion"."nit_asociado","fun$afiliacion"."ZONA"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('INNER JOIN "fun$oficinas" on ("fun$afiliacion"."cod_oficina" = "fun$oficinas"."cod_oficina"),');
          SQL.Add('"fun$parentesco"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."es_afiliacion" = :afiliacion) AND');
          SQL.Add('("fun$afiliacion"."fecha" BETWEEN :fecha AND :fecha1) AND');
          SQL.Add('("fun$afiliacion"."id_convenio" = :id_convenio)AND');
          SQL.Add('("fun$afiliacion"."parentesco" = "fun$parentesco"."id_parentesco")');
          if DBOficina.KeyValue <> 111 then
          begin
          SQL.Add('and ("fun$afiliacion"."cod_oficina" = :oficina)');
          ParamByName('oficina').AsInteger := DBOficina.KeyValue;
          end;
          SQL.Add('order by "fun$oficinas"."cod_oficina","fun$afiliacion"."id_afiliacion"');
          //SQL.Add('order by "fun$oficinas"."cod_oficina","fun$afiliacion"."fecha"');
          ParamByName('afiliacion').AsSmallInt := Tipoa.ItemIndex;
          ParamByName('fecha').AsDate := fecha1.Date;
          ParamByName('fecha1').AsDate := fecha2.Date;
          try
             ParamByName('id_convenio').AsSmallInt := DBconvenio.KeyValue;
          except
          on e: Exception do
          begin
            MessageDlg('No ha Seleccionado un tipo de Convenio',mtError,[mbok],0);
            DBconvenio.SetFocus;
          end;
          end;
          Open;
          Last;
          First;
          if RecordCount = 0 then begin
            MessageDlg('No hay Registros Disponibles',mtInformation,[mbok],0);
            DBconvenio.SetFocus;
            Abort;
          end;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          if Tipoa.ItemIndex = 1 then
             frmProgresos.Titulo := 'Reporte de Tramites '
          else
             frmProgresos.Titulo := 'Reporte de Renovaciones ';
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            _sApellido1 := '';
            _sApellido2 := '';
            _sNombre1 := '';
            nombres := '';
            frmProgresos.Position := RecNo;
            frmProgresos.Infolabel := 'Elemento Numero: '+IntToStr(RecNo);
            Application.ProcessMessages;
            _sZona := DataQuerys.IBdatos.FieldByName('ZONA').AsString;
            if (FieldByName('es_local').AsInteger = 1) and (FieldByName('parentesco').AsInteger = 1) then
            begin
               cadena := DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString;
               s := StrLen(PChar(cadena));
               h := MidStr(cadena,s,1);
               if h = '/' then
                  cadena := LeftStr(cadena,s-1);

               with FrmQuerys.IBseleccion do
               begin
                 Close;
                 verificatransaccion(FrmQuerys.IBseleccion);
                 SQL.Clear;
                 SQL.Add('select * from "gen$persona"');
                 SQL.Add('where ID_PERSONA = :ID_PERSONA');
                 //SQL.Add('select * from BUSCA_PERSONA_N1 (:NIT)');
                 ParamByName('ID_PERSONA').AsString := cadena;
                 Open;
                 nombres := FieldByName('NOMBRE').AsString;
                 if Pos(' ', FieldByName('NOMBRE').AsString) > 0 then
                 begin
                   Nombres := Leftstr(FieldByName('NOMBRE').AsString,Pos(' ', FieldByName('NOMBRE').AsString)-1);
                   _sNombre1 := RightStr(FieldByName('NOMBRE').AsString,Length(FieldByName('NOMBRE').AsString) - Pos(' ', FieldByName('NOMBRE').AsString));
                 end;
                 _sMail := FieldByName('EMAIL').AsString;
                 _sApellido1 := FieldByName('PRIMER_APELLIDO').AsString;
                 _sApellido2 := FieldByName('SEGUNDO_APELLIDO').AsString;
                 fecha := FieldByName('FECHA_NACIMIENTO').AsString;
                 lugar_nit := FieldByName('LUGAR_EXPEDICION').AsString;
                 sexo := FieldByName('SEXO').AsString;
                 _iIdIdentificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
                 tipo_nit  := FieldByName('ID_IDENTIFICACION').AsString;
                 if tipo_nit = '1' then
                    tipo_nit := 'R.C'
                 else if tipo_nit = '2' then
                    tipo_nit := 'T.I'
                 else if tipo_nit = '3' then
                    tipo_nit := 'C.C'
                 else if tipo_nit = '8' then
                    tipo_nit := 'O'
                 else
                    tipo_nit := 'N';
                 id_persona := FieldByName('ID_PERSONA').AsString;
                 {SQL.Clear;
                 SQL.Add('select * from "gen$tiposidentificacion"');
                 SQL.Add('where ID_IDENTIFICACION = :ID_IDENTIFICACION');
                 ParamByName('ID_IDENTIFICACION').AsInteger := tipo_n ;
                 Open;
                 tipo_nit := FieldByName('DESCRIPCION_IDENTIFICACION').AsString;}
                 SQL.Clear;
                 SQL.Add('select * from "gen$direccion"');
                 SQL.Add('where ID_DIRECCION = 1 and ID_PERSONA = :ID_PERSONA');
                 ParamByName('ID_PERSONA').AsString := cadena;
                 Open;
                 direccion := FieldByName('DIRECCION').AsString;
                 barrio := FieldByName('BARRIO').AsString;
                 ciudad := FieldByName('MUNICIPIO').AsString;
                 telefono := FieldByName('TELEFONO1').AsString;
                 SQL.Clear;
                 if id_persona <> '' then
                 begin
                 SQL.Add('SELECT * FROM P_CAP_0008 (:ID_AGENCIA,:ID_TIPO_CAPTACION,:ID_IDENTIFICACION,:ID_PERSONA)');
                 ParamByName('ID_AGENCIA').AsInteger := DBoficina.KeyValue;
                 ParamByName('ID_TIPO_CAPTACION').AsInteger := 1;
                 ParamByName('ID_IDENTIFICACION').AsInteger := _iIdIdentificacion;
                 ParamByName('ID_PERSONA').AsString := cadena;
                 Open;
                 cuenta := FieldByName('NUMERO_CUENTA').AsString;
                 end;
                 {if tipo_nit = '1' then
                    tipo_nit := 'R.C'
                 else if tipo_nit = '3' then
                    tipo_nit := 'C.C'
                 else if tipo_nit = '2' then
                    tipo_nit := 'T.I'
                 else
                 tipo_nit := '3';}
               if id_persona = '' then buscar;
               end;
            end
            else
            begin
               if (FieldByName('parentesco').AsInteger = 1) then
               begin
                  with DataQuerys.IBFundacion do
                  begin
                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT');
                    SQL.Add('"fun$datos_asociado"."numero_cuenta"');
                    SQL.Add('FROM');
                    SQL.Add('"fun$datos_asociado"');
                    SQL.Add('WHERE');
                    SQL.Add('("fun$datos_asociado"."nit_asociado" = :nit)');
                    ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString;
                    Open;
                    cuenta := FieldByName('numero_cuenta').AsString;
                    Close;
                  end;
               end;
               with DataQuerys.IBselecion do
               begin
                 Close;
                 verificatransaccion(DataQuerys.IBselecion);
                 SQL.Clear;
                 SQL.Add('select * from BUSCA_BENE(:NIT)');
                 ParamByName('NIT').AsString := DataQuerys.IBdatos.fieldbyname('nit_beneficiario').AsString;
                 Open;
                 direccion := FieldByName('DIRECCION').AsString;
                 nombres := FieldByName('NOMBRES').AsString;
                 _sNombre1 := FieldByName('NOMBRE1').AsString;
                 _sApellido1 := FieldByName('APELLIDO1').AsString;
                 _sApellido2 := FieldByName('APELLIDO2').AsString;
                 _sMail := FieldByName('MAIL').AsString;
                 fecha := FieldByName('FECHA_NACIMIENTO').AsString;
                 barrio := FieldByName('BARRIO').AsString;
                 ciudad := FieldByName('MUNICIPIO').AsString;
                 telefono := FieldByName('TELEFONO').AsString;
                 estrato :=  FieldByName('ESTRATO').AsString;
                 tipo_nit := FieldByName('TIPO_ID').AsString;
                 if tipo_nit = '1' then
                    tipo_nit := 'C.C'
                 else if tipo_nit = '2' then
                    tipo_nit := 'T.I'
                 else if tipo_nit = '3' then
                    tipo_nit := 'P'
                 else if tipo_nit = '4' then
                    tipo_nit := 'R.C'
                 else if tipo_nit = '5' then
                    tipo_nit := 'O'
                 else
                    tipo_nit := 'N';
                 lugar_nit := FieldByName('LUGAR_ID').AsString;
                 sexo := FieldByName('SEXO').AsString;
                 no_entrada := FieldByName('NO_ENTRADA').AsInteger;
               end;
            end;
            if nombres = '' then nombres := '';
            if tipo_nit = '' then tipo_nit := 'C.C';

            if estrato = '' then estrato := IntToStr(no_estrato(DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString));

            if nombres = '' then
            conteo := conteo + 1;
            with CDafiliacion do
            begin
              Append;
              FieldValues['nombres'] := nombres;
              //***
              FieldValues['nombre1'] := _sNombre1;
              FieldValues['apellido1'] := _sApellido1;
              FieldValues['apellido2'] := _sApellido2;
              //**
              FieldValues['nit'] := DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString;
{              if tipo_nit = '1' then
                 tipo_nit := 'R.C'
              else if tipo_nit = '3' then
                 tipo_nit := 'C.C'
              else if tipo_nit = '2' then
                 tipo_nit := 'T.I'
              else
                 tipo_nit := '3';}
              FieldValues['tipo_nit'] := tipo_nit;
              FieldValues['lugar_nit'] := lugar_nit;
              FieldValues['parentesco'] := DataQuerys.IBdatos.FieldByName('descripcion').AsString;
              FieldValues['sexo'] := sexo;
              FieldValues['estrato'] := estrato;
              FieldValues['direccion'] := direccion;
              FieldValues['barrio'] := barrio;
              FieldValues['telefono'] := telefono;
              FieldValues['fecha_na'] := fecha;
              FieldValues['cuenta'] := cuenta;
              FieldValues['numero'] := DataQuerys.IBdatos.RecNo;
              FieldValues['ciudad'] := ciudad;
              FieldValues['ZONA'] := _sZona;
              FieldValues['MAIL'] := _sMail;
              FieldValues['carnet'] := busca_carnet(DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString,1,DBconvenio.KeyValue);
              FieldValues['descripcion'] := busca_carnet(DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString,2,DBconvenio.KeyValue);

              if valor_plan(DataQuerys.IBdatos.FieldByName('id_afiliacion').AsInteger) <> 0 then
              begin
                 FieldValues['valor_plan'] := FormatCurr('#,##0.0',valor_plan(DataQuerys.IBdatos.FieldByName('id_afiliacion').AsInteger));
                 valor_plan1 := valor_plan(DataQuerys.IBdatos.FieldByName('id_afiliacion').AsInteger) + valor_plan1;
              end
              else
                 FieldValues['valor_plan'] := '0,0';
                 FieldValues['fecha_a'] := DataQuerys.IBdatos.FieldByName('fecha').AsString;
                 FieldValues['plan'] := busca_plan(DataQuerys.IBdatos.FieldByName('id_afiliacion').AsInteger);
                 FieldValues['no_entrada'] := no_entrada;
                 FieldValues['eps'] := busca_eps(DataQuerys.IBdatos.FieldByName('nit_beneficiario').AsString);
                 FieldValues['es_local'] := DataQuerys.IBdatos.FieldByName('es_local').AsInteger;
                 FieldValues['cod_oficina'] := DataQuerys.IBdatos.FieldByName('cod_oficina').AsInteger;
                 FieldValues['des_oficina'] := DataQuerys.IBdatos.FieldByName('des_oficina').AsString;
              Post;
           end;
             cuenta := '';
             estrato := '';
            Next;
          end;
          Close;
          frmProgresos.Cerrar;
        end;
end;
procedure TFrmBeneficiario.Button7Click(Sender: TObject);
begin
        tramite
end;

procedure TFrmBeneficiario.FormCreate(Sender: TObject);
begin
        FrmQuerys := TFrmQuerys.Create(self);
        DataQuerys := TDataQuerys.Create(Self);
        verificatransaccion(IBconvenio);
        IBconvenio.Open;
        IBconvenio.Last;
        fecha1.Date := Date;
        fecha2.Date := Date;
       // fecha2.MaxDate := Date;
        fecha1.MaxDate := Date;
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$oficinas"."descripcion",');
          SQL.Add('"fun$oficinas"."cod_oficina"');
          SQL.Add('FROM');
          SQL.Add('"fun$oficinas"');
          Open;
          while not Eof do
          begin
             CDoficina.Append;
             CDoficina.FieldValues['cod_oficina'] := FieldByName('cod_oficina').AsInteger;
             CDoficina.FieldValues['oficina'] := FieldByName('descripcion').AsString;
             CDoficina.Post;
             Next;
          end;
             CDoficina.Append;
             CDoficina.FieldValues['cod_oficina'] := 111;
             CDoficina.FieldValues['oficina'] := 'GENERAL';
             CDoficina.Post;
        end;
        DBOficina.KeyValue := 111;
        DBconvenio.KeyValue := 1;
 end;

procedure TFrmBeneficiario.buscar;
begin
               with DataQuerys.IBselecion do
               begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select * from BUSCA_BENE(:NIT)');
                 ParamByName('NIT').AsString := DataQuerys.IBdatos.fieldbyname('nit_beneficiario').AsString;
                 Open;
                 direccion := FieldByName('DIRECCION').AsString;
                 nombres := FieldByName('NOMBRES').AsString;
                 fecha := FieldByName('FECHA_NACIMIENTO').AsString;
                 barrio := FieldByName('BARRIO').AsString;
                 ciudad := FieldByName('MUNICIPIO').AsString;
                 telefono := FieldByName('TELEFONO').AsString;
                 estrato :=  FieldByName('ESTRATO').AsString;
                 tipo_nit := FieldByName('TIPO_ID').AsString;
                 if tipo_nit = '1' then
                    tipo_nit := 'R.C'
                 else if tipo_nit = '3' then
                    tipo_nit := 'C.C'
                 else if tipo_nit = '2' then
                    tipo_nit := 'T.I'
                 else
                    tipo_nit := '3';
                 lugar_nit := FieldByName('LUGAR_ID').AsString;
                 sexo := FieldByName('SEXO').AsString;
               end;
end;

procedure TFrmBeneficiario.cmChildKey(var msg: TWMKEY);
begin
if msg.CharCode = VK_RETURN then
    if not (Assigned(ActiveControl) and
           ((ActiveControl is TButton) or
            (ActiveControl is TCustomMemo)))
    then begin
      msg.Result := 1;
      keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), 0, 0);
      Keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), KEYEVENTF_KEYUP, 0);
    end;
end;

procedure TFrmBeneficiario.SejecutarClick(Sender: TObject);
begin
        verificatransaccion(DataQuerys.IBingresa);
        if Panel1.Enabled then
        begin
         CDafiliacion.CancelUpdates;
         tipo_oficina := DBOficina.Text;
         tipo_afiliacion := Tipoa.Text;
         tipo_convenio := DBconvenio.Text;
         if opcion_beneficiario <> 1 then
            tramite
         else
            fechas_vencidas;
         if DBconvenio.KeyValue  <> 1 then
            DBGrid1.PopupMenu.AutoPopup := False
         else
            DBGrid1.PopupMenu.AutoPopup := True;
            Panel4.Enabled := False;
            Panel1.Enabled := False;
            Sejecutar.Caption := '&Otra Consulta';
            Sejecutar.Glyph.LoadFromFile(FrMain.wpath+'\Icon\buscar.bmp');
         end
         else
         begin
            CDafiliacion.CancelUpdates;
            Sejecutar.Caption := '&Ejecutar Consulta';
            Sejecutar.Glyph.LoadFromFile(FrMain.wpath+'\Icon\aceptar.bmp');
            Panel4.Enabled := True;
            Panel1.Enabled := True;
         end;

end;

procedure TFrmBeneficiario.SpeedButton2Click(Sender: TObject);
var      descripcion,descripcion1 :string;
begin
          opcion_reporte := 0;
          FrmTipo := TFrmTipo.Create(self);
          FrmTipo.tipo := 0;
          FrmTipo.ShowModal;
          if opcion_reporte = 2 then
          begin
            frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
            if DBconvenio.KeyValue = 1 then
            begin
               descripcion := tipo_afiliacion+' '+ FrMain.Empresa+' Y OTRAS COOPERATIVAS';
               descripcion1 := tipo_afiliacion+' '+ tipo_oficina;
              if Tipoa.ItemIndex = 0 then
                 PrAfiliacion.LoadTemplateFromFile(FrMain.wpath+'\reportes\reportesigloxxire.prt',False)
              else
                 PrAfiliacion.LoadTemplateFromFile(FrMain.wpath+'\reportes\reportesigloxxi.prt',False);
            end
            else if DBconvenio.KeyValue = 2 then
            begin
              descripcion := tipo_afiliacion +' '+ 'EN EL MES DE ' + formatdatetime('mmmm/yyyy',fecha2.Date);
              descripcion1 := tipo_afiliacion +' '+ 'EN EL MES DE ' + formatdatetime('mmmm/yyyy',fecha2.Date);
              PrAfiliacion.LoadTemplateFromFile(FrMain.wpath+'\reportes\reporteolivos.prt',False);
              PrAfiliacion.Variables.ByName['valor_plan'].AsString := FormatCurr('#,##0.0',valor_plan1);
              PrAfiliacion.Variables.ByName['convenio'].AsString := tipo_convenio;
            end
            else if DBconvenio.KeyValue = 3 then
            begin
                descripcion := 'RELACION DE '+tipo_afiliacion +'ES DESDE EL ' + formatdatetime('DD " DE " MMMM',fecha1.Date) + ' AL ' + FormatDateTime('DD " DE " MMMM " DE " YYYY',fecha2.date);
                descripcion := 'RELACION DE '+tipo_afiliacion +'ES DESDE EL ' + formatdatetime('DD " DE " MMMM',fecha1.Date) + ' AL ' + FormatDateTime('DD " DE " MMMM " DE " YYYY',fecha2.date);
                PrAfiliacion.LoadTemplateFromFile(FrMain.wpath+'\reportes\reporteequivida.prt',False);
                PrAfiliacion.Variables.ByName['valor_plan'].AsString := FormatCurr('#,##0.0',valor_plan1);
                PrAfiliacion.Variables.ByName['convenio'].AsString := tipo_convenio;
             end
            else if DBconvenio.KeyValue = 4 then
            begin
                descripcion := 'RELACION DE '+tipo_afiliacion +'ES DESDE EL ' + formatdatetime('DD " DE " MMMM',fecha1.Date) + ' AL ' + FormatDateTime('DD " DE " MMMM " DE " YYYY',fecha2.date);
                descripcion := 'RELACION DE '+tipo_afiliacion +'ES DESDE EL ' + formatdatetime('DD " DE " MMMM',fecha1.Date) + ' AL ' + FormatDateTime('DD " DE " MMMM " DE " YYYY',fecha2.date);
                PrAfiliacion.LoadTemplateFromFile(FrMain.wpath+'\reportes\reportefonoc.prt',False);
                PrAfiliacion.Variables.ByName['valor_plan'].AsString := FormatCurr('#,##0.0',valor_plan1);
                PrAfiliacion.Variables.ByName['convenio'].AsString := tipo_convenio;
            end;



// descripcion de reportes
            PrAfiliacion.Variables.ByName['empresa'].AsString := FrMain.Empresa;
            PrAfiliacion.Variables.ByName['hoy'].AsDateTime := Date;
            PrAfiliacion.Variables.ByName['empleado'].AsString := empleados(UpperCase(FrMain.Dbalias),2);
            PrAfiliacion.Variables.ByName['Nit'].AsString := FrMain.Nit;
            if DBoficina.KeyValue = 111 then
              PrAfiliacion.Variables.ByName['tramite'].AsString := descripcion
            else
              PrAfiliacion.Variables.ByName['tramite'].AsString := descripcion1;
            if PrAfiliacion.PrepareReport then
            begin
              frmVistaPreliminar.Reporte := PrAfiliacion;
              frmVistaPreliminar.ShowModal;
            end;
            end
            else if opcion_reporte = 1 then
            begin
              if DBconvenio.KeyValue = 1 then
              begin
                frDBDataSet1.DataSet := CDafiliacion;
                IBtiponit.Open;
                if Tipoa.ItemIndex = 1 then
                   imprimir_reporte(FrMain.wpath+'\reportes\repsigloxxia.frf')
                else
                   imprimir_reporte(FrMain.wpath+'\reportes\repsigloxxir.frf');
             end
             else if DBconvenio.KeyValue = 4 then
                   imprimir_reporte(FrMain.wpath+'\reportes\reportefonoc.frf')
             else if DBconvenio.KeyValue = 2 then
                   imprimir_reporte(FrMain.wpath+'\reportes\reportelosolivos.frf')
             else if DBconvenio.KeyValue = 3 then
                   imprimir_reporte(FrMain.wpath+'\reportes\reportelequivida.frf');
            end;
end;

{procedure TFrmBeneficiario.actuliza4;
var     total,comit :string;
        s :Integer;
begin
        comit := '0';
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$beneficiario"."identificacion"');
          SQL.Add('FROM');
          SQL.Add('"fun$beneficiario"');
          SQL.Add('WHERE');
          SQL.Add('("fun$beneficiario"."tipo_id" = 4)');
          SQL.Add('and "fun$beneficiario"."no_entrada" > 36772');
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Titulo := 'Actualizando Beneficiarios';
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            if Frac(RecNo/100) = 0 then
            begin
               verificatransaccion(DataQuerys.IBselecion);
               comit := CurrToStr(RecNo/100);
            end;
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Actualizacion No : '+IntToStr(RecNo)+#13+'Commit No : '+comit;
            Application.ProcessMessages;
            s := StrLen(PChar(FieldByName('identificacion').AsString));
            total := LeftStr(FieldByName('identificacion').AsString,s-1);
            with DataQuerys.IBselecion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('update "fun$afiliacion" set');
              SQL.Add('"fun$afiliacion"."nit_beneficiario" = :cadena');
              SQL.Add('where "fun$afiliacion"."nit_beneficiario" = :nit');
              ParamByName('nit').AsString := total;
              ParamByName('cadena').AsString := DataQuerys.IBdatos.fieldbyname('identificacion').AsString;
              Open;
              Close;
            end;
            Next;
          end;
          DataQuerys.IBselecion.Transaction.Commit;
          frmProgresos.Cerrar;
        end;
end;}

procedure TFrmBeneficiario.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
var     oficina :string;
begin
        if DBOficina.KeyValue = 111 then
           oficina := 'General'
        else
           oficina := 'Oficina: '+DBOficina.Text;
        if ParName = 'nit' then
           ParValue := FrMain.Nit;
        if ParName = 'oficina' then
           ParValue := oficina;
        if ParName = 'empresa' then
           ParValue := FrMain.Empresa;
        if ParName = 'reporte' then
           ParValue := UpCaseFirst(Tipoa.Text+'es');
        if ParName = 'fecha1' then
           ParValue := FormatDateTime('dd "de" mmm',fecha1.DateTime);
        if ParName = 'fecha2' then
           ParValue := FormatDateTime('dd "de" mmm',fecha2.DateTime);
        if ParName = 'ano' then
           ParValue := FormatDateTime('yyyy',fecha1.DateTime);
        if ParName = 'valor_plan' then
           ParValue := valor_plan1;
        if ParName = 'convenio' then
           ParValue := tipo_convenio;
end;

procedure TFrmBeneficiario.imprimir_reporte(cadena:string);
begin
        FrmImpresion := TFrmImpresion.Create(self);
        frReport1.LoadFromFile(cadena);
        frCompositeReport1.DoublePass := True;
        frCompositeReport1.Reports.Clear;
        frCompositeReport1.Reports.Add(frReport1);
        frReport1.Preview := FrmImpresion.frPreview1;
        frReport1.ShowReport;
        FrmImpresion.ShowModal
end;
procedure TFrmBeneficiario.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        ShowMessage('listo');
end;

function TFrmBeneficiario.busca_carnet(nit: string;opcion,id_programa:integer): string;
begin
        with DataQuerys.IBFundacion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          if opcion = 1 then
            SQL.Add('"fun$carnet"."no_carnet" as no_carnet')
          else
            SQL.Add('"fun$carnet"."descripcion" as no_carnet');
          SQL.Add('FROM');
          SQL.Add('"fun$carnet"');
          SQL.Add('WHERE');
          SQL.Add('("fun$carnet"."nit_beneficiario" = :nit) AND');
          SQL.Add('("fun$carnet"."programa" = :programa)');
          ParamByName('nit').AsString := nit;
          ParamByName('programa').AsInteger := id_programa;
          Open;
          Result := FieldByName('no_carnet').AsString;
          Close;
        end;
end;

procedure TFrmBeneficiario.fechas_vencidas;
var     h :string;
        s,consecutivo :Integer;
        cadena,nit_b :string;
        _sZona,_sMail :string;
begin
        consecutivo := 0;
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$afiliacion"."nit_beneficiario","fun$afiliacion"."ZONA"');
          SQL.Add('from "fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
           if DBOficina.KeyValue <> 111 then
          begin
            SQL.Add('and("fun$afiliacion"."cod_oficina" = :cod_oficina)');
            ParamByName('cod_oficina').AsInteger := DBOficina.KeyValue;
          end;
          SQL.Add('order by "fun$afiliacion"."id_afiliacion"');
          ParamByName('convenio').AsInteger := DBconvenio.KeyValue;
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Titulo := 'Reporte de Beneficiarios Vencidos';
          frmProgresos.Ejecutar;
          while not Eof do
          begin
             nit_b := FieldByName('nit_beneficiario').AsString;
             _sZona := FieldByName('ZONA').AsString;
             if validafecha(nit_b) = false then
             begin
              consecutivo := consecutivo + 1;
               //*********************
              frmProgresos.Position := RecNo;
              frmProgresos.Infolabel := 'Elemento Numero: '+IntToStr(consecutivo);
              Application.ProcessMessages;
              if (extraedatos(nit_b,6) = '1') and (extraedatos(nit_b,8) = '1') then
              begin
                 cadena := nit_b;
                 s := StrLen(PChar(cadena));
                 h := MidStr(cadena,s,1);
                 if h = '/' then
                    LeftStr(cadena,s-1);
                 with FrmQuerys.IBseleccion do
                 begin
                   Close;
                   verificatransaccion(FrmQuerys.IBseleccion);
                   SQL.Clear;
                   SQL.Add('select * from BUSCA_PERSONA_N1 (:NIT)');
                   ParamByName('NIT').AsString := cadena;
                   Open;
                   direccion := FieldByName('DIRECCION').AsString;
                   nombres := FieldByName('APELLIDO1').AsString+' '+FieldByName('APELLIDO2').AsString+' '+FieldByName('NOMBRES').AsString;
                   fecha := FieldByName('FECHA_NACIMIENTO').AsString;
                   barrio := FieldByName('BARRIO').AsString;
                   ciudad := FieldByName('MUNICIPIO').AsString;
                   telefono := FieldByName('TELEFONO').AsString;
                   lugar_nit := FieldByName('LUGAR_EXPEDICION').AsString;
                   sexo := FieldByName('SEXO').AsString;
                   cuenta := FieldByName('NUMERO_CUENTA').AsString;
                   tipo_nit := FieldByName('ID_IDENTIFICACION').AsString;
                   if tipo_nit = '1' then
                      tipo_nit := 'R.C'
                   else if tipo_nit = '3' then
                      tipo_nit := 'C.C'
                   else if tipo_nit = '2' then
                      tipo_nit := 'T.I'
                   else
                      tipo_nit := '3';
                    if FieldByName('ID_PERSONA').AsString = '' then buscar;
               end;
            end
            else
            begin
               if (extraedatos(nit_b,8) = '1') then
               begin
                  with DataQuerys.IBFundacion do
                  begin
                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT');
                    SQL.Add('"fun$datos_asociado"."numero_cuenta"');
                    SQL.Add('FROM');
                    SQL.Add('"fun$datos_asociado"');
                    SQL.Add('WHERE');
                    SQL.Add('("fun$datos_asociado"."nit_asociado" = :nit)');
                    ParamByName('nit').AsString := nit_b;
                    Open;
                    cuenta := FieldByName('numero_cuenta').AsString;
                    Close;
                  end;
               end;
               with DataQuerys.IBselecion do
               begin
                 Close;
                 verificatransaccion(DataQuerys.IBselecion);
                 SQL.Clear;
                 SQL.Add('select * from BUSCA_BENE(:NIT)');
                 ParamByName('NIT').AsString := nit_b;
                 Open;
                 direccion := FieldByName('DIRECCION').AsString;
                 nombres := FieldByName('NOMBRES').AsString;
                 fecha := FieldByName('FECHA_NACIMIENTO').AsString;
                 barrio := FieldByName('BARRIO').AsString;
                 ciudad := FieldByName('MUNICIPIO').AsString;
                 telefono := FieldByName('TELEFONO').AsString;
                 estrato :=  FieldByName('ESTRATO').AsString;
                 tipo_nit := FieldByName('TIPO_ID').AsString;
                 _sMail := FieldByName('MAIL').AsString;
                 if tipo_nit = '1' then
                    tipo_nit := 'R.C'
                 else if tipo_nit = '3' then
                    tipo_nit := 'C.C'
                 else if tipo_nit = '2' then
                    tipo_nit := 'T.I'
                 else
                 tipo_nit := '3';
                 lugar_nit := FieldByName('LUGAR_ID').AsString;
                 sexo := FieldByName('SEXO').AsString;
               end;
            end;
            if nombres = '' then nombres := 'd';
            if tipo_nit = '1' then
               tipo_nit := 'R.C'
            else if tipo_nit = '3' then
                 tipo_nit := 'C.C'
            else if tipo_nit = '2' then
                 tipo_nit := 'T.I'
            else
                 tipo_nit := '3';
            if estrato = '' then estrato := IntToStr(no_estrato(nit_b));
            if nombres = 'd' then
            conteo := conteo + 1;
            with CDafiliacion do
            begin
              Append;
              FieldValues['nombres'] := nombres;
              FieldValues['nit'] := nit_b;
              FieldValues['tipo_nit'] := tipo_nit;
              FieldValues['lugar_nit'] := lugar_nit;
              FieldValues['parentesco'] := extraedatos(nit_b,1);//DataQuerys.IBdatos.FieldByName('descripcion').AsString;
              FieldValues['sexo'] := sexo;
              FieldValues['estrato'] := estrato;
              FieldValues['direccion'] := direccion;
              FieldValues['barrio'] := barrio;
              FieldValues['telefono'] := telefono;
              FieldValues['fecha_na'] := fecha;
              FieldValues['cuenta'] := cuenta;
              FieldValues['numero'] := consecutivo;//DataQuerys.IBdatos.RecNo;
              FieldValues['ciudad'] := ciudad;
              FieldValues['carnet'] := busca_carnet(nit_b,1,DBconvenio.KeyValue);
              FieldValues['descripcion'] := busca_carnet(nit_b,2,DBconvenio.KeyValue);
              FIELDVALUES['zona'] := _sZona;
              FieldValues['mail'] := _sMAIL;
              if valor_plan(StrToInt(extraedatos(nit_b,5))) <> 0 then
              begin
                 FieldValues['valor_plan'] := FormatCurr('#,##0.0',valor_plan(StrToInt(extraedatos(nit_b,5))));
                 valor_plan1 := valor_plan(StrToInt(extraedatos(nit_b,5))) + valor_plan1;
              end
              else
                 FieldValues['valor_plan'] := '0';
                 FieldValues['fecha_a'] := extraedatos(nit_b,4);
                 FieldValues['plan'] := busca_plan(StrToInt(extraedatos(nit_b,5)));
                 FieldValues['eps'] := busca_eps(nit_b);
              Post;
           end;
          end;

          //end;
               //**********************
               cuenta := '';
               estrato := '';

               Next;
             end; //fin while
             Close;
          frmProgresos.Cerrar;
          end;// fin busca beneficiario
end;

        {SELECT
  MAX("fun$afiliacion"."fecha") AS FIELD_1,
  MAX("fun$afiliacion"."fecha_vencimiento") AS FIELD_2
FROM
  "fun$afiliacion"}


procedure TFrmBeneficiario.SpeedButton3Click(Sender: TObject);
begin
        Close;
       //Button2Click(Self); //actualizar titulares
       //Button4Click(Self);//actualiza beneficiarios
End;

procedure TFrmBeneficiario.exportar(archivo, cadena: string);
begin
        FrmImpresion := TFrmImpresion.Create(self);
        frReport1.LoadFromFile(cadena);
        frCompositeReport1.DoublePass := True;
        frCompositeReport1.Reports.Clear;
        frCompositeReport1.Reports.Add(frReport1);
        frReport1.Preview := FrmImpresion.frPreview1;
        frReport1.ShowReport;
        frReport1.ExportTo(FRexcel,archivo);
        //FrmImpresion.ShowModal
end;

procedure TFrmBeneficiario.ExportarDatos1Click(Sender: TObject);
begin
        if Dialogo.Execute then
        begin
          try
             if Tipoa.ItemIndex = 1 then
                 exportar(Dialogo.FileName,FrMain.wpath+'\reportes\repexportsxxi.frf')
             else
                 exportar(Dialogo.FileName,FrMain.wpath+'\reportes\repexportsxxire.frf');
          except
          on E: Exception do
             messagedlg('El Archivo Se Encuentra Abierto, Favor Cambie el Nombre del Archivo'+#10+#13+'Mensage: '+E.Message,mtError,[mbok],0);
       end;
          end;
end;

procedure TFrmBeneficiario.DBGrid1DblClick(Sender: TObject);
var _iTipo :Integer;
begin
        if (CDafiliacionparentesco.Value <> 'A. TITULAR') or  (CDafiliaciones_local.Value <> 1)  then
        begin
        FrmActualizarD := TFrmActualizarD.Create(self);
        with FrmActualizarD do
        begin
          TEnit.Text := CDafiliacionnit.Text;
          TEnombres.Text := CDafiliacionnombres.Text;
          TElugar.Text := CDafiliacionlugar_nit.Text;
           if CDafiliacionsexo.Text = 'M' then
              Csexo.ItemIndex := 0
           else if CDafiliacionsexo.Text = 'F' then
              Csexo.ItemIndex := 1
           else
           Csexo.ItemIndex := -1;
          DBparentesco.Text := CDafiliacionparentesco.Text;
          TEestrato.Text := CDafiliacionestrato.Text;
          DTfecha.Text := CDafiliacionfecha_na.Text;
          TECiudad.Text := CDafiliacionciudad.Text;
          TEBarrio.Text := CDafiliacionbarrio.Text;
          nombre1.Text := CDafiliacionnombre1.Text;
          apellido1.Text := CDafiliacionapellido1.Text;
          apellido2.Text := CDafiliacionapellido2.Text;
          DBGrid1.Canvas.Brush.Color := clAqua;
          DBGrid1.Canvas.Lock;
          try
            if CDafiliaciontipo_nit.Value = 'R.C' then
               _iTipo := 4
            else if CDafiliaciontipo_nit.Value = 'C.C' then
               _iTipo := 1
            else if CDafiliaciontipo_nit.Value = 'T.I' then
               _iTipo := 2
            else if CDafiliaciontipo_nit.Value = 'P' then
               _iTipo := 3
            else if CDafiliaciontipo_nit.Value = 'O' then
               _iTipo := 5
            else
               _iTipo := 3;
            DBTipoNit.KeyValue := _iTipo;
          except
            Exit;
          end;
          TEdireccion.Text := CDafiliaciondireccion.Text;
          TEtelefono.Text := CDafiliaciontelefono.Text;
          if CDafiliacionnombres.Text <> '' then
             control_actualizacion := False
          else
             control_actualizacion := True;
          ShowModal;
        end;
        end;
end;

procedure TFrmBeneficiario.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   if controlcolor then
   begin
   with DBGrid1 do begin
       if not (gdSelected in State) then begin
         if DataSource.DataSet.FieldByName('numero').AsString = IntToStr(numerocolor)  then
           Canvas.Brush.Color := clAqua;
       end;
       DefaultDrawColumnCell(Rect, DataCol, Column, State)
     end;
   end;
end;

function TFrmBeneficiario.extraedatos(nit: string;
  opcion: integer): string;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          case opcion of
            1: SQL.Add('"fun$parentesco"."descripcion" as total');
            2: SQL.Add('"fun$afiliacion"."nit_beneficiario" as total');
            3: SQL.Add('"fun$afiliacion"."id_convenio" as total');
            4: SQL.Add('"fun$afiliacion"."fecha" as total');
            5: SQL.Add('"fun$afiliacion"."id_afiliacion" as total');
            6: SQL.Add('"fun$afiliacion"."es_local" as total');
            7: SQL.Add('"fun$afiliacion"."fecha_vencimiento" as total');
            8: SQL.Add('"fun$afiliacion"."parentesco" as total');
          end;
          SQL.Add('FROM');
          SQL.Add('"fun$parentesco",');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."parentesco" = "fun$parentesco"."id_parentesco") AND');
          SQL.Add('("fun$afiliacion"."nit_beneficiario" = :nit )AND');
          SQL.Add('("fun$afiliacion"."fecha" = (select max("fun$afiliacion"."fecha")');
          SQL.Add('from "fun$afiliacion"');
          SQL.Add('where "fun$afiliacion"."nit_beneficiario" = :nit))');
          ParamByName('nit').AsString := nit;
          Open;
          Result := FieldByName('total').AsString;
          Close;
        end;
end;


function TFrmBeneficiario.no_estrato(nit: string): integer;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$beneficiario"."estrato"');
          SQL.Add('FROM');
          SQL.Add('"fun$beneficiario"');
          SQL.Add('INNER JOIN "fun$afiliacion" ON ("fun$beneficiario"."identificacion" = "fun$afiliacion"."nit_beneficiario")');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."nit_asociado" = :nit) AND');
          SQL.Add('("fun$beneficiario"."estrato" IS NOT NULL)');
          ParamByName('nit').AsString := nit;
          Open;
          if FieldByName('estrato').AsInteger = 0 then
             Result := 2
          else
             Result := FieldByName('estrato').AsInteger
        end;
end;

end.
