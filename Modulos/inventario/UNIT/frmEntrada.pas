unit frmEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, IBCustomDataSet, StdCtrls, Mask, DBCtrls,
  ExtCtrls;

type
  TEntrada = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IBDataSet2cod_clasificacionValidate(Sender: TField);
    procedure IBDataSet1descripcionValidate(Sender: TField);
    procedure IBDataSet1nombreValidate(Sender: TField);
  private
    { Private declarations }
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
  public
    { Public declarations }
  end;

var
  Entrada: TEntrada;

implementation
uses    FrmDatamodulo;



{$R *.dfm}

procedure TEntrada.FormCreate(Sender: TObject);
begin
DataGeneral:=Tdatageneral.Create(self);
ibdataset1.Active:=true;

end;

procedure TEntrada.Button2Click(Sender: TObject);
begin
ibdataset1.Insert;
//ibdataset1cod_clasificacion.

datageneral.IBTransaction1.CommitRetaining;
dbgrid1.Columns.Grid.SetFocus;
//ibdataset1cod_clasificacion.NewValue;
end;

procedure TEntrada.IBDataSet2cod_clasificacionValidate(Sender: TField);
begin
listbox1.Items.Add(ibdataset1cod_clasificacion.Text);
end;

procedure TEntrada.IBDataSet1descripcionValidate(Sender: TField);
begin
 listbox1.Items.Add(ibdataset1cod_clasificacion.Text);
end;

procedure TEntrada.IBDataSet1nombreValidate(Sender: TField);
begin
ibdataset1descripcion.Text:='sdjkfhg';
end;
procedure Tentrada.cmChildKey(var msg: TWMKEY);
begin
  if msg.CharCode = VK_RETURN then
    if not (Assigned(ActiveControl) and
           ((ActiveControl is TButton) or
            (ActiveControl is TCustomMemo)))
    then begin
      msg.Result := 1;
      keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), 0, 0);
      keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), KEYEVENTF_KEYUP, 0);
    end;
end;


end.
