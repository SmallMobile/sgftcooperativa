object Form1: TForm1
  Left = 242
  Top = 156
  Width = 525
  Height = 375
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 312
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 200
    Top = 192
    Width = 177
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Database1: TDatabase
    DatabaseName = 'foxpro'
    DriverName = 'Microsoft FoxPro VFP Driver (*.'
    KeepConnection = False
    LoginPrompt = False
    SessionName = 'Default'
    Left = 312
    Top = 32
  end
  object Session1: TSession
    Left = 360
    Top = 32
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;Mode=Read;Extende' +
      'd Properties="DSN=Visual FoxPro Database;UID=;SourceDB=\\Winserv' +
      'er\CONVENIO\Data\equivida.dbc;SourceType=DBC;Exclusive=No;Backgr' +
      'oundFetch=Yes;Collate=Machine;Null=Yes;Deleted=Yes;"'
    LoginPrompt = False
    Mode = cmRead
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 96
    Top = 104
  end
  object Query1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from "equivida" where  "equivida".numdocum = '#39'5035698'#39)
    Left = 96
    Top = 72
  end
end
