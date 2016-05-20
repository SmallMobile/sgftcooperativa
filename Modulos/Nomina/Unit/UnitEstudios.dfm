object FrmEstudios: TFrmEstudios
  Left = 232
  Top = 356
  Width = 369
  Height = 278
  AutoSize = True
  Caption = 'Registrar Estudio Empleados'
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 361
    Height = 208
    Caption = 'Rgistrar Estudio'
    TabOrder = 0
    object Label1: TLabel
      Left = 3
      Top = 15
      Width = 47
      Height = 13
      Caption = 'Empleado'
    end
    object Label2: TLabel
      Left = 3
      Top = 52
      Width = 74
      Height = 13
      Caption = 'Tipo de Estudio'
    end
    object Label3: TLabel
      Left = 3
      Top = 89
      Width = 72
      Height = 13
      Caption = 'Titulo Obtenido'
    end
    object Label4: TLabel
      Left = 3
      Top = 130
      Width = 30
      Height = 13
      Caption = 'Fecha'
    end
    object Label5: TLabel
      Left = 179
      Top = 130
      Width = 43
      Height = 13
      Caption = 'Duraci'#243'n'
    end
    object Label6: TLabel
      Left = 3
      Top = 168
      Width = 48
      Height = 13
      Caption = 'Instituci'#243'n'
    end
    object DbEmpleado: TDBLookupComboBox
      Left = 3
      Top = 29
      Width = 352
      Height = 21
      KeyField = 'NIT'
      ListField = 'NOMBRE'
      ListSource = DsEmpleado
      TabOrder = 0
      OnEnter = DbEmpleadoEnter
      OnKeyPress = DbEmpleadoKeyPress
    end
    object DbEstudio: TDBLookupComboBox
      Left = 3
      Top = 66
      Width = 352
      Height = 21
      KeyField = 'IDESTUDIO'
      ListField = 'DESCRIPCION'
      ListSource = DsEstudio
      TabOrder = 1
      OnEnter = DbEstudioEnter
      OnKeyPress = DbEmpleadoKeyPress
    end
    object EdTitulo: TEdit
      Left = 3
      Top = 104
      Width = 352
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
      OnKeyPress = DbEmpleadoKeyPress
    end
    object DtFecha: TDateTimePicker
      Left = 3
      Top = 144
      Width = 171
      Height = 21
      CalAlignment = dtaLeft
      Date = 40436.4115372801
      Time = 40436.4115372801
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 3
      OnKeyPress = DbEmpleadoKeyPress
    end
    object EdDuracion: TEdit
      Left = 179
      Top = 144
      Width = 177
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
      OnKeyPress = DbEmpleadoKeyPress
    end
    object EdInstitucion: TEdit
      Left = 3
      Top = 183
      Width = 352
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 5
      OnKeyPress = DbEmpleadoKeyPress
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 208
    Width = 361
    Height = 36
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 24
      Top = 5
      Width = 75
      Height = 25
      Caption = '&Registrar'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn3: TBitBtn
      Left = 142
      Top = 5
      Width = 75
      Height = 25
      Caption = 'C&ancelar'
      TabOrder = 1
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 252
      Top = 5
      Width = 75
      Height = 25
      Caption = 'C&errar'
      TabOrder = 2
      OnClick = BitBtn4Click
    end
  end
  object IbEmpleado: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT'
      
        '  "inv$empleado"."nombre" || '#39' '#39' ||   "inv$empleado"."apellido" ' +
        'as NOMBRE,'
      '  "inv$empleado"."nit" AS NIT'
      'FROM'
      '  "inv$empleado"'
      'order by NOMBRE')
    Left = 240
    Top = 80
  end
  object IbEstudio: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  TIPOESTUDIO.IDESTUDIO,'
      '  TIPOESTUDIO.DESCRIPCION'
      'FROM'
      '  TIPOESTUDIO'
      'ORDER BY DESCRIPCION')
    Left = 232
    Top = 112
  end
  object DsEmpleado: TDataSource
    DataSet = IbEmpleado
    Left = 248
    Top = 152
  end
  object DsEstudio: TDataSource
    DataSet = IbEstudio
    Left = 304
    Top = 152
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 304
    Top = 88
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 192
    Top = 72
  end
end
