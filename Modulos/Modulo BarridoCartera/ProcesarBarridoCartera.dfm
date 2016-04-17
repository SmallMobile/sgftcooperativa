object frmBarridoCartera: TfrmBarridoCartera
  Left = 287
  Top = 154
  Width = 409
  Height = 150
  Caption = 'Barrido Automatico de Cartera'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 385
    Height = 17
    Alignment = taCenter
    AutoSize = False
  end
  object Label2: TLabel
    Left = 8
    Top = 72
    Width = 385
    Height = 17
    Alignment = taCenter
    AutoSize = False
  end
  object Bar1: TProgressBar
    Left = 6
    Top = 41
    Width = 389
    Height = 21
    Min = 0
    Max = 100
    TabOrder = 0
  end
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 8
    Top = 104
  end
  object IBQTabla: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    SQL.Strings = (
      '       ')
    Left = 32
    Top = 102
  end
  object IBCuotas: TIBSQL
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 56
    Top = 102
  end
  object DSBarrido: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 144
    Data = {
      2D0200009619E0BD0100000018000000170000000000030000002D0207414745
      4E43494102000100000000000A434F4C4F434143494F4E010049000000010005
      5749445448020002000B001049444944454E54494649434143494F4E02000100
      00000000094944504552534F4E41010049000000010005574944544802000200
      0F000F43554F544153414C4951554944415204000100000000000D434C415349
      4649434143494F4E02000100000000000943415445474F524941010049000000
      010005574944544802000200010008474152414E54494102000100000000000B
      53414C444F41435455414C080004000000010007535542545950450200490006
      004D6F6E6579000645535441444F02000100000000000A56414C4F5243554F54
      41080004000000010007535542545950450200490006004D6F6E6579000A4645
      4348415041474F4B04000600000000000A46454348415041474F490400060000
      000000095449504F43554F54410200010000000000094944494E544552455304
      000100000000000B5449504F494E544552455301004900000001000557494454
      480200020001000956414C4F525441534108000400000000000F56414C4F5241
      435455414C5441534108000400000000000956414C4F524D4F52410800040000
      0000000A50554E544F5341444943080004000000000009414D4F5254495A414B
      040001000000000009414D4F5254495A414904000100000000000C4449415350
      524F52524F474104000100000000000000}
    object DSBarridoAGENCIA: TSmallintField
      FieldName = 'AGENCIA'
    end
    object DSBarridoCOLOCACION: TStringField
      FieldName = 'COLOCACION'
      Size = 11
    end
    object DSBarridoIDIDENTIFICACION: TSmallintField
      FieldName = 'IDIDENTIFICACION'
    end
    object DSBarridoIDPERSONA: TStringField
      FieldName = 'IDPERSONA'
      Size = 15
    end
    object DSBarridoCUOTASALIQUIDAR: TIntegerField
      FieldName = 'CUOTASALIQUIDAR'
    end
    object DSBarridoCLASIFICACION: TSmallintField
      FieldName = 'CLASIFICACION'
    end
    object DSBarridoCATEGORIA: TStringField
      FieldName = 'CATEGORIA'
      Size = 1
    end
    object DSBarridoGARANTIA: TSmallintField
      FieldName = 'GARANTIA'
    end
    object DSBarridoSALDOACTUAL: TCurrencyField
      FieldName = 'SALDOACTUAL'
    end
    object DSBarridoESTADO: TSmallintField
      FieldName = 'ESTADO'
    end
    object DSBarridoVALORCUOTA: TCurrencyField
      FieldName = 'VALORCUOTA'
    end
    object DSBarridoFECHAPAGOK: TDateField
      FieldName = 'FECHAPAGOK'
    end
    object DSBarridoFECHAPAGOI: TDateField
      FieldName = 'FECHAPAGOI'
    end
    object DSBarridoTIPOCUOTA: TSmallintField
      FieldName = 'TIPOCUOTA'
    end
    object DSBarridoIDINTERES: TIntegerField
      FieldName = 'IDINTERES'
    end
    object DSBarridoTIPOINTERES: TStringField
      FieldName = 'TIPOINTERES'
      Size = 1
    end
    object DSBarridoVALORTASA: TFloatField
      FieldName = 'VALORTASA'
    end
    object DSBarridoVALORACTUALTASA: TFloatField
      FieldName = 'VALORACTUALTASA'
    end
    object DSBarridoVALORMORA: TFloatField
      FieldName = 'VALORMORA'
    end
    object DSBarridoPUNTOSADIC: TFloatField
      FieldName = 'PUNTOSADIC'
    end
    object DSBarridoAMORTIZAK: TIntegerField
      FieldName = 'AMORTIZAK'
    end
    object DSBarridoAMORTIZAI: TIntegerField
      FieldName = 'AMORTIZAI'
    end
    object DSBarridoDIASPRORROGA: TIntegerField
      FieldName = 'DIASPRORROGA'
    end
  end
  object IBBarrido: TIBSQL
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 85
    Top = 102
  end
  object IBSaldo: TIBSQL
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 112
    Top = 102
  end
  object IBTBarrido: TIBTransaction
    AllowAutoStart = False
    DefaultDatabase = dmGeneral.IBDatabase1
    DefaultAction = TARollback
    AutoStopAction = saRollback
    Left = 110
    Top = 144
  end
  object IBExtracto: TIBSQL
    Database = dmGeneral.IBDatabase1
    Transaction = IBTBarrido
    Left = 256
    Top = 102
  end
  object IBcomprobante: TIBSQL
    Database = dmGeneral.IBDatabase1
    Transaction = dmGeneral.IBTransaction1
    Left = 136
    Top = 102
  end
  object IBConsecB: TIBSQL
    Database = dmGeneral.IBDatabase1
    Transaction = IBTBarrido
    Left = 280
    Top = 102
  end
end
