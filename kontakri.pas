{====================================Modul kontakri================================
U njemu se nalaze procedure, funkcije i varijeble vezane za prozor kontakta.
===================================================================================}
unit kontakri;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,shellapi, StdCtrls, Mask,baza, FrameTelefoni, FrameTelefon,
  ActnMan, ActnColorMaps,funkcije;

type
  TfrKontakti = class(TForm)
    btObrisi: TButton;
    btDodaj: TButton;
    btSend: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btClose: TButton;
    btSpremi: TButton;
    btVrati: TButton;
    btDelete: TButton;
    btImenik: TButton;
    edTvrtka: TEdit;
    edPrezime: TEdit;
    edIme: TEdit;
    edUlica: TEdit;
    edGrad: TEdit;
    edDrzava: TEdit;
    edEmail: TEdit;
    frTelefoni: TfTelefoni;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    cbNick: TComboBox;
    constructor Create(i:integer);
    procedure btSendClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btSpremiClick(Sender: TObject);
    procedure btVratiClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btImenikClick(Sender: TObject);
    procedure btObrisiClick(Sender: TObject);
    procedure btDodajClick(Sender: TObject);
    procedure cbNickEnter(Sender: TObject);
    procedure cbNickChange(Sender: TObject);
  public
    prom:boolean; {prom je globalna varijabla koja nam govori dali je doslo do
                  promjene podataka te samim time potrebe za spremanjem}
    koji:integer; {koji je globalna varijabla koja oznacava redni broj kontakta
                  èiji podaci se trenutaèno nalaze u formi}
    novi:boolean;
  end;

var
  frKontakti: TfrKontakti;



implementation
uses main;
{$R *.dfm}
{kreiranje forme Kontakata prima jedan prametar tipa integer
koji govori èijim podacima treba ispuniti formu}
constructor TfrKontakti.Create(i:integer);
begin
  inherited create(application);
  koji:=i;
  with contacts.Contact[koji] do
  begin
    edIme.Text:=Ime;
    edPrezime.Text:=Prezime;
    edUlica.Text:=Ulica;
    edGrad.Text:=Grad;
    edDrzava.Text:=Drzava;
    edEmail.Text:=Email;
    cbNick.Text:=Nick;
    edTvrtka.Text:=Tvrtka;
    frTelefoni.Napravi(Telefon);
    caption:=Prikaz;
  end;
  prom:=false;
end;

{procedura btSendClick
otvara novi e-mail i adresira ga na vrijednost koja se nalazi u kontroli imena "edemail"
novo pismo ce biti otvoreno u glavnom programu za citanje e-mail na korisnikovom raèunalu
npr. Outlook Express, Opera itd.}
procedure TfrKontakti.btSendClick(Sender: TObject);
begin
  if edemail.Text<>'' then
  shellexecute(getdesktopwindow(),'open',pchar('mailto:' + edemail.Text),nil,nil,SW_SHOWDEFAULT);
end;

{procedura btCloseClick
izvršava se pritiskom na kontrolu "btClose" tj. gumb "Zatvori", a ona zatvara formu}
procedure TfrKontakti.btCloseClick(Sender: TObject);
begin
  close;
end;

{procedura btSpremiClick
izvršava se pritiskom na kontrolu "btSpremi" tj. gumb "Spremi", a ona sprema
promjene napravljene u podacima o kontaktu}
procedure TfrKontakti.btSpremiClick(Sender: TObject);
begin
  prom:=false;
  novi:=false;
  with contacts.Contact[koji] do
  begin
    Ime:=edIme.Text;
    Prezime:=edPrezime.Text;
    Ulica:=edUlica.Text;
    Grad:=edGrad.Text;
    Drzava:=edDrzava.Text;
    Email:=edEmail.Text;
    Nick:=cbNick.Text;
    Tvrtka:=edTvrtka.Text;
    frTelefoni.Spremi(Telefon);
    caption:=prikaz;
  end;
  contacts.Spremi;
end;

{procedura btVratiClick
izvršava se pritiskom na kontrolu "btVrati" tj. gumb "Vrati", a ona vraca
podatke o kontaktu na stanje u kojem se nalaze u bazi}
procedure TfrKontakti.btVratiClick(Sender: TObject);
begin
  with contacts.Contact[koji] do
  begin
    edIme.Text:=Ime;
    edPrezime.Text:=Prezime;
    edUlica.Text:=Ulica;
    edGrad.Text:=Grad;
    edDrzava.Text:=Drzava;
    edEmail.Text:=Email;
    cbNick.Text:=Nick;
    edTvrtka.Text:=Tvrtka;
    frTelefoni.vrati(telefon);
    caption:=prikaz;
  end;
  prom:=false;
