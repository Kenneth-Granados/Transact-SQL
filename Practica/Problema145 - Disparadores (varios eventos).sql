USE Practica;
GO

if object_id('Empleados') is not null
  drop table Empleados;
 if object_id('Sucursales') is not null
  drop table Sucursales;
 GO
 create table Sucursales(
  codigo int identity,
  domicilio varchar(30),
  constraint PK_Sucursales primary key (codigo)
 );

 create table Empleados(
  documento char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  sucursal int not null,
  constraint PK_Empleados primary key (documento),
  constraint FK_Empleados_sucursal foreign key(sucursal)
   references Sucursales(codigo)
 );
GO
 insert into Sucursales values ('Colon 123');
 insert into Sucursales values ('Sucre 234');
 insert into Sucursales values ('Rivadavia 345');

 insert into Empleados values ('22222222','Ana Acosta','Avellaneda 1258',1);
 insert into Empleados values ('23333333','Betina Bustos','Bulnes 345',2);
 insert into Empleados values ('24444444','Carlos Caseres','Caseros 948',3);
 insert into Empleados values ('25555555','Fabian Fuentes','Francia 845',1);
 insert into Empleados values ('26666666','Gustavo Garcia','Guemes 587',2);
 insert into Empleados values ('27777777','Maria Morales','Maipu 643',3);
GO
--4- Cree un disparador de inserción, eliminación y actualización que no permita modificaciones en la 
--tabla "Empleados" si tales modificaciones afectan a Empleados de la sucursal de 1.
create trigger dis_Empleados
on Empleados
for insert,update,delete
as
declare @suc int
if (exists (select *from inserted where sucursal=1)) or
    (exists (select *from deleted where sucursal=1))
begin
raiserror('No puede modificar datos de Empleados de la sucursal 1', 16, 1)
rollback transaction
end;
GO
--5- Ingrese un empleado en la sucursal 3.
insert into Empleados values ('30000000','Zulma Zapata','Suiza 258',3);
--El trigger se dispara permitiendo la transacción;
GO
--6- Intente ingresar un empleado en la sucursal 1.
 insert into Empleados values ('31111111','Ricardo Rojas','Rivadavia 256',1);
--El trigger se dispara y deshace la transacción.
GO
--7- Ejecute un "update" sobre "Empleados" que permita la transacción.
 update Empleados set domicilio='Avellaneda 234' where documento='23333333';
GO
--8- Ejecute un "update" sobre "Empleados" que el trigger deshaga.
 update Empleados set domicilio='Avellaneda 234' where documento='22222222';
GO
--9- Elimine un empleado (o varios) que no sean de la sucursal 1.
 delete from Empleados where documento='25555555';
--El trigger se ejecuta y la transacción se realiza.
GO
--10- Intente eliminar un empleado (o varios) de la sucursal 1.
--El trigger deshace la transacción.
 delete from Empleados where documento='30000000';
GO