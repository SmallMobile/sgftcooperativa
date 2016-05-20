unit UnitRegistrocap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, DB, IBCustomDataSet, IBQuery,
  IBDatabase, DBClient, Grids, DBGrids, Buttons, pr_Common, pr_TxClasses;

type
  TFrmRegistrocap = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DataSource1: TDataSource;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    descripcion: TDBLookupComboBox;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    CDasistenete: TClientDataSet;
    CDasistenetedocumento: TStringField;
    CDasistenetenombres: TStringField;
    CDasisteneteasistio: TBooleanField;
    DataSource2: TDataSource;
    CDasistenetevalor: TStringField;
    Panel2: TPanel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CDasistenetecuenta: TStringField;
    CDasisteneteedad: TIntegerField;
    CDasistenetenumero: TIntegerField;
    CDasistenetetelefono: TStringField;
    reporte: TprTxReport;
    Label4: TLabel;
    Label5: TLabel;
    Fecha: TEdit;
    Acta: TEdit;
    Ejecutar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EjecutarClick(Sender: TObject);
    procedure descripcionExit(Sender: TObject);
  private
    tipo_capacitacion: boolean;
      procedure educacion(nit:string);
    function busca_datos(nit: string): boolean;
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmRegistrocap: TFrmRegistrocap;

implementation

uses UnitQuerys, UnitdataQuerys,UnitGlobal,UnitVistaPreliminar,
  UnitPrincipal, UnitPantallaProgreso, UnitGlobales;

{$R *.dfm}

procedure TFrmRegistrocap.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        FrmQuerys := TFrmQuerys.Create(self);
        IBQuery1.Open;
        IBQuery1.Last;
end;

procedure TFrmRegistrocap.DBGrid1DblClick(Sender: TObject);
begin
        CDasistenete.Edit;
        if CDasistenetevalor.Text = 'NO' then
        begin
          CDasistenetevalor.Text :='SI';
          CDasisteneteasistio.Value := True;
        end
        else
        begin
          CDasistenetevalor.Text :='NO';
          CDasisteneteasistio.Value := False;
        end;
        CDasistenete.Post;
end;

procedure TFrmRegistrocap.cmChildKey(var msg: TWMKEY);
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

procedure TFrmRegistrocap.BitBtn1Click(Sender: TObject);
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
             reporte.Variables.ByName['participante'].AsString := 'Ahorradores';
          if reporte.PrepareReport then          begin
            frmVistaPreliminar.Reporte := reporte;
            frmVistaPreliminar.ShowModal;
          end;
          Close;
        end;
end;
procedure TFrmRegistrocap.BitBtn2Click(Sender: TObject);
begin
        if FrmQuerys.IBregistro.Transaction.InTransaction then
           FrmQuerys.IBregistro.Transaction.Commit;
        FrmQuerys.IBregistro.Transaction.StartTransaction;

        if (tipo_capacitacion) and (Acta.Text = '' ) then
        begin
          MessageDlg('Tipo de Capacitacion Básico es Necesaria el Acta',mtInformation,[mbok],0);
          Acta.SetFocus;
          Exit;
        end;
        if MessageDlg('Esta Seguro de Realizar la Transaccion...',mtinformation,[mbyes,mbno],0) = mryes then
        begin
          with CDasistenete do
          begin
            First;
            while not Eof do
            begin
              if FieldValues['asistio'] = False then
              begin
                with DataQuerys.IBdatos do
                begin
                  Close;
                  verificatransaccion(DataQuerys.IBdatos);
                  SQL.Clear;
                  SQL.Add('delete from "fun$capacitacionper"');
                  SQL.Add('where "fun$capacitacionper"."id_persona" = :nit');
                  SQL.Add('and "fun$capacitacionper"."id_capacitacion" = :id_capacitacion');
                  ParamByName('nit').AsString := CDasistenete.FieldValues['documento'];
                  ParamByName('id_capacitacion').AsInteger := descripcion.KeyValue;
                  Open;
                  Close;
                  Transaction.Commit;
                end;
              end
              else
              begin
                educacion(CDasistenete.FieldValues['documento']);
              end;
              Next;
            end;
          end;
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('update "fun$capacitacion" set');
          SQL.Add('"fun$capacitacion"."estado" = 0');
          SQL.Add('where "fun$capacitacion"."id_capacitacion" = :id_capacitacion');
          ParamByName('id_capacitacion').AsInteger := descripcion.KeyValue;
          Open;
          Close;
          Transaction.Commit;
          CDasistenete.CancelUpdates;
          ejecutarclick(Self);
        end;
        end;
        IBQuery1.Close;
        IBQuery1.Open;
        FrmQuerys.IBregistro.Transaction.Commit;
