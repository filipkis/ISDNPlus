{====================================Modul funkcije================================
Sadrzi funkcije koje su nevezane za pojedine kontrole i trebaju biti dostupne
cijelom programu.
===================================================================================}
unit funkcije;

interface
uses shellapi,dialogs,windows;
    procedure imenik(str:string);

implementation

{procedura koja prima jedan parametar tipa string koji predstavlja broj telefona
i prema njemu na internetu trazi odgovarajuce podtke u imeniku Hrvatskog telekoma
ili ViP net mreze}
procedure imenik(str:string);
begin
  if (str='') or ((str[1]='0') and (str[2]='0')) then //provjera ako broj slucajno nije HT ili ViP
  messagedlg('Broj nije ispravan broj Hrvatskog Telekoma ili ViP mobilne mreže',mtwarning,[mbok],0)
  else if (str[1]='0') and (str[2]='9') and (str[3]='1') then //ako je ViP onda se odlazi na njihovu internet stranicu
    shellexecute(getdesktopwindow(),'open',pchar('http://www.vip.hr/sp/d_imenik?phn='+copy(str,4,length(str)-3)+'&formflag=true'),nil,nil,SW_SHOWDEFAULT)
  else //ako nije onda na HT-ovu
    shellexecute(getdesktopwindow(),'open',pchar('http://imenik.ht.hr/?a=find&metoda=2&lang=0&naziv=' + str + '&izbor=3&zup=0&Search=Tra%9Ei'),nil,nil,SW_SHOWDEFAULT);
end;

end.
