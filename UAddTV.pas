unit UAddTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Buttons, StdCtrls, DB, IBCustomDataSet, IBStoredProc;

type
  TFAddTV = class(TForm)
    PageControl1: TPageControl;
    TS: TTabSheet;
    Label1: TLabel;
    EVid: TEdit;
    SBAddV: TSpeedButton;
    SBCancel: TSpeedButton;
    TS1: TTabSheet;
    ibsp: TIBStoredProc;
    Label2: TLabel;
    ENazT: TEdit;
    Label3: TLabel;
    ESerN: TEdit;
    EKolT: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    ECena: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    ESrok: TEdit;
    Label8: TLabel;
    SBAddT: TSpeedButton;
    SBCan: TSpeedButton;
    procedure SBCancelClick(Sender: TObject);
    procedure SBAddVClick(Sender: TObject);
    procedure SBAddTClick(Sender: TObject);
    procedure ECenaKeyPress(Sender: TObject; var Key: Char);
    procedure EKolTKeyPress(Sender: TObject; var Key: Char);
    procedure ESrokKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAddTV: TFAddTV;

implementation

{$R *.dfm}

uses UGlav;

procedure TFAddTV.SBCancelClick(Sender: TObject);
begin
   FAddTV.Close;
end;

procedure TFAddTV.SBAddVClick(Sender: TObject);
begin

  if EVid.Text = '' then
   begin
      application.MessageBox('Введите название вида товара!','Предупреждение',MB_ICONWARNING + MB_OK);
      abort;
   end;

 ibsp.ParamByName('nvidt').AsString := EVid.Text;
 ibsp.ExecProc;

 if ibsp.ParamByName('kvidt').AsString <> '' then
  begin
     application.MessageBox('Такое название вида товара уже существует!','Предупреждение',MB_ICONWARNING + MB_OK);
     abort;
  end;

 if FAddTV.Caption = 'Добавление вида товара' then
 begin

 try

 if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

 FGlav.ibt.StartTransaction;

 FGlav.ibs.Close;
 FGlav.ibs.SQL.Clear;
 FGlav.ibs.SQL.Add('insert into vidtovara (kod_vidtovar, naz_vidtovar)');
 FGlav.ibs.SQL.Add('values (0, :naz_v)');
 FGlav.ibs.ParamByName('naz_v').AsString := EVid.Text;
 FGlav.ibs.ExecQuery;

 FGlav.LBVidFull;
 FGlav.LBTovar.Items.Clear;

 FGlav.ibt.Commit;

 except

   FGlav.ibt.Rollback;
   raise;

 end;
 end
  else
   begin

 try

 if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

 FGlav.ibt.StartTransaction;

 FGlav.ibs.Close;
 FGlav.ibs.SQL.Clear;
 FGlav.ibs.SQL.Add('update vidtovara set naz_vidtovar = :naz_v');
 FGlav.ibs.SQL.Add('where kod_vidtovar = :kod_v');
 FGlav.ibs.ParamByName('naz_v').AsString := EVid.Text;
 FGlav.ibs.ParamByName('kod_v').AsInteger := UGlav.vidtovar;
 FGlav.ibs.ExecQuery;

 FGlav.LBVidFull;

 FGlav.LBTovar.Items.Clear;

 FGlav.ibt.Commit;

 except

   FGlav.ibt.Rollback;
   raise;

 end;

end;

 FAddTV.Close;

end;

procedure TFAddTV.SBAddTClick(Sender: TObject);
begin
 if (ENazT.Text = '') or (ESerN.Text = '') or (EKolT.Text = '') or (ECena.Text = '') or
     (ESrok.Text = '') then
   begin
      application.MessageBox('Введены не все атрибуты товара!','Предупреждение',MB_ICONWARNING + MB_OK);
      abort;
   end;

  if FAddTV.Caption = 'Добавление товара' then
   begin

         try

         if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

         FGlav.ibt.StartTransaction;

         FGlav.ibs.Close;
         FGlav.ibs.SQL.Clear;
         FGlav.ibs.SQL.Add('insert into tovar (kod_tovara, naz_tovar, cena_tovara,');
         FGlav.ibs.SQL.Add(' serial_num, kol_tovara, kod_vidtovar, garantiya)');
         FGlav.ibs.SQL.Add('values (0, :naz_t, :cena, :ser, :kol_t, :kod_v, :gar)');
         FGlav.ibs.ParamByName('naz_t').AsString := ENazT.Text;
         FGlav.ibs.ParamByName('cena').AsFloat := StrToFloat(ECena.Text);
         FGlav.ibs.ParamByName('ser').AsString := ESerN.Text;
         FGlav.ibs.ParamByName('kol_t').AsInteger := StrToInt(EKolT.Text);
         FGlav.ibs.ParamByName('kod_v').AsInteger := UGlav.vidtovar;
         FGlav.ibs.ParamByName('gar').AsInteger := StrToInt(ESrok.Text);
         FGlav.ibs.ExecQuery;

         FGlav.LBTovarFull(UGlav.vidtovar);

         FGlav.ibt.Commit;

         except

          FGlav.ibt.Rollback;
         raise;

        end;

   end
    else
     begin

        try

         if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

         FGlav.ibt.StartTransaction;

         FGlav.ibs.Close;
         FGlav.ibs.SQL.Clear;
         FGlav.ibs.SQL.Add('update tovar set naz_tovar = :naz_t, cena_tovara = :cena,');
         FGlav.ibs.SQL.Add(' serial_num = :ser, kol_tovara = :kol_t, garantiya = :gar');
         FGlav.ibs.SQL.Add('where kod_tovara = :kod_t');
         FGlav.ibs.ParamByName('naz_t').AsString := ENazT.Text;
         FGlav.ibs.ParamByName('cena').AsFloat := StrToFloat(ECena.Text);
         FGlav.ibs.ParamByName('ser').AsString := ESerN.Text;
         FGlav.ibs.ParamByName('kol_t').AsInteger := StrToInt(EKolT.Text);
         FGlav.ibs.ParamByName('kod_t').AsInteger := UGlav.kodtovara;
         FGlav.ibs.ParamByName('gar').AsInteger := StrToInt(ESrok.Text);
         FGlav.ibs.ExecQuery;

         FGlav.LBTovarFull(UGlav.vidtovar);

         FGlav.ibt.Commit;

         except

          FGlav.ibt.Rollback;
         raise;

        end;

     end;

    FAddTV.Close; 

end;

procedure TFAddTV.ECenaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',',']) then
    begin
      application.MessageBox('В поле должны заносится только числа!','Ошибка ввода',MB_ICONERROR);
      Key := #0;
    end;
end;

procedure TFAddTV.EKolTKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9']) then
    begin
      application.MessageBox('В поле должны заносится только целые числа!','Ошибка ввода',MB_ICONERROR);
      Key := #0;
    end;
end;

procedure TFAddTV.ESrokKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9']) then
    begin
      application.MessageBox('В поле должны заносится только целые числа!','Ошибка ввода',MB_ICONERROR);
      Key := #0;
    end;
end;

end.
