USE Practica;
GO

if object_id('Empleados') is not null
  drop table Empleados;

 create table Empleados(
  documento char(8) not null,
  nombre varchar(10),
  domicilio varchar(30),
  ciudad varchar(20) default 'Buenos Aires'
 );
 GO
--2- Agregue el campo "legajo" de tipo int identity y una restricción "primary key":
 alter table Empleados
  add legajo int identity
  constraint PK_Empleados_legajo primary key;
  GO
--3- Vea si la estructura cambió y si se agregó la restricción:
 --sp_columns Empleados;
 exec sp_helpconstraint Empleados;
 GO
--4- Agregue el campo "hijos" de tipo tinyint y en la misma sentencia una restricción "check" que no 
--permita valores superiores a 30:
 alter table Empleados
  add hijos tinyint
  constraint CK_Empleados_hijos check (hijos<=30);
GO
--5- Ingrese algunos registros:
 insert into Empleados values('22222222','Juan Lopez','Colon 123','Cordoba',2);
 insert into Empleados values('23333333','Ana Garcia','Sucre 435','Cordoba',3);
 GO
--6- Intente agregar el campo "sueldo" de tipo decimal(6,2) no nulo y una restricción "check" que no 
--permita valores negativos para dicho campo:
 alter table Empleados
  add sueldo decimal(6,2) not null
  constraint CK_Empleados_sueldo check (sueldo>=0);
--No lo permite porque no damos un valor por defecto para dicho campo no nulo y los registros 
--existentes necesitan cargar un valor.
GO
--7- Agregue el campo "sueldo" de tipo decimal(6,2) no nulo, una restricción "check" que no permita 
--valores negativos para dicho campo y una restricción "default" que almacene el valor "0":
 alter table Empleados
  add sueldo decimal(6,2) not null
  constraint CK_Empleados_sueldo check (sueldo>=0)
  constraint DF_Empleados_sueldo default 0;
  GO
--8- Recupere los registros:
 select * from Empleados;

--9- Vea la nueva estructura de la tabla:
 exec sp_columns Empleados;

--10- Vea las restricciones:
 exec sp_helpconstraint Empleados;
 GO
