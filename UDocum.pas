unit UDocum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids, ComCtrls, IBSQL, StdCtrls, Mask, DB,
  IBCustomDataSet, IBQuery, DBGrids;

type
  TFDocum = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    SGS: TStringGrid;
    SpeedButton1: TSpeedButton;
    ibs4: TIBSQL;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ENazDoc: TEdit;
    Label2: TLabel;
    MEDatP: TMaskEdit;
    MEDatO: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    EStoim: TEdit;
    GroupBox2: TGroupBox;
    CBTipD: TComboBox;
    GroupBox3: TGroupBox;
    CBZak: TComboBox;
    GroupBox4: TGroupBox;
    CBSotr: TComboBox;
    GroupBox5: TGroupBox;
    CBPrich: TComboBox;
    SBAddDoc: TSpeedButton;
    TabSheet3: TTabSheet;
    SBPosmNaryad: TSpeedButton;
    DataSource1: TDataSource;
    DBG: TDBGrid;
    ibs5: TIBQuery;
    SBPrint: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SBAddDocClick(Sender: TObject);
    procedure SBPosmNaryadClick(Sender: TObject);
    procedure SGSSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SBPrintClick(Sender: TObject);
  private
    { Private declarations }
    procedure SGSFull;
    procedure CBSotrFull;
    procedure CBPrichFull;
    procedure CBTipDFull;
    procedure CBZakFull;
  public
    { Public declarations }
  end;

var
  FDocum: TFDocum;

implementation

{$R *.dfm}

uses UGlav, UOtchet;

var
 koddocument, nom_strok : integer;

procedure TFDocum.SpeedButton1Click(Sender: TObject);
begin
  FDocum.Close;
end;

procedure TfDocum.SGSFull;
var
 i : integer;
begin

  if FGLav.ibt.InTransaction then FGlav.ibt.Commit;

  FGlav.ibt.StartTransaction;

  ibs4.Close;
  ibs4.SQL.Clear;
  ibs4.SQL.Add('select count(*) from docum ');
  ibs4.ExecQuery;

  SGS.RowCount := ibs4.Fields[0].AsInteger + 1;

  ibs4.Close;
  ibs4.SQL.Clear;
  ibs4.SQL.Add('select D.*, P.opis_prichin, T.naz_tipdocum, Z.naz_organiz, S.fio');
  ibs4.SQL.Add('from docum D, prichina P, tipdocum T, zakazchik Z, sotrudniki S');
  ibs4.SQL.Add('where (D.kod_prichina = P.kod_prichina) and (D.kod_tipdocum = T.kod_tipdocum)');
  ibs4.SQL.Add('and (D.kod_zakazchik = Z.kod_zakazchik) and (D.kod_sotrud = S.kod_sotrud)');
  ibs4.SQL.Add('order by D.naz_docum');
  ibs4.ExecQuery;

  i := 1;

  with ibs4 do
   begin
     while not eof do
      begin
          SGS.Cells[0,i] := FGlav.DelitP(FieldByName('naz_docum').AsString);
          SGS.Cells[1,i] := FGlav.DelitP(FieldByName('naz_tipdocum').AsString);
          SGS.Cells[2,i] := FGlav.DelitP(FieldByName('naz_organiz').AsString);
          SGS.Cells[3,i] := FGlav.DelitP(FieldByName('fio').AsString);
          SGS.Cells[4,i] := FieldByName('data_podpis').AsString;
          SGS.Cells[5,i] := FieldByName('data_okon').AsString;
          SGS.Cells[6,i] := FieldByName('stoim').AsString;
          SGS.Cells[7,i] := FGlav.DelitP(FieldByname('opis_prichin').AsString);
          SGS.Cells[8,i] := FieldByName('kod_docum').AsString;
          inc(i);
          next;
      end;
   end;

end;

procedure TFDocum.FormCreate(Sender: TObject);
var
 i : integer;
