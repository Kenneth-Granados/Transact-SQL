USE Practica;
GO

if object_id ('Empleados') is not null
  drop table Empleados;
 if object_id ('Clientes') is not null
  drop table Clientes;
  GO
--2- Defina un nuevo tipo de dato llamado "tipo_año". Primero debe eliminarlo, si existe, para volver 
--a crearlo. Para ello emplee esta sentencia que explicaremos en el siguiente capítulo:
 if exists (select *from systypes
  where name = 'tipo_año')
   exec sp_droptype tipo_año;
GO
--3- Cree un tipo de dato definido por el usuario llamado "tipo_año" basado en el tipo "int" que 
--permita valores nulos:
 exec sp_addtype tipo_año, 'int','null';
 GO
--4- Ejecute el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido 
--anteriormente para obtener información del mismo:
 EXEC sp_help tipo_año;
 GO
--5- Cree la tabla "Empleados" con 3 campos: documento (char de 8), nombre (30 caracteres) y 
--añoingreso (tipo_año):
 create table Empleados(
  documento char(8),
  nombre varchar(30),
  añoingreso tipo_año
 );
GO
--6- Elimine la regla llamada "RG_año" si existe:
 if object_id ('RG_año') is not null
   drop rule RG_año;
GO
--7- Cree la regla que permita valores integer desde 1990 (año en que se inauguró el comercio) y el 
--año actual:
 create rule RG_año
  as @año between 1990 and datepart(year,getdate());
  GO
--8- Asocie la regla al tipo de datos "tipo_año" especificando que solamente se aplique a los futuros 
--campos de este tipo:
 exec sp_bindrule RG_año, 'tipo_año', 'futureonly';
 GO
--9- Vea si se aplicó a la tabla Empleados:
 exec sp_helpconstraint Empleados;
--No se aplicó porque especificamos la opción "futureonly":
GO
--10- Cree la tabla "Clientes" con 3 campos: nombre (30 caracteres), añoingreso (tipo_año) y domicilio 
--(30 caracteres):
 create table Clientes(
  documento char(8),
  nombre varchar(30),
  añoingreso tipo_año
 );
 GO
--11- Vea si se aplicó la regla en la nueva tabla:
 exec sp_helpconstraint Clientes;
--Si aparece.
GO
--12- Ingrese registros con valores para el año que infrinjan la regla en la tabla "Empleados":
 insert into Empleados values('11111111','Ana Acosta',2050);
 select * from Empleados;
--Lo acepta porque en esta tabla no se aplica la regla.
GO
--13- Intente ingresar en la tabla "Clientes" un valor de fecha que infrinja la regla:
 insert into Clientes values('22222222','Juan Perez',2050);
--No lo permite.
GO
--14- Quite la asociación de la regla con el tipo de datos:
 exec sp_unbindrule 'tipo_año';
 GO
--15- Vea si se quitó la asociación:
 exec sp_helpconstraint Clientes;
--Si se quitó.
GO
--16- Vuelva a asociar la regla, ahora sin el parámetro "futureonly":
 exec sp_bindrule RG_año, 'tipo_año';
--Note que hay valores que no cumplen la regla pero SQL Server NO lo verifica al momento de asociar 
--una regla.
GO
--17- Intente agregar una fecha de ingreso fuera del intervalo que admite la regla en cualquiera de 
--las tablas (ambas tienen la asociación):
 insert into Empleados values('33333333','Romina Guzman',1900);
--Mensaje de error.
GO
--18- Vea la información del tipo de dato:
 exec sp_help tipo_año;
--En la columna que hace referencia a la regla asociada aparece "RG_año".
GO
--19- Elimine la regla llamada "RG_añonegativo", si existe:
 if object_id ('RG_añonegativo') is not null
   drop rule RG_añonegativo;
GO
--20- Cree una regla llamada "RG_añonegativo" que admita valores entre -2000 y -1:
  create rule RG_añonegativo
  as @año between -2000 and -1;
GO
--21- Asocie la regla "RG_añonegativo" al campo "añoingreso" de la tabla "Clientes":
 exec sp_bindrule RG_añonegativo, 'Clientes.añoingreso';
 GO
--22- Vea si se asoció:
 exec sp_helpconstraint Clientes;
--Se asoció.
GO
--23- Verifique que no está asociada al tipo de datos "tipo_año":
 exec sp_help tipo_año;
--No, tiene asociada la regla "RG_año".
GO
--24- Intente ingresar un registro con valor '-1900' para el campo "añoingreso" de "Empleados":
 insert into Empleados values('44444444','Pedro Perez',-1900);
--No lo permite por la regla asociada al tipo de dato.
GO
--25- Ingrese un registro con valor '-1900' para el campo "añoingreso" de "Clientes" y recupere los 
--registros de dicha tabla:
 insert into Clientes values('44444444','Pedro Perez',-1900);
 select * from Clientes;
--Note que se ingreso, si bien el tipo de dato de "añoingreso" tiene asociada una regla que no admite 
--tal valor, el campo tiene asociada una regla que si lo admite y ésta prevalece.
GO
