unit Unitcomponentes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, Grids, DBGrids, Buttons, DB,
  IBCustomDataSet, IBQuery;

type
  TFrmConcomponente = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    placa: TMaskEdit;
    DBcomponente: TDBGrid;
    Label2: TLabel;
    descripcion: TEdit;
    Panel2: TPanel;
    Aceptar: TBitBtn;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    Dscomponente: TDataSource;
    IBcomponentes: TIBQuery;
    procedure placaExit(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
    procedure AceptarClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConcomponente: TFrmConcomponente;

implementation
uses UnitDatamodulo,unitgeneral,unitglobal;


{$R *.dfm}

procedure TFrmConcomponente.placaExit(Sender: TObject);
var codigo_activo:Integer;
begin
        IBcomponentes.Close;
        if validaactivo(placa.Text) <> 0 then
        begin
        MessageDlg('El Activo fue Dado de Baja',mtInformation,[mbOK],0);
        placa.Text := '';
        descripcion.Text :='';
        placa.SetFocus;
        Exit;
        end;
        with DataGeneral.Ibdatos1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$activo"."cod_activo","act$activo"."descripcion"');
          SQL.Add('from "act$activo"');
          SQL.Add('where "act$activo"."placa" = :"placa"');
          ParamByName('placa').AsString := placa.Text;
          Open;
          descripcion.Text := FieldByName('descripcion').AsString;
          codigo_activo := FieldByName('cod_activo').AsInteger;
          Close;
        end;
        IBcomponentes.ParamByName('codigo').AsInteger := codigo_activo;
        IBcomponentes.Open;
end;

procedure TFrmConcomponente.placaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
        placaExit(Self);
end;

procedure TFrmConcomponente.AceptarClick(Sender: TObject);
begin
        IBcomponentes.Close;
        placa.Text := '';
        descripcion.Text :='';
        placa.SetFocus;
end;

procedure TFrmConcomponente.CancelarClick(Sender: TObject);
begin
        placaexit(Self);
end;

procedure TFrmConcomponente.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmConcomponente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        IBcomponentes.Close;
        
end;

end.
