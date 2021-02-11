use policlinica;



select* from utilizator;

/*afisare date personale angajat*/
drop procedure if exists AFISARE_DATE_PERSONALE;
DELIMITER //
create procedure AFISARE_DATE_PERSONALE(id_persoana int)
begin
	select utilizator.nume,utilizator.prenume,utilizator.functie,utilizator.data_angajare,utilizator.telefon,utilizator.email,utilizator.cnp,
    adresa.tara,adresa.judet,adresa.oras,adresa.strada,adresa.numar,adresa.cod_postal,angajat.salariu
    from utilizator, adresa,angajat
    where id_persoana = utilizator.id and adresa.id_adresa=utilizator.id and utilizator.id=angajat.id;
    end//
DELIMITER ;

call AFISARE_DATE_PERSONALE(4);

/*adaugare angajat*/
drop procedure if exists ADD_ANGAJAT;
DELIMITER //
create procedure ADD_ANGAJAT(tara varchar(100),judet varchar(100),oras varchar(100),strada varchar(100),numar int,cnp varchar(100),
cod_postal varchar(100),salariu int,functie varchar(100),mail varchar(100),nume varchar(100),prenume varchar(100),grad varchar(100),
competente varchar(100),post varchar(100),proc varchar(100),parola varchar(100),tel varchar(100),titlu varchar(100),tip varchar(100),nrO int,cod_parafa int)
	begin
		set @id_utilizator=NULL;
        set @id_adresa=NULL;
        set @id_angajat=NULL;
        select @id_utilizator := max(utilizator.id) from utilizator;
        select @id_angajat :=max(angajat.id) from angajat;
        select @id_adresa := max(adresa.id_adresa) from adresa;
        
        insert into utilizator(functie,email,telefon,nume,prenume,parola,CNP,data_angajare,id_adresa,id_angajat)
        values(functie,mail,tel,nume,prenume,parola,cnp,current_date(),@id_adresa,@id_angajat);
        
        insert into adresa(tara,judet,oras,strada,numar,cod_postal)
		values (tara,judet,oras,strada,numar,cod_postal);
     
		insert into angajat(concediu,salariu,nr_ore,nume,prenume)
		values (0,salariu,nrO,nume,prenume);
        
        if functie="Medic" then
			insert into medic(grad,cod_parafa,competente,titlu,post_didactic,procent,id_angajat)
            values(grad,cod_parafa,competente,titlu,post,proc,@id_angajat+1);
		end if;
        if functie="Asistent" then 
			insert into asistent(tip,grad,id_angajat)
            values(tip,grad,@id_angajat+1);
            end if;
end//
delimiter ;


call ADD_ANGAJAT("Romania","Cluj","Cluj","Campului",8,"12345636","50032",5000,"Medic","add@gmail.com","Ioan","Anca","specialist",
"inalte","Doctorand",20,"dada","07645211","Lector","Lector",10,13);
        
select* from angajat;
select* from utilizator;
select* from medic;



/*stergere angajat*/
drop procedure if exists stergereAngajat;
 DELIMITER //
    create procedure stergereAngajat(nume varchar(100),prenume varchar(100))
    begin
    set @id_stergere=null;
    select utilizator.id into @id_stergere from utilizator where nume=utilizator.nume and prenume=utilizator.prenume;
    delete from utilizator where @id_stergere=utilizator.id;
    end//
    DELIMITER ;
    
call stergereAngajat("Luncan","Ionel");
select* from utilizator;

/*cautare angajat*/
drop procedure if exists cautareAngajat;
DELIMITER //
create procedure cautareAngajat(num varchar(100),prenum varchar(100), funct varchar(100))
BEGIN
     set @index1=NULL;
     select id into @index1 from utilizator where nume=num and prenume=prenum and functie=funct;
    
     select utilizator.nume,utilizator.prenume,utilizator.functie,utilizator.email,utilizator.telefon,utilizator.cnp,
     utilizator.data_angajare,adresa.tara,adresa.judet,adresa.oras,adresa.strada,adresa.numar,adresa.cod_postal
	 from utilizator,adresa where utilizator.id=@index1 and adresa.id_adresa=utilizator.id;
END//
DELIMITER ;


