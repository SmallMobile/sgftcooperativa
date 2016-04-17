object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'M'#243'dulo Riesgo de Liquidez'
  ClientHeight = 194
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 144
    Top = 64
    object GenerarArchivoExcel1: TMenuItem
      Caption = 'Generar Archivo Excel'
      OnClick = GenerarArchivoExcel1Click
    end
    object Salir1: TMenuItem
      Caption = 'Salir'
      OnClick = Salir1Click
    end
  end
end
