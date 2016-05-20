unit UnitDatosempleado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ToolWin, ExtCtrls, DBCtrls, ImgList,
  DB, IBCustomDataSet, IBDatabase;

type
  TFrmempleado1 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    nit: TEdit;
    Label2: TLabel;
    nombres: TEdit;
    Label6: TLabel;
    apellidos: TEdit;
    Label3: TLabel;
    telefono: TEdit;
    Label7: TLabel;
    direccion: TEdit;
    Label5: TLabel;
    ciudad: TEdit;
    Label4: TLabel;
    sexo: TComboBox;
    GroupBox2: TGroupBox;
    cargo: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ext_telefono: TEdit;
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    BCANCELAR: TBitBtn;
    Bcerrar: TBitBtn;
    DataSource1: TDataSource;
    IBDataSet1: TIBDataSet;
    dependencia: TDBLookupComboBox;
    IBTransaction1: TIBTransaction;
    procedure nitKeyPress(Sender: TObject; var Key: Char);
    procedure sexoKeyPress(Sender: TObject; var Key: Char);
    procedure nombresKeyPress(Sender: TObject; var Key: Char);
    procedure apellidosKeyPress(Sender: TObject; var Key: Char);
    procedure direccionKeyPress(Sender: TObject; var Key: Char);
    procedure ciudadKeyPress(Sender: TObject; var Key: Char);
    procedure telefonoKeyPress(Sender: TObject; var Key: Char);
    procedure cargoKeyPress(Sender: TObject; var Key: Char);
    procedure dependenciaKeyPress(Sender: TObject; var Key: Char);
    procedure ext_telefonoKeyPress(Sender: TObject; var Key: Char);
    procedure BcerrarClick(Sender: TObject);
    procedure BCANCELARClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nombresExit(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure nitExit(Sender: TObject);
    procedure apellidosExit(Sender: TObject);
    procedure ciudadExit(Sender: TObject);
    procedure cargoExit(Sender: TObject);
    procedure direccionExit(Sender: TObject);



  private
    { Private declarations }
  public
        openempleado: boolean;
        actempleado: boolean;
    procedure actemp;
  published
    procedure limpiar;
    procedure entra_datos;
    procedure verificacod;
    procedure verificadep;
    procedure NumericoSinPunto(Sender: TObject; var Key: Char);
    { Public declarations }
  end;

var       Frmempleado1: TFrmempleado1;
          cod_dep:integer;
          idsex: char;

implementation
uses unitquerys,unitdatamodulo;
//var     DataGeneral:TdataGeneral;

{$R *.dfm}

procedure TFrmempleado1.nitKeyPress(Sender: TObject; var Key: Char);
begin
        NumericoSinPunto(self,key);

        if key = #13 then
        sexo.SetFocus;
end;



procedure TFrmempleado1.sexoKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        nombres.SetFocus;
end;

procedure TFrmempleado1.nombresKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        apellidos.SetFocus;
end;

procedure TFrmempleado1.apellidosKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        direccion.SetFocus;
end;

procedure TFrmempleado1.direccionKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        ciudad.SetFocus;
end;

procedure TFrmempleado1.ciudadKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        telefono.SetFocus;
end;

procedure TFrmempleado1.telefonoKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        cargo.SetFocus;
end;

procedure TFrmempleado1.cargoKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        dependencia.SetFocus;
end;

procedure TFrmempleado1.dependenciaKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        ext_telefono.SetFocus
end;

procedure TFrmempleado1.ext_telefonoKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        baceptar.SetFocus;
end;

procedure TFrmempleado1.BcerrarClick(Sender: TObject);
begin
        close;
end;

procedure TFrmempleado1.limpiar;
begin
        nit.Text:='';
        nombres.Text:='';
        apellidos.Text:='';
        direccion.Text:='';
        ciudad.Text:='';
        telefono.Text:='';
        cargo.Text:='';
        //dependencia.Text:='';
        ext_telefono.Text:='';
        nit.SetFocus;


end;

procedure TFrmempleado1.BCANCELARClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmempleado1.FormCreate(Sender: TObject);
begin
        //DataGeneral:=TdataGeneral.Create(self);
        ibdataset1.Active:=true;
end;

procedure TFrmempleado1.entra_datos;

begin
        with DataQuerys.IBingresa do
        begin
        Close;
        if Transaction.InTransaction then
           Transaction.Commit;
        Transaction.StartTransaction;
        Sql.Clear;
        Sql.Add('Insert into "inv$empleado" ');
        Sql.Add('values (');
        Sql.Add(':"nit",:"nombre",:"apellido",:"cargo",:"ext_telefono",:"cod_dependencia",');
        Sql.Add(':"direccion",:"ciudad",:"sexo",:"telefono")');
        Parambyname('nit').AsInteger:=strtoint(nit.Text);
        Parambyname('nombre').AsString:=nombres.Text;
        Parambyname('apellido').AsString:=apellidos.Text;
        Parambyname('cargo').AsString:=cargo.Text;
        Parambyname('ext_telefono').AsString:=telefono.Text;
        Parambyname('cod_dependencia').AsInteger:=cod_dep;
        Parambyname('direccion').AsString:=direccion.Text;
        Parambyname('ciudad').AsString:=ciudad.Text;
        Parambyname('sexo').AsString:=idsex;
        Parambyname('telefono').AsString:=telefono.Text;
        Open;
        Close;
        Transaction.Commit;
        end;
end;
procedure TFrmempleado1.verificacod;
begin
        with DataQuerys.IBselecion do
        begin
        Close;
        Sql.Clear;
        Sql.Add('select "inv$dependencia"."cod_dependencia" as coddep from "inv$dependencia"');
        Sql.Add('where "inv$dependencia"."nombre" like :"SISTEMAS"');
        ParamByname('SISTEMAS').AsString:=dependencia.Text;
        open;
        cod_dep:=FieldByname('coddep').AsInteger;
        close;
        end;
end;

procedure TFrmempleado1.nombresExit(Sender: TObject);
begin
        nombres.Text:=uppercase(nombres.Text);
        if sexo.Text='Masculino' then
        begin
            idsex:='M';
        end
        else
            idsex:='F';

        end;


procedure TFrmempleado1.BACEPTARClick(Sender: TObject);
begin
          if nit.Text= '' then
          begin
            Showmessage('El Campo Nit debe Contener un Valor');
            nit.SetFocus;
          end
            else if nombres.Text = '' then
            begin
              Showmessage('El Campo Nombre debe Contener un Valor');
              nombres.SetFocus;
            end
              else if apellidos.Text = '' then
              begin
                Showmessage('El Campo apellido debe Contener un Valor');
                apellidos.SetFocus;
              end
                else if dependencia.Text = '' then
                  Showmessage('El Campo Dependencia debe Contener un Valor')
                  else
                  begin
                    verificacod;
                    entra_datos;
                    limpiar;
        end;


end;

procedure TFrmempleado1.ToolButton1Click(Sender: TObject);
begin
        verificacod;
        entra_datos;
end;

procedure TFrmempleado1.verificadep;
begin

end;

procedure TFrmempleado1.NumericoSinPunto(Sender: TObject; var Key: Char);
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

procedure TFrmempleado1.FormActivate(Sender: TObject);
begin
        ibdataset1.Active:=true;
        ibdataset1.Last;
        nit.SetFocus;
end;

procedure TFrmempleado1.nitExit(Sender: TObject);
var vernit: string;
begin
        if nit.Text <> '' then begin
        if actempleado = true  then
        actemp
        else
        begin
        with DataQuerys.IBselecion do
        begin
        close;
        Sql.Clear;
        Sql.Add('Select "inv$empleado"."nombre" as nombre from "inv$empleado"');
        Sql.Add('where "inv$empleado"."nit"=:"codigo"' );
        ParamByname('codigo').AsString:=nit.Text;
        open;
        vernit:=fieldbyname('nombre').AsString;
        if vernit <> '' then
        begin
        Showmessage('El Empleado ya se Encuentra Registrado');
        nit.SetFocus;
        end;
        end;
        end;
        end;
        end;



procedure TFrmempleado1.actemp;
begin
end;

procedure TFrmempleado1.apellidosExit(Sender: TObject);
begin
        apellidos.Text:=uppercase(apellidos.Text);
end;

procedure TFrmempleado1.ciudadExit(Sender: TObject);
begin
        ciudad.Text:=uppercase(ciudad.Text);
end;

procedure TFrmempleado1.cargoExit(Sender: TObject);
begin
        cargo.Text:=uppercase(cargo.Text);
end;

procedure TFrmempleado1.direccionExit(Sender: TObject);
begin
direccion.Text:=uppercase(direccion.Text);
end;

end.


