unit UnitLibroCajaDiario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, pr_Common, pr_TxClasses, IBCustomDataSet, IBQuery,
  StdCtrls, Buttons, Mask, ExtCtrls;

type
  TfrmLibroRCajaDiario = class(TForm)
    Panel1: TPanel;
    Label5: TLabel;
    Label4: TLabel;
    CBMeses: TComboBox;
    EdAno: TMaskEdit;
    Panel2: TPanel;
    CmdAceptar: TBitBtn;
    CmdCerrar: TBitBtn;
    IBQTemp: TIBQuery;
    IBQTemp1: TIBQuery;
    Reporte: TprTxReport;
    procedure CmdAceptarClick(Sender: TObject);
    procedure CmdCerrarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLibroRCajaDiario: TfrmLibroRCajaDiario;

implementation

{$R *.dfm}

uses UnitdmGeneral,UnitGlobales;

procedure TfrmLibroRCajaDiario.CmdAceptarClick(Sender: TObject);
begin
        with IBQTemp do begin
          Close;
          ParamByName('MES').AsInteger := CBMeses.ItemIndex + 1;
        end;

        with IBQTemp1 do begin
          Close;
          ParamByName('MES').AsInteger := CBMeses.ItemIndex + 1;
        end;


        Reporte.Variables.ByName['MES'].AsString := CBMeses.Text;
        Reporte.Variables.ByName['ANOCORTE'].AsString := EdAno.Text;
        if Reporte.PrepareReport then
           Reporte.PreviewPreparedReport(True);

end;

procedure TfrmLibroRCajaDiario.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmLibroRCajaDiario.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
        entertabs(Key,Self);
end;

procedure TfrmLibroRCajaDiario.FormCreate(Sender: TObject);
begin

      with IBQTemp do begin
        if Transaction.InTransaction then
           Transaction.Rollback;
        Transaction.StartTransaction;
      end;
      
end;

end.
