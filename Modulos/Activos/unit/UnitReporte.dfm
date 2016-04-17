object FrmReporte: TFrmReporte
  OldCreateOrder = False
  Left = 267
  Top = 168
  Height = 207
  Width = 128
  object Activosporseccion: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    AutoCalcFields = False
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select "act$activo"."placa","act$activo"."fechacompra",'
      '"act$activo"."descripcion","act$traslado"."cod_oficina",'
      '"Inv$Agencia"."descripcion","act$traslado"."cod_seccion",'
      '"inv$dependencia"."nombre","act$activo"."placa","preciocompra"'
      'from "act$traslado" inner join "inv$dependencia" on'
      
        '("act$traslado"."cod_seccion"="inv$dependencia"."cod_dependencia' +
        '"),'
      '"act$activo","Inv$Agencia"'
      'where "act$activo"."cod_activo"="act$traslado"."cod_activo" and'
      '"Inv$Agencia"."cod_agencia"="act$traslado"."cod_oficina" and'
      '"act$activo"."esactivo" = 1 and "act$traslado"."lugar" ='#39'A'#39' and'
      '"act$activo"."estado"='#39'A'#39
      'order by "Inv$Agencia"."descripcion"')
    Left = 44
    Top = 46
  end
  object empresa: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select *  from "inv$empresa"')
    Left = 11
    Top = 65534
  end
  object Elementos: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select "act$activo"."placa","act$activo"."fechacompra",'
      '"act$activo"."descripcion","act$traslado"."cod_oficina",'
      '"Inv$Agencia"."descripcion","act$traslado"."cod_seccion",'
      '"inv$dependencia"."nombre","act$activo"."placa","preciocompra"'
      'from "act$traslado" inner join "inv$dependencia" on'
      
        '("act$traslado"."cod_seccion"="inv$dependencia"."cod_dependencia' +
        '"),'
      '"act$activo","Inv$Agencia"'
      'where "act$activo"."cod_activo"="act$traslado"."cod_activo" and'
      '"Inv$Agencia"."cod_agencia"="act$traslado"."cod_oficina" and'
      '"act$activo"."esactivo" = 0 and "act$traslado"."lugar" ='#39'A'#39' and'
      '"act$activo"."estado"='#39'A'#39
      'order by "Inv$Agencia"."descripcion"')
    Left = 54
  end
  object polizas: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "Inv$Agencia"."descripcion",'
      '  "act$activo"."placa",'
      '  "act$activo"."descripcion" AS "descripcion1",'
      '  "act$poliza"."fecha_inicio",'
      '  "act$poliza"."fecha_vencimiento",'
      '  "act$poliza"."valor_asegurado",'
      '  "act$tipo_poliza"."descripcion" AS "descripcion2",'
      '  "inv$dependencia"."nombre"'
      'FROM'
      '  "Inv$Agencia",'
      '  "act$activo",'
      '  "act$poliza",'
      '  "act$tipo_poliza",'
      '  "act$traslado"'
      
        '  INNER JOIN "inv$dependencia" ON ("act$traslado"."cod_seccion" ' +
        '= "inv$dependencia"."cod_dependencia")'
      'WHERE'
      '  ("act$activo"."cod_activo" = "act$poliza"."cod_activo") AND '
      
        '  ("act$traslado"."cod_oficina" = "Inv$Agencia"."cod_agencia") A' +
        'ND '
      '  ("act$activo"."cod_activo" = "act$traslado"."cod_activo") AND '
      
        '  ("act$tipo_poliza"."cod_tipopoliza" = "act$poliza"."tipo_poliz' +
        'a") AND '
      '  ("act$poliza"."vencido" = 0) AND'
      ' ("act$traslado"."lugar"='#39'A'#39') AND'
      '  ("act$activo"."estado"='#39'A'#39') AND'
      '  ("act$poliza"."tipo_poliza" = :"cod_poliza")'
      'order by   "Inv$Agencia"."descripcion",'
      '"act$activo"."descripcion"')
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cod_poliza'
        ParamType = ptUnknown
      end>
  end
  object IBactivodepreciado: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "act$activo"."placa",'
      '  "act$activo"."descripcion",'
      '  "act$activo"."fechacompra",'
      '  "act$activo"."preciocompra",'
      '  "Inv$Agencia"."descripcion" AS "descripcion1"'
      'FROM'
      '  "act$traslado"'
      
        '  INNER JOIN "act$activo" ON ("act$traslado"."cod_activo" = "act' +
        '$activo"."cod_activo")'
      
        '  INNER JOIN "Inv$Agencia" ON ("act$traslado"."cod_oficina" = "I' +
        'nv$Agencia"."cod_agencia")'
      'WHERE'
      '  ("act$activo"."estado" = '#39'A'#39')')
    Left = 64
    Top = 104
  end
end
