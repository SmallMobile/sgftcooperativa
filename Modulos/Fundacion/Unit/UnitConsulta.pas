unit UnitConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvEdit, Buttons, DBCtrls, ComCtrls, JvComCtrls, DB,
  IBDatabase, IBCustomDataSet, IBQuery, JvStaticText, ExtCtrls, JvCheckBox,
  JvLabel, JvPanel,dateutils, JvObservibleCheckBox,JclSysutils, IBSQL,
  IBStoredProc,StrUtils,Jpeg;


type
  TFrmConsulta = class(TForm)
    grupo: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DSdocumento: TDataSource;
    DScaptacion: TDataSource;
    IBcaptacion: TIBQuery;
    IBdocumento: TIBQuery;
    IBTranregistro: TIBTransaction;
    Label1: TLabel;
    DBcaptacion: TDBLookupComboBox;
    Label2: TLabel;
    cuenta: TJvEdit;
    T: TLabel;
    DBtipo: TDBLookupComboBox;
    Label3: TLabel;
    documento: TJvEdit;
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    JvLabel1: TJvLabel;
    JvPanel1: TJvPanel;
    IBasociado: TIBQuery;
    Panel2: TPanel;
    BTconsulta: TBitBtn;
    BitBtn4: TBitBtn;
    Panel3: TPanel;
    CHaportes: TCheckBox;
    CHahorros: TJvCheckBox;
    CHfianzas: TJvCheckBox;
    CHcreditos: TJvCheckBox;
    CHjuvenil: TJvCheckBox;
    JvLabel2: TJvLabel;
    DSAsociado: TDataSource;
    Label4: TLabel;
    TEnombre: TJvStaticText;
    JvStaticText1: TJvStaticText;
    TEdocumento: TJvStaticText;
    JvStaticText2: TJvStaticText;
    TEsexo: TJvStaticText;
    JvStaticText4: TJvStaticText;
    TEdireccion: TJvStaticText;
    JvStaticText6: TJvStaticText;
    TEtelefono: TJvStaticText;
    JvStaticText8: TJvStaticText;
    TECiudad: TJvStaticText;
    CHcapacitacion: TJvCheckBox;
    IBSQL1: TIBSQL;
    IBQPersona: TIBQuery;
    IBSQL2: TIBSQL;
    Ctitular: TComboBox;
    Procedimiento: TIBStoredProc;
    CBcuenta: TComboBox;
    IBSQL3: TIBSQL;
    ImgFotoC: TImage;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBcaptacionExit(Sender: TObject);
    procedure DBtipoExit(Sender: TObject);
    procedure BTconsultaClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  opcion_busqueda :Smallint;
  //agencia :Smallint;
  id_identificacion :smallint;
  id_persona :string;
  tipo_captacion :Integer;
  numero_cuenta :string;
  {Educacion_h :Boolean;
  AportesAct :Boolean;
  AportesAnt :Boolean;
  Deudas_h :Boolean;
  Fianzas_h :Boolean; }
  digito_cuenta :Integer;
  //saldoanterior :Currency;
//  saldoapoactual :Currency;

    function aportes(id_persona, cuenta: string; id_identificacion,
      agencia, tipo: integer): boolean;
    function saldominimo(tipo: smallint): currency;
    function colocacion(id_identificacion: integer;
      id_persona: string): boolean;
    function fianzas(id_identificacion: integer;
      id_persona: string): boolean;
    function educacion(id_persona: string;
      id_identificacion: integer): boolean;
    procedure validar;
    procedure titular(cuenta, tp: integer);
    function estado(tipo: integer): string;
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmConsulta: TFrmConsulta;

implementation

uses UnitdataQuerys,UnitGlobal, UnitGlobalescol, UnitdmColocacion, Unitdata, UnitGlobales,UnitGuardaImagen;

{$R *.dfm}

procedure TFrmConsulta.cmChildKey(var msg: TWMKEY);
begin
if msg.CharCode = VK_RETURN then
    if not (Assigned(ActiveControl) and
           ((ActiveControl is TButton) or
            (ActiveControl is TCustomMemo)))
    then begin
      msg.Result := 1;
      keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), 0, 0);
      Keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), KEYEVENTF_KEYUP, 0);
    end;
end;

procedure TFrmConsulta.FormCreate(Sender: TObject);
begin
        PageControl1.ActivePage := TabSheet1;
        IBdocumento.Open;
        IBcaptacion.Open;
        IBdocumento.Last;
        IBcaptacion.Last;
        FrmQuerys := TFrmQuerys.Create(self);
        //IBasociado.Open;
        IBasociado.Close;
        dmColocacion := TdmColocacion.Create(self);
        if frmdata.IBTransaction2.InTransaction then
           frmdata.IBTransaction2.Commit;
        frmdata.IBTransaction2.StartTransaction;
        {if IBTranregistro.InTransaction then
           IBTranregistro.Commit;
        IBTranregistro.StartTransaction;}
