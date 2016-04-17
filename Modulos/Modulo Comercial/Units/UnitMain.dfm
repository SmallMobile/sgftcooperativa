object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 564
  ClientWidth = 788
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 440
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object MainMenu1: TMainMenu
    Left = 248
    Top = 256
    object Generales1: TMenuItem
      Caption = 'Generales'
      object CAmbiarContrasea1: TMenuItem
        Caption = 'Cambiar Contrase'#241'a'
      end
      object Salir1: TMenuItem
        Caption = 'Salir'
        OnClick = Salir1Click
      end
    end
    object ProcesosEspeciales1: TMenuItem
      Caption = 'Procesos Especiales'
      object Contratuales1: TMenuItem
        Caption = 'Contratuales'
        OnClick = Contratuales1Click
      end
    end
    object Informes1: TMenuItem
      Caption = 'Informes'
    end
  end
  object JvSimpleXML1: TJvSimpleXML
    IndentString = '  '
    Left = 184
    Top = 305
  end
end
