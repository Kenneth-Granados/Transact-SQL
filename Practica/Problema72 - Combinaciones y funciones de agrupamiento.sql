USE Practica;
GO

if object_id('Visitantes') is not null
  drop table Visitantes;
 if object_id('Ciudades') is not null
  drop table Ciudades;
GO

create table Visitantes(
 nombre varchar(30),
 edad tinyint,
 sexo char(1) default 'f',
 domicilio varchar(30),
 codigociudad tinyint not null,
 mail varchar(30),
 montocompra decimal (6,2)
);

create table Ciudades(
 codigo tinyint identity,
 nombre varchar(20)
);
GO
--3- Ingrese algunos registros:
 insert into Ciudades values('Cordoba');
 insert into Ciudades values('Carlos Paz');
 insert into Ciudades values('La Falda');
 insert into Ciudades values('Cruz del Eje');

 insert into Visitantes values 
   ('Susana Molina', 35,'f','Colon 123', 1, null,59.80);
 insert into Visitantes values 
   ('Marcos Torres', 29,'m','Sucre 56', 1, 'marcostorres@hotmail.com',150.50);
 insert into Visitantes values 
   ('Mariana Juarez', 45,'f','San Martin 111',2,null,23.90);
 insert into Visitantes values 
   ('Fabian Perez',36,'m','Avellaneda 213',3,'fabianperez@xaxamail.com',0);
 insert into Visitantes values 
   ('Alejandra Garcia',28,'f',null,2,null,280.50);
 insert into Visitantes values 
   ('Gaston Perez',29,'m',null,5,'gastonperez1@gmail.com',95.40);
 insert into Visitantes values 
   ('Mariana Juarez',33,'f',null,2,null,90);
GO
--4- Cuente la cantidad de visitas por ciudad mostrando el nombre de la ciudad (3 filas)
SELECT c.nombre AS CIUDAD,COUNT(*) AS 'Cantidad de visitantes' FROM Ciudades AS c
INNER JOIN Visitantes AS v ON c.codigo = v.codigociudad
GROUP BY c.nombre;
GO
--5- Muestre el promedio de gastos de las visitas agrupados por ciudad y sexo (4 filas)
SELECT c.nombre,v.sexo AS CIUDAD,AVG(v.montocompra) AS 'Promedio de compras' FROM Ciudades AS c
INNER JOIN Visitantes AS v ON c.codigo = v.codigociudad
GROUP BY c.nombre,v.sexo;
GO
--6- Muestre la cantidad de Visitantes con mail, agrupados por ciudad (3 filas)
SELECT c.nombre AS CIUDAD,COUNT(v.mail) AS 'Cantidad de visitantes con e-mail' FROM Ciudades AS c
INNER JOIN Visitantes AS v ON c.codigo = v.codigociudad
GROUP BY c.nombre;
GO
--7- Obtenga el monto de compra más alto de cada ciudad (3 filas)
SELECT c.nombre AS CIUDAD,MAX(v.montocompra) AS 'Cantidad de visitantes' FROM Ciudades AS c
INNER JOIN Visitantes AS v ON c.codigo = v.codigociudad
GROUP BY c.nombre;
GO