end;

procedure TFrmConsulta.BitBtn1Click(Sender: TObject);
var     es_activa :Boolean;
        jpg :TJPEGImage;
        _sjpg : TMemoryStream;
        _iImagen :TGImagen;
        _rImagen :TImagen;

begin
          es_activa := False;
        _iImagen := TGImagen.Create;
//          agencia := 1;
          if opcion_busqueda = 1 then
          begin
           try
            with IBSQL1 do begin
              Close;
              SQL.Clear;
              SQL.Add('select ID_IDENTIFICACION,ID_PERSONA from "cap$maestrotitular" Where');
              SQL.Add('ID_TIPO_CAPTACION = :ID_TIPOCAPTACION and NUMERO_CUENTA = :NUMERO_CUENTA and NUMERO_TITULAR = 1');
              ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(cuenta.Text);
              ParamByName('ID_TIPOCAPTACION').AsInteger := DBcaptacion.KeyValue;
              ExecQuery;
              if RecordCount > 0 then
              begin
                id_identificacion := FieldByName('ID_IDENTIFICACION').AsInteger;
                id_persona  := FieldByName('ID_PERSONA').AsString;
              end
              else
              begin
                MessageDlg('Verifique los Datos del Asociado, No de Cuenta no Encontrado',mtWarning,[mbOk],0);
                cuenta.SetFocus;
                Exit;
              end;
          end;
         except
         begin
           messagedlg('Error en la Entrada de los Datos',mterror,[mbok],0);
           cuenta.SetFocus;
           Exit;
         end;
         end;
         end
         else
         begin
           id_identificacion := DBtipo.KeyValue;
           id_persona := documento.Text;
         end;
           with IBSQL1 do
           begin
             Close;
             SQL.Clear;
             SQL.Add('select "cap$maestrotitular".ID_AGENCIA,"cap$maestrotitular".ID_TIPO_CAPTACION,"cap$maestrotitular".NUMERO_CUENTA,"cap$maestrotitular".DIGITO_CUENTA,"cap$maestro".ID_ESTADO from "cap$maestrotitular"');
             SQL.Add('inner join "cap$maestro" ON ("cap$maestro".ID_AGENCIA = "cap$maestrotitular".ID_AGENCIA and "cap$maestro".ID_TIPO_CAPTACION = "cap$maestrotitular".ID_TIPO_CAPTACION and');
             SQL.Add('"cap$maestro".NUMERO_CUENTA = "cap$maestrotitular".NUMERO_CUENTA and "cap$maestro".DIGITO_CUENTA = "cap$maestrotitular".DIGITO_CUENTA)');
             SQL.Add('inner join "cap$tiposestado" ON ("cap$maestro".ID_ESTADO = "cap$tiposestado".ID_ESTADO)');
             SQL.Add('where');
             //SQL.Add('ID_IDENTIFICACION = :ID_IDENTIFICACION and ID_PERSONA = :ID_PERSONA and NUMERO_TITULAR = 1 and "cap$tiposestado".SE_SUMA <> 0');
             SQL.Add('ID_IDENTIFICACION = :ID_IDENTIFICACION and ID_PERSONA = :ID_PERSONA and NUMERO_TITULAR = 1');
             SQL.Add('order by "cap$maestrotitular".ID_AGENCIA ASC,"cap$maestrotitular".ID_TIPO_CAPTACION ASC,"cap$maestrotitular".NUMERO_CUENTA ASC,"cap$maestrotitular".DIGITO_CUENTA');
             ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
             ParamByName('ID_PERSONA').AsString := id_persona;
             ExecQuery;
             if RecordCount > 0 then begin
                while not Eof do
                begin
                  if FieldByName('ID_TIPO_CAPTACION').AsInteger = 1 then
                  begin
                     CBcuenta.Items.Add(Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger]) + ' - ' +estado(FieldByName('ID_ESTADO').AsInteger));
                  if FieldByName('ID_ESTADO').AsInteger = 1 then
                  begin
                    es_activa := True;
                    digito_cuenta := FieldByName('DIGITO_CUENTA').AsInteger;
                    numero_cuenta := Format('%.7d',[FieldByName('NUMERO_CUENTA').AsInteger]);
                    tipo_captacion  := 2;//FieldByName('ID_TIPO_CAPTACION').AsInteger;
                    //agencia := FieldByName('ID_AGENCIA').AsInteger;
                  end;
                  end;
                   Next;
                end;
                CBcuenta.ItemIndex := 0;
              end
              else
              begin
                 MessageDlg('Verifique los Datos del Asociado, No de Documento no Encontrado',mtWarning,[mbOk],0);
                 try
                   documento.SetFocus;
                 except
                   cuenta.SetFocus;
                 end;
                 Exit;
              end;
           end;
         with IBasociado do
         begin
           Close;
           ParamByName('ID_PERSONA').AsString := id_persona;
           ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
           Open;
           TEnombre.Caption := FieldByName('PRIMER_APELLIDO').AsString + ' ' +FieldByName('SEGUNDO_APELLIDO').AsString+ ' '+FieldByName('NOMBRE').AsString;
           CHcapacitacion.Checked := IntToBool(FieldByName('EDUCACION').AsInteger);
           //Close;
         end;
            _rimagen := _iImagen.ConsultaImagen(id_identificacion,id_persona);
            if _rImagen.Foto.Size > 0 then
            begin
              jpg := TJpegImage.Create;
              jpg.LoadFromStream(_rImagen.Foto);
              ImgFotoC.Picture.Bitmap.Assign(jpg);
              ImgFotoC.Repaint;
              FreeAndNil(jpg);
            end;
            FreeAndNil(_rImagen);
         with IBQPersona do
         begin
           SQL.Clear;
           SQL.Add('select * from "gen$direccion"');
           SQL.Add('where ID_PERSONA = :id_persona AND ID_IDENTIFICACION = :id_identificacion');
           ParamByName('ID_PERSONA').AsString := id_persona;
           ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
           Open;
           TEdocumento.Caption := id_persona;
           TEdireccion.Caption := FieldByName('DIRECCION').AsString;
           TECiudad.Caption := FieldByName('MUNICIPIO').AsString;
           TEtelefono.Caption := FieldByName('TELEFONO1').AsString;
           //DBImage1.Fields :=
         end;
         //end;
         if not es_activa then
            Exit;
         TEsexo.Caption := IntToStr(tipo_captacion)+'01-'+Format('%.6d',[strtoint(numero_cuenta)]);
         CHaportes.Checked := aportes(id_persona,numero_cuenta,id_identificacion,agencia,1);
         CHahorros.Checked := aportes(id_persona,numero_cuenta,id_identificacion,agencia,2);
         CHcreditos.Checked := colocacion(id_identificacion,id_persona);
         CHfianzas.Checked := fianzas(id_identificacion,id_persona);
         grupo.Enabled := False;
         IF opcion_busqueda = 1 then
            titular(StrToInt(cuenta.Text),DBcaptacion.KeyValue)
         else
            titular(StrToInt(numero_cuenta),2);
