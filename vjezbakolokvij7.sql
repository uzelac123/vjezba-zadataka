drop database if exists kolokvij_vjezba_7;
create database kolokvij_vjezba_7;
use kolokvij_vjezba_7;

create table mladic(
	sifra int not null primary key auto_increment,
	prstena int,
	lipa decimal(14,5) not null,
	narukvica int not null,
	drugiputa datetime not null
);

create table zarucnik(
	sifra int not null primary key auto_increment,
	vesta varchar(34),
	asocijalno bit not null,
	modelnaocala varchar(43),
	narukvica int not null,
	novcica decimal(15,5) not null
);

create table zarucnik_mladic(
	sifra int not null primary key auto_increment,
	zarucnik int not null,
	mladic int not null
);

create table ostavljen(
	sifra int not null primary key auto_increment,
	lipa decimal(14,6),
	introvertno bit not null,
	kratkamajica varchar(38)not null,
	prstena int not null,
	zarucnik int
);

create table prijateljica(
	sifra int not null primary key auto_increment,
	haljina varchar(45),
	gustoca decimal(15,10) not null,
	ogrlica int,
	novcica decimal(12,5),
	ostavljen int
);

create table sestra(
	sifra int not null primary key auto_increment,
	bojakose varchar(34) not null,
	hlace varchar(36) not null,
	lipa decimal(15,6),
	stilfrizura varchar(40) not null,
	maraka decimal(12,8) not null,
	prijateljica int
);

create table cura(
	sifra int not null primary key auto_increment,
	lipa decimal(12,9) not null,
	introvertno bit,
	modelnaocala varchar(40),
	narukvica int,
	treciputa datetime,
	kuna decimal(14,9)
);

create table punica(
	sifra int not null primary key auto_increment,
	majica varchar(40),
	eura decimal(12,6) not null,
	prstena int,
	cura int not null
);

alter table punica add foreign key (cura) references cura(sifra);

alter table sestra add foreign key (prijateljica) references prijateljica(sifra);

alter table prijateljica add foreign key (ostavljen) references ostavljen(sifra);

alter table ostavljen add foreign key (zarucnik) references zarucnik(sifra);

alter table zarucnik_mladic add foreign key (zarucnik) references zarucnik(sifra);
alter table zarucnik_mladic add foreign key (mladic) references mladic(sifra);

insert into zarucnik(asocijalno,narukvica,novcica)
values(0,1,15.56),(1,2,32.22),(1,4,22.33);

insert into mladic(lipa,narukvica,drugiputa)
values(44.13,7,'2020-09-08'),(55.13,6,'2021-09-08'),(77.13,9,'2022-09-08');

insert into zarucnik_mladic(zarucnik,mladic)
values(1,1),(2,2),(3,3);

insert into ostavljen(introvertno,kratkamajica,prstena)
values(0,'nike',8),(1,'adidas',9),(1,'puma',11);

insert into prijateljica(gustoca)
values(11.11),(12.12),(13.13);

update punica set eura = '15.77';

delete from sestra where hlace < 'AB';

select kratkamajica from ostavljen where introvertno is null;

select m.narukvica , s.stilfrizura , p.gustoca 
from mladic m inner join zarucnik_mladic zm on m.sifra = zm.mladic 
inner join zarucnik z on z.sifra = zm.zarucnik 
inner join ostavljen o on o.zarucnik = z.sifra 
inner join prijateljica p on p.ostavljen = o.sifra 
inner join sestra s on s.prijateljica = p.sifra 
where o.introvertno is not null and z.asocijalno is not null;


select z.asocijalno , z.modelnaocala 
from zarucnik z left join zarucnik_mladic zm on zm.zarucnik = z.sifra 
where zm.zarucnik is null;