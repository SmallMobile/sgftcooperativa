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
    fecha:string;
    total:string;
    fin:string;
  End;

type
  Data = Record
    consecutivo : string[10];
    fecha:string[10];
    valor:string[20];
    moneda:string[1];
    oficina:string[15];
    municipio:string[5];
    producto:string[2];
    transaccion:string[1];
    cuenta:string[20];
    tipoid1:string[2];
    id1:string[20];
    papellido1:string[40];
    sapellido1:string[40];
    pnombre1:string[40];
    snombre1:string[40];
    razonsocial:string[60];
    actividad:string[20];
    ingresos:string[20];
    tipoid2:string[2];
    id2:string[20];
    papellido2:string[40];
    sapellido2:string[40];
    pnombre2:string[40];
    snombre2:string[40];
  End;

type
  Footer = Record
    consecutivo:string[10];
    codigo:string[8];
    total:string[10];
    fin:string;
  End;

type
  TfrmSiplaft4 = class(TForm)
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
  frmSiplaft4: TfrmSiplaft4;

implementation

uses uDatos;

{$R *.dfm}

procedure TfrmSiplaft4.BitBtn1Click(Sender: TObject);
begin
  if uDatos.DataModule4._ibdb.Connected then
    uDatos.DataModule4._ibdb.Close;
  Close;
end;

procedure TfrmSiplaft4._bitConectarClick(Sender: TObject);
begin
  uDatos.DataModule4._ibdb.Open;
  if (not uDatos.DataModule4._ibdb.Connected) then
  begin
    Showmessage('No se pudo conectar');
    exit;
  end;
  uDatos.DataModule4._ibt.StartTransaction;

end;

procedure TfrmSiplaft4._bitProcesarClick(Sender: TObject);
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
  uDatos.DataModule4._qrSelect.ParamByName('FECHA1').AsDate := _edtFechaInicial.Date;
  uDatos.DataModule4._qrSelect.ParamByName('FECHA2').AsDate := _edtFechaFinal.Date;
  uDatos.DataModule4._qrSelect.ParamByName('VALOR1').AsCurrency := _edtMontoInd.Value;
  uDatos.DataModule4._qrSelect.ParamByName('VALOR2').AsCurrency := _edtMontoAcu.Value;
  uDatos.DataModule4._qrSelect.Open;
  uDatos.DataModule4._cdsSelect.Open;
  uDatos.DataModule4._cdsSelect.Filtered := False;
  uDatos.DataModule4._cdsSelect.Filter := 'TP_MOVIMIENTO = 2';
  uDatos.DataModule4._cdsSelect.Filtered := True;
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
  DateTimeToString(_s,'yyyy-mm-dd',_edtFechaFinal.DateTime);
  _header.fecha := _s;
  for _i := 1 to 510 do
  begin
    Application.ProcessMessages;
    _header.fin := _header.fin + 'X';
  end;
  _s := _header.consecutivo+_header.codigo+_header.fecha+_header.total+_header.fin;
// write header
  WriteLn(_file,_s);
