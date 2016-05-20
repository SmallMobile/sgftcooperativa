unit UnitCambioFecha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, IBDatabase,IniFiles, JvComponent,
  JvBaseDlg, JvPasswordForm, StdCtrls, ExtCtrls, JvEdit, DBCtrls, ComCtrls,
  Buttons;

type
  TForm1 = class(TForm)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBconsulta: TIBQuery;
    jv: TJvPasswordForm;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    tipo: TDBLookupComboBox;
    numero: TJvEdit;
    Panel2: TPanel;
    Label3: TLabel;
    asociado: TEdit;
    Panel3: TPanel;
    Label4: TLabel;
    fecha1: TDateTimePicker;
    Label5: TLabel;
    fecha2: TDateTimePicker;
    Panel4: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    IBTransaction2: TIBTransaction;
    IBTipo: TIBQuery;
    DataSource1: TDataSource;
    s1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure jvOk(Sender: TObject; Password: String; var Accept: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure tipoKeyPress(Sender: TObject; var Key: Char);
    procedure numeroKeyPress(Sender: TObject; var Key: Char);
    procedure fecha2KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure numeroExit(Sender: TObject);
    procedure s1Click(Sender: TObject);
  private
      password1,password2 :string;
    salir :Boolean;
    archivo :TextFile;
    vCuenta :Integer;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses UnitCuadro;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var     server,MiINI,oficina,codigo :string;
begin
  MiINI := ExtractFilePath(Application.ExeName) + 'Consulta.ini';
  with TIniFile.Create(MiINI) do
  try
    server := ReadString('DBNAME','server','');
    oficina := ReadString('DBNAME','oficina','');
    codigo :=  ReadString('DBNAME','codigo','');
  finally
    free;
  end;
  salir := True;
  password1 := 'svr00' + codigo;
  jv.Execute;
  Self.Caption := 'Conectado a: ' + oficina + ' Cambio de Fechas 2007/08/27'; //+ ', ' + server + ' V.2007/03/01 Mej.';
  if LowerCase(password2) = password1 then
  begin
      try
       FrmCuadro := TFrmCuadro.Create(Self);
       IBDatabase1.DatabaseName := server;
       IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
       IBDatabase1.Params.Values['User_Name'] := 'SYSDBA';
       IBDatabase1.Params.Values['PassWord'] := 'masterkey';
       IBDatabase1.Connected := False;
       IBDatabase1.Connected := True;
       IBTransaction1.Active := True;
      except
       Application.Terminate;
      end;
  end
  else
  begin
     ShowMessage('Contraseña Incorrecta');
     Application.Terminate;
  end;
  //ShowMessage(IBDatabase1.DatabaseName);
  if ibtransaction2.InTransaction then
     ibtransaction2.Rollback;
  ibtransaction2.StartTransaction;
  IBTipo.Close;
  IBTipo.Open;
  IBTipo.Last;
  tipo.KeyValue := 3;

end;

procedure TForm1.jvOk(Sender: TObject; Password: String;
  var Accept: Boolean);
begin
       Password2 := Password;
       Accept := True;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
        IBTransaction1.Active := False;
        IBDatabase1.Connected := False;
        Close;
end;

procedure TForm1.tipoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           numero.SetFocus;
end;

procedure TForm1.numeroKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           fecha2.SetFocus

end;

procedure TForm1.fecha2KeyPress(Sender: TObject; var Key: Char);
begin
      if Key = #13 then
         BitBtn1.SetFocus;

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
        if MessageDlg('Esta Seguro de Realizar la Operacion',mtInformation,[mbyes,mbno],0) = mrno then
           Exit;
        with IBconsulta do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update "cap$maestro" set FECHA_APERTURA = :FECHA where NUMERO_CUENTA = :NUMERO AND ID_TIPO_CAPTACION IN (1,2)');
          ParamByName('NUMERO').AsInteger := vCuenta;
          ParamByName('FECHA').AsDate := fecha2.DateTime;
          try
            ExecSQL;
            Transaction.Commit;
          except
          begin
             ShowMessage('Error al Actualizar');
             Transaction.Rollback;
          end;
          end;
            ShowMessage('Actualizado con Exito!!!');
            s1.Click;
        end;
end;

procedure TForm1.numeroExit(Sender: TObject);
begin
        vCuenta := 0;
        fecha2.Date := Date;
        if numero.Text = '' then
           Exit;
        with IBconsulta do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"gen$persona".NOMBRE,');
          SQL.Add('"gen$persona".PRIMER_APELLIDO,');
          SQL.Add('"gen$persona".SEGUNDO_APELLIDO,');
          SQL.Add('"cap$maestro".NUMERO_CUENTA,"cap$maestro".FECHA_APERTURA');
          SQL.Add('FROM');
          SQL.Add('"cap$maestrotitular"');
          SQL.Add('INNER JOIN "cap$maestro" ON ("cap$maestrotitular".ID_AGENCIA="cap$maestro".ID_AGENCIA)');
          SQL.Add('AND ("cap$maestrotitular".ID_TIPO_CAPTACION="cap$maestro".ID_TIPO_CAPTACION)');
          SQL.Add('AND ("cap$maestrotitular".NUMERO_CUENTA="cap$maestro".NUMERO_CUENTA)');
          SQL.Add('AND ("cap$maestrotitular".DIGITO_CUENTA="cap$maestro".DIGITO_CUENTA)');
          SQL.Add('INNER JOIN "gen$persona" ON ("gen$persona".ID_IDENTIFICACION="cap$maestrotitular".ID_IDENTIFICACION)');
          SQL.Add('AND ("gen$persona".ID_PERSONA="cap$maestrotitular".ID_PERSONA)');
          SQL.Add('WHERE');
          SQL.Add('("cap$maestro".ID_ESTADO = 1) AND ');
          SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = 1) AND ');
          SQL.Add('("gen$persona".ID_IDENTIFICACION = :ID) AND ');
          SQL.Add('("gen$persona".ID_PERSONA = :ID_PERSONA)');
          ParamByName('ID_PERSONA').AsString := numero. Text;
          ParamByName('ID').AsInteger := tipo.KeyValue;
          Open;
          if RecordCount = 0 then
          begin
             ShowMessage('No se Encontraron Datos');
             numero.SetFocus;
             BitBtn1.Enabled := False;
          end
          else
          begin
            BitBtn1.Enabled := True;
            asociado.Text := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
            vCuenta := FieldByName('NUMERO_CUENTA').AsInteger;
            fecha1.DateTime := FieldByName('FECHA_APERTURA').AsDateTime;
          end;

        end;
end;

procedure TForm1.s1Click(Sender: TObject);
begin
        asociado.Text := '';
        numero.Text := '';
        BitBtn1.Enabled := False;
        tipo.SetFocus
end;

end.
