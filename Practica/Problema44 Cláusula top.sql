USE Practica;

if object_id('empleados') is not null
  drop table empleados;
GO

 create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  estadocivil char(1),--c=casado, s=soltero,v=viudo
  seccion varchar(20)
 );
GO

 insert into empleados
  values ('22222222','Alberto Lopez','c','Sistemas');
 insert into empleados
  values ('23333333','Beatriz Garcia','c','Administracion');
 insert into empleados
  values ('24444444','Carlos Fuentes','s','Administracion');
 insert into empleados
  values ('25555555','Daniel Garcia','s','Sistemas');
 insert into empleados
  values ('26666666','Ester Juarez','c','Sistemas');
 insert into empleados
  values ('27777777','Fabian Torres','s','Sistemas');
 insert into empleados
  values ('28888888','Gabriela Lopez',null,'Sistemas');
 insert into empleados
  values ('29999999','Hector Garcia',null,'Administracion');
GO
--4- Muestre los 5 primeros registros (5 registros)
SELECT TOP 5 * FROM empleados
--5- Muestre nombre y seccion de los 4 primeros registros ordenados por sección (4 registros)
SELECT TOP 4 nombre,seccion FROM empleados
ORDER BY seccion 
--6- Realice la misma consulta anterior pero incluya todos los registros que tengan el mismo valor en 
--"seccion" que el último (8 registros)
SELECT TOP 4 WITH TIES nombre,seccion FROM empleados
ORDER BY seccion 
--7- Muestre nombre, estado civil y seccion de los primeros 4 empleados ordenados por estado civil y 
--sección (4 registros)
SELECT TOP 4 nombre,estadocivil,seccion FROM empleados
ORDER BY estadocivil,seccion 
--8- Realice la misma consulta anterior pero incluya todos los valores iguales al último registro 
--retornado (5 registros)
SELECT TOP 4 WITH TIES nombre,estadocivil,seccion FROM empleados
ORDER BY estadocivil,seccion 