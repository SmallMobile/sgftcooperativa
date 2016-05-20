unit UnitActualiza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons;

type
  TFrmactualiza = class(TForm)
    GroupBox4: TGroupBox;
    dbpoliza: TDBGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    placa: TEdit;
    nombre_p: TMemo;
    GroupBox2: TGroupBox;
    dbactauliza: TDBGrid;
    GroupBox6: TGroupBox;
    cancelar: TSpeedButton;
    salir: TSpeedButton;
    aceptar: TBitBtn;
    bcerrar: TBitBtn;
    procedure placaExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dbactaulizaEnter(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
    procedure salirClick(Sender: TObject);
    procedure cancelarClick(Sender: TObject);
    procedure bcerrarClick(Sender: TObject);
    procedure aceptarClick(Sender: TObject);
    procedure placaEnter(Sender: TObject);
  private
  cod_activo,cod_poliza:Integer;
    { Private declarations }
  public
  codigo_activo:Integer;
  cod_pol:Integer;
  valida_poliza:Boolean;
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
  published
    procedure limpiar;
    { Public declarations }
  end;

var
  Frmactualiza: TFrmactualiza;

implementation

uses UnitDatamodulo,unitgeneral,unitglobal;

{$R *.dfm}

procedure TFrmactualiza.placaExit(Sender: TObject);
var    nombre:string;

begin
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$activo"."descripcion",');
          SQL.Add('"act$activo"."cod_activo"');
          SQL.Add('from "act$activo"');
          SQL.Add('where "act$activo"."placa" = :"placa"');
          ParamByName('placa').AsString:=placa.Text;
          Open;
          cod_activo:=FieldByName('cod_activo').AsInteger;
          codigo_activo:=cod_activo;
          nombre:=FieldByName('descripcion').AsString;
          Close;
        end;
        if validaactivo(placa.Text) = 0 then
           begin
           if nombre ='' then
             begin
             Label3.Caption:='';
             MessageDlg('El Activo no se Encuentra en la Base de Datos',mtInformation,[mbOK],0);
             placa.SetFocus;
             end
           else
            begin
            with DataGeneral.IBdatos do
            begin
              Close;
              SQL.Clear;
              SQL.Add('Select "inv$dependencia"."nombre"');
              SQL.Add('from "inv$dependencia","inv$empleado","act$traslado"');
              SQL.Add('where "act$traslado"."nit_empleado"="inv$empleado"."nit" and');
              SQL.Add('"inv$empleado"."cod_dependencia"="inv$dependencia"."cod_dependencia" and');
              SQL.Add('"act$traslado"."cod_traslado" = (');
              SQL.Add('select max("act$traslado"."cod_traslado") from "act$traslado"');
              SQL.Add('where "act$traslado"."cod_activo" = :"codigo" and');
              SQL.Add('"act$traslado"."forma_traslado"=:"def")');
              ParamByName('codigo').AsInteger:=cod_activo;
              parambyname('def').AsString:='DEFINITIVO';
              Open;
              Label3.Caption:=FieldByName('nombre').AsString;
              nombre_p.Text:=nombre;
              Close;
            end;
            end;
            with frmgeneral.ibcod_poliza do
            begin
              Close;
              Open;
              cod_poliza:=(FieldByName('codigo').AsInteger);
              Close;
            end;
              with frmgeneral.hitorial_polizas do
              begin
               Close;
               ParamByName('codigo').AsInteger:=cod_activo;
               Open;
              end;
               frmgeneral.hitorial_polizas.Open
              end
              else
        begin
         Label3.Caption:='';
         MessageDlg('El Activo fue Dado de Baja',mtInformation,[mbOK],0);
         nombre_p.Text:='';
         placa.SetFocus;
        end;
end;

procedure TFrmactualiza.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        ShortDateFormat := 'yyyy/mm/dd';
        frmgeneral.hitorial_polizas.Close;
        frmgeneral.IbActpoliza.Transaction.RollbackRetaining;
        frmgeneral.IbActpoliza.Close;
end;

procedure TFrmactualiza.FormCreate(Sender: TObject);
begin
        ShortDateFormat := 'dd/mm/yy';
        frmgeneral.IbActpoliza.Open;
        valida_poliza:=False;
end;
procedure Tfrmactualiza.cmChildKey(var msg: TWMKEY);
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

procedure TFrmactualiza.dbactaulizaEnter(Sender: TObject);
begin
        frmgeneral.codigo_poliza:=cod_poliza+1;
end;

procedure TFrmactualiza.placaKeyPress(Sender: TObject; var Key: Char);
begin
        ValidaPlaca(Self,Key);
        if Key = #13 then
           GroupBox2.SetFocus
end;

procedure TFrmactualiza.salirClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmactualiza.limpiar;
begin
        placa.Text:='';
        frmgeneral.hitorial_polizas.Close;
        frmgeneral.IbActpoliza.Close;
        frmgeneral.IbActpoliza.Open;
        placa.SetFocus;
end;

procedure TFrmactualiza.cancelarClick(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmactualiza.bcerrarClick(Sender: TObject);
begin
        if (frmgeneral.IbActpolizafecha_inicio.Text= '') or (frmgeneral.IbActpolizatipo_poliza.Text='') then
        begin
          bcerrar.Enabled:=false;
          dbactauliza.SetFocus;
        end
        else
          frmgeneral.IbActpoliza.Delete;
          dbactauliza.SetFocus;
end;

procedure TFrmactualiza.aceptarClick(Sender: TObject);
var codigo,cod_tipo:Integer;
begin
        //codigo:=0;
        frmgeneral.IbActpoliza.Insert;
        frmgeneral.IbActpoliza.Transaction.CommitRetaining;
        DataGeneral.IBTransaction1.Commit;
        if valida_poliza = True  then
        begin
          codigo:=cod_poliza+1;
        with DataGeneral.IBsel1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$poliza"."tipo_poliza"');
          SQL.Add('from "act$poliza"');
          SQL.Add('where "act$poliza"."cod_poliza"=:"codigo_p"');
          ParamByName('codigo_p').AsInteger:=codigo;
          Open;
        while  not DataGeneral.IBsel1.Eof do
        begin
          cod_tipo:=FieldByName('tipo_poliza').AsInteger;
          with DataGeneral.IBsel do
          begin
            Close;
            SQL.Clear;
            SQL.Add('update "act$poliza" set "act$poliza"."vencido" = 1' );
            SQL.Add('where "act$poliza"."cod_poliza" <> :"codigo"');
            SQL.Add('and "act$poliza"."tipo_poliza" =:"tipo"' );
            SQL.Add('and "act$poliza"."vencido" = 0');
            SQL.Add('and "act$poliza"."cod_activo" =:"cod"');
            ParamByName('codigo').AsInteger:=codigo;
            ParamByName('tipo').AsInteger:=cod_tipo;
            ParamByName('cod').AsInteger:=cod_activo;
            Open;
            Close;
          end;
            DataGeneral.IBsel1.Next;
        end;
        DataGeneral.IBsel1.Close;
        end;
        end;
        limpiar;
        DataGeneral.IBTransaction1.CommitRetaining;
end;

procedure TFrmactualiza.placaEnter(Sender: TObject);
begin
        Label3.Caption:='';
        nombre_p.Text:='';
end;
end.
