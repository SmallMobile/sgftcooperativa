object frmdata: Tfrmdata
  OldCreateOrder = False
  Left = 184
  Top = 211
  Height = 150
  Width = 215
  object IBTransaction2: TIBTransaction
    Active = False
    DefaultDatabase = IBDatabase2
    DefaultAction = TACommitRetaining
    AutoStopAction = saNone
    Left = 40
    Top = 8
  end
  object IBDatabase2: TIBDatabase
    DatabaseName = '192.168.1.7:/var/db/fbird/coopservir.gdb'
    Params.Strings = (
      'user_name=wuribe'
      'password=wuribe'
      'lc_ctype=ISO8859_1')
    LoginPrompt = False
    DefaultTransaction = IBTransaction2
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 120
    Top = 8
  end
  object IBQuery3: TIBQuery
    Database = IBDatabase2
    Transaction = IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    Left = 32
    Top = 56
  end
end
