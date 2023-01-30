USE Practica;

if object_id('empleados') is not null
  drop table empleados;

 create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  seccion varchar(20)
 );
GO

 insert into empleados
  values ('22222222','Alberto Lopez','Sistemas');
 insert into empleados
  values ('23333333','Beatriz Garcia','Administracion');
 insert into empleados
  values ('23333333','Carlos Fuentes','Administracion');

--4- Intente establecer una restricción "primary key" para la tabla para que el documento no se repita 
--ni admita valores nulos:
 alter table empleados
 add constraint PK_empleados_documento
 primary key(documento);
--No lo permite porque la tabla contiene datos que no cumplen con la restricción, debemos eliminar (o 
--modificar) el registro que tiene documento duplicado:
 delete from empleados
  where nombre='Carlos Fuentes';

--5- Establezca la restricción "primary key" del punto 4.
alter table empleados
 add constraint PK_empleados_documento
 primary key(documento);
--6- Intente actualizar un documento para que se repita.
--No lo permite porque va contra la restricción.
update empleados set documento='22222222'
  where documento='23333333';
--7-Intente establecer otra restricción "primary key" con el campo "nombre".
--No lo permite, sólo puede haber una restricción "primary key" por tabla.
alter table empleados
 add constraint PK_empleados_nombre
 primary key(nombre);
--8- Intente ingresar un registro con valor nulo para el documento.
--No lo permite porque la restricción no admite valores nulos.
 insert into empleados values(null,'Marcelo Juarez','Sistemas');
--9- Establezca una restricción "default" para que almacene "00000000" en el documento en caso de 
--omitirlo en un "insert".
alter table empleados
  add constraint DF_empleados_documento
  default '00000000'
  for documento;
--10- Ingrese un registro sin valor para el documento.
 insert into empleados (nombre,seccion) values('Luis Luque','Sistemas'); 
--11- Vea el registro:
 select * from empleados;

--12- Intente ingresar otro empleado sin documento explícito.
--No lo permite porque se duplicaría la clave.
insert into empleados (nombre,seccion) values('Ana Fuentes','Sistemas');
--13- Vea las restricciones de la tabla empleados (2 filas):
 exec sp_helpconstraint empleados;

