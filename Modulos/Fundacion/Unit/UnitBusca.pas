unit UnitBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,unitconvenios, Mask, Buttons, DB, Grids,
  DBGrids, DBClient, IBCustomDataSet, IBQuery, pr_Common, pr_TxClasses,
  ComCtrls,StrUtils;

type
  TFrmBuscar = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cbusqueda: TComboBox;
    TEfiltro: TEdit;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    TEnombre: TEdit;
    Label8: TLabel;
    TEestrato: TEdit;
    Panel3: TPanel;
    Label6: TLabel;
    Label10: TLabel;
    TEdireccion: TEdit;
    Label9: TLabel;
    Label11: TLabel;
    TEciudad: TEdit;
    TEtelefono: TEdit;
    Label12: TLabel;
    TEidentificacion: TEdit;
    CHcriterio: TCheckBox;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    Panel5: TPanel;
    Label13: TLabel;
    DSprograma: TDataSource;
    CDprograma: TClientDataSet;
    DBprograma: TDBGrid;
    CDprogramaprograma: TStringField;
    CDprogramafecha: TStringField;
    BTActualiza: TBitBtn;
    CDcheques: TIBQuery;
    TEbarrio: TEdit;
    report1: TprTxReport;
    PRcheques: TprTxReport;
    Mfecha: TMaskEdit;
    CDprogramanit_asociado: TStringField;
    CDprogramafecha_a: TDateField;
    BTconvenio: TSpeedButton;
    BitBtn2: TSpeedButton;
    CDprogramaconvenio: TIntegerField;
    procedure TEfiltroExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure cbusquedaExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BTActualizaClick(Sender: TObject);
    procedure BTconvenioClick(Sender: TObject);
    procedure DBprogramaDblClick(Sender: TObject);
  private
  no_entrada :Integer;
    function fecha(nit: string): tdate;
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    procedure buscar(opcion: integer);
    procedure convenio;
    procedure limpia;
    procedure cheques;
    procedure actuliza_datos;
    { Public declarations }
  end;

var
  FrmBuscar: TFrmBuscar;

implementation

uses UnitQuerys,Unitglobal, UnitdataQuerys,unitdata, UnitPrincipal,unitvistapreliminar,
  UnitGrupo, UnitPantallaProgreso;

{$R *.dfm}

procedure TFrmBuscar.cmChildKey(var msg: TWMKEY);
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

procedure TFrmBuscar.buscar(opcion: integer);
var     h :string;
        s :Integer;
