unit FrmSalida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ImgList, ToolWin, DBCtrls, DB,
  IBCustomDataSet, Grids, DBGrids, Buttons, ExtCtrls, IBDatabase, IBQuery,
  IBSQL;

type
  TSalida = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    no_salida: TLabel;
    fecha_salida: TDateTimePicker;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    dependencia: TLabel;
    Apellido: TLabel;
    nombre: TLabel;
    Label6: TLabel;
    Dbagencia: TDBLookupComboBox;
    dataagen: TDataSource;
    ibagencia: TIBDataSet;
    GroupBox3: TGroupBox;
    DataSource1: TDataSource;
    IBsalida: TIBDataSet;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    BCANCELAR: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    IBsql: TIBSQL;
    IBsel1: TIBQuery;
    IBdatos: TIBQuery;
    IBsel: TIBQuery;
    GroupBox4: TGroupBox;
    Bcerrar: TBitBtn;
    rsec: TRadioButton;
    remp: TRadioButton;
    Ibdel: TIBQuery;
    lista: TComboBox;
    IBDataSet1: TIBDataSet;
    Label5: TLabel;
    Nit_empleado: TEdit;
    listanit: TComboBox;
    nombre1: TMemo;
    IBsalidacantidad: TIntegerField;
    IBsalidacod_agencia: TSmallintField;
    IBsalidacod_articulo: TIntegerField;
    IBsalidafecha_entrega: TDateField;
    IBsalidanit_empleado: TIntegerField;
    IBsalidano_salida: TIntegerField;
    IBsalidacod_barras: TIntegerField;
    IBsalidanombre: TIBStringField;
    IBsalidadefinicion: TIBStringField;
    IBsalidacantidad_articulo: TIntegerField;
    IBsalidaprecio_salida: TIBBCDField;
    IBsalidacod_dependencia: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure IBsalidacod_barrasValidate(Sender: TField);
    procedure DbagenciaExit(Sender: TObject);
    procedure Nit_empleadoExit(Sender: TObject);
    procedure Nit_empleadoKeyPress(Sender: TObject; var Key: Char);
    procedure DbagenciaKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure BACEPTARClick(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IBsalidacod_articuloValidate(Sender: TField);
    procedure BCANCELARClick(Sender: TObject);
    procedure listaExit(Sender: TObject);
    procedure IBsalidaPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);

  private
    { Private declarations }
   procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
  public
  published
    procedure act_articulo;
    procedure limpiar;
    procedure NumericoSinPunto(Sender: TObject; var Key: Char);
    { Public declarations }
  end;

var
  Salida: TSalida;
  codigo_agencia:integer;
  existencia_articulo: integer;
  tipo: char;
  opcion:boolean;
  codigo_dependencia: integer;
  cerrar_salida: Integer;

implementation
Uses    frmprincipal,FrmArticulo,frmdatamodulo, frmentradadatos,frmempleados,frmdependencia,
  Frmreportesgenerales;
{$R *.dfm}

procedure TSalida.FormCreate(Sender: TObject);
var nombre,nombre1: string;
begin
        cerrar_salida:=0;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "inv$empleado"."nombre","inv$empleado"."apellido"  from "inv$empleado"');
          Open;
          while not DataGeneral.IBsel.Eof do
          begin
            nombre:=FieldByName('nombre').AsString + ' ' + fieldbyname('apellido').AsString;
            nombre1:=FieldByName('nombre').AsString + fieldbyname('apellido').AsString;
            lista.Items.Add(nombre);
            listanit.Items.Add(nombre1);
            DataGeneral.IBsel.Next;
          end;
          Close;
        end;
        fecha_salida.Date:=Date;
end;

