unit UnitEliminaEmpleado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, IBDatabase, DB, IBCustomDataSet,
  IBQuery;

type
  TFrmEliminaEmpleado = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    empleado: TComboBox;
    empleadonit: TComboBox;
    seccion: TEdit;
    nomina: TEdit;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    busca_nombre: TIBQuery;
    IBTransaction1: TIBTransaction;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure empleadoExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
  nit_emp :Integer;
    { Private declarations }
  public
  published
    procedure eliminar_nomina(nit: integer);
    { Public declarations }
  end;

var
  FrmEliminaEmpleado: TFrmEliminaEmpleado;

implementation

uses UnitQuerys, UnitGlobal;

{$R *.dfm}

procedure TFrmEliminaEmpleado.FormCreate(Sender: TObject);
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Clear;
          SQL.Add('select "inv$empleado"."nombre","inv$empleado"."apellido"  from "inv$empleado"');
          SQL.Add('where "inv$empleado"."nit" in (');
          SQL.Add('select "nom$empleado"."nitempleado" from "nom$empleado")');          
          SQL.Add('order by "inv$empleado"."nombre"');
          Open;
          while not Eof do
          begin
            empleado.Items.Add(FieldByName('nombre').AsString + ' ' + fieldbyname('apellido').AsString);
            empleadonit.Items.Add(FieldByName('nombre').AsString + fieldbyname('apellido').AsString);
            Next;
             end;
          Close;
          Transaction.Commit;
        end;
end;

procedure TFrmEliminaEmpleado.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmEliminaEmpleado.eliminar_nomina(nit: integer);
begin
        if nit = 1 then begin
          with DataQuerys.IBdatos do
          begin
            Close;
            verificatransaccion(DataQuerys.IBdatos);
            SQL.Clear;
            SQL.Add('delete from "nom$empleado"');
            SQL.Add('where "nom$empleado"."nitempleado" = :nit');
            ParamByName('nit').AsInteger := nit_emp;
            Open;
            SQL.Clear;
            SQL.Add('delete from "nom$obligaciones" where "nom$obligaciones"."nit" = :nit');
            ParamByName('nit').AsInteger := nit_emp;
            Open;
            SQL.Clear;
            SQL.Add('delete from "nom$consolidado" where "nom$consolidado"."nit" = :nit');
            ParamByName('nit').AsInteger := nit_emp;
            Open;
            SQL.Clear;
            SQL.Add('delete from "nom$retefuente" where "nom$retefuente"."nit_empleado" = :nit');
            ParamByName('nit').AsInteger := nit_emp;
            Open;
            SQL.Clear;
            SQL.Add('delete from "nomina" where "nomina"."nit" = :nit');
            ParamByName('nit').AsInteger := nit_emp;
            Open;
            Close;
            Transaction.Commit;
          end;
        end
        else begin
        end;
end;

procedure TFrmEliminaEmpleado.empleadoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           BitBtn2.SetFocus
end;

procedure TFrmEliminaEmpleado.empleadoExit(Sender: TObject);
var     a :Integer;
        b: string;
begin
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        busca_nombre.Close;
        busca_nombre.parambyname('nombre').AsString := b;
        busca_nombre.Open;
        nit_emp := busca_nombre.fieldbyname('nit').AsInteger;
        seccion.Text := busca_nombre.fieldbyname('nombre').AsString;
        busca_nombre.Close;
        if nit_emp = 0 then
        begin
          MessageDlg('El Nombre del Empleado no es Correcto',mtInformation,[mbOK],0);
          empleado.SetFocus;
          Exit;
        end;
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$tiponomina"."descripcion"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado",');
          SQL.Add('"nom$tiponomina"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."tipo_nomina" = "nom$tiponomina"."codigo") AND');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          nomina.Text := FieldByName('descripcion').AsString;
          Close;
        end;
end;

procedure TFrmEliminaEmpleado.BitBtn2Click(Sender: TObject);
begin
        if MessageDlg('Seguro de Eliminar al Empleado(a)'+#13+empleado.Text,mtWarning,[mbyes,mbno],0) = mryes then
        begin
           eliminar_nomina(1);
           nomina.Text := '';
           seccion.Text := '';
           empleado.ItemIndex := -1;
        end;
end;

end.
