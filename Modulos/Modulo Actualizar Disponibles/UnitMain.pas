unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, IBCustomDataSet, IBQuery, IBDatabase,
  Buttons, DateUtils;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    EdBasedeDatos: TEdit;
    Label2: TLabel;
    EdServidor: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    EdFechaI: TDateTimePicker;
    EdFechaF: TDateTimePicker;
    btnIniciar: TBitBtn;
    BitBtn1: TBitBtn;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    Label6: TLabel;
    Label7: TLabel;
    EdUsuario: TEdit;
    EdClave: TEdit;
    Label8: TLabel;
    EdRole: TEdit;
    IBQuery2: TIBQuery;
    IBDatabase2: TIBDatabase;
    IBTransaction2: TIBTransaction;
    IBQuery3: TIBQuery;
    IBQuery4: TIBQuery;
    Label9: TLabel;
    edFecha: TStaticText;
    Label10: TLabel;
    edCodigo: TStaticText;
    Label3: TLabel;
    cbAgencia: TComboBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
        Close;
end;

procedure TForm1.btnIniciarClick(Sender: TObject);
var
   FechaInicial:TDate;
   FechaFinal:TDate;
   vSaldoInicial:Currency;
   vMovimientos:Currency;
   vSaldo :Currency;
   vidagencia:Integer;
begin
        vidagencia := cbAgencia.ItemIndex+1;
        // configuración de la base de datos
        with IBDatabase1 do
        begin
            DatabaseName := EdServidor.Text + ':' + EdBasedeDatos.Text;
            Params.Add('user_name='+EdUsuario.Text);
            Params.Add('password='+EdClave.Text);
            Params.Add('sql_role_name=CONTABILIDAD_A');
            Params.Add('lc_ctype=ISO8859_1');
            try
              Open;
            except
              ShowMessage('No se pudo conectar a la Base de Datos Alterna');
              Exit;
            end;
        end;
        with IBTransaction1 do
        begin
             if InTransaction then
                Rollback;
             StartTransaction;
        end;

        with IBDatabase2 do
        try
            Open;
            if IBTransaction2.InTransaction then
              IBTransaction2.Rollback;
            IBTransaction2.StartTransaction;
        except
            ShowMessage('No se pudo conectar a la Base de Datos Central');
            Exit;
        end;

// Ciclo repetitivo por cada fecha
       FechaInicial :=  EdFechaI.Date;
       FechaFinal := EdFechaF.Date;
       
       while FechaInicial < FechaFinal do
       begin
          edFecha.Caption := DateToStr(FechaInicial);
          Application.ProcessMessages;
  // Buscar Los Códigos
          with IBQuery3 do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select * from "con$codigosdiariodisponible" order by ID_CODIGO ASC,CODIGO ASC');
            Open;
          end;
  // Ciclo por cada código
   // Buscar Saldo Inicial del Año
          while not IBQuery3.Eof do
          begin
            edCodigo.Caption := IBQuery3.FieldByName('CODIGO').AsString;
            Application.ProcessMessages;
            IBQuery1.Close;
            IBQuery1.SQL.Clear;
            IBQuery1.SQL.Add('select SALDOINICIAL from "con$saldosiniciales" where CODIGO = :CODIGO and ID_AGENCIA = :ID_AGENCIA');
            IBQuery1.ParamByName('CODIGO').AsString := IBQuery3.FieldByName('CODIGO').AsString;
            IBQuery1.ParamByName('ID_AGENCIA').AsInteger := vidagencia;
            IBQuery1.Open;
            vSaldoInicial := IBQuery1.FieldByName('SALDOINICIAL').AsCurrency;

            IBQuery1.Close;
            IBQuery1.SQL.Clear;
            IBQuery1.SQL.Add('select SUM(DEBITO - CREDITO) AS MOVIMIENTO from "con$auxiliar"');
            IBQuery1.SQL.Add('where ID_AGENCIA = :ID_AGENCIA and CODIGO = :CODIGO and');
            IBQuery1.SQL.Add(' FECHA <= :FECHA and ESTADOAUX = :ESTADOAUX');
            IBQuery1.ParamByName('ID_AGENCIA').AsInteger := vidagencia;
            IBQuery1.ParamByName('CODIGO').AsString := IBQuery3.FieldByName('CODIGO').AsString;
            IBQuery1.ParamByName('ESTADOAUX').AsString := 'C';
            IBQuery1.ParamByName('FECHA').AsDate := FechaInicial;
            IBQuery1.Open;
            vMovimientos := IBQuery1.FieldByName('MOVIMIENTO').AsCurrency;

            vSaldo := vSaldoInicial + vMovimientos;

            IBQuery4.Close;
            IBQuery4.SQL.Clear;
            IBQuery4.SQL.Add('insert into "con$diariodisponible" values(');
            IBQuery4.SQL.Add(':FECHA,:CODIGO,:ID_AGENCIA,:ID_CODIGO,:SALDODIA');
            IBQuery4.SQL.Add(')');
            IBQuery4.ParamByName('FECHA').AsDate := FechaInicial;
            IBQuery4.ParamByName('CODIGO').AsString := IBQuery3.FieldByName('CODIGO').AsString;
            IBQuery4.ParamByName('ID_AGENCIA').AsInteger := vidagencia;
            IBQuery4.ParamByName('ID_CODIGO').AsInteger := IBQuery3.fieldbyname('ID_CODIGO').AsInteger;
            IBQuery4.ParamByName('SALDODIA').AsCurrency := vSaldo;
            IBQuery4.ExecSQL;

            IBQuery3.Next;

          end; //fin del while ibquery3

          FechaInicial := IncDay(FechaInicial);
   end; // fin del while de fechainicial
   IBTransaction1.Commit;
   IBTransaction2.Commit;

end;

end.
