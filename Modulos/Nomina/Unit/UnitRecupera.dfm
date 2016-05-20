object FrmRecupera: TFrmRecupera
  Left = 220
  Top = 215
  Width = 273
  Height = 146
  BorderIcons = [biSystemMenu]
  Caption = 'Recuperar Nomina'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 70
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 14
      Width = 124
      Height = 13
      Caption = 'Fecha de Realizacion'
    end
    object Label2: TLabel
      Left = 10
      Top = 42
      Width = 90
      Height = 13
      Caption = 'Tipo de Nomina'
    end
    object fecha: TDateTimePicker
      Left = 141
      Top = 10
      Width = 117
      Height = 21
      CalAlignment = dtaLeft
      Date = 38135.594239537
      Time = 38135.594239537
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object dbltiponomina: TDBLookupComboBox
      Left = 142
      Top = 42
      Width = 115
      Height = 21
      KeyField = 'codigo'
      ListField = 'descripcion'
      ListSource = DataSource1
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = -1
    Top = 71
    Width = 266
    Height = 41
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Button1: TButton
      Left = 24
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Aceptar'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 152
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object DataSource1: TDataSource
    DataSet = IBQuery1
    Left = 104
    Top = 40
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "nom$tiponomina"')
    Left = 48
    Top = 24
  end
end
