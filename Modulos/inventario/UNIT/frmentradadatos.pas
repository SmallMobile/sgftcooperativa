unit frmentradadatos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ComCtrls, ToolWin, Grids, DBGrids, DB,
  IBCustomDataSet, Buttons, ExtCtrls, IBSQL, IBQuery, IBDatabase;

type
    TEntrada_Articulo = class(TForm)
    ImageList1: TImageList;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    fecha_entrada: TDateTimePicker;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    nit_proveedor: TEdit;
    grupo2: TGroupBox;
    Label5: TLabel;
    no_factura: TEdit;
    kkk: TLabel;
    descripcion_fact: TMemo;
    Label6: TLabel;
    Garantia: TMemo;
    GroupBox4: TGroupBox;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    IBentrada: TIBDataSet;
    BitBtn1: TBitBtn;
    Label7: TLabel;
    telefono: TLabel;
    IBDataSet1: TIBDataSet;
    IBDataSet1cod_articulo: TIntegerField;
    IBDataSet1cod_barras: TIntegerField;
    IBDataSet1nombre: TIBStringField;
    IBDataSet1existencia: TFloatField;
    IBDataSet1cod_clasificacion: TIntegerField;
    nombre_p: TMemo;
    Label4: TLabel;
    no_entrada: TLabel;
    Panel1: TPanel;
    BACEPTAR: TBitBtn;
    BCANCELAR: TBitBtn;
    BitBtn2: TBitBtn;
    Label8: TLabel;
    Bcerrar: TBitBtn;
    Label11: TLabel;
    Label12: TLabel;
    IBdatos: TIBQuery;
    IBsql: TIBSQL;
    IBsel: TIBQuery;
    IBsel1: TIBQuery;
    ibsel3: TIBQuery;
    IBentradacantidad: TIntegerField;
    IBentradacod_articulo: TIntegerField;
    IBentradacod_factura: TIntegerField;
    IBentradafecha_entrada: TDateField;
    IBentradanit_proveedor: TIBBCDField;
    IBentradano_entrada: TIntegerField;
    IBentradaprecio_unidad: TIBBCDField;
    IBentradacod_barras: TIntegerField;
    IBentradanombre: TIBStringField;
    IBentradacantidad_articulo: TIntegerField;
    IBentradaprecio_unitario: TIBBCDField;
    procedure FormCreate(Sender: TObject);
    procedure IBentradacod_barrasValidate(Sender: TField);
    procedure nit_proveedorExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure no_facturaExit(Sender: TObject);
    procedure nit_proveedorKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure no_facturaKeyPress(Sender: TObject; var Key: Char);
    procedure descripcion_factKeyPress(Sender: TObject; var Key: Char);
    procedure GarantiaKeyPress(Sender: TObject; var Key: Char);
    procedure BACEPTARClick(Sender: TObject);
    procedure BcerrarClick(Sender: TObject);
    procedure BCANCELARClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IBentradacantidadValidate(Sender: TField);
    procedure IBentradacod_articuloValidate(Sender: TField);
    procedure IBentradaprecio_unitarioValidate(Sender: TField);
    procedure IBentradaPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);



     private
      procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    { Private declarations }

  public
  regimen:string;
   published
    procedure entra_factura;
    procedure limpia_datos;
    procedure actualizar_articulo;
    procedure act_articulo;
    { Public declarations }
  end;

var
        Entrada_Articulo: TEntrada_Articulo;
        Codigo_Factura:integer;
        entra:boolean;
        codigob:integer;
        factura: boolean;
        sum_art:integer;

implementation
Uses   frmproveedores,frmreportesgenerales,frmarticulo,frmdependencia,FRMPRINCIPAL,
  FrmDatamodulo;
{$R *.dfm}

procedure TEntrada_Articulo.FormCreate(Sender: TObject);
begin

        fecha_entrada.Date:=date;
        fecha_entrada.MaxDate := Date;
        sum_art:=1;
end;

procedure TEntrada_Articulo.IBentradacod_barrasValidate(Sender: TField);
{var     coddar:string;
        cantidad_ar: integer;} // CODIGO PARA EL MANEJO DE CODIGO DE BARRAS... OPCIONAL

