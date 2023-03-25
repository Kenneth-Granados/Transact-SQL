USE Practica;
GO

if object_id('Alumnos') is not null
  drop table Alumnos;
  GO
--2- Créela con los campos necesarios. Agregue una restricción "primary key" para el campo "documento" 
--y una "check" para validar que el campo "nota" se encuentre entre los valores 0 y 10:
 create table Alumnos(
  documento char(8),
  nombre varchar(30),
  nota decimal(4,2),
  primary key(documento),
  constraint CK_Alumnos_nota_valores check (nota>=0 and nota <=10),
 );
 GO
--3-Ingrese algunos registros:
 insert into Alumnos values('30111111','Ana Algarbe',5.1);
 insert into Alumnos values('30222222','Bernardo Bustamante',3.2);
 insert into Alumnos values('30333333','Carolina Conte',4.5);
 insert into Alumnos values('30444444','Diana Dominguez',9.7);
 insert into Alumnos values('30555555','Fabian Fuentes',8.5);
 insert into Alumnos values('30666666','Gaston Gonzalez',9.70);
 GO
--4- Obtenga todos los datos de los Alumnos con la nota más alta, empleando subconsulta.
--2 registros.
SELECT * FROM Alumnos
WHERE nota = (SELECT MAX(nota) FROM Alumnos)
GO
--5- Realice la misma consulta anterior pero intente que la consulta interna retorne, además del 
--máximo valor de nota, el nombre. 
SELECT * FROM Alumnos
WHERE nota = (SELECT MAX(nota),nombre FROM Alumnos)
--Mensaje de error, porque la lista de selección de una subconsulta que va luego de un operador de 
--comparación puede incluir sólo un campo o expresión (excepto si se emplea "exists" o "in").
GO
--6- Muestre los Alumnos que tienen una nota menor al promedio, su nota, y la diferencia con el 
--promedio.
--3 registros.
SELECT a.nombre,a.nota,(SELECT AVG(nota) FROM Alumnos) AS 'Diferencia con el promedio' FROM Alumnos AS a
WHERE a.nota < (SELECT AVG(nota) FROM Alumnos)
GO
--7- Cambie la nota del alumno que tiene la menor nota por 4.
--1 registro modificado.
UPDATE Alumnos SET nota=4
WHERE nota = (SELECT MIN(nota) FROM Alumnos)
--8- Elimine los Alumnos cuya nota es menor al promedio.
--3 registros eliminados.
DELETE FROM Alumnos 
WHERE nota < (SELECT AVG(nota) FROM Alumnos)