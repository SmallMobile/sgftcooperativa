object FrmCopia: TFrmCopia
  Left = 249
  Top = 216
  Width = 337
  Height = 300
  BorderIcons = [biSystemMenu]
  Caption = 'Copia de Seguridad'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
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
      Top = 0
      Width = 328
      Height = 222
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
    Color = clGradientInactiveCaption
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 114
      Top = 8
      Width = 104
      Height = 25
      Caption = '&Realizar Copia'
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000230B0000230B00000001000000010000191919000A3A
        54002C2B2A003D393400374546003A5C600061555D00A1522600BF480000AF56
        1F00AE5B2100704038007B635A0098605800E98F3F00E7914400EB9241000000
        82000009960029597D002E5F9300000AB5000616C9000650FF00FF00FF001F92
        F1003086E7005270FC007F788B00ECA96C00F5B17200F7B37300F9C69300FFD3
        A100FFFFFF000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000181818180003
        1818181818181818181818181818030204181818181818181818181818081805
        14010B18181818181818181818081805130C090B181818181818181818081818
        061D100A0B18181818181818180808080D201F0E0A0B18181818181818081818
        080D201F10090B18181818181808181818180D201E0F070B1818181818081818
        0808080D201C19121118181818080808082222210D1A16161211181818081818
        0808080808151B17161818181808181818181818181815151818180808080808
        1818181818181818181818082222210818181818181818181818180808080808
        1818181818181818181818181818181818181818181818181818}
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