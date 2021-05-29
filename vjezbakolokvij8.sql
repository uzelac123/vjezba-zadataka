drop database if exists kolokvij_vjezba_8;
create database kolokvij_vjezba_8;
use kolokvij_vjezba_8;

create table cura(
	sifra int not null primary key auto_increment,
	nausnica int not null,
	indiferentno bit,
	ogrlica int not null,
	gustoca decimal(12,6),
	drugiputa datetime,
	vesta varchar(33),
	prijateljica int
);

create table prijateljica(
	sifra int not null primary key auto_increment,
	vesta varchar(50),
	nausnica int not null,
	introvertno bit not null
);

create table neprijatelj(
	sifra int not null primary key auto_increment,
	kratkamajica varchar(44),
	introvertno bit,
	indiferentno bit,
	ogrlica int not null,
	becar int not null
);

create table becar(
	sifra int not null primary key auto_increment,
	eura decimal(15,10) not null,
	treciputa datetime,
	prviputa datetime,
	muskarac int not null
);

create table brat(
	sifra int not null primary key auto_increment,
	introvertno bit,
	novcica decimal(14,7) not null,
	treciputa datetime,
	neprijatelj int
);

create table decko(
	sifra int not null primary key auto_increment,
	kuna decimal(12,10),
	lipa decimal(17,10),
	bojakose varchar(44),
	treciputa datetime not null,
	ogrlica int not null,
	ekstrovertno bit not null
);

create table muskarac(
	sifra int not null primary key auto_increment,
	haljina varchar(44),
	drugiputa datetime not null,
	treciputa datetime
);

create table muskarac_decko(
	sifra int not null primary key auto_increment,
	muskarac int not null,
	decko int not null
);

alter table cura add foreign key (prijateljica) references prijateljica(sifra);

alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);

alter table neprijatelj add foreign key (becar) references becar(sifra);

alter table becar add foreign key (muskarac) references muskarac(sifra);

alter table muskarac_decko add foreign key (muskarac) references muskarac(sifra);

alter table muskarac_decko add foreign key (decko) references decko(sifra);

insert into muskarac(drugiputa)
values('2020-01-01'),('2019-01-01'),('2018-01-01');

insert into decko(treciputa,ogrlica,ekstrovertno)
values('2020-01-01',17,0),('2008-02-01',15,1),('1998-05-23',7,1);

insert into muskarac_decko(muskarac,decko)
values(1,1),(2,2),(3,3);

insert into becar(eura,muskarac)
values(13.87,1),(14.86,2),(21.54,3);

insert into neprijatelj(ogrlica,becar)
values(7,1),(20,2),(29,3);

update cura set indiferentno = false;

delete from brat where novcica != '12.75';

select prviputa from becar b where b.treciputa is null;

select d.bojakose , b2.neprijatelj , n.introvertno 

from decko d inner join muskarac_decko md on d.sifra = md.decko 

inner join muskarac m on m.sifra = md.muskarac 

inner join becar b on m.sifra = b.muskarac 

inner join neprijatelj n on b.sifra = n.becar 

inner join brat b2 on n.sifra = b2.neprijatelj 

where b.treciputa is not null and m.drugiputa is not null;


select m.drugiputa , m.treciputa 
from muskarac m left join muskarac_decko md on m.sifra = md.muskarac 
where md.muskarac is null;