unit UnitCredito;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList,strutils, Buttons;

type
  TFrmCredito = class(TForm)
    Button1: TButton;
    lista: TListBox;
    Button2: TButton;
    ActionList1: TActionList;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    BitBtn1: TBitBtn;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private

    procedure actualizaa;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCredito: TFrmCredito;

implementation
uses unitdata,UnitGlobal, UnitPrograma,Unitdatamodulo, UnitQuerys,
  Unitprogreso,unitdataquerys,Unitpantallaprogreso, UnitPrincipal, UnitVistapreliminar;
{$R *.dfm}

procedure TFrmCredito.actualizaa;
var     comit :string;
begin
        DataQuerys := TDataQuerys.Create(self);
        with DataQuerys.IBdatos do
        begin
           Close;
           SQL.Clear;
           SQL.Add('select * from "fun$datos_asociado"');
           Open;
           Last;
           First;
           frmProgresos := TfrmProgresos.Create(self);
           frmProgresos.Titulo := 'Actualizando Oficinas';
           frmProgresos.Max := RecordCount;
           frmProgresos.Min := 0;
           frmProgresos.Ejecutar;
           while not Eof do
           begin
           if Frac(RecNo/100) = 0 then
            begin
               verificatransaccion(DataQuerys.IBselecion);
               comit := CurrToStr(RecNo/100);
            end;
             frmProgresos.Position := RecNo;
             frmProgresos.InfoLabel := 'Actualizacion No : '+IntToStr(RecNo)+#13+'Commit No : '+comit;
             Application.ProcessMessages;
             with DataQuerys.IBselecion do
             begin
               Close;
               SQL.Clear;
               SQL.Add('update "fun$afiliacion" set');
               SQL.Add('"fun$afiliacion"."cod_oficina" = :oficina');
               SQL.Add('where "fun$afiliacion"."nit_asociado" = :nit');
               SQL.Add('and "fun$afiliacion"."es_local" = 0');
               ParamByName('oficina').AsInteger := DataQuerys.IBdatos.FieldByName('oficina').AsInteger;
               ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('nit_asociado').AsString;
               Open;
               Close;
             end;
             Next;
           end;
           frmProgresos.Cerrar;
           DataQuerys.IBselecion.Transaction.Commit;
        end;


end;

procedure TFrmCredito.Button1Click(Sender: TObject);
var     contador :Integer;
begin
        contador := 0;
        DataQuerys := TDataQuerys.Create(self);
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select * from "fun$prueba"');
          Open;
          while not Eof do
          begin
            with DataQuerys.IBselecion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('select * from "fun$beneficiario"');
              SQL.Add('where "fun$beneficiario"."identificacion" = :nit');
              ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('ced').AsString;
              Open;
              if RecordCount <> 0 then
              begin
                with DataQuerys.IBingresa do
                begin
                  Close;
                  verificatransaccion(DataQuerys.IBingresa);
                  SQL.Clear;
                  SQL.Add('delete from "fun$prueba"');
                  SQL.Add('where "fun$prueba"."ced" = :nit');
                  ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('ced').AsString;
                  Open;
                  Close;
                  Transaction.Commit;
                end;
                contador := contador + 1;
              end;
              Close;
          end;
          Next;
        end;
        ShowMessage('total : '+IntToStr(RecordCount)+ ' incluidos : '+IntToStr(contador));
end;
end;

procedure TFrmCredito.Button2Click(Sender: TObject);
var     nit_a :string;
       //esta : Smallint;
begin
        DataQuerys := TDataQuerys.Create(self);
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$prueba"."nombre","fun$prueba"."oficina"');
          SQL.Add(',"fun$prueba"."parentesco","fun$prueba"."nit_bene"');
          SQL.Add('FROM');
          SQL.Add('"fun$prueba"');
          SQL.Add('where "fun$prueba"."parentesco" = 1');
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Max :=RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
           frmProgresos.Position := RecNo;
           frmProgresos.InfoLabel := 'Registro Actualizado No : ' +IntToStr(RecNo);
           Application.ProcessMessages;
           if FieldByName('parentesco').AsString = '1' then
           begin
               //oficina := FieldByName('oficina').AsInteger;
               nit_a := FieldByName('nit_bene').AsString;
               //consecutivo := 1;

