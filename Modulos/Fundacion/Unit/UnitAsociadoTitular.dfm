object FrmAsociadoTitular: TFrmAsociadoTitular
  Left = 252
  Top = 200
  Width = 418
  Height = 311
  BorderIcons = [biSystemMenu]
  Caption = 'Restaurar Asociados Titulares'
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
    Width = 409
    Height = 89
    Alignment = taLeftJustify
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 200
      Top = 27
      Width = 65
      Height = 13
      Caption = 'Documento'
    end
    object JvLabel1: TJvLabel
      Left = 3
      Top = 2
      Width = 197
      Height = 13
      Caption = 'Informaci'#243'n Beneficiarios Titulares'
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
    end
    object Label3: TLabel
      Left = 4
      Top = 27
      Width = 41
      Height = 13
      Caption = 'Oficina'
    end
    object Label2: TLabel
      Left = 5
      Top = 57
      Width = 50
      Height = 13
      Caption = 'Nombres'
    end
    object JvEdit1: TJvEdit
      Left = 268
      Top = 25
      Width = 135
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
      OnExit = JvEdit1Exit
    end
    object DBOficina: TDBLookupComboBox
      Left = 63
      Top = 25
      Width = 130
      Height = 21
      KeyField = 'cod_oficina'
      ListField = 'descripcion'
      ListSource = DataSource1
      TabOrder = 0
    end
    object LBnombres: TJvStaticText
      Left = 64
      Top = 56
      Width = 337
      Height = 21
      TextMargins.X = 0
      TextMargins.Y = 0
      AutoSize = False
      BorderStyle = sbsSunken
      Color = clBtnHighlight
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Layout = tlTop
      ParentColor = False
      TabOrder = 2
      WordWrap = False
    end
  end
  object DataSource1: TDataSource
    DataSet = IBQuery1
    Left = 208
    Top = 8
  end
  object IBQuery1: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from "fun$oficinas"')
    Left = 248
  end
end
