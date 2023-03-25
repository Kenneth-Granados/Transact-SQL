USE Practica;
GO

if object_id('Alumnos') is not null drop table Alumnos;
create table Alumnos(
legajo char(5) not null, 
documento char(8) not null,
apellido varchar(30), 
nombre varchar(30),
notafinal decimal(4,2) );
GO
--2- Cree un índice no agrupado para el campo "apellido". 
CREATE NONCLUSTERED INDEX I_Alumnos_Apellido
ON Alumnos(apellido);
GO
--3- Establezca una restricción "primary" para el campo "legajo" y especifique que cree un índice "agrupado".
ALTER TABLE Alumnos
ADD CONSTRAINT PK_Alumnos_Legajo
PRIMARY KEY CLUSTERED(legajo)
GO
--4- Vea la información que muestra "sp_helpindex": 
exec sp_helpindex Alumnos; 
GO
--5- Intente eliminar el índice "PK_Alumnos_legajo" con "drop index":
DROP INDEX PK_Alumnos_Legajo; --No se puede. 
--6- Intente eliminar el índice "I_Alumnos_apellido" sin especificar el nombre de la tabla: 
DROP INDEX I_Alumnos_Apellido;-- Mensaje de error.
GO
--7- Elimine el índice "I_Alumnos_apellido" especificando el nombre de la tabla. 
DROP INDEX Alumnos.I_Alumnos_Apellido;
GO
--8- Verifique que se eliminó: 
exec sp_helpindex Alumnos;
GO
--9- Solicite que se elimine el índice "I_Alumnos_apellido" si existe:
IF EXISTS (SELECT NAME FROM sysindexes WHERE NAME = 'I_Alumnos_Apellido')
DROP INDEX Alumnos.I_Alumnos_Apellido;
GO
--10- Elimine el índice "PK_Alumnos_legajo" (quite la restricción). 
ALTER TABLE Alumnos
DROP PK_Alumnos_Legajo
GO
--11- Verifique que el índice "PK_Alumnos_legajo" ya no existe:
exec sp_helpindex Alumnos;