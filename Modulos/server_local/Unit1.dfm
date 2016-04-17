object Form1: TForm1
  Left = 222
  Top = 171
  Width = 544
  Height = 375
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 264
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 72
    Top = 96
    Width = 361
    Height = 89
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 72
    Top = 192
    Width = 361
    Height = 89
    TabOrder = 2
  end
  object Button2: TButton
    Left = 432
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
  end
  object IdTCPServer1: TIdTCPServer
    Active = True
    Bindings = <>
    DefaultPort = 4001
    OnExecute = IdTCPServer1Execute
    ThreadMgr = IdThread
    Left = 88
    Top = 32
  end
  object IdThread: TIdThreadMgrDefault
    Left = 128
    Top = 32
  end
  object CDrespuesta: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'respuesta'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'tipo'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 200
    Top = 32
    Data = {
      450000009619E0BD010000001800000002000000000003000000450009726573
      7075657374610100490000000100055749445448020002001E00047469706F04
      000100000000000000}
    object CDrespuestarespuesta: TStringField
      FieldName = 'respuesta'
      Size = 30
    end
    object CDrespuestatipo: TIntegerField
      FieldName = 'tipo'
    end
  end
  object Scambio: TShellChangeNotifier
    NotifyFilters = [nfSizeChange]
    Root = 'C:\convenio\SALIDA'
    WatchSubTree = True
    Left = 368
    Top = 48
  end
  object ShellChangeNotifier1: TShellChangeNotifier
    NotifyFilters = [nfFileNameChange, nfDirNameChange]
    Root = 'C:\'
    WatchSubTree = True
    Left = 272
    Top = 40
  end
end
