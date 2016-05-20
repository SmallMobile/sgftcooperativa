object frmAExcel: TfrmAExcel
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Seleccionar Registro y Exportar a Excel'
  ClientHeight = 409
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 586
    Height = 33
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 8
      Top = 11
      Width = 73
      Height = 13
      Caption = 'A'#241'o a Procesar'
    end
    object edYear: TJvValidateEdit
      Left = 87
      Top = 8
      Width = 42
      Height = 21
      CriticalPoints.MaxValueIncluded = False
      CriticalPoints.MinValueIncluded = False
      DisplayFormat = dfYear
      EditText = '2000'
      MaxLength = 4
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 143
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Procesar'
      TabOrder = 1
    end
    object BitBtn2: TBitBtn
      Left = 224
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Exportar'
      Enabled = False
      TabOrder = 2
    end
    object BitBtn3: TBitBtn
      Left = 504
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Cerrar'
      TabOrder = 3
      OnClick = BitBtn3Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 33
    Width = 586
    Height = 376
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 96
    ExplicitTop = 128
    ExplicitWidth = 185
    ExplicitHeight = 41
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 584
      Height = 374
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = -3
      ExplicitWidth = 466
      ExplicitHeight = 257
    end
  end
end
