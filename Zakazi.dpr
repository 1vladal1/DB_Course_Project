program Zakazi;

uses
  Forms,
  UGlav in 'UGlav.pas' {FGlav},
  UVhod in 'UVhod.pas' {FVhod},
  UAddTV in 'UAddTV.pas' {FAddTV},
  USot in 'USot.pas' {FSot},
  UNaryad in 'UNaryad.pas' {FNaryad},
  UZakazchik in 'UZakazchik.pas' {FZakazchik},
  UAddZakaz in 'UAddZakaz.pas' {FAddZak},
  UZakazi in 'UZakazi.pas' {FZakaz},
  UDocum in 'UDocum.pas' {FDocum},
  UOtchet in 'UOtchet.pas' {FOtchet},
  UOtchetO in 'UOtchetO.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'База заказов';
  Application.CreateForm(TFVhod, FVhod);
  Application.CreateForm(TFGlav, FGlav);
  Application.CreateForm(TFOtchet, FOtchet);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
