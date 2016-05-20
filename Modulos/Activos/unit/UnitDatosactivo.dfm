object FrmdatoActivo: TFrmdatoActivo
  Left = 144
  Top = 178
  Width = 517
  Height = 300
  BorderIcons = []
  Caption = 'Datos Del Activo'
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
    Width = 509
    Height = 129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 21
      Top = 18
      Width = 71
      Height = 13
      Caption = 'No de Placa'
    end
    object Label2: TLabel
      Left = 21
      Top = 46
      Width = 68
      Height = 13
      Caption = 'Descripcion'
    end
    object Label3: TLabel
      Left = 21
      Top = 74
      Width = 82
      Height = 13
      Caption = 'Fecha Ingreso'
    end
    object Label4: TLabel
      Left = 242
      Top = 74
      Width = 32
      Height = 13
      Caption = 'Clase'
    end
    object Label5: TLabel
      Left = 21
      Top = 104
      Width = 87
      Height = 13
      Caption = 'Seccion Actual'
    end
    object Label6: TLabel
      Left = 242
      Top = 104
      Width = 47
      Height = 13
      Caption = 'Agencia'
    end
    object Label13: TLabel
      Left = 242
      Top = 18
      Width = 40
      Height = 13
      Caption = 'Estado'
    end
    object descripcion: TEdit
      Left = 116
      Top = 43
      Width = 372
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object fecha: TEdit
      Left = 116
      Top = 71
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object clase: TEdit
      Left = 314
      Top = 71
      Width = 175
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object Agencia: TEdit
      Left = 314
      Top = 101
      Width = 176
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
    object Seccion: TEdit
      Left = 116
      Top = 101
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 5
    end
    object estado: TEdit
      Left = 314
      Top = 15
      Width = 171
      Height = 21
      ReadOnly = True
      TabOrder = 6
    end
    object placa: TMaskEdit
      Left = 116
      Top = 15
      Width = 107
      Height = 21
      EditMask = '!\09-99999;1;_'
      MaxLength = 8
      TabOrder = 0
      Text = '0 -     '
      OnKeyPress = placaKeyPress
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 130
    Width = 509
    Height = 98
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Label7: TLabel
      Left = 21
      Top = 10
      Width = 67
      Height = 13
      Caption = 'V. Historico'
    end
    object Label8: TLabel
      Left = 21
      Top = 38
      Width = 79
      Height = 13
      Caption = 'Dep. Mensual'
    end
    object Label9: TLabel
      Left = 21
      Top = 66
      Width = 69
      Height = 13
      Caption = 'V. en Libros'
    end
    object Label10: TLabel
      Left = 242
      Top = 10
      Width = 49
      Height = 13
      Caption = 'Vida Util'
    end
    object Label11: TLabel
      Left = 242
      Top = 38
      Width = 66
      Height = 13
      Caption = 'Dep. acum.'
    end
    object Label12: TLabel
      Left = 242
      Top = 66
      Width = 62
      Height = 13
      Caption = 'T. Deprec.'
    end
    object valor: TEdit
      Left = 116
      Top = 7
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object dmensual: TEdit
      Left = 116
      Top = 35
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object vlibros: TEdit
      Left = 116
      Top = 63
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object vida: TEdit
      Left = 314
      Top = 7
      Width = 175
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object dacumulada: TEdit
      Left = 314
      Top = 35
      Width = 175
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
    object tiempo: TEdit
      Left = 314
      Top = 63
      Width = 175
      Height = 21
      ReadOnly = True
      TabOrder = 5
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 229
    Width = 509
    Height = 36
    TabOrder = 2
    object Cancelar: TSpeedButton
      Left = 198
      Top = 5
      Width = 134
      Height = 25
      Caption = '&Ejecutar Consulta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
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
      ParentFont = False
      OnClick = CancelarClick
    end
    object Salir: TSpeedButton
      Left = 347
      Top = 5
      Width = 134
      Height = 25
      Caption = '&Salir'
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
      OnClick = SalirClick
    end
    object Aceptar: TBitBtn
      Left = 41
      Top = 5
      Width = 134
      Height = 25
      Caption = '&Nueva Consulta'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = AceptarClick
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
  object IBdatosactivo: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "act$activo"."descripcion",'
      '  "act$activo"."estado",'
      '  "act$activo"."fechacompra",'
      '  "act$activo"."preciocompra",'
      '  "act$clase_activo"."descripcion" AS "cactivo",'
      '  "Inv$Agencia"."descripcion" AS "oficina",'
      '  "inv$dependencia"."nombre",'
      '  "act$activo"."vidadepreciable"'
      'FROM'
      '  "Inv$Agencia",'
      '  "act$activo"'
      
        '  INNER JOIN "act$clase_activo" ON ("act$activo"."clase_activo" ' +
        '= "act$clase_activo"."cod_clase"),'
      '  "act$traslado"'
      
        '  INNER JOIN "inv$dependencia" ON ("act$traslado"."cod_seccion" ' +
        '= "inv$dependencia"."cod_dependencia")'
      'WHERE'
      '  ("act$activo"."cod_activo" = "act$traslado"."cod_activo") AND '
      
        '  ("act$traslado"."cod_oficina" = "Inv$Agencia"."cod_agencia") A' +
        'ND '
      '  ("act$traslado"."lugar" = '#39'A'#39') AND '
      '  ("act$activo"."estado" = '#39'A'#39') AND '
      '  ("act$activo"."placa" = :"placa") AND'
      '  ("act$activo"."esactivo"=1)'
      '')
    Left = 8
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'placa'
        ParamType = ptUnknown
      end>
  end
end
