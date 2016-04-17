unit UnitDigita;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls;

type
  TDigita = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    editcodigo: TMaskEdit;
    Label3: TLabel;
    editdebito: TMemo;
    Label4: TLabel;
    editcredito: TMemo;
    Label5: TLabel;
    Panel2: TPanel;
    BtnAgregar: TBitBtn;
    Btncerrar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure editcodigoExit(Sender: TObject);
    procedure editcodigoKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAgregarClick(Sender: TObject);
    procedure BtncerrarClick(Sender: TObject);
    procedure editdebitoKeyPress(Sender: TObject; var Key: Char);
    procedure editcreditoKeyPress(Sender: TObject; var Key: Char);
    procedure editcreditoEnter(Sender: TObject);
    procedure editdebitoEnter(Sender: TObject);
    procedure editdebitoExit(Sender: TObject);
  private

    { Private declarations }
  public
  nomcuenta:string;
  codigo,debito,credito,nocuenta:Variant;
  final: Boolean;
  vnomcuenta,nombre: string;
    procedure cerrar;
  published
    function EvaluarCodigo(codigo: string): string;

    { Public declarations }
  end;

var
  Digita: TDigita;

implementation


uses Unitdecomprobante,unitglobal;
{$R *.dfm}

procedure TDigita.cerrar;
begin
        final := true;
        self.Close;
end;

procedure TDigita.FormShow(Sender: TObject);
begin
        DmComprobante := TDmComprobante.Create(self);
        editcodigo.Text := codigo;
        editdebito.Text := formatcurr('#,##0.00',debito);
        editcredito.Text := formatcurr('#,##0.00',credito);
end;

procedure TDigita.editcodigoExit(Sender: TObject);
var Cadena:string;
begin
    Cadena := EditCODIGO.Text;
    while Pos(' ',Cadena) > 0 do
      Cadena[Pos(' ',Cadena)] := '0';
    Codigo := Cadena;
    vnomcuenta := evaluarcodigo(codigo);
end;

function TDigita.EvaluarCodigo(codigo: string): string;
var     movimiento : boolean;
begin
with Dmcomprobante.IBQuery1 do
    begin
     sql.Clear;
     Sql.Add('select "NOMBRE", "MOVIMIENTO", "INFORME"');
     Sql.Add('from "con$puc"');
     Sql.Add('where "con$puc"."CODIGO" =:"CODIGO"');
     parambyname('CODIGO').AsString := codigo;
     Open;
     nombre := FieldByName('NOMBRE').AsString;
     movimiento := IntToBoolean(FieldByName('MOVIMIENTO').AsInteger);
     if DmComprobante.IBQuery1.RecordCount > 0 then
      begin
        label5.Visible := true;
        label5.Caption := nombre;
        result := nombre;

        if not movimiento then
          begin
           MessageDlg('La Cuenta no es de Movimiento',mtError,[mbOk],0);
           editcodigo.SetFocus;
           editcodigo.Text := '';
           label5.Visible := false;
           exit;
          end;
      end
     else
      begin
        MessageDlg('La Cuenta no Existe',mtError,[mbOk],0);
        editcodigo.Text := '';
        editcodigo.SetFocus;
      end;
    end;
end;

procedure TDigita.editcodigoKeyPress(Sender: TObject; var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TDigita.BtnAgregarClick(Sender: TObject);
begin
        if (debito = 0) and (credito = 0) then
          begin
           MessageDlg('Debe Digitar un Valor Debito ó Crédito',mtError,[mbOk],0);
           editdebito.SetFocus;
           self.ModalResult := mrNone;
        end;
end;

procedure TDigita.BtncerrarClick(Sender: TObject);
begin
          self.Close;
end;

procedure TDigita.editdebitoKeyPress(Sender: TObject; var Key: Char);
begin
        Numerico(sender,key);
        if key = #13 then
          Btnagregar.SetFocus;
end;

procedure TDigita.editcreditoKeyPress(Sender: TObject; var Key: Char);
begin
    Numerico(sender,key);
    if key = #13 then
     begin
           if (editcredito.Text = '0') or (editcredito.Text = '') or (editcredito.Text = '0.00') then
         begin
           credito := strtocurr('0');
           editcredito.Text := formatcurr('#,##0.00',credito);
           editdebito.SetFocus;
         end
       else
         begin
          credito := strtocurr(editcredito.Text);
          editcredito.Text := formatcurr('#,##0.00',credito);
          debito:= 0;
          editdebito.Text := formatcurr('#,##0.00',debito);
          Btnagregar.SetFocus;
         end;
     end;
end;

procedure TDigita.editcreditoEnter(Sender: TObject);
begin
        editcredito.Text := floattostr(credito);
        editcredito.SelectAll;
end;

procedure TDigita.editdebitoEnter(Sender: TObject);
begin
        editdebito.Text := floattostr(debito);
        editdebito.SelectAll;
end;

procedure TDigita.editdebitoExit(Sender: TObject);
begin
           if (editdebito.Text ='0') or (editdebito.Text='') or (editdebito.Text='0.00')   then
           begin
             debito:= strtocurr('0');
             editdebito.Text := formatcurr('#,##0.00',debito);
             editcredito.SetFocus;
           end
        else
         begin
           debito:= strtocurr(editdebito.Text);
           editdebito.Text := formatcurr('#,##0.00',debito);
           credito:= 0;
           editcredito.Text := formatcurr('#,##0.00',credito);
         end;
     end;
end.
