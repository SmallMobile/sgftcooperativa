object FrmTipo: TFrmTipo
  Left = 188
  Top = 262
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Tipo de Reporte'
  ClientHeight = 68
  ClientWidth = 152
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 0
    Width = 151
    Height = 34
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object RGrafico: TRadioButton
      Left = 8
      Top = 9
      Width = 113
      Height = 17
      Caption = '&Grafico'
      TabOrder = 0
    end
    object Rtextual: TRadioButton
      Left = 80
      Top = 10
      Width = 66
      Height = 17
      Caption = '&Textual'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 35
    Width = 151
    Height = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object BTaceptar: TButton
      Left = 41
      Top = 3
      Width = 75
      Height = 25
      Caption = '&Aceptar'
      ModalResult = 1
      TabOrder = 0
      OnClick = BTaceptarClick
    end
  end
end
