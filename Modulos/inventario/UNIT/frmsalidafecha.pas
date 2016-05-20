unit frmsalidafecha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, StdCtrls, Buttons, IBDatabase, Grids,
  DBGrids, ExtCtrls, ComCtrls;

type
  Tsalidaporfecha = class(TForm)
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    Panel1: TPanel;
    DataSource1: TDataSource;
    ibmante: TIBDataSet;
    fecha_entrada: TDateTimePicker;
    fecha1: TDateTimePicker;
    ibmanteno_salida: TIntegerField;
    ibmantefecha_entrega: TDateField;
    ibmanteDEP: TIBStringField;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    IBDataSet1: TIBDataSet;
    IBDataSet1no_salida: TIntegerField;
    IBDataSet1precio_salida: TIBBCDField;
    IBDataSet1nombre: TIBStringField;
    DBGrid2: TDBGrid;
    Label3: TLabel;
    DataSource2: TDataSource;
    IBDataSet1cod_articulo: TIntegerField;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    IBDataSet1cantidad: TSmallintField;
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
  salidaporfecha: Tsalidaporfecha;

implementation
uses frmdatamodulo;

{$R *.dfm}

procedure Tsalidaporfecha.BitBtn2Click(Sender: TObject);
begin
        ibmante.ParamByName('fecha').AsString:=datetostr(fecha_entrada.Date);
        ibmante.ParamByName('fecha1').AsString:=datetostr(fecha1.Date);
        ibmante.Open;
        if ibmante.RecordCount= 0 then
        begin
        ibmante.Close;
        Showmessage('No Existen Elementos Disponibles');
        end;
end;

procedure Tsalidaporfecha.FormCreate(Sender: TObject);
begin
        Fecha_entrada.DateTime:=date;
        fecha1.DateTime:=date;
end;

procedure Tsalidaporfecha.DBGrid1CellClick(Column: TColumn);
begin
        if ibmanteno_salida.Text <> '' then
        begin
        ibdataset1.Close;
        ibdataset1.ParamByName('codigo').AsInteger:=strtoint(ibmanteno_salida.Text);
        ibdataset1.Open;
        end;
end;

procedure Tsalidaporfecha.BitBtn1Click(Sender: TObject);
begin
        ibmante.Close;
        ibdataset1.Close;
end;

procedure Tsalidaporfecha.BitBtn3Click(Sender: TObject);
begin
        close;
end;

end.
