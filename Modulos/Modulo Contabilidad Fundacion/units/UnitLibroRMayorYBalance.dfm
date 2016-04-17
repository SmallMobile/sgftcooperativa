object frmLibroMayorYBalance: TfrmLibroMayorYBalance
  Left = 221
  Top = 185
  Width = 350
  Height = 116
  Caption = 'Libro Registrado Mayor y Balance'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = -9
    Top = -1
    Width = 351
    Height = 50
    TabOrder = 0
    object Label5: TLabel
      Left = 16
      Top = 13
      Width = 99
      Height = 13
      Caption = 'Balance con corte a:'
    end
    object Label4: TLabel
      Left = 240
      Top = 12
      Width = 22
      Height = 13
      Caption = 'A'#241'o:'
    end
    object CBMeses: TComboBox
      Left = 128
      Top = 9
      Width = 105
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'Enero'
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
      Left = 264
      Top = 8
      Width = 31
      Height = 21
      EditMask = '!9999;1;_'
      MaxLength = 4
      TabOrder = 1
      Text = '    '
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 49
    Width = 342
    Height = 33
    Align = alBottom
    Color = clOlive
    TabOrder = 1
    object CmdAceptar: TBitBtn
      Left = 167
      Top = 5
      Width = 81
      Height = 25
      Caption = '&Aceptar'
      TabOrder = 0
      OnClick = CmdAceptarClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000D30E0000D30E00000001000000010000008C00000094
        0000009C000000A5000000940800009C100000AD100000AD180000AD210000B5
        210000BD210018B5290000C62900319C310000CE310029AD390031B5420018C6
        420000D6420052A54A0029AD4A0029CE5A006BB5630000FF63008CBD7B00A5C6
        94005AE7A500FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF001B1B1B1B1B13
        04161B1B1B1B1B1B1B1B1B1B1B1B1B0B0A01181B1B1B1B1B1B1B1B1B1B1B160A
        0C030D1B1B1B1B1B1B1B1B1B1B1B050E0C0601191B1B1B1B1B1B1B1B1B130E0C
        170E02001B1B1B1B1B1B1B1B1B0B1517170A0C01181B1B1B1B1B1B1B1B111717
        13130C030D1B1B1B1B1B1B1B1B1B08081B1B070C01191B1B1B1B1B1B1B1B1B1B
        1B1B100C02001B1B1B1B1B1B1B1B1B1B1B1B1B090C01181B1B1B1B1B1B1B1B1B
        1B1B1B130C0F101B1B1B1B1B1B1B1B1B1B1B1B1B141A0F181B1B1B1B1B1B1B1B
        1B1B1B1B1012181B1B1B1B1B1B1B1B1B1B1B1B1B1B191B1B1B1B1B1B1B1B1B1B
        1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B}
    end
    object CmdCerrar: TBitBtn
      Left = 254
      Top = 5
      Width = 75
      Height = 25
      Caption = '&Cerrar'
      TabOrder = 1
      OnClick = CmdCerrarClick
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
  object IBQPuc: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 65533
    Top = 23
  end
  object IBQSaldoAct: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'Select'
      'SUM("con$saldoscuenta".DEBITO) AS DEBITO,'
      'SUM("con$saldoscuenta".CREDITO) AS CREDITO'
      'from "con$saldoscuenta"'
      'where'
      '"con$saldoscuenta".CODIGO =:"CODIGO" and'
      '"con$saldoscuenta".MES =:"MES"')
    Left = 24
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODIGO'
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
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 96
    Top = 24
  end
  object ReportBalance: TprTxReport
    ShowProgress = True
    FromPage = 1
    ToPage = 1
    Title = 'Liquidaci'#243'n'
    ExportFromPage = 0
    ExportToPage = 0
    Values = <
      item
        Name = 'TotalDebitoAnt'
        Formula = 'IBQTabla.DEBITOANT'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
        Accumulate = True
      end
      item
        Name = 'TotalCreditoAnt'
        Formula = 'IBQTabla.CREDITOANT'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
      end
      item
        Name = 'TotalDebitoMov'
        Formula = 'IBQTabla.DEBITOMOV'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
      end
      item
        Name = 'TotalCreditoMov'
        Formula = 'IBQTabla.CREDITOMOV'
        ResetOn = rvtGroup
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
      end
      item
        Name = 'TotalDebitoAct'
        Formula = 'IBQTabla.DEBITOACT'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
        Accumulate = True
      end
      item
        Name = 'TotalCreditoAct'
        Formula = 'IBQTabla.CREDITOACT'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla'
      end
      item
        Name = 'TotalDebitoAnt1'
        Formula = 'IBQTabla1.DEBITOANT'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla1'
        Accumulate = True
      end
      item
        Name = 'TotalCreditoAnt1'
        Formula = 'IBQTabla1.CREDITOANT'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla1'
        Accumulate = True
      end
      item
        Name = 'TotalDebitoAct1'
        Formula = 'IBQTabla1.DEBITOACT'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla1'
        Accumulate = True
      end
      item
        Name = 'TotalCreditoAct1'
        Formula = 'IBQTabla1.CREDITOACT'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla1'
        Accumulate = True
      end
      item
        Name = 'TotalDebitoMov1'
        Formula = 'IBQTabla1.DEBITOMOV'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla1'
        Accumulate = True
      end
      item
        Name = 'TotalCreditoMov1'
        Formula = 'IBQTabla1.CREDITOMOV'
        ResetOn = rvtReport
        CalcOn = cvtDataSetNext
        DataSetName = 'IBQTabla1'
        Accumulate = True
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
      end>
    PrinterName = '\\DEPARTAS02\Epson LX-300'
    OnUnknownVariable = ReportBalanceUnknownVariable
    ESCModelName = 'Epson printers'
    WrapAfterColumn = 0
    EjectPageAfterPrint = False
    LinesOnPage = 0
    FromLine = 0
    ToLine = 0
    ExportFromLine = 0
    ExportToLine = 0
    Left = 313
    Top = 3
    SystemInfo = (
      'OS: WIN32_NT 5.1.2600 Service Pack 2'
      ''
      'PageSize: 4096'
      'ActiveProcessorMask: $1000'
      'NumberOfProcessors: 1'
      'ProcessorType: 586'
      ''
      'Compiler version: Delphi6'
      'PReport version: 1.9.7')
    object prTxPage1: TprTxPage
      ColNum = 236
      object prTxHPageHeaderBand1: TprTxHPageHeaderBand
        Height = 4
        PrintOnFirstPage = True
        object prTxMemoObj4: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------')
            end>
          dRec.Left = 0
          dRec.Top = 1
          dRec.Right = 137
          dRec.Bottom = 2
        end
        object prTxMemoObj7: TprTxMemoObj
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
              WordWrap = True
            end>
          dRec.Left = 53
          dRec.Top = 2
          dRec.Right = 99
          dRec.Bottom = 3
        end
        object prTxMemoObj9: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------')
            end>
          dRec.Left = 0
          dRec.Top = 3
          dRec.Right = 137
          dRec.Bottom = 4
        end
        object prTxCommandObj5: TprTxCommandObj
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
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CODIGO')
              hAlign = prhCenter
              vAlign = prvCenter
            end>
          dRec.Left = 0
          dRec.Top = 6
          dRec.Right = 18
          dRec.Bottom = 7
        end
        object prTxMemoObj15: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CTA')
              hAlign = prhCenter
              vAlign = prvCenter
            end>
          dRec.Left = 0
          dRec.Top = 5
          dRec.Right = 4
          dRec.Bottom = 6
        end
        object prTxMemoObj17: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|'
                '|')
            end>
          dRec.Left = 35
          dRec.Top = 4
          dRec.Right = 36
          dRec.Bottom = 6
        end
        object prTxMemoObj25: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|'
                '|')
            end>
          dRec.Left = 103
          dRec.Top = 4
          dRec.Right = 104
          dRec.Bottom = 6
        end
      end
      object prTxHDetailHeaderBand1: TprTxHDetailHeaderBand
        Height = 3
        DetailBand = ReportBalance.prTxHDetailBand1
        object prTxMemoObj11: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 4
          dRec.Top = 1
          dRec.Right = 5
          dRec.Bottom = 2
        end
        object prTxMemoObj12: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'NOMBRE')
              hAlign = prhCenter
              vAlign = prvCenter
            end>
          dRec.Left = 5
          dRec.Top = 1
          dRec.Right = 35
          dRec.Bottom = 2
        end
        object prTxMemoObj14: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'MES ANTERIOR')
              hAlign = prhCenter
              vAlign = prvCenter
            end>
          dRec.Left = 36
          dRec.Top = 0
          dRec.Right = 69
          dRec.Bottom = 1
        end
        object prTxMemoObj16: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'DEBITO')
              hAlign = prhCenter
            end>
          dRec.Left = 36
          dRec.Top = 1
          dRec.Right = 52
          dRec.Bottom = 2
        end
        object prTxMemoObj18: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 52
          dRec.Top = 1
          dRec.Right = 53
          dRec.Bottom = 2
        end
        object prTxMemoObj22: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CREDITO')
              hAlign = prhCenter
              vAlign = prvCenter
            end>
          dRec.Left = 53
          dRec.Top = 1
          dRec.Right = 69
          dRec.Bottom = 2
        end
        object prTxMemoObj23: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|'
                '|')
            end>
          dRec.Left = 69
          dRec.Top = 0
          dRec.Right = 70
          dRec.Bottom = 2
        end
        object prTxMemoObj24: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'MOVIMIENTOS DEL MES')
              hAlign = prhCenter
              vAlign = prvCenter
            end>
          dRec.Left = 70
          dRec.Top = 0
          dRec.Right = 103
          dRec.Bottom = 1
        end
        object prTxMemoObj26: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'DEBITO')
              hAlign = prhCenter
            end>
          dRec.Left = 70
          dRec.Top = 1
          dRec.Right = 86
          dRec.Bottom = 2
        end
        object prTxMemoObj28: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CREDITO')
              hAlign = prhCenter
              vAlign = prvCenter
            end>
          dRec.Left = 87
          dRec.Top = 1
          dRec.Right = 103
          dRec.Bottom = 2
        end
        object prTxMemoObj29: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'SALDO ACTUAL')
              hAlign = prhCenter
              vAlign = prvCenter
            end>
          dRec.Left = 104
          dRec.Top = 0
          dRec.Right = 137
          dRec.Bottom = 1
        end
        object prTxMemoObj30: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'DEBITO')
              hAlign = prhCenter
            end>
          dRec.Left = 104
          dRec.Top = 1
          dRec.Right = 120
          dRec.Bottom = 2
        end
        object prTxMemoObj34: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 120
          dRec.Top = 1
          dRec.Right = 121
          dRec.Bottom = 2
        end
        object prTxMemoObj35: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'CREDITO')
              hAlign = prhCenter
              vAlign = prvCenter
            end>
          dRec.Left = 121
          dRec.Top = 1
          dRec.Right = 137
          dRec.Bottom = 2
        end
        object prTxMemoObj21: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------')
            end>
          dRec.Left = 0
          dRec.Top = 2
          dRec.Right = 137
          dRec.Bottom = 3
        end
        object prTxMemoObj1: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 86
          dRec.Top = 1
          dRec.Right = 87
          dRec.Bottom = 2
        end
      end
      object prTxHDetailBand1: TprTxHDetailBand
        Height = 1
        DataSetName = 'IBQTabla'
        ColCount = 1
        Bands = (
          'prTxHDetailHeaderBand1'
          'prTxHDetailFooterBand2')
        object prTxMemoObj36: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQTabla.CODIGO]')
              vAlign = prvCenter
            end>
          dRec.Left = 0
          dRec.Top = 0
          dRec.Right = 4
          dRec.Bottom = 1
        end
        object prTxMemoObj37: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 4
          dRec.Top = 0
          dRec.Right = 5
          dRec.Bottom = 1
        end
        object prTxMemoObj38: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQTabla.NOMBRE]')
              vAlign = prvCenter
            end>
          dRec.Left = 5
          dRec.Top = 0
          dRec.Right = 35
          dRec.Bottom = 1
        end
        object prTxMemoObj39: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 35
          dRec.Top = 0
          dRec.Right = 36
          dRec.Bottom = 1
        end
        object prTxMemoObj40: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla.DEBITOANT]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 36
          dRec.Top = 0
          dRec.Right = 52
          dRec.Bottom = 1
        end
        object prTxMemoObj41: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 52
          dRec.Top = 0
          dRec.Right = 53
          dRec.Bottom = 1
        end
        object prTxMemoObj42: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla.CREDITOANT]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 53
          dRec.Top = 0
          dRec.Right = 69
          dRec.Bottom = 1
        end
        object prTxMemoObj43: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 69
          dRec.Top = 0
          dRec.Right = 70
          dRec.Bottom = 1
        end
        object prTxMemoObj44: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla.DEBITOMOV]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 70
          dRec.Top = 0
          dRec.Right = 86
          dRec.Bottom = 1
        end
        object prTxMemoObj45: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 86
          dRec.Top = 0
          dRec.Right = 87
          dRec.Bottom = 1
        end
        object prTxMemoObj46: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla.CREDITOMOV]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 87
          dRec.Top = 0
          dRec.Right = 103
          dRec.Bottom = 1
        end
        object prTxMemoObj47: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 103
          dRec.Top = 0
          dRec.Right = 104
          dRec.Bottom = 1
        end
        object prTxMemoObj48: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla.DEBITOACT]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 104
          dRec.Top = 0
          dRec.Right = 120
          dRec.Bottom = 1
        end
        object prTxMemoObj49: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 120
          dRec.Top = 0
          dRec.Right = 121
          dRec.Bottom = 1
        end
        object prTxMemoObj50: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla.CREDITOACT]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 121
          dRec.Top = 0
          dRec.Right = 137
          dRec.Bottom = 1
        end
      end
      object prTxHDetailBand2: TprTxHDetailBand
        Height = 1
        DataSetName = 'IBQTabla1'
        Bands = (
          'prTxHDetailFooterBand3')
        object prTxMemoObj61: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQTabla1.CODIGO]')
              vAlign = prvCenter
            end>
          dRec.Left = 0
          dRec.Top = 0
          dRec.Right = 4
          dRec.Bottom = 1
        end
        object prTxMemoObj62: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 4
          dRec.Top = 0
          dRec.Right = 5
          dRec.Bottom = 1
        end
        object prTxMemoObj63: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[IBQTabla1.NOMBRE]')
              vAlign = prvCenter
            end>
          dRec.Left = 5
          dRec.Top = 0
          dRec.Right = 35
          dRec.Bottom = 1
        end
        object prTxMemoObj64: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 35
          dRec.Top = 0
          dRec.Right = 36
          dRec.Bottom = 1
        end
        object prTxMemoObj65: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla1.DEBITOANT]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 36
          dRec.Top = 0
          dRec.Right = 52
          dRec.Bottom = 1
        end
        object prTxMemoObj66: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 52
          dRec.Top = 0
          dRec.Right = 53
          dRec.Bottom = 1
        end
        object prTxMemoObj67: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla1.CREDITOANT]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 53
          dRec.Top = 0
          dRec.Right = 69
          dRec.Bottom = 1
        end
        object prTxMemoObj68: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 69
          dRec.Top = 0
          dRec.Right = 70
          dRec.Bottom = 1
        end
        object prTxMemoObj69: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla1.DEBITOMOV]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 70
          dRec.Top = 0
          dRec.Right = 86
          dRec.Bottom = 1
        end
        object prTxMemoObj70: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla1.CREDITOMOV]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 87
          dRec.Top = 0
          dRec.Right = 103
          dRec.Bottom = 1
        end
        object prTxMemoObj71: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 86
          dRec.Top = 0
          dRec.Right = 87
          dRec.Bottom = 1
        end
        object prTxMemoObj72: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 103
          dRec.Top = 0
          dRec.Right = 104
          dRec.Bottom = 1
        end
        object prTxMemoObj73: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla1.DEBITOACT]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 104
          dRec.Top = 0
          dRec.Right = 120
          dRec.Bottom = 1
        end
        object prTxMemoObj74: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 120
          dRec.Top = 0
          dRec.Right = 121
          dRec.Bottom = 1
        end
        object prTxMemoObj75: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>IBQTabla1.CREDITOACT]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 121
          dRec.Top = 0
          dRec.Right = 137
          dRec.Bottom = 1
        end
      end
      object prTxHDetailFooterBand2: TprTxHDetailFooterBand
        Height = 3
        DetailBand = ReportBalance.prTxHDetailBand1
        ColCount = 0
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = False
        object prTxMemoObj19: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------')
            end>
          dRec.Left = 0
          dRec.Top = 0
          dRec.Right = 137
          dRec.Bottom = 1
        end
        object prTxMemoObj20: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'TOTALES -->')
            end>
          dRec.Left = 0
          dRec.Top = 1
          dRec.Right = 26
          dRec.Bottom = 2
        end
        object prTxMemoObj31: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalDebitoAnt]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 36
          dRec.Top = 1
          dRec.Right = 52
          dRec.Bottom = 2
        end
        object prTxMemoObj32: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 52
          dRec.Top = 1
          dRec.Right = 53
          dRec.Bottom = 2
        end
        object prTxMemoObj52: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalCreditoAnt]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 53
          dRec.Top = 1
          dRec.Right = 69
          dRec.Bottom = 2
        end
        object prTxMemoObj53: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 69
          dRec.Top = 1
          dRec.Right = 70
          dRec.Bottom = 2
        end
        object prTxMemoObj54: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalDebitoMov]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 70
          dRec.Top = 1
          dRec.Right = 86
          dRec.Bottom = 2
        end
        object prTxMemoObj55: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 86
          dRec.Top = 1
          dRec.Right = 87
          dRec.Bottom = 2
        end
        object prTxMemoObj56: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalCreditoMov]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 87
          dRec.Top = 1
          dRec.Right = 103
          dRec.Bottom = 2
        end
        object prTxMemoObj57: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 103
          dRec.Top = 1
          dRec.Right = 104
          dRec.Bottom = 2
        end
        object prTxMemoObj58: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalDebitoAct]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 104
          dRec.Top = 1
          dRec.Right = 120
          dRec.Bottom = 2
        end
        object prTxMemoObj59: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 120
          dRec.Top = 1
          dRec.Right = 121
          dRec.Bottom = 2
        end
        object prTxMemoObj60: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalCreditoAct]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 121
          dRec.Top = 1
          dRec.Right = 137
          dRec.Bottom = 2
        end
        object prTxMemoObj89: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '================================================================' +
                  '================================================================' +
                  '================================================================' +
                  '========================================')
            end>
          dRec.Left = 0
          dRec.Top = 2
          dRec.Right = 137
          dRec.Bottom = 3
        end
      end
      object prTxHDetailFooterBand3: TprTxHDetailFooterBand
        Height = 3
        DetailBand = ReportBalance.prTxHDetailBand2
        ColCount = 0
        ColDirection = prcdTopBottomLeftRight
        LinkToDetail = False
        object prTxMemoObj76: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------------------------------' +
                  '----------------------------------------')
            end>
          dRec.Left = 0
          dRec.Top = 0
          dRec.Right = 137
          dRec.Bottom = 1
        end
        object prTxMemoObj77: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'TOTALES -->')
            end>
          dRec.Left = 0
          dRec.Top = 1
          dRec.Right = 26
          dRec.Bottom = 2
        end
        object prTxMemoObj78: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalDebitoAnt1]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 36
          dRec.Top = 1
          dRec.Right = 52
          dRec.Bottom = 2
        end
        object prTxMemoObj79: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 52
          dRec.Top = 1
          dRec.Right = 53
          dRec.Bottom = 2
        end
        object prTxMemoObj80: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalCreditoAnt1]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 53
          dRec.Top = 1
          dRec.Right = 69
          dRec.Bottom = 2
        end
        object prTxMemoObj81: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 69
          dRec.Top = 1
          dRec.Right = 70
          dRec.Bottom = 2
        end
        object prTxMemoObj82: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalDebitoMov1]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 70
          dRec.Top = 1
          dRec.Right = 86
          dRec.Bottom = 2
        end
        object prTxMemoObj83: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 86
          dRec.Top = 1
          dRec.Right = 87
          dRec.Bottom = 2
        end
        object prTxMemoObj84: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalCreditoMov1]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 87
          dRec.Top = 1
          dRec.Right = 103
          dRec.Bottom = 2
        end
        object prTxMemoObj85: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 103
          dRec.Top = 1
          dRec.Right = 104
          dRec.Bottom = 2
        end
        object prTxMemoObj86: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalDebitoAct1]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 104
          dRec.Top = 1
          dRec.Right = 120
          dRec.Bottom = 2
        end
        object prTxMemoObj87: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '|')
            end>
          dRec.Left = 120
          dRec.Top = 1
          dRec.Right = 121
          dRec.Bottom = 2
        end
        object prTxMemoObj88: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[:<#,##0.00>TotalCreditoAct1]')
              hAlign = prhRight
              vAlign = prvCenter
            end>
          dRec.Left = 121
          dRec.Top = 1
          dRec.Right = 137
          dRec.Bottom = 2
        end
        object prTxMemoObj90: TprTxMemoObj
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                
                  '================================================================' +
                  '================================================================' +
                  '================================================================' +
                  '========================================')
            end>
          dRec.Left = 0
          dRec.Top = 2
          dRec.Right = 137
          dRec.Bottom = 3
        end
      end
    end
  end
  object IBQTabla: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODIGO'
        DataType = ftString
        Size = 18
      end
      item
        Name = 'NOMBRE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'NIVEL'
        DataType = ftInteger
      end
      item
        Name = 'DESCRIPCION_AGENCIA'
        DataType = ftString
        Size = 10
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
    IndexFieldNames = 'CODIGO'
    Params = <>
    StoreDefs = True
    Left = 48
    Top = 52
    Data = {
      6D0100009619E0BD01000000180000000A0000000000030000006D0106434F44
      49474F0100490000000100055749445448020002001200064E4F4D4252450100
      490000000100055749445448020002006400054E4956454C0400010000000000
      134445534352495043494F4E5F4147454E434941010049000000010005574944
      5448020002000A000944454249544F414E540800040000000100075355425459
      50450200490006004D6F6E6579000A4352454449544F414E5408000400000001
      0007535542545950450200490006004D6F6E6579000944454249544F4D4F5608
      0004000000010007535542545950450200490006004D6F6E6579000A43524544
      49544F4D4F56080004000000010007535542545950450200490006004D6F6E65
      79000944454249544F4143540800040000000100075355425459504502004900
      06004D6F6E6579000A4352454449544F41435408000400000001000753554254
      5950450200490006004D6F6E6579000000}
    object IBQTablaCODIGO: TStringField
      FieldName = 'CODIGO'
      Size = 18
    end
    object IBQTablaNOMBRE: TStringField
      FieldName = 'NOMBRE'
      Size = 100
    end
    object IBQTablaNIVEL: TIntegerField
      FieldName = 'NIVEL'
    end
    object IBQTablaDESCRIPCION_AGENCIA: TStringField
      FieldName = 'DESCRIPCION_AGENCIA'
      Size = 10
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
    object IBQTablaDEBITOACT: TCurrencyField
      FieldName = 'DEBITOACT'
    end
    object IBQTablaCREDITOACT: TCurrencyField
      FieldName = 'CREDITOACT'
    end
  end
  object IBQTabla1: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODIGO'
        DataType = ftString
        Size = 18
      end
      item
        Name = 'NOMBRE'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'NIVEL'
        DataType = ftInteger
      end
      item
        Name = 'DESCRIPCION_AGENCIA'
        DataType = ftString
        Size = 10
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
    IndexFieldNames = 'CODIGO'
    Params = <>
    StoreDefs = True
    Left = 76
    Top = 52
    Data = {
      6D0100009619E0BD01000000180000000A0000000000030000006D0106434F44
      49474F0100490000000100055749445448020002001200064E4F4D4252450100
      490000000100055749445448020002006400054E4956454C0400010000000000
      134445534352495043494F4E5F4147454E434941010049000000010005574944
      5448020002000A000944454249544F414E540800040000000100075355425459
      50450200490006004D6F6E6579000A4352454449544F414E5408000400000001
      0007535542545950450200490006004D6F6E6579000944454249544F4D4F5608
      0004000000010007535542545950450200490006004D6F6E6579000A43524544
      49544F4D4F56080004000000010007535542545950450200490006004D6F6E65
      79000944454249544F4143540800040000000100075355425459504502004900
      06004D6F6E6579000A4352454449544F41435408000400000001000753554254
      5950450200490006004D6F6E6579000000}
    object StringField1: TStringField
      FieldName = 'CODIGO'
      Size = 18
    end
    object StringField2: TStringField
      FieldName = 'NOMBRE'
      Size = 100
    end
    object IntegerField1: TIntegerField
      FieldName = 'NIVEL'
    end
    object StringField3: TStringField
      FieldName = 'DESCRIPCION_AGENCIA'
      Size = 10
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
end
