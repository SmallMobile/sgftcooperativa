unit FrmEmpleados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ToolWin, ExtCtrls, DBCtrls, ImgList,
  DB, IBCustomDataSet,frmdependencia;

type
  Templeado = class(TForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

var       empleado: Templeado;
          cod_dep:integer;
          idsex: char;

implementation
uses    FrmDatamodulo,frmsalida;
//var     DataGeneral:TdataGeneral;

{$R *.dfm}

procedure Templeado.nitKeyPress(Sender: TObject; var Key: Char);
begin
        NumericoSinPunto(self,key);

        if key = #13 then
        sexo.SetFocus;
end;



procedure Templeado.sexoKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        nombres.SetFocus;
end;

procedure Templeado.nombresKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        apellidos.SetFocus;
end;

procedure Templeado.apellidosKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        direccion.SetFocus;
end;

procedure Templeado.direccionKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        ciudad.SetFocus;
end;

procedure Templeado.ciudadKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        telefono.SetFocus;
end;

procedure Templeado.telefonoKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        cargo.SetFocus;
end;

procedure Templeado.cargoKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        dependencia.SetFocus;
end;

procedure Templeado.dependenciaKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        ext_telefono.SetFocus
end;

procedure Templeado.ext_telefonoKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        baceptar.SetFocus;
end;

procedure Templeado.BcerrarClick(Sender: TObject);
begin
        close;
end;

procedure Templeado.limpiar;
begin
        nit.Text:='';
        nombres.Text:='';
        apellidos.Text:='';
        direccion.Text:='';
        ciudad.Text:='';
        telefono.Text:='';
        cargo.Text:='';
        dependencia.KeyValue := -1;
        ext_telefono.Text:='';
        nit.SetFocus;


end;

procedure Templeado.BCANCELARClick(Sender: TObject);
begin
        limpiar;
end;

procedure Templeado.FormCreate(Sender: TObject);
begin
        //DataGeneral:=TdataGeneral.Create(self);
        ibdataset1.Active:=true;
end;

procedure Templeado.entra_datos;

begin
        with DataGeneral.IBsql do
        begin
        Sql.Clear;
        Sql.Add('Insert into "inv$empleado" (');
        Sql.Add('"inv$empleado"."nit",');
        Sql.Add('"inv$empleado"."nombre",');
        Sql.Add('"inv$empleado"."apellido",');
        Sql.Add('"inv$empleado"."cargo",');
        Sql.Add('"inv$empleado"."ext_telefono",');
        Sql.Add('"inv$empleado"."cod_dependencia",');
        Sql.Add('"inv$empleado"."direccion",');
        Sql.Add('"inv$empleado"."ciudad",');
        Sql.Add('"inv$empleado"."sexo",');
        Sql.Add('"inv$empleado"."telefono")');
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
        ExecQuery;
        Close;
        DataGeneral.IBTransaction1.CommitRetaining;
        end;
end;

procedure Templeado.verificacod;


begin
        with datageneral.IBdatos do
        begin
        Sql.Clear;
        Sql.Add('select "inv$dependencia"."cod_dependencia" as coddep from "inv$dependencia"');
        Sql.Add('where "inv$dependencia"."nombre" like :"SISTEMAS"');
        ParamByname('SISTEMAS').AsString:=dependencia.Text;
        open;
        cod_dep:=FieldByname('coddep').AsInteger;
        close;
        end;
end;

procedure Templeado.nombresExit(Sender: TObject);
begin
        nombres.Text:=uppercase(nombres.Text);
        if sexo.Text='Masculino' then
        begin
            idsex:='M';
        end
        else
            idsex:='F';

        end;


procedure Templeado.BACEPTARClick(Sender: TObject);
var nombres1,seccion: string;
begin
        if actempleado = true then
        begin
          verificacod;
          try
          with datageneral.IBdatos do
          begin
            close;
            sql.clear;
            sql.Add('update "inv$empleado" set "inv$empleado"."cod_dependencia"=:"codigo",');
            sql.Add('"inv$empleado"."nombre"=:"nombre",');
            sql.Add('"inv$empleado"."apellido"=:"apellido",');
            sql.Add('"inv$empleado"."direccion"=:"direccion",');
            sql.Add('"inv$empleado"."ext_telefono"=:"e_telefono",');
            sql.Add('"inv$empleado"."cargo"=:"cargo",');
            sql.Add('"inv$empleado"."telefono"=:"telefono"');
            sql.Add('where "inv$empleado"."nit"=:"nit"');
            parambyname('nit').AsInteger:=strtoint(nit.Text);
            parambyname('codigo').AsInteger := dependencia.KeyValue;
            parambyname('nombre').AsString:=nombres.Text;
            parambyname('apellido').AsString:=apellidos.Text;
            parambyname('direccion').AsString:=direccion.Text;
            parambyname('e_telefono').AsString:=ext_telefono.Text;
            parambyname('telefono').AsString:=telefono.Text;
            ParamByName('cargo').AsString := cargo.Text;
            open;
            close;
            datageneral.IBTransaction1.CommitRetaining;
            limpiar;
            end;
            except
            on E: Exception do
            begin
            nit.SetFocus;
            end;
            end;

        end
        else
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
                    nombres1:= nombres.Text;
                    seccion:=dependencia.Text;
                    limpiar;
                       if openempleado = true then begin
                       empleado.Close;
                       salida.dependencia.Caption:=seccion;
                       salida.nombre1.Text:=nombres1;
                       salida.Show;
                       salida.Dbagencia.SetFocus;
                       end;
        end;
        end;


end;

procedure Templeado.ToolButton1Click(Sender: TObject);
begin
        verificacod;
        entra_datos;
end;

procedure Templeado.FormClose(Sender: TObject; var Action: TCloseAction);
begin

        if openempleado = true then begin
        empleado.Close;
        salida.Show;
        openempleado:=false;
        end;

end;

procedure Templeado.verificadep;
begin

end;

procedure Templeado.NumericoSinPunto(Sender: TObject; var Key: Char);
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

procedure Templeado.FormActivate(Sender: TObject);
begin
        ibdataset1.Active:=true;
        ibdataset1.Last;
        nit.SetFocus;
end;

procedure Templeado.nitExit(Sender: TObject);
var vernit: string;
begin
        if nit.Text <> '' then begin
        if actempleado = true  then
        actemp
        else
        begin
        with datageneral.IBdatos do
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



procedure Templeado.actemp;
var sexo1:string;

begin
        with datageneral.IBsel do
        begin
        close;
        sql.Clear;
        sql.Add('select "inv$empleado"."nombre" as nombre,"inv$empleado"."apellido" as apellido,');
        sql.Add('"inv$empleado"."cargo" as cargo,"inv$empleado"."ext_telefono" as e_telefono,');
        sql.Add('"inv$empleado"."cod_dependencia" as dependencia,"inv$empleado"."direccion" as direccion,');
        sql.Add('"inv$empleado"."ciudad" as ciudad,"inv$empleado"."sexo" as sexo,');
        sql.Add ('"inv$empleado"."telefono" as telefono');
        sql.Add(' from "inv$empleado"');
        sql.Add('where "inv$empleado"."nit"=:"nit"');
        parambyname('nit').AsInteger:=strtoint(nit.Text);
        open;
        nombres.Text:=fieldbyname('nombre').AsString;
        apellidos.Text:=fieldbyname('apellido').AsString;
        direccion.Text:=fieldbyname('direccion').AsString;
        ciudad.Text:=fieldbyname('ciudad').AsString;
        telefono.Text:=fieldbyname('telefono').AsString;
        cargo.Text:=fieldbyname('cargo').AsString;
        dependencia.KeyValue := fieldbyname('dependencia').AsString;
        ext_telefono.Text:=fieldbyname('e_telefono').AsString;
        sexo1 := FieldByName('sexo').AsString;
        if sexo1 = 'M' then
        sexo.ItemIndex:=1
        else
        sexo.ItemIndex:=0;
        close;
        end;
        if nombres.Text='' then
        begin
        Showmessage('El Empleado no Existe');
        nit.SetFocus;
        end;


end;

procedure Templeado.apellidosExit(Sender: TObject);
begin
        apellidos.Text:=uppercase(apellidos.Text);
end;

procedure Templeado.ciudadExit(Sender: TObject);
begin
        ciudad.Text:=uppercase(ciudad.Text);
end;

procedure Templeado.cargoExit(Sender: TObject);
begin
        cargo.Text:=uppercase(cargo.Text);
end;

procedure Templeado.direccionExit(Sender: TObject);
begin
direccion.Text:=uppercase(direccion.Text);
end;

end.


