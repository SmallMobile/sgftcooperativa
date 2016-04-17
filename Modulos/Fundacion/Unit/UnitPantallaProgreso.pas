unit UnitPantallaProgreso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, JvSpecialProgress, Buttons,
  JvWaitingGradient, JvGradientCaption, JvWaitingProgress;

type
  TfrmProgresos = class(TForm)
    Info: TLabel;
    Barra: TJvSpecialProgress;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cancelarClick(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
  private
    { Private declarations }
    FMaximo:Integer;
    procedure setposicion(Value:Integer);
    procedure setminimo(Value:Integer);
    procedure setmaximo(Value:Integer);
    procedure setinfo(Value:string);
    procedure setTitulo(Value:string);
  public
    { Public declarations }
    property Position:Integer Write setposicion;
    property Min:Integer Write setMinimo;
    property Max:Integer Write setMaximo;
    property InfoLabel:string Write setInfo;
    property Titulo:string Write SetTitulo;
    procedure Ejecutar;
    procedure Cerrar;
  end;

var
  frmProgresos: TfrmProgresos;
  MinValor:Integer;
  MaxValor:Integer;
  Porcentaje:Integer;

implementation

uses UnitPrincipal;

{$R *.dfm}

procedure TfrmProgresos.setminimo(Value:Integer);
begin
        Barra.Minimum := Value;
end;

procedure TfrmProgresos.setmaximo(Value:Integer);
begin
        Fmaximo := Value;
        Barra.Maximum := Value;

end;

procedure TfrmProgresos.setposicion(Value:Integer);
begin
        //try
        Porcentaje := Value;
        Barra.Position := Porcentaje;
        Porcentaje := (Porcentaje * 100 ) div FMaximo;
        Barra.Caption := FormatFloat('#0%',Porcentaje);
        FrMain.FUltimaActividad := Now;
        FrMain.apagar := False;
        //except
end;

procedure TfrmProgresos.setinfo(Value:string);
begin
        Info.Caption := Value;
end;

procedure TfrmProgresos.setTitulo(Value:string);
begin
        Self.Caption := Value;
end;

procedure TfrmProgresos.Ejecutar;
begin
        Self.Show;
end;

procedure TfrmProgresos.Cerrar;
begin
        Close;
end;

procedure TfrmProgresos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        Action := caFree;
end;

procedure TfrmProgresos.cancelarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmProgresos.FormDblClick(Sender: TObject);
begin
        if Self.Visible then
           Self.Visible := false
        else
           Self.Visible := True;
end;

end.
