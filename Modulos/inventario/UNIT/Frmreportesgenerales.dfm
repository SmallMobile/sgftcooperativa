object reportes: Treportes
  Left = 145
  Top = 142
  Width = 511
  Height = 374
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
    Left = 256
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object Button2: TButton
    Left = 256
    Top = 143
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 240
    Top = 232
    Width = 233
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object frReport1: TfrReport
    Dataset = frDBDataSet1
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit, pbPageSetup]
    RebuildPrinter = False
    Left = 104
    ReportForm = {19000000}
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = stock_minimo
    Left = 136
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select  "inv$articulo"."nombre","inv$articulo"."cod_articulo",'
      '"inv$articulo"."stock","inv$articulo"."precio_unitario",'
      
        '"inv$articulo"."existencia","inv$clasificacion"."nombre","inv$ar' +
        'ticulo"."detalle"'
      'from "inv$articulo","inv$clasificacion"'
      
        'where "inv$articulo"."cod_clasificacion"="inv$clasificacion"."co' +
        'd_clasificacion"'
      'order by "inv$articulo"."nombre"')
    Left = 8
  end
  object IBTable1: TIBTable
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    FieldDefs = <
      item
        Name = 'cod_articulo'
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
      end
      item
        Name = 'precio_unitario'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end
      item
        Name = 'cod_barras'
        DataType = ftInteger
      end
      item
        Name = 'detalle'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'stock'
        DataType = ftSmallint
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
    Left = 40
    Top = 128
  end
  object frCompositeReport1: TfrCompositeReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    DoublePassReport = False
    Left = 232
    ReportForm = {19000000}
  end
  object IBdatos: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
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
    Left = 7
    Top = 32
  end
  object Empresa: TIBTable
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    FieldDefs = <
      item
        Name = 'nombre'
        DataType = ftString
        Size = 100
      end>
    StoreDefs = True
    TableName = 'inv$empresa'
    Left = 40
  end
  object proveedores: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "inv$proveedor"'
      'order by "inv$proveedor"."nombre"')
    Left = 40
    Top = 32
  end
  object cosumoseccion: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      
        'select "inv$articulo"."nombre","inv$salida"."cantidad","inv$arti' +
        'culo"."cod_articulo",'
      '"inv$dependencia"."nombre","Inv$Agencia"."descripcion",'
      '"inv$salida"."no_salida","inv$salida"."fecha_entrega"'
      
        'from "Inv$Agencia","inv$articulo","inv$dependencia","inv$emplead' +
        'o","inv$salida"'
      
        'where "inv$dependencia"."cod_dependencia"="inv$empleado"."cod_de' +
        'pendencia"and'
      '"inv$empleado"."nit"="inv$salida"."nit_empleado" and'
      '"inv$articulo"."cod_articulo"="inv$salida"."cod_articulo"and'
      '"Inv$Agencia"."cod_agencia"="inv$salida"."cod_agencia"')
    Left = 72
  end
  object valoracionseccion: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    DataSource = DataSource1
    SQL.Strings = (
      'select '
      ' "inv$articulo"."nombre",'
      '"inv$salida"."cantidad",'
      '"inv$articulo"."cod_articulo",'
      '"inv$dependencia"."nombre"  as seccion,'
      '"Inv$Agencia"."descripcion",'
      '"inv$salida"."no_salida",'
      '"inv$salida"."fecha_entrega",'
      '"inv$salida"."precio_salida"'
      
        'from "inv$salida" inner join "inv$dependencia" on ("inv$salida".' +
        '"cod_dependencia"="inv$dependencia"."cod_dependencia"), "Inv$Age' +
        'ncia","inv$articulo",'
      '"inv$empleado"'
      'where '
      '"inv$empleado"."nit"="inv$salida"."nit_empleado" and'
      '"inv$articulo"."cod_articulo"="inv$salida"."cod_articulo"and'
      '"Inv$Agencia"."cod_agencia"="inv$salida"."cod_agencia"'
      'and "inv$salida"."cod_dependencia"=:"codigo" and '
      ' "inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1"  '
      'order by "inv$salida"."no_salida"'
      ''
      ''
      '')
    Left = 72
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha1'
        ParamType = ptUnknown
      end>
  end
  object entrada: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select'
      '"inv$articulo"."nombre",'
      '"inv$entrada"."cantidad",'
      '"inv$articulo"."cod_articulo",'
      '"inv$entrada"."no_entrada",'
      '"inv$entrada"."fecha_entrada",'
      '"inv$entrada"."precio_unidad",'
      '"inv$entrada"."nit_proveedor",'
      '"inv$datos_factura"."no_factura",'
      '"inv$proveedor"."nombre" as nombrep,'
      '"inv$proveedor"."telefono",'
      '"inv$proveedor"."ciudad"'
      
        'from "inv$articulo","inv$entrada","inv$datos_factura","inv$prove' +
        'edor"'
      
        'where "inv$articulo"."cod_articulo"="inv$entrada"."cod_articulo"' +
        ' and'
      
        '"inv$entrada"."cod_factura"="inv$datos_factura"."cod_factura" an' +
        'd'
      
        '"inv$proveedor"."nit_proveedor"="inv$entrada"."nit_proveedor" an' +
        'd'
      '"inv$entrada"."no_entrada"=:"entrada"'
      ''
      '')
    Left = 8
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'entrada'
        ParamType = ptUnknown
      end>
  end
  object repseccion: TIBQuery
    Left = 40
    Top = 64
  end
  object salida: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select "Inv$Agencia"."descripcion","Inv$Agencia"."ciudad",'
      '"Inv$Agencia"."telefono","inv$salida"."no_salida",'
      '"inv$salida"."precio_salida","inv$articulo"."nombre",'
      '"inv$salida"."cantidad","inv$salida"."fecha_entrega",'
      '"inv$articulo"."cod_articulo"'
      'from "Inv$Agencia","inv$articulo","inv$salida"'
      'where "Inv$Agencia"."cod_agencia"="inv$salida"."cod_agencia" and'
      
        '"inv$articulo"."cod_articulo"="inv$salida"."cod_articulo" and "i' +
        'nv$salida"."cod_agencia"=:"codigo" and '
      ' "inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1"  '
      'order by "inv$salida"."no_salida"'
      ''
      ''
      ''
      '')
    Left = 72
    Top = 64
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha1'
        ParamType = ptUnknown
      end>
  end
  object regsalida: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select'
      ' "inv$articulo"."nombre",'
      '"inv$salida"."cantidad",'
      '"inv$articulo"."cod_articulo",'
      '"inv$dependencia"."nombre"  as seccion,'
      '"Inv$Agencia"."descripcion",'
      '"Inv$Agencia"."ciudad",'
      '"inv$salida"."no_salida",'
      '"inv$salida"."fecha_entrega",'
      '"inv$salida"."precio_salida"'
      
        'from "inv$salida" inner join "inv$dependencia" on ("inv$salida".' +
        '"cod_dependencia"="inv$dependencia"."cod_dependencia"),'
      '"Inv$Agencia","inv$articulo",'
      '"inv$empleado"'
      'where '
      '"inv$empleado"."nit"="inv$salida"."nit_empleado" and'
      '"inv$articulo"."cod_articulo"="inv$salida"."cod_articulo"and'
      
        '"Inv$Agencia"."cod_agencia"="inv$salida"."cod_agencia" and "inv$' +
        'salida"."no_salida"=:"codigo"'
      ' '
      ''
      ''
      ''
      '')
    Left = 8
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
  end
  object total: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      
        'select distinct "inv$articulo"."nombre","inv$salida"."cod_articu' +
        'lo" from "inv$articulo" inner join "inv$salida" on ( "inv$articu' +
        'lo"."cod_articulo"="inv$salida"."cod_articulo") where "inv$salid' +
        'a"."cod_dependencia"=210')
    Left = 72
    Top = 97
  end
  object total1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select sum("inv$salida"."cantidad")  as nom from "inv$salida" ')
    Left = 8
    Top = 128
    object total1NOM: TLargeintField
      FieldName = 'NOM'
    end
  end
  object referencia: TIBTable
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    FieldDefs = <
      item
        Name = 'cod_articulo'
        DataType = ftInteger
      end
      item
        Name = 'nombre'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cantidad'
        DataType = ftInteger
      end
      item
        Name = 'nombre_re'
        DataType = ftString
        Size = 100
      end>
    StoreDefs = True
    TableName = 'inv$referencia'
    Left = 40
    Top = 96
    object referenciacod_articulo: TIntegerField
      FieldName = 'cod_articulo'
    end
    object referencianombre: TIBStringField
      FieldName = 'nombre'
      Size = 100
    end
    object referenciacantidad: TIntegerField
      FieldName = 'cantidad'
    end
    object referencianombre_re: TIBStringField
      FieldName = 'nombre_re'
      Size = 100
    end
  end
  object DataSource1: TDataSource
    DataSet = referencia
    Left = 104
    Top = 96
  end
  object frReport2: TfrReport
    Dataset = frDBDataSet2
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    OnGetValue = frReport2GetValue
    Left = 104
    Top = 32
    ReportForm = {19000000}
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = referencia
    Left = 136
    Top = 32
  end
  object IBDataSet1: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      'select "inv$empleado"."nit"  from "inv$empleado"'
      
        '      where "inv$empleado"."nombre"||"inv$empleado"."apellido" =' +
        ':"nombre"')
    Left = 104
    Top = 64
  end
  object stock_minimo: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      
        'select "inv$articulo"."cod_articulo","inv$articulo"."nombre","in' +
        'v$articulo"."existencia","inv$clasificacion"."nombre","inv$artic' +
        'ulo"."stock"'
      'from "inv$articulo","inv$clasificacion"'
      ' where "inv$articulo"."existencia" <= "inv$articulo"."stock" and'
      
        '"inv$articulo"."cod_clasificacion"="inv$clasificacion"."cod_clas' +
        'ificacion"')
    Left = 72
    Top = 128
  end
  object Detalle: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select "inv$articulo"."cod_articulo",'
      '"inv$articulo"."nombre",'
      '"inv$articulo"."detalle"'
      'from "inv$articulo"'
      ' where "inv$articulo"."detalle" <> '#39#39
      'order by "inv$articulo"."nombre"')
    Left = 104
    Top = 128
  end
  object valorempleado: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select '
      ' "inv$articulo"."nombre",'
      '"inv$salida"."cantidad",'
      '"inv$articulo"."cod_articulo",'
      '"inv$salida"."no_salida",'
      '"inv$salida"."fecha_entrega",'
      '"inv$salida"."precio_salida",'
      '"inv$empleado"."nombre",'
      '"inv$empleado"."apellido"'
      'from "inv$articulo","inv$empleado","inv$salida"'
      'where '
      '"inv$empleado"."nit"="inv$salida"."nit_empleado" and'
      '"inv$articulo"."cod_articulo"="inv$salida"."cod_articulo"and'
      '"inv$salida"."definicion"='#39'E'#39' and'
      ' "inv$salida"."nit_empleado"=:"codigo" and '
      ' "inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1"  '
      'order by "inv$salida"."no_salida"'
      ''
      ''
      '')
    Left = 8
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fecha1'
        ParamType = ptUnknown
      end>
  end
  object valgeneral: TIBQuery
    Left = 40
    Top = 160
  end
  object datos: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 200
  end
  object cantidad_total: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select sum ("inv$salida"."cantidad") as cantidad from "inv$salid' +
        'a"'
      'where "inv$salida"."cod_articulo"=:"codigo" and'
      '"inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" and '
      '"inv$salida"."precio_salida"=:"precio" and'
      '"inv$salida"."nit_empleado"=:"nit" and'
      '"inv$salida"."definicion"=:"E"')
    Left = 4
    Top = 307
    object cantidad_totalCANTIDAD: TLargeintField
      FieldName = 'CANTIDAD'
    end
  end
  object cant_tot: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 89
    Top = 306
  end
  object ibbusca_codigo: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select distinct "inv$salida"."cod_articulo","inv$articulo"."nomb' +
        're" from "inv$articulo","inv$salida"'
      'where  "inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" and'
      '"inv$articulo"."cod_articulo"="inv$salida"."cod_articulo" and'
      '"inv$salida"."nit_empleado"=:"nit" and'
      '"inv$salida"."definicion"=:"E"')
    Left = 31
    Top = 307
  end
  object ibprecio_salida: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      'select distinct "inv$salida"."precio_salida" from "inv$salida"'
      'where "inv$salida"."cod_articulo"=:"codigo" and'
      '"inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" and'
      '"inv$salida"."nit_empleado"=:"nit" and'
      '"inv$salida"."definicion"=:"E"')
    Left = 60
    Top = 307
  end
  object ibbusca_general: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select distinct "inv$salida"."cod_articulo" as codigo,"inv$artic' +
        'ulo"."nombre" as nombre  from "inv$articulo","inv$salida"'
      'where  "inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" and'
      '"inv$articulo"."cod_articulo"="inv$salida"."cod_articulo" ')
    Left = 31
    Top = 307
  end
  object cantidad_general: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select sum ("inv$salida"."cantidad") as cantidad from "inv$salid' +
        'a"'
      'where "inv$salida"."cod_articulo"=:"codigo" and'
      '"inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" and '
      '"inv$salida"."precio_salida"=:"precio" '
      ''
      '')
    Left = 63
    Top = 307
    object LargeintField1: TLargeintField
      FieldName = 'CANTIDAD'
    end
  end
  object ibbusca_seccion: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select distinct "inv$salida"."cod_articulo" as codigo,"inv$artic' +
        'ulo"."nombre" as nombre  from "inv$articulo","inv$salida"'
      'where  "inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" and'
      '"inv$articulo"."cod_articulo"="inv$salida"."cod_articulo"  and'
      '"inv$salida"."cod_dependencia"=:"cod_dep"')
    Left = 63
    Top = 307
  end
  object ibprecio_salidagen: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      'select distinct "inv$salida"."precio_salida" from "inv$salida"'
      'where "inv$salida"."cod_articulo"=:"codigo" and'
      '"inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" ')
    Left = 4
    Top = 307
  end
  object ibprecio_salidasec: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      'select distinct "inv$salida"."precio_salida" from "inv$salida"'
      'where "inv$salida"."cod_articulo"=:"codigo" and'
      '"inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1"  and'
      '"inv$salida"."cod_dependencia"=:"cod_dep"')
    Left = 36
    Top = 307
  end
  object ibcantidad_seccion: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select sum ("inv$salida"."cantidad") as cantidad from "inv$salid' +
        'a"'
      'where "inv$salida"."cod_articulo"=:"codigo" and'
      '"inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" and '
      '"inv$salida"."precio_salida"=:"precio" and'
      '"inv$salida"."cod_dependencia"=:"cod_dep"'
      ''
      '')
    Left = 4
    Top = 307
  end
  object ibbusca_agencia: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select distinct "inv$salida"."cod_articulo" as codigo,"inv$artic' +
        'ulo"."nombre" as nombre  from "inv$articulo","inv$salida"'
      'where  "inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" and'
      '"inv$articulo"."cod_articulo"="inv$salida"."cod_articulo"  and'
      '"inv$salida"."cod_agencia"=:"cod_dep"')
    Left = 63
    Top = 307
  end
  object ibprecio_agencia: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      'select distinct "inv$salida"."precio_salida" from "inv$salida"'
      'where "inv$salida"."cod_articulo"=:"codigo" and'
      '"inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1"  and'
      '"inv$salida"."cod_articulo"=:"codigo" and'
      '"inv$salida"."cod_agencia"=:"cod_dep"')
    Left = 28
    Top = 307
  end
  object ibcantidad_agencia: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select sum ("inv$salida"."cantidad") as cantidad from "inv$salid' +
        'a"'
      'where "inv$salida"."cod_articulo"=:"codigo" and'
      '"inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" and '
      '"inv$salida"."precio_salida"=:"precio" and'
      '"inv$salida"."cod_agencia"=:"cod_dep"'
      ''
      '')
    Left = 4
    Top = 307
  end
  object IBQuery2: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select  "inv$articulo"."nombre","inv$articulo"."cod_articulo",'
      '"inv$articulo"."stock","inv$articulo"."precio_unitario",'
      
        '"inv$articulo"."existencia","inv$clasificacion"."nombre","inv$ar' +
        'ticulo"."detalle"'
      'from "inv$articulo","inv$clasificacion"'
      
        'where "inv$articulo"."cod_clasificacion"="inv$clasificacion"."co' +
        'd_clasificacion"'
      
        'order by "inv$articulo"."cod_clasificacion","inv$articulo"."nomb' +
        're"'
      ''
      '')
    Left = 136
    Top = 64
  end
  object secciones: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "inv$dependencia"'
      'order by "inv$dependencia"."cod_dependencia"')
    Left = 136
    Top = 96
  end
  object frOLEExcelExport1: TfrOLEExcelExport
    Default = True
    OpenExcelAfterExport = True
    Left = 192
    Top = 48
  end
  object frRtfAdvExport1: TfrRtfAdvExport
    Left = 216
    Top = 48
  end
  object frRTFExport1: TfrRTFExport
    ScaleX = 1.3
    ScaleY = 1
    Left = 240
    Top = 48
  end
  object frTextExport1: TfrTextExport
    ScaleX = 1
    ScaleY = 1
    Left = 264
    Top = 48
  end
  object valor_existencia: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select  "inv$articulo"."nombre","inv$articulo"."cod_articulo",'
      '"inv$articulo"."stock","inv$articulo"."precio_unitario",'
      
        '"inv$articulo"."existencia","inv$clasificacion"."nombre","inv$ar' +
        'ticulo"."detalle"'
      'from "inv$articulo","inv$clasificacion"'
      
        'where "inv$articulo"."cod_clasificacion"="inv$clasificacion"."co' +
        'd_clasificacion"'
      'order by "inv$articulo"."nombre"')
    Left = 136
    Top = 128
  end
  object valoracion: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select  "inv$articulo"."nombre","inv$articulo"."cod_articulo",'
      '"inv$articulo"."stock","inv$articulo"."precio_unitario",'
      
        '"inv$articulo"."existencia","inv$clasificacion"."nombre","inv$ar' +
        'ticulo"."detalle"'
      'from "inv$articulo","inv$clasificacion"'
      
        'where "inv$articulo"."cod_clasificacion"="inv$clasificacion"."co' +
        'd_clasificacion"'
      'and "inv$articulo"."cod_clasificacion"=4000'
      'order by "inv$articulo"."nombre"')
    Left = 72
    Top = 160
    object valoracionnombre: TIBStringField
      FieldName = 'nombre'
      Origin = 'inv$articulo.nombre'
      Size = 100
    end
    object valoracioncod_articulo: TIntegerField
      FieldName = 'cod_articulo'
      Origin = 'inv$articulo.cod_articulo'
      Required = True
    end
    object valoracionstock: TSmallintField
      FieldName = 'stock'
      Origin = 'inv$articulo.stock'
    end
    object valoracionprecio_unitario: TIBBCDField
      FieldName = 'precio_unitario'
      Origin = 'inv$articulo.precio_unitario'
      Precision = 18
      Size = 2
    end
    object valoracionexistencia: TIntegerField
      FieldName = 'existencia'
      Origin = 'inv$articulo.existencia'
    end
    object valoracionnombre1: TIBStringField
      FieldName = 'nombre1'
      Origin = 'inv$clasificacion.nombre'
      Size = 50
    end
    object valoraciondetalle: TIBStringField
      FieldName = 'detalle'
      Origin = 'inv$articulo.detalle'
      Size = 100
    end
  end
  object valoracion1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select  "inv$articulo"."nombre","inv$articulo"."cod_articulo",'
      '"inv$articulo"."stock","inv$articulo"."precio_unitario",'
      
        '"inv$articulo"."existencia","inv$clasificacion"."nombre","inv$ar' +
        'ticulo"."detalle"'
      'from "inv$articulo","inv$clasificacion"'
      
        'where "inv$articulo"."cod_clasificacion"="inv$clasificacion"."co' +
        'd_clasificacion"'
      'and "inv$articulo"."cod_clasificacion" = 3000'
      'order by "inv$articulo"."nombre"')
    Left = 368
    Top = 104
  end
  object e_consumo: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select sum ("inv$salida"."cantidad") as cantidad from "inv$salid' +
        'a"'
      'where "inv$salida"."cod_articulo"=:"codigo" and'
      '"inv$salida"."fecha_entrega">=:"fecha" and'
      '"inv$salida"."fecha_entrega"<=:"fecha1" '
      '')
    Left = 120
    Top = 308
  end
end
