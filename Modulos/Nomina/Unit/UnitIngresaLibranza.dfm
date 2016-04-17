object FrmIngresaLibranza: TFrmIngresaLibranza
  Left = 437
  Top = 305
  Width = 540
  Height = 242
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'Ingresar Libranza'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 444
    Height = 105
    Caption = 'Informaci'#243'n del Empelado'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 47
      Height = 13
      Caption = 'Empleado'
    end
    object Label2: TLabel
      Left = 306
      Top = 17
      Width = 69
      Height = 13
      Caption = 'Nomina Actual'
    end
    object Label3: TLabel
      Left = 7
      Top = 57
      Width = 53
      Height = 13
      Caption = 'Colocaci'#243'n'
    end
    object Label4: TLabel
      Left = 92
      Top = 57
      Width = 55
      Height = 13
      Caption = 'Valor Cuota'
    end
    object Label5: TLabel
      Left = 200
      Top = 57
      Width = 91
      Height = 13
      Caption = 'Fecha Vencimiento'
    end
    object Label6: TLabel
      Left = 305
      Top = 57
      Width = 72
      Height = 13
      Caption = 'Oficina Destino'
    end
    object DbEmpleado: TDBLookupComboBox
      Left = 6
      Top = 32
      Width = 298
      Height = 21
      KeyField = 'NIT'
      ListField = 'NOMBRE'
      ListSource = DsEmpleado
      TabOrder = 0
      OnExit = DbEmpleadoExit
      OnKeyPress = DbEmpleadoKeyPress
    end
    object EdNomina: TEdit
      Left = 306
      Top = 32
      Width = 132
      Height = 21
      Color = clMenuBar
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object EdColocacion: TEdit
      Left = 8
      Top = 72
      Width = 80
      Height = 21
      TabOrder = 2
      OnKeyPress = DbEmpleadoKeyPress
    end
    object jvValor: TJvCurrencyEdit
      Left = 92
      Top = 72
      Width = 106
      Height = 21
      Alignment = taRightJustify
      ReadOnly = False
      TabOrder = 3
      OnKeyPress = DbEmpleadoKeyPress
      HasMaxValue = False
      HasMinValue = False
    end
    object dtFecha: TDateTimePicker
      Left = 200
      Top = 72
      Width = 103
      Height = 21
      CalAlignment = dtaLeft
      Date = 40724.5878347106
      Time = 40724.5878347106
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 4
      OnKeyPress = DbEmpleadoKeyPress
    end
    object dbNomina: TDBLookupComboBox
      Left = 304
      Top = 72
      Width = 135
      Height = 21
      KeyField = 'COD'
      ListField = 'DES'
      ListSource = DsNomina
      TabOrder = 5
      OnKeyPress = DbEmpleadoKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 102
    Width = 532
    Height = 106
    Caption = 'Libranzas Asignadas'
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 7
      Top = 15
      Width = 518
      Height = 83
      DataSource = dsLibranza
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'descripcion'
          Title.Caption = 'Oficina'
          Width = 126
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COLOCACION'
          Title.Caption = 'Colocaci'#243'n'
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VCUOTA'
          Title.Caption = 'V. Cuota'
          Width = 123
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FECHAV'
          Title.Caption = 'F. Vencimiento'
          Width = 100
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    Left = 443
    Top = 1
    Width = 88
    Height = 107
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 5
      Top = 19
      Width = 75
      Height = 25
      Caption = '&Agregar'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 5
      Top = 55
      Width = 75
      Height = 25
      Caption = '&Cerrar'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object DsEmpleado: TDataSource
    DataSet = IbEmpleado
    Left = 680
    Top = 24
  end
  object IbEmpleado: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      
        '  "inv$empleado"."nombre" || '#39' '#39' || "inv$empleado"."apellido" AS' +
        ' NOMBRE,'
      '  "inv$empleado"."nit" AS NIT,'
      '  "nom$empleado"."tipo_nomina",'
      '  "nom$tiponomina"."descripcion"'
      'FROM'
      '  "inv$empleado"'
      
        '  INNER JOIN "nom$empleado" ON ("inv$empleado"."nit" = "nom$empl' +
        'eado"."nitempleado")'
      
        '  INNER JOIN "nom$tiponomina" ON ("nom$empleado"."tipo_nomina" =' +
        ' "nom$tiponomina"."codigo")'
      'WHERE'
      '  "nom$empleado"."numero_cuenta" = 0'
      'ORDER BY'
      '  NOMBRE')
    Left = 640
    Top = 24
  end
  object DsNomina: TDataSource
    DataSet = IbNomina
    Left = 712
    Top = 32
  end
  object IbNomina: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "Inv$Agencia"."cod_agencia" as COD,'
      '  "Inv$Agencia"."descripcion" as DES'
      'FROM'
      '  "Inv$Agencia"')
    Left = 600
    Top = 24
  end
  object PopupMenu1: TPopupMenu
    Left = 632
    Top = 152
    object Eliminar1: TMenuItem
      Caption = 'Eliminar'
      OnClick = Eliminar1Click
    end
  end
  object IbLibranza: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      '  "Inv$Agencia"."descripcion",'
      '  "nom$libranza".COLOCACION,'
      '  "nom$libranza".VCUOTA,'
      '  "nom$libranza".FECHAV'
      'FROM'
      '  "nom$libranza"'
      
        '  INNER JOIN "Inv$Agencia" ON ("nom$libranza".IDAGENCIA = "Inv$A' +
        'gencia"."cod_agencia")'
      'WHERE'
      '  "nom$libranza".NIT = :NIT'
      '')
    Left = 784
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NIT'
        ParamType = ptUnknown
      end>
    object IbLibranzadescripcion: TIBStringField
      FieldName = 'descripcion'
      Origin = '"Inv$Agencia"."descripcion"'
      Size = 50
    end
    object IbLibranzaCOLOCACION: TIBStringField
      FieldName = 'COLOCACION'
      Origin = '"nom$libranza"."COLOCACION"'
      Size = 12
    end
    object IbLibranzaVCUOTA: TIBBCDField
      FieldName = 'VCUOTA'
      Origin = '"nom$libranza"."VCUOTA"'
      DisplayFormat = '#.#'
      Precision = 18
      Size = 2
    end
    object IbLibranzaFECHAV: TDateField
      FieldName = 'FECHAV'
      Origin = '"nom$libranza"."FECHAV"'
    end
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 376
    Top = 288
  end
  object dsLibranza: TDataSource
    DataSet = IbLibranza
    Left = 520
    Top = 280
  end
end
