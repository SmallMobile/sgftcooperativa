object frmVerify: TfrmVerify
  Left = 440
  Top = 67
  Width = 184
  Height = 207
  Caption = 'Verificaci'#243'n'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 38
    Top = 5
    Width = 100
    Height = 130
    Stretch = True
  end
  object BitBtn1: TBitBtn
    Left = 36
    Top = 98
    Width = 105
    Height = 33
    Caption = 'Inicio'
    TabOrder = 0
    Visible = False
    OnClick = BitBtn1Click
  end
  object cmd_Exit: TBitBtn
    Left = 36
    Top = 136
    Width = 105
    Height = 33
    Caption = '&Salir'
    TabOrder = 1
    OnClick = cmd_ExitClick
  end
  object FPGetTemplate1: TFPGetTemplate
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnDone = FPGetTemplate1Done
    OnSampleReady = FPGetTemplate1SampleReady
    Left = 34
    Top = 48
  end
end
