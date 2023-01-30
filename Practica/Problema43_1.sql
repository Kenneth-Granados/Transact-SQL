USE Practica;

if object_id('clientes') is not null
  drop table clientes;

 create table clientes (
  codigo int identity,
  nombre varchar(30) not null,
  domicilio varchar(30),
  ciudad varchar(20),
  provincia varchar (20),
  primary key(codigo)
);
GO

 insert into clientes
  values ('Lopez Marcos','Colon 111','Cordoba','Cordoba');
 insert into clientes
  values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba');
 insert into clientes
  values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba');
 insert into clientes
  values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe');
 insert into clientes
  values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba');
 insert into clientes
  values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe');
 insert into clientes
  values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba');
 insert into clientes
  values ('Lopez Carlos',null,'Cruz del Eje','Cordoba');
 insert into clientes
  values ('Ramos Betina','San Martin 999','Cordoba','Cordoba');
 insert into clientes
  values ('Lopez Lucas','San Martin 1010','Posadas','Misiones');
GO
--4- Obtenga las provincias sin repetir (3 registros)
SELECT DISTINCT provincia FROM clientes;
--5- Cuente las distintas provincias.
SELECT DISTINCT COUNT(provincia) AS Total FROM clientes;
--6- Se necesitan los nombres de las ciudades sin repetir (6 registros)
SELECT DISTINCT ciudad FROM clientes;
--7- Obtenga la cantidad de ciudades distintas.
SELECT DISTINCT COUNT(ciudad) AS Total FROM clientes;
--8- Combine con "where" para obtener las distintas ciudades de la provincia de Cordoba (3 registros)
SELECT DISTINCT ciudad FROM clientes
WHERE provincia LIKE 'Cordoba'
--9- Contamos las distintas ciudades de cada provincia empleando "group by" (3 regist
SELECT provincia, COUNT(DISTINCT ciudad) AS Cantidad FROM clientes
GROUP BY provincia