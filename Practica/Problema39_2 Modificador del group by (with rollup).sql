USE Practica;

if object_id('notas') is not null
  drop table notas;

 create table notas(
  documento char(8) not null,
  materia varchar(30),
  nota decimal(4,2)
 );
GO

insert into notas values ('22333444','Programacion',8);
insert into notas values ('22333444','Programacion',9);
insert into notas values ('22333444','Ingles',8);
insert into notas values ('22333444','Ingles',7);
insert into notas values ('22333444','Ingles',6);
insert into notas values ('22333444','Sistemas de datos',10);
insert into notas values ('22333444','Sistemas de datos',9);

insert into notas values ('23444555','Programacion',5);
insert into notas values ('23444555','Programacion',4);
insert into notas values ('23444555','Programacion',3);
insert into notas values ('23444555','Ingles',9);
insert into notas values ('23444555','Ingles',7);
insert into notas values ('23444555','Sistemas de datos',9);

insert into notas values ('24555666','Programacion',1);
insert into notas values ('24555666','Programacion',3.5);
insert into notas values ('24555666','Ingles',4.5);
insert into notas values ('24555666','Sistemas de datos',6);
 GO

--4- Se necesita el promedio por alumno por materia y el promedio de cada alumno en todas las materias 
--cursadas hasta el momento (13 registros):
-- select documento,materia,
--  avg(nota) as promedio
--  from notas
--  group by documento,materia with rollup;
--Note que  hay 4 filas extras, 3 con el promedio de cada alumno y 1 con el promedio de todos los 
--alumnos de todas las materias.
SELECT documento, materia, AVG(nota) AS promedio FROM notas
GROUP BY documento, materia WITH ROLLUP;
--5- Compruebe los resultados parciales de la consulta anterior realizando otra consulta mostrando el 
--promedio de todas las carreras de cada alumno (4 filas)
SELECT documento, AVG(nota) AS promedio FROM notas
GROUP BY documento WITH ROLLUP;
--6- Muestre la cantidad de notas de cada alumno, por materia (9 filas)
SELECT documento, materia, COUNT(nota) AS promedio FROM notas
GROUP BY documento, materia;
--7- Realice la misma consulta anterior con resultados parciales incluidos (13 filas)
SELECT documento, materia, COUNT(nota) AS promedio FROM notas
GROUP BY documento, materia WITH ROLLUP;
--8- Muestre la nota menor y la mayor de cada alumno y la menor y mayor nota de todos (use "rollup") 
--(4 filas)
SELECT documento, MAX(nota) AS maximo, MIN(nota) AS Minimo FROM notas
GROUP BY documento WITH ROLLUP;