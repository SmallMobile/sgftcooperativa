object FrmDbProgres: TFrmDbProgres
  Left = 212
  Top = 240
  Width = 345
  Height = 108
  BorderIcons = []
  Caption = 'Generando Reportes de Cartera'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 337
    Height = 73
    TabOrder = 0
    object JV: TJvSpecialProgress
      Left = 8
      Top = 47
      Width = 321
      Height = 20
      BorderStyle = bsSingle
      Caption = 'JV'
      Color = clWhite
      EndColor = clBlue
      GradientBlocks = True
      ParentColor = False
      Solid = True
    end
    object Label1: TLabel
      Left = 11
      Top = 10
      Width = 171
      Height = 13
      Caption = 'Espere un Momento por Favor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 11
      Top = 30
      Width = 284
      Height = 13
      Caption = 'Este Procedimiento puede tardar varios Minutos...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Timer1: TTimer
    Interval = 60
    Left = 272
    Top = 40
  end
end
