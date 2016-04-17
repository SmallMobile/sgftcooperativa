unit Unitpermisos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IBDatabase, DB, StdCtrls, DBXpress, FMTBcd, ExtCtrls, SqlExpr,
  DBCtrls, ComCtrls, IBCustomDataSet, IBQuery, Buttons, DBClient,JclStrings,
  ImgList;

type
  TFrmPermisos = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabRole: TTabSheet;
    TabPermiso: TTabSheet;
    DsEmpleado: TDataSource;
    IBempleado: TIBQuery;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    Panel2: TPanel;
    LrnAsignado: TListBox;
    LrAsignado: TListBox;
    Label3: TLabel;
    Label4: TLabel;                                                                  
    BTquitar: TBitBtn;
    BTagregar: TBitBtn;
    BitBtn3: TBitBtn;
    IBroles: TIBQuery;
    IBnRoles: TIBQuery;
    Dbroles: TClientDataSet;
    Dbrolesrol: TStringField;
    Label5: TLabel;
    Panel3: TPanel;
    BtBuscar: TBitBtn;
    BitBtn5: TBitBtn;
    BtCancelar: TBitBtn;
    BitBtn7: TBitBtn;
    IBejecuta: TIBQuery;
    IBTransaction2: TIBTransaction;
    Label6: TLabel;
    DbAgencia: TDBLookupComboBox;
    TabReporte: TTabSheet;
    IBagencia: TIBQuery;
    DsAgencia: TDataSource;
    IBEmpSucursal: TIBQuery;
    CDempleado: TClientDataSet;
    CDempleadoid_empleado: TStringField;
    CDempleadonombre: TStringField;
    Panel4: TPanel;
    Label7: TLabel;
    DBmodulo: TDBLookupComboBox;
    LrPnAsignado: TListBox;
    LrPAsignado: TListBox;
    Label8: TLabel;
    Label9: TLabel;
    IBmodulo: TIBQuery;
    DSmodulo: TDataSource;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn8: TBitBtn;
    ImageList1: TImageList;
    TabActivar: TTabSheet;
    TabCrear: TTabSheet;
    DbEmpleado: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Edlogin: TEdit;
    Label10: TLabel;
    DbEmpleado1: TDBLookupComboBox;
    Panel5: TPanel;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DbEmpleadoClick(Sender: TObject);
    procedure BtBuscarClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BTagregarClick(Sender: TObject);
    procedure BTquitarClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure LrnAsignadoClick(Sender: TObject);
    procedure LrAsignadoClick(Sender: TObject);
    procedure TabPermisoShow(Sender: TObject);
    procedure TabReporteShow(Sender: TObject);
    procedure DbAgenciaExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure TabRoleShow(Sender: TObject);
    procedure DBmoduloClick(Sender: TObject);
    procedure DbEmpleado1Click(Sender: TObject);
  private
  ruta :string;
  Tipo :Char;
  vEmpleado :string;
    procedure Empleado(agencia: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPermisos: TFrmPermisos;

implementation

{$R *.dfm}

procedure TFrmPermisos.FormCreate(Sender: TObject);
begin
        TabPermiso.Enabled := False;
        TabReporte.Enabled := False;
        TabRole.Enabled := False;
        ruta := '192.168.200.254:/dbase/fpruebas/database.fdb';// DBserver + ':' + DBpath + DBname;
        FrmPermisos.Caption := 'Permisos Base de Datos ' + ruta;
        IBDatabase1.DataBaseName := ruta;
        IBDatabase1.Params.Values['lc_ctype'] := 'ISO8859_1';
        IBDatabase1.Params.Values['User_Name'] := 'SYSDBA';
        IBDatabase1.Params.Values['PassWord'] := 'masterkey';
        IBDatabase1.Connected := False;
        IBDatabase1.Connected := True;
        IBTransaction1.Active := True;
        IBagencia.Open;
        IBagencia.Last;
        DbAgencia.KeyValue := 1;
        Tipo := 'P';
        IBmodulo.Close;
        IBmodulo.Open;
        IBmodulo.Last;
        DBmodulo.KeyValue := 1;
end;

procedure TFrmPermisos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        IBDatabase1.Connected := False;
        IBTransaction1.Active := False;

end;

procedure TFrmPermisos.DbEmpleadoClick(Sender: TObject);
begin
        Edlogin.Text := DbEmpleado.KeyValue;
        vEmpleado := DbEmpleado.KeyValue;
        TabPermiso.Enabled := True;
        TabReporte.Enabled := True;
        TabRole.Enabled := True;

end;

procedure TFrmPermisos.BtBuscarClick(Sender: TObject);
begin
        TabPermiso.Enabled := False;
        TabReporte.Enabled := False;
        if DbEmpleado.KeyValue = Null then
           Exit;
        LrAsignado.Clear;
        LrnAsignado.Clear;
        Dbroles.CancelUpdates;
        if IBroles.Transaction.InTransaction then
           IBroles.Transaction.Commit;
        IBroles.Transaction.StartTransaction;
        IBroles.Close;
        IBroles.ParamByName('ID').AsString := vEmpleado;
        IBroles.Open;
        while not IBroles.Eof do
        begin
          LrAsignado.Items.Add(Trim(IBroles.FieldByName('RDB$RELATION_NAME').AsString));
          Dbroles.Append;
          Dbroles.FieldValues['rol'] := Trim(IBroles.FieldByName('RDB$RELATION_NAME').AsString);
          Dbroles.Post;
          IBroles.Next;
        end;
        IBnRoles.Close;
        IBnRoles.Open;
        while not IBnRoles.Eof do
        begin
          Dbroles.Filtered := False;
          Dbroles.Filter := 'rol = ' + '''' + Trim(IBnRoles.FieldByName('RDB$ROLE_NAME').AsString) + '''';
          Dbroles.Filtered := True;
          if Dbroles.RecordCount > 0 then
             IBnroles.Next
          else
          begin
            LrnAsignado.Items.Add(Trim(IBnRoles.FieldByName('RDB$ROLE_NAME').AsString));
          IBnRoles.Next;
          end;
        end;
        DbEmpleado.Enabled := False;
        BtBuscar.Enabled := False;

end;

procedure TFrmPermisos.BitBtn7Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmPermisos.BTagregarClick(Sender: TObject);
begin
        try
          LrAsignado.Items.Add(LrnAsignado.Items.Strings[LrnAsignado.ItemIndex]);
          LrnAsignado.Items.Delete(LrnAsignado.ItemIndex);
        except
          MessageDlg('Debe Seleccionar al Menos un Registro',mtError,[mbok],0);
        end;

end;

procedure TFrmPermisos.BTquitarClick(Sender: TObject);
begin
        try
          LrnAsignado.Items.Add(LrAsignado.Items.Strings[LrAsignado.ItemIndex]);
          LrAsignado.Items.Delete(LrAsignado.ItemIndex);
        except
          MessageDlg('Debe Seleccionar al Menos un Registro',mtError,[mbok],0);
        end;


end;

procedure TFrmPermisos.BtCancelarClick(Sender: TObject);
begin
        LrAsignado.Clear;
        LrPnAsignado.Clear;
        LrPAsignado.Clear;
        LrnAsignado.Clear;
        BtBuscar.Enabled := True;
        TabPermiso.Enabled := False;
        TabReporte.Enabled := False;
        TabRole.Enabled := False;
        DbAgencia.DropDown;
end;

procedure TFrmPermisos.BitBtn5Click(Sender: TObject);
var     i :Integer;
begin
        if LrnAsignado.Count = 0 then
           Exit;
        if MessageDlg('Esta Seguro de Realizar los Cambios',mtInformation,[mbyes,mbno],0) = mrno then
           Exit;
        if Tipo = 'P' then
        begin
          with Dbroles do
          begin
            Filtered := False;
            First;
            while not Eof do
            begin
              with IBejecuta do
              begin
                if Transaction.InTransaction then
                   Transaction.Commit;
                Transaction.StartTransaction;
                SQL.Clear;
                SQL.Add('REVOKE ' + Dbroles.FieldByName('rol').AsString + ' FROM ' + vEmpleado);
                ExecSQL;
                Transaction.Commit;
              end; // fin del ibejecuta
              Next;
            end; // fin del while
          end; // fin del dbroles
          for i := 0 to LrAsignado.Count -1 do
          begin
            with IBejecuta do
            begin
              if Transaction.InTransaction then
                 Transaction.Commit;
              Transaction.StartTransaction;
              SQL.Clear;
              SQL.Add('GRANT ' + LrAsignado.Items.Strings[I] + ' TO ' + vEmpleado);
              ExecSQL;
              Transaction.Commit;
            end;
          end;
        end
        else
        begin
        end;
          MessageDlg('Proceso Realizado con Exito',mtInformation,[mbok],0);
          BtCancelar.Click;
end;

procedure TFrmPermisos.LrnAsignadoClick(Sender: TObject);
begin
        BTagregar.Enabled := True;
        BTquitar.Enabled := False;
end;

procedure TFrmPermisos.LrAsignadoClick(Sender: TObject);
begin
        BTagregar.Enabled := False;
        BTquitar.Enabled := True;

end;

procedure TFrmPermisos.TabPermisoShow(Sender: TObject);
begin
        Tipo := 'P';
end;

procedure TFrmPermisos.TabReporteShow(Sender: TObject);
begin
        Tipo := ' ';
end;

procedure TFrmPermisos.DbAgenciaExit(Sender: TObject);
begin
        Empleado(DbAgencia.KeyValue);
end;

procedure TFrmPermisos.Empleado(agencia: integer);
begin
        with CDempleado do
        begin
          CancelUpdates;
          if agencia = 1 then
          begin
            IBempleado.Close;
            IBempleado.Open;
            while not IBempleado.Eof do
            begin
              Append;
              FieldValues['id_empleado'] := IBempleado.FieldByName('ID_EMPLEADO').AsString;
              FieldValues['nombre'] := IBempleado.FieldByName('EMPLEADO').AsString;
              IBempleado.Next;
            end;
          end
          else
          begin
          end;
        end;
        DbEmpleado.ListSource := DsEmpleado;
        DbEmpleado.Enabled := True;
end;

procedure TFrmPermisos.BitBtn2Click(Sender: TObject);
begin
        TabRole.Enabled := False;
        TabReporte.Enabled := False;
        if DbEmpleado.KeyValue = Null then
           Exit;
        with IBejecuta do
        begin
          Close;
          SQL.Clear;
          if Transaction.InTransaction then
            Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Add('SELECT ');
          SQL.Add('"per$descripcion".DESCRIPCION,');
          SQL.Add('"per$descripcion".ID_PERMISO');
          SQL.Add('FROM');
          SQL.Add('"per$permodulo"');
          SQL.Add('INNER JOIN "per$descripcion" ON ("per$permodulo".ID_PERMISO="per$descripcion".ID_PERMISO)');
          SQL.Add('WHERE');
          SQL.Add('("per$permodulo".ID_MODULO = :ID_MODULO)');
          ParamByName('ID_MODULO').AsInteger := DBmodulo.KeyValue;
          Open;
          LrPnAsignado.Clear;
          while not Eof do
          begin
            LrPnAsignado.Items.Add(FieldByName('DESCRIPCION').AsString);
            Next;
          end;
        end;

end;

procedure TFrmPermisos.TabRoleShow(Sender: TObject);
begin
        Tipo := 'R';
end;

procedure TFrmPermisos.DBmoduloClick(Sender: TObject);
begin
        with IBejecuta do
        begin
        end;
end;

procedure TFrmPermisos.DbEmpleado1Click(Sender: TObject);
begin
        vEmpleado := dbempleado1.KeyValue;
end;

end.
