unit UnitProveedores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, ImgList, ToolWin;

type
  TFrmProveedor = class(TForm)
    Panel1: TPanel;
    panel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    nombre: TMemo;
    Label3: TLabel;
    direccion: TEdit;
    Label4: TLabel;
    ciudad: TEdit;
    Label5: TLabel;
    telefono: TEdit;
    BACEPTAR: TBitBtn;
    BCANCELAR: TBitBtn;
    Bcerrar: TBitBtn;
    nit: TEdit;
    Label6: TLabel;
    regimen: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure BCANCELARClick(Sender: TObject);
    procedure nitKeyPress(Sender: TObject; var Key: Char);
    procedure nombreKeyPress(Sender: TObject; var Key: Char);
    procedure direccionKeyPress(Sender: TObject; var Key: Char);
    procedure ciudadKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton1Click(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure telefonoKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure nitExit(Sender: TObject);
    procedure regimenKeyPress(Sender: TObject; var Key: Char);
    procedure nombreExit(Sender: TObject);
    procedure ciudadExit(Sender: TObject);

  private
    { Private declarations }
  public

  published
    procedure cancelar;
    procedure entra_datos;

    { Public declarations }
  end;

var
  FrmProveedor: TFrmProveedor;
  regimen1: string;


implementation

uses UnitDatamodulo, UnitPrincipal;

{$R *.dfm}

procedure TFrmProveedor.FormCreate(Sender: TObject);
begin
        nombre.Text := '';
end;

procedure TFrmProveedor.BcerrarClick(Sender: TObject);
begin
        close;
end;

procedure TFrmProveedor.BCANCELARClick(Sender: TObject);
begin
        cancelar;
end;

procedure TFrmProveedor.nitKeyPress(Sender: TObject; var Key: Char);
begin

        if Key = #13 then
          nombre.SetFocus;
end;

procedure TFrmProveedor.nombreKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          direccion.SetFocus;
end;

procedure TFrmProveedor.direccionKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          ciudad.SetFocus;
end;

procedure TFrmProveedor.ciudadKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          telefono.SetFocus;
end;
procedure TFrmProveedor.cancelar;
begin
        nit.Text := '';
        nombre.Text := '';
        direccion.Text := '';
        ciudad.Text := '';
        telefono.Text := '';
        nit.SetFocus;
        nit.Text := '';
        Regimen.Text := '';
end;

procedure TFrmProveedor.entra_datos;
begin
           if regimen.Text= 'Comun' then
             regimen1 := 'C'
           else
             regimen1 := 'S';
             with DataGeneral.IBsql do
             begin
               sQL.Clear;
               Sql.Add('Insert into "inv$proveedor" (');
               Sql.Add('"inv$proveedor"."nit_proveedor",');
               Sql.Add('"inv$proveedor"."nombre",');
               Sql.Add('"inv$proveedor"."direccion",');
               Sql.Add('"inv$proveedor"."ciudad",');
               Sql.Add('"inv$proveedor"."telefono",');
               Sql.Add('"inv$proveedor"."regimen")');
               Sql.Add('values (');
               Sql.Add(':"nit",:"nombre",:"direccion",:"ciudad",:"telefono",:"regimen")');
               ParamByname('nit').AsInt64:=strtoint64(nit.Text);
               ParamByname('nombre').AsString:=nombre.Text;
               ParamByname('direccion').AsString:=direccion.Text;
               ParamByname('ciudad').AsString:=ciudad.Text;
               ParamByname('telefono').AsString:=telefono.Text;
               ParamByname('regimen').AsVariant:=regimen1;
               Execquery;
               Close;
               DataGeneral.IBTransaction1.CommitRetaining;
            end;
end;

procedure TFrmProveedor.ToolButton1Click(Sender: TObject);
begin
        if nit.Text = '' then begin
          showmessage('El Campo Nit no puede ser Nulo');
          nit.SetFocus;
        end
        else begin
          entra_datos;
          cancelar;
        end;
end;

procedure TFrmProveedor.BACEPTARClick(Sender: TObject);
var nom,tel:string;
begin
       if nit.Text = '' then begin
          ShowMessage('El Campo Nit debe Contener un Valor');
          nit.SetFocus;
        end
          else if nombre.Text = '' then
          begin
            ShowMessage('El Campo Nombre debe Contener un Valor');
            nombre.SetFocus;
          end
            else if ciudad.Text = '' then
            begin
              ShowMessage('El Campo Ciudad debe Contener un Valor');
              ciudad.SetFocus;
            end
              else if regimen.Text = '' then
              begin
                showmessage('El Campo Regimen debe Contener un Valor');
                regimen.SetFocus;
              end
                else begin
                  tel := telefono.Text;
                  nom := nombre.Text;
                  entra_datos;
                  cancelar;
                 end;
end;

procedure TFrmProveedor.telefonoKeyPress(Sender: TObject; var Key: Char);
begin
        if key=#13 then
          Regimen.SetFocus;
end;

procedure TFrmProveedor.FormActivate(Sender: TObject);
begin
        nit.SetFocus;
end;

procedure TFrmProveedor.nitExit(Sender: TObject);
var vernit : string;
begin
        if nit.Text <> '' then
        begin
          with datageneral.IBdatos do
          begin
            close;
            Sql.Clear;
            Sql.Add('Select "inv$proveedor"."nombre" as nombre from "inv$proveedor"');
            Sql.Add('where "inv$proveedor"."nit_proveedor"=:"codigo"' );
            ParamByname('codigo').AsString:=nit.Text;
            open;
            vernit := fieldbyname('nombre').AsString;
              if vernit <> '' then
              begin
                Showmessage('El Proveedor ya se Encuentra Registrado');
                nit.SetFocus;
              end;
                close;
            end;
        end;
end;

procedure TFrmProveedor.regimenKeyPress(Sender: TObject; var Key: Char);
begin
        if key=#13 then
          Baceptar.SetFocus;
end;

procedure TFrmProveedor.nombreExit(Sender: TObject);
begin
        nombre.Text := uppercase(nombre.Text);
end;

procedure TFrmProveedor.ciudadExit(Sender: TObject);
begin
        ciudad.Text := uppercase(ciudad.Text);
end;
end.
