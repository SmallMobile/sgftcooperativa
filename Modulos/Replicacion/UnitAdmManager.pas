unit UnitAdmManager;

interface

uses
  IniFiles,SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QButtons, DBXpress, DB, SqlExpr;

type
  TfrmAdmMgr = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    EdDBMgr: TEdit;
    Panel2: TPanel;
    Label2: TLabel;
    EdUsuario: TEdit;
    Label3: TLabel;
    EdContrasena: TEdit;
    Panel3: TPanel;
    btnProbar: TBitBtn;
    btnGuardar: TBitBtn;
    btnCerrar: TBitBtn;
    SQLConn: TSQLConnection;
    Od1: TOpenDialog;
    btnAbrir: TBitBtn;
    procedure btnCerrarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnProbarClick(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdmMgr: TfrmAdmMgr;

implementation

{$R *.xfm}

procedure TfrmAdmMgr.btnCerrarClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmAdmMgr.btnGuardarClick(Sender: TObject);
var
  MiIni:TIniFile;
begin
     try
      MiIni := TIniFile.Create(ExtractFilepath(Application.ExeName)+'/Repl.ini');
      MiIni.WriteString('MANAGER','Ruta',EdDBMgr.Text);
      MiIni.WriteString('MANAGER','Usuario',EdUsuario.Text);
      MiIni.WriteString('MANAGER','Contrasena',EdContrasena.Text);
      ShowMessage('Cambios Guardados con Exito!');
     except
      ShowMessage('Error al Guardar Cambios!');
     end;
end;

procedure TfrmAdmMgr.FormCreate(Sender: TObject);
var
  MiIni:TIniFile;
begin
      MiIni := TIniFile.Create(ExtractFilepath(Application.ExeName)+'/Repl.ini');
      EdDBMgr.Text := MiIni.ReadString('MANAGER','Ruta','');
      EdUsuario.Text := MiIni.ReadString('MANAGER','Usuario','');
      EdContrasena.Text := MiIni.ReadString('MANAGER','Contrasena','');

end;

procedure TfrmAdmMgr.btnProbarClick(Sender: TObject);
begin
        with SQLConn do
        begin
          Params.Clear;
          Params.Values['Database'] := EdDBMgr.Text;
          Params.Values['User_name'] := EdUsuario.Text;
          Params.Values['Password'] := EdContrasena.Text;
          SQLConn.Open;
          if SQLConn.Connected then
            ShowMessage('Conexión Exitosa!')
          else
            ShowMessage('Conexión Fallida!');
        end;
end;

procedure TfrmAdmMgr.btnAbrirClick(Sender: TObject);
begin
        if Od1.Execute then
          EdDBMgr.Text := Od1.FileName;
end;

end.
