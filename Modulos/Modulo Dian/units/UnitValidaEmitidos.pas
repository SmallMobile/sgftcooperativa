unit UnitValidaEmitidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DateUtils,
  Dialogs, StdCtrls, DB, IBCustomDataSet, IBQuery, DBClient, Grids, DBGrids, strUtils,DataSetToExcel,
  ComCtrls, JvEdit, JvTypedEdit;

type
  TFrmValidaEmitidos = class(TForm)
    btnProcesar: TButton;
    IBSelect: TIBQuery;
    IBConsulta: TIBQuery;
    CdFechas: TClientDataSet;
    CdFechasVALOR: TCurrencyField;
    CdFechasIDPERSONA: TStringField;
    CdFechasFECHAV: TDateField;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    CDDATOS: TClientDataSet;
    CDDATOSNUMERO: TStringField;
    CDDATOSIDPERSONA: TStringField;
    CDDATOSIDIDENTIFICACION: TIntegerField;
    CDDATOSINICIAL: TCurrencyField;
    CDDATOSINVERSION: TCurrencyField;
    CDDATOSINTERES: TCurrencyField;
    CDDATOSSALDO: TCurrencyField;
    CDDATOSFECHAA: TDateField;
    CDDATOSFECHAV: TDateField;
    CDDATOSESTADO: TStringField;
    CdFechasIDIDENTIFICACION: TIntegerField;
    IBInserta: TIBQuery;
    btnGeneraExcel: TButton;
    IB: TIBQuery;
    IBCon: TIBQuery;
    cdCdat: TClientDataSet;
    cdCdatTIPO: TStringField;
    cdCdatNUMERO: TStringField;
    cdCdatDV: TStringField;
    cdCdatPAPELLIDO: TStringField;
    cdCdatSAPELLIDO: TStringField;
    cdCdatPNOMBRE: TStringField;
    cdCdatSNOMBRE: TStringField;
    cdCdatRZ: TStringField;
    cdCdatDIRECCION: TStringField;
    cdCdatDPTO: TStringField;
    cdCdatMNCP: TStringField;
    cdCdatVALORINICIAL: TCurrencyField;
    cdCdatINVERSION: TCurrencyField;
    cdCdatINTERES: TCurrencyField;
    cdCdatSALDO: TCurrencyField;
    cdCdatCUENTA: TStringField;
    cdCdatTIT: TStringField;
    save: TSaveDialog;
    Button3: TButton;
    Edit1: TEdit;
    fecha: TDateTimePicker;
    IBq1: TIBQuery;
    btnTotalAExcel: TButton;
    IBConTotal: TIBQuery;
    Label1: TLabel;
    Label2: TLabel;
    EdMonto: TJvCurrencyEdit;
    procedure btnProcesarClick(Sender: TObject);
    procedure btnGeneraExcelClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnTotalAExcelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  function ValidaCdat(_iIdentificacion:Integer;_sIdPersona,_sCuenta:string):Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmValidaEmitidos: TFrmValidaEmitidos;

implementation

uses unitMain, unitGlobales;

{$R *.dfm}

procedure TFrmValidaEmitidos.btnProcesarClick(Sender: TObject);
var     _cInversion :Currency;
        _cInversionAnt :Currency;
        _cInversionRes :Currency;
        _cFechaFinal :TDate;
