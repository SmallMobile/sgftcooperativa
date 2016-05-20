unit UnitElementos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, DB, IBCustomDataSet, IBQuery;

type
  TFrmElementos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label13: TLabel;
    descripcion: TEdit;
    fecha: TEdit;
    clase: TEdit;
    Agencia: TEdit;
    Seccion: TEdit;
    estado: TEdit;
    placa: TMaskEdit;
    Panel3: TPanel;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    Aceptar: TBitBtn;
    IBdatosactivo: TIBQuery;
    procedure SalirClick(Sender: TObject);
    procedure CancelarClick(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmElementos: TFrmElementos;

implementation

{$R *.dfm}

procedure TFrmElementos.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmElementos.CancelarClick(Sender: TObject);
begin
        if placa.Text = '  -  -   ' then
        Exit;
        with IBdatosactivo do
        begin
          Close;
          ParamByName('placa').AsString := placa.Text;
          Open;
        if RecordCount <> 0 then
        begin
          descripcion.Text := FieldByName('descripcion').AsString;
          fecha.Text := FormatDateTime('dd "de" mmm "de" yyyy',FieldByName('fechacompra').AsDateTime);
          Agencia.Text := FieldByName('oficina').AsString;
          Seccion.Text := FieldByName('nombre').AsString;
          Clase.Text := '$'+FormatCurr('#,##0.00',FieldByName('preciocompra').AsCurrency);
          estado.Text := 'Elemento de Trabajo';
          Close;
        end
        else
        begin
          MessageDlg('Verifique la Placa del Elemento',mtInformation,[mbOK],0);
          Aceptar.Click;
          placa.SetFocus;
        end;
        end;
end;

procedure TFrmElementos.AceptarClick(Sender: TObject);
begin
        placa.Text := '';
        descripcion.Text := '';
        clase.Text := '';
        fecha.Text := '';
        Agencia.Text := '';
        Seccion.Text := '';
        estado.Text := '';
        placa.SetFocus;
end;
procedure TFrmElementos.placaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          Cancelar.Click;
end;

end.
