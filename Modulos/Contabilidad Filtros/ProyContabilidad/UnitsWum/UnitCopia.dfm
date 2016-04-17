object FrmCopia: TFrmCopia
  Left = 207
  Top = 97
  Width = 337
  Height = 300
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'Copia de Seguridad'
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
    Width = 329
    Height = 225
    Caption = 'Panel1'
    TabOrder = 0
    object Memo1: TMemo
      Left = 0
      Top = -1
      Width = 328
      Height = 224
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 225
    Width = 329
    Height = 41
    Caption = 'Panel2'
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 120
      Top = 8
      Width = 91
      Height = 25
      Caption = '&Realizar Copia'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object IB: TIBBackupService
    ServerName = 'localhost'
    Protocol = TCP
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    TraceFlags = []
    Verbose = True
    BlockingFactor = 0
    Options = []
    Left = 136
    Top = 24
  end
end