begin

        {with DataGeneral.IBdatos do
        Begin
        close;
        Sql.Clear;
        Sql.Add('select "inv$articulo"."cod_articulo" as codigo, "inv$articulo"."nombre" as nombre,');
        sql.Add('"inv$articulo"."existencia" as cantidad from  "inv$articulo"');
        Sql.Add('where "inv$articulo"."cod_barras"= :"cod_barra"');
        ParamByname('cod_barra').AsInteger := StrtoInt(IBentradacod_barras.Text);
        open;
        coddar:=FieldByname('codigo').AsString;
        cantidad_ar:= fieldbyname('cantidad').AsInteger;
        ibentradanombre.Text:=Fieldbyname('nombre').AsString;
        if coddar='' then
        begin
        Showmessage('el Articulo no se Encuentra');
        articulo.openarticulo:= True;
        articulo.cod_barras.Text:=ibentradacod_barras.Text;
        entrada_articulo.Hide;
        articulo.ShowModal;
        end
        else
        //**
        IBentradacod_articulo.Text := coddar;
        close;
        end;
        IBentradano_entrada.Text:=no_entrada.Caption;
        IBentradafecha_entrada.Text:=datetostr(fecha_entrada.DateTime);
        IBentradanit_proveedor.Text:=nit_proveedor.Text;
        IBentradacod_Factura.Text:=IntToStr(codigo_factura);
        codigob:=strtoint(ibentradacod_barras.Text);
        IBentradacantidad_articulo.Text:=inttostr(cantidad_ar);
        bcerrar.Enabled:=true;
        end; }
    end;

procedure TEntrada_Articulo.nit_proveedorExit(Sender: TObject);
var     noentra:integer;
        op:string;
begin
        factura:=false;
        if nit_proveedor.Text <> '' then begin
            with IBsql do
            begin
              Close;
              Sql.Clear;
              Sql.Add('select max("inv$entrada"."no_entrada") as noentrada');
              sql.Add(' from "inv$entrada"');
              execquery;
              noentra:=fieldbyname('noentrada').AsInteger;
              noentra:=noentra+1;
              no_entrada.Caption:= inttostr(noentra);
              close;
              DataGeneral.IBTransaction1.CommitRetaining;
            end;
        With IBsql do
        begin
          close;
          Sql.Clear;
          Sql.Add('Select "inv$proveedor"."nombre" as proveedor,"inv$proveedor"."telefono" as telefono,');
          Sql.Add('"inv$proveedor"."regimen" as regimen');
          Sql.Add('from "inv$proveedor"' );
          Sql.Add('where "inv$proveedor"."nit_proveedor"=:"nit"');
          ParamByname('nit').AsInt64:=strtoint64(nit_proveedor.Text);
          execquery;
          op:=FieldByname('proveedor').AsString;
          telefono.Caption:=FieldByname('telefono').AsString;
          regimen:=FieldByname('regimen').AsString;
          Close;
            if op='' then begin
            showmessage('No existe el Proveedor');
            entra:=true;
            bitbtn1.Enabled:=true;
            BitBtn1.SetFocus;
            end
             else
             begin
               nombre_p.Text:=op;
             end;
            end;
        end;
end;

procedure TEntrada_Articulo.BitBtn1Click(Sender: TObject);
begin

        proveedor:=tproveedor.Create(self);
        proveedor.opentrada:=true;
        entrada_articulo.Hide;
        Proveedor.nit.Text:=nit_proveedor.Text;
        proveedor.Showmodal;
end;

procedure TEntrada_Articulo.entra_factura;
begin
        With IBdatos do
        begin
          Sql.Clear;
          Sql.Add('Insert Into "inv$datos_factura"' );
          Sql.Add('Values (');
          Sql.Add(':"cod_factura",:"no_factura",:"observacion",:"garantia")');
          ParamByname('cod_factura').AsInteger:=codigo_factura;
          ParamByname('no_factura').AsString:=no_factura.Text;
          ParamByname('observacion').AsString:=descripcion_fact.Text;
          ParamByname('garantia').AsString:=garantia.Text;
          open;
          Close;
        end;
end;

procedure TEntrada_Articulo.limpia_datos;
begin
        no_entrada.Caption:='';
        no_factura.Text:='';
        descripcion_fact.Text:='';
        garantia.Text:='';
        nit_proveedor.Text:='';
        nombre_P.Text:='';
        nit_proveedor.SetFocus;
        ibentrada.Close;
        IBentrada.Open;
        IBDataSet1.Close;
        telefono.Caption:='';
end;

procedure TEntrada_Articulo.no_facturaExit(Sender: TObject);
var     codigo:integer;
begin
         IBentrada.Active:=True;
         With IBdatos do
         begin
           Close;
           Sql.Clear;
           Sql.Add('Select max("inv$datos_factura"."cod_factura") as factura');
           Sql.Add('from "inv$datos_factura"');
           open;
           codigo:=FieldByname('factura').AsInteger;
           codigo_factura:=codigo+1;
           close;
         end;
end;

