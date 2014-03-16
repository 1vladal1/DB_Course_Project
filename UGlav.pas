unit UGlav;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IBSQL, IBDatabase, DB, Buttons, ComCtrls, Menus;

type
  TFGlav = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    LBVid: TListBox;
    LBTovar: TListBox;
    GroupBox3: TGroupBox;
    BBSotrud: TBitBtn;
    BBNaryad: TBitBtn;
    BBZakaz: TBitBtn;
    BBVihod: TBitBtn;
    ibd: TIBDatabase;
    ibt: TIBTransaction;
    ibs: TIBSQL;
    StatusBar1: TStatusBar;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    BBZakazchik: TBitBtn;
    BBDocum: TBitBtn;
    MainMenu1: TMainMenu;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    procedure BBVihodClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LBVidClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure LBTovarClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure LBTovarDblClick(Sender: TObject);
    procedure BBSotrudClick(Sender: TObject);
    procedure BBNaryadClick(Sender: TObject);
    procedure BBZakazchikClick(Sender: TObject);
    procedure BBZakazClick(Sender: TObject);
    procedure BBDocumClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

  public
    { Public declarations }
     procedure LBVidFull;
     procedure LBTovarFull(kod: integer);
     function DelitP(stroka: string):string;

  end;

var
  FGlav: TFGlav;
  vidtovar, kodtovara : integer;

implementation

{$R *.dfm}

uses UVhod, UAddTV, USot, UNaryad, Uzakazchik, Uzakazi, UDocum;

var
 MasT : array of array [0..5] of string;
 MasV : array of array [0..1] of string;
 razmerT, razmerV : integer;

procedure TFGlav.BBVihodClick(Sender: TObject);
begin
if application.MessageBox('Действительно хотите завершить работу?','Подтвердите завершение',MB_ICONQUESTION + MB_YESNO)=idYes
  then
   application.Terminate;
end;

procedure TFGlav.LBVidFull;
var
 i : integer;
begin

  if ibt.InTransaction then ibt.Commit;

  ibt.StartTransaction;

  ibs.Close;
  ibs.SQL.Clear;
  ibs.SQL.Add('select count(*) from vidtovara');
  ibs.ExecQuery;

  razmerV := ibs.Fields[0].AsInteger;

  ibs.Close;
  ibs.SQL.Clear;
  ibs.SQL.Add('select * from vidtovara');
  ibs.SQL.Add('order by naz_vidtovar');
  ibs.ExecQuery;


  LBVid.Items.Clear;

  MasV := nil;
  SetLength(MasV,razmerV);
  i := 0;

  with ibs do
   begin
    while not eof do
     begin
       MasV[i][0] := FieldByName('kod_vidtovar').AsString;
       MasV[i][1] := DelitP(FieldByName('naz_vidtovar').AsString);
       inc(i);
       next;
     end;
   end;

  for i := 0 to razmerV - 1 do
   LBVid.Items.Add(MasV[i][1]);


end;

procedure TFGlav.LBTovarFull(kod: integer);
var
 i : integer;
begin

  if ibt.InTransaction then ibt.Commit;

  ibt.StartTransaction;

  ibs.Close;
  ibs.SQL.Clear;
  ibs.SQL.Add('select count(*) from tovar where (kod_vidtovar = :kod_v1)');
  ibs.SQL.Add('and (kol_tovara <> 0)');
  ibs.ParamByName('kod_v1').AsInteger := kod;
  ibs.ExecQuery;

  razmerT := ibs.Fields[0].AsInteger;

  ibs.Close;
  ibs.SQL.Clear;
  ibs.SQL.Add('select * from tovar where (kod_vidtovar = :kod_v)');
  ibs.SQL.Add('and (kol_tovara <> 0)');
  ibs.SQL.Add('order by naz_tovar');
  ibs.ParamByName('kod_v').AsInteger := kod;
  ibs.ExecQuery;

  LBTovar.Items.Clear;

  MasT := nil;
  setlength(MasT,razmerT);
  i := 0;

  with ibs do
   begin
     while not eof do
      begin

        MasT[i][0] := FieldByName('kod_tovara').AsString;
        MasT[i][1] := DelitP(FieldByName('naz_tovar').AsString);
        MasT[i][2] := FieldByName('cena_tovara').AsString;
        MasT[i][3] := DelitP(FieldByName('serial_num').AsString);
        MasT[i][4] := FieldByName('kol_tovara').AsString;
        MasT[i][5] := FieldByName('garantiya').AsString;
        inc(i);
        next;

      end;
   end;

   for i := 0 to razmerT - 1 do
    begin
      LBTovar.Items.Add(MasT[i][1]);
    end;

end;

