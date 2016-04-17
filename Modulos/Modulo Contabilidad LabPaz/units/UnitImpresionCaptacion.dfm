object frmImpresionCaptacion: TfrmImpresionCaptacion
  Left = 182
  Top = 137
  Width = 512
  Height = 296
  Caption = 'Impresi'#243'n de la Captaci'#243'n'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 504
    Height = 141
    Align = alTop
    TabOrder = 0
    object Label24: TLabel
      Left = 110
      Top = 10
      Width = 105
      Height = 13
      Caption = 'Tipo de Captaci'#243'n'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label25: TLabel
      Left = 350
      Top = 8
      Width = 44
      Height = 13
      Caption = 'N'#250'mero'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label26: TLabel
      Left = 2
      Top = 52
      Width = 44
      Height = 13
      Caption = 'Nombre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 28
      Top = 10
      Width = 47
      Height = 13
      Caption = 'Agencia'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 2
      Top = 82
      Width = 100
      Height = 13
      Caption = 'Impresora Actual:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBLCBTipoCaptacion: TDBLookupComboBox
      Left = 110
      Top = 24
      Width = 235
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      KeyField = 'ID_TIPO_CAPTACION'
      ListField = 'DESCRIPCION'
      ListSource = DSTiposCaptacion
      ParentFont = False
      TabOrder = 1
    end
    object EdNumeroCap: TJvEdit
      Left = 348
      Top = 24
      Width = 81
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
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 7
      ParentFont = False
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 2
      OnEnter = EdNumeroCapEnter
      OnExit = EdNumeroCapExit
      OnKeyPress = EdNumeroCapKeyPress
    end
    object EdDigitoCap: TStaticText
      Left = 430
      Top = 24
      Width = 21
      Height = 21
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelKind = bkFlat
      BorderStyle = sbsSunken
      Color = clCaptionText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 4
    end
    object EdNombreCap: TStaticText
      Left = 50
      Top = 50
      Width = 449
      Height = 21
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clCaptionText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 5
    end
    object CmdImprimir: TBitBtn
      Left = 6
      Top = 110
      Width = 121
      Height = 25
      Caption = '&Imprimir Formulario'
      Enabled = False
      TabOrder = 3
      OnClick = CmdImprimirClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000220B0000220B0000000100000001000000840000088C
        0800108C080018941000219410001894180029941800219C2100299C210029A5
        2900E78C31005AA53900B56B4A006BAD4A0073AD4A008C6B5200946B5200E79C
        5200A5635A00A56B5A00BD7B5A0084B55A00FFB55A0063BD6300A5636B00A573
        6B00BD846B00C6846B00D6946B00A5B56B0073BD6B00DE9C7300CEB5730094BD
        73009CBD7300ADBD730073C673007BC6730084C6730094C673009CC67300E7AD
        7B00DEBD7B00EFBD7B009CC67B00EFC67B00EFBD84009CC68400EFC68400F7C6
        840084CE8400EFC68C00F7CE8C00B5AD9400ADB59400EFC69400A5CE9400C6CE
        9400D6CE9400E7CE9400F7CE9400BDCE9C00EFCE9C00BDD69C00EFCEA500ADD6
        A500BDD6A500F7D6A500A5DEA500EFD6AD00F7D6AD00B5DEAD00DECEB500F7D6
        B500F7DEB500F7DEBD00DEC6C600FFEFC600FFEFCE00E7E7D600F7EFD600FFEF
        DE00DEF7DE00E7F7DE00FFEFE700E7F7E700FFF7E700F7F7EF00FFF7EF00FFF7
        F700F7FFF700FFFFF700FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005C5C18181818
        1818181818181818185C5C5C184D393A3E3B302E2B2E2E30185C5C5C184E2208
        0D04040B202B2B30185C5C5C12513D0200000000062A2B30185C5C5C12563D03
        0003230E000E2E30185C5C5C19584201000015401D0D3330185C5C5C195D4F38
        2F212245402C3733185C5C5C1A5D4454502F212122403E3C185C5C5C1A5D2441
        5426000001454043185C5C5C1C5D32002541050002494640185C5C5C1C5D5709
        00000000024E4835185C5C5C1F5D5D521707071E08101313185C5C5C1F5D5D5D
        5D52525B360F110A0C5C5C5C295D5D5D5D5D5D5D4C1316145C5C5C5C29575757
        575757574C131A5C5C5C5C5C291C1C1C1C1C1C1C1C135C5C5C5C}
    end
    object DBLCBAgencia: TDBLookupComboBox
      Left = 4
      Top = 24
      Width = 105
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      KeyField = 'ID_AGENCIA'
      ListField = 'DESCRIPCION_AGENCIA'
      ListSource = DSAgencia
      ParentFont = False
      TabOrder = 0
    end
    object CmdImprimirTarjeta: TBitBtn
      Left = 130
      Top = 110
      Width = 121
      Height = 25
      Caption = '&Imprimir Tarjeta'
      Enabled = False
      TabOrder = 6
      OnClick = CmdImprimirTarjetaClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000330B0000330B000000010000000100002D2D2D001855
        6F004544420058534E005160610054777B006E6E6E007C707800B56D3E00C171
        3500C07638008A5B520098586A0098606A00947E7500A16A6A00AD7B7300B673
        7300C07B7300FFA13800EFA65A00EDA75F00F0A85C00CA847B00D48F7B000000
        9A000316AC0041749600477AA9000018C6001029D600106BFF00FF00FF0035A8
        F5004A9EED006D8AFD00848484009891A200A1A1A100F1BC8600F8C28C00F9C4
        8D00F7D6AD00FBD3A900F7DEBD00F7E7CE00F7EFE700FFF7EF00FFF4F400FFFF
        FF00000000000000000000000000000000000000000000000000000000000000
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
        0000000000000000000000000000000000000000000000000000202020202020
        2020202020202020202020202020202020202020202020202020202020202020
        2020202020202020202020200F0F0F0F0F0F0F0F0F0F0F0F0F20200C302E0003
        2A2D2D2D2C2C2C2A2A0F200C2F300302042A2D2D2D2C2C2C2A0F200D2F2F2E05
        1C010B2A2D2D2D2C2C0F200D312626051B0E090B062424242C0F20113131312F
        0727160A0B2C2E2D2C0F201131313131102B29140A0B2C2E2D0F201231262626
        26102B2916090B242E0F2012313131313131102B2815080B2C0F201713131313
        131313102B25211A19202018131313130F20202010221E1E1A19202018181818
        20202020201D231F1E202020202020202020202020201D1D2020}
    end
    object EdImpresora: TStaticText
      Left = 104
      Top = 78
      Width = 313
      Height = 21
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clCaptionText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 7
    end
    object CmdImpresora: TBitBtn
      Left = 422
      Top = 76
      Width = 75
      Height = 25
      Caption = '&Impresora'
      TabOrder = 8
      OnClick = CmdImpresoraClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000420B0000420B00000001000000010000313131003131
        39004A4A4200525252005A5A63006B6363007B7363006B6B6B007B7B7B008484
        84008C8C8C009C9C9C00A5A5A500ADA5A5002139AD00ADA5AD00ADADAD00B5AD
        AD00FFBDAD00FFC6AD00B5B5B500BDB5B500DEB5B500B5BDB500D6BDB500F7BD
        B500FFCEB500BDBDBD00C6BDBD00BDDEBD00C6BDC600C6C6C600FFD6C600CECE
        CE00D6CECE00EFD6CE00FFDECE00D6D6D600DEDEDE00E7DEDE00FFE7DE00DEE7
        E700E7E7E700F7EFE7007B94EF00EFEFEF00F7F7F700FF00FF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF002F2F2F2F2F2F
        092F2F2F0B0B0C2F2F2F2F2F2F2F0909260D03071021260B2F2F2F2F09092E30
        261104000003090B0C2F09092D302D25140C0F0B080301010A2F092D2A211414
        21140D0C0F100C090B2F091B141425262D2E2A211B100C0F0C2F09142525252A
        261714252626221F102F2F0926252A25141D2114151B1F211B2F2F2F09211B1C
        2A2E2D2B27141F092F2F2F2F2F092925142126262625092F2F2F2F2F2F2F2B28
        232323270202020202022F2F2F2F162824201A13022C0E2828052F2F2F2F1628
        20201A122C0E2C0E28052F2F2F2F162820201A120228280E2C062F2F2F162828
        24201A12022828280E2C2F2F2F1616161619192F02050505060E}
    end
    object CmdCerrar: TBitBtn
      Left = 424
      Top = 108
      Width = 75
      Height = 25
      Caption = 'Cerrar'
      TabOrder = 9
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
    object CmdNuevoReporte: TBitBtn
      Left = 252
      Top = 110
      Width = 109
      Height = 25
      Caption = 'Formulario'
      Enabled = False
      TabOrder = 10
      OnClick = CmdNuevoReporteClick
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
  end
  object DSTiposCaptacion: TDataSource
    DataSet = dmCaptacion.IBTiposCaptacion
    Left = 314
    Top = 152
  end
  object ReporteCer: TprTxReport
    FromPage = 1
    ToPage = 1
    ExportFromPage = 0
    ExportToPage = 0
    Values = <>
    Variables = <
      item
        Name = 'LETRAS'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'NOMINAL'
        ValueType = 'prvvtString'
        Value = ''
      end>
    PrinterName = 'EPSON FX-1180+ ESC/P'
    ESCModelName = 'Epson printers'
    WrapAfterColumn = 0
    EjectPageAfterPrint = False
    LinesOnPage = 0
    FromLine = 0
    ToLine = 0
    ExportFromLine = 0
    ExportToLine = 0
    Left = 116
    Top = 150
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
      ColNum = 160
      object prTxHDetailBand1: TprTxHDetailBand
        Height = 22
        UseVerticalBands = False
        DataSetName = 'IBQuery'
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        object prTxMemoObj1: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<dd>IBQuery.FECHA_APERTURA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 35
          dRec.Top = 6
          dRec.Right = 37
          dRec.Bottom = 7
          Visible = False
        end
        object prTxMemoObj2: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<MM>IBQuery.FECHA_APERTURA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 39
          dRec.Top = 6
          dRec.Right = 42
          dRec.Bottom = 7
          Visible = False
        end
        object prTxMemoObj3: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy>IBQuery.FECHA_APERTURA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 44
          dRec.Top = 6
          dRec.Right = 48
          dRec.Bottom = 7
          Visible = False
        end
        object prTxMemoObj4: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<dd>IBQuery.FECHA_VENCIMIENTO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 50
          dRec.Top = 6
          dRec.Right = 52
          dRec.Bottom = 7
          Visible = False
        end
        object prTxMemoObj5: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<MM>IBQuery.FECHA_VENCIMIENTO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 54
          dRec.Top = 6
          dRec.Right = 57
          dRec.Bottom = 7
          Visible = False
        end
        object prTxMemoObj6: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy>IBQuery.FECHA_VENCIMIENTO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 59
          dRec.Top = 6
          dRec.Right = 63
          dRec.Bottom = 7
          Visible = False
        end
        object prTxMemoObj7: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0>IBQuery.VALOR_INICIAL]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 37
          dRec.Top = 9
          dRec.Right = 51
          dRec.Bottom = 10
          Visible = False
        end
        object prTxCommandObj1: TprTxCommandObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              TxCommands = (
                txcReset
                txcCondensedOff
                txcNormal)
            end>
          dRec.Left = 0
          dRec.Top = 0
          dRec.Right = 1
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQuery.DESCRIPCION_AGENCIA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 9
          dRec.Top = 9
          dRec.Right = 19
          dRec.Bottom = 10
          Visible = False
        end
        object prTxMemoObj9: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[IBQuery.ID_TIPO_CAPTACION_ABONO][:<00>IBQuery.ID_AGENCIA]-[:<00' +
                  '00000>IBQuery.NUMERO_CUENTA_ABONO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 22
          dRec.Top = 9
          dRec.Right = 34
          dRec.Bottom = 10
          Visible = False
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<0000000>IBQuery.NUMERO_CUENTA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold
                tfoWide
                tfo12cpi)
            end>
          dRec.Left = 65
          dRec.Top = 5
          dRec.Right = 72
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj11: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQuery.ID_PERSONA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 53
          dRec.Top = 9
          dRec.Right = 65
          dRec.Bottom = 10
          Visible = False
        end
        object prTxMemoObj12: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQuery.LUGAR_EXPEDICION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 66
          dRec.Top = 9
          dRec.Right = 77
          dRec.Bottom = 10
          Visible = False
        end
        object prTxMemoObj13: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[IBQuery.PRIMER_APELLIDO] [IBQuery.SEGUNDO_APELLIDO] [IBQuery.NO' +
                  'MBRE]xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold
                tfoWide
                tfo12cpi)
            end>
          dRec.Left = 13
          dRec.Top = 11
          dRec.Right = 51
          dRec.Bottom = 12
          Visible = False
        end
        object prTxMemoObj14: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[LETRAS]xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' +
                  'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' +
                  'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' +
                  'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' +
                  'xxxxxxxxxxxxxxxxxxxxxx')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoCondensed
                tfoBold)
            end>
          dRec.Left = 14
          dRec.Top = 13
          dRec.Right = 123
          dRec.Bottom = 14
          Visible = False
        end
        object prTxMemoObj15: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#0.00%>NOMINAL]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfo12cpi)
            end>
          dRec.Left = 22
          dRec.Top = 18
          dRec.Right = 29
          dRec.Bottom = 19
          Visible = False
        end
        object prTxMemoObj16: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#0.00%>IBQuery.TASA_EFECTIVA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 35
          dRec.Top = 18
          dRec.Right = 45
          dRec.Bottom = 19
          Visible = False
        end
        object prTxMemoObj17: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CADA [IBQuery.AMORTIZACION] DIAS')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 16
          dRec.Top = 20
          dRec.Right = 75
          dRec.Bottom = 21
          Visible = False
        end
      end
    end
  end
  object IBQuery: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "cap$maestro".ID_AGENCIA,'
      '  "cap$maestro".ID_TIPO_CAPTACION,'
      '  "cap$maestro".NUMERO_CUENTA,'
      '  "cap$maestro".DIGITO_CUENTA,'
      '  "cap$maestro".VALOR_INICIAL,'
      '  "cap$maestro".ID_FORMA,'
      '  "cap$maestro".FECHA_APERTURA,'
      '  "cap$maestro".PLAZO_CUENTA,'
      '  "cap$maestro".TIPO_INTERES,'
      '  "cap$maestro".ID_INTERES,'
      '  "cap$maestro".TASA_EFECTIVA,'
      '  "cap$maestro".PUNTOS_ADICIONALES,'
      '  "cap$maestro".MODALIDAD,'
      '  "cap$maestro".AMORTIZACION,'
      '  "cap$maestro".CUOTA,'
      '  "cap$maestro".CUOTA_CADA,'
      '  "cap$maestro".ID_PLAN,'
      '  "cap$maestro".ID_ESTADO,'
      '  "cap$maestro".FECHA_VENCIMIENTO,'
      '  "cap$maestro".FECHA_ULTIMO_PAGO,'
      '  "cap$maestro".FECHA_PROXIMO_PAGO,'
      '  "cap$maestro".FECHA_PRORROGA,'
      '  "cap$maestro".FECHA_VENCIMIENTO_PRORROGA,'
      '  "cap$maestro".FIRMAS,'
      '  "cap$maestro".SELLOS,'
      '  "cap$maestro".PROTECTOGRAFOS,'
      '  "cap$maestro".ID_TIPO_CAPTACION_ABONO,'
      '  "cap$maestro".NUMERO_CUENTA_ABONO,'
      '  "cap$tiposestado".DESCRIPCION,'
      '  "cap$tiposestado".PARA_ACTIVAR,'
      '  "cap$tiposestado".PARA_SALDAR,'
      '  "cap$tiposestado".PERMITE_MOVIMIENTO,'
      '  "gen$agencia".DESCRIPCION_AGENCIA,'
      '  "gen$persona".ID_IDENTIFICACION,'
      '  "gen$persona".ID_PERSONA,'
      '  "gen$persona".LUGAR_EXPEDICION,'
      '  "gen$persona".FECHA_EXPEDICION,'
      '  "gen$persona".SEXO,'
      '  "gen$persona".FECHA_NACIMIENTO,'
      '  "gen$persona".LUGAR_NACIMIENTO,'
      '  "gen$persona".NOMBRE,'
      '  "gen$persona".PRIMER_APELLIDO,'
      '  "gen$persona".SEGUNDO_APELLIDO,'
      '  "gen$persona".ID_IDENTIFICACION_CONYUGE,'
      '  "gen$persona".ID_CONYUGE,'
      '  "gen$persona".PRIMER_APELLIDO_CONYUGE,'
      '  "gen$persona".SEGUNDO_APELLIDO_CONYUGE,'
      '  "gen$persona".NOMBRE_CONYUGE,'
      '  "gen$persona".INGRESOS_CONYUGE,'
      '  "gen$persona".INGRESOS_CONYUGE_OTROS,'
      '  "gen$persona".EGRESOS_CONYUGE,'
      '  "gen$persona".OTROS_EGRESOS_CONYUGE,'
      '  "gen$persona".PROFESION,'
      '  "gen$persona".EMPRESA_LABORA,'
      '  "gen$persona".CARGO_ACTUAL,'
      '  "gen$persona".DECLARACION,'
      '  "gen$persona".INGRESOS_A_PRINCIPAL,'
      '  "gen$persona".INGRESOS_OTROS,'
      '  "gen$persona".DESC_INGR_OTROS,'
      '  "gen$persona".EGRESOS_ALQUILER,'
      '  "gen$persona".EGRESOS_ALIMENTACION,'
      '  "gen$persona".EGRESOS_TRANSPORTE,'
      '  "gen$persona".EGRESOS_SERVICIOS,'
      '  "gen$persona".EGRESOS_DEUDAS,'
      '  "gen$persona".EGRESOS_OTROS,'
      '  "gen$persona".TOTAL_ACTIVOS,'
      '  "gen$persona".TOTAL_PASIVOS,'
      '  "gen$tiposestadocivil".DESCRIPCION_ESTADO_CIVIL,'
      '  "gen$tiposidentificacion".DESCRIPCION_IDENTIFICACION'
      'FROM'
      '  "cap$maestro"'
      
        '  LEFT JOIN "cap$maestrotitular" ON ("cap$maestro".ID_AGENCIA = ' +
        '"cap$maestrotitular".ID_AGENCIA) AND ("cap$maestro".ID_TIPO_CAPT' +
        'ACION = "cap$maestrotitular".ID_TIPO_CAPTACION) AND ("cap$maestr' +
        'o".NUMERO_CUENTA = "cap$maestrotitular".NUMERO_CUENTA) AND ("cap' +
        '$maestro".DIGITO_CUENTA = "cap$maestrotitular".DIGITO_CUENTA)'
      '  LEFT JOIN "gen$agencia" ON'
      '("cap$maestro".ID_AGENCIA = "gen$agencia".ID_AGENCIA)'
      
        '  LEFT JOIN "gen$persona" ON ("cap$maestrotitular".ID_IDENTIFICA' +
        'CION = "gen$persona".ID_IDENTIFICACION) AND ("cap$maestrotitular' +
        '".ID_PERSONA = "gen$persona".ID_PERSONA)'
      
        '  LEFT JOIN "cap$tiposestado" ON ("cap$maestro".ID_ESTADO = "cap' +
        '$tiposestado".ID_ESTADO)'
      
        ' LEFT JOIN "gen$tiposestadocivil" ON "gen$persona".ID_TIPO_ESTAD' +
        'O_CIVIL = "gen$tiposestadocivil".ID_TIPO_ESTADO_CIVIL'
      ' LEFT JOIN "gen$tiposidentificacion" ON'
      
        '("gen$persona".ID_IDENTIFICACION = "gen$tiposidentificacion".ID_' +
        'IDENTIFICACION)'
      'WHERE'
      '  ("cap$maestro".ID_AGENCIA = :ID_AGENCIA) AND '
      '  ("cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION) AND '
      '  ("cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA) AND '
      '  ("cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA)'
      'ORDER BY'
      '  "cap$maestrotitular".NUMERO_TITULAR')
    Left = 152
    Top = 150
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_AGENCIA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_TIPO_CAPTACION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NUMERO_CUENTA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DIGITO_CUENTA'
        ParamType = ptUnknown
      end>
  end
  object IBAgencias: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "gen$agencia"')
    Left = 258
    Top = 152
  end
  object DSAgencia: TDataSource
    DataSet = IBAgencias
    Left = 286
    Top = 152
  end
  object IBSql: TIBSQL
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 178
    Top = 152
  end
  object NLetra: TNLetra
    Numero = 0
    Letras = 'Cero'
    Left = 206
    Top = 152
  end
  object ReporteCap: TprTxReport
    FromPage = 1
    ToPage = 1
    ExportFromPage = 0
    ExportToPage = 0
    Values = <>
    Variables = <
      item
        Name = 'CUENTA'
        ValueType = 'prvvtString'
        Value = '201-0026305'
      end
      item
        Name = 'APERTURA'
        ValueType = 'prvvtDateTime'
        Value = 36948d
      end
      item
        Name = 'CIUDAD'
        ValueType = 'prvvtString'
        Value = 'OCA'#209'A'
      end
      item
        Name = 'FIRMAS'
        ValueType = 'prvvtInteger'
        Value = 0
      end
      item
        Name = 'TIPO_CUENTA'
        ValueType = 'prvvtString'
        Value = 'Individual'
      end
      item
        Name = 'SELLOS'
        ValueType = 'prvvtInteger'
        Value = 0
      end
      item
        Name = 'PROTECTOGRAFOS'
        ValueType = 'prvvtInteger'
        Value = 0
      end>
    PrinterName = 'EPSON FX-1180+ ESC/P'
    WrapAfterColumn = 0
    EjectPageAfterPrint = False
    LinesOnPage = 0
    FromLine = 0
    ToLine = 0
    ExportFromLine = 0
    ExportToLine = 0
    Left = 6
    Top = 150
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
      LineNum = 100
      ColNum = 140
      object prTxHTitleBand1: TprTxHTitleBand
        Height = 5
        UseVerticalBands = False
        object prTxMemoObj1: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'FORMULARIO DE APERTURA Y ACTUALIZACION DE DATOS')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = True
            end>
          dRec.Left = 60
          dRec.Top = 2
          dRec.Right = 87
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Impreso:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 121
          dRec.Top = 4
          dRec.Right = 129
          dRec.Bottom = 5
          Visible = False
        end
        object prTxMemoObj9: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/mm/dd>StartDateTime]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 129
          dRec.Top = 4
          dRec.Right = 139
          dRec.Bottom = 5
          Visible = False
        end
        object prTxCommandObj1: TprTxCommandObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
            end>
          dRec.Left = 0
          dRec.Top = 0
          dRec.Right = 1
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHPageHeaderBand1: TprTxHPageHeaderBand
        Height = 5
        UseVerticalBands = False
        PrintOnFirstPage = True
        object prTxMemoObj2: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Cuenta No.')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 64
          dRec.Top = 0
          dRec.Right = 74
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj3: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CUENTA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 74
          dRec.Top = 0
          dRec.Right = 85
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj4: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Fecha de Apertura:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 86
          dRec.Top = 0
          dRec.Right = 104
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj5: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/mm/dd>APERTURA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 104
          dRec.Top = 0
          dRec.Right = 114
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj6: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Ciudad:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 115
          dRec.Top = 0
          dRec.Right = 122
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj7: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CIUDAD]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 122
          dRec.Top = 0
          dRec.Right = 132
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'I. CONDICIONES DE MANEJO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 64
          dRec.Top = 2
          dRec.Right = 88
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj11: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Tipo de Cuenta: ')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 64
          dRec.Top = 3
          dRec.Right = 79
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj12: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[TIPO_CUENTA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 79
          dRec.Top = 3
          dRec.Right = 89
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj13: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Requisitos: Nro de Firmas:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 91
          dRec.Top = 3
          dRec.Right = 117
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj14: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<00>FIRMAS]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 117
          dRec.Top = 3
          dRec.Right = 119
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj15: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Nro de Sellos:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 120
          dRec.Top = 3
          dRec.Right = 134
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj16: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<00>SELLOS]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 134
          dRec.Top = 3
          dRec.Right = 136
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj17: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Protectografos:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 91
          dRec.Top = 4
          dRec.Right = 106
          dRec.Bottom = 5
          Visible = False
        end
        object prTxMemoObj18: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<00>PROTECTOGRAFOS]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 106
          dRec.Top = 4
          dRec.Right = 108
          dRec.Bottom = 5
          Visible = False
        end
      end
      object prTxHDetailBand1: TprTxHDetailBand
        Height = 9
        UseVerticalBands = False
        DataSetName = 'IBPersona'
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        object prTxMemoObj19: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'INFORMACION SOLICITANTE')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 20
          dRec.Top = 0
          dRec.Right = 44
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj20: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBPersona.RecNo]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 47
          dRec.Top = 0
          dRec.Right = 48
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj21: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Nombres y Apellidos:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 20
          dRec.Top = 1
          dRec.Right = 40
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj22: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[IBPersona.NOMBRE] [IBPersona.PRIMER_APELLIDO] [IBPersona.SEGUND' +
                  'O_APELLIDO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 40
          dRec.Top = 1
          dRec.Right = 122
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj23: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Identificacion No.:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 20
          dRec.Top = 2
          dRec.Right = 39
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj24: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBPersona.ID_PERSONA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 39
          dRec.Top = 2
          dRec.Right = 51
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj25: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Expedida en:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 52
          dRec.Top = 2
          dRec.Right = 64
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj26: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBPersona.LUGAR_EXPEDICION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 64
          dRec.Top = 2
          dRec.Right = 84
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj27: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Fecha Exp:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 85
          dRec.Top = 2
          dRec.Right = 95
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj28: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/mm/dd>IBPersona.FECHA_EXPEDICION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 95
          dRec.Top = 2
          dRec.Right = 105
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj29: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Sexo:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 106
          dRec.Top = 2
          dRec.Right = 111
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj30: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'iif(IBPersona.SEXO = M,Masculino,Femenino)')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 112
          dRec.Top = 2
          dRec.Right = 122
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj31: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Fecha de Nacimiento:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 20
          dRec.Top = 3
          dRec.Right = 40
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj32: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/mm/dd>IBPersona.FECHA_NACIMIENTO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 41
          dRec.Top = 3
          dRec.Right = 49
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj33: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Lugar de Nacimiento:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 50
          dRec.Top = 3
          dRec.Right = 70
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj34: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBPersona.LUGAR_NACIMIENTO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 71
          dRec.Top = 3
          dRec.Right = 91
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj35: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Estado Civil:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 92
          dRec.Top = 3
          dRec.Right = 105
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj36: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 106
          dRec.Top = 3
          dRec.Right = 116
          dRec.Bottom = 4
          Visible = False
        end
      end
    end
  end
  object IBPersona: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      
        'select * from "gen$persona" where ID_IDENTIFICACION = :ID_IDENTI' +
        'FICACION and ID_PERSONA = :ID_PERSONA')
    Left = 62
    Top = 150
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
  object IBTitulares: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    AfterScroll = IBTitularesAfterScroll
    SQL.Strings = (
      'SELECT'
      '"cap$maestrotitular".ID_IDENTIFICACION,'
      '"cap$maestrotitular".ID_PERSONA,'
      '"gen$persona".LUGAR_EXPEDICION,'
      '"gen$persona".FECHA_EXPEDICION,'
      '"gen$persona".SEXO,'
      '"gen$persona".FECHA_NACIMIENTO,'
      '"gen$persona".LUGAR_NACIMIENTO,'
      '"gen$persona".NOMBRE,'
      '"gen$persona".PRIMER_APELLIDO,'
      '"gen$persona".SEGUNDO_APELLIDO,'
      '"gen$persona".ID_IDENTIFICACION_CONYUGE,'
      '"gen$persona".ID_CONYUGE,'
      '"gen$persona".PRIMER_APELLIDO_CONYUGE,'
      '"gen$persona".SEGUNDO_APELLIDO_CONYUGE,'
      '"gen$persona".NOMBRE_CONYUGE,'
      '"gen$persona".INGRESOS_CONYUGE,'
      '"gen$persona".INGRESOS_CONYUGE_OTROS,'
      '"gen$persona".EGRESOS_CONYUGE,'
      '"gen$persona".OTROS_EGRESOS_CONYUGE,'
      '"gen$persona".PROFESION,'
      '"gen$persona".EMPRESA_LABORA,'
      '"gen$persona".CARGO_ACTUAL,'
      '"gen$persona".DECLARACION,'
      '"gen$persona".INGRESOS_A_PRINCIPAL,'
      '"gen$persona".INGRESOS_OTROS,'
      '"gen$persona".DESC_INGR_OTROS,'
      '"gen$persona".EGRESOS_ALQUILER,'
      '"gen$persona".EGRESOS_ALIMENTACION,'
      '"gen$persona".EGRESOS_TRANSPORTE,'
      '"gen$persona".EGRESOS_SERVICIOS,'
      '"gen$persona".EGRESOS_DEUDAS,'
      '"gen$persona".EGRESOS_OTROS,'
      '"gen$persona".TOTAL_ACTIVOS,'
      '"gen$persona".TOTAL_PASIVOS,'
      '"gen$persona".EDUCACION,'
      '"gen$tiposestadocivil".DESCRIPCION_ESTADO_CIVIL,'
      '"gen$tiposidentificacion".DESCRIPCION_IDENTIFICACION,'
      '"gen$tiposidentificacion".INICIAL_IDENTIFICACION,'
      '"cap$tipostitulares".ID_TIPO_TITULAR,'
      '"cap$maestrotitular".NUMERO_TITULAR,'
      '"cap$tipostitulares".DESCRIPCION_TIPO_TITULAR'
      'FROM "cap$maestrotitular"'
      
        'INNER JOIN "gen$persona" ON ("cap$maestrotitular".ID_IDENTIFICAC' +
        'ION = "gen$persona".ID_IDENTIFICACION and'
      '"cap$maestrotitular".ID_PERSONA = "gen$persona".ID_PERSONA)'
      
        'INNER JOIN "cap$tipostitulares" ON ("cap$maestrotitular".TIPO_TI' +
        'TULAR = "cap$tipostitulares".ID_TIPO_TITULAR)'
      
        ' LEFT JOIN "gen$tiposestadocivil" ON "gen$persona".ID_TIPO_ESTAD' +
        'O_CIVIL = "gen$tiposestadocivil".ID_TIPO_ESTADO_CIVIL'
      ' LEFT JOIN "gen$tiposidentificacion" ON'
      
        '("gen$persona".ID_IDENTIFICACION = "gen$tiposidentificacion".ID_' +
        'IDENTIFICACION)'
      ''
      'where'
      '"cap$maestrotitular".ID_AGENCIA = :ID_AGENCIA and'
      '"cap$maestrotitular".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION and'
      '"cap$maestrotitular".NUMERO_CUENTA = :NUMERO_CUENTA and'
      '"cap$maestrotitular".DIGITO_CUENTA = :DIGITO_CUENTA'
      'Order By'
      
        '"cap$maestrotitular".TIPO_TITULAR,"cap$maestrotitular".NUMERO_TI' +
        'TULAR')
    Left = 34
    Top = 150
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_AGENCIA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_TIPO_CAPTACION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NUMERO_CUENTA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DIGITO_CUENTA'
        ParamType = ptUnknown
      end>
  end
  object IBDirRes: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      
        'select first 1 * from "gen$direccion" where ID_IDENTIFICACION = ' +
        ':ID_IDENTIFICACION and ID_PERSONA = :ID_PERSONA and ID_DIRECCION' +
        ' = 1')
    Left = 34
    Top = 178
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
  object IBDirCor: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      
        'select first 1 * from "gen$direccion" where ID_IDENTIFICACION = ' +
        ':ID_IDENTIFICACION and ID_PERSONA = :ID_PERSONA and ID_DIRECCION' +
        ' = 2')
    Left = 62
    Top = 178
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
  object IBDirEmp: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      
        'select first 1 * from "gen$direccion" where ID_IDENTIFICACION = ' +
        ':ID_IDENTIFICACION and ID_PERSONA = :ID_PERSONA and ID_DIRECCION' +
        ' = 3')
    Left = 90
    Top = 178
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
  object IBAutorizado: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "gen$persona".ID_PERSONA,'
      '  "gen$persona".PRIMER_APELLIDO,'
      '  "gen$persona".SEGUNDO_APELLIDO,'
      '  "gen$persona".NOMBRE,'
      '  "cap$maestrotitular".ID_PERSONA'
      'FROM'
      '  "cap$maestro"'
      
        '  INNER JOIN "cap$maestrotitular" ON ("cap$maestro".ID_AGENCIA =' +
        ' "cap$maestrotitular".ID_AGENCIA) AND ("cap$maestro".ID_TIPO_CAP' +
        'TACION = "cap$maestrotitular".ID_TIPO_CAPTACION) AND ("cap$maest' +
        'ro".NUMERO_CUENTA = "cap$maestrotitular".NUMERO_CUENTA) AND ("ca' +
        'p$maestro".DIGITO_CUENTA = "cap$maestrotitular".DIGITO_CUENTA)'
      
        '  INNER JOIN "gen$persona" ON ("cap$maestrotitular".ID_IDENTIFIC' +
        'ACION = "gen$persona".ID_IDENTIFICACION) AND ("cap$maestrotitula' +
        'r".ID_PERSONA = "gen$persona".ID_PERSONA)'
      'WHERE'
      '  ("cap$maestro".ID_AGENCIA = :ID_AGENCIA) AND '
      '  ("cap$maestro".ID_TIPO_CAPTACION = :ID_TIPO_CAPTACION) AND '
      '  ("cap$maestro".NUMERO_CUENTA = :NUMERO_CUENTA) AND '
      '  ("cap$maestro".DIGITO_CUENTA = :DIGITO_CUENTA) AND '
      '  ("cap$maestrotitular".TIPO_TITULAR = 2)')
    Left = 34
    Top = 206
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_AGENCIA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_TIPO_CAPTACION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NUMERO_CUENTA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DIGITO_CUENTA'
        ParamType = ptUnknown
      end>
  end
  object IBReferencias: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT'
      '  "gen$referencias".PRIMER_APELLIDO_REFERENCIA,'
      '  "gen$referencias".SEGUNDO_APELLIDO_REFERENCIA,'
      '  "gen$referencias".NOMBRE_REFERENCIA,'
      '  "gen$referencias".DIRECCION_REFERENCIA,'
      '  "gen$referencias".TELEFONO_REFERENCIA,'
      '  "gen$tiposreferencia".DESCRIPCION_REFERENCIA,'
      '  "gen$tiposparentesco".DESCRIPCION_PARENTESCO'
      'FROM'
      '  "gen$referencias"'
      
        '  INNER JOIN "gen$tiposreferencia" ON ("gen$referencias".TIPO_RE' +
        'FERENCIA = "gen$tiposreferencia".ID_REFERENCIA)'
      
        '  INNER JOIN "gen$tiposparentesco" ON ("gen$referencias".PARENTE' +
        'SCO_REFERENCIA = "gen$tiposparentesco".ID_PARENTESCO)'
      ' WHERE'
      '"gen$referencias".TIPO_ID_REFERENCIA = :ID_IDENTIFICACION and'
      '"gen$referencias".ID_REFERENCIA = :ID_PERSONA')
    Left = 64
    Top = 206
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
  object IBFuncionario: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      
        'select NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO from "gen$emple' +
        'ado" where ID_EMPLEADO = :ID_EMPLEADO')
    Left = 92
    Top = 206
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_EMPLEADO'
        ParamType = ptUnknown
      end>
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 380
    Top = 150
  end
  object prTxReport1: TprTxReport
    FromPage = 1
    ToPage = 1
    ExportFromPage = 0
    ExportToPage = 0
    Values = <>
    Variables = <
      item
        Name = 'Empresa'
        ValueType = 'prvvtString'
        Value = 'COOPSERVIR LTDA'
      end>
    PrinterName = 'EPSON FX-1180+ ESC/P'
    WrapAfterColumn = 0
    EjectPageAfterPrint = False
    LinesOnPage = 0
    FromLine = 0
    ToLine = 0
    ExportFromLine = 0
    ExportToLine = 0
    Left = 132
    Top = 184
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
      ColNum = 160
      object prTxHPageHeaderBand1: TprTxHPageHeaderBand
        Height = 15
        UseVerticalBands = False
        PrintOnFirstPage = True
        object prTxMemoObj1: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '+---------------------------------------------------------------' +
                  '---------------------------+')
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
          dRec.Right = 92
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj2: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[Empresa]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 2
          dRec.Top = 1
          dRec.Right = 15
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj3: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'SOLICITUD DE INGRESO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 16
          dRec.Top = 1
          dRec.Right = 36
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj4: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Impreso el:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 37
          dRec.Top = 1
          dRec.Right = 48
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj5: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/MM/dd>StartDateTime]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 49
          dRec.Top = 1
          dRec.Right = 59
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj6: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Captacion:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 60
          dRec.Top = 1
          dRec.Right = 71
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj7: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 72
          dRec.Top = 1
          dRec.Right = 90
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 91
          dRec.Top = 1
          dRec.Right = 92
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj9: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '+---------------------------------------------------------------' +
                  '---------------------------+')
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
          dRec.Top = 2
          dRec.Right = 92
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
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
          dRec.Top = 1
          dRec.Right = 1
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj11: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
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
          dRec.Top = 3
          dRec.Right = 1
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj12: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
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
          dRec.Top = 5
          dRec.Right = 1
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj13: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
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
          dRec.Top = 7
          dRec.Right = 1
          dRec.Bottom = 8
          Visible = False
        end
        object prTxMemoObj14: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
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
          dRec.Top = 9
          dRec.Right = 1
          dRec.Bottom = 10
          Visible = False
        end
        object prTxMemoObj15: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
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
          dRec.Top = 11
          dRec.Right = 1
          dRec.Bottom = 12
          Visible = False
        end
        object prTxMemoObj16: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
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
          dRec.Top = 13
          dRec.Right = 1
          dRec.Bottom = 14
          Visible = False
        end
        object prTxMemoObj17: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '+---------------------------------------------------------------' +
                  '---------------------------+')
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
          dRec.Top = 4
          dRec.Right = 92
          dRec.Bottom = 5
          Visible = False
        end
        object prTxMemoObj18: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '+---------------------------------------------------------------' +
                  '---------------------------+')
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
          dRec.Top = 6
          dRec.Right = 92
          dRec.Bottom = 7
          Visible = False
        end
        object prTxMemoObj19: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '+---------------------------------------------------------------' +
                  '---------------------------+')
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
          dRec.Top = 8
          dRec.Right = 92
          dRec.Bottom = 9
          Visible = False
        end
        object prTxMemoObj20: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '+---------------------------------------------------------------' +
                  '---------------------------+')
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
          dRec.Top = 10
          dRec.Right = 92
          dRec.Bottom = 11
          Visible = False
        end
        object prTxMemoObj21: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '+---------------------------------------------------------------' +
                  '---------------------------+')
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
          dRec.Top = 12
          dRec.Right = 92
          dRec.Bottom = 13
          Visible = False
        end
        object prTxMemoObj22: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '+---------------------------------------------------------------' +
                  '---------------------------+')
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
          dRec.Top = 14
          dRec.Right = 92
          dRec.Bottom = 15
          Visible = False
        end
        object prTxMemoObj23: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Id:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 2
          dRec.Top = 3
          dRec.Right = 5
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj24: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 6
          dRec.Top = 3
          dRec.Right = 18
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj25: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Tp:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 19
          dRec.Top = 3
          dRec.Right = 22
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj26: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 23
          dRec.Top = 3
          dRec.Right = 42
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj27: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 18
          dRec.Top = 3
          dRec.Right = 19
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj28: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 43
          dRec.Top = 3
          dRec.Right = 44
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj29: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Exp:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 44
          dRec.Top = 3
          dRec.Right = 48
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj30: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 49
          dRec.Top = 3
          dRec.Right = 69
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj31: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Fecha Nac:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 70
          dRec.Top = 3
          dRec.Right = 80
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj32: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 81
          dRec.Top = 3
          dRec.Right = 91
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj33: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 69
          dRec.Top = 3
          dRec.Right = 70
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj34: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 91
          dRec.Top = 3
          dRec.Right = 92
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj35: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'NOMBRE:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 2
          dRec.Top = 5
          dRec.Right = 10
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj36: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 11
          dRec.Top = 5
          dRec.Right = 75
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj37: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Tel:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 76
          dRec.Top = 5
          dRec.Right = 80
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj38: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 81
          dRec.Top = 5
          dRec.Right = 91
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj39: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 75
          dRec.Top = 5
          dRec.Right = 76
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj40: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 91
          dRec.Top = 5
          dRec.Right = 92
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj41: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'AUTORI:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 2
          dRec.Top = 7
          dRec.Right = 10
          dRec.Bottom = 8
          Visible = False
        end
        object prTxMemoObj42: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 11
          dRec.Top = 7
          dRec.Right = 75
          dRec.Bottom = 8
          Visible = False
        end
        object prTxMemoObj43: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 75
          dRec.Top = 7
          dRec.Right = 76
          dRec.Bottom = 8
          Visible = False
        end
        object prTxMemoObj44: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Tel:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 76
          dRec.Top = 7
          dRec.Right = 80
          dRec.Bottom = 8
          Visible = False
        end
        object prTxMemoObj45: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 81
          dRec.Top = 7
          dRec.Right = 91
          dRec.Bottom = 8
          Visible = False
        end
        object prTxMemoObj46: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 91
          dRec.Top = 7
          dRec.Right = 92
          dRec.Bottom = 8
          Visible = False
        end
      end
    end
  end
  object FormularioN: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbExit]
    StoreInDFM = True
    RebuildPrinter = False
    OnGetValue = FormularioNGetValue
    Left = 164
    Top = 184
    ReportForm = {
      190000006C53000019FFFFFFFF23005C5C53495354454D415330335C68702064
      65736B6A657420333432302073657269657300FFFFFFFFFF050000006F080000
      E40D00004800000000000000000000000000000000FFFF00000000FFFF000000
      000000000000000000030400466F726D000F000080DC000000780000007C0100
      002C010000040000000200EC0000000B00506167654865616465723100020100
      000000100000000B030000CC0000003000020001000000000000000000FFFFFF
      1F00000000000000000000000000FFFF00000000000200000001000000000000
      0001000000C800000014000000010000000000000200590100000D004D617374
      65724865616465723100020100000000E10000000B0300001800000070000400
      01000000000000000000FFFFFF1F00000000000000000000000000FFFF000000
      000002000000010000000000000001000000C800000014000000010000000000
      000200D10100000B004D6173746572446174613100020100000000FD0000000B
      0300007C0000003000050001000000000000000000FFFFFF1F000000000D0066
      724942546974756C6172657300000000000000FFFF0000000000020000000100
      00000000000001000000C800000014000000010000000000000200490200000B
      004D6173746572446174613200020100000000980100000B0300009000000030
      00050001000000000000000000FFFFFF1F000000000D0066724942546974756C
      6172657300000000000000FFFF00000000000200000001000000000000000100
      0000C800000014000000010000000000000200C30200000B004D617374657244
      6174613300020100000000470200000B03000020000000300005000100000000
      0000000000FFFFFF1F000000000F00667249425265666572656E636961730000
      0000000000FFFF000000000002000000010000000000000001000000C8000000
      14000000010000000000000200310300000E005265706F727453756D6D617279
      31000201000000000B0300000B030000E4000000300001000100000000000000
      0000FFFFFF1F00000000000000000000000000FFFF0000000000020000000100
      00000000000001000000C8000000140000000100000000000002009E0300000D
      004D617374657248656164657232000201000000002F0200000B030000140000
      007000040001000000000000000000FFFFFF1F00000000000000000000000000
      FFFF000000000002000000010000000000000001000000C80000001400000001
      00000000000002000B0400000D004D6173746572486561646572330002010000
      00007C0100000B030000140000003000040001000000000000000000FFFFFF1F
      00000000000000000000000000FFFF0000000000020000000100000000000000
      01000000C800000014000000010000000000000200780400000D004D61737465
      724865616465723400020100000000700200000B030000140000003000040001
      000000000000000000FFFFFF1F00000000000000000000000000FFFF00000000
      0002000000010000000000000001000000C80000001400000001000000000000
      0200F30400000B004D6173746572446174613400020100000000940200000B03
      0000140000003000050001000000000000000000FFFFFF1F0000000010006672
      444242656E65666963696172696F00000000000000FFFF000000000002000000
      010000000000000001000000C800000014000000010000000000000200600500
      000D004D61737465724865616465723500020100000000B40200000B03000014
      0000003000040001000000000000000000FFFFFF1F0000000000000000000000
      0000FFFF000000000002000000010000000000000001000000C8000000140000
      00010000000000000200D60500000B004D617374657244617461350002010000
      0000CC0200000B030000140000003000050001000000000000000000FFFFFF1F
      000000000B0066724442617578696C696F00000000000000FFFF000000000002
      000000010000000000000001000000C800000014000000010000000000000000
      8706000005004D656D6F31000200900100001D000000F0000000340000000300
      000001000000000000000000FFFFFF1F2E02000000000003001600464F524D55
      4C4152494F2044452041504552545552410D0100590D160041435455414C495A
      4143494F4E204445204441544F5300000000FFFF000000000002000000010000
      00000500417269616C000C0000000200000000000A0000000100020000000000
      FFFFFF00000000020000000000000000002107000005004D656D6F32000200B0
      0200001A00000044000000140000000300000001000000000000000000FFFFFF
      1F2E02000000000001001C00486F6A61205B50414745235D206465205B544F54
      414C50414745535D00000000FFFF000000000002000000010000000005004172
      69616C00080000000200000000000A0000000100020000000000FFFFFF000000
      0002000000000000000000AA07000005004D656D6F3300020038010000600000
      003C000000100000000300000001000000000000000000FFFFFF1F2E02000000
      000001000B004375656E7461204E6F2E3A00000000FFFF000000000002000000
      01000000000500417269616C0008000000000000000000080000000100020000
      000000FFFFFF00000000020000000000000000003008000005004D656D6F3400
      020076010000600000004E000000100000000300000001000000000000000000
      FFFFFF1F2C000000000000010008005B4355454E54415D00000000FFFF000000
      00000200000001000000000500417269616C0008000000020000000000090000
      000100020000000000FFFFFF0000000002000000000000000000BD0800000500
      4D656D6F35000200C50100006000000056000000100000000300000001000000
      000000000000FFFFFF1F2E02000000000001000F004665636861204170657274
      7572613A00000000FFFF00000000000200000001000000000500417269616C00
      08000000000000000000090000000100020000000000FFFFFF00000000020000
      000000000000005409000005004D656D6F360002001C02000060000000480000
      00100000000300000001000000000000000000FFFFFF1F2C0004020A00797979
      792F6D6D2F64640001000F005B464543484141504552545552415D00000000FF
      FF00000000000200000001000000000500417269616C00080000000200000000
      00080000000100020000000000FFFFFF0000000002000000000000000000D909
      000005004D656D6F370002006602000060000000280000001000000003000000
      01000000000000000000FFFFFF1F2E020000000000010007004369756461643A
      00000000FFFF00000000000200000001000000000500417269616C0008000000
      000000000000080000000100020000000000FFFFFF0000000002000000000000
      000000690A000005004D656D6F38000200BE0200002F00000030000000100000
      000300000001000000000000000000FFFFFF1F2C0004020A00797979792F6D6D
      2F64640001000800496D707265736F3A00000000FFFF00000000000200000001
      000000000500417269616C000800000000000000000008000000010002000000
      0000FFFFFF0000000002000000000000000000F70A000005004D656D6F390002
      00B70200003D0000003C000000100000000300000001000000000000000000FF
      FFFF1F2C0004020A00797979792F6D6D2F646400010006005B444154455D0000
      0000FFFF00000000000200000001000000000500417269616C00080000000200
      00000000020000000100020000000000FFFFFF00000000020000000000000000
      007E0B000006004D656D6F313000020090020000600000006700000010000000
      0300000001000000000000000000FFFFFF1F2C000000000000010008005B4349
      554441445D00000000FFFF00000000000200000001000000000500417269616C
      0009000000020000000000080000000100020000000000FFFFFF000000000200
      0000000000000000150C000006004D656D6F31310002003801000078000000A8
      000000140000000300000001000000000000000000FFFFFF1F2E020000000000
      01001800492E20434F4E444943494F4E4553204445204D414E454A4F00000000
      FFFF00000000000200000001000000000500417269616C000800000003000000
      0000080000000100020000000000FFFFFF0000000002000000000000000000A3
      0C000006004D656D6F3132000200430100009000000050000000100000000300
      000001000000000000000000FFFFFF1F2E02000000000001000F005469706F20
      6465204375656E74613A00000000FFFF00000000000200000001000000000500
      417269616C0008000000000000000000000000000100020000000000FFFFFF00
      000000020000000000000000002E0D000006004D656D6F313300020093010000
      9000000048000000100000000300000001000000000000000000FFFFFF1F2E02
      000000000001000C005B5449504F4355454E54415D00000000FFFF0000000000
      0200000001000000000500417269616C00080000000200000000000000000001
      00020000000000FFFFFF0000000002000000000000000000C70D000006004D65
      6D6F3134000200DE010000900000008400000010000000030000000100000000
      0000000000FFFFFF1F2E02000000000001001A0052657175697369746F733A20
      4E726F206465204669726D61733A00000000FFFF000000000002000000010000
      00000500417269616C0008000000000000000000000000000100020000000000
      FFFFFF0000000002000000000000000000500E000006004D656D6F3135000200
      620200009000000010000000100000000300000001000000000000000000FFFF
      FF1F2E0004010200303000010008005B4649524D41535D00000000FFFF000000
      00000200000001000000000500417269616C0008000000020000000000000000
      000100020000000000FFFFFF0000000002000000000000000000DD0E00000600
      4D656D6F31360002007602000090000000480000001000000003000000010000
      00000000000000FFFFFF1F2E02000000000001000E004E726F2064652053656C
      6C6F733A00000000FFFF00000000000200000001000000000500417269616C00
      08000000000000000000000000000100020000000000FFFFFF00000000020000
      00000000000000660F000006004D656D6F3137000200C2020000900000001300
      0000100000000300000001000000000000000000FFFFFF1F2E00040102003030
      00010008005B53454C4C4F535D00000000FFFF00000000000200000001000000
      000500417269616C0008000000020000000000000000000100020000000000FF
      FFFF0000000002000000000000000000F40F000006004D656D6F313800020043
      0100009E00000050000000100000000300000001000000000000000000FFFFFF
      1F2E02000000000001000F0050726F746563746F677261666F733A00000000FF
      FF00000000000200000001000000000500417269616C00080000000000000000
      00000000000100020000000000FFFFFF00000000020000000000000000008510
      000006004D656D6F3139000200940100009E0000001800000010000000030000
      0001000000000000000000FFFFFF1F2E0204010200303000010010005B50524F
      544543544F475241464F535D00000000FFFF0000000000020000000100000000
      0500417269616C0008000000020000000000000000000100020000000000FFFF
      FF00000000020000000000000000001811000006004D656D6F32310002006000
      0000FF0000006C000000100000000300000001000000000000000000FFFFFF1F
      2E020000000000010014004E6F6D627265732079204170656C6C69646F733A00
      000000FFFF00000000000200000001000000000500417269616C000800000000
      0000000000000000000100020000000000FFFFFF000000000200000000000000
      0000F311000006004D656D6F3232000200D1000000FF000000D6010000100000
      000100000001000000000000000000FFFFFF1F2E02000000000001005C005B54
      52494D284942546974756C617265732E4E4F4D4252452B272027202B49425469
      74756C617265732E5052494D45525F4150454C4C49444F2B2720272B49425469
      74756C617265732E534547554E444F5F4150454C4C49444F295D00000000FFFF
      00000000000200000001000000000500417269616C000A000000020000000000
      000000000100020000000000FFFFFF0000000002000000000000000000851200
      0006004D656D6F3233000200600000000D010000590000001000000003000000
      01000000000000000000FFFFFF1F2E020000000000010013004964656E746966
      6963616369F36E204E6F2E3A00000000FFFF0000000000020000000100000000
      0500417269616C0008000000000000000000000000000100020000000000FFFF
      FF00000000020000000000000000004513000006004D656D6F3234000200BB00
      00000D01000060000000100000000300000001000000000000000000FFFFFF1F
      2E020000000000010041005B4942546974756C617265732E22494E494349414C
      5F4944454E54494649434143494F4E225D2D5B4942546974756C617265732E22
      49445F504552534F4E41225D00000000FFFF0000000000020000000100000000
      0500417269616C0008000000020000000000000000000100020000000000FFFF
      FF0000000002000000000000000000D113000006004D656D6F32350002001C01
      00000D01000044000000100000000300000001000000000000000000FFFFFF1F
      2E02000000000001000D00457870656469646F20656E3A2000000000FFFF0000
      0000000200000001000000000500417269616C00080000000000000000000000
      00000100020000000000FFFFFF00000000020000000000000000007014000006
      004D656D6F3236000200620100000D0100007500000010000000030000000100
      0000000000000000FFFFFF1F2E020000000000010020005B4942546974756C61
      7265732E224C554741525F45585045444943494F4E225D00000000FFFF000000
      00000200000001000000000500417269616C0008000000020000000000000000
      000100020000000000FFFFFF0000000002000000000000000000F91400000600
      4D656D6F3237000200D90100000D0100003C0000001000000003000000010000
      00000000000000FFFFFF1F2E02000000000001000A004665636861204578703A
      00000000FFFF00000000000200000001000000000500417269616C0008000000
      000000000000000000000100020000000000FFFFFF0000000002000000000000
      000000A215000006004D656D6F3238000200160200000D010000600000001000
      00000300000001000000000000000000FFFFFF1F2C0004020A00797979792F6D
      6D2F646400010020005B4942546974756C617265732E2246454348415F455850
      45444943494F4E225D00000000FFFF0000000000020000000100000000050041
      7269616C0008000000020000000000000000000100020000000000FFFFFF0000
      0000020000000000000000002616000006004D656D6F3239000200770200000D
      01000020000000100000000300000001000000000000000000FFFFFF1F2E0200
      00000000010005005365786F3A00000000FFFF00000000000200000001000000
      000500417269616C0008000000000000000000000000000100020000000000FF
      FFFF00000000020000000000000000000917000006004D656D6F333000020096
      0200000D01000061000000100000000300000001000000000000000000FFFFFF
      1F2E020000000000010064005B4946285B4942546974756C617265732E225345
      584F225D203D20274D272C20274D415343554C494E4F272C204946285B494254
      6974756C617265732E225345584F225D203D202746272C202746454D454E494E
      4F272C20274E494E47554E4F2729295D00000000FFFF00000000000200000001
      000000000500417269616C000800000002000000000000000000010002000000
      0000FFFFFF00000000020000000000000000009C17000006004D656D6F333100
      0200600000001C0100006C000000100000000300000001000000000000000000
      FFFFFF1F2E020000000000010014004665636861206465204E6163696D69656E
      746F3A00000000FFFF00000000000200000001000000000500417269616C0008
      000000000000000000000000000100020000000000FFFFFF0000000002000000
      0000000000004518000006004D656D6F3332000200CB0000001C010000500000
      00100000000300000001000000000000000000FFFFFF1F2C0004020A00797979
      792F6D6D2F646400010020005B4942546974756C617265732E2246454348415F
      4E4143494D49454E544F225D00000000FFFF0000000000020000000100000000
      0500417269616C0008000000020000000000000000000100020000000000FFFF
      FF0000000002000000000000000000D818000006004D656D6F33330002001B01
      00001C0100006C000000100000000300000001000000000000000000FFFFFF1F
      2E020000000000010014004C75676172206465204E6163696D69656E746F3A00
      000000FFFF00000000000200000001000000000500417269616C000800000000
      0000000000000000000100020000000000FFFFFF000000000200000000000000
      00006419000006004D656D6F3334000200580200001C01000040000000100000
      000300000001000000000000000000FFFFFF1F2E02000000000001000D004573
      7461646F20436976696C3A00000000FFFF000000000002000000010000000005
      00417269616C0008000000000000000000000000000100020000000000FFFFFF
      00000000020000000000000000000B1A000006004D656D6F3335000200980200
      001C01000060000000100000000300000001000000000000000000FFFFFF1F2E
      020000000000010028005B4942546974756C617265732E224445534352495043
      494F4E5F45535441444F5F434956494C225D00000000FFFF0000000000020000
      0001000000000500417269616C00080000000200000000000000000001000200
      00000000FFFFFF0000000002000000000000000000AA1A000006004D656D6F33
      36000200880100001C010000CE00000010000000030000000100000000000000
      0000FFFFFF1F2E020000000000010020005B4942546974756C617265732E224C
      554741525F4E4143494D49454E544F225D00000000FFFF000000000002000000
      01000000000500417269616C0008000000020000000000000000000100020000
      000000FFFFFF00000000020000000000000000003E1B000006004D656D6F3337
      000200600000002B0100006C0000001000000003000000010000000000000000
      00FFFFFF1F2E0200000000000100150044697265636369F36E20526573696465
      6E6369613A00000000FFFF00000000000200000001000000000500417269616C
      0008000000000000000000000000000100020000000000FFFFFF000000000200
      0000000000000000E71B000006004D656D6F3338000200CC0000002B01000010
      010000100000000300000001000000000000000000FFFFFF1F2E020000000000
      01002A005B49424469725265732E22444952454343494F4E225D205B49424469
      725265732E2242415252494F225D00000000FFFF000000000002000000010000
      00000500417269616C0008000000020000000000000000000100020000000000
      FFFFFF0000000002000000000000000000701C000006004D656D6F3339000200
      DC0100002B01000034000000100000000300000001000000000000000000FFFF
      FF1F2E02000000000001000A004D756E69636970696F3A00000000FFFF000000
      00000200000001000000000500417269616C0008000000000000000000000000
      000100020000000000FFFFFF0000000002000000000000000000051D00000600
      4D656D6F3430000200100200002B010000640000001000000003000000010000
      00000000000000FFFFFF1F2E020000000000010016005B49424469725265732E
      224D554E49434950494F225D00000000FFFF0000000000020000000100000000
      0500417269616C0008000000020000000000000000000100020000000000FFFF
      FF00000000020000000000000000008D1D000006004D656D6F34310002007302
      00002B01000034000000100000000300000001000000000000000000FFFFFF1F
      2E0200000000000100090054656CE9666F6E6F3A00000000FFFF000000000002
      00000001000000000500417269616C0008000000000000000000000000000100
      020000000000FFFFFF0000000002000000000000000000221E000006004D656D
      6F3432000200A80200002B010000500000001000000003000000010000000000
      00000000FFFFFF1F2E020000000000010016005B49424469725265732E225445
      4C45464F4E4F31225D00000000FFFF0000000000020000000100000000050041
      7269616C0008000000020000000000000000000100020000000000FFFFFF0000
      000002000000000000000000BB1E000006004D656D6F3433000200600000003A
      0100008B000000100000000300000001000000000000000000FFFFFF1F2E0200
      0000000001001A0044697265636369F36E20436F72726573706F6E64656E6369
      613A00000000FFFF00000000000200000001000000000500417269616C000800
      0000000000000000000000000100020000000000FFFFFF000000000200000000
      0000000000641F000006004D656D6F3434000200ED0000003A010000EE000000
      100000000300000001000000000000000000FFFFFF1F2E02000000000001002A
      005B4942446972436F722E22444952454343494F4E225D205B4942446972436F
      722E2242415252494F225D00000000FFFF000000000002000000010000000005
      00417269616C0008000000020000000000000000000100020000000000FFFFFF
      0000000002000000000000000000ED1F000006004D656D6F3435000200DC0100
      003A01000034000000100000000300000001000000000000000000FFFFFF1F2E
      02000000000001000A004D756E69636970696F3A00000000FFFF000000000002
      00000001000000000500417269616C0008000000000000000000000000000100
      020000000000FFFFFF00000000020000000000000000008220000006004D656D
      6F3436000200100200003A010000640000001000000003000000010000000000
      00000000FFFFFF1F2E020000000000010016005B4942446972436F722E224D55
      4E49434950494F225D00000000FFFF0000000000020000000100000000050041
      7269616C0008000000020000000000000000000100020000000000FFFFFF0000
      0000020000000000000000000A21000006004D656D6F3437000200730200003A
      01000034000000100000000300000001000000000000000000FFFFFF1F2E0200
      000000000100090054656CE9666F6E6F3A00000000FFFF000000000002000000
      01000000000500417269616C0008000000000000000000000000000100020000
      000000FFFFFF00000000020000000000000000009F21000006004D656D6F3438
      000200A80200003A010000500000001000000003000000010000000000000000
      00FFFFFF1F2E020000000000010016005B4942446972436F722E2254454C4546
      4F4E4F31225D00000000FFFF0000000000020000000100000000050041726961
      6C0008000000020000000000000000000100020000000000FFFFFF0000000002
      0000000000000000003222000006004D656D6F34390002006000000049010000
      6C000000100000000300000001000000000000000000FFFFFF1F2E0200000000
      00010014004163746976696461642045636F6EF36D6963613A00000000FFFF00
      000000000200000001000000000500417269616C000800000000000000000000
      0000000100020000000000FFFFFF0000000002000000000000000000CA220000
      06004D656D6F3530000200CC0000004901000010010000100000000300000001
      000000000000000000FFFFFF1F2E020000000000010019005B4942546974756C
      617265732E2250524F464553494F4E225D00000000FFFF000000000002000000
      01000000000500417269616C0008000000020000000000000000000100020000
      000000FFFFFF00000000020000000000000000005523000006004D656D6F3531
      000200DC01000049010000400000001000000003000000010000000000000000
      00FFFFFF1F2E02000000000001000C00446573637269706369F36E3A00000000
      FFFF00000000000200000001000000000500417269616C000800000000000000
      0000000000000100020000000000FFFFFF0000000002000000000000000000F0
      23000006004D656D6F35320002001A02000049010000DC000000100000000300
      000001000000000000000000FFFFFF1F2E02000000000001001C005B49425469
      74756C617265732E22434152474F5F41435455414C225D00000000FFFF000000
      00000200000001000000000500417269616C0008000000020000000000000000
      000100020000000000FFFFFF0000000002000000000000000000842400000600
      4D656D6F35330002006000000057010000740000001000000003000000010000
      00000000000000FFFFFF1F2E02000000000001001500456D707265736120646F
      6E6465206C61626F72613A00000000FFFF000000000002000000010000000005
      00417269616C0008000000000000000000000000000100020000000000FFFFFF
      00000000020000000000000000002125000006004D656D6F3534000200D40000
      005701000085000000100000000300000001000000000000000000FFFFFF1F2E
      02000000000001001E005B4942546974756C617265732E22454D50524553415F
      4C41424F5241225D00000000FFFF000000000002000000010000000005004172
      69616C0008000000020000000000000000000100020000000000FFFFFF000000
      0002000000000000000000AA25000006004D656D6F35350002005A0100005701
      000034000000100000000300000001000000000000000000FFFFFF1F2E020000
      00000001000A0044697265636369F36E3A00000000FFFF000000000002000000
      01000000000500417269616C0008000000000000000000000000000100020000
      000000FFFFFF00000000020000000000000000003F26000006004D656D6F3536
      0002008D01000057010000780000001000000003000000010000000000000000
      00FFFFFF1F2E020000000000010016005B4942446972456D702E224449524543
      43494F4E225D00000000FFFF0000000000020000000100000000050041726961
      6C0008000000020000000000000000000100020000000000FFFFFF0000000002
      000000000000000000C826000006004D656D6F35370002000602000057010000
      34000000100000000300000001000000000000000000FFFFFF1F2E0200000000
      0001000A004D756E69636970696F3A00000000FFFF0000000000020000000100
      0000000500417269616C00080000000000000000000000000001000200000000
      00FFFFFF00000000020000000000000000005D27000006004D656D6F35380002
      00390200005701000050000000100000000300000001000000000000000000FF
      FFFF1F2E020000000000010016005B4942446972456D702E224D554E49434950
      494F225D00000000FFFF00000000000200000001000000000500417269616C00
      08000000020000000000000000000100020000000000FFFFFF00000000020000
      00000000000000E527000006004D656D6F35390002008A020000570100003100
      0000100000000300000001000000000000000000FFFFFF1F2E02000000000001
      00090054656CE9666F6E6F3A00000000FFFF0000000000020000000100000000
      0500417269616C0008000000000000000000000000000100020000000000FFFF
      FF00000000020000000000000000007A28000006004D656D6F3630000200BC02
      0000570100003C000000100000000300000001000000000000000000FFFFFF1F
      2E020000000000010016005B4942446972456D702E2254454C45464F4E4F3122
      5D00000000FFFF00000000000200000001000000000500417269616C00080000
      00020000000000000000000100020000000000FFFFFF00000000020000000000
      000000001529000006004D656D6F363100020060000000650100009800000010
      0000000300000001000000000000000000FFFFFF1F2E02000000000001001C00
      4E6F6D627265732079204170656C6C69646F7320436F6E797567653A00000000
      FFFF00000000000200000001000000000500417269616C000800000000000000
      0000000000000100020000000000FFFFFF000000000200000000000000000014
      2A000006004D656D6F3632000200F80000006501000000020000100000000300
      000001000000000000000000FFFFFF1F2E020000000000010080005B7472696D
      285B4942546974756C617265732E224E4F4D4252455F434F4E59554745225D2B
      2720272B5B4942546974756C617265732E225052494D45525F4150454C4C4944
      4F5F434F4E59554745225D2B2720272B205B4942546974756C617265732E2253
      4547554E444F5F4150454C4C49444F5F434F4E59554745225D295D00000000FF
      FF00000000000200000001000000000500417269616C00090000000200000000
      00000000000100020000000000FFFFFF0000000002000000000000000000AE2A
      000006004D656D6F363500020061000000A9010000980200001D0000000B0000
      0001000000000000000000FFFFFF1F2E02000000000001001B005B4942546974
      756C617265732E224445434C41524143494F4E225D00000000FFFF0000000000
      0200000001000000000500417269616C00080000000200000000000000000001
      00020000000000FFFFFF0000000002000000000000000000592B000006004D65
      6D6F3636000200AA000000C70100006000000010000000030000000100000000
      0000000000FFFFFF1F2E02040108002420232C232E303000010024005B494254
      6974756C617265732E22494E475245534F535F415F5052494E434950414C225D
      00000000FFFF00000000000200000001000000000500417269616C0008000000
      020000000000010000000100020000000000FFFFFF0000000002000000000000
      000000E52B000006004D656D6F363700020061000000C7010000480000001000
      00000300000001000000000000000000FFFFFF1F2E02000000000001000D0049
      6E677265736F73204D65733A00000000FFFF0000000000020000000100000000
      0500417269616C0008000000000000000000000000000100020000000000FFFF
      FF0000000002000000000000000000732C000006004D656D6F36380002000A01
      0000C701000050000000100000000300000001000000000000000000FFFFFF1F
      2E02000000000001000F00496E677265736F73204F74726F733A00000000FFFF
      00000000000200000001000000000500417269616C0008000000000000000000
      000000000100020000000000FFFFFF0000000002000000000000000000182D00
      0006004D656D6F36390002005C010000C7010000600000001000000003000000
      01000000000000000000FFFFFF1F2E02040108002420232C232E30300001001E
      005B4942546974756C617265732E22494E475245534F535F4F54524F53225D00
      000000FFFF00000000000200000001000000000500417269616C000800000002
      0000000000010000000100020000000000FFFFFF000000000200000000000000
      0000A32D000006004D656D6F3730000200BC010000C701000040000000100000
      000300000001000000000000000000FFFFFF1F2E02000000000001000C004465
      73637269706369F36E3A00000000FFFF00000000000200000001000000000500
      417269616C0008000000000000000000000000000100020000000000FFFFFF00
      00000002000000000000000000412E000006004D656D6F3731000200FC010000
      C7010000FD000000100000000300000001000000000000000000FFFFFF1F2E02
      000000000001001F005B4942546974756C617265732E22444553435F494E4752
      5F4F54524F53225D00000000FFFF000000000002000000010000000005004172
      69616C0008000000020000000000000000000100020000000000FFFFFF000000
      0002000000000000000000D12E000006004D656D6F373200020061000000D701
      000060000000100000000300000001000000000000000000FFFFFF1F2E020000
      00000001001100496E677265736F7320436F6E797567653A00000000FFFF0000
      0000000200000001000000000500417269616C00080000000000000000000000
      00000100020000000000FFFFFF0000000002000000000000000000782F000006
      004D656D6F3733000200C0000000D70100006000000010000000030000000100
      0000000000000000FFFFFF1F2E02040108002420232C232E303000010020005B
      4942546974756C617265732E22494E475245534F535F434F4E59554745225D00
      000000FFFF00000000000200000001000000000500417269616C000800000002
      0000000000010000000100020000000000FFFFFF000000000200000000000000
      00000E30000006004D656D6F373400020020010000D701000080000000100000
      000300000001000000000000000000FFFFFF1F2E02000000000001001700496E
      677265736F73204F74726F7320436F6E797567653A00000000FFFF0000000000
      0200000001000000000500417269616C00080000000000000000000000000001
      00020000000000FFFFFF0000000002000000000000000000BB30000006004D65
      6D6F3735000200A0010000D70100006000000010000000030000000100000000
      0000000000FFFFFF1F2E02040108002420232C232E303000010026005B494254
      6974756C617265732E22494E475245534F535F434F4E595547455F4F54524F53
      225D00000000FFFF00000000000200000001000000000500417269616C000800
      0000020000000000010000000100020000000000FFFFFF000000000200000000
      00000000004B31000006004D656D6F373600020060000000E701000060000000
      100000000300000001000000000000000000FFFFFF1F2E020000000000010011
      0045677265736F732041727269656E646F3A00000000FFFF0000000000020000
      0001000000000500417269616C00080000000000000000000000000001000200
      00000000FFFFFF0000000002000000000000000000F231000006004D656D6F37
      37000200C0000000E70100006000000010000000030000000100000000000000
      0000FFFFFF1F2E02040108002420232C232E303000010020005B494254697475
      6C617265732E2245475245534F535F414C5155494C4552225D00000000FFFF00
      000000000200000001000000000500417269616C000800000002000000000001
      0000000100020000000000FFFFFF000000000200000000000000000086320000
      06004D656D6F373800020020010000E701000070000000100000000300000001
      000000000000000000FFFFFF1F2E0200000000000100150045677265736F7320
      416C696D656E74616369F36E3A00000000FFFF00000000000200000001000000
      000500417269616C0008000000000000000000000000000100020000000000FF
      FFFF00000000020000000000000000003133000006004D656D6F3739000200A1
      010000E701000060000000100000000300000001000000000000000000FFFFFF
      1F2E02040108002420232C232E303000010024005B4942546974756C61726573
      2E2245475245534F535F414C494D454E544143494F4E225D00000000FFFF0000
      0000000200000001000000000500417269616C00080000000200000000000100
      00000100020000000000FFFFFF0000000002000000000000000000C333000006
      004D656D6F383000020001020000E70100006A00000010000000030000000100
      0000000000000000FFFFFF1F2E0200000000000100130045677265736F732054
      72616E73706F7274653A00000000FFFF00000000000200000001000000000500
      417269616C0008000000000000000000000000000100020000000000FFFFFF00
      000000020000000000000000006C34000006004D656D6F383100020069020000
      E701000060000000100000000300000001000000000000000000FFFFFF1F2E02
      040108002420232C232E303000010022005B4942546974756C617265732E2245
      475245534F535F5452414E53504F525445225D00000000FFFF00000000000200
      000001000000000500417269616C000800000002000000000001000000010002
      0000000000FFFFFF0000000002000000000000000000FD34000006004D656D6F
      383200020060000000F701000060000000100000000300000001000000000000
      000000FFFFFF1F2E0200000000000100120045677265736F7320536572766963
      696F733A00000000FFFF00000000000200000001000000000500417269616C00
      08000000000000000000000000000100020000000000FFFFFF00000000020000
      00000000000000A535000006004D656D6F3833000200C0000000F70100006000
      0000100000000300000001000000000000000000FFFFFF1F2E02040108002420
      232C232E303000010021005B4942546974756C617265732E2245475245534F53
      5F534552564943494F53225D00000000FFFF0000000000020000000100000000
      0500417269616C0008000000020000000000010000000100020000000000FFFF
      FF00000000020000000000000000003236000006004D656D6F38340002002001
      0000F701000070000000100000000300000001000000000000000000FFFFFF1F
      2E02000000000001000E0045677265736F73204F74726F733A00000000FFFF00
      000000000200000001000000000500417269616C000800000000000000000000
      0000000100020000000000FFFFFF0000000002000000000000000000D6360000
      06004D656D6F3835000200A0010000F701000060000000100000000300000001
      000000000000000000FFFFFF1F2E02040108002420232C232E30300001001D00
      5B4942546974756C617265732E2245475245534F535F4F54524F53225D000000
      00FFFF00000000000200000001000000000500417269616C0008000000020000
      000000010000000100020000000000FFFFFF0000000002000000000000000000
      6537000006004D656D6F38360002006000000007020000600000001000000003
      00000001000000000000000000FFFFFF1F2E0200000000000100100045677265
      736F7320436F6E797567653A00000000FFFF0000000000020000000100000000
      0500417269616C0008000000000000000000000000000100020000000000FFFF
      FF00000000020000000000000000000B38000006004D656D6F3837000200C000
      00000702000060000000100000000300000001000000000000000000FFFFFF1F
      2E02040108002420232C232E30300001001F005B4942546974756C617265732E
      2245475245534F535F434F4E59554745225D00000000FFFF0000000000020000
      0001000000000500417269616C00080000000200000000000100000001000200
      00000000FFFFFF0000000002000000000000000000A038000006004D656D6F38
      3800020021010000070200007C00000010000000030000000100000000000000
      0000FFFFFF1F2E0200000000000100160045677265736F73204F74726F732043
      6F6E797567653A00000000FFFF00000000000200000001000000000500417269
      616C0008000000000000000000000000000100020000000000FFFFFF00000000
      020000000000000000004C39000006004D656D6F3839000200A0010000070200
      0060000000100000000300000001000000000000000000FFFFFF1F2E02040108
      002420232C232E303000010025005B4942546974756C617265732E224F54524F
      535F45475245534F535F434F4E59554745225D00000000FFFF00000000000200
      000001000000000500417269616C000800000002000000000001000000010002
      0000000000FFFFFF0000000002000000000000000000D939000006004D656D6F
      3930000200600000001702000060000000100000000300000001000000000000
      000000FFFFFF1F2E02000000000001000E00546F74616C2041637469766F733A
      00000000FFFF00000000000200000001000000000500417269616C0008000000
      000000000000000000000100020000000000FFFFFF0000000002000000000000
      0000007D3A000006004D656D6F3931000200C000000017020000600000001000
      00000300000001000000000000000000FFFFFF1F2E02040108002420232C232E
      30300001001D005B4942546974756C617265732E22544F54414C5F4143544956
      4F53225D00000000FFFF00000000000200000001000000000500417269616C00
      08000000020000000000010000000100020000000000FFFFFF00000000020000
      000000000000000A3B000006004D656D6F393200020020010000170200006000
      0000100000000300000001000000000000000000FFFFFF1F2E02000000000001
      000E00546F74616C2050617369766F733A00000000FFFF000000000002000000
      01000000000500417269616C0008000000000000000000000000000100020000
      000000FFFFFF0000000002000000000000000000AE3B000006004D656D6F3933
      0002008001000017020000800000001000000003000000010000000000000000
      00FFFFFF1F2E02040108002420232C232E30300001001D005B4942546974756C
      617265732E22544F54414C5F50415349564F53225D00000000FFFF0000000000
      0200000001000000000500417269616C00080000000200000000000100000001
      00020000000000FFFFFF0000000002000000000000000000BD3C000006004D65
      6D6F39350002006000000049020000E800000010000000030000000100000000
      0000000000FFFFFF1F2E020000000000010090005B5B5452494D285B49425265
      666572656E636961732E224E4F4D4252455F5245464552454E434941225D2B27
      20272B5B49425265666572656E636961732E225052494D45525F4150454C4C49
      444F5F5245464552454E434941225D2B2720272B5B49425265666572656E6369
      61732E22534547554E444F5F4150454C4C49444F5F5245464552454E43494122
      5D295D5D00000000FFFF00000000000200000001000000000500417269616C00
      08000000020000000000000000000100020000000000FFFFFF00000000020000
      000000000000004F3D000006004D656D6F39360002004A010000490200006400
      0000100000000300000001000000000000000000FFFFFF1F2E02000000000001
      0013005469706F206465205265666572656E6369613A00000000FFFF00000000
      000200000001000000000500417269616C000800000000000000000000000000
      0100020000000000FFFFFF0000000002000000000000000000F63D000006004D
      656D6F3937000200B0010000490200007A000000100000000300000001000000
      000000000000FFFFFF1F2E020000000000010028005B49425265666572656E63
      6961732E224445534352495043494F4E5F5245464552454E434941225D000000
      00FFFF00000000000200000001000000000500417269616C0008000000020000
      000000000000000100020000000000FFFFFF0000000002000000000000000000
      803E000006004D656D6F39380002002C02000049020000400000001000000003
      00000001000000000000000000FFFFFF1F2E02000000000001000B0050617265
      6E746573636F3A00000000FFFF00000000000200000001000000000500417269
      616C0008000000000000000000000000000100020000000000FFFFFF00000000
      02000000000000000000273F000006004D656D6F39390002006C020000490200
      008C000000100000000300000001000000000000000000FFFFFF1F2E02000000
      0000010028005B49425265666572656E636961732E224445534352495043494F
      4E5F504152454E544553434F225D00000000FFFF000000000002000000010000
      00000500417269616C0008000000020000000000000000000100020000000000
      FFFFFF0000000002000000000000000000B13F000007004D656D6F3130300002
      00600000005602000038000000100000000300000001000000000000000000FF
      FFFF1F2E02000000000001000A0044697265636369F36E3A00000000FFFF0000
      0000000200000001000000000500417269616C00080000000000000000000000
      00000100020000000000FFFFFF00000000020000000000000000005740000007
      004D656D6F313031000200980000005602000093010000100000000300000001
      000000000000000000FFFFFF1F2E020000000000010026005B49425265666572
      656E636961732E22444952454343494F4E5F5245464552454E434941225D0000
      0000FFFF00000000000200000001000000000500417269616C00080000000200
      00000000000000000100020000000000FFFFFF00000000020000000000000000
      00FC40000007004D656D6F3130320002006C020000560200008C000000100000
      000300000001000000000000000000FFFFFF1F2E020000000000010025005B49
      425265666572656E636961732E2254454C45464F4E4F5F5245464552454E4349
      41225D00000000FFFF00000000000200000001000000000500417269616C0008
      000000020000000000000000000100020000000000FFFFFF0000000002000000
      0000000000008541000007004D656D6F3130330002002C020000560200004000
      0000100000000300000001000000000000000000FFFFFF1F2E02000000000001
      00090054656CE9666F6E6F3A00000000FFFF0000000000020000000100000000
      0500417269616C0008000000000000000000000000000100020000000000FFFF
      FF00000000020000000000000000005F43000007004D656D6F31303400020048
      00000013030000B2020000280000000300000001000000000000000000FFFFFF
      1F2E02000000000001005A014465636C61726F28616D6F73292071756520636F
      6E6F63656D6F732079206163657074616D6F73206C617320636F6E646963696F
      6E6573206465206D616E656A6F2064652065737461206D6F64616C6964616420
      64652061686F72726F2E204175746F72697A616D6F732061205B454D50524553
      415D20706172613A206129205265706F72746172206F20636F6E73756C746172
      206375616C717569657220696E666F726D616369F36E2072656C6163696F6E61
      646120636F6E206D6973286E7565737472617329206163746976696461646573
      2066696E616E63696572617320656E206C61732063656E7472616C6573206465
      2072696573676F2E2062292051756520656E206361736F206465206D75657274
      652C20656C2076616C6F72206465206C6F732061706F7274657320736F636961
      6C65732073656120656E7472656761646F2061206D69732062656E6566696369
      6172696F732E00000000FFFF0000000000020000000100000000050041726961
      6C0008000000000000000000000000000100020000000000FFFFFF0000000002
      000000000000000400AE43000005004C696E6532000200480000003F030000B2
      020000000000000100080002000000000000000000FFFFFF002E020000000000
      000000000000FFFF000000000002000000010000000000003344000007004D65
      6D6F31303500020098000000B303000060000000100000000300000001000000
      000000000000FFFFFF1F2E020000000000010005004669726D6100000000FFFF
      00000000000200000001000000000500417269616C0008000000000000000000
      020000000100020000000000FFFFFF0000000002000000000000000400824400
      0005004C696E65330002004C000000B3030000F4000000000000000100080002
      000000000000000000FFFFFF002E020000000000000000000000FFFF00000000
      0002000000010000000000000745000007004D656D6F313036000200F0010000
      B303000060000000100000000300000001000000000000000000FFFFFF1F2E02
      0000000000010005004669726D6100000000FFFF000000000002000000010000
      00000500417269616C0008000000000000000000020000000100020000000000
      FFFFFF00000000020000000000000004005645000005004C696E6534000200A4
      010000B3030000F4000000000000000100080002000000000000000000FFFFFF
      002E020000000000000000000000FFFF00000000000200000001000000000A0C
      005466725368617065566965770000C745000006005368617065310002004101
      000043030000600000006C0000000100000002000000000000000000FFFFFF1F
      2E02000000000001000F004855454C4C412044414354494C415200000000FFFF
      0000000000020000000100000000010A0C005466725368617065566965770000
      3846000006005368617065320002009902000043030000600000006C00000001
      00000002000000000000000000FFFFFF1F2E02000000000001000F004855454C
      4C412044414354494C415200000000FFFF000000000002000000010000000001
      0000C346000007004D656D6F31303700020068000000E3030000680000000C00
      00000300000001000000000000000000FFFFFF1F2E02000000000001000B0046
      756E63696F6E6172696F00000000FFFF00000000000200000001000000000500
      417269616C0007000000000000000000020000000100020000000000FFFFFF00
      000000020000000000000000005047000007004D656D6F313038000200480000
      00D7030000AC0000000C0000000300000001000000000000000000FFFFFF1F2E
      02000000000001000D005B46554E43494F4E4152494F5D00000000FFFF000000
      00000200000001000000000500417269616C0007000000000000000000030000
      000100020000000000FFFFFF0000000002000000000000000000E24700000600
      4D656D6F323000020064000000E10000008C0000001400000003000000010000
      00000000000000FFFFFF1F2E02000000000001001300494E464F524D4143494F
      4E20544954554C415200000000FFFF0000000000020000000100000000050041
      7269616C0008000000030000000000020000000100020000000000FFFFFF0000
      0000020000000000000000007148000006004D656D6F3934000200480000002F
      02000068000000140000000300000001000000000000000000FFFFFF1F2E0200
      00000000010010004949492E205245464552454E4349415300000000FFFF0000
      0000000200000001000000000500417269616C00080000000300000000000000
      00000100020000000000FFFFFF0000000002000000000000000400C048000005
      004C696E65310002004800000011030000B20200000000000001000800020000
      00000000000000FFFFFF002E020000000000000000000000FFFF000000000002
      000000010000000000004F49000007004D656D6F313039000200480100004403
      000054000000100000000300000001000000000000000000FFFFFF1F2E020000
      00000001000F004855454C4C412044414354494C415200000000FFFF00000000
      000200000001000000000500417269616C000600000000000000000002000000
      0100020000000000FFFFFF0000000002000000000000000000DE49000007004D
      656D6F313130000200A002000044030000540000001000000003000000010000
      00000000000000FFFFFF1F2E02000000000001000F004855454C4C4120444143
      54494C415200000000FFFF00000000000200000001000000000500417269616C
      0006000000000000000000020000000100020000000000FFFFFF000000000200
      0000000000000000774A000006004D656D6F3633000200480000007C010000AC
      000000140000000300000001000000000000000000FFFFFF1F2E020000000000
      01001A0049492E20494E464F524D4143494F4E2046494E414E43494552410000
      0000FFFF00000000000200000001000000000500417269616C00080000000300
      00000000000000000100020000000000FFFFFF00000000020000000000000000
      00454B000006004D656D6F363400020061000000980100009C01000010000000
      0300000001000000000000000000FFFFFF1F2E02000000000001004F00446563
      6C61726F28616D6F732920717565206C6F7320666F6E646F73206D616E656A61
      646F7320656E2065737461206D6F64616C696461642064652061686F72726F20
      70726F7669656E656E20646500000000FFFF0000000000020000000100000000
      0500417269616C0008000000000000000000000000000100020000000000FFFF
      FF0000000002000000000000000000D64B000007004D656D6F31313100020049
      000000710200006C000000120000000300000001000000000000000000FFFFFF
      1F2E0200000000000100110049562E2042454E45464943494152494F53000000
      00FFFF00000000000200000001000000000500417269616C0008000000030000
      000000000000000100020000000000FFFFFF0000000002000000000000000000
      B64C000007004D656D6F3131320002006100000096020000E800000010000000
      0300000001000000000000000000FFFFFF1F2E020000000000010060005B4942
      62656E65666963696172696F2E224E4F4D425245225D205B494262656E656669
      63696172696F2E225052494D45525F4150454C4C49444F225D205B494262656E
      65666963696172696F2E22534547554E444F5F4150454C4C49444F225D000000
      00FFFF00000000000200000001000000000500417269616C0008000000020000
      000000000000000100020000000000FFFFFF0000000002000000000000000000
      414D000007004D656D6F3131330002004A010000960200004000000010000000
      0300000001000000000000000000FFFFFF1F2E02000000000001000B00506172
      656E746573636F3A00000000FFFF000000000002000000010000000005004172
      69616C0008000000000000000000000000000100020000000000FFFFFF000000
      0002000000000000000000EA4D000007004D656D6F3131340002008C01000096
      0200008C000000100000000300000001000000000000000000FFFFFF1F2E0200
      00000000010029005B494262656E65666963696172696F2E2244455343524950
      43494F4E5F504152454E544553434F225D00000000FFFF000000000002000000
      01000000000500417269616C0008000000020000000000000000000100020000
      000000FFFFFF0000000002000000000000000000884E000007004D656D6F3131
      350002002D020000960200003000000010000000030000000100000000000000
      0000FFFFFF1F2E02000000000001001E005B494262656E65666963696172696F
      2E22504F5243454E54414A45225D2500000000FFFF0000000000020000000100
      0000000500417269616C00080000000200000000000000000001000200000000
      00FFFFFF00000000020000000000000000002A4F000007004D656D6F31313700
      020049000000B5020000F8000000120000000300000001000000000000000000
      FFFFFF1F2E02000000000001002200562E2042454E45464943494152494F2041
      5558494C494F20504F52204D554552544500000000FFFF000000000002000000
      01000000000500417269616C0008000000030000000000000000000100020000
      000000FFFFFF0000000002000000000000000000FB4F000007004D656D6F3131
      3800020060000000CE020000E800000010000000030000000100000000000000
      0000FFFFFF1F2E020000000000010051005B4942417578696C696F2E224E4F4D
      425245225D205B4942417578696C696F2E225052494D45525F4150454C4C4944
      4F225D205B4942417578696C696F2E22534547554E444F5F4150454C4C49444F
      225D00000000FFFF00000000000200000001000000000500417269616C000800
      0000020000000000000000000100020000000000FFFFFF000000000200000000
      00000000008650000007004D656D6F31313900020049010000CE020000400000
      00100000000300000001000000000000000000FFFFFF1F2E0200000000000100
      0B00506172656E746573636F3A00000000FFFF00000000000200000001000000
      000500417269616C0008000000000000000000000000000100020000000000FF
      FFFF00000000020000000000000000002A51000007004D656D6F313230000200
      8B010000CE0200008C000000100000000300000001000000000000000000FFFF
      FF1F2E020000000000010024005B4942417578696C696F2E2244455343524950
      43494F4E5F504152454E544553434F225D00000000FFFF000000000002000000
      01000000000500417269616C0008000000020000000000000000000100020000
      000000FFFFFF0000000002000000000000000000B351000007004D656D6F3131
      36000200AB020000000100003800000010000000030000000100000000000000
      0000FFFFFF1F2E0200000000000100090045647563616369F36E00000000FFFF
      00000000000200000001000000000500417269616C0008000000000000000000
      000000000100020000000000FFFFFF0000000002000000000000000A0F005466
      72436865636B426F78566965770000355200000600436865636B31000200E702
      0000010100000C0000000C00000001000F0002000000000000000000FFFFFF1F
      2E020000000000010019005B4942546974756C617265732E2245445543414349
      4F4E225D00000000FFFF00000000000200000001000000000100000000FEFEFF
      0A0000000A002047656E6572616C65730000000006004355454E5441000F0027
      3230312D303032363330352D3827000D0046454348414150455254555241000A
      00323030342F30312F3031000600434955444144000700274F4341D14127000A
      005449504F4355454E5441000C0027496E646976696475616C27000600464952
      4D41530001003100060053454C4C4F5300010031000E0050524F544543544F47
      5241464F5300010031000700454D5052455341000000000B0046554E43494F4E
      4152494F000000000000000000000000FC00002F00464F524D554C4152494F20
      444520415045525455524120592041435455414C495A4143494F4E2044452044
      41544F530E00414C4558414E444552204352555A010031010031010030010030
      00005800E54F558615AAE24065FB417BD7E5E240}
  end
  object FormularioJ: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 192
    Top = 184
    ReportForm = {19000000}
  end
  object frIBTitulares: TfrDBDataSet
    DataSet = IBTitulares
    Left = 164
    Top = 210
  end
  object frIBReferencias: TfrDBDataSet
    DataSet = IBReferencias
    Left = 192
    Top = 210
  end
  object frShapeObject1: TfrShapeObject
    Left = 222
    Top = 184
  end
  object IBbeneficiario: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "gen$tiposparentesco".DESCRIPCION_PARENTESCO,'
      '  "gen$beneficiario".ID_AGENCIA,'
      '  "gen$beneficiario".ID_PERSONA,'
      '  "gen$beneficiario".ID_IDENTIFICACION,'
      '  "gen$beneficiario".PRIMER_APELLIDO,'
      '  "gen$beneficiario".SEGUNDO_APELLIDO,'
      '  "gen$beneficiario".NOMBRE,'
      '  "gen$beneficiario".ID_PARENTESCO,'
      '  "gen$beneficiario".AUXILIO,'
      '  "gen$beneficiario".PORCENTAJE'
      'FROM'
      '  "gen$beneficiario"'
      
        '  INNER JOIN "gen$tiposparentesco" ON ("gen$beneficiario".ID_PAR' +
        'ENTESCO = "gen$tiposparentesco".ID_PARENTESCO)'
      
        'where ID_IDENTIFICACION = :ID_IDENTIFICACION and ID_PERSONA = :I' +
        'D_PERSONA and AUXILIO = 0')
    Left = 272
    Top = 192
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
  object frDBBeneficiario: TfrDBDataSet
    DataSet = IBbeneficiario
    Left = 368
    Top = 224
  end
  object frDBauxilio: TfrDBDataSet
    DataSet = IBAuxilio
    Left = 328
    Top = 192
  end
  object IBAuxilio: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "gen$tiposparentesco".DESCRIPCION_PARENTESCO,'
      '  "gen$beneficiario".ID_AGENCIA,'
      '  "gen$beneficiario".ID_PERSONA,'
      '  "gen$beneficiario".ID_IDENTIFICACION,'
      '  "gen$beneficiario".PRIMER_APELLIDO,'
      '  "gen$beneficiario".SEGUNDO_APELLIDO,'
      '  "gen$beneficiario".NOMBRE,'
      '  "gen$beneficiario".ID_PARENTESCO,'
      '  "gen$beneficiario".AUXILIO,'
      '  "gen$beneficiario".PORCENTAJE'
      'FROM'
      '  "gen$beneficiario"'
      
        '  INNER JOIN "gen$tiposparentesco" ON ("gen$beneficiario".ID_PAR' +
        'ENTESCO = "gen$tiposparentesco".ID_PARENTESCO)'
      
        'where ID_IDENTIFICACION = :ID_IDENTIFICACION and ID_PERSONA = :I' +
        'D_PERSONA and AUXILIO = 1')
    Left = 264
    Top = 224
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
end
