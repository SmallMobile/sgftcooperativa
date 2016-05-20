unit UnitConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBTables, DB, StdCtrls, ADODB;

type
  TForm1 = class(TForm)
    Database1: TDatabase;
    Session1: TSession;
    Button1: TButton;
    Edit1: TEdit;
    ADOConnection1: TADOConnection;
    Query1: TADOQuery;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var     sentencia :string;
begin
        //sentencia := 'select * from equivida where  equivida .numdocum = ' + '''' + Edit1.Text + '''';
        sentencia := 'select certificado,fecha_venc from equivida where  poliza <> '+ '''' + '''' + ' and equivida .numdocum = ' + '''' + Edit1.Text + '''';
        with Query1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add(sentencia);
          ShowMessage(sentencia);
          Open;
          while not Eof do
          begin
            ShowMessage(FieldByName('certificado').AsString + ' - ' + FieldByName('fecha_venc').AsString);
            Next;
          end;
        end;

end;

end.
