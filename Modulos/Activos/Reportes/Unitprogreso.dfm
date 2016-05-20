object FrmProgreso: TFrmProgreso
  Left = 189
  Top = 280
  Width = 400
  Height = 76
  BorderIcons = []
  Caption = 'Progreso de la Depreciacion'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object BarraProgreso: TProgressBar
    Left = 0
    Top = 0
    Width = 392
    Height = 42
    Align = alBottom
    Min = 1
    Max = 100
    Position = 1
    Smooth = True
    Step = 2
    TabOrder = 0
  end
end
