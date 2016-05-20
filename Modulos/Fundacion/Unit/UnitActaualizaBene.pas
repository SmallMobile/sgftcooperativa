unit UnitActaualizaBene;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, IBCustomDataSet, IBQuery, DBCtrls, StdCtrls,
  JvEdit, Mask, JvLabel, IBDatabase, Buttons;

type
  TFrmActaulizaBene = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    DBoficina: TDBLookupComboBox;
    DSoficina: TDataSource;
    IBoficina: TIBQuery;
    Label4: TLabel;
    TEdocumento: TJvEdit;
    TEnombres: TJvEdit;
    JvLabel1: TJvLabel;
    JvLabel3: TJvLabel;
    TEcuenta: TMaskEdit;
    Label1: TLabel;
    ciudad: TEdit;
    IBToficina: TIBTransaction;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure TEdocumentoExit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
  published
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    procedure limpiar;
    { Public declarations }
  end;

var
  FrmActaulizaBene: TFrmActaulizaBene;

implementation

uses UnitdataQuerys,UnitGlobal, UnitQuerys;

{$R *.dfm}

procedure TFrmActaulizaBene.cmChildKey(var msg: TWMKEY);
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

procedure TFrmActaulizaBene.FormCreate(Sender: TObject);
begin
        FrmQuerys := TFrmQuerys.Create(self);
        DataQuerys := TDataQuerys.Create(Self);
        IBoficina.Open;
        IBoficina.Last;
end;

procedure TFrmActaulizaBene.TEdocumentoExit(Sender: TObject);
begin
        with DataQuerys.IBdatos do
        begin
          SQL.Clear;
          SQL.Add('select "fun$afiliacion"."nit_asociado" from "fun$afiliacion"');
          SQL.Add('where "fun$afiliacion"."nit_beneficiario" = :nit');
          ParamByName('nit').AsString := TEdocumento.Text;
          Open;
          if RecordCount = 0 then
          begin
            MessageDlg('No se Encuentra Registrado',mtInformation,[mbok],0);
            limpiar;
            Exit;
          end;
          Close;
        end;
        if DBoficina.KeyValue = 1 then
        begin
          with FrmQuerys.IBseleccion do
          begin
              SQL.Clear;
              SQL.Add(' select * from BUSCA_PERSONA_N1(:NIT)');
              ParamByName('NIT').AsString := TEdocumento.Text;
              Open;
              if RecordCount = 0 then
              begin
                 MessageDlg('Verifique la Informacion el No de Identificacion'+#13+'no se Encuentra Registrado el la Base de Datos.',mtInformation,[mbok],0);
                 DBoficina.SetFocus;
              end
              else
              begin
                TEcuenta.EditMask := '!999-999999;1;0';
                TEcuenta.Text := '201-'+ FieldByName('NUMERO_CUENTA').AsString;
                TEnombres.Text := FieldByName('APELLIDO1').AsString + ' ' +FieldByName('APELLIDO2').AsString + ' ' +FieldByName('NOMBRES').AsString;
              end;
          end;
        end
        else
        begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select * FROM BUSCA_BENE(:NIT)');
          ParamByName('NIT').AsString := TEdocumento.Text;
          Open;
          if RecordCount = 0 then
          begin
            MessageDlg('El Beneficiario no Existe',mtInformation,[mbyes,mbno],0);
            TEdocumento.SetFocus;
          end
          else
          begin
            TEcuenta.EditMask := '';
            TEnombres.Text := FieldByName('NOMBRES').AsString;
          end;
        end;
end;
end;

procedure TFrmActaulizaBene.limpiar;
begin
        TEdocumento.Text := '';
        TEcuenta.Text := '';
        TEnombres.Text := '';
        DBoficina.SetFocus;
end;

procedure TFrmActaulizaBene.BitBtn3Click(Sender: TObject);
begin
        limpiar;
end;

procedure TFrmActaulizaBene.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmActaulizaBene.BitBtn1Click(Sender: TObject);
begin
       if MessageDlg('Seguro de Realizar la Transaccion?',mtInformation,[mbyes,mbno],0) = mryes then
       begin
        with DataQuerys.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update "fun$afiliacion" set');
          SQL.Add('"fun$afiliacion"."nit_asociado" = :nit,');
          SQL.Add('"fun$afiliacion"."parentesco" = 1');
          SQL.Add('where "fun$afiliacion"."nit_beneficiario" = :nit');
          ParamByName('nit').AsString := TEdocumento.Text;
          Open;
          Close;
          Transaction.Commit;
       end;
       limpiar;
       end;

end;

end.
