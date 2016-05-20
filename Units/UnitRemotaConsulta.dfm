object FrmRemotaConsulta: TFrmRemotaConsulta
  Left = 414
  Top = 191
  Width = 409
  Height = 298
  AutoSize = True
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta Remota Desde :'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 401
    Height = 57
    Caption = '&Busqueda por Numero de Documento'
    TabOrder = 0
    object Label1: TLabel
      Left = 10
      Top = 16
      Width = 102
      Height = 13
      Caption = 'Tipo de Identificaci'#243'n'
    end
    object Label2: TLabel
      Left = 210
      Top = 16
      Width = 110
      Height = 13
      Caption = 'N'#250'mero de Documento'
    end
    object DBtipo: TDBLookupComboBox
      Left = 9
      Top = 32
      Width = 224
      Height = 21
      KeyField = 'ID_IDENTIFICACION'
      ListField = 'DESCRIPCION_IDENTIFICACION'
      ListSource = DSagencia
      TabOrder = 0
      OnKeyPress = DBtipoKeyPress
    end
    object JVnumero: TJvEdit
      Left = 249
      Top = 32
      Width = 145
      Height = 21
      Alignment = taRightJustify
      GroupIndex = -1
      MaxPixel.Font.Charset = DEFAULT_CHARSET
      MaxPixel.Font.Color = clWindowText
      MaxPixel.Font.Height = -11
      MaxPixel.Font.Name = 'MS Sans Serif'
      MaxPixel.Font.Style = []
      Modified = False
      SelStart = 0
      SelLength = 0
      PasswordChar = #0
      ReadOnly = False
      TabOrder = 1
      OnExit = JVnumeroExit
      OnKeyPress = JVnumeroKeyPress
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 55
    Width = 401
    Height = 59
    Caption = 'Busqueda Por &Nombres y Apellidos'
    TabOrder = 1
    object Label3: TLabel
      Left = 9
      Top = 14
      Width = 69
      Height = 13
      Caption = 'Primer Apellido'
    end
    object Label4: TLabel
      Left = 142
      Top = 14
      Width = 83
      Height = 13
      Caption = 'Segundo Apellido'
    end
    object Label5: TLabel
      Left = 273
      Top = 14
      Width = 42
      Height = 13
      Caption = 'Nombres'
    end
    object PApellido: TEdit
      Left = 10
      Top = 28
      Width = 128
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnKeyPress = PApellidoKeyPress
    end
    object SApellido: TEdit
      Left = 142
      Top = 28
      Width = 126
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      OnKeyPress = SApellidoKeyPress
    end
    object Nombres: TEdit
      Left = 272
      Top = 28
      Width = 121
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 2
      OnExit = NombresExit
      OnKeyPress = NombresKeyPress
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 105
    Width = 401
    Height = 126
    Caption = 'Resultado de la Busqueda'
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 9
      Top = 15
      Width = 386
      Height = 107
      DataSource = DSrespuesta
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = DBGrid1CellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'descripcion'
          Title.Caption = 'DESCRIPCION'
          Width = 229
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tp'
          Title.Caption = 'TP'
          Width = 20
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ag'
          Title.Caption = 'AG'
          Width = 20
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cuenta'
          Title.Caption = 'CUENTA'
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 231
    Width = 401
    Height = 33
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 18
      Top = 5
      Width = 129
      Height = 25
      Caption = '&Limpiar Campos'
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        080000000000000100000E0F00000E0F00000001000000010000FF00FF00B584
        8400B5948C00C6A59C00D6BDB500E7C6B500E7CECE0000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000020101010101010200000000000000000106060606
        0606010100000000000000010606060606060103010000000000000204040404
        0404010303010000000000000205050505050501030301000000000000020505
        0505050501030301000000000000020505050505050103030100000000000002
        0505050505050103010000000000000002050505050505010100000000000000
        0002050505050505010000000000000000000201010101010200000000000000
        0000000000000000000000000000000000000000000000000000}
    end
    object BitBtn2: TBitBtn
      Left = 248
      Top = 5
      Width = 137
      Height = 25
      Caption = '&Salir del Formulario'
      ModalResult = 1
      TabOrder = 1
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000220B0000220B00000001000000010000006400004242
        42008C6363009A666600B9666600BB686800B0717200C3686900C66A6B00C76A
        6D00CF6C6E00D2686900D16D6E00CC6E7100C0797A00D2707200D4707100D572
        7300D0727500D3747600D9757600D8767700E37D7E000080000000960000DC7F
        8000FF00FF00D7868700DA888800D8888A00DA888A00DF898A00E6808100E085
        8500E9818200EE868700E3888900E78C8D00F0878800F18B8C00F28B8C00F18D
        8E00F48C8D00F48E8F00EB8F9000EC969700E49A9800F3919200F7909100F791
        9200F2939400F9909200F9949500FA949500F9969700F0999A00FC999A00FF9D
        9E00F7B58400F5A7A500FACCAA00FBD6BB00FADCDC00FFFFFF00000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000000000001A1A1A1A1A1A
        1A02011A1A1A1A1A1A1A1A1A1A1A02030405011A1A1A1A1A1A1A1A1A0203080B
        0B07010303030303031A1A1A030C0C0C0A09010E1F323B3B031A1A1A030C0C10
        0F0D01181818183B031A1A1A03111114151201181818183B031A1A1A03161616
        201301181717173B031A1A1A0326222D3E1D01171700003B031A1A1A03262337
        3F1E013C3A3A3A3B031A1A1A03272B282A19013C3D3D3D3B031A1A1A03273031
        2921013C3D3D3D3B031A1A1A032734352F24013C3D3D3D3B031A1A1A03273338
        3625013C3D3D3D3B031A1A1A03032E33392C013C3D3D3D3B031A1A1A1A1A0306
        1B1C010303030303031A1A1A1A1A1A1A0303011A1A1A1A1A1A1A}
    end
  end
  object CDrespuesta: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cuenta'
        DataType = ftInteger
      end
      item
        Name = 'descripcion'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'tp'
        DataType = ftInteger
      end
      item
        Name = 'ag'
        DataType = ftInteger
      end
      item
        Name = 'saldo'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 56
    Data = {
      810000009619E0BD010000001800000005000000000003000000810006637565
      6E746104000100000000000B6465736372697063696F6E010049000000010005
      5749445448020002003200027470040001000000000002616704000100000000
      000573616C646F080004000000010007535542545950450200490006004D6F6E
      6579000000}
    object CDrespuestacuenta: TIntegerField
      FieldName = 'cuenta'
    end
    object CDrespuestadescripcion: TStringField
      FieldName = 'descripcion'
      Size = 50
    end
    object CDrespuestatp: TIntegerField
      FieldName = 'tp'
    end
    object CDrespuestaag: TIntegerField
      FieldName = 'ag'
    end
    object CDrespuestasaldo: TCurrencyField
      FieldName = 'saldo'
    end
  end
  object DSrespuesta: TDataSource
    DataSet = CDrespuesta
    Left = 24
  end
  object IBagencia: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "gen$tiposidentificacion"')
    Left = 104
  end
  object DSagencia: TDataSource
    DataSet = IBagencia
    Left = 136
  end
  object IdTCPClient1: TIdTCPClient
    OnWorkEnd = IdTCPClient1WorkEnd
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 176
    Top = 8
  end
  object IdFTP1: TIdFTP
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 160
    Top = 32
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 208
    Top = 48
  end
end
