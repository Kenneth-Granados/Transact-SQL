USE Practica;
GO

if object_id('Empleados') is not null
  drop table Empleados;

 create table Empleados(
  apellido varchar(20),
  nombre varchar(20),
  domicilio varchar(30),
  fechaingreso datetime
 );
 GO
 insert into Empleados(apellido,nombre) values ('Rodriguez','Pablo');

--2- Agregue el campo "sueldo", de tipo decimal(5,2).
ALTER TABLE Empleados
ADD Sueldo DECIMAL(5,2);
GO
--3- Verifique que la estructura de la tabla ha cambiado.
EXEC sp_columns Empleados;
--4- Agregue un campo "codigo", de tipo int con el atributo "identity".
ALTER TABLE Empleados
ADD Codigo INT IDENTITY;
GO
--5- Intente agregar un campo "documento" no nulo.
ALTER TABLE Empleados
ADD Documento CHAR(8) NOT NULL;
--No es posible, porque SQL Server no permite agregar campos "not null" a menos que se especifique un 
--valor por defecto.
GO

--6- Agregue el campo del punto anterior especificando un valor por defecto:
 alter table Empleados
  add documento char(8) not null default '00000000';
GO
--7- Verifique que la estructura de la tabla ha cambiado.
EXEC sp_columns Empleados;
--8- Elimine el campo "sueldo".
ALTER TABLE Empleados
DROP COLUMN Sueldo;
GO
--9- Verifique la eliminación:
 exec sp_columns Empleados;

--10- Intente eliminar el campo "documento".
--no lo permite.
ALTER TABLE Empleados
DROP COLUMN Documento;
GO
--11- Elimine los campos "codigo" y "fechaingreso" en una sola sentencia.
ALTER TABLE Empleados
DROP COLUMN codigo,fechaingreso;
GO
--12- Verifique la eliminación de los campos:
 exec sp_columns Empleados;