begin
        CdFechas.CancelUpdates;
        if IBSelect.Transaction.InTransaction then
           IBSelect.Transaction.Commit;
        IBSelect.Transaction.StartTransaction;
        IBSelect.Close;
        IBSelect.SQL.Clear;
        IBSelect.SQL.Add('delete FROM "dian$cdatreal"');
        IBSelect.ExecSQL;
        IBSelect.Transaction.Commit;
        IBSelect.Transaction.StartTransaction;
        IBSelect.Close;
        IBSelect.SQL.Clear;
        IBSelect.SQL.Add('select sum(INVERSION+INICIAL) AS VALOR,IDPERSONA,FECHAV,IDIDENTIFICACION FROM "dian$cdat" WHERE ESTADO = :ESTADO GROUP BY IDPERSONA,FECHAV,IDIDENTIFICACION');
        IBSelect.ParamByName('ESTADO').AsString := 'SALDADO';
        IBSelect.Open;
        while not IBSelect.Eof do
        begin
          CdFechas.Append;
          CdFechas.FieldValues['VALOR'] := IBSelect.FieldByName('VALOR').AsCurrency;
          CdFechas.FieldValues['IDPERSONA'] := IBSelect.FieldByName('IDPERSONA').AsString;
          CdFechas.FieldValues['FECHAV'] := IBSelect.FieldByName('FECHAV').AsDateTime;
          CdFechas.FieldValues['IDIDENTIFICACION'] := IBSelect.FieldByName('IDIDENTIFICACION').AsInteger;
          CdFechas.Post;
          IBSelect.Next;
        end;
        //Validar Información de Cdats por persona
        IBSelect.SQL.Clear;
        IBSelect.Close;
        IBSelect.SQL.Add('select DISTINCT IDPERSONA,IDIDENTIFICACION from "dian$cdat"');
        //IBSelect.SQL.Add('where IDPERSONA = ' + QuotedStr('12686420'));
        IBSelect.Open;
        while not IBSelect.Eof do
        begin
          IBConsulta.Close;
          IBConsulta.ParamByName('IDPERSONA').AsString := IBSelect.FieldByName('IDPERSONA').AsString;
          IBConsulta.ParamByName('IDIDENTIFICACION').AsInteger := IBSelect.FieldByName('IDIDENTIFICACION').AsInteger;
          IBConsulta.Open;
          while not IBConsulta.Eof do
          begin
            if LeftStr(IBConsulta.FieldByName('CUENTA').AsString,1) = '6' then
            begin
              _cFechaFinal := IBConsulta.FieldByName('FECHA').AsDateTime + 3;
              CdFechas.Filtered := False;
              CdFechas.Filter := 'IDIDENTIFICACION = ' + IBSelect.FieldByName('IDIDENTIFICACION').AsString + ' AND ' +
                                 'IDPERSONA = ' + QuotedStr(IBSelect.FieldByName('IDPERSONA').AsString)+ ' AND ' +
                                 'FECHAV >= ' + QuotedStr(DateToStr(IBConsulta.FieldByName('FECHA').AsDateTime -1)) + ' AND FECHAV <= ' + QuotedStr(DateToStr(IBConsulta.FieldByName('FECHA').AsDateTime));
                                 //'FECHAV = ' + QuotedStr(IBConsulta.FieldByName('FECHA').AsString);
              CdFechas.Filtered := True;
              _cInversionAnt := CdFechas.FieldByName('VALOR').AsCurrency;
              if _cInversionAnt > 0 then
              begin
                _cInversion := IBConsulta.FieldByName('INVERSION').AsCurrency - _cInversionAnt;
                if _cInversion < 0 then
                begin
                   _cInversionRes  := _cInversion * -1;
                   _cInversion := 0;
                end
                else
                  _cInversionRes := 0;
                CdFechas.Filtered := False;
                CdFechas.Filter := 'IDIDENTIFICACION = ' + IBSelect.FieldByName('IDIDENTIFICACION').AsString + ' AND ' +
                               'IDPERSONA = ' + QuotedStr(IBSelect.FieldByName('IDPERSONA').AsString)+ ' AND ' +
                               'FECHAV >= ' + QuotedStr(DateToStr(IBConsulta.FieldByName('FECHA').AsDateTime -1)) + ' AND FECHAV <= ' + QuotedStr(DateToStr(IBConsulta.FieldByName('FECHA').AsDateTime));                               
                               //'FECHAV = ' + QuotedStr(IBConsulta.FieldByName('FECHA').AsString);
                CdFechas.Filtered := True;
                CdFechas.Edit;
                CdFechas.FieldValues['VALOR'] := _cInversionRes;
                CdFechas.Post;
              end
              else
                _cInversion := IBConsulta.FieldByName('INVERSION').AsCurrency;
            end
            else
              _cInversion := IBConsulta.FieldByName('INVERSION').AsCurrency;
            // Validación cdats con saldo 0 y prorrogados
            if (IBConsulta.FieldByName('ESTADO').AsString = 'PRORROGADO') and (IBConsulta.FieldByName('SALDO').AsCurrency <= 0) then
            begin
              IBConsulta.Next;
            end
            else
            begin
              IBInserta.Close;
              IBInserta.ParamByName('CUENTA').AsString := IBConsulta.FieldByName('CUENTA').AsString;
              IBInserta.ParamByName('IDPERSONA').AsString := IBConsulta.FieldByName('IDPERSONA').AsString;
              IBInserta.ParamByName('IDIDENTIFICACION').AsInteger := IBConsulta.FieldByName('IDIDENTIFICACION').AsInteger;
              IBInserta.ParamByName('INICIAL').AsCurrency := IBConsulta.FieldByName('INICIAL').AsCurrency;
              IBInserta.ParamByName('INVERSION').AsCurrency := _cInversion;
              IBInserta.ParamByName('INTERES').AsCurrency := IBConsulta.FieldByName('INTERES').AsCurrency;
              IBInserta.ParamByName('SALDO').AsCurrency := IBConsulta.FieldByName('SALDO').AsCurrency;
              try
                IBInserta.ParamByName('FECHA').AsDateTime := IBConsulta.FieldByName('FECHA').AsDateTime;
              except
                IBInserta.ParamByName('FECHA').Clear;
              end;
              try
                IBInserta.ParamByName('FECHAV').AsDateTime := IBConsulta.FieldByName('FECHAV').AsDateTime;
              except
                IBInserta.ParamByName('FECHAV').Clear;
              end;
              IBInserta.ParamByName('ESTADO').AsString := IBConsulta.FieldByName('ESTADO').AsString;
              IBInserta.ExecSQL;
              IBConsulta.Next;
            end;
            //Fin Validación cdats Prorrogados y con saldo 0
          end;
          IBSelect.Next;
        end;
        IBInserta.Transaction.Commit;
        IBInserta.Transaction.StartTransaction;
        with IBInserta do
        begin
          Close;
          SQL.Clear;
          SQL.Add('delete from "dian$nocdat"');
          ExecSQL;
          Transaction.Commit;
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO "dian$nocdat"');
          SQL.Add('select IDPERSONA, IDIDENTIFICACION,sum(inversion) from "dian$cdatreal" GROUP BY IDPERSONA,IDIDENTIFICACION');
          SQL.Add('having sum(inversion) < :MONTO');
          ParamByName('MONTO').AsCurrency := EdMonto.Value;
          ExecSQL;
          Transaction.Commit;
        end;
        CdFechas.Filtered := False;
