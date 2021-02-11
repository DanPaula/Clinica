drop database if exists policlinica;
create database if not exists policlinica;
use policlinica;
SET GLOBAL time_zone = '+3:00';
create table if not exists policlinica(
id int unique auto_increment,
nume varchar(20),
id_adresa int,
primary key(id));

create table if not exists adresa(
id_adresa int unique auto_increment,
tara varchar(20),
oras varchar(20),
judet varchar(20),
strada varchar(20),
numar varchar(20),
cod_postal varchar(20),
primary key(id_adresa));

create table if not exists program(
id int unique auto_increment,
id_program int,
ziua enum("LUNI","MARTI","MIERCURI","JOI","VINERI","SAMBATA","DUMINICA"),
ora_start time,
ora_sf time,
primary key(id));

create table if not exists utilizator(
id int unique auto_increment,
cnp varchar(20),
nume varchar(20),
id_unitate int,
prenume varchar(20),
functie varchar(30),
data_angajare varchar(20),
telefon varchar(20),
email varchar(20),
parola varchar(20),
id_angajat int unique,
id_adresa int unique,
primary key(id));

create table if not exists angajat(
id int unique auto_increment,
nume varchar(20),
prenume varchar(20),
ziua varchar(50),
ore varchar(20),
concediu varchar(30),
salariu int,
nr_ore int,
id_istoric_concediu int,
primary key(id));

create table if not exists receptioner(
id int unique auto_increment,
id_angajat int,
primary key(id));

create table if not exists asistent(
id int unique auto_increment,
tip varchar(20),
grad varchar(20),
id_angajat int,
primary key(id));

create table  if not exists tabl_temp
  ( pret int,
  salariu int);
create table if not exists medic(
id int unique auto_increment,
id_medic int,
nume varchar(20),
prenume varchar(20),
grad varchar(20),
cod_parafa int,
competente varchar(20),
titlu varchar(20),
post_didactic varchar(20),
procent int,
id_angajat int,
primary key(id));

create table if not exists administrator(
id int unique auto_increment,
superAdmin bool,
id_angajat int,
primary key(id));

create table if not exists inspector(
id int unique auto_increment,
id_angajat int,
primary key(id));

create table if not exists profit_med(
suma int);

create table if not exists servicii(
id int unique auto_increment,
nume varchar(20),
pret int,
durata time,
necesitate varchar(30),
id_medic int,
primary key(id));

create table if not exists specialitate(
id int unique auto_increment,
nume varchar(30),
id_medic int,
primary key(id));

create table if not exists programare(
id int  unique auto_increment,
nume varchar(30),
prenume varchar(30),
ziua enum("LUNI","MARTI","MIERCURI","JOI","VINERI","SAMBATA","DUMINICA"),
ora time,
id_receptioner int,
primary key(id));

create table if not exists pacient(
id int unique auto_increment,
stareDeSanatate varchar(40),
nume varchar(100),
prenume varchar(100),
totalPlata int,
id_pacient int,
id_istoric int,
primary key(id));

create table if not exists raportMedical(
id int unique auto_increment,
numePacient varchar(20),
prenumePacient varchar(20),
numeMedic varchar(20),
prenumeMedic varchar(20),
dataConsult date,
detalii varchar(30),
id_asistent int,
id_medic int,
id_istoric_raport int,
primary key(id));

create table if not exists istoricRaport(
id int unique  auto_increment,
dataConsult date,
numePacient varchar(20),
prenumePacient varchar(20),
numeMedic varchar(20),
prenumeMedic varchar(20),
detalii varchar(30),
primary key(id));



create table if not exists istoricPacient(
id int unique auto_increment,
numeMedic varchar(20),
prenumeMedic varchar(20),
nume varchar(20),
prenume varchar(20),
ziua enum("LUNI", "MARTI", "MIERCURI", "JOI", "VINERI", "SAMBATA", "DUMINICA"),
stare varchar(20),
inceput time,
sfarsit time,
pret int,
id_medic int,
id_pacient int,
id_orar int, 
primary key(id));


create table if not exists istoricPacient1(
id int unique auto_increment,
numeMedic varchar(20),
prenumeMedic varchar(20),
nume varchar(20),
prenume varchar(20),
ziua enum("LUNI", "MARTI", "MIERCURI", "JOI", "VINERI", "SAMBATA", "DUMINICA"),
numeProcedura varchar(20),
inceput time,
sfarsit time,
pret int,
id_medic int,
id_pacient int,
id_orar int, 
primary key(id));

create table if not exists tabl_profit_medic
(coeficient int,
salariu int,
pret int);

create table istoricConcediu(
id int unique auto_increment,
dataStart date,
dataEnd date,
primary key(id));

create table orar(
id int,
ziua enum("LUNI","MARTI","MIERCURI","JOI","VINERI","SAMBATA","DUMINICA"),
ora_start time,
ora_final time,
id_orar int);

create table if not exists bonuri(
id int unique auto_increment,
dataA date,
id_istoric_rapoarte int,
numePacient varchar(20),
prenumePacient varchar(20),
pret int,
stare int,
primary key(id)
);

create table if not exists cerere
(
nume_pacient varchar(20),
prenume_pacient varchar(20),
numeM varchar(20),
prenumeM varchar(20),
id int unique auto_increment not null,
data_curenta date,
ora_curenta time,
stare_cerere int, # setata cu 0 
operatie int,
id_pacient int,
Primary key(id)
);


create table if not exists consult
(
id int unique auto_increment not null,
nume_consult varchar(30),
id_angajat int,
Primary key(id)
);

alter table policlinica add
foreign key(id_adresa) references adresa(id_adresa);

alter table program add
foreign key(id_program) references policlinica(id);

alter table utilizator add
foreign key(id_unitate) references policlinica(id);

alter table utilizator add
foreign key(id_angajat) references angajat(id);

alter table utilizator add
foreign key(id_adresa) references adresa(id_adresa);

alter table angajat add
foreign key(id_istoric_concediu) references istoricConcediu(id);

alter table receptioner add
foreign key(id_angajat) references angajat(id);

alter table asistent add
foreign key(id_angajat) references angajat(id);

alter table medic add
foreign key(id_angajat) references angajat(id);

alter table inspector add
foreign key(id_angajat) references angajat(id);

alter table administrator add
foreign key(id_angajat) references angajat(id);

alter table servicii add
foreign key(id_medic) references medic(id);

alter table specialitate add
foreign key(id_medic) references medic(id);

alter table programare add
foreign key(id_receptioner) references receptioner(id);

alter table pacient add
foreign key(id_pacient) references adresa(id_adresa);

alter table raportMedical add
foreign key(id_asistent) references asistent(id);

alter table raportMedical add
foreign key(id_medic) references medic(id);

alter table raportMedical add
foreign key(id_istoric_raport) references istoricRaport(id);

alter table istoricPacient add
foreign key(id_medic) references medic(id);

alter table istoricPacient add
foreign key(id_pacient) references pacient(id);

alter table istoricPacient1 add
foreign key(id_medic) references medic(id);

alter table istoricPacient1 add
foreign key(id_pacient) references pacient(id);

alter table orar add
foreign key(id_orar) references angajat(id);

alter table consult add
foreign key(id_angajat) references angajat(id);

alter table cerere add
foreign key(id_pacient) references pacient(id);