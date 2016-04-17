object frmXml: TfrmXml
  Left = 233
  Top = 132
  Width = 686
  Height = 521
  Caption = 'Generar Xml'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 34
    Width = 58
    Height = 13
    Caption = 'Documento '
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 82
    Height = 13
    Caption = 'Tipo Documento '
  end
  object Label3: TLabel
    Left = 8
    Top = 296
    Width = 46
    Height = 13
    Caption = 'En Tabla:'
  end
  object EdDocumento: TEdit
    Left = 70
    Top = 32
    Width = 171
    Height = 21
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 252
    Top = 6
    Width = 109
    Height = 23
    Caption = '&Iniciar Proceso'
    TabOrder = 1
    OnClick = BitBtn1Click
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
  object Panel1: TPanel
    Left = 5
    Top = 58
    Width = 196
    Height = 215
    TabOrder = 2
    object CheckBox1: TCheckBox
      Left = 5
      Top = 2
      Width = 164
      Height = 17
      Caption = 'Procesar cap$maestro'
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 5
      Top = 18
      Width = 164
      Height = 17
      Caption = 'Procesar cap$maestrotitular'
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 5
      Top = 34
      Width = 188
      Height = 17
      Caption = 'Procesar cap$maestrosaldoinicial'
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 5
      Top = 50
      Width = 188
      Height = 17
      Caption = 'Procesar cap$maestrosaldosmes'
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 5
      Top = 66
      Width = 188
      Height = 17
      Caption = 'Procesar cap$maestrosapertura'
      TabOrder = 4
    end
    object CheckBox6: TCheckBox
      Left = 5
      Top = 82
      Width = 188
      Height = 17
      Caption = 'Procesar cap$extracto'
      TabOrder = 5
    end
    object CheckBox7: TCheckBox
      Left = 5
      Top = 98
      Width = 188
      Height = 17
      Caption = 'Procesar cap$tablaliquidacion'
      TabOrder = 6
    end
    object CheckBox8: TCheckBox
      Left = 5
      Top = 114
      Width = 188
      Height = 17
      Caption = 'Procesar cap$tablaliquidacioncon'
      TabOrder = 7
    end
    object CheckBox9: TCheckBox
      Left = 5
      Top = 130
      Width = 188
      Height = 17
      Caption = 'Procesar cap$saldosmes'
      TabOrder = 8
    end
    object CheckBox10: TCheckBox
      Left = 5
      Top = 146
      Width = 148
      Height = 17
      Caption = 'Procesar gen$persona'
      TabOrder = 9
    end
    object CheckBox11: TCheckBox
      Left = 5
      Top = 162
      Width = 148
      Height = 17
      Caption = 'Procesar gen$direccion'
      TabOrder = 10
    end
    object CheckBox12: TCheckBox
      Left = 5
      Top = 178
      Width = 148
      Height = 17
      Caption = 'Procesar gen$referencias'
      TabOrder = 11
    end
    object CheckBox13: TCheckBox
      Left = 5
      Top = 194
      Width = 148
      Height = 17
      Caption = 'Procesar gen$beneficiario'
      TabOrder = 12
    end
  end
  object EdTipo: TJvIntegerEdit
    Left = 96
    Top = 6
    Width = 121
    Height = 21
    Alignment = taRightJustify
    ReadOnly = False
    TabOrder = 3
    Value = 0
    MaxValue = 0
    MinValue = 0
    HasMaxValue = False
    HasMinValue = False
  end
  object BitBtn2: TBitBtn
    Left = 256
    Top = 32
    Width = 105
    Height = 25
    Caption = 'Insertar'
    TabOrder = 4
    OnClick = BitBtn2Click
  end
  object Memo1: TMemo
    Left = 208
    Top = 56
    Width = 465
    Height = 425
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object st1: TStaticText
    Left = 5
    Top = 316
    Width = 196
    Height = 25
    AutoSize = False
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvSpace
    BiDiMode = bdRightToLeftNoAlign
    BorderStyle = sbsSunken
    Color = clBtnHighlight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentBiDiMode = False
    ParentColor = False
    ParentFont = False
    TabOrder = 6
  end
  object xml: TJvSimpleXml
    Left = 280
    Top = 64
  end
  object IdBase64Decoder1: TIdBase64Decoder
    Left = 384
    Top = 48
  end
  object CDSCuentas: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 432
    Top = 24
    Data = {
      720000009619E0BD01000000180000000400000000000300000072000B544950
      4F5F4355454E544104000100000000000D4E554D45524F5F4355454E54410400
      0100000000000D4E5F5449504F5F4355454E544104000100000000000F4E5F4E
      554D45524F5F4355454E544104000100000000000000}
    object CDSCuentasTIPO_CUENTA: TIntegerField
      FieldName = 'TIPO_CUENTA'
    end
    object CDSCuentasNUMERO_CUENTA: TIntegerField
      FieldName = 'NUMERO_CUENTA'
    end
    object CDSCuentasN_TIPO_CUENTA: TIntegerField
      FieldName = 'N_TIPO_CUENTA'
    end
    object CDSCuentasN_NUMERO_CUENTA: TIntegerField
      FieldName = 'N_NUMERO_CUENTA'
    end
  end
end
