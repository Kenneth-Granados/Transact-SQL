USE Practica;

if object_id('vehiculos') is not null
  drop table vehiculos;
GO

 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime,
  horasalida datetime
 );
GO
--3- Establezca una restricción "default" para el campo "tipo" que almacene el valor "a" en caso de no 
--ingresarse valor para dicho campo.
ALTER TABLE vehiculos
ADD CONSTRAINT DF_vehiculos_tipo
DEFAULT 'a'
FOR tipo
--4- Ingrese un registro sin valor para el campo "tipo":
 insert into vehiculos values('BVB111',default,default,null);

--5- Recupere los registros:
 select * from vehiculos;

--6- Intente establecer otra restricción "default" para el campo "tipo" que almacene el valor "m" en 
--caso de no ingresarse valor para dicho campo.
--No lo permite porque un campo solamente admite una restricción "default" y ya tiene una.
ALTER TABLE vehiculos
ADD CONSTRAINT DF_vehiculos_tipo
DEFAULT 'm'
FOR tipo
--7- Establezca una restricción "default" para el campo "horallegada" que almacene la fecha y hora del 
--sistema.
ALTER TABLE vehiculos
ADD CONSTRAINT DF_vehiculos_horallegada
DEFAULT GETDATE()
FOR horallegada
--8- Ingrese un registro sin valor para los campos de tipo datetime.
insert into vehiculos values('BVB111',default,default,default);
--9- Recupere los registros:
 select * from vehiculos;

--10- Vea las restricciones.
--2 restricciones.
EXEC sp_helpconstraint visitantes