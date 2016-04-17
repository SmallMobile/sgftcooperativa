unit UnitDb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, JvSpecialProgress, JvWaitingGradient;

type
  TfrmDB = class(TForm)
    Info: TLabel;
    barra: TJvSpecialProgress;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FPosicion:Integer;
    FMinimo:Integer;
    FMaximo:Integer;
    FInfo:string;
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
  frmDB: TfrmDB;
  MinValor:Integer;
  MaxValor:Integer;
  Porcentaje:Integer;

implementation

{$R *.dfm}

procedure TfrmDB.setminimo(Value:Integer);
begin
        Barra.Minimum := Value;
end;

procedure TfrmDB.setmaximo(Value:Integer);
begin
        Fmaximo := Value;
        Barra.Maximum := Value;
        
end;

procedure TfrmDB.setposicion(Value:Integer);
var Valor:Integer;
begin
        Porcentaje := Value;
        Barra.Position := Porcentaje;
//        Porcentaje := (Porcentaje * 100 ) div FMaximo;
//        Barra.Caption := FormatFloat('#0%',Porcentaje);
end;

procedure TfrmDB.setinfo(Value:string);
begin
        Info.Caption := Value;
end;

procedure TfrmDB.setTitulo(Value:string);
begin
        Self.Caption := Value;
end;

procedure TfrmDB.Ejecutar;
begin
        Self.Show;
end;

procedure TfrmDB.Cerrar;
begin
        Close;
end;

procedure TfrmDB.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        Action := caFree;
end;

end.
