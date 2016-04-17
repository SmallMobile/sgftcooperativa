unit UnitTarjetasNovedades;

interface

uses
  ShellApi, Windows, Messages, DateUtils, StrUtils, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, DB, IBCustomDataSet,
  IBQuery,unitdmgeneral, IBSQL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, AbBase, AbBrowse,
  AbZBrows, AbZipper, AbMeter, IdMessage;

type
  TfrmTarjetasNovedades = class(TForm)
    Panel1: TPanel;
    CmdProcesar: TBitBtn;
    CmdCerrar: TBitBtn;
    CmdVer: TBitBtn;
    CmdEnviar: TBitBtn;
    Label1: TLabel;
    EdFechaCorte: TDateTimePicker;
    GroupBox1: TGroupBox;
    chkTarjetas: TCheckBox;
    chkCuentas: TCheckBox;
    chkTarjetaCuenta: TCheckBox;
    chkControl: TCheckBox;
    IBQTarjetas: TIBQuery;
    IBSQL1: TIBSQL;
    IdSMTP1: TIdSMTP;
    Label2: TLabel;
    EdEstado: TStaticText;
    Msg: TIdMessage;
    Label3: TLabel;
    EdMail: TEdit;
    Label4: TLabel;
    EdMailCCO: TEdit;
    GroupBox3: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    rb1: TRadioButton;
    rb2: TRadioButton;
    procedure CmdCerrarClick(Sender: TObject);
    procedure CmdProcesarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CmdVerClick(Sender: TObject);
    procedure CmdEnviarClick(Sender: TObject);
  private
    { Private declarations }
    function ObtenerTamanoArchivo(const FileName: string): Int64;    
  public
    { Public declarations }
  end;

var
  frmTarjetasNovedades: TfrmTarjetasNovedades;

  AT:TextFile;
  AC:TextFile;
  ATC:TextFile;
  ACT:TextFile;
  ATN:TextFile;

  FAT:string;
  FAC:string;
  FATC:string;
  FACT:string;
  FTN:string;

  FFF:string;

  Bin,Entidad:string;


implementation

{$R *.dfm}

uses UnitGlobales;

procedure TfrmTarjetasNovedades.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmTarjetasNovedades.CmdProcesarClick(Sender: TObject);
var Cadena:string;
    SaldoTotal,SaldoDisponible:Currency;
    ConteoAT,ConteoAC,ConteoATC,ConteoACT,ConteoTN:Integer;
    Tamano:Int64;
    LineaPedido:string;
