USE Practica;
GO

if object_id('Deportes') is not null
  drop table Deportes;
GO

 create table Deportes(
  nombre varchar(15),
  profesor varchar(30),
  dia varchar(10),
  cuota decimal(5,2),
 );
GO 
--3- Ingrese algunos registros. Incluya profesores que dicten más de un curso:
 insert into Deportes values('tenis','Ana Lopez','lunes',20);
 insert into Deportes values('natacion','Ana Lopez','martes',15);
 insert into Deportes values('futbol','Carlos Fuentes','miercoles',10);
 insert into Deportes values('basquet','Gaston Garcia','jueves',15);
 insert into Deportes values('padle','Juan Huerta','lunes',15);
 insert into Deportes values('handball','Juan Huerta','martes',10);
 GO
--4- Muestre los nombres de los profesores que dictan más de un deporte empleando subconsulta.
SELECT DISTINCT d1.profesor FROM Deportes AS d1
WHERE d1.profesor IN (SELECT d2.profesor FROM Deportes AS d2
WHERE d1.nombre <> d2.nombre);
GO
--5- Obtenga el mismo resultado empleando join.
SELECT DISTINCT d1.profesor FROM Deportes AS d1
INNER JOIN Deportes AS d2 ON d1.profesor= d2.profesor
WHERE d1.nombre <> d2.nombre;
GO
--6- Buscamos todos los Deportes que se dictan el mismo día que un determinado deporte (natacion) 
--empleando subconsulta.
SELECT d1.nombre FROM Deportes AS d1
WHERE d1.nombre LIKE 'natacion' AND d1.dia = (SELECT d2.dia FROM Deportes AS d2
WHERE d2.nombre LIKE 'natacion');
GO
--7- Obtenga la misma salida empleando "join".
SELECT  d1.nombre FROM Deportes AS d1
INNER JOIN Deportes AS d2 ON d1.dia=d2.dia
WHERE d2.nombre='natacion' AND d1.nombre<>d2.nombre