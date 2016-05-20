object frmConfrontar: TfrmConfrontar
  Left = 48
  Top = 262
  BorderStyle = bsToolWindow
  Caption = 'Confrontaci'#243'n Cartera Septiembre Vs Diciembre 2005'
  ClientHeight = 307
  ClientWidth = 716
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 64
    Width = 36
    Height = 13
    Caption = 'Fecha1'
  end
  object Label2: TLabel
    Left = 152
    Top = 65
    Width = 36
    Height = 13
    Caption = 'Fecha2'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 128
    Width = 705
    Height = 161
    Color = clBtnFace
    DataSource = DSexel
    Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 573
    Top = 0
    Width = 140
    Height = 89
    Color = clOlive
    TabOrder = 1
    object btnConfrontar: TBitBtn
      Left = 6
      Top = 8
      Width = 131
      Height = 25
      Caption = '&Iniciar Confrontaci'#243'n'
      TabOrder = 0
      OnClick = btnConfrontarClick
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
    object btnCerrar: TBitBtn
      Left = 5
      Top = 35
      Width = 131
      Height = 25
      Caption = '&Cerrar Formulario'
      TabOrder = 1
      OnClick = btnCerrarClick
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
    object BitBtn1: TBitBtn
      Left = 16
      Top = 64
      Width = 75
      Height = 25
      Caption = 'BitBtn1'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object Bar1: TProgressBar
    Left = 8
    Top = 8
    Width = 564
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 2
  end
  object Bar2: TProgressBar
    Left = 8
    Top = 32
    Width = 564
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 3
  end
  object Status: TStatusBar
    Left = 0
    Top = 288
    Width = 716
    Height = 19
    Panels = <
      item
        Text = 'Estado Actual'
        Width = 80
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Fecha1: TDateTimePicker
    Left = 53
    Top = 62
    Width = 97
    Height = 21
    CalAlignment = dtaLeft
    Date = 38924.3320862269
    Time = 38924.3320862269
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 5
  end
  object Fecha2: TDateTimePicker
    Left = 192
    Top = 62
    Width = 97
    Height = 21
    CalAlignment = dtaLeft
    Date = 38924.332108287
    Time = 38924.332108287
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 6
  end
  object CDResult: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID_AGENCIA'
        DataType = ftSmallint
      end
      item
        Name = 'ID_COLOCACION'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'ID_EDAD'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ID_ARRASTRE'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'BAJA'
        DataType = ftBoolean
      end
      item
        Name = 'SUBE'
        DataType = ftBoolean
      end
      item
        Name = 'MANTIENE'
        DataType = ftBoolean
      end
      item
        Name = 'SALDADO'
        DataType = ftBoolean
      end
      item
        Name = 'NOMBRE'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'DEUDA'
        DataType = ftCurrency
      end
      item
        Name = 'DEUDAJ'
        DataType = ftCurrency
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    IndexFieldNames = 'ID_EDAD;ID_AGENCIA;ID_COLOCACION'
    Params = <>
    StoreDefs = True
    Left = 104
    Top = 112
    Data = {
      3C0100009619E0BD01000000180000000B0000000000030000003C010A49445F
      4147454E43494102000100000000000D49445F434F4C4F434143494F4E010049
      0000000100055749445448020002000B000749445F4544414401004900000001
      000557494454480200020001000B49445F415252415354524501004900000001
      000557494454480200020001000442414A410200030000000000045355424502
      00030000000000084D414E5449454E4502000300000000000753414C4441444F
      0200030000000000064E4F4D4252450100490000000100055749445448020002
      00C800054445554441080004000000010007535542545950450200490006004D
      6F6E6579000644455544414A0800040000000100075355425459504502004900
      06004D6F6E65790001000D44454641554C545F4F524445520200820000000000}
    object CDResultID_AGENCIA: TSmallintField
      DisplayWidth = 15
      FieldName = 'ID_AGENCIA'
    end
    object CDResultID_COLOCACION: TStringField
      FieldName = 'ID_COLOCACION'
      FixedChar = True
      Size = 11
    end
    object CDResultID_EDAD: TStringField
      FieldName = 'ID_EDAD'
      Size = 1
    end
    object CDResultID_ARRASTRE: TStringField
      DisplayWidth = 17
      FieldName = 'ID_ARRASTRE'
      Size = 1
    end
    object CDResultBAJA: TBooleanField
      DisplayWidth = 6
      FieldName = 'BAJA'
    end
    object CDResultSUBE: TBooleanField
      DisplayWidth = 6
      FieldName = 'SUBE'
    end
    object CDResultMANTIENE: TBooleanField
      DisplayWidth = 11
      FieldName = 'MANTIENE'
    end
    object CDResultSALDADO: TBooleanField
      DisplayWidth = 11
      FieldName = 'SALDADO'
    end
    object CDResultNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 200
    end
    object CDResultDEUDA: TCurrencyField
      FieldName = 'DEUDA'
    end
    object CDResultDEUDAJ: TCurrencyField
      FieldName = 'DEUDAJ'
    end
  end
  object IBQMarzo: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "col$causaciones".ID_AGENCIA,'
      '  "col$causaciones".ID_COLOCACION,'
      '  "col$causaciones".ID_ARRASTRE,'
      
        '  "gen$persona".PRIMER_APELLIDO || '#39' '#39' || "gen$persona".SEGUNDO_' +
        'APELLIDO || '#39' '#39' || "gen$persona".NOMBRE AS NOMBRE,'
      '  "col$causaciones".DEUDA'
      'FROM'
      ' "col$causaciones"'
      
        ' INNER JOIN "gen$persona" ON ("col$causaciones".ID_IDENTIFICACIO' +
        'N="gen$persona".ID_IDENTIFICACION)'
      '  AND ("col$causaciones".ID_PERSONA="gen$persona".ID_PERSONA)'
      'WHERE'
      ' FECHA_CORTE = '#39'2005/09/30'#39' and ID_ARRASTRE in ('#39'B'#39','#39'C'#39','#39'D'#39')'
      'ORDER BY ID_ARRASTRE ASC, ID_COLOCACION ASC')
    Left = 304
    Top = 216
  end
  object DataSource1: TDataSource
    DataSet = CDResult
    Left = 24
    Top = 104
  end
  object IBTransaction1: TIBTransaction
    AllowAutoStart = False
    DefaultDatabase = IBDatabase1
    DefaultAction = TARollback
    Left = 184
    Top = 128
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = '192.168.200.141:/var/db/fbird/database.fdb'
    Params.Strings = (
      'user_name=ADMDOR'
      'password=sinvida'
      'sql_role_name=CARTERA'
      'lc_ctype=ISO8859_1')
    LoginPrompt = False
    Left = 48
    Top = 112
  end
  object IBSQL1: TIBSQL
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 248
    Top = 192
  end
  object IBDatabase2: TIBDatabase
    LoginPrompt = False
    DefaultTransaction = IBTransaction2
    Left = 72
    Top = 112
  end
  object IBDatabase3: TIBDatabase
    LoginPrompt = False
    DefaultTransaction = IBTransaction3
    Left = 96
    Top = 144
  end
  object CDAbonos: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID_AGENCIA'
        DataType = ftSmallint
      end
      item
        Name = 'ID_COLOCACION'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'FECHA'
        DataType = ftDate
      end
      item
        Name = 'VALOR_CAPITAL'
        DataType = ftCurrency
      end
      item
        Name = 'RECIBO'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end
      item
        Name = 'CDAbonosIndex5'
        Fields = 'ID_AGENCIA;ID_COLOCACION;FECHA;RECIBO'
      end>
    IndexName = 'CDAbonosIndex5'
    MasterFields = 'ID_AGENCIA;ID_COLOCACION'
    MasterSource = DScreditos
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 416
    Top = 16
    Data = {
      AC0000009619E0BD010000001800000005000000000003000000AC000A49445F
      4147454E43494102000100000000000D49445F434F4C4F434143494F4E010049
      0000000100055749445448020002000B0005464543484104000600000000000D
      56414C4F525F4341504954414C08000400000001000753554254595045020049
      0006004D6F6E6579000652454349424F040001000000000001000D4445464155
      4C545F4F524445520200820000000000}
    object CDAbonosID_AGENCIA: TSmallintField
      FieldName = 'ID_AGENCIA'
    end
    object CDAbonosID_COLOCACION: TStringField
      FieldName = 'ID_COLOCACION'
      Size = 11
    end
    object CDAbonosFECHA: TDateField
      FieldName = 'FECHA'
    end
    object CDAbonosVALOR_CAPITAL: TCurrencyField
      FieldName = 'VALOR_CAPITAL'
    end
    object CDAbonosRECIBO: TIntegerField
      FieldName = 'RECIBO'
    end
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = IBDatabase2
    DefaultAction = TARollback
    Left = 208
    Top = 152
  end
  object IBTransaction3: TIBTransaction
    DefaultDatabase = IBDatabase3
    DefaultAction = TARollback
    Left = 216
    Top = 136
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    Left = 384
    Top = 96
    ReportForm = {19000000}
  end
  object ColocacionesDS: TfrDBDataSet
    DataSource = DSResult
    Left = 160
    Top = 136
  end
  object AbonosDS: TfrDBDataSet
    DataSource = DSAbonos
    Left = 192
    Top = 128
  end
  object DSResult: TDataSource
    DataSet = CDResult
    Left = 144
    Top = 144
  end
  object DSAbonos: TDataSource
    AutoEdit = False
    DataSet = CDAbonos
    Enabled = False
    Left = 240
    Top = 152
  end
  object frDesigner1: TfrDesigner
    Left = 272
    Top = 152
  end
  object frOLEExcelExport1: TfrOLEExcelExport
    Left = 320
    Top = 136
  end
  object frRtfAdvExport1: TfrRtfAdvExport
    Left = 368
    Top = 128
  end
  object CdCreditos: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID_AGENCIA'
        DataType = ftSmallint
      end
      item
        Name = 'ID_COLOCACION'
        DataType = ftString
        Size = 11
      end
      item
        Name = 'NOMBRE'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'VARIACION'
        DataType = ftCurrency
      end
      item
        Name = 'CLASIFICACION'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 448
    Top = 16
    Data = {
      B20000009619E0BD010000001800000005000000000003000000B2000A49445F
      4147454E43494102000100000000000D49445F434F4C4F434143494F4E010049
      0000000100055749445448020002000B00064E4F4D4252450200490000000100
      05574944544802000200FF0009564152494143494F4E08000400000001000753
      5542545950450200490006004D6F6E6579000D434C4153494649434143494F4E
      01004900000001000557494454480200020032000000}
    object CdCreditosID_AGENCIA: TSmallintField
      FieldName = 'ID_AGENCIA'
    end
    object CdCreditosID_COLOCACION: TStringField
      FieldName = 'ID_COLOCACION'
      Size = 11
    end
    object CdCreditosNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 255
    end
    object CdCreditosVARIACION: TCurrencyField
      FieldName = 'VARIACION'
    end
    object CdCreditosCLASIFICACION: TStringField
      FieldName = 'CLASIFICACION'
      Size = 50
    end
  end
  object IBdespues: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "col$causaciones".PCAPITAL'
      'FROM'
      ' "col$causaciones"'
      'WHERE'
      '  ("col$causaciones".ID_COLOCACION = :ID_COLOCACION) AND '
      '  ("col$causaciones".FECHA_CORTE = :FECHA_CORTE) AND '
      '  ("col$causaciones".ID_AGENCIA = :ID_AGENCIA)')
    Left = 416
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_COLOCACION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FECHA_CORTE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_AGENCIA'
        ParamType = ptUnknown
      end>
  end
  object IBantes: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "col$causaciones".PCAPITAL'
      'FROM'
      ' "col$causaciones"'
      'WHERE'
      '  ("col$causaciones".ID_COLOCACION = :ID_COLOCACION) AND '
      '  ("col$causaciones".FECHA_CORTE = :FECHA_CORTE) AND '
      '  ("col$causaciones".ID_AGENCIA = :ID_AGENCIA)')
    Left = 368
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_COLOCACION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FECHA_CORTE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_AGENCIA'
        ParamType = ptUnknown
      end>
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT'
      '  "col$causaciones".ID_COLOCACION,'
      '  "gen$persona".NOMBRE,'
      '  "gen$persona".PRIMER_APELLIDO,'
      '  "gen$persona".SEGUNDO_APELLIDO,'
      '  "col$causaciones".ID_IDENTIFICACION,'
      '  "col$causaciones".ID_PERSONA,'
      '  "col$clasificacion".DESCRIPCION_CLASIFICACION'
      'FROM'
      ' "col$causaciones"'
      
        ' INNER JOIN "gen$persona" ON ("col$causaciones".ID_IDENTIFICACIO' +
        'N="gen$persona".ID_IDENTIFICACION)'
      '  AND ("col$causaciones".ID_PERSONA="gen$persona".ID_PERSONA)'
      
        ' INNER JOIN "col$clasificacion" ON ("col$clasificacion".ID_CLASI' +
        'FICACION="col$causaciones".ID_CLASIFICACION)'
      'WHERE'
      '  ("col$causaciones".FECHA_CORTE = '#39'2005/12/30'#39') ')
    Left = 488
    Top = 56
  end
  object IBvalida: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT '
      ' "col$causaciones".PCAPITAL'
      'FROM'
      ' "col$causaciones"'
      'WHERE'
      
        '  ("col$causaciones".FECHA_CORTE BETWEEN :FECHA_INICIO AND :FECH' +
        'A_FIN) AND'
      '  ("col$causaciones".ID_COLOCACION = :ID_COLOCACION) AND'
      '  ("col$causaciones".ID_AGENCIA = :ID_AGENCIA)')
    Left = 464
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FECHA_INICIO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FECHA_FIN'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_COLOCACION'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_AGENCIA'
        ParamType = ptUnknown
      end>
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = CdCreditos
    Left = 440
    Top = 88
  end
  object DScreditos: TDataSource
    DataSet = CdCreditos
    Left = 472
    Top = 80
  end
  object CdExel: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 96
    Data = {
      BC0000009619E0BD010000001800000006000000000003000000BC000643414D
      504F3101004900000001000557494454480200020037000643414D504F320100
      4900000001000557494454480200020037000643414D504F3301004900000001
      000557494454480200020037000643414D504F34010049000000010005574944
      54480200020037000643414D504F350100490000000100055749445448020002
      0037000643414D504F3601004900000001000557494454480200020037000000}
    object CdExelCAMPO1: TStringField
      FieldName = 'CAMPO1'
      Size = 55
    end
    object CdExelCAMPO2: TStringField
      FieldName = 'CAMPO2'
      Size = 55
    end
    object CdExelCAMPO3: TStringField
      FieldName = 'CAMPO3'
      Size = 55
    end
    object CdExelCAMPO4: TStringField
      FieldName = 'CAMPO4'
      Size = 55
    end
    object CdExelCAMPO5: TStringField
      FieldName = 'CAMPO5'
      Size = 55
    end
    object CdExelCAMPO6: TStringField
      FieldName = 'CAMPO6'
      Size = 55
    end
  end
  object DSexel: TDataSource
    DataSet = CdExel
    Left = 528
    Top = 96
  end
  object SDdialogo: TSaveDialog
    Left = 104
    Top = 136
  end
end
