unit UnitAyudaManual;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBDatabase, JvBaseDlg, JvLoginDlg, JvComponent,
  JvPasswordForm, IBSQL, JvEdit, JvTypedEdit, StdCtrls, Buttons, DBCtrls,
  ExtCtrls, ComCtrls, JvStaticText, IBCustomDataSet, IBQuery, JvLabel, DateUtils;

type
  TFrmAyudaManual = class(TForm)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    jv: TJvLoginDlg;
    PageControl1: TPageControl;
    TabAportes: TTabSheet;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    PageControl4: TPageControl;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    DBLCBTipoDocumento: TDBLookupComboBox;
    EdDocumento: TEdit;
    CmdBuscarAsociadoDocumento: TBitBtn;
    TabSheet5: TTabSheet;
    Label2: TLabel;
    EdCuentaAportes: TJvIntegerEdit;
    CmdBuscarAsociadoCuenta: TBitBtn;
    TabJuvenil: TTabSheet;
    GroupBox2: TGroupBox;
    PageControl5: TPageControl;
    TabBuscarDocumentoAsociadoJuvenil: TTabSheet;
    Label7: TLabel;
    DBLCBTipoDocumentoJuvenil: TDBLookupComboBox;
    EdDocumentoJuvenil: TEdit;
    CmdBuscarJuvenilDoc: TBitBtn;
    TabSheet6: TTabSheet;
    Label8: TLabel;
    EdCuentaJuvenil: TJvIntegerEdit;
    CmdBuscarJuvenilCuenta: TBitBtn;
    IBSQL1: TIBSQL;
    IBQTiposDocumentos: TIBQuery;
    DSTiposDocumento: TDataSource;
    Panel2: TPanel;
    Label3: TLabel;
    EdnombreAsociado: TJvStaticText;
    Label4: TLabel;
    Cuenta: TJvStaticText;
    Panel3: TPanel;
    BTregistra: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    JVvalor: TJvCurrencyEdit;
    DBayudas: TDBLookupComboBox;
    IBQuery1: TIBQuery;
    DataSource1: TDataSource;
    IBQuery2: TIBQuery;
    Label9: TLabel;
    JVjuvenil: TJvCurrencyEdit;
    JvLabel1: TJvLabel;
    JVnombre: TJvStaticText;
    procedure FormCreate(Sender: TObject);
    procedure CmdBuscarAsociadoDocumentoClick(Sender: TObject);
    procedure CmdBuscarAsociadoCuentaClick(Sender: TObject);
    procedure CmdBuscarJuvenilDocClick(Sender: TObject);
    procedure CmdBuscarJuvenilCuentaClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBLCBTipoDocumentoKeyPress(Sender: TObject; var Key: Char);
    procedure TabAportesShow(Sender: TObject);
    procedure EdDocumentoKeyPress(Sender: TObject; var Key: Char);
    procedure EdCuentaAportesKeyPress(Sender: TObject; var Key: Char);
    procedure DBLCBTipoDocumentoJuvenilKeyPress(Sender: TObject;
      var Key: Char);
    procedure EdDocumentoJuvenilKeyPress(Sender: TObject; var Key: Char);
    procedure EdCuentaJuvenilKeyPress(Sender: TObject; var Key: Char);
    procedure TabBuscarDocumentoAsociadoJuvenilShow(Sender: TObject);
    procedure JVvalorEnter(Sender: TObject);
    procedure JVvalorKeyPress(Sender: TObject; var Key: Char);
    procedure DBayudasKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure BTregistraClick(Sender: TObject);
    procedure JVjuvenilKeyPress(Sender: TObject; var Key: Char);
    procedure JVjuvenilEnter(Sender: TObject);
    procedure IBDatabase1BeforeConnect(Sender: TObject);
  private
  Ag,Tp,Nm,Dg :Integer;
  Agj,Tpj,Nmj,Dgj :Integer;
    es_juvenil: Boolean;
    procedure EnterTabs(var Key: Char; oSelf: TForm);
    { Private declarations }
  public
    procedure Limpiar;
    { Public declarations }
  end;

var
  FrmAyudaManual: TFrmAyudaManual;

implementation

{$R *.dfm}

