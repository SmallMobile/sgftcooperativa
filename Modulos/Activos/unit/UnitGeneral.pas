unit UnitGeneral;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery,dbtables,messages,Dialogs;

type
  Tfrmgeneral = class(TDataModule)
    activo_componente: TDataSource;
    poliza: TIBDataSet;
    pol: TDataSource;
    componente: TIBDataSet;
    componentecod_componente: TIntegerField;
    componentecod_activo: TIntegerField;
    componentedescripcion: TIBStringField;
    componenteserial: TIBStringField;
    tipo_polizas: TIBDataSet;
    busca_nombre: TIBDataSet;
    DataAgencia: TDataSource;
    IbAgencia: TIBQuery;
    hitorial_polizas: TIBDataSet;
    datahistorial_poliza: TDataSource;
    DataActpoliza: TDataSource;
    IbActpoliza: TIBDataSet;
    IbActpolizacod_poliza: TIntegerField;
    IbActpolizatipo_poliza: TSmallintField;
    IbActpolizafecha_inicio: TDateField;
    IbActpolizafecha_vencimiento: TDateField;
    IbActpolizacod_activo: TIntegerField;
    IbActpolizavalor_asegurado: TIBBCDField;
    IbActpolizanombre_poliza: TStringField;
    IbAseguradora: TIBDataSet;
    IbActpolizanit_seguro: TIBBCDField;
    IbActpolizaseguro: TStringField;
    ibcod_poliza: TIBDataSet;
    ibcod_polizaCODIGO: TIntegerField;
    polizacod_poliza: TIntegerField;
    polizatipo_poliza: TSmallintField;
    polizafecha_inicio: TDateField;
    polizafecha_vencimiento: TDateField;
    polizacod_activo: TIntegerField;
    polizavalor_asegurado: TIBBCDField;
    polizanit_seguro: TIBBCDField;
    polizaseguro: TStringField;
    polizanombre_poliza: TStringField;
    hitorial_polizascod_poliza: TIntegerField;
    hitorial_polizastipo_poliza: TSmallintField;
    hitorial_polizasfecha_inicio: TDateField;
    hitorial_polizasfecha_vencimiento: TDateField;
    hitorial_polizascod_activo: TIntegerField;
    hitorial_polizasvalor_asegurado: TIBBCDField;
    hitorial_polizasdescripcion: TIBStringField;
    hitorial_polizasdescripcion1: TIBStringField;
    polizavencido: TSmallintField;
    IbActpolizavencido: TSmallintField;
    dtipo: TDataSource;
    DSEntrega: TDataSource;
    IBentrega: TIBDataSet;
    IBentregafecha_traslado: TDateField;
    IBentreganit_empleado: TIntegerField;
    IBentregacod_oficina: TSmallintField;
    IBentregacod_seccion: TSmallintField;
    IBentregacod_activo: TIntegerField;
    IBentregaforma_traslado: TIBStringField;
    IBentregaidentificador: TIBStringField;
    IBentregalugar: TIBStringField;
    IBentregacod_traslado: TSmallintField;
    IBentregaplaca: TIBStringField;
    IBentregadescripcion: TIBStringField;
    DSseccion: TDataSource;
    IBseccion: TIBDataSet;
    IBentregatipotraslado: TIBStringField;
    componenteplaca: TIBStringField;
    procedure polizavalor_aseguradoValidate(Sender: TField);
    procedure polizafecha_inicioValidate(Sender: TField);
    procedure componenteserialValidate(Sender: TField);
    procedure IbActpolizafecha_inicioValidate(Sender: TField);
    procedure IbActpolizaPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure polizaPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure IBentregaplacaValidate(Sender: TField);
    procedure IBentregaPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private

    { Private declarations }
  public
  codigo,codigo_poliza,valida_codigo:Integer;
    { Public declarations }
  end;

var
  frmgeneral: Tfrmgeneral;

const
  {DECLARACION DE ERRORES}
  primaria = 9729;
implementation
uses unitdatamodulo,unitactivoreal, UnitActualiza, Unitentrega;

{$R *.dfm}

procedure Tfrmgeneral.polizavalor_aseguradoValidate(Sender: TField);
var valor: Variant;
begin
        valor:=polizavalor_asegurado.Text;
        //polizavalor_asegurado.Text:=FormatCurr('#,##0.00',valor);
end;