end;

procedure TFrmValidaEmitidos.btnGeneraExcelClick(Sender: TObject);
var     _sTp :string; //Tipo Doc
        _sId :string; // Numero Doc
        _sDv :string; // Digito Verificación
        _sDpto :string;
        _sMcp :string;
        _sCodMunicipio :string;
        ExcelFile:TDataSetToExcel;
begin
        with IBSelect do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"dian$cdatreal".CUENTA,');
          SQL.Add('"dian$cdatreal".IDPERSONA,');
          SQL.Add('"dian$cdatreal".IDIDENTIFICACION,');
          SQL.Add('"dian$cdatreal".INICIAL,');
          SQL.Add('"dian$cdatreal".INVERSION,');
          SQL.Add('"dian$cdatreal".INTERES,');
          SQL.Add('"dian$cdatreal".SALDO,');
          SQL.Add('"dian$cdatreal".FECHA,');
          SQL.Add('"dian$cdatreal".FECHAV,');
          SQL.Add('"dian$cdatreal".ESTADO,');
          SQL.Add('"gen$persona".NOMBRE,');
          SQL.Add('"gen$persona".PRIMER_APELLIDO,');
          SQL.Add('"gen$persona".SEGUNDO_APELLIDO');
          SQL.Add('FROM');
          SQL.Add('"dian$cdatreal"');
          SQL.Add('INNER JOIN "gen$persona" ON ("dian$cdatreal".IDPERSONA = "gen$persona".ID_PERSONA)');
          SQL.Add('AND ("dian$cdatreal".IDIDENTIFICACION = "gen$persona".ID_IDENTIFICACION)');
          Open;
          while not Eof do
          begin
            if ValidaCdat(FieldByName('IDIDENTIFICACION').AsInteger,FieldByName('IDPERSONA').AsString,FieldByName('CUENTA').AsString) then
            begin
                 case FieldByName('IDIDENTIFICACION').AsInteger of
                     1: _stp := '11';
                     2: _stp := '12';
                     3: _stp := '13';
                     4: _stp := '31';
                     6: _stp := '22';
                     9: _stp := '11';
                  end;
                  cdCdat.Append;
                  cdCdat.FieldValues['TIPO'] := _sTp;
                    if _STp = '31' then
                    begin
                      _sId := LeftStr(FieldByName('IDPERSONA').AsString,Length(FieldByName('IDPERSONA').AsString)-1);
                      _sDv := RightStr(FieldByName('IDPERSONA').AsString,1);
                    end
                    else
                    begin
                      _sId := FieldByName('IDPERSONA').AsString;
                      _sDv := '';
                    end;
                 cdCdat.FieldValues['NUMERO'] := _sId;
                 cdCdat.FieldValues['DV'] := _sDv;
                 if _sTp <> '31' then
                 begin
                   cdCdat.FieldValues['PAPELLIDO'] := FieldByName('PRIMER_APELLIDO').AsString;
                   cdCdat.FieldValues['SAPELLIDO'] := FieldByName('SEGUNDO_APELLIDO').AsString;
                   cdCdat.FieldValues['PNOMBRE'] := LeftStr(FieldByName('NOMBRE').AsString,Pos(' ', FieldByName('NOMBRE').AsString)-1);
                   cdCdat.FieldValues['SNOMBRE'] := RightStr(FieldByName('NOMBRE').AsString,Length(FieldByName('NOMBRE').AsString) - Pos(' ', FieldByName('NOMBRE').AsString));
                 end
                 else
                   cdCdat.FieldValues['RZ'] := Trim(FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString + ' ' + FieldByName('NOMBRE').AsString);
                 IBCon.Close;
                 IBCon.ParamByName('IDPERSONA').AsString := FieldByName('IDPERSONA').AsString;
                 IBCon.ParamByName('IDIDENTIFICACION').AsInteger := FieldByName('IDIDENTIFICACION').AsInteger;
                 IBCon.Open;
                 cdCdat.FieldValues['DIRECCION'] := IBCon.FieldByName('DIRECCION').AsString;
                 _sCodMunicipio := IBCon.FieldByName('COD_MUNICIPIO').AsString;
                 //**
                 try
                 if StrLen(PChar(_sCodMunicipio)) = 4 then
                    _sCodMunicipio := '0' +  _sCodMunicipio;
                 _sDpto := FormatCurr('00',StrToInt(LeftStr(_sCodMunicipio,2)));
                 _sMcp := FormatCurr('000',StrToInt(RightStr(_sCodMunicipio,3)));
                 except
                 begin
                   _sDpto := '0';
                   _sMcp := '0';
                 end;
                 end;

                 //**
                 cdCdat.FieldValues['DPTO'] := _sDpto;
                 cdCdat.FieldValues['MNCP'] := _sMcp;
                 cdCdat.FieldValues['VALORINICIAL'] := FieldByName('INICIAL').AsCurrency;
                 cdCdat.FieldValues['INVERSION'] := FieldByName('INVERSION').AsCurrency;
                 cdCdat.FieldValues['INTERES'] := FieldByName('INTERES').AsCurrency;
                 if LeftStr(FieldByName('CUENTA').AsString,1) = '6' then
                     cdCdat.FieldValues['SALDO'] := FieldByName('SALDO').AsCurrency
                 else
                 begin
                    if FieldByName('ESTADO').AsString = 'SALDADO' then
                       cdCdat.FieldValues['SALDO'] := 0
                    else
                       cdCdat.FieldValues['SALDO'] := FieldByName('INVERSION').AsCurrency + FieldByName('INICIAL').AsCurrency;
                 end;
                 cdCdat.FieldValues['CUENTA'] := FieldByName('CUENTA').AsString;
                 cdCdat.FieldValues['TIT'] := 1;
                 {
                        cdCdat.FieldValues['FECHAA'] := FieldByName('FECHA').AsString;
                        if FieldByName('ESTADO').AsString = 'SALDADO' then
                        cdCdat.FieldValues['FECHAV'] := FieldByName('FECHAV').AsString
                         else
                        cdCdat.FieldValues['FECHAV'] := '';
                        cdCdat.FieldValues['ESTADO'] := FieldByName('ESTADO').AsString;
                        cdCdat.FieldValues['CIUDAD'] := IBCon.FieldByName('MUNICIPIO').AsString;
                 }
                 cdCdat.Post;
            end;
         Next;
       end;
      end;
        save.FileName := LowerCase(frmMain.DescAgencia);
        if Save.Execute then
        begin
          cdCdat.First;
          ExcelFile := TDataSetToExcel.Create(cdCdat,Save.FileName);
          ExcelFile.WriteFile;
          ExcelFile.Free;
        end;

