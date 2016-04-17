type
   TXMLHead=Record
     szHead:array[0..2] of Char;
     nSize :array[0..3] of Byte;
     nCrc  :array[0..3] of Byte;
     vbKey :array[0..7] of Byte;
end;

const
//CAUSALES
C_COMPRA = 0;
C_RETIRO = 1;
C_ANULACION = 20;
C_CONSULTA1 = 30;
C_CONSULTA2 = 31;
//MENSAJES
M_PETICION = 200;
M_R_PETICION = 210;
M_A_PETICION = 220;
M_B_PETICION = 221;
M_R_A_PETICION = 230;
M_A_REVERSO = 420;
M_B_REVERSO = 421;
M_R_A_REVERSO = 430;
//ERRORES
E_BIEN = 0;
E_TARJETA_INVALIDA = 56;
E_FONDOS_INSUFICIENTES = 51;
E_TARJETA_VENCIDA = 54;


// Mostrar archivo en el TMemo
   UDPMemo.Text := ResCadena;
// Crear archivo XML

    EncaXML := '<?xml version="1.0" encoding="ISO-8859-1" ?> ';
    XmlString := EncaXML + ResCadena;
    XmlDoc := TsdXmlDocument.Create;
    XmlDoc.XmlFormat := xfReadable;
    XmlDoc.ReadFromString(XmlString);
    XMLMemo.Text := XmlDoc.WriteToString;

    HXMLNode := XmlDoc.Root.NodeByName('HEADER');
    HostRet := HXMLNode.ReadString('SOURCE');
//    SXMLNode := HXMLNode.NodeByName('SOURCE');
//    HostRet := SXMLNode.ValueAsString;
    DXMLNode := XmlDoc.Root.NodeByName('DATA');
    RXMLNode := DXMLNode.NodeByName('ROW');

// Tomar datos archivo XML
    if RXMLNode.ReadAttributeString('SOURCE') <> 'ATMPOS' then Exit; //agregar codigo de rechazo

    PuertoRet := RXMLNode.ReadAttributeInteger('PORT');
    IdRet := RXMLNode.ReadAttributeInteger('ID');
    Ano := YearOf(Date);
    Mes := StrToInt(LeftStr(RXMLNode.ReadAttributeString('DATE'),2));
    Dia := StrToInt(RightStr(RXMLNode.ReadAttributeString('DATE'),2));
    Hora := StrToInt(LeftStr(RXMLNode.ReadAttributeString('TIME'),2));
    Minuto := StrToInt(MidStr(RXMLNode.ReadAttributeString('TIME'),3,2));
    Segundo := StrToInt(RightStr(RXMLNode.ReadAttributeString('TIME'),2));
    SecuenciaRet := RXMLNode.ReadAttributeString('SECUENCE');
    Terminal := LeftStr(SecuenciaRet,8);
    Mensaje := RXMLNode.ReadAttributeInteger('MESSAGE');
    CausalRet := RXMLNode.ReadAttributeInteger('CAUSAL');
    ID_Tarjeta := RXMLNode.ReadAttributeString('CARD');
    RedRet := RXMLNode.ReadAttributeInteger('NET');
    MontoRet := RXMLNode.ReadAttributeInteger('AMMOUNT');

    AssignFile(Registro,'UDPServerTD.log');
    Append(Registro);

    XmlDoc.Free;
    Application.ProcessMessages;
// Buscar Cuenta de Tarjeta
    Conectar;
    IDT.IsolationLevel := xilREADCOMMITTED;
    IDT.TransactionID := IdRet;
    SQLConn.StartTransaction(IDT);
    SQLQ := TSQLQuery.Create(nil);
    SQLQ.SQLConnection := SQLConn;

