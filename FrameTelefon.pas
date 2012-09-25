{====================================Modul FrameTelefon============================
U njemu se nalaze procedure, funkcije i varijable za Freme Telefon. U Frameu se
nalaze polja Broj i Opis koja predstavljaju broj telefona i opis istog.
===================================================================================}
unit FrameTelefon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfTelefon = class(TFrame)
    edOpis: TEdit;
    edBroj: TEdit;
    shSel: TShape;
    procedure SetSelection(s:boolean);
    function GetSelection:boolean;
    procedure FrameEnter(Sender: TObject);
    procedure FrameClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);
    property Selected:boolean read GetSelection write SetSelection;
  end;

implementation
{$R *.dfm}

{procedure SetSelection
pokazuje okvir koji oznacuje da je Frame selektiran ovisno o tome
jeli "s" true ili false.}
procedure TfTelefon.SetSelection(s:boolean);
begin
  shsel.Visible:=s;
end;

{function GetSelection
vraca vrijednost jeli vidljiv okvir koji pokazuje da je Frame selektiran
ili nije.}
function TfTelefon.GetSelection:boolean;
begin
  result:=shsel.Visible;
end;

{constructor Create
izvrsava se prlikom kreiranja svakog Frame Telefon te ga smjesta na
odgovarajuce mjesto u Frame-u Telefoni.}
constructor TfTelefon.Create(AOwner:TComponent);
begin
  inherited create(AOwner);
  if owner.ComponentCount>1 then top:=(owner.Components[owner.ComponentCount-2] as TfTelefon).top+height
  else Top:=0;
end;

{procedure FrameEnter
izvrsava se prilikom stvljanja kursora u Frame. Tada prikazuje
okvir koji oznacava da je Frame selektiran.}
procedure TfTelefon.FrameEnter(Sender: TObject);
var
  i:integer;
begin
  for i:=0 to owner.ComponentCount-1 do
  if owner.FindComponent('tel'+inttostr(i)).Name<>self.Name then
  if (owner.Components[i] as TfTelefon).Selected then (owner.Components[i] as TfTelefon).Selected:=false;
  selected:=true;
end;

{procedure FrameClick
izvrsava se pritiskom na Frame misem. Stavlja kursor za unos
na polje Broj.}
procedure TfTelefon.FrameClick(Sender: TObject);
begin
  edBroj.SetFocus;
end;

end.
