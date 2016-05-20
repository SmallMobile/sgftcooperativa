unit UnitEliCapacitacion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, DB, IBDatabase,
  IBCustomDataSet, IBQuery;

type
  TFrmElicapacitacion = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    DBcap: TDBLookupComboBox;
    IBQuery1: TIBQuery;
    IBTransaction1: TIBTransaction;
    DataSource1: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmElicapacitacion: TFrmElicapacitacion;

implementation

uses UnitQuerys;

{$R *.dfm}

procedure TFrmElicapacitacion.FormCreate(Sender: TObject);
begin
        IBQuery1.Open;
        IBQuery1.Last;
        DataQuerys := TDataQuerys.Create(self);
end;

procedure TFrmElicapacitacion.BitBtn1Click(Sender: TObject);
begin
        with DataQuerys.IBdatos do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$capacitacionper"."id_persona"');
          SQL.Add('FROM');
          SQL.Add('"fun$capacitacionper"');
          SQL.Add('WHERE');
          SQL.Add('("fun$capacitacionper"."id_capacitacion" = :id)');
          ParamByName('id').AsInteger := DBcap.KeyValue;
          Open;
          if RecordCount <> 0 then
          begin
             MessageDlg('Debe eliminar primero los participantes de la Capacitación',mtWarning,[mbok],0);
             Exit;
          end
          else
          begin
            SQL.Clear;
            SQL.Add('delete from "fun$capacitacion" where "fun$capacitacion"."id_capacitacion" = :id');
            ParamByName('id').AsInteger := DBcap.KeyValue;
            Open;
            Transaction.Commit;
            if IBQuery1.Transaction.InTransaction then
               IBQuery1.Transaction.Commit;
            IBQuery1.Transaction.StartTransaction;
            IBQuery1.Open;
            IBQuery1.Last;
          end;

        end;
end;

end.