// Mirar si el movimiento es de un Datafono
    IdCaja := 0;

    with SQLQ do begin
     Close;
     SQL.Clear;
     SQL.Add('select ID_CAJA from "caj$cajas" where DATAFONO = :DATAFONO');
     ParamByName('DATAFONO').AsString := Terminal;
     try
      Open;
      IdCaja := FieldByName('ID_CAJA').AsInteger;
     except
      Close;
      SQLConn.Rollback(IDT);
      Desconectar;
      Exit;
     end;
    end;

    Writeln(Registro,FormatDateTime('yyyy/mm/dd hh:mm:ss',Now)+':> Petición:Mensaje="'+IntToStr(Mensaje)+'" Causal="'+IntToStr(CausalRet)+'" Tarjeta="'+ID_Tarjeta+'" Secuencia="'+SecuenciaRet+'" '+
                      'Monto="'+CurrToStr(MontoRet)+'" Fecha="'+Format('%.4d',[Ano])+'/'+Format('%.2d',[Mes])+'/'+Format('%.2d',[Dia])+'" '+
                      'Hora="'+Format('%.2d',[Hora])+':'+Format('%.2d',[Minuto])+':'+Format('%.2d',[Segundo])+'"');
    Closefile(Registro);

    if IdCaja > 0 then
     LogMemo1.Lines.Add(FormatDateTime('yyyy/mm/dd hh:mm:ss',Now)+':> Petición:Mensaje="'+IntToStr(Mensaje)+'" Causal="'+IntToStr(CausalRet)+'" Tarjeta="'+ID_Tarjeta+'" Secuencia="'+SecuenciaRet+'" '+
                      'Monto="'+CurrToStr(MontoRet)+'" Fecha="'+Format('%.4d',[Ano])+'/'+Format('%.2d',[Mes])+'/'+Format('%.2d',[Dia])+'" '+
                      'Hora="'+Format('%.2d',[Hora])+':'+Format('%.2d',[Minuto])+':'+Format('%.2d',[Segundo])+'"')
    else
     LogMemo.Lines.Add(FormatDateTime('yyyy/mm/dd hh:mm:ss',Now)+':> Petición:Mensaje="'+IntToStr(Mensaje)+'" Causal="'+IntToStr(CausalRet)+'" Tarjeta="'+ID_Tarjeta+'" Secuencia="'+SecuenciaRet+'" '+
                      'Monto="'+CurrToStr(MontoRet)+'" Fecha="'+Format('%.4d',[Ano])+'/'+Format('%.2d',[Mes])+'/'+Format('%.2d',[Dia])+'" '+
                      'Hora="'+Format('%.2d',[Hora])+':'+Format('%.2d',[Minuto])+':'+Format('%.2d',[Segundo])+'"');

// Verificar si es un reintento
{
    if ( (Mensaje = M_A_PETICION) or
       (Mensaje = M_B_PETICION) or
       (Mensaje = M_B_REVERSO) ) then
    begin
      with SQLQ do begin
        Close;
        SQL.Clear;
        SQL.Add('select * from "cap$tarjetamovol" where');
        SQL.Add('FECHA = :FECHA and HORA = :HORA and ID_TARJETA = :ID_TARJETA and');
        SQL.Add('SECUENCIA = :SECUENCIA and MENSAJE = :MENSAJE and');
        SQL.Add('CAUSAL = :CAUSAL and MONTO = :MONTO');
        ParamByName('FECHA').AsDate := EncodeDate(Ano,Mes,Dia);
        ParamByName('HORA').AsTime :=  EncodeTime(Hora,Minuto,Segundo,0);
        ParamByName('ID_TARJETA').AsString := ID_Tarjeta;
        ParamByName('SECUENCIA').AsString := SecuenciaRet;
        ParamByName('MENSAJE').AsInteger := Mensaje;
        ParamByName('CAUSAL').AsInteger := CausalRet;
        ParamByName('MONTO').AsCurrency := MontoRet;
        try
         Open;
         Existe := False;
         While Not Eof do
         begin
           Existe := True;
           Next;
         end;
         if Existe then
         begin
          Close;
          SQLConn.Commit(IDT);
          XMLRMemo.Lines.Add('ya respondido');
          Desconectar;
          Exit;
         end
         else
          XMLRMemo.Lines.Add('no respondido');
        except
           Close;
           SQLConn.Rollback(IDT);
           Desconectar;
           Exit;
        end;
      end;
    end;
}
// Crear Respuesta

    with SQLQ do begin
      Close;
      SQL.Clear;
      SQL.Add('select * from "cap$tarjetacuenta" where');
      SQL.Add('ID_TARJETA = :ID_TARJETA');
      ParamByName('ID_TARJETA').AsString := LeftStr(ID_Tarjeta,16);
      try
       Open;
       if FieldByName('ID_TARJETA').AsString = '' then
          Error := E_TARJETA_INVALIDA;
       Estado := FieldByName('ID_ESTADO').AsInteger;
      except
       raise;
      end;

      If Error = 0 then
      begin
        Id_Agencia := FieldByName('ID_AGENCIA').AsInteger;
        Id_Tipo_Captacion := FieldByName('ID_TIPO_CAPTACION').AsInteger;
        Numero_Cuenta := FieldByName('NUMERO_CUENTA').AsInteger;
        Digito_Cuenta := FieldByName('DIGITO_CUENTA').AsInteger;
        CupoPos := FieldByName('CUPO_POS').AsCurrency;
        CupoAtm := FieldByName('CUPO_ATM').AsCurrency;
        Close;

        SQL.Clear;
        SQL.Add('select * from SALDOTD(:ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA)');
        ParamByName('ID_AGENCIA').AsInteger := Id_Agencia;
        ParamByName('ID_TIPO_CAPTACION').AsInteger := Id_Tipo_Captacion;
        ParamByName('NUMERO_CUENTA').AsInteger := Numero_Cuenta;
        ParamByName('DIGITO_CUENTA').AsInteger := Digito_Cuenta;
        try
         Open;
         Saldo := FieldByName('SALDO').AsCurrency;
         Disponible := FieldByName('DISPONIBLE').AsCurrency;
         if Estado = 2 then
         begin
            Saldo := 0;
            Disponible := 0;
         end;
        except
         raise;
        end;

        SQLConn.Commit(IDT);
