unit FrmRepEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Trepentrada = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    no_entrada: TEdit;
    ejesalida: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure no_entradaKeyPress(Sender: TObject; var Key: Char);
    procedure ejesalidaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  repentrada: Trepentrada;

implementation
uses frmreportesgenerales, FrmPrincipal;

{$R *.dfm}

procedure Trepentrada.BitBtn1Click(Sender: TObject);
var lugar: string;
begin
         if no_entrada.Text <> '' then
         begin
         reportes:=treportes.Create(self);
         lugar:=frmain.wpath+'reportes\repentradas.frf';
         reportes.frDBDataSet1.DataSet:=reportes.entrada;
         reportes.entrada.ParamByName('entrada').AsInteger:=strtoint(no_entrada.Text);
         reportes.entrada.Open;
         if reportes.entrada.RecordCount = 0 then
         begin
         showmessage('No Existen Registros disponibles');
         no_entrada.SetFocus;
         end
         else
         reportes.imprimir_reporte(lugar);
         no_entrada.SetFocus;
         end
         else
         begin
         Showmessage('No Existen Registros Disponibles');
         no_entrada.SetFocus;
         end;
end;

procedure Trepentrada.no_entradaKeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13 then
        begin
        if bitbtn1.Visible=true then
        bitbtn1.SetFocus
        else
        ejesalida.SetFocus;
        end;
end;

procedure Trepentrada.ejesalidaClick(Sender: TObject);
begin
         if no_entrada.Text <> '' then
         begin
         reportes:=treportes.Create(self);
         lugar:=frmain.wpath+'reportes\Regsalida.frf';
         reportes.frDBDataSet1.DataSet:=reportes.regsalida;
         reportes.regsalida.ParamByName('codigo').AsInteger:=strtoint(no_entrada.Text);
         reportes.regsalida.Open;
         if reportes.regsalida.RecordCount = 0 then
         begin
         showmessage('No Existen Registros disponibles');
         no_entrada.SetFocus;
         end
         else
         reportes.imprimir_reporte(lugar);
         no_entrada.SetFocus;
         end
         else
         begin
         Showmessage('No Existen Registros Disponibles');
         no_entrada.SetFocus;
         end;

end;

end.