end;

procedure TFrmConsulta.DBcaptacionExit(Sender: TObject);
begin
       opcion_busqueda := 1;
end;

procedure TFrmConsulta.DBtipoExit(Sender: TObject);
begin
        opcion_busqueda := 2;
end;

function TFrmConsulta.aportes(id_persona, cuenta: string;
  id_identificacion, agencia, tipo: integer): boolean;
var digito:string;
    Saldo_Inicial:Currency;
    Saldo_Actual:Currency;
    Saldo_Canje :Currency;
    salto_total :Currency;
begin
        digito := DigitoControl(tipo,cuenta);
           with procedimiento do
           begin
             StoredProcName := 'SALDO_ACTUAL';// saldo actual
             Params[1].AsInteger := agencia;
             Params[2].AsInteger := tipo;
             Params[3].AsInteger := StrToInt(cuenta);
             Params[4].AsInteger := StrToInt(digito);
             Params[5].AsString := IntToStr(YearOf(Date));
             Params[6].AsDate := EncodeDate(YearOf(Date),01,01);
             Params[7].AsDate := EncodeDate(YearOf(Date),12,31);
             Prepared := True;
             ExecProc;
             if  ParamByName('SALDO_ACTUAL').AsCurrency < saldominimo(tipo) then
                 Result := false
             else
                 Result := True;
           end