// Verificar Reverso si existe original

    if //( (Mensaje = M_A_REVERSO) or
       ((Mensaje = M_B_REVERSO) ) then
       begin
        SQLConn.StartTransaction(IDT);
        Close;
        SQL.Clear;
        SQL.Add('select * from "cap$tarjetamovsdia" where');
        SQL.Add('ID_TARJETA = :ID_TARJETA and SECUENCIA = :SECUENCIA and');
        SQL.Add('MONTO = :MONTO');
        ParamByName('ID_TARJETA').AsString := Id_Tarjeta;
        ParamByName('SECUENCIA').AsString := SecuenciaRet;
        ParamByName('MONTO').AsCurrency := MontoRet;
        try
         Open;
         Existe := False;
         while not Eof do
         begin
          Existe := True;
          Next;
         end;
         SQLConn.Commit(IDT);
         if not Existe then
           MontoRet := 0;
         Close;
        except
          SQLConn.Rollback(IDT);
          raise;
        end;
       end;

// Preparar respuesta según Petición

/// Compras o Retiros
        if ((CausalRet = C_COMPRA) or
            (CausalRet = C_RETIRO)) then
        begin
//// Reversión a Operación Aumenta Disponible
           if ((Mensaje = M_A_REVERSO) or
               (Mensaje = M_B_REVERSO)) then
           begin
             Saldo := Saldo + MontoRet;
             Disponible := Disponible + MontoRet;
           end;
//// Operación Disminuye Disponible
           if ((Mensaje = M_PETICION) or
                (Mensaje = M_A_PETICION) or
                (Mensaje = M_B_PETICION)) then
           begin
            if Disponible < MontoRet then
             begin
              Error := E_FONDOS_INSUFICIENTES;
             end
            else
             begin
              Saldo := Saldo - MontoRet;
              Disponible := Disponible - MontoRet;
             end;
           end; // if Mensaje
        end; //if Causal
// Anulación a una operación anterior
        if (CausalRet = C_ANULACION) then
        begin
//// Petición de Anulación  Aumenta Disponible
          if ((Mensaje = M_PETICION) or
              (Mensaje = M_A_PETICION) or
              (Mensaje = M_B_PETICION)) then
          begin
            Saldo := Saldo + MontoRet;
            Disponible := Disponible + MontoRet;
          end;
//// Reversión a una Anulación Disminuye Disponible
          if (Mensaje = M_A_REVERSO) or (Mensaje = M_B_REVERSO) then
          begin
            Saldo := Saldo - MontoRet;
            Disponible := Disponible - MontoRet;
          end;
        end;
//
      end;//end del if Error
    end; //end with SQLQ

