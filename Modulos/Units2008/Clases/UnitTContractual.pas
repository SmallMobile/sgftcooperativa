unit UnitTContractual;

Interface
uses SysUtils,Dialogs,UnitGlobal,DB, IBDatabase, IBCustomDataSet, IBQuery, DBClient,
     JclSysUtils;
  type
  TContractual = Class
  Private
    _sDescripcion :string;
    _iPlazo :Integer;
    _cPorcentaje :string;
    _iEstado :Smallint;
    _IBDatabase1: TIBDatabase;
  public
  property Descripcion :string write _sDescripcion;
  property Plazo :Integer write _iPlazo;
  property Porcentaje :string write _cPorcentaje;
  property IBDatabase1: TIBDatabase write _IBDatabase1;
  property Estado :Smallint write _iEstado;
  procedure SelectContractual(CdDataset:TClientDataSet);
end;

implementation
procedure TContractual.SelectContractual(CdDataset: TClientDataSet);
var IBquery1 : TIBQuery;
  IBTransaction1: TIBTransaction;
begin
     Cddataset.CancelUpdates;
     IBTransaction1 := TIBTransaction.Create(nil);
     IBtransaction1.DefaultDatabase := _IbDatabase1;
     IBtransaction1.DefaultAction := TARollback;
     IBquery1 := TIBQuery.Create(nil);
     with Ibquery1 do
     begin
       Database := _IBdatabase1;
       Transaction := IBtransaction1;
       Close;
       SQL.Clear;
       SQL.Add('SELECT * FROM "cap$tiposplancontractual" WHERE ACTIVO = 1 ORDER BY ID_PLAN');
       Open;
       while not Eof  do
       begin
         CdDataset.Append;
         CdDataset.FieldValues['ID_PLAN'] := FieldByName('ID_PLAN').AsInteger;
         CdDataset.FieldValues['DESCRIPCION'] := FieldByName('DESCRIPCION').AsString;
         CdDataset.FieldValues['PLAZO'] := FieldByName('PLAZO').AsInteger;
         CdDataset.FieldValues['PORCENTAJE'] := FieldByName('CUOTAS').AsCurrency;
         CdDataset.FieldValues['ACTIVO'] := IntToBool(FieldByName('ACTIVO').AsInteger);
         CdDataset.Post;
         Next;
       end;
     end;
end;
end.

