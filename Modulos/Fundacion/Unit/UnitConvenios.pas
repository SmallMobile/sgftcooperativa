unit UnitConvenios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Grids, DBGrids, DB, DBClient,
  Buttons, IBCustomDataSet, IBQuery;

type
  TFrmConvenio = class(TForm)
    PageControl1: TPageControl;
    TabEntidad: TTabSheet;
    Label2: TLabel;
    TEntidad: TEdit;
    Label3: TLabel;
    TMdescripcion: TMemo;
    Label5: TLabel;
    Label7: TLabel;
    TECiudad: TEdit;
    Dfecha: TDateTimePicker;
    Label8: TLabel;
    Label6: TLabel;
    TEDireccion: TEdit;
    TETelefono: TEdit;
    Panel1: TPanel;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    BACEPTAR: TBitBtn;
    TabParametro: TTabSheet;
    Ctablaparametro: TClientDataSet;
    DBparametros: TDBGrid;
    BitBtn1: TBitBtn;
    Ctablaparametroid_convenio: TIntegerField;
    Ctablaparametroparentesco: TIntegerField;
    Ctablaparametrodefinicion: TStringField;
    Ctablaparametroparametro: TStringField;
    Ctablaparametrovalor: TStringField;
    DSparametro: TDataSource;
    Ctablaparametroid_parametro: TSmallintField;
    IBparentesco: TIBQuery;
    Ctablaparametroparentesco1: TStringField;
    TabPlanes: TTabSheet;
    CDplanes: TClientDataSet;
    CDplanesid_plan: TSmallintField;
    CDplanesid_convenio: TSmallintField;
    CDplanesdescripcion: TStringField;
    CDplanesperiodo: TSmallintField;
    DSplanes: TDataSource;
    DBplanes: TDBGrid;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    TEdirector: TEdit;
    Label4: TLabel;
    TElocal: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure TabParametroEnter(Sender: TObject);
    procedure TEntidadExit(Sender: TObject);
    procedure CtablaparametroparentescoValidate(Sender: TField);
    procedure CtablaparametroBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CDplanesdescripcionValidate(Sender: TField);
    procedure TMdescripcionKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure TMdescripcionExit(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure TETelefonoExit(Sender: TObject);
  private
  id_parametro,id_convenio,id_plan :Smallint;
    procedure registrar;
    procedure limpiar;
    { Private declarations }

  public
  opcion_fecha : Boolean;
  published
  procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;

    { Public declarations }
  end;

var
  FrmConvenio: TFrmConvenio;

implementation
uses UnitDatamodulo,Unitprograma,unitdata, UnitQuerys,UnitGlobal, Unittipo;
{$R *.dfm}


procedure TFrmConvenio.cmChildKey(var msg: TWMKEY);
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

procedure TFrmConvenio.FormCreate(Sender: TObject);

begin
        DataQuerys := TDataQuerys.Create(self);
        IBparentesco.Open;
        Ctablaparametro.Active := True;
        Dfecha.Date := Date;
        Dfecha.MaxDate := Date;
end;

procedure TFrmConvenio.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmConvenio.BitBtn1Click(Sender: TObject);
begin
        try
          Ctablaparametro.Delete;
        except
        on E: Exception do
          MessageDlg('No Existen Campos Para Eliminar',mtWarning,[mbok],0);
        end;
end;

procedure TFrmConvenio.TabParametroEnter(Sender: TObject);
begin
        DBparametros.SetFocus;
end;

procedure TFrmConvenio.TEntidadExit(Sender: TObject);
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('MAX("fun$parametros"."id_parametro") AS "parametro"');
          SQL.Add('FROM');
          SQL.Add('"fun$parametros"');
          Open;
          id_parametro := FieldByName('parametro').AsInteger;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('MAX("fun$convenios"."id_convenio") AS "convenio"');
          SQL.Add('FROM');
          SQL.Add('"fun$convenios"');
          Open;
          id_convenio := FieldByName('convenio').AsInteger + 1;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('MAX("fun$planes"."id_plan") AS "plan"');
          SQL.Add('FROM');
          SQL.Add('"fun$planes"');
          Open;
          id_plan := FieldByName('plan').AsInteger;
          Close;
        end;
end;

procedure TFrmConvenio.CtablaparametroparentescoValidate(Sender: TField);
begin
        id_parametro := id_parametro + 1;
        Ctablaparametroid_parametro.Value := id_parametro;
        Ctablaparametroid_convenio.Value := id_convenio;
end;

procedure TFrmConvenio.CtablaparametroBeforePost(DataSet: TDataSet);
begin
        if (Ctablaparametrovalor.Text = '') then
            Ctablaparametrovalor.Text := '0';
        if  Ctablaparametroparametro.Text = '' Then
            Ctablaparametroparametro.Text := 'NINGUNO';
        if (Ctablaparametroparentesco.Text = '')or (Ctablaparametrodefinicion.Text = '') then
        begin
           MessageDlg('Faltan Datos Importantes Por Registrar',mtError,[mbok],0);
           Exit;
        end;
end;

procedure TFrmConvenio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        Ctablaparametro.CancelUpdates;
end;

procedure TFrmConvenio.CDplanesdescripcionValidate(Sender: TField);
begin
        id_plan := id_plan + 1;
        CDplanesid_plan.Value := id_plan;
        CDplanesid_convenio.Value := id_convenio;
end;

procedure TFrmConvenio.TMdescripcionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           TEdirector.SetFocus
end;

procedure TFrmConvenio.BitBtn2Click(Sender: TObject);
begin
        try
          CDplanes.Delete;
        except
        on E: Exception do
          MessageDlg('No Existen Campos Para Eliminar',mtWarning,[mbok],0);
        end;
end;

procedure TFrmConvenio.TMdescripcionExit(Sender: TObject);
begin
        TMdescripcion.Text := UpperCase(TMdescripcion.Text);
        TabParametro.Enabled := True;
        TabPlanes.Enabled := True;
end;

procedure TFrmConvenio.registrar;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('insert into "fun$convenios"');
          SQL.Add('values (');
          SQL.Add(':id_convenio,');
          SQL.Add(':descripcion,');
          SQL.Add(':direccion,');
          SQL.Add(':ciudad,');
          SQL.Add(':telefono,');
          SQL.Add(':director,');
          SQL.Add(':representante_local,');
          SQL.Add(':fecha,:tipo_fecha)');
          ParamByName('id_convenio').AsInteger := id_convenio;
          ParamByName('descripcion').AsString := TMdescripcion.Text;
          ParamByName('direccion').AsString := TEDireccion.Text;
          ParamByName('ciudad').AsString := TECiudad.Text;
          ParamByName('telefono').AsString := TETelefono.Text;
          ParamByName('director').AsString := TEdirector.Text;
          ParamByName('representante_local').AsString := TElocal.Text;
          ParamByName('fecha').AsDatetime := Dfecha.DateTime;
          ParamByName('tipo_fecha').AsSmallInt := Ord(opcion_fecha);
          Open;
          Close;
          Transaction.Commit;
        end;
        with Ctablaparametro do
        begin
          First;
          while not Eof do
          begin
            with DataQuerys.IBdatos do
            begin
              Close;
              verificatransaccion(DataQuerys.IBdatos);
              SQL.Clear;
              SQL.Add('insert into "fun$parametros"');
              SQL.Add('values (');
              SQL.Add(':id_parametro,');
              SQL.Add(':id_convenio,');
              SQL.Add(':parentesco,');
              SQL.Add(':definicion,');
              SQL.Add(':parametro,');
              SQL.Add(':valor)');
              ParamByName('id_parametro').AsInteger := Ctablaparametro.FieldValues['id_parametro'];
              ParamByName('id_convenio').AsInteger := Ctablaparametro.FieldValues['id_convenio'];
              ParamByName('parentesco').AsInteger := Ctablaparametro.FieldValues['parentesco'];
              ParamByName('definicion').AsString := Ctablaparametro.FieldValues['definicion'];
              ParamByName('parametro').AsString := Ctablaparametro.FieldValues['parametro'];
              ParamByName('valor').AsString := Ctablaparametro.FieldValues['valor'];
              Open;
              Close;
              Transaction.Commit;
            end;
            Next;
          end;
        end;
        with CDplanes do
        begin
           First;
           while not Eof do
           begin
             with DataQuerys.IBdatos do
             begin
               Close;
               verificatransaccion(DataQuerys.IBdatos);
               SQL.Clear;
               SQL.Add('insert into "fun$planes"');
               SQL.Add('values(');
               SQL.Add(':id_plan,');
               SQL.Add(':id_convenio,');
               SQL.Add(':descripcion,');
               SQL.Add(':periocidad)');
               ParamByName('id_plan').AsInteger := CDplanes.FieldValues['id_plan'];
               ParamByName('id_convenio').AsInteger := CDplanes.FieldValues['id_convenio'];
               ParamByName('descripcion').AsString := CDplanes.FieldValues['descripcion'];
               ParamByName('periocidad').AsString := CDplanes.FieldValues['periodo'];
               Open;
               Close;
               Transaction.Commit;
             end;
             Next;
           end;
        end;
end;

procedure TFrmConvenio.BACEPTARClick(Sender: TObject);
begin
        if TMdescripcion.Text = '' then
        begin
           MessageDlg('El Campo Nombre no puede ser Nulo',mtInformation,[mbok],0);
           TMdescripcion.SetFocus;
           Exit;
        end;
        if MessageDlg('Seguro de Registrar el Convenio',mtInformation,[mbyes,mbno],0) = mryes then
        begin
           FrmTipo := TFrmTipo.Create(self);
           FrmTipo.Caption := 'Tipo Fecha de Vencimiento';
           FrmTipo.RGrafico.Caption := '&Exacta';
           FrmTipo.Rtextual.Caption := '&Total';
           FrmTipo.tipo := 1;
           FrmTipo.ShowModal;
           registrar;
           MessageDlg('El Convenio ha sido Registrado Exitosamente.',mtInformation,[mbok],0);
           limpiar;
        end;
end;

procedure TFrmConvenio.limpiar;
begin
        TEntidad.Text := '';
        TMdescripcion.Text := '';
        TEdirector.Text := '';
        TECiudad.Text := '';
        TEDireccion.Text := '';
        TETelefono.Text := '';
        TElocal.Text := '';
        CDplanes.CancelUpdates;
        Ctablaparametro.CancelUpdates;
        TabEntidad.Show;
        TEntidad.SetFocus;
end;

procedure TFrmConvenio.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmConvenio.TETelefonoExit(Sender: TObject);
begin
        TabParametro.Show;
        DBparametros.SetFocus;
end;

end.
