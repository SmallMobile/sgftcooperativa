object FrmCreditosFianzas: TFrmCreditosFianzas
  Left = 81
  Top = 200
  Width = 553
  Height = 243
  AutoSize = True
  BorderIcons = [biSystemMenu]
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
    Width = 545
    Height = 177
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 2
      Top = 0
      Width = 535
      Height = 169
      DataSource = DScredito
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
          FieldName = 'colocacion'
          Title.Caption = 'Colocaci'#243'n'
          Width = 91
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor'
          Title.Caption = 'Saldo Inicial'
          Width = 105
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'saldo'
          Title.Caption = 'Saldo Actual'
          Width = 106
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha'
          Title.Caption = 'Fecha Interes'
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'estado'
          Title.Caption = 'Estado'
          Width = 100
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 177
    Width = 169
    Height = 32
    Color = clOlive
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 43
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Cerrar'
      TabOrder = 0
      OnClick = BitBtn1Click
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
    Left = 170
    Top = 177
    Width = 375
    Height = 32
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Label1: TLabel
      Left = 12
      Top = 8
      Width = 187
      Height = 13
      Caption = 'Total Saldo de Cr'#233'ditos Vigentes'
    end
    object valor: TJvCurrencyEdit
      Left = 205
      Top = 4
      Width = 163
      Height = 21
      Alignment = taRightJustify
      ReadOnly = False
      TabOrder = 0
      HasMaxValue = False
      HasMinValue = False
    end
  end
  object CDcredito: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 376
    Top = 48
    Data = {
      A60000009619E0BD010000001800000005000000000003000000A6000A636F6C
      6F636163696F6E01004900000001000557494454480200020014000576616C6F
      72080004000000010007535542545950450200490006004D6F6E657900057361
      6C646F080004000000010007535542545950450200490006004D6F6E65790005
      666563686104000600000000000665737461646F010049000000010005574944
      54480200020032000000}
    object CDcreditocolocacion: TStringField
      DisplayWidth = 19
      FieldName = 'colocacion'
    end
    object CDcreditovalor: TCurrencyField
      DisplayWidth = 20
      FieldName = 'valor'
    end
    object CDcreditosaldo: TCurrencyField
      DisplayWidth = 19
      FieldName = 'saldo'
    end
    object CDcreditofecha: TDateField
      DisplayWidth = 17
      FieldName = 'fecha'
    end
    object CDcreditoestado: TStringField
      DisplayWidth = 23
      FieldName = 'estado'
      Size = 50
    end
  end
  object DScredito: TDataSource
    DataSet = CDcredito
    Left = 456
    Top = 24
  end
end
