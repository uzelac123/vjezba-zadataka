drop database if exists kolokvij_vjezba_2;
create database kolokvij_vjezba_2;
use kolokvij_vjezba_2;

create table cura(
	sifra int not null primary key auto_increment,
	haljina varchar(33) not null,
	drugiputa datetime not null,
	suknja varchar(38),
	narukvica int,
	introvertno bit,
	majica varchar(40) not null,
	decko int
);

create table decko(
	sifra int not null primary key auto_increment,
	indiferentno bit,
	vesta varchar(34),
	asocijalno bit not null
);

create table decko_zarucnica(
	sifra int not null primary key auto_increment,
	decko int not null,
	zarucnica int not null
);

create table zarucnica(
	sifra int not null primary key auto_increment,
	narukvica int,
	bojakose varchar(37) not null,
	novcica decimal(15,9),
	lipa decimal(15,8) not null,
	indiferentno bit not null
);

create table neprijatelj(
	sifra int not null primary key auto_increment,
	majica varchar(32),
	haljina varchar(43) not null,
	lipa decimal(16,8),
	modelnaocala varchar(49) not null,
	kuna decimal(12,6) not null,
	jmbag char(11),
	cura int
);

create table prijatelj(
	sifra int not null primary key auto_increment,
	modelnaocala varchar(37),
	treciputa datetime not null,
	ekstrovertno bit not null,
	prviputa datetime,
	svekar int not null
);

create table brat(
	sifra int not null primary key auto_increment,
	suknja varchar(47),
	ogrlica int not null,
	asocijalno bit not null,
	neprijatelj int not null
);

create table svekar(
	sifra int not null primary key auto_increment,
	stilfrizura varchar(48),
	ogrlica int not null,
	asocijalno bit not null
);

alter table cura add foreign key (decko) references decko(sifra);

alter table decko_zarucnica add foreign key (decko) references decko(sifra);
alter table decko_zarucnica add foreign key (zarucnica) references zarucnica(sifra);

alter table neprijatelj add foreign key (cura) references cura(sifra);

alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);

alter table prijatelj add foreign key (svekar) references svekar(sifra);

#U tablice neprijatelj, cura i decko_zarucnica unesite po 3 retka.
insert into neprijatelj(haljina,modelnaocala,kuna)
values('sve?ana haljina','sun?ane nao?ale',30.98),
('svadbena haljina','nao?ale za ?itanje',78.54),
('obi?na haljina','Ray ban',99.18);

insert into cura(haljina,drugiputa,majica)
values('uska haljina','2021-03-04','dugih rukava'),
('široka haljina','2020-12-25','kratkih rukava'),
('haljina sa cvjeti?ima','2020-06-14','bez rukava');

insert into decko(asocijalno)
values(1),(0),(0);

insert into zarucnica(bojakose,lipa,indiferentno)
values('crna',70.97,1),
('plava',7.67,0),
('sme?a',45.43,0);

insert into decko_zarucnica(decko,zarucnica)
values(1,1), (2,3), (3,2);

update prijatelj set treciputa = '2020-04-30';

delete from brat where ogrlica != 14;

#Izlistajte suknja iz tablice cura uz uvjet da vrijednost kolone drugiputa nepoznate.
select suknja from cura where drugiputa = null; # nisam siguran je li ovo to?no.


select z.novcica, b.neprijatelj, n.haljina 
from zarucnica z inner join decko_zarucnica dz on z.sifra = dz.zarucnica 
inner join decko d on dz.decko = d.sifra 
inner join cura c on d.sifra = c.decko 
inner join neprijatelj n on c.sifra = n.cura 
inner join brat b on n.sifra = b.neprijatelj 
where d.vesta like '%ba%' and c.drugiputa is not null 
order by n.haljina desc;

#Prikažite kolone vesta i asocijalno iz tablice decko ?iji se primarni klju? ne nalaze u tablici decko_zarucnica.
select d.vesta , d.asocijalno 
from decko d left join decko_zarucnica dz on d.sifra = dz.decko 
where dz.decko is null;
