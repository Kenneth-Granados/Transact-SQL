USE Practica;
GO

if (object_id('Ciudades')) is not null
   drop table Ciudades;
  if (object_id('Clientes')) is not null
   drop table Clientes;
GO
--2- Cree la tabla "Clientes" (codigo, nombre, domicilio, ciudad, codigociudad) y "Ciudades" (codigo, 
--nombre). Agregue una restricción "primary key" para el campo "codigo" de ambas tablas y una "foreing 
--key" para validar que el campo "codigociudad" exista en "Ciudades" con actualización en cascada:
 create table Ciudades(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

 create table Clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  codigociudad tinyint not null,
  primary key(codigo),
  constraint FK_Clientes_ciudad
   foreign key (codigociudad)
   references Ciudades(codigo)
   on update cascade,
 );
 GO
--3- Ingrese algunos registros para ambas tablas:
 insert into Ciudades (nombre) values('Cordoba');
 insert into Ciudades (nombre) values('Cruz del Eje');
 insert into Ciudades (nombre) values('Carlos Paz');
 insert into Ciudades (nombre) values('La Falda');
 insert into Ciudades (nombre) values('Villa Maria');

 insert into Clientes values ('Lopez Marcos','Colon 111',1);
 insert into Clientes values ('Lopez Hector','San Martin 222',1);
 insert into Clientes values ('Perez Ana','San Martin 333',2);
 insert into Clientes values ('Garcia Juan','Rivadavia 444',3);
 insert into Clientes values ('Perez Luis','Sarmiento 555',3);
 insert into Clientes values ('Gomez Ines','San Martin 666',4);
 insert into Clientes values ('Torres Fabiola','Alem 777',5);
 insert into Clientes values ('Garcia Luis','Sucre 888',5);
 GO
--4- Necesitamos conocer los nombres de las Ciudades de aquellos Clientes cuyo domicilio es en calle 
--"San Martin", empleando subconsulta.
--3 registros.
SELECT c.nombre FROM Ciudades AS c
WHERE c.codigo IN (SELECT cl.codigociudad FROM Clientes AS cl
WHERE cl.domicilio LIKE 'San Martin %');
GO
--5- Obtenga la misma salida anterior pero empleando join.
SELECT DISTINCT c.nombre FROM Ciudades AS c
JOIN Clientes AS cl ON c.codigo = cl.codigociudad
WHERE cl.domicilio LIKE 'San Martin %';
GO
--6- Obtenga los nombre de las Ciudades de los Clientes cuyo apellido no comienza con una letra 
--específica, empleando subconsulta.
--2 registros.
SELECT c.nombre FROM Ciudades AS c
WHERE c.codigo NOT IN (SELECT cl.codigociudad FROM Clientes AS cl
WHERE cl.nombre LIKE 'L%');
GO
--7- Pruebe la subconsulta del punto 6 separada de la consulta exterior para verificar que retorna una 
--lista de valores de un solo campo.
SELECT cl.codigociudad FROM Clientes AS cl
WHERE cl.nombre LIKE 'L%';
GO
