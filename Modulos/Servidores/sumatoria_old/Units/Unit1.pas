unit Unit1;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, DBXpress, DB, SqlExpr, FMTBcd;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.xfm}

end.
