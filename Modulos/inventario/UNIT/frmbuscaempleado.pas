unit frmbuscaempleado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IBDatabase, DB, IBCustomDataSet, StdCtrls, Grids, DBGrids,
  IBQuery, Buttons, ComCtrls;

type
  TBuscaempleado = class(TForm)
    Ibbusca: TIBDataSet;
    DataSource1: TDataSource;
    Ibbuscacantidad: TSmallintField;
    Ibbuscacod_articulo: TIntegerField;
    Ibbuscafecha_entrega: TDateField;
    Ibbuscanit_empleado: TIntegerField;
    Ibbuscano_salida: TIntegerField;
    Ibbuscanombre: TIBStringField;
    Ibdato: TIBQuery;
    GroupBox1: TGroupBox;
    seccion: TLabel;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    listanit: TComboBox;
    Label4: TLabel;
    lista: TComboBox;
    IBDataSet1: TIBDataSet;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    fecha_ini: TDateTimePicker;
    Label6: TLabel;
    fecha_fin: TDateTimePicker;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure listaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Buscaempleado: TBuscaempleado;
  nit_emp: Integer;

implementation
uses frmdatamodulo, Frmreportesgenerales;


{$R *.dfm}

procedure TBuscaempleado.BitBtn1Click(Sender: TObject);
begin
        seccion.Caption:='';
        lista.ItemIndex:=-1;
        lista.SetFocus;
        Ibbusca.Close;
        BitBtn3.Enabled:=True;
end;

procedure TBuscaempleado.BitBtn2Click(Sender: TObject);
begin
        close;
end;

procedure TBuscaempleado.listaExit(Sender: TObject);
var     a:integer;
        b:string;
begin
        a:=lista.ItemIndex;
        listanit.ItemIndex:=a;
        b:=listanit.Text;
        ibdataset1.parambyname('nombre').AsString:=b;
        ibdataset1.Open;
        nit_emp:=ibdataset1.fieldbyname('nit').AsInteger;
        ibdataset1.Close;

end;
procedure TBuscaempleado.FormCreate(Sender: TObject);
var nombre,nombre1: string;
begin
       // reportes := Treportes.Create(self);
        fecha_ini.DateTime:=date;
        fecha_fin.DateTime:=date;
        with datageneral.IBsel do
        begin
          close;
          sql.Clear;
          sql.Add('select "inv$empleado"."nombre","inv$empleado"."apellido"  from "inv$empleado"');
          open;
            while not datageneral.IBsel.Eof do
            begin
              nombre:=fieldbyname('nombre').AsString + ' ' + fieldbyname('apellido').AsString;
              nombre1:=fieldbyname('nombre').AsString + fieldbyname('apellido').AsString;
              lista.Items.Add(nombre);
              listanit.Items.Add(nombre1);
              datageneral.IBsel.Next;
            end;
        close;
        end;
end;

procedure TBuscaempleado.BitBtn3Click(Sender: TObject);
begin
        Ibbusca.ParamByName('nit').AsInteger:=nit_emp;
        Ibbusca.ParamByName('fecha').AsString:=DateToStr(fecha_ini.DateTime);
        Ibbusca.ParamByName('fecha1').AsString:=DateToStr(fecha_fin.DateTime);
        ibbusca.Open;
          with ibdato do
          begin
            Sql.Clear;
            Sql.Add('select "inv$empleado"."nombre" as nombree,"inv$dependencia"."nombre" as nombred');
            Sql.Add('from "inv$empleado","inv$dependencia"');
            Sql.Add('where "inv$dependencia"."cod_dependencia"="inv$empleado"."cod_dependencia" and');
            Sql.Add('"inv$empleado"."nit"=:"nit"');
            ParamByname('nit').AsInteger:=nit_emp;
            open;
            seccion.Caption:=FieldByname('nombred').AsString;
            Close;
            BitBtn3.Enabled:=False;

          end;
end;

end.


