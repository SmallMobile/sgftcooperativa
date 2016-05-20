object frmBalanceGralDetallado: TfrmBalanceGralDetallado
  Left = 144
  Top = 274
  Width = 436
  Height = 156
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'Balance General Detallado'
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
  object Panel1: TPanel
    Left = 321
    Top = 0
    Width = 107
    Height = 121
    TabOrder = 2
    object CmdAceptar: TBitBtn
      Left = 16
      Top = 13
      Width = 81
      Height = 25
      Caption = '&Generar'
      TabOrder = 0
      OnClick = CmdAceptarClick
    end
    object CmdCerrar: TBitBtn
      Left = 18
      Top = 61
      Width = 75
      Height = 25
      Caption = '&Salir'
      TabOrder = 1
      OnClick = CmdCerrarClick
    end
  end
  object Panel3: TPanel
    Left = 1
    Top = 1
    Width = 323
    Height = 41
    Caption = 'Panel3'
    TabOrder = 3
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 33
    Width = 325
    Height = 44
    Caption = 'Seleccione Codigo Inicial y Final'
    TabOrder = 0
    object EdCodigoInicial: TMaskEdit
      Left = 8
      Top = 17
      Width = 142
      Height = 21
      EditMask = '!9-9-99-99-99-99-99-99-99-99;0;0'
      MaxLength = 27
      TabOrder = 0
      OnExit = EdCodigoInicialExit
      OnKeyPress = EdCodigoInicialKeyPress
    end
    object EdCodigoFinal: TMaskEdit
      Left = 169
      Top = 17
      Width = 145
      Height = 21
      EditMask = '!9-9-99-99-99-99-99-99-99-99;0;0'
      MaxLength = 27
      TabOrder = 1
      OnExit = EdCodigoFinalExit
      OnKeyPress = EdCodigoFinalKeyPress
    end
  end
  object GroupBox3: TGroupBox
    Left = 1
    Top = 73
    Width = 324
    Height = 49
    Caption = 'Seleccione Nivel, A'#241'o y Mes de Corte'
    TabOrder = 1
    object CBNivel: TComboBox
      Left = 3
      Top = 20
      Width = 118
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'UNO'
      OnExit = CBNivelExit
      OnKeyPress = CBNivelKeyPress
      Items.Strings = (
        'UNO'
        'DOS'
        'TRES'
        'CUATRO'
        'CINCO'
        'SEIS'
        'SIETE'
        'OCHO'
        'NUEVE'
        'DIEZ')
    end
    object EdAno: TMaskEdit
      Left = 131
      Top = 20
      Width = 31
      Height = 21
      EditMask = '!9999;1;_'
      MaxLength = 4
      TabOrder = 1
      Text = '    '
      OnExit = EdAnoExit
      OnKeyPress = EdAnoKeyPress
    end
    object CBMeses: TComboBox
      Left = 173
      Top = 20
      Width = 142
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
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
    Left = 24
    Top = 264
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
    object IBQSaldoActDEBITO: TIBBCDField
      FieldName = 'DEBITO'
      Origin = '"con$saldoscuenta"."DEBITO"'
      Precision = 18
      Size = 3
    end
    object IBQSaldoActCREDITO: TIBBCDField
      FieldName = 'CREDITO'
      Origin = '"con$saldoscuenta"."CREDITO"'
      Precision = 18
      Size = 3
    end
  end
  object IBQTabla: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 32
    Top = 232
  end
  object ReportBalanceDet: TprTxReport
    ShowProgress = True
    FromPage = 1
    ToPage = 1
    Title = 'Liquidaci'#243'n'
    ExportFromPage = 0
    ExportToPage = 0
    Values = <
      item
        Name = 'TotalDebitoAnt'
        AggFunction = prafSum
        Formula = 'IBQTabla.DEBITOANT'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
        Accumulate = True
      end
      item
        Name = 'TotalCreditoAnt'
        AggFunction = prafSum
        Formula = 'IBQTabla.CREDITOANT'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
      end
      item
        Name = 'TotalDebitoMov'
        AggFunction = prafSum
        Formula = 'IBQTabla.DEBITOMOV'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
      end
      item
        Name = 'TotalCreditoMov'
        AggFunction = prafSum
        Formula = 'IBQTabla.CREDITOMOV'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
      end
      item
        Name = 'TotalDebitoAct'
        AggFunction = prafSum
        Formula = 'IBQTabla.DEBITOANT + IBQTabla.DEBITOMOV'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
        Accumulate = True
      end
      item
        Name = 'TotalCreditoAct'
        AggFunction = prafSum
        Formula = 'IBQTabla.CREDITOANT + IBQTabla.CREDITOMOV'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
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
        Name = 'Mes'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'AnoCorte'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Nit'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'CodigoI'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'CodigoF'
        ValueType = 'prvvtString'
        Value = ''
      end>
    PrinterName = '\\DEPARTAS02\Epson LX-300'
    ESCModelName = 'Epson printers'
    WrapAfterColumn = 0
    EjectPageAfterPrint = False
    LinesOnPage = 0
    FromLine = 0
    ToLine = 0
    ExportFromLine = 0
    ExportToLine = 0
    Left = 39
    Top = 225
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
      ColNum = 236
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
              TxFontOptionsEx = (
                tfoBold
                tfoWide)
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 20
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj2: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'BALANCE GENERAL DETALLADO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold
                tfoItalic)
            end>
          dRec.Left = 80
          dRec.Top = 0
          dRec.Right = 108
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
                  '----------------------------------------------------------------' +
                  '----------------------------------------')
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
          dRec.Right = 233
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj7: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Corte a : [Mes] de [AnoCorte]'
                '      ')
              DeleteEmptyLinesAtEnd = True
              DeleteEmptyLines = True
              CanResizeX = True
              CanResizeY = True
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = True
            end>
          dRec.Left = 200
          dRec.Top = 2
          dRec.Right = 231
          dRec.Bottom = 3
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
                  '----------------------------------------')
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
          dRec.Right = 233
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
                '[IBQTabla.DESCRIPCION_AGENCIA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold)
            end>
          dRec.Left = 19
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
                'Elaboro        : [empleado]')
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
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 185
          dRec.Top = 0
          dRec.Right = 209
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
        object prTxMemoObj15: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CUENTA CONTABLE')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 5
          dRec.Right = 83
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj17: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|'
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
          dRec.Left = 83
          dRec.Top = 5
          dRec.Right = 84
          dRec.Bottom = 7
          Visible = False
        end
        object prTxMemoObj25: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|'
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
          dRec.Left = 183
          dRec.Top = 5
          dRec.Right = 184
          dRec.Bottom = 7
          Visible = False
        end
        object prTxMemoObj51: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Nit : [Nit]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 28
          dRec.Top = 0
          dRec.Right = 48
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
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 200
          dRec.Top = 3
          dRec.Right = 231
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Codigo Inicial :')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 78
          dRec.Top = 2
          dRec.Right = 95
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj61: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Codigo Final   :')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 78
          dRec.Top = 3
          dRec.Right = 95
          dRec.Bottom = 4
          Visible = False
        end
        object prTxMemoObj62: TprTxMemoObj
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
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 95
          dRec.Top = 2
          dRec.Right = 112
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj63: TprTxMemoObj
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
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 95
          dRec.Top = 3
          dRec.Right = 112
          dRec.Bottom = 4
          Visible = False
        end
      end
      object prTxHDetailHeaderBand1: TprTxHDetailHeaderBand
        Height = 3
        UseVerticalBands = False
        DetailBand = ReportBalanceDet.prTxHDetailBand1
        ColCount = 0
        ColDirection = prcdTopBottomLeftRight
        ReprintOnEachPage = True
        LinkToDetail = True
        object prTxMemoObj11: TprTxMemoObj
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
          dRec.Left = 19
          dRec.Top = 1
          dRec.Right = 20
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj12: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'NOMBRE')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 20
          dRec.Top = 1
          dRec.Right = 83
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj14: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'MES ANTERIOR')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 84
          dRec.Top = 0
          dRec.Right = 133
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj16: TprTxMemoObj
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
          dRec.Left = 84
          dRec.Top = 1
          dRec.Right = 108
          dRec.Bottom = 2
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
          dRec.Left = 108
          dRec.Top = 1
          dRec.Right = 109
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj22: TprTxMemoObj
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
          dRec.Left = 109
          dRec.Top = 1
          dRec.Right = 133
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj23: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|'
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
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj24: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'MOVIMIENTOS DEL MES')
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
          dRec.Right = 183
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj26: TprTxMemoObj
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
          dRec.Left = 134
          dRec.Top = 1
          dRec.Right = 158
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj27: TprTxMemoObj
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
          dRec.Left = 158
          dRec.Top = 1
          dRec.Right = 159
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj28: TprTxMemoObj
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
          dRec.Left = 159
          dRec.Top = 1
          dRec.Right = 183
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj29: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'SALDO ACTUAL')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 184
          dRec.Top = 0
          dRec.Right = 233
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj30: TprTxMemoObj
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
          dRec.Left = 184
          dRec.Top = 1
          dRec.Right = 208
          dRec.Bottom = 2
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
          dRec.Left = 208
          dRec.Top = 1
          dRec.Right = 209
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj35: TprTxMemoObj
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
          dRec.Left = 209
          dRec.Top = 1
          dRec.Right = 233
          dRec.Bottom = 2
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
                  '----------------------------------------------------------------' +
                  '----------------------------------------')
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
          dRec.Right = 233
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CODIGO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 1
          dRec.Right = 19
          dRec.Bottom = 2
          Visible = False
        end
      end
      object prTxHDetailBand1: TprTxHDetailBand
        Height = 1
        UseVerticalBands = False
        DataSetName = 'IBQTabla'
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        Groups = (
          'gNivel')
        Bands = (
          'prTxHDetailHeaderBand1'
          'prTxHDetailFooterBand2')
        object prTxMemoObj36: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQTabla.CODIGO]')
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
          dRec.Right = 19
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj37: TprTxMemoObj
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
          dRec.Left = 19
          dRec.Top = 0
          dRec.Right = 20
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj38: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQTabla.NOMBRE]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 20
          dRec.Top = 0
          dRec.Right = 83
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
          dRec.Left = 83
          dRec.Top = 0
          dRec.Right = 84
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj40: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,#0.00>iif(IBQTabla.DEBITOANT > 0,IBQTabla.DEBITOANT,0)]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 84
          dRec.Top = 0
          dRec.Right = 108
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj41: TprTxMemoObj
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
          dRec.Left = 108
          dRec.Top = 0
          dRec.Right = 109
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj42: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>iif(IBQTabla.CREDITOANT > 0,IBQTabla.CREDITOANT,0)]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 109
          dRec.Top = 0
          dRec.Right = 133
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
          dRec.Left = 133
          dRec.Top = 0
          dRec.Right = 134
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj44: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla.DEBITOMOV]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 134
          dRec.Top = 0
          dRec.Right = 158
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
          dRec.Left = 158
          dRec.Top = 0
          dRec.Right = 159
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj46: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla.CREDITOMOV]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 159
          dRec.Top = 0
          dRec.Right = 183
          dRec.Bottom = 1
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
          dRec.Left = 183
          dRec.Top = 0
          dRec.Right = 184
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj48: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[:<#,##0.00>iif((IBQTabla.DEBITOANT - IBQTabla.CREDITOANT)+ (IBQ' +
                  'Tabla.DEBITOMOV - IBQTabla.CREDITOMOV) > 0,(IBQTabla.DEBITOANT -' +
                  ' IBQTabla.CREDITOANT)+ (IBQTabla.DEBITOMOV - IBQTabla.CREDITOMOV' +
                  '),0)]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 184
          dRec.Top = 0
          dRec.Right = 208
          dRec.Bottom = 1
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
          dRec.Left = 208
          dRec.Top = 0
          dRec.Right = 209
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj50: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[:<#,##0.00>iif((IBQTabla.DEBITOANT-IBQTabla.CREDITOANT)+(IBQTab' +
                  'la.DEBITOMOV-IBQTabla.CREDITOMOV) < 0,-((IBQTabla.DEBITOANT - IB' +
                  'QTabla.CREDITOANT) + (IBQTabla.DEBITOMOV - IBQTabla.CREDITOMOV))' +
                  ',0)]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 209
          dRec.Top = 0
          dRec.Right = 233
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHDetailFooterBand2: TprTxHDetailFooterBand
        Height = 1
        UseVerticalBands = False
        DetailBand = ReportBalanceDet.prTxHDetailBand1
        ColCount = 0
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = False
        object prTxMemoObj89: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '================================================================' +
                  '================================================================' +
                  '================================================================' +
                  '========================================')
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
          dRec.Right = 233
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHGroupFooterBand1: TprTxHGroupFooterBand
        Height = 1
        UseVerticalBands = False
        Group = ReportBalanceDet.gNivel
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = True
        object prTxMemoObj19: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
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
          dRec.Right = 10
          dRec.Bottom = 1
          Visible = False
        end
      end
    end
    object gNivel: TprGroup
      Valid = 'IBQTabla.NIVEL'
      DetailBand = ReportBalanceDet.prTxHDetailBand1
    end
  end
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 176
    Top = 208
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
    Left = 144
    Top = 216
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
  object Reporte: TprTxReport
    ShowProgress = True
    FromPage = 1
    ToPage = 1
    Title = 'Liquidaci'#243'n'
    ExportFromPage = 0
    ExportToPage = 0
    Values = <
      item
        Name = 'TotalDebitoAnt'
        AggFunction = prafSum
        Formula = 'IBQTabla.DEBITOANT'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
        Accumulate = True
      end
      item
        Name = 'TotalCreditoAnt'
        AggFunction = prafSum
        Formula = 'IBQTabla.CREDITOANT'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
      end
      item
        Name = 'TotalDebitoMov'
        AggFunction = prafSum
        Formula = 'IBQTabla.DEBITOMOV'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
      end
      item
        Name = 'TotalCreditoMov'
        AggFunction = prafSum
        Formula = 'IBQTabla.CREDITOMOV'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
      end
      item
        Name = 'TotalDebitoAct'
        AggFunction = prafSum
        Formula = 'IBQTabla.DEBITOANT + IBQTabla.DEBITOMOV'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
        Accumulate = True
      end
      item
        Name = 'TotalCreditoAct'
        AggFunction = prafSum
        Formula = 'IBQTabla.CREDITOANT + IBQTabla.CREDITOMOV'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
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
        Name = 'Mes'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'AnoCorte'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Nit'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'CodigoI'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'CodigoF'
        ValueType = 'prvvtString'
        Value = ''
      end>
    PrinterName = '\\DEPARTAS02\Epson LX-300'
    ESCModelName = 'Epson printers'
    WrapAfterColumn = 0
    EjectPageAfterPrint = False
    LinesOnPage = 0
    FromLine = 0
    ToLine = 0
    ExportFromLine = 0
    ExportToLine = 0
    Left = 59
    Top = 227
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
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold
                tfoWide)
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 24
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj2: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'BALANCE GENERAL DETALLADO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold
                tfoItalic)
            end>
          dRec.Left = 50
          dRec.Top = 0
          dRec.Right = 78
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj7: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Corte a : [Mes] de [AnoCorte]'
                '      ')
              DeleteEmptyLinesAtEnd = True
              DeleteEmptyLines = True
              CanResizeX = True
              CanResizeY = True
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = True
            end>
          dRec.Left = 106
          dRec.Top = 1
          dRec.Right = 137
          dRec.Bottom = 2
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
                  '----------------------------------------')
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
          dRec.Top = 3
          dRec.Right = 137
          dRec.Bottom = 4
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
          dRec.Top = 1
          dRec.Right = 18
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj6: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQTabla.DESCRIPCION_AGENCIA]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold)
            end>
          dRec.Left = 19
          dRec.Top = 1
          dRec.Right = 48
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj33: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Elaboro        : [empleado]')
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
          dRec.Right = 48
          dRec.Bottom = 3
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
              hAlign = prhRight
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 113
          dRec.Top = 0
          dRec.Right = 137
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
        object prTxMemoObj17: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|'
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
          dRec.Left = 52
          dRec.Top = 4
          dRec.Right = 53
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj25: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|'
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
          dRec.Left = 115
          dRec.Top = 4
          dRec.Right = 116
          dRec.Bottom = 6
          Visible = False
        end
        object prTxMemoObj51: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Nit : [Nit]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 25
          dRec.Top = 0
          dRec.Right = 45
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
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 106
          dRec.Top = 2
          dRec.Right = 137
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Codigo Inicial :')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 65
          dRec.Top = 1
          dRec.Right = 82
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj61: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Codigo Final   :')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 65
          dRec.Top = 2
          dRec.Right = 82
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj62: TprTxMemoObj
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
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 82
          dRec.Top = 1
          dRec.Right = 99
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj63: TprTxMemoObj
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
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 82
          dRec.Top = 2
          dRec.Right = 99
          dRec.Bottom = 3
          Visible = False
        end
      end
      object prTxHDetailHeaderBand1: TprTxHDetailHeaderBand
        Height = 3
        UseVerticalBands = False
        DetailBand = Reporte.prTxHDetailBand1
        ColCount = 0
        ColDirection = prcdTopBottomLeftRight
        ReprintOnEachPage = True
        LinkToDetail = True
        object prTxMemoObj11: TprTxMemoObj
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
          dRec.Left = 13
          dRec.Top = 1
          dRec.Right = 14
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj12: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'NOMBRE')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 14
          dRec.Top = 1
          dRec.Right = 52
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj14: TprTxMemoObj
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
          dRec.Left = 53
          dRec.Top = 0
          dRec.Right = 73
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj16: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'MES ANTERIOR')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 53
          dRec.Top = 1
          dRec.Right = 73
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj23: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|'
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
          dRec.Left = 73
          dRec.Top = 0
          dRec.Right = 74
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj24: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'MOVIMIENTOS DEL MES')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 74
          dRec.Top = 0
          dRec.Right = 115
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj26: TprTxMemoObj
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
          dRec.Left = 74
          dRec.Top = 1
          dRec.Right = 94
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj27: TprTxMemoObj
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
          dRec.Left = 94
          dRec.Top = 1
          dRec.Right = 95
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj28: TprTxMemoObj
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
          dRec.Left = 95
          dRec.Top = 1
          dRec.Right = 115
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj29: TprTxMemoObj
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
          dRec.Left = 116
          dRec.Top = 0
          dRec.Right = 136
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj30: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'MES ACTUAL')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 116
          dRec.Top = 1
          dRec.Right = 136
          dRec.Bottom = 2
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
                  '----------------------------------------------------------------' +
                  '----------------------------------------')
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
          dRec.Right = 137
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj20: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|'
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
          dRec.Left = 136
          dRec.Top = 0
          dRec.Right = 137
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CODIGO')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 1
          dRec.Top = 1
          dRec.Right = 13
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj4: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CUENTA CONTABLE')
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
          dRec.Right = 52
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHDetailBand1: TprTxHDetailBand
        Height = 1
        UseVerticalBands = False
        DataSetName = 'IBQTabla'
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        Groups = (
          'gNivel')
        Bands = (
          'prTxHDetailHeaderBand1'
          'prTxHDetailFooterBand2')
        object prTxMemoObj36: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQTabla.CODIGO]')
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
          dRec.Right = 13
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj37: TprTxMemoObj
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
          dRec.Left = 13
          dRec.Top = 0
          dRec.Right = 14
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj38: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQTabla.NOMBRE]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 14
          dRec.Top = 0
          dRec.Right = 52
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
          dRec.Left = 52
          dRec.Top = 0
          dRec.Right = 53
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj40: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[:<#,#0.00>iif(IBQTabla.DEBITOANT > 0,IBQTabla.DEBITOANT,-IBQTab' +
                  'la.CREDITOANT)]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 53
          dRec.Top = 0
          dRec.Right = 73
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj41: TprTxMemoObj
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
          dRec.Left = 73
          dRec.Top = 0
          dRec.Right = 74
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj44: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla.DEBITOMOV]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 74
          dRec.Top = 0
          dRec.Right = 94
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
          dRec.Left = 94
          dRec.Top = 0
          dRec.Right = 95
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj46: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla.CREDITOMOV]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 95
          dRec.Top = 0
          dRec.Right = 115
          dRec.Bottom = 1
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
          dRec.Left = 115
          dRec.Top = 0
          dRec.Right = 116
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj48: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '[:<#,##0.00>((IBQTabla.DEBITOANT - IBQTabla.CREDITOANT)+ (IBQTab' +
                  'la.DEBITOMOV - IBQTabla.CREDITOMOV))]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhRight
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 116
          dRec.Top = 0
          dRec.Right = 136
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
          dRec.Left = 136
          dRec.Top = 0
          dRec.Right = 137
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHDetailFooterBand2: TprTxHDetailFooterBand
        Height = 1
        UseVerticalBands = False
        DetailBand = Reporte.prTxHDetailBand1
        ColCount = 0
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = False
        object prTxMemoObj89: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '================================================================' +
                  '================================================================' +
                  '================================================================' +
                  '========================================')
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
          dRec.Right = 137
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHGroupFooterBand1: TprTxHGroupFooterBand
        Height = 1
        UseVerticalBands = False
        Group = Reporte.gNivel
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = True
        object prTxMemoObj19: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
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
          dRec.Right = 10
          dRec.Bottom = 1
          Visible = False
        end
      end
    end
    object gNivel: TprGroup
      Valid = 'IBQTabla.NIVEL'
      DetailBand = Reporte.prTxHDetailBand1
    end
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = IBQTabla
    Left = 88
    Top = 176
  end
  object frOLEExcelExport1: TfrOLEExcelExport
    Left = 56
    Top = 176
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    Left = 24
    Top = 176
    ReportForm = {19000000}
  end
  object JvProgreso: TJvProgressDlg
    Text = 'Progress'
    Left = 200
    Top = 184
  end
end
