USE Practica;
GO

if object_id ('Empleados') is not null
  drop table Empleados;
 if object_id ('Clientes') is not null
  drop table Clientes;
  GO
--2- Defina un nuevo tipo de dato llamado "tipo_a�o". Primero debe eliminarlo, si existe, para volver 
--a crearlo. Para ello emplee esta sentencia que explicaremos en el siguiente cap�tulo:
 if exists (select *from systypes
  where name = 'tipo_a�o')
   exec sp_droptype tipo_a�o;
GO
--3- Cree un tipo de dato definido por el usuario llamado "tipo_a�o" basado en el tipo "int" que 
--permita valores nulos:
 exec sp_addtype tipo_a�o, 'int','null';
 GO
--4- Ejecute el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido 
--anteriormente para obtener informaci�n del mismo:
 EXEC sp_help tipo_a�o;
 GO
--5- Cree la tabla "Empleados" con 3 campos: documento (char de 8), nombre (30 caracteres) y 
--a�oingreso (tipo_a�o):
 create table Empleados(
  documento char(8),
  nombre varchar(30),
  a�oingreso tipo_a�o
 );
GO
--6- Elimine la regla llamada "RG_a�o" si existe:
 if object_id ('RG_a�o') is not null
   drop rule RG_a�o;
GO
--7- Cree la regla que permita valores integer desde 1990 (a�o en que se inaugur� el comercio) y el 
--a�o actual:
 create rule RG_a�o
  as @a�o between 1990 and datepart(year,getdate());
  GO
--8- Asocie la regla al tipo de datos "tipo_a�o" especificando que solamente se aplique a los futuros 
--campos de este tipo:
 exec sp_bindrule RG_a�o, 'tipo_a�o', 'futureonly';
 GO
--9- Vea si se aplic� a la tabla Empleados:
 exec sp_helpconstraint Empleados;
--No se aplic� porque especificamos la opci�n "futureonly":
GO
--10- Cree la tabla "Clientes" con 3 campos: nombre (30 caracteres), a�oingreso (tipo_a�o) y domicilio 
--(30 caracteres):
 create table Clientes(
  documento char(8),
  nombre varchar(30),
  a�oingreso tipo_a�o
 );
 GO
--11- Vea si se aplic� la regla en la nueva tabla:
 exec sp_helpconstraint Clientes;
--Si aparece.
GO
--12- Ingrese registros con valores para el a�o que infrinjan la regla en la tabla "Empleados":
 insert into Empleados values('11111111','Ana Acosta',2050);
 select * from Empleados;
--Lo acepta porque en esta tabla no se aplica la regla.
GO
--13- Intente ingresar en la tabla "Clientes" un valor de fecha que infrinja la regla:
 insert into Clientes values('22222222','Juan Perez',2050);
--No lo permite.
GO
--14- Quite la asociaci�n de la regla con el tipo de datos:
 exec sp_unbindrule 'tipo_a�o';
 GO
--15- Vea si se quit� la asociaci�n:
 exec sp_helpconstraint Clientes;
--Si se quit�.
GO
--16- Vuelva a asociar la regla, ahora sin el par�metro "futureonly":
 exec sp_bindrule RG_a�o, 'tipo_a�o';
--Note que hay valores que no cumplen la regla pero SQL Server NO lo verifica al momento de asociar 
--una regla.
GO
--17- Intente agregar una fecha de ingreso fuera del intervalo que admite la regla en cualquiera de 
--las tablas (ambas tienen la asociaci�n):
 insert into Empleados values('33333333','Romina Guzman',1900);
--Mensaje de error.
GO
--18- Vea la informaci�n del tipo de dato:
 exec sp_help tipo_a�o;
--En la columna que hace referencia a la regla asociada aparece "RG_a�o".
GO
--19- Elimine la regla llamada "RG_a�onegativo", si existe:
 if object_id ('RG_a�onegativo') is not null
   drop rule RG_a�onegativo;
GO
--20- Cree una regla llamada "RG_a�onegativo" que admita valores entre -2000 y -1:
  create rule RG_a�onegativo
  as @a�o between -2000 and -1;
GO
--21- Asocie la regla "RG_a�onegativo" al campo "a�oingreso" de la tabla "Clientes":
 exec sp_bindrule RG_a�onegativo, 'Clientes.a�oingreso';
 GO
--22- Vea si se asoci�:
 exec sp_helpconstraint Clientes;
--Se asoci�.
GO
--23- Verifique que no est� asociada al tipo de datos "tipo_a�o":
 exec sp_help tipo_a�o;
--No, tiene asociada la regla "RG_a�o".
GO
--24- Intente ingresar un registro con valor '-1900' para el campo "a�oingreso" de "Empleados":
 insert into Empleados values('44444444','Pedro Perez',-1900);
--No lo permite por la regla asociada al tipo de dato.
GO
--25- Ingrese un registro con valor '-1900' para el campo "a�oingreso" de "Clientes" y recupere los 
--registros de dicha tabla:
 insert into Clientes values('44444444','Pedro Perez',-1900);
 select * from Clientes;
--Note que se ingreso, si bien el tipo de dato de "a�oingreso" tiene asociada una regla que no admite 
--tal valor, el campo tiene asociada una regla que si lo admite y �sta prevalece.
GO
