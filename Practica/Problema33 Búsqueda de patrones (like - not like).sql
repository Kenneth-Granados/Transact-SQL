USE Practica;

if object_id('Empleados') is not null
  drop table empleados;
GO
SET DATEFORMAT ymd;

 create table empleados(
  nombre varchar(30),
  documento char(8),
  domicilio varchar(30),
  fechaingreso datetime,
  seccion varchar(20),
  sueldo decimal(6,2),
  primary key(documento)
 );
 GO

 insert into empleados
  values('Juan Perez','22333444','Colon 123','1990-10-08','Gerencia',900.50);
 insert into empleados
  values('Ana Acosta','23444555','Caseros 987','1995-12-18','Secretaria',590.30);
 insert into empleados
  values('Lucas Duarte','25666777','Sucre 235','2005-05-15','Sistemas',790);
 insert into empleados
  values('Pamela Gonzalez','26777888','Sarmiento 873','1999-02-12','Secretaria',550);
 insert into empleados
  values('Marcos Juarez','30000111','Rivadavia 801','2002-09-22','Contaduria',630.70);
 insert into empleados
  values('Yolanda Perez','35111222','Colon 180','1990-10-08','Administracion',400);
 insert into empleados
  values('Rodolfo Perez','35555888','Coronel Olmedo 588','1990-05-28','Sistemas',800);

--4- Muestre todos los empleados con apellido "Perez" empleando el operador "like" (3 registros)
SELECT nombre FROM empleados
WHERE nombre LIKE '%Perez%';
GO
--5- Muestre todos los empleados cuyo domicilio comience con "Co" y tengan un "8" (2 registros)
SELECT domicilio FROM empleados
WHERE domicilio LIKE 'Co%'
GO
--6- Seleccione todos los empleados cuyo documento finalice en 0,2,4,6 u 8 (4 registros)
SELECT documento FROM empleados
WHERE documento LIKE '%[02468]'
GO
--7- Seleccione todos los empleados cuyo documento NO comience con 1 ni 3 y cuyo nombre finalice en 
--"ez" (2 registros)
SELECT nombre,documento FROM empleados
WHERE documento LIKE '[^13]%' AND nombre LIKE '%ez'
GO
--8- Recupere todos los nombres que tengan una "y" o una "j" en su nombre o apellido (3 registros)
SELECT nombre FROM empleados
WHERE nombre LIKE '%[yj]%' 
GO
--9- Muestre los nombres y sección de los empleados que pertenecen a secciones que comiencen con "S" o 
--"G" y tengan 8 caracteres (3 registros)
SELECT nombre,seccion FROM empleados
WHERE LEN(seccion)=8 AND seccion LIKE '[SG]%'
GO
--10- Muestre los nombres y sección de los empleados que pertenecen a secciones que NO comiencen con 
--"S" o "G" (2 registros)
SELECT nombre,seccion FROM empleados
WHERE seccion LIKE '[^SG]%'
GO
--11- Muestre todos los nombres y sueldos de los empleados cuyos sueldos incluyen centavos (3 
--registros)
SELECT nombre,sueldo FROM empleados
WHERE sueldo NOT LIKE '%.00'
GO
--12- Muestre los empleados que hayan ingresado en "1990" (3 registros)
SELECT nombre FROM empleados
WHERE fechaingreso LIKE '%1990%'
GO

--Así como "%" reemplaza cualquier cantidad de caracteres, el guión bajo "_" reemplaza un caracter, es otro caracter comodín. 
--Por ejemplo, queremos ver los libros de "Lewis Carroll" pero no recordamos si se escribe "Carroll" o "Carrolt", entonces tipeamos esta condición:
--select * from libros where autor like "%Carrol_"; 
--Otro caracter comodín es [] reemplaza cualquier carácter contenido en el conjunto especificado dentro de los corchetes. Para seleccionar los libros 
--cuya editorial comienza con las letras entre la "P" y la "S" usamos la siguiente sintaxis: 
-- select titulo,autor,editorial from libros where editorial like '[P-S]%'; --Ejemplos: 
--... like '[a-cf-i]%': busca cadenas que comiencen con a,b,c,f,g,h o i; 
--... like '[-acfi]%': busca cadenas que comiencen con -,a,c,f o i;
--... like 'A[_]9%': busca cadenas que comiencen con 'A_9'; 
--... like 'A[nm]%': busca cadenas que comiencen con 'An' o 'Am'.
