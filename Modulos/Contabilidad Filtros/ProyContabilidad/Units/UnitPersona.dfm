object FrmPersona: TFrmPersona
  Left = 159
  Top = 108
  Width = 610
  Height = 390
  BorderIcons = [biSystemMenu]
  Caption = 'FrmPersona'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 473
    Height = 41
    Caption = 'Panel1'
    TabOrder = 2
  end
  object Panel2: TPanel
    Left = 473
    Top = 0
    Width = 128
    Height = 353
    Caption = 'Panel2'
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 11
      Top = 10
      Width = 89
      Height = 25
      Caption = '&Aplicar'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 11
      Top = 50
      Width = 89
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 11
      Top = 90
      Width = 89
      Height = 25
      Caption = '&Cerrar'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 39
    Width = 473
    Height = 162
    Caption = 'Informacion Personal'
    TabOrder = 0
    object Label49: TLabel
      Left = 6
      Top = 16
      Width = 94
      Height = 13
      Caption = 'Tipo de Documento'
    end
    object Label50: TLabel
      Left = 270
      Top = 16
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object Label1: TLabel
      Left = 8
      Top = 36
      Width = 69
      Height = 13
      Caption = 'Primer Nombre'
    end
    object Label2: TLabel
      Left = 240
      Top = 36
      Width = 69
      Height = 13
      Caption = 'Primer Nombre'
    end
    object Label3: TLabel
      Left = 8
      Top = 75
      Width = 69
      Height = 13
      Caption = 'Primer Apellido'
    end
    object Label4: TLabel
      Left = 240
      Top = 75
      Width = 83
      Height = 13
      Caption = 'Segundo Apellido'
    end
    object Label5: TLabel
      Left = 9
      Top = 114
      Width = 25
      Height = 13
      Caption = 'Email'
    end
    object Label6: TLabel
      Left = 241
      Top = 114
      Width = 101
      Height = 13
      Caption = 'Fecha de Nacimiento'
    end
    object EdIdentificacion: TMemo
      Left = 312
      Top = 13
      Width = 155
      Height = 21
      Alignment = taRightJustify
      TabOrder = 1
      WantReturns = False
      WordWrap = False
      OnExit = EdIdentificacionExit
      OnKeyPress = DBtipoKeyPress
    end
    object EdNombre1: TEdit
      Left = 9
      Top = 52
      Width = 228
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
      OnKeyPress = DBtipoKeyPress
    end
    object EdNombre2: TEdit
      Left = 241
      Top = 52
      Width = 229
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 3
      OnKeyPress = DBtipoKeyPress
    end
    object EdApellido1: TEdit
      Left = 9
      Top = 91
      Width = 228
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
      OnKeyPress = DBtipoKeyPress
    end
    object EdApellido2: TEdit
      Left = 240
      Top = 91
      Width = 227
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
      OnKeyPress = DBtipoKeyPress
    end
    object EdMail: TEdit
      Left = 10
      Top = 130
      Width = 228
      Height = 21
      TabOrder = 6
      OnKeyPress = DBtipoKeyPress
    end
    object DtFecha: TDateTimePicker
      Left = 241
      Top = 130
      Width = 227
      Height = 21
      CalAlignment = dtaLeft
      Date = 39657.748366169
      Time = 39657.748366169
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 7
      OnKeyPress = DBtipoKeyPress
    end
    object DBtipo: TDBLookupComboBox
      Left = 104
      Top = 13
      Width = 165
      Height = 21
      KeyField = 'ID_IDENTIFICACION'
      ListField = 'DESCRIPCION_IDENTIFICACION'
      ListSource = DsTipo
      TabOrder = 0
      OnEnter = DBtipoEnter
      OnKeyPress = DBtipoKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 202
    Width = 473
    Height = 151
    Caption = 'Informacion Direccion Residencia'
    TabOrder = 1
    object Label7: TLabel
      Left = 6
      Top = 15
      Width = 45
      Height = 13
      Caption = 'Direccion'
    end
    object Label8: TLabel
      Left = 6
      Top = 51
      Width = 27
      Height = 13
      Caption = 'Barrio'
    end
    object Label9: TLabel
      Left = 238
      Top = 51
      Width = 45
      Height = 13
      Caption = 'Municipio'
    end
    object Label10: TLabel
      Left = 237
      Top = 89
      Width = 47
      Height = 13
      Caption = 'Telefonos'
    end
    object Label11: TLabel
      Left = 8
      Top = 92
      Width = 20
      Height = 13
      Caption = 'Pais'
    end
    object EdDireccion: TEdit
      Left = 7
      Top = 31
      Width = 458
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnKeyPress = DBtipoKeyPress
    end
    object EdBarrio: TEdit
      Left = 7
      Top = 66
      Width = 228
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      OnKeyPress = DBtipoKeyPress
    end
    object EdTelefono1: TMemo
      Left = 237
      Top = 107
      Width = 112
      Height = 21
      Alignment = taRightJustify
      TabOrder = 4
      WantReturns = False
      WordWrap = False
      OnKeyPress = DBtipoKeyPress
    end
    object EdTelefono2: TMemo
      Left = 354
      Top = 107
      Width = 112
      Height = 21
      Alignment = taRightJustify
      TabOrder = 5
      WantReturns = False
      WordWrap = False
      OnKeyPress = DBtipoKeyPress
    end
    object DbPais: TDBLookupComboBox
      Left = 8
      Top = 107
      Width = 226
      Height = 21
      KeyField = 'CODIGO'
      ListField = 'DESCRIPCION'
      ListSource = DsPais
      TabOrder = 3
      OnKeyPress = DBtipoKeyPress
    end
    object DbMunicipio: TDBLookupComboBox
      Left = 238
      Top = 66
      Width = 226
      Height = 21
      KeyField = 'COD_MUNICIPIO'
      ListField = 'NOMBRE'
      ListSource = DsMunicipio
      TabOrder = 2
      OnKeyPress = DBtipoKeyPress
    end
  end
  object IBMunicipio: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTipos
    SQL.Strings = (
      
        'select COD_MUNICIPIO, NOMBRE || '#39' '#39' || DPTO AS NOMBRE from "gen$' +
        'municipios"')
    Left = 48
    Top = 72
  end
  object IBPais: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTipos
    SQL.Strings = (
      'SELECT '
      '  GEN$PAIS.CODIGO,'
      '  GEN$PAIS.DESCRIPCION'
      'FROM'
      '  GEN$PAIS')
    Left = 48
    Top = 88
  end
  object IBtipo: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTipos
    SQL.Strings = (
      'SELECT '
      '  "gen$tiposidentificacion".ID_IDENTIFICACION,'
      '  "gen$tiposidentificacion".DESCRIPCION_IDENTIFICACION'
      'FROM'
      '  "gen$tiposidentificacion"')
    Left = 40
    Top = 56
  end
  object DsTipo: TDataSource
    DataSet = IBtipo
    Left = 16
    Top = 56
  end
  object DsMunicipio: TDataSource
    DataSet = IBMunicipio
    Left = 16
    Top = 72
  end
  object DsPais: TDataSource
    DataSet = IBPais
    Left = 16
    Top = 80
  end
  object IBTipos: TIBTransaction
    Active = True
    DefaultDatabase = dmGeneral.IBDatabase1
    Left = 24
    Top = 96
  end
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 280
    Top = 56
  end
end
