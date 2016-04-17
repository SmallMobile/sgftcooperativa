unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles,UnitTconexion, Menus;

type
  TFrmMain = class(TForm)
    MainMenu1: TMainMenu;
    Generales1: TMenuItem;
    ProcesosEspeciales1: TMenuItem;
    CAmbiarContrasea1: TMenuItem;
    Informes1: TMenuItem;
    Salir1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
  private
  _tConexion :TConexion;
  _bSalir :Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation
uses UnitGlobal;

{$R *.dfm}

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if _bSalir then
  begin
   if MessageDlg('Seguro que desea Cerrar el Módulo',mtConfirmation,[mbYes,mbNo],0) = mrYes Then
      Canclose := true
   else
      Canclose := False
  end
  else
    Canclose := true
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var MiINI :string;
begin
    MiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(MiINI) do
  try
    _sDBserver := ReadString('DBNAME','server','192.168.200.2');
    _sDBPath := ReadString('DBNAME','path','/var/db/fbird/');
    _sDBname := ReadString('DBNAME','name','database.fdb');
    _sEmpresa := ReadString('EMPRESA','name','CREDISERVIR LTDA');
    _sNit     := ReadString('EMPRESA','nit','890.505.363-6');
    _iAgencia := ReadInteger('EMPRESA','Agencia',1);
    _sCiudad  := ReadString('EMPRESA','city','OCAÑA N.S.');
    _cDBMinutos := ReadFloat('ADICIONALES','timerrelogin',5);
  finally
    free;
  end;
  _tConexion := TConexion.Create;
  _tConexion.DBrole := 'CREDITOS';
  _bSalir := _tConexion.ValidaUsuario;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
        if not _bSalir then
           Self.Close;

end;

procedure TFrmMain.Salir1Click(Sender: TObject);
begin
  Close;
end;

end.
