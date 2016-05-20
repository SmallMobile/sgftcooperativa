unit UnitCommCiclo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ZlibEx, IBSQL, DB, IBDatabase, ExtCtrls, IBQuery,
  IBCustomDataSet, ComCtrls, JvProgressBar, DBClient;

type
  TForm1 = class(TForm)
    Button1: TButton;
    IBTransaction1: TIBTransaction;
    IBDatabase1: TIBDatabase;
    Image1: TImage;
    IBSQL1: TIBQuery;
    Label2: TLabel;
    EdFoto: TEdit;
    Label3: TLabel;
    EdFirma: TEdit;
    Label4: TLabel;
    EdFHuella: TEdit;
    Label5: TLabel;
    EdDHuella: TEdit;
    EdCFoto: TEdit;
    EdCfirma: TEdit;
    EdCFHuella: TEdit;
    EdCDHuella: TEdit;
    Image3: TImage;
    Image5: TImage;
    IBSQL2: TIBQuery;
    Label1: TLabel;
    EdInicio: TEdit;
    Label6: TLabel;
    EdTranscurso: TEdit;
    Bar2: TJvProgressBar;
    Bar1: TJvProgressBar;
    Timer1: TTimer;
    Cds: TClientDataSet;
    CdsID_IDENTIFICACION: TIntegerField;
    CdsID_PERSONA: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Inicio:TDateTime;  

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
   Sfoto,Sfirma,Shuella,Sdhuella:TStream;
   cSfoto,cSfirma,cShuella,cSdhuella:TStream;
   uFoto:TStream;
   tamanoh,Tfoto,Tfirma,Thuella:Integer;
   Imagen:TBitmap;
   Buffer:Pointer;
   Total:Integer;
