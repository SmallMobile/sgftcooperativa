unit UnitPlandeCuentas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, DB, DBClient, Grids,
  DBGrids, IBSQL, IBCustomDataSet, IBQuery, StrUtils, pr_Common,
  pr_TxClasses, pr_Parser;

type
  TfrmPlandeCuentas = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BtnModificar: TBitBtn;
    BtnAgregar: TBitBtn;
    BtnEliminar: TBitBtn;
    Btnreporte: TBitBtn;
    btnrefrescar: TBitBtn;
    Btnlimpiar: TBitBtn;
    Btncerrar: TBitBtn;
    Panel3: TPanel;
    Panel4: TPanel;
    Label7: TLabel;
    editcodigo: TMaskEdit;
    editnombre: TEdit;
    Label11: TLabel;
    editcodigomayor: TMaskEdit;
    Label15: TLabel;
    Editsaldoinicial: TMemo;
    Label16: TLabel;
    Editsaldoactual: TMemo;
    CDPuc: TClientDataSet;
    DSPuc: TDataSource;
    Label1: TLabel;
    DBPuc: TDBGrid;
    CDPucCODIGO: TStringField;
    CDPucNOMBRE: TStringField;
    CDPucCODIGOMAYOR: TStringField;
    CDPucMOVIMIENTO: TBooleanField;
    CDPucESBANCO: TBooleanField;
    CDPucINFORME: TStringField;
    CDPucNIVEL: TSmallintField;
    CDPucNATURALEZA: TStringField;
    CDPucSALDOINICIAL: TCurrencyField;
    CDPucSALDOACTUAL: TCurrencyField;
    IBSQL1: TIBSQL;
    IBQPuc: TIBQuery;
    IBSaldos: TIBSQL;
    GroupBox1: TGroupBox;
    Debito: TRadioButton;
    Credito: TRadioButton;
    Ninguna: TRadioButton;
    GroupBox2: TGroupBox;
    Label12: TLabel;
    Editnivel: TMaskEdit;
    CheckBoxmovimiento: TCheckBox;
    CheckBoxesbanco: TCheckBox;
    GroupBox3: TGroupBox;
    Retencion: TCheckBox;
    Iva: TCheckBox;
    PagoT: TCheckBox;
    IBSQL2: TIBSQL;
    IBQuery1: TIBQuery;
    Reporte: TprTxReport;
    procedure FormShow(Sender: TObject);
    procedure DBPucCellClick(Column: TColumn);
    procedure BtnModificarClick(Sender: TObject);
    procedure BtnAgregarClick(Sender: TObject);
    procedure BtnEliminarClick(Sender: TObject);
    procedure btnrefrescarClick(Sender: TObject);
    procedure BtnlimpiarClick(Sender: TObject);
    procedure BtncerrarClick(Sender: TObject);
    procedure BtnreporteClick(Sender: TObject);
    procedure ReporteUnknownObjFunction(Sender: TObject;
      Component: TComponent; const FuncName: String;
      const Parameters: TprVarsArray; ParametersCount: Integer;
      var Value: TprVarValue; var IsProcessed: Boolean);
    procedure editcodigoExit(Sender: TObject);
    procedure editcodigoKeyPress(Sender: TObject; var Key: Char);
    procedure editcodigomayorKeyPress(Sender: TObject; var Key: Char);
    procedure editnombreKeyPress(Sender: TObject; var Key: Char);
    procedure EditsaldoinicialKeyPress(Sender: TObject; var Key: Char);
    procedure EditsaldoactualKeyPress(Sender: TObject; var Key: Char);
    procedure EditsaldoinicialEnter(Sender: TObject);
  private
    function EvaluarCodigoMayor(Codigo: String): string;
    function EvaluarNivel(Codigo: String): Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlandeCuentas: TfrmPlandeCuentas;
  Codigo:string;
  CodigoMayor:string;
  Nivel:Integer;

implementation

{$R *.dfm}

uses UnitGlobales, UnitDmGeneral;