procedure TFrmAyudaManual.FormCreate(Sender: TObject);
var veces : Integer;
begin
//        JV.Execute;
        IBDatabase1.DataBaseName := '192.168.200.254:/dbase/fbird/database.fdb';
        IBDatabase1.Params.Values['sql_role_name'] := 'FUNDACION';
        //IBDatabase1.Params.Values['User_Name'] := 'sysdba';//LowerCase(jv.Username);
        //IBDatabase1.Params.Values['PassWord'] := 'masterkey';//LowerCase(jv.Password);

        while not IBDatabase1.Connected do
        begin
          try
            veces := veces + 1;
            if veces = 3 then
            begin
               Application.Terminate;
               Exit;
            end;
            IBDatabase1.Connected := True;
            IBTransaction1.Active := True;
          except
          begin
             MessageDlg('Usuario o Password Incorrectos',mtWarning,[mbok],0);
             IBDatabase1.Connected := False;
//             Exit;
          end;
          end;
        end;
        IBQTiposDocumentos.Open;
        IBQTiposDocumentos.Last;
        IBQuery1.Open;
        IBQuery1.Last;
        Self.Caption := IBDatabase1.DatabaseName;
        PageControl1.ActivePage := TabAportes;
        PageControl4.ActivePage := TabSheet2;
end;

procedure TFrmAyudaManual.CmdBuscarAsociadoDocumentoClick(Sender: TObject);
begin
        with IBSQL1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select PRIMER_APELLIDO,SEGUNDO_APELLIDO,NOMBRE,EDUCACION,FOTO from "gen$persona" where ID_IDENTIFICACION = :ID and');
          SQL.Add('ID_PERSONA = :PERSONA');
          ParamByName('ID').AsInteger := DBLCBTipoDocumento.KeyValue;
          ParamByName('PERSONA').AsString := EdDocumento.Text;
          ExecQuery;
           if RecordCount > 0 then begin
              EdNombreAsociado.Caption := FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                          FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                          FieldByName('NOMBRE').AsString;
           end;
          Close;
          SQL.Clear;
          SQL.Add('select "cap$maestrotitular".ID_AGENCIA,"cap$maestrotitular".ID_TIPO_CAPTACION,"cap$maestrotitular".NUMERO_CUENTA,"cap$maestrotitular".DIGITO_CUENTA from "cap$maestrotitular"');
          SQL.Add('inner join "cap$maestro" ON ("cap$maestro".ID_AGENCIA = "cap$maestrotitular".ID_AGENCIA and "cap$maestro".ID_TIPO_CAPTACION = "cap$maestrotitular".ID_TIPO_CAPTACION and');
          SQL.Add('"cap$maestro".NUMERO_CUENTA = "cap$maestrotitular".NUMERO_CUENTA and "cap$maestro".DIGITO_CUENTA = "cap$maestrotitular".DIGITO_CUENTA)');
          SQL.Add('inner join "cap$tiposestado" ON ("cap$maestro".ID_ESTADO = "cap$tiposestado".ID_ESTADO)');
          SQL.Add('where');
          SQL.Add('ID_IDENTIFICACION = :ID_IDENTIFICACION and ID_PERSONA = :ID_PERSONA and NUMERO_TITULAR = 1 and "cap$tiposestado".SE_SUMA <> 0');
          SQL.Add('order by "cap$maestrotitular".ID_AGENCIA ASC,"cap$maestrotitular".ID_TIPO_CAPTACION ASC,"cap$maestrotitular".NUMERO_CUENTA ASC,"cap$maestrotitular".DIGITO_CUENTA');ParamByName('ID_IDENTIFICACION').AsInteger := DBLCBTipoDocumento.KeyValue;
          ParamByName('ID_PERSONA').AsString := EdDocumento.Text;
          ExecQuery;
             if IBSQL1.RecordCount > 0 then
             begin
                   Ag := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
                   Tp := IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                   Nm := IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger;
                   Dg := IBSQL1.FieldByName('DIGITO_CUENTA').AsInteger;
                   Cuenta.Caption := IntToStr(Tp) + '0' + IntToStr(Ag) + '-' + FormatCurr('000000',Nm);
             end
             else
             begin
              MessageDlg('Asociado no Encontrado',mtInformation,[mbok],0);
              Exit;
             end;
        end;
        JVvalor.SetFocus;
        BTregistra.Enabled := True;
        es_juvenil := False;
        PageControl4.Enabled := False;
        PageControl5.Enabled := False;        
end;