end;

function TFrmValidaEmitidos.ValidaCdat(_iIdentificacion: Integer;
  _sIdPersona,_sCuenta: string): Boolean;
var
        _dFechav :TDate;
begin
        Result := False;
        with IB do
        begin
          Close;
          ParamByName('IDPERSONA').AsString := _sIdPersona;
          ParamByName('IDIDENTIFICACION').AsInteger := _iIdentificacion;
          Open;
          if RecordCount <= 0 then
             Result := True;
        end;
        if Result = True then
        begin
          with IBq1 do
          begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT');
            SQL.Add('"dian$cdatreal".FECHAV,');
            SQL.Add('"dian$cdatreal".ESTADO,');
            SQL.Add('"dian$cdatreal".FECHA');
            SQL.Add('FROM');
            SQL.Add('  "dian$cdatreal"');
            SQL.Add('WHERE');
            SQL.Add('  "dian$cdatreal".CUENTA = :CUENTA');
            ParamByName('CUENTA').AsString := _sCuenta;
            Open;
            if (FieldByName('ESTADO').AsString = 'SALDADO') and (FieldByName('FECHA').AsDateTime <= fecha.DateTime)   then
            begin
              _dFechav := FieldByName('FECHAV').AsDateTime;
              Close;
              SQL.Clear;
              SQL.Add('SELECT');
              SQL.Add('"dian$cdatreal".ESTADO');
              SQL.Add('FROM');
              SQL.Add('"dian$cdatreal"');
              SQL.Add('WHERE');
              SQL.Add('"dian$cdatreal".FECHA BETWEEN :FECHA1 AND :FECHA2 AND');
              SQL.Add('"dian$cdatreal".IDPERSONA = :IDPERSONA AND');
              SQL.Add('"dian$cdatreal".IDIDENTIFICACION = :IDIDENTIFICACION');
              ParamByName('FECHA1').AsDateTime := _dFechav -2;
              ParamByName('FECHA2').AsDateTime := _dFechav;
              ParamByName('IDPERSONA').AsString := _sIdPersona;
              ParamByName('IDIDENTIFICACION').AsInteger := _iIdentificacion;
              Open;
              if RecordCount = 0 then
                 Result := False;
            end;
          end;

        end;
        

