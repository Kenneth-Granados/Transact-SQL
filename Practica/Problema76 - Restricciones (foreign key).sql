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
  codigoprovincia tinyint
 );

 create table Provincias(
  codigo tinyint not null,
  nombre varchar(20)
 );
 GO
--En este ejemplo, el campo "codigoprovincia" de "Clientes" es una clave for�nea, se emplea para 
--enlazar la tabla "Clientes" con "Provincias".

--2- Intente agregar una restricci�n "foreign key" a la tabla "Clientes" que haga referencia al campo 
--"codigo" de "Provincias":
 alter table Clientes
 add constraint FK_Clientes_codigoprovincia
  foreign key (codigoprovincia)
  references Provincias(codigo);
--No se puede porque "Provincias" no tiene restricci�n "primary key" ni "unique".
GO
--3- Establezca una restricci�n "primary key" al campo "codigo" de "Provincias":
 alter table Provincias
 add constraint PK_Provincias_codigo
  primary key (codigo);
GO
--4- Ingrese algunos registros para ambas tablas:
 insert into Provincias values(1,'Cordoba');
 insert into Provincias values(2,'Santa Fe');
 insert into Provincias values(3,'Misiones');
 insert into Provincias values(4,'Rio Negro');

 insert into Clientes values('Perez Juan','San Martin 123','Carlos Paz',1);
 insert into Clientes values('Moreno Marcos','Colon 234','Rosario',2);
 insert into Clientes values('Acosta Ana','Avellaneda 333','Posadas',3);
 insert into Clientes values('Luisa Lopez','Juarez 555','La Plata',6);
GO
--5- Intente agregar la restricci�n "foreign key" del punto 2 a la tabla "Clientes":
 alter table Clientes
 add constraint FK_Clientes_codigoprovincia
  foreign key (codigoprovincia)
  references Provincias(codigo);
  GO
--No se puede porque hay un registro en "Clientes" cuyo valor de "codigoprovincia" no existe en 
--"Provincias".

--6- Elimine el registro de "Clientes" que no cumple con la restricci�n y establezca la restricci�n 
--nuevamente:
 delete from Clientes where codigoprovincia=6;
 alter table Clientes
 add constraint FK_Clientes_codigoprovincia
  foreign key (codigoprovincia)
  references Provincias(codigo);
GO
--7- Intente agregar un cliente con un c�digo de provincia inexistente en "Provincias".
--No se puede.
insert into clientes values('Garcia Marcos','Colon 877','Lules',9);
GO
--8- Intente eliminar el registro con c�digo 3, de "Provincias".
--No se puede porque hay registros en "Clientes" al cual hace referencia.
DELETE FROM Provincias WHERE codigo=3; 
GO
--9- Elimine el registro con c�digo "4" de "Provincias".
--Se permite porque en "Clientes" ning�n registro hace referencia a �l.
DELETE FROM Provincias WHERE codigo=4; 
--10- Intente modificar el registro con c�digo 1, de "Provincias".
--No se puede porque hay registros en "Clientes" al cual hace referencia.
UPDATE Provincias SET codigo=7 WHERE codigo=1;
GO
--11- Vea las restricciones de "Clientes".
--aparece la restricci�n "foreign key".
EXEC sp_helpconstraint Clientes;
--12- Vea las restricciones de "Provincias".
--aparece la restricci�n "primary key" y nos informa que la tabla es rerenciada por una "foreign key" 
--de la tabla "Clientes" llamada "FK_Clientes_codigoprovincia".
EXEC sp_helpconstraint Provincias;