procedure TFrmAyudaManual.CmdBuscarAsociadoCuentaClick(Sender: TObject);
begin
        with IBSQL1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select ID_IDENTIFICACION,ID_PERSONA from "cap$maestrotitular" Where');
          SQL.Add('ID_TIPO_CAPTACION = 1 and NUMERO_CUENTA = :NUMERO_CUENTA and NUMERO_TITULAR = 1');
          ParamByName('NUMERO_CUENTA').AsInteger := EdCuentaAportes.Value;
            ExecQuery;
            if RecordCount > 0 then
            begin
              DBLCBTipoDocumento.KeyValue := FieldByName('ID_IDENTIFICACION').AsInteger;
              EdDocumento.Text := FieldByName('ID_PERSONA').AsString;
              CmdBuscarAsociadoDocumento.Click;
            end;
        end;

end;

procedure TFrmAyudaManual.CmdBuscarJuvenilDocClick(Sender: TObject);
var    id_persona :string;
       id_identificacion :Integer;
begin
        with IBSQL1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select PRIMER_APELLIDO,SEGUNDO_APELLIDO,NOMBRE,EDUCACION,FOTO from "gen$persona" where ID_IDENTIFICACION = :ID and');
          SQL.Add('ID_PERSONA = :PERSONA');
          ParamByName('ID').AsInteger := DBLCBTipoDocumentoJuvenil.KeyValue;
          ParamByName('PERSONA').AsString := EdDocumentoJuvenil.Text;
          ExecQuery;
           if RecordCount = 0 then
           begin
               MessageDlg('Error Asociado no Encontrado',mtInformation,[mbok],0);
               Exit;
           end
           else
           begin
              JVnombre.Caption :=  FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                          FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                          FieldByName('NOMBRE').AsString;

              Close;
              SQL.Clear;
              SQL.Add('select * from "cap$maestrotitular" ');
              SQL.Add('inner join "cap$maestro" ON ("cap$maestrotitular".ID_AGENCIA = "cap$maestro".ID_AGENCIA and ');
              SQL.Add('"cap$maestrotitular".ID_TIPO_CAPTACION = "cap$maestro".ID_TIPO_CAPTACION and');
              SQL.Add('"cap$maestrotitular".NUMERO_CUENTA = "cap$maestro".NUMERO_CUENTA and');
              SQL.Add('"cap$maestrotitular".DIGITO_CUENTA ="cap$maestro".DIGITO_CUENTA)');
              SQL.Add('inner join "cap$tiposestado" ON ("cap$maestro".ID_ESTADO = "cap$tiposestado".ID_ESTADO)');
              SQL.Add('where');
              SQL.Add('"cap$maestrotitular".ID_PERSONA = :ID_PERSONA and');
              SQL.Add('"cap$maestrotitular".NUMERO_TITULAR = 2 ');
              //SQL.Add('"cap$tiposestado".SE_SUMA <> 0');
              //ParamByName('ID_IDENTIFICACION').AsInteger := DBLCBTipoDocumentoJuvenil.KeyValue;
              ParamByName('ID_PERSONA').AsString := EdDocumentoJuvenil.Text;
              ExecQuery;
              if RecordCount > 0 then
              begin
                  Agj := FieldByName('ID_AGENCIA').AsInteger;
                  TpJ := FieldByName('ID_TIPO_CAPTACION').AsInteger;
                  NmJ := FieldByName('NUMERO_CUENTA').AsInteger;
                  DgJ := FieldByName('DIGITO_CUENTA').AsInteger;
                  Cuenta.Caption := IntToStr(TpJ) + '0' + IntToStr(AgJ) + '-' + FormatCurr('000000',NmJ);
              end
              else
              begin
                MessageDlg('Error Cuenta Juvenil no Encontrada',mtInformation,[mbok],0);
                Exit;
              end;
              Close;
              SQL.Clear;
              SQL.Add('select ID_IDENTIFICACION,ID_PERSONA from "cap$maestrotitular" where');
              SQL.Add('ID_AGENCIA = :ID_AGENCIA and ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and ');
              SQL.Add('NUMERO_CUENTA = :NUMERO_CUENTA and DIGITO_CUENTA = :DIGITO_CUENTA and');
              SQL.Add('NUMERO_TITULAR = 1');
              ParamByName('ID_AGENCIA').AsInteger := Agj;
              ParamByName('ID_TIPO_CAPTACION').AsInteger := Tpj;
              ParamByName('NUMERO_CUENTA').AsInteger := Nmj;
              ParamByName('DIGITO_CUENTA').AsInteger := Dgj;
              ExecQuery;
              if RecordCount > 0 then
              begin
                id_persona := FieldByName('ID_PERSONA').AsString;
                id_identificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
              end;
              Close;
              SQL.Clear;
              SQL.Add('select PRIMER_APELLIDO,SEGUNDO_APELLIDO,NOMBRE, ID_AGENCIA,ID_TIPO_CAPTACION,NUMERO_CUENTA,DIGITO_CUENTA from "gen$persona"');
              SQL.Add('inner join "cap$maestrotitular" ON ("gen$persona".ID_IDENTIFICACION = "cap$maestrotitular".ID_IDENTIFICACION and');
              SQL.Add('"gen$persona".ID_PERSONA = "cap$maestrotitular".ID_PERSONA)');
              SQL.Add('where "gen$persona".ID_IDENTIFICACION = :ID_IDENTIFICACION and "gen$persona".ID_PERSONA = :ID_PERSONA and');
              SQL.Add('"cap$maestrotitular".NUMERO_TITULAR = 1 and "cap$maestrotitular".ID_TIPO_CAPTACION = 1');
              ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
              ParamByName('ID_PERSONA').AsString := id_persona;
              DBLCBTipoDocumento.KeyValue := id_identificacion;
              EdDocumento.Text := id_persona;
              ExecQuery;
              if RecordCount > 0 then begin
                 EdNombreAsociado.Caption := FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                             FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                             FieldByName('NOMBRE').AsString;
                 Ag := FieldByName('ID_AGENCIA').AsInteger;
                 Tp := FieldByName('ID_TIPO_CAPTACION').AsInteger;
                 Nm := FieldByName('NUMERO_CUENTA').AsInteger;
                 Dg := FieldByName('DIGITO_CUENTA').AsInteger;
             end;

        end;
        es_juvenil := True;
        JVjuvenil.SetFocus;
        BTregistra.Enabled := True;
        PageControl4.Enabled := False;
        PageControl5.Enabled := False;        
        end;
