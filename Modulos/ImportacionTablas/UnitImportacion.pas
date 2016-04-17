unit UnitImportacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, FIBQuery, pFIBQuery, FIBDatabase,
  pFIBDatabase;

type
  TForm1 = class(TForm)
    pFIBAnterior: TpFIBDatabase;
    pFIBTransaction1: TpFIBTransaction;
    pFIBNueva: TpFIBDatabase;
    pFIBTransaction2: TpFIBTransaction;
    IBQuery1: TpFIBQuery;
    IBQuery2: TpFIBQuery;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
        with IBQuery1 do begin
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('select * from "gen$persona" where ID_IDENTIFICACION = :ID and ID_PERSONA > :ID_PERSONA order by ID_IDENTIFICACION, ID_PERSONA');
          Parambyname('ID').AsInteger := strtoint(Edit2.Text);
          ParamByName('ID_PERSONA').AsString := Edit1.Text;
          ExecQuery;

          while not Eof do begin
             Label2.Caption := FieldByName('ID_PERSONA').AsString;
             Application.ProcessMessages;
             IBQuery2.Transaction.StartTransaction;
             IBQuery2.Close;
             IBQuery2.SQL.Clear;
             IBQuery2.SQL.Add('insert into "gen$persona" VALUES (');
             IBQuery2.SQL.Add(':ID_IDENTIFICACION,');
             IBQuery2.SQL.Add(':ID_PERSONA,');
             IBQuery2.SQL.Add(':LUGAR_EXPEDICION,');
             IBQuery2.SQL.Add(':FECHA_EXPEDICION,');
             IBQuery2.SQL.Add(':NOMBRE,');
             IBQuery2.SQL.Add(':PRIMER_APELLIDO,');
             IBQuery2.SQL.Add(':SEGUNDO_APELLIDO,');
             IBQuery2.SQL.Add(':ID_TIPO_PERSONA,');
             IBQuery2.SQL.Add(':SEXO,');
             IBQuery2.SQL.Add(':FECHA_NACIMIENTO,');
             IBQuery2.SQL.Add(':LUGAR_NACIMIENTO,');
             IBQuery2.SQL.Add(':PROVINCIA_NACIMIENTO,');
             IBQuery2.SQL.Add(':DEPTO_NACIMIENTO,');
             IBQuery2.SQL.Add(':PAIS_NACIMIENTO,');
             IBQuery2.SQL.Add(':ID_TIPO_ESTADO_CIVIL,');
             IBQuery2.SQL.Add(':ID_CONYUGE,');
             IBQuery2.SQL.Add(':ID_IDENTIFICACION_CONYUGE,');
             IBQuery2.SQL.Add(':NOMBRE_CONYUGE,');
             IBQuery2.SQL.Add(':PRIMER_APELLIDO_CONYUGE,');
             IBQuery2.SQL.Add(':SEGUNDO_APELLIDO_CONYUGE,');
             IBQuery2.SQL.Add(':ID_APODERADO,');
             IBQuery2.SQL.Add(':ID_IDENTIFICACION_APODERADO,');
             IBQuery2.SQL.Add(':NOMBRE_APODERADO,');
             IBQuery2.SQL.Add(':PRIMER_APELLIDO_APODERADO,');
             IBQuery2.SQL.Add(':SEGUNDO_APELLIDO_APODERADO,');
             IBQuery2.SQL.Add(':PROFESION,');
             IBQuery2.SQL.Add(':ID_ESTADO,');
             IBQuery2.SQL.Add(':ID_TIPO_RELACION,');
             IBQuery2.SQL.Add(':ID_CIIU,');
             IBQuery2.SQL.Add(':EMPRESA_LABORA,');
             IBQuery2.SQL.Add(':FECHA_INGRESO_EMPRESA,');
             IBQuery2.SQL.Add(':CARGO_ACTUAL,');
             IBQuery2.SQL.Add(':DECLARACION,');
             IBQuery2.SQL.Add(':INGRESOS_A_PRINCIPAL,');
             IBQuery2.SQL.Add(':INGRESOS_OTROS,');
             IBQuery2.SQL.Add(':INGRESOS_CONYUGE,');
             IBQuery2.SQL.Add(':INGRESOS_CONYUGE_OTROS,');
             IBQuery2.SQL.Add(':DESC_INGR_OTROS,');
             IBQuery2.SQL.Add(':EGRESOS_ALQUILER,');
             IBQuery2.SQL.Add(':EGRESOS_SERVICIOS,');
             IBQuery2.SQL.Add(':EGRESOS_TRANSPORTE,');
             IBQuery2.SQL.Add(':EGRESOS_ALIMENTACION,');
             IBQuery2.SQL.Add(':EGRESOS_DEUDAS,');
             IBQuery2.SQL.Add(':EGRESOS_OTROS,');
             IBQuery2.SQL.Add(':DESC_EGRE_OTROS,');
             IBQuery2.SQL.Add(':EGRESOS_CONYUGE,');
             IBQuery2.SQL.Add(':OTROS_EGRESOS_CONYUGE,');
             IBQuery2.SQL.Add(':TOTAL_ACTIVOS,');
             IBQuery2.SQL.Add(':TOTAL_PASIVOS,');
             IBQuery2.SQL.Add(':EDUCACION,');
             IBQuery2.SQL.Add(':RETEFUENTE,');
             IBQuery2.SQL.Add(':ACTA,');
             IBQuery2.SQL.Add(':FECHA_REGISTRO,');
             IBQuery2.SQL.Add(':FOTO,');
             IBQuery2.SQL.Add(':FIRMA,');
             IBQuery2.SQL.Add(':ESCRITURA_CONSTITUCION,');
             IBQuery2.SQL.Add(':DURACION_SOCIEDAD,');
             IBQuery2.SQL.Add(':CAPITAL_SOCIAL,');
             IBQuery2.SQL.Add(':MATRICULA_MERCANTIL,');
             IBQuery2.SQL.Add(':FOTO_HUELLA,');
             IBQuery2.SQL.Add(':DATOS_HUELLA)');
             IBQuery2.ParamByName('ID_IDENTIFICACION').AsInteger := Fieldbyname('ID_IDENTIFICACION').AsInteger;
             IBQuery2.ParamByName('ID_PERSONA').AsString := FieldByName('ID_PERSONA').AsString;
             IBQuery2.ParamByName('LUGAR_EXPEDICION').AsString := FieldByName('LUGAR_EXPEDICION').AsString;
             IBQuery2.ParamByName('FECHA_EXPEDICION').AsDate := FieldByName('FECHA_EXPEDICION').AsDate;
             IBQuery2.ParamByName('NOMBRE').AsString := FieldByName('NOMBRE').AsString;
             IBQuery2.ParamByName('PRIMER_APELLIDO').AsString := FieldByName('PRIMER_APELLIDO').AsString;
             IBQuery2.ParamByName('SEGUNDO_APELLIDO').AsString := FieldByName('SEGUNDO_APELLIDO').AsString;
             IBQuery2.ParamByName('ID_TIPO_PERSONA').AsInteger := FieldByName('ID_TIPO_PERSONA').AsInteger;
             IBQuery2.ParamByName('SEXO').AsString := FieldByName('SEXO').AsString;
             IBQuery2.ParamByName('FECHA_NACIMIENTO').AsDate := FieldByName('FECHA_NACIMIENTO').AsDate;
             IBQuery2.ParamByName('LUGAR_NACIMIENTO').AsString := FieldByName('LUGAR_NACIMIENTO').AsString;
             IBQuery2.ParamByName('PROVINCIA_NACIMIENTO').AsString := FieldByName('PROVINCIA_NACIMIENTO').AsString;
             IBQuery2.ParamByName('DEPTO_NACIMIENTO').AsString := FieldByName('DEPTO_NACIMIENTO').AsString;
             IBQuery2.ParamByName('PAIS_NACIMIENTO').AsString := FieldByName('PAIS_NACIMIENTO').AsString;
             IBQuery2.ParamByName('ID_TIPO_ESTADO_CIVIL').AsInteger := FieldByName('ID_TIPO_ESTADO_CIVIL').AsInteger;
             IBQuery2.ParamByName('ID_CONYUGE').AsString := FieldByName('ID_CONYUGE').AsString;
             IBQuery2.ParamByName('ID_IDENTIFICACION_CONYUGE').AsInteger := FieldByName('ID_IDENTIFICACION_CONYUGE').AsInteger;
             IBQuery2.ParamByName('NOMBRE_CONYUGE').AsString := FieldByName('NOMBRE_CONYUGE').AsString;
             IBQuery2.ParamByName('PRIMER_APELLIDO_CONYUGE').AsString := FieldByName('PRIMER_APELLIDO_CONYUGE').AsString;
             IBQuery2.ParamByName('SEGUNDO_APELLIDO_CONYUGE').AsString := FieldByName('SEGUNDO_APELLIDO_CONYUGE').AsString;
             IBQuery2.ParamByName('ID_APODERADO').AsString := FieldByName('ID_APODERADO').AsString;
             IBQuery2.ParamByName('ID_IDENTIFICACION_APODERADO').AsInteger := FieldByName('ID_IDENTIFICACION_APODERADO').AsInteger;
             IBQuery2.ParamByName('NOMBRE_APODERADO').AsString := FieldByName('NOMBRE_APODERADO').AsString;
             IBQuery2.ParamByName('PRIMER_APELLIDO_APODERADO').AsString := FieldByName('PRIMER_APELLIDO_APODERADO').AsString;
             IBQuery2.ParamByName('SEGUNDO_APELLIDO_APODERADO').AsString := FieldByName('SEGUNDO_APELLIDO_APODERADO').AsString;
             IBQuery2.ParamByName('PROFESION').AsString := FieldByName('PROFESION').AsString;
             IBQuery2.ParamByName('ID_ESTADO').AsInteger := FieldByName('ID_ESTADO').AsInteger;
             IBQuery2.ParamByName('ID_TIPO_RELACION').AsInteger := fieldbyname('ID_TIPO_RELACION').AsInteger;
             IBQuery2.ParamByName('ID_CIIU').AsInteger := FieldByName('ID_CIIU').AsInteger;
             IBQuery2.ParamByName('EMPRESA_LABORA').AsString := FieldByName('EMPRESA_LABORA').AsString;
             IBQuery2.ParamByName('FECHA_INGRESO_EMPRESA').AsDate := FieldByName('FECHA_INGRESO_EMPRESA').AsDate;
             IBQuery2.ParamByName('CARGO_ACTUAL').AsString := FieldByName('CARGO_ACTUAL').AsString;
             IBQuery2.ParamByName('DECLARACION').Assign(FieldByName('DECLARACION'));
             IBQuery2.ParamByName('INGRESOS_A_PRINCIPAL').AsCurrency := FieldByName('INGRESOS_A_PRINCIPAL').AsCurrency;
             IBQuery2.ParamByName('INGRESOS_OTROS').AsCurrency := FieldByName('INGRESOS_OTROS').AsCurrency;
             IBQuery2.ParamByName('INGRESOS_CONYUGE').AsCurrency := FIELDBYNAME('INGRESOS_CONYUGE').AsCurrency;
             IBQuery2.ParamByName('INGRESOS_CONYUGE_OTROS').AsCurrency := FieldByName('INGRESOS_CONYUGE_OTROS').AsCurrency;
             IBQuery2.ParamByName('DESC_INGR_OTROS').Assign(FieldByName('DESC_INGR_OTROS'));
             IBQuery2.ParamByName('EGRESOS_ALQUILER').AsCurrency := FIELDBYNAME('EGRESOS_ALQUILER').AsCurrency;
             IBQuery2.ParamByName('EGRESOS_SERVICIOS').AsCurrency := FieldByName('EGRESOS_SERVICIOS').AsCurrency;
             IBQuery2.ParamByName('EGRESOS_TRANSPORTE').AsCurrency := FieldByName('EGRESOS_TRANSPORTE').AsCurrency;
             IBQuery2.ParamByName('EGRESOS_ALIMENTACION').AsCurrency := FieldByName('EGRESOS_TRANSPORTE').AsCurrency;
             IBQuery2.ParamByName('EGRESOS_DEUDAS').AsCurrency := FieldByName('EGRESOS_DEUDAS').AsCurrency;
             IBQuery2.ParamByName('EGRESOS_OTROS').AsCurrency := FieldByName('EGRESOS_OTROS').AsCurrency;
             IBQuery2.ParamByName('DESC_EGRE_OTROS').Assign(FieldByName('DESC_EGRE_OTROS'));
             IBQuery2.ParamByName('EGRESOS_CONYUGE').AsCurrency := FIELDBYNAME('EGRESOS_CONYUGE').AsCurrency;
             IBQuery2.ParamByName('OTROS_EGRESOS_CONYUGE').AsCurrency := FieldByName('OTROS_EGRESOS_CONYUGE').AsCurrency;
             IBQuery2.ParamByName('TOTAL_ACTIVOS').AsCurrency := FieldByName('TOTAL_ACTIVOS').AsCurrency;
             IBQuery2.ParamByName('TOTAL_PASIVOS').AsCurrency := FieldByName('TOTAL_PASIVOS').AsCurrency;
             IBQuery2.ParamByName('EDUCACION').AsInteger := FieldByName('EDUCACION').AsInteger;
             IBQuery2.ParamByName('RETEFUENTE').AsInteger := FieldByName('RETEFUENTE').AsInteger;
             IBQuery2.ParamByName('ACTA').AsString := FieldByName('ACTA').AsString;
             IBQuery2.ParamByName('FECHA_REGISTRO').AsDate := FieldByName('FECHA_REGISTRO').AsDate;
             IBQuery2.ParamByName('FOTO').Assign(FieldByName('FOTO'));
             IBQuery2.ParamByName('FIRMA').Assign(FieldByName('FIRMA'));
             IBQuery2.ParamByName('ESCRITURA_CONSTITUCION').AsString := FieldByName('ESCRITURA_CONSTITUCION').AsString;
             IBQuery2.ParamByName('DURACION_SOCIEDAD').AsInteger := FieldByName('DURACION_SOCIEDAD').AsInteger;
             IBQuery2.ParamByName('CAPITAL_SOCIAL').AsCurrency := FieldByName('CAPITAL_SOCIAL').AsCurrency;
             IBQuery2.ParamByName('MATRICULA_MERCANTIL').AsString := FieldByName('MATRICULA_MERCANTIL').AsString;
             IBQuery2.ParamByName('FOTO_HUELLA').Assign(FieldByName('FOTO_HUELLA'));
             IBQuery2.ParamByName('DATOS_HUELLA').Assign(FieldByName('DATOS_HUELLA'));
             try
               IBQuery2.ExecQuery;
               IBQuery2.Transaction.Commit;
             except
               raise;
             end;
             Next;
          end;
          Transaction.Commit;
        end;
        ShowMessage('Proceso Finalizado');
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
        pFIBAnterior.Connected := True;
        pFIBNueva.Connected := True;
end;

end.