end;

procedure TFrmRegistrocap.EjecutarClick(Sender: TObject);
var     nombre,telefono :string;
        id_identificacion :Integer;
begin
        CDasistenete.CancelUpdates;
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
          SQL.Add('"fun$capacitacionper"."oficina"');
          SQL.Add('FROM');
          SQL.Add('"fun$capacitacionper"');
          SQL.Add('WHERE');
          SQL.Add('("fun$capacitacionper"."id_capacitacion" = :id_capacitacion)');
          ParamByName('id_capacitacion').AsSmallInt := descripcion.KeyValue;
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Titulo := 'Generando Listado';
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Participante No : ' + IntToStr(RecNo);
            Application.ProcessMessages;
            if FieldByName('oficina').AsInteger = agencia then
            begin
              {with FrmQuerys.IBseleccion do
              begin
                Close;
                verificatransaccion(FrmQuerys.IBseleccion);
                SQL.Clear;
                SQL.Add(' select * from BUSCA_PERSONA_N1(:NIT)');
                ParamByName('NIT').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                Open;}
                //
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
                  ParamByName('ID_AGENCIA').AsInteger := 1;
                  ParamByName('ID_TIPO_CAPTACION').AsInteger := 2;
                  ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
                  ParamByName('ID_PERSONA').AsString := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                  ExecQuery;

                //
                CDasistenete.Append;
                CDasistenete.FieldValues['documento'] := DataQuerys.IBdatos.FieldByName('id_persona').AsString;
                CDasistenete.FieldValues['nombres'] := nombre;
                CDasistenete.FieldValues['asistio'] := True;
                CDasistenete.FieldValues['valor'] := 'SI';
                CDasistenete.FieldValues['cuenta'] := FieldByName('NUMERO_CUENTA').AsString;
                CDasistenete.FieldValues['edad'] := 0;//edad(FieldByName('FECHA_NACIMIENTO').AsDateTime);
                CDasistenete.FieldValues['telefono'] := telefono;
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
          frmProgresos.Cerrar;
        end;

end;
procedure TFrmRegistrocap.descripcionExit(Sender: TObject);
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$capacitacion"."fecha","fun$capacitacion"."id_tipocapacitacion"');
          SQL.Add('FROM');
          SQL.Add('"fun$capacitacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$capacitacion"."id_capacitacion" = :id)');
          ParamByName('id').AsInteger := descripcion.KeyValue;
          Open;
          Fecha.Text := FormatDateTime('dd " de " mmm-yyyy',FieldByName('fecha').AsDateTime);
          if FieldByName('id_tipocapacitacion').AsInteger = 1 then
             tipo_capacitacion := True
          else
             tipo_capacitacion := False;
          Close;
        end;
end;

procedure TFrmRegistrocap.educacion(nit:string);
begin
        if tipo_capacitacion then
        begin
          with FrmQuerys.IBregistro do
          begin
            Close;
            SQL.Clear;
            SQL.Add('update "gen$persona" set');
            SQL.Add('EDUCACION = 1,');
            SQL.Add('ACTA = :acta');
            SQL.Add('where id_persona = :id_persona');
            ParamByName('acta').AsString := Acta.Text;
            ParamByName('id_persona').AsString := nit;
            Open;
            Close;
          end;
        end;
end;

function TFrmRegistrocap.busca_datos(nit: string): boolean;
begin

end;

end.
