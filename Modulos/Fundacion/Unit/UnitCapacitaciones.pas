unit UnitCapacitaciones;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IBDatabase, DB, IBCustomDataSet, IBQuery,
  DBCtrls, ComCtrls, JvEdit, JvTypedEdit, Buttons;

type
  TFrmCapacitaciones = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    DBtipo: TDBLookupComboBox;
    DataSource1: TDataSource;
    IBQuery1: TIBQuery;
    IBTransaction1: TIBTransaction;
    Label3: TLabel;
    DTfecha: TDateTimePicker;
    Label5: TLabel;
    Mdescripcion: TMemo;
    Label7: TLabel;
    TEhorario: TEdit;
    Panel2: TPanel;
    Label8: TLabel;
    CBparticipante: TComboBox;
    Participantes: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    JVmaximo: TJvIntegerEdit;
    JVhoras: TJvFloatEdit2;
    JVlugar: TJvEdit;
    Panel3: TPanel;
    BCancelar: TSpeedButton;
    SPcerrar: TSpeedButton;
    Baceptar: TBitBtn;
    Label6: TLabel;
    DBsubtipo: TDBLookupComboBox;
    IBsubtipo: TIBQuery;
    DSsubtipo: TDataSource;
    Label11: TLabel;
    EDentidad: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure SPcerrarClick(Sender: TObject);
    procedure MdescripcionKeyPress(Sender: TObject; var Key: Char);
    procedure MdescripcionExit(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BaceptarClick(Sender: TObject);
    procedure DBtipoExit(Sender: TObject);
  private
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    procedure registrar;
    function busca_codigo: integer;
    { Public declarations }
  end;

var
  FrmCapacitaciones: TFrmCapacitaciones;

implementation

uses UnitQuerys,UnitGlobal;

{$R *.dfm}

procedure TFrmCapacitaciones.cmChildKey(var msg: TWMKEY);
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

procedure TFrmCapacitaciones.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        verificatransaccion(IBQuery1);
        IBQuery1.Open;
        IBQuery1.Last;
        DTfecha.Date := Date;
        DBtipo.KeyValue := 1;
end;

procedure TFrmCapacitaciones.SPcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmCapacitaciones.MdescripcionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          JVlugar.SetFocus
end;

procedure TFrmCapacitaciones.MdescripcionExit(Sender: TObject);
begin
        Mdescripcion.Text := UpperCase(Mdescripcion.Text)
end;

procedure TFrmCapacitaciones.registrar;
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('insert into "fun$capacitacion" values (');
          SQL.Add(':id_capacitacion,:fecha,:horario,:estado');
          SQL.Add(',:id_tipocaptacion,:descripcion,:cupo,');
          SQL.Add(':horas,:lugar,:esjuvenil,:id_programa,:entidad)');
          ParamByName('id_capacitacion').AsInteger := busca_codigo;
          ParamByName('fecha').AsDate := DTfecha.Date;
          ParamByName('horario').AsString := TEhorario.Text;
          ParamByName('estado').AsSmallInt := 1;
          ParamByName('id_tipocaptacion').AsSmallInt := DBtipo.KeyValue;
          ParamByName('descripcion').AsString := Mdescripcion.Text;
          ParamByName('cupo').AsSmallInt := JVmaximo.Value;
          ParamByName('horas').AsCurrency := JVhoras.Value;
          ParamByName('lugar').AsString := JVlugar.Text;
          ParamByName('esjuvenil').AsSmallInt := CBparticipante.ItemIndex;
          ParamByName('id_programa').AsSmallInt := DBsubtipo.KeyValue;
          ParamByName('entidad').AsString := EDentidad.Text;
          ExecSQL;
          Close;
          Transaction.Commit;
        end;
end;

function TFrmCapacitaciones.busca_codigo: integer;
begin
        with DataQuerys.IBingresa do
        begin
          Close;
          verificatransaccion(DataQuerys.IBingresa);
          SQL.Clear;
          SQL.Add('select max("fun$capacitacion"."id_capacitacion") as codigo from');
          SQL.Add('"fun$capacitacion"');
          Open;
          Result := FieldByName('codigo').AsInteger + 1;
          Close;
        end;
end;

procedure TFrmCapacitaciones.BCancelarClick(Sender: TObject);
begin
        TEhorario.Text := '';
        JVhoras.Value := 0;
        JVmaximo.Value := 0;
        Mdescripcion.Text := '';
        JVlugar.Text := '';
        CBparticipante.ItemIndex := 0;
        DBtipo.KeyValue := -1;
        EDentidad.Text := '';
        IBsubtipo.Close;
        DBtipo.SetFocus;
end;

procedure TFrmCapacitaciones.BaceptarClick(Sender: TObject);
begin
        if JVhoras.Value = 0 then
        begin
           MessageDlg('El Campo Horas no Puede ser Nulo...',mtWarning,[mbok],0);
           JVhoras.SetFocus;
           Exit;
        end
        else if Mdescripcion.Text = '' then
        begin
           MessageDlg('El Campo Descripcion no Puede ser Nulo...',mtWarning,[mbok],0);
           Mdescripcion.SetFocus;
           Exit;
        end;

        if MessageDlg('Seguro de Realizar la Transaccion?',mtInformation,[mbyes,mbno],0) = mryes then
        begin
          registrar;
          BCancelar.Click;
        end;
end;

procedure TFrmCapacitaciones.DBtipoExit(Sender: TObject);
begin
        IBsubtipo.Close;
        IBsubtipo.ParamByName('id').AsInteger := DBtipo.KeyValue;
        IBsubtipo.Open;
        IBsubtipo.Last;
end;

end.