procedure TfrmPlandeCuentas.FormShow(Sender: TObject);
begin
        Panel3.Caption := Empresa + '      ' + 'Nit.  ' + Nit;
        Btnlimpiar.Click;
end;

procedure TfrmPlandeCuentas.DBPucCellClick(Column: TColumn);
var Cadena:string;
begin
        editcodigo.Text := IBQPuc.FieldByName('CODIGO').AsString;
        Cadena := EditCODIGO.Text;
        while Pos(' ',Cadena) > 0 do
        Cadena[Pos(' ',Cadena)] := '0';
        Codigo := Cadena;
        Editnivel.Text := IntToStr(IBQPuc.FieldByName('NIVEL').AsInteger);
        if IBQPuc.FieldByName('MOVIMIENTO').AsInteger = 1 then
          CheckBoxmovimiento.Checked := True
        else CheckBoxmovimiento.Checked := False;
        if IBQPuc.FieldByName('ESBANCO').AsInteger = 1 then
          CheckBoxesbanco.Checked := True
        else CheckBoxesbanco.Checked := False;
        editnombre.Text := IBQPuc.FieldByName('NOMBRE').AsString;
        editcodigomayor.Text := IBQPuc.FieldByName('CODIGOMAYOR').AsString;
        if IBQPuc.FieldByName('NATURALEZA').AsString = 'D' then
          Debito.Checked := True
        else if IBQPuc.FieldByName('NATURALEZA').AsString = 'C' then
          Credito.Checked := True
        else begin
          Debito.Checked := False;
          Credito.Checked := False;
        end;
        if IBQPuc.FieldByName('INFORME').AsString = '01' then
          Retencion.Checked := True
        else if IBQPuc.FieldByName('INFORME').AsString = '02' then
          Iva.Checked := True
        else if IBQPuc.FieldByName('INFORME').AsString = '03' then
          PagoT.Checked := True
        else begin
          Retencion.Checked := False;
          Iva.Checked := False;
          PagoT.Checked := False;
        end;
        Editsaldoinicial.Text := FormatCurr('#0.00',IBQPuc.FieldByName('SALDOINICIAL').AsCurrency);

        IBSaldos.Close;
        IBSaldos.ParamByName('CODIGO').AsString := Codigo;
        IBSaldos.ExecQuery;
        Editsaldoactual.Text := FormatCurr('#0.00',IBSaldos.FieldByName('SALDO').AsCurrency);
        IBSaldos.Close;

end;

procedure TfrmPlandeCuentas.BtnModificarClick(Sender: TObject);
begin
        with IBSQL1 do begin
          Close;
          SQL.Clear;
          SQL.Add('update "con$puc" SET NOMBRE=:NOMBRE,NATURALEZA=:NATURALEZA,MOVIMIENTO=:MOVIMIENTO,');
          SQL.Add('ESBANCO=:ESBANCO,INFORME=:INFORME,CODIGOMAYOR=:CODIGOMAYOR');
          SQL.Add('where CODIGO = :CODIGO');
          ParamByName('CODIGO').AsString := Codigo;
          ParamByName('NOMBRE').AsString := Trim(editnombre.Text);
          if Debito.Checked then
            ParamByName('NATURALEZA').AsString := 'D'
          else if Credito.Checked then
            ParamByName('NATURALEZA').AsString := 'C'
          else
            ParamByName('NATURALEZA').AsString := 'N';

          if CheckBoxmovimiento.Checked then
            ParamByName('MOVIMIENTO').AsInteger := 1
          else
            ParamByName('MOVIMIENTO').AsInteger := 0;

          if CheckBoxesbanco.Checked then
            ParamByName('ESBANCO').AsInteger := 1
          else
            ParamByName('ESBANCO').AsInteger := 0;

          if Retencion.Checked then
            ParamByName('INFORME').AsString := '01'
          else if Iva.Checked then
            ParamByName('INFORME').AsString := '02'
          else if PagoT.Checked then
            ParamByName('INFORME').AsString := '03'
          else
            ParamByName('INFORME').AsString := '00';

          ParamByName('CODIGOMAYOR').AsString := Trim(editcodigomayor.Text);
          try
            ExecQuery;
            if RowsAffected < 1 then
            begin
              MessageDlg('No se Actualizó Ningún Registro del PUC',mtError,[mbcancel],0);
            end;
            Transaction.Commit;
          except
              MessageDlg('Error al Actualizar PUC',mtError,[mbcancel],0);
              Transaction.Rollback;
              raise;
          end;
        end;
        BtnRefrescar.Click;        