call cautareAngajat("Sacaz","Mirel","Admin");
SET SQL_SAFE_UPDATES = 0;
drop procedure if exists stergerePacient;
 DELIMITER //
    create procedure stergerePacient(nume varchar(100),prenume varchar(100))
    begin
    set @id_stergere=null;
    select utilizator.id into @id_stergere from utilizator where nume=utilizator.nume and prenume=utilizator.prenume;
    delete from utilizator where @id_stergere=utilizator.id;
    delete from pacient where nume=pacient.nume and prenume=pacient.prenume;
    
    end//
    DELIMITER ;
  
call stergerePacient("Gabor","Tania");
select*from pacient;
/*adaugare pacient*/
drop procedure if exists addPacient;
DELIMITER //
create procedure addPacient(mail varchar(100),nume varchar(100),prenume varchar(100),telefon varchar(100),
cnp varchar(100),tara varchar(100),judet varchar(100),oras varchar(100),strada varchar(100), nr int,cod_postal varchar(100),
stare varchar(100),suma int, parola varchar(100),numeM varchar(20),prenumeM varchar(20),inceput time,sfarsit time,operatie int)
begin
     set @id_util=NULL;
     set @adres=NULL;
     select @id_util:=max(utilizator.id) from utilizator;
     select @adres:=max(adresa.id_adresa) from adresa;

     insert into adresa(tara,judet,oras,strada,numar,cod_postal)
     values (tara,judet,oras,strada,nr,cod_postal);
     
     insert into utilizator (functie,email,telefon,nume,prenume,parola,CNP)
     values ("Pacient",mail,telefon,nume,prenume,parola,cnp);
      insert into istoricPacient(nume,prenume,stare,pret,inceput,sfarsit)
      values(nume,prenume,stare,suma,inceput,sfarsit);
     insert into pacient (stareDeSanatate,nume,prenume,totalPlata)
     values (stare,nume,prenume,suma);
     insert into cerere(data_curenta,ora_curenta,nume_pacient,prenume_pacient,numeM,prenumeM,operatie)
     values(current_date,current_time,nume,prenume,numeM,prenumeM,operatie);
    
     end //
DELIMITER ;
call addPacient("eman@sd","Emanuel","Popescu","098663122","1938232123","Romania","Brasov","Brasov","Memorandumului",90,"505200",
"buna",300,"121r423","Borcea","Adrian",'14:10','14:50',2);
select* from pacient;
select* from istoricPacient;

drop procedure if exists cautarePacient;
DELIMITER //
create procedure cautarePacient(num varchar(100),prenum varchar(100), funct varchar(100))
BEGIN
     set @index1=NULL;
     select id into @index1 from utilizator where nume=num and prenume=prenum and functie=funct;
    
     select utilizator.nume,utilizator.prenume,utilizator.functie,utilizator.email,utilizator.telefon,utilizator.cnp,
     utilizator.data_angajare,adresa.tara,adresa.judet,adresa.oras,adresa.strada,adresa.numar,adresa.cod_postal
	 from utilizator,adresa where utilizator.id=@index1 and adresa.id_adresa=utilizator.id;
END//
DELIMITER ;
call cautarePacient("Cristina","Pop","Pacient");


/*creare raport*/
drop procedure if exists creareRaport;
delimiter //
create procedure creareRaport(numePacient varchar(30),prenumePacient varchar(30),numeMedic varchar(30),prenumeMedic varchar(30),
dataConsult date,idAsistent int,idMedic int,detalii varchar(50))
begin
	insert into raportMedical(numePacient,prenumePacient,numeMedic,prenumeMedic,dataConsult,id_asistent,id_medic,detalii)
    values(numePacient,prenumePacient,numeMedic,prenumeMedic,dataConsult,idAsistent,idMedic,detalii);
    end//
delimiter ;

call creareRaport("Ana","Radulet","Anca","Grozea","2019-06-30",1,1,"entorsa");
select* from raportMedical;