procedure Tfrmgeneral.polizafecha_inicioValidate(Sender: TField);
begin
      polizacod_activo.Text:=IntToStr(frmactivoreal.codigo_activo);
      polizacod_poliza.Text:=IntToStr(codigo_poliza);
      polizavencido.Text:='0';

end;

procedure Tfrmgeneral.componenteserialValidate(Sender: TField);
begin
        if frmactivoreal.Control_dato=False then
        begin
          frmactivoreal.Control_dato:=True;
          frmactivoreal.entra_datos;
        end;

        codigo:=codigo+1;
        componentecod_activo.Text:=IntToStr(frmactivoreal.codigo_activo);
        componentecod_componente.Text:=IntToStr(codigo);
        //ShowMessage(componentecod_componente.Text);
        frmactivoreal.eliminarcomp.Enabled:=True;
        frmactivoreal.EliminarPoliza.Enabled:=True;

end;

procedure Tfrmgeneral.IbActpolizafecha_inicioValidate(Sender: TField);
begin
      IbActpolizacod_activo.Text:=IntToStr(Frmactualiza.codigo_activo);
      IbActpolizacod_poliza.Text:=IntToStr(codigo_poliza);
      IbActpolizavencido.Text:='0';
      Frmactualiza.valida_poliza:=True;
      Frmactualiza.bcerrar.Enabled:=True;
      
end;

procedure Tfrmgeneral.IbActpolizaPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
  begin
if E.Message <> '' then
        begin
            Frmactualiza.dbactauliza.SetFocus;
            E.Message:='Error En la Actualizacion';
        end;
end;

procedure Tfrmgeneral.polizaPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin

{    if E.Message <> '' THEN
    begin
    E.Message:='ERROR El Tipo de Seguro '+polizanombre_poliza.Text+' se Repite Favor Eliminar';
    end;}
end;

procedure Tfrmgeneral.IBentregaplacaValidate(Sender: TField);
var       tipo,placaactivo:string;
begin
        placaactivo := UpperCase(IBentregaplaca.Text);
        with DataGeneral.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$activo"."cod_activo","act$activo"."descripcion" from "act$activo"');
          SQL.Add('where "act$activo"."placa" = :"placa"');
          ParamByName('placa').AsString:=placaactivo;
          Open;
          IBentregacod_activo.Text:=FieldByName('cod_activo').AsString;
          with DataGeneral.IBsql do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select count(*) as codigo from "act$traslado"');
            SQL.Add('where "act$traslado"."cod_activo"=:"codigo_activo"');
            ParamByName('codigo_activo').AsString:=IBentregacod_activo.Text;
            ExecQuery;
            tipo:=FieldByName('codigo').AsString;
            Close;
          end;
          if tipo <> '0' then
          begin
          //ShowMessage('El Activo Ya Fue Entregado');
          valida_codigo:=0;
          //IBentregaplaca.FocusControl;
          Exit;
          end;

        if IBentregacod_activo.Text ='' then
        begin
        valida_codigo:=1;
        //ShowMessage('El Numero de PLaca No existe');
        Close;
        Exit;
        end;
        IBentregadescripcion.Text:=FieldByName('descripcion').AsString;
        IBentregafecha_traslado.Text := DateTimeToStr(FrmEntrega.fecha.DateTime);
        IBentregacod_traslado.Text := IntToStr(FrmEntrega.cod_traslado);
        IBentreganit_empleado.Text := IntToStr(FrmEntrega.nit_emp);
        IBentregacod_oficina.Text:= IntToStr(FrmEntrega.cod_agencia);
        IBentregacod_seccion.Text := IntToStr(FrmEntrega.codigo_seccion);
        IBentregaforma_traslado.Text := 'DEFINITIVO';
        IBentregaidentificador.Text := 'N';
        IBentregalugar.Text := 'A';
        IBentregatipotraslado.Text := FrmEntrega.tipo_entrega;
        FrmEntrega.eliminar.Enabled := True;
        Close;
        end;
end;

procedure Tfrmgeneral.IBentregaPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
        if (E.Message <> '') and (valida_codigo = 1) then
        begin
          E.Message := 'El Numero de Placa no Existe';
          IBentregaplaca.FocusControl;
          Exit;
        end;
        if (E.Message <> '') and (valida_codigo = 0) then
        begin
          E.Message := 'El Activo ya Fue Entregado';
          IBentregaplaca.FocusControl;
          Exit;
        end;
end;

end.
