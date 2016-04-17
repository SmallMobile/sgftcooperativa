unit UnitActualizanit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, JvLabel, StdCtrls, JvEdit, DBCtrls, Buttons, DB,
  IBCustomDataSet, IBQuery;

type
  TFrmActualizanit = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    JVoldnumero: TJvEdit;
    JvLabel1: TJvLabel;
    JvLabel2: TJvLabel;
    DBoficina: TDBLookupComboBox;
    JVnewnumero: TJvEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    DSoficina: TDataSource;
    IBoficina: TIBQuery;
    procedure JVoldnumeroExit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
  es_titular :Boolean;
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmActualizanit: TFrmActualizanit;

implementation

uses UnitQuerys;

{$R *.dfm}

procedure TFrmActualizanit.JVoldnumeroExit(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        if JVoldnumero.Text <> '' then
        begin
        with DataQuerys.IBdatos do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('SELECT *');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacion"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacion"."nit_beneficiario" = :NIT)');
          ParamByName('NIT').AsString := JVoldnumero.Text;
          Open;
          if RecordCount = 0 then
          begin
            MessageDlg('No se Encuentra en Afiliaciones',mtInformation,[mbok],0);
            JVoldnumero.SetFocus;
            Exit;
          end;
        end;
        if DBoficina.KeyValue <> 1 then
        begin
          with DataQuerys.IBdatos do
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"fun$beneficiario"."nombres"');
            SQL.Add('FROM');
            SQL.Add('"fun$beneficiario"');
            SQL.Add('WHERE');
            SQL.Add('("fun$beneficiario"."identificacion" = :nit)');
            ParamByName('nit').AsString := JVoldnumero.Text;
            Open;
            if MessageDlg('Esta Seguro de Cambiar el Documento a: ' + FieldByName( 'nombres').AsString,mtInformation,[mbyes,mbno],0) = mrno then
              JVoldnumero.SetFocus
            else
              JVnewnumero.SetFocus;
          end;
        end;
        end;

end;

procedure TFrmActualizanit.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmActualizanit.FormCreate(Sender: TObject);
begin
        IBoficina.Open;
        IBoficina.Last;
end;

procedure TFrmActualizanit.BitBtn1Click(Sender: TObject);
var     es_local :Integer;
begin
        if JVnewnumero.Text = '' then
        begin
          MessageDlg('El Campo Nuevo Número no debe estar Vacio',mtInformation,[mbok],0);
          JVnewnumero.SetFocus;
          Exit;
        end;
        if MessageDlg('Es Titular???',mtInformation,[mbyes,mbno],0) = mryes then
           es_titular := True
        else
           es_titular := False;
        if MessageDlg('Esta Seguro de Realizar los Cambios',mtInformation,[mbyes,mbno],0) = mryes then
        begin
        if DBoficina.KeyValue = 1 then
           es_local := 1
        else
           es_local := 0;
        if (es_local = 1 ) and (es_titular) then
        begin
        with DataQuerys.IBdatos do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('update "fun$afiliacion" set');
          SQL.Add('"fun$afiliacion"."nit_asociado" = :nit_asociadonew');
          SQL.Add('where');
          SQL.Add('"fun$afiliacion"."nit_asociado" = :nit_asociadoold');
          SQL.Add('and "fun$afiliacion"."es_local" = :es_local');
          ParamByName('nit_asociadoold').AsString := JVoldnumero.Text;
          ParamByName('nit_asociadonew').AsString := JVnewnumero.Text;
          ParamByName('es_local').AsInteger := es_local;
          Open;
          SQL.Clear;
          SQL.Add('update "fun$afiliacion" set');
          SQL.Add('"fun$afiliacion"."nit_beneficiario" = :nit_asociado_new');
          SQL.Add('where');
          SQL.Add('"fun$afiliacion"."nit_beneficiario" = :nit_asociado_old');
          SQL.Add('and "fun$afiliacion"."es_local" = :es_local');
          ParamByName('nit_asociado_new').AsString := JVnewnumero.Text;
          ParamByName('nit_asociado_old').AsString := JVoldnumero.Text;          
          ParamByName('es_local').AsInteger := es_local;
          Open;
          Close;
          Transaction.Commit;
        end;
        end
        else
        begin
        with DataQuerys.IBdatos do
        begin
         if Transaction.InTransaction then
             Transaction.Commit;
         Transaction.StartTransaction;
         if es_titular then
          begin
               Close;
               SQL.Clear;
               SQL.Add('update "fun$afiliacion" set');
               SQL.Add('"fun$afiliacion"."nit_asociado" = :nit_asociado_new');
               SQL.Add('where');
               SQL.Add('"fun$afiliacion"."nit_asociado" = :nit_asociado_old');
               SQL.Add('and "fun$afiliacion"."es_local" = :es_local');
               ParamByName('nit_asociado_old').AsString := JVoldnumero.Text;
               ParamByName('nit_asociado_new').AsString := JVnewnumero.Text;
               ParamByName('es_local').AsInteger := es_local;
               Open;
          end;
               SQL.Clear;
               SQL.Add('update "fun$afiliacion" set');
               SQL.Add('"fun$afiliacion"."nit_beneficiario" = :nit_asociado_new');
               SQL.Add('where');
               SQL.Add('"fun$afiliacion"."nit_beneficiario" = :nit_asociado_old');
               //SQL.Add('and "fun$afiliacion"."es_local" = :es_local');
               ParamByName('nit_asociado_old').AsString := JVoldnumero.Text;
               ParamByName('nit_asociado_new').AsString := JVnewnumero.Text;
               //ParamByName('es_local').AsInteger := es_local;
               Open;
               Close;
               SQL.Clear;
               SQL.Add('update "fun$beneficiario" set');
               SQL.Add('"fun$beneficiario"."identificacion" = :documento_new');
               SQL.Add('where "fun$beneficiario"."identificacion" = :documento_old');
               ParamByName('documento_new').AsString := JVnewnumero.Text;
               ParamByName('documento_old').AsString := JVoldnumero.Text;
               Open;
               Transaction.Commit;
             end;
           end;
           BitBtn2.Click;
           end;

end;

procedure TFrmActualizanit.BitBtn2Click(Sender: TObject);
begin
        JVoldnumero.Text := '';
        JVnewnumero.Text := '';
        DBoficina.KeyValue := -1;
        DBoficina.SetFocus;
end;

procedure TFrmActualizanit.cmChildKey(var msg: TWMKEY);
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

end.
