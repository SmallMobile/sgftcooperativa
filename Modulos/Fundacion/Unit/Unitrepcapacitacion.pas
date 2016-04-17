unit Unitrepcapacitacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, IBDatabase, IBCustomDataSet, IBQuery, DBCtrls,
  ComCtrls, StdCtrls, Buttons,DateUtils,jcldatetime, DBClient, pr_Common, JclSysUtils,
  pr_TxClasses, StrUtils;

type
  TFrmRepCapacitacion = class(TForm)
    Label1: TLabel;
    ff: TPanel;
    fecha: TDateTimePicker;
    capacitacion: TDBLookupComboBox;
    Label2: TLabel;
    IBQuery2: TIBQuery;
    IBTransaction2: TIBTransaction;
    DataSource2: TDataSource;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    CDasistenete: TClientDataSet;
    CDasistenetedocumento: TStringField;
    CDasistenetenombres: TStringField;
    CDasisteneteasistio: TBooleanField;
    CDasistenetevalor: TStringField;
    CDasistenetecuenta: TStringField;
    CDasisteneteedad: TIntegerField;
    CDasistenetenumero: TIntegerField;
    CDasistenetetelefono: TStringField;
    reporte: TprTxReport;
    IBQuery1: TIBQuery;
    reporte1: TprTxReport;
    IBconferencista: TIBQuery;
    IBTransaction1: TIBTransaction;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
  published
    function esjuvenil(id_capacitacion: integer): boolean;
    { Public declarations }
  end;

var
  FrmRepCapacitacion: TFrmRepCapacitacion;

implementation

uses UnitQuerys, UnitdataQuerys,UnitGlobal, UnitPrincipal,Unitvistapreliminar,
  UnitPantallaProgreso, UnitGlobales;

{$R *.dfm}

procedure TFrmRepCapacitacion.BitBtn1Click(Sender: TObject);
var     a :string;
begin
        a := IntToStr(DaysInAMonth(YearOfDate(Date),MonthOfDate(fecha.Date)));
        IBQuery2.Close;
        IBQuery2.ParamByName('fecha1').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',fecha.Date));
        IBQuery2.ParamByName('fecha2').AsDate := StrToDate(FormatDateTime('yyyy/mm/'+a,fecha.Date));
        IBQuery2.Open;
        IBQuery2.Last;

end;

procedure TFrmRepCapacitacion.BitBtn4Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmRepCapacitacion.BitBtn3Click(Sender: TObject);
var     nombre, telefono, certificado :string;
        id_identificacion :Integer;
