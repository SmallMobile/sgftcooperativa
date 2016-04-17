unit UnitActualizaFecha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, DB, IBCustomDataSet, IBQuery,
  ComCtrls, Buttons,JclDateTime;

type
  TFrmActualizafecha = class(TForm)
    Panel1: TPanel;
    DSconvenio: TDataSource;
    IBconvenio: TIBQuery;
    Label3: TLabel;
    Label1: TLabel;
    DBconvenio: TDBLookupComboBox;
    Label2: TLabel;
    Label4: TLabel;
    DTfecha: TDateTimePicker;
    DTvence: TDateTimePicker;
    BTActualiza: TBitBtn;
    BTCerrar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BTCerrarClick(Sender: TObject);
    procedure BTActualizaClick(Sender: TObject);
  private
    { Private declarations }
  public
  published
    procedure actualizar;
    { Public declarations }
  end;

var
  FrmActualizafecha: TFrmActualizafecha;

implementation

uses UnitQuerys, UnitPantallaProgreso,UnitGlobal;

{$R *.dfm}

procedure TFrmActualizafecha.FormCreate(Sender: TObject);
begin
        IBconvenio.Open;
        IBconvenio.Last;
        DBconvenio.KeyValue := 1;
end;

procedure TFrmActualizafecha.BTCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmActualizafecha.actualizar;
begin
        DataQuerys := TDataQuerys.Create(self);
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$afiliacion"."id_afiliacion"');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."fecha" BETWEEN :fecha1 AND :fecha2)');
          SQL.Add('and ("fun$afiliacion"."id_convenio" = :convenio)');
          ParamByName('fecha1').AsDate := StrToDate(FormatDateTime('yyyy/mm/01',DTfecha.Date));
          ParamByName('fecha2').AsDate := StrToDate(FormatDateTime('yyyy/mm/'+IntToStr(MonthOfDate(DTfecha.Date)),DTfecha.Date));
          ParamByName('convenio').AsInteger := DBconvenio.KeyValue;
          Open;
          Last;
          First;
          if RecordCount = 0 then
             Exit;
          frmProgresos := TfrmProgresos.Create(self);
          frmProgresos.Titulo := 'Actualizando Fechas de Vencimiento';
          frmProgresos.Max := RecordCount;
          frmProgresos.Min := 0;
          frmProgresos.Ejecutar;
          while not Eof do
          begin
            frmProgresos.Position := RecNo;
            frmProgresos.InfoLabel := 'Actualizacion No : '+IntToStr(RecNo);
            Application.ProcessMessages;
            with DataQuerys.IBselecion do
            begin
              Close;
              SQL.Clear;
              SQL.Add('update "fun$afiliacion" set');
              SQL.Add('"fun$afiliacion"."fecha_vencimiento" = :fecha');
              SQL.Add(',"fun$afiliacion"."es_fechaparcial" = 1');
              SQL.Add('where "fun$afiliacion"."id_afiliacion" = :afiliacion');
              ParamByName('afiliacion').AsInteger := DataQuerys.IBdatos.FieldByName('id_afiliacion').AsInteger;
              ParamByName('fecha').AsDate := DTvence.Date;
              Open;
              Close;
            end;
            Next;
          end;
          frmProgresos.Cerrar;
          MessageDlg('Actualizacion Realizada Con Exito!',mtInformation,[mbok],0);
          verificatransaccion(DataQuerys.IBselecion);
        end;

end;

procedure TFrmActualizafecha.BTActualizaClick(Sender: TObject);
begin
        if MessageDlg('Esta Seguro de Realizar la Actualización?',mtinformation,[mbyes,mbno],0) = mryes then
           actualizar;
end;

end.
