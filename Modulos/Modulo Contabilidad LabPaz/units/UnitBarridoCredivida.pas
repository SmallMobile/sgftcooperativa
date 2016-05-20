unit UnitBarridoCredivida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DB, DBClient, StdCtrls, Buttons, IBSQL,
  IBCustomDataSet, IBQuery, IBStoredProc,DateUtils,jcldatetime, DBCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, sdXmlDocuments;

type
  TFrmBarridoCredivida = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    DScredivida: TDataSource;
    DBcredivida: TClientDataSet;
    DBcredividanombre: TStringField;
    DBcredividacuenta: TIntegerField;
    DBcredividadg: TIntegerField;
    DBcredividavalor: TCurrencyField;
    DBcredividadescontar: TBooleanField;
    Label1: TLabel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Panel3: TPanel;
    IBSQL1: TIBSQL;
    IBQuery1: TIBQuery;
    IBProc: TIBStoredProc;
    Label2: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBcredividaid_persona: TStringField;
    DBcredividadireccion: TStringField;
    DBcredividatelefono: TStringField;
    DBcredividaciudad: TStringField;
    DBcredividaciudad_nacimiento: TStringField;
    DBcredividafecha_nacimiento: TDateField;
    IdTCPClient1: TIdTCPClient;
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
  private
  vCrediVida :Currency;
  vNotaContable :Integer;
    procedure ahorros(numero_cuenta, digito: Integer;consecutivo :string);
    { Private declarations }
  public
    { Public declarations }
  end;
                         
var
  FrmBarridoCredivida: TFrmBarridoCredivida;

implementation
uses UnitGlobales, UnitPantallaProgreso;

{$R *.dfm}

procedure TFrmBarridoCredivida.BitBtn1Click(Sender: TObject);
var     vSaldo :Currency;
        direccion,telefono,ciudad :string;
