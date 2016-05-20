unit UnitPension;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, StdCtrls, ExtCtrls, DBCtrls,
  JvStaticText, JvEdit, JvTypedEdit, Buttons, Mask, JvToolEdit, JvCurrEdit;

type
  TFrmPension = class(TForm)
    Panel1: TPanel;
    empleado: TComboBox;
    Label2: TLabel;
    busca_nombre: TIBQuery;
    empleadonit: TComboBox;
    Label3: TLabel;
    seccion: TEdit;
    Label1: TLabel;
    nomina: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    IBpension: TIBQuery;
    DSpension: TDataSource;
    DBpension: TDBLookupComboBox;
    Label4: TLabel;
    JVpension: TJvStaticText;
    JVaporte: TJvCurrencyEdit;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure empleadoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JVaporteEnter(Sender: TObject);
    procedure JVaporteKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
  private
  nit_emp :Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPension: TFrmPension;

implementation
uses UnitGlobal, UnitQuerys;

{$R *.dfm}

procedure TFrmPension.empleadoExit(Sender: TObject);
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
        with DataQuerys.IBselecion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"nom$tiponomina"."descripcion","nom$empleado"."sueldobasico","nom$empleado"."codigo_pension"');
          SQL.Add('FROM');
          SQL.Add('"nom$empleado",');
          SQL.Add('"nom$tiponomina"');
          SQL.Add('WHERE');
          SQL.Add('("nom$empleado"."tipo_nomina" = "nom$tiponomina"."codigo") AND');
          SQL.Add('("nom$empleado"."nitempleado" = :nit)');
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          nomina.Text := FieldByName('descripcion').AsString;
          DBpension.KeyValue := FieldByName('codigo_pension').AsInteger;
          JVpension.Caption := DBpension.Text;
          SQL.Clear;
          SQL.Add('select sum("nom$pension"."valor") as valor from "nom$pension"');
          SQL.Add('where "nom$pension"."id_persona" = :ID_PERSONA and "nom$pension"."id_nomina" = :ID_NOMINA');
          ParamByName('ID_PERSONA').AsInteger := nit_emp;
          ParamByName('ID_NOMINA').AsInteger := buscanomina(DataQuerys.IBingresa);
          Open;
          if FieldByName('valor').AsCurrency <> 0 then
          begin
             MessageDlg('El Empleado ' + empleado.Text + ' Posee Registrada' + #13 + FormatCurr('#,##0.00',FieldByName('valor').AsCurrency) + ' en Pensiones Voluntarias',mtInformation,[mbok],0);
          end;
          Close;
          if nit_emp <> 0 then
          begin
            SQL.Clear;
            SQL.Add('select * from "nom$pension" where "nom$pension"."id_persona" = :id_persona');
            ParamByName('id_persona').AsInteger := nit_emp;
            Open;
            JVaporte.Value := FieldByName('valor').AsCurrency;
          end;
        end;
end;

procedure TFrmPension.FormCreate(Sender: TObject);
begin
        IBpension.Open;
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
        end;

end;

procedure TFrmPension.JVaporteEnter(Sender: TObject);
begin
        JVaporte.SelectAll
end;

procedure TFrmPension.JVaporteKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           BitBtn1.SetFocus
end;

procedure TFrmPension.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmPension.BitBtn2Click(Sender: TObject);
begin
        empleado.ItemIndex := -1;
        seccion.Text := '';
        nomina.Text := '';
        JVaporte.Value := 0;
        JVpension.Caption := '';
        empleado.SetFocus;
end;

procedure TFrmPension.BitBtn1Click(Sender: TObject);
begin
        if nit_emp = 0 then
        begin
           MessageDlg('Favor Verifique el Empleado, No Existe',mtWarning,[mbok],0);
           empleado.SetFocus;
           Exit;
        end;
        if MessageDlg('Seguro de Realizar la Transacción ?',mtInformation,[mbyes,mbno],0) = mryes then
        begin
          if JVaporte.Value = 0 then
          begin
            with DataQuerys.IBselecion do
            begin
               Close;
               SQL.Clear;
               SQL.Add('delete from "nom$pension" where "nom$pension"."id_persona" = :id_persona');
               ParamByName('id_persona').AsInteger := nit_emp;
               ExecSQL;
               Transaction.Commit;
               Transaction.StartTransaction;
               BitBtn2.Click;
            end;
            Exit;            
          end;

           with DataQuerys.IBselecion do
           begin
             Close;
             SQL.Clear;
             SQL.Add('select * from "nom$pension" where "nom$pension"."id_persona" = :id_persona');
             ParamByName('id_persona').AsInteger := nit_emp;
             Open;
             if RecordCount > 0 then
             begin
             SQL.Clear;
             SQL.Add('delete from "nom$pension" where "nom$pension"."id_persona" = :id_persona');
             ParamByName('id_persona').AsInteger := nit_emp;
             ExecSQL;
             end;
             SQL.Clear;
             SQL.Add('insert into "nom$pension" values (0,:id_persona,:valor)');
             ParamByName('id_persona').AsInteger := nit_emp;
             ParamByName('valor').AsCurrency := JVaporte.Value;
             ExecSQL;
             Transaction.Commit;
             Transaction.StartTransaction;
             BitBtn2.Click;
           end;
        end;

end;

procedure TFrmPension.empleadoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           JVaporte.SetFocus
end;

end.