end;

procedure TFrmValidaEmitidos.Button3Click(Sender: TObject);
begin
              CdFechas.Filtered := False;
              CdFechas.Filter := 'IDIDENTIFICACION = ' + '3' + ' AND ' +
                                 'IDPERSONA = ' + QuotedStr(Edit1.Text)+ ' AND ' +
                                 'FECHAV >= ' + QuotedStr(DateToStr(fecha.DateTime -2)) + ' AND FECHAV <= ' + QuotedStr(DateToStr(fecha.DateTime));
              CdFechas.Filtered := True;
              //ShowMessage(CdFechas.FieldByName('VALOR').AsString);



end;

procedure TFrmValidaEmitidos.btnTotalAExcelClick(Sender: TObject);
var     _sTp :string; //Tipo Doc
        _sId :string; // Numero Doc
        _sDv :string; // Digito Verificación
        _sDpto :string;
        _sMcp :string;
        _sCodMunicipio :string;
        ExcelFile:TDataSetToExcel;
begin
        with IBSelect do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"dian$cdatreal".CUENTA,');
          SQL.Add('"dian$cdatreal".IDPERSONA,');
          SQL.Add('"dian$cdatreal".IDIDENTIFICACION,');
          SQL.Add('"dian$cdatreal".INICIAL,');
          SQL.Add('"dian$cdatreal".INVERSION,');
          SQL.Add('"dian$cdatreal".INTERES,');
          SQL.Add('"dian$cdatreal".SALDO,');
          SQL.Add('"dian$cdatreal".FECHA,');
          SQL.Add('"dian$cdatreal".FECHAV,');
          SQL.Add('"dian$cdatreal".ESTADO,');
          SQL.Add('"gen$persona".NOMBRE,');
          SQL.Add('"gen$persona".PRIMER_APELLIDO,');
          SQL.Add('"gen$persona".SEGUNDO_APELLIDO');
          SQL.Add('FROM');
          SQL.Add('"dian$cdatreal"');
          SQL.Add('INNER JOIN "gen$persona" ON ("dian$cdatreal".IDPERSONA = "gen$persona".ID_PERSONA)');
          SQL.Add('AND ("dian$cdatreal".IDIDENTIFICACION = "gen$persona".ID_IDENTIFICACION)');
          Open;
          while not Eof do
          begin
            if ValidaCdat(FieldByName('IDIDENTIFICACION').AsInteger,FieldByName('IDPERSONA').AsString,FieldByName('CUENTA').AsString) then
            begin
                 case FieldByName('IDIDENTIFICACION').AsInteger of
                     1: _stp := '11';
                     2: _stp := '12';
                     3: _stp := '13';
                     4: _stp := '31';
                     6: _stp := '22';
                     9: _stp := '11';
                  end;
                  cdCdat.Append;
                  cdCdat.FieldValues['TIPO'] := _sTp;
                    if _STp = '31' then
                    begin
                      _sId := LeftStr(FieldByName('IDPERSONA').AsString,Length(FieldByName('IDPERSONA').AsString)-1);
                      _sDv := RightStr(FieldByName('IDPERSONA').AsString,1);
                    end
                    else
                    begin
                      _sId := FieldByName('IDPERSONA').AsString;
                      _sDv := '';
                    end;
                 cdCdat.FieldValues['NUMERO'] := _sId;
                 cdCdat.FieldValues['DV'] := _sDv;
                 if _sTp <> '31' then
                 begin
                   cdCdat.FieldValues['PAPELLIDO'] := FieldByName('PRIMER_APELLIDO').AsString;
                   cdCdat.FieldValues['SAPELLIDO'] := FieldByName('SEGUNDO_APELLIDO').AsString;
                   cdCdat.FieldValues['PNOMBRE'] := LeftStr(FieldByName('NOMBRE').AsString,Pos(' ', FieldByName('NOMBRE').AsString)-1);
                   cdCdat.FieldValues['SNOMBRE'] := RightStr(FieldByName('NOMBRE').AsString,Length(FieldByName('NOMBRE').AsString) - Pos(' ', FieldByName('NOMBRE').AsString));
                 end
                 else
                   cdCdat.FieldValues['RZ'] := Trim(FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString + ' ' + FieldByName('NOMBRE').AsString);
                 IBConTotal.Close;
                 IBConTotal.ParamByName('IDPERSONA').AsString := FieldByName('IDPERSONA').AsString;
                 IBConTotal.ParamByName('IDIDENTIFICACION').AsInteger := FieldByName('IDIDENTIFICACION').AsInteger;
                 IBConTotal.Open;
                 cdCdat.FieldValues['DIRECCION'] := IBConTotal.FieldByName('DIRECCION').AsString;
                 _sDpto := IBConTotal.FieldByName('DPTO').AsString;
                 _sMcp := IBConTotal.FieldByName('MCP').AsString;

                 //**
                 cdCdat.FieldValues['DPTO'] := _sDpto;
                 cdCdat.FieldValues['MNCP'] := _sMcp;
                 cdCdat.FieldValues['VALORINICIAL'] := FieldByName('INICIAL').AsCurrency;
                 cdCdat.FieldValues['INVERSION'] := FieldByName('INVERSION').AsCurrency;
                 cdCdat.FieldValues['INTERES'] := FieldByName('INTERES').AsCurrency;
                 if LeftStr(FieldByName('CUENTA').AsString,1) = '6' then
                     cdCdat.FieldValues['SALDO'] := FieldByName('SALDO').AsCurrency
                 else
                 begin
                    if FieldByName('ESTADO').AsString = 'SALDADO' then
                       cdCdat.FieldValues['SALDO'] := 0
                    else
                       cdCdat.FieldValues['SALDO'] := FieldByName('INVERSION').AsCurrency + FieldByName('INICIAL').AsCurrency;
                 end;
                 cdCdat.FieldValues['CUENTA'] := FieldByName('CUENTA').AsString;
                 cdCdat.FieldValues['TIT'] := 1;
                 {
                        cdCdat.FieldValues['FECHAA'] := FieldByName('FECHA').AsString;
                        if FieldByName('ESTADO').AsString = 'SALDADO' then
                        cdCdat.FieldValues['FECHAV'] := FieldByName('FECHAV').AsString
                        else
                        cdCdat.FieldValues['FECHAV'] := '';
                        cdCdat.FieldValues['ESTADO'] := FieldByName('ESTADO').AsString;
                        cdCdat.FieldValues['CIUDAD'] := '';
                 }
                 cdCdat.Post;
            end;
         Next;
       end;
      end;
        save.FileName := LowerCase(frmMain.DescAgencia);
        if Save.Execute then
        begin
          cdCdat.First;
          ExcelFile := TDataSetToExcel.Create(cdCdat,Save.FileName);
          ExcelFile.WriteFile;
          ExcelFile.Free;
        end;



end;

procedure TFrmValidaEmitidos.FormCreate(Sender: TObject);
begin
        fecha.Date := EncodeDate(YearOf(fFechaActual) - 1, 12 , 31);
end;

end.