begin
        DBcredivida.CancelUpdates;
        with IBQuery1 do
        begin
          if Transaction.InTransaction then
             Transaction.Rollback;
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"gen$minimos".VALOR_MINIMO');
          SQL.Add('FROM');
          SQL.Add('"gen$minimos"');
          SQL.Add('WHERE');
          SQL.Add('("gen$minimos".ID_MINIMO = 5)');
          Open;
          vCrediVida := FieldByName('VALOR_MINIMO').AsCurrency;
          Label2.Visible := True;
          Label2.Caption := 'Valor Credivida : $' + FormatCurr('#,#',vCrediVida);
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"cap$maestrotitular".ID_IDENTIFICACION,');
          SQL.Add('"cap$maestrotitular".ID_PERSONA,');
          SQL.Add('"col$credivida".NUMERO_CUENTA,');
          SQL.Add('"col$credivida".DG_CUENTA');
          SQL.Add('FROM');
          SQL.Add('"cap$maestrotitular"');
          SQL.Add('INNER JOIN "col$credivida" ON ("cap$maestrotitular".NUMERO_CUENTA="col$credivida".NUMERO_CUENTA)');
          SQL.Add('AND ("cap$maestrotitular".DIGITO_CUENTA="col$credivida".DG_CUENTA)');
          SQL.Add('WHERE');
          SQL.Add('("cap$maestrotitular".ID_TIPO_CAPTACION = 2) AND ');
          SQL.Add('("col$credivida".FECHA_VENCIMIENTO = :HOY) AND ');
          SQL.Add('("col$credivida".APLICADO = 0)');
          ParamByName('HOY').AsDate := fFechaActual;
          Open;
          if RecordCount = 0 then
          begin
            MessageDlg('No Existen Credividas Vencidos a la Fecha',mtInformation,[mbok],0);
            Exit;
          end;
          Last;
          First;
          frmProgreso := TfrmProgreso.Create(self);
          frmProgreso.Titulo := 'Barrido de Credividas. Registros Encontrados : ' + IntToStr(RecordCount);
          frmProgreso.Max := RecordCount;
          frmProgreso.Min := 0;
          frmProgreso.Ejecutar;
          while not Eof do
          begin
             frmProgreso.Position := RecNo;
             frmProgreso.InfoLabel := 'Registro Número : ' + IntToStr(RecNo);
             Application.ProcessMessages;
             IBProc.Prepare;
             IBProc.Params[1].AsInteger := Agencia;
             IBProc.Params[2].AsInteger := 2;
             IBProc.Params[3].AsInteger := FieldByName('NUMERO_CUENTA').AsInteger;
             IBProc.Params[4].AsInteger := FieldByName('DG_CUENTA').AsInteger;
             IBProc.Params[5].AsInteger := YearOfDate(fFechaActual);
             IBProc.Params[6].AsDateTime := EncodeDate(YearOf(fFechaActual),01,01);
             IBProc.Params[7].AsDateTime := EncodeDate(YearOf(fFechaActual),12,31);
             IBProc.ExecProc;
             vSaldo := IBProc.Params[0].AsCurrency;
             IBSQL1.Close;
             IBSQL1.SQL.Clear;
             IBSQL1.SQL.Add('SELECT ');
             IBSQL1.SQL.Add('"gen$direccion".MUNICIPIO,');
             IBSQL1.SQL.Add('"gen$direccion".DIRECCION,');
             IBSQL1.SQL.Add('"gen$direccion".TELEFONO1');
             IBSQL1.SQL.Add('FROM');
             IBSQL1.SQL.Add('"gen$direccion"');
             IBSQL1.SQL.Add('WHERE');
             IBSQL1.SQL.Add('("gen$direccion".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND ');
             IBSQL1.SQL.Add('("gen$direccion".ID_PERSONA = :ID_PERSONA) AND ');
             IBSQL1.SQL.Add('("gen$direccion".ID_DIRECCION = 1)');
             IBSQL1.ParamByName('ID_PERSONA').AsString := FieldByName('ID_PERSONA').AsString;
             IBSQL1.ParamByName('ID_IDENTIFICACION').AsInteger := FieldByName('ID_IDENTIFICACION').AsInteger;
             IBSQL1.ExecQuery;
             direccion := IBSQL1.FieldByName('DIRECCION').AsString;
             telefono := IBSQL1.FieldByName('TELEFONO1').AsString;
             ciudad := IBSQL1.FieldByName('MUNICIPIO').AsString;
             IBSQL1.Close;
             IBSQL1.SQL.Clear;
             IBSQL1.SQL.Add('SELECT NOMBRE,PRIMER_APELLIDO,SEGUNDO_APELLIDO,FECHA_NACIMIENTO,LUGAR_NACIMIENTO FROM "gen$persona" WHERE ID_PERSONA = :ID_PERSONA AND ID_IDENTIFICACION = :ID_IDENTIFICACION');
             IBSQL1.ParamByName('ID_PERSONA').AsString := FieldByName('ID_PERSONA').AsString;
             IBSQL1.ParamByName('ID_IDENTIFICACION').AsInteger := FieldByName('ID_IDENTIFICACION').AsInteger;
             IBSQL1.ExecQuery;
             DBcredivida.Append;
             DBcredivida.FieldValues['nombre'] := IBSQL1.FieldByName('NOMBRE').AsString + ' ' + IBSQL1.FieldByName('PRIMER_APELLIDO').AsString + ' ' + IBSQL1.FieldByName('SEGUNDO_APELLIDO').AsString;
             DBcredivida.FieldValues['cuenta'] := FieldByName('NUMERO_CUENTA').AsInteger;
             DBcredivida.FieldValues['dg'] := FieldByName('DG_CUENTA').AsInteger;
             DBcredivida.FieldValues['valor'] := vSaldo;
             DBcredivida.FieldValues['direccion'] := direccion;
             DBcredivida.FieldValues['telefono'] := telefono;
             DBcredivida.FieldValues['ciudad'] := ciudad;
             DBcredivida.FieldValues['ciudad_nacimiento'] := IBSQL1.FieldByName('LUGAR_NACIMIENTO').AsString;
             DBcredivida.FieldValues['fecha_nacimiento'] := IBSQL1.FieldByName('FECHA_NACIMIENTO').AsDateTime;
             if vSaldo > vCrediVida then
               DBcredivida.FieldValues['descontar'] := True
             else
               DBcredivida.FieldValues['descontar'] := False;
             DBcredivida.Post;
             Next;
          end;
          frmProgreso.Cerrar;
          BitBtn1.Enabled := False;
          BitBtn2.Enabled := True;
        end;
end;

procedure TFrmBarridoCredivida.DBGrid1ColExit(Sender: TObject);
begin
 if DBGrid1.SelectedField.FieldName = DBCheckBox1.DataField then
    DBCheckBox1.Visible := False

end;

procedure TFrmBarridoCredivida.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const IsChecked : array[Boolean] of Integer = 
      (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);  
var
  DrawState: Integer;
  DrawRect: TRect;