{        Saldo_Inicial := 0;
        Saldo_Actual := 0;
        Saldo_Canje := 0;
        digito := DigitoControl(tipo,cuenta);
        with FrmQuerys.IBseleccion do
        begin
          Close;
          verificatransaccion(FrmQuerys.IBseleccion);
          SQL.Clear;
          SQL.Add('Select "cap$maestrosaldoinicial".SALDO_INICIAL from "cap$maestro"');
          SQL.Add('LEFT JOIN "cap$maestrosaldoinicial" ON ("cap$maestro".ID_AGENCIA = "cap$maestrosaldoinicial".ID_AGENCIA) AND ');
          SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$maestrosaldoinicial".ID_TIPO_CAPTACION) AND ');
          SQL.Add('("cap$maestro".NUMERO_CUENTA = "cap$maestrosaldoinicial".NUMERO_CUENTA) AND ("cap$maestro".DIGITO_CUENTA = "cap$maestrosaldoinicial".DIGITO_CUENTA)');
          SQL.Add('INNER JOIN "cap$tiposestado" ON ("cap$maestro".ID_ESTADO = "cap$tiposestado".ID_ESTADO)');
          SQL.Add('Where');
          SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
          SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
          SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA and');
          SQL.Add('"cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA and');
          SQL.Add('"cap$maestrosaldoinicial".ANO = :ANO');
          ParamByName('ID_AGENCIA').AsInteger := Agencia;
          ParamByName('ID_TIPO_CAPTACION').AsInteger := Tipo;
          ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(cuenta);
          ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(digito);
          ParamByName('ANO').AsString := IntToStr(YearOf(Date));
          Open;
          if RecordCount > 0 then
             Saldo_Inicial := FieldByName('SALDO_INICIAL').AsCurrency;
          SQL.Clear;
          SQL.Add('SELECT SUM("cap$extracto".VALOR_DEBITO - "cap$extracto".VALOR_CREDITO) AS SUMA from "cap$maestro"');
          SQL.Add('LEFT JOIN "cap$extracto" ON ("cap$maestro".ID_AGENCIA = "cap$extracto".ID_AGENCIA) AND ');
          SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$extracto".ID_TIPO_CAPTACION) AND ');
          SQL.Add('("cap$maestro".NUMERO_CUENTA = "cap$extracto".NUMERO_CUENTA) AND ("cap$maestro".DIGITO_CUENTA = "cap$extracto".DIGITO_CUENTA)');
          SQL.Add('Where');
          SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
          SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
          SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA and');
          SQL.Add('"cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA and');
          SQL.Add('"cap$extracto".FECHA_MOVIMIENTO BETWEEN :FECHA1 and :FECHA2');
          ParamByName('ID_AGENCIA').AsInteger := Agencia;
          ParamByName('ID_TIPO_CAPTACION').AsInteger := Tipo;
          ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(cuenta);
          ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(digito);
          ParamByName('FECHA1').AsDate := EncodeDate(YearOf(Date),01,01);
          ParamByName('FECHA2').AsDate := EncodeDate(YearOf(Date),12,31);
          Open;
          if RecordCount > 0 then
             Saldo_Actual := FieldByName('SUMA').AsCurrency;
          SQL.Clear;
          SQL.Clear;
          SQL.Add('SELECT SUM("cap$canje".VALOR_CHEQUE + "cap$canje".VALOR_MONEDAS) AS CANJE');
          SQL.Add('FROM');
          SQL.Add('"cap$maestro"');
          SQL.Add('LEFT JOIN "cap$canje" ON ("cap$maestro".ID_AGENCIA = "cap$canje".ID_AGENCIA) AND ');
          SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$canje".ID_TIPO_CAPTACION) AND ("cap$maestro".NUMERO_CUENTA = "cap$canje".NUMERO_CUENTA) AND ("cap$maestro".DIGITO_CUENTA = "cap$canje".DIGITO_CUENTA)');
          SQL.Add('Where');
          SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
          SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
          SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA and');
          SQL.Add('"cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA and');
          SQL.Add('"cap$canje".LIBERADO = 0 and');
          SQL.Add('"cap$canje".DEVUELTO = 0');
          ParamByName('ID_AGENCIA').AsInteger := Agencia;
          ParamByName('ID_TIPO_CAPTACION').AsInteger := Tipo;
          ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(cuenta);
          ParamByName('DIGITO_CUENTA').AsInteger := StrToInt(digito);
          Open;
          if RecordCount > 0 then
             Saldo_Canje := FieldByName('CANJE').AsCurrency;
          Close;
        end;
        salto_total := Saldo_Actual + Saldo_Inicial;
        if tipo > 1 then
           salto_total := salto_total + Saldo_Canje;
//        ShowMessage(CurrToStr(salto_total));
        if salto_total >= saldominimo(tipo) then
           Result := True
        else
           Result := False;}
end;

function TFrmConsulta.saldominimo(tipo: smallint): currency;
begin
        with FrmQuerys.IBseleccion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"cap$tipocaptacion".SALDO_MINIMO');
          SQL.Add('FROM');
          SQL.Add('"cap$tipocaptacion"');
          SQL.Add('WHERE');
          SQL.Add('("cap$tipocaptacion".ID_TIPO_CAPTACION = :tipo)');
          ParamByName('tipo').AsSmallInt := tipo;
          Open;
          Result := FieldByName('SALDO_MINIMO').AsCurrency;
          Close;
        end;
end;

procedure TFrmConsulta.BTconsultaClick(Sender: TObject);
begin
        ImgFotoC.Picture := nil;
        Ctitular.Clear;
        PageControl1.ActivePage := TabSheet1;
        cuenta.Text := '';
        documento.Text := '';
        TEnombre.Caption := '';
        TEsexo.Caption := '';
        TEdireccion.Caption := '';
        TECiudad.Caption := '';
        TEtelefono.Caption := '';
        TEdocumento.Caption := '';
        CHaportes.State := cbGrayed;
        CHahorros.State := cbGrayed;
        CHcreditos.State := cbGrayed;
        CHfianzas.State := cbGrayed;
        CHcapacitacion.State := cbGrayed;
        IBasociado.Close;
        grupo.Enabled := True;
        DBtipo.KeyValue := -1;
        DBcaptacion.KeyValue := -1;
        DBcaptacion.SetFocus;
        CBcuenta.ItemIndex := -1;
        CBcuenta.Clear;
        if frmdata.IBTransaction2.InTransaction then
           frmdata.IBTransaction2.Commit;
        frmdata.IBTransaction2.StartTransaction;
        dmColocacion.Free;
        dmColocacion := TdmColocacion.Create(Self);

