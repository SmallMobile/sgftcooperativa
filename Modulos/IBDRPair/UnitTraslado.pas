unit UnitTraslado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ZlibEx, IBDatabase, DB,
  IBCustomDataSet, IBQuery;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    edDBOrigen: TEdit;
    Label2: TLabel;
    edDBDestino: TEdit;
    Label3: TLabel;
    edUsuario: TEdit;
    Label4: TLabel;
    edPasabordo: TEdit;
    Image1: TImage;
    btnIniciar: TBitBtn;
    btnDetener: TBitBtn;
    btnSalir: TBitBtn;
    IBOrigen: TIBDatabase;
    IBDestino: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBTransaction2: TIBTransaction;
    IBQuery1: TIBQuery;
    IBQuery2: TIBQuery;
    Label5: TLabel;
    edSizeNormal: TStaticText;
    Label6: TLabel;
    edSizeFinal: TStaticText;
    btnSiguiente: TBitBtn;
    Image2: TImage;
    Label7: TLabel;
    edDocumento: TEdit;
    procedure btnSalirClick(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
    procedure btnSiguienteClick(Sender: TObject);
    procedure btnDetenerClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure EjecutarCiclo;
    { Public declarations }
  end;

var
  Form1: TForm1;
  Continuar:Boolean;
  Id:Integer;
  Pr:string;

implementation

{$R *.dfm}

procedure TForm1.btnSalirClick(Sender: TObject);
begin
        Close;
end;

procedure TForm1.btnIniciarClick(Sender: TObject);
begin
  if ((edDBOrigen.Text = '')  or
     (edDBDestino.Text = '')) then
     begin
        ShowMessage('Debe seleccionar Base de Datos Origen y Destino');
        Exit;
     end;

  if ((edUsuario.Text = '') or
     (edPasabordo.Text = '')) then
     begin
        ShowMessage('Debe seleccionar usuario y contraseña con los permisos adecuados');
        Exit;
     end;

  IBOrigen.DatabaseName := edDBOrigen.Text;
  IBDestino.DatabaseName := edDBDestino.Text;

  IBOrigen.Params.Add('user_name='+edUsuario.Text);
  IBOrigen.Params.Add('password='+edPasabordo.Text);
  IBOrigen.Params.Add('lc_ctype=ISO8859_1');

  IBDestino.Params.Add('user_name='+edUsuario.Text);
  IBDestino.Params.Add('password='+edPasabordo.Text);
  IBDestino.Params.Add('lc_ctype=ISO8859_1');

  IBOrigen.Open;
  IBDestino.Open;

  if ( not IBOrigen.Connected) or ( not IBDestino.Connected) then
  begin
       ShowMessage('No se pudo conectar a alguna de las bases');
       Exit;
  end;

  IBOrigen.Close;
  IBDestino.Close;

  btnSalir.Enabled := False;
  Application.ProcessMessages;

  IBQuery1.Database := IBOrigen;
  IBQuery2.Database := IBDestino;

  Pr := edDocumento.Text;
  Continuar := True;
  EjecutarCiclo;


end;

procedure TForm1.btnSiguienteClick(Sender: TObject);
var
  AStream:TStream;
  AStreamCompress:TStream;
  SizeSource:Integer;
  SizeDestin:Integer;
  AStreamFirma:TStream;
  AStreamFirmacompress:TStream;
  SSFirma:Integer;
  SDFirma:Integer;
  AStreamHuella:TStream;
  AStreamHuellaCompress:TStream;
  SSHuella:Integer;
  SDHuella:Integer;

begin

   with IBQuery1 do begin

    AStream := TMemoryStream.Create;
    TBlobField(FieldByName('FOTO')).SaveToStream(AStream);
    AStream.Seek(0,soFromBeginning);
    SizeSource := AStream.Size;
    edSizeNormal.Caption := IntToStr(SizeSource);
    AStream.Seek(0,soFromBeginning);
    Image1.Picture.Bitmap.LoadFromStream(AStream);
    Image1.Repaint;

    AStream.Seek(0,soFromBeginning);
    AStreamCompress := TMemoryStream.Create;
    ZCompressStream(AStream,AStreamCompress,zcMax);
    AStreamCompress.Seek(0,soFromBeginning);
    SizeDestin := AStreamCompress.Size;
    edSizeFinal.Caption := IntToStr(SizeDestin);

    AStream.Free;

    AStream := TMemoryStream.Create;

    AStreamCompress.Seek(0,soFromBeginning);
    ZDecompressStream(AStreamCompress,AStream);

    AStream.Seek(0,soFromBeginning);
    Image2.Picture.Bitmap.LoadFromStream(AStream);
    Image2.Repaint;

    Application.ProcessMessages;

    Next;

   end;
end;

procedure TForm1.EjecutarCiclo;
var
  AStream:TStream;
  AStreamCompress:TStream;
  SizeSource:Integer;
  SizeDestin:Integer;
  AStreamFirma:TStream;
  AStreamFirmaCompress:TStream;
  SSFirma:Integer;
  SDFirma:Integer;
  AStreamHuella:TStream;
  AStreamHuellaCompress:TStream;
  SSHuella:Integer;
  SDHuella:Integer;
begin

   with IBQuery1 do begin
    while Continuar do begin

    IBOrigen.Open;
    Transaction.StartTransaction;
    SQL.Clear;
    SQL.Add('select FIRST 1 ID_IDENTIFICACION,ID_PERSONA,FOTO,FIRMA,FOTO_HUELLA from "gen$persona"');
    SQL.Add('where ID_PERSONA > :ID_PERSONA');
    SQL.Add('order by ID_PERSONA ASC');
    ParamByName('ID_PERSONA').AsString := Pr;
    
    try
     Open;
     Pr := FieldByName('ID_PERSONA').AsString;
    except
     Transaction.Rollback;
     raise;
     Exit;
    end;


    AStream := TMemoryStream.Create;
    
    TBlobField(FieldByName('FOTO')).SaveToStream(AStream);
    AStream.Seek(0,soFromBeginning);
    SizeSource := AStream.Size;
    edSizeNormal.Caption := IntToStr(SizeSource);
    AStream.Seek(0,soFromBeginning);
    Image1.Picture.Bitmap.LoadFromStream(AStream);
    Image1.Repaint;

    AStream.Seek(0,soFromBeginning);

    AStreamCompress := TMemoryStream.Create;
    ZCompressStream(AStream,AStreamCompress,zcMax);
    AStreamCompress.Seek(0,soFromBeginning);
    SizeDestin := AStreamCompress.Size;
    edSizeFinal.Caption := IntToStr(SizeDestin);

    AStreamFirma := TMemoryStream.Create;
//    AStreamFirmaCompress := TMemoryStream.Create;
    TBlobField(FieldByName('FIRMA')).SaveToStream(AStreamFirma);
    AStreamFirma.Seek(0,soFromBeginning);
//    ZCompressStream(AStreamFirma,AStreamFirmaCompress,zcMax);

//    AStreamFirma.Free;

    AStreamHuella := TMemoryStream.Create;
    AStreamHuellaCompress := TMemoryStream.Create;
    TBlobField(FieldByName('FOTO_HUELLA')).SaveToStream(AStreamHuella);
    AStreamHuella.Seek(0,soFromBeginning);
    ZCompressStream(AStreamHuella,AStreamHuellaCompress,zcMax);

    AStreamHuella.Free;

    Application.ProcessMessages;

    if SizeSource > 70000 then begin

     IBDestino.Open;

     IBQuery2.Transaction.StartTransaction;
     IBQuery2.Close;
     IBQuery2.SQL.Clear;
     IBQuery2.SQL.Add('insert into "gen$zimages" values (');
     IBQuery2.SQL.Add(':ID_IDENTIFICACION,');
     IBQuery2.SQL.Add(':ID_PERSONA,');
     IBQuery2.SQL.Add(':FOTO,');
     IBQuery2.SQL.Add(':FIRMA,');
     IBQuery2.SQL.Add(':FOTO_HUELLA');
     IBQuery2.SQL.Add(')');
     IBQuery2.ParamByName('ID_IDENTIFICACION').AsInteger := FieldByName('ID_IDENTIFICACION').AsInteger;
     IBQuery2.ParamByName('ID_PERSONA').AsString := FieldByName('ID_PERSONA').AsString;
     IBQuery2.ParamByName('FOTO').LoadFromStream(AStreamCompress,ftBlob);
     IBQuery2.ParamByName('FIRMA').LoadFromStream(AStreamFirma,ftBlob);
     IBQuery2.ParamByName('FOTO_HUELLA').LoadFromStream(AStreamHuellaCompress,ftBlob);
     try
       IBQuery2.ExecSQL;
       IBQuery2.Transaction.Commit;
       IBDestino.Close;
     except
       IBQuery2.Transaction.Rollback;
       IBQuery1.Transaction.Rollback;
       IBOrigen.Close;
       IBDestino.Close;
     end;
    end;

    FreeAndNil(AStreamCompress);
    FreeAndNil(AStreamHuellaCompress);
    FreeAndNil(AStreamFirma);

    if Transaction.InTransaction then
    begin
       Transaction.Commit;
       IBOrigen.Close;
    end;

   end;
  end;
end;

procedure TForm1.btnDetenerClick(Sender: TObject);
begin
        Continuar := False;
        btnSalir.Enabled := True;
end;

end.