begin
  if (gdFocused in State) then
  begin
    if (Column.Field.FieldName = DBCheckBox1.DataField) then
    begin
     DBCheckBox1.Left := Rect.Left + DBGrid1.Left + 2;
     DBCheckBox1.Top := Rect.Top + DBGrid1.top + 2;
     DBCheckBox1.Width := Rect.Right - Rect.Left;
     DBCheckBox1.Height := Rect.Bottom - Rect.Top;
     DBCheckBox1.Visible := True;
    end
  end
  else
  begin
    if (Column.Field.FieldName = DBCheckBox1.DataField) then
    begin
      DrawRect:=Rect;
      InflateRect(DrawRect,-1,-1);

      DrawState := ISChecked[Column.Field.AsBoolean];

      DBGrid1.Canvas.FillRect(Rect);
      DrawFrameControl(DBGrid1.Canvas.Handle, DrawRect,
                       DFC_BUTTON, DrawState);
    end;
  end;
end;

procedure TFrmBarridoCredivida.BitBtn2Click(Sender: TObject);
var     v_certificado: string;
        XmlDoc, Rdoc :TsdXmlDocument;
        Nodo: TXmlNode;
begin
        if MessageDlg('Esta Seguro de Realizar la Transaccion',mtInformation,[mbyes,mbno],0) = mryes then
        begin
          BitBtn2.Enabled := False;
          BitBtn3.Enabled := True;
          with DBcredivida do
          begin
            Filtered := False;
            Filter := 'descontado = True';
            Filtered := True;
            while not Eof do
            begin
//            v_certificado := con_equivida;
            XmlDoc := TsdXmlDocument.CreateName('equivida');
            XmlDoc.EncodingString := 'ISO8859-1';
            XmlDoc.XmlFormat := xfReadable;
            Nodo := XmlDoc.Root.NodeNew('registro');
            with Nodo do
            begin
              WriteString('cedula',FieldByName('id_persona').AsString);
              WriteString('nombre',FieldByName('nombre').AsString);
              WriteString('direccion',FieldByName('direccion').AsString);
              WriteString('telefono',FieldByName('telefono').AsString);
              WriteString('consecutivo',v_certificado);
              WriteString('ciudad',FieldByName('Ciudad').AsString);
              WriteString('ciudad_nacimiento',FieldByName('ciudad_nacimiento').AsString);
              //WriteString('fecha_nacimiento',FormatCurr('dd-mm-yy',FieldByName('fecha_nacimineto').AsDateTime);
            end;
            Next;
            end;
          end;
        end;
end;

procedure TFrmBarridoCredivida.BitBtn4Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmBarridoCredivida.ahorros(numero_cuenta, digito: Integer;consecutivo :string);
begin
          with IBQuery1 do
           begin
             SQL.Clear;
             SQL.Add('insert into "cap$extracto" values(');
             SQL.Add(':"ID_AGENCIA",:"ID_TIPO_CAPTACION",:"NUMERO_CUENTA",');
             SQL.Add(':"DIGITO_CUENTA",:"FECHA_MOVIMIENTO",:"HORA_MOVIMIENTO",');
             SQL.Add(':"ID_TIPO_MOVIMIENTO",:"DOCUMENTO_MOVIMIENTO",:"DESCRIPCION_MOVIMIENTO",');
             SQL.Add(':"VALOR_DEBITO",:"VALOR_CREDITO")');
             ParamByName('ID_AGENCIA').AsInteger := Agencia;
             ParamByName('ID_TIPO_CAPTACION').AsInteger := 2;
             ParamByName('NUMERO_CUENTA').AsInteger := numero_cuenta;
             ParamByName('DIGITO_CUENTA').AsInteger := digito;
             ParamByName('FECHA_MOVIMIENTO').AsDateTime := fFechaActual;
             ParamByName('HORA_MOVIMIENTO').AsTime := Time;
             ParamByName('ID_TIPO_MOVIMIENTO').AsInteger := 6;
             ParamByName('DOCUMENTO_MOVIMIENTO').AsString := IntToStr(vNotaContable);
             ParamByName('DESCRIPCION_MOVIMIENTO').AsString := 'RETIRO POR BARRIDO CREDIVIDA No. ' + consecutivo;
             ParamByName('VALOR_DEBITO').AsCurrency := 0;
             ParamByName('VALOR_CREDITO').AsCurrency := vCrediVida;
             try
               ExecSQL;
               Transaction.CommitRetaining;
             except
             begin
               MessageDlg('Error Retirando de Ahorros',mtError,[mbok],0);
               Exit;
             end;
             end;
             Close;
           end;
end;

end.
