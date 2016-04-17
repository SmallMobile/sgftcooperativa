object Form1: TForm1
  Left = 216
  Top = 114
  Width = 475
  Height = 360
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 40
    Width = 13
    Height = 13
    Caption = 'Nit'
  end
  object nit: TEdit
    Left = 121
    Top = 37
    Width = 145
    Height = 21
    TabOrder = 0
  end
  object eje: TBitBtn
    Left = 136
    Top = 72
    Width = 105
    Height = 17
    Caption = '&Ejecutar'
    TabOrder = 1
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 168
    Width = 433
    Height = 49
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'nit_empleado'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cod_articulo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'no_salida'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'fecha_entrega'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cantidad'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cod_agencia'
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = IBDataSet1
    Left = 320
    Top = 40
  end
  object IBDataSet1: TIBDataSet
    Database = IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select * from "inv$salida"'
      'where "inv$salida"."nit_empleado"=:"codigo"')
    Left = 328
    Top = 80
    object IBDataSet1nit_empleado: TIntegerField
      FieldName = 'nit_empleado'
      Origin = 'inv$salida.nit_empleado'
    end
    object IBDataSet1cod_articulo: TIntegerField
      FieldName = 'cod_articulo'
      Origin = 'inv$salida.cod_articulo'
      Required = True
    end
    object IBDataSet1no_salida: TIntegerField
      FieldName = 'no_salida'
      Origin = 'inv$salida.no_salida'
      Required = True
    end
    object IBDataSet1fecha_entrega: TDateField
      FieldName = 'fecha_entrega'
      Origin = 'inv$salida.fecha_entrega'
    end
    object IBDataSet1cantidad: TSmallintField
      FieldName = 'cantidad'
      Origin = 'inv$salida.cantidad'
    end
    object IBDataSet1cod_agencia: TSmallintField
      FieldName = 'cod_agencia'
      Origin = 'inv$salida.cod_agencia'
      Required = True
    end
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = '192.168.1.8:/home/inventario.gdb'
    Params.Strings = (
      'user_name=wuribe'
      'password=wuribe'
      'lc_ctype=ISO8859_1')
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 56
    Top = 80
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    AutoStopAction = saNone
    Left = 72
    Top = 88
  end
end
