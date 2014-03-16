unit UVhod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFVhod = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EPolz: TEdit;
    EPasw: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FVhod: TFVhod;

implementation

{$R *.dfm}

uses UGlav;

procedure TFVhod.Button1Click(Sender: TObject);
var
 flag : boolean;
begin

  flag := false;

  if (epolz.Text = 'Admin') and (EPasw.Text = 'qwerty') then
   begin

       flag := true;
       FGlav.Visible := true;
       FGlav.BBSotrud.Visible := true;
       FGlav.BBNaryad.Visible := true;
       FGlav.BBDocum.Visible := true;
       FGlav.BBZakaz.Left := 224;
       FGlav.BBZakazchik.Left := 224;
       FGlav.BBVihod.Left := 424;
       FGlav.Show;


   end;

  if (Epolz.Text = 'Vadim') and (EPasw.Text = 'Vadim') then
   begin

       flag := true;
       FGlav.Visible := true;
       FGlav.BBSotrud.Visible := false;
       FGlav.BBNaryad.Visible := false;
       FGlav.BBDocum.Visible := true;
       FGlav.BBZakaz.Left := 224;
       FGlav.BBZakazchik.Left := 224;
       FGlav.BBVihod.Left := 424;
       FGlav.Show;


   end;

if (Epolz.Text = 'Dima') and (EPasw.Text = 'Dima') then
   begin

       flag := true;
       FGlav.Visible := true;
       FGlav.BBSotrud.Visible := true;
       FGlav.BBNaryad.Visible := false;
       FGlav.BBDocum.Visible := false;
       FGlav.BBZakaz.Left := 224;
       FGlav.BBZakazchik.Left := 224;
       FGlav.BBVihod.Left := 424;
       FGlav.Show;


   end;

  if (Epolz.Text = 'Vlad') and (EPasw.Text = 'Vlad') then
   begin

       flag := true;
       FGlav.Visible := true;
       FGlav.BBSotrud.Visible := false;
       FGlav.BBNaryad.Visible := true;
       FGlav.BBDocum.Visible := true;
       FGlav.BBZakaz.Left := 224;
       FGlav.BBZakazchik.Left := 224;
       FGlav.BBVihod.Left := 424;
       FGlav.Show;


   end;

  if not flag then
    application.MessageBox('Невозможен вход в базу!','Ошибка',MB_ICONERROR); 

end;

procedure TFVhod.Button2Click(Sender: TObject);
begin
  application.Terminate;
end;

end.