begin
        if opcion = 1 then
        begin
          s := StrLen(PChar(TEfiltro.Text));
          h := MidStr(TEfiltro.Text,s,1);
          if h = '/' then
             TEfiltro.Text := LeftStr(TEfiltro.Text,s-1);
          with FrmQuerys.IBseleccion do
          begin
            Close;
            verificatransaccion(FrmQuerys.IBseleccion);
            SQL.Clear;
            SQL.Add('select * from "gen$persona"');
            SQL.Add('where ID_PERSONA = :ID_PERSONA');
            ParamByName('ID_PERSONA').AsString := TEfiltro.Text;
            Open;
            TEnombre.Text := FieldByName('PRIMER_APELLIDO').AsString+' '+FieldByName('SEGUNDO_APELLIDO').AsString+' '+FieldByName('NOMBRE').AsString;
            TEidentificacion.Text := FieldByName('ID_PERSONA').AsString;
            Mfecha.Text := FieldByName('FECHA_NACIMIENTO').AsString;
            SQL.Clear;
            SQL.Add('SELECT * FROM "gen$direccion"');
            SQL.Add('where ID_PERSONA = :ID_PERSONA and');
            SQL.Add('ID_DIRECCION = 1');
            ParamByName('ID_PERSONA').AsString := TEfiltro.Text;            
            Open;
            TEdireccion.Text := FieldByName('DIRECCION').AsString;
            TEbarrio.Text := FieldByName('BARRIO').AsString;
            TEciudad.Text := FieldByName('MUNICIPIO').AsString;
            TEtelefono.Text := FieldByName('TELEFONO1').AsString;
            Close;
          end;
          end
          else if opcion = 2 then
          begin
            with DataQuerys.IBdatos do
            begin
              Close;
              verificatransaccion(DataQuerys.IBdatos);
              SQL.Clear;
              SQL.Add('select * from BUSCA_BENE(:NIT)');
              ParamByName('NIT').AsString := TEfiltro.Text;
              Open;
              TEdireccion.Text := FieldByName('DIRECCION').AsString;
              TEidentificacion.Text := FieldByName('ID_PERSONA').AsString;
              TEnombre.Text := FieldByName('NOMBRES').AsString;
              Mfecha.Text := FieldByName('FECHA_NACIMIENTO').AsString;
              TEbarrio.Text := FieldByName('BARRIO').AsString;
              TEciudad.Text := FieldByName('MUNICIPIO').AsString;
              TEtelefono.Text := FieldByName('TELEFONO').AsString;
              TEestrato.Text :=  FieldByName('ESTRATO').AsString;
              no_entrada := FieldByName('NO_ENTRADA').AsInteger;
              Close;
            end;
          end
          else if opcion = 3 then
          begin
          with FrmQuerys.IBseleccion do
          begin
            Close;
            verificatransaccion(FrmQuerys.IBseleccion);
            SQL.Clear;
            SQL.Add('select * from BUSCA_PERSONA (:NOMBRE)');
            ParamByName('NOMBRE').AsString := '%'+TEfiltro.Text+'%';
            Open;
            TEdireccion.Text := FieldByName('DIRECCION').AsString;
            TEidentificacion.Text := FieldByName('ID_PERSONA').AsString;
            TEnombre.Text := FieldByName('APELLIDO1').AsString+' '+FieldByName('APELLIDO2').AsString+' '+FieldByName('NOMBRES').AsString;
            Mfecha.Text := FieldByName('FECHA_NACIMIENTO').AsString;
            TEbarrio.Text := FieldByName('BARRIO').AsString;
            TEciudad.Text := FieldByName('MUNICIPIO').AsString;
            TEtelefono.Text := FieldByName('TELEFONO').AsString;
            Close;
          end;
        end
        else if opcion = 4 then
        begin
          with DataQuerys.IBdatos do
          begin
            Close;
            verificatransaccion(DataQuerys.IBdatos);
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"fun$beneficiario"."nombres",');
            SQL.Add('"fun$beneficiario"."identificacion",');
            SQL.Add('"fun$beneficiario"."estrato",');
            SQL.Add('"fun$beneficiario"."barrio",');
            SQL.Add('"fun$beneficiario"."direccion",');
            SQL.Add('"fun$beneficiario"."telefono",');
            SQL.Add('"fun$beneficiario"."fecha_nacimiento",');
            SQL.Add('"fun$beneficiario"."no_entrada",');
            SQL.Add('"fun$beneficiario"."ciudad"');
            SQL.Add('FROM');
            SQL.Add('"fun$beneficiario"');
            SQL.Add('WHERE');
            SQL.Add('("fun$beneficiario"."nombres" like :NOMBRE)');
            ParamByName('NOMBRE').AsString := '%'+TEfiltro.Text+'%';
            Open;
            TEdireccion.Text := FieldByName('direccion').AsString;
            TEidentificacion.Text := FieldByName('identificacion').AsString;
            TEnombre.Text := FieldByName('nombres').AsString;
            Mfecha.Text := FieldByName('FECHA_NACIMIENTO').AsString;
            TEbarrio.Text := FieldByName('barrio').AsString;
            TEciudad.Text := FieldByName('ciudad').AsString;
            TEtelefono.Text := FieldByName('telefono').AsString;
            TEestrato.Text :=  FieldByName('estrato').AsString;
            no_entrada := FieldByName('NO_ENTRADA').AsInteger;
            Close;
          end;
        end;
end;

procedure TFrmBuscar.TEfiltroExit(Sender: TObject);
begin
//        CDgrupo.CancelUpdates;
        if CHcriterio.Checked then
           BTActualiza.Enabled := False
        else
           BTActualiza.Enabled := True;
        CDprograma.CancelUpdates;
        if (cbusqueda.ItemIndex <> -1) and (TEfiltro.Text <> '') then
        begin
          if (cbusqueda.ItemIndex = 0) and (CHcriterio.Checked) then
             buscar(1)
          else if (cbusqueda.ItemIndex = 0) and (CHcriterio.Checked = false) then
             buscar(2)
          else if (cbusqueda.ItemIndex = 1) and (CHcriterio.Checked) then
             buscar(3)
          else if (cbusqueda.ItemIndex = 1) and (CHcriterio.Checked = false) then
             buscar(4);
          //convenio;
          if TEnombre.Text = '' then
          begin
            MessageDlg('Intente de Nuevo la Busqueda no Arrojo Resultados',mtWarning,[Mbok],0);
            cbusqueda.SetFocus;
          end;
        end
        else
        begin
          MessageDlg('Debe Selecionar un Tipo de Busqueda',mtWarning,[mbok],0);
          cbusqueda.SetFocus;
        end;
