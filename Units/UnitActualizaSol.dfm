object FrmActualizaSol: TFrmActualizaSol
  Left = 207
  Top = 249
  Width = 543
  Height = 281
  BorderIcons = [biSystemMenu]
  Caption = 'Cambios en Solicitudes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 1
    Top = 33
    Width = 534
    Height = 83
    Enabled = False
    TabOrder = 0
    object Label1: TLabel
      Left = 4
      Top = 3
      Width = 120
      Height = 13
      Caption = 'Informacion Solicitud'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Valor: TJvLabel
      Left = 7
      Top = 26
      Width = 24
      Height = 13
      Caption = 'Valor'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object JvLabel2: TJvLabel
      Left = 139
      Top = 26
      Width = 43
      Height = 13
      Caption = 'Inversi'#243'n'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object JvLabel3: TJvLabel
      Left = 351
      Top = 26
      Width = 40
      Height = 13
      Caption = 'Garantia'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object JvLabel1: TJvLabel
      Left = 7
      Top = 56
      Width = 26
      Height = 13
      Caption = 'Plazo'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object JvLabel4: TJvLabel
      Left = 82
      Top = 56
      Width = 59
      Height = 13
      Caption = 'Clasificaci'#243'n'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object JvLabel5: TJvLabel
      Left = 290
      Top = 56
      Width = 26
      Height = 13
      Caption = 'Linea'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object EDinversion: TJvEdit
      Left = 205
      Top = 24
      Width = 142
      Height = 21
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
    end
    object EDgarantia: TJvEdit
      Left = 394
      Top = 24
      Width = 135
      Height = 21
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
      TabOrder = 1
    end
    object EDplazo: TJvEdit
      Left = 34
      Top = 54
      Width = 46
      Height = 21
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
      TabOrder = 2
    end
    object EDclasificacion: TJvEdit
      Left = 144
      Top = 54
      Width = 143
      Height = 21
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
      TabOrder = 3
    end
    object EDlinea: TJvEdit
      Left = 319
      Top = 54
      Width = 135
      Height = 21
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
      TabOrder = 4
    end
    object EDvalor: TJvCurrencyEdit
      Left = 34
      Top = 24
      Width = 103
      Height = 21
      Alignment = taRightJustify
      ReadOnly = False
      TabOrder = 5
      HasMaxValue = False
      HasMinValue = False
    end
    object Chcredivida_old: TCheckBox
      Left = 459
      Top = 56
      Width = 68
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Credivida'
      TabOrder = 6
    end
  end
  object Panel2: TPanel
    Left = 1
    Top = 0
    Width = 533
    Height = 33
    TabOrder = 1
    object Label2: TLabel
      Left = 6
      Top = 8
      Width = 101
      Height = 13
      Caption = 'N'#250'mero de Radicado'
    end
    object Label3: TLabel
      Left = 180
      Top = 9
      Width = 49
      Height = 13
      Caption = 'Solicitante'
    end
    object EDradicado: TJvEdit
      Left = 110
      Top = 5
      Width = 68
      Height = 21
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      MaxLength = 10
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 0
      OnExit = EDradicadoExit
      OnKeyPress = EDradicadoKeyPress
    end
    object EDsolicitante: TJvEdit
      Left = 232
      Top = 6
      Width = 295
      Height = 21
      TabStop = False
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
  object Panel3: TPanel
    Left = 1
    Top = 116
    Width = 534
    Height = 90
    TabOrder = 2
    object Label4: TLabel
      Left = 5
      Top = 5
      Width = 116
      Height = 13
      Caption = 'Campos a Actualizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object JvLabel7: TJvLabel
      Left = 7
      Top = 26
      Width = 24
      Height = 13
      Caption = 'Valor'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object JvLabel8: TJvLabel
      Left = 139
      Top = 26
      Width = 43
      Height = 13
      Caption = 'Inversi'#243'n'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object JvLabel9: TJvLabel
      Left = 351
      Top = 26
      Width = 40
      Height = 13
      Caption = 'Garantia'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object JvLabel10: TJvLabel
      Left = 7
      Top = 56
      Width = 26
      Height = 13
      Caption = 'Plazo'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object JvLabel12: TJvLabel
      Left = 82
      Top = 56
      Width = 59
      Height = 13
      Caption = 'Clasificaci'#243'n'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object JvLabel13: TJvLabel
      Left = 290
      Top = 56
      Width = 26
      Height = 13
      Caption = 'Linea'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object EDvalor_a: TJvCurrencyEdit
      Left = 34
      Top = 24
      Width = 103
      Height = 21
      Alignment = taRightJustify
      ReadOnly = False
      TabOrder = 0
      OnExit = EDvalor_aExit
      OnKeyPress = EDvalor_aKeyPress
      HasMaxValue = False
      HasMinValue = False
    end
    object DBinversion: TDBLookupComboBox
      Left = 205
      Top = 24
      Width = 145
      Height = 21
      KeyField = 'ID_INVERSION'
      ListField = 'DESCRIPCION_INVERSION'
      ListSource = DSinversion
      TabOrder = 1
      OnKeyPress = DBinversionKeyPress
    end
    object DBgarantia: TDBLookupComboBox
      Left = 394
      Top = 24
      Width = 137
      Height = 21
      KeyField = 'ID_GARANTIA'
      ListField = 'DESCRIPCION_GARANTIA'
      ListSource = DSgarantia
      TabOrder = 2
      OnKeyPress = DBgarantiaKeyPress
    end
    object DBclasificacion: TDBLookupComboBox
      Left = 144
      Top = 54
      Width = 145
      Height = 21
      KeyField = 'ID_CLASIFICACION'
      ListField = 'DESCRIPCION_CLASIFICACION'
      ListSource = DSclasificacion
      TabOrder = 4
      OnKeyPress = DBclasificacionKeyPress
    end
    object DBlinea: TDBLookupComboBox
      Left = 319
      Top = 54
      Width = 137
      Height = 21
      KeyField = 'ID_LINEA'
      ListField = 'DESCRIPCION_LINEA'
      ListSource = DSlinea
      TabOrder = 5
      OnExit = DBlineaExit
      OnKeyPress = DBlineaKeyPress
    end
    object JVplazo: TJvEdit
      Left = 34
      Top = 54
      Width = 46
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
      TabOrder = 3
      OnExit = JVplazoExit
      OnKeyPress = JVplazoKeyPress
    end
    object Chcredivida: TCheckBox
      Left = 459
      Top = 56
      Width = 68
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Credivida'
      TabOrder = 6
      OnClick = ChcredividaClick
    end
  end
  object JvPanel1: TJvPanel
    Left = 0
    Top = 207
    Width = 336
    Height = 40
    TabOrder = 3
    MultiLine = False
    object Scerrar: TSpeedButton
      Left = 231
      Top = 8
      Width = 92
      Height = 25
      Caption = 'C&errar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
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
      ParentFont = False
      OnClick = ScerrarClick
    end
    object BitBtn1: TBitBtn
      Left = 16
      Top = 8
      Width = 92
      Height = 25
      Caption = '&Actualizar '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
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
    object BTcancelar: TBitBtn
      Left = 123
      Top = 8
      Width = 92
      Height = 25
      Caption = '&Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = BTcancelarClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000220B0000220B000000010000000100000031DE000031
        E7000031EF000031F700FF00FF000031FF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00040404040404
        0404040404040404000004000004040404040404040404000004040000000404
        0404040404040000040404000000000404040404040000040404040402000000
        0404040400000404040404040404000000040000000404040404040404040400
        0101010004040404040404040404040401010204040404040404040404040400
        0201020304040404040404040404030201040403030404040404040404050203
        0404040405030404040404040303050404040404040303040404040303030404
        0404040404040403040403030304040404040404040404040404030304040404
        0404040404040404040404040404040404040404040404040404}
    end
  end
  object Panel4: TPanel
    Left = 336
    Top = 207
    Width = 199
    Height = 40
    TabOrder = 4
    object BitBtn4: TBitBtn
      Left = 22
      Top = 8
      Width = 149
      Height = 25
      Caption = '&Nueva Solicitud'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn4Click
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000220B0000220B00000001000000010000EFA54A00C684
        6B00BD8C7300CE947300EFB57300FFC67300BD847B00C6947B00CE9C7B00B584
        8400B58C8400CE9C8400B5948C00C6A59400EFCE9400F7CE9400C6A59C00EFCE
        9C00F7CE9C00F7D69C00C6ADA500CEADA500F7D6A500CEB5AD00D6B5AD00C6BD
        AD00F7D6AD00F7DEAD00D6BDB500DEBDB500DEC6B500E7C6B500EFC6B500EFCE
        B500F7D6B500F7DEB500FFDEB500EFCEBD00F7DEBD00E7DEC600F7DEC600F7E7
        C600E7CECE00E7D6CE00F7E7CE00E7D6D600F7E7D600FFE7D600FFEFD600FFEF
        DE00FFEFE700FFF7E700FFF7EF00FFF7F700FFFFF700FF00FF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00373709090909
        09090909090909090937373710302926231A16110E0E0E130937373710302C28
        26221611110E0E110937373714322E2C2826221A11110E110937373714332E2C
        292823221A11110E093737371736322E2E2C2826221A11110937373718383432
        2E2C2928261A1616093737371C383534312E2C292826221A093737371C383835
        34322E2C28262323093737371D3838383532312E2C282822093737371E383838
        3835323131302719093737371F383838383834342E0D0C0A093737371F383838
        383838362A0204000137373725383838383838382B070503373737371F353434
        343434342A070B37373737371F212121211F1F211C0637373737}
    end
  end
  object DSinversion: TDataSource
    DataSet = IBinversion
    Left = 232
    Top = 24
  end
  object DSgarantia: TDataSource
    DataSet = IBgarantia
    Left = 264
    Top = 24
  end
  object DSclasificacion: TDataSource
    DataSet = IBclasificacion
    Left = 296
    Top = 24
  end
  object DSlinea: TDataSource
    DataSet = IBlinea
    Left = 328
    Top = 24
  end
  object IBinversion: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from "col$inversion"')
    Left = 232
    Top = 56
  end
  object IBgarantia: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from "col$garantia"')
    Left = 264
    Top = 56
  end
  object IBlinea: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from "col$lineas" where ESTADO <> 0')
    Left = 328
    Top = 56
  end
  object IBclasificacion: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from "col$clasificacion"')
    Left = 296
    Top = 56
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = dmGeneral.IBDatabase1
    Left = 400
    Top = 16
  end
end
