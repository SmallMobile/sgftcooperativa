unit UnitCambioReferencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, IBDatabase, ComCtrls, StdCtrls,
  Buttons;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Bar1: TProgressBar;
    Label3: TLabel;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQueryL: TIBQuery;
    IBQueryW: TIBQuery;
    btnProcesar: TBitBtn;
    IBQueryL1: TIBQuery;
    BitBtn1: TBitBtn;
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
        IBQueryL.SQL.Add(' TIPO_ID_REFERENCIA,ID_REFERENCIA, COUNT(*) as TOTAL');
        IBQueryL.SQL.Add('from');
        IBQueryL.SQL.Add(' "gen$referencias"');
        IBQueryL.SQL.Add('group by');
        IBQueryL.SQL.Add(' TIPO_ID_REFERENCIA,ID_REFERENCIA');
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
        IBQueryW.SQL.Add('insert into "gen$referencias_new" values (');
        IBQueryW.SQL.Add(':TIPO_ID_REFERENCIA,');
        IBQueryW.SQL.Add(':ID_REFERENCIA,');
        IBQueryW.SQL.Add(':CONSECUTIVO_REFERENCIA,');
        IBQueryW.SQL.Add(':PRIMER_APELLIDO_REFERENCIA,');
        IBQueryW.SQL.Add(':SEGUNDO_APELLIDO_REFERENCIA,');
        IBQueryW.SQL.Add(':NOMBRE_REFERENCIA,');
        IBQueryW.SQL.Add(':DIRECCION_REFERENCIA,');
        IBQueryW.SQL.Add(':TELEFONO_REFERENCIA,');
        IBQueryW.SQL.Add(':TIPO_REFERENCIA,');
        IBQueryW.SQL.Add(':PARENTESCO_REFERENCIA)');

        while not IBQueryL.Eof do begin
          Bar1.Position := IBQueryL.RecNo;
          Edit1.Text := IBQueryL.FieldByName('TIPO_ID_REFERENCIA').AsString + ':' + IBQueryL.FieldByName('ID_REFERENCIA').AsString;
          Application.ProcessMessages;
          IBQueryL1.Close;
          IBQueryL1.SQL.Clear;
          IBQueryL1.SQL.Add('select * from "gen$referencias" where');
          IBQueryL1.SQL.Add('TIPO_ID_REFERENCIA = :TIPO_ID_REFERENCIA and');
          IBQueryL1.SQL.Add('ID_REFERENCIA = :ID_REFERENCIA');
          IBQueryL1.ParamByName('TIPO_ID_REFERENCIA').AsInteger := IBQueryL.FieldByName('TIPO_ID_REFERENCIA').AsInteger;
          IBQueryL1.ParamByName('ID_REFERENCIA').AsString := IBQueryL.FieldByName('ID_REFERENCIA').AsString;
          try
           IBQueryL1.Open;
          except
           raise;
          end;

          while not IBQueryL1.Eof do begin
           Application.ProcessMessages;
           IBQueryW.ParamByName('TIPO_ID_REFERENCIA').AsInteger := IBQueryL1.FieldByName('TIPO_ID_REFERENCIA').AsInteger;
           IBQueryW.ParamByName('ID_REFERENCIA').AsString := IBQueryL1.FieldByName('ID_REFERENCIA').AsString;
           IBQueryW.ParamByName('CONSECUTIVO_REFERENCIA').AsInteger := IBQueryL1.RecNo;
           IBQueryW.ParamByName('PRIMER_APELLIDO_REFERENCIA').AsString := IBQueryL1.FieldByName('PRIMER_APELLIDO_REFERENCIA').AsString;
           IBQueryW.ParamByName('SEGUNDO_APELLIDO_REFERENCIA').AsString := IBQueryL1.FieldByName('SEGUNDO_APELLIDO_REFERENCIA').AsString;
           IBQueryW.ParamByName('NOMBRE_REFERENCIA').AsString := IBQueryL1.FieldByName('NOMBRE_REFERENCIA').AsString;
           IBQueryW.ParamByName('DIRECCION_REFERENCIA').AsString := IBQueryL1.FieldByName('DIRECCION_REFERENCIA').AsString;
           IBQueryW.ParamByName('TELEFONO_REFERENCIA').AsString := IBQueryL1.FieldByName('TELEFONO_REFERENCIA').AsString;
           IBQueryW.ParamByName('TIPO_REFERENCIA').AsInteger := IBQueryL1.FieldByName('TIPO_REFERENCIA').AsInteger;
           IBQueryW.ParamByName('PARENTESCO_REFERENCIA').AsInteger := IBQueryL1.FieldByName('PARENTESCO_REFERENCIA').AsInteger;
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
