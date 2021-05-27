drop database if exists kolokvijvjezba6;
create database kolokvijvjezba6;
use kolokvijvjezba6;


#0 Kreiranje tablica i veza
create table decko(
  sifra int not null primary key auto_increment,
  prviputa datetime,
  modelnaocala varchar(41),
  nausnica int,
  zena int not null
);

create table zena(
  sifra int not null primary key auto_increment,
  novcica decimal(14,8) not null,
  narukvica int not null,
  dukserica varchar(40) not null,
  haljina varchar(30),
  hlace varchar(32),
  brat int not null
);

create table prijatelj(
  sifra int not null primary key auto_increment,
  haljina varchar(35),
  prstena int not null,
  introvertno bit,
  stilfrizura varchar(36) not null
);

create table brat(
  sifra int not null primary key auto_increment,
  nausnica int not null,
  treciputa datetime not null,
  narukvica int not null,
  halce varchar(31),
  prijatelj int
);

create table prijatelj_ostavljena(
  sifra int not null primary key auto_increment,
  prijatelj int not null,
  ostavljena int not null
);

create table ostavljena(
  sifra int not null primary key auto_increment,
  prviputa datetime not null,
  kratkamajica varchar(39) not null,
  drugiputa datetime,
  marka decimal(14,10)
);

create table svekrva(
  sifra int not null primary key auto_increment,
  hlace varchar(48) not null,
  suknja varchar(42) not null,
  ogrlica int not null,
  treciputa datetime not null,
  dukserica varchar(32) not null,
  narukvica int not null,
  punac int 
);

create table punac(
  sifra int not null primary key auto_increment,
  ekstrovertno bit not null,
  suknja varchar(30) not null,
  majica varchar(44) not null,
  prviputa datetime not null
);

alter table svekrva add foreign key(punac) references punac(sifra);
alter table decko add foreign key(zena) references zena(sifra);
alter table zena add foreign key(brat) references brat(sifra);
alter table brat add foreign key(prijatelj) references prijatelj(sifra);

alter table prijatelj_ostavljena add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_ostavljena add foreign key(ostavljena) references ostavljena(sifra);


select * from prijatelj;

insert into prijatelj(prstena,stilfrizura)
values  (3,'Kratka'),
        (5,'Duga'),
        (7,'Celavo');
        
       
select * from brat;

insert into brat(nausnica,treciputa,narukvica)
values  (8,'2021-11-21',1),
        (5,'2017-12-11',5),
        (8,'2013-09-23',9);
        
       
select * from zena;

insert into zena(novcica,narukvica,dukserica,brat)
values  (10.99,3,'Plava',1),
        (20.99,8,'Zelena',2),
        (30.99,1,'Crna',3);
        
       
select * from ostavljena;

insert into ostavljena(prviputa,kratkamajica)
values  ('2020-12-03','Plava kratka'),
        ('2019-04-23','Zelena duga'),
        ('2018-11-13','Crna kratka');
        
       
select * from prijatelj_ostavljena;

insert into prijatelj_ostavljena(prijatelj,ostavljena)
values  (1,3),
        (2,2),
        (3,1);
        
       
select * from punac;
insert into punac(ekstrovertno,suknja,majica,prviputa)
values  (0,'Kratka','Dugih rukava','2024-04-04'),
        (1,'Duga','Kratkih rukava','2023-12-11'),
        (1,'Plava','Crna','2021-11-01');
        
select * from svekrva;
insert into svekrva(hlace,suknja,ogrlica,treciputa,dukserica,narukvica,punac)
values  ('Plave','Crna',3,'2019-12-31','Duga',3,1),
        ('Crne','Plava',5,'2012-10-24','Crna',3,1),
        ('Zelene','Zuta',1,'2013-11-01','Plava',3,1);
        
update svekrva set suknja='Osijek';


select * from decko;
delete from decko where modelnaocala<'AB';


select a.drugiputa , f.zena , e.narukvica 
from ostavljena a
inner join prijatelj_ostavljena b on a.sifra      = b.ostavljena 
inner join prijatelj            c on b.prijatelj  = c.sifra
inner join brat                 d on c.sifra      = d.prijatelj 
inner join zena                 e on d.sifra      = e.brat
inner join decko                f on e.sifra      = f.zena
where d.treciputa is not null and c.prstena = 219
order by e.narukvica desc;


select a.prstena , a.introvertno
from prijatelj a left join prijatelj_ostavljena b on a.sifra = b.prijatelj 
where b.prijatelj is null;