object FrmEmpleado: TFrmEmpleado
  Left = 350
  Top = 257
  Width = 419
  Height = 369
  BorderIcons = []
  Caption = 'Registrar Empleado'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 0
    Width = 409
    Height = 186
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 0
      Width = 93
      Height = 13
      Caption = 'Datos Empleado'
    end
    object Label2: TLabel
      Left = 11
      Top = 21
      Width = 50
      Height = 13
      Caption = 'Nombres'
    end
    object Label3: TLabel
      Left = 11
      Top = 50
      Width = 47
      Height = 13
      Caption = 'Agencia'
    end
    object Label4: TLabel
      Left = 232
      Top = 53
      Width = 40
      Height = 13
      Caption = 'Fecha '
    end
    object Label5: TLabel
      Left = 11
      Top = 119
      Width = 59
      Height = 13
      Caption = 'T. Nomina'
    end
    object Label10: TLabel
      Left = 233
      Top = 86
      Width = 40
      Height = 13
      Caption = 'Salario'
    end
    object Label11: TLabel
      Left = 11
      Top = 86
      Width = 65
      Height = 13
      Caption = 'No. Cuenta'
    end
    object Label12: TLabel
      Left = 11
      Top = 148
      Width = 24
      Height = 13
      Caption = 'Mail'
    end
    object empleadonit: TComboBox
      Left = 232
      Top = 183
      Width = 41
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'empleadonit'
      Visible = False
    end
    object empleado: TComboBox
      Left = 86
      Top = 18
      Width = 315
      Height = 21
      Style = csDropDownList
      CharCase = ecUpperCase
      DropDownCount = 5
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemHeight = 13
      ParentFont = False
      TabOrder = 1
      OnExit = empleadoExit
      OnKeyPress = empleadoKeyPress
    end
    object Fecha: TDateTimePicker
      Left = 281
      Top = 50
      Width = 124
      Height = 21
      CalAlignment = dtaLeft
      Date = 38050.4591710069
      Format = 'dd/MM/yyyy'
      Time = 38050.4591710069
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
      OnKeyPress = FechaKeyPress
    end
    object TipoNomina: TDBLookupComboBox
      Left = 86
      Top = 116
      Width = 142
      Height = 21
      KeyField = 'codigo'
      ListField = 'descripcion'
      ListSource = DStiponomina
      TabOrder = 3
      OnExit = TipoNominaExit
      OnKeyPress = TipoNominaKeyPress
    end
    object salario: TJvCurrencyEdit
      Left = 282
      Top = 83
      Width = 119
      Height = 21
      Alignment = taRightJustify
      ReadOnly = False
      TabOrder = 4
      OnKeyPress = salarioKeyPress
      HasMaxValue = False
      HasMinValue = False
    end
    object cuenta: TJvEdit
      Left = 85
      Top = 84
      Width = 141
      Height = 21
      Alignment = taRightJustify
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 5
      OnExit = cuentaExit
      OnKeyPress = cuentaKeyPress
    end
    object Chtransporte: TCheckBox
      Left = 232
      Top = 118
      Width = 80
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Transporte'
      TabOrder = 6
      OnKeyPress = ChtransporteKeyPress
    end
    object CHtiempo: TCheckBox
      Left = 315
      Top = 118
      Width = 86
      Height = 17
      Alignment = taLeftJustify
      Caption = '1/2 Tiempo'
      TabOrder = 7
    end
    object seccion: TEdit
      Left = 302
      Top = 179
      Width = 142
      Height = 21
      TabStop = False
      ReadOnly = True
      TabOrder = 8
      Visible = False
    end
    object DbAgencia: TDBLookupComboBox
      Left = 85
      Top = 51
      Width = 139
      Height = 21
      KeyField = 'cod_agencia'
      ListField = 'descripcion'
      ListSource = DsAgencia
      TabOrder = 9
      OnKeyPress = DbAgenciaKeyPress
    end
    object EdMail: TEdit
      Left = 86
      Top = 145
      Width = 315
      Height = 21
      TabOrder = 10
      OnKeyPress = EdMailKeyPress
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 298
    Width = 409
    Height = 36
    Color = clOlive
    TabOrder = 1
    object Cancelar: TSpeedButton
      Left = 140
      Top = 7
      Width = 126
      Height = 25
      Caption = '&Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000220B0000220B000000010000000100000031DE000031
        E7000031EF000031F700FF00FF000031FF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00040404040404
        0404040404040404000004000004040404040404040404000004040000000404
        0404040404040000040404000000000404040404040000040404040402000000
        0404040400000404040404040404000000040000000404040404040404040400
        0101010004040404040404040404040401010204040404040404040404040400
        0201020304040404040404040404030201040403030404040404040404050203
        0404040405030404040404040303050404040404040303040404040303030404
        0404040404040403040403030304040404040404040404040404030304040404
        0404040404040404040404040404040404040404040404040404}
      ParentFont = False
      OnClick = CancelarClick
    end
    object Salir: TSpeedButton
      Left = 275
      Top = 7
      Width = 126
      Height = 25
      Caption = '&Salir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
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
      ParentFont = False
      OnClick = SalirClick
    end
    object BACEPTAR: TBitBtn
      Left = 7
      Top = 7
      Width = 126
      Height = 25
      Caption = '&Registrar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = BACEPTARClick
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
  end
  object Panel2: TPanel
    Left = 0
    Top = 187
    Width = 409
    Height = 111
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Label6: TLabel
      Left = 7
      Top = 4
      Width = 72
      Height = 13
      Caption = 'Otros Datos '
    end
    object Label7: TLabel
      Left = 11
      Top = 22
      Width = 61
      Height = 13
      Caption = 'Salud EPS'
    end
    object Label8: TLabel
      Left = 11
      Top = 51
      Width = 86
      Height = 13
      Caption = 'Pensiones AFP'
    end
    object Label9: TLabel
      Left = 11
      Top = 81
      Width = 75
      Height = 13
      Caption = 'Riesgos ARP'
    end
    object DBsalud: TDBLookupComboBox
      Left = 111
      Top = 18
      Width = 226
      Height = 21
      KeyField = 'codigo'
      ListField = 'descripcion'
      ListSource = DSsalud
      TabOrder = 0
      OnExit = DBsaludExit
      OnKeyPress = DBsaludKeyPress
    end
    object DBpension: TDBLookupComboBox
      Left = 112
      Top = 48
      Width = 225
      Height = 21
      KeyField = 'codigo'
      ListField = 'descripcion'
      ListSource = DSpension
      TabOrder = 1
      OnExit = DBpensionExit
      OnKeyPress = DBpensionKeyPress
    end
    object DBriesgos: TDBLookupComboBox
      Left = 112
      Top = 80
      Width = 225
      Height = 21
      KeyField = 'codigo'
      ListField = 'descripcion'
      ListSource = DSriesgo
      TabOrder = 2
      OnExit = DBriesgosExit
      OnKeyPress = DBriesgosKeyPress
    end
  end
  object busca_nombre: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      
        'select "inv$empleado"."nit","inv$dependencia"."nombre" as nombre' +
        ','
      '"inv$empleado"."cod_dependencia"'
      'from "inv$empleado","inv$dependencia"'
      
        'where "inv$empleado"."nombre"||"inv$empleado"."apellido" =:"nomb' +
        're" and  "inv$empleado"."cod_dependencia"='
      '"inv$dependencia"."cod_dependencia"')
    Left = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'nombre'
        ParamType = ptUnknown
      end>
  end
  object IBTiponomina: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBtrantiponomina
    SQL.Strings = (
      'select * from "nom$tiponomina"')
    Left = 16
    Top = 232
  end
  object DStiponomina: TDataSource
    DataSet = IBTiponomina
    Left = 48
  end
  object IBtrantiponomina: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
  end
  object IBTransempresa: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 48
    Top = 232
  end
  object IBsalud: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransempresa
    SQL.Strings = (
      'SELECT '
      '  "nom$entidad"."descripcion",'
      '  "nom$prestacion"."codigo"'
      'FROM'
      '  "nom$entidad",'
      '  "nom$tipoprestacion",'
      '  "nom$prestacion"'
      'WHERE'
      '  ("nom$prestacion"."nitentidad" = "nom$entidad"."nit") AND '
      
        '  ("nom$tipoprestacion"."codigo" = "nom$prestacion"."tipoprestac' +
        'ion") AND '
      '  ("nom$prestacion"."tipoprestacion" = 100)')
    Left = 24
    Top = 176
  end
  object DSsalud: TDataSource
    DataSet = IBsalud
    Top = 184
  end
  object IBbuscaservicio: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "nom$entidad"."descripcion"'
      'FROM'
      '  "nom$entidad",'
      '  "nom$tipoprestacion",'
      '  "nom$prestacion"'
      'WHERE'
      '  ("nom$prestacion"."nitentidad" = "nom$entidad"."nit") AND '
      
        '  ("nom$tipoprestacion"."codigo" = "nom$prestacion"."tipoprestac' +
        'ion") AND '
      '  ("nom$tipoprestacion"."codigo" = :codigo)')
    Left = 312
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
  end
  object IBriesgo: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransempresa
    SQL.Strings = (
      'SELECT '
      '  "nom$entidad"."descripcion",'
      '  "nom$prestacion"."codigo"'
      'FROM'
      '  "nom$entidad",'
      '  "nom$tipoprestacion",'
      '  "nom$prestacion"'
      'WHERE'
      '  ("nom$prestacion"."nitentidad" = "nom$entidad"."nit") AND '
      
        '  ("nom$tipoprestacion"."codigo" = "nom$prestacion"."tipoprestac' +
        'ion") AND '
      '  ("nom$prestacion"."tipoprestacion" = 300)')
    Left = 24
    Top = 176
  end
  object IBpension: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransempresa
    SQL.Strings = (
      'SELECT '
      '  "nom$entidad"."descripcion",'
      '  "nom$prestacion"."codigo"'
      'FROM'
      '  "nom$entidad",'
      '  "nom$tipoprestacion",'
      '  "nom$prestacion"'
      'WHERE'
      '  ("nom$prestacion"."nitentidad" = "nom$entidad"."nit") AND '
      
        '  ("nom$tipoprestacion"."codigo" = "nom$prestacion"."tipoprestac' +
        'ion") AND '
      '  ("nom$prestacion"."tipoprestacion" = 200)')
    Left = 64
    Top = 224
  end
  object DSpension: TDataSource
    DataSet = IBpension
    Left = 104
    Top = 232
  end
  object DSriesgo: TDataSource
    DataSet = IBriesgo
    Top = 208
  end
  object DsAgencia: TDataSource
    DataSet = IBagencia
    Left = 280
    Top = 56
  end
  object IBagencia: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBtrantiponomina
    SQL.Strings = (
      'SELECT '
      '  "Inv$Agencia"."cod_agencia",'
      '  "Inv$Agencia"."descripcion"'
      'FROM'
      ' "Inv$Agencia"')
    Left = 240
    Top = 24
  end
end