begin
      try
        Inicio := Now;
        EdInicio.Text := DateTimeToStr(Inicio);
        Timer1.Enabled := True;
        IBDatabase1.Open;
        IBTransaction1.StartTransaction;
        with IBSQL1 do begin
          Close;
          SQL.Clear;
          SQL.Add('select count(*) as TOTAL from "gen$persona"');
          try
           Open;
          except
           raise;
          end;
          Total := FieldByName('TOTAL').AsInteger;

          SQL.Clear;
          SQL.Add('select ID_IDENTIFICACION,ID_PERSONA from "gen$persona" order by ID_IDENTIFICACION,ID_PERSONA');
          try
           Open;
          except
           Transaction.Rollback;
           raise;
          end;

          Bar2.Min := 0;
          Bar2.Max := Total;
          Bar2.Position := 0;


          while not Eof do
          begin
            Bar2.Position := RecNo;
            Application.ProcessMessages;
            Cds.Open;
            Cds.Append;
            Cds.FieldByName('ID_IDENTIFICACION').AsInteger := FieldByName('ID_IDENTIFICACION').AsInteger;
            Cds.FieldByName('ID_PERSONA').AsString := FieldByName('ID_PERSONA').AsString;
            Cds.Post;
            Cds.Close;
            Next;
          end;

          Transaction.Commit;

          IBDatabase1.Close;

          Bar2.Min := 0;
          Bar2.Max := Total;
          Bar2.Position := 0;

          Cds.Open;
          Cds.First;

          while not Cds.Eof do begin
          Bar2.Position := Cds.RecNo;
          Bar1.Position := 0;
          Application.ProcessMessages;

          IBDatabase1.Open;

          Transaction.StartTransaction;

          Close;
          SQL.Clear;
          SQL.Add('select ID_IDENTIFICACION,ID_PERSONA,FOTO,FIRMA,FOTO_HUELLA,DATOS_HUELLA from "gen$persona"');
          SQL.Add('where ID_IDENTIFICACION = :ID_IDENTIFICACION and ID_PERSONA = :ID_PERSONA');
          ParamByName('ID_IDENTIFICACION').asinteger := Cds.FieldByName('ID_IDENTIFICACION').AsInteger;
          ParamByName('ID_PERSONA').AsString := Cds.FieldByName('ID_PERSONA').AsString;
          try
           Open;
          except
           raise;
          end;


          Sfoto := TMemoryStream.Create;
          TBlobField(FieldByName('FOTO')).SaveToStream(Sfoto);
          Sfoto.Seek(0,soFromBeginning);
          Tfoto := Sfoto.Size;
          if Tfoto <= 8 then
          begin
             Transaction.Rollback;
             IBDatabase1.Close;
             Cds.Next;
             Continue;
          end;

          Image1.Picture.Bitmap.LoadFromStream(Sfoto);
          Image1.Repaint;
          EdFoto.Text := IntToStr(Sfoto.Size);

          Bar1.Position := 10;

          Sfirma := TMemoryStream.Create;
          TBlobField(FieldByName('FIRMA')).SaveToStream(Sfirma);
          Sfirma.Seek(0,soFromBeginning);
          Tfirma := Sfirma.Size;
          if Tfirma > 0 then begin
            Image3.Picture.Bitmap.LoadFromStream(Sfirma);
            Image3.Repaint;
          end;
          EdFirma.Text := IntToStr(Sfirma.Size);

          Bar1.Position := 20;

          Shuella := TMemoryStream.Create;
          TBlobField(FieldByName('FOTO_HUELLA')).SaveToStream(Shuella);
          Shuella.Seek(0,soFromBeginning);
          Thuella := Shuella.Size;
          if Thuella > 0 then begin
            Image5.Picture.Bitmap.LoadFromStream(Shuella);
            Image5.Repaint;
          end;
          EdFHuella.Text := IntToStr(Shuella.Size);

          Bar1.Position := 30;

          Sdhuella := TMemoryStream.Create;
          TBlobField(FieldByName('DATOS_HUELLA')).SaveToStream(Sdhuella);
          Sdhuella.Seek(0,soFromBeginning);

          Bar1.Position := 40;

          tamanoh := Sdhuella.Size;
          EdDHuella.Text := IntToStr(tamanoh);

          Bar1.Position := 50;

          cSfoto := TMemoryStream.Create;
          cSfirma := TMemoryStream.Create;
          cShuella := TMemoryStream.Create;

          Sfoto.Seek(0,soFromBeginning);
          ZCompressStream(Sfoto,cSfoto);
          cSfoto.Seek(0,soFromBeginning);
          EdCFoto.Text := IntToStr(cSfoto.Size);
          Tfoto := csfoto.Size;

          Bar1.Position := 60;

          Sfirma.Seek(0,soFromBeginning);
          ZCompressStream(Sfirma,cSfirma);
          cSfirma.Seek(0,soFromBeginning);
          EdCFirma.Text := IntToStr(cSfirma.Size);
          Tfirma := cSfirma.Size;

          Bar1.Position := 70;

          Shuella.Seek(0,soFromBeginning);
          ZCompressStream(Shuella,cShuella);
          cShuella.Seek(0,soFromBeginning);
          EdCFHuella.Text := IntToStr(cShuella.Size);
          Thuella := cShuella.Size;

          Bar1.Position := 80;

          IBSQL2.Close;
          IBSQL2.SQL.Clear;
          IBSQL2.SQL.Add('insert into "gen$zimages" values (');
          IBSQL2.SQL.Add(':ID_IDENTIFICACION,:ID_PERSONA,:FOTO,:FIRMA,:FOTO_HUELLA,:DATOS_HUELLA,:TAMANO)');
          IBSQL2.ParamByName('ID_IDENTIFICACION').AsInteger := FieldByName('ID_IDENTIFICACION').AsInteger;
          IBSQL2.ParamByName('ID_PERSONA').AsString := FieldByName('ID_PERSONA').AsString;
         try
          if Tfoto > 128 then begin
          cSfoto.Seek(0,soFromBeginning);
          GetMem(Buffer,Tfoto);
          cSfoto.ReadBuffer(Buffer^,Tfoto);
          IBSQL2.ParamByName('FOTO').SetBlobData(Buffer,Tfoto);
          end
          else
           IBSQL2.ParamByName('FOTO').Clear;
          if Tfirma > 8 then begin
          cSfirma.Seek(0,soFromBeginning);
          GetMem(Buffer,tfirma);
          cSfirma.ReadBuffer(Buffer^,cSfirma.Size);
          IBSQL2.ParamByName('FIRMA').SetBlobData(Buffer,Tfirma);
          end
          else
           IBSQL2.ParamByName('FIRMA').Clear;

          Bar1.Position := 90;

          if Thuella > 8 then begin
          cShuella.Seek(0,soFromBeginning);
          GetMem(Buffer,Thuella);
          cShuella.ReadBuffer(Buffer^,Thuella);
          IBSQL2.ParamByName('FOTO_HUELLA').SetBlobData(Buffer,Thuella);

          Sdhuella.Seek(0,soFromBeginning);
          GetMem(Buffer,Sdhuella.Size);
          Sdhuella.ReadBuffer(Buffer^,Sdhuella.Size);
          IBSQL2.ParamByName('DATOS_HUELLA').SetBlobData(Buffer,Sdhuella.Size);
          end
          else
          begin
            IBSQL2.ParamByName('FOTO_HUELLA').Clear;
            IBSQL2.ParamByName('DATOS_HUELLA').Clear;
          end;

          IBSQL2.ParamByName('TAMANO').AsInteger := tamanoh;

          Bar1.Position := 100;          
          if Tfoto > 8 then
           try
            IBSQL2.ExecSQL;
            Transaction.Commit;
            IBDatabase1.Close;
           except
            IBSQL2.Transaction.Rollback;
            IBDatabase1.Close;
            raise;
           end;
         except
           IBSQL2.Transaction.Rollback;
           IBDatabase1.Close;
           raise;
         end;
         Cds.Next;
         end;
        end;
      except
        Timer1.Enabled := False;
        raise;
      end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var Paso:TDateTime;
begin
        Paso := Now-Inicio;
        EdTranscurso.Text := timetostr(Paso);
end;

end.
