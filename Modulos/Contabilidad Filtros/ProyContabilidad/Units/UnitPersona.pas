unit UnitPersona;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, ComCtrls, DB, IBCustomDataSet,
  IBQuery, IBDatabase, Buttons;

type
  TFrmPersona = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label49: TLabel;
    Label50: TLabel;
    EdIdentificacion: TMemo;
    EdNombre1: TEdit;
    Label1: TLabel;
    EdNombre2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EdApellido1: TEdit;
    Label4: TLabel;
    EdApellido2: TEdit;
    Label5: TLabel;
    EdMail: TEdit;
    Label6: TLabel;
    DtFecha: TDateTimePicker;
    Label7: TLabel;
    EdDireccion: TEdit;
    Label8: TLabel;
    EdBarrio: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    EdTelefono1: TMemo;
    EdTelefono2: TMemo;
    DbPais: TDBLookupComboBox;
    Label11: TLabel;
    DbMunicipio: TDBLookupComboBox;
    DBtipo: TDBLookupComboBox;
    IBMunicipio: TIBQuery;
    IBPais: TIBQuery;
    IBtipo: TIBQuery;
    DsTipo: TDataSource;
    DsMunicipio: TDataSource;
    DsPais: TDataSource;
    IBTipos: TIBTransaction;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    IBQuery1: TIBQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBtipoKeyPress(Sender: TObject; var Key: Char);
    procedure DBtipoEnter(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EdIdentificacionExit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    _bActualiza :Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPersona: TFrmPersona;

implementation
uses UnitGlobales;

{$R *.dfm}

procedure TFrmPersona.FormCreate(Sender: TObject);
begin
        IBtipo.Close;
        IBtipo.Open;
        IBtipo.Last;
        DBtipo.KeyValue := 3;
        IBMunicipio.Close;
        IBMunicipio.Open;
        IBMunicipio.Last;
        DbMunicipio.KeyValue := 54498;
        IBPais.Close;
        IBPais.Open;
        IBPais.Last;
        DbPais.KeyValue := 160;
end;

procedure TFrmPersona.FormKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self)
end;

procedure TFrmPersona.DBtipoKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self)
end;

procedure TFrmPersona.DBtipoEnter(Sender: TObject);
begin
        DBtipo.DropDown
end;

procedure TFrmPersona.BitBtn2Click(Sender: TObject);
begin
    EdIdentificacion.Text := '';
    EdNombre1.Text := '';
    EdNombre2.Text := '';
    EdApellido1.Text := '';
    EdApellido2.Text := '';
    EdMail.Text := '';
    EdDireccion.Text := '';
    EdBarrio.Text := '';
    EdTelefono1.Text := '';
    EdTelefono2.Text := '';
    EdIdentificacion.Enabled := True;
    DBtipo.SetFocus;
end;

