object frmdata: Tfrmdata
  OldCreateOrder = False
  Left = 258
  Top = 301
  Height = 88
  Width = 199
  object IBTransaction2: TIBTransaction
    DefaultDatabase = IBDatabase2
    DefaultAction = TACommitRetaining
    Left = 24
  end
  object IBDatabase2: TIBDatabase
    DatabaseName = '192.168.200.7:/var/db/fbird/database.fdb'
    Params.Strings = (
      'lc_ctype=ISO8859_1'
      'password=masterkey'
      'user_name=sysdba')
    LoginPrompt = False
    DefaultTransaction = IBTransaction2
    Left = 72
  end
end
