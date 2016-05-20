object Form1: TForm1
  Left = 253
  Top = 190
  Width = 471
  Height = 479
  Caption = 'Corregir Colocaciones'
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
    Width = 76
    Height = 13
    Caption = 'Base de Datos: '
  end
  object Edit1: TEdit
    Left = 83
    Top = 5
    Width = 222
    Height = 21
    TabOrder = 0
    Text = '192.168.200.141:/var/db/fbird/database.fdb'
  end
  object Button1: TButton
    Left = 309
    Top = 4
    Width = 75
    Height = 25
    Caption = 'Conectar....'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 384
    Top = 4
    Width = 75
    Height = 25
    Caption = 'Deconectar'
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 40
    Width = 461
    Height = 225
    Caption = 'Colocaci'#243'n'
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
    end
    object EdColocacion: TEdit
      Left = 48
      Top = 15
      Width = 84
      Height = 21
      TabOrder = 0
    end
  end
end
