object dataentrada: Tdataentrada
  OldCreateOrder = False
  Left = 65532
  Top = 65532
  Height = 578
  Width = 808
  object ibagencia: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select * from  "Inv$Agencia"')
    Left = 96
    Top = 72
  end
  object DataSource1: TDataSource
    DataSet = IBsalida
    Left = 120
    Top = 16
  end
  object IBsalida: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    ForcedRefresh = True
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from "inv$salida"'
      'where'
      '  "inv$salida"."cod_articulo" = :"OLD_cod_articulo" and'
      '  "inv$salida"."nit_empleado" = :"OLD_nit_empleado" and'
      '  "inv$salida"."no_salida" = :"OLD_no_salida" and'
      '  "inv$salida"."fecha_entrega" = :"OLD_fecha_entrega" and'
      '  "inv$salida"."cantidad" = :"OLD_cantidad" and'
      '  "inv$salida"."cod_agencia" = :"OLD_cod_agencia" and'
      '   "inv$salida"."definicion" = :"OLD_definicion" and'
      '   "inv$salida"."definicion" = :"OLD_definicion" and'
      
        '    "inv$salida"."cantidad_articulo" = :"OLD_cantidad_articulo" ' +
        'and'
      '    "inv$salida"."precio_salida" = :"OLD_precio_salida" and'
      '     "inv$salida"."cod_dependencia" =:"OLD_cod_dependencia"')
    InsertSQL.Strings = (
      'insert into "inv$salida"'
      
        '  ("inv$salida"."cod_articulo", "inv$salida"."nit_empleado", "in' +
        'v$salida"."no_salida", '
      
        '   "inv$salida"."fecha_entrega", "inv$salida"."cantidad", "inv$s' +
        'alida"."cod_agencia",'
      
        ' "inv$salida"."definicion",  "inv$salida"."cantidad_articulo","p' +
        'recio_salida", '
      '"inv$salida"."cod_dependencia")'
      'values'
      
        '  (:"cod_articulo", :"nit_empleado", :"no_salida", :"fecha_entre' +
        'ga", :"cantidad", '
      
        ':"cod_agencia",:"definicion",:"cantidad_articulo",:"precio_salid' +
        'a",'
      ':"cod_dependencia")'
      '')
    SelectSQL.Strings = (
      'select "inv$salida"."cantidad","inv$salida"."cod_agencia",'
      '"inv$salida"."cod_articulo","inv$salida"."fecha_entrega",'
      '"inv$salida"."nit_empleado","inv$salida"."no_salida",'
      '"inv$articulo"."cod_barras","inv$articulo"."nombre",'
      '"inv$salida"."definicion","inv$salida"."cantidad_articulo",'
      '"inv$salida"."precio_salida","inv$salida"."cod_dependencia"'
      'from "inv$salida","inv$articulo"'
      
        'where "inv$articulo"."cod_articulo"="inv$salida"."cod_articulo" ' +
        'and'
      '"inv$salida"."cod_articulo"=:"articulo"')
    ModifySQL.Strings = (
      'update "inv$salida"'
      'set'
      '  "inv$salida"."cantidad" = :"cantidad",'
      '  "inv$salida"."cod_agencia" = :"cod_agencia",'
      '  "inv$salida"."cod_articulo" = :"cod_articulo",'
      '  "inv$salida"."fecha_entrega" = :"fecha_entrega",'
      '  "inv$salida"."nit_empleado" = :"nit_empleado",'
      '  "inv$salida"."no_salida" = :"no_salida",'
      '  "inv$salida"."definicion" = :"definicion",'
      '  "inv$salida"."cantidad_articulo" = :"cantidad_articulo",'
      '  "inv$salida"."precio_salida" = :"precio_salida",'
      '  "inv$salida"."cod_dependencia"=:"cod_dependencia"'
      'where'
      '  "inv$salida"."cantidad" = :"OLD_cantidad" and'
      '  "inv$salida"."cod_agencia" = :"OLD_cod_agencia" and'
      '  "inv$salida"."cod_articulo" = :"OLD_cod_articulo" and'
      '  "inv$salida"."fecha_entrega" = :"OLD_fecha_entrega" and'
      '  "inv$salida"."nit_empleado" = :"OLD_nit_empleado" and'
      '  "inv$salida"."no_salida" = :"OLD_no_salida" and '
      '  "inv$salida"."definicion" = :"OLD_definicion" and'
      
        '  "inv$salida"."cantidad_articulo" = :"OLD_cantidad_articulo" an' +
        'd'
      '  "inv$salida"."precio_salida" = :"OLD_precio_salida" and'
      '   "inv$salida"."cod_dependencia" = :"OLD_cod_dependencia"'
      '')
    Filtered = True
    Left = 16
    Top = 80
    object IBsalidacod_articulo: TIntegerField
      FieldName = 'cod_articulo'
      Origin = 'inv$salida.cod_articulo'
      Required = True
      OnValidate = IBsalidacod_articuloValidate
    end
    object IBsalidanit_empleado: TIntegerField
      FieldName = 'nit_empleado'
      Origin = 'inv$salida.nit_empleado'
    end
    object IBsalidano_salida: TIntegerField
      FieldName = 'no_salida'
      Origin = 'inv$salida.no_salida'
      Required = True
    end
    object IBsalidafecha_entrega: TDateField
      FieldName = 'fecha_entrega'
      Origin = 'inv$salida.fecha_entrega'
    end
    object IBsalidacod_barras: TIntegerField
      FieldName = 'cod_barras'
      Origin = 'inv$articulo.cod_barras'
      Required = True
    end
    object IBsalidanombre: TIBStringField
      DisplayWidth = 20
      FieldName = 'nombre'
      Origin = 'inv$articulo.nombre'
      ReadOnly = True
    end
    object IBsalidacantidad: TSmallintField
      FieldName = 'cantidad'
      Origin = 'inv$salida.cantidad'
    end
    object IBsalidacod_agencia: TSmallintField
      FieldName = 'cod_agencia'
      Origin = 'inv$salida.cod_agencia'
      Required = True
    end
    object IBsalidadefinicion: TIBStringField
      FieldName = 'definicion'
      Origin = 'inv$salida.definicion'
      FixedChar = True
      Size = 1
    end
    object IBsalidacantidad_articulo: TSmallintField
      FieldName = 'cantidad_articulo'
      Origin = 'inv$salida.cantidad_articulo'
    end
    object IBsalidaprecio_salida: TIBBCDField
      FieldName = 'precio_salida'
      Origin = 'inv$salida.precio_salida'
      Precision = 18
      Size = 2
    end
    object IBsalidacod_dependencia: TIntegerField
      FieldName = 'cod_dependencia'
      Origin = 'inv$salida.cod_dependencia'
    end
  end
  object IBDataSet1: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select "inv$empleado"."nit"  from "inv$empleado"'
      
        '      where "inv$empleado"."nombre"||"inv$empleado"."apellido" =' +
        ':"nombre"')
    Left = 72
    Top = 16
  end
  object dataagen: TDataSource
    DataSet = ibagencia
    Left = 16
    Top = 16
  end
  object IBDataSet3: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select * from "inv$articulo"')
    Top = 176
    object IBDataSet3cod_articulo: TIntegerField
      FieldName = 'cod_articulo'
      Origin = 'inv$articulo.cod_articulo'
      Required = True
    end
    object IBDataSet3cod_barras: TIntegerField
      FieldName = 'cod_barras'
      Origin = 'inv$articulo.cod_barras'
      Required = True
    end
    object IBDataSet3nombre: TIBStringField
      FieldName = 'nombre'
      Origin = 'inv$articulo.nombre'
      Size = 100
    end
    object IBDataSet3existencia: TFloatField
      FieldName = 'existencia'
      Origin = 'inv$articulo.existencia'
    end
    object IBDataSet3cod_clasificacion: TIntegerField
      FieldName = 'cod_clasificacion'
      Origin = 'inv$articulo.cod_clasificacion'
      Required = True
    end
  end
  object IBentrada: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      'delete from "inv$entrada"'
      'where'
      '  "inv$entrada"."cod_articulo" = :"OLD_cod_articulo" and'
      '  "inv$entrada"."no_entrada" = :"OLD_no_entrada"')
    InsertSQL.Strings = (
      'insert into "inv$entrada"'
      '  ("inv$entrada"."cantidad", "inv$entrada"."cod_articulo", '
      '"inv$entrada"."cod_factura", '
      
        '   "inv$entrada"."fecha_entrada", "inv$entrada"."nit_proveedor",' +
        ' '
      '"inv$entrada"."no_entrada", '
      
        '   "inv$entrada"."precio_unidad","inv$entrada"."cantidad_articul' +
        'o" )'
      'values'
      
        '  (:"cantidad", :"cod_articulo", :"cod_factura", :"fecha_entrada' +
        '", :"nit_proveedor", '
      '   :"no_entrada", :"precio_unidad",:"cantidad_articulo")')
    SelectSQL.Strings = (
      
        'select  "inv$entrada"."cantidad", "inv$entrada"."cod_articulo", ' +
        '"inv$entrada"."cod_factura", "inv$entrada"."fecha_entrada", "inv' +
        '$entrada"."nit_proveedor","inv$entrada"."no_entrada",'
      '"inv$entrada". "precio_unidad","inv$articulo"."cod_barras",'
      '"inv$articulo"."nombre","inv$entrada"."cantidad_articulo",'
      '"inv$articulo"."precio_unitario"'
      'from "inv$entrada","inv$articulo"'
      'where'
      ' "inv$entrada"."cod_articulo"="inv$articulo"."cod_articulo" and'
      ' "inv$entrada"."cod_articulo"=:"cod_articulo"'
      ''
      ''
      '')
    ModifySQL.Strings = (
      'update "inv$entrada"'
      'set'
      '  "inv$entrada"."cantidad" = :"cantidad",'
      '  "inv$entrada"."cod_articulo" = :"cod_articulo",'
      '  "inv$entrada"."cod_factura" = :"cod_factura",'
      '  "inv$entrada"."fecha_entrada" = :"fecha_entrada",'
      '  "inv$entrada"."nit_proveedor" = :"nit_proveedor",'
      '  "inv$entrada"."no_entrada" = :"no_entrada",'
      '  "inv$entrada"."precio_unidad" = :"precio_unidad",'
      '  "inv$entrada"."cantidad_articulo" = :"cantidad_articulo"'
      'where'
      '  "inv$entrada"."cantidad" = :"OLD_cantidad" and'
      '  "inv$entrada"."cod_articulo" = :"OLD_cod_articulo" and'
      '  "inv$entrada"."cod_factura" = :"OLD_cod_factura" and'
      '  "inv$entrada"."fecha_entrada" = :"OLD_fecha_entrada" and'
      '  "inv$entrada"."nit_proveedor" = :"OLD_nit_proveedor" and'
      '  "inv$entrada"."no_entrada" = :"OLD_no_entrada" and'
      '  "inv$entrada"."precio_unidad" = :"OLD_precio_unidad" and'
      '  "inv$entrada"."cantidad_articulo" = :"OLD_cantidad_articulo"')
    Filtered = True
    GeneratorField.Field = 'cantidad'
    GeneratorField.ApplyEvent = gamOnPost
    Left = 80
    Top = 192
    object IBentradacantidad: TSmallintField
      FieldName = 'cantidad'
      Origin = 'inv$entrada.cantidad'
    end
    object IBentradacod_articulo: TIntegerField
      FieldName = 'cod_articulo'
      Origin = 'inv$entrada.cod_articulo'
      Required = True
    end
    object IBentradacod_factura: TIntegerField
      FieldName = 'cod_factura'
      Origin = 'inv$entrada.cod_factura'
      Required = True
    end
    object IBentradafecha_entrada: TDateField
      FieldName = 'fecha_entrada'
      Origin = 'inv$entrada.fecha_entrada'
    end
    object IBentradano_entrada: TIntegerField
      FieldName = 'no_entrada'
      Origin = 'inv$entrada.no_entrada'
      Required = True
    end
    object IBentradaprecio_unidad: TIBBCDField
      FieldName = 'precio_unidad'
      Origin = 'inv$entrada.precio_unidad'
      Required = True
      currency = True
      Precision = 18
      Size = 2
    end
    object IBentradacod_barras: TIntegerField
      FieldName = 'cod_barras'
      Origin = 'inv$articulo.cod_barras'
      Required = True
    end
    object IBentradanombre: TIBStringField
      DisplayWidth = 25
      FieldName = 'nombre'
      Origin = 'inv$articulo.nombre'
      Size = 100
    end
    object IBentradacantidad_articulo: TSmallintField
      FieldName = 'cantidad_articulo'
      Origin = 'inv$entrada.cantidad_articulo'
    end
    object IBentradaprecio_unitario: TIBBCDField
      FieldName = 'precio_unitario'
      Origin = 'inv$articulo.precio_unitario'
      currency = True
      Precision = 18
      Size = 2
    end
    object IBentradanit_proveedor: TIBBCDField
      FieldName = 'nit_proveedor'
      Origin = 'inv$entrada.nit_proveedor'
      Precision = 18
      Size = 1
    end
  end
  object DataSource2: TDataSource
    DataSet = IBentrada
    Left = 64
    Top = 144
  end
end
