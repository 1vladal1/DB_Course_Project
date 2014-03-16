unit USot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, ComCtrls, IBSQL, StdCtrls, Mask, Menus, ExtCtrls;

type
  TFSot = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    SG: TStringGrid;
    SBBack: TSpeedButton;
    SBAddS: TSpeedButton;
    SBDelS: TSpeedButton;
    SBEditS: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Efio: TEdit;
    ERabt: TEdit;
    EStav: TEdit;
    ETabN: TEdit;
    MDatr: TMaskEdit;
    EDomA: TEdit;
    EDomt: TEdit;
    SBVstavit: TSpeedButton;
    SBClose: TSpeedButton;
    CBOtd: TComboBox;
    CBDolg: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    ibs1: TIBSQL;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    SBFiltr: TSpeedButton;
    LBOtd: TListBox;
    LBDolg: TListBox;
    SBRefresh: TSpeedButton;
    Bevel1: TBevel;
    GB: TGroupBox;
    LbSotr: TListBox;
    PosS: TMenuItem;
    procedure SBBackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBOtdChange(Sender: TObject);
    procedure CBOtdDropDown(Sender: TObject);
    procedure CBDolgDropDown(Sender: TObject);
    procedure CBDolgChange(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure SBVstavitClick(Sender: TObject);
    procedure SBAddSClick(Sender: TObject);
    procedure SBCloseClick(Sender: TObject);
    procedure SGSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SBEditSClick(Sender: TObject);
    procedure SBDelSClick(Sender: TObject);
    procedure LBOtdClick(Sender: TObject);
    procedure SBRefreshClick(Sender: TObject);
    procedure LBDolgClick(Sender: TObject);
    procedure SBFiltrClick(Sender: TObject);
    procedure PosSClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    procedure CBOtdFull;
    procedure CBDolgFull(kod: integer);
    procedure SgZapol;
  public
    { Public declarations }
  end;

var
  FSot: TFSot;

implementation

{$R *.dfm}

uses UGlav;

var
 MasO : array of array [0..1] of string;
 MasD : array of array [0..2] of string;
 razmerO, razmerD, indO, indD, kodo, kodd, kods : integer;
 flagO, flagD, prosmD : boolean;
 nom_str, vibotd, vibdolg : integer;

procedure TFSot.SBBackClick(Sender: TObject);
begin
  FSot.Close;
end;

procedure TFSot.FormCreate(Sender: TObject);
var
 i : integer;
begin

   with SG do
  begin
   Cells[0,0] := 'Ф.И.О.';
   Cells[1,0] := 'Должность';
   Cells[2,0] := 'Отдел';
   Cells[3,0] := 'Рабочий телефон';
   Cells[4,0] := 'Ставка';
   Cells[5,0] := 'Табельный номер';
   Cells[6,0] := 'Дата рождения';
   Cells[7,0] := 'Домашний адрес';
   Cells[8,0] := 'Домашний телефон';
  end;

 for i := 0 to 8 do
  SG.ColWidths[i] := 220;
  SG.ColWidths[3] := 140;

  CBOtdFull;
  SGZapol;
  PageControl1.ActivePage := TabSheet1;

  flagO := false;
  flagD := false;
  prosmD := false;

end;

procedure TFSot.CBOtdFull;
var
 i : integer;
begin

 ibs1.Close;
 ibs1.SQL.Clear;
 ibs1.SQL.Add('select count(*) from otdel');
 ibs1.ExecQuery;

 razmero := ibs1.Fields[0].AsInteger;

 ibs1.Close;
 ibs1.SQL.Clear;
 ibs1.SQL.Add('select * from otdel');
 ibs1.SQL.Add('order by naz_otdel');
 ibs1.ExecQuery;
 CBOtd.Items.Clear;
 LBOtd.Items.Clear;

 MasO := nil;
 SetLength(MasO,razmero);
 i := 0;

 with ibs1 do
  begin
   while not eof do
    begin
     MasO[i][0] := Fields[0].AsString;
     MasO[i][1] := FGlav.DelitP(Fields[1].AsString);
     inc(i);
     next;
    end;
  end;

 for i := 0 to razmero - 1 do
   begin
     CBOtd.Items.Add(MasO[i][1]);
     LBOtd.Items.Add(MasO[i][1]);
   end;

end;

procedure TFSot.CBDolgFull(kod: integer);
var
 i : integer;
begin

 CBDolg.Text := '';

 ibs1.Close;
 ibs1.SQL.Clear;
 ibs1.SQL.Add('select count(*) from dolgnost where kod_otdel = :kod_o');
 ibs1.ParamByName('kod_o').Value := kod;
 ibs1.ExecQuery;

 razmerd := ibs1.Fields[0].AsInteger;

 ibs1.Close;
 ibs1.SQL.Clear;
 ibs1.SQL.Add('select * from dolgnost where kod_otdel = :kod_o1');
 ibs1.SQL.Add('order by naz_doolgnost');
 ibs1.ParamByName('kod_o1').Value := kod;
 ibs1.ExecQuery;

 CBDolg.Items.Clear;
 LBDolg.Items.Clear;

 MasD := nil;
 SetLength(MasD, razmerd);
 i := 0;

  with ibs1 do
  begin
   while not eof do
    begin
     MasD[i][0] := Fields[0].AsString;
     MasD[i][1] := FGlav.DelitP(Fields[1].AsString);
     MasD[i][2] := Fields[2].AsString;
     inc(i);
     next;
    end;
  end;

  for i := 0 to razmerd - 1 do
   begin
    CBDolg.Items.Add(MasD[i][1]);
    LBDolg.Items.Add(MasD[i][1]);
   end;

end;


procedure TFSot.CBOtdChange(Sender: TObject);
begin

if flagO then
 begin

 indO := CBOtd.ItemIndex;
 flagO := false;

 ibs1.Close;
 ibs1.SQL.Clear;
 ibs1.SQL.Add('select kod_otdel from otdel where naz_otdel = :naz_o');
 ibs1.ParamByName('naz_o').Value := CBOtd.Text;
 ibs1.ExecQuery;

 kodo := ibs1.Fields[0].AsInteger;

 CBDolgFull(kodo);

 CBDolg.Enabled := true;
 
 end;

end;

procedure TFSot.CBOtdDropDown(Sender: TObject);
begin
 flago := true;
end;

procedure TFSot.CBDolgDropDown(Sender: TObject);
begin
  flagD := true;
end;

procedure TFSot.CBDolgChange(Sender: TObject);
begin
   if flagD then
     begin
     indD := CBDolg.ItemIndex;
     flagD := false;

     ibs1.Close;
     ibs1.SQL.Clear;
     ibs1.SQL.Add('select kod_dolgnost from dolgnost where (naz_doolgnost = :naz_d) and (kod_otdel = :kod_o)');
     ibs1.ParamByName('naz_d').Value := CBDolg.Text;
     ibs1.ParamByName('kod_o').Value := kodo;
     ibs1.ExecQuery;

     kodd := ibs1.Fields[0].AsInteger;

   end;
end;

procedure TFSot.N1Click(Sender: TObject);
begin

 if CBOtd.Text = '' then
  begin
    application.MessageBox('Введите название отдела!','Ошибка',MB_ICONERROR);
    abort;
  end;

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('insert into otdel (kod_otdel, naz_otdel)');
  ibs1.SQL.Add('values (0, :naz_o)');
  ibs1.ParamByName('naz_o').AsString := CBOtd.Text;
  ibs1.ExecQuery;

  CBOtdFull;

  CBDolg.Enabled := false;

  CBDolg.Text := '';
  CBOtd.Text := '';

end;

procedure TFSot.N2Click(Sender: TObject);
begin
  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from naryad where kod_sotrud in (');
  ibs1.SQL.Add('select kod_sotrud from sotrudniki where kod_dolgnost in (');
  ibs1.SQL.Add('select kod_dolgnost from dolgnost where kod_otdel = :kod_o))');
  ibs1.ParamByName('kod_o').AsInteger := kodo;
  ibs1.ExecQuery;

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from zakaz where kod_docum in (');
  ibs1.SQL.Add('select kod_docum from docum where kod_sotrud in (');
  ibs1.SQL.Add('select kod_sotrud from sotrudniki where kod_dolgnost in (');
  ibs1.SQL.Add('select kod_dolgnost from dolgnost where kod_otdel = :kod_o1)))');
  ibs1.ParamByName('kod_o1').AsInteger := kodo;
  ibs1.ExecQuery;


  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from docum where kod_sotrud in (');
  ibs1.SQL.Add('select kod_sotrud from sotrudniki where kod_dolgnost in (');
  ibs1.SQL.Add('select kod_dolgnost from dolgnost where kod_otdel = :kod_o2))');
  ibs1.ParamByName('kod_o2').AsInteger := kodo;
  ibs1.ExecQuery;

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from sotrudniki where kod_dolgnost in (');
  ibs1.SQL.Add('select kod_dolgnost from dolgnost where kod_otdel = :kod_o3)');
  ibs1.ParamByName('kod_o3').AsInteger := kodo;
  ibs1.ExecQuery;

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from dolgnost where kod_otdel = :kod_o4');
  ibs1.ParamByName('kod_o4').AsInteger := kodo;
  ibs1.ExecQuery;

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from otdel where kod_otdel = :kod_o5');
  ibs1.ParamByName('kod_o5').AsInteger := kodo;
  ibs1.ExecQuery;

  CBOtd.Text := '';
  CBDolg.Text := '';

  CBOtdFull;

  CBDolg.Enabled := false;
end;

procedure TFSot.N3Click(Sender: TObject);
var
  n : integer;
begin
  n := StrToInt(MasO[indO][0]);

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('update otdel set naz_otdel = :naz_o where kod_otdel = :kod_o');
  ibs1.ParamByName('kod_o').AsInteger := n;
  ibs1.ParamByName('naz_o').AsString := CBOtd.Text;
  ibs1.ExecQuery;

  CBOtdFull;
end;

procedure TFSot.N4Click(Sender: TObject);
begin
  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('insert into dolgnost (kod_dolgnost, naz_doolgnost, kod_otdel)');
  ibs1.SQL.Add('values (0, :naz_d, :kod_o)');
  ibs1.ParamByName('naz_d').AsString := CBDolg.Text;
  ibs1.ParamByName('kod_o').AsInteger := kodo;
  ibs1.ExecQuery;

  CBDolgFull(kodo);
end;

procedure TFSot.N5Click(Sender: TObject);
begin
  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from naryad where kod_sotrud in (');
  ibs1.SQL.Add('select kod_sotrud from sotrudniki where kod_dolgnost = :kod_d)');
  ibs1.ParamByName('kod_d').AsInteger := kodd;
  ibs1.ExecQuery;

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from zakaz where kod_docum in (');
  ibs1.SQL.Add('select kod_docum from docum where kod_sotrud in (');
  ibs1.SQL.Add('select kod_sotrud from sotrudniki where kod_dolgnost = :kod_d1))');
  ibs1.ParamByName('kod_d1').AsInteger := kodd;
  ibs1.ExecQuery;


  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from docum where kod_sotrud in (');
  ibs1.SQL.Add('select kod_sotrud from sotrudniki where kod_dolgnost = :kod_d2)');
  ibs1.ParamByName('kod_d2').AsInteger := kodd;
  ibs1.ExecQuery;

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from sotrudniki where kod_dolgnost = :kod_d3');
  ibs1.ParamByName('kod_d3').AsInteger := kodd;
  ibs1.ExecQuery;

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from dolgnost where kod_dolgnost = :kod_d4');
  ibs1.ParamByName('kod_d4').AsInteger := kodd;
  ibs1.ExecQuery;

  CBDolg.Text := '';

  CBDolgFull(kodo);
end;

procedure TFSot.N6Click(Sender: TObject);
var
 n : integer;
begin
   n := StrToInt(MasD[indD][0]);

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('update dolgnost set naz_doolgnost = :naz_d where kod_dolgnost = :kod_d');
  ibs1.ParamByName('kod_d').AsInteger := n;
  ibs1.ParamByName('naz_d').AsString := CBDolg.Text;
  ibs1.ExecQuery;

  CBDolgFull(kodo);

end;

procedure TFSot.SBVstavitClick(Sender: TObject);
begin
  if (Efio.Text = '') or (ERabt.Text = '') or (CBOtd.Text = '') or
     (CBdolg.Text = '') or (EStav.Text = '') or (ETabN.Text = '') or
     (MDatr.Text = '  .  .  ') or (EDomA.Text = '') or (EDomt.Text = '') then
      begin
         application.MessageBox('Не все данные заполнены!','Ошибка',MB_ICONERROR);
         abort;
      end;


  if SBVstavit.Caption = 'Вставить' then
   begin

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('insert into sotrudniki (kod_sotrud, stavka, kod_dolgnost, rab_tel, fio, tab_nomer, data_rog, dom_address, dom_tel)');
  ibs1.SQL.Add('values (0, :stav, :kod_d, :rab_t, :fam, :tab_n, :dat_r, :dom_a, :dom_t)');
  ibs1.ParamByName('stav').AsInteger := StrToInt(EStav.Text);
  ibs1.ParamByName('kod_d').AsInteger := kodd;
  ibs1.ParamByName('rab_t').AsString := ERabt.Text;
  ibs1.ParamByName('fam').AsString := Efio.Text;
  ibs1.ParamByName('tab_n').AsInteger := StrToInt(ETabN.Text);
  ibs1.ParamByName('dat_r').AsDate := StrToDate(Mdatr.Text);
  ibs1.ParamByName('dom_a').AsString := EDomA.Text;
  ibs1.ParamByName('dom_t').AsString := EDomt.Text;
  ibs1.ExecQuery;


  end
    else
     begin

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('update sotrudniki set stavka = :stav, kod_dolgnost = :kod_d, rab_tel = :rab_t,');
  ibs1.SQL.Add('fio = :fam, tab_nomer = :tab_n, data_rog = :dat_r, dom_address = :dom_a, dom_tel = :dom_t');
  ibs1.SQL.Add('where kod_sotrud = :kod_s');
  ibs1.ParamByName('stav').AsInteger := StrToInt(EStav.Text);
  ibs1.ParamByName('kod_d').AsInteger := kodd;
  ibs1.ParamByName('rab_t').AsString := ERabt.Text;
  ibs1.ParamByName('fam').AsString := Efio.Text;
  ibs1.ParamByName('tab_n').AsInteger := StrToInt(ETabN.Text);
  ibs1.ParamByName('dat_r').AsDate := StrToDate(Mdatr.Text);
  ibs1.ParamByName('dom_a').AsString := EDomA.Text;
  ibs1.ParamByName('dom_t').AsString := EDomt.Text;
  ibs1.ParamByName('kod_s').AsInteger := kods; 
  ibs1.ExecQuery;

     end;

  SGzapol;

  Efio.Color := clBtnFace;
  ETabN.Color := clBtnFace;
  ERabt.Color := clBtnFace;
  Mdatr.Color := clBtnFace;
  EDomA.Color := clBtnFace;
  EDomt.Color := clBtnFace;
  EStav.Color := clBtnFace;
  CBDolg.Color := clBtnFace;
  CBotd.Color := clBtnFace;
  SBVstavit.Enabled := false;
  SBClose.Enabled := false;
  TabSheet2.Enabled := false;
  PageControl1.ActivePage := TabSheet1;
  SBVstavit.Caption := '';

  Efio.Text := '';
  ETabN.Text := '';
  ERabt.Text := '';
  Mdatr.Text := '  .  .  ';
  EDomA.Text := '';
  EDomt.Text := '';
  EStav.Text := '';
  CBDolg.Text := '';
  CBOtd.Text := '';

end;

procedure TFSot.SgZapol;
var
 i : integer;
begin

 ibs1.Close;
 ibs1.SQL.Clear;
 ibs1.SQL.Add('select count(*) from sotrudniki');
 ibs1.ExecQuery;

 SG.RowCount := ibs1.Fields[0].AsInteger + 1;

 ibs1.Close;
 ibs1.SQL.Clear;
 ibs1.SQL.Add('select S.*, O.naz_otdel, D.naz_doolgnost');
 ibs1.SQL.Add('from sotrudniki S, otdel O, dolgnost D');
 ibs1.SQL.Add('where (S.kod_dolgnost = D.kod_dolgnost) and (D.kod_otdel = O.kod_otdel)');
 ibs1.SQL.Add('order by S.fio');
 ibs1.ExecQuery;

 i := 1;

 with ibs1 do
  begin
    while not eof do
     begin
     
        SG.Cells[0,i] := FGlav.DelitP(FieldByName('fio').AsString); // 'Ф.И.О.';
        SG.Cells[1,i] := FGlav.DelitP(FieldByName('naz_doolgnost').AsString); //'Должность';
        SG.Cells[2,i] := FGlav.DelitP(FieldByName('naz_otdel').AsString); //'Отдел';
        SG.Cells[3,i] := FGlav.DelitP(FieldByName('rab_tel').AsString); //'Рабочий телефон';
        SG.Cells[4,i] := FieldByName('stavka').AsString; //'Ставка';
        SG.Cells[5,i] := FieldByName('tab_nomer').AsString; //'Табельный номер';
        SG.Cells[6,i] := FieldByName('data_rog').AsString; //'Дата рождения';
        SG.Cells[7,i] := FGlav.DelitP(FieldByName('dom_address').AsString); //'Домашний адрес';
        SG.Cells[8,i] := FGlav.DelitP(FieldByName('dom_tel').AsString); //'Домашний телефон';
        SG.Cells[9,i] := FieldByName('kod_sotrud').AsString;
        inc(i);
        next;

     end;
  end;

end;

procedure TFSot.SBAddSClick(Sender: TObject);
begin
  Efio.Color := clWindow;
  ETabN.Color := clWindow;
  ERabt.Color := clWindow;
  Mdatr.Color := clWindow;
  EDomA.Color := clWindow;
  EDomt.Color := clWindow;
  EStav.Color := clWindow;
  CBDolg.Color := clWindow;
  CBotd.Color := clWindow;
  SBVstavit.Enabled := true;
  SBClose.Enabled := true;
  TabSheet2.Enabled := true;
  PageControl1.ActivePage := TabSheet2;
  SBVstavit.Caption := 'Вставить';
end;

procedure TFSot.SBCloseClick(Sender: TObject);
begin
  Efio.Color := clBtnFace;
  ETabN.Color := clBtnFace;
  ERabt.Color := clBtnFace;
  Mdatr.Color := clBtnFace;
  EDomA.Color := clBtnFace;
  EDomt.Color := clBtnFace;
  EStav.Color := clBtnFace;
  CBDolg.Color := clBtnFace;
  CBotd.Color := clBtnFace;
  SBVstavit.Enabled := false;
  SBClose.Enabled := false;
  TabSheet2.Enabled := false;
  PageControl1.ActivePage := TabSheet1;
  SBVstavit.Caption := '';
end;

procedure TFSot.SGSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
   nom_str := arow;
   kods := StrToInt(SG.Cells[9,arow]);
   SBDels.Enabled := true;
   SBEditS.Enabled := true;
end;

procedure TFSot.SBEditSClick(Sender: TObject);
begin
  Efio.Text := SG.Cells[0,nom_str];
  ETabN.Text := SG.Cells[5,nom_str];
  ERabt.Text := SG.Cells[3,nom_str];
  Mdatr.Text := SG.Cells[6,nom_str];
  EDomA.Text := SG.Cells[7,nom_str];
  EDomt.Text := SG.Cells[8,nom_str];
  EStav.Text := SG.Cells[4,nom_str];
  CBDolg.Text := SG.Cells[1,nom_str];
  CBOtd.Text := SG.Cells[2,nom_str];
  Efio.Color := clWindow;
  ETabN.Color := clWindow;
  ERabt.Color := clWindow;
  Mdatr.Color := clWindow;
  EDomA.Color := clWindow;
  EDomt.Color := clWindow;
  EStav.Color := clWindow;
  CBDolg.Color := clWindow;
  CBotd.Color := clWindow;
  SBVstavit.Enabled := true;
  SBClose.Enabled := true;
  TabSheet2.Enabled := true;
  PageControl1.ActivePage := TabSheet2;
  SBVstavit.Caption := 'Изменить';
end;

procedure TFSot.SBDelSClick(Sender: TObject);
begin
  if application.MessageBox('Вы действительно хотите удалить сотрудника?','Удаление сотрудника',MB_ICONQUESTION + MB_YESNO) = idYes then
   begin

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from naryad where kod_sotrud = :kod_s');
  ibs1.ParamByName('kod_s').AsInteger := kods;
  ibs1.ExecQuery;

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from zakaz where kod_docum in (');
  ibs1.SQL.Add('select kod_docum from docum where kod_sotrud = :kod_s1)');
  ibs1.ParamByName('kod_s1').AsInteger := kods;
  ibs1.ExecQuery;


  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from docum where kod_sotrud = :kod_s2');
  ibs1.ParamByName('kod_s2').AsInteger := kods;
  ibs1.ExecQuery;

  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('delete from sotrudniki where kod_sotrud = :kod_s3');
  ibs1.ParamByName('kod_s3').AsInteger := kods;
  ibs1.ExecQuery;

  SGZapol;

   end;
end;

procedure TFSot.LBOtdClick(Sender: TObject);
begin
  vibotd := StrToInt(MasO[LBOtd.ItemIndex][0]);

  CBDolgFull(vibotd);

  SBFiltr.Enabled := true;
  prosmD := false;

end;

procedure TFSot.SBRefreshClick(Sender: TObject);
begin
 SGZapol;
end;

procedure TFSot.LBDolgClick(Sender: TObject);
begin
  prosmD := true;
  vibdolg := StrToInt(MasD[LBDolg.ItemIndex][0]);
end;

procedure TFSot.SBFiltrClick(Sender: TObject);
var
 i : integer;
begin
  if prosmD then
   begin

   ibs1.Close;
   ibs1.SQL.Clear;
   ibs1.SQL.Add('select count(*) from sotrudniki where kod_dolgnost = :kod_d');
   ibs1.ParamByName('kod_d').AsInteger := vibdolg;
   ibs1.ExecQuery;

   SG.RowCount := ibs1.Fields[0].AsInteger + 1;

   ibs1.Close;
   ibs1.SQL.Clear;
   ibs1.SQL.Add('select S.*, O.naz_otdel, D.naz_doolgnost');
   ibs1.SQL.Add('from sotrudniki S, otdel O, dolgnost D');
   ibs1.SQL.Add('where (S.kod_dolgnost = D.kod_dolgnost) and (D.kod_otdel = O.kod_otdel)');
   ibs1.SQL.Add('and (S.kod_dolgnost = :kod_d1)');
   ibs1.SQL.Add('order by S.fio');
   ibs1.ParamByName('kod_d1').AsInteger := vibdolg;
   ibs1.ExecQuery;

   end
    else
     begin

   ibs1.Close;
   ibs1.SQL.Clear;
   ibs1.SQL.Add('select count(*) from sotrudniki where kod_dolgnost in (');
   ibs1.SQL.Add('select kod_dolgnost from dolgnost where kod_otdel = :kod_o)');
   ibs1.ParamByName('kod_o').AsInteger := vibotd;
   ibs1.ExecQuery;

   SG.RowCount := ibs1.Fields[0].AsInteger + 1;

   ibs1.Close;
   ibs1.SQL.Clear;
   ibs1.SQL.Add('select S.*, O.naz_otdel, D.naz_doolgnost');
   ibs1.SQL.Add('from sotrudniki S, otdel O, dolgnost D');
   ibs1.SQL.Add('where (S.kod_dolgnost = D.kod_dolgnost) and (D.kod_otdel = O.kod_otdel)');
   ibs1.SQL.Add('and (S.kod_dolgnost in (select kod_dolgnost from dolgnost where kod_otdel = :kod_o1))');
   ibs1.SQL.Add('order by S.fio');
   ibs1.ParamByName('kod_o1').AsInteger := vibotd;
   ibs1.ExecQuery;

  end;

   i := 1;

 with ibs1 do
  begin
    while not eof do
     begin
     
        SG.Cells[0,i] := FGlav.DelitP(FieldByName('fio').AsString); // 'Ф.И.О.';
        SG.Cells[1,i] := FGlav.DelitP(FieldByName('naz_doolgnost').AsString); //'Должность';
        SG.Cells[2,i] := FGlav.DelitP(FieldByName('naz_otdel').AsString); //'Отдел';
        SG.Cells[3,i] := FGlav.DelitP(FieldByName('rab_tel').AsString); //'Рабочий телефон';
        SG.Cells[4,i] := FieldByName('stavka').AsString; //'Ставка';
        SG.Cells[5,i] := FieldByName('tab_nomer').AsString; //'Табельный номер';
        SG.Cells[6,i] := FieldByName('data_rog').AsString; //'Дата рождения';
        SG.Cells[7,i] := FGlav.DelitP(FieldByName('dom_address').AsString); //'Домашний адрес';
        SG.Cells[8,i] := FGlav.DelitP(FieldByName('dom_tel').AsString); //'Домашний телефон';
        SG.Cells[9,i] := FieldByName('kod_sotrud').AsString;
        inc(i);
        next;

     end;
  end;

  PageControl1.ActivePage := TabSheet1;
  prosmD := false;
  SBFiltr.Enabled := false;

end;

procedure TFSot.PosSClick(Sender: TObject);
begin


  ibs1.Close;
  ibs1.SQL.Clear;
  ibs1.SQL.Add('select fio from sotrudniki where kod_dolgnost in (');
  ibs1.SQL.Add('select kod_dolgnost from dolgnost where kod_otdel = :kod_o)');
  ibs1.ParamByName('kod_o').AsInteger := kodo;
  ibs1.ExecQuery;

  LBSotr.Items.Clear;

  with ibs1 do
   begin
     while not eof do
      begin
        LBSotr.Items.Add(FGlav.DelitP(FieldByName('fio').AsString));
        next;
      end;
   end;

   GB.Visible := true;

end;

procedure TFSot.PageControl1Change(Sender: TObject);
begin
  GB.Visible := false;
  Efio.Color := clBtnFace;
  ETabN.Color := clBtnFace;
  ERabt.Color := clBtnFace;
  Mdatr.Color := clBtnFace;
  EDomA.Color := clBtnFace;
  EDomt.Color := clBtnFace;
  EStav.Color := clBtnFace;
  CBDolg.Color := clBtnFace;
  CBotd.Color := clBtnFace;
  SBVstavit.Enabled := false;
  SBClose.Enabled := false;
  TabSheet2.Enabled := false;
  SBVstavit.Caption := '';

  Efio.Text := '';
  ETabN.Text := '';
  ERabt.Text := '';
  Mdatr.Text := '  .  .  ';
  EDomA.Text := '';
  EDomt.Text := '';
  EStav.Text := '';
  CBDolg.Text := '';
  CBOtd.Text := '';

end;

end.