/*vizualizare raport medic*/
drop procedure if exists istoricRapoarte;
DELIMITER //
    create procedure istoricRapoarte(idPacient int,idMedic int)
    begin
    set @idIstoric=null;
    set @idMedic=null;
    set @idPacient=null;
    
    select medic.id into @idMedic from medic,utilizator,angajat where utilizator.id=idMedic  and angajat.id=utilizator.id_angajat 
    and medic.id_angajat=angajat.id;
    
    select istoricPacient.id into @idIstoric from utilizator,pacient,istoricPacient where utilizator.id=idPacient and 
    utilizator.id=pacient.id_pacient and pacient.id=istoricPacient.id_pacient  limit 1;
    
    select id_pacient into @idPacient from istoricPacient where istoricPacient.id=@idIstoric and id_medic=@idMedic limit 1;
	
    select raportMedical.numePacient,raportMedical.prenumePacient,raportMedical.numeMedic,raportMedical.prenumeMedic,raportMedical.detalii 
    from utilizator,raportMedical where utilizator.id=idPacient and raportMedical.numePacient=utilizator.nume and 
    raportMedical.prenumePacient=utilizator.prenume and raportMedical.id_medic=@idMedic;
    
    end//
    DELIMITER ;

call istoricRapoarte(1,1);

/*profit per unitate*/
drop procedure if exists VizProfitUnitate;
delimiter //
create procedure VizProfitUnitate(id int )
begin
	set @pret=null;
    set @salar=null;
    select sum(pret) into @pret  from istoricPacient ;
    select sum(salariu) into @salar from angajat;
  insert into tabl_temp (pret,salariu)
  values(@pret,@salar);
    end //
    DELIMITER ;
    
call VizProfitUnitate(1);
drop procedure if exists VizualizareOrar;
delimiter //
create procedure VizualizareOrar(nume varchar(20),prenume varchar(20))
begin
	select ziua , ore from angajat where angajat.nume=nume and angajat.prenume=prenume;
   
    end//
    delimiter ;

call VizualizareOrar("Traian","Basescu");
drop procedure if exists VizualizareConcediu;
delimiter //
create procedure VizualizareConcediu(nume varchar(20),prenume varchar(20))
begin
	select concediu from angajat where angajat.nume=nume and angajat.prenume=prenume;
end//
delimiter ;

call VizualizareConcediu("Traian","Basescu");
drop procedure if exists creareRaport;
delimiter //
create procedure creareRaport(numePacient varchar(30),prenumePacient varchar(30),numeMedic varchar(30),prenumeMedic varchar(30),
dataConsult date,detalii varchar(50))
begin
	insert into raportMedical(numePacient,prenumePacient,numeMedic,prenumeMedic,dataConsult,detalii)
    values(numePacient,prenumePacient,numeMedic,prenumeMedic,dataConsult,detalii);
    
    insert into istoricRaport(dataConsult,numePacient,prenumePacient,numeMedic,prenumeMedic,detalii)
    values(dataConsult,numePacient,prenumePacient,numeMedic,prenumeMedic,detalii);
    end//
delimiter ;

call creareRaport("Ana","Radulet","Anca","Grozea","2019-06-30","entorsa");

drop procedure if exists VizProfitMedic;
delimiter //
create procedure VizProfitMedic(nume varchar(20))
begin
	set @proc = null;
    set @catArVrea = null;
    set @catPrimeste = null;
    select procent into @proc from medic where nume = medic.nume;
    select sum(pret) into @catArVrea from istoricPacient where nume = istoricPacient.numeMedic;
    select (@proc*@catArVrea/100) into @catPrimeste;
   insert into profit_med(suma)
   values(@catPrimeste);
    end//
    delimiter ;
    
call VizProfitMedic("Giurgiu");
select * from profit_med;
call VizProfitMedic("Gabor");
select * from profit_med;

drop procedure if exists emitereBon;
delimiter //
create procedure emitereBon(nume varchar(20),prenume varchar(20))
begin
	set @sumaPlata=null;
    select pacient.totalPlata into @sumaPlata from pacient where pacient.nume=nume and pacient.prenume=prenume;
	insert into bonuri(numePacient,prenumePacient,pret,dataA)
    values (nume,prenume,@sumaPlata,current_date());
	
end//
delimiter ;



