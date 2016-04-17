unit UnitHorasExtras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, StdCtrls, ExtCtrls, Buttons,
  JvEdit, JvTypedEdit,Math, Mask;

type
  TFrmHorasExtras = class(TForm)
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
    Panel4: TPanel;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    BACEPTAR: TBitBtn;
    Panel2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    total: TJvCurrencyEdit;
    Panel3: TPanel;
    Label7: TLabel;
    Rdiurna: TRadioButton;
    Rnocturna: TRadioButton;
    hora: TJvEdit;
    Rdominical: TRadioButton;
    Rdomnocturna: TRadioButton;
    Rdomdiurna: TRadioButton;
    Rdominicalextra: TRadioButton;
    Rotras: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure horaKeyPress(Sender: TObject; var Key: Char);
    procedure SalirClick(Sender: TObject);
    procedure horaExit(Sender: TObject);
    procedure empleadoExit(Sender: TObject);
    procedure empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure CancelarClick(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure RdiurnaKeyPress(Sender: TObject; var Key: Char);
    procedure RnocturnaKeyPress(Sender: TObject; var Key: Char);
    procedure RdominicalKeyPress(Sender: TObject; var Key: Char);
    procedure RdomnocturnaKeyPress(Sender: TObject; var Key: Char);
    procedure RdominicalextraKeyPress(Sender: TObject; var Key: Char);
    procedure RdomdiurnaKeyPress(Sender: TObject; var Key: Char);
    procedure RotrasKeyPress(Sender: TObject; var Key: Char);
  private
  nit_emp :Integer;
  minutos :Currency;
    diurno: integer;
    procedure limpiar;
    procedure entra_datos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmHorasExtras: TFrmHorasExtras;

implementation

uses UnitQuerys,unitglobal;

{$R *.dfm}

procedure TFrmHorasExtras.FormCreate(Sender: TObject);
begin

        Rdiurna.Hint := 'Hora Extra Diurna con Recargo del '+CurrToStr((valorhoraextra(dataquerys.IBaportes,3)-1)*100)+'%';
        Rnocturna.Hint := 'Hora Extra Nocturna con Recargo del '+CurrToStr((valorhoraextra(dataquerys.IBaportes,4)-1)*100)+'%';
        Rdominical.Hint := 'Hora Ordinaria Dominical Diurna con Recargo del '+CurrToStr((valorhoraextra(dataquerys.IBaportes,5)-1)*100)+'%';
        Rdomnocturna.Hint := 'Hora Ordinaria Dominical Nocturna con Recargo del '+CurrToStr((valorhoraextra(dataquerys.IBaportes,6)-1)*100)+'%';
        Rdomdiurna.Hint := 'Hora Extra Dominical Diurna con Recargo del '+CurrToStr((valorhoraextra(dataquerys.IBaportes,7)-1)*100)+'%';
        Rdominicalextra.Hint := 'Hora Extra Dominical Nocturna con Recargo del '+CurrToStr((valorhoraextra(dataquerys.IBaportes,10)-1)*100)+'%';
        Rotras.Hint := 'Solo Recargo del '+CurrToStr((valorhoraextra(dataquerys.IBaportes,11))*100)+'%';
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

procedure TFrmHorasExtras.horaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           BACEPTAR.SetFocus;
end;

procedure TFrmHorasExtras.SalirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmHorasExtras.horaExit(Sender: TObject);
var    valor_hora,hora1 :Currency;
begin

        if hora.Text <> '' then
           begin
           if Frac(StrToCurr(hora.Text)) > 60 then
              begin
              MessageDlg('Excede el Numero Maximo de Minutos',mtError,[mbok],0);
              hora.SetFocus;
           end
           else if Frac(StrToCurr(hora.Text)) < 0.01 then
               minutos := StrToCurr(hora.Text)
           else
           begin
               hora1 := (Frac(StrToCurr(hora.Text))*100)/60;
               minutos := int(StrToCurr(hora.Text))+hora1;
           end;
           valor_hora :=(descuento(DataQuerys.IBselecion,nit_emp,3)/240)* minutos;
           if Rdiurna.Checked then
           begin
             total.Value := SimpleRoundTo(valor_hora*valorhoraextra(dataquerys.IBaportes,3),0);
             diurno := 1;
           end
           else if Rnocturna.Checked then
           begin
             total.Value := SimpleRoundTo(valor_hora*valorhoraextra(dataquerys.IBaportes,4),0);
             diurno := 2;
           end
           else if Rdominical.Checked then
           begin
             total.Value := SimpleRoundTo(valor_hora* valorhoraextra(dataquerys.IBaportes,5),0);
             diurno := 3;
           end
           else if Rdomnocturna.Checked then
           begin
             total.Value := SimpleRoundTo(valor_hora* valorhoraextra(dataquerys.IBaportes,6),0);
             diurno := 4;
           end
           else if Rdomdiurna.Checked then
           begin
             total.Value := SimpleRoundTo(valor_hora* valorhoraextra(dataquerys.IBaportes,7),0);
             diurno := 5;
           end
           else if Rdominicalextra.Checked then
           begin
             total.Value := SimpleRoundTo(valor_hora* valorhoraextra(dataquerys.IBaportes,10),0);
             diurno := 6;
           end
           else if Rotras.Checked then
           begin
             total.Value := SimpleRoundTo(valor_hora* valorhoraextra(dataquerys.IBaportes,11),0);
             diurno := 7;
           end;

        end;
end;

procedure TFrmHorasExtras.empleadoExit(Sender: TObject);
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
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('sum("nom$horasextras"."horas") as horas');
          SQL.Add('FROM');
          SQL.Add('"nom$horasextras"');
          SQL.Add('INNER JOIN "nom$controlnomina" ON ("nom$horasextras"."cod_nomina" = "nom$controlnomina"."cod_nomina")');
          SQL.Add('WHERE');
          SQL.Add('("nom$horasextras"."nit_empleado" = :nit) and');
          SQL.Add('("nom$controlnomina"."liquidada" = 0) and');
          SQL.Add('("nom$controlnomina"."fecha" = :fecha)');
          ParamByName('nit').AsInteger := nit_emp;
          ParamByName('fecha').AsDateTime := StrToDate(FormatDateTime('yyyy/mm/01',Date));
          Open;
          b:= FieldByName('horas').AsString;
          if FieldByName('horas').AsString <> '' then
          begin
            if MessageDlg(empleado.Text+' Tiene Registrada un total de: '+
            FieldByName('horas').AsString+'  Horas'+#13+'                                     Desea Continuar?'
            ,mtInformation,[mbYes,mbNo],0) = mrNO Then
          empleado.SetFocus
          end;
          Close;
        end;

end;

procedure TFrmHorasExtras.empleadoKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           Rdiurna.SetFocus;
end;

procedure TFrmHorasExtras.limpiar;
begin
        empleado.ItemIndex := -1;
        seccion.Text := '';
        nomina.Text := '';
        hora.Text := '';
        total.Value := 0;
        empleado.SetFocus;
end;

procedure TFrmHorasExtras.CancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmHorasExtras.BACEPTARClick(Sender: TObject);
begin
        if hora.Text = '' then
        begin
          MessageDlg('El Campo no puede ser Nulo',mtInformation,[mbOK],0);
          hora.SetFocus;
        end
        else
        begin
        entra_datos;
        limpiar;
        end;

end;

procedure TFrmHorasExtras.entra_datos;
var     codigonomina :Integer;
begin
        codigonomina := buscanomina(DataQuerys.IBselecion);
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('insert into "nom$horasextras"');
          SQL.Add('values (');
          SQL.Add(':cod_nomina,:horas,:nit_empleado,:diurna)');
          ParamByName('cod_nomina').AsInteger := codigonomina;
          ParamByName('horas').AsCurrency := minutos;
          ParamByName('nit_empleado').AsInteger := nit_emp;
          ParamByName('diurna').AsInteger := diurno;
          Open;
          Close;
          Transaction.Commit;
        end;

end;

procedure TFrmHorasExtras.RdiurnaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           hora.SetFocus;
end;

procedure TFrmHorasExtras.RnocturnaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           hora.SetFocus;
end;

procedure TFrmHorasExtras.RdominicalKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           hora.SetFocus;
end;

procedure TFrmHorasExtras.RdomnocturnaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           hora.SetFocus;
end;

procedure TFrmHorasExtras.RdominicalextraKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           hora.SetFocus;
end;

procedure TFrmHorasExtras.RdomdiurnaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           hora.SetFocus;
end;

procedure TFrmHorasExtras.RotrasKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           hora.SetFocus;
end;

end.
