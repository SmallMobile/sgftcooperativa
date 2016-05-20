object Salida: TSalida
  Left = 161
  Top = 96
  Width = 519
  Height = 454
  BorderIcons = [biSystemMenu]
  Caption = 'Salida'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = -4
    Width = 510
    Height = 49
    TabOrder = 2
    object Label1: TLabel
      Left = 14
      Top = 18
      Width = 56
      Height = 13
      Caption = 'Salida No'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 281
      Top = 18
      Width = 36
      Height = 13
      Caption = 'Fecha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object no_salida: TLabel
      Left = 88
      Top = 18
      Width = 5
      Height = 13
      Alignment = taCenter
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object fecha_salida: TDateTimePicker
      Left = 349
      Top = 14
      Width = 99
      Height = 21
      CalAlignment = dtaLeft
      Date = 37650.3339290741
      Time = 37650.3339290741
      DateFormat = dfShort
      DateMode = dmComboBox
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Kind = dtkDate
      ParseInput = False
      ParentFont = False
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 85
    Width = 511
    Height = 108
    Caption = 'Datos Empleado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 10
      Top = 20
      Width = 44
      Height = 13
      Caption = 'Nombre'
    end
    object dependencia: TLabel
      Left = 81
      Top = 46
      Width = 5
      Height = 13
    end
    object Apellido: TLabel
      Left = 85
      Top = 112
      Width = 8
      Height = 13
      Caption = '1'
      Visible = False
    end
    object nombre: TLabel
      Left = 84
      Top = 112
      Width = 8
      Height = 13
      Caption = '1'
      Visible = False
    end
    object Label6: TLabel
      Left = 12
      Top = 73
      Width = 47
      Height = 13
      Caption = 'Agencia'
    end
    object Label5: TLabel
      Left = 9
      Top = 46
      Width = 47
      Height = 13
      Caption = 'Secci'#243'n'
    end
    object Dbagencia: TDBLookupComboBox
      Left = 79
      Top = 71
      Width = 324
      Height = 21
      KeyField = 'cod_agencia'
      ListField = 'descripcion'
      ListSource = dataagen
      TabOrder = 1
      OnExit = DbagenciaExit
      OnKeyPress = DbagenciaKeyPress
    end
    object BitBtn1: TBitBtn
      Left = 407
      Top = 16
      Width = 25
      Height = 22
      Hint = 'Agregar Empleado'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TabStop = False
      OnClick = BitBtn1Click
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000030F0000030F000000010000000100000094000000C6
        0000319C42004A524A00429C4A0052525200527352005A5A5A00635A5A005AAD
        5A005AB55A004ABD5A005A63630063636300636B63006384630063636B006B63
        6B006B6B6B006B946B00736B7300737373007394730073737B007B737B007B7B
        7B008C847B00738C7B006B9C7B007B9C7B0084CE7B0073D67B007B8484008484
        84007B9484007B9C840073AD84008C848C008C8C8C0094948C008CA58C009494
        940084A594009C949C009C9C9C00A5A5A500ADADAD00B5B5AD00B5B5B500BDB5
        B500BDBDBD00C6BDBD00CEC6BD00C6C6C600D6D6D600FF00FF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00373737373737
        3737373737373737373737373737373737373737373737373737373737122C0D
        12212E32322D262937373737370D321212262E3536322D2E3737373737073212
        12212E3536322D2E37373737370D2E0D0712152A00242C263737373737072D0D
        0D212E011F002626373737373708331211212E011F002D2E37373737370C3212
        060F1D011F001D233737373737083010040000010B0000000237373737082D0E
        091E1E1E1F0101010937373737083312061B28011F00161D3737373737082F12
        0D202C011F002C2D373737373707290D071215011F0026263737373737032921
        27292922131C26193737373737371A1814171515151921373737}
    end
    object lista: TComboBox
      Left = 79
      Top = 17
      Width = 325
      Height = 21
      CharCase = ecUpperCase
      ItemHeight = 13
      TabOrder = 0
      OnExit = listaExit
    end
    object Nit_empleado: TEdit
      Left = 464
      Top = 39
      Width = 9
      Height = 21
      TabOrder = 3
      Visible = False
      OnExit = Nit_empleadoExit
      OnKeyPress = Nit_empleadoKeyPress
    end
    object listanit: TComboBox
      Left = 463
      Top = 44
      Width = 18
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Visible = False
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 192
    Width = 511
    Height = 188
    Caption = 'Relaci'#243'n Articulos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 16
      Top = 26
      Width = 481
      Height = 127
      DataSource = DataSource1
      Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      Columns = <
        item
          Expanded = False
          FieldName = 'cod_articulo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nombre'
          ReadOnly = True
          Title.Caption = 'Descripcion'
          Title.Font.Charset = BALTIC_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 198
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cod_barras'
          ReadOnly = True
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'cantidad_articulo'
          ReadOnly = True
          Title.Caption = 'Existencia'
          Width = 76
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nit_empleado'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'no_salida'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'fecha_entrega'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'cantidad'
          Width = 86
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'definicion'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'cod_agencia'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'precio_salida'
          ReadOnly = True
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'cod_dependencia'
          Visible = False
        end>
    end
    object Bcerrar: TBitBtn
      Left = 203
      Top = 158
      Width = 97
      Height = 25
      Hint = 'Eliminar Registro'
      Caption = '&Eliminar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BcerrarClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000E30E0000E30E00000001000000010000424242004A42
        4A0052424A004A4A4A004A524A00525252005A6352005A5A5A005A635A006363
        5A006B635A00525263005A5263005A5A6300635A63005A636300636363006B63
        63006B6B6300635A6B0063636B006B6B6B006B736B00636B7300736B73006B73
        73007373730084737300737B730073737B007B737B0084737B007B7B7B008C84
        7B00848484008C848C00848C8C008C8C8C008C948C00949494009CA594009C9C
        9C000021A500A5A5A500ADADAD00ADADB500B5B5B500BDBDBD006B84C600C6C6
        C600CECECE00D6D6D600E7DED600DEDEDE000029E700526BF700638CF7009494
        F700FF00FF009CB5FF009CBDFF00B5C6FF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003A3A3A3A3A3A
        3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A3A22291A
        101A2C2E2F2B22223A3A3A3A3A03352210202B2F33312C293A3A3A3A3A003322
        101A2B2E33312C293A3A3A3A3A03352210202B2E33312B273A3A3A3A3A032B1A
        071A2B2E2F2B22223A3A3A3A3A003322101A2B2E33312C293A3A3A3A3A003323
        14302A2A2A2A2A2A2A3A3A3A3A003523102A363636363636362A3A3A3A022B1A
        10302A2A2A2A2A2A2A3A3A3A3A023423111A2B2C32312B273A3A3A3A3A023423
        0916292C322F2B273A3A3A3A3A022B1A1316272C322F2B253A3A3A3A3A042D25
        282B2B2B2C2B25203A3A3A3A3A3A211E181D1A1A1A20223A3A3A}
    end
    object nombre1: TMemo
      Left = 192
      Top = -40
      Width = 393
      Height = 41
      TabStop = False
      BorderStyle = bsNone
      Color = clBtnFace
      TabOrder = 2
      Visible = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 383
    Width = 510
    Height = 37
    TabOrder = 3
    object BACEPTAR: TBitBtn
      Left = 29
      Top = 6
      Width = 97
      Height = 25
      Hint = 'Crear Registro'
      Caption = '&Crear'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BACEPTARClick
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
    object BCANCELAR: TBitBtn
      Left = 209
      Top = 6
      Width = 97
      Height = 25
      Hint = 'Cancelar'
      Caption = 'C&ancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = BCANCELARClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000220B0000220B000000010000000100000031DE000031
        E7000031EF000031F700FF00FF000031FF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00040404040404
        0404040404040404000004000004040404040404040404000004040000000404
        0404040404040000040404000000000404040404040000040404040402000000
        0404040400000404040404040404000000040000000404040404040404040400
        0101010004040404040404040404040401010204040404040404040404040400
        0201020304040404040404040404030201040403030404040404040404050203
        0404040405030404040404040303050404040404040303040404040303030404
        0404040404040403040403030304040404040404040404040404030304040404
        0404040404040404040404040404040404040404040404040404}
    end
    object BitBtn2: TBitBtn
      Left = 388
      Top = 6
      Width = 97
      Height = 25
      Hint = 'Salir'
      Caption = 'C&errar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BitBtn2Click
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
  object GroupBox4: TGroupBox
    Left = 0
    Top = 45
    Width = 511
    Height = 40
    Caption = 'Tipo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object rsec: TRadioButton
      Left = 324
      Top = 13
      Width = 105
      Height = 17
      Caption = 'Seccion'
      TabOrder = 0
    end
    object remp: TRadioButton
      Left = 55
      Top = 13
      Width = 113
      Height = 17
      Caption = 'Empleado'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object dataagen: TDataSource
    DataSet = ibagencia
    Left = 408
    Top = 144
  end
  object ibagencia: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      'select * from  "Inv$Agencia"')
    Left = 408
    Top = 144
  end
  object DataSource1: TDataSource
    DataSet = IBsalida
    Left = 440
    Top = 144
  end
  object IBsalida: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    ForcedRefresh = True
    OnPostError = IBsalidaPostError
    DeleteSQL.Strings = (
      'delete from "inv$salida"'
      'where'
      '  "inv$salida"."cod_articulo" = :"OLD_cod_articulo" and'
      '  "inv$salida"."nit_empleado" = :"OLD_nit_empleado" and'
      '  "inv$salida"."no_salida" = :"OLD_no_salida" and'
      '  "inv$salida"."fecha_entrega" = :"OLD_fecha_entrega" and'
      '  "inv$salida"."cantidad" = :"OLD_cantidad" and'
      '  "inv$salida"."cod_agencia" = :"OLD_cod_agencia" and'
      '   "inv$salida"."definicion" = :"OLD_definicion" and'
      '   "inv$salida"."definicion" = :"OLD_definicion" and'
      
        '    "inv$salida"."cantidad_articulo" = :"OLD_cantidad_articulo" ' +
        'and'
      '    "inv$salida"."precio_salida" = :"OLD_precio_salida" and'
      '     "inv$salida"."cod_dependencia" =:"OLD_cod_dependencia"')
    InsertSQL.Strings = (
      'insert into "inv$salida"'
      
        '  ("inv$salida"."cod_articulo", "inv$salida"."nit_empleado", "in' +
        'v$salida"."no_salida", '
      
        '   "inv$salida"."fecha_entrega", "inv$salida"."cantidad", "inv$s' +
        'alida"."cod_agencia",'
      
        ' "inv$salida"."definicion",  "inv$salida"."cantidad_articulo","p' +
        'recio_salida", '
      '"inv$salida"."cod_dependencia")'
      'values'
      
        '  (:"cod_articulo", :"nit_empleado", :"no_salida", :"fecha_entre' +
        'ga", :"cantidad", '
      
        ':"cod_agencia",:"definicion",:"cantidad_articulo",:"precio_salid' +
        'a",'
      ':"cod_dependencia")'
      '')
    SelectSQL.Strings = (
      'select "inv$salida"."cantidad","inv$salida"."cod_agencia",'
      '"inv$salida"."cod_articulo","inv$salida"."fecha_entrega",'
      '"inv$salida"."nit_empleado","inv$salida"."no_salida",'
      '"inv$articulo"."cod_barras","inv$articulo"."nombre",'
      '"inv$salida"."definicion","inv$salida"."cantidad_articulo",'
      '"inv$salida"."precio_salida","inv$salida"."cod_dependencia"'
      'from "inv$salida","inv$articulo"'
      
        'where "inv$articulo"."cod_articulo"="inv$salida"."cod_articulo" ' +
        'and'
      '"inv$salida"."cod_articulo"=:"articulo"')
    ModifySQL.Strings = (
      'update "inv$salida"'
      'set'
      '  "inv$salida"."cantidad" = :"cantidad",'
      '  "inv$salida"."cod_agencia" = :"cod_agencia",'
      '  "inv$salida"."cod_articulo" = :"cod_articulo",'
      '  "inv$salida"."fecha_entrega" = :"fecha_entrega",'
      '  "inv$salida"."nit_empleado" = :"nit_empleado",'
      '  "inv$salida"."no_salida" = :"no_salida",'
      '  "inv$salida"."definicion" = :"definicion",'
      '  "inv$salida"."cantidad_articulo" = :"cantidad_articulo",'
      '  "inv$salida"."precio_salida" = :"precio_salida",'
      '  "inv$salida"."cod_dependencia"=:"cod_dependencia"'
      'where'
      '  "inv$salida"."cantidad" = :"OLD_cantidad" and'
      '  "inv$salida"."cod_agencia" = :"OLD_cod_agencia" and'
      '  "inv$salida"."cod_articulo" = :"OLD_cod_articulo" and'
      '  "inv$salida"."fecha_entrega" = :"OLD_fecha_entrega" and'
      '  "inv$salida"."nit_empleado" = :"OLD_nit_empleado" and'
      '  "inv$salida"."no_salida" = :"OLD_no_salida" and '
      '  "inv$salida"."definicion" = :"OLD_definicion" and'
      
        '  "inv$salida"."cantidad_articulo" = :"OLD_cantidad_articulo" an' +
        'd'
      '  "inv$salida"."precio_salida" = :"OLD_precio_salida" and'
      '   "inv$salida"."cod_dependencia" = :"OLD_cod_dependencia"'
      '')
    Filtered = True
    Left = 168
    Top = 192
    object IBsalidacantidad: TIntegerField
      ConstraintErrorMessage = 'ERROR NO PUEDE SER VACIO'
      FieldName = 'cantidad'
      Origin = '"inv$salida"."cantidad"'
      Required = True
    end
    object IBsalidacod_agencia: TSmallintField
      FieldName = 'cod_agencia'
      Origin = '"inv$salida"."cod_agencia"'
      Required = True
    end
    object IBsalidacod_articulo: TIntegerField
      FieldName = 'cod_articulo'
      Origin = '"inv$salida"."cod_articulo"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      OnValidate = IBsalidacod_articuloValidate
    end
    object IBsalidafecha_entrega: TDateField
      FieldName = 'fecha_entrega'
      Origin = '"inv$salida"."fecha_entrega"'
    end
    object IBsalidanit_empleado: TIntegerField
      FieldName = 'nit_empleado'
      Origin = '"inv$salida"."nit_empleado"'
    end
    object IBsalidano_salida: TIntegerField
      FieldName = 'no_salida'
      Origin = '"inv$salida"."no_salida"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IBsalidacod_barras: TIntegerField
      FieldName = 'cod_barras'
      Origin = '"inv$articulo"."cod_barras"'
    end
    object IBsalidanombre: TIBStringField
      FieldName = 'nombre'
      Origin = '"inv$articulo"."nombre"'
      Size = 100
    end
    object IBsalidadefinicion: TIBStringField
      FieldName = 'definicion'
      Origin = '"inv$salida"."definicion"'
      FixedChar = True
      Size = 1
    end
    object IBsalidacantidad_articulo: TIntegerField
      FieldName = 'cantidad_articulo'
      Origin = '"inv$salida"."cantidad_articulo"'
    end
    object IBsalidaprecio_salida: TIBBCDField
      FieldName = 'precio_salida'
      Origin = '"inv$salida"."precio_salida"'
      Precision = 18
      Size = 2
    end
    object IBsalidacod_dependencia: TIntegerField
      FieldName = 'cod_dependencia'
      Origin = '"inv$salida"."cod_dependencia"'
    end
  end
  object IBsql: TIBSQL
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 136
    Top = 16
  end
  object IBsel1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 200
    Top = 16
  end
  object IBdatos: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 168
    Top = 16
  end
  object IBsel: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 104
    Top = 16
  end
  object Ibdel: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 232
    Top = 16
  end
  object IBDataSet1: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      'select "inv$empleado"."nit"  from "inv$empleado"'
      
        '      where "inv$empleado"."nombre"||"inv$empleado"."apellido" =' +
        ':"nombre"')
    Left = 472
    Top = 88
  end
end
