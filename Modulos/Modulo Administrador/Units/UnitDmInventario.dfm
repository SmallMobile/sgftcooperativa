object DmInventario: TDmInventario
  OldCreateOrder = False
  Left = 355
  Top = 204
  Height = 150
  Width = 215
  object IBDatabase1: TIBDatabase
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    Left = 8
    Top = 8
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 56
    Top = 8
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 128
    Top = 16
  end
end
