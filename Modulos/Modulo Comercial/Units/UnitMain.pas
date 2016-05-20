unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles,Menus,UnitTConexion, JvSimpleXml, StdCtrls;

type
  TFrmMain = class(TForm)
    MainMenu1: TMainMenu;
    Generales1: TMenuItem;
    ProcesosEspeciales1: TMenuItem;
    CAmbiarContrasea1: TMenuItem;
    Informes1: TMenuItem;
    Salir1: TMenuItem;
    Contratuales1: TMenuItem;
    JvSimpleXML1: TJvSimpleXML;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure Contratuales1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
uses UnitGlobal, UnitCrearContratual,UnitLogin;

{$R *.dfm}

procedure TFrmMain.Button1Click(Sender: TObject);
var
    ADoc: TJvSimpleXml;
    Root:TJvSimpleXmlElemClassic;
    ANode:TJvSimpleXmlElemClassic;
    Nodo:TJvSimpleXmlElemClassic;
begin
         Adoc := TJvSimpleXml.Create(Self);
         ADoc.Root.Name := 'query_info';
         ANode := ADoc.Root.Items.Add('querys');
         Nodo := ANode.Items.Add('query');
         Nodo.Items.Add('tipo','select');
         Nodo.Items.Add('sentencia','select * from "col$estado');
         ADoc.SaveToFile('C:\Peticion2.xml');

end;

procedure TFrmMain.Contratuales1Click(Sender: TObject);
begin
  FrmCrearContractual := TFrmCrearContractual.Create(Self);
  FrmCrearContractual.ShowModal
end;

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
    frmLogin:TfrmLogin;
    Veces :SmallInt;
    Mensaje :string;

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
        _sDBRole := 'CAPTACIONES';
        Veces := 0;
        frmLogin := TfrmLogin.Create(nil);
        frmLogin.EdRole.Text := _sDBrole;
        _bSalir := False;
        while Not _bSalir do
        begin
           if Veces = 3 then
                Exit;
           if frmLogin.ShowModal = mrOk then
           begin
             with frmLogin do
             begin
                _sDBUser := EdUsuario.Text;
                _sDBPass:= EdPasabordo.Text;
                _sDBRole := EdRole.Text;
                Veces := Veces + 1;
                _tConexion := TConexion.Create;
                _bSalir := _tConexion.ValidaUsuario;
                if not (_bSalir) then               
                  _tConexion.Destroy;
             end;//fin del begin del with
            end // fin del if
            else
            begin
              _bSalir := False;
              Exit;
            end; // fim deñ ese if
        end;
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
