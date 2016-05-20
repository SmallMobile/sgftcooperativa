unit UnitActivoreal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,ExtCtrls, Grids, DBGrids, Buttons, DB, IBCustomDataSet
  ,ImgList,  ToolWin, IBDatabase, Menus, Mask, JvEdit, JvTypedEdit;

type
  Tfrmactivoreal = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    fecha_compra: TDateTimePicker;
    No_factura: TEdit;
    descripcion: TMemo;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    vida: TEdit;
    GroupBox3: TGroupBox;
    dbcomponente: TDBGrid;
    GroupBox4: TGroupBox;
    dbpoliza: TDBGrid;
    Label7: TLabel;
    clase: TComboBox;
    Label6: TLabel;
    Label9: TLabel;
    garantia: TMemo;
    GroupBox6: TGroupBox;
    aceptar: TBitBtn;
    cancelar: TSpeedButton;
    salir: TSpeedButton;
    menucomp: TPopupMenu;
    eliminarcomp: TMenuItem;
    ImageList1: TImageList;
    menupol: TPopupMenu;
    EliminarPoliza: TMenuItem;
    placa: TMaskEdit;
    valor: TJvCurrencyEdit;
    procedure SpeedButton3Click(Sender: TObject);
    procedure placaKeyPress(Sender: TObject; var Key: Char);
    procedure No_facturaKeyPress(Sender: TObject; var Key: Char);
    procedure fecha_compraKeyPress(Sender: TObject; var Key: Char);
    procedure claseKeyPress(Sender: TObject; var Key: Char);
    procedure descripcionKeyPress(Sender: TObject; var Key: Char);
    procedure garantiaKeyPress(Sender: TObject; var Key: Char);
    procedure valorKeyPress(Sender: TObject; var Key: Char);
    procedure vidaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure salirClick(Sender: TObject);
    procedure cancelarClick(Sender: TObject);
    procedure placaExit(Sender: TObject);
    procedure claseExit(Sender: TObject);
    procedure dbpolizaEnter(Sender: TObject);
    procedure entradaClick(Sender: TObject);
    procedure aceptarClick(Sender: TObject);
    procedure No_facturaExit(Sender: TObject);
    procedure vidaExit(Sender: TObject);
    procedure eliminarcompClick(Sender: TObject);
    procedure EliminarPolizaClick(Sender: TObject);
    procedure descripcionExit(Sender: TObject);
    procedure garantiaExit(Sender: TObject);
  private
  cod_clase:Integer;
  nodeplaca: string;
  valor_activo: Currency;
    { Private declarations }
  public
  codigo_activo,cod_poliza: Integer;
  valor_real: Variant;
  Control_dato: Boolean;
  esactivo: Boolean;
  control_actualiza :Smallint;
  control_placa: Smallint;
  published

    procedure limpiar;
    procedure cmChildKey(var msg: TWMKEY); message CM_CHILDKEY;
    procedure entra_datos;
    procedure valida;
    procedure boorrar;
    procedure NumericoSinPunto(Sender: TObject; var Key: Char);
    procedure actualizar_activo;

    { Public declarations }
  end;

var
  frmactivoreal: Tfrmactivoreal;

implementation
uses unitdatamodulo,unitgeneral,unitglobal, Unitentrega, UnitTraslado;


{$R *.dfm}

procedure Tfrmactivoreal.SpeedButton3Click(Sender: TObject);
begin
        with DataGeneral.IBsql do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select count(*) as contador from "act$activo"');
          ExecQuery;
          placa.Text := FieldByName('contador').AsString;
          Close;
        end;
end;

procedure Tfrmactivoreal.placaKeyPress(Sender: TObject; var Key: Char);
begin
        ValidaPlaca(Self,Key);
        if Key = #13 then
          No_factura.SetFocus;
end;

procedure Tfrmactivoreal.No_facturaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          fecha_compra.SetFocus;
end;

procedure Tfrmactivoreal.fecha_compraKeyPress(Sender: TObject;
  var Key: Char);
