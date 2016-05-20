object FrmConsulta: TFrmConsulta
  Left = 224
  Top = 136
  Width = 528
  Height = 355
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta de Estado de los Asociados'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grupo: TGroupBox
    Left = 0
    Top = 0
    Width = 520
    Height = 89
    Caption = 'Tipo de Busqueda'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 3
      Top = 14
      Width = 414
      Height = 69
      ActivePage = TabSheet2
      Style = tsFlatButtons
      TabIndex = 1
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = '&Captacion'
        object Label1: TLabel
          Left = 2
          Top = 11
          Width = 26
          Height = 13
          Caption = 'Tipo'
        end
        object Label2: TLabel
          Left = 249
          Top = 12
          Width = 44
          Height = 13
          Caption = 'Numero'
        end
        object DBcaptacion: TDBLookupComboBox
          Left = 32
          Top = 9
          Width = 209
          Height = 21
          KeyField = 'ID_TIPO_CAPTACION'
          ListField = 'DESCRIPCION'
          ListSource = DScaptacion
          TabOrder = 0
          OnExit = DBcaptacionExit
        end
        object cuenta: TJvEdit
          Left = 301
          Top = 9
          Width = 100
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
          TabOrder = 1
        end
      end
      object TabSheet2: TTabSheet
        Caption = '&Documento'
        ImageIndex = 1
        object T: TLabel
          Left = 2
          Top = 11
          Width = 26
          Height = 13
          Caption = 'Tipo'
        end
        object Label3: TLabel
          Left = 249
          Top = 11
          Width = 44
          Height = 13
          Caption = 'Numero'
        end
        object DBtipo: TDBLookupComboBox
          Left = 32
          Top = 9
          Width = 209
          Height = 21
          KeyField = 'ID_IDENTIFICACION'
          ListField = 'DESCRIPCION_IDENTIFICACION'
          ListSource = DSdocumento
          TabOrder = 0
          OnExit = DBtipoExit
        end
        object documento: TJvEdit
          Left = 301
          Top = 9
          Width = 100
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
          TabOrder = 1
        end
      end
    end
    object BitBtn1: TBitBtn
      Left = 423
      Top = 50
      Width = 87
      Height = 21
      Caption = '&Busqueda'
      TabOrder = 1
      OnClick = BitBtn1Click
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000320B0000320B000000010000000100005A6B7300AD7B
        73004A637B00EFBD8400B58C8C00A5948C00C6948C00B59C8C00BD9C8C00F7BD
        8C00BD949400C6949400CE949400C69C9400CEAD9400F7CE9400C6A59C00CEA5
        9C00D6A59C00C6AD9C00CEAD9C00D6AD9C00F7CE9C00F7D69C004A7BA500CEAD
        A500D6B5A500DEBDA500F7D6A500DEBDAD00DEC6AD00E7C6AD00FFDEAD00FFE7
        AD00CEB5B500F7DEB500F7E7B500FFE7B500FFEFB500D6BDBD00DED6BD00E7DE
        BD00FFE7BD006B9CC600EFDEC600FFEFC600FFF7C600F7E7CE00FFF7CE00F7EF
        D600F7F7D600FFF7D600FFFFD6002184DE00F7F7DE00FFFFDE001884E700188C
        E700FFFFE700188CEF00218CEF00B5D6EF00F7F7EF00FFF7EF00FFFFEF00FFFF
        F700FF00FF004AB5FF0052B5FF0052BDFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0042020A424242
        424242424242424242422B39180B42424242424242424242424243443C180B42
        4242424242424242424242444438180B42424242424242424242424244433918
        0A424242424242424242424242444335004201101A114242424242424242453D
        05072F343434291942424242424242221A2D34343437403E0442424242424206
        231C303437404146284242424242421B210F30373A414140310D42424242421F
        20032434373A3A37321342424242421D25030F2D37373737311042424242420D
        2D2D1C162430333429424242424242421E463F0F0316252E0842424242424242
        4227312D21252314424242424242424242420E141B1B42424242}
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 93
    Width = 364
    Height = 156
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object JvLabel1: TJvLabel
      Left = 6
      Top = 1
      Width = 100
      Height = 13
      Caption = 'Datos Personales'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object Label4: TLabel
      Left = 8
      Top = 29
      Width = 50
      Height = 13
      Caption = 'Titulares'
    end
    object TEnombre: TJvStaticText
      Left = 79
      Top = 3
      Width = 278
      Height = 18
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clBtnHighlight
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlCenter
      ParentColor = False
      TabOrder = 0
      Visible = False
      WordWrap = False
    end
    object JvStaticText1: TJvStaticText
      Left = 8
      Top = 61
      Width = 68
      Height = 17
      TextMargins.X = 0
      TextMargins.Y = 0
      Caption = 'Documento'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlTop
      TabOrder = 1
      WordWrap = False
    end
    object TEdocumento: TJvStaticText
      Left = 79
      Top = 59
      Width = 113
      Height = 18
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clBtnHighlight
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
    object JvStaticText2: TJvStaticText
      Left = 196
      Top = 61
      Width = 44
      Height = 17
      TextMargins.X = 0
      TextMargins.Y = 0
      Caption = 'Cuenta'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlTop
      TabOrder = 3
      WordWrap = False
    end
    object TEsexo: TJvStaticText
      Left = 240
      Top = 59
      Width = 116
      Height = 18
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clBtnHighlight
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
    object JvStaticText4: TJvStaticText
      Left = 8
      Top = 92
      Width = 58
      Height = 17
      TextMargins.X = 0
      TextMargins.Y = 0
      Caption = 'Direccion'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlTop
      TabOrder = 5
      WordWrap = False
    end
    object TEdireccion: TJvStaticText
      Left = 79
      Top = 90
      Width = 278
      Height = 18
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clBtnHighlight
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
    object JvStaticText6: TJvStaticText
      Left = 8
      Top = 123
      Width = 54
      Height = 17
      TextMargins.X = 0
      TextMargins.Y = 0
      Caption = 'Telefono'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlTop
      TabOrder = 7
      WordWrap = False
    end
    object TEtelefono: TJvStaticText
      Left = 79
      Top = 121
      Width = 113
      Height = 18
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clBtnHighlight
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlCenter
      ParentColor = False
      TabOrder = 8
      WordWrap = False
    end
    object JvStaticText8: TJvStaticText
      Left = 197
      Top = 123
      Width = 43
      Height = 17
      TextMargins.X = 0
      TextMargins.Y = 0
      Caption = 'Ciudad'
      Color = clBtnFace
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlTop
      ParentColor = False
      TabOrder = 9
      WordWrap = False
    end
    object TECiudad: TJvStaticText
      Left = 240
      Top = 121
      Width = 116
      Height = 18
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clBtnHighlight
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlCenter
      ParentColor = False
      TabOrder = 10
      WordWrap = False
    end
    object Ctitular: TComboBox
      Left = 78
      Top = 28
      Width = 280
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 11
    end
    object CBcuenta: TComboBox
      Left = 240
      Top = 57
      Width = 117
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 12
    end
  end
  object JvPanel1: TJvPanel
    Left = 366
    Top = 93
    Width = 153
    Height = 156
    Caption = 'JvPanel1'
    Enabled = False
    TabOrder = 2
    MultiLine = False
    object ImgFotoC: TImage
      Left = 4
      Top = 4
      Width = 135
      Height = 135
      Hint = 'Fotografia del Asociado'
      ParentShowHint = False
      ShowHint = True
      Stretch = True
    end
  end
  object Panel2: TPanel
    Left = 366
    Top = 251
    Width = 153
    Height = 70
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object BTconsulta: TBitBtn
      Left = 11
      Top = 7
      Width = 128
      Height = 25
      Caption = '&Otra'
      TabOrder = 0
      OnClick = BTconsultaClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
        0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
        00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
        00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
        F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
        F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
        FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
        0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
        00337777FFFF77FF7733EEEE0000000003337777777777777333}
      NumGlyphs = 2
    end
    object BitBtn4: TBitBtn
      Left = 11
      Top = 40
      Width = 128
      Height = 25
      Caption = '&Cerrar'
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
  object Panel3: TPanel
    Left = 0
    Top = 249
    Width = 364
    Height = 72
    Hint = 'Si la Casilla Aparece Activada es Porque se Encuenta al Dia'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    object JvLabel2: TJvLabel
      Left = 6
      Top = 1
      Width = 153
      Height = 13
      Caption = 'Resutados de la Busqueda'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object CHaportes: TCheckBox
      Left = 3
      Top = 22
      Width = 105
      Height = 20
      Alignment = taLeftJustify
      BiDiMode = bdLeftToRight
      Caption = 'Aportes al Dia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      State = cbGrayed
      TabOrder = 0
    end
    object CHahorros: TJvCheckBox
      Left = 32
      Top = 50
      Width = 121
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Ahorros al Dia'
      State = cbGrayed
      TabOrder = 1
      AutoSize = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object CHfianzas: TJvCheckBox
      Left = 205
      Top = 51
      Width = 121
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Fianzas al Dia'
      State = cbGrayed
      TabOrder = 2
      AutoSize = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object CHcreditos: TJvCheckBox
      Left = 126
      Top = 23
      Width = 105
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Creditos al Dia'
      State = cbGrayed
      TabOrder = 3
      AutoSize = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object CHjuvenil: TJvCheckBox
      Left = 157
      Top = 93
      Width = 121
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Ahorro Juvenil'
      TabOrder = 4
      AutoSize = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object CHcapacitacion: TJvCheckBox
      Left = 246
      Top = 22
      Width = 105
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Capacitacion'
      State = cbGrayed
      TabOrder = 5
      AutoSize = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
  end
  object DSdocumento: TDataSource
    DataSet = IBdocumento
    Left = 488
  end
  object DScaptacion: TDataSource
    DataSet = IBcaptacion
    Left = 488
  end
  object IBcaptacion: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTranregistro
    SQL.Strings = (
      'select * from "cap$tipocaptacion"')
    Left = 456
  end
  object IBdocumento: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTranregistro
    SQL.Strings = (
      'select * from "gen$tiposidentificacion"')
    Left = 424
  end
  object IBTranregistro: TIBTransaction
    DefaultDatabase = frmdata.IBDatabase2
    Left = 384
    Top = 8
  end
  object IBasociado: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTranregistro
    SQL.Strings = (
      'SELECT '
      '  "gen$persona".ID_IDENTIFICACION,'
      '  "gen$persona".ID_PERSONA,'
      '  "gen$persona".LUGAR_EXPEDICION,'
      '  "gen$persona".FECHA_EXPEDICION,'
      '  "gen$persona".NOMBRE,'
      '  "gen$persona".PRIMER_APELLIDO,'
      '  "gen$persona".SEGUNDO_APELLIDO,'
      '  "gen$persona".ID_TIPO_PERSONA,'
      '  "gen$persona".SEXO,'
      '  "gen$persona".FECHA_NACIMIENTO,'
      '  "gen$persona".LUGAR_NACIMIENTO,'
      '  "gen$persona".PROVINCIA_NACIMIENTO,'
      '  "gen$persona".DEPTO_NACIMIENTO,'
      '  "gen$persona".PAIS_NACIMIENTO,'
      '  "gen$persona".ID_TIPO_ESTADO_CIVIL,'
      '  "gen$persona".ID_CONYUGE,'
      '  "gen$persona".ID_IDENTIFICACION_CONYUGE,'
      '  "gen$persona".NOMBRE_CONYUGE,'
      '  "gen$persona".PRIMER_APELLIDO_CONYUGE,'
      '  "gen$persona".SEGUNDO_APELLIDO_CONYUGE,'
      '  "gen$persona".ID_APODERADO,'
      '  "gen$persona".ID_IDENTIFICACION_APODERADO,'
      '  "gen$persona".NOMBRE_APODERADO,'
      '  "gen$persona".PRIMER_APELLIDO_APODERADO,'
      '  "gen$persona".SEGUNDO_APELLIDO_APODERADO,'
      '  "gen$persona".PROFESION,'
      '  "gen$persona".ID_ESTADO,'
      '  "gen$persona".ID_TIPO_RELACION,'
      '  "gen$persona".ID_CIIU,'
      '  "gen$persona".EMPRESA_LABORA,'
      '  "gen$persona".FECHA_INGRESO_EMPRESA,'
      '  "gen$persona".CARGO_ACTUAL,'
      '  "gen$persona".DECLARACION,'
      '  "gen$persona".INGRESOS_A_PRINCIPAL,'
      '  "gen$persona".INGRESOS_OTROS,'
      '  "gen$persona".INGRESOS_CONYUGE,'
      '  "gen$persona".INGRESOS_CONYUGE_OTROS,'
      '  "gen$persona".DESC_INGR_OTROS,'
      '  "gen$persona".EGRESOS_ALQUILER,'
      '  "gen$persona".EGRESOS_SERVICIOS,'
      '  "gen$persona".EGRESOS_TRANSPORTE,'
      '  "gen$persona".EGRESOS_ALIMENTACION,'
      '  "gen$persona".EGRESOS_DEUDAS,'
      '  "gen$persona".EGRESOS_OTROS,'
      '  "gen$persona".DESC_EGRE_OTROS,'
      '  "gen$persona".EGRESOS_CONYUGE,'
      '  "gen$persona".OTROS_EGRESOS_CONYUGE,'
      '  "gen$persona".TOTAL_ACTIVOS,'
      '  "gen$persona".TOTAL_PASIVOS,'
      '  "gen$persona".EDUCACION,'
      '  "gen$persona".RETEFUENTE,'
      '  "gen$persona".ACTA,'
      '  "gen$persona".FECHA_REGISTRO,'
      '  "gen$persona".FOTO,'
      '  "gen$persona".FIRMA,'
      '  "gen$persona".ESCRITURA_CONSTITUCION,'
      '  "gen$persona".DURACION_SOCIEDAD,'
      '  "gen$persona".CAPITAL_SOCIAL,'
      '  "gen$persona".MATRICULA_MERCANTIL,'
      '  "gen$persona".FOTO_HUELLA,'
      '  "gen$persona".DATOS_HUELLA'
      'FROM'
      '  "gen$persona"'
      'WHERE'
      '  ("gen$persona".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND '
      '  ("gen$persona".ID_PERSONA = :ID_PERSONA)'
      '')
    Left = 168
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_IDENTIFICACION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_PERSONA'
        ParamType = ptUnknown
      end>
  end
  object DSAsociado: TDataSource
    DataSet = IBasociado
    Left = 240
    Top = 8
  end
  object IBSQL1: TIBSQL
    Database = frmdata.IBDatabase2
    Transaction = IBTranregistro
    Left = 280
    Top = 8
  end
  object IBQPersona: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTranregistro
    Left = 202
    Top = 8
  end
  object IBSQL2: TIBSQL
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    Left = 328
    Top = 8
  end
  object Procedimiento: TIBStoredProc
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    StoredProcName = 'SALDO_ACTUAL'
    Left = 32
    Top = 80
    ParamData = <
      item
        DataType = ftBCD
        Name = 'SALDO_ACTUAL'
        ParamType = ptOutput
      end
      item
        DataType = ftSmallint
        Name = 'AG'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'TP'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CTA'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'DGT'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ANO'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'FECHA1'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'FECHA2'
        ParamType = ptInput
      end>
  end
  object IBSQL3: TIBSQL
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    Left = 224
    Top = 72
  end
end
