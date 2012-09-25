{====================================Modul main====================================
U njemu se nalaze procedure, funkcije i varijeble vezane za glavni prozor programa.
Tu se ujedno nalazi i objekt Isdn tipa TCapiMonitor koji služi za povezivanje s
ISDN adapterom. On reagira na pozive.
===================================================================================}
unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CpMoni, ExtCtrls, shellapi, CoolTrayIcon, Menus, registry,
  dateutils, baza, Grids, XPMan, AppEvnts, funkcije, XPMenu;

type
  TfrMain = class(TForm)
    Isdn: TCapiMonitor;
    edTko: TEdit;
    btImenik: TButton;
    btContact: TButton;
    edFind: TEdit;
    Label1: TLabel;
    Tray: TCoolTrayIcon;
    trayMenu: TPopupMenu;
    Zatvori1: TMenuItem;
    Prikai1: TMenuItem;
    btObrPoz: TButton;
    Meni: TMainMenu;
    Program1: TMenuItem;
    Zatvori2: TMenuItem;
    Smanjiutray1: TMenuItem;
    Opcije1: TMenuItem;
    Kontakit1: TMenuItem;
    Novi1: TMenuItem;
    Obrii1: TMenuItem;
    Pozivi1: TMenuItem;
    Obriipoziv1: TMenuItem;
    Obriisvepozive1: TMenuItem;
    HTImenik1: TMenuItem;
    btObrSve: TButton;
    btEdit: TButton;
    btObrisi: TButton;
    btNew: TButton;
    Shape4: TShape;
    btCopy: TButton;
    btUbaci: TMenuItem;
    lbMsn: TLabel;
    sgPozivi: TStringGrid;
    sgKontakti: TStringGrid;
    XPManifest1: TXPManifest;
    ApplicationEvents1: TApplicationEvents;
    btDisconect: TButton;
    procedure btEditClick(Sender: TObject);
    procedure IsdnIncomingCall(CallingPartyNumber,
      CalledPartyNumber: String; CipValue: Word; CipValueString: String);
    procedure FormCreate(Sender: TObject);
    procedure IsdnDisconnectInfo(aRejectCause, aDisconnectReason: Word);
    procedure btImenikClick(Sender: TObject);
    procedure edFindChange(Sender: TObject);
    procedure edFindEnter(Sender: TObject);
    procedure edFindKeyPress(Sender: TObject; var Key: Char);
    procedure btContactClick(Sender: TObject);
    procedure TrayClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Prikai1Click(Sender: TObject);
    procedure Zatvori1Click(Sender: TObject);
    procedure Zatvori2Click(Sender: TObject);
    procedure Smanjiutray1Click(Sender: TObject);
    procedure Obriisvepozive1Click(Sender: TObject);
    procedure Obriipoziv1Click(Sender: TObject);
    procedure Obrii1Click(Sender: TObject);
    procedure Novi1Click(Sender: TObject);
    procedure btCopyClick(Sender: TObject);
    procedure Opcije1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sgKontaktiKeyPress(Sender: TObject; var Key: Char);
    procedure sgKontaktiMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ApplicationEvents1ShowHint(var HintStr: String;
      var CanShow: Boolean; var HintInfo: THintInfo);
    procedure btDisconectClick(Sender: TObject);
    procedure sgKontaktiDblClick(Sender: TObject);
  public
    procedure PopuniPozive;
    procedure PopuniKontakte;
    function Kontakt(x:integer):TForm;
  end;

const
  stNepo='Nepoznat broj';
  stSkriven='Skriven broj';
var
  frMain: TfrMain;
  ballon,prog:boolean;
  reg:tregistry;
  poziv:string;

implementation

uses  kontakri, about, opcije;

{$R *.dfm}
{funkcija Kontakt
vraca formu u kojoj se ispisuju podaci kontakta s rednim brojem x u popisu
kontakata}
function TfrMain.Kontakt(x:integer):TForm;
var
  i,z:integer;
begin
  z:=-1;
  for i:=0 to screen.FormCount-1 do
  if screen.Forms[i].ClassType=TfrKontakti then
  if (screen.Forms[i] as TfrKontakti).koji=x then z:=i;
  if z<>-1 then begin
    screen.Forms[z].Show;
    result:=screen.Forms[z];
  end
  else begin
    result:=tfrKontakti.Create(x);
    result.show;
  end;
end;

