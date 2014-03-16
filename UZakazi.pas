unit UZakazi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, CheckLst, IBSQL, DB, IBCustomDataSet,
  IBStoredProc;

type
  TFZakaz = class(TForm)
    GroupBox1: TGroupBox;
    CBNazDocum: TComboBox;
    GroupBox2: TGroupBox;
    SBSost: TSpeedButton;
    SBCan: TSpeedButton;
    ibs3: TIBSQL;
    SBProsZak: TSpeedButton;
    ibsp1: TIBStoredProc;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EKol: TEdit;
    CLTovar: TListBox;
    Label4: TLabel;
    SBOplat: TSpeedButton;
    procedure SBCanClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SBSostClick(Sender: TObject);
    procedure SBProsZakClick(Sender: TObject);
    procedure CBNazDocumChange(Sender: TObject);
    procedure CLTovarClick(Sender: TObject);
    procedure SBOplatClick(Sender: TObject);
  private
    { Private declarations }
    procedure CBNazDocumZapol;
    procedure CLTovarZapol;
  public
    { Public declarations }
  end;

var
  FZakaz: TFZakaz;

implementation

{$R *.dfm}

uses UGlav, UOtchetO;
var
 MasT : array of array [0..2] of string;
 MasZT : array of array [0..1] of string;
 razmerT, razZT : integer;
 flag : boolean;

procedure TFZakaz.SBCanClick(Sender: TObject);
begin
  FZakaz.Close;
end;

procedure TFZakaz.CBNazDocumZapol;
begin

  if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

  FGLav.ibt.StartTransaction;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select naz_docum from docum');
  ibs3.SQL.Add('order by naz_docum');
  ibs3.ExecQuery;

  CBnazDocum.Items.Clear;

  with ibs3 do
   begin
    while not eof do
     begin
       CBnazDocum.Items.Add(FGlav.DelitP(Fields[0].AsString));
       next;
     end;
   end;

end;

procedure TFZakaz.CLTovarZapol;
var
 i : integer;
begin

   if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

  FGLav.ibt.StartTransaction;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select count(*) from tovar');
  ibs3.SQL.Add('where kol_tovara <> 0');
  ibs3.ExecQuery;

  razmert := ibs3.Fields[0].AsInteger;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select kod_tovara, naz_tovar, kol_tovara from tovar');
  ibs3.SQL.Add('where kol_tovara <> 0');
  ibs3.SQL.Add('order by naz_tovar');
  ibs3.ExecQuery;

  CLTovar.Items.Clear;

  MasT := nil;
  SetLength(MasT, razmerT);
  i := 0;

  with ibs3 do
   begin
    while not eof do
     begin
       MasT[i][0] := FieldByname('kod_tovara').AsString;
       MasT[i][1] := FGlav.DelitP(FieldByName('naz_tovar').AsString);
       MasT[i][2] := FieldByName('kol_tovara').AsString;
       inc(i);
       next;
     end;
   end;

   for i := 0 to razmert - 1 do
    CLTovar.Items.Add(MasT[i][1]);


end;

procedure TFZakaz.FormCreate(Sender: TObject);
begin
  CBNazDocumZapol;
  CLTovarZapol;
  flag := false;
end;

procedure TFZakaz.SBSostClick(Sender: TObject);
var
 i, n : integer;
