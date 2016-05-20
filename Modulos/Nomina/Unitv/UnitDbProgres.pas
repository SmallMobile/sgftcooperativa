unit UnitDbProgres;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvSpecialProgress, StdCtrls;

type
  TFrmDbProgres = class(TForm)
    Panel1: TPanel;
    JV: TJvSpecialProgress;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    
    
    procedure setposicion(Value: Integer);
    procedure setTitulo(Value: string);
    { Private declarations }
  public
  property Position:Integer Write setposicion;
  property Titulo:string Write SetTitulo;
  procedure ejecutar;
  procedure cerrar;


  published
    { Public declarations }
  end;

var
  FrmDbProgres: TFrmDbProgres;

implementation

{$R *.dfm}

procedure TFrmDbProgres.FormCreate(Sender: TObject);
begin
//        baja := 0;
//        Timer1.Enabled := True;
end;

procedure TFrmDbProgres.ejecutar;
begin
        Self.Show;
end;

procedure TFrmDbProgres.cerrar;
begin
        Close;
end;

procedure TFrmDbProgres.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        Action := caFree;
end;

procedure TFrmDbProgres.setposicion(Value: Integer);
begin
        JV.Position := Value;

end;

procedure TFrmDbProgres.setTitulo(Value: string);
begin

end;

end.
