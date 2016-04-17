unit UnitModDescuentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DB, IBCustomDataSet, Grids, DBGrids,
  IBQuery, IBDatabase;

type
  TFrmModDescuentos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    empleadonit: TComboBox;
    empleado: TComboBox;
    BitBtn1: TBitBtn;
    DataSource1: TDataSource;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    busca_nombre: TIBQuery;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    SpeedButton1: TSpeedButton;
    BitBtn3: TBitBtn;
    IBTransaction1: TIBTransaction;
    IBDataSet1: TIBDataSet;
    procedure FormCreate(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
  private
  nit_emp :Integer;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  FrmModDescuentos: TFrmModDescuentos;

implementation

uses UnitQuerys;

{$R *.dfm}

procedure TFrmModDescuentos.FormCreate(Sender: TObject);
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Clear;
          SQL.Add('select "inv$empleado"."nombre","inv$empleado"."apellido"  from "inv$empleado"');
          SQL.Add('where "inv$empleado"."nit" in (');
          SQL.Add('select "nom$empleado"."nitempleado" from "nom$empleado")');          
          SQL.Add('order by "inv$empleado"."nombre"');
          Open;
          while not Eof do
          begin
            empleado.Items.Add(FieldByName('nombre').AsString + ' ' + fieldbyname('apellido').AsString);
            empleadonit.Items.Add(FieldByName('nombre').AsString + fieldbyname('apellido').AsString);
            Next;
             end;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmModDescuentos.empleadoExit(Sender: TObject);
var     a :Integer;
        b :String;

begin
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        busca_nombre.Close;
        busca_nombre.parambyname('nombre').AsString := b;
        busca_nombre.Open;
        nit_emp := busca_nombre.fieldbyname('nit').AsInteger;
        busca_nombre.Close;
        if nit_emp = 0 then
        begin
          MessageDlg('El Nombre del Empleado no es Correcto',mtInformation,[mbOK],0);
          empleado.SetFocus;
          Exit;
        end;
end;

procedure TFrmModDescuentos.BitBtn3Click(Sender: TObject);
begin
        IBDataSet1.Close;
        empleado.ItemIndex := -1;
        empleado.SetFocus
end;

procedure TFrmModDescuentos.BitBtn2Click(Sender: TObject);
begin
        if MessageDlg('Esta Seguro de Realizar la Transacción',mtWarning,[mbyes,mbno],0) = mryes then
        begin
          IBDataSet1.ApplyUpdates;
          with IBDataSet1.Transaction do
          begin
             Commit;
             StartTransaction;
          end;
        end;
end;

procedure TFrmModDescuentos.BitBtn1Click(Sender: TObject);
begin
        IBDataSet1.ParamByName('nit').AsInteger := nit_emp;
        IBDataSet1.ParamByName('fecha').AsDateTime := StrToDateTime(FormatDateTime('yyyy/mm/01',Date));
        IBDataSet1.Open;
end;

procedure TFrmModDescuentos.SpeedButton1Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmModDescuentos.empleadoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          BitBtn1.SetFocus;
end;

end.
