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
--2- Cree un �ndice no agrupado para el campo "apellido". 
CREATE NONCLUSTERED INDEX I_Alumnos_Apellido
ON Alumnos(apellido);
GO
--3- Establezca una restricci�n "primary" para el campo "legajo" y especifique que cree un �ndice "agrupado".
ALTER TABLE Alumnos
ADD CONSTRAINT PK_Alumnos_Legajo
PRIMARY KEY CLUSTERED(legajo)
GO
--4- Vea la informaci�n que muestra "sp_helpindex": 
exec sp_helpindex Alumnos; 
GO
--5- Intente eliminar el �ndice "PK_Alumnos_legajo" con "drop index":
DROP INDEX PK_Alumnos_Legajo; --No se puede. 
--6- Intente eliminar el �ndice "I_Alumnos_apellido" sin especificar el nombre de la tabla: 
DROP INDEX I_Alumnos_Apellido;-- Mensaje de error.
GO
--7- Elimine el �ndice "I_Alumnos_apellido" especificando el nombre de la tabla. 
DROP INDEX Alumnos.I_Alumnos_Apellido;
GO
--8- Verifique que se elimin�: 
exec sp_helpindex Alumnos;
GO
--9- Solicite que se elimine el �ndice "I_Alumnos_apellido" si existe:
IF EXISTS (SELECT NAME FROM sysindexes WHERE NAME = 'I_Alumnos_Apellido')
DROP INDEX Alumnos.I_Alumnos_Apellido;
GO
--10- Elimine el �ndice "PK_Alumnos_legajo" (quite la restricci�n). 
ALTER TABLE Alumnos
DROP PK_Alumnos_Legajo
GO
--11- Verifique que el �ndice "PK_Alumnos_legajo" ya no existe:
exec sp_helpindex Alumnos;