unit UnitUsuario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Buttons, ExtCtrls, DB, IBCustomDataSet,
  IBQuery, IBDatabase;

type
  TFrmUsuario = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CmdAceptar: TBitBtn;
    CmdCancelar: TBitBtn;
    Label1: TLabel;
    DbLogin: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    Panel3: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EdNombre: TEdit;
    EdPApellido: TEdit;
    EdSApellido: TEdit;
    EdContrasena: TEdit;
    BitBtn2: TBitBtn;
    IBQuery1: TIBQuery;
    DataSource1: TDataSource;
    IBTransaction1: TIBTransaction;
    IBQuery2: TIBQuery;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CmdAceptarClick(Sender: TObject);
    procedure CmdCancelarClick(Sender: TObject);
  private
    _sContrasena :string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUsuario: TFrmUsuario;

implementation
uses UnitGlobales;

{$R *.dfm}

procedure TFrmUsuario.BitBtn2Click(Sender: TObject);
begin
        EdNombre.Text := '';
        EdPApellido.Text := '';
        EdSApellido.Text := '';
        EdContrasena.Text := '';
        Panel1.Enabled := True;
        Panel3.Enabled := True;
        DbLogin.SetFocus;
        CmdAceptar.Enabled := True;
end;

procedure TFrmUsuario.FormCreate(Sender: TObject);
begin
        IBQuery1.Close;
        IBQuery1.Open;
        IBQuery1.Last;
        DbLogin.KeyValue := 'AUXILIAR';
end;

procedure TFrmUsuario.BitBtn1Click(Sender: TObject);
begin
        with IBQuery1 do
        begin
          EdNombre.Text := FieldByName('NOMBRE').AsString;
          EdPApellido.Text := FieldByName('PRIMER_APELLIDO').AsString;
          EdSApellido.Text := FieldByName('SEGUNDO_APELLIDO').AsString;
          _sContrasena := FieldByName('CONTRASENA').AsString;
        end;
        Panel1.Enabled := False;
end;

procedure TFrmUsuario.CmdAceptarClick(Sender: TObject);
begin
        if MessageDlg('Esta Seguro(a) de Realizar la Transaccion',MtInformation,[mbYes,mbNo],0) = Mrno then
           Exit;
        if Trim(EdContrasena.Text) <> '' then
           _sContrasena := EdContrasena.Text;
        with IBQuery2 do
        begin
          Close;
          if Transaction.InTransaction then
            Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('update "gen$empleado" set NOMBRE = :NOMBRE, PRIMER_APELLIDO = :PRIMER_APELLIDO, SEGUNDO_APELLIDO = :SEGUNDO_APELLIDO, CONTRASENA = :CONTRASENA');
          SQL.Add('where ID_EMPLEADO = :ID_EMPLEADO');
          ParamByName('NOMBRE').AsString := EdNombre.Text;
          ParamByName('SEGUNDO_APELLIDO').AsString := EdSApellido.Text;
          ParamByName('PRIMER_APELLIDO').AsString := EdPApellido.Text;
          ParamByName('CONTRASENA').AsString := _sContrasena;
          ParamByName('ID_EMPLEADO').AsString := DbLogin.KeyValue;
          ExecSQL;
          Transaction.Commit;
          ShowMessage('Registro Actualizado con Exito');
          Panel3.Enabled := False;
          CmdAceptar.Enabled := False;
        end;
end;

procedure TFrmUsuario.CmdCancelarClick(Sender: TObject);
begin
        Close;
end;

end.