{procedura PopuniKontakte
puni listu kontakata s podacim iz baze}
procedure TfrMain.PopuniKontakte;
var
  i:integer;
begin
  sgKontakti.RowCount:=length(contacts.Contact)+1;
  for i:=0 to high(contacts.contact) do
  begin
    sgKontakti.Cells[0,i+1]:=contacts.contact[i].Nick;
    sgKontakti.Cells[1,i+1]:=contacts.contact[i].Prezime;
    sgKontakti.Cells[2,i+1]:=contacts.contact[i].Ime;
  end;
  contacts.Spremi;
end;

{procedura PopuniPoziva
puni listu poziva s podacima iz baze}
procedure TfrMain.PopuniPozive;
var
  i:integer;
begin
  sgPozivi.RowCount:=length(calls.Call);
  for i:=high(calls.call) downto 0 do
  begin
    sgPozivi.Cells[0,sgpozivi.RowCount-i-1]:=calls.call[i].Tel;
    sgPozivi.Cells[1,sgpozivi.RowCount-i-1]:=calls.call[i].Osoba;
    sgPozivi.Cells[2,sgpozivi.RowCount-i-1]:=calls.call[i].Vrijeme;
  end;
end;

{procedura btEditClick
U slucaju da je broj selektiranog poziva vezan za neki kontakt
poziva funkciju kontakt i predaje joj parametar x koji oznacava
redni broj kontakta u popisu. U slucaju da nema kontakta s tim
brojem kreira novi i njemu predaje broj}
procedure TfrMain.btEditClick(Sender: TObject);
var
  x:integer;
begin
  if calls.call[sgpozivi.rowcount-sgPozivi.Row-1].Tel<>'' then
  begin
    x:=contacts.NadjiTelefon(calls.call[sgpozivi.rowcount-sgPozivi.Row-1].Tel);
    if x<>-1 then Kontakt(x)
    else begin
      contacts.DodajContact;
      contacts.Contact[high(contacts.contact)].DodajTelefon;
      contacts.Contact[high(contacts.contact)].
      Telefon[high(contacts.Contact[high(contacts.contact)].Telefon)].Broj:=
      calls.Call[sgpozivi.rowcount-sgPozivi.Row-1].Tel;
      Kontakt(high(contacts.contact));
    end;
  end;
end;

{procedura IsdnIncomingCall
reagira na dolazni poziv od ISDN adaptera postavalja ulazne
varijable na odgovarajuce vrijednosti. Nakon toga dodaje poziv
u listu poziva i obavjestava korisnik o pozivu na odgovarajuci
naci}
procedure TfrMain.IsdnIncomingCall(CallingPartyNumber,
  CalledPartyNumber: String; CipValue: Word; CipValueString: String);
var temp:string;
begin
  temp:=calledpartynumber;
  if calledpartynumber[1]='1' then delete(temp,1,1);
  lbmsn.Caption:=msns.msn[temp];
  calls.DodajCall;
  calls.Call[high(calls.call)].Tel:=callingpartynumber;
  calls.Spremi;
  if callingpartynumber='' then edTko.Text:=stSkriven
  else edtko.text:=calls.call[high(calls.call)].Osoba;
  poziv:=edTko.text;
  popunipozive;
  if ballon then tray.ShowBalloonHint('Dolazni poziv od:',poziv,bitInfo,60);
  if prog then
  begin
    tray.ShowMainForm;
    application.BringToFront;
    SetForegroundWindow(frmain.Handle);
  end;
  btDisconect.Enabled:=true;
end;

