object frmDB: TfrmDB
  Left = 169
  Top = 255
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Progreso'
  ClientHeight = 80
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Info: TLabel
    Left = 6
    Top = 14
    Width = 313
    Height = 19
    AutoSize = False
    Caption = 'Espere un Momento por Favor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object barra: TJvSpecialProgress
    Left = 3
    Top = 47
    Width = 321
    Height = 20
    BorderStyle = bsSingle
    Caption = 'barra'
    Color = clWhite
    EndColor = clBlue
    GradientBlocks = True
    ParentColor = False
    Solid = True
  end
end