// Registrar movimientos de respuesta reintentos

    if ((Mensaje = M_A_PETICION) or
        (Mensaje = M_B_PETICION) or
        (Mensaje = M_B_REVERSO) ) then
    begin
      IDT.IsolationLevel := xilREADCOMMITTED;
      IDT.TransactionID := IdRet;
      SQLConn.StartTransaction(IDT);
      with SQLQ do begin
        Close;
        SQL.Clear;
        SQL.Add('insert into "cap$tarjetamovol" values(');
        SQL.Add(':FECHA, :HORA, :ID_TARJETA,');
        SQL.Add(':SECUENCIA, :MENSAJE,');
        SQL.Add(':CAUSAL, :MONTO ');
        SQL.Add(')');
        ParamByName('FECHA').AsDate := EncodeDate(Ano,Mes,Dia);
        ParamByName('HORA').AsTime :=  EncodeTime(Hora,Minuto,Segundo,0);
        ParamByName('ID_TARJETA').AsString := ID_Tarjeta;
        ParamByName('SECUENCIA').AsString := SecuenciaRet;
        ParamByName('MENSAJE').AsInteger := Mensaje;
        ParamByName('CAUSAL').AsInteger := CausalRet;
        ParamByName('MONTO').AsCurrency := MontoRet;
        try
         ExecSQL;
         SQLConn.Commit(IDT);
        except
         SQLConn.Rollback(IDT);
        end; // fin del try
      end; // fin del with
    end; // fin del if

// Aplicar Datos a "cap$tarjetamovsdia" si es el caso.

   if ((CausalRet = C_COMPRA) or (CausalRet = C_RETIRO)) and (Error = E_BIEN) and Aplicar then
   begin
      IDT.IsolationLevel := xilREADCOMMITTED;
      IDT.TransactionID := IdRet;
      SQLConn.StartTransaction(IDT);
      with SQLQ do begin
       SQL.Clear;
       SQL.Add('insert into "cap$tarjetamovsdia" VALUES(');
       SQL.Add(':ID_TARJETA,:SECUENCIA,:MONTO,:FECHA,:HORA,');
       SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA)');
       ParamByName('ID_TARJETA').AsString := LeftStr(ID_Tarjeta,16);
       ParamByName('SECUENCIA').AsString := SecuenciaRet;
       if (Mensaje = M_A_REVERSO) or (Mensaje = M_B_REVERSO) then
         MontoRet := -MontoRet;
       ParamByName('MONTO').AsCurrency := MontoRet;
       ParamByName('FECHA').AsDate := EncodeDate(Ano,Mes,Dia);
       ParamByName('HORA').AsTime  := EncodeTime(Hora,Minuto,Segundo,00);
       ParamByName('ID_AGENCIA').AsInteger := Id_Agencia;
       ParamByName('ID_TIPO_CAPTACION').AsInteger := Id_Tipo_Captacion;
       ParamByName('NUMERO_CUENTA').AsInteger := Numero_Cuenta;
       ParamByName('DIGITO_CUENTA').AsInteger := Digito_Cuenta;

       try
        if MontoRet <> 0 then
        begin
         ExecSQL;

