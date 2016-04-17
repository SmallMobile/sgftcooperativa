object Form1: TForm1
  Left = 165
  Top = 130
  Width = 544
  Height = 178
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 14
    Top = 52
    Width = 45
    Height = 13
    Caption = 'Id Actual:'
  end
  object Label2: TLabel
    Left = 64
    Top = 52
    Width = 32
    Height = 13
    Caption = 'Label2'
    Color = clWhite
    ParentColor = False
  end
  object BitBtn1: TBitBtn
    Left = 148
    Top = 12
    Width = 135
    Height = 25
    Caption = 'Iniciar Importaci'#243'n'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 8
    Top = 14
    Width = 75
    Height = 25
    Caption = 'Conectar'
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object Edit1: TEdit
    Left = 148
    Top = 72
    Width = 137
    Height = 21
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 148
    Top = 44
    Width = 23
    Height = 21
    TabOrder = 3
  end
  object pFIBAnterior: TpFIBDatabase
    DBName = '192.168.1.2:/var/db/fbird/cooperativa.gdb'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'lc_ctype=ISO8859_1'
      'password=masterkey')
    DefaultTransaction = pFIBTransaction1
    SQLDialect = 3
    Timeout = 0
    AliasName = 'cooperativa'
    WaitForRestoreConnect = 0
    Left = 450
    Top = 44
  end
  object pFIBTransaction1: TpFIBTransaction
    DefaultDatabase = pFIBAnterior
    TimeoutAction = TARollback
    Left = 422
    Top = 16
  end
  object pFIBNueva: TpFIBDatabase
    DBName = '192.168.1.2:/var/db/fbird/database.fdb'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=masterkey'
      'lc_ctype=ISO8859_1')
    DefaultTransaction = pFIBTransaction2
    SQLDialect = 3
    Timeout = 0
    AliasName = 'database'
    WaitForRestoreConnect = 0
    Left = 422
    Top = 44
  end
  object pFIBTransaction2: TpFIBTransaction
    DefaultDatabase = pFIBNueva
    TimeoutAction = TARollback
    Left = 450
    Top = 16
  end
  object IBQuery1: TpFIBQuery
    Database = pFIBAnterior
    Transaction = pFIBTransaction1
    Left = 478
    Top = 16
  end
  object IBQuery2: TpFIBQuery
    Database = pFIBNueva
    Transaction = pFIBTransaction2
    Left = 478
    Top = 44
  end
end
