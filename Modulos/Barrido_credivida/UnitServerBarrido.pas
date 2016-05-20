unit UnitServerBarrido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JclShell,sdXmlDocuments,strutils,  ShellApi,
  ExtCtrls, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls,
  IdThreadMgr, IdThreadMgrDefault, DB, DBClient, JvComponent, JvTrayIcon,
  Menus, ADODB, JvAlarms;
type
  leer = record
    poliza :string;
    texto :string;
    estado :string;
end;
type
  TFrmServerConsultas = class(TForm)
    IdTCPServer1: TIdTCPServer;
    IdThread: TIdThreadMgrDefault;
    Memo1: TMemo;
    Memo2: TMemo;
    JvTrayIcon1: TJvTrayIcon;
    PopupMenu1: TPopupMenu;
    CerrarEquivida1: TMenuItem;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    CDbeneficiarios: TClientDataSet;
    CDbeneficiariosnombre: TStringField;
    CDbeneficiariosporciento: TCurrencyField;
    CDbeneficiariosparentesco: TIntegerField;
    CDbeneficiariosid_persona: TStringField;
    DBcredivida: TClientDataSet;
    DBcredividanombre: TStringField;
    DBcredividaid_persona: TStringField;
    DBcredividadireccion: TStringField;
    DBcredividatelefono: TStringField;
    DBcredividaciudad: TStringField;
    DBcredividaciudad_nacimiento: TStringField;
    DBcredividaid_identificacion: TSmallintField;
    DBcredividafecha_nacimiento: TStringField;
    DBcredividacertificado: TStringField;
    DBcredividadg: TIntegerField;
    DBcredividacuenta: TIntegerField;
    DBcredividafecha: TDateField;
    Timer1: TTimer;
    procedure IdTCPServer1Execute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
    procedure JvTrayIcon1BalloonHide(Sender: TObject);
    procedure CerrarEquivida1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    function lee_archivo(cadena:string): leer;
    procedure ejecutar(Ejecutable, Argumentos: string;
      Visibilidad: integer);
    function formato(cadena, caracter: string; tamano: integer): string;    { Private declarations }
  public
  published

    function recupera: string;

    { Public declarations }
  end;

var
  FrmServerConsultas: TFrmServerConsultas;

implementation

{$R *.dfm}

procedure TFrmServerConsultas.IdTCPServer1Execute(AThread: TIdPeerThread);
var     Astream :TStringStream;
        Astream1 :TMemoryStream;
        XmlDoc,Xmlres,XmlError :TsdXmlDocument;
        tamano :Integer;
        nodo,nodo1 :TXmlNode;
        i :Integer;
        cadena,cadena1 :string;
        Archivo :string;
        sentencia :string;
        vIdPersona :String;
        Poliza :string;
        Opcion :Integer;
        vFecha1,Vfecha2 :string;
        vCadena:string;
        vArchivo :TStringList;
