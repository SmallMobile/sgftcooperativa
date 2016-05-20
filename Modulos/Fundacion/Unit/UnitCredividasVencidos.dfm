object FrmCredividasVencidos: TFrmCredividasVencidos
  Left = 428
  Top = 289
  Width = 290
  Height = 115
  BorderIcons = [biSystemMenu]
  Caption = 'Credividas Vencidos'
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
    Width = 281
    Height = 41
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 11
      Width = 39
      Height = 13
      Caption = 'F. Inicial'
    end
    object Label2: TLabel
      Left = 143
      Top = 11
      Width = 34
      Height = 13
      Caption = 'F. Final'
    end
    object DtFecha1: TDateTimePicker
      Left = 48
      Top = 8
      Width = 91
      Height = 21
      CalAlignment = dtaLeft
      Date = 39659.3806177546
      Time = 39659.3806177546
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 0
    end
    object DtFecha2: TDateTimePicker
      Left = 182
      Top = 8
      Width = 91
      Height = 21
      CalAlignment = dtaLeft
      Date = 39659.3806809259
      Time = 39659.3806809259
      DateFormat = dfShort
      DateMode = dmComboBox
      Kind = dtkDate
      ParseInput = False
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 281
    Height = 40
    TabOrder = 1
    object BitBtn1: TBitBtn
      Left = 28
      Top = 8
      Width = 90
      Height = 25
      Caption = '&Ejecutar'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 156
      Top = 8
      Width = 90
      Height = 25
      Caption = '&Salir'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 144
    Top = 16
  end
  object IdTCPClient1: TIdTCPClient
    OnWork = IdTCPClient1Work
    OnWorkBegin = IdTCPClient1WorkBegin
    Port = 0
    Left = 72
    Top = 40
  end
  object JvProgreso: TJvProgressDlg
    Text = 'Progress'
    Left = 128
    Top = 48
  end
  object Jv: TJvSaveDialog
    Filter = 'Excel 97-2003|*.xls'
    Height = 419
    Width = 563
    Left = 136
    Top = 32
  end
end
