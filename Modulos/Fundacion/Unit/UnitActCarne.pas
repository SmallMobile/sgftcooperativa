unit UnitActCarne;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DB, Buttons;

type
  TFrmActCarne = class(TForm)
    Panel2: TPanel;
    Label5: TLabel;
    DBCarnet: TDBGrid;
    DScarnet: TDataSource;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
      procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmActCarne: TFrmActCarne;

implementation
uses UnitAfiliacion, UnitQuerys, UnitGlobal;

{$R *.dfm}

procedure TFrmActCarne.cmChildKey(var msg: TWMKEY);
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

procedure TFrmActCarne.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmActCarne.BitBtn1Click(Sender: TObject);
begin
       if MessageDlg('Seguro de Realizar la Transaccion',mtInformation,[mbyes,mbno],0) = mryes then
       begin
       with FrmAfiliacion.CDcarnet do
        begin
          First;
          while not Eof do
          begin
            with DataQuerys.IBdatos do
            begin
              SQL.Clear;
              SQL.Add('select count(*) as contador from "fun$carnet"');
              SQL.Add('where "fun$carnet"."nit_beneficiario" = :nit');
              SQL.Add('and "fun$carnet"."programa" = :programa');
              ParamByName('programa').AsString := FrmAfiliacion.CDcarnet.FieldValues['programa'];
              ParamByName('nit').AsString := FrmAfiliacion.CDcarnet.FieldValues['nit_beneficiario'];
              Open;
              if FieldByName('contador').AsInteger = 0 then
              begin
                with DataQuerys.IBselecion do
                begin
                   Close;
                   verificatransaccion(DataQuerys.IBselecion);
                   SQL.Clear;
                   SQL.Add('insert into "fun$carnet"');
                   SQL.Add('values(');
                   SQL.Add(':no_carnet,:nit_beneficiario,');
                   SQL.Add(':descripcion,:programa)');
                   ParamByName('no_carnet').AsString := FrmAfiliacion.CDcarnet.FieldValues['no_carnet'];
                   ParamByName('nit_beneficiario').AsString := FrmAfiliacion.CDcarnet.FieldValues['nit_beneficiario'];
                   try
                   ParamByName('descripcion').AsString := UpperCase(FrmAfiliacion.CDcarnet.FieldValues['descripcion']);
                   except
                   on e: Exception do
                   ParamByName('descripcion').AsString := '';
                   end;
                   ParamByName('programa').AsString := FrmAfiliacion.CDcarnet.FieldValues['programa'];
                   Open;
                   Close;
                end;
              end
              else
              begin
                 with DataQuerys.IBselecion do
                 begin
                   Close;
                   verificatransaccion(DataQuerys.IBdatos);
                   SQL.Clear;
                   SQL.Add('update "fun$carnet"');
                   SQL.Add('set "fun$carnet"."no_carnet" = :carnet,');
                   SQL.Add('"fun$carnet"."descripcion" = :descripcion');
                   SQL.Add('where "fun$carnet"."nit_beneficiario" = :nit and');
                   SQL.Add('"fun$carnet"."programa" = :programa');
                   ParamByName('nit').AsString := FrmAfiliacion.CDcarnet.FieldValues['nit_beneficiario'];
                   ParamByName('programa').AsString := FrmAfiliacion.CDcarnet.FieldValues['programa'];
                   ParamByName('carnet').AsString := FrmAfiliacion.CDcarnet.FieldValues['no_carnet'];
                   try
                   ParamByName('descripcion').AsString := UpperCase(FrmAfiliacion.CDcarnet.FieldValues['descripcion']);
                   except
                   on e: Exception do
                   ParamByName('descripcion').AsString := '';
                   end;
                   Open;
                   Close;
                 end;
              end;
            end;
            Next;
          end;
          end;
        DataQuerys.IBselecion.Transaction.Commit;
        FrmAfiliacion.CDcarnet.CancelUpdates;
        end;
end;

procedure TFrmActCarne.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

end.
