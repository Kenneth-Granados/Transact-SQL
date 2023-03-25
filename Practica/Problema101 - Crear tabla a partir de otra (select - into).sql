USE Practica;
GO

if object_id('Empleados')is not null
  drop table Empleados;
 if object_id('Sucursales')is not null
  drop table Sucursales;
GO
--2- Cree la tabla "Sucursales":
 create table Sucursales( 
  codigo int identity,
  ciudad varchar(30) not null,
  primary key(codigo)
 ); 

--3- Cree la tabla "Empleados":
 create table Empleados( 
  documento char(8) not null,
  nombre varchar(30) not null,
  domicilio varchar(30),
  seccion varchar(20),
  sueldo decimal(6,2),
  codigosucursal int,
  primary key(documento),
  constraint FK_Empleados_sucursal
   foreign key (codigosucursal)
   references Sucursales(codigo)
   on update cascade
 ); 
GO
--4- Ingrese algunos registros para ambas tablas:
 insert into Sucursales values('Cordoba');
 insert into Sucursales values('Villa Maria');
 insert into Sucursales values('Carlos Paz');
 insert into Sucursales values('Cruz del Eje');

 insert into Empleados values('22222222','Ana Acosta','Avellaneda 111','Secretaria',500,1);
 insert into Empleados values('23333333','Carlos Caseros','Colon 222','Sistemas',800,1);
 insert into Empleados values('24444444','Diana Dominguez','Dinamarca 333','Secretaria',550,2);
 insert into Empleados values('25555555','Fabiola Fuentes','Francia 444','Sistemas',750,2);
 insert into Empleados values('26666666','Gabriela Gonzalez','Guemes 555','Secretaria',580,3);
 insert into Empleados values('27777777','Juan Juarez','Jujuy 777','Secretaria',500,4);
 insert into Empleados values('28888888','Luis Lopez','Lules 888','Sistemas',780,4);
 insert into Empleados values('29999999','Maria Morales','Marina 999','Contaduria',670,4);
 GO
--5- Realice un join para mostrar todos los datos de "Empleados" incluyendo la ciudad de la sucursal:
 select documento,nombre,domicilio,seccion,sueldo,ciudad
  from Empleados
  join Sucursales on codigosucursal=codigo;
GO
--6-Cree una tabla llamada "secciones" que contenga las secciones de la empresa (primero elimínela, si 
--existe):
 if object_id('Secciones') is not null
  drop table Secciones;
GO
 select distinct seccion as nombre
  into Secciones
  from Empleados;
GO
--7- Recupere la información de "secciones":
 select *from Secciones;
--3 registros.
GO
--8- Se necesita una nueva tabla llamada "sueldosxseccion" que contenga la suma de los sueldos de los 
--Empleados por sección. Primero elimine la tabla, si existe:
 if object_id('SueldosxSeccion') is not null
  drop table SueldosxSeccion;
GO
 select seccion, sum(sueldo) as total
  into SueldosxSeccion
  from Empleados
  group by seccion;
GO
--9- Recupere los registros de la nueva tabla:
 select *from sueldosxseccion;
GO
--10- Se necesita una tabla llamada "maximossueldos" que contenga los mismos campos que "Empleados" y 
--guarde los 3 Empleados con sueldos más altos. Primero eliminamos, si existe, la tabla 
--"maximossueldos":
 if object_id('MaximosSueldos') is not null
  drop table MaximosSueldos;
GO
  select top 3 *
  into MaximosSueldos
  from Empleados
  order by sueldo;
GO
--11- Vea los registros de la nueva tabla:
 select *from MaximosSueldos;
 GO
--12- Se necesita una nueva tabla llamada "sucursalCordoba" que contenga los nombres y sección de los 
--Empleados de la ciudad de Córdoba. En primer lugar, eliminamos la tabla, si existe. Luego, consulte 
--las tablas "Empleados" y "Sucursales" y guarde el resultado en la nueva tabla:
 if object_id('SucursalCordoba') is not null
  drop table SucursalCordoba;
GO
 select nombre,ciudad
  into SucursalCordoba
  from Empleados
  join Sucursales
  on codigosucursal=codigo
  where ciudad='Cordoba';
GO
--13- Consulte la nueva tabla:
 select *from sucursalCordoba;
 GO