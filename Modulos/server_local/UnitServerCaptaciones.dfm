object FrmServerConsultas: TFrmServerConsultas
  Left = 96
  Top = 143
  Width = 373
  Height = 214
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
    DefaultPort = 4500
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
      0000010003002020080000000000E80200003600000020200200000000003001
      00001E0300002020100000000000E80200004E04000028000000200000004000
      0000010004000000000080020000000000000000000000000000000000000000
      00000000C00000C0000000C0C000C0000000C000C000C0C00000C0C0C0008080
      80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      0000000000000000000000000000000000000000FFFFFFFF0000000000000000
      00000FFFFFF99FFFFFF0000000000000000FFFFFF999999FFFFFF00000000000
      00FFFFFFF999999FFFFFFF00000000000FFFFFFF99999999FFFFFFF000000000
      FFFFFFFF99999999FFFFFFFF0000000FFFFFFFFFF999999FFFFFFFFFF000000F
      FFFFFFFFF999999FFFFFFFFFF00000FFFFFFFFFFFFF99FFFFFFFFFFFFF0000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFF999999FFFFFFFFFFF000FFF
      FFFFFFFFF999999FFFFFFFFFFFF00FFFFFFFFFFFF999999FFFFFFFFFFFF00FFF
      FFFFFFFFFF999999FFFFFFFFFFF00FFFFFFFFFFFFF999999FFFFFFFFFFF00FFF
      FFFFFFFFFFF999999FFFFFFFFFF00FFFFFFFFFFFFFF999999FFFFFFFFFF00FFF
      FFFFFFFFFFFF999999FFFFFFFFF00FFFFFFFFFFFFFFF999999FFFFFFFFF000FF
      FFFFF999999FF999999FFFFFFF0000FFFFFFF999999FF999999FFFFFFF0000FF
      FFFFF999999FF999999FFFFFFF00000FFFFFF99999999999999FFFFFF000000F
      FFFFF99999999999999FFFFFF0000000FFFFFF999999999999FFFFFF00000000
      0FFFFF999999999999FFFFF00000000000FFFFF9999999999FFFFF0000000000
      000FFFFFF999999FFFFFF0000000000000000FFFFFFFFFFFFFF0000000000000
      00000000FFFFFFFF00000000000000000000000000000000000000000000FFF0
      0FFFFF8001FFFE00007FFC00003FF800001FF000000FE0000007C0000003C000
      0003800000018000000180000001000000000000000000000000000000000000
      0000000000000000000000000000800000018000000180000001C0000003C000
      0003E0000007F000000FF800001FFC00003FFE00007FFF8001FFFFF00FFF2800
      0000200000004000000001000100000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000000FF000007E7E0001F81F8003F8
      1FC007F00FE00FF00FF01FF81FF81FF81FF83FFE7FFC3FFFFFFC3FF81FFC7FF8
      1FFE7FF81FFE7FFC0FFE7FFC0FFE7FFE07FE7FFE07FE7FFF03FE7FFF03FE3F81
      81FC3F8181FC3F8181FC1F8001F81F8001F80FC003F007C003E003E007C001F8
      1F80007FFE00000FF00000000000FFF00FFFFF8001FFFE00007FFC00003FF800
      001FF000000FE0000007C0000003C00000038000000180000001800000010000
      0000000000000000000000000000000000000000000000000000000000008000
      00018000000180000001C0000003C0000003E0000007F000000FF800001FFC00
      003FFE00007FFF8001FFFFF00FFF280000002000000040000000010004000000
      0000000000000000000000000000000000000000000000000000000080000080
      00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
      000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
      00000000000000000000000022222222000000000000000000000222222FF222
      2220000000000000000222222FFFFFF22222200000000000002222222FFFFFF2
      222222000000000002222222FFFFFFFF222222200000000022222222FFFFFFFF
      2222222200000002222222222FFFFFF22222222220000002222222222FFFFFF2
      222222222000002222222222222FF22222222222220000222222222222222222
      2222222222000022222222222FFFFFF22222222222000222222222222FFFFFF2
      2222222222200222222222222FFFFFF222222222222002222222222222FFFFFF
      22222222222002222222222222FFFFFF222222222220022222222222222FFFFF
      F22222222220022222222222222FFFFFF222222222200222222222222222FFFF
      FF22222222200222222222222222FFFFFF2222222220002222222FFFFFF22FFF
      FFF222222200002222222FFFFFF22FFFFFF222222200002222222FFFFFF22FFF
      FFF222222200000222222FFFFFFFFFFFFFF222222000000222222FFFFFFFFFFF
      FFF2222220000000222222FFFFFFFFFFFF22222200000000022222FFFFFFFFFF
      FF222220000000000022222FFFFFFFFFF222220000000000000222222FFFFFF2
      2222200000000000000002222222222222200000000000000000000022222222
      00000000000000000000000000000000000000000000FFF00FFFFF8001FFFE00
      007FFC00003FF800001FF000000FE0000007C0000003C0000003800000018000
      0001800000010000000000000000000000000000000000000000000000000000
      000000000000800000018000000180000001C0000003C0000003E0000007F000
      000FF800001FFC00003FFE00007FFF8001FFFFF00FFF}
    IconIndex = -1
    Hint = 'Servidor de Consultas Credividas'
    PopupMenu = PopupMenu1
    Delay = 0
    Visibility = [tvMinimizeClick]
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
  object JvTransparentForm1: TJvTransparentForm
    Active = False
    AutoSize = False
    Left = 376
    Top = 48
  end
end