end;

procedure TFrmConsulta.BitBtn4Click(Sender: TObject);
begin
        Close;
end;

function TFrmConsulta.colocacion(id_identificacion: Integer;
  id_persona: string): Boolean;
var     fecha,fechahoy :TDate;
        tipo :string;
        amortiza,diasp :Integer;
begin
        Result := True;
        with FrmQuerys.IBseleccion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select ID_COLOCACION from "col$colocacion" where ID_ESTADO_COLOCACION in (0,1,2,3) and ID_PERSONA = :ID_PERSONA and ID_IDENTIFICACION = :ID_IDENTIFICACION');
          ParamByName('ID_PERSONA').AsString := id_persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
          Open;
          while not Eof do
          begin
            if obtenerdeudahoy1(Agencia,FieldByName('ID_COLOCACION').AsString,IBSQL2).Dias > 0 then
            begin
              Result := False;
              Break;
            end;
            Next;
          end;
        end;
{        fechahoy := Date;
        with FrmQuerys.IBseleccion do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"col$colocacion".ID_COLOCACION,"col$colocacion".ID_ESTADO_COLOCACION,');
          SQL.Add('"col$colocacion".FECHA_INTERES,');
          SQL.Add('"col$colocacion".AMORTIZA_INTERES,');
          SQL.Add('"col$tiposcuota".INTERES,');
          SQL.Add('"col$colocacion".TIPO_INTERES');
          SQL.Add('FROM');
          SQL.Add('"col$colocacion"');
          SQL.Add('INNER JOIN "col$tiposcuota" ON ("col$colocacion".ID_TIPO_CUOTA = "col$tiposcuota".ID_TIPOS_CUOTA)');
          SQL.Add('WHERE');
          SQL.Add('(ID_IDENTIFICACION = :ID_IDENTIFICACION) AND');
          SQL.Add('(ID_PERSONA = :ID_PERSONA) AND');
          SQL.Add('(ID_ESTADO_COLOCACION IN (0,1,2,3))');
          ParamByName('ID_PERSONA').AsString := id_persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
          Open;
          if FieldByName('ID_COLOCACION').AsString <> '' then
          begin
            while not Eof do
            begin
            IncDay(Date);
              case FieldByName('ID_ESTADO_COLOCACION').AsInteger of
                2..3: begin Result := False; Break; end;
                0..1: begin
                      fecha := FieldByName('FECHA_INTERES').AsDateTime;
                      tipo := FieldByName('TIPO_INTERES').AsString;
                      amortiza := FieldByName('AMORTIZA_INTERES').AsInteger;
                      fecha := CalculoFecha(fecha,amortiza);
                      diasp := dias(fecha,fechahoy);
                      if diasp > 0 then
                      begin
                         Result := False;
                         Break;
                      end
                      else
                         Result := True;
                      end;
              else
                Result := True;
              end;
            Next;
            end;
          end
          else
          Result := True;
          Close;
        end;    }
end;

function TFrmConsulta.fianzas(id_identificacion: integer;
  id_persona: string): boolean;
  var   dias :Integer;
begin
        Result := True;
        with FrmQuerys.ibfianzas  do
        begin
          Close;
          Close;
          SQL.Clear;
          SQL.Add('select "col$colocacion".ID_COLOCACION');
          SQL.Add('from "col$colgarantias"');
          SQL.Add('inner join "col$colocacion" ON ("col$colocacion".ID_AGENCIA = "col$colgarantias".ID_AGENCIA and');
          SQL.Add('"col$colocacion".ID_COLOCACION = "col$colgarantias".ID_COLOCACION)');
          SQL.Add('inner join "col$estado" ON ("col$colocacion".ID_ESTADO_COLOCACION = "col$estado".ID_ESTADO_COLOCACION)');
          SQL.Add('left join "gen$persona" ON ( "col$colocacion".ID_IDENTIFICACION = "gen$persona".ID_IDENTIFICACION and "col$colocacion".ID_PERSONA = "gen$persona".ID_PERSONA)');
          SQL.Add('where "col$colgarantias".ID_PERSONA = :ID_PERSONA AND "col$colgarantias".ID_IDENTIFICACION = :ID_IDENTIFICACION AND');
          SQL.Add('("col$colocacion".ID_ESTADO_COLOCACION <= 2)');
          ParamByName('ID_IDENTIFICACION').AsInteger := id_identificacion;
          ParamByName('ID_PERSONA').AsString := id_persona;
          Open;
          while not Eof do
          begin
           dias := obtenerdeudahoy1(Agencia,FieldByName('ID_COLOCACION').AsString,IBSQL2).Dias;
           if dias > 0 then
           begin
             Result := False;
             Break;
           end;
           Next;
         end;
        end;
