unit uForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, JvExStdCtrls, JvEdit, JvValidateEdit,
  Mask, JvExMask, JvToolEdit, DateUtils, StrUtils, JvExComCtrls, JvProgressBar;

type

  Header = Record
    consecutivo:string;
    codigo:string;
    fechaI:string;
    fechaF:string;
    total:string;
    fin:string;
  End;

type
  Data = Record
    consecutivo : string[10];
    noproducto:string[20];
    fecha:string[10];
    producto:string[2];
    municipio:string[5];
    tipoid1:string[2];
    id1:string[20];
    papellido1:string[40];
    sapellido1:string[40];
    pnombre1:string[40];
    snombre1:string[40];
    razonsocial1:string[60];
    tipoid2:string[2];
    id2:string[20];
    papellido2:string[40];
    sapellido2:string[40];
    pnombre2:string[40];
    snombre2:string[40];
    razonsocial2:string[60];
  End;

type
  Footer = Record
    consecutivo:string[10];
    codigo:string[8];
    total:string[10];
    fin:string;
  End;

type
  TfrmPlanoSiplaft = class(TForm)
    _bitConectar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    _edtFechaInicial: TDateTimePicker;
    _edtFechaFinal: TDateTimePicker;
    _bitProcesar: TBitBtn;
    BitBtn1: TBitBtn;
    Label5: TLabel;
    _edtFile: TStaticText;
    _bar: TJvProgressBar;
    procedure _bitConectarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure _bitProcesarClick(Sender: TObject);
    procedure _edtFechaFinalExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlanoSiplaft: TfrmPlanoSiplaft;

implementation

uses uDatos;

{$R *.dfm}

procedure TfrmPlanoSiplaft.BitBtn1Click(Sender: TObject);
begin
  if uDatos.DataModule4._ibdb.Connected then
    uDatos.DataModule4._ibdb.Close;
  Close;
end;

procedure TfrmPlanoSiplaft._bitConectarClick(Sender: TObject);
begin
  uDatos.DataModule4._ibdb.Open;
  if (not uDatos.DataModule4._ibdb.Connected) then
  begin
    Showmessage('No se pudo conectar');
    exit;
  end;
  uDatos.DataModule4._ibt.StartTransaction;

end;

procedure TfrmPlanoSiplaft._bitProcesarClick(Sender: TObject);
var
 _file : TextFile;
 _handle:Integer;
 _header:Header;
 _footer:Footer;
 _data:Data;
 _s:string;
  _i,_csc: Integer;
begin
  AssignFile(_file,_edtFile.Caption);
   Rewrite(_file);
  uDatos.DataModule4._qrSelect.Close;
  uDatos.DataModule4._qrSelect.Open;
  uDatos.DataModule4._cdsSelect.Open;
  uDatos.DataModule4._cdsSelect.Last;
  uDatos.DataModule4._cdsSelect.First;
  _header.total := Format('%.10d',[uDatos.DataModule4._cdsSelect.RecordCount]);
  uDatos.DataModule4._cdsSelect.Filtered := False;
  uDatos.DataModule4._cdsSelect.Last;
  uDatos.DataModule4._cdsSelect.First;
  _bar.Min := 0;
  _bar.Max := uDatos.DataModule4._cdsSelect.RecordCount;
  _bar.Position := 0;

  _header.consecutivo:= Format('%10d',[0]);
  _header.codigo := '06003007';
  DateTimeToString(_s,'yyyy-mm-dd',_edtFechaInicial.DateTime);
  _header.fechaI := _s;
  DateTimeToString(_s,'yyyy-mm-dd',_edtFechaFinal.DateTime);
  _header.fechaF := _s;
  for _i := 1 to 483 do
  begin
    Application.ProcessMessages;
    _header.fin := _header.fin + 'X';
  end;
  _s := _header.consecutivo+_header.codigo+_header.fechaI+_header.fechaF+_header.total+_header.fin;
// write header
  WriteLn(_file,_s);