{             end
             else
            begin
            with DataQuerys.IBselecion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('SELECT');
              SQL.Add('"fun$beneficiario"."identificacion"');
              SQL.Add('FROM');
              SQL.Add('"fun$beneficiario"');
              SQL.Add('WHERE');
              SQL.Add('("fun$beneficiario"."nombres" = :nombres)');
              ParamByName('nombres').AsString := DataQuerys.IBdatos.fieldbyname('nombre').AsString;
              Open;
              nit := FieldByName('identificacion').AsString;
              if nit = '' then
              begin
                nit := nit_a + '-'+IntToStr(consecutivo);
                consecutivo := consecutivo + 1;
                esta := 0;
              end;}
            with DataQuerys.IBselecion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('update "fun$prueba" set' );
              //SQL.Add('"fun$prueba"."oficina" = :nit');
              SQL.Add('"fun$prueba"."esta" = 0,');
              SQL.Add('"fun$prueba"."nit_asociado" = :nit_a');
              SQL.Add('where "fun$prueba"."nombre" = :nombres');
              //ParamByName('esta').AsInteger := esta;
              //ParamByName('nit').AsString := nit;
              ParamByName('nit_a').AsString := nit_a;
              ParamByName('nombres').AsString := DataQuerys.IBdatos.fieldbyname('nombre').AsString;
              Open;
              Close;
            end;
            end;
            Next;
            end;
            frmProgresos.Cerrar;
            DataQuerys.IBselecion.Transaction.Commit;
            end;
end;

procedure TFrmCredito.Button3Click(Sender: TObject);
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$eje"."ced"');
          SQL.Add('FROM');
          SQL.Add('"fun$eje"');
          Open;
          while not Eof do
          begin
          with DataQuerys.IBselecion do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select * from BUSCA_BENE(:NIT)');
            ParamByName('NIT').AsString := DataQuerys.IBdatos.FieldByName('ced').AsString;
            Open;
            if FieldByName('NOMBRES').AsString <> '' then
            begin
              with DataQuerys.IBingresa do
              begin
              Close;
              SQL.Clear;
              verificatransaccion(DataQuerys.IBingresa);
              SQL.Add('update "fun$eje" set');
              SQL.Add('"fun$eje"."esta" = 1');
              SQL.Add('where "fun$eje"."ced" = :nit');
              ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('ced').AsString;
              Open;
              Close;
              Transaction.Commit;
              end;
            end;
          end;
        Next;
        end;
        end;
end;

procedure TFrmCredito.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
end;

procedure TFrmCredito.Button4Click(Sender: TObject);
begin
        with DataQuerys.IBdatos do
        begin
         Close;
         SQL.Clear;
         SQL.Add('SELECT');
         SQL.Add('*');
         SQL.Add('FROM');
         SQL.Add('"fun$titular"');
         Open;
         while not Eof do
         begin
          with DataQuerys.IBselecion do
          begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT');
           SQL.Add('"fun$datos_asociado"."nit_asociado"');
           SQL.Add('FROM');
           SQL.Add('"fun$datos_asociado"');
           SQL.Add('where "fun$datos_asociado"."nit_asociado" = :nit_a');
           ParamByName('nit_a').AsString  := DataQuerys.IBdatos.FieldByName('nit').AsString;
           Open;
           if RecordCount = 0 then
           begin
             SQL.Clear;
             SQL.Add('insert into "fun$datos_asociado" values(');
             SQL.Add(':nit_asociado,');
             SQL.Add(':oficina,');
             SQL.Add(':numero_cuenta)');
             ParamByName('nit_asociado').AsString := DataQuerys.IBdatos.FieldByName('nit').AsString;
             ParamByName('numero_cuenta').AsString := DataQuerys.IBdatos.FieldByName('cuenta').AsString;
             ParamByName('oficina').AsInteger := DataQuerys.IBdatos.FieldByName('oficina').AsInteger;
             Open;
           end;
           Close;
         end;
         Next;
        end;
        end;
end;

