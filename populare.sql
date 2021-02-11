use policlinica;
	
insert into policlinica(nume)
values ("Medlife");

insert into adresa(tara,judet,oras,strada,numar,cod_postal)
values  ("Romania","Cluj","Cluj-Napoca","Observator",1,"400500"),
("Romania","Cluj","Cluj-Napoca","Observator",1,"400500"),
("Romania","Cluj","Cluj-Napoca","Observator",1,"400500"),
("Romania","Cluj","Cluj-Napoca","Observator",1,"400500"),
("Romania","Cluj","Cluj-Napoca","Observator",1,"400500"),
("Romania","Cluj","Cluj-Napoca","Observator",1,"400500"),
("Romania","Cluj","Cluj-Napoca","Observator",1,"400500"),
("Romania","Cluj","Cluj-Napoca","Observator",1,"400500"),
("Romania","Cluj","Cluj-Napoca","Observator",1,"400500");

insert into program(ziua,ora_start,ora_sf)
values  ('LUNI',"08:00","22:00"),
		('MARTI',"08:00","22:00"),
		('MIERCURI',"08:00","22:00"),
		('JOI',"08:00","22:00"),
		('VINERI',"08:00","22:00"),
		('SAMBATA',"08:00","18:00"),
		('DUMINICA',"08:00","18:00");
        
insert into utilizator (functie,data_angajare,email,telefon,nume,prenume,parola,CNP)
values  ("Admin","10.02.2018","a1@yahoo.com","0123456789","Sacaz","Mirel","testare1","0200000000000"),
        ("SuperA","10.02.2018","a@yahoo.com","0123456789","Traian","Basescu","testare","0200000000000"),
		("ResurseUmane","10.02.2018","a@yahoo.com","0123456789","Dan","Paula","resurse","0200000000000"),
		("Receptioner","10.02.2018","a@yahoo.com","0123456789","Moldovan","Armina","tenisdemasa","0200000000000"),
		("Medic","10.02.2018","a@yahoo.com","0123456789","Gabor","Loreaha","stergatoare","0200000000000"),
		("Medic","10.02.2018","a@yahoo.com","0123456789","Borcea","Adrian","kumite","0200000000000"),
		("Asistent","10.02.2018","a@yahoo.com","0123456789","Avram","Bianca","am dreptate","0200000000000"),
		("Contabil","10.02.2018","a@yahoo.com","0123456789","Hulea","Andi","artistique","0200000000000"),
		("Medic","10.02.2018","a@yahoo.com","0123456789","Giurgiu","Mihai","portugalia","0200000000000"),
        ("Asistent","10.02.2018","ian@ocult.com","0123456789","Pop","Ionut","bnPeContrasens","0200000000000"),
        ("Asistent","10.02.2018","azteca@ocult.com","0123456789","Pop","Marius","unDeget","0200000000000");
        
insert into angajat(salariu,nr_ore,nume,prenume,ziua,ore,concediu)
values (6000,6,"Sacaz","Mirel","Luni Marti Miercuri Vineri Duminica","08-14","06 Jan-19 Jan"),
       (8000,6,"Traian","Basescu","Luni Marti Miercuri Sambata Duminica","08-14","06 Jul-20 Jul"),
       (4000,6,"Dan","Paula","Luni Miercuri Joi Vineri Duminica","16-22","07 Mar-13 Mar"),
       (2500,6,"Moldovan","Armina","Marti Miercuri Joi Vineri Duminica","08-14","10 Jul-20 Jul"),
       (4000,6,"Gabor","Loreaha","Luni Marti Miercuri Sambata Duminica","10-16","01 Dec-11 Dec"),
       (3500,6,"Borcea","Adrian","Marti Miercuri Joi Vineri Duminica","08-14","20 Dec-27 Dec"),
       (3500,6,"Avram","Bianca","Luni Miercuri Vineri Sambata Duminica","14-20","28 Dec-4 Jan"),
       (3500,6,"Hulea","Andi","Luni Marti Miercuri Joi Vineri","12-18","06 Mai-20 Mai"),
       (4500,6,"Giurgiu","Mihai","Luni Marti Miercuri Joi Vineri","16-22","24 Aug-30 Aug"),
       (4500,6,"Pop","Ionut","Luni Marti Vineri Sambata Duminica","10-16","06 Feb-20 Feb"),
       (4500,6,"Pop","Marius","Luni Marti Miercuri Vineri Duminica","16-22","01 Feb-10 Feb");
      
       
insert into asistent(tip,grad)
 values ("Generalist","Secundar"),
		("Generalist","Principal"),
		("Laborator","Secundar"),
        ("Laborator","Principal"),
        ("Radiologie","Principal");

