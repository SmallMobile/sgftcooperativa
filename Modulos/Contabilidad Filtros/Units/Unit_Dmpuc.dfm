object Dmpuc: TDmpuc
  OldCreateOrder = False
  Left = 384
  Top = 183
  Height = 278
  Width = 223
  object DataSourcesaldos: TDataSource
    DataSet = IBDataSetSaldos
    Left = 31
    Top = 6
  end
  object DataSource1: TDataSource
    DataSet = IBDataSet1
    Left = 22
    Top = 62
  end
  object IBDataSet1: TIBDataSet
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    DeleteSQL.Strings = (
      'delete from "con$puc"'
      'where'
      '  "con$puc"."CODIGO" = :"OLD_CODIGO" and'
      '  "con$puc"."ID_AGENCIA" = :"OLD_ID_AGENCIA"')
    InsertSQL.Strings = (
      'insert into "con$puc"'
      
        '  ("con$puc"."CODIGO", "con$puc"."ID_AGENCIA", "con$puc"."CLAVE"' +
        ', '
      '"con$puc"."NOMBRE", '
      
        '   "con$puc"."TIPO", "con$puc"."CODIGOMAYOR", "con$puc"."MOVIMIE' +
        'NTO", '
      '"con$puc"."ESBANCO", '
      
        '   "con$puc"."INFORME", "con$puc"."NIVEL", "con$puc"."NATURALEZA' +
        '", '
      '"con$puc"."CENTROCOSTO", '
      '   "con$puc"."SALDOINICIAL")'
      'values'
      '  (:"CODIGO", :"ID_AGENCIA", :"CLAVE", :"NOMBRE", :"TIPO", '
      ':"CODIGOMAYOR", '
      
        '   :"MOVIMIENTO", :"ESBANCO", :"INFORME", :"NIVEL", :"NATURALEZA' +
        '", '
      ':"CENTROCOSTO", '
      '   :"SALDOINICIAL")')
    RefreshSQL.Strings = (
      'Select '
      '  "con$puc"."CODIGO",'
      '  "con$puc"."ID_AGENCIA",'
      '  "con$puc"."CLAVE",'
      '  "con$puc"."NOMBRE",'
      '  "con$puc"."TIPO",'
      '  "con$puc"."CODIGOMAYOR",'
      '  "con$puc"."MOVIMIENTO",'
      '  "con$puc"."ESBANCO",'
      '  "con$puc"."INFORME",'
      '  "con$puc"."NIVEL",'
      '  "con$puc"."NATURALEZA",'
      '  "con$puc"."CENTROCOSTO",'
      '  "con$puc"."SALDOINICIAL"'
      'from "con$puc" '
      'where'
      '  "con$puc"."CODIGO" = :"CODIGO" and'
      '  "con$puc"."ID_AGENCIA" = :"ID_AGENCIA"')
    SelectSQL.Strings = (
      'select * from "con$puc" order by "con$puc"."CODIGO"')
    ModifySQL.Strings = (
      'update "con$puc"'
      'set'
      '  "con$puc"."CODIGO" = :"CODIGO",'
      '  "con$puc"."ID_AGENCIA" = :"ID_AGENCIA",'
      '  "con$puc"."CLAVE" = :"CLAVE",'
      '  "con$puc"."NOMBRE" = :"NOMBRE",'
      '  "con$puc"."TIPO" = :"TIPO",'
      '  "con$puc"."CODIGOMAYOR" = :"CODIGOMAYOR",'
      '  "con$puc"."MOVIMIENTO" = :"MOVIMIENTO",'
      '  "con$puc"."ESBANCO" = :"ESBANCO",'
      '  "con$puc"."INFORME" = :"INFORME",'
      '  "con$puc"."NIVEL" = :"NIVEL",'
      '  "con$puc"."NATURALEZA" = :"NATURALEZA",'
      '  "con$puc"."CENTROCOSTO" = :"CENTROCOSTO",'
      '  "con$puc"."SALDOINICIAL" = :"SALDOINICIAL"'
      'where'
      '  "con$puc"."CODIGO" = :"OLD_CODIGO" and'
      '  "con$puc"."ID_AGENCIA" = :"OLD_ID_AGENCIA"')
    GeneratorField.Field = 'codigo'
    Left = 124
    Top = 62
  end
  object DataSourceInformes: TDataSource
    DataSet = IBDataSetinformes
    Left = 24
    Top = 125
  end
  object IBDataSetinformes: TIBDataSet
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    RefreshSQL.Strings = (
      'Select '
      '  "con$informes"."ID",'
      '  "con$informes"."DESCRIPCION",'
      '  "con$informes"."PIDOID",'
      '  "con$informes"."PIDOMONTO",'
      '  "con$informes"."PIDOTASA",'
      '  "con$informes"."PIDOTIPOID"'
      'from "con$informes" '
      'where'
      '  "con$informes"."ID" = :"ID"')
    SelectSQL.Strings = (
      'select * from "con$informes"')
    Left = 128
    Top = 125
  end
  object DataSourcecentros: TDataSource
    DataSet = IBDataSetcentros
    Left = 24
    Top = 192
  end
  object IBDataSetcentros: TIBDataSet
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    RefreshSQL.Strings = (
      'Select '
      '  "con$centrocosto"."ID",'
      '  "con$centrocosto"."DESCRIPCION"'
      'from "con$centrocosto" '
      'where'
      '  "con$centrocosto"."ID" = :"ID"')
    SelectSQL.Strings = (
      'select * from "con$centrocosto"')
    ModifySQL.Strings = (
      '')
    Left = 128
    Top = 192
  end
  object IBDataSetSaldos: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "con$saldoscuenta" where '
      '"con$saldoscuenta"."CODIGO" = :"CODIGO" and'
      '"con$saldoscuenta"."ID_AGENCIA" =:"ID_AGENCIA" '
      'order by "con$saldoscuenta"."MES"')
    Left = 106
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODIGO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_AGENCIA'
        ParamType = ptUnknown
      end>
  end
end