begin

  if CBNazDocum.Text = '' then
   begin
     application.MessageBox('Выберите название документа!','Ошибка',MB_ICONERROR);
     abort;
   end;

  if EKol.Text = '' then
   begin
     application.MessageBox('Введите количество товара!','Ошибка',MB_ICONERROR);
     abort;
   end;

   if StrToInt(EKol.Text) > StrToInt(MasT[CLTovar.ItemIndex][2]) then
   begin
     application.MessageBox(PChar('Товара всего ' + MasT[CLTovar.ItemIndex][2]),'Предупреждение',MB_ICONWARNING);
     abort;
   end;

  if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

  FGLav.ibt.StartTransaction;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select kod_docum from docum where naz_docum = :naz_d');
  ibs3.ParamByName('naz_d').AsString := CBNazDocum.Text;
  ibs3.ExecQuery;

  n := ibs3.Fields[0].AsInteger;

  if n = 0 then
   begin
     application.MessageBox('Такого документа в базе нет!','Ошибка',MB_ICONERROR);
     abort;
   end;


         try
           if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

           FGLav.ibt.StartTransaction;

           for i := 0 to StrToInt(EKol.Text) - 1 do
            begin
             ibsp1.ParamByName('kod_t').AsInteger := StrToInt(MasT[CLTovar.ItemIndex][0]);
             ibsp1.ExecProc;
            end;

           ibs3.Close;
           ibs3.SQL.Clear;
           ibs3.SQL.Add('insert into zakaz (kod_zakaz, kod_docum, kod_tovara, oplata, kol_tov)');
           ibs3.SQL.Add('values (0, :kod_d, :kod_t, 0, :kol_t)');
           ibs3.ParamByName('kod_d').AsInteger := n;
           ibs3.ParamByName('kod_t').AsInteger := StrToInt(MasT[CLTovar.ItemIndex][0]);
           ibs3.ParamByName('kol_t').AsInteger := StrToInt(EKol.Text);
           ibs3.ExecQuery;

           FGlav.ibt.Commit;

           CLTovarZapol;
           
        except
           FGlav.ibt.Rollback;
           raise;
        end;

     EKol.Text := '';   

   FGlav.LBTovar.Items.Clear;
   FGlav.LBVid.ItemIndex := 0;

end;

procedure TFZakaz.SBProsZakClick(Sender: TObject);
var
 n,i : integer;
begin
  if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

  FGLav.ibt.StartTransaction;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select kod_docum from docum where naz_docum = :naz_d');
  ibs3.ParamByName('naz_d').AsString := CBNazDocum.Text;
  ibs3.ExecQuery;

  n := ibs3.Fields[0].AsInteger;

  if n = 0 then
   begin
     application.MessageBox('Такого документа в базе нет!','Ошибка',MB_ICONERROR);
     abort;
   end;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select count(*) from zakaz where kod_docum = :kod_d');
  ibs3.ParamByName('kod_d').AsInteger := n;
  ibs3.ExecQuery;

  razZT := ibs3.Fields[0].AsInteger;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select T.naz_tovar, Z.kol_tov from tovar T, zakaz Z ');
  ibs3.SQL.Add('where (T.kod_tovara = Z.kod_tovara) and (Z.kod_docum = :kod_d)');
  ibs3.SQL.Add('order by naz_tovar');
  ibs3.ParamByName('kod_d').AsInteger := n;
  ibs3.ExecQuery;

  MasZT := nil;
  SetLength(MasZT, razzt);
  i := 0;

  CLTovar.Items.Clear;

  with ibs3 do
   begin
    while not eof do
     begin
       MasZT[i][0] := FGlav.DelitP(FieldByName('naz_tovar').AsString);
       MasZT[i][1] := FieldByName('kol_tov').AsString;
       inc(i);
       next;
     end;
   end;

  for i := 0 to razzt - 1 do
   cltovar.Items.Add(MasZT[i][0]);

  flag := true; 

end;

procedure TFZakaz.CBNazDocumChange(Sender: TObject);
var
 n : integer;
