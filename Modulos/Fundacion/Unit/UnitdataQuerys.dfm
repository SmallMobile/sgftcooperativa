object FrmQuerys: TFrmQuerys
  OldCreateOrder = False
  Left = 194
  Top = 180
  Height = 150
  Width = 381
  object IBseleccion: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTranseleccion
    Left = 8
    Top = 8
  end
  object IBregistro: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTranregistro
    Left = 80
    Top = 8
  end
  object IBTranseleccion: TIBTransaction
    DefaultDatabase = frmdata.IBDatabase2
    Left = 8
    Top = 56
  end
  object IBTranregistro: TIBTransaction
    DefaultDatabase = frmdata.IBDatabase2
    Left = 72
    Top = 56
  end
  object IBSQL1: TIBSQL
    Database = frmdata.IBDatabase2
    Transaction = IBTIBsql
    Left = 144
    Top = 8
  end
  object IBTIBsql: TIBTransaction
    DefaultDatabase = frmdata.IBDatabase2
    Left = 144
    Top = 56
  end
  object IBfianzas: TIBQuery
    Database = frmdata.IBDatabase2
    Transaction = IBTransaction1
    Left = 216
    Top = 16
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = frmdata.IBDatabase2
    Left = 216
    Top = 72
  end
end
