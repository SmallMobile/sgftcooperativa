object dmcomprobante: Tdmcomprobante
  OldCreateOrder = False
  Left = 354
  Top = 209
  Height = 230
  Width = 312
  object DataComprobante: TIBDataSet
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    SelectSQL.Strings = (
      'select * from  "con$tipocomprobante"')
    Top = 48
  end
  object Dsagencia: TDataSource
    DataSet = dataagencia
    Left = 16
    Top = 152
  end
  object Dstipocom: TDataSource
    DataSet = DataComprobante
    Left = 40
    Top = 40
  end
  object IBQuery1: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    Left = 96
  end
  object buscacodigo: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select "con$puc"."CODIGO" from "con$puc"'
      'where "con$puc"."NOMBRE" like :"nombre" AND'
      '"con$puc"."CODIGO" like :"codigo" || '#39'%'#39)
    Left = 8
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'nombre'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'codigo'
        ParamType = ptUnknown
      end>
  end
  object IBQuery2: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    Left = 80
    Top = 48
  end
  object ibbuscada: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    Left = 64
    Top = 65535
  end
  object tipocomprobante: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from  "con$tipocomprobante"')
    Left = 48
    Top = 96
  end
  object Ibdatos1: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = frmdata.IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    Left = 88
    Top = 93
  end
  object dataagencia: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from "Inv$Agencia"')
    Left = 88
    Top = 152
  end
end
