object frmInformeAuxiliares: TfrmInformeAuxiliares
  Left = 232
  Top = 350
  Width = 529
  Height = 180
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'Libro Auxiliar'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 412
    Height = 34
    Caption = 'Panel3'
    TabOrder = 0
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 33
    Width = 413
    Height = 70
    Caption = 'Seleccione Codigo Inicial y Codigo Final'
    TabOrder = 1
    object EdCodigoInicial: TMaskEdit
      Left = 6
      Top = 17
      Width = 139
      Height = 21
      EditMask = '!9-9-99-99-99-99-99-99-99-99;0;0'
      MaxLength = 27
      TabOrder = 0
      OnExit = EdCodigoInicialExit
      OnKeyPress = EdCodigoInicialKeyPress
    end
    object EdCodigoFinal: TMaskEdit
      Left = 6
      Top = 42
      Width = 141
      Height = 21
      EditMask = '!9-9-99-99-99-99-99-99-99-99;0;0'
      MaxLength = 27
      TabOrder = 1
      OnExit = EdCodigoFinalExit
      OnKeyPress = EdCodigoFinalKeyPress
    end
    object EdCtaI: TStaticText
      Left = 153
      Top = 18
      Width = 255
      Height = 21
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clCaptionText
      ParentColor = False
      TabOrder = 2
    end
    object EdCtaF: TStaticText
      Left = 153
      Top = 42
      Width = 256
      Height = 21
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clCaptionText
      ParentColor = False
      TabOrder = 3
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 99
    Width = 413
    Height = 47
    Caption = 'Seleccione Fecha Inicial, Fecha Final y Estado '
    TabOrder = 2
    object EdFechaInicial: TDateTimePicker
      Left = 4
      Top = 17
      Width = 120
      Height = 20
      CalAlignment = dtaLeft
      Date = 37811.6218238194
      Format = 'yyyy/MM/dd'
      Time = 37811.6218238194
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
      OnExit = EdFechaInicialExit
      OnKeyPress = EdFechaInicialKeyPress
    end
    object EdFechaFinal: TDateTimePicker
      Left = 126
      Top = 17
      Width = 115
      Height = 20
      CalAlignment = dtaLeft
      Date = 37811.6219742824
      Format = 'yyyy/MM/dd'
      Time = 37811.6219742824
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
      OnExit = EdFechaFinalExit
      OnKeyPress = EdFechaFinalKeyPress
    end
    object CbMovimiento: TComboBox
      Left = 243
      Top = 17
      Width = 165
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'MOVIMIENTOS CERRADOS'
      Items.Strings = (
        'MOVIMIENTOS CERRADOS'
        'TODOS LOS MOVIMIENTOS')
    end
  end
  object Panel1: TPanel
    Left = 412
    Top = 0
    Width = 109
    Height = 145
    Color = clGradientInactiveCaption
    TabOrder = 3
    object CmdAceptar: TBitBtn
      Left = 14
      Top = 21
      Width = 81
      Height = 25
      Caption = 'Generar'
      TabOrder = 0
      OnClick = CmdAceptarClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000420B0000420B00000001000000010000005A00000073
        0800008C080008841000BD8C7300BD847B00EFA54A00C6846B00CE947300C694
        7B00EFB57300FFC67300FF00FF00B5848400B58C8400B5948C00CE9C8400C6A5
        9400C6A59C00C6ADA500CEB5AD00C6BDAD00D6B5AD00D6BDB500EFCE9400EFCE
        9C00F7D69C00F7D6A500F7D6AD00E7C6B500EFCEB500EFCEBD00F7D6B500F7DE
        B500F7DEBD00E7CECE00E7DEC600E7D6CE00F7DEC600F7E7C600F7E7CE00F7E7
        D600FFE7D600FFEFD600FFEFDE00FFEFE700FFF7E700FFF7EF00FFF7F700FFFF
        F700FFFFFF000000000000000000000000000000000000000000000000000000
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
        00000000000000000000000000000000000000000000000000000C0C0D0D0D0D
        0D0D0D0D0D0D0D0D0D0C0C0C122A2A2A26261B191818181A0D0C0C0C122B0B0B
        0B0B0B0A0A0606190D0C0C0C132D2A2A2A2A2A2A2A2A2A190D0C0C0C132E2928
        272626201C1919180D0C0C0C14310B0B0B0B0B0A0A0606190D0C0C0C16322A2A
        2A2A2A2A2A2A2A1B0D0C0C001732302F2C2626262622201C0D0C0C0100320B0B
        0B0B0B0A0A0606210D0C0C0101002A2A2A2A2A2A2A2A2A200D0C0C0302023232
        32302D26262B24150D0C0C0202320B0B0A0A062F29110F0E0D0C0C021D322A2A
        2A2A2A3123040A06070C0C0C1F3232323232323225090B080C0C0C0C1D302F2F
        2F2F2F2F2309100C0C0C0C0C1D1E1E1E1E1D1D1E17050C0C0C0C}
    end
    object CmdCerrar: TBitBtn
      Left = 14
      Top = 60
      Width = 81
      Height = 25
      Caption = '&Salir'
      TabOrder = 1
      OnClick = CmdCerrarClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000D30E0000D30E00000001000000010000008500000094
        0000009B0000008C2300009B230000A1230000A8230000BA230023A1340023C0
        340023A1420042AF630034C04F0034C6590042C059004FCC75004FD175004FD6
        7500FF00FF0063E194006CEB9B006CCCA10075F0A10000AFDC0023B5DC0023B5
        E10034BAE10063CCC0006CD1D10042C0E6004FC6EB0059CCE60059CCEB0063D1
        EB007DDCEB0063D1F0006CD6F00075DCF00075DCF5007DDCF5007DE1F5008CC6
        AF0085E1C60085E1F50085E6F5008CE6F0008CE6F5008CEBF5008CE6FA008CEB
        FA009BEBF50094EBFA0094F0FA009BF0FA009BF5FA00B5EBE100A1F0E600AFE6
        F500B5EBFA00A1F0FA00A1F5FF00A8F5FF00AFF5FF00AFFAFA00A8FAFF00AFFA
        FF00AFFFFF00B5FAFF00B5FFFF00BAFFFF00C0E6F500C6EBF500CCFFFF00DCFA
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
        0000000000000000000000000000000000000000000000000000121F1A1A1212
        12121212121212121212121F342821201D181712121212121212121F403C3634
        312B23201D191D121212121F42403C35332E2C282627241E1A12121F4442403C
        35332E22282626241A12121F444241403C3533001C2726241A12121F44424241
        403C352D002827251A12121F42424242413D3634050028251A12121F44424215
        01413D3D06002C281A12121F49483704043F3D010600302B1A12121F1D1D000F
        030301070001332C1A12121F2F1B0A16100D0902003C35311A12121F44001314
        110000003E403C351A12121F452A000E0C00294746393A321A12121F3B43380B
        0800001F1F1F1F1F1F1212121F1F1F1F1F121212121212121212}
    end
  end
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'select DISTINCT'
      '"con$auxiliar".ID_AGENCIA,'
      '"con$auxiliar".ID_COMPROBANTE,'
      '"con$auxiliar".CODIGO,'
      '"con$auxiliar".DEBITO,'
      '"con$auxiliar".CREDITO,'
      '"con$auxiliar".ID_PERSONA,'
      '"con$auxiliar".ESTADOAUX,'
      '"con$comprobante".FECHADIA,'
      '"con$comprobante".DESCRIPCION,'
      '"con$puc".NOMBRE,'
      '"con$puc".SALDOINICIAL,'
      '"gen$agencia".DESCRIPCION_AGENCIA,'
      '"gen$persona".NOMBRE,'
      '"gen$persona".PRIMER_APELLIDO,'
      '"gen$persona".SEGUNDO_APELLIDO'
      'from "con$auxiliar"'
      
        'LEFT JOIN "con$comprobante" ON ("con$auxiliar".ID_COMPROBANTE = ' +
        '"con$comprobante".ID_COMPROBANTE)'
      
        'LEFT JOIN "con$puc" ON ("con$auxiliar".CODIGO = "con$puc".CODIGO' +
        ')'
      
        'LEFT JOIN "gen$agencia" ON ("con$auxiliar".ID_AGENCIA = "gen$age' +
        'ncia".ID_AGENCIA)'
      
        'LEFT JOIN "gen$persona" ON ("con$auxiliar".ID_PERSONA = "gen$per' +
        'sona".ID_PERSONA)'
      'where'
      
        '("con$auxiliar".FECHA >= :"FECHA_INICIAL" and "con$auxiliar".FEC' +
        'HA <= :"FECHA_FINAL") and'
      
        '("con$auxiliar".CODIGO >= :"CODIGO_INICIAL" and "con$auxiliar".C' +
        'ODIGO <= :"CODIGO_FINAL") and'
      '("con$auxiliar".ESTADOAUX = '#39'C'#39')'
      
        'order by "con$auxiliar".CODIGO, "con$auxiliar".FECHA, "con$auxil' +
        'iar".ID_COMPROBANTE, "con$auxiliar".CREDITO')
    Left = 220
    Top = 270
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'FECHA_INICIAL'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'FECHA_FINAL'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CODIGO_INICIAL'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CODIGO_FINAL'
        ParamType = ptUnknown
      end>
    object IBQuery1ID_AGENCIA: TSmallintField
      FieldName = 'ID_AGENCIA'
      Origin = '"con$auxiliar"."ID_AGENCIA"'
      Required = True
    end
    object IBQuery1ID_COMPROBANTE: TIntegerField
      FieldName = 'ID_COMPROBANTE'
      Origin = '"con$auxiliar"."ID_COMPROBANTE"'
    end
    object IBQuery1CODIGO: TIBStringField
      FieldName = 'CODIGO'
      Origin = '"con$auxiliar"."CODIGO"'
      FixedChar = True
      Size = 18
    end
    object IBQuery1DEBITO: TIBBCDField
      FieldName = 'DEBITO'
      Origin = '"con$auxiliar"."DEBITO"'
      Precision = 18
      Size = 3
    end
    object IBQuery1CREDITO: TIBBCDField
      FieldName = 'CREDITO'
      Origin = '"con$auxiliar"."CREDITO"'
      Precision = 18
      Size = 3
    end
    object IBQuery1ID_PERSONA: TIBStringField
      FieldName = 'ID_PERSONA'
      Origin = '"con$auxiliar"."ID_PERSONA"'
      Size = 15
    end
    object IBQuery1ESTADOAUX: TIBStringField
      FieldName = 'ESTADOAUX'
      Origin = '"con$auxiliar"."ESTADOAUX"'
      FixedChar = True
      Size = 1
    end
    object IBQuery1FECHADIA: TDateField
      FieldName = 'FECHADIA'
      Origin = '"con$comprobante"."FECHADIA"'
    end
    object IBQuery1DESCRIPCION: TMemoField
      FieldName = 'DESCRIPCION'
      Origin = '"con$comprobante"."DESCRIPCION"'
      BlobType = ftMemo
      Size = 8
    end
    object IBQuery1NOMBRE: TIBStringField
      FieldName = 'NOMBRE'
      Origin = '"con$puc"."NOMBRE"'
      Size = 100
    end
    object IBQuery1SALDOINICIAL: TIBBCDField
      FieldName = 'SALDOINICIAL'
      Origin = '"con$puc"."SALDOINICIAL"'
      Precision = 18
      Size = 3
    end
    object IBQuery1DESCRIPCION_AGENCIA: TIBStringField
      FieldName = 'DESCRIPCION_AGENCIA'
      Origin = '"gen$agencia"."DESCRIPCION_AGENCIA"'
      Size = 50
    end
    object IBQuery1NOMBRE1: TIBStringField
      FieldName = 'NOMBRE1'
      Origin = '"gen$persona"."NOMBRE"'
      Size = 90
    end
    object IBQuery1PRIMER_APELLIDO: TIBStringField
      FieldName = 'PRIMER_APELLIDO'
      Origin = '"gen$persona"."PRIMER_APELLIDO"'
      Size = 30
    end
    object IBQuery1SEGUNDO_APELLIDO: TIBStringField
      FieldName = 'SEGUNDO_APELLIDO'
      Origin = '"gen$persona"."SEGUNDO_APELLIDO"'
      Size = 30
    end
  end
  object ReportAuxiliar: TprTxReport
    ShowProgress = True
    FromPage = 1
    ToPage = 1
    Title = 'Liquidaci'#243'n'
    ExportFromPage = 0
    ExportToPage = 0
    Values = <
      item
        Name = 'TotalDebitos'
        AggFunction = prafSum
        Formula = 'IBQuery1.DEBITO'
        ResetOn = rvtPage
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQuery1'
        Accumulate = True
      end
      item
        Name = 'TotalCreditos'
        AggFunction = prafSum
        Formula = 'IBQuery1.CREDITO'
        ResetOn = rvtPage
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQuery1'
        Accumulate = True
      end
      item
        Group = ReportAuxiliar.fecha
        Name = 'TotalDF'
        AggFunction = prafSum
        Formula = 'IBQuery1.DEBITO'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQuery1'
      end
      item
        Group = ReportAuxiliar.fecha
        Name = 'TotalCF'
        AggFunction = prafSum
        Formula = 'IBQuery1.CREDITO'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQuery1'
      end
      item
        Group = ReportAuxiliar.codigo
        Name = 'TotalDC'
        AggFunction = prafSum
        Formula = 'IBQuery1.DEBITO'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQuery1'
      end
      item
        Group = ReportAuxiliar.codigo
        Name = 'TotalCC'
        AggFunction = prafSum
        Formula = 'IBQuery1.CREDITO'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQuery1'
      end>
    Variables = <
      item
        Name = 'Empresa'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Hoy'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'empleado'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'FechaI'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'FechaF'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'CodigoI'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'codigoF'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'NomAgencia'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Estado'
        ValueType = 'prvvtString'
        Value = 'ABIERTO'
      end>
    PrinterName = '\\DEPARTAS02\Epson LX-300'
    OnUnknownVariable = ReportAuxiliarUnknownVariable
    ESCModelName = 'Epson printers'
    WrapAfterColumn = 0
    EjectPageAfterPrint = False
    LinesOnPage = 0
    FromLine = 0
    ToLine = 0
    ExportFromLine = 0
    ExportToLine = 0
    Left = 128
    Top = 238
    SystemInfo = (
      'OS: WIN32_NT 5.1.2600 Service Pack 2'
      ''
      'PageSize: 4096'
      'ActiveProcessorMask: $1000'
      'NumberOfProcessors: 1'
      'ProcessorType: 586'
      ''
      'Compiler version: Delphi6'
      'PReport version: 1.9.4')
    object prTxPage1: TprTxPage
      PageType = tptPage
      LineNum = 60
      ColNum = 181
      object prTxHPageHeaderBand1: TprTxHPageHeaderBand
        Height = 5
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
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 2
          dRec.Top = 0
          dRec.Right = 18
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj2: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'LIBROS AUXILIARES')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 82
          dRec.Top = 0
          dRec.Right = 99
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj3: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Fecha de Impresion : [:<yyyy/mm/dd>Hoy]')
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
          dRec.Top = 0
          dRec.Right = 152
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj4: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '---------------------------------------------------')
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
          dRec.Right = 180
          dRec.Bottom = 2
          Visible = False
        end
        object prTxCommandObj1: TprTxCommandObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              TxCommands = (
                txcBoldOn)
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 2
          dRec.Bottom = 1
          Visible = False
        end
        object prTxCommandObj2: TprTxCommandObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              TxCommands = (
                txcBoldOff)
            end>
          dRec.Left = 18
          dRec.Top = 0
          dRec.Right = 19
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj7: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Fecha Inicial    :'
                '  ')
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
          dRec.Top = 2
          dRec.Right = 73
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/mm/dd>FechaI]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 73
          dRec.Top = 2
          dRec.Right = 95
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj19: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Codigo Inicial   :')
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
          dRec.Top = 3
          dRec.Right = 73
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj20: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CodigoI]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 73
          dRec.Top = 3
          dRec.Right = 95
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj22: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Fecha Final   :')
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
          dRec.Top = 2
          dRec.Right = 132
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj30: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<yyyy/mm/dd>FechaF]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 132
          dRec.Top = 2
          dRec.Right = 154
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj31: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Codigo Final  :')
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
          dRec.Top = 3
          dRec.Right = 132
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj32: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CodigoF]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 132
          dRec.Top = 3
          dRec.Right = 154
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj9: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------')
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
          dRec.Top = 4
          dRec.Right = 181
          dRec.Bottom = 5
          Visible = False
        end
        object prTxMemoObj5: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Agencia        :')
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
          dRec.Top = 2
          dRec.Right = 18
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj6: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[NomAgencia]')
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
          dRec.Top = 2
          dRec.Right = 47
          dRec.Bottom = 3
          Visible = False
        end
        object prTxCommandObj3: TprTxCommandObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              TxCommands = (
                txcBoldOn)
            end>
          dRec.Left = 18
          dRec.Top = 2
          dRec.Right = 19
          dRec.Bottom = 3
          Visible = False
        end
        object prTxCommandObj4: TprTxCommandObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              TxCommands = (
                txcBoldOff)
            end>
          dRec.Left = 47
          dRec.Top = 2
          dRec.Right = 48
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj33: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Usuario        : [empleado]')
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
          dRec.Right = 48
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj13: TprTxMemoObj
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
          dRec.Left = 156
          dRec.Top = 0
          dRec.Right = 180
          dRec.Bottom = 1
          Visible = False
        end
        object prTxCommandObj5: TprTxCommandObj
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
        object prTxMemoObj25: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'ESTADO ACTUAL MOVIMIENTOS')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 155
          dRec.Top = 2
          dRec.Right = 179
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj26: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[Estado]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 155
          dRec.Top = 3
          dRec.Right = 179
          dRec.Bottom = 4
          Visible = False
        end
      end
      object prTxHDetailHeaderBand1: TprTxHDetailHeaderBand
        Height = 2
        UseVerticalBands = False
        DetailBand = ReportAuxiliar.prTxHDetailBand2
        ColCount = 0
        ColDirection = prcdTopBottomLeftRight
        ReprintOnEachPage = False
        LinkToDetail = False
        object prTxMemoObj53: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'COMP.')
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
          dRec.Top = 0
          dRec.Right = 9
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj55: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'DEBITO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 80
          dRec.Top = 0
          dRec.Right = 96
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj113: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CREDITO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 97
          dRec.Top = 0
          dRec.Right = 114
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj119: TprTxMemoObj
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
          dRec.Left = 9
          dRec.Top = 0
          dRec.Right = 10
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj121: TprTxMemoObj
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
          dRec.Left = 96
          dRec.Top = 0
          dRec.Right = 97
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj72: TprTxMemoObj
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
          dRec.Left = 133
          dRec.Top = 0
          dRec.Right = 134
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj73: TprTxMemoObj
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
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 134
          dRec.Top = 0
          dRec.Right = 143
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj21: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------')
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
          dRec.Right = 181
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj15: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'DESCRIPCION')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 10
          dRec.Top = 0
          dRec.Right = 79
          dRec.Bottom = 1
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
          dRec.Left = 79
          dRec.Top = 0
          dRec.Right = 80
          dRec.Bottom = 1
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
          dRec.Left = 143
          dRec.Top = 0
          dRec.Right = 144
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj35: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'BENEFICIARIO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 144
          dRec.Top = 0
          dRec.Right = 181
          dRec.Bottom = 1
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
          dRec.Left = 114
          dRec.Top = 0
          dRec.Right = 115
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj38: TprTxMemoObj
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
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 115
          dRec.Top = 0
          dRec.Right = 133
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHDetailBand2: TprTxHDetailBand
        Height = 1
        UseVerticalBands = False
        DataSetName = 'IBQuery1'
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        Groups = (
          'codigo'
          'fecha')
        Bands = (
          'prTxHDetailHeaderBand1'
          'prTxHDetailFooterBand1')
        object prTxMemoObj57: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQuery1.ID_COMPROBANTE]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 9
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj59: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQuery1.DEBITO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 80
          dRec.Top = 0
          dRec.Right = 96
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj65: TprTxMemoObj
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
          dRec.Left = 9
          dRec.Top = 0
          dRec.Right = 10
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj111: TprTxMemoObj
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
          dRec.Left = 96
          dRec.Top = 0
          dRec.Right = 97
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj117: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQuery1.CREDITO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 97
          dRec.Top = 0
          dRec.Right = 114
          dRec.Bottom = 1
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
          dRec.Left = 133
          dRec.Top = 0
          dRec.Right = 134
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj11: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQuery1.ID_PERSONA]')
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
          dRec.Top = 0
          dRec.Right = 143
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj17: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQuery1.DESCRIPCION]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 10
          dRec.Top = 0
          dRec.Right = 79
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj18: TprTxMemoObj
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
          dRec.Left = 79
          dRec.Top = 0
          dRec.Right = 80
          dRec.Bottom = 1
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
          dRec.Left = 143
          dRec.Top = 0
          dRec.Right = 144
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj37: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[BENEFICIARIO]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 144
          dRec.Top = 0
          dRec.Right = 181
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
          dRec.Left = 114
          dRec.Top = 0
          dRec.Right = 115
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj40: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,#0.00>SALDOACTUAL]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 115
          dRec.Top = 0
          dRec.Right = 133
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHDetailFooterBand1: TprTxHDetailFooterBand
        Height = 2
        UseVerticalBands = False
        DetailBand = ReportAuxiliar.prTxHDetailBand2
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = True
        object prTxMemoObj60: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '================================================================' +
                  '================================================================' +
                  '======================================================')
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
          dRec.Right = 181
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj61: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'TOTAL MOVIMIENTOS -->')
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
        object prTxMemoObj63: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalDebitos]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold)
            end>
          dRec.Left = 80
          dRec.Top = 1
          dRec.Right = 96
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj64: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalCreditos]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold)
            end>
          dRec.Left = 97
          dRec.Top = 1
          dRec.Right = 114
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj29: TprTxMemoObj
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
          dRec.Left = 96
          dRec.Top = 1
          dRec.Right = 97
          dRec.Bottom = 2
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
          dRec.Left = 114
          dRec.Top = 1
          dRec.Right = 115
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj56: TprTxMemoObj
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
          dRec.Left = 79
          dRec.Top = 1
          dRec.Right = 80
          dRec.Bottom = 2
          Visible = False
        end
      end
      object prTxHGroupHeaderBand1: TprTxHGroupHeaderBand
        Height = 1
        UseVerticalBands = True
        Group = ReportAuxiliar.codigo
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = True
        StartNewPage = False
        ReprintOnEachPage = False
        object prTxMemoObj23: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQuery1.CODIGO] : [IBQuery1.NOMBRE]')
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
          dRec.Right = 54
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj43: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,#0.00>SALDOINICIAL]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 115
          dRec.Top = 0
          dRec.Right = 133
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj27: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Saldo Inicial:')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 99
          dRec.Top = 0
          dRec.Right = 114
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHGroupHeaderBand2: TprTxHGroupHeaderBand
        Height = 1
        UseVerticalBands = False
        Group = ReportAuxiliar.fecha
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = True
        StartNewPage = False
        ReprintOnEachPage = False
        object prTxMemoObj24: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQuery1.FECHADIA]')
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
          dRec.Right = 24
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHGroupFooterBand2: TprTxHGroupFooterBand
        Height = 2
        UseVerticalBands = False
        Group = ReportAuxiliar.codigo
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = False
        object prTxMemoObj44: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '---------------------')
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
          dRec.Right = 181
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj45: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'SubTotal Cuenta    :')
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
          dRec.Right = 27
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj46: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalDC]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 80
          dRec.Top = 1
          dRec.Right = 96
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
          dRec.Left = 96
          dRec.Top = 1
          dRec.Right = 97
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj48: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalCC]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 97
          dRec.Top = 1
          dRec.Right = 114
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj49: TprTxMemoObj
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
          dRec.Left = 114
          dRec.Top = 1
          dRec.Right = 115
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj54: TprTxMemoObj
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
          dRec.Left = 79
          dRec.Top = 1
          dRec.Right = 80
          dRec.Bottom = 2
          Visible = False
        end
      end
    end
    object codigo: TprGroup
      Valid = 'IBQuery1.CODIGO'
      DetailBand = ReportAuxiliar.prTxHDetailBand2
    end
    object fecha: TprGroup
      Valid = 'IBQuery1.FECHADIA'
      DetailBand = ReportAuxiliar.prTxHDetailBand2
    end
  end
  object IBQuery: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 8
    Top = 270
  end
  object IBQuery2: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 50
    Top = 254
  end
  object IBSQL1: TIBSQL
    Database = dmGeneral.IBDatabase1
    SQL.Strings = (
      'select NOMBRE from "con$puc" where CODIGO = :CODIGO')
    Transaction = dmGeneral.IBTransaction1
    Left = 92
    Top = 246
  end
  object IBTipoDocumento: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "gen$tiposidentificacion"')
    Left = 138
    Top = 188
  end
  object DSTipoDocumento: TDataSource
    DataSet = IBTipoDocumento
    Left = 90
    Top = 190
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    Left = 256
    Top = 168
    ReportForm = {19000000}
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = IBQuery1
    Left = 408
    Top = 160
  end
  object frOLEExcelExport1: TfrOLEExcelExport
    Left = 360
    Top = 184
  end
end
