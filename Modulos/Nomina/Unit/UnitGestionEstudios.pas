unit UnitGestionEstudios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, DB, IBCustomDataSet, IBQuery, ExtCtrls,
  Buttons, Grids, DBGrids, IBDatabase, FR_Class, FR_DSet, FR_DBSet;

type
  TFrmGestionEstudios = class(TForm)
    GroupBox1: TGroupBox;
    DbEmpleado: TDBLookupComboBox;
    chEmpleado: TCheckBox;
    IbEmpleado: TIBQuery;
    DsEmpleado: TDataSource;
    IbEstudio: TIBQuery;
    DsEstudio: TDataSource;
    GroupBox2: TGroupBox;
    DbEstudio: TDBLookupComboBox;
    ChEstudio: TCheckBox;
    GroupBox3: TGroupBox;
    rEmpleado: TRadioButton;
    rEstudio: TRadioButton;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    DataSource1: TDataSource;
    BitBtn4: TBitBtn;
    frReport1: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGestionEstudios: TFrmGestionEstudios;

implementation
uses UnitGlobal, UnitPrincipal, UnitNomina;

{$R *.dfm}

procedure TFrmGestionEstudios.FormCreate(Sender: TObject);
begin
        IbEmpleado.Close;
        IbEmpleado.Open;
        IbEmpleado.Last;
        IbEstudio.Close;
        IbEstudio.Open;
        IbEstudio.Last;
        DbEstudio.KeyValue := 13;
end;

procedure TFrmGestionEstudios.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmGestionEstudios.BitBtn1Click(Sender: TObject);
var
        _sSql :string;
begin
        BitBtn1.Enabled := False;
        GroupBox1.Enabled := False;
        GroupBox2.Enabled := False;
        GroupBox3.Enabled := False;
        BitBtn4.Enabled := True;
        if (DbEmpleado.KeyValue = Null) and (chEmpleado.Checked = False) then
        begin
           ShowMessage('Debe Registrar un Empleado');
           DbEmpleado.SetFocus;
           Exit;
        end;
        _sSql := 'SELECT ' +
                 ' TIPOESTUDIO.DESCRIPCION,' +
                 ' ESTUDIO.ESTUDIOID,' +
                 ' ESTUDIO.TITULO,' +
                 ' ESTUDIO.INSTITUCION,' +
                 ' ESTUDIO.DURACION,' +
                 ' ESTUDIO.NITEMPLEADO, ' +
                 ' ESTUDIO.IDESTUDIO,' +
                 ' "inv$empleado"."nombre" || ' + QuotedStr(' ') +  ' || "inv$empleado"."apellido" as NOMBRE' +
                 ' FROM' +
                 ' ESTUDIO' +
                 ' INNER JOIN TIPOESTUDIO ON (ESTUDIO.IDESTUDIO = TIPOESTUDIO.IDESTUDIO)' +
                 ' INNER JOIN "inv$empleado" ON (ESTUDIO.NITEMPLEADO = "inv$empleado"."nit")';
        if (chEmpleado.Checked = False) or (ChEstudio.Checked = False) then
           _sSql := _sSql + 'WHERE ';
        if chEmpleado.Checked = False then
        begin
          _sSql := _sSql + ' ESTUDIO.NITEMPLEADO = ' + IntToStr(DbEmpleado.KeyValue);
        end;
        if ChEstudio.Checked = False then
        begin
          if chEmpleado.Checked = False then
             _sSql := _sSql + ' AND ';
          _sSql := _sSql + ' ESTUDIO.IDESTUDIO = ' + IntToStr(DbEstudio.KeyValue);
        end;
        _sSql := _sSql + ' ORDER BY ';
        if rEmpleado.Checked then
           _sSql := _sSql + ' ESTUDIO.NITEMPLEADO'
        else
           _sSql := _sSql + ' ESTUDIO.IDESTUDIO';
        with IBQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Text := _sSql;
          Open;
        end;
end;

procedure TFrmGestionEstudios.BitBtn2Click(Sender: TObject);
begin
        BitBtn1.Enabled := True;
        GroupBox1.Enabled := True;
        GroupBox2.Enabled := True;
        GroupBox3.Enabled := True;
        BitBtn4.Enabled := True;
        IBQuery1.Close;
        DbEmpleado.SetFocus;
end;

procedure TFrmGestionEstudios.BitBtn4Click(Sender: TObject);
var
        _sImprimirReporte :string;
begin
        if rEmpleado.Checked then
          _sImprimirReporte := FrMain.wpath+'reportes\RepEstudioEmp.frf'
        else
          _sImprimirReporte := FrMain.wpath+'reportes\RepEstudioEst.frf';
        frDBDataSet1.DataSet := IBQuery1;
        frReport1.LoadFromFile(_sImprimirReporte);
        frReport1.ShowReport;
end;

end.
