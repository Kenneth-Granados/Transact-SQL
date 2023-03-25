USE Practica
GO

if object_id ('Libros') is not null 
drop table Libros;
GO
--2- Recuerde que si elimina una tabla, las asociaciones de reglas y valores predeterminados de sus campos desaparecen, pero las reglas y 
--valores predeterminados siguen existiendo. Si intenta crear una regla o un valor predeterminado con igual nombre que uno existente, 
--aparecerá un mensaje indicándolo, por ello, debe eliminarlos (si existen) para poder crearlos nuevamente:
if object_id ('VP_cero') is not null drop default VP_cero; if object_id ('VP_desconocido') 
is not null drop default VP_desconocido; 
if object_id ('RG_positivo') is not null drop rule RG_positivo;
GO
--3- Cree la tabla: 
create table Libros(
codigo int identity, 
titulo varchar(40) not null, 
autor varchar(30), 
editorial varchar(20),
precio decimal(5,2), 
cantidad smallint );
GO
--4- Cree una regla para impedir que se ingresen valores negativos, llamada "RG_positivo".
CREATE RULE RG_positivo AS @positivo >= 0;
GO
--5- Asocie la regla al campo "precio".
EXEC sp_bindrule RG_positivo,'Libros.precio';
GO
--6- Asocie la regla al campo "cantidad".
EXEC sp_bindrule RG_positivo,'Libros.cantidad';
GO
--7- Cree un valor predeterminado para que almacene el valor cero, llamado "VP_cero". 
CREATE DEFAULT VP_cero AS 0;
GO
--8- Asócielo al campo "precio". 
EXEC sp_bindefault VP_cero,'Libros.precio';
GO
--9- Asócielo al campo "cantidad". 
EXEC sp_bindefault VP_cero,'Libros.cantidad';
GO
--10- Cree un valor predeterminado con la cadena "Desconocido" llamado "VP_desconocido". 
CREATE DEFAULT VP_desconocido AS 'Desconocido';
GO
--11- Asócielo al campo "autor". 
EXEC sp_bindefault VP_desconocido,'Libros.autor';
GO
--12- Asócielo al campo "editorial". 
EXEC sp_bindefault VP_desconocido,'Libros.editorial';
GO
--13- Vea las reglas y valores predeterminados con "sp_help": 
exec sp_help;
GO
--14- Vea las reglas y valores predeterminados asociados a "libros". Aparecen 6 filas, 2 corresponden a la regla "RG_positivo" asociadas a los campos "precio" y "cantidad";
--2 al valor predeterminado "VP_cero" asociados a los campos "precio" y "cantidad" y 2 al valor predeterminado "VP_desconocido" asociados a los campos "editorial" y "autor".
EXEC sp_help Libros
GO
--15- Ingrese un registro con valores por defecto para todos los campos, excepto "titulo" y vea qué se almacenó. 
INSERT INTO Libros (titulo) VALUES ('Azul');
SELECT * FROM Libros;
GO
--15- Quite la asociación del valor predeterminado "VP_cero" al campo "precio". 
EXEC sp_unbindefault 'Libros.precio';
GO
--16- Ingrese otro registro con valor predeterminado para el campo "precio" y vea cómo se almacenó. 
INSERT INTO Libros (titulo) VALUES ('Azul2');
SELECT * FROM Libros;
GO
--17- Vea las reglas y valores predeterminados asociados a "libros". 5 filas; el valor predeterminado "VP_cero" ya no está asociado al campo "precio". 
EXEC sp_help Libros
GO
--18- Verifique que el valor predeterminado "VP_cero" existe aún en la base de datos.
EXEC sp_help VP_cero
GO
--19- Intente eliminar el valor predeterminado "VP_cero". No se puede porque está asociado al campo "cantidad".
DROP DEFAULT VP_cero;
GO
--20- Quite la asociación del valor predeterminado "VP_cero" al campo "cantidad". 
EXEC sp_unbindefault 'Libros.cantidad';
GO
--21- Verifique que ya no existe asociación de este valor predeterminado con la tabla "libros". 4 filas. 
EXEC sp_help Libros
GO
--22- Verifique que el valor predeterminado "VP_cero" aun existe en la base de datos. 
EXEC sp_help VP_cero
GO
--23- Elimine el valor predeterminado "VP_cero". 
DROP DEFAULT VP_cero;
GO
--24- Verifique que ya no existe en la base de datos.
EXEC sp_help VP_cero
GO