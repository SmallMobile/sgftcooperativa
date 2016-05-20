unit reporte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FR_View, ComCtrls, ImgList, ToolWin, FR_Ctrls;

type
  Tipresion = class(TForm)
    frPreview1: TfrPreview;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton2: TToolButton;
    pagsig: TToolButton;
    ToolButton6: TToolButton;
    ToolButton4: TToolButton;
    ToolButton7: TToolButton;
    frSpeedButton1: TfrSpeedButton;
    ToolButton8: TToolButton;
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure pagsigClick(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure frSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ipresion: Tipresion;

implementation

uses Frmreportesgenerales;


{$R *.dfm}

procedure Tipresion.ToolButton3Click(Sender: TObject);
begin
        frPreview1.Print;
end;

procedure Tipresion.ToolButton5Click(Sender: TObject);
begin
        frPreview1.SaveToFile;
end;

procedure Tipresion.ToolButton1Click(Sender: TObject);
begin
        frPreview1.PageSetupDlg;
end;

procedure Tipresion.pagsigClick(Sender: TObject);
begin
        frPreview1.Prev;
end;

procedure Tipresion.ToolButton6Click(Sender: TObject);
begin
        frPreview1.Next;
end;

procedure Tipresion.ToolButton7Click(Sender: TObject);
begin
        Self.Close;
end;

procedure Tipresion.frSpeedButton1Click(Sender: TObject);
begin
        frPreview1.SaveToFile;
end;

end.
