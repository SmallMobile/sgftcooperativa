object Form1: TForm1
  Left = 210
  Top = 117
  Width = 696
  Height = 480
  Caption = 'M'#243'dulo Bancoldex - '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 160
    Top = 160
    object File1: TMenuItem
      Caption = '&Generales'
      object New1: TMenuItem
        Caption = '&Cambiar Contrase'#241'a'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object PrintSetup1: TMenuItem
        Caption = 'C&onfigurar Impresora'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = '&Salir de Crediservir'
      end
    end
    object Edit1: TMenuItem
      Caption = '&Procesos'
      object Undo1: TMenuItem
        Caption = '&Agregar Recursos'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Repeatcommand1: TMenuItem
        Caption = 'G&enerar Plano'
      end
    end
    object Window1: TMenuItem
      Caption = '&Informes'
      object NewWindow1: TMenuItem
        Caption = '&Reporte Solicitudes'
      end
      object ile1: TMenuItem
        Caption = 'R&eporte Cr'#233'ditos'
      end
    end
  end
end
