object FrmExogena: TFrmExogena
  Left = 0
  Top = 0
  Width = 800
  Height = 570
  BorderIcons = [biSystemMenu]
  Caption = 'Formatos de la DIAN'
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
  object Label5: TLabel
    Left = 496
    Top = 33
    Width = 5
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 512
    Top = 5
    Width = 59
    Height = 13
    Caption = 'Consecutivo'
  end
  object xml: TWebBrowser
    Left = 7
    Top = 80
    Width = 785
    Height = 454
    TabOrder = 0
    ControlData = {
      4C00000022510000EC2E00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Agrid: TXStringGrid
    Left = 728
    Top = 22
    Width = 33
    Height = 43
    TabOrder = 1
    Visible = False
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
  object r: TRichEdit
    Left = 7
    Top = 81
    Width = 785
    Height = 454
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
    Visible = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 337
    Height = 79
    TabOrder = 3
    object Label2: TLabel
      Left = 9
      Top = 6
      Width = 97
      Height = 13
      Caption = 'Archivo de Excel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 10
      Top = 31
      Width = 80
      Height = 13
      Caption = 'Hoja de Excel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 10
      Top = 58
      Width = 80
      Height = 13
      Caption = 'Xml Generado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CBhoja: TComboBox
      Left = 108
      Top = 29
      Width = 193
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
    end
    object EDlibro: TEdit
      Left = 108
      Top = 3
      Width = 192
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object Button1: TButton
      Left = 302
      Top = 1
      Width = 33
      Height = 25
      Caption = '...'
      TabOrder = 2
      OnClick = Button1Click
    end
    object BitBtn1: TBitBtn
      Left = 302
      Top = 27
      Width = 33
      Height = 25
      Caption = '...'
      Enabled = False
      TabOrder = 3
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 302
      Top = 53
      Width = 33
      Height = 25
      Caption = '...'
      TabOrder = 4
      OnClick = BitBtn2Click
    end
    object CBarchivos: TComboBox
      Left = 108
      Top = 55
      Width = 193
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
    end
  end
  object Panel2: TPanel
    Left = 336
    Top = 0
    Width = 153
    Height = 79
    TabOrder = 4
    object Label4: TLabel
      Left = 8
      Top = 51
      Width = 78
      Height = 13
      Caption = 'No. Registros'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object CHinsercion: TCheckBox
      Left = 3
      Top = 1
      Width = 137
      Height = 17
      Alignment = taLeftJustify
      BiDiMode = bdRightToLeftNoAlign
      Caption = 'Inserci'#243'n/Remplazo'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      State = cbChecked
      TabOrder = 0
    end
    object jVNumero: TJvIntegerEdit
      Left = 110
      Top = 48
      Width = 34
      Height = 21
      Alignment = taRightJustify
      ReadOnly = False
      TabOrder = 1
      Value = 5000
      MaxValue = 0
      MinValue = 0
      HasMaxValue = False
      HasMinValue = False
    end
    object Ch: TCheckBox
      Left = 4
      Top = 21
      Width = 136
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Xml/Texto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = ChClick
    end
  end
  object Button2: TButton
    Left = 496
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Nuevo'
    TabOrder = 5
    OnClick = Button2Click
  end
  object jvConsecutivo: TJvIntegerEdit
    Left = 576
    Top = 2
    Width = 57
    Height = 21
    Alignment = taRightJustify
    ReadOnly = False
    TabOrder = 6
    Value = 0
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
    Left = 752
    Top = 40
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
  object Op: TOpenDialog
    FileName = 'C:\listo.xml'
    Filter = 'Archivos de Exel|*.xls'
    InitialDir = 'c:\'
    Title = 'Abrir Archivos de la DIAN'
    Left = 744
    Top = 32
  end
end
