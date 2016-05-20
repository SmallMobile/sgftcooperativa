object login: Tlogin
  Left = 297
  Top = 193
  Width = 218
  Height = 134
  BorderIcons = [biSystemMenu]
  Caption = 'Validar Usuario'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000888
    8888888888888888888888888888000000000000000000000000000000080F88
    88888888888888888888888888080F7F7F7F7F7F7F7F7F7F7F7F7F7F78080FF7
    F7F7F7F7F7700000F7000007F8080F7F7F7F7F7F7F7F88F077888F0F78080FF7
    F7F7F7F7F7777777F7777777F8080F7F7F7F7F7F7F7F7F7F7F7F7F7F78080FF7
    F7F7F7F7F7F7F7F7F7F7F7F7F8080F7F7F7F7F7F7F7F7F7F7F7F7F7F78080FF7
    000000000000000000000007F8080F770F0F0F0F0F0F0FFFFFFFFF0F78080FF7
    F0FFF0FFF0FF0FFFFFFFFF07F8080F770F0F0F0F0F0F0FFFFFFFFF0F78080FF7
    777777777777777777777777F8080F7F707F7F7F7F7F7F7F7F7F7F7F78080FF7
    0707F0F0F7F7F7F7F7F7F7F7F8080F7F0F0000000F7F7F7F7F7F7F7F78080FF7
    F0F7F7F7F7F7F7F7F7F7F7F7F8080F7F7F7F7F7F7F7F7F7F7F7F7F7F78080FFF
    FFFFFFFFFFFFFFFFFFFFFFFFFF08000000000000000000000000000000080CCC
    CCCCCCCCCCCCCCCCCCCC07070708000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFFFFFFFFF800000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 6
    Width = 44
    Height = 13
    Caption = 'Usuario'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 7
    Top = 36
    Width = 65
    Height = 13
    Caption = 'Contrase'#241'a'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object usuario: TEdit
    Left = 75
    Top = 7
    Width = 124
    Height = 21
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnKeyPress = usuarioKeyPress
  end
  object password: TEdit
    Left = 75
    Top = 37
    Width = 124
    Height = 21
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = passwordKeyPress
  end
  object aceptar: TBitBtn
    Left = 19
    Top = 68
    Width = 71
    Height = 25
    HelpType = htKeyword
    Caption = '&Aceptar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ModalResult = 1
    ParentFont = False
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 111
    Top = 67
    Width = 71
    Height = 25
    Caption = '&Cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn1Click
  end
end
