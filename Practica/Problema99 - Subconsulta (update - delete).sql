USE Practica;
GO

if object_id('Inscriptos') is not null
drop table Inscriptos;
if object_id('Socios') is not null
drop table Socios;
GO

create table Socios(
numero int identity,
documento char(8),
nombre varchar(30),
domicilio varchar(30),
primary key (numero)
);
 
create table Inscriptos (
numerosocio int not null,
deporte varchar(20) not null,
matricula char(1),-- 'n' o 's'
primary key(numerosocio,deporte),
constraint FK_Inscriptos_socio
foreign key (numerosocio)
references Socios(numero)
);
GO

insert into Socios values('23333333','Alberto Paredes','Colon 111');
insert into Socios values('24444444','Carlos Conte','Sarmiento 755');
insert into Socios values('25555555','Fabian Fuentes','Caseros 987');
insert into Socios values('26666666','Hector Lopez','Sucre 344');

insert into Inscriptos values(1,'tenis','s');
insert into Inscriptos values(1,'basquet','s');
insert into Inscriptos values(1,'natacion','s');
insert into Inscriptos values(2,'tenis','s');
insert into Inscriptos values(2,'natacion','s');
insert into Inscriptos values(2,'basquet','n');
insert into Inscriptos values(2,'futbol','n');
insert into Inscriptos values(3,'tenis','s');
insert into Inscriptos values(3,'basquet','s');
insert into Inscriptos values(3,'natacion','n');
insert into Inscriptos values(4,'basquet','n');
GO
--4- Actualizamos la cuota ('s') de todas las inscripciones de un socio determinado (por documento) 
--empleando subconsulta.

update inscriptos set matricula='s'
where numerosocio=
(select numero from socios
    where documento='25555555');
GO
--5- Elimine todas las inscripciones de los Socios que deben alguna matrícula (5 registros eliminados)
delete from inscriptos
where numerosocio in
(select numero
from socios as s
join inscriptos
on numerosocio=numero
where matricula='n');
GO