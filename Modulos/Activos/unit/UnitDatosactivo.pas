unit UnitDatosactivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, IBCustomDataSet, IBQuery, Mask,Math;

type
  TFrmdatoActivo = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    descripcion: TEdit;
    Label3: TLabel;
    fecha: TEdit;
    Label4: TLabel;
    clase: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Agencia: TEdit;
    Seccion: TEdit;
    Panel2: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    valor: TEdit;
    dmensual: TEdit;
    vlibros: TEdit;
    vida: TEdit;
    dacumulada: TEdit;
    tiempo: TEdit;
    Panel3: TPanel;
    Aceptar: TBitBtn;
    Cancelar: TSpeedButton;
    Salir: TSpeedButton;
    IBdatosactivo: TIBQuery;
    Label13: TLabel;
    estado: TEdit;
    placa: TMaskEdit;
    procedure CancelarClick(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
    procedure AceptarClick(Sender: TObject);
    procedure SalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmdatoActivo: TFrmdatoActivo;

implementation
uses unitdatamodulo,unitglobal;

{$R *.dfm}

procedure TFrmdatoActivo.CancelarClick(Sender: TObject);
var depreciacion,valorhistorico,valor_real,valor_dep: Currency;
    meses: Integer;
begin
        valorhistorico := 0;
        meses := 0;
        with IBdatosactivo do
        begin
          Close;
          ParamByName('placa').AsString:=placa.Text;
          Open;
        if RecordCount <> 0 then
        begin
          if FieldByName('estado').AsString = 'A' then
          begin
            depreciacion := SimpleRoundTo(StrToCurr(deprecia(placa.Text,'9')),0);
            valorhistorico := FieldByName('preciocompra').AsCurrency;
            meses := StrToInt(deprecia(placa.Text,'8'));//tiempo transcurrido
            if validafecha then
            begin
              dacumulada.Text := '$'+FormatCurr('#,##0.00',SimpleRoundTo(StrToCurr(deprecia(placa.Text,'13')),0));
              vlibros.Text := '$'+FormatCurr('#,##0.00',StrToCurr(deprecia(placa.Text,'10')));
            end
            else
            begin
              meses := meses - 1;
              if meses < 0 then// verifica
              begin
                MessageDlg('El No. de Inventario No ha sido Depreciado',mtInformation,[mbOK],0);
                Exit;
              end;
              valor_real:=SimpleRoundTo(valorhistorico-(depreciacion*meses),0);
            if valor_real <= 0 then
            begin
               valor_real := 0;
               valor_dep := valorhistorico;
            end
            else
              valor_dep := meses * depreciacion;
            vlibros.Text := '$'+FormatCurr('#,##0.00',SimpleRoundTo(valor_real,0));
            dacumulada.Text := '$'+FormatCurr('#,##0.00',SimpleRoundTo(valor_dep,0));
            end;
            if deprecia(placa.Text,'10') <> '0' then
              estado.Text := 'P. DEPRECIADO'
            else
              estado.Text := 'T. DEPRECIADO'
            end;
            descripcion.Text := FieldByName('descripcion').AsString;
            clase.Text := FieldByName('cactivo').AsString;
            Agencia.Text := FieldByName('oficina').AsString;
            Seccion.Text := FieldByName('nombre').AsString;
            vida.Text := FieldByName('vidadepreciable').AsString+' Meses';
            dmensual.Text := '$'+FormatCurr('#,##0.00',StrToCurr(deprecia(placa.Text,'9')));
            if meses <= 1 then
            tiempo.Text := IntToStr(meses) + ' Mes'
            else
            tiempo.Text := IntToStr(meses) + ' Meses';
            valor.Text := '$'+FormatCurr('#,##0.00',valorhistorico);
            fecha.Text := FormatDateTime('dd "de" mmm "de" yyyy',FieldByName('fechacompra').AsDateTime);
           end
        else
        begin
           MessageDlg('El No. de Inventario no Existe o Fue Dado de Baja',mtInformation,[mbOK],0);
           AceptarClick(Self);
        end;
           Close;
        end;
end;

procedure TFrmdatoActivo.placaKeyPress(Sender: TObject; var Key: Char);
begin
        validaplaca(Self,Key);
        if Key = #13 then
          CancelarClick(self);
end;

procedure TFrmdatoActivo.AceptarClick(Sender: TObject);
begin
        placa.Text := '';
        estado.Text := '';
        descripcion.Text := '';
        Agencia.Text := '';
        Seccion.Text := '';
        vlibros.Text := '';
        valor.Text := '';
        dmensual.Text := '';
        tiempo.Text := '';
        fecha.Text := '';
        dacumulada.Text := '';
        vida.Text := '';
        clase.Text := '';
        placa.SetFocus;
end;

procedure TFrmdatoActivo.SalirClick(Sender: TObject);
begin
        Close;
end;
end.
