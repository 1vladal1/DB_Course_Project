unit UZakazchik;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Grids;

type
  TFZakazchik = class(TForm)
    SGZ: TStringGrid;
    SBAddZak: TSpeedButton;
    SBDelZak: TSpeedButton;
    SBEditzak: TSpeedButton;
    SBCanZak: TSpeedButton;
    procedure SBCanZakClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SBAddZakClick(Sender: TObject);
    procedure SBEditzakClick(Sender: TObject);
    procedure SGZSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SBDelZakClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SGZZapol;
  end;

var
  FZakazchik: TFZakazchik;
   nom_zakaz : integer;

implementation

{$R *.dfm}

uses UAddZakaz, UGlav;

var
 vibstr : integer;

procedure TFZakazchik.SBCanZakClick(Sender: TObject);
begin
 FZakazchik.Close;
end;

procedure TFZakazchik.FormCreate(Sender: TObject);
var
 i : integer;
begin

  with SGZ do
   begin
     Cells[0,0] := '  Название организации';
     Cells[1,0] := '  Контактное лицо';
     Cells[2,0] := '  Адрес';
     Cells[3,0] := '  Телефон';
     Cells[4,0] := '  Факс';
   end;

   for i := 0 to 4 do
    SGZ.ColWidths[i] := 200;

    SGZZapol;

end;

procedure TFZakazchik.SBAddZakClick(Sender: TObject);
begin

  FAddZak := TFAddZak.Create(Self);

  try
    FAddZak.ShowModal;
  finally
    FAddZak.Free;
  end;

end;

procedure TFZakazchik.SGZZapol;
var
 i : integer;
begin

   if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

     FGlav.ibt.StartTransaction;

     FGlav.ibs.Close;
     FGlav.ibs.SQL.Clear;
     FGlav.ibs.SQL.Add('select count(*) from zakazchik');
     FGlav.ibs.ExecQuery;

     SGZ.RowCount := FGlav.ibs.Fields[0].AsInteger + 1;

     FGlav.ibs.Close;
     FGlav.ibs.SQL.Clear;
     FGlav.ibs.SQL.Add('select * from zakazchik');
     FGlav.ibs.SQL.Add('order by naz_organiz');
     FGlav.ibs.ExecQuery;

     i := 1;

     with FGlav.ibs do
      begin
       while not eof do
        begin
          SGZ.Cells[0,i] := FGlav.DelitP(FieldByName('naz_organiz').AsString);
          SGZ.Cells[1,i] := FGlav.DelitP(FieldByName('kon_lico').AsString);
          SGZ.Cells[2,i] := FGlav.delitP(FieldByName('address').AsString);
          SGZ.Cells[3,i] := FGlav.DelitP(FieldByName('tel').AsString);
          SGZ.Cells[4,i] := FGlav.DelitP(FieldByName('fax').AsString);
          SGZ.Cells[5,i] := FieldByName('kod_zakazchik').AsString;
          inc(i);
          next;
        end;
      end;
end;

procedure TFZakazchik.SBEditzakClick(Sender: TObject);
begin

 FAddZak := TFAddZak.Create(Self);

  try

    FAddZak.ENazOrg.Text := SGZ.Cells[0,vibstr];
    FAddZak.EKonLic.Text := SGZ.Cells[1,vibstr];
    FAddZak.EAdres.Text := SGZ.Cells[2,vibstr];
    FAddZak.ETel.Text := SGZ.Cells[3,vibstr];
    FAddZak.EFax.Text := SGZ.Cells[4,vibstr];

    FAddZak.Caption := 'Редактирование заказчика';
    FAddZak.SBAddZ.Caption := 'Изменить';

    FAddZak.ShowModal;

  finally
    FAddZak.Free;
  end;

end;

procedure TFZakazchik.SGZSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
   vibstr := arow;
   nom_zakaz := StrToInt(SGZ.Cells[5,arow]);
end;

procedure TFZakazchik.SBDelZakClick(Sender: TObject);
begin

  if nom_zakaz = 0 then
   begin
     application.MessageBox('Выберите заказчика!','Ошибка',MB_ICONERROR);
     abort;
   end;

  if application.MessageBox('Вы действительно хотите удалить заказчика?','Удаление заказчика',MB_ICONQUESTION + MB_YESNO) = idYes then
   begin
     try
       if FGlav.ibt.InTransaction then FGlav.ibt.Commit;
        FGlav.ibt.StartTransaction;

          FGlav.ibs.Close;
          FGlav.ibs.SQL.Clear;
          FGlav.ibs.SQL.Add('delete from zakazchik where kod_zakazchik = :kod_z');
          FGlav.ibs.ParamByName('kod_z').AsInteger := nom_zakaz;
          FGlav.ibs.ExecQuery;

          SGZZapol;

        FGlav.ibt.Commit;
     except
        FGlav.ibt.Rollback;
        raise;
     end;
   end;

end;

end.
