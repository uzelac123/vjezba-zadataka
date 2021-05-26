drop database if exists kolokvij_vjezba_3;
create database kolokvij_vjezba_3;
use kolokvij_vjezba_3;

create table cura(
	sifra int not null primary key auto_increment,
	dukserica varchar(49),
	maraka decimal(13,7),
	drugiputa datetime,
	majica varchar(49),
	novcica decimal(15,8),
	ogrlica int not null
);

create table svekar(
	sifra int not null primary key auto_increment,
	novcica decimal(16,8) not null,
	suknja varchar(44) not null,
	bojakose varchar(36),
	prstena int,
	narukvica int not null,
	cura int not null
);

create table snasa(
	sifra int not null primary key auto_increment,
	introvertno bit,
	kuna decimal(15,6) not null,
	eura decimal(12,9) not null,
	treciputa datetime,
	ostavljena int not null
);

create table punica(
	sifra int not null primary key auto_increment,
	asocijalno bit,
	kratkamajica varchar(44),
	kuna decimal(13,8) not null,
	vesta varchar(32) not null,
	snasa int
);

create table ostavljena(
	sifra int not null primary key auto_increment,
	kuna decimal(17,5),
	lipa decimal(15,6),
	majica varchar(36),
	modelnaocala varchar(31) not null,
	prijatelj int
);

create table brat(
	sifra int not null primary key auto_increment,
	jmbag char(11),
	ogrlica int not null,
	ekstrovertno bit not null
);

create table prijatelj(
	sifra int not null primary key auto_increment,
	kuna decimal(16,10),
	haljina varchar(37),
	lipa decimal(13,10),
	dukserica varchar(31),
	indiferentno bit not null
);

create table prijatelj_brat(
	sifra int not null primary key auto_increment,
	prijatelj int not null,
	brat int not null
);


alter table svekar add foreign key (cura) references cura(sifra);

alter table punica add foreign key (snasa) references snasa(sifra);

alter table snasa add foreign key (ostavljena) references ostavljena(sifra);

alter table ostavljena add foreign key (prijatelj) references prijatelj(sifra);

alter table prijatelj_brat add foreign key (prijatelj) references prijatelj(sifra);
alter table prijatelj_brat add foreign key (brat) references brat(sifra);


insert into ostavljena(modelnaocala)
values('Tommy Hillfiger'), ('Sun?ane nao?ale'), ('Nao?ale za ?itanje');

insert into snasa(kuna,eura,ostavljena)
values(99.99,88.88,1), 
(77.77,66.66,2), 
(55.55,44.44,3);

insert into prijatelj(indiferentno)
values(0), (1), (0);

insert into brat(ogrlica, ekstrovertno)
values(7,0), (13,1), (17,0);

insert into prijatelj_brat(prijatelj,brat)
values(1,1), (2,2), (3,3);

update svekar set suknja = 'Osijek';

delete from punica where kratkamajica = '44';

select majica from ostavljena where lipa not in (9.00,10.00,20.00,30.00,35.00);


select b.ekstrovertno, p.vesta, s.kuna 
from punica p inner join snasa s on p.snasa = s.sifra 
inner join ostavljena o on s.ostavljena = o.sifra 
inner join prijatelj p2 on o.prijatelj = p2.sifra 
inner join prijatelj_brat pb on p2.sifra = pb.prijatelj 
inner join brat b on pb.brat = b.sifra
where o.lipa != 91.00 and p2.haljina like '%ba%'
order by s.kuna desc;


select p.haljina , p.lipa 
from prijatelj p left join prijatelj_brat pb on p.sifra = pb.prijatelj 
where pb.prijatelj is null;