{procedura FormCreate
izvrsava se pokretanjem programa, te pritom cita vrijednosti
iz registrya i nemjesta program prema njima. Nakon toga
puni popise poziva i kontakata}
procedure TfrMain.FormCreate(Sender: TObject);
begin
  isdn.WaitForCall(1,60);
  reg:=tregistry.create;
  reg.rootkey:=HKEY_LOCAL_MACHINE;
  if reg.OpenKey('\Software\ISDN Plus',true) then
  begin
    if reg.ValueExists('ballon') then ballon:=reg.Readbool('ballon')
    else begin
      reg.WriteBool('ballon',true);
      ballon:=true;
    end;
    if reg.ValueExists('prog') then prog:=reg.Readbool('prog')
    else begin
      reg.WriteBool('prog',true);
      prog:=true;
    end;
    if reg.ValueExists('MainTop') then Top:=reg.ReadInteger('MainTop')
    else reg.WriteInteger('MainTop',Top);
    if reg.ValueExists('MainLeft') then Left:=Reg.ReadInteger('MainLeft')
    else reg.WriteInteger('MainLeft',Left);
    if reg.ValueExists('Mainheight') then Height:=reg.ReadInteger('MainHeight')
    else reg.WriteInteger('MainHeight',Height);
    if reg.ValueExists('MainKon') then
    begin
      if reg.ReadBool('MainKon') then btContact.Click;
    end else reg.WriteBool('MainKon',false);
    reg.CloseKey;
  end;
  contacts:=tcontacts.Create;
  sgKontakti.Cells[0,0]:='Ime za prikazivanje:';
  sgKontakti.Cells[1,0]:='Prezime:';
  sgKontakti.Cells[2,0]:='Ime:';
  PopuniPozive;
  PopuniKontakte;
end;

{procedura IsdnDisconnectInfo
izvrsava se prilikom prekida poziva. Brise informcije korisniku
o dolaznom pozivu}
procedure TfrMain.IsdnDisconnectInfo(aRejectCause, aDisconnectReason: Word);
begin
  Tray.HideBallonHint;
  edtko.text:='';
  lbMsn.Caption:='';
  btDisconect.Enabled:=false;
  poziv:='';
end;

{procedura btImenikClick
izvršava se pritiskom na gumb Online Imenik i salje proceduri
imenik vrijednost telefona u trenutacno selektiranom pozivu iz
liste poziva}
procedure TfrMain.btImenikClick(Sender: TObject);
begin
  imenik(calls.call[sgpozivi.rowcount-sgPozivi.Row-1].Tel);
end;

{procedure edFindChange
izvršava se prilikom promjene vrijednosti u polju Trazi. Trazi
u bazi korisnika s vrijednostima unesenim u tom polju}
procedure TfrMain.edFindChange(Sender: TObject);
var
  i:integer;
begin
  if edfind.Text<>'' then
  for i:=0 to high(contacts.contact) do
  if contacts.Contact[i].Nadji(edFind.Text) then
  begin
    sgkontakti.Row:=i+1;
    break;
  end;
end;

{procedure edFindEnter
izvrsava se dolaskom u polje Trazi. Poziva proceduru koja se
izvrsava prilikom promjene vrijednosti polja Trazi}
procedure TfrMain.edFindEnter(Sender: TObject);
begin
  edfind.OnChange(frmain);
end;

{procedure edFindKeyPress
izvrsava se priliko pritiskanja bilo koje tipke u polju dok se
kursor nalazi u polju trazi. Ako je ta tipka Enter onda poziva
funkciju kontakt s vrijednosti selektirnog reda u popisu kontakta}
procedure TfrMain.edFindKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  begin
    kontakt(sgKontakti.Row-1);
  end;
end;


{procedure btContactClick
prikazuje/skriva desni dio forme gdje se nalazi popis kontakata}
procedure TfrMain.btContactClick(Sender: TObject);
begin
  if btcontact.Caption='Kontakti ->' then
  begin
    btcontact.Caption:='Kontakti <-';
    btcopy.show;
    meni.items[2].Visible:=true;
    frmain.Constraints.MinWidth:=793;
    frmain.Constraints.MaxWidth:=793;
  end
  else begin
    btcontact.Caption:='Kontakti ->';
    btcopy.Hide;
    frmain.Constraints.MinWidth:=401;
    frmain.Constraints.MaxWidth:=401;
    meni.Items[2].Visible:=false;
  end;
end;

{procedure TrayClick
izvršava se pritiskom na ikonu u System Tray-u i prikazuje glavnu
formu}
procedure TfrMain.TrayClick(Sender: TObject);
begin
  tray.ShowMainForm;
end;

{procedure FormClose
izvrsava se prilikom zahtjeva za zatvaranje glevne forme. "Salje"
program u System Tray}
procedure TfrMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tray.HideMainForm;
  action:=canone;
end;

{procedure Prikai1Click
izvrsava se pritiskom na Prikazi u izborniku System Tray ikone
programa. Prikazuje program}
procedure TfrMain.Prikai1Click(Sender: TObject);
begin
  tray.ShowMainForm;
end;

