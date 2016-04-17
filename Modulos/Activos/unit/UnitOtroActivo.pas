unit UnitOtroActivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DBCtrls, DB, ComCtrls, JvEdit,
  JvTypedEdit, IBCustomDataSet, IBQuery, IBDatabase;

type
  TFrmOtroActivo = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    placa: TEdit;
    valor: TJvCurrencyEdit;
    fecha: TDateTimePicker;
    DataSource1: TDataSource;
    oficina: TDBLookupComboBox;
    descripcion: TEdit;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    IBQuery1: TIBQuery;
    IBTransaction1: TIBTransaction;
    IBQuery2: TIBQuery;
    IBTransaction2: TIBTransaction;
    procedure BitBtn3Click(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
    procedure valorKeyPress(Sender: TObject; var Key: Char);
    procedure oficinaKeyPress(Sender: TObject; var Key: Char);
    procedure fechaKeyPress(Sender: TObject; var Key: Char);
    procedure descripcionKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure oficinaEnter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOtroActivo: TFrmOtroActivo;

implementation

uses UnitDatamodulo;

{$R *.dfm}

procedure TFrmOtroActivo.BitBtn3Click(Sender: TObject);
begin
        Close
end;

procedure TFrmOtroActivo.placaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           valor.SetFocus
end;

procedure TFrmOtroActivo.valorKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           oficina.SetFocus

end;

procedure TFrmOtroActivo.oficinaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           fecha.SetFocus

end;

procedure TFrmOtroActivo.fechaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           descripcion.SetFocus

end;

procedure TFrmOtroActivo.descripcionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           BitBtn1.SetFocus

end;

procedure TFrmOtroActivo.FormCreate(Sender: TObject);
begin
        IBQuery1.Open;
        IBQuery1.Last;
        fecha.Date := Date;
        oficina.KeyValue := 1;
end;

procedure TFrmOtroActivo.oficinaEnter(Sender: TObject);
begin
        oficina.DropDown
end;

procedure TFrmOtroActivo.BitBtn1Click(Sender: TObject);
begin
        if MessageDlg('Esta Seguro de Realizar la Transacción',mtInformation,[mbyes,mbno],0) = mryes then
        begin
           with IBQuery2 do
           begin
             Close;
             if Transaction.InTransaction then
                 Transaction.Commit;
             Transaction.StartTransaction;
             SQL.Clear;
             SQL.Add('insert into "act$otrosactivos" values (');
             SQL.Add(':agencia,:descripcion,:valor,:placa,:fecha)');
             ParamByName('placa').AsString := placa.Text;
             ParamByName('agencia').AsInteger := oficina.KeyValue;
             ParamByName('descripcion').AsString := descripcion.Text;
             ParamByName('valor').AsCurrency := valor.Value;
             ParamByName('fecha').AsDateTime := fecha.DateTime;
             Open;
             Close;
             Transaction.Commit;
             BitBtn2.Click;
           end;
        end;
end;

procedure TFrmOtroActivo.BitBtn2Click(Sender: TObject);
begin
        placa.Text := '';
        valor.Value := 0;
        descripcion.Text := '';
        placa.SetFocus
end;

end.
