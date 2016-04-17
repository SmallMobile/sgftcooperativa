object FrmNomina: TFrmNomina
  Left = 463
  Top = 223
  Width = 468
  Height = 358
  Caption = 'FrmNomina'
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
  object Bara: TJvSpecialProgress
    Left = 44
    Top = 176
    Width = 315
    Height = 33
    BorderStyle = bsSingle
    Caption = '0%'
    Color = clHighlightText
    EndColor = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    GradientBlocks = True
    HintColor = clMenu
    ParentColor = False
    ParentFont = False
    Solid = True
    Step = 1
    TextCentered = True
    TextOption = toCaption
  end
  object Button1: TButton
    Left = 0
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = -1
    Top = 93
    Width = 113
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object nomi: TJvCurrencyEdit
    Left = 248
    Top = 88
    Width = 121
    Height = 21
    Alignment = taRightJustify
    ReadOnly = False
    TabOrder = 2
    Value = 1
    HasMaxValue = False
    HasMinValue = False
  end
  object nit: TJvIntegerEdit
    Left = 240
    Top = 48
    Width = 121
    Height = 21
    Alignment = taRightJustify
    ReadOnly = False
    TabOrder = 3
    Value = 0
    MaxValue = 0
    MinValue = 0
    HasMaxValue = False
    HasMinValue = False
  end
  object frReport1: TfrReport
    Dataset = frDBDataSet1
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    Left = 328
    Top = 128
    ReportForm = {19000000}
  end
  object frCompositeReport1: TfrCompositeReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    DoublePassReport = False
    Left = 80
    ReportForm = {19000000}
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = IBconsolidadas
    Left = 64
  end
  object IBempresa: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from "inv$empresa"')
    Top = 176
  end
  object IBnomina: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT'
      '  "nom$nomina"."nit_empleado",'
      '  "nom$nomina"."ibc",'
      '  "nom$nomina"."sueldobasico",'
      '  "inv$empleado"."apellido",'
      '  "inv$empleado"."nombre",'
      '  "nom$nomina"."dias_trabajados",'
      '  "nom$nomina"."total_basico",'
      '  "nom$nomina"."horas_extras",'
      '  "nom$nomina"."transporte",'
      '  "nom$nomina"."total_devengado",'
      '  "nom$nomina"."libranza",'
      '  "nom$nomina"."cporcobrar",'
      '  "nom$nomina"."fsp",'
      '  "nom$nomina"."retefuente",'
      '  "nom$nomina"."salud",'
      '  "nom$nomina"."pension",'
      '  "nom$nomina"."sueldoneto",'
      ' "nom$nomina"."ap_pension",'
      '  "nom$empleado"."numero_cuenta"'
      'FROM'
      '  "inv$empleado"'
      
        '  INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empl' +
        'eado"."nitempleado")'
      
        '  INNER JOIN "nom$nomina" ON ("nom$empleado"."nitempleado" = "no' +
        'm$nomina"."nit_empleado")'
      'WHERE'
      ' ("nom$nomina"."codigo_nomina" = :codigo) AND'
      '  ("nom$empleado"."tipo_nomina" = :tiponomina)'
      'order by   "inv$empleado"."apellido"')
    Left = 224
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tiponomina'
        ParamType = ptUnknown
      end>
  end
  object IBfondos: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "nom$fondos"."descripcion",'
      '  "nom$fondos"."valor_salud",'
      '  "nom$fondos"."valor_pension",'
      '  "nom$fondos"."fsp",'
      '  "nom$fondos"."tipo_nomina"'
      'FROM'
      '  "nom$fondos"'
      'WHERE'
      '  ("nom$fondos"."deduccion" = 1) AND '
      '  ("nom$fondos"."tipo_nomina" = :tipo) AND'
      '  ("nom$fondos"."cod_nomina" = :codigo)')
    Left = 32
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'tipo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
  end
  object IBaportes: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "nom$fondos"."descripcion",'
      '  "nom$fondos"."valor_salud",'
      '  "nom$fondos"."valor_pension",'
      '  "nom$fondos"."fsp",'
      '  "nom$fondos"."tipo_nomina"'
      'FROM'
      '  "nom$fondos"'
      'WHERE'
      '  ("nom$fondos"."deduccion" = 0) AND '
      '  ("nom$fondos"."tipo_nomina" = :tipo) AND'
      '  ("nom$fondos"."cod_nomina" = :codigo)')
    Left = 65
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'tipo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
  end
  object IBfechanomina: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "nom$controlnomina"."fecha"'
      'FROM'
      '  "nom$controlnomina"'
      'WHERE'
      '  ("nom$controlnomina"."cod_nomina" =:cod)')
    Left = 96
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cod'
        ParamType = ptUnknown
      end>
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = IBaportes
    Left = 96
  end
  object frDBDataSet3: TfrDBDataSet
    DataSet = IBfondos
    Left = 128
  end
  object IBtiponomina: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select "nom$tiponomina"."descripcion" from "nom$tiponomina"'
      'where  "nom$tiponomina"."codigo" = :codigo')
    Left = 32
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 192
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "nom$nomina"."codigo_nomina",'
      '  "nom$nomina"."nit_empleado",'
      '  "nom$nomina"."dias_trabajados",'
      '  "nom$nomina"."sueldobasico",'
      '  "nom$nomina"."total_basico",'
      '  "nom$nomina"."horas_extras",'
      '  "nom$nomina"."transporte",'
      '  "nom$nomina"."total_devengado",'
      '  "nom$nomina"."libranza",'
      '  "nom$nomina"."fsp",'
      '  "nom$nomina"."cporcobrar",'
      '  "nom$nomina"."retefuente",'
      '  "nom$nomina"."salud",'
      '  "nom$nomina"."pension",'
      '  "nom$nomina"."sueldoneto",'
      '  "nom$nomina"."codigo_nomina",'
      '  "nom$nomina"."ap_pension",'
      '  "inv$empleado"."nombre",'
      '  "inv$empleado"."apellido",'
      '  "inv$empleado"."cargo",'
      '  "nom$tiponomina"."descripcion"'
      'FROM'
      '  "nom$nomina"'
      
        '  INNER JOIN "inv$empleado" ON ("nom$nomina"."nit_empleado" = "i' +
        'nv$empleado"."nit")'
      
        '  INNER JOIN "nom$empleado" ON ("nom$nomina"."nit_empleado" = "n' +
        'om$empleado"."nitempleado")'
      
        '  INNER JOIN "nom$tiponomina" ON ("nom$empleado"."tipo_nomina" =' +
        ' "nom$tiponomina"."codigo")'
      'WHERE'
      '  ("nom$nomina"."codigo_nomina" = :codigo)'
      'ORDER BY "inv$empleado"."apellido"')
    Left = 296
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
  end
  object IBvacaciones: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "inv$empleado"."nombre",'
      '  "inv$empleado"."apellido",'
      '  "nom$vacaciones"."nitempleado",'
      '  "nom$vacaciones"."fechasalida",'
      '  "nom$vacaciones"."fechareintegro",'
      '  "nom$vacaciones"."observaciones",'
      '  "nom$vacaciones"."devengado",'
      '  "nom$vacaciones"."numero_dias",'
      '  "nom$vacaciones"."entrada",'
      '  "nom$vacaciones"."salida",'
      '  "inv$empleado"."nit",'
      '  "nom$empleado"."sueldobasico"'
      'FROM'
      '  "nom$vacaciones"'
      
        '  INNER JOIN "inv$empleado" ON ("nom$vacaciones"."nitempleado" =' +
        ' "inv$empleado"."nit")'
      
        '  INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empl' +
        'eado"."nitempleado")'
      'WHERE'
      '  ("nom$vacaciones"."codigo" = :codigo) '
      '  ')
    Left = 64
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
  end
  object IBQuery2: TIBQuery
    Left = 128
    Top = 32
  end
  object IBcausacion: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT'
      '*'
      'FROM'
      '  "nomina"'
      'WHERE'
      '  ("nomina".TIPON in (:tipo,:tipo1))'
      '   and ("nomina"."mes" = :MES);')
    Left = 40
    Top = 264
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'tipo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tipo1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MES'
        ParamType = ptUnknown
      end>
  end
  object IBtabla: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from  "nomina38092.3901052431"')
    Left = 160
    Top = 32
  end
  object IBobligaciones: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "nom$obligaciones"."sueldo",'
      '  "nom$obligaciones"."ano",'
      '  "nom$obligaciones"."horas_extras",'
      '  "nom$obligaciones"."viaticos",'
      '  "nom$obligaciones"."transporte",'
      '  "nom$obligaciones"."p_antiguedad",'
      '  "nom$obligaciones"."p_vacaciones",'
      '  "nom$obligaciones"."p_navidad",'
      '  "nom$obligaciones"."p_servicios",'
      '  "nom$obligaciones"."vacaciones",'
      '  "nom$obligaciones"."bonificacion",'
      '  "nom$obligaciones"."pension",'
      '  "nom$obligaciones"."fsp",'
      '  "inv$empleado"."nombre",'
      '  "inv$empleado"."apellido"'
      'FROM'
      '  "nom$obligaciones"'
      
        '  INNER JOIN "inv$empleado" ON ("nom$obligaciones"."nit" = "inv$' +
        'empleado"."nit")'
      'WHERE'
      '  ("nom$obligaciones"."ano" = :fecha)'
      'order by "inv$empleado"."nombre" ')
    Left = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end>
  end
  object IBreportes: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "nom$tipoprestacion"."codigo",'
      '  "nom$prestacion"."nitentidad",'
      '  "nom$prestacion"."codigo" AS "codigo1",'
      '  "inv$empleado"."nombre",'
      '  "inv$empleado"."apellido",'
      '  "nom$entidad"."descripcion",'
      '  "inv$dependencia"."nombre" AS "nombre1"'
      'FROM'
      '  "nom$tipoprestacion",'
      '  "inv$empleado"'
      
        '  INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empl' +
        'eado"."nitempleado")'
      
        '  INNER JOIN "nom$prestacion" ON ("nom$empleado"."codigo_pension' +
        '" = "nom$prestacion"."codigo")'
      
        '  INNER JOIN "nom$entidad" ON ("nom$prestacion"."nitentidad" = "' +
        'nom$entidad"."nit")'
      
        '  INNER JOIN "inv$dependencia" ON ("inv$empleado"."cod_dependenc' +
        'ia" = "inv$dependencia"."cod_dependencia")'
      'WHERE'
      
        '  ("nom$tipoprestacion"."codigo" = "nom$prestacion"."tipoprestac' +
        'ion")')
    Left = 160
    Top = 64
  end
  object Ibriesgos: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "nom$tipoprestacion"."codigo",'
      '  "nom$prestacion"."nitentidad",'
      '  "nom$prestacion"."codigo" AS "codigo1",'
      '  "inv$empleado"."nombre",'
      '  "inv$empleado"."apellido",'
      '  "nom$entidad"."descripcion",'
      '  "inv$dependencia"."nombre" AS "nombre1"'
      'FROM'
      '  "nom$tipoprestacion",'
      '  "inv$empleado"'
      
        '  INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empl' +
        'eado"."nitempleado")'
      
        '  INNER JOIN "nom$prestacion" ON ("nom$empleado"."codigo_riesgo"' +
        ' = "nom$prestacion"."codigo")'
      
        '  INNER JOIN "nom$entidad" ON ("nom$prestacion"."nitentidad" = "' +
        'nom$entidad"."nit")'
      
        '  INNER JOIN "inv$dependencia" ON ("inv$empleado"."cod_dependenc' +
        'ia" = "inv$dependencia"."cod_dependencia")'
      'WHERE'
      
        '  ("nom$tipoprestacion"."codigo" = "nom$prestacion"."tipoprestac' +
        'ion")')
    Left = 192
    Top = 32
  end
  object IBsalud: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "nom$tipoprestacion"."codigo",'
      '  "nom$prestacion"."nitentidad",'
      '  "nom$prestacion"."codigo" AS "codigo1",'
      '  "inv$empleado"."nombre",'
      '  "inv$empleado"."apellido",'
      '  "nom$entidad"."descripcion",'
      '  "inv$dependencia"."nombre" AS "nombre1"'
      'FROM'
      '  "nom$tipoprestacion",'
      '  "inv$empleado"'
      
        '  INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empl' +
        'eado"."nitempleado")'
      
        '  INNER JOIN "nom$prestacion" ON ("nom$empleado"."codigo_salud" ' +
        '= "nom$prestacion"."codigo")'
      
        '  INNER JOIN "nom$entidad" ON ("nom$prestacion"."nitentidad" = "' +
        'nom$entidad"."nit")'
      
        '  INNER JOIN "inv$dependencia" ON ("inv$empleado"."cod_dependenc' +
        'ia" = "inv$dependencia"."cod_dependencia")'
      'WHERE'
      
        '  ("nom$tipoprestacion"."codigo" = "nom$prestacion"."tipoprestac' +
        'ion")')
    Left = 192
    Top = 64
  end
  object CDtabla: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'nombre'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'sueldo'
        DataType = ftCurrency
      end
      item
        Name = 'nit'
        DataType = ftInteger
      end
      item
        Name = 'eps'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'arp'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'afp'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'fecha'
        DataType = ftDate
      end
      item
        Name = 'cuenta'
        DataType = ftInteger
      end
      item
        Name = 'nomina'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'tiponomina'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 184
    Top = 112
    Data = {
      F70000009619E0BD01000000180000000A000000000003000000F700066E6F6D
      6272650100490000000100055749445448020002006400067375656C646F0800
      04000000010007535542545950450200490006004D6F6E657900036E69740400
      0100000000000365707301004900000001000557494454480200020032000361
      7270010049000000010005574944544802000200320003616670010049000000
      0100055749445448020002003200056665636861040006000000000006637565
      6E74610400010000000000066E6F6D696E610100490000000100055749445448
      0200020014000A7469706F6E6F6D696E6104000100000000000000}
    object CDtablanombre: TStringField
      FieldName = 'nombre'
      Size = 100
    end
    object CDtablasueldo: TCurrencyField
      FieldName = 'sueldo'
    end
    object CDtablanit: TIntegerField
      FieldName = 'nit'
    end
    object CDtablaeps: TStringField
      FieldName = 'eps'
      Size = 50
    end
    object CDtablaarp: TStringField
      FieldName = 'arp'
      Size = 50
    end
    object CDtablaafp: TStringField
      FieldName = 'afp'
      Size = 50
    end
    object CDtablafecha: TDateField
      FieldName = 'fecha'
    end
    object CDtablacuenta: TIntegerField
      FieldName = 'cuenta'
    end
    object CDtablanomina: TStringField
      FieldName = 'nomina'
    end
    object CDtablatiponomina: TIntegerField
      FieldName = 'tiponomina'
    end
  end
  object IBinforme: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      
        '  "inv$empleado"."nombre" || '#39' '#39' || "inv$empleado"."apellido" AS' +
        ' "nombres",'
      '  "nom$empleado"."numero_cuenta",'
      '  "nom$empleado"."sueldobasico",'
      '  "nom$empleado"."fecha_registro",'
      '  "nom$tiponomina"."descripcion",'
      '  "nom$tiponomina"."codigo"'
      'FROM'
      '  "nom$empleado"'
      
        '  INNER JOIN "inv$empleado" ON ("nom$empleado"."nitempleado" = "' +
        'inv$empleado"."nit"),'
      '  "nom$tiponomina"'
      'WHERE'
      '  ("nom$empleado"."tipo_nomina" = "nom$tiponomina"."codigo")')
    Left = 120
    Top = 96
  end
  object CDhoras: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 136
    Data = {
      C50000009619E0BD010000001800000005000000000003000000C500066E6F6D
      627265010049000000010005574944544802000200640006646975726E6F0800
      04000000010007535542545950450200490006004D6F6E657900076665637469
      766F080004000000010007535542545950450200490006004D6F6E6579000964
      6F6D696E6963616C080004000000010007535542545950450200490006004D6F
      6E6579000662617369636F080004000000010007535542545950450200490006
      004D6F6E6579000000}
    object CDhorasnombre: TStringField
      FieldName = 'nombre'
      Size = 100
    end
    object CDhorasdiurno: TCurrencyField
      FieldName = 'diurno'
    end
    object CDhorasfectivo: TCurrencyField
      FieldName = 'fectivo'
    end
    object CDhorasdominical: TCurrencyField
      FieldName = 'dominical'
    end
    object CDhorasbasico: TCurrencyField
      FieldName = 'basico'
    end
  end
  object IBconsolidadas: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "nom$consolidado"."vacaciones",'
      '"nom$consolidado"."cesantia",'
      '  "nom$consolidado"."prima_vacaciones",'
      '  "nom$consolidado"."prima_ant",'
      '  "inv$empleado"."nombre",'
      '  "inv$empleado"."apellido"'
      'FROM'
      '  "nom$consolidado"'
      
        '  INNER JOIN "inv$empleado" ON ("nom$consolidado"."nit" = "inv$e' +
        'mpleado"."nit")'
      'ORDER BY   "inv$empleado"."nombre"')
    Left = 24
    Top = 224
  end
  object CDPago: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'nombres'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'valor'
        DataType = ftCurrency
      end
      item
        Name = 'cedula'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'retefuente'
        DataType = ftCurrency
      end
      item
        Name = 'cuenta'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 152
    Top = 232
    Data = {
      B50000009619E0BD010000001800000005000000000003000000B500076E6F6D
      6272657301004900000001000557494454480200020064000576616C6F720800
      04000000010007535542545950450200490006004D6F6E65790006636564756C
      610100490000000100055749445448020002000F000A726574656675656E7465
      080004000000010007535542545950450200490006004D6F6E65790006637565
      6E746101004900000001000557494454480200020014000000}
    object CDPagonombres: TStringField
      FieldName = 'nombres'
      Size = 100
    end
    object CDPagovalor: TCurrencyField
      FieldName = 'valor'
    end
    object CDPagocedula: TStringField
      FieldName = 'cedula'
      Size = 15
    end
    object CDPagoretefuente: TCurrencyField
      FieldName = 'retefuente'
    end
    object CDPagocuenta: TStringField
      FieldName = 'cuenta'
    end
  end
  object CDhora: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'nombres'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'hdiurna'
        DataType = ftCurrency
      end
      item
        Name = 'vdiurna'
        DataType = ftCurrency
      end
      item
        Name = 'hfestivo'
        DataType = ftCurrency
      end
      item
        Name = 'vfestivo'
        DataType = ftCurrency
      end
      item
        Name = 'hdominical'
        DataType = ftCurrency
      end
      item
        Name = 'vdominical'
        DataType = ftCurrency
      end
      item
        Name = 'hnocturno'
        DataType = ftCurrency
      end
      item
        Name = 'vnocturno'
        DataType = ftCurrency
      end
      item
        Name = 'horad'
        DataType = ftCurrency
      end
      item
        Name = 'valorn'
        DataType = ftCurrency
      end
      item
        Name = 'horaord'
        DataType = ftCurrency
      end
      item
        Name = 'vhoraord'
        DataType = ftCurrency
      end
      item
        Name = 'hotra'
        DataType = ftCurrency
      end
      item
        Name = 'votra'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 88
    Top = 224
    Data = {
      340200009619E0BD01000000180000000F0000000000030000003402076E6F6D
      6272657301004900000001000557494454480200020064000768646975726E61
      080004000000010007535542545950450200490006004D6F6E65790007766469
      75726E61080004000000010007535542545950450200490006004D6F6E657900
      08686665737469766F080004000000010007535542545950450200490006004D
      6F6E65790008766665737469766F080004000000010007535542545950450200
      490006004D6F6E6579000A68646F6D696E6963616C0800040000000100075355
      42545950450200490006004D6F6E6579000A76646F6D696E6963616C08000400
      0000010007535542545950450200490006004D6F6E65790009686E6F63747572
      6E6F080004000000010007535542545950450200490006004D6F6E6579000976
      6E6F637475726E6F080004000000010007535542545950450200490006004D6F
      6E65790005686F72616408000400000001000753554254595045020049000600
      4D6F6E6579000676616C6F726E08000400000001000753554254595045020049
      0006004D6F6E65790007686F72616F7264080004000000010007535542545950
      450200490006004D6F6E6579000876686F72616F726408000400000001000753
      5542545950450200490006004D6F6E65790005686F7472610800040000000100
      07535542545950450200490006004D6F6E65790005766F747261080004000000
      010007535542545950450200490006004D6F6E6579000000}
    object CDhoranombres: TStringField
      FieldName = 'nombres'
      Size = 100
    end
    object CDhorahdiurna: TCurrencyField
      FieldName = 'hdiurna'
    end
    object CDhoravdiurna: TCurrencyField
      FieldName = 'vdiurna'
    end
    object CDhorahfestivo: TCurrencyField
      FieldName = 'hfestivo'
    end
    object CDhoravfestivo: TCurrencyField
      FieldName = 'vfestivo'
    end
    object CDhorahdominical: TCurrencyField
      FieldName = 'hdominical'
    end
    object CDhoravdominical: TCurrencyField
      FieldName = 'vdominical'
    end
    object CDhorahnocturno: TCurrencyField
      FieldName = 'hnocturno'
    end
    object CDhoravnocturno: TCurrencyField
      FieldName = 'vnocturno'
    end
    object CDhorahorad: TCurrencyField
      FieldName = 'horad'
    end
    object CDhoravalorn: TCurrencyField
      FieldName = 'valorn'
    end
    object CDhorahoraord: TCurrencyField
      FieldName = 'horaord'
    end
    object CDhoravhoraord: TCurrencyField
      FieldName = 'vhoraord'
    end
    object CDhorahotra: TCurrencyField
      FieldName = 'hotra'
    end
    object CDhoravotra: TCurrencyField
      FieldName = 'votra'
    end
  end
  object IBQuery3: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "nom$tiponomina"."descripcion",'
      '  "nom$tiponomina"."valor"'
      'FROM'
      '  "nom$tiponomina"'
      'WHERE'
      '  ("nom$tiponomina"."valor" <> 0)')
    Left = 376
    Top = 216
  end
  object frDBDataSet4: TfrDBDataSet
    DataSet = IBQuery3
    Left = 392
    Top = 32
  end
  object IBInteres: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "Inv$Agencia"."descripcion",'
      '  "nomina"."nombre",'
      '  "nomina"."nit",'
      '  "nomina"."interes"'
      'FROM'
      '  "nomina"'
      
        '  INNER JOIN "Inv$Agencia" ON ("nomina"."tipo_nomina" = "Inv$Age' +
        'ncia"."cod_agencia")'
      'WHERE'
      '  ("nomina"."tipo_nomina" = :tipo) and ("nomina"."mes" = 12)'
      'ORDER BY'
      '  "nomina"."nombre"')
    Left = 376
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'tipo'
        ParamType = ptUnknown
      end>
  end
  object frDBDataSet5: TfrDBDataSet
    DataSet = IBInteres
    Left = 408
    Top = 128
  end
  object frRtfAdvExport1: TfrRtfAdvExport
    Left = 320
  end
  object frTIFFExport1: TfrTIFFExport
    Left = 288
  end
  object frOLEExcelExport1: TfrOLEExcelExport
    Left = 272
  end
  object IBpension: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "inv$empleado"."nombre",'
      '  "inv$empleado"."apellido",'
      '  "nom$pension"."valor",'
      '  "inv$empleado"."nit",'
      '  "nom$prestacion"."codigo",'
      '  "nom$entidad"."descripcion"'
      'FROM'
      ' "inv$empleado"'
      
        ' INNER JOIN "nom$pension" ON ("inv$empleado"."nit"="nom$pension"' +
        '."id_persona")'
      
        ' INNER JOIN "nom$empleado" ON ("inv$empleado"."nit"="nom$emplead' +
        'o"."nitempleado")'
      
        ' INNER JOIN "nom$prestacion" ON ("nom$empleado"."codigo_pension"' +
        '="nom$prestacion"."codigo")'
      
        ' INNER JOIN "nom$entidad" ON ("nom$prestacion"."nitentidad"="nom' +
        '$entidad"."nit")')
    Left = 224
    Top = 144
  end
  object frDBpension: TfrDBDataSet
    DataSet = IBpension
    Left = 376
    Top = 104
  end
  object IBNomina1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "nom$nomina"."nit_empleado",'
      '  "nom$nomina"."ibc",'
      '  "nom$nomina"."sueldobasico",'
      '  "inv$empleado"."apellido",'
      '  "inv$empleado"."nombre",'
      '  "nom$nomina"."dias_trabajados",'
      '  "nom$nomina"."total_basico",'
      '  "nom$nomina"."horas_extras",'
      '  "nom$nomina"."transporte",'
      '  "nom$nomina"."total_devengado",'
      '  "nom$nomina"."libranza",'
      '  "nom$nomina"."cporcobrar",'
      '  "nom$nomina"."fsp",'
      '  "nom$nomina"."retefuente",'
      '  "nom$nomina"."salud",'
      '  "nom$nomina"."pension",'
      '  "nom$nomina"."sueldoneto",'
      '  "nom$nomina"."ap_pension",'
      '  "nom$recuperanomina"."tipo_nomina",'
      '  "nom$recuperanomina"."cuenta"'
      'FROM'
      ' "nom$nomina"'
      
        ' INNER JOIN "nom$recuperanomina" ON ("nom$nomina"."nit_empleado"' +
        '="nom$recuperanomina"."nit_empleado")'
      
        ' INNER JOIN "inv$empleado" ON ("inv$empleado"."nit"="nom$recuper' +
        'anomina"."nit_empleado")'
      'WHERE'
      '  ("nom$nomina"."codigo_nomina" = :codigo) AND '
      '  ("nom$recuperanomina"."tipo_nomina" = :tiponomina)'
      'ORDER BY'
      '  "inv$empleado"."apellido"')
    Left = 192
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tiponomina'
        ParamType = ptUnknown
      end>
  end
  object CDobligacion: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'nombre'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'horas'
        DataType = ftCurrency
      end
      item
        Name = 'sueldo'
        DataType = ftCurrency
      end
      item
        Name = 'viaticos'
        DataType = ftCurrency
      end
      item
        Name = 'atransporte'
        DataType = ftCurrency
      end
      item
        Name = 'pantiguedad'
        DataType = ftCurrency
      end
      item
        Name = 'pvacacion'
        DataType = ftCurrency
      end
      item
        Name = 'pnavidad'
        DataType = ftCurrency
      end
      item
        Name = 'pservicios'
        DataType = ftCurrency
      end
      item
        Name = 'vacaciones'
        DataType = ftCurrency
      end
      item
        Name = 'bonificacion'
        DataType = ftCurrency
      end
      item
        Name = 'salud'
        DataType = ftCurrency
      end
      item
        Name = 'pension'
        DataType = ftCurrency
      end
      item
        Name = 'fsp'
        DataType = ftCurrency
      end
      item
        Name = 'retefuente'
        DataType = ftCurrency
      end
      item
        Name = 'int_cesantias'
        DataType = ftCurrency
      end
      item
        Name = 'cesantias'
        DataType = ftCurrency
      end
      item
        Name = 'nit'
        DataType = ftInteger
      end
      item
        Name = 'grep'
        DataType = ftCurrency
      end
      item
        Name = 'apension'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 392
    Top = 288
    Data = {
      E00200009619E0BD010000001800000014000000000003000000E002066E6F6D
      627265020049000000010005574944544802000200FF0005686F726173080004
      000000010007535542545950450200490006004D6F6E657900067375656C646F
      080004000000010007535542545950450200490006004D6F6E65790008766961
      7469636F73080004000000010007535542545950450200490006004D6F6E6579
      000B617472616E73706F72746508000400000001000753554254595045020049
      0006004D6F6E6579000B70616E74696775656461640800040000000100075355
      42545950450200490006004D6F6E65790009707661636163696F6E0800040000
      00010007535542545950450200490006004D6F6E65790008706E617669646164
      080004000000010007535542545950450200490006004D6F6E6579000A707365
      72766963696F73080004000000010007535542545950450200490006004D6F6E
      6579000A7661636163696F6E6573080004000000010007535542545950450200
      490006004D6F6E6579000C626F6E696669636163696F6E080004000000010007
      535542545950450200490006004D6F6E6579000573616C756408000400000001
      0007535542545950450200490006004D6F6E6579000770656E73696F6E080004
      000000010007535542545950450200490006004D6F6E65790003667370080004
      000000010007535542545950450200490006004D6F6E6579000A726574656675
      656E7465080004000000010007535542545950450200490006004D6F6E657900
      0D696E745F636573616E74696173080004000000010007535542545950450200
      490006004D6F6E65790009636573616E74696173080004000000010007535542
      545950450200490006004D6F6E657900036E6974040001000000000004677265
      70080004000000010007535542545950450200490006004D6F6E657900086170
      656E73696F6E080004000000010007535542545950450200490006004D6F6E65
      79000000}
    object CDobligacionnombre: TStringField
      FieldName = 'nombre'
      Size = 255
    end
    object CDobligacionhoras: TCurrencyField
      FieldName = 'horas'
    end
    object CDobligacionsueldo: TCurrencyField
      FieldName = 'sueldo'
    end
    object CDobligacionviaticos: TCurrencyField
      FieldName = 'viaticos'
    end
    object CDobligacionatransporte: TCurrencyField
      FieldName = 'atransporte'
    end
    object CDobligacionpantiguedad: TCurrencyField
      FieldName = 'pantiguedad'
    end
    object CDobligacionpvacacion: TCurrencyField
      FieldName = 'pvacacion'
    end
    object CDobligacionpnavidad: TCurrencyField
      FieldName = 'pnavidad'
    end
    object CDobligacionpservicios: TCurrencyField
      FieldName = 'pservicios'
    end
    object CDobligacionvacaciones: TCurrencyField
      FieldName = 'vacaciones'
    end
    object CDobligacionbonificacion: TCurrencyField
      FieldName = 'bonificacion'
    end
    object CDobligacionsalud: TCurrencyField
      FieldName = 'salud'
    end
    object CDobligacionpension: TCurrencyField
      FieldName = 'pension'
    end
    object CDobligacionfsp: TCurrencyField
      FieldName = 'fsp'
    end
    object CDobligacionfspretefuente: TCurrencyField
      FieldName = 'retefuente'
    end
    object CDobligacionint_cesantias: TCurrencyField
      FieldName = 'int_cesantias'
    end
    object CDobligacioncesantias: TCurrencyField
      FieldName = 'cesantias'
    end
    object CDobligacionnit: TIntegerField
      FieldName = 'nit'
    end
    object CDobligaciongrep: TCurrencyField
      FieldName = 'grep'
    end
    object CDobligacionapension: TCurrencyField
      FieldName = 'apension'
    end
  end
  object IBcalObligacion: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction2
    Left = 8
    Top = 296
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 40
    Top = 296
  end
  object frDBDataSet6: TfrDBDataSet
    DataSet = CDobligacion
    Left = 360
    Top = 288
  end
  object frTIFFExport2: TfrTIFFExport
    Left = 88
    Top = 136
  end
  object IB360: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT'
      '*'
      'FROM'
      '  "nomina"'
      'WHERE'
      '  ("nomina".TIPON in (:tipo,:tipo1))'
      '   and ("nomina"."mes" = :MES)'
      '   and "nomina"."PRIMAV360" > 0')
    Left = 408
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'tipo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tipo1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'MES'
        ParamType = ptUnknown
      end>
  end
  object frDB360: TfrDBDataSet
    DataSet = IB360
    Left = 376
    Top = 176
  end
end
