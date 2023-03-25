USE Practica;
GO

--any" y "some" son sinónimos. Chequean si alguna fila de la lista resultado de una subconsulta se encuentra el valor especificado en la condición.

if object_id('Inscriptos') is not null
  drop table Inscriptos;
 if object_id('Socios') is not null
  drop table Socios;
GO
--2- Cree las tablas:
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
  cuotas tinyint
  constraint CK_Inscriptos_cuotas
   check (cuotas>=0 and cuotas<=10)
  constraint DF_Inscriptos_cuotas default 0,
  primary key(numerosocio,deporte),
  constraint FK_Inscriptos_socio
   foreign key (numerosocio)
   references Socios(numero)
   on update cascade
   on delete cascade,
 );
GO
--3- Ingrese algunos registros:
 insert into Socios values('23333333','Alberto Paredes','Colon 111');
 insert into Socios values('24444444','Carlos Conte','Sarmiento 755');
 insert into Socios values('25555555','Fabian Fuentes','Caseros 987');
 insert into Socios values('26666666','Hector Lopez','Sucre 344');

 insert into Inscriptos values(1,'tenis',1);
 insert into Inscriptos values(1,'basquet',2);
 insert into Inscriptos values(1,'natacion',1);
 insert into Inscriptos values(2,'tenis',9);
 insert into Inscriptos values(2,'natacion',1);
 insert into Inscriptos values(2,'basquet',default);
 insert into Inscriptos values(2,'futbol',2);
 insert into Inscriptos values(3,'tenis',8);
 insert into Inscriptos values(3,'basquet',9);
 insert into Inscriptos values(3,'natacion',0);
 insert into Inscriptos values(4,'basquet',10);
GO
--4- Muestre el número de socio, el nombre del socio y el deporte en que está inscripto con un join de 
--ambas tablas.
SELECT s.numero,s.nombre,i.deporte FROM Socios AS s
INNER JOIN Inscriptos As i ON i.numerosocio = s.numero
GO
--5- Muestre los Socios que se serán compañeros en tenis y también en natación (empleando 
--subconsulta)
--3 filas devueltas.
SELECT s.nombre FROM Socios AS s
INNER JOIN Inscriptos As i ON s.numero = i.numerosocio
WHERE i.deporte = 'natacion' AND s.numero = ANY 
(SELECT i.numerosocio FROM Inscriptos AS i
WHERE i.deporte = 'tenis');
GO

--6- vea si el socio 1 se ha inscripto en algún deporte en el cual se haya inscripto el socio 2.
--3 filas.
SELECT i.deporte FROM Inscriptos As i 
WHERE i.numerosocio = 1 AND i.deporte = ANY 
(SELECT i.deporte FROM Inscriptos AS i
WHERE i.numerosocio=2);
GO
--7- Obtenga el mismo resultado anterior pero empleando join.
SELECT i.deporte FROM Inscriptos As i 
INNER JOIN Inscriptos AS i1 ON i.deporte = i1.deporte
WHERE i.numerosocio = 1 AND i1.numerosocio = 2;
GO
--8- Muestre los deportes en los cuales el socio 2 pagó más cuotas que ALGUN deporte en los que se 
--inscribió el socio 1.
--2 registros.
SELECT i.deporte FROM Inscriptos As i 
WHERE i.numerosocio = 2 AND i.cuotas > ANY 
(SELECT i.cuotas FROM Inscriptos AS i
WHERE i.numerosocio=1);
GO
--9- Muestre los deportes en los cuales el socio 2 pagó más cuotas que TODOS los deportes en que se 
--inscribió el socio 1.
--1 registro.
SELECT i.deporte FROM Inscriptos As i 
WHERE i.numerosocio = 2 AND i.cuotas > ALL 
(SELECT i.cuotas FROM Inscriptos AS i
WHERE i.numerosocio=1);
GO
--10- Cuando un socio no ha pagado la matrícula de alguno de los deportes en que se ha inscripto, se 
--lo borra de la inscripción de todos los deportes. Elimine todos los Socios que no pagaron ninguna 
--cuota en algún deporte.
--7 registros.
DELETE FROM Inscriptos 
WHERE numerosocio = ANY (
SELECT numerosocio FROM Inscriptos
WHERE cuotas = 0);
GO