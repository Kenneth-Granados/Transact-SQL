USE Practica;
GO

if object_id('Alumnos') is not null
  drop table Alumnos;

 create table Alumnos(
  documento char(8),
  nombre varchar(40),
  nota decimal(4,2),
  primary key(documento)
 );
 GO
 insert into Alumnos values ('22222222','Pedro Lopez',5);
 insert into Alumnos values ('23333333','Ana Lopez',4);
 insert into Alumnos values ('24444444','Maria Juarez',8);
 insert into Alumnos values ('25555555','Juan Garcia',5.6);
 insert into Alumnos values ('26666666','Karina Torres',2);
 insert into Alumnos values ('27777777','Nora Torres',7.5);
 insert into Alumnos values ('28888888','Mariano Herrero',3.5);
GO

 if object_id('Aprobados') is not null
  drop table Aprobados;

 create table Aprobados(
  documento char(8),
  nombre varchar(40),
  nota decimal(4,2)
 );
GO
 if object_id('Desaprobados') is not null
  drop table Desaprobados;

 create table Desaprobados(
  documento char(8),
  nombre varchar(40)
 );
GO
--5- Elimine el procedimiento llamado "pa_aprobados", si existe:
 if object_id('pa_aprobados') is not null
  drop procedure pa_aprobados;
GO
--6- Cree el procedimiento para que seleccione todos los datos de los Alumnos cuya nota es igual o 
--superior a 4.
 create proc pa_aprobados
  as
  select *
   from Alumnos
   where nota>=4;
GO
--7- Ingrese en la tabla "Aprobados" el resultado devuelto por el procedimiento almacenado "pa_aprobados".
insert into Aprobados exec pa_aprobados;
GO
--8- Vea el contenido de "Aprobados":
 select *from Aprobados;
 GO
--9- Elimine el procedimiento llamado "pa_Desaprobados", si existe:
 if object_id('pa_Desaprobados') is not null
  drop procedure pa_Desaprobados;
GO
--10- Cree el procedimiento para que seleccione el documento y nombre de los Alumnos cuya nota es 
--menor a 4.
create proc pa_Desaprobados
as
select documento,nombre
from Alumnos
where nota<4;
GO
--11- Ingrese en la tabla "Desaprobados" el resultado devuelto por el procedimiento almacenado 
--"pa_Desaprobados".
 insert into Desaprobados exec pa_Desaprobados;
GO
--12- Vea el contenido de "Desaprobados":
 select *from Desaprobados;
 GO
