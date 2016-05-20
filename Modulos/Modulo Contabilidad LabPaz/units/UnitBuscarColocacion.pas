unit UnitBuscarColocacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, DB,
  IBCustomDataSet, IBQuery, IBSQL;

type
  TfrmBusquedadeColocacion = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CBtiposid: TDBLookupComboBox;
    EdNombre: TEdit;
    EdNumeroIdentificacion: TMemo;
    CmdBuscarPersona: TBitBtn;
    Panel4: TPanel;
    CmdAceptar: TBitBtn;
    CmdCerrar: TBitBtn;
    IBQuery: TIBQuery;
    DataSource: TDataSource;
    IBQuery1: TIBQuery;
    DataSource1: TDataSource;
    IBDataSet1: TIBDataSet;
    GridColocacion: TDBGrid;
    IBQueryID_COLOCACION: TIBStringField;
    IBQueryID_CLASIFICACION: TSmallintField;
    IBQueryDESCRIPCION_ESTADO_COLOCACION: TIBStringField;
    IBQueryAMORTIZA_CAPITAL: TIntegerField;
    IBQueryAMORTIZA_INTERES: TIntegerField;
    IBQueryVALOR_CUOTA: TIBBCDField;
    IBQueryFECHA_INTERES: TDateField;
    IBQueryFECHA_CAPITAL: TDateField;
    IBQueryES_CASTIGADO: TSmallintField;
    IBQueryES_NOVISADO: TSmallintField;
    IBQueryES_ANULADO: TSmallintField;
    IBQueryES_CANCELADO: TSmallintField;
    IBQueryID_ESTADO_COLOCACION: TSmallintField;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    EdCuenta: TEdit;
    CmdBuscarCuenta: TBitBtn;
    IBSQL1: TIBSQL;
    procedure EdNumeroIdentificacionKeyPress(Sender: TObject;
      var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure EdNumeroIdentificacionExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CmdCerrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IBQueryAfterScroll(DataSet: TDataSet);
    procedure GridColocacionDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure CmdAceptarClick(Sender: TObject);
    procedure CmdBuscarPersonaClick(Sender: TObject);
    procedure CmdBuscarCuentaClick(Sender: TObject);
    procedure EdCuentaExit(Sender: TObject);
    procedure EdCuentaKeyPress(Sender: TObject; var Key: Char);
    procedure CBtiposidExit(Sender: TObject);
  private
    procedure BuscarColocaciones;
    procedure SetColocacion(vNewValue:String);
    function  GetColocacion:String;
    { Private declarations }
  public
    property Colocacion:String read GetColocacion write SetColocacion;
    { Public declarations }
  end;

var
  frmBusquedadeColocacion: TfrmBusquedadeColocacion;
  vColocacion :String;
  Colores :array[1..15] of TColor;
implementation

{$R *.dfm}

uses UnitDmGeneral,UnitGlobales, UnitBuscarPersona;

procedure TfrmBusquedadeColocacion.SetColocacion(vNewValue:String);
begin
        vColocacion := vNewValue;
end;

function TfrmBusquedadeColocacion.GetColocacion:String;
begin
        Result := vColocacion;
end;

procedure TfrmBusquedadeColocacion.EdNumeroIdentificacionKeyPress(
  Sender: TObject; var Key: Char);
begin
        NumericoSinPunto(Sender,Key);
end;

procedure TfrmBusquedadeColocacion.FormShow(Sender: TObject);
begin
        if DmGeneral.IBTransaction1.InTransaction then
         begin
           DmGeneral.IBTransaction1.Commit;
           DmGeneral.IBTransaction1.StartTransaction;
         end;
        IBDataSet1.Open;
        IBDataSet1.Last;
        IBDataSet1.First;
end;

procedure TfrmBusquedadeColocacion.EdNumeroIdentificacionExit(
  Sender: TObject);
begin
        if DmGeneral.IBTransaction1.InTransaction then
           DmGeneral.IBTransaction1.CommitRetaining;
        with IBQuery1 do
        begin
             SQL.Clear;
             SQL.Add('select * from "gen$persona" where ');
             SQL.Add('"gen$persona".ID_IDENTIFICACION = :"ID_IDENTIFICACION" and ');
             SQL.Add('"gen$persona".ID_PERSONA = :"ID_PERSONA"');
             ParamByName('ID_IDENTIFICACION').AsInteger := CBtiposid.KeyValue;
             ParamByName('ID_PERSONA').AsString := EdNumeroIdentificacion.Text;
             Active := true;
             Last;
             First;
             if RecordCount = 1 then
             begin
                EdNombre.Text  := FieldByName('PRIMER_APELLIDO').AsString + ' '+
                                  FieldByName('SEGUNDO_APELLIDO').AsString + ' ' +
                                  FieldByName('NOMBRE').AsString;
                BuscarColocaciones;
             end;
        end;
end;

procedure TfrmBusquedadeColocacion.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmBusquedadeColocacion.BuscarColocaciones;
begin
        with IBQuery do
        begin
             SQL.Clear;
             SQL.Add('SELECT ');
             SQL.Add('"col$colocacion".ID_COLOCACION,');
             SQL.Add('"col$colocacion".ID_CLASIFICACION,');
             SQL.Add('"col$estado".ID_ESTADO_COLOCACION,');
             SQL.Add('"col$estado".DESCRIPCION_ESTADO_COLOCACION,');
             SQL.Add('"col$colocacion".AMORTIZA_CAPITAL,');
             SQL.Add('"col$colocacion".AMORTIZA_INTERES,');
             SQL.Add('"col$colocacion".VALOR_CUOTA,');
             SQL.Add('"col$colocacion".FECHA_INTERES,');
             SQL.Add('"col$colocacion".FECHA_CAPITAL,');
             SQL.Add('"col$estado".ES_CASTIGADO,');
             SQL.Add('"col$estado".ES_NOVISADO,');
             SQL.Add('"col$estado".ES_ANULADO,');
             SQL.Add('"col$estado".ES_CANCELADO ');
             SQL.Add('FROM ');
             SQL.Add('"col$colocacion"');
             SQL.Add('INNER JOIN "col$estado" ON ("col$colocacion".ID_ESTADO_COLOCACION = "col$estado".ID_ESTADO_COLOCACION) ');
             SQL.Add('WHERE ');
             SQL.Add('(ID_IDENTIFICACION = :"ID_IDENTIFICACION") AND ');
             SQL.Add('(ID_PERSONA = :"ID_PERSONA")');
             SQL.Add(' ORDER BY ');
             SQL.Add('"col$colocacion".ID_ESTADO_COLOCACION,"col$colocacion".ID_COLOCACION ');

             ParamByName('ID_IDENTIFICACION').AsInteger := CBtiposid.KeyValue;
             ParamByName('ID_PERSONA').AsString := EdNumeroIdentificacion.Text;

             IBQueryVALOR_CUOTA.DisplayFormat := ',#';
             IBQueryFECHA_CAPITAL.DisplayFormat := 'yyyy/mm/dd';
             IBQueryFECHA_INTERES.DisplayFormat := 'yyyy/mm/dd';
             Open;
        end;
end;

procedure TfrmBusquedadeColocacion.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmBusquedadeColocacion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        Action := caFree;
end;

procedure TfrmBusquedadeColocacion.IBQueryAfterScroll(DataSet: TDataSet);
begin
        with DataSet do
        begin
         if  (FieldByName('ES_CASTIGADO').AsInteger = 1) or
             (FieldByName('ES_NOVISADO').AsInteger =1) or
             (FieldByName('ES_ANULADO').AsInteger = 1) or
             (FieldByName('ES_CANCELADO').AsInteger = 1) then
             CmdAceptar.Enabled := false
         else
             CmdAceptar.Enabled := true;
        end;


end;

procedure TfrmBusquedadeColocacion.GridColocacionDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
        with IBQuery do
        begin
         if  (FieldByName('ES_CASTIGADO').AsInteger = 1) or
             (FieldByName('ES_NOVISADO').AsInteger =1) or
             (FieldByName('ES_ANULADO').AsInteger = 1) or
             (FieldByName('ES_CANCELADO').AsInteger = 1) then
             GridColocacion.Canvas.Brush.Color := Colores[FieldByName('ID_ESTADO_COLOCACION').AsInteger+1];
        end;
        GridColocacion.DefaultDrawColumnCell(Rect, DataCol,Column,State);

end;

procedure TfrmBusquedadeColocacion.FormCreate(Sender: TObject);
begin
        Colores[7] := clYellow;
        Colores[6] := clBlue;
        Colores[5] := clFuchsia;
        Colores[4] := clAqua;
        Colores[3] := clLtGray;
        Colores[2] := clDkGray;
        Colores[1] := clWhite;

end;

procedure TfrmBusquedadeColocacion.CmdAceptarClick(Sender: TObject);
begin
        Colocacion := IBQuery.FieldByName('ID_COLOCACION').AsString;
end;

procedure TfrmBusquedadeColocacion.CmdBuscarPersonaClick(Sender: TObject);
var frmBuscarPersona:TfrmBuscarPersona;
begin
        frmBuscarPersona := TfrmBuscarPersona.Create(Self);
        if frmBuscarPersona.ShowModal = mrOK then
        begin
           CBtiposid.KeyValue := frmBuscarPersona.id_identificacion;
           EdNumeroIdentificacion.Text := frmBuscarPersona.id_persona;
           EdNumeroIdentificacionExit(TObject(EdNumeroIdentificacion));
        end;

end;

procedure TfrmBusquedadeColocacion.CmdBuscarCuentaClick(Sender: TObject);
var Dg:Integer;
begin
        if EdCuenta.Text = '' then Exit;

        EdCuenta.Text := Format('%.7d',[Strtoint(EdCuenta.Text)]);
        Dg := StrToInt(DigitoControl(1,EdCuenta.Text));

        with IBSQL1 do begin
          Close;
          SQL.Clear;
          SQL.Add('select ID_IDENTIFICACION,ID_PERSONA from "cap$maestrotitular"');
          SQL.Add('where "cap$maestrotitular".ID_AGENCIA = :ID_AGENCIA and');
          SQL.Add('"cap$maestrotitular".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and');
          SQL.Add('"cap$maestrotitular".NUMERO_CUENTA = :NUMERO_CUENTA and');
          SQL.Add('"cap$maestrotitular".DIGITO_CUENTA = :DIGITO_CUENTA and');
          sql.Add('"cap$maestrotitular".NUMERO_TITULAR = 1');
          ParamByName('ID_AGENCIA').AsInteger := Agencia;
          ParamByName('ID_TIPO_CAPTACION').AsInteger := 1;
          ParamByName('NUMERO_CUENTA').AsInteger := StrToInt(EdCuenta.Text);
          ParamByName('DIGITO_CUENTA').AsInteger := Dg;
          try
           ExecQuery;
          except
          end;

          CBtiposid.KeyValue := FieldByName('ID_IDENTIFICACION').AsInteger;
          EdNumeroIdentificacion.Text := FieldByName('ID_PERSONA').AsString;
        end;          

        EdNumeroIdentificacionexit(Sender);
end;

procedure TfrmBusquedadeColocacion.EdCuentaExit(Sender: TObject);
begin
        CmdBuscarCuenta.Click;
end;

procedure TfrmBusquedadeColocacion.EdCuentaKeyPress(Sender: TObject;
  var Key: Char);
begin
        NumericoSinPunto(Sender,Key);
end;

procedure TfrmBusquedadeColocacion.CBtiposidExit(Sender: TObject);
begin
        if CBtiposid.KeyValue < 1 then
          EdCuenta.SetFocus;
end;

end.
