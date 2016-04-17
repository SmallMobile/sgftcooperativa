unit UnitEmpleado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, IBCustomDataSet, IBQuery,
  DBCtrls, ComCtrls, IBDatabase, JvEdit, JvTypedEdit, jclsysutils;

type
  TFrmEmpleado = class(TForm)
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    empleadonit: TComboBox;
    empleado: TComboBox;
    busca_nombre: TIBQuery;
    Label3: TLabel;
    Label4: TLabel;
    Fecha: TDateTimePicker;
    Label5: TLabel;
    TipoNomina: TDBLookupComboBox;
    IBTiponomina: TIBQuery;
    DStiponomina: TDataSource;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    Panel2: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBsalud: TDBLookupComboBox;
    DBpension: TDBLookupComboBox;
    DBriesgos: TDBLookupComboBox;
    IBtrantiponomina: TIBTransaction;
    IBTransempresa: TIBTransaction;
    IBsalud: TIBQuery;
    DSsalud: TDataSource;
    Label10: TLabel;
    salario: TJvCurrencyEdit;
    IBbuscaservicio: TIBQuery;
    IBriesgo: TIBQuery;
    IBpension: TIBQuery;
    DSpension: TDataSource;
    DSriesgo: TDataSource;
    Label11: TLabel;
    cuenta: TJvEdit;
    Chtransporte: TCheckBox;
    CHtiempo: TCheckBox;
    seccion: TEdit;
    DsAgencia: TDataSource;
    IBagencia: TIBQuery;
    DbAgencia: TDBLookupComboBox;
    Label12: TLabel;
    EdMail: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure FechaKeyPress(Sender: TObject; var Key: Char);
    procedure salarioKeyPress(Sender: TObject; var Key: Char);
    procedure TipoNominaKeyPress(Sender: TObject; var Key: Char);
    procedure DBsaludKeyPress(Sender: TObject; var Key: Char);
    procedure DBpensionKeyPress(Sender: TObject; var Key: Char);
    procedure DBriesgosKeyPress(Sender: TObject; var Key: Char);
    procedure CancelarClick(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure cuentaKeyPress(Sender: TObject; var Key: Char);
    procedure TipoNominaExit(Sender: TObject);
    procedure DBsaludExit(Sender: TObject);
    procedure DBpensionExit(Sender: TObject);
    procedure DBriesgosExit(Sender: TObject);
    procedure ChtransporteKeyPress(Sender: TObject; var Key: Char);
    procedure DbAgenciaKeyPress(Sender: TObject; var Key: Char);
    procedure cuentaExit(Sender: TObject);
    procedure EdMailKeyPress(Sender: TObject; var Key: Char);
  private
    nit_emp: Integer;
    cod_tiponomina: Integer;
    cod_salud :Integer;
    cod_pension :Integer;
    cod_riesgo :Integer;
    procedure actualizaempleado;
    procedure buscaempleado;
  public
  actualizar :Boolean;
  published
    procedure limpiar;
    procedure entra_datos;
    { Public declarations }
  end;

var
  FrmEmpleado: TFrmEmpleado;

implementation

uses UnitQuerys, UnitDatamodulo, UnitGlobal;

{$R *.dfm}

procedure TFrmEmpleado.FormCreate(Sender: TObject);
begin
        Fecha.DateTime := Date;
        Fecha.MaxDate := Date;
        IBTiponomina.Open;
        IBTiponomina.Last;
        IBsalud.Open;
        IBsalud.Last;
        IBpension.Open;
        IBpension.Last;
        IBriesgo.Open;
        IBriesgo.Last;
        IBagencia.Close;
        IBagencia.Open;
        IBagencia.Last;
        DbAgencia.KeyValue := 1;
        with DataQuerys.IBselecion do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Clear;
          SQL.Add('select "inv$empleado"."nombre","inv$empleado"."apellido"  from "inv$empleado"');
          SQL.Add('order by "inv$empleado"."nombre"');
          Open;
          while not Eof do
          begin
            empleado.Items.Add(FieldByName('nombre').AsString + ' ' + fieldbyname('apellido').AsString);
            empleadonit.Items.Add(FieldByName('nombre').AsString + fieldbyname('apellido').AsString);
            Next;
             end;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmEmpleado.BcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmEmpleado.empleadoExit(Sender: TObject);
var     a :Integer;
        b: string;
begin
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        busca_nombre.Close;
        verificatransaccion(busca_nombre);
        busca_nombre.parambyname('nombre').AsString := b;
        busca_nombre.Open;
        nit_emp := busca_nombre.fieldbyname('nit').AsInteger;
        seccion.Text := busca_nombre.fieldbyname('nombre').AsString;
        busca_nombre.Close;
        if nit_emp = 0 then
        begin
          MessageDlg('El Nombre del Empleado no es Correcto',mtInformation,[mbOK],0);
          empleado.SetFocus;
          Exit;
        end;
        if actualizar then
        begin
          with DataQuerys.IBselecion do
          begin
            Close;
            verificatransaccion(DataQuerys.IBselecion);
            SQL.Clear;
            SQL.Add('select * from "nom$empleado"');
            SQL.Add('where "nom$empleado"."nitempleado" = :nit');
            ParamByName('nit').AsInteger := nit_emp;
            Open;
            if RecordCount <> 0 then
            begin
              MessageDlg(empleado.Text+' ya se encuentra Registrado',mtInformation,[mbOK],0);
              seccion.Text := '';
              empleado.ItemIndex := -1;
              empleado.SetFocus;
            end;
            Close;
          end;
        end
        else
        buscaempleado;
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('  "nom$relacion".ID_AGENCIA');
          SQL.Add('FROM');
          SQL.Add(' "nom$relacion"');
          SQL.Add('WHERE');
          SQL.Add('  ("nom$relacion".NIT = :NIT)');
          ParamByName('NIT').AsInteger := nit_emp;
          Open;
          if RecordCount > 0 then
             DbAgencia.KeyValue := FieldByName('ID_AGENCIA').AsInteger
          else
             DbAgencia.KeyValue := Null;
        end;

end;

procedure TFrmEmpleado.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmEmpleado.empleadoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          DbAgencia.SetFocus;
end;

procedure TFrmEmpleado.FechaKeyPress(Sender: TObject; var Key: Char);
begin
          if Key = #13 then
            cuenta.SetFocus;
end;

procedure TFrmEmpleado.salarioKeyPress(Sender: TObject; var Key: Char);
begin
          if Key = #13 then
             TipoNomina.SetFocus;
end;

procedure TFrmEmpleado.TipoNominaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           Chtransporte.SetFocus
end;

procedure TFrmEmpleado.DBsaludKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           DBpension.SetFocus;
end;

procedure TFrmEmpleado.DBpensionKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           DBriesgos.SetFocus;
end;

procedure TFrmEmpleado.DBriesgosKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           BACEPTAR.SetFocus;
end;

procedure TFrmEmpleado.limpiar;
begin
        empleado.ItemIndex := -1;
        seccion.Text := '';
        salario.Value := 0;
        cuenta.Text := '';
        DBriesgos.KeyValue := -1;
        DBsalud.KeyValue := -1;
        DBpension.KeyValue := -1;
        TipoNomina.KeyValue := -1;
        empleado.SetFocus;
        Chtransporte.Checked := False;
        CHtiempo.Checked := False;
        EdMail.Text := '';
end;

procedure TFrmEmpleado.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmEmpleado.BACEPTARClick(Sender: TObject);
begin
        if salario.Value = 0 then
        begin
           MessageDlg('El Campo Salario no Puede ser Nulo',mtInformation,[mbOK],0);
           salario.SetFocus;
        end
        else if cod_tipoNomina = 0 then
        begin
          MessageDlg('El Campo T. Nomina no Puede ser Nulo',mtInformation,[mbOK],0);
          TipoNomina.SetFocus;
        end
        else if cod_salud = 0 then
        begin
          MessageDlg('El Campo Salud EPS no Puede ser Nulo',mtInformation,[mbOK],0);
          DBsalud.SetFocus;
        end
        else if cod_pension = 0 then
        begin
          MessageDlg('El Campo Pension AFP no Puede ser Nulo',mtInformation,[mbOK],0);
          DBpension.SetFocus;
        end
        else if cod_riesgo = 0 then
        begin
          MessageDlg('El Campo  Riesgos ARP no Puede ser Nulo',mtInformation,[mbOK],0);
          DBriesgos.SetFocus;
        end
        else
        begin
        if actualizar then
          entra_datos
        else
          actualizaempleado;
          limpiar;
        end;
end;

procedure TFrmEmpleado.cuentaKeyPress(Sender: TObject; var Key: Char);
begin
        Numerico(Self,Key);
        if Key = #13 then
           salario.SetFocus;
end;

procedure TFrmEmpleado.TipoNominaExit(Sender: TObject);
begin
        try
        cod_tiponomina := TipoNomina.KeyValue;
        except on E: Exception do
        if actualizar then
        cod_tiponomina := 0;
        end;
end;

procedure TFrmEmpleado.DBsaludExit(Sender: TObject);
begin
try
        cod_salud := DBsalud.KeyValue;
        except on E: Exception do
        if actualizar then
        cod_salud := 0;
        end;
end;

procedure TFrmEmpleado.DBpensionExit(Sender: TObject);
begin
try
        cod_pension := DBpension.KeyValue;
        except on E: Exception do
        if actualizar then
        cod_pension := 0;
        end;
end;

procedure TFrmEmpleado.DBriesgosExit(Sender: TObject);
begin
try
        cod_riesgo := DBriesgos.KeyValue;
        except on E: Exception do
        if actualizar then
        cod_riesgo := 0;
        end;
end;

procedure TFrmEmpleado.entra_datos;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('insert into "nom$empleado" values(');
          SQL.Add(':nitempleado,:numero_cuenta,:codigo_pension,');
          SQL.Add(':codigo_salud,:sueldo_basico,:tipo_nomina,:codigo_riesgo,:fecha_registro,:aux_transporte,:jornada,:mail)');
          ParamByName('nitempleado').AsInteger := nit_emp;
          ParamByName('numero_cuenta').AsString := cuenta.Text;
          ParamByName('codigo_pension').AsInteger := cod_pension;
          ParamByName('codigo_salud').AsInteger := cod_salud;
          ParamByName('sueldo_basico').AsCurrency := salario.Value;
          ParamByName('tipo_nomina').AsInteger := cod_tiponomina;
          ParamByName('codigo_riesgo').AsInteger := cod_riesgo;
          ParamByName('fecha_registro').AsDateTime := Fecha.DateTime;
          ParamByName('aux_transporte').AsInteger := BoolToInt(Chtransporte.Checked);
          ParamByName('jornada').AsInteger := BoolToInt(CHtiempo.Checked);
          ParamByName('mail').AsString := EdMail.Text;
          ExecSQL;
          SQL.Clear;
          SQL.Add('insert into "nom$obligaciones" values(:nit,:ano,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)');
          ParamByName('nit').AsInteger := nit_emp;
          ParamByName('ano').AsSmallInt := StrToInt(FormatDateTime('yyyy',date));
          ExecSQL;
          SQL.Clear;
          SQL.Add('insert into "nom$consolidado" values (0,0,0,0,:nit)');
          ParamByName('nit').AsInteger := nit_emp;
          ExecSQL;
          SQL.Clear;
          SQL.Add('insert into "nom$retefuente" values (:nit,0)');
          ParamByName('nit').AsInteger := nit_emp;
          ExecSQL;
          SQL.Clear;
          SQL.Add('insert into "nomina" values (:nombre,:basico,0,0,0,0,0,0,0,0,0,0,0,:mes,0,:nit,:tipo_nomina,0,0,0,0,0,0,0,0,0,0,0,0)');
          ParamByName('nombre').AsString := empleado.Text;
          ParamByName('basico').AsCurrency := salario.Value;
          ParamByName('mes').AsString := '00';
          parambyname('nit').AsInteger := nit_emp;
          ParamByName('tipo_nomina').AsInteger := TipoNomina.KeyValue;
          ExecSQL;
          try
            if (cuenta.Text = '0') and (DbAgencia.KeyValue <> -1) then
            begin
              Close;
              SQL.Clear;
              SQL.Add('insert into "nom$relacion" values(:ID_AGENCIA,:NIT)');
              ParamByName('NIT').AsInteger := nit_emp;
              ParamByName('ID_AGENCIA').AsInteger := DbAgencia.KeyValue;
              ExecSQL;
            end;
          except
          end;
          Close;
          SQL.Clear;
          SQL.Add('insert into "nom$recuperanomina" values (');
          SQL.Add(':nit,:tipo,:cuenta,:estado,:fecha)');
          ParamByName('nit').AsInteger := nit_emp;
          ParamByName('tipo').AsInteger := TipoNomina.KeyValue;
          ParamByName('cuenta').AsInteger := StrToInt(cuenta.Text);
          ParamByName('estado').AsInteger := 1;
          ParamByName('fecha').Clear;
          ExecSQL;
          Close;
          Transaction.Commit;
        end;

end;
procedure TFrmEmpleado.actualizaempleado;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('update "nom$empleado" set');
          SQL.Add('"nom$empleado"."numero_cuenta" = :numero_cuenta,');
          SQL.Add('"nom$empleado"."codigo_pension" = :codigo_pension,');
          SQL.Add('"nom$empleado"."codigo_salud" = :codigo_salud,');
          SQL.Add('"nom$empleado"."sueldobasico" = :sueldo_basico,');
          SQL.Add('"nom$empleado"."tipo_nomina" = :tipo_nomina,');
          SQL.Add('"nom$empleado"."codigo_riesgo" = :codigo_riesgo,');
          SQL.Add('"nom$empleado"."fecha_registro" = :fecha_registro,');
          SQL.Add('"nom$empleado"."aux_transporte" = :aux_transporte,');
          SQL.Add('"nom$empleado"."jornada" = :jornada,');
          SQL.Add('"nom$empleado"."MAIL" = :mail');
          SQL.Add('where "nom$empleado"."nitempleado" = :nitempleado');
          ParamByName('nitempleado').AsInteger := nit_emp;
          ParamByName('numero_cuenta').AsString := cuenta.Text;
          ParamByName('codigo_pension').AsInteger := cod_pension;
          ParamByName('codigo_salud').AsInteger := cod_salud;
          ParamByName('sueldo_basico').AsCurrency := salario.Value;
          ParamByName('tipo_nomina').AsInteger := cod_tiponomina;
          ParamByName('codigo_riesgo').AsInteger := cod_riesgo;
          ParamByName('fecha_registro').AsDateTime := Fecha.DateTime;
          ParamByName('aux_transporte').AsInteger := BoolToInt(Chtransporte.Checked);
          ParamByName('jornada').AsInteger := BoolToInt(CHtiempo.Checked);
          ParamByName('mail').AsString := EdMail.Text;
          ExecSQL;
          SQL.Clear;
          SQL.Add('update "nomina" set');
          SQL.Add('"nomina"."basico" = :basico');
          SQL.Add('where "nomina"."nit"  = :nit');
          ParamByName('basico').AsCurrency := salario.Value;
          ParamByName('nit').AsInteger := nit_emp;
          ExecSQL;
          Close;
          SQL.Clear;
          SQL.Add('delete from "nom$relacion" where NIT = :NIT');
          ParamByName('NIT').AsInteger := nit_emp;
          ExecSQL;
          try
            if (cuenta.Text = '0') and (DbAgencia.KeyValue <> -1) then
            begin
              Close;
              SQL.Clear;
              SQL.Add('insert into "nom$relacion" values(:ID_AGENCIA,:NIT)');
              ParamByName('NIT').AsInteger := nit_emp;
              ParamByName('ID_AGENCIA').AsInteger := DbAgencia.KeyValue;
              ExecSQL;
            end;
          except
          end;
          Close;
          SQL.Clear;
          SQL.Add('delete from "nom$recuperanomina" where "nom$recuperanomina"."nit_empleado" = :nit');
          ParamByName('nit').AsInteger := nit_emp;
          ExecSQL;
          Transaction.CommitRetaining;
          Close;
          SQL.Clear;
          SQL.Add('insert into "nom$recuperanomina" values (');
          SQL.Add(':nit,:tipo,:cuenta,:estado,:fecha)');
          ParamByName('nit').AsInteger := nit_emp;
          ParamByName('tipo').AsInteger := TipoNomina.KeyValue;
          ParamByName('cuenta').AsInteger := StrToInt(cuenta.Text);
          ParamByName('estado').AsInteger := 1;
          ParamByName('fecha').Clear;
          ExecSQL;
          Close;
          Transaction.Commit;
        end;

end;

procedure TFrmEmpleado.buscaempleado;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"nom$empleado"."codigo_pension",');
          SQL.Add('"nom$empleado"."codigo_salud",');
          SQL.Add('"nom$empleado"."sueldobasico",');
          SQL.Add('"nom$empleado"."fecha_registro",');
          SQL.Add('"nom$empleado"."tipo_nomina",');
          SQL.Add('"nom$empleado"."codigo_riesgo",');
          SQL.Add('"nom$empleado"."numero_cuenta",');
          SQL.Add('"nom$empleado"."aux_transporte",');
          SQL.Add('"nom$empleado"."jornada",');
          SQL.Add('"nom$empleado"."MAIL"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          CHtiempo.Checked := IntToBool(FieldByName('jornada').AsInteger);
          salario.Value := FieldByName('sueldobasico').AsCurrency;
          cuenta.Text := FieldByName('numero_cuenta').AsString;
          cod_tiponomina := FieldByName('tipo_nomina').AsInteger;
          cod_salud := FieldByName('codigo_salud').AsInteger;
          cod_pension := FieldByName('codigo_pension').AsInteger;
          cod_riesgo := FieldByName('codigo_riesgo').AsInteger;
          Fecha.DateTime := FieldByName('fecha_registro').AsDateTime;
          Chtransporte.Checked := IntToBool(FieldByName('aux_transporte').AsInteger);
          EdMail.Text := FieldByName('MAIL').AsString;
          TipoNomina.KeyValue := cod_tiponomina;
          DBsalud.KeyValue := cod_salud;
          DBpension.KeyValue := cod_pension;
          DBriesgos.KeyValue := cod_riesgo;
          Close;
          if salario.Value = 0 then
          begin
            MessageDlg('El Empleado no ha Sido Registrado Aun.',mtInformation,[mbok],0);
            empleado.SetFocus;
          end;
        end;
end;

procedure TFrmEmpleado.ChtransporteKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           EdMail.SetFocus
end;

procedure TFrmEmpleado.DbAgenciaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          Fecha.SetFocus;

end;

procedure TFrmEmpleado.cuentaExit(Sender: TObject);
begin
        if cuenta.Text = '' then
           cuenta.Text := '0';
end;

procedure TFrmEmpleado.EdMailKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           DBsalud.SetFocus

end;

end.