procedure TSalida.IBsalidacod_barrasValidate(Sender: TField);
{var     coddar,narticulo:string;}
// MANEJO DE CODIGOS DE BARRAS ... OPCIONAL
begin
        {if remp.Checked = true then
        tipo:= 'E'
        else
        tipo:='S';
        with IBdatos do
        Begin
        close;
        Sql.Clear;
        Sql.Add('select "inv$articulo"."cod_articulo" as codigo, "inv$articulo"."nombre" as des, "inv$articulo"."existencia" as existencia from "inv$articulo"');
        Sql.Add('where "inv$articulo"."cod_barras"= :"cod_barra"');
        ParamByname('cod_barra').AsInteger := StrtoInt(IBsalidacod_barras.Text);
        open;
        coddar:=FieldByname('codigo').AsString;
        narticulo:=FieldByname('des').AsString;
        existencia_articulo:= strtoint(fieldbyname('existencia').AsString);
        if coddar='' then
        begin
        Showmessage('el Articulo no se Encuentra');
        articulo.cod_barras.Text:=IBsalidacod_barras.Text;
        entrada_articulo.Hide;
        articulo.ShowModal;
        end
        else
        begin
        //**
        IBsalidacod_articulo.Text := coddar;
        Ibsalidanombre.text :=narticulo;

        close;
        end;
        end;
        IBsalidano_salida.Text:=no_salida.Caption;
        IBsalidafecha_entrega.Text:=datetostr(fecha_salida.DateTime);
        Ibsalidanit_empleado.text:=nit_empleado.text;
        IBsalidacod_agencia.Text:=IntToStr(codigo_agencia);
        IBsalidadefinicion.Text:=tipo;
        ibsalidacantidad_articulo.Text:=inttostr(existencia_articulo);
        //codigob:=strtoint(ibentradacod_barras.Text);
        }
end;

procedure TSalida.DbagenciaExit(Sender: TObject);
begin
        With IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('Select "Inv$Agencia"."cod_agencia"  as cod from "Inv$Agencia"');
          SQL.Add('where "Inv$Agencia"."descripcion"=:"agencia"');
          ParamByName('agencia').AsString:=Dbagencia.Text;
          Open;
          codigo_agencia:=Fieldbyname('cod').AsInteger;
          Close;
        end;
          baceptar.Enabled:=true;
end;

procedure TSalida.Nit_empleadoExit(Sender: TObject);
var     nombres: string;
        nosalida:integer;
begin
        ibsalida.Active:=true;
        if lista.Text<>'' then
        begin
          with IBsql do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select max("inv$salida"."no_salida") as nosalida');
            SQL.Add(' from "inv$salida"');
            ExecQuery;
            nosalida:=FieldByName('nosalida').AsInteger;
            nosalida:=nosalida+1;
            no_salida.Caption:=inttostr(nosalida);
            Close;
          end;
          with IBdatos do
          begin
            Close;
            SQL.Clear;
            SQL.Add('Select "inv$empleado"."nombre" as nombre,"inv$empleado"."apellido" as apellido,');
            SQL.Add('"inv$dependencia"."nombre" as seccion, "inv$dependencia"."cod_dependencia" as cod from "inv$empleado","inv$dependencia"');
            SQL.Add('where "inv$empleado"."cod_dependencia"="inv$dependencia"."cod_dependencia" and');
            SQL.Add('"inv$empleado"."nit"=:"nit"');
            ParamByname('nit').AsInteger:=StrToInt(nit_empleado.Text);
            Open;
            nombres:= fieldbyname('nombre').AsString;
            if nombres = '' then
            begin
              ShowMessage('no existe el empleado');
              BitBtn1.SetFocus;
           end
             else
             begin
               dependencia.Caption:=FieldByName('seccion').AsString;
               codigo_dependencia:=strtoint(FieldByName('cod').AsString);
               nombre.Caption:= nombres;
               apellido.Caption:= FieldByName('apellido').AsString;
               nombre1.Text:=nombre.Caption + ' ' + apellido.Caption;
               Close;
             end;
        end;
        end;
end;