begin
        CmdProcesar.Enabled := False;
        EdEstado.Caption := 'Generando Archivos ...';
        Application.ProcessMessages;

        with IBQTarjetas do begin
         if Transaction.InTransaction then
           Transaction.Rollback;
         Transaction.StartTransaction;
         Close;
         SQL.Clear;
         SQL.Add('select * from "cap$tarjetabin"');
         try
           Open;
           if RecordCount < 1 then
            begin
              MessageDlg('No se pudo obtener la información de la entidad',mtError,[mbok],0);
              Transaction.Rollback;
              Exit;
            end
         except
            Transaction.Rollback;
            raise;
         end;

         Bin := FieldByName('ID_BIN').AsString;
         Entidad:= FieldByName('ID_ENTIDAD').AsString;

         FAT := 'C:\Tdebito\TJ'+FormatDateTime('ddmmyyyy',EdFechaCorte.Date)+'.'+Entidad;
         FAC := 'C:\Tdebito\CT'+FormatDateTime('ddmmyyyy',EdFechaCorte.Date)+'.'+Entidad;
         FATC := 'C:\Tdebito\TC'+FormatDateTime('ddmmyyyy',EdFechaCorte.Date)+'.'+Entidad;
         FTN := 'C:\Tdebito\TN'+FormatDateTime('ddmmyyyy',EdFechaCorte.Date)+'.'+Entidad;
         FACT := 'C:\Tdebito\FC'+FormatDateTime('ddmmyyyy',EdFechaCorte.Date)+'.'+Entidad;
         FFF  := Entidad+FormatDateTime('ddmmyyyy',EdFechaCorte.Date);


         AssignFile(AT,FAT);
         AssignFile(AC,FAC);
         AssignFile(ATC,FATC);
         AssignFile(ACT,FACT);
         AssignFile(ATN,FTN);


         Close;
         SQL.Clear;
         SQL.Add('SELECT "cap$tarjetacuenta".ID_TARJETA, ');
         SQL.Add('"cap$tarjetacuenta".ID_AGENCIA,');
         SQL.Add('"cap$tarjetacuenta".ID_TIPO_CAPTACION,');
         SQL.Add('"cap$tarjetacuenta".NUMERO_CUENTA,');
         SQL.Add('"cap$tarjetacuenta".DIGITO_CUENTA,');
         SQL.Add('"cap$tarjetacuenta".FECHA_ASIGNACION,');
         SQL.Add('"cap$tarjetacuenta".HORA_ASIGNACION,');
         SQL.Add('"cap$tarjetacuenta".ID_ESTADO,');
         SQL.Add('"cap$tarjetacuenta".FECHA_BLOQUEO,');
         SQL.Add('"cap$tarjetacuenta".FECHA_CANCELADA,');
         SQL.Add('"cap$tarjetacuenta".CUPO_ATM,');
         SQL.Add('"cap$tarjetacuenta".CUPO_POS,');
         SQL.Add('"cap$tarjetacuenta".TRANS_ATM,');
         SQL.Add('"cap$tarjetacuenta".TRANS_POS,');
         SQL.Add('"gen$persona".ID_PERSONA,');
         SQL.Add('"gen$persona".PRIMER_APELLIDO,');
         SQL.Add('"gen$persona".SEGUNDO_APELLIDO,');
         SQL.Add('"gen$persona".NOMBRE');
         SQL.Add('FROM');
         SQL.Add('"cap$tarjetacuenta"');
         SQL.Add('INNER JOIN "cap$maestrotitular" ON ("cap$tarjetacuenta".ID_AGENCIA = "cap$maestrotitular".ID_AGENCIA) AND');
         SQL.Add('("cap$tarjetacuenta".ID_TIPO_CAPTACION = "cap$maestrotitular".ID_TIPO_CAPTACION) AND ');
         SQL.Add('("cap$tarjetacuenta".NUMERO_CUENTA = "cap$maestrotitular".NUMERO_CUENTA) AND ("cap$tarjetacuenta".DIGITO_CUENTA = "cap$maestrotitular".DIGITO_CUENTA)');
         SQL.Add('INNER JOIN "gen$persona" ON ("cap$maestrotitular".ID_IDENTIFICACION = "gen$persona".ID_IDENTIFICACION) AND');
         SQL.Add('("cap$maestrotitular".ID_PERSONA = "gen$persona".ID_PERSONA)');
//         SQL.Add('where');
//         SQL.Add('( (FECHA_ASIGNACION = :FECHA) or ');
//         SQL.Add('(FECHA_BLOQUEO = :FECHA) or ');
//         SQL.Add('(FECHA_CANCELADA = :FECHA))');
         SQL.Add('ORDER BY ID_TARJETA');