insert into medic(grad,cod_parafa,competente,titlu,post_didactic,procent, id_angajat,nume,prenume,id_medic)
values  ("Specialist", 4000, "competente", "Doctorand", "Preparator", 5, 1,"Giurgiu","Mihai",1),
		("Primar", 4001, "competente", "Doctor SM", "Asistent", 10, 2,"Gabor","Loreaha",2),
		("Specialist", 4002, "competente", "Doctorand", "Lector", 15, 3,"Borcea","Adrian",3);
    
        
insert into administrator(superAdmin)
values  (1),
		(0);

insert into servicii( nume,pret,durata,necesitate, id_medic) 
values  ("Consultatie",50,"00:15:00","durere in piept", 1),
		("Ecografie",200,"00:10:00","cotrol periodic", 2),
        ("Analize",100,"00:30:00","control anual", 3),
		("Chirurgie",6000,"02:00:00","transplant rinichi", 2),
        ("Donare Sange",0,"00:05:00","deaia", 1);

insert into specialitate(nume)
values  ("Chirurgie"),
        ("Medicina Generala"),
		("Cardiologie"),
		("Chirurgie"),
        ("Medicina Generala"),
		("Medicina Dentara");

insert into pacient(stareDeSanatate, id_pacient, id_istoric,nume,prenume,totalPlata)
values ("grav", 1, 1,"Luncan","Bogdan",5000),
	   ("mediu", 2, 2,"Vanyi","Vivien",600),
       ("coma", 3, 3,"Klaus","Iohanis",8000),
       ("mediu", 4, 4,"Popa","Dorian",2000);
	

       
insert into istoricPacient(stare, nume, prenume, ziua, inceput, sfarsit, pret, id_medic, id_orar,numeMedic,prenumeMedic)
values
	   ("grav", "Luncan", "Bogdan", 'JOI', '14:00', '18:00', 13000, 1, 1,"Giurgiu","Mihai"),
	   ("mediu", "Vanyi", "Vivien", 'MIERCURI', '14:00', '15:00', 9000, 2, 2,"Gabor","Loreaha"),
       ("coma", "Klaus", "Iohanis", 'LUNI', '15:10', '15:50', 60000, 2, 3,"Gabor","Loreaha"),
       ("mediu", "Popa", "Dorian", 'VINERI', '14:00', '18:00', 50000, 3, 4,"Borcea","Adrian"),
       ("mediu", "Grigorescu", "Octavian", 'MARTI', '10:44', '11:10', 1044, 2, 5,"Gabor","Loreaha");
       
insert into istoricPacient1(numeProcedura, nume, prenume, ziua, inceput, sfarsit, pret, id_medic, id_orar,numeMedic,prenumeMedic)
values
	   ("ecografie", "Luncan", "Bogdan", 'JOI', '14:00', '18:00', 13000, 1, 1,"Giurgiu","Mihai"),
	   ("consultatie", "Vanyi", "Vivien", 'MIERCURI', '14:00', '15:00', 9000, 2, 2,"Gabor","Loreaha"),
       ("consultatie", "Klaus", "Iohanis", 'LUNI', '15:10', '15:50', 60000, 2, 3,"Gabor","Loreaha"),
       ("operatie", "Popa", "Dorian", 'VINERI', '14:00', '18:00', 50000, 3, 4,"Borcea","Adrian"),
       ("operatie", "Grigorescu", "Octavian", 'MARTI', '10:44', '11:10', 1044, 2, 5,"Gabor","Loreaha");

insert into orar(ziua, ora_start, ora_final, id_orar) 
values  ('LUNI',"08:00","22:00", 1),
		('MARTI',"08:00","22:00", 2),
		('MIERCURI',"08:00","22:00", 3),
		('JOI',"08:00","22:00", 4),
		('VINERI',"08:00","22:00", 1),
		('SAMBATA',"08:00","18:00", 2),
        ('DUMINICA', "08:00","18:00", 3);
        
insert into cerere(data_curenta, ora_curenta, stare_cerere, operatie, id_pacient,nume_pacient,prenume_pacient,numeM,prenumeM)
values (current_date, current_time, 0, 1, 1,"Luncan","Bogdan","Giurgiu","Mihai"),
	   (current_date, current_time, 0, 2, 2,"Vanyi","Vivien","Gabor","Loreaha"),
       (current_date, current_time, 0, 2, 3,"Klaus","Iohanis","Gabor","Loreaha"),
       (current_date, current_time, 0, 1, 4,"Grigorescu","Octavian","Gabor","Loreaha");