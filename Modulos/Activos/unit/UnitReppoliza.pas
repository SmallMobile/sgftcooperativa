unit UnitReppoliza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Buttons;

type
  TFrmReportepol = class(TForm)
    Label1: TLabel;
    poliza: TDBLookupComboBox;
    ejepol: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure polizaExit(Sender: TObject);
    procedure ejepolClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  tipo_pol:Integer;
  lugar:string;
    { Private declarations }
  public
  reporte: Boolean;
    { Public declarations }
  end;

var
  FrmReportepol: TFrmReportepol;

implementation
uses unitgeneral, UnitActivorep, UnitReporte, UnitPrincipal, UnitDatamodulo;

{$R *.dfm}

procedure TFrmReportepol.FormCreate(Sender: TObject);
begin
        frmgeneral.tipo_polizas.Active := True;
        frmgeneral.tipo_polizas.Last;
        reporte := False;
end;

procedure TFrmReportepol.polizaExit(Sender: TObject);
begin
        if poliza.KeyValue = Null then
          poliza.KeyValue := 1;
          tipo_pol:=poliza.KeyValue;
end;

procedure TFrmReportepol.ejepolClick(Sender: TObject);
begin
        reporte := True;
        frmActivos := tFrmActivos.Create(self);
        FrmReporte := TFrmReporte.Create(self);
        FrmReporte.polizas.Transaction.Commit;
        lugar := frmain.wpath+'reportes\polizas.frf';
        FrmActivos.frDBDataSet1.DataSet := FrmReporte.polizas;
        FrmReporte.polizas.ParamByName('cod_poliza').AsInteger := tipo_pol;
        FrmReporte.polizas.Open;
        if FrmReporte.polizas.RecordCount = 0 then
          showmessage('No Existen Registros disponibles')
        else
          FrmActivos.imprimir_reporte(lugar);
          FrmReportepol.Close;

end;

procedure TFrmReportepol.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      frmgeneral.tipo_polizas.Active := False;
end;
end.
