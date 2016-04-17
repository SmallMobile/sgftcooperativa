unit UnitEntidad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, ImgList, ToolWin;

type
  TFrmEntidad = class(TForm)
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
    correo: TEdit;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure BCANCELARClick(Sender: TObject);
    procedure nitKeyPress(Sender: TObject; var Key: Char);
    procedure nombreKeyPress(Sender: TObject; var Key: Char);
    procedure direccionKeyPress(Sender: TObject; var Key: Char);
    procedure ciudadKeyPress(Sender: TObject; var Key: Char);
    procedure BACEPTARClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure nitExit(Sender: TObject);
    procedure regimenKeyPress(Sender: TObject; var Key: Char);
    procedure nombreExit(Sender: TObject);
    procedure ciudadExit(Sender: TObject);
    procedure telefonoKeyPress(Sender: TObject; var Key: Char);
    procedure correoKeyPress(Sender: TObject; var Key: Char);
    procedure direccionExit(Sender: TObject);

  private
    { Private declarations }
  public

  published
    procedure cancelar;
    procedure entra_datos;

    { Public declarations }
  end;

var
  FrmEntidad: TFrmEntidad;
implementation

uses UnitDatamodulo, UnitPrincipal, UnitQuerys;

{$R *.dfm}

procedure TFrmEntidad.FormCreate(Sender: TObject);
begin
        nombre.Text := '';
end;

procedure TFrmEntidad.BcerrarClick(Sender: TObject);
begin
        close;
end;

procedure TFrmEntidad.BCANCELARClick(Sender: TObject);
begin
        cancelar;
end;

procedure TFrmEntidad.nitKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          nombre.SetFocus;
end;

procedure TFrmEntidad.nombreKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          direccion.SetFocus;
end;

procedure TFrmEntidad.direccionKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          ciudad.SetFocus;
end;

procedure TFrmEntidad.ciudadKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          telefono.SetFocus;
end;
procedure TFrmEntidad.cancelar;
begin
        nit.Text := '';
        nombre.Text := '';
        direccion.Text := '';
        ciudad.Text := '';
        telefono.Text := '';
        correo.Text := '';
        nit.SetFocus;
        nit.Text := '';
end;

procedure TFrmEntidad.entra_datos;
begin
             with DataQuerys.IBingresa do
             begin
               Close;
               if Transaction.InTransaction then
                 Transaction.Commit;
               Transaction.StartTransaction;
               sQL.Clear;
               Sql.Add('Insert into "nom$entidad"');
               Sql.Add('values (');
               Sql.Add(':"nit",:"nombre",:"telefono",:"ciudad",:"direccion",:"correo")');
               ParamByname('nit').AsString:=nit.Text;
               ParamByname('nombre').AsString:=nombre.Text;
               ParamByname('direccion').AsString:=direccion.Text;
               ParamByname('ciudad').AsString:=ciudad.Text;
               ParamByname('telefono').AsString:=telefono.Text;
               ParamByName('correo').AsString := correo.Text;
               open;
               Close;
               Transaction.Commit;
            end;
end;

procedure TFrmEntidad.BACEPTARClick(Sender: TObject);
var nom,tel:string;
begin
       if nit.Text = '' then begin
          MessageDlg('El Campo Nit debe Contener un Valor',mtInformation,[mbOK],0);
          nit.SetFocus;
        end
          else if nombre.Text = '' then
          begin
            MessageDlg('El Campo Nombre debe Contener un Valor',mtInformation,[mbOK],0);
            nombre.SetFocus;
          end
            else if ciudad.Text = '' then
            begin
              MessageDlg('El Campo Ciudad debe Contener un Valor',mtInformation,[mbOK],0);
              ciudad.SetFocus;
            end
                else begin
                  tel := telefono.Text;
                  nom := nombre.Text;
                  entra_datos;
                  cancelar;
                 end;
end;

procedure TFrmEntidad.FormActivate(Sender: TObject);
begin
        nit.SetFocus;
end;

procedure TFrmEntidad.nitExit(Sender: TObject);
begin
        if nit.Text <> '' then
        begin
          with DataQuerys.IBselecion do
          begin
            close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
            Sql.Clear;
            SQL.Add('select * from "nom$entidad"');
            SQL.Add('where "nom$entidad"."nit" = :nit');
            ParamByName('nit').AsString := nit.Text;
            Open;
              if RecordCount <> 0 then
              begin
                MessageDlg('El Proveedor ya se Encuentra Registrado',mtInformation,[mbOK],0);
                nit.SetFocus;
              end;
                close;
            end;
        end;
end;

procedure TFrmEntidad.regimenKeyPress(Sender: TObject; var Key: Char);
begin
        if key=#13 then
          Baceptar.SetFocus;
end;

procedure TFrmEntidad.nombreExit(Sender: TObject);
begin
        nombre.Text := uppercase(nombre.Text);
end;

procedure TFrmEntidad.ciudadExit(Sender: TObject);
begin
        ciudad.Text := uppercase(ciudad.Text);
end;
procedure TFrmEntidad.telefonoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          correo.SetFocus;
end;

procedure TFrmEntidad.correoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          BACEPTAR.SetFocus;
end;

procedure TFrmEntidad.direccionExit(Sender: TObject);
begin
        direccion.Text := UpperCase(direccion.Text);
end;

end.