begin
        {CDasistenete.CancelUpdates;
        with FrmQuerys.IBSQL1 do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          end;
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$capacitacionper"."id_persona",');
          SQL.Add('"fun$capacitacionper"."oficina",');
          SQL.Add('"fun$capacitacionper"."telefono"');
          SQL.Add('FROM');
          SQL.Add('"fun$capacitacionper"');
          SQL.Add('WHERE');
          SQL.Add('("fun$capacitacionper"."id_capacitacion" = :id_capacitacion)');
          ParamByName('id_capacitacion').AsSmallInt := capacitacion.KeyValue;
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Titulo := 'Generando Reporte';
          frmProgresos.Ejecutar;
          while not Eof do
          begin
          frmProgresos.Position := RecNo;
          frmProgresos.InfoLabel := 'Participante No : ' + IntToStr(RecNo);
          Application.ProcessMessages;
            if FieldByName('oficina').AsInteger = 1 then
            begin } //
              {with FrmQuerys.IBseleccion do
              begin
                Close;
                verificatransaccion(FrmQuerys.IBseleccion);
                SQL.Clear;
                SQL.Add(' select * from BUSCA_PERSONA_N1(:NIT)');
                ParamByName('NIT').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                Open;}
                //
                {
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
                  if RecordCount <> 0 then
                     telefono := FieldByName('TELEFONO1').AsString
                  else
                     telefono := '       ';
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT * FROM P_CAP_0008 (:ID_AGENCIA,:ID_TIPO_CAPTACION,:ID_IDENTIFICACION,:ID_PERSONA)');
                  ParamByName('ID_AGENCIA').AsInteger := 1;
                  ParamByName('ID_TIPO_CAPTACION').AsInteger := 2;
                  ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
                  ParamByName('ID_PERSONA').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  ExecQuery;

                //
                if DataQuerys.IBdatos.FieldByName('telefono').AsString = 'C' then
                   certificado := ' CERT.'
                else
                   certificado := '';
                CDasistenete.Append;
                CDasistenete.FieldValues['documento'] := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                CDasistenete.FieldValues['nombres'] := nombre;
                CDasistenete.FieldValues['asistio'] := True;
                CDasistenete.FieldValues['valor'] := 'SI';
                CDasistenete.FieldValues['cuenta'] := FieldByName('NUMERO_CUENTA').AsString;
                CDasistenete.FieldValues['edad'] := 0;
                CDasistenete.FieldValues['telefono'] := telefono + CERTIFICADO;
                CDasistenete.FieldValues['numero'] := DataQuerys.IBdatos.RecNo;
                CDasistenete.Post;
                Close;
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
               CDasistenete.FieldValues['asistio'] := True;
               CDasistenete.FieldValues['valor'] := 'SI';
               CDasistenete.FieldValues['cuenta'] := busca_numerocuenta(DataQuerys.IBdatos.FieldByName('id_persona').AsString);
               //ShowMessage(FieldByName('FECHA_NACIMIENTO').AsString);
               try
               CDasistenete.FieldValues['edad'] := edad(FieldByName('FECHA_NACIMINETO').AsDateTime);
               except
               CDasistenete.FieldValues['edad'] := 0;
               end;
               CDasistenete.FieldValues['telefono'] := FieldByName('TELEFONO').AsString;
               CDasistenete.FieldValues['numero'] := DataQuerys.IBdatos.RecNo;
               CDasistenete.Post;
               Close;
            end;
          end;
          Next;
          end;
        end;
        frmProgresos.Cerrar; }
        //*******
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
          ParamByName('id_capacitacion').AsInteger := capacitacion.KeyValue;
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
            if FieldByName('oficina').AsInteger = Agencia  then
            begin
              if esjuvenil(capacitacion.KeyValue) = False then
              begin
                with FrmQuerys.IBseleccion do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT *');
                  SQL.Add('FROM');
                  SQL.Add('"gen$persona"');
                  SQL.Add('WHERE');
                  SQL.Add('("gen$persona".id_persona = :nit)');
                  ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  Open;
                  //Last;
                  id_identificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
                  nombre := FieldByName('PRIMER_APELLIDO').AsString + ' ' +FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +FieldByName('NOMBRE').AsString;
                  SQL.Clear;
                  SQL.Add('select * from "gen$direccion"');
                  SQL.Add('where ID_DIRECCION = 1');
                  SQL.Add('AND ID_PERSONA = :ID_PERSONA');
                  ParamByName('ID_PERSONA').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  Open;
                  if RecordCount <> 0 then
                     telefono := FieldByName('TELEFONO1').AsString
                  else
                     telefono := '       ';
                  SQL.Clear;
                  SQL.Add('SELECT * FROM P_CAP_0008 (:ID_AGENCIA,:ID_TIPO_CAPTACION,:ID_IDENTIFICACION,:ID_PERSONA)');
                  ParamByName('ID_AGENCIA').AsInteger := Agencia;
                  ParamByName('ID_TIPO_CAPTACION').AsInteger := 2;
                  ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
                  ParamByName('ID_PERSONA').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  Open;
                if LeftStr(DataQuerys.IBdatos.FieldByName('telefono').AsString,1) = 'C' then
                   certificado := ' CERTIFICADO.'
                else
                   certificado := '';
                  CDasistenete.Append;
                  CDasistenete.FieldValues['documento'] := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  CDasistenete.FieldValues['nombres'] := nombre;
                  CDasistenete.FieldValues['telefono'] := telefono + certificado;
                  CDasistenete.FieldValues['cuenta'] := FieldByName('NUMERO_CUENTA').AsString;
                  //CDasistenete.FieldValues['telefono_op'] := DataQuerys.IBdatos.FieldByName('telefono').AsString;
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
                  //CDasistenete.FieldValues['telefono_op'] := DataQuerys.IBdatos.FieldByName('telefono').AsString;
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
               //CDasistenete.FieldValues['telefono_op'] := DataQuerys.IBdatos.FieldByName('telefono').AsString;
               CDasistenete.FieldValues['numero'] := DataQuerys.IBdatos.recno;
               CDasistenete.Post;
               Close;
            end;
          end;
          Next;
          end;
          frmProgresos.Cerrar;

        //*******
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
          ParamByName('id_capacitacion').AsInteger := capacitacion.KeyValue;
          Open;
          frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
          reporte.Variables.ByName['empresa'].AsString := FrMain.Empresa;
          reporte.Variables.ByName['hoy'].AsDateTime := Date;
          reporte.Variables.ByName['empleado'].AsString := empleados(UpperCase(FrMain.Dbalias),2);
          reporte.Variables.ByName['Nit'].AsString := FrMain.Nit;
          reporte.Variables.ByName['tramite'].AsString := capacitacion.Text;
          reporte.Variables.ByName['convenio'].AsString := FieldByName('descripcion').AsString;
          reporte.Variables.ByName['horario'].AsString := FieldByName('horario').AsString;
          reporte.Variables.ByName['lugar'].AsString := FieldByName('lugar').AsString;
          reporte.Variables.ByName['fecha'].AsString := FieldByName('fecha').AsString;
          if FieldByName('esjuvenil').AsInteger = 1 then
             reporte.Variables.ByName['participante'].AsString := 'Ahorradores Juveniles'
          else
             reporte.Variables.ByName['participante'].AsString := 'Asociados Adultos';
             {with CDasistenete do
             begin
             Close;
             CommandText := 'order by nombres';
             Open;
             end;}
             verificatransaccion(IBconferencista);
             IBconferencista.Close;
             IBconferencista.ParamByName('id').AsInteger := capacitacion.KeyValue;
             IBconferencista.Open;
             CDasistenete.IndexFieldNames := 'nombres';
             CDasistenete.Open;
          if reporte.PrepareReport then          begin
            frmVistaPreliminar.Reporte := reporte;
            frmVistaPreliminar.ShowModal;
          end;
          Close;

        end;
        end;
