object FrmDescaraAutomatica: TFrmDescaraAutomatica
  Left = 265
  Top = 144
  Width = 474
  Height = 363
  Caption = 'Tarjeta D'#233'bito'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btDescargArchivo: TButton
    Left = 353
    Top = 160
    Width = 40
    Height = 25
    Caption = 'DescargaArchivo'
    TabOrder = 0
    OnClick = btDescargArchivoClick
  end
  object Button1: TButton
    Left = 369
    Top = 152
    Width = 32
    Height = 25
    Caption = 'Descarga Manual'
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 1
    Top = 0
    Width = 329
    Height = 88
    TabOrder = 2
    object Label2: TLabel
      Left = 2
      Top = 3
      Width = 75
      Height = 13
      Caption = 'Archivo Externo'
    end
    object Label7: TLabel
      Left = 200
      Top = 3
      Width = 69
      Height = 13
      Caption = 'Fecha Archivo'
    end
    object Label8: TLabel
      Left = 2
      Top = 40
      Width = 45
      Height = 13
      Caption = 'Convenio'
    end
    object Label9: TLabel
      Left = 81
      Top = 40
      Width = 44
      Height = 13
      Caption = 'Operador'
    end
    object Label10: TLabel
      Left = 205
      Top = 40
      Width = 38
      Height = 13
      Caption = 'Formato'
    end
    object EdArchivoExterno: TJvFilenameEdit
      Left = 2
      Top = 18
      Width = 198
      Height = 21
      DefaultExt = '*.pgp'
      Filter = 'Archivos Enpacto(*.zip)|*.zip'
      ButtonFlat = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      NumGlyphs = 1
      ParentFont = False
      TabOrder = 0
      OnChange = EdArchivoExternoChange
    end
    object EdFecha: TJvEdit
      Left = 200
      Top = 16
      Width = 121
      Height = 21
      Alignment = taCenter
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 1
    end
    object EdConvenio: TJvEdit
      Left = 2
      Top = 54
      Width = 77
      Height = 21
      Alignment = taCenter
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 2
    end
    object EdOperador: TJvEdit
      Left = 81
      Top = 54
      Width = 122
      Height = 21
      Alignment = taCenter
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 3
    end
    object EdFormato: TJvEdit
      Left = 205
      Top = 53
      Width = 115
      Height = 21
      Alignment = taCenter
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 330
    Top = 0
    Width = 136
    Height = 189
    TabOrder = 3
    object bitProcesar: TBitBtn
      Left = 30
      Top = 42
      Width = 75
      Height = 25
      Caption = '&Procesar'
      Enabled = False
      TabOrder = 0
      OnClick = bitProcesarClick
    end
    object bitCancelar: TBitBtn
      Left = 30
      Top = 71
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = bitCancelarClick
    end
    object bitSalir: TBitBtn
      Left = 30
      Top = 99
      Width = 75
      Height = 25
      Caption = '&Salir'
      TabOrder = 2
      OnClick = bitSalirClick
    end
    object bitDescomprimir: TBitBtn
      Left = 31
      Top = 13
      Width = 75
      Height = 25
      Caption = '&Descomprimir'
      Enabled = False
      TabOrder = 3
      OnClick = bitDescomprimirClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 82
    Width = 330
    Height = 107
    Caption = 'Relaci'#243'n de Archivos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label3: TLabel
      Left = 7
      Top = 37
      Width = 71
      Height = 13
      Caption = 'Movimientos'
    end
    object Label4: TLabel
      Left = 7
      Top = 83
      Width = 53
      Height = 13
      Caption = 'Bloqueos'
    end
    object Label5: TLabel
      Left = 7
      Top = 59
      Width = 47
      Height = 13
      Caption = 'Tarjetas'
    end
    object Label6: TLabel
      Left = 7
      Top = 15
      Width = 69
      Height = 13
      Caption = 'Estadisticas'
    end
    object EdMov: TEdit
      Left = 79
      Top = 35
      Width = 220
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object EdBlq: TEdit
      Left = 79
      Top = 57
      Width = 220
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object EdTar: TEdit
      Left = 79
      Top = 81
      Width = 220
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
    object EdEst: TEdit
      Left = 79
      Top = 13
      Width = 220
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object Button2: TButton
      Left = 300
      Top = 13
      Width = 27
      Height = 21
      Caption = '...'
      TabOrder = 4
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 300
      Top = 36
      Width = 27
      Height = 21
      Caption = '...'
      TabOrder = 5
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 300
      Top = 58
      Width = 27
      Height = 21
      Caption = '...'
      TabOrder = 6
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 301
      Top = 81
      Width = 27
      Height = 21
      Caption = '...'
      TabOrder = 7
      OnClick = Button5Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 1
    Top = 186
    Width = 465
    Height = 143
    Caption = 'Cadenas Procesadas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    object mLineas: TMemo
      Left = 3
      Top = 15
      Width = 458
      Height = 122
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssHorizontal
      TabOrder = 0
    end
  end
  object Memotxt: TMemo
    Left = 385
    Top = 136
    Width = 32
    Height = 17
    Lines.Strings = (
      'Mem'
      'otxt')
    TabOrder = 6
    Visible = False
  end
  object Msg: TIdMessage
    BccList = <>
    CharSet = 'ISO8859_1'
    CCList = <>
    Recipients = <>
    ReplyTo = <>
    Left = 124
    Top = 402
  end
  object POP: TIdPOP3
    ASCIIFilter = True
    Host = '192.168.200.2'
    Password = 'tdebitocreo6'
    UserId = 'tdebito@crediservir.com'
    Left = 144
    Top = 412
  end
  object IdTCPClient1: TIdTCPClient
    Port = 0
    Left = 184
    Top = 408
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Archivo Encriptado (*.pgp)|*.pgp'
    Left = 564
    Top = 322
  end
  object UnZip: TAbUnZipper
    ExtractOptions = [eoCreateDirs, eoRestorePath]
    OnArchiveItemProgress = UnZipArchiveItemProgress
    Left = 660
    Top = 322
  end
  object CdSentencia: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID_AGENCIA'
        DataType = ftInteger
      end
      item
        Name = 'SENTENCIA'
        DataType = ftString
        Size = 400
      end
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 6
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 200
    Top = 400
    Data = {
      640000009619E0BD01000000180000000300000000000300000064000A49445F
      4147454E43494104000100000000000953454E54454E43494102004900000001
      00055749445448020002009001045449504F0100490000000100055749445448
      0200020006000000}
    object CdSentenciaID_AGENCIA: TIntegerField
      FieldName = 'ID_AGENCIA'
    end
    object CdSentenciaSENTENCIA: TStringField
      FieldName = 'SENTENCIA'
      Size = 400
    end
    object CdSentenciaTIPO: TStringField
      FieldName = 'TIPO'
      Size = 6
    end
  end
  object IdTCPClient2: TIdTCPClient
    Port = 0
    Left = 616
    Top = 320
  end
end