procedure TFrmPersona.BitBtn1Click(Sender: TObject);
begin
        if MessageDlg('Esta Seguro(a) de Realizar la Transaccion',mtWarning,[mbyes,mbno],0) = mrNo then
          Exit;
        with IBQuery1 do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
            SQL.Clear;
          if _bActualiza then // si es actualizacion
          begin
            SQL.Add('UPDATE');
            SQL.Add('"gen$persona"');
            SQL.Add('SET');
            SQL.Add('NOMBRE = :NOMBRE,');
            SQL.Add('SEGUNDO_NOMBRE = :SEGUNDO_NOMBRE,');
            SQL.Add('PRIMER_APELLIDO = :PRIMER_APELLIDO,');
            SQL.Add('SEGUNDO_APELLIDO = :SEGUNDO_APELLIDO,');
            SQL.Add('FECHA_NACIMIENTO = :FECHA_NACIMIENTO,');
            SQL.Add('DIRECCION = :DIRECCION,');
            SQL.Add('MUNICIPO = :MUNICIPO,');
            SQL.Add('BARRIO = :BARRIO,');
            SQL.Add('TELEFONO1 = :TELEFONO1,');
            SQL.Add('TELEFONO2 = :TELEFONO2,');
            SQL.Add('EMAIL = :EMAIL,');
            SQL.Add('ID_EMPLEADO = :ID_EMPLEADO,');
            SQL.Add('FECHA_ACTUALIZACION = :FECHA_ACTUALIZACION');
            SQL.Add('WHERE');
            SQL.Add('ID_IDENTIFICACION = :ID_IDENTIFICACION AND');
            SQL.Add('ID_PERSONA = :ID_PERSONA');
          end// find de la validacion del actuliza
          else
          begin     //insercion
            SQL.Add('INSERT INTO');
            SQL.Add('"gen$persona"(');
            SQL.Add('ID_IDENTIFICACION,');
            SQL.Add('ID_PERSONA,');
            SQL.Add('NOMBRE,');
            SQL.Add('SEGUNDO_NOMBRE,');
            SQL.Add('PRIMER_APELLIDO,');
            SQL.Add('SEGUNDO_APELLIDO,');
            SQL.Add('FECHA_NACIMIENTO,');
            SQL.Add('DIRECCION,');
            SQL.Add('MUNICIPO,');
            SQL.Add('BARRIO,');
            SQL.Add('TELEFONO1,');
            SQL.Add('TELEFONO2,');
            SQL.Add('EMAIL,');
            SQL.Add('ID_EMPLEADO,');
            SQL.Add('FECHA_ACTUALIZACION)');
            SQL.Add('VALUES(');
            SQL.Add(':ID_IDENTIFICACION,');
            SQL.Add(':ID_PERSONA,');
            SQL.Add(':NOMBRE,');
            SQL.Add(':SEGUNDO_NOMBRE,');
            SQL.Add(':PRIMER_APELLIDO,');
            SQL.Add(':SEGUNDO_APELLIDO,');
            SQL.Add(':FECHA_NACIMIENTO,');
            SQL.Add(':DIRECCION,');
            SQL.Add(':MUNICIPO,');
            SQL.Add(':BARRIO,');
            SQL.Add(':TELEFONO1,');
            SQL.Add(':TELEFONO2,');
            SQL.Add(':EMAIL,');
            SQL.Add(':ID_EMPLEADO,');
            SQL.Add(':FECHA_ACTUALIZACION)');
          end;
          ParamByName('ID_IDENTIFICACION').AsInteger := DBtipo.KeyValue;
          ParamByName('ID_PERSONA').AsString := EdIdentificacion.Text;
          ParamByName('NOMBRE').AsString := EdNombre1.Text;
          ParamByName('SEGUNDO_NOMBRE').AsString := EdNombre2.Text;
          ParamByName('PRIMER_APELLIDO').AsString := EdApellido1.Text;
          ParamByName('SEGUNDO_APELLIDO').AsString := EdApellido2.Text;
          ParamByName('FECHA_NACIMIENTO').AsDate := DtFecha.DateTime;
          ParamByName('DIRECCION').AsString := EdDireccion.Text;
          ParamByName('MUNICIPO').AsInteger := DbMunicipio.KeyValue;
          ParamByName('BARRIO').AsString := EdBarrio.Text;
          ParamByName('TELEFONO1').AsString := EdTelefono1.Text;
          ParamByName('TELEFONO2').AsString := EdTelefono2.Text;
          ParamByName('EMAIL').AsString := EdMail.Text;
          ParamByName('ID_EMPLEADO').AsString := '';
          ParamByName('FECHA_ACTUALIZACION').AsDate := Date;
          try
            ExecSQL;
            Transaction.Commit;
            ShowMessage('Transaccion Realizada con Exito');
            BitBtn2.Click;
          except
            ShowMessage('Ha Ocurrido un Error Por favor Revise');
          end;

        end;// fin del with del IBquery
end;
procedure TFrmPersona.EdIdentificacionExit(Sender: TObject);
begin
        _bActualiza := False;
        with IBQuery1 do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('select * from "gen$persona" where ID_PERSONA = :ID_PERSONA and ID_IDENTIFICACION = :ID_IDENTIFICACION');
          ParamByName('ID_IDENTIFICACION').AsInteger := DBtipo.KeyValue;
          ParamByName('ID_PERSONA').AsString := EdIdentificacion.Text;
          Open;
          if RecordCount > 0 then
          begin
            if MessageDlg('La Persona ya Existe, Desea Actualizarla',mtWarning,[mbyes,mbno],0) = mrNo then
               BitBtn2.Click
            else
            begin
              _bActualiza := True;
              EdIdentificacion.Enabled := False;
              EdNombre1.Text := FieldByName('NOMBRE').AsString;
              EdNombre2.Text := FieldByName('SEGUNDO_NOMBRE').AsString;
              EdApellido1.Text := FieldByName('PRIMER_APELLIDO').AsString;
              EdApellido2.Text := FieldByName('SEGUNDO_APELLIDO').AsString;
              DtFecha.DateTime := FieldByName('FECHA_NACIMIENTO').AsDateTime;
              EdDireccion.Text := FieldByName('DIRECCION').AsString;
              DbMunicipio.KeyValue := FieldByName('MUNICIPO').AsInteger;
              EdBarrio.Text := FieldByName('BARRIO').AsString;
              EdTelefono1.Text := FieldByName('TELEFONO1').AsString;
              EdTelefono2.Text := FieldByName('TELEFONO2').AsString;
              EdMail.Text := FieldByName('EMAIL').AsString;
            end;
          end;

        end;
end;

procedure TFrmPersona.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

end.
