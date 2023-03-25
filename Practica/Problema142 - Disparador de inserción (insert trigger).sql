USE Practica;
GO

 if object_id('Empleados') is not null
  drop table Empleados;
 if object_id('Secciones') is not null
  drop table Secciones;
GO
 create table Secciones(
  codigo int identity,
  nombre varchar(30),
  sueldomaximo decimal(8,2), 
  constraint PK_Secciones primary key(codigo)
 );

 create table Empleados(
  documento char(8) not null,
  nombre varchar(30) not null,
  domicilio varchar(30),
  codigoseccion int not null,
  sueldo decimal(8,2),
  constraint PK_Empleados primary key(documento),
  constraint FK_empelados_seccion
   foreign key (codigoseccion) references Secciones(codigo)
 );
 GO
 insert into Secciones values('Administracion',1500);
 insert into Secciones values('Sistemas',2000);
 insert into Secciones values('Secretaria',1000);

 insert into Empleados values('22222222','Ana Acosta','Avellaneda 88',1,1100);
 insert into Empleados values('23333333','Bernardo Bustos','Bulnes 345',1,1200);
 insert into Empleados values('24444444','Carlos Caseres','Colon 674',2,1800);
 insert into Empleados values('25555555','Diana Duarte','Colon 873',3,1000);
GO
--4- Cree un disparador para que se ejecute cada vez que una instrucción "insert" ingrese datos en 
--"Empleados"; el mismo debe verificar que el sueldo del empleado no sea mayor al sueldo máximo 
--establecido para la sección, si lo es, debe mostrar un mensaje indicando tal situación y deshacer la 
--transacción.
create trigger dis_Empleados_insertar
on Empleados
for insert
as
declare @maximo decimal(8,2)
set @maximo=(select sueldomaximo from Secciones
            join inserted
            on inserted.codigoseccion=Secciones.codigo)
if (@maximo<(select sueldo from inserted))
begin
declare @mensaje varchar(40)
set @mensaje='El sueldo debe ser menor a '+cast(@maximo as char(8))
raiserror(@mensaje, 16, 1)
rollback transaction
end;
GO
--5- Ingrese un nuevo registro en "Empleados" cuyo sueldo sea menor o igual al establecido para la 
--sección.
insert into Empleados values('26666666','Federico Fuentes','Francia 938',2,1000);
GO
--6- Verifique que el disparador se ejecutó consultando la tabla "Empleados":
 select *from Empleados;
 GO
--7- Intente ingresar un nuevo registro en "Empleados" cuyo sueldo sea mayor al establecido para la 
--sección.
insert into Empleados values('27777777','Gaston Garcia','Guemes 366',3,1200)
--El disparador se ejecutó mostrando un mensaje y la transacción se deshizo.
GO
--8- Verifique que el registro no se agregó en "Empleados":
 select *from Empleados;
GO
--9- Intente ingresar un empleado con código de sección inexistente.
 insert into Empleados values('27777777','Gaston Garcia','Guemes 366',9,1200);
--Aparece un mensaje de error porque se viola la restricción "foreign key"; el trigger no llegó a 
--ejecutarse.
GO