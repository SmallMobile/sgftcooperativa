object FrmCredito: TFrmCredito
  Left = 11
  Top = 134
  Width = 543
  Height = 406
  Caption = 'Ejemplos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object lista: TListBox
    Left = 280
    Top = 0
    Width = 121
    Height = 257
    ItemHeight = 13
    TabOrder = 1
  end
  object Button2: TButton
    Left = 32
    Top = 24
    Width = 185
    Height = 33
    Caption = 'ACTUALIZA  DATOS ASOCIADO'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 56
    Top = 248
    Width = 153
    Height = 25
    Caption = 'VERIFICA SI ESTA'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 0
    Top = 80
    Width = 75
    Height = 25
    Caption = 'TITULAR'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 0
    Top = 104
    Width = 177
    Height = 33
    Caption = 'Actualiza Oficina'
    TabOrder = 5
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 0
    Top = 136
    Width = 177
    Height = 25
    Caption = 'Actiualiza 4'
    TabOrder = 6
    OnClick = Button6Click
  end
  object BitBtn1: TBitBtn
    Left = 176
    Top = 296
    Width = 235
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 7
    OnClick = BitBtn1Click
  end
  object ActionList1: TActionList
    Left = 216
    Top = 64
  end
end
