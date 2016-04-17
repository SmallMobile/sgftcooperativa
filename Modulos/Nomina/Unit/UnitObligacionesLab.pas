unit UnitObligacionesLab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, IBCustomDataSet, IBQuery, Buttons,
  JvEdit, JvTypedEdit, JvLabel;

type
  TFrmObligacionLaboral = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    empleado: TComboBox;
    empleadonit: TComboBox;
    seccion: TEdit;
    nomina: TEdit;
    busca_nombre: TIBQuery;
    Panel2: TPanel;
    Label5: TLabel;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    JvLabel3: TJvLabel;
    viaticos: TJvCurrencyEdit;
    transporte: TJvCurrencyEdit;
    bonificacion: TJvCurrencyEdit;
    Panel4: TPanel;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    BACEPTAR: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure viaticosKeyPress(Sender: TObject; var Key: Char);
    procedure transporteKeyPress(Sender: TObject; var Key: Char);
    procedure bonificacionKeyPress(Sender: TObject; var Key: Char);
    procedure SalirClick(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
  private
  nit_emp :Integer;
    procedure limpiar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmObligacionLaboral: TFrmObligacionLaboral;

implementation

uses UnitQuerys, UnitDatosempleado,UnitGlobal;

{$R *.dfm}

procedure TFrmObligacionLaboral.FormCreate(Sender: TObject);
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

procedure TFrmObligacionLaboral.empleadoExit(Sender: TObject);
var     a :Integer;
        b :String;
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
          SQL.Add('"nom$tiponomina"."descripcion","nom$empleado"."sueldobasico"');
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

procedure TFrmObligacionLaboral.empleadoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          viaticos.SetFocus
end;

procedure TFrmObligacionLaboral.viaticosKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          transporte.SetFocus

end;

procedure TFrmObligacionLaboral.transporteKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           bonificacion.SetFocus
end;

procedure TFrmObligacionLaboral.bonificacionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          BACEPTAR.SetFocus;

end;

procedure TFrmObligacionLaboral.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmObligacionLaboral.limpiar;
begin
        viaticos.Value := 0;
        bonificacion.Value := 0;
        transporte.Value := 0;
        seccion.Text := '';
        nomina.Text := '';
        empleado.ItemIndex := -1;
        empleado.SetFocus;
end;

procedure TFrmObligacionLaboral.BACEPTARClick(Sender: TObject);
begin
        if bonificacion.Value <> 0 then
           obligacion(10,nit_emp,(bonificacion.Value + selobligacion(10,nit_emp)));
        if viaticos.Value <> 0 then
           obligacion(3,nit_emp,(viaticos.Value+ selobligacion(3,nit_emp)));
        if transporte.Value <> 0 then
           obligacion(4,nit_emp,(transporte.Value + selobligacion(13,nit_emp)));
        limpiar;
end;

end.
