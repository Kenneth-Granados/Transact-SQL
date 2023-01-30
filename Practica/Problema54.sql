USE Practica;

if object_id('vehiculos') is not null
  drop table vehiculos;
GO

 if object_id ('RG_patente_patron') is not null
   drop rule RG_patente_patron;
 if object_id ('RG_horallegada') is not null
   drop rule RG_horallegada;
 if object_id ('RG_tipo_rango') is not null
   drop rule RG_tipo_rango;
 if object_id ('RG_tipo_rango2') is not null
   drop rule RG_tipo_rango2;
 if object_id ('RG_menor_fechaactual') is not null
   drop rule RG_menor_fechaactual;
GO

 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime not null,
  horasalida datetime
 );
GO
SET DATEFORMAT ymd;

 insert into vehiculos values ('AAA111','a','1990-02-01 08:10',null);
 insert into vehiculos values ('BCD222','m','1990-02-01 08:10','1990-02-01 10:10');
 insert into vehiculos values ('BCD222','m','1990-02-01 12:00',null);
 insert into vehiculos values ('CC1234','a','1990-02-01 12:00',null);
 GO
--5- Cree una regla para restringir los valores que se pueden ingresar en un campo "patente" (3 letras 
--seguidas de 3 d�gitos):

 create rule RG_patente_patron
 as @patente like '[A-Z][A-Z][A-Z][0-9][0-9][0-9]'
 GO
--6- Ejecute el procedimiento almacenado del sistema "sp_help" para ver que la regla creada 
--anteriormente existe:
 exec sp_help;

--7- Ejecute el procedimiento almacenado del sistema "sp_helpconstraint" para ver que la regla creada 
--anteriormente no est� asociada a�n a ning�n campo de la tabla "vehiculos".
EXEC sp_helpconstraint vehiculos;
--8-  Asocie la regla al campo "patente":
EXEC sp_bindrule RG_patente_patron,'vehiculos.patente';
GO
--Note que hay una patente que no cumple la regla, SQL Server NO controla los datos existentes, pero 
--si controla las inserciones y actualizaciones:
 select * from vehiculos;

--9- Intente ingresar un registro con valor para el campo "patente" que no cumpla con la regla.
--aparece un mensaje de error indicando que hay conflicto con la regla y la inserci�n no se realiza.
insert into vehiculos values ('125juk','a','1990-02-01 12:00',null);
GO
--10- Cree otra regla que controle los valores para el campo "tipo" para que solamente puedan 
--ingresarse los caracteres "a" y "m".
CREATE RULE RG_tipo_rango
AS @tipo IN('a','m')
GO
--11- Asocie la regla al campo "tipo".
EXEC sp_bindrule RG_tipo_rango,'vehiculos.tipo';
--12- Intente actualizar un registro cambiando el valor de "tipo" a un valor que no cumpla con la 
--regla anterior.
--No lo permite.
UPDATE  vehiculos 
SET tipo='l';
GO
--13- Cree otra regla llamada "RG_vehiculos_tipo2" que controle los valores para el campo "tipo" para 
--que solamente puedan ingresarse los caracteres "a", "c" y "m".
CREATE RULE RG_tipo_rango2
AS @tipo IN('a','m','c')
GO
--14- Si la asociamos a un campo que ya tiene asociada otra regla, la nueva regla reeemplaza la 
--asociaci�n anterior. Asocie la regla creada en el punto anterior al campo "tipo".
EXEC sp_bindrule RG_tipo_rango2,'vehiculos.tipo';
--15- Actualice el registro que no pudo actualizar en el punto 12:
 update vehiculos set tipo='c' where patente='AAA111';
 GO
--16- Cree una regla que permita fechas menores o iguales a la actual.
CREATE RULE RG_menor_fechaactual
AS @fecha <=GETDATE();
GO
--17- Asocie la regla anterior a los campos "horallegada" y "horasalida":
 exec sp_bindrule RG_menor_fechaactual, 'vehiculos.horallegada';
 exec sp_bindrule RG_menor_fechaactual, 'vehiculos.horasalida';

--18- Ingrese un registro en el cual la hora de entrada sea posterior a la hora de salida:
 insert into vehiculos values ('NOP555','a','1990-02-01 10:10','1990-02-01 08:30');

--19- Intente establecer una restricci�n "check" que asegure que la fecha y hora de llegada a la playa 
--no sea posterior a la fecha y hora de salida:
 alter table vehiculos
 add constraint CK_vehiculos_llegada_salida
 check(horallegada<=horasalida);
--No lo permite porque hay un registro que no cumple la restricci�n.

--20- Elimine dicho registro:
 delete from vehiculos where patente='NOP555';

--21- Establezca la restricci�n "check" que no pudo establecer en el punto 19:
 alter table vehiculos
 --WITH NOCHECK para no tener que usar delete
 add constraint CK_vehiculos_llegada_salida
 check(horallegada<=horasalida);

--22- Cree una restricci�n "default" que almacene el valor "b" en el campo "tipo:
 alter table vehiculos
 add constraint DF_vehiculos_tipo
 default 'b'
 for tipo;
--Note que esta restricci�n va contra la regla asociada al campo "tipo" que solamente permite los 
--valores "a", "c" y "m". SQL Server no informa el conflicto hasta que no intenta ingresar el valor 
--por defecto.

--23- Intente ingresar un registro con el valor por defecto para el campo "tipo":
insert into vehiculos values ('STU456',default,'1990-02-01 10:10','1990-02-01 15:30');
--No lo permite porque va contra la regla asociada al campo "tipo".

--24- Vea las reglas asociadas a "empleados" y las restricciones aplicadas a la misma tabla ejecutando 
"sp_helpconstraint".
--Muestra 1 restricci�n "check", 1 restricci�n "default" y 4 reglas asociadas

