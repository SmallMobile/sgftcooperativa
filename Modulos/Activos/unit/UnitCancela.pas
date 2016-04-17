unit UnitCancela;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBCustomDataSet, IBQuery, Buttons;

type
  TFrmCancela = class(TForm)
    Label1: TLabel;
    placa: TEdit;
    Ibbuscapol: TIBQuery;
    n1: TCheckBox;
    n2: TCheckBox;
    n3: TCheckBox;
    n4: TCheckBox;
    Baceptar: TBitBtn;
    Bcancelar: TBitBtn;
    Label2: TLabel;
    des: TEdit;
    Ibcancela: TIBQuery;
    BitBtn1: TBitBtn;
    procedure placaExit(Sender: TObject);
    procedure BcancelarClick(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
    procedure BaceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
  cod_activo:Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCancela: TFrmCancela;

implementation
uses unitdatamodulo, Unitentrega;

{$R *.dfm}

procedure TFrmCancela.placaExit(Sender: TObject);
var alto:Integer;
begin
        alto := 94;
        with Ibbuscapol do
        begin
          Close;
          ParamByName('placa').AsString:=placa.Text;
          Open;
          cod_activo := FieldByName('cod_activo').AsInteger;
          while not Ibbuscapol.Eof do
          begin
           if FieldByName('tipo').AsInteger=1 then
           begin
            n1.Visible := True;
            n1.Top := alto;
           end
           else if FieldByName('tipo').AsInteger=2 then
           begin
             n2.Visible := True;
             n2.Top := alto;
           end
           else if FieldByName('tipo').AsInteger=3 then
           begin
             n3.Visible := True;
             n3.Top := alto;
           end
           else if FieldByName('tipo').AsInteger=4 then
           begin
             n4.Visible := True;
             n4.Top := alto;
          end;
        Ibbuscapol.Next;
        alto := alto+28;
    end;
    des.Text := FieldByName('descripcion1').AsString;
    Ibbuscapol.Close;
    end;
end;

procedure TFrmCancela.BcancelarClick(Sender: TObject);
begin
        n1.Visible := false;
        n2.Visible := False;
        n3.Visible := False;
        n4.Visible := False;
        des.Text := '';
        placa.Text := '';
        placa.SetFocus;
end;

procedure TFrmCancela.placaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
        placaExit(self)
end;

procedure TFrmCancela.BaceptarClick(Sender: TObject);
begin
        if n1.Checked = True then
        begin
          with Ibcancela do
          begin
            Close;
            ParamByName('cod_activo').AsInteger := cod_activo;
            ParamByName('cod_poliza').AsInteger := 1;
            Open;
            Close;
          end;
        end;
        if n2.Checked = True then
        begin
          with Ibcancela do
          begin
            Close;
            ParamByName('cod_activo').AsInteger := cod_activo;
            ParamByName('cod_poliza').AsInteger := 2;
            Open;
            Close;
           end;
        end;
        if n3.Checked = True then
        begin
          with Ibcancela do
          begin
          Close;
          ParamByName('cod_activo').AsInteger := cod_activo;
          ParamByName('cod_poliza').AsInteger := 3;
          Open;
          Close;
        end;
        end;
        if n4.Checked = True then
        begin
          with Ibcancela do
          begin
            Close;
            ParamByName('cod_activo').AsInteger := cod_activo;
            ParamByName('cod_poliza').AsInteger := 4;
            Open;
            Close;
          end;
        end;
        DataGeneral.IBTransaction1.CommitRetaining;
        BcancelarClick(Self);
end;

procedure TFrmCancela.FormCreate(Sender: TObject);
begin
        FrmEntrega := TFrmEntrega.Create(self);
end;

procedure TFrmCancela.BitBtn1Click(Sender: TObject);
begin
        Close;
end;
end.
