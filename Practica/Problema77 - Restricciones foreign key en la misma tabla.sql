USE Practica
GO

if object_id('Clientes') is not null
  drop table Clientes;
  GO

 create table Clientes(
  codigo int not null,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  referenciadopor int,
  primary key(codigo)
  
 );
 GO
--2- Ingresamos algunos registros:
 insert into Clientes values (50,'Juan Perez','Sucre 123','Cordoba',null);
 insert into Clientes values(90,'Marta Juarez','Colon 345','Carlos Paz',null);
 insert into Clientes values(110,'Fabian Torres','San Martin 987','Cordoba',50);
 insert into Clientes values(125,'Susana Garcia','Colon 122','Carlos Paz',90);
 insert into Clientes values(140,'Ana Herrero','Colon 890','Carlos Paz',9);
 GO

--3- Intente agregar una restricción "foreign key" para evitar que en el campo "referenciadopor" se 
--ingrese un valor de código de cliente que no exista.
alter table Clientes
  add constraint FK_Clientes_referenciadopor
  foreign key (referenciadopor)
  references Clientes (codigo);
--No se permite porque existe un registro que no cumple con la restricción que se intenta establecer.
GO

--4- Cambie el valor inválido de "referenciadopor" del registro que viola la restricción por uno 
--válido
 update Clientes set referenciadopor=90 where referenciadopor=9;
GO

--5- Agregue la restricción "foreign key" que intentó agregar en el punto 3.
alter table Clientes
  add constraint FK_Clientes_referenciadopor
  foreign key (referenciadopor)
  references Clientes (codigo);
GO

--6- Vea la información referente a las restricciones de la tabla "Clientes".
exec sp_helpconstraint Clientes;
GO
--7- Intente agregar un registro que infrinja la restricción.
--No lo permite.
insert into Clientes values(150,'Karina Gomez','Caseros 444','Cruz del Eje',8);
GO

--8- Intente modificar el código de un cliente que está referenciado en "referenciadopor".
 update Clientes set codigo=180 where codigo=90;
--No se puede.
GO
--9- Intente eliminar un cliente que sea referenciado por otro en "referenciadopor".
--No se puede.
delete from Clientes where nombre='Marta Juarez';
GO

--10- Cambie el valor de código de un cliente que no referenció a nadie.
update Clientes set codigo=180 where codigo=125;
GO
--11- Elimine un cliente que no haya referenciado a otros.
delete from Clientes where codigo=110;
GO

SELECT c2.nombre,c1.nombre AS 'Lo referencio' FROM Clientes As c1
INNER JOIN Clientes AS c2 On c1.codigo = c2.referenciadopor;
Go

SELECT * FROM Clientes;