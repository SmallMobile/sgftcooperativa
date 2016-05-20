unit UnitSaldosCaja;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Buttons, DB, IBCustomDataSet,
  IBQuery, IBDatabase, DBClient, FR_DSet, FR_DBSet, FR_Class,
  IdBaseComponent, IdComponent, IdTCPConnection, sdXmlDocuments,IdTCPClient;

type
  TFrmSaldosCaja = class(TForm)
    Panel1: TPanel;
    DBagencia: TDBLookupComboBox;
    Label1: TLabel;                    
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    IBagencia: TIBQuery;
    DSagencia: TDataSource;
    CBtotal: TCheckBox;
    IBsaldos: TIBQuery;
    IBTransaction1: TIBTransaction;
    CDsaldos: TClientDataSet;
    CDsaldosid_agencia: TIntegerField;
    CDsaldosagencia: TStringField;
    CDsaldosempleado: TStringField;
    CDsaldoscaja: TIntegerField;
    CDsaldossaldo: TCurrencyField;
    frReport1: TfrReport;
    frDBDataSet1: TfrDBDataSet;
    IdTCPClient1: TIdTCPClient;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure IdTCPClient1Work(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure IdTCPClient1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
  private
    XmlPetC :TsdXmlDocument;
    XmlresC :TsdXmlDocument;
    nodo,nodo1 :TXmlNode;
    Valida_Tcp :Boolean;
    Astream :TMemoryStream;
    tamano :Integer;
    id_agencia :Integer;
    agencia :string;
    procedure SaldoLocal;
    procedure SaldoRemoto(puerto: integer; host_r: string);
    procedure insertar(id_agencia, caja: integer; saldo: currency; agencia,
      empleado: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSaldosCaja: TFrmSaldosCaja;

implementation
uses UnitGlobales, UnitPantallaProgreso;
{$R *.dfm}

procedure TFrmSaldosCaja.FormCreate(Sender: TObject);
begin
        if IBagencia.Transaction.InTransaction then
           IBagencia.Transaction.Rollback;
        IBagencia.Transaction.StartTransaction;
        IBagencia.Close;
        IBagencia.Open;
        IBagencia.Last;
        DBagencia.KeyValue := 1;
end;

procedure TFrmSaldosCaja.BitBtn1Click(Sender: TObject);
begin
        CDsaldos.CancelUpdates;
        if CBtotal.Checked = False then
        begin
          if DBagencia.KeyValue = 1 then
            saldolocal
          else if DBagencia.KeyValue = 2 then
          begin
            agencia := 'ABREGO';
            id_agencia := 2;
            saldoremoto(puerto_abrego,host_abrego);
          end
          else if DBagencia.KeyValue = 3 then
          begin
            agencia := 'CONVENCION';
            id_agencia := 3;
            saldoremoto(puerto_convencion,host_convencion);
          end;
        end
        else
        begin
          saldolocal;
          agencia := 'ABREGO';
          id_agencia := 2;
          saldoremoto(puerto_abrego,host_abrego);
          agencia := 'CONVENCION';
          id_agencia := 3;
          saldoremoto(puerto_convencion,host_convencion);
        end;
        frReport1.ShowReport;
end;

procedure TFrmSaldosCaja.SaldoLocal;
begin
        with IBsaldos do
        begin
          if Transaction.InTransaction then
             Transaction.Rollback;
          Transaction.StartTransaction;
          Close;
          ParamByName('FECHAINICIAL').AsString := DateToStr(fFechaActual) + ' 00:00:00 ';
          ParamByName('FECHAFINAL').AsString := DateToStr(fFechaActual) + ' 23:59:59';
          ParamByName('FECHA').AsDate := fFechaActual;
          Open;
          while not Eof do
          begin
            if FieldByName('SALDOCAJA').AsCurrency <> 0 then
               insertar(1,FieldByName('ID_CAJA').AsInteger,FieldByName('SALDOCAJA').AsCurrency,'OCAÑA',FieldByName('EMPLEADO').AsString);
            Next;
          end;
        end;
end;

procedure TFrmSaldosCaja.SaldoRemoto(puerto: integer; host_r: string);
var     sentencia :string;
        AList,AListCampos:TList;
        cadena :string;
        i :Integer;
begin
         sentencia := 'select * from P_SALDO_REMOTO(' +  '''' + DateToStr(fFechaActual) + ' 00:00:00' + '''' + ',' + '''' + DateToStr(fFechaActual) + ' 23:59:59' + '''' + ',' + '''' + DateToStr(fFechaActual) + '''' + ')';
         XmlPetc := TsdXmlDocument.CreateName('query_info');
         XmlPetc.XmlFormat := xfReadable;
         Nodo := XmlPetc.Root.NodeNew('querys');
         Nodo1 := Nodo.NodeNew('query');
         Nodo1.WriteString('tipo','select');
         nodo1.WriteString('sentencia',sentencia);
         XmlresC := TsdXmlDocument.Create;
         XmlresC.EncodingString := 'ISO8859-1';
         XmlresC.XmlFormat := xfReadable;
         Astream := TMemoryStream.Create;
         XmlPetC.SaveToStream(Astream);
           with IdTCPClient1 do
           begin
             Port := Puerto;
             Host := Host_r;
             try
               Application.ProcessMessages;
               Connect;
             except
             on e: Exception do
             begin
                Application.ProcessMessages;
                MessageDlg('Error en la Conexión' + #13 + e.Message,mtError,[mbok],0);
                frmProgreso.Cerrar;
                Disconnect;
                Exit;
             end;
           end;
           if Connected then
           begin
                frmProgreso := TfrmProgreso.Create(self);
                frmProgreso.Ejecutar;
                frmProgreso.Titulo := 'Recibiendo Informacion de ' + agencia;// + Desc_Agencia;
                frmProgreso.InfoLabel := 'Espere un Momento por Favor ...';
                frmProgreso.Min := 0;
                frmProgreso.Position := 50;
                Application.ProcessMessages;
                //Cadena := ReadLn();
                Cadena := ReadLn();
                AStream := TMemoryStream.Create;
                XmlPetC.SaveToStream(AStream);
                WriteInteger(AStream.Size);
                OpenWriteBuffer;
                WriteStream(AStream);
                CloseWriteBuffer;
                FreeAndNil(AStream);
                tamano := ReadInteger;
                AStream := TMemoryStream.Create;
                ReadStream(Astream,tamano,False);
                XmlResc.LoadFromStream(AStream);
                Disconnect;
                frmProgreso.Cerrar;
           end;
           end;
           AList := TList.Create;
           Nodo := XmlResc.Root.NodeByName('consulta000');
           Nodo.NodesByName('Registro',AList);
           for i := 0 to AList.Count -1 do
           begin
              AListCampos := TList.Create;
              TXmlNode(AList[i]).NodesByName('campo',AListCampos);
              insertar(id_agencia,TXmlNode(AListCampos[2]).ValueAsInteger,TXmlNode(AListCampos[0]).ValueAsFloat,agencia,TXmlNode(AListCampos[1]).ValueAsString);
           end;
end;

procedure TFrmSaldosCaja.insertar(id_agencia, caja: integer;
  saldo: currency; agencia, empleado: string);
begin
        with CDsaldos do
        begin
          Append;
          FieldValues['id_agencia'] := id_agencia;
          FieldValues['caja'] := caja;
          FieldValues['saldo'] := saldo;
          FieldValues['agencia'] := agencia;
          FieldValues['empleado'] := empleado;
          Post;
        end;
end;

procedure TFrmSaldosCaja.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if ParName = 'empresa' then
           ParValue := Empresa;
        if ParName = 'nit' then
           parvalue := Nit;
end;

procedure TFrmSaldosCaja.IdTCPClient1Work(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
          frmProgreso.InfoLabel := 'Espere un Momento por Favor ...';// + CurrToStr(AWorkCount/1000);
          frmProgreso.Position := 100;
          Application.ProcessMessages;

end;

procedure TFrmSaldosCaja.IdTCPClient1WorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
          {frmProgreso.Max := AWorkCountMax;
          frmProgreso.Min := 0;}

end;

end.
