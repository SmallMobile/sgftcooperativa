unit UnitEstudios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, ExtCtrls, ComCtrls, Buttons, Grids, DBGrids,
  DB, IBCustomDataSet, IBQuery, IBDatabase;

type
  TFrmEstudios = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DbEmpleado: TDBLookupComboBox;
    Label2: TLabel;
    DbEstudio: TDBLookupComboBox;
    Label3: TLabel;
    EdTitulo: TEdit;
    Label4: TLabel;
    DtFecha: TDateTimePicker;
    Label5: TLabel;
    EdDuracion: TEdit;
    Label6: TLabel;
    EdInstitucion: TEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    IbEmpleado: TIBQuery;
    IbEstudio: TIBQuery;
    DsEmpleado: TDataSource;
    DsEstudio: TDataSource;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    procedure BitBtn4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DbEmpleadoKeyPress(Sender: TObject; var Key: Char);
    procedure DbEmpleadoEnter(Sender: TObject);
    procedure DbEstudioEnter(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEstudios: TFrmEstudios;

implementation
uses UnitGlobales;

{$R *.dfm}

procedure TFrmEstudios.BitBtn4Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmEstudios.FormCreate(Sender: TObject);
begin
        IbEmpleado.Close;
        IbEmpleado.Open;
        IbEmpleado.Last;
        IbEstudio.Close;
        IbEstudio.Open;
        IbEstudio.Last;
        DbEstudio.KeyValue := 13;
        DtFecha.Date := fFechaActual;
end;

procedure TFrmEstudios.BitBtn1Click(Sender: TObject);
begin
        if DbEmpleado.KeyValue = Null then
        begin
           ShowMessage('Debe Registrar un Empleado');
           DbEmpleado.SetFocus;
        end;
        if MessageDlg('Esta Seguro(a) de realizar la operación',mtInformation,[mbyes,mbno],0)  = mrno then
           Exit;
        with IBQuery1 DO
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO ');
          SQL.Add('ESTUDIO(');
          SQL.Add('IDESTUDIO,');
          SQL.Add('NITEMPLEADO,');
          SQL.Add('TITULO,');
          SQL.Add('FECHAREG,');
          SQL.Add('INSTITUCION,');
          SQL.Add('DURACION,');
          SQL.Add('FECHAREGISTRO,');
          SQL.Add('USUARIOREG,');
          SQL.Add('ESTADO,');
          SQL.Add('CONELIMINADO,');
          SQL.Add('USUARIOELI,');
          SQL.Add('FECHAELI)');
          SQL.Add('VALUES(');
          SQL.Add(':IDESTUDIO,');
          SQL.Add(':NITEMPLEADO,');
          SQL.Add(':TITULO,');
          SQL.Add(':FECHAREG,');
          SQL.Add(':INSTITUCION,');
          SQL.Add(':DURACION,');
          SQL.Add(':FECHAREGISTRO,');
          SQL.Add(':USUARIOREG,');
          SQL.Add(':ESTADO,');
          SQL.Add(':CONELIMINADO,');
          SQL.Add(':USUARIOELI,');
          SQL.Add(':FECHAELI)');
          ParamByName('IDESTUDIO').AsInteger := DbEstudio.KeyValue;
          ParamByName('NITEMPLEADO').AsInteger := DbEmpleado.KeyValue;
          ParamByName('TITULO').AsString := EdTitulo.Text;
          ParamByName('FECHAREG').AsDate := DtFecha.Date;
          ParamByName('INSTITUCION').AsString := EdInstitucion.Text;
          ParamByName('DURACION').AsString := EdDuracion.Text;
          ParamByName('FECHAREGISTRO').AsDate := fFechaActual;
          ParamByName('USUARIOREG').AsString := DBAlias;
          ParamByName('ESTADO').AsInteger := 1;
          ParamByName('CONELIMINADO').Clear;
          ParamByName('USUARIOELI').Clear;
          ParamByName('FECHAELI').Clear;
          ExecSQL;
          Transaction.Commit;
          ShowMessage('Registro Insertado con Exito');
          BitBtn3.Click;
        end;

end;

procedure TFrmEstudios.DbEmpleadoKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TFrmEstudios.DbEmpleadoEnter(Sender: TObject);
begin
        DbEmpleado.DropDown;
end;

procedure TFrmEstudios.DbEstudioEnter(Sender: TObject);
begin
        DbEstudio.DropDown;
end;

procedure TFrmEstudios.BitBtn3Click(Sender: TObject);
begin
        DbEmpleado.SetFocus;
        EdTitulo.Text := '';
        EdDuracion.Text := '';
        EdInstitucion.Text := '';
        DtFecha.Date := fFechaActual;
end;

end.