//         ParamByName('FECHA').AsDate := EdFechaCorte.Date;
         try
          Open;
          if RecordCount < 1 then
           begin
            MessageDlg('No Existen Novedades para el Día',mtInformation,[mbok],0);
            chkTarjetas.Checked := True;
            chkCuentas.Checked := True;
            chkTarjetaCuenta.Checked := True;
            chkControl.Checked := True;
            CmdVer.Enabled := False;
            CmdEnviar.Enabled := False;
            Exit;
           end;
         except
           Transaction.Rollback;
           raise;
         end;

         Rewrite(AT);
         Rewrite(AC);
         Rewrite(ATC);
         Rewrite(ACT);
         Rewrite(ATN);

         ConteoAT := 0;
         ConteoAC := 0;
         ConteoATC := 0;
         ConteoACT := 0;
         ConteoTN := 0;


         while not Eof do begin

           IBSQL1.Close;
           IBSQL1.SQL.Clear;
           IBSQL1.SQL.Add('SELECT * FROM SALDO_ACTUAL_TD(:AG,:TP,:CTA,:DGT,:ANO,:FECHA1,:FECHA2)');
           IBSQL1.ParamByName('AG').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
           IBSQL1.ParamByName('TP').AsInteger := FieldByName('ID_TIPO_CAPTACION').AsInteger;
           IBSQL1.ParamByName('CTA').AsInteger := FieldByName('NUMERO_CUENTA').AsInteger;
           IBSQL1.ParamByName('DGT').AsInteger := FieldByName('DIGITO_CUENTA').AsInteger;
           IBSQL1.ParamByName('ANO').AsString := IntToStr(YearOf(EdFechaCorte.Date));
           IBSQL1.ParamByName('FECHA1').AsDate := EncodeDate(YearOf(EdFechaCorte.Date),01,01);
           IBSQL1.ParamByName('FECHA2').AsDate := EdFechaCorte.Date;
           try
             IBSQL1.ExecQuery;
             SaldoTotal := IBSQL1.FieldByName('SALDO_ACTUAL').AsCurrency;
           except
             Transaction.Rollback;
             raise;
           end;


           IBSQL1.Close;
           IBSQL1.SQL.Clear;
           IBSQL1.SQL.Add('SELECT * FROM SALDO_DISPONIBLE_TD(:AG,:TP,:CTA,:DGT,:ANO,:FECHA1,:FECHA2)');
           IBSQL1.ParamByName('AG').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
           IBSQL1.ParamByName('TP').AsInteger := FieldByName('ID_TIPO_CAPTACION').AsInteger;
           IBSQL1.ParamByName('CTA').AsInteger := FieldByName('NUMERO_CUENTA').AsInteger;
           IBSQL1.ParamByName('DGT').AsInteger := FieldByName('DIGITO_CUENTA').AsInteger;
           IBSQL1.ParamByName('ANO').AsString := IntToStr(YearOf(EdFechaCorte.Date));
           IBSQL1.ParamByName('FECHA1').AsDate := EncodeDate(YearOf(EdFechaCorte.Date),01,01);
           IBSQL1.ParamByName('FECHA2').AsDate := EdFechaCorte.Date;
           try
             IBSQL1.ExecQuery;
             SaldoDisponible := IBSQL1.FieldByName('SALDO_DISPONIBLE').AsCurrency;
           except
             Transaction.Rollback;
             raise;
           end;

           if SaldoTotal < 0 then SaldoTotal := 0;
           if SaldoDisponible < 0 then SaldoDisponible := 0;

           if FieldByName('ID_ESTADO').AsInteger = 3 then
//           if FieldByName('FECHA_CANCELADA').AsDateTime = Trunc(EdFechaCorte.Date) then
           begin
              Cadena := 'D:'+Bin+','+FieldByName('ID_TARJETA').AsString+','+'10'+','+','+','+','+','+
                        FieldByName('ID_PERSONA').AsString+','+FieldByName('PRIMER_APELLIDO').AsString+' '+
                        FieldByName('SEGUNDO_APELLIDO').AsString+' '+FieldByName('NOMBRE').AsString;
              Writeln(AT,Cadena);
              ConteoAT := ConteoAT + 1;
// Archivo de Cuentas
{              Cadena := 'D:'+Bin+','+Entidad+FieldByName('ID_TIPO_CAPTACION').AsString+Format('%.2d',[FieldByName('ID_AGENCIA').AsInteger])+
                        Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger])+','+
                        '10'+','+'170'+','+FormatCurr('#0',SaldoTotal)+'00'+','+
                        FormatCurr('#0',SaldoDisponible)+'00'+','+FormatCurr('#0',FieldByName('CUPO_ATM').AsCurrency)+'00,'+
                        Format('%d',[FieldByName('TRANS_ATM').AsInteger])+','+FormatCurr('#0',FieldByName('CUPO_POS').AsCurrency)+'00,'+
                        Format('%d',[FieldByName('TRANS_POS').AsInteger]);
}
              Cadena := 'D:'+Bin+','+Entidad+FieldByName('ID_TIPO_CAPTACION').AsString+Format('%.2d',[FieldByName('ID_AGENCIA').AsInteger])+
                        Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger])+','+
                        '10'+','+'170'+','+FormatCurr('#0',0)+'00'+','+
                        FormatCurr('#0',0)+'00'+','+FormatCurr('#0',0)+'00,'+
                        Format('%d',[0])+','+FormatCurr('#0',0)+'00,'+
                        Format('%d',[0]);

              Writeln(AC,Cadena);
              ConteoAC := ConteoAC + 1;
