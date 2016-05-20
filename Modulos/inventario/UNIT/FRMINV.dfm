object inventa: Tinventa
  Left = 215
  Top = 112
  Width = 544
  Height = 375
  BorderIcons = [biSystemMenu]
  Caption = 'Inventario'
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
  object Label1: TLabel
    Left = 162
    Top = 21
    Width = 159
    Height = 13
    Caption = 'INVENTARIOS ARTICULOS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 15
    Top = 32
    Width = 17
    Height = 16
    Caption = 'A'
    TabOrder = 0
  end
  object Button2: TButton
    Left = 56
    Top = 112
    Width = 41
    Height = 16
    Caption = 'B'
    TabOrder = 1
    OnClick = Button2Click
  end
  object nombre: TEdit
    Left = 160
    Top = 168
    Width = 49
    Height = 21
    TabOrder = 2
  end
  object Button3: TButton
    Left = 24
    Top = 144
    Width = 113
    Height = 25
    Caption = 'Button3'
    TabOrder = 3
    OnClick = Button3Click
  end
  object frReport1: TfrReport
    Dataset = frDBDataSet1
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 464
    Top = 16
    ReportForm = {19000000}
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = IBQuery1
    Left = 504
    Top = 16
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select  "inv$articulo"."nombre","inv$articulo"."cod_articulo",'
      '"inv$articulo"."existencia","inv$clasificacion"."nombre"'
      'from "inv$articulo","inv$clasificacion"'
      
        'where "inv$articulo"."cod_clasificacion"="inv$clasificacion"."co' +
        'd_clasificacion"'
      'order by "inv$articulo"."nombre"')
    Left = 56
    Top = 8
  end
  object IBTable1: TIBTable
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'cod_articulo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'cod_barras'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'nombre'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cod_clasificacion'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'existencia'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'RDB$PRIMARY35'
        Fields = 'cod_articulo'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'RDB$FOREIGN55'
        Fields = 'cod_clasificacion'
      end>
    StoreDefs = True
    TableName = 'inv$articulo'
    Left = 344
    Top = 40
  end
  object frCompositeReport1: TfrCompositeReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    DoublePassReport = False
    Left = 376
    Top = 8
    ReportForm = {19000000}
  end
  object IBdatos: TIBQuery
    BufferChunks = 1000
    CachedUpdates = True
    SQL.Strings = (
      
        'select distinct "inv$articulo"."nombre","inv$empleado"."nit","in' +
        'v$empleado"."nombre",'
      '"inv$salida"."fecha_entrega","inv$salida"."no_salida",'
      '"inv$dependencia"."nombre",'
      '"inv$salida"."cantidad","inv$articulo"."cod_articulo"'
      ' from'
      '"inv$articulo","inv$salida","inv$empleado","inv$dependencia"'
      
        'where "inv$dependencia"."cod_dependencia"="inv$empleado"."cod_de' +
        'pendencia" and'
      '"inv$empleado"."nit"="inv$salida"."nit_empleado" and'
      '"inv$salida"."cod_articulo"="inv$articulo"."cod_articulo" '
      'order by "inv$salida"."no_salida"')
    Left = 87
    Top = 8
  end
end
