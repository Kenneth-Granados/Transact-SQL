USE Practica;

 if object_id('vehiculos') is not null
  drop table vehiculos;
 if object_id ('RG_patente_patron') is not null
   drop rule RG_patente_patron;
 if object_id ('RG_vehiculos_tipo') is not null
   drop rule RG_vehiculos_tipo;
 if object_id ('RG_vehiculos_tipo2') is not null
   drop rule RG_vehiculos_tipo2;
GO

 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime not null,
  horasalida datetime
 );
 GO
--4- Cree una regla para restringir los valores que se pueden ingresar en un campo "patente" (3 letras 
--seguidas de 3 dígitos):
 create rule RG_patente_patron
 as @patente like '[A-Z][A-Z][A-Z][0-9][0-9][0-9]';
 GO
--5-Asocie la regla al campo "patente":
 exec sp_bindrule RG_patente_patron,'vehiculos.patente';

--6- Intente ingresar un registro con valor para el campo "patente" que no cumpla con la regla:
 insert into vehiculos values ('FGHIJK','a','1990-02-01 18:00',null);
--aparece un mensaje de error indicando que hay conflicto con la regla y la inserción no se realiza.
GO
--7- Cree otra regla que controle los valores para el campo "tipo" para que solamente puedan 
--ingresarse los caracteres "a" y "m":
 create rule RG_vehiculos_tipo
 as @tipo in ('a','m')
 GO
--8- Asocie la regla al campo "tipo":
 exec sp_bindrule RG_vehiculos_tipo, 'vehiculos.tipo';

--9- Intente ingresar un registro con el valor 'c' para "tipo":
 insert into vehiculos values('AAA111','c','2001-10-10 10:10',NULL);
--No lo permite.
GO
---10- Cree otra regla llamada "RG_vehiculos_tipo2" que controle los valores para el campo "tipo" para 
--que solamente puedan ingresarse los caracteres "a", "c" y "m":
 create rule RG_vehiculos_tipo2
 as @tipo in ('a','c','m');
 GO
--11- Si la asociamos a un campo que ya tiene asociada otra regla, la nueva regla reeemplaza la 
--asociación anterior. Asocie la regla creada en el punto anterior al campo "tipo".
EXEC sp_bindrule RG_vehiculos_tipo2, 'vehiculos.tipo';
--12- Ingrese el registro que no pudo ingresar en el punto 9.
insert into vehiculos values('AAA111','c','2001-10-10 10:10',NULL);
--13- Intente eliminar la regla "RG_vehiculos_tipo2".
DROP RULE RG_vehiculos_tipo2
--No es posible porque está asociada a un campo de "vehiculos".

--14- Elimine la regla "RG_vehiculos_tipo".
DROP RULE RG_vehiculos_tipo
--Es posible porque no está asociada a ningún campo.

--15- Intente eliminar la regla "RG_patente_patron".
DROP RULE RG_patente_patron
--No es posible porque está asociada.

--16- Quite la asociación de la regla con el campo "patente" de "vehiculos".
EXEC sp_unbindrule 'vehiculos.patente'
--17- Vea si la regla "RG_patente_patron" está asociada a algún campo de "vehiculos".
EXEC sp_helpconstraint vehiculo

--No lo está.

--18- Verifique que la regla aún existe en la base de datos activa:
 exec sp_help;
--aparece la regla.

--19- Elimine la regla que no pudo eliminar en el punto 15.
DROP RULE RG_patente_patron
--20- Verifique que la regla ya no existe en la base de datos activa.
 exec sp_help;
--No aparece la regla "RG_patente_patron".

EXEC sp_help RG_vehiculos_tipo2 --para ver una regla en especifico
--Para ver el texto de una regla empleamos el procedimiento almacenado "sp_helptext" seguido del nombre de la regla: exec sp_helptext NOMBREREGLA;
EXEC sp_helptext RG_vehiculos_tipo2; 
--Si queremos ver todas las reglas creadas por nosotros, podemos tipear: select * from sysobjects where xtype='R' and-- tipo regla name like 'RG%';--búsqueda con comodín
select * from sysobjects where xtype='R' and name like 'RG%'--'%vehiculos%';