begin

  with SGS do
   begin
     Cells[0,0] := '  Название документа';
     Cells[1,0] := '  Тип документа';
     Cells[2,0] := '  Имя заказчика';
     Cells[3,0] := '  Имя сотрудника';
     Cells[4,0] := '  Дата подписания';
     Cells[5,0] := '  Дата окончания';
     Cells[6,0] := '  Сумма';
     Cells[7,0] := '  Причина';
   end;

   for i := 0 to 7 do
    SGS.ColWidths[i] := 200;

  SGSFull;
  CBSotrFull;
  CBPrichFull;
  CBTipDFull;
  CBZakFull;

end;

procedure TFDocum.SBAddDocClick(Sender: TObject);
var
 n, m, k, s : integer;
begin

  if (ENazDoc.Text = '') or (MEdatP.Text = '  .  .  ') or (MEDatO.Text = '  .  .  ') or
     (EStoim.Text = '') or (CBSotr.Text = '') or (CBPrich.Text = '') or (CBTipD.Text = '') or
     (CBZak.Text = '') then
      begin
        application.MessageBox('Введены не все данные!','Ошибка',MB_ICONERROR);
        abort;
      end;

   try

    if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

    FGlav.ibt.StartTransaction;

    ibs4.Close;
    ibs4.SQL.Clear;
    ibs4.SQL.Add('select kod_sotrud from sotrudniki where fio = :fio_s');
    ibs4.ParamByName('fio_s').AsString := CBSotr.Text;
    ibs4.ExecQuery;

    s := ibs4.Fields[0].AsInteger;

    if s = 0 then
     begin
       application.MessageBox('Такого сотрудника в базе нет!','Ошибка',MB_ICONERROR);
       abort;
     end;

    ibs4.Close;
    ibs4.SQL.Clear;
    ibs4.SQL.Add('select kod_prichina from prichina where opis_prichin = :op_p');
    ibs4.ParamByName('op_p').AsString := CBPrich.Text;
    ibs4.ExecQuery;

    k := ibs4.Fields[0].AsInteger;

    if k = 0 then
     begin
       application.MessageBox('Такой причины в базе нет!','Ошибка',MB_ICONERROR);
       abort;
     end;

    ibs4.Close;
    ibs4.SQL.Clear;
    ibs4.SQL.Add('select kod_tipdocum from tipdocum where naz_tipdocum = :naz_t');
    ibs4.ParamByName('naz_t').AsString := CBTipD.Text;
    ibs4.ExecQuery;

    m := ibs4.Fields[0].AsInteger;

    if m = 0 then
     begin
       application.MessageBox('Такого типа документа в базе нет!','Ошибка',MB_ICONERROR);
       abort;
     end;

    ibs4.Close;
    ibs4.SQL.Clear;
    ibs4.SQL.Add('select kod_zakazchik from zakazchik where naz_organiz = :naz_o');
    ibs4.ParamByName('naz_o').AsString := CBZak.Text;
    ibs4.ExecQuery;

    n := ibs4.Fields[0].AsInteger;

    if n = 0 then
     begin
       application.MessageBox('Такого заказчика в базе нет!','Ошибка',MB_ICONERROR);
       abort;
     end;

    ibs4.Close;
    ibs4.SQL.Clear;
    ibs4.SQL.Add('insert into docum (kod_docum, kod_prichina, kod_tipdocum, kod_zakazchik,');
    ibs4.SQL.Add('naz_docum, data_podpis, data_okon, kod_sotrud, stoim)');
    ibs4.SQL.Add('values (0, :kod_p, :kod_t, :kod_z, :naz_d, :data_p, :data_o, :kod_s, :st)');
    ibs4.ParamByName('kod_p').AsInteger := k;
    ibs4.ParamByName('kod_t').AsInteger := m;
    ibs4.ParamByName('kod_z').AsInteger := n;
    ibs4.ParamByName('kod_s').AsInteger := s;
    ibs4.ParamByName('naz_d').AsString := ENazDoc.Text;
    ibs4.ParamByName('data_p').AsDate := StrToDate(MEDatP.Text);
    ibs4.ParamByName('data_o').AsDate := StrToDate(MEDatO.Text);
    ibs4.ParamByName('st').AsFloat := StrToFloat(EStoim.Text);
    ibs4.ExecQuery;

    SGSFull;

    FGlav.ibt.Commit;

    ENazDoc.Text := '';
    MEdatP.Text := '  .  .  ';
    MEDatO.Text := '  .  .  ';
    EStoim.Text := '';
    CBSotr.Text := '';
    CBPrich.Text := '';
    CBTipD.Text := '';
    CBZak.Text := '';

   except

    FGlav.ibt.Rollback;
    raise;

   end;

