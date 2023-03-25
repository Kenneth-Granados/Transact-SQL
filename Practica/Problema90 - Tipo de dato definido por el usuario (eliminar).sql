USE Practica;
GO

if object_id ('Empleados') is not null
  drop table Empleados;

--2- Defina un nuevo tipo de dato llamado "tipo_año". Primero debe eliminarlo, si existe para volver a 
--crearlo:
 if exists (select *from systypes
  where name = 'tipo_año')
  exec sp_droptype tipo_año;
  GO
--3- Cree un tipo de dato definido por el usuario llamado "tipo_año" basado en el tipo "int" que 
--permita valores nulos:
 exec sp_addtype tipo_año, 'int','null';
 GO
--4- Elimine la regla llamada "RG_año" si existe:
 if object_id ('RG_año') is not null
   drop rule RG_año;
   GO
--5- Cree la regla que permita valores integer desde 1990 (fecha en que se inauguró el comercio) y el 
--año actual:
 create rule RG_año
  as @año between 1990 and datepart(year,getdate());
  GO
--6- Asocie la regla al tipo de datos "tipo_año":
 exec sp_bindrule RG_año, 'tipo_año';
GO
--7- Cree la tabla "Empleados" con un campo del tipo creado anteriormente:
 create table Empleados(
  documento char(8),
  nombre varchar(30),
  añoingreso tipo_año
 );
 GO
--8- Intente ingresar un registro con un valor inválido para el campo "añoingreso":
 insert into Empleados values('22222222','Juan Lopez',1980);
--No lo permite.
GO
--9- Ingrese un registro con un valor válido para el campo "añoingreso":
 insert into Empleados values('22222222','Juan Lopez',2000);
 GO
--10- Intente eliminar la regla asociada al tipo de datos:
 drop rule RG_año;
--No se puede porque está asociada a un tipo de datos.
GO
--11- Elimine la asociación:
 exec sp_unbindrule 'tipo_año';
GO
--12- Verifique que la asociación ha sido eliminada pero la regla sigue existiendo:
-- sp_helpconstraint Empleados;
 exec sp_help tipo_año;
 GO
--13- Elimine la regla:
 drop rule RG_año;
 GO
--14- Verifique que la regla ya no existe:
 exec sp_help RG_año;
 GO
--15- Ingrese el registro que no pudo ingresar en el punto 8:
 insert into Empleados values('22222222','Juan Lopez',1980);
--Lo permite porque el tipo de dato ya no tiene asociada la regla.
GO
--16- Intente eliminar el tipo de datos "tipo_año":
 exec sp_droptype tipo_año;
--No lo permite porque hay una tabla que lo utiliza.
GO
--17- Elimine la tabla "Empleados":
 drop table Empleados;
 GO
--18- Verifique que el tipo de dato "tipo_año" aún existe:
 exec sp_help tipo_año;
 GO
--19- Elimine el tipo de datos:
 exec sp_droptype tipo_año;
 GO
--20- Verifique que el tipo de dato "tipo_año" ya no existe:
 exec sp_help tipo_año;
GO
