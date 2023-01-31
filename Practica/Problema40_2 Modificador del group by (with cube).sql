 USE Practica;
 
 if object_id('visitantes') is not null
  drop table visitantes;

 create table visitantes(
  nombre varchar(30),
  edad tinyint,
  sexo char(1),
  domicilio varchar(30),
  ciudad varchar(20),
  mail varchar(30) default 'no tiene',
  montocompra decimal(6,2)
 );
GO

 insert into visitantes
  values ('Susana Molina',28,'f',null,'Cordoba',null,45.50); 
 insert into visitantes
  values ('Marcela Mercado',36,'f','Avellaneda 345','Cordoba',default,22.40);
 insert into visitantes
  values ('Alberto Garcia',35,'m',default,'Alta Gracia','albertogarcia@hotmail.com',25); 
 insert into visitantes
  values ('Teresa Garcia',33,'f',default,'Alta Gracia',default,120);
 insert into visitantes
  values ('Roberto Perez',45,'m',null,'Cordoba','robertoperez@xaxamail.com',33.20);
 insert into visitantes
  values ('Marina Torres',22,'f',null,'Villa Dolores',default,95);
 insert into visitantes
  values ('Julieta Gomez',24,'f','San Martin 333','Alta Gracia','julietagomez@gmail.com',53.50);
 insert into visitantes
  values ('Roxana Lopez',20,'f','null','Alta Gracia',default,240);
 insert into visitantes
  values ('Liliana Garcia',50,'f','Paso 999','Cordoba',default,48);
 insert into visitantes
  values ('Juan Torres',43,'m','Sarmiento 876','Cordoba',null,15.30);
GO
--4- Agrupe por sexo y ciudad y calcule el total de la compra empleando "rollup" y luego "cube":
SELECT sexo, ciudad, SUM(montocompra) AS total FROM visitantes
GROUP BY sexo, ciudad
WITH ROLLUP;
--Se generan 2 filas con "ciudad" conteniendo "null" y 1 fila con ambos campos seteados a "null".
 select sexo,ciudad,
  sum(montocompra) as total
  from visitantes
  group by sexo,ciudad
  with cube;
--Se generan 2 filas con "ciudad" conteniendo "null" (total de sexo femenino y masculino); 1 fila con 
--ambos campos seteados a "null" (monto total de todos los visitantes) y 3 filas con "sexo" 
--conteniendo "null" (monto total de cada ciudad). 

--5- Calcule la edad promedio de los visitantes agrupando por sexo y ciudad, sin considerar los que no 
--tienen mail, use ambos modificadores de "group by" ("rollup" y "cube"):
 select sexo,ciudad,
  avg(edad) as 'edad promedio'
  from visitantes
  where mail is not null and
  mail <>'no tiene'
  group by sexo,ciudad
  with rollup;
--Se generan 2 filas con el promedio de edad por sexo de cada ciudad y 1 fila con el promedio de edad 
--de todos los visitantes.
 select sexo,ciudad,
  avg(edad) as 'edad promedio'
  from visitantes
  where mail is not null and
  mail <>'no tiene'
  group by sexo,ciudad
  with cube;
--Se generan 2 filas con el promedio de edad por sexo de cada ciudad, 1 fila con el promedio de edad 
--de todos los visitantes y 3 filas con el promedio de edad por ciudad.
