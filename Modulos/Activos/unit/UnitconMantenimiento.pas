unit UnitconMantenimiento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, DB,
  IBCustomDataSet, IBQuery;

type
  TFrmcosultaMant = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Placa: TEdit;
    Label2: TLabel;
    Descripcion: TEdit;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    Label3: TLabel;
    nombre: TEdit;
    Panel4: TPanel;
    Aceptar: TBitBtn;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    Ibmantenimiento: TIBQuery;
    Ibmantenimientodescripcion: TIBStringField;
    Ibmantenimientodescripcion1: TIBStringField;
    Ibmantenimientofecha: TDateField;
    Ibmantenimientovalor: TIBBCDField;
    Ibmantenimientocod_mantenimiento: TIntegerField;
    Ibcodmantenimiento: TIBQuery;
    DSmantenimiento: TDataSource;
    procedure AceptarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure SalirClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure PlacaKeyPress(Sender: TObject; var Key: Char);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmcosultaMant: TFrmcosultaMant;

implementation

{$R *.dfm}
procedure TFrmcosultaMant.AceptarClick(Sender: TObject);
begin
        Ibmantenimiento.ParamByName('Placa').AsString:=Placa.Text;
        Ibmantenimiento.Open;
        if Ibmantenimiento.RecordCount = 0 then
        begin
          MessageDlg('El Activo no Existe o no tiene Mantenimientos',mtInformation,[mbOK],0);
          CancelarClick(Self)
        end
        else
          Descripcion.Text:=Ibmantenimiento.FieldByName('descripcion').AsString;
end;

procedure TFrmcosultaMant.DBGrid1CellClick(Column: TColumn);
begin
        try
          Ibcodmantenimiento.Close;
          Ibcodmantenimiento.ParamByName('codigo').AsString := Ibmantenimientocod_mantenimiento.Text;
          Ibcodmantenimiento.Open;
          nombre.Text := Ibcodmantenimiento.FieldByName('ejecutadopor').AsString;
        except
        on E: Exception do
        begin
          MessageDlg('No Existene Elementos Disponibles',mtInformation,[mbOK],0);
        end;
        end;
end;

procedure TFrmcosultaMant.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmcosultaMant.CancelarClick(Sender: TObject);
begin
        Placa.Text := '';
        Descripcion.Text := '';
        nombre.Text := '';
        Ibmantenimiento.Close;
        Placa.SetFocus;
end;

procedure TFrmcosultaMant.PlacaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
        aceptarclick(Self);
end;
end.