end;

procedure TFrmRepCapacitacion.FormCreate(Sender: TObject);
begin
        FrmQuerys := TFrmQuerys.Create(self);
        DataQuerys := TDataQuerys.Create(self);
        fecha.Date := Date;
end;

procedure TFrmRepCapacitacion.BitBtn2Click(Sender: TObject);
var     a :string;
begin
        a := IntToStr(DaysInAMonth(YearOfDate(Date),MonthOfDate(fecha.Date)));
        IBQuery1.Close;
        IBQuery1.ParamByName('fecha1').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',fecha.Date));
        IBQuery1.ParamByName('fecha2').AsDate := StrToDate(FormatDateTime('yyyy/mm/'+a,fecha.Date));
        IBQuery1.Open;
        IBQuery1.Last;
          frmVistaPreliminar := TfrmVistaPreliminar.Create(self);
          reporte1.Variables.ByName['empresa'].AsString := FrMain.Empresa;
          reporte1.Variables.ByName['hoy'].AsDateTime := Date;
          reporte1.Variables.ByName['empleado'].AsString := empleados(UpperCase(FrMain.Dbalias),2);
          reporte1.Variables.ByName['Nit'].AsString := FrMain.Nit;
          reporte1.Variables.ByName['tramite'].AsString := capacitacion.Text;
          if reporte1.PrepareReport then          begin
            frmVistaPreliminar.Reporte := reporte1;
            frmVistaPreliminar.ShowModal;
          end;
end;

function TFrmRepCapacitacion.esjuvenil(id_capacitacion: integer): boolean;
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
