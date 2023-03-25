USE Practica;
GO

if object_id ('Empleados') is not null
  drop table Empleados;

--2- Defina un nuevo tipo de dato llamado "tipo_a�o". Primero debe eliminarlo, si existe para volver a 
--crearlo:
 if exists (select *from systypes
  where name = 'tipo_a�o')
  exec sp_droptype tipo_a�o;
  GO
--3- Cree un tipo de dato definido por el usuario llamado "tipo_a�o" basado en el tipo "int" que 
--permita valores nulos:
 exec sp_addtype tipo_a�o, 'int','null';
 GO
--4- Elimine la regla llamada "RG_a�o" si existe:
 if object_id ('RG_a�o') is not null
   drop rule RG_a�o;
   GO
--5- Cree la regla que permita valores integer desde 1990 (fecha en que se inaugur� el comercio) y el 
--a�o actual:
 create rule RG_a�o
  as @a�o between 1990 and datepart(year,getdate());
  GO
--6- Asocie la regla al tipo de datos "tipo_a�o":
 exec sp_bindrule RG_a�o, 'tipo_a�o';
GO
--7- Cree la tabla "Empleados" con un campo del tipo creado anteriormente:
 create table Empleados(
  documento char(8),
  nombre varchar(30),
  a�oingreso tipo_a�o
 );
 GO
--8- Intente ingresar un registro con un valor inv�lido para el campo "a�oingreso":
 insert into Empleados values('22222222','Juan Lopez',1980);
--No lo permite.
GO
--9- Ingrese un registro con un valor v�lido para el campo "a�oingreso":
 insert into Empleados values('22222222','Juan Lopez',2000);
 GO
--10- Intente eliminar la regla asociada al tipo de datos:
 drop rule RG_a�o;
--No se puede porque est� asociada a un tipo de datos.
GO
--11- Elimine la asociaci�n:
 exec sp_unbindrule 'tipo_a�o';
GO
--12- Verifique que la asociaci�n ha sido eliminada pero la regla sigue existiendo:
-- sp_helpconstraint Empleados;
 exec sp_help tipo_a�o;
 GO
--13- Elimine la regla:
 drop rule RG_a�o;
 GO
--14- Verifique que la regla ya no existe:
 exec sp_help RG_a�o;
 GO
--15- Ingrese el registro que no pudo ingresar en el punto 8:
 insert into Empleados values('22222222','Juan Lopez',1980);
--Lo permite porque el tipo de dato ya no tiene asociada la regla.
GO
--16- Intente eliminar el tipo de datos "tipo_a�o":
 exec sp_droptype tipo_a�o;
--No lo permite porque hay una tabla que lo utiliza.
GO
--17- Elimine la tabla "Empleados":
 drop table Empleados;
 GO
--18- Verifique que el tipo de dato "tipo_a�o" a�n existe:
 exec sp_help tipo_a�o;
 GO
--19- Elimine el tipo de datos:
 exec sp_droptype tipo_a�o;
 GO
--20- Verifique que el tipo de dato "tipo_a�o" ya no existe:
 exec sp_help tipo_a�o;
GO
