USE Practica;

if object_id('clientes') is not null
  drop table clientes;

 create table clientes (
  codigo int identity,
  nombre varchar(30) not null,
  domicilio varchar(30),
  ciudad varchar(20),
  estado varchar (20),
  pais varchar(20),
  primary key(codigo)
 );
GO

 insert into clientes
  values ('Lopez Marcos','Colon 111', 'Cordoba','Cordoba','Argentina');
 insert into clientes
  values ('Perez Ana','San Martin 222', 'Carlos Paz','Cordoba','Argentina');
 insert into clientes
  values ('Garcia Juan','Rivadavia 333', 'Carlos Paz','Cordoba','Argentina');
 insert into clientes
  values ('Perez Luis','Sarmiento 444', 'Rosario','Santa Fe','Argentina');
 insert into clientes
  values ('Gomez Ines','San Martin 987', 'Santa Fe','Santa Fe','Argentina');
 insert into clientes
  values ('Gomez Ines','San Martin 666', 'Santa Fe','Santa Fe','Argentina');
 insert into clientes
  values ('Lopez Carlos','Irigoyen 888', 'Cordoba','Cordoba','Argentina');
 insert into clientes
  values ('Ramos Betina','San Martin 999', 'Cordoba','Cordoba','Argentina');
 insert into clientes
  values ('Fernando Salas','Mariano Osorio 1234', 'Santiago','Region metropolitana','Chile');
 insert into clientes
  values ('German Rojas','Allende 345', 'Valparaiso','Region V','Chile');
 insert into clientes
  values ('Ricardo Jara','Pablo Neruda 146', 'Santiago','Region metropolitana','Chile');
 insert into clientes
  values ('Joaquin Robles','Diego Rivera 147', 'Guadalajara','Jalisco','Mexico');
  GO

--4- Necesitamos la cantidad de clientes por país y la cantidad total de clientes en una sola consulta 
--(4 filas)
--Note que la consulta retorna los registros agrupados por pais y una fila extra en la que la columna 
--"pais" contiene "null" y la columna con la cantidad muestra la cantidad total.
SELECT pais, COUNT(*) AS cantidad FROM clientes
GROUP BY pais
WITH ROLLUP;
--5- Necesitamos la cantidad de clientes agrupados por pais y estado, incluyendo resultados paciales 
--(9 filas)
--Note que la salida muestra los totales por pais y estado y produce 4 filas extras: 3 muestran los 
--totales para cada pais, con la columna "estado" conteniendo "null" y 1 muestra el total de todos los 
--clientes, con las columnas "pais" y "estado" conteniendo "null".
SELECT pais, estado,COUNT(*) AS cantidad FROM clientes
GROUP BY pais, estado
WITH ROLLUP;
--6- Necesitamos la cantidad de clientes agrupados por pais, estado y ciudad, empleando "rollup" (16 
--filas)
--El resultado muestra los totales por pais, estado y ciudad y genera 9 filas extras: 5 muestran los 
--totales para cada estado, con la columna correspondiente a "ciudad" conteniendo "null", 3 muestran 
--los totales para cada pais, con las columnas "ciudad" y "estado" conteniendo "null" y 1 muestra el 
--total de todos los clientes, con las columnas "pais", "estado" y "ciudad" conteniendo "null".
SELECT pais, estado, ciudad, COUNT(*) AS cantidad FROM clientes
GROUP BY pais, estado, ciudad
WITH ROLLUP;