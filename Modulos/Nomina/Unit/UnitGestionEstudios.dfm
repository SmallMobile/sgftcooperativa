object FrmGestionEstudios: TFrmGestionEstudios
  Left = 333
  Top = 193
  Width = 610
  Height = 475
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'Gestion de Estudios '
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
    Left = 1
    Top = 0
    Width = 345
    Height = 41
    Caption = 'Filtro por Empleado'
    TabOrder = 0
    object DbEmpleado: TDBLookupComboBox
      Left = 4
      Top = 14
      Width = 279
      Height = 21
      KeyField = 'NIT'
      ListField = 'NOMBRE'
      ListSource = DsEmpleado
      TabOrder = 0
    end
    object chEmpleado: TCheckBox
      Left = 285
      Top = 16
      Width = 53
      Height = 17
      Caption = 'Todos'
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 40
    Width = 346
    Height = 41
    Caption = 'Filtro por estudio'
    TabOrder = 1
    object DbEstudio: TDBLookupComboBox
      Left = 4
      Top = 14
      Width = 279
      Height = 21
      KeyField = 'IDESTUDIO'
      ListField = 'DESCRIPCION'
      ListSource = DsEstudio
      TabOrder = 0
    end
    object ChEstudio: TCheckBox
      Left = 285
      Top = 16
      Width = 53
      Height = 17
      Caption = 'Todos'
      TabOrder = 1
    end
  end
  object GroupBox3: TGroupBox
    Left = 344
    Top = 0
    Width = 90
    Height = 81
    Caption = 'Agrupar por'
    TabOrder = 2
    object rEmpleado: TRadioButton
      Left = 9
      Top = 20
      Width = 70
      Height = 17
      Caption = 'Empleado'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rEstudio: TRadioButton
      Left = 10
      Top = 47
      Width = 61
      Height = 17
      Caption = 'Estudio'
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 434
    Top = 5
    Width = 167
    Height = 75
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 5
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Ejecutar'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 87
      Top = 9
      Width = 75
      Height = 25
      Caption = '&Nuevo'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 87
      Top = 40
      Width = 75
      Height = 25
      Caption = '&Cerrar'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 5
      Top = 40
      Width = 75
      Height = 25
      Caption = '&Reporte'
      Enabled = False
      TabOrder = 3
      OnClick = BitBtn4Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 1
    Top = 80
    Width = 601
    Height = 361
    DataSource = DataSource1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NOMBRE'
        Title.Caption = 'Empleado'
        Width = 186
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIPCION'
        Title.Caption = 'Estudio'
        Width = 124
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESTUDIOID'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'TITULO'
        Title.Caption = 'Titulo'
        Width = 164
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'INSTITUCION'
        Title.Caption = 'Instituci'#243'n'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DURACION'
        Title.Caption = 'Duraci'#243'n'
        Width = 86
        Visible = True
      end>
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
    Left = 224
    Top = 248
  end
  object DsEmpleado: TDataSource
    DataSet = IbEmpleado
    Left = 368
    Top = 256
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
    Left = 304
    Top = 256
  end
  object DsEstudio: TDataSource
    DataSet = IbEstudio
    Left = 336
    Top = 256
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 224
    Top = 160
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 168
    Top = 152
  end
  object DataSource1: TDataSource
    DataSet = IBQuery1
    Left = 48
    Top = 240
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 416
    Top = 256
    ReportForm = {19000000}
  end
  object frDBDataSet1: TfrDBDataSet
    Left = 136
    Top = 288
  end
end