procedure TSalida.Nit_empleadoKeyPress(Sender: TObject; var Key: Char);
begin
        numericosinpunto(Self,Key);
        if key= #13 then
          dbagencia.SetFocus
end;

procedure TSalida.DbagenciaKeyPress(Sender: TObject; var Key: Char);
begin
        if key= #13 then
          dbgrid1.SetFocus;

end;

procedure TSalida.BitBtn1Click(Sender: TObject);
begin
        empleado := templeado.Create(self);
        empleado.IBDataSet1.Active:=true;
        empleado.openempleado:=true;
        empleado.nit.Text:=nit_empleado.Text;
        salida.Hide;
        empleado.ShowModal;

end;

procedure TSalida.act_articulo;
var     codigo_articulo,canarticulo,cantotal,cansalida:integer;
begin
        with IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "inv$salida"."cod_articulo" as cod');
          SQL.Add('from "inv$salida" ');
          SQL.Add('where "inv$salida"."no_salida"=:"no_salida"');
          ParamByName('no_salida').AsInteger:= strtoint(no_salida.Caption);
          Open;
          while  not IBdatos.Eof do
          begin
            codigo_articulo:=fieldbyname('cod').AsInteger;
            with IBsel do
            begin
              Close;
              SQL.Clear;
              SQL.Add('select "inv$articulo"."existencia" as existencia from "inv$articulo"');
              SQL.Add('where "inv$articulo"."cod_articulo"=:"cod_articulo"');
              ParamByName('cod_articulo').AsInteger:=codigo_articulo;
              Open;
              canarticulo:=FieldByName('existencia').AsInteger;
              Close;
            end;
               with IBsel do
               begin
                 Close;
                 SQL.Clear;
                 SQL.Add('select "inv$salida"."cantidad" as cantidad from "inv$salida"');
                 SQL.Add('where "inv$salida"."cod_articulo"=:"cod_articulo"');
                 SQL.Add('and "inv$salida"."no_salida"=:"salida"');
                 ParamByName('cod_articulo').AsInteger:=codigo_articulo;
                 ParamByName('salida').AsInteger:=strtoint(no_salida.Caption);
                 Open;
                 cansalida:=FieldByName('cantidad').AsInteger;
                 Close;
               end;
        cantotal:=canarticulo-cansalida;
        if cantotal < 0 then
        begin
        with ibdel do
        begin
        close;
        sql.Clear;
        sql.Add('delete from "inv$salida" where "inv$salida"."cod_articulo"=:"codigo" and');
        sql.Add('"inv$salida"."no_salida"=:"entrada"');
        parambyname('codigo').AsInteger:=codigo_articulo;
        parambyname('entrada').AsInteger:=strtoint(no_salida.Caption);
        open;
        close;
        datageneral.iBTransaction1.CommitRetaining;
        end;
        end
        else
        begin
        with IBsel1 do
        begin
        close;
        Sql.Clear;
        Sql.Add('update "inv$articulo"');
        Sql.Add('set "inv$articulo"."existencia"=:"nueva_can"');
        Sql.Add('where "inv$articulo"."cod_articulo"=:"cod_articulo"');
        parambyname('nueva_can').AsInteger:=cantotal;
        parambyname('cod_articulo').AsInteger:=codigo_articulo;
        open;
        close;
        datageneral.iBTransaction1.CommitRetaining;
        end;
        end;
        IBdatos.Next;
        end;
        IBdatos.Close;
        end;
        end;


procedure TSalida.BACEPTARClick(Sender: TObject);
var    Mensaje :String;
begin
        try
          IBsalida.Insert;
          datageneral.IBTransaction1.CommitRetaining;
          act_articulo;
          cerrar_salida:=1;
          if MessageDlg('Desea ver el Reporte de Salida',mtConfirmation,[mbYes,mbNo],0) = mrYes Then
          begin
            reportes:=treportes.Create(self);
            lugar:=frmain.wpath+'reportes\Regsalida.frf';
            reportes.frDBDataSet1.DataSet:=reportes.regsalida;
            reportes.regsalida.ParamByName('codigo').AsInteger:=strtoint(no_salida.Caption);
            reportes.regsalida.Open;
            reportes.imprimir_reporte(lugar);
         end;
           Limpiar;
        except
        on E: Exception do      
        begin
          Mensaje:= IBsalidacod_articulo.Text;
          ShowMessage('Elimine o Modifique El Registro con Codigo: '+ mensaje);
          DBGrid1.SetFocus
        end
        end;
