USE Practica;

if object_id('remis') is not null
  drop table remis;
GO

 create table remis(
  numero tinyint identity ,
  patente char(6),
  marca varchar(15),
  modelo char(4)
 );
GO
--select NEWID();
 insert into remis values('ABC123','Renault clio','1990');
 insert into remis values('DEF456','Peugeot 504','1995');
 insert into remis values('DEF456','Fiat Duna','1998');
 insert into remis values('GHI789','Fiat Duna','1995');
 insert into remis values(null,'Fiat Duna','1995');
 GO
--4- Intente agregar una restricción "unique" para asegurarse que la patente del remis no tomará 
--valores repetidos.
--No se puede porque hay valores duplicados.
ALTER TABLE remis
ADD CONSTRAINT UQ_remis_patente
UNIQUE (patente)
--5- Elimine el registro con patente duplicada y establezca la restricción.
--Note que hay 1 registro con valor nulo en "patente".
DELETE remis
WHERE numero=3;
ALTER TABLE remis
ADD CONSTRAINT UQ_remis_patente
UNIQUE (patente)

--6- Intente ingresar un registro con patente repetida (no lo permite)
 insert into remis values('DEF456','Toyota','1998');
--7- Intente ingresar un registro con valor nulo para el campo "patente".
--No lo permite porque la clave estaría duplicada.
 insert into remis values(NULL,'Toyota','1998');
--8- Muestre la información de las restricciones:
 exec sp_helpconstraint remis;

