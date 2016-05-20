unit UnitReportes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient,JclSysUtils, pr_Common, pr_TxClasses, StdCtrls,
  Grids, DBGrids, MPlayer, IBDatabase, IBCustomDataSet, IBQuery;

type
  TFrmReportes = class(TForm)
    CDDatos: TClientDataSet;
    CDDatosnumero: TIntegerField;
    CDDatosnombres: TStringField;
    CDDatosnit: TStringField;
    CDDatostelefono: TStringField;
    CDDatosbarrio: TStringField;
    CDDatosdireccion: TStringField;
    CDDatosciudad: TStringField;
    CDDatoscuenta: TStringField;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    IBCapAsociado: TIBQuery;
    IBTransaction1: TIBTransaction;
    Reporte: TprTxReport;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    asociado :string;
    nit_asociado :string;
    procedure asociados;
    function verifica(nit: string): boolean;
    procedure capaciatacionaso;
    { Public declarations }
  end;

var
  FrmReportes: TFrmReportes;

implementation

uses UnitQuerys, UnitdataQuerys, UnitPantallaProgreso, UnitPrincipal,UnitVistaPreliminar,UnitGlobal;

{$R *.dfm}

procedure TFrmReportes.asociados;
var     cadena,convenio :string;
begin
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$afiliacion"."es_local",');
          SQL.Add('"fun$afiliacion"."nit_asociado"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."es_afiliacion" = 1) AND');
          SQL.Add('("fun$afiliacion"."id_convenio" = :convenio)');
          SQL.Add('and ("fun$afiliacion"."fecha" >= :fecha1)');
          ParamByName('convenio').AsInteger := 1;
          ParamByName('fecha1').AsDate := StrToDate('2004/06/01');
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Titulo := 'Reporte General de Asociados';
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Registro No : '+IntToStr(RecNo);
            Application.ProcessMessages;
            if verifica(FieldByName('nit_asociado').AsString) then
            begin
              with FrmQuerys.IBseleccion do
              begin
                Close;
                SQL.Clear;
                SQL.Add('select * from BUSCA_PERSONA_N1 (:NIT)');
                ParamByName('NIT').AsString := DataQuerys.IBdatos.FieldByName('nit_asociado').AsString;
                Open;
                //if FieldByName('NOMBRES').AsString <> '' then
                //begin
                CDDatos.Append;
                CDDatos.FieldValues['direccion'] := FieldByName('DIRECCION').AsString;
                CDDatos.FieldValues['nombres'] := FieldByName('APELLIDO1').AsString+' '+FieldByName('APELLIDO2').AsString+' '+FieldByName('NOMBRES').AsString;
                CDDatos.FieldValues['barrio'] := FieldByName('BARRIO').AsString;
                CDDatos.FieldValues['ciudad'] := FieldByName('MUNICIPIO').AsString;
                CDDatos.FieldValues['telefono'] := FieldByName('TELEFONO').AsString;
                CDDatos.FieldValues['cuenta'] := FieldByName('NUMERO_CUENTA').AsString;
                CDDatos.FieldValues['nit'] := DataQuerys.IBdatos.FieldByName('nit_asociado').AsString;
                CDDatos.FieldValues['numero'] :=  DataQuerys.IBdatos.RecNo;
                CDDatos.Post;
                //end;
              end;
            end
            else
            begin
              with DataQuerys.IBselecion do
              begin
                Close;
                SQL.Clear;
                SQL.Add('select * from BUSCA_BENE(:NIT)');
                ParamByName('NIT').AsString := DataQuerys.IBdatos.fieldbyname('nit_asociado').AsString;
                Open;
                CDDatos.Append;
                CDDatos.FieldValues['direccion'] := FieldByName('DIRECCION').AsString;
                CDDatos.FieldValues['nombres'] := FieldByName('NOMBRES').AsString;
                CDDatos.FieldValues['barrio'] := FieldByName('BARRIO').AsString;
                CDDatos.FieldValues['ciudad'] := FieldByName('MUNICIPIO').AsString;
                CDDatos.FieldValues['telefono'] := FieldByName('TELEFONO').AsString;
                CDDatos.FieldValues['direccion'] := DataQuerys.IBdatos.FieldByName('nit_asociado').AsString;
                CDDatos.FieldValues['numero'] :=  DataQuerys.IBdatos.RecNo;
                CDDatos.Post;
               end;
            end;
            Next;

  //          CDDatos.First;
    //        CDDatos.Last;
          end;
          Close;
          frmProgresos.Cerrar;
          //reporte.LoadTemplateFromFile(FrMain.wpath+'\reportes\reporteasociados.prt',False);
          Reporte.Variables.ByName['empresa'].AsString := FrMain.Empresa;
          Reporte.Variables.ByName['nit'].AsString := FrMain.Nit;
          Reporte.Variables.ByName['tramite'].AsString := cadena;
          Reporte.Variables.ByName['convenio'].AsString := convenio;
          if reporte.PrepareReport then
            begin
              frmVistaPreliminar.Reporte := reporte;
              frmVistaPreliminar.ShowModal;
            end;
        end;
end;

function TFrmReportes.verifica(nit: string): boolean;
begin
        with DataQuerys.IBFundacion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$afiliacion"."es_local"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."nit_asociado" = :nit)');
          ParamByName('nit').AsString := nit;
          Open;
          Result := IntToBool(FieldByName('es_local').AsInteger);
          Close;
        end;
end;

procedure TFrmReportes.Button1Click(Sender: TObject);
begin
asociados
end;

procedure TFrmReportes.capaciatacionaso;
begin
          IBCapAsociado.Close;
          IBCapAsociado.ParamByName('nit').AsString := nit_asociado;
          IBCapAsociado.Open;
          frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
          reporte.Variables.ByName['empresa'].AsString := FrMain.Empresa;
          reporte.Variables.ByName['hoy'].AsDateTime := Date;
          reporte.Variables.ByName['empleado'].AsString :=empleado_fun(UpperCase(FrMain.Dbalias));
          reporte.Variables.ByName['Nit'].AsString := FrMain.Nit;
          Reporte.Variables.ByName['participante'].AsString := asociado;
//          reporte.Variables.ByName['tramite'].AsString := descripcion.Text;
  //        reporte.Variables.ByName['convenio'].AsString := FieldByName('descripcion').AsString;
    //      reporte.Variables.ByName['horario'].AsString := FieldByName('horario').AsString;
      //    reporte.Variables.ByName['lugar'].AsString := FieldByName('lugar').AsString;
        //  reporte.Variables.ByName['fecha'].AsString := FieldByName('fecha').AsString;
          if reporte.PrepareReport then          begin
            frmVistaPreliminar.Reporte := reporte;
            frmVistaPreliminar.ShowModal;
          end;
end;

procedure TFrmReportes.FormCreate(Sender: TObject);
begin
        FrmQuerys := TFrmQuerys.Create(self);
end;

end.
