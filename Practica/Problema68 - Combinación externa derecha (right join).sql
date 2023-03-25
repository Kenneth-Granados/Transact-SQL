USE Practica;
GO

if (object_id('Clientes')) is not null drop table Clientes;
if (object_id('Provincias')) is not null drop table Provincias;
GO

create table Clientes ( 
codigo int identity, 
nombre varchar(30), 
domicilio varchar(30),
ciudad varchar(20),
codigoprovincia tinyint not null,
primary key(codigo) );

create table Provincias( 
codigo tinyint identity, 
nombre varchar(20), 
primary key (codigo) );
GO
--3- Ingrese algunos registros para ambas tablas: 
insert into Provincias (nombre) values('Cordoba');
insert into Provincias (nombre) values('Santa Fe');
insert into Provincias (nombre) values('Corrientes');
insert into Clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
insert into Clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
insert into Clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
insert into Clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
insert into Clientes values ('Gomez Ines','San Martin 666','Santa Fe',2); 
insert into Clientes values ('Torres Fabiola','Alem 777','La Plata',4);
insert into Clientes values ('Garcia Luis','Sucre 475','Santa Rosa',5);
GO

--3- Muestre todos los datos de los clientes, incluido el nombre de la provincia empleando un "right join".
SELECT c.nombre,domicilio,ciudad, p.nombre FROM Provincias AS p 
RIGHT JOIN Clientes AS c on c.codigoprovincia = p.codigo;
GO
--4- Obtenga la misma salida que la consulta anterior pero empleando un "left join".
SELECT c.nombre,domicilio,ciudad, p.nombre FROM Provincias AS p 
LEFT JOIN Clientes AS c on c.codigoprovincia = p.codigo;
GO
--5- Empleando un "right join", muestre solamente los clientes de las provincias que existen en "provincias" (5 registros)
SELECT c.nombre,domicilio,ciudad, p.nombre FROM Provincias AS p 
RIGHT JOIN Clientes AS c on c.codigoprovincia = p.codigo
WHERE p.codigo IS NOT NULL;
GO
--6- Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por ciudad (2 registros)
SELECT c.nombre,domicilio,ciudad, p.nombre FROM Provincias AS p 
RIGHT JOIN Clientes AS c on c.codigoprovincia = p.codigo
WHERE p.codigo IS  NULL
ORDER BY c.ciudad;
GO