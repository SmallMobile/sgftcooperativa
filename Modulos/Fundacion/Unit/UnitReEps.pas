unit UnitReEps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DB, DBClient, IBCustomDataSet, IBQuery,
  StdCtrls, Buttons;

type
  TFrmReEps = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    CDeps: TClientDataSet;
    DSeps: TDataSource;
    CDepsnombres: TStringField;
    IBQuery1: TIBQuery;
    CDepsid_eps: TIntegerField;
    CDepseps: TStringField;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CDepsnit_beneficiario: TStringField;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    function verifica(nit: string): Boolean;  { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmReEps: TFrmReEps;

implementation

uses UnitQuerys, UnitGlobal, UnitAfiliacion, UnitNuevaAfiliacion;

{$R *.dfm}

procedure TFrmReEps.BitBtn1Click(Sender: TObject);
begin
       DataQuerys := TDataQuerys.Create(self);
       with CDeps do
        begin
          First;
          while not Eof do
          begin
            if FieldValues['id_eps'] <> 0 then
            begin
               verifica(FieldValues['nit_beneficiario']);
               with DataQuerys.IBdatos do
               begin
                Close;
                verificatransaccion(DataQuerys.IBdatos);
                SQL.Clear;
                SQL.Add('insert into "fun$afiliacioneps" values (');
                SQL.Add(':id_eps,:nit_beneficiario,:id_convenio)');
                ParamByName('id_eps').AsInteger := CDeps.FieldValues['id_eps'];
                ParamByName('nit_beneficiario').AsString := CDeps.FieldValues['nit_beneficiario'];
                ParamByName('id_convenio').AsInteger := 1;
                Open;
                Close;
                Transaction.Commit;
              end;
            end;
            Next;
          end;
       end;
       Self.Close;
end;

procedure TFrmReEps.BitBtn2Click(Sender: TObject);
begin
        Close;
end;

function TFrmReEps.verifica(nit: string): Boolean;
begin
        with DataQuerys.IBselecion do
        begin
          Close;
          verificatransaccion(DataQuerys.IBselecion);
          SQL.Clear;
          SQL.Add('DELETE');
          SQL.Add('FROM');
          SQL.Add('"fun$afiliacioneps"');
          SQL.Add('WHERE');
          SQL.Add('("fun$afiliacioneps"."nit_beneficiario" = :id)');
          ParamByName('id').AsString := nit;
          Open;
          Close;
          Transaction.Commit;
        end;
end;

end.