drop procedure if exists programareConsult;
DELIMITER //
create procedure programareConsult(numePacient varchar(20),prenumePacient varchar(20))
BEGIN
      set @data_curCerere = NULL;
      set @timp_curCerere = NULL;
      set @id_operatie = 0;
      set @id_pacient = NULL;
      set @id_cerere=null;
      set @numeM=null;
      set @prenumeM=null;
      set @numeP=null;
      set @prenumeP=null;
      set @st=null;
      set @sf=null;
      select id into @id_cerere from cerere where cerere.nume_pacient=numePacient and cerere.prenume_pacient=prenumePacient;
      select numeM into @numeM from cerere where cerere.nume_pacient=numePacient and cerere.prenume_pacient=prenumePacient;
      select prenumeM into @prenumeM from cerere where cerere.nume_pacient=numePacient and cerere.prenume_pacient=prenumePacient;
	  select nume_pacient into @numeP from cerere where cerere.nume_pacient=numePacient and cerere.prenume_pacient=prenumePacient;
      select prenume_pacient into @prenumeP from cerere where cerere.nume_pacient=numePacient and cerere.prenume_pacient=prenumePacient;
      select current_date into @data_curCerere from cerere where id = @id_cerere;
	  select current_time into @timp_curCerere from cerere where id = @id_cerere;
	  select operatie into @id_operatie from cerere where id = @id_cerere;
	  select id_pacient into @id_pacient from cerere where id = @id_cerere;
      
      set @nume_operatie = NULL;
      set @pret_operatie = NULL;
      set @durata_operatie = NULL;
      set @id_medic = NULL;
	  select nume into @nume_operatie from servicii where id = @id_operatie;
	  select pret into @pret_operatie from servicii where id = @id_operatie;
	  select durata into @durata_operatie from servicii where id = @id_operatie;
	  select id_medic into @id_medic from servicii where id = @id_operatie;
      
      set @numePacient = NULL;
      set @prenumePacient = NULL;
	  select nume into @numePacient from pacient where id = @id_pacient;
	  select prenume into @prenumePacient from pacient where id = @id_pacient;
      
      set @id_angajat = NULL;
      select id_angajat into @id_angajat from medic where id = @id_medic;
      
      set @ziuaL = NULL;
      set @incL = NULL;
      set @sfarL = NULL;
	  select ziua into @ziuaL from orar where id_orar = @id_angajat and ziua = 'LUNI';
	  select ora_start into @incL from orar where id_orar = @id_angajat and ziua = 'LUNI';
	  select ora_final into @sfarL from orar where id_orar = @id_angajat and ziua = 'LUNI';
      
      set @ziuaMA = NULL;
      set @incMA = NULL;
      set @sfarMA = NULL;
      select ziua into @ziuaMA from orar where id_orar = @id_angajat and ziua = 'MARTI';
	  select ora_start into @incMA from orar where id_orar = @id_angajat and ziua = 'MARTI';
	  select ora_final into @sfarMA from orar where id_orar = @id_angajat and ziua = 'MARTI';
      
      set @ziuaMI=NULL;
      set @incMI=NULL;
      set @sfarMI=NULL;
      select ziua into @ziuaMI from orar where id_orar=@id_angajat and ziua='MIERCURI';
	  select ora_start into @incMI from orar where id_orar=@id_angajat and ziua='MIERCURI';
	  select ora_final into @sfarMI from orar where id_orar=@id_angajat and ziua='MIERCURI';
      
      set @ziuaJ=NULL;
      set @incJ=NULL;
      set @sfarJ=NULL;
      select ziua into @ziuaJ from orar where id_orar=@id_angajat and ziua='JOI';
	  select ora_start into @incJ from orar where id_orar=@id_angajat and ziua='JOI';
	  select ora_final into @sfarJ from orar where id_orar=@id_angajat and ziua='JOI';
      
      set @ziuaV=NULL;
      set @incV=NULL;
      set @sfarV=NULL;
      select ziua into @ziuaV from orar where id_orar=@id_angajat and ziua='VINERI';
	  select ora_start into @incV from orar where id_orar=@id_angajat and ziua='VINERI';
	  select ora_final into @sfarV from orar where id_orar=@id_angajat and ziua='VINERI';
      
      set @ziuaS=NULL;
      set @incS=NULL;
      set @sfarS=NULL;
      select ziua into @ziuaS from orar where id_orar=@id_angajat and ziua='SAMBATA';
	  select ora_start into @incS from orar where id_orar=@id_angajat and ziua='SAMBATA';
	  select ora_final into @sfarS from orar where id_orar=@id_angajat and ziua='SAMBATA';
      
      set @ziuaD=NULL;
      set @incD=NULL;
      set @sfarD=NULL;
      select ziua into @ziuaD from orar where id_orar=@id_angajat and ziua='DUMINICA';
	  select ora_start into @incD from orar where id_orar=@id_angajat and ziua='DUMINICA';
	  select ora_final into @sfarD from orar where id_orar=@id_angajat and ziua='DUMINICA';
      
      # calculez ultima aparitie a unei programari in orar
      set @idProgramare = NULL;
      select max(id) into @idProgramare from istoricPacient1 where id_medic = @id_medic;
 
      # acum imi extrag ultima programare ca sa pot sa fac o alta programare
      if @idProgramare is NULL then
      CASE dayname(addtime(@data_curCerere,"24:00:00"))
      WHEN 'Monday' THEN insert into istoricPacient1 (nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'MARTI',@incL,addtime(@incL,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'Tuesday' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'MIERCURI',@incMA,addtime(@incMA,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'Wednesday' THEN insert into istoricPacient1 (nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'JOI',@incMI,addtime(@incMI,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'Thursday' THEN insert into istoricPacient1 (nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'VINERI',@incJ,addtime(@incJ,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'Friday' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'SAMBATA',@incV,addtime(@incV,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'Saturday' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'DUMINICA',@incS,addtime(@incS,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'Sunday' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'LUNI',@incD,addtime(@incD,@durata_operatie),@id_medic,@id_pacient);
      ELSE BEGIN END;
      END CASE;
      ELSE
        SET @dataUO=NULL;
        Set @inceputUO=NULL;
        set @sfarsitUO=NULL;
	  select ziua into @dataUO from istoricPacient where id=@idProgramare;
	  select inceput into @inceputUO from istoricPacient where id=@idProgramare;
	  select sfarsit into @sfarsitUO from istoricPacient where id=@idProgramare;
      
      if addtime(@sfarsitUO,@durata_operatie)<@sfarL or addtime(@sfarsitUO,@durata_operatie)<@sfarMA or addtime(@sfarsitUO,@durata_operatie)<@sfarMI or addtime(@sfarsitUO,@durata_operatie)<@sfarJ or addtime(@sfarsitUO,@durata_operatie)<@sfarV or addtime(@sfarsitUO,@durata_operatie)<@sfarS or addtime(@sfarsitUO,@durata_operatie)<@sfarD then
       CASE @dataUO
      WHEN 'LUNI' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,@dataUO,@sfarsitUO,addtime(@sfarsitUO,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'MARTI' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,@dataUO,@sfarsitUO,addtime(@sfarsitUO,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'MIERCURI' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,@dataUO,@sfarsitUO,addtime(@sfarsitUO,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'JOI' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,@dataUO,@sfarsitUO,addtime(@sfarsitUO,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'VINERI' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,@dataUO,@sfarsitUO,addtime(@sfarsitUO,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'SAMBATA' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,@dataUO,@sfarsitUO,addtime(@sfarsitUO,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'DUMINICA' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,@dataUO,@sfarsitUO,addtime(@sfarsitUO,@durata_operatie),@id_medic,@id_pacient);
      ELSE BEGIN END;
      END CASE;
      else begin end;
	 CASE @dataUO
      WHEN 'LUNI' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'MARTI',@incMA,addtime(@incMA,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'MARTI' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'MIERCURI',@incMI,addtime(@incMI,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'MIERCURI' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'JOI',@incJ,addtime(@incJ,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'JOI' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'VINERI',@incV,addtime(@incV,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'VINERI' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'SAMBATA',@incS,addtime(@incS,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'SAMBATA' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'DUMINICA',@incD,addtime(@incD,@durata_operatie),@id_medic,@id_pacient);
      WHEN 'DUMINICA' THEN insert into istoricPacient1(nume, prenume,numeMedic,prenumeMedic, numeProcedura,pret,ziua,inceput,sfarsit,id_medic,id_pacient)
      values (@numeP, @prenumeP,@numeM,@prenumeM, @nume_operatie,@pret_operatie,'LUNI',@incL,addtime(@incL,@durata_operatie),@id_medic,@id_pacient);
	END CASE;
      end if;
      END IF;
END//
DELIMITER ;

call programareConsult("Emanuel","Popescu");
select* from istoricPacient;
select* from cerere;

call emitereBon("Luncan","Bogdan");
select* from bonuri;
select* from profit_med;

select * from tabl_profit_medic;
select* from raportMedical;
select* from istoricRaport;
select* from tabl_temp;
select* from utilizator;


select*from utilizator;
select* from angajat;
select*from cerere;
select*from pacient;
select*from istoricPacient;
select* from istoricPacient1;