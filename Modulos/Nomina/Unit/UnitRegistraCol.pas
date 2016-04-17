unit UnitRegistraCol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, DB, DBClient,
  IBCustomDataSet, IBQuery, Buttons, IBDatabase;

type
  TFrmDesmarcarCol = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    DbEmpleado: TDBLookupComboBox;
    GroupBox1: TGroupBox;
    DbFianzas: TDBGrid;
    DsColocacion: TDataSource;
    DataSource2: TDataSource;
    CdColocacion: TClientDataSet;
    CdColocacionID_COLOCACION: TStringField;
    CdColocacionFECHAK: TDateField;
    CdColocacionFECHAI: TDateField;
    CdColocacionESTADO: TBooleanField;
    IBQuery1: TIBQuery;
    BitBtn1: TBitBtn;
    IBQuery2: TIBQuery;
    DBCheckBox2: TDBCheckBox;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    IBQuery3: TIBQuery;
    IBTransaction1: TIBTransaction;
    CdColocacionID_PERSONA: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DbEmpleadoKeyPress(Sender: TObject; var Key: Char);
    procedure DbFianzasColExit(Sender: TObject);
    procedure DbFianzasDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DbFianzasKeyPress(Sender: TObject; var Key: Char);
    procedure DbFianzasDblClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDesmarcarCol: TFrmDesmarcarCol;

implementation
uses UnitGlobales, UnitPrincipal, UnitGlobal;

{$R *.dfm}

procedure TFrmDesmarcarCol.FormCreate(Sender: TObject);
begin
        IBQuery1.Close;
        IBQuery1.Open;
        IBQuery1.Last;
end;

procedure TFrmDesmarcarCol.BitBtn1Click(Sender: TObject);
begin
        CdColocacion.CancelUpdates;
        with IBQuery2 do
        begin
          if Transaction.InTransaction then
             Transaction.Rollback;
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('"col$colocacion".ID_COLOCACION,');
          SQL.Add('"col$colocacion".FECHA_INTERES,');
          SQL.Add('"col$colocacion".FECHA_CAPITAL');
          SQL.Add('FROM');
          SQL.Add('"col$colocacion"');
          SQL.Add('WHERE');
          SQL.Add('("col$colocacion".ID_PERSONA = :ID_PERSONA) AND ');
          SQL.Add('("col$colocacion".ID_ESTADO_COLOCACION = 0)');
          ParamByName('ID_PERSONA').AsString := DbEmpleado.KeyValue;
          Open;
          while not Eof do
          begin
            CdColocacion.Append;
            CdColocacion.FieldValues['ID_COLOCACION'] := FieldByName('ID_COLOCACION').AsString;
            CdColocacion.FieldValues['FECHAK'] := FieldByName('FECHA_CAPITAL').AsDateTime;
            CdColocacion.FieldValues['FECHAI'] := FieldByName('FECHA_INTERES').AsDateTime;
            CdColocacion.FieldValues['ID_PERSONA'] := DbEmpleado.KeyValue;
            CdColocacion.FieldValues['ESTADO'] := BuscaCol(FieldByName('ID_COLOCACION').AsString);
            CdColocacion.Post;
            Next;
          end;

        end;
end;

procedure TFrmDesmarcarCol.DbEmpleadoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           BitBtn1.SetFocus
end;

procedure TFrmDesmarcarCol.DbFianzasColExit(Sender: TObject);
begin
if DbFianzas.SelectedField.FieldName = DBCheckBox2.DataField then
    DBCheckBox2.Visible := False;

end;

