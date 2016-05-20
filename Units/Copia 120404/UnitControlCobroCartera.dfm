object frmControlCobroCartera: TfrmControlCobroCartera
  Left = 10
  Top = 0
  Width = 790
  Height = 566
  Caption = 'Colocaciones - Control de Cobro'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 97
    Align = alTop
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 780
      Height = 92
      Align = alTop
      Caption = 'Condiciones de Busqueda'
      TabOrder = 0
      object RGEstado: TRadioGroup
        Left = 6
        Top = 14
        Width = 153
        Height = 73
        Caption = 'Estado'
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Todos'
          'Vigentes'
          'Prejuridicos'
          'Juridicos'
          'Castigados')
        TabOrder = 0
      end
      object GroupBox2: TGroupBox
        Left = 164
        Top = 14
        Width = 133
        Height = 73
        Caption = 'Morosidad'
        TabOrder = 1
        object Label1: TLabel
          Left = 10
          Top = 20
          Width = 37
          Height = 13
          Caption = 'Desde: '
        end
        object Label2: TLabel
          Left = 10
          Top = 44
          Width = 34
          Height = 13
          Caption = 'Hasta :'
        end
        object Label3: TLabel
          Left = 104
          Top = 20
          Width = 21
          Height = 13
          Caption = 'Dias'
        end
        object Label4: TLabel
          Left = 104
          Top = 42
          Width = 21
          Height = 13
          Caption = 'Dias'
        end
        object EdDiasIni: TJvIntegerEdit
          Left = 48
          Top = 16
          Width = 51
          Height = 21
          Alignment = taRightJustify
          ReadOnly = False
          TabOrder = 0
          Value = 0
          MaxValue = 0
          MinValue = 0
          HasMaxValue = False
          HasMinValue = False
        end
        object EdDiasFin: TJvIntegerEdit
          Left = 48
          Top = 40
          Width = 51
          Height = 21
          Alignment = taRightJustify
          ReadOnly = False
          TabOrder = 1
          Value = 0
          MaxValue = 0
          MinValue = 0
          HasMaxValue = False
          HasMinValue = False
        end
      end
      object CmdProcesar: TBitBtn
        Left = 304
        Top = 18
        Width = 81
        Height = 25
        Caption = '&Procesar'
        TabOrder = 2
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
      object CmdCerrar: TBitBtn
        Left = 304
        Top = 60
        Width = 81
        Height = 25
        Caption = '&Cerrar'
        TabOrder = 3
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
      object GroupBox5: TGroupBox
        Left = 400
        Top = 8
        Width = 253
        Height = 81
        Caption = 'Buscar Colocaci'#243'n'
        TabOrder = 4
        object Label5: TLabel
          Left = 4
          Top = 22
          Width = 39
          Height = 13
          Caption = 'Agencia'
        end
        object Label6: TLabel
          Left = 6
          Top = 52
          Width = 93
          Height = 13
          Caption = 'N'#250'mero Colocaci'#243'n'
        end
        object DBLCBAgencias: TDBLookupComboBox
          Left = 52
          Top = 20
          Width = 113
          Height = 21
          KeyField = 'ID_AGENCIA'
          ListField = 'DESCRIPCION_AGENCIA'
          ListSource = DataSource2
          TabOrder = 0
        end
        object EdNumeroColocacion: TEdit
          Left = 106
          Top = 48
          Width = 123
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnKeyPress = EdNumeroColocacionKeyPress
        end
        object CmdBuscar: TBitBtn
          Left = 172
          Top = 18
          Width = 75
          Height = 25
          Caption = '&Buscar'
          TabOrder = 2
          OnClick = CmdBuscarClick
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
      object GroupBox6: TGroupBox
        Left = 654
        Top = 8
        Width = 99
        Height = 81
        Caption = 'Compromisos'
        TabOrder = 5
        object CmdCompromisos: TBitBtn
          Left = 8
          Top = 48
          Width = 81
          Height = 25
          Caption = 'Del D'#237'a'
          TabOrder = 1
          OnClick = CmdCompromisosClick
          Glyph.Data = {
            36050000424D3605000000000000360400002800000010000000100000000100
            08000000000000010000230B0000230B00000001000000010000EF9C2100F7A5
            5A00636B6B00FFB56B008C8C8C009C9C9400A5A5A500ADADAD00B5B5B500527B
            C600DEDEDE00EFEFEF00F7F7F700FF00FF0039A5FF0000F7FF0094FFFF00FFFF
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
            FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000D0D0D0D0D0D
            0D0D0D0D0D0D0D0D0D0D0D02020202020202020202020202020D0D0411111111
            1111111111111111040D0D04110303030303030303030311040D0D0411031111
            0909110311110311040D0D05110311110F09090311110311050D0D0511030303
            0E0F090909030311050D0D0511011111010E100F09090111050D0D060C011109
            090909100F09090C060D0D060C00000E100F0F0F0F0F0909060D0D070B001111
            0E100F090911000B070D0D070B001111000E100F0909000B070D0D080A000000
            000E100F0F09090A080D0D080A0A0A0A0A0A0E100F0F0909080D0D0808080808
            0808080E100F0F09090D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D}
        end
        object EdFechaCompromiso: TDateTimePicker
          Left = 5
          Top = 20
          Width = 85
          Height = 21
          CalAlignment = dtaLeft
          Date = 37693.4262030903
          Format = 'yyyy/MM/dd'
          Time = 37693.4262030903
          DateFormat = dfShort
          DateMode = dmComboBox
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Kind = dtkDate
          ParseInput = False
          ParentFont = False
          TabOrder = 0
          OnExit = EdFechaCompromisoExit
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 97
    Width = 782
    Height = 186
    Align = alTop
    TabOrder = 1
    object GroupBox3: TGroupBox
      Left = 1
      Top = 1
      Width = 780
      Height = 184
      Align = alClient
      Caption = 'Resultado de la Busqueda'
      TabOrder = 0
      object GridColocaciones: TXStringGrid
        Left = 2
        Top = 15
        Width = 776
        Height = 167
        Align = alClient
        ColCount = 13
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
        TabOrder = 0
        OnSelectCell = GridColocacionesSelectCell
        FixedLineColor = clBlack
        Columns = <
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'COLOCACION'
            Width = 86
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'ASOCIADO'
            Width = 253
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'SALDO'
            Width = 74
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Alignment = taRightJustify
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'CUOTA'
            Width = 74
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Alignment = taRightJustify
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'CAPITAL'
            Width = 70
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'INTERES'
            Width = 70
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'ESTADO'
            Width = 70
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'DIAS'
            Width = 37
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Alignment = taRightJustify
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'ID'
            Width = 18
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'IDENTIFICACION'
            Width = 110
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            Caption = 'TIPO CUOTA'
            Width = 187
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'EN AHORROS'
            Width = 82
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Alignment = taRightJustify
          end
          item
            HeaderFont.Charset = DEFAULT_CHARSET
            HeaderFont.Color = clWindowText
            HeaderFont.Height = -11
            HeaderFont.Name = 'MS Sans Serif'
            HeaderFont.Style = [fsBold]
            HeaderAlignment = taCenter
            Caption = 'EN APORTES'
            Width = 82
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            Alignment = taRightJustify
          end>
        MultiLine = False
        ImmediateEditMode = False
        ColWidths = (
          86
          253
          74
          74
          70
          70
          70
          37
          18
          110
          187
          82
          82)
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 283
    Width = 782
    Height = 32
    Align = alTop
    TabOrder = 2
    object CmdOtraBusqueda: TBitBtn
      Left = 644
      Top = 2
      Width = 123
      Height = 25
      Caption = 'Otra Busqueda'
      TabOrder = 0
      OnClick = CmdOtraBusquedaClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000420B0000420B00000001000000010000004A0000005A
        00000052080018520800005A0800006B080021521000295A1000186310000873
        1000295A1800315A180010631800186B1800185A210039632100108421004263
        29004A632900186B290010942900527331004A7B3100528C390018AD39007373
        4200218C4200529442006394420021B54200639C4A0018BD4A0029C65200639C
        5A0029CE5A0031E76B005A6B730042EF73004A637B00EFBD8400B58C8C00C694
        8C00BD9C8C00BD949400C6949400F7CE9400C6A59C00C6AD9C00CEAD9C00F7CE
        9C004A7BA500CEADA500D6B5A500DEBDA500F7D6A500DEC6AD00FFE7AD00CEB5
        B500F7DEB500FFE7B500D6BDBD00DED6BD00E7DEBD006B9CC600FFEFC600FFF7
        C600FFF7CE00F7EFD600FFFFD6002184DE001884E700188CE700218CEF00B5D6
        EF00FFF7EF00FF00FF004AB5FF0052B5FF0052BDFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004B262B4B4B4B
        4B4B4B4B4B4B4B4B4B4B3F47322C4B4B4B4B4B4B4B4B4B4B4B4B4C4D48322C4B
        4B4B4B4B4B4B4B4B4B4B4B4D4D46322C4B4B4B4B4B4B4B4B4B4B4B4B4D4C4732
        2B4B4B4B4B4B4B4B4B4B4B4B4B4D4C452400000001004B4B4B4B4B4B4B4B4E49
        0E110B07090906334B4B4B4B4B4B4B3934404444081F0519284B4B4B4B000029
        3A364244211818153D4B4B4B000D040F382D00000520220900004B4B021D1D0C
        1727171A142523100F2F4B00102325141A172D1B0C1D1D13432E000009222005
        0000363117040D163E4B4B4B0018180A374F4A2D271C1E412A4B4B4B00051F00
        4B3C4340383B3A304B4B4B4B4B0009090003120F35354B4B4B4B}
    end
    object ComboInformes: TJvImageComboBox
      Left = 394
      Top = 3
      Width = 121
      Height = 22
      Color = cl3DLight
      Items = <
        item
          Text = 'Informes'
          ImageIndex = 13
          Indent = 0
        end
        item
          Text = 'Informe Mora'
          ImageIndex = 12
          Indent = 0
        end
        item
          Text = 'Informe Aportes'
          ImageIndex = 11
          Indent = 0
        end>
      ItemIndex = 0
      DroppedWidth = 121
      ButtonStyle = fsLighter
      ImageList = ImageList
      TabOrder = 1
      OnClick = ComboInformesClick
    end
    object ComboUtilidades: TJvImageComboBox
      Left = 16
      Top = 3
      Width = 121
      Height = 22
      Color = cl3DLight
      Items = <
        item
          Text = 'Utilidades'
          ImageIndex = 16
          Indent = 0
        end
        item
          Text = 'Informaci'#243'n'
          ImageIndex = 15
          Indent = 0
        end
        item
          Text = 'Garant'#237'as'
          ImageIndex = 14
          Indent = 0
        end
        item
          Text = 'Liquidaci'#243'n'
          ImageIndex = 10
          Indent = 0
        end>
      ItemIndex = 0
      DroppedWidth = 121
      ButtonStyle = fsLighter
      ImageList = ImageList
      TabOrder = 2
      OnClick = ComboUtilidadesClick
    end
    object ComboExtractos: TJvImageComboBox
      Left = 142
      Top = 3
      Width = 121
      Height = 22
      Color = cl3DLight
      Items = <
        item
          Text = 'Extractos'
          ImageIndex = 18
          Indent = 0
        end
        item
          Text = 'Captaci'#243'n'
          ImageIndex = 2
          Indent = 0
        end
        item
          Text = 'Colocaci'#243'n'
          ImageIndex = 4
          Indent = 0
        end>
      ItemIndex = 0
      DroppedWidth = 121
      ButtonStyle = fsLighter
      ImageList = ImageList
      TabOrder = 3
      OnClick = ComboExtractosClick
    end
    object ComboMantenimientos: TJvImageComboBox
      Left = 268
      Top = 3
      Width = 121
      Height = 22
      Color = cl3DLight
      Items = <
        item
          Text = 'Mantenimientos'
          ImageIndex = 17
          Indent = 0
        end
        item
          Text = 'Personas'
          ImageIndex = 0
          Indent = 0
        end>
      ItemIndex = 0
      DroppedWidth = 121
      ButtonStyle = fsLighter
      ImageList = ImageList
      TabOrder = 4
      OnClick = ComboMantenimientosClick
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 315
    Width = 782
    Height = 217
    Align = alClient
    TabOrder = 3
    object GroupBox4: TGroupBox
      Left = 1
      Top = 1
      Width = 780
      Height = 182
      Caption = 'Observaciones y Compromisos'
      TabOrder = 0
      object DBGrid1: TDBGrid
        Left = 2
        Top = 15
        Width = 776
        Height = 165
        Align = alClient
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'FECHA_OBSERVACION'
            ReadOnly = True
            Title.Alignment = taCenter
            Title.Caption = 'FECHA'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'OBSERVACION'
            ReadOnly = True
            Title.Alignment = taCenter
            Width = 600
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FECHA_COMPROMISO'
            Title.Alignment = taCenter
            Title.Caption = 'COMPROMISO'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COMPLETO'
            Title.Alignment = taCenter
            Title.Caption = 'REPORTO'
            Width = 150
            Visible = True
          end>
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 183
      Width = 780
      Height = 33
      Align = alBottom
      TabOrder = 1
      object CmdAgregar: TBitBtn
        Left = 4
        Top = 4
        Width = 75
        Height = 25
        Caption = 'Agregar'
        Enabled = False
        TabOrder = 0
        OnClick = CmdAgregarClick
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000E30E0000E30E0000000100000001000031319C003131
          A5003131AD003131B5003131BD003131C6003131CE003131D6003131DE003131
          E7003131EF003131F700FF00FF003131FF003139FF003939FF003942FF00424A
          FF004A4AFF005252FF006363FF006B6BFF006B73FF007B84FF00848CFF009C9C
          FF00C6CEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000C1B1B1B1B1B
          1B1B1B1B1B1B1B1B1B0C1B16030404040505040403030201141B1B05080A0B0B
          0A0B0A0A0A090805001B1B070A0E0E0E0E0E0E0E0E0E0906021B1B090E0E0E0E
          0E1B180E0E0E0B08031B1B0A0E0E0E0E0E1B180E0E0E0E09041B1B0E0E0E0E0E
          0E1B180E0E0E0E0A051B1B0E0E181818181B181818180B0A061B1B0E0E1B1B1B
          1B1B1B1B1B1B0A0A061B1B0E10100E0E0E1B180E0E0B0A0A061B1B0E1313100E
          0E1B180E0E0B0A0A061B1B1015141110101B180E0E0E0B0B061B1B1318151312
          111B180E0E0E0E0B061B1B1419181514131211100E0E0E0B041B1B1A1412100E
          0E0E0E0E0E0E0B08171B0C1B1B1B1B1B1B1B1B1B1B1B1B1B1B0C}
      end
      object CmdEliminar: TBitBtn
        Left = 84
        Top = 4
        Width = 75
        Height = 25
        Caption = 'Eliminar'
        Enabled = False
        TabOrder = 1
        OnClick = CmdEliminarClick
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000E30E0000E30E0000000100000001000031319C003131
          A5003131AD003131B5003131BD003131C6003131CE003131D6003131DE003131
          E7003131EF003131F700FF00FF003131FF003139FF003939FF003942FF00424A
          FF004A4AFF005252FF006363FF006B6BFF006B73FF007B84FF00848CFF009C9C
          FF00C6CEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000C1B1B1B1B1B
          1B1B1B1B1B1B1B1B1B0C1B16030404040505040403030201141B1B05080A0B0B
          0A0B0A0A0A090805001B1B070A0E0E0E0E0E0E0E0E0E0906021B1B090E0E0E0E
          0E0E0E0E0E0E0B08031B1B0A0E0E0E0E0E0E0E0E0E0E0E09041B1B0E0E0E0E0E
          0E0E0E0E0E0E0E0A051B1B0E0E1818181818181818180B0A061B1B0E0E1B1B1B
          1B1B1B1B1B1B0A0A061B1B0E10100E0E0E0E0E0E0E0B0A0A061B1B0E1313100E
          0E0E0E0E0E0B0A0A061B1B1015141110100E0E0E0E0E0B0B061B1B1318151312
          11110E0E0E0E0E0B061B1B1419181514131211100E0E0E0B041B1B1A1412100E
          0E0E0E0E0E0E0B08171B0C1B1B1B1B1B1B1B1B1B1B1B1B1B1B0C}
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = IBDataSet1
    Left = 702
    Top = 278
  end
  object IBSQL1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 702
    Top = 310
  end
  object IBDataSet1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      
        'select "col$controlcobro".ID_AGENCIA,"col$controlcobro".ID_COLOC' +
        'ACION,"col$controlcobro".FECHA_OBSERVACION,"col$controlcobro". O' +
        'BSERVACION, "col$controlcobro".ES_OBSERVACION,"col$controlcobro"' +
        '.ES_COMPROMISO, "col$controlcobro".FECHA_COMPROMISO, "gen$emplea' +
        'do".PRIMER_APELLIDO,"gen$empleado".NOMBRE from "col$controlcobro' +
        '" '
      
        'INNER JOIN "gen$empleado" ON ("col$controlcobro".ID_USUARIO = "g' +
        'en$empleado".ID_EMPLEADO)'
      
        'where ID_AGENCIA = :ID_AGENCIA and ID_COLOCACION = :ID_COLOCACIO' +
        'N ORDER BY FECHA_OBSERVACION DESC')
    Left = 730
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_AGENCIA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_COLOCACION'
        ParamType = ptUnknown
      end>
    object IBDataSet1ID_AGENCIA: TSmallintField
      FieldName = 'ID_AGENCIA'
      Origin = 'col$controlcobro.ID_AGENCIA'
      Required = True
    end
    object IBDataSet1ID_COLOCACION: TIBStringField
      FieldName = 'ID_COLOCACION'
      Origin = 'col$controlcobro.ID_COLOCACION'
      Required = True
      FixedChar = True
      Size = 11
    end
    object IBDataSet1FECHA_OBSERVACION: TDateField
      FieldName = 'FECHA_OBSERVACION'
      Origin = 'col$controlcobro.FECHA_OBSERVACION'
    end
    object IBDataSet1OBSERVACION: TMemoField
      FieldName = 'OBSERVACION'
      Origin = 'col$controlcobro.OBSERVACION'
      OnGetText = IBDataSet1OBSERVACIONGetText
      BlobType = ftMemo
      Size = 8
    end
    object IBDataSet1ES_OBSERVACION: TSmallintField
      FieldName = 'ES_OBSERVACION'
      Origin = 'col$controlcobro.ES_OBSERVACION'
    end
    object IBDataSet1ES_COMPROMISO: TSmallintField
      FieldName = 'ES_COMPROMISO'
      Origin = 'col$controlcobro.ES_COMPROMISO'
    end
    object IBDataSet1FECHA_COMPROMISO: TDateField
      FieldName = 'FECHA_COMPROMISO'
      Origin = 'col$controlcobro.FECHA_COMPROMISO'
      OnGetText = IBDataSet1FECHA_COMPROMISOGetText
      DisplayFormat = 'yyyy/MM/dd'
    end
    object IBDataSet1PRIMER_APELLIDO: TIBStringField
      FieldName = 'PRIMER_APELLIDO'
      Origin = 'gen$empleado.PRIMER_APELLIDO'
      Size = 30
    end
    object IBDataSet1NOMBRE: TIBStringField
      FieldName = 'NOMBRE'
      Origin = 'gen$empleado.NOMBRE'
      Size = 30
    end
    object IBDataSet1COMPLETO: TStringField
      FieldKind = fkCalculated
      FieldName = 'COMPLETO'
      OnGetText = IBDataSet1COMPLETOGetText
      Calculated = True
    end
  end
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "gen$agencia"')
    Left = 668
    Top = 280
  end
  object DataSource2: TDataSource
    AutoEdit = False
    DataSet = IBQuery1
    Left = 674
    Top = 310
  end
  object IBSQL2: TIBSQL
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 722
    Top = 278
  end
  object ReporteMora: TprTxReport
    ShowProgress = True
    CanUserEdit = False
    DesignerFormMode = fmNormal
    PreviewFormMode = fmNormal
    Collate = False
    Copies = 1
    FromPage = 1
    ToPage = 1
    PrintPagesMode = ppmAll
    Title = 'Informe Diario de Cartera'
    ExportOptions = [preoShowParamsDlg, preoShowProgress, preoShowAfterGenerate]
    ExportPagesMode = ppmAll
    ExportFromPage = 0
    ExportToPage = 0
    Values = <
      item
        Name = 'TNoDesembolsos'
        AggFunction = prafCount
        Formula = 'IBTabla.ID_COLOCACION'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBTabla'
      end
      item
        Name = 'TotalDesembolsos'
        AggFunction = prafSum
        Formula = 'IBTabla.VALOR_DESEMBOLSO'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBTabla'
        Accumulate = True
      end
      item
        Name = 'TotalCartera'
        AggFunction = prafSum
        Formula = 'IBTabla.SALDO'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBTabla'
      end>
    Variables = <
      item
        Name = 'Empresa'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Empleado'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Nit'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'MoraI'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Agencia'
        ValueType = 'prvvtString'
        Value = ''
      end>
    PrinterName = 'EPSON FX-1180+ ESC/P'
    ESCModelName = 'Epson printers'
    LeftSpaces = 0
    WrapAfterColumn = 0
    StartNewLineOnWrap = False
    EjectPageAfterPrint = False
    PaperType = ptPage
    UseLinesOnPage = False
    LinesOnPage = 0
    MakeFormFeedOnRulon = False
    PrintRulonMode = prmAllLines
    FromLine = 0
    ToLine = 0
    ExportTxOptions = []
    ExportFromLine = 0
    ExportToLine = 0
    ExportCodePage = prtxcpDOS866
    Left = 110
    Top = 424
    SystemInfo = (
      'OS: WIN32_NT 5.1.2600 Service Pack 1'
      ''
      'PageSize: 4096'
      'ActiveProcessorMask: $1000'
      'NumberOfProcessors: 1'
      'ProcessorType: 586'
      ''
      'Compiler version: Delphi6'
      'PReport version: 1.83')
    object prTxPage1: TprTxPage
      PageType = tptPage
      LineNum = 60
      ColNum = 236
      object prTxHPageHeaderBand1: TprTxHPageHeaderBand
        Height = 4
        UseVerticalBands = False
        PrintOnFirstPage = True
        object prTxMemoObj1: TprTxMemoObj
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
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold
                tfoWide)
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 17
          dRec.Bottom = 1
          Visible = False
        end
        object prTxCommandObj1: TprTxCommandObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              TxCommands = (
                txcCondensedOn)
            end>
          dRec.Left = 0
          dRec.Top = 0
          dRec.Right = 1
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj30: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Fecha de Impresion :[:<yyyy/mm/dd>StartDateTime]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = True
              CanResizeY = True
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 196
          dRec.Top = 2
          dRec.Right = 231
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj32: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'INFORME GENERAL COLOCACIONES CON MORA A PARTIR DE [MoraI] DIAS')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold
                tfoItalic)
            end>
          dRec.Left = 61
          dRec.Top = 0
          dRec.Right = 126
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj31: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Elaboro :  [empleado]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 3
          dRec.Right = 45
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj4: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'AGENCIA : [Agencia]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 2
          dRec.Right = 23
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj27: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Nit. [Nit]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
              TxFontStyleEx = tfsNormal
              TxFontOptionsEx = (
                tfoBold)
            end>
          dRec.Left = 28
          dRec.Top = 0
          dRec.Right = 48
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj28: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Pagina [Page] de [PagesCount]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 180
          dRec.Top = 0
          dRec.Right = 208
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj29: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '---------------------------------------')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 1
          dRec.Right = 232
          dRec.Bottom = 2
          Visible = False
        end
      end
      object prTxHDetailHeaderBand1: TprTxHDetailHeaderBand
        Height = 3
        UseVerticalBands = False
        DetailBand = ReporteMora.prTxHDetailBand1
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        ReprintOnEachPage = True
        LinkToDetail = True
        object prTxMemoObj14: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '---------------------------------------')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 232
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj15: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '---------------------------------------')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 2
          dRec.Right = 232
          dRec.Bottom = 3
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
          dRec.Left = 122
          dRec.Top = 1
          dRec.Right = 123
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj38: TprTxMemoObj
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
          dRec.Left = 170
          dRec.Top = 1
          dRec.Right = 171
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj2: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'COLOCACION')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 1
          dRec.Right = 14
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj3: TprTxMemoObj
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
          dRec.Left = 38
          dRec.Top = 1
          dRec.Right = 39
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj51: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'NIT/CC')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 39
          dRec.Top = 1
          dRec.Right = 54
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj53: TprTxMemoObj
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
          dRec.Left = 54
          dRec.Top = 1
          dRec.Right = 55
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj54: TprTxMemoObj
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
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 55
          dRec.Top = 1
          dRec.Right = 98
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj55: TprTxMemoObj
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
          dRec.Left = 98
          dRec.Top = 1
          dRec.Right = 99
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj56: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'VALOR')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 99
          dRec.Top = 1
          dRec.Right = 122
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'VALOR CUOTA')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 147
          dRec.Top = 1
          dRec.Right = 170
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'SALDO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 123
          dRec.Top = 1
          dRec.Right = 146
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj12: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'FECHA VENC.')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 171
          dRec.Top = 1
          dRec.Right = 182
          dRec.Bottom = 2
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
          dRec.Left = 221
          dRec.Top = 1
          dRec.Right = 222
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj17: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'DIAS MORA')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 222
          dRec.Top = 1
          dRec.Right = 232
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj20: TprTxMemoObj
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
          dRec.Left = 25
          dRec.Top = 1
          dRec.Right = 26
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj21: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'FECHA APERT.')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 26
          dRec.Top = 1
          dRec.Right = 38
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj48: TprTxMemoObj
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
          dRec.Left = 14
          dRec.Top = 1
          dRec.Right = 15
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj49: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'No. CUENTA')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = True
              CanResizeY = True
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 15
          dRec.Top = 1
          dRec.Right = 25
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj6: TprTxMemoObj
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
          dRec.Left = 146
          dRec.Top = 1
          dRec.Right = 147
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj9: TprTxMemoObj
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
          dRec.Left = 182
          dRec.Top = 1
          dRec.Right = 183
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj33: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CLASIFICACION')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 183
          dRec.Top = 1
          dRec.Right = 196
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj36: TprTxMemoObj
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
          dRec.Left = 196
          dRec.Top = 1
          dRec.Right = 197
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj37: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'EVALUACION')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 197
          dRec.Top = 1
          dRec.Right = 207
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj47: TprTxMemoObj
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
          dRec.Left = 207
          dRec.Top = 1
          dRec.Right = 208
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj58: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'ESTADO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 208
          dRec.Top = 1
          dRec.Right = 221
          dRec.Bottom = 2
          Visible = False
        end
      end
      object prTxHDetailBand1: TprTxHDetailBand
        Height = 1
        UseVerticalBands = False
        DataSetName = 'IBTabla'
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        Bands = (
          'prTxHDetailHeaderBand1'
          'prTxHDetailFooterBand1')
        object prTxMemoObj57: TprTxMemoObj
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
          dRec.Left = 38
          dRec.Top = 0
          dRec.Right = 39
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj60: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[IBTabla.PRIMER_APELLIDO] [IBTabla.SEGUNDO_APELLIDO] [IBTabla.NO' +
                  'MBRE]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 55
          dRec.Top = 0
          dRec.Right = 98
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj19: TprTxMemoObj
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
          dRec.Left = 98
          dRec.Top = 0
          dRec.Right = 99
          dRec.Bottom = 1
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
          dRec.Left = 170
          dRec.Top = 0
          dRec.Right = 171
          dRec.Bottom = 1
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
          dRec.Left = 221
          dRec.Top = 0
          dRec.Right = 222
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj64: TprTxMemoObj
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
          dRec.Left = 54
          dRec.Top = 0
          dRec.Right = 55
          dRec.Bottom = 1
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
          dRec.Left = 122
          dRec.Top = 0
          dRec.Right = 123
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj22: TprTxMemoObj
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
          dRec.Left = 25
          dRec.Top = 0
          dRec.Right = 26
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj50: TprTxMemoObj
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
          dRec.Left = 14
          dRec.Top = 0
          dRec.Right = 15
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj11: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.ID_COLOCACION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 14
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj18: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.CUENTA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 15
          dRec.Top = 0
          dRec.Right = 25
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj23: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/mm/dd>IBTabla.FECHA_DESEMBOLSO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 26
          dRec.Top = 0
          dRec.Right = 38
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj24: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.ID_PERSONA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 39
          dRec.Top = 0
          dRec.Right = 54
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj26: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBTabla.VALOR_DESEMBOLSO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 99
          dRec.Top = 0
          dRec.Right = 122
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj52: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBTabla.SALDO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 123
          dRec.Top = 0
          dRec.Right = 146
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj66: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/mm/dd>IBTabla.FECHA_VENCIMIENTO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 171
          dRec.Top = 0
          dRec.Right = 182
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj68: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.MORA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 222
          dRec.Top = 0
          dRec.Right = 232
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj41: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBTabla.VALOR_CUOTA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 147
          dRec.Top = 0
          dRec.Right = 170
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj7: TprTxMemoObj
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
          dRec.Left = 146
          dRec.Top = 0
          dRec.Right = 147
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj42: TprTxMemoObj
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
          dRec.Left = 182
          dRec.Top = 0
          dRec.Right = 183
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj44: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.ID_CLASIFICACION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 183
          dRec.Top = 0
          dRec.Right = 196
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj45: TprTxMemoObj
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
          dRec.Left = 196
          dRec.Top = 0
          dRec.Right = 197
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj46: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.ID_EVALUACION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 197
          dRec.Top = 0
          dRec.Right = 207
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj59: TprTxMemoObj
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
          dRec.Left = 207
          dRec.Top = 0
          dRec.Right = 208
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj61: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.DESCRIPCION_ESTADO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 208
          dRec.Top = 0
          dRec.Right = 221
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHDetailFooterBand1: TprTxHDetailFooterBand
        Height = 2
        UseVerticalBands = False
        DetailBand = ReporteMora.prTxHDetailBand1
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = False
        object prTxMemoObj25: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '---------------------------------------')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 232
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj16: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Valor Total Colocaciones : [:<#,##0.00>TotalDesembolsos] ')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 71
          dRec.Top = 1
          dRec.Right = 126
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj5: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'No. Colocaciones : [TNoDesembolsos]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 1
          dRec.Right = 28
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj35: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Valor Total Cartera : [:<#,##0.00>TotalCartera] ')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 151
          dRec.Top = 1
          dRec.Right = 206
          dRec.Bottom = 2
          Visible = False
        end
      end
    end
  end
  object IBTabla: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID_AGENCIA'
        DataType = ftInteger
      end
      item
        Name = 'ID_COLOCACION'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'DESCRIPCION_ESTADO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'CUENTA'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ID_IDENTIFICACION'
        DataType = ftInteger
      end
      item
        Name = 'ID_PERSONA'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'NOMBRE'
        DataType = ftString
        Size = 255
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
        Name = 'VALOR_DESEMBOLSO'
        DataType = ftCurrency
      end
      item
        Name = 'SALDO'
        DataType = ftCurrency
      end
      item
        Name = 'VALOR_CUOTA'
        DataType = ftCurrency
      end
      item
        Name = 'FECHA_DESEMBOLSO'
        DataType = ftDate
      end
      item
        Name = 'FECHA_VENCIMIENTO'
        DataType = ftDate
      end
      item
        Name = 'ID_CLASIFICACION'
        DataType = ftSmallint
      end
      item
        Name = 'ID_EVALUACION'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'MORA'
        DataType = ftInteger
      end
      item
        Name = 'APORTES'
        DataType = ftCurrency
      end
      item
        Name = 'AHORROS'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 392
    Top = 72
    Data = {
      680200009619E0BD01000000180000001300000000000300000068020A49445F
      4147454E43494104000100000000000D49445F434F4C4F434143494F4E010049
      0000000100055749445448020002000B00124445534352495043494F4E5F4553
      5441444F0100490000000100055749445448020002006400064355454E544101
      00490000000100055749445448020002000A001149445F4944454E5449464943
      4143494F4E04000100000000000A49445F504552534F4E410100490000000100
      055749445448020002000F00064E4F4D42524502004900000001000557494454
      4802000200FF000F5052494D45525F4150454C4C49444F010049000000010005
      5749445448020002001E0010534547554E444F5F4150454C4C49444F01004900
      00000100055749445448020002001E001056414C4F525F444553454D424F4C53
      4F080004000000010007535542545950450200490006004D6F6E657900055341
      4C444F080004000000010007535542545950450200490006004D6F6E6579000B
      56414C4F525F43554F5441080004000000010007535542545950450200490006
      004D6F6E6579001046454348415F444553454D424F4C534F0400060000000000
      1146454348415F56454E43494D49454E544F04000600000000001049445F434C
      4153494649434143494F4E02000100000000000D49445F4556414C554143494F
      4E0100490000000100055749445448020002000100044D4F5241040001000000
      00000741504F5254455308000400000001000753554254595045020049000600
      4D6F6E6579000741484F52524F53080004000000010007535542545950450200
      490006004D6F6E6579000000}
    object IBTablaID_AGENCIA: TIntegerField
      FieldName = 'ID_AGENCIA'
    end
    object IBTablaID_COLOCACION: TStringField
      FieldName = 'ID_COLOCACION'
      Size = 11
    end
    object IBTablaDESCRIPCION_ESTADO: TStringField
      FieldName = 'DESCRIPCION_ESTADO'
      Size = 100
    end
    object IBTablaCUENTA: TStringField
      FieldName = 'CUENTA'
      Size = 10
    end
    object IBTablaID_IDENTIFICACION: TIntegerField
      FieldName = 'ID_IDENTIFICACION'
    end
    object IBTablaID_PERSONA: TStringField
      FieldName = 'ID_PERSONA'
      Size = 15
    end
    object IBTablaNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 255
    end
    object IBTablaPRIMER_APELLIDO: TStringField
      FieldName = 'PRIMER_APELLIDO'
      Size = 30
    end
    object IBTablaSEGUNDO_APELLIDO: TStringField
      FieldName = 'SEGUNDO_APELLIDO'
      Size = 30
    end
    object IBTablaVALOR_DESEMBOLSO: TCurrencyField
      FieldName = 'VALOR_DESEMBOLSO'
    end
    object IBTablaSALDO: TCurrencyField
      FieldName = 'SALDO'
    end
    object IBTablaVALOR_CUOTA: TCurrencyField
      FieldName = 'VALOR_CUOTA'
    end
    object IBTablaFECHA_DESEMBOLSO: TDateField
      FieldName = 'FECHA_DESEMBOLSO'
    end
    object IBTablaFECHA_VENCIMIENTO: TDateField
      FieldName = 'FECHA_VENCIMIENTO'
    end
    object IBTablaID_CLASIFICACION: TSmallintField
      FieldName = 'ID_CLASIFICACION'
    end
    object IBTablaID_EVALUACION: TStringField
      FieldName = 'ID_EVALUACION'
      Size = 1
    end
    object IBTablaMORA: TIntegerField
      FieldName = 'MORA'
    end
    object IBTablaAPORTES: TCurrencyField
      FieldName = 'APORTES'
    end
    object IBTablaAHORROS: TCurrencyField
      FieldName = 'AHORROS'
    end
  end
  object IBTabla1: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID_AGENCIA'
        DataType = ftInteger
      end
      item
        Name = 'ID_COLOCACION'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'DESCRIPCION_ESTADO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'CUENTA'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ID_IDENTIFICACION'
        DataType = ftInteger
      end
      item
        Name = 'ID_PERSONA'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'NOMBRE'
        DataType = ftString
        Size = 255
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
        Name = 'VALOR_DESEMBOLSO'
        DataType = ftCurrency
      end
      item
        Name = 'SALDO'
        DataType = ftCurrency
      end
      item
        Name = 'VALOR_CUOTA'
        DataType = ftCurrency
      end
      item
        Name = 'FECHA_DESEMBOLSO'
        DataType = ftDate
      end
      item
        Name = 'FECHA_VENCIMIENTO'
        DataType = ftDate
      end
      item
        Name = 'ID_CLASIFICACION'
        DataType = ftSmallint
      end
      item
        Name = 'ID_EVALUACION'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'MORA'
        DataType = ftInteger
      end
      item
        Name = 'APORTES'
        DataType = ftCurrency
      end
      item
        Name = 'AHORROS'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 432
    Top = 72
    Data = {
      680200009619E0BD01000000180000001300000000000300000068020A49445F
      4147454E43494104000100000000000D49445F434F4C4F434143494F4E010049
      0000000100055749445448020002000B00124445534352495043494F4E5F4553
      5441444F0100490000000100055749445448020002006400064355454E544101
      00490000000100055749445448020002000A001149445F4944454E5449464943
      4143494F4E04000100000000000A49445F504552534F4E410100490000000100
      055749445448020002000F00064E4F4D42524502004900000001000557494454
      4802000200FF000F5052494D45525F4150454C4C49444F010049000000010005
      5749445448020002001E0010534547554E444F5F4150454C4C49444F01004900
      00000100055749445448020002001E001056414C4F525F444553454D424F4C53
      4F080004000000010007535542545950450200490006004D6F6E657900055341
      4C444F080004000000010007535542545950450200490006004D6F6E6579000B
      56414C4F525F43554F5441080004000000010007535542545950450200490006
      004D6F6E6579001046454348415F444553454D424F4C534F0400060000000000
      1146454348415F56454E43494D49454E544F04000600000000001049445F434C
      4153494649434143494F4E02000100000000000D49445F4556414C554143494F
      4E0100490000000100055749445448020002000100044D4F5241040001000000
      00000741504F5254455308000400000001000753554254595045020049000600
      4D6F6E6579000741484F52524F53080004000000010007535542545950450200
      490006004D6F6E6579000000}
    object IntegerField1: TIntegerField
      FieldName = 'ID_AGENCIA'
    end
    object StringField1: TStringField
      FieldName = 'ID_COLOCACION'
      Size = 11
    end
    object StringField2: TStringField
      FieldName = 'DESCRIPCION_ESTADO'
      Size = 100
    end
    object StringField3: TStringField
      FieldName = 'CUENTA'
      Size = 10
    end
    object IntegerField2: TIntegerField
      FieldName = 'ID_IDENTIFICACION'
    end
    object StringField4: TStringField
      FieldName = 'ID_PERSONA'
      Size = 15
    end
    object StringField5: TStringField
      FieldName = 'NOMBRE'
      Size = 255
    end
    object StringField6: TStringField
      FieldName = 'PRIMER_APELLIDO'
      Size = 30
    end
    object StringField7: TStringField
      FieldName = 'SEGUNDO_APELLIDO'
      Size = 30
    end
    object CurrencyField1: TCurrencyField
      FieldName = 'VALOR_DESEMBOLSO'
    end
    object CurrencyField2: TCurrencyField
      FieldName = 'SALDO'
    end
    object CurrencyField3: TCurrencyField
      FieldName = 'VALOR_CUOTA'
    end
    object DateField1: TDateField
      FieldName = 'FECHA_DESEMBOLSO'
    end
    object DateField2: TDateField
      FieldName = 'FECHA_VENCIMIENTO'
    end
    object SmallintField1: TSmallintField
      FieldName = 'ID_CLASIFICACION'
    end
    object StringField8: TStringField
      FieldName = 'ID_EVALUACION'
      Size = 1
    end
    object IntegerField3: TIntegerField
      FieldName = 'MORA'
    end
    object IBTabla1APORTES: TCurrencyField
      FieldName = 'APORTES'
    end
    object IBTabla1AHORROS: TCurrencyField
      FieldName = 'AHORROS'
    end
  end
  object ReporteAportes: TprTxReport
    ShowProgress = True
    CanUserEdit = False
    DesignerFormMode = fmNormal
    PreviewFormMode = fmNormal
    Collate = False
    Copies = 1
    FromPage = 1
    ToPage = 1
    PrintPagesMode = ppmAll
    Title = 'Informe Diario de Cartera'
    ExportOptions = [preoShowParamsDlg, preoShowProgress, preoShowAfterGenerate]
    ExportPagesMode = ppmAll
    ExportFromPage = 0
    ExportToPage = 0
    Values = <
      item
        Name = 'TNoDesembolsos'
        AggFunction = prafCount
        Formula = 'IBTabla.ID_COLOCACION'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBTabla'
      end
      item
        Name = 'TotalDesembolsos'
        AggFunction = prafSum
        Formula = 'IBTabla.VALOR_DESEMBOLSO'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBTabla'
        Accumulate = True
      end
      item
        Name = 'TotalCartera'
        AggFunction = prafSum
        Formula = 'IBTabla.SALDO'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBTabla'
      end>
    Variables = <
      item
        Name = 'Empresa'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Empleado'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Nit'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'MoraI'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Agencia'
        ValueType = 'prvvtString'
        Value = ''
      end>
    PrinterName = 'EPSON FX-1180+ ESC/P'
    ESCModelName = 'Epson printers'
    LeftSpaces = 0
    WrapAfterColumn = 0
    StartNewLineOnWrap = False
    EjectPageAfterPrint = False
    PaperType = ptPage
    UseLinesOnPage = False
    LinesOnPage = 0
    MakeFormFeedOnRulon = False
    PrintRulonMode = prmAllLines
    FromLine = 0
    ToLine = 0
    ExportTxOptions = []
    ExportFromLine = 0
    ExportToLine = 0
    ExportCodePage = prtxcpDOS866
    Left = 110
    Top = 424
    SystemInfo = (
      'OS: WIN32_NT 5.1.2600 Service Pack 1'
      ''
      'PageSize: 4096'
      'ActiveProcessorMask: $1000'
      'NumberOfProcessors: 1'
      'ProcessorType: 586'
      ''
      'Compiler version: Delphi6'
      'PReport version: 1.83')
    object prTxPage1: TprTxPage
      PageType = tptPage
      LineNum = 60
      ColNum = 236
      object prTxHPageHeaderBand1: TprTxHPageHeaderBand
        Height = 4
        UseVerticalBands = False
        PrintOnFirstPage = True
        object prTxMemoObj1: TprTxMemoObj
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
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold
                tfoWide)
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 17
          dRec.Bottom = 1
          Visible = False
        end
        object prTxCommandObj1: TprTxCommandObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              TxCommands = (
                txcCondensedOn)
            end>
          dRec.Left = 0
          dRec.Top = 0
          dRec.Right = 1
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj30: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Fecha de Impresion :[:<yyyy/mm/dd>StartDateTime]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = True
              CanResizeY = True
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 196
          dRec.Top = 2
          dRec.Right = 231
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj32: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'INFORME GENERAL COLOCACIONES CON MORA A PARTIR DE [MoraI] DIAS')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold
                tfoItalic)
            end>
          dRec.Left = 61
          dRec.Top = 0
          dRec.Right = 126
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj31: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Elaboro :  [empleado]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 3
          dRec.Right = 45
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj4: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'AGENCIA : [Agencia]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 2
          dRec.Right = 23
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj27: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Nit. [Nit]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
              TxFontStyleEx = tfsNormal
              TxFontOptionsEx = (
                tfoBold)
            end>
          dRec.Left = 28
          dRec.Top = 0
          dRec.Right = 48
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj28: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Pagina [Page] de [PagesCount]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 180
          dRec.Top = 0
          dRec.Right = 208
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj29: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '---------------------------------------')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 1
          dRec.Right = 232
          dRec.Bottom = 2
          Visible = False
        end
      end
      object prTxHDetailHeaderBand1: TprTxHDetailHeaderBand
        Height = 3
        UseVerticalBands = False
        DetailBand = ReporteAportes.prTxHDetailBand1
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        ReprintOnEachPage = True
        LinkToDetail = True
        object prTxMemoObj14: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '---------------------------------------')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 232
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj15: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '---------------------------------------')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 2
          dRec.Right = 232
          dRec.Bottom = 3
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
          dRec.Left = 122
          dRec.Top = 1
          dRec.Right = 123
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj38: TprTxMemoObj
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
          dRec.Left = 170
          dRec.Top = 1
          dRec.Right = 171
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj2: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'COLOCACION')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 1
          dRec.Right = 14
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj3: TprTxMemoObj
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
          dRec.Left = 38
          dRec.Top = 1
          dRec.Right = 39
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj51: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'NIT/CC')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 39
          dRec.Top = 1
          dRec.Right = 54
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj53: TprTxMemoObj
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
          dRec.Left = 54
          dRec.Top = 1
          dRec.Right = 55
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj54: TprTxMemoObj
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
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 55
          dRec.Top = 1
          dRec.Right = 98
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj55: TprTxMemoObj
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
          dRec.Left = 98
          dRec.Top = 1
          dRec.Right = 99
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj56: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'VALOR')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 99
          dRec.Top = 1
          dRec.Right = 122
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'VALOR CUOTA')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 147
          dRec.Top = 1
          dRec.Right = 170
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'SALDO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 123
          dRec.Top = 1
          dRec.Right = 146
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj12: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'FECHA VENC.')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 171
          dRec.Top = 1
          dRec.Right = 182
          dRec.Bottom = 2
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
          dRec.Left = 221
          dRec.Top = 1
          dRec.Right = 222
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj17: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'DIAS MORA')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 222
          dRec.Top = 1
          dRec.Right = 232
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj20: TprTxMemoObj
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
          dRec.Left = 25
          dRec.Top = 1
          dRec.Right = 26
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj21: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'FECHA APERT.')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 26
          dRec.Top = 1
          dRec.Right = 38
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj48: TprTxMemoObj
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
          dRec.Left = 14
          dRec.Top = 1
          dRec.Right = 15
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj49: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'No. CUENTA')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = True
              CanResizeY = True
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 15
          dRec.Top = 1
          dRec.Right = 25
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj6: TprTxMemoObj
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
          dRec.Left = 146
          dRec.Top = 1
          dRec.Right = 147
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj9: TprTxMemoObj
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
          dRec.Left = 182
          dRec.Top = 1
          dRec.Right = 183
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj47: TprTxMemoObj
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
          dRec.Left = 207
          dRec.Top = 1
          dRec.Right = 208
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj58: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'ESTADO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 208
          dRec.Top = 1
          dRec.Right = 221
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj33: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'SALDO APORTES')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 183
          dRec.Top = 1
          dRec.Right = 207
          dRec.Bottom = 2
          Visible = False
        end
      end
      object prTxHDetailBand1: TprTxHDetailBand
        Height = 1
        UseVerticalBands = False
        DataSetName = 'IBTabla'
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        Valid = 'IBTabla.SALDO <= IBTabla.APORTES'
        Bands = (
          'prTxHDetailHeaderBand1'
          'prTxHDetailFooterBand1')
        object prTxMemoObj57: TprTxMemoObj
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
          dRec.Left = 38
          dRec.Top = 0
          dRec.Right = 39
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj60: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[IBTabla.PRIMER_APELLIDO] [IBTabla.SEGUNDO_APELLIDO] [IBTabla.NO' +
                  'MBRE]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 55
          dRec.Top = 0
          dRec.Right = 98
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj19: TprTxMemoObj
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
          dRec.Left = 98
          dRec.Top = 0
          dRec.Right = 99
          dRec.Bottom = 1
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
          dRec.Left = 170
          dRec.Top = 0
          dRec.Right = 171
          dRec.Bottom = 1
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
          dRec.Left = 221
          dRec.Top = 0
          dRec.Right = 222
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj64: TprTxMemoObj
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
          dRec.Left = 54
          dRec.Top = 0
          dRec.Right = 55
          dRec.Bottom = 1
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
          dRec.Left = 122
          dRec.Top = 0
          dRec.Right = 123
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj22: TprTxMemoObj
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
          dRec.Left = 25
          dRec.Top = 0
          dRec.Right = 26
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj50: TprTxMemoObj
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
          dRec.Left = 14
          dRec.Top = 0
          dRec.Right = 15
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj11: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.ID_COLOCACION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 14
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj18: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.CUENTA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 15
          dRec.Top = 0
          dRec.Right = 25
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj23: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/mm/dd>IBTabla.FECHA_DESEMBOLSO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 26
          dRec.Top = 0
          dRec.Right = 38
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj24: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.ID_PERSONA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 39
          dRec.Top = 0
          dRec.Right = 54
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj26: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBTabla.VALOR_DESEMBOLSO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 99
          dRec.Top = 0
          dRec.Right = 122
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj52: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBTabla.SALDO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 123
          dRec.Top = 0
          dRec.Right = 146
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj66: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/mm/dd>IBTabla.FECHA_VENCIMIENTO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 171
          dRec.Top = 0
          dRec.Right = 182
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj68: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.MORA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 222
          dRec.Top = 0
          dRec.Right = 232
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj41: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBTabla.VALOR_CUOTA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 147
          dRec.Top = 0
          dRec.Right = 170
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj7: TprTxMemoObj
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
          dRec.Left = 146
          dRec.Top = 0
          dRec.Right = 147
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj42: TprTxMemoObj
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
          dRec.Left = 182
          dRec.Top = 0
          dRec.Right = 183
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj59: TprTxMemoObj
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
          dRec.Left = 207
          dRec.Top = 0
          dRec.Right = 208
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj61: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBTabla.DESCRIPCION_ESTADO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 208
          dRec.Top = 0
          dRec.Right = 221
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj36: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBTabla.APORTES]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 183
          dRec.Top = 0
          dRec.Right = 207
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHDetailFooterBand1: TprTxHDetailFooterBand
        Height = 2
        UseVerticalBands = False
        DetailBand = ReporteAportes.prTxHDetailBand1
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = False
        object prTxMemoObj16: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Valor Total Colocaciones : [:<#,##0.00>TotalDesembolsos] ')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 71
          dRec.Top = 1
          dRec.Right = 126
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj5: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'No. Colocaciones : [TNoDesembolsos]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 1
          dRec.Right = 28
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj35: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Valor Total Cartera : [:<#,##0.00>TotalCartera] ')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 151
          dRec.Top = 1
          dRec.Right = 206
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj25: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '---------------------------------------')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 232
          dRec.Bottom = 1
          Visible = False
        end
      end
    end
  end
  object ImageList: TImageList
    Left = 344
    Bitmap = {
      494C010113001800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000006000000001002000000000000060
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
      0000000000000000000000000000000000000000000000000000B5848400B584
      8400B5848400B5848400B5848400B5848400B5848400B5848400B5848400B584
      8400B5848400B5848400A5A5A500424242000000000000000000000000000000
      00000000000000000000000000006B7373006B73730000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6A59C00FFEF
      D600F7E7C600F7DEBD00F7DEB500F7D6AD00F7D6A500EFCE9C00EFCE9400EFCE
      9400EFCE9400ADADAD005A5A5A00C6C6C6000000000000000000000000000000
      000000000000000000006B7373008C736300A5632100734A2900000000000000
      00000000000000000000000000000000000000000000589DD700346BAC00346B
      AC00346BAC00346BAC00346BAC00346BAC00346BAC00346BAC00346BAC00346B
      AC00346BAC00346BAC00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6A59C00FFEF
      D600F7E7CE00F7DEC600F7DEBD00F7D6B500F7D6A500EFCE9C00EFCE9C00EFCE
      9400BDBDBD006B6B6B00C6C6C600848484000000000000000000000000000000
      000000000000000000006B635A009C846300D6731800A55A2900000000000000
      00000000000000000000000000000000000000000000589DD700F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6ADA500FFEF
      E700AD6B5A00AD6B5A00AD6B5A009C9C9C009C9C9C009C9C9C009C9C9C00AD6B
      5A006B6B6B00181818006B6B6B00524A4A0000000000000000005A5252005A52
      52005A525200000000006B635A009C846300D6731800945A2900000000000000
      00000000000000000000000000000000000000000000589DD700F7FFFF002C69
      30002C6930002C6930002C6930002C6930002C6930002C6930002C6930002C69
      30002C693000F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C6ADA500FFF7
      E700F7E7D600F7E7CE00BDBDBD004A4A4A00524A4A004A4A4A0052525200A5A5
      A500393939006B6B6B00BDBDBD00000000000000000084848400B5B5B500BDBD
      BD00B5B5B500A5A5A500736B6300A58C7300D67318008C523100000000000000
      000000000000000000000000000000000000000000004EA5ED00F7FFFF002C69
      3000F7FFFF0079A9D700F7FFFF0079A9D700F7FFFF00F7FFFF0079A9D700F7FF
      FF002C693000F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CEB5AD00FFFF
      F700AD6B5A0094949C0042393900AD6B5A00AD6B5A00AD6B5A00AD6B5A004239
      39006B6B6B00DEDED600B5848400000000000000000084848400848484008484
      8400C6C6C600BDBDBD00736B6300CE9C6B00D67318008C5A39005A5252005A52
      52005A5252005A5252006363630000000000000000004EA5ED00F7FFFF002C69
      30004EBF6C0079A9D7004EBF6C0079A9D7004EBF6C004EBF6C0079A9D7004EBF
      6C002C693000F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6B5AD00FFFF
      FF00A5A59C0042393900B5847300AD6B5A00AD6B5A00AD6B5A00AD6B5A00B584
      730042393900C6C6C600B5848400000000000000000000000000000000000000
      0000B5B5B500C6C6C600736B6300CE9C6300D6732100734A3900B5B5B500ADAD
      AD00ADADAD00B5B5B500A594A5005A525200000000004EA5ED00F7FFFF002C69
      3000F7FFFF0079A9D700F7FFFF0079A9D700F7FFFF00F7FFFF0079A9D700F7FF
      FF002C693000F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6BDB500A5A5
      9C006B6B6B00C6B59400FFE7D600EFC6AD00F7D6AD00F7D6AD00E7C69C00F7E7
      CE009C8C730042393900B584840000000000000000009C9C9C00636363006363
      6300C6C6C600BDBDBD007B736300DEA56B00D6732100734A3900848484008484
      840084848400848484008484840000000000000000004EA5ED00F7FFFF002C69
      30004EBF6C0079A9D7004EBF6C0079A9D7004EBF6C004EBF6C0079A9D7004EBF
      6C002C693000F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6BDB500A5A5
      9C006B6B6B00D6BDA500AD6B5A00AD6B5A00AD6B5A00AD6B5A00AD6B5A00AD6B
      5A00AD9C8C0042393900B584840000000000000000009C9C9C00A5A5A500B5B5
      B500A5A5A5008484840063635A00D6A57300DE7331007B5A4A00000000000000
      000000000000000000000000000000000000000000004EA5ED00F7FFFF002C69
      3000F7FFFF0079A9D700F7FFFF0079A9D700F7FFFF00F7FFFF0079A9D700F7FF
      FF002C693000F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEBDB500A5A5
      9C006B6B6B00C6BDA500B5847300B5847300AD6B5A00AD6B5A00AD6B5A00AD6B
      5A00A5947B0042393900B58484000000000000000000000000009C9C9C009C9C
      9C0084848400000000007B736B00F7BD7B00CE73310084635A00000000000000
      000000000000000000000000000000000000000000004EA5ED00F7FFFF002C69
      30002C6930002C6930002C6930002C6930002C6930002C6930002C6930002C69
      30002C693000F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000DEC6B500FFFF
      FF00A5A59C006B6B6B00FFD6AD00FFE7D600F7FFFF00FFFFF700FFDED600FFD6
      B50042393900A5A5A500B5848400000000000000000000000000000000000000
      0000000000000000000063524200A57B5A00A5634200846B6300000000000000
      000000000000000000000000000000000000000000004EA5ED00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C6B500FFFF
      FF00FFFFFF00A5A59C006B6B6B00F7D6AD00AD6B5A00AD6B5A00EFD6A5004239
      3900BDBDBD00B58C8400B5848400000000000000000000000000000000000000
      000000000000000000005A525200A5A5A5006B6B6B005A525200000000000000
      000000000000000000000000000000000000000000004EA5ED00F7FFFF00F7FF
      FF002C6930002C6930002C6930002C6930002C6930002C6930002C6930002C69
      3000F7FFFF00F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C6B500FFFF
      FF00AD6B5A00AD6B5A00A5A59C006B6B6B006B6B6B006B6B6B006B6B6B00A5A5
      9C00EFB57300EFA54A00C6846B00000000000000000000000000000000008C8C
      8C008C8C8C00000000005A525200A5A5A500B5B5B5005A525200000000000000
      000000000000000000000000000000000000000000004EA5ED00F7FFFF00F7FF
      FF004EBF6C004EBF6C0041B2580041B25800349F3F00349F3F00349F3F003283
      3C00F7FFFF00F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFCEBD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A5A59C00A5A59C00A5A59C00A5A59C00C694
      7B00FFC67300CE94730000000000000000000000000000000000527B8400D6D6
      D600636363008C8C8C005A52520094949400C6C6C600C6C6C600000000000000
      00005A5252006B7373000000000000000000000000004EA5ED00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00346BAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C6B500FFF7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00E7CECE00C694
      7B00CE9C84000000000000000000000000000000000000000000527B8400B5B5
      B50063636300F7F7F7006B6B6B0094949400ADADAD00B5B5B500C6C6C600BDBD
      BD009C9C9C006B7373000000000000000000000000004EA5ED004EA5ED004EA5
      ED004EA5ED004EA5ED004EA5ED004EA5ED004EA5ED004EA5ED004EA5ED00589D
      D700589DD700589DD700589DD700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7C6B500EFCE
      B500EFCEB500EFCEB500EFCEB500E7C6B500E7C6B500EFCEB500D6BDB500BD84
      7B0000000000000000000000000000000000000000000000000063636300B5B5
      B5009C9C9C008C8C8C00A5A5A500DEDEDE00CECECE00BDBDBD00ADADAD00949C
      9C006B7373000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A5636B00A563
      6B00A5636B00A5636B00A5636B00A5636B00A5636B00A5636B00A5636B00A563
      6B00A5636B00A5636B00A5636B00000000000000000000000000000000000000
      000000000000000000009C9C9C00000000000000000000000000848484008484
      84008C8C8C000000000000000000000000000000000000000000000000000000
      0000AD7B6B00AD7B6B00AD7B6B00AD7B6B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004A526300FFEF
      C600F7D6B500EFD6AD00EFCE9C00EFCE9400EFC68C00EFBD8400EFBD7B00EFBD
      8400EFBD8400EFC68400A5636B00000000000000000000000000000000000000
      00009C9C9C009C9C9C00D6CECE009494940039393900525252009C949400C6C6
      C600D6D6D600848484000000000000000000000000000000000000000000AD7B
      6B00DEA57B00EFC69400E7C6A500DEB58C00AD7B6B00AD7B6B00AD7B6B00AD7B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000636B8400186BC600636B
      8400F7DEBD00EFD6AD00EFCEA500EFCE9C00EFC69400EFC68C00EFBD8400EFBD
      7B00EFBD7B00EFC68400A5636B000000000000000000000000009C9C9C009C9C
      9C00F7F7F700FFFFFF00D6D6D6009C9C9C004242420021182100211821003131
      310063636300848484008C8C8C00000000000000000000000000AD7B6B00DEB5
      8C00EFB57B00EFC69C00EFD6B500EFCEA500C69C73007B4A4A008C525200AD7B
      6B00AD7B6B00AD7B6B000000000000000000000000000000000010841000189C
      180031A5310039AD390039AD3900107B100031942900217318005A524200736B
      5A0000000000000000000000000000000000000000000000000031A5FF001073
      D6006B6B8400F7DEBD00EFD6B500EFCEA500EFCE9C00EFC69400EFC68C00EFBD
      8400EFBD7B00EFC68400A5636B0000000000948C8C009C9C9C00EFEFEF00FFFF
      FF00EFE7E700C6C6C6009C9C9C008C8C8C009494940084848400636363003939
      39001821210021182100737373000000000000000000AD7B6B00E7BD9400EFC6
      8C00EFB57B00EFC6A500F7E7CE00F7D6AD00C69C84007B4A4A007B4A4A00CEA5
      7B00EFBD8C00D6A58400AD7B6B0000000000000000000000000021A5210031AD
      31004ABD4A0052C65200399C39008CBD7B0052BD520042BD4200217318004A42
      2900000000000000000000000000000000000000000000000000A5635A0031A5
      FF001073D6005A638400F7DEBD00EFD6AD00EFCEA500EFCE9C00EFC69400EFC6
      8C00EFBD8400EFC68400A5636B00000000009C9C9C00E7E7E700E7E7E700BDBD
      BD00A5A5A500B5ADAD00C6BDBD00A5A5A50094949400948C8C00949494009C94
      94008C8C8C006B6B6B008484840000000000AD7B6B00F7CE9C00F7D69400EFC6
      8C00EFB57B00F7CEAD00FFEFDE00FFE7C600CEA58C007B4A4A007B4A4A00CEA5
      7B00EFBD8C00DEB58400AD7B6B00000000000000000000000000299C29004ABD
      4A006BCE6B006BC66B00F7FFEF00F7FFEF0063C6630063CE630031A531004A6B
      3900000000000000000000000000000000000000000000000000A5736B00FFF7
      EF0031A5FF00427BAD008C635A00AD7B730094635A00AD7B6B00CEA58400EFC6
      9400EFC68C00EFC68400A5636B000000000094949400ADADAD00A5A5A500ADAD
      AD00C6C6C600D6D6D600EFEFEF00EFEFEF00DEDEDE00C6C6C600ADADAD009C9C
      9C00948C8C00949494008C8C8C0000000000AD7B6B00F7D69C00F7D69400F7C6
      8C00F7B57300F7CEAD00FFF7EF00FFEFDE00CEAD9C00734242007B4A4A00CEA5
      7B00EFBD8C00DEB58400AD7B6B00000000000000000000000000000000004ABD
      4A0073CE730052A54A00FFFFFF00FFFFFF006BC66B0073CE7300319C31000000
      0000000000000000000000000000000000000000000000000000A5736B00FFFF
      FF00F7EFE700AD8C8C00B58C8400DEBDA500EFD6B500D6B59C00B58C7300CEA5
      8400EFC69400EFC68C00A5636B0000000000948C8C00ADADAD00C6C6C600CECE
      CE00C6C6C600DEDEDE00CECECE00A5ADA500BDBDBD00CECECE00D6D6D600D6D6
      D600C6C6C600B5B5B5009494940000000000AD7B6B00F7D69C00FFD69400E7BD
      9400B5A59400F7CEAD00FFFFF700FFF7EF00DEC6B50094635A0084524A00CEA5
      8400EFBD8C00DEB58400AD7B6B00000000000000000000000000000000000000
      000018734A003984AD00217BBD00428CAD0063BD6300399C3900000000000000
      0000000000000000000000000000000000000000000000000000BD846B00FFFF
      FF00FFF7EF00AD847B00DEC6B500F7E7CE00F7E7C600FFFFF700D6B59C00AD7B
      6B00EFCE9C00EFCE9400A5636B0000000000000000009C9C9C00CECECE00CECE
      CE00DEDEDE00C6C6C600B5B5B500A5D6A500BDC6BD00C6A5A500ADA5A500A5A5
      A500B5B5B500C6BDBD00A5A5A50000000000AD7B6B00FFD69400D6CEA50052A5
      E7002184F70084ADDE00FFFFEF00FFF7EF00FFF7E700F7E7CE00E7C6A500E7C6
      9C00E7BD9400DEB58400AD7B6B00000000000000000000000000000000000000
      0000187BC600218CE700298CE700218CE700296B520000000000000000000000
      0000000000000000000000000000000000000000000000000000BD846B00FFFF
      FF00FFFFFF0094636300F7EFDE00F7EFDE00F7E7CE00FFFFEF00EFD6B5009463
      5A00EFCEA500F7D6A500A5636B000000000000000000000000009C9C9C00BDBD
      BD00ADADAD00ADADAD00E7E7E700F7EFEF00EFEFEF00EFE7DE00D6D6D600CECE
      CE00B5B5B500949494000000000000000000AD7B6B009CC6C60042B5FF0031AD
      FF00319CFF001884FF0084BDF700FFFFEF00FFF7EF00FFEFDE00F7E7CE00EFD6
      B500EFC69C00DEB58C00A57B7B0000000000000000000000000000000000297B
      AD00399CFF00399CFF00399CFF00399CFF00298CE70039525200000000000000
      0000000000000000000000000000000000000000000000000000D6946B00FFFF
      FF00FFFFFF00B58C8400DEC6C600F7EFE700F7EFDE00FFFFD600DEBDA500AD7B
      7300F7D6AD00EFCEA500A5636B00000000000000000000000000000000009C9C
      9C00D6D6D600CECECE009C9C9C00BDBDBD00D6D6D600D6D6D600D6D6D600C6C6
      C600ADADAD00000000000000000000000000429CF70042A5FF0042ADFF0042B5
      FF0039A5FF002994FF001884FF008CC6F700FFFFEF00FFF7EF00FFEFDE00FFE7
      C600DEC6B500948C94009C7B8400000000000000000000000000000000002184
      C60042A5FF0042A5FF0042A5FF0042A5FF00399CF700315A6B00000000000000
      0000000000000000000000000000000000000000000000000000D6946B00FFFF
      FF00FFFFFF00D6BDBD00BD949400DEC6C600F7EFDE00DEC6B500B58C8400B58C
      7B00DECEB500B5AD9400A5636B00000000000000000000000000000000000000
      0000FFE7E700FFDECE00E7C6BD00E7C6BD00E7CEC600DED6CE00CECECE009494
      94000000000000000000000000000000000000000000429CFF0042A5FF0042AD
      FF0042B5FF0039A5FF002994FF001884FF008CC6F700FFFFEF00FFFFEF00D6D6
      D600737BAD007B739400000000000000000000000000000000006BA5C60042A5
      F7004AB5FF0052B5FF0052BDFF0052B5FF004AADFF0039739400000000000000
      0000000000000000000000000000000000000000000000000000DE9C7300FFFF
      FF00FFFFFF00FFFFFF00D6BDBD00B58C840094636300AD847B00CEA59C00A56B
      5A00A56B5A00A56B5A00A5636B00000000000000000000000000000000000000
      0000CE9C9C00FFDECE00FFCEBD00FFC6AD00FFBDA500FFAD9C00000000000000
      0000000000000000000000000000000000000000000000000000429CF70042A5
      FF0042ADFF0042ADFF0039A5FF002994FF001884FF0094C6FF00B5CEE7004A6B
      BD00526BA50000000000000000000000000000000000000000005294BD0042A5
      EF005ABDFF005ABDFF0052B5F7004AB5EF0052B5F70039738C00000000000000
      0000000000000000000000000000000000000000000000000000DE9C7300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700D6BDBD00A56B
      5A00E79C5200E78C3100B56B4A00000000000000000000000000000000000000
      0000CE9C9C00FFDECE00FFCEBD00FFC6AD00FFBDA500F7AD9400000000000000
      00000000000000000000000000000000000000000000000000000000000042A5
      FF0042ADFF0042B5FF0042ADFF00319CFF002994FF001884FF00316BE7003163
      C60000000000000000000000000000000000000000000000000063849C002173
      A5004A94C6006BADD60063ADF7004A9CE700216BA50000000000000000000000
      0000000000000000000000000000000000000000000000000000E7AD7B00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DEC6C600A56B
      5A00FFB55A00BD7B5A0000000000000000000000000000000000000000000000
      0000CE9C9C00FFDECE00FFCEBD00FFC6AD00FFBDA500F7AD9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000042A5FF0042ADFF0042B5FF0039ADFF003994F7001831B5003952DE000000
      0000000000000000000000000000000000000000000000000000000000002173
      A5006BADD6008CBDE70073BDE7005AADDE00316B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000E7AD7B00F7F7
      EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF00F7F7EF00D6BDBD00A56B
      5A00BD846B00000000000000000000000000000000000000000000000000CE9C
      9C00FFE7D600FFDECE00FFCEBD00FFC6AD00FFBDA500F7AD9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000042A5FF0042ADFF00000000000000000018109400394ADE000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006BA5BD004A94B5004A8CAD0063849C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E7AD7B00D694
      6B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00D6946B00A56B
      5A0000000000000000000000000000000000000000000000000000000000CE9C
      9C00CE9C9C00CE9C9C00CE9C9C00F7AD9C00F7AD9C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000018189C00394ADE000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063636B00525252000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C6B63009C6B
      63009C6B63009C6B63009C6B63009C6B63009C6B63009C6B63009C6B63009C6B
      63009C6B63009C6B6300A56B6B00000000000000000000000000000000000000
      00000000000063636B0094949400A5A5A5003131310000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF000080800000808000000000000000000000FF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000084840000848400008484008484
      84000000000000000000000000000000000000000000000000009C736B00FFE7
      C600F7DEB500F7D6AD00F7D69C00F7CE9400EFC68400EFC68400EFC68400EFC6
      8400EFC68400EFC684009C6B6300000000000000000000000000000000000000
      000063636B0094949400D6D6D600DEDEDE00ADADAD0052525200000000000000
      0000000000000000000000000000000000000000000000808000008080000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF000080800000000000000000000000000000000000848484000084
      840000848400008484008484840000848400C6FFFF0084FFFF0084FFFF000084
      84000000000000000000000000000000000000000000000000009C736B00F7E7
      C600F7DEBD00F7D6AD00EFCEA500EFCE9C00EFC69400EFC68400EFBD7B00EFBD
      7B00EFBD7B00EFBD7B009C6B6300000000000000000000000000000000006363
      6B0094949400D6D6D600D6D6D600DEDEDE00DEDEDE00ADADAD00313131000000
      0000000000000000000000000000000000000000000000000000008080000080
      80000080800000808000008080000080800000FFFF0000FFFF0000FFFF000080
      800000FFFF0000FFFF0000FFFF0000000000000000000000000000848400C6FF
      FF0084FFFF0084FFFF0000848400848484000084840000848400008484008484
      84000084840084848400000000000000000000000000000000009C736B00F7E7
      D600FFEFCE00F7DEBD00FFDEB500F7D6AD00EFCE9C00EFC69400EFC68400EFBD
      7B00EFBD7B00EFBD7B009C6B6300000000000000000000000000636363008484
      8400D6D6D600D6D6D600D6D6D600DEDEDE00DEDEDE00E7E7DE00ADADAD005252
      5200000000000000000000000000000000000000000000808000008080000080
      80000080800000808000008080000080800000FFFF0000FFFF000080800000FF
      FF0000FFFF000080800000FFFF00000000000000000000000000848484000084
      8400008484000084840084848400000000000000000000848400C6C6C600C6C6
      C600C6C6C6000084840000000000000000000000000000000000A5737300FFF7
      DE00948C8C00948C8C00948C8C00948C8C00E7C69C00EFCE9C00EFC69400EFC6
      8400EFBD7B00EFBD7B009C6B6300000000000000000063636B007B7B7B00ADAD
      AD00BDBDBD00BDBDBD00CECECE00D6D6D600DEDEDE00DEDEDE00E7E7E700ADAD
      AD003131310000000000000000000000000000808000000000000000000000FF
      FF0000FFFF0000FFFF00008080000080800000FFFF0000FFFF000080800000FF
      FF00000000000080800000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000084840000C6C60000C6
      C60000C6C6000084840000000000000000000000000000000000A57B7300FFFF
      F700313129006B7394001029A50021213900D6B58C00F7D6AD00EFCE9C00EFC6
      9400EFC68400EFBD7B009C6B6300000000007B7B7B0063636B00A5A5AD00A5A5
      AD00B5ADBD00BDBDBD00C6C6C600BDBDBD00949494007B7B7B005A525200D6D6
      D600BDBDBD005252520000000000000000000080800000808000008080000080
      80000080800000808000008080000080800000FFFF00008080000080800000FF
      FF0000FFFF0000FFFF0000FFFF000000000000000000005A0000005A0000005A
      0000005A0000005A0000005A0000005A0000005A000000848400C6C6C600C6C6
      C600C6C6C60000848400005A0000005A00000000000000000000AD847B00FFFF
      F70031313900637BE7007B94FF0010219C00DEC69C00FFDEB500EFCEA500EFCE
      9C00EFC69400EFC684009C6B63000000000084848C0052526300293163002931
      520042426B0063637B00BDC6C600CECECE00B5B5B500949CA5009C9CA500DEDE
      DE00EFEFEF00B5B5B5004A424A00000000000000000000000000008080000080
      800000000000000000000000000000000000000000000080800000FFFF000080
      80000080800000FFFF00000000000000000000000000005A0000008400000084
      000000C6000000C6000000C6000000C6000000C600000084840000C6C60000C6
      C60000C6C6000084840000840000005A00000000000000000000B58C7B00FFFF
      FF0042424200524A4A005A524A00182994006373D600C6B59C00F7D6B500EFCE
      A500EFCE9C00EFC694009C6B63000000000094949C0073849C007394CE007B9C
      CE006B8CC600526BAD002931840021316300526B9C003973A500EFEFEF00EFEF
      EF00EFEFEF00F7F7F700A5A5A50052525200000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000080800000FF
      FF0000FFFF0000000000000000000000000000000000005A00000084000000C6
      000084FF840084FF840084FF8400424242004242420000848400FFFFFF0084FF
      FF0084FFFF000084840000840000005A00000000000000000000BD8C7B00FFFF
      FF00FFFFFF00F7EFE700F7E7D600F7E7D600637BE700425AE700E7CEBD00F7D6
      AD00EFCEA500EFCE9C009C6B63000000000094949C008494AD008CADDE008CAD
      DE0094B5E7008CA5D6006384C6005A73BD006B7BBD0018217300EFEFEF00EFEF
      EF00EFEFEF00F7F7F700EFEFEF00A5A5A5000000000000000000000000000000
      000000FFFF00C0C0C000C0C0C000C0C0C000C0C0C00000000000000000000000
      00000000000000000000000000000000000000000000005A000000C60000C6FF
      C600C6FFC60084FF840042424200C6C6C600C6C6C60000848400008484000084
      84000084840084FF840000C60000005A00000000000000000000C6947B00FFFF
      FF00948C8C00948C8C00948C8C00948C8C00EFE7CE00C6BDDE00EFD6C600F7D6
      B500F7D6AD00E7C69C0094736B0000000000000000000000000084A5DE00738C
      BD00182173001018420052B5DE004294C6006384C6008CA5D600EFEFEF00EFEF
      EF00EFEFEF00F7F7F700DEE7DE00A5A5A500000000000000000000808000C0C0
      C0000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      00000000000000000000000000000000000000000000005A000000C60000C6FF
      C600C6FFC600C6FFC60042424200C6FFFF00C6C6C600C6C6C6004242420084FF
      840084FF840084FF840000C60000005A00000000000000000000CE9C8400FFFF
      FF0031312900A5A5A5005263AD0029314200D6CEBD00FFF7DE00FFEFCE00F7E7
      C600DECEAD00B5A58C00846B6300000000000000000000000000ADC6E7007BA5
      D6001821520021426B004A8CC600314A8C0084A5D600A5BDDE00EFEFEF00EFEF
      EF00F7F7F700F7F7F700A5A5A500000000000000000000000000000000000080
      800000808000FFFFFF00FFFFFF00FFFFFF000080800000808000008080000080
      80000080800000000000000000000000000000000000005A00000084000000C6
      0000C6FFC600C6FFC600C6FFC60042424200424242004242420084FF840084FF
      840084FF840000C6000000840000005A00000000000000000000CE9C8400FFFF
      FF0042424A007B94FF00426BFF0018297B00E7DEC600FFF7E700E7CEBD00A56B
      6B00A56B6B00A56B6B00A56B6B00000000000000000000000000000000006B73
      840052B5DE0052A5CE008CADDE00A5BDDE00DEDEDE00DEDEDE00EFEFEF00EFEF
      EF00DEDEDE009C9C9C0000000000000000000000000000000000000000000000
      0000008080000080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000080
      80000000000000000000000000000000000000000000005A0000008400000084
      000000C60000C6FFC600C6FFC600C6FFC600C6FFC60084FF840084FF840084FF
      840000C600000084000000840000005A00000000000000000000D6A58400FFFF
      FF0029292900636B84008C8C9C000821A500BDC6F700FFFFF700D6B5AD00A56B
      6B00E79C4A00E78C3100A56B6B000000000000000000000000006B7384002139
      630052A5CE00849CBD00A5BDDE00A5BDDE008C8C8C0094949400EFEFEF00EFEF
      EF009C9C9C000000000000000000000000000000000000000000000000000000
      00000080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00008080000080
      80000000000000000000000000000000000000000000005A0000005A0000005A
      0000005A0000005A0000005A0000005A0000005A0000005A0000005A0000005A
      0000005A0000005A0000005A0000005A00000000000000000000D6A58400FFFF
      FF00ADB5B50094949400949494008C9CC6004263FF009CB5FF00D6B5BD00A56B
      6B00F7AD5A00A56B6B000000000000000000000000006B73840021219C0052A5
      CE000000000000000000949494008C8C8C00F7F7F700E7E7DE00949494009494
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6A58400F7EF
      E700FFFFF700FFFFF700FFFFF700FFF7EF00CECEEF005A73EF00B5A5B500A56B
      6B00A56B6B0000000000000000000000000000000000BDB5EF001818AD000000
      0000000000000000000000000000949494009494940094949400949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6946B00D69C
      7B00D69C7B00D69C7B00CE947300C68C7300C68C7300C68C7300AD736B00A56B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F7FFDFDFDFFFDEDEDEFFFBFB
      FBFF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00000000000000000000000000008C6363004242420000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C0000000000000000000898989FF676768FF7B6767FFA9A9
      A9FFFBFBFBFF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF0000000000000000000000000000
      00008C6363009A666600B9666600BB6868004242420000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000052638C00314A7B0031395A0000000000000000005A6B
      8C003163BD0031395A000000000000000000808000000000000000000000FFFF
      FF00FFFFFF00C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000008080
      8000C0C0C000000000000000000000000000667986FF4573C3FF8B7FA3FF7865
      65FFA9A9A9FFFBFBFBFF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF00000000000000008C6363009A66
      6600C66A6B00D2686900D2686900C3686900424242009A6666009A6666009A66
      66009A6666009A6666009A6666000000000000000000000000006BADFF00639C
      FF00427BE700214A94005A94FF00427BEF00294A940021428400315ABD003163
      BD00396BD6003163C60031395A0000000000808000008080000080800000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000000000008080
      80008080800000000000000000000000000055B4FEFF49AFFFFF4474C4FF8B7F
      A3FF786565FFA9A9A9FFFBFBFBFF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF00000000000000009A666600D16D
      6E00D16D6E00D16D6E00CF6C6E00C76A6D0042424200C0797A00DF898A00F293
      9400F5A7A500F5A7A5009A666600000000000000000000000000396BC6005284
      E700396BC60029529C00A5E7FF006BA5FF00315ABD00315ABD002952A5002142
      8C0021428C002952A500526B9C0000000000808000008080000000000000FFFF
      FF00FFFFFF00C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0080808000000000000000000000000000000000FF55B4FEFF49AFFFFF4475
      C6FF8B7FA3FF786565FFA9A9A9FFFBFBFBFF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF00000000000000009A666600D16D
      6E00D16D6E00D4707100D2707200CC6E71004242420000960000009600000096
      000000960000F5A7A5009A66660000000000000000000000000063A5FF005A94
      FF00427BEF00315AAD004A84F7004A84F7003973E7003973E7003163C6002952
      AD001831630018294A00424A6B0000000000808000008080000080800000C0C0
      C000C0C0C00080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000000000000000000000000000000000FF000000FF55B4FEFF49AF
      FFFF4475C6FF8B7FA3FF816E6EFFE8E8E8FFF5F5F5FFDCDCDCFFD5D5D5FFD7D7
      D7FFEFEFEFFFFEFEFEFF000000FF000000FF00000000000000009A666600D572
      7300D5727300D9757600D8767700D07275004242420000960000009600000096
      000000960000F5A7A5009A66660000000000000000000000000084C6FF0073AD
      FF004A84F700315ABD004A84FF004A84F700427BF700427BEF003163CE00295A
      B5001839730018294A000000000000000000808000008080000000000000FFFF
      FF00FFFFFF000000000000000000C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000FF000000FF000000FF55B4
      FEFF49AFFFFF4475C6FF6C6C6CFF777777FF8D6D6DFF9A6767FFC69393FFA47E
      7EFF615E5EFFA7A7A7FFF9F9F9FF000000FF00000000000000009A666600E37D
      7E00E37D7E00E37D7E00E6808100D37476004242420000960000008000000080
      000000800000F5A7A5009A666600000000000000000000000000396BC6005284
      E700396BC6002952AD00528CFF004A8CFF006BA5FF005A94FF00396BD600295A
      B50018316B0018294A000000000000000000808000008080000080800000C0C0
      C000C0C0C000C0C0C000FFFF0000FF00000080808000C0C0C000C0C0C000C0C0
      C000C0C0C000000000000000000000000000000000FF000000FF000000FF0000
      00FF52B1FEFFBDBDBDFF857B7BFFD8AA91FFFFEBBCFFFFFDD2FFFFFFD6FFFFFF
      DAFFF2E8C9FF856666FF999999FFFBFBFBFF00000000000000009A666600F087
      8800E9818200EC969700FADCDC00D8888A004242420000800000008000000064
      000000640000F5A7A5009A66660000000000000000000000000094D6FF007BB5
      FF00528CFF00315ABD005294FF005A9CFF0094CEFF006BA5FF00396BD600295A
      B50018316300293952000000000000000000808000008080000000000000FFFF
      FF00FFFFFF00C0C0C000FFFFFF00FFFF0000FF000000C0C0C000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FFD5D5D5FFE3B194FFFFFCD0FFFFF1BEFFFFFFD4FFFFFFE3FFFFFF
      ECFFFFFFFFFFFAF7E7FF655555FFD5D5D5FF00000000000000009A666600F087
      8800EE868700F0999A00FFFFFF00DA888A0042424200FACCAA00F7B58400F7B5
      8400F7B58400F5A7A5009A666600000000000000000000000000396BC6005284
      E700396BC600294A9C005A9CFF0063ADFF009CD6FF0063A5FF003163C6002952
      A50031395A00000000000000000000000000808000008080000080800000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FFFF0000FF00000080808000C0C0
      C000C0C0C000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FFC79D9DFFFFE8BCFFFFE2AFFFFFF6C3FFFFFFD9FFFFFFEBFFFFFF
      FAFFFFFFFCFFFFFFDDFFB79085FF909090FF00000000000000009A666600F18B
      8C00F48E8F00F28B8C00F48C8D00DC7F800042424200FACCAA00FBD6BB00FBD6
      BB00FBD6BB00F5A7A5009A6666000000000000000000000000009CDEFF007BBD
      FF00528CFF00315ABD00528CFF004A84FF004A7BDE00427BE700315ABD00294A
      940000000000000000000000000000000000808000008080000000000000FFFF
      FF00FFFFFF00C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFF0000FF000000C0C0
      C000FFFFFF00000000000000000000000000000000FF000000FF000000FF0000
      00FFFEFEFEFFD6A99CFFFFFACAFFFFDEABFFFFF3C0FFFFFFD6FFFFFFE5FFFFFF
      EEFFFFFFEBFFFFFFDCFFEDE3BAFF6E6E6EFF00000000000000009A666600F18B
      8C00F7909100F7919200F18D8E00E085850042424200FACCAA00FBD6BB00FBD6
      BB00FBD6BB00F5A7A5009A666600000000000000000000000000000000000000
      000000000000000000006BADFF0073ADFF00295AB50021397300395284000000
      000000000000000000000000000000000000808000008080000080800000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000FFFF0000FF00
      000080808000000000000000000000000000000000FF000000FF000000FF0000
      00FF000000FFE4BFA5FFFFF9C6FFFFD7A4FFFFEAB7FFFFFECCFFFFFFD9FFFFFF
      DFFFFFFFDDFFFFFFD2FFFFF3C0FF7D7D7DFF00000000000000009A666600F18B
      8C00F9949500FA949500F3919200E388890042424200FACCAA00FBD6BB00FBD6
      BB00FBD6BB00F5A7A5009A666600000000000000000000000000000000000000
      000000000000526B9C009CDEFF006BA5FF00294A9400394A6B00000000000000
      000000000000000000000000000000000000808000008080000000000000FFFF
      FF00FFFFFF00C0C0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      0000FF000000808080000000000000000000000000FF000000FF000000FF0000
      00FF000000FFCEA099FFFFFDD1FFFFE3B9FFFFDBABFFFFF2BFFFFFFAC7FFFFFF
      CDFFFFFDCAFFFFFBC9FFDAB797FFB0B0B0FF00000000000000009A666600F18B
      8C00F9909200FC999A00F9969700E78C8D0042424200FACCAA00FBD6BB00FBD6
      BB00FBD6BB00F5A7A5009A666600000000000000000000000000000000000000
      0000000000007BA5DE009CDEFF004A84F7002139630000000000000000000000
      000000000000000000000000000000000000808000008080000080800000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000FFFF0000FF0000008080800000000000000000FF000000FF000000FF0000
      00FF000000FFE7D3D3FFFFF1C2FFFFFFFFFFFFF9EDFFFFDAA8FFFFE2AFFFFFE5
      B2FFFFE7B4FFFFE8B9FF986B6BFFEFEFEFFF00000000000000009A6666009A66
      6600E49A9800F9909200FF9D9E00EB8F900042424200FACCAA00FBD6BB00FBD6
      BB00FBD6BB00F5A7A5009A666600000000000000000000000000000000000000
      0000000000007BA5DE0094CEFF004A84F700213963004A525A00000000000000
      0000000000000000000000000000000000000000000080800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000FFFF0000FF00000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FFBF8F8FFFFFFFFFFFFFFCEDFFFFF8D4FFFFDDAAFFFFF5
      C2FFFFE6BAFFC08D81FFD8D8D8FF000000FF0000000000000000000000000000
      00009A666600B0717200D7868700DA888800424242009A6666009A6666009A66
      66009A6666009A6666009A666600000000000000000000000000000000000000
      0000000000009CDEFF0063A5FF005294FF003963CE00294A9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFF000000000000000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FFC5A2A2FFD8B89CFFFFE8B5FFFFE2AFFFEDC6
      A3FFB78787FFEAEAEAFF000000FF000000FF0000000000000000000000000000
      000000000000000000009A6666009A6666004242420000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007BA5DE004A84F7003963C600526B9C00000000000000
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
      000000000000C0C0C0008080800000000000000000000000000000FFFF0000FF
      FF0000000000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000FF000000000000000000000000000000F6F6F6FFBABABAFFA0A0A0FFA0A0
      A0FFA0A0A0FFACACACFFC9C9C9FFE9E9E9FFFEFEFEFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      000000000000C0C0C000C0C0C00080808000000000000000000000FFFF0000FF
      FF00C0C0C000C0C0C000C0C0C000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000FFFFFF000000000000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000FF00000000000000FFFFFF00FFFF
      FF0080808000000000000000000000000000B9562DFFD14B26FFE8583FFFF963
      50FFFD6554FFD24B26FFA53F19FF65554FFF989898FF959595FF7C7C7CFF7070
      70FF707070FF7D7D7DFFBBBBBBFFFEFEFEFF000000000000000080800000C0C0
      C000C0C0C000000000000000000000000000808080000000000000FFFF0000FF
      FF00C0C0C000FFFFFF00C0C0C000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF008080
      800000000000000000000000000000000000C34317FFEF5D46FFFD725CFFFD7D
      64FFC85A2CFFD38653FFFD6B58FFEC5B42FF40B340FF2F922CFF52C252FF4ABE
      4AFF3BB73BFF21A921FF596659FFF5F5F5FF0000000080800000C0C0C000C0C0
      C000C0C0C00080800000C0C0C000808000000000000080808000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FF000000FFFFFF00FF00
      0000FF000000FF000000FF000000FF0000000000000000000000FFFFFF00C0C0
      C000C0C0C000C0C0C0000000000000000000D4977DFFFD6B58FFFD866AFFEB80
      59FFFFD9A6FFFFDAA7FFFD8368FFFD6655FF67CD67FFBFD9ACFF479842FF6ACE
      6AFF56C456FF39B639FF6B7E6BFFFDFDFDFF0000000000000000808000008080
      0000C0C0C000C0C0C000C0C0C000C0C0C0008080000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000000000FFFF
      FF00FFFFFF00C0C0C000000000000000000000000000C9653FFFF98C6BFFE99A
      7AFFBF8C84FFFFBF91FFFD8E70FFBA4C1AFF81D981FFFFFFFCFFFFFFFFFF67C0
      67FF69CD69FF2E9D2EFFDDDDDDFF0000000000000000FFFF0000000000008080
      000080800000C0C0C00000FF000000FF00008080000080800000000000008080
      800000000000C0C0C000C0C0C000000000000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C00000000000EFEFEFFF4A4A4AFF020202FF0C25
      7EFF102F95FF06167BFF645C59FF379B37FF92E192FFDFD1BCFF458BAFFF9FB0
      A4FF43A443FFD6D6D6FF000000000000000000000000FFFF0000808000000000
      00008080000080800000808000008080000080800000C0C0C000808000000000
      000080808000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FF000000FFFFFF00FF00
      0000FF000000FF000000FF000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000171717FF131313FF0E2B6AFF1949
      AFFF1A4DB3FF1949AFFF081D6BFFBFBFBFFF91B0C0FF2C92F0FF2D93F2FF2B91
      EFFF125F88FFA4A4A4FFFEFEFEFF000000000000000000000000FFFF000000FF
      000000000000808000008080000080800000C0C0C000C0C0C000C0C0C0008080
      0000000000008080800000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF000000000000000000191919FF232323FF2060C6FF2368
      CEFF246AD0FF2266CCFF10429EFFA3A3A3FF288DDFFF3CA1FFFF3CA1FFFF3CA1
      FFFF379DFFFF5A6063FFEFEFEFFF00000000000000000000000000000000FFFF
      000000FF0000000000008080000080800000C0C0C000C0C0C000C0C0C00000FF
      0000808000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000292929FF363636FF2162B5FF2F8D
      F3FF3295FBFF2E8BF1FF1C63C0FFA6A6A6FF44AAFFFF4AB0FFFF4BB1FFFF49AF
      FFFF44A9FFFF1F5F81FFDADADAFF000000000000000000000000000000000000
      0000FFFF000000FF0000000000008080000080800000C0C0C000C0C0C0008080
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FF000000FFFFFF00FF00
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000001C1C1CFF454545FF2C2C2CFF1641
      9EFF2368DDFF3694F7FF1258A2FFD1D1D1FF50B6FFFF56BCFFFF57BDFFFF55BB
      FFFF4EB4FFFF197EBAFFD4D4D4FF000000000000000000000000C0C0C0000000
      000000000000FFFF000000FF0000000000008080000000FF0000808000000000
      0000FFFF00008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000DEDEDEFF515151FF666666FF9B9B
      9BFF717171FF2E2E2EFF3A3F43FFF8F8F8FF1C82B9FF2D8ABCFF308ABAFF1D83
      CCFF2587CBFF176389FFECECECFF0000000000000000C0C0C000C0C0C000C0C0
      C0000000000000000000FFFF000000FF00000000000080800000000000008080
      0000FFFF00008080800000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      000000000000000000000000000000000000FFFFFF00FF000000FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C0000000
      00000000000000000000000000000000000000000000BDBDBDFF636363FF9393
      93FF6D6D6DFF2F2F2FFFF2F2F2FF000000007CAFC8FF61AFDBFF84C0E4FF9ECC
      E6FF3992C2FFB0B6B9FFFEFEFEFF000000000000000000000000C0C0C0000000
      0000000000000000000000000000FFFF000000FF00000000000080800000FFFF
      0000808080000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FF000000FF000000FF00
      0000FF000000FF000000FFFFFF00FFFFFF00FFFFFF00C0C0C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007CAFC8FF5CA1C4FF3D8E
      B8FFC7D3DAFFFEFEFEFF00000000000000000000000000000000000000000000
      0000C0C0C000C0C0C0000000000000000000FFFF000080800000FFFF00008080
      8000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C000000000000000000000000000FFFF0000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000600000000100010000000000000300000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C000FE7FFFFF0000C000FC3F80010000
      C000FC3F80010000C000C43F80010000C001803F80010000C001800180010000
      C001F00080010000C001800180010000C001803F80010000C001C43F80010000
      C001FC3F80010000C001FC3F80010000C001E43F80010000C003C03380010000
      C007C00380010000C00FC007FFFF0000C001FDC7F0FFFFFFC001F003E00FFFFF
      8001C001C003C00FC00100018001C00FC00100010001C00FC00100010001E01F
      C00100010001F03FC00180010001F07FC001C0030001E03FC001E0070001E03F
      C001F00F8003C03FC001F03FC007C03FC001F03FE00FC07FC003F03FF01FE07F
      C007E03FF99FF0FFC00FE07FFF9FFFFFFCFFFFFFFFFFC001F87FC003FE0FC001
      F03F8001C00FC001E01F8001C003C001C00F0001C183C00180070001FF83C001
      000300018000C001000180018000C001000080038000C0010000800F8000C001
      C000800F8000C001C001C0078000C001E003E0078000C001C007E0078000C003
      8C0FF81FFFFFC0079E1FFFFFFFFFC00F9FFF0FFFFE7FFFFF000107FFF07FFC63
      000103FFC001C001000101FFC001C001000180FFC001C0010001C003C001C003
      0001E001C001C0030001F000C001C0030001F800C001C0070001F800C001C00F
      0001F000C001FC1F0001F800C001F83F0001F800C001F87F0001F800C001F83F
      0001FC01F001F83FFFF8FE03FC7FFC3FFFFFF7FFC003FFFFFFFFE1C18003FE03
      007FC08080030007000080408003000700000039800300030000801F80030003
      800180098003000100038001800300010001C003800300030001E00380030001
      0001F00780030001000188038003000300018C038003001F81018E078007001F
      FF83F30F800F003FFFFFF39F801F007F00000000000000000000000000000000
      000000000000}
  end
  object IBSQL3: TIBSQL
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 288
  end
end
