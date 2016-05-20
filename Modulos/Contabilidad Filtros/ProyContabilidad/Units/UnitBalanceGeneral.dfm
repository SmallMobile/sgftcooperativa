object frmBalanceGeneral: TfrmBalanceGeneral
  Left = 249
  Top = 267
  Width = 417
  Height = 111
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'Mayor y Balance'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 1
    Top = 0
    Width = 293
    Height = 37
    Caption = 'Panel3'
    TabOrder = 0
  end
  object Panel4: TPanel
    Left = 296
    Top = 1
    Width = 113
    Height = 75
    TabOrder = 1
    object CmdAceptar: TBitBtn
      Left = 12
      Top = 5
      Width = 81
      Height = 25
      Caption = '&Generar'
      TabOrder = 0
      OnClick = CmdAceptarClick
    end
    object CmdCerrar: TBitBtn
      Left = 13
      Top = 40
      Width = 80
      Height = 25
      Caption = '&Salir'
      TabOrder = 1
      OnClick = CmdCerrarClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 32
    Width = 294
    Height = 45
    Caption = 'Seleccione A'#241'o, Mes y Tipo de Reporte'
    TabOrder = 2
    object CBMeses: TComboBox
      Left = 39
      Top = 17
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Enero'
      OnExit = CBMesesExit
      OnKeyPress = CBMesesKeyPress
      Items.Strings = (
        'Enero'
        'Febrero'
        'Marzo'
        'Abril'
        'Mayo'
        'Junio'
        'Julio'
        'Agosto'
        'Septiembre'
        'Octubre'
        'Noviembre'
        'Diciembre')
    end
    object EdAno: TMaskEdit
      Left = 5
      Top = 17
      Width = 31
      Height = 21
      EditMask = '!9999;1;_'
      MaxLength = 4
      TabOrder = 1
      Text = '    '
      OnExit = EdAnoExit
      OnKeyPress = EdAnoKeyPress
    end
    object CbTipo: TComboBox
      Left = 129
      Top = 16
      Width = 160
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'REPORTE NORMAL'
      Items.Strings = (
        'REPORTE NORMAL'
        'LIBRO REGISTRADO')
    end
  end
  object IBQPuc: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'select'
      '"con$puc".CODIGO,'
      '"con$puc".ID_AGENCIA,'
      '"con$puc".NOMBRE,'
      '"con$puc".SALDOINICIAL,'
      '"gen$agencia".DESCRIPCION_AGENCIA,'
      '"con$saldoscuenta".DEBITO AS DEBITOANT,'
      '"con$saldoscuenta".CREDITO AS CREDITOANT'
      'from "con$puc"'
      
        'LEFT JOIN "gen$agencia" ON ("con$puc".ID_AGENCIA = "gen$agencia"' +
        '.ID_AGENCIA)'
      
        'INNER JOIN "con$saldoscuenta" ON ("con$puc".CODIGO = "con$saldos' +
        'cuenta".CODIGO and "con$puc".ID_AGENCIA = "con$saldoscuenta".ID_' +
        'AGENCIA)'
      'where'
      '("con$puc".NIVEL = :"NIVEL") and'
      '("con$saldoscuenta".MES =:"MES")'
      'order by "con$puc".CODIGO')
    Left = 53
    Top = 183
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NIVEL'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MES'
        ParamType = ptUnknown
      end>
  end
  object IBQSaldoAct: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'Select'
      '"con$saldoscuenta".DEBITO,'
      '"con$saldoscuenta".CREDITO'
      'from "con$saldoscuenta"'
      'where'
      '"con$saldoscuenta".CODIGO =:"CODIGO" and'
      '"con$saldoscuenta".ID_AGENCIA =:"ID_AGENCIA" and'
      '"con$saldoscuenta".MES =:"MES"')
    Left = 104
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_AGENCIA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MES'
        ParamType = ptUnknown
      end>
  end
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 36
    Top = 160
  end
  object IBQTabla: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODIGO'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'NOMBRE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'DEBITOANT'
        DataType = ftCurrency
      end
      item
        Name = 'CREDITOANT'
        DataType = ftCurrency
      end
      item
        Name = 'DEBITOMOV'
        DataType = ftCurrency
      end
      item
        Name = 'CREDITOMOV'
        DataType = ftCurrency
      end
      item
        Name = 'DESCRIPCION_AGENCIA'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'DEBITOACT'
        DataType = ftCurrency
      end
      item
        Name = 'CREDITOACT'
        DataType = ftCurrency
      end
      item
        Name = 'TIPO'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'IBQTablaIndex1'
        Fields = 'CODIGO'
      end>
    IndexFieldNames = 'TIPO;CODIGO'
    Params = <>
    StoreDefs = True
    Left = 82
    Top = 186
    Data = {
      6C0100009619E0BD01000000180000000A0000000000030000006C0106434F44
      49474F0100490000000100055749445448020002000400064E4F4D4252450100
      4900000001000557494454480200020064000944454249544F414E5408000400
      0000010007535542545950450200490006004D6F6E6579000A4352454449544F
      414E54080004000000010007535542545950450200490006004D6F6E65790009
      44454249544F4D4F56080004000000010007535542545950450200490006004D
      6F6E6579000A4352454449544F4D4F5608000400000001000753554254595045
      0200490006004D6F6E657900134445534352495043494F4E5F4147454E434941
      01004900000001000557494454480200020064000944454249544F4143540800
      04000000010007535542545950450200490006004D6F6E6579000A4352454449
      544F414354080004000000010007535542545950450200490006004D6F6E6579
      00045449504F04000100000000000000}
    object IBQTablaCODIGO: TStringField
      DisplayWidth = 4
      FieldName = 'CODIGO'
      Size = 4
    end
    object IBQTablaNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 100
    end
    object IBQTablaDEBITOANT: TCurrencyField
      FieldName = 'DEBITOANT'
    end
    object IBQTablaCREDITOANT: TCurrencyField
      FieldName = 'CREDITOANT'
    end
    object IBQTablaDEBITOMOV: TCurrencyField
      FieldName = 'DEBITOMOV'
    end
    object IBQTablaCREDITOMOV: TCurrencyField
      FieldName = 'CREDITOMOV'
    end
    object IBQTablaDESCRIPCION_AGENCIA: TStringField
      FieldName = 'DESCRIPCION_AGENCIA'
      Size = 100
    end
    object IBQTablaDEBITOACT: TCurrencyField
      FieldName = 'DEBITOACT'
    end
    object IBQTablaCREDITOACT: TCurrencyField
      FieldName = 'CREDITOACT'
    end
    object IBQTablaTIPO: TIntegerField
      FieldName = 'TIPO'
    end
  end
  object IBQTabla1: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODIGO'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'NOMBRE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'DEBITOANT'
        DataType = ftCurrency
      end
      item
        Name = 'CREDITOANT'
        DataType = ftCurrency
      end
      item
        Name = 'DEBITOMOV'
        DataType = ftCurrency
      end
      item
        Name = 'CREDITOMOV'
        DataType = ftCurrency
      end
      item
        Name = 'DEBITOACT'
        DataType = ftCurrency
      end
      item
        Name = 'CREDITOACT'
        DataType = ftCurrency
      end>
    IndexDefs = <
      item
        Name = 'IBQTablaIndex1'
        Fields = 'CODIGO'
      end>
    IndexName = 'IBQTablaIndex1'
    Params = <>
    StoreDefs = True
    Left = 318
    Top = 186
    Data = {
      370100009619E0BD010000001800000008000000000003000000370106434F44
      49474F0100490000000100055749445448020002000400064E4F4D4252450100
      4900000001000557494454480200020064000944454249544F414E5408000400
      0000010007535542545950450200490006004D6F6E6579000A4352454449544F
      414E54080004000000010007535542545950450200490006004D6F6E65790009
      44454249544F4D4F56080004000000010007535542545950450200490006004D
      6F6E6579000A4352454449544F4D4F5608000400000001000753554254595045
      0200490006004D6F6E6579000944454249544F41435408000400000001000753
      5542545950450200490006004D6F6E6579000A4352454449544F414354080004
      000000010007535542545950450200490006004D6F6E6579000000}
    object StringField1: TStringField
      DisplayWidth = 4
      FieldName = 'CODIGO'
      Size = 4
    end
    object StringField2: TStringField
      FieldName = 'NOMBRE'
      Size = 100
    end
    object CurrencyField1: TCurrencyField
      FieldName = 'DEBITOANT'
    end
    object CurrencyField2: TCurrencyField
      FieldName = 'CREDITOANT'
    end
    object CurrencyField3: TCurrencyField
      FieldName = 'DEBITOMOV'
    end
    object CurrencyField4: TCurrencyField
      FieldName = 'CREDITOMOV'
    end
    object IBQTabla1DEBITOACT: TCurrencyField
      FieldName = 'DEBITOACT'
    end
    object IBQTabla1CREDITOACT: TCurrencyField
      FieldName = 'CREDITOACT'
    end
  end
  object IBQSaldoAnt: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'Select'
      '"con$saldoscuenta".DEBITO,'
      '"con$saldoscuenta".CREDITO'
      'from "con$saldoscuenta"'
      'where'
      '"con$saldoscuenta".CODIGO =:"CODIGO" and'
      '"con$saldoscuenta".ID_AGENCIA =:"ID_AGENCIA" and'
      '"con$saldoscuenta".MES =:"MES"')
    Left = 2
    Top = 162
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_AGENCIA'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MES'
        ParamType = ptUnknown
      end>
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    Left = 56
    Top = 176
    ReportForm = {19000000}
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = IBQTabla
    Left = 192
    Top = 184
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = IBQTabla1
    Left = 256
    Top = 176
  end
  object frOLEExcelExport1: TfrOLEExcelExport
    Left = 144
    Top = 176
  end
end
