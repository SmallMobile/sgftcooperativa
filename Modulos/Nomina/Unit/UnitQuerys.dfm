object DataQuerys: TDataQuerys
  OldCreateOrder = False
  Left = 241
  Top = 176
  Height = 150
  Width = 408
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
  object IBaportes: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBtranaportes
    Left = 152
  end
  object IBtranaportes: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 152
    Top = 48
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction1
    Left = 200
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 200
    Top = 48
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = DataGeneral.IBDatabase1
    Left = 280
    Top = 56
  end
  object IBdata: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = IBTransaction2
    Left = 280
  end
end
