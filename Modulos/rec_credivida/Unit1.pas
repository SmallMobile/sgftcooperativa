unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBQuery, IBDatabase, StdCtrls, Buttons,
  ExtCtrls, FR_Class, IBSQL, DBClient;

type
  TForm1 = class(TForm)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    frReport1: TfrReport;
    IBSQL1: TIBSQL;
    Panel3: TPanel;
    BitBtn2: TBitBtn;
    Edit5: TEdit;
    Label5: TLabel;
    CDbeneficiarios: TClientDataSet;
    CDbeneficiariosnombre: TStringField;
    CDbeneficiariosporciento: TCurrencyField;
    CDbeneficiariosparentesco: TIntegerField;
    BitBtn3: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
        try
          IBDatabase1.DatabaseName := Edit1.Text;
          IBDatabase1.Connected := True;
          MessageDlg('Base de Datos Conectada',mtInformation,[mbok],0);
          BitBtn2.Enabled := True;
        except
        on e: Exception do
        begin
          MessageDlg('Base de Datos no Conectada, con Error' + e.Message,mtError,[mbok],0);
          BitBtn2.Enabled := False;
        end;
        end;
        Edit2.SetFocus;
end;

procedure TForm1.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
        if IBDatabase1.Connected then
        begin
          with IBQuery1 do
          begin
            Close;
            ParamByName('ID_PERSONA').AsString := Edit3.Text;
            ParamByName('ID_IDENTIFICACION').AsInteger := StrToInt(Edit2.Text);
            Open;
          if ParName = 'nombre' then
             ParValue := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
          if ParName = 'certificado' then
             ParValue := Edit4.Text;
          if ParName = 'documento' then
             ParValue := Edit3.Text;
          if ParName = 'lugar_exp' then
             ParValue := FieldByName('LUGAR_EXPEDICION').AsString;
          if ParName = 'nacimiento' then
             ParValue := FieldByName('LUGAR_NACIMIENTO').AsString;
          if ParName = 'fecha_nacimiento' then
             ParValue := FieldByName('FECHA_NACIMIENTO').AsDateTime;
          if ParName = 'empresa' then
             ParValue := FieldByName('EMPRESA_LABORA').AsString;
          if ParName = 'cargo' then
             ParValue := FieldByName('CARGO_ACTUAL').AsString;
          if ParName = 'direccion' then
             ParValue := FieldByName('DIRECCION').AsString;
          if ParName = 'ciudad' then
             ParValue := FieldByName('MUNICIPIO').AsString;
          if ParName = 'telefono' then
             ParValue := FieldByName('TELEFONO1').AsString;
          end;
        with IBSQL1 do
        begin
          Close;
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('select VALOR_MINIMO from "gen$minimos"');
          SQL.Add('where ID_MINIMO = 9');
          ExecQuery;
          if ParName = 'valor_poliza' then
             ParValue := FieldByName('VALOR_MINIMO').AsCurrency;
          if ParName = 'poliza_total' then
             ParValue := FieldByName('VALOR_MINIMO').AsCurrency * 12;
          Close;
          SQL.Clear;
          SQL.Add('select * from "gen$agencia"');
          SQL.Add('where ID_AGENCIA = :ID_AGENCIA');
          ParamByName('ID_AGENCIA').AsInteger := 1;
          ExecQuery;
          if ParName = 'ciudad_exp' then
             ParValue := FieldByName('DESCRIPCION_AGENCIA').AsString;
          Close;
          if ParName = 'mes' then
             ParValue := UpperCase(FormatDateTime('mmmm',Date));
        end;
        end;
         with CDbeneficiarios do
          begin
            First;
            if RecordCount = 0 then
            begin
               if ParName = 'nom1' then
               ParValue := 'LOS DE LEY';
               if ParName = 'por1' then
                 ParValue := 100;
            end;
           while not Eof do
           begin
            //primero
            if RecNo = 1 then
            begin
               if ParName = 'nom1' then
               ParValue := FieldByName('nombre').AsString;
               if ParName = 'por1' then
                 ParValue := FieldByName('porciento').AsInteger;
            end;
            //segundo
            if RecNo = 2 then
            begin
               if ParName = 'nom2' then
               ParValue := FieldByName('nombre').AsString;
               if ParName = 'por2' then
                 ParValue := FieldByName('porciento').AsInteger;
            end;
            //tercero
            if RecNo = 3 then
            begin
               if ParName = 'nom3' then
               ParValue := FieldByName('nombre').AsString;
               if ParName = 'por3' then
                 ParValue := FieldByName('porciento').AsInteger;
            end;
            //cuarto
            if RecNo = 4 then
            begin
               if ParName = 'nom4' then
               ParValue := FieldByName('nombre').AsString;
               if ParName = 'por4' then
                 ParValue := FieldByName('porciento').AsInteger;
            end;
            Next;
            end;
          end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
        with IBSQL1 do
        begin
          if Transaction.InTransaction then
             Transaction.Commit;
          Transaction.StartTransaction;
          SQL.Clear;
          SQL.Add('SELECT *');
          SQL.Add('FROM');
          SQL.Add(' "gen$beneficiario"');
          SQL.Add('WHERE');
          SQL.Add('("gen$beneficiario".ID_PERSONA = :ID_PERSONA) AND ');
          SQL.Add('("gen$beneficiario".ID_IDENTIFICACION = :ID_IDENTIFICACION) AND ');
          SQL.Add('("gen$beneficiario".AUXILIO = 0)');
          ParamByName('ID_PERSONA').AsString := Edit3.Text;
          ParamByName('ID_IDENTIFICACION').AsInteger := StrToInt(Edit2.Text);
          ExecQuery;
          while not Eof do
          begin
            CDbeneficiarios.Append;
            CDbeneficiarios.FieldValues['nombre'] := FieldByName('NOMBRE').AsString + ' ' + FieldByName('PRIMER_APELLIDO').AsString + ' ' + FieldByName('SEGUNDO_APELLIDO').AsString;
            CDbeneficiarios.FieldValues['porciento'] := FieldByName('PORCENTAJE').AsCurrency;
            CDbeneficiarios.FieldValues['parentesco'] := FieldByName('ID_PARENTESCO').AsString;
            CDbeneficiarios.Post;
            Next;
          end;

        end;
        frReport1.ShowReport
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
        if InputBox('clave de ingreso','digite','') <> 'wer' then
           Application.Terminate
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           BitBtn1.SetFocus
end;

procedure TForm1.BitBtn1KeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           Edit2.SetFocus
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           Edit3.SetFocus

end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           BitBtn2.SetFocus

end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
        if Key = #13 then
           Edit4.SetFocus

end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
        Close;
end;

end.
