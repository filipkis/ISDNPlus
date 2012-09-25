{====================================Program isdn==================================
Progrma sluzi za prikazivanje broja telefona dolaznog poziva te povezivenjem tog
broja s s osobom (kontaktom) u adresaru. Temelji se na ISDN-u te je za njegov rad
potreban ISDN adapter. Na adapter se povezuje preko CAPI-a.
===================================================================================}
program isdn;

uses
  Forms,
  main in 'main.pas' {frMain},
  kontakri in 'kontakri.pas' {frKontakti},
  opcije in 'opcije.pas' {frOpcije},
  baza in 'baza.pas',
  FrameTelefoni in 'FrameTelefoni.pas' {fTelefoni: TFrame},
  FrameTelefon in 'FrameTelefon.pas' {fTelefon: TFrame},
  funkcije in 'funkcije.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ISDN Plus';
  Application.CreateForm(TfrMain, frMain);
  Application.Run;
end.
