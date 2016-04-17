object DataGeneral: TDataGeneral
  OldCreateOrder = False
  Left = 199
  Top = 176
  Height = 241
  Width = 368
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = '192.168.200.2:/var/db/fbird/inventario.gdb'
    Params.Strings = (
      'lc_ctype=ISO8859_1'
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    Left = 235
    Top = 32
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    DefaultAction = TACommitRetaining
    Left = 43
    Top = 5
  end
  object IBsql: TIBSQL
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 3
    Top = 101
  end
  object IBdatos: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 3
    Top = 53
  end
  object IBsel: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 35
    Top = 101
  end
  object IBsel1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 83
    Top = 61
  end
  object Ibacta: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    ForcedRefresh = True
    Filtered = True
    Left = 72
    Top = 104
  end
  object Ibdatos1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 80
    Top = 8
  end
  object ibglobal: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 40
    Top = 56
  end
  object IBsel3: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction2
    Left = 8
    Top = 152
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 48
    Top = 160
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 144
    Top = 16
  end
  object IBTransaction3: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 152
    Top = 88
  end
end
