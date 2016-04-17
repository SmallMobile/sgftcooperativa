unit UnitCotrasena;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, JvStaticText, Buttons, DB, IBCustomDataSet,
  IBQuery;

type
  TFrmContrasena = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    JvLogin: TJvStaticText;
    JvEmpleado: TJvStaticText;
    Panel2: TPanel;
    CmdAceptar: TBitBtn;
    CmdCancelar: TBitBtn;
    Panel3: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EdCont1: TEdit;
    EdCont2: TEdit;
    EdCont3: TEdit;
    IBQuery1: TIBQuery;
    procedure CmdCancelarClick(Sender: TObject);
    procedure CmdAceptarClick(Sender: TObject);
    procedure EdCont1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmContrasena: TFrmContrasena;

implementation
uses UnitGlobales;

{$R *.dfm}

procedure TFrmContrasena.CmdCancelarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmContrasena.CmdAceptarClick(Sender: TObject);
begin
        if DBPasabordo <> EdCont1.Text then
        begin
          ShowMessage('La Contraseña Actual no Concuerda, Favor Revise');
          Exit;
        end;
        if EdCont2.Text <> EdCont3.Text then
        begin
          ShowMessage('Las Contraseñas Digitadas no Concuerdan, Favor Revise');
          Exit;
        end;
        with IBQuery1 do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('update "gen$empleado" set CONTRASENA = :CONTRASENA where ID_EMPLEADO = :ID_EMPLEADO');
          ParamByName('ID_EMPLEADO').AsString := DBAlias;
          ParamByName('CONTRASENA').AsString := UpperCase(EdCont2.Text);
          ExecSQL;
          Transaction.Commit;
          CmdAceptar.Enabled := False;
          Panel3.Enabled := False;
          ShowMessage('Contraseña Actualizada con Exito');
        end;
end;

procedure TFrmContrasena.EdCont1KeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TFrmContrasena.FormCreate(Sender: TObject);
begin
        with IBQuery1 do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('select * from "gen$empleado" where ID_EMPLEADO = :ID_EMPLEADO');
          ParamByName('ID_EMPLEADO').AsString := DBAlias;
          Open;
          JvLogin.Caption := DBAlias;
          JvEmpleado.Caption := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString; 
        end;

end;

end.