end;

procedure TSalida.BcerrarClick(Sender: TObject);
begin
        if ibsalidacod_articulo.Text='' then
        begin
        bcerrar.Enabled:=false;
        dbgrid1.SetFocus;
        end
        else
        ibsalida.Delete;
        dbgrid1.SetFocus;
end;

procedure TSalida.BitBtn2Click(Sender: TObject);
begin
        close;
end;

procedure TSalida.limpiar;
begin
        nit_empleado.Text:='';
        no_salida.Caption:='';
        dependencia.Caption:='';
        nombre.Caption:='';
        nombre1.Text:='';
        apellido.Caption:='';
        no_salida.Caption:='';
        ibsalida.Close;
        ibsalida.Open;
        lista.ItemIndex:=-1;
        baceptar.Enabled:=false;
        ibagencia.Close;
        lista.SetFocus;
        datageneral.IBTransaction1.RollbackRetaining;
        end;

procedure Tsalida.cmChildKey(var msg: TWMKEY);
begin
  if msg.CharCode = VK_RETURN then
    if not (Assigned(ActiveControl) and
           ((ActiveControl is TButton) or
            (ActiveControl is TCustomMemo)))
    then begin
      msg.Result := 1;
      keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), 0, 0);
              keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), KEYEVENTF_KEYUP, 0);
    end;
end;

procedure TSalida.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        datageneral.IBTransaction1.RollbackRetaining;
        if cerrar_salida = 0 then
        IBsalida.Transaction.RollbackRetaining;
        limpiar;
        FrMain.actualizar;
end;

