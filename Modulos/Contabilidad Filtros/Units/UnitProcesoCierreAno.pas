unit UnitProcesoCierreAno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, IBSQL, IBDatabase, DB, IB, 
  IBCustomDataSet, IBQuery, DateUtils;

type
  TfrmCierreAno = class(TForm)
    GroupBox1: TGroupBox;
    comprobante: TCheckBox;
    auxiliar: TCheckBox;
    cajadiario: TCheckBox;
    saldoscuenta: TCheckBox;
    saldosiniciales: TCheckBox;
    GroupBox3: TGroupBox;
    consecutivos: TCheckBox;
    Panel2: TPanel;
    CmdCerrar: TBitBtn;
    BTimportar: TBitBtn;
    IBSQL1: TIBSQL;
    IBQuery1: TIBQuery;
    IBSQL2: TIBSQL;
    IBSQL3: TIBSQL;
    hi: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure BTimportarClick(Sender: TObject);
    procedure CmdCerrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCierreAno: TfrmCierreAno;
  Alias,Clave :string;
  Generado:Boolean;
implementation

{$R *.dfm}

uses UnitDmGeneral, INIFiles, UnitGlobales, unitMain;

procedure TfrmCierreAno.FormShow(Sender: TObject);
begin
        Generado := False;

        with IBQuery1 do begin
         if Transaction.InTransaction then
           Transaction.Rollback;
         Transaction.StartTransaction;
         Close;
         SQL.Clear;
         SQL.Add('select CONSECUTIVO from "gen$consecutivos" where ID_CONSECUTIVO = 99');
         try
          Open;
          if FieldByName('CONSECUTIVO').AsInteger <> 0 then
             Generado := True
          else
             Generado := False;
          Transaction.Commit;
         except
             Generado := True;
         end;
        end;

end;

procedure TfrmCierreAno.BTimportarClick(Sender: TObject);
var
   Tipos:array[1..4] of Integer;
   i :Integer;
   Total:Integer;
begin
        if Generado then begin
          MessageDlg('El Proceso de Fin de Año, ya fue Ejecutado',mtError,[mbok],0);
          BTimportar.Enabled := False;
          Exit;
        end;

        with IBQuery1 do begin
          if Transaction.InTransaction then
            Transaction.Rollback;
          Transaction.StartTransaction;
        end;

        frmMain.Timer2.Enabled := False;
        hi.Caption := TimeToStr(Now);

        with IBSQL1 do begin
          Close;
          SQL.Clear;
          SQL.Add('delete from "con$comprobante"');
          ExecQuery;
          comprobante.Checked := True;

          Close;
          SQL.Clear;
          SQL.Add('delete from "con$auxiliar"');
          ExecQuery;
          auxiliar.Checked := True;

          Close;
          SQL.Clear;
          SQL.Add('delete from "con$cajadiario"');
          ExecQuery;
          cajadiario.Checked := True;

          Close;
          SQL.Clear;
          SQL.Add('delete from "con$saldoscuenta"');
          ExecQuery;
          saldoscuenta.Checked := True;

          Close;
          SQL.Clear;
          SQL.Add('delete from "con$saldosiniciales"');
          ExecQuery;
          saldosiniciales.Checked := True;

          Close;
          SQL.Clear;
          SQL.Add('update "gen$consecutivos" set CONSECUTIVO = 0');
          ExecQuery;
          consecutivos.Checked := True;
          Close;

          // Marcar proceso realizado

          Close;
          SQL.Clear;
          SQL.Add('update "gen$consecutivos" SET CONSECUTIVO = 1 where ID_CONSECUTIVO = 99');
          try
            ExecQuery;
          except
            Transaction.Rollback;
            raise;
            Exit;
          end;
          // Fin marcado

          Transaction.Commit;
          MessageDlg('Proceso de Fin de Año Terminado con Exito',mtconfirmation,[mbok],0);
        end; // del with

        BTimportar.Enabled := False;

        frmMain.Timer2.Enabled := False;

end;

procedure TfrmCierreAno.CmdCerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TfrmCierreAno.FormCreate(Sender: TObject);
begin
   ShortDateFormat := 'yyyy/MM/dd';
end;

end.
