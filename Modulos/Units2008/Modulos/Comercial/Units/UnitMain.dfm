object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 450
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
    end
    object Informes1: TMenuItem
      Caption = 'Informes'
    end
  end
end