end;

procedure TFrmAyudaManual.CmdBuscarJuvenilCuentaClick(Sender: TObject);
begin
        with IBSQL1 do begin
          Close;
          SQL.Clear;
          SQL.Add('select ID_IDENTIFICACION,ID_PERSONA from "cap$maestrotitular" Where');
          SQL.Add('ID_TIPO_CAPTACION = 4 and NUMERO_CUENTA = :NUMERO_CUENTA');// and NUMERO_TITULAR = 2');
          ParamByName('NUMERO_CUENTA').AsInteger := EdCuentaJuvenil.Value;
            ExecQuery;
            if RecordCount > 0 then begin
              DBLCBTipoDocumentoJuvenil.KeyValue := FieldByName('ID_IDENTIFICACION').AsInteger;
              EdDocumentoJuvenil.Text := FieldByName('ID_PERSONA').AsString;
              CmdBuscarJuvenilDoc.Click;
            end
            else
              MessageDlg('Numero de Cuenta no Encontrado'+#13+'Por Favor Verifiquelo!',mtError,[mbcancel],0);
        end;
end;

procedure TFrmAyudaManual.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmAyudaManual.FormKeyPress(Sender: TObject; var Key: Char);
begin
        entertabs(key,Self)
end;

procedure TFrmAyudaManual.EnterTabs(var Key: Char; oSelf: TForm);
begin
 if (Key=#13) and
      not (oSelf.ActiveControl is TButton)    and
      not (oSelf.ActiveControl is TDBMemo)//    and
      //not (oSelf.ActiveControl is TJvStringGrid)
                                 then begin
      oSelf.Perform( WM_NEXTDLGCTL, 0,0);

      Key := #0;
      end;
end;

procedure TFrmAyudaManual.DBLCBTipoDocumentoKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self)
end;

procedure TFrmAyudaManual.TabAportesShow(Sender: TObject);
begin
        PageControl4.ActivePage := TabSheet2;
        DBLCBTipoDocumento.SetFocus
end;

procedure TFrmAyudaManual.EdDocumentoKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self)
end;

procedure TFrmAyudaManual.EdCuentaAportesKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self)
end;

procedure TFrmAyudaManual.DBLCBTipoDocumentoJuvenilKeyPress(
  Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self)
end;

procedure TFrmAyudaManual.EdDocumentoJuvenilKeyPress(Sender: TObject;
  var Key: Char);
begin
EnterTabs(Key,Self)
end;

procedure TFrmAyudaManual.EdCuentaJuvenilKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           CmdBuscarJuvenilCuenta.Click
end;

procedure TFrmAyudaManual.TabBuscarDocumentoAsociadoJuvenilShow(
  Sender: TObject);
begin
DBLCBTipoDocumentoJuvenil.SetFocus
end;

