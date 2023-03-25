USE Practica;
GO

if object_id('Articulos') is not null
  drop table Articulos;

 create table Articulos(
  codigo int identity,
  descripcion varchar(30),
  precio decimal(5,2) not null,
  cantidad smallint not null default 0,
  montototal as precio *cantidad
 );
--El campo "montototal" es un campo calculado que multiplica el precio de cada artículo por la 
--cantidad disponible.
GO
--2- Intente ingresar un registro con valor para el campo calculado:
 insert into Articulos values('birome',1.5,100,150);
--No lo permite.
GO
--3- Ingrese algunos registros:
 insert into Articulos values('birome',1.5,100);
 insert into Articulos values('cuaderno 12 hojas',4.8,150);
 insert into Articulos values('lapices x 12',5,200);
 GO
--4- Recupere los registros:
 select * from Articulos;
 GO
--5- Actualice un precio y recupere los registros:
 update Articulos set precio=2 where descripcion='birome';
 select * from Articulos;
--el campo calculado "montototal" recalcula los valores para cada registro automáticamente.
GO
--6- Actualice una cantidad y vea el resultado:
 update Articulos set cantidad=200 where descripcion='birome';
 select * from Articulos;
--el campo calculado "montototal" recalcula sus valores.
GO
--7- Intente actualizar un campo calculado:
 update Articulos set montototal=300 where descripcion='birome';
--No lo permite.
GO