object DataGeneral: TDataGeneral
  OldCreateOrder = False
  Left = 301
  Top = 232
  Height = 216
  Width = 324
  object IBDatabase1: TIBDatabase
    DatabaseName = ':'
    LoginPrompt = False
    Left = 96
    Top = 24
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 40
    Top = 24
  end
  object IBsql: TIBSQL
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 128
    Top = 96
  end
  object IBdatos: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 192
    Top = 16
  end
  object IBsel: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 48
    Top = 104
  end
  object IBsel1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 184
    Top = 128
  end
end
