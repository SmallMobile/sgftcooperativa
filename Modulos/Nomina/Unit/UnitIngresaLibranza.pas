unit UnitIngresaLibranza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, DB, IBCustomDataSet, IBQuery,
  JvEdit, JvTypedEdit, ComCtrls, Grids, DBGrids, Buttons, Menus;

type
  TFrmIngresaLibranza = class(TForm)
    DsEmpleado: TDataSource;
    IbEmpleado: TIBQuery;
    GroupBox1: TGroupBox;
    DbEmpleado: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    EdNomina: TEdit;
    Label3: TLabel;
    EdColocacion: TEdit;
    Label4: TLabel;
    jvValor: TJvCurrencyEdit;
    Label5: TLabel;
    dtFecha: TDateTimePicker;
    Label6: TLabel;
    dbNomina: TDBLookupComboBox;
    GroupBox2: TGroupBox;
    DsNomina: TDataSource;
    IbNomina: TIBQuery;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PopupMenu1: TPopupMenu;
    Eliminar1: TMenuItem;
    IbLibranza: TIBQuery;
    IBQuery1: TIBQuery;
    dsLibranza: TDataSource;
    IbLibranzadescripcion: TIBStringField;
    IbLibranzaCOLOCACION: TIBStringField;
    IbLibranzaVCUOTA: TIBBCDField;
    IbLibranzaFECHAV: TDateField;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DbEmpleadoKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure Inicializar;
    procedure DbEmpleadoExit(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Eliminar1Click(Sender: TObject);
  private
    _sColocacion :string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmIngresaLibranza: TFrmIngresaLibranza;

implementation
uses
UnitGlobales;

{$R *.dfm}

procedure TFrmIngresaLibranza.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmIngresaLibranza.FormCreate(Sender: TObject);
begin
        Inicializar;
end;

procedure TFrmIngresaLibranza.DbEmpleadoKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TFrmIngresaLibranza.BitBtn1Click(Sender: TObject);
begin
        if MessageDlg('Esta Seguro(a) de Aplicar la Libranza...',mtInformation,[mbYes,mbno],0) = mrno then
           Exit;
        with IBQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO');
          SQL.Add('  "nom$libranza"(');
          SQL.Add('  NIT,');
          SQL.Add('  IDAGENCIA,');
          SQL.Add('  COLOCACION,');
          SQL.Add('  VCUOTA,');
          SQL.Add('  FECHAV)');
          SQL.Add('VALUES(');
          SQL.Add('  :NIT,');
          SQL.Add('  :IDAGENCIA,');
          SQL.Add('  :COLOCACION,');
          SQL.Add('  :VCUOTA,');
          SQL.Add('  :FECHAV)');
          ParamByName('NIT').AsInteger := DbEmpleado.KeyValue ;
          ParamByName('IDAGENCIA').AsInteger := dbNomina.KeyValue;
          ParamByName('COLOCACION').AsString := EdColocacion.Text ;
          ParamByName('VCUOTA').AsCurrency := jvValor.Value ;
          ParamByName('FECHAV').AsDateTime := dtFecha.DateTime;
          ExecSQL;
          Transaction.Commit;
          Transaction.StartTransaction;
          Inicializar;
          DbEmpleado.SetFocus;
          EdNomina.Text := '';
          jvValor.Value := 0;
          EdColocacion.Text := '';
          dbNomina.KeyValue := 1;
          dtFecha.DateTime := fFechaActual;
          IbLibranza.Close;
          IbLibranza.ParamByName('NIT').AsInteger := DbEmpleado.KeyValue;
          IbLibranza.Open;
        end;
end;

procedure TFrmIngresaLibranza.Inicializar();
begin
        IbEmpleado.Close;
        IbEmpleado.Open;
        IbEmpleado.Last;
        IbNomina.Close;
        IbNomina.Open;
        IbNomina.Last;
        dtFecha.DateTime := fFechaActual;
end;

procedure TFrmIngresaLibranza.DbEmpleadoExit(Sender: TObject);
begin
        EdNomina.Text := IbEmpleado.FieldByName('descripcion').AsString;
        IbLibranza.Close;
        IbLibranza.ParamByName('NIT').AsInteger := DbEmpleado.KeyValue;
        IbLibranza.Open;
end;

procedure TFrmIngresaLibranza.DBGrid1CellClick(Column: TColumn);
begin
        _sColocacion := IbLibranza.FieldByName('COLOCACION').AsString;
end;

procedure TFrmIngresaLibranza.Eliminar1Click(Sender: TObject);
begin
        with IBQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('DELETE FROM "nom$libranza"');
          SQL.Add('WHERE "nom$libranza".NIT = :NIT');
          SQL.Add('AND "nom$libranza".COLOCACION = :COLOCACION');
          ParamByName('NIT').AsInteger := DbEmpleado.KeyValue;
          ParamByName('COLOCACION').AsString := _sColocacion;
          ExecSQL;
          Transaction.Commit;
          Inicializar;
        end;

end;

end.
