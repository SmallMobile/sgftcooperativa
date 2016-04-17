unit UnitEliminaHoras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, IBCustomDataSet, IBQuery, Buttons,
  JvEdit, JvTypedEdit;

type
  TFrmReversar = class(TForm)
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
    Label5: TLabel;
    TEHoras: TEdit;
    boton: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label6: TLabel;
    JVvalor: TJvCurrencyEdit;
    CHtodo: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure botonClick(Sender: TObject);
  private
  nit_emp :Integer;
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReversar: TFrmReversar;

implementation

uses UnitQuerys,UnitGlobal, UnitDatosempleado;

{$R *.dfm}

procedure TFrmReversar.FormCreate(Sender: TObject);
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

procedure TFrmReversar.empleadoExit(Sender: TObject);
var     a :Integer;
        b :string;
        hn,hf,hd,hdi,vn,vd,vdi,vf,valor_hora :Currency;
        hed,hved,hdd,hvdd :Currency;
        valor_h : Variant;
begin
          hdi := 0;
          hd := 0;
          hf := 0;
          hn := 0;
        a := empleado.ItemIndex;
        empleadonit.ItemIndex := a;
        b := empleadonit.Text;
        busca_nombre.Close;
        busca_nombre.parambyname('nombre').AsString := b;
        busca_nombre.Open;
        nit_emp := busca_nombre.fieldbyname('nit').AsInteger;
        seccion.Text := busca_nombre.fieldbyname('nombre').AsString;
        busca_nombre.Close;
        if empleado.Text <> '' then
        begin
        if nit_emp = 0 then
        begin
          MessageDlg('El Nombre del Empleado no es Correcto',mtInformation,[mbOK],0);
          empleado.SetFocus;
          Exit;
        end;
        valor_hora := descuento(DataQuerys.IBselecion,nit_emp,3)/240;
        with DataQuerys.IBdatos do
        begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT DISTINCT');
           SQL.Add('"nom$tiponomina"."descripcion"');
           SQL.Add('FROM');
           SQL.Add('"nom$tiponomina",');
           SQL.Add('"nom$empleado"');
           SQL.Add('WHERE');
           SQL.Add('("nom$tiponomina"."codigo" = "nom$empleado"."tipo_nomina") AND');
           SQL.Add('("nom$empleado"."nitempleado" = :nit)');
           ParamByName('nit').AsInteger := nit_emp;
           Open;
           nomina.Text := FieldByName('descripcion').AsString;
           Close;
        end;
        with DataQuerys.IBdatos do
            begin
              Close;
              verificatransaccion(DataQuerys.IBdatos);
              SQL.Clear;
              SQL.Add('select "nom$horasextras"."horas","nom$horasextras"."diurna" from "nom$horasextras"');
              SQL.Add('where "nom$horasextras"."cod_nomina" = :cod_nomina and');
              SQL.Add('"nom$horasextras"."nit_empleado" = :nit');
              ParamByName('cod_nomina').AsInteger := buscanomina(DataQuerys.IBingresa);
              ParamByName('nit').AsInteger := nit_emp;
              Open;
              while not Eof do
              begin
                case FieldByName('diurna').AsInteger of
                 1:hdi := hdi + FieldByName('horas').AsCurrency; //total_horas + (valor_hora * FieldByName('horas').AsCurrency) * 1.25;// hora diurna
                 2:hf := hf + FieldByName('horas').AsCurrency;
                 3:hd := hd + FieldByName('horas').AsCurrency;
                 4:hn := hn + FieldByName('horas').AsCurrency;
//                 4:hed := hed + FieldByName('horas').AsCurrency;
                 5:hdd := hdd + FieldByName('horas').AsCurrency;
                end;
                Next;
              end;
              valor_h := 0.2;
              JVvalor.Value := valor_h;
              TEHoras.Text := CurrToStr(hdi+hf+hd+hn);
              if JVvalor.Value <> 0 then
              begin
                 boton.Enabled := True;
                 boton.SetFocus;
              end
              else
                 boton.Enabled := false
          end;
        end;
        
end;

procedure TFrmReversar.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmReversar.BitBtn2Click(Sender: TObject);
begin
        empleado.ItemIndex := -1;
        seccion.Text := '';
        nomina.Text := '';
        TEHoras.Text := '';
        empleado.SetFocus;
end;

procedure TFrmReversar.botonClick(Sender: TObject);
begin
        if MessageDlg('Esta Seguro de Eliminar la Horas Extras?',mtinformation,[mbyes,mbno],0) = mryes then
        begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          if CHtodo.Checked = false then
          begin
          SQL.Add('delete from "nom$horasextras"');
          SQL.Add('where "nom$horasextras"."cod_nomina" = :tipo_nomina');
          SQL.Add('and "nom$horasextras"."nit_empleado" = :nit');
          ParamByName('tipo_nomina').AsSmallInt := buscanomina(DataQuerys.IBselecion);
          ParamByName('nit').AsInteger := nit_emp;
          Open;
          end
          else
          begin
          SQL.Add('delete from "nom$horasextras"');
          SQL.Add('where "nom$horasextras"."cod_nomina" = :tipo_nomina');
          ParamByName('tipo_nomina').AsSmallInt := buscanomina(DataQuerys.IBselecion);
          Open;
          end;
          Close;
          Transaction.Commit;
        end;
        empleado.ItemIndex := -1;
        seccion.Text := '';
        nomina.Text := '';
        TEHoras.Text := '';
        empleado.SetFocus;
        end
        else
        empleado.SetFocus;
        boton.Enabled := False;
end;

procedure TFrmReversar.cmChildKey(var msg: TWMKEY);
begin
if msg.CharCode = VK_RETURN then
    if not (Assigned(ActiveControl) and
           ((ActiveControl is TButton) or
            (ActiveControl is TCustomMemo)))
    then begin
      msg.Result := 1;
      keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), 0, 0);
      Keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), KEYEVENTF_KEYUP, 0);
    end;
end;

end.
