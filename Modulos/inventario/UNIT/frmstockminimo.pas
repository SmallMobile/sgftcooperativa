unit frmstockminimo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  Tstockminimo = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    codigo: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    minimo: TEdit;
    BitBtn1: TBitBtn;
    Button1: TButton;
    procedure codigoExit(Sender: TObject);
    procedure codigoKeyPress(Sender: TObject; var Key: Char);
    procedure minimoKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  stockminimo: Tstockminimo;

implementation
uses frmdatamodulo;

{$R *.dfm}

procedure Tstockminimo.codigoExit(Sender: TObject);
begin
        if codigo.text <> '' then
        begin
        with datageneral.IBsel do
        begin
        close;
        sql.clear;
        sql.Add('select "inv$articulo"."nombre" from "inv$articulo" where "inv$articulo"."cod_articulo"=:"codigo"');
        parambyname('codigo').AsInteger:=strtoint(codigo.Text);
        open;
        label3.Caption:=fieldbyname('nombre').AsString;
        close;
        end;
        end;


end;

procedure Tstockminimo.codigoKeyPress(Sender: TObject; var Key: Char);
begin
            if key = #13 then
            minimo.SetFocus;
end;

procedure Tstockminimo.minimoKeyPress(Sender: TObject; var Key: Char);
begin
        if key =#13 then
        bitbtn1.SetFocus;
end;

procedure Tstockminimo.BitBtn1Click(Sender: TObject);
begin
        if codigo.Text  <> '' then
        begin
        with datageneral.IBsel1 do
        begin
        close;
        sql.Clear;
        sql.Add('update "inv$articulo" set "inv$articulo"."stock"=:"minimo"');
        sql.Add('where "inv$articulo"."cod_articulo"=:"codigo"');
        parambyname('minimo').AsInteger:=strtoint(minimo.Text);
        parambyname('codigo').AsInteger:=strtoint(codigo.Text);
        open;
        close;
        datageneral.IBTransaction1.CommitRetaining;
        end;
        label3.Caption:='';
        codigo.Text:='';
        minimo.Text:='';
        codigo.SetFocus;
        end
        else
        codigo.SetFocus;

end;

procedure Tstockminimo.Button1Click(Sender: TObject);
begin
        with DataGeneral.IBsel1 do
       begin
       Close;
       SQL.Clear;
       SQL.Add('select "inv$entrada"."fecha_entrada" from "inv$entrada"');
       SQL.Add('where "inv$entrada"."no_entrada"=:"w"');
       ParamByName('w').AsInteger:=1;
       Open;
       Close;
       minimo.Text:=FieldByName('fecha_entrada').AsString;
       end;
       end;

end.