end;

procedure TFrmBuscar.FormCreate(Sender: TObject);
begin
        FrmQuerys := TFrmQuerys.Create(self);
        DataQuerys := TDataQuerys.Create(self);
end;
procedure TFrmBuscar.convenio;
begin
        if TEidentificacion.Text  <> '' then
        begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$convenios"."descripcion",');
          SQL.Add('"fun$convenios"."id_convenio"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('INNER JOIN "fun$convenios" ON ("fun$afiliacion"."id_convenio" = "fun$convenios"."id_convenio")');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."nit_beneficiario" = :nit)');
          ParamByName('nit').AsString := TEidentificacion.Text;
          Open;
            while not Eof do
            begin
              with DataQuerys.IBselecion do
              begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT');
                SQL.Add('MAX("fun$afiliacion"."fecha_vencimiento") AS fecha,');
                SQL.Add('MAX("fun$afiliacion"."id_afiliacion") AS id_afiliacion,');
                SQL.Add('MAX("fun$afiliacion"."fecha") AS fecha_a');
                SQL.Add('FROM');
                SQL.Add('"fun$afiliacion"');
                SQL.Add('WHERE');
                SQL.Add('("fun$afiliacion"."nit_beneficiario" = :nit) AND');
                SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
                ParamByName('nit').AsString := TEidentificacion.Text;
                ParamByName('convenio').AsString := DataQuerys.IBdatos.FieldByName('id_convenio').AsString;
                Open;
                with DataQuerys.IBingresa do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT DISTINCT');
                  SQL.Add('"fun$afiliacion"."nit_asociado",');
                  SQL.Add('"fun$afiliacion"."id_afiliacion"');
                  SQL.Add('FROM');
                  SQL.Add('"fun$afiliacion"');
                  SQL.Add('WHERE');
                  SQL.Add('("fun$afiliacion"."id_convenio" = :convenio) AND');
                  SQL.Add('("fun$afiliacion"."nit_beneficiario" = :bene) AND');
                  SQL.Add('("fun$afiliacion"."fecha" = :fecha)');
                  ParamByName('convenio').AsInteger := DataQuerys.IBdatos.FieldByName('id_convenio').AsInteger;
                  ParamByName('bene').AsString := TEidentificacion.Text;
                  ParamByName('fecha').AsDateTime:= DataQuerys.IBselecion.FieldByName('fecha').AsDateTime;
                  Open;
              end;
                CDprograma.Append;
                CDprograma.FieldValues['programa'] := DataQuerys.IBdatos.FieldByName('descripcion').AsString;
                CDprograma.FieldValues['convenio'] := DataQuerys.IBdatos.FieldByName('id_convenio').AsInteger;                
                CDprograma.FieldValues['fecha'] := FormatDateTime('yyyy/mm/dd',FieldByName('fecha').AsDateTime);
                CDprograma.FieldValues['fecha_a'] := DataQuerys.IBselecion.FieldByName('fecha_a').AsDateTime;
                CDprograma.FieldValues['nit_asociado'] := DataQuerys.IBingresa.FieldByName('nit_asociado').AsString;
                CDprograma.Post;
              end;
              Next;
            end;
          end;
        end;
end;

procedure TFrmBuscar.limpia;
begin
        cbusqueda.ItemIndex := -1;
        CHcriterio.Checked := False;
        TEfiltro.Text := '';
        TEnombre.Text := '';
        TEidentificacion.Text := '';
        TEestrato.Text := '';
        Mfecha.Text := '';
        TEbarrio.Text := '';
        TEtelefono.Text := '';
        TEdireccion.Text := '';
        TEciudad.Text := '';
        CDprograma.CancelUpdates;
        cbusqueda.SetFocus;
end;

procedure TFrmBuscar.BitBtn1Click(Sender: TObject);
begin
        limpia;
end;

procedure TFrmBuscar.cbusquedaExit(Sender: TObject);
begin
        if cbusqueda.ItemIndex = 0 then
           TEfiltro.MaxLength := 15
        else
           TEfiltro.MaxLength := 150;
end;