procedure TFGlav.FormCreate(Sender: TObject);
begin

 try
  ibd.Open;
  LBVidFull;
 except
   application.MessageBox('Не удается усановить связь с базой!','Ошибка',MB_ICONERROR);
   application.Terminate;
 end;

end;

procedure TFGlav.LBVidClick(Sender: TObject);
begin

   vidtovar := StrToInt(MasV[LBVid.ItemIndex][0]);

   LBTovarFull(vidtovar);


end;

procedure TFGlav.FormShow(Sender: TObject);
begin
   FVhod.Visible := false;
end;

procedure TFGlav.N1Click(Sender: TObject);
begin

 FAddTV := TFAddTV.Create(Self);

 try
   FAddTv.Height := 154;
   FAddTV.Width := 448;
   FAddTV.Caption := 'Добавление вида товара';
   FAddTV.TS1.Destroy;
   FAddTV.ShowModal;
 finally
   FAddTv.Free;
 end;

end;

procedure TFGlav.N3Click(Sender: TObject);
begin

 if vidtovar = 0 then
  begin
    application.MessageBox('Выберите тип товара!','Предупреждение',MB_ICONWARNING);
    abort;
  end;

 FAddTV := TFAddTV.Create(Self);

 try
   FAddTv.Height := 154;
   FAddTV.Width := 448;
   FAddTV.TS1.Destroy;
   FAddTV.Caption := 'Редактирование вида товара';
   FAddTV.EVid.Text := MasV[LBVid.ItemIndex][1];
   FAddTV.ShowModal;
 finally
   FAddTv.Free;
 end;
end;

procedure TFGlav.N2Click(Sender: TObject);
begin
  if vidtovar = 0 then
  begin
    application.MessageBox('Выберите тип товара!','Предупреждение',MB_ICONWARNING);
    abort;
  end;

  if application.MessageBox('Вы действительно хотите удалить данный вид товара?',
                            'Удаление вида товара',MB_ICONQUESTION + MB_YESNO) = idYes then
   begin

     try

       if ibt.InTransaction then ibt.Commit;

       ibt.StartTransaction;

       ibs.Close;
       ibs.SQL.Clear;
       ibs.SQL.Add('delete from zakaz where kod_tovara in (');
       ibs.SQL.Add('select kod_tovara from tovar where kod_vidtovar = :kod_v)');
       ibs.ParamByName('kod_v').AsInteger := vidtovar;
       ibs.ExecQuery;

       ibs.Close;
       ibs.SQL.Clear;
       ibs.SQL.Add('delete from tovar where kod_vidtovar = :kod_v1');
       ibs.ParamByName('kod_v1').AsInteger := vidtovar;
       ibs.ExecQuery;

       ibs.Close;
       ibs.SQL.Clear;
       ibs.SQL.Add('delete from vidtovara where kod_vidtovar = :kod_v2');
       ibs.ParamByName('kod_v2').AsInteger := vidtovar;
       ibs.ExecQuery;

       LBVidFull;
       LBTovar.Items.Clear;

       ibt.Commit;

     except

      ibt.Rollback;
      raise;

     end;

   end;

end;

function TFGlav.DelitP(stroka: string):string;
var
 i : integer;
 k : byte;
begin

 k := 0;

 for i := 1 to length(stroka) do
  begin
   if (k<=2) then
    begin
    if (stroka[i] = ' ') and (stroka[i+1] = ' ') then
      inc(k);
    if k = 2 then
      DelitP := copy(stroka,1,i - 2);
    end;
  end;

end;


procedure TFGlav.N4Click(Sender: TObject);
begin

 if vidtovar = 0 then
  begin
    application.MessageBox('Выберите тип товара куда нужно добавить товар!','Предупреждение',MB_ICONWARNING);
    abort;
  end;


   FAddTV := TFAddTV.Create(Self);

 try
   FAddTv.Height := 255;
   FAddTV.Width := 495;
   FAddTV.Caption := 'Добавление товара';
   FAddTV.TS.Destroy;
   FAddTV.ShowModal;
 finally
   FAddTv.Free;
 end;
end;

procedure TFGlav.LBTovarClick(Sender: TObject);
begin
 kodtovara := StrToInt(MasT[LBTovar.ItemIndex][0]);
end;

