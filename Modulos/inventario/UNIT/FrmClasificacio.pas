unit FRMCLASIFICACIO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Buttons, DB, IBCustomDataSet,
  IBQuery, IBDatabase, ExtCtrls, IBSQL, ImgList, ComCtrls, ToolWin;

type
  Tfrmclasificacion = class(TForm)
    Ibres: TIBQuery;
    Panel1: TPanel;
    COD_CLASIFICACION: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    nombre: TEdit;
    DESCRIPCION: TMemo;
    Panel2: TPanel;
    BCANCELAR: TBitBtn;
    BACEPTAR: TBitBtn;
    IbSql: TIBSQL;
    Bcerrar: TBitBtn;
    codigo: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure nombreKeyPress(Sender: TObject; var Key: Char);
    procedure BCANCELARClick(Sender: TObject);
    procedure DESCRIPCIONKeyPress(Sender: TObject; var Key: Char);
    procedure BACEPTARClick(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure nombreExit(Sender: TObject);
    procedure DESCRIPCIONExit(Sender: TObject);
    procedure codigoKeyPress(Sender: TObject; var Key: Char);
    procedure codigoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmclasificacion: Tfrmclasificacion;
  contador: integer;



implementation
uses    FrmDatamodulo, frmDependencia;
//var     DataGeneral:TdataGeneral;


{$R *.dfm}

procedure Tfrmclasificacion.FormCreate(Sender: TObject);
begin
        //DataGeneral:=TdataGeneral.Create(self);



//IBDatabase1.Connected:=true;
//IBTransaction1.Active:=true;
//MEMO1.Text:='';
end;

procedure Tfrmclasificacion.nombreKeyPress(Sender: TObject; var Key: Char);
begin
        IF KEY = #13 THEN
        descripcion.SetFocus;
end;

procedure Tfrmclasificacion.BCANCELARClick(Sender: TObject);
begin
        cod_clasificacion.Caption:='';
        nombre.Text:='';
        descripcion.Text:='';
        nombre.SetFocus;
        cod_clasificacion.Caption:='';


end;



procedure Tfrmclasificacion.DESCRIPCIONKeyPress(Sender: TObject;
  var Key: Char);
begin
        if key=#13 then
        Baceptar.SetFocus
end;

procedure Tfrmclasificacion.BACEPTARClick(Sender: TObject);

begin
        if codigo.Text = '' then
        begin
          showmessage('El Campo Codigo no puede Ser Nulo');
          codigo.SetFocus;
        end
          else if nombre.Text = '' then
          begin
            showmessage('El Campo Nombre no puede Ser Nulo');
            nombre.SetFocus;
          end
          else
          begin
            With DataGeneral.IBsql do
            Begin
              Sql.Clear;
              Sql.Add('Insert Into "inv$clasificacion"(' );
              Sql.Add('"inv$clasificacion"."cod_clasificacion",');
              Sql.Add('"inv$clasificacion"."nombre",');
              Sql.Add('"inv$clasificacion"."descripcion" )');
              Sql.Add('values(');
              Sql.Add(':"Cod_Clasificacion",:"Nombre",:"Descripcion")');
              Parambyname('Cod_Clasificacion').AsInteger:=strtoint(codigo.Text);
              Parambyname('Nombre').AsString:=nombre.Text;
              Parambyname('Descripcion').AsString:=descripcion.Text;
              execquery;
              close;
              DataGeneral.IBTransaction1.CommitRetaining;
              cod_clasificacion.Caption:='';
              nombre.Text:='';
              codigo.Text:='';
              descripcion.Text:='';
              codigo.SetFocus;
            end;
          end;
end;

procedure Tfrmclasificacion.BcerrarClick(Sender: TObject);
begin

        cod_clasificacion.Caption:='';
        nombre.Text:='';
        descripcion.Text:='';
        close;

end;

procedure Tfrmclasificacion.FormActivate(Sender: TObject);
begin
        Codigo.SetFocus;
end;

procedure Tfrmclasificacion.nombreExit(Sender: TObject);
begin
        NOMBRE.Text:=uppercase(nombre.Text);
end;

procedure Tfrmclasificacion.DESCRIPCIONExit(Sender: TObject);
begin
        descripcion.Text:=uppercase(descripcion.Text);
end;

procedure Tfrmclasificacion.codigoKeyPress(Sender: TObject; var Key: Char);
begin
        dependencia.NumericoSinPunto(self,key);
        if key=#13 then
           nombre.SetFocus
end;

procedure Tfrmclasificacion.codigoExit(Sender: TObject);
var nombre:string;
begin
        if codigo.Text <> '' then
        begin
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "inv$clasificacion"."nombre" from "inv$clasificacion"');
          SQL.Add('where "inv$clasificacion"."cod_clasificacion" = :"codigo"');
          ParamByName('codigo').AsInteger:=StrToInt(codigo.Text);
          Open;
          nombre := FieldByName('nombre').AsString;
          Close;
        end;

        if nombre <> '' then
          begin
          ShowMessage('El Codigo '+codigo.Text+ ' Ya se encuentra Asignado a '+ nombre);
          codigo.Text:='';
          codigo.SetFocus;
          end;
          end;
          end;

end.
