{====================================Modul baza====================================
U njemu se nalaze procedure, funkcije i varijeble vezane za bazu. Tu se dakle nalazi
cijela "logika" baze, nacin ucitavanja iz sekvencijalnih datoteka, sortiranja,
pretrazivanja i sl.
===================================================================================}
unit baza;

interface

uses
  forms,sysutils,variants;

type
  TTelefon=class //podaci za jedan telefonski broj
  private
    fBroj:string;
    fOpis:string;
    function GetCistiBr:string;
  published
    property CistiBr:string read GetCistiBr;
    property Broj:string read fBroj write fBroj;
    property Opis:string read fOpis write fOpis;
  end;

  TMsn=class //kolekcija telefona koji predstavljaju msn
    Telefon:array of TTelefon;
    function GetMsn(s:string):string;
  public
    property Msn[broj:string]:string read GetMsn;
    procedure ObrisiTelefon(koji:integer);
    procedure DodajTelefon;
    constructor Create;
    destructor Destroy;
  end;

  TContact=class //podaci za jedan kontakt
    Telefon:array of TTelefon;
  private
    fIme:String;
    fPrezime:string;
    fUlica:String;
    fGrad:string;
    fDrzava:string;
    fEmail:string;
    fNick:string;
    fTvrtka:string;
    function GetPrikaz:string;
  public
    procedure ObrisiTelefon(koji:integer);
    function Nadji(s:string):boolean;
    procedure DodajTelefon;
    property Ime:string read fIme write fime;
    property Prezime:string read fPrezime write fPrezime;
    property Ulica:string read fUlica write fUlica;
    property Grad:string read fGrad write fGrad;
    property Drzava:string read fDrzava write fDrzava;
    property Email:string read fEmail write fEmail;
    property Nick:string read fNick write fNick;
    property Tvrtka:string read fTvrtka write fTvrtka;
    property Prikaz:string read GetPrikaz;
  end;

  TCall=class //podaci za jedan poziv
  private
    fTel:string;
    fVrijeme:TDateTime;
    function GetOsoba:string;
    function GetVrijeme:string;
  public
    constructor Create;
    property Tel:string read fTel write fTel;
    property Vrijeme:string read GetVrijeme;
    property Osoba:string read GetOsoba;
  end;

  TCalls=class //kolekcija poziva
    Call:array of TCall;
  public
    procedure Spremi;
    procedure ObrisiPoziv(koji:integer);
    procedure DodajCall;
    constructor Create;
    destructor Destroy;
  end;

  TContacts=class //kolekcija kontakata
    Contact:array of TContact;
  public
    procedure Spremi;
    procedure SortNick;
    procedure SortIme;
    procedure SortPrezim;
    function NadjiTelefon(s:string):integer;
    procedure ObrisiContact(koji:integer);
    constructor Create;
    destructor Destroy;
    procedure DodajContact;
  end;

var
  Contacts:TContacts; //varijabla koja predstavlja kolekciju kontakte
  Calls:TCalls; //varijabla koja predstavlja kolekciju poziva
  Msns:TMsn; //varijabla koja predstavlja kolekciju msn-a
  vrsta:TFormatSettings;

implementation

{funkcija GetCistiBr
vraca telefonski broj formatiran bez znakova osim znamenki}
function TTelefon.GetCistiBr:string;
var
  i:integer;
begin
  result:='';
  for i:=1 to length(fBroj) do
  if fBroj[i]='+' then result:=result+'00'
  else if fbroj[i] in ['0'..'9'] then result:=result + fbroj[i];
end;

{funkcija GetMsn
vraca opis telefona za odgovarajuci msn "s" iz kolekcije msn-a}
function TMsn.GetMsn(s:string):string;
var
  i:integer;
begin
  result:='';
  for i:=0 to high(telefon) do
  if Telefon[i].Broj=s then
  begin
    result:=Telefon[i].Opis;
    break;
  end;
end;