// Archivo de Tarjeta Cuenta
              Cadena := 'D:'+Bin+','+FieldByName('ID_TARJETA').AsString+','+Entidad+FieldByName('ID_TIPO_CAPTACION').AsString+Format('%.2d',[FieldByName('ID_AGENCIA').AsInteger])+
                        Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger])+','+'10'+','+'1';
              Writeln(ATC,Cadena);
              ConteoATC := ConteoATC + 1;

           end
           else
           if FieldByName('ID_ESTADO').AsInteger = 2 then
//           if FieldByName('FECHA_BLOQUEO').AsDateTime = Trunc(EdFechaCorte.Date) then
           begin
              Cadena := 'A:'+Bin+','+FieldByName('ID_TARJETA').AsString+','+'10'+','+','+','+','+','+
                        FieldByName('ID_PERSONA').AsString+','+FieldByName('PRIMER_APELLIDO').AsString+' '+
                        FieldByName('SEGUNDO_APELLIDO').AsString+' '+FieldByName('NOMBRE').AsString;
              Writeln(AT,Cadena);
              ConteoAT := ConteoAT + 1;
// Archivo de Cuentas
              Cadena := 'A:'+Bin+','+Entidad+FieldByName('ID_TIPO_CAPTACION').AsString+Format('%.2d',[FieldByName('ID_AGENCIA').AsInteger])+
                        Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger])+','+
                        '10'+','+'170'+','+FormatCurr('#0',0)+'00'+','+
                        FormatCurr('#0',0)+'00'+','+FormatCurr('#0',FieldByName('CUPO_ATM').AsCurrency)+'00,'+
                        Format('%d',[FieldByName('TRANS_ATM').AsInteger])+','+FormatCurr('#0',FieldByName('CUPO_POS').AsCurrency)+'00,'+
                        Format('%d',[FieldByName('TRANS_POS').AsInteger]);
              Writeln(AC,Cadena);
              ConteoAC := ConteoAC + 1;
// Archivo de Tarjeta Cuenta
              Cadena := 'A:'+Bin+','+FieldByName('ID_TARJETA').AsString+','+Entidad+FieldByName('ID_TIPO_CAPTACION').AsString+Format('%.2d',[FieldByName('ID_AGENCIA').AsInteger])+
                        Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger])+','+'10'+','+'1';
              Writeln(ATC,Cadena);
              ConteoATC := ConteoATC + 1;

           end
           else
//           if FieldByName('FECHA_ASIGNACION').AsString = DateToStr(EdFechaCorte.Date) then
           begin
// Archivo de Tarjetas
              Cadena := 'A:'+Bin+','+FieldByName('ID_TARJETA').AsString+','+'10'+','+','+','+','+','+
                        FieldByName('ID_PERSONA').AsString+','+FieldByName('PRIMER_APELLIDO').AsString+' '+
                        FieldByName('SEGUNDO_APELLIDO').AsString+' '+FieldByName('NOMBRE').AsString;
              Writeln(AT,Cadena);
              ConteoAT := ConteoAT + 1;
// Archivo de Cuentas
              Cadena := 'A:'+Bin+','+Entidad+FieldByName('ID_TIPO_CAPTACION').AsString+Format('%.2d',[FieldByName('ID_AGENCIA').AsInteger])+
                        Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger])+','+
                        '10'+','+'170'+','+FormatCurr('#0',SaldoTotal)+'00'+','+
                        FormatCurr('#0',SaldoDisponible)+'00'+','+FormatCurr('#0',FieldByName('CUPO_ATM').AsCurrency)+'00,'+
                        Format('%d',[FieldByName('TRANS_ATM').AsInteger])+','+FormatCurr('#0',FieldByName('CUPO_POS').AsCurrency)+'00,'+
                        Format('%d',[FieldByName('TRANS_POS').AsInteger]);
              Writeln(AC,Cadena);
              ConteoAC := ConteoAC + 1;
