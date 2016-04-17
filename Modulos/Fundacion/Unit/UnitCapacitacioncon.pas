unit UnitCapacitacioncon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, DB, IBCustomDataSet, IBQuery, IBDatabase, StdCtrls,
  ExtCtrls, Buttons, Grids, DBGrids, DBClient;

type
  TFrmCapacitacionCon = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    DataSource2: TDataSource;
    descripcion: TDBLookupComboBox;
    conferencista: TDBLookupComboBox;
    IBQuery2: TIBQuery;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Panel3: TPanel;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    cdconferencista: TClientDataSet;
    cdconferencistaid_capacitacion: TIntegerField;
    cdconferencistaid_persona: TIntegerField;
    cdconferencistanombre: TStringField;
    cdconferencistaentidad: TStringField;
    DataSource3: TDataSource;
    Panel4: TPanel;
    BCancelar: TSpeedButton;
    SPcerrar: TSpeedButton;
    Baceptar: TBitBtn;
    IBTransaction2: TIBTransaction;
    procedure FormCreate(Sender: TObject);
    procedure SPcerrarClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BaceptarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure descripcionExit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure descripcionKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCapacitacionCon: TFrmCapacitacionCon;

implementation

uses UnitQuerys,UnitGlobal, UnitConferencista;

{$R *.dfm}

procedure TFrmCapacitacionCon.FormCreate(Sender: TObject);
begin
        DataQuerys := TDataQuerys.Create(self);
        IBQuery1.Open;
        IBQuery2.Open;
        IBQuery1.Last;
        IBQuery2.Last;

end;

procedure TFrmCapacitacionCon.SPcerrarClick(Sender: TObject);
begin
        Close;
end;

procedure TFrmCapacitacionCon.BitBtn2Click(Sender: TObject);
var     entidad :string;
begin
        with DataQuerys.IBdatos DO
        begin
          Close;
          verificatransaccion(DataQuerys.IBdatos);
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"fun$conferencista"."entidad"');
          SQL.Add('FROM');
          SQL.Add('"fun$conferencista"');
          SQL.Add('where "fun$conferencista"."id_conferencista" = :id');
          ParamByName('id').AsInteger := conferencista.KeyValue;
          Open;
          entidad := FieldByName('entidad').AsString;
          Close;
        end;
        if not (cdconferencista.Locate('id_persona',conferencista.KeyValue,[loPartialKey])) then
        begin
        with cdconferencista do
        begin
          Append;
          FieldValues['id_capacitacion'] := descripcion.KeyValue;
          FieldValues['id_persona'] := conferencista.KeyValue;
          FieldValues['nombre'] := conferencista.Text;
          FieldValues['entidad'] := entidad;
          Post;
        end;
        end;
end;

procedure TFrmCapacitacionCon.BaceptarClick(Sender: TObject);
begin
        with cdconferencista do
        begin
          First;
          while not Eof do
          begin
            with DataQuerys.IBdatos do
            begin
              Close;
              verificatransaccion(DataQuerys.IBdatos);
              SQL.Clear;
              SQL.Add('insert into "fun$capacitacioncon" values (');
              SQL.Add(':id_capacitacion,:id_conferencista)');
              ParamByName('id_capacitacion').AsInteger := cdconferencista.FieldValues['id_capacitacion'];
              ParamByName('id_conferencista').AsInteger := cdconferencista.FieldValues['id_persona'];
              Open;
              Close;
              Transaction.Commit;
           end;
           Next;
          end;
        end;
        BCancelar.Click;
end;


procedure TFrmCapacitacionCon.BCancelarClick(Sender: TObject);
begin
        cdconferencista.CancelUpdates;
        descripcion.SetFocus
end;

procedure TFrmCapacitacionCon.descripcionExit(Sender: TObject);
begin
        cdconferencista.CancelUpdates;
end;

procedure TFrmCapacitacionCon.BitBtn3Click(Sender: TObject);
begin
        FrmConferencista := TFrmConferencista.Create(self);
        FrmConferencista.ShowModal;
end;

procedure TFrmCapacitacionCon.DBGrid1DblClick(Sender: TObject);
begin
        try
          cdconferencista.Delete;
        except
        on e: Exception do
        MessageDlg('No Existen Datos Para Eliminar',mtInformation,[mbok],0);
        end;



end;

procedure TFrmCapacitacionCon.descripcionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
           conferencista.SetFocus
end;

end.