{procedure Zatvori1Click
izvrsava se pritiskom na Zatvori u izborniku System Tray ikone
programa. Zatvara program}
procedure TfrMain.Zatvori1Click(Sender: TObject);
begin
  application.Terminate;
end;

{procedure Zatvori2Click
izvrsava se pritiskom na Zatvori u izborniku Program glavnig Meni-a.
Zatvara program}
procedure TfrMain.Zatvori2Click(Sender: TObject);
begin
  application.Terminate;
end;

{procedure Smanjiutray1Click
izvrsava se pritiskom na Smanji u Tray u izborniku Progrma glavnog
Meni-a. "Spusta" program u System Tray}
procedure TfrMain.Smanjiutray1Click(Sender: TObject);
begin
  tray.HideMainForm;
end;

{procedure Obriisvepozive1Click
izvrsava se pritiskom na Obrisi sve pozive u izborniku Pozivi glavnog
Meni-a. Brise sve pozive iz liste poziva.}
procedure TfrMain.Obriisvepozive1Click(Sender: TObject);
var
  i:integer;
begin
  if messagedlg('Jeste li sigurni da želite obrisati sve pozive?',mtwarning,[mbyes,mbno],0)=mryes then
  begin
    for i:=0 to high(calls.call) do calls.ObrisiPoziv(i);
    calls.Spremi;
    PopuniPozive;
  end;
end;

{procedure Obriipoziv1Click
izvrsava se pritiskom na Obrisi poziv u izborniku Pozivi glavnog Meni-a.
Brise selektirani poziv u listi poziva iz baze.}
procedure TfrMain.Obriipoziv1Click(Sender: TObject);
begin
  if messagedlg('Jeste li sigurni da želite obrisati poziv?',mtwarning,[mbyes,mbno],0)=mryes then
  begin
    Calls.ObrisiPoziv(sgpozivi.rowcount-sgPozivi.Row-1);
    calls.Spremi;
    PopuniPozive;
  end;
end;

{procedure Obrii1Click
izvrsava se pritiskom na Obrisi iz izbornika Kontakti glavnog Meni-a.
Brisi selektirani kontakt u listi kontakata iz baze.}
procedure TfrMain.Obrii1Click(Sender: TObject);
begin
  if messagedlg('Jeste li sigurni da želite obrisati osobu iz adresara?',mtwarning,[mbyes,mbno],0)=mryes then
  begin
    baza.Contacts.ObrisiContact(sgKontakti.Row-1);
    Contacts.Spremi;
    PopuniPozive;
    PopuniKontakte;
  end;
end;

{procedure Novi1Click
izvrsava se pritiskom na Novi u izborniku Kontakti glavnog Meni-a.
Dodaje novi kontakt u bazu i otvara prozor tog kontakta spreman za
unos njegovih podataka.}
procedure TfrMain.Novi1Click(Sender: TObject);
begin
  contacts.DodajContact;
  with TfrKontakti.Create(high(contacts.contact)) do
  begin
    prom:=true;
    show;
    novi:=true;
  end;
end;

{procedure btCopyClick
izvrsava se pritiskom na gumb Ubaci telefon kontaktu. Prebacuje
trenutno selektirani telefon u listi poziva ako je nepoznat
selektiranom kontaktu u listi kontakata.}
procedure TfrMain.btCopyClick(Sender: TObject);
var
  x:integer;
begin
  if calls.call[sgpozivi.rowcount-sgPozivi.Row-1].Tel<>'' then
  begin
    x:=contacts.NadjiTelefon(calls.call[sgpozivi.rowcount-sgPozivi.Row-1].Tel);
    if x=-1 then
    begin
      contacts.Contact[sgKontakti.Row-1].DodajTelefon;
      contacts.Contact[sgKontakti.Row-1].Telefon[high(contacts.contact[sgKontakti.Row-1].telefon)].Broj:=calls.call[sgpozivi.rowcount-sgPozivi.Row-1].Tel;
      PopuniPozive;
      with kontakt(sgKontakti.Row-1) as TfrKontakti do
      begin
        frTelefoni.ScrollInView(frTelefoni.tel[high(frtelefoni.tel)]);
        frtelefoni.Tel[high(frtelefoni.tel)].edopis.SetFocus;
      end;
    end;
  end;
end;

{procedure Opcije1Click
izvrsava se pritiskom na Opcije u izborniku Program glavnog Meni-a.
Prikazuje prozor s opcijama.}
procedure TfrMain.Opcije1Click(Sender: TObject);
begin
  application.CreateForm(tfropcije,fropcije);
  fropcije.ShowModal;
