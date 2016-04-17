object FrmQuerys: TFrmQuerys
  OldCreateOrder = False
  Left = 248
  Top = 165
  Height = 150
  Width = 381
  object IBseleccion: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTranseleccion
    BufferChunks = 1000
    CachedUpdates = False
    Left = 8
    Top = 8
  end
  object IBregistro: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTranregistro
    BufferChunks = 1000
    CachedUpdates = False
    Left = 56
    Top = 8
  end
  object IBTranseleccion: TIBTransaction
    Active = False
    DefaultDatabase = frmdata.IBDatabase2
    AutoStopAction = saNone
    Left = 8
    Top = 56
  end
  object IBTranregistro: TIBTransaction
    Active = False
    DefaultDatabase = frmdata.IBDatabase2
    AutoStopAction = saNone
    Left = 56
    Top = 56
  end
  object IBSQL1: TIBSQL
    Database = frmdata.IBDatabase2
    ParamCheck = True
    Transaction = IBTIBsql
    Left = 104
    Top = 8
  end
  object IBTIBsql: TIBTransaction
    Active = False
    DefaultDatabase = frmdata.IBDatabase2
    AutoStopAction = saNone
    Left = 104
    Top = 56
  end
  object IBSaldo: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 144
    Top = 8
  end
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = frmdata.IBDatabase2
    AutoStopAction = saNone
    Left = 144
    Top = 56
  end
end
