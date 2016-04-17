object Form1: TForm1
  Left = 288
  Top = 236
  Width = 593
  Height = 324
  Caption = 'Traslado de Imagenes'
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
    Left = 8
    Top = 8
    Width = 58
    Height = 13
    Caption = 'Base Origen'
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 63
    Height = 13
    Caption = 'Base Destino'
  end
  object Label3: TLabel
    Left = 8
    Top = 80
    Width = 36
    Height = 13
    Caption = 'Usuario'
  end
  object Label4: TLabel
    Left = 8
    Top = 104
    Width = 54
    Height = 13
    Caption = 'Contrase'#241'a'
  end
  object Image1: TImage
    Left = 8
    Top = 136
    Width = 177
    Height = 153
    Center = True
    Stretch = True
  end
  object Label5: TLabel
    Left = 200
    Top = 144
    Width = 81
    Height = 13
    Caption = 'Tama'#241'o Normal: '
  end
  object Label6: TLabel
    Left = 200
    Top = 168
    Width = 70
    Height = 13
    Caption = 'Tama'#241'o Final: '
  end
  object Image2: TImage
    Left = 400
    Top = 136
    Width = 177
    Height = 153
    Center = True
    Stretch = True
  end
  object Label7: TLabel
    Left = 200
    Top = 80
    Width = 47
    Height = 13
    Caption = 'Iniciar En:'
  end
  object edDBOrigen: TEdit
    Left = 88
    Top = 6
    Width = 305
    Height = 21
    TabOrder = 0
  end
  object edDBDestino: TEdit
    Left = 88
    Top = 38
    Width = 305
    Height = 21
    TabOrder = 1
  end
  object edUsuario: TEdit
    Left = 88
    Top = 78
    Width = 97
    Height = 21
    TabOrder = 2
  end
  object edPasabordo: TEdit
    Left = 88
    Top = 102
    Width = 97
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
  end
  object btnIniciar: TBitBtn
    Left = 456
    Top = 64
    Width = 97
    Height = 25
    Caption = '&Iniciar Proceso'
    TabOrder = 4
    OnClick = btnIniciarClick
  end
  object btnDetener: TBitBtn
    Left = 456
    Top = 96
    Width = 97
    Height = 25
    Caption = '&Detener Proceso'
    TabOrder = 5
    OnClick = btnDetenerClick
  end
  object btnSalir: TBitBtn
    Left = 480
    Top = 8
    Width = 81
    Height = 25
    Caption = '&Salir'
    TabOrder = 6
    OnClick = btnSalirClick
  end
  object edSizeNormal: TStaticText
    Left = 288
    Top = 142
    Width = 97
    Height = 17
    AutoSize = False
    Color = clWhite
    ParentColor = False
    TabOrder = 7
  end
  object edSizeFinal: TStaticText
    Left = 288
    Top = 166
    Width = 97
    Height = 17
    AutoSize = False
    Color = clWhite
    ParentColor = False
    TabOrder = 8
  end
  object btnSiguiente: TBitBtn
    Left = 200
    Top = 200
    Width = 75
    Height = 25
    Caption = '&Siguiente'
    TabOrder = 9
    OnClick = btnSiguienteClick
  end
  object edDocumento: TEdit
    Left = 250
    Top = 77
    Width = 121
    Height = 21
    TabOrder = 10
    Text = '0'
  end
  object IBOrigen: TIBDatabase
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    Left = 408
    Top = 8
  end
  object IBDestino: TIBDatabase
    LoginPrompt = False
    DefaultTransaction = IBTransaction2
    Left = 408
    Top = 48
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBOrigen
    DefaultAction = TARollback
    Left = 440
    Top = 8
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = IBDestino
    DefaultAction = TARollback
    Left = 440
    Top = 48
  end
  object IBQuery1: TIBQuery
    Left = 408
    Top = 88
  end
  object IBQuery2: TIBQuery
    Database = IBDestino
    Transaction = IBTransaction2
    Left = 440
    Top = 88
  end
end
