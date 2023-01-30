USE Practica;

if object_id('vehiculos') is not null
  drop table vehiculos;

 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime not null,
  horasalida datetime
 );
 GO
--3- Establezca una restricci�n "check" que admita solamente los valores "a" y "m" para el campo 
--"tipo":
 alter table vehiculos
 add constraint CK_vehiculos_tipo
 check (tipo in ('a','m'));

--4- Establezca una restricci�n "default" para el campo "tipo" que almacene el valor "a" en caso de no 
--ingresarse valor para dicho campo:
 alter table vehiculos
  add constraint DF_vehiculos_tipo
  default 'a'
  for tipo;

--5- Establezca una restricci�n "check" para el campo "patente" para que acepte 3 letras seguidas de 3 
--d�gitos:
 alter table vehiculos
 add constraint CK_vehiculos_patente_patron
 check (patente like '[A-Z][A-Z][A-Z][0-9][0-9][0-9]');

--6- Agregue una restricci�n "primary key" que incluya los campos "patente" y "horallegada":
 alter table vehiculos
 add constraint PK_vehiculos_patentellegada
 primary key(patente,horallegada);

--7- Ingrese un veh�culo:
insert into vehiculos values('SDR456','a','2005/10/10 10:10',null);

--8- Intente ingresar un registro repitiendo la clave primaria:
insert into vehiculos values('SDR456','m','2005/10/10 10:10',null);
--No se permite.

--9- Ingrese un registro repitiendo la patente pero no la hora de llegada:
insert into vehiculos values('SDR456','m','2005/10/10 12:10',null);

--10- Ingrese un registro repitiendo la hora de llegada pero no la patente:
insert into vehiculos values('SDR111','m','2005/10/10 10:10',null);

--11- Vea todas las restricciones para la tabla "vehiculos":
exec sp_helpconstraint vehiculos;
--aparecen 4 filas, 2 correspondientes a restricciones "check", 1 a "default" y 1 a "primary key".

--12- Elimine la restricci�n "default" del campo "tipo".
ALTER TABLE vehiculos
DROP DF_vehiculos_tipo
--13- Vea si se ha eliminado:
exec sp_helpconstraint vehiculos;

--14- Elimine la restricci�n "primary key" y "check".
ALTER TABLE vehiculos
DROP CK_vehiculos_patente_patron,CK_vehiculos_tipo,PK_vehiculos_patentellegada
--15- Vea si se han eliminado:
 exec sp_helpconstraint vehiculos;
