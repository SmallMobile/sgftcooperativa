unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponent, JvSimpleXml, StdCtrls, JvCtrls, IBDatabase, DB,
  IBCustomDataSet, IBQuery, DBClient, IBSQL,Math;

type
  TForm1 = class(TForm)
    xml: TJvSimpleXml;
    IBDatabase1: TIBDatabase;
    IBconsulta: TIBQuery;
    IBTransaction1: TIBTransaction;
    CdSolicitud: TClientDataSet;
    CdSolicitudID_SOLICITUD: TStringField;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    xml1: TJvSimpleXml;
    CDcartera: TClientDataSet;
    CDcarteraID_COLOCACION: TStringField;
    JvImgBtn1: TJvImgBtn;
    Button1: TButton;
    IBInsertar: TIBQuery;
    IBDatabase2: TIBDatabase;
    IBTransaction2: TIBTransaction;
    IBSQL1: TIBSQL;
    IBSQL2: TIBSQL;
    procedure JvImgBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  nRegistro,nCampo: TJvSimpleXmlElem;
  nodo :TJvSimpleXmlElems;
  vId_Persona :string;
  vId_Identificacion :Integer;
  vAnalista :string;
  AgenciaT:Integer;
  procedure EvaluarCapital(Saldo:Currency);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  CortoPlazo,LargoPlazo:Currency;

implementation

uses UnitGlobales;

{$R *.dfm}

procedure TForm1.JvImgBtn1Click(Sender: TObject);
var     i :Integer;
        vTabla :Boolean;
        vContador :Integer;
begin
// Inicio Traslado de Solicitudes
        AgenciaT := 4;
        CdSolicitud.CancelUpdates;
        vAnalista := 'WURIBE';
        vContador := 1;
        vTabla := False;
        vId_Persona := Edit1.Text;
        vId_Identificacion := 3;
        with IBconsulta do
        begin
          xml.LoadFromString('');
          xml.Root.Name := 'Traslado';
          SQL.Clear;
          SQL.Add('select * from "col$solicitud" where ID_PERSONA = :ID_PERSONA and ID_IDENTIFICACION = :ID_IDENTIFICACION');
          ParamByName('ID_PERSONA').AsString := vId_Persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vId_Identificacion;
          Open;
          if RecordCount > 0 then //registro de solicitudes
          begin
              nRegistro  := xml.Root.Items.Add('tabla');
              nRegistro.Properties.Add('nombre','col$solicitud');
            while not Eof do
            begin
              nCampo := nRegistro.Items.Add('Registro');
              for i := 0 to FieldDefs.Count -1 do
                 nCampo.Items.Add('campo',Fields.Fields[i].AsString);
              CdSolicitud.Append;
              CdSolicitud.FieldValues['ID_SOLICITUD'] := FieldByName('ID_SOLICITUD').AsString;
              CdSolicitud.Post;
              Next;
            end;
          end; //fin registro de solicitudes
          // busqueda de codeudores
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$codeudor" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$codeudor');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin del registra codeudor
          // busqueda de conyuges
          vTabla := False;
          vContador := 0;
          SQL.Clear;
          SQL.Add('select * from "col$infconyuge" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$infconyuge');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin del registra conyuges
          // busqueda de referencias
          Close;
          SQL.Clear;
          SQL.Add('select * from "col$referencias" where ID_PERSONA = :ID_PERSONA  and ID_IDENTIFICACION = :ID_IDENTIFICACION');
          ParamByName('ID_PERSONA').AsString := vId_Persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vId_Identificacion;
          Open;
          if RecordCount > 0 then //registro de solicitudes
          begin
              nRegistro  := xml.Root.Items.Add('tabla');
              nRegistro.Properties.Add('nombre','col$referencias');
            while not Eof do
            begin
              nCampo := nRegistro.Items.Add('Registro');
              for i := 0 to FieldDefs.Count -1 do
                 nCampo.Items.Add('campo',Fields.Fields[i].AsString);
              Next;
            end;
          end; //fin registro de referencias solicitud
          // busqueda entardas de las solicitudes
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$referenciasolicitud" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$referenciasolicitud');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin entradas de las solicitudes
          // busqueda registros de sesion
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$registrosesion" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$registrosesion');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                 begin
                   if FieldDefs.Items[i].DataType = fttime then
                      nCampo.Items.Add('campo',FormatDateTime('hh:mm:ss',Fields.Fields[i].AsDateTime))
                   else
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 end;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin consulta de registro de sesion
          // registro de la entrada de los analistas
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$solicitudanalista" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$solicitudanalista');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                 begin
                   if i = 2 then
                      nCampo.Items.Add('campo',vAnalista)
                   else
                   begin
                   if FieldDefs.Items[i].DataType = ftdatetime then
                      nCampo.Items.Add('campo',FormatDateTime('yyyy/mm/dd hh:mm:ss',Fields.Fields[i].AsDateTime))
                   else
                      nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                   end;
                 end;
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin consulta de los analista
          // consulta de los requisisitos
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$solicitudrequisito" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$solicitudrequisito');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin consulta de los requisistos
          // consulta de los requisisitos
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$observacion" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$observacion');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin consulta de la observaciones del analista
          // consulta bien raiz
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "gen$bienesraices" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','gen$bienesraices');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //consulta infromacion crediticia
          // consulta bien raiz
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "gen$infcrediticia" where ID_SOLICITUD = :ID_SOLICITUD');
          CdSolicitud.First;
          while not CdSolicitud.Eof do
          begin
             Close;
             ParamByName('ID_SOLICITUD').AsString := CdSolicitud.FieldByName('ID_SOLICITUD').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','gen$infcrediticia');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                   vContador := vContador + 1;
                 Next;
                end;
             end;
             CdSolicitud.Next;
          end; //fin consulta bien raiz
          Close;  // consulta de informacion de persona infpersona
          SQL.Clear;
          SQL.Add('select * from "gen$infpersona" where ID_PERSONA = :ID_PERSONA  and ID_IDENTIFICACION = :ID_IDENTIFICACION');
          ParamByName('ID_PERSONA').AsString := vId_Persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vId_Identificacion;
          Open;
          if RecordCount > 0 then //registro de solicitudes
          begin
              nRegistro  := xml.Root.Items.Add('tabla');
              nRegistro.Properties.Add('nombre','gen$infpersona');
            while not Eof do
            begin
              nCampo := nRegistro.Items.Add('Registro');
              for i := 0 to FieldDefs.Count -1 do
                 nCampo.Items.Add('campo',Fields.Fields[i].AsString);
              Next;
            end;
          end; //fin consulat de informacion adicional de la persona
          Close;// consulta de vehiculos
          SQL.Clear;
          SQL.Add('select * from "gen$vehiculo" where ID_PERSONA = :ID_PERSONA  and ID_IDENTIFICACION = :ID_IDENTIFICACION');
          ParamByName('ID_PERSONA').AsString := vId_Persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vId_Identificacion;
          Open;
          if RecordCount > 0 then //registro de solicitudes
          begin
              nRegistro  := xml.Root.Items.Add('tabla');
              nRegistro.Properties.Add('nombre','gen$vehiculo');
            while not Eof do
            begin
              nCampo := nRegistro.Items.Add('Registro');
              for i := 0 to FieldDefs.Count -1 do
                 nCampo.Items.Add('campo',Fields.Fields[i].AsString);
              Next;
            end;
          end; //fin consulta de vehiculos