end;

function TFrmConsulta.educacion(id_persona: string;
  id_identificacion: integer): boolean;
begin
        with FrmQuerys.IBfianzas do
        begin
          Close;
          verificatransaccion(FrmQuerys.IBfianzas);
          SQL.Clear;
          SQL.Add('SELECT "gen$persona".educacion');
          SQL.Add('FROM "gen$persona"');
          SQL.Add('WHERE "gen$persona".id_persona = :id_persona');
          SQL.Add('and');
          SQL.Add('"gen$persona".id_identificacion = :id_identificacion');
          ParamByName('id_persona').AsString := id_persona;
          ParamByName('id_identificacion').AsInteger := id_identificacion;
          Open;
          Result := IntToBool(FieldByName('educacion').AsInteger);
          Close;
        end;
end;

procedure TFrmConsulta.validar;
var fecha :TDate;
tipo :string;
amortiza,diasp :Integer;
begin
{        Educacion_h     := False;
        AportesAct    := False;
        AportesAnt    := False;
        Deudas_h        := True;
        Fianzas_h       := True;
//        vDisponible    := 0;

// Verificación de Asociado y Requisitos
        with IBQPersona do begin
          SQL.Clear;
          SQL.Add('select PRIMER_APELLIDO,SEGUNDO_APELLIDO,NOMBRE,EDUCACION,FOTO from "gen$persona" where ID_IDENTIFICACION = :ID and');
          SQL.Add('ID_PERSONA = :PERSONA');
          ParamByName('ID').AsInteger := DBtipo.KeyValue;
          ParamByName('PERSONA').AsString := Documento.Text;
          try
           Open;
           if RecordCount > 0 then begin
              Application.ProcessMessages;
              TEnombre.Caption := FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                          FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                          FieldByName('NOMBRE').AsString;
              if InttoBool(FieldByName('EDUCACION').AsInteger) then begin
                Educacion_h := True;
                CHcapacitacion.Checked := Educacion_h;
              end
              else
              begin
                educacion_h := False;
                chcapacitacion.Checked := educacion_h;
              end;
              IBSQL1.Close;
              IBSQL1.SQL.Clear;
              IBSQL1.SQL.Add('select "cap$maestrotitular".ID_AGENCIA,"cap$maestrotitular".ID_TIPO_CAPTACION,"cap$maestrotitular".NUMERO_CUENTA,"cap$maestrotitular".DIGITO_CUENTA from "cap$maestrotitular"');
              IBSQL1.SQL.Add('inner join "cap$maestro" ON ("cap$maestro".ID_AGENCIA = "cap$maestrotitular".ID_AGENCIA and "cap$maestro".ID_TIPO_CAPTACION = "cap$maestrotitular".ID_TIPO_CAPTACION and');
              IBSQL1.SQL.Add('"cap$maestro".NUMERO_CUENTA = "cap$maestrotitular".NUMERO_CUENTA and "cap$maestro".DIGITO_CUENTA = "cap$maestrotitular".DIGITO_CUENTA)');
              IBSQL1.SQL.Add('inner join "cap$tiposestado" ON ("cap$maestro".ID_ESTADO = "cap$tiposestado".ID_ESTADO)');
              IBSQL1.SQL.Add('where');
              IBSQL1.SQL.Add('ID_IDENTIFICACION = :ID_IDENTIFICACION and ID_PERSONA = :ID_PERSONA and NUMERO_TITULAR = 1 and "cap$tiposestado".SE_SUMA <> 0');
              IBSQL1.SQL.Add('order by "cap$maestrotitular".ID_AGENCIA ASC,"cap$maestrotitular".ID_TIPO_CAPTACION ASC,"cap$maestrotitular".NUMERO_CUENTA ASC,"cap$maestrotitular".DIGITO_CUENTA');
              IBSQL1.ParamByName('ID_IDENTIFICACION').AsInteger := DBtipo.KeyValue;
              IBSQL1.ParamByName('ID_PERSONA').AsString := Documento.Text;
              try
                IBSQL1.ExecQuery;
                if IBSQL1.RecordCount > 0 then begin
                   Agencia := IBSQL1.FieldByName('ID_AGENCIA').AsInteger;
                   tipo_captacion := IBSQL1.FieldByName('ID_TIPO_CAPTACION').AsInteger;
                   Numero_cuenta := IntToStr(IBSQL1.FieldByName('NUMERO_CUENTA').AsInteger);
                   Digito_cuenta := IBSQL1.FieldByName('DIGITO_CUENTA').AsInteger;
                end
                else
                begin
                   Agencia := 0;
                   Tipo_captacion := 0;
                   Numero_cuenta := '0';
                   Digito_cuenta := 0;
                   SaldoAnterior := 0;
                   SaldoApoActual := 0;
                   Exit;
                end;
              except
                Transaction.Rollback;
                raise;
              end;
              IBSQL1.Close;
              IBSQL1.SQL.Clear;
              IBSQL1.SQL.Add('select SALDO_INICIAL from "cap$maestrosaldoinicial" where');
              IBSQL1.SQL.Add('ID_AGENCIA = :AG and ID_TIPO_CAPTACION = :TP and NUMERO_CUENTA = :NM and');
              IBSQL1.SQL.Add('DIGITO_CUENTA = :DG and ANO = :ANO');
              IBSQL1.ParamByName('AG').AsInteger := Agencia;
              IBSQL1.ParamByName('TP').AsInteger := tipo_captacion;
              IBSQL1.ParamByName('NM').AsInteger := StrToInt(numero_cuenta);
              IBSQL1.ParamByName('DG').AsInteger := Digito_cuenta;
              IBSQL1.ParamByName('ANO').AsString := IntToStr(YearOf(Date));
              try
               IBSQL1.ExecQuery;
               if IBSQL1.RecordCount > 0 then begin
                 SaldoAnterior := IBSQL1.FieldByName('SALDO_INICIAL').AsCurrency;
                 if SaldoAnterior > 0 then
                    AportesAnt := true
                 else
                    AportesAnt := False;
               end
               else
               begin
                 SaldoAnterior := 0;
                 AportesAnt := False;
               end;
               CHaportes.Checked := AportesAnt;
              except
               Transaction.Rollback;
               raise;
              end;

              IBSQL1.Close;
              IBSQL1.SQL.Clear;
              IBSQL1.SQL.Add('select SALDO_ACTUAL from SALDO_ACTUAL(:AG,:TP,:NM,:DG,:ANO,:FECHA1,:FECHA2)');
              IBSQL1.ParamByName('AG').AsInteger := Agencia;
              IBSQL1.ParamByName('TP').AsInteger := tipo_captacion;
              IBSQL1.ParamByName('NM').AsInteger := StrToInt(numero_cuenta);
              IBSQL1.ParamByName('DG').AsInteger := Digito_cuenta;
              IBSQL1.ParamByName('ANO').AsString := IntToStr(YearOf(Date));
              IBSQL1.ParamByName('FECHA1').AsDate := EncodeDate(YearOf(Date),01,01);
              IBSQL1.ParamByName('FECHA2').AsDate := EncodeDate(YearOf(Date),12,31);
              try
                IBSQL1.ExecQuery;
                if IBSQL1.RecordCount > 0 then begin
                  SaldoapoActual := IBSQL1.FieldByName('SALDO_ACTUAL').AsCurrency;
                  if SaldoApoActual >= 125300 then
                    AportesAct := True
                  else
                    AportesAct := False;
                end
                else
                begin
                  SaldoApoActual := 0;
                  AportesAct := False;
                end;
                CHaportes.Checked := True;
              except
                Transaction.Rollback;
                raise;
              end;
              with IBSQL1 do
              begin
              SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"col$colocacion".ID_COLOCACION,"col$colocacion".ID_ESTADO_COLOCACION,');
          SQL.Add('"col$colocacion".FECHA_INTERES,');
          SQL.Add('"col$colocacion".AMORTIZA_INTERES,');
          SQL.Add('"col$tiposcuota".INTERES,');
          SQL.Add('"col$colocacion".TIPO_INTERES');
          SQL.Add('FROM');
          SQL.Add('"col$colocacion"');
          SQL.Add('INNER JOIN "col$tiposcuota" ON ("col$colocacion".ID_TIPO_CUOTA = "col$tiposcuota".ID_TIPOS_CUOTA)');
          SQL.Add('WHERE');
          SQL.Add('(ID_IDENTIFICACION = :ID_IDENTIFICACION) AND');
          SQL.Add('(ID_PERSONA = :ID_PERSONA) AND');
          SQL.Add('(ID_ESTADO_COLOCACION IN (0,1,2,3))');
          ParamByName('ID_PERSONA').AsString := documento.Text;
          ParamByName('ID_IDENTIFICACION').AsInteger := DBtipo.KeyValue;
          execquery;
          if FieldByName('ID_COLOCACION').AsString <> '' then
          begin
            while not Eof do
            begin
            IncDay(Date);
              case FieldByName('ID_ESTADO_COLOCACION').AsInteger of
                2..3: begin deudas_h := False; Break; end;
                0..1: begin
                      fecha := FieldByName('FECHA_INTERES').AsDateTime;
                      tipo := FieldByName('TIPO_INTERES').AsString;
                      amortiza := FieldByName('AMORTIZA_INTERES').AsInteger;
                      fecha := CalculoFecha(fecha,amortiza);
                      diasp := dias(fecha,date);
                      if diasp > 0 then
                      begin
                         deudas_h := False;
                         Break;
                      end
                      else
                         Deudas_h := True;
                      end;
              else
                Deudas_h := True;
              end;
            Next;
            end;
          end
          else
          Deudas_h := True;
          Close;
        end;
              chcreditos.Checked := Deudas_h;


        with IBSQL1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"col$colocacion".ID_IDENTIFICACION,');
          SQL.Add('"col$colocacion".ID_PERSONA');
          SQL.Add('FROM');
          SQL.Add('"col$colgarantias"');
          SQL.Add('INNER JOIN "col$colocacion" ON ("col$colgarantias".ID_COLOCACION = "col$colocacion".ID_COLOCACION)');
          SQL.Add('WHERE');
          SQL.Add('("col$colgarantias".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND');
          SQL.Add('("col$colgarantias".ID_PERSONA = :ID_PERSONA)');
          ParamByName('ID_IDENTIFICACION').AsInteger := DBtipo.KeyValue;
          ParamByName('ID_PERSONA').AsString := documento.Text;
          ExecQuery;
          Fianzas_h := True;
          while not Eof do
          begin
            Fianzas_h := colocacion(FieldByName('ID_IDENTIFICACION').AsInteger,FieldByName('ID_PERSONA').AsString);
            if Fianzas_h = False then
               Break;
            Next;
          end;
    end;

        }
