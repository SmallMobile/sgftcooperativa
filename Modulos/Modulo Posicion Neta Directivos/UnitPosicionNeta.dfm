object frmPosicionNeta: TfrmPosicionNeta
  Left = 192
  Top = 144
  Width = 510
  Height = 322
  Caption = 'Posici'#243'n Neta'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 6
    Width = 116
    Height = 13
    Caption = 'Archivo de Captaciones:'
  end
  object Label2: TLabel
    Left = 6
    Top = 32
    Width = 121
    Height = 13
    Caption = 'Archivo de Colocaciones:'
  end
  object Label3: TLabel
    Left = 6
    Top = 58
    Width = 93
    Height = 13
    Caption = 'Archivo de Aportes:'
  end
  object Label4: TLabel
    Left = 6
    Top = 84
    Width = 117
    Height = 13
    Caption = 'Archivo de Documentos:'
  end
  object EdCaptacion: TJvFilenameEdit
    Left = 137
    Top = 2
    Width = 257
    Height = 21
    DefaultExt = '*.txt'
    Filter = 'Archivos de Texto Separado por Tabulaciones (*.txt)|*.txt'
    DialogOptions = [ofReadOnly, ofHideReadOnly]
    DialogTitle = 'Buscar Archivo'
    ButtonFlat = False
    Color = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 1
    ParentFont = False
    TabOrder = 0
  end
  object EdColocacion: TJvFilenameEdit
    Left = 137
    Top = 28
    Width = 257
    Height = 21
    DefaultExt = '*.txt'
    Filter = 'Archivos de Texto Separado por Tabulaciones (*.txt)|*.txt'
    DialogOptions = [ofReadOnly, ofHideReadOnly]
    DialogTitle = 'Buscar Archivo'
    ButtonFlat = False
    Color = clTeal
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 1
    ParentFont = False
    TabOrder = 1
  end
  object EdAportes: TJvFilenameEdit
    Left = 137
    Top = 54
    Width = 257
    Height = 21
    DefaultExt = '*.txt'
    Filter = 'Archivos de Texto Separado por Tabulaciones (*.txt)|*.txt'
    DialogOptions = [ofReadOnly, ofHideReadOnly]
    DialogTitle = 'Buscar Archivo'
    ButtonFlat = False
    Color = clPurple
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 1
    ParentFont = False
    TabOrder = 2
  end
  object CmdProcesar: TBitBtn
    Left = 400
    Top = 4
    Width = 97
    Height = 25
    Caption = '&Iniciar Proceso'
    TabOrder = 3
    OnClick = CmdProcesarClick
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      08000000000000010000D30E0000D30E000000010000000100004A7BB500296B
      C600527BC600186BD600528CD6003194D600397BE7005284E700107BEF00317B
      EF001084EF0029ADEF0039ADEF0010B5EF0008BDEF000073F7001873F7002973
      F7000884F7000894F70018A5F70000CEF70018DEF70063DEF700FF00FF000073
      FF00007BFF000084FF00008CFF000094FF00009CFF0000A5FF0010A5FF0039A5
      FF0052A5FF005AA5FF0000ADFF0029ADFF0031ADFF0000B5FF006BB5FF0084B5
      FF0000BDFF0008BDFF0010BDFF0000C6FF0008C6FF006BC6FF0000CEFF0018CE
      FF0000D6FF0008D6FF0010D6FF0021D6FF0031D6FF0000DEFF0018DEFF0029DE
      FF0042DEFF0000E7FF0010E7FF0018E7FF0039E7FF0000EFFF0018EFFF0039EF
      FF004AEFFF0000F7FF0008F7FF0029F7FF0031F7FF0042F7FF004AF7FF005AF7
      FF0000FFFF0008FFFF0018FFFF0021FFFF0031FFFF0039FFFF00FFFFFF00FFFF
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
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00181818181818
      1818181818181818181818181802181818181818181818181818181818090201
      18181818181818181818181818061A0F02181818181818181818181818181E1C
      1C0218181818181818181818181818271C1D0202181818181818181818181818
      272E1E1E02181818181818181818181818272B241E0218181818181818180202
      022D4B462C240202181818181818252D3F43434A42311F02181818181818212D
      3F433F374A4A412E021818181818182E3E42474C4A4A4B4D0218181818181818
      1836444A43322702181818181818181818181836433F241F0218181818181818
      1818181818363A34230218181818181818181818181818362202}
  end
  object CmdReporte: TBitBtn
    Left = 400
    Top = 32
    Width = 97
    Height = 25
    Caption = 'Reporte'
    TabOrder = 4
    OnClick = CmdReporteClick
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      08000000000000010000220B0000220B00000001000000010000181818002118
      21001821210031313100393939004242420052525200636363006B6B6B007373
      7300848484008C8C8C00948C8C00949494009C949400F7AD94009C9C9C00CE9C
      9C00F7AD9C00FFAD9C00FFB59C009C9CA500A5A5A500ADA5A500C6A5A500A5AD
      A500FFBDA500A5D6A500ADADAD00B5ADAD00FFC6AD00B5B5B500FFC6B500BDBD
      BD00C6BDBD00BDC6BD00E7C6BD00EFCEBD00FFCEBD00BDBDC600C6C6C600CEC6
      C600E7CEC600CECECE00D6CECE00DED6CE00FFDECE00D6D6D600FFE7D600D6DE
      DE00DEDEDE00EFE7DE00E7E7E700EFE7E700FFE7E700EFEFEF00F7EFEF00F7EF
      F700F7F7F700FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003B3B3B3B3B3B
      103B3B3B0A0A0B3B3B3B3B3B3B3B10102C0D04060E282F0A3B3B3B3B10103A3C
      2F1005010103070A0B3B0C10373C3528100B0D0A07040201093B10343421161D
      22160D0C0D0E0B080A3B0D1C161C282F373732281C100C0D0B3B0C1C282B2832
      2B19212B2F2F281F0D3B3B102B2B32281F1B231817161F22163B3B3B10211C1C
      343837332F2B1F0D3B3B3B3B3B102F2B10212F2F2F281C3B3B3B3B3B3B3B362E
      24242A2D2B0D3B3B3B3B3B3B3B3B112E261E1A133B3B3B3B3B3B3B3B3B3B112E
      261E1A0F3B3B3B3B3B3B3B3B3B3B112E261E1A123B3B3B3B3B3B3B3B3B11302E
      261E1A123B3B3B3B3B3B3B3B3B1111111112123B3B3B3B3B3B3B}
  end
  object CmdCerrar: TBitBtn
    Left = 400
    Top = 60
    Width = 97
    Height = 25
    Caption = '&Cerrar'
    TabOrder = 5
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
  object GroupBox1: TGroupBox
    Left = 4
    Top = 105
    Width = 489
    Height = 87
    Caption = 'Cargando Archivos a Procesar'
    TabOrder = 6
    object BarCaptacion: TJvProgressBar
      Left = 4
      Top = 14
      Width = 477
      Height = 17
      Min = 0
      Max = 100
      TabOrder = 0
      BarColor = clBlue
    end
    object BarColocacion: TJvProgressBar
      Left = 4
      Top = 34
      Width = 477
      Height = 17
      Min = 0
      Max = 100
      TabOrder = 1
      BarColor = clTeal
    end
    object BarAportes: TJvProgressBar
      Left = 4
      Top = 54
      Width = 477
      Height = 17
      Min = 0
      Max = 100
      TabOrder = 2
      BarColor = clPurple
    end
  end
  object GroupBox2: TGroupBox
    Left = 6
    Top = 194
    Width = 487
    Height = 43
    Caption = 'Procesar Informaci'#243'n'
    Color = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 7
    object Bar: TJvSpecialProgress
      Left = 6
      Top = 12
      Width = 475
      Height = 27
      Caption = 'Bar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      GradientBlocks = True
      ParentFont = False
      Solid = True
      Step = 1
      TextOption = toPercent
    end
  end
  object EdDocumentos: TJvFilenameEdit
    Left = 137
    Top = 80
    Width = 257
    Height = 21
    DefaultExt = '*.txt'
    Filter = 'Archivos de Texto Separado por Tabulaciones (*.txt)|*.txt'
    DialogOptions = [ofReadOnly, ofHideReadOnly]
    DialogTitle = 'Buscar Archivo'
    ButtonFlat = False
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    NumGlyphs = 1
    ParentFont = False
    TabOrder = 8
  end
  object GroupBox3: TGroupBox
    Left = 7
    Top = 238
    Width = 487
    Height = 43
    Caption = 'Calculando Posici'#243'n'
    Color = clAqua
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 9
    object Bar1: TJvSpecialProgress
      Left = 6
      Top = 12
      Width = 475
      Height = 27
      Caption = 'Bar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      GradientBlocks = True
      ParentFont = False
      Solid = True
      Step = 1
      TextOption = toPercent
    end
  end
  object CDSCaptacion: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TIPO_IDE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMERO_IDE'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'SALDO'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 366
    Top = 112
    Data = {
      780000009619E0BD010000001800000003000000000003000000780008544950
      4F5F49444501004900000001000557494454480200020001000A4E554D45524F
      5F4944450100490000000100055749445448020002000F000553414C444F0800
      04000000010007535542545950450200490006004D6F6E6579000000}
    object CDSCaptacionTIPO_IDE: TStringField
      FieldName = 'TIPO_IDE'
      Size = 1
    end
    object CDSCaptacionNUMERO_IDE: TStringField
      FieldName = 'NUMERO_IDE'
      Size = 15
    end
    object CDSCaptacionSALDO: TCurrencyField
      FieldName = 'SALDO'
    end
  end
  object CDSColocacion: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TIPO_IDE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMERO_IDE'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'SALDO_CAPITAL'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 394
    Top = 112
    Data = {
      800000009619E0BD010000001800000003000000000003000000800008544950
      4F5F49444501004900000001000557494454480200020001000A4E554D45524F
      5F4944450100490000000100055749445448020002000F000D53414C444F5F43
      41504954414C080004000000010007535542545950450200490006004D6F6E65
      79000000}
    object CDSColocacionTIPO_IDE: TStringField
      FieldName = 'TIPO_IDE'
      Size = 1
    end
    object CDSColocacionNUMERO_IDE: TStringField
      FieldName = 'NUMERO_IDE'
      Size = 15
    end
    object CDSColocacionSALDO_CAPITAL: TCurrencyField
      FieldName = 'SALDO_CAPITAL'
    end
  end
  object CDSAportes: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TIPO_IDE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMERO_IDE'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'SALDO_APO'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 414
    Top = 112
    Data = {
      7C0000009619E0BD0100000018000000030000000000030000007C0008544950
      4F5F49444501004900000001000557494454480200020001000A4E554D45524F
      5F4944450100490000000100055749445448020002000F000953414C444F5F41
      504F080004000000010007535542545950450200490006004D6F6E6579000000}
    object CDSAportesTIPO_IDE: TStringField
      FieldName = 'TIPO_IDE'
      Size = 1
    end
    object CDSAportesNUMERO_IDE: TStringField
      FieldName = 'NUMERO_IDE'
      Size = 15
    end
    object CDSAportesSALDO_APO: TCurrencyField
      FieldName = 'SALDO_APO'
    end
  end
  object CDSDocumentos: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TIPO_IDE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'NUMERO_IDE'
        DataType = ftString
        Size = 15
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 382
    Top = 140
    Data = {
      560000009619E0BD010000001800000002000000000003000000560008544950
      4F5F49444501004900000001000557494454480200020001000A4E554D45524F
      5F4944450100490000000100055749445448020002000F000000}
    object CDSDocumentosTIPO_IDE: TStringField
      FieldName = 'TIPO_IDE'
      Size = 1
    end
    object CDSDocumentosNUMERO_IDE: TStringField
      FieldName = 'NUMERO_IDE'
      Size = 15
    end
  end
  object CDSPosicion: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'NUMERO_IDE'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'CAPTACION'
        DataType = ftCurrency
      end
      item
        Name = 'COLOCACION'
        DataType = ftCurrency
      end
      item
        Name = 'APORTES'
        DataType = ftCurrency
      end
      item
        Name = 'POSICION'
        DataType = ftCurrency
      end
      item
        Name = 'PRIMER_APELLIDO'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'SEGUNDO_APELLIDO'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'NOMBRE'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 410
    Top = 140
    Data = {
      330100009619E0BD01000000180000000800000000000300000033010A4E554D
      45524F5F4944450100490000000100055749445448020002000F000943415054
      4143494F4E080004000000010007535542545950450200490006004D6F6E6579
      000A434F4C4F434143494F4E0800040000000100075355425459504502004900
      06004D6F6E6579000741504F5254455308000400000001000753554254595045
      0200490006004D6F6E65790008504F534943494F4E0800040000000100075355
      42545950450200490006004D6F6E6579000F5052494D45525F4150454C4C4944
      4F0100490000000100055749445448020002001E0010534547554E444F5F4150
      454C4C49444F0100490000000100055749445448020002001E00064E4F4D4252
      4501004900000001000557494454480200020032000000}
    object CDSPosicionNUMERO_IDE: TStringField
      FieldName = 'NUMERO_IDE'
      Size = 15
    end
    object CDSPosicionCAPTACION: TCurrencyField
      FieldName = 'CAPTACION'
    end
    object CDSPosicionCOLOCACION: TCurrencyField
      FieldName = 'COLOCACION'
    end
    object CDSPosicionAPORTES: TCurrencyField
      FieldName = 'APORTES'
    end
    object CDSPosicionPOSICION: TCurrencyField
      FieldName = 'POSICION'
    end
    object CDSPosicionPRIMER_APELLIDO: TStringField
      FieldName = 'PRIMER_APELLIDO'
      Size = 30
    end
    object CDSPosicionSEGUNDO_APELLIDO: TStringField
      FieldName = 'SEGUNDO_APELLIDO'
      Size = 30
    end
    object CDSPosicionNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 50
    end
  end
  object Reporte: TprTxReport
    Values = <>
    Variables = <>
    Left = 422
    Top = 166
    SystemInfo = (
      'OS: WIN32_NT 5.1.2600 Service Pack 2'
      ''
      'PageSize: 4096'
      'ActiveProcessorMask: $1000'
      'NumberOfProcessors: 2'
      'ProcessorType: 586'
      ''
      'Compiler version: Delphi6'
      'PReport version: 1.9.4')
    object prTxPage1: TprTxPage
      PageType = tptPage
      LineNum = 60
      ColNum = 132
      object prTxHPageHeaderBand1: TprTxHPageHeaderBand
        Height = 2
        UseVerticalBands = False
        PrintOnFirstPage = False
        object prTxMemoObj1: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'POSICION NETA DIRECTIVOS')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 26
          dRec.Top = 0
          dRec.Right = 50
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHDetailBand1: TprTxHDetailBand
        Height = 1
        UseVerticalBands = False
        DataSetName = 'CDSPosicion'
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        Bands = (
          'prTxHDetailHeaderBand1')
        object prTxMemoObj7: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDSPosicion.NUMERO_IDE]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 0
          dRec.Top = 0
          dRec.Right = 15
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,0.00>CDSPosicion.POSICION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 20
          dRec.Top = 0
          dRec.Right = 32
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,0.00>CDSPosicion.COLOCACION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 52
          dRec.Top = 0
          dRec.Right = 70
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj9: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,0.00>CDSPosicion.CAPTACION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 33
          dRec.Top = 0
          dRec.Right = 51
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj11: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,0.00>CDSPosicion.APORTES]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 71
          dRec.Top = 0
          dRec.Right = 89
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj13: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[CDSPosicion.PRIMER_APELLIDO] [CDSPosicion.SEGUNDO_APELLIDO] [CD' +
                  'SPosicion.NOMBRE]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 90
          dRec.Top = 0
          dRec.Right = 132
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHDetailHeaderBand1: TprTxHDetailHeaderBand
        Height = 2
        UseVerticalBands = False
        DetailBand = Reporte.prTxHDetailBand1
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        ReprintOnEachPage = True
        LinkToDetail = True
        object prTxMemoObj2: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'DOCUMENTO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 0
          dRec.Top = 0
          dRec.Right = 15
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj3: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'POSICION')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 20
          dRec.Top = 0
          dRec.Right = 32
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj4: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CAPTACIONES')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 33
          dRec.Top = 0
          dRec.Right = 51
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj5: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'COLOCACIONES')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 52
          dRec.Top = 0
          dRec.Right = 70
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj6: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'APORTES')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 71
          dRec.Top = 0
          dRec.Right = 89
          dRec.Bottom = 1
          Visible = False
        end
        object prTxHLineObj1: TprTxHLineObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
            end>
          dRec.Left = 0
          dRec.Top = 1
          dRec.Right = 89
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj12: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'ASOCIADO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 90
          dRec.Top = 0
          dRec.Right = 132
          dRec.Bottom = 1
          Visible = False
        end
      end
    end
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = Transaction
    Left = 464
    Top = 96
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = '192.168.200.141:/var/db/fbird/database.fdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'sql_role_name=CONTABILIDAD_A'
      'lc_ctype=ISO8859_1')
    LoginPrompt = False
    DefaultTransaction = Transaction
    Left = 412
    Top = 96
  end
  object Transaction: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 440
    Top = 96
  end
end
