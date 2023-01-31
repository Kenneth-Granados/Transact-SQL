USE Practica;

if object_id('visitantes') is not null
  drop table visitantes;
GO

 create table visitantes(
  numero int identity,
  nombre varchar(30),
  edad tinyint,
  domicilio varchar(30),
  ciudad varchar(20),
  montocompra decimal (6,2) not null
 );
 GO
--3- Defina una restricci�n "default" para el campo "ciudad" que almacene el valor "Cordoba" en caso 
--de no ingresar valor para dicho campo:
 alter table visitantes
  add constraint DF_visitantes_ciudad
  default 'Cordoba'
  for ciudad;

--4- Defina una restricci�n "default" para el campo "montocompra" que almacene el valor "0" en caso de 
--no ingresar valor para dicho campo:
 alter table visitantes
  add constraint DF_visitantes_montocompra
  default 0
  for montocompra;

--5- Ingrese algunos registros sin valor para los campos con restricci�n "default":
 insert into visitantes
  values ('Susana Molina',35,'Colon 123',default,59.80);
 insert into visitantes (nombre,edad,domicilio)
  values ('Marcos Torres',29,'Carlos Paz');
 insert into visitantes
  values ('Mariana Juarez',45,'Carlos Paz',null,23.90);
GO
--6- Vea c�mo se almacenaron los registros:
 select * from visitantes;

--7- Vea las restricciones creadas anteriormente.
--aparecen dos filas, una por cada restricci�n.
EXEC sp_helpconstraint visitantes;
--8- Intente agregar otra restricci�n "default" al campo "ciudad".
--Aparece un mensaje de error indicando que el campo ya tiene una restricci�n "default" y sabemos 
--que no puede establecerse m�s de una restricci�n "default" por campo.
ALTER TABLE visitantes
ADD CONSTRAINT DF_visitantes_ciudad
DEFAULT 'Desconocido'
FOR ciudad
--9- Intente establecer una restricci�n "default" al campo "identity".
--No se permite.
ALTER TABLE visitantes
ADD CONSTRAINT DF_visitantes_numero
DEFAULT 0
FOR numero