end;

procedure TFrmConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        dmColocacion.Free
end;

procedure TFrmConsulta.titular(cuenta, tp: integer);
var
        _sIdPersona :string;
        _iIdIdentificacion :Integer;
begin
        with IBSQL1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "gen$persona".ID_IDENTIFICACION,"gen$persona".ID_PERSONA,');
          SQL.Add('"gen$persona".PRIMER_APELLIDO,"gen$persona".SEGUNDO_APELLIDO,"gen$persona".NOMBRE,"gen$persona".DATOS_HUELLA,"gen$persona".FIRMA,"cap$maestrotitular".NUMERO_TITULAR');
          SQL.Add('from "cap$maestro"');
          SQL.Add('LEFT JOIN "cap$maestrotitular" ON ');
          SQL.Add('("cap$maestro".ID_AGENCIA = "cap$maestrotitular".ID_AGENCIA) AND ');
          SQL.Add('("cap$maestro".ID_TIPO_CAPTACION = "cap$maestrotitular".ID_TIPO_CAPTACION) AND ');
          SQL.Add('("cap$maestro".NUMERO_CUENTA = "cap$maestrotitular".NUMERO_CUENTA) AND ');
          SQL.Add('("cap$maestro".DIGITO_CUENTA = "cap$maestrotitular".DIGITO_CUENTA)');
          SQL.Add('LEFT JOIN "gen$persona" ON ("cap$maestrotitular".ID_IDENTIFICACION = "gen$persona".ID_IDENTIFICACION) AND ');
          SQL.Add('("cap$maestrotitular".ID_PERSONA = "gen$persona".ID_PERSONA)');
          SQL.Add('where');
          SQL.Add('"cap$maestro".ID_AGENCIA = :ID_AGENCIA and');
          SQL.Add('"cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
          SQL.Add('"cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA');
          SQL.Add('ORDER BY "cap$maestrotitular".NUMERO_TITULAR');
          ParamByName('ID_AGENCIA').AsInteger := agencia ;
          ParamByName('ID_TIPO_CAPTACION').AsInteger := Tp;
          ParamByName('NUMERO_CUENTA').AsInteger := cuenta;
//          ParamByName('DIGITO_CUENTA').AsInteger := Dg;
          ExecQuery;
               while not Eof do
               begin
                 Ctitular.Items.Add(FieldByName('ID_IDENTIFICACION').AsString + '-' +
                                                   FieldByName('ID_PERSONA').AsString + '   ' +
                                                   FieldByName('PRIMER_APELLIDO').AsString + ' ' +
                                                   FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                                   FieldByName('NOMBRE').AsString);
                 Next;
               end;
          end;
          Ctitular.ItemIndex := 0;

end;

function TFrmConsulta.estado(tipo: integer): string;
begin
        with IBSQL3 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"cap$tiposestado".DESCRIPCION');
          SQL.Add('FROM');
          SQL.Add('"cap$tiposestado"');
          SQL.Add('WHERE');
          SQL.Add('("cap$tiposestado".ID_ESTADO = :ID_ESTADO)');
          ParamByName('ID_ESTADO').AsInteger := tipo;
          ExecQuery;
          Result := LeftStr(FieldByName('DESCRIPCION').AsString,3);
        end;
end;

end.
