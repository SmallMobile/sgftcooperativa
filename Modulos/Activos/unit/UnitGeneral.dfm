object frmgeneral: Tfrmgeneral
  OldCreateOrder = False
  Left = 232
  Top = 181
  Height = 313
  Width = 311
  object activo_componente: TDataSource
    DataSet = componente
    Left = 48
    Top = 176
  end
  object poliza: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    OnPostError = polizaPostError
    DeleteSQL.Strings = (
      'delete from "act$poliza"'
      'where'
      '  "act$poliza"."cod_poliza" = :"OLD_cod_poliza" and'
      '  "act$poliza"."tipo_poliza" = :"OLD_tipo_poliza"')
    InsertSQL.Strings = (
      'insert into "act$poliza"'
      
        '  ("act$poliza"."cod_poliza", "act$poliza"."tipo_poliza", "act$p' +
        'oliza"."fecha_inicio", '
      '   "act$poliza"."fecha_vencimiento", "act$poliza"."cod_activo", '
      '"act$poliza"."valor_asegurado", '
      '   "act$poliza"."nit_seguro", "act$poliza"."vencido")'
      'values'
      
        '  (:"cod_poliza", :"tipo_poliza", :"fecha_inicio", :"fecha_venci' +
        'miento", '
      '   :"cod_activo", :"valor_asegurado", :"nit_seguro", :"vencido")')
    RefreshSQL.Strings = (
      'Select '
      '  "act$poliza"."cod_poliza",'
      '  "act$poliza"."tipo_poliza",'
      '  "act$poliza"."fecha_inicio",'
      '  "act$poliza"."fecha_vencimiento",'
      '  "act$poliza"."cod_activo",'
      '  "act$poliza"."valor_asegurado",'
      '  "act$poliza"."nit_seguro",'
      '  "act$poliza"."vencido"'
      'from "act$poliza" '
      'where'
      '  "act$poliza"."cod_poliza" = :"cod_poliza" and'
      '  "act$poliza"."tipo_poliza" = :"tipo_poliza"')
    SelectSQL.Strings = (
      'Select '
      '  "act$poliza"."cod_poliza",'
      '  "act$poliza"."tipo_poliza",'
      '   "act$poliza"."fecha_inicio",'
      '  "act$poliza"."fecha_vencimiento",'
      '  "act$poliza"."cod_activo",'
      '  "act$poliza"."valor_asegurado",'
      '   "act$poliza"."nit_seguro",'
      '    "act$poliza"."vencido"'
      ''
      ''
      ''
      'from "act$poliza","act$tipo_poliza"'
      'where "act$poliza"."cod_poliza"=:"poliza"'
      '')
    ModifySQL.Strings = (
      'update "act$poliza"'
      'set'
      '  "act$poliza"."cod_poliza" = :"cod_poliza",'
      '  "act$poliza"."tipo_poliza" = :"tipo_poliza",'
      '  "act$poliza"."fecha_inicio" = :"fecha_inicio",'
      '  "act$poliza"."fecha_vencimiento" = :"fecha_vencimiento",'
      '  "act$poliza"."cod_activo" = :"cod_activo",'
      '  "act$poliza"."valor_asegurado" = :"valor_asegurado",'
      '  "act$poliza"."nit_seguro" = :"nit_seguro",'
      '  "act$poliza"."vencido" = :"vencido"'
      'where'
      '  "act$poliza"."cod_poliza" = :"OLD_cod_poliza" and'
      '  "act$poliza"."tipo_poliza" = :"OLD_tipo_poliza"')
    Left = 59
    Top = 58
    object polizacod_poliza: TIntegerField
      FieldName = 'cod_poliza'
      Origin = 'act$poliza.cod_poliza'
      Required = True
    end
    object polizatipo_poliza: TSmallintField
      FieldName = 'tipo_poliza'
      Origin = 'act$poliza.tipo_poliza'
    end
    object polizafecha_inicio: TDateField
      FieldName = 'fecha_inicio'
      Origin = 'act$poliza.fecha_inicio'
      OnValidate = polizafecha_inicioValidate
      EditMask = '!90/90/00;1;_'
    end
    object polizafecha_vencimiento: TDateField
      FieldName = 'fecha_vencimiento'
      Origin = 'act$poliza.fecha_vencimiento'
      EditMask = '!90/90/00;1;_'
    end
    object polizacod_activo: TIntegerField
      FieldName = 'cod_activo'
      Origin = 'act$poliza.cod_activo'
    end
    object polizavalor_asegurado: TIBBCDField
      FieldName = 'valor_asegurado'
      Origin = 'act$poliza.valor_asegurado'
      OnValidate = polizavalor_aseguradoValidate
      Precision = 18
      Size = 2
    end
    object polizanit_seguro: TIBBCDField
      FieldName = 'nit_seguro'
      Origin = 'act$poliza.nit_seguro'
      Required = True
      Precision = 18
      Size = 1
    end
    object polizaseguro: TStringField
      FieldKind = fkLookup
      FieldName = 'seguro'
      LookupDataSet = IbAseguradora
      LookupKeyFields = 'nit_aseguradora'
      LookupResultField = 'descripcion'
      KeyFields = 'nit_seguro'
      Lookup = True
    end
    object polizanombre_poliza: TStringField
      FieldKind = fkLookup
      FieldName = 'nombre_poliza'
      LookupDataSet = tipo_polizas
      LookupKeyFields = 'cod_tipopoliza'
      LookupResultField = 'descripcion'
      KeyFields = 'tipo_poliza'
      Lookup = True
    end
    object polizavencido: TSmallintField
      FieldName = 'vencido'
      Origin = 'act$poliza.vencido'
    end
  end
  object pol: TDataSource
    DataSet = poliza
    Left = 6
    Top = 59
  end
  object componente: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    DeleteSQL.Strings = (
      'delete from "act$componente"'
      'where'
      '  "act$componente"."cod_activo" = :"OLD_cod_activo" and'
      '  "act$componente"."cod_componente" = :"OLD_cod_componente" and'
      '  "act$componente"."descripcion" = :"OLD_descripcion" and'
      '  "act$componente"."serial" = :"OLD_serial" and'
      '  "act$componente"."placa" = :"OLD_placa"')
    InsertSQL.Strings = (
      'insert into "act$componente"'
      
        '  ("act$componente"."cod_activo", "act$componente"."cod_componen' +
        'te", '
      '"act$componente"."descripcion", '
      '   "act$componente"."serial","act$componente"."placa")'
      'values'
      
        '  (:"cod_activo", :"cod_componente", :"descripcion", :"serial",:' +
        '"placa")')
    SelectSQL.Strings = (
      'select * from "act$componente"'
      'where "act$componente"."cod_activo"=:"cod_activo"')
    ModifySQL.Strings = (
      'update "act$componente"'
      'set'
      '  "act$componente"."cod_activo" = :"cod_activo",'
      '  "act$componente"."cod_componente" = :"cod_componente",'
      '  "act$componente"."descripcion" = :"descripcion",'
      '  "act$componente"."serial" = :"serial",'
      '  "act$componente"."placa" = :"placa"'
      '  '
      'where'
      '  "act$componente"."cod_activo" = :"OLD_cod_activo" and'
      '  "act$componente"."cod_componente" = :"OLD_cod_componente" and'
      '  "act$componente"."descripcion" = :"OLD_descripcion" and'
      '  "act$componente"."serial" = :"OLD_serial" and'
      '  "act$componente"."placa" = :"OLD_placa"')
    Filtered = True
    Left = 152
    Top = 288
    object componentecod_componente: TIntegerField
      FieldName = 'cod_componente'
      Origin = 'act$componente.cod_componente'
      Required = True
    end
    object componentecod_activo: TIntegerField
      FieldName = 'cod_activo'
      Origin = 'act$componente.cod_activo'
      Required = True
    end
    object componentedescripcion: TIBStringField
      FieldName = 'descripcion'
      Origin = 'act$componente.descripcion'
      Size = 100
    end
    object componenteserial: TIBStringField
      FieldName = 'serial'
      Origin = 'act$componente.serial'
      OnValidate = componenteserialValidate
      Size = 50
    end
    object componenteplaca: TIBStringField
      FieldName = 'placa'
      Origin = '"act$componente"."placa"'
      FixedChar = True
      Size = 10
    end
  end
  object tipo_polizas: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      'select * from "act$tipo_poliza"')
    Left = 200
    Top = 56
  end
  object busca_nombre: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select "inv$empleado"."nit","inv$dependencia"."nombre" as nombre' +
        ','
      '"inv$empleado"."cod_dependencia"'
      'from "inv$empleado","inv$dependencia"'
      
        'where "inv$empleado"."nombre"||"inv$empleado"."apellido" =:"nomb' +
        're" and  "inv$empleado"."cod_dependencia"='
      '"inv$dependencia"."cod_dependencia"')
    Left = 120
    Top = 112
  end
  object DataAgencia: TDataSource
    DataSet = IbAgencia
    Left = 232
    Top = 8
  end
  object IbAgencia: TIBQuery
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SQL.Strings = (
      'select * from "Inv$Agencia"')
    Left = 56
    Top = 8
  end
  object hitorial_polizas: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    DeleteSQL.Strings = (
      'delete from "act$poliza"'
      'where'
      '  "act$poliza"."cod_poliza" = :"OLD_cod_poliza" and'
      '  "act$poliza"."tipo_poliza" = :"OLD_tipo_poliza" and'
      '  "act$poliza"."fecha_inicio" = :"OLD_fecha_inicio" and'
      
        '  "act$poliza"."fecha_vencimiento" = :"OLD_fecha_vencimiento" an' +
        'd'
      '  "act$poliza"."cod_activo" = :"OLD_cod_activo" and'
      '  "act$poliza"."valor_asegurado" = :"OLD_valor_asegurado"')
    InsertSQL.Strings = (
      'insert into "act$poliza"'
      '  ("act$poliza"."cod_poliza", "act$poliza"."tipo_poliza",  '
      
        '   "act$poliza"."fecha_inicio", "act$poliza"."fecha_vencimiento"' +
        ', '
      '"act$poliza"."cod_activo", '
      '   "act$poliza"."valor_asegurado")'
      'values'
      
        '  (:"cod_poliza", :"tipo_poliza", :"fecha_inicio", :"fecha_venci' +
        'miento", '
      '   :"cod_activo", :"valor_asegurado")')
    RefreshSQL.Strings = (
      'Select '
      '  "act$poliza"."cod_poliza",'
      '  "act$poliza"."tipo_poliza",'
      '  "act$poliza"."fecha_inicio",'
      '  "act$poliza"."fecha_vencimiento",'
      '  "act$poliza"."cod_activo",'
      '  "act$poliza"."valor_asegurado",'
      '  "act$tipo_poliza"."descripcion"'
      ''
      'from "act$poliza" ,"act$tipo_poliza" '
      
        'where "act$tipo_poliza"."cod_tipopoliza"= "act$poliza"."tipo_pol' +
        'iza" and'
      '"act$poliza"."cod_activo" = :"codigo"'
      '  ')
    SelectSQL.Strings = (
      'Select'
      '  "act$poliza"."cod_poliza",'
      '  "act$poliza"."tipo_poliza",'
      '  "act$poliza"."fecha_inicio",'
      '  "act$poliza"."fecha_vencimiento",'
      '  "act$poliza"."cod_activo",'
      '  "act$poliza"."valor_asegurado",'
      '  "act$tipo_poliza"."descripcion",'
      '  "act$aseguradora"."descripcion"'
      'from "act$poliza" ,"act$tipo_poliza" ,"act$aseguradora"'
      
        'where "act$tipo_poliza"."cod_tipopoliza"= "act$poliza"."tipo_pol' +
        'iza" and'
      '"act$poliza"."nit_seguro" ="act$aseguradora"."nit_aseguradora"'
      
        'and "act$poliza"."vencido" = 0 and "act$poliza"."cod_activo"=:"c' +
        'odigo"')
    ModifySQL.Strings = (
      'update "act$poliza"'
      'set'
      '  "act$poliza"."cod_poliza" = :"cod_poliza",'
      '  "act$poliza"."tipo_poliza" = :"tipo_poliza",'
      '  "act$poliza"."fecha_inicio" = :"fecha_inicio",'
      '  "act$poliza"."fecha_vencimiento" = :"fecha_vencimiento",'
      '  "act$poliza"."cod_activo" = :"cod_activo",'
      '  "act$poliza"."valor_asegurado" = :"valor_asegurado"'
      'where'
      '  "act$poliza"."cod_poliza" = :"OLD_cod_poliza" and'
      '  "act$poliza"."tipo_poliza" = :"OLD_tipo_poliza" and'
      '  "act$poliza"."fecha_inicio" = :"OLD_fecha_inicio" and'
      
        '  "act$poliza"."fecha_vencimiento" = :"OLD_fecha_vencimiento" an' +
        'd'
      '  "act$poliza"."cod_activo" = :"OLD_cod_activo" and'
      '  "act$poliza"."valor_asegurado" = :"OLD_valor_asegurado"')
    Left = 56
    Top = 112
    object hitorial_polizascod_poliza: TIntegerField
      FieldName = 'cod_poliza'
      Origin = 'act$poliza.cod_poliza'
      Required = True
    end
    object hitorial_polizastipo_poliza: TSmallintField
      FieldName = 'tipo_poliza'
      Origin = 'act$poliza.tipo_poliza'
    end
    object hitorial_polizasfecha_inicio: TDateField
      FieldName = 'fecha_inicio'
      Origin = 'act$poliza.fecha_inicio'
    end
    object hitorial_polizasfecha_vencimiento: TDateField
      FieldName = 'fecha_vencimiento'
      Origin = 'act$poliza.fecha_vencimiento'
    end
    object hitorial_polizascod_activo: TIntegerField
      FieldName = 'cod_activo'
      Origin = 'act$poliza.cod_activo'
    end
    object hitorial_polizasvalor_asegurado: TIBBCDField
      FieldName = 'valor_asegurado'
      Origin = 'act$poliza.valor_asegurado'
      currency = True
      Precision = 18
      Size = 2
    end
    object hitorial_polizasdescripcion: TIBStringField
      FieldName = 'descripcion'
      Origin = 'act$tipo_poliza.descripcion'
      Size = 100
    end
    object hitorial_polizasdescripcion1: TIBStringField
      FieldName = 'descripcion1'
      Origin = 'act$aseguradora.descripcion'
      Size = 60
    end
  end
  object datahistorial_poliza: TDataSource
    DataSet = hitorial_polizas
    Top = 224
  end
  object DataActpoliza: TDataSource
    DataSet = IbActpoliza
    Left = 120
    Top = 8
  end
  object IbActpoliza: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    OnPostError = IbActpolizaPostError
    DeleteSQL.Strings = (
      'delete from "act$poliza"'
      'where'
      '  "act$poliza"."cod_poliza" = :"OLD_cod_poliza" and'
      '  "act$poliza"."tipo_poliza" = :"OLD_tipo_poliza"')
    InsertSQL.Strings = (
      'insert into "act$poliza"'
      
        '  ("act$poliza"."cod_poliza", "act$poliza"."tipo_poliza", "act$p' +
        'oliza"."fecha_inicio", '
      
        '   "act$poliza"."fecha_vencimiento", "act$poliza"."cod_activo", ' +
        '"act$poliza"."valor_asegurado", '
      '   "act$poliza"."nit_seguro", "act$poliza"."vencido")'
      'values'
      
        '  (:"cod_poliza", :"tipo_poliza", :"fecha_inicio", :"fecha_venci' +
        'miento", '
      '   :"cod_activo", :"valor_asegurado", :"nit_seguro", :"vencido")')
    RefreshSQL.Strings = (
      'Select '
      '  "act$poliza"."cod_poliza",'
      '  "act$poliza"."tipo_poliza",'
      '  "act$poliza"."fecha_inicio",'
      '  "act$poliza"."fecha_vencimiento",'
      '  "act$poliza"."cod_activo",'
      '  "act$poliza"."valor_asegurado",'
      '  "act$poliza"."nit_seguro",'
      '  "act$poliza"."vencido"'
      'from "act$poliza" '
      'where'
      '  "act$poliza"."cod_poliza" = :"cod_poliza" and'
      '  "act$poliza"."tipo_poliza" = :"tipo_poliza"')
    SelectSQL.Strings = (
      'Select '
      '  "act$poliza"."cod_poliza",'
      '  "act$poliza"."tipo_poliza",'
      '   "act$poliza"."fecha_inicio",'
      '  "act$poliza"."fecha_vencimiento",'
      '  "act$poliza"."cod_activo",'
      '  "act$poliza"."valor_asegurado",'
      '   "act$poliza"."nit_seguro",'
      '    "act$poliza"."vencido"'
      'from "act$poliza","act$tipo_poliza"'
      'where "act$poliza"."cod_poliza"=:"poliza"'
      '')
    ModifySQL.Strings = (
      'update "act$poliza"'
      'set'
      '  "act$poliza"."cod_poliza" = :"cod_poliza",'
      '  "act$poliza"."tipo_poliza" = :"tipo_poliza",'
      '  "act$poliza"."fecha_inicio" = :"fecha_inicio",'
      '  "act$poliza"."fecha_vencimiento" = :"fecha_vencimiento",'
      '  "act$poliza"."cod_activo" = :"cod_activo",'
      '  "act$poliza"."valor_asegurado" = :"valor_asegurado",'
      '  "act$poliza"."nit_seguro" = :"nit_seguro",'
      '  "act$poliza"."vencido" = :"vencido"'
      'where'
      '  "act$poliza"."cod_poliza" = :"OLD_cod_poliza" and'
      '  "act$poliza"."tipo_poliza" = :"OLD_tipo_poliza"')
    Left = 184
    Top = 8
    object IbActpolizacod_poliza: TIntegerField
      FieldName = 'cod_poliza'
      Origin = 'act$poliza.cod_poliza'
      Required = True
    end
    object IbActpolizatipo_poliza: TSmallintField
      FieldName = 'tipo_poliza'
      Origin = 'act$poliza.tipo_poliza'
    end
    object IbActpolizafecha_inicio: TDateField
      ConstraintErrorMessage = 'error'
      FieldName = 'fecha_inicio'
      Origin = 'act$poliza.fecha_inicio'
      OnValidate = IbActpolizafecha_inicioValidate
      DisplayFormat = 'dd/mm/yyyy'
      EditMask = '90/90/0000;1;_'
    end
    object IbActpolizafecha_vencimiento: TDateField
      FieldName = 'fecha_vencimiento'
      Origin = 'act$poliza.fecha_vencimiento'
      DisplayFormat = 'dd/mm/yy'
      EditMask = '90/90/0000;1;_'
    end
    object IbActpolizacod_activo: TIntegerField
      FieldName = 'cod_activo'
      Origin = 'act$poliza.cod_activo'
    end
    object IbActpolizavalor_asegurado: TIBBCDField
      FieldName = 'valor_asegurado'
      Origin = 'act$poliza.valor_asegurado'
      currency = True
      Precision = 18
      Size = 2
    end
    object IbActpolizanombre_poliza: TStringField
      FieldKind = fkLookup
      FieldName = 'nombre_poliza'
      LookupDataSet = tipo_polizas
      LookupKeyFields = 'cod_tipopoliza'
      LookupResultField = 'descripcion'
      KeyFields = 'tipo_poliza'
      Lookup = True
    end
    object IbActpolizanit_seguro: TIBBCDField
      FieldName = 'nit_seguro'
      Origin = 'act$poliza.nit_seguro'
      Required = True
      Precision = 18
      Size = 1
    end
    object IbActpolizaseguro: TStringField
      FieldKind = fkLookup
      FieldName = 'seguro'
      LookupDataSet = IbAseguradora
      LookupKeyFields = 'nit_aseguradora'
      LookupResultField = 'descripcion'
      KeyFields = 'nit_seguro'
      Size = 30
      Lookup = True
    end
    object IbActpolizavencido: TSmallintField
      FieldName = 'vencido'
      Origin = 'act$poliza.vencido'
    end
  end
  object IbAseguradora: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      'select * from "act$aseguradora"')
    Left = 214
    Top = 112
  end
  object ibcod_poliza: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      
        'select max("act$poliza"."cod_poliza") as codigo from "act$poliza' +
        '"')
    Left = 120
    Top = 58
    object ibcod_polizaCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
  end
  object dtipo: TDataSource
    DataSet = tipo_polizas
    Left = 88
    Top = 160
  end
  object DSEntrega: TDataSource
    DataSet = IBentrega
    Left = 160
    Top = 232
  end
  object IBentrega: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    OnPostError = IBentregaPostError
    DeleteSQL.Strings = (
      'delete from "act$traslado"'
      'where'
      '  "act$traslado"."cod_traslado" = :"OLD_cod_traslado" and'
      '  "act$traslado"."fecha_traslado" = :"OLD_fecha_traslado" and'
      '  "act$traslado"."nit_empleado" = :"OLD_nit_empleado" and'
      '  "act$traslado"."cod_oficina" = :"OLD_cod_oficina" and'
      '  "act$traslado"."cod_seccion" = :"OLD_cod_seccion" and'
      '  "act$traslado"."cod_activo" = :"OLD_cod_activo" and'
      '  "act$traslado"."forma_traslado" = :"OLD_forma_traslado" and'
      '  "act$traslado"."identificador" = :"OLD_identificador" and'
      '  "act$traslado"."lugar" = :"OLD_lugar" and'
      '  "act$traslado"."tipotraslado" = :"OLD_tipotraslado"')
    InsertSQL.Strings = (
      'insert into "act$traslado"'
      
        '  ("act$traslado"."cod_traslado", "act$traslado"."fecha_traslado' +
        '", "act$traslado"."nit_empleado", '
      
        '   "act$traslado"."cod_oficina", "act$traslado"."cod_seccion", "' +
        'act$traslado"."cod_activo", '
      
        '   "act$traslado"."forma_traslado", "act$traslado"."identificado' +
        'r", "act$traslado"."lugar", '
      '   "act$traslado"."tipotraslado")'
      'values'
      
        '  (:"cod_traslado", :"fecha_traslado", :"nit_empleado", :"cod_of' +
        'icina", '
      
        '   :"cod_seccion", :"cod_activo", :"forma_traslado", :"identific' +
        'ador", '
      '   :"lugar", :"tipotraslado")')
    RefreshSQL.Strings = (
      'Select '
      '  "act$traslado"."cod_traslado",'
      '  "act$traslado"."fecha_traslado",'
      '  "act$traslado"."nit_empleado",'
      '  "act$traslado"."cod_oficina",'
      '  "act$traslado"."cod_seccion",'
      '  "act$traslado"."cod_activo",'
      '  "act$traslado"."tipo_traslado",'
      '  "act$traslado"."fecha_reintegro",'
      '  "act$traslado"."forma_traslado",'
      '  "act$traslado"."motivo",'
      '  "act$traslado"."identificador",'
      '  "act$traslado"."estado",'
      '  "act$traslado"."lugar",'
      '  "act$traslado"."tipotraslado"'
      'from "act$traslado" '
      'where'
      '  "act$traslado"."cod_traslado" = :"cod_traslado" and'
      '  "act$traslado"."fecha_traslado" = :"fecha_traslado" and'
      '  "act$traslado"."nit_empleado" = :"nit_empleado" and'
      '  "act$traslado"."cod_oficina" = :"cod_oficina" and'
      '  "act$traslado"."cod_seccion" = :"cod_seccion" and'
      '  "act$traslado"."cod_activo" = :"cod_activo" and'
      '  "act$traslado"."forma_traslado" = :"forma_traslado" and'
      '  "act$traslado"."identificador" = :"identificador" and'
      '  "act$traslado"."lugar" = :"lugar" and'
      '  "act$traslado"."tipotraslado" = :"tipotraslado"')
    SelectSQL.Strings = (
      'SELECT DISTINCT '
      '  "act$traslado"."fecha_traslado",'
      '  "act$traslado"."nit_empleado",'
      '  "act$traslado"."cod_oficina",'
      '  "act$traslado"."cod_seccion",'
      '  "act$traslado"."cod_activo",'
      '  "act$traslado"."forma_traslado",'
      '  "act$traslado"."identificador",'
      '  "act$traslado"."lugar",'
      '  "act$traslado"."cod_traslado",'
      '  "act$traslado"."tipotraslado",'
      '  "act$activo"."placa",'
      '  "act$activo"."descripcion"'
      'FROM'
      '  "act$activo",'
      '  "act$traslado"'
      'WHERE'
      '  ("act$activo"."cod_activo" = :"cod") AND '
      '  ("act$activo"."cod_activo" = "act$traslado"."cod_activo")')
    ModifySQL.Strings = (
      'update "act$traslado"'
      'set'
      '  "act$traslado"."cod_traslado" = :"cod_traslado",'
      '  "act$traslado"."fecha_traslado" = :"fecha_traslado",'
      '  "act$traslado"."nit_empleado" = :"nit_empleado",'
      '  "act$traslado"."cod_oficina" = :"cod_oficina",'
      '  "act$traslado"."cod_seccion" = :"cod_seccion",'
      '  "act$traslado"."cod_activo" = :"cod_activo",'
      '  "act$traslado"."forma_traslado" = :"forma_traslado",'
      '  "act$traslado"."identificador" = :"identificador",'
      '  "act$traslado"."lugar" = :"lugar",'
      '  "act$traslado"."tipotraslado" = :"tipotraslado"'
      'where'
      '  "act$traslado"."cod_traslado" = :"OLD_cod_traslado" and'
      '  "act$traslado"."fecha_traslado" = :"OLD_fecha_traslado" and'
      '  "act$traslado"."nit_empleado" = :"OLD_nit_empleado" and'
      '  "act$traslado"."cod_oficina" = :"OLD_cod_oficina" and'
      '  "act$traslado"."cod_seccion" = :"OLD_cod_seccion" and'
      '  "act$traslado"."cod_activo" = :"OLD_cod_activo" and'
      '  "act$traslado"."forma_traslado" = :"OLD_forma_traslado" and'
      '  "act$traslado"."identificador" = :"OLD_identificador" and'
      '  "act$traslado"."lugar" = :"OLD_lugar" and'
      '  "act$traslado"."tipotraslado" = :"OLD_tipotraslado"')
    Left = 56
    Top = 288
    object IBentregafecha_traslado: TDateField
      FieldName = 'fecha_traslado'
      Origin = 'act$traslado.fecha_traslado'
    end
    object IBentreganit_empleado: TIntegerField
      FieldName = 'nit_empleado'
      Origin = 'act$traslado.nit_empleado'
    end
    object IBentregacod_oficina: TSmallintField
      FieldName = 'cod_oficina'
      Origin = 'act$traslado.cod_oficina'
    end
    object IBentregacod_seccion: TSmallintField
      FieldName = 'cod_seccion'
      Origin = 'act$traslado.cod_seccion'
    end
    object IBentregacod_activo: TIntegerField
      FieldName = 'cod_activo'
      Origin = 'act$traslado.cod_activo'
    end
    object IBentregaforma_traslado: TIBStringField
      FieldName = 'forma_traslado'
      Origin = 'act$traslado.forma_traslado'
    end
    object IBentregaidentificador: TIBStringField
      FieldName = 'identificador'
      Origin = 'act$traslado.identificador'
      FixedChar = True
      Size = 1
    end
    object IBentregalugar: TIBStringField
      FieldName = 'lugar'
      Origin = 'act$traslado.lugar'
      FixedChar = True
      Size = 1
    end
    object IBentregacod_traslado: TSmallintField
      FieldName = 'cod_traslado'
      Origin = 'act$traslado.cod_traslado'
      Required = True
    end
    object IBentregaplaca: TIBStringField
      FieldName = 'placa'
      Origin = 'act$activo.placa'
      OnValidate = IBentregaplacaValidate
      FixedChar = True
      Size = 10
    end
    object IBentregadescripcion: TIBStringField
      FieldName = 'descripcion'
      Origin = 'act$activo.descripcion'
      Size = 250
    end
    object IBentregatipotraslado: TIBStringField
      FieldName = 'tipotraslado'
      Origin = 'act$traslado.tipotraslado'
      FixedChar = True
      Size = 1
    end
  end
  object DSseccion: TDataSource
    DataSet = IBseccion
    Left = 136
    Top = 160
  end
  object IBseccion: TIBDataSet
    Database = DataGeneral.IBDatabase1
    Transaction = DataGeneral.IBTransaction1
    SelectSQL.Strings = (
      'select * from "inv$dependencia"')
    Left = 200
    Top = 160
  end
end
