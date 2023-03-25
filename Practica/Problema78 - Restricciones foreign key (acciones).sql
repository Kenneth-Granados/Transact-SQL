USE Practica;
GO

if object_id('Clientes') is not null
  drop table Clientes;
 if object_id('Provincias') is not null
  drop table Provincias;
GO

 create table Clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint,
  primary key(codigo)
 );

 create table Provincias(
  codigo tinyint,
  nombre varchar(20),
  primary key (codigo)
 );
 GO

 insert into Provincias values(1,'Cordoba');
 insert into Provincias values(2,'Santa Fe');
 insert into Provincias values(3,'Misiones');
 insert into Provincias values(4,'Rio Negro');

 insert into Clientes values('Perez Juan','San Martin 123','Carlos Paz',1);
 insert into Clientes values('Moreno Marcos','Colon 234','Rosario',2);
 insert into Clientes values('Acosta Ana','Avellaneda 333','Posadas',3);
 GO

--4- Establezca una restricción "foreign key" especificando la acción "en cascade" para 
--actualizaciones y "no action" para eliminaciones.
 alter table Clientes
 add constraint FK_clientes_codigoprovincia
  foreign key (codigoprovincia)
  references Provincias(codigo)
  on update cascade
  on delete no action;
  GO
--5- Intente eliminar el registro con código 3, de "Provincias".
 delete from provincias where codigo=3;
--No se puede porque hay registros en "Clientes" al cual hace referencia y la opción para 
--eliminaciones se estableció como "no action".
GO
--6- Modifique el registro con código 3, de "Provincias".
update Provincias set codigo=9 where codigo=3;
GO
--7- Verifique que el cambio se realizó en cascada, es decir, que se modificó en la tabla "Provincias" 
--y en "Clientes":
 select * from Provincias;
 select * from Clientes;
 GO
--8- Intente modificar la restricción "foreign key" para que permita eliminación en cascada.
 alter table Clientes
 add constraint FK_clientes_codigoprovincia
  foreign key (codigoprovincia)
  references Provincias(codigo)
  on update cascade,
  on delete cascade;
--Mensaje de error, no se pueden modificar las restricciones.
GO
--9- Intente eliminar la tabla "Provincias".
 drop table Provincias;
--No se puede eliminar porque una restricción "foreign key" hace referencia a ella.
GO

--------------------------------------------------------------------------------------------------------
--Segundo problema:

 if object_id('Inscripciones') is not null
  drop table Inscripciones;
 if object_id('Deportes') is not null
  drop table Deportes;
 if object_id('Socios') is not null
  drop table Socios;
GO

 create table Deportes(
  codigo tinyint,
  nombre varchar(20),
  primary key(codigo)
 );

 create table Socios(
  documento char(8),
  nombre varchar(30),
  primary key(documento)
 );

 create table Inscripciones(
  documento char(8), 
  codigodeporte tinyint,
  matricula char(1),-- 's' si está paga, 'n' si no está paga
  primary key(documento,codigodeporte)
 );

--3- Establezca una restricción "foreign key" para "Inscripciones" que haga referencia al campo 
--"codigo" de "Deportes" que permita la actualización en cascada:
  alter table Inscripciones
  add constraint FK_Inscripciones_codigodeporte
  foreign key (codigodeporte)
  references Deportes(codigo)
  on update cascade;

--4- Establezca una restricción "foreign key" para "Inscripciones" que haga referencia al campo 
--"documento" de "Socios" que permita la eliminación en cascada (Recuerde que se pueden establecer 
--varias retricciones "foreign key" a una tabla):
  alter table Inscripciones
  add constraint FK_Inscripciones_documento
  foreign key (documento)
  references Socios(documento)
  on delete cascade;
  GO
--5- Ingrese algunos registros en las tablas:
 insert into Deportes values(1,'basquet');
 insert into Deportes values(2,'futbol');
 insert into Deportes values(3,'natacion');
 insert into Deportes values(4,'tenis');

 insert into Socios values('30000111','Juan Lopez');
 insert into Socios values('31111222','Ana Garcia');
 insert into Socios values('32222333','Mario Molina');
 insert into Socios values('33333444','Julieta Herrero');

 insert into Inscripciones values ('30000111',1,'s');
 insert into Inscripciones values ('30000111',2,'s');
 insert into Inscripciones values ('31111222',1,'s');
 insert into Inscripciones values ('32222333',3,'n');
 GO
--6- Intente ingresar una inscripción con un código de deporte inexistente:
 insert into Inscripciones values('30000111',6,'s');
--Mensaje de error.

--7- Intente ingresar una inscripción con un documento inexistente en "Socios":
 insert into Inscripciones values('40111222',1,'s');
--Mensaje de error.
GO
--8- Elimine un registro de "Deportes" que no tenga inscriptos:
 delete from Deportes where nombre='tenis';
--Se elimina porque no hay inscriptos en dicho deporte.

--9- Intente eliminar un deporte para los cuales haya inscriptos:
 delete from Deportes where nombre='natacion';
--No se puede porque al no especificarse acción para eliminaciones, por defecto es "no action" y hay 
--inscriptos en dicho deporte.
GO
--10- Modifique el código de un deporte para los cuales haya inscriptos.
 update Deportes set codigo=5 where nombre='natacion';
--La opción para actualizaciones se estableció en cascada, se modifica el código en "Deportes" y en 
--"Inscripciones".
GO
--11- Verifique los cambios:
 select * from Deportes;
 select * from Inscripciones;
GO

--12- Elimine el socio que esté inscripto en algún deporte.
delete from socios where documento='32222333'; 
--Se elimina dicho socio de "Socios" y la acción se extiende a la tabla "Inscripciones".
GO
--13- Verifique que el socio eliminado ya no aparece en "Inscripciones":
 select * from Socios;
 select * from Inscripciones;
GO
--14- Modifique el documento de un socio que esté inscripto.
update Socios set documento='35555555' where documento='30000111';
--No se puede porque la acción es "no action" para actualizaciones.
GO
--15- Intente eliminar la tabla "Deportes":
 drop table Deportes;
--No se puede porque una restricción "foreign key" hace referencia a ella.

--16- Vea las restricciones de la tabla "Socios":
 exec sp_helpconstraint Socios;
--Muestra la restricción "primary key" y la referencia de una "foreign key" de la tabla 
--"Inscripciones".

--17- Vea las restricciones de la tabla "Deportes":
 exec sp_helpconstraint Deportes;
--Muestra la restricción "primary key" y la referencia de una "foreign key" de la tabla 
--"Inscripciones".

--18- Vea las restricciones de la tabla "Inscripciones":
 exec sp_helpconstraint Inscripciones;
--Muestra 3 restricciones. Una "primary key" y dos "foreign key", una para el campo "codigodeporte" 
--que especifica "no action" en la columna "delete_action" y "cascade" en la columna "update_action"; 
--la otra, para el campo "documento" especifica "cascade" en la columna "delete_action" y "no action" 
--en "update_action".
