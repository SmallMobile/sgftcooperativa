unit UnitCancelar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, IBCustomDataSet, IBQuery, JvEdit,
  JvTypedEdit, JvLabel, Buttons, JvButtons, Math;

type
  TFrmCancelar = class(TForm)
    empleadonit: TComboBox;
    empleado: TComboBox;
    Label2: TLabel;
    l2: TPanel;
    busca_nombre: TIBQuery;
    Label1: TLabel;
    seccion: TEdit;
    JvLabel1: TJvLabel;
    dias: TJvIntegerEdit;
    boton: TJvHTButton;
    GroupBox1: TGroupBox;
    Sa: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    salud: TJvCurrencyEdit;
    pension: TJvCurrencyEdit;
    transporte: TJvCurrencyEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TSpeedButton;
    procedure empleadoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure diasKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure botonClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
  nit_emp :Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCancelar: TFrmCancelar;

implementation

uses UnitQuerys,UnitGlobal;

{$R *.dfm}

procedure TFrmCancelar.empleadoExit(Sender: TObject);
var     a :Integer;
        b: string;
begin
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        busca_nombre.Close;
        verificatransaccion(busca_nombre);
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
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$empleado"."sueldobasico" from "nom$empleado" where');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          if RecordCount = 0 then
          begin
            MessageDlg('Emnpleado no Registrado en la Nomina',mtError,[mbok],0);
            empleado.SetFocus;
            Exit;
          end;
        end;
end;

procedure TFrmCancelar.FormCreate(Sender: TObject);
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('select "inv$empleado"."nombre","inv$empleado"."apellido"  from "inv$empleado"');
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

procedure TFrmCancelar.empleadoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           dias.SetFocus;
end;

procedure TFrmCancelar.diasKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           boton.SetFocus
end;

procedure TFrmCancelar.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmCancelar.BitBtn2Click(Sender: TObject);
begin
        empleado.ItemIndex := -1;
        seccion.Text := '';
        dias.Value := 0;
        salud.Value := 0;
        pension.Value := 0;
        transporte.Value := 0;
        empleado.SetFocus;
end;

procedure TFrmCancelar.botonClick(Sender: TObject);
var     porcentajeS,porcentajeP :Currency;
        codigo :Integer;
begin
       codigo := 8;
       with DataQuerys.IBdatos do
       begin
         verificatransaccion(DataQuerys.IBdatos);
         SQL.Clear;
         SQL.Add('select "nom$tipoprestacion"."porempleado" from "nom$tipoprestacion"');
         SQL.Add('where "nom$tipoprestacion"."codigo" = :codigo');
         ParamByName('codigo').AsInteger := 100;
         Open;
         porcentajeS := FieldByName('porempleado').AsCurrency;
         SQL.Clear;
         SQL.Add('select "nom$tipoprestacion"."porempleado" from "nom$tipoprestacion"');
         SQL.Add('where "nom$tipoprestacion"."codigo" = :codigo');
         ParamByName('codigo').AsInteger := 200;
         Open;
         porcentajeP := FieldByName('porempleado').AsCurrency;
         SQL.Clear;
         SQL.Add('select "nom$empleado"."sueldobasico" from "nom$empleado"');
         SQL.Add('where "nom$empleado"."nitempleado" = :nit');
         ParamByName('nit').AsInteger := nit_emp;
         Open;
         salud.Value := SimpleRoundTo((((ibc(DataQuerys.IBselecion,nit_emp) * porcentajeS)) / 100) / 30,0) * dias.Value;
         pension.Value := SimpleRoundTo((((ibc(DataQuerys.IBselecion,nit_emp) * porcentajeP)) / 100) / 30,0) * dias.Value;
         Close;
         SQL.Clear;
         SQL.Add('select "nom$empleado"."jornada","nom$empleado"."aux_transporte" from "nom$empleado" where  "nom$empleado"."nitempleado" = :nit');
         ParamByName('nit').AsInteger := nit_emp;
         Open;
         if FieldByName('aux_transporte').AsInteger = 0 then
            transporte.Value := 0
         else
         begin
           if abs(FieldByName('jornada').AsInteger) = 1 then
              codigo := 9;
           SQL.Clear;
           SQL.Add('select "nom$general"."valor" from "nom$general"');
           SQL.Add('where "nom$general"."codigo" = :codigo');
           ParamByName('codigo').AsInteger := codigo;
           Open;
           transporte.Value := SimpleRoundTo(((FieldByName('valor').AsCurrency/30)*dias.Value),0);
         end;

       end;
end;

procedure TFrmCancelar.BitBtn1Click(Sender: TObject);
begin
        if MessageDlg('Esta Seguro de Realizar la Operación?',mtInformation,[mbyes,mbno],0) = mryes then
        verificatransaccion(DataQuerys.IBingresa);
        with DataQuerys.IBingresa do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "nom$cancelacion" values (:NIT,:CODIGO,:DIAS)');
          ParamByName('NIT').AsInteger := nit_emp;
          ParamByName('CODIGO').AsInteger := buscanomina(DataQuerys.IBQuery1);
          ParamByName('DIAS').AsInteger := dias.Value;
          ExecSQL;
          Close;
          SQL.Clear;
          SQL.Add('delete from "nom$consolidado" where "nom$consolidado"."nit" = :NIT');
          ParamByName('NIT').AsInteger := nit_emp;
          ExecSQL;
          Transaction.Commit;
          MessageDlg('Operación Realizada con Exito',mtinformation,[mbok],0);
          BitBtn2.Click;
        end;
end;

end.
