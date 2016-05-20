object frmSiplaft4: TfrmSiplaft4
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Procesar Planos Siplaft'
  ClientHeight = 208
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 48
    Width = 63
    Height = 13
    Caption = 'Fecha Inicial:'
  end
  object Label2: TLabel
    Left = 8
    Top = 75
    Width = 55
    Height = 13
    Caption = 'FechaFinal:'
  end
  object Label5: TLabel
    Left = 8
    Top = 116
    Width = 67
    Height = 13
    Caption = 'Archivo Texto'
  end
  object _bitConectar: TBitBtn
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Conectar'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = _bitConectarClick
  end
  object _edtFechaInicial: TDateTimePicker
    Left = 77
    Top = 48
    Width = 100
    Height = 21
    Date = 39826.673048206020000000
    Time = 39826.673048206020000000
    TabOrder = 1
  end
  object _edtFechaFinal: TDateTimePicker
    Left = 77
    Top = 75
    Width = 100
    Height = 21
    Date = 39826.673202685180000000
    Time = 39826.673202685180000000
    TabOrder = 2
    OnExit = _edtFechaFinalExit
  end
  object _bitProcesar: TBitBtn
    Left = 102
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Procesar'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = _bitProcesarClick
  end
  object BitBtn1: TBitBtn
    Left = 256
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Cerrar'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object _edtFile: TStaticText
    Left = 136
    Top = 113
    Width = 121
    Height = 21
    AutoSize = False
    BevelOuter = bvRaised
    BorderStyle = sbsSunken
    Color = clBtnFace
    ParentColor = False
    TabOrder = 5
  end
  object _bar: TJvProgressBar
    Left = 8
    Top = 183
    Width = 321
    Height = 17
    TabOrder = 6
  end
end
