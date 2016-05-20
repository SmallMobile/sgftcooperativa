object DataQuerys: TDataQuerys
  OldCreateOrder = False
  Left = 139
  Top = 206
  Height = 150
  Width = 388
  object IBdatos: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTrandatos
    Left = 8
  end
  object IBselecion: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTranselecion
    Left = 56
  end
  object IBingresa: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTraningresa
    Left = 104
  end
  object IBTrandatos: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 8
    Top = 48
  end
  object IBTranselecion: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 56
    Top = 48
  end
  object IBTraningresa: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 104
    Top = 48
  end
  object IBFundacion: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBtranFundacion
    Left = 152
  end
  object IBtranFundacion: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 152
    Top = 48
  end
  object IBSQL1: TIBSQL
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    Left = 192
  end
  object IBSQL2: TIBSQL
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    Left = 232
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 200
    Top = 56
  end
end
