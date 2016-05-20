object Form1: TForm1
  Left = 266
  Top = 135
  Width = 460
  Height = 559
  Caption = 'Paso de Imagenes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 4
    Top = 78
    Width = 207
    Height = 167
    Stretch = True
  end
  object Label2: TLabel
    Left = 217
    Top = 113
    Width = 63
    Height = 13
    Caption = 'Tama'#241'o Foto'
  end
  object Label3: TLabel
    Left = 217
    Top = 139
    Width = 67
    Height = 13
    Caption = 'Tama'#241'o Firma'
  end
  object Label4: TLabel
    Left = 217
    Top = 165
    Width = 74
    Height = 13
    Caption = 'Tama'#241'o Foto H'
  end
  object Label5: TLabel
    Left = 217
    Top = 191
    Width = 76
    Height = 13
    Caption = 'Tama'#241'o Dato H'
  end
  object Image3: TImage
    Left = 4
    Top = 249
    Width = 320
    Height = 160
  end
  object Image5: TImage
    Left = 52
    Top = 416
    Width = 105
    Height = 105
  end
  object Label1: TLabel
    Left = 250
    Top = 6
    Width = 25
    Height = 13
    Caption = 'Inicio'
  end
  object Label6: TLabel
    Left = 248
    Top = 32
    Width = 59
    Height = 13
    Caption = 'Transcurrido'
  end
  object Button1: TButton
    Left = 4
    Top = 4
    Width = 115
    Height = 25
    Caption = 'Comprimir e Insertar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object EdFoto: TEdit
    Left = 292
    Top = 109
    Width = 73
    Height = 21
    TabOrder = 1
  end
  object EdFirma: TEdit
    Left = 292
    Top = 135
    Width = 73
    Height = 21
    TabOrder = 2
  end
  object EdFHuella: TEdit
    Left = 292
    Top = 161
    Width = 73
    Height = 21
    TabOrder = 3
  end
  object EdDHuella: TEdit
    Left = 292
    Top = 187
    Width = 73
    Height = 21
    TabOrder = 4
  end
  object EdCFoto: TEdit
    Left = 372
    Top = 109
    Width = 73
    Height = 21
    TabOrder = 5
  end
  object EdCfirma: TEdit
    Left = 372
    Top = 135
    Width = 73
    Height = 21
    TabOrder = 6
  end
  object EdCFHuella: TEdit
    Left = 372
    Top = 161
    Width = 73
    Height = 21
    TabOrder = 7
  end
  object EdCDHuella: TEdit
    Left = 372
    Top = 187
    Width = 73
    Height = 21
    TabOrder = 8
  end
  object EdInicio: TEdit
    Left = 286
    Top = 2
    Width = 163
    Height = 21
    TabOrder = 9
  end
  object EdTranscurso: TEdit
    Left = 310
    Top = 28
    Width = 141
    Height = 21
    TabOrder = 10
  end
  object Bar2: TJvProgressBar
    Left = 4
    Top = 52
    Width = 445
    Height = 21
    Min = 0
    Max = 100
    TabOrder = 11
  end
  object Bar1: TJvProgressBar
    Left = 4
    Top = 30
    Width = 237
    Height = 21
    Min = 0
    Max = 100
    TabOrder = 12
    BarColor = clRed
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 132
    Top = 4
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = '192.168.200.7:/var/db/fbird/database.fdb'
    Params.Strings = (
      'user_name=ADMDOR'
      'password=nino2001'
      'sql_role_name=CAPTACIONES'
      'lc_ctype=ISO8859_1')
    LoginPrompt = False
    Left = 162
    Top = 4
  end
  object IBSQL1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 190
    Top = 4
  end
  object IBSQL2: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 220
    Top = 4
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 254
    Top = 24
  end
  object Cds: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 162
    Top = 34
    Data = {
      530000009619E0BD01000000180000000200000000000300000053001149445F
      4944454E54494649434143494F4E04000100000000000A49445F504552534F4E
      410100490000000100055749445448020002000F000000}
    object CdsID_IDENTIFICACION: TIntegerField
      FieldName = 'ID_IDENTIFICACION'
    end
    object CdsID_PERSONA: TStringField
      FieldName = 'ID_PERSONA'
      Size = 15
    end
  end
end
