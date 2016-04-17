unit Unitcambioplaca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, Buttons;

type
  Tfrmcambioplaca = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    placa: TMaskEdit;
    MaskEdit1: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    descripcion: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure MaskEdit1Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: Char);
  private
  codigo :Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcambioplaca: Tfrmcambioplaca;

implementation

uses UnitDatamodulo;

{$R *.dfm}

procedure Tfrmcambioplaca.MaskEdit1Exit(Sender: TObject);
begin
        with DataGeneral.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$activo"."descripcion","act$activo"."cod_activo"');
          SQL.Add('from "act$activo"');
          SQL.Add('where "act$activo"."placa" = :placa');
          ParamByName('placa').AsString := MaskEdit1.Text;
          Open;
          descripcion.Text := FieldByName('descripcion').AsString;
          codigo:= FieldByName('cod_activo').AsInteger;
          Close;
       end;
end;

procedure Tfrmcambioplaca.BitBtn1Click(Sender: TObject);
begin
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update "act$activo"');
          SQL.Add('set "act$activo"."placa" = :placa,');
          SQL.Add('"act$activo"."esactivo" = 0');
          SQL.Add('where "act$activo"."cod_activo" = :codigo');
          ParamByName('placa').AsString := placa.Text;
          ParamByName('codigo').AsInteger := codigo;
          Open;
          Close;
        end;
        MaskEdit1.Text := '';
        placa.Text := '';
        descripcion.Text := '';
        MaskEdit1.SetFocus;
end;

procedure Tfrmcambioplaca.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure Tfrmcambioplaca.MaskEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          placa.SetFocus;
end;

end.