//          xml.SaveToFile('c:\ejemplo.xml');
// Fin Traslado de Solicitudes


// Inicio Traslado de Cartera
          CDcartera.CancelUpdates;
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$colocacion" where ID_PERSONA = :ID_PERSONA and ID_IDENTIFICACION = :ID_IDENTIFICACION and ID_ESTADO_COLOCACION IN (0,2,3,8,9)');
          ParamByName('ID_PERSONA').AsString := vId_Persona;
          ParamByName('ID_IDENTIFICACION').AsInteger := vId_Identificacion;
          Open;

          if RecordCount > 0 then //registro de Colocaciones
          begin
              nRegistro  := xml.Root.Items.Add('tabla');
              nRegistro.Properties.Add('nombre','col$colocacion');
            while not Eof do
            begin
              nCampo := nRegistro.Items.Add('Registro');
              for i := 0 to FieldDefs.Count -1 do
                 if i = 0 then
                  nCampo.Items.Add('campo',AgenciaT)
                 else
                  nCampo.Items.Add('campo',Fields.Fields[i].AsString);

              IBSQL1.SQL.Clear;
              IBSQL1.SQL.Add('select * from "col$codigospuc" where ID_CLASIFICACION = :"ID_CLASIFICACION" and ');
              IBSQL1.SQL.Add('ID_GARANTIA = :"ID_GARANTIA" and ID_CATEGORIA = :"ID_CATEGORIA" ');
              IBSQL1.ParamByName('ID_CLASIFICACION').AsInteger := FieldByName('ID_CLASIFICACION').AsInteger;
              IBSQL1.ParamByName('ID_GARANTIA').AsInteger := FieldByName('ID_GARANTIA').AsInteger;
              IBSQL1.ParamByName('ID_CATEGORIA').AsString := FieldByName('ID_EVALUACION').AsString;
              IBSQL1.ExecQuery;

                // Inicio Corto y Largo Plazo
                CortoPlazo := 0;
                LargoPlazo := 0;
                IBSQL2.SQL.Clear;
                IBSQL2.SQL.Add('select * from "col$tablaliquidacion"');
                IBSQL2.SQL.Add('where (ID_AGENCIA = :"ID_AGENCIA") AND (ID_COLOCACION = :"ID_COLOCACION") AND');
                IBSQL2.SQL.Add('(PAGADA = 0)');
                IBSQL2.SQL.Add('ORDER BY FECHA_A_PAGAR');
                IBSQL2.ParamByName('ID_AGENCIA').AsInteger := FieldByName('ID_AGENCIA').AsInteger;
                IBSQL2.ParamByName('ID_COLOCACION').AsString := FieldByName('ID_COLOCACION').AsString;
                IBSQL2.ExecQuery;
                if IBSQL2.RecordCount > 0 then
                 while not Eof do
                 begin
                   if DiasEntre(Date,IBSQL2.FieldbyName('FECHA_A_PAGAR').AsDate) <= 360 then
                      CortoPlazo := CortoPlazo + SimpleRoundTo(IBSQL2.FieldByName('CAPITAL_A_PAGAR').AsCurrency,0)
                   else
                      LargoPlazo := LargoPlazo + SimpleRoundTo(IBSQL2.FieldByName('CAPITAL_A_PAGAR').AsCurrency,0);
                   IBSQL2.Next;
                 end; // while
                EvaluarCapital(FieldByName('VALOR_DESEMBOLSO').AsCurrency - FieldByName('ABONOS_CAPITAL').AsCurrency);
                nRegistro := xml.Root.Items.Add('tabla');
                nRegistro.Properties.Add('nombre','con$auxiliar');
                nCampo := nRegistro.Items.Add('Registro');
                if CortoPlazo > 0 then begin
                  nCampo.Items.Add('campo',IBSQL1.FieldByName('COD_CAPITAL_CP').AsString);
                  nCampo.Items.Add('campo',CurrToStr(CortoPlazo));
                end;
                if LargoPlazo > 0 then begin
                  nCampo.Items.Add('campo',IBSQL1.FieldByName('COD_CAPITAL_LP').AsString);
                  nCampo.Items.Add('campo',CurrToStr(LargoPlazo));
                end;                                              
                //fin corto y Largo Plazo

                //

              CDcartera.Append;
              CDcartera.FieldValues['ID_COLOCACION'] := FieldByName('ID_COLOCACION').AsString;
              CDcartera.Post;
              Next;
            end;
           end; //fin registro de Colocaciones

          // Busqueda de extracto
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$extracto" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$extracto');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                   if i = 0 then
                    nCampo.Items.Add('campo',AgenciaT)
                   else
                   begin
                   if FieldDefs.Items[i].DataType = fttime then
                      nCampo.Items.Add('campo',FormatDateTime('hh:mm:ss',Fields.Fields[i].AsDateTime))
                   else
                      nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                   end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //fin del registra extracto

          // Busqueda de Extracto Detallado
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$extractodet" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$extractodet');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 0 then
                   nCampo.Items.Add('campo',AgenciaT)
                  else
                  begin
                   if FieldDefs.Items[i].DataType = fttime then
                      nCampo.Items.Add('campo',FormatDateTime('hh:mm:ss',Fields.Fields[i].AsDateTime))
                   else
                      nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                  end;
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //fin del registra Extracto Detallado

          // Busqueda de Garantias Personales
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$colgarantias" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$colgarantias');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 0 then
                   nCampo.Items.Add('campo',AgenciaT)
                  else
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin registro de Garantias Personales

          // Busqueda de Garantias Reales
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$colgarantiasreal" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$colgarantiasreal');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 0 then
                   nCampo.Items.Add('campo',AgenciaT)
                  else
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin registro de Garantias Reales

          // Busqueda de Tabla de Liquidacion
          vTabla := False;
          vContador := 1;
          SQL.Clear;
          SQL.Add('select * from "col$tablaliquidacion" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$tablaliquidacion');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 2 then
                   nCampo.Items.Add('campo',AgenciaT)
                  else
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Tabla de Liquidacion

          // Busqueda Registros de Costas
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$costas" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$costas');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 0 then
                   nCampo.Items.Add('campo',AgenciaT)
                  else
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Registro de Costas

          // Registro de Pagos Consignacion Nal
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$pagoconnal" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$pagoconnal');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 0 then
                   nCampo.Items.Add('campo',AgenciaT)
                  else
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Pagos Consignacion Nal

          // Registro Control de Cobro
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$controlcobro" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$controlcobro');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 0 then
                   nCampo.Items.Add('campo',AgenciaT)
                  else
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Control de Cobro

          // Registro Colocaciones en Abogados
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$colocacionabogado" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$colocacionabogado');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 0 then
                   nCampo.Items.Add('campo',AgenciaT)
                  else
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Colocaciones en Abogados

          // Registro Cambios de Estado
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$cambioestado" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$cambioestado');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 0 then
                   nCampo.Items.Add('campo',AgenciaT)
                  else
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Cambios de Estado

          // Registro Marcas
          vTabla := False;
          SQL.Clear;
          SQL.Add('select * from "col$marcas" where ID_COLOCACION = :ID_COLOCACION');
          CDcartera.First;
          while not CDcartera.Eof do
          begin
             Close;
             ParamByName('ID_COLOCACION').AsString := CDcartera.FieldByName('ID_COLOCACION').AsString;
             Open;
             if RecordCount > 0 then
             begin
               if vTabla = False then // valida si fue creado el nodo
               begin
                  vTabla := True;
                  nRegistro  := xml.Root.Items.Add('tabla');
                  nRegistro.Properties.Add('nombre','col$marcas');
               end;
               while not Eof do
               begin
                 nCampo := nRegistro.Items.Add('Registro');
                 for i := 0 to FieldDefs.Count -1 do
                  if i = 1 then
                   nCampo.Items.Add('campo',AgenciaT)
                  else
                   nCampo.Items.Add('campo',Fields.Fields[i].AsString);
                 Next;
                end;
             end;
             CDcartera.Next;
          end; //Fin Registro de Marcas

          xml.SaveToFile('c:\ejemplo.xml');
        end;
        ShowMessage('Proceso Terminado con Exito');