begin
  CLTovarZapol;

  EKol.Text := '';

  if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

  FGLav.ibt.StartTransaction;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select kod_docum from docum where naz_docum = :naz_d');
  ibs3.ParamByName('naz_d').AsString := CBNazDocum.Text;
  ibs3.ExecQuery;

  n := ibs3.Fields[0].AsInteger;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select naz_tipdocum from tipdocum where kod_tipdocum = :kod_t');
  ibs3.ParamByName('kod_t').AsInteger := n;
  ibs3.ExecQuery;

  Label2.Caption := ibs3.Fields[0].AsString;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select count(*) from zakaz where (kod_docum = :kod_d) and (oplata = 1)');
  ibs3.ParamByName('kod_d').AsInteger := n;
  ibs3.ExecQuery;

  n := ibs3.Fields[0].AsInteger;

  if n = 0 then Label4.Caption := 'Не оплачено'
  else Label4.Caption := 'Оплачено';

  flag := false;

end;

procedure TFZakaz.CLTovarClick(Sender: TObject);
begin
  if flag then
   begin
     EKol.Text := MasZT[ClTovar.ItemIndex][1];
   end;
end;

procedure TFZakaz.SBOplatClick(Sender: TObject);
var
 n, razm, i : integer;
 Mas : array of array [0..1] of string;
 summa : double;
begin

  if CBNazDocum.Text = '' then
   begin
     application.MessageBox('Выберите документ!','Ошибка',MB_ICONERROR);
     abort;
   end;

  try
  if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

  FGLav.ibt.StartTransaction;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select kod_docum from docum where naz_docum = :naz_d');
  ibs3.ParamByName('naz_d').AsString := CBNazDocum.Text;
  ibs3.ExecQuery;

  n := ibs3.Fields[0].AsInteger;

  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('update zakaz set oplata = 1 where kod_docum = :kod_d');
  ibs3.ParamByName('kod_d').AsInteger := n;
  ibs3.ExecQuery;



  ibs3.Close;
  ibs3.SQL.Clear;
  ibs3.SQL.Add('select count(*) from zakaz where kod_docum = :id_z');
  ibs3.ParamByName('id_z').AsInteger := n;
  ibs3.ExecQuery;

   razm := ibs3.Fields[0].AsInteger;

   if razm = 0 then
    begin
      application.MessageBox('Данная заявка не содержит товара!','Предупреждение',MB_ICONWARNING);
      abort;
    end;

   ibs3.Close;
   ibs3.SQL.Clear;
   ibs3.SQL.Add('select Z.*, T.* from zakaz Z, tovar T');
   ibs3.SQL.Add('where (Z.kod_tovara = T.kod_tovara) and (Z.kod_docum = :id_z)');
   ibs3.ParamByName('id_z').AsInteger := n;
   ibs3.ExecQuery;

   Mas := nil;
   SetLength(Mas, razm);
   i := 0;

   with ibs3 do
    begin
     while not eof do
      begin
        Mas[i][0] := FieldByname('kol_tov').AsString;
        Mas[i][1] := FieldByname('cena_tovara').AsString;
        inc(i);
        next;
      end;
    end;

   summa := 0;

   for i := 0 to razm - 1 do
     summa := summa + StrToFloat(Mas[i][0])*StrToFloat(Mas[i][1]);

   Form1.QRLabel8.Caption := FloatToStr(summa);

   Form1.ibq.Close;
   Form1.ibq.SQL.Clear;
   Form1.ibq.SQL.Add('select T.naz_tovar, V.naz_vidtovar, T.kol_tovara, T.cena_tovara, Z.kol_tov');
   Form1.ibq.SQL.Add('from tovar T, vidtovara V, zakaz Z');
   Form1.ibq.SQL.Add('where (T.kod_vidtovar = V.kod_vidtovar) and (Z.kod_tovara = T.kod_tovara) and (Z.kod_docum = :kod_d)');
   Form1.ibq.ParamByName('kod_d').AsInteger := n;
   Form1.ibq.Open;


   Form1.QRLabel2.Caption := CBNazDocum.Text;



   Form1.QuickRep1.Preview;

   Label4.Caption := 'Оплачено';

   FGlav.ibt.Commit;

  except
    FGlav.ibt.Rollback;
    raise;
  end;

end;

end.
