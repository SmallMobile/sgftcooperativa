unit UnitCambioDireccion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, IBDatabase, StdCtrls, Buttons,
  ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Bar1: TProgressBar;
    btnProcesar: TBitBtn;
    BitBtn1: TBitBtn;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQueryL: TIBQuery;
    IBQueryW: TIBQuery;
    IBQueryL1: TIBQuery;
    procedure btnProcesarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnProcesarClick(Sender: TObject);
begin
        IBDatabase1.DatabaseName := Edit2.Text;
        IBDatabase1.Params.Clear;
        IBDatabase1.Params.Add('user_name=SYSDBA');
        IBDatabase1.Params.Add('password=masterkey');
        IBDatabase1.Params.Add('lc_ctype=ISO8859_1');
        try
         IBDatabase1.Open;
        except
         raise;
        end;

        IBTransaction1.StartTransaction;

        IBQueryL.Close;
        IBQueryL.SQL.Clear;
        IBQueryL.SQL.Add('select');
        IBQueryL.SQL.Add(' ID_IDENTIFICACION,ID_PERSONA, COUNT(*) as TOTAL');
        IBQueryL.SQL.Add('from');
        IBQueryL.SQL.Add(' "gen$direccion"');
        IBQueryL.SQL.Add('group by');
        IBQueryL.SQL.Add(' ID_IDENTIFICACION,ID_PERSONA');
        try
         IBQueryL.Open;
         IBQueryL.Last;
         IBQueryL.First;
        except
         IBTransaction1.Rollback;
         raise;
        end;

        Bar1.Min := 0;
        Bar1.Max := IBQueryL.RecordCount;
        Bar1.Position := 0;

        IBQueryW.SQL.Clear;
        IBQueryW.SQL.Add('insert into "gen$direccion_new" values (');
        IBQueryW.SQL.Add(':ID_IDENTIFICACION,');
        IBQueryW.SQL.Add(':ID_PERSONA,');
        IBQueryW.SQL.Add(':CONSECUTIVO,');
        IBQueryW.SQL.Add(':ID_DIRECCION,');
        IBQueryW.SQL.Add(':DIRECCION,');
        IBQueryW.SQL.Add(':BARRIO,');
        IBQueryW.SQL.Add(':MUNICIPIO,');
        IBQueryW.SQL.Add(':TELEFONO1,');
        IBQueryW.SQL.Add(':TELEFONO2,');
        IBQueryW.SQL.Add(':TELEFONO3,');        
        IBQueryW.SQL.Add(':TELEFONO4)');

        while not IBQueryL.Eof do begin
          Bar1.Position := IBQueryL.RecNo;
          Edit1.Text := IBQueryL.FieldByName('ID_IDENTIFICACION').AsString + ':' + IBQueryL.FieldByName('ID_PERSONA').AsString;
          Application.ProcessMessages;
          IBQueryL1.Close;
          IBQueryL1.SQL.Clear;
          IBQueryL1.SQL.Add('select * from "gen$direccion" where');
          IBQueryL1.SQL.Add('ID_IDENTIFICACION = :ID_IDENTIFICACION and');
          IBQueryL1.SQL.Add('ID_PERSONA = :ID_PERSONA');
          IBQueryL1.ParamByName('ID_IDENTIFICACION').AsInteger := IBQueryL.FieldByName('ID_IDENTIFICACION').AsInteger;
          IBQueryL1.ParamByName('ID_PERSONA').AsString := IBQueryL.FieldByName('ID_PERSONA').AsString;
          try
           IBQueryL1.Open;
          except
           raise;
          end;

          while not IBQueryL1.Eof do begin
           Application.ProcessMessages;
           IBQueryW.ParamByName('ID_IDENTIFICACION').AsInteger := IBQueryL1.FieldByName('ID_IDENTIFICACION').AsInteger;
           IBQueryW.ParamByName('ID_PERSONA').AsString := IBQueryL1.FieldByName('ID_PERSONA').AsString;
           IBQueryW.ParamByName('CONSECUTIVO').AsInteger := IBQueryL1.RecNo;
           IBQueryW.ParamByName('ID_DIRECCION').AsInteger := IBQueryL1.FieldByName('ID_DIRECCION').AsInteger;
           IBQueryW.ParamByName('DIRECCION').AsString := IBQueryL1.FieldByName('DIRECCION').AsString;
           IBQueryW.ParamByName('BARRIO').AsString := IBQueryL1.FieldByName('BARRIO').AsString;
           IBQueryW.ParamByName('MUNICIPIO').AsString := IBQueryL1.FieldByName('MUNICIPIO').AsString;
           IBQueryW.ParamByName('TELEFONO1').AsString := IBQueryL1.FieldByName('TELEFONO1').AsString;
           IBQueryW.ParamByName('TELEFONO2').AsString := IBQueryL1.FieldByName('TELEFONO2').AsString;
           IBQueryW.ParamByName('TELEFONO3').AsString := IBQueryL1.FieldByName('TELEFONO3').AsString;
           IBQueryW.ParamByName('TELEFONO4').AsString := IBQueryL1.FieldByName('TELEFONO4').AsString;
           try
             IBQueryW.ExecSQL;
           except
             raise;
           end;

           IBQueryL1.Next;
          end;

          IBQueryL.Next;
        end; // fin del while

        IBTransaction1.Commit;

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
        try
         IBDatabase1.Close;
        finally
         Close;
        end;
end;

end.
