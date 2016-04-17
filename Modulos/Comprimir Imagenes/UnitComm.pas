unit UnitComm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ZlibEx, IBSQL, DB, IBDatabase, ExtCtrls, IBQuery,
  IBCustomDataSet;

type
  TForm1 = class(TForm)
    EdId: TEdit;
    Label1: TLabel;
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
    Image2: TImage;
    Button2: TButton;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

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
begin
        IBTransaction1.StartTransaction;
        with IBSQL1 do begin
          Close;
          SQL.Clear;
          SQL.Add('select ID_IDENTIFICACION,ID_PERSONA,FOTO,FIRMA,FOTO_HUELLA,DATOS_HUELLA from "gen$persona"');
          SQL.Add('where ID_IDENTIFICACION =:ID and ID_PERSONA = :NUMERO');
          ParamByName('ID').AsInteger := 3;
          ParamByName('NUMERO').AsString := EdId.Text;
          try
           Open;
          except
           raise;
          end;

          Sfoto := TMemoryStream.Create;
          TBlobField(FieldByName('FOTO')).SaveToStream(Sfoto);
          Sfoto.Seek(0,soFromBeginning);
          Image1.Picture.Bitmap.LoadFromStream(Sfoto);
          Image1.Repaint;
          EdFoto.Text := IntToStr(Sfoto.Size);

          Sfirma := TMemoryStream.Create;
          TBlobField(FieldByName('FIRMA')).SaveToStream(Sfirma);
          Sfirma.Seek(0,soFromBeginning);
          Image3.Picture.Bitmap.LoadFromStream(Sfirma);
          Image3.Repaint;
          EdFirma.Text := IntToStr(Sfirma.Size);

          Shuella := TMemoryStream.Create;
          TBlobField(FieldByName('FOTO_HUELLA')).SaveToStream(Shuella);
          Shuella.Seek(0,soFromBeginning);
          Image5.Picture.Bitmap.LoadFromStream(Shuella);
          Image5.Repaint;
          EdFHuella.Text := IntToStr(Shuella.Size);

          Sdhuella := TMemoryStream.Create;
          TBlobField(FieldByName('DATOS_HUELLA')).SaveToStream(Sdhuella);
          Sdhuella.Seek(0,soFromBeginning);

          tamanoh := Sdhuella.Size;
          EdDHuella.Text := IntToStr(tamanoh);

          cSfoto := TMemoryStream.Create;
          cSfirma := TMemoryStream.Create;
          cShuella := TMemoryStream.Create;

          Sfoto.Seek(0,soFromBeginning);
          ZCompressStream(Sfoto,cSfoto);
          cSfoto.Seek(0,soFromBeginning);
          EdCFoto.Text := IntToStr(cSfoto.Size);
          Tfoto := csfoto.Size;

          Sfirma.Seek(0,soFromBeginning);
          ZCompressStream(Sfirma,cSfirma);
          cSfirma.Seek(0,soFromBeginning);
          EdCFirma.Text := IntToStr(cSfirma.Size);
          Tfirma := cSfirma.Size;

          Shuella.Seek(0,soFromBeginning);
          ZCompressStream(Shuella,cShuella);
          cShuella.Seek(0,soFromBeginning);
          EdCFHuella.Text := IntToStr(cShuella.Size);
          Thuella := cShuella.Size;

          Close;
          SQL.Clear;
          SQL.Add('insert into "gen$zimages" values (');
          SQL.Add(':ID_IDENTIFICACION,:ID_PERSONA,:FOTO,:FIRMA,:FOTO_HUELLA,:DATOS_HUELLA,:TAMANO)');
          ParamByName('ID_IDENTIFICACION').AsInteger := 3;
          ParamByName('ID_PERSONA').AsString := EdId.Text;

         try
          if Tfoto > 0 then begin
          cSfoto.Seek(0,soFromBeginning);
          GetMem(Buffer,Tfoto);
          cSfoto.ReadBuffer(Buffer^,Tfoto);
          ParamByName('FOTO').SetBlobData(Buffer,Tfoto);
          end
          else
           ParamByName('FOTO').Clear;

          if Tfirma > 0 then begin
          cSfirma.Seek(0,soFromBeginning);
          GetMem(Buffer,tfirma);
          cSfirma.ReadBuffer(Buffer^,cSfirma.Size);
          ParamByName('FIRMA').SetBlobData(Buffer,Tfirma);
          end
          else
           ParamByName('FIRMA').Clear;

          if Thuella > 0 then begin
          cShuella.Seek(0,soFromBeginning);
          GetMem(Buffer,Thuella);
          cShuella.ReadBuffer(Buffer^,Thuella);
          ParamByName('FOTO_HUELLA').SetBlobData(Buffer,Thuella);

          Sdhuella.Seek(0,soFromBeginning);
          GetMem(Buffer,Sdhuella.Size);
          Sdhuella.ReadBuffer(Buffer^,Sdhuella.Size);
          ParamByName('DATOS_HUELLA').SetBlobData(Buffer,Sdhuella.Size);
          end
          else
          begin
            ParamByName('FOTO_HUELLA').Clear;
            ParamByName('DATOS_HUELLA').Clear;
          end;

          ParamByName('TAMANO').AsInteger := tamanoh;
          try
           ExecSQL;
          except
           Transaction.Rollback;
           raise;
          end;
         except
           Transaction.Rollback;
           raise;
         end;
        end;

     IBTransaction1.Commit;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
   Sfoto,Sfirma,Shuella,Sdhuella:TStream;
   cSfoto,cSfirma,cShuella,cSdhuella:TStream;
   uFoto:TStream;
   tamanoh:Integer;
   Imagen:TBitmap;
   Buffer:Pointer;
