object Form1: TForm1
  Left = 184
  Top = 236
  Width = 433
  Height = 186
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
    Left = 18
    Top = 84
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object JvFilenameEdit1: TJvFilenameEdit
    Left = 16
    Top = 8
    Width = 265
    Height = 21
    ButtonFlat = False
    NumGlyphs = 1
    TabOrder = 0
    Text = 'JvFilenameEdit1'
  end
  object BitBtn1: TBitBtn
    Left = 288
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Conectar'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 16
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Procesar'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object pFIBDatabase1: TpFIBDatabase
    DBName = '192.168.1.2:/var/db/fbird/database.fdb'
    DBParams.Strings = (
      'lc_ctype=ISO8859_1'
      'password=masterkey'
      'user_name=SYSDBA')
    DefaultTransaction = pFIBTransaction1
    SQLDialect = 3
    Timeout = 0
    WaitForRestoreConnect = 0
    Left = 328
    Top = 56
  end
  object pFIBTransaction1: TpFIBTransaction
    DefaultDatabase = pFIBDatabase1
    TimeoutAction = TARollback
    Left = 376
    Top = 64
  end
  object pFIBQuery1: TpFIBQuery
    Database = pFIBDatabase1
    Transaction = pFIBTransaction1
    Left = 376
    Top = 88
  end
end
