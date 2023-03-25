USE Practica;
GO

if object_id('Socios') is not null
 drop table Socios;
if object_id('Deportes') is not null
 drop table Deportes;
if object_id('Inscriptos') is not null
 drop table Inscriptos;
Go

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
 anio char(4),
 matricula char(1),--'s'=paga, 'n'=impaga
 primary key(documento,codigodeporte,anio)
);
GO

--3- Ingrese algunos registros en "Socios":
insert into Socios values('22222222','Ana Acosta','Avellaneda 111');
insert into Socios values('23333333','Betina Bustos','Bulnes 222');
insert into Socios values('24444444','Carlos Castro','Caseros 333');
insert into Socios values('25555555','Daniel Duarte','Dinamarca 44');
GO
--4- Ingrese algunos registros en "Deportes":
insert into Deportes values('basquet','Juan Juarez');
insert into Deportes values('futbol','Pedro Perez');
insert into Deportes values('natacion','Marina Morales');
insert into Deportes values('tenis','Marina Morales');
GO
--5- Inscriba a varios Socios en el mismo deporte en el mismo año:
insert into Inscriptos values ('22222222',3,'2006','s');
insert into Inscriptos values ('23333333',3,'2006','s');
insert into Inscriptos values ('24444444',3,'2006','n');
GO
--6- Inscriba a un mismo socio en el mismo deporte en distintos años:
insert into Inscriptos values ('22222222',3,'2005','s');
insert into Inscriptos values ('22222222',3,'2007','n');
GO
--7- Inscriba a un mismo socio en distintos Deportes el mismo año:
insert into Inscriptos values ('24444444',1,'2006','s');
insert into Inscriptos values ('24444444',2,'2006','s');
GO
--8- Ingrese una inscripción con un código de deporte inexistente y un documento de socio que no 
--exista en "Socios":
 insert into Inscriptos values ('26666666',0,'2006','s');
GO
--9- Muestre el nombre del socio, el nombre del deporte en que se inscribió y el año empleando 
--diferentes tipos de join.
select s.nombre,d.nombre,anio
  from deportes as d
  right join inscriptos as i
  on codigodeporte=d.codigo
  left join socios as s
  on i.documento=s.documento;
GO
--10- Muestre todos los datos de las inscripciones (excepto los códigos) incluyendo aquellas 
--inscripciones cuyo código de deporte no existe en "Deportes" y cuyo documento de socio no se 
--encuentra en "Socios".
select s.nombre,d.nombre,anio,matricula
  from deportes as d
  full join inscriptos as i
  on codigodeporte=d.codigo
  full join socios as s
  on s.documento=i.documento;
GO
--11- Muestre todas las inscripciones del socio con documento "22222222".
select s.nombre,d.nombre,anio,matricula
  from deportes as d
  join inscriptos as i
  on codigodeporte=d.codigo
  join socios as s
  on s.documento=i.documento
  where s.documento='22222222';