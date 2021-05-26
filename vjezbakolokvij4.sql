drop database if exists kolokvij_vjezba4;
create database kolokvij_vjezba4;
use kolokvij_vjezba4;

create table punac(
	sifra int not null primary key auto_increment,
	treciputa datetime,
	majica varchar(46),
	jmbag char(11) not null,
	novcica decimal(18,7) not null,
	maraka decimal(12,6) not null,
	ostavljen int not null
);

create table ostavljen(
	sifra int not null primary key auto_increment,
	modelnaocala varchar(43),
	introvertno bit,
	kuna decimal(14,10)
);

create table mladic(
	sifra int not null primary key auto_increment,
	kuna decimal(15,9),
	lipa decimal(18,5),
	nausinca int,
	stilfrizura varchar(49),
	vesta varchar(34)
);

create table zena_mladic(
	sifra int not null primary key auto_increment,
	zena int,
	mladic int
);

create table zena(
	sifra int not null primary key auto_increment,
	suknja varchar(39) not null,
	lipa decimal(18,7),
	prstena int not null
);

create table snasa(
	sifra int not null primary key auto_increment,
	introvertno bit,
	treciputa datetime,
	haljina varchar(44) not null,
	zena int not null
);

create table becar(
	sifra int not null primary key auto_increment,
	novcica decimal(14,8),
	kratkamajica varchar(48) not null,
	bojaociju varchar(36) not null,
	snasa int not null
);

create table prijatelj(
	sifra int not null primary key auto_increment,
	eura decimal(16,9),
	prstena int not null,
	gustoca decimal(16,5),
	jmbag char(11) not null,
	suknja varchar(47) not null,
	becar int not null
);

alter table punac add foreign key (ostavljen) references ostavljen(sifra);
alter table zena_mladic add foreign key (mladic) references mladic(sifra);
alter table zena_mladic add foreign key (zena) references zena(sifra);
alter table snasa add foreign key (zena) references zena(sifra);
alter table becar add foreign key (snasa) references snasa(sifra);
alter table prijatelj add foreign key (becar) references becar(sifra);


insert into zena(suknja,prstena) values
('narancasta',1);

insert into mladic(vesta) values
('zelena');

insert into zena_mladic(zena,mladic) values
(1,1),
(1,1),
(1,1);

insert into snasa(haljina,zena) values
('plava',1),
('ljubicasta',1),
('roza',1);

insert into becar(kratkamajica,bojaociju,snasa) values
('zelena','plava',1),
('bijela','crvena',1),
('zuta','crna',1);

insert into ostavljen(kuna) values
(420.69);
insert into punac(jmbag,novcica,maraka,ostavljen) values
(24613578921,69.99,75.25,1);
select * from punac;
update punac set majica='Osijek';

insert into zena(suknja,prstena) values
('tirkizna',1);
insert into snasa(haljina,zena) values
('crvena',1),
('plava',1),
('zelena',1);
insert into becar(kratkamajica,bojaociju,snasa) values
('ljubicasta','smeda',1),
('bijela','plava',1),
('zelena','zlatna',1);
insert into prijatelj(prstena,jmbag,suknja,becar) values
(6,15467373456,'zelena',1),
(28,34562879124,'zelena',1),
(5,5631820745,'zelena',1),
(65,77893547521,'zelena',1),
(98,88563472159,'zelena',1);
select * from prijatelj;

delete from prijatelj where prstena >17;

select * from snasa;

select * from snasa where treciputa is null;

select b.kratkamajica, p.jmbag, m.nausnica
inner join mladic m inner join zena_mladic zm on m.sifra=zm.mladic
inner join zena z on z.sifra=zm.zena
inner join snasa s on z.sifra=s.zena
inner join becar b on s.sifra=b.snasa
inner join prijatelj p on b.sifra=p.becar
where s.treciputa is not null and z.lipa!=29;

select z.lipa, z.prstena 
from zena z
where not exists (select * from  zena_mladic zm where zm.zena=z.sifra);
