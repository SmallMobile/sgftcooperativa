object FrmValidaEmitidos: TFrmValidaEmitidos
  Left = 469
  Top = 182
  Width = 463
  Height = 306
  Caption = 'Calcular CDATs'
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
    Left = 16
    Top = 8
    Width = 68
    Height = 13
    Caption = 'Monto M'#237'nimo'
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 63
    Height = 13
    Caption = 'Identificaci'#243'n'
  end
  object btnProcesar: TButton
    Left = 288
    Top = 8
    Width = 161
    Height = 25
    Caption = 'Procesar'
    TabOrder = 0
    OnClick = btnProcesarClick
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 96
    Width = 449
    Height = 120
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object btnGeneraExcel: TButton
    Left = 288
    Top = 40
    Width = 161
    Height = 25
    Caption = 'Generar Excel'
    TabOrder = 2
    OnClick = btnGeneraExcelClick
  end
  object Button3: TButton
    Left = 224
    Top = 69
    Width = 75
    Height = 25
    Caption = 'Buscar'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 80
    Top = 70
    Width = 137
    Height = 21
    TabOrder = 4
  end
  object fecha: TDateTimePicker
    Left = 96
    Top = 32
    Width = 121
    Height = 21
    CalAlignment = dtaLeft
    Date = 40178.4073107986
    Time = 40178.4073107986
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 5
  end
  object btnTotalAExcel: TButton
    Left = 8
    Top = 216
    Width = 129
    Height = 25
    Caption = 'Total de CDAT a Excel'
    TabOrder = 6
    OnClick = btnTotalAExcelClick
  end
  object EdMonto: TJvCurrencyEdit
    Left = 96
    Top = 8
    Width = 121
    Height = 21
    Alignment = taRightJustify
    ReadOnly = False
    TabOrder = 7
    Value = 5000000
    HasMaxValue = False
    HasMinValue = False
  end
  object IBSelect: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'select DISTINCT idpersona from "dian$cdat"')
    Left = 328
    Top = 48
  end
  object IBConsulta: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      
        'select * from "dian$cdat" where IDPERSONA = :IDPERSONA AND IDIDE' +
        'NTIFICACION = :IDIDENTIFICACION')
    Left = 288
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IDPERSONA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IDIDENTIFICACION'
        ParamType = ptUnknown
      end>
  end
  object CdFechas: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'VALOR'
        DataType = ftCurrency
      end
      item
        Name = 'IDPERSONA'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'FECHAV'
        DataType = ftDate
      end
      item
        Name = 'IDIDENTIFICACION'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 304
    Top = 192
    Data = {
      820000009619E0BD01000000180000000400000000000300000082000556414C
      4F52080004000000010007535542545950450200490006004D6F6E6579000949
      44504552534F4E410100490000000100055749445448020002000F0006464543
      48415604000600000000001049444944454E54494649434143494F4E04000100
      000000000000}
    object CdFechasVALOR: TCurrencyField
      FieldName = 'VALOR'
    end
    object CdFechasIDPERSONA: TStringField
      FieldName = 'IDPERSONA'
      Size = 15
    end
    object CdFechasFECHAV: TDateField
      FieldName = 'FECHAV'
    end
    object CdFechasIDIDENTIFICACION: TIntegerField
      FieldName = 'IDIDENTIFICACION'
    end
  end
  object DataSource1: TDataSource
    DataSet = CdFechas
    Left = 136
    Top = 184
  end
  object CDDATOS: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'NUMERO'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'IDPERSONA'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'IDIDENTIFICACION'
        DataType = ftInteger
      end
      item
        Name = 'INICIAL'
        DataType = ftCurrency
      end
      item
        Name = 'INVERSION'
        DataType = ftCurrency
      end
      item
        Name = 'INTERES'
        DataType = ftCurrency
      end
      item
        Name = 'SALDO'
        DataType = ftCurrency
      end
      item
        Name = 'FECHAA'
        DataType = ftDate
      end
      item
        Name = 'FECHAV'
        DataType = ftDate
      end
      item
        Name = 'ESTADO'
        DataType = ftString
        Size = 15
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 72
    Top = 184
    Data = {
      350100009619E0BD01000000180000000A0000000000030000003501064E554D
      45524F0100490000000100055749445448020002001E00094944504552534F4E
      410100490000000100055749445448020002000F001049444944454E54494649
      434143494F4E040001000000000007494E494349414C08000400000001000753
      5542545950450200490006004D6F6E65790009494E56455253494F4E08000400
      0000010007535542545950450200490006004D6F6E65790007494E5445524553
      080004000000010007535542545950450200490006004D6F6E6579000553414C
      444F080004000000010007535542545950450200490006004D6F6E6579000646
      4543484141040006000000000006464543484156040006000000000006455354
      41444F0100490000000100055749445448020002000F000000}
    object CDDATOSNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 30
    end
    object CDDATOSIDPERSONA: TStringField
      FieldName = 'IDPERSONA'
      Size = 15
    end
    object CDDATOSIDIDENTIFICACION: TIntegerField
      FieldName = 'IDIDENTIFICACION'
    end
    object CDDATOSINICIAL: TCurrencyField
      FieldName = 'INICIAL'
    end
    object CDDATOSINVERSION: TCurrencyField
      FieldName = 'INVERSION'
    end
    object CDDATOSINTERES: TCurrencyField
      FieldName = 'INTERES'
    end
    object CDDATOSSALDO: TCurrencyField
      FieldName = 'SALDO'
    end
    object CDDATOSFECHAA: TDateField
      FieldName = 'FECHAA'
    end
    object CDDATOSFECHAV: TDateField
      FieldName = 'FECHAV'
    end
    object CDDATOSESTADO: TStringField
      FieldName = 'ESTADO'
      Size = 15
    end
  end
  object IBInserta: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      ' INSERT INTO'
      
        ' "dian$cdatreal"(CUENTA,IDPERSONA,IDIDENTIFICACION,INICIAL,INVER' +
        'SION,INTERES,SALDO,FECHA,FECHAV,ESTADO)'
      ' VALUES('
      
        '          :CUENTA,:IDPERSONA,:IDIDENTIFICACION,:INICIAL,:INVERSI' +
        'ON,:INTERES,:SALDO,:FECHA,:FECHAV,:ESTADO)')
    Left = 264
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CUENTA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IDPERSONA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IDIDENTIFICACION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'INICIAL'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'INVERSION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'INTERES'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'SALDO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FECHA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FECHAV'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ESTADO'
        ParamType = ptUnknown
      end>
  end
  object IB: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      
        'select VALOR from "dian$nocdat" where IDPERSONA = :IDPERSONA and' +
        ' IDIDENTIFICACION = :IDIDENTIFICACION')
    Left = 400
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IDPERSONA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IDIDENTIFICACION'
        ParamType = ptUnknown
      end>
  end
  object IBCon: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT FIRST 1 '
      '  "gen$direccion".MUNICIPIO,'
      '  "gen$direccion".COD_MUNICIPIO,'
      '  "gen$direccion".DIRECCION'
      'FROM'
      '  "gen$direccion"'
      'WHERE'
      '  "gen$direccion".ID_DIRECCION = 1 AND '
      '  "gen$direccion".ID_PERSONA = :IDPERSONA AND '
      '  "gen$direccion".ID_IDENTIFICACION = :IDIDENTIFICACION')
    Left = 384
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IDPERSONA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IDIDENTIFICACION'
        ParamType = ptUnknown
      end>
  end
  object cdCdat: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'NUMERO'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'DV'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'PAPELLIDO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'SAPELLIDO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'PNOMBRE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'SNOMBRE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'RZ'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'DIRECCION'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'DPTO'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'MNCP'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'VALORINICIAL'
        DataType = ftCurrency
      end
      item
        Name = 'INVERSION'
        DataType = ftCurrency
      end
      item
        Name = 'INTERES'
        DataType = ftCurrency
      end
      item
        Name = 'SALDO'
        DataType = ftCurrency
      end
      item
        Name = 'CUENTA'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TIT'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 352
    Top = 216
    Data = {
      080200009619E0BD010000001800000011000000000003000000080204544950
      4F0100490000000100055749445448020002000200064E554D45524F01004900
      00000100055749445448020002000F0002445601004900000001000557494454
      4802000200010009504150454C4C49444F010049000000010005574944544802
      000200640009534150454C4C49444F0100490000000100055749445448020002
      00640007504E4F4D425245010049000000010005574944544802000200640007
      534E4F4D425245010049000000010005574944544802000200640002525A0100
      49000000010005574944544802000200C80009444952454343494F4E01004900
      00000100055749445448020002006400044450544F0100490000000100055749
      445448020002000300044D4E4350010049000000010005574944544802000200
      03000C56414C4F52494E494349414C0800040000000100075355425459504502
      00490006004D6F6E65790009494E56455253494F4E0800040000000100075355
      42545950450200490006004D6F6E65790007494E544552455308000400000001
      0007535542545950450200490006004D6F6E6579000553414C444F0800040000
      00010007535542545950450200490006004D6F6E657900064355454E54410100
      4900000001000557494454480200020014000354495401004900000001000557
      494454480200020001000000}
    object cdCdatTIPO: TStringField
      FieldName = 'TIPO'
      Size = 2
    end
    object cdCdatNUMERO: TStringField
      FieldName = 'NUMERO'
      Size = 15
    end
    object cdCdatDV: TStringField
      FieldName = 'DV'
      Size = 1
    end
    object cdCdatPAPELLIDO: TStringField
      FieldName = 'PAPELLIDO'
      Size = 100
    end
    object cdCdatSAPELLIDO: TStringField
      FieldName = 'SAPELLIDO'
      Size = 100
    end
    object cdCdatPNOMBRE: TStringField
      FieldName = 'PNOMBRE'
      Size = 100
    end
    object cdCdatSNOMBRE: TStringField
      FieldName = 'SNOMBRE'
      Size = 100
    end
    object cdCdatRZ: TStringField
      FieldName = 'RZ'
      Size = 200
    end
    object cdCdatDIRECCION: TStringField
      FieldName = 'DIRECCION'
      Size = 100
    end
    object cdCdatDPTO: TStringField
      FieldName = 'DPTO'
      Size = 3
    end
    object cdCdatMNCP: TStringField
      FieldName = 'MNCP'
      Size = 3
    end
    object cdCdatVALORINICIAL: TCurrencyField
      FieldName = 'VALORINICIAL'
    end
    object cdCdatINVERSION: TCurrencyField
      FieldName = 'INVERSION'
    end
    object cdCdatINTERES: TCurrencyField
      FieldName = 'INTERES'
    end
    object cdCdatSALDO: TCurrencyField
      FieldName = 'SALDO'
    end
    object cdCdatCUENTA: TStringField
      FieldName = 'CUENTA'
    end
    object cdCdatTIT: TStringField
      FieldName = 'TIT'
      Size = 1
    end
  end
  object save: TSaveDialog
    Left = 296
    Top = 8
  end
  object IBq1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      
        'select VALOR from "dian$nocdat" where IDPERSONA = :IDPERSONA and' +
        ' IDIDENTIFICACION = :IDIDENTIFICACION')
    Left = 240
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IDPERSONA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IDIDENTIFICACION'
        ParamType = ptUnknown
      end>
  end
  object IBConTotal: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT FIRST 1'
      '  "dian$direccion".DPTO,'
      '  "dian$direccion".MCP,'
      '  "dian$direccion".DIRECCION'
      'FROM'
      '  "dian$direccion"'
      'WHERE'
      '  "dian$direccion".NUMERO = :IDPERSONA AND'
      '  "dian$direccion".ID = :IDIDENTIFICACION')
    Left = 296
    Top = 240
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IDPERSONA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'IDIDENTIFICACION'
        ParamType = ptUnknown
      end>
  end
end
