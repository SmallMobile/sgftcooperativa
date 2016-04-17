object Form1: TForm1
  Left = 208
  Top = 116
  Width = 559
  Height = 622
  Caption = 'Traslado de Agencia'
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
  object Label1: TLabel
    Left = 128
    Top = 40
    Width = 37
    Height = 13
    Caption = 'Numero'
  end
  object Label2: TLabel
    Left = 138
    Top = 8
    Width = 21
    Height = 13
    Caption = 'Tipo'
  end
  object Edit1: TEdit
    Left = 171
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '5035698'
  end
  object Edit2: TEdit
    Left = 170
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '3'
  end
  object Memo1: TMemo
    Left = 8
    Top = 101
    Width = 537
    Height = 481
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object JvImgBtn1: TJvImgBtn
    Left = 308
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Trasladar'
    TabOrder = 3
    OnClick = JvImgBtn1Click
  end
  object Button1: TButton
    Left = 308
    Top = 37
    Width = 121
    Height = 25
    Caption = 'Insertar'
    TabOrder = 4
    OnClick = Button1Click
  end
  object xml: TJvSimpleXml
    Left = 8
    Top = 56
  end
  object IBDatabase1: TIBDatabase
    DatabaseName = '192.168.200.198:/var/db/fbird/database.fdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=isO8859_1')
    LoginPrompt = False
    Left = 8
  end
  object IBconsulta: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 88
    Top = 56
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 32
  end
  object CdSolicitud: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 224
    Top = 56
    Data = {
      3B0000009619E0BD0100000018000000010000000000030000003B000C49445F
      534F4C4943495455440100490000000100055749445448020002000A000000}
    object CdSolicitudID_SOLICITUD: TStringField
      FieldName = 'ID_SOLICITUD'
      Size = 10
    end
  end
  object xml1: TJvSimpleXml
    Left = 40
    Top = 56
  end
  object CDcartera: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 248
    Top = 56
    Data = {
      3C0000009619E0BD0100000018000000010000000000030000003C000D49445F
      434F4C4F434143494F4E0100490000000100055749445448020002000B000000}
    object CDcarteraID_COLOCACION: TStringField
      FieldName = 'ID_COLOCACION'
      Size = 11
    end
  end
  object IBInsertar: TIBQuery
    Database = IBDatabase2
    Transaction = IBTransaction2
    Left = 120
    Top = 56
  end
  object IBDatabase2: TIBDatabase
    DatabaseName = '192.168.200.198:/var/db/copia/database.fdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=isO8859_1')
    LoginPrompt = False
    DefaultTransaction = IBTransaction2
    Left = 72
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = IBDatabase2
    Left = 96
  end
  object IBSQL1: TIBSQL
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 144
    Top = 56
  end
  object IBSQL2: TIBSQL
    Database = IBDatabase1
    Transaction = IBTransaction1
    Left = 168
    Top = 56
  end
end
