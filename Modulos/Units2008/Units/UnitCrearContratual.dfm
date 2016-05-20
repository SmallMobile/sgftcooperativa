object FrmCrearContractual: TFrmCrearContractual
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Mantenimiento de Contractuales'
  ClientHeight = 356
  ClientWidth = 488
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 489
    Height = 241
    Caption = 'Planes Actuales'
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 3
      Top = 16
      Width = 482
      Height = 222
      DataSource = DsContractual
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ID_PLAN'
          Title.Caption = 'Csc'
          Width = 29
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRIPCION'
          Width = 305
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PLAZO'
          Width = 77
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PORCENTAJE'
          Title.Alignment = taCenter
          Title.Caption = '%'
          Width = 30
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ACTIVO'
          Title.Caption = 'S'
          Visible = False
        end>
    end
  end
  object DsContractual: TDataSource
    DataSet = CdContractual
    Left = 336
    Top = 328
  end
  object CdContractual: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 240
    Top = 288
    Data = {
      7A0000009619E0BD0100000018000000050000000000030000007A000749445F
      504C414E04000100000000000B4445534352495043494F4E0200490000000100
      05574944544802000200FF0005504C415A4F04000100000000000A504F524345
      4E54414A4508000400000000000641435449564F02000300000000000000}
    object CdContractualID_PLAN: TIntegerField
      FieldName = 'ID_PLAN'
    end
    object CdContractualDESCRIPCION: TStringField
      FieldName = 'DESCRIPCION'
      Size = 255
    end
    object CdContractualPLAZO: TIntegerField
      FieldName = 'PLAZO'
    end
    object CdContractualPORCENTAJE: TFloatField
      FieldName = 'PORCENTAJE'
    end
    object CdContractualACTIVO: TBooleanField
      FieldName = 'ACTIVO'
    end
  end
end