end;

{procedura btDeleteClick
izvršava se pritiskom na kontrolu "btDelete" tj. gumb "Briši", a ona
briše iz baze trenutaènog kontakta na formi}
procedure TfrKontakti.btDeleteClick(Sender: TObject);
begin
  if messagedlg('Jeste li sigurni da želite obrisati kontakt?',mtwarning,[mbyes,mbno],0)=mryes then
  begin
    contacts.ObrisiContact(koji);
    contacts.Spremi;
    prom:=false;
    close;
  end;
end;

{procedura FormClose
izvršava se prilikom zatvaranja forme}
procedure TfrKontakti.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // u sluèaju da je došlo do promjena podataka
  if prom then
  // provjera dali ih treba spremiti
  case messagedlg('Želite li spremiti promjene?',mtwarning,[mbyes,mbno,mbcancel],0) of
    mryes: begin
      action:=caFree;
      btspremi.Click;
    end;
    mrno: begin
      if novi then contacts.ObrisiContact(koji)
      else begin
        action:=caFree;
        btvrati.Click;
      end;
    end;
    mrcancel:action:=canone;
  end;
  if action<>canone then action:=cafree;
  frmain.PopuniPozive;
  frmain.PopuniKontakte;
end;

{procedure btImenikClick
izvrsava se pritiskom na gumb Imenik u grupi telefoni. Poziva funkciju
za prikazivanje telefonskog imenika na internetu za trenutno selektirani
telefon u grupi.}
procedure TfrKontakti.btImenikClick(Sender: TObject);
var
  i,x:integer;
begin
  x:=-1;
  for i:=0 to high(frTelefoni.Tel) do
  if frTelefoni.Tel[i].selected then x:=i;
  if x<>-1 then imenik(contacts.contact[koji].Telefon[x].CistiBr);
end;

{procedure btObrisiClick
izvrsava se pritiskom na gumb Obrisi u grupi telefoni. Brisi selektrirani
telefon u grupi iz baze.}
procedure TfrKontakti.btObrisiClick(Sender: TObject);
var
  i,x:integer;
begin
  x:=-1;
  for i:=0 to high(frTelefoni.Tel) do
  if frTelefoni.Tel[i].selected then x:=i;
  if x<>-1 then
  begin
    Contacts.Contact[koji].ObrisiTelefon(x);
    contacts.Spremi;
    frTelefoni.ObrisiTelefon(x);
    if (x>high(frtelefoni.tel)) and (x<>0) then frTelefoni.tel[x-1].edbroj.SetFocus;
  end;
end;

{procedure btDodajClick
izvrsava se pritiskom na gumb Dodaj u grupi telefoni. Dodaje novi
telefon kontaktu.}
procedure TfrKontakti.btDodajClick(Sender: TObject);
begin
  Contacts.Contact[koji].DodajTelefon;
  frTelefoni.DodajTelefon;            
end;

{procedure cbNickEnter
izvrsava postavljanjem kursora na polje Ime za prikazivanje.
Puni padajucu listu tog polja s odredjenim podacima.}
procedure TfrKontakti.cbNickEnter(Sender: TObject);
begin
  cbNick.Items.Clear;
  with cbNick do begin
    if edime.Text<>'' then AddItem(edime.Text,self);
    if edprezime.Text<>'' then AddItem(edPrezime.Text,self);
    if (edime.Text<>'') and (edprezime.Text<>'') then
    begin
      AddItem(edprezime.Text + ', ' + edIme.Text,self);
      AddItem(edime.Text + ' ' + edprezime.Text,self);
    end;
    if edTvrtka.Text<>'' then AddItem(edtvrtka.Text,self);
  end;
end;

{procedure cbNickChange
izvrsava se prilikom promjene vrijednosti bilo kojeg polja u prozoru kontakta.
Postavlja varijablu prom na true tako da program zna da su se dogodile promjene
kako bi ih mogao spremiti u valjanom trenutku.}
procedure TfrKontakti.cbNickChange(Sender: TObject);
begin
  prom:=true;
end;

end.
