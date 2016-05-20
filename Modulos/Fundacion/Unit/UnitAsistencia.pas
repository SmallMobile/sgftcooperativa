unit UnitAsistencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, Buttons, DB, DBClient,
  IBCustomDataSet, IBQuery, DBCtrls, pr_Common, pr_TxClasses, ImgList,
  Menus, JclSysUtils;

type
  TFrmAsistencia = class(TForm)
    Panel1: TPanel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CDasistenete: TClientDataSet;
    CDasistenetedocumento: TStringField;
    CDasistenetenombres: TStringField;
    CDasistenetetelefono: TStringField;
    descripcion: TDBLookupComboBox;
    DataSource1: TDataSource;
    IBQuery1: TIBQuery;
    CDasistenetecuenta: TStringField;
    DataSource2: TDataSource;
    CDasistenetetelefono_op: TStringField;
    CDasistenetenumero: TIntegerField;
    PopupMenu1: TPopupMenu;
    EliminarRegistro1: TMenuItem;
    ImageList1: TImageList;
    reporte: TprTxReport;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EliminarRegistro1Click(Sender: TObject);
  private
    { Private declarations }
  public
  published
    function esjuvenil(id_capacitacion: integer): boolean;
    { Public declarations }
  end;

var
  FrmAsistencia: TFrmAsistencia;

implementation

uses UnitQuerys, UnitdataQuerys,UnitGlobal, UnitPantallaProgreso,UnitVistaPreliminar,
  UnitPrincipal, UnitGlobales;

{$R *.dfm}

procedure TFrmAsistencia.FormCreate(Sender: TObject);
begin
        IBQuery1.Open;
        IBQuery1.Last;
end;

procedure TFrmAsistencia.BitBtn1Click(Sender: TObject);
var     nombre, telefono :string;
        id_identificacion :Integer;
begin
        FrmQuerys := TFrmQuerys.Create(self);
        DataQuerys := TDataQuerys.Create(self);
        CDasistenete.CancelUpdates;
        verificatransaccion(FrmQuerys.IBseleccion);
        with FrmQuerys.IBSQL1 do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          end;
        with DataQuerys.IBdatos   do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$capacitacionper"."id_persona",');
          SQL.Add('"fun$capacitacionper"."oficina",');
          SQL.Add('"fun$capacitacionper"."telefono"');
          SQL.Add('FROM');
          SQL.Add('"fun$capacitacionper"');
          SQL.Add('WHERE');
          SQL.Add('("fun$capacitacionper"."id_capacitacion" = :id_capacitacion)');
          ParamByName('id_capacitacion').AsInteger := descripcion.KeyValue;
          Open;
          Last;
          First;
          frmprogresos := TfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Titulo := 'Cargando Lista de Asistentes';
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Registro No : ' + IntToStr(RecNo);
            Application.ProcessMessages;
            if FieldByName('oficina').AsInteger = Agencia then
            begin
              if esjuvenil(descripcion.KeyValue) = False then
              begin
                with FrmQuerys.IBSQL1 do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT *');
                  SQL.Add('FROM');
                  SQL.Add('"gen$persona"');
                  SQL.Add('WHERE');
                  SQL.Add('("gen$persona".id_persona = :nit)');
                  ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  ExecQuery;
                  id_identificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
                  nombre := FieldByName('PRIMER_APELLIDO').AsString + ' ' +FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +FieldByName('NOMBRE').AsString;
                  Close;
                  SQL.Clear;
                  SQL.Add('select * from "gen$direccion"');
                  SQL.Add('where ID_DIRECCION = 1');
                  SQL.Add('AND ID_PERSONA = :ID_PERSONA');
                  ParamByName('ID_PERSONA').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  ExecQuery;
                  telefono := FieldByName('TELEFONO1').AsString;
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM P_CAP_0008 (:ID_AGENCIA,:ID_TIPO_CAPTACION,:ID_IDENTIFICACION,:ID_PERSONA)');
                  ParamByName('ID_AGENCIA').AsInteger := Agencia;
                  ParamByName('ID_TIPO_CAPTACION').AsInteger := 2;
                  ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
                  ParamByName('ID_PERSONA').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  ExecQuery;
                  CDasistenete.Append;
                  CDasistenete.FieldValues['documento'] := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  CDasistenete.FieldValues['nombres'] := nombre;
                  CDasistenete.FieldValues['telefono'] := telefono;
                  CDasistenete.FieldValues['cuenta'] := FieldByName('NUMERO_CUENTA').AsString;
                  CDasistenete.FieldValues['telefono_op'] := DataQuerys.IBdatos.FieldByName('telefono').AsString;
                  CDasistenete.FieldValues['numero'] := DataQuerys.IBdatos.RecNo;
                  CDasistenete.Post;
                  Close;
                end;
              end
              else
              begin
                with FrmQuerys.IBSQL1 do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT');
                  SQL.Add('"gen$persona".NOMBRE,');
                  SQL.Add('"gen$persona".PRIMER_APELLIDO,');
                  SQL.Add('"gen$persona".SEGUNDO_APELLIDO,');
                  SQL.Add('"gen$persona".EDUCACION,');
                  SQL.Add('"cap$maestrotitular".NUMERO_CUENTA,');
                  SQL.Add('"gen$persona".provincia_nacimiento,');
                  SQL.Add('"gen$direccion".TELEFONO1');
                  SQL.Add('FROM');
                  SQL.Add('"cap$maestrotitular"');
                  SQL.Add('INNER JOIN "gen$persona" ON ("cap$maestrotitular".ID_PERSONA = "gen$persona".ID_PERSONA)');
                  SQL.Add('INNER JOIN "gen$direccion" ON ("gen$persona".ID_PERSONA = "gen$direccion".ID_PERSONA)');
                  SQL.Add('WHERE');
                  SQL.Add('("cap$maestrotitular".ID_TIPO_CAPTACION = 4) AND');
                  SQL.Add('("cap$maestrotitular".NUMERO_TITULAR = 2) and');
                  SQL.Add('("gen$persona".id_persona = :nit)');
                  ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  ExecQuery;
                  CDasistenete.Append;
                  CDasistenete.FieldValues['documento'] := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  CDasistenete.FieldValues['nombres'] := FieldByName('PRIMER_APELLIDO').AsString + ' ' +FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +FieldByName('NOMBRE').AsString;
                  CDasistenete.FieldValues['telefono'] := FieldByName('TELEFONO1').AsString;
                  CDasistenete.FieldValues['cuenta'] := FieldByName('NUMERO_CUENTA').AsString;
                  CDasistenete.FieldValues['telefono_op'] := DataQuerys.IBdatos.FieldByName('telefono').AsString;
                  CDasistenete.FieldValues['numero'] := DataQuerys.IBdatos.RecNo;
                  CDasistenete.Post;
                end;
              end;
            end
            else
            begin
             with DataQuerys.IBingresa do
             begin
               Close;
               verificatransaccion(DataQuerys.IBingresa);
               SQL.Clear;
               SQL.Add('select * FROM BUSCA_BENE(:NIT)');
               ParamByName('NIT').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
               Open;
               CDasistenete.Append;
               CDasistenete.FieldValues['documento'] := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
               CDasistenete.FieldValues['nombres'] := FieldByName('NOMBRES').AsString;
               CDasistenete.FieldValues['telefono'] := FieldByName('TELEFONO').AsString;
               CDasistenete.FieldValues['cuenta'] := busca_numerocuenta(DataQuerys.IBdatos.FieldByName('id_persona').AsString);
               CDasistenete.FieldValues['telefono_op'] := DataQuerys.IBdatos.FieldByName('telefono').AsString;
               CDasistenete.FieldValues['numero'] := DataQuerys.IBdatos.recno;
               CDasistenete.Post;
               Close;
            end;
          end;
          Next;
          end;
          frmProgresos.Cerrar;
        end;
