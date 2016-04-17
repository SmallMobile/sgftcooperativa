unit UnitBasesFuentes;

interface

uses
  IniFiles, SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QGrids, QDBGrids, DBXpress, DB, SqlExpr, QButtons,
  FMTBcd, Provider, DBClient, DBLocal, DBLocalS;

type
  TfrmMgrFuentes = class(TForm)
    DBGrid: TDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    EdDBFuente: TEdit;
    Od1: TOpenDialog;
    btnAbrir: TBitBtn;
    Panel2: TPanel;
    btnAdicionar: TBitBtn;
    btnRemover: TBitBtn;
    DataSource: TDataSource;
    SQLConn2: TSQLConnection;
    Panel3: TPanel;
    Label2: TLabel;
    EdUsuario: TEdit;
    Label3: TLabel;
    EdContrasena: TEdit;
    SQLQuery1: TSQLQuery;
    SQLTable1: TSQLClientDataSet;
    btnCerrar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
    procedure btnCerrarClick(Sender: TObject);
  private
    procedure Inicializar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMgrFuentes: TfrmMgrFuentes;
  IDT:TTransactionDesc;

implementation

{$R *.xfm}

procedure TfrmMgrFuentes.FormCreate(Sender: TObject);
var
  MiIni:TIniFile;
  EdDBMgr,EdUsuario,EdContrasena:string;
begin
      MiIni := TIniFile.Create(ExtractFilepath(Application.ExeName)+'/Repl.ini');
      EdDBMgr := MiIni.ReadString('MANAGER','Ruta','');
      EdUsuario := MiIni.ReadString('MANAGER','Usuario','');
      EdContrasena := MiIni.ReadString('MANAGER','Contrasena','');

      with SQLConn2 do
      begin
        Params.Clear;
        Params.Values['Database'] := EdDBMgr;
        Params.Values['User_name'] := EdUsuario;
        Params.Values['Password'] := EdContrasena;
        SQLConn2.Open;
        if not Connected then
        begin
          ShowMessage('Error al abrir DB de Configuración');
          Exit;
        end
        else
          Inicializar;
      end;

end;

procedure TfrmMgrFuentes.btnAdicionarClick(Sender: TObject);
begin
      if ( EdDBFuente.Text <> '' ) and
         ( EdUsuario.Text <> '' ) and
         ( EdContrasena.Text <> '') then
      begin
        SQLQuery1.Close;
        SQLQuery1.SQL.Clear;
        SQLQuery1.SQL.Add('insert into SOURCES (SOURCE_PATH,USERNAME,PASSWD)');
        SQLQuery1.SQL.Add('values (:SOURCE_PATH,:USERNAME,:PASSWD)');
        SQLQuery1.ParamByName('SOURCE_PATH').AsString := EdDBFuente.Text;
        SQLQuery1.ParamByName('USERNAME').AsString := EdUsuario.Text;
        SQLQuery1.ParamByName('PASSWD').AsString := EdContrasena.Text;
        try
          SQLQuery1.ExecSQL;
          SQLConn2.Commit(IDT);
          Inicializar;
        except
          raise;
        end;
      end
      else
        MessageDlg('Falta algún parametro, Registro no adicionado',mterror,[mbCancel],0);

end;

procedure TfrmMgrFuentes.btnRemoverClick(Sender: TObject);
begin
        if MessageDlg('Seguro de Remover',mtConfirmation,[mbYes,mbNo],0) = mryes then
        begin
          SQLQuery1.Close;
          SQLQuery1.SQL.Clear;
          SQLQuery1.SQL.Add('delete from SOURCES where IDSOURCE =:ID');
          SQLQuery1.ParamByName('ID').AsInteger := SQLTable1.FieldByName('IDSOURCE').AsInteger;
          try
           SQLQuery1.ExecSQL;
           SQLConn2.Commit(IDT);
           Inicializar;
          except
           raise;
          end;
        end;
end;

procedure TfrmMgrFuentes.Inicializar;
begin
          IDT.TransactionID := 2;
          SQLConn2.StartTransaction(IDT);
          SQLTable1.Close;
          SQLTable1.Open;
end;

procedure TfrmMgrFuentes.btnAbrirClick(Sender: TObject);
begin
        if Od1.Execute then
          EdDBFuente.Text := Od1.FileName;
end;

procedure TfrmMgrFuentes.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

end.