// write data
  _csc := 0;
  while not uDatos.DataModule4._cdsSelect.Eof do
  begin
     _csc := _csc + 1;
     _data.consecutivo := '';
     _data.fecha := '';
     _data.valor := '';
     _data.moneda := '';
     _data.oficina := '';
     _data.municipio := '';
     _data.producto := '';
     _data.transaccion := '';
     _data.cuenta := '';
     _data.tipoid1 := '';
     _data.id1 := '';
     _data.papellido1 := '';
     _data.sapellido1 := '';
     _data.pnombre1 := '';
     _data.snombre1 := '';
     _data.razonsocial := '';
     _data.actividad := '';
     _data.ingresos := '';
     _data.tipoid2 := '';
     _data.id2 := '';
     _data.papellido2 := '';
     _data.sapellido2 := '';
     _data.pnombre2 := '';
     _data.snombre2 := '';
     _bar.Position := uDatos.DataModule4._cdsSelect.RecNo;
     Application.ProcessMessages;
     _data.consecutivo := Format('%10d',[_csc]);
     DateTimeToString(_s,'yyyy-mm-dd',uDatos.DataModule4._cdsSelect.FieldByName('FECHA_MOV').AsDateTime);
     _data.fecha := _s;
     _data.valor := Format('%20.0f',[uDatos.DataModule4._cdsSelect.FieldByName('EFECTIVO').AsCurrency]);
     _data.moneda := '1';
     _data.oficina := Format('%-15s',[Format('%.2d',[uDatos.DataModule4._cdsSelect.FieldByName('ID_AGENCIA').AsInteger])]);
     case uDatos.DataModule4._cdsSelect.FieldByName('ID_AGENCIA').AsInteger of
       1: _data.municipio := '54498';
       2: _data.municipio := '54003';
       3: _data.municipio := '54206';
       4: _data.municipio := '20011';
     end;
     case uDatos.DataModule4._cdsSelect.FieldByName('TP_CAPTACION').AsInteger of
       1: _data.producto := '94';
       2: _data.producto := '90';
       4: _data.producto := '90';
       5: _data.producto := '92';
       6: _data.producto := '91';
       else
          _data.producto := '09';
     end;
     _data.transaccion := Format('%.1d',[uDatos.DataModule4._cdsSelect.FieldByName('TP_MOVIMIENTO').AsInteger]);
     _data.cuenta := Format('%.1d%.2d%-17s',[uDatos.DataModule4._cdsSelect.FieldByName('TP_CAPTACION').AsInteger,
                                                 uDatos.DataModule4._cdsSelect.FieldByName('ID_AGENCIA').AsInteger,
                                                 uDatos.DataModule4._cdsSelect.FieldByName('CUENTA').AsString]);
     case uDatos.DataModule4._cdsSelect.FieldByName('T_TIPO_IDENTIFICACION').AsInteger of
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
     _data.id1 := Format('%-20s',[uDatos.DataModule4._cdsSelect.FieldByName('T_N_IDENTIFICACION').AsString]);
      _data.papellido1 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('T_PRIMER_APELLIDO').AsString]);
     _data.sapellido1 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('T_SEGUNDO_APELLIDO').AsString]);
     _i := Pos(' ',uDatos.DataModule4._cdsSelect.FieldByName('T_NOMBRE').AsString);
     _data.pnombre1 := Format('%-40s',[LeftStr(uDatos.DataModule4._cdsSelect.FieldByName('T_NOMBRE').AsString,_i)]);
     _data.snombre1 := Format('%-40s',[MidStr(uDatos.DataModule4._cdsSelect.FieldByName('T_NOMBRE').AsString,
                              _i+1,
                              Length(uDatos.DataModule4._cdsSelect.FieldByName('T_NOMBRE').AsString))]);
     _data.razonsocial := Format('%-60s',[uDatos.DataModule4._cdsSelect.FieldByName('T_RAZON_SOCIAL').AsString]);
     _data.actividad := Format('%-20s',[uDatos.DataModule4._cdsSelect.FieldByName('CIIU').AsString]);
     _data.ingresos := Format('%20f',[uDatos.DataModule4._cdsSelect.FieldByName('T_INGRESOS').AsCurrency]);

     case uDatos.DataModule4._cdsSelect.FieldByName('T2_TIPO_IDENTIFICACION').AsInteger of
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
     _data.id2 := Format('%-20s',[uDatos.DataModule4._cdsSelect.FieldByName('T2_N_IDENTIFICACION').AsString]);
     _data.papellido2 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('T2_PRIMER_APELLIDO').AsString]);
     _data.sapellido2 := Format('%-40s',[uDatos.DataModule4._cdsSelect.FieldByName('T2_SEGUNDO_APELLIDO').AsString]);
     _i := Pos(' ',uDatos.DataModule4._cdsSelect.FieldByName('T2_NOMBRE').AsString);
     _data.pnombre2 := Format('%-40s',[LeftStr(uDatos.DataModule4._cdsSelect.FieldByName('T2_NOMBRE').AsString,_i)]);
     _data.snombre2 := Format('%-40s',[MidStr(uDatos.DataModule4._cdsSelect.FieldByName('T2_NOMBRE').AsString,
                              _i+1,
                              Length(uDatos.DataModule4._cdsSelect.FieldByName('T2_NOMBRE').AsString))]);
     _s := _data.consecutivo+
           _data.fecha+
           _data.valor+
           _data.moneda+
           _data.oficina+
           _data.municipio+
           _data.producto+
           _data.transaccion+
           _data.cuenta+
           _data.tipoid1+
           _data.id1+
           _data.papellido1+
           _data.sapellido1+
           _data.pnombre1+
           _data.snombre1+
           _data.razonsocial+
           _data.actividad+
           _data.ingresos+
           _data.tipoid2+
           _data.id2+
           _data.papellido2+
           _data.sapellido2+
           _data.pnombre2+
           _data.snombre2;

     if Length(_s) <> 548 then ShowMessage('El dato no cumple con el tamaño requerido');
     Writeln(_file,_s);
     uDatos.DataModule4._cdsSelect.Next;
  end;

// write footer
  _footer.consecutivo:= Format('%10d',[0]);
  _footer.codigo := '06003007';
  _footer.total := _header.total;
  for _i := 1 to 520 do
  begin
    Application.ProcessMessages;
    _footer.fin := _footer.fin + 'X';
  end;

  _s := _footer.consecutivo+_footer.codigo+_footer.total+_footer.fin;
  WriteLn(_file,_s);
  CloseFile(_file);
  ShowMessage('Proceso Finalizado');
end;

procedure TfrmSiplaft4._edtFechaFinalExit(Sender: TObject);
begin
  if _edtFechaInicial.Date >= _edtFechaFinal.Date then
  begin
     _edtFechaInicial.Date := _edtFechaFinal.Date;
  end;
  _edtFile.Caption := 'D:\CREDIS'+Format('%.2d%.2s',[MonthOf(_edtFechaInicial.Date),RightStr(FloatToStr(YearOf(_edtFechaInicial.Date)),2)])+'.txt';
end;

end.
