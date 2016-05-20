unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, IniFiles;

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    GenerarArchivoExcel1: TMenuItem;
    Salir1: TMenuItem;
    procedure Salir1Click(Sender: TObject);
    procedure GenerarArchivoExcel1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses UnitGlobal, UnitTConexion, UnitAExcel;
{$R *.dfm}

procedure TfrmMain.FormShow(Sender: TObject);
var
  _tconexion :TConexion;
  _sMiIni :string;
begin
  _tconexion := TConexion.Create;

  _sMiINI := ChangeFileExt(Application.ExeName,'.ini');
  with TIniFile.Create(_sMiINI) do
  try
    _sDBserver := ReadString('DBNAME','server','0.0.0.0');
    _sDBPath := ReadString('DBNAME','path','/tmp/');
    _sDBname := ReadString('DBNAME','name','database.fdb');
    _sEmpresa := ReadString('EMPRESA','name','CREDISERVIR LTDA');
    _sNit     := ReadString('EMPRESA','nit','890.505.363-6');
    _iAgencia  := ReadInteger('EMPRESA','Agencia',1);
    _sCiudad  := ReadString('EMPRESA','city','OCAÑA N.S.');
  finally
    free;
  end;

  if not _tconexion.ValidaUsuario then
    self.Close;
end;

procedure TfrmMain.GenerarArchivoExcel1Click(Sender: TObject);
var
  frmAExcel: TfrmAExcel;
begin
  frmAExcel := TfrmAExcel.Create(self);
end;

procedure TfrmMain.Salir1Click(Sender: TObject);
begin
  Self.Close;
end;

end.
