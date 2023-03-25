USE Practica;
GO

if object_id ('Empleados') is not null
  drop table Empleados;

--2- Defina un nuevo tipo de dato llamado "tipo_legajo". Primero debe eliminarlo (si existe) para 
--volver a crearlo. Para ello emplee esta sentencia que explicaremos en el siguiente capítulo:
 if exists (select name from systypes
  where name = 'Tipo_Legajo')
  exec sp_droptype Tipo_Legajo;
GO
--3- Cree un tipo de dato definido por el usuario llamado "tipo_legajo" basado en el tipo "char" de 4 
--caracteres que no permita valores nulos.
EXEC sp_addtype Tipo_Legajo,'CHAR(4)','NOT NULL';
GO

--4- Ejecute el procedimiento almacenado "sp_help" junto al nombre del tipo de dato definido 
--anteriormente para obtener información del mismo.
EXEC sp_help Tipo_Legajo;
--5- Cree la tabla "empleados" con 3 campos: legajo (tipo_legajo), documento (char de 8) y nombre (30 
--caracteres):
 create table Empleados(
  legajo Tipo_Legajo,
  documento char(8),
  nombre varchar(30)
 );
GO
--6- Intente ingresar un registro con valores por defecto:
 insert into Empleados default values;
--No se puede porque el campo "tipo_legajo" no admite valores nulos y no tiene definido un valor por 
--defecto.
GO
--7- Ingrese un registro con valores válidos.
insert into empleados values('A111','22222222','Juan Perez');
Go