end;

procedure TFDocum.CBSotrFull;
begin

 if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

    FGlav.ibt.StartTransaction;

    ibs4.Close;
    ibs4.SQL.Clear;
    ibs4.SQL.Add('select * from sotrudniki');
    ibs4.ExecQuery;

    CBSotr.Items.Clear;

    with ibs4 do
     begin
       while not eof do
        begin
          CBSotr.Items.Add(FGlav.DelitP(FieldByname('fio').AsString));
          next;
        end;
     end;

end;

procedure TFDocum.CBPrichFull;
begin

   if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

    FGlav.ibt.StartTransaction;


    ibs4.Close;
    ibs4.SQL.Clear;
    ibs4.SQL.Add('select * from prichina');
    ibs4.ExecQuery;

    CBPrich.Items.Clear;

    with ibs4 do
     begin
       while not eof do
        begin
          CBPrich.Items.Add(FGlav.DelitP(FieldByname('opis_prichin').AsString));
          next;
        end;
     end;

end;

procedure TFDocum.CBTipDFull;
begin

   if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

    FGlav.ibt.StartTransaction;


    ibs4.Close;
    ibs4.SQL.Clear;
    ibs4.SQL.Add('select * from tipdocum');
    ibs4.ExecQuery;

    CBTipD.Items.Clear;

    with ibs4 do
     begin
       while not eof do
        begin
          CBTipD.Items.Add(FGlav.DelitP(FieldByname('naz_tipdocum').AsString));
          next;
        end;
     end;

end;

procedure TFDocum.CBZakFull;
begin

    if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

    FGlav.ibt.StartTransaction;


    ibs4.Close;
    ibs4.SQL.Clear;
    ibs4.SQL.Add('select * from zakazchik');
    ibs4.ExecQuery;

    CBZak.Items.Clear;

    with ibs4 do
     begin
       while not eof do
        begin
          CBZak.Items.Add(FGlav.DelitP(FieldByname('naz_organiz').AsString));
          next;
        end;
     end;

end;

procedure TFDocum.SBPosmNaryadClick(Sender: TObject);
begin

 if koddocument = 0 then
   begin
     application.MessageBox('Выберите документ!','Предупреждение',MB_ICONERROR);
     abort;
   end;

  ibs5.Close;
  ibs5.SQL.Clear;
  ibs5.SQL.Add('select N.*, S.fio, D.naz_docum');
  ibs5.SQL.Add('from naryad N, sotrudniki S, docum D');
  ibs5.SQL.Add('where (N.kod_sotrud  = S.kod_sotrud) and (N.kod_docum = :kod_d)');
  ibs5.SQL.Add('and (N.kod_docum = D.kod_docum)');
  ibs5.ParamByName('kod_d').Value := koddocument;
  ibs5.Open;

  PageControl1.ActivePage := TabSheet3;

end;

procedure TFDocum.SGSSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  koddocument := StrToInt(SGS.Cells[8,arow]);
  nom_strok := arow;
end;

procedure TFDocum.SBPrintClick(Sender: TObject);
begin
  FOtchet.QRLabel2.Caption := SGS.Cells[0,nom_strok];
  FOtchet.QuickRep1.Preview;
end;

end.
