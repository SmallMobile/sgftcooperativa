unit Frmexistencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, Grids, DBGrids, StdCtrls, Buttons;

type
  Texistencia = class(TForm)
    DataSource1: TDataSource;
    IBDataSet1: TIBDataSet;
    DBGrid1: TDBGrid;
    IBDataSet1cod_articulo: TIntegerField;
    IBDataSet1nombre: TIBStringField;
    IBDataSet1cod_clasificacion: TIntegerField;
    IBDataSet1existencia: TIntegerField;
    IBDataSet1precio_unitario: TIBBCDField;
    IBDataSet1cod_barras: TIntegerField;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    a: TButton;
    b: TButton;
    c: TButton;
    d: TButton;
    e: TButton;
    f: TButton;
    g: TButton;
    h: TButton;
    i: TButton;
    j: TButton;
    k: TButton;
    l: TButton;
    m: TButton;
    n: TButton;
    o: TButton;
    p: TButton;
    q: TButton;
    r: TButton;
    s: TButton;
    t: TButton;
    u: TButton;
    v: TButton;
    w: TButton;
    x: TButton;
    y: TButton;
    Button1: TButton;
    IBDataSet2: TIBDataSet;
    procedure aClick(Sender: TObject);
    procedure bClick(Sender: TObject);
    procedure cClick(Sender: TObject);
    procedure dClick(Sender: TObject);
    procedure eClick(Sender: TObject);
    procedure fClick(Sender: TObject);
    procedure gClick(Sender: TObject);
    procedure hClick(Sender: TObject);
    procedure iClick(Sender: TObject);
    procedure jClick(Sender: TObject);
    procedure kClick(Sender: TObject);
    procedure lClick(Sender: TObject);
    procedure mClick(Sender: TObject);
    procedure nClick(Sender: TObject);
    procedure oClick(Sender: TObject);
    procedure pClick(Sender: TObject);
    procedure qClick(Sender: TObject);
    procedure rClick(Sender: TObject);
    procedure sClick(Sender: TObject);
    procedure tClick(Sender: TObject);
    procedure vClick(Sender: TObject);
    procedure wClick(Sender: TObject);
    procedure xClick(Sender: TObject);
    procedure yClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure uClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  existencia: Texistencia;

implementation
uses frmdatamodulo;

{$R *.dfm}

procedure Texistencia.aClick(Sender: TObject);
begin
        ibdataset1.Close;
        ibdataset1.ParamByName('letra').AsVariant:='A';
        ibdataset1.Open;
end;

procedure Texistencia.bClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='B';
        ibdataset1.Open;

end;

procedure Texistencia.cClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='C';
        ibdataset1.Open;
end;

procedure Texistencia.dClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='D';
        ibdataset1.Open;

end;

procedure Texistencia.eClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='E';
        ibdataset1.Open;

end;

procedure Texistencia.fClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='F';
        ibdataset1.Open;

end;

procedure Texistencia.gClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='G';
        ibdataset1.Open;

end;

procedure Texistencia.hClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='H';
        ibdataset1.Open;

end;

procedure Texistencia.iClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='I';
        ibdataset1.Open;

end;

procedure Texistencia.jClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='J';
        ibdataset1.Open;

end;

procedure Texistencia.kClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='K';
        ibdataset1.Open;

end;

procedure Texistencia.lClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='L';
        ibdataset1.Open;

end;

procedure Texistencia.mClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='M';
        ibdataset1.Open;

end;

procedure Texistencia.nClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='N';
        ibdataset1.Open;

end;

procedure Texistencia.oClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='O';
        ibdataset1.Open;

end;

procedure Texistencia.pClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='P';
        ibdataset1.Open;

end;

procedure Texistencia.qClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='Q';
        ibdataset1.Open;

end;

procedure Texistencia.rClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='R';
        ibdataset1.Open;

end;

procedure Texistencia.sClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='S';
        ibdataset1.Open;

end;

procedure Texistencia.tClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='T';
        ibdataset1.Open;

end;

procedure Texistencia.vClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='V';
        ibdataset1.Open;

end;

procedure Texistencia.wClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='W';
        ibdataset1.Open;

end;

procedure Texistencia.xClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='X';
        ibdataset1.Open;

end;

procedure Texistencia.yClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='Y';
        ibdataset1.Open;

end;

procedure Texistencia.Button1Click(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='Z';
        ibdataset1.Open;

end;

procedure Texistencia.uClick(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='Y';
        ibdataset1.Open;
end;

procedure Texistencia.BitBtn2Click(Sender: TObject);
begin
        close;
end;

procedure Texistencia.BitBtn1Click(Sender: TObject);
begin
        ibdataset1.Close;
        Ibdataset1.ParamByName('letra').AsVariant:='%';
        ibdataset1.Open;
end;

procedure Texistencia.DBGrid1CellClick(Column: TColumn);
var     detalle,nombre : string;
begin
        if IBDataSet1cod_articulo.Text <> '' then
        begin
          ibdataset2.Close;
          ibdataset2.ParamByName('cod').AsInteger:=strtoint(IBDataSet1cod_articulo.Text);
          ibdataset2.Open;
          detalle := IBDataSet2.FieldByName('detalle').AsString;
          nombre := IBDataSet2.FieldByName('nombre').AsString;
          IBDataSet2.Close;
            if detalle = '' then
              ShowMessage('No contiene Detalle')
            else
              ShowMessage('Nombre: '+ nombre +' Detalle: '+ detalle);
         end;
end;

end.
