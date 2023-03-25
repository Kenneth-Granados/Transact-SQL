USE Practica;
GO

if object_id('Inscriptos') is not null
  drop table Inscriptos;
 if object_id('Socios') is not null
  drop table Socios;
 if object_id('Deportes') is not null
  drop table Deportes;
GO

 create table Socios(
  documento char(8) not null, 
  nombre varchar(30),
  domicilio varchar(30),
  primary key(documento)
 );
 create table Deportes(
  codigo tinyint identity,
  nombre varchar(20),
  profesor varchar(15),
  primary key(codigo)
 );
 create table Inscriptos(
  documento char(8) not null, 
  codigodeporte tinyint not null,
  año char(4),
  matricula char(1),--'s'=paga, 'n'=impaga
  primary key(documento,codigodeporte,año),
  constraint FK_Inscriptos_socio
   foreign key (documento)
   references Socios(documento)
   on update cascade
   on delete cascade
 );
GO

 insert into Socios values('22222222','Ana Acosta','Avellaneda 111');
 insert into Socios values('23333333','Betina Bustos','Bulnes 222');
 insert into Socios values('24444444','Carlos Castro','Caseros 333');
 insert into Socios values('25555555','Daniel Duarte','Dinamarca 44');

 insert into Deportes values('basquet','Juan Juarez');
 insert into Deportes values('futbol','Pedro Perez');
 insert into Deportes values('natacion','Marina Morales');
 insert into Deportes values('tenis','Marina Morales');

 insert into Inscriptos values ('22222222',3,'2006','s');
 insert into Inscriptos values ('23333333',3,'2006','s');
 insert into Inscriptos values ('24444444',3,'2006','n');
 insert into Inscriptos values ('22222222',3,'2005','s');
 insert into Inscriptos values ('22222222',3,'2007','n');
 insert into Inscriptos values ('24444444',1,'2006','s');
 insert into Inscriptos values ('24444444',2,'2006','s');
 GO
--4- Realice una consulta en la cual muestre todos los datos de las inscripciones, incluyendo el 
--nombre del deporte y del profesor.
--Esta consulta es un join.
select i.documento,i.codigodeporte,d.nombre as deporte, año, matricula, d.profesor
 from deportes as d
 join inscriptos as i
 on d.codigo=i.codigodeporte;
 GO
 
--5- Utilice el resultado de la consulta anterior como una tabla derivada para emplear en lugar de una 
--tabla para realizar un "join" y recuperar el nombre del socio, el deporte en el cual está inscripto, 
--el año, el nombre del profesor y la matrícula.
select s.nombre,td.deporte,td.profesor,td.año,td.matricula
  from socios as s
  join (select i.documento,i.codigodeporte,d.nombre as deporte, año, matricula, d.profesor
	from deportes as d
	join inscriptos as i
	on d.codigo=i.codigodeporte) as td
  on td.documento=s.documento;