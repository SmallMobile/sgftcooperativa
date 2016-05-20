object FrmCierreSucursal: TFrmCierreSucursal
  Left = 476
  Top = 289
  Width = 384
  Height = 259
  Caption = 'Comprobante Automatico Sucursales'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object CdMovimiento: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID_AGENCIA'
        DataType = ftInteger
      end
      item
        Name = 'AGENCIA'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ID_CAJA'
        DataType = ftSmallint
      end
      item
        Name = 'ORIGEN_MOVIMIENTO'
        DataType = ftSmallint
      end
      item
        Name = 'ID_TIPO_CAPTACION'
        DataType = ftSmallint
      end
      item
        Name = 'ID_TIPO_MOVIMIENTO'
        DataType = ftSmallint
      end
      item
        Name = 'EFECTIVO_DB'
        DataType = ftCurrency
      end
      item
        Name = 'CHEQUE_DB'
        DataType = ftCurrency
      end
      item
        Name = 'EFECTIVO_CR'
        DataType = ftCurrency
      end
      item
        Name = 'CHEQUE_CR'
        DataType = ftCurrency
      end
      item
        Name = 'CODIGO'
        DataType = ftString
        Size = 18
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 120
    Data = {
      5F0100009619E0BD01000000180000000B0000000000030000005F010A49445F
      4147454E4349410400010000000000074147454E434941010049000000010005
      57494454480200020032000749445F43414A410200010000000000114F524947
      454E5F4D4F56494D49454E544F02000100000000001149445F5449504F5F4341
      50544143494F4E02000100000000001249445F5449504F5F4D4F56494D49454E
      544F02000100000000000B454645435449564F5F444208000400000001000753
      5542545950450200490006004D6F6E657900094348455155455F444208000400
      0000010007535542545950450200490006004D6F6E6579000B45464543544956
      4F5F4352080004000000010007535542545950450200490006004D6F6E657900
      094348455155455F435208000400000001000753554254595045020049000600
      4D6F6E65790006434F4449474F01004900000001000557494454480200020012
      000000}
    object CdMovimientoID_AGENCIA: TIntegerField
      FieldName = 'ID_AGENCIA'
    end
    object CdMovimientoAGENCIA: TStringField
      FieldName = 'AGENCIA'
      Size = 50
    end
    object CdMovimientoID_CAJA: TSmallintField
      FieldName = 'ID_CAJA'
    end
    object CdMovimientoORIGEN_MOVIMIENTO: TSmallintField
      FieldName = 'ORIGEN_MOVIMIENTO'
    end
    object CdMovimientoID_TIPO_CAPTACION: TSmallintField
      FieldName = 'ID_TIPO_CAPTACION'
    end
    object CdMovimientoID_TIPO_MOVIMIENTO: TSmallintField
      FieldName = 'ID_TIPO_MOVIMIENTO'
    end
    object CdMovimientoEFECTIVO_DB2: TCurrencyField
      FieldName = 'EFECTIVO_DB'
    end
    object CdMovimientoCHEQUE_DB: TCurrencyField
      FieldName = 'CHEQUE_DB'
    end
    object CdMovimientoEFECTIVO_CR: TCurrencyField
      FieldName = 'EFECTIVO_CR'
    end
    object CdMovimientoCHEQUE_CR: TCurrencyField
      FieldName = 'CHEQUE_CR'
    end
    object CdMovimientoCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 18
    end
  end
  object CDcomision: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'comision'
        DataType = ftCurrency
      end
      item
        Name = 'agencia'
        DataType = ftInteger
      end
      item
        Name = 'id_identificacion'
        DataType = ftInteger
      end
      item
        Name = 'id_persona'
        DataType = ftString
        Size = 15
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 104
    Top = 8
    Data = {
      880000009619E0BD010000001800000004000000000003000000880008636F6D
      6973696F6E080004000000010007535542545950450200490006004D6F6E6579
      00076167656E63696104000100000000001169645F6964656E74696669636163
      696F6E04000100000000000A69645F706572736F6E6101004900000001000557
      49445448020002000F000000}
    object CDcomisioncomision: TCurrencyField
      FieldName = 'comision'
    end
    object CDcomisionagencia: TIntegerField
      FieldName = 'agencia'
    end
    object CDcomisionid_identificacion: TIntegerField
      FieldName = 'id_identificacion'
    end
    object CDcomisionid_persona: TStringField
      FieldName = 'id_persona'
      Size = 15
    end
    object CDcomisionvalor: TAggregateField
      FieldName = 'valor'
      ProviderFlags = [pfInWhere]
      Active = True
      currency = True
      Expression = 'sum(comision)'
    end
  end
end