// Validar si es por DataFono
         if IdCaja > 0 then begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "caj$movimiento" (');
          SQL.Add('ID_CAJA,');
          SQL.Add('FECHA_MOV,');
          SQL.Add('ID_AGENCIA,');
          SQL.Add('ID_TIPO_CAPTACION,');
          SQL.Add('NUMERO_CUENTA,');
          SQL.Add('DIGITO_CUENTA,');
          SQL.Add('ORIGEN_MOVIMIENTO,');
          SQL.Add('ID_TIPO_MOVIMIENTO,');
          SQL.Add('DOCUMENTO,');
          SQL.Add('CHEQUES_MOVIMIENTO,');
          SQL.Add('BILLETES,');
          SQL.Add('MONEDAS,');
          SQL.Add('CHEQUES,');
          SQL.Add('HUELLA');
          SQL.Add(') values (');
          SQL.Add(':ID_CAJA,');
          SQL.Add(':FECHA_MOV,');
          SQL.Add(':ID_AGENCIA,');
          SQL.Add(':ID_TIPO_CAPTACION,');
          SQL.Add(':NUMERO_CUENTA,');
          SQL.Add(':DIGITO_CUENTA,');
          SQL.Add(':ORIGEN_MOVIMIENTO,');
          SQL.Add(':ID_TIPO_MOVIMIENTO,');
          SQL.Add(':DOCUMENTO,');
          SQL.Add(':CHEQUES_MOVIMIENTO,');
          SQL.Add(':BILLETES,');
          SQL.Add(':MONEDAS,');
          SQL.Add(':CHEQUES,');
          SQL.Add(':HUELLA');
          SQL.Add(')');
          ParamByName('ID_CAJA').AsInteger := IdCaja;
          ParamByName('FECHA_MOV').AsDateTime := EncodeDateTime(Ano,Mes,Dia,Hora,Minuto,Segundo,00);
          ParamByName('ID_AGENCIA').AsInteger := Id_Agencia;
          ParamByName('ID_TIPO_CAPTACION').AsInteger := Id_Tipo_Captacion;
          ParamByName('NUMERO_CUENTA').AsInteger := Numero_Cuenta;
          ParamByName('DIGITO_CUENTA').AsInteger := Digito_Cuenta;
          ParamByName('ORIGEN_MOVIMIENTO').AsInteger := 10;
          ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 2;
          ParamByName('DOCUMENTO').AsString := SecuenciaRet;
          ParamByName('CHEQUES_MOVIMIENTO').AsInteger := 0;
          ParamByName('BILLETES').AsCurrency := MontoRet;
          ParamByName('MONEDAS').AsCurrency := 0;
          ParamByName('CHEQUES').AsCurrency := 0;
          ParamByName('HUELLA').AsInteger := 0;
          try
           ExecSQL;
// Aplicar Transacción
          except
           SQLConn.Rollback(IDT);
          end;
         end;
         SQLConn.Commit(IDT);
        end;
       except
         SQLConn.Rollback(IDT);
       end; // fin try
      end; // fin with
    end; // fin if   compra o retiro

// Registrar operaciones no aplicadas.
// Fin Registro

   if (CausalRet = C_ANULACION) and (Error = E_BIEN) and Aplicar then
   begin
      IDT.IsolationLevel := xilREADCOMMITTED;
      IDT.TransactionID := IdRet;
      SQLConn.StartTransaction(IDT);
      with SQLQ do begin
       SQL.Clear;
       SQL.Add('insert into "cap$tarjetamovsdia" VALUES(');
       SQL.Add(':ID_TARJETA,:SECUENCIA,:MONTO,:FECHA,:HORA,');
       SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA)');
       ParamByName('ID_TARJETA').AsString := LeftStr(ID_Tarjeta,16);
       ParamByName('SECUENCIA').AsString := SecuenciaRet;
       if Mensaje in [M_PETICION,M_A_PETICION,M_B_PETICION] then
          MontoRet := -MontoRet
       else
       if ( Mensaje = M_A_REVERSO)  or (Mensaje = M_B_REVERSO) then
          MontoRet := MontoRet;
       ParamByName('MONTO').AsCurrency := MontoRet;
       ParamByName('FECHA').AsDate := EncodeDate(Ano,Mes,Dia);
       ParamByName('HORA').AsTime  := EncodeTime(Hora,Minuto,Segundo,00);
       ParamByName('ID_AGENCIA').AsInteger := Id_Agencia;
       ParamByName('ID_TIPO_CAPTACION').AsInteger := Id_Tipo_Captacion;
       ParamByName('NUMERO_CUENTA').AsInteger := Numero_Cuenta;
       ParamByName('DIGITO_CUENTA').AsInteger := Digito_Cuenta;

       try
        if MontoRet <> 0 then
        begin
         ExecSQL;
         SQLConn.Commit(IDT);
        end;
       except
         SQLConn.Rollback(IDT);

// Registrar operaciones no aplicadas.
// Fin Registro
       end; // fin try
      end; // fin with
    end; // fin if anulación
except
  raise;
end;

// Cerrar conexion
 Desconectar;

// Crear XML
    XMLString := '<TRANSA><HEADER><SOURCE>0.0.0.0</SOURCE></HEADER>';
    XMLString := XMLString + '<FIELDS></FIELDS><DATA><ROW ';
    XMLString := XMLString + 'ID="'+IntToStr(IdRet)+'" ';
    XMLString := XMLString + 'CARD="'+Trim(ID_Tarjeta)+'" ';
    if Mensaje = M_PETICION then
       MensajeRet := M_R_PETICION
    else
    if (Mensaje = M_A_PETICION) or (Mensaje = M_B_PETICION) then
       MensajeRet := M_R_A_PETICION
    else
    if (Mensaje = M_A_REVERSO) OR (Mensaje = M_B_REVERSO) then
       MensajeRet := M_R_A_REVERSO
    else
       MensajeRet := 000;

    XMLString := XMLString + 'MESSAGE="'+ IntToStr(MensajeRet)+'" ';

