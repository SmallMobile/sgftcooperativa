object FrmActualiza: TFrmActualiza
  Left = 190
  Top = 172
  Width = 419
  Height = 231
  BorderIcons = [biSystemMenu]
  Caption = 'Actualiza descripcion de Inventarios'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 409
    Height = 89
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 12
      Width = 40
      Height = 13
      Caption = 'Codigo'
    end
    object JvLabel1: TJvLabel
      Left = 11
      Top = 42
      Width = 68
      Height = 13
      Caption = 'Descripcion'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object codigo: TJvEdit
      Left = 88
      Top = 10
      Width = 59
      Height = 21
      Alignment = taRightJustify
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 0
      OnExit = codigoExit
      OnKeyPress = codigoKeyPress
    end
    object titulo: TJvEdit
      Left = 88
      Top = 41
      Width = 305
      Height = 21
      ClipBoardCommands = [caCopy]
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      PasswordChar = #0
      ReadOnly = True
      TabOrder = 1
    end
  end
  object JvPanel1: TJvPanel
    Left = 0
    Top = 90
    Width = 409
    Height = 71
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    MultiLine = False
    object Label2: TLabel
      Left = 3
      Top = 1
      Width = 109
      Height = 13
      Caption = 'Nueva Descripci'#242'n'
    end
  end
  object JvPanel2: TJvPanel
    Left = 0
    Top = 164
    Width = 409
    Height = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    MultiLine = False
    object JvImgBtn1: TJvImgBtn
      Left = 160
      Top = 3
      Width = 75
      Height = 25
      Caption = '&Actualizar'
      TabOrder = 0
      OnClick = JvImgBtn1Click
    end
  end
  object nuevo: TJvEdit
    Left = 8
    Top = 107
    Width = 385
    Height = 42
    GroupIndex = -1
    MaxPixel.Font.Charset = DEFAULT_CHARSET
    MaxPixel.Font.Color = clWindowText
    MaxPixel.Font.Height = -11
    MaxPixel.Font.Name = 'MS Sans Serif'
    MaxPixel.Font.Style = []
    Modified = False
    SelStart = 0
    SelLength = 0
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    PasswordChar = #0
    ReadOnly = False
    TabOrder = 3
  end
end