end;

procedure TfrmPlandeCuentas.BtnAgregarClick(Sender: TObject);
var
i:Integer;
begin
        IBSQL2.Close;
        IBSQL2.ParamByName('CODIGO').AsString := Codigo;
        IBSQL2.ExecQuery;
        if IBSQL2.RecordCount > 0 then begin
           MessageDlg('Ese Código ya Existe',mtError,[mbOk],0);
           Editcodigo.SetFocus;
           Exit;
        end;

        Nivel := EvaluarNivel(Codigo);
        if Nivel > 1 then begin
          IBSQL2.Close;
          IBSQL2.ParamByName('CODIGO').AsString := CodigoMayor;
          IBSQL2.ExecQuery;
          if IBSQL2.RecordCount <= 0 then begin
             MessageDlg('No Existe la Cuenta Mayor',mtError,[mbOk],0);
             Editcodigo.SetFocus;
             Exit;
          end;
        end;

        if editnombre.Text = '' then begin
           MessageDlg('Cuenta Debe Tener un Nombre',mtError,[mbOk],0);
           editnombre.SetFocus;
           Exit;
        end;

        if ((Debito.Checked = False) and (Credito.Checked = False) and (Ninguna.Checked = False)) then begin
           MessageDlg('Debe definir la Naturaleza de la Cuenta',mtError,[mbOk],0);
           Debito.SetFocus;
           Exit;
        end;


        with IBSQL1 do
         begin
           sql.Clear;
           sql.Add('insert into "con$puc"');
           sql.Add('("con$puc"."CODIGO", "con$puc"."ID_AGENCIA",');
           sql.Add('"con$puc"."CLAVE", "con$puc"."NOMBRE",');
           sql.Add('"con$puc"."TIPO", "con$puc"."CODIGOMAYOR",');
           sql.Add('"con$puc"."MOVIMIENTO", "con$puc"."NIVEL",');
           sql.Add('"con$puc"."ESBANCO", "con$puc"."NATURALEZA",');
           sql.Add('"con$puc"."INFORME", "con$puc".CENTROCOSTO, "con$puc"."SALDOINICIAL")');
           sql.Add('values (');
           sql.Add(':"CODIGO", :"ID_AGENCIA", :"CLAVE", :"NOMBRE",');
           sql.Add(':"TIPO", :"CODIGOMAYOR", :"MOVIMIENTO", :"NIVEL",');
           sql.Add(':"ESBANCO", :"NATURALEZA", :"INFORME",');
           sql.Add(':CENTROCOSTO, :"SALDOINICIAL")');
           ParamByName('CODIGO').AsString         := Codigo;
           ParamByName('ID_AGENCIA').AsInteger    := 1;
           ParamByName('CLAVE').AsString          := '00000';
           ParamByName('NOMBRE').AsString         := Trim(editnombre.Text);
           ParamByName('TIPO').AsString           := '00';
           ParamByName('CODIGOMAYOR').AsString    := CodigoMayor;

          if CheckBoxmovimiento.Checked then
            ParamByName('MOVIMIENTO').AsInteger := 1
          else
            ParamByName('MOVIMIENTO').AsInteger := 0;

          if CheckBoxesbanco.Checked then
            ParamByName('ESBANCO').AsInteger := 1
          else
            ParamByName('ESBANCO').AsInteger := 0;

          if Retencion.Checked then
            ParamByName('INFORME').AsString := '01'
          else if Iva.Checked then
            ParamByName('INFORME').AsString := '02'
          else if PagoT.Checked then
            ParamByName('INFORME').AsString := '03'
          else
            ParamByName('INFORME').AsString := '00';
           ParamByName('NIVEL').AsInteger         := Nivel;
          if Debito.Checked then
            ParamByName('NATURALEZA').AsString := 'D'
          else if Credito.Checked then
            ParamByName('NATURALEZA').AsString := 'C'
          else
            ParamByName('NATURALEZA').AsString := 'N';

           ParamByName('CENTROCOSTO').AsString    := '00';
           ParamByName('SALDOINICIAL').AsCurrency := StrToCurr(Editsaldoinicial.Text);
           ExecQuery;
         end;

        with IBSQL1 do
         begin
           sql.Clear;
           sql.Add('insert into "con$saldoscuenta" (');
           sql.Add('"con$saldoscuenta"."ID_AGENCIA", "con$saldoscuenta"."CODIGO",');
           sql.Add('"con$saldoscuenta"."MES", "con$saldoscuenta"."DEBITO",');
           sql.Add('"con$saldoscuenta"."CREDITO" )');
           sql.Add('values (');
           sql.Add(':"ID_AGENCIA", :"CODIGO", :"MES", :"DEBITO", :"CREDITO")');
           For i:= 1 to 12 do
           begin
             ParamByName('ID_AGENCIA').AsInteger := 1;
             ParamByName('CODIGO').AsString      := Codigo;
             ParamByName('MES').AsString         := Format('%.2d',[i]);
             ParamByName('DEBITO').AsCurrency    := 0.00;
             ParamByName('CREDITO').AsCurrency   := 0.00;
             ExecQuery;
           end;

         end;

         IBSQL1.Transaction.Commit;
         IBSQL1.Transaction.StartTransaction;
         btnrefrescar.Click;
         Btnlimpiar.Click;


