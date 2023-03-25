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
CREATE NONCLUSTERED INDEX I_Alumnos_apellido
ON Alumnos(apellido);
GO
-- 3- Vea la informaci�n de los �ndices de "Alumnos".
EXEC sp_helpindex Alumnos;
GO
-- 4- Modif�quelo agregando el campo "nombre". 
CREATE NONCLUSTERED INDEX I_Alumnos_apellido
ON Alumnos(apellido,nombre)
WITH DROP_EXISTING;
GO
--5- Verifique que se modific�:
exec sp_helpindex Alumnos; 
GO
--6- Establezca una restricci�n "unique" para el campo "documento".
ALTER TABLE Alumnos
ADD CONSTRAINT UQ_Alumnos_Documento
UNIQUE (documento);
GO
--7- Vea la informaci�n que muestra "sp_helpindex":
exec sp_helpindex Alumnos; 
GO
--8- Intente modificar con "drop_existing" alguna caracter�stica del �ndice que se cre� autom�ticamente al agregar la restricci�n "unique":
CREATE CLUSTERED INDEX UQ_Alumnos_Documento ON Alumnos(documento)
WITH DROP_EXISTING;
--No se puede emplear "drop_existing" con �ndices creados a partir de una restricci�n. 
GO
--9- Cree un �ndice no agrupado para el campo "legajo".
CREATE INDEX I_Alumnos_Legajo
ON Alumnos(legajo) 
GO
--10- Muestre todos los �ndices: 
exec sp_helpindex Alumnos; 
GO
--11- Convierta el �ndice creado en el punto 9 a agrupado conservando las dem�s caracter�sticas.
CREATE CLUSTERED INDEX I_Alumnos_Legajo
ON Alumnos(legajo) WITH DROP_EXISTING
GO
--12- Verifique que se modific�:
exec sp_helpindex Alumnos;
GO
--13- Intente convertir el �ndice "I_Alumnos_legajo" a no agrupado: 
CREATE NONCLUSTERED INDEX I_Alumnos_Legajo 
ON Alumnos(legajo) WITH DROP_EXISTING; 
--No se puede convertir un �ndice agrupado en no agrupado.
GO
--14- Modifique el �ndice "I_Alumnos_apellido" quit�ndole el campo "nombre". 
CREATE NONCLUSTERED INDEX I_Alumnos_apellido
ON Alumnos(apellido)
WITH DROP_EXISTING;
GO
--15- Intente convertir el �ndice "I_Alumnos_apellido" en agrupado:
CREATE CLUSTERED INDEX I_Alumnos_apellido ON Alumnos(apellido) WITH DROP_EXISTING;
--No lo permite porque ya existe un �ndice agrupado.
GO
--16- Modifique el �ndice "I_Alumnos_legajo" para que sea �nico y conserve todas las otras caracter�sticas.
CREATE UNIQUE CLUSTERED INDEX I_Alumnos_Legajo 
ON Alumnos(legajo) WITH DROP_EXISTING; 
GO
--17- Verifique la modificaci�n: 
exec sp_helpindex Alumnos;
GO
--18- Modifique nuevamente el �ndice "I_Alumnos_legajo" para que no sea �nico y conserve las dem�s caracter�sticas.
CREATE CLUSTERED INDEX I_Alumnos_Legajo 
ON Alumnos(legajo) WITH DROP_EXISTING; 
GO
--19- Verifique la modificaci�n: 
exec sp_helpindex Alumnos;
GO