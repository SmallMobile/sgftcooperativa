object dmPersona: TdmPersona
  OldCreateOrder = False
  Left = 207
  Top = 149
  Height = 365
  Width = 518
  object IBQuery: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    ForcedRefresh = True
    SQL.Strings = (
      'select * from "gen$persona"')
    Left = 8
    Top = 18
  end
  object DStiposrelacion: TDataSource
    AutoEdit = False
    DataSet = IBDStiposrelacion
    Left = 272
    Top = 4
  end
  object DStiposciiu: TDataSource
    AutoEdit = False
    DataSet = IBDStiposciiu
    Left = 344
    Top = 4
  end
  object DStiposidentificacion: TDataSource
    AutoEdit = False
    DataSet = IBDStiposidentificacion
    Left = 64
    Top = 58
  end
  object DStipopersona: TDataSource
    DataSet = IBDStipopersona
    Left = 206
    Top = 2
  end
  object DSestadocivil: TDataSource
    AutoEdit = False
    DataSet = IBDSestadocivil
    Left = 326
    Top = 56
  end
  object DStiposidentificacionconyuge: TDataSource
    AutoEdit = False
    DataSet = IBDStiposidentificacionconyuge
    Left = 124
    Top = 4
  end
  object DStipodireccion: TDataSource
    DataSet = IBDStipodireccion
    Left = 154
    Top = 56
  end
  object DStiporeferencia: TDataSource
    DataSet = IBDStiporeferencia
    Left = 242
    Top = 56
  end
  object DSparentesco: TDataSource
    AutoEdit = False
    DataSet = IBDSparentesco
    Left = 66
    Top = 6
  end
  object IBQuery1: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    Left = 18
    Top = 186
  end
  object IBTPersonas: TIBTransaction
    DefaultDatabase = dmGeneral.IBDatabase1
    DefaultAction = TARollback
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    AutoStopAction = saRollback
    Left = 20
    Top = 258
  end
  object IBDStiposidentificacion: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    ForcedRefresh = True
    SQL.Strings = (
      'select * from "gen$tiposidentificacion"')
    Left = 190
    Top = 110
  end
  object IBDStiposrelacion: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    ForcedRefresh = True
    SQL.Strings = (
      'select * from "gen$tiposrelacion"')
    Left = 94
    Top = 116
  end
  object IBDStiposciiu: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    ForcedRefresh = True
    SQL.Strings = (
      'select * from "gen$tiposciiu"')
    Left = 20
    Top = 116
  end
  object IBDStipopersona: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    ForcedRefresh = True
    SQL.Strings = (
      'select * from "gen$tipospersona"')
    Left = 254
    Top = 174
  end
  object IBDSestadocivil: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    ForcedRefresh = True
    SQL.Strings = (
      'select * from "gen$tiposestadocivil"')
    Left = 376
    Top = 196
  end
  object IBDStiposidentificacionconyuge: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    ForcedRefresh = True
    SQL.Strings = (
      'select * from "gen$tiposidentificacion"')
    Left = 386
    Top = 146
  end
  object IBDStipodireccion: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    SQL.Strings = (
      'select * from "gen$tiposdireccion"')
    Left = 302
    Top = 218
  end
  object IBDStiporeferencia: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    SQL.Strings = (
      'select * from "gen$tiposreferencia"')
    Left = 98
    Top = 204
  end
  object IBDSparentesco: TIBQuery
    Database = dmGeneral.IBDatabase1
    Transaction = IBTPersonas
    SQL.Strings = (
      'select * from "gen$tiposparentesco"')
    Left = 304
    Top = 116
  end
end
