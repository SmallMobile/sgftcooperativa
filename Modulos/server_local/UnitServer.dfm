object FrmServer: TFrmServer
  Left = 124
  Top = 104
  Width = 369
  Height = 211
  AutoSize = True
  BorderIcons = []
  Caption = 'Server Equivida'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 361
    Height = 89
    ReadOnly = True
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 0
    Top = 88
    Width = 361
    Height = 89
    ReadOnly = True
    TabOrder = 1
  end
  object Button1: TButton
    Left = 184
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    Visible = False
    OnClick = Button1Click
  end
  object IdTCPServer1: TIdTCPServer
    Active = True
    Bindings = <>
    DefaultPort = 4001
    OnExecute = IdTCPServer1Execute
    TerminateWaitTime = 10000
    ThreadMgr = IdThread
    Left = 8
    Top = 8
  end
  object IdThread: TIdThreadMgrDefault
    Left = 40
    Top = 8
  end
  object JvTrayIcon1: TJvTrayIcon
    Active = True
    Animated = True
    Icon.Data = {
      0000010001002020100000000000E80200001600000028000000200000004000
      0000010004000000000080020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF22222FFFFFFFFFFFFFFFFFFF
      FFFFFF222222222FFFFFFFFFFFFFFFFFFFFF222222222222FFFFFFFFFFFFFFFF
      FFF22222222222222FFFFFFFFFFFFFFFFFF222222222222222FFFFFFFFFFFFFF
      FF22222222222222222FFFFFFFFFFFFFFFF222222222222222FFFFFFFFFFFFFF
      FFFFF22222222222FFFFFFFFFFFFFFFFFFFFFF222222222FFFFFFFFFFFFFFFFF
      FFFFFF22222222FFFFFFFFFFFFFFFFFFFFFFFFF222222FFFFFFFFFFFFFFFFFFF
      22FFFFFF22222FFFFFF2FFFFFFFFFFFF222FFFFF22222FFFFF22FFFFFFFFFFFF
      2222FFFF2222FFFF2222FFFFFFFFFFFF2222FFFF2222FFFF2222FFFFFFFFFFFF
      222222FF2222FFF22222FFFFFFFFFFFF222222FF2222FF222222FFFFFFFFFFFF
      2222222FF22FFF222222FFFFFFFFFFFF2222222FF22FF2222222FFFFFFFFFFFF
      F2222222F22FF2222222FFFFFFFFFFFFF2222222F22FF2222222FFFFFFFFFFFF
      F2222222F22FF222222FFFFFFFFFFFFFF2222222F22F2222222FFFFFFFFFFFFF
      FF222222F22F222222FFFFFFFFFFFFFFFFF22222F22F222222FFFFFFFFFFFFFF
      FFF22222F22F22222FFFFFFFFFFFFFFFFFFF2222F22F2222FFFFFFFFFFFFFFFF
      FFFFF222F22F222FFFFFFFFFFFFFFFFFFFFFFF22F22F22FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    IconIndex = -1
    Hint = 'Servidor Credivida'
    PopupMenu = PopupMenu1
    Delay = 0
    Visibility = [tvRestoreClick, tvMinimizeClick]
    OnBalloonHide = JvTrayIcon1BalloonHide
    Left = 72
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 232
    Top = 64
    object CerrarEquivida1: TMenuItem
      Caption = 'Cerrar Equivida'
      OnClick = CerrarEquivida1Click
    end
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=base'
    LoginPrompt = False
    Left = 32
    Top = 88
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select certificado,fecha_venc from equivida')
    Left = 72
    Top = 88
  end
end
