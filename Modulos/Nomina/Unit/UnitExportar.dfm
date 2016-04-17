object FrmExportarPagos: TFrmExportarPagos
  Left = 235
  Top = 297
  Width = 378
  Height = 101
  BorderIcons = [biSystemMenu]
  Caption = 'Exportar Pagos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 148
    Height = 33
    TabOrder = 0
    object Label1: TLabel
      Left = 4
      Top = 10
      Width = 19
      Height = 13
      Caption = 'A'#241'o'
    end
    object JvAno: TJvYearEdit
      Left = 27
      Top = 7
      Width = 38
      Height = 21
      Alignment = taRightJustify
      ReadOnly = False
      TabOrder = 0
      Value = 2009
      MaxValue = 9999
      MinValue = 0
      HasMaxValue = True
      HasMinValue = True
      WindowsillYear = 71
    end
    object BitBtn1: TBitBtn
      Left = 68
      Top = 5
      Width = 76
      Height = 25
      Caption = '&Ejecutar'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 33
    Width = 148
    Height = 34
    Caption = 'Panel2'
    TabOrder = 1
    object Button1: TButton
      Left = 28
      Top = 4
      Width = 79
      Height = 25
      Caption = '&Cerrar'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT '
      
        '  "inv$empleado"."nombre" ||  '#39' '#39' || "inv$empleado"."apellido" A' +
        'S NOMBRE,'
      '  "nom$obligaciones"."nit",'
      '  "nom$tiponomina"."descripcion",'
      '  "nom$obligaciones"."sueldo",'
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
      '  "nom$obligaciones"."retefuente",'
      '  "nom$obligaciones"."g_representacion"'
      ''
      'FROM'
      '  "nom$obligaciones"'
      
        '  INNER JOIN "inv$empleado" ON ("nom$obligaciones"."nit" = "inv$' +
        'empleado"."nit")'
      
        '  INNER JOIN "nom$empleado" ON ("nom$obligaciones"."nit" = "nom$' +
        'empleado"."nitempleado")'
      
        '  INNER JOIN "nom$tiponomina" ON ("nom$empleado"."tipo_nomina" =' +
        ' "nom$tiponomina"."codigo")'
      'WHERE'
      '  "nom$obligaciones"."ano" = :ANO')
    Left = 200
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ANO'
        ParamType = ptUnknown
      end>
  end
  object Jv: TJvSaveDialog
    Filter = 'Excel 97-2003|*.xls'
    Height = 419
    Width = 563
    Left = 136
    Top = 32
  end
  object Jv1: TJvProgressDlg
    Text = 'Progress'
    Left = 168
    Top = 24
  end
end
