object FrmAutorizacionSolicitud: TFrmAutorizacionSolicitud
  Left = 235
  Top = 197
  Width = 565
  Height = 387
  BorderIcons = [biSystemMenu]
  Caption = 'Autorizaci'#243'n de Cambios al Sistema'
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 555
    Height = 70
    Caption = 'Informaci'#243'n del Empleado'
    TabOrder = 1
    object JvStaticText1: TJvStaticText
      Left = 3
      Top = 21
      Width = 43
      Height = 17
      TextMargins.X = 0
      TextMargins.Y = 0
      Caption = 'Agencia'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlTop
      TabOrder = 0
      WordWrap = False
    end
    object agencia: TJvStaticText
      Left = 46
      Top = 20
      Width = 95
      Height = 19
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clWhite
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlCenter
      ParentColor = False
      TabOrder = 1
      WordWrap = False
    end
    object area: TJvStaticText
      Left = 174
      Top = 19
      Width = 113
      Height = 19
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clWhite
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlCenter
      ParentColor = False
      TabOrder = 2
      WordWrap = False
    end
    object JvStaticText4: TJvStaticText
      Left = 146
      Top = 22
      Width = 26
      Height = 17
      TextMargins.X = 0
      TextMargins.Y = 0
      Caption = 'Area'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlTop
      TabOrder = 3
      WordWrap = False
    end
    object fecha: TJvStaticText
      Left = 419
      Top = 19
      Width = 129
      Height = 19
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clWhite
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlCenter
      ParentColor = False
      TabOrder = 4
      WordWrap = False
    end
    object JvStaticText7: TJvStaticText
      Left = 291
      Top = 21
      Width = 128
      Height = 17
      TextMargins.X = 0
      TextMargins.Y = 0
      Caption = 'Fecha y Hora de Registro '
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlTop
      TabOrder = 5
      WordWrap = False
    end
    object login: TJvStaticText
      Left = 46
      Top = 44
      Width = 95
      Height = 19
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clWhite
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlCenter
      ParentColor = False
      TabOrder = 6
      WordWrap = False
    end
    object JvStaticText9: TJvStaticText
      Left = 3
      Top = 45
      Width = 30
      Height = 17
      TextMargins.X = 0
      TextMargins.Y = 0
      Caption = 'Login'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlTop
      TabOrder = 7
      WordWrap = False
    end
  end
  object empleado: TJvStaticText
    Left = 195
    Top = 44
    Width = 354
    Height = 19
    TextMargins.X = 0
    TextMargins.Y = 0
    AutoSize = False
    BorderStyle = sbsSunken
    Color = clWhite
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Layout = tlCenter
    ParentColor = False
    TabOrder = 2
    WordWrap = False
  end
  object JvStaticText11: TJvStaticText
    Left = 144
    Top = 45
    Width = 51
    Height = 17
    TextMargins.X = 0
    TextMargins.Y = 0
    Caption = 'Empleado'
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    Layout = tlTop
    TabOrder = 3
    WordWrap = False
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 67
    Width = 555
    Height = 76
    Caption = 'Requerimiento'
    TabOrder = 4
    object requerimiento: TMemo
      Left = 1
      Top = 13
      Width = 548
      Height = 58
      TabStop = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 141
    Width = 555
    Height = 115
    Caption = 'Explicaci'#243'n'
    TabOrder = 5
    object explicacion: TMemo
      Left = 1
      Top = 13
      Width = 548
      Height = 97
      TabStop = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object GroupBox4: TGroupBox
    Left = 2
    Top = 252
    Width = 555
    Height = 65
    Caption = 'Observaci'#243'n Auditoria'
    TabOrder = 0
    object observacion: TMemo
      Left = 1
      Top = 13
      Width = 548
      Height = 46
      ScrollBars = ssVertical
      TabOrder = 0
      OnExit = observacionExit
    end
  end
  object Panel1: TPanel
    Left = 3
    Top = 317
    Width = 163
    Height = 35
    TabOrder = 6
    object Rautoriza: TRadioButton
      Left = 3
      Top = 6
      Width = 74
      Height = 17
      Caption = '&Autorizar'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object Rniega: TRadioButton
      Left = 83
      Top = 6
      Width = 60
      Height = 17
      Caption = '&Negar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 166
    Top = 316
    Width = 157
    Height = 36
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object BitBtn1: TBitBtn
      Left = 6
      Top = 4
      Width = 62
      Height = 25
      Hint = 'Siguiente Registro'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000E30E0000E30E0000000100000001000010630000006B
        0000086B00000073000008730000007B0000107B000000840000088400001084
        0000008C0000088C00000094000008940000009C0000089C000000A5000008A5
        000000AD000000B5000000BD000000C6000008C6000000CE000000D6000008D6
        000008630800087B0800107B080010840800008C0800088C0800009408001094
        0800009C080000A5080000AD080000B5080010BD080010C60800087B1000107B
        1000187B10001084100018841000088C1000188C1000109410001894100010D6
        100018D61000107B1800187B18001884180029841800108C1800188C1800218C
        18001094180018941800189C1800219C180010C6180018C6180018D61800187B
        210018842100189421002194210029A521001873290029AD290031DE290029E7
        290029843100298C3100398C310029D6310031D6310039AD390042A5420039DE
        420042DE42004AAD520052AD520052E752005AE75A0063AD630063E763006BEF
        63006B946B0073B56B006BDE6B0063E76B006BE76B0063EF6B007BB5730073B5
        7B007BDE7B007BB5840084BD84008CC69400A5E7A500CEEFBD00BDEFC600C6EF
        C600C6EFCE00CEEFCE00D6F7CE00D6E7D600DEE7D600D6EFD600DEEFD600CEE7
        DE00D6EFDE00DEEFDE00DEEFE700EFF7EF00F7F7F700FF00FF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00777777777777
        772F4F777777777777777777777777777712394F777777777777777777777777
        770E3D354F7777777777777777777777770E0B082D4F77777777125C55523F25
        131F0A4457294F777777225840161413100A1E073957344F7777215817151413
        120E1E07054157344F77105D17161413120C1E0707054B57414F0F5E17161413
        12201E0705034C57464F0E5817161413100C0C071B3657414F77205940161413
        240D0A073757334F7777126256523F25120C0C4357294F777777777777777777
        770E0A082D4F7777777777777777777777213B384F7777777777777777777777
        770E3B4F77777777777777777777777777444F77777777777777}
    end
    object BitBtn2: TBitBtn
      Left = 90
      Top = 4
      Width = 57
      Height = 25
      Hint = 'Anterior Registro'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BitBtn2Click
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000E30E0000E30E0000000100000001000010630000006B
        0000086B00000073000008730000007B0000107B000000840000088400001084
        0000008C0000088C00000094000008940000009C0000089C000000A5000008A5
        000000AD000000B5000000BD000000C6000008C6000000CE000000D6000008D6
        000008630800087B0800107B080010840800008C0800088C0800009408001094
        0800009C080000A5080000AD080000B5080010BD080010C60800087B1000107B
        1000187B10001084100018841000088C1000188C1000109410001894100010D6
        100018D61000107B1800187B18001884180029841800108C1800188C1800218C
        18001094180018941800189C1800219C180010C6180018C6180018D61800187B
        210018842100189421002194210029A521001873290029AD290031DE290029E7
        290029843100298C3100398C310029D6310031D6310039AD390042A5420039DE
        420042DE42004AAD520052AD520052E752005AE75A0063AD630063E763006BEF
        63006B946B0073B56B006BDE6B0063E76B006BE76B0063EF6B007BB5730073B5
        7B007BDE7B007BB5840084BD84008CC69400A5E7A500CEEFBD00BDEFC600C6EF
        C600C6EFCE00CEEFCE00D6F7CE00D6E7D600DEE7D600D6EFD600DEEFD600CEE7
        DE00D6EFDE00DEEFDE00DEEFE700EFF7EF00F7F7F700FF00FF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00777777777777
        774F2F777777777777777777777777774F39127777777777777777777777774F
        353D0E77777777777777777777774F2D080B0E777777777777777777774F2957
        440A1F13253F52555C1277774F345739071E0A10131416405822774F34574105
        071E0E121314151758214F41574B0507071E0C12131416175D104F46574C0305
        071E2012131416175E0F774F4157361B070C0C1013141617580E77774F335737
        070A0D241314164059207777774F2957430C0C12253F52566212777777774F2D
        080A0E7777777777777777777777774F383B2177777777777777777777777777
        4F3B0E77777777777777777777777777774F4477777777777777}
    end
  end
  object Panel3: TPanel
    Left = 324
    Top = 316
    Width = 233
    Height = 36
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    object BitBtn3: TBitBtn
      Left = 22
      Top = 4
      Width = 80
      Height = 25
      Caption = 'A&plicar'
      TabOrder = 0
      OnClick = BitBtn3Click
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
    object BitBtn4: TBitBtn
      Left = 124
      Top = 4
      Width = 80
      Height = 25
      Caption = '&Salir'
      TabOrder = 1
      OnClick = BitBtn4Click
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
  object IBEvents1: TIBEvents
    AutoRegister = False
    Database = dmGeneral.IBDatabase1
    Events.Strings = (
      'por_autorizar')
    Registered = False
    OnEventAlert = IBEvents1EventAlert
    Left = 416
    Top = 384
  end
  object frmTray: TJvTrayIcon
    Icon.Data = {
      0000010001001010100000000000280100001600000028000000100000002000
      00000100040000000000C0000000000000000000000000000000000000000000
      0000000080000080000000808000800000008000800080800000C0C0C0008080
      80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF002222
      22222222222222F2FF2FF2F2FF2222F2FF2FF2F2FF222222222222222222FFF2
      2FFFFFF22FFFFFF22FFFFFF22FFFFFF22FFFFFF22FFFFFF22FFFFFF22FFF2222
      2222222222222222222222222222F222222FF222222FFF2222FFFF2222FFFFF2
      2FFFFFF22FFFFFFFFFFFFFFFFFFF222222222222222222222222222222220000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    IconIndex = -1
    Hint = 'Autorizacion de Cambios al Sistema'
    Snap = True
    Visibility = [tvVisibleTaskBar, tvVisibleTaskList]
    OnDblClick = frmTrayDblClick
    OnMouseMove = frmTrayMouseMove
    OnBalloonShow = frmTrayBalloonShow
    Left = 408
    Top = 232
  end
  object MSNPopUp1: TMSNPopUp
    Text = 'text'
    URL = 'http://www.url.com/'
    IconBitmap.Data = {
      76020000424D7602000000000000760000002800000020000000200000000100
      0400000000000002000000000000000000001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00222222222222
      2222222222222222222222222222222222222222222222222222222222222222
      2222222222222222222222222222222222222222222222222222FFFFFF222FFF
      FFFFFFFFFFF222FFFFFFFFFFFF222FFFFFFFFFFFFFF222FFFFFFFFFFFF222FFF
      FFFFFFFFFFF222FFFFFFFFFFFF222FFFFFFFFFFFFFF222FFFFFFFFFFFF222FFF
      FFFFFFFFFFF222FFFFFFFFFFFF222FFFFFFFFFFFFFF222FFFFFFFFFFFF222FFF
      FFFFFFFFFFF222FFFFFFFFFFFF222FFFFFFFFFFFFFF222FFFFFFFFFFFF222FFF
      FFFFFFFFFFF222FFFFFFFFFFFF222FFFFFFFFFFFFFF222FFFFFFFFFFFF222FFF
      FFFFFFFFFFF222FFFFFF222222222222222FF222222222222222222222222222
      222FF222222222222222F2222222222222FFFF2222222222222FF22222222222
      22FFFF2222222222222FFF22222222222FFFFFF22222222222FFFF2222222222
      2FFFFFF22222222222FFFFF222222222FFFFFFFF222222222FFFFFF222222222
      FFFFFFFF222222222FFFFFFF2222222FFFFFFFFFF2222222FFFFFFFF2222222F
      FFFFFFFFF2222222FFFFFFFF2222222FFFFFFFFFF2222222FFFFFFFFF22222FF
      FFFFFFFFFF22222FFFFFFFFFF22222FFFFFFFFFFFF22222FFFFFFFFFFF222FFF
      FFFFFFFFFFF222FFFFFFFFFFFF222FFFFFFFFFFFFFF222FFFFFFFFFFFFF2FFFF
      FFFFFFFFFFFF2FFFFFFFFFFFFFF2FFFFFFFFFFFFFFFF2FFFFFFF}
    IconLeft = 8
    IconTop = 8
    Width = 148
    Height = 121
    GradientColor1 = clLime
    GradientColor2 = clWhite
    ScrollSpeed = 8
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    HoverFont.Charset = DEFAULT_CHARSET
    HoverFont.Color = clBlue
    HoverFont.Height = -12
    HoverFont.Name = 'Arial'
    HoverFont.Style = [fsUnderline]
    Title = 'title'
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    Options = [msnCascadePopups, msnAllowScroll]
    TextCursor = crDefault
    PopupMarge = 2
    PopupStartX = 16
    PopupStartY = 2
    DefaultMonitor = dmDesktop
    Left = 408
    Top = 392
  end
  object IBBuscar: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "gen$agencia".DESCRIPCION_AGENCIA,'
      '  "per$solicitud".CONSECUTIVO,'
      '  "per$solicitud".ID_AGENCIA,'
      '  "per$solicitud".AREA,'
      '  "per$solicitud".FECHAR,'
      '  "per$solicitud".HORAR,'
      '  "per$solicitud".REQUERIMIENTO,'
      '  "per$solicitud".EXPLICACION,'
      '  "gen$empleado".ID_EMPLEADO,'
      
        '  "gen$empleado".NOMBRE || '#39' '#39' || "gen$empleado".SEGUNDO_APELLID' +
        'O || '#39' '#39' || "gen$empleado".PRIMER_APELLIDO AS NOMBRE'
      'FROM'
      ' "gen$agencia"'
      
        ' INNER JOIN "per$solicitud" ON ("gen$agencia".ID_AGENCIA="per$so' +
        'licitud".ID_AGENCIA)'
      
        ' INNER JOIN "gen$empleado" ON ("gen$empleado".ID_EMPLEADO="per$s' +
        'olicitud".ID_EMPLEADO)'
      'WHERE'
      '  ("per$solicitud".VISADO = 0)')
    Left = 448
    Top = 272
  end
  object IBTBuscar: TIBTransaction
    DefaultDatabase = dmGeneral.IBDatabase1
    Left = 408
    Top = 368
  end
  object NLetra1: TNLetra
    Numero = 0
    Letras = 'Cero'
    Left = 416
    Top = 384
  end
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 232
    Top = 56
  end
end
