object FrmEjemplo: TFrmEjemplo
  Left = 139
  Top = 175
  Width = 544
  Height = 375
  Caption = 'FrmEjemplo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BitBtn1: TBitBtn
    Left = 160
    Top = 56
    Width = 129
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Memo1: TMemo
    Left = 256
    Top = 152
    Width = 185
    Height = 33
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object texto: TEdit
    Left = 256
    Top = 192
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "gen$persona".FECHA_EXPEDICION,'
      '  "gen$persona".NOMBRE,'
      '  "gen$persona".PRIMER_APELLIDO,'
      '  "gen$persona".SEGUNDO_APELLIDO,'
      '  "gen$persona".FECHA_NACIMIENTO,'
      '  "gen$persona".LUGAR_NACIMIENTO,'
      '   "gen$persona".ID_PERSONA'
      'FROM'
      '  "gen$persona"'
      'WHERE'
      '  ("gen$persona".ID_PERSONA = :id)')
    Left = 72
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object tcpcliente: TIdTCPClient
    Port = 0
    Left = 72
    Top = 96
  end
end
