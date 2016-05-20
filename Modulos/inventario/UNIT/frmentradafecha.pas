unit frmentradafecha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ComCtrls, ExtCtrls, DB,
  IBCustomDataSet, IBQuery;

type
  Tconentrada = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    fecha_entrada: TDateTimePicker;
    fecha1: TDateTimePicker;
    Panel2: TPanel;
    Label4: TLabel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    Label3: TLabel;
    DBGrid2: TDBGrid;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    DataSource1: TDataSource;
    ibentrdatos: TIBDataSet;
    ibentrdatosno_entrada: TIntegerField;
    ibentrdatosfecha_entrada: TDateField;
    ibentrdatosno_factura: TIBStringField;
    ibentrdatosNOMBREP: TIBStringField;
    DataSource2: TDataSource;
    IBDataSet1: TIBQuery;
    IBDataSet1no_entrada: TIntegerField;
    IBDataSet1cantidad: TIntegerField;
    IBDataSet1precio_unidad: TIBBCDField;
    IBDataSet1nombre: TIBStringField;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  conentrada: Tconentrada;

implementation
uses frmdatamodulo;

{$R *.dfm}

procedure Tconentrada.BitBtn2Click(Sender: TObject);
begin
        ibentrdatos.ParamByName('fecha').AsString:=datetostr(fecha_entrada.Date);
        ibentrdatos.ParamByName('fecha1').AsString:=datetostr(fecha1.Date);
        ibentrdatos.Open;
        if ibentrdatos.RecordCount = 0 then
        begin
          ibentrdatos.Close;
          Showmessage('No Existen Elementos Disponibles');
        end;
end;

procedure Tconentrada.FormCreate(Sender: TObject);
begin
        Fecha_entrada.DateTime:=date;
        fecha1.DateTime:=date;
end;

procedure Tconentrada.DBGrid1CellClick(Column: TColumn);
begin

{        if ibentrdatosno_entrada.Text <> '' then
        begin
          ibdataset1.Close;
          ibdataset1.ParamByName('codigo').AsInteger:=strtoint(ibentrdatosno_entrada.Text);
          ibdataset1.Open;
          while not IBDataSet1.Eof do
          begin
            ShowMessage(IBDataSet1.FieldByName('cantidad').AsString);
            IBDataSet1.Next;
          end;
        end;}
        with ibdataset1 do
        begin
          Close;
          ParamByName('codigo').AsInteger:=strtoint(ibentrdatosno_entrada.Text);
          Open;
        end;


end;

procedure Tconentrada.BitBtn1Click(Sender: TObject);
begin
        ibentrdatos.Close;
        ibdataset1.Close;
end;

procedure Tconentrada.BitBtn3Click(Sender: TObject);
begin
        close;
end;

end.
