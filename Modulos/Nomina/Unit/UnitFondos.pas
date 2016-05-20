unit UnitFondos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvEdit, JvTypedEdit, StdCtrls, Buttons, DBCtrls,
  ComCtrls, DB, IBCustomDataSet, IBQuery;

type
  TFrmFondos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    cuenta: TEdit;
    Label3: TLabel;
    valor: TJvCurrencyEdit;
    Panel2: TPanel;
    BACEPTAR: TBitBtn;
    Bnomina: TBitBtn;
    Bcerrar: TBitBtn;
    agencia: TDBLookupComboBox;
    Label4: TLabel;
    DateTimePicker1: TDateTimePicker;
    DataSource1: TDataSource;
    IBQuery1: TIBQuery;
    procedure BcerrarClick(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure agenciaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure agenciaKeyPress(Sender: TObject; var Key: Char);
    procedure valorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFondos: TFrmFondos;

implementation
uses unitdatamodulo, UnitQuerys,UnitGlobal;

{$R *.dfm}

procedure TFrmFondos.BcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmFondos.BACEPTARClick(Sender: TObject);
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('update "nom$tiponomina"');
          SQL.Add('set "nom$tiponomina"."valor" = :valor');
          SQL.Add('where "nom$tiponomina"."codigo" = :codigo');
          ParamByName('valor').AsCurrency := valor.Value;
          ParamByName('codigo').AsInteger := agencia.KeyValue;
          Open;
          Close;
          Transaction.Commit;
        end;
        valor.Value := 0;
        cuenta.Text := '';
end;

procedure TFrmFondos.agenciaExit(Sender: TObject);
begin
        try
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"nom$tiponomina"."cuenta"');
          SQL.Add('FROM');
          SQL.Add('"nom$tiponomina"');
          SQL.Add('WHERE');
          SQL.Add('("nom$tiponomina"."codigo" = :cod)');
          ParamByName('cod').AsInteger := agencia.KeyValue;
          Open;
          cuenta.Text := FieldByName('cuenta').AsString;
          Close;
        end;
        except
        on E: Exception do
        begin
          MessageDlg('Debe Seleccionar Una Agencia',mtError,[mbOK],0);
          Exit;
        end;
        end;
end;

procedure TFrmFondos.FormCreate(Sender: TObject);
begin
        IBQuery1.Open;
        IBQuery1.Last;
        DateTimePicker1.DateTime := Date;
end;

procedure TFrmFondos.agenciaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           valor.SetFocus;
end;

procedure TFrmFondos.valorKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          BACEPTAR.SetFocus;
end;

end.