//
    XMLString := XMLString + 'ERROR="'+Format('%.2d',[Error])+'" ';
    XMLString := XMLString + 'AMMOUNT1="'+FormatCurr('#0',Saldo)+'" ';
    XMLString := XMLString + 'AMMOUNT2="'+FormatCurr('#0',Disponible)+'" ';
    XMLString := XMLString + '/></DATA></TRANSA>';

    XMLRMemo.Text := XMLString;

    DataString := TextToHex(XMLString);//,Length(XMLString));
    if (Length(DataString) mod 16 <> 0) then
    begin
         j := 16 - (Length(DataString) mod 16);
         for i := 1 to j do
          DataString := DataString + '0';
    end;

    DataString := DESCipher(DataString,KeyRet,True);
    KeyString  := DESCipher(KeyRet,'0123456789ABCDEF',True);

    EncaXMLRet.szHead := 'XML';
    Pint := Addr(EncaXMLRet.nSize);
    Pint^:= Length(DataString) div 2;
    Pint := Addr(EncaXMLRet.nCrc);
    Pint^:= 0;

    for i := 0 to 7 do
     EncaXMLRet.vbKey[i] := StrToInt('$'+MidStr(KeyString,i*2+1,2));

    PByte := @EncaXMLRet;
    for i := 0 to 18 do
    begin
      Buffer[i] := PByte^;
      Inc(PByte);
    end;

    j := (Length(DataString) div 2)-1;

    for i := 0 to j do
    begin
     Hex := MidStr(DataString,i*2+1,2);
     Buffer[19+i] := StrToInt('$'+Hex);
    end;

    i := i + 19;
    XMLRMemo.Lines.Add('Armando respuesta');
// Enviar Respuesta
    UDPServer.SendBuffer(HostR,PuertoRet,Buffer,i);

    AssignFile(Registro,'UDPServerTD.log');
    Append(Registro);
    Writeln(Registro,FormatDateTime('yyyy/mm/dd hh:mm:ss',Now)+':> Respuesta:Mensaje="'+IntToStr(MensajeRet)+
                      '" Error="'+Format('%.2d',[Error])+'" Tarjeta="'+ID_Tarjeta+'" '+
                      'Saldo="'+FormatCurr('#,0.00',Saldo)+'" Disponible="'+FormatCurr('#,0.00',Disponible)+
                      '" CupoPOS="'+FormatCurr('#,0.00',CupoPOS)+'" CupoATM="'+FormatCurr('#,0.00',CupoATM)+'"');

    if IdCaja > 0 then
     Logmemo1.Lines.Add(FormatDateTime('yyyy/mm/dd hh:mm:ss',Now)+':> Respuesta:Mensaje="'+IntToStr(MensajeRet)+
                      '" Error="'+Format('%.2d',[Error])+'" Tarjeta="'+ID_Tarjeta+'" '+
                      'Saldo="'+FormatCurr('#,0.00',Saldo)+'" Disponible="'+FormatCurr('#,0.00',Disponible)+
                      '" CupoPOS="'+FormatCurr('#,0.00',CupoPOS)+'" CupoATM="'+FormatCurr('#,0.00',CupoATM)+'"')
    else
     Logmemo.Lines.Add(FormatDateTime('yyyy/mm/dd hh:mm:ss',Now)+':> Respuesta:Mensaje="'+IntToStr(MensajeRet)+
                      '" Error="'+Format('%.2d',[Error])+'" Tarjeta="'+ID_Tarjeta+'" '+
                      'Saldo="'+FormatCurr('#,0.00',Saldo)+'" Disponible="'+FormatCurr('#,0.00',Disponible)+
                      '" CupoPOS="'+FormatCurr('#,0.00',CupoPOS)+'" CupoATM="'+FormatCurr('#,0.00',CupoATM)+'"');

    CloseFile(Registro);

end;

procedure TUDPMainForm.BitBtn1Click(Sender: TObject);
begin
        if UDPServer.Active then
           UDPServer.Active := False;
        Close;
end;

procedure TUDPMainForm.Timer1Timer(Sender: TObject);
begin
 if UDPServer.Active then
     label6.Caption := 'Activo'
  else
     label6.Caption := 'InActivo';
  label2.Caption := DateTimeToStr(Now);
end;

end.