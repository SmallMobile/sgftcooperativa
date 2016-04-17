unit UnitTraslado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  Tfrmfact = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nit: TEdit;
    nombre_p: TMemo;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    no_factura: TEdit;
    Label6: TLabel;
    fecha_entrada: TDateTimePicker;
    Label7: TLabel;
    Descripcion: TMemo;
    Panel1: TPanel;
    Aceptar: TBitBtn;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    Label8: TLabel;
    Label9: TLabel;
    procedure nitExit(Sender: TObject);
    procedure SalirClick(Sender: TObject);
    procedure nitKeyPress(Sender: TObject; var Key: Char);
    procedure no_facturaKeyPress(Sender: TObject; var Key: Char);
    procedure fecha_entradaKeyPress(Sender: TObject; var Key: Char);
    procedure DescripcionKeyPress(Sender: TObject; var Key: Char);
    procedure CancelarClick(Sender: TObject);
    procedure AceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
        cod_factura:Integer;
    { Private declarations }
  public
  published
    procedure limpiar;
    procedure numerico(Sender: TObject; var Key: Char);
    procedure entra_datos;
    { Public declarations }
  end;

var
  frmfact: Tfrmfact;

implementation

uses UnitDatamodulo, UnitProveedores;

{$R *.dfm}

procedure Tfrmfact.limpiar;
begin
        nombre_p.Text := '';
        nit.Text := '';
        Label4.Caption := '';
        no_factura.Text := '';
        Descripcion.Text := '';
        label9.Caption := '';
        nit.SetFocus;
end;

procedure Tfrmfact.nitExit(Sender: TObject);
begin

        if nit.Text = '' then
        begin
          ShowMessage('El Campo Nit Debe Contener un Valor');
          nit.SetFocus;
        end
        else
        begin
        with DataGeneral.IBdatos do
        begin
          Close;
          sql.Clear;
          SQL.Add('select "inv$proveedor"."nombre","inv$proveedor"."ciudad","inv$proveedor"."telefono"');
          SQL.Add('from "inv$proveedor"');
          SQL.Add('where "inv$proveedor"."nit_proveedor"=:"nit"');
          ParamByName('nit').AsString := nit.Text;
          Open;
          Label4.Caption := FieldByName('telefono').AsString;
          nombre_p.Text := FieldByName('nombre').AsString;
          Label9.Caption := FieldByName('ciudad').AsString;
          Close;
        end;
        if nombre_p.Text = '' then
        begin
          if MessageDlg('Desea Registrar el Proveedor',mtCustom,[mbYes,mbNo],0) = mrYes Then
          begin
            frmproveedor := TFrmProveedor.Create(self);
            FrmProveedor.nit.Text := nit.Text;
            FrmProveedor.nit.ReadOnly := True;
            FrmProveedor.ShowModal;
            nit.SetFocus;
          end
          else
          begin
          nit.SetFocus;
          end;
          end;
        end;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select max("act$factura"."cod_factura") as codigo from "act$factura"');
          Open;
          cod_factura := (FieldByName('codigo').AsInteger) + 1;
          Close;
        end;
end;

procedure Tfrmfact.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure Tfrmfact.nitKeyPress(Sender: TObject; var Key: Char);
begin
        numerico(Self,Key);
        if Key = #13 then
          no_factura.SetFocus;
end;

procedure Tfrmfact.no_facturaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          fecha_entrada.SetFocus;
end;

procedure Tfrmfact.fecha_entradaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          Descripcion.SetFocus;
end;

procedure Tfrmfact.DescripcionKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          Aceptar.SetFocus;
end;

procedure Tfrmfact.numerico(Sender: TObject; var Key: Char);
begin
if not (Key in [#8,#13, '0'..'9', '-', DecimalSeparator]) then
  begin
    Key := #0;
  end //End First if.
  else
  if ((Key = DecimalSeparator) or (Key = '-')) and (Pos(Key, TMemo(Sender).Text ) > 0) then
  begin
    Key := #0;
  end//End second if.
  else
  if (Key = '-') and (TMemo(Sender).SelStart <> 0) then
  begin
    Key := #0;
  end;//End third if.
end;

procedure Tfrmfact.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure Tfrmfact.entra_datos;
begin
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "act$factura" ');
          SQL.Add('values(');
          SQL.Add(':"cod_factura",:"nit_proveedor",:"descripcion"');
          SQL.Add(',:"fecha",:"no_factura")');
          ParamByName('cod_factura').AsInteger := cod_factura;
          ParamByName('nit_proveedor').AsString := nit.Text;
          ParamByName('descripcion').AsString := Descripcion.Text;
          ParamByName('no_factura').AsString := no_factura.Text;
          ParamByName('fecha').AsDate := fecha_entrada.DateTime;
          Open;
          Close;
        end;
        DataGeneral.IBTransaction1.CommitRetaining;
end;

procedure Tfrmfact.AceptarClick(Sender: TObject);
begin
        if no_factura.Text = '' then
          begin
          ShowMessage('El Campo No. Factura debe Contener un Valor');
          no_factura.SetFocus;
        end
        else
        begin
          entra_datos;
           limpiar;
        end;
end;

procedure Tfrmfact.FormCreate(Sender: TObject);
begin
        fecha_entrada.DateTime := Date;
end;
end.
