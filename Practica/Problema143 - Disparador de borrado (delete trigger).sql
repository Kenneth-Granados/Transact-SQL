USE Practica;
GO

if object_id('Articulos') is not null
  drop table Articulos;
GO
 create table Articulos(
  codigo int identity,
  tipo varchar(30),
  descripcion varchar(40),
  precio decimal(8,2),
  stock int,
  constraint PK_Articulos primary key (codigo)
 );
 GO
 insert into Articulos values ('impresora','Epson Stylus C45',400,100);
 insert into Articulos values ('impresora','Epson Stylus C85',500,200);
 insert into Articulos values ('impresora','Epson Stylus Color 600',400,0);
 insert into Articulos values ('monitor','Samsung 14',900,0);
 insert into Articulos values ('monitor','Samsung 17',1200,0);
 insert into Articulos values ('monitor','xxx 15',1500,0);
 insert into Articulos values ('monitor','xxx 17',1600,0);
 insert into Articulos values ('monitor','zzz 15',1300,0);
GO
--4- Cree un disparador para controlar que no se elimine un artículo si hay stock. El disparador se 
--activará cada vez que se ejecuta un "delete" sobre "Articulos", controlando el stock, si se está 
--eliminando un artículo cuyo stock sea mayor a 0, el disparador debe retornar un mensaje de error y 
--deshacer la transacción.
create trigger DIS_Articulos_borrar
on Articulos
for delete
as 
if exists(select *from deleted where stock>0)--si algun registro borrado tiene stock
begin
raiserror('No puede eliminar artículos que tienen stock',16,1)
rollback transaction
end
else
begin
    declare @cantidad int
    select @cantidad=count(*) from deleted
    select 'Se eliminaron ' +rtrim(cast(@cantidad as char(10)))+ ' registros'
end;
GO
--5- Solicite la eliminación de un articulo que no tenga stock.
--Se activa el disparador y permite la transacción.
 delete from Articulos where codigo=4;
GO
--6- Intente eliminar un artículo para el cual haya stock.
--El trigger se dispara y deshace la transacción. Puede verificar que el artículo no fue eliminado 
--consultando la tabla "Articulos".
 delete from Articulos where codigo=2;
GO
--7- Solicite la eliminación de varios artículos que no tengan stock.
--Se activa el disparador y permite la transacción. Puede verificar que se borraron 2 artículos 
--consultando la tabla "Articulos".
delete from Articulos where descripcion like '%xx%';
GO
--8- Intente eliminar varios artículos, algunos con stock y otros sin stock.
--El trigger se dispara y deshace la transacción, es decir, ningún artículo fue eliminado, tampoco los 
--que tienen stock igual a 0.
 delete from Articulos where codigo<=3;
GO
--9- Cree un trigger para evitar que se elimine más de 1 artículo.
--Note que hay 2 disparadores para el mismo suceso (delete) sobre la misma tabla.
create trigger DIS_Articulos_borrar2
  on Articulos
  for delete
  as
   declare @cantidad int
   select @cantidad=count(*) from deleted
   if @cantidad>1
   begin
    raiserror('No puede eliminar más de 1 artículo',16,1)
    rollback transaction
   end;
GO
--10- Solicite la eliminación de 1 artículo para el cual no haya stock.
--Ambos disparadores "DIS_Articulos_borrar" y "DIS_Articulos_borrar2" se activan y permiten la 
--transacción.
 delete from Articulos where codigo=3;
GO
--11- Solicite la eliminación de 1 artículo que tenga stock.
--El disparadores "DIS_Articulos_borrar" se activa y no permite la transacción. El disparador 
--"DIS_Articulos_borrar2" no llega a activarse.
delete from Articulos where codigo=2;
GO
--12- Solicite la eliminación de 2 artículos para los cuales no haya stock.
--El disparador "DIS_Articulos_borrar" se activa y permite la transacción pero el disparador 
--"DIS_Articulos_borrar2" no permite la transacción.
 delete from Articulos where tipo='monitor';
GO
--13- Solicite la eliminación de 2 artículos para los que haya stock.
--El disparador "DIS_Articulos_borrar" se activa y no permite la transacción. El disparador 
--"DIS_Articulos_borrar2" no llega a activarse.
 delete from Articulos where tipo='impresora';
GO