object existencia: Texistencia
  Left = 210
  Top = 143
  Width = 558
  Height = 375
  BorderIcons = [biSystemMenu]
  Caption = 'Existencia de Articulos'
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
  object Label1: TLabel
    Left = 154
    Top = 8
    Width = 220
    Height = 24
    Caption = 'Existencia  de Articulos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 5
    Top = 76
    Width = 541
    Height = 225
    Hint = 'Para ver el Detalle Haga click sobre el Codigo del Articulo'
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'cod_articulo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nombre'
        Width = 260
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cod_clasificacion'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'existencia'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'precio_unitario'
        Width = 111
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cod_barras'
        Visible = False
      end>
  end
  object BitBtn1: TBitBtn
    Left = 64
    Top = 312
    Width = 150
    Height = 25
    Caption = 'Todos Los Articulos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn1Click
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
  object BitBtn2: TBitBtn
    Left = 304
    Top = 312
    Width = 150
    Height = 25
    Caption = 'Cerrar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn2Click
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
    Left = 8
    Top = 34
    Width = 537
    Height = 39
    TabOrder = 3
    object a: TButton
      Left = 6
      Top = 13
      Width = 20
      Height = 20
      Caption = '&A'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = aClick
    end
    object b: TButton
      Left = 25
      Top = 13
      Width = 20
      Height = 20
      Caption = '&B'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = bClick
    end
    object c: TButton
      Left = 45
      Top = 13
      Width = 20
      Height = 20
      Caption = '&C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = cClick
    end
    object d: TButton
      Left = 66
      Top = 13
      Width = 20
      Height = 20
      Caption = '&D'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnClick = dClick
    end
    object e: TButton
      Left = 85
      Top = 13
      Width = 20
      Height = 20
      Caption = '&E'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = eClick
    end
    object f: TButton
      Left = 105
      Top = 13
      Width = 20
      Height = 20
      Caption = '&F'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = fClick
    end
    object g: TButton
      Left = 126
      Top = 13
      Width = 20
      Height = 20
      Caption = '&G'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = gClick
    end
    object h: TButton
      Left = 146
      Top = 13
      Width = 20
      Height = 20
      Caption = '&H'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      OnClick = hClick
    end
    object i: TButton
      Left = 166
      Top = 13
      Width = 20
      Height = 20
      Caption = '&I'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = iClick
    end
    object j: TButton
      Left = 186
      Top = 13
      Width = 20
      Height = 20
      Caption = '&J'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      OnClick = jClick
    end
    object k: TButton
      Left = 205
      Top = 13
      Width = 20
      Height = 20
      Caption = '&K'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      OnClick = kClick
    end
    object l: TButton
      Left = 226
      Top = 13
      Width = 20
      Height = 20
      Caption = '&L'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      OnClick = lClick
    end
    object m: TButton
      Left = 246
      Top = 13
      Width = 20
      Height = 20
      Caption = '&M'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      OnClick = mClick
    end
    object n: TButton
      Left = 266
      Top = 13
      Width = 20
      Height = 20
      Caption = '&N'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      OnClick = nClick
    end
    object o: TButton
      Left = 286
      Top = 13
      Width = 20
      Height = 20
      Caption = '&O'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      OnClick = oClick
    end
    object p: TButton
      Left = 306
      Top = 13
      Width = 20
      Height = 20
      Caption = '&P'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
      OnClick = pClick
    end
    object q: TButton
      Left = 327
      Top = 13
      Width = 20
      Height = 20
      Caption = '&Q'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
      OnClick = qClick
    end
    object r: TButton
      Left = 348
      Top = 13
      Width = 20
      Height = 20
      Caption = '&R'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 17
      OnClick = rClick
    end
    object s: TButton
      Left = 368
      Top = 13
      Width = 20
      Height = 20
      Caption = '&S'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 18
      OnClick = sClick
    end
    object t: TButton
      Left = 388
      Top = 13
      Width = 20
      Height = 20
      Caption = '&T'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 19
      OnClick = tClick
    end
    object u: TButton
      Left = 408
      Top = 13
      Width = 20
      Height = 20
      Caption = '&U'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 20
      OnClick = uClick
    end
    object v: TButton
      Left = 429
      Top = 13
      Width = 20
      Height = 20
      Caption = '&V'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 21
      OnClick = vClick
    end
    object w: TButton
      Left = 450
      Top = 13
      Width = 20
      Height = 20
      Caption = '&W'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 22
      OnClick = wClick
    end
    object x: TButton
      Left = 470
      Top = 13
      Width = 20
      Height = 20
      Caption = '&X'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 23
      OnClick = xClick
    end
    object y: TButton
      Left = 491
      Top = 13
      Width = 20
      Height = 20
      Caption = '&Y'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 24
      OnClick = yClick
    end
    object Button1: TButton
      Left = 509
      Top = 13
      Width = 20
      Height = 20
      Caption = '&Z'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 25
      OnClick = Button1Click
    end
  end
  object DataSource1: TDataSource
    DataSet = IBDataSet1
    Left = 408
    Top = 24
  end
  object IBDataSet1: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select * from "inv$articulo"'
      'where "inv$articulo"."nombre" like :"letra" || '#39'%'#39
      'order by "inv$articulo"."nombre"')
    Left = 224
    object IBDataSet1cod_articulo: TIntegerField
      FieldName = 'cod_articulo'
      Origin = 'inv$articulo.cod_articulo'
      Required = True
    end
    object IBDataSet1nombre: TIBStringField
      FieldName = 'nombre'
      Origin = 'inv$articulo.nombre'
      Size = 100
    end
    object IBDataSet1cod_clasificacion: TIntegerField
      FieldName = 'cod_clasificacion'
      Origin = 'inv$articulo.cod_clasificacion'
      Required = True
    end
    object IBDataSet1existencia: TIntegerField
      FieldName = 'existencia'
      Origin = 'inv$articulo.existencia'
    end
    object IBDataSet1precio_unitario: TIBBCDField
      FieldName = 'precio_unitario'
      Origin = 'inv$articulo.precio_unitario'
      currency = True
      Precision = 18
      Size = 2
    end
    object IBDataSet1cod_barras: TIntegerField
      FieldName = 'cod_barras'
      Origin = 'inv$articulo.cod_barras'
    end
  end
  object IBDataSet2: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      
        'select "inv$articulo"."detalle","inv$articulo"."nombre"  from "i' +
        'nv$articulo"'
      'where "inv$articulo"."cod_articulo"=:"cod"')
    Left = 88
    Top = 8
  end
end
