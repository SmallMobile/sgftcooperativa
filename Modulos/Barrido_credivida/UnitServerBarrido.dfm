object FrmServerConsultas: TFrmServerConsultas
  Left = 300
  Top = 291
  Width = 369
  Height = 211
  AutoSize = True
  BorderIcons = []
  Caption = 'Servidor Barrido Credividas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
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
    Animated = True
    Icon.Data = {
      0000010002002020100000000000E80200002600000010101000000000002801
      00000E0300002800000020000000400000000100040000000000800200000000
      0000000000000000000000000000000000000000800000800000008080008000
      0000800080008080000080808000C0C0C0000000FF0000FF000000FFFF00FF00
      0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000300000000000000000000000000000000
      30000000000000000000000000000000B3000000000000000000000000000000
      0B3000000000000000000000000000000BB30000000000000000000000000000
      00BB300000000000000000000000000000BBB300000000000000000000000000
      000BBB30000000000000000000000000000BBBB3000000000000000000000000
      0000BBBB3000000000000000000000000000BBBBB30000000000000000000000
      00000BBBBB300000000000000000000000000BBBBBB300000000000000000000
      000BBBBBBBBB300000000000000000000000BBBBBB3333000000000000000000
      0000BBBBBB300000000000000000000000000BBBBBB300000000000000000000
      00000BBBBBBB30000000000000000000000000BBBBBBB3000000000000000000
      000000BBBBBBBB3000000000000000000000000BBBBBBBB30000000000000000
      0000000BBBBBBBBB300000000000000000000000BBBBBBBBB300000000000000
      00000000BBBBBBBBBB30000000000000000000000BBBBBBBBBB3000000000000
      000000000BBBBBBBBBBB3000000000000000000000BBBBBBBBBBB30000000000
      0000000000BBBBBBBBBBBB300000000000000000000BBBBBBBBBBBB300000000
      0000000000000000000000000000FFFFFFFFCFFFFFFFC7FFFFFFE3FFFFFFE1FF
      FFFFF0FFFFFFF07FFFFFF83FFFFFF81FFFFFFC0FFFFFFC07FFFFFE03FFFFFE01
      FFFFFF00FFFFFC007FFFFC003FFFFE001FFFFE000FFFFF007FFFFF003FFFFF80
      1FFFFF800FFFFFC007FFFFC003FFFFE001FFFFE000FFFFF0007FFFF0003FFFF8
      001FFFF8000FFFFC0007FFFC0003280000001000000020000000010004000000
      0000C00000000000000000000000000000000000000000000000000080000080
      00000080800080000000800080008080000080808000C0C0C0000000FF0000FF
      000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0000000000000000000000
      00000000000000300000000000000003000000000000000B3000000000000000
      B300000000000000BB30000000000000BBB3000000000000BBB0000000000000
      0BB30000000000000BBB30000000000000BBB3000000000000BBBB3000000000
      000BBBB300000000000BBBBB30000000000000000000BFFF00009FFF00008FFF
      0000C7FF0000C3FF0000E1FF0000C0FF0000E07F0000E03F0000F07F0000F03F
      0000F81F0000F80F0000FC070000FC030000FE010000}
    IconIndex = -1
    Hint = 'Servidor Credividas'
    PopupMenu = PopupMenu1
    Delay = 0
    Snap = True
    Visibility = [tvMinimizeClick, tvMinimizeDbClick]
    OnBalloonHide = JvTrayIcon1BalloonHide
    Left = 72
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    MenuAnimation = [maTopToBottom]
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
    Mode = cmRead
    Left = 32
    Top = 88
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'update equivida set equivida.eliminado = false')
    Left = 72
    Top = 88
  end
  object CDbeneficiarios: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'nombre'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'porciento'
        DataType = ftCurrency
      end
      item
        Name = 'parentesco'
        DataType = ftInteger
      end
      item
        Name = 'id_persona'
        DataType = ftString
        Size = 15
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 288
    Top = 40
    Data = {
      8D0000009619E0BD0100000018000000040000000000030000008D00066E6F6D
      627265020049000000010005574944544802000200FF0009706F726369656E74
      6F080004000000010007535542545950450200490006004D6F6E6579000A7061
      72656E746573636F04000100000000000A69645F706572736F6E610100490000
      000100055749445448020002000F000000}
    object CDbeneficiariosnombre: TStringField
      FieldName = 'nombre'
      Size = 255
    end
    object CDbeneficiariosporciento: TCurrencyField
      FieldName = 'porciento'
    end
    object CDbeneficiariosparentesco: TIntegerField
      FieldName = 'parentesco'
    end
    object CDbeneficiariosid_persona: TStringField
      FieldName = 'id_persona'
      Size = 15
    end
  end
  object DBcredivida: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'nombre'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'id_persona'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'direccion'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'telefono'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'ciudad'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'ciudad_nacimiento'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'id_identificacion'
        DataType = ftSmallint
      end
      item
        Name = 'fecha_nacimiento'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'certificado'
        DataType = ftString
        Size = 7
      end
      item
        Name = 'dg'
        DataType = ftInteger
      end
      item
        Name = 'cuenta'
        DataType = ftInteger
      end
      item
        Name = 'fecha'
        DataType = ftDate
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 136
    Data = {
      570100009619E0BD01000000180000000C0000000000030000005701066E6F6D
      627265010049000000010005574944544802000200FA000A69645F706572736F
      6E610100490000000100055749445448020002000F0009646972656363696F6E
      01004900000001000557494454480200020096000874656C65666F6E6F010049
      0000000100055749445448020002000F00066369756461640100490000000100
      055749445448020002003200116369756461645F6E6163696D69656E746F0100
      4900000001000557494454480200020032001169645F6964656E746966696361
      63696F6E02000100000000001066656368615F6E6163696D69656E746F010049
      0000000100055749445448020002000A000B636572746966696361646F010049
      0000000100055749445448020002000700026467040001000000000006637565
      6E7461040001000000000005666563686104000600000000000000}
    object DBcredividanombre: TStringField
      FieldName = 'nombre'
      Size = 250
    end
    object DBcredividaid_persona: TStringField
      FieldName = 'id_persona'
      Size = 15
    end
    object DBcredividadireccion: TStringField
      FieldName = 'direccion'
      Size = 150
    end
    object DBcredividatelefono: TStringField
      FieldName = 'telefono'
      Size = 15
    end
    object DBcredividaciudad: TStringField
      FieldName = 'ciudad'
      Size = 50
    end
    object DBcredividaciudad_nacimiento: TStringField
      FieldName = 'ciudad_nacimiento'
      Size = 50
    end
    object DBcredividaid_identificacion: TSmallintField
      FieldName = 'id_identificacion'
    end
    object DBcredividafecha_nacimiento: TStringField
      FieldName = 'fecha_nacimiento'
      Size = 10
    end
    object DBcredividacertificado: TStringField
      FieldName = 'certificado'
      Size = 7
    end
    object DBcredividadg: TIntegerField
      FieldName = 'dg'
    end
    object DBcredividacuenta: TIntegerField
      FieldName = 'cuenta'
    end
    object DBcredividafecha: TDateField
      FieldName = 'fecha'
    end
  end
  object Timer1: TTimer
    Enabled = False
    Left = 112
    Top = 8
  end
end
