drop database if exists kolokvij_vjezba_11;
create database kolokvij_vjezba_11;
use kolokvij_vjezba_11;

create table punica(
	sifra int not null primary key auto_increment,
	carape varchar(33) not null,
	drugiputa datetime,
	majica varchar(40) not null,
	haljina varchar(30) not null,
	bojakose varchar(37) not null,
	djevojka int not null
);

create table djevojka(
	sifra int not null primary key auto_increment,
	kratkamajica varchar(45) not null,
	prstena int,
	ekstrovertno bit not null,
	majica varchar(42) not null,
	introvertno bit not null,
	svekrva int
);

create table punac(
	sifra int not null primary key auto_increment,
	jmbag char(11),
	kuna decimal(16,5) not null,
	vesta varchar(45) not null
);

create table mladic(
	sifra int not null primary key auto_increment,
	ogrlica int not null,
	stilfrizura varchar(35),
	drugiputa datetime not null,
	hlace varchar(45) not null
);

create table punac_mladic(
	sifra int not null primary key auto_increment,
	punac int not null,
	mladic int not null
);

create table svekrva(
	sifra int not null primary key auto_increment,
	narukvica int not null,
	carape varchar(39) not null,
	haljina varchar(31),
	punac int not null
);

create table neprijatelj(
	sifra int not null primary key auto_increment,
	narukvica int not null,
	novcica decimal(12,8) not null,
	bojakose varchar(39) not null,
	gustoca decimal(14,10),
	introvertno bit not null,
	asocijalno bit
);

create table muskarac(
	sifra int not null primary key auto_increment,
	maraka decimal(16,5),
	novcica decimal(13,10),
	nausnica int not null,
	narukvica int not null,
	gustoca decimal(12,6),
	neprijatelj int not null
);

alter table muskarac add foreign key (neprijatelj) references neprijatelj(sifra);

alter table punica add foreign key (djevojka) references djevojka(sifra);

alter table djevojka add foreign key (svekrva) references svekrva(sifra);

alter table svekrva add foreign key (punac) references punac(sifra);

alter table punac_mladic add foreign key (punac) references punac(sifra);

alter table punac_mladic add foreign key (mladic) references mladic(sifra);


insert into punac(kuna,vesta)
values(55.22,'Nike'),(11.00,'bez kapulja?e'),(40.02,'za po ku?i');

insert into mladic(ogrlica,drugiputa,hlace)
values(13,'2020-02-02','traper'),(14,'2021-01-10','poderane'),(15,'2018-04-05','od odijela');

insert into punac_mladic(punac,mladic)
values(1,1),(2,2),(3,3);

insert into svekrva(narukvica,carape,punac)
values(12,'pokemon',1),(14,'kratke ljetne',2),(20,'debele zimske',3);

insert into djevojka(kratkamajica,ekstrovertno,majica,introvertno)
values('adidas',0,'neka bezz',0),('nike',0,'polo',1),('puma',1,'crvena',1);

update muskarac set novcica = 12.30;

delete from punica where drugiputa = '2019-04-08';

select haljina
from svekrva s where s.carape like '&ana&';

select m.drugiputa , p2.haljina , d.prstena 

from mladic m inner join punac_mladic pm on m.sifra = pm.mladic 

inner join punac p on p.sifra = pm.punac 

inner join svekrva s on s.punac = p.sifra 

inner join djevojka d on d.svekrva = s.sifra 

inner join punica p2 on p2.djevojka = d.sifra 

where s.carape like 'a%' and p.kuna != 10.00

order by d.prstena desc;


select p.kuna , p.vesta 

from punac p left join punac_mladic pm on pm.punac = p.sifra 

where pm.punac is null;