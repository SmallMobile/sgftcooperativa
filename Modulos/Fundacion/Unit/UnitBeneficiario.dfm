object FrmBeneficiario: TFrmBeneficiario
  Left = 45
  Top = 189
  Width = 805
  Height = 572
  BorderIcons = [biSystemMenu]
  Caption = 'Reporte Mensual de Afiliaciones y Renovaciones'
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 88
    Top = 224
    Width = 161
    Height = 25
    Caption = 'Button1'
    TabOrder = 4
    Visible = False
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 16
    Top = 168
    Width = 185
    Height = 25
    Caption = 'duplicados'
    TabOrder = 5
    Visible = False
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 400
    Top = 304
    Width = 75
    Height = 25
    Caption = 'complrtar nit'
    TabOrder = 6
    Visible = False
    OnClick = Button4Click
  end
  object Edit1: TEdit
    Left = 240
    Top = 264
    Width = 321
    Height = 21
    TabOrder = 7
    Text = 'Edit1'
    Visible = False
  end
  object Button5: TButton
    Left = 8
    Top = 168
    Width = 169
    Height = 33
    Caption = 'verificar nit'
    TabOrder = 8
    Visible = False
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 88
    Top = 176
    Width = 121
    Height = 25
    Caption = 'ver nit'
    TabOrder = 9
    Visible = False
    OnClick = Button6Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 609
    Height = 41
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 5
      Top = 15
      Width = 54
      Height = 13
      Caption = 'Convenio'
    end
    object Label4: TLabel
      Left = 406
      Top = 15
      Width = 41
      Height = 13
      Caption = 'Oficina'
    end
    object Button7: TButton
      Left = 622
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button7'
      TabOrder = 1
      Visible = False
      OnClick = Button7Click
    end
    object DBconvenio: TDBLookupComboBox
      Left = 61
      Top = 12
      Width = 332
      Height = 21
      DropDownRows = 5
      KeyField = 'id_convenio'
      ListField = 'descripcion'
      ListSource = DSconvenio
      TabOrder = 0
    end
    object DBOficina: TDBLookupComboBox
      Left = 452
      Top = 12
      Width = 147
      Height = 21
      KeyField = 'cod_oficina'
      ListField = 'oficina'
      ListSource = DSOFICINA
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 609
    Top = 0
    Width = 187
    Height = 88
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Sejecutar: TSpeedButton
      Left = 27
      Top = 4
      Width = 137
      Height = 25
      Caption = '&Ejecutar Consulta'
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
      OnClick = SejecutarClick
    end
    object SpeedButton2: TSpeedButton
      Left = 28
      Top = 32
      Width = 137
      Height = 25
      Caption = '&Ver Reporte'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000220B0000220B00000001000000010000181818002118
        21001821210031313100393939004242420052525200636363006B6B6B007373
        7300848484008C8C8C00948C8C00949494009C949400F7AD94009C9C9C00CE9C
        9C00F7AD9C00FFAD9C00FFB59C009C9CA500A5A5A500ADA5A500C6A5A500A5AD
        A500FFBDA500A5D6A500ADADAD00B5ADAD00FFC6AD00B5B5B500FFC6B500BDBD
        BD00C6BDBD00BDC6BD00E7C6BD00EFCEBD00FFCEBD00BDBDC600C6C6C600CEC6
        C600E7CEC600CECECE00D6CECE00DED6CE00FFDECE00D6D6D600FFE7D600D6DE
        DE00DEDEDE00EFE7DE00E7E7E700EFE7E700FFE7E700EFEFEF00F7EFEF00F7EF
        F700F7F7F700FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003B3B3B3B3B3B
        103B3B3B0A0A0B3B3B3B3B3B3B3B10102C0D04060E282F0A3B3B3B3B10103A3C
        2F1005010103070A0B3B0C10373C3528100B0D0A07040201093B10343421161D
        22160D0C0D0E0B080A3B0D1C161C282F373732281C100C0D0B3B0C1C282B2832
        2B19212B2F2F281F0D3B3B102B2B32281F1B231817161F22163B3B3B10211C1C
        343837332F2B1F0D3B3B3B3B3B102F2B10212F2F2F281C3B3B3B3B3B3B3B362E
        24242A2D2B0D3B3B3B3B3B3B3B3B112E261E1A133B3B3B3B3B3B3B3B3B3B112E
        261E1A0F3B3B3B3B3B3B3B3B3B3B112E261E1A123B3B3B3B3B3B3B3B3B11302E
        261E1A123B3B3B3B3B3B3B3B3B1111111112123B3B3B3B3B3B3B}
      OnClick = SpeedButton2Click
    end
    object SpeedButton3: TSpeedButton
      Left = 28
      Top = 60
      Width = 137
      Height = 25
      Caption = '&Cerrar'
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
      OnClick = SpeedButton3Click
    end
    object Label5: TLabel
      Left = 160
      Top = 88
      Width = 39
      Height = 13
      Caption = 'Label5'
    end
    object Button2: TButton
      Left = -8
      Top = 71
      Width = 171
      Height = 25
      Caption = 'Actualizar Titular'
      TabOrder = 0
      Visible = False
      OnClick = Button2Click
    end
  end
  object Panel3: TPanel
    Left = -1
    Top = 88
    Width = 797
    Height = 449
    Caption = 'Panel3'
    TabOrder = 3
    object DBGrid1: TDBGrid
      Left = -9
      Top = 12
      Width = 797
      Height = 425
      Ctl3D = True
      DataSource = DataSource1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDrawColumnCell = DBGrid1DrawColumnCell
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'numero'
          Title.Caption = 'No'
          Width = 20
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nombres'
          Title.Caption = 'P. Nombre'
          Width = 121
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nombre1'
          Title.Caption = 'S. Nombre'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'apellido1'
          Title.Caption = 'P. Ape.'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'apellido2'
          Title.Caption = 'S. Ape.'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tipo_nit'
          Title.Caption = 'Dto'
          Width = 23
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nit'
          Title.Caption = 'Numero'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'lugar_nit'
          Title.Caption = 'De'
          Width = 51
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'parentesco'
          Title.Caption = 'Parentesco'
          Width = 61
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sexo'
          Title.Caption = 'Sexo'
          Width = 35
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'estrato'
          Title.Caption = 'Est'
          Width = 28
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'direccion'
          Title.Caption = 'Direccion'
          Width = 71
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'barrio'
          Title.Caption = 'Barrio'
          Width = 96
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'telefono'
          Title.Caption = 'Telefono'
          Width = 61
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha_na'
          Title.Caption = 'Fecha N.'
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cuenta'
          Title.Caption = 'Cuenta'
          Width = 57
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor_plan'
          Width = 88
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'fecha_a'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'plan'
          Width = 79
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'carnet'
          Width = 63
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'descripcion'
          Title.Caption = 'Descripcion'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'eps'
          Title.Caption = 'Eps'
          Width = 102
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'zona'
          Title.Caption = 'Zona'
          Width = 20
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'mail'
          Width = 20
          Visible = True
        end>
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 41
    Width = 609
    Height = 47
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Tipo: TLabel
      Left = 6
      Top = 15
      Width = 26
      Height = 13
      Caption = 'Tipo'
    end
    object Label1: TLabel
      Left = 197
      Top = 15
      Width = 71
      Height = 13
      Caption = 'Fecha Inicio'
    end
    object Label2: TLabel
      Left = 400
      Top = 15
      Width = 57
      Height = 13
      Caption = 'Fecha Fin'
    end
    object Tipoa: TComboBox
      Left = 39
      Top = 13
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 0
      Text = 'RENOVACION'
      Items.Strings = (
        'RENOVACION'
        'AFILIACION')
    end
    object fecha1: TDateTimePicker
      Left = 276
      Top = 12
      Width = 113
      Height = 21
      CalAlignment = dtaLeft
      Date = 38128.4623900463
      Format = 'dd/MM/yyyy'
      Time = 38128.4623900463
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
    object fecha2: TDateTimePicker
      Left = 470
      Top = 11
      Width = 129
      Height = 21
      CalAlignment = dtaLeft
      Date = 38128.462458044
      Format = 'dd/MM/yyyy'
      Time = 38128.462458044
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 2
    end
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    Left = 40
    Top = 176
  end
  object DataSource1: TDataSource
    DataSet = CDafiliacion
    Left = 40
    Top = 152
  end
  object CDafiliacion: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'nombres'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'nit'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'tipo_nit'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'lugar_nit'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'parentesco'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'sexo'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'estrato'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'direccion'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'barrio'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'telefono'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'fecha_na'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'cuenta'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'numero'
        DataType = ftInteger
      end
      item
        Name = 'ciudad'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'carnet'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'descripcion'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'valor_plan'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'fecha_a'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'plan'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'no_entrada'
        DataType = ftInteger
      end
      item
        Name = 'eps'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cod_oficina'
        DataType = ftInteger
      end
      item
        Name = 'es_local'
        DataType = ftInteger
      end
      item
        Name = 'des_oficina'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'nombre1'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'apellido1'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'apellido2'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'zona'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'mail'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 248
    Top = 208
    Data = {
      1E0300009619E0BD01000000180000001D0000000000030000001E03076E6F6D
      627265730100490000000100055749445448020002009600036E697401004900
      00000100055749445448020002000F00087469706F5F6E697401004900000001
      00055749445448020002000300096C756761725F6E6974010049000000010005
      57494454480200020032000A706172656E746573636F01004900000001000557
      49445448020002001400047365786F0100490000000100055749445448020002
      000100076573747261746F010049000000010005574944544802000200010009
      646972656363696F6E0100490000000100055749445448020002004600066261
      7272696F01004900000001000557494454480200020032000874656C65666F6E
      6F0100490000000100055749445448020002001E000866656368615F6E610100
      490000000100055749445448020002001400066375656E746101004900000001
      00055749445448020002001400066E756D65726F040001000000000006636975
      6461640100490000000100055749445448020002002800066361726E65740100
      4900000001000557494454480200020014000B6465736372697063696F6E0100
      4900000001000557494454480200020028000A76616C6F725F706C616E010049
      00000001000557494454480200020014000766656368615F6101004900000001
      00055749445448020002000F0004706C616E0100490000000100055749445448
      020002001E000A6E6F5F656E7472616461040001000000000003657073010049
      00000001000557494454480200020064000B636F645F6F666963696E61040001
      00000000000865735F6C6F63616C04000100000000000B6465735F6F66696369
      6E610100490000000100055749445448020002006400076E6F6D627265310200
      49000000010005574944544802000200FF00096170656C6C69646F3102004900
      0000010005574944544802000200FF00096170656C6C69646F32020049000000
      010005574944544802000200FF00047A6F6E6101004900000001000557494454
      48020002001400046D61696C0100490000000100055749445448020002003200
      0000}
    object CDafiliacionnombres: TStringField
      FieldName = 'nombres'
      Size = 150
    end
    object CDafiliacionnit: TStringField
      FieldName = 'nit'
      Size = 15
    end
    object CDafiliaciontipo_nit: TStringField
      FieldName = 'tipo_nit'
      Size = 3
    end
    object CDafiliacionlugar_nit: TStringField
      FieldName = 'lugar_nit'
      Size = 50
    end
    object CDafiliacionparentesco: TStringField
      FieldName = 'parentesco'
    end
    object CDafiliacionsexo: TStringField
      FieldName = 'sexo'
      Size = 1
    end
    object CDafiliacionestrato: TStringField
      FieldName = 'estrato'
      Size = 1
    end
    object CDafiliaciondireccion: TStringField
      FieldName = 'direccion'
      Size = 70
    end
    object CDafiliacionbarrio: TStringField
      FieldName = 'barrio'
      Size = 50
    end
    object CDafiliaciontelefono: TStringField
      FieldName = 'telefono'
      Size = 30
    end
    object CDafiliacionfecha_na: TStringField
      FieldName = 'fecha_na'
    end
    object CDafiliacioncuenta: TStringField
      FieldName = 'cuenta'
    end
    object CDafiliacionnumero: TIntegerField
      FieldName = 'numero'
    end
    object CDafiliacionciudad: TStringField
      FieldName = 'ciudad'
      Size = 40
    end
    object CDafiliacioncarnet: TStringField
      FieldName = 'carnet'
    end
    object CDafiliaciondescripcion: TStringField
      FieldName = 'descripcion'
      Size = 40
    end
    object CDafiliacionvalor_plan: TStringField
      FieldName = 'valor_plan'
    end
    object CDafiliacionfecha_a: TStringField
      FieldName = 'fecha_a'
      Size = 15
    end
    object CDafiliacionplan: TStringField
      FieldName = 'plan'
      Size = 30
    end
    object CDafiliacionno_entrada: TIntegerField
      FieldName = 'no_entrada'
    end
    object CDafiliacioneps: TStringField
      FieldName = 'eps'
      Size = 100
    end
    object CDafiliacioncod_oficina: TIntegerField
      FieldName = 'cod_oficina'
    end
    object CDafiliaciones_local: TIntegerField
      FieldName = 'es_local'
    end
    object CDafiliaciondes_oficina: TStringField
      FieldName = 'des_oficina'
      Size = 100
    end
    object CDafiliacionnombre1: TStringField
      FieldName = 'nombre1'
      Size = 255
    end
    object CDafiliacionapellido1: TStringField
      FieldName = 'apellido1'
      Size = 255
    end
    object CDafiliacionapellido2: TStringField
      FieldName = 'apellido2'
      Size = 255
    end
    object CDafiliacionzona: TStringField
      FieldName = 'zona'
    end
    object CDafiliacionmail: TStringField
      FieldName = 'mail'
      Size = 50
    end
  end
  object IBconvenio: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'SELECT DISTINCT '
      '  "fun$convenios"."id_convenio",'
      '  "fun$convenios"."descripcion"'
      'FROM'
      '  "fun$convenios"'
      'order by   "fun$convenios"."id_convenio"')
    Left = 8
    Top = 48
  end
  object DSconvenio: TDataSource
    DataSet = IBconvenio
    Top = 56
  end
  object PrAfiliacion: TprTxReport
    ShowProgress = True
    ExportFromPage = 0
    ExportToPage = 0
    Values = <>
    Variables = <
      item
        Name = 'empresa'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'hoy'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'anulacion'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'empleado'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'Nit'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'oficina'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'tiponota'
        ValueType = 'prvvtString'
        Value = ''
      end
      item
        Name = 'tramite'
        ValueType = 'prvvtString'
        Value = ''
      end>
    WrapAfterColumn = 0
    EjectPageAfterPrint = False
    LinesOnPage = 0
    FromLine = 0
    ToLine = 0
    ExportFromLine = 0
    ExportToLine = 0
    Left = 73
    Top = 177
    SystemInfo = (
      'OS: WIN32_NT 5.1.2600 Service Pack 2'
      ''
      'PageSize: 4096'
      'ActiveProcessorMask: $1000'
      'NumberOfProcessors: 1'
      'ProcessorType: 586'
      ''
      'Compiler version: Delphi6'
      'PReport version: 1.9.4')
    object prTxPage1: TprTxPage
      PageType = tptPage
      LineNum = 60
      ColNum = 160
      object prTxHTitleBand1: TprTxHTitleBand
        Height = 10
        UseVerticalBands = False
        object prTxCommandObj1: TprTxCommandObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 2
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj1: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'FUNDACION [empresa]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = True
              CanResizeY = True
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold
                tfoWide)
            end>
          dRec.Left = 2
          dRec.Top = 0
          dRec.Right = 36
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj2: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Nit. [Nit]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = True
              CanResizeY = True
              hAlign = prhLeft
              vAlign = prvCenter
              DefaultFont = False
              WordWrap = False
              TxFontOptionsEx = (
                tfoBold)
            end>
          dRec.Left = 42
          dRec.Top = 0
          dRec.Right = 61
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj3: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Fecha del Reporte: [hoy]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 2
          dRec.Top = 1
          dRec.Right = 48
          dRec.Bottom = 2
          Visible = False
        end
        object prTxMemoObj4: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Descripcion: [tramite]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 2
          dRec.Top = 2
          dRec.Right = 115
          dRec.Bottom = 3
          Visible = False
        end
        object prTxMemoObj5: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '1. CEDULA DE CIUDADANIA'
                '2. TARJETA DE IDENTIDAD'
                '3. PASAPORTE'
                '4. REGISTRO CIVIL'
                '5. OTROS (C.C MADRE)')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
              TxFontStyleEx = tfsElite
            end>
          dRec.Left = 2
          dRec.Top = 4
          dRec.Right = 39
          dRec.Bottom = 9
          Visible = False
        end
        object prTxMemoObj8: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Dcto')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 36
          dRec.Top = 10
          dRec.Right = 41
          dRec.Bottom = 11
          Visible = False
        end
        object prTxMemoObj9: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Numero')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 41
          dRec.Top = 10
          dRec.Right = 52
          dRec.Bottom = 11
          Visible = False
        end
        object prTxMemoObj18: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Ciudad')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 76
          dRec.Top = 10
          dRec.Right = 89
          dRec.Bottom = 11
          Visible = False
        end
        object prTxMemoObj23: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Eps')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 120
          dRec.Top = 10
          dRec.Right = 137
          dRec.Bottom = 11
          Visible = False
        end
      end
      object prTxHDetailBand1: TprTxHDetailBand
        Height = 1
        UseVerticalBands = False
        DataSetName = 'CDafiliacion'
        ColCount = 1
        ColDirection = prcdTopBottomLeftRight
        Bands = (
          'prTxHDetailHeaderBand1')
        object prTxMemoObj19: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.numero]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 2
          dRec.Top = 0
          dRec.Right = 7
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj21: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.tipo_nit]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhCenter
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 36
          dRec.Top = 0
          dRec.Right = 41
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj22: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.nit]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 41
          dRec.Top = 0
          dRec.Right = 52
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj24: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.parentesco]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 52
          dRec.Top = 0
          dRec.Right = 65
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj29: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.telefono]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 65
          dRec.Top = 0
          dRec.Right = 76
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj31: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.ciudad]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 76
          dRec.Top = 0
          dRec.Right = 89
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj20: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.nombres]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 7
          dRec.Top = 0
          dRec.Right = 36
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj13: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.cuenta]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 89
          dRec.Top = 0
          dRec.Right = 96
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj14: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.carnet]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 97
          dRec.Top = 0
          dRec.Right = 103
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj17: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.descripcion]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 104
          dRec.Top = 0
          dRec.Right = 120
          dRec.Bottom = 1
          Visible = False
        end
      end
      object prTxHDetailHeaderBand1: TprTxHDetailHeaderBand
        Height = 2
        UseVerticalBands = False
        DetailBand = PrAfiliacion.prTxHDetailBand1
        ColCount = 0
        ColDirection = prcdTopBottomLeftRight
        ReprintOnEachPage = False
        LinkToDetail = False
        object prTxMemoObj6: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'No')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 2
          dRec.Top = 0
          dRec.Right = 7
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj7: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Apellidos y Nombres')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 7
          dRec.Top = 0
          dRec.Right = 36
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj11: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Parentesco')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 52
          dRec.Top = 0
          dRec.Right = 65
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj16: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Telefono')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 65
          dRec.Top = 0
          dRec.Right = 76
          dRec.Bottom = 1
          Visible = False
        end
        object prTxCommandObj2: TprTxCommandObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              TxCommands = (
                txcNormal)
            end>
          dRec.Left = 1
          dRec.Top = 0
          dRec.Right = 2
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj10: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Cuenta')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 89
          dRec.Top = 0
          dRec.Right = 96
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj12: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Carnet')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 97
          dRec.Top = 0
          dRec.Right = 103
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj15: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                'Descripcion')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 104
          dRec.Top = 0
          dRec.Right = 120
          dRec.Bottom = 1
          Visible = False
        end
        object prTxMemoObj25: TprTxMemoObj
          dRec.DefVersion = 0
          dRec.Versions = <
            item
              Visible = True
              Memo.Strings = (
                '[CDafiliacion.eps]')
              DeleteEmptyLinesAtEnd = False
              DeleteEmptyLines = False
              CanResizeX = False
              CanResizeY = False
              hAlign = prhLeft
              vAlign = prvTop
              DefaultFont = False
              WordWrap = False
            end>
          dRec.Left = 120
          dRec.Top = 2
          dRec.Right = 137
          dRec.Bottom = 3
          Visible = False
        end
      end
    end
  end
  object IBid: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "fun$tipoidentificacion"')
    Left = 8
    Top = 176
  end
  object CDoficina: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cod_oficina'
        DataType = ftInteger
      end
      item
        Name = 'oficina'
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 136
    Top = 176
    Data = {
      4A0000009619E0BD0100000018000000020000000000030000004A000B636F64
      5F6F666963696E610400010000000000076F666963696E610100490000000100
      0557494454480200020032000000}
    object CDoficinacod_oficina: TIntegerField
      FieldName = 'cod_oficina'
    end
    object CDoficinaoficina: TStringField
      FieldName = 'oficina'
      Size = 50
    end
  end
  object DSOFICINA: TDataSource
    DataSet = CDoficina
    Left = 136
    Top = 208
  end
  object FRexcel: TfrOLEExcelExport
    Default = True
    ShowDialog = False
    CellsBorders = False
    ExportPictures = False
    OpenExcelAfterExport = True
    PageBreaks = False
    Left = 8
    Top = 240
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    Left = 8
    Top = 208
    ReportForm = {19000000}
  end
  object frCompositeReport1: TfrCompositeReport
    InitialZoom = pzDefault
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    DoublePassReport = False
    Left = 40
    Top = 208
    ReportForm = {19000000}
  end
  object frDBDataSet1: TfrDBDataSet
    DataSet = CDafiliacion
    Left = 72
    Top = 208
  end
  object SaveDialog1: TSaveDialog
    Filter = 'Excel|xls'
    InitialDir = 'c:\fundacion\export'
    Left = 40
    Top = 272
  end
  object frDBDataSet2: TfrDBDataSet
    DataSet = IBid
    Left = 40
    Top = 304
  end
  object IBtiponit: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "fun$tipoidentificacion"')
    Left = 8
    Top = 272
  end
  object frTextExport1: TfrTextExport
    ScaleX = 1
    ScaleY = 1
    Left = 40
    Top = 240
  end
  object frRTFExport1: TfrRTFExport
    ScaleX = 1.3
    ScaleY = 1
    Left = 72
    Top = 240
  end
  object frCSVExport1: TfrCSVExport
    Default = True
    ShowDialog = False
    ScaleX = 10
    ScaleY = 10
    ConvertToOEM = True
    Delimiter = ','
    Left = 72
    Top = 272
  end
  object frHTMExport1: TfrHTMExport
    ScaleX = 1
    ScaleY = 1
    Left = 8
    Top = 304
  end
  object Dialogo: TJvSaveDialog
    DefaultExt = '*.xls'
    Filter = 'Archivos de Exel|*.xls'
    InitialDir = 'c:\'
    Height = 419
    Width = 563
    Left = 104
    Top = 176
  end
  object PopupMenu1: TPopupMenu
    AutoPopup = False
    Left = 104
    Top = 208
    object ExportarDatos1: TMenuItem
      Caption = 'Exportar Datos'
      ShortCut = 16453
      OnClick = ExportarDatos1Click
    end
  end
end
