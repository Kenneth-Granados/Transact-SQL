 USE Practica;

 if object_id ('clientes') is not null
  drop table clientes;
--2- Recuerde que si elimina una tabla, las asociaciones de reglas y valores predeterminados de sus 
--campos desaparecen, pero las reglas y valores predeterminados siguen existiendo. Si intenta crear 
--una regla o un valor predeterminado con igual nombre que uno existente, aparecerá un mensaje 
--indicándolo, por ello, debe eliminarlos (si existen) para poder crearlos nuevamente:
 if object_id ('VP_legajo_patron') is not null
   drop default VP_legajo_patron;
 if object_id ('RG_legajo_patron') is not null
   drop rule RG_legajo_patron;
 if object_id ('RG_legajo') is not null
   drop rule RG_legajo;
 if object_id ('VP_datodesconocido') is not null
   drop default VP_datodesconocido;
 if object_id ('VP_fechaactual') is not null
   drop default VP_fechaactual;
GO

 create table clientes(
  legajo char(4),
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(15),
  provincia varchar(20) default 'Cordoba',
  fechaingreso datetime
 );
 GO
--4- Cree una regla para establecer un patrón para los valores que se ingresen en el campo "legajo" (2 
--letras seguido de 2 cifras) llamada "RG_legajo_patron":
CREATE RULE RG_legajo_patron
AS @variable LIKE '[A-Z][A-Z][0-9][0-9]'
GO
--5- Asocie la regla al campo "legajo".
EXEC sp_bindrule RG_legajo_patron, 'clientes.legajo'; 
GO
--6- Cree un valor predeterminado para el campo "legajo" ('AA00') llamado "VP_legajo_patron".
CREATE DEFAULT VP_legajo_patron
AS 'AA00'
GO
--7- Asócielo al campo "legajo".
EXEC sp_bindefault VP_legajo_patron, 'clientes.legajo'; 
--Recuerde que un campo puede tener un valor predeterminado y reglas asociados.
GO
--8- Cree un valor predeterminado con la cadena "??" llamado "VP_datodesconocido".
CREATE DEFAULT VP_datodesconocido
AS '??'
GO
--9- Asócielo al campo "domicilio".
EXEC sp_bindefault VP_datodesconocido, 'clientes.domicilio'
GO
--10- Asócielo al campo "ciudad".
--Recuerde que un valor predeterminado puede asociarse a varios campos.
EXEC sp_bindefault VP_datodesconocido, 'clientes.ciudad'
GO
--11- Ingrese un registro con valores por defecto para los campos "domicilio" y "ciudad" y vea qué 
--almacenaron.
INSERT INTO clientes (nombre,fechaingreso)
VALUES ('Julio',GETDATE()) 
GO
--12- Intente asociar el valor predeterminado "VP_datodesconocido" al campo "provincia".
EXEC sp_bindefault VP_datodesconocido, 'clientes.provincia'
GO
--No se puede porque dicho campo tiene una restricción "default".
--EXEC sp_helpconstraint clientes
--13- Cree un valor predeterminado con la fecha actual llamado "VP_fechaactual".
CREATE DEFAULT VP_fechaactual
AS GETDATE();
GO
--14- Asócielo al campo "fechaingreso".
EXEC sp_bindefault VP_fechaactual, 'clientes.fechaingreso';
--15- Ingrese algunos registros para ver cómo se almacenan los valores para los cuales no se insertan 
--datos.
INSERT INTO clientes (nombre)
VALUES ('Marcos') 
GO
--16- Asocie el valor predeterminado "VP_datodesconocido" al campo "fechaingreso".
EXEC sp_bindefault VP_datodesconocido, 'clientes.fechaingreso';
--Note que se asoció un valor predeterminado de tipo caracter a un campo de tipo "datetime"; SQL 
--Server lo permite, pero al intentar ingresar el valor aparece un mensaje de error.

--17- Ingrese un registro con valores por defecto.
INSERT INTO clientes (nombre)
VALUES ('MANUEL') 
GO
--No lo permite porque son de distintos tipos.

--18- Cree una regla que entre en conflicto con el valor predeterminado "VP_legajo_patron".
CREATE RULE RG_legajo_prueba
AS @prueba LIKE'B%'
GO
--19- Asocie la regla al campo "legajo".
EXEC sp_bindrule RG_legajo_prueba,  'clientes.legajo'; 
--Note que la regla especifica que el campo "legajo" debe comenzar con la letra "B", pero el valor 
--predeterminado tiene el valor "AA00"; SQL Server realiza la asociación, pero al intentar ingresar el 
--valor predeterminado, no puede hacerlo y muestra un mensaje de error.

--20- Intente ingresar un registro con el valor "default" para el campo "legajo".
INSERT INTO clientes (nombre)
VALUES ('MAN') 
GO
--No lo permite porque al intentar ingresar el valor por defecto establecido con el valor 
--predeterminado entra en conflicto con la regla "RG_legajo".

