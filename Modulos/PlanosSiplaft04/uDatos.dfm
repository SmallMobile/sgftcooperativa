object DataModule4: TDataModule4
  OldCreateOrder = False
  Height = 135
  Width = 216
  object _cdsSelect: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = '_dspSelect'
    Left = 128
    Top = 80
  end
  object _dspSelect: TDataSetProvider
    DataSet = _qrSelect
    Left = 32
    Top = 80
  end
  object _ibdb: TIBDatabase
    DatabaseName = '192.168.200.254:/dbase/01032009/database.fdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    Left = 24
    Top = 8
  end
  object _qrSelect: TIBQuery
    Database = _ibdb
    Transaction = _ibt
    SQL.Strings = (
      'SELECT * FROM CON$UIAFPRODUCTOS')
    Left = 104
    Top = 8
  end
  object _ibt: TIBTransaction
    DefaultDatabase = _ibdb
    DefaultAction = TARollback
    Left = 168
    Top = 32
  end
end