// Fin Traslado de Cartera
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
        IBDatabase1.Connected := True;
        IBTransaction1.Active := True;
        IBDatabase2.Connected := True;
        IBTransaction2.Active := True;

end;

procedure TForm1.Button1Click(Sender: TObject);
var     i,j,h :Integer;
        tabla :string;
        sentencia :string;
begin
        if IBInsertar.Transaction.InTransaction then
           IBInsertar.Transaction.Commit;
        IBInsertar.Transaction.StartTransaction;
        xml1.LoadFromFile('c:\ejemplo.xml');
        for i := 0 to xml1.Root.Items.Count -1 do
        begin
            nRegistro := xml1.Root.Items[i];
            tabla := 'insert into "' + nRegistro.Properties.Item[0].Value + '" values(';
            for j := 0 to nRegistro.Items.Count -1 do
            begin
               nCampo := nRegistro.Items[j];
               for h := 0 to nCampo.Items.Count -1 do
               begin
                   if h = 0 then
                      if ncampo.Items.Item[h].Value = '' then
                         sentencia := 'NULL' else
                      sentencia := '''' + ncampo.Items.Item[h].Value + ''''
                   else
                      if ncampo.Items.Item[h].Value = '' then
                          sentencia := sentencia + ',NULL' else
                        sentencia := sentencia + ',' + '''' + ncampo.Items.Item[h].Value + '''';
               end;
               Memo1.Lines.Add(#13 + #13);
               Memo1.Lines.Add(tabla + sentencia + ')');

               with IBInsertar do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Add(tabla + sentencia + ')');
                  try
                    ExecSQL;
                    Transaction.CommitRetaining;
                  except
                    Transaction.RollbackRetaining;
                  end;
                end;
               sentencia := '';
            end;

            //Memo1.Lines.Add(IntToStr(i));
        end;
        IBInsertar.Transaction.Commit;

end;

procedure TForm1.EvaluarCapital(Saldo:Currency);
begin
              if CortoPlazo < 1 then begin
                 CortoPlazo := Saldo;
                 LargoPlazo := 0;
                 Exit;
              end;

              if CortoPlazo > Saldo then begin
                 CortoPlazo := Saldo;
                 LargoPlazo := 0;
                 Exit;
              end;

              if (CortoPlazo + LargoPlazo) < Saldo then
              begin
               if LargoPlazo > 0 then
                  LargoPlazo := Saldo - CortoPlazo
               else
               begin
                 CortoPlazo := Saldo;
                 LargoPlazo := 0;
               end;
               Exit;
              end;

              LargoPlazo := Saldo - CortoPlazo;
              if LargoPlazo < 1 then LargoPlazo := 0;
end;


end.