{destructor Destroy
sprema kolekciju msn-a u datoteku "msn.idb" i zatvara je te oslobajda memoriju"}
destructor TMsn.Destroy;
var
  d:text;
  i:integer;
begin
  assign(d,extractfilepath(application.exename) + 'msn.idb');
  rewrite(d);
  for i:=0 to high(msns.telefon) do writeln(d,msns.telefon[i].Broj,'<>',msns.telefon[i].opis);
  close(d);
  inherited Destroy;
end;

{konstruktor Create
kreira tj. ucitava iz datoteke "msn.idb" kolekciju msn-a}
constructor TMsn.Create;
var
  d:text;
  s:string;
begin
  inherited Create;
  assign(d,extractfilepath(application.exename) + 'msn.idb');
  reset(d);
  while not eof(d) do
  begin
    readln(d,s);
    DodajTelefon;
    with Telefon[high(telefon)] do
    begin
      Broj:=copy(s,1,pos('<>',s)-1);
      Opis:=copy(s,pos('<>',s)+2,length(s)-pos('<>',s)-1);
    end;
  end;
  close(d);
end;

{procedura ObrisiTelefon
brise telefon iz kolekcije msn-a}
procedure TMsn.ObrisiTelefon(koji:integer);
var
  i:integer;
begin
  for i:=koji to high(Telefon)-1 do Telefon[i]:=Telefon[i+1];
  setlength(Telefon,high(telefon));
end;

{procedura DodajTelefon
dodaje telefon kolekciji msn-a}
procedure TMsn.DodajTelefon;
begin
  setlength(Telefon,length(telefon)+1);
  Telefon[high(Telefon)]:=TTelefon.Create;
end;

{funkcija Nadji
vraca true ako vrijednostima polja kontakta postoji podstring "s"}
function TContact.Nadji(s:string):boolean;
begin
  result:=false;
  if pos(AnsiUpperCase(s),AnsiUpperCase(nick))<>0 then result:=true
  else if pos(AnsiUpperCase(s),AnsiUpperCase(prezime))<>0 then result:=true
  else if pos(AnsiUpperCase(s),AnsiUpperCase(ime))<>0 then result:=true
  else if pos(AnsiUpperCase(s),AnsiUpperCase(tvrtka))<>0 then result:=true;
end;

{procedura Zamjena
vrsi zamjenu izmedju "prvi" i "drugi" ako je "dali" jednako true}
procedure Zamjena(dali:boolean;var prvi,drugi:TContact);
var
  privremeni:TContact;
begin
  if dali then
  begin
    privremeni:=prvi;
    prvi:=drugi;
    drugi:=privremeni;
  end;
end;

{funkcija KojiChar
vraca redni broj slova s hrvatskom abecedom}
function KojiChar(s:char):integer;
begin
  case s of
    'È','è':result:=2;
    'Æ','æ':result:=3;
    'Ð','ð':result:=5;
    'Š','š':result:=7;
    'Ž','ž':result:=9;
    'A'..'C','a'..'c':result:=1;
    'D','d':result:=4;
    'E'..'S','e'..'s':result:=6;
    'T'..'Z','t'..'z':result:=8;
    else result:=10;
  end;
end;

{funkcija VeciString
vraca true ako je po abecedi prvi veci od drugog, a false
ako su jednaki ili je manji}
function VeciString(s1,s2:string):boolean;
var
  d,i,b1,b2:integer;
begin
  s1:=ansiuppercase(s1);
  s2:=ansiuppercase(s2);
  if s1<>s2 then
  if s2='' then result:=true
  else if s1='' then result:=false
  else
  begin
    if length(s1)>length(s2) then d:=length(s1)
    else d:=length(s2);
    i:=1;
    while (s1[i]=s2[i]) or (i=d) do i:=i+1;
    b1:=kojichar(s1[i]);
    b2:=kojichar(s2[i]);
    if b1<>b2 then result:=b1>b2
    else
    if b1 in [2,3,5,7,9] then result:=false
    else result:=upcase(s1[i])>upcase(s2[i]);
  end else result:=false;
end;

{procedura SortPrezim
sortira kolekciju kontakata po imenu za prikazivanje, zatim prezimenu, te imenu}
procedure TContacts.SortNick;
var
  i,j:integer;
begin
  for i:=0 to high(contact)-1 do
  for j:=i+1 to high(contact) do
  if contact[i].nick<>contact[j].nick then zamjena(VeciString(contact[i].nick,contact[j].nick),contact[i],contact[j])
  else if contact[i].Prezime<>contact[j].Prezime then zamjena(vecistring(contact[i].Prezime,contact[j].Prezime),contact[i],contact[j])
  else if contact[i].ime<>contact[j].ime then zamjena(vecistring(contact[i].ime,contact[j].ime),contact[i],contact[j]);
end;

{procedura SortIme
sortira kolekciju kontakata po imenu, a zatim po prezimenu}
procedure TContacts.SortIme;
var
  i,j:integer;
begin
  for i:=0 to high(contact)-1 do
  for j:=i+1 to high(contact) do
  if contact[i].ime<>contact[j].ime then zamjena(VeciString(contact[i].ime,contact[j].ime),contact[i],contact[j])
  else if contact[i].Prezime<>contact[j].Prezime then zamjena(vecistring(contact[i].Prezime,contact[j].Prezime),contact[i],contact[j]);
end;

{procedura SortPrezime
sortira kolekciju kontakata po prezimenu, a zatim po imenu}
procedure TContacts.SortPrezim;
var
  i,j:integer;
begin
  for i:=0 to high(contact)-1 do
  for j:=i+1 to high(contact) do
  if contact[i].Prezime<>contact[j].Prezime then zamjena(VeciString(contact[i].Prezime,contact[j].Prezime),contact[i],contact[j])
  else if contact[i].ime<>contact[j].ime then zamjena(vecistring(contact[i].ime,contact[j].ime),contact[i],contact[j]);
end;

{funkcija NadjiTelefon
vraca redni broj kontakta u kolekciji koji ima telefon "s"}
function TContacts.NadjiTelefon(s:string):integer;
var
  i,j:integer;
begin
  result:=-1;
  if s<>'' then
  for i:=0 to high(contact) do
  for j:=0 to high(contact[i].telefon) do
  if Contact[i].Telefon[j].CistiBr=s then result:=i;
end;

{procedura ObrisiContact
brise kontakt iz kolekcije kontakata}
procedure TContacts.ObrisiContact;
var
  i:integer;
begin
  for i:=koji to high(contact)-1 do contact[i]:=contact[i+1];
  setlength(contact,high(contact));
end;

{procedura ObrisiPoziv
brise poziv iz kolekcije poziva}
procedure TCalls.ObrisiPoziv;
var
  i:integer;
begin
  for i:=koji to high(call)-1 do call[i]:=call[i+1];
  setlength(call,high(call));
end;

{procedura DodajContact
dodaje novi kontakt u kolekciju kantakata}
procedure TContacts.DodajContact;
begin
  setlength(contact,length(contact)+1);
  contact[high(contact)]:=TContact.Create;
end;

{procedura ObirsiTelefon
brise telefon kontaktu rednog broja "koji"}
procedure TContact.ObrisiTelefon(koji:integer);
var
  i:integer;
begin
  for i:=koji to high(Telefon)-1 do Telefon[i]:=Telefon[i+1];
  setlength(Telefon,high(telefon));
end;

{procedura DodajTelefon
dodaje kontaktu novi telefon}
procedure TContact.DodajTelefon;
begin
  setlength(Telefon,length(telefon)+1);
  Telefon[high(Telefon)]:=TTelefon.Create;
end;

{procedura Spremi
sprema kontakte u datoteku "contacts.idb" i zatvara datoteku}
procedure TContacts.Spremi;
var
  i,j:integer;
  d:text;
begin
  assign(d,extractfilepath(application.exename) + 'contacts.idb');
  rewrite(d);
  for i:=0 to high(contact) do
  begin
    write(d,contact[i].nick,'<>',contact[i].tvrtka,'<>',contact[i].prezime,'<>',contact[i].ime,'<>',
    contact[i].ulica,'<>',contact[i].grad,'<>',contact[i].drzava,'<>',contact[i].email,'<>');
    for j:=0 to high(contact[i].telefon) do write(d,contact[i].telefon[j].fBroj,'<t>',contact[i].telefon[j].fopis,'<t>');
    writeln(d);
  end;
  close(d);
end;

{destructor Destroy
poziva proceduru spremi i oslobadja memeoriju}
destructor TContacts.Destroy;
begin
  spremi;
  inherited Destroy;
end;

{konstruktor Create
kreira kontakre tj. ucitava ih iz datoteke "contacts.idb"}
constructor TContacts.Create;
var
  d:text;
  i,j:integer;
  s:string;
begin
  inherited Create;
  assign(d,extractfilepath(application.exename) + 'contacts.idb');
  reset(d);
  msns:=TMsn.Create;
  calls:=TCalls.Create;
  i:=0;
  while not eof(d) do
  begin
    readln(d,s);
    DodajContact;
    contact[i].Nick:=copy(s,1,pos('<>',s)-1);
    delete(s,1,pos('<>',s)+1);
    contact[i].Tvrtka:=copy(s,1,pos('<>',s)-1);
    delete(s,1,pos('<>',s)+1);
    contact[i].Prezime:=copy(s,1,pos('<>',s)-1);
    delete(s,1,pos('<>',s)+1);
    contact[i].Ime:=copy(s,1,pos('<>',s)-1);
    delete(s,1,pos('<>',s)+1);
    contact[i].ulica:=copy(s,1,pos('<>',s)-1);
    delete(s,1,pos('<>',s)+1);
    contact[i].Grad:=copy(s,1,pos('<>',s)-1);
    delete(s,1,pos('<>',s)+1);
    contact[i].Drzava:=copy(s,1,pos('<>',s)-1);
    delete(s,1,pos('<>',s)+1);
    contact[i].email:=copy(s,1,pos('<>',s)-1);
    delete(s,1,pos('<>',s)+1);
    j:=0;
    while pos('<t>',s)<>0 do
    begin
      contact[i].DodajTelefon;
      contact[i].Telefon[j].fBroj:=copy(s,1,pos('<t>',s)-1);
      delete(s,1,pos('<t>',s)+2);
      contact[i].Telefon[j].fOpis:=copy(s,1,pos('<t>',s)-1);
      delete(s,1,pos('<t>',s)+2);
      j:=j+1;
    end;
    i:=i+1;
  end;
  close(d);
end;

{funkcija GetVrijeme
vraca formatirani string vremena poziva}
function TCall.GetVrijeme:string;
begin
  result:=FormatDateTime('dd.mm.yyyy. hh:nn:ss',fVrijeme);
end;

{procedura DodajCall
dodaje poziv u bazu}
procedure TCalls.DodajCall;
begin
  setlength(Call,length(call)+1);
  Call[high(call)]:=TCall.Create;
end;

{procedura Spremi
sprema pozive u datoteku "calls.idb" i zatvara datoteku}
procedure TCalls.Spremi;
var
  d:text;
  i:integer;
begin
  assign(d,extractfilepath(application.exename) + 'calls.idb');
  rewrite(d);
  for i:=0 to high(call) do writeln(d,Call[i].fTel,'<>',call[i].Vrijeme,'<>');
  close(d);
end;

{destructor Destroy
poziva proceduru spremi i oslobadja memoriju}
destructor TCalls.Destroy;
begin
  spremi;
  inherited Destroy;
end;

{konstruktor Create
kreira pozive tj. ucitava ih iz datoteke "calls.idb" u bazu}
constructor TCalls.Create;
var
  d:text;
  i:integer;
  s:string;
begin
  inherited Create;
  vrsta.DateSeparator:='.';
  vrsta.TimeSeparator:=':';
  vrsta.ShortDateFormat:='dd.mm.yyyy';
  vrsta.ShortTimeFormat:='hh:mm:ss';
  assign(d,extractfilepath(application.exename) + 'calls.idb');
  reset(d);
  i:=0;
  while not eof(d) do
  begin
    readln(d,s);
    DodajCall;
    Call[i].fTel:=copy(s,1,pos('<>',s)-1);
    delete(s,1,pos('<>',s)+1);
    Call[i].fVrijeme:=strtodatetime(copy(s,1,pos('<>',s)-1),vrsta);
    i:=i+1;
  end;
  close(d);
end;

{konstruktor Create
kreira novi poziv i postavlja mu vrijeme na trenutacno}
constructor TCall.Create;
begin
  inherited Create;
  fVrijeme:=Now;
end;

{funkcija GetPrikaz
vraca vrijednost koju treba prikazati za pojedini kontakt ovisno o tome
koje je polje uneseno u bazu}
function TContact.GetPrikaz:string;
begin
  if nick<>'' then result:=Nick
  else if tvrtka<>'' then result:=Tvrtka
  else if prezime<>'' then result:=prezime
  else if ime<>'' then result:=ime
  else result:='';
end;

{funckija GetOsoba
vraca string koji je prikazuje osobu vezanu za telefonski broj poziva.}
function TCall.GetOsoba:string;
var
  i,j:integer;
begin
  result:='';
  for i:=0 to high(Contacts.Contact) do
  for j:=0 to high(contacts.contact[i].telefon) do
  if contacts.contact[i].Telefon[j].Cistibr=Tel then
  begin
    result:=contacts.contact[i].Prikaz;
    if contacts.contact[i].telefon[j].opis<>'' then result:=result + '->' + contacts.contact[i].telefon[j].opis;
  end;
  if tel='' then result:='Skriven broj';
  if result='' then result:='Nepoznat broj';
end;


end.
