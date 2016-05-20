object FrmReportes: TFrmReportes
  Left = 143
  Top = 138
  Width = 544
  Height = 354
  Caption = 'reportes'
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
  object a: TJvFloatEdit
    Left = 104
    Top = 48
    Width = 121
    Height = 21
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
    TabOrder = 0
    OnKeyPress = aKeyPress
  end
  object GridColocaciones: TXStringGrid
    Left = 0
    Top = 32
    Width = 536
    Height = 169
    ColCount = 11
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 1
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
      187)
  end
  object Button1: TButton
    Left = 88
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 296
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object IBQTabla: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '       ')
    Left = 144
    Top = 286
  end
  object IBQuery1: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    Left = 184
    Top = 255
  end
  object IBCuotas: TIBSQL
    Database = frmdata.IBDatabase2
    ParamCheck = True
    Transaction = frmdata.IBTransaction2
    Left = 120
    Top = 286
  end
  object IBGrupo3: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    Left = 352
    Top = 286
  end
  object IBextracto: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    Left = 96
    Top = 280
  end
  object IBbarrido: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 72
    Top = 280
  end
  object IBConsecB: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    Left = 32
    Top = 264
  end
  object IBcomprobante: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    Left = 176
    Top = 288
  end
end
