object Form1: TForm1
  Left = 223
  Top = 225
  Width = 544
  Height = 375
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
  object Button1: TButton
    Left = 240
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 232
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object IdTCPClient1: TIdTCPClient
    Port = 0
    Left = 104
    Top = 72
  end
end
