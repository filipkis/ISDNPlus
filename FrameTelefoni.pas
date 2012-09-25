{====================================Modul FrameTelefoni===========================
U njemu se nalaze procedure i varijable vezane za prikazivanje polja Frame-a Telefon
u Frame-u Telefoni. Takodjer osim samog proikazivanja jos se nalaze i procedure koje
svaki Frame Telefon pune odgovarajucim podacima iz baze.
===================================================================================}
unit FrameTelefoni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs,baza,FrameTelefon;

type
  TfTelefoni = class(TFrame)
  private

  public
    Tel:array of TfTelefon;
    procedure Napravi(aray:array of TTelefon);
    procedure DodajTelefon;
    procedure ObrisiTelefon(koji:integer);
    procedure Spremi(a:array of TTelefon);
    procedure vrati(a:array of TTelefon);
  published

  end;

implementation

{$R *.dfm}

{procedure Vrati
vraca vrijednost polja Broj i Opis svakog Frame-a Telefon na vrijednost
iz baze}
procedure TfTelefoni.Vrati(a:array of TTelefon);
var
  i:integer;
begin
  for i:=0 to high(a) do
  begin
    tel[i].edBroj.Text:=a[i].Broj;
    tel[i].edOpis.text:=a[i].Opis;
  end;
end;

{procedure Spremi
sprema vrijednost polja Broj i Opis svakog Frame-a Telefon u bazu}
procedure TfTelefoni.Spremi(a:array of TTelefon);
var
  i:integer;
begin
  for i:=0 to high(a) do
  begin
    a[i].Broj:=tel[i].edBroj.Text;
    a[i].Opis:=tel[i].edOpis.Text;
  end;
end;

{procedure ObrisiTelefon
brise Frame Telefon rednog broja "koji"}
procedure TfTelefoni.ObrisiTelefon(koji:integer);
var
  i:integer;
begin
  for i:=koji to high(Tel)-1 do
  begin
    tel[i].edBroj.Text:=tel[i+1].edBroj.text;
    tel[i].edOpis.Text:=tel[i+1].edopis.text;
  end;
  tel[high(tel)].Free;
  setlength(tel,high(tel));
end;

{procedure DodajTelefon
dodaje novi Frame Telefon}
procedure TfTelefoni.DodajTelefon;
begin
  if high(tel)>2 then Tel[0].SetFocus;
  setlength(Tel,length(Tel)+1);
  Tel[high(tel)]:=TfTelefon.Create(self);
  with Tel[high(tel)] do
  begin
    Parent:=self;
    Name:='Tel'+inttostr(high(tel));
    SetFocus;
  end;
end;

{procedure Napravi
izvrsava se tijekom prikazivanja Frema Telefoni tj. prikazivanja
prozora Kontakt u kojem se on nalazi. Kreira potreban broj
Frame-ova za odredjeni kontakt te ih puni podacima iz baze.}
procedure TfTelefoni.Napravi;
var i:integer;
begin
  setlength(tel,high(aray)+1);
  for i:=0 to high(aray) do
  begin
    Tel[i]:=TfTelefon.Create(self);
    with Tel[i] do
    begin
      Parent:=self;
      Name:='Tel'+inttostr(i);
      edOpis.text:=aray[i].Opis;
      edBroj.text:=aray[i].Broj;
    end;
  end;
  if high(tel)<>-1 then tel[0].Selected:=true;
end;

end.