procedure TFrmCredito.Button5Click(Sender: TObject);
var     codigo :Integer;
begin
        DataQuerys := TDataQuerys.Create(self);
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$afiliacion"."nit_asociado"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."id_afiliacion" > 36437)');
          Open;
          Last;
          First;
          frmProgresos := tfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'registro no : ' + IntToStr(RecNo);
            Application.ProcessMessages;
            with DataQuerys.IBselecion do
            begin
              Close;
              verificatransaccion(DataQuerys.IBselecion);
              SQL.Clear;
              SQL.Add('SELECT DISTINCT');
              SQL.Add('"fun$afiliacion"."cod_oficina"');
              SQL.Add('FROM');
              SQL.Add('"fun$afiliacion"');
              SQL.Add('WHERE');
              SQL.Add('("fun$afiliacion"."id_afiliacion" < 36437) AND');
              SQL.Add('("fun$afiliacion"."nit_asociado" = :nit)');
              ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('nit_asociado').AsString;
              Open;
              codigo := FieldByName('cod_oficina').AsInteger;
              SQL.Clear;
              SQL.Add('update "fun$afiliacion" set');
              SQL.Add('"fun$afiliacion"."cod_oficina" = :cod_oficina,');
              if codigo = 1 then
                 SQL.Add('"fun$afiliacion"."es_local" = 1')
              else
                 SQL.Add('"fun$afiliacion"."es_local" = 0');
              SQL.Add('where "fun$afiliacion"."nit_asociado" = :nit and');
              SQL.Add('"fun$afiliacion"."id_afiliacion" > 36437');
              ParamByName('cod_oficina').AsInteger := codigo;
              ParamByName('nit').AsString := DataQuerys.IBdatos.FieldByName('nit_asociado').AsString;
              Open;
              Close
            end;
            Next;
          end;
          frmProgresos.Cerrar;
          Close;
        end;
end;

procedure TFrmCredito.Button6Click(Sender: TObject);
var     h,cadena :string;
        s :Integer;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"fun$afiliacion"."nit_beneficiario"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('INNER JOIN "fun$beneficiario" ON ("fun$afiliacion"."nit_beneficiario" = "fun$beneficiario"."identificacion")');
          SQL.Add('WHERE');
          SQL.Add('("fun$beneficiario"."tipo_id" = 4)');
          //SQL.Add('and "fun$afiliacion"."id_afiliacion" > 39000');
          Open;
          Last;
          First;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := IntToStr(RecNo);
            Application.ProcessMessages;
            s := StrLen(PChar(FieldByName('nit_beneficiario').AsString));
            h := MidStr(FieldByName('nit_beneficiario').AsString,s,1);
            cadena := FieldByName('nit_beneficiario').AsString;
            if h = '/' then
               cadena := LeftStr(FieldByName('nit_beneficiario').AsString,s-1);
            with DataQuerys.IBselecion do
            begin
              Close;
              verificatransaccion(DataQuerys.IBselecion);
              SQL.Clear;
              SQL.Add('update "fun$afiliacion" set');
              SQL.Add('"fun$afiliacion"."nit_beneficiario" = :nit_b');
              SQL.Add('where "fun$afiliacion"."nit_beneficiario" = :nit_be');
              ParamByName('nit_be').AsString := cadena;
              ParamByName('nit_b').AsString := DataQuerys.IBdatos.fieldbyname('nit_beneficiario').AsString;
              Open;
              Close;
            end;
            Next;
          end;
          Close;
          frmProgresos.Cerrar;
        end;
end;

procedure TFrmCredito.BitBtn1Click(Sender: TObject);
var     cedulaa :string;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$afiliacion_1"."nit_beneficiario",');
          SQL.Add('"fun$afiliacion_1"."id_afiliacion",');
          SQL.Add('"fun$afiliacion_1"."parentesco"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion_1"');
          Open;
          Last;
          First;
          FrmProgreso := TFrmProgreso.Create(self);
          FrmProgreso.Barra.Maximum := RecordCount;
          FrmProgreso.Show;
          while not Eof do
          begin
            FrmProgreso.Barra.Position := DataQuerys.IBdatos.RecNo;
            FrmProgreso.Caption := 'Actualizacion Numero: ' + IntToStr(RecNo);
            if (FieldByName('parentesco').AsInteger = 1) or (FieldByName('parentesco').AsInteger = 20) then
               cedulaa := FieldByName('nit_beneficiario').AsString;
            with DataQuerys.IBselecion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('update "fun$afiliacion_1" set ');
              SQL.Add('"fun$afiliacion_1"."nit_asociado" = :cedula');
              SQL.Add('where "fun$afiliacion_1"."id_afiliacion" = :ced');
              ParamByName('ced').AsInteger := DataQuerys.IBdatos.FieldByName('id_afiliacion').AsInteger;
              ParamByName('cedula').AsString := cedulaa;
              Open;
              Close;
            end;
          Next;
        end;
        Close;
        FrmProgreso.Hide;
        DataQuerys.IBselecion.Transaction.Commit;
        end;

end;

end.