procedure TSalida.NumericoSinPunto(Sender: TObject; var Key: Char);
begin
if not (Key in [#8,#13, '0'..'9']) then
  begin
  Key := #0;
  end //End First if.
  else
  if ((Key = DecimalSeparator) or (Key = '-')) and (Pos(Key, TMemo(Sender).Text ) > 0) then
  begin
    Key := #0;
  end//End second if.
  else
  if (Key = '-') and (TMemo(Sender).SelStart <> 0) then
  begin
    Key := #0;
  end;//End third if.
end;

procedure TSalida.IBsalidacod_articuloValidate(Sender: TField);
var    precio,coddar,narticulo:string;
       stock,existencia:string;
begin
        if Nit_empleado.Text = '0' then
        begin
           MessageDlg('La Información del Empleado no es Correcta, Favor Verifique',mtInformation,[mbok],0);
           IBsalida.Cancel;
           lista.SetFocus;
           Exit;
        end;
        if remp.Checked = True then
          tipo:= 'E'
        else
          tipo:='S';
        with IBdatos do
        Begin
          close;
          Sql.Clear;
          Sql.Add('select "inv$articulo"."cod_articulo" as codigo, "inv$articulo"."nombre" as des, "inv$articulo"."existencia" as existencia,');
          Sql.Add('"inv$articulo"."precio_unitario" as precio,');
          SQL.Add('"inv$articulo"."stock" as stock,"inv$articulo"."existencia" as stock');
          SQL.Add('from "inv$articulo"');
          Sql.Add('where "inv$articulo"."cod_articulo"= :"cod_articulo"');
          ParamByname('cod_articulo').AsInteger := StrtoInt(IBsalidacod_articulo.Text);
          open;
          coddar:=FieldByname('codigo').AsString;
          stock:= FieldByname('stock').AsString;
          existencia:=FieldByname('existencia').AsString;
            if coddar='' then
            begin
              ShowMessage('el Articulo no se Encuentra');
            end
            else
            begin
              if (stock <> '') or (stock <> '0') then
              begin
                if StrToInt(existencia) <= StrToInt(stock) then
                   ShowMessage('el Articulo se Encuentra en su Stock Minimo');
              end;
                narticulo := FieldByname('des').AsString;
                existencia_articulo := StrToInt(fieldbyname('existencia').AsString);
                precio:= fieldbyname('precio').AsString;
                Ibsalidanombre.text :=narticulo;
                close;
            end;
        end;
        IBsalidano_salida.Text := no_salida.Caption;
        IBsalidafecha_entrega.Text := datetostr(fecha_salida.DateTime);
        Ibsalidanit_empleado.Text := nit_empleado.text;
        IBsalidacod_agencia.Text := IntToStr(codigo_agencia);
        IBsalidadefinicion.Text := tipo;
        ibsalidacod_barras.Text := '0';
        IBsalidacantidad_articulo.Text := IntToStr(existencia_articulo);
        IBsalidaprecio_salida.Text:= precio;
        Ibsalidacod_dependencia.Text := IntToStr(codigo_dependencia);
        bcerrar.Enabled := True;
end;
procedure TSalida.BCANCELARClick(Sender: TObject);
begin
        limpiar;
end;

procedure TSalida.listaExit(Sender: TObject);
var     a,nit_emp:integer;
        b:string;
        nombres: string;
        nosalida:integer;
begin
        IBagencia.Active := True;
        ibagencia.Last;
        a := lista.ItemIndex;
        listanit.ItemIndex :=a;
        b := listanit.Text;
        IBDataSet1.ParamByName('nombre').AsString:=b;
        IBDataSet1.Open;
        nit_emp := ibdataset1.fieldbyname('nit').AsInteger;
        ibsalida.Active := True;
        if lista.Text <> '' then
          begin
            with IBsql do
            begin
              Sql.Clear;
              Sql.Add('select max("inv$salida"."no_salida") as nosalida');
              sql.Add('from "inv$salida"');
              ExecQuery;
              nosalida := FieldByName('nosalida').AsInteger;
              nosalida := nosalida + 1;
              no_salida.Caption := IntToStr(nosalida);
              Close;
            end;
              with IBdatos do
              begin
        Close;
        SQL.Clear;
        SQL.Add('Select "inv$empleado"."nombre" as nombre,"inv$empleado"."apellido" as apellido,');
        SQL.Add('"inv$dependencia"."nombre" as seccion, "inv$dependencia"."cod_dependencia" as cod from "inv$empleado","inv$dependencia"');
        SQL.Add('where "inv$empleado"."cod_dependencia"="inv$dependencia"."cod_dependencia" and');
        SQL.Add('"inv$empleado"."nit"=:"nit"');
        ParamByname('nit').AsInteger:=nit_emp;
        nit_empleado.Text := IntToStr(nit_emp);
        Open;
        nombres := FieldByName('nombre').AsString;
        if nombres = '' then
        begin
        ShowMessage('no existe el empleado');
        BitBtn1.SetFocus;
        end
        else
        begin
        dependencia.Caption := FieldByName('seccion').AsString;
        codigo_dependencia := StrToInt(FieldByName('cod').AsString);
        nombre.Caption := nombres;
        apellido.Caption := fieldbyname('apellido').AsString;
        nombre1.Text := nombre.Caption + ' ' + apellido.Caption;
        Close;
        end;
        end;
        end;
        IBDataSet1.Close;
end;

procedure TSalida.IBsalidaPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);  
var     mensaje : string;
begin
        if E.Message <> '' then
        begin
            mensaje := IBsalidacod_articulo.Text;
            DBGrid1.SetFocus;
            E.Message:='Favor Verifique la Informción - ' + E.Message;
        end;
end;

end.
