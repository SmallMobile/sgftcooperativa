unit UnitPrestacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls, IBDatabase, DB,
  IBCustomDataSet, IBQuery;

type
  TFrmPrestacion = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BACEPTAR: TBitBtn;
    Salir: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbempresa: TDBLookupComboBox;
    dbservicio: TDBLookupComboBox;
    editcodigo: TMaskEdit;
    Label4: TLabel;
    descripcion: TEdit;
    Dsempresa: TDataSource;
    IBempresa: TIBQuery;
    IBTransempresa: TIBTransaction;
    IBservicio: TIBQuery;
    DSservicio: TDataSource;
    procedure SalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbempresaKeyPress(Sender: TObject; var Key: Char);
    procedure dbservicioKeyPress(Sender: TObject; var Key: Char);
    procedure editcodigoKeyPress(Sender: TObject; var Key: Char);
    procedure editcodigoExit(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure dbempresaExit(Sender: TObject);
    procedure dbservicioExit(Sender: TObject);
  private
  codigo,nit_empresa :string;
  cod_prestacion,cod_servicio :Integer;
  codigo_pucbasico :Integer;


    { Private declarations }
  public
  published
    procedure registrarcodigo;
    procedure entra_datos;
    procedure limpiar;
    { Public declarations }
  end;

var
  FrmPrestacion: TFrmPrestacion;

implementation
uses unitdatamodulo, UnitdataQuerys, UnitQuerys, Unitglobal;

{$R *.dfm}

procedure TFrmPrestacion.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmPrestacion.FormCreate(Sender: TObject);
begin
        IBservicio.Open;
        IBservicio.Last;
        IBempresa.Open;
        IBempresa.Last;
        FrmQuerys := TFrmQuerys.Create(self);
end;

procedure TFrmPrestacion.dbempresaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           dbservicio.SetFocus;
end;
procedure TFrmPrestacion.dbservicioKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           editcodigo.SetFocus;
end;

procedure TFrmPrestacion.editcodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           BACEPTAR.SetFocus;
end;

procedure TFrmPrestacion.editcodigoExit(Sender: TObject);
var     Cadena:string;
begin
        Cadena := EditCODIGO.Text;
        while Pos(' ',Cadena) > 0 do
          Cadena[Pos(' ',Cadena)] := '0';
        Codigo := Cadena;
        with FrmQuerys.IBseleccion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "NOMBRE"');
          SQL.Add('from "con$puc"');
          SQL.Add('where "con$puc"."CODIGO" =:"CODIGO"');
          ParamByName('CODIGO').AsString := codigo;
          Open;
          if RecordCount = 0 then
          begin
            MessageDlg('El Codigo es Incorrecto',mtInformation,[mbOK],0);
            editcodigo.SetFocus;
          end
          else
          descripcion.Text := FieldByName('NOMBRE').AsString;
          Close;
        end;
end;

procedure TFrmPrestacion.registrarcodigo;

begin

end;

procedure TFrmPrestacion.BACEPTARClick(Sender: TObject);
begin
        if nit_empresa = '0' then
        begin
           MessageDlg('El Campo Empresa no Puede ser Nulo',mtInformation,[mbOK],0);
           dbempresa.SetFocus
        end
        else if cod_servicio = 0 then
        begin
           MessageDlg('El Campo Servicio no Puede ser Nulo',mtInformation,[mbOK],0);
           dbservicio.SetFocus
        end
        else if descripcion.Text = '' then
        begin
           MessageDlg('El Campo cod. Contable no Puede ser Nulo',mtInformation,[mbOK],0);
           editcodigo.SetFocus
        end
        else
        begin
        registrarcodigo;
        entra_datos;
        limpiar;
        end;
end;

procedure TFrmPrestacion.entra_datos;
var     identificador : Smallint;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('select * from "nom$pucbasico"');
          SQL.Add('where "nom$pucbasico"."codigo" ='+codigo);
          Open;
          if RecordCount = 1 then
          begin
            MessageDlg('Ya se Encuentra registrada el Codigo de la Cuenta',mtInformation,[mbOK],0);
            editcodigo.SetFocus;
            Exit;
          end;
          SQL.Clear;
          SQL.Add('select max("nom$pucbasico"."id") as id from "nom$pucbasico"');
          Open;
          identificador := FieldByName('id').AsInteger;
          codigo_pucbasico := identificador+1;
          SQL.Clear;
          SQL.Add('insert into "nom$pucbasico"');
          SQL.Add('values (');
          SQL.Add(':id,:codigo,:descripcion)');
          ParamByName('id').AsInteger := identificador+1;
          ParamByName('codigo').AsString := codigo;
          ParamByName('descripcion').AsString := descripcion.Text;
          Open;
          SQL.Clear;
          SQL.Add('select max("nom$prestacion"."codigo") as cod_prestacion from "nom$prestacion"');
          Open;
          cod_prestacion := FieldByName('cod_prestacion').AsInteger+1;
          try
            SQL.Clear;
            SQL.Add('insert into "nom$prestacion"');
            SQL.Add('values (');
            SQL.Add(':nitentidad,:tipoprestacion,:codigo,');
            SQL.Add(':codigopuc,:fechaingreso)');
            ParamByName('nitentidad').AsString := nit_empresa;
            ParamByName('tipoprestacion').AsInteger := cod_servicio;
            ParamByName('codigo').AsInteger := cod_prestacion;
            ParamByName('codigopuc').AsInteger := codigo_pucbasico;
            ParamByName('fechaingreso').AsDatetime := Date;
            Open;
            Close;
            Transaction.Commit;
          except on E: Exception do
          begin
            Transaction.Rollback;
            MessageDlg('Ya se Encuentra registrado el servicio',mtInformation,[mbOK],0);
          end;
          end;

        end;


end;
procedure TFrmPrestacion.dbempresaExit(Sender: TObject);
begin
        try
        nit_empresa := dbempresa.KeyValue;
        except on E: Exception do
        begin
        nit_empresa := '0';
        end;
        end;
end;

procedure TFrmPrestacion.dbservicioExit(Sender: TObject);
begin
        try
        cod_servicio := dbservicio.KeyValue;
        except on E: Exception do
        begin
        cod_servicio := 0;
        end;
        end;
end;

procedure TFrmPrestacion.limpiar;
begin
        editcodigo.Text := '';
        descripcion.Text := ''
end;

end.
