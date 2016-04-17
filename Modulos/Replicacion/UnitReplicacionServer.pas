unit UnitReplicacionServer;

interface

uses

  StrUtils, SysUtils, Types, Classes, DBXpress, DB, SqlExpr, ComCtrls, FMTBcd,
  IniFiles, IB, IBDatabase, IBCustomDataSet, IBQuery, IBEvents,
  cmpTrayIcon, Menus, QControls, QGraphics, QStdCtrls, QExtCtrls,
  QComCtrls, QButtons, QTypes, QMenus, QForms;

type
  TfrmMain = class(TForm)
    PageControl1: TPageControl;
    TabEstado: TTabSheet;
    TabOpciones: TTabSheet;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Image2: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    lblRplMgrDb: TLabel;
    GroupBox2: TGroupBox;
    chkEventos: TCheckBox;
    Label5: TLabel;
    EdIntervalo: TEdit;
    Label6: TLabel;
    SpeedButton4: TSpeedButton;
    TIntervaloRepl: TTimer;
    THacerReplicacion: TTimer;
    Panel1: TPanel;
    EstadoLbl: TLabel;
    SQLConnMgr: TIBDatabase;
    SQLConnSrc: TIBDatabase;
    SQLConnTgt: TIBDatabase;
    SQLQMgrRel: TIBQuery;
    IBTMgr: TIBTransaction;
    IBTSrc: TIBTransaction;
    IBTTgr: TIBTransaction;
    SQLQMgrRep: TIBQuery;
    SQLQOtros: TIBQuery;
    SQLQSrc: TIBQuery;
    SQLQCambio: TIBQuery;
    SQLQTgt: TIBQuery;
    IBEvent: TIBEvents;
    SQLQSrcTabla: TIBQuery;
    TrayIcon1: TTrayIcon;
    SpeedButton5: TSpeedButton;
    lblProceso: TLabel;
    procedure THacerReplicacionTimer(Sender: TObject);
    procedure TIntervaloReplTimer(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShowForm1Click(Sender: TObject);
    procedure Run1Click(Sender: TObject);
    procedure TrayIcon1RightBtnClick(Sender: TObject);
    procedure TrayIcon1LeftBtnClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
    procedure ReplicarDatos;
    procedure HandleError(ErrorMsg:string; Nivel:Integer);
    procedure PasoValor(var Parametro: TParam; Valor: String);
    procedure PasoParametro(Campo: TField; var Parametro: TParam);
    function EvaluoTipoDato(TipoDato: integer): TFieldType;
    { Private declarations }
  public
    ErrorFile : array[0..254] of Char;
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

  Ejecutando:Boolean;
  TodoError:Integer;
  FatalError:Boolean;

  IDRelacion :Integer;

  IDTMgr:TTransactionDesc;
  IDTSrc:TTransactionDesc;
  IDTTgt:TTransactionDesc;

implementation

{$R *.xfm}

uses UnitErrores;

procedure TfrmMain.ReplicarDatos;
var
   MiIni:TIniFile;

   DBMgrPath:string;
   MgrUsuario:string;
   MgrContrasena:string;

   DBSrcID:Integer;
   DBSrcPath:string;
   SrcUsuario:string;
   SrcContrasena:string;

   DBTgtID:Integer;
   DBTgtPath:string;
   TgtUsuario:string;
   TgtContrasena:string;

   Total:Integer;

   NomTabla:string;
   lLlave:TStringList; // almacena los campos llave
   lValor:TStringList; // almacena los valores de los campos llave anterior
   lNuevo:TStringList; // almacena los valores de los campos llave nuevas

   TipoOperacion:Integer;
   TipoDato:Integer; // Tipo de dato del campo a manejar;

// variables varias
   i:Integer;
   cadena:string;
   secuencia:Integer;

   Parametro:TParam;
   Campo:TField;

// Variables de Control
   NoAplicado:Boolean;

// Porcentaje proceso
   Porcentaje:Integer;
begin
// Leer información de configuración del Manager

   MiIni := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Repl.ini');
   DBMgrPath := MiIni.ReadString('MANAGER','Ruta','');
   MgrUsuario := MiIni.ReadString('MANAGER','Usuario','');
   MgrContrasena := MiIni.ReadString('MANAGER','Contrasena','');

// Conectar al Manager

   with SQLConnMgr do
   begin
     Params.Clear;
     DatabaseName :=  DBMgrPath;
     Params.Values['User_name'] := MgrUsuario;
     Params.Values['Password']  := MgrContrasena;

     try
      Connected := True;
      DefaultTransaction.StartTransaction;
     except
      on E: EIBInterBaseError do
       begin
        HandleError('Error al intentar conectar con la base de datos de control: '+  E.Message,0);
        Exit;
       end;
     end;
   end;

// Leer Relaciones Configuradas

   with SQLQMgrRel do
   begin
     Close;
     SQL.Clear;
     SQL.Add('select * from RELACIONES');
     try
      Open;
     except
      on E: EIBInterBaseError do
       begin
        HandleError('Error al intentar buscar RELACIONES: '+  E.Message,1);
        Exit;
       end;
     end;
   end;

// Ciclo de Relaciones Configuradas

   while not SQLQMgrRel.Eof do  // (1)
   begin
     Application.ProcessMessages;

     DBSrcID := SQLQMgrRel.FieldByName('IDSOURCE').AsInteger;
     DBTgtID := SQLQMgrRel.FieldByName('IDTARGET').AsInteger;
     IDRelacion := SQLQMgrRel.FieldByName('IDRELACION').AsInteger;

// Leer Base Origen

     SQLQOtros.Close;
     SQLQOtros.SQL.Clear;
     SQLQOtros.SQL.Add('select * from SOURCES where IDSOURCE = :IDSOURCE');
     SQLQOtros.ParamByName('IDSOURCE').AsInteger := DBSrcID;
     try
      SQLQOtros.Open;
      DBSrcPath := SQLQOtros.FieldByName('SOURCE_PATH').AsString;
      SrcUsuario := SQLQOtros.FieldByName('USERNAME').AsString;
      SrcContrasena := SQLQOtros.FieldByName('PASSWD').AsString;
      SQLQOtros.Close;
     except
      on E: EIBInterBaseError do
       begin
        HandleError('Error al intentar buscar DB Fuente: '+  E.Message,1);
        Exit;
       end;
     end;

// Leer Base Destino

     SQLQOtros.Close;
     SQLQOtros.SQL.Clear;
     SQLQOtros.SQL.Add('select * from TARGETS where IDTARGET = :IDTARGET');
     SQLQOtros.ParamByName('IDTARGET').AsInteger := DBTgtID;
     try
      SQLQOtros.Open;
      DBTgtPath := SQLQOtros.FieldByName('TARGET_PATH').AsString;
      TgtUsuario := SQLQOtros.FieldByName('USERNAME').AsString;
      TgtContrasena := SQLQOtros.FieldByName('PASSWD').AsString;
      SQLQOtros.Close;
     except
      on E: EIBInterBaseError do
       begin
        HandleError('Error al intentar buscar DB Destino: '+  E.Message,1);
        Exit;
       end;
     end;

// Probar conexión a base de datos origen

     with SQLConnSrc do
     begin
       Params.Clear;
       DatabaseName :=  DBSrcPath;
       Params.Values['User_name'] := SrcUsuario;
       Params.Values['Password']  := SrcContrasena;

     try
      Connected := True;
      DefaultTransaction.StartTransaction;
     except
      on E: EIBInterBaseError do
       begin
        HandleError('Error al intentar conectar con la base de datos de origen: '+  E.Message,1);
        Exit;
       end;
     end;
   end;

// Probar conexión a base de datos destino

     with SQLConnTgt do
     begin
       Params.Clear;
       DatabaseName := DBTgtPath;
       Params.Values['User_name'] := TgtUsuario;
       Params.Values['Password']  := TgtContrasena;

      try
       Connected := True;
       DefaultTransaction.StartTransaction;
      except
      on E: EIBInterBaseError do
       begin
        HandleError('Error al intentar conectar con la base de datos de destino: '+  E.Message,2);
        Exit;
       end;
      end;
     end;

     SQLQCambio.Close;
     SQLQCambio.SQL.Clear;
     SQLQCambio.SQL.Add('select count(*) as TOTAL from REPL_CAMBIOS');
     SQLQCambio.SQL.Add('where');
     SQLQCambio.SQL.Add('IDRELACION = :IDRELACION and');
     SQLQCambio.SQL.Add('IDSOURCE = :IDSOURCE and');
     SQLQCambio.SQL.Add('IDTARGET = :IDTARGET');
     SQLQCambio.ParamByName('IDRELACION').AsInteger := IDRelacion;
     SQLQCambio.ParamByName('IDSOURCE').AsInteger := DBSrcID;
     SQLQCambio.ParamByName('IDTARGET').AsInteger := DBTgtID;
     try
       SQLQCambio.Open;
       Total := SQLQCambio.FieldByName('TOTAL').AsInteger;
//       Total := 1000;
     except
      on E: EIBInterBaseError do
       begin
        HandleError('Error al intentar obtener reporte de cambios en la base fuente: '+  E.Message,3);
        Exit;
       end;
     end;


     SQLQCambio.Close;
     SQLQCambio.SQL.Clear;
     if Total > 3000 then
     begin
       Total := 3000;
       SQLQCambio.SQL.Add('select FIRST 3000 * from REPL_CAMBIOS where');
       SQLQCambio.SQL.Add('IDRELACION = :IDRELACION and');
       SQLQCambio.SQL.Add('IDSOURCE = :IDSOURCE and');
       SQLQCambio.SQL.Add('IDTARGET = :IDTARGET');
       SQLQCambio.SQL.Add('ORDER BY IDRELACION,IDSOURCE,IDTARGET,SECUENCIA');
       SQLQCambio.ParamByName('IDRELACION').AsInteger := IDRelacion;
       SQLQCambio.ParamByName('IDSOURCE').AsInteger := DBSrcID;
       SQLQCambio.ParamByName('IDTARGET').AsInteger := DBTgtID;
     end
     else
     begin
       SQLQCambio.SQL.Add('select * from REPL_CAMBIOS where');
       SQLQCambio.SQL.Add('IDRELACION = :IDRELACION and');
       SQLQCambio.SQL.Add('IDSOURCE = :IDSOURCE and');
       SQLQCambio.SQL.Add('IDTARGET = :IDTARGET');
       SQLQCambio.SQL.Add('ORDER BY IDRELACION,IDSOURCE,IDTARGET,SECUENCIA');
       SQLQCambio.ParamByName('IDRELACION').AsInteger := IDRelacion;
       SQLQCambio.ParamByName('IDSOURCE').AsInteger := DBSrcID;
       SQLQCambio.ParamByName('IDTARGET').AsInteger := DBTgtID;
     end;
     try
       SQLQCambio.Open;
     except
      on E: EIBInterBaseError do
       begin
        HandleError('Error al intentar obtener reporte de cambios en la base fuente: '+  E.Message,3);
        Exit;
       end;
     end;

// Ciclo de cambios en base origen
     lblProceso.Visible := True;

     while not SQLQCambio.Eof do begin
      Application.ProcessMessages;

      lblProceso.Caption := 'Registro '+ IntToStr(SQLQCambio.RecNo)+' de '+ IntToStr(Total);
      Porcentaje := trunc((SQLQCambio.RecNo/Total) * 100);
      TrayIcon1.Hint := 'FB Replicador - Estado: Ejecutando '+IntToStr(Porcentaje)+'%';

      Application.ProcessMessages;

      secuencia := SQLQCambio.FieldByName('SECUENCIA').AsInteger;

      SQLQOtros.Close;
      SQLQOtros.SQL.Clear;
      SQLQOtros.SQL.Add('select IDRELACION,IDREPLICA,NOMTABLA,PKTABLA from TABLARELACIONES where IDREPLICA = :IDREPLICA');
      SQLQOtros.ParamByName('IDREPLICA').AsInteger := SQLQCambio.FieldByName('IDREPLICA').AsInteger;
      try
       SQLQOtros.Open;
      except
       on E: EIBInterBaseError do
       begin
        HandleError('Error al intentar obtener las Tablas de Replicación: '+  E.Message,3);
        Exit;
       end;
      end;

      NomTabla := SQLQOtros.FieldByName('NOMTABLA').AsString;


      lLlave := TStringList.Create;
      lValor := TStringList.Create;
      lNuevo := TStringList.Create;

      if Pos(#32,SQLQOtros.FieldByName('PKTABLA').AsString) > 0 then
         lLlave.Text := StringReplace(SQLQOtros.FieldByName('PKTABLA').AsString,#32,#13,[rfReplaceAll])
      else
         lLlave.Text := StringReplace(SQLQOtros.FieldByName('PKTABLA').AsString,#9,#13,[rfReplaceAll]);

      if Pos(';',SQLQCambio.FieldByName('LLAVEANT').AsString) > 0 then
         lValor.Text := StringReplace(SQLQCambio.FieldByName('LLAVEANT').AsString,';',#13,[rfReplaceAll])
      else
         lValor.Text := StringReplace(SQLQCambio.FieldByName('LLAVEANT').AsString,#9,#13,[rfReplaceAll]);

      if Pos(';',SQLQCambio.FieldByName('LLAVENUEVA').AsString) > 0 then
         lNuevo.Text := StringReplace(SQLQCambio.FieldByName('LLAVENUEVA').AsString,';',#13,[rfReplaceAll])
      else
         lNuevo.Text := StringReplace(SQLQCambio.FieldByName('LLAVENUEVA').AsString,#9,#13,[rfReplaceAll]);

      if ((lValor.Count = 0) and (lNuevo.Count = 0)) then
      begin
       SQLQCambio.Next;
       Continue;
      end;


// Separar según el tipo de Operación
      if SQLQCambio.FieldByName('OPERACION').AsString = 'D' then
         TipoOperacion := 1;
      if SQLQCambio.FieldByName('OPERACION').AsString = 'U' then
         TipoOperacion := 2;
      if SQLQCambio.FieldByName('OPERACION').AsString = 'I' then
         TipoOperacion := 3;

      if (TipoOperacion = 1) and (lLlave.Count <> lValor.Count) then
       begin
         HandleError('Error se puede realizar eliminacion sin la llave a eliminar',4);
         NoAplicado := True;
         SQLQCambio.Next;
         lLlave.Free;
         lValor.Free;
         lNuevo.Free;
         Continue;
       end;

      if (TipoOperacion = 3) and (lLlave.Count <> lNuevo.Count) then
       begin
         HandleError('Error se puede realizar nueva insersion sin llave pk ',4);
         NoAplicado := True;
         SQLQCambio.Next;
         lLlave.Free;
         lValor.Free;
         lNuevo.Free;
         Continue;
       end;

      if (TipoOperacion = 2) and (lValor.Count <> lNuevo.Count) then
       begin
         HandleError('Error se puede realizar actualizacion sin ambas llaves ',4);
         NoAplicado := True;
         SQLQCambio.Next;
         lLlave.Free;
         lValor.Free;
         lNuevo.Free;
         Continue;
       end;

      NoAplicado := False;

      case TipoOperacion of
      1: begin
           SQLQTgt.Close;
           SQLQTgt.SQL.Clear;
           cadena := 'delete from "'+NomTabla+'" where ';
           SQLQTgt.SQL.Add(cadena);

           for i := 0 to lLlave.Count - 1 do
           begin
             SQLQTgt.SQL.Add(Trim(lLlave.Strings[i])+'= :'+Trim(lLlave.Strings[i]));
             if (i <> lLlave.Count - 1) then
                SQLQTgt.SQL.Add('and');
           end;

           for i := 0 to lllave.Count - 1 do
           begin

            SQLQSrc.Close;
            SQLQSrc.SQL.Clear;
            SQLQSrc.SQL.Add('Select RF.RDB$FIELD_NAME,F.RDB$FIELD_TYPE FROM');
            SQLQSrc.SQL.Add('RDB$RELATION_FIELDS RF LEFT JOIN RDB$FIELDS F');
            SQLQSrc.SQL.Add('ON RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME WHERE');
            SQLQSrc.SQL.Add('RDB$RELATION_NAME = :TABLENAME and RF.RDB$FIELD_NAME = :FIELDNAME');
            SQLQSrc.SQL.Add('AND F.RDB$COMPUTED_BLR IS NULL');
            SQLQSrc.SQL.Add('AND F.RDB$DIMENSIONS IS NULL');
            SQLQSrc.ParamByName('TABLENAME').AsString := NomTabla;
            SQLQSrc.ParamByName('FIELDNAME').AsString := Trim(lLlave.Strings[i]);
            try
             SQLQSrc.Open;
             TipoDato := SQLQSrc.FieldByName('RDB$FIELD_TYPE').AsInteger;
             SQLQSrc.Close;
            except
              on E: EIBInterBaseError do
               begin
                HandleError('Error al intentar obtener tipo de dato de un campo: '+  E.Message,4);
                lLlave.Free;
                lValor.Free;
                lNuevo.Free;
                SQLQCambio.Next;
                NoAplicado := True;
                Continue;
               end;
              else
               begin
                HandleError('Error al intentar obtener tipo de dato de un campo',4);
                lLlave.Free;
                lValor.Free;
                lNuevo.Free;
                SQLQCambio.Next;
                NoAplicado := True;
                Continue;
               end;
            end;
            SQLQTgt.Params.ParamByName(Trim(lLlave.Strings[i])).DataType := EvaluoTipoDato(TipoDato);//TFieldType(TipoDato);
            Parametro := SQLQTgt.Params.ParamByName(Trim(lLlave.Strings[i]));
            pasovalor(Parametro,Trim(lValor.Strings[i]));
            SQLQTgt.Params.ParamByName(Trim(lLlave.Strings[i])).Assign(Parametro);
           end;
           try
             SQLQTgt.ExecSQL;
           except
//              on E: EIBInterBaseError do
//               begin
                HandleError('Error al intentar aplicar la eliminación del registro: ',4);//+  E.Message,3);
                lLlave.Free;
                lValor.Free;
                lNuevo.Free;
                SQLQCambio.Next;
                NoAplicado := True;
                Continue;
//               end;
           end;
         end;

      2: begin
           SQLQSrcTabla.Close;
           SQLQSrcTabla.SQL.Clear;
           SQLQSrcTabla.SQL.Add('select * from "'+NomTabla+'" where ');

           for i := 0 to lLlave.Count - 1 do
           begin
             SQLQSrcTabla.SQL.Add(Trim(lLlave.Strings[i])+'= :'+Trim(lLlave.Strings[i]));
             if (i <> lLlave.Count - 1) then
                SQLQSrcTabla.SQL.Add('and');
           end;

           for i := 0 to lllave.Count - 1 do
           begin

            SQLQSrc.Close;
            SQLQSrc.SQL.Clear;
            SQLQSrc.SQL.Add('Select RF.RDB$FIELD_NAME,F.RDB$FIELD_TYPE FROM');
            SQLQSrc.SQL.Add('RDB$RELATION_FIELDS RF LEFT JOIN RDB$FIELDS F');
            SQLQSrc.SQL.Add('ON RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME WHERE');
            SQLQSrc.SQL.Add('RDB$RELATION_NAME = :TABLENAME and RF.RDB$FIELD_NAME = :FIELDNAME');
            SQLQSrc.SQL.Add('AND F.RDB$COMPUTED_BLR IS NULL');
            SQLQSrc.SQL.Add('AND F.RDB$DIMENSIONS IS NULL');
            SQLQSrc.ParamByName('TABLENAME').AsString := NomTabla;
            SQLQSrc.ParamByName('FIELDNAME').AsString := Trim(lLlave.Strings[i]);
            try
             SQLQSrc.Open;
             TipoDato := SQLQSrc.FieldByName('RDB$FIELD_TYPE').AsInteger;
             SQLQSrc.Close;
            except
              on E: EIBInterBaseError do
               begin
                HandleError('Error al intentar obtener tipo de dato de un campo: '+  E.Message,4);
                lLlave.Free;
                lValor.Free;
                lNuevo.Free;
                SQLQCambio.Next;
                NoAplicado := True;
                Continue;
               end;
              else
               begin
                HandleError('Error al intentar obtener tipo de dato de un campo',4);
                lLlave.Free;
                lValor.Free;
                lNuevo.Free;
                SQLQCambio.Next;
                NoAplicado := True;
                Continue;
               end;
            end;
            SQLQSrcTabla.Params.ParamByName(Trim(lLlave.Strings[i])).DataType := EvaluoTipoDato(TipoDato);
            Parametro := SQLQSrcTabla.Params.ParamByName(Trim(lLlave.Strings[i]));
            try
             PasoValor(Parametro,Trim(lValor.Strings[i]));
            except
             HandleError('Error en Actualización al asignar los valores a la llave primaria',4);
             lLlave.Free;
             lValor.Free;
             lNuevo.Free;
             SQLQCambio.Next;
             NoAplicado := True;
             Continue;
             //             Exit;
            end;
            SQLQSrcTabla.Params.ParamByName(Trim(lLlave.Strings[i])).Assign(Parametro);
           end;

           try
            SQLQSrcTabla.Open;
// Aplicar Actualización si corresponde
            if SQLQSrcTabla.RecordCount > 0 then
            begin
               SQLQTgt.Close;
               SQLQTgt.SQL.Clear;
               SQLQTgt.SQL.Add('update "'+NomTabla+'" SET ');
// crear query de inserción clausulas SET
               for i := 0 to SQLQSrcTabla.FieldCount - 1 do
               begin
                  SQLQTgt.SQL.Add(SQLQSrcTabla.Fields[i].FieldName+' =:'+ SQLQSrcTabla.Fields[i].FieldName);
                  if (i <> (SQLQSrcTabla.FieldCount - 1)) then
                    SQLQTgt.SQL.Add(',');
               end;

               SQLQTgt.SQL.Add('where');

// Colocar Clausula de condición
               for i := 0 to lLlave.Count - 1 do
               begin
                  SQLQTgt.SQL.Add(Trim(lLlave.Strings[i])+'= :OLD_'+Trim(lLlave.Strings[i]));
                  if (i <> lLlave.Count - 1) then
                   SQLQTgt.SQL.Add('and');
               end;

               for i := 0 to lllave.Count - 1 do
               begin

                 SQLQSrc.Close;
                 SQLQSrc.SQL.Clear;
                 SQLQSrc.SQL.Add('Select RF.RDB$FIELD_NAME,F.RDB$FIELD_TYPE FROM');
                 SQLQSrc.SQL.Add('RDB$RELATION_FIELDS RF LEFT JOIN RDB$FIELDS F');
                 SQLQSrc.SQL.Add('ON RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME WHERE');
                 SQLQSrc.SQL.Add('RDB$RELATION_NAME = :TABLENAME and RF.RDB$FIELD_NAME = :FIELDNAME');
                 SQLQSrc.SQL.Add('AND F.RDB$COMPUTED_BLR IS NULL');
                 SQLQSrc.SQL.Add('AND F.RDB$DIMENSIONS IS NULL');
                 SQLQSrc.ParamByName('TABLENAME').AsString := NomTabla;
                 SQLQSrc.ParamByName('FIELDNAME').AsString := Trim(lLlave.Strings[i]);
                 try
                  SQLQSrc.Open;
                  TipoDato := SQLQSrc.FieldByName('RDB$FIELD_TYPE').AsInteger;
                  SQLQSrc.Close;
                 except
                   on E: EIBInterBaseError do
                   begin
                    HandleError('Error al intentar obtener tipo de dato de un campo: '+  E.Message,4);
                    lLlave.Free;
                    lValor.Free;
                    lNuevo.Free;
                    SQLQCambio.Next;
                    NoAplicado := True;
                    Continue;
                   end;
                   else
                   begin
                    HandleError('Error al intentar obtener tipo de dato de un Campo',4);
                    lLlave.Free;
                    lValor.Free;
                    lNuevo.Free;
                    SQLQCambio.Next;
                    NoAplicado := True;
                    Continue;
                   end;
                 end;
                 SQLQTgt.Params.ParamByName('OLD_'+Trim(lLlave.Strings[i])).DataType := EvaluoTipoDato(TipoDato);
                 Parametro := SQLQTgt.Params.ParamByName('OLD_'+Trim(lLlave.Strings[i]));
                 try
                  PasoValor(Parametro,Trim(lValor.Strings[i]));
                 except
                  HandleError('Error en Actualización al asignar los valores a la llave primaria',4);
                  lLlave.Free;
                  lValor.Free;
                  lNuevo.Free;
                  SQLQCambio.Next;
                  NoAplicado := True;
                  Continue;
                 end;

                 SQLQTgt.Params.ParamByName('OLD_'+Trim(lLlave.Strings[i])).Assign(Parametro);
               end;
// Asignar valores a cada parametro
               for i := 0 to SQLQSrcTabla.FieldCount - 1 do
               begin
                  Campo     := SQLQSrcTabla.FieldByName(SQLQSrcTabla.Fields[i].FieldName);
                  Parametro := SQLQTgt.ParamByName(SQLQSrcTabla.Fields[i].FieldName);
                  PasoParametro(Campo,Parametro);
               end;
// Fin Asignación de Valores
               try
                SQLQTgt.ExecSQL;
                except
                on E: EIBInterBaseError do
                begin
                 HandleError('Error al intentar realizar la actualización del registro: '+  E.Message,4);
                 lLlave.Free;
                 lValor.Free;
                 lNuevo.Free;
                 SQLQCambio.Next;
                 NoAplicado := True;
                 Continue;
                end;
                else
                begin
                 HandleError('Error al intentar realizar la actualización del registro',4);
                 lLlave.Free;
                 lValor.Free;
                 lNuevo.Free;
                 SQLQCambio.Next;
                 NoAplicado := True;
                 Continue;
                end;
               end;
            end;
           except
            raise;
           end;

         end; // fin del caso 2

      3: begin
           SQLQSrcTabla.Close;
           SQLQSrcTabla.SQL.Clear;
           SQLQSrcTabla.SQL.Add('select * from "'+NomTabla+'" where ');

           for i := 0 to lLlave.Count - 1 do
           begin
             SQLQSrcTabla.SQL.Add(Trim(lLlave.Strings[i])+'= :'+Trim(lLlave.Strings[i]));
             if (i <> lLlave.Count - 1) then
                SQLQSrcTabla.SQL.Add('and');
           end;

           for i := 0 to lllave.Count - 1 do
           begin

            SQLQSrc.Close;
            SQLQSrc.SQL.Clear;
            SQLQSrc.SQL.Add('Select RF.RDB$FIELD_NAME,F.RDB$FIELD_TYPE FROM');
            SQLQSrc.SQL.Add('RDB$RELATION_FIELDS RF LEFT JOIN RDB$FIELDS F');
            SQLQSrc.SQL.Add('ON RF.RDB$FIELD_SOURCE = F.RDB$FIELD_NAME WHERE');
            SQLQSrc.SQL.Add('RDB$RELATION_NAME = :TABLENAME and RF.RDB$FIELD_NAME = :FIELDNAME');
            SQLQSrc.SQL.Add('AND F.RDB$COMPUTED_BLR IS NULL');
            SQLQSrc.SQL.Add('AND F.RDB$DIMENSIONS IS NULL');
            SQLQSrc.ParamByName('TABLENAME').AsString := NomTabla;
            SQLQSrc.ParamByName('FIELDNAME').AsString := Trim(lLlave.Strings[i]);
            try
             SQLQSrc.Open;
             TipoDato := SQLQSrc.FieldByName('RDB$FIELD_TYPE').AsInteger;
             SQLQSrc.Close;
            except
              on E: EIBInterBaseError do
               begin
                HandleError('Error al intentar obtener tipo de dato de un campo: '+  E.Message,4);
                lLlave.Free;
                lValor.Free;
                lNuevo.Free;
                SQLQCambio.Next;
                NoAplicado := True;
                Continue;
               end;
              else
               begin
                HandleError('Error al intentar obtener tipo de dato de un campo',4);
                lLlave.Free;
                lValor.Free;
                lNuevo.Free;
                SQLQCambio.Next;
                NoAplicado := True;
                Continue;
               end;
            end;
            SQLQSrcTabla.Params.ParamByName(Trim(lLlave.Strings[i])).DataType := EvaluoTipoDato(TipoDato);
            Parametro := SQLQSrcTabla.Params.ParamByName(Trim(lLlave.Strings[i]));
            try
              PasoValor(Parametro,Trim(lNuevo.Strings[i]));
            except
              HandleError('Error en Inserción al asignar los valores a la llave primaria',4);
              lLlave.Free;
              lValor.Free;
              lNuevo.Free;
              SQLQCambio.Next;
              NoAplicado := True;
              Continue;
            end;
            SQLQSrcTabla.Params.ParamByName(Trim(lLlave.Strings[i])).Assign(Parametro);
           end;

           try
            SQLQSrcTabla.Open;
// Aplicar Actualización si corresponde
            if SQLQSrcTabla.RecordCount > 0 then
            begin
               SQLQTgt.Close;
               SQLQTgt.SQL.Clear;
               SQLQTgt.SQL.Add('insert into "'+NomTabla+'" values (');
// crear query de inserción clausulas SET
               for i := 0 to SQLQSrcTabla.FieldCount - 1 do
               begin
                  SQLQTgt.SQL.Add(':'+SQLQSrcTabla.Fields[i].FieldName);
                  if (i <> (SQLQSrcTabla.FieldCount - 1)) then
                    SQLQTgt.SQL.Add(',');
               end;

               SQLQTgt.SQL.Add(')');

// Asignar valores a cada parametro
               for i := 0 to SQLQSrcTabla.FieldCount - 1 do
               begin
                  Campo     := SQLQSrcTabla.FieldByName(SQLQSrcTabla.Fields[i].FieldName);
                  Parametro := SQLQTgt.ParamByName(SQLQSrcTabla.Fields[i].FieldName);
                  PasoParametro(Campo,Parametro);
               end;
// Fin Asignación de Valores
               try
                SQLQTgt.ExecSQL;
               except
               on E: EIBInterBaseError do
                begin
                HandleError('Error al intentar insertar el nuevo registro: '+  E.Message,4);
                lLlave.Free;
                lValor.Free;
                lNuevo.Free;
                SQLQCambio.Next;
                NoAplicado := True;
                Continue;
                end;
               else
                begin
                 HandleError('Error al intentar insertar el nuevo registro',4);
                 lLlave.Free;
                 lValor.Free;
                 lNuevo.Free;
                 SQLQCambio.Next;
                 NoAplicado := True;
                 Continue;
                end;
               end;
            end;
           except
              on E: EIBInterBaseError do
               begin
                HandleError('Error al intentar obtener los datos del nuevo registro: '+  E.Message,4);
                lLlave.Free;
                lValor.Free;
                lNuevo.Free;
                SQLQCambio.Next;
                NoAplicado := True;
                Continue;
               end;
              else
               begin
                HandleError('Error al intentar obtener los datos del nuevo registro',4);
                lLlave.Free;
                lValor.Free;
                lNuevo.Free;
                SQLQCambio.Next;
                NoAplicado := True;
                Continue;
               end;
           end;

         end; // fin caso 3
      end; // fin del case


      lLlave.Free;
      lValor.Free;
      lNuevo.Free;

      if not NoAplicado then
      begin
       SQLQSrc.Close;
       SQLQSrc.SQL.Clear;
       SQLQSrc.SQL.Add('delete from REPL_CAMBIOS where SECUENCIA = :SECUENCIA');
       SQLQSrc.ParamByName('SECUENCIA').AsInteger := secuencia;
       try
        SQLQSrc.ExecSQL;
       except
         on E: EIBInterBaseError do
         begin
           HandleError('Error al intentar eliminar registro ya replicado: '+  E.Message,3);
           Exit;
         end;
       end;
      end;

      SQLQCambio.Next;
     end;// fin del ciclo de cambios en la base origen

     lblProceso.Visible := False;

     SQLConnTgt.DefaultTransaction.Commit;
     SQLConnSrc.DefaultTransaction.Commit;

     SQLConnTgt.Close;
     SQLConnSrc.Close;

     SQLQMgrRel.Next; // incrementar ciclo de relaciones configuradas

   end; // fin del ciclo while de relaciones configuradas (1)
   SQLConnMgr.DefaultTransaction.Commit;
   SQLConnMgr.Close;
end;

procedure TfrmMain.THacerReplicacionTimer(Sender: TObject);
begin
 THacerReplicacion.Enabled := False;
 if (not Ejecutando) then
  begin
  Ejecutando := True;
  TrayIcon1.Hint := 'FB Replicador - Estado: Ejecutando';
  TrayIcon1.Enabled := False;
  TrayIcon1.Icon.LoadFromFile('IBReplsmly.ico');
  TrayIcon1.Enabled := True;

  EstadoLbl.Font.Color := clYellow;
  EstadoLbl.Caption := 'Ejecutando';
  Image2.Picture.LoadFromFile('YLIGHT.BMP');
  Application.ProcessMessages;
  TodoError := 0;
  ReplicarDatos;
  if (TodoError > 0) then
  begin
      TrayIcon1.Hint := 'FB Replicador - Estado: Errores';
      TrayIcon1.Enabled := False;
      TrayIcon1.Icon.LoadFromFile('IBReplsmlr.ico');
      TrayIcon1.Enabled := True;
      Image2.Picture.LoadFromFile('RLIGHT.BMP');
      Estadolbl.Font.Color := clRed;
      Estadolbl.Caption := 'Errores';
  end
  else
  begin
      TrayIcon1.Hint := 'FB Replicador - Estado: En Espera';
      TrayIcon1.Enabled := False;
      TrayIcon1.Icon.LoadFromFile('IBReplsml.ico');
      TrayIcon1.Enabled := True;
      Image2.Picture.LoadFromFile('GLIGHT.BMP');
      Estadolbl.Font.Color := clGreen;
      Estadolbl.Caption := 'En Espera';
  end;
    Application.ProcessMessages;
    TodoError := 0;
    Ejecutando := False;
 end;

end;

procedure TfrmMain.TIntervaloReplTimer(Sender: TObject);
begin
 THacerReplicacion.Enabled := True;
end;


procedure TfrmMain.SpeedButton3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
begin
  THacerReplicacion.Enabled := True;
end;

procedure TfrmMain.HandleError(ErrorMsg:string; Nivel:Integer);
var
  Len : Integer;
  F:Textfile;
  FileId : Integer;
begin
  if (not FileExists(ErrorFile)) then begin
    FileId := FileCreate(ErrorFile);
    if FileId > 0 then begin
      FileClose(FileId);
    end;
  end;
  AssignFile(F,ErrorFile);
  Append(F);
  Writeln(F,DateTimeToStr(Now) + ' '+ErrorMsg);
  CloseFile(F);
  Inc(TodoError);

  case Nivel of
  1: begin
     SQLConnMgr.DefaultTransaction.Rollback;
     SQLConnMgr.Close;
     end;
  2: begin
     SQLConnMgr.DefaultTransaction.Rollback;
     SQLConnSrc.DefaultTransaction.Rollback;
     SQLConnMgr.Close;
     SQLConnSrc.Close;
     end;
  3: begin
     SQLConnMgr.DefaultTransaction.Rollback;
     SQLConnSrc.DefaultTransaction.Rollback;
     SQLConnTgt.DefaultTransaction.Rollback;
     SQLConnMgr.Close;
     SQLConnSrc.Close;
     SQLConnTgt.Close;
     end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  ReplIni: TIniFile;
  EvtStr : string;
begin
  Height := 204;
  Width := 413;
  ReplIni := TIniFile.Create(Extractfilepath(Application.ExeName)+'\REPL.INI');
  with ReplIni do begin
     EdIntervalo.Text := ReadString('CONFIGURACION', 'Intervalo', '0');
     EvtStr := ReadString('CONFIGURACION', 'EventResp', 'False');
  end;
  ReplIni.Free;
  if (EvtStr = 'True') then
     chkEventos.Checked := True
  else
     chkEventos.Checked := False;

 TIntervaloRepl.Interval := StrToInt( EdIntervalo.Text)*1000;
 TIntervaloRepl.Enabled := True;
 if (chkEventos.Checked) then
   IBEvent.Registered := True;


 StrCopy(ErrorFile,PChar(ExtractFilePath(Application.EXEName)));
 StrLCat(ErrorFile, PChar('replerrors.txt'),SizeOf(ErrorFile)-1);
end;

procedure TfrmMain.PasoValor(var Parametro: TParam; Valor: string);
var Ant:string;
begin
    Valor := Trim(Valor);
    case Parametro.DataType of
        ftUnknown       : Parametro.Value := Valor;
        ftString        : Parametro.AsString := Valor;
        ftSmallint      : Parametro.AsInteger := Trunc(StrToFloat(Valor));
        ftInteger       : Parametro.AsInteger := Trunc(StrToFloat(Valor));
        ftWord          : Parametro.AsInteger := Trunc(StrToFloat(Valor));
        ftBoolean       : begin
                            if Valor = 'True' then
                               Parametro.AsBoolean := True
                            else
                               Parametro.AsBoolean := False;
                          end;
        ftFloat         :  begin
                            Valor := StringReplace(Valor,'.',DecimalSeparator,[rfreplaceall]);
                            Parametro.AsFloat   := StrToFloat(Valor);
                           end;
        ftCurrency,
        ftBCD           : begin
                            Valor := StringReplace(Valor,'.',DecimalSeparator,[rfreplaceall]);
                            Parametro.AsCurrency  := StrToCurr(Valor);
                          end;
        ftDate          : begin
                           Ant := ShortDateFormat;
                           ShortDateFormat := 'yyyy-mm-dd';
                           Valor := StringReplace(Valor,'-','/',[rfreplaceall]);
                           Parametro.AsDate      := StrToDate(Valor);
                           ShortDateFormat := Ant;
                          end;
        ftTime          : Parametro.AsTime      := StrToTime(leftstr(Valor,8));
        ftDateTime      :begin
                           Ant := ShortDateFormat;
                           ShortDateFormat := 'yyyy-mm-dd';
                           Valor := StringReplace(Valor,'-','/',[rfreplaceall]);
                           Parametro.AsDateTime      := StrToDateTime(LeftStr(Valor,19));
                           ShortDateFormat := Ant;
                          end;
        ftFixedChar	: Parametro.AsString    := Valor;
        ftWideString    : Parametro.AsString    := Valor;
        ftLargeint      : begin
                            Valor := StringReplace(Valor,'.',DecimalSeparator,[rfreplaceall]);
                            Parametro.AsInteger   := Trunc(StrToFloat(Valor));
                          end;
        ftTimeStamp     :begin
                           Ant := ShortDateFormat;
                           ShortDateFormat := 'yyyy-mm-dd';
                           Valor := StringReplace(Valor,'-','/',[rfreplaceall]);
                           Parametro.AsDateTime      := StrToDateTime(LeftStr(Valor,19));
                           ShortDateFormat := Ant;
                          end;
    end;
end;

procedure TfrmMain.PasoParametro(Campo: TField; var Parametro: TParam);
var
  BlobField:TStream;
begin
      case Campo.DataType of
       ftString,
       ftFixedChar,
       ftWideString     : Parametro.AsString   := Campo.AsString;       //	Character or string field
       ftSmallint,                                                      //	16-bit integer field
       ftInteger,                                                       //      32-bit integer field
       ftAutoinc,                                                       //      Auto incremental integer
       ftWord,
       ftLargeint       : Parametro.AsInteger  := Campo.AsInteger;      //      16-bit unsigned integer field
       ftBoolean        : Parametro.AsBoolean  := Campo.AsBoolean ;     //	Boolean field
       ftFloat          : Parametro.AsFloat    := Campo.AsFloat;        //	Floating-point numeric field
       ftCurrency       : Parametro.AsCurrency := Campo.AsCurrency;     //	Money field
       ftBCD            : Parametro.AsBCD      := Campo.AsCurrency;     // 	Binary-Coded Decimal field that can be converted to Currency type without a loss of precision.
       ftDate           : Parametro.AsDate     := Campo.AsDateTime;     // 	Date field
       ftTime           : Parametro.AsTime     := Campo.AsDateTime;     //	Time field
       ftDateTime       : Parametro.AsDateTime := Campo.AsDateTime;     //	Date and time field
       ftBytes,
       ftVarBytes,
       ftblob           : begin                                         //	Fixed number of bytes (binary storage)
                           BlobField := TMemoryStream.Create;
                           (Campo as TBlobField).SaveToStream(BlobField);
                           BlobField.Seek(0,soFromBeginning);
//                           BlobSize := BlobField.Size;
                           Parametro.LoadFromStream(BlobField,ftBlob);
                           BlobField.Free;
                          end;
       ftMemo           : begin
                           BlobField := TMemoryStream.Create;
                           (Campo as TBlobField).SaveToStream(BlobField);
                           BlobField.Seek(0,soFromBeginning);
//                           BlobSize := BlobField.Size;
                           Parametro.LoadFromStream(BlobField,ftMemo);
                           BlobField.Free;
                          end;                                           //	Text memo field
       ftGraphic        : begin
                           BlobField := TMemoryStream.Create;
                           (Campo as TBlobField).SaveToStream(BlobField);
                           BlobField.Seek(0,soFromBeginning);
//                           BlobSize := BlobField.Size;
                           Parametro.LoadFromStream(BlobField,ftGraphic);
                           BlobField.Free;
                          end;                                           //	Bitmap field
       ftFmtMemo        : begin
                           BlobField := TMemoryStream.Create;
                           (Campo as TBlobField).SaveToStream(BlobField);
                           BlobField.Seek(0,soFromBeginning);
//                           BlobSize := BlobField.Size;
                           Parametro.LoadFromStream(BlobField,ftFmtMemo);
                           BlobField.Free;
                         end;                                          //	Formatted text memo field
{
       ftParadoxOle	Paradox OLE field
       ftDBaseOle	dBASE OLE field
       ftTypedBinary	Typed binary field
       ftCursor	Output cursor from an Oracle stored procedure (TParam only)
       ftADT	Abstract Data Type field
       ftArray	Array field
       ftReference	REF field
       ftDataSet	DataSet field
       ftOraBlob	BLOB fields in Oracle 8 tables
       ftOraClob	CLOB fields in Oracle 8 tables
}
       ftVariant        : Parametro.Value := Campo.Value;               //	Data of unknown or undetermined type
{
       ftInterface	References to interfaces (IUnknown)
       ftIDispatch	References to IDispatch interfaces
       ftGuid	globally unique identifier (GUID) values
}
       ftTimeStamp      : Parametro.AsDateTime := Campo.AsDateTime;     //	Date and time field accessed through dbExpress
//       ftFMTBcd	Binary-Coded Decimal field that is too large for ftBCD.
      end;
end;

function TfrmMain.EvaluoTipoDato(TipoDato: integer): TFieldType;
begin
        case TipoDato of
          7 : Result := ftSmallint;
          8 : Result := ftInteger;
         10 : Result := ftFloat;
         12 : Result := ftDate;
         13 : Result := ftTime;
         14,
         37,
         40 : Result := ftstring;
         16 : Result := ftLargeint;
         27 : Result := ftFloat;
         35 : Result := ftTimeStamp;
        end;
end;

procedure TfrmMain.ShowForm1Click(Sender: TObject);
begin
  Visible := True;
  SetFocus;
end;

procedure TfrmMain.Run1Click(Sender: TObject);
begin
  THacerReplicacion.Enabled := True;
end;

procedure TfrmMain.TrayIcon1RightBtnClick(Sender: TObject);
begin
  Visible := True;
  SetFocus;
end;

procedure TfrmMain.TrayIcon1LeftBtnClick(Sender: TObject);
begin
  Visible := False;
end;

procedure TfrmMain.SpeedButton4Click(Sender: TObject);
var
  ReplIni: TIniFile;
begin
   TIntervaloRepl.Enabled := False;
   IBEvent.Registered := False;
   ReplIni := TIniFile.Create(Extractfilepath(Application.ExeName)+'\REPL.INI');
   with ReplIni do begin
     WriteString('CONFIGURACION', 'Intervalo', EdIntervalo.Text);
     if chkEventos.Checked then
        WriteString('CONFIGURACION', 'EventResp', 'True')
     else
        WriteString('CONFIGURACION', 'EventResp', 'False');
   end;
   TIntervaloRepl.Interval := StrToInt( EdIntervalo.Text)*1000;
   TIntervaloRepl.Enabled := True;
   if (chkEventos.Checked) then
     IBEvent.Registered := True;
   ReplIni.Free;
end;

procedure TfrmMain.SpeedButton2Click(Sender: TObject);
begin
   frmErrorres.Show;
end;

procedure TfrmMain.SpeedButton5Click(Sender: TObject);
begin
  Visible := False;
end;

initialization
  TodoError := 0;
  FatalError := False;
  Ejecutando := False;
end.