procedure TFrmAyudaManual.JVvalorEnter(Sender: TObject);
begin
        JVvalor.SelectAll
end;

procedure TFrmAyudaManual.JVvalorKeyPress(Sender: TObject; var Key: Char);
begin
        entertabs(Key,Self)
end;

procedure TFrmAyudaManual.DBayudasKeyPress(Sender: TObject; var Key: Char);
begin
        entertabs(Key,Self)
end;

procedure TFrmAyudaManual.Limpiar;
begin
        BTregistra.Enabled := False;
        PageControl1.Enabled := True;
        EdDocumento.Text := '';
        JVvalor.Value := 0;
        EdCuentaAportes.Value := 0;
        EdnombreAsociado.Caption := '';
        Cuenta.Caption := '';
        EdDocumentoJuvenil.Text := '';
        EdCuentaJuvenil.Value := 0;
        PageControl4.Enabled := False;
        PageControl5.Enabled := False;       
        PageControl4.Enabled := True;
        PageControl5.Enabled := True;
        PageControl1.ActivePage := TabAportes;
        PageControl4.ActivePage := TabSheet2;
        DBLCBTipoDocumento.SetFocus
end;

procedure TFrmAyudaManual.BitBtn2Click(Sender: TObject);
begin
        Limpiar;
end;

procedure TFrmAyudaManual.BTregistraClick(Sender: TObject);
var    valor :Currency;
       id_ayuda :Integer;
begin
        if es_juvenil then
        begin
           valor := JVjuvenil.Value;
           id_ayuda := 9;
        end
        else
        begin
           valor := JVvalor.Value;
           id_ayuda := DBayudas.KeyValue;
        end;
        if MessageDlg('Esta Seguro de Realizar la Transacción',mtWarning,[mbyes,mbno],0) = mryes then
        begin
          with IBQuery2 do
          begin
            try
              Close;
              if Transaction.InTransaction then
                 Transaction.Rollback;
              Transaction.StartTransaction;
              SQL.Clear;
              SQL.Add('insert into "fun$consolayudas" (ID_AGENCIA,ID_TIPO_CAPTACION,NUMERO_CUENTA,');
              SQL.Add('DIGITO_CUENTA,PERIODO,ID_AYUDA,VALOR) values (');
              SQL.Add(':ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,:PERIODO,:ID_AYUDA,:VALOR)');
              ParamByName('ID_AGENCIA').AsInteger := Ag;
              ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
              ParamByName('NUMERO_CUENTA').AsInteger := Nm;
              ParamByName('DIGITO_CUENTA').AsInteger := Dg;
              ParamByName('PERIODO').AsInteger := YearOf(Date);
              ParamByName('ID_AYUDA').AsInteger := id_ayuda;
              ParamByName('VALOR').AsCurrency := valor;
              ExecSQL;
              if es_juvenil then
              begin
                SQL.Clear;
                SQL.Add('insert into "fun$juveniles" (ID_AGENCIA,ID_TIPO_CAPTACION,NUMERO_CUENTA,DIGITO_CUENTA,PERIODO,FECHA_ENTREGA,VALOR_ENTREGADO)');
                SQL.Add('values (:ID_AGENCIA,:ID_TIPO_CAPTACION,:NUMERO_CUENTA,:DIGITO_CUENTA,:PERIODO,:FECHA_ENTREGA,:VALOR_ENTREGADO)');
                ParamByName('ID_AGENCIA').AsInteger := AgJ;
                ParamByName('ID_TIPO_CAPTACION').AsInteger := TpJ;
                ParamByName('NUMERO_CUENTA').AsInteger := NmJ;
                ParamByName('DIGITO_CUENTA').AsInteger := DgJ;
                ParamByName('PERIODO').AsInteger := YearOf(Date);
                ParamByName('FECHA_ENTREGA').AsDate := Date;
                ParamByName('VALOR_ENTREGADO').AsCurrency := valor;
                ExecSQL;
              end;
                Transaction.Commit;
                limpiar;
            except
              Transaction.Rollback;
            end;
          end;
        end;
end;

procedure TFrmAyudaManual.JVjuvenilKeyPress(Sender: TObject;
  var Key: Char);
begin
EnterTabs(Key,Self)
end;

procedure TFrmAyudaManual.JVjuvenilEnter(Sender: TObject);
begin
        JVjuvenil.SelectAll
end;

procedure TFrmAyudaManual.IBDatabase1BeforeConnect(Sender: TObject);
begin
        IBDatabase1.LoginPrompt := True;
end;

end.
