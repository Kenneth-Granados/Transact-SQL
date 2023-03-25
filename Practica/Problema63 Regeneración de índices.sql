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
CREATE NONCLUSTERED INDEX I_Alumnos_apellido
ON Alumnos(apellido);
GO
-- 3- Vea la información de los índices de "Alumnos".
EXEC sp_helpindex Alumnos;
GO
-- 4- Modifíquelo agregando el campo "nombre". 
CREATE NONCLUSTERED INDEX I_Alumnos_apellido
ON Alumnos(apellido,nombre)
WITH DROP_EXISTING;
GO
--5- Verifique que se modificó:
exec sp_helpindex Alumnos; 
GO
--6- Establezca una restricción "unique" para el campo "documento".
ALTER TABLE Alumnos
ADD CONSTRAINT UQ_Alumnos_Documento
UNIQUE (documento);
GO
--7- Vea la información que muestra "sp_helpindex":
exec sp_helpindex Alumnos; 
GO
--8- Intente modificar con "drop_existing" alguna característica del índice que se creó automáticamente al agregar la restricción "unique":
CREATE CLUSTERED INDEX UQ_Alumnos_Documento ON Alumnos(documento)
WITH DROP_EXISTING;
--No se puede emplear "drop_existing" con índices creados a partir de una restricción. 
GO
--9- Cree un índice no agrupado para el campo "legajo".
CREATE INDEX I_Alumnos_Legajo
ON Alumnos(legajo) 
GO
--10- Muestre todos los índices: 
exec sp_helpindex Alumnos; 
GO
--11- Convierta el índice creado en el punto 9 a agrupado conservando las demás características.
CREATE CLUSTERED INDEX I_Alumnos_Legajo
ON Alumnos(legajo) WITH DROP_EXISTING
GO
--12- Verifique que se modificó:
exec sp_helpindex Alumnos;
GO
--13- Intente convertir el índice "I_Alumnos_legajo" a no agrupado: 
CREATE NONCLUSTERED INDEX I_Alumnos_Legajo 
ON Alumnos(legajo) WITH DROP_EXISTING; 
--No se puede convertir un índice agrupado en no agrupado.
GO
--14- Modifique el índice "I_Alumnos_apellido" quitándole el campo "nombre". 
CREATE NONCLUSTERED INDEX I_Alumnos_apellido
ON Alumnos(apellido)
WITH DROP_EXISTING;
GO
--15- Intente convertir el índice "I_Alumnos_apellido" en agrupado:
CREATE CLUSTERED INDEX I_Alumnos_apellido ON Alumnos(apellido) WITH DROP_EXISTING;
--No lo permite porque ya existe un índice agrupado.
GO
--16- Modifique el índice "I_Alumnos_legajo" para que sea único y conserve todas las otras características.
CREATE UNIQUE CLUSTERED INDEX I_Alumnos_Legajo 
ON Alumnos(legajo) WITH DROP_EXISTING; 
GO
--17- Verifique la modificación: 
exec sp_helpindex Alumnos;
GO
--18- Modifique nuevamente el índice "I_Alumnos_legajo" para que no sea único y conserve las demás características.
CREATE CLUSTERED INDEX I_Alumnos_Legajo 
ON Alumnos(legajo) WITH DROP_EXISTING; 
GO
--19- Verifique la modificación: 
exec sp_helpindex Alumnos;
GO