procedure TFrmBuscar.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmBuscar.cheques;
begin
        FrmQuerys := TFrmQuerys.Create(Self);
        frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
        with CDcheques do
        begin
           Close;
           verificatransaccion(FrmQuerys.IBseleccion);
           SQL.Clear;
           SQL.Add('SELECT DISTINCT');
           SQL.Add('"gen$agencia".DESCRIPCION_AGENCIA,');
           SQL.Add('"gen$agencia".ID_AGENCIA,');
           SQL.Add('"gen$bancos".DESCRIPCION ,');
           SQL.Add('"tes$cheques".NUMERO_CHEQUE,');
           SQL.Add('"tes$cheques".NUMERO_CUENTA,');
           SQL.Add('"tes$cheques".VALOR,');
           SQL.Add('"tes$cheques".FECHA_CONSIGNADO,');
           SQL.Add('"tes$cheques".PLAZA');
           SQL.Add('FROM');
           SQL.Add('"tes$cheques"');
           SQL.Add('LEFT OUTER JOIN "gen$bancos" ON ("tes$cheques".ID_BANCO = "gen$bancos".ID_BANCO)');
           SQL.Add('LEFT OUTER JOIN "gen$agencia" ON ("tes$cheques".ID_AGENCIA = "gen$agencia".ID_AGENCIA)');
           SQL.Add('WHERE');
           SQL.Add('("tes$cheques".LIBERADO = 0)');
           SQL.Add('ORDER BY');
           SQL.Add('"tes$cheques".PLAZA');
           Open;
           Last;
           First;
              PRcheques.Variables.ByName['empresa'].AsString := FrMain.Empresa;
              PRcheques.Variables.ByName['hoy'].AsDateTime := Date;
              PRcheques.Variables.ByName['Empleado'].AsString := empleados(UpperCase(FrMain.Dbalias),1);
              PRcheques.Variables.ByName['Nit'].AsString := FrMain.Nit;
              if prcheques.PrepareReport then
               begin
                 frmVistaPreliminar.Reporte := PRcheques;
                 frmVistaPreliminar.ShowModal;
               end;
           Close;
        end;
end;

procedure TFrmBuscar.actuliza_datos;
begin
        
end;

procedure TFrmBuscar.BTActualizaClick(Sender: TObject);
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update "fun$beneficiario" set');
          SQL.Add('"fun$beneficiario"."nombres" = :nombres,');
          SQL.Add('"fun$beneficiario"."identificacion" = :identificacion,');
          SQL.Add('"fun$beneficiario"."estrato" = :estrato,');
          SQL.Add('"fun$beneficiario"."direccion" = :direccion,');
          SQL.Add('"fun$beneficiario"."barrio" = :barrio,');
          SQL.Add('"fun$beneficiario"."telefono" = :telefono,');
          SQL.Add('"fun$beneficiario"."fecha_nacimiento" = :fecha_nacimiento,');
          SQL.Add('"fun$beneficiario"."ciudad" = :ciudad');
          SQL.Add('where "fun$beneficiario"."no_entrada" = :no_entrada');
          ParamByName('no_entrada').AsInteger := no_entrada;
          ParamByName('nombres').AsString := TEnombre.Text;
          ParamByName('identificacion').AsString := TEidentificacion.Text;
          ParamByName('estrato').AsString := TEestrato.Text;
          ParamByName('direccion').AsString := TEdireccion.Text;
          ParamByName('barrio').AsString := TEbarrio.Text;
          ParamByName('telefono').AsString := TEtelefono.Text;
          ParamByName('fecha_nacimiento').AsString := Mfecha.Text;
          ParamByName('ciudad').AsString := TEciudad.Text;
          Open;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmBuscar.BTconvenioClick(Sender: TObject);
begin
        CDprograma.CancelUpdates;
        convenio;
end;

procedure TFrmBuscar.DBprogramaDblClick(Sender: TObject);
var     nit_asociado,nit,nombres,parentesco :string;
        id_afilia :Integer;