end;

{procedure FormDestroy
izvrsava se prilikom gasenja programa. Sprema potrebne podatke o programu
u Registry.}
procedure TfrMain.FormDestroy(Sender: TObject);
begin
  msns.Destroy;
  if reg.OpenKey('\Software\ISDN Plus',true) then
  begin
    reg.WriteInteger('MainTop',top);
    reg.WriteInteger('MainLeft',left);
    reg.WriteInteger('MainHeight',height);
    if btContact.Caption='Kontakti <-' then reg.WriteBool('MainKon',true)
    else reg.WriteBool('MainKon',false);
    reg.CloseKey;
  end;
end;

{procedure sgKontaktiKeyPress
izvrsava se pritiskom na bilo koju tipku tipkovnice dok je popis
kontakta selektiran. Ako je pritisnut enter prikazuje prozor kontakta
s podacima selektiranog kontakta}
procedure TfrMain.sgKontaktiKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then kontakt(sgKontakti.Row-1);
end;

{procedure sgKontaktiMouseDown
izvrsava se pritiskom na popis kontakata gumbom misa. Ako je gumb lijevi
i pritisnut je prvi red tada ovisno o kojoj je koloni stitnuto program
sortira popis.}
procedure TfrMain.sgKontaktiMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if button<>mbLeft then abort
  else if y<=18 then
  begin
    case x of
      1..122:contacts.SortNick;
      123..244:contacts.SortPrezim;
      245..366:contacts.SortIme;
    end;
    PopuniKontakte;
  end;
end;

{procedure ApplicationEvents1ShowHint
izvrsava se prilikom pokazivanja Hinta za popis kontakata.
Prikazuje detalje o selektiranom kontaktu.}
procedure TfrMain.ApplicationEvents1ShowHint(var HintStr: String;
  var CanShow: Boolean; var HintInfo: THintInfo);
var
  i:integer;
begin
  hintstr:='';
  hintinfo.ReshowTimeout:=500;
  hintinfo.HideTimeout:=0;
  if hintinfo.HintControl=sgKontakti then
  if hintinfo.CursorPos.Y>18 then
  with contacts.contact[sgkontakti.toprow + (hintinfo.cursorpos.y) div 19 -2] do
  begin
    if tvrtka<>'' then
    begin
      if hintstr<>'' then hintstr:=hintstr+#13;
      hintstr:=hintstr + 'Tvrtka: ' + tvrtka;
    end;
    if (ulica<>'') or (grad<>'') then
    begin
      if hintstr<>'' then hintstr:=hintstr+#13;
      hintstr:=hintstr + 'Adresa: ' + ulica + ', ' + grad;
    end;
    if email<>'' then
    begin
      if hintstr<>'' then hintstr:=hintstr+#13;
      hintstr:=hintstr + 'Email: ' + email;
    end;
    if length(telefon)<>0 then
    begin
      if hintstr<>'' then hintstr:=hintstr + #13;
      hintstr:=hintstr + 'Telefoni: ' + telefon[0].Broj;
      if telefon[0].Opis<>'' then hintstr:=hintstr + '->' + telefon[0].Opis;
      for i:=1 to high(telefon) do
      begin
        hintstr:=hintstr + #13 +'               ' + telefon[i].Broj;
        if telefon[i].Opis<>'' then hintstr:=hintstr + '->' + telefon[i].Opis;
      end;
    end;
  end else
  case hintinfo.CursorPos.X of
    1..122:hintstr:='Sortiraj po Imenenu za prikazivanje';
    123..244:hintstr:='Sortiraj po Prezimenu';
    245..366:hintstr:='Sortiraj po Imenu';
  end;
end;

{procedure btDisconectClick
izvrsava se pritiskom na gumb Prekini poziv. Prekida trenutno aktivan
poziv prije nego sto se itko javi na njega.}
procedure TfrMain.btDisconectClick(Sender: TObject);
begin
  Isdn.RejectCall(0);
end;

{procedure sgKontaktiDblClick
izvrsava se dvostrukim klikom na popis kontakata. Prikazuje prozor
kontakta s podacima selektrianog kontakta.}
procedure TfrMain.sgKontaktiDblClick(Sender: TObject);
begin
  kontakt(sgKontakti.Row-1);
end;

end.