procedure TFGlav.N6Click(Sender: TObject);
begin

  if kodtovara = 0 then
  begin
    application.MessageBox('Выберите товар который нужно редактировать!','Предупреждение',MB_ICONWARNING);
    abort;
  end;


   FAddTV := TFAddTV.Create(Self);

 try
   FAddTv.Height := 255;
   FAddTV.Width := 495;
   FAddTV.ENazT.Text := MasT[LBTovar.ItemIndex][1];
   FAddTV.ESerN.Text := MasT[LBTovar.ItemIndex][3];
   FAddTV.EKolT.Text := MasT[LBTovar.ItemIndex][4];
   FAddTV.ECena.Text := MasT[LBTovar.ItemIndex][2];
   FAddTV.ESrok.Text := MasT[LBTovar.ItemIndex][5];
   FAddTV.Caption := 'Редактирование товара';
   FAddTV.TS.Destroy;
   FAddTV.ShowModal;
 finally
   FAddTv.Free;
 end;

end;

procedure TFGlav.N5Click(Sender: TObject);
var
 n : integer;
begin

if kodtovara = 0 then
  begin
    application.MessageBox('Выберите название товара!','Предупреждение',MB_ICONWARNING);
    abort;
  end;


  if application.MessageBox('Вы действительно хотите удалить данный товар?',
                            'Удаление товара',MB_ICONQUESTION + MB_YESNO) = idYes then
   begin

     try

       if ibt.InTransaction then ibt.Commit;

       ibt.StartTransaction;

       ibs.Close;
       ibs.SQL.Clear;
       ibs.SQL.Add('select kod_zakaz from zakaz where kod_tovara = :kod_t');
       ibs.ParamByName('kod_t').AsInteger := kodtovara;
       ibs.ExecQuery;

       n := ibs.Fields[0].AsInteger;

       if n <> 0 then
        begin
          application.MessageBox('Невозможно удалить товар, т.к. он содержится в заказе!','Предупреждение',MB_ICONWARNING);
          abort;
        end;

       ibs.Close;
       ibs.SQL.Clear;
       ibs.SQL.Add('delete from zakaz where kod_tovara = :kod_t');
       ibs.ParamByName('kod_t').AsInteger := kodtovara;
       ibs.ExecQuery;

       ibs.Close;
       ibs.SQL.Clear;
       ibs.SQL.Add('delete from tovar where kod_tovara = :kod_t1');
       ibs.ParamByName('kod_t1').AsInteger := kodtovara;
       ibs.ExecQuery;

       LBTovarFull(vidtovar);

       ibt.Commit;

     except

      ibt.Rollback;
      raise;

     end;

   end;
end;

procedure TFGlav.LBTovarDblClick(Sender: TObject);
begin

    FAddTV := TFAddTV.Create(Self);

 try
   FAddTv.Height := 255;
   FAddTV.Width := 495;
   FAddTV.ENazT.Text := MasT[LBTovar.ItemIndex][1];
   FAddTV.ESerN.Text := MasT[LBTovar.ItemIndex][3];
   FAddTV.EKolT.Text := MasT[LBTovar.ItemIndex][4];
   FAddTV.ECena.Text := MasT[LBTovar.ItemIndex][2];
   FAddTV.ESrok.Text := MasT[LBTovar.ItemIndex][5];
   FAddTV.Caption := 'Сведния о товаре';
   FAddTV.ENazT.ReadOnly := true;
   FAddTV.ESerN.ReadOnly := true;
   FAddTV.EKolT.ReadOnly := true;
   FAddTV.ECena.ReadOnly := true;
   FAddTV.ESrok.ReadOnly := true;
   FAddTV.SBAddT.Visible := false;
   FAddTV.TS.Destroy;
   FAddTV.ShowModal;
 finally
   FAddTv.Free;
 end;
end;

procedure TFGlav.BBSotrudClick(Sender: TObject);
begin

  FSot := TFSot.Create(Self);

  try
    FSot.ShowModal;
  finally
    FSot.Free;
  end;

end;

procedure TFGlav.BBNaryadClick(Sender: TObject);
begin

   FNaryad := TFNaryad.Create(Self);

   try
     Fnaryad.ShowModal;
   finally
     FNaryad.Free;
   end;

end;

procedure TFGlav.BBZakazchikClick(Sender: TObject);
begin
  Fzakazchik := TFZakazchik.Create(Self);
   try

     FZakazchik.ShowModal;
   finally
     Fzakazchik.Free;
   end;
end;

procedure TFGlav.BBZakazClick(Sender: TObject);
begin

  Fzakaz := TFZakaz.Create(Self);

  try
    FZakaz.ShowModal;
  finally
    FZakaz.Free;
  end;

end;

procedure TFGlav.BBDocumClick(Sender: TObject);
begin

  FDocum := TFDocum.Create(Self);

  try
   FDocum.ShowModal;
  finally
   FDocum.Free;
  end;

end;

procedure TFGlav.N9Click(Sender: TObject);
begin
  FVhod.Visible := true;
  FVhod.EPolz.Text := '';
  FVhod.EPasw.Text := '';
  FGlav.Close;
end;

procedure TFGlav.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  application.Terminate;
end;

end.
