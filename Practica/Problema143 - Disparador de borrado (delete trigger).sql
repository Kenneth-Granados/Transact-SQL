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
--4- Cree un disparador para controlar que no se elimine un art�culo si hay stock. El disparador se 
--activar� cada vez que se ejecuta un "delete" sobre "Articulos", controlando el stock, si se est� 
--eliminando un art�culo cuyo stock sea mayor a 0, el disparador debe retornar un mensaje de error y 
--deshacer la transacci�n.
create trigger DIS_Articulos_borrar
on Articulos
for delete
as 
if exists(select *from deleted where stock>0)--si algun registro borrado tiene stock
begin
raiserror('No puede eliminar art�culos que tienen stock',16,1)
rollback transaction
end
else
begin
    declare @cantidad int
    select @cantidad=count(*) from deleted
    select 'Se eliminaron ' +rtrim(cast(@cantidad as char(10)))+ ' registros'
end;
GO
--5- Solicite la eliminaci�n de un articulo que no tenga stock.
--Se activa el disparador y permite la transacci�n.
 delete from Articulos where codigo=4;
GO
--6- Intente eliminar un art�culo para el cual haya stock.
--El trigger se dispara y deshace la transacci�n. Puede verificar que el art�culo no fue eliminado 
--consultando la tabla "Articulos".
 delete from Articulos where codigo=2;
GO
--7- Solicite la eliminaci�n de varios art�culos que no tengan stock.
--Se activa el disparador y permite la transacci�n. Puede verificar que se borraron 2 art�culos 
--consultando la tabla "Articulos".
delete from Articulos where descripcion like '%xx%';
GO
--8- Intente eliminar varios art�culos, algunos con stock y otros sin stock.
--El trigger se dispara y deshace la transacci�n, es decir, ning�n art�culo fue eliminado, tampoco los 
--que tienen stock igual a 0.
 delete from Articulos where codigo<=3;
GO
--9- Cree un trigger para evitar que se elimine m�s de 1 art�culo.
--Note que hay 2 disparadores para el mismo suceso (delete) sobre la misma tabla.
create trigger DIS_Articulos_borrar2
  on Articulos
  for delete
  as
   declare @cantidad int
   select @cantidad=count(*) from deleted
   if @cantidad>1
   begin
    raiserror('No puede eliminar m�s de 1 art�culo',16,1)
    rollback transaction
   end;
GO
--10- Solicite la eliminaci�n de 1 art�culo para el cual no haya stock.
--Ambos disparadores "DIS_Articulos_borrar" y "DIS_Articulos_borrar2" se activan y permiten la 
--transacci�n.
 delete from Articulos where codigo=3;
GO
--11- Solicite la eliminaci�n de 1 art�culo que tenga stock.
--El disparadores "DIS_Articulos_borrar" se activa y no permite la transacci�n. El disparador 
--"DIS_Articulos_borrar2" no llega a activarse.
delete from Articulos where codigo=2;
GO
--12- Solicite la eliminaci�n de 2 art�culos para los cuales no haya stock.
--El disparador "DIS_Articulos_borrar" se activa y permite la transacci�n pero el disparador 
--"DIS_Articulos_borrar2" no permite la transacci�n.
 delete from Articulos where tipo='monitor';
GO
--13- Solicite la eliminaci�n de 2 art�culos para los que haya stock.
--El disparador "DIS_Articulos_borrar" se activa y no permite la transacci�n. El disparador 
--"DIS_Articulos_borrar2" no llega a activarse.
 delete from Articulos where tipo='impresora';
GO