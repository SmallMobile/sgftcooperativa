object Form1: TForm1
  Left = 180
  Top = 138
  Width = 667
  Height = 549
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
    Left = 6
    Top = 12
    Width = 55
    Height = 13
    Caption = 'Documento'
  end
  object Image1: TImage
    Left = 4
    Top = 40
    Width = 201
    Height = 157
    Stretch = True
  end
  object Label2: TLabel
    Left = 217
    Top = 42
    Width = 63
    Height = 13
    Caption = 'Tama'#241'o Foto'
  end
  object Label3: TLabel
    Left = 217
    Top = 68
    Width = 67
    Height = 13
    Caption = 'Tama'#241'o Firma'
  end
  object Label4: TLabel
    Left = 217
    Top = 94
    Width = 74
    Height = 13
    Caption = 'Tama'#241'o Foto H'
  end
  object Label5: TLabel
    Left = 217
    Top = 120
    Width = 76
    Height = 13
    Caption = 'Tama'#241'o Dato H'
  end
  object Image2: TImage
    Left = 453
    Top = 39
    Width = 201
    Height = 157
    IncrementalDisplay = True
    Stretch = True
  end
  object Image3: TImage
    Left = 4
    Top = 204
    Width = 320
    Height = 160
  end
  object Image4: TImage
    Left = 334
    Top = 204
    Width = 320
    Height = 160
  end
  object Image5: TImage
    Left = 52
    Top = 384
    Width = 105
    Height = 105
  end
  object Image6: TImage
    Left = 496
    Top = 380
    Width = 105
    Height = 105
  end
  object EdId: TEdit
    Left = 66
    Top = 8
    Width = 137
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 206
    Top = 8
    Width = 115
    Height = 25
    Caption = 'Comprimir e Insertar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object EdFoto: TEdit
    Left = 292
    Top = 38
    Width = 73
    Height = 21
    TabOrder = 2
  end
  object EdFirma: TEdit
    Left = 292
    Top = 64
    Width = 73
    Height = 21
    TabOrder = 3
  end
  object EdFHuella: TEdit
    Left = 292
    Top = 90
    Width = 73
    Height = 21
    TabOrder = 4
  end
  object EdDHuella: TEdit
    Left = 292
    Top = 116
    Width = 73
    Height = 21
    TabOrder = 5
  end
  object EdCFoto: TEdit
    Left = 372
    Top = 38
    Width = 73
    Height = 21
    TabOrder = 6
  end
  object EdCfirma: TEdit
    Left = 372
    Top = 64
    Width = 73
    Height = 21
    TabOrder = 7
  end
  object EdCFHuella: TEdit
    Left = 372
    Top = 90
    Width = 73
    Height = 21
    TabOrder = 8
  end
  object EdCDHuella: TEdit
    Left = 372
    Top = 116
    Width = 73
    Height = 21
    TabOrder = 9
  end
  object Button2: TButton
    Left = 324
    Top = 8
    Width = 177
    Height = 25
    Caption = 'Recuperar y Descomprimir'
    TabOrder = 10
    OnClick = Button2Click
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 14
    Top = 36
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = '192.168.200.2:/var/db/fbird/database.fdb'
    Params.Strings = (
      'user_name=ADMDOR'
      'password=nino2001'
      'sql_role_name=CAPTACIONES'
      'lc_ctype=ISO8859_1')
    LoginPrompt = False
    Left = 44
    Top = 36
  end
  object IBSQL1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 72
    Top = 36
  end
end
