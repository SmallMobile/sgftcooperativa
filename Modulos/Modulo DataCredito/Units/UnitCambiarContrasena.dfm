object frmCambiarContrasena: TfrmCambiarContrasena
  Left = 268
  Top = 199
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Cambiar Contrase'#241'a'
  ClientHeight = 199
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000000020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF008888
    88888888800000008888888888888888888888800FFF88870088888888888888
    8888880FFF00000F8708888888888888888880FF000080000870888888888888
    88880FF00000800000870888888888888880FF00F00000008008708888888888
    8880FF000F000008000F808888888888880FF000000887000000F70888888888
    880FF00000FF88700000F80888888888880FF0FF00FFF8800880F80888888888
    880FF00000FFFF800000F80888888888880FF000000FFF000000FF0888888888
    880FFF000F00000F000FFF0888888888880FFF00F0000000F00FFF0888888888
    8880FFF00000F00000FFF088888888888880FFFF0000F0000FFFF08888888888
    88880FFFFF00000FFFFF088888888888888880FFFFFF0FFFFFF0888888888888
    8888800FFFF000FFFF00888888888888888880800FFFFFFF0080888888888888
    88888080800000008080888888888888888880F08888888880F0888888880000
    000000000000000000F0000000008888888888888888888880F0888888888888
    888888888888888880F08888888888FFFFFFFFFFFFFFFFFFF0F0FFFFFFFF8807
    777770707777777770F077777777880AAAAAA0770AAAAAAA0FF0AAAAAAAA880A
    AAAAAA07F00AAA00FF0AAAAAAAAA880AAAAAAAA07FF000FFF0AAAAAAAAAA880A
    AAAAAAAA00FFFFF00AAAAAAAAAAA880AAAAAAAAAAA00000AAAAAAAAAAAAA0000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 12
    Width = 130
    Height = 13
    Caption = 'Digite la Nueva Contrase'#241'a'
  end
  object Label2: TLabel
    Left = 8
    Top = 36
    Width = 151
    Height = 13
    Caption = 'Reescriba la Nueva Contrase'#241'a'
  end
  object Label3: TLabel
    Left = 10
    Top = 70
    Width = 37
    Height = 13
    Caption = 'Nombre'
  end
  object Label4: TLabel
    Left = 10
    Top = 94
    Width = 42
    Height = 13
    Caption = 'Apellidos'
  end
  object Label5: TLabel
    Left = 10
    Top = 122
    Width = 53
    Height = 13
    Caption = 'ID Usuario:'
  end
  object Label6: TLabel
    Left = 10
    Top = 144
    Width = 46
    Height = 13
    Caption = 'ID Grupo:'
  end
  object EdPasabordo: TEdit
    Left = 162
    Top = 8
    Width = 121
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 15
    PasswordChar = '*'
    TabOrder = 0
  end
  object EdRePasabordo: TEdit
    Left = 162
    Top = 32
    Width = 121
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 15
    PasswordChar = '*'
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 171
    Width = 290
    Height = 28
    Align = alBottom
    Color = clOlive
    TabOrder = 2
    object CmdCambiar: TBitBtn
      Left = 136
      Top = 2
      Width = 75
      Height = 25
      Caption = '&Cambiar'
      TabOrder = 0
      OnClick = CmdCambiarClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000D30E0000D30E00000001000000010000008C00000094
        0000009C000000A5000000940800009C100000AD100000AD180000AD210000B5
        210000BD210018B5290000C62900319C310000CE310029AD390031B5420018C6
        420000D6420052A54A0029AD4A0029CE5A006BB5630000FF63008CBD7B00A5C6
        94005AE7A500FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF001B1B1B1B1B13
        04161B1B1B1B1B1B1B1B1B1B1B1B1B0B0A01181B1B1B1B1B1B1B1B1B1B1B160A
        0C030D1B1B1B1B1B1B1B1B1B1B1B050E0C0601191B1B1B1B1B1B1B1B1B130E0C
        170E02001B1B1B1B1B1B1B1B1B0B1517170A0C01181B1B1B1B1B1B1B1B111717
        13130C030D1B1B1B1B1B1B1B1B1B08081B1B070C01191B1B1B1B1B1B1B1B1B1B
        1B1B100C02001B1B1B1B1B1B1B1B1B1B1B1B1B090C01181B1B1B1B1B1B1B1B1B
        1B1B1B130C0F101B1B1B1B1B1B1B1B1B1B1B1B1B141A0F181B1B1B1B1B1B1B1B
        1B1B1B1B1012181B1B1B1B1B1B1B1B1B1B1B1B1B1B191B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B}
    end
    object CmdCerrar: TBitBtn
      Left = 214
      Top = 2
      Width = 75
      Height = 25
      Caption = '&Cerrar'
      TabOrder = 1
      OnClick = CmdCerrarClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000220B0000220B00000001000000010000006400004242
        42008C6363009A666600B9666600BB686800B0717200C3686900C66A6B00C76A
        6D00CF6C6E00D2686900D16D6E00CC6E7100C0797A00D2707200D4707100D572
        7300D0727500D3747600D9757600D8767700E37D7E000080000000960000DC7F
        8000FF00FF00D7868700DA888800D8888A00DA888A00DF898A00E6808100E085
        8500E9818200EE868700E3888900E78C8D00F0878800F18B8C00F28B8C00F18D
        8E00F48C8D00F48E8F00EB8F9000EC969700E49A9800F3919200F7909100F791
        9200F2939400F9909200F9949500FA949500F9969700F0999A00FC999A00FF9D
        9E00F7B58400F5A7A500FACCAA00FBD6BB00FADCDC00FFFFFF00000000000000
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
        00000000000000000000000000000000000000000000000000001A1A1A1A1A1A
        1A02011A1A1A1A1A1A1A1A1A1A1A02030405011A1A1A1A1A1A1A1A1A0203080B
        0B07010303030303031A1A1A030C0C0C0A09010E1F323B3B031A1A1A030C0C10
        0F0D01181818183B031A1A1A03111114151201181818183B031A1A1A03161616
        201301181717173B031A1A1A0326222D3E1D01171700003B031A1A1A03262337
        3F1E013C3A3A3A3B031A1A1A03272B282A19013C3D3D3D3B031A1A1A03273031
        2921013C3D3D3D3B031A1A1A032734352F24013C3D3D3D3B031A1A1A03273338
        3625013C3D3D3D3B031A1A1A03032E33392C013C3D3D3D3B031A1A1A1A1A0306
        1B1C010303030303031A1A1A1A1A1A1A0303011A1A1A1A1A1A1A}
    end
  end
  object EdNombre: TStaticText
    Left = 54
    Top = 68
    Width = 233
    Height = 19
    AutoSize = False
    BorderStyle = sbsSunken
    Color = clWhite
    ParentColor = False
    TabOrder = 3
  end
  object EdApellidos: TStaticText
    Left = 54
    Top = 92
    Width = 233
    Height = 19
    AutoSize = False
    BorderStyle = sbsSunken
    Color = clWhite
    ParentColor = False
    TabOrder = 4
  end
  object EdUID: TStaticText
    Left = 66
    Top = 118
    Width = 81
    Height = 19
    AutoSize = False
    BorderStyle = sbsSunken
    Color = clWhite
    ParentColor = False
    TabOrder = 5
  end
  object EdGID: TStaticText
    Left = 66
    Top = 140
    Width = 81
    Height = 19
    AutoSize = False
    BorderStyle = sbsSunken
    Color = clWhite
    ParentColor = False
    TabOrder = 6
  end
  object IBSS1: TIBSecurityService
    Protocol = TCP
    LoginPrompt = False
    TraceFlags = []
    SecurityAction = ActionModifyUser
    UserID = 0
    GroupID = 0
    Left = 8
    Top = 30
  end
end