begin
        ADOConnection1.DefaultDatabase := 'C:\convenio\Data\equivida.dbc';
        ADOConnection1.Connected := True;
        DBcredivida.CancelUpdates;
        CDbeneficiarios.CancelUpdates;
        XmlDoc :=  TsdXmlDocument.Create; //xml de entrada
        XmlDoc.EncodingString := 'ISO8859-1';
        XmlDoc.XmlFormat := xfReadable;
        Xmlres := TsdXmlDocument.CreateName('retorno');// xml de salida
        Xmlres.EncodingString := 'ISO8859-1';
        Xmlres.XmlFormat := xfReadable;
        XmlError := TsdXmlDocument.CreateName('retorno');// xml de salida
        XmlError.EncodingString := 'ISO8859-1';
        XmlError.XmlFormat := xfReadable;
        Astream := TStringStream.Create('');
        try
          tamano := AThread.Connection.ReadInteger;
          AThread.Connection.ReadStream(Astream,tamano,false);
        except
          Exit;
        end;
        XmlDoc.LoadFromStream(Astream);
        nodo := XmlDoc.Root.NodeByName('Tipo');
        Opcion := nodo.ReadInteger('Opcion');
        if Opcion = 1 then// barrido de renovación de credividas
        begin
        try
          XmlDoc.SaveToFile('c:\opcion2.xml');
          nodo := XmlDoc.Root.NodeByName('Asociados');
          for i := 0 to nodo.NodeCount - 1 do //inicio primer for
          begin
            sentencia := 'select certificado from equivida where equivida.numdocum = ' + '''' + nodo.Nodes[i].ReadString('cedula') + '''' + ' and equivida.fecha_venc = {d' + '''' + nodo.Nodes[i].ReadString('fechav') + '''' + '}';
            DBcredivida.Append;
            DBcredivida.FieldValues['id_identificacion'] := nodo.Nodes[i].ReadInteger('id');
            DBcredivida.FieldValues['id_persona'] := nodo.Nodes[i].ReadString('cedula');
            DBcredivida.FieldValues['nombre'] := nodo.Nodes[i].ReadString('nombre');
            DBcredivida.FieldValues['direccion'] := nodo.Nodes[i].ReadString('direccion');
            DBcredivida.FieldValues['telefono'] := nodo.Nodes[i].ReadString('telefono');
            DBcredivida.FieldValues['ciudad'] := nodo.Nodes[i].ReadString('ciudad');
            DBcredivida.FieldValues['ciudad_nacimiento'] := nodo.Nodes[i].ReadString('ciudad_nacimiento');
            DBcredivida.FieldValues['fecha_nacimiento'] := nodo.Nodes[i].ReadString('fecha_nacimiento');
            DBcredivida.FieldValues['dg'] := nodo.Nodes[i].ReadInteger('dg');
            DBcredivida.FieldValues['cuenta'] := nodo.Nodes[i].ReadInteger('cuenta');
            DBcredivida.FieldValues['fecha'] := nodo.Nodes[i].ReadDateTime('fechav');
            with ADOQuery1 do
            begin
              Close;
              SQL.Clear;
              SQL.Add(sentencia);
              Open;
              Memo1.Lines.Add(FieldByName('certificado').AsString + ', ' + nodo.Nodes[i].ReadString('cedula') );
              DBcredivida.FieldValues['certificado'] := Trim(FieldByName('certificado').AsString);
            end;
            DBcredivida.Post;
           end; // fin del primer for
          nodo := XmlDoc.Root.NodeByName('Beneficiarios');
          for i := 0 to nodo.NodeCount - 1 do// segundo for
          begin
            with CDbeneficiarios do
            begin
              Append;
              FieldValues['id_persona'] := nodo.Nodes[i].ReadString('cedula');
              FieldValues['nombre'] := nodo.Nodes[i].ReadString('nombre');
              FieldValues['porciento'] := nodo.Nodes[i].ReadFloat('porciento');
              FieldValues['parentesco'] := nodo.Nodes[i].ReadInteger('parentesco');
              Post;
            end;
          end; // fin del segundo for
          Memo1.Text := '';
          Memo2.Text := '';
          nodo := Xmlres.Root.NodeNew('ERROR');
          nodo.WriteString('ERROR','F');
          with DBcredivida do // inicio dbcredivida
          begin
            if RecordCount > 0 then
               nodo := Xmlres.Root.NodeNew('salidas');
            First;
            while not Eof do // inicio primer while
            begin
              cadena := '';
              cadena1 := '';
              Poliza := Trim(FieldByName('certificado').AsString);
              vIdPersona := Trim(FieldByName('id_persona').AsString);
              Archivo := vIdPersona;
              nodo1 := nodo.NodeNew('salida');
              if Poliza <> '' then // inicio valida poliza
              begin
                cadena := vIdPersona + #9 + FieldByName('nombre').AsString +
                #9 + FieldByName('direccion').AsString + #9 + FieldByName('telefono').AsString+ #9 +
                Poliza + #9 + FieldByName('ciudad').AsString + #9 +
                FieldByName('ciudad_nacimiento').AsString + #9 + FieldByName('fecha_nacimiento').AsString;
                with CDbeneficiarios do  // inicio cdbeneficiarios
                begin
                  Filtered := False;
                  Filter := 'id_persona = ' + '''' + vIdPersona + '''';
                  Filtered := True;
                  while not Eof do // inicio segundo while
                  begin
                    if RecNo = 1 then
                       cadena1 := FieldByName('nombre').AsString + #9 + FieldByName('porciento').AsString + #9 + FieldByName('parentesco').AsString
                    else
                       cadena1 := cadena1 + #9 + FieldByName('nombre').AsString + #9 + FieldByName('porciento').AsString + #9 + FieldByName('parentesco').AsString;
                    Next;
                  end; // fin segundo while
                end; // fin cdbeneficiarios
                cadena := cadena + #9 + cadena1;
                Memo1.Text := cadena;
                Memo1.Lines.SaveToFile('c:\convenio\entrada\'+ Archivo + '.txt');
                ejecutar('c:\convenio\importar\importar.exe','',2);
                Sleep(100);
                if FileExists('c:\convenio\salida\'+ Archivo + '.res') then // inicio valida archivo
                begin
                  nodo1.WriteString('id_persona',vIdPersona);
                  nodo1.WriteString('poliza',poliza);
                  nodo1.WriteString('texto',lee_archivo('c:\convenio\salida\'+ Archivo + '.res').texto);
                  nodo1.WriteString('estado',lee_archivo('c:\convenio\salida\'+ Archivo + '.res').estado);
                  nodo1.WriteInteger('dg',FieldByName('dg').AsInteger);
                  nodo1.WriteInteger('cuenta',FieldByName('cuenta').AsInteger);
                  nodo1.WriteInteger('id_identificacion',FieldByName('id_identificacion').AsInteger);
                  nodo1.WriteDateTime('fecha',FieldByName('fecha').AsDateTime);
                end
                else
                begin
                  nodo1.WriteString('id_persona',vIdPersona);
                  nodo1.WriteString('poliza','0');
                  nodo1.WriteString('texto','No Existe Archivo de Salida');
                  nodo1.WriteString('estado','F');
                  nodo1.WriteInteger('dg',FieldByName('dg').AsInteger);
                  nodo1.WriteInteger('cuenta',FieldByName('cuenta').AsInteger);
                  nodo1.WriteInteger('id_identificacion',FieldByName('id_identificacion').AsInteger);
                  nodo1.WriteDateTime('fecha',FieldByName('fecha').AsDateTime);
                end; // fin valida archivo
                DeleteFile('c:\convenio\salida\'+ Archivo + '.res');
              end
              else
              begin
                nodo1.WriteString('id_persona',vIdPersona);
                nodo1.WriteString('poliza','0');
                nodo1.WriteString('texto','Numero de Poliza no Encontrada');
                nodo1.WriteString('estado','F');
                nodo1.WriteInteger('dg',FieldByName('dg').AsInteger);
                nodo1.WriteInteger('cuenta',FieldByName('cuenta').AsInteger);
                nodo1.WriteInteger('id_identificacion',FieldByName('id_identificacion').AsInteger);
                nodo1.WriteDateTime('fecha',FieldByName('fecha').AsDateTime);
              end; // fin valida poliza
              Next;
            end; // fin del primer while
          end; // fin db credivida
          Xmlres.SaveToStream(Astream);
          AThread.Connection.WriteInteger(Astream.Size);
          AThread.Connection.OpenWriteBuffer;
          AThread.Connection.WriteStream(Astream);
          AThread.Connection.CloseWriteBuffer;
        except
        on e: Exception do
        begin
          nodo := XmlError.Root.NodeNew('ERROR');
          nodo.WriteString('ERROR','V');
          nodo.WriteString('MENSAJE',e.Message);
          XmlError.SaveToStream(Astream);
          AThread.Connection.WriteInteger(Astream.Size);
          AThread.Connection.OpenWriteBuffer;
          AThread.Connection.WriteStream(Astream);
          AThread.Connection.CloseWriteBuffer;
          AThread.Connection.Disconnect;
        end; // fin delñ aexception
        end; // fin del primer try
      end // fin opcion 1
      else if Opcion = 2 then // valida la opcion para la consulta de credividas
      begin
        nodo := XmlDoc.Root.NodeByName('registro');
        sentencia := 'select certificado,fecha_venc from equivida where equivida.eliminado = 0 and equivida.siniestrado = 0 and equivida.numdocum = ' + '''' + nodo.ReadString('cedula') + '''';
        try
        with ADOQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add(sentencia);
          Open;
            while not Eof do
            begin
               if FieldByName('fecha_venc').AsDateTime > Date then
               begin
                 nodo := Xmlres.Root.NodeNew('certificado');
                 nodo.ValueAsString := (LeftStr(FieldByName('certificado').AsString,7) + ' - ' + FormatDateTime('yyy/mm/dd',fieldByName('fecha_venc').AsDateTime) + ' Vigente');
               end
               else if (FieldByName('fecha_venc').AsDateTime + 30) > Date then
               begin
                 nodo := Xmlres.Root.NodeNew('certificado');
                 nodo.ValueAsString := (LeftStr(FieldByName('certificado').AsString,7) + ' - ' + FormatDateTime('yyy/mm/dd',fieldByName('fecha_venc').AsDateTime) + ' Renovar');
               end;
              Next;
            end;
       end;
        Astream := TStringStream.Create('');
        Xmlres.SaveToStream(Astream);
        AThread.Connection.WriteInteger(Astream.Size);
        AThread.Connection.OpenWriteBuffer;
        AThread.Connection.WriteStream(Astream);
        AThread.Connection.CloseWriteBuffer;
       except
       on e: Exception do
           ADOQuery1.Close;
       end;
      end // fin opcion 2
      else if Opcion = 3 then //generar archivo plano para la equidad
      begin
        nodo := Xmldoc.Root.NodeByName('Fechas');
        vFecha1 := nodo.ReadString('vf1');
        vFecha2 := nodo.ReadString('vf2');
        sentencia := 'SELECT equivida.certificado,' +
                     'equivida.fecha_venc, equivida.nombreaseg, ' +
                     'equivida.valoraseg, equivida.numdocum ' +
                     'FROM equivida equivida ' +
                     'WHERE (equivida.eliminado=0) AND' +
                     ' (equivida.siniestrado=0) AND' +
                     ' (equivida.fechacaptura Between' +
                     ' {d '+ '''' + vFecha1 + '''' +'} And {d' + '''' + vfecha2 + '''' + '}' + ')';
        Memo1.Clear;
        Memo1.Text := sentencia;
        with ADOQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add(sentencia);
          Open;
          if RecordCount <> 0 then
          begin
             vArchivo := TStringList.Create;
             nodo := Xmlres.Root.NodeNew('Registro');
          end;
          while not Eof do
          begin
              nodo1 := nodo.NodeNew('v' + formatcurr('000',RecNo));
              nodo1.WriteString('nombre',Format('%.31s',[PChar(ADOQuery1.FieldByName('nombreaseg').AsString)]));
              nodo1.WriteString('documento',formato(Trim(ADOQuery1.FieldByName('numdocum').AsString),'0',12));
              nodo1.WriteString('valor',Format('%.8s',[ADOQuery1.FieldByName('valoraseg').AsString]));
              nodo1.WriteString('certificado',Format('%.7s',[PChar(ADOQuery1.FieldByName('certificado').AsString)]));
              vCadena := '';
              vCadena := '0745';
              vCadena := vCadena + Format('%.31s',[PChar(ADOQuery1.FieldByName('nombreaseg').AsString)]);
              vCadena := vCadena + formato(Trim(ADOQuery1.FieldByName('numdocum').AsString),'0',12);
              vCadena := vCadena + Format('%.8s',[ADOQuery1.FieldByName('valoraseg').AsString]);     //vCadena + Format('%.8s',[ADOQuery1.FieldByName('valoraseg').asfloat]);
              vCadena := vCadena + Format('%.7s',[PChar(ADOQuery1.FieldByName('certificado').AsString)]);
              vArchivo.Add(vCadena);
              Next;
          end;
          Astream1 := TMemoryStream.Create;
          Xmlres.SaveToStream(astream1);
          AThread.Connection.WriteInteger(Astream1.Size);
          AThread.Connection.OpenWriteBuffer;
          AThread.Connection.WriteStream(Astream1);
          AThread.Connection.CloseWriteBuffer;
        end;
      end // fin opcion 3
      else if Opcion = 4 then // PLANOS CREDIVIDAS
      begin
        nodo := Xmldoc.Root.NodeByName('Fechas');
        vFecha1 := nodo.ReadString('vf1');
        sentencia := 'SELECT equivida.fecha_venc, equivida.certificado, equivida.numdocum, equivida.nombreaseg, personas.ciudad, personas.direccion, personas.telefono ' +
                     'FROM equivida equivida, personas personas ' +
                     'WHERE personas.numdocum = equivida.numdocum AND (equivida.fecha_venc={d '+ '''' + vFecha1 + '''' +'})';
        Memo1.Text := sentencia;
        with ADOQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add(sentencia);
          Open;
          if RecordCount <> 0 then
             nodo := Xmlres.Root.NodeNew('Registro');
          while not Eof do
          begin
            nodo1 := nodo.NodeNew('v' + formatcurr('000',RecNo));
            nodo1.WriteString('nombre',ADOQuery1.FieldByName('nombreaseg').AsString);
            nodo1.WriteString('direccion',ADOQuery1.FieldByName('direccion').AsString);
            nodo1.WriteString('telefono',ADOQuery1.FieldByName('telefono').AsString);
            nodo1.WriteString('certificado',ADOQuery1.FieldByName('certificado').AsString);
            nodo1.WriteString('documento',ADOQuery1.FieldByName('numdocum').AsString);
            Next;
          end;
        end;
          Astream1 := TMemoryStream.Create;
          Xmlres.SaveToStream(astream1);
          AThread.Connection.WriteInteger(Astream1.Size);
          AThread.Connection.OpenWriteBuffer;
          AThread.Connection.WriteStream(Astream1);
          AThread.Connection.CloseWriteBuffer;
      end;// FIN OPCION 4
      ADOConnection1.Connected := False;
end;

function TFrmServerConsultas.lee_archivo(cadena:string): leer;
var
        a :TStringList;
        F:TextFile;
        S:string;
begin
        if FileExists(cadena) then begin
          AssignFile(F, cadena);
          Reset(F);
        while not EOF(F) do begin
          ReadLn(F, S);
        end;
          CloseFile(F);
          a := TStringList.Create;
          a.Text := StringReplace(s,#9,#13,[rfreplaceall]);
          Result.poliza := a.Strings[0];
          Result.texto :=  a.Strings[1];
          Result.estado := Trim(a.Strings[2]);
end;

end;

function TFrmServerConsultas.recupera: string;
begin
end;

procedure TFrmServerConsultas.FormCreate(Sender: TObject);
begin
ShowWindow( Application.Handle, SW_HIDE );
   SetWindowLong( Application.Handle, GWL_EXSTYLE,
                  GetWindowLong(Application.Handle, GWL_EXSTYLE) or
                  WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
   ShowWindow( Application.Handle, SW_SHOW );
   JvTrayIcon1.Active := True;
   ShowWindow(Application.Handle, SW_MINIMIZE);
end;

procedure TFrmServerConsultas.ejecutar(Ejecutable, Argumentos: string;
  Visibilidad: integer);
var
      Info:TShellExecuteInfo;
      pInfo:PShellExecuteInfo;
      exitCode:DWord;
   begin
      {Puntero a Info}
      {Pointer to Info}
      pInfo:=@Info;
      {Rellenamos Info}
      {Fill info}
      With Info do
      begin
       cbSize:=SizeOf(Info);
       fMask:=SEE_MASK_NOCLOSEPROCESS;
       wnd:=Handle;
       lpVerb:=nil;
       lpFile:=PChar(Ejecutable);
       lpParameters:=Pchar(Argumentos+#0);
       lpDirectory:=nil;
       nShow:=Visibilidad;
       hInstApp:=0;
      end;
      ShellExecuteEx(pInfo);
      repeat
       exitCode := WaitForSingleObject(Info.hProcess,500);
       Application.ProcessMessages;
      until (exitCode <> WAIT_TIMEOUT);
end;

procedure TFrmServerConsultas.JvTrayIcon1BalloonHide(Sender: TObject);
begin
        MessageDlg('Servidor Credivida',mtInformation,[mbok],0);
end;

procedure TFrmServerConsultas.CerrarEquivida1Click(Sender: TObject);
begin
        JvTrayIcon1.Active := False;
        IdTCPServer1.Active := False;
        Close;
end;


function TFrmServerConsultas.formato(cadena, caracter: string;
  tamano: integer): string;
var     vTamano,i :Integer;
        vCar :string;
begin
        vTamano := tamano - Length(cadena);
        for i := 0 to vtamano - 1 do
            vCar := vCar + caracter;
        Result := vCar + cadena;
end;

procedure TFrmServerConsultas.Timer1Timer(Sender: TObject);
begin
        //if Time >= StrToTime('14:18:00') THEN
        //   ShowMessage('SON LAS ' + TimeToStr(Time));
end;

end.

