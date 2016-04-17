unit UnitPlandeCuentas1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, DB, DBClient, Grids,
  DBGrids, IBSQL, IBCustomDataSet, IBQuery;

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
    Label13: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    editcodigomayor: TMaskEdit;
    Label12: TLabel;
    Editnivel: TMaskEdit;
    Label15: TLabel;
    Editsaldoinicial: TMemo;
    Label16: TLabel;
    Editsaldoactual: TMemo;
    CheckBoxmovimiento: TCheckBox;
    CheckBoxesbanco: TCheckBox;
    DBNavigator1: TDBNavigator;
    CDPuc: TClientDataSet;
    DSPuc: TDataSource;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    DBpUC: TDBGrid;
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
    IBQuery1: TIBQuery;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPlandeCuentas: TfrmPlandeCuentas;

implementation

{$R *.dfm}

uses UnitGlobales, UnitDmGeneral;

procedure TfrmPlandeCuentas.FormShow(Sender: TObject);
begin
        with IBSQL1 do begin
         Close;
         SQL.Clear;
         SQL.Add('select * from  "con$puc"');
         ExecQuery;
         while not Eof do begin
          CDPuc.Append;
          
         end;

        end;
end;

end.