// Archivo de Tarjeta Cuenta
              Cadena := 'A:'+Bin+','+FieldByName('ID_TARJETA').AsString+','+Entidad+FieldByName('ID_TIPO_CAPTACION').AsString+Format('%.2d',[FieldByName('ID_AGENCIA').AsInteger])+
                        Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger])+','+'10'+','+'1';
              Writeln(ATC,Cadena);
              ConteoATC := ConteoATC + 1;
           end;
           Next;
         end;
        end;

        CloseFile(AC);
        CloseFile(AT);
        CloseFile(ATC);

// Archivo pedido tarjetas
        with IBSQL1 do begin
          Close;
          SQL.Clear;
          SQL.Add('select * from "cap$tarjetapedido" where FECHA_PEDIDO = :FECHA');

          ParamByName('FECHA').AsDate := EdFechaCorte.Date;
          try
           ExecQuery;
           if RecordCount > 0 then
             begin
               LineaPedido := FieldByName('ID_TARJETA_FINAL').AsString + '   ' + Format('%.6d',[FieldByName('CANTIDAD').AsInteger])+' ';
               ConteoTN := 1;
             end
           else
               LineaPedido := '';
          except
           Transaction.Rollback;
           raise;
          end;
          Close;

          Writeln(ATN,LineaPedido);
          CloseFile(ATN);
        end;
// Archivo de Control
        if ConteoAT > 0 then
           begin
            Tamano := ObtenerTamanoArchivo(FAT);
            Cadena := RightStr(FAT,14)+',0,'+IntToStr(Tamano)+',0,'+Format('%d',[ConteoAT]);
            Writeln(ACT,Cadena);
           end;

        if ConteoAC > 0 then
           begin
            Tamano := ObtenerTamanoArchivo(FAC);
            Cadena := RightStr(FAC,14)+',0,'+IntToStr(Tamano)+',0,'+Format('%d',[ConteoAC]);
            Writeln(ACT,Cadena);
           end;

        if ConteoATC > 0 then
           begin
            Tamano := ObtenerTamanoArchivo(FATC);
            Cadena := RightStr(FATC,14)+',0,'+IntToStr(Tamano)+',0,'+Format('%d',[ConteoATC]);
            Writeln(ACT,Cadena);
           end;

        if ConteoTN >= 0 then
           begin
            if ConteoTN = 0 then
              Tamano := 0
            else
              Tamano := ObtenerTamanoArchivo(FTN);
            Cadena := RightStr(FTN,14)+',0,'+IntToStr(Tamano)+',0,'+Format('%d',[ConteoTN]);
            Writeln(ACT,Cadena);
           end;

        CloseFile(ACT);

        chkTarjetas.Checked := True;
        chkCuentas.Checked := True;
        chkTarjetaCuenta.Checked := True;
        chkControl.Checked := True;


        CmdVer.Enabled := True;
        CmdEnviar.Enabled := True;

        MessageDlg('Proceso Culminado',mtInformation,[mbok],0);
end;

function TfrmTarjetasNovedades.ObtenerTamanoArchivo(const FileName: string): Int64;
var
  SizeLow, SizeHigh: DWord;
  hFile: THandle;
begin
  Result := 0;
  hFile := FileOpen(FileName, fmOpenRead);
  try
    if hFile <> 0 then
    begin
      SizeLow := Windows.GetFileSize(hFile, @SizeHigh);
      Result := (SizeHigh shl 32) + SizeLow;
    end;
  finally
    FileClose(hFile);
  end;
end;