procedure TFrmDesmarcarCol.DbFianzasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
const IsChecked : array[Boolean] of Integer =
      (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
var
  DrawState: Integer;
  DrawRect: TRect;
begin
  if (gdFocused in State) then
  begin
    if (Column.Field.FieldName = DBCheckBox2.DataField) then
    begin
     DBCheckBox2.Left := Rect.Left + DbFianzas.Left + 5;    //15
     DBCheckBox2.Top := Rect.Top + DbFianzas.top + 2;        //2
     DBCheckBox2.Width := 27;//Rect.Right - Rect.Left;
     DBCheckBox2.Height := 17;//Rect.Bottom - Rect.Top;
     DBCheckBox2.Visible := True;
    end
  end
  else
  begin
    if (Column.Field.FieldName = DBCheckBox2.DataField) then
    begin
      DrawRect:=Rect;
      InflateRect(DrawRect,-1,-1);

      DrawState := ISChecked[Column.Field.AsBoolean];

      DbFianzas.Canvas.FillRect(Rect);
      DrawFrameControl(DbFianzas.Canvas.Handle, DrawRect,
                       DFC_BUTTON, DrawState);
    end;
  end;

end;

procedure TFrmDesmarcarCol.DbFianzasKeyPress(Sender: TObject; var Key: Char);
begin
if (key = Chr(9)) then Exit;

  if (DbFianzas.SelectedField.FieldName = DBCheckBox2.DataField) then
  begin
    DBCheckBox2.SetFocus;
    SendMessage(DBCheckBox2.Handle, WM_Char, word(Key), 0);
  end;

end;

procedure TFrmDesmarcarCol.DbFianzasDblClick(Sender: TObject);
begin
        CdColocacion.Edit;
        if CdColocacionESTADO.Value = True then
          CdColocacionESTADO.Value := False
        else
          CdColocacionESTADO.Value := True;
        CdColocacion.Post;
end;

procedure TFrmDesmarcarCol.BitBtn4Click(Sender: TObject);
begin
        Close;
end;

procedure TFrmDesmarcarCol.BitBtn3Click(Sender: TObject);
begin
        CdColocacion.CancelUpdates;
        DbEmpleado.SetFocus;
end;

procedure TFrmDesmarcarCol.BitBtn2Click(Sender: TObject);
var     vCambio :Boolean;
begin
        vCambio := False;
        if MessageDlg('Esta Seguro de Realizar la Operación',mtInformation,[mbyes,mbno],0) = mrno then
           Exit;
        with IBQuery3 do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Rollback;
          Transaction.StartTransaction;
          SQL.Clear;
          CdColocacion.First;
//          CdColocacion.Filtered := False;
//          CdColocacion.Filter := 'ESTADO = TRUE';
//          CdColocacion.Filtered := True;
          while not CdColocacion.Eof do
          begin
            SQL.Clear;
            if (BuscaCol(CdColocacionID_COLOCACION.Value) = False) and (CdColocacionESTADO.Value = True) then
            begin
              SQL.Add('insert into "nom$colocacion" values (:ID_COLOCACION,:ID_PERSONA,:ID_EMPLEADO,:FECHA_REGISTRO,NULL,1,:HORA)');
              ParamByName('ID_COLOCACION').AsString := CdColocacionID_COLOCACION.Value;
              ParamByName('ID_PERSONA').AsString := CdColocacionID_PERSONA.Value;
              ParamByName('ID_EMPLEADO').AsString := uppercase(frmain.DBAlias);
              ParamByName('FECHA_REGISTRO').AsDate := fFechaActual;
              ParamByName('HORA').AsTime := Time;
              ExecSQL;
              vCambio := True;
            end
            else if (BuscaCol(CdColocacionID_COLOCACION.Value) = True) and (CdColocacionESTADO.Value = False) then
            begin
              SQL.Add('update "nom$colocacion" set ESTADO = 0, FECHA_SALIDA = :FECHA where ID_COLOCACION = :ID and ESTADO = 1');
              ParamByName('ID').AsString := CdColocacionID_COLOCACION.Value;
              ParamByName('FECHA').AsDate := fFechaActual;
              ExecSQL;
              vCambio := True;
            end;

          CdColocacion.Next;
          end;
          if vCambio then
          begin
            Transaction.Commit;
            MessageDlg('Operación Registrada con Exito',mtInformation,[mbok],0);
          end
          else
             MessageDlg('No se Realizo Ninguna Operación',mtInformation,[mbok],0);
          CdColocacion.CancelUpdates;
        end;
end;

end.
