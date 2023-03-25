USE Practica;
GO

if object_id('Empleados') is not null
  drop table Empleados;

 create table Empleados(
  legajo int not null,
  documento char(7) not null,
  nombre varchar(10),
  domicilio varchar(30),
  ciudad varchar(20) default 'Buenos Aires',
  sueldo decimal(6,2),
  cantidadhijos tinyint default 0,
  primary key(legajo)
 );
GO
--2- Modifique el campo "nombre" extendiendo su longitud.
ALTER TABLE Empleados
ALTER COLUMN nombre VARCHAR(30);
GO
--3- Controle la modificación:
EXEC sp_columns Empleados;
GO
--4- Modifique el campo "sueldo" para que no admita valores nulos.
ALTER TABLE Empleados
ALTER COLUMN sueldo DECIMAL(6,2) NOT NULL;
GO
--4- Modifique el campo "documento" ampliando su longitud a 8 caracteres.
ALTER TABLE Empleados
ALTER COLUMN documento CHAR(8);
GO
--5- Intente modificar el tipo de datos del campo "legajo" a "tinyint":
 alter table Empleados
  alter column legajo tinyint not null;
--No se puede porque tiene una restricción.
GO
--6- Ingrese algunos registros, uno con "nombre" nulo:
 insert into Empleados values(1,'22222222','Juan Perez','Colon 123','Cordoba',500,3);
 insert into Empleados values(2,'30000000',null,'Sucre 456','Cordoba',600,2);
 GO
--7- Intente modificar el campo "nombre" para que no acepte valores nulos:
 alter table Empleados
  alter column nombre varchar(30) not null;
--No se puede porque hay registros con ese valor.
GO
--8- Elimine el registro con "nombre" nulo y realice la modificación del punto 7:
 delete from Empleados where nombre is null;
 alter table Empleados
  alter column nombre varchar(30) not null;
  GO
--9- Modifique el campo "ciudad" a 10 caracteres.
ALTER TABLE Empleados
ALTER COLUMN ciudad VARCHAR(10);
GO
--10- Intente agregar un registro con el valor por defecto para "ciudad":
 insert into Empleados values(3,'33333333','Juan Perez','Sarmiento 856',default,500,4);
--No se puede porque el campo acepta 10 caracteres y  el valor por defecto tiene 12 caracteres.
GO
--11- Modifique el campo "ciudad" sin que afecte la restricción dándole una longitud de 15 caracteres.
ALTER TABLE Empleados
ALTER COLUMN ciudad VARCHAR(15);
GO
--12- Agregue el registro que no pudo ingresar en el punto 10:
 insert into Empleados values(3,'33333333','Juan Perez','Sarmiento 856',default,500,4);
 GO
--13- Intente agregar el atributo identity de "legajo".
ALTER TABLE Empleados
ALTER COLUMN legajo INT IDENTITY;
--No se puede agregar este atributo.
GO