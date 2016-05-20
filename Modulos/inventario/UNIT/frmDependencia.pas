unit frmDependencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ToolWin, ExtCtrls, ImgList;

type
  TDependencia = class(TForm)
    panel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nombre: TMemo;
    telefono: TEdit;
    codigo_dependencia: TEdit;
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    BCANCELAR: TBitBtn;
    Bcerrar: TBitBtn;
    ImageList1: TImageList;
    jefe: TEdit;
    procedure codigo_dependenciaKeyPress(Sender: TObject; var Key: Char);
    procedure nombreKeyPress(Sender: TObject; var Key: Char);
    procedure telefonoKeyPress(Sender: TObject; var Key: Char);
    procedure jefeKeyPress(Sender: TObject; var Key: Char);
    procedure BACEPTARClick(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure BCANCELARClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure codigo_dependenciaExit(Sender: TObject);
    procedure nombreExit(Sender: TObject);
    procedure jefeExit(Sender: TObject);
  private
    { Private declarations }
  public

  published
  procedure NumericoSinPunto(Sender: TObject; var Key: Char);
    procedure limpiar;

    { Public declarations }
  end;

var
  Dependencia: TDependencia;

implementation
uses frmdatamodulo,frmprincipal;
//var datageneral:TdataGeneral;

{$R *.dfm}

procedure TDependencia.codigo_dependenciaKeyPress(Sender: TObject;
  var Key: Char);
begin
        numericosinpunto(self,key);

        if key = #13 then
          nombre.SetFocus;
end;

procedure TDependencia.nombreKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
          telefono.SetFocus;
end;

procedure TDependencia.telefonoKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
          jefe.SetFocus;
end;

procedure TDependencia.jefeKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
          baceptar.SetFocus;
end;

procedure TDependencia.NumericoSinPunto(Sender: TObject; var Key: Char);
begin
if not (Key in [#8,#13, '0'..'9']) then
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
  procedure TDependencia.BACEPTARClick(Sender: TObject);
begin


        if codigo_dependencia.Text = '' then
        begin
          showmessage('El Campo Codigo no puede Ser Nulo');
          codigo_dependencia.SetFocus;
        end
          else if nombre.Text = '' then
          begin
            showmessage('El Campo Descripción no puede Ser Nulo');
            nombre.SetFocus;
          end
             else
             begin
               with datageneral.IBsql do
               begin
                 close;
                 Sql.Clear;
                 Sql.Add('Insert into "inv$dependencia" values (');
                 Sql.Add(':"cod_dependencia",:"nombre",:"telefono",:"jefe")');
                 Parambyname('cod_dependencia').AsInteger:= strtoint(codigo_dependencia.Text);
                 Parambyname('nombre').AsString:=nombre.Text;
                 Parambyname('telefono').AsString:=telefono.Text;
                 Parambyname('jefe').AsString:=jefe.Text;
                 Execquery;
                 close;
                 DataGeneral.IBTransaction1.CommitRetaining;
               end;
               limpiar;
        end;
end;

procedure TDependencia.BcerrarClick(Sender: TObject);
begin
        close;
end;

procedure TDependencia.BCANCELARClick(Sender: TObject);
begin
        limpiar;
end;

procedure TDependencia.limpiar;
begin
        codigo_dependencia.Text:='';
        nombre.Text:='';
        telefono.Text:='';
        jefe.Text:='';
        codigo_dependencia.SetFocus;
end;

procedure TDependencia.FormActivate(Sender: TObject);
begin
        codigo_dependencia.SetFocus;
end;

procedure TDependencia.codigo_dependenciaExit(Sender: TObject);
var     cod_dep: string;
begin

        with datageneral.IBdatos do
        begin
          Sql.Clear;
          Sql.Add('select "inv$dependencia"."cod_dependencia" as coddep from "inv$dependencia"');
          Sql.Add('where "inv$dependencia"."cod_dependencia"=:"codigo"');
          ParamByname('codigo').AsString:=codigo_dependencia.Text;
          open;
          cod_dep:=FieldByname('coddep').AsString;
          close;
            if cod_dep <> '' then
            begin
              Showmessage('El Codigo Ya esta Registrado');
              Codigo_dependencia.SetFocus;
            end;
        end;
end;

procedure TDependencia.nombreExit(Sender: TObject);
begin
        nombre.Text:=uppercase(nombre.Text);

end;

procedure TDependencia.jefeExit(Sender: TObject);
begin
        jefe.Text:=uppercase(jefe.Text);
end;

end.








