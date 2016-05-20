unit UnitRetefuente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBClient, Grids, DBGrids, StdCtrls, Buttons;

type
  TFrmReteFuente = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    CDretefuente: TClientDataSet;
    CDretefuentenit_empleado: TIntegerField;
    CDretefuentenombres: TStringField;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CDretefuenteretefuente: TFloatField;
    CDretefuentesalud: TCurrencyField;
    CDretefuenteeducacion: TCurrencyField;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Public declarations }
  end;

var
  FrmReteFuente: TFrmReteFuente;

implementation

uses UnitQuerys,UnitGlobal;

{$R *.dfm}

procedure TFrmReteFuente.cmChildKey(var msg: TWMKEY);
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

procedure TFrmReteFuente.FormCreate(Sender: TObject);
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT DISTINCT');
          SQL.Add('"inv$empleado"."nombre","inv$empleado"."apellido",');
          SQL.Add('"nom$retefuente"."nit_empleado",');
          SQL.Add('"nom$retefuente"."retefuente",');
          SQL.Add('"nom$retefuente"."SALUD",');
          SQL.Add('"nom$retefuente"."EDUCACION"');
          SQL.Add('FROM');
          SQL.Add('"inv$empleado"');
          SQL.Add('INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empleado"."nitempleado")');
          SQL.Add('INNER JOIN "nom$retefuente" ON ("nom$empleado"."nitempleado" = "nom$retefuente"."nit_empleado")');
          Open;
          while not Eof do
          begin
            CDretefuente.Append;
            CDretefuente.FieldValues['nombres'] := FieldByName('nombre').AsString + ' ' + FieldByName('apellido').AsString;
            CDretefuente.FieldValues['nit_empleado'] := FieldByName('nit_empleado').AsInteger;
            CDretefuente.FieldValues['retefuente'] := FieldByName('retefuente').AsCurrency;
            CDretefuente.FieldValues['salud'] := FieldByName('salud').AsCurrency;
            CDretefuente.FieldValues['educacion'] := FieldByName('educacion').AsCurrency;
            CDretefuente.Post;
            Next;
          end;
          CDretefuente.First;
        end;
        Close;
end;

procedure TFrmReteFuente.BitBtn1Click(Sender: TObject);
begin
        with CDretefuente do
        begin
          First;
          while not Eof do
            begin
               with DataQuerys.IBdatos do
               begin
                 Close;
                 verificatransaccion(DataQuerys.IBdatos);
                 SQL.Clear;
                 SQL.Add('update "nom$retefuente" set');
                 SQL.Add('"nom$retefuente"."retefuente" = :retefuente,');
                 SQL.Add('"nom$retefuente"."SALUD" = :SALUD,');
                 SQL.Add('"nom$retefuente"."EDUCACION" = :EDUCACION');
                 SQL.Add('where "nom$retefuente"."nit_empleado" = :nit_empleado');
                 ParamByName('nit_empleado').AsInteger := CDretefuente.FieldValues['nit_empleado'];
                 ParamByName('retefuente').AsCurrency := CDretefuente.FieldValues['retefuente'];
                 ParamByName('SALUD').AsCurrency := CDretefuente.FieldValues['salud'];
                 ParamByName('EDUCACION').AsCurrency := CDretefuente.FieldValues['educacion'];
                 ExecSQL;
                 Close;
                 Transaction.Commit;
               end;
               Next;
            end;
          MessageDlg('Los Cambios Fueron Realizados Exitosamente',mtinformation,[mbok],0);
          Close;
        end;
end;

end.

