object Form1: TForm1
  Left = 60
  Top = 169
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
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 29
    Width = 22
    Height = 13
    Caption = 'Hoja'
  end
  object Label2: TLabel
    Left = 5
    Top = 6
    Width = 23
    Height = 13
    Caption = 'Libro'
  end
  object Label3: TLabel
    Left = 10
    Top = 64
    Width = 82
    Height = 13
    Caption = 'Resultado Xml'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 155
    Top = 1
    Width = 33
    Height = 25
    Caption = '...'
    TabOrder = 0
    OnClick = Button1Click
  end
  object EDlibro: TEdit
    Left = 32
    Top = 3
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'c:\exogena\exogena.xls'
  end
  object Button2: TButton
    Left = 156
    Top = 26
    Width = 33
    Height = 23
    Caption = '...'
    Enabled = False
    TabOrder = 2
    OnClick = Button2Click
  end
  object CBhoja: TComboBox
    Left = 32
    Top = 27
    Width = 122
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
  end
  object BitBtn1: TBitBtn
    Left = 192
    Top = 8
    Width = 169
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 4
    OnClick = BitBtn1Click
  end
  object xml: TWebBrowser
    Left = 8
    Top = 80
    Width = 785
    Height = 457
    TabOrder = 5
    ControlData = {
      4C000000225100003B2F00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Agrid: TXStringGrid
    Left = 512
    Top = 14
    Width = 33
    Height = 43
    TabOrder = 6
    FixedLineColor = clBlack
    Columns = <
      item
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
      end
      item
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
      end
      item
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
      end
      item
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
      end
      item
        HeaderFont.Charset = DEFAULT_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -11
        HeaderFont.Name = 'MS Sans Serif'
        HeaderFont.Style = []
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
      end>
    MultiLine = False
    ImmediateEditMode = False
  end
  object CHinsercion: TCheckBox
    Left = 200
    Top = 40
    Width = 65
    Height = 17
    Alignment = taLeftJustify
    BiDiMode = bdRightToLeftNoAlign
    Caption = 'Inserci'#243'n'
    Checked = True
    ParentBiDiMode = False
    State = cbChecked
    TabOrder = 7
  end
  object CBarchivos: TComboBox
    Left = 95
    Top = 59
    Width = 368
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 8
  end
  object BitBtn2: TBitBtn
    Left = 464
    Top = 59
    Width = 45
    Height = 21
    Caption = 'Ver'
    TabOrder = 9
    OnClick = BitBtn2Click
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      08000000000000010000D30E0000D30E00000001000000010000008C00000094
      0000009C000000A5000000940800009C100000AD100000AD180000AD210000B5
      210000BD210018B5290000C62900319C310000CE310029AD390031B5420018C6
      420000D6420052A54A0029AD4A0029CE5A006BB5630000FF63008CBD7B00A5C6
      94005AE7A500FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF001B1B1B1B1B13
      04161B1B1B1B1B1B1B1B1B1B1B1B1B0B0A01181B1B1B1B1B1B1B1B1B1B1B160A
      0C030D1B1B1B1B1B1B1B1B1B1B1B050E0C0601191B1B1B1B1B1B1B1B1B130E0C
      170E02001B1B1B1B1B1B1B1B1B0B1517170A0C01181B1B1B1B1B1B1B1B111717
      13130C030D1B1B1B1B1B1B1B1B1B08081B1B070C01191B1B1B1B1B1B1B1B1B1B
      1B1B100C02001B1B1B1B1B1B1B1B1B1B1B1B1B090C01181B1B1B1B1B1B1B1B1B
      1B1B1B130C0F101B1B1B1B1B1B1B1B1B1B1B1B1B141A0F181B1B1B1B1B1B1B1B
      1B1B1B1B1012181B1B1B1B1B1B1B1B1B1B1B1B1B1B191B1B1B1B1B1B1B1B1B1B
      1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B1B}
  end
  object jVNumero: TJvIntegerEdit
    Left = 284
    Top = 37
    Width = 57
    Height = 21
    Alignment = taRightJustify
    ReadOnly = False
    TabOrder = 10
    Value = 5000
    MaxValue = 0
    MinValue = 0
    HasMaxValue = False
    HasMinValue = False
  end
  object jv: TJvOpenDialog
    Height = 0
    Width = 0
    Left = 64
    Top = 280
  end
  object CD1019: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'tdocp'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'nidp'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'tdoc'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'nidsec'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'apl1'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'apl2'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'nom1'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'nom2'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'raz'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'dv'
        DataType = ftString
        Size = 2
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 400
    Top = 24
    Data = {
      140100009619E0BD01000000180000000A00000000000300000014010574646F
      63700100490000000100055749445448020002000200046E6964700100490000
      0001000557494454480200020014000474646F63010049000000010005574944
      5448020002000200066E69647365630100490000000100055749445448020002
      0014000461706C310100490000000100055749445448020002003C000461706C
      320100490000000100055749445448020002003C00046E6F6D31010049000000
      0100055749445448020002003C00046E6F6D3201004900000001000557494454
      48020002003C000372617A020049000000010005574944544802000200FF0002
      647601004900000001000557494454480200020002000000}
    object CD1019tdocp: TStringField
      FieldName = 'tdocp'
      Size = 2
    end
    object CD1019nidp: TStringField
      FieldName = 'nidp'
    end
    object CD1019tdoc: TStringField
      FieldName = 'tdoc'
      Size = 2
    end
    object CD1019nidsec: TStringField
      FieldName = 'nidsec'
    end
    object CD1019apl1: TStringField
      FieldName = 'apl1'
      Size = 60
    end
    object CD1019apl2: TStringField
      FieldName = 'apl2'
      Size = 60
    end
    object CD1019nom1: TStringField
      FieldName = 'nom1'
      Size = 60
    end
    object CD1019nom2: TStringField
      FieldName = 'nom2'
      Size = 60
    end
    object CD1019raz: TStringField
      FieldName = 'raz'
      Size = 255
    end
    object CD1019dv: TStringField
      FieldName = 'dv'
      Size = 2
    end
  end
end
