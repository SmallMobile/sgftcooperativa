object FrmPrograma: TFrmPrograma
  Left = 516
  Top = 239
  Width = 431
  Height = 420
  BorderIcons = []
  Caption = 'Actualizar Datos'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 423
    Height = 170
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 57
      Width = 50
      Height = 13
      Caption = 'Nombres'
    end
    object Label2: TLabel
      Left = 191
      Top = 109
      Width = 29
      Height = 13
      Caption = 'Sexo'
    end
    object Label3: TLabel
      Left = 7
      Top = 31
      Width = 17
      Height = 13
      Caption = 'Nit'
    end
    object Tipo: TLabel
      Left = 191
      Top = 31
      Width = 26
      Height = 13
      Caption = 'Tipo'
    end
    object Label4: TLabel
      Left = 329
      Top = 110
      Width = 41
      Height = 13
      Caption = 'Estrato'
    end
    object Label5: TLabel
      Left = 6
      Top = 3
      Width = 100
      Height = 13
      Caption = 'Datos Personales'
    end
    object Label10: TLabel
      Left = 7
      Top = 136
      Width = 65
      Height = 13
      Caption = 'Parentesco'
    end
    object JvLabel1: TJvLabel
      Left = 7
      Top = 109
      Width = 53
      Height = 13
      Caption = 'Lugar Nit'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object Label12: TLabel
      Left = 8
      Top = 85
      Width = 52
      Height = 13
      Caption = 'Apellidos'
    end
    object Mail: TLabel
      Left = 193
      Top = 141
      Width = 24
      Height = 13
      Caption = 'Mail'
    end
    object TEnombres: TEdit
      Left = 77
      Top = 55
      Width = 156
      Height = 21
      Hint = 'Apellidos y Nombres'
      CharCase = ecUpperCase
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object Csexo: TComboBox
      Left = 234
      Top = 107
      Width = 95
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 7
      Items.Strings = (
        'MASCULINO'
        'FEMENINO')
    end
    object TEestrato: TEdit
      Left = 370
      Top = 107
      Width = 42
      Height = 21
      MaxLength = 1
      TabOrder = 8
    end
    object DBtiponit: TDBLookupComboBox
      Left = 234
      Top = 29
      Width = 184
      Height = 21
      DropDownRows = 4
      KeyField = 'codigo'
      ListField = 'descripcion'
      ListSource = DataSource1
      TabOrder = 1
    end
    object DBparentesco: TDBLookupComboBox
      Left = 77
      Top = 134
      Width = 108
      Height = 21
      KeyField = 'id_parentesco'
      ListField = 'descripcion'
      ListSource = DSparentesco
      TabOrder = 9
      OnExit = DBparentescoExit
    end
    object TEnit: TJvEdit
      Left = 77
      Top = 29
      Width = 107
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
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 0
      OnExit = TEnitExit
    end
    object TElugar: TJvEdit
      Left = 77
      Top = 107
      Width = 107
      Height = 21
      Hint = 'Procedencia de Nit o Numero de Indentificaci'#243'n'
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      CharCase = ecUpperCase
      ParentShowHint = False
      PasswordChar = #0
      ReadOnly = False
      ShowHint = True
      TabOrder = 6
    end
    object nombre1: TEdit
      Left = 236
      Top = 55
      Width = 181
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
    end
    object apellido1: TEdit
      Left = 77
      Top = 82
      Width = 156
      Height = 21
      Hint = 'Apellidos y Nombres'
      CharCase = ecUpperCase
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
    end
    object apellido2: TEdit
      Left = 234
      Top = 83
      Width = 181
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
    end
    object EdMail: TEdit
      Left = 234
      Top = 135
      Width = 178
      Height = 21
      MaxLength = 30
      TabOrder = 10
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 204
    Width = 421
    Height = 149
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Label6: TLabel
      Left = 6
      Top = 3
      Width = 101
      Height = 13
      Caption = 'Datos Residencia'
    end
    object Label7: TLabel
      Left = 7
      Top = 23
      Width = 40
      Height = 13
      Caption = 'Ciudad'
    end
    object Label8: TLabel
      Left = 7
      Top = 48
      Width = 34
      Height = 13
      Caption = 'Barrio'
    end
    object Label9: TLabel
      Left = 6
      Top = 73
      Width = 55
      Height = 13
      Caption = 'Direcci'#243'n'
    end
    object T: TLabel
      Left = 6
      Top = 98
      Width = 57
      Height = 13
      Caption = 'Telefonos'
    end
    object Label11: TLabel
      Left = 6
      Top = 123
      Width = 22
      Height = 13
      Caption = 'Eps'
    end
    object TECiudad: TEdit
      Left = 67
      Top = 21
      Width = 345
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
    object TEBarrio: TEdit
      Left = 67
      Top = 46
      Width = 345
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object TEdireccion: TEdit
      Left = 67
      Top = 71
      Width = 346
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
    end
    object TEtelefono: TEdit
      Left = 67
      Top = 96
      Width = 346
      Height = 21
      TabOrder = 3
    end
    object Eps: TDBLookupComboBox
      Left = 66
      Top = 120
      Width = 347
      Height = 21
      KeyField = 'id_eps'
      ListField = 'descripcion'
      ListSource = DataSource2
      TabOrder = 4
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 354
    Width = 421
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object BCancelar: TSpeedButton
      Left = 250
      Top = 6
      Width = 112
      Height = 22
      Caption = '&Cancelar'
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
      OnClick = BcancelarClick
    end
    object Baceptar: TBitBtn
      Left = 46
      Top = 6
      Width = 112
      Height = 22
      Caption = '&Aceptar'
      TabOrder = 0
      OnClick = BaceptarClick
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
  object JvPanel1: TJvPanel
    Left = 0
    Top = 169
    Width = 422
    Height = 33
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    MultiLine = False
    object Fecha: TLabel
      Left = 82
      Top = 8
      Width = 121
      Height = 13
      Caption = 'Fecha de Nacimiento'
    end
    object Cuenta: TJvLabel
      Left = 252
      Top = 10
      Width = 41
      Height = 13
      Caption = 'Cuenta'
      Visible = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object TEcuenta: TJvEdit
      Left = 296
      Top = 6
      Width = 108
      Height = 21
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 1
      Visible = False
    end
    object DTfecha: TMaskEdit
      Left = 215
      Top = 6
      Width = 109
      Height = 21
      EditMask = '!9999/99/99;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '    /  /  '
    end
  end
  object IBtipo: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTtipo
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "fun$tipoidentificacion"."codigo",'
      '  "fun$tipoidentificacion"."descripcion"'
      'FROM'
      '  "fun$tipoidentificacion"')
    Left = 288
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = IBtipo
    Left = 240
    Top = 8
  end
  object IBTtipo: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 336
    Top = 16
  end
  object IBparentesco: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTtipo
    SQL.Strings = (
      'SELECT '
      '  "fun$parentesco"."id_parentesco",'
      '  "fun$parentesco"."descripcion"'
      'FROM'
      '  "fun$parentesco"'
      'ORDER BY "fun$parentesco"."descripcion"')
    Left = 128
    Top = 224
  end
  object DSparentesco: TDataSource
    DataSet = IBparentesco
    Left = 160
    Top = 256
  end
  object DataSource2: TDataSource
    DataSet = IBEps
    Left = 24
    Top = 144
  end
  object IBEps: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  *'
      'FROM'
      '  "fun$eps"')
    Left = 64
    Top = 144
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 256
    Top = 40
  end
end
