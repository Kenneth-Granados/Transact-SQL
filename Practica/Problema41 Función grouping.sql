USE Practica;

if object_id('empleados') is not null
  drop table empleados;

 create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  sexo char(1),
  estadocivil char(1),--c=casado, s=soltero,v=viudo
  seccion varchar(20),
  primary key (documento)
 );
GO

 insert into empleados
  values ('22222222','Alberto Lopez','m','c','Sistemas');
 insert into empleados
  values ('23333333','Beatriz Garcia','f','c','Administracion');
 insert into empleados
  values ('24444444','Carlos Fuentes','m','s','Administracion');
 insert into empleados
  values ('25555555','Daniel Garcia','m','s','Sistemas');
 insert into empleados
  values ('26666666','Ester Juarez',null,'c','Sistemas');
 insert into empleados
  values ('27777777','Fabian Torres',null,'s','Sistemas');
 insert into empleados
  values ('28888888','Gabriela Lopez','f',null,'Sistemas');
 insert into empleados
  values ('29999999','Hector Garcia','m',null,'Administracion');
GO
--4- Cuente la cantidad de empleados agrupados por sexo y estado civil, empleando "rollup".
--Es dificil distinguir los valores de detalle y resumen.
SELECT sexo, estadocivil, COUNT(*) AS Total FROM empleados
GROUP BY sexo, estadocivil
WITH ROLLUP
--5- Realice la misma consulta anterior pero emplee la función "grouping" para los dos campos por los 
--que se agrupa para distinguir los valores de resumen y de detalle.
--Note que las columnas de resumen contienen 1 y las de detalle 0.
SELECT sexo, estadocivil, COUNT(*) AS Total,GROUPING(sexo) AS R1, GROUPING(estadocivil) AS R2 FROM empleados
GROUP BY sexo, estadocivil
WITH ROLLUP
--6- Realice la misma consulta anterior pero con "cube" en lugar de "rollup", distinguiendo los 
--valores de resumen y de detalle.
--Note que las columnas de resumen contienen 1 y las de detalle 0.
SELECT sexo, estadocivil, COUNT(*) AS Total,GROUPING(sexo) AS R1, GROUPING(estadocivil) AS R2 FROM empleados
GROUP BY sexo, estadocivil
WITH CUBE