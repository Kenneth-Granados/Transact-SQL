USE Practica;
GO

if object_id('Clientes') is not null
  drop table Clientes;
 if object_id('Proveedores') is not null
  drop table Proveedores;
 if object_id('Empleados') is not null
  drop table Empleados;
GO

 create table Proveedores(
  codigo int identity,
  nombre varchar (30),
  domicilio varchar(30),
  primary key(codigo)
 );
 create table Clientes(
  codigo int identity,
  nombre varchar (30),
  domicilio varchar(30),
  primary key(codigo)
 );
 create table Empleados(
  documento char(8) not null,
  nombre varchar(20),
  apellido varchar(20),
  domicilio varchar(30),
  primary key(documento)
 );
GO

 insert into Proveedores values('Bebida cola','Colon 123');
 insert into Proveedores values('Carnes Unica','Caseros 222');
 insert into Proveedores values('Lacteos Blanca','San Martin 987');
 insert into Clientes values('Supermercado Lopez','Avellaneda 34');
 insert into Clientes values('Almacen Anita','Colon 987');
 insert into Clientes values('Garcia Juan','Sucre 345');
 insert into Empleados values('23333333','Federico','Lopez','Colon 987');
 insert into Empleados values('28888888','Ana','Marquez','Sucre 333');
 insert into Empleados values('30111111','Luis','Perez','Caseros 956');
GO
--4- El supermercado quiere enviar una tarjeta de salutación a todos los Proveedores, Clientes y 
--Empleados y necesita el nombre y domicilio de todos ellos. Emplee el operador "union" para obtener 
--dicha información de las tres tablas.
SELECT p.nombre,p.domicilio FROM Proveedores As p
UNION SELECT c.nombre,c.domicilio FROM Clientes AS c
UNION SELECT e.nombre,e.domicilio FROM Empleados AS e
GO
--5- Agregue una columna con un literal para indicar si es un proveedor, un cliente o un empleado y 
--ordene por dicha columna.
SELECT p.nombre,p.domicilio,'Proveedor' AS 'Dirigido a' FROM Proveedores As p
UNION SELECT c.nombre,c.domicilio,'Clientes' AS 'Dirigido a' FROM Clientes AS c
UNION SELECT e.nombre,e.domicilio,'Empleados' AS 'Dirigido a' FROM Empleados AS e
ORDER BY 'Dirigido a'
GO