procedure TEntrada_Articulo.nit_proveedorKeyPress(Sender: TObject;
  var Key: Char);
begin
        dependencia.NumericoSinPunto(self,key);
        if key = #13 then
          no_factura.SetFocus;
end;

procedure TEntrada_Articulo.FormActivate(Sender: TObject);
begin
        bitbtn1.Enabled:=false;
end;

procedure TEntrada_Articulo.no_facturaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if key=#13 then
          descripcion_fact.SetFocus;
end;

procedure TEntrada_Articulo.descripcion_factKeyPress(Sender: TObject;
  var Key: Char);
begin
        if key=#13 then
          garantia.SetFocus;
end;

procedure TEntrada_Articulo.GarantiaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if key=#13  then
          dbgrid1.SetFocus;
end;

procedure TEntrada_Articulo.BACEPTARClick(Sender: TObject);
var     lugar,mensaje:string;
begin
          if nit_proveedor.Text='' then
          begin
             Showmessage('El Campo Nombre Nit No Puede Ser Nulo');
             nit_proveedor.SetFocus;
             end
               else if no_factura.Text = '' then
               begin
                  Showmessage('El Campo No. Factura No Puede Ser Nulo');
                  no_factura.SetFocus;
               end
               else
               begin
               try
                 IBentrada.Insert;
                 actualizar_articulo;
                 datageneral.IBTransaction1.CommitRetaining;
                   if MessageDlg('Desea ver el Reporte de Entrada',mtConfirmation,[mbYes,mbNo],0) = mrYes Then
                     begin
                       reportes:=treportes.Create(self);
                       lugar:=frmain.wpath+'reportes\repentradas.frf';
                       reportes.frDBDataSet1.DataSet:=reportes.entrada;
                       reportes.entrada.ParamByName('entrada').AsInteger:=strtoint(no_entrada.Caption);
                       reportes.entrada.Open;
                       reportes.imprimir_reporte(lugar);
                     end;
                         limpia_datos;
                         no_entrada.Caption:='';
                except
                on E: Exception do
                begin
                  Mensaje:= IBentradacod_articulo.Text;
                  ShowMessage('Eliminie o Modifique El Registro con Codigo: '+ mensaje);
                  DBGrid1.SetFocus
                end
          end;
        end;
end;

procedure TEntrada_Articulo.BcerrarClick(Sender: TObject);
begin

        if ibentradacod_articulo.Text = '' then
        begin
          bcerrar.Enabled:=false;
          dbgrid1.SetFocus;
        end
        else
          ibentrada.Delete;
end;

procedure TEntrada_Articulo.BCANCELARClick(Sender: TObject);
begin
        datageneral.IBTransaction1.RollbackRetaining;
        ibentrada.Close;
        limpia_datos;
        nit_proveedor.SetFocus;
end;

procedure TEntrada_Articulo.actualizar_articulo;
var     codigo_articulo,canarticulo,cantotal,canentrada:integer;
        precio,precio_a,precio_e,precio_te,precio_ta,precio_total: currency;

begin
        with IBdatos do
        begin
          close;
          Sql.Clear;
          Sql.Add('select "inv$entrada"."cod_articulo" as cod ');
          Sql.Add('from "inv$entrada" ');
          Sql.Add('where "inv$entrada"."no_entrada"=:"no_entrada"');
          ParamByname('no_entrada').AsInteger:= strtoint(no_entrada.Caption);
          open;
          while  not IBdatos.Eof do
          begin
            codigo_articulo:=fieldbyname('cod').AsInteger;
            with IBsel do
            begin
              close;
              Sql.Clear;
              Sql.Add('select "inv$articulo"."existencia" as existencia,');
              sql.Add('"inv$articulo"."precio_unitario" as precio_u from "inv$articulo"');
              Sql.Add('where "inv$articulo"."cod_articulo"=:"cod_articulo"');
              parambyname('cod_articulo').AsInteger:=codigo_articulo;
              open;
              canarticulo:=fieldbyname('existencia').AsInteger; // existencia actual del articulo
              precio_a := fieldbyname('precio_u').AsCurrency; // precio del articulo
              close;
            end;
            with IBsel do
            begin
              close;
              Sql.Clear;
              Sql.Add('select "inv$entrada"."cantidad" as cantidad,');
              sql.Add('"inv$entrada"."precio_unidad" as precio');
              sql.Add('from "inv$entrada"');
              Sql.Add('where "inv$entrada"."cod_articulo"=:"cod_articulo"');
              Sql.Add('and "inv$entrada"."no_entrada"=:"entrada"');
              parambyname('cod_articulo').AsInteger:=codigo_articulo;
              parambyname('entrada').AsInteger:=strtoint(no_entrada.Caption);
              open;
              canentrada:=fieldbyname('cantidad').AsInteger; // cantidad de entrada
              precio_e:=fieldbyname('precio').AsCurrency;  // valor unitario de entrada
              close;
            end;
            precio_te := precio_e * canentrada;
            precio_ta := precio_a * canarticulo;
            precio_total:= precio_te + precio_ta;
            cantotal:=canentrada+canarticulo;
            precio:=precio_total/cantotal; // valor promedio del articulo
            with IBsel1 do
            begin
              close;
              Sql.Clear;
              Sql.Add('update "inv$articulo"');
              Sql.Add('set "inv$articulo"."existencia"=:"nueva_can",');
              sql.Add('"inv$articulo"."precio_unitario"=:"unidad"');
              Sql.Add('where "inv$articulo"."cod_articulo"=:"cod_articulo"');
              ParamByName('nueva_can').AsInteger:=cantotal;
              ParamByName('cod_articulo').AsInteger:=codigo_articulo;
              ParamByName('unidad').AsCurrency:=precio;
              open;
              close;
              datageneral.IBTransaction1.CommitRetaining;
              end;
          IBdatos.Next;
          end;
        end;
          IBdatos.Close;
