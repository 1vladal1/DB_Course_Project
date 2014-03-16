unit UAddZakaz;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, IBSQL;

type
  TFAddZak = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    ENazOrg: TEdit;
    EKonLic: TEdit;
    Label2: TLabel;
    EAdres: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ETel: TEdit;
    Label5: TLabel;
    EFax: TEdit;
    SBAddZ: TSpeedButton;
    SBcanAdd: TSpeedButton;
    ibs2: TIBSQL;
    procedure SBcanAddClick(Sender: TObject);
    procedure SBAddZClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FAddZak: TFAddZak;

implementation

{$R *.dfm}

uses UGlav, UZakazchik;

procedure TFAddZak.SBcanAddClick(Sender: TObject);
begin
  FAddZak.Close;
end;

procedure TFAddZak.SBAddZClick(Sender: TObject);
begin

 if (ENazOrg.Text = '') or (EKonLic.Text = '') or (EAdres.Text = '') or
     (ETel.Text = '') or (EFax.Text = '') then
       begin
         application.MessageBox('Введены не все данные!','Ошибка',MB_ICONERROR);
         abort;
       end;

   try

   if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

    FGlav.ibt.StartTransaction;

    if SBAddZ.Caption = 'Добавить' then
     begin

    ibs2.Close;
    ibs2.SQL.Clear;
    ibs2.SQL.Add('insert into zakazchik (kod_zakazchik, naz_organiz, kon_lico, address, tel, fax)');
    ibs2.SQL.Add('values (0, :naz_o, :kon_l, :addre, :tel_o, :fax_o)');
    ibs2.ParamByName('naz_o').AsString := ENazOrg.Text;
    ibs2.ParamByName('kon_l').AsString := EKonLic.Text;
    ibs2.ParamByName('addre').AsString := EAdres.Text;
    ibs2.ParamByName('tel_o').AsString := ETel.Text;
    ibs2.ParamByName('fax_o').AsString := EFax.Text;
    ibs2.ExecQuery;

     end
      else
       begin
          ibs2.Close;
          ibs2.SQL.Clear;
          ibs2.SQL.Add('update zakazchik set naz_organiz = :naz_o, kon_lico = :kon_l,');
          ibs2.SQL.Add('address = :addre, tel = :tel_o, fax = :fax_o');
          ibs2.SQL.Add('where kod_zakazchik = :kod_z');
          ibs2.ParamByName('naz_o').AsString := ENazOrg.Text;
          ibs2.ParamByName('kon_l').AsString := EKonLic.Text;
          ibs2.ParamByName('addre').AsString := EAdres.Text;
          ibs2.ParamByName('tel_o').AsString := ETel.Text;
          ibs2.ParamByName('fax_o').AsString := EFax.Text;
          ibs2.ParamByName('kod_z').AsInteger := Uzakazchik.nom_zakaz;
          ibs2.ExecQuery;
       end;

    FZakazchik.SGZZapol;

    FGlav.ibt.Commit;

    FAddZak.Close;

  except
    FGlav.ibt.Rollback;
    raise;
  end;

end;

end.
