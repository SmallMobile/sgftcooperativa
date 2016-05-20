object frmProgresos: TfrmProgresos
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
    Top = 17
    Width = 313
    Height = 19
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Barra: TJvSpecialProgress
    Left = 4
    Top = 49
    Width = 315
    Height = 24
    BorderStyle = bsSingle
    Caption = '0%'
    Color = clHighlightText
    EndColor = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    GradientBlocks = True
    ParentColor = False
    ParentFont = False
    Solid = True
    Step = 1
    TextCentered = True
    TextOption = toCaption
  end
end