begin
        FrmGrupo := TFrmGrupo.Create(self);
        FrmGrupo.CDgrupo.CancelUpdates;
        with DataQuerys.IBdatos do
        begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT');
           SQL.Add('"fun$afiliacion"."nit_asociado"');
           SQL.Add('FROM');
           SQL.Add('"fun$afiliacion"');
           SQL.Add('WHERE');
           SQL.Add('("fun$afiliacion"."nit_beneficiario" = :nit) AND');
           SQL.Add('("fun$afiliacion"."id_convenio" = :convenio) ');
           ParamByName('nit').AsString := TEidentificacion.Text;
           ParamByName('convenio').AsInteger := CDprogramaconvenio.AsInteger;
           Open;
           Last;
           nit_asociado := FieldByName('nit_asociado').AsString;
           SQL.Clear;
           SQL.Add('select max("fun$afiliacion"."id_afiliacion") as id_afilia from "fun$afiliacion"');
           SQL.Add('where "fun$afiliacion"."nit_asociado" = :nit_asociado');
           ParamByName('nit_asociado').AsString := nit_asociado;
           Open;
           First;
           id_afilia := FieldByName('id_afilia').AsInteger - 10;
           Close;
        end;
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$afiliacion"."nit_beneficiario","fun$afiliacion"."parentesco"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."nit_asociado" = :nit) AND');
          SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
          //SQL.Add('AND ("fun$afiliacion"."id_afiliacion" >= :id_afilia)');
          SQL.Add('order by "parentesco"');
          //ParamByName('id_afilia').AsInteger := id_afilia;
          ParamByName('nit').AsString := nit_asociado;
          ParamByName('convenio').AsInteger := CDprogramaconvenio.AsInteger;
          Open;
          Last;
          First;
          frmprogresos := TfrmProgresos.Create(self);
          frmProgresos.Titulo := 'Espere un Momento...  Cargando Grupo Familiar';
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            parentesco := '';
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Beneficiario No : '+IntToStr(RecNo);
            Application.ProcessMessages;
            nit := FieldByName('nit_beneficiario').AsString;
            with DataQuerys.IBdatos do
            begin
              Close;
              verificatransaccion(DataQuerys.IBdatos);
              SQL.Clear;
              SQL.Add('SELECT distinct');
              SQL.Add('"fun$beneficiario"."nombres",');
              SQL.Add('"fun$afiliacion"."nit_beneficiario",');
              SQL.Add('"fun$parentesco"."descripcion"');
              SQL.Add('FROM');
              SQL.Add('"fun$afiliacion"');
              SQL.Add('INNER JOIN "fun$parentesco" ON ("fun$afiliacion"."parentesco" = "fun$parentesco"."id_parentesco")');
              SQL.Add('LEFT OUTER JOIN "fun$beneficiario" ON ("fun$afiliacion"."nit_beneficiario" = "fun$beneficiario"."identificacion")');
              SQL.Add('WHERE');
              SQL.Add('("fun$afiliacion"."nit_beneficiario" = :nit_beneficiario) and');
              SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
              ParamByName('nit_beneficiario').AsString := nit;
              ParamByName('convenio').AsSmallInt := CDprogramaconvenio.AsInteger;
              Open;
              Last;
              nombres := FieldByName('nombres').AsString;
              parentesco := FieldByName('descripcion').AsString;
            end;
            if (nombres = '') and (nit <> '') then
            begin
              with FrmQuerys.IBseleccion do
              begin
                Close;
                SQL.Clear;
                SQL.Add('select * from BUSCA_PERSONA_N1(:NIT)');
                ParamByName('NIT').AsString := nit;
                Open;
                nombres := FieldByName('APELLIDO1').AsString + ' ' +FieldByName('APELLIDO2').AsString + ' ' +FieldByName('NOMBRES').AsString;
                Close;
              end;
          end;
          with FrmGrupo.CDgrupo do
          begin
            Append;
            FieldValues['documento'] := nit;
            FieldValues['nombres'] := nombres;
            FieldValues['programa'] := CDprogramaconvenio.AsInteger;
            FieldValues['parentesco'] := parentesco;
            FieldValues['eps'] := busca_eps(nit);
            FieldValues['carnet'] := buscar_carnet(nit,CDprogramaconvenio.AsInteger,1);
            FieldValues['fecha'] := fecha(nit);
            Post;
          end;
          nombres := '';
          Next;
        end;
        end;
        frmProgresos.Cerrar;
        FrmGrupo.ShowModal;
        FrmGrupo.Free;
end;

function TFrmBuscar.fecha(nit: string): tdate;
begin
        with DataQuerys.IBFundacion do
        begin
           Close;
           verificatransaccion(DataQuerys.IBFundacion);
           SQL.Clear;
           SQL.Add('select max("fun$afiliacion"."fecha") as fecha from "fun$afiliacion"');
           SQL.Add('where "fun$afiliacion"."nit_beneficiario" = :nit');
           ParamByName('nit').AsString := nit;
           Open;
           Result := FieldByName('fecha').AsDateTime;
           Close;
           Transaction.Commit;
        end;
end;

end.
