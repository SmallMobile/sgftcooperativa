object dmColocacion: TdmColocacion
  OldCreateOrder = False
  Left = 286
  Top = 114
  Height = 395
  Width = 284
  object IBQuery: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select CODIGO,"nombre",DEBITO,CREDITO FROM "col$concol" left joi' +
        'n "con$puc" ON "col$concol"."CODIGO" = "con$puc"."codigo" ')
    Left = 152
    Top = 186
  end
  object IBQuery1: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTransaction3
    BufferChunks = 1000
    CachedUpdates = False
    Left = 104
    Top = 185
  end
  object IBQueryVarios: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 152
    Top = 234
  end
  object IBDScontable: TIBDataSet
    Database = frmdata.IBDatabase2
    Transaction = IBTransaction6
    BufferChunks = 1000
    CachedUpdates = False
    DeleteSQL.Strings = (
      '')
    InsertSQL.Strings = (
      'insert into "col$concol"'
      '  ("col$concol"."ID_AGENCIA", "col$concol"."ID_COLOCACION", '
      '"col$concol"."CODIGO", '
      '   "col$concol"."DEBITO", "col$concol"."CREDITO", '
      '"col$concol"."FECHA_Y_HORA")'
      'values'
      
        '  (:"ID_AGENCIA", :"ID_COLOCACION", :"CODIGO", :"DEBITO", :"CRED' +
        'ITO", '
      ':"FECHA_Y_HORA")')
    RefreshSQL.Strings = (
      'Select '
      '  "col$concol"."ID_AGENCIA",'
      '  "col$concol"."ID_COLOCACION",'
      '  "col$concol"."CODIGO",'
      '  "col$concol"."DEBITO",'
      '  "col$concol"."CREDITO",'
      '  "col$concol"."FECHA_Y_HORA"'
      'from "col$concol" '
      'where'
      '  "col$concol"."ID_AGENCIA" = :"ID_AGENCIA" and'
      '  "col$concol"."ID_COLOCACION" = :"ID_COLOCACION"')
    SelectSQL.Strings = (
      'select * from "col$concol" where ID_COLOCACION = '#39'00000000000'#39)
    ModifySQL.Strings = (
      'update "col$concol"'
      'set'
      '  "col$concol"."ID_AGENCIA" = :"ID_AGENCIA",'
      '  "col$concol"."ID_COLOCACION" = :"ID_COLOCACION",'
      '  "col$concol"."CODIGO" = :"CODIGO",'
      '  "col$concol"."DEBITO" = :"DEBITO",'
      '  "col$concol"."CREDITO" = :"CREDITO",'
      '  "col$concol"."FECHA_Y_HORA" = :"FECHA_Y_HORA"'
      'where'
      '  "col$concol"."ID_AGENCIA" = :"OLD_ID_AGENCIA" and'
      '  "col$concol"."ID_COLOCACION" = :"OLD_ID_COLOCACION"')
    Left = 222
    Top = 10
  end
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = frmdata.IBDatabase2
    AutoStopAction = saNone
    Left = 8
    Top = 184
  end
  object IBTransaction2: TIBTransaction
    Active = False
    DefaultDatabase = frmdata.IBDatabase2
    AutoStopAction = saNone
    Left = 8
    Top = 232
  end
  object IBTransaction3: TIBTransaction
    Active = False
    DefaultDatabase = frmdata.IBDatabase2
    AutoStopAction = saNone
    Left = 56
    Top = 232
  end
  object IBTransaction4: TIBTransaction
    Active = False
    DefaultDatabase = frmdata.IBDatabase2
    AutoStopAction = saNone
    Left = 208
    Top = 136
  end
  object IBTransaction5: TIBTransaction
    Active = False
    DefaultDatabase = frmdata.IBDatabase2
    AutoStopAction = saNone
    Left = 48
    Top = 184
  end
  object IBTransaction6: TIBTransaction
    Active = False
    DefaultDatabase = frmdata.IBDatabase2
    AutoStopAction = saNone
    Left = 104
    Top = 232
  end
  object IBSQL: TIBSQL
    Database = frmdata.IBDatabase2
    ParamCheck = True
    Transaction = IBTransaction4
    Left = 128
  end
  object IBSQLcodigos: TIBSQL
    Database = frmdata.IBDatabase2
    ParamCheck = True
    Transaction = IBTransaction5
    Left = 24
    Top = 16
  end
end