procedure TfrmTarjetasNovedades.FormShow(Sender: TObject);
begin
        Edit1.Text := Pop3ServerMail1;
        Edit2.Text := Pop3ServerMail2;
        EdFechaCorte.Date := ffechaactual;
        EdMail.Text := SmtpServerTo;        
end;

procedure TfrmTarjetasNovedades.CmdVerClick(Sender: TObject);
begin
        ShellExecute(Handle, 'open', 'notepad.exe', PChar(FAT), nil, SW_SHOWNORMAL);
        ShellExecute(Handle, 'open', 'notepad.exe', PChar(FAC), nil, SW_SHOWNORMAL);
        ShellExecute(Handle, 'open', 'notepad.exe', PChar(FATC), nil, SW_SHOWNORMAL);
        ShellExecute(Handle, 'open', 'notepad.exe', PChar(FTN), nil, SW_SHOWNORMAL);
        ShellExecute(Handle, 'open', 'notepad.exe', PChar(FACT), nil, SW_SHOWNORMAL);
end;

procedure TfrmTarjetasNovedades.CmdEnviarClick(Sender: TObject);
var Zip :TAbZipper;
begin
       CmdEnviar.Enabled := False;
       EdEstado.Caption := 'Comprimiendo Archivo';
       Application.ProcessMessages;
// Comprimir Archivos
       Zip := TAbZipper.Create(nil);
       Zip.FileName := 'C:\Tdebito\Salida\'+FFF+'.Zip';
       Zip.ClearTags;
       Zip.AddFiles(FAT,0);
       Zip.AddFiles(FAC,0);
       Zip.AddFiles(FATC,0);
       Zip.AddFiles(FTN,0);
       Zip.AddFiles(FACT,0);
       Zip.Save;
       Zip.Free;

// Componer Mensaje

       EdEstado.Caption := 'Generando Correo...';
       Application.ProcessMessages;
       Msg.From.Text := SmtpServerFrom;
       Msg.Recipients.EMailAddresses := EdMail.Text+','+EdMailCCO.Text;
       Msg.ReceiptRecipient.Text := Msg.From.Text;
       Msg.Priority := TIdMessagePriority(0);
       Msg.Subject := 'Nov. convenio '+Entidad+' del día '+FormatDateTime('dd-mm-yyyy',EdFechaCorte.Date);
       Msg.Body.Add('Adjunto remitimos archivos de novedades para el día ' + FormatDateTime('dd-mm-yyyy',EdFechaCorte.Date));
       Msg.Body.Add('Correo generado '+FormatDateTime('dd-mm-yyyy hh:mm',fFechaHoraActual));
       Msg.Body.Add('');
       Msg.Body.Add('Gracias');
       Msg.Body.Add('Operador TDB Afinidad '+Empresa);
       TIdAttachment.Create(Msg.MessageParts, 'C:\Tdebito\Salida\'+FFF+'.Zip');

//
       EdEstado.Caption := 'Enviando Correo...';
       Application.ProcessMessages;

       if rb1.Checked then
       begin
         SmtpServerName := Pop3ServerName1;
         SmtpServerUser := Pop3ServerUser1;
         SmtpServerPassword := Pop3ServerPassword1;
       end
       else
       begin
         SmtpServerName := Pop3ServerName2;
         SmtpServerUser := Pop3ServerUser2;
         SmtpServerPassword := Pop3ServerPassword2;
       end;

       IdSMTP1.Host := SmtpServerName;
       IdSMTP1.Port := SmtpServerPort;
       IdSMTP1.UserId := SmtpServerUser;
       IdSMTP1.Password := SmtpServerPassword;
       IdSMTP1.Connect;
       try
         IdSMTP1.Send(Msg);
         IdSMTP1.Disconnect;
         EdEstado.Caption := 'Proceso culminado con exito!';
         MessageDlg('Mensaje enviado, confirme el proceso a través de la cuenta de correo. Gracias',mtInformation,[mbok],0);
       except
          IdSMTP1.Disconnect;
          EdEstado.Caption := 'Proceso culminado con ERROR!';
          MessageDlg('Error conectando al servidor de correo. Verifique!',mtError,[mbcancel],0);
          raise;
       end;

end;

end.
