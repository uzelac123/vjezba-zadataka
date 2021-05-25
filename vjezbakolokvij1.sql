drop database if exists vjezbakolokvij1;
create database vjezbakolokvij1;
use vjezbakolokvij1;

create table punac(
	sifra int not null primary key auto_increment,
	ogrlica int,
	gustoca decimal(14,9),
	hlace varchar(41) not null
);

create table sestra(
	sifra int not null primary key auto_increment,
	introvertno bit,
	haljina varchar(31) not null,
	maraka decimal(16,6),
	hlace varchar(46) not null,
	narukvica int not null
);

create table zena(
	sifra int not null primary key auto_increment,
	treciputa datetime,
	hlace varchar(46),
	kratkamajica varchar(31) not null,
	jmbg char(11) not null,
	bojaociju varchar(39) not null,
	haljina varchar(44),
	sestra int not null
);

create table cura(
	sifra int not null primary key auto_increment,
	novcica decimal(16,5) not null,
	gustoca decimal(18,6) not null,
	lipa decimal(13,10),
	ogrlica int not null,
	bojakose varchar(38),
	suknja varchar(36),
	punac int
);

create table sestra_svekar(
	sifra int not null primary key auto_increment,
	sestra int not null,
	svekar int not null
);

create table muskarac(
	sifra int not null primary key auto_increment,
	bojaociju varchar(50) not null,
	hlace varchar(30),
	modelnaocala varchar(43),
	maraka decimal(14,5) not null,
	zena int not null
);

create table svekar(
	sifra int not null primary key auto_increment,
	bojaociju varchar(40) not null,
	prstena int,
	dukserica varchar(41),
	lipa decimal(13,8),
	eura decimal(12,7),
	majica varchar(35)
);

create table mladic(
	sifra int not null primary key auto_increment,
	suknja varchar(50) not null,
	kuna decimal(16,8) not null,
	drugiputa datetime,
	asocijalno bit,
	ekstroventno bit not null,
	dukserica varchar(48) not null,
	muskarac int
);

alter table sestra_svekar add foreign key(sestra) references sestra(sifra);
alter table zena add foreign key(sestra) references sestra(sifra);
alter table cura add foreign key(punac) references punac(sifra);
alter table sestra_svekar add foreign key(svekar) references svekar(sifra);
alter table muskarac add foreign key(zena) references zena(sifra);
alter table mladic add foreign key(muskarac) references muskarac(sifra);

insert into sestra(haljina,hlace,narukvica) values
('zuta','crvena',1);

insert into svekar(bojaociju) values
('crvena');

insert into zena(kratkamajica,jmbg,bojaociju,sestra) values
('panakota',11111111111,'plava',1),
('crvena',22222222222,'zelena',1),
('narancasta',33333333333,'plava',1);

insert into muskarac(bojaociju,maraka,zena) values
('smeda',232323232.34567,1),
('plava',454545456.34567,1),
('zelene',676767678.12345,1);

insert into sestra_svekar(sestra,svekar) values
(1,1),
(1,1),
(1,1);

select * from sestra_svekar;
select * from sestra;
select * from svekar;
select * from zena;
select * from muskarac;

insert into cura(novcica,gustoca,ogrlica) values
(33333333333.55555,564456456456.123123,1);
select * from cura;
update cura set gustoca=15.77 where sifra=1;
select * from cura;

insert into mladic(suknja,kuna,ekstroventno,dukserica) values
('kratka',25.65,1,'zuta'),
('kratka',35.65,1,'zuta'),
('kratka',11.65,1,'zuta'),
('kratka',5.65,1,'zuta');
select * from mladic;
delete from mladic where kuna>15.78;
select * from mladic;

select * from zena;
select * from zena where kratkamajica like '%ana%';

select a.dukserica, f.asocijalno, e.hlace 
from svekar a inner join sestra_svekar b on a.sifra=b.svekar
inner join sestra c on c.sifra=b.sestra
inner join zena d on d.sestra=c.sifra
inner join muskarac e on e.zena=d.sifra 
inner join mladic f on f.muskarac=e.sifra 
where d.hlace like 'a%' and c.haljina like '%ba%';

select c.haljina, c.maraka 
from sestra c
where not exists
(select * from sestra_svekar b where b.sestra = c.sifra);