end;

procedure TFrmAsistencia.BitBtn2Click(Sender: TObject);
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$capacitacion"."fecha",');
          SQL.Add('"fun$capacitacion"."horario",');
          SQL.Add('"fun$tipocapacitacion"."descripcion",');
          SQL.Add('"fun$capacitacion"."lugar",');
          SQL.Add('"fun$capacitacion"."esjuvenil"');
          SQL.Add('FROM');
          SQL.Add('"fun$capacitacion"');
          SQL.Add('INNER JOIN "fun$tipocapacitacion" ON ("fun$capacitacion"."id_tipocapacitacion" = "fun$tipocapacitacion"."id_tipo")');
          SQL.Add(' WHERE');
          SQL.Add('("fun$capacitacion"."id_capacitacion" = :id_capacitacion)');
          ParamByName('id_capacitacion').AsInteger := descripcion.KeyValue;
          Open;
          frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
          reporte.Variables.ByName['empresa'].AsString := FrMain.Empresa;
          reporte.Variables.ByName['hoy'].AsDateTime := Date;
          reporte.Variables.ByName['empleado'].AsString := empleados(UpperCase(FrMain.Dbalias),2);
          reporte.Variables.ByName['Nit'].AsString := FrMain.Nit;
          reporte.Variables.ByName['tramite'].AsString := descripcion.Text;
          reporte.Variables.ByName['convenio'].AsString := FieldByName('descripcion').AsString;
          reporte.Variables.ByName['horario'].AsString := FieldByName('horario').AsString;
          reporte.Variables.ByName['lugar'].AsString := FieldByName('lugar').AsString;
          reporte.Variables.ByName['fecha'].AsString := FieldByName('fecha').AsString;
          if FieldByName('esjuvenil').AsInteger = 1 then
             reporte.Variables.ByName['participante'].AsString := 'Ahorradores Juveniles'
          else
             reporte.Variables.ByName['participante'].AsString := 'Ahorradores Adultos';
          CDasistenete.IndexFieldNames := 'nombres';
          if reporte.PrepareReport then          begin
            frmVistaPreliminar.Reporte := reporte;
            frmVistaPreliminar.ShowModal;
          end;
          Close;
        end;

end;

procedure TFrmAsistencia.EliminarRegistro1Click(Sender: TObject);
var     beneficiario :string;
begin
        if MessageDlg('Esta Seguro de Eliminar el Registro',mtWarning,[Mbyes,Mbno],0) = mryes then
        begin
        try
          beneficiario := CDasistenetedocumento.Text;
          CDasistenete.Delete;
        except
          MessageDlg('No existen Datos para Eliminar',mtInformation,[mbok],0);
        end;
        with DataQuerys.IBdatos do
        begin
           Close;
           verificatransaccion(DataQuerys.IBdatos);
           SQL.Clear;
           SQL.Add('delete from "fun$capacitacionper"');
           SQL.Add('where "fun$capacitacionper"."id_persona" = :nit' );
           ParamByName('nit').AsString := beneficiario;
           Open;
           Close;
           Transaction.Commit;
        end;
        end;
end;

function TFrmAsistencia.esjuvenil(id_capacitacion: integer): boolean;
begin
        with DataQuerys.IBFundacion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$capacitacion"."esjuvenil"');
          SQL.Add('FROM');
          SQL.Add('"fun$capacitacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$capacitacion"."id_capacitacion" = :i)');
          ParamByName('i').AsInteger := id_capacitacion;
          Open;
            Result := IntToBool(FieldByName('esjuvenil').AsInteger);
          Close;
        end;
end;

end.