begin
        IBTransaction1.StartTransaction;
        with IBSQL1 do begin
          Close;
          SQL.Clear;
          SQL.Add('select ID_IDENTIFICACION,ID_PERSONA,FOTO,FIRMA,FOTO_HUELLA,DATOS_HUELLA from "gen$zimages"');
          SQL.Add('where ID_IDENTIFICACION =:ID and ID_PERSONA = :NUMERO');
          ParamByName('ID').AsInteger := 3;
          ParamByName('NUMERO').AsString := EdId.Text;
          try
           Open;
          except
           raise;
          end;

          cSfoto := TMemoryStream.Create;
          uFoto := TMemoryStream.Create;
          TBlobField(FieldByName('FOTO')).SaveToStream(cSfoto);
          cSfoto.Seek(0,soFromBeginning);
          ZDecompressStream(cSfoto,uFoto);
          uFoto.Seek(0,soFromBeginning);
          Image2.Picture.Bitmap.LoadFromStream(ufoto);
          Image2.Repaint;
          EdFoto.Text := IntToStr(ufoto.Size);
          uFoto.Free;

          cSfirma := TMemoryStream.Create;
          uFoto := TMemoryStream.Create;
          TBlobField(FieldByName('FIRMA')).SaveToStream(cSfirma);
          cSfirma.Seek(0,soFromBeginning);
          ZDecompressStream(cSfirma,uFoto);
          uFoto.Seek(0,soFromBeginning);
          Image4.Picture.Bitmap.LoadFromStream(uFoto);
          Image4.Repaint;
          EdFirma.Text := IntToStr(uFoto.Size);
          uFoto.Free;

          cShuella := TMemoryStream.Create;
          uFoto := TMemoryStream.Create;
          TBlobField(FieldByName('FOTO_HUELLA')).SaveToStream(cShuella);
          cShuella.Seek(0,soFromBeginning);
          ZDecompressStream(cShuella,uFoto);
          uFoto.Seek(0,soFromBeginning);
          Image6.Picture.Bitmap.LoadFromStream(uFoto);
          Image6.Repaint;
          EdFHuella.Text := IntToStr(uFoto.Size);
          uFoto.Free;

          Sdhuella := TMemoryStream.Create;
          TBlobField(FieldByName('DATOS_HUELLA')).SaveToStream(Sdhuella);
          Sdhuella.Seek(0,soFromBeginning);
          tamanoh := Sdhuella.Size;
          EdDHuella.Text := IntToStr(tamanoh);

          Transaction.Commit;

        end;
end;

end.
