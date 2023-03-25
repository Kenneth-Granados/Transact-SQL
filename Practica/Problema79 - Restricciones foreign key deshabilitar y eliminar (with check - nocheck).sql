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
 insert into Clientes values('Garcia Juan','Sucre 345','Cordoba',1);
 insert into Clientes values('Lopez Susana','Caseros 998','Posadas',3);
 insert into Clientes values('Marcelo Moreno','Peru 876','Viedma',4);
 insert into Clientes values('Lopez Sergio','Avellaneda 333','La Plata',5);
 GO
--4- Intente agregar una restricción "foreign key" para que los códigos de provincia de "Clientes" 
--existan en "Provincias" con acción en cascada para actualizaciones y eliminaciones, sin especificar 
--la opción de comprobación de datos:
 alter table Clientes
  add constraint FK_Clientes_codigoprovincia
  foreign key (codigoprovincia)
  references Provincias(codigo)
  on update cascade
  on delete cascade;
--No se puede porque al no especificar opción para la comprobación de datos, por defecto es "check" y 
--hay un registro que no cumple con la restricción.
GO
--5- Agregue la restricción anterior pero deshabilitando la comprobación de datos existentes:
 alter table Clientes
  with nocheck
  add constraint FK_Clientes_codigoprovincia
  foreign key (codigoprovincia)
  references Provincias(codigo)
  on update cascade
  on delete cascade;
  GO
--6- Vea las restricciones de "Clientes":
 sp_helpconstraint Clientes;
--Aparece la restricción "primary key" y "foreign key", las columnas "delete_action" y "update_action" 
--contienen "cascade" y la columna "status_enabled" contiene "Enabled".
 GO

--7- Vea las restricciones de "Provincias":
 sp_helpconstraint Provincias;
--Aparece la restricción "primary key" y la referencia a esta tabla de la restricción "foreign key" de 
--la tabla "Clientes.
 GO

--8- Deshabilite la restricción "foreign key" de "Clientes":
 alter table Clientes
 nocheck constraint FK_Clientes_codigoprovincia;
GO
--9- Vea las restricciones de "Clientes":
 exec sp_helpconstraint Clientes;
--la restricción "foreign key" aparece inhabilitada.
GO
--10- Vea las restricciones de "Provincias":
 exec sp_helpconstraint Provincias;
--informa que la restricción "foreign key" de "Clientes" hace referencia a ella, aún cuando está 
--deshabilitada.
GO
--11- Agregue un registro que no cumpla la restricción "foreign key":
 insert into Clientes values('Garcia Omar','San Martin 100','La Pampa',6);
--Se permite porque la restricción está deshabilitada.
GO
--12- Elimine una provincia de las cuales haya Clientes:
 delete from Provincias where codigo=2;
GO
--13- Corrobore que el registro se eliminó de "Provincias" pero no se extendió a "Clientes":
 select * from Clientes;
 select * from Provincias;

--14- Modifique un código de provincia de la cual haya Clientes:
 update Provincias set codigo=9 where codigo=3;
GO
--15- Verifique que el cambio se realizó en "Provincias" pero no se extendió a "Clientes":
 select * from Clientes;
 select * from Provincias;
GO
--16- Intente eliminar la tabla "Provincias":
 drop table Provincias;
--No se puede porque la restricción "FK_Clientes_codigoprovincia" la referencia, aunque esté deshabilitada.
GO
--17- Habilite la restricción "foreign key":
 alter table Clientes
  check constraint FK_Clientes_codigoprovincia;
GO
--18- Intente agregar un cliente con código de provincia inexistente en "Provincias":
 insert into Clientes values('Hector Ludueña','Paso 123','La Plata',8);
--No se puede.
GO
--19- Modifique un código de provincia al cual se haga referencia en "Clientes":
 update Provincias set codigo=20 where codigo=4;
--Actualización en cascada.
GO
--20- Vea que se modificaron en ambas tablas:
 select * from Clientes;
 select * from Provincias;

--21- Elimine una provincia de la cual haya referencia en "Clientes":
 delete from Provincias where codigo=1;
--Acción en cascada.

--22- Vea que los registros de ambas tablas se eliminaron:
 select * from Clientes;
 select * from Provincias;

--23- Elimine la restriccion "foreign key":
  alter table Clientes
  drop constraint FK_Clientes_codigoprovincia;
GO
--24- Vea las restriciones de la tabla "Provincias":
 exec sp_helpconstraint Provincias;
--Solamente aparece la restricción "primary key", ya no hay una "foreign key" que la referencie.
GO
--25- Elimine la tabla "Provincias":
 drop table Provincias;
--Puede eliminarse porque no hay restricción "foreign key" que la referencie.