end;

procedure TEntrada_Articulo.act_articulo;
begin

end;

procedure TEntrada_Articulo.BitBtn2Click(Sender: TObject);
begin
        Close;
end;
procedure Tentrada_articulo.cmChildKey(var msg: TWMKEY);
begin
  if msg.CharCode = VK_RETURN then
    if not (Assigned(ActiveControl) and
           ((ActiveControl is TButton) or
            (ActiveControl is TCustomMemo)))
    then begin
      msg.Result := 1;
      keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), 0, 0);
      Keybd_event(VK_TAB, MapVirtualKey(VK_TAB,0), KEYEVENTF_KEYUP, 0);
    end;
end;

procedure TEntrada_Articulo.FormClose(Sender: TObject;
var     Action: TCloseAction);
begin
         limpia_datos;
         datageneral.ibtransaction1.RollbackRetaining;
         FrMain.actualizar;
end;

procedure TEntrada_Articulo.IBentradacantidadValidate(Sender: TField);
begin
        if factura = false then
        begin
          entra_factura;
          factura:=true;
        end;
end;

procedure TEntrada_Articulo.IBentradacod_articuloValidate(Sender: TField);
var     cantidad_ar: integer;
begin
        with ibsel3 do
        Begin
          close;
          Sql.Clear;
          Sql.Add('select "inv$articulo"."nombre" as nombre,');
          sql.Add('"inv$articulo"."existencia" as cantidad from  "inv$articulo"');
          Sql.Add('where "inv$articulo"."cod_articulo"= :"cod_articulo"');
          ParamByName('cod_articulo').AsInteger := StrtoInt(IBentradacod_articulo.Text);
          open;
          cantidad_ar:= FieldByName('cantidad').AsInteger;
          ibentradanombre.Text:=FieldByName('nombre').AsString;
            if ibentradanombre.Text ='' then
            begin
              Showmessage('el Articulo no se Encuentra');
            end
            else

          close;
        end;
        IBentradano_entrada.Text:=no_entrada.Caption;
        IBentradafecha_entrada.Text:=DateToStr(fecha_entrada.DateTime);
        IBentradanit_proveedor.Text:=nit_proveedor.Text;
        IBentradacod_Factura.Text:=IntToStr(codigo_factura);
        ibentradacod_barras.Text:=IntToStr(0);
        IBentradacantidad_articulo.Text:=IntToStr(cantidad_ar);
        bcerrar.Enabled:=true;
end;

procedure TEntrada_Articulo.IBentradaprecio_unitarioValidate(
  Sender: TField);
var     total_articulo,valor,entrada,iva: variant;
begin
        total_articulo:= ibentradaprecio_unitario.Text;
          if regimen = 'C' then
            iva:= total_articulo * 0.16
          else
            iva:= total_articulo * 0.12;
            total_articulo:= total_articulo + iva;
            entrada:= ibentradacantidad.Text;
            valor:= total_articulo/entrada;
            ibentradaprecio_unidad.Text:= valor;
end;

procedure TEntrada_Articulo.IBentradaPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
var     mensaje : string;
begin
        if E.Message <> '' then
        begin
            Mensaje:= IBentradacod_articulo.Text;
            DBGrid1.SetFocus;
            E.Message:='Elimine o Modifique el Codigo:'+ Mensaje;
        end;
end;
end.

