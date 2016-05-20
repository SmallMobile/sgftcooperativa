unit FrmAgencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ToolWin, ExtCtrls, ImgList;

type
  Td = class(TForm)
    panel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;              
    Label5: TLabel;
    Descripcion: TMemo;
    direccion: TEdit;
    ciudad: TEdit;
    telefono: TEdit;
    Cod_agencia: TEdit;
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    BCANCELAR: TBitBtn;
    Bcerrar: TBitBtn;
    procedure Cod_agenciaKeyPress(Sender: TObject; var Key: Char);
    procedure DescripcionKeyPress(Sender: TObject; var Key: Char);
    procedure direccionKeyPress(Sender: TObject; var Key: Char);
    procedure ciudadKeyPress(Sender: TObject; var Key: Char);
    procedure telefonoKeyPress(Sender: TObject; var Key: Char);
    procedure BACEPTARClick(Sender: TObject);
    procedure BCANCELARClick(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DescripcionExit(Sender: TObject);
    procedure Cod_agenciaExit(Sender: TObject);
  private
    { Private declarations }
  public
  published
    procedure entra_datos;
    procedure limpia_datos;
    { Public declarations }
  end;

var
  d: Td;

implementation
Uses    FrmDataModulo,frmdependencia;
//Var     DataGeneral:TdataGeneral;

{$R *.dfm}

procedure Td.Cod_agenciaKeyPress(Sender: TObject; var Key: Char);
begin
        dependencia.NumericoSinPunto(self,key);
        if key = #13 then
          descripcion.SetFocus;
end;

procedure Td.DescripcionKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
          direccion.SetFocus;
end;

procedure Td.direccionKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
          ciudad.SetFocus;
end;

procedure Td.ciudadKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
          telefono.SetFocus;
end;

procedure Td.telefonoKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
          Baceptar.SetFocus;

end;

procedure Td.BACEPTARClick(Sender: TObject);
begin
        if cod_agencia.Text = '' then
        begin
          Showmessage('El campo Codigo no Puede ser Nulo');
          cod_agencia.SetFocus;
        end
        else
          entra_datos;
          limpia_datos;

end;

procedure Td.entra_datos;
begin
        With DataGeneral.IBsql do
        Begin
          Sql.Clear;
          Sql.Add('Insert into "Inv$Agencia" (');
          Sql.Add('"Inv$Agencia"."cod_agencia",');
          Sql.Add('"Inv$Agencia"."descripcion",');
          Sql.Add('"Inv$Agencia"."direccion",');
          Sql.Add('"Inv$Agencia"."telefono",');
          Sql.Add('"Inv$Agencia"."ciudad" )');
          Sql.Add('Values (');
          Sql.Add(':"cod_agencia",:"descripcion",:"direccion",');
          Sql.Add(':"telefono",:"ciudad" )');
          ParamByname('cod_agencia').AsInteger:=strtoint(cod_agencia.Text);
          ParamByname('descripcion').AsString:=descripcion.Text;
          ParamByname('direccion').AsString:=direccion.Text;
          ParamByname('telefono').AsString:=telefono.Text;
          ParamByname('ciudad').AsString:=ciudad.Text;
          Execquery;
          Close;
          DataGeneral.IBTransaction1.CommitRetaining;
        End;



end;

procedure Td.limpia_datos;
begin
        cod_agencia.Text:='';
        descripcion.Text:='';
        direccion.Text:='';
        telefono.Text:='';
        ciudad.Text:='';
        cod_agencia.SetFocus;

end;

procedure Td.BCANCELARClick(Sender: TObject);
begin
        limpia_datos;
end;

procedure Td.BcerrarClick(Sender: TObject);
begin
        close;
end;

procedure Td.FormActivate(Sender: TObject);
begin
        cod_agencia.SetFocus;
end;

procedure Td.DescripcionExit(Sender: TObject);
begin
        uppercase(descripcion.Text);

end;

procedure Td.Cod_agenciaExit(Sender: TObject);
begin
        if cod_agencia.Text <> '' then
        begin
          with datageneral.IBdatos do
          begin
            close;
            sql.Clear;
            sql.Add('select "Inv$Agencia"."cod_agencia" from "Inv$Agencia"');
            sql.Add('where "Inv$Agencia"."cod_agencia"=:"codigo"');
            parambyname('codigo').AsInteger:=strtoint(cod_agencia.Text);
           open;
             if RecordCount > 0 then
             begin
               showmessage('Ya existe El codigo');
               cod_agencia.SetFocus;
             end;
           close;
          end;
        end;

end;

end.