// write data
  _csc := 0;
  while not uDatos.DataModule4._cdsSelect.Eof do
  begin
     _csc := _csc + 1;
     _data.consecutivo := '';
     _data.noproducto := '';
     _data.fecha := '';
     _data.producto := '';
     _data.municipio := '';
     _data.tipoid1 := '';
     _data.id1 := '';
     _data.papellido1 := '';
     _data.sapellido1 := '';
     _data.pnombre1 := '';
     _data.snombre1 := '';
     _data.razonsocial1 := '';
     _data.tipoid2 := '';
     _data.id2 := '';
     _data.papellido2 := '';
     _data.sapellido2 := '';
     _data.pnombre2 := '';
     _data.snombre2 := '';
     _data.razonsocial2 := '';
     _bar.Position := uDatos.DataModule4._cdsSelect.RecNo;
     Application.ProcessMessages;
     _data.consecutivo := Format('%10d',[_csc]);
     _data.noproducto := Format('%.1d%.2d%-17s',[uDatos.DataModule4._cdsSelect.FieldByName('ID_TIPO_CAPTACION').AsInteger,
                                                 uDatos.DataModule4._cdsSelect.FieldByName('ID_AGENCIA').AsInteger,'']);

     DateTimeToString(_s,'yyyy-mm-dd',uDatos.DataModule4._cdsSelect.FieldByName('FECHA').AsDateTime);
     _data.fecha := _s;
     //
     case uDatos.DataModule4._cdsSelect.FieldByName('ID_AGENCIA').AsInteger of
       1: _data.municipio := '54498';
       2: _data.municipio := '54003';
       3: _data.municipio := '54206';
       4: _data.municipio := '20011';
     end;
     case uDatos.DataModule4._cdsSelect.FieldByName('ID_TIPO_CAPTACION').AsInteger of
       1: _data.producto := '94';
       2: _data.producto := '90';
       4: _data.producto := '90';
       5: _data.producto := '92';
       6: _data.producto := '91';
       else
          _data.producto := '09';
     end;

     //_data.producto := format('%2d',[udatos.DataModule4._cdsSelect.FieldByName('TIPO_PRODUCTO').AsString]);
     //_data.municipio := udatos.DataModule4._cdsSelect.FieldByName('COD_DPTO').AsString;
     //
     //_data.tipoid1 := Format('%2d',[udatos.DataModule4._cdsSelect.FieldByName('ID_IDENTIFICACION1').AsInteger]);
     case uDatos.DataModule4._cdsSelect.FieldByName('ID_IDENTIFICACION1').AsInteger of
        1: _data.tipoid1 := '11';
        2: _data.tipoid1 := '12';
        3: _data.tipoid1 := '13';
        4: _data.tipoid1 := '31';
        5,9: _data.tipoid1 := '00';
        6: _data.tipoid1 := '22';
        7: _data.tipoid1 := '42';
        8: _data.tipoid1 := '41';
        else
          _data.tipoid1 := '00';
     end;

     _data.id1 := Format('%-20s',[uDatos.DataModule4._cdsSelect.FieldByName('ID_PERSONA1').AsString]);

     _data.papellido1 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('1APELLIDO_T1').AsString]);
     _data.sapellido1 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('2APELLIDO_T1').AsString]);
     //_data.pnombre1 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T1').AsString]);
     //_data.snombre1 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('2NOMBRE_T1').AsString]);
     _i := Pos(' ',uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T1').AsString);
     if _i = 0 then
     begin
         _data.pnombre1 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T1').AsString]);
         _data.snombre1 := Format('%-40s',['']);
     end
     else
     begin
       _data.pnombre1 := Format('%-40s',[LeftStr(uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T1').AsString,_i)]);
       _data.snombre1 := Format('%-40s',[MidStr(uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T1').AsString,
                              _i+1,
                              Length(uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T1').AsString))]);
     end;

     _data.razonsocial1 := Format('%-60s',[uDatos.DataModule4._cdsSelect.FieldByName('RAZON_T1').AsString]);
//     _data.tipoid2 := Format('%10d',[udatos.DataModule4._cdsSelect.FieldByName('ID_IDENTIFICACION2').AsInteger]);
     case uDatos.DataModule4._cdsSelect.FieldByName('ID_IDENTIFICACION2').AsInteger of
        1: _data.tipoid2 := '11';
        2: _data.tipoid2 := '12';
        3: _data.tipoid2 := '13';
        4: _data.tipoid2 := '31';
        5,9: _data.tipoid2 := '00';
        6: _data.tipoid2 := '22';
        7: _data.tipoid2 := '42';
        8: _data.tipoid2 := '41';
        else
         _data.tipoid2 := '00';
     end;

     _data.id2 := Format('%-20s',[uDatos.DataModule4._cdsSelect.FieldByName('ID_PERSONA2').AsString]);
     _data.papellido2 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('1APELLIDO_T2').AsString]);
     _data.sapellido2 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('2APELLIDO_T2').AsString]);
//     _data.pnombre2 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T2').AsString]);
//     _data.snombre2 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('2NOMBRE_T2').AsString]);
     _i := Pos(' ',uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T2').AsString);
     if _i = 0 then
     begin
       _data.pnombre2 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T2').AsString]);
       _data.snombre2 := Format('%-40s',['']);
     end
     else
     begin
       _data.pnombre2 := Format('%-40s',[LeftStr(uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T2').AsString,_i)]);
       _data.snombre2 := Format('%-40s',[MidStr(uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T2').AsString,
                              _i+1,
                              Length(uDatos.DataModule4._cdsSelect.FieldByName('1NOMBRE_T2').AsString))]);
     end;

     _data.razonsocial2 := Format('%-60s',[uDatos.DataModule4._cdsSelect.FieldByName('RAZON_T2').AsString]);


     _s := _data.consecutivo+
           _data.noproducto+
           _data.fecha+
           _data.producto+
           _data.municipio+
           _data.tipoid1+
           _data.id1+
           _data.papellido1+
           _data.sapellido1+
           _data.pnombre1+
           _data.snombre1+
           _data.razonsocial1+
           _data.tipoid2+
           _data.id2+
           _data.papellido2+
           _data.sapellido2+
           _data.pnombre2+
           _data.snombre2+
           _data.razonsocial2;

     if Length(_s) <> 531 then ShowMessage('El dato no cumple con el tamaño requerido');
     Writeln(_file,_s);
     uDatos.DataModule4._cdsSelect.Next;
  end;

// write footer
  _footer.consecutivo:= Format('%10d',[0]);
  _footer.codigo := '06003007';
  _footer.total := _header.total;
  for _i := 1 to 503 do
  begin
    Application.ProcessMessages;
    _footer.fin := _footer.fin + 'X';
  end;

  _s := _footer.consecutivo+_footer.codigo+_footer.total+_footer.fin;
  WriteLn(_file,_s);
  CloseFile(_file);
  ShowMessage('Proceso Finalizado');
end;

procedure TfrmPlanoSiplaft._edtFechaFinalExit(Sender: TObject);
begin
  if _edtFechaInicial.Date >= _edtFechaFinal.Date then
  begin
     _edtFechaInicial.Date := _edtFechaFinal.Date;
  end;
  _edtFile.Caption := 'D:\CREDIS'+Format('%.2d%.2s',[MonthOf(_edtFechaFinal.Date),RightStr(FloatToStr(YearOf(_edtFechaFinal.Date)),2)])+'.txt';
end;

end.
