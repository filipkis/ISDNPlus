{====================================Modul opcije==================================
U njemu se nalaze procedure, funkcije i varijeble vezane za prozor opcije programa.
===================================================================================}
unit opcije;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, FrameTelefoni,baza;

type
  TfrOpcije = class(TForm)
    GroupBox1: TGroupBox;
    btDelete: TButton;
    btAdd: TButton;
    GroupBox2: TGroupBox;
    cbBalon: TCheckBox;
    cbProg: TCheckBox;
    Prihvati: TButton;
    btCancel: TButton;
    fTel: TfTelefoni;
    cbStartUp: TCheckBox;
    procedure PrihvatiClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btDeleteClick(Sender: TObject);
    procedure btAddClick(Sender: TObject);
  end;

var
  frOpcije: TfrOpcije;

implementation

uses main;
{$R *.dfm}

{procedura PrihvatiClick
izvrsva se pritiskom na gumb "Prihvati". Sprema sve promjene u opcijam
u registry te promjene u MSN-ima u bazu i zatvara prozor}
procedure TfrOpcije.PrihvatiClick(Sender: TObject);
var
  i:integer;
begin
  reg.OpenKey('Software\ISDN Plus',true);
  if cbbalon.Checked then
  begin
    reg.WriteBool('ballon',true);
    ballon:=true;
  end
  else begin
    reg.WriteBool('Ballon',false);
    ballon:=false;
  end;
  if cbprog.Checked then
  begin
    reg.WriteBool('prog',true);
    prog:=true;
  end
  else begin
    reg.WriteBool('prog',false);
    prog:=false;
  end;
  reg.CloseKey;
  reg.OpenKey('software\Microsoft\windows\currentversion\run',false);
  if cbstartup.Checked then reg.WriteString('ISDN Plus',application.ExeName)
  else if reg.ValueExists('ISDN Plus') then reg.DeleteValue('ISDN Plus');
  reg.CloseKey;
  close;
  fTel.Spremi(msns.Telefon);
  for i:=0 to high(msns.telefon) do
  if msns.Telefon[i].Broj='' then
  begin
    msns.ObrisiTelefon(i);
    ftel.ObrisiTelefon(i);
  end;
end;

{procedure btCancelClick
izvršava se pritiskom na gumb "Prekini". Vraca sve vrijednosti
opcija na prije otvaranja prozora i zatvara prozor}
procedure TfrOpcije.btCancelClick(Sender: TObject);
var
  i:integer;
begin
  close;
  ftel.vrati(msns.Telefon);
  for i:=0 to high(msns.telefon) do
  if msns.Telefon[i].Broj='' then
  begin
    msns.ObrisiTelefon(i);
    ftel.ObrisiTelefon(i);
  end;
end;

{procedure FormCreate
izvršava se prilikom kreiranja fomre. Ucitava sve vrijednosti opcija
iz registrya i MSN-ova iz baze}
procedure TfrOpcije.FormCreate(Sender: TObject);
begin
  reg.OpenKey('Software\ISDN Plus',true);
  if reg.ReadBool('ballon') then cbbalon.Checked:=true
  else cbbalon.Checked:=false;
  if reg.ReadBool('prog') then cbprog.Checked:=true
  else cbprog.Checked:=false;
  reg.CloseKey;
  reg.OpenKey('software\Microsoft\windows\currentversion\run',false);
  if reg.ValueExists('ISDN Plus') then cbStartUp.Checked:=true
  else cbStartUp.Checked:=false;
  reg.CloseKey;
  ftel.Napravi(msns.telefon);
end;

{procedure FormClose
izvrsava se prilikom slanja zahtjeva za zatvaranjem forma. Oslobadja
memoriju brisuci podatke o formi}
procedure TfrOpcije.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
end;

{procedure btDeleteClisk
izvrsava se pritiskom na gumb "Delete". Brise MSN iz liste i baze}
procedure TfrOpcije.btDeleteClick(Sender: TObject);
var
  i,x:integer;
begin
  x:=-1;
  for i:=0 to high(fTel.Tel) do
  if fTel.Tel[i].selected then x:=i;
  if x<>-1 then
  begin
    Msns.ObrisiTelefon(x);
    fTel.ObrisiTelefon(x);
    if (x>high(ftel.tel)) and (x<>0) then fTel.tel[x-1].edbroj.SetFocus;
  end;
end;

{procedure btAddClick
izvrsava se pritiskom na gumb dodaj. Dodaje prazni MSN u bazu i listu}
procedure TfrOpcije.btAddClick(Sender: TObject);
begin
  msns.DodajTelefon;
  ftel.DodajTelefon;
end;

end.
