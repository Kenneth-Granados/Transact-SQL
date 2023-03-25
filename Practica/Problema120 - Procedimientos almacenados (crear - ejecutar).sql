USE Practica;
GO

 if object_id('Empleados') is not null
  drop table Empleados;

 create table Empleados(
  documento char(8),
  nombre varchar(20),
  apellido varchar(20),
  sueldo decimal(6,2),
  cantidadhijos tinyint,
  seccion varchar(20),
  primary key(documento)
 );
GO

 insert into Empleados values('22222222','Juan','Perez',300,2,'Contaduria');
 insert into Empleados values('22333333','Luis','Lopez',300,0,'Contaduria');
 insert into Empleados values ('22444444','Marta','Perez',500,1,'Sistemas');
 insert into Empleados values('22555555','Susana','Garcia',400,2,'Secretaria');
 insert into Empleados values('22666666','Jose Maria','Morales',400,3,'Secretaria');
GO
--3- Elimine el procedimiento llamado "pa_Empleados_sueldo" si existe:
 if object_id('pa_Empleados_sueldo') is not null
  drop procedure pa_Empleados_sueldo;
GO
--4- Cree un procedimiento almacenado llamado "pa_Empleados_sueldo" que seleccione los nombres, 
--apellidos y sueldos de los Empleados.
create procedure pa_Empleados_sueldo
as
select nombre,apellido,sueldo
from Empleados;
GO
--5- Ejecute el procedimiento creado anteriormente.
exec pa_Empleados_sueldo;
GO
--6- Elimine el procedimiento llamado "pa_Empleados_hijos" si existe:
 if object_id('pa_Empleados_hijos') is not null
  drop procedure pa_Empleados_hijos;
GO
--7- Cree un procedimiento almacenado llamado "pa_Empleados_hijos" que seleccione los nombres, 
--apellidos y cantidad de hijos de los Empleados con hijos.
 create procedure pa_Empleados_hijos
as
select nombre,apellido,cantidadhijos
from Empleados
where cantidadhijos>0;
GO
--8- Ejecute el procedimiento creado anteriormente.
exec pa_Empleados_hijos;
GO
--9- Actualice la cantidad de hijos de algún empleado sin hijos y vuelva a ejecutar el procedimiento 
--para verificar que ahora si aparece en la lista.
update Empleados set cantidadhijos=1 where documento='22333333';
exec pa_Empleados_hijos;
GO