begin
        if (Key = #13) then
        begin
          if clase.Visible = True then
             clase.SetFocus
          else
             descripcion.SetFocus;
        end;
end;

procedure Tfrmactivoreal.claseKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          descripcion.SetFocus;
end;

procedure Tfrmactivoreal.descripcionKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = #13 then
          garantia.SetFocus;
end;

procedure Tfrmactivoreal.garantiaKeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
          valor.SetFocus;
end;

procedure Tfrmactivoreal.valorKeyPress(Sender: TObject; var Key: Char);
begin
        Numerico(Self,Key);
        if (Key = #13) then
        begin
          if vida.Visible = True then
             vida.SetFocus
          else
             dbcomponente.SetFocus;
        end;
end;

procedure Tfrmactivoreal.vidaKeyPress(Sender: TObject; var Key: Char);
begin
        numericosinpunto(Self,Key);
        if Key = #13 then
        begin
          dbcomponente.SetFocus;
        end;
end;

procedure Tfrmactivoreal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        if control_actualiza <> 1 then
        begin
        if (placa.Text <> '') and (clase.Text <> '') then
        begin
          if MessageDlg('Desea Guardar los Cambios',mtinformation,[mbYes,mbNo],0) = mrYes Then
          begin
            frmgeneral.poliza.Close;
            frmgeneral.componente.Close
          end
          else
          begin
            limpiar;
            frmgeneral.poliza.Close;
            frmgeneral.componente.Close
          end;
        end;
       end;
end;

procedure Tfrmactivoreal.FormCreate(Sender: TObject);
begin

        fecha_compra.DateTime := Date;
        Fecha_compra.MaxDate := StrToDate(FormatDateTime('yyyy/mm/dd',Date));
        frmgeneral.poliza.Active := True;
        frmgeneral.componente.Active := True;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$clase_activo"."descripcion" from "act$clase_activo"');
          SQL.Add('where "act$clase_activo"."cod_clase" <> :"cod_clase"');
          ParamByName('cod_clase').AsInteger:=1;
          Open;
        while not DataGeneral.IBsel.Eof do
        begin
          clase.Items.Add(FieldByName('descripcion').AsString);
          DataGeneral.IBsel.Next;
        end;
          Close;
        end;
end;

procedure Tfrmactivoreal.salirClick(Sender: TObject);
begin
        limpiar;
        Close;
end;

procedure Tfrmactivoreal.limpiar;
begin
        placa.Text := '';
        No_factura.Text := '';
        clase.ItemIndex := -1;
        descripcion.Text := '';
        garantia.Text := '';
        valor.Value := 0;
        vida.Text := '';
        frmgeneral.poliza.Transaction.RollbackRetaining;
        frmgeneral.componente.Transaction.RollbackRetaining;
        frmgeneral.poliza.Close;
        frmgeneral.poliza.Open;
        frmgeneral.componente.Close;
        frmgeneral.hitorial_polizas.Close;
        frmgeneral.componente.Open;
        placa.SetFocus;
        Label6.Visible := True;
        Label5.Visible := True;
        vida.Visible := True;
        Label7.Visible := True;
        clase.Visible := True;
        valor.Value := 0;
        frmgeneral.componente.Close;
end;

procedure Tfrmactivoreal.cancelarClick(Sender: TObject);
begin
        limpiar;
        if control_actualiza <> 1 then
        boorrar;
end;

procedure tfrmactivoreal.NumericoSinPunto(Sender: TObject; var Key: Char);
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

procedure Tfrmactivoreal.cmChildKey(var msg: TWMKEY);
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

procedure Tfrmactivoreal.placaExit(Sender: TObject);
var     contador:Integer;
        a:string;
begin
      control_placa := 0;
      Label5.Visible := True;
      Label6.Visible := true;
      vida.Visible := true;
      Label7.Visible := true;
      clase.Visible := True;
      nodeplaca := placa.Text;
      if control_actualiza = 1 then
      begin
        if validaactivo(placa.Text) <> 0 then
        begin
          MessageDlg('El Activo Fue Dado de Baja',mtInformation,[mbOK],0);
          placa.SetFocus;
          limpiar;
          Exit;
        end;
        Control_dato := True;
        with DataGeneral.IBdatos do
        begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT');
          SQL.Add('"act$activo"."cod_activo",');
          SQL.Add('"act$activo"."fechacompra",');
          SQL.Add('"act$activo"."preciocompra",');
          SQL.Add('"act$activo"."descripcion",');
          SQL.Add('"act$activo"."vidadepreciable",');
          SQL.Add('"act$activo"."no_factura",');
          SQL.Add('"act$activo"."garantia",');
          SQL.Add('"act$activo"."clase_activo",');
          SQL.Add('"act$activo"."esactivo"');
          SQL.Add('FROM');
          SQL.Add('"act$activo"');
          SQL.Add('WHERE "act$activo"."placa" = :"placa"');
          ParamByName('placa').AsString := placa.Text;
          Open;
          if FieldByName('esactivo').AsInteger = 0 then
          begin
            clase.Visible := False;
            Label5.Visible := False;
            Label6.Visible := False;
            vida.Visible := False;
            Label7.Visible := False;
          end;
          No_factura.Text:= FieldByName('no_factura').AsString;
          fecha_compra.DateTime := FieldByName('fechacompra').AsDateTime;
          vida.Text := FieldByName('vidadepreciable').AsString;
          descripcion.Text := FieldByName('descripcion').AsString;
          garantia.Text := FieldByName('garantia').AsString;
          valor_activo := FieldByName('preciocompra').AsCurrency;
          valor.Value :=  valor_activo;
          codigo_activo := FieldByName('cod_activo').AsInteger;
          cod_clase := FieldByName('clase_activo').AsInteger;
          Close;
          with frmgeneral.componente do
          begin
            Close;
            ParamByName('cod_activo').AsInteger := codigo_activo;
            Open;
          end;
        end;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$clase_activo"."descripcion"');
          SQL.Add('from "act$clase_activo"');
          SQL.Add('where "act$clase_activo"."cod_clase" = :"cod_clase"');
          ParamByName('cod_clase').AsInteger := cod_clase;
          Open;
          clase.Text := FieldByName('descripcion').AsString;
          Close;
        end;
        if codigo_activo = 0 then
        begin
        fecha_compra.DateTime := Date;
        placa.SetFocus;
        Exit;
        end;
      end
      else
      begin
      cod_clase := 0;
      a := devuelve(placa.Text);
          with DataGeneral.IBsel do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select count(*) as contador');
            SQL.Add('from "act$activo"');
            SQL.Add('where "act$activo"."placa" = :"placa"');
            ParamByName('placa').AsString:=placa.Text;
            Open;
            contador:=FieldByName('contador').AsInteger;
            Close;
          end;
          if contador = 1 then
          begin
            MessageDlg('El No de Placa Ya Existe',mtInformation,[mbOK],0);
            placa.SetFocus;
            Exit;
          end;
      if (a <> '05-') and (a <> '01-') and (a <> '02-') and (a <> '03-') and (a <> 'NA-') and (a <> '04-'){ and (a <> '02-') and (a <> '03-') }then // validar entrada de codigos de placas
      begin
        MessageDlg('Verifique el Codigo, No es Correcto',mtInformation,[mbOK],0);
        placa.SetFocus;
        Exit;
      end;
      if StrPos(PChar('NA-'),PChar(devuelve(placa.Text))) <> nil then
      begin
        MessageDlg('El Elemento No es Un Activo',mtInformation,[mbOK],0);
        Label5.Visible := False;
        Label6.Visible := False;
        vida.Visible := False;
        Label7.Visible := False;
        clase.Visible := False;
        if StrLen(PChar(placa.Text)) <> 10 then
        begin
          MessageDlg('Verifique El Codigo no tiene El No. de Caracteres Especificado',mtInformation,[mbOK],0);
          placa.SetFocus;
          Exit;
        end;
      end
      else
      begin
        if StrLen(PChar(placa.Text)) <> 8 then
        begin
          MessageDlg('Verifique El Codigo no tiene El No. de Caracteres Especificado',mtInformation,[mbOK],0);
          placa.SetFocus;
          Exit;
        end;
        end;

      if placa.Text <> '' then
      begin
           Control_dato := False;
          with DataGeneral.IBsel do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select count(*) as contador');
            SQL.Add('from "act$activo"');
            SQL.Add('where "act$activo"."placa" = :"placa"');
            ParamByName('placa').AsString:=placa.Text;
            Open;
            contador := FieldByName('contador').AsInteger;
            Close;
          end;
          if contador = 0 then // if busca placa
          begin

          with DataGeneral.IBsel do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select max("act$activo"."cod_activo") as codigo from "act$activo"');
            Open;
            codigo_activo := (FieldByName('codigo').AsInteger)+1;
            Close;
          end;
            with frmgeneral.ibcod_poliza do
          begin
            Close;
            Open;
            cod_poliza := (FieldByName('codigo').AsInteger);
            Close;
          end;
          end
         else // compara placa
         begin
          MessageDlg('El No de Placa Ya Existe',mtInformation,[mbOK],0);
          placa.SetFocus;
          control_placa := 1;
         end; // fin busca placa
      end // fin del primer if
      else
      begin
        MessageDlg('Debe contener un Valor',mtInformation,[mbOK],0);
        placa.SetFocus;
      end;
      if Label5.Visible = True then
        esactivo := True
      else
        esactivo := false
      end;
end;

procedure Tfrmactivoreal.entra_datos;
begin
        valida;
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('insert into "act$activo"');
          SQL.Add('values (');
          SQL.Add(':"cod_activo",:"descripcion",:"placa",');
          SQL.Add(':"fechacompra",:"preciocompra",:"vidadepreciable",');
          SQL.Add(':"cod_barras",:"no_factura",:"garantia",:"clase_activo",:"estado",:"esactivo")');
          ParamByName('cod_activo').AsInteger:=codigo_activo;
          ParamByName('descripcion').AsString:=descripcion.Text;
          ParamByName('placa').AsString:=placa.Text;
          ParamByName('fechacompra').AsDate:=fecha_compra.DateTime;
          ParamByName('preciocompra').AsCurrency:=valor.Value;
          ParamByName('vidadEpreciable').AsInteger:=StrToInt(vida.Text);
          ParamByName('cod_barras').AsString:='0';
          ParamByName('no_factura').AsString:=No_factura.Text;
          ParamByName('clase_activo').AsInteger:=cod_clase;
          ParamByName('garantia').AsString:=garantia.Text;
          ParamByName('estado').AsString:='A';
          ParamByName('esactivo').AsInteger:=Ord(esactivo);
          Open;
          Close;
          DataGeneral.IBTransaction1.CommitRetaining;
        end
end;

procedure Tfrmactivoreal.claseExit(Sender: TObject);
begin
        with DataGeneral.IBsql do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select "act$clase_activo"."cod_clase","act$clase_activo"."vidautil" from "act$clase_activo"');
          SQL.Add('where "act$clase_activo"."descripcion" like :"descripcion"');
          ParamByName('descripcion').AsTrimString:=clase.Text;
          ExecQuery;
          cod_clase := FieldByName('cod_clase').AsInteger;
          vida.Text := FieldByName('vidautil').AsString;
          Close;
        end;
        if cod_clase = 0 then
        begin
          MessageDlg('Debe contener un Valor',mtInformation,[mbOK],0);
          clase.SetFocus;
        end;
end;

procedure Tfrmactivoreal.dbpolizaEnter(Sender: TObject);
begin
        frmgeneral.poliza.Open;
        frmgeneral.codigo_poliza:=cod_poliza+1;
        if Control_dato = False then
        begin
          Control_dato := True;
          entra_datos;
        end;
end;
procedure Tfrmactivoreal.entradaClick(Sender: TObject);
begin
        FrmEntrega := TFrmEntrega.Create(self);
        FrmEntrega.ShowModal;
end;

procedure Tfrmactivoreal.aceptarClick(Sender: TObject);
begin
        if control_actualiza = 1 then
           actualizar_activo
        else
        begin
        if Control_dato = False then
        begin
          Control_dato := True;
          entra_datos;
        end;
        end;
          try
            frmgeneral.poliza.Insert;
            frmgeneral.poliza.Transaction.CommitRetaining;
            frmgeneral.componente.Insert;
            frmgeneral.componente.Transaction.CommitRetaining;
            DataGeneral.IBTransaction1.CommitRetaining;
          except
          end;
          limpiar;
end;

procedure Tfrmactivoreal.No_facturaExit(Sender: TObject);
var contador:Integer;
begin
        if No_factura.Text <> '' then
        begin
          with DataGeneral.IBsel do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select count(*) as contador');
            SQL.Add('from "act$factura"');
            SQL.Add('where "act$factura"."no_factura" = :"factura"');
            ParamByName('factura').AsString:=No_factura.Text;
            Open;
            contador := FieldByName('contador').AsInteger;
            Close;
          end;
        if contador = 0 then
          begin
          if MessageDlg('Desea Registrar la Factura',mtCustom,[mbYes,mbNo],0) = mrYes Then
          begin
            frmfact := Tfrmfact.Create(self);
            frmfact.no_factura.Text:=No_factura.Text;
            frmfact.no_factura.ReadOnly:=True;
            frmfact.ShowModal;
            No_factura.SetFocus;
          end
          else
            No_factura.SetFocus;
          end;
        end;
end;

procedure Tfrmactivoreal.vidaExit(Sender: TObject);
begin
        if vida.Text = '' then
          vida.Text := '0';
end;

procedure Tfrmactivoreal.valida;
begin
        if valor.Text = '' then
           valor.Text := '0';
        if vida.Text = '' then
           vida.Text := '0';
        if cod_clase = 0 then
           cod_clase := 1
end;

procedure Tfrmactivoreal.eliminarcompClick(Sender: TObject);
begin
        if frmgeneral.componentedescripcion.Text = '' then
        begin
          eliminarcomp.Enabled:=False;
        end
        else
          frmgeneral.componente.Delete;

end;

procedure Tfrmactivoreal.EliminarPolizaClick(Sender: TObject);
begin
        if frmgeneral.polizatipo_poliza.Text = '' then
        begin
          EliminarPoliza.Enabled := False;
        end
        else
          frmgeneral.poliza.Delete;
end;

procedure Tfrmactivoreal.boorrar;
begin
       if control_placa = 0 then
       begin
        with DataGeneral.IBsel do
        begin
          Close;
          SQL.Clear;
          SQL.Add('delete from "act$activo"');
          SQL.Add('where "act$activo"."placa" = :"placa"');
          ParamByName('placa').AsString:=nodeplaca;
          Open;
          Close;
        end;
          DataGeneral.IBTransaction1.CommitRetaining;
        end;
end;

procedure Tfrmactivoreal.descripcionExit(Sender: TObject);
begin
        descripcion.Text := UpperCase(descripcion.Text);
end;

procedure Tfrmactivoreal.garantiaExit(Sender: TObject);
begin
        garantia.Text := UpperCase(garantia.Text);
end;
procedure Tfrmactivoreal.actualizar_activo;
begin
        with DataGeneral.IBsel1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update "act$activo" set');
          SQL.Add('"act$activo"."no_factura" = :"no_factura",');
          SQL.Add('"act$activo"."fechacompra" = :"fecha_compra",');
          SQL.Add('"act$activo"."clase_activo" = :"clase",');
          SQL.Add('"act$activo"."descripcion" = :"descripcion",');
          SQL.Add('"act$activo"."vidadepreciable" = :"vida",');
          SQL.Add('"act$activo"."garantia" = :"garantia",');
          SQL.Add('"act$activo"."preciocompra" = :"precio"');
          SQL.Add('where');
          SQL.Add('"act$activo"."cod_activo" = :"codigo"');
          ParamByName('no_factura').AsString := No_factura.Text;
          ParamByName('fecha_compra').AsDate := fecha_compra.DateTime;
          ParamByName('clase').AsInteger := cod_clase;
          ParamByName('descripcion').AsString := descripcion.Text;
          ParamByName('vida').AsInteger := StrToInt(vida.Text);
          ParamByName('garantia').AsString := garantia.Text;
          ParamByName('precio').AsCurrency := valor.Value;
          ParamByName('codigo').AsInteger := codigo_activo;
          Open;
          Close;
          DataGeneral.IBTransaction1.CommitRetaining;
          end;
end;

end.


