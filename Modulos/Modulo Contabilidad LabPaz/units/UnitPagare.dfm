object frmPagare: TfrmPagare
  Left = 268
  Top = 253
  Width = 238
  Height = 90
  Caption = 'Impresi'#243'n de Pagar'#233
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 6
    Width = 89
    Height = 13
    Caption = 'COLOCACION No:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 23
    Width = 230
    Height = 33
    Align = alBottom
    Color = clOlive
    TabOrder = 1
    object CmdCerrar: TBitBtn
      Left = 146
      Top = 4
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
    object CmdImprimir: TBitBtn
      Left = 2
      Top = 4
      Width = 75
      Height = 25
      Caption = '&Imprimir'
      TabOrder = 0
      OnClick = CmdImprimirClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000220B0000220B00000001000000010000181818002118
        21001821210031313100393939004242420052525200636363006B6B6B007373
        7300848484008C8C8C00948C8C00949494009C949400F7AD94009C9C9C00CE9C
        9C00F7AD9C00FFAD9C00FFB59C009C9CA500A5A5A500ADA5A500C6A5A500A5AD
        A500FFBDA500A5D6A500ADADAD00B5ADAD00FFC6AD00B5B5B500FFC6B500BDBD
        BD00C6BDBD00BDC6BD00E7C6BD00EFCEBD00FFCEBD00BDBDC600C6C6C600CEC6
        C600E7CEC600CECECE00D6CECE00DED6CE00FFDECE00D6D6D600FFE7D600D6DE
        DE00DEDEDE00EFE7DE00E7E7E700EFE7E700FFE7E700EFEFEF00F7EFEF00F7EF
        F700F7F7F700FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003B3B3B3B3B3B
        103B3B3B0A0A0B3B3B3B3B3B3B3B10102C0D04060E282F0A3B3B3B3B10103A3C
        2F1005010103070A0B3B0C10373C3528100B0D0A07040201093B10343421161D
        22160D0C0D0E0B080A3B0D1C161C282F373732281C100C0D0B3B0C1C282B2832
        2B19212B2F2F281F0D3B3B102B2B32281F1B231817161F22163B3B3B10211C1C
        343837332F2B1F0D3B3B3B3B3B102F2B10212F2F2F281C3B3B3B3B3B3B3B362E
        24242A2D2B0D3B3B3B3B3B3B3B3B112E261E1A133B3B3B3B3B3B3B3B3B3B112E
        261E1A0F3B3B3B3B3B3B3B3B3B3B112E261E1A123B3B3B3B3B3B3B3B3B11302E
        261E1A123B3B3B3B3B3B3B3B3B1111111112123B3B3B3B3B3B3B}
    end
  end
  object EdColocacion: TMemo
    Left = 96
    Top = 2
    Width = 125
    Height = 19
    Alignment = taRightJustify
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnKeyPress = EdColocacionKeyPress
  end
  object GridDeudores: TStringGrid
    Left = 4
    Top = 26
    Width = 221
    Height = 7
    ColCount = 4
    FixedCols = 0
    TabOrder = 2
    Visible = False
  end
  object IBSQLPagare: TIBSQL
    Database = dmGeneral.IBDatabase1
    SQL.Strings = (
      'SELECT'
      '  "col$colocacion".ID_AGENCIA,'
      '  "col$colocacion".ID_COLOCACION,'
      '  "col$colocacion".ID_IDENTIFICACION,'
      '  "col$colocacion".ID_PERSONA,'
      '  "gen$persona".PRIMER_APELLIDO,'
      '  "gen$persona".SEGUNDO_APELLIDO,'
      '  "gen$persona".NOMBRE,'
      '  "gen$persona".LUGAR_EXPEDICION,'
      '  "gen$tiposidentificacion".DESCRIPCION_IDENTIFICACION,'
      '  "col$colocacion".VALOR_DESEMBOLSO,'
      '  "col$colocacion".FECHA_DESEMBOLSO,'
      '  "col$colocacion".FECHA_VENCIMIENTO,'
      '  "col$inversion".DESCRIPCION_INVERSION,'
      '  "col$garantia".DESCRIPCION_GARANTIA,'
      '  "cap$maestrotitular".ID_TIPO_CAPTACION,'
      '  "cap$maestrotitular".NUMERO_CUENTA,'
      '  "col$colocacion".VALOR_CUOTA,'
      '  "col$colocacion".FECHA_VENCIMIENTO,'
      '  "col$colocacion".ID_INTERES,'
      '  "col$colocacion".TASA_INTERES_CORRIENTE,'
      '  "col$tasasvariables".DESCRIPCION_TASA,'
      '  "col$colocacion".PUNTOS_INTERES,'
      '  "col$colocacion".AMORTIZA_CAPITAL,'
      '  "col$colocacion".AMORTIZA_INTERES,'
      '  "col$tiposcuota".INTERES,'
      '  "col$tiposcuota".TIPO_CUOTA'
      'FROM'
      '  "col$colocacion"'
      
        '  INNER JOIN "gen$tiposidentificacion" ON ("col$colocacion".ID_I' +
        'DENTIFICACION = "gen$tiposidentificacion".ID_IDENTIFICACION)'
      
        '  LEFT JOIN "col$tasasvariables" ON ("col$colocacion".ID_INTERES' +
        ' = "col$tasasvariables".ID_INTERES)'
      
        '  LEFT JOIN "gen$persona" ON ("col$colocacion".ID_IDENTIFICACION' +
        ' = "gen$persona".ID_IDENTIFICACION and "col$colocacion".ID_PERSO' +
        'NA = "gen$persona".ID_PERSONA)'
      
        '  LEFT OUTER JOIN "cap$maestrotitular" ON ("gen$persona".ID_IDEN' +
        'TIFICACION = "cap$maestrotitular".ID_IDENTIFICACION) AND ("gen$p' +
        'ersona".ID_PERSONA = "cap$maestrotitular".ID_PERSONA)'
      
        ' LEFT OUTER JOIN "cap$maestro" ON ("cap$maestrotitular".ID_AGENC' +
        'IA = "cap$maestro".ID_AGENCIA AND "cap$maestrotitular".ID_TIPO_C' +
        'APTACION = "cap$maestro".ID_TIPO_CAPTACION AND "cap$maestrotitul' +
        'ar".NUMERO_CUENTA = "cap$maestro".NUMERO_CUENTA AND "cap$maestro' +
        'titular".DIGITO_CUENTA = "cap$maestro".DIGITO_CUENTA)'
      
        '  LEFT OUTER JOIN "col$tasasvariables" ON ("col$colocacion".ID_I' +
        'NTERES = "col$tasasvariables".ID_INTERES)'
      
        ' LEFT OUTER JOIN "col$garantia" ON ("col$colocacion".ID_GARANTIA' +
        ' = "col$garantia".ID_GARANTIA)'
      
        ' LEFT OUTER JOIN "col$inversion" ON ("col$colocacion".ID_INVERSI' +
        'ON = "col$inversion".ID_INVERSION)'
      
        ' LEFT OUTER JOIN "col$tiposcuota" ON ("col$colocacion".ID_TIPO_C' +
        'UOTA = "col$tiposcuota".ID_TIPOS_CUOTA)'
      'WHERE'
      '  "col$colocacion".ID_AGENCIA = :AGENCIA and'
      '  "col$colocacion".ID_COLOCACION = :ID_COLOCACION and'
      '  "cap$maestrotitular".ID_TIPO_CAPTACION = 1 and'
      '  "cap$maestrotitular".NUMERO_TITULAR = 1 and'
      '  "cap$maestro".ID_ESTADO = 1')
    Transaction = dmGeneral.IBTransaction1
    Left = 342
    Top = 54
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = CDSCodeudores
    Left = 22
    Top = 80
  end
  object IBSQLCodeudores: TIBSQL
    Database = dmGeneral.IBDatabase1
    SQL.Strings = (
      
        'select "gen$persona".ID_IDENTIFICACION, "gen$persona".ID_PERSONA' +
        ', "gen$persona".PRIMER_APELLIDO, "gen$persona".SEGUNDO_APELLIDO,' +
        '"gen$persona".NOMBRE, '
      '"gen$persona".LUGAR_EXPEDICION,'
      
        '"gen$tiposidentificacion".DESCRIPCION_IDENTIFICACION from "col$c' +
        'olgarantias"'
      
        'inner join "gen$persona" on ("col$colgarantias".ID_IDENTIFICACIO' +
        'N = "gen$persona".ID_IDENTIFICACION and "col$colgarantias".ID_PE' +
        'RSONA = "gen$persona".ID_PERSONA)'
      
        'inner join "gen$tiposidentificacion" ON ("gen$persona".ID_IDENTI' +
        'FICACION = "gen$tiposidentificacion".ID_IDENTIFICACION)'
      'where'
      '  ID_AGENCIA = :ID_AGENCIA and'
      '  ID_COLOCACION = :ID_COLOCACION'
      'order by'
      '  "col$colgarantias".CSC_GARANTIA')
    Transaction = dmGeneral.IBTransaction1
    Left = 180
    Top = 78
  end
  object NLetra: TNLetra
    Numero = 0
    Letras = 'Cero'
    Left = 308
    Top = 58
  end
  object IBSQLCuotas: TIBSQL
    Database = dmGeneral.IBDatabase1
    SQL.Strings = (
      'select * from "col$tablaliquidacion"'
      
        'where ID_AGENCIA = :ID_AGENCIA and ID_COLOCACION = :ID_COLOCACIO' +
        'N')
    Transaction = dmGeneral.IBTransaction1
    Left = 24
    Top = 110
  end
  object IBSQL1: TIBSQL
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 142
    Top = 82
  end
  object CDSCodeudores: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'NOMBRE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'IDENTIFICACION'
        DataType = ftString
        Size = 255
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 118
    Top = 52
    Data = {
      580000009619E0BD0100000018000000020000000000030000005800064E4F4D
      42524501004900000001000557494454480200020014000E4944454E54494649
      434143494F4E020049000000010005574944544802000200FF000000}
    object CDSCodeudoresNOMBRE: TStringField
      FieldName = 'NOMBRE'
    end
    object CDSCodeudoresIDENTIFICACION: TStringField
      FieldName = 'IDENTIFICACION'
      Size = 255
    end
  end
  object ReporteN: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    OnBeginPage = ReporteNBeginPage
    OnGetValue = ReporteGetValue
    Left = 72
    Top = 24
    ReportForm = {19000000}
  end
end
