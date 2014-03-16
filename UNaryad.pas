unit UNaryad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, IBSQL;

type
  TFNaryad = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    CBDocum: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    MEDats: TMaskEdit;
    MEDatK: TMaskEdit;
    EOtvl: TEdit;
    CBIspol: TComboBox;
    EVidR: TEdit;
    BBOfor: TBitBtn;
    BitBtn1: TBitBtn;
    ibs2: TIBSQL;
    procedure FormCreate(Sender: TObject);
    procedure BBOforClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CBDocumZapol;
    procedure CBIspolZapol;
  public
    { Public declarations }
  end;

var
  FNaryad: TFNaryad;

implementation

{$R *.dfm}

uses UGlav;

procedure TFNaryad.CBDocumZapol;
begin

  if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

  FGlav.ibt.StartTransaction;

  ibs2.Close;
  ibs2.SQL.Clear;
  ibs2.SQL.Add('select * from docum');
  ibs2.SQL.Add('order by naz_docum');
  ibs2.ExecQuery;

  CBDocum.Items.Clear;

  with ibs2 do
   begin
    while not eof do
     begin
       CBDocum.Items.Add(FGlav.DelitP(FieldByName('naz_docum').AsString));
       next;
     end;
   end;

end;

procedure TFnaryad.CBIspolZapol;
begin

  if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

  FGlav.ibt.StartTransaction;

  ibs2.Close;
  ibs2.SQL.Clear;
  ibs2.SQL.Add('select * from sotrudniki');
  ibs2.SQL.Add('order by fio');
  ibs2.ExecQuery;

  CBIspol.Items.Clear;

  with ibs2 do
   begin
     while not eof do
      begin
        CBIspol.Items.Add(FGlav.DelitP(FieldByName('fio').AsString));
        next;
      end;
   end;

end;

procedure TFNaryad.FormCreate(Sender: TObject);
begin
 CBDocumZapol;
 CBIspolZapol;
end;

procedure TFNaryad.BBOforClick(Sender: TObject);
var
 n, m : integer;
begin
  if (CBDocum.Text = '') or (EOtvl.Text = '') or (CBIspol.Text = '') or
     (EVidR.Text = '') or (MEDats.Text = '  .  .  ') or (MEDatK.Text = '  .  .  ') then
      begin
          application.MessageBox('Введены не все атрибуты наряда!','Предупреждение',MB_ICONWARNING + MB_OK);
          abort;
      end;

         try

          if FGlav.ibt.InTransaction then FGlav.ibt.Commit;

         FGlav.ibt.StartTransaction;

         ibs2.Close;
         ibs2.SQL.Clear;
         ibs2.SQL.Add('select kod_docum from docum where naz_docum = :naz_d');
         ibs2.ParamByName('naz_d').AsString := CbDocum.Text;
         ibs2.ExecQuery;

         n := ibs2.Fields[0].AsInteger;

         if n = 0 then
          begin
            application.MessageBox('Такого документа в базе нет!','Предупреждение',MB_ICONWARNING);
            abort;
          end;

         ibs2.Close;
         ibs2.SQL.Clear;
         ibs2.SQL.Add('select kod_sotrud from sotrudniki where fio = :fio_s');
         ibs2.ParamByName('fio_s').AsString := CBIspol.Text;
         ibs2.ExecQuery;

         m := ibs2.Fields[0].AsInteger;

         if m = 0 then
          begin
            application.MessageBox('Такого сотрудника в базе нет!','Предупреждение',MB_ICONWARNING);
            abort;
          end;

         ibs2.Close;
         ibs2.SQL.Clear;
         ibs2.SQL.Add('insert into naryad (kod_naryad, kod_docum, data_nach, data_sdachi,');
         ibs2.SQL.Add(' otvet_lico, kod_sotrud, vid_roboti)');
         ibs2.SQL.Add('values (0, :kod_d, :data_n, :data_k, :otv, :kod_s, :vid_r)');
         ibs2.ParamByName('kod_d').AsInteger := n;
         ibs2.ParamByName('data_n').AsDate := StrToDate(MEDats.Text);
         ibs2.ParamByName('data_k').AsDate := StrToDate(MEDatK.Text);
         ibs2.ParamByName('otv').AsString := Eotvl.Text;
         ibs2.ParamByName('kod_s').AsInteger := m;
         ibs2.ParamByName('vid_r').AsString := EVidr.Text;
         ibs2.ExecQuery;

         FGlav.ibt.Commit;

         FNaryad.Close;

         except
          FGlav.ibt.Rollback;
          raise;
         end;

end;

procedure TFNaryad.BitBtn1Click(Sender: TObject);
begin
  FNaryad.Close;
end;

end.