end;

procedure TfrmPlandeCuentas.BtnEliminarClick(Sender: TObject);
var
i:Integer;
begin
        If StrToCurr(Editsaldoactual.Text) <> 0 then begin
           MessageDlg('No se Puede Eliminar Cuenta con Movimiento',mtError,[mbOk],0);
           Exit;
        end;


        IBSQL2.Close;
        IBSQL2.ParamByName('CODIGO').AsString := Codigo;
        IBSQL2.ExecQuery;
        if IBSQL2.RecordCount > 0 then
         if  MessageDlg('Seguro de Eliminar Cuenta' + #10 + #13 +
             IBSQL2.FieldByName('CODIGO').AsString + #13 + #10 + IBSQL2.FieldByName('NOMBRE').AsString,mtConfirmation,[mbYes,mbNo],0) = mrYes then
           begin
             with IBSQL1 do
              begin
                SQL.Clear;
                SQL.Add('delete from "con$puc" ');
                SQL.Add('where "con$puc"."CODIGO" =:"CODIGO" and');
                SQL.Add('"con$puc"."ID_AGENCIA" =:"ID_AGENCIA"');
                ParamByName('CODIGO').AsString := Codigo;
                ParamByName('ID_AGENCIA').AsInteger := 1;
                ExecQuery;
              end;

              with IBSQL1 do
               begin
                 sql.Clear;
                 sql.Add('delete from "con$saldoscuenta" where ');
                 sql.Add('"con$saldoscuenta"."ID_AGENCIA" =:"ID_AGENCIA" and');
                 sql.Add('"con$saldoscuenta"."CODIGO" =:"CODIGO" and');
                 sql.Add('"con$saldoscuenta"."MES" =:"MES"');
                 For i := 1 to 12 do
                  begin
                    ParamByName('ID_AGENCIA').AsInteger := 1;
                    ParamByName('CODIGO').AsString := Codigo;
                    ParamByName('MES').AsString := Format('%.2d',[i]);
                    ExecQuery;
                  end;
               end;
           end;
         DmGeneral.IBTransaction1.Commit;
         dmgeneral.IBTransaction1.StartTransaction;
         BtnRefrescar.Click;         
end;

procedure TfrmPlandeCuentas.btnrefrescarClick(Sender: TObject);
begin
        if IBQPuc.Transaction.InTransaction then
          IBQPuc.Transaction.Commit;
        IBQPuc.Transaction.StartTransaction;
        IBQPuc.Close;
        IBQPuc.Open;
end;

procedure TfrmPlandeCuentas.BtnlimpiarClick(Sender: TObject);
begin
        editcodigo.Text := '';
        editcodigomayor.Text := '';
        editnombre.Text := '';
        Debito.Checked := False;
        Credito.Checked := False;
        Ninguna.Checked := False;
        Editnivel.Text := '';
        CheckBoxmovimiento.Checked := False;
        CheckBoxesbanco.Checked := False;
        Retencion.Checked := False;
        Iva.Checked := False;
        PagoT.Checked := False;
        Editsaldoinicial.Text := '0.00';
        Editsaldoactual.Text := '0.00';
        btnrefrescar.Click;
        editcodigo.SetFocus;
        editcodigo.SelectAll;
end;

procedure TfrmPlandeCuentas.BtncerrarClick(Sender: TObject);
begin
        Self.Close;
end;

procedure TfrmPlandeCuentas.BtnreporteClick(Sender: TObject);
begin
        with IBQuery1 do
        begin
         sql.Clear;
         sql.Add('select ');
         sql.Add('"con$puc".CODIGO,');
         sql.Add('"con$puc".ID_AGENCIA,');
         sql.Add('"con$puc".NOMBRE,');
         sql.Add('"con$puc".NATURALEZA,');
         sql.Add('"con$puc".NIVEL,');
         sql.Add('"con$puc".CODIGOMAYOR,');
         sql.add('"con$puc".MOVIMIENTO,');
         sql.Add('"con$puc".INFORME');
         sql.Add('from "con$puc" ORDER BY "con$puc".CODIGO');
         open;
        end;
        Reporte.Variables.ByName['empresa'].AsString := Empresa;
        If Reporte.PrepareReport then
           Reporte.PreviewPreparedReport(true);
        IBQuery1.Close;
end;

procedure TfrmPlandeCuentas.ReporteUnknownObjFunction(Sender: TObject;
  Component: TComponent; const FuncName: String;
  const Parameters: TprVarsArray; ParametersCount: Integer;
  var Value: TprVarValue; var IsProcessed: Boolean);
var
  f : TField;
begin
 if (Component=IBQuery1) and
    (AnsiCompareText(FuncName,'IBQuery1.field')=0) and
    (ParametersCount=1) then
  begin
    // Parameter with index 0 is the fieldname
    if _vAsString(Parameters[0]) = 'MOVIMIENTO' then
     begin
      f := IBQuery1.FindField(_vAsString(Parameters[0]));
      if f<>nil then
       begin
         if f.AsInteger <> 0 then
            value.vString := 'S'
         else
            value.vString := 'N';
       IsProcessed := true;
       end;
     end;
    if _vAsString(Parameters[0]) = 'ID_AGENCIA' then
     begin
      f := IBQuery1.FindField(_vAsString(Parameters[0]));
      if f<>nil then
       begin
        if f.AsInteger = 1 then
           value.vString := 'OCANA'
        else
        if f.AsInteger = 2 then
           value.vString := 'CONVENCION'
        else
        if f.AsInteger = 3 then
           value.vString := 'ABREGO';
       IsProcessed := true;
       end;
     end;
    if _vAsString(Parameters[0]) = 'INFORME' then
     begin
      f := IBQuery1.FindField(_vAsString(Parameters[0]));
      if f <> nil then
       begin
        if f.AsInteger = 00 then
           value.vString := 'NINGUNO';
        if f.AsInteger = 01 then
           value.vString := 'RETENCION EN LA FUENTE';
        if f.AsInteger = 02 then
           value.vString := 'IVA';
        if f.AsInteger = 03 then
           value.vString := 'PAGO A TERCEROS';
       IsProcessed := true;
       end;
     end;
    if _vAsString(Parameters[0]) = 'NATURALEZA' then
     begin
      f := IBQuery1.FindField(_vAsString(Parameters[0]));
      if f <> nil then
       begin
        if f.AsString = 'D' then
         value.vString := 'DEBITO';
        if f.AsString = 'C' then
         value.vString := 'CREDITO';
        if f.AsString = 'N' then
         value.vString := 'NINGUNA';
       IsProcessed := true;
      end;
    end;
    if _vAsString(Parameters[0]) = 'CODIGO' then
     begin
      f := IBQuery1.FindField(_vAsString(Parameters[0]));
      if f <> nil then
       begin
        value.vString := precisarcodigo(f.AsString);
        Isprocessed := true;
       end;
     end;
    if _vAsString(Parameters[0]) = 'CODIGOMAYOR' then
     begin
      f := IBQuery1.FindField(_vAsString(Parameters[0]));
      if f <> nil then
       begin
        value.vString := precisarcodigo(f.AsString);
        Isprocessed := true;
       end;
     end;
  end;
end;

function TfrmPlandeCuentas.EvaluarCodigoMayor(Codigo: String): String;
var Longitud : Integer;
    Cadena : String[18];
begin
        Cadena := '000000000000000000';
        Longitud := 16;

        if MidStr(Codigo,17,2) = '00' then Longitud := 14; //18-10
        if MidStr(Codigo,15,2) = '00' then Longitud := 13; //16-9
        if MidStr(Codigo,13,2) = '00' then Longitud := 10; //14-8
        if MidStr(Codigo,11,2) = '00' then Longitud := 8; //12-7
        if MidStr(Codigo,9,2)  = '00' then Longitud := 6; //10-6
        if MidStr(Codigo,7,2)  = '00' then Longitud := 4; //8-5
        if MidStr(Codigo,5,2)  = '00' then Longitud := 2; //6-4
        if MidStr(Codigo,3,2)  = '00' then Longitud := 1; //4-3
        if Midstr(Codigo,2,1)  = '0'  then Longitud := 1; //1-2
        Insert(LeftStr(Codigo,Longitud),Cadena,1);
        Result := Cadena;
end;

function TfrmPlandeCuentas.EvaluarNivel(Codigo: String): Integer;
var Longitud : Integer;
begin
        Longitud := 0;
        if Midstr(codigo,1,1)  <> '0'  then Longitud := 1;
        if MidStr(Codigo,2,1)  <> '0'  then Longitud := 2;
        if MidStr(Codigo,3,2)  <> '00' then Longitud := 3;
        if MidStr(Codigo,5,2)  <> '00' then Longitud := 4;
        if MidStr(Codigo,7,2)  <> '00' then Longitud := 5;
        if MidStr(Codigo,9,2)  <> '00' then Longitud := 6;
        if MidStr(Codigo,11,2) <> '00' then Longitud := 7;
        if MidStr(Codigo,13,2) <> '00' then Longitud := 8;
        if MidStr(Codigo,15,2) <> '00' then Longitud := 9;
        if MidStr(Codigo,17,2) <> '00' then Longitud := 10;
        Result := Longitud;
end;

procedure TfrmPlandeCuentas.editcodigoExit(Sender: TObject);
var Cadena: String;
begin
        Cadena := EditCODIGO.Text;
        while Pos(' ',Cadena) > 0 do
        Cadena[Pos(' ',Cadena)] := '0';
        Codigo := Cadena;
        CodigoMayor := EvaluarCodigoMayor(Codigo);
        editcodigomayor.Text := CodigoMayor;
        Nivel := EvaluarNivel(Codigo);
        Editnivel.Text := IntToStr(Nivel);
end;


procedure TfrmPlandeCuentas.editcodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmPlandeCuentas.editcodigomayorKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmPlandeCuentas.editnombreKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmPlandeCuentas.EditsaldoinicialKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmPlandeCuentas.EditsaldoactualKeyPress(Sender: TObject;
  var Key: Char);
begin
        EnterTabs(Key,Self);
end;

procedure TfrmPlandeCuentas.EditsaldoinicialEnter(Sender: TObject);
begin
        Editsaldoinicial.SelectAll;
end;

end.
