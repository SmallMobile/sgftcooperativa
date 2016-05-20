unit UnitGrupo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, JvPanel, Buttons, DB,
  DBClient;

type
  TFrmGrupo = class(TForm)
    JvPanel1: TJvPanel;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BTverificar: TBitBtn;
    BTeliminar: TBitBtn;
    CDgrupo: TClientDataSet;
    CDgrupodocumento: TStringField;
    CDgruponombres: TStringField;
    CDgrupoprograma: TIntegerField;
    CDgrupoparentesco: TStringField;
    CDgrupoEps: TStringField;
    CDgrupocarnet: TStringField;
    DSgrupo: TDataSource;
    CDgrupofecha: TDateField;
    procedure BTverificarClick(Sender: TObject);
    procedure BTeliminarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGrupo: TFrmGrupo;

implementation
uses unitBusca, UnitQuerys, UnitGlobal;

{$R *.dfm}

procedure TFrmGrupo.BTverificarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmGrupo.BTeliminarClick(Sender: TObject);
begin
        if MessageDlg('Esta Seguro de Eliminar Defitivamente a'+#13+CDgruponombres.Text,mtInformation,[mbyes,mbno],0) = mryes then
        begin
        with DataQuerys.IBdatos do
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('delete from "fun$afiliacion"');
          SQL.Add('where "fun$afiliacion"."nit_beneficiario" = :nit');
          SQL.Add('and "fun$afiliacion"."id_convenio" = :convenio');
          ParamByName('convenio').AsInteger := CDgrupoprograma.Value;
          ParamByName('nit').AsString := CDgrupodocumento.Text;
          Open;
          Close;
          Transaction.Commit;
        end;
        try
          CDgrupo.Delete;
        except
          BTeliminar.SetFocus;
        end;
